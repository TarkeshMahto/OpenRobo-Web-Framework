*** Settings ***
Documentation    Amazon-specific keywords and test flows
Library          Browser
Library          Collections


*** Keywords ***
Search For Product
    [Documentation]    Search for a product on Amazon
    [Arguments]    ${product_name}
    
    Type Text    ${AMAZON_SEARCH_INPUT}    ${product_name}
    Click    ${AMAZON_SEARCH_BUTTON}
    Wait For Elements State    ${AMAZON_SEARCH_RESULTS}    visible    timeout=10s
    Log    Searched for: ${product_name}

Click First Product In Results
    [Documentation]    Click the first product in search results
    
    ${first_product}    Get Elements    ${AMAZON_SEARCH_RESULTS}
    Click    ${first_product}[0]
    Wait For Load State    networkidle
    Log    First product clicked

Add Current Product To Cart
    [Documentation]    Add the current product to cart
    
    Scroll To Element    ${AMAZON_ADD_TO_CART_BUTTON}
    Click    ${AMAZON_ADD_TO_CART_BUTTON}
    Sleep    2s
    Log    Product added to cart

Verify Product Added To Cart
    [Documentation]    Verify that product was successfully added to cart
    
    ${cart_count}    Get Text    ${AMAZON_CART_BADGE}
    Should Not Be Equal    ${cart_count}    0
    Log    Cart count: ${cart_count}

Search And Add To Cart
    [Documentation]    Complete flow: search, find product, and add to cart
    [Arguments]    ${product_name}
    
    Search For Product    ${product_name}
    Click First Product In Results
    Add Current Product To Cart
    Verify Product Added To Cart
