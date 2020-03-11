*** Settings ***
Library           Selenium2Library
Library           HttpLibrary.HTTP
Resource          Commons.robot
Resource          Locators/TechDoc_Page_Locators.robot

*** Keywords ***
Select Product on Technical Documentation Page
    [Arguments]    ${product_name}
    Input Text    id=productAutoComplete    ${product_name}
    Click Element    id=btnProductAutoComplete
    Wait Until Page Contains Element    tag=h1
    Element Text Should Be    tag=h1    ${product_name} - ${dsg_mobNavPartial_rlsNtsGds}

Open TechDoc Page
    Open Support Portal Anonimously
    Navigate to Technical Download Page

Navigate to Technical Download Page
    Page Should Contain Element    ${dsg_home_ToolsTitle_rng_locator}
    Scroll To Element    ${dsg_home_ToolsTitle_rng_locator}
    Highlight Element    ${dsg_home_ToolsTitle_rng_locator}
    Click Link    ${dsg_home_ToolsTitle_rng_locator}/..
    Current Page Should Not Contain Errors
    Wait Until Page Contains Element    ${dsg_ReleaseNotes_Page_Title_locator}
    Location Should Contain    /technical-documents

Active page should be the Technical Documentation page for the '${product_name}' product
    Wait Until Page Contains Element    xpath=//h1[@id="LayoutH1"][text()[contains(.,'${product_name} - ${dsg_ReleaseNotes_Page_Title}')]]
