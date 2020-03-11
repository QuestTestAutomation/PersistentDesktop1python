*** Settings ***
Suite Setup       Global Setup
Test Teardown     Close Working Session
Resource          SuiteMyAccount_Keywords_Resources.robot

*** Variables ***

*** Test Cases ***
User navigates to "My Products" page
    [Setup]    Prepare Environment
    GIVEN the user 'quest123.qa@gmail.com' logged into portal
    WHEN the user selects 'My Account' option from the top masthead
    THEN the user on the 'My Products' page
    AND the user sees table of products
    AND the user sees the 'Support Status' column of Product table
    AND the user can see detail info after clicking on the value of column 'Support Status'
    AND the user sees the 'Open Cases' column of Product table
    AND the user can see detail info after clicking on the value of column 'Open Cases'
    AND the user sees the 'News & Alerts' column of Product table
    AND the user can see detail info after clicking on the value of column 'News & Alerts'
    AND the user sees the 'Last Download' column of Product table
    AND the user can see detail info after clicking on the value of column 'Last Download'
    AND the user sees the 'My Products' column of Product table
    Comment    AND the user can go to the support page of product after clicking on the title
    AND the user sees the 'License Status' column of Product table
    AND the user can see detail info after clicking on the value of column 'License Status'

*** Keywords ***
The user can go to the support page of product after clicking on the title
    ${current_url}=    Get Location
    ${detail_value_cell}    ${noRecords}=    The user clicks value of cell table    ${at_MyProducts_ProductGrid}    My Products    &{product_numColumn_Table}
    The user on the Product Support page of product '${detail_value_cell}'
    sleep    1
    Run Keyword IF    "${BROWSER}"=="IE"    Go To    ${current_url}
    ...    ELSE    Go Back
    The user sees table of products

The user can see detail info after clicking on the value of column '${name_column}'
    Comment    Close Popup    ${at_popup_opinion}
    ${locator}=    Prepare Locator To JS    ${at_MyProducts_ProductGrid}
    ${noRecords}=    Get Matching Xpath Count    ${locator}/tbody/tr[@class='no-records-found']
    Return From Keyword If    ${noRecords}==1
    ${num}=    Set Variable    &{product_numColumn_Table}[${name_column}]
    Run Keyword IF    '${num}'=='${EMPTY}'    Fail    Column with title '${name_column}' has not been found
    ${value_field}=    Execute Javascript    return window.document.evaluate("${locator}/tbody/tr[1]/td[${num}]//text()[normalize-space()]", document, null, XPathResult.STRING_TYPE, null).stringValue;
    Run Keyword IF    '${name_column}' in ('Support Status', 'License Status', 'News & Alerts', 'Open Cases', 'Last Download')    Detail info ${name_column}    ${value_field}    ${at_MyProducts_ProductGrid}/tbody/tr[1]/td[${num}]

