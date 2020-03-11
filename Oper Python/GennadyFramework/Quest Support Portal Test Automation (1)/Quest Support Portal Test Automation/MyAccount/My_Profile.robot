*** Settings ***
Suite Setup       Global Setup
Test Teardown     Close Working Session
Resource          SuiteMyAccount_Keywords_Resources.robot

*** Variables ***

*** Test Cases ***
User updates profile and contact
    [Tags]
    [Setup]    Prepare Mailbox
    GIVEN a user has support account and password of account is '12345robot'
    WHEN the user sign in and inputs the valid password '12345robot'
    THEN the user is logged
    WHEN the user selects 'My Profile' option from the top masthead
    THEN the user on the 'My Profile' page
    AND the user sees all the required fields
    WHEN the user clicks "pen" icon
    THEN the user can edit these fields
    WHEN the user clicks the 'Save' button
    THEN new data have been saved
    WHEN the user clicks 'Change Password' link
    THEN the user on the 'Edit Password' page
    WHEN the user set password to '11111robot'
    THEN the password has been changed
    WHEN the user clicks 'My Login Credentials' tab
    THEN the user sees the account that is logged in
    Comment    WHEN the user clicks 'My Group Membership' tab

*** Keywords ***
The user sees all the required fields
    The user sees the 'First Name' field of Profile details
    The user sees the 'Last Name' field of Profile details
    The user sees the 'Phone Number' field of Profile details
    The user sees the 'Pager/Cell Phone' field of Profile details
    The user sees the 'Time Zone' field of Profile details
    The user sees the 'Preferred Contact Method' field of Profile details
    The user sees the 'Preferred Language' field of Profile details

The user can edit these fields
    Set Test Variable    ${xpath_to_field}    ${profilePage_DellSoftwareProfile_panel}
    Set Test Variable    &{id_field}    &{QuestProfile_field}
    Comment    Set Test Variable    &{value_field}    &{QuestProfile_value}
    Set 'New First Robot' to field 'First Name'
    Set 'New Last Robot' to field 'Last Name'
    Set '1230000000' to field 'Phone Number'
    Set '9990000000' to field 'Pager/Cell Phone'
    Select 'Russian Standard Time' in the 'Time Zone' selector
    Select 'Email' in the 'Preferred Contact Method' selector
    Select 'German' in the 'Preferred Language' selector

the user clicks "pen" icon
    Wait Until Page Contains Element    ${profilePage_profileEdit}
    Highlight Element    ${profilePage_profileEdit}
    Click Element    ${profilePage_profileEdit}

the user clicks the 'Save' button
    Wait Until Page Contains Element    ${profilePage_SaveProfile_button}
    Scroll To Element    ${profilePage_SaveProfile_button}
    Highlight Element    ${profilePage_SaveProfile_button}
    Click Element    ${profilePage_SaveProfile_button}
    Wait Until Page Contains Element    ${profilePage_profileButtonsId}

new data have been saved
    Value of 'First Name' field has been saved
    Value of 'Last Name' field has been saved
    Value of 'Phone Number' field has been saved
    Value of 'Pager/Cell Phone' field has been saved
    Value of 'Time Zone' selector has been saved
    Value of 'Preferred Contact Method' selector has been saved
    Value of 'Preferred Language' selector has been saved

Value of '${field_name}' field has been saved
    ${field}=    Set Variable    &{QuestProfile_field}[${field_name}]
    Run Keyword IF    "${field}"=="${None}"    Fail    The test does not contain definition of the field '${field_name}'
    ${valueElement}=    JS Get Value From Input    ${profilePage_DellSoftwareProfile_panel}//input[@id='${field}']
    ${editValue}=    Set Variable    &{value_field}[${field_name}]
    Run Keyword IF    "${valueElement}"!="${editValue}"    Capture Page Screenshot
    Run Keyword IF    "${valueElement}"!="${editValue}"    Fail    Value of '${field_name}' field does not match the typed value

Value of '${field_name}' selector has been saved
    ${field}=    Set Variable    &{QuestProfile_field}[${field_name}]
    Run Keyword IF    "${field}"=="${None}"    Fail    The test does not contain definition of the field '${field_name}'
    ${valueElement}=    JS Get Value From Select    ${profilePage_DellSoftwareProfile_panel}//select[@id='${field}']
    ${editValue}=    Set Variable    &{value_field}[${field_name}]
    Run Keyword IF    "${valueElement}"!="${editValue}"    Capture Page Screenshot
    Run Keyword IF    "${valueElement}"!="${editValue}"    Fail    Value of '${field_name}' field does not match the typed value

the user clicks 'Change Password' link
    Wait Until Page Contains Element    ${profilePage_ChangeDSGPassword_link}
    Scroll To Element    ${profilePage_ChangeDSGPassword_link}
    Highlight Element    ${profilePage_ChangeDSGPassword_link}
    Click Element    ${profilePage_ChangeDSGPassword_link}

the user set password to '${pass_value}'
    ${account}=    Evaluate    next((item for item in @{list_account} if item.get('email')=='${mailbox['email_addr']}'), None)
    log    ${account}
    Run Keyword IF    "${account}"=="${None}"    Fail    The account '${mailbox['email_addr']}' has not defined
    Wait Until Page Contains Element    ${at_UpdatePassword_username}[@value="${account['email']}"]    error=Email address did not appear on the Edit Password page in TIMEOUT.
    Change Password    ${pass_value}    ${account['password']}
    Fail Test If Alert

the password has been changed
    Active page should be Password Changed
    Back To Application
    The user selects 'My Profile' option from the top masthead

the user sees the account that is logged in
    Wait Until Page Contains Element    ${profilePage_dsgacct_locator}//span[text()[contains(., '${mailbox['email_addr']}')]]
    Wait Until Element Is Visible    ${profilePage_dsgacct_locator}//span[text()[contains(., '${mailbox['email_addr']}')]]
    Highlight Element    ${profilePage_dsgacct_locator}//span[text()[contains(., '${mailbox['email_addr']}')]]

the user clicks 'My Login Credentials' tab
    Wait Until Element Is Visible    ${profilePage_MyLoginCredentials_tab}
    Scroll To Element    ${profilePage_MyLoginCredentials_tab}
    Focus    ${profilePage_MyLoginCredentials_tab}
    Click Element    ${profilePage_MyLoginCredentials_tab}
