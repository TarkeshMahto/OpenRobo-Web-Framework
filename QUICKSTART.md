# OpenRobo Web Framework - Setup & Quick Start Guide

## What You Just Set Up

You now have a **professional Robot Framework** with advanced Browser Library features including:

✅ **Network Recording & Analysis** (HAR files)
✅ **Video Recording** (test execution)
✅ **JavaScript Execution** (DOM manipulation)
✅ **Device Emulation** (mobile testing)
✅ **Geolocation & Permissions** (location-based features)
✅ **Offline Mode Simulation** (offline testing)
✅ **Multi-Browser Testing** (Chromium, Firefox, WebKit)
✅ **Performance Monitoring** (load times, metrics)
✅ **Custom Locator Handlers** (dynamic elements)
✅ **Storage State Management** (session persistence)

---

## Quick Start (5 Minutes)

### Step 1: Navigate to Project
```bash
cd /workspaces/OpenRobo-Web-Framework
```

### Step 2: Install with Poetry
```bash
poetry install
poetry shell
```

### Step 3: Run a Smoke Test
```bash
robot --outputdir results tests/smoke/amazon_search.robot
```

### Step 4: View Results
```bash
# HTML Report
open results/report.html

# Or on Linux
xdg-open results/report.html
```

---

## Project Structure Explained

```
resources/
├── config/
│   ├── base.robot              # Global settings (timeouts, viewport, etc.)
│   ├── environments.robot      # Dev/Staging/Prod URLs
│   └── locators.robot          # CSS/XPath selectors for your app
├── keywords/
│   ├── common.robot            # Advanced feature keywords
│   └── amazon.robot            # Your app's specific keywords

tests/
├── smoke/                      # Quick tests (2-5 tests)
├── regression/                 # Full test suite
└── advanced/                   # Advanced feature examples

results/                        # Test outputs (auto-created)
├── screenshots/
├── videos/
├── har/                        # Network recordings
└── traces/                     # Playwright debugging
```

---

## How to Customize for YOUR Application

### 1. Update Locators
Edit `resources/config/locators.robot`:

```robot
*** Variables ***
${LOGIN_BUTTON}          id=login-btn
${USERNAME_FIELD}        name=username
${PASSWORD_FIELD}        xpath=//input[@type="password"]
${SUBMIT_BUTTON}         css=button.submit
```

### 2. Create Application Keywords
Create `resources/keywords/myapp.robot`:

```robot
*** Keywords ***
Login With Credentials
    [Arguments]    ${username}    ${password}
    Type Text    ${USERNAME_FIELD}    ${username}
    Type Text    ${PASSWORD_FIELD}    ${password}
    Click    ${SUBMIT_BUTTON}
```

### 3. Write Your First Test
Create `tests/smoke/login_test.robot`:

```robot
*** Settings ***
Resource    ../config/base.robot
Resource    ../keywords/myapp.robot

Suite Setup      Open Browser With Advanced Features    https://myapp.com
Suite Teardown   Close Browser With Cleanup

*** Test Cases ***
User Can Login
    Login With Credentials    testuser    testpass
    # Add assertions here
```

### 4. Run Your Test
```bash
robot tests/smoke/login_test.robot
```

---

## Running Tests - Common Commands

### Run All Tests
```bash
robot tests/
```

### Run Specific Test File
```bash
robot tests/smoke/amazon_search.robot
```

### Run With Tags
```bash
robot --include smoke tests/
robot --exclude advanced tests/
```

### Run in Firefox
```bash
robot -v BROWSER_TYPE:firefox tests/
```

### Run Headless (No UI)
```bash
robot -v HEADLESS:True tests/
```

### Run With Video Recording
```bash
robot tests/advanced/advanced_features.robot
# Videos saved to results/videos/
```

### Run With Network Recording
```bash
robot tests/advanced/advanced_features.robot
# Network HAR files saved to results/har/
```

### Generate Detailed Report
```bash
robot --outputdir results tests/
# Then open: results/report.html
```

---

## Advanced Features - Usage Examples

### Example 1: Capture Network Traffic
```robot
Test With Network Recording
    Open Browser With Advanced Features
    ...    url=https://myapp.com
    ...    record_video=True
    ...    record_har=True
    
    # Your test steps here
    Type Text    id=search    Robot Framework
    Click    id=search-btn
    
    # Network activity automatically captured
    Close Browser With Cleanup
```

