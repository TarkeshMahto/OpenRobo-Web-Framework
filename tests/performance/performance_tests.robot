*** Settings ***
Documentation     Performance Testing Test Suite
...               Tests for performance metrics, optimization, and benchmarking
Library           BuiltIn
Library           Collections
Library           String
Resource          ${EXECDIR}/resources/config/base.robot
Resource          ${EXECDIR}/resources/keywords/performance.robot
Resource          ${EXECDIR}/resources/keywords/common.robot

Suite Setup       Log    Starting Performance Testing Suite
Suite Teardown    Log    Performance Testing Suite Complete


*** Test Cases ***
Test Page Load Time Measurement
    [Documentation]    Measure total page load time
    [Tags]    performance    load-time    metrics    smoke
    Log    Testing page load time measurement
    ${load_time}=    Measure Page Load Time    ${BASE_URL}
    Should Be Greater Than    ${load_time}    0


Test Paint Timings
    [Documentation]    Measure First Paint and First Contentful Paint
    [Tags]    performance    paint    rendering    metrics
    Log    Testing paint timings (FP, FCP, LCP)
    ${metrics}=    Measure Paint Timings    ${BASE_URL}
    Should Be A Dictionary    ${metrics}
    Should Contain    ${metrics}    FP
    Should Contain    ${metrics}    FCP
    Should Contain    ${metrics}    LCP


Test Core Web Vitals
    [Documentation]    Measure Core Web Vitals: LCP, FID, CLS, INP
    [Tags]    performance    core-web-vitals    google-metrics    important
    Log    Testing Core Web Vitals
    ${cwv}=    Measure Core Web Vitals    ${BASE_URL}
    Should Be A Dictionary    ${cwv}
    Should Contain    ${cwv}    LCP
    Should Contain    ${cwv}    FID
    Should Contain    ${cwv}    CLS
    Should Contain    ${cwv}    INP


Test DOM Ready Time
    [Documentation]    Measure time until DOM is ready
    [Tags]    performance    dom    parsing    metrics
    Log    Testing DOM ready time
    ${dom_time}=    Measure DOM Ready Time    ${BASE_URL}
    Should Be Greater Than    ${dom_time}    0


Test CPU Usage Profiling
    [Documentation]    Profile CPU usage during page load
    [Tags]    performance    cpu    profiling    advanced
    Log    Testing CPU usage profiling
    ${cpu_metrics}=    Profile CPU Usage    ${BASE_URL}
    Should Be A Dictionary    ${cpu_metrics}
    Should Contain    ${cpu_metrics}    peak_usage
    Should Contain    ${cpu_metrics}    average_usage


Test Memory Usage Profiling
    [Documentation]    Profile memory consumption during test
    [Tags]    performance    memory    profiling    advanced
    Log    Testing memory usage profiling
    ${memory_metrics}=    Profile Memory Usage    ${BASE_URL}
    Should Be A Dictionary    ${memory_metrics}
    Should Contain    ${memory_metrics}    initial_heap
    Should Contain    ${memory_metrics}    peak_heap
    Should Contain    ${memory_metrics}    final_heap


Test JavaScript Execution Time
    [Documentation]    Measure JavaScript execution time
    [Tags]    performance    javascript    execution    metrics
    Log    Testing JavaScript execution time
    ${js_time}=    Measure JavaScript Execution Time    ${BASE_URL}
    Should Be Greater Than    ${js_time}    0


Test Asset Load Times
    [Documentation]    Measure load time for CSS, JS, images, fonts
    [Tags]    performance    assets    resources    metrics
    Log    Testing asset load times
    ${asset_times}=    Measure Asset Load Times    ${BASE_URL}    all
    Should Be A Dictionary    ${asset_times}
    Should Contain    ${asset_times}    css
    Should Contain    ${asset_times}    javascript
    Should Contain    ${asset_times}    images


Test CSS Asset Load Time
    [Documentation]    Measure CSS asset load time
    [Tags]    performance    assets    css
    Log    Testing CSS asset load time
    ${asset_times}=    Measure Asset Load Times    ${BASE_URL}    css
    Should Be A Dictionary    ${asset_times}


Test JavaScript Asset Load Time
    [Documentation]    Measure JavaScript asset load time
    [Tags]    performance    assets    javascript
    Log    Testing JavaScript asset load time
    ${asset_times}=    Measure Asset Load Times    ${BASE_URL}    javascript
    Should Be A Dictionary    ${asset_times}


Test Image Asset Load Time
    [Documentation]    Measure image asset load time
    [Tags]    performance    assets    images
    Log    Testing image asset load time
    ${asset_times}=    Measure Asset Load Times    ${BASE_URL}    images
    Should Be A Dictionary    ${asset_times}


Test JavaScript Benchmark
    [Documentation]    Benchmark JavaScript performance
    [Tags]    performance    javascript    benchmark    advanced
    Log    Testing JavaScript benchmark
    ${benchmark}=    Benchmark JavaScript Performance    ${BASE_URL}    100
    Should Be A Dictionary    ${benchmark}
    Should Contain    ${benchmark}    average
    Should Contain    ${benchmark}    minimum
    Should Contain    ${benchmark}    maximum


