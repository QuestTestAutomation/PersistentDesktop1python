*** Settings ***
Resource          ../Resources/ContactSupport_Page_Resources.robot
Resource          ../Resources/ServiceRequest_Page_Resources.robot
Resource          ../Resources/SignIn_Page_Resources.robot
Resource          ../Resources/Commons.robot
Resource          ../Resources/Menu.robot
Resource          ../Resources/Filters.robot
Resource          ../Resources/MyAccount.robot
Resource          ../01__Registration/SuiteRegistration_Keywords_Resources.robot
Resource          ../03__Downloads/SuiteDownloads_Keywords_Resources.robot
Resource          ../Resources/Locators/MyAccountProfile_Locators.robot

*** Variables ***
@{list_account}
@{list_licenses}
@{list_groups}
&{GroupMembership_numColumn_Table}
&{GroupMembership_nameColumn_Table}    Group Name=${profilePage_column_GroupName_GroupMembershipGrid}    Role=${profilePage_column_Role_GroupMembershipGrid}    Share email with Group=${profilePage_column_Share_GroupMembershipGrid}
&{QuestProfile_field}    Business Email=    First Name=FirstName    Last Name=LastName    Phone Number=PhoneNumber    Pager/Cell Phone=PagerNumber    Time Zone=TimeZone    Preferred Contact Method=PreferredContactMethod
...               Preferred Language=PreferredLanguage
&{QuestProfile_value}    Business Email=${EMPTY}    First Name=${EMPTY}    Last Name=${EMPTY}    Phone Number=${EMPTY}    Pager/Cell Phone=${EMPTY}    Time Zone=${EMPTY}    Preferred Contact Method=${EMPTY}
...               Preferred Language=${EMPTY}
&{product_numColumn_Table}
&{product_nameColumn_Table}    My Products=${column_MyProducts_ProductGrid}    Support Status=${column_SupportStatus_ProductGrid}    License Status=${column_LicenseStatus_ProductGrid}    News & Alerts=${column_NewsAlerts_ProductGrid}    Open Cases=${column_OpenSRs_ProductGrid}    Last Download=${column_Downloads_ProductGrid}
&{NewsAlerts_numColumn_Table}
&{NewsAlerts_nameColumn_Table}    News & Alerts=${column_NewsAlerts_newsAlertsDetailGrid}    Published date=${column_PublishedDate_newsAlertsDetailGrid}
&{OpenCases_numColumn_Table}
&{OpenCases_nameColumn_Table}    ID=${column_ID_SRDetailGrid}    Request Title=${column_RequestTitle_SRDetailGrid}    Product=${column_Product_SRDetailGrid}    Status=${column_Status_SRDetailGrid}    Created On=${column_CreatedOn_SRDetailGrid}    Updated On=${column_UpdatedOn_SRDetailGrid}
&{LastDownload_numColumn_Table}
&{LastDownload_nameColumn_Table}    File Name=${column_FileName_DownloadDetailGrid}    Release Date=${column_ReleaseDate_DownloadDetailGrid}    Downloaded On=${column_DownloadedOn_DownloadDetailGrid}
&{LicenseStatus_numColumn_Table}
&{LicenseStatus_nameColumn_Table}    License #=${column_License#_LicenseDetailGrid}    Renewal Expiration Date=${column_Renewal_LicenseDetailGrid}    User Group=${column_UserGroup_LicenseDetailGrid}    My Role=${column_MyRole_LicenseDetailGrid}
&{Members_numColumn_Table}
&{Members_nameColumn_Table}    Name=${groupPage_column_Name_MembersGrid}    Email Id=${groupPage_column_EmailId_MembersGrid}    Admin=${groupPage_column_Admin_MembersGrid}    Support=${groupPage_column_Support_MembersGrid}    License User=${groupPage_column_LicenseUser_MembersGrid}
&{ExpansionUnit_numColumn_Table}
&{ExpansionUnit_nameColumn_Table}    License Number=${column_LicenseNumber_ExpansionUnitGrid}    Product=${column_Product_ExpansionUnitGrid}    Expansion Unit Service Tag=${column_ExpansionUnitServiceTag_ExpansionUnitGrid}
&{TransferKey_numColumn_Table}
&{TransferKey_nameColumn_Table}    Property Name=${column_PropertyName_TransferKeyGrid}    Property Value=${column_PropertyValue_TransferKeyGrid}
&{licensePage_nameField}    Description=${licensePage_nameField_Description}    Version=${licensePage_nameField_Version}    Group=${licensePage_nameField_Group}    License User=${licensePage_nameField_LicenseUser}    Quantity Owned=${licensePage_nameField_QuantityOwned}    Under Maintenance=${licensePage_nameField_UnderMaintenance}    License Renewal=${licensePage_nameField_LicenseRenewal}
...               License Number=${licensePage_nameField_LicenseNumber}    Related License Number=${licensePage_nameField_RelatedLicenseNumber}    Primary Service Tag=${licensePage_nameField_PrimaryServiceTag}    Warranty Expiration=${licensePage_nameField_WarrantyExpiration}
&{licensePage_nameLink}    Manage Group Assignment=${licensePage_nameLink_ManageGroupAssignment}    See All=${licensePage_nameLink_SeeAll}    Request License Access=${licensePage_nameLink_RequestLicenseAccess}    Manage License Users=${licensePage_nameLink_ManageLicenseUsers}
&{licensePage_filters_xpath}    Product=${licensePage_FilterProduct_header}    License Number=${licensePage_FilterLicenseNumber_header}    Service Tag=${licensePage_FilterServiceTag_header}    License User=${licensePage_FilterLicenseUser_header}    Groups=${licensePage_FilterGroups_header}    Renewal Date=${licensePage_FilterRenewalDate_header}
&{groupPage_nameField}    Description=${groupsPage_nameField_Description}    Group Name=${groupsPage_nameField_GroupName}    Products=${groupsPage_nameField_Products}    Membership Visibility=${groupsPage_nameField_MembershipVisibility}
${numLicense_RetrieveKey}    ${EMPTY}
&{groupPage_filters_xpath}    Groups=${groupPage_FilterGroups_header}    Product=${groupPage_FilterProduct_header}    Members=${groupPage_FilterMembers_header}    My Role=${groupPage_FilterMyRole_header}
&{sortBy_var}     Groups=${groupPage_selector_SortBy}    Sort by Group Name (A-Z)=${dsg_MyAccount_MyGroup_SortGroupName}    Sort by Newest=${dsg_MyAccount_MyGroup_SortNewest}    Licenses=${licensePage_selector_SortBy}    Sort by Product Name=${dsg_Licensing_Sort_By_Product_Name}    Sort by License Number=${dsg_Licensing_Sort_By_License_Number}
${index_list}     -1
${numLicense_GroupAdmin}    ${EMPTY}

