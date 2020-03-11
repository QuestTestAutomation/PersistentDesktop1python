*** Settings ***
Suite Setup       Global Setup
Test Teardown     Close Working Session
Resource          ../Resources/Commons.robot
Resource          ../02__Login/SuiteLogin_Keywords_Resources.robot
Resource          SuiteDownloads_Keywords_Resources.robot

*** Test Cases ***
Search Software Downloads Page (General Search)
    [Tags]    C89
    [Setup]    Prepare Account
    Skip the rest of the test case for the following configurations    Samsung_GalaxyS6    iPhone_6    iPadAir_2
    GIVEN the user 'quest123.qa@gmail.com' logged into portal
    WHEN the user navigates to Software Downloads
    AND selects test product in the ‘Select your product to find the latest Software’ selector
    THEN the user on ‘Download Software’ page of the test product
    WHEN the user changes version on '12.9'
    THEN the available installations for version appear
    WHEN the user set text "silent" to field "Search All Downloads"
    AND clicks on icon 'Search'
    THEN the user on ‘Search Downloads’ page of the test product
    Comment    WHEN the user searches text without version filter
    AND result set contains 1 articles
    AND the found fragments of text 'silent' are highlighted
    WHEN the user clicks button 'Clear'
    THEN the text has been removed from field 'Search Binaries by keyword'
    AND result set contains 21 articles
    WHEN the user clicks "Choose a different product"
    THEN the user on the products a-z page
    WHEN the user clicks on 'My Downloads'
    THEN the user on 'My Downloads' page
    Comment    WHEN the user clicks on email
    Comment    THEN emai box pops up

*** Keywords ***
The user set text "${value}" to field "Search All Downloads"
    ${locator}=    Set Variable    ${search_input}
    JS Set Value To Input    ${locator}    ${value}

Clicks on icon 'Search'
    Highlight Element    ${search_button}
    Click Element    ${search_button}

The user on ‘Search Downloads’ page of the test product
    Active page should be Search Downloads page for the '${TEST_PRODUCT}' product
    Close Popup    ${at_popup_opinion}

The user searches text without version filter
    Click Element    ${button_delete_filter_version}
    Wait Until Page Does Not Contain Element    ${Endeca_Product Version_locator}

The found fragments of text '${value}' are highlighted
    Wait Until Element is Visible    xpath=${search_results_articles}
    ${count_not_highlight}=    Get Matching Xpath Count    ${search_results_articles}/p//*[text()[contains(., "${value}")]][not(@style="background-color:yellow") and not(@style="background-color: yellow;")]
    ${count_highlight}=    Get Matching Xpath Count    ${search_results_articles}/p//*[text()[contains(., "${value}")]][@style="background-color:yellow" or @style="background-color: yellow;"]
    ${count_found_text}=    Get Matching Xpath Count    ${search_results_articles}/p//*[text()[contains(., "${value}")]]
    ${count_articles}=    Get Matching Xpath Count    ${search_results_articles}
    Run Keyword IF    ${count_not_highlight}>0 or ${count_highlight}!=${count_found_text} or ${count_articles}>${count_found_text}    Capture Page Screenshot
    Run Keyword IF    ${count_not_highlight}>0 or ${count_highlight}!=${count_found_text}    Fail    Has been found not highlighted search text '${value}'
    Run Keyword IF    ${count_articles}>${count_found_text}    Fail    Have been found articles that not contain search text '${value}'

The user clicks button 'Clear'
    Click Element    ${button_clear}

The text has been removed from field 'Search Binaries by keyword'
    Wait Until Page Contains Element    ${input_search}[@value=""]

Result set contains ${count_result} articles
    Wait Until Element Is Visible    ${count_results_locator}
    ${str_results}=    Get Text    ${count_results_locator}
    log    ${str_results}
    ${re_str}=    Set Variable IF    "${LOCALE}"=="ja-jp"    \\A\\s*([0-9]*)[^0-9]*    \\s+([0-9]*)\\s*\\Z
    ${count}=    Get Regexp Matches    ${str_results}    ${re_str}    1
    ${count_articles}=    Run Keyword IF    "${count}"!="${EMPTY}" and "${count}"!="[]"    Evaluate    ${count}[0]
    ...    ELSE    Set Variable    ${EMPTY}
    Run Keyword IF    "${count_articles}"!="${count_result}"    Capture Page Screenshot
    Run Keyword IF    "${count_articles}"!="${count_result}"    Fail    The obtained number of articles and the expected number of articles are not equivalent
