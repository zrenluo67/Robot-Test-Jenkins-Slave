*** Settings ***
Library    Selenium2Library

*** Variables ***
${PAGE}           Ruckus Wireless
${URL}            https://www.google.ca
${BROWSER}        firefox

*** Test Cases ***
[TC-001]-Search Ruckus Wireless on Google
    Launch Browser
    Search Web Page On Google
    Launch Page

*** Keywords ***
Launch Browser
    Open Browser    ${URL}  ${BROWSER}
Search Web Page On Google
    Input Text    id=lst-ib    ${PAGE}
    Click Button    name=btnG
    Sleep    2s
    Capture Page Screenshot
Launch Page
    Wait Until Element Is Visible    link=Ruckus Wireless      20 Seconds
    Click Element     link=Ruckus Wireless
    Sleep    2s
    Capture Page Screenshot
