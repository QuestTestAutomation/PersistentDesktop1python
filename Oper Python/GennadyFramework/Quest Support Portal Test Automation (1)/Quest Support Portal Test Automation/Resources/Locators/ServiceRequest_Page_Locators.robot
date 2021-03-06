*** Variables ***
${dsg_ContactUs_SubmitButtonLabel_locator}    xpath=//a[text()[contains(., "${dsg_ContactUs_SubmitButtonLabel}")]]
${dsg_SR_SubmitSR_Title_locator}    xpath=//h1[@id="LayoutH1"][text()[contains(.,'${dsg_SR_SubmitSR}')]]
${product_SubmitServiceRequest}    xpath=//div[@id='divSelProd']//input    # xpath=//div[@id='divSelProd']//input[@placeholder[contains(., '${dsg_DropDown_ProductDefaultValue}')]]
${dsg_Chat_TriggerText_locator}    xpath=//div[@id='partialChatWindow']//div[contains(text(), '${dsg_Chat_TriggerText}')]
${dsg_Premium_chatHeader_locator}    xpath=//div[@id='partialChatWindow']//div[@class='chat-content contact-drawer-panel']//li[@class='chatHeader'][.//text()[contains(., '${dsg_Premium_chatHeader}')]]
${Dsg_Renewal_Request_Pricing_Button_locator}    xpath=//div[@id='partialChatWindow']//div[@class='chat-content contact-drawer-panel']//a[text()[contains(., '${Dsg_Renewal_Request_Pricing_Button}')]]
${product_list_SubmitServiceRequest}    xpath=//div[@id='divSelProd']//div[@class="selectize-dropdown-content"]/div
${divSRModal}     xpath=//div[@id='divSRModal']
${okButton_divSRModal}    ${divSRModal}[@aria-hidden='false']//a[@id='ok-button']
${dsg_CreateSR_Next_locator}    xpath=//div[@id='divSelProd']//a[@id="next-button"]
${at_SR_create}    xpath=//div[@id='SR_create']
${dsg_CreateSR_Save_locator}    xpath=//div[@id='SR_create']//input[@id='save-button']
${dsg_CreateSR_SRConfirmation_locator}    ${divSRModal}[@aria-hidden='false']//div[@class='modal-header']//h3[text()[contains(., '${dsg_CreateSR_SRConfirmation}')]]
${at_SRConfirmationMsg}    concat(//div[@id='divSRModal']//p[@id='SRModalContent']//text()[1], //div[@id='divSRModal']//p[@id='SRModalContent']//text()[2], //div[@id='divSRModal']//p[@id='SRModalContent']//text()[3], //div[@id='divSRModal']//p[@id='SRModalContent']//text()[4], //div[@id='divSRModal']//p[@id='SRModalContent']//text()[5], //div[@id='divSRModal']//p[@id='SRModalContent']//text()[6], //div[@id='divSRModal']//p[@id='SRModalContent']//text()[7], //div[@id='divSRModal']//p[@id='SRModalContent']//text()[8], //div[@id='divSRModal']//p[@id='SRModalContent']//text()[9], //div[@id='divSRModal']//p[@id='SRModalContent']//text()[10])
${dsg_SRDetail_ServiceRequest#_Title_locator}    xpath=//h1[@id="LayoutH1"][text()[contains(.,'${dsg_SRDetail_ServiceRequest#}')]]
${button_SubmitServiceRequest}    xpath=//div[@id='KB_articles']//a[@id='lnkSubmitRequest']
${dsg_SR_TrialAltAcctMsgTitle_locator}    ${divSRModal}[@aria-hidden='false']//div[@class='modal-header']//h3[text()[contains(., '${dsg_SR_TrialAltAcctMsgTitle}')]]
${dsg_SearchSR_MySR_Title_locator}    xpath=//h1[@id="LayoutH1"][text()[contains(.,'${dsg_SearchSR_MySR}')]]
${appliedFilter_Product}    xpath=//div[@id='SRFAppliedFilter']//span[./span[text()[contains(., '${dsg_General_Product}')]]]
${appliedFilter_Requester}    xpath=//div[@id='SRFAppliedFilter']//span[./span[text()[contains(., '${dsg_SearchSR_ByAccounts}')]]]
${appliedFilter_Date}    xpath=//div[@id='SRFAppliedFilter']//span[./span[text()[contains(., '${dsg_SearchSR_ByDate}')]]]
${appliedFilter_Status}    xpath=//div[@id='SRFAppliedFilter']//span[./span[text()[contains(., '${dsg_SearchSR_ByStatus}')]]]
${Entitlement_CreateSR_NotSure_Title_locator}    ${divSRModal}[@aria-hidden='false']//h3[@id='SRModalTitle'][text()[contains(., '${Entitlement_CreateSR_NotSure_Title}')]]
${filter_product_locator}    xpath=//div[@id='SsrCriteriaAccordion']/div[@data-srf-type='product']
${filter_requester_locator}    xpath=//div[@id='SsrCriteriaAccordion']/div[@data-srf-type='requester']
${filter_status_locator}    xpath=//div[@id='SsrCriteriaAccordion']/div[@data-srf-type='status']
${filter_updated_locator}    xpath=//div[@id='SsrCriteriaAccordion']/div[@data-srf-type='updated']
${Entitlement_CreateSR_TrialUser_Title_locator}    ${divSRModal}//div[@class='modal-header']//h3[text()[contains(., '${Entitlement_CreateSR_TrialUser_Title}')]]
${SSRInputWell}    xpath=//div[@id='SSRInputWell']
${dsg_searchsr_refresh_locator}    xpath=//div[@id='SSRInputWell']//a[text()[contains(., '${dsg_searchsr_refresh}')]]
${table_SRSearchResults}    xpath=//table[@id='SRSearchResults']
${dsg_SR_AddAttachments_locator}    xpath=//div[@id='tab1']//a[text()[contains(., '${dsg_SR_AddAttachments}')]]
${dsg_SR_UpdateSR_locator}    xpath=//div[@id='attach-modal'][@aria-hidden='false']//div[@class='modal-header']//h3[text()[contains(., '${dsg_SR_UpdateSR}')]]
${AttachFile_locator}    xpath=//div[@id='attach-modal'][@aria-hidden='false']//input[@id='SRDetail_upload']
${dsg_SR_AttachToRequest_locator}    xpath=//div[@id='attach-modal'][@aria-hidden='false']//button[text()[contains(., '${dsg_SR_AttachToRequest}')]]
${attach-modal}    xpath=//div[@id='attach-modal']
${dsg_SR_AddNote_locator}    xpath=//div[@id='tab1']//a[text()[contains(., '${dsg_SR_AddNote}')]]
${dsg_SRDetail_AddSRNote_locator}    xpath=//div[@id='note-modal'][@aria-hidden='false']//div[@class='modal-header']//h3[text()[contains(., '${dsg_SRDetail_AddSRNote}')]]
${SRNote_field}    xpath=//div[@id='note-modal'][@aria-hidden='false']//textarea
${dsg_SR_AddNote_button}    xpath=//div[@id='note-modal'][@aria-hidden='false']//button[text()[contains(., '${dsg_SR_AddNote}')]]
${dsg_SRDetail_RequestHistory_tag}    xpath=//div[@id='SRDetailTabs']//a[@role='tab'][text()[contains(., '${dsg_SRDetail_RequestHistory}')]]
${note-modal}     xpath=//div[@id='note-modal']
${dsg_ProductSwap_ExpandAll_button}    xpath=//div[@id='SRDetailTabs']//div[@id='tab2']//a[text()[contains(., '${dsg_ProductSwap_ExpandAll}')]]
${RequestHistory_table}    xpath=//div[@id='SRDetailTabs']//div[@id='tab2']//table
${returnToMySearch_locator}    xpath=//div[@id='ServiceRequestDetails']//i[@class='i-action-return-arrow']
${filters_GoSearch_button}    xpath=//div[@id='SsrCriteriaAccordion']//a[text()[contains(., '${dsg_searchsr_refresh}')]]
${Entitlement_ExpiredMaintenance_Title_locator}    ${divSRModal}[@aria-hidden='false']//div[@class='modal-header']//h3[@id='SRModalTitle'][text()[contains(., '${Entitlement_ExpiredMaintenance_Title}')]]
${Entitlement_CreateSR_HardFailContract_Title_locator}    ${divSRModal}[@aria-hidden='false']//div[@class='modal-header']//h3[@id='SRModalTitle'][text()[contains(., '${Entitlement_CreateSR_HardFailContract_Title}')]]
${Entitlement_ExpiredMaintenance_HardFail_Mesg_locator}    ${divSRModal}[@aria-hidden='false']//p[@id='SRModalContent'][text()[contains(., '${Entitlement_ExpiredMaintenance_HardFail_Mesg}')]]
${Entitlement_CreateSR_ExpiredMaintenance_HardFail_Mesg_locator}    ${divSRModal}[@aria-hidden='false']//p[@id='SRModalContent'][text()[contains(., '${Entitlement_CreateSR_ExpiredMaintenance_HardFail_Mesg}')]]
${Entitlement_CreateSR_SoftFailContract_Title_locator}    ${divSRModal}[@aria-hidden='false']//div[@class='modal-header']//h3[@id='SRModalTitle'][text()[contains(., '${Entitlement_CreateSR_SoftFailContract_Title}')]]
${Entitlement_CreateSR_SoftFailContract_Mesg_locator}    ${divSRModal}[@aria-hidden='false']//p[@id='SRModalContent']
${dsg_CreateSR_Alert_Title_locator}    ${divSRModal}[@aria-hidden='false']//div[@class='modal-header']//h3[@id='SRModalTitle'][text()[contains(., '${dsg_CreateSR_Alert_Title}')]]
