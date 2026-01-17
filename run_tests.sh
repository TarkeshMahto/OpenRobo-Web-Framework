#!/bin/bash
# Run all smoke tests
robot --outputdir results/smoke tests/smoke/

# Run all regression tests
robot --outputdir results/regression tests/regression/

# Run specific advanced feature tests
robot --outputdir results/advanced --include advanced tests/advanced/

# Run tests with a specific tag
robot --outputdir results/tagged --include smoke .

# Run tests with detailed logging
robot --outputdir results/detailed -v BROWSER_TYPE:firefox -v HEADLESS:False tests/smoke/
