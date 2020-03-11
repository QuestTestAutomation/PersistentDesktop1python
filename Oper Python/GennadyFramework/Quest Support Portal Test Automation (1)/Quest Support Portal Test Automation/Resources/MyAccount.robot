*** Settings ***
Resource          Commons.robot
Resource          Locators/SignIn_Page_Locators.robot

*** Keywords ***
Clicks 'MyAccount'
    ${locator}=    Replace String    ${at_SignInButton}    xpath=    ${EMPTY}
    Wait Until Page Contains Element    ${at_SignInButton}
    ${is_open}=    Get Matching Xpath Count    ${locator}[@class='i-small-useraccount flyout-open']
    Focus    ${at_SignInButton}
    Run Keyword IF    ${is_open}==0    Click Element    ${at_SignInButton}
    Wait Until Element Is Visible    ${at_dsg_MyAccount_Label}
    Focus    ${at_dsg_MyAccount_Label}
    Click Element    ${at_dsg_MyAccount_Label}
    Wait Until Page Contains Element    ${dsg_MyAccount_PageTitle_MyProductSupport_locator}

Active page should be My Products
    Wait Until Page Contains Element    ${dsg_MyAccount_PageTitle_MyProductSupport_locator}
    Current Page Should Not Contain Errors

Active page should be Product Support of the product '${product_name}'
    Wait Until Page Contains Element    xpath=//h1[@id="LayoutH1"][text()[contains(.,'${dsg_ProductOverview_PageTitle} - ${product_name}')]]

Modal window should be Register Product Or License
    Wait Until Page Contains Element    ${RegisterProductOrLicenseModal}[@aria-hidden='false']
    Wait Until Page Contains Element    ${dsg_MyAccount_PageTitle_MyProductSupport_locator}

Close modal window Register Product Or License
    Wait Until Page Contains Element    ${button_Close_RegisterProductOrLicenseModal}
    Click Element    ${button_Close_RegisterProductOrLicenseModal}
    Wait Until Page Contains Element    ${RegisterProductOrLicenseModal}[@aria-hidden='true']

Active page should be How to Buy
    Wait Until Page Contains Element    ${HowToBuy_Title_locator}
    Comment    Current Page Should Not Contain Errors

The user on the 'My Assets - Software & Appliances' page
    Active page should be Licenses

The user on the Product Support page of product '${name_product}'
    Active page should be Product Support of the product '${name_product}'

Active page should be My Product Licenses FAQ
    Wait Until Element Is Visible    ${at_LicensesFAQ}
    Location Should Contain    /my-product-licenses-faq
    Current Page Should Not Contain Errors

Active page should be My Groups
    Wait Until Element Is Visible    ${dsg_MyAccount_MyGroup_Title_locator}
    Current Page Should Not Contain Errors

Modal window should be View License Users
    Wait Until Page Contains Element    ${ViewSubscribersModal}[@aria-hidden='false']
    Wait Until Page Contains Element    ${dsg_Licensing_View_License_Users_Title}

Modal window should be Request License User Access
    Wait Until Page Contains Element    ${RequestSubscriptionModal}[@aria-hidden='false']
    Wait Until Page Contains Element    ${dsg_Licensing_Request_License_User_Access_Title}

Modal window should be Manage License Users
    Wait Until Page Contains Element    ${ManageSubscribersModal}[@aria-hidden='false']
    Wait Until Page Contains Element    ${dsg_Licensing_Manage_License_Users_Title}

Modal window should be Add Expansion Unit
    Wait Until Page Contains Element    ${AddExpansionUnitModal}[@aria-hidden='false']
    Wait Until Page Contains Element    ${dsg_Registration_AddExpansionUnit_Title_locator}

Modal window should be Register Product
    Wait Until Page Contains Element    ${RegisterProductOrLicenseModal}[@aria-hidden='false']
    Wait Until Page Contains Element    ${dsg_RegisterUnKnownProductLicense_Modal_Title_locator}

Active page should be View License '${license_number}'
    Wait Until Page Contains Element    ${dsg_Licensing_ViewLicense_Page_Title_locator}
    Wait Until Page Contains Element    xpath=//div[@id='detail-panel-${license_number}']

Active page should be My Group FAQ
    Wait Until Element Is Visible    ${at_GroupFAQ}
    Location Should Contain    /my-group-faq
    Current Page Should Not Contain Errors

Clicks 'MyProfile'
    ${locator}=    Prepare Locator To JS    ${at_SignInButton}
    Wait Until Page Contains Element    ${at_SignInButton}
    ${is_open}=    Get Matching Xpath Count    ${locator}[@class='i-small-useraccount flyout-open']
    Focus    ${at_SignInButton}
    Run Keyword IF    ${is_open}==0    Click Element    ${at_SignInButton}
    Wait Until Element Is Visible    ${at_dsg_MyProfile_Label}
    Focus    ${at_dsg_MyProfile_Label}
    Click Element    ${at_dsg_MyProfile_Label}
    Wait Until Page Contains Element    ${dsg_ManageProfile_Title_locator}

Active page should be My Profile
    Wait Until Page Contains Element    ${dsg_ManageProfile_Title_locator}
    Wait Until Element Is Visible    ${dsg_ManageProfile_Title_locator}
    Current Page Should Not Contain Errors

The user on the 'My Profile' page
    Active page should be My Profile
