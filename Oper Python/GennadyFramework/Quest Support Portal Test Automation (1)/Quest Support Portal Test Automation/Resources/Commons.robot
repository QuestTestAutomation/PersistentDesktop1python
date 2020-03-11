*** Settings ***
Library           Selenium2Library
Library           HttpLibrary.HTTP
Library           String
Library           DateTime
Library           Collections
Resource          Locators/Main_Page_Locators.robot
Library           DatabaseLibrary
Library           Libs/mixUtils.py
Library           Libs/TestRailLibrary.py    https://gtestbtest01.testrail.io    gtestbtest01@gmail.com    SwMh7YAiB7u4OB5RKVrY-Y8GPA7IatidpY3/EAjmZ
Library           Libs/TestExecutionListener.py
Variables         SupportTranslations/TranslationVarsDB.py    ${SUPPORT_STAGE2_DB_CONNECTION_STRING}    ${LOCALE}    ${MULTIBRANDING_SITE}

*** Variables ***
${BROWSER}        Samsung_GalaxyS6    # iPadAir_2, Samsung_GalaxyS6, iPhone_6, FireFox, Chrome
${SUPPORT_STAGE2_SITE}    https://stage-support.quest.com
${DESIRED_CAPABILITIES}    browser:chrome,browser_version:51.0,os:Windows,os_version:7,resolution:1024x768,acceptSslCerts:True,project:Support,chromeOptions.excludeSwitches:disable-popup-blocking
${REMOTE_URL}     http://timofeivasiliev1:KqzGvsAKwop89WD7dp4d@hub.browserstack.com:80/wd/hub
${LOCALE}         en-us
${TEST_PRODUCT}    Toad for Oracle
${TEST_PRODUCT_VERSION}    12.9
${SUPPORT_STAGE2_DB_CONNECTION_STRING}    "Driver={SQL Server};Server=stage-support-wwwdb2014.prod.quest.corp;Database=Stage_Support;Uid=IUSR_Tridion_Support_Solutions;Pwd=#Tridion2;"
${MULTIBRANDING_SITE}    QST
&{VALID_DSG_ACCOUNT}    email=Yosemite.Sam@software.dell.com    password=Y0s3m1t3S8m    FirstName=Yosemite
&{VALID_QUEST_ACCOUNT}    email=Mickey.Mouse@quest.com    password=M1ckeyM0us3    FirstName=Yosemite    LastName=Sam
&{EXTERNAL_ACCOUNT_TEMP}    email=yaseen.ma@gmail.com    password=quest123    FirstName=Yaseen    LastName=Mo
&{EXTERNAL_ACCOUNT}    email=quest123.qa@gmail.com    password=quest123    FirstName=quest123    LastName=qa
${RE_BASE_MAIL_ADDRESS}    supportadmin@quest.com    # regExp of base mailAddress
${RE_ADDITIONAL_MAIL_ADDRESS}    email2dbuat[0-9]@quest.com    # regExp of additional mailAddress
${TIMS_Only_LicenseNumber}    126-233-405    # 113-378-439; 113-853-426; 114-588-911
${HARD_FAIL}      SQL Navigator for Oracle
${SOFT_FAIL}      vRanger
${SOFT_FAIL_version}    7.5
${HARD_FAIL_version}    7.2
&{PARTNER_ACCOUNT}    email=spp.testaccount@yahoo.com    password=quest123
${BUILD_NAME}     local_run
${EMAIL_SYSTEM}    GuerrillaMail    # GuerrillaMail, TempMail
${TESTRAIL_PROJECT}    P1
${TESTRAIL_PLAN}    Regression
${TESTRAIL_RUN}     Test Run - 17
${BUILD_URL}     http://spb8456:8888/job/TestRail%20Integration%20Pilot%20Project/Browser=IE,Culture=es-es/13/


