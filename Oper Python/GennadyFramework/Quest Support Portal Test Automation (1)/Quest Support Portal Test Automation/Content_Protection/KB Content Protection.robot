*** Settings ***
Resource          ../Resources/Commons.robot
Library           Process
Library           OperatingSystem

*** Test Cases ***
Premium Content 80 Protected
    Skip the rest of the test case for the following configurations    FireFox    IE    FireFox    iPadAir_2    Samsung_GalaxyS6
    ${out}=    Run And Return Rc And Output    PowerShell.exe -NoProfile -File "${CURDIR}\\Kb80.ps1"
    Run Keyword If    '${out[1]}' == 'Differences have been found. See the report'    Fail    msg=*HTML*<a href="file://spb8456/share/SupportKb80.csv">Unprotected content has been found. Click the link for detailed report</a>
