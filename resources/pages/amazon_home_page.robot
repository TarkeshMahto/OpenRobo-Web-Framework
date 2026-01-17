*** Settings ***
Documentation     Amazon Home Page Object - Contains locators and keywords for Amazon home page
Resource          base_page.robot


*** Variables ***
# Amazon Home Page Locators
${AMAZON_LOGO}                        css=a[aria-label="Amazon"]
${AMAZON_SEARCH_BOX}                  css=input[id="twotabsearchtextbox"]
${AMAZON_SEARCH_BUTTON}               css=button[id="nav-search-submit-button"]
${AMAZON_SEARCH_RESULTS}              css=div[data-component-type="s-search-result"]
${AMAZON_FIRST_RESULT}                css=div[data-component-type="s-search-result"] h2 a
${AMAZON_CART_BADGE}                  css=span#nav-cart-count
${AMAZON_ACCOUNT_MENU}                css=a#nav-account
${AMAZON_CART_LINK}                   css=a#nav-cart


*** Keywords ***
Open Amazon Home Page
    [Documentation]    Open Amazon home page
    [Arguments]    ${base_url}
    Navigate To    ${base_url}
    Verify Amazon Home Page Loaded

Verify Amazon Home Page Loaded
    [Documentation]    Verify Amazon home page is loaded
    Wait For Element Visible    ${AMAZON_LOGO}
    Wait For Element Visible    ${AMAZON_SEARCH_BOX}
    Log    Amazon home page loaded successfully

Search For Product
    [Documentation]    Search for a product on Amazon
    [Arguments]    ${product_name}
    Click Element    ${AMAZON_SEARCH_BOX}
    Fill Text    ${AMAZON_SEARCH_BOX}    ${product_name}
    Click Element    ${AMAZON_SEARCH_BUTTON}
    Wait For Page Load
    Verify Search Results Loaded

Verify Search Results Loaded
    [Documentation]    Verify search results page loaded
    Wait For Element Visible    ${AMAZON_SEARCH_RESULTS}    timeout=30s
    ${count}=    Get Element Count    ${AMAZON_SEARCH_RESULTS}
    Should Be Greater Than    ${count}    0
    Log    ${count} results found

Get Search Result Count
    [Documentation]    Get number of search results
    ${count}=    Get Element Count    ${AMAZON_SEARCH_RESULTS}
    RETURN    ${count}

Click First Search Result
    [Documentation]    Click on the first search result
    Wait For Element Visible    ${AMAZON_FIRST_RESULT}
    Click Element    ${AMAZON_FIRST_RESULT}
    Wait For Page Load

Get Cart Count
    [Documentation]    Get number of items in cart
    Wait For Element Visible    ${AMAZON_CART_BADGE}
    ${count}=    Get Element Text    ${AMAZON_CART_BADGE}
    RETURN    ${count}

Click Cart
    [Documentation]    Click on cart
    Click Element    ${AMAZON_CART_LINK}
    Wait For Page Load

Open Account Menu
    [Documentation]    Open account menu
    Click Element    ${AMAZON_ACCOUNT_MENU}

Clear Search Box
    [Documentation]    Clear the search box
    ${search_box}=    Get Element    ${AMAZON_SEARCH_BOX}
    Triple Click    ${AMAZON_SEARCH_BOX}
    Press Keys    ${AMAZON_SEARCH_BOX}    Delete
