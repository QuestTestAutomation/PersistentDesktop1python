*** Settings ***
Suite Setup       Global Setup
Test Teardown     Close Working Session
Force Tags
Resource          SuiteServiceRequest_Keywords_Resources.robot

*** Variables ***
&{requered_field_local}    Business Email=Email    First Name=FirstName    Last Name=LastName    Descriptive Title=srt    Description of the Problem=description    Product Model=version    Contact me by=ddlContactMeBy
&{contactInformation_field}    Business Email=Email    First Name=FirstName    Last Name=LastName    Company Name=CompanyName    Address=Address    Postal Code=PostalCode    City=City
...               Country=Country    State=State    Descriptive Title=srt    Description of the Problem=description    License Number=IdentificationNumber    Phone Number=PhoneNumber    Product=SelectedProductId
...               Product Model=version    Environment Details=Environment    Contact me by=ddlContactMeBy    Account ID=ddlAtSite    Select Your Customer=enduser
&{contactInformation_value}    Business Email=${EMPTY}    First Name=${EMPTY}    Last Name=${EMPTY}    Company Name=${EMPTY}    Address=${EMPTY}    Postal Code=${EMPTY}    City=${EMPTY}
...               Country=${EMPTY}    State=${EMPTY}    Descriptive Title=${EMPTY}    Description of the Problem=${EMPTY}    License Number=${EMPTY}    Phone Number=${EMPTY}    Product=${EMPTY}
...               Product Model=${EMPTY}    Environment Details=${EMPTY}    Account ID=${EMPTY}
&{notFullyIntegratedProduct}    RemoteScan LAN=https://www.remote-scan.com/customer/contact.php

*** Test Cases ***
Create SR - User selects fully integrated product
    [Setup]    Prepare Environment
    Skip the rest of the test case for the following configurations    Samsung_GalaxyS6
    GIVEN an anonymous user on the Contact Support page
    WHEN the user clicks the button ''Submit Request'
    THEN the user on ‘Submit a Service Request’ page
    WHEN the user selects product 'Toad for Oracle'
    THEN the user on 'Sign In' page
    WHEN the user logs in as 'quest123.qa@gmail.com'
    Comment    THEN the user is logged
    THEN the user on ‘Submit a Service Request’ page and the user is logged
    WHEN the user selects 'ALISO VIEJO_TST - TEST ACCOUNT - PORTAL QA AUTOMATION (1-3Q551PB)' in the 'Account ID' selector
    AND the user clicks on the button 'Next'
    THEN the modal window about problem submitting SR does not appear
    AND the user fills requered filds
    AND Clicks on the button 'Save & Go To Confirmation'
    AND If 'Product Alert' modal window appears the user clicks on the 'Continue' button
    THEN the user on the page KB Articles that may match the issue
    WHEN the user clicks on the button 'Submit Service Request'
    THEN the modal window 'Service Request Submitted Confirmation' appears
    AND this window contains number SR
    Comment    THEN the modal window 'Support for Trial User' appears
    WHEN the user closes the modal window
    THEN the user on the page SR details

Create SR - User selects not fully integrated product
    [Setup]    Prepare Environment
    Skip the rest of the test case for the following configurations    iPhone_6    iPadAir_2    IE    Samsung_GalaxyS6
    GIVEN an anonymous user on the Contact Support page
    WHEN the user clicks the button ''Submit Request'
    THEN the user on ‘Submit a Service Request’ page
    WHEN the user selects product 'RemoteScan LAN'
    THEN the modal window 'Welcome to Quest Support' appears
    WHEN the user clicks 'Continue' button of modal window
    THEN the user redirects on a new tab to the support page of outside product 'RemoteScan LAN'

