*** Settings ***
Library           Selenium2Library
Library           HttpLibrary.HTTP
Resource          Commons.robot
Resource          Locators/Video_Tutorials_Page_Locators.robot
Resource          Locators/Main_Page_Locators.robot
Library           DateTime

*** Variables ***
${check_video_is_playing_interval}    7

*** Keywords ***
Open Video Tutorials Page
    Open Support Portal Anonimously
    Page Should Contain Element    ${dsg_home_ToolsTitle_vt_locator}
    Scroll To Element    ${dsg_home_ToolsTitle_vt_locator}
    Highlight Element    ${dsg_home_ToolsTitle_vt_locator}
    Click Link    ${dsg_home_ToolsTitle_vt_locator}/..
    Current Page Should Not Contain Errors
    Wait Until Page Contains Element    ${dsg_Videos_Page_Title_locator}
    Location Should Contain    /videos-product-select

Active page should be Video Tutorials page for the Test product
    Wait Until Page Contains Element    ${dsg_VideoTutorial_PageTitle_locator}

Should be selected category of Video Tutorials
    [Arguments]    ${video_category_name}
    Page Should Contain Element    xpath=//select[@id="TabActionId"]
    Highlight Element    xpath=//select[@id="TabActionId"]
    ${selected_item_label}=    Get Selected List Label    xpath=//select[@id="TabActionId"]
    Should Be Equal As Strings    ${video_category_name}    ${selected_item_label}    Should be selected '${video_category_name}' videos category but in fact selected category is \ '${selected_item_label}'

Active Video Should Not Be Playing
    Active page should be Video Tutorials page for the Test product
    ${current_position_before}=    Get Current Position in Active Video
    sleep    ${check_video_is_playing_interval}
    ${current_position_after}=    Get Current Position in Active Video
    Should Be Equal As Strings    ${current_position_before}    ${current_position_after}    Video is playing. But it should NOT.

Active Video Should Be
    [Arguments]    ${name_of_active_video}
    Active page should be Video Tutorials page for the Test product
    ${active_video}=    Get Active Video Title
    Should Be Equal As Strings    ${active_video}    ${name_of_active_video}    Active video is '${active_video}' but in fact active should be '${name_of_active_video}'

Get Active Video Title
    Active page should be Video Tutorials page for the Test product
    ${active_video_title}=    Get Text    ${at_active_video_title_locator}
    [Return]    ${active_video_title}

Get Current Position in Active Video
    Active page should be Video Tutorials page for the Test product
    Wait Until Page Contains Element    ${at_video_player}
    ${current_video_position}=    Get Element Attribute    ${at_active_video_current_time_locator}
    ${current_video_position_time}=    Convert Time    ${current_video_position}    exclude_millis=true
    ${current_video_position_time}=    Convert To String    ${current_video_position_time}
    ${current_video_position_time}=    Replace String    ${current_video_position_time}    .0    ${EMPTY}
    ${current_video_position}=    Convert To Integer    ${current_video_position_time}
    [Return]    ${current_video_position}

Click Play Button
    Active page should be Video Tutorials page for the Test product
    Scroll To Element    ${at_video_play_button}
    Page Should Contain Element    ${at_video_play_button}
    Comment    Mouse Down    ${at_video_play_button}
    Click Button    ${at_video_play_button}
    Wait Until Element Is Not Visible    ${at_video_play_button}

Active Video Should Be Playing
    Active page should be Video Tutorials page for the Test product
    ${first_position}=    Get Current Position in Active Video
    sleep    ${check_video_is_playing_interval}
    ${second_position}=    Get Current Position in Active Video
    Run Keyword IF    ${second_position} == ${first_position} or ${second_position} < ${first_position}    Capture Page Screenshot
    Should Be True    ${second_position} > ${first_position}    The active video is not playing. But it SHOULD be plaing

Select Video From the Videos Carousel
    [Arguments]    ${id_video}=0
    Active page should be Video Tutorials page for the Test product
    Page Should Contain Element    ${at_carousel_video}    For the current version of product does not contain any video
    Scroll To Element    ${at_carousel_video}
    Page Should Contain Element    id=${id_video}    The current version of product does not contain video with id=${id_video}
    Comment    Highlight Element    id=${id_video}
    Click Element    id=${id_video}

