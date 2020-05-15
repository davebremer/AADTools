function get-skuName {

<#
.SYNOPSIS
   Translates a Microsoft SKU ID into a common name
 

.DESCRIPTION
 Translates a Microsoft SKU ID into a common name

.EXAMPLE
 get-skuName "VISIOCLIENT"
 Returns the name "Visio Online Plan 2"

.LINK 
 https://docs.microsoft.com/en-us/azure/active-directory/users-groups-roles/licensing-service-plan-reference

.LINK
 https://www.thelazyadministrator.com/2018/03/19/get-friendly-license-name-for-all-users-in-office-365-using-powershell/

.NOTES
 Author: Dave Bremer
 Date: 2020/4/24
 Revisions:
    

#>


Param ([Parameter (Mandatory=$True)]
        [ValidateNotNullOrEmpty()]
        [string] $skuID
        )


$obj = New-Object PSObject -Property @{
            SkuName = $null
            SkuID= $skuID
            LookupFound = $true
        }


switch ($skuID) {
    AAD_BASIC { $obj.SkuName = 'Azure Active Directory Basic'}
    AAD_PREMIUM { $obj.SkuName = 'Azure Active Directory Premium P1'}
    AAD_PREMIUM_P2 { $obj.SkuName = 'Azure Active Directory Premium P2'}
    ATP_ENTERPRISE { $obj.SkuName = 'Office 365 Advanced Threat Protection (Plan 1)'}
    CRMPLAN2 { $obj.SkuName = 'Microsoft Dynamics Crm Online Basic'}
    CRMSTANDARD { $obj.SkuName = 'Microsoft Dynamics Crm Online'}
    DESKLESSPACK { $obj.SkuName = 'Office 365 F1'}
    DEVELOPERPACK { $obj.SkuName = 'Office 365 E3 Developer'}
    DYN365_ENTERPRISE_CUSTOMER_SERVICE { $obj.SkuName = 'Dynamics 365 For Customer Service Enterprise Edition'}
    DYN365_ENTERPRISE_PLAN1 { $obj.SkuName = 'Dynamics 365 Customer Engagement Plan Enterprise Edition'}
    DYN365_ENTERPRISE_SALES { $obj.SkuName = 'Dynamics 365 For Sales Enterprise Edition'}
    DYN365_ENTERPRISE_SALES_CUSTOMERSERVICE { $obj.SkuName = 'Dynamics 365 For Sales And Customer Service Enterprise Edition'}
    DYN365_ENTERPRISE_TEAM_MEMBERS { $obj.SkuName = 'Dynamics 365 For Team Members Enterprise Edition'}
    DYN365_FINANCIALS_BUSINESS_SKU { $obj.SkuName = 'Dynamics 365 For Financials Business Edition'}
    Dynamics_365_for_Operations { $obj.SkuName = 'Dynamics 365 Unf Ops Plan Ent Edition'}
    EMS { $obj.SkuName = 'Enterprise Mobility + Security E3'}
    EMSPREMIUM { $obj.SkuName = 'Enterprise Mobility + Security E5'}
    ENTERPRISEPACK { $obj.SkuName = "Office 365 E3"}
    ENTERPRISEPACK { $obj.SkuName = 'Office 365 E3'}
    ENTERPRISEPACK_USGOV_DOD { $obj.SkuName = 'Office 365 E3_Usgov_Dod'}
    ENTERPRISEPACK_USGOV_GCCHIGH { $obj.SkuName = 'Office 365 E3_Usgov_Gcchigh'}
    ENTERPRISEPREMIUM { $obj.SkuName = "Office 365 E5"}
    ENTERPRISEPREMIUM { $obj.SkuName = 'Office 365 E5'}
    ENTERPRISEPREMIUM_FACULTY { $obj.SkuName = 'Office 365 A5 For Faculty'}
    ENTERPRISEPREMIUM_NOPSTNCONF { $obj.SkuName = 'Office 365 E5 Without Audio Conferencing'}
    ENTERPRISEPREMIUM_STUDENT { $obj.SkuName = 'Office 365 A5 For Students'}
    ENTERPRISEWITHSCAL { $obj.SkuName = 'Office 365 E4'}
    EOP_ENTERPRISE_PREMIUM { $obj.SkuName = "Exchange Enterprise CAL Services (EOP, DLP)"}
    EQUIVIO_ANALYTICS { $obj.SkuName = 'Office 365 Advanced Compliance'}
    EXCHANGE_S_ESSENTIALS { $obj.SkuName = 'Exchange Online Essentials'}
    EXCHANGEARCHIVE { $obj.SkuName = 'Exchange Online Archiving For Exchange Server'}
    EXCHANGEARCHIVE_ADDON { $obj.SkuName = 'Exchange Online Archiving For Exchange Online'}
    EXCHANGEDESKLESS { $obj.SkuName = 'Exchange Online Kiosk'}
    EXCHANGEENTERPRISE { $obj.SkuName = 'Exchange Online (Plan 2)'}
    EXCHANGEESSENTIALS { $obj.SkuName = 'Exchange Online Essentials'}
    EXCHANGESTANDARD { $obj.SkuName = 'Exchange Online (Plan 1)'}
    EXCHANGETELCO { $obj.SkuName = 'Exchange Online Pop'}
    FLOW_FREE { $obj.SkuName = "Microsoft Power Automate Free"}
    IDENTITY_THREAT_PROTECTION { $obj.SkuName = 'Microsoft 365 E5 Security'}
    IDENTITY_THREAT_PROTECTION_FOR_EMS_E5 { $obj.SkuName = 'Microsoft 365 E5 Security For Ems E5'}
    INFORMATION_PROTECTION_COMPLIANCE { $obj.SkuName = 'Microsoft 365 E5 Compliance'}
    INTUNE_A { $obj.SkuName = 'Intune'}
    IT_ACADEMY_AD { $obj.SkuName = 'Ms Imagine Academy'}
    LITEPACK { $obj.SkuName = 'Office 365 Small Business'}
    LITEPACK_P2 { $obj.SkuName = 'Office 365 Small Business Premium'}
    M365EDU_A1 { $obj.SkuName = 'Microsoft 365 A1'}
    M365EDU_A3_FACULTY { $obj.SkuName = 'Microsoft 365 A3 For Faculty'}
    M365EDU_A3_STUDENT { $obj.SkuName = 'Microsoft 365 A3 For Students'}
    M365EDU_A5_FACULTY { $obj.SkuName = 'Microsoft 365 A5 For Faculty'}
    M365EDU_A5_STUDENT { $obj.SkuName = 'Microsoft 365 A5 For Students'}
    MCOCAP { $obj.SkuName = 'Common Area Phone'}
    MCOEV { $obj.SkuName = 'Skype For Business Cloud Pbx'}
    MCOIMP { $obj.SkuName = 'Skype For Business Online (Plan 1)'}
    MCOMEETADV { $obj.SkuName = 'Audio Conferencing'}
    MCOPSTN1 { $obj.SkuName = 'Skype For Business Pstn Domestic Calling'}
    MCOPSTN2 { $obj.SkuName = 'Skype For Business Pstn Domestic And International Calling'}
    MCOPSTN5 { $obj.SkuName = 'Skype For Business Pstn Domestic Calling (120 Minutes)'}
    MCOSTANDARD { $obj.SkuName = 'Skype For Business Online (Plan 2)'}
    MIDSIZEPACK { $obj.SkuName = 'Office 365 Midsize Business'}
    O365_BUSINESS { $obj.SkuName = 'Office 365 Business'}
    O365_BUSINESS_ESSENTIALS { $obj.SkuName = 'Office 365 Business Essentials'}
    O365_BUSINESS_PREMIUM { $obj.SkuName = 'Office 365 Business Premium'}
    OFFICESUBSCRIPTION { $obj.SkuName = 'Office 365 Proplus'}
    POWER_BI_ADDON { $obj.SkuName = 'Power Bi For Office 365 Add-On'}
    POWER_BI_PRO { $obj.SkuName = 'Power Bi Pro'}
    POWER_BI_STANDARD{ $obj.SkuName = "Power BI (free)"}
    POWERAPPS_INDIVIDUAL_USER { $obj.SkuName = "PowerApps and Logic Flows"}
    POWERAPPS_PER_USER { $obj.SkuName = 'Power Apps Per User Plan'}
    POWERAPPS_VIRAL{ $obj.SkuName = "Microsoft Power Apps Plan 2 Trial"}
    POWERFLOW_P2  { $obj.SkuName = "Microsoft Power Apps Plan 2"}
    PROJECTCLIENT { $obj.SkuName = 'Project For Office 365'}
    PROJECTESSENTIALS { $obj.SkuName = 'Project Online Essentials'}
    PROJECTONLINE_PLAN_1 { $obj.SkuName = 'Project Online Premium Without Project Client'}
    PROJECTONLINE_PLAN_2 { $obj.SkuName = 'Project Online With Project For Office 365'}
    PROJECTPREMIUM { $obj.SkuName = 'Project Online Premium'}
    PROJECTPROFESSIONAL { $obj.SkuName = 'Project Online Professional'}
    RIGHTSMANAGEMENT { $obj.SkuName = 'Azure Information Protection Plan 1'}
    RIGHTSMANAGEMENT_ADHOC { $obj.SkuName = 'Windows Azure Rights Management'}            
    SHAREPOINTENTERPRISE { $obj.SkuName = 'Sharepoint Online (Plan 2)'}
    SHAREPOINTSTANDARD { $obj.SkuName = 'Sharepoint Online (Plan 1)'}
    SMB_BUSINESS { $obj.SkuName = 'Office 365 Business'}
    SMB_BUSINESS_ESSENTIALS { $obj.SkuName = 'Office 365 Business Essentials'}
    SMB_BUSINESS_PREMIUM { $obj.SkuName = 'Office 365 Business Premium'}
    SPB { $obj.SkuName = 'Microsoft 365 Business'}
    SPE_E3 { $obj.SkuName = 'Microsoft 365 E3'}
    SPE_E3_USGOV_DOD { $obj.SkuName = 'Microsoft 365 E3_Usgov_Dod'}
    SPE_E3_USGOV_GCCHIGH { $obj.SkuName = 'Microsoft 365 E3_Usgov_Gcchigh'}
    SPE_E5 { $obj.SkuName = 'Microsoft 365 E5'}
    SPE_F1 { $obj.SkuName = 'Microsoft 365 F1'}
    SPZA_IW { $obj.SkuName = 'App Connect'}
    STANDARDPACK { $obj.SkuName = 'Office 365 E1'}
    STANDARDWOFFPACK { $obj.SkuName = 'Office 365 E2'}
    STREAM { $obj.SkuName = "Stream Trial" }
    TEAMS_EXPLORATORY { $obj.SkuName = "Microsoft Teams Exploratory"}
    TEAMS_COMMERCIAL_TRIAL  { $obj.SkuName = "Microsoft Teams Commercial Cloud"}
    VISIOCLIENT { $obj.SkuName = 'Visio Online Plan 2'}
    VISIOONLINE_PLAN1 { $obj.SkuName = 'Visio Online Plan 1'}
    WACONEDRIVEENTERPRISE { $obj.SkuName = 'Onedrive For Business (Plan 2)'}
    WACONEDRIVESTANDARD { $obj.SkuName = 'Onedrive For Business (Plan 1)'}
    WIN_DEF_ATP { $obj.SkuName = 'Microsoft Defender Advanced Threat Protection'}
    WINDOWS_STORE{ $obj.SkuName =  'Windows Store for Business'}
    WIN10_PRO_ENT_SUB { $obj.SkuName = 'Windows 10 Enterprise E3'}
    WIN10_VDA_E5 { $obj.SkuName = 'Windows 10 Enterprise E5'}

    # and for anything new or missing...
    Default {
        $obj.SkuName = $skuID
        $obj.LookupFound = $false
        } #default

    } #switch

Write-Output $obj
}