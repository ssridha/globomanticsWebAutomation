*** Settings ***
Documentation     A resource file with reusable keywords and variables.
...               The system specific keywords created here form our own
...               domain specific language. They utilize keywords provided
...               by the imported SeleniumLibrary.
Library           SeleniumLibrary
Resource    variables/variables.robot


*** Variables ***
${user_name}             rahulshettyacademy
${invalid_password}      123445
${valid_password}        learning
${url}                   https://rahulshettyacademy.com/loginpagePractise/
${browser_name}          Chrome




*** Keywords ***

open the browser with the url
     open browser   ${BASE_URL}     ${BROWSER}
     maximize browser window

Close Browser session
    Close Browser

Wait Until element passed is located on Page
    [Arguments]         ${page_locator}
    Wait Until Element Is Visible        ${page_locator}        timeout=10





