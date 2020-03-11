*** Variables ***
${dsg_Download_Page_Title_locator}    xpath=//h1[@id="LayoutH1"][text()[contains(.,'${dsg_dload-rls_page-title}')]]
${dsg_home_ToolsTitle_dnr_locator}    xpath=//div[@id="Tools"]//span[@class="tools-title"][text()[contains(., '${dsg_home_ToolsTitle_dnr}')]]
${download_links}    xpath=(//i[@class="i-small-download"]/..)
${application_links}    xpath=(//i[@class="i-small-download"]/ancestor::tr//a[not(child::*)])
${download_links_with_notification}    xpath=(//i[@class='i-small-download'][./ancestor::tr[//a[not(child::*)] and .//*[@class='downloads-notification-icon']]]/..)
${dsg_Download_AddToFolder_locator}    xpath=//div[@class='modal-content']//h3[text()[contains(., '${dsg_Download_AddToFolder}')]]//ancestor::div[@id='download-1' or @id='download-2']
${dsg_Download_AddToFolder_link}    ${dsg_Download_AddToFolder_locator}[@aria-hidden='false']//a[text()[contains(., '${dsg_Download_AddToFolder}')]]
${dsg_Download_AddToFolder_Notification}    ${dsg_Download_AddToFolder_locator}[@aria-hidden='false']//div[@id='NotificationWidget' and not(@style='display: none;')]
${dsg_General_ErrorTitle_locator}    xpath=//div[@class="modal-content"]//h3[.//text()[contains(.,"${dsg_General_ErrorTitle}")]]
${Entitlement_Download_HardFailContract_Title_locator}    xpath=//div[@class="modal-content"]//h3[.//text()[contains(.,"${Entitlement_Download_HardFailContract_Title}")]]
${dsg_ExpiredMaintenance_HardFail_Message_locator}    xpath=//div[@class="modal-content"]/div[@class="modal-body"]
${buttonClose_HardFail}    ${Entitlement_Download_HardFailContract_Title_locator}/../button[@class="close"]
${dsg_InstallDetail_AddToDownloads_locator}    xpath=//div[@class="action-buttons"]//a[text()[contains(., "${dsg_InstallDetail_AddToDownloads}")]]
${url_To_CartDownload}    /my-downloads
${dsg_DownloadFolder_MyDownloads_locator}    xpath=//h1[@id="LayoutH1"][text()[contains(.,"${dsg_DownloadFolder_MyDownloads}")]]
${table_download}    xpath=//div[@class="my-downloads-list"]//div[@class="left-text-table"]/table
${Entitlement_ExpiredMaintenance_Title_locator}    xpath=//div[@class="modal-content"]//h3[.//text()[contains(.,"${Entitlement_ExpiredMaintenance_Title}")]]
${Entitlement_Download_SoftFailContract_Title_locator}    xpath=//div[@class="modal-content"]//h3[.//text()[contains(.,"${Entitlement_Download_SoftFailContract_Title}")]]
${dsg_dload-install_extraDetail_locator}    xpath=//ul[@id="BreadCrumbs"]/li[text()[contains(., '${dsg_dload-install_extraDetail}')]]
${buttonClose_SoftFail}    ${Entitlement_Download_SoftFailContract_Title_locator}/../button[@class="close"]
${dsg_General_ChooseDifferentProduct_locator}    xpath=//a[@data-i18n="dsg_General_ChooseDifferentProduct"]
${list_alphabetsatoz}    xpath=//ul[@class="alphabetsatoz"]
${list_ProductsWrap}    xpath=//div[@id="ProductsWrap"]
${search_input}    xpath=//div[@class="search-holder advanced-search"]/input
${search_button}    xpath=//div[@class="search-holder advanced-search"]/button
${button_delete_filter_version}    xpath=//div[@class="filter-results"]//span[text()[contains(., '${Endeca_ProductVersion}')]]//i
${search_results_articles}    //div[@class="article-results even-list center-content"]//div[@class="article"]
${button_clear}    xpath=//a[text()[contains(., '${dsg_search_clear_button_text}')]]
${input_search}    xpath=//input[@id="txtKeyword"]
${email_icon}     xpath=//span[@class="i-small-mail"]
${dsg_Home_EmailHead_locator}    xpath=//div[@class="modal-content"]//h3[text()[contains(., '${dsg_Home_EmailHead}')]]
${MyDownloads_icon}    xpath=//span[@class="i-small-cart"]
${Endeca_Product Version_locator}    xpath=//div[@class="filter-results"]//span[text()[contains(., "${Endeca_Product Version}")]]
${count_results_locator}    xpath=//div[@class="article-results even-list center-content"]//div[@class="results-utility"]//span[@class="results"]
${dsg_General_ErrorRequest_locator}    ${dsg_ExpiredMaintenance_HardFail_Message_locator}//*[@id="EntitlementMsgContent"]
${wBrandDisclaimerDialog}    xpath=//div[@id='wBrandDisclaimerDialog' and @aria-hidden='false']
${wBrandDisclaimerDialog_btn_continue}    xpath=//div[@id='wBrandDisclaimerDialog' and @aria-hidden='false']//input[@value='${General_Continue}']
