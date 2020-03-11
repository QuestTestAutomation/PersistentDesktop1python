*** Settings ***
Library           Selenium2Library
Library           HttpLibrary.HTTP
Resource          Commons.robot
Resource          Locators/Main_Page_Locators.robot

*** Keywords ***
Click menu 'Support'
    ${loc}=    Set Variable IF    '${LOCALE}'=='es-es'    /es    '${LOCALE}'=='ja-jp'    /jp    ${EMPTY}
    ${at_menu_Support}=    Run Keyword IF    '${LOCALE}'=='es-es' or '${LOCALE}'=='ja-jp'    Replace String    ${at_menu_Support}    href= '/    href= '${loc}/
    ...    ELSE    Set Variable    ${at_menu_Support}
    Scroll To Element    ${at_i-ui-menucollapsed}
    Focus    ${at_i-ui-menucollapsed}
    Click Element    ${at_i-ui-menucollapsed}
    Wait Until Element is Visible    ${at_menu_Support}
    Focus    ${at_menu_Support}
    Click Element    ${at_menu_Support}

Click submenu 'My Account'
    ${small}=    Get Matching Xpath Count    //div[@id="SubHeader" and @class="tablet-and-down"]
    ${loc}=    Set Variable IF    '${LOCALE}'=='es-es'    /es-es    '${LOCALE}'=='ja-jp'    /jp    ${EMPTY}
    ${at_menu_Support_MyAccount}=    Run Keyword IF    '${LOCALE}'=='es-es' or '${LOCALE}'=='ja-jp'    Replace String    ${at_menu_Support_MyAccount}    href= '/    href= '${loc}/
    ...    ELSE    Set Variable    ${at_menu_Support_MyAccount}
    Wait Until Element Is Visible    ${at_menu_Support_MyAccount}
    Focus    ${at_menu_Support_MyAccount}
    Run Keyword IF    ${small}!=0    Click Element    ${at_menu_Support_MyAccount}//i

Click submenu 'My Service Requests'
    ${loc}=    Set Variable IF    '${LOCALE}'=='es-es'    /es-es    '${LOCALE}'=='ja-jp'    /jp    ${EMPTY}
    ${at_menu_Support_MyAccount_MyServiceRequest}=    Run Keyword IF    '${LOCALE}'=='es-es' or '${LOCALE}'=='ja-jp'    Replace String    ${at_menu_Support_MyAccount_MyServiceRequest}    href= '/    href= '${loc}/
    ...    ELSE    Set Variable    ${at_menu_Support_MyAccount_MyServiceRequest}
    Wait Until Element Is Visible    ${at_menu_Support_MyAccount_MyServiceRequest}
    Scroll To Element    ${at_menu_Support_MyAccount_MyServiceRequest}
    Focus    ${at_menu_Support_MyAccount_MyServiceRequest}
    Click Element    ${at_menu_Support_MyAccount_MyServiceRequest}/span

Click submenu 'My Products'
    ${loc}=    Set Variable IF    '${LOCALE}'=='es-es'    /es    '${LOCALE}'=='ja-jp'    /jp    ${EMPTY}
    ${at_menu_Support_MyAccount_MyProducts}=    Run Keyword IF    '${LOCALE}'=='es-es' or '${LOCALE}'=='ja-jp'    Replace String    ${at_menu_Support_MyAccount_MyProducts}    href= '/    href= '${loc}/
    ...    ELSE    Set Variable    ${at_menu_Support_MyAccount_MyProducts}
    Wait Until Element Is Visible    ${at_menu_Support_MyAccount_MyProducts}
    Scroll To Element    ${at_menu_Support_MyAccount_MyProducts}
    Focus    ${at_menu_Support_MyAccount_MyProducts}
    Click Element    ${at_menu_Support_MyAccount_MyProducts}/span

