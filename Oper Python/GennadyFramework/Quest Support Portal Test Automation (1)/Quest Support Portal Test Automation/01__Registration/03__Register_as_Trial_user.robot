*** Settings ***
Suite Setup       Global Setup
Test Teardown     Close Working Session
Force Tags        registration
Resource          ../Resources/Commons.robot
Resource          SuiteRegistration_Keywords_Resources.robot

*** Variables ***
&{requered_field_local_old}    ${dsg_Registration_Label_ProductId_Title}=Product    ${dsg_Registration_Label_EmailAddress_Title}=EmailAddress    ${dsg_Registration_Label_FirstName_Title}=FirstName    ${dsg_Registration_Label_LastName_Title}=LastName    ${dsg_Registration_Label_Company_Title}=Company    ${dsg_Registration_Label_PhoneNumber_Title}=PhoneNumber    ${dsg_Registration_Label_Address1_Title}=Address1
...               ${dsg_Registration_Label_PostalCode_Title}=PostalCode    ${dsg_Registration_Label_City_Title}=City    ${dsg_Registration_Label_Country_Title}=Country
&{requered_field_local}    ${dsg_Registration_Label_ProductId_Title}=ProductId    ${dsg_Registration_Label_EmailAddress_Title}=EmailAddress    ${dsg_Registration_Label_Password}=Password    ${dsg_Registration_Label_FirstName_Title}=FirstName    ${dsg_Registration_Label_LastName_Title}=LastName    ${dsg_Registration_Label_Company_Title}=Company    ${dsg_Registration_Label_PhoneNumber_Title}=PhoneNumber
...               ${dsg_Registration_Label_Address1}=Address1    ${dsg_Registration_Label_PostalCode_Title}=PostalCode    ${dsg_Registration_Label_City_Title}=City    ${dsg_Registration_Label_Country_Title}=Country

*** Test Cases ***
Register As Trial User
    [Tags]    C220
    [Setup]    Prepare Mailbox
    GIVEN An anonymous user on the Registration page
    WHEN The user click on the link ‘Register Trial Product’
    THEN The user on the page ‘Create a Support Account With A Trial Product’
    WHEN The user selects the test product in the product selector
    AND fills contact information
    AND clicks the button 'Create Account'
    THEN account has been created
    AND the user receives email with temporary password
    Comment    WHEN the user sign in with temporary password
    WHEN the user performs verification
    THEN the user on the Welcome page
    Comment    AND Creates new password
    AND the user is logged
    AND profile information and registration information are equal
    AND My Products page contains correct product information

Check link SignIn from email with password
    [Tags]    C222
    [Setup]    Prepare Mailbox
    GIVEN An anonymous user on the Registration page
    WHEN The user click on the link ‘Register Trial Product’
    THEN The user on the page ‘Create a Support Account With A Trial Product’
    WHEN The user selects the test product in the product selector
    AND fills contact information
    AND clicks the button 'Create Account'
    THEN account has been created
    AND the user receives email with temporary password
    WHEN the user navigates to email link "Quest Software Sign In"
    Comment    THEN the user on the page Create New Password
    Comment    WHEN the user creates new password
    THEN the user is logged

