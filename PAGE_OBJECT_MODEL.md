# Page Object Model (POM) Implementation Guide

## Overview

The OpenRobo Web Framework has been refactored to use the **Page Object Model (POM)** design pattern. This separates test logic from page-specific element locators and interactions, making tests more maintainable, readable, and scalable.

---

## Architecture

### Directory Structure

```
resources/
├── pages/
│   ├── base_page.robot           # Base page with common keywords
│   ├── amazon_home_page.robot    # Amazon home page object
│   ├── amazon_product_page.robot # Amazon product page object
│   ├── amazon_cart_page.robot    # Amazon shopping cart page object
│   └── [other_page].robot        # Additional page objects
├── keywords/
│   └── [shared keywords]
└── config/
    └── base.robot                 # Configuration and variables
```

### Page Object Files

Each page object file contains:
1. **Locators** - CSS/XPath selectors for page elements
2. **Keywords** - High-level actions for the page
3. **Verification** - Methods to verify page state

---

## Page Objects

### 1. Base Page (`base_page.robot`)

**Purpose**: Common functionality shared by all pages

**Key Features**:
- Page load waits and timeouts
- Common element interactions
- Utility methods for all pages

**Available Keywords**:
```robot
Wait For Page Load
Wait For Element Visible
Wait For Element Hidden
Get Element Text
Get Element Count
Click Element
Fill Text
Is Element Visible
Scroll To Element
Get Element Attribute
Navigate To
Get Current URL
Verify Page Loaded
```

**Example**:
```robot
Wait For Page Load                           # Waits for page to load
Click Element    ${SOME_BUTTON}              # Click any button
${text}=    Get Element Text    ${ELEMENT}   # Get text from element
```

---

### 2. Amazon Home Page (`amazon_home_page.robot`)

**Purpose**: Handle Amazon home page interactions

**Locators**:
- `${AMAZON_LOGO}` - Amazon logo/header
- `${AMAZON_SEARCH_BOX}` - Search input field
- `${AMAZON_SEARCH_BUTTON}` - Search submit button
- `${AMAZON_SEARCH_RESULTS}` - Search result items
- `${AMAZON_FIRST_RESULT}` - First search result
- `${AMAZON_CART_BADGE}` - Shopping cart counter
- `${AMAZON_ACCOUNT_MENU}` - Account menu link
- `${AMAZON_CART_LINK}` - Cart navigation link

**Available Keywords**:
```robot
Open Amazon Home Page
Verify Amazon Home Page Loaded
Search For Product
Verify Search Results Loaded
Get Search Result Count
Click First Search Result
Get Cart Count
Click Cart
Open Account Menu
Clear Search Box
```

**Example**:
```robot
Open Amazon Home Page    ${BASE_URL}
Search For Product    MacBook Pro
${count}=    Get Search Result Count
Click First Search Result
```

---

### 3. Amazon Product Page (`amazon_product_page.robot`)

**Purpose**: Handle product page interactions

**Locators**:
- `${AMAZON_PRODUCT_TITLE}` - Product title
- `${AMAZON_PRODUCT_PRICE}` - Product price
- `${AMAZON_PRODUCT_RATING}` - Product rating
- `${AMAZON_ADD_TO_CART_BTN_ALT}` - Add to cart button
- `${AMAZON_BUY_NOW_BUTTON}` - Buy now button
- `${AMAZON_PRODUCT_DESCRIPTION}` - Product description
- `${AMAZON_PRODUCT_IMAGE}` - Product image
- `${AMAZON_QUANTITY_SELECTOR}` - Quantity dropdown

**Available Keywords**:
```robot
Verify Product Page Loaded
Get Product Title
Get Product Price
Get Product Rating
Add Product To Cart
Wait For Add To Cart Success
Buy Now
Get Product Description
Set Product Quantity
View Product Image
Go Back To Search
```

**Example**:
```robot
Verify Product Page Loaded
${title}=    Get Product Title
${price}=    Get Product Price
Add Product To Cart
```

