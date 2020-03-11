*** Settings ***
Suite Setup       Global Setup
Test Teardown     Close Working Session
Resource          ../Resources/Commons.robot
Resource          ../02__Login/SuiteLogin_Keywords_Resources.robot
Resource          SuiteDownloads_Keywords_Resources.robot

*** Test Cases ***
Soft Fail
    [Tags]    C93
    [Setup]    Prepare Account
    Skip the rest of the test case for the following configurations    Samsung_GalaxyS6    iPhone_6
    log    ${SOFT_FAIL}
    log    ${SOFT_FAIL_version}
    GIVEN the user 'quest123.qa@gmail.com' logged into portal
    WHEN the user navigates to Software Downloads
    AND selects product '${SOFT_FAIL}' in the ‘Select your product to find the latest Software’ selector
    THEN the user on ‘Download Software’ page of the '${SOFT_FAIL}' product
    WHEN the user changes version on '${SOFT_FAIL_version}'
    THEN the available installations for version appear
    WHEN the user clicks on the application link 1
    THEN the user on the page 'Install Detail'
    WHEN the user clicks on the button 'Add to Downloads'
    THEN receives 'soft fail' error
    WHEN the user closes this message
    THEN modal window 'Add to My Downloads' appears
    WHEN the user clicks 'Add to Downloads' button of modal window
    THEN the Support's Download Cart is not Empty

*** Keywords ***
The user closes this message
    Click Element    ${buttonClose_SoftFail}
