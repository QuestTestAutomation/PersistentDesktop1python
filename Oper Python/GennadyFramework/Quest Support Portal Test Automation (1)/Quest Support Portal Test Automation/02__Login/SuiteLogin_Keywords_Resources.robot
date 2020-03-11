*** Settings ***
Resource          ../Resources/Commons.robot
Resource          ../Resources/Locators/SignIn_Page_Locators.robot
Resource          ../Resources/SignIn_Page_Resources.robot
Resource          ../01__Registration/SuiteRegistration_Keywords_Resources.robot

*** Variables ***
@{list_account}
&{id_field_local}    Email Address=EmailAddress    First Name=FirstName    Last Name=LastName    Company=Company    Phone Number=PhoneNumber    Address=Address1    Suite/Unit Number=Address2
...               Postal Code=PostalCode    City=City    Country=Country    State=State    AccountId=AccountId    Asset Number=LicenseNumber    Business Email=UserName
...               Confirm Business Email=UserName2    Email=username

*** Keywords ***
A user has support account
    GIVEN An anonymous user on the Registration page
    WHEN The user clicks on the link ‘Register Trial Product’
    THEN The user on the page ‘Create a Support Account With A Trial Product’
    WHEN The user selects the test product in the product selector
    AND fills contact information
    AND clicks the button 'Create Account'
    THEN account has been created
    AND the user receives email with temporary password
    Comment    WHEN the user sign in with temporary password
    Comment    AND Creates new password
    WHEN the user performs verification
    THEN the user on the Welcome page
    Comment    THEN the user is logged
    Comment    The User Sign out
    Close Working Session

Account has been created
    Wait Until Page Contains Element    ${dib-verify-email}

Fills contact information
    Set Test Variable    ${xpath_to_field}    ${at_form_frmRegisterTrialUser}
    ${email}=    Set Variable    ${mailbox['email_addr']}
    Set '${email}' to field 'Email Address'
    Set '${temporary_pass}' to field 'Password'
    Set '${temporary_pass}' to field 'Confirm Password'
    Set 'First Robot' to field 'First Name'
    Set 'Last Robot' to field 'Last Name'
    Set 'Company Robot' to field 'Company'
    Set '1234567890' to field 'Phone Number'
    Set 'Address Company Robot' to field 'Address'
    Comment    Set '10' to field 'Suite/Unit Number'
    Set '11111' to field 'Postal Code'
    Set 'City Robot' to field 'City'
    Select 'United States' in the 'Country' selector
    Select 'Alaska' in the 'State' selector

The user clicks on the link ‘Register Trial Product’
    Comment    Scroll To Element    ${at_link_trial_product}
    Comment    Highlight Element    ${at_link_trial_product}
    Click Element    ${at_link_trial_product}

The user sign in
    Comment    Navigate to SignIn Page
    Open SignIn Page

A user has support account and password of account is '${new_pass}'
    Set Test Variable    ${temporary_pass}    ${new_pass}
    GIVEN An anonymous user on the Registration page
    WHEN The user clicks on the link ‘Register Trial Product’
    THEN The user on the page ‘Create a Support Account With A Trial Product’
    WHEN The user selects the test product in the product selector
    AND fills contact information
    AND clicks the button 'Create Account'
    THEN account has been created
    AND the user receives email with temporary password
    Comment    WHEN the user sign in with temporary password
    WHEN the user navigates to email link "Quest Software Sign In"
    THEN the user on the Welcome page
    Comment    THEN the user on the page Create New Password
    Comment    AND Creates new password '${new_pass}'
    AND the user is logged
    Comment    Comment    AND Creates new password '${new_pass}'
    Comment    Comment    THEN the user is logged
    Comment    The User Sign out
    ${dop_account}=    Create Dictionary    email=${mailbox['email_addr']}    password=${new_pass}
    Append To List    ${list_account}    ${dop_account}
    Close Working Session

Creates new password '${new_pass}'
    Creates new password    ${new_pass}

The user sign in and inputs the ${valid-invalid} password '${pass}'
    The user sign in
    SignIn    ${mailbox['email_addr']}    ${pass}
    Comment    sleep    3

The user tries to enter the ${valid-invalid} password '${pass}' again
    SignIn    ${mailbox['email_addr']}    ${pass}
    Comment    sleep    3

Set Known Email Adress
    [Arguments]    ${known_email_address}
    ${mailbox}=    Create Dictionary    email_addr=${known_email_address}
    Set Test Variable    ${mailbox}

