*** Settings ***
Suite Setup       Global Setup
Test Teardown     Close Working Session
Resource          ../Resources/ContactSupport_Page_Resources.robot
Resource          ../Resources/Commons.robot
Resource          ContactForms_Keywords_Resources.robot
Resource          ../01__Registration/SuiteRegistration_Keywords_Resources.robot

*** Variables ***
&{list_Topics}    Other=61    Access knowledge articles or documentation=60    Create a technical service request=35    Download software=33    Register for Support=31    Sign in or reset password=32    Update My Account=34
&{requered_field_local}    Descriptive Title=Title    Description of the Problem=Description    Full Name=FullName    Business Email=Email
&{contactInformation_field}    Business Email=Email    Full Name=FullName    Company Name=CompanyName    Address=Address    Postal Code=PostalCode    City=City    Country=Country
...               State=State    Descriptive Title=Title    Description of the Problem=Description    License Number=IdentificationNumber    Phone Number=PhoneNumber    Product=ProductBrand
&{contactInformation_value}    Business Email=${EMPTY}    Full Name=FullName    Company Name=${EMPTY}    Address=${EMPTY}    Postal Code=${EMPTY}    City=${EMPTY}    Country=${EMPTY}
...               State=${EMPTY}    Descriptive Title=${EMPTY}    Description of the Problem=${EMPTY}    License Number=${EMPTY}    Phone Number=${EMPTY}    Product=${EMPTY}

*** Test Cases ***
User sends a customer service form
    [Setup]    Prepare Environment
    [Tags]     C77
    Skip the rest of the test case for the following configurations    iPhone_6    iPadAir_2
    GIVEN an anonymous user on the Contact Support page
    WHEN the user selects 'Customer Service' in the Customer Service Request selector
    THEN the user on ‘Customer Service’ page
    WHEN the user selects 'Other' in the 'How can we help you?' selector
    AND the user selects the test product in the field 'Product'
    AND If 'Product Alert' modal window is appeared the user clicks on the 'Continue' button
    AND fills contact information
    AND describes service request details
    AND clicks the button 'Next'
    THEN the user on the page KB Articles that may match the issue
    AND fills captcha
    WHEN the user clicks on the button 'Submit Customer Service Request'
    THEN the user reseives messages 'Your request has been sent successfully'
    AND the user receives email with confirmation service request

User sends a customer service form - Validations
    [Setup]    Prepare Environment
    [Tags]    C73
    Skip the rest of the test case for the following configurations    iPhone_6    iPadAir_2
    Comment    GIVEN an anonymous user on the main page of Support Portal
    Comment    WHEN the user selects 'Contact Support' in the 'Support' menu
    Comment    THEN The user on the Contact Support page
    GIVEN an anonymous user on the Contact Support page
    WHEN the user selects 'Customer Service' in the Customer Service Request selector
    THEN the user on ‘Customer Service’ page
    WHEN the user selects 'Other' in the 'How can we help you?' selector
    AND the user selects the test product in the field 'Product'
    AND If 'Product Alert' modal window is appeared the user clicks on the 'Continue' button
    AND scrolls down the page
    AND clicks the button 'Next'
    THEN the user receives an error on the page
    WHEN the user fills requered filds
    AND clicks the button 'Next'
    THEN the user on the page KB Articles that may match the issue
    AND fills captcha
    WHEN the user clicks on the button 'Submit Customer Service Request'
    THEN the user reseives messages 'Your request has been sent successfully'
    AND the user receives email with confirmation service request

*** Keywords ***
Fills contact information
    Wait Until Page Contains Element    ${xpath_to_field}
    Set 'Full Name Robot' to field 'Full Name'
    Set '${email}' to field 'Business Email'
    Set '1234567890' to field 'Phone Number'
    Comment    Set 'Company Robot' to field 'Company Name'
    Comment    Set 'Address Company Robot' to field 'Address'
    Comment    Set '11111' to field 'Postal Code'
    Comment    Set 'City Robot' to field 'City'
    Comment    Select 'United States' in the 'Country' selector
    Comment    Select 'Alaska' in the 'State' selector

The user selects 'Customer Service' in the Customer Service Request selector
    Comment    ${dsg_var}=    Run Keyword IF    "${LOCALE}"=="ja-jp"    Replace String Using Regexp    ${dsg_ContactUs_Category_12_DisplayName}    [\\r\\n\\t]
    ...    ${EMPTY}
    ...    ELSE    Set Variable    ${Customer_Service}
    ${dsg_var}=    Replace String Using Regexp    ${dsg_ContactUs_Category_12_DisplayName}    [\\r\\n\\t]    ${EMPTY}
    JS Select Item of DropDown List    ${CustomerServiceRequest_locator}    ${dsg_var}
    Comment    JS Select Item of DropDown List    ${CustomerServiceRequest_locator}    ${dsg_ContactUs_Category_12_DisplayName}
    Comment    Select From List By Value    ${CustomerServiceRequest_locator}    12

The user selects '${value}' in the 'How can we help you?' selector
    ${number_value}=    Set Variable    &{list_Topics}[${value}]
    Run Keyword if    "${number_value}"=="${None}" or "${number_value}"=="${EMPTY}"    Fail    The value '${Value}' has not been defined
    Select From List By Value    ${dsg_ContactUs_Topic_locator}    ${number_value}

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
    Set 'My Descriptive Title' to field 'Descriptive Title'
    Set text 'My Description of the Problem' to field 'Description of the Problem'
    Set 'Full Name Robot' to field 'Full Name'
    Set '${email}' to field 'Business Email'

The user selects the test product in the field '${nameSelector}'
    Set Test Variable    ${xpath_to_field}    xpath=//div[@id='ContactFormPlaceholder']
    The user selects the test product in the '${nameSelector}' selector
    Set Test Variable    ${xpath_to_field}    ${at_ContactFormPlaceholder}
