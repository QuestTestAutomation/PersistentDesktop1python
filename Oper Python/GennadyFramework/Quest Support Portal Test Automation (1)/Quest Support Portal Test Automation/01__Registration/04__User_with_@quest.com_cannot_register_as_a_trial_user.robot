*** Settings ***
Documentation     *Test Case #7904:* Registration - User with *@software.dell.com cannot register as a trial user
...
...               http://alvatfw01:8080/tfs/web/wi.aspx?id=7904&pguid=98ba80ca-4eae-4fca-b6eb-a89eaca35595
Suite Setup       Global Setup
Test Teardown     Close Working Session
Force Tags        registration
Resource          ../Resources/Commons.robot
Resource          SuiteRegistration_Keywords_Resources.robot
Resource          ../Resources/SignIn_Page_Resources.robot

*** Variables ***
&{requered_field_local}    ${dsg_Registration_Label_EmailAddress_Title}=EmailAddress

*** Test Cases ***
Validate Unknown Emploee Email Address
    [Setup]    Setup DSG Email Address    unexistingwrongemail@quest.com    # Set non-existing email adders for DGS account
    GIVEN An anonymous user on the Registration page
    WHEN The user click on the link ‘Register Trial Product’
    THEN The user on the page ‘Create a Support Account With A Trial Product’
    WHEN The user selects the test product in the product selector
    AND fills contact information
    Comment    THEN Alert with notification is raised    ${dsg_Registration_Validation_Email_UnknownEmployee}
    THEN the user receives an error on the page
    AND User clicks the button 'Create Account'
    Comment    THEN Alert with notification is raised    ${dsg_Registration_Validation_Email_UnknownEmployee}
    THEN the user receives an error on the page

Refuse Registration for Known Quest Email Address
    [Setup]    Setup DSG Email Address    Oleg.Skripnyak@quest.com    # Set non-existing email adders for DGS account
    GIVEN An anonymous user on the Registration page
    WHEN The user click on the link ‘Register Trial Product’
    THEN The user on the page ‘Create a Support Account With A Trial Product’
    WHEN The user selects the test product in the product selector
    AND fills contact information
    THEN Alert with notification is raised    ${dsg_Registration_Label_EmailAddress}
    AND User clicks the button 'Create Account'
    THEN Alert with notification is raised    ${dsg_Registration_Label_EmailAddress}
    Comment    THEN Alert with notification is raised    ${dsg_Registration_Validation_Email_Registered_Template}

*** Keywords ***
The user click on the link ‘Register Trial Product’
    Comment    Scroll To Element    ${at_link_trial_product}
    Comment    Highlight Element    ${at_link_trial_product}
    Click Element    ${at_link_trial_product}

Fills contact information
    Set Test Variable    ${xpath_to_field}    ${at_form_frmRegisterTrialUser}
    Comment    ${email}=    Set Variable    ${mailbox['email_addr']}
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

Alert with notification is raised
    [Arguments]    ${expected_alert_text_message}
    ${expected_alert_text_message}=    Replace String Using Regexp    ${expected_alert_text_message}    <a.*?>    ${EMPTY}
    ${expected_alert_text_message}=    Replace String Using Regexp    ${expected_alert_text_message}    <\/a>    ${EMPTY}
    Pass Test If Alert    ${expected_alert_text_message}    The expexted alert text differs from the actual text

User clicks the button 'Create Account'
    ${dsg_var}=    Replace String Using Regexp    ${dsg_Registration_Button_CreateAccount}    [\\r\\n\\t]    ${EMPTY}
    Scroll To Element    ${xpath_to_field}//button[contains(text(), '${dsg_var}')]
    Click Button    ${xpath_to_field}//button[contains(text(), '${dsg_var}')]
    Comment    Scroll To Element    ${xpath_to_field}//button[text()='${dsg_Registration_Button_CreateAccount}']
    Comment    Click Button    ${xpath_to_field}//button[text()='${dsg_Registration_Button_CreateAccount}']
    sleep    2
    Current Page Should Not Contain Errors

Setup DSG Email Address
    [Arguments]    ${email_address}
    ${email}=    Set Variable    ${email_address}
    Set Test Variable    ${email}

The user receives an error on the page
    sleep    1
    ${msg_re}=    Generate RegExp Error Message    ${at_form_frmRegisterTrialUser}    [0-9]{1,} item[s]* need[s]* attention    attributeName_forMsg=title    &{requered_field_local}
    ${countErrorFields}=    Evaluate    '${msg_re}'.count('\\s*\\|*') + 1
    ${str}=    Set Variable IF    "${msg_re}"!="${EMPTY}" and ${countErrorFields}>1    ${countErrorFields} items need attention    "${msg_re}"!="${EMPTY}" and ${countErrorFields}==1    1 item needs attention    ${EMPTY}
    Pass Test If Alert    ${msg_re}    ${str}
