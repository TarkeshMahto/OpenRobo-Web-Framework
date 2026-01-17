*** Settings ***
Documentation    Advanced feature demonstrations
Resource         ../config/base.robot
Resource         ../keywords/common.robot

Suite Setup      Open Browser With Advanced Features    https://www.amazon.com    ${True}    ${True}    ${True}
Suite Teardown   Close Browser With Cleanup


*** Test Cases ***
Test Network Interception And HAR Recording
    [Documentation]    Demonstrate network interception and HAR file recording
    [Tags]    advanced    network
    
    Go To    https://www.amazon.com
    Intercept Network Request    **/*.js
    Take Screenshot With Timestamp    network_test
    Log    Network activity captured in HAR file

Test JavaScript Execution And Performance Metrics
    [Documentation]    Execute custom JavaScript and measure performance
    [Tags]    advanced    performance
    
    Go To    https://www.amazon.com
    ${metrics}    Get Performance Metrics
    Log    Performance metrics retrieved: ${metrics}
    Take Screenshot With Timestamp    performance_test

Test Browser Dialog Handling
    [Documentation]    Handle browser dialogs (alerts, confirms, prompts)
    [Tags]    advanced    dialogs
    
    Go To    https://www.amazon.com
    # Intercept dialog handler
    Intercept Dialog    action=accept
    Take Screenshot With Timestamp    dialog_test

Test Geolocation And Permissions
    [Documentation]    Test geolocation and permission granting
    [Tags]    advanced    geolocation
    
    Go To    https://www.amazon.com
    # Set geolocation to New York
    Set Geolocation    40.7128    -74.0060    0
    Grant Browser Permissions    geolocation    notifications
    Take Screenshot With Timestamp    geolocation_test

Test Offline Mode
    [Documentation]    Test offline simulation
    [Tags]    advanced    offline
    
    Go To    https://www.amazon.com
    Take Screenshot With Timestamp    online_state
    
    Go Offline
    Sleep    1s
    Take Screenshot With Timestamp    offline_state
    
    Go Online
    Sleep    1s
    Take Screenshot With Timestamp    back_online_state

Test Multi-Browser Testing
    [Documentation]    Test with different browsers
    [Tags]    advanced    multi-browser
    
    New Browser    browser=firefox    headless=True
    New Context
    New Page    url=https://www.amazon.com
    Take Screenshot With Timestamp    firefox_test
    Close Browser

Test Device Emulation
    [Documentation]    Test with emulated mobile device
    [Tags]    advanced    device-emulation
    
    New Browser    browser=chromium    headless=True
    New Context
    New Page    url=https://www.amazon.com
    Set Viewport Size    width=375    height=667
    Take Screenshot With Timestamp    mobile_test
    Close Browser

Test Storage State Management
    [Documentation]    Save and reuse browser storage state
    [Tags]    advanced    storage
    
    Go To    https://www.amazon.com
    # Simulate user actions that set cookies/storage
    Evaluate JavaScript    
    ...    selector=None
    ...    function=() => {
    ...        localStorage.setItem('test_key', 'test_value');
    ...        return true;
    ...    }
    
    Save Storage State
    Take Screenshot With Timestamp    storage_state_test

Test Custom Locator Handler
    [Documentation]    Handle dynamic elements with custom handlers
    [Tags]    advanced    locator-handler
    
    Go To    https://www.amazon.com
    Set Custom Locator Handler    selector=.dynamic-popup    handler_action=click
    Take Screenshot With Timestamp    locator_handler_test

Test Network Idle Wait
    [Documentation]    Wait for network to become idle
    [Tags]    advanced    network-idle
    
    Go To    https://www.amazon.com
    Wait For Network Idle    timeout=10s
    Take Screenshot With Timestamp    network_idle_test
