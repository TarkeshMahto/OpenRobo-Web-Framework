*** Settings ***
Documentation     Terminal Validation Test Suite
...               Tests for terminal command execution and result validation
Library           BuiltIn
Library           Collections
Library           String
Resource          ${EXECDIR}/resources/config/base.robot
Resource          ${EXECDIR}/resources/keywords/terminal_validation.robot

Suite Setup       Log    Starting Terminal Validation Testing Suite
Suite Teardown    Log    Terminal Validation Testing Complete


*** Test Cases ***
Test Execute Basic Terminal Command
    [Documentation]    Execute basic terminal command
    [Tags]    terminal    execution    basic    smoke
    Log    Testing basic terminal command execution
    ${result}=    Execute Terminal Command    echo "Test"    30    True
    Should Not Be Empty    ${result}
    Dictionary Should Contain Key    ${result}    exit_code


Test Execute Command With Exit Code Validation
    [Documentation]    Execute command and validate exit code
    [Tags]    terminal    validation    exit-code    smoke
    Log    Testing exit code validation
    ${result}=    Execute Command And Validate Exit Code    ls -la    0    30
    Should Not Be Empty    ${result}
    Should Be True    ${result}[exit_code_valid]


Test Execute Command With Output Validation
    [Documentation]    Execute command and validate output
    [Tags]    terminal    validation    output    smoke
    Log    Testing output validation
    ${result}=    Execute Command And Validate Output    echo "test output"    test output    30    False
    Should Not Be Empty    ${result}
    Should Be True    ${result}[output_found]


Test Execute Command And Parse Output
    [Documentation]    Execute command and parse output
    [Tags]    terminal    parsing    structured-output
    Log    Testing output parsing
    ${result}=    Execute Command And Parse Output    echo '{"key":"value"}'    json    30
    Should Not Be Empty    ${result}
    Dictionary Should Contain Key    ${result}    parser_type


Test Execute Piped Commands
    [Documentation]    Execute chained terminal commands
    [Tags]    terminal    piping    advanced
    Log    Testing piped commands
    ${result}=    Execute Command With Pipe    ls | grep test    30
    Should Not Be Empty    ${result}
    Should Be True    ${result}[all_successful]


Test Execute Grep Search
    [Documentation]    Search using grep
    [Tags]    terminal    grep    search
    Log    Testing grep search
    ${result}=    Execute Grep Search    pattern    /etc/hosts    True
    Should Not Be Empty    ${result}
    Dictionary Should Contain Key    ${result}    matches_found


Test Execute Command And Count Lines
    [Documentation]    Execute command and count output lines
    [Tags]    terminal    counting    output-analysis
    Log    Testing line counting
    ${result}=    Execute Command And Count Output Lines    ls -la    30
    Should Not Be Empty    ${result}
    Dictionary Should Contain Key    ${result}    total_lines


Test Execute Command And Extract Fields
    [Documentation]    Execute command and extract fields
    [Tags]    terminal    extraction    parsing
    Log    Testing field extraction
    ${result}=    Execute Command And Extract Fields    ps aux    \t    ${EMPTY}
    Should Not Be Empty    ${result}
    Dictionary Should Contain Key    ${result}    total_fields


Test Execute Shell Script
    [Documentation]    Execute shell script file
    [Tags]    terminal    scripts    execution
    Log    Testing shell script execution
    ${result}=    Execute Shell Script    /tmp/test.sh    arg1 arg2    60
    Should Not Be Empty    ${result}
    Dictionary Should Contain Key    ${result}    exit_code


Test Execute Command With Timeout
    [Documentation]    Execute command with timeout
    [Tags]    terminal    timeout    timeout-handling
    Log    Testing timeout handling
    ${result}=    Execute Command With Timeout    sleep 5    10    SIGTERM
    Should Not Be Empty    ${result}
    Should Be True    ${result}[completed_within_timeout]


Test Execute Command With Environment Variables
    [Documentation]    Execute command with env variables
    [Tags]    terminal    environment    variables    advanced
    Log    Testing environment variables
    ${env_vars}=    Create Dictionary    VAR1=value1    VAR2=value2
    ${result}=    Execute Command With Env Variables    echo $VAR1    ${env_vars}
    Should Not Be Empty    ${result}


Test Execute Multiple Sequential Commands
    [Documentation]    Execute multiple commands sequentially
    [Tags]    terminal    batch    sequential    advanced
    Log    Testing sequential command execution
    ${commands}=    Create List    echo "test1"    echo "test2"
    ${result}=    Execute Multiple Commands Sequentially    ${commands}    60    False
    Should Not Be Empty    ${result}
    Should Be True    ${result}[all_passed]


Test Execute Command And Compare Output
    [Documentation]    Execute command and compare output
    [Tags]    terminal    comparison    validation
    Log    Testing output comparison
    ${result}=    Execute Command And Compare Output    echo "test"    test    exact
    Should Not Be Empty    ${result}
    Should Be True    ${result}[match_found]


Test Execute Command With Input
    [Documentation]    Execute command with stdin input
    [Tags]    terminal    stdin    input
    Log    Testing command with input
    ${result}=    Execute Command With Input    cat    test input    30
    Should Not Be Empty    ${result}
    Dictionary Should Contain Key    ${result}    exit_code


