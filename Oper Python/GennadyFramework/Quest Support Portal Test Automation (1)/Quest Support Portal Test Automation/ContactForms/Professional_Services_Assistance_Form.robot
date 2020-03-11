*** Settings ***
Suite Setup       Global Setup
Test Teardown     Close Working Session
Resource          ../Resources/ContactSupport_Page_Resources.robot
Resource          ../Resources/Commons.robot
Resource          ContactForms_Keywords_Resources.robot
Resource          ../01__Registration/SuiteRegistration_Keywords_Resources.robot

*** Variables ***
&{contactInformation_field}    Product=Product
&{contactInformation_value}    Product=${EMPTY}

*** Test Cases ***
User sends a professional services assistance form
    [Setup]    Prepare Environment
    [Tags]    C63
    Skip the rest of the test case for the following configurations    iPhone_6    iPadAir_2    IE
    GIVEN an anonymous user on the Contact Support page
    WHEN the user selects 'Professional Services Assistance' in the Customer Service Request selector
    THEN the user on the 'Professional Services Assistance' page
    WHEN the user selects 'Change Auditor' in the 'Product' selector
    THEN the modal window 'Welcome to Quest Support' appears
    WHEN the user clicks 'Continue' button of modal window
    THEN the user redirects on a new tab to the page 'Professional Services' of product 'Change Auditor'

*** Keywords ***
The user selects 'Professional Services Assistance' in the Customer Service Request selector
    JS Select Item of DropDown List    ${CustomerServiceRequest_locator}    ${dsg_ContactUs_Category_3_DisplayName}

The user clicks 'Continue' button of modal window
    Click Element    ${dsg_ProductSearch_modalBtnContinue_locator}

The user redirects on a new tab to the page 'Professional Services' of product '${value}'
    ${product_url}=    Replace String Using Regexp    ${value}    \\s+    -
    ${locale}=    Evaluate    ("" if "${LOCALE}".lower()=="en-us" else "/${LOCALE}".lower())
    ${url}=    Evaluate    ("${SUPPORT_STAGE2_SITE}${locale}/${product_url}/professional-services").lower()
    ${br}=    Convert To Lowercase    ${BROWSER}
    ${waiting}=    Set Variable IF    "${br}"=="firefox"    20    10
    sleep    ${waiting}
    ${location}=    Get location
    Select Window    url=${url}

Prepare Environment
    Set Test Variable    &{id_field}    &{contactInformation_field}
    Set Test Variable    &{value_field}    &{contactInformation_value}
    Set Test Variable    ${xpath_to_field}    ${at_ContactFormPlaceholder}
