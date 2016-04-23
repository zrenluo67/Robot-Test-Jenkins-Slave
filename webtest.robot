***
| ${BROWSER} | chrome

*** Settings ***
| Library | Selenium2Library
| Suite Teardown | Close all browsers

*** Test Cases ***
| Example
| | Open browser | https://www.ruckuswireless.com/ | ${BROWSER}
| | Capture Page Screenshot
