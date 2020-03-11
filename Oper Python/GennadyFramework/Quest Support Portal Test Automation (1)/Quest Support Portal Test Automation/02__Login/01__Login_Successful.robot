*** Settings ***
Suite Setup       Global Setup
Test Teardown     Close Working Session
Resource          ../Resources/Commons.robot
Resource          SuiteLogin_Keywords_Resources.robot

*** Test Cases ***
Login with valid credentials
    [Setup]    Prepare Mailbox
    GIVEN a user has support account and password of account is '12345robot'
    WHEN the user sign in and inputs the valid password '12345robot'
    THEN the user is logged

Login with valid @software.dell.com credentials
    [Tags]    debug
    [Setup]    Set Known Email Adress    ${VALID_DSG_ACCOUNT['email']}
    When The user sign in and inputs the valid password '${VALID_DSG_ACCOUNT['password']}'
    THEN the user is logged

Login with valid @quest.com credentials
    [Tags]    debug    outdated
    [Setup]    Set Known Email Adress    ${VALID_QUEST_ACCOUNT['email']}
    When The user sign in and inputs the valid password '${VALID_QUEST_ACCOUNT['password']}'
    THEN the user is logged

Login with RememberMe
    [Tags]
    [Setup]    Prepare Environment
    WHEN the user logs in as 'quest123.qa@gmail.com' and marks the "Remember Me" checkbox
    THEN the user is logged
    WHEN the user Sign out
    AND the user again navigates to Sign In page
    THEN the 'Email' field contains value 'quest123.qa@gmail.com'

*** Keywords ***
Prepare Environment
    Append To List    ${list_account}    ${EXTERNAL_ACCOUNT}
    Append To List    ${list_account}    ${EXTERNAL_ACCOUNT_TEMP}
    Append To List    ${list_account}    ${PARTNER_ACCOUNT}
    Set Test Variable    @{list_account}

The 'Email' field contains value '${value_email}'
    sleep    2
    ${valueElement}=    JS Get Value From Input    ${at_SignIn_emailAddress}
    Run Keyword IF    "${valueElement}"!="${value_email}"    Fail    Email address does not contain ${value_email}
    Comment    Wait Until Page Contains Element    ${at_SignIn_emailAddress}[@value="${value_email}"]    error=Email address does not contain ${value_email}
    sleep    1