*** Keywords ***
Open Support Portal Anonimously
    Open SauceLab Session
    Comment    Open BrowserStack Session
    Current Page Should Not Contain Errors
    Comment    Wait Until Page Contains Element    ${dsg_Home_pageTitle_locator}
    Comment    Element Text Should Be    ${dsg_Home_pageTitle_locator}    ${dsg_Home_pageTitle}
    Page Should Contain Element    id=SignInLink
    Page Should Not Contain Element    id=SignOutLink
    ${location}=    Set Variable    ${SUPPORT_STAGE2_SITE}
    ${location}=    Replace String    ${location}    http    ${EMPTY}
    Location Should Contain    ${location}
    Run Keyword If    '${LOCALE}'!='en-us'    Location Should Contain    ${LOCALE}

Close Working Session
    Close Browser
    ${tcase_id}=    Extract CaseID From Robot Tags    ${TEST TAGS}
    log    ${tcase_id}
    log    ${TESTRAIL_PROJECT}
    log    ${TESTRAIL_RUN}
    log    ${BROWSER}
    &{test_info}=    Return Test Info    ${TEST NAME}
    Log    ${test_info}
    #${elapsed}=    Convert Time    ${test_results.elapsedtime}    verbose
    ${logURL}=    Catenate    SEPARATOR=    ${BUILD_URL}    robot/report/log.html#    ${test_info.id}
    ${comment}=    Pretty Print Test Comment    Error Message=${TEST MESSAGE}    Tags=${test_info.tags}    Execution Log=${logURL}    Full Path=${test_info.longname}	
    #Run Keyword If    ${tcase_id} != 0     Add Result To TestRail Case Run Config    ${TESTRAIL_PROJECT}    ${TESTRAIL_PLAN}    ${TESTRAIL_RUN}    ${BROWSER}, ${LOCALE}    ${tcase_id}    ${TEST STATUS}    comment=${comment}
    

Global Setup
    Set Global Variable    ${BROWSER}
    Set Global Variable    ${DESIRED_CAPABILITIES}
    Set Global Variable    ${SUPPORT_STAGE2_SITE}
    Use the Following Mail System    ${EMAIL_SYSTEM}

