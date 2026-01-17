*** Settings ***
Documentation     Amazon Cart Page Object - Contains locators and keywords for Amazon cart page
Resource          base_page.robot


*** Variables ***
# Amazon Cart Page Locators
${AMAZON_CART_ITEMS}                  css=div[class*="a-spacing-base"]
${AMAZON_CART_ITEM_TITLE}             css=span[class*="a-truncate"]
${AMAZON_CART_ITEM_PRICE}             css=span.a-price-whole
${AMAZON_CART_REMOVE_BUTTON}          css=button[aria-label*="Delete"]
${AMAZON_CART_QUANTITY}               css=input[aria-label*="quantity"]
${AMAZON_CART_SUBTOTAL}               css=div[id="sc-subtotal-label-activecart"]
${AMAZON_PROCEED_TO_CHECKOUT}         css=input[name="proceedToRetailCheckout"]
${AMAZON_EMPTY_CART_MESSAGE}          css=div[class*="a-row"]
${AMAZON_SAVE_FOR_LATER}              css=button[aria-label*="Save"]


*** Keywords ***
Verify Cart Page Loaded
    [Documentation]    Verify cart page is loaded
    Wait For Page Load
    Log    Cart page loaded successfully

Get Cart Item Count
    [Documentation]    Get number of items in cart
    ${count}=    Get Element Count    ${AMAZON_CART_ITEMS}
    RETURN    ${count}

Get Cart Item Title
    [Documentation]    Get title of first cart item
    [Arguments]    ${index}=1
    ${title}=    Get Element Text    css=(${AMAZON_CART_ITEM_TITLE})[${index}]
    RETURN    ${title}

Get Cart Item Price
    [Documentation]    Get price of cart item
    [Arguments]    ${index}=1
    ${price}=    Get Element Text    css=(${AMAZON_CART_ITEM_PRICE})[${index}]
    RETURN    ${price}

Remove Item From Cart
    [Documentation]    Remove item from cart
    [Arguments]    ${index}=1
    Click Element    css=(${AMAZON_CART_REMOVE_BUTTON})[${index}]
    Wait For Page Load

Update Item Quantity
    [Documentation]    Update quantity of cart item
    [Arguments]    ${index}    ${quantity}
    Wait For Element Visible    css=(${AMAZON_CART_QUANTITY})[${index}]
    Fill Text    css=(${AMAZON_CART_QUANTITY})[${index}]    ${quantity}
    Wait For Page Load

Get Cart Subtotal
    [Documentation]    Get cart subtotal
    ${subtotal}=    Get Element Text    ${AMAZON_CART_SUBTOTAL}
    RETURN    ${subtotal}

Save Item For Later
    [Documentation]    Save item for later
    [Arguments]    ${index}=1
    Click Element    css=(${AMAZON_SAVE_FOR_LATER})[${index}]

Proceed To Checkout
    [Documentation]    Proceed to checkout
    Click Element    ${AMAZON_PROCEED_TO_CHECKOUT}
    Wait For Page Load

Verify Cart Is Empty
    [Documentation]    Verify cart is empty
    ${empty_message}=    Is Element Visible    ${AMAZON_EMPTY_CART_MESSAGE}
    Should Be True    ${empty_message}
    Log    Cart is empty

Verify Cart Contains Items
    [Documentation]    Verify cart contains items
    ${count}=    Get Cart Item Count
    Should Be Greater Than    ${count}    0
