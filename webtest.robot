 ***
| ${BROWSER} | chrome

*** Settings ***
| Library | Selenium2Library
| Suite Teardown | Close all browsers

*** Test Cases ***
| Example
| | Open browser | http://bbcnews.com | ${BROWSER}