Create SR - User selects a trial product
    [Setup]    Prepare Environment
    Skip the rest of the test case for the following configurations    Samsung_GalaxyS6
    GIVEN the user 'quest123.qa@gmail.com' logged into portal
    Comment    WHEN the user selects 'Contact Support' in the 'Support' menu
    WHEN the user navigates to Contact Support Page
    THEN The user on the Contact Support page
    WHEN the user clicks the button ''Submit Request'
    THEN the user on ‘Submit a Service Request’ page
    WHEN the user selects product 'NC-NIM'
    Comment    THEN the modal window 'No Assigned License Number for Account Selected' appears
    Comment    WHEN the user closes the modal window
    AND the user selects 'ALISO VIEJO_TST - TEST ACCOUNT - PORTAL QA AUTOMATION (1-3Q551PB)' in the 'Account ID' selector
    AND the user clicks on the button 'Next'
    THEN the modal window about problem submitting SR does not appear
    AND the user fills requered filds
    AND Clicks on the button 'Save & Go To Confirmation'
    AND If 'Product Alert' modal window appears the user clicks on the 'Continue' button
    THEN the user on the page KB Articles that may match the issue
    WHEN the user clicks on the button 'Submit Service Request'
    THEN the modal window 'Support for Trial User' appears
    Comment    AND this window contains number SR
    WHEN the user closes the modal window
    THEN the user on the page SR details

Hard Fail-Creating SR through Portal
    [Setup]    Prepare Environment
    Skip the rest of the test case for the following configurations    Samsung_GalaxyS6
    log    ${HARD_FAIL}
    GIVEN the user 'quest123.qa@gmail.com' logged into portal
    Comment    WHEN the user selects 'Contact Support' in the 'Support' menu
    WHEN the user navigates to Contact Support Page
    THEN The user on the Contact Support page
    WHEN the user clicks the button ''Submit Request'
    THEN the user on ‘Submit a Service Request’ page
    WHEN the user selects product '${HARD_FAIL}'
    AND the user selects 'ALISO VIEJO_TST - TEST ACCOUNT - PORTAL QA AUTOMATION (1-3Q551PB)' in the 'Account ID' selector
    AND the user clicks on the button 'Next'
    THEN the modal window about problem submitting SR does not appear
    AND the modal window 'Expired Maintenance' appears

Create SR - Partner user creates a service request for non-partner account
    [Setup]    Prepare Environment
    Skip the rest of the test case for the following configurations    Samsung_GalaxyS6
    GIVEN the user 'spp.testaccount@yahoo.com' logged into portal
    Comment    WHEN the user selects 'Contact Support' in the 'Support' menu
    WHEN the user navigates to Contact Support Page
    THEN The user on the Contact Support page
    WHEN the user clicks the button ''Submit Request'
    THEN the user on ‘Submit a Service Request’ page
    WHEN the user selects product 'Toad for Oracle'
    AND the user selects "No" radio button for "Is this service request for a customer?"
    AND the user selects 'BELFIELD_2 - UNIVERSITY COLLEGE DUBLIN (1-9QELG-1779)' in the 'Account ID' selector
    WHEN the user clicks on the button 'Next'
    THEN the modal window about problem submitting SR does not appear
    AND the user fills requered filds
    AND Clicks on the button 'Save & Go To Confirmation'
    AND If 'Product Alert' modal window appears the user clicks on the 'Continue' button
    THEN the user on the page KB Articles that may match the issue
    WHEN the user clicks on the button 'Submit Service Request'
    THEN the modal window 'Support for Trial User' appears
    WHEN the user closes the modal window
    Comment    THEN the modal window 'Service Request Submitted Confirmation' appears
    Comment    AND this window contains number SR
    Comment    WHEN the user closes the modal window
    THEN the user on the page SR details

