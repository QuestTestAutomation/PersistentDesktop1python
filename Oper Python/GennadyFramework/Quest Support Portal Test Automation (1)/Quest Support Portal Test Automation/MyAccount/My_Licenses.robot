*** Settings ***
Suite Setup       Global Setup
Test Teardown     Close Working Session
Resource          SuiteMyAccount_Keywords_Resources.robot

*** Variables ***
@{list_ServiceTag}    2GXTQ12    7FXTQ12    1DXRVN1
${host_assignment}    dc=ad,dc=fcc

*** Test Cases ***
User navigates to "My Licenses" page
    [Setup]    Prepare Environment
    GIVEN the user 'yaseenma@yahoo.com' logged into portal
    WHEN the user selects 'My Licenses' in the submenu 'My Account' of menu 'Support'
    THEN the user on the 'My Assets - Software & Appliances' page
    AND the user sees own licenses
    AND the user sees all the required fields
    AND the user sees on the page 'My Licenses' all the required filters
    AND the user sees all the required links in the License details
    WHEN the user has hidden the licenses
    THEN the link "Show Hidden Registered Products" will be displayed, otherwise there is no
    WHEN the user select value 'Sort by Product Name' from Licenses Sort Option
    THEN the licenses are sorted by Product
    WHEN the user select value 'Sort by License Number' from Licenses Sort Option
    THEN the licenses are sorted by License
    WHEN the user clicks link 'Register Product FAQ'
    THEN the user on the 'My Product Licenses FAQ' page
    WHEN the user clicks link 'Manage Group Assignment'
    THEN the user on the 'My Groups' page
    WHEN some license contains link 'See All' and the user clicks this link
    THEN the modal window 'View License Users' appears
    WHEN some license contains link 'Request License Access' and the user clicks this link
    THEN the modal window 'Request License User Access' appears
    WHEN some license contains link 'Manage License Users' and the user clicks this link
    THEN the modal window 'Manage License Users' appears
    WHEN the user clicks tab 'Retrieve Key' of License where the user is a license user
    THEN the user sees license retrieve key heading
    WHEN the user clicks the button 'Add Expansion Unit'
    THEN the modal window 'Add Expansion Unit' appears
    WHEN the user closes modal window 'Add Expansion Unit'
    AND the user clicks tab 'Retrieve Key' of License where the user is not a license user
    THEN the user sees nonLicense retrieve key heading

My Assets - Retrieve Key Tab
    [Setup]    Prepare Environment
    GIVEN the user 'yaseenma@yahoo.com' logged into portal
    WHEN the user selects 'My Licenses' in the submenu 'My Account' of menu 'Support'
    THEN the user on the 'My Assets - Software & Appliances' page
    AND the user sees own licenses
    WHEN the user has hidden the licenses
    THEN the link "Show Hidden Registered Products" will be displayed, otherwise there is no
    WHEN the user clicks tab 'Retrieve Key' of License where the user is a license user
    THEN the user sees license retrieve key heading
    WHEN the user clicks the button 'Add Expansion Unit'
    THEN the modal window 'Add Expansion Unit' appears
    AND the user can add Expansion Unit if it has not been added yet
    AND the user sees all the required fields of the 'Expansion Unit' table
    WHEN the user navigates to license with the 'Transfer Key' button
    THEN the user can transfers key if it has not been transfered yet
    AND the user sees all the required fields of the 'Transfer Key' table

User wants to Hide/Show products
    [Setup]    Prepare Environment
    GIVEN the user 'yaseenma@yahoo.com' logged into portal
    WHEN the user selects 'My Account' option from the top masthead
    THEN the user on the 'My Products' page
    AND the user sees table of products
    WHEN the user selects 'My Licenses' in the submenu 'My Account' of menu 'Support'
    THEN the user on the 'My Assets - Software & Appliances' page
    AND the user sees own licenses
    Comment    WHEN the user has hidden the licenses
    Comment    THEN the link "Show Hidden Registered Products" will be displayed, otherwise there is no
    WHEN the user hides all products
    THEN all products are hidden
    WHEN the user shows all products
    THEN all products are shown

*** Keywords ***
The user has hidden the licenses
    sleep    1

The user on the 'My Groups' page
    Comment    ${current_url}=    Get Location
    ${countLicenses}=    Evaluate    len(@{list_licenses})
    Return From Keyword IF    ${countLicenses}==0
    Active page should be My Groups
    sleep    1
    Comment    Run Keyword IF    "${BROWSER}"=="IE"    Go To    ${current_url}
    ...    ELSE    Go Back
    Go To    ${current_url}

The user sees all the required fields
    The user sees the 'Primary Service Tag' field of License details
    The user sees the 'Related License Number' field of License details
    The user sees the 'License Number' field of License details
    The user sees the 'Description' field of License details
    The user sees the 'Version' field of License details
    The user sees the 'Group' field of License details
    The user sees the 'License User' field of License details
    The user sees the 'Quantity Owned' field of License details
    The user sees the 'Under Maintenance' field of License details
    The user sees the 'License Renewal' field of License details
    The user sees the 'Warranty Expiration' field of License details

