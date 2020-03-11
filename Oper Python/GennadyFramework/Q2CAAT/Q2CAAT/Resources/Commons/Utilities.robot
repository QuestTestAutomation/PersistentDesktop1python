*** Settings ***
Library    String
Library    SeleniumLibrary    

*** Keywords ***

Highlight Element
    [Arguments]    ${element_xpath_locator}
    ${element_xpath_locator}=    Replace String    ${element_xpath_locator}    "    '
    ${element_xpath_locator}=    Replace String    ${element_xpath_locator}    xpath=    ${EMPTY}
    Execute Javascript    window.document.evaluate("${element_xpath_locator}", document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue.style.border="solid pink";
    
    
Scroll To Element
    [Arguments]    ${element_xpath_locator}
    ${element_xpath_locator}=    Replace String    ${element_xpath_locator}    "    '
    ${element_xpath_locator}=    Replace String    ${element_xpath_locator}    xpath=    ${EMPTY}
    Execute Javascript    window.document.evaluate("${element_xpath_locator}", document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue.scrollIntoView(true);
    
