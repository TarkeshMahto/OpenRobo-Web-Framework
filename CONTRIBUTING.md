# Contributing to OpenRobo Web Framework

## Code Structure Guidelines

### Test Organization
- **Smoke Tests** (`tests/smoke/`) - Quick sanity checks (2-5 min execution)
- **Regression Tests** (`tests/regression/`) - Full test suite (30-60 min)
- **Advanced Tests** (`tests/advanced/`) - Feature demonstrations

### Naming Conventions
- Test files: `feature_test.robot` (lowercase, underscore-separated)
- Test cases: `User Can Do Something Specific` (Title Case, descriptive)
- Keywords: `Do Something Specific` (Verb-first, clear intent)
- Variables: `${CONSTANT_NAME}` (UPPERCASE, underscores)

### File Organization
```
resources/
├── config/           # Configuration files (selectors, URLs, settings)
├── keywords/         # Reusable keywords (organized by feature)
└── libraries/        # Custom Python libraries (if needed)

tests/
├── smoke/           # Quick tests
├── regression/      # Full suite
└── advanced/        # Advanced features
```

## Writing New Tests

### Step 1: Add Locators
Add element selectors to `resources/config/locators.robot`:
```robot
${MY_BUTTON}    id=my-button
${MY_INPUT}     css=input.search
```

### Step 2: Create Keywords
Create or update `resources/keywords/myapp.robot`:
```robot
*** Keywords ***
Click My Button
    Click    ${MY_BUTTON}
    Wait For Load State    networkidle
```

### Step 3: Write Test
Create test in appropriate directory:
```robot
*** Settings ***
Resource    ../config/base.robot
Resource    ../config/locators.robot
Resource    ../keywords/myapp.robot

*** Test Cases ***
Test My Feature
    [Tags]    smoke
    Click My Button
    # Add assertions
```

## Best Practices

1. **Locators First** - Always put selectors in `locators.robot`
2. **Keywords Over Steps** - Keep test cases readable
3. **Meaningful Names** - Test case names describe what's being tested
4. **Explicit Waits** - Always wait for elements before interacting
5. **Error Messages** - Add descriptive assertion messages
6. **Clean Teardown** - Ensure resources are cleaned up
7. **Avoid Hard-Coding** - Use variables for URLs, credentials, etc.
8. **Single Responsibility** - Each keyword does one thing well
9. **Documentation** - Document complex keywords with [Documentation]
10. **DRY Principle** - Don't repeat yourself; create keywords instead

## Adding New Features

1. Create keyword file: `resources/keywords/feature_name.robot`
2. Create test file: `tests/smoke/feature_test.robot`
3. Add locators to: `resources/config/locators.robot`
4. Update this documentation

## Running Tests During Development

```bash
# Run your specific test
robot tests/smoke/your_test.robot

# Run with debug output
robot -v BROWSER_TYPE:chromium --loglevel DEBUG tests/smoke/your_test.robot

# Run with slow motion (see what's happening)
robot -v SLOWMO:500 tests/smoke/your_test.robot

# Keep browser open on failure for debugging
robot -v HEADLESS:False tests/smoke/your_test.robot
```

## Debugging Tips

1. **Use `Take Screenshot`** to see page state
2. **Use `Log`** to output variables
3. **Use `Pause Execution`** to stop and inspect
4. **Use SLOWMO** to slow down execution
5. **Run Headless=False** to watch browser
6. **Use `Evaluate JavaScript`** to inspect elements

## Git Workflow

1. Create branch: `git checkout -b feature/my-feature`
2. Write tests and keywords
3. Run tests: `robot tests/`
4. Commit changes: `git commit -m "Add feature X tests"`
5. Push: `git push origin feature/my-feature`
6. Create pull request

## Avoid These Common Mistakes

❌ Hard-coded waits (`Sleep    5s`) - Use smart waits instead
❌ Hard-coded selectors in tests - Put them in `locators.robot`
❌ Long test cases - Break into smaller keyword calls
❌ Tests that depend on each other - Make them independent
❌ No error messages on assertions - Always add context
❌ Testing implementation details - Test user behaviors
❌ Ignoring timeouts - Always set appropriate timeouts

---

Thank you for contributing! 🙏
