*** Settings ***
Resource          ../Resources/Commons.robot
Resource          ../Resources/SignIn_Page_Resources.robot
Resource          ../ServiceRequest/SuiteServiceRequest_Keywords_Resources.robot

*** Variables ***
${ACTUAL_VARS_DICT}    ${EMPTY}
${EXPECTED_VARS_DICT}    ${EMPTY}

*** Keywords ***
Get Site Catalyst Variables
    [Arguments]    ${sc_var_number}=${null}
    Sleep    5
    ${max_sc_var}=    Get questdsgsupportstage obj
    ${sc_var}=    Set Variable If    ${sc_var_number}!=${null}    s_i_0_questdsgsupportstage_${sc_var_number}    ${max_sc_var}
    ${JS_code}=    Set Variable    return window.${sc_var}.outerHTML
    ${val1}=    Execute Javascript    ${JS_code}
    log    ${val1}
    Convert To String    ${val1}
    ${dct}=    Get SCVarialbles Dict    ${val1}
    [Return]    ${dct}

Expected SiteCatalyst Vars of Submit a Service Request page
    [Arguments]    ${actual_vars}
    ${dict}=    Create Dictionary
    ${day}=    Get Weekday Name
    ${week_part}=    Get Week Part
    ${locale_val}=    Set Variable If    '${LOCALE}' == 'en-us'    en    ${LOCALE}
    Run Keyword If    '${actual_vars['c3']}' in ('alvcwsw01','alvcwsw02')    Set To Dictionary    ${dict}    c3=${actual_vars['c3']}
    Should Match Regexp    ${actual_vars['c17']}    \\d{1,2}:\\d{1,2}[A|P]M    Variable 'c17' does not match time format
    Set To Dictionary    ${dict}    c17=${actual_vars['c17']}
    Set To Dictionary    ${dict}    v18=D=c18
    Set To Dictionary    ${dict}    v12=D=c12
    Set To Dictionary    ${dict}    v10=D=c10
    Set To Dictionary    ${dict}    v17=D=c17
    Set To Dictionary    ${dict}    v8=D=c8
    Set To Dictionary    ${dict}    v19=D=c19
    Set To Dictionary    ${dict}    server=stage-support.quest.com
    Set To Dictionary    ${dict}    c16=United States
    Set To Dictionary    ${dict}    c15=1-7QG2GX
    Set To Dictionary    ${dict}    c19=${week_part}
    Set To Dictionary    ${dict}    c18=${day}
    Set To Dictionary    ${dict}    c12=New
    Set To Dictionary    ${dict}    c10=7eed98d6-9b97-411e-9b73-40dfcf0277e2
    Set To Dictionary    ${dict}    c31=external
    Set To Dictionary    ${dict}    events=event7
    Set To Dictionary    ${dict}    v32=D=c32
    Set To Dictionary    ${dict}    c32=submit-service-request
    Set To Dictionary    ${dict}    v69=stage-support.quest.com
    Set To Dictionary    ${dict}    v61=D=g
    Set To Dictionary    ${dict}    c9=form
    Set To Dictionary    ${dict}    v4=${locale_val}
    Set To Dictionary    ${dict}    c1=N
    Set To Dictionary    ${dict}    c4=${locale_val}
    Set To Dictionary    ${dict}    c69=stage-support.quest.com
    Set To Dictionary    ${dict}    c61=D=g
    [Return]    ${dict}

Logged in User '${user}' with pass '${password}'
    Open Support Portal Anonimously
    The user navigates to SignIn page and logs in    ${user}    ${password}
    The user is logged

Go to Submit a Service Request page
    ${url}=    Get Location
    go to    ${url}/create-service-request
    Sleep    5

Prepare Actual Site Catalyst Variables List For '${PageType}'
    ${sc}=    Set Variable If    '${PageType}' == 'Service Request Page'    4    ${null}
    ${variables}=    Get Site Catalyst Variables    ${sc}
    keep in dictionary if key matches    ${variables}    ^c\\d{1,}    ^v\\d{1,}    event*    server
    Set Test Variable    ${ACTUAL_VARS_DICT}    ${variables}
    Run Keyword If    '${PageType}' == 'Create SR Page'    Set To Dictionary    ${ACTUAL_VARS_DICT}     v8=D=c8       

Expected And Actual Variables Lists Should Be The Same
    Print Dictionary    ${ACTUAL_VARS_DICT}    Actual variables found on the page
    Print Dictionary    ${EXPECTED_VARS_DICT}    Expected list of variables
    Dictionaries Should Be Equal    ${ACTUAL_VARS_DICT}    ${EXPECTED_VARS_DICT}

Prepare Expected Site Catalyst Variables List
    ${d}=    Expected SiteCatalyst Vars of Submit a Service Request page    ${ACTUAL_VARS_DICT}
    Set Test Variable    ${EXPECTED_VARS_DICT}    ${d}

