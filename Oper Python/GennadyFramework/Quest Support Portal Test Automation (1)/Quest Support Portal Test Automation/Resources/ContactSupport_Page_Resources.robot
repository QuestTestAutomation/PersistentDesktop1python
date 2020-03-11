*** Settings ***
Library           Selenium2Library
Library           HttpLibrary.HTTP
Resource          Commons.robot
Resource          Locators/ContactSupport_Page_Locators.robot

*** Keywords ***
Open Contact Support Page
    Open Support Portal Anonimously
    Navigate to Contact Support Page
    Comment    Page Should Contain Element    ${dsg_home_ToolsTitle_msr_locator}
    Comment    Scroll To Element    ${dsg_home_ToolsTitle_msr_locator}
    Comment    Highlight Element    ${dsg_home_ToolsTitle_msr_locator}
    Comment    Click Link    ${dsg_home_ToolsTitle_msr_locator}/..
    Comment    Active page should be Contact Support

Active page should be Customer Service
    Comment    ${locator}=    Set Variable IF    "${LOCALE}"=="ja-jp"    xpath=//h1[@id="LayoutH1"][text()[contains(.,'${dsg_ContactUs_Category_12_DisplayName}')]]    ${CustomerService_ContactForm_Title_locator}
    Comment    ${locator}=    Set Variable    xpath=//h1[@id="LayoutH1"][text()[contains(.,'${dsg_ContactUs_Category_12_DisplayName}')]]
    Comment    Wait Until Page Contains Element    ${locator}
    Wait Until Page Contains Element    ${CustomerService_ContactForm_Title_locator}
    Location Should Contain    /customer-service
    Current Page Should Not Contain Errors

Active page should be Contact Support
    Wait Until Page Contains Element    ${dsg_ManageSR_ManageServiceRequest_locator}
    Location Should Contain    /contact-support
    Current Page Should Not Contain Errors

Active page should be Licensing Assistance
    Wait Until Page Contains Element    ${LicensingAssistance_ContactForm_Title_locator}
    Location Should Contain    /licensing
    Current Page Should Not Contain Errors

Active page should be Professional Services Assistance
    Wait Until Page Contains Element    ${ProfessionalServicesAssistance_ContactForm_Title_locator}
    Location Should Contain    /pso
    Current Page Should Not Contain Errors

Active page should be Welcome to Quest Support
    Wait Until Page Contains Element    ${dsg_ProductSearch_WarmTransferTitle_locator}[@aria-hidden="false"]

Active page should be Renewals Assistance
    Wait Until Page Contains Element    ${RenewalsAssistance_ContactForm_Title_locator}
    Location Should Contain    /renewals
    Current Page Should Not Contain Errors

Active page should be Request Product Information
    Wait Until Page Contains Element    ${RequestProductInformation_ContactForm_Title_locator}
    Location Should Contain    /sales
    Current Page Should Not Contain Errors

Active page should be Training Assistance
    Wait Until Page Contains Element    ${TrainingAssistance_ContactForm_Title_locator}
    Location Should Contain    /training
    Current Page Should Not Contain Errors

Navigate to Contact Support Page
    Page Should Contain Element    ${dsg_home_ToolsTitle_msr_locator}
    Scroll To Element    ${dsg_home_ToolsTitle_msr_locator}
    Highlight Element    ${dsg_home_ToolsTitle_msr_locator}
    Click Link    ${dsg_home_ToolsTitle_msr_locator}/..
    Active page should be Contact Support
