*** Settings ***
Suite Setup       Global Setup
Test Teardown     Close Working Session
Force Tags        registration
Resource          ../Resources/Commons.robot
Resource          SuiteRegistration_Keywords_Resources.robot

*** Test Cases ***
Integrity - Create a Support Account with Asset Number
    An anonymous user on the Registration page
    Page Should Contain 'Asset Number' Field
    Contact Information Fields Count Should Be    6
    Contact Information Field Attributes Should Be    order=1    label=${dsg_Registration_Label_EmailAddress_Title}    name=EmailAddress    type=text    IsRequired=true
    Contact Information Field Attributes Should Be    order=2    label=${dsg_Registration_Label_Password}    name=Password    type=password    IsRequired=true
    Contact Information Field Attributes Should Be    order=3    label=${dsg_Registration_Label_PasswordConfirm}    name=PasswordConfirm    type=password    IsRequired=true
    Contact Information Field Attributes Should Be    order=4    label=${dsg_Registration_Label_FirstName_Title}    name=FirstName    type=text    IsRequired=true
    Contact Information Field Attributes Should Be    order=5    label=${dsg_Registration_Label_LastName_Title}    name=LastName    type=text    IsRequired=true
    Contact Information Field Attributes Should Be    order=6    label=${dsg_Registration_Label_PhoneNumber_Title}    name=PhoneNumber    type=text    IsRequired=true
    Page Should Contain 'Create Account' Button

Integrity - Create a Support Account with Account Number
    An anonymous user on the Registration page
    The user click on the link ‘Or Use Account ID’
    Page Should Contain 'Support Account Number' Field
    Page Should Contain 'Product' Selector
    Contact Information Fields Count Should Be    6
    Contact Information Field Attributes Should Be    order=1    label=${dsg_Registration_Label_EmailAddress}    name=EmailAddress    type=text    IsRequired=true
    Contact Information Field Attributes Should Be    order=2    label=${dsg_Registration_Label_Password}    name=Password    type=password    IsRequired=true
    Contact Information Field Attributes Should Be    order=3    label=${dsg_Registration_Label_PasswordConfirm}    name=PasswordConfirm    type=password    IsRequired=true
    Contact Information Field Attributes Should Be    order=4    label=${dsg_Registration_Label_FirstName}    name=FirstName    type=text    IsRequired=true
    Contact Information Field Attributes Should Be    order=5    label=${dsg_Registration_Label_LastName}    name=LastName    type=text    IsRequired=true
    Contact Information Field Attributes Should Be    order=6    label=${dsg_Registration_Label_PhoneNumber}    name=PhoneNumber    type=text    IsRequired=true
    Page Should Contain 'Create Account' Button

Integrity - Create a Support Account With A Trial Product
    An anonymous user on the Registration page
    The user click on the link ‘Register Trial Product’
    Page Should Contain 'Product' Selector
    Contact Information Fields Count Should Be    11
    Contact Information Field Attributes Should Be    order=1    label=${dsg_Registration_Label_EmailAddress}    name=EmailAddress    type=text    IsRequired=true
    Contact Information Field Attributes Should Be    order=2    label=${dsg_Registration_Label_Password}    name=Password    type=password    IsRequired=true
    Contact Information Field Attributes Should Be    order=3    label=${dsg_Registration_Label_PasswordConfirm}    name=PasswordConfirm    type=password    IsRequired=true
    Contact Information Field Attributes Should Be    order=4    label=${dsg_Registration_Label_FirstName}    name=FirstName    type=text    IsRequired=true
    Contact Information Field Attributes Should Be    order=5    label=${dsg_Registration_Label_LastName}    name=LastName    type=text    IsRequired=true
    Contact Information Field Attributes Should Be    order=6    label=${dsg_Registration_Label_Company}    name=Company    type=text    IsRequired=true
    Contact Information Field Attributes Should Be    order=7    label=${dsg_Registration_Label_PhoneNumber}    name=PhoneNumber    type=text    IsRequired=true
    Contact Information Field Attributes Should Be    order=8    label=${dsg_Registration_Label_Address1}    name=Address1    type=text    IsRequired=true
    Contact Information Field Attributes Should Be    order=9    label=${dsg_Registration_Label_Address2}    name=Address1    type=text    IsRequired=true
    Contact Information Field Attributes Should Be    order=10    label=${dsg_Registration_Label_PostalCode}    name=PostalCode    type=text    IsRequired=true
    Contact Information Field Attributes Should Be    order=11    label=${dsg_Registration_Label_City}    name=City    type=text    IsRequired=true
    Page Should Contain 'Select Country' Selector
    Page Should Contain 'Selct State' Selector
    Page Should Contain 'Create Account' Button

