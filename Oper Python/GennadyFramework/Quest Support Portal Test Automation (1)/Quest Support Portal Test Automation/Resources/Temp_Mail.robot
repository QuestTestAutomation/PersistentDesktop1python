*** Settings ***
Library           HttpLibrary.HTTP
Library           String
Library           Libs/mixUtils.py
Library           Collections

*** Variables ***
${gmRoot}         api.guerrillamail.com
${domain}         @p33.org

*** Keywords ***
Create Mail Box
    ${dname}=    Generate Random String    10    [LOWER]
    ${dname}=    Catenate    SEPARATOR=    ${dname}    ${domain}
    log    ${dname}
    ${mailBox}=    Create Dictionary
    Set To Dictionary    ${mailBox}    email_addr    ${dname}
    Set To Dictionary    ${mailBox}    email_timestamp    1505151445
    Set To Dictionary    ${mailBox}    alias    fake_alias
    Set To Dictionary    ${mailBox}    sid_token    fake_sid_token
    Comment    ${mailBox}=    Evaluate    json.dumps(&{mb})    json
    Comment    log    ${mailBox}
    [Return]    ${mailBox}

Check Email
    [Arguments]    ${mailBox}    ${sequence_number}=0
    [Return]    ${emails}

Fetch Email
    [Arguments]    ${mailBox}    ${email_id}
    Create Http Context    ${gmRoot}
    ${md5}=    Calculate MD5    ${mailBox['email_addr']}
    ${APIcall}=    Catenate    SEPARATOR=    http://api.temp-mail.ru/request/mail/id/    ${md5}    /format/json
    Run Keyword And Continue on Failure    GET    ${APIcall}
    ${status}=    Get Response Status
    Run Keyword IF    "200" not in "${status}"    Set Tags    invalidTestData
    ${resp}=    Run Keyword IF    "200" in "${status}"    Get Response Body
    ...    ELSE    Set Variable    []
    Comment    ${resp}=    Parse Json    ${resp}
    ${t_email}=    Fetch byID TempMail    ${resp}    ${email_id}
    ${email}=    Run Keyword IF    ${t_email} is ${None}    Set Variable    ${EMPTY}
    ...    ELSE    Convert Email to GMail    ${t_email}    ${mailBox['email_addr']}
    Comment    ${email}=    Create Dictionary
    Comment    Set To Dictionary    ${email}    mail_id    ${t_email['mail_id']}
    Comment    Set To Dictionary    ${email}    mail_from    ${t_email['mail_from']}
    Comment    Set To Dictionary    ${email}    mail_recipient    ${mailBox['email_addr']}
    Comment    Set To Dictionary    ${email}    mail_subject    ${t_email['mail_subject']}
    Comment    Set To Dictionary    ${email}    mail_excerpt    ${EMPTY}
    Comment    Set To Dictionary    ${email}    mail_body    ${t_email['mail_text']}
    [Return]    ${email}

Get Email List
    [Arguments]    ${mailBox}    ${offset}=0    ${seq}=0
    Create Http Context    ${gmRoot}
    ${md5}=    Calculate MD5    ${mailBox['email_addr']}
    ${APIcall}=    Catenate    SEPARATOR=    http://api.temp-mail.ru/request/mail/id/    ${md5}    /format/json
    Run Keyword And Ignore Error    GET    ${APIcall}
    ${status}=    Get Response Status
    Run Keyword IF    "200" not in "${status}"    Set Tags    invalidTestData
    ${resp}=    Run Keyword IF    "200" in "${status}"    Get Response Body
    ...    ELSE    Set Variable    []
    ${resp}=    Parse Json    ${resp}
    ${email_list}=    Convert Collection to GM    ${resp}
    ${mail_temp}=    Evaluate    next((email for email in ${email_list} if re.search('^${seq}$' , email['mail_id'])), None)    modules=re
    log many    ${mail_temp}
    ${mail_timestamp}=    Run Keyword if    ${mail_temp} is None    Set Variable    0
    ...    ELSE    Evaluate    ${mail_temp}.get('mail_timestamp')
    ${email_list}=    RunKeyword IF    ${mail_timestamp}>0    Evaluate    filter(lambda d: round(d.get('mail_timestamp'), 2)>${mail_timestamp}, ${email_list})
    ...    ELSE    Set Variable    ${email_list}
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
    ${count_list}=    Evaluate    len(@{emails})
    ${emls_length}=    Run Keyword IF    ${count_list}!=0    Get Length    ${emails[0]}
    ...    ELSE    Set Variable    ${count_list}
    ${empty_list}=    Create List
    Return From Keyword If    ${emls_length}==0    ${empty_list}
    ${email}=    Evaluate    next((email for email in ${emails} if re.search('${re_base_mailFrom}' , email['mail_from'])), None)    modules=re
    ${email}=    Run Keyword if    ${email} is None    Evaluate    next((email for email in ${emails} if re.search('${re_additional_mailFrom}' , email['mail_from'])), None)    modules=re
    ...    ELSE    Set Variable    ${email}
    ${your_new_account_email}=    Set Variable If    ${email} is None    ${EMPTY}    ${email}
    [Return]    ${your_new_account_email}
