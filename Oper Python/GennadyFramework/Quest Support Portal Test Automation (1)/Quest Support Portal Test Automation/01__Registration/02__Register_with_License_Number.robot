*** Settings ***
Suite Setup       Global Setup
Test Teardown     Close Working Session
Force Tags        registration
Resource          ../Resources/Commons.robot
Resource          SuiteRegistration_Keywords_Resources.robot

*** Variables ***

*** Test Cases ***
Register with License Number
    [Setup]    Prepare Mailbox
    GIVEN An anonymous user on the Registration page
    WHEN the user fills field 'Asset Number'
    AND fills contact information
    AND clicks the button 'Create Account'
    THEN account has been created
    AND the user receives email with temporary password
    Comment    WHEN the user sign in with temporary password
    Comment    AND Creates new password
    WHEN the user performs verification
    THEN the user on the Welcome page
    AND the user is logged
    AND profile information and registration information are equal
    AND the license page contains correct license information

*** Keywords ***
Account has been created
    Fail Test If Alert    Failed to create new Support Account. Alert was raised. Alert text:    invalidTestData
    Wait Until Page Contains Element    ${dib-verify-email}

Fills contact information
    Comment    Set Test Variable    &{id_field}    &{contact_information_field_id}
    Set Test Variable    ${xpath_to_field}    ${at_form_frmRegisterTrialUser}
    ${email}=    Set Variable    ${mailbox['email_addr']}
    Set '${email}' to field 'Email Address'
    Set '${temporary_pass}' to field 'Password'
    Set '${temporary_pass}' to field 'Confirm Password'
    Set 'First Robot' to field 'First Name'
    Set 'Last Robot' to field 'Last Name'
    Set '1234567890' to field 'Phone Number'

Profile information and registration information are equal
    Clicks 'My Profile'
    sleep    3
    ${first_name}=    Get Element Attribute    ${at_ManageProfile_FirstName}@value
    ${last_name}=    Get Element Attribute    ${at_ManageProfile_LastName}@value
    ${phone_number}=    Get Element Attribute    ${at_ManageProfile_PhoneNumber}@value
    Page Should Contain Element    ${dsg_ManageProfile_Label_EmailAddress_locator}//div[text()[normalize-space()="${mailbox['email_addr']}"]]
    Should Be Equal    ${first_name}    &{value_field}[First Name]
    Should Be Equal    ${last_name}    &{value_field}[Last Name]
    Should Be Equal    ${phone_number}    &{value_field}[Phone Number]

The user click on the link ‘Or Use Account ID’
    Comment    Scroll To Element    ${dsg_Registration_Link_UseAccountId_locator}
    Comment    Highlight Element    ${dsg_Registration_Link_UseAccountId_locator}
    Click Element    ${dsg_Registration_Link_UseAccountId_locator}

The user fills field 'Asset Number'
    Comment    Set Test Variable    &{id_field}    &{contact_information_field_id}
    Set '${LICENSE_NUMBER}' to field 'Asset Number'
    sleep    2
