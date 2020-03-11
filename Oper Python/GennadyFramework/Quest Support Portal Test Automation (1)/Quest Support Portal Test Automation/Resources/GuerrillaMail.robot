*** Settings ***
Library           HttpLibrary.HTTP
Library           String

*** Variables ***
${gmRoot}         api.guerrillamail.com

*** Keywords ***
Create Mail Box
    Create Http Context    ${gmRoot}
    Run Keyword And Continue on Failure    GET    /ajax.php?f=get_email_address&ip=127.0.0.1&agent=Mozilla_foo_bar
    ${status}=    Get Response Status
    Run Keyword IF    "200" not in "${status}"    Fail    Mailbox has not been created (${status})    invalidTestData
    Response Status Code Should Equal    200
    ${mailBox}=    Get Response Body
    ${mailBox}=    Parse Json    ${mailBox}
    [Return]    ${mailBox}

Check Email
    [Arguments]    ${mailBox}    ${sequence_number}=0
    Create Http Context    ${gmRoot}
    ${APIcall}=    Catenate    /ajax.php?f=check_email&sid_token=    ${mailBox['sid_token']}    &seq=    ${sequence_number}    &ip=127.0.0.1&agent=Mozilla_foo_bar
    GET    ${APIcall}
    ${emails}=    Get Response Body
    ${emails}=    Parse Json    ${emails}
    [Return]    ${emails}

Fetch Email
    [Arguments]    ${mailBox}    ${email_id}
    Create Http Context
    ${APIcall}=    Catenate    /ajax.php?f=fetch_email&sid_token=    ${mailBox['sid_token']}    &email_id=    ${email_id}    &ip=127.0.0.1&agent=Mozilla_foo_bar
    Run Keyword And Continue on Failure    GET    ${APIcall}
    ${status}=    Get Response Status
    Run Keyword IF    "200" not in "${status}"    Set Tags    invalidTestData
    ${email}=    Run Keyword IF    "200" in "${status}"    Get Response Body
    ...    ELSE    Set Variable    ${EMPTY}
    ${email}=    Run Keyword IF    "200" in "${status}"    Parse Json    ${email}
    ...    ELSE    Set Variable    ${email}
    [Return]    ${email}

Get Email List
    [Arguments]    ${mailBox}    ${offset}=0    ${seq}=0
    Create Http Context    ${gmRoot}
    ${APIcall}=    Catenate    /ajax.php?f=get_email_list&sid_token=    ${mailBox['sid_token']}    &offset=    ${offset}    &ip=127.0.0.1&agent=Mozilla_foo_bar
    ...    &seq=    ${seq}
    Run Keyword And Continue on Failure    GET    ${APIcall}
    ${status}=    Get Response Status
    Run Keyword IF    "200" not in "${status}"    Set Tags    invalidTestData
    ${email_list}=    Run Keyword IF    "200" in "${status}"    Get Response Body
    ...    ELSE    Set Variable    []
    ${email_list}=    Parse Json    ${email_list}
    ${email_list}=    Set Variable IF    "200" in "${status}"    ${email_list['list']}    ${email_list}
    [Return]    ${email_list}

Get Last Email ID
    [Arguments]    ${mailBox}
    ${emails}=    Get Email List    ${mailBox}
    ${last_email_id}=    Set Variable    ${emails['list'][0]['mail_id']}
    [Return]    ${last_email_id}

Get Past Email ID by Offset
    [Arguments]    ${mailBox}    ${offset}=0
    [Documentation]    Returns email ID of the specified by the offset agrument email.
    ...    ${offset}=0 means the last email
    ...    ${offset}=1 means the previous email
    ${emails}=    Get Email List    ${mailBox}
    ${last_email_id}=    Set Variable    ${emails['list'][offset]['mail_id']}

Email From Should be Equal
    [Arguments]    ${email}    ${mail_from}
    Should Be Equal As Strings    ${email['mail_from']}    ${mail_from}

Email Subject Should be Equal
    [Arguments]    ${email}    ${mail_subject}
    Should Be Equal As Strings    ${email['mail_subject']}    ${mail_subject}

Get Email Body
    [Arguments]    ${email}
    ${email_body}=    Set Variable    ${email['mail_body']}
    [Return]    ${email_body}

Get Temp Password
    [Arguments]    ${email}    ${str_re}=[Pp]assword: ([^<\s\n\t]*)
    ${body}=    Get Email Body    ${email}
    log    ${body}
    ${temp_password}=    Get Regexp Matches    ${body}    ${str_re}    1
    Should Not Be Empty    ${temp_password}    Email '${email['mail_subject']} ' from ${email['mail_from']} does not contain Password
    ${temp_password}=    Evaluate    ${temp_password}[0]
    [Return]    ${temp_password}

Get Your New Account Email
    [Arguments]    ${mailBox}    ${offset}=0    ${seq}=0    ${re_base_mailFrom}=support@quest.com    ${re_additional_mailFrom}=email2dbuat[0-9]@quest.com    # ${re_base_mailFrom} - regExp base address; ${re_additional_emailFrom} - regExp additional Address
    ${emails}=    Get Email List    ${mailBox}    ${offset}    ${seq}
    log many    ${emails}
    Comment    ${email}=    Evaluate    next((email for email in ${emails} if email['mail_from']=='support@quest.com'), None)
    Comment    ${email}=    Run Keyword if    ${email} is None    Evaluate    next((email for email in ${emails} if re.search('email2dbuat[0-9]@software.dell.com' , email['mail_from'])), None)    modules=re
    ...    ELSE    Set Variable    ${email}
    ${email}=    Evaluate    next((email for email in ${emails} if re.search('${re_base_mailFrom}' , email['mail_from'])), None)    modules=re
    ${email}=    Run Keyword if    ${email} is None    Evaluate    next((email for email in ${emails} if re.search('${re_additional_mailFrom}' , email['mail_from'])), None)    modules=re
    ...    ELSE    Set Variable    ${email}
    ${your_new_account_email}=    Set Variable If    ${email} is None    ${EMPTY}    ${email}
    [Return]    ${your_new_account_email}

Get Specific Email
    [Arguments]    ${mailBox}    ${offset}=0    ${seq}=0    ${re_base_mailFrom}=${EMPTY}    ${re_additional_mailFrom}=${EMPTY}    # ${re_base_mailFrom} - regExp base address; ${re_additional_emailFrom} - regExp additional Address
    ${emails}=    Get Email List    ${mailBox}    ${offset}    ${seq}
    log many    ${emails}
    ${email}=    Evaluate    next((email for email in ${emails} if re.search('${re_base_mailFrom}' , email['mail_from'])), None)    modules=re
    ${email}=    Run Keyword if    ${email} is None    Evaluate    next((email for email in ${emails} if re.search('${re_additional_mailFrom}' , email['mail_from'])), None)    modules=re
    ...    ELSE    Set Variable    ${email}
    ${your_new_account_email}=    Set Variable If    ${email} is None    ${EMPTY}    ${email}
    [Return]    ${your_new_account_email}
