*** Settings ***
Documentation     Base Page Object - Contains common functionality for all pages
Library           Browser
Library           Collections
Library           String


*** Variables ***
# Page Load Timeout
${PAGE_LOAD_TIMEOUT}      30s

# Common Locators
${BODY}                   css=body
${MAIN_CONTENT}           css=main
${HEADER}                 css=header
${FOOTER}                 css=footer


*** Keywords ***
Wait For Page Load
    [Documentation]    Wait for page to load completely
    [Arguments]    ${timeout}=${PAGE_LOAD_TIMEOUT}
    Wait For Load State    networkidle    timeout=${timeout}

Wait For Element Visible
    [Documentation]    Wait for element to be visible
    [Arguments]    ${locator}    ${timeout}=30s
    Wait For Elements State    ${locator}    visible    timeout=${timeout}

Wait For Element Hidden
    [Documentation]    Wait for element to be hidden
    [Arguments]    ${locator}    ${timeout}=30s
    Wait For Elements State    ${locator}    hidden    timeout=${timeout}

Get Element Text
    [Documentation]    Get text from element
    [Arguments]    ${locator}
    ${text}=    Get Text    ${locator}
    RETURN    ${text}

Get Element Count
    [Documentation]    Get count of elements matching locator
    [Arguments]    ${locator}
    ${count}=    Get Element Count    ${locator}
    RETURN    ${count}

Click Element
    [Documentation]    Click on element
    [Arguments]    ${locator}
    Click    ${locator}

Fill Text
    [Documentation]    Fill text in input field
    [Arguments]    ${locator}    ${text}
    Fill Text    ${locator}    ${text}

Is Element Visible
    [Documentation]    Check if element is visible
    [Arguments]    ${locator}
    ${visible}=    Get Element Count    ${locator}
    RETURN    ${visible}

Scroll To Element
    [Documentation]    Scroll to element
    [Arguments]    ${locator}
    Scroll To    ${locator}

Get Element Attribute
    [Documentation]    Get attribute value from element
    [Arguments]    ${locator}    ${attribute}
    ${value}=    Get Attribute    ${locator}    ${attribute}
    RETURN    ${value}

Navigate To
    [Documentation]    Navigate to URL
    [Arguments]    ${url}
    Go To    ${url}

Get Current URL
    [Documentation]    Get current page URL
    ${url}=    Get Url
    RETURN    ${url}

Verify Page Loaded
    [Documentation]    Verify page has loaded
    [Arguments]    ${page_identifier}
    Wait For Load State    networkidle
    Log    Page ${page_identifier} loaded successfully
