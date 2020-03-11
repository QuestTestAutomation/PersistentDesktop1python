*** Settings ***
Test Teardown     KB Visibility Teardown
Force Tags        KB_Visibility
Test Template     KB Article Should Require Sign In
Test Timeout      10 minutes
Resource          ../Resources/Accounts.robot
Resource          ../Resources/Knowledge_Base_KB_Visibility_Resources.robot
Resource          Suite_KB_Visibility_Keywords_Resources.robot

*** Test Cases ***    User         KB_Number    Product      Status       Type        Premium_Sign_In
Anonymous [20762]     Anonymous    20762        SharePlex    Published    External    `# Days Required

Anonymous [115709]    Anonymous    115709       SharePlex    Published    External    Always Required
