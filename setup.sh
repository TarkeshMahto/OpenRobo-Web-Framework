#!/bin/bash
# OpenRobo Web Framework - Setup and Validation Script

echo "================================================"
echo "OpenRobo Web Framework - Complete Setup Guide"
echo "================================================"
echo ""

# Check if poetry is installed
if ! command -v poetry &> /dev/null; then
    echo "❌ Poetry not found. Installing..."
    curl -sSL https://install.python-poetry.org | python3 -
else
    echo "✅ Poetry is installed"
fi

echo ""
echo "================================================"
echo "Step 1: Install Dependencies with Poetry"
echo "================================================"
poetry install

echo ""
echo "================================================"
echo "Step 2: Activate Virtual Environment"
echo "================================================"
poetry shell

echo ""
echo "================================================"
echo "Step 3: Initialize Browser Library"
echo "================================================"
rfbrowser init

echo ""
echo "================================================"
echo "Step 4: Create Output Directories"
echo "================================================"
mkdir -p results/{screenshots,videos,har,traces,smoke,regression,advanced,detailed,tagged}

echo ""
echo "================================================"
echo "✅ OpenRobo Web Framework Setup Complete!"
echo "================================================"
echo ""
echo "Next Steps:"
echo "1. Edit locators: resources/config/locators.robot"
echo "2. Add keywords: resources/keywords/myapp.robot"
echo "3. Write tests: tests/smoke/my_test.robot"
echo "4. Run tests: robot tests/smoke/"
echo ""
echo "Quick Start Commands:"
echo "  - Run all tests:      robot tests/"
echo "  - Run smoke tests:    robot tests/smoke/"
echo "  - Run with video:     robot tests/advanced/advanced_features.robot"
echo "  - View report:        open results/report.html"
echo ""
echo "Resources:"
echo "  - Full guide:      see ADVANCED_FEATURES.md"
echo "  - Quick start:     see QUICKSTART.md"
echo "  - Contributing:    see CONTRIBUTING.md"
echo ""
