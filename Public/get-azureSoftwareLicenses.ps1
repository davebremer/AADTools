function get-azureSoftwareLicenses {

<#
.SYNOPSIS
   Returns the license count from Azure.
 

.DESCRIPTION
 Returns the license count from Azure. Really just a wrapper for Get-MsolAccountSku from module msolservice

.EXAMPLE
 azureSoftwareLicenses
 Returns for each Azuer software license: skupartnumber, ActiveUnits,ConsumedUnits,WarningUnits

.EXAMPLE
 get-azureSoftwareLicenses | where remaining -LT 5 | select Name,ActiveUnits,consumedunits,remaining
 Returns those items with less than 5 spare licenses

.EXAMPLE
 get-azureSoftwareLicenses | where name -like "*E[3|5]*" | select name,ActiveUnits,consumedunits,remaining | sort remaining
 Returns the number of licenses for E3 or E5
 
.NOTES
 Author: Dave Bremer
 Date: 2020/4/17
 Revisions:
    

#>
#Requires -Modules "MSOnline"

#Check for a connection

try {
    Write-Verbose "Already connected"
    Get-MsolDomain -ErrorAction Stop > $null
} Catch {
    Write-Output "Connecting to Azure..."
    Connect-MsolService
}

$obj = New-Object PSObject -Property @{
            Name = $null
            SkuPartNumber = $null
            ActiveUnits = $null
            ConsumedUnits = $null
            WarningUnits = $null
            Remaining = $null
            SuspendedUnits = $null
        }

$parts = Get-MsolAccountSku 

foreach ($part in $parts) {
    $obj.Name = (get-skuName $part.SkuPartNumber).Skuname
    $obj.SkuPartNumber = $part.SkuPartNumber
    $obj.ActiveUnits = $part.ActiveUnits
    $obj.ConsumedUnits = $part.ConsumedUnits
    $obj.WarningUnits = $part.WarningUnits
    $obj.SuspendedUnits = $part.SuspendedUnits
    $obj.Remaining = ($Part.ActiveUnits - $Part.ConsumedUnits)

    
    Write-Output $obj | select Name,SkuPartNumber, ActiveUnits, ConsumedUnits, WarningUnits,SuspendedUnits,Remaining
}

#Get-MsolAccountSku | select skupartnumber,ActiveUnits,ConsumedUnits,WarningUnits,@{n="remaining";e={$_.ActiveUnits - $_.ConsumedUnits}}

}