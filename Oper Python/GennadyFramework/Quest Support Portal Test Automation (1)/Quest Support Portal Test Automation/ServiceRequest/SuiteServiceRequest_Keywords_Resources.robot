*** Settings ***
Resource          ../Resources/ContactSupport_Page_Resources.robot
Resource          ../Resources/ServiceRequest_Page_Resources.robot
Resource          ../Resources/SignIn_Page_Resources.robot
Resource          ../Resources/Commons.robot
Resource          ../Resources/Menu.robot
Resource          ../Resources/Filters.robot
Resource          ../Resources/Locators/MyAccountProfile_Locators.robot
Resource          ../01__Registration/SuiteRegistration_Keywords_Resources.robot
Resource          ../ContactForms/ContactForms_Keywords_Resources.robot
Resource          ../03__Downloads/SuiteDownloads_Keywords_Resources.robot

*** Variables ***
@{list_account}
&{filter_xpathValue}    Product=product    Requester=requester    Status=status    Last Updated=updated    Account ID=account
&{filter_product}    All Products=${EMPTY}
&{filter_requester}    My Service Requests=user    Companywide Requests=all
&{filter_status}    Select All=${EMPTY}    Open=Open    Investigating=Investigating    Updated by Customer=Updated by Customer    Customer Response Requested=Customer Response Requested    Product Update Requested=CR Tracking    RMA=RMA
...               RMA In Progress=RMA In Progress    RMA Requested=RMA Requested    Closed=Closed
&{filter_updated}    7 Days=7    30 Days=30    90 Days=90    180 Days=180    360 Days=360    2 Years=720
&{filter_account}    Select All=${EMPTY}
&{filter_columnTable}    SR Number=1    Title=2    Product=3    Status=4    Last Updated=7

*** Keywords ***
The user clicks the button ''Submit Request'
    Click Element    ${dsg_ContactUs_SubmitButtonLabel_locator}

The user on ‘Submit a Service Request’ page
    Active page should be Submit a Service Request

The user clicks on 'Chat Now'
    Wait Until Page Contains Element    ${dsg_Chat_TriggerText_locator}
    ${locator}=    Replace String    ${dsg_Chat_TriggerText_locator}/..[@class='chat-control hidden-xs contact-drawer open']    xpath=    ${EMPTY}
    ${chat_is_open}=    Get Matching Xpath Count    ${locator}
    Run Keyword IF    ${chat_is_open}==0    Click Element    ${dsg_Chat_TriggerText_locator}

The Premium Char appears
    Wait Until Page Contains Element    ${dsg_Premium_chatHeader_locator}

The user clicks on the button 'Request Pricing'
    Click Element    ${Dsg_Renewal_Request_Pricing_Button_locator}

The user redirects on a new tab to the page 'Renewals Assistance'
    ${locale}=    Evaluate    ("" if "${LOCALE}".lower()=="en-us" else "/${LOCALE}".lower())
    ${url}=    Set Variable    ${SUPPORT_STAGE2_SITE}${locale}/contact-us/renewals
    sleep    10
    Select Window    url=${url}

The user clicks on the button 'Next'
    Close SRModal
    Wait Until Page Contains Element    ${dsg_CreateSR_Next_locator}
    Scroll To Element    ${dsg_CreateSR_Next_locator}
    Focus    ${dsg_CreateSR_Next_locator}
    Click Element    ${dsg_CreateSR_Next_locator}
    Comment    Simulate    ${dsg_CreateSR_Next_locator}    click
    sleep    2
    Comment    Current Page Should Not Contain Errors

Close SRModal
    Close Chat    ${at_chat}
    sleep    5
    ${locator}=    Replace String    ${okButton_divSRModal}    xpath=    ${EMPTY}
    ${show_modal}=    Get Matching Xpath Count    ${locator}
    Run Keyword IF    ${show_modal}!=0    Click Element    ${okButton_divSRModal}
    Close Popup    ${at_popup_opinion}

Clicks on the button 'Save & Go To Confirmation'
    Focus    ${dsg_CreateSR_Save_locator}
    Click Element    ${dsg_CreateSR_Save_locator}

The modal window 'Service Request Submitted Confirmation' appears
    Active page should be Service Request Submitted Confirmation