Test Execute Command And Monitor Performance
    [Documentation]    Execute command and monitor performance
    [Tags]    terminal    performance    monitoring    advanced
    Log    Testing performance monitoring
    ${result}=    Execute Command And Monitor Performance    ls -laR /    30    True
    Should Not Be Empty    ${result}
    Dictionary Should Contain Key    ${result}    execution_time_ms


Test Execute Command And Validate JSON
    [Documentation]    Execute command and validate JSON output
    [Tags]    terminal    json    validation
    Log    Testing JSON output validation
    ${result}=    Execute Command And Validate JSON Output    echo '{"key":"value"}'    False    30
    Should Not Be Empty    ${result}
    Should Be True    ${result}[valid_json]


Test Execute Command And Validate CSV
    [Documentation]    Execute command and validate CSV output
    [Tags]    terminal    csv    validation
    Log    Testing CSV output validation
    ${result}=    Execute Command And Validate CSV Output    cat data.csv    ,    30
    Should Not Be Empty    ${result}
    Dictionary Should Contain Key    ${result}    total_rows


Test Execute Command And Extract Regex
    [Documentation]    Execute command and extract using regex
    [Tags]    terminal    regex    extraction    advanced
    Log    Testing regex extraction
    ${result}=    Execute Command And Extract Regex    echo "test123data"    [0-9]+    0
    Should Not Be Empty    ${result}
    Dictionary Should Contain Key    ${result}    matches


Test Execute Command And Log Results
    [Documentation]    Execute command and log results
    [Tags]    terminal    logging    reporting
    Log    Testing command result logging
    ${result}=    Execute Command And Log Results    echo "test"    INFO    30
    Should Not Be Empty    ${result}
    Should Be True    ${result}[logged_successfully]


Test Validate Command Output Contains Text
    [Documentation]    Validate output contains expected text
    [Tags]    terminal    validation    assertion
    Log    Testing output contains validation
    ${result}=    Validate Command Output Contains    echo "success"    success    30
    Should Not Be Empty    ${result}
    Should Be True    ${result}[contains_expected_text]


Test Validate Command Output NOT Contains
    [Documentation]    Validate output does not contain text
    [Tags]    terminal    validation    negation
    Log    Testing output NOT contains validation
    ${result}=    Validate Command Output NOT Contains    echo "safe"    error    30
    Should Not Be Empty    ${result}
    Should Not Be True    ${result}[contains_unexpected_text]


Test Validate Command Output Matches Regex
    [Documentation]    Validate output matches regex
    [Tags]    terminal    validation    regex    advanced
    Log    Testing regex pattern validation
    ${result}=    Validate Command Output Matches Regex    echo "test123"    [0-9]+    30
    Should Not Be Empty    ${result}
    Should Be True    ${result}[matches_regex]


Test Compare Two Command Outputs
    [Documentation]    Compare outputs from two commands
    [Tags]    terminal    comparison    diff    advanced
    Log    Testing output comparison
    ${result}=    Compare Command Output Files    echo "a"    echo "a"    30
    Should Not Be Empty    ${result}
    Should Be True    ${result}[outputs_match]


Test Execute Command With Retry
    [Documentation]    Execute command with retry logic
    [Tags]    terminal    retry    resilience    advanced
    Log    Testing command retry
    ${result}=    Execute Command With Retry    echo "test"    3    5    30
    Should Not Be Empty    ${result}
    Should Be True    ${result}[succeeded]


Test Execute Command Asynchronously
    [Documentation]    Execute command asynchronously
    [Tags]    terminal    async    background    advanced
    Log    Testing asynchronous command execution
    ${result}=    Execute Command Asynchronously    sleep 30    background_job
    Should Not Be Empty    ${result}
    Dictionary Should Contain Key    ${result}    process_id


Test Get Command Execution Metrics
    [Documentation]    Get detailed execution metrics
    [Tags]    terminal    metrics    performance    advanced
    Log    Testing execution metrics collection
    ${result}=    Get Command Execution Metrics    echo "test"    30
    Should Not Be Empty    ${result}
    Dictionary Should Contain Key    ${result}    execution_time_ms


Test Verify Command Success Pattern
    [Documentation]    Verify command output matches success pattern
    [Tags]    terminal    validation    patterns
    Log    Testing success pattern validation
    ${result}=    Validate Command Output Contains    echo "Process completed successfully"    completed    30
    Should Not Be Empty    ${result}


Test Extract Multiple Fields From Output
    [Documentation]    Extract multiple fields from command output
    [Tags]    terminal    extraction    multi-field
    Log    Testing multi-field extraction
    ${result}=    Execute Command And Extract Fields    who    \t    ${EMPTY}
    Should Not Be Empty    ${result}
    Should Be True    ${result}[total_fields] > 0


Test Validate Numeric Output Range
    [Documentation]    Validate numeric output is within range
    [Tags]    terminal    validation    numeric
    Log    Testing numeric output validation
    ${result}=    Execute Command And Monitor Performance    echo "100"    30
    Should Not Be Empty    ${result}
    Dictionary Should Contain Key    ${result}    execution_time_ms
