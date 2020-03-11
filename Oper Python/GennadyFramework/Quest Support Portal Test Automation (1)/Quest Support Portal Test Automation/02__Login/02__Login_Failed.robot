*** Settings ***
Suite Setup       Global Setup
Test Teardown     Close Working Session
Resource          ../Resources/Commons.robot
Resource          SuiteLogin_Keywords_Resources.robot

*** Test Cases ***
Login with invalid credentials
    [Tags]    C134
    [Setup]    Prepare Mailbox
    GIVEN a user has support account and password of account is '12345robot'
    WHEN the user sign in and inputs the invalid password '12345'
    THEN The user receives error message about invalid credentials

Lock user account after 3 failed login attempts
    [Tags]    C137
    [Setup]    Prepare Mailbox
    Comment    Skip the rest of the test case for the following configurations    Samsung_GalaxyS6
    GIVEN a user has support account and password of account is '12345robot'
    WHEN the user sign in and inputs the invalid password '12345'
    THEN The user receives error message about invalid credentials
    WHEN the user tries to enter the invalid password '11111' again
    THEN The user receives error message about invalid credentials
    WHEN the user tries to enter the invalid password '22222' again
    THEN The user receives error message about invalid credentials
    WHEN the user tries to enter the valid password '12345robot' again
    THEN The user receives error message about lock user account

Login with invalid credentials (a mistake in the email address)
    [Tags]
    [Setup]    Prepare Mailbox
    GIVEN a user has support account and password of account is '12345robot'
    WHEN the user sign in
    AND inputs the invalid email address with additional leading character '*' and valid password '12345robot'
    THEN The user receives error message about invalid credentials

*** Keywords ***
The user receives error message about invalid credentials
    ${msg_re}=    Set Variable IF    "${LOCALE}"=="en-us"    The email address or password you entered is incorrect    "${LOCALE}"=="ja-jp"    入力されたEメールアドレスまたはパスワードが正しくありません    La dirección de correo electrónico o la contraseña que ingresó es incorrecta.
    Login is Failed    ${msg_re}    Invalid email address or password

The user receives error message about lock user account
    ${msg_re}=    Set Variable IF    "${LOCALE}"=="es-es"    La dirección de correo electrónico ${mailbox['email_addr']} está temporalmente bloqueada debido a los diversos intentos de inicio de sesión.    "${LOCALE}"=="ja-jp"    Eメールアドレス${mailbox['email_addr']}は、許容される回数を超えてサインインに失敗したため一時的にロックされています    The email address ${mailbox['email_addr']} is temporarily locked due to too many sign-in attempts. Please sign in using correct credentials after a minute. If you forgot your password, please reset it after a minute.
    Login is Failed    ${msg_re}    ${msg_re}

Inputs the invalid email address with additional leading character '${value}' and valid password '${pass}'
    SignIn    ${value}${mailbox['email_addr']}    ${pass}
    sleep    3
