*** Variables ***
${dsg_Home_pageTitle_locator}    //h1[@id="LayoutH1"][text()[contains(., '${dsg_Home_pageTitle}')]]
${dsg_home_ToolsTitle_vt_locator}    xpath=//div[@id="Tools"]//span[@class="tools-title"][text()[contains(., '${dsg_home_ToolsTitle_vt}')]]
${at_country_selector}    xpath=//a[@id="countrySelector"]
${at_country_list}    xpath=//div[@class='popover-content']//div[@id='countryListContent']
${at_button_signIn}    xpath=//div[@id="Profile"]//i[@class="i-small-useraccount"]
${at_Create_Support_User_Label}    xpath=//div[@id='SignInFlyout']//button[text()='${dsg_Create_Support_User_Label}']
${at_element_menu_signIn}    xpath=//div[@id='SignInFlyout']//a[text()[contains(.,'${dsg_General_SignIn}')]]
${at_popup_opinion}    xpath=//div[@id='IPEinvLGL'][not(@style[contains(., 'visibility: hidden')])]//map[@name='IPEMap']//area[@alt='close']
${at_popup_opinion_no}    xpath=//div[@id="IPEinvLGL"]//map[@name="IPEMap"]//area[@alt="no"]
${at_recaptcha}    xpath=//div[@class="recaptcha-checkbox-checkmark"]
${at_version_selector}    xpath=//select[@id='filterVersion']
${at_chat}        xpath=//div[@id="partialChatWindow"and @style="display: block;"]//i[@class="i-action-return-arrow"]
${at_main_menu}    xpath=//div[@id='SubHeader']
${at_i-ui-menucollapsed}    xpath=//i[@class='i-ui-menucollapsed']
${at_menu_Support}    xpath=//div[@id='SubHeader']//li[./a['/kb-product-select'=substring(@href, string-length(@href) - string-length('/kb-product-select') +1)]]/ancestor::li[1]/a
${at_menu_Support_ContactSupport}    xpath=//div[@id='SubHeader']//li[./a[@href= '/create-service-request']]/ancestor::li[1]/a
${at_menu_Support_MyAccount}    xpath=//div[@id='SubHeader']//li[./a[@href= '/search-service-request']]/ancestor::li[1]/a
${at_menu_Support_MyAccount_MyServiceRequest}    xpath=//div[@id='SubHeader']//li/a[@href= '/search-service-request']
${at_menu_Support_MyAccount_MyProducts}    xpath=//div[@id='SubHeader']//li/a[@href= '/my-account']
${at_menu_Support_MyAccount_MyLicenses}    xpath=//div[@id='SubHeader']//li/a[@href= '/my-account/licensing']
${at_menu_Support_MyAccount_MyGroups}    xpath=//div[@id='SubHeader']//li/a[@href= '/my-account/group']
${icon_table-loading}    xpath=//div[@class="fixed-table-loading i-ui-loading"]
${icon_i-ui-loading}    //i[@class[contains(., 'i-ui-loading')]]
${HowToBuy_Title_locator}    xpath=html/head/title[text()[contains(., 'How to Buy')]]
${terms-conditions-modal}    xpath=//div[@id='terms-conditions-modal']
${dsg_AcceptTerms_Modal_Text_locator}    ${terms-conditions-modal}[@aria-hidden='false']//p[text()[contains(., '${dsg_AcceptTerms_Modal_Text}')]]
${terms-conditions-modal_checkbox}    ${dsg_AcceptTerms_Modal_Text_locator}//input[@type='checkbox']
${terms-conditions-modal_continueButton}    ${terms-conditions-modal}[@aria-hidden='false']//a[text()[contains(., '${General_Continue}')]]
${download_table_locator}    xpath=//div[@id="MainContent"]//div[@class="download-table"]
${dsg_ProductAtoZ_Title_locator}    xpath=//h1[@id="LayoutH1"][text()[contains(., "${dsg_ProductAtoZ_Title}")]]
${seeAllProducts_locator}    xpath=//div[@id='Canvas']//a[@data-i18n='dsg_Common_seeAllProducts']