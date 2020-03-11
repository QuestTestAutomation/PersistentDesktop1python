*** Settings ***
Suite Setup       Global Setup
Test Teardown     Close Working Session
Resource          ../Resources/Commons.robot
Resource          SuiteLogin_Keywords_Resources.robot

*** Test Cases ***
Forgot Password
    [Tags]    debug    outdated
    [Setup]    Prepare Mailbox
    GIVEN a user has support account
    WHEN the user sign in
    AND clicks link 'Forgot Password'
    THEN the user on Reset Password page
    WHEN The user fills account email
    AND clicks button 'Reset Password'
    THEN the user receives email with temporary password
    AND Creates new password
    THEN the user is logged

Check link SignIn from email with forgotten password
    [Tags]    C135
    [Setup]    Prepare Mailbox
    GIVEN a user has support account
    WHEN the user sign in
    AND clicks link 'Forgot Password'
    THEN the user on Reset Password page
    WHEN The user fills account email
    AND clicks button 'Reset Password'
    THEN the user receives email with instruction to reset password
    WHEN the user navigates to email link "Quest Software Sign In"
    THEN the user on Update Password page
    WHEN the user resets password
    AND Sign in with new password
    THEN the user is logged

*** Keywords ***
