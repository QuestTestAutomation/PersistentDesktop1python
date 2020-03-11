*** Settings ***
Suite Setup       Global Setup
Test Teardown     Close Working Session
Resource          ../Resources/Commons.robot
Resource          SuiteKB_Keywords_Resources.robot

*** Test Cases ***
Open KB without sign in
    [Setup]    Prepare Account
    Comment    Skip the rest of the test case for the following configurations    Samsung_GalaxyS6    iPhone_6
    GIVEN an anonymous user on the Knowledge Base page
    WHEN the user selects product 'Foglight' in the ‘Select your product to list Technical Documentation’ selector
    THEN the user on the ‘Knowledge Base’ page of the 'Foglight' product
    WHEN the user types '134748' in the ‘Search Knowledge Base by keyword’ input
    AND clicks on icon 'Search'
    THEN the search by the value '134748' completed
    AND the result set contains articles with the value '134748'
    Comment    THEN the user on the page of the 'NetVault Backup Plug-in for Domino 4.4 Release Notes' document
    WHEN the user selects the 'Exchange Agent Fails to collect data due to SMB Connection Error (134748)' document
    THEN the user on the page of the 'Exchange Agent Fails to collect data due to SMB Connection Error (134748)' document
    AND authentication is required
    WHEN the user logs in as 'quest123.qa@gmail.com'
    THEN the user on the page of the 'Exchange Agent Fails to collect data due to SMB Connection Error (134748)' document
    Comment    AND entitlement is required

Open document with current entitlement
    [Tags]    debug
    [Setup]    Prepare Account
    Comment    Skip the rest of the test case for the following configurations    Samsung_GalaxyS6    iPhone_6
    GIVEN an anonymous user on the Knowledge Base page
    WHEN the user selects the test product in the ‘Select your product to list Technical Documentation’ selector
    THEN the user on the ‘Technical Documentation’ page of the test product
    WHEN the user changes version on '${TEST_PRODUCT_VERSION}'
    THEN the available documentation for version appear
    WHEN the user selects the 'Toad for Oracle 12.9 2016 Suites Installation Guide' document
    THEN the user on the page of the 'Toad for Oracle 12.9 2016 Suites Installation Guide' document
    AND authentication is required
    WHEN the user logs in as 'quest123.qa@gmail.com'
    THEN the user on the page of the 'Toad for Oracle 12.9 2016 Suites Installation Guide' document
    AND entitlement is required
    AND full content of the article is shown

Online view
    [Tags]    debug
    [Setup]    Prepare Account
    Comment    Skip the rest of the test case for the following configurations    Samsung_GalaxyS6    iPhone_6
    GIVEN an anonymous user on the Knowledge Base page
    WHEN the user clicks "See All Products"
    THEN the user on the products a-z page
    WHEN the user types a name of test product in the ‘Enter your product to find support’ selector
    THEN the user on the ‘Technical Documentation’ page of the test product
    WHEN the user changes version on '${TEST_PRODUCT_VERSION}'
    THEN the available documentation for version appear
    WHEN the user selects the 'Toad for Oracle 12.9 2016 Suites Release Notes' document
    THEN the user on the page of the 'Toad for Oracle 12.9 2016 Suites Release Notes' document
    AND authentication is required
    WHEN the user logs in as 'quest123.qa@gmail.com'
    THEN the user on the page of the 'Toad for Oracle 12.9 2016 Suites Release Notes' document
    AND entitlement is required
    AND full content of the article is shown

*** Keywords ***
