# Network & Performance Testing Guide

## Overview

The OpenRobo Web Framework includes comprehensive network testing and performance testing capabilities powered by Playwright's advanced features. These tools help you monitor, measure, and optimize application performance.

---

## Table of Contents

1. [Network Testing](#network-testing)
2. [Performance Testing](#performance-testing)
3. [Test Suites](#test-suites)
4. [Best Practices](#best-practices)
5. [Advanced Scenarios](#advanced-scenarios)

---

## Network Testing

### What is Network Testing?

Network testing monitors and validates:
- HTTP requests and responses
- API endpoints and status codes
- Network conditions and throttling
- Error handling and resilience
- Security headers and protocols
- Bandwidth and traffic analysis

### Network Testing Keywords

#### 1. Record Network Requests
Capture all network requests during test execution.

```robot
Record Network Requests    https://api.example.com    .*api.*
```

#### 2. Intercept Network Call
Intercept and modify network requests/responses.

```robot
Intercept Network Call    https://example.com    /api/users    {"status": "ok"}
```

#### 3. Capture Network HAR
Export network activity as HAR (HTTP Archive) format for analysis.

```robot
${har_file}=    Capture Network HAR    https://example.com    network.har
```

#### 4. Monitor Request Response Times
Measure time taken for requests to complete.

```robot
${response_time}=    Monitor Request Response Times    https://api.example.com    /data
```

#### 5. Check Network Status Codes
Validate HTTP response status codes.

```robot
${status}=    Check Network Status Codes    https://example.com    200
Should Be Equal As Integers    ${status}    200
```

#### 6. Simulate Network Throttling
Test application behavior under various network conditions.

```robot
# Available profiles: slow-4g, 4g, 3g, 2g
Simulate Network Throttling    https://example.com    slow-4g
```

**Network Profiles:**
- **slow-4g**: Latency=400ms, Download=400kbps, Upload=400kbps
- **4g**: Latency=50ms, Download=4Mbps, Upload=3Mbps
- **3g**: Latency=100ms, Download=1.6Mbps, Upload=400kbps
- **2g**: Latency=500ms, Download=400kbps, Upload=400kbps

#### 7. Test API Endpoint
Verify API endpoint availability and response.

```robot
${status}=    Test API Endpoint    https://api.example.com/v1/users    GET    200
${status}=    Test API Endpoint    https://api.example.com/v1/users    POST    201
```

#### 8. Verify Network Request Headers
Validate that request headers are sent correctly.

```robot
Verify Network Request Headers    https://example.com    Authorization    Bearer token123
Verify Network Request Headers    https://api.example.com    X-API-Key    secretkey
```

#### 9. Monitor Bandwidth Usage
Track network bandwidth consumption.

```robot
${bandwidth}=    Monitor Bandwidth Usage    https://example.com
Log    Total bytes: ${bandwidth}[total_bytes]
Log    Download speed: ${bandwidth}[download_speed]
```

#### 10. Test Network Failure Handling
Verify app behavior during network failures.

```robot
# Failure types: offline, timeout, connection-reset, dns-failed
Test Network Failure Handling    https://example.com    offline
Test Network Failure Handling    https://example.com    timeout
```

#### 11. Capture Network Errors
Log all network errors encountered.

```robot
${errors}=    Capture Network Errors    https://example.com
Log    Network errors: ${errors}
```

#### 12. Test DNS Resolution
Verify DNS resolution works correctly.

```robot
${resolved}=    Test DNS Resolution    example.com
Should Be True    ${resolved}
```

#### 13. Monitor WebSocket Connections
Track WebSocket traffic for real-time features.

```robot
Monitor WebSocket Connections    https://example.com    /socket.io
```

#### 14. Test CORS Headers
Validate Cross-Origin Resource Sharing configuration.

```robot
Test CORS Headers    https://api.example.com    https://example.com
```

#### 15. Measure Time To First Byte
Measure TTFB (how quickly server responds).

```robot
${ttfb}=    Measure Time To First Byte    https://example.com
Log    TTFB: ${ttfb}s
```

### Network Testing Examples

#### Complete API Testing Example
```robot
*** Test Cases ***
Test API With Network Monitoring
    [Tags]    api    network    smoke
    
    # Test endpoint availability
    ${status}=    Test API Endpoint    https://api.example.com/v1/data    GET    200
    Should Be Equal As Integers    ${status}    200
    
    # Verify headers
    Verify Network Request Headers    https://api.example.com    Authorization    Bearer token
    
    # Monitor response times
    ${response_time}=    Monitor Request Response Times    https://api.example.com    /data
    Should Be Less Than    ${response_time}    2.0
    
    # Test error handling
    Test Network Failure Handling    https://api.example.com    timeout
```

#### Network Resilience Testing
```robot
*** Test Cases ***
Test Network Resilience
    [Tags]    network    resilience    advanced
    
    # Test offline behavior
    Test Network Failure Handling    https://example.com    offline
    
    # Test connection reset
    Test Network Failure Handling    https://example.com    connection-reset
    
    # Capture any errors
    ${errors}=    Capture Network Errors    https://example.com
    Log    Errors encountered: ${errors}
```

---

## Performance Testing

### What is Performance Testing?

Performance testing measures and validates:
- Page load times
- Core Web Vitals (LCP, FID, CLS, INP)
- Asset load times
- CPU and memory usage
- Rendering performance
- JavaScript execution speed
- Animation smoothness

### Core Web Vitals

Google's Core Web Vitals are critical performance metrics:

| Metric | Good | Needs Work | Poor |
|--------|------|-----------|------|
| **LCP** (Largest Contentful Paint) | < 2.5s | 2.5s - 4s | > 4s |
| **FID** (First Input Delay) | < 100ms | 100ms - 300ms | > 300ms |
| **CLS** (Cumulative Layout Shift) | < 0.1 | 0.1 - 0.25 | > 0.25 |
| **INP** (Interaction to Next Paint) | < 200ms | 200ms - 500ms | > 500ms |

### Performance Testing Keywords

#### 1. Measure Page Load Time
Total time from navigation start to fully loaded.

```robot
${load_time}=    Measure Page Load Time    https://example.com
Log    Page load time: ${load_time}s
```

#### 2. Measure Paint Timings
First Paint (FP), First Contentful Paint (FCP), and Largest Contentful Paint (LCP).

```robot
${metrics}=    Measure Paint Timings    https://example.com
Log    FP: ${metrics}[FP]s
Log    FCP: ${metrics}[FCP]s
Log    LCP: ${metrics}[LCP]s
```

#### 3. Measure Core Web Vitals
All four key metrics: LCP, FID, CLS, INP.

```robot
${cwv}=    Measure Core Web Vitals    https://example.com
Log    LCP: ${cwv}[LCP]s
Log    FID: ${cwv}[FID]ms
Log    CLS: ${cwv}[CLS]
Log    INP: ${cwv}[INP]ms
```

#### 4. Measure DOM Ready Time
Time until DOM is ready (DOMContentLoaded event).

```robot
${dom_time}=    Measure DOM Ready Time    https://example.com
Log    DOM ready: ${dom_time}s
```

#### 5. Profile CPU Usage
Monitor CPU usage during execution.

```robot
${cpu}=    Profile CPU Usage    https://example.com
Log    Peak: ${cpu}[peak_usage]%
Log    Average: ${cpu}[average_usage]%
```

#### 6. Profile Memory Usage
Track memory consumption in MB.

```robot
${memory}=    Profile Memory Usage    https://example.com
Log    Initial heap: ${memory}[initial_heap]MB
Log    Peak heap: ${memory}[peak_heap]MB
Log    Final heap: ${memory}[final_heap]MB
```

#### 7. Measure JavaScript Execution Time
Time spent executing JavaScript.

```robot
${js_time}=    Measure JavaScript Execution Time    https://example.com
Log    JS execution: ${js_time}s
```

#### 8. Measure Asset Load Times
Load times for CSS, JavaScript, images, fonts.

```robot
${assets}=    Measure Asset Load Times    https://example.com    all
Log    CSS: ${assets}[css]s
Log    JS: ${assets}[javascript]s
Log    Images: ${assets}[images]s
```

#### 9. Benchmark JavaScript Performance
Benchmark JS execution across multiple iterations.

```robot
${bench}=    Benchmark JavaScript Performance    https://example.com    100
Log    Average: ${bench}[average]s
Log    Min: ${bench}[minimum]s
Log    Max: ${bench}[maximum]s
```

#### 10. Test Rendering Performance
Layout, paint, and composite times.

```robot
${rendering}=    Test Rendering Performance    https://example.com
Log    Layout: ${rendering}[layout_time]s
Log    Paint: ${rendering}[paint_time]s
```

#### 11. Measure Time To Interactive
Time until page is fully interactive.

```robot
${tti}=    Measure Time To Interactive    https://example.com
Log    Time to Interactive: ${tti}s
```

#### 12. Test Animation Performance
FPS, frame time, and jank metrics.

```robot
${animation}=    Test Animation Performance    https://example.com
Log    FPS: ${animation}[fps]
Log    Jank: ${animation}[jank_percentage]%
```

#### 13. Profile Network Waterfall
Analyze resource loading sequence.

```robot
${waterfall}=    Profile Network Waterfall    https://example.com
Log    Total requests: ${waterfall}[total_requests]
Log    Total size: ${waterfall}[total_size]MB
```

#### 14. Stress Test Performance
Test under concurrent load.

```robot
${stress}=    Stress Test Performance    https://example.com    10
Log    Success rate: ${stress}[success_rate]%
Log    Avg response: ${stress}[avg_response_time]s
```

#### 15. Generate Performance Report
Create comprehensive performance analysis.

```robot
${report}=    Generate Performance Report    https://example.com    report.html
Log    Report saved to: ${report}[output_file]
```

### Performance Testing Examples

#### Complete Performance Audit
```robot
*** Test Cases ***
Comprehensive Performance Audit
    [Tags]    performance    audit    advanced
    
    # Measure Core Web Vitals
    ${cwv}=    Measure Core Web Vitals    https://example.com
    Log    LCP: ${cwv}[LCP]s (target: < 2.5s)
    Log    FID: ${cwv}[FID]ms (target: < 100ms)
    Log    CLS: ${cwv}[CLS] (target: < 0.1)
    
    # Validate against targets
    Should Be Less Than    ${cwv}[LCP]    2.5
    Should Be Less Than    ${cwv}[FID]    100
    Should Be Less Than    ${cwv}[CLS]    0.1
    
    # Measure load times
    ${load_time}=    Measure Page Load Time    https://example.com
    Log    Page load: ${load_time}s
    
    # Profile resources
    ${assets}=    Measure Asset Load Times    https://example.com
    Log    CSS: ${assets}[css]s
    Log    JS: ${assets}[javascript]s
    
    # Monitor system
    ${memory}=    Profile Memory Usage    https://example.com
    Log    Peak memory: ${memory}[peak_heap]MB
```

#### Performance Regression Testing
```robot
*** Test Cases ***
Performance Regression Check
    [Tags]    performance    regression    smoke
    
    # Get current metrics
    ${current}=    Measure Core Web Vitals    https://example.com
    
    # Define baseline
    ${baseline}=    Create Dictionary
    ...    LCP=2.0
    ...    FID=80
    ...    CLS=0.08
    ...    INP=150
    
    # Compare
    ${comparison}=    Compare Performance Metrics    ${current}    ${baseline}
    Log    ${comparison}
    
    # Assert no regression
    Should Not Be True    ${comparison}[regressions] > 0
```

---

## Test Suites

### Network Testing Suite
Location: `tests/network/network_tests.robot`

Run network tests:
```bash
poetry run robot tests/network/network_tests.robot
```

Run specific network tests:
```bash
# Throttling tests
poetry run robot -i throttling tests/network/

# API tests
poetry run robot -i api tests/network/

# Error handling
poetry run robot -i error-handling tests/network/
```

### Performance Testing Suite
Location: `tests/performance/performance_tests.robot`

Run performance tests:
```bash
poetry run robot tests/performance/performance_tests.robot
```

Run specific performance tests:
```bash
# Core Web Vitals only
poetry run robot -i core-web-vitals tests/performance/

# Asset performance
poetry run robot -i assets tests/performance/

# Stress testing
poetry run robot -i stress-test tests/performance/
```

---

## Best Practices

### Network Testing Best Practices

1. **Monitor Real User Conditions**
   ```robot
   # Test on slow networks
   Simulate Network Throttling    ${URL}    slow-4g
   ```

2. **Verify Error Handling**
   ```robot
   Test Network Failure Handling    ${URL}    offline
   Test Network Failure Handling    ${URL}    timeout
   ```

3. **Validate Security Headers**
   ```robot
   Verify Network Request Headers    ${URL}    X-Security-Header    value
   Test CORS Headers    ${URL}    ${ORIGIN}
   ```

4. **Track API Performance**
   ```robot
   ${time}=    Monitor Request Response Times    ${API_URL}    /endpoint
   Should Be Less Than    ${time}    1.0    # < 1 second
   ```

### Performance Testing Best Practices

1. **Test Core Web Vitals**
   ```robot
   ${cwv}=    Measure Core Web Vitals    ${URL}
   Should Be Less Than    ${cwv}[LCP]    2.5
   Should Be Less Than    ${cwv}[FID]    100
   Should Be Less Than    ${cwv}[CLS]    0.1
   ```

2. **Profile Resources**
   ```robot
   ${memory}=    Profile Memory Usage    ${URL}
   ${cpu}=    Profile CPU Usage    ${URL}
   Should Be Less Than    ${memory}[peak_heap]    100    # MB
   Should Be Less Than    ${cpu}[peak_usage]    80    # %
   ```

3. **Compare Against Baseline**
   ```robot
   ${current}=    Measure Core Web Vitals    ${URL}
   ${baseline}=    Create Dictionary    LCP=2.0    FID=80
   Compare Performance Metrics    ${current}    ${baseline}
   ```

4. **Test Under Load**
   ```robot
   ${results}=    Stress Test Performance    ${URL}    10
   Should Be Greater Than    ${results}[success_rate]    95
   ```

---

## Advanced Scenarios

### Scenario 1: E-Commerce Performance Testing
```robot
*** Test Cases ***
E-Commerce Performance Check
    [Tags]    performance    ecommerce
    
    # Product page load
    ${load}=    Measure Page Load Time    https://shop.example.com/product/123
    Should Be Less Than    ${load}    3.0
    
    # Core Web Vitals
    ${cwv}=    Measure Core Web Vitals    https://shop.example.com/product/123
    Should Be Less Than    ${cwv}[LCP]    2.5
    
    # Image optimization
    ${assets}=    Measure Asset Load Times    https://shop.example.com    images
    Should Be Less Than    ${assets}[images]    1.5
```

### Scenario 2: API Performance Under Load
```robot
*** Test Cases ***
API Load Testing
    [Tags]    api    network    stress
    
    # Test with normal load
    ${normal}=    Monitor Request Response Times    https://api.example.com    /users
    
    # Test under stress (10 concurrent)
    ${stress}=    Stress Test Performance    https://api.example.com    10
    Should Be Greater Than    ${stress}[success_rate]    99
    Should Be Less Than    ${stress}[avg_response_time]    1.0
```

### Scenario 3: Network Resilience Testing
```robot
*** Test Cases ***
Network Resilience Check
    [Tags]    network    resilience
    
    # Test on slow network
    Simulate Network Throttling    https://example.com    slow-4g
    
    # Test offline behavior
    Test Network Failure Handling    https://example.com    offline
    
    # Verify error capture
    ${errors}=    Capture Network Errors    https://example.com
    Log    Errors: ${errors}
```

---

## Integration with CI/CD

### GitHub Actions Example
```yaml
- name: Run Network Tests
  run: poetry run robot tests/network/

- name: Run Performance Tests
  run: poetry run robot tests/performance/
```

### Jenkins Example
```groovy
stage('Network Tests') {
    steps {
        sh 'poetry run robot tests/network/'
    }
}

stage('Performance Tests') {
    steps {
        sh 'poetry run robot tests/performance/'
    }
}
```

---

## Troubleshooting

### Network Tests Failing

**Issue:** Cannot capture network requests  
**Solution:** Ensure `headless=false` in browser configuration

**Issue:** Throttling not working  
**Solution:** Only works with Chromium browser, not Firefox or WebKit

### Performance Tests Taking Too Long

**Issue:** Tests are slow  
**Solution:** Run only specific test tags: `poetry run robot -i core-web-vitals tests/performance/`

**Issue:** High memory usage  
**Solution:** Limit concurrent executions with `--processes 1`

---

## Resources

- [Network Testing with Playwright](https://playwright.dev/docs/api/class-brusercontext#browser-context-route)
- [Web Performance APIs](https://developer.mozilla.org/en-US/docs/Web/API/Performance)
- [Core Web Vitals Guide](https://web.dev/vitals/)
- [Google Lighthouse](https://developers.google.com/web/tools/lighthouse)

---

**Ready to test network and performance? Start with `tests/network/` or `tests/performance/`! 🚀**