*** Keywords ***
The user selects 'My Account' option from the top masthead
    Clicks 'My Account'

The user on the 'My Products' page
    Active page should be My Products

The user sees table of products
    Close Popup    ${at_popup_opinion}
    Scroll To Element    ${at_MyProducts_ProductGrid}
    Table Is Enabled    ${at_MyProducts_ProductGrid}

The user sees the '${name_column}' column of ${type_table} table
    Comment    Close Popup    ${at_popup_opinion}
    &{nameColumn_table}=    Set Variable IF    '${type_table}'=='Product'    &{product_nameColumn_Table}    '${type_table}'=='News&Alerts'    &{NewsAlerts_nameColumn_Table}    '${type_table}'=='Last Download'
    ...    &{LastDownload_nameColumn_Table}    '${type_table}'=='License Status'    &{LicenseStatus_nameColumn_Table}    '${type_table}'=='Open Cases'    &{OpenCases_nameColumn_Table}    '${type_table}'=='Members'
    ...    &{Members_nameColumn_Table}    '${type_table}'=='Expansion Unit'    &{ExpansionUnit_nameColumn_Table}    '${type_table}'=='Transfer Key'    &{TransferKey_nameColumn_Table}    &{product_nameColumn_Table}
    ${partName_table}=    Set Variable IF    '${type_table}'=='Product'    product    '${type_table}'=='News&Alerts'    NewsAlerts    '${type_table}'=='Last Download'
    ...    LastDownload    '${type_table}'=='License Status'    LicenseStatus    '${type_table}'=='Open Cases'    OpenCases    '${type_table}'=='Members'
    ...    Members    '${type_table}'=='Expansion Unit'    ExpansionUnit    '${type_table}'=='Transfer Key'    TransferKey    product
    ${num}=    Evaluate    ${${partName_table}_numColumn_Table}.get('name_column', None)
    Return From Keyword IF    ${num} is not None
    ${locator}=    Set Variable    &{nameColumn_Table}[${name_column}]
    ${locator}=    Replace String    ${locator}    xpath=    ${EMPTY}
    ${is_column}=    Get Matching XPath Count    ${locator}
    Run Keyword IF    ${is_column}==0    Capture Page Screenshot
    Run Keyword IF    ${is_column}==0    Fail    Column with title '${name_column}' has not been found
    ${locator}=    Replace String Using Regexp    ${locator}    [\\r\\n]    ${EMPTY}
    ${num_column}=    Execute Javascript    return window.document.evaluate("count(${locator}/preceding-sibling::*)", document, null, XPathResult.NUMBER_TYPE, null).numberValue+1;
    Set To Dictionary    ${${partName_table}_numColumn_Table}    ${name_column}=${num_column}
    Comment    log many    ${numColumn_Table}

Prepare Environment
    ${dop_account}=    Create Dictionary    email=yaseenma@gmail.com    password=quest123
    Append To List    ${list_account}    ${dop_account}
    ${dop_account}=    Create Dictionary    email=yaseenma@yahoo.com    password=quest123
    Append To List    ${list_account}    ${dop_account}
    Append To List    ${list_account}    ${EXTERNAL_ACCOUNT}
    Append To List    ${list_account}    ${EXTERNAL_ACCOUNT_TEMP}
    Set Test Variable    @{list_account}

The user clicks link 'Register Product FAQ'
    Wait Until Element Is Visible    ${dsg_Licensing_Licensing_FAQs_locator}
    Highlight Element    ${dsg_Licensing_Licensing_FAQs_locator}
    Focus    ${dsg_Licensing_Licensing_FAQs_locator}
    Click Element    ${dsg_Licensing_Licensing_FAQs_locator}

The user on the 'My Product Licenses FAQ' page
    Active page should be My Product Licenses FAQ
    sleep    1
    Go Back

