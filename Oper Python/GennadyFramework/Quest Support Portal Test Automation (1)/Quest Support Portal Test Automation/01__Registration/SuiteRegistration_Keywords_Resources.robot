*** Settings ***
Resource          ../Resources/Registration_Page_Resources.robot
Resource          ../Resources/Commons.robot
Resource          ../Resources/Locators/Registration_Page_Locators.robot
Resource          ../Resources/Locators/SignIn_Page_Locators.robot
Resource          ../Resources/SignIn_Page_Resources.robot
Resource          ../Resources/MyAccount.robot

*** Variables ***
&{id_field}       Email Address=EmailAddress    First Name=FirstName    Last Name=LastName    Company=Company    Phone Number=PhoneNumber    Address=Address1    Suite/Unit Number=Address2
...               Postal Code=PostalCode    City=City    Country=Country    State=State    AccountId=AccountId    Asset Number=LicenseOrServiceTag    Email=username
...               Password=Password    Confirm Password=PasswordConfirm    Address 1=Address1
&{value_field}    Email Address=${EMPTY}    First Name=${EMPTY}    Last Name=${EMPTY}    Company=${EMPTY}    Phone Number=${EMPTY}    Address==${EMPTY}    Suite/Unit Number=${EMPTY}
...               Postal Code=${EMPTY}    City=${EMPTY}    Country=${EMPTY}    State=${EMPTY}    AccountId=${EMPTY}    Asset Number=${EMPTY}    Email=${EMPTY}
...               Password=${EMPTY}    Confirm Password=${EMPTY}    Address 1=${EMPTY}
${mailbox}        ${EMPTY}
${xpath_to_field}    ${EMPTY}
${count_attempt_check_mailbox}    15
${temporary_pass}    12345robot
${verificationCode}    ${EMPTY}
${pause_check_mailbox}    20
${LICENSE_NUMBER}    126-169-391    # 125-635-321, 125-200-497; 125-233-583; 125-340-992; 113-840-674 (with Transfer Key)
${ACCOUNT_ID}     1-7QFUX3    # 1-7QG2I5, 1-7QFUX3
${link_SignIn}    ${EMPTY}
${dsg_Registration_Complete_KnownAccount_Title_locator}    xpath=//h1[@id="LayoutH1" and text()[contains(., '${dsg_Registration_Complete_KnownAccount_Title}')]]
${seq_email}      0

*** Keywords ***
An anonymous user on the Registration page
    Open Registration Page

The user on the page ‘Create a Support Account With A Trial Product’
    Active page should be Create a Support Account With A Trial Product

The user on the page ‘Customer Service’
    Active page should be Customer Service

Prepare Mailbox
    ${mailbox}=    Create Mail Box
    Set Test Variable    ${mailbox}

Set '${value}' to field '${fieldName}'
    ${locator}=    Set Variable    ${xpath_to_field}//input[@id="&{id_field}[${fieldName}]"]
    Wait Until Page Contains Element    ${locator}
    Scroll To Element    ${locator}
    Click Element    ${locator}
    JS Set Value To Input    ${locator}    ${value}
    Comment    Run Keyword IF    "${fieldName}" in ("Email Address", "AccountId", "Asset Number")    JS Set Value To Input    ${locator}    ${value}
    ...    ELSE    Input Text    ${locator}    ${value}
    Set To Dictionary    ${value_field}    ${fieldName}=${value}
    Comment    Run Keyword IF    "${fieldName}" not in ("Email Address", "AccountId", "Asset Number")    Simulate    ${locator}    change
    Comment    Run Keyword IF    "${fieldName}" not in ("Email Address", "AccountId", "Asset Number")    sleep    2

Set text '${value}' to field '${fieldName}'
    ${locator}=    Set Variable    ${xpath_to_field}//textarea[@id="&{id_field}[${fieldName}]"]
    JS Set Value To Input    ${locator}    ${value}
    Comment    Input Text    ${locator}    ${value}
    Set To Dictionary    ${value_field}    ${fieldName}=${value}
    Comment    Simulate    ${locator}    change
    Comment    sleep    2

