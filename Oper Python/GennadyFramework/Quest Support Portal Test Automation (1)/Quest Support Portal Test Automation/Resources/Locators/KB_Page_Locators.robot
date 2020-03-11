*** Variables ***
${form_KBSearch}    xpath=//form[@id='KBSearch']
${dsg_LandingKnowledgeBase_Page_Title_locator}    xpath=//h1[@id="LayoutH1"][text()[contains(.,'${dsg_LandingKnowledgeBase_Page_Title}')]]
${dsg_home_toolsTitle_knowledgeBase_locator}    xpath=//div[@id="Tools"]//span[@class="tools-title"][text()[contains(., '${dsg_home_toolsTitle_knowledgeBase}')]]
${input_txtKbAutoCompleteKeyword}    ${form_KBSearch}//input[@id='txtKbAutoCompleteKeyword']
${search_button}    ${form_KBSearch}//button/i[@class='i-small-searchleft']
${list_articles}    xpath=//div[@id='KbTabSet']//div[@class='article']
${kbContent_locator}    xpath=//div[@id="MainContent"]
