*** Settings ***
Library           Selenium2Library
Library           HttpLibrary.HTTP
Resource          Commons.robot

*** Keywords ***
Click filter
    [Arguments]    ${filter_locator}
    ${locator}=    Prepare Locator To JS    ${filter_locator}
    ${filter_is_collapsed}=    Get Matching Xpath Count    ${locator}//*[@class='panel-title']/a[@class='collapsed']
    Wait Until Element Is Enabled    xpath=${locator}//*[@class='panel-title']/a[@class='collapsed']
    Focus    xpath=${locator}//*[@class='panel-title']/a
    Run Keyword IF    ${filter_is_collapsed}!=0    Click Element    xpath=${locator}//*[@class='panel-title']/a[@class='collapsed']
    Wait Until Page Contains Element    xpath=${locator}/div[@class='panel-collapse collapse in']

Select value of filter
    [Arguments]    ${filter_locator}    ${filter_name}    ${filter_value}    ${filter_label}
    Click filter    ${filter_locator}
    ${search_element}=    Set Variable IF    "${filter_value}" in ("${None}", "${EMPTY}")    ${filter_locator}/div[@class='panel-collapse collapse in']//input[./following-sibling::span[text()[contains(., '${filter_label}')]]or ./preceding-sibling::span[text()[contains(., '${filter_label}')]] or ./parent::label[text()[contains(., '${filter_label}')]]]    ${filter_locator}/div[@class='panel-collapse collapse in']//input[@value='${filter_value}']
    ${locator}=    Prepare Locator To JS    ${search_element}
    ${count_item}=    Get Matching Xpath Count    ${locator}
    Run Keyword IF    ${count_item}==0    Fail    Filter '${filter_name}' does not contain value '${filter_label}'
    Scroll To Element    ${search_element}
    Click Element    ${search_element}
