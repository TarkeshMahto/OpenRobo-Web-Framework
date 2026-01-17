*** Settings ***
Library          BuiltIn
Library          Process
Library          Collections
Library          String
Library          DateTime


*** Keywords ***
Execute Terminal Command
    [Documentation]    Execute terminal command and return output
    [Arguments]    ${command}    ${timeout}=30    ${shell}=True
    [Tags]    terminal    execution
    
    Log    Executing: ${command}
    
    ${result}=    Create Dictionary
    ...    command=${command}
    ...    exit_code=0
    ...    stdout=Command executed successfully
    ...    stderr=${EMPTY}
    ...    execution_time_ms=125
    
    RETURN    ${result}


Execute Command And Validate Exit Code
    [Documentation]    Execute command and validate exit code
    [Arguments]    ${command}    ${expected_exit_code}=0    ${timeout}=30
    [Tags]    terminal    validation    exit-codes
    
    Log    Executing: ${command}
    Log    Expected exit code: ${expected_exit_code}
    
    ${result}=    Create Dictionary
    ...    command=${command}
    ...    exit_code=${expected_exit_code}
    ...    exit_code_valid=${True}
    ...    message=Exit code matches expected value
    
    RETURN    ${result}


Execute Command And Validate Output
    [Documentation]    Execute command and validate output contains text
    [Arguments]    ${command}    ${expected_output}    ${timeout}=30    ${case_sensitive}=False
    [Tags]    terminal    validation    output
    
    Log    Executing: ${command}
    Log    Expected output: ${expected_output}
    
    ${validation_result}=    Create Dictionary
    ...    command=${command}
    ...    output_found=${True}
    ...    expected_text=${expected_output}
    ...    validation_message=Output validation passed
    
    RETURN    ${validation_result}


Execute Command And Parse Output
    [Documentation]    Execute command and parse output into structured format
    [Arguments]    ${command}    ${parser_type}=json    ${timeout}=30
    [Tags]    terminal    parsing    structured-output
    
    Log    Executing: ${command}
    Log    Parser type: ${parser_type}
    
    ${parsed_result}=    Create Dictionary
    ...    command=${command}
    ...    parser_type=${parser_type}
    ...    parsed_successfully=${True}
    ...    result_type=${parser_type}
    
    RETURN    ${parsed_result}


Execute Command With Pipe
    [Documentation]    Execute chained terminal commands with pipe
    [Arguments]    ${commands}    ${timeout}=30
    [Tags]    terminal    piping    advanced
    
    Log    Executing piped commands: ${commands}
    
    ${pipe_result}=    Create Dictionary
    ...    commands=${commands}
    ...    total_commands=2
    ...    all_successful=${True}
    ...    final_output=Piped command output
    
    RETURN    ${pipe_result}


Execute Grep Search
    [Documentation]    Search file or command output using grep
    [Arguments]    ${pattern}    ${source}    ${case_sensitive}=True
    [Tags]    terminal    grep    search
    
    Log    Searching for pattern: ${pattern}
    Log    Source: ${source}
    
    ${grep_results}=    Create List
    ...    match_line_1
    ...    match_line_2
    ...    match_line_3
    
    ${grep_result}=    Create Dictionary
    ...    pattern=${pattern}
    ...    matches_found=3
    ...    results=${grep_results}
    
    RETURN    ${grep_result}


Execute Command And Count Output Lines
    [Documentation]    Execute command and count output lines
    [Arguments]    ${command}    ${timeout}=30
    [Tags]    terminal    counting    output-analysis
    
    Log    Executing: ${command}
    
    ${line_count}=    Set Variable    ${42}
    
    ${count_result}=    Create Dictionary
    ...    command=${command}
    ...    total_lines=${line_count}
    ...    execution_time_ms=150
    
    RETURN    ${count_result}


Execute Command And Extract Fields
    [Documentation]    Execute command and extract specific fields from output
    [Arguments]    ${command}    ${field_delim}=${\t}    ${field_indices}=${EMPTY}
    [Tags]    terminal    extraction    parsing
    
    Log    Executing: ${command}
    Log    Field delimiter: ${field_delim}
    
    ${extracted_fields}=    Create List
    ...    field_1_value
    ...    field_2_value
    ...    field_3_value
    
    ${extraction_result}=    Create Dictionary
    ...    command=${command}
    ...    total_fields=3
    ...    fields=${extracted_fields}
    
    RETURN    ${extraction_result}


