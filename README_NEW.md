# OpenRobo Web Framework

A professional, production-ready **Robot Framework** with advanced **robotframework-browser** capabilities for web automation, API testing, and desktop automation.

**Author:** Tarkeshwar Kumar Mahto

## 🚀 Features

### Core Capabilities
- ✅ **Web UI Automation** with robotframework-browser (Chromium, Firefox, WebKit)
- ✅ **API Testing** with robotframework-requests
- ✅ **Desktop Automation** with robotframework-imagehorizonlibrary
- ✅ **Organized Project Structure** with reusable keywords and configurations

### Advanced Browser Features
1. **Network Interception & HAR Recording** - Capture and analyze network traffic
2. **JavaScript Execution** - Execute custom JS during tests
3. **Device Emulation** - Test on mobile devices, tablets, various screen sizes
4. **Recording & Tracing** - Video, Playwright traces, HAR files
5. **Persistent Storage & Sessions** - Save/restore browser state
6. **Custom Locator Handlers** - Handle dynamic/problematic elements
7. **Context Isolation** - Multiple isolated browser contexts
8. **Geolocation & Permissions** - Test location-based features
9. **Performance Monitoring** - Measure load times and metrics
10. **Multi-Browser Testing** - Test across all major browsers

---

## 📋 Quick Start

### 1. Install Dependencies
```bash
poetry install
poetry shell
```

### 2. Initialize Browser Library
```bash
rfbrowser init
```

### 3. Run Your First Test
```bash
robot tests/smoke/amazon_search.robot
```

### 4. View Results
```bash
open results/report.html
```

---

## 📁 Project Structure

```
openrobo-web-framework/
├── resources/
│   ├── config/
│   │   ├── base.robot              # Global configuration
│   │   ├── environments.robot      # Dev/Staging/Prod configs
│   │   └── locators.robot          # Element selectors
│   ├── keywords/
│   │   ├── common.robot            # Advanced feature keywords
│   │   └── amazon.robot            # Application-specific keywords
│   └── libraries/                  # Custom Python libraries
├── tests/
│   ├── smoke/                      # Quick tests (2-5 min)
│   ├── regression/                 # Full test suite
│   └── advanced/                   # Advanced features demo
├── results/                        # Test outputs (auto-created)
├── pyproject.toml                  # Poetry dependencies
├── robot.ini                       # Robot Framework config
├── ADVANCED_FEATURES.md            # Advanced features guide
├── QUICKSTART.md                   # Quick start guide
└── CONTRIBUTING.md                 # Contributing guidelines
```

---

## 🎯 Common Commands

### Run Tests
```bash
# All tests
robot tests/

# Smoke tests only
robot tests/smoke/

# With specific browser
robot -v BROWSER_TYPE:firefox tests/

# Headless mode
robot -v HEADLESS:True tests/

# With video recording
robot tests/advanced/advanced_features.robot
```

### Generate Reports
```bash
robot --outputdir results tests/
# Reports: results/report.html, results/log.html
```

---

## 📚 Documentation

- **[QUICKSTART.md](QUICKSTART.md)** - Get started in 5 minutes
- **[ADVANCED_FEATURES.md](ADVANCED_FEATURES.md)** - Detailed feature guide
- **[CONTRIBUTING.md](CONTRIBUTING.md)** - Development guidelines

---

## 🔧 Configuration

### Browser Settings (`resources/config/base.robot`)
```robot
${HEADLESS}         False          # Show/hide browser
${BROWSER_TYPE}     chromium       # chromium, firefox, webkit
${TIMEOUT}          30s            # Default timeout
${SLOWMO}           0              # Slow down execution (ms)
```

### Locators (`resources/config/locators.robot`)
```robot
${SEARCH_INPUT}     id=twotabsearchtextbox
${SEARCH_BUTTON}    id=nav-search-submit-button
${ADD_TO_CART}      id=add-to-cart-button
```

---

## 💡 Usage Examples

### Basic Test
```robot
*** Settings ***
Resource    ../config/base.robot
Resource    ../keywords/amazon.robot

Suite Setup      Open Browser With Advanced Features    https://amazon.com
Suite Teardown   Close Browser With Cleanup

*** Test Cases ***
Search And Add To Cart
    Search For Product    MacBook Pro
    Click First Product In Results
    Add Current Product To Cart
```

### Advanced Features
```robot
Test With Network Recording
    Open Browser With Advanced Features
    ...    record_video=True
    ...    record_har=True
    ...    record_trace=False
    
    Search For Product    Laptop
    # Network traffic captured automatically
```

### Mobile Testing
```robot
Test Mobile Device
    New Browser    browser=chromium
    New Context
    New Page    url=https://amazon.com
    Set Viewport Size    375    667
    # Test on mobile viewport
```

---

## 🧪 Test Organization

### Smoke Tests (`tests/smoke/`)
- Quick sanity checks
- 2-5 minute execution
- Example: `amazon_search.robot`

### Regression Tests (`tests/regression/`)
- Full test suite
- 30-60 minute execution
- Example: `amazon_regression.robot`

### Advanced Tests (`tests/advanced/`)
- Feature demonstrations
- Performance tests
- Network tests
- Example: `advanced_features.robot`

---

## ⚙️ Customization

### For Your Application

1. **Update Locators**
   ```bash
   Edit: resources/config/locators.robot
   Add your app's CSS/XPath selectors
   ```

2. **Create Keywords**
   ```bash
   Create: resources/keywords/myapp.robot
   Define your app's workflows
   ```

3. **Write Tests**
   ```bash
   Create: tests/smoke/myapp_test.robot
   Use your new keywords
   ```

4. **Run Tests**
   ```bash
   robot tests/smoke/myapp_test.robot
   ```

---

## 🐛 Troubleshooting

### Browser Won't Start
```bash
rfbrowser init
```

### Tests Timeout
```bash
robot -v TIMEOUT:60s tests/
```

### Video Not Recording
```bash
mkdir -p results/videos
chmod 777 results/videos
```

---

## 📖 Resources

- [Robot Framework](https://robotframework.org)
- [Browser Library](https://robotframework-browser.org)
- [Playwright](https://playwright.dev)
- [Best Practices](https://github.com/MarketSquare/robotframework-browser/wiki)

---

## 📄 License

MIT License - See LICENSE file

---

## 🤝 Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md) for development guidelines.

---

## 🎓 Next Steps

1. Read [QUICKSTART.md](QUICKSTART.md) for 5-minute setup
2. Explore [ADVANCED_FEATURES.md](ADVANCED_FEATURES.md) for all capabilities
3. Customize for your application (update locators and keywords)
4. Write your first test in `tests/smoke/`
5. Integrate with CI/CD pipeline

---

**Ready to automate? Start with the [QUICKSTART.md](QUICKSTART.md)! 🚀**