Number SR from text
    [Arguments]    ${text_value}    ${re_str}
    ${temp_SR}=    Get Regexp Matches    ${text_value}    ${re_str}    1
    ${SR_value}=    Run Keyword IF    "${temp_SR}"!="${EMPTY}" and "${temp_SR}"!="[]"    Evaluate    ${temp_SR}[0]
    ...    ELSE    Set Variable    ${EMPTY}
    [Return]    ${SR_value}

This window contains number SR
    ${msg_text}=    Execute Javascript    return window.document.evaluate("${at_SRConfirmationMsg}", document, null, XPathResult.STRING_TYPE, null).stringValue;
    ${re_str}=    Set Variable IF    '${LOCALE}'!='ja-jp'    .*\\s+([0-9]+)[\\s\.]+.*    [^0-9]*([0-9]+)[^0-9]*
    ${SR}=    Number SR from text    ${msg_text}    ${re_str}
    Set Test Variable    ${SR_number}    ${SR}

The user closes the modal window
    Focus    ${okButton_divSRModal}
    Click Element    ${okButton_divSRModal}

The user on the page SR details
    Active page should be Service Request Details
    Wait Until Page Contains Element    xpath=//h1[@id="LayoutH1"][text()[contains(.,'${SR_number}')]]

The user clicks on the button 'Submit Service Request'
    Wait Until Element Is Visible    ${button_SubmitServiceRequest}
    Focus    ${button_SubmitServiceRequest}
    Click Element    ${button_SubmitServiceRequest}

The modal window 'No Assigned License Number for Account Selected' appears
    Active page should be No Assigned License Number for Account Selected

the user logs in as '${email}'
    ${account}=    Evaluate    next((item for item in @{list_account} if item.get('email')=='${email}'), None)
    Run Keyword if    "${account}" is not "${None}"    SignIn    ${account['email']}    ${account['password']}
    sleep    3

The user selects product '${name_product}'
    Focus    ${product_SubmitServiceRequest}
    Click Element    ${product_SubmitServiceRequest}
    Wait Until Page Contains Element    ${product_list_SubmitServiceRequest}
    ${locator}=    Replace String    ${product_list_SubmitServiceRequest}    "    '
    ${locator}=    Replace String    ${locator}    xpath=    ${EMPTY}
    ${existsItem}=    Get Matching Xpath Count    ${locator}[text()[normalize-space()='${name_product}']]
    Run Keyword IF    ${existsItem}==0    FAIL    Selector does not contain ${name_product}
    ${numItem}=    Execute Javascript    return window.document.evaluate("count(${locator}[text()[normalize-space()='${name_product}']]/preceding-sibling::*)", document, null, XPathResult.NUMBER_TYPE, null).numberValue + 1;
    Scroll To Element    ${locator}[${numItem}]
    Click Element    ${product_list_SubmitServiceRequest}[${numItem}]

The user on the 'My Service Requests' page
    Active page should be My Service Request

The modal window about problem submitting SR does not appear
    Close Chat    ${at_chat}
    ${locator}=    Prepare Locator To JS    ${Entitlement_CreateSR_NotSure_Title_locator}
    ${show_modal}=    Get Matching Xpath Count    ${locator}
    Run Keyword IF    ${show_modal}!=0    Capture Page Screenshot
    Run Keyword IF    ${show_modal}!=0    Fail    Message 'There was problem submitting your Service Request' has appeared
    Comment    Close Popup    ${at_popup_opinion}

The user selects value '${filter_value}' of filter '${filter_name}'
    Comment    the user clicks filter '${filter_name}'
    ${locator}=    Set Variable    xpath=//div[@id='SsrCriteriaAccordion']/div[@data-srf-type='&{filter_xpathValue}[${filter_name}]']
    ${values}=    Set Variable IF    '${filter_name}'=='Product'    &{filter_product}    '${filter_name}'=='Requester'    &{filter_requester}    '${filter_name}'=='Status'
    ...    &{filter_status}    '${filter_name}'=='Last Updated'    &{filter_updated}    &{filter_account}
    ${search_value}=    Evaluate    ${values}.get('${filter_value}', None)
    Comment    ${search_element}=    Set Variable IF    '${search_value}'=='${None}'    xpath=${locator}/div[@class='panel-collapse collapse in']//label[text()[contains(., '${filter_value}')]]/input    xpath=${locator}/div[@class='panel-collapse collapse in']//input[@value='${search_value}']
    Comment    Click Element    ${search_element}
    Select value of filter    ${locator}    ${filter_name}    ${search_value}    ${filter_value}

