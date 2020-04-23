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
 get-azureSoftwareLicenses | where remaining -LT 5 | select skupartnumber,ActiveUnits,consumedunits,remaining
 Returns those items with less than 5 spare licenses
 
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

    #map sku to a friendly name to display
    # Mostly from https://docs.microsoft.com/en-us/azure/active-directory/users-groups-roles/licensing-service-plan-reference
    switch ($part.SkuPartNumber) {
        AAD_BASIC { $obj.Name = 'Azure Active Directory Basic'}
        AAD_PREMIUM { $obj.Name = 'Azure Active Directory Premium P1'}
        AAD_PREMIUM_P2 { $obj.Name = 'Azure Active Directory Premium P2'}
        ATP_ENTERPRISE { $obj.Name = 'Office 365 Advanced Threat Protection (Plan 1)'}
        CRMPLAN2 { $obj.Name = 'Microsoft Dynamics Crm Online Basic'}
        CRMSTANDARD { $obj.Name = 'Microsoft Dynamics Crm Online'}
        DESKLESSPACK { $obj.Name = 'Office 365 F1'}
        DEVELOPERPACK { $obj.Name = 'Office 365 E3 Developer'}
        DYN365_ENTERPRISE_CUSTOMER_SERVICE { $obj.Name = 'Dynamics 365 For Customer Service Enterprise Edition'}
        DYN365_ENTERPRISE_PLAN1 { $obj.Name = 'Dynamics 365 Customer Engagement Plan Enterprise Edition'}
        DYN365_ENTERPRISE_SALES { $obj.Name = 'Dynamics 365 For Sales Enterprise Edition'}
        DYN365_ENTERPRISE_SALES_CUSTOMERSERVICE { $obj.Name = 'Dynamics 365 For Sales And Customer Service Enterprise Edition'}
        DYN365_ENTERPRISE_TEAM_MEMBERS { $obj.Name = 'Dynamics 365 For Team Members Enterprise Edition'}
        DYN365_FINANCIALS_BUSINESS_SKU { $obj.Name = 'Dynamics 365 For Financials Business Edition'}
        Dynamics_365_for_Operations { $obj.Name = 'Dynamics 365 Unf Ops Plan Ent Edition'}
        EMS { $obj.Name = 'Enterprise Mobility + Security E3'}
        EMSPREMIUM { $obj.Name = 'Enterprise Mobility + Security E5'}
        ENTERPRISEPACK { $obj.Name = "Office 365 E3"}
        ENTERPRISEPACK { $obj.Name = 'Office 365 E3'}
        ENTERPRISEPACK_USGOV_DOD { $obj.Name = 'Office 365 E3_Usgov_Dod'}
        ENTERPRISEPACK_USGOV_GCCHIGH { $obj.Name = 'Office 365 E3_Usgov_Gcchigh'}
        ENTERPRISEPREMIUM { $obj.Name = "Office 365 E5"}
        ENTERPRISEPREMIUM { $obj.Name = 'Office 365 E5'}
        ENTERPRISEPREMIUM_FACULTY { $obj.Name = 'Office 365 A5 For Faculty'}
        ENTERPRISEPREMIUM_NOPSTNCONF { $obj.Name = 'Office 365 E5 Without Audio Conferencing'}
        ENTERPRISEPREMIUM_STUDENT { $obj.Name = 'Office 365 A5 For Students'}
        ENTERPRISEWITHSCAL { $obj.Name = 'Office 365 E4'}
        EOP_ENTERPRISE_PREMIUM { $obj.Name = "Exchange Enterprise CAL Services (EOP, DLP)"}
        EQUIVIO_ANALYTICS { $obj.Name = 'Office 365 Advanced Compliance'}
        EXCHANGE_S_ESSENTIALS { $obj.Name = 'Exchange Online Essentials'}
        EXCHANGEARCHIVE { $obj.Name = 'Exchange Online Archiving For Exchange Server'}
        EXCHANGEARCHIVE_ADDON { $obj.Name = 'Exchange Online Archiving For Exchange Online'}
        EXCHANGEDESKLESS { $obj.Name = 'Exchange Online Kiosk'}
        EXCHANGEENTERPRISE { $obj.Name = 'Exchange Online (Plan 2)'}
        EXCHANGEESSENTIALS { $obj.Name = 'Exchange Online Essentials'}
        EXCHANGESTANDARD { $obj.Name = 'Exchange Online (Plan 1)'}
        EXCHANGETELCO { $obj.Name = 'Exchange Online Pop'}
        FLOW_FREE { $obj.Name = "Microsoft Power Automate Free"}
        IDENTITY_THREAT_PROTECTION { $obj.Name = 'Microsoft 365 E5 Security'}
        IDENTITY_THREAT_PROTECTION_FOR_EMS_E5 { $obj.Name = 'Microsoft 365 E5 Security For Ems E5'}
        INFORMATION_PROTECTION_COMPLIANCE { $obj.Name = 'Microsoft 365 E5 Compliance'}
        INTUNE_A { $obj.Name = 'Intune'}
        IT_ACADEMY_AD { $obj.Name = 'Ms Imagine Academy'}
        LITEPACK { $obj.Name = 'Office 365 Small Business'}
        LITEPACK_P2 { $obj.Name = 'Office 365 Small Business Premium'}
        M365EDU_A1 { $obj.Name = 'Microsoft 365 A1'}
        M365EDU_A3_FACULTY { $obj.Name = 'Microsoft 365 A3 For Faculty'}
        M365EDU_A3_STUDENT { $obj.Name = 'Microsoft 365 A3 For Students'}
        M365EDU_A5_FACULTY { $obj.Name = 'Microsoft 365 A5 For Faculty'}
        M365EDU_A5_STUDENT { $obj.Name = 'Microsoft 365 A5 For Students'}
        MCOEV { $obj.Name = 'Skype For Business Cloud Pbx'}
        MCOIMP { $obj.Name = 'Skype For Business Online (Plan 1)'}
        MCOMEETADV { $obj.Name = 'Audio Conferencing'}
        MCOPSTN1 { $obj.Name = 'Skype For Business Pstn Domestic Calling'}
        MCOPSTN2 { $obj.Name = 'Skype For Business Pstn Domestic And International Calling'}
        MCOPSTN5 { $obj.Name = 'Skype For Business Pstn Domestic Calling (120 Minutes)'}
        MCOSTANDARD { $obj.Name = 'Skype For Business Online (Plan 2)'}
        MIDSIZEPACK { $obj.Name = 'Office 365 Midsize Business'}
        O365_BUSINESS { $obj.Name = 'Office 365 Business'}
        O365_BUSINESS_ESSENTIALS { $obj.Name = 'Office 365 Business Essentials'}
        O365_BUSINESS_PREMIUM { $obj.Name = 'Office 365 Business Premium'}
        OFFICESUBSCRIPTION { $obj.Name = 'Office 365 Proplus'}
        POWER_BI_ADDON { $obj.Name = 'Power Bi For Office 365 Add-On'}
        POWER_BI_PRO { $obj.Name = 'Power Bi Pro'}
        POWER_BI_STANDARD{ $obj.Name = "Power BI (free)"}
        POWERAPPS_INDIVIDUAL_USER { $obj.Name = "PowerApps and Logic Flows"}
        POWERAPPS_PER_USER { $obj.Name = 'Power Apps Per User Plan'}
        POWERAPPS_VIRAL{ $obj.Name = "Microsoft Power Apps Plan 2 Trial"}
        POWERFLOW_P2  { $obj.Name = "Microsoft Power Apps Plan 2"}
        PROJECTCLIENT { $obj.Name = 'Project For Office 365'}
        PROJECTESSENTIALS { $obj.Name = 'Project Online Essentials'}
        PROJECTONLINE_PLAN_1 { $obj.Name = 'Project Online Premium Without Project Client'}
        PROJECTONLINE_PLAN_2 { $obj.Name = 'Project Online With Project For Office 365'}
        PROJECTPREMIUM { $obj.Name = 'Project Online Premium'}
        PROJECTPROFESSIONAL { $obj.Name = 'Project Online Professional'}
        RIGHTSMANAGEMENT { $obj.Name = 'Azure Information Protection Plan 1'}
        RIGHTSMANAGEMENT_ADHOC { $obj.Name = 'Windows Azure Rights Management'}            
        SHAREPOINTENTERPRISE { $obj.Name = 'Sharepoint Online (Plan 2)'}
        SHAREPOINTSTANDARD { $obj.Name = 'Sharepoint Online (Plan 1)'}
        SMB_BUSINESS { $obj.Name = 'Office 365 Business'}
        SMB_BUSINESS_ESSENTIALS { $obj.Name = 'Office 365 Business Essentials'}
        SMB_BUSINESS_PREMIUM { $obj.Name = 'Office 365 Business Premium'}
        SPB { $obj.Name = 'Microsoft 365 Business'}
        SPE_E3 { $obj.Name = 'Microsoft 365 E3'}
        SPE_E3_USGOV_DOD { $obj.Name = 'Microsoft 365 E3_Usgov_Dod'}
        SPE_E3_USGOV_GCCHIGH { $obj.Name = 'Microsoft 365 E3_Usgov_Gcchigh'}
        SPE_E5 { $obj.Name = 'Microsoft 365 E5'}
        SPE_F1 { $obj.Name = 'Microsoft 365 F1'}
        STANDARDPACK { $obj.Name = 'Office 365 E1'}
        STANDARDWOFFPACK { $obj.Name = 'Office 365 E2'}
        STREAM { $obj.Name = "Stream Trial" }
        TEAMS_EXPLORATORY { $obj.Name = "Microsoft Teams Exploratory"}
        TEAMS_COMMERCIAL_TRIAL  { $obj.Name = "Microsoft Teams Commercial Cloud"}
        VISIOCLIENT { $obj.Name = 'Visio Online Plan 2'}
        VISIOONLINE_PLAN1 { $obj.Name = 'Visio Online Plan 1'}
        WACONEDRIVEENTERPRISE { $obj.Name = 'Onedrive For Business (Plan 2)'}
        WACONEDRIVESTANDARD { $obj.Name = 'Onedrive For Business (Plan 1)'}
        WIN_DEF_ATP { $obj.Name = 'Microsoft Defender Advanced Threat Protection'}
        WIN10_PRO_ENT_SUB { $obj.Name = 'Windows 10 Enterprise E3'}
        WIN10_VDA_E5 { $obj.Name = 'Windows 10 Enterprise E5'}

        # and for anything new or missing...
        Default {
            $obj.Name = $part.SkuPartNumber

            } #default
    } #switch
    
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