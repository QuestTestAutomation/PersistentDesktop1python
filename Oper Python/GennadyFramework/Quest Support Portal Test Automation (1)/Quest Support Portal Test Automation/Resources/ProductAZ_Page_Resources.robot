*** Settings ***
Library           Selenium2Library
Library           HttpLibrary.HTTP
Resource          Commons.robot
Resource          Locators/Main_Page_Locators.robot
Library           DateTime

*** Keywords ***
Active page should be Products a-z page
    Wait Until Page Contains Element    ${dsg_ProductAtoZ_Title_locator}

The user selects product '${name_product}' in the ‘Enter your product to find support’ selector
    Select Product in Product Search element    ${name_product}
