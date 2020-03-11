*** Settings ***
Resource          ../Resources/ContactSupport_Page_Resources.robot
Resource          ../Resources/Commons.robot
Resource          ../Resources/Menu.robot
Resource          ../01__Registration/SuiteRegistration_Keywords_Resources.robot

*** Variables ***
&{requered_field}
${email}          ${EMPTY}
${SR_number}      ${EMPTY}
${count_attempt_check_email}    15

*** Keywords ***
An anonymous user on the Contact Support page
    Open Contact Support Page

The user on ‘Customer Service’ page
    Active page should be Customer Service

The user selects the test product in the '${nameSelector}' selector
    The user selects '${TEST_PRODUCT}' in the '${nameSelector}' selector

Fills captcha
    Check Captcha    xpath=//iframe

Clicks the button 'Next'
    Wait Until Page Contains Element    ${xpath_to_field}//input[@id="next-button"]
    Click Element    ${xpath_to_field}//input[@id="next-button"]
    sleep    2
    Current Page Should Not Contain Errors

The user clicks on the button 'Submit Customer Service Request'
    Click Element    ${dsg_CustomerServiceForm_RelevantArticles_Submit_locator}

The user reseives messages 'Your request has been sent successfully'
    Wait Until Page Contains Element    ${dsg_ContactUs_EmailConfirmationMsg_locator}

The user on the page KB Articles that may match the issue
    Fail Test If Alert    Failed to create Service Request. Alert was raised. Alert text:    invalidTestData
    Comment    Wait Until Page Contains Element    ${dsg_CreateSR_KBDescription_locator}
    Wait Until Page Contains Element    ${dsg_CustomerServiceForm_Submit_locator}
    Current Page Should Not Contain Errors

Scrolls down the page
    Wait Until Page Contains Element    ${xpath_to_field}//input[@type="button"]
    Scroll To Element    ${xpath_to_field}//input[@type="button"]

Describes service request details
    Set 'My Descriptive Title' to field 'Descriptive Title'
    Set text 'My Description of the Problem' to field 'Description of the Problem'
    log    ${LICENSE_NUMBER}
    Set '${LICENSE_NUMBER}' to field 'License Number'

