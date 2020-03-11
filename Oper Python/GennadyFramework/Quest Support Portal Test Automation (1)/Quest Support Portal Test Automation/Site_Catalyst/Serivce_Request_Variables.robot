*** Settings ***
Suite Setup       Global Setup
Test Setup        Logged in User 'yaseenma@yahoo.com' with pass 'quest123'    # yaseenma@yahoo.com \ \ \ quest123
Test Teardown     Close Working Session
Resource          ../Resources/Commons.robot
Resource          SiteCatalyst_Keywords.robot

*** Test Cases ***
Site Cat Variables for Create Service Request Page
    Go to Submit a Service Request page
    sleep    10
    Prepare Actual Site Catalyst Variables List For 'Create SR Page'
    Prepare Expected Site Catalyst Variables List
    Expected And Actual Variables Lists Should Be The Same

Site Cat Variables for Product Service Request Page
    Go to Submit a Service Request page
    The user selects product 'Directory Troubleshooter'
    The user selects 'ALISO VIEJO_TST - TEST ACCOUNT - PORTAL QA AUTOMATION (1-3Q551PB)' in the 'Account ID'
    The user clicks on the button 'Next'
    Sleep    10
    Prepare Actual Site Catalyst Variables List For 'SR Details Page'
    Prepare Expected Site Catalyst Variables List
    Extend Expected Variables List for Product Service Request Page
    Expected And Actual Variables Lists Should Be The Same

Site Cat Variables for Confirm Service Request Page
    Go to Submit a Service Request page
    The user selects product 'Directory Troubleshooter'
    The user selects 'ALISO VIEJO_TST - TEST ACCOUNT - PORTAL QA AUTOMATION (1-3Q551PB)' in the 'Account ID'
    The user clicks on the button 'Next'
    User fills Describe Service Request Details form
    Clicks on the button 'Save & Go To Confirmation'
    Wait for Submit Service Request Page
    Sleep    10
    Prepare Actual Site Catalyst Variables List For 'Confirm Service Request Page'
    Prepare Expected Site Catalyst Variables List
    Extend Expected Variables List for Confirm Service Request Page
    Expected And Actual Variables Lists Should Be The Same

Site Cat Variables for Service Request Page
    Go to Submit a Service Request page
    The user selects product 'Directory Troubleshooter'
    The user selects 'ALISO VIEJO_TST - TEST ACCOUNT - PORTAL QA AUTOMATION (1-3Q551PB)' in the 'Account ID'
    The user clicks on the button 'Next'
    User fills Describe Service Request Details form
    Clicks on the button 'Save & Go To Confirmation'
    Wait for Submit Service Request Page
    The user clicks on the button 'Submit Service Request'
    Wait for 'Complementary support services for trial users' dialog
    sleep    10
    Prepare Actual Site Catalyst Variables List For 'Service Request Page'
    Prepare Expected Site Catalyst Variables List
    Extend Expected Variables List for Service Request Page
    Expected And Actual Variables Lists Should Be The Same

*** Keywords ***