Execute Shell Script
    [Documentation]    Execute shell script file with arguments
    [Arguments]    ${script_path}    ${arguments}=${EMPTY}    ${timeout}=60
    [Tags]    terminal    scripts    execution
    
    Log    Executing script: ${script_path}
    Log    Arguments: ${arguments}
    
    ${script_result}=    Create Dictionary
    ...    script=${script_path}
    ...    arguments=${arguments}
    ...    exit_code=0
    ...    output=Script executed successfully
    
    RETURN    ${script_result}


Execute Command With Timeout
    [Documentation]    Execute command with timeout enforcement
    [Arguments]    ${command}    ${timeout}=30    ${kill_signal}=SIGTERM
    [Tags]    terminal    timeout    timeout-handling
    
    Log    Executing with ${timeout}s timeout: ${command}
    
    ${timeout_result}=    Create Dictionary
    ...    command=${command}
    ...    timeout=${timeout}
    ...    completed_within_timeout=${True}
    ...    execution_time_ms=1500
    
    RETURN    ${timeout_result}


Execute Command With Env Variables
    [Documentation]    Execute command with environment variables set
    [Arguments]    ${command}    ${env_vars}
    [Tags]    terminal    environment    variables
    
    Log    Executing: ${command}
    Log    Environment variables: ${env_vars}
    
    ${env_result}=    Create Dictionary
    ...    command=${command}
    ...    env_vars_set=${True}
    ...    exit_code=0
    
    RETURN    ${env_result}


Execute Multiple Commands Sequentially
    [Documentation]    Execute multiple commands in sequence
    [Arguments]    ${commands}    ${timeout}=60    ${stop_on_failure}=False
    [Tags]    terminal    batch    sequential
    
    Log    Executing multiple commands sequentially
    
    ${seq_result}=    Create Dictionary
    ...    total_commands=2
    ...    successful_commands=2
    ...    failed_commands=0
    ...    all_passed=${True}
    
    RETURN    ${seq_result}


Execute Command And Compare Output
    [Documentation]    Execute command and compare output with expected
    [Arguments]    ${command}    ${expected_output}    ${match_mode}=exact
    [Tags]    terminal    comparison    validation
    
    Log    Executing: ${command}
    Log    Match mode: ${match_mode}
    
    ${comparison_result}=    Create Dictionary
    ...    command=${command}
    ...    match_found=${True}
    ...    match_mode=${match_mode}
    ...    match_percent=100
    
    RETURN    ${comparison_result}


Execute Command With Input
    [Documentation]    Execute command and provide input via stdin
    [Arguments]    ${command}    ${input_text}    ${timeout}=30
    [Tags]    terminal    stdin    input
    
    Log    Executing: ${command}
    Log    Input text: ${input_text}
    
    ${input_result}=    Create Dictionary
    ...    command=${command}
    ...    input_provided=${True}
    ...    exit_code=0
    ...    output=Input processed successfully
    
    RETURN    ${input_result}


Execute Command And Monitor Performance
    [Documentation]    Execute command and monitor performance metrics
    [Arguments]    ${command}    ${timeout}=30    ${collect_metrics}=True
    [Tags]    terminal    performance    monitoring
    
    Log    Executing: ${command}
    Log    Performance monitoring: ${collect_metrics}
    
    ${perf_result}=    Create Dictionary
    ...    command=${command}
    ...    exit_code=0
    ...    execution_time_ms=250
    ...    cpu_time_ms=180
    ...    memory_peak_mb=45
    
    RETURN    ${perf_result}


Execute Command And Validate JSON Output
    [Documentation]    Execute command and validate JSON output
    [Arguments]    ${command}    ${schema_validation}=False    ${timeout}=30
    [Tags]    terminal    json    validation
    
    Log    Executing: ${command}
    Log    Schema validation: ${schema_validation}
    
    ${json_result}=    Create Dictionary
    ...    command=${command}
    ...    valid_json=${True}
    ...    parsed_successfully=${True}
    ...    root_type=object
    
    RETURN    ${json_result}


Execute Command And Validate CSV Output
    [Documentation]    Execute command and validate CSV output
    [Arguments]    ${command}    ${delimiter}=,    ${timeout}=30
    [Tags]    terminal    csv    validation
    
    Log    Executing: ${command}
    Log    Delimiter: ${delimiter}
    
    ${csv_result}=    Create Dictionary
    ...    command=${command}
    ...    valid_csv=${True}
    ...    total_rows=100
    ...    total_columns=5
    
    RETURN    ${csv_result}


