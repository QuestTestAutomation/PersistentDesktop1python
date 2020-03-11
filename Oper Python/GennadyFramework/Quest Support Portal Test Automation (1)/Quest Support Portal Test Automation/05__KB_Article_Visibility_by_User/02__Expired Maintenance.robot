*** Settings ***
Test Teardown     KB Visibility Teardown
Force Tags        KB_Visibility
Test Template     KB Article Should Notify Expired Maintenance
Test Timeout      10 minutes
Resource          ../Resources/Accounts.robot
Resource          ../Resources/Knowledge_Base_KB_Visibility_Resources.robot
Resource          Suite_KB_Visibility_Keywords_Resources.robot

*** Test Cases ***    User                   KB_Number    Product                     Status       Type        Premium_Sign_In
Ext User (Non Ent) [181974]
                      ${Ext_User_Non_Ent}    181974       SQL Navigator for Oracle    Published    External    `# Days Required

Ext User (Non Ent) [39141]
                      ${Ext_User_Non_Ent}    39141        SQL Navigator for Oracle    Published    External    Always Required