*** Keywords ***
Contact Information Field Attributes Should Be
    [Arguments]    ${order}    ${label}    ${name}    ${type}    ${IsRequired}
    Comment    ${label}=    Strip String    ${label}
    Comment    Page Should Contain Element    xpath=//div/child::h4[contains(text(),"Contact Information")]/..//div[@class="row" or @class="form-group"][${order}]//div[@class="form-group"]    Field number ${order} was not found on the page    loglevel=NONE
    Comment    Highlight Element    //div/child::h4[contains(text(),"Contact Information")]/..//div[@class="row"][${order}]//div[@class="form-group"]
    Comment    Scroll To Element    //div/child::h4[contains(text(),"Contact Information")]/..//div[@class="row"][${order}]//div[@class="form-group"]
    Comment    Page Should Contain Element    xpath=//div/child::h4[contains(text(),"Contact Information")]/..//div[@class="row"][${order}]//div[@class="form-group"]/label    Field does not have label    loglevel=NONE
    Comment    Element Text Should Be    xpath=//div/child::h4[contains(text(),"Contact Information")]/..//div[@class="row"][${order}]//div[@class="form-group"]/label    ${label}    Field label mismatch
    Comment    Element Attribute Should Be    xpath=//div/child::h4[contains(text(),"Contact Information")]/..//div[@class="row"][${order}]//div[@class="form-group"]/div/input    aria-required    ${IsRequired}
    Comment    Element Attribute Should Be    xpath=//div/child::h4[contains(text(),"Contact Information")]/..//div[@class="row"][${order}]//div[@class="form-group"]/div/input    name    ${name}
    Comment    Element Attribute Should Be    xpath=//div/child::h4[contains(text(),"Contact Information")]/..//div[@class="row"][${order}]//div[@class="form-group"]/div/input    title    ${label}
    Comment    Element Attribute Should Be    xpath=//div/child::h4[contains(text(),"Contact Information")]/..//div[@class="row"][${order}]//div[@class="form-group"]/div/input    type    ${type}
    ${label}=    Strip String    ${label}
    Page Should Contain Element    xpath=//div[h4[contains(text(),"${dsg_ContactUs_ContactInfoLabel}")]]/*[self::div[@class="form-group"] or child::div[@class="form-group"]][.//input][${order}]    Field number ${order} was not found on the page    loglevel=NONE
    Highlight Element    //div[h4[contains(text(),"${dsg_ContactUs_ContactInfoLabel}")]]/*[self::div[@class="form-group"] or child::div[@class="form-group"]][.//input][${order}]
    Scroll To Element    //div[h4[contains(text(),"${dsg_ContactUs_ContactInfoLabel}")]]/*[self::div[@class="form-group"] or child::div[@class="form-group"]][.//input][${order}]
    Page Should Contain Element    xpath=//div[h4[contains(text(),"${dsg_ContactUs_ContactInfoLabel}")]]/*[self::div[@class="form-group"] or child::div[@class="form-group"]][.//input][${order}]//label    Field does not have label    loglevel=NONE
    Element Text Should Be    xpath=//div[h4[contains(text(),"${dsg_ContactUs_ContactInfoLabel}")]]/*[self::div[@class="form-group"] or child::div[@class="form-group"]][.//input][${order}]//label    ${label}    Field label mismatch
    ${isAttribute}=    Get Matching Xpath Count    //div[h4[contains(text(),"${dsg_ContactUs_ContactInfoLabel}")]]/*[self::div[@class="form-group"] or child::div[@class="form-group"]][.//input][${order}]//input[@aria-required]
    Run Keyword IF    ${isAttribute}>0    Element Attribute Should Be    xpath=//div[h4[contains(text(),"${dsg_ContactUs_ContactInfoLabel}")]]/*[self::div[@class="form-group"] or child::div[@class="form-group"]][.//input][${order}]//input    aria-required    ${IsRequired}
    Element Attribute Should Be    xpath=//div[h4[contains(text(),"${dsg_ContactUs_ContactInfoLabel}")]]/*[self::div[@class="form-group"] or child::div[@class="form-group"]][.//input][${order}]//input    name    ${name}
    Comment    Element Attribute Should Be    xpath=//div[h4[contains(text(),"Contact Information")]]/*[self::div[@class="form-group"] or child::div[@class="form-group"]][.//input][${order}]//input    title    ${label}
    Element Attribute Should Be    xpath=//div[h4[contains(text(),"${dsg_ContactUs_ContactInfoLabel}")]]/*[self::div[@class="form-group"] or child::div[@class="form-group"]][.//input][${order}]//input    type    ${type}

