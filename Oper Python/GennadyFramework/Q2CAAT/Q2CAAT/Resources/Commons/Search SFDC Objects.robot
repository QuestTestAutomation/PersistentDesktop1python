*** Settings ***
Library    SeleniumLibrary
Resource    Locartors/Search Locators.robot
Resource    Navigation/Main Page Navigation.robot
Resource    Utilities.robot

*** Keywords ***

Search and Open Account '${account_name}'
    Select 'Accounts' View
    Page Should Contain Element    ${serach_control}
    #Click Element    ${search_entity_combo}
    Click Element    //input[@title="Search Accounts and more"]
    Press Key    //input[@title="Search Accounts and more"]    ${account_name}
    Press Key    //input[@title="Search Accounts and more"]    \\13
    sleep    1
    Wait Until Page Contains Element    //div[@class="slds-grid forceSearchSearch"]//table[@data-aura-class="uiVirtualDataTable"]/tbody/tr/th//a[text()="${account_name}"]
    Wait Until Element Is Visible    //div[@class="slds-grid forceSearchSearch"]//table[@data-aura-class="uiVirtualDataTable"]/tbody/tr/th//a[text()="${account_name}"]    
    #sleep    5
    Highlight Element    //div[@class="slds-grid forceSearchSearch"]//table[@data-aura-class="uiVirtualDataTable"]/tbody/tr/th//a[text()="${account_name}"]/../..
    Click Element    //div[@class="slds-grid forceSearchSearch"]//table[@data-aura-class="uiVirtualDataTable"]/tbody/tr/th//a[text()="${account_name}"]/../..
    #Set Focus To Element    //div[@class="slds-grid forceSearchSearch"]//table[@data-aura-class="uiVirtualDataTable"]/tbody/tr/th//a[text()="${account_name}"]/../..
    #Press Key    //div[@class="slds-grid forceSearchSearch"]//table[@data-aura-class="uiVirtualDataTable"]/tbody/tr/th//a[text()="${account_name}"]/../..    \\13
    Wait Until Page Contains Element    //nav[@class="entityNameTitle"]//span[text()='Account']
    Wait Until Page Contains Element    //nav[@class="entityNameTitle"]//span[text()='Account']/../../../following-sibling::h1//span[text()='${account_name}']        
    
    
     