---

### 4. Amazon Cart Page (`amazon_cart_page.robot`)

**Purpose**: Handle shopping cart interactions

**Locators**:
- `${AMAZON_CART_ITEMS}` - Cart item containers
- `${AMAZON_CART_ITEM_TITLE}` - Item title in cart
- `${AMAZON_CART_ITEM_PRICE}` - Item price in cart
- `${AMAZON_CART_REMOVE_BUTTON}` - Remove button
- `${AMAZON_CART_QUANTITY}` - Quantity input
- `${AMAZON_CART_SUBTOTAL}` - Subtotal display
- `${AMAZON_PROCEED_TO_CHECKOUT}` - Checkout button
- `${AMAZON_SAVE_FOR_LATER}` - Save for later button

**Available Keywords**:
```robot
Verify Cart Page Loaded
Get Cart Item Count
Get Cart Item Title
Get Cart Item Price
Remove Item From Cart
Update Item Quantity
Get Cart Subtotal
Save Item For Later
Proceed To Checkout
Verify Cart Is Empty
Verify Cart Contains Items
```

**Example**:
```robot
Click Cart
Verify Cart Page Loaded
${count}=    Get Cart Item Count
${price}=    Get Cart Item Price    1
Remove Item From Cart    1
```

---

## Using Page Objects in Tests

### Basic Test Structure

```robot
*** Settings ***
Resource    ${EXECDIR}/resources/pages/amazon_home_page.robot
Resource    ${EXECDIR}/resources/pages/amazon_product_page.robot

*** Test Cases ***
Search And Add Product
    Open Amazon Home Page    ${BASE_URL}
    Search For Product    iPhone
    Click First Search Result
    Verify Product Page Loaded
    Add Product To Cart
```

### Benefits of POM

1. **Maintainability**: Element locators in one place, easy to update
2. **Readability**: Tests read like business requirements
3. **Reusability**: Page keywords can be used across multiple tests
4. **Scalability**: New tests can be added easily
5. **Reduced Code Duplication**: Common actions centralized

---

## Test Examples

### Smoke Tests (`amazon_search_pom.robot`)

Simple tests verifying basic functionality:

```robot
Search For Product Using POM
    Open Amazon Home Page    ${BASE_URL}
    Search For Product    MacBook Pro
    ${count}=    Get Search Result Count
    Should Be Greater Than    ${count}    0

Complete Shopping Workflow Using POM
    Open Amazon Home Page    ${BASE_URL}
    Search For Product    Laptop Stand
    Click First Search Result
    Verify Product Page Loaded
    Add Product To Cart
    Click Cart
    Verify Cart Page Loaded
```

### Regression Tests (`amazon_regression_pom.robot`)

Comprehensive tests verifying functionality doesn't break:

```robot
Search Functionality Works Using POM
    Open Amazon Home Page    ${BASE_URL}
    Search For Product    Robot Framework
    ${count}=    Get Search Result Count
    Should Be True    ${count} > 0

Add Multiple Products To Cart Using POM
    Open Amazon Home Page    ${BASE_URL}
    Search For Product    Laptop
    Click First Search Result
    Add Product To Cart
    # ... repeat for multiple products
    ${final_count}=    Get Cart Count
    Should Be Equal As Integers    ${final_count}    3
```

---

## Creating New Page Objects

### Step-by-Step Guide

1. **Create Page File**:
   ```bash
   touch resources/pages/my_page.robot
   ```

2. **Add Settings Section**:
   ```robot
   *** Settings ***
   Documentation     My Page Object
   Resource          base_page.robot
   ```

3. **Add Locators**:
   ```robot
   *** Variables ***
   ${MY_ELEMENT}     css=.my-class
   ${MY_BUTTON}      css=button[id="my-button"]
   ```

4. **Add Keywords**:
   ```robot
   *** Keywords ***
   My Action
       [Documentation]    Description of action
       Click Element    ${MY_BUTTON}
       Wait For Element Visible    ${RESULT}
   ```