Register As Trial User - Validations
    [Tags]    C213
    [Setup]    Prepare Mailbox
    ${email}=    Set Variable    ${mailbox['email_addr']}
    log    ${email}
    GIVEN An anonymous user on the Registration page
    WHEN The user click on the link ‘Register Trial Product’
    THEN The user on the page ‘Create a Support Account With A Trial Product’
    WHEN the user scrolls down the page
    AND clicks the button 'Create Account'
    THEN the user receives an error on the page
    WHEN the user selects the test product in the product selector
    AND the user scrolls down the page
    AND clicks the button 'Create Account'
    THEN the user receives an error on the page
    WHEN the user sets '${email}' to field 'Email Address'
    AND the user sets '${temporary_pass}' to field 'Password'
    AND the user sets '${temporary_pass}' to field 'Confirm Password'
    Comment    AND the user scrolls down the page
    Comment    AND clicks the button 'Create Account'
    Comment    THEN the user receives an error on the page
    AND the user sets 'Last Robot' to field 'Last Name'
    Comment    AND the user scrolls down the page
    Comment    AND clicks the button 'Create Account'
    Comment    THEN the user receives an error on the page
    AND the user sets 'Company Robot' to field 'Company'
    Comment    AND the user scrolls down the page
    Comment    AND clicks the button 'Create Account'
    Comment    THEN the user receives an error on the page
    AND the user sets '1234567890' to field 'Phone Number'
    Comment    AND the user scrolls down the page
    Comment    AND clicks the button 'Create Account'
    Comment    THEN the user receives an error on the page
    AND the user sets 'Address Company Robot' to field 'Address 1'
    Comment    AND the user scrolls down the page
    Comment    AND clicks the button 'Create Account'
    Comment    THEN the user receives an error on the page
    Comment    AND the user sets '10' to field 'Suite/Unit Number'
    Comment    AND the user scrolls down the page
    Comment    AND clicks the button 'Create Account'
    Comment    THEN the user receives an error on the page
    AND the user sets '11111' to field 'Postal Code'
    Comment    AND the user scrolls down the page
    Comment    AND clicks the button 'Create Account'
    Comment    THEN the user receives an error on the page
    AND the user sets 'City Robot' to field 'City'
    Comment    AND the user scrolls down the page
    Comment    AND clicks the button 'Create Account'
    Comment    THEN the user receives an error on the page
    AND the user selects 'United States' in the 'Country' selector
    AND the user scrolls down the page
    AND clicks the button 'Create Account'
    THEN the user receives an error on the page
    WHEN the user sets 'First Robot' to field 'First Name'
    Comment    AND the user scrolls down the page
    Comment    AND clicks the button 'Create Account'
    Comment    THEN the user receives an error on the page
    AND the user selects 'Albania' in the 'Country' selector
    AND the user scrolls down the page
    AND clicks the button 'Create Account'
    THEN account has been created
    AND the user receives email with temporary password
    WHEN the user performs verification
    THEN the user on the Welcome page
    Comment    WHEN the user sign in with temporary password
    Comment    AND Creates new password
    AND the user is logged
    AND profile information and registration information are equal
    AND My Products page contains correct product information

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
    Set 'Company Robot' to field 'Company'
    Set '1234567890' to field 'Phone Number'
    Set 'Address Company Robot' to field 'Address 1'
    Comment    Set 'Address Company Robot' to field 'Address'
    Comment    Set '10' to field 'Suite/Unit Number'
    Set '11111' to field 'Postal Code'
    Set 'City Robot' to field 'City'
    Select 'United States' in the 'Country' selector
    Select 'Alaska' in the 'State' selector

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

The user click on the link ‘Register Trial Product’
    Comment    Scroll To Element    ${at_link_trial_product}
    Comment    Highlight Element    ${at_link_trial_product}
    Click Element    ${at_link_trial_product}

The user receives an error on the page
    sleep    1
    ${msg_re}=    Generate RegExp Error Message    ${at_form_frmRegisterTrialUser}    [0-9]{1,} item[s]* need[s]* attention    attributeName_forMsg=title    &{requered_field_local}
    ${countErrorFields}=    Evaluate    '${msg_re}'.count('\\s*\\|*') + 1
    ${str}=    Set Variable IF    "${msg_re}"!="${EMPTY}" and ${countErrorFields}>1    ${countErrorFields} items need attention    "${msg_re}"!="${EMPTY}" and ${countErrorFields}==1    1 item needs attention    ${EMPTY}
    Pass Test If Alert    ${msg_re}    ${str}

The user scrolls down the page
    Scroll To Element    ${xpath_to_field}${dsg_Registration_Button_CreateAccount_locator}

The user sets '${value}' to field '${fieldName}'
    Set '${value}' to field '${fieldName}'

The user selects '${value}' in the '${nameSelector}' selector
    Select '${value}' in the '${nameSelector}' selector
    Run Keyword IF    '${value}'=='United States' and '${nameSelector}'=='Country'    Set To Dictionary    ${requered_field_local}    ${dsg_Registration_Label_State_Title}=State
    Run Keyword IF    '${value}'!='United States' and '${nameSelector}'=='Country'    Remove From Dictionary    ${requered_field_local}    ${dsg_Registration_Label_State_Title}
    Comment    log many    ${requered_field_local}
