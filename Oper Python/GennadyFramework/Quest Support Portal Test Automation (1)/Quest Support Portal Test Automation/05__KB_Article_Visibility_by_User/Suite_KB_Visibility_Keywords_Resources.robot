*** Settings ***
Resource          ../Resources/SignIn_Page_Resources.robot
Resource          ../Resources/Locators/Search_page_locators.robot

*** Keywords ***
Check Product For Current KB Article Page
    [Arguments]    ${KB_Number}    ${Product}
    ${KB_Number_Lowercase}=    Convert To Lowercase    ${KB_Number}
    Location Should Contain    kb/${KB_Number_Lowercase}
    Element Should Contain    xpath=//h1    ${KB_Number}
    ${actual_product_name}=    Get Text    xpath=//ul[@id="BreadCrumbs"]//li[last()]/a
    Should Be Equal As Strings    ${actual_product_name}    ${Product}    *HTML*<b>KB [${KB_Number}] Product mismatch. Expected '${Product}'. Actual '${actual_product_name}'. Please check tets data<b/>
    ${Product}=    Replace String    ${Product}    ${SPACE}    -
    ${Product}=    Convert To Lowercase    ${Product}
    Run Keyword If    'sonicwall' in '${Product}'    Location Should Contain    /kb/${KB_Number_Lowercase}
    Run Keyword If    'sonicwall' not in '${Product}'    Location Should Contain    ${Product}

Current KB Article Should be Visible
    [Arguments]    ${KB_Number}
    ${KB_Number_lowercase}=    Convert To Lowercase    ${KB_Number}
    Location Should Contain    kb/${KB_Number_lowercase}
    Element Should Contain    xpath=//h1    ${KB_Number}
    Page Should Not Contain Element    xpath=//div[@class="well well-lg well-gray-medium-stroke well-blue-stroke"]    *HTML*<b>KB [${KB_Number}] should be visible. But it contains restriction pane<b/>    loglevel=NONE
    Page Should Contain Element    xpath=//ul[@id="kbDtlSec"]/li[3]    *HTML*<b>KB [${KB_Number}] should be visible. But the resolution section is hided<b/>    loglevel=NONE

KB Article Should Not Be Found
    [Arguments]    ${User}    ${KB_Number}    ${Product}    ${Status}    ${Type}    ${Premium_Sign_In}
    Setup Siebel Data for KB    ${KB_Number}    ${Status}    ${Type}    ${Premium_Sign_In}
    ${User_data_string}=    Convert To String    ${User}
    ${User_data_string}=    Replace String    ${User_data_string}    '    ${EMPTY}
    Run Keyword If    '${User_data_string}'!='Anonymous'    Login    ${User}
    ...    ELSE    Open Support Portal Anonimously
    Create Extended Test Message    ${User}    ${KB_Number}    ${Product}    ${Status}    ${Type}    ${Premium_Sign_In}
    Search and Not Found KB    ${KB_Number}
    Page Should Not Be Found    ${SUPPORT_STAGE2_SITE}/${LOCALE}/kb/${KB_Number}
    [Teardown]    Close Browser

KB Article Should Notify Expired Maintenance
    [Arguments]    ${User}    ${KB_Number}    ${Product}    ${Status}    ${Type}    ${Premium_Sign_In}
    Setup Siebel Data for KB    ${KB_Number}    ${Status}    ${Type}    ${Premium_Sign_In}
    ${User_data_string}=    Convert To String    ${User}
    ${User_data_string}=    Replace String    ${User_data_string}    '    ${EMPTY}
    Run Keyword If    '${User_data_string}'!='Anonymous'    Login    ${User}
    ...    ELSE    Open Support Portal Anonimously
    Create Extended Test Message    ${User}    ${KB_Number}    ${Product}    ${Status}    ${Type}    ${Premium_Sign_In}
    Search and Open KB    ${KB_Number}
    Check Product For Current KB Article Page    ${KB_Number}    ${Product}
    Access to KB Article Page Should be Restricted    ${KB_Number}    Expired Maintenance
    [Teardown]    Close Browser

KB Article Should Require Sign In
    [Arguments]    ${User}    ${KB_Number}    ${Product}    ${Status}    ${Type}    ${Premium_Sign_In}
    Setup Siebel Data for KB    ${KB_Number}    ${Status}    ${Type}    ${Premium_Sign_In}
    ${User_data_string}=    Convert To String    ${User}
    ${User_data_string}=    Replace String    ${User_data_string}    '    ${EMPTY}
    Run Keyword If    '${User_data_string}'!='Anonymous'    Login    ${User}
    ...    ELSE    Open Support Portal Anonimously
    Create Extended Test Message    ${User}    ${KB_Number}    ${Product}    ${Status}    ${Type}    ${Premium_Sign_In}
    Search and Open KB    ${KB_Number}
    Check Product For Current KB Article Page    ${KB_Number}    ${Product}
    Access to KB Article Page Should be Restricted    ${KB_Number}    Require Sign In
    [Teardown]    Close Browser

