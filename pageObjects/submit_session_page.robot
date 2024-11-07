*** Settings ***
Library    SeleniumLibrary
Resource    ../variables/variables.robot
Library    String

*** Variables ***
${TITLE_FIELD}           id:inputTitle
${DESCRIPTION_FIELD}     id:inputDescription
${DAY_FIELD}             id:inputDay
${LEVEL_FIELD}           id:inputLevel
${SUBMIT_BUTTON}         xpath://button[contains(.,'Submit')]
${VALIDATION_MESSAGE}    return document.getElementById("{id}").validationMessage;



*** Keywords ***
I fill the Submit Session form with details
    [Arguments]    ${title}    ${description}    ${day}    ${level}
    [Documentation]    Fill out the Submit Session form with the provided details.
    Input Text    ${TITLE_FIELD}         ${title}
    Input Text    ${DESCRIPTION_FIELD}   ${description}
    Input Text    ${DAY_FIELD}    ${day}
    Input Text    ${LEVEL_FIELD}  ${level}


I click Submit
    [Documentation]    Click on the Submit button to submit the session form.
    sleep   1s
    Click Element    ${SUBMIT_BUTTON}


I should see success message
    [Documentation]    Verify that the success message "Session Submitted Successfully!" is displayed.
    Page Should Contain    Session Submitted Successfully!

I should see validation messages for mandatory fields
    [Documentation]    Verify that validation messages are displayed for Title, Description, Day, and Level fields.
    sleep    1s
    ${title_id}=         Replace String    ${TITLE_FIELD}    id:    ${EMPTY}
    ${title_validation}=    Execute JavaScript    ${VALIDATION_MESSAGE.replace("{id}", "${title_id}")}
    Should Be Equal    ${title_validation}    Please fill out this field.