Test Rendering Performance
    [Documentation]    Test rendering and layout performance
    [Tags]    performance    rendering    layout    metrics
    Log    Testing rendering performance
    ${rendering}=    Test Rendering Performance    ${BASE_URL}
    Should Be A Dictionary    ${rendering}
    Should Contain    ${rendering}    layout_time
    Should Contain    ${rendering}    paint_time


Test Time To Interactive
    [Documentation]    Measure Time To Interactive (TTI)
    [Tags]    performance    tti    interactivity    metrics
    Log    Testing Time To Interactive measurement
    ${tti}=    Measure Time To Interactive    ${BASE_URL}
    Should Be Greater Than    ${tti}    0


Test First Input Delay
    [Documentation]    Measure First Input Delay (FID)
    [Tags]    performance    fid    input-delay    metrics
    Log    Testing First Input Delay measurement
    ${fid}=    Measure First Input Delay    ${BASE_URL}
    Should Be Greater Than    ${fid}    0


Test Animation Performance
    [Documentation]    Test CSS and JavaScript animation performance
    [Tags]    performance    animation    fps    rendering
    Log    Testing animation performance
    ${animation}=    Test Animation Performance    ${BASE_URL}
    Should Be A Dictionary    ${animation}
    Should Contain    ${animation}    fps
    Should Contain    ${animation}    dropped_frames
    Should Contain    ${animation}    jank_percentage


Test Network Waterfall Analysis
    [Documentation]    Analyze network request waterfall
    [Tags]    performance    network    waterfall    advanced
    Log    Testing network waterfall profiling
    ${waterfall}=    Profile Network Waterfall    ${BASE_URL}
    Should Be A Dictionary    ${waterfall}
    Should Contain    ${waterfall}    total_requests
    Should Contain    ${waterfall}    total_size


Test Performance Metrics Comparison
    [Documentation]    Compare performance metrics against baseline
    [Tags]    performance    comparison    regression    advanced
    Log    Testing performance metrics comparison
    ${current}=    Create Dictionary    LCP=1.5    FID=50
    ${baseline}=    Create Dictionary    LCP=2.0    FID=100
    ${comparison}=    Compare Performance Metrics    ${current}    ${baseline}
    Should Be A Dictionary    ${comparison}


Test Stress Testing
    [Documentation]    Stress test application performance
    [Tags]    performance    stress-test    load-testing    advanced
    Log    Testing stress test with concurrent users
    ${results}=    Stress Test Performance    ${BASE_URL}    10
    Should Be A Dictionary    ${results}
    Should Contain    ${results}    concurrent_users
    Should Contain    ${results}    success_rate


Test Long Tasks Monitoring
    [Documentation]    Monitor long JavaScript tasks (> 50ms)
    [Tags]    performance    long-tasks    javascript    advanced
    Log    Testing long JavaScript task monitoring
    ${long_tasks}=    Monitor Long Tasks    ${BASE_URL}
    Should Be A List    ${long_tasks}


Test Scroll Performance
    [Documentation]    Measure scroll and interaction smoothness (FPS, jank)
    [Tags]    performance    scroll    smoothness    metrics
    Log    Testing scroll performance
    ${scroll}=    Measure Scroll Performance    ${BASE_URL}
    Should Be A Dictionary    ${scroll}
    Should Contain    ${scroll}    fps
    Should Contain    ${scroll}    dropped_frames


Test Performance Report Generation
    [Documentation]    Generate comprehensive performance report
    [Tags]    performance    reporting    analysis    advanced
    Log    Testing performance report generation
    ${report}=    Generate Performance Report    ${BASE_URL}    perf_report.html
    Should Be A Dictionary    ${report}
    Should Contain    ${report}    url
    Should Contain    ${report}    metrics_count


Test LCP Performance Target
    [Documentation]    Verify LCP is under target (2.5s)
    [Tags]    performance    lcp    core-web-vitals    validation
    Log    Validating LCP performance target
    ${cwv}=    Measure Core Web Vitals    ${BASE_URL}
    Should Be Less Than    ${cwv}[LCP]    2.5


Test FID Performance Target
    [Documentation]    Verify FID is under target (100ms)
    [Tags]    performance    fid    core-web-vitals    validation
    Log    Validating FID performance target
    ${cwv}=    Measure Core Web Vitals    ${BASE_URL}
    Should Be Less Than    ${cwv}[FID]    100


Test CLS Performance Target
    [Documentation]    Verify CLS is under target (0.1)
    [Tags]    performance    cls    core-web-vitals    validation
    Log    Validating CLS performance target
    ${cwv}=    Measure Core Web Vitals    ${BASE_URL}
    Should Be Less Than    ${cwv}[CLS]    0.1


Test INP Performance Target
    [Documentation]    Verify INP is under target (200ms)
    [Tags]    performance    inp    core-web-vitals    validation
    Log    Validating INP performance target
    ${cwv}=    Measure Core Web Vitals    ${BASE_URL}
    Should Be Less Than    ${cwv}[INP]    200
