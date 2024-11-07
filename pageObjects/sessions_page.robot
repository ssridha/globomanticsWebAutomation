*** Settings ***
Library    SeleniumLibrary
Resource    ../variables/variables.robot
Library    String

*** Variables ***
${SESSION_FILTER_BUTTON_BASE}        xpath://button[contains(., '{day}')]
${SESSION_DAY_LOCATOR_BASE}          xpath://h5[@data-cy="day" and contains(text(), 'Day: {day}')]
${SESSION_TITLE_LOCATOR_TEMPLATE}    xpath://h3[contains(text(), '{title}')]
${SUBMIT_SESSION_LINK}               link:Submit a Session!

*** Keywords ***
I filter sessions by day
    [Arguments]    ${day}
    [Documentation]    This filters out the sessions based on the day provided
    ${dynamic_filter_path}=     Replace String    ${SESSION_FILTER_BUTTON_BASE}    {day}    ${day}
    sleep   3s
    Click Element    ${dynamic_filter_path}
    sleep   3s

I should see only ${day} sessions
    [Arguments]    ${day}
    [Documentation]    Verify that all displayed sessions are only for the specified ${day}.
    # Construct the dynamic locator using the template and the provided day
    ${session_locator}=    Replace String    ${SESSION_DAY_LOCATOR_BASE}    {day}    ${day}
    # Get the count of sessions displayed for the specified day
    ${session_count}=    Get Element Count    ${session_locator}
    # Ensure at least one session is displayed
    Should Be True    ${session_count} > 0    No sessions found for ${day}
    # Verify each session's day matches the expected day
    FOR    ${index}    IN RANGE    ${session_count}
        # Verify the day text of each session matches ${day}
        Element Text Should Be    ${session_locator}[${index} + 1}]    Day: ${day}
    END

I click Submit a Session
    [Documentation]    Click on "Submit a Session" link to navigate to the Submit Session form.
    Click Element    ${SUBMIT_SESSION_LINK}
    sleep    3s

I should see session with title
    [Arguments]    ${title}
    [Documentation]    Verify that a session with the specified title is displayed on the View Sessions page.
    # Construct the dynamic locator for the session title
    sleep    3s
    ${session_locator}=    Replace String    ${SESSION_TITLE_LOCATOR_TEMPLATE}    {title}    ${title}
    # Verify that the session with the given title is visible on the page
    Wait Until Element Is Visible    ${session_locator}    timeout=5s
    Element Should Be Visible    ${session_locator}