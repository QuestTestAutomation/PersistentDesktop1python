*** Settings ***
Suite Setup       Global Setup
Test Teardown     Close Working Session
Resource          ../Resources/ContactSupport_Page_Resources.robot
Resource          ../Resources/Commons.robot
Resource          ContactForms_Keywords_Resources.robot
Resource          ../01__Registration/SuiteRegistration_Keywords_Resources.robot

*** Variables ***
&{requered_field_local}    Product=SelectedProductId    Business Email=Email    First Name=FirstName    Last Name=LastName    Company Name=CompanyName    Address=Address    Postal Code=PostalCode
...               City=City    Country=Country    Request Details=RequestDetails
&{contactInformation_field}    Business Email=Email    First Name=FirstName    Last Name=LastName    Company Name=CompanyName    Address=Address    Address 2=Address2    Postal Code=PostalCode
...               City=City    Country=Country    State=State    Request Details=RequestDetails    Product=SelectedProductId
&{contactInformation_value}    Business Email=${EMPTY}    First Name=${EMPTY}    Last Name=${EMPTY}    Company Name=${EMPTY}    Address=${EMPTY}    Address 2=${EMPTY}    Postal Code=${EMPTY}
...               City=${EMPTY}    Country=${EMPTY}    State=${EMPTY}    Request Details=${EMPTY}    Product=${EMPTY}

*** Test Cases ***
User sends a training assistance form
    [Setup]    Prepare Environment
    [Tags]    C62
    Skip the rest of the test case for the following configurations    Samsung_GalaxyS6
    GIVEN an anonymous user on the Contact Support page
    WHEN the user selects 'Training Assistance' in the Customer Service Request selector
    THEN the user on the 'Training Assistance' page
    WHEN the user selects 'Toad for Oracle' in the 'Product' selector
    AND If 'Product Alert' modal window is appeared the user clicks on the 'Continue' button
    AND fills contact information
    AND clicks the button 'Submit Request'
    THEN the user reseives messages 'Your request has been sent successfully'

User sends a training assistance form - Validations
    [Setup]    Prepare Environment
    [Tags]    C53
    Skip the rest of the test case for the following configurations    Samsung_GalaxyS6
    Comment    GIVEN an anonymous user on the main page of Support Portal
    Comment    WHEN the user selects 'Contact Support' in the 'Support' menu
    Comment    THEN The user on the Contact Support page
    GIVEN an anonymous user on the Contact Support page
    WHEN the user selects 'Training Assistance' in the Customer Service Request selector
    THEN the user on the 'Training Assistance' page
    WHEN the user scrolls down the page
    AND clicks the button 'Submit Request'
    THEN the user receives an error on the page
    WHEN the user selects the test product in the 'Product' selector
    AND If 'Product Alert' modal window is appeared the user clicks on the 'Continue' button
    WHEN the user fills requered filds
    AND clicks the button 'Submit Request'
    THEN the user reseives messages 'Your request has been sent successfully'

*** Keywords ***
Fills contact information
    Wait Until Page Contains Element    ${xpath_to_field}
    Set '${email}' to field 'Business Email'
    Set 'First Robot' to field 'First Name'
    Set 'Last Robot' to field 'Last Name'
    Set 'Company Robot' to field 'Company Name'
    Set 'Address Company Robot' to field 'Address'
    Set 'Address 2 Robot' to field 'Address 2'
    Set '11111' to field 'Postal Code'
    Set 'City Robot' to field 'City'
    Select 'United States' in the 'Country' selector
    Select 'Alaska' in the 'State' selector
    Set 'My Request Details' to field 'Request Details'

The user selects 'Training Assistance' in the Customer Service Request selector
    JS Select Item of DropDown List    ${CustomerServiceRequest_locator}    ${dsg_ContactUs_Category_1_DisplayName}

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
    Set 'Address Company Robot' to field 'Address'
    Set '11111' to field 'Postal Code'
    Set 'City Robot' to field 'City'
    Select 'Afghanistan' in the 'Country' selector
    Set 'My Request Details' to field 'Request Details'