Element Attribute Should Be
    [Arguments]    ${locator}    ${attribute_name}    ${expected_value}
    ${attribute}=    Get Element Attribute    ${locator}@${attribute_name}
    ${attribute}=    Strip String    ${attribute}
    Should Be Equal As Strings    ${attribute}    ${expected_value}    Attribute '${attribute_name}' mismatch. Actual value: '${attribute}' Expected value: '${expected_value}'

Page Should Contain 'Asset Number' Field
    Page Should Contain Element    xpath=//div[@class="form-group "]/label[contains(text(), "${dsg_Registration_Label_LicenseOrServiceTag_Title}")]    Asset Number field missed    loglevel=NONE
    Scroll To Element    //div[@class="form-group "]
    Highlight Element    //div[@class="form-group "]
    Comment    ${var_title}=    Set Variable IF    "${LOCALE}"=="es-es"    ${dsg_Registration_Label_LicenseOrServiceTag_Title}    Asset Number
    Comment    Element Attribute Should Be    xpath=//div[@class="form-group "]//input    title    ${var_title}
    Element Attribute Should Be    xpath=//div[@class="form-group "]//input    title    ${dsg_Registration_Label_LicenseOrServiceTag_Title}
    Element Attribute Should Be    xpath=//div[@class="form-group "]//input    name    LicenseOrServiceTag
    Element Attribute Should Be    xpath=//div[@class="form-group "]//input    type    text
    log    ${dsg_Account_Registration_LicOrSvcNo}
    ${dsg_var}=    Set Variable    ${dsg_Account_Registration_LicOrSvcNo}
    Comment    ${dsg_var}=    Run Keyword IF    "${LOCALE}"=="es-es"    Evaluate    re.sub('&([^;]+);', lambda m: unichr(htmlentitydefs.name2codepoint[m.group(1)]), '${dsg_Account_Registration_LicOrSvcNo}')    modules=htmlentitydefs, re
    ...    ELSE    Set Variable    ${dsg_Account_Registration_LicOrSvcNo}
    Element Attribute Should Be    xpath=//div[@class="form-group "]//input    placeholder    ${dsg_var}

Contact Information Fields Count Should Be
    [Arguments]    ${count}
    ${actual_count}=    Get Matching Xpath Count    //div[h4[contains(text(),"${dsg_ContactUs_ContactInfoLabel}")]]/*[self::div[@class="form-group"] or child::div[@class="form-group"]][.//input]
    Xpath Should Match X Times    //div[h4[contains(text(),"${dsg_ContactUs_ContactInfoLabel}")]]/*[self::div[@class="form-group"] or child::div[@class="form-group"]][.//input]    ${count}    Contact Information Fields Count Should Be '${count}'. But actual count is '${actual_count}' Please check Contact Information Fields    loglevel=NONE

Page Should Contain 'Create Account' Button
    Page Should Contain Button    xpath=//button[@id="btnSubmit"][contains(text(), "${dsg_Registration_Button_CreateAccount}")]    Create Account button is missed    loglevel=NONE

The user click on the link ‘Or Use Account ID’
    Comment    Scroll To Element    ${dsg_Registration_Link_UseAccountId_locator}
    Comment    Highlight Element    ${dsg_Registration_Link_UseAccountId_locator}
    Comment    Click Element    ${dsg_Registration_Link_UseAccountId_locator}
    Click Link    xpath=//a[@id="AccountNoToggle"]
    Sleep    1

