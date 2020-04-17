function get-azureSoftwareLicenses {
<#
.SYNOPSIS
   Returns the license count from Azure.
 

.DESCRIPTION
 Returns the license count from Azure. Really just a wrapper for Get-MsolAccountSku from module msolservice

.EXAMPLE
 azueSoftwareLicenses
 Returns for each Azuer software license: skupartnumber, ActiveUnits,ConsumedUnits,WarningUnits
 
.NOTES
 Author: Dave Bremer
 Date: 
 Revisions:
    

#>

#Check for a connection

try {
    Write-Verbose "Already connected"
    Get-MsolDomain -ErrorAction Stop > $null
} Catch {
    Write-Output "Connecting to Azure..."
    Connect-MsolService
}

Get-MsolAccountSku | select skupartnumber,ActiveUnits,ConsumedUnits,WarningUnits
}