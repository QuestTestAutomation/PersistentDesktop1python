*** Settings ***
Suite Setup       Global Setup
Test Teardown     Close Working Session
Resource          SuiteServiceRequest_Keywords_Resources.robot

*** Variables ***
&{contactInformation_field}    Service Request Number=SRNumber    Title Keyword Search=keyword
&{contactInformation_value}    Service Request Number=${EMPTY}    Title Keyword Search=${EMPTY}

*** Test Cases ***
Search SR
    [Setup]    Prepare Environment
    Comment    Skip the rest of the test case for the following configurations    iPhone_6    iPadAir_2
    GIVEN the user 'quest123.qa@gmail.com' logged into portal
    WHEN the user selects 'My Service Requests' in the submenu 'My Account' of menu 'Support'
    THEN the user on the 'My Service Requests' page
    AND the default filters are applied
    AND the user sees table of SR results
    WHEN the user selects value 'vRanger' of filter 'Product'
    AND scrolls to the button 'Go Search' and clicks
    THEN Search of SR with value 'vRanger' of filter 'Product' has been performed
    Comment    THEN The results table contains 2 rows
    WHEN the user selects value 'Companywide Requests' of filter 'Requester'
    AND scrolls to the button 'Go Search' and clicks
    Comment    THEN The results table contains 2 rows
    THEN Search of SR with value 'vRanger' of filter 'Product' has been performed
    WHEN the user selects value 'Closed' of filter 'Status'
    AND scrolls to the button 'Go Search' and clicks
    Comment    THEN The results table contains 3 rows
    THEN Search of SR with value 'vRanger' of filter 'Product' has been performed
    WHEN the user selects value '360 Days' of filter 'Last Updated'
    AND scrolls to the button 'Go Search' and clicks
    Comment    THEN search of SR for 7 Days has been performed
    Comment    THEN The results table contains 3 rows
    THEN Search of SR with value 'vRanger' of filter 'Product' has been performed
    WHEN the user set the value 'SR 2' to filter 'Title Keyword Search'
    AND clicks the button 'Go Search'
    THEN The results table contains 1 rows
    WHEN the user set the value '4105378' to filter 'Service Request Number'
    AND clicks the button 'Go Search'
    THEN SR '4105378' has been found
    WHEN the user clicks title of SR
    THEN the user on the page SR details
    WHEN the user clicks 'Return to my search'
    THEN the user on the 'My Service Requests' page
    WHEN the user clicks filter 'Product'
    THEN the user sees that values of filter and values of user's products are equal

*** Keywords ***
Prepare Environment
    Append To List    ${list_account}    ${EXTERNAL_ACCOUNT}
    Append To List    ${list_account}    ${EXTERNAL_ACCOUNT_TEMP}
    Set Test Variable    &{id_field}    &{contactInformation_field}
    Set Test Variable    &{value_field}    &{contactInformation_value}
    Set Test Variable    @{list_account}

The user sees all applied filters
    Visualization Applied Filter    ${filter_product_locator}    ${appliedFilter_Product}    Product    radio
    Visualization Applied Filter    ${filter_requester_locator}    ${appliedFilter_Requester}    Requester    radio
    Visualization Applied Filter    ${filter_updated_locator}    ${appliedFilter_Date}    Updated    radio
    Visualization Applied Filter    ${filter_status_locator}    ${appliedFilter_Status}    Status    checkbox

Visualization Applied Filter
    [Arguments]    ${filter_locator}    ${visualizationFilter_locator}    ${nameFilter}    ${typeFilter}=radio
    ${filter}=    Replace String    ${filter_locator}    "    '
    ${filter}=    Replace String    ${filter}    xpath=    ${EMPTY}
    ${appliedFilter}=    Replace String    ${visualizationFilter_locator}    "    '
    ${appliedFilter}=    Replace String    ${appliedFilter}    xpath=    ${EMPTY}
    ${count_item}=    Get Matching Xpath Count    ${filter}//div[@class='${typeFilter}']
    : FOR    ${index}    IN RANGE    ${count_item}
    \    ${is_checked}    ${value_attribute}=    Item Is Checked    ${filter}//div[@class='${typeFilter}'][${index}+1]//input    value
    \    ${visualization_value}=    Run Keyword IF    '${is_checked}'=='${True}'    Execute Javascript    return window.document.evaluate("${filter}//div[@class='${typeFilter}'][${index}+1]//text()[normalize-space()]", document, null, XPathResult.STRING_TYPE, null).stringValue;
    \    ...    ELSE    Set Variable    ${EMPTY}
    \    Run Keyword IF    '${is_checked}'=='${True}'    Exit For Loop
    ${visualization_value}=    Get Regexp Matches    ${visualization_value}    \\s*(.*)\\s*$    1
    ${visualization_value}=    Run Keyword IF    "${visualization_value}"!="[]"    Evaluate    ${visualization_value}[0]
    ...    ELSE    Set Variable    ${EMPTY}
    ${is_descriptionFilter}=    Get Matching Xpath Count    ${appliedFilter}[text()[contains(., '${visualization_value}')]]
    ${is_descriptionFilter}=    Run Keyword IF    ${is_descriptionFilter}==0 and '${value_attribute}'!='${EMPTY}'    Get Matching Xpath Count    ${appliedFilter}[text()[contains(., '${value_attribute}')]]
    ...    ELSE    Set Variable    ${is_descriptionFilter}
    Run Keyword IF    ${is_descriptionFilter}==0 and ('${typeFilter}'=='radio' or '${value_attribute}'!='${EMPTY}')    Fail    Visualization Applied Filter ${nameFilter} does not contain value '${visualization_value}'

