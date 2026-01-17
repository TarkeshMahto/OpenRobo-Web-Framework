*** Settings ***
Documentation    Regression tests for Amazon functionality
Resource         ../config/base.robot
Resource         ../config/locators.robot
Resource         ../keywords/common.robot
Resource         ../keywords/amazon.robot

Suite Setup      Open Browser With Advanced Features    ${BASE_URL}
Suite Teardown   Close Browser With Cleanup


*** Test Cases ***
Search Functionality Works
    [Documentation]    Verify search returns results
    [Tags]    regression    amazon
    
    Search For Product    Robot Framework
    ${count}    Get Element Count    ${AMAZON_SEARCH_RESULTS}
    Should Be True    ${count} > 0
    Log    Found ${count} products

Navigate To Product Page
    [Documentation]    Verify navigation to product page works
    [Tags]    regression    amazon
    
    Search For Product    Python Book
    Click First Product In Results
    ${title}    Get Text    ${AMAZON_PRODUCT_TITLE}
    Should Not Be Empty    ${title}

Add Multiple Products To Cart
    [Documentation]    Verify multiple products can be added
    [Tags]    regression    amazon
    
    Search And Add To Cart    Laptop
    Go To    ${BASE_URL}
    
    Search And Add To Cart    Mouse
    Go To    ${BASE_URL}
    
    Search And Add To Cart    Keyboard
    ${final_count}    Get Text    ${AMAZON_CART_BADGE}
    Should Be Equal As Integers    ${final_count}    3

Cart Persists After Navigation
    [Documentation]    Verify cart contents persist
    [Tags]    regression    amazon
    
    Search And Add To Cart    Monitor
    Go To    ${BASE_URL}
    Go To    ${BASE_URL}
    ${count}    Get Text    ${AMAZON_CART_BADGE}
    Should Not Be Equal    ${count}    0
