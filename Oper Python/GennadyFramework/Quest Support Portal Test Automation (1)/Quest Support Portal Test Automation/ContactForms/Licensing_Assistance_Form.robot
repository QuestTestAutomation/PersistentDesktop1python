*** Settings ***
Suite Setup       Global Setup
Test Teardown     Close Working Session
Resource          ../Resources/ContactSupport_Page_Resources.robot
Resource          ../Resources/Commons.robot
Resource          ContactForms_Keywords_Resources.robot
Resource          ../01__Registration/SuiteRegistration_Keywords_Resources.robot

*** Variables ***
&{requered_field_local}    Business Email=EmailAddress    Contact First Name=ContactFirstName    Contact Last Name=ContactLastName    Company Name=CompanyName    Country=Country    License Request Details=LicenseRequestDetails
&{contactInformation_field}    Business Email=EmailAddress    Contact First Name=ContactFirstName    Contact Last Name=ContactLastName    Company Name=CompanyName    Country=Country    Phone Number=PhoneNumber    Product=Product
...               Product Version=ProductVersion    License Number=LicenseNumber    License Key=LicenseKey    Machine ID=MachineId    License Request Details=LicenseRequestDetails    License File=fileName
&{contactInformation_value}    Business Email=${EMPTY}    Contact First Name=${EMPTY}    Contact Last Name=${EMPTY}    Company Name=${EMPTY}    Country=${EMPTY}    Phone Number=${EMPTY}    Product=${EMPTY}
...               Product Version=${EMPTY}    License Number=${EMPTY}    License Key=${EMPTY}    Machine ID=${EMPTY}    License Request Details=${EMPTY}    License File=${EMPTY}

*** Test Cases ***
User sends a licensing assistance form
    [Setup]    Prepare Environment
    [Tags]    C43
    Skip the rest of the test case for the following configurations    iPhone_6    iPadAir_2
    GIVEN an anonymous user on the Contact Support page
    WHEN the user selects 'Licensing Assistance' in the Customer Service Request selector
    THEN the user on the 'Licensing Assistance' page
    WHEN the user selects the test product in the 'Product' selector
    AND If 'Product Alert' modal window is appeared the user clicks on the 'Continue' button
    AND the user selects test version in the product version selector
    AND fills contact information
    Comment    AND describes service request details
    AND fills captcha
    AND clicks the button 'Next'
    THEN the user on the page KB Articles that may match the issue
    WHEN the user clicks on the button 'Submit Licensing Request'
    THEN the user reseives messages 'Your request has been sent successfully'
    AND the user receives email with confirmation service request

User sends a request licensing assistance form - Validations
    [Setup]    Prepare Environment
    [Tags]    C80
    Skip the rest of the test case for the following configurations    iPhone_6    iPadAir_2
    Comment    GIVEN an anonymous user on the main page of Support Portal
    Comment    WHEN the user selects 'Contact Support' in the 'Support' menu
    Comment    THEN The user on the Contact Support page
    GIVEN an anonymous user on the Contact Support page
    WHEN the user selects 'Licensing Assistance' in the Customer Service Request selector
    THEN the user on the 'Licensing Assistance' page
    WHEN the user selects the test product in the 'Product' selector
    AND If 'Product Alert' modal window is appeared the user clicks on the 'Continue' button
    AND the user selects test version in the product version selector
    AND scrolls down the page
    AND clicks the button 'Next'
    THEN the user receives an error on the page
    WHEN the user fills requered filds
    AND fills captcha
    AND clicks the button 'Next'
    THEN the user on the page KB Articles that may match the issue
    WHEN the user clicks on the button 'Submit Licensing Request'
    THEN the user reseives messages 'Your request has been sent successfully'
    AND the user receives email with confirmation service request

*** Keywords ***
Fills contact information
    Wait Until Page Contains Element    ${xpath_to_field}
    Set '${email}' to field 'Business Email'
    Set 'First Robot' to field 'Contact First Name'
    Set 'Last Robot' to field 'Contact Last Name'
    Set 'Company Robot' to field 'Company Name'
    Select 'United States' in the 'Country' selector
    Set '1234567890' to field 'Phone Number'
    log    ${LICENSE_NUMBER}
    Set '${LICENSE_NUMBER}' to field 'License Number'
    Set '11111' to field 'License Key'
    Set '11111' to field 'Machine ID'
    Set text 'My License Request Details' to field 'License Request Details'

The user selects 'Licensing Assistance' in the Customer Service Request selector
    JS Select Item of DropDown List    ${CustomerServiceRequest_locator}    ${dsg_ContactUs_Category_11_DisplayName}

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
    Set 'First Robot' to field 'Contact First Name'
    Set 'Last Robot' to field 'Contact Last Name'
    Set 'Company Robot' to field 'Company Name'
    Select 'United States' in the 'Country' selector
    Set text 'My License Request Details' to field 'License Request Details'