Click submenu 'Contact Support'
    ${small}=    Get Matching Xpath Count    //div[@id="SubHeader" and @class="tablet-and-down"]
    ${loc}=    Set Variable IF    '${LOCALE}'=='es-es'    /es    '${LOCALE}'=='ja-jp'    /jp    ${EMPTY}
    ${at_menu_Support_ContactSupport}=    Run Keyword IF    '${LOCALE}'=='es-es' or '${LOCALE}'=='ja-jp'    Replace String    ${at_menu_Support_ContactSupport}    href= '/    href= '${loc}/
    ...    ELSE    Set Variable    ${at_menu_Support_ContactSupport}
    Wait Until Element Is Visible    ${at_menu_Support_ContactSupport}
    Scroll To Element    ${at_menu_Support_ContactSupport}
    Focus    ${at_menu_Support_ContactSupport}
    Comment    Click Element    ${at_menu_Support_ContactSupport}/span
    Run Keyword IF    ${small}!=0    Click Element    ${at_menu_Support_ContactSupport}//i

Table Is Enabled
    [Arguments]    ${table_locator}
    Wait Until Page Does Not Contain Element    ${icon_table-loading}
    Wait Until Element is Visible    ${table_locator}
    Wait Until Element is Enabled    ${table_locator}

Click submenu 'My Licenses'
    ${loc}=    Set Variable IF    '${LOCALE}'=='es-es'    /es    '${LOCALE}'=='ja-jp'    /jp    ${EMPTY}
    ${at_menu_Support_MyAccount_MyLicenses}=    Run Keyword IF    '${LOCALE}'=='es-es' or '${LOCALE}'=='ja-jp'    Replace String    ${at_menu_Support_MyAccount_MyLicenses}    href= '/    href= '${loc}/
    ...    ELSE    Set Variable    ${at_menu_Support_MyAccount_MyLicenses}
    Wait Until Element Is Visible    ${at_menu_Support_MyAccount_MyLicenses}
    Scroll To Element    ${at_menu_Support_MyAccount_MyLicenses}
    Focus    ${at_menu_Support_MyAccount_MyLicenses}
    Click Element    ${at_menu_Support_MyAccount_MyLicenses}/span

The user selects 'My Service Requests' in the submenu 'My Account' of menu 'Support'
    Close Popup    ${at_popup_opinion}
    Click menu 'Support'
    Click submenu 'My Account'
    Click submenu 'My Service Requests'

The user selects 'Contact Support' in the 'Support' menu
    Click menu 'Support'
    Click submenu 'Contact Support'

The user selects 'My Products' in the submenu 'My Account' of menu 'Support'
    Close Popup    ${at_popup_opinion}
    Click menu 'Support'
    Click submenu 'My Account'
    Click submenu 'My Products'

The user selects 'My Licenses' in the submenu 'My Account' of menu 'Support'
    Close Popup    ${at_popup_opinion}
    Click menu 'Support'
    Click submenu 'My Account'
    Click submenu 'My Licenses'

The user selects 'My Groups' in the submenu 'My Account' of menu 'Support'
    Close Popup    ${at_popup_opinion}
    Click menu 'Support'
    Click submenu 'My Account'
    Click submenu 'My Groups'

Click submenu 'My Groups'
    ${loc}=    Set Variable IF    '${LOCALE}'=='es-es'    /es    '${LOCALE}'=='ja-jp'    /jp    ${EMPTY}
    ${at_menu_Support_MyAccount_MyGroups}=    Run Keyword IF    '${LOCALE}'=='es-es' or '${LOCALE}'=='ja-jp'    Replace String    ${at_menu_Support_MyAccount_MyGroups}    href= '/    href= '${loc}/
    ...    ELSE    Set Variable    ${at_menu_Support_MyAccount_MyGroups}
    Wait Until Element Is Visible    ${at_menu_Support_MyAccount_MyGroups}
    Scroll To Element    ${at_menu_Support_MyAccount_MyGroups}
    Focus    ${at_menu_Support_MyAccount_MyGroups}
    Click Element    ${at_menu_Support_MyAccount_MyGroups}/span
