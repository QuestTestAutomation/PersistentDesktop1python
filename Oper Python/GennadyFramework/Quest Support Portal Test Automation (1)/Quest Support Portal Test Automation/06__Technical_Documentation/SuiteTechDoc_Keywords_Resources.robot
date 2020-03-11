*** Settings ***
Resource          ../Resources/Commons.robot
Resource          ../Resources/Locators/SignIn_Page_Locators.robot
Resource          ../Resources/SignIn_Page_Resources.robot
Resource          ../Resources/Locators/TechDoc_Page_Locators.robot
Resource          ../Resources/TechDoc_Page_Resources.robot
Resource          ../Resources/ProductAZ_Page_Resources.robot
Resource          ../02__Login/SuiteLogin_Keywords_Resources.robot

*** Variables ***
@{list_account}
&{list_doc}

*** Keywords ***
Prepare Account
    Append To List    ${list_account}    ${EXTERNAL_ACCOUNT}
    Append To List    ${list_account}    ${EXTERNAL_ACCOUNT_TEMP}

An anonymous user on the Technical Documentation page
    Open TechDoc Page

The user selects product '${name_product}' in the ‘Select your product to list Technical Documentation’ selector
    Select Product in Product Search element    ${name_product}

The user selects the test product in the ‘Select your product to list Technical Documentation’ selector
    Select Product in Product Search element    ${TEST_PRODUCT}

The user types a name of test product in the ‘Enter your product to find support’ selector
    the user selects product '${TEST_PRODUCT}' in the ‘Enter your product to find support’ selector

The user on the ‘Technical Documentation’ page of the '${product_name}' product
    Active page should be the Technical Documentation page for the '${product_name}' product
    sleep    2
    Close Chat    ${at_chat}
    Close Popup    ${at_popup_opinion}

The user on the ‘Technical Documentation’ page of the test product
    The user on the ‘Technical Documentation’ page of the '${TEST_PRODUCT}' product

The user changes version on '${version}'
    Select version '${version}'

The available documentation for version appear
    sleep    3
    Wait Until Element is Enabled    ${download_table_locator}
    Close Popup    ${at_popup_opinion}

The user selects the '${name_document}' document
    ${locator}=    Prepare Locator To JS    ${download_table_locator}//tbody//a[text()[contains(., "${name_document}")]]
    ${count_links}=    Get Matching Xpath Count    ${locator}
    Run Keyword IF    ${count_links}==0    Capture Page Screenshot
    Run Keyword IF    ${count_links}==0    Fail    Technical Documentation does not contain the document "${name_document}"    invalidTestData
    Scroll To Element    ${locator}
    Highlight Element    ${locator}
    ${link_doc}=    Execute Javascript    return window.document.evaluate("${locator}/@href", document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue.value
    Set To Dictionary    ${list_doc}    ${name_document}=${link_doc}
    Click link    ${locator}

The user on the page of the '${name_document}' document
    ${url_doc}=    Set Variable    ${list_doc['${name_document}']}
    Wait Until Page Contains Element    xpath=//h1[@id="LayoutH1"]
    Location Should Contain    ${url_doc}

Authentication is required
    ${locator}=    Prepare Locator To JS    ${bookContent_locator}
    ${message_text}=    Execute Javascript    return window.document.evaluate("${locator}", document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue.innerHTML
    ${message_text}=    Replace String Using Regexp    ${message_text}    <!--.*-->    ${EMPTY}
    ${message_text}=    Replace String Using Regexp    ${message_text}    <\\s+\/    </
    ${dsg_var}=    Replace String Using Regexp    ${dsg_Documents_AuthenticationRequired}    <!--.*-->    ${EMPTY}
    ${dsg_var}=    Replace String Using Regexp    ${message_text}    <\\s+\/    </
    Should Contain    ${message_text}    ${dsg_var}

the user logs in as '${email}'
    ${account}=    Evaluate    next((item for item in @{list_account} if item.get('email')=='${email}'), None)
    Run Keyword if    "${account}" is "${None}"    FAIL    The account '${email}' has not defined
    Comment    The user sign in
    Click 'Sign In Now'
    SignIn    ${account['email']}    ${account['password']}
    sleep    3

entitlement is required
    ${locator}=    Prepare Locator To JS    ${bookContent_locator}
    ${message_text}=    Execute Javascript    return window.document.evaluate("${locator}", document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue.innerHTML
    ${message_text}=    Replace String Using Regexp    ${message_text}    <!--.*-->    ${EMPTY}
    ${message_text}=    Replace String Using Regexp    ${message_text}    <\\s+\/    </
    ${dsg_var}=    Replace String Using Regexp    ${dsg_Documents_EntitlementRequired}    <!--.*-->    ${EMPTY}
    ${dsg_var}=    Replace String Using Regexp    ${message_text}    <\\s+\/    </
    Should Contain    ${message_text}    ${dsg_var}

Click 'Sign In Now'
    ${locator}=    Prepare Locator To JS    ${bookContent_locator}//div[@style[contains(., 'display: inline-block')]]//a[@class[contains(., 'btn-primary')]]
    ${count_link}=    Get Matching Xpath Count    ${locator}
    Run Keyword IF    ${count_link}==0    Capture Page Screenshot
    Run Keyword IF    ${count_link}==0    Fail    Cannot find the 'Sign In Now' link
    Scroll To Element    ${locator}
    Highlight Element    ${locator}
    Click link    ${locator}

Full content of the article is shown
    Wait Until Page Contains Element    ${bookContent_locator}[.//*[@id[starts-with(., 'TOPIC-')]]]

The user clicks "See All Products"
    Wait Until Page Contains Element    ${seeAllProducts_locator}
    ${locator}=    Prepare Locator To JS    ${seeAllProducts_locator}
    Scroll To Element    ${locator}
    Highlight Element    ${locator}
    Focus    ${seeAllProducts_locator}
    Click Element    ${seeAllProducts_locator}

The user on the products a-z page
    Active page should be Products a-z page

The user clicks on the download link ${num_link}
    Scroll To Element    ${downloadPdf_links}[${num_link}]
    Highlight Element    ${downloadPdf_links}[${num_link}]
    Click link    ${downloadPdf_links}[${num_link}]

The user on 'Sign In' page
    Active page should be Sign In

The '${email}' user logged into portal
    ${account}=    Evaluate    next((item for item in @{list_account} if item.get('email')=='${email}'), None)
    Run Keyword if    "${account}"=="${None}"    Fail    The test does not contain definition for account '${email}'
    SignIn    ${account['email']}    ${account['password']}
    Comment    SignIn    &{EXTERNAL_ACCOUNT}[email]    &{EXTERNAL_ACCOUNT}[password]
    sleep    3
    The user is logged
