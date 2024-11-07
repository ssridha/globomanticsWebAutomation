*** Settings ***
Library    SeleniumLibrary
Resource    ../variables/variables.robot

*** Variables ***
${CONFERENCE_NAV_LINK}  xpath://div[@id='navbarSupportedContent']//ul[@class='navbar-nav mr-auto']//a[@class="nav-link" and @href="/conference"]

*** Keywords ***
the Landing Page is open
    [Documentation]    Open the main landing page of the application.
    Go To   ${BASE_URL}

I navigate to the Conference Page
    [Documentation]    Navigate to the Conference page from the landing page.
    Click Element    ${CONFERENCE_NAV_LINK}