Scroll To Element
    [Arguments]    ${element_xpath_locator}
    ${element_xpath_locator}=    Replace String    ${element_xpath_locator}    "    '
    ${element_xpath_locator}=    Replace String    ${element_xpath_locator}    xpath=    ${EMPTY}
    Execute Javascript    window.document.evaluate("${element_xpath_locator}", document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue.scrollIntoView(true);

Open BrowserStack Session
    ${DESIRED_CAPABILITIES}=    Set Variable    browser:${BROWSER},os:Windows,os_version:8.1,acceptSslCerts:True,project:Support,chromeOptions.excludeSwitches:disable-popup-blocking,name:${TEST_NAME}
    ${DESIRED_CAPABILITIES}=    Set Variable If    '${BROWSER}'=='iPhone_6'    browserName:iPhone, platform:MAC, device:iPhone 6,name:${TEST_NAME}    ${DESIRED_CAPABILITIES}
    ${DESIRED_CAPABILITIES}=    Set Variable If    '${BROWSER}'=='iPadAir_2'    browserName:iPad, platform:MAC, device:iPad Air 2,name:${TEST_NAME}    ${DESIRED_CAPABILITIES}
    ${DESIRED_CAPABILITIES}=    Set Variable If    '${BROWSER}'=='Samsung_GalaxyS6'    browserName:Chrome, platformName:Android, platformVersion:7.1, deviceName:Samsung Galaxy S7 Edge HD GoogleAPI Emulator, name:${TEST_NAME}    ${DESIRED_CAPABILITIES}
    ${SUPPORT_STAGE2_SITE}=    Set Variable if    '${LOCALE}'=='en-us'    ${SUPPORT_STAGE2_SITE}    ${SUPPORT_STAGE2_SITE}/${LOCALE}/
    ${BROWSER}=    Set Variable If    '${BROWSER}'=='iPhone_6'    iphone    ${BROWSER}
    ${BROWSER}=    Set Variable If    '${BROWSER}'=='iPadAir_2'    safari    ${BROWSER}
    ${BROWSER}=    Set Variable If    '${BROWSER}'=='Samsung_GalaxyS6'    android    ${BROWSER}
    Set Selenium Timeout    180
    Open Browser    ${SUPPORT_STAGE2_SITE}    ${BROWSER}    remote_url=${REMOTE_URL}    desired_capabilities=${DESIRED_CAPABILITIES}
    Comment    Open Browser    ${SUPPORT_STAGE2_SITE}    ${BROWSER}

Select Product in Product Search element
    [Arguments]    ${product_name}
    Page Should Contain Element    id=productAutoComplete
    Comment    Scroll To Element    id=productAutoComplete
    Comment    Highlight Element    id=productAutoComplete
    Input Text    id=productAutoComplete    ${product_name}
    Wait Until Element Is Visible    id=TypeAheadResults
    Page Should Contain Element    xpath=//div[@id="TypeAheadResults"]//li//a[@data-product="${product_name}"]
    Scroll To Element    //div[@id="TypeAheadResults"]//li//a[@data-product="${product_name}"]
    Click Element    xpath=//div[@id="TypeAheadResults"]//li//a[@data-product="${product_name}"]

Select version '${version}'
    ${version_label}=    Get Text    ${at_version_selector}/option[@data-filtervalue='${version}']
    JS Select Item of DropDown List    ${at_version_selector}    ${version_label}

Should be selected the latest version
    Page Should Contain Element    xpath=//select[@id="verName"]
    Element Should Contain    xpath=//select[@id="verName"]//option[@selected="selected"]    ${dsg_Search_Latest_Version}

Highlight Element
    [Arguments]    ${element_xpath_locator}
    ${element_xpath_locator}=    Replace String    ${element_xpath_locator}    "    '
    ${element_xpath_locator}=    Replace String    ${element_xpath_locator}    xpath=    ${EMPTY}
    Execute Javascript    window.document.evaluate("${element_xpath_locator}", document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue.style.border="solid pink";

Get Product By Name
    [Arguments]    ${product_name}
    Connect To Database Using Custom Params    pyodbc    ${SUPPORT_STAGE2_DB_CONNECTION_STRING}
    @{product_dataset}=    Query    SELECT TOP 1 [ProductID],[ProductName] ,[ProductType] ,[Brand] ,[IntegrationType] ,[Status] ,[IsLicensed] ,[IsCommercial] ,[EndecaID] ,[LatestVersionID] ,[AfterHoursMessage] ,[LastUpdate] ,[IsEOL] ,[IsAppliance] ,[SupportProductType] ,[PlcText] ,[IsDeleted] ,[NotInTIMS] ,[PremiumKB] \ FROM [STAGE_Support].[dbo].[Product] \ where [ProductName] = '${product_name}'
    ${prod_len}=    Get Length    ${product_dataset}
    Return From Keyword If    '${prod_len}'=='0'    ${EMPTY}
    &{product}=    Create Dictionary    ProductID=${product_dataset[0][0]}
    Set To Dictionary    ${product}    ProductName=${product_dataset[0][1]}
    Set To Dictionary    ${product}    ProductType=${product_dataset[0][2]}
    Set To Dictionary    ${product}    Brand=${product_dataset[0][3]}
    Set To Dictionary    ${product}    IntegrationType=${product_dataset[0][4]}
    Set To Dictionary    ${product}    Status=${product_dataset[0][5]}
    Set To Dictionary    ${product}    IsLicensed=${product_dataset[0][6]}
    Set To Dictionary    ${product}    IsCommercial=${product_dataset[0][7]}
    Set To Dictionary    ${product}    EndecaID=${product_dataset[0][8]}
    Set To Dictionary    ${product}    LatestVersionID=${product_dataset[0][9]}
    Set To Dictionary    ${product}    AfterHoursMessage=${product_dataset[0][10]}
    Set To Dictionary    ${product}    LastUpdate=${product_dataset[0][11]}
    Set To Dictionary    ${product}    IsEOL=${product_dataset[0][12]}
    Set To Dictionary    ${product}    IsAppliance=${product_dataset[0][13]}
    Set To Dictionary    ${product}    SupportProductType=${product_dataset[0][14]}
    Set To Dictionary    ${product}    PlcText=${product_dataset[0][15]}
    Set To Dictionary    ${product}    IsDeleted=${product_dataset[0][16]}
    Set To Dictionary    ${product}    NotInTIMS=${product_dataset[0][17]}
    Set To Dictionary    ${product}    PremiumKB=${product_dataset[0][18]}
    [Return]    &{product}

Get Version By Product and Version Name
    [Arguments]    ${product_name}    ${version_name}
    Connect To Database Using Custom Params    pyodbc    ${SUPPORT_STAGE2_DB_CONNECTION_STRING}
    @{version_dataset}=    Query    SELECT TOP 1 v.[VersionID] ,v.[VersionName] ,v.[ProductID] ,v.[Status] ,v.[IsLicensed] ,v.[IsCommercial] ,v.[IsSearchable] ,v.[DisplayOrder] ,v.[EndecaID] ,v.[SupportStartDate] ,v.[SupportEndDate] ,v.[LimitedSupportDate] ,v.[PLCFlag] ,v.[PLCOrder] ,v.[LastUpdate] ,v.[LastDayOrderDate] ,v.[ArmEndDate] ,v.[OneYearLdoDate] ,v.[LrmEndDate] ,v.[VersionType] ,v.[NotificationURL] ,v.[Country] ,v.[IsDeleted] \ FROM [STAGE_Support].[dbo].[ProductVersion] v \ inner join [dbo].[Product] p on v.[ProductID] = p.[ProductID] \ Where v.[VersionName] = '${version_name}' and p.[ProductName] = '${product_name}'
    ${version_len}=    Get Length    ${version_dataset}
    Return From Keyword If    '${version_len}'=='0'    ${EMPTY}
    &{version}=    Create Dictionary    VersionID=${version_dataset[0][0]}
    Set To Dictionary    ${version}    VersionName=${version_dataset[0][1]}
    Set To Dictionary    ${version}    ProductID=${version_dataset[0][2]}
    Set To Dictionary    ${version}    Status=${version_dataset[0][3]}
    Set To Dictionary    ${version}    IsLicensed=${version_dataset[0][4]}
    Set To Dictionary    ${version}    IsCommercial=${version_dataset[0][5]}
    Set To Dictionary    ${version}    IsSearchable=${version_dataset[0][6]}
    Set To Dictionary    ${version}    DisplayOrder=${version_dataset[0][7]}
    Set To Dictionary    ${version}    EndecaID=${version_dataset[0][8]}
    Set To Dictionary    ${version}    SupportStartDate=${version_dataset[0][9]}
    Set To Dictionary    ${version}    SupportEndDate=${version_dataset[0][10]}
    Set To Dictionary    ${version}    LimitedSupportDate=${version_dataset[0][11]}
    Set To Dictionary    ${version}    PLCFlag=${version_dataset[0][12]}
    Set To Dictionary    ${version}    PLCOrder=${version_dataset[0][13]}
    Set To Dictionary    ${version}    LastUpdate=${version_dataset[0][14]}
    Set To Dictionary    ${version}    LastDayOrderDate=${version_dataset[0][15]}
    Set To Dictionary    ${version}    ArmEndDate=${version_dataset[0][16]}
    Set To Dictionary    ${version}    OneYearLdoDate=${version_dataset[0][17]}
    Set To Dictionary    ${version}    LrmEndDate=${version_dataset[0][18]}
    [Return]    &{version}

Get List Video By Product, Version and Category
    [Arguments]    ${product_name}    ${version_name}    ${category}=All    ${locale}=en-US
    ${conn}=    Replace String    ${SUPPORT_STAGE2_DB_CONNECTION_STRING}    "    ${EMPTY}
    ${fieldsDict} =    Create Dictionary    Brightcove=${2}    VideoText=${1}
    ${query}=    Set Variable    declare @product varchar(8000), @version nvarchar(4000), @locale nvarchar(4000), @tabAct nvarchar(4000) select @product='${product_name}', @version='${version_name}', @locale='${locale}', @tabAct='${category}' select DISTINCT VideoID, VideoText, BrightcoveVideoID, Locale, v.KBArticleID, case when DisplayOrder is null then 999 else DisplayOrder end as DisplayOrder from ProductVideosView v left join (SELECT DISTINCT KBArticleID, TabActionId FROM KBArticleTopics kb INNER JOIN TabActionKBTopicMapping t ON kb.TopicName = t.Topic ) AS tab ON v.KBArticleID = tab.KBArticleID where ltrim(rtrim(IsNull(ProductName, ''))) = ltrim(rtrim(IsNull(@product, ''))) and ( ltrim(rtrim(IsNull(@version, '')))='' or ltrim(rtrim(VersionName))=ltrim(rtrim(@version)) ) AND (KbIsExternal = 'Y') AND (KbType = 'Solution') AND (KbStatus IN ('Published','QuickShare')) AND Locale in ('en-US', @locale) AND (ltrim(rtrim(IsNull(@tabAct, 'All'))) = 'All' \ or TabActionId in (select TabActionId from TabAction where ltrim(rtrim(Name)) = ltrim(rtrim(@tabAct))) ) order by 6
    ${jsonVideo}=    Query Result To Json    ${conn}    ${query}    ${fieldsDict}
    ${jsonVideo}=    Parse Json    ${jsonVideo}
    log many    ${jsonVideo}
    [Return]    ${jsonVideo}

Skip the rest of the test case for the following configurations
    [Arguments]    @{configurations}
    ${config_index}=    Get Index From List    ${configurations}    ${BROWSER}
    ${output}=    Convert To String    ${configurations}
    ${output}=    Replace String    ${output}    u'    '
    ${output}=    Remove String    ${output}    [    ]
    Pass Execution If    '${config_index}'!='-1'    Test can not be exectued for the following configs: ${output}

Current Page Should Not Contain Errors
    sleep    3
    Wait Until Element is Visible    xpath=//*[@id='LayoutH1']
    ${current_location}=    Get Location
    ${is_error}=    Get Matching Xpath Count    //*[@id='LayoutH1']/text()[contains(., 'Error On Page')]
    Run Keyword IF    ${is_error}!=0    Fail    The page '${current_location}' falls with error

Scroll To Element of List
    [Arguments]    ${xpath_list}    ${itemText}
    ${xpath_list}=    Replace String    ${xpath_list}    "    '
    ${xpath_list}=    Replace String    ${xpath_list}    xpath=    ${EMPTY}
    ${scrollHeight}=    Execute Javascript    return window.document.evaluate("${xpath_list}", document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue.scrollHeight;
    ${countItems}=    Get Matching Xpath Count    ${xpath_list}//li/a
    ${numItem}=    Execute Javascript    return window.document.evaluate("count(${xpath_list}//li[./a[text()='${itemText}']]/preceding-sibling::*)", document, null, XPathResult.NUMBER_TYPE, null).numberValue;
    ${position}=    Run Keyword IF    ${countItems}>0    Evaluate    int(${scrollHeight}/${countItems}.*${numItem})
    ...    ELSE    Set Variable    ${0}
    Execute Javascript    window.document.evaluate("${xpath_list}", document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue.scrollTop=${position};
    Comment
    Comment    window.document.evaluate("count(//div/select[@id='Product']/option[text()='Adamo']/preceding-sibling::*)", document, null, XPathResult.NUMBER_TYPE, null).numberValue

Close Popup
    [Arguments]    ${xpath_button_close}
    ${match_element}=    Prepare Locator To JS    ${xpath_button_close}
    ${count}=    Get Matching Xpath Count    ${match_element}
    Run Keyword If    ${count}>0    Focus    ${xpath_button_close}
    Run Keyword If    ${count}>0    Click Element    ${xpath_button_close}
    Comment    Run Keyword If    ${count}>0    Simulate    ${xpath_button_close}    click
    Comment    Run Keyword If    ${count}>0    Simulate    ${xpath_button_close}    mousedown
    Comment    Run Keyword If    ${count}>0    Simulate    ${xpath_button_close}    mouseup

JS Select Item of DropDown List
    [Arguments]    ${list_locator}    ${search_value}
    [Documentation]    Keyword for WebElement represent by tag 'select'
    Scroll To Element    ${list_locator}
    Focus    ${list_locator}
    Comment    Click Element    ${list_locator}
    ${locator}=    Prepare Locator To JS    ${list_locator}
    ${existsItem}=    Get Matching Xpath Count    ${locator}/option[text()[normalize-space()='${search_value}'] and not(@style='display: none;')]
    Run Keyword IF    ${existsItem}==0    Click Element    ${list_locator}
    Run Keyword IF    ${existsItem}==0    Capture Page Screenshot
    Run Keyword IF    ${existsItem}==0    FAIL    Selector does not contain ${search_value}
    ${numItem}=    Execute Javascript    return window.document.evaluate("count(${locator}/option[text()[normalize-space()='${search_value}']]/preceding-sibling::*)", document, null, XPathResult.NUMBER_TYPE, null).numberValue;
    Execute Javascript    window.document.evaluate("${locator}", document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue.selectedIndex=${numItem};
    Simulate    ${list_locator}    onselect
    Simulate    ${list_locator}    change
    sleep    2

Check Captcha
    [Arguments]    ${xpath_frame}
    Select Frame    ${xpath_frame}
    Wait Until Page Contains Element    id=recaptcha-anchor
    Click Element    id=recaptcha-anchor
    sleep    3
    Unselect Frame

JS Set Value To Input
    [Arguments]    ${input_locator}    ${value}
    [Documentation]    Keyword for WebElement represent by tag 'select'
    Scroll To Element    ${input_locator}
    Focus    ${input_locator}
    Comment    Click Element    ${input_locator}
    ${locator}=    Prepare Locator To JS    ${input_locator}
    Execute Javascript    window.document.evaluate("${locator}", document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue.value='${value}';
    Simulate    ${input_locator}    change
    Simulate    ${input_locator}    keyup
    sleep    1

Page Should Not Be Found
    [Arguments]    ${location}
    Go To    ${location}
    Wait Until Element is Visible    xpath=//*[@id='LayoutH1']
    Element Should Contain    xpath=//*[@id='LayoutH1']    ${dsg_404_Title}    Expected 'Page not Found' redirect. Actually ${location} is accessible

Close Chat
    [Arguments]    ${xpath_button_close}
    Return From Keyword IF    "${BROWSER}" in ("iPhone_6", "iPadAir_2", "Samsung_GalaxyS6")
    ${match_element}=    Prepare Locator To JS    ${xpath_button_close}
    ${count}=    Get Matching Xpath Count    ${match_element}
    Run Keyword If    ${count}>0    Focus    ${xpath_button_close}
    Run Keyword If    ${count}>0    Click Element    ${xpath_button_close}

An anonymous user on the main page of Support Portal
    Open Support Portal Anonimously

JS Get Value from List by Index
    [Arguments]    ${list_locator}    ${num}
    [Documentation]    Keyword for WebElement represent by tag 'select'
    ${locator}=    Replace String    ${list_locator}    "    '
    ${locator}=    Replace String    ${locator}    xpath=    ${EMPTY}
    ${existsItem}=    Get Matching Xpath Count    ${locator}//option[${num}]
    Comment    Run Keyword IF    ${existsItem}==0    FAIL    Selector does not contain element #${num}
    ${result}=    Run Keyword IF    ${existsItem}!=0    Execute Javascript    return window.document.evaluate("${locator}//option[${num}]/text()", document, null, XPathResult.STRING_TYPE, null).stringValue;
    ...    ELSE    Set Variable    ${EMPTY}
    [Return]    ${result}

Prepare Locator To JS
    [Arguments]    ${locator}
    ${result}=    Replace String    ${locator}    "    '
    ${result}=    Replace String    ${result}    xpath=    ${EMPTY}
    log many    ${result}
    [Return]    ${result}

Open SauceLab Session
    Comment    ${REMOTE_URL}    Set Variable    http://sso-quest-Tamara.Homchik:25cbd4e9-1a43-4fbd-9fff-9ae28aed7694@ondemand.saucelabs.com:80/wd/hub
    ${REMOTE_URL}    Set Variable    http://sso-quest-Gennady.Borodin:8d553dcb-3305-4247-b2c5-0acc04d8b376@ondemand.saucelabs.com:80/wd/hub
    &{dc_smsg6_dict}=    Create Dictionary
    Set To Dictionary    ${dc_smsg6_dict}    deviceName=Samsung Galaxy S9 WQHD GoogleAPI Emulator
    Set To Dictionary    ${dc_smsg6_dict}    browserName=Chrome
    Set To Dictionary    ${dc_smsg6_dict}    platformVersion=7.1
    Set To Dictionary    ${dc_smsg6_dict}    platformName=Android
    Set To Dictionary    ${dc_smsg6_dict}    name=${TEST_NAME}
    Set To Dictionary    ${dc_smsg6_dict}    build=${BUILD_NAME}
    &{dc_ip10_dict}=    Create Dictionary
    Set To Dictionary    ${dc_ip10_dict}    deviceName=iPhone X Simulator
    Set To Dictionary    ${dc_ip10_dict}    browserName=Safari
    Set To Dictionary    ${dc_ip10_dict}    platformName=iOS
    Set To Dictionary    ${dc_ip10_dict}    platformVersion=11.3
    Set To Dictionary    ${dc_ip10_dict}    name=${TEST_NAME}
    Set To Dictionary    ${dc_ip10_dict}    build=${BUILD_NAME}
        
    Comment    ${DESIRED_CAPABILITIES}=    Set Variable    browser:${BROWSER},os:Windows,os_version:8.1,acceptSslCerts:True,project:Support,chromeOptions.excludeSwitches:disable-popup-blocking,name:${TEST_NAME}
    ${BROWSER}=    Set Variable If    '${BROWSER}'=='IE'    internet explorer    ${BROWSER}
    ${DESIRED_CAPABILITIES}=    Set Variable    browserName:${BROWSER},platform:Windows 8.1, acceptSslCerts:True,chromeOptions.excludeSwitches:disable-popup-blocking,name:${TEST_NAME},build:${BUILD_NAME}
    ${DESIRED_CAPABILITIES}=    Set Variable If    '${BROWSER}'=='iPhone_6'    ${dc_ip10_dict}    ${DESIRED_CAPABILITIES}
    ${DESIRED_CAPABILITIES}=    Set Variable If    '${BROWSER}'=='iPadAir_2'    browserName:iPad, platform:MAC, device:iPad Air 2,name:${TEST_NAME},build:${BUILD_NAME}    ${DESIRED_CAPABILITIES}
    ${DESIRED_CAPABILITIES}=    Set Variable If    '${BROWSER}'=='Samsung_GalaxyS6'    ${dc_smsg6_dict}    ${DESIRED_CAPABILITIES}
    ${SUPPORT_STAGE2_SITE}=    Set Variable if    '${LOCALE}'=='en-us'    ${SUPPORT_STAGE2_SITE}    ${SUPPORT_STAGE2_SITE}/${LOCALE}/
    ${BROWSER}=    Set Variable If    '${BROWSER}'=='iPhone_6'    iphone    ${BROWSER}
    ${BROWSER}=    Set Variable If    '${BROWSER}'=='iPadAir_2'    safari    ${BROWSER}
    ${BROWSER}=    Set Variable If    '${BROWSER}'=='Samsung_GalaxyS6'    Android    ${BROWSER}
    Set Selenium Timeout    180
    Open Browser    ${SUPPORT_STAGE2_SITE}    ${BROWSER}    remote_url=${REMOTE_URL}    desired_capabilities=${DESIRED_CAPABILITIES}

Item Is Checked
    [Arguments]    ${locator}    ${name_attribute}=${EMPTY}    # ${name_attribute}: if need return value of attribute
    ${locator}=    Prepare Locator To JS    ${locator}
    ${existsItem}=    Get Matching Xpath Count    ${locator}
    Run Keyword IF    ${existsItem}==0    FAIL    Page does not contain element ${locator}
    ${result}=    Execute Javascript    return window.document.evaluate("${locator}", document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue.checked
    ${existsAttribute}=    Run Keyword IF    '${name_attribute}'!='${EMPTY}'    Get Matching Xpath Count    ${locator}[@${name_attribute}]
    ${value_attribute}=    Run Keyword IF    ${existsAttribute}==1    Execute Javascript    return window.document.evaluate("${locator}", document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue.${name_attribute}
    [Return]    ${result}    ${value_attribute}

Close TermsConditionsModal
    sleep    2
    ${locator}=    Prepare Locator To JS    ${terms-conditions-modal}[@aria-hidden='false']
    ${show_modal}=    Get Matching Xpath Count    ${locator}
    ${isCheck}    ${temp}=    Run Keyword IF    ${show_modal}!=0    Item Is Checked    ${terms-conditions-modal_checkbox}
    ...    ELSE    Set Variable    ${False}    ${EMPTY}
    Run Keyword IF    ${show_modal}!=0 and "${isCheck}"=="${False}"    Click Element    ${terms-conditions-modal_checkbox}
    Run Keyword IF    ${show_modal}!=0    Click Element    ${terms-conditions-modal_continueButton}
    Run Keyword IF    ${show_modal}!=0    Wait Until Page Does not Contain Element    ${terms-conditions-modal}[@aria-hidden='false']

JS Get Value From Input
    [Arguments]    ${input_locator}
    [Documentation]    Keyword for WebElement represent by tag 'input'
    Wait Until Element Is Visible    ${input_locator}
    Scroll To Element    ${input_locator}
    ${locator}=    Prepare Locator To JS    ${input_locator}
    ${result}=    Execute Javascript    return window.document.evaluate("${locator}", document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue.value;
    [Return]    ${result}

JS Get Value From Select
    [Arguments]    ${select_locator}
    [Documentation]    Keyword for WebElement represent by tag 'select'
    Wait Until Element Is Visible    ${select_locator}
    Scroll To Element    ${select_locator}
    ${locator}=    Prepare Locator To JS    ${select_locator}
    ${result}=    Execute Javascript    return window.document.evaluate("${locator}//option[@selected]/text()", document, null, XPathResult.STRING_TYPE, null).stringValue;
    [Return]    ${result}

Get Product Properties By Name
    [Arguments]    ${product_name}
    ${conn}=    Replace String    ${SUPPORT_STAGE2_DB_CONNECTION_STRING}    "    ${EMPTY}
    ${fieldsDict} =    Create Dictionary    ProductID=${0}    ProductName=${1}    ProductType=${2}    Brand=${3}    IntegrationType=${4}
    ...    Status=${5}    IsLicensed=${6}    IsCommercial=${7}    EndecaID=${8}    LatestVersionID=${9}    AfterHoursMessage=${10}
    ...    LastUpdate=${11}    IsEOL=${12}    IsAppliance=${13}    SupportProductType=${14}    PlcText=${15}    IsDeleted=${16}
    ...    NotInTIMS=${17}    PremiumKB=${18}    Site=${19}    SrProductType=${20}    PlcProductType=${21}    IsPremiumChat=${22}
    ${query}=    Set Variable    declare @product varchar(8000) select @product='${product_name}' select ProductID, ProductName, ProductType, Brand, IntegrationType, Status, IsLicensed, IsCommercial, EndecaID, LatestVersionID, AfterHoursMessage, LastUpdate, IsEOL, IsAppliance, SupportProductType, PlcText, IsDeleted, NotInTIMS, PremiumKB, Site, SrProductType, PlcProductType, IsPremiumChat from Product where ltrim(rtrim(IsNull(ProductName, ''))) = ltrim(rtrim(IsNull(@product, '')))
    log many    ${query}
    ${jsonProp}=    Query Result To Json    ${conn}    ${query}    ${fieldsDict}    returnList=0
    ${jsonProp}=    Parse Json    ${jsonProp}
    log many    ${jsonProp}
    [Return]    ${jsonProp}

Use the Following Mail System
    [Arguments]    ${MailSystem}
    log    The selected email servcie is '${MailSystem}'
    Run Keyword If    '${MailSystem}' == 'GuerrillaMail'    Import Resource    ${CURDIR}\\GuerrillaMail.robot
    Run Keyword If    '${MailSystem}' == 'TempMail'    Import Resource    ${CURDIR}\\Temp_Mail.robot
