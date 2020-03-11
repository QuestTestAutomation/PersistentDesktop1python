*** Settings ***
Resource          ../Resources/Video_Page_Resources.robot
Resource          ../Resources/Commons.robot

*** Variables ***
${itemVersion}    ${EMPTY}
${itemCategory}    ${EMPTY}

*** Keywords ***
An anonymous user on the Video Tutorials page
    Open Video Tutorials Page
    Close Popup    ${at_popup_opinion}

The user selects test product in the ‘Select your product to view available Video Tutorials’ selector
    Select Product in Product Search element    ${TEST_PRODUCT}

The user on ‘Video and Tutorials’ page of the test product
    Active page should be Video Tutorials page for the Test product

The latest version of the test product should be selected
    Should be selected the latest version
    ${latest_version}=    Get Element Attribute    ${at_version_selector_videoPage}/option[@selected="selected"]@value
    Set Test Variable    ${itemVersion}    ${latest_version}

Video types selector set to ‘All’
    Should be selected category of Video Tutorials    All
    Set Test Variable    ${itemCategory}    All

The most recent video should be displayed
    log    To refactor as brightcove id is not the same as video text
    Comment    ${vid_list}=    Get List Video By Product, Version and Category    Toad for Oracle    12.8
    Comment    ${expected_topmost_video}=    Set Variable    ${vid_list[0]['VideoText']}
    Comment    ${actual_topmost_video}=    Get Active Video Title
    Comment    Should Be Equal As Strings    ${actual_topmost_video}    ${expected_topmost_video}    The most recent video should be '${expected_topmost_video}' but in fact it was '${actual_topmost_video}'

The player size should be big

The most recent video should NOT be playing
    Active Video Should Not Be Playing

The visitor clicks the Play button
    Click Play Button

The video start playing
    Active Video Should Be Playing

The selected video '${title}' is loaded to the player
    Video is selected and loaded    title_video=${title}

The video should NOT be playing
    Active Video Should Not Be Playing

The user selects the video '${title}' from the videos carousel
    Select Video From the Videos Carousel by Title    ${title}

The user sets video types selector to '${category}'
    Set Test Variable    ${itemCategory}    ${category}
    Filtering Video by Category    ${itemCategory}
    sleep    3

The video set is changed
    sleep    1

Frontend and backend video sets are equal
    Active page should be Video Tutorials page for the Test product
    sleep    2
    Comment    ${version_label}=    Get Selected List Value    ${at_version_selector}
    Comment    ${category_label}=    Get Selected List Label    ${dsg_VideoTutorials_category_selector_locator}
    ${frontend_list_video}=    Get List Video From the Videos Carousel
    ${backend_list_video}=    Get List Video By Product, Version and Category    ${TEST_PRODUCT}    ${itemVersion}    ${itemCategory}    ${LOCALE}
    ${compare_json}=    Compare Json    ${frontend_list_video}    ${backend_list_video}
    ${diff_json}=    Run Keyword IF    ${compare_json}==${FALSE}    Difference Json    ${frontend_list_video}    ${backend_list_video}
    ...    ELSE    Set Variable    ${EMPTY}
    log many    ${diff_json}
    Should Be True    ${compare_json}==${TRUE}    Video sets are not equal but should (product:${TEST_PRODUCT}, version: ${itemVersion}, category: ${itemCategory}).
    Comment    Should Be Equal    ${frontend_list_video}    ${backend_list_video}    Frontend and backend video sets are not equal but should

The user changes version on '${version_name}'
    Set Test Variable    ${itemVersion}    ${version_name}
    Filtering Video by Version    ${itemVersion}
    sleep    3

The user changes country on '${country}'
    Close Popup    ${at_popup_opinion}
    ${locale}=    Set Country to '${country}'
    Import Variables    ${CURDIR}/../Resources/SupportTranslations/TranslationVarsDB.py    ${SUPPORT_STAGE2_DB_CONNECTION_STRING}    ${locale}    ${MULTIBRANDING_SITE}
    Set Test Variable    ${dsg_VideoTutorial_PageTitle_locator}    xpath=//h1[@id="LayoutH1"][text()[contains(.,'${TEST_PRODUCT} - ${dsg_VideoTutorial_PageTitle}')]]
    sleep    2
