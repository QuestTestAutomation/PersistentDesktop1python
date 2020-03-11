*** Settings ***
Documentation     As an anonymous portal visitor I want to watch the topmost video for the selected product
Suite Setup       Global Setup
Test Teardown     Close Working Session
Resource          ../Resources/Video_Page_Resources.robot
Resource          ../Resources/Commons.robot
Resource          SuiteVideos_Keywords_Resources.robot

*** Test Cases ***
Play the topmost video
    [Tags]    video
    Skip the rest of the test case for the following configurations    iPhone_6    iPadAir_2    Samsung_GalaxyS6
    GIVEN An anonymous user on the Video Tutorials page
    WHEN The user selects test product in the ‘Select your product to view available Video Tutorials’ selector
    THEN The user on ‘Video and Tutorials’ page of the test product
    AND The latest version of the test product should be selected
    AND Video types selector set to ‘All’
    AND The most recent video should be displayed
    Comment    AND The player size should be big
    AND The most recent video should NOT be playing
    WHEN The visitor clicks the Play button
    THEN The video start playing
