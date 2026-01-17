*** Settings ***
Documentation    Locators for Amazon web application
Library          Collections


*** Variables ***
# Search functionality
${AMAZON_SEARCH_INPUT}                id=twotabsearchtextbox
${AMAZON_SEARCH_BUTTON}               id=nav-search-submit-button
${AMAZON_SEARCH_RESULTS}              [data-component-type="s-search-result"]

# Product page
${AMAZON_ADD_TO_CART_BUTTON}          id=add-to-cart-button
${AMAZON_PRODUCT_TITLE}               h1[data-feature-name="title"]
${AMAZON_PRODUCT_PRICE}               span.a-price-whole

# Cart
${AMAZON_CART_BADGE}                  id=nav-cart-count
${AMAZON_CART_LINK}                   id=nav-cart
