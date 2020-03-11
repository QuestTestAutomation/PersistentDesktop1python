*** Settings ***
Suite Setup       Global Setup
Test Teardown     Close Working Session
Resource          ../Resources/ContactSupport_Page_Resources.robot
Resource          ../Resources/Commons.robot
Resource          ContactForms_Keywords_Resources.robot
Resource          ../01__Registration/SuiteRegistration_Keywords_Resources.robot

*** Variables ***
&{requered_field_local}    Product=SelectedProductId    Business Email=ContactEmailAddress    First Name=ContactFirstName    Last Name=ContactLastName    Company Name=ContactCompanyName    New License Number=NewLicenseNumber
&{contactInformation_field}    Business Email=ContactEmailAddress    First Name=ContactFirstName    Last Name=ContactLastName    Company Name=ContactCompanyName    New License Number=NewLicenseNumber    Product=SelectedProductId
&{contactInformation_value}    Business Email=${EMPTY}    First Name=${EMPTY}    Last Name=${EMPTY}    Company Name=${EMPTY}    New License Number=${EMPTY}    Product=${EMPTY}

*** Test Cases ***
User sends a renewals assistance form
    [Setup]    Prepare Environment
    [Tags]    C74
    GIVEN an anonymous user on the Contact Support page
    WHEN the user selects 'Renewals Assistance' in the Customer Service Request selector
    THEN the user on the 'Renewals Assistance' page
    WHEN the user selects 'Foglight' in the 'Product' selector
    AND If 'Product Alert' modal window is appeared the user clicks on the 'Continue' button
    AND fills contact information
    AND clicks the button 'Submit Request'
    THEN the user reseives messages 'Your request has been sent successfully'

User sends a renewals assistance form - Validations
    [Setup]    Prepare Environment
    Comment    GIVEN an anonymous user on the main page of Support Portal
    Comment    WHEN the user selects 'Contact Support' in the 'Support' menu
    Comment    THEN The user on the Contact Support page
    GIVEN an anonymous user on the Contact Support page
    WHEN the user selects 'Renewals Assistance' in the Customer Service Request selector
    THEN the user on the 'Renewals Assistance' page
    WHEN the user scrolls down the page
    AND clicks the button 'Submit Request'
    THEN the user receives an error on the page
    WHEN the user selects 'Foglight' in the 'Product' selector
    AND If 'Product Alert' modal window is appeared the user clicks on the 'Continue' button
    AND the user fills requered filds
    AND clicks the button 'Submit Request'
    THEN the user reseives messages 'Your request has been sent successfully'

*** Keywords ***
Fills contact information
    Wait Until Page Contains Element    ${xpath_to_field}
    Set '${email}' to field 'Business Email'
    Set 'First Robot' to field 'First Name'
    Set 'Last Robot' to field 'Last Name'
    Set 'Company Robot' to field 'Company Name'
    log    ${LICENSE_NUMBER}
    Set '${LICENSE_NUMBER}' to field 'New License Number'

The user selects 'Renewals Assistance' in the Customer Service Request selector
    JS Select Item of DropDown List    ${CustomerServiceRequest_locator}    ${dsg_ContactUs_Category_2_DisplayName}

The user receives an error on the page
    ${msg_re}=    Generate RegExp Error Message    ${at_ContactFormPlaceholder}    ${dsg_Validation_Attention_Multi}    attributeName_forMsg=data-val-displayname    &{requered_field_local}
    Pass Test If Alert    ${msg_re}    ${dsg_Validation_Attention_Multi}

Prepare Environment
    Prepare Mailbox
    Set Test Variable    &{id_field}    &{contactInformation_field}
    Set Test Variable    &{value_field}    &{contactInformation_value}
    Set Test Variable    ${xpath_to_field}    ${at_ContactFormPlaceholder}
    Set Test Variable    ${email}    ${mailbox['email_addr']}
    Set Test Variable    &{requered_field}    &{requered_field_local}

The user fills requered filds
    Set '${email}' to field 'Business Email'
    Set 'First Robot' to field 'First Name'
    Set 'Last Robot' to field 'Last Name'
    Set 'Company Robot' to field 'Company Name'
    log    ${LICENSE_NUMBER}
    Set '${LICENSE_NUMBER}' to field 'New License Number'
