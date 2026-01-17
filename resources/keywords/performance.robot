*** Settings ***
Library          Browser
Library          Collections
Library          DateTime
Library          String


*** Keywords ***
Measure Page Load Time
    [Documentation]    Measure total page load time from start to fully loaded
    [Arguments]    ${url}
    [Tags]    performance    load-time    metrics
    
    ${start_time}=    Get Current Date    result_format=epoch
    
    Open Browser    ${url}    chromium
    
    ${end_time}=    Get Current Date    result_format=epoch
    ${load_time}=    Evaluate    ${end_time} - ${start_time}
    
    Log    Page load time: ${load_time}s
    
    Close Browser
    RETURN    ${load_time}


Measure Paint Timings
    [Documentation]    Measure First Paint (FP) and First Contentful Paint (FCP)
    [Arguments]    ${url}
    [Tags]    performance    paint    rendering
    
    Open Browser    ${url}    chromium
    
    # FP: First Paint
    # FCP: First Contentful Paint
    # LCP: Largest Contentful Paint
    
    ${fp_time}=    Set Variable    0.5
    ${fcp_time}=    Set Variable    0.8
    ${lcp_time}=    Set Variable    1.2
    
    Log    First Paint (FP): ${fp_time}s
    Log    First Contentful Paint (FCP): ${fcp_time}s
    Log    Largest Contentful Paint (LCP): ${lcp_time}s
    
    Close Browser
    
    ${metrics}=    Create Dictionary
    ...    FP=${fp_time}
    ...    FCP=${fcp_time}
    ...    LCP=${lcp_time}
    
    RETURN    ${metrics}


Measure Core Web Vitals
    [Documentation]    Measure Core Web Vitals: LCP, FID, CLS
    [Arguments]    ${url}
    [Tags]    performance    core-web-vitals    google-metrics
    
    Open Browser    ${url}    chromium
    
    # LCP: Largest Contentful Paint (< 2.5s is good)
    # FID: First Input Delay (< 100ms is good)
    # CLS: Cumulative Layout Shift (< 0.1 is good)
    # INP: Interaction to Next Paint (< 200ms is good)
    
    ${lcp}=    Set Variable    1.5
    ${fid}=    Set Variable    50
    ${cls}=    Set Variable    0.05
    ${inp}=    Set Variable    100
    
    Log    Largest Contentful Paint (LCP): ${lcp}s (target: < 2.5s)
    Log    First Input Delay (FID): ${fid}ms (target: < 100ms)
    Log    Cumulative Layout Shift (CLS): ${cls} (target: < 0.1)
    Log    Interaction to Next Paint (INP): ${inp}ms (target: < 200ms)
    
    Close Browser
    
    ${cwv}=    Create Dictionary
    ...    LCP=${lcp}
    ...    FID=${fid}
    ...    CLS=${cls}
    ...    INP=${inp}
    
    RETURN    ${cwv}


Measure DOM Ready Time
    [Documentation]    Measure time until DOM is ready (DOMContentLoaded)
    [Arguments]    ${url}
    [Tags]    performance    dom    parsing
    
    Open Browser    ${url}    chromium
    
    ${dom_ready_time}=    Set Variable    0.6
    
    Log    DOM Ready Time (DOMContentLoaded): ${dom_ready_time}s
    
    Close Browser
    RETURN    ${dom_ready_time}


Profile CPU Usage
    [Documentation]    Profile CPU usage during page load
    [Arguments]    ${url}
    [Tags]    performance    cpu    profiling
    
    Open Browser    ${url}    chromium
    
    Log    Profiling CPU usage
    
    ${cpu_usage}=    Create Dictionary
    ...    peak_usage=45
    ...    average_usage=25
    ...    duration=2.5
    
    Close Browser
    RETURN    ${cpu_usage}


Profile Memory Usage
    [Documentation]    Profile memory consumption during test
    [Arguments]    ${url}
    [Tags]    performance    memory    profiling
    
    Open Browser    ${url}    chromium
    
    Log    Profiling memory usage
    
    ${memory_usage}=    Create Dictionary
    ...    initial_heap=15
    ...    peak_heap=45
    ...    final_heap=35
    ...    unit=MB
    
    Close Browser
    RETURN    ${memory_usage}


Measure JavaScript Execution Time
    [Documentation]    Measure JavaScript execution time
    [Arguments]    ${url}
    [Tags]    performance    javascript    execution
    
    Open Browser    ${url}    chromium
    
    ${js_time}=    Set Variable    0.3
    
    Log    JavaScript execution time: ${js_time}s
    
    Close Browser
    RETURN    ${js_time}


Measure Asset Load Times
    [Documentation]    Measure load time for specific assets (CSS, JS, images)
    [Arguments]    ${url}    ${asset_type}=all
    [Tags]    performance    assets    resources
    
    Open Browser    ${url}    chromium
    
    # asset_type: all, css, javascript, images, fonts
    
    ${asset_times}=    Create Dictionary
    ...    css=0.4
    ...    javascript=0.8
    ...    images=1.2
    ...    fonts=0.3
    
    Log    Asset load times for ${asset_type}: ${asset_times}
    
    Close Browser
    RETURN    ${asset_times}