The modal window 'Support for Trial User' appears
    Active page should be Support for Trial User

The user '${user_account}' created SR for the product '${name_product}'
    GIVEN the user '${user_account}' logged into portal
    Comment    WHEN the user selects 'Contact Support' in the 'Support' menu
    WHEN the user navigates to Contact Support Page
    THEN The user on the Contact Support page
    WHEN the user clicks the button ''Submit Request'
    THEN the user on ‘Submit a Service Request’ page
    WHEN the user selects product '${name_product}'
    AND the user selects 'ALISO VIEJO_TST - TEST ACCOUNT - PORTAL QA AUTOMATION (1-3Q551PB)' in the 'Account ID' selector
    AND the user clicks on the button 'Next'
    THEN the modal window about problem submitting SR does not appear
    AND the user fills requered filds
    AND Clicks on the button 'Save & Go To Confirmation'
    AND If 'Product Alert' modal window appears the user clicks on the 'Continue' button
    THEN the user on the page KB Articles that may match the issue
    WHEN the user clicks on the button 'Submit Service Request'
    THEN the modal window 'Service Request Submitted Confirmation' appears
    AND this window contains number SR
    WHEN the user closes the modal window
    THEN the user on the page SR details
    The User Sign out
    Close Working Session

The user fills requered filds
    sleep    5
    ${valueVersion}=    JS Get Value from List by Index    ${xpath_to_field}//select[@id='&{contactInformation_field}[Product Model]']    2
    Select '${valueVersion}' in the 'Product Model' selector
    Set text 'My Descriptive Title' to field 'Descriptive Title'
    Set text 'My Description of the Problem' to field 'Description of the Problem'
    Set text 'My Environment Details' to field 'Environment Details'
    Select '${dsg_CreateSR_ContactByEmail}' in the 'Contact me by' selector

Clicks the button 'Go Search'
    Comment    sleep    2
    Highlight Element    ${dsg_searchsr_refresh_locator}
    Focus    ${dsg_searchsr_refresh_locator}
    Click Element    ${dsg_searchsr_refresh_locator}

The user set the value '${value}' to filter '${filter_name}'
    the user sees table of SR results
    Set Test Variable    ${xpath_to_field}    ${SSRInputWell}
    Set '${value}' to field '${filter_name}'
    sleep    1

SR '${value}' has been found
    The user sees table of SR results
    ${locator}=    Replace String    ${table_SRSearchResults}    "    '
    ${locator}=    Replace String    ${locator}    xpath=    ${EMPTY}
    ${existsItem}=    Get Matching Xpath Count    ${locator}//tbody/tr[@data-uniqueid='${value}']
    Run Keyword IF    ${existsItem}==0    Capture Page Screenshot
    Run Keyword IF    ${existsItem}==0    Fail    SR '${value}' not found
    ${countItems}=    Get Matching Xpath Count    ${locator}//tbody/tr
    Run Keyword IF    ${countItems}>1    Capture Page Screenshot
    Run Keyword IF    ${countItems}>1    Fail    Table of search results contains ${countItems} of records, but it should contain not more 1.

The user clicks title of SR '${value}'
    ${locator}=    Replace String    ${table_SRSearchResults}    "    '
    ${locator}=    Replace String    ${locator}    xpath=    ${EMPTY}
    ${existsItem}=    Get Matching Xpath Count    ${locator}//tbody/tr[@data-uniqueid='${value}']/td[2]/a
    Run Keyword IF    ${existsItem}==0    Fail    Link of title SR '${value}' not found
    Focus    ${table_SRSearchResults}//tbody/tr[@data-uniqueid='${value}']/td[2]/a
    Click Element    ${table_SRSearchResults}//tbody/tr[@data-uniqueid='${value}']/td[2]/a

The user clicks 'Add Attachments'
    Wait Until Page Contains Element    ${dsg_SR_AddAttachments_locator}
    Scroll To Element    ${dsg_SR_AddAttachments_locator}
    Focus    ${dsg_SR_AddAttachments_locator}
    Click Element    ${dsg_SR_AddAttachments_locator}
    sleep    2