--Generate RegExp Error Message
    [Arguments]    ${base_locator}    ${base_msg}    &{requeredField}
    Comment    ${locator}=    Prepare Locator To JS    ${at_ContactFormPlaceholder}
    ${locator}=    Prepare Locator To JS    ${base_locator}
    ${msg}=    Set Variable    ${EMPTY}
    Comment    :FOR    ${field}    IN    @{requered_field}
    : FOR    ${field}    IN    @{requeredField}
    \    Comment    ${id}=    Set Variable    &{requered_field}[${field}]
    \    ${id}=    Set Variable    &{requeredField}[${field}]
    \    ${value_field}=    Execute Javascript    return window.document.evaluate("${locator}//*[@id='${id}']", document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue.value
    \    ${is_attribute}=    Get Matching Xpath Count    ${locator}//*[@id='${id}'][@data-val-displayname]
    \    ${name_for_msg}=    Run Keyword If    "${value_field}"=="${EMPTY}" and ${is_attribute}==1    Execute Javascript    return window.document.evaluate("${locator}//*[@id='${id}']/@data-val-displayname", document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue.value
    \    ...    ELSE IF    "${value_field}"=="${EMPTY}" and ${is_attribute}==0    Set Variable    ${field}
    \    ...    ELSE    Set Variable    ${EMPTY}
    \    ${msg}=    Set Variable IF    "${value_field}"=="${EMPTY}" and "${msg}"!="${EMPTY}"    ${msg}\\s*[\|]\\s*${name_for_msg}    "${value_field}"=="${EMPTY}" and "${msg}"=="${EMPTY}"    ${base_msg}.*${name_for_msg}
    \    ...    ${msg}
    [Return]    ${msg}

The user on the Contact Support page
    Active page should be Contact Support

The user on the 'Licensing Assistance' page
    Active page should be Licensing Assistance

The user selects test version in the product version selector
    sleep    1
    Select '${TEST_PRODUCT_VERSION}' in the 'Product Version' selector

The user clicks on the button 'Submit Licensing Request'
    Click Element    ${dsg_LicenseForm_RelevantArticles_Submit_locator}

The user receives email with confirmation service request
    ${wait_mailFrom}=    Set Variable    ${RE_BASE_MAIL_ADDRESS}
    ${wait_mailFrom_2}=    Set Variable    ${RE_ADDITIONAL_MAIL_ADDRESS}
    ${re_subject}=    Set Variable    (Auto\-Confirmation \|SR Number:[0-9]*\|)
    ${str_re}=    Set Variable    [\\s\|]SR Number:([0-9]*)[\\s\|]
    : FOR    ${index}    IN RANGE    ${count_attempt_check_email}
    \    log    ${index}
    \    ${email}=    Get Specific Email    ${mailbox}    seq=${seq_email}    re_base_mailFrom=${wait_mailFrom}    re_additional_mailFrom=${wait_mailFrom_2}
    \    ${len_email}=    Get Length    ${email}
    \    ${email_from}=    Set Variable If    ${len_email}==0    ${EMPTY}    ${email['mail_from']}
    \    ${email_confirm}=    Run Keyword IF    ${len_email}>0    Fetch Email    ${mailbox}    ${email['mail_id']}
    \    ...    ELSE    Set Variable    ${EMPTY}
    \    ${len_email_confirm}=    Get Length    ${email_confirm}
    \    ${SR_num}=    Run Keyword IF    ${len_email_confirm}>0    Get Regexp Matches    ${email_confirm['mail_body']}    ${str_re}
    \    ...    1
    \    ...    ELSE    Set Variable    ${EMPTY}
    \    ${is_expected_mail}=    Run Keyword IF    ${len_email_confirm}>0    Get Regexp Matches    ${email_confirm['mail_subject']}    ${re_subject}
    \    ...    1
    \    ...    ELSE    Set Variable    ${EMPTY}
    \    Run Keyword IF    ${len_email_confirm}>0    log    ${email_confirm['mail_body']}
    \    Run Keyword IF    ${len_email_confirm}==0 or \ \ "${is_expected_mail}"=="[]"    sleep    ${pause_check_mailbox}
    \    ...    ELSE    Exit For Loop
    \    Focus    xpath=//h1
    ${msg}=    Evaluate    'Email with SR Number has not been received in '+str((${index}+1)*${pause_check_mailbox})+' sec. '
    Run Keyword IF    ${len_email_confirm}==0    Fail    ${msg}    invalidTestData
    Run Keyword IF    "${SR_num}"=="${EMPTY}" or "${SR_num}"=="[]"    Fail    ${msg}Email '${email['mail_subject']} ' from ${email['mail_from']} does not contain SR Number    invalidTestData
    ${SR_num}=    Run Keyword IF    "${SR_num}"!="${EMPTY}" and "${SR_num}"!="[]"    Evaluate    ${SR_num}[0]
    ...    ELSE    Set Variable    ${EMPTY}
    Set Test Variable    ${SR_number}    ${SR_num}
    Set Test Variable    ${seq_email}    ${email['mail_id']}

The user on the 'Professional Services Assistance' page
    Active page should be Professional Services Assistance

The user selects '${value}' in the '${nameSelector}' selector
    Select '${value}' in the '${nameSelector}' selector
    ${location}=    Get Location
    ${is_msgAppear}=    Evaluate    (1 if re.search('.*/renewals$' , '${location}') else 0)    modules=re
    Comment    Run Keyword IF    ${is_msgAppear}==1    Wait Until Page Contains    ${dsg_ContactUs_Renewals_ProductContact_Instructions_locator}

The user on the 'Renewals Assistance' page
    Active page should be Renewals Assistance

The user on the 'Request product information' page
    Active page should be Request Product Information

The user on the 'Training Assistance' page
    Active page should be Training Assistance

Clicks the button 'Submit Request'
    Wait Until Page Contains Element    ${xpath_to_field}//input[@id="sendButton"]
    Click Element    ${xpath_to_field}//input[@id="sendButton"]
    sleep    2
    Comment    Current Page Should Not Contain Errors

The user scrolls down the page
    Scrolls down the page

The modal window 'Welcome to Quest Support' appears
    Active page should be Welcome to Quest Support

The user clicks 'Continue' button of modal window
    Click Element    ${dsg_ProductSearch_modalBtnContinue_locator}

If 'Product Alert' modal window is appeared the user clicks on the 'Continue' button
    Close Chat    ${at_chat}
    ${locator}=    Prepare Locator To JS    ${divNotificationModal_Alert_Title_locator}
    ${show_modal}=    Get Matching Xpath Count    ${locator}
    Run Keyword IF    ${show_modal}!=0    Click Element    ${okButton_divNotificationModal}
