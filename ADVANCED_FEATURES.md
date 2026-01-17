# OpenRobo Web Framework

A professional, production-ready Robot Framework with robotframework-browser featuring advanced automation capabilities.

## Features

### Core Features
- **Web UI Automation** with robotframework-browser (Chromium, Firefox, WebKit)
- **API Testing** with robotframework-requests
- **Desktop Automation** with robotframework-imagehorizonlibrary
- **Modern Test Structure** with organized keywords, configs, and tests

### Advanced Features

#### 1. **Network Interception & HAR Recording**
- Capture network requests/responses
- Analyze performance through HAR files
- Mock API responses
- Intercept and modify requests

#### 2. **JavaScript Execution**
- Execute custom JavaScript during tests
- Interact with complex SPAs
- Manipulate DOM directly
- Set/get browser state

#### 3. **Device Emulation**
- Test on mobile devices (iPhone, Android)
- Test on tablets and desktops
- Simulate different screen sizes
- Test responsive design

#### 4. **Recording & Tracing**
- Video recordings of test execution
- Playwright trace files for debugging
- HAR file recording for network analysis
- Screenshot capture with timestamps

#### 5. **Persistent Storage & Sessions**
- Save and restore browser context state
- Preserve cookies and localStorage
- Reuse authentication sessions
- Reduce test execution time

#### 6. **Custom Locator Handlers**
- Handle dynamic/problematic elements
- Auto-retry with fallback selectors
- Bypass authentication popups
- Handle unpredictable UI changes

#### 7. **Context Isolation**
- Run multiple browser contexts
- Test concurrent user scenarios
- Parallel test execution
- Isolated browser state per test

#### 8. **Geolocation & Permissions**
- Set geolocation coordinates
- Grant/deny browser permissions
- Test location-based features
- Simulate permission flows

#### 9. **Performance Monitoring**
- Measure page load times
- Analyze Core Web Vitals
- Monitor network performance
- Detect performance regressions

#### 10. **Multi-Browser Testing**
- Run tests on Chromium, Firefox, WebKit
- Test cross-browser compatibility
- Browser-specific feature testing
- Performance comparisons

## Project Structure

```
openrobo-web-framework/
├── resources/
│   ├── config/
│   │   ├── base.robot              # Base configuration
│   │   ├── environments.robot      # Environment configs (dev/staging/prod)
│   │   └── locators.robot          # Web element locators
│   ├── keywords/
│   │   ├── common.robot            # Common advanced keywords
│   │   └── amazon.robot            # Application-specific keywords
│   └── libraries/                  # Custom Python libraries (future)
├── tests/
│   ├── smoke/                      # Quick smoke tests
│   │   └── amazon_search.robot
│   ├── regression/                 # Full regression suite
│   └── advanced/                   # Advanced feature demonstrations
│       └── advanced_features.robot
├── results/
│   ├── screenshots/                # Screenshot artifacts
│   ├── videos/                     # Video recordings
│   ├── har/                        # Network HAR files
│   └── traces/                     # Playwright trace files
├── pyproject.toml                  # Poetry dependencies
├── robot.ini                       # Robot Framework config
├── run_tests.sh                    # Test runner (Unix/Linux/Mac)
├── run_tests.bat                   # Test runner (Windows)
└── README.md                       # This file
```

## Installation

### 1. Install Poetry (if not already installed)
```bash
curl -sSL https://install.python-poetry.org | python3 -
```

### 2. Install Dependencies with Poetry
```bash
poetry install
```

### 3. Activate Virtual Environment
```bash
poetry shell
```

### 4. Initialize Browser Library
```bash
rfbrowser init
```

## Running Tests

### Run All Smoke Tests
```bash
robot --outputdir results/smoke tests/smoke/
```

### Run Advanced Features Only
```bash
robot --outputdir results/advanced --include advanced tests/advanced/
```

### Run Specific Test File
```bash
robot --outputdir results tests/smoke/amazon_search.robot
```

### Run with Custom Variables
```bash
robot -v HEADLESS:True -v BROWSER_TYPE:firefox tests/smoke/
```

### Run with Video Recording
```bash
robot -v VIDEO_DIR:./results/videos tests/smoke/
```

### Run with HAR Recording
```bash
robot -v HAR_DIR:./results/har tests/advanced/advanced_features.robot
```

### Generate HTML Reports
```bash
robot --outputdir results --output output.xml --report report.html --log log.html tests/
```

## Configuration

### Environment Variables
Modify `resources/config/environments.robot` to set different endpoints:

```robot
${DEV_BASE_URL}       https://www.amazon.com
${STAGING_BASE_URL}   https://staging.amazon.com
${PROD_BASE_URL}      https://www.amazon.com
```

