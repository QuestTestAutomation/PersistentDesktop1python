*** Settings ***
Resource    ../../Resources/Commons/Login To SFDC.robot
Resource    ../../Resources/Commons/Navigation/Select Application.robot
Resource    ../../Resources/Commons/Search SFDC Objects.robot
Resource    ../../Resources/Commons/Navigation/Accounts Page Keywords.robot
Test Teardown    Close Browser

*** Test Cases ***
Check 'DELAWARE NATION' account for contact 'Receiving Dept'
    [Documentation]    ITQTC-58 https://jira.labs.quest.com/browse/ITQTC-58
    Login To SFDC sandbox as UAT account
    Switch to 'Z-Force Quotes' App
    Search and Open Account 'DELAWARE NATION'
    Account 'DELAWARE NATION' should have Contact 'Receiving Dept'
    Capture Page Screenshot
    
Check 'DELAWARE NATION' account for oppty 'DELAWARE NATION-1-40IJ2GN-12/01/2017 01:20:05'
    [Documentation]    ITQTC-58 https://jira.labs.quest.com/browse/ITQTC-58
    Login To SFDC sandbox as UAT account
    Switch to 'Z-Force Quotes' App
    Search and Open Account 'DELAWARE NATION'
    Account 'DELAWARE NATION' should have Oppty 'DELAWARE NATION-1-40IJ2GN-12/01/2017 01:20:05'
    Capture Page Screenshot    
    
    