KB Article Should be Visible
    [Arguments]    ${User}    ${KB_Number}    ${Product}    ${Status}    ${Type}    ${Premium_Sign_In}
    Setup Siebel Data for KB    ${KB_Number}    ${Status}    ${Type}    ${Premium_Sign_In}
    ${User_data_string}=    Convert To String    ${User}
    ${User_data_string}=    Replace String    ${User_data_string}    '    ${EMPTY}
    Run Keyword If    '${User_data_string}'!='Anonymous'    Login    ${User}
    ...    ELSE    Open Support Portal Anonimously
    Create Extended Test Message    ${User}    ${KB_Number}    ${Product}    ${Status}    ${Type}    ${Premium_Sign_In}
    Search and Open KB    ${KB_Number}
    Check Product For Current KB Article Page    ${KB_Number}    ${Product}
    Current KB Article Should be Visible    ${KB_Number}
    [Teardown]    Close Browser

Login
    [Arguments]    ${User}
    Open SignIn Page
    SignIn    ${User['email']}    ${User['password']}

Search and Not Found KB
    [Arguments]    ${KB_Number}
    ${no_search_results}=    Get Regexp Matches    ${dsg_SearchPage_NoResults_HTML}    "><p>(.*?)<\/p>    1
    Wait Until Page Contains Element    xpath=//div[@id="Profile"]/div[@class="mob-si pop-search-flyout"]
    Comment    Run Keyword If    '${BROWSER}' in ('iPhone_6', 'iPadAir_2', 'Samsung_GalaxyS6')    Click Element    xpath=//form[@id="HeaderSearch"]/div[@class="mob-si"]
    Click Element    xpath=//i[@class="i-small-searchleft"]
    Input Text    xpath=//form[@id="SearchFlyout"]//input[@name="k"]    ${KB_Number}
    Click Button    xpath=//form[@id="SearchFlyout"]//button
    sleep    1
    Wait Until Page Contains Element    ${dsg_search_Title_SearchGlobal_locator}
    ${KB_Number}=    Convert To Lowercase    ${KB_Number}
    Locator Should Match X Times    xpath=//div[@class="article"]//a[contains(@href,"/kb/${KB_Number}")]    0    message=*HTML*<b>KB '${KB_Number}' should not be found. But the search contains results for '${KB_Number}'.</b>    loglevel=NONE

Search and Open KB
    [Arguments]    ${KB_Number}
    Wait Until Page Contains Element    xpath=//div[@id="Profile"]/div[@class="mob-si pop-search-flyout"]
    Comment    Run Keyword If    '${BROWSER}' in ('iPhone_6', 'iPadAir_2', 'Samsung_GalaxyS6')    Click Element    xpath=//form[@id="HeaderSearch"]/div[@class="mob-si"]
    Click Element    xpath=//i[@class="i-small-searchleft"]
    Input Text    xpath=//form[@id="SearchFlyout"]//input[@name="k"]    ${KB_Number}
    Click Button    xpath=//form[@id="SearchFlyout"]//button
    sleep    1
    Wait Until Page Contains Element    xpath=//div[@class="article"]    timeout=10    error=*HTML*<b>No search results for KB '${KB_Number}' in 10 seconds. But KB '${KB_Number}' should be found<b/>
    Wait Until Page Contains Element    ${dsg_search_Title_SearchGlobal_locator}
    ${KB_Number_Lowercase}=    Convert To Lowercase    ${KB_Number}
    ${KB_results_count}=    Get Matching Xpath Count    //div[@class="article"]//a[contains(@href,"/kb/${KB_Number_Lowercase}")]
    Should Be True    ${KB_results_count} > 0    *HTML*<b>Search results should conatin at least one KB '${KB_Number}' article. But the KB was not found.</b>
    Click Link    xpath=//div[@class="article"]//a[contains(@href, '${KB_Number}')]
    Wait Until Page Contains Element    xpath=//ul[@id="kbDtlSec"]
    Location Should Contain    kb/${KB_Number_Lowercase}
    Element Should Contain    xpath=//h1    ${KB_Number}

