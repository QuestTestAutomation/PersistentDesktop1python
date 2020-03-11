*** Settings ***
Documentation     Kathleen \ suggested to move tests 126049, 145398 to Exp Maint
Test Teardown     KB Visibility Teardown
Force Tags        KB_Visibility    debug
Test Template     KB Article Should Require Permission
Test Timeout      10 minutes
Resource          ../Resources/Accounts.robot
Resource          ../Resources/Knowledge_Base_KB_Visibility_Resources.robot
Resource          Suite_KB_Visibility_Keywords_Resources.robot

*** Test Cases ***    User                                         KB_Number    Product                     Status       Type        Premium_Sign_In
Partner w/ no DSG Cert but not entitled [126049]
                      ${Partner_w_no_DSG_Cert_but_not_entitled}    126049       SQL Navigator for Oracle    Published    External    `# Days Required

Partner w/ no DSG Cert but not entitled [145398]
                      ${Partner_w_no_DSG_Cert_but_not_entitled}    145398       SQL Navigator for Oracle    Published    External    Always Required