Video is selected and loaded
    [Arguments]    ${id_video}=${EMPTY}    ${title_video}=${EMPTY}
    Active page should be Video Tutorials page for the Test product
    ${locator_video}=    Set Variable IF    "${id_video}"=="${EMPTY}"    ${at_carousel_video}//a[.//p/text()="${title_video}"]    ${at_carousel_video}//a[@id='${id_video}']
    ${title_video}=    Get Text    ${locator_video}//p
    ${onclick}=    Get Element Attribute    ${locator_video}@onclick
    ${BrightcoveVideoID}=    Get Regexp Matches    ${onclick}    data-video-id%3D%22([^%]*)%22    1
    ${BrightcoveVideoID}=    Evaluate    ${BrightcoveVideoID}[0]
    log    ${title_video}
    log    ${BrightcoveVideoID}
    Comment    Current Frame Contains    ${title_video}
    Highlight Element    ${locator_video}//p
    ${title_player}=    Get Text    id=vjs-dock-title-1
    Scroll To Element    ${at_video_player}
    ${data_video_id}=    Get Element Attribute    xpath=//div[@id="VideoPlayer"]/div@data-video-id
    Should Be Equal    ${data_video_id}    ${BrightcoveVideoID}

Select Video From the Videos Carousel by Title
    [Arguments]    ${title_video}
    Active page should be Video Tutorials page for the Test product
    Page Should Contain Element    ${at_carousel_video}    For the current version of product does not contain any video
    Page Should Contain Element    ${at_carousel_video}//a[.//p/text()="${title_video}"]    The current version of product does not contain video with title "${title_video}"
    Scroll To Element    ${at_carousel_video}
    Highlight Element    ${at_carousel_video}//a[.//p/text()="${title_video}"]
    Focus    ${at_carousel_video}//a[.//p/text()="${title_video}"]
    Click Link    ${at_carousel_video}//a[.//p/text()="${title_video}"]

Filtering Video by Category
    [Arguments]    ${category}
    Active page should be Video Tutorials page for the Test product
    JS Select Item of DropDown List    ${dsg_VideoTutorials_category_selector_locator}    ${category}

Get List Video From the Videos Carousel
    Active page should be Video Tutorials page for the Test product
    ${locator}=    Replace String    ${at_carousel_video}    xpath=    ${EMPTY}
    ${count}=    Get Matching Xpath Count    ${locator}//div[./a[@class='description']]
    log many    ${count}
    ${video_set}=    Create List
    : FOR    ${index}    IN RANGE    ${count}
    \    ${onclick}=    Get Element Attribute    ${at_carousel_video}//a[@id='${index}']@onclick
    \    ${Brightcove}=    Get Regexp Matches    ${onclick}    data-video-id%3D%22([^%]*)%22    1
    \    ${Brightcove}=    Evaluate    ${Brightcove}[0]
    \    ${title}=    Get Regexp Matches    ${onclick}    Title - (.*)....SC_SetVideoProps    1
    \    ${title}=    Evaluate    ${title}[0]
    \    ${title}=    Evaluate    '${title}'.decode('unicode_escape')
    \    ${val}=    Create Dictionary    Brightcove=${Brightcove}    VideoText=${title}
    \    Comment    ${val}=    Stringify Json    ${val}
    \    Append To List    ${video_set}    ${val}
    log many    ${video_set}
    [Return]    ${video_set}

Filtering Video by Version
    [Arguments]    ${version}
    Active page should be Video Tutorials page for the Test product
    ${version_label}=    Get Text    ${at_version_selector_videoPage}/option[@value="${version}"]
    JS Select Item of DropDown List    ${at_version_selector_videoPage}    ${version_label}

Set Country to '${name_country}'
    ${xpath_list}=    Replace String    ${at_country_list}    "    '
    ${xpath_list}=    Replace String    ${xpath_list}    xpath=    ${EMPTY}
    Scroll To Element    ${at_country_selector}
    Focus    ${at_country_selector}
    Click Element    ${at_country_selector}
    Scroll To Element of List    ${xpath_list}    ${name_country}
    ${href}=    Get Element Attribute    xpath=${xpath_list}//li/a[text()='${name_country}']@href
    ${locale}=    Get Regexp Matches    ${href}    SelectCountry[^,]*,'/(..-..)/.*/videos    1
    ${locale}=    Run Keyword If    "${locale}"=="[]"    Set Variable    ${EMPTY}
    ...    ELSE    Evaluate    ${locale}[0]
    ${locale}=    Set Variable IF    '${locale}'=='${EMPTY}'    en-us    ${locale}
    Click Element    xpath=${xpath_list}//li/a[text()='${name_country}']
    [Return]    ${locale}