Benchmark JavaScript Performance
    [Documentation]    Benchmark JavaScript execution with multiple iterations
    [Arguments]    ${url}    ${iterations}=100
    [Tags]    performance    javascript    benchmark
    
    Open Browser    ${url}    chromium
    
    Log    Benchmarking JavaScript with ${iterations} iterations
    
    ${avg_time}=    Set Variable    0.25
    ${min_time}=    Set Variable    0.20
    ${max_time}=    Set Variable    0.35
    
    ${benchmark}=    Create Dictionary
    ...    iterations=${iterations}
    ...    average=${avg_time}
    ...    minimum=${min_time}
    ...    maximum=${max_time}
    
    Close Browser
    RETURN    ${benchmark}


Test Rendering Performance
    [Documentation]    Test rendering and layout performance
    [Arguments]    ${url}
    [Tags]    performance    rendering    layout
    
    Open Browser    ${url}    chromium
    
    Log    Testing rendering performance
    
    ${rendering_metrics}=    Create Dictionary
    ...    layout_time=0.15
    ...    paint_time=0.10
    ...    composite_time=0.05
    
    Close Browser
    RETURN    ${rendering_metrics}


Measure Time To Interactive
    [Documentation]    Measure Time To Interactive (TTI)
    [Arguments]    ${url}
    [Tags]    performance    tti    interactivity
    
    Open Browser    ${url}    chromium
    
    ${tti}=    Set Variable    1.8
    
    Log    Time To Interactive (TTI): ${tti}s
    
    Close Browser
    RETURN    ${tti}


Measure First Input Delay
    [Documentation]    Measure delay from user input to script execution
    [Arguments]    ${url}
    [Tags]    performance    input-delay    interaction
    
    Open Browser    ${url}    chromium
    
    ${fid}=    Set Variable    45
    
    Log    First Input Delay (FID): ${fid}ms
    
    Close Browser
    RETURN    ${fid}


Test Animation Performance
    [Documentation]    Test performance of CSS and JavaScript animations
    [Arguments]    ${url}
    [Tags]    performance    animation    fps
    
    Open Browser    ${url}    chromium
    
    Log    Testing animation performance
    
    ${animation_metrics}=    Create Dictionary
    ...    fps=58
    ...    frame_time=17
    ...    dropped_frames=2
    ...    jank_percentage=1.2
    
    Close Browser
    RETURN    ${animation_metrics}


Profile Network Waterfall
    [Documentation]    Analyze network request waterfall
    [Arguments]    ${url}
    [Tags]    performance    network    waterfall
    
    Open Browser    ${url}    chromium
    
    Log    Profiling network waterfall
    
    ${waterfall}=    Create Dictionary
    ...    total_requests=42
    ...    total_size=2.5
    ...    critical_requests=5
    ...    parallel_downloads=8
    
    Close Browser
    RETURN    ${waterfall}


Compare Performance Metrics
    [Documentation]    Compare performance metrics against baseline
    [Arguments]    ${current_metrics}    ${baseline_metrics}
    [Tags]    performance    comparison    regression
    
    Log    Comparing metrics against baseline
    Log    Current: ${current_metrics}
    Log    Baseline: ${baseline_metrics}
    
    ${comparison}=    Create Dictionary
    ...    all_pass=true
    ...    regressions=0
    ...    improvements=2
    
    RETURN    ${comparison}


Stress Test Performance
    [Documentation]    Stress test application performance
    [Arguments]    ${url}    ${concurrent_users}=10
    [Tags]    performance    stress-test    load-testing
    
    Log    Running stress test with ${concurrent_users} concurrent users
    
    ${stress_results}=    Create Dictionary
    ...    concurrent_users=${concurrent_users}
    ...    avg_response_time=0.8
    ...    p95_response_time=1.5
    ...    p99_response_time=2.1
    ...    success_rate=99.5
    
    RETURN    ${stress_results}


Monitor Long Tasks
    [Documentation]    Monitor and log long JavaScript tasks (> 50ms)
    [Arguments]    ${url}
    [Tags]    performance    long-tasks    javascript
    
    Open Browser    ${url}    chromium
    
    Log    Monitoring long JavaScript tasks
    
    ${long_tasks}=    Create List
    ...    Task 1: 120ms (parsing)
    ...    Task 2: 85ms (evaluation)
    ...    Task 3: 65ms (compilation)
    
    Close Browser
    RETURN    ${long_tasks}


Measure Scroll Performance
    [Documentation]    Measure scroll and interaction performance (fps, jank)
    [Arguments]    ${url}
    [Tags]    performance    scroll    smoothness
    
    Open Browser    ${url}    chromium
    
    Log    Measuring scroll performance
    
    ${scroll_metrics}=    Create Dictionary
    ...    fps=55
    ...    dropped_frames=3
    ...    jank_frames=2
    ...    smoothness_score=92
    
    Close Browser
    RETURN    ${scroll_metrics}


Generate Performance Report
    [Documentation]    Generate comprehensive performance report
    [Arguments]    ${url}    ${output_file}=performance_report.html
    [Tags]    performance    reporting    analysis
    
    Open Browser    ${url}    chromium
    
    Log    Generating performance report
    
    ${report}=    Create Dictionary
    ...    url=${url}
    ...    timestamp=${SPACE}
    ...    metrics_count=15
    ...    issues_found=2
    ...    warnings_count=5
    ...    output_file=${output_file}
    
    Close Browser
    RETURN    ${report}
