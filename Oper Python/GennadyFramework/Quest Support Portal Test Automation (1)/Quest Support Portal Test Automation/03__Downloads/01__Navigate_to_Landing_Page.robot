*** Settings ***
Suite Setup       Global Setup
Test Teardown     Close Working Session
Resource          ../Resources/Commons.robot
Resource          SuiteDownloads_Keywords_Resources.robot

*** Test Cases ***
User navigates to the 
    [Tags]    C90
    [Setup]    Prepare Account
    Skip the rest of the test case for the following configurations    Samsung_GalaxyS6    iPhone_6
    GIVEN the user 'quest123.qa@gmail.com' logged into portal
    WHEN the user navigates to Software Downloads
    Comment    AND selects test product in the ‘Select your product to find the latest Software’ selector
    Comment    THEN the user on ‘Download Software’ page of the test product
    AND selects product 'Foglight' in the ‘Select your product to find the latest Software’ selector
    THEN the user on ‘Download Software’ page of the 'Foglight' product
    WHEN the user clicks "Choose a different product"
    THEN the user on the products a-z page
    Comment    WHEN the user selects letter 'T' of A-Z list
    Comment    AND clicks product 'Toad for Oracle'
    WHEN the user selects product 'Toad for Oracle' in the ‘Select your product to find the latest Software’ selector
    THEN the user on ‘Download Software’ page of the 'Toad for Oracle' product
    WHEN the user changes version on '${TEST_PRODUCT_VERSION}'
    THEN the available installations for version appear
    WHEN the user clicks on the icon 'Download' 1
    THEN If 'Download' modal window appears the user clicks on the 'Continue' button
    AND modal window 'Add to My Downloads' appears
    AND background of 'Add to My Downloads' button is 'blue' color and font is 'white' color
    WHEN the user clicks 'Add to Downloads' button of modal window
    THEN modal window 'Add to My Downloads' has been closed
    WHEN the user clicks on the icon 'Download' 2
    THEN If 'Download' modal window appears the user clicks on the 'Continue' button
    AND modal window 'Add to My Downloads' appears
    AND background of 'Add to My Downloads' button is 'blue' color and font is 'white' color

Anonymous User navigates to the downloads landing page
    [Tags]    C94
    [Setup]    Prepare Account
    Skip the rest of the test case for the following configurations    Samsung_GalaxyS6    iPhone_6
    GIVEN an anonymous user on the Software Downloads page
    WHEN the user selects test product in the ‘Select your product to find the latest Software’ selector
    THEN the user on ‘Download Software’ page of the test product
    WHEN the user clicks "Choose a different product"
    THEN the user on the products a-z page
    WHEN the user selects letter 'A' of A-Z list
    AND clicks product 'Archive Manager'
    THEN the user on ‘Download Software’ page of the 'Archive Manager' product
    WHEN the user changes version on '5.3'
    THEN the available installations for version appear
    WHEN the user clicks on the icon 'Download' 1
    THEN If 'Download' modal window appears the user clicks on the 'Continue' button
    THEN the user on 'Sign In' page

Download notifications must show on the add to my downloads prompt
    [Tags]    
    [Setup]    Prepare Account
    Skip the rest of the test case for the following configurations    Samsung_GalaxyS6    iPhone_6
    GIVEN the user 'quest123.qa@gmail.com' logged into portal
    WHEN the user navigates to Software Downloads
    AND selects test product in the ‘Select your product to find the latest Software’ selector
    THEN the user on ‘Download Software’ page of the '${TEST_PRODUCT}' product
    WHEN the user changes version on '${TEST_PRODUCT_VERSION}'
    THEN the available installations for version appear
    THEN the user on ‘Download Software’ page of the 'Toad for Oracle' product
    WHEN the list of software contains links with notifications
    AND the user clicks on the icon 'Download'
    THEN If 'Download' modal window appears the user clicks on the 'Continue' button
    AND modal window 'Add to My Downloads' appears
    AND modal window 'Add to My Downloads' contains the notification description

*** Keywords ***
The user selects test product in the ‘Select your product to find the latest Software’ selector
    Selects test product in the ‘Select your product to find the latest Software’ selector
