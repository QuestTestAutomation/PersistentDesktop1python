*** Settings ***
Resource          ../Commons.robot

*** Variables ***
${dsg_Videos_Page_Title_locator}    xpath=//h1[@id="LayoutH1"][text()[contains(.,'${dsg_Videos_Page_Title}')]]
${dsg_VideoTutorial_PageTitle_locator}    xpath=//h1[@id="LayoutH1"][text()[contains(.,'${TEST_PRODUCT} - ${dsg_VideoTutorial_PageTitle}')]]
${dsg_VideoTutorials_category_selector_locator}    xpath=//select[@id="TabActionId"]
${at_active_video_title_locator}    xpath=//div[@id="VideoPlayer"]//div[@class="vjs-dock-title" and @id="vjs-dock-title-1"]
${at_active_video_current_time_locator}    xpath=//div[@id="VideoPlayer"]//div[@class="vjs-tooltip-progress-bar vjs-slider-bar"]@data-current-time
${at_video_play_button}    xpath=//button[@class="vjs-big-play-button"]
${at_carousel_video}    xpath=//div[@class="carousel-holder carousel-social no-icons"]//div[@class="slide"]
${at_video_player}    xpath=//div[@aria-label="video player"]
${at_version_selector_videoPage}    xpath=//select[@id='verName']