Add Expansion Unit
    [Arguments]    ${license}
    Wait Until Element Is Enabled    ${assetInput_AddExpansionUnitModal}
    Click Element    ${assetInput_AddExpansionUnitModal}
    JS Set Value To Input    ${assetInput_AddExpansionUnitModal}    ${license}
    Highlight Element    ${addButton_AddExpansionUnitModal}
    Focus    ${addButton_AddExpansionUnitModal}
    Click Element    ${addButton_AddExpansionUnitModal}
    Wait Until Page Contains Element    ${AddExpansionUnitModal}[@aria-hidden='false']${icon_i-ui-loading}

the user can add Expansion Unit if it has not been added yet
    ${countLicenses}=    Evaluate    len(@{list_licenses})
    ${countServiceTag}=    Evaluate    len(@{list_ServiceTag})
    ${locator}=    Prepare Locator To JS    ${list_licenses_locator}${Licensing_Retrieve_Key_ExpansionUnit_rows}
    ${count_rows_ExpansionUnit}=    Get Matching Xpath Count    ${locator}
    Run Keyword IF    ${count_rows_ExpansionUnit}>0    The user closes modal window 'Add Expansion Unit'
    Return From Keyword IF    0 in (${countLicenses}, ${countServiceTag}) or "${numLicense_RetrieveKey}"=="${EMPTY}" or ${count_rows_ExpansionUnit}>0
    : FOR    ${index}    IN RANGE    ${countServiceTag}
    \    Add Expansion Unit    @{list_ServiceTag}[${index}]
    \    ${count_rows_ExpansionUnit}=    Get Matching Xpath Count    ${locator}
    \    Run Keyword IF    ${count_rows_ExpansionUnit}>0    Exit For Loop
    ${newCount_rows_ExpansionUnit}=    Get Matching Xpath Count    ${locator}
    Run Keyword IF    ${newCount_rows_ExpansionUnit}==0    Capture Page Screenshot
    Run Keyword IF    ${newCount_rows_ExpansionUnit}==0    Fail    Failed to add service tags (@{list_ServiceTag})    invalidTestData
    Run Keyword IF    ${newCount_rows_ExpansionUnit}<>${Count_rows_ExpansionUnit}    The user sees own licenses
    The user closes modal window 'Add Expansion Unit'

The user sees all the required fields of the 'Expansion Unit' table
    ${countLicenses}=    Evaluate    len(@{list_licenses})
    ${locator}=    Prepare Locator To JS    ${list_licenses_locator}${Licensing_Retrieve_Key_ExpansionUnit_rows}
    ${count_rows_ExpansionUnit}=    Get Matching Xpath Count    ${locator}
    Return From Keyword IF    0 in (${countLicenses}, ${count_rows_ExpansionUnit})
    ${index_item}=    Evaluate    next((index for index, item in enumerate(@{list_licenses}) if item.get('Rows_AddExpansionUnit', 0)>0), -1)
    Comment    ${locator}=    Prepare Locator To JS    ${list_licenses_locator}[${index_item}+1]
    ${locator}=    Prepare Locator To JS    ${list_licenses_locator}[@data-lic='${numLicense_RetrieveKey}']
    ${isActive_Tab}=    Get Matching XPath Count    ${locator}${licensesDetail_tab_retrieve}/ancestor::li[1][@class[contains(., 'active')]]
    Run Keyword IF    ${isActive_Tab}==0    Click Element    xpath=${locator}${licensesDetail_tab_retrieve}
    &{new_dict}=    Evaluate    {k: "${locator}" + ${ExpansionUnit_nameColumn_Table}[k] for k in ${ExpansionUnit_nameColumn_Table}}
    log many    ${new_dict}
    Set Test Variable    &{ExpansionUnit_nameColumn_Table}    &{new_dict}
    the user sees the 'License Number' column of Expansion Unit table
    the user sees the 'Product' column of Expansion Unit table
    the user sees the 'Expansion Unit Service Tag' column of Expansion Unit table

The user can transfers key if it has not been transfered yet
    ${countLicenses}=    Evaluate    len(@{list_licenses})
    Return From Keyword IF    ${countLicenses}==0 or "${numLicense_RetrieveKey}"=="${EMPTY}"
    ${locator}=    Prepare Locator To JS    ${list_licenses_locator}[@data-lic='${numLicense_RetrieveKey}']
    ${locator_button}=    Prepare Locator To JS    ${dsg_Licensing_Retrieve_Key_Transfer_Key_locator}
    ${count_button}=    Get Matching Xpath Count    ${locator}${locator_button}[@class[not(contains(., 'disabled'))]]
    Return From Keyword IF    ${count_button}==0
    Highlight Element    ${locator}${locator_button}
    Focus    ${locator}${locator_button}
    Click Element    ${locator}${locator_button}
    Transfer Key
    ${locator_table}=    Prepare Locator To JS    ${Licensing_Retrieve_Key_TransferKey_rows}
    ${newCount_rows_TransferKey}=    Get Matching Xpath Count    ${locator}${Licensing_Retrieve_Key_TransferKey_rows}
    Run Keyword IF    ${newCount_rows_TransferKey}==0    Capture Page Screenshot
    Run Keyword IF    ${newCount_rows_TransferKey}==0    Fail    Failed to transfer key    invalidTestData

