*** Settings ***
Library    SeleniumLibrary
Resource    ../variables/variables.robot
Library    String

*** Variables ***
${SPEAKER_CARD}             css:h3[data-cy='speakerName']
${FEATURED_SPEAKER_BUTTON}  xpath://button[contains(., 'Featured Speaker')]/i
${ENABLED_STYLE}            color: gold;


*** Keywords ***
I should see a Featured Badge for all the speakers
    [Documentation]    Verify that each speaker entry has a Featured Speaker button.
    wait until element is visible       ${SPEAKER_CARD}
    ${speaker_count}=    Get Element Count    ${SPEAKER_CARD}
    ${badge_count}=      Get Element Count    ${FEATURED_SPEAKER_BUTTON}
    should be equal as numbers      ${speaker_count}    ${badge_count}      Each speaker should have a Featured Speaker button

I should toggle the Featured speaker button
    [Documentation]    Verify that the Featured Speaker button can be toggled between enabled and disabled states.
    # Step 1: Check initial state of the button
    wait until element is visible       ${SPEAKER_CARD}
    ${initial_style}=    Get Element Attribute    ${FEATURED_SPEAKER_BUTTON}    style
    IF    '${ENABLED_STYLE}' in '${initial_style}'
        ${initial_state}=    Set Variable    enabled
    ELSE
        ${initial_state}=    Set Variable    disabled
    END
    Log    Initial state: ${initial_state}  # Debugging line
    # Step 2: Toggle the button
    Click Element    ${FEATURED_SPEAKER_BUTTON}
    # Step 3: Verify the button state after toggling
    ${new_style}=    Get Element Attribute    ${FEATURED_SPEAKER_BUTTON}    style
    Run Keyword If    '${initial_state}' == 'enabled'
    ...    Should Not Contain    ${new_style}    ${ENABLED_STYLE}    The button should be disabled after clicking
    ...    ELSE
    ...    Should Contain    ${new_style}    ${ENABLED_STYLE}    The button should be enabled after clicking
