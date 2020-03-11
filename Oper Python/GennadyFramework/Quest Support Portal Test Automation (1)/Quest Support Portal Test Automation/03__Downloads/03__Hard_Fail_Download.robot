*** Settings ***
Suite Setup       Global Setup
Test Teardown     Close Working Session
Resource          ../Resources/Commons.robot
Resource          ../02__Login/SuiteLogin_Keywords_Resources.robot
Resource          SuiteDownloads_Keywords_Resources.robot

*** Test Cases ***
Hard Fail
    [Tags]    C82
    [Setup]    Prepare Account
    Skip the rest of the test case for the following configurations    Samsung_GalaxyS6    iPhone_6
    log    ${HARD_FAIL}
    log    ${HARD_FAIL_version}
    GIVEN the user 'quest123.qa@gmail.com' logged into portal
    WHEN the user navigates to Software Downloads
    AND selects product '${HARD_FAIL}' in the ‘Select your product to find the latest Software’ selector
    THEN the user on ‘Download Software’ page of the '${HARD_FAIL}' product
    WHEN the user changes version on '${HARD_FAIL_version}'
    THEN the available installations for version appear
    Comment    WHEN the user clicks on the link 'Download'
    WHEN the user clicks on the application link 1
    THEN the user on the page 'Install Detail'
    WHEN the user clicks on the button 'Add to Downloads'
    THEN receives 'hard fail' error
    AND the Support's Download Cart is Empty

*** Keywords ***
