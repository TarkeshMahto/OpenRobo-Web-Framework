*** Settings ***
Documentation     Example refactored regression tests using Page Object Model
Resource          ${EXECDIR}/resources/config/base.robot
Resource          ${EXECDIR}/resources/pages/amazon_home_page.robot
Resource          ${EXECDIR}/resources/pages/amazon_product_page.robot
Resource          ${EXECDIR}/resources/pages/amazon_cart_page.robot

Suite Setup       Open Browser    ${BASE_URL}    ${BROWSER_TYPE}
Suite Teardown    Close Browser


*** Test Cases ***
Search Functionality Works Using POM
    [Documentation]    Verify search returns results using POM
    [Tags]    regression    amazon    pom
    
    Open Amazon Home Page    ${BASE_URL}
    Search For Product    Robot Framework
    ${count}=    Get Search Result Count
    Should Be True    ${count} > 0
    Log    Found ${count} products

Navigate To Product Page Using POM
    [Documentation]    Verify navigation to product page works using POM
    [Tags]    regression    amazon    pom
    
    Open Amazon Home Page    ${BASE_URL}
    Search For Product    Python Book
    Click First Search Result
    Verify Product Page Loaded
    ${title}=    Get Product Title
    Should Not Be Empty    ${title}

Add Multiple Products To Cart Using POM
    [Documentation]    Verify multiple products can be added using POM
    [Tags]    regression    amazon    pom
    
    Open Amazon Home Page    ${BASE_URL}
    
    # Add first product
    Search For Product    Laptop
    Click First Search Result
    Add Product To Cart
    
    # Add second product
    Open Amazon Home Page    ${BASE_URL}
    Search For Product    Mouse
    Click First Search Result
    Add Product To Cart
    
    # Add third product
    Open Amazon Home Page    ${BASE_URL}
    Search For Product    Keyboard
    Click First Search Result
    Add Product To Cart
    
    # Verify cart count
    ${final_count}=    Get Cart Count
    Should Be Equal As Integers    ${final_count}    3

Verify Cart Persistence Using POM
    [Documentation]    Verify cart contents persist after navigation using POM
    [Tags]    regression    amazon    pom
    
    Open Amazon Home Page    ${BASE_URL}
    Search For Product    Monitor
    Click First Search Result
    Add Product To Cart
    
    ${initial_count}=    Get Cart Count
    Should Be Equal As Integers    ${initial_count}    1
    
    # Navigate away and back
    Open Amazon Home Page    ${BASE_URL}
    ${persisted_count}=    Get Cart Count
    Should Be Equal As Integers    ${persisted_count}    ${initial_count}

Search Result Accuracy Using POM
    [Documentation]    Verify search results match search term using POM
    [Tags]    regression    amazon    pom
    
    Open Amazon Home Page    ${BASE_URL}
    ${search_term}=    Set Variable    Graphics Card
    Search For Product    ${search_term}
    ${count}=    Get Search Result Count
    Should Be Greater Than    ${count}    0
    Log    Search for '${search_term}' returned ${count} results

Product Price Display Using POM
    [Documentation]    Verify product price is displayed correctly using POM
    [Tags]    regression    amazon    pom
    
    Open Amazon Home Page    ${BASE_URL}
    Search For Product    Wireless Mouse
    Click First Search Result
    Verify Product Page Loaded
    ${price}=    Get Product Price
    Should Not Be Empty    ${price}
    Log    Product price: ${price}

Product Rating Display Using POM
    [Documentation]    Verify product rating is displayed using POM
    [Tags]    regression    amazon    pom
    
    Open Amazon Home Page    ${BASE_URL}
    Search For Product    Mechanical Keyboard
    Click First Search Result
    Verify Product Page Loaded
    ${rating}=    Get Product Rating
    Should Not Be Empty    ${rating}
    Log    Product rating: ${rating}

Cart Item Removal Using POM
    [Documentation]    Verify items can be removed from cart using POM
    [Tags]    regression    amazon    pom
    
    Open Amazon Home Page    ${BASE_URL}
    Search For Product    USB Cable
    Click First Search Result
    Add Product To Cart
    
    Click Cart
    Verify Cart Page Loaded
    ${initial_count}=    Get Cart Item Count
    Should Be Greater Than    ${initial_count}    0
    
    Remove Item From Cart    1
    ${final_count}=    Get Cart Item Count
    Should Be Equal As Integers    ${final_count}    0
