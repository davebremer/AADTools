function Get-aaduserMfaMethods {
<#
.SYNOPSIS
   Returns the various MFA methods set up for a user identified by UPN 
 

.DESCRIPTION
  Returns the various MFA methods set up for an O365 user identified by UPN

.PARAMETER UserPrincipalName
 the UserPrincipalName of the accounts being checked

.PARAMETER Details
 Adds details of the user and MFA methods - including user's Title, Office, as well as the items registered for MFA
 MFA phone, MFA Alt Phone, MFA Email

.EXAMPLE
 Get-aaduserMfaMethods alice@company.com, bob@company.com
 Returns the methods used by Alice and Bob

.EXAMPLE
 Get-aaduserMfaMethods alice@company.com -details
 Will add details of the users title, office, mfa phone and alt phone and mfa email

.EXAMPLE
 Get-ADUser -filter "name -like '*Smith*'" | Get-aaduserMfaMethods | where defaultmethod -eq $true
 Gets the default methods of anyone with "Smith" as part of their name
 
.NOTES
 Author: Dave Bremer
 Date: 2020/9/14
 Revisions:
    2020/4/17 added details

 #todo this would be a good one to set in manifest to limit displayed fields from object, and maybe specify order of fields

#>

    [cmdletBinding()]
    Param ([Parameter (
            Mandatory=$True,
            ValueFromPipelineByPropertyName = $TRUE
                )]
            [ValidateNotNullOrEmpty()]
            #[ValidateScript({Get-ADGroup $_})]
            [string[]] $userprincipalname,
            [switch] $Details
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

    #TODO check if detaiols and add fields appropriatly here
    #set up the object
    $prop = @{
               "UserPrincipalName" = $null;
                "DisplayName" = $null;
                "MFAMethod" = $null;
                "DefaultMethod" = $null
             }
     if ($PSBoundParameters.Keys -contains 'Details'){
        $prop.add("Title", $null)
        $prop.add("Office", $null)
        $prop.add("MFAPhoneNumber", $null)
        $prop.add("MFAAlternativePhoneNumber",$null)
        $prop.add("MFAemail", $null)
     }
     $obj = New-Object -TypeName PSObject -Property $prop
     $obj.psobject.typenames.insert(0, 'daveb.AADUserMFANethods')

} #BEGIN

PROCESS {
    foreach ($u in $userprincipalname) {
        
        $theUser = Get-MsolUser -UserPrincipalName $u
        Write-Verbose $theuser.DisplayName

        $obj.UserPrincipalName = $theUser.UserPrincipalName
        $obj.DisplayName = $theUser.DisplayName
        
        if ($PSBoundParameters.Keys -contains 'Details'){          
                $obj.Title=$theUser.Title
                $obj.Office=$theUser.Office
                $obj.MFAPhoneNumber = $theUser.StrongAuthenticationUserDetails.PhoneNumber
                $obj.MFAAlternativePhoneNumber = $theUser.StrongAuthenticationUserDetails.AlternativePhoneNumber
                $obj.MFAemail = $theUser.StrongAuthenticationUserDetails.email
            } # if details

        $methods = ($theUser | select -ExpandProperty StrongAuthenticationmethods)
        if (-not $methods) {
            $obj.MFAMethod = $null
            $obj.DefaultMethod = $null
            Write-Output $obj
        }
        foreach ($method in $methods) {
            $obj.MFAMethod = $method.MethodType
            $obj.DefaultMethod = $method.IsDefault

            

            Write-Output $obj
        } #foreach method
        
    } #foreach user
} #PROCESS

END{}

}