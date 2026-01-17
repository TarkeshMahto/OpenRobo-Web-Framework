*** Settings ***
Documentation     Example refactored smoke test using Page Object Model
Library           BuiltIn
Resource          ${EXECDIR}/resources/config/base.robot
Resource          ${EXECDIR}/resources/pages/amazon_home_page.robot
Resource          ${EXECDIR}/resources/pages/amazon_product_page.robot
Resource          ${EXECDIR}/resources/pages/amazon_cart_page.robot

Suite Setup       Open Browser    ${BASE_URL}    ${BROWSER_TYPE}
Suite Teardown    Close Browser


*** Test Cases ***
Search For Product Using POM
    [Documentation]    Test searching for product using Page Object Model
    [Tags]    smoke    amazon    pom
    
    # Using Home Page object
    Open Amazon Home Page    ${BASE_URL}
    Search For Product    MacBook Pro
    
    # Verify results
    ${count}=    Get Search Result Count
    Should Be Greater Than    ${count}    0
    Log    Found ${count} MacBook Pro results

Click First Product Using POM
    [Documentation]    Test clicking first product using POM
    [Tags]    smoke    amazon    pom
    
    Open Amazon Home Page    ${BASE_URL}
    Search For Product    iPhone
    Click First Search Result
    
    # Using Product Page object
    Verify Product Page Loaded
    ${title}=    Get Product Title
    Should Contain    ${title}    iPhone

Add Product To Cart Using POM
    [Documentation]    Test adding product to cart using POM
    [Tags]    smoke    amazon    pom
    
    Open Amazon Home Page    ${BASE_URL}
    Search For Product    AirPods
    Click First Search Result
    
    Verify Product Page Loaded
    Add Product To Cart
    
    # Verify cart was updated
    ${cart_count}=    Get Cart Count
    Should Be Equal As Integers    ${cart_count}    1

View Cart Using POM
    [Documentation]    Test viewing cart using POM
    [Tags]    smoke    amazon    pom
    
    Open Amazon Home Page    ${BASE_URL}
    Search For Product    iPad
    Click First Search Result
    Add Product To Cart
    
    Click Cart
    Verify Cart Page Loaded
    Verify Cart Contains Items

Complete Shopping Workflow Using POM
    [Documentation]    Test complete shopping workflow using POM
    [Tags]    smoke    amazon    pom    workflow
    
    # 1. Search for product
    Open Amazon Home Page    ${BASE_URL}
    Search For Product    Laptop Stand
    ${result_count}=    Get Search Result Count
    Should Be Greater Than    ${result_count}    0
    
    # 2. Click first product
    Click First Search Result
    Verify Product Page Loaded
    ${product_title}=    Get Product Title
    Log    Selected product: ${product_title}
    
    # 3. Add to cart
    Add Product To Cart
    ${cart_count}=    Get Cart Count
    Should Be Equal As Integers    ${cart_count}    1
    
    # 4. View cart
    Click Cart
    Verify Cart Page Loaded
    ${cart_item_title}=    Get Cart Item Title    1
    Should Be Equal    ${cart_item_title}    ${product_title}