Page Should Contain 'Support Account Number' Field
    Page Should Contain Element    xpath=//div[@class="row"]//div[@class="form-group hide-until"][1]/label[contains(text(), "${dsg_Registration_Label_AccountId_Title}")]    'Support Account Number' field is missed    loglevel=NONE
    Highlight Element    //div[@class="row"]//div[@class="form-group hide-until"][1]
    Scroll To Element    //div[@class="row"]//div[@class="form-group hide-until"][1]
    Element Attribute Should Be    //div[@class="row"]//div[@class="form-group hide-until"][1]//input    title    ${dsg_Registration_Label_AccountId_Title}
    Element Attribute Should Be    //div[@class="row"]//div[@class="form-group hide-until"][1]//input    name    AccountId
    Element Attribute Should Be    //div[@class="row"]//div[@class="form-group hide-until"][1]//input    type    text
    ${isAttribute}=    Get Matching Xpath Count    //div[@class="row"]//div[@class="form-group hide-until"][1]//input[@aria-required]
    Run Keyword IF    ${isAttribute}>0    Element Attribute Should Be    //div[@class="row"]//div[@class="form-group hide-until"][1]//input    aria-required    true

Page Should Contain 'Product' Selector
    Page Should Contain Element    xpath=//div[@class="row"]//select[@id="Product"]/../../label[contains(text(), "${dsg_Registration_Label_ProductId_Title}")]    'Product' selector is missed    loglevel=NONE
    Highlight Element    //div[@class="row"]//select[@id="Product"]
    Scroll To Element    //div[@class="row"]//select[@id="Product"]
    ${value_name}=    Set Variable If    "${TEST NAME}"=="Integrity - Create a Support Account with Account Number"    ProductId    ${dsg_Registration_Label_ProductId_Title}
    Element Attribute Should Be    xpath=//div[@class="row"]//select[@id="Product"]    name    ${value_name}
    Element Attribute Should Be    xpath=//div[@class="row"]//select[@id="Product"]    title    ${dsg_Registration_Label_ProductId_Title}
    Element Attribute Should Be    xpath=//div[@class="row"]//select[@id="Product"]    aria-required    true
    Element Attribute Should Be    xpath=//div[@class="row"]//select[@id="Product"]    id    Product

The user click on the link ‘Register Trial Product’
    Comment    Scroll To Element    ${at_link_trial_product}
    Comment    Highlight Element    ${at_link_trial_product}
    Click Element    ${at_link_trial_product}
    sleep    1

Page Should Contain 'Select Country' Selector
    Comment    Page Should Contain Element    xpath=//div/child::h4[contains(text(),"Contact Information")]/..//div[@class="row"]//div[@class="form-group"]//select[@id="Country"]    Selector 'Select Country' is missed    loglevel=NONE
    Comment    Element Attribute Should Be    xpath=//div/child::h4[contains(text(),"Contact Information")]/..//div[@class="row"]//div[@class="form-group"]//select[@id="Country"]    id    Country
    Page Should Contain Element    xpath=//div[h4[contains(text(),"${dsg_ContactUs_ContactInfoLabel}")]]/*[self::div[@class="form-group"] or child::div[@class="form-group"]]//select[@id="Country"]    Selector 'Select Country' is missed    loglevel=NONE
    Element Attribute Should Be    xpath=//div[h4[contains(text(),"${dsg_ContactUs_ContactInfoLabel}")]]/*[self::div[@class="form-group"] or child::div[@class="form-group"]]//select[@id="Country"]    id    Country

Page Should Contain 'Selct State' Selector
    Comment    Page Should Contain Element    xpath=//div/child::h4[contains(text(),"Contact Information")]/..//div[@class="row"]//div[@class="form-group"]//select[@id="State"]
    Comment    Element Attribute Should Be    xpath=//div/child::h4[contains(text(),"Contact Information")]/..//div[@class="row"]//div[@class="form-group"]//select[@id="State"]    id    State
    Page Should Contain Element    xpath=//div[h4[contains(text(),"${dsg_ContactUs_ContactInfoLabel}")]]/*[self::div[@class="form-group"] or child::div[@class="form-group"]]//select[@id="State"]
    Element Attribute Should Be    xpath=//div[h4[contains(text(),"${dsg_ContactUs_ContactInfoLabel}")]]/*[self::div[@class="form-group"] or child::div[@class="form-group"]]//select[@id="State"]    id    State