The modal window 'Update Service Request' appears
    Active page should be Update Service Request

The user clicks 'Add Note'
    Wait Until Page Contains Element    ${dsg_SR_AddNote_locator}
    Scroll To Element    ${dsg_SR_AddNote_locator}
    Focus    ${dsg_SR_AddNote_locator}
    Click Element    ${dsg_SR_AddNote_locator}
    sleep    2

The modal window 'Add Service Request Note' appears
    Active page should be Add Service Request Note

The user sees table of SR results
    sleep    3
    Table Is Enabled    ${table_SRSearchResults}

The user clicks title of SR
    ${locator}=    Replace String    ${table_SRSearchResults}    "    '
    ${locator}=    Replace String    ${locator}    xpath=    ${EMPTY}
    ${existsItem}=    Get Matching Xpath Count    ${locator}//tbody/tr[1]/td[2]/a
    Run Keyword IF    ${existsItem}==0    Fail    Link of title SR not found
    Focus    ${table_SRSearchResults}//tbody/tr[1]/td[2]/a
    Click Element    ${table_SRSearchResults}//tbody/tr[1]/td[2]/a

The user clicks 'Return to my search'
    Focus    ${returnToMySearch_locator}
    Click Element    ${returnToMySearch_locator}

The user clicks filter '${filter_name}'
    Click Filter    //div[@id='SsrCriteriaAccordion']/div[@data-srf-type='&{filter_xpathValue}[${filter_name}]']
    Comment    ${locator}=    Set Variable    //div[@id='SsrCriteriaAccordion']/div[@data-srf-type='&{filter_xpathValue}[${filter_name}]']
    Comment    ${filter_is_collapsed}=    Get Matching Xpath Count    ${locator}//h4[@class='panel-title']/a[@class='collapsed']
    Comment    Wait Until Element Is Enabled    xpath=${locator}//h4[@class='panel-title']/a[@class='collapsed']
    Comment    Comment    Scroll To Element    xpath=${locator}
    Comment    Focus    xpath=${locator}//h4[@class='panel-title']/a
    Comment    Run Keyword IF    ${filter_is_collapsed}!=0    Click Element    xpath=${locator}//h4[@class='panel-title']/a[@class='collapsed']
    Comment    Wait Until Page Contains Element    xpath=${locator}/div[@class='panel-collapse collapse in']

