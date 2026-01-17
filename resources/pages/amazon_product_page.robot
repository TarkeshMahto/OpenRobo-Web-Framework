*** Settings ***
Documentation     Amazon Product Page Object - Contains locators and keywords for Amazon product page
Resource          base_page.robot


*** Variables ***
# Amazon Product Page Locators
${AMAZON_PRODUCT_TITLE}               css=h1 span
${AMAZON_PRODUCT_PRICE}               css=span.a-price-whole
${AMAZON_PRODUCT_RATING}              css=i[data-a-icon="star-fill"] span
${AMAZON_ADD_TO_CART_BUTTON}          css=input[aria-label*="Add to Shopping Cart"]
${AMAZON_ADD_TO_CART_BTN_ALT}         css=button[id="add-to-cart-button"]
${AMAZON_BUY_NOW_BUTTON}              css=button[id="buy-now-button"]
${AMAZON_PRODUCT_DESCRIPTION}         css=div[id="feature-bullets"]
${AMAZON_PRODUCT_IMAGE}               css=img[id="landingImage"]
${AMAZON_ADD_TO_CART_SUCCESS}         css=div[id="huc-v2-order-row-confirm"]
${AMAZON_QUANTITY_SELECTOR}           css=select[id="quantity"]
${AMAZON_BACK_BUTTON}                 css=a[rel="nofollow"]


*** Keywords ***
Verify Product Page Loaded
    [Documentation]    Verify product page is loaded
    [Arguments]    ${timeout}=30s
    Wait For Element Visible    ${AMAZON_PRODUCT_TITLE}    timeout=${timeout}
    Wait For Element Visible    ${AMAZON_PRODUCT_PRICE}    timeout=${timeout}
    Log    Product page loaded successfully

Get Product Title
    [Documentation]    Get product title
    ${title}=    Get Element Text    ${AMAZON_PRODUCT_TITLE}
    RETURN    ${title}

Get Product Price
    [Documentation]    Get product price
    ${price}=    Get Element Text    ${AMAZON_PRODUCT_PRICE}
    RETURN    ${price}

Get Product Rating
    [Documentation]    Get product rating
    ${rating}=    Get Element Text    ${AMAZON_PRODUCT_RATING}
    RETURN    ${rating}

Add Product To Cart
    [Documentation]    Add product to cart
    Wait For Element Visible    ${AMAZON_ADD_TO_CART_BTN_ALT}    timeout=30s
    Click Element    ${AMAZON_ADD_TO_CART_BTN_ALT}
    Wait For Add To Cart Success

Wait For Add To Cart Success
    [Documentation]    Wait for add to cart confirmation
    Wait For Element Visible    ${AMAZON_ADD_TO_CART_SUCCESS}    timeout=30s
    Log    Product added to cart successfully

Buy Now
    [Documentation]    Click Buy Now button
    Click Element    ${AMAZON_BUY_NOW_BUTTON}
    Wait For Page Load

Get Product Description
    [Documentation]    Get product description
    ${description}=    Get Element Text    ${AMAZON_PRODUCT_DESCRIPTION}
    RETURN    ${description}

Set Product Quantity
    [Documentation]    Set product quantity
    [Arguments]    ${quantity}
    Wait For Element Visible    ${AMAZON_QUANTITY_SELECTOR}
    Select Options By    ${AMAZON_QUANTITY_SELECTOR}    value    ${quantity}

View Product Image
    [Documentation]    Verify product image is visible
    Wait For Element Visible    ${AMAZON_PRODUCT_IMAGE}
    Log    Product image is visible

Go Back To Search
    [Documentation]    Go back to search results
    Click Element    ${AMAZON_BACK_BUTTON}
    Wait For Page Load