Detail info Support Status
    [Arguments]    ${value_cell}    ${locator_cell}
    Focus    ${locator_cell}
    Click Element    ${locator_cell}
    sleep    3
    Wait Until Page Does Not Contain Element    ${icon_table-loading}
    Comment    Wait Until Page Contains Element    ${at_MyProducts_ProductGrid}/tbody/tr[2][@class='detail-view']
    #
    ${locator}=    Prepare Locator To JS    ${at_MyProducts_ProductGrid}/tbody/tr[2][@class='detail-view']/td
    ${detail_info}=    Set Variable IF    '${value_cell}'=='${dsg_MyAccount_GridSupportStatus_Standard}'    ${dsg_MyAccount_SupportStatusDetailView_Standard}    '${value_cell}'=='${dsg_MyAccount_GridSupportStatus_24X7}'    ${dsg_MyAccount_SupportStatusDetailView_24X7}    '${value_cell}'=='${dsg_MyAccount_GridSupportStatus_NoStatus}'
    ...    ${dsg_MyAccount_SupportStatusDetailView_NoStatus}    '${value_cell}'=='${dsg_MyAccount_GridSupportStatus_Premier}'    ${dsg_MyAccount_SupportStatusDetailView_Premier}    '${value_cell}'=='${dsg_MyAccount_GridSupportStatus_SPP}'    ${dsg_MyAccount_SupportStatusDetailView_SPP}    '${value_cell}'=='${dsg_MyAccount_GridSupportStatus_Trial}'
    ...    ${dsg_MyAccount_SupportStatusDetailView_Trial}    '${value_cell}'=='${dsg_MyAccount_GridSupportStatus_SPP24X7}'    ${dsg_MyAccount_SupportStatusDetailView_SPP24X7}    ${EMPTY}
    log    ${detail_info}
    ${detail_info}=    Replace String Using Regexp    ${detail_info}    <\\s+\/    </
    ${detail_info}=    Replace String Using Regexp    ${detail_info}    \\s*\/>    >
    ${detail_info}=    Replace String Using Regexp    ${detail_info}    ["']    ${EMPTY}
    ${detail_info}=    Run Keyword IF    "${LOCALE}"!="ja-jp"    Replace String    ${detail_info}    (    \\(
    ...    ELSE    Replace String    ${detail_info}    （    \\（
    ${detail_info}=    Run Keyword IF    "${LOCALE}"!="ja-jp"    Replace String    ${detail_info}    )    \\)
    ...    ELSE    Replace String    ${detail_info}    ）    \\）
    ${loc}=    Set Variable IF    '${LOCALE}'=='es-es'    /es-es    '${LOCALE}'=='ja-jp'    /ja-jp    ${EMPTY}
    ${detail_info}=    Run Keyword IF    '${LOCALE}'=='es-es' or '${LOCALE}'=='ja-jp'    Replace String    ${detail_info}    href=/    href=${loc}/
    ...    ELSE    Set Variable    ${detail_info}
    ${column_text}=    Execute Javascript    return window.document.evaluate("${locator}", document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue.innerHTML
    ${column_text}=    Replace String Using Regexp    ${column_text}    ["']    ${EMPTY}
    log    ${detail_info}
    log    ${column_text}
    ${matches}=    Get Regexp Matches    ${column_text}    ${detail_info}
    Run Keyword IF    ${matches}==[]    Capture Page Screenshot
    Run Keyword IF    ${matches}==[]    Fail    Detail Info no matches value of column

Detail info License Status
    [Arguments]    ${value_cell}    ${locator_cell}
    ${current_url}=    Get Location
    Focus    ${locator_cell}/*[self::a or self::span]
    Click Element    ${locator_cell}/*[self::a or self::span]
    Comment    sleep    3
    Wait Until Page Does Not Contain Element    ${icon_table-loading}
    #
    Comment    Run Keyword IF    '${value_cell}'=='${dsg_MyAccount_GridBuyLabel}'    Active page should be How to Buy
    Run Keyword IF    '${value_cell}'=='${dsg_MyAccount_GridBuyLabel}'    Go To    ${current_url}
    Comment    ...
    ...    ELSE IF    '${value_cell}'=='${dsg_MyAccount_GridBuyLabel}' and "${BROWSER}"!="IE"    Go Back
    Comment    Run Keyword IF    '${value_cell}'=='${dsg_MyAccount_GridBuyLabel}'    Go Back
    Return From Keyword IF    '${value_cell}'=='${dsg_MyAccount_GridBuyLabel}'
    Run Keyword IF    '${value_cell}'=='${dsg_MyAccount_GridRegisterLicenseLabel}'    Modal window should be Register Product Or License
    Run Keyword IF    '${value_cell}'=='${dsg_MyAccount_GridRegisterLicenseLabel}'    Close modal window Register Product Or License
    Run Keyword IF    '${value_cell}'=='${dsg_MyAccount_GridBuyLabel}'    The user sees table of products
    ...    ELSE    Wait Until Page Contains Element    ${at_MyProducts_ProductGrid}/tbody/tr[2][@class='detail-view']
    Wait Until Element Is Visible    ${at_licenseDetailGrid}
    the user sees the 'License #' column of License Status table
    the user sees the 'Renewal Expiration Date' column of License Status table
    the user sees the 'User Group' column of License Status table
    the user sees the 'My Role' column of License Status table
    ${locator}=    Prepare Locator To JS    ${at_MyProducts_ProductGrid}/tbody/tr[2][@class='detail-view']
    ${is_link}=    Get Matching XPath Count    ${locator}//div[@class='inline-content-links']//a[text()[contains(., '${dsg_MyAccount_LicenseDetail_AddLicenseLabel}')]]
    Run Keyword IF    ${is_link}==0    Capture Page Screenshot
    Run Keyword IF    ${is_link}==0    Fail    Detail View License does not contain link 'Add Asset'
    ...    ELSE    Focus    xpath=${locator}//div[@class='inline-content-links']//a[text()[contains(., '${dsg_MyAccount_LicenseDetail_AddLicenseLabel}')]]
    Click Element    xpath=${locator}//div[@class='inline-content-links']//a[text()[contains(., '${dsg_MyAccount_LicenseDetail_AddLicenseLabel}')]]
    Modal window should be Register Product Or License
    Close modal window Register Product Or License

Detail info News & Alerts
    [Arguments]    ${value_cell}    ${locator_cell}
    ${locator}=    Prepare Locator To JS    ${at_MyProducts_ProductGrid}
    the user sees the 'My Products' column of Product table
    ${num}=    Set Variable    &{product_numColumn_Table}[My Products]
    ${name_product}=    Execute Javascript    return window.document.evaluate("${locator}/tbody/tr[1]/td[${num}]//text()[normalize-space()]", document, null, XPathResult.STRING_TYPE, null).stringValue;
    Focus    ${locator_cell}/*[self::span or self::i]
    Click Element    ${locator_cell}/*[self::span or self::i]
    sleep    3
    Wait Until Page Does Not Contain Element    ${icon_table-loading}
    #
    Wait Until Page Contains Element    ${at_MyProducts_ProductGrid}/tbody/tr[2][@class='detail-view']
    Wait Until Element Is Visible    ${at_newsAlertsDetailGrid}
    the user sees the 'News & Alerts' column of News&Alerts table
    the user sees the 'Published date' column of News&Alerts table
    ${count}=    Get Regexp Matches    ${value_cell}    ([0-9]*)\\s+${dsg_MyAccount_NewsAlertsDescription}    1
    ${count}=    Run Keyword If    "${count}"!="[]"    Evaluate    ${count}[0]
    ...    ELSE    Set Variable    0
    ${current_url}=    Get Location
    ${detail_value_cell}    ${noRecords}=    The user clicks value of cell table    ${at_newsAlertsDetailGrid}    News & Alerts    &{NewsAlerts_numColumn_Table}
    sleep    1
    Run Keyword IF    ${noRecords}==1 and ${count}!=0    Capture Page Screenshot
    Run Keyword If    ${noRecords}==1 and ${count}!=0    Fail    Detail table not contains info
    Run Keyword If    ${noRecords}==0    Wait Until Page Contains Element    xpath=//h1[@id="LayoutH1"][text()[contains(., "What's new for ${name_product}")]]
    Run Keyword If    ${noRecords}==0    Sleep    1
    Run Keyword IF    ${noRecords}==0 and "${BROWSER}"=="IE"    Go To    ${current_url}
    ...    ELSE IF    ${noRecords}==0 and "${BROWSER}"!="IE"    Go Back
    Comment    Run Keyword If    ${noRecords}==0    Go Back
    Run Keyword If    ${noRecords}==0    the user on the 'My Products' page
    Run Keyword If    ${noRecords}==0    The user sees table of products

Detail info Open Cases
    [Arguments]    ${value_cell}    ${locator_cell}
    ${locator}=    Prepare Locator To JS    ${at_MyProducts_ProductGrid}
    the user sees the 'My Products' column of Product table
    ${num}=    Set Variable    &{product_numColumn_Table}[My Products]
    ${name_product}=    Execute Javascript    return window.document.evaluate("${locator}/tbody/tr[1]/td[${num}]//text()[normalize-space()]", document, null, XPathResult.STRING_TYPE, null).stringValue;
    ${product_properties}=    Get Product Properties By Name    ${name_product}
    Focus    ${locator_cell}/span
    Click Element    ${locator_cell}/span
    sleep    3
    Wait Until Page Does Not Contain Element    ${icon_table-loading}
    #
    Wait Until Page Contains Element    ${at_MyProducts_ProductGrid}/tbody/tr[2][@class='detail-view']
    Wait Until Element Is Visible    ${at_SRDetailGrid}
    the user sees the 'ID' column of Open Cases table
    the user sees the 'Request Title' column of Open Cases table
    the user sees the 'Product' column of Open Cases table
    the user sees the 'Status' column of Open Cases table
    the user sees the 'Created On' column of Open Cases table
    the user sees the 'Updated On' column of Open Cases table
    ${count}=    Set Variable    ${value_cell}
    ${locator}=    Prepare Locator To JS    ${at_SRDetailGrid}
    ${num}=    Set Variable    &{OpenCases_numColumn_Table}[ID]
    ${SR}=    Run Keyword If    ${count}>0    Execute Javascript    return window.document.evaluate("${locator}/tbody/tr[1]/td[${num}]//text()[normalize-space()]", document, null, XPathResult.STRING_TYPE, null).stringValue;
    ...    ELSE    Set Variable    ${EMPTY}
    ${current_url}=    Get Location
    ${detail_value_cell}    ${noRecords}=    The user clicks value of cell table    ${at_SRDetailGrid}    Request Title    &{OpenCases_numColumn_Table}
    sleep    1
    Run Keyword IF    ${noRecords}==1 and ${count}!=0    Capture Page Screenshot
    Run Keyword If    ${noRecords}==1 and "${count}"!="0"    Fail    Detail table not contains info
    Run Keyword If    ${noRecords}==0    Active page should be Service Request Details
    Run Keyword If    ${noRecords}==0    Wait Until Page Contains Element    xpath=//h1[@id="LayoutH1"][text()[contains(.,'${dsg_SRDetail_ServiceRequest#}')]][text()[contains(.,'${SR}')]]
    Run Keyword If    ${noRecords}==0    Sleep    1
    Run Keyword IF    ${noRecords}==0 and "${BROWSER}"=="IE"    Go To    ${current_url}
    ...    ELSE IF    ${noRecords}==0 and "${BROWSER}"!="IE"    Go Back
    Comment    Run Keyword If    ${noRecords}==0    Go Back
    Run Keyword If    ${noRecords}==0    the user on the 'My Products' page
    Run Keyword If    ${noRecords}==0    The user sees table of products
    #
    ${locator}=    Prepare Locator To JS    ${at_MyProducts_ProductGrid}/tbody/tr[2][@class='detail-view']
    ${is_show_detail}=    Get Matching XPath Count    ${locator}
    Run Keyword IF    ${is_show_detail}==0    Focus    ${locator_cell}/span
    Run Keyword IF    ${is_show_detail}==0    Click Element    ${locator_cell}/span
    Run Keyword IF    ${is_show_detail}==0    sleep    3
    Wait Until Page Does Not Contain Element    ${icon_table-loading}
    Run Keyword IF    ${is_show_detail}==0    Wait Until Page Contains Element    ${at_MyProducts_ProductGrid}/tbody/tr[2][@class='detail-view']
    Wait Until Element Is Visible    ${at_SRDetailGrid}
    ${is_link}=    Get Matching XPath Count    ${locator}//div[@class='inline-content-links']//a[text()[contains(., '${dsg_MyAccount_SRDetail_SeeAllRequestLabel}')]]
    Run Keyword IF    ${is_link}==0    Capture Page Screenshot
    Run Keyword IF    ${is_link}==0    Fail    Detail View Open Cases does not contain link 'See All Service Request'
    ...    ELSE    Scroll To Element    ${locator}//div[@class='inline-content-links']//a[text()[contains(., '${dsg_MyAccount_SRDetail_SeeAllRequestLabel}')]]
    ${current_url}=    Get Location
    Focus    xpath=${locator}//div[@class='inline-content-links']//a[text()[contains(., '${dsg_MyAccount_SRDetail_SeeAllRequestLabel}')]]
    Click Element    xpath=${locator}//div[@class='inline-content-links']//a[text()[contains(., '${dsg_MyAccount_SRDetail_SeeAllRequestLabel}')]]
    Active page should be My Service Request
    sleep    1
    log    "${BROWSER}"
    Run Keyword IF    "${BROWSER}"=="IE"    Go To    ${current_url}
    ...    ELSE    Go Back
    Comment    Go Back
    the user on the 'My Products' page
    The user sees table of products
    #
    ${is_show_detail}=    Get Matching XPath Count    ${locator}
    Run Keyword IF    ${is_show_detail}==0    Focus    ${locator_cell}/span
    Run Keyword IF    ${is_show_detail}==0    Click Element    ${locator_cell}/span
    Run Keyword IF    ${is_show_detail}==0    sleep    3
    Wait Until Page Does Not Contain Element    ${icon_table-loading}
    Run Keyword IF    ${is_show_detail}==0    Wait Until Page Contains Element    ${at_MyProducts_ProductGrid}/tbody/tr[2][@class='detail-view']
    Wait Until Element Is Visible    ${at_SRDetailGrid}
    ${is_link}=    Get Matching XPath Count    ${locator}//div[@class='inline-content-links']//a[text()[contains(., '${dsg_MyAccount_SRDetail_SubmitRequestLabel}')]]
    Run Keyword IF    ${is_link}==0    Fail    Detail View Open Cases does not contain link 'Submit a Service Request'
    ...    ELSE    Scroll To Element    ${locator}//div[@class='inline-content-links']//a[text()[contains(., '${dsg_MyAccount_SRDetail_SubmitRequestLabel}')]]
    ${current_url}=    Get Location
    Focus    xpath=${locator}//div[@class='inline-content-links']//a[text()[contains(., '${dsg_MyAccount_SRDetail_SubmitRequestLabel}')]]
    Click Element    xpath=${locator}//div[@class='inline-content-links']//a[text()[contains(., '${dsg_MyAccount_SRDetail_SubmitRequestLabel}')]]
    Active page should be Submit a Service Request
    ${locator}=    Prepare Locator To JS    ${product_list_SubmitServiceRequest}[@class='option selected'][text()[contains(., '${name_product}')]]
    ${is_product_selected}=    Get Matching XPath Count    ${locator}
    # temporary comment
    log    &{product_properties}[IntegrationType]
    log    &{product_properties}[IsCommercial]
    Run Keyword IF    ${is_product_selected}==0 and (("&{product_properties}[IntegrationType]"=="Full" and "&{product_properties}[IsCommercial]"=="Y") or "&{product_properties}[IntegrationType]"!="Full")    Capture Page Screenshot
    Run Keyword IF    ${is_product_selected}==0 and (("&{product_properties}[IntegrationType]"=="Full" and "&{product_properties}[IsCommercial]"=="Y") or "&{product_properties}[IntegrationType]"!="Full")    Fail    Product '${name_product}' not selected in the 'Product' selector of the page 'Submit a Service Request'
    sleep    1
    Run Keyword IF    "${BROWSER}"=="IE"    Go To    ${current_url}
    ...    ELSE    Go Back
    Comment    Go Back
    the user on the 'My Products' page
    The user sees table of products

Detail info Last Download
    [Arguments]    ${value_cell}    ${locator_cell}
    ${current_url}=    Get Location
    ${locator}=    Prepare Locator To JS    ${at_MyProducts_ProductGrid}
    the user sees the 'My Products' column of Product table
    ${num}=    Set Variable    &{product_numColumn_Table}[My Products]
    ${name_product}=    Execute Javascript    return window.document.evaluate("${locator}/tbody/tr[1]/td[${num}]//text()[normalize-space()]", document, null, XPathResult.STRING_TYPE, null).stringValue;
    ${locator}=    Prepare Locator To JS    ${locator_cell}
    ${valueCell_is_link}=    Get Matching XPath Count    ${locator}/a
    Focus    ${locator_cell}/*[self::a or self::span]
    Click Element    ${locator_cell}/*[self::a or self::span]
    Comment    sleep    3
    Wait Until Page Does Not Contain Element    ${icon_table-loading}
    Run Keyword IF    ${valueCell_is_link}!=0    Active page should be Download Software page for the '${name_product}' product
    Run Keyword IF    ${valueCell_is_link}!=0    sleep    1
    Run Keyword IF    ${valueCell_is_link}!=0    Go To    ${current_url}
    Run Keyword IF    ${valueCell_is_link}!=0    The user on the 'My Products' page
    Return From Keyword IF    ${valueCell_is_link}!=0
    #
    Wait Until Page Contains Element    ${at_MyProducts_ProductGrid}/tbody/tr[2][@class='detail-view']
    Wait Until Element Is Visible    ${at_DownloadDetailGrid}
    the user sees the 'File Name' column of Last Download table
    the user sees the 'Release Date' column of Last Download table
    the user sees the 'Downloaded On' column of Last Download table
    ${locator}=    Prepare Locator To JS    ${at_MyProducts_ProductGrid}/tbody/tr[2][@class='detail-view']
    ${is_link}=    Get Matching XPath Count    ${locator}//a[@class='new-version-link']
    Run Keyword IF    ${is_link}!=0    Click Element    xpath=${locator}//a[@class='new-version-link']
    Run Keyword IF    ${is_link}!=0    Active page should be Download Software page for the '${name_product}' product
    Run Keyword IF    ${is_link}!=0    sleep    1
    Run Keyword IF    ${is_link}!=0 and "${BROWSER}"=="IE"    Go To    ${current_url}
    ...    ELSE IF    ${is_link}!=0 and "${BROWSER}"!="IE"    Go Back
    Comment    Run Keyword IF    ${is_link}!=0    Go Back
    Run Keyword IF    ${is_link}!=0    the user on the 'My Products' page
    Run Keyword IF    ${is_link}!=0    The user sees table of products

The user clicks value of cell table
    [Arguments]    ${table_locator}    ${nameColumn}    &{dict_numColumn}
    ${value_cell}=    Set Variable    ${EMPTY}
    ${locator}=    Prepare Locator To JS    ${table_locator}
    ${noRecords}=    Get Matching Xpath Count    ${locator}/tbody/tr[@class='no-records-found']
    Return From Keyword If    ${noRecords}==1
    ${num}=    Set Variable    &{dict_numColumn}[${nameColumn}]
    Run Keyword IF    '${num}'=='${EMPTY}'    Capture Page Screenshot
    Run Keyword IF    '${num}'=='${EMPTY}'    Fail    Column with title '${nameColumn}' has not been found
    ${value_cell}=    Execute Javascript    return window.document.evaluate("${locator}/tbody/tr[1]/td[${num}]//text()[normalize-space()]", document, null, XPathResult.STRING_TYPE, null).stringValue;
    Click Element    ${table_locator}/tbody/tr[1]/td[${num}]/*[self::a or self::span or self::i]
    [Return]    ${value_cell}    ${noRecords}