The user sees own licenses
    Wait Until Page Does Not Contain Element    ${icon_table-loading}
    Close Popup    ${at_popup_opinion}
    Wait Until Element Is Enabled    ${div_Licensing}
    Wait Until Element Is Visible    ${div_Licensing}
    ${temp_list}=    Create List
    Set Test Variable    ${list_licenses}    ${temp_list}
    ${locator}=    Prepare Locator To JS    ${list_licenses_locator}
    ${count_lic}=    Get Matching Xpath Count    ${locator}
    ${locator_button_AddExpansionUnit}=    Prepare Locator To JS    ${dsg_Licensing_Retrieve_Key_Add_Expansion_Unit_locator}
    ${locator_Licensing_Retrieve_Key_ExpansionUnit_rows}=    Prepare Locator To JS    ${Licensing_Retrieve_Key_ExpansionUnit_rows}
    ${locator_button_TransferKey}=    Prepare Locator To JS    ${dsg_Licensing_Retrieve_Key_Transfer_Key_locator}
    ${locator_Licensing_Retrieve_Key_TransferKey_rows}=    Prepare Locator To JS    ${Licensing_Retrieve_Key_TransferKey_rows}
    ${locator_licenses_UserIsLicense}=    Prepare Locator To JS    ${licenses_UserIsLicense}
    : FOR    ${index}    IN RANGE    ${count_lic}
    \    ${data_lic}=    Execute Javascript    return window.document.evaluate("${locator}[${index+1}]/@data-lic", document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue.value
    \    Comment    ${visibility}=    Execute Javascript    return window.document.evaluate("${locator}[${index+1}]/a[contains(@class, 'visibility-links')][@style='display: none;']/text()[normalize-space()]", document, null, XPathResult.STRING_TYPE, null).stringValue
    \    Comment    ${matches}=    Get Regexp Matches    ${visibility}    ${dsg_Common_Hide}
    \    ${visibility}=    Execute Javascript    return window.document.evaluate("${locator}[${index+1}]/a[@style='display: none;']/@class", document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue.value
    \    ${matches}=    Get Regexp Matches    ${visibility}    visibility-hide
    \    ${visibility}=    Set Variable IF    "${matches}"=="[]"    Show    Hide
    \    ${name_product}=    Execute Javascript    return window.document.evaluate("${locator}[${index+1}]${licensesDetail_tab_detail}/text()[normalize-space()]", document, null, XPathResult.STRING_TYPE, null).stringValue
    \    ${count_button_AddExpansionUnit}=    Get Matching Xpath Count    ${locator}[${index+1}][.${locator_button_AddExpansionUnit}]
    \    ${count_rows_ExpansionUnit}=    Get Matching Xpath Count    ${locator}[${index+1}]${locator_Licensing_Retrieve_Key_ExpansionUnit_rows}
    \    ${count_button_TransferKey}=    Get Matching Xpath Count    ${locator}[${index+1}][.${locator_button_TransferKey}]
    \    ${count_rows_TransferKey}=    Get Matching Xpath Count    ${locator}[${index+1}]${Licensing_Retrieve_Key_TransferKey_rows}
    \    ${count_UserIsLicenseUser}=    Get Matching Xpath Count    ${locator}[${index+1}][.${locator_licenses_UserIsLicense}]
    \    ${license}=    Create Dictionary    License=${data_lic}    Visibility=${visibility}    Product=${name_product}    Button_AddExpansionUnit=${${count_button_AddExpansionUnit}}
    \    ...    Rows_AddExpansionUnit=${${count_rows_ExpansionUnit}}    Button_TransferKey=${${count_button_TransferKey}}    Rows_TransferKey=${${count_rows_TransferKey}}    UserIsLicenseUser=${${count_UserIsLicenseUser}}
    \    Append To List    ${list_licenses}    ${license}
    log many    @{list_licenses}
    Close Popup    ${at_popup_opinion}

The link "Show Hidden Registered Products" will be displayed, otherwise there is no
    Clicks link "Show Hidden Registered Products"

The licenses are sorted by ${value_sorting}
    ${value_sorting}=    Set Variable IF    "${value_sorting}" in ("Product", "License")    ${value_sorting}    Product
    ${locator}=    Prepare Locator To JS    ${list_licenses_locator}
    Comment    @{temp_list}=    Evaluate    sorted(@list_licenses, key=lambda elem: "%s %s" % (elem['Product'], elem['License']))
    @{temp_list}=    Evaluate    sorted(@{list_licenses}, key=lambda item: (item['${value_sorting}'].lower()))
    log many    @{temp_list}
    ${count}=    Evaluate    len(@{temp_list})
    : FOR    ${index}    IN RANGE    ${count}
    \    ${my_value}=    Evaluate    @{temp_list}[${index}].get('${value_sorting}')
    \    ${page_value}=    Run Keyword IF    "${value_sorting}"=="Product"    Execute Javascript    return window.document.evaluate("${locator}[${index+1}]${licensesDetail_tab_detail}/text()[normalize-space()]", document, null, XPathResult.STRING_TYPE, null).stringValue
    \    ...    ELSE    Execute Javascript    return window.document.evaluate("${locator}[${index+1}]/@data-lic", document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue.value
    \    Run Keyword IF    "${my_value}"!="${page_value}"    FAIL    Licenses are sorted incorrectly

The user select value '${value_selector}' from ${type_object} Sort Option
    ${locator}=    Evaluate    &{sortBy_var}.get('${type_object}', None)
    ${value}=    Evaluate    &{sortBy_var}.get('${value_selector}', None)
    Run Keyword IF    "${locator}"=="${None}"    Fail    The test does not contain definition of the Sort By selector '${type_object}'
    Run Keyword IF    "${value}"=="${None}"    Fail    The test does not contain definition of the var for value '${value_selector}'
    Wait Until Element Is Enabled    ${locator}
    JS Select Item of DropDown List    ${locator}    ${value}

The user sees the '${name_field}' field of License details
    ${locator}=    Evaluate    &{licensePage_nameField}.get('${name_field}', None)
    ${notKOA_locator}=    Evaluate    &{licensePage_nameField}.get('License Number', None)
    ${locator_temp}=    Replace String Using Regexp    ${locator}    [\\r\\n]    ${EMPTY}
    Run Keyword IF    "${locator_temp}"=="${None}"    Fail    The test does not contain definition of the field '${name_field}'
    ${countLicenses}=    Evaluate    len(@{list_licenses})
    ${notKOA_locator}=    Prepare Locator To JS    ${notKOA_locator}
    ${count_notKOA}=    Get Matching XPath Count    ${notKOA_locator}
    ${countKOA}=    Evaluate    ${countLicenses}-${count_notKOA}
    ${locator}=    Prepare Locator To JS    ${locator}
    ${countField}=    Get Matching XPath Count    ${locator}
    Run Keyword IF    ("${name_field}" in ("Primary Service Tag", "Related License Number", "Warranty Expiration") and ${countField}!=${countKOA}) or ("${name_field}"=="License Number" and ${countField}!=(${countLicenses} - ${countKOA})) or ("${name_field}" not in ("Primary Service Tag", "Related License Number", "Warranty Expiration", "License Number") and ${countField}!=${countLicenses})    Capture Page Screenshot
    Run Keyword IF    ("${name_field}" in ("Primary Service Tag", "Related License Number", "Warranty Expiration") and ${countField}!=${countKOA}) or ("${name_field}"=="License Number" and ${countField}!=(${countLicenses} - ${countKOA})) or ("${name_field}" not in ("Primary Service Tag", "Related License Number", "Warranty Expiration", "License Number") and ${countField}!=${countLicenses})    Fail    You need to check the field "${name_field}" in the licenses

The user sees the '${name_link}' link
    ${locator}=    Evaluate    &{licensePage_nameLink}.get('${name_link}', None)
    ${locator_temp}=    Replace String Using Regexp    ${locator}    [\\r\\n]    ${EMPTY}
    Run Keyword IF    "${locator_temp}"=="${None}"    Fail    The test does not contain definition of the link '${name_link}'
    ${locator}=    Prepare Locator To JS    ${locator}
    ${countLink}=    Get Matching XPath Count    ${locator}
    [Return]    ${countLink}

the user sees all the required links in the License details
    ${countLicenses}=    Evaluate    len(@{list_licenses})
    ${count}=    The user sees the 'Manage Group Assignment' link
    Run Keyword IF    ${count}!=${countLicenses}    Capture Page Screenshot
    Run Keyword IF    ${count}!=${countLicenses}    Fail    You need to check the link "Manage Group Assignment" in the licenses
    ${countSeeAll}=    The user sees the 'See All' link
    ${countRequestLicenseAccess}=    The user sees the 'Request License Access' link
    ${countManageLicenseUsers}=    The user sees the 'Manage License Users' link
    Run Keyword IF    (${countSeeAll} + ${countRequestLicenseAccess} + ${countManageLicenseUsers})!=${countLicenses}    Capture Page Screenshot
    Run Keyword IF    (${countSeeAll} + ${countRequestLicenseAccess} + ${countManageLicenseUsers})!=${countLicenses}    Fail    You need to check the links "See All", "Request License Access", "Manage License Users" in the licenses. One of these links should be in each of the license.

The user clicks link 'Manage Group Assignment'
    ${countLicenses}=    Evaluate    len(@{list_licenses})
    Return From Keyword IF    ${countLicenses}==0
    ${locator}=    Prepare Locator To JS    (${licensePage_nameLink_ManageGroupAssignment}[./ancestor::div[@data-lic and not(@style='display: none;')]])[1]
    ${countLink}=    Get Matching XPath Count    ${locator}
    Return From Keyword IF    ${countLink}==0
    Clicks link "Show Hidden Registered Products"
    Wait Until Element Is Visible    xpath=${locator}
    Focus    xpath=${locator}
    ${current_url}=    Get Location
    Set Test Variable    ${current_url}
    Click Element    xpath=${locator}

Some license contains link '${name_link}' and the user clicks this link
    ${locator}=    Evaluate    &{licensePage_nameLink}.get('${name_link}', None)
    ${locator}=    Replace String Using Regexp    ${locator}    [\\r\\n]    ${EMPTY}
    Run Keyword IF    "${locator}"=="${None}"    Fail    The test does not contain definition of the link '${name_link}'
    ${locator}=    Prepare Locator To JS    ${locator}[./ancestor::div[@data-lic and not(@style='display: none;')]]
    ${countLink}=    Get Matching XPath Count    ${locator}
    Return From Keyword IF    ${countLink}==0
    Clicks link "Show Hidden Registered Products"
    Wait Until Element is Visible    xpath=(${locator})[1]
    Run Keyword IF    "${BROWSER}"!="IE"    Scroll To Element    xpath=(${locator})[1]
    Run Keyword IF    "${BROWSER}"!="IE"    Highlight Element    xpath=(${locator})[1]
    Focus    xpath=(${locator})[1]
    Click Element    xpath=(${locator})[1]

The modal window 'View License Users' appears
    ${locator}=    Prepare Locator To JS    ${licensePage_nameLink_SeeAll}[./ancestor::div[@data-lic and not(@style='display: none;')]]
    ${countLink}=    Get Matching XPath Count    ${locator}
    Return From Keyword IF    ${countLink}==0
    Modal window should be View License Users
    sleep    1
    Focus    ${closeButton_ViewSubscribersModall}
    Click Element    ${closeButton_ViewSubscribersModall}

The modal window 'Request License User Access' appears
    ${locator}=    Prepare Locator To JS    ${licensePage_nameLink_RequestLicenseAccess}[./ancestor::div[@data-lic and not(@style='display: none;')]]
    ${countLink}=    Get Matching XPath Count    ${locator}
    Return From Keyword IF    ${countLink}==0
    Modal window should be Request License User Access
    sleep    1
    Focus    ${cancelButton_RequestSubscriptionModal}
    Click Element    ${cancelButton_RequestSubscriptionModal}

The modal window 'Manage License Users' appears
    ${locator}=    Prepare Locator To JS    ${licensePage_nameLink_ManageLicenseUsers}[./ancestor::div[@data-lic and not(@style='display: none;')]]
    ${countLink}=    Get Matching XPath Count    ${locator}
    Return From Keyword IF    ${countLink}==0
    Modal window should be Manage License Users
    sleep    1
    Focus    ${closeButton_ManageSubscribersModall}
    Click Element    ${closeButton_ManageSubscribersModall}

The user sees on the page 'My Licenses' all the required filters
    # temporary expression
    Return From Keyword IF    "${BROWSER}" in ("iPhone_6", "iPadAir_2", "Samsung_GalaxyS6")
    #
    The user sees the filter    Product    &{licensePage_filters_xpath}
    The user sees the filter    License Number    &{licensePage_filters_xpath}
    The user sees the filter    Service Tag    &{licensePage_filters_xpath}
    The user sees the filter    License User    &{licensePage_filters_xpath}
    The user sees the filter    Groups    &{licensePage_filters_xpath}
    The user sees the filter    Renewal Date    &{licensePage_filters_xpath}

The user sees the filter
    [Arguments]    ${name_filter}    &{dict_filters}
    ${locator}=    Evaluate    ${dict_filters}.get('${name_filter}', None)
    Run Keyword IF    "${locator}"=="${None}"    Fail    The test does not contain definition of the filter '${name_filter}'
    ${locator}=    Prepare Locator To JS    ${locator}
    ${countFilter}=    Get Matching XPath Count    ${locator}
    Run Keyword IF    ${countFilter}==0    Capture Page Screenshot
    Run Keyword IF    ${countFilter}==0    Fail    The page does not contain the filter '${name_filter}'
    Wait Until Element Is Visible    xpath=${locator}

The user sees groups or message 'No Groups'
    Sleep    2
    ${temp_list}=    Create List
    Set Test Variable    ${list_groups}    ${temp_list}
    Close Popup    ${at_popup_opinion}
    Wait Until Element Is Not Visible    ${icon_ProcessingGroupSearch}
    Comment    Scroll To Element    ${div_groupList}
    Wait Until Element Is Enabled    ${div_groupList}
    ${noGroups_locator}=    Prepare Locator To JS    ${div_groupList}/span
    ${locator}=    Prepare Locator To JS    ${list_groups_locator}
    ${count_groups}=    Get Matching Xpath Count    ${locator}
    ${count_noGroups}=    Get Matching Xpath Count    ${noGroups_locator}
    Run Keyword IF    ${count_groups}==0 and ${count_noGroups}==0    Wait Until Page Contains Element    xpath=${noGroups_locator}
    ${message_text}=    Run Keyword IF    ${count_groups}==0    Execute Javascript    return window.document.evaluate("${noGroups_locator}", document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue.innerHTML
    Run Keyword IF    ${count_groups}==0    Should Contain    ${message_text}    ${dsg_MyAccount_MyGroup_NoGroups}
    : FOR    ${index}    IN RANGE    ${count_groups}
    \    ${groupName}=    Execute Javascript    return window.document.evaluate("${locator}[${index+1}]/@data-group-name", document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue.value
    \    ${groupID}=    Execute Javascript    return window.document.evaluate("${locator}[${index+1}]//input[@id='GroupId']/@value", document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue.value
    \    ${isMembershipVisibility}=    Get Matching XPath Count    ${locator}[${index+1}][.${groupPage_ChkMembershipVisibility}][@checked='checked']
    \    ${HdnLoggedUserEmail}=    Execute Javascript    return window.document.evaluate("${locator}[${index+1}]//input[@id='HdnLoggedUserEmail']/@value", document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue.value
    \    ${HdnLoggedUserEmail}=    Convert To Uppercase    ${HdnLoggedUserEmail}
    \    ${isAdminGroup}=    Get Matching XPath Count    ${locator}[${index+1}]${groupPage_Btn_EditGroup}
    \    Comment    ${isAdminGroup}=    Get Matching XPath Count    ${locator}[${index+1}]//tr[@id='InfoRow'][.//input[@id='HdnEmail']/@value='${HdnLoggedUserEmail}'][.//input[@name='ChkAdmin' and @checked='checked']]
    \    ${HdnLicenseData}=    Execute Javascript    return window.document.evaluate("${locator}[${index+1}]//input[@id='HdnLicenseData']/@value", document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue.value
    \    log many    ${HdnLicenseData}
    \    ${CreatedDate}=    Get Regexp Matches    ${HdnLicenseData}    ,\\s*"CreatedDate"\\s*:\\s*"[^0-9]*\(([0-9]*)\)[^"]*",    1
    \    ${CreatedDate}=    Run Keyword IF    "${CreatedDate}"!="[]"    Evaluate    ${CreatedDate}[0]
    \    ...    ELSE    Set Variable    0
    \    ${GroupLicense}=    Get Regexp Matches    ${HdnLicenseData}    ,\\s*"LicenseNumber"\\s*:\\s*"([0-9\-]*)"\\s*,    1
    \    ${GroupLicense}=    Run Keyword IF    "${GroupLicense}"!="[]"    Evaluate    ${GroupLicense}[0]
    \    ...    ELSE    Set Variable    ${EMPTY}
    \    ${group}=    Create Dictionary    Group Name=${groupName}    Group ID=${groupID}    Created Date=${CreatedDate}    Group License=${GroupLicense}
    \    ...    isAdminGroup=${${isAdminGroup}}    isMembershipVisibility=${${isMembershipVisibility}}    LoggedUserEmail=${HdnLoggedUserEmail}
    \    Append To List    ${list_groups}    ${group}
    log many    ${list_groups}
    Comment    log many    ${message_text}
    Comment    log many    ${dsg_MyAccount_MyGroup_NoGroups}

The user clicks tab 'Retrieve Key' of License where the user is a license user
    ${countLicenses}=    Evaluate    len(@{list_licenses})
    Return From Keyword IF    ${countLicenses}==0
    ${numLic}=    Evaluate    next((item.get('License', '') for item in ${list_licenses} if item.get('Button_AddExpansionUnit', -1)>0 and item.get('Rows_AddExpansionUnit', -1)>0), '')
    ${numLic}=    Run Keyword IF    "${numLic}"=="${EMPTY}"    Evaluate    next((item.get('License', '') for item in ${list_licenses} if item.get('Button_AddExpansionUnit', -1)>0), '')
    ...    ELSE    Set Variable    ${numLic}
    Return From Keyword IF    "${numLic}"=="${EMPTY}"
    Clicks link "Show Hidden Registered Products"
    Set Test Variable    ${numLicense_RetrieveKey}    ${numLic}
    Wait Until Element Is Visible    ${list_licenses_locator}[@data-lic='${numLic}']${licensesDetail_tab_retrieve}
    Scroll To Element    ${list_licenses_locator}[@data-lic='${numLic}']${licensesDetail_tab_retrieve}
    Focus    ${list_licenses_locator}[@data-lic='${numLic}']${licensesDetail_tab_retrieve}
    Click Element    ${list_licenses_locator}[@data-lic='${numLic}']${licensesDetail_tab_retrieve}

The user sees license retrieve key heading
    ${countLicenses}=    Evaluate    len(@{list_licenses})
    Return From Keyword IF    ${countLicenses}==0 or "${numLicense_RetrieveKey}"=="${EMPTY}"
    ${locator}=    Prepare Locator To JS    ${licensesDetail_tabPanel_retrieve}
    ${count}=    Get Matching Xpath Count    ${locator}//div[@id='lic-${numLicense_RetrieveKey}']//p
    ${text}=    Execute Javascript    return window.document.evaluate("${locator}//div[@id='lic-${numLicense_RetrieveKey}']//p", document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue.innerHTML
    ${text}=    Replace String Using Regexp    ${text}    (<a [^>]*>|</a>)    ${EMPTY}
    ${heading}=    Set Variable    ${dsg_Licensing_Retrieve_Key_Heading}
    ${heading}=    Replace String Using Regexp    ${heading}    (<a [^>]*>|</a>)    ${EMPTY}
    ${heading}=    Replace String Using Regexp    ${heading}    &ldquo;    “
    ${heading}=    Replace String Using Regexp    ${heading}    &rdquo;    ”
    Comment    ${heading}=    Evaluate    re.sub('(&ldquo;|&rdquo;)', lambda m: {'&ldquo;':'“', '&rdquo;':'”'}[m.group(1)], '${heading}')    modules=re
    log many    ${text}
    log many    ${heading}
    ${matches}=    Get Regexp Matches    ${text}    ${heading}
    Run Keyword IF    "${matches}"=="[]"    Fail    License Retrieve Key heading no matches value of tab

The user clicks the button 'Add Expansion Unit'
    ${countLicenses}=    Evaluate    len(@{list_licenses})
    Return From Keyword IF    ${countLicenses}==0
    ${locator}=    Prepare Locator To JS    ${list_licenses_locator}
    ${locator_button}=    Prepare Locator To JS    ${dsg_Licensing_Retrieve_Key_Add_Expansion_Unit_locator}
    ${count_button}=    Get Matching Xpath Count    ${locator}[.${locator_button}]
    Return From Keyword IF    ${count_button}==0
    Comment    Scroll To Element    ${list_licenses_locator}[@data-lic='${nimLicense_RetrieveKey}']${dsg_Licensing_Retrieve_Key_Add_Expansion_Unit_locator}
    Clicks link "Show Hidden Registered Products"
    Wait Until Element Is Visible    ${list_licenses_locator}[@data-lic='${numLicense_RetrieveKey}']${dsg_Licensing_Retrieve_Key_Add_Expansion_Unit_locator}
    Highlight Element    ${list_licenses_locator}[@data-lic='${numLicense_RetrieveKey}']${dsg_Licensing_Retrieve_Key_Add_Expansion_Unit_locator}
    Focus    ${list_licenses_locator}[@data-lic='${numLicense_RetrieveKey}']${dsg_Licensing_Retrieve_Key_Add_Expansion_Unit_locator}
    Click Element    ${list_licenses_locator}[@data-lic='${numLicense_RetrieveKey}']${dsg_Licensing_Retrieve_Key_Add_Expansion_Unit_locator}

The modal window 'Add Expansion Unit' appears
    ${countLicenses}=    Evaluate    len(@{list_licenses})
    Return From Keyword IF    ${countLicenses}==0
    ${locator}=    Prepare Locator To JS    ${list_licenses_locator}
    ${locator_button}=    Prepare Locator To JS    ${dsg_Licensing_Retrieve_Key_Add_Expansion_Unit_locator}
    ${count_button}=    Get Matching Xpath Count    ${locator}[.${locator_button}]
    Return From Keyword IF    ${count_button}==0
    Modal window should be Add Expansion Unit

The user clicks tab 'Retrieve Key' of License where the user is not a license user
    ${countLicenses}=    Evaluate    len(@{list_licenses})
    Return From Keyword IF    ${countLicenses}==0
    ${numLic}=    Evaluate    next((item.get('License', '') for item in ${list_licenses} if item.get('UserIsLicenseUser', -1)==0), '')
    Set Test Variable    ${numLicense_RetrieveKey}    ${numLic}
    Return From Keyword IF    "${numLic}"=="${EMPTY}"
    Clicks link "Show Hidden Registered Products"
    Wait Until Element Is Visible    ${list_licenses_locator}[@data-lic='${numLic}']${licensesDetail_tab_retrieve}
    Scroll To Element    ${list_licenses_locator}[@data-lic='${numLic}']${licensesDetail_tab_retrieve}
    Highlight Element    ${list_licenses_locator}[@data-lic='${numLic}']${licensesDetail_tab_retrieve}
    Focus    ${list_licenses_locator}[@data-lic='${numLic}']${licensesDetail_tab_retrieve}
    Click Element    ${list_licenses_locator}[@data-lic='${numLic}']${licensesDetail_tab_retrieve}

The user sees nonLicense retrieve key heading
    ${countLicenses}=    Evaluate    len(@{list_licenses})
    Return From Keyword IF    ${countLicenses}==0 or "${numLicense_RetrieveKey}"=="${EMPTY}"
    ${locator}=    Prepare Locator To JS    ${licensesDetail_tabPanel_retrieve}
    ${count}=    Get Matching Xpath Count    ${locator}//div[@id='lic-${numLicense_RetrieveKey}']//p
    ${text}=    Execute Javascript    return window.document.evaluate("${locator}//div[@id='lic-${numLicense_RetrieveKey}']", document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue.innerHTML
    ${text}=    Replace String Using Regexp    ${text}    <a [^>]*>    ${EMPTY}
    ${heading}=    Set Variable    ${dsg_Licensing_NonLicenseUserRetrieveKeyMsg}
    ${heading}=    Replace String Using Regexp    ${heading}    <a [^>]*>    ${EMPTY}
    ${matches}=    Get Regexp Matches    ${text}    ${heading}
    Run Keyword IF    "${matches}"=="[]"    Fail    License Retrieve Key heading no matches value of tab

The user sees the '${name_field}' field of Group details
    ${locator}=    Evaluate    &{groupPage_nameField}.get('${name_field}', None)
    ${locator_temp}=    Replace String Using Regexp    ${locator}    [\\r\\n]    ${EMPTY}
    Run Keyword IF    "${locator_temp}"=="${None}"    Fail    The test does not contain definition of the field '${name_field}'
    ${countGroups}=    Evaluate    len(@{list_groups})
    ${locator}=    Prepare Locator To JS    ${locator}
    ${countField}=    Get Matching XPath Count    ${locator}
    Run Keyword IF    ("${name_field}"=="Membership Visibility" and ${countField}>${countGroups}) or ("${name_field}"!="Membership Visibility" and ${countField}!=${countGroups})    Capture Page Screenshot
    Run Keyword IF    ("${name_field}"=="Membership Visibility" and ${countField}>${countGroups}) or ("${name_field}"!="Membership Visibility" and ${countField}!=${countGroups})    Fail    You need to check the field "${name_field}" in the groups

The user sees on the page 'My Groups' all the required filters
    # temporary expression
    Return From Keyword IF    "${BROWSER}" in ("iPhone_6", "iPadAir_2", "Samsung_GalaxyS6")
    #
    The user sees the filter    Groups    &{groupPage_filters_xpath}
    The user sees the filter    Product    &{groupPage_filters_xpath}
    The user sees the filter    Members    &{groupPage_filters_xpath}
    The user sees the filter    My Role    &{groupPage_filters_xpath}

The user clicks link 'Add Group'
    Wait Until Element Is Visible    ${groupPage_Link_AddGroup}
    Scroll To Element    ${groupPage_Link_AddGroup}
    Highlight Element    ${groupPage_Link_AddGroup}
    Focus    ${groupPage_Link_AddGroup}
    Click Element    ${groupPage_Link_AddGroup}

The modal window 'Register Product' appears
    Modal window should be Register Product

The user enters TIMS-Only license number in the field 'Asset Number'
    Add Group    ${TIMS_Only_LicenseNumber}

The user clicks the 'View License' link in this error message
    Highlight Element    ${modalRegisterProduct_error_link_ViewLicense}
    Focus    ${modalRegisterProduct_error_link_ViewLicense}
    Click Element    ${modalRegisterProduct_error_link_ViewLicense}

The user on the View License page
    Active page should be View License '${TIMS_Only_LicenseNumber}'

The user clicks link 'Groups FAQ'
    Wait Until Element Is Visible    ${groupPage_Link_GroupsFAQ}
    Highlight Element    ${groupPage_Link_GroupsFAQ}
    Focus    ${groupPage_Link_GroupsFAQ}
    Click Element    ${groupPage_Link_GroupsFAQ}

The user on the 'My Group FAQ' page
    Active page should be My Group FAQ
    sleep    1
    Go Back
    Wait Until Element Is Not Visible    ${icon_ProcessingGroupSearch}
    Wait Until Element Is Enabled    ${div_groupList}

The groups are sorted by ${value_sorting}
    sleep    2
    Wait Until Element Is Not Visible    ${icon_ProcessingGroupSearch}
    Wait Until Element Is Enabled    ${div_groupList}
    ${value_sorting}=    Set Variable IF    "${value_sorting}"=="Newest"    Group ID    Group Name
    ${locator}=    Prepare Locator To JS    ${list_groups_locator}
    ${reverse_value}=    Set Variable IF    "${value_sorting}"=="Group ID"    True    False
    Comment    @{temp_list}=    Evaluate    sorted(@list_licenses, key=lambda elem: "%s %s" % (elem['Product'], elem['License']))
    @{temp_list}=    Evaluate    sorted(@{list_groups}, key=lambda item: item['${value_sorting}'], \ reverse=${reverse_value})
    log many    @{temp_list}
    ${count}=    Evaluate    len(@{temp_list})
    Wait Until Element Is Enabled    ${div_groupList}
    Wait Until Element Is Visible    ${div_groupList}
    : FOR    ${index}    IN RANGE    ${count}
    \    ${my_value}=    Evaluate    @{temp_list}[${index}].get('${value_sorting}')
    \    ${page_value}=    Run Keyword IF    "${value_sorting}"=="Group Name"    Execute Javascript    return window.document.evaluate("${locator}[${index+1}]/@data-group-name", document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue.value
    \    ...    ELSE    Execute Javascript    return window.document.evaluate("${locator}[${index+1}]//input[@id='GroupId']/@value", document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue.value
    \    Run Keyword IF    "${my_value}"!="${page_value}"    FAIL    Groups are sorted incorrectly

the user logs in as '${email}'
    ${account}=    Evaluate    next((item for item in @{list_account} if item.get('email')=='${email}'), None)
    Run Keyword if    "${account}"=="${None}"    Fail    The account '${email}' has not defined
    The user navigates to SignIn page and logs in    ${account['email']}    ${account['password']}
    sleep    3

The user on the 'My Groups' page
    Active page should be My Groups

Add Group
    [Arguments]    ${license}
    Wait Until Element Is Enabled    ${modalRegisterProduct_Field_LicenseNumber}
    Click Element    ${modalRegisterProduct_Field_LicenseNumber}
    JS Set Value To Input    ${modalRegisterProduct_Field_LicenseNumber}    ${license}
    Element Should Be Disabled    ${modalRegisterProduct_Field_Group}
    Highlight Element    ${modalRegisterProduct_Button_Search}
    Focus    ${modalRegisterProduct_Button_Search}
    Click Element    ${modalRegisterProduct_Button_Search}
    Wait Until Element Is Enabled    ${modalRegisterProduct_Field_LicenseNumber}

The user receives TimsOnlyLicense error
    sleep    2
    Wait Until Element Is Not Visible    ${modalRegisterProduct_icon_processingLicReg}
    ${locator}=    Prepare Locator To JS    ${modalRegisterProduct_error_RegProdLicError}
    ${count}=    Get Matching Xpath Count    ${locator}
    ${text}=    Execute Javascript    return window.document.evaluate("${locator}", document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue.innerHTML
    ${text}=    Replace String Using Regexp    ${text}    <a [^>]*>    ${EMPTY}
    ${message}=    Set Variable    ${dsg_LicenseReg_TimsOnlyLicense_Error}
    ${message}=    Replace String Using Regexp    ${message}    <a [^>]*>    ${EMPTY}
    ${matches}=    Get Regexp Matches    ${text}    ${message}
    Run Keyword IF    "${matches}"=="[]"    Capture Page Screenshot
    Run Keyword IF    "${matches}"=="[]"    Fail    Message LicenseReg_TimsOnlyLicense_Error no matches text of modal window
    Element Should Be Disabled    ${modalRegisterProduct_Field_Group}

The user add group
    GIVEN the user on the 'My Groups' page
    WHEN the user clicks link 'Add Group'
    THEN the modal window 'Register Product' appears
    Add Group    ${numLicense_GroupAdmin}
    AND the user clicks the 'Save changes' button
    THEN the user sees groups or message 'No Groups'

The user clicks the 'Save changes' button
    Wait Until Element Is Enabled    ${button_Save_RegisterProductOrLicenseModal}
    Click Element    ${button_Save_RegisterProductOrLicenseModal}
    Wait Until Page Contains Element    ${RegisterProductOrLicenseModal}[@aria-hidden='true']

Visibility of checkbox 'Membership Visibility'
    [Arguments]    ${locator}    ${isVisible}
    ${locator}=    Prepare Locator To JS    ${locator}${groupPage_ChkMembershipVisibility}
    ${isCheckbox}=    Get Matching Xpath Count    ${locator}
    ${msg}=    Set Variable IF    ${isVisible}==0 and ${isCheckbox}>0    Checkbox 'Membership Visibility' is visible, but not should    ${isVisible}!=0 and ${isCheckbox}==0    Checkbox 'Membership Visibility' is not visible, but should    ${EMPTY}
    Run Keyword IF    (${isVisible}==0 and ${isCheckbox}>0) or (${isVisible}!=0 and ${isCheckbox}==0)    Capture Page Screenshot
    Run Keyword IF    (${isVisible}==0 and ${isCheckbox}>0) or (${isVisible}!=0 and ${isCheckbox}==0)    Fail    ${msg}
    ${locator}=    Prepare Locator To JS    ${locator}//dt[text()[starts-with(., 'Membership Visibility:')]]
    ${isCheckbox}=    Get Matching Xpath Count    ${locator}
    ${msg}=    Set Variable IF    ${isVisible}==0 and ${isCheckbox}>0    Label 'Membership Visibility' is visible, but not should    ${isVisible}!=0 and ${isCheckbox}==0    Label 'Membership Visibility' is not visible, but should    ${EMPTY}
    Run Keyword IF    (${isVisible}==0 and ${isCheckbox}>0) or (${isVisible}!=0 and ${isCheckbox}==0)    Capture Page Screenshot
    Run Keyword IF    (${isVisible}==0 and ${isCheckbox}>0) or (${isVisible}!=0 and ${isCheckbox}==0)    Fail    ${msg}

The user closes modal window 'Add Expansion Unit'
    ${locator}=    Prepare Locator To JS    ${cancelButton_AddExpansionUnitModal}
    ${count_button}=    Get Matching Xpath Count    ${locator}
    Return From Keyword IF    ${count_button}==0
    Focus    ${cancelButton_AddExpansionUnitModal}
    Click Element    ${cancelButton_AddExpansionUnitModal}

The user navigates to license with the 'Transfer Key' button
    ${countLicenses}=    Evaluate    len(@{list_licenses})
    Return From Keyword IF    ${countLicenses}==0
    ${numLic}=    Evaluate    next((item.get('License', '') for item in ${list_licenses} if item.get('Button_TransferKey', -1)>0 and item.get('Rows_TransferKey', -1)>0), '')
    ${numLic}=    Run Keyword IF    "${numLic}"=="${EMPTY}"    Evaluate    next((item.get('License', '') for item in ${list_licenses} if item.get('Button_TransferKey', -1)>0), '')
    ...    ELSE    Set Variable    ${numLic}
    Run Keyword IF    "${numLic}"=="${EMPTY}"    Fail    Licenses with Transfer Key have not been found    invalidTestData
    Set Test Variable    ${numLicense_RetrieveKey}    ${numLic}
    Clicks link "Show Hidden Registered Products"
    Wait Until Element Is Visible    ${list_licenses_locator}[@data-lic='${numLic}']${licensesDetail_tab_retrieve}
    Scroll To Element    ${list_licenses_locator}[@data-lic='${numLic}']${licensesDetail_tab_retrieve}
    Focus    ${list_licenses_locator}[@data-lic='${numLic}']${licensesDetail_tab_retrieve}
    Click Element    ${list_licenses_locator}[@data-lic='${numLic}']${licensesDetail_tab_retrieve}

The user selects 'My Profile' option from the top masthead
    Clicks 'My Profile'

Clicks link "Show Hidden Registered Products"
    Comment    ${displayed_link}=    Evaluate    next((1 for item in @{list_licenses} if item.get('Visibility')=='Hide'), 0)
    Comment    Run Keyword IF    ${displayed_link}==1    Wait Until Page Contains Element    ${dsg_Licensing_Show_Registered_Licenses_locator}/ancestor::li[1][not(@style='display: none;')]
    ...    ELSE    Wait Until Page Contains Element    ${dsg_Licensing_Show_Registered_Licenses_locator}/ancestor::li[1][@style='display: none;']
    ${locator}=    Prepare Locator To JS    ${dsg_Licensing_Show_Registered_Licenses_locator}[text()[contains(., '${dsg_Licensing_Show_Registered_Licenses}')]][./ancestor::li[1][not(@style='display: none;')]]
    ${isShowHidden}=    Get Matching Xpath Count    ${locator}
    Comment    Run Keyword IF    ${displayed_link}==1 and ${isShowHidden}>0    Click Element    ${dsg_Licensing_Show_Registered_Licenses_locator}/ancestor::li[1][not(@style='display: none;')]
    Run Keyword IF    ${isShowHidden}>0    Scroll To Element    ${dsg_Licensing_Show_Registered_Licenses_locator}[./ancestor::li[1][not(@style='display: none;')]]
    Run Keyword IF    ${isShowHidden}>0    Click Element    ${dsg_Licensing_Show_Registered_Licenses_locator}[./ancestor::li[1][not(@style='display: none;')]]

The user sees the '${name_field}' field of Profile details
    ${id}=    Evaluate    &{QuestProfile_field}.get('${name_field}', None)
    Run Keyword IF    "${id}"=="${None}"    Fail    The test does not contain definition of the field '${name_field}'
    ${locator}=    Prepare Locator To JS    ${profilePage_DellSoftwareProfile_panel}//*[self::input or self::select][@id='${id}']
    ${countField}=    Get Matching XPath Count    ${locator}
    Run Keyword IF    ${countField}!=1    Capture Page Screenshot
    Run Keyword IF    ${countField}!=1    Fail    You need to check the field "${name_field}" in the profile

the user clicks 'My Group Membership' tab
    Wait Until Element Is Visible    ${profilePage_MyGroupMembership_tab}
    Scroll To Element    ${profilePage_MyGroupMembership_tab}
    Focus    ${profilePage_MyGroupMembership_tab}
    Click Element    ${profilePage_MyGroupMembership_tab}
