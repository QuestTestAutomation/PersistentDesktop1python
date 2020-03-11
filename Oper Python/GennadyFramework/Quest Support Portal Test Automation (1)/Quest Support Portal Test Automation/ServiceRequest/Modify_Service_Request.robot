*** Settings ***
Suite Setup       Global Setup
Test Teardown     Close Working Session
Resource          SuiteServiceRequest_Keywords_Resources.robot

*** Variables ***
&{requered_field_local}    Business Email=Email    First Name=FirstName    Last Name=LastName    Descriptive Title=srt    Description of the Problem=description    Product Model=version    Contact me by=ddlContactMeBy
&{contactInformation_field}    Business Email=Email    First Name=FirstName    Last Name=LastName    Company Name=CompanyName    Address=Address    Postal Code=PostalCode    City=City
...               Country=Country    State=State    Descriptive Title=srt    Description of the Problem=description    License Number=IdentificationNumber    Phone Number=PhoneNumber    Product=SelectedProductId
...               Product Model=version    Environment Details=Environment    Contact me by=ddlContactMeBy    Account ID=ddlAtSite    Service Request Number=SRNumber    Descriptive name=fileDescription
&{contactInformation_value}    Business Email=${EMPTY}    First Name=${EMPTY}    Last Name=${EMPTY}    Company Name=${EMPTY}    Address=${EMPTY}    Postal Code=${EMPTY}    City=${EMPTY}
...               Country=${EMPTY}    State=${EMPTY}    Descriptive Title=${EMPTY}    Description of the Problem=${EMPTY}    License Number=${EMPTY}    Phone Number=${EMPTY}    Product=${EMPTY}
...               Product Model=${EMPTY}    Environment Details=${EMPTY}    Account ID=${EMPTY}    Service Request Number=${EMPTY}    Descriptive name=${EMPTY}
&{notFullyIntegratedProduct}    RemoteScan LAN=http://www.remote-scan.com/customer/index.php

*** Test Cases ***
Modify SR - Add Attachment
    [Setup]    Prepare Environment
    Skip the rest of the test case for the following configurations    iPhone_6    iPadAir_2    Samsung_GalaxyS6
    GIVEN the user 'quest123.qa@gmail.com' created SR for the product 'Toad for Oracle'
    WHEN the user 'quest123.qa@gmail.com' logged into portal
    AND the user selects 'My Service Requests' in the submenu 'My Account' of menu 'Support'
    THEN the user on the 'My Service Requests' page
    log    ${SR_Number}
    WHEN the user set the value '${SR_Number}' to filter 'Service Request Number'
    AND clicks the button 'Go Search'
    THEN SR '${SR_Number}' has been found
    WHEN the user clicks title of SR '${SR_Number}'
    THEN the user on the page SR details
    WHEN the user clicks 'Add Attachments'
    THEN the modal window 'Update Service Request' appears
    WHEN the user set '1.txt' to field 'Attach file'
    AND adds descriptive name of the file
    AND the user clicks button 'Attach to Request'
    THEN the file is uploaded
    AND the user sees a link to the uploaded file

Modify SR - Add Note
    [Setup]    Prepare Environment
    Skip the rest of the test case for the following configurations    iPhone_6    iPadAir_2    Samsung_GalaxyS6
    GIVEN the user 'quest123.qa@gmail.com' created SR for the product 'Toad for Oracle'
    WHEN the user 'quest123.qa@gmail.com' logged into portal
    AND the user selects 'My Service Requests' in the submenu 'My Account' of menu 'Support'
    THEN the user on the 'My Service Requests' page
    log    ${SR_Number}
    WHEN the user set the value '${SR_Number}' to filter 'Service Request Number'
    AND clicks the button 'Go Search'
    THEN SR '${SR_Number}' has been found
    WHEN the user clicks title of SR '${SR_Number}'
    THEN the user on the page SR details
    WHEN the user clicks 'Add Note'
    THEN the modal window 'Add Service Request Note' appears
    WHEN the user set text 'Note to SR #${SR_Number}' to field 'Add Note to Service Request'
    AND the user clicks button 'Add Note'
    THEN the note is added
    AND The user sees added note 'Note to SR #${SR_Number}'

*** Keywords ***
Prepare Environment
    Comment    Prepare Mailbox
    Append To List    ${list_account}    ${EXTERNAL_ACCOUNT}
    Append To List    ${list_account}    ${EXTERNAL_ACCOUNT_TEMP}
    Set Test Variable    &{id_field}    &{contactInformation_field}
    Set Test Variable    &{value_field}    &{contactInformation_value}
    Set Test Variable    ${xpath_to_field}    ${at_SR_create}
    Comment    Set Test Variable    ${email}    ${mailbox['email_addr']}
    Set Test Variable    &{requered_field}    &{requered_field_local}
    Set Test Variable    @{list_account}

The user selects '${value}' in the '${nameSelector}' selector
    Set Test Variable    ${xpath_to_field}    ${EMPTY}
    Select '${value}' in the '${nameSelector}' selector
    Set Test Variable    ${xpath_to_field}    ${at_SR_create}

The user set '${name_file}' to field 'Attach file'
    Choose File    ${AttachFile_locator}    ${CURDIR}${/}..${/}Resources${/}Files${/}${name_file}

Adds descriptive name of the file
    Set Test Variable    ${xpath_to_field}    ${EMPTY}
    Set 'Descriptive name of the file (SR #${SR_Number})' to field 'Descriptive name'

The user clicks button 'Attach to Request'
    Scroll To Element    ${dsg_SR_AttachToRequest_locator}
    Focus    ${dsg_SR_AttachToRequest_locator}
    Click Element    ${dsg_SR_AttachToRequest_locator}

The file is uploaded
    Wait Until Page Contains Element    ${attach-modal}[@aria-hidden='true']

The user sees a link to the uploaded file
    Wait Until Page Contains Element    xpath=//div[@id='tab1']//a[text()[contains(., 'Descriptive name of the file (SR #${SR_Number})')]]
    Scroll To Element    xpath=//div[@id='tab1']//a[text()[contains(., 'Descriptive name of the file (SR #${SR_Number})')]]
    Focus    xpath=//div[@id='tab1']//a[text()[contains(., 'Descriptive name of the file (SR #${SR_Number})')]]

The user set text '${value}' to field 'Add Note to Service Request'
    Focus    ${SRNote_field}
    JS Set Value To Input    ${SRNote_field}    ${value}

The user clicks button 'Add Note'
    Scroll To Element    ${dsg_SR_AddNote_button}
    Focus    ${dsg_SR_AddNote_button}
    Click Element    ${dsg_SR_AddNote_button}

The note is added
    Wait Until Page Contains Element    ${note-modal}[@aria-hidden='true']

The user sees added note '${value}'
    Scroll To Element    ${dsg_SRDetail_RequestHistory_tag}
    Focus    ${dsg_SRDetail_RequestHistory_tag}
    Click Element    ${dsg_SRDetail_RequestHistory_tag}
    Wait Until Page Contains Element    ${dsg_ProductSwap_ExpandAll_button}
    Scroll To Element    ${dsg_ProductSwap_ExpandAll_button}
    Focus    ${dsg_ProductSwap_ExpandAll_button}
    Click Element    ${dsg_ProductSwap_ExpandAll_button}
    Wait Until Page Contains Element    ${RequestHistory_table}/tbody/tr[@class='expand even']/td[text()[contains(., '${value}')]]
    Highlight Element    ${RequestHistory_table}/tbody/tr[@class='expand even']/td[text()[contains(., '${value}')]]
    sleep    2