The default filters are applied
    Radio Button Should Be Set To    Product    ${EMPTY}
    Radio Button Should Be Set To    StatusType    user
    Radio Button Should Be Set To    SearchDays    90
    Checkbox Should Be Selected    ${filter_status_locator}//div[@class='checkbox']//input[@value='Open']
    Checkbox Should Be Selected    ${filter_status_locator}//div[@class='checkbox']//input[@value='Investigating']
    Checkbox Should Be Selected    ${filter_status_locator}//div[@class='checkbox']//input[@value='Updated by Customer']
    Checkbox Should Be Selected    ${filter_status_locator}//div[@class='checkbox']//input[@value='Customer Response Requested']
    Checkbox Should Not Be Selected    ${filter_status_locator}//div[@class='checkbox']//input[@value='CR Tracking']
    Checkbox Should Not Be Selected    ${filter_status_locator}//div[@class='checkbox']//input[@value='RMA']
    Checkbox Should Not Be Selected    ${filter_status_locator}//div[@class='checkbox']//input[@value='RMA In Progress']
    Checkbox Should Not Be Selected    ${filter_status_locator}//div[@class='checkbox']//input[@value='RMA Requested']
    Checkbox Should Not Be Selected    ${filter_status_locator}//div[@class='checkbox']//input[@value='Closed']

The user sees that values of filter and values of user's products are equal
    ${filter_value}=    Create List
    ${table_value}=    Create List
    ${filter}=    Replace String    ${filter_product_locator}    "    '
    ${filter}=    Replace String    ${filter}    xpath=    ${EMPTY}
    ${count_item}=    Get Matching Xpath Count    ${filter}//div[@class='radio'][.//input[not(@value='')]]
    : FOR    ${index}    IN RANGE    ${count_item}
    \    ${value}=    Execute Javascript    return window.document.evaluate("${filter}//div[@class='radio'][.//input[not(@value='')]][${index}+1]/label/text()[normalize-space()]", document, null, XPathResult.STRING_TYPE, null).stringValue
    \    ${value}=    Get Regexp Matches    ${value}    \\s*(.*)\\s*$    1
    \    ${value}=    Run Keyword IF    "${value}"!="[]"    Evaluate    ${value}[0]
    \    ...    ELSE    Set Variable    ${EMPTY}
    \    Append To List    ${filter_value}    ${value}
    log    ${filter_value}
    The user selects 'My Products' in the submenu 'My Account' of menu 'Support'
    Table Is Enabled    ${at_MyProducts_ProductGrid}
    Comment    Wait Until Page Does Not Contain Element    ${icon_table-loading}
    Comment    Wait Until Element is Enabled    ${at_MyProducts_ProductGrid}
    Comment    Wait Until Element is Visible    ${at_MyProducts_ProductGrid}
    ${grid}=    Prepare Locator To JS    ${at_MyProducts_ProductGrid}
    ${totalPages}=    Prepare Locator To JS    ${paginationInfo_totalPages}
    Comment    ${count_item}=    Get Matching Xpath Count    ${grid}/tbody/tr
    ${isPagenation}=    Get Matching Xpath Count    ${totalPages}
    ${count_page}=    Run Keyword IF    ${isPagenation}>0    Execute Javascript    return window.document.evaluate("${totalPages}", document, null, XPathResult.STRING_TYPE, null).stringValue
    ...    ELSE    Set Variable    1
    : FOR    ${indexPage}    IN RANGE    ${count_page}
    \    Get Values of Table Column In List    ${grid}    2    ${table_value}
    \    Run Keyword IF    ${count_page}>1    Click Element    ${paginationInfo_buttonNext}
    \    Wait Until Element is Enabled    ${at_MyProducts_ProductGrid}
    log    ${table_value}
    Lists Should Be Equal    ${filter_value}    ${table_value}
    The user selects 'My Service Requests' in the submenu 'My Account' of menu 'Support'
    Comment    Go Back
    The user sees table of SR results

Get Values of Table Column In List
    [Arguments]    ${table_locator}    ${num_column}    ${list_value}
    ${grid}=    Prepare Locator To JS    ${table_locator}
    ${count_item}=    Get Matching Xpath Count    ${grid}/tbody/tr
    : FOR    ${index}    IN RANGE    ${count_item}
    \    ${value}=    Execute Javascript    return window.document.evaluate("${grid}/tbody/tr[${index}+1]/td[${num_column}]//text()[normalize-space()]", document, null, XPathResult.STRING_TYPE, null).stringValue
    \    ${value}=    Get Regexp Matches    ${value}    \\s*(.*)\\s*$    1
    \    ${value}=    Run Keyword IF    "${value}"!="[]"    Evaluate    ${value}[0]
    \    ...    ELSE    Set Variable    ${EMPTY}
    \    Append To List    ${list_value}    ${value}
