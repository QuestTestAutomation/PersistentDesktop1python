*** Settings ***
Library           Selenium2Library
Library           HttpLibrary.HTTP
Resource          Commons.robot
Resource          Locators/Registration_Page_Locators.robot

*** Keywords ***
Open Registration Page
    Open Support Portal Anonimously
    Comment    Page Should Contain Element    ${dsg_home_ToolsTitle_vt_locator}
    Focus    ${at_button_signIn}
    Click Element    ${at_button_signIn}
    Focus    ${at_Create_Support_User_Label}
    Highlight Element    ${at_Create_Support_User_Label}
    Click Element    ${at_Create_Support_User_Label}
    Wait Until Page Contains Element    ${dsg_Registration_WithSupportProduct_PageTitle_locator}
    Location Should Contain    /account/registersupportuser
    Current Page Should Not Contain Errors

Active page should be Create a Support Account With A Trial Product
    Wait Until Page Contains Element    ${dsg_Registration_WithTrialProduct_PageTitle_locator}

Active page should be Confirmation
    Wait Until Page Contains Element    ${dib-verify-email}
    Current Page Should Not Contain Errors

Active page should be Licenses
    Wait Until Page Contains Element    ${dsg_Licensing_Landing_Page_Title_locator}
    Current Page Should Not Contain Errors

Active page should be Welcome
    Wait Until Page Contains Element    ${dsg_Account_WelcomePage_Title_locator}
    Current Page Should Not Contain Errors

Verification Code
    [Arguments]    ${email}    ${verifyCode}
    Wait Until Page Contains Element    ${at_VerifyEmail_username}[@value='${email}']    error=Email address did not appear on the Verify Email page in TIMEOUT.
    Focus    ${at_VerifyEmail_verificationCode}
    JS Set Value To Input    ${at_VerifyEmail_verificationCode}    ${verifyCode}
    Click Button    ${at_VerifyEmail_buttonVerify}

The user on the Welcome page
    Active page should be Welcome
