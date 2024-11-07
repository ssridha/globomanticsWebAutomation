*** Settings ***
Library    SeleniumLibrary
Resource    ../variables/variables.robot

*** Variables ***
${VIEW_SPEAKERS_LINK}   link:View Speakers
${VIEW_SESSIONS_LINK}   link:View Sessions


*** Keywords ***
the Conference Page should be displayed
    [Documentation]    Verify that the Conference page is displayed.
    location should be    ${BASE_URL}/conference
    page should contain element     ${VIEW_SPEAKERS_LINK}
    page should contain element     ${VIEW_SESSIONS_LINK}

I click speaker or session link
    [Documentation]    Click on a link on the Conference page based on the provided link name (e.g., "View Speakers" or "View Sessions").
    [Arguments]    ${link_name}
    Run Keyword If    '${link_name}' == 'View Speakers'    Click Element    ${VIEW_SPEAKERS_LINK}
    ...    ELSE IF    '${link_name}' == 'View Sessions'    Click Element    ${VIEW_SESSIONS_LINK}
    ...    ELSE    Fail    Invalid link name provided: ${link_name}




