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
${redirect_url}    ${EMPTY}

*** Test Cases ***
User sends a request product information form
    [Setup]    Prepare Environment
    [Tags]    C44
    Skip the rest of the test case for the following configurations    iPhone_6    iPadAir_2    IE
    GIVEN an anonymous user on the Contact Support page
    WHEN the user selects 'Request product information' in the Customer Service Request selector
    THEN the user on the 'Request product information' page
    WHEN the user selects 'vRanger' in the field 'Product'
    THEN the modal window 'Welcome to Quest Support' appears
    WHEN the user clicks 'Continue' button of modal window
    THEN the user redirects on a new tab to the page 'Contact Sales' of product 'vRanger'

*** Keywords ***
The user selects 'Request product information' in the Customer Service Request selector
    JS Select Item of DropDown List    ${CustomerServiceRequest_locator}    ${dsg_ContactUs_Category_4_DisplayName}

Prepare Environment
    Set Test Variable    &{id_field}    &{contactInformation_field}
    Set Test Variable    &{value_field}    &{contactInformation_value}
    Set Test Variable    ${xpath_to_field}    ${at_ContactFormPlaceholder}

The user selects '${name_product}' in the field '${name_field}'
    ${locator}=    Replace String    ${at_ContactFormPlaceholder}    "    '
    ${locator}=    Replace String    ${locator}    xpath=    ${EMPTY}
    ${locator}=    Set Variable    ${locator}//select[@id='&{id_field}[${name_field}]']/option[text()[normalize-space()='${name_product}']]
    Wait Until Element Is Enabled    ${at_ContactFormPlaceholder}//select[@id="&{id_field}[${name_field}]"]
    ${is_attribute}=    Get Matching Xpath Count    ${locator}[@data-url]
    ${redirect_url}=    Run Keyword IF    ${is_attribute}==1    Execute Javascript    return window.document.evaluate("${locator}/@data-url", document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue.value
    Set Test Variable    ${redirect_url}
    The user selects '${name_product}' in the '${name_field}' selector

The user redirects on a new tab to the page 'Contact Sales' of product '${value}'
    ${product_url}=    Replace String Using Regexp    ${value}    \\s+    -
    ${locale}=    Evaluate    ("" if "${LOCALE}".lower()=="en-us" else "/${LOCALE}".lower())
    Comment    ${url}=    Evaluate    ("${SUPPORT_STAGE2_SITE}${locale}/${product_url}/professional-services").lower()
    sleep    10
    Select Window    url=${redirect_url}
