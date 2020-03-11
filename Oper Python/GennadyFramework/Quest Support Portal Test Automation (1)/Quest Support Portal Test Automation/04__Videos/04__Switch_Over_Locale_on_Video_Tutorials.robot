*** Settings ***
Documentation     As an anonymous portal visitor I want to switch over locale on page Video Tutorials
Suite Setup       Global Setup
Test Teardown     Close Working Session
Force Tags        video
Resource          ../Resources/Video_Page_Resources.robot
Resource          ../Resources/Commons.robot
Resource          SuiteVideos_Keywords_Resources.robot

*** Test Cases ***
Switch over locale
    [Tags]    C280
    Skip the rest of the test case for the following configurations    Samsung_GalaxyS6
    GIVEN An anonymous user on the Video Tutorials page
    WHEN The user selects test product in the ‘Select your product to view available Video Tutorials’ selector
    THEN The user on ‘Video and Tutorials’ page of the test product
    AND The latest version of the test product should be selected
    AND Video types selector set to ‘All’
    Comment    Comment    Comment
    Comment    Comment    Comment
    AND The most recent video should NOT be playing
    AND frontend and backend video sets are equal
    WHEN The user changes country on 'Mexico'
    THEN The video set is changed
    AND frontend and backend video sets are equal
    WHEN The user changes country on 'ж—Ґжњ¬'
    THEN The video set is changed
    AND frontend and backend video sets are equal
    WHEN The user changes country on 'United Kingdom'
    THEN The video set is changed
    AND frontend and backend video sets are equal
