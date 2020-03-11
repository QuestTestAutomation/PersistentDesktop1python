*** Settings ***
Resource          ../Resources/Commons.robot
Resource          ../Resources/Locators/SignIn_Page_Locators.robot
Resource          ../Resources/SignIn_Page_Resources.robot
Resource          ../Resources/Locators/Download_Page_Locators.robot
Resource          ../Resources/Download_Page_Resources.robot
Resource          ../02__Login/SuiteLogin_Keywords_Resources.robot

*** Variables ***
@{list_account}

*** Keywords ***
Selects product '${name_product}' in the ‘Select your product to find the latest Software’ selector
    Select Product in Product Search element    ${name_product}

The user on ‘Download Software’ page of the '${product_name}' product
    Active page should be Download Software page for the '${product_name}' product
    sleep    2
    Comment    Wait Until Page Contains Element    ${download_table_locator}
    Close Chat    ${at_chat}
    Close Popup    ${at_popup_opinion}

Modal window 'Add to My Downloads' appears
    Run Keyword IF    '${LOCALE}'!='en-us'    Close TermsConditionsModal
    Active page should be Add to My Downloads

The user clicks 'Add to Downloads' button of modal window
    Click Link    ${dsg_Download_AddToFolder_link}
    sleep    2

The Support's Download Cart is Empty
    ${locale}=    Evaluate    ("" if "${LOCALE}".lower()=="en-us" else "/${LOCALE}".lower())
    Go To    ${SUPPORT_STAGE2_SITE}${locale}${url_To_CartDownload}
    Wait Until Page Contains Element    ${dsg_DownloadFolder_MyDownloads_locator}
    Wait Until Page Does Not Contain Element    ${table_download}

The user clicks on the application link ${num_link}
    Scroll To Element    ${application_links}[${num_link}]
    Highlight Element    ${application_links}[${num_link}]
    Click link    ${application_links}[${num_link}]

The user clicks on the button 'Add to Downloads'
    Wait Until Page Contains Element    ${dsg_InstallDetail_AddToDownloads_locator}
    Scroll To Element    ${dsg_InstallDetail_AddToDownloads_locator}
    Click Element    ${dsg_InstallDetail_AddToDownloads_locator}
    Comment    Simulate    ${dsg_InstallDetail_AddToDownloads_locator}    click
    sleep    1
    Run Keyword IF    '${LOCALE}'!='en-us'    Close TermsConditionsModal

