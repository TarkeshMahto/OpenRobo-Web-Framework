#!/bin/bash
# OpenRobo Framework - Complete Testing Guide

echo ""
echo "╔════════════════════════════════════════════════════════════════════╗"
echo "║     OpenRobo Web Framework - Advanced Features Test Suite          ║"
echo "║              All 10 Advanced Features Demonstrated                  ║"
echo "╚════════════════════════════════════════════════════════════════════╝"
echo ""

# Color codes
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Display menu
show_menu() {
    echo "${BLUE}Choose a test to run:${NC}"
    echo ""
    echo "  ${GREEN}1${NC}  Run Basic Smoke Test"
    echo "       → Search MacBook Pro on Amazon"
    echo "       → Add to cart and verify"
    echo ""
    echo "  ${GREEN}2${NC}  Run All Advanced Features"
    echo "       → Network interception & HAR recording"
    echo "       → JavaScript execution & performance"
    echo "       → Device emulation (mobile testing)"
    echo "       → Geolocation & permissions"
    echo "       → Offline mode simulation"
    echo "       → Multi-browser testing"
    echo "       → Storage state management"
    echo "       → Custom locator handlers"
    echo ""
    echo "  ${GREEN}3${NC}  Run Specific Feature Demo"
    echo "       → Choose individual feature to test"
    echo ""
    echo "  ${GREEN}4${NC}  Run Full Regression Suite"
    echo "       → Complete Amazon workflow tests"
    echo ""
    echo "  ${GREEN}5${NC}  Run with Video Recording"
    echo "       → Record test execution to video"
    echo ""
    echo "  ${GREEN}6${NC}  Run with Network Recording"
    echo "       → Capture network traffic (HAR)"
    echo ""
    echo "  ${GREEN}7${NC}  Run on Different Browser"
    echo "       → Test on Firefox or WebKit"
    echo ""
    echo "  ${GREEN}8${NC}  Run Headless Mode"
    echo "       → Tests run without UI"
    echo ""
    echo "  ${GREEN}9${NC}  Generate HTML Report"
    echo "       → Create and open test report"
    echo ""
    echo "  ${GREEN}0${NC}  Exit"
    echo ""
}

# Function to run basic smoke test
run_smoke_test() {
    echo "${YELLOW}Running Smoke Test...${NC}"
    echo "Test: Search MacBook Pro and add to cart"
    echo ""
    robot --outputdir results tests/smoke/amazon_search.robot
    echo ""
    echo "${GREEN}✓ Smoke test completed!${NC}"
    echo "Results saved to: results/"
}

# Function to run all advanced features
run_advanced_features() {
    echo "${YELLOW}Running ALL Advanced Features Tests...${NC}"
    echo ""
    echo "This will demonstrate all 10 advanced features:"
    echo "  1. Network Interception & HAR Recording"
    echo "  2. JavaScript Execution & Performance"
    echo "  3. Device Emulation (Mobile)"
    echo "  4. Geolocation & Permissions"
    echo "  5. Offline Mode Simulation"
    echo "  6. Multi-browser Testing"
    echo "  7. Storage State Management"
    echo "  8. Custom Locator Handlers"
    echo "  9. Browser Dialog Handling"
    echo " 10. Network Idle Waiting"
    echo ""
    robot --outputdir results tests/advanced/advanced_features.robot
    echo ""
    echo "${GREEN}✓ Advanced features tests completed!${NC}"
}

# Function to show feature options
show_features() {
    echo "${BLUE}Advanced Features Available:${NC}"
    echo ""
    echo "  ${GREEN}1${NC}  Network Interception & HAR Recording"
    echo "  ${GREEN}2${NC}  JavaScript Execution & Performance Metrics"
    echo "  ${GREEN}3${NC}  Browser Dialog Handling"
    echo "  ${GREEN}4${NC}  Geolocation & Permissions"
    echo "  ${GREEN}5${NC}  Offline Mode Simulation"
    echo "  ${GREEN}6${NC}  Multi-Browser Testing"
    echo "  ${GREEN}7${NC}  Device Emulation"
    echo "  ${GREEN}8${NC}  Storage State Management"
    echo "  ${GREEN}9${NC}  Custom Locator Handler"
    echo " ${GREEN}10${NC}  Network Idle Waiting"
    echo ""
    read -p "Enter feature number (1-10): " feature_num
    
    case $feature_num in
        1)
            echo "${YELLOW}Running Network Interception Test...${NC}"
            robot --outputdir results --include "network" tests/advanced/advanced_features.robot
            ;;
        2)
            echo "${YELLOW}Running JavaScript Execution Test...${NC}"
            robot --outputdir results --include "performance" tests/advanced/advanced_features.robot
            ;;
        3)
            echo "${YELLOW}Running Dialog Handling Test...${NC}"
            robot --outputdir results --include "dialogs" tests/advanced/advanced_features.robot
            ;;
        4)
            echo "${YELLOW}Running Geolocation Test...${NC}"
            robot --outputdir results --include "geolocation" tests/advanced/advanced_features.robot
            ;;
        5)
            echo "${YELLOW}Running Offline Mode Test...${NC}"
            robot --outputdir results --include "offline" tests/advanced/advanced_features.robot
            ;;
        6)
            echo "${YELLOW}Running Multi-Browser Test...${NC}"
            robot --outputdir results --include "multi-browser" tests/advanced/advanced_features.robot
            ;;
        7)
            echo "${YELLOW}Running Device Emulation Test...${NC}"
            robot --outputdir results --include "device-emulation" tests/advanced/advanced_features.robot
            ;;
        8)
            echo "${YELLOW}Running Storage State Test...${NC}"
            robot --outputdir results --include "storage" tests/advanced/advanced_features.robot
            ;;
        9)
            echo "${YELLOW}Running Custom Locator Handler Test...${NC}"
            robot --outputdir results --include "locator-handler" tests/advanced/advanced_features.robot
            ;;
        10)
            echo "${YELLOW}Running Network Idle Test...${NC}"
            robot --outputdir results --include "network-idle" tests/advanced/advanced_features.robot
            ;;
        *)
            echo "${RED}Invalid option${NC}"
            ;;
    esac
}