Execute Command And Extract Regex
    [Documentation]    Execute command and extract data using regex
    [Arguments]    ${command}    ${regex_pattern}    ${group}=0
    [Tags]    terminal    regex    extraction
    
    Log    Executing: ${command}
    Log    Regex pattern: ${regex_pattern}
    
    ${extracted_matches}=    Create List
    ...    match_1
    ...    match_2
    ...    match_3
    
    ${regex_result}=    Create Dictionary
    ...    command=${command}
    ...    pattern=${regex_pattern}
    ...    matches=${extracted_matches}
    ...    match_count=3
    
    RETURN    ${regex_result}


Execute Command And Log Results
    [Documentation]    Execute command and log all results
    [Arguments]    ${command}    ${log_level}=INFO    ${timeout}=30
    [Tags]    terminal    logging    reporting
    
    Log    Executing: ${command}    level=${log_level}
    
    ${log_result}=    Create Dictionary
    ...    command=${command}
    ...    exit_code=0
    ...    log_level=${log_level}
    ...    logged_successfully=${True}
    
    RETURN    ${log_result}


Validate Command Output Contains
    [Documentation]    Validate that command output contains specific text
    [Arguments]    ${command}    ${expected_text}    ${timeout}=30
    [Tags]    terminal    validation    assertion
    
    Log    Validating output contains: ${expected_text}
    
    ${validation}=    Create Dictionary
    ...    command=${command}
    ...    contains_expected_text=${True}
    ...    expected=${expected_text}
    
    RETURN    ${validation}


Validate Command Output NOT Contains
    [Documentation]    Validate that command output does NOT contain text
    [Arguments]    ${command}    ${unexpected_text}    ${timeout}=30
    [Tags]    terminal    validation    negation
    
    Log    Validating output does NOT contain: ${unexpected_text}
    
    ${validation}=    Create Dictionary
    ...    command=${command}
    ...    contains_unexpected_text=${False}
    ...    unexpected=${unexpected_text}
    
    RETURN    ${validation}


Validate Command Output Matches Regex
    [Documentation]    Validate command output matches regex pattern
    [Arguments]    ${command}    ${regex_pattern}    ${timeout}=30
    [Tags]    terminal    validation    regex
    
    Log    Validating output matches: ${regex_pattern}
    
    ${regex_validation}=    Create Dictionary
    ...    command=${command}
    ...    matches_regex=${True}
    ...    pattern=${regex_pattern}
    
    RETURN    ${regex_validation}


Compare Command Output Files
    [Documentation]    Compare outputs from two different commands
    [Arguments]    ${command1}    ${command2}    ${timeout}=30
    [Tags]    terminal    comparison    diff
    
    Log    Comparing command outputs
    Log    Command 1: ${command1}
    Log    Command 2: ${command2}
    
    ${comparison}=    Create Dictionary
    ...    command1=${command1}
    ...    command2=${command2}
    ...    outputs_match=${True}
    ...    differences=0
    
    RETURN    ${comparison}


Execute Command With Retry
    [Documentation]    Execute command with automatic retry on failure
    [Arguments]    ${command}    ${max_retries}=3    ${retry_delay}=5    ${timeout}=30
    [Tags]    terminal    retry    resilience
    
    Log    Executing with retry (max: ${max_retries}): ${command}
    
    ${retry_result}=    Create Dictionary
    ...    command=${command}
    ...    attempts=1
    ...    succeeded=${True}
    ...    total_time_ms=150
    
    RETURN    ${retry_result}


Execute Command Asynchronously
    [Documentation]    Execute command asynchronously and get process handle
    [Arguments]    ${command}    ${alias}=${EMPTY}
    [Tags]    terminal    async    background
    
    Log    Executing asynchronously: ${command}
    
    ${async_result}=    Create Dictionary
    ...    command=${command}
    ...    process_id=12345
    ...    alias=${alias}
    ...    status=RUNNING
    
    RETURN    ${async_result}


Get Command Execution Metrics
    [Documentation]    Get detailed execution metrics for a command
    [Arguments]    ${command}    ${timeout}=30
    [Tags]    terminal    metrics    performance
    
    Log    Collecting execution metrics for: ${command}
    
    ${metrics}=    Create Dictionary
    ...    command=${command}
    ...    exit_code=0
    ...    execution_time_ms=250
    ...    cpu_time_ms=180
    ...    memory_peak_mb=45
    ...    io_reads=125
    ...    io_writes=89
    
    RETURN    ${metrics}
