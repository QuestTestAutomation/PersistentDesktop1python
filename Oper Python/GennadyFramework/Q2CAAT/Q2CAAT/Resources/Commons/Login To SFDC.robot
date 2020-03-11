*** Setting ***
Library    Collections
Library    SeleniumLibrary
Resource    Variables.robot

*** Keyword ***
Login To SFDC sandbox as UAT account
    Set Selenium Timeout    ${MAX_WAIT_TIME} 
    Log    &{SF_USER}[email]
	Open Test SFDC site using '${ENVIRONMENT}' environment
	Wait Until Page Contains Element    id:Login
	Input Text    id:username    &{SF_USER}[email]
	Input Password    id:password    &{SF_USER}[password]
	Click Element    id:Login
	Verify Your Identity
	Wait Until Page Contains Element    //button[@data-aura-class="uiButton forceHeaderButton oneUserProfileCardTrigger"]
	sleep    3
	#Wait Until Element Contains    id:userNavLabel    &{SF_USER}[display_name]
	
Verify Your Identity
    ${h2_count}=    Get Element Count    //h2
    Return From Keyword If    '${h2_count}' == '0'    No verification needed    
    ${verify}=    Get Text    //h2
    Return From Keyword If    '${verify}' != 'Verify Your Identity'    ${verify}
    Input Text    id:emc    ${VERIFICATION_CODE}
    Click Element    id:save


Open Test SFDC site using '${env}' environment
    Run Keyword If    '${env}'=='Local'    Open Test SFDC Site On Local Environment
    Run Keyword If    '${env}'=='Remote'    Open Test SFDC Site On Remote Environment    

Open Test SFDC Site On Local Environment
    Open Browser    url=${BASE_URL}    browser=${BROWSER}
    
Open Test SFDC Site On Remote Environment
    ${REMOTE_URL}    Set Variable    http://sso-quest-Gennady.Borodin:8d553dcb-3305-4247-b2c5-0acc04d8b376@ondemand.saucelabs.com:80/wd/hub
    &{DESIRED_CAPABILITIES}=    Create Dictionary
    Set To Dictionary    ${DESIRED_CAPABILITIES}    browserName=${BROWSER}
    Set To Dictionary    ${DESIRED_CAPABILITIES}    platform=Windows 10
    Set To Dictionary    ${DESIRED_CAPABILITIES}    name=${TEST_NAME}
    Set To Dictionary    ${DESIRED_CAPABILITIES}    build=QTC Automated Suite
    #Set To Dictionary    &{DESIRED_CAPABILITIES}    browserName=${BROWSER}
    #${DESIRED_CAPABILITIES}=    Set Variable    browserName:${BROWSER},platform:Windows 8.1, acceptSslCerts:True,chromeOptions.excludeSwitches:disable-popup-blocking,name:${TEST_NAME},build:${BUILD_NAME}
    Open Browser    ${BASE_URL}    ${BROWSER}    remote_url=${REMOTE_URL}    desired_capabilities=${DESIRED_CAPABILITIES}
    log    ${ENVIRONMENT}