# Function to run regression tests
run_regression() {
    echo "${YELLOW}Running Full Regression Suite...${NC}"
    echo "Tests: Complete Amazon workflow scenarios"
    echo ""
    robot --outputdir results/regression tests/regression/
    echo ""
    echo "${GREEN}✓ Regression tests completed!${NC}"
}

# Function to run with video
run_with_video() {
    echo "${YELLOW}Running tests with Video Recording...${NC}"
    echo "Videos will be saved to: results/videos/"
    echo ""
    robot --outputdir results tests/advanced/advanced_features.robot
    echo ""
    echo "${GREEN}✓ Tests completed with video recording!${NC}"
    echo "Video files: results/videos/*.webm"
}

# Function to run with HAR
run_with_har() {
    echo "${YELLOW}Running tests with Network Recording (HAR)...${NC}"
    echo "Network HAR files will be saved to: results/har/"
    echo ""
    robot --outputdir results tests/advanced/advanced_features.robot
    echo ""
    echo "${GREEN}✓ Tests completed with network recording!${NC}"
    echo "HAR files: results/har/network.har"
}

# Function to run with different browser
run_different_browser() {
    echo "${BLUE}Select browser:${NC}"
    echo "  ${GREEN}1${NC}  Firefox"
    echo "  ${GREEN}2${NC}  WebKit"
    echo "  ${GREEN}3${NC}  Chromium (default)"
    echo ""
    read -p "Enter choice (1-3): " browser_choice
    
    case $browser_choice in
        1)
            echo "${YELLOW}Running tests on Firefox...${NC}"
            robot -v BROWSER_TYPE:firefox --outputdir results tests/smoke/
            ;;
        2)
            echo "${YELLOW}Running tests on WebKit...${NC}"
            robot -v BROWSER_TYPE:webkit --outputdir results tests/smoke/
            ;;
        3)
            echo "${YELLOW}Running tests on Chromium...${NC}"
            robot --outputdir results tests/smoke/
            ;;
        *)
            echo "Invalid option"
            ;;
    esac
}

# Function to run headless
run_headless() {
    echo "${YELLOW}Running tests in Headless Mode...${NC}"
    echo "Browser UI will not be displayed"
    echo ""
    robot -v HEADLESS:True --outputdir results tests/
    echo ""
    echo "${GREEN}✓ Headless tests completed!${NC}"
}

# Function to generate and open report
generate_report() {
    echo "${YELLOW}Generating HTML Report...${NC}"
    echo ""
    robot --outputdir results tests/
    echo ""
    echo "${GREEN}✓ Report generated!${NC}"
    echo ""
    echo "Opening report in browser..."
    if command -v xdg-open &> /dev/null; then
        xdg-open results/report.html
    elif command -v open &> /dev/null; then
        open results/report.html
    else
        echo "Please open manually: results/report.html"
    fi
}

# Main loop
while true; do
    show_menu
    read -p "Enter your choice [0-9]: " choice
    
    case $choice in
        1)
            run_smoke_test
            ;;
        2)
            run_advanced_features
            ;;
        3)
            show_features
            ;;
        4)
            run_regression
            ;;
        5)
            run_with_video
            ;;
        6)
            run_with_har
            ;;
        7)
            run_different_browser
            ;;
        8)
            run_headless
            ;;
        9)
            generate_report
            ;;
        0)
            echo "${GREEN}Goodbye!${NC}"
            exit 0
            ;;
        *)
            echo "${YELLOW}Invalid option. Please try again.${NC}"
            ;;
    esac
    
    echo ""
    read -p "Press Enter to continue..."
    clear
done
