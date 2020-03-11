*** Setting ***
Library    RequestsLibrary     

*** Keyword ***
   
Dowload PDF Anonimously
    [Arguments]    ${download_URL}    ${expected_pdf_name}
    ${reqToRedirector}=    Evaluate    requests.get('${download_URL}')    modules=requests
    Should Be Equal As Integers    ${reqToRedirector.status_code}    200	msg=${reqToRedirector.status_code} error while requesting '${expected_pdf_name}' from Downloads. URL: ${download_URL}    values=False
    log    ${reqToRedirector.url}
    ${reqToPdf}=    Evaluate    requests.get('${reqToRedirector.url}')    modules=requests
    Should Be Equal As Integers    ${reqToPdf.status_code}    200    msg = ${reqToPdf.status_code} error while requesting '${reqToRedirector.url}'    values=False
    Should End With    ${reqToPdf.headers['Content-Disposition']}    ${expected_pdf_name}    msg=Header 'Content-Disposition' does not contain expected PDF name ${expected_pdf_name}    ignore_case=True    values=False
         
    
          