### Example 2: Mobile Device Testing
```robot
Test On Mobile Device
    New Browser    browser=chromium    headless=True
    New Context
    New Page    url=https://myapp.com
    Set Viewport Size    width=375    height=667
    
    # Run your test on mobile viewport
    Type Text    id=search    Product Name
    Click    id=search-btn
    
    Take Screenshot With Timestamp    mobile_view
```

### Example 3: Test With Geolocation
```robot
Test Location Features
    Open Browser With Advanced Features    https://myapp.com
    Set Geolocation    40.7128    -74.0060    0
    Grant Browser Permissions    geolocation
    
    Click    id=find-nearby-btn
    # Location-based features are now active
```

### Example 4: Offline Testing
```robot
Test Offline Functionality
    Open Browser With Advanced Features    https://myapp.com
    
    # Test online functionality
    Type Text    id=search    Test Query
    
    # Simulate going offline
    Go Offline
    # User can't search
    
    # Back online
    Go Online
    Type Text    id=search    Test Query
```

### Example 5: Performance Monitoring
```robot
Test Performance
    Open Browser With Advanced Features    https://myapp.com
    Go To    https://myapp.com
    
    ${metrics}    Get Performance Metrics
    Log    ${metrics}
    # Use metrics in assertions
```

---

## Common Keywords Reference

### Browser Control
- `Open Browser With Advanced Features` - Start browser with all features
- `Close Browser With Cleanup` - Properly close browser
- `Go To` - Navigate to URL
- `Reload` - Refresh page

### Element Interaction
- `Type Text` - Type into input field
- `Click` - Click element
- `Take Screenshot` - Capture screen
- `Wait For Elements State` - Wait for element visibility

### Advanced Features
- `Intercept Network Request` - Capture network traffic
- `Get Performance Metrics` - Get page performance data
- `Set Geolocation` - Set browser location
- `Grant Browser Permissions` - Allow permissions
- `Go Offline` - Simulate offline mode
- `Set Viewport Size` - Change screen size

---

## Troubleshooting

### Problem: Tests Won't Run
**Solution:**
```bash
poetry install
poetry shell
rfbrowser init
```

### Problem: Browser Not Found
**Solution:**
```bash
rfbrowser init
```

### Problem: Timeout Errors
**Solution:** Increase timeout in test:
```robot
Set Browser Timeout    60s
```

### Problem: Screenshots Not Saving
**Solution:** Ensure directory exists:
```bash
mkdir -p results/screenshots
```

### Problem: Video Recording Not Working
**Solution:** Check permissions:
```bash
chmod -R 777 results/videos/
```

---

## Next Steps

1. **Customize for Your App**
   - Update locators in `resources/config/locators.robot`
   - Create app-specific keywords in `resources/keywords/`

2. **Write Your First Test**
   - Create test file in `tests/smoke/`
   - Use the keywords you created
   - Run and verify

3. **Add CI/CD Integration**
   - Add GitHub Actions workflow
   - Configure for Jenkins/GitLab CI
   - Set up automated test runs

4. **Expand Test Suite**
   - Add regression tests
   - Add advanced feature tests
   - Organize by feature/module

5. **Performance Baseline**
   - Establish performance benchmarks
   - Monitor performance regressions
   - Report metrics

---

## Useful Commands

```bash
# Run all tests
robot tests/

# Run smoke tests only
robot --include smoke tests/

# Run with specific browser
robot -v BROWSER_TYPE:firefox tests/

# Run headless (no UI)
robot -v HEADLESS:True tests/

# Run with slower execution (500ms per action)
robot -v SLOWMO:500 tests/

# Generate reports
robot --outputdir results tests/

# Run and stop on first failure
robot --exitonfailure tests/

# Run with verbose output
robot -v BROWSER_TYPE:chromium --loglevel DEBUG tests/
```

---

## Key Files to Edit

1. **`resources/config/locators.robot`** - Add your app's selectors here
2. **`resources/keywords/myapp.robot`** - Add your app's workflows
3. **`tests/smoke/test_name.robot`** - Write your tests here
4. **`resources/config/base.robot`** - Change global settings here

---

## Resources

- [Robot Framework Docs](https://robotframework.org)
- [Browser Library Docs](https://robotframework-browser.org)
- [Playwright Docs](https://playwright.dev)
- [Framework Guidelines](../ADVANCED_FEATURES.md)

---

**You're all set! 🚀 Start writing your first test case.**
