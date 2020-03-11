*** Settings ***
Library           Selenium2Library
Library           HttpLibrary.HTTP
Resource          Commons.robot
Resource          Locators/ServiceRequest_Page_Locators.robot

*** Keywords ***
Active page should be Submit a Service Request
    Wait Until Page Contains Element    ${dsg_SR_SubmitSR_Title_locator}
    sleep    2
    Location Should Contain    /create-service-request
    Current Page Should Not Contain Errors

Active page should be Service Request Submitted Confirmation
    Wait Until Page Contains Element    ${dsg_CreateSR_SRConfirmation_locator}

Active page should be Service Request Details
    Wait Until Page Contains Element    ${dsg_SRDetail_ServiceRequest#_Title_locator}

Active page should be No Assigned License Number for Account Selected
    Wait Until Page Contains Element    ${dsg_SR_TrialAltAcctMsgTitle_locator}

Active page should be My Service Request
    Wait Until Page Contains Element    ${dsg_SearchSR_MySR_Title_locator}
    Location Should Contain    /search-service-request
    Current Page Should Not Contain Errors

Active page should be Support for Trial User
    Wait Until Page Contains Element    ${Entitlement_CreateSR_TrialUser_Title_locator}

Active page should be Update Service Request
    Wait Until Page Contains Element    ${dsg_SR_UpdateSR_locator}

Active page should be Add Service Request Note
    Wait Until Page Contains Element    ${dsg_SRDetail_AddSRNote_locator}

Modal window should be Expired Maintenance
    Comment    Wait Until Page Contains Element    ${Entitlement_ExpiredMaintenance_Title_locator}
    Comment    Wait Until Page Contains Element    ${Entitlement_ExpiredMaintenance_HardFail_Mesg_locator}
    Wait Until Page Contains Element    ${Entitlement_CreateSR_HardFailContract_Title_locator}
    Wait Until Page Contains Element    ${Entitlement_CreateSR_ExpiredMaintenance_HardFail_Mesg_locator}

Modal window should be Expired Maintenance Soft Fail
    Wait Until Page Contains Element    ${Entitlement_CreateSR_SoftFailContract_Title_locator}
    Comment    Wait Until Page Contains Element    ${Entitlement_ExpiredMaintenance_HardFail_Mesg_locator}