Receives 'hard fail' error
    Wait Until Element is Visible    ${Entitlement_Download_HardFailContract_Title_locator}
    ${locator}=    Prepare Locator To JS    ${dsg_General_ErrorRequest_locator}
    ${message_text}=    Execute Javascript    return window.document.evaluate("${locator}", document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue.innerHTML
    ${message_text}=    Run Keyword IF    "${LOCALE}"!="en-us"    Replace String    ${message_text}    href="/${LOCALE}/    href="/
    ...    ELSE    Set Variable    ${message_text}
    ${message_text}=    Replace String Using Regexp    ${message_text}    <!--.*-->    ${EMPTY}
    ${message_text}=    Replace String Using Regexp    ${message_text}    <\\s+\/    </
    ${dsg_var}=    Run Keyword IF    "${LOCALE}"!="en-us"    Replace String    ${Entitlement_Download_HardFailContract_Mesg}    href="/${LOCALE}/    href="/
    ...    ELSE    Set Variable    ${Entitlement_Download_HardFailContract_Mesg}
    ${dsg_var}=    Replace String Using Regexp    ${dsg_var}    <!--.*-->    ${EMPTY}
    ${dsg_var}=    Replace String Using Regexp    ${message_text}    <\\s+\/    </
    Should Contain    ${message_text}    ${dsg_var}
    Click Element    ${buttonClose_HardFail}

Receives 'soft fail' error
    Wait Until Element is Visible    ${Entitlement_Download_SoftFailContract_Title_locator}
    ${locator}=    Prepare Locator To JS    ${dsg_ExpiredMaintenance_HardFail_Message_locator}/p[@id='EntitlementMsgContent']
    ${message_text}=    Execute Javascript    return window.document.evaluate("${locator}", document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue.innerHTML
    ${message_text}=    Replace String Using Regexp    ${message_text}    <!--.*-->    ${EMPTY}
    ${message_text}=    Replace String Using Regexp    ${message_text}    <\\s+\/    </
    ${dsg_var}=    Replace String Using Regexp    ${Entitlement_Download_SoftFailContract_Mesg}    \{strGlobalPartNumber\}    ${SOFT_FAIL}
    ${dsg_var}=    Replace String Using Regexp    ${dsg_var}    <!--.*-->    ${EMPTY}
    ${dsg_var}=    Replace String Using Regexp    ${message_text}    <\\s+\/    </
    Should Contain    ${message_text}    ${dsg_var}

the Support's Download Cart is not Empty
    ${locale}=    Evaluate    ("" if "${LOCALE}".lower()=="en-us" else "/${LOCALE}".lower())
    Go To    ${SUPPORT_STAGE2_SITE}${locale}${url_To_CartDownload}
    Wait Until Page Contains Element    ${dsg_DownloadFolder_MyDownloads_locator}
    Wait Until Page Contains Element    ${table_download}//tr

The user changes version on '${version}'
    Select version '${version}'
    Comment    ${version_label}=    Get Text    ${at_version_selector}/option[@data-filtervalue='${version}']
    Comment    JS Select Item of DropDown List    ${at_version_selector}    ${version_label}

The available installations for version appear
    sleep    3
    Wait Until Element is Enabled    ${download_table_locator}
    Close Popup    ${at_popup_opinion}

The user on the page 'Install Detail'
    Wait Until Page Contains Element    ${dsg_dload-install_extraDetail_locator}

The user navigates to Software Downloads
    Navigate to Download Page

Selects test product in the ‘Select your product to find the latest Software’ selector
    Selects product '${TEST_PRODUCT}' in the ‘Select your product to find the latest Software’ selector

The user on ‘Download Software’ page of the test product
    The user on ‘Download Software’ page of the '${TEST_PRODUCT}' product

The user clicks "Choose a different product"
    Wait Until Page Contains Element    ${dsg_General_ChooseDifferentProduct_locator}
    Focus    ${dsg_General_ChooseDifferentProduct_locator}
    Click Element    ${dsg_General_ChooseDifferentProduct_locator}

The user on the products a-z page
    Active page should be Products a-z page

The user clicks on the icon 'Download' ${num_link}
    Comment    Assign ID to Element    ${download_links}[${num_link}]    myID
    Scroll To Element    ${download_links}[${num_link}]
    Highlight Element    ${download_links}[${num_link}]
    Click link    ${download_links}[${num_link}]
    sleep    2
    Run Keyword IF    '${LOCALE}'!='en-us'    Close TermsConditionsModal

The user '${email}' logged into portal
    The user sign in
    ${account}=    Evaluate    next((item for item in @{list_account} if item.get('email')=='${email}'), None)
    Run Keyword if    "${account}"=="${None}"    Fail    The test does not contain definition for account '${email}'
    SignIn    ${account['email']}    ${account['password']}
    Comment    SignIn    &{EXTERNAL_ACCOUNT}[email]    &{EXTERNAL_ACCOUNT}[password]
    sleep    3
    The user is logged

The user selects letter '${letter}' of A-Z list
    Click Element    ${list_alphabetsatoz}/li[./a[text()="${letter}"]]

Clicks product '${product_name}'
    Scroll To Element    ${list_ProductsWrap}//a[text()="${product_name}"]
    Highlight Element    ${list_ProductsWrap}//a[text()="${product_name}"]
    Click Element    ${list_ProductsWrap}//a[text()="${product_name}"]

Background of 'Add to My Downloads' button is 'blue' color and font is 'white' color
    Page Should Contain Element    ${dsg_Download_AddToFolder_link}[@class="btn btn-primary"]

Modal window 'Add to My Downloads' has been closed
    Page Add to My Downloads should be close

The user on 'My Downloads' page
    Active page should be My Downloads page

The user clicks on email
    Scroll To Element    ${email_icon}
    Highlight Element    ${email_icon}
    Click Element    ${email_icon}

Emai box pops up
    Active page should be Email

The user clicks on 'My Downloads'
    Scroll To Element    ${MyDownloads_icon}
    Highlight Element    ${MyDownloads_icon}
    Click Element    ${MyDownloads_icon}

An anonymous user on the Software Downloads page
    Open Download Page

The user selects product '${name_product}' in the ‘Select your product to find the latest Software’ selector
    Select Product in Product Search element    ${name_product}

The user on 'Sign In' page
    Active page should be Sign In

Prepare Account
    Append To List    ${list_account}    ${EXTERNAL_ACCOUNT}
    Append To List    ${list_account}    ${EXTERNAL_ACCOUNT_TEMP}

The list of software contains links with notifications
    ${locator}=    Prepare Locator To JS    ${download_links_with_notification}
    ${count_links_with_notification}=    Get Matching Xpath Count    ${locator}
    Run Keyword IF    ${count_links_with_notification}==0    Capture Page Screenshot
    Run Keyword IF    ${count_links_with_notification}==0    Fail    Download Software does not contain links with \ notifications    invalidTestData

The user clicks on the icon 'Download'
    Scroll To Element    ${download_links_with_notification}[1]
    Highlight Element    ${download_links_with_notification}[1]
    Click link    ${download_links_with_notification}[1]
    sleep    2
    Run Keyword IF    '${LOCALE}'!='en-us'    Close TermsConditionsModal

Modal window 'Add to My Downloads' contains the notification description
    Page Should Contain Element    ${dsg_Download_AddToFolder_Notification}

If 'Download' modal window appears the user clicks on the 'Continue' button
    Close Chat    ${at_chat}
    ${locator}=    Prepare Locator To JS    ${wBrandDisclaimerDialog}
    ${show_modal}=    Get Matching Xpath Count    ${locator}
    Run Keyword IF    ${show_modal}!=0    Click Element    ${wBrandDisclaimerDialog_btn_continue}