Get questdsgsupportstage obj
    ${rc}=    Execute Javascript    return s.rc['questdsgsupportstage']
    ${rc}=    Convert To Integer    ${rc}
    Run Keyword And Return If    ${rc}==1    Return From Keyword    s_i_0_questdsgsupportstage
    ${offset}=    Evaluate    ${rc} - 1
    ${return_obj}=    Set Variable    s_i_0_questdsgsupportstage_${offset}
    [Return]    ${return_obj}

Extend Expected Variables List for Product Service Request Page
    Set To Dictionary    ${EXPECTED_VARS_DICT}    c22=directory-troubleshooter
    Set To Dictionary    ${EXPECTED_VARS_DICT}    v22=D=c22
    Set To Dictionary    ${EXPECTED_VARS_DICT}    c8=Trial
    Comment    Remove From Dictionary    ${EXPECTED_VARS_DICT}    c8
    Comment    Remove From Dictionary    ${EXPECTED_VARS_DICT}    v8    
    Set To Dictionary    ${EXPECTED_VARS_DICT}    c32=submit-sr-entitlement
    Set To Dictionary    ${EXPECTED_VARS_DICT}    c72=directory-troubleshooter:submit-sr-entitlement
    Set To Dictionary    ${EXPECTED_VARS_DICT}    v72=D=c72

User selects Software Version '${version}'
    sleep    1
    JS Select Item of DropDown List    xpath=//select[@id="version"]    ${version}

User types '${text}' in Descriptive Title
    Input Text    xpath=//textarea[@id="srt"]    ${text}

User types '${text}' in Description of the Problem
    Input Text    xpath=//textarea[@id="description"]    ${text}

User types '${text}' in Environment Details
    Input Text    xpath=//textarea[@id="Environment"]    ${text}

User selects '${item}' in Contact me by
    JS Select Item of DropDown List    xpath=//select[@id="ddlContactMeBy"]    ${item}

User fills Describe Service Request Details form
    User selects Software Version '4.14'
    User types 'Descriptive Title test value' in Descriptive Title
    User types 'Description of the Problem test value' in Description of the Problem
    User types 'Environment Details test value' in Environment Details
    User selects '${dsg_CreateSR_ContactByEmail}' in Contact me by

Extend Expected Variables List for Confirm Service Request Page
    Extend Expected Variables List for Product Service Request Page
    Set To Dictionary    ${EXPECTED_VARS_DICT}    c32=submit_sr_next
    Set To Dictionary    ${EXPECTED_VARS_DICT}    c21=SR
    Set To Dictionary    ${EXPECTED_VARS_DICT}    c28=descriptive title test value
    Set To Dictionary    ${EXPECTED_VARS_DICT}    v21=D=c21
    Set To Dictionary    ${EXPECTED_VARS_DICT}    v28=D=c28
    Set To Dictionary    ${EXPECTED_VARS_DICT}    events=event7,event1
    Set To Dictionary    ${EXPECTED_VARS_DICT}    c1=Y
    Set To Dictionary    ${EXPECTED_VARS_DICT}    c72=directory-troubleshooter:submit_sr_next
    Set To Dictionary    ${EXPECTED_VARS_DICT}    v72=D=c72

Extend Expected Variables List for Service Request Page
    Set To Dictionary    ${EXPECTED_VARS_DICT}    c32=submit-sr-confirmed
    Set To Dictionary    ${EXPECTED_VARS_DICT}    c9=form
    Set To Dictionary    ${EXPECTED_VARS_DICT}    c22=directory-troubleshooter
    Set To Dictionary    ${EXPECTED_VARS_DICT}    v22=D=c22
    Set To Dictionary    ${EXPECTED_VARS_DICT}    c8=Trial
    Set To Dictionary    ${EXPECTED_VARS_DICT}    v21=D=c21
    Set To Dictionary    ${EXPECTED_VARS_DICT}    v28=D=c28
    Set To Dictionary    ${EXPECTED_VARS_DICT}    events=event7,event1
    Set To Dictionary    ${EXPECTED_VARS_DICT}    c72=directory-troubleshooter:submit-sr-confirmed
    Set To Dictionary    ${EXPECTED_VARS_DICT}    v72=D=c72

Wait for Submit Service Request Page
    Wait Until Page Contains Element    id=lnkSubmitRequest

Wait for 'Complementary support services for trial users' dialog
    Wait Until Element Is Visible    xpath=//h3[@id="SRModalTitle"]
    sleep    2
    Element Text Should Be    xpath=//h3[@id="SRModalTitle"]    ${Entitlement_CreateSR_TrialUser_Title}
    Comment    Click Element    xpath=//div[@id="divSRModal"]//a[@id="ok-button"]
    Comment    Wait Until Element Is Not Visible    xpath=//div[@class="modal-content"]

The user selects '${value}' in the 'Account ID'
    sleep    2
    Close SRModal
    ${locator}=    Set Variable    //select[@id="ddlAtSite"]
    Wait Until Element Is Enabled    ${locator}
    JS Select Item of DropDown List    ${locator}    ${value}
