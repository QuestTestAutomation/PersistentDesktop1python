*** Settings ***
Documentation     As an anonymous portal visitor I want to select a video from collection of videos of the selected product
Suite Setup       Global Setup
Test Teardown     Close Working Session
Resource          ../Resources/Video_Page_Resources.robot
Resource          ../Resources/Commons.robot
Resource          SuiteVideos_Keywords_Resources.robot

*** Test Cases ***
Play the selected video
    [Tags]    video    1C278
    Skip the rest of the test case for the following configurations    iPhone_6    iPadAir_2    Samsung_GalaxyS6
    sleep    2
    sleep    2
    sleep    3
    #sleep    60
    #GIVEN An anonymous user on the Video Tutorials page
    #WHEN The user selects test product in the ‘Select your product to view available Video Tutorials’ selector
    #THEN The user on ‘Video and Tutorials’ page of the test product
    #AND The latest version of the test product should be selected
    #AND Video types selector set to ‘All’
    #AND The most recent video should be displayed
    Comment    AND The player size should be big
    #AND The most recent video should NOT be playing
    #WHEN The user changes version on '12.9'
    #THEN The video set is changed
    #AND the user selects the video 'Video - How to use Toad Query Builder' from the videos carousel
    #THEN The selected video 'Video - How to use Toad Query Builder' is loaded to the player
    #AND The video start playing
Play the selected video twice
    Skip the rest of the test case for the following configurations    iPhone_6    iPadAir_2    Samsung_GalaxyS6
    sleep    1
    sleep    2