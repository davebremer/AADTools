function Get-AzureUserLicenses {
#Requires -Modules "MSOnline"
<#
.SYNOPSIS
   Returns the licenses assigned to 

.DESCRIPTION
  

.PARAMETER UserPrincipalName
 The UserPrincipalName of the accounts being checked


.EXAMPLE

.LINK
 https://www.itprotoday.com/office-365/office-365-licensing-windows-powershell
 
.NOTES
 Author: Dave Bremer
 Date: 2020/05/14
 Revisions:
    

#>

[cmdletBinding()]
Param ([Parameter (
        Mandatory=$True,
        ValueFromPipelineByPropertyName = $TRUE
            )]
        [ValidateNotNullOrEmpty()]
        [string[]] $userprincipalname
        )


BEGIN {
    #Check for a connection
    try {
        Write-Verbose "Already connected"
        Get-MsolDomain -ErrorAction Stop > $null
    } Catch {
        Write-Output "Connecting to Azure..."
        Connect-MsolService
    }

    $obj = New-Object PSObject -Property @{ 
                    UPN = $null
                    Service = $null
                    ProvisioningStatus = $null
                    
                 }
    $obj.psobject.typenames.insert(0, 'daveb.AzureUserLicenses')

} #BEGIN

PROCESS {

    foreach ($upn in $userprincipalname) {
        $obj.UPN = $upn
        $obj.Service = $null
        $ProvisioningStatus = $null

        $licensedetails = (Get-MsolUser -UserPrincipalName $upn).Licenses
        
        # If there's a license, show the details.
        # Otherwise, the output is blank.
        if ($licensedetails.Count -gt 0){
          foreach ($license in $licensedetails){
            foreach ($plan in $license.servicestatus) {
                
                $obj.Service = (get-skuName $plan.serviceplan.servicename).skuname
                $obj.ProvisioningStatus = $plan.ProvisioningStatus
                
                Write-Output $obj | select upn,Service,ProvisioningStatus
                }
          }
        }
    }
} # PROCESS

END{}
}