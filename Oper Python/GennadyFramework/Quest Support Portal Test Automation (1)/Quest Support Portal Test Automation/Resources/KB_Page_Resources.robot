*** Settings ***
Library           Selenium2Library
Library           HttpLibrary.HTTP
Resource          Commons.robot
Resource          Locators/KB_Page_Locators.robot

*** Keywords ***
Select Product on Knowledge Base Page
    [Arguments]    ${product_name}
    Input Text    id=productAutoComplete    ${product_name}
    Click Element    id=btnProductAutoComplete
    Wait Until Page Contains Element    tag=h1
    Element Text Should Be    tag=h1    ${product_name} - ${dsg_search_Title_SearchKB}

Open KB Page
    Open Support Portal Anonimously
    Navigate to Knowledge Base Page

Navigate to Knowledge Base Page
    Page Should Contain Element    ${dsg_home_toolsTitle_knowledgeBase_locator}
    Scroll To Element    ${dsg_home_toolsTitle_knowledgeBase_locator}
    Highlight Element    ${dsg_home_toolsTitle_knowledgeBase_locator}
    Click Link    ${dsg_home_toolsTitle_knowledgeBase_locator}/..
    Current Page Should Not Contain Errors
    Wait Until Page Contains Element    ${dsg_LandingKnowledgeBase_Page_Title_locator}
    Location Should Contain    /kb-product-select

Active page should be the Knowledge Base page for the '${product_name}' product
    Wait Until Page Contains Element    xpath=//h1[@id="LayoutH1"][text()[contains(.,'${product_name} - ${dsg_search_Title_SearchKB}')]]