Select '${value}' in the '${nameSelector}' selector
    ${locator}=    Set Variable    ${xpath_to_field}//select[@id="&{id_field}[${nameSelector}]"]
    Wait Until Element Is Enabled    ${locator}
    JS Select Item of DropDown List    ${locator}    ${value}
    Set To Dictionary    ${value_field}    ${nameSelector}=${value}
    sleep    1

Clicks the button 'Create Account'
    Click Button    ${xpath_to_field}${dsg_Registration_Button_CreateAccount_locator}
    sleep    3
    Comment    Current Page Should Not Contain Errors
    Comment    Fail Test If Alert    Failed to create new Support Account. Alert was raised. Alert text:    invalidTestData

The user receives email with temporary password
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
    Comment    ${str_re}=    Set Variable IF    "${LOCALE}"=="ja-jp"    仮パスワード: ([^ <\\s\\n\\t]*)    "${LOCALE}"=="es-es"    [Cc]ontraseña temporal: ([^<\\s\\n\\t]*)
    ...    [Pp]assword: ([^<\\s\\n\\t]*)
    Comment    ${str_re}=    Set Variable IF    "${LOCALE}"=="ja-jp"    一時パスワード: ([^ <\\s\\n\\t]*)    "${LOCALE}"=="es-es"    [Cc]ontraseña temporal:\\s* ([^<\\s\\n\\t]*)
    ...    [Pp]assword:\\s*([^<\\s\\n\\t]*)
    ${str_re}=    Set Variable IF    "${LOCALE}"=="ja-jp"    次のコードを入力:[\\s]*(<[^>]*>)*([^<\\s]*)    "${LOCALE}"=="es-es"    O ingrese el código :[\\s]*(<[^>]*>)*([^<\\s]*)    Or enter code:[\\s]*(<[^>]*>)*([^<\\s]*)
    Comment    ${link_re}=    Set Variable IF    "${LOCALE}"=="ja-jp" and ${seq_email}>0    <a href[^"]*"(.*)">\\s*Quest Softwareへのログインはこちらから[^<]*</a>    "${LOCALE}"=="ja-jp"    <a href[^"]*"(.*)">\\s*Quest Softwareの.グインはこちらから[^<]*</a>
    ...    ${seq_email}>0    <a href[^"]*"(.*)">.*Quest.*</a>    password now, go to.*<a href[^"]*"(.*)">[^<]*Quest Software Sign In[^<]*</a>
    Comment    ${link_re}=    Set Variable IF    "${LOCALE}"=="ja-jp" and ${seq_email}>0    <a href[^"]*"(.*)">\\s*Quest へのログインはこちらから[^<]*</a>    "${LOCALE}"=="ja-jp"    <a href[^"]*"(.*)">\\s*Quest の.グインはこちらから[^<]*</a>
    ...    ${seq_email}>0    <a href[^"]*"(.*)">.*Quest.*</a>    password now, go to.*<a href[^"]*"(.*)">[^<]*</a>
    Comment    ${link_re}=    Set Variable IF    "${LOCALE}"=="ja-jp" and ${seq_email}>0    <a href[^"]*"(.*)">\\s*Quest へのログインはこちらから[^<]*</a>    "${LOCALE}"=="ja-jp"    <a href[^"]*"([^"]*quest\.com/account/confirm/[^"]*)">[^<]*</a>
    ...    ${seq_email}>0    <a href[^"]*"([^"]*/ResetPassword/[^"]*)">.*[Qq]uest.*</a>    "${LOCALE}"=="es-es"    Para establecer una contraseña permanente ahora, visite.*<a href[^"]*"([^"]*)">[^<]*</a>    password now, go to.*<a href[^"]*"(.*)">[^<]*</a>
    Comment    ${link_re}=    Set Variable IF    "${LOCALE}"=="ja-jp" and "${seq_email}"!="0"    <a href[^"]*"(.*)">\\s*Quest へのログインはこちらから[^<]*</a>    "${LOCALE}"=="ja-jp"    ["](https://.*account.quest.com[^>"]*)["]>
    ...    "${seq_email}"!="0"    <a href[^"]*"([^"]*/ResetPassword/[^"]*)">.*Reset Password.*</a>    "${LOCALE}"=="es-es"    ["](https://.*account.quest.com[^>"]*)["]>    ["](https://.*account.quest.com[^>"]*)["]>
    ${link_re}=    Set Variable IF    "${LOCALE}"=="ja-jp" and "${seq_email}"!="0"    <a href[^"]*"(.*)">\\s*Quest へのログインはこちらから[^<]*</a>    "${LOCALE}"=="ja-jp"    ["](http://.*\\.quest.com/wf/[^>"]*)["]>    "${seq_email}"!="0"
    ...    <a href[^"]*"([^"]*/ResetPassword/[^"]*)">.*Reset Password.*</a>    "${LOCALE}"=="es-es"    ["](http://.*\\.quest.com/wf/[^>"]*)["]>    ["](http://.*\\.quest.com/wf/[^>"]*)["]>
    : FOR    ${index}    IN RANGE    ${count_attempt_check_mailbox}
    \    log    ${index}
    \    ${email}=    Get Specific Email    ${mailbox}    seq=${seq_email}    re_base_mailFrom=${wait_mailFrom}    re_additional_mailFrom=${wait_mailFrom_2}
    \    ${len_email}=    Get Length    ${email}
    \    ${email_from}=    Set Variable If    ${len_email}==0    ${EMPTY}    ${email['mail_from']}
    \    ${email_pass}=    Run Keyword IF    ${len_email}>0    Fetch Email    ${mailbox}    ${email['mail_id']}
    \    ...    ELSE    Set Variable    ${EMPTY}
    \    ${len_email_pass}=    Get Length    ${email_pass}
    \    ${temp_pass}=    Run Keyword IF    ${len_email_pass}>0    Get Regexp Matches    ${email_pass['mail_body']}    ${str_re}
    \    ...    2
    \    ...    ELSE    Set Variable    ${EMPTY}
    \    Run Keyword IF    ${len_email_pass}>0    log    ${email_pass['mail_body']}
    \    Run Keyword IF    ${len_email}==0 or ('${email_from}'!='support@quest.com' and "${temp_pass}"=="[]")    sleep    ${pause_check_mailbox}
    \    ...    ELSE    Exit For Loop
    \    Focus    xpath=//*[h1 or h2]
    ${msg}=    Evaluate    'Email with temporary password has not been received in '+str((${index}+1)*${pause_check_mailbox})+' sec. '
    Run Keyword IF    ${len_email_pass}==0    Fail    ${msg}    invalidTestData
    Run Keyword IF    "${temp_pass}"=="${EMPTY}" or "${temp_pass}"=="[]"    Fail    ${msg}Email '${email['mail_subject']} ' from ${email['mail_from']} does not contain Password    invalidTestData
    ${temp_pass}=    Run Keyword IF    "${temp_pass}"!="${EMPTY}" and "${temp_pass}"!="[]"    Evaluate    ${temp_pass}[0]
    ...    ELSE    Set Variable    ${EMPTY}
    Comment    ${temp_pass}=    Get Temp Password    ${email_pass}    ${str_re}
    Set Test Variable    ${verificationCode}    ${temp_pass}
    Set Test Variable    ${seq_email}    ${email['mail_id']}
    Comment    ${link_}=    Get Regexp Matches    ${mail_body}    (https://.*account.quest.com[^>""]*).>https://.*account.quest.com    1
    ${link_}=    Get Regexp Matches    ${email_pass['mail_body']}    ${link_re}    1
    ${link_}=    Run Keyword IF    "${link_}"!="[]"    Evaluate    ${link_}[0]
    ...    ELSE    Set Variable    ${EMPTY}
    Set Test Variable    ${link_SignIn}    ${link_}

The user sign in with temporary password
    Focus    ${at_button_signIn}
    Click Element    ${at_button_signIn}
    Wait Until Element Is Visible    ${at_element_menu_signIn}
    Click Element    ${at_element_menu_signIn}
    SignIn    ${mailbox['email_addr']}    ${temporary_pass}
    Fail Test If Alert

The user performs verification
    Verification Code    ${mailbox['email_addr']}    ${verificationCode}
    Fail Test If Alert

Creates new password
    [Arguments]    ${new_pass}=${EMPTY}
    ${cutXpath_at_CreatePass_UserName}=    Replace String    ${at_CreatePass_UserName}    ''    '
    ${cutXpath_at_CreatePass_UserName}=    Replace String    ${cutXpath_at_CreatePass_UserName}    xpath=    ${EMPTY}
    Comment    Wait Until Page Contains Element    ${at_CreatePass_UserName}
    Comment    Wait Until Element is Visible    ${at_CreatePass_UserName}
    Wait Until Page Contains Element    ${at_CreatePass_UserName}[@value="${mailbox['email_addr']}"]    error=Email address did not appear on the Create New Password page in TIMEOUT.
    ${new_pass}=    Set Variable IF    "${new_pass}"=="${EMPTY}"    ${temporary_pass}robot    ${new_pass}
    Create New Password    ${new_pass}    ${temporary_pass}
    Fail Test If Alert

The license page contains correct license information
    ${locale}=    Evaluate    ("" if "${LOCALE}".lower()=="en-us" else "/${LOCALE}".lower())
    Go To    ${SUPPORT_STAGE2_SITE}${locale}${url_To_License}
    Active page should be Licenses
    Wait Until Page Contains    ${LICENSE_NUMBER}
    Comment    Page Should Contain    ${LICENSE_NUMBER}

My Products page contains correct product information
    Scroll To Element    ${at_SignInButton}
    Focus    ${at_SignInButton}
    Click Element    ${at_SignInButton}
    Focus    ${at_dsg_MyAccount_Label}
    Click Element    ${at_dsg_MyAccount_Label}
    Wait Until Page Contains Element    ${at_MyProducts_ProductGrid}/tbody/tr/td
    sleep    5
    Wait Until Element Is Visible    ${dsg_MyAccount_GridColCaption_MyProduct_locator}
    ${at_alert}=    Prepare Locator To JS    ${at_MyProducts_ProductGrid}//*[self::td or self::span[parent::td] or self::a[parent::td]][text()[normalize-space()]="${TEST_PRODUCT}"]
    ${alert}=    Get Matching Xpath Count    ${at_alert}
    ${alert_text}=    SET Variable IF    ${alert}==0    My Products page does not contain information about product    ${EMPTY}
    Run Keyword IF    ${alert}==0    Capture Page Screenshot
    Run Keyword IF    ${alert}==0    Fail    ${alert_text}

The user selects the test product in the product selector
    JS Select Item of DropDown List    ${at_trial_select_product}    ${TEST_PRODUCT}
    Set To Dictionary    ${value_field}    Product=${TEST_PRODUCT}

Fail Test If Alert
    [Arguments]    ${msg}=${EMPTY}    ${tagName}=${EMPTY}    # ${msg} is base part of message for log
    ${is_alert}    ${alert_text}=    If Alert
    Run Keyword IF    ${is_alert}!=0    Capture Page Screenshot
    Run Keyword IF    ${is_alert}!=0    Fail    ${msg}'${alert_text}’    ${tagName}

The user navigates to email link "Quest Software Sign In"
    ${msg}=    Set Variable IF    "${link_SignIn}"=="${EMPTY}"    Email with password does not contalin link "Dell Software Sign In"    ${EMPTY}
    Run Keyword IF    "${link_SignIn}"=="${EMPTY}"    Fail    ${msg}
    Go To    ${link_SignIn}

The user navigates to email link for verification email address
    ${msg}=    Set Variable IF    "${link_SignIn}"=="${EMPTY}"    Email with password does not contalin link "Dell Software Sign In"    ${EMPTY}
    Run Keyword IF    "${link_SignIn}"=="${EMPTY}"    Fail    ${msg}
    Go To    ${link_SignIn}

The user on the page Create New Password
    Active page should be Create New Password
    ${locator}=    Prepare Locator To JS    ${at_body_ChangePassword-ResetPassword}
    ${is_ResetPassword}=    Get Matching Xpath Count    ${locator}
    Run Keyword IF    ${is_ResetPassword}>0    Set Test Variable    ${temporary_pass}    reset123
    ${at_CreatePass_UserName}=    Replace String    ${at_CreatePass_UserName}    xpath=    ${EMPTY}
    ${at_CreatePass_tempPass}=    Replace String    ${at_CreatePass_tempPass}    xpath=    ${EMPTY}
    ${email}=    Get Element Attribute    ${at_CreatePass_UserName}@value
    ${pass}=    Run Keyword IF    ${is_ResetPassword}==0    Get Element Attribute    ${at_CreatePass_tempPass}@value
    ...    ELSE    Set Variable    reset123
    ${email_addr}    ${email}=    Evaluate    "${mailbox['email_addr']}".lower(), "${email}".lower()
    ${msg}=    Set Variable IF    "${email}"!="${email_addr}"    Business Email does not match Registration Email.    ${EMPTY}
    ${msg}=    Set Variable IF    "${pass}"!="${temporary_pass}"    ${msg}Temporary Password does not match password from email.    ${msg}
    Run Keyword IF    "${msg}"!="${EMPTY}"    Fail    ${msg}

The user creates new password
    Create New Password    ${temporary_pass}robot
    Set Test Variable    ${temporary_pass}    ${temporary_pass}robot

The user resets password
    [Arguments]    ${new_pass}=${EMPTY}
    ${new_pass}=    Set Variable IF    "${new_pass}"=="${EMPTY}"    ${temporary_pass}robot    ${new_pass}
    Reset Password    ${new_pass}
    Set Test Variable    ${temporary_pass}    ${new_pass}

If Alert
    [Arguments]    ${locator_at_alert}=${EMPTY}    ${locator_at_alert_text}=${EMPTY}    ${locator_at_alert_header}=${EMPTY}
    Comment    ${at_alert}=    Replace String    ${at_alert}    "    '
    Comment    ${at_alert}=    Replace String    ${at_alert}    xpath=    ${EMPTY}
    ${locator_at_alert}=    Set Variable IF    "${locator_at_alert}"=="${EMPTY}"    ${at_alert}    ${locator_at_alert}
    ${locator_at_alert_text}=    Set Variable IF    "${locator_at_alert_text}"=="${EMPTY}"    ${at_alert_text}    ${locator_at_alert_text}
    ${locator_at_alert_header}=    Set Variable IF    "${locator_at_alert_header}"=="${EMPTY}"    ${at_alert_header}    ${locator_at_alert_header}
    ${is_alert}=    Get Matching Xpath Count    ${locator_at_alert}
    ${alert_text}=    Run Keyword IF    ${is_alert}!=0    Execute Javascript    return window.document.evaluate("${locator_at_alert_text}", document, null, XPathResult.STRING_TYPE, null).stringValue;
    ...    ELSE    Set Variable    ${EMPTY}
    ${alert_header}=    Run Keyword IF    ${is_alert}!=0 and "${locator_at_alert_header}"!="${EMPTY}"    Execute Javascript    return window.document.evaluate("${locator_at_alert_header}", document, null, XPathResult.STRING_TYPE, null).stringValue;
    ...    ELSE    Set Variable    ${EMPTY}
    Comment    ${alert_text}=    Evaluate    "${alert_header}".strip() + " " + "${alert_text}".strip()
    ${alert_text}=    Set Variable    ${alert_header} ${alert_text}
    Run Keyword IF    ${is_alert}!=0    Scroll To Element    ${locator_at_alert}
    Run Keyword IF    ${is_alert}!=0    Capture Page Screenshot
    [Return]    ${is_alert}    ${alert_text}

Pass Test If Alert
    [Arguments]    ${alert_re}=${EMPTY}    ${msg}=${EMPTY}    ${tagName}=${EMPTY}    # ${alert_re} is regexp of expected message. ${msg} is base part of message for log
    log    ${alert_re}
    Run Keyword And Continue on Failure    Wait Until Page Contains Element    ${at_alert}
    sleep    1
    ${is_alert}    ${alert_text}=    If Alert
    ${alert_text}=    Replace String Using Regexp    ${alert_text}    <[^>]*>    ${EMPTY}
    ${alert_text}=    Replace String    ${alert_text}    "    '
    ${alert_re}=    Replace String Using Regexp    ${alert_re}    <[^>]*>    ${EMPTY}
    ${alert_re}=    Replace String    ${alert_re}    "    '
    ${msg}=    Set Variable IF    "${msg}"=="${EMPTY}"    ${msg}    '${msg}'
    Run Keyword IF    ${is_alert}==0    Capture Page Screenshot
    Run Keyword IF    ${is_alert}==0    Fail    Error message ${msg} has not been received    ${tagName}
    ${expected_alert}=    Run Keyword IF    ${is_alert}!=0 and "${alert_re}"!="${EMPTY}"    Get Regexp Matches    ${alert_text}    ${alert_re}
    ...    ELSE    Set Variable    ${EMPTY}
    Run Keyword IF    ${is_alert}!=0 and "${expected_alert}"=="[]"    Scroll To Element    ${at_alert}
    Run Keyword IF    ${is_alert}!=0 and "${expected_alert}"=="[]"    Capture Page Screenshot
    Run Keyword IF    ${is_alert}!=0 and "${expected_alert}"=="[]"    Fail    Received error message has not been matched expected error message ${msg}    ${tagName}

Generate RegExp Error Message
    [Arguments]    ${base_locator}    ${base_msg}    ${attributeName_forMsg}=title    &{requeredField}
    Comment    ${locator}=    Prepare Locator To JS    ${at_ContactFormPlaceholder}
    ${locator}=    Prepare Locator To JS    ${base_locator}
    ${msg}=    Set Variable    ${EMPTY}
    Comment    :FOR    ${field}    IN    @{requered_field}
    : FOR    ${field}    IN    @{requeredField}
    \    Comment    ${id}=    Set Variable    &{requered_field}[${field}]
    \    ${id}=    Set Variable    &{requeredField}[${field}]
    \    ${value_field}=    Execute Javascript    return window.document.evaluate("${locator}//*[@id='${id}']", document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue.value
    \    Comment    ${is_attribute}=    Get Matching Xpath Count    ${locator}//*[@id='${id}'][@data-val-displayname]
    \    ${is_attribute}=    Get Matching Xpath Count    ${locator}//*[@id='${id}'][@${attributeName_forMsg}]
    \    Comment    ${name_for_msg}=    Run Keyword If    "${value_field}"=="${EMPTY}" and ${is_attribute}==1    Execute Javascript    return window.document.evaluate("${locator}//*[@id='${id}']/@data-val-displayname", document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue.value
    \    ...    ELSE IF    "${value_field}"=="${EMPTY}" and ${is_attribute}==0    Set Variable    ${field}
    \    ...    ELSE    Set Variable    ${EMPTY}
    \    ${name_for_msg}=    Run Keyword If    "${value_field}"=="${EMPTY}" and ${is_attribute}==1    Execute Javascript    return window.document.evaluate("${locator}//*[@id='${id}']/@${attributeName_forMsg}", document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue.value
    \    ...    ELSE IF    "${value_field}"=="${EMPTY}" and ${is_attribute}==0    Set Variable    ${field}
    \    ...    ELSE    Set Variable    ${EMPTY}
    \    ${name_for_msg}=    Replace String Using Regexp    ${name_for_msg}    [\\r\\n]    ${EMPTY}
    \    Comment    ${msg}=    Set Variable IF    "${value_field}"=="${EMPTY}" and "${msg}"!="${EMPTY}"    ${msg}\\s*[\|]\\s*${name_for_msg}    "${value_field}"=="${EMPTY}" and "${msg}"=="${EMPTY}"
    \    ...    ${base_msg}.*${name_for_msg}    ${msg}
    \    ${msg}=    Set Variable IF    "${value_field}"=="${EMPTY}" and "${msg}"!="${EMPTY}"    ${msg}\\s*\\|*\\s*${name_for_msg}    "${value_field}"=="${EMPTY}" and "${msg}"=="${EMPTY}"    ${base_msg}.*${name_for_msg}
    \    ...    ${msg}
    [Return]    ${msg}