### Browser Settings
Modify `resources/config/base.robot`:

```robot
${HEADLESS}           False          # Show/hide browser
${BROWSER_TYPE}       chromium       # chromium, firefox, webkit
${SLOWMO}             0              # Add delay (ms)
${TIMEOUT}            30s            # Default timeout
```

### Output Directories
All outputs are saved to `results/`:
- `results/screenshots/` - Screenshots
- `results/videos/` - Video recordings
- `results/har/` - Network recordings
- `results/traces/` - Playwright traces

## Advanced Features Usage

### 1. Network Interception Example
```robot
Test Network Features
    Open Browser With Advanced Features    ${BASE_URL}    ${True}    ${True}    ${True}
    Intercept Network Request    **/*.js
    Go To    ${BASE_URL}
    # Network activity captured in HAR file
    Close Browser With Cleanup
```

### 2. Performance Monitoring Example
```robot
Test Performance
    Open Browser With Advanced Features    ${BASE_URL}
    Go To    ${BASE_URL}
    ${metrics}    Get Performance Metrics
    Log    ${metrics}
```

### 3. Mobile Device Emulation Example
```robot
Test Mobile Device
    New Browser    browser=chromium    headless=True
    New Context
    New Page    url=${BASE_URL}
    Set Viewport Size    width=375    height=667
    # Run tests on mobile viewport
```

### 4. Geolocation Testing Example
```robot
Test Geolocation Features
    Open Browser With Advanced Features    ${BASE_URL}
    Set Geolocation    40.7128    -74.0060    0
    Grant Browser Permissions    geolocation    notifications
    # Test location-based features
```

## Keyword Reference

### Common Keywords (Advanced Features)
- `Open Browser With Advanced Features` - Open browser with recording/tracing
- `Start Tracing` - Begin Playwright tracing
- `Intercept Network Request` - Capture network requests
- `Emulate Device` - Emulate mobile device
- `Take Screenshot With Timestamp` - Screenshot with timestamp
- `Wait For Network Idle` - Wait for network to complete
- `Get Performance Metrics` - Retrieve performance data
- `Intercept Dialog` - Handle browser dialogs
- `Set Geolocation` - Set browser location
- `Grant Browser Permissions` - Grant permissions
- `Go Offline` / `Go Online` - Simulate offline mode
- `Close Browser With Cleanup` - Cleanup resources

### Amazon Keywords
- `Search For Product` - Search Amazon product
- `Click First Product In Results` - Click first search result
- `Add Current Product To Cart` - Add to cart
- `Verify Product Added To Cart` - Verify cart update
- `Search And Add To Cart` - Complete flow

## Best Practices

1. **Use Page Object Keywords** - Keep selectors in `locators.robot`
2. **Organize by Feature** - Group related tests in subdirectories
3. **Use Tags** - Tag tests for easy filtering (smoke, regression, etc.)
4. **Error Handling** - Use `Run Keyword If` for conditional flows
5. **Screenshot on Failure** - Automatic screenshots for debugging
6. **Wait for Elements** - Always wait for elements to be visible/ready
7. **Clean up Resources** - Close browsers in teardown
8. **Version Control** - Commit everything except results/

## Troubleshooting

### Browser Won't Start
```bash
rfbrowser init  # Reinstall browser binaries
```

### Test Timeout
Increase timeout:
```bash
robot -v TIMEOUT:60s tests/
```

### Screenshots Not Saving
Ensure `results/screenshots/` directory exists:
```bash
mkdir -p results/{screenshots,videos,har,traces}
```

### Network Recording Issues
Check HAR directory permissions:
```bash
chmod 777 results/har/
```

## Next Steps

1. **Customize Locators** - Update `resources/config/locators.robot` for your application
2. **Add More Tests** - Create test cases in `tests/smoke/` and `tests/regression/`
3. **Create Keywords** - Add application-specific keywords in `resources/keywords/`
4. **Integrate CI/CD** - Add to GitHub Actions, Jenkins, etc.
5. **Performance Baselines** - Establish performance benchmarks
6. **Custom Libraries** - Add Python libraries in `resources/libraries/`

## Resources

- [Robot Framework Documentation](https://robotframework.org)
- [Browser Library Documentation](https://robotframework-browser.org)
- [Playwright Documentation](https://playwright.dev)
- [Robot Framework Best Practices](https://github.com/MarketSquare/robotframework-browser/wiki)

## License

MIT License - See LICENSE file for details

## Support

For issues, questions, or contributions, please visit the project repository.

---

Happy Testing! 🚀