5. **Use in Tests**:
   ```robot
   *** Settings ***
   Resource    resources/pages/my_page.robot
   
   *** Test Cases ***
   My Test
       My Action
   ```

---

## Best Practices

### 1. Locator Naming Convention

```robot
${PAGE_NAME_ELEMENT_TYPE}    selector

# Good
${AMAZON_HOME_SEARCH_BOX}
${PRODUCT_PAGE_ADD_TO_CART_BUTTON}
${CART_PAGE_REMOVE_BUTTON}

# Avoid
${search}
${btn}
${element}
```

### 2. Keyword Naming

- Use descriptive names that explain the action
- Start with action verb (Click, Fill, Verify, Get, etc.)
- Include page context

```robot
# Good
Click First Search Result
Verify Product Page Loaded
Get Cart Item Count
Add Product To Cart

# Avoid
Click1
Check
Count
Add
```

### 3. Page Object Organization

- One file per page/section
- Keep related functionality together
- Inherit from base_page for common functionality
- Use documentation strings

### 4. Test Organization

- One test per user story/scenario
- Use descriptive test names
- Keep tests focused and independent
- Use appropriate tags

```robot
Search For Product Using POM
    [Documentation]    User searches for product on Amazon home page
    [Tags]    smoke    amazon    pom    search
```

### 5. Handling Dynamic Content

```robot
*** Variables ***
# Good: Uses data-attributes or stable selectors
${SEARCH_RESULT}    css=div[data-component-type="s-search-result"]

# Acceptable: Uses classes
${BUTTON}           css=button.buy-button

# Avoid: Uses text or index-based selectors
${BUTTON}           xpath=//button[contains(text(), "Buy")]
```

---

## Running Tests with POM

### Run All POM Tests

```bash
poetry run robot tests/smoke/amazon_search_pom.robot
poetry run robot tests/regression/amazon_regression_pom.robot
```

### Run Specific Test Case

```bash
poetry run robot -t "Search For Product Using POM" tests/smoke/amazon_search_pom.robot
```

### Run Tests by Tag

```bash
poetry run robot -i pom tests/
poetry run robot -i smoke tests/
```

### Run with Output

```bash
poetry run robot --outputdir results tests/smoke/amazon_search_pom.robot
```

---

## Migration from Old to POM

### Before (Old Approach)

```robot
*** Test Cases ***
Search Test
    Open Browser    https://example.com    chromium
    Click    css=input[id="twotabsearchtextbox"]
    Fill Text    css=input[id="twotabsearchtextbox"]    iPhone
    Click    css=button[id="nav-search-submit-button"]
    Wait For Load State    networkidle
    ${count}=    Get Element Count    css=div[data-component-type="s-search-result"]
    Should Be Greater Than    ${count}    0
```

### After (POM Approach)

```robot
*** Settings ***
Resource    resources/pages/amazon_home_page.robot

*** Test Cases ***
Search Test
    Open Amazon Home Page    ${BASE_URL}
    Search For Product    iPhone
    ${count}=    Get Search Result Count
    Should Be Greater Than    ${count}    0
```

---

## Troubleshooting

### Locator Not Found

1. Check selector syntax in Variables section
2. Verify element exists on page (use browser dev tools)
3. Wait for element visibility before interaction
4. Check if element is in iframe (requires different approach)

### Keyword Not Found

1. Verify Resource import at top of test file
2. Check keyword spelling and case sensitivity
3. Ensure arguments match keyword definition

### Flaky Tests

1. Add explicit waits (Wait For Element Visible)
2. Use stable locators (data-attributes preferred)
3. Avoid hardcoded sleep times
4. Use appropriate timeouts

---

## Summary

The **Page Object Model** provides:
- ✅ Better code organization
- ✅ Easier maintenance
- ✅ Improved test readability
- ✅ Code reusability
- ✅ Reduced duplication
- ✅ Scalable test architecture

Start using POM for all new tests and gradually migrate existing tests for a more maintainable framework!
