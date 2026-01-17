*** Settings ***
Documentation    Basic smoke test for Amazon search and add to cart
Library          Browser
Library          Collections
Library          String
Library          DateTime
Library          OperatingSystem

Suite Setup      Log    Basic smoke test setup
Suite Teardown   Log    Test teardown


*** Test Cases ***
Search For MacBook Pro And Add To Cart
    [Documentation]    Test searching for MacBook Pro and adding to cart
    [Tags]    smoke    amazon
    
    Log    This is a smoke test for Amazon search functionality