The user receives email with instruction to reset password
    Comment    ${str_re}=    Set Variable IF    "${LOCALE}"=="ja-jp"    仮パスワード: ([^ <\\s\\n\\t]*)    [Pp]assword: ([^<\\s\\n\\t]*)
    Comment    ${link_re}=    Set Variable IF    "${LOCALE}"=="ja-jp" and ${seq_email}>0    <a href[^"]*"(.*)">\\s*Dell Softwareへのログインはこちらから[^<]*</a>    "${LOCALE}"=="ja-jp"    <a href[^"]*"(.*)">\\s*Dell Softwareの.グインはこちらから[^<]*</a>
    ...    ${seq_email}>0    <a href[^"]*"(.*)">.*Quest.*</a>    To set up a permanent password now, go to.*<a href[^"]*"(.*)">[^<]*account\\.quest\\.com[^<]*</a>
    Comment    ${str_re}=    Set Variable IF    "${LOCALE}"=="ja-jp" and ${seq_email}>0    一時パスワード: ([^ <\\s\\n\\t]*)    "${LOCALE}"=="ja-jp"    仮パスワード: ([^ <\\s\\n\\t]*)
    ...    [Pp]assword: ([^<\\s\\n\\t]*)
    Comment    ${link_re}=    Set Variable IF    "${LOCALE}"=="ja-jp" and ${seq_email}>0    <a href[^"]*"(.*)">\\s*Quest Softwareサインイン</a>    "${LOCALE}"=="ja-jp"    <a href[^"]*"(.*)">\\s*Quest Softwareの.グインはこちらから[^<]*</a>
    ...    ${seq_email}>0    <a href[^"]*"(.*)">.*Quest.*</a>    password now, go to.*<a href[^"]*"(.*)">[^<]*Quest Software Sign In[^<]*</a>
    Comment    ${wait_mailFrom}=    Set Variable IF    "${LOCALE}"=="ja-jp"    support@software.dell.com    ${RE_BASE_MAIL_ADDRESS}
    ${wait_mailFrom}=    Set Variable    ${RE_BASE_MAIL_ADDRESS}
    ${wait_mailFrom_2}=    Set Variable    ${RE_ADDITIONAL_MAIL_ADDRESS}
    ${str_re}=    Set Variable IF    "${LOCALE}"=="ja-jp"    仮パスワード: ([^ <\\s\\n\\t]*)    [Pp]assword: ([^<\\s\\n\\t]*)
    Comment    ${link_re}=    Set Variable IF    "${LOCALE}"=="ja-jp" and ${seq_email}>0    <a href[^"]*"(.*)">\\s*Quest Softwareへのログインはこちらから[^<]*</a>    "${LOCALE}"=="ja-jp"    <a href[^"]*"(.*)">\\s*Quest Softwareの.グインはこちらから[^<]*</a>
    ...    ${seq_email}>0    <a href[^"]*"(.*)">.*Quest.*</a>    password now, go to.*<a href[^"]*"(.*)">[^<]*Quest Software Sign In[^<]*</a>
    Comment    ${link_re}=    Set Variable IF    "${LOCALE}"=="ja-jp" and "${seq_email}"=="0"    <a href[^"]*"(.*)">\\s*Quest の.グインはこちらから[^<]*</a>    "${seq_email}"!="0"    href[^"]*"([^"]*https*://.*quest\.com/account/ResetPassword/[^"\\s]*)"
    ...    password now, go to.*<a href[^"]*"(.*)">[^<]*</a>
    ${link_re}=    Set Variable IF    "${LOCALE}"=="ja-jp" and "${seq_email}"=="0"    <a href[^"]*"(.*)">\\s*Quest の.グインはこちらから[^<]*</a>    "${seq_email}"!="0"    ["](http://.*\\.quest.com/wf/[^>"]*)["]>    password now, go to.*<a href[^"]*"(.*)">[^<]*</a>
    : FOR    ${index}    IN RANGE    ${count_attempt_check_mailbox}
    \    log    ${index}
    \    ${email}=    Get Specific Email    ${mailbox}    seq=${seq_email}    re_base_mailFrom=${wait_mailFrom}    re_additional_mailFrom=${wait_mailFrom_2}
    \    ${len_email}=    Get Length    ${email}
    \    ${email_from}=    Set Variable If    ${len_email}==0    ${EMPTY}    ${email['mail_from']}
    \    ${email_pass}=    Run Keyword IF    ${len_email}>0    Fetch Email    ${mailbox}    ${email['mail_id']}
    \    ...    ELSE    Set Variable    ${EMPTY}
    \    ${len_email_pass}=    Get Length    ${email_pass}
    \    ${link}=    Run Keyword IF    ${len_email_pass}>0    Get Regexp Matches    ${email_pass['mail_body']}    ${link_re}
    \    ...    1
    \    ...    ELSE    Set Variable    ${EMPTY}
    \    Run Keyword IF    ${len_email_pass}>0    log    ${email_pass['mail_body']}
    \    Run Keyword IF    ${len_email}==0 or ('${email_from}'!='support@quest.com' and "${link}"=="[]")    sleep    ${pause_check_mailbox}
    \    ...    ELSE    Exit For Loop
    \    Focus    xpath=//*[h1 or h2]
    ${msg}=    Evaluate    'Email with instruction to reset password has not been received in '+str((${index}+1)*${pause_check_mailbox})+' sec. '
    Run Keyword IF    ${len_email_pass}==0    Fail    ${msg}    invalidTestData
    Run Keyword IF    "${link}"=="${EMPTY}" or "${link}"=="[]"    Fail    ${msg}Email '${email['mail_subject']} ' from ${email['mail_from']} does not contain link to reset password    invalidTestData
    Set Test Variable    ${seq_email}    ${email['mail_id']}
    ${link}=    Evaluate    ${link}[0]
    Set Test Variable    ${link_SignIn}    ${link}

The user logs in as '${email}' and marks the "Remember Me" checkbox
    ${account}=    Evaluate    next((item for item in @{list_account} if item.get('email')=='${email}'), None)
    Run Keyword if    "${account}"=="${None}"    Fail    The account '${email}' has not defined
    The user sign in
    Mark the 'Remember Me' checkbox
    SignIn    ${account['email']}    ${account['password']}

The user again navigates to Sign In page
    Navigate to SignIn Page

Login is Failed
    [Arguments]    ${alert_re}=${EMPTY}    ${msg}=${EMPTY}    ${tagName}=${EMPTY}    # ${alert_re} is regexp of expected message. ${msg} is base part of message for log
    log    ${alert_re}
    Run Keyword And Continue on Failure    Wait Until Page Contains Element    ${at_alert_SignIn}
    sleep    1
    ${is_alert}    ${alert_text}=    If Alert    ${at_alert_SignIn}    ${at_alert_text_SignIn}
    ${alert_text}=    Replace String Using Regexp    ${alert_text}    <[^>]*>    ${EMPTY}
    ${alert_text}=    Replace String    ${alert_text}    "    '
    ${alert_text}=    Replace String Using Regexp    ${alert_text}    [\\[\\]]    ${EMPTY}
    log    ${alert_text}
    ${alert_re}=    Replace String Using Regexp    ${alert_re}    <[^>]*>    ${EMPTY}
    ${alert_re}=    Replace String    ${alert_re}    "    '
    ${msg}=    Set Variable IF    "${msg}"=="${EMPTY}"    ${msg}    '${msg}'
    Run Keyword IF    ${is_alert}==0    Capture Page Screenshot
    Run Keyword IF    ${is_alert}==0    Fail    Error message ${msg} has not been received    ${tagName}
    ${expected_alert}=    Run Keyword IF    ${is_alert}!=0 and "${alert_re}"!="${EMPTY}"    Get Regexp Matches    ${alert_text}    ${alert_re}
    ...    ELSE    Set Variable    ${EMPTY}
    Run Keyword IF    ${is_alert}!=0 and "${expected_alert}"=="[]"    Scroll To Element    ${at_alert_SignIn}
    Run Keyword IF    ${is_alert}!=0 and "${expected_alert}"=="[]"    Capture Page Screenshot
    Run Keyword IF    ${is_alert}!=0 and "${expected_alert}"=="[]"    Fail    Received error message has not been matched expected error message ${msg}    ${tagName}

Sign in with new password
    SignIn    ${mailbox['email_addr']}    ${temporary_pass}
    sleep    3

The user on Update Password page
    Active page should be Update Password

The user on Reset Password page
    Active page should be Reset Password

Clicks link 'Forgot Password'
    Focus    ${at_link_ForgotPassword}
    Click Element    ${at_link_ForgotPassword}

Clicks button 'Reset Password'
    Focus    ${at_buttom_ResetPassword}
    Click Element    ${at_buttom_ResetPassword}
    sleep    1
    Fail Test If Alert

The user fills account email
    ${email}=    Set Variable    ${mailbox['email_addr']}
    Set Test Variable    &{id_field}    &{id_field_local}
    Set Test Variable    ${xpath_to_field}    ${at_body_ResetPassword}
    Set '${email}' to field 'Email'
    Comment    Set '${email}' to field 'Confirm Business Email'