Scrolls to the button 'Go Search' and clicks
    Scroll To Element    ${filters_GoSearch_button}
    Wait Until Element Is Enabled    ${filters_GoSearch_button}
    Focus    ${filters_GoSearch_button}
    Comment    ${locator}=    Prepare Locator To JS    ${filters_GoSearch_button}
    Comment    Execute Javascript    window.document.evaluate("${locator}", document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue.click();
    Click Element    ${filters_GoSearch_button}
    Scroll To Element    ${appliedFilter_Product}
    Comment    Wait Until Page Contains Element    ${filters_GoSearch_button}[@disabled='disabled']

Search of SR with value '${value}' of filter '${filter}' has been performed
    The user sees table of SR results
    ${locator}=    Replace String    ${table_SRSearchResults}    "    '
    ${locator}=    Replace String    ${locator}    xpath=    ${EMPTY}
    ${countRow}=    Get Matching Xpath Count    ${locator}//tbody/tr
    ${countSearchItem}=    Get Matching Xpath Count    ${locator}//tbody/tr/td[&{filter_columnTable}[${filter}]][text()='${value}']
    ${noRecords}=    Get Matching Xpath Count    ${locator}//tbody/tr[@class='no-records-found']
    Run Keyword IF    ${noRecords}==0 and ${countSearchItem}!=${countRow}    Capture Page Screenshot
    Run Keyword IF    ${noRecords}==0 and ${countSearchItem}!=${countRow}    Fail    The table contains wrong results
    Comment    ${countItems}=    Get Matching Xpath Count    ${locator}//tbody/tr
    Comment    Run Keyword IF    ${countItems}>1    Fail    Table of search results contains ${countItems} of records, but it should contain not more 1.

Search of SR for ${period} has been performed
    The user sees table of SR results
    ${list}=    Get Values of Column Table to List    ${table_SRSearchResults}//tbody/tr    &{filter_columnTable}[Last Updated]

Get Values of Column Table to List
    [Arguments]    ${row_locator}    ${num_column}
    ${value_list}=    Create List
    ${locator}=    Replace String    ${row_locator}    "    '
    ${locator}=    Replace String    ${locator}    xpath=    ${EMPTY}
    ${count_item}=    Get Matching Xpath Count    ${locator}
    : FOR    ${index}    IN RANGE    ${count_item}
    \    ${value}=    Execute Javascript    return window.document.evaluate("${locator}[${index}+1]/td[${num_column}]//text()[normalize-space()]", document, null, XPathResult.STRING_TYPE, null).stringValue
    \    ${value}=    Get Regexp Matches    ${value}    \\s*(.*)\\s*$    1
    \    ${value}=    Run Keyword IF    "${value}"!="[]"    Evaluate    ${value}[0]
    \    ...    ELSE    Set Variable    ${EMPTY}
    \    Append To List    ${value_list}    ${value}
    [Return]    ${value_list}

The results table contains ${count} rows
    The user sees table of SR results
    ${locator}=    Replace String    ${table_SRSearchResults}    "    '
    ${locator}=    Replace String    ${locator}    xpath=    ${EMPTY}
    ${countRow}=    Get Matching Xpath Count    ${locator}//tbody/tr
    ${noRecords}=    Get Matching Xpath Count    ${locator}//tbody/tr[@class='no-records-found']
    Run Keyword IF    (${count}==0 and ${noRecords}==0 and ${countRow}!=0) or (${count}!=0 and (${noRecords}!=0 or ${count}!=${countRow}))    Capture Page Screenshot
    Run Keyword IF    (${count}==0 and ${noRecords}==0 and ${countRow}!=0) or (${count}!=0 and (${noRecords}!=0 or ${count}!=${countRow}))    Fail    Results table is wrong

The modal window 'Expired Maintenance' appears
    Modal window should be Expired Maintenance

The user selects "${value}" radio button for "Is this service request for a customer?"
    ${value}=    Set Variable IF    "${value}"=="No"    0    1
    Wait Until Element Is Visible    xpath=//input[@type='radio' and @name='radio-3' and (@value='${value}' or @id='${value}')]
    Select Radio Button    radio-3    ${value}

The user navigates to Contact Support Page
    Navigate to Contact Support Page

The Soft Fail advisory message appears
    Modal window should be Expired Maintenance Soft Fail
    ${locator}=    Prepare Locator To JS    ${Entitlement_CreateSR_SoftFailContract_Mesg_locator}
    ${message_text}=    Execute Javascript    return window.document.evaluate("${locator}", document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue.innerHTML
    ${message_text}=    Replace String Using Regexp    ${message_text}    <!--.*-->    ${EMPTY}
    ${message_text}=    Replace String Using Regexp    ${message_text}    <\\s+\/    </
    ${dsg_var}=    Replace String Using Regexp    ${Entitlement_SoftFailContract_Mesg}    \{strGlobalPartNumber\}    ${SOFT_FAIL}
    ${dsg_var}=    Replace String Using Regexp    ${dsg_var}    <!--.*-->    ${EMPTY}
    ${dsg_var}=    Replace String Using Regexp    ${message_text}    <\\s+\/    </
    Should Contain    ${message_text}    ${dsg_var}

If 'Product Alert' modal window appears the user clicks on the 'Continue' button
    Close Chat    ${at_chat}
    ${locator}=    Prepare Locator To JS    ${dsg_CreateSR_Alert_Title_locator}
    ${show_modal}=    Get Matching Xpath Count    ${locator}
    Run Keyword IF    ${show_modal}!=0    Click Element    ${okButton_divSRModal}

If 'No Assigned License Number for Account Selected' modal window appears the user clicks on the 'Ok' button
    Close Chat    ${at_chat}
    ${locator}=    Prepare Locator To JS    ${dsg_SR_TrialAltAcctMsgTitle_locator}
    ${show_modal}=    Get Matching Xpath Count    ${locator}
    Run Keyword IF    ${show_modal}!=0    Click Element    ${okButton_divSRModal}
