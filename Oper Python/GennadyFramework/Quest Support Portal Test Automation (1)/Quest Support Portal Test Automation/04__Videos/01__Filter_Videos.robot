*** Settings ***
Documentation     As an anonymous portal visitor I want to filter video on the Video Tutorials page of the product
Suite Setup       Global Setup
Test Teardown     Close Working Session
Force Tags        video
Resource          ../Resources/Video_Page_Resources.robot
Resource          ../Resources/Commons.robot
Resource          SuiteVideos_Keywords_Resources.robot

*** Test Cases ***
Filtering video by Category
    [Tags]    C279
    Skip the rest of the test case for the following configurations    Samsung_GalaxyS6
    GIVEN An anonymous user on the Video Tutorials page
    WHEN The user selects test product in the ‘Select your product to view available Video Tutorials’ selector
    THEN The user on ‘Video and Tutorials’ page of the test product
    AND The latest version of the test product should be selected
    AND Video types selector set to ‘All’
    AND The most recent video should be displayed
    Comment    Comment    AND The player size should be big
    AND The most recent video should NOT be playing
    AND frontend and backend video sets are equal
    WHEN The user changes version on '12.9'
    AND the user sets video types selector to 'Getting Started'
    THEN The video set is changed
    AND frontend and backend video sets are equal
    WHEN The user sets video types selector to 'Install & Upgrade'
    THEN The video set is changed
    AND frontend and backend video sets are equal
    WHEN The user sets video types selector to 'Most Popular'
    THEN The video set is changed
    AND frontend and backend video sets are equal

Filtering video by Version
    Skip the rest of the test case for the following configurations    Samsung_GalaxyS6
    GIVEN An anonymous user on the Video Tutorials page
    WHEN The user selects test product in the ‘Select your product to view available Video Tutorials’ selector
    THEN The user on ‘Video and Tutorials’ page of the test product
    AND The latest version of the test product should be selected
    AND Video types selector set to ‘All’
    AND The most recent video should be displayed
    Comment    Comment    AND The player size should be big
    AND The most recent video should NOT be playing
    AND frontend and backend video sets are equal
    WHEN The user changes version on '12.9'
    THEN The video set is changed
    AND frontend and backend video sets are equal

Filtering video by Version and Category
    Skip the rest of the test case for the following configurations    Samsung_GalaxyS6
    GIVEN An anonymous user on the Video Tutorials page
    WHEN The user selects test product in the ‘Select your product to view available Video Tutorials’ selector
    THEN The user on ‘Video and Tutorials’ page of the test product
    AND The latest version of the test product should be selected
    AND Video types selector set to ‘All’
    AND The most recent video should be displayed
    Comment    Comment    AND The player size should be big
    AND The most recent video should NOT be playing
    AND frontend and backend video sets are equal
    WHEN The user changes version on '12.9'
    THEN The video set is changed
    AND frontend and backend video sets are equal
    WHEN The user sets video types selector to 'Getting Started'
    THEN The video set is changed
    AND frontend and backend video sets are equal
    WHEN The user sets video types selector to 'Most Popular'
    THEN The video set is changed
    AND frontend and backend video sets are equal
