*** Settings ***
Library  Selenium2Library
Library  ./Libs/Utillib.py
Library  ./Libs/XLLib.py
Library  ./Libs/LoginPage.py
Library  ./Libs/CPQLib.py
Resource  ./Resources/Common.robot
Resource  ./Resources/Account.robot
Resource  ./Resources/Opportunity.robot
Resource  ./Resources/Contacts.robot
Resource  ./Resources/CPQQuote.robot
Suite Setup  Common.Initialize Test Suite
Suite Teardown  Common.Finalize Test Suite
Test Setup  Common.Initialize Test Case Run
Test Teardown  Common.Finalize Test Case Run


*** Test Cases ***
#SFDCTC01
#
#
#    POC_Keywords.Lauch Browser
#    POC_Keywords.Login into Application
#    sleep  10s
#    Account.Navigate To Accounts
#    Account.Add New Account
#    Logout of Application
#
#
#SFDCTC02
#    POC_Keywords.Lauch Browser
#    POC_Keywords.Login into Application
#    Account.Create New Account Contact
#    Contacts.Add Contact Details
#    Contacts.Get Contact Details
#    Logout of Application
#
##SFDCTC03
###    POC_Keywords.Lauch Browser
##    POC_Keywords.Login into Application
##    Contacts.Create New Contact Opportunity
##    Opportunity.Add Opportunity Dteails
##    Opportunity.Get Opportunity Detail
##    Logout of Application
SFDCTC04
    Common.Lauch Browser
    Common.Login into Application
    Click On Steel Brick Button
#    Add Products to CPQQuote
#    Add Products to CPQQuote New
    Add Products to CPQQuote New New