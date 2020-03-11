*** Settings ***
Resource          ../Resources/Commons.robot
Resource          ../Resources/Locators/SignIn_Page_Locators.robot
Resource          ../Resources/SignIn_Page_Resources.robot
Resource          ../Resources/Locators/KB_Page_Locators.robot
Resource          ../Resources/KB_Page_Resources.robot
Resource          ../Resources/ProductAZ_Page_Resources.robot
Resource          ../02__Login/SuiteLogin_Keywords_Resources.robot

*** Variables ***
@{list_account}
&{list_doc}

*** Keywords ***
Prepare Account
    Append To List    ${list_account}    ${EXTERNAL_ACCOUNT}
    Append To List    ${list_account}    ${EXTERNAL_ACCOUNT_TEMP}

An anonymous user on the Knowledge Base page
    Open KB Page

The user selects product '${name_product}' in the ‘Select your product to list Technical Documentation’ selector
    Select Product in Product Search element    ${name_product}

The user selects the test product in the ‘Select your product to search Knowledge Base’ selector
    Select Product in Product Search element    ${TEST_PRODUCT}

The user types a name of test product in the ‘Enter your product to find support’ selector
    the user selects product '${TEST_PRODUCT}' in the ‘Enter your product to find support’ selector

The user on the ‘Knowledge Base’ page of the '${product_name}' product
    Active page should be the Knowledge Base page for the '${product_name}' product
    sleep    2
    Close Chat    ${at_chat}
    Close Popup    ${at_popup_opinion}

The user on the ‘Knowledge Base’ page of the test product
    The user on the ‘Knowledge Base’ page of the '${TEST_PRODUCT}' product

The user selects the '${name_document}' document
    ${locator}=    Prepare Locator To JS    ${list_articles}//a[text()[contains(., "${name_document}")]]
    ${count_links}=    Get Matching Xpath Count    ${locator}
    Run Keyword IF    ${count_links}==0    Capture Page Screenshot
    Run Keyword IF    ${count_links}==0    Fail    The list of Knowledge Base does not contain the document "${name_document}"    invalidTestData
    Scroll To Element    ${locator}
    Highlight Element    ${locator}
    ${link_doc}=    Execute Javascript    return window.document.evaluate("${locator}/@href", document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue.value
    Set To Dictionary    ${list_doc}    ${name_document}=${link_doc}
    Click link    ${locator}

The user on the page of the '${name_document}' document
    ${url_doc}=    Set Variable    ${list_doc['${name_document}']}
    Wait Until Page Contains Element    xpath=//h1[@id="LayoutH1"]
    ${part_of_link}=    Get Regexp Matches    ${url_doc}    /kb/[0-9]*/
    ${part_of_link}=    Run Keyword IF    "${part_of_link}"!="${EMPTY}" and "${part_of_link}"!="[]"    Evaluate    ${part_of_link}[0]
    ...    ELSE    Set Variable    ${EMPTY}
    Location Should Contain    ${part_of_link}

Authentication is required
    ${locator}=    Prepare Locator To JS    ${kbContent_locator}
    ${message_text}=    Execute Javascript    return window.document.evaluate("${locator}", document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue.innerHTML
    ${message_text}=    Replace String Using Regexp    ${message_text}    <!--.*-->    ${EMPTY}
    ${message_text}=    Replace String Using Regexp    ${message_text}    <\\s+\/    </
    ${dsg_var}=    Replace String Using Regexp    ${dsg_KbArticle_AuthenticationRequired}    <!--.*-->    ${EMPTY}
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
    ${locator}=    Prepare Locator To JS    ${kbContent_locator}
    ${message_text}=    Execute Javascript    return window.document.evaluate("${locator}", document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue.innerHTML
    ${message_text}=    Replace String Using Regexp    ${message_text}    <!--.*-->    ${EMPTY}
    ${message_text}=    Replace String Using Regexp    ${message_text}    <\\s+\/    </
    ${dsg_var}=    Replace String Using Regexp    ${dsg_Documents_EntitlementRequired}    <!--.*-->    ${EMPTY}
    ${dsg_var}=    Replace String Using Regexp    ${message_text}    <\\s+\/    </
    Should Contain    ${message_text}    ${dsg_var}

Click 'Sign In Now'
    ${locator}=    Prepare Locator To JS    ${kbContent_locator}//a[@class[starts-with(., "btn btn-primary")]]
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

the user types '${search_value}' in the ‘Search Knowledge Base by keyword’ input
    ${locator}=    Set Variable    ${input_txtKbAutoCompleteKeyword}
    JS Set Value To Input    ${locator}    ${search_value}

Clicks on icon 'Search'
    Highlight Element    ${search_button}
    Click Element    ${search_button}

the result set contains articles with the value '${search_value}'
    ${locator}=    Prepare Locator To JS    ${list_articles}//*[self::p or self::a][text()[contains(., '${search_value}')]]
    Wait Until Element is Visible    ${form_KBSearch}
    Comment    ${count_not_highlight}=    Get Matching Xpath Count    ${search_results_articles}/p//*[text()[contains(., "${value}")]][not(@style="background-color:yellow") and not(@style="background-color: yellow;")]
    Comment    ${count_highlight}=    Get Matching Xpath Count    ${search_results_articles}/p//*[text()[contains(., "${value}")]][@style="background-color:yellow" or @style="background-color: yellow;"]
    ${count_found_text}=    Get Matching Xpath Count    ${locator}
    Comment    ${count_articles}=    Get Matching Xpath Count    ${search_results_articles}
    Run Keyword IF    ${count_found_text}==0    Capture Page Screenshot
    Run Keyword IF    ${count_found_text}==0    Fail    Results do not contain search text '${search_value}'
    Comment    Run Keyword IF    ${count_not_highlight}>0 or ${count_highlight}!=${count_found_text} or ${count_articles}>${count_found_text}    Capture Page Screenshot
    Comment    Run Keyword IF    ${count_not_highlight}>0 or ${count_highlight}!=${count_found_text}    Fail    Has been found not highlighted search text '${value}'
    Comment    Run Keyword IF    ${count_articles}>${count_found_text}    Fail    Have been found articles that not contain search text '${value}'

the search by the value '${search_value}' completed
    ${val}=    Set Variable    /kb?k=${search_value}
    Wait Until Element Is Enabled    ${form_KBSearch}
    Location Should Contain    ${val}
