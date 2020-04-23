function get-azureLastSynchTimes {

<#
.SYNOPSIS
   Returns the last directory and password sync times
 

.DESCRIPTION
 Returns the last directory and password sync times. Really just a wrapper for Get-MsolCompanyInformation from module msolservice

.EXAMPLE
 azureSoftwareLicenses
 Returns the latest Directory synch times and the last password synch time


.NOTES
 Author: Dave Bremer
 Date: 2020/4/20
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

Get-MsolCompanyInformation | select @{n="Company";e={$_.DisplayName}},
                                    @{n="LastDirSyncTime";e={('{0:dd/MM/yyyy HH:mm:ss}' -f (get-date -date $_.LastDirSyncTime)) }},
                                    @{n="LastPasswordSyncTime";e={('{0:dd/MM/yyyy HH:mm:ss}' -f (get-date -date $_.LastPasswordSyncTime)) }}

}