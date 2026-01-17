@echo off
REM Windows batch script to run tests

REM Run all smoke tests
robot --outputdir results\smoke tests\smoke\

REM Run all regression tests
robot --outputdir results\regression tests\regression\

REM Run specific advanced feature tests
robot --outputdir results\advanced --include advanced tests\advanced\

REM Run tests with a specific tag
robot --outputdir results\tagged --include smoke .

REM Run tests with detailed logging
robot --outputdir results\detailed -v BROWSER_TYPE:firefox -v HEADLESS:False tests\smoke\