Transfer Key
    Comment

The user sees all the required fields of the 'Transfer Key' table
    ${countLicenses}=    Evaluate    len(@{list_licenses})
    ${locator}=    Prepare Locator To JS    ${list_licenses_locator}${Licensing_Retrieve_Key_TransferKey_rows}
    ${count_rows_TransferKey}=    Get Matching Xpath Count    ${locator}
    Return From Keyword IF    0 in (${countLicenses}, ${count_rows_TransferKey})
    Comment    ${index_item}=    Evaluate    next((index for index, item in enumerate(@{list_licenses}) if item.get('Rows_TransferKey', 0)>0), -1)
    Comment    ${locator}=    Prepare Locator To JS    ${list_licenses_locator}[${index_item}+1]
    ${locator}=    Prepare Locator To JS    ${list_licenses_locator}[@data-lic='${numLicense_RetrieveKey}']
    ${isActive_Tab}=    Get Matching XPath Count    ${locator}${licensesDetail_tab_retrieve}/ancestor::li[1][@class[contains(., 'active')]]
    Run Keyword IF    ${isActive_Tab}==0    Click Element    xpath=${locator}${licensesDetail_tab_retrieve}
    &{new_dict}=    Evaluate    {k: "${locator}" + ${TransferKey_nameColumn_Table}[k] for k in ${TransferKey_nameColumn_Table}}
    log many    ${new_dict}
    Set Test Variable    &{TransferKey_nameColumn_Table}    &{new_dict}
    the user sees the 'Property Name' column of Transfer Key table
    the user sees the 'Property Value' column of Transfer Key table

the user hides all products
    hide/show all products    0

all products are hidden
    ${locator}=    Prepare Locator To JS    ${list_licenses_locator}
    ${count_lic}=    Get Matching Xpath Count    ${locator}
    : FOR    ${index}    IN RANGE    ${count_lic}
    \    Element Should Not Be Visible    ${list_licenses_locator}[${index+1}]    Not all products have been hidden

hide/show all products
    [Arguments]    ${action}=0    # 0-Hide, 1-Show
    Comment    ${dict}=    Create Dictionary
    ${temp_list}=    Create List
    ${valueLink}=    Set Variable IF    ${action}==0    ${dsg_Common_Hide}    ${dsg_Common_Show}
    ${valueList}=    Set Variable IF    ${action}==0    Hide    Show
    ${count}=    Evaluate    len(@{list_licenses})
    : FOR    ${index}    IN RANGE    ${count}
    \    ${visibility}=    Evaluate    @{list_licenses}[${index}].get('Visibility')
    \    ${license}=    Evaluate    @{list_licenses}[${index}].get('License')
    \    ${locator}=    Set Variable    ${div_Licensing}//div[@data-lic='${license}']/a[text()[starts-with(., '${valueLink}')]]
    \    Run Keyword IF    ("${visibility}"=="Show" and ${action}==0) or ("${visibility}"=="Hide" and ${action}==1)    Scroll To Element    ${locator}
    \    Run Keyword IF    ("${visibility}"=="Show" and ${action}==0) or ("${visibility}"=="Hide" and ${action}==1)    Highlight Element    ${locator}
    \    Run Keyword IF    ("${visibility}"=="Show" and ${action}==0) or ("${visibility}"=="Hide" and ${action}==1)    Click Element    ${locator}
    \    Run Keyword IF    "${visibility}"=="Show" and ${action}==0    Wait Until Element Is Not Visible    ${locator}
    \    ${dict}=    Get From List    ${list_licenses}    ${index}
    \    Run Keyword IF    ("${visibility}"=="Show" and ${action}==0) or ("${visibility}"=="Hide" and ${action}==1)    Set To Dictionary    ${dict}    Visibility=${valueList}
    \    Append To List    ${temp_list}    ${dict}
    Set Test Variable    ${list_licenses}    ${temp_list}
    log many    @{list_licenses}

the user shows all products
    Clicks link "Show Hidden Registered Products"
    hide/show all products    1

all products are shown
    ${locator}=    Prepare Locator to JS    ${list_licenses_locator}/a[@style="display: none;"][not(text()='${dsg_Common_Show}')]
    ${countHide}=    Get Matching Xpath Count    ${locator}
    Run Keyword IF    ${countHide}>0    Capture Page Screenshot
    Run Keyword IF    ${countHide}>0    Fail    Not all products have been shown
    ${locator}=    Prepare Locator To JS    ${list_licenses_locator}
    ${count_lic}=    Get Matching Xpath Count    ${locator}
    : FOR    ${index}    IN RANGE    ${count_lic}
    \    Element Should Be Visible    ${list_licenses_locator}[${index+1}]    Not all products have been shown
