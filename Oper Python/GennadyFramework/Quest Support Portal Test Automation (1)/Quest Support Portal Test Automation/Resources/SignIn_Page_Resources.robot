*** Settings ***
Library           Selenium2Library
Library           HttpLibrary.HTTP
Resource          Commons.robot
Resource          Locators/SignIn_Page_Locators.robot

*** Keywords ***
Open SignIn Page
    Open Support Portal Anonimously
    Navigate to SignIn Page

SignIn
    [Arguments]    ${account}    ${pass}
    Wait Until Page Contains Element    ${at_SignIn_emailAddress}
    JS Set Value To Input    ${at_SignIn_emailAddress}    ${account}
    JS Set Value To Input    ${at_SignIn_password}    ${pass}
    Comment    Input Text    ${at_SignIn_emailAddress}    ${account}
    Comment    Input Text    ${at_SignIn_password}    ${pass}
    Click Button    ${at_SigIn_buttonSignIn}

Create New Password
    [Arguments]    ${new_pass}    ${old_pass}=${EMPTY}
    Comment    Active page should be Create New Password
    Comment    Run Keyword IF    "${old_pass}"!="${EMPTY}"    Input Text    ${at_CreatePass_tempPass}    ${old_pass}
    Run Keyword IF    "${old_pass}"!="${EMPTY}"    JS Set Value To Input    ${at_CreatePass_tempPass}    ${old_pass}
    JS Set Value To Input    ${at_CreatePass_newPass}    ${new_pass}
    JS Set Value To Input    ${at_CreatePass_confirmPass}    ${new_pass}
    Comment    Input Text    ${at_CreatePass_newPass}    ${new_pass}
    Comment    Input Text    ${at_CreatePass_confirmPass}    ${new_pass}
    sleep    1
    Click Button    ${at_CreatePass_buttonCreatePass}

Reset Password
    [Arguments]    ${new_pass}
    JS Set Value To Input    ${at_ResetPassword_password}    ${new_pass}
    sleep    1
    Click Button    ${at_ResetPassword_button}

Change Password
    [Arguments]    ${new_pass}    ${old_pass}=${EMPTY}
    Run Keyword IF    "${old_pass}"!="${EMPTY}"    JS Set Value To Input    ${at_UpdatePassword_oldPass}    ${old_pass}
    JS Set Value To Input    ${at_UpdatePassword_newPass}    ${new_pass}
    sleep    1
    Click Button    ${at_buttom_UpdatePassword}

Active page should be Create New Password
    Wait Until Page Contains Element    ${at_CreatNewPassword_Title_locator}

Active page should be Reset Password
    Wait Until Page Contains Element    ${at_ResetPassword_Title_locator}

Navigate to SignIn Page
    Comment    Page Should Contain Element    ${dsg_home_ToolsTitle_vt_locator}
    Wait Until Page Contains Element    ${at_button_signIn}
    Focus    ${at_button_signIn}
    Click Element    ${at_button_signIn}
    Click Element    ${at_element_menu_signIn}
    Active page should be Sign In

SignOut
    ${cutXpath_at_button_signIn}=    Replace String    ${at_button_signIn}    "    '
    ${cutXpath_at_button_signIn}=    Replace String    ${cutXpath_at_button_signIn}    xpath=    ${EMPTY}
    ${count}=    Get Matching Xpath Count    ${cutXpath_at_button_signIn}
    Run Keyword IF    ${count}!=0    Scroll To Element    ${at_button_signIn}
    Run Keyword IF    ${count}!=0    Focus    ${at_button_signIn}
    Run Keyword IF    ${count}!=0    Click Element    ${at_button_signIn}
    Wait Until Element Is Visible    ${at_dsg_General_SignOut}
    Highlight Element    ${at_dsg_General_SignOut}
    Focus    ${at_dsg_General_SignOut}
    Click Element    ${at_dsg_General_SignOut}
    Wait Until Page Does Not Contain Element    ${at_dsg_General_SignOut}

Active page should be Sign In
    Wait Until Element Is Visible    ${at_body_SignIn}

The User Sign out
    SignOut

The user navigates to SignIn page and logs in
    [Arguments]    ${account}    ${pass}
    Navigate to SignIn Page
    SignIn    ${account}    ${pass}

The user is logged
    Wait Until Page Contains Element    ${at_SignOutLink}
    Close TermsConditionsModal
    Focus    ${at_SignInButton}
    Click Element    ${at_SignInButton}
    Page Should Contain Element    ${at_dsg_General_SignOut}
    Click Element    ${at_SignInButton}

Mark the 'Remember Me' checkbox
    Wait Until Page Contains Element    ${at_SignIn_rememberMe}
    Highlight Element    ${at_SignIn_rememberMe}
    ${isCheck}    ${temp}=    Item Is Checked    ${at_SignIn_rememberMe}
    Run Keyword IF    "${isCheck}"=="${False}"    Click Element    ${at_SignIn_rememberMe}

Active page should be Edit Password
    Comment    Wait Until Element Is Visible    ${at_CreatNewPassword_Title_locator}
    Wait Until Element Is Visible    ${at_UpdatePassword_Title_locator}

Active page should be Update Password
    Wait Until Element Is Visible    ${at_UpdatePassword_Title_locator}

The user on the 'Edit Password' page
    Active page should be Edit Password

Active page should be Password Changed
    Wait Until Element Is Visible    ${at_PasswordChanged_Title_locator}

Back To Application
    Wait Until Element Is Visible    ${at_BackToApp_locator}
    Highlight Element    ${at_BackToApp_locator}
    Focus    ${at_BackToApp_locator}
    Click Element    ${at_BackToApp_locator}
