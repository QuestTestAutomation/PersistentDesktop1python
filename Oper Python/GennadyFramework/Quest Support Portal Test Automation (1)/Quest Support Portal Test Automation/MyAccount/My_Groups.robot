*** Settings ***
Suite Setup       Global Setup
Test Teardown     Close Working Session
Resource          SuiteMyAccount_Keywords_Resources.robot

*** Variables ***

*** Test Cases ***
User registers TIMS-Only License
    [Setup]    Prepare Environment
    GIVEN the user 'quest123.qa@gmail.com' logged into portal
    WHEN the user selects 'My Groups' in the submenu 'My Account' of menu 'Support'
    THEN the user on the 'My Groups' page
    AND the user sees groups or message 'No Groups'
    AND the user sees all the required fields
    AND the user sees on the page 'My Groups' all the required filters
    WHEN the user select value 'Sort by Group Name (A-Z)' from Groups Sort Option
    THEN the groups are sorted by Name
    WHEN the user select value 'Sort by Newest' from Groups Sort Option
    THEN the groups are sorted by Newest
    WHEN the user clicks link 'Groups FAQ'
    THEN the user on the 'My Group FAQ' page
    WHEN the user clicks link 'Add Group'
    THEN the modal window 'Register Product' appears
    WHEN the user enters TIMS-Only license number in the field 'Asset Number'
    THEN the user receives TimsOnlyLicense error
    Comment    AND the button 'Save Changes' is disabled
    WHEN the user clicks the 'View License' link in this error message
    THEN the user on the View License page

Support or license user views group visibility on "My Profile"
    [Setup]    Prepare Environment
    GIVEN the user 'yaseenma@yahoo.com' logged into portal
    WHEN the user selects 'My Groups' in the submenu 'My Account' of menu 'Support'
    THEN the user on the 'My Groups' page
    AND the user sees groups or message 'No Groups'
    WHEN the user navigates to a group for which he or she is the admin
    AND the admin hides members of group
    THEN the admin sees members of group
    WHEN the user Sign out
    AND the user logs in as 'quest123.qa@gmail.com'
    THEN the user is logged
    WHEN the user selects 'My Groups' in the submenu 'My Account' of menu 'Support'
    THEN the user on the 'My Groups' page
    AND the user sees groups or message 'No Groups'
    WHEN the user navigates to the group that the admin has configured
    THEN the 'Membership Visibility' checkbox for this group is not visible
    AND the user sees only his/her account and admin account

*** Keywords ***
The user sees all the required fields
    The user sees the 'Group Name' field of Group details
    The user sees the 'Description' field of Group details
    The user sees the 'Membership Visibility' field of Group details
    The user sees the 'Products' field of Group details

The button 'Save Changes' is disabled
    Wait Until Element Is Disabled    ${modalRegisterProduct_Button_SaveChanges}    disabled=""

The user selects value '${filter_value}' of filter '${filter_name}'
    ${locator}=    Evaluate    &{groupPage_filters_xpath}.get('${filter_name}', None)
    Run Keyword IF    "${locator}"=="${None}"    Fail    The test does not contain definition of the filter '${filter_name}'
    Select value of filter    ${locator}    ${filter_name}    ${None}    ${filter_value}

The user navigates to a group for which he or she is the admin
    ${index_item}=    Evaluate    next((index for index, item in enumerate(@{list_groups}) if item.get('isAdminGroup', -1)==1 and item.get('isMembershipVisibility', -1)==0), -1)
    ${index_item}=    Run Keyword IF    ${index_item}==-1    Evaluate    next((index for index, item in enumerate(@{list_groups}) if item.get('isAdminGroup', -1)==1), -1)
    ...    ELSE    Set Variable    ${index_item}
    Run Keyword IF    ${index_item}==-1    Fail    Groups for which the user is admin has not been found
    Set Test Variable    ${index_list}    ${index_item}
    Scroll To Element    ${list_groups_locator}[${index_list}+1]
    ${locator}=    Prepare Locator To JS    ${list_groups_locator}[${index_list}+1]
    ${isActive_Tab}=    Get Matching XPath Count    ${locator}${groupsPage_tab_TabGroupData}[@class='active']
    Run Keyword IF    ${isActive_Tab}==0    Click Element    xpath=${locator}${groupsPage_tab_TabGroupData}
    ${count_Btn_EditGroup}=    Get Matching XPath Count    ${locator}[.${groupPage_Btn_EditGroup}]
    Run Keyword IF    ${count_Btn_EditGroup}==0    Fail    Group for which the user is admin does not contain the 'EditGroup' button
    ${license_group}=    Evaluate    @{list_groups}[${index_list}].get('Group License', '')
    Set Test Variable    ${numLicense_GroupAdmin}    ${license_group}

The admin hides members of group
    Run Keyword IF    ${index_list}==-1    Fail    Groups for which the user is admin has not been found
    ${locator}=    Prepare Locator To JS    ${list_groups_locator}[${index_list}+1]
    Comment    Highlight Element    ${locator}${groupPage_ChkMembershipVisibility}//ancestor::dd[1]//input[ancestor::div[1][@name='ContainerInfo']]
    Highlight Element    ${locator}${groupPage_ChkMembershipVisibility}//ancestor::dd[1]//div[@name='ContainerInfo']
    ${is_checked}=    Get Matching XPath Count    ${locator}${groupPage_ChkMembershipVisibility}[@checked='checked']
    Return From Keyword IF    ${is_checked}==0
    Focus    ${locator}${groupPage_Btn_EditGroup}
    Highlight Element    ${locator}${groupPage_Btn_EditGroup}
    Click Element    ${locator}${groupPage_Btn_EditGroup}
    Wait Until Element is Visible    ${locator}${groupPage_ChkMembershipVisibility}
    Focus    ${locator}${groupPage_ChkMembershipVisibility}
    Click Element    ${locator}${groupPage_ChkMembershipVisibility}
    Save Edit Group    ${locator}${groupPage_Btn_SaveGroupInfo}
    Run Keyword IF    ${index_list}==-1    Fail    Groups for which the user is admin has not been found
    Scroll To Element    ${list_groups_locator}[${index_list}+1]

