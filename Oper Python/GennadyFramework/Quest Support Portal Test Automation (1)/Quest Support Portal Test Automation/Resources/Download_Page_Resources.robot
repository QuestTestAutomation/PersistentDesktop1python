*** Settings ***
Library           Selenium2Library
Library           HttpLibrary.HTTP
Resource          Commons.robot
Resource          Locators/Download_Page_Locators.robot

*** Keywords ***
Select Product on Download Page
    [Arguments]    ${product_name}
    Input Text    id=productAutoComplete    ${product_name}
    Click Element    id=btnProductAutoComplete
    Wait Until Page Contains Element    tag=h1
    Element Text Should Be    tag=h1    ${product_name} - Download Software

Open Download Page
    Open Support Portal Anonimously
    Navigate to Download Page

Select Software Download Link
    [Arguments]    ${file_name}
    Click Link    ${file_name}
    Wait Until Page Contains Element    tag=h1
    Element Text Should Be    tag=h1    Download ${file_name}

Check details of the software download link
    Page Should Contain Element    xpath=//a[@class="btn btn-success"]
    Element Text Should Be    xpath=//a[@class="btn btn-success"]    Add to Downloads
    Location Should Be    ${SUPPORT_STAGE2_SITE}/download-install-detail/6061024

Navigate to Download Page
    Page Should Contain Element    ${dsg_home_ToolsTitle_dnr_locator}
    Scroll To Element    ${dsg_home_ToolsTitle_dnr_locator}
    Highlight Element    ${dsg_home_ToolsTitle_dnr_locator}
    Click Link    ${dsg_home_ToolsTitle_dnr_locator}/..
    Current Page Should Not Contain Errors
    Wait Until Page Contains Element    ${dsg_Download_Page_Title_locator}
    Location Should Contain    /download-product-select

Active page should be Download Software page for the '${product_name}' product
    Wait Until Page Contains Element    xpath=//h1[@id="LayoutH1"][text()[contains(.,'${product_name} - ${dsg_dload-rls_page-title}')]]

Active page should be Add to My Downloads
    Wait Until Page Contains Element    ${dsg_Download_AddToFolder_locator}[@aria-hidden="false"]

Active page should be Products a-z page
    Wait Until Page Contains Element    ${dsg_ProductAtoZ_Title_locator}

Page Add to My Downloads should be close
    Wait Until Page Contains Element    ${dsg_Download_AddToFolder_locator}[@aria-hidden="true" and @id="download-1"]
    Wait Until Page Contains Element    ${dsg_Download_AddToFolder_locator}[@aria-hidden="true" and @id="download-2"]

Active page should be Search Downloads page for the '${product_name}' product
    Wait Until Page Contains Element    xpath=//h1[@id="LayoutH1"][text()[contains(.,'${product_name} - ${dsg_search_Title_SearchDownloads }')]]

Active page should be My Downloads page
    Wait Until Page Contains Element    ${dsg_DownloadFolder_MyDownloads_locator}

Active page should be Email
    Wait Until Page Contains Element    ${dsg_Home_EmailHead_locator}
