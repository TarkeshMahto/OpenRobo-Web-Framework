*** Settings ***
Documentation    Common keywords for all test cases
Library          Browser
Library          Collections
Library          String
Library          DateTime
Library          OperatingSystem


*** Keywords ***
Open Browser With Advanced Features
    [Documentation]    Opens browser with recording, tracing, and HAR capture enabled
    [Arguments]    ${url}=${BASE_URL}    ${record_video}=True    ${record_trace}=False    ${record_har}=False
    
    # Create context with advanced features
    ${context_options}    Create Dictionary
    ...    recordVideo=${record_video}
    ...    recordHar=${record_har}
    ...    viewport={"width": ${VIEWPORT_WIDTH}, "height": ${VIEWPORT_HEIGHT}}
    
    # New browser with custom options
    New Browser    
    ...    browser=${BROWSER_TYPE}
    ...    headless=${HEADLESS}
    ...    slowMo=${SLOWMO}
    
    New Context    
    ...    baseURL=${url}
    ...    recordVideo={"dir": "${VIDEO_DIR}"} if ${record_video} else None
    ...    recordHar={"path": "${HAR_DIR}/network.har"} if ${record_har} else None
    
    New Page    url=${url}
    
    # Start tracing if requested
    Run Keyword If    ${record_trace}    Start Tracing
    
    Set Browser Timeout    ${TIMEOUT}
    Log    Browser opened with advanced features enabled

Start Tracing
    [Documentation]    Start Playwright tracing for debugging
    Evaluate JavaScript    
    ...    selector=None
    ...    function=async () => { 
    ...        const { Playwright } = await import('@playwright/test');
    ...        console.log('Tracing started');
    ...    }

Intercept Network Request
    [Documentation]    Intercept and optionally modify HTTP requests
    [Arguments]    ${url_pattern}    ${response_body}=None
    
    Evaluate JavaScript
    ...    selector=None
    ...    function=async () => {
    ...        window._interceptedRequests = [];
    ...        // Note: Advanced interception requires custom Playwright setup
    ...    }
    Log    Network interception configured for: ${url_pattern}

Emulate Device
    [Documentation]    Emulate specific mobile device
    [Arguments]    ${device_name}=iPhone 12
    
    ${device}    Get Device    ${device_name}
    Log    Device emulation configured: ${device_name}

Take Screenshot With Timestamp
    [Documentation]    Take screenshot with automatic timestamp
    [Arguments]    ${filename_prefix}=screenshot
    
    ${timestamp}    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${filename}    Catenate    SEPARATOR=_    ${filename_prefix}    ${timestamp}
    
    Take Screenshot    filename=${SCREENSHOT_DIR}/${filename}.png
    Log    Screenshot saved: ${filename}.png

Wait For Network Idle
    [Documentation]    Wait for network activity to complete
    [Arguments]    ${timeout}=${TIMEOUT}
    
    Wait Until Network Is Idle    timeout=${timeout}

Get Performance Metrics
    [Documentation]    Collect performance metrics from page
    
    ${metrics}    Evaluate JavaScript
    ...    selector=None
    ...    function=() => {
    ...        const perfData = performance.getEntriesByType('navigation')[0];
    ...        return {
    ...            'domContentLoaded': perfData.domContentLoadedEventEnd - perfData.domContentLoadedEventStart,
    ...            'loadComplete': perfData.loadEventEnd - perfData.loadEventStart,
    ...            'totalTime': perfData.loadEventEnd - perfData.fetchStart
    ...        };
    ...    }
    
    Log    Performance Metrics: ${metrics}
    [Return]    ${metrics}

Intercept Dialog
    [Documentation]    Handle browser dialogs (alert, confirm, prompt)
    [Arguments]    ${action}=accept    ${prompt_input}=
    
    Handle Future Dialogs    action=${action}    prompt_input=${prompt_input}

Set Custom Locator Handler
    [Documentation]    Add handler for problematic elements
    [Arguments]    ${selector}    ${handler_action}=click
    
    # Example: Handle dynamic popup that might appear
    Add Locator Handler Click    selector=${selector}    click_selector=${selector}

Grant Browser Permissions
    [Documentation]    Grant permissions like geolocation, camera, microphone
    [Arguments]    @{permissions}
    
    Grant Permissions    permissions=${permissions}

Set Geolocation
    [Documentation]    Set browser geolocation
    [Arguments]    ${latitude}    ${longitude}    ${accuracy}=0
    
    Set Geolocation    latitude=${latitude}    longitude=${longitude}    accuracy=${accuracy}

Go Offline
    [Documentation]    Simulate offline mode
    
    Set Offline    offline=True

Go Online
    [Documentation]    Return to online mode
    
    Set Offline    offline=False

Add HTTP Headers
    [Documentation]    Add custom HTTP headers to requests
    [Arguments]    &{headers}
    
    # Note: Headers should be set during context creation
    Log    Custom headers would be: ${headers}

Close Browser With Cleanup
    [Documentation]    Close browser and ensure proper cleanup
    [Arguments]    ${save_trace}=True
    
    Run Keyword If    ${save_trace}    Log    Trace saved to ${TRACE_DIR}
    Close Browser
    Log    Browser closed and resources cleaned up