Save Edit Group
    [Arguments]    ${locator}
    Focus    ${locator}
    Click Element    ${locator}
    the user sees groups or message 'No Groups'
    ${index_item}=    Evaluate    next((index for index, item in enumerate(@{list_groups}) if item.get('Group License', -1)=='${numLicense_GroupAdmin}'), -1)
    Set Test Variable    ${index_list}    ${index_item}

The admin sees members of group
    Run Keyword IF    ${index_list}==-1    Fail    Groups for which the user is admin has not been found
    ${locator}=    Prepare Locator To JS    ${list_groups_locator}[${index_list}+1]
    ${isActive_Tab}=    Get Matching XPath Count    ${locator}${groupsPage_tab_TabGroupMembers}[@class='active']
    Run Keyword IF    ${isActive_Tab}==0    Click Element    xpath=${locator}${groupsPage_tab_TabGroupMembers}
    &{new_dict}=    Evaluate    {k: "${locator}" + ${Members_nameColumn_Table}[k] for k in ${Members_nameColumn_Table}}
    log many    ${new_dict}
    Set Test Variable    &{Members_nameColumn_Table}    &{new_dict}
    the user sees the 'Name' column of Members table
    the user sees the 'Email Id' column of Members table
    the user sees the 'Admin' column of Members table
    the user sees the 'Support' column of Members table
    the user sees the 'License User' column of Members table
    log many    &{Members_numColumn_Table}

The user navigates to the group that the admin has configured
    Run Keyword IF    "${numLicense_GroupAdmin}"=="${EMPTY}"    Fail    Information about License for the test is not found
    ${index_item}=    Evaluate    next((index for index, item in enumerate(@{list_groups}) if item.get('Group License', -1)=='${numLicense_GroupAdmin}'), -1)
    Run Keyword IF    ${index_item}==-1    The user add group
    ${index_item}=    Run Keyword IF    ${index_item}==-1    Evaluate    next((index for index, item in enumerate(@{list_groups}) if item.get('Group License', -1)=='${numLicense_GroupAdmin}'), -1)
    ...    ELSE    Set Variable    ${index_item}
    Run Keyword IF    ${index_item}==-1    Fail    Test group has not been found
    Set Test Variable    ${index_list}    ${index_item}
    Scroll To Element    ${list_groups_locator}[${index_list}+1]

The 'Membership Visibility' checkbox for this group is not visible
    Visibility of checkbox 'Membership Visibility'    ${list_groups_locator}[${index_list}+1]    0

the user sees only his/her account and admin account
    ${LoggedUserEmail}=    Evaluate    @{list_groups}[${index_list}].get('LoggedUserEmail', '')
    ${lower_LoggedUserEmail}=    Convert To Lowercase    ${LoggedUserEmail}
    ${locator}=    Prepare Locator To JS    ${list_groups_locator}[${index_list}+1]
    ${isActive_Tab}=    Get Matching XPath Count    ${locator}${groupsPage_tab_TabGroupMembers}[@class='active']
    Run Keyword IF    ${isActive_Tab}==0    Click Element    xpath=${locator}${groupsPage_tab_TabGroupMembers}
    ${count_user}=    Get Matching Xpath Count    ${locator}//tr[@id='InfoRow']
    ${countNotAdmin_ExcludeSelf}=    Get Matching Xpath Count    ${locator}//tr[@id='InfoRow'][.//input[@id='HdnEmail' and @value!='${LoggedUserEmail}' and @value!='${lower_LoggedUserEmail}']][.//input[@name='ChkAdmin' and not(@checked='checked')]]
    ${countNotAdmin_Self}=    Get Matching Xpath Count    ${locator}//tr[@id='InfoRow'][.//input[@id='HdnEmail' and (@value='${LoggedUserEmail}' or @value='${lower_LoggedUserEmail}')]][.//input[@name='ChkAdmin' and not(@checked='checked')]]
    ${countAdmin_ExcludeSelf}=    Get Matching Xpath Count    ${locator}//tr[@id='InfoRow'][.//input[@id='HdnEmail' and @value!='${LoggedUserEmail}' and @value!='${lower_LoggedUserEmail}']][.//input[@name='ChkAdmin' and @checked='checked']]
    ${countAdmin_Self}=    Get Matching Xpath Count    ${locator}//tr[@id='InfoRow'][.//input[@id='HdnEmail' and (@value='${LoggedUserEmail}' or @value='${lower_LoggedUserEmail}')]][.//input[@name='ChkAdmin' and @checked='checked']]
    ${msg}=    Set Variable IF    ${countNotAdmin_ExcludeSelf}!=0    The user sees other non Admin users, but not should    ${countNotAdmin_Self}>1    The user sees multiple rows of self account    ${countNotAdmin_Self}>0 and ${countAdmin_Self}>0
    ...    The user can not be both an admin and non admin at the same time    ${EMPTY}