Create SR - Partner user creates a service request for partner account
    [Setup]    Prepare Environment
    Skip the rest of the test case for the following configurations    Samsung_GalaxyS6
    GIVEN the user 'spp.testaccount@yahoo.com' logged into portal
    Comment    WHEN the user selects 'Contact Support' in the 'Support' menu
    WHEN the user navigates to Contact Support Page
    THEN The user on the Contact Support page
    WHEN the user clicks the button ''Submit Request'
    THEN the user on ‘Submit a Service Request’ page
    WHEN the user selects product 'Toad for Oracle'
    AND the user selects "Yes" radio button for "Is this service request for a customer?"
    AND the user selects 'P_ALISO VIEJO - TEST ACCOUNT - PORTAL QA AUTOMATION SPP (1-3Q551Q0)' in the 'Account ID' selector
    AND the user selects 'TEST ACCOUNT - PORTAL QA AUTOMATION (1-3Q551PB)' in the 'Select Your Customer' selector
    WHEN the user clicks on the button 'Next'
    THEN the modal window about problem submitting SR does not appear
    AND the user fills requered filds
    AND Clicks on the button 'Save & Go To Confirmation'
    AND If 'Product Alert' modal window appears the user clicks on the 'Continue' button
    THEN the user on the page KB Articles that may match the issue
    WHEN the user clicks on the button 'Submit Service Request'
    THEN the modal window 'Service Request Submitted Confirmation' appears
    AND this window contains number SR
    Comment    THEN the modal window 'Support for Trial User' appears
    WHEN the user closes the modal window
    THEN the user on the page SR details

Soft Fail - Creating SR through Portal
    [Setup]    Prepare Environment
    Skip the rest of the test case for the following configurations    Samsung_GalaxyS6
    log    ${SOFT_FAIL}
    GIVEN the user 'quest123.qa@gmail.com' logged into portal
    Comment    WHEN the user selects 'Contact Support' in the 'Support' menu
    WHEN the user navigates to Contact Support Page
    THEN The user on the Contact Support page
    WHEN the user clicks the button ''Submit Request'
    THEN the user on ‘Submit a Service Request’ page
    WHEN the user selects product '${SOFT_FAIL}'
    AND If 'No Assigned License Number for Account Selected' modal window appears the user clicks on the 'Ok' button
    Comment    THEN the modal window 'No Assigned License Number for Account Selected' appears
    Comment    WHEN the user closes the modal window
    AND the user selects 'ALISO VIEJO_TST - TEST ACCOUNT - PORTAL QA AUTOMATION (1-3Q551PB)' in the 'Account ID' selector
    AND the user clicks on the button 'Next'
    THEN the modal window about problem submitting SR does not appear
    AND the user fills requered filds
    AND Clicks on the button 'Save & Go To Confirmation'
    AND If 'Product Alert' modal window appears the user clicks on the 'Continue' button
    THEN the user on the page KB Articles that may match the issue
    WHEN the user clicks on the button 'Submit Service Request'
    THEN the Soft Fail advisory message appears
    Comment    AND this window contains number SR
    WHEN the user closes the modal window
    THEN the user on the page SR details

*** Keywords ***
Prepare Environment
    Comment    Prepare Mailbox
    Append To List    ${list_account}    ${EXTERNAL_ACCOUNT}
    Append To List    ${list_account}    ${EXTERNAL_ACCOUNT_TEMP}
    Append To List    ${list_account}    ${PARTNER_ACCOUNT}
    Set Test Variable    &{id_field}    &{contactInformation_field}
    Set Test Variable    &{value_field}    &{contactInformation_value}
    Set Test Variable    ${xpath_to_field}    ${at_SR_create}
    Comment    Set Test Variable    ${email}    ${mailbox['email_addr']}
    Set Test Variable    &{requered_field}    &{requered_field_local}
    Set Test Variable    @{list_account}

The user redirects on a new tab to the support page of outside product '${name_product}'
    sleep    5
    Select Window    url=&{notFullyIntegratedProduct}[${name_product}]

The user selects '${value}' in the '${nameSelector}' selector
    Set Test Variable    ${xpath_to_field}    ${EMPTY}
    Select '${value}' in the '${nameSelector}' selector
    Set Test Variable    ${xpath_to_field}    ${at_SR_create}

The user on ‘Submit a Service Request’ page and the user is logged
    Wait Until Page Contains Element    ${at_SignInButton}
    Page Should Contain Element    ${at_dsg_General_SignOut}
    The user on ‘Submit a Service Request’ page
    Run Keyword IF    '${BROWSER}'=='IE'    Simulate    xpath=//select[@id='product']    change
    Close SRModal