Setup Siebel Data for KB
    [Arguments]    ${KB_Number}    ${Status}    ${Type}    ${Premium_Sign_In}
    Connect To Database Using Custom Params    pyodbc    ${SUPPORT_STAGE2_DB_CONNECTION_STRING}
    ${Premium_Sign_In}=    Replace String    ${Premium_Sign_In}    `    ${EMPTY}
    ${Premium_Sign_In}=    Set Variable If    '${Premium_Sign_In}'=='Any Value'    Not Required    ${Premium_Sign_In}
    ${IsExternal}=    Set Variable If    '${Type}'=='External'    Y    N
    ${KB_count_query}=    Catenate    SEPARATOR=    select count(*) from KbArticles where solNumber = '    ${KB_Number}    '
    @{KB_count}=    Query    ${KB_count_query}
    ${query_count_gt1}=    Catenate    SEPARATOR=    Update KbArticles set PremiumType = '    ${Premium_Sign_In}    ', Status='    ${Status}
    ...    ', IsExternal = '    ${IsExternal}    ' where solNumber = '    ${KB_Number}    ' and Status='    ${Status}
    ...    \    '
    ${query_count_eq1}=    Catenate    SEPARATOR=    Update KbArticles set PremiumType = '    ${Premium_Sign_In}    ', Status='    ${Status}
    ...    ', IsExternal = '    ${IsExternal}    ' where solNumber = '    ${KB_Number}    '
    ${query}=    Set Variable If    ${KB_count[0][0]}>1    ${query_count_gt1}    ${query_count_eq1}
    Execute Sql String    ${query}

Access to KB Article Page Should be Restricted
    [Arguments]    ${KB_Number}    ${Restriction}
    ${KB_Number_lowercase}=    Convert To Lowercase    ${KB_Number}
    Location Should Contain    kb/${KB_Number_lowercase}
    Element Should Contain    xpath=//h1    ${KB_Number}
    ${require_RenewContract_h2}=    Get Regexp Matches    ${dsg_KbArticle_RenewContract}    .*<h2.*>(.*)<\/h2>    1
    ${UnavailableContent_h2}=    Get Regexp Matches    ${dsg_KbArticle_UnavailableContent}    ><h2>(.*?)<\/h2>    1
    ${require_login_h2}=    Get Regexp Matches    ${dsg_KbArticle_AuthenticationRequired}    .*<h2>(.*)<\/h2>    1
    Page Should Contain Element    xpath=//div[@class="well well-lg well-gray-medium-stroke well-blue-stroke"]    *HTML*<b>KB [${KB_Number}] page should be restricted due to '${Restriction}'. But it is fully visible.</b>    loglevel=NONE
    Run Keyword If    '${Restriction}'=='Permission Required'    Page Should Contain Element    xpath=//div[@class="well well-lg well-gray-medium-stroke well-blue-stroke"]//h2[text()][contains(.,"${UnavailableContent_h2[0]}")]    *HTML*<b>KB [${KB_Number}] should be restricted due to '${Restriction}'. Actually it restriced due to another restriction</b>    loglevel=NONE
    Run Keyword If    '${Restriction}'=='Require Sign In'    Page Should Contain Element    xpath=//div[@class="well well-lg well-gray-medium-stroke well-blue-stroke"]//h2[text()][contains(.,"${require_login_h2[0]}")]    *HTML*<b>KB [${KB_Number}] should be restricted due to '${Restriction}'. Actually it restriced due to another restriction</b>    loglevel=NONE
    Run Keyword If    '${Restriction}'=='Expired Maintenance'    Page Should Contain Element    xpath=//div[@class="well well-lg well-gray-medium-stroke well-blue-stroke"]//h2[text()][contains(.,"${require_RenewContract_h2[0]}")]    *HTML*<b>KB [${KB_Number}] should be restricted due to '${Restriction}'. Actually it restriced due to another restriction</b>    loglevel=NONE
    Page Should Not Contain Element    xpath=//ul[@id="kbDtlSec"]/li[3]    *HTML*<b>KB [${KB_Number}] resolution should NOT be visible. But the resolution section is visible<b/>    loglevel=NONE

KB Visibility Teardown
    Run Keyword If Test Failed    Set Test Message    ${test_msg}    append=True

Create Extended Test Message
    [Arguments]    ${User}    ${KB_Number}    ${Product}    ${Status}    ${Type}    ${Premium_Sign_In}
    ${User_data_string}=    Convert To String    ${User}
    ${User_data_string}=    Replace String    ${User_data_string}    '    ${EMPTY}
    ${user_message}=    Set Variable If    '${User_data_string}'=='Anonymous'    User ${User}    User ${User['email']}/${User['password']}
    ${test_msg}=    Catenate    SEPARATOR=\n    \n\n${user_message}    KB#: ${KB_Number}    Product: ${Product}    Status: ${Status}
    ...    Type: ${Type}    Premium: ${Premium_Sign_In}
    Set Test Variable    ${test_msg}

KB Article Should Require Permission
    [Arguments]    ${User}    ${KB_Number}    ${Product}    ${Status}    ${Type}    ${Premium_Sign_In}
    Setup Siebel Data for KB    ${KB_Number}    ${Status}    ${Type}    ${Premium_Sign_In}
    ${User_data_string}=    Convert To String    ${User}
    ${User_data_string}=    Replace String    ${User_data_string}    '    ${EMPTY}
    Run Keyword If    '${User_data_string}'!='Anonymous'    Login    ${User}
    ...    ELSE    Open Support Portal Anonimously
    Create Extended Test Message    ${User}    ${KB_Number}    ${Product}    ${Status}    ${Type}    ${Premium_Sign_In}
    Search and Open KB    ${KB_Number}
    Check Product For Current KB Article Page    ${KB_Number}    ${Product}
    Access to KB Article Page Should be Restricted    ${KB_Number}    Permission Required
    [Teardown]    Close Browser
