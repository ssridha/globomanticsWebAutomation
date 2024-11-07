*** Settings ***
Documentation   Validate conference functionality in Globomantics test application
Library     SeleniumLibrary
Test Setup      open the browser with the url
Test Teardown   Close Browser session
Resource        ../pageObjects/generic.robot
Resource        ../pageObjects/landing_page.robot
Resource        ../pageObjects/conference_page.robot
Resource        ../pageObjects/speakers_page.robot
Resource        ../pageObjects/sessions_page.robot
Resource        ../pageObjects/submit_session_page.robot


*** Variables ***

*** Test Cases ***
Scenario: Verify Conference Page Navigation
    [Documentation]    As a user, I want to navigate to the Conference page and view its sections.
    [Tags]
    Given the Landing Page is open
    When I navigate to the Conference Page
    Then the Conference Page should be displayed

Scenario: Filter the sessions with the given days
    [Template]    Filter Sessions By Day Template
    [Tags]
    Thursday
    Friday

Scenario: Verify Submit Session Form Submission
    [Documentation]    As a user, I want to submit a new session from the Submit a Session form.
    Given the Landing Page is open
    When I navigate to the Conference Page
    And I click speaker or session link     View Sessions
    And I click Submit a Session
    And I fill the Submit Session form with details    Discover Robot    Robot Session    Friday    Beginner
    Then I click Submit
    And I should see success message
    When I navigate to the Conference Page
    And I click speaker or session link     View Sessions
    And I should see session with title    Discover Robot

Scenario: Verify Validation for Mandatory Fields in Submit Session Form
    [Documentation]    As a user, I want to verify that all mandatory fields in the Submit Session form have validation messages if left empty.
    Given the Landing Page is open
    When I navigate to the Conference Page
    And I click speaker or session link     View Sessions
    And I click Submit a Session
    And I click Submit
    Then I should see validation messages for mandatory fields

Scenario: Verify All Speakers Has Featured Speaker Button
    [Documentation]    As a user, I want to view featured speakers with a badge on the Speakers page for all the speakers
    [Tags]
    Given the Landing Page is open
    When I navigate to the Conference Page
    And I click speaker or session link     View Speakers
    Then I should see a Featured Badge for all the speakers

Scenario: Verify Featured Speaker Button Can Be Toggled
    [Documentation]    As a user, I want to toggle the Featured Speaker button enable and disable
    [Tags]
    Given the Landing Page is open
    When I navigate to the Conference Page
    And I click speaker or session link     View Speakers
    Then I should toggle the Featured speaker button

*** Keywords ***
Filter Sessions By Day Template
    [Arguments]    ${day}
    [Documentation]    This template filters sessions based on the day provided as test data.
    Given the Landing Page is open
    When I navigate to the Conference Page
    And I click speaker or session link    View Sessions
    And I filter sessions by day    ${day}
    Then I should see only ${day} sessions     ${day}