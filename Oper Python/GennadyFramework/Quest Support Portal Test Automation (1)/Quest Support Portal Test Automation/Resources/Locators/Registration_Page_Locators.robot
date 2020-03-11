*** Settings ***

*** Variables ***
${dsg_Registration_WithSupportProduct_PageTitle_locator}    xpath=//h1[@id="LayoutH1" and text()='${dsg_Registration_WithSupportProduct_PageTitle}']
${at_link_trial_product}    xpath=//form[@id="frmRegisterTrialUser"]//div//a[text()[contains(., "${dsg_Registration_Link_ClickHere_Text}")]]
${dsg_Registration_WithTrialProduct_PageTitle_locator}    xpath=//h1[@id="LayoutH1" and text()[contains(., '${dsg_Registration_WithTrialProduct_PageTitle}')]]
${dsg_Account_WelcomePage_Title_locator}    xpath=//h1[@id="LayoutH1" and text()[contains(., '${dsg_Account_WelcomePage_Title}')]]
${at_trial_select_product}    xpath=//form[@id="frmRegisterTrialUser"]//select[@id="Product"]
${at_form_frmRegisterTrialUser}    xpath=//form[@id="frmRegisterTrialUser"]
${dsg_Registration_Complete_TrialAccount_Title_locator}    xpath=//h1[@id="LayoutH1" and text()[contains(., '${dsg_Registration_Complete_TrialAccount_Title}')]]
${dsg_Registration_Link_UseAccountId_locator}    xpath=//form[@id="frmRegisterTrialUser"]//div/a[text()[contains(.,"${dsg_Registration_Link_UseAccountId}")]]
${at_alert}       //div[@class='alert' or @class='alert-warning']
${at_alert_text}    concat((//div[@class='alert' or @class='alert-warning']//div[@ class='label-error-wrapper']//text())[1], (//div[@class='alert' or @class='alert-warning']//div[@ class='label-error-wrapper']//text())[2], (//div[@class='alert' or @class='alert-warning']//div[@ class='label-error-wrapper']//text())[3], (//div[@class='alert' or @class='alert-warning']//div[@ class='label-error-wrapper']//text())[4], (//div[@class='alert' or @class='alert-warning']//div[@ class='label-error-wrapper']//text())[5], (//div[@class='alert' or @class='alert-warning']//div[@ class='label-error-wrapper']//text())[6], (//div[@class='alert' or @class='alert-warning']//div[@ class='label-error-wrapper']//text())[7], (//div[@class='alert' or @class='alert-warning']//div[@ class='label-error-wrapper']//text())[8], (//div[@class='alert' or @class='alert-warning']//div[@ class='label-error-wrapper']//text())[9], (//div[@class='alert' or @class='alert-warning']//div[@ class='label-error-wrapper']//text())[10], (//div[@class='alert' or @class='alert-warning']//div[@ class='label-error-wrapper']//text())[11], (//div[@class='alert' or @class='alert-warning']//div[@ class='label-error-wrapper']//text())[12], (//div[@class='alert' or @class='alert-warning']//div[@ class='label-error-wrapper']//text())[13], (//div[@class='alert' or @class='alert-warning']//div[@ class='label-error-wrapper']//text())[14], (//div[@class='alert' or @class='alert-warning']//div[@ class='label-error-wrapper']//text())[15], (//div[@class='alert' or @class='alert-warning']//div[@ class='label-error-wrapper']//text())[16], (//div[@class='alert' or @class='alert-warning']//div[@ class='label-error-wrapper']//text())[17], (//div[@class='alert' or @class='alert-warning']//div[@ class='label-error-wrapper']//text())[18], (//div[@class='alert' or @class='alert-warning']//div[@ class='label-error-wrapper']//text())[19], (//div[@class='alert' or @class='alert-warning']//div[@ class='label-error-wrapper']//text())[20])    # string-join(//div[@class='alert' or @class='alert-warning']//div[@ class='label-error-wrapper']//text(), ' ')
${at_alert_header}    //div[@class='alert' or @class='alert-warning']//h4/text()
${dsg_Registration_Link_Support_Text_locator}    xpath=//form[@id="frmRegisterTrialUser"]//div/a[text()[contains(.,"${dsg_Registration_Link_Support_Text}")]]
${at_CustomService_select_product}    xpath=//div[@id="divSelProd"]//select[@id="SelectedProductId"]
${at_h1}          xpath=//h1[@id="LayoutH1"]
${dsg_Registration_Complete_KnownAccount_Title_locator}    xpath=//h1[@id="LayoutH1" and text()[contains(., '${dsg_Registration_Complete_KnownAccount_Title}')]]
${dsg_Registration_Button_CreateAccount_locator}    //button[@id='btnSubmit']
${dib-verify-email}    xpath=//div[@id='kc-content'][.//img[@id='email-sent-image'] and .//div[@id='dib-verify-email']]
${at_VerifyEmail_username}    xpath=//div[@id='dib-verify-email']//input[@id='username']
${at_VerifyEmail_verificationCode}    xpath=//div[@id='dib-verify-email']//input[@id='verificationCode']
${at_VerifyEmail_buttonVerify}    xpath=//div[@id='dib-verify-email']//button[@id='kc-verify-email']
