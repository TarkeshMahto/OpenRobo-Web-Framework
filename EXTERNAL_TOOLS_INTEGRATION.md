# External Tools & Terminal Validation Integration Guide

## Overview

The OpenRobo Web Framework now includes comprehensive external tools integration and terminal command validation capabilities. This enables testing with specialized network tools (iPerf, Ping, Traceroute, etc.) and full terminal command execution with result validation.

---

## Table of Contents

1. [External Tools Testing](#external-tools-testing)
2. [Terminal Command Validation](#terminal-command-validation)
3. [Test Suites](#test-suites)
4. [Advanced Scenarios](#advanced-scenarios)
5. [Integration Examples](#integration-examples)

---

## External Tools Testing

### Supported Tools & Keywords

#### Network Performance Tools

##### 1. iPerf Network Speed Test
Measure network bandwidth between client and server.

```robot
Run Network Speed Test With iPerf
    [Arguments]    ${server}    ${port}=5201    ${duration}=10    ${direction}=send
```

**Example:**
```robot
${result}=    Run Network Speed Test With iPerf    192.168.1.1    5201    30    send
Log    Bandwidth: ${result}[bandwidth_mbps] Mbps
Log    Jitter: ${result}[jitter_ms] ms
```

**Returns:**
- `bandwidth_mbps` - Measured bandwidth
- `jitter_ms` - Network jitter
- `packet_loss_percent` - Packet loss rate
- `duration_seconds` - Test duration
- `test_type` - Test direction (send/receive/bidirectional)

##### 2. Ping Connectivity Test
Test basic connectivity and latency to target host.

```robot
Run Ping Test
    [Arguments]    ${target}    ${count}=4    ${timeout}=10
```

**Example:**
```robot
${result}=    Run Ping Test    8.8.8.8    10    15
Log    Packet loss: ${result}[packet_loss_percent]%
Log    Average latency: ${result}[avg_time_ms]ms
```

**Returns:**
- `packets_sent` / `packets_received` - Packet counts
- `packet_loss_percent` - Loss percentage
- `min_time_ms` / `avg_time_ms` / `max_time_ms` - Latency metrics
- `stddev_ms` - Standard deviation

##### 3. Traceroute Analysis
Trace network path to destination.

```robot
Run Traceroute Test
    [Arguments]    ${target}    ${max_hops}=30
```

**Example:**
```robot
${result}=    Run Traceroute Test    example.com    30
${hops}=    Set Variable    ${result}[hops]
Log    Hop count: ${result}[hops_count]
```

**Returns:**
- `target` - Target host
- `hops_count` - Number of hops
- `hops` - List of hop details
- `completed` - Trace completion status

#### DNS & Domain Tools

##### 4. DNS Lookup
Perform DNS resolution with details.

```robot
Run DNS Lookup
    [Arguments]    ${hostname}
```

**Example:**
```robot
${result}=    Run DNS Lookup    example.com
Log    IP: ${result}[ip_addresses]
Log    Query time: ${result}[query_time_ms]ms
```

**Returns:**
- `hostname` - Queried hostname
- `ip_addresses` - Resolved IP addresses
- `query_time_ms` - Query response time
- `ttl` - Time to live

##### 5. DNS Propagation Check
Check DNS propagation across multiple nameservers.

```robot
Run DNS Propagation Check
    [Arguments]    ${domain}
```

**Example:**
```robot
${result}=    Run DNS Propagation Check    example.com
Log    Propagated: ${result}[propagated]
Log    Percentage: ${result}[propagation_percent]%
```

#### HTTP & API Tools

##### 6. HTTP Request with Curl
Execute HTTP requests with detailed metrics.

```robot
Run HTTP Request With Curl
    [Arguments]    ${url}    ${method}=GET    ${timeout}=30
```

**Example:**
```robot
${result}=    Run HTTP Request With Curl    https://api.example.com/data    GET    30
Log    HTTP Code: ${result}[http_code]
Log    Response time: ${result}[total_time_ms]ms
Log    Size: ${result}[size_download_bytes] bytes
```

**Returns:**
- `http_code` - HTTP status code
- `connect_time_ms` - Connection time
- `total_time_ms` - Total request time
- `size_download_bytes` - Response size
- `speed_download_kbps` - Download speed

##### 7. HTTP Header Analysis
Analyze HTTP response headers.

```robot
Run HTTP Header Analysis
    [Arguments]    ${url}
```

**Example:**
```robot
${result}=    Run HTTP Header Analysis    https://example.com
Log    Server: ${result}[headers][server]
Log    Content-Type: ${result}[headers][content-type]
```

#### Load Testing Tools

##### 8. Apache Bench Load Testing
Run load tests with Apache Bench.

```robot
Run Load Testing With Apache Bench
    [Arguments]    ${url}    ${concurrent_requests}=10    ${total_requests}=100
```

**Example:**
```robot
${result}=    Run Load Testing With Apache Bench    https://example.com    20    1000
Log    Requests/sec: ${result}[requests_per_second]
Log    Mean time: ${result}[mean_time_ms]ms
Log    Failed: ${result}[failed_requests]
```

**Returns:**
- `total_requests` - Total requests sent
- `concurrent_requests` - Concurrent level
- `requests_per_second` - Throughput
- `mean_time_ms` - Average response time
- `min_time_ms` / `max_time_ms` - Time ranges
- `failed_requests` - Failed request count

##### 9. Speedtest Bandwidth Test
Measure internet bandwidth.

```robot
Run Bandwidth Test With Speedtest
    [Arguments]    ${server_id}=${EMPTY}
```

**Example:**
```robot
${result}=    Run Bandwidth Test With Speedtest
Log    Download: ${result}[download_mbps] Mbps
Log    Upload: ${result}[upload_mbps] Mbps
Log    Ping: ${result}[ping_ms] ms
```

#### Advanced Network Analysis

##### 10. MTR (My Traceroute) Test
Combined ping and traceroute analysis.

```robot
Run MTR Test
    [Arguments]    ${target}    ${packet_count}=100
```

**Example:**
```robot
${result}=    Run MTR Test    8.8.8.8    200
Log    Packet loss: ${result}[packet_loss_percent]%
Log    Avg latency: ${result}[avg_latency_ms]ms
```

##### 11. Network Interface Statistics
Get interface statistics.

```robot
Run Network Interface Statistics
    [Arguments]    ${interface}=${EMPTY}
```

**Returns:** Interface statistics including packets, errors, dropped

##### 12. Netstat Connection Analysis
Analyze network connections.

```robot
Run Netstat Analysis
    [Arguments]    ${filter}=${EMPTY}    ${sort_by}=port
```

**Example:**
```robot
${result}=    Run Netstat Analysis    ${EMPTY}    state
Log    Total connections: ${result}[total_connections]
Log    Established: ${result}[established]
```

##### 13. TCP Connectivity Test
Test TCP port accessibility.

```robot
Run TCP Port Connectivity Test
    [Arguments]    ${host}    ${port}    ${timeout}=5
```

**Example:**
```robot
${result}=    Run TCP Port Connectivity Test    example.com    443    5
Should Be True    ${result}[reachable]
Log    Response time: ${result}[response_time_ms]ms
```

##### 14. Latency Measurement
Measure network latency.

```robot
Run Latency Measurement
    [Arguments]    ${target}    ${method}=ping    ${samples}=10
```

**Example:**
```robot
${result}=    Run Latency Measurement    8.8.8.8    ping    50
Log    Average: ${result}[average_ms]ms
Log    Jitter: ${result}[jitter_ms]ms
```

##### 15. Jitter Analysis
Analyze latency variation.

```robot
Run Jitter Analysis
    [Arguments]    ${target}    ${duration}=60
```

##### 16. Packet Loss Analysis
Test packet loss rate.

```robot
Run Packet Loss Analysis
    [Arguments]    ${target}    ${packet_count}=1000
```

##### 17. Advanced Network Packet Capture
Capture network packets.

```robot
Run Network Packet Capture
    [Arguments]    ${interface}    ${filter}=${EMPTY}    ${packet_count}=100
```

##### 18. SSL Certificate Validation
Validate SSL/TLS certificates.

```robot
Run SSL Certificate Validation
    [Arguments]    ${host}    ${port}=443
```

**Example:**
```robot
${result}=    Run SSL Certificate Validation    example.com    443
Should Be True    ${result}[certificate_valid]
Log    Days until expiry: ${result}[days_until_expiry]
```

##### 19. Firewall Rule Validation
Validate firewall rules and policies.

```robot
Run Firewall Rule Validation
    [Arguments]    ${direction}=inbound
```

##### 20. System Resource Monitoring
Monitor CPU, Memory, Disk, Network.

```robot
Run System Resource Monitor
    [Arguments]    ${duration}=60    ${interval}=5
```

**Example:**
```robot
${result}=    Run System Resource Monitor    120    10
Log    CPU: ${result}[cpu_usage_percent]%
Log    Memory: ${result}[memory_usage_percent]%
```

---

## Terminal Command Validation

### Core Keywords

#### 1. Execute Terminal Command
Execute any terminal command.

```robot
Execute Terminal Command
    [Arguments]    ${command}    ${timeout}=30    ${shell}=True
```

**Example:**
```robot
${result}=    Execute Terminal Command    ls -la /home    30    True
Log    Exit code: ${result}[exit_code]
Log    Output: ${result}[stdout]
```

#### 2. Execute Command And Validate Exit Code
Execute and verify exit code.

```robot
Execute Command And Validate Exit Code
    [Arguments]    ${command}    ${expected_exit_code}=0    ${timeout}=30
```

**Example:**
```robot
${result}=    Execute Command And Validate Exit Code    curl https://example.com    0    30
Should Be True    ${result}[exit_code_valid]
```

#### 3. Execute Command And Validate Output
Execute and verify output contains text.

```robot
Execute Command And Validate Output
    [Arguments]    ${command}    ${expected_output}    ${timeout}=30    ${case_sensitive}=False
```

**Example:**
```robot
${result}=    Execute Command And Validate Output    echo "SUCCESS"    success    30    False
Should Be True    ${result}[output_found]
```

#### 4. Execute Command And Parse Output
Parse command output into structured data.

```robot
Execute Command And Parse Output
    [Arguments]    ${command}    ${parser_type}=json    ${timeout}=30
```

**Example:**
```robot
${result}=    Execute Command And Parse Output    curl -s https://api.example.com    json
```

#### 5. Execute Grep Search
Search in files or command output.

```robot
Execute Grep Search
    [Arguments]    ${pattern}    ${source}    ${case_sensitive}=True
```

**Example:**
```robot
${result}=    Execute Grep Search    ERROR    /var/log/syslog    True
Log    Matches found: ${result}[matches_found]
```

#### 6. Execute Command With Timeout
Enforce timeout on command execution.

```robot
Execute Command With Timeout
    [Arguments]    ${command}    ${timeout}=30    ${kill_signal}=SIGTERM
```

#### 7. Execute Command With Retry
Retry on failure with configurable attempts.

```robot
Execute Command With Retry
    [Arguments]    ${command}    ${max_retries}=3    ${retry_delay}=5    ${timeout}=30
```

**Example:**
```robot
${result}=    Execute Command With Retry    curl https://example.com    3    2    30
Log    Attempts: ${result}[attempts]
Should Be True    ${result}[succeeded]
```

#### 8. Execute Command And Extract Fields
Extract specific fields from output.

```robot
Execute Command And Extract Fields
    [Arguments]    ${command}    ${field_delim}=${\t}    ${field_indices}=${EMPTY}
```

**Example:**
```robot
${result}=    Execute Command And Extract Fields    ps aux    ${\s}
Log    Total fields: ${result}[total_fields]
```

#### 9. Execute Multiple Commands Sequentially
Run commands one after another.

```robot
Execute Multiple Commands Sequentially
    [Arguments]    ${commands}    ${timeout}=60    ${stop_on_failure}=False
```

**Example:**
```robot
${commands}=    Create List    cd /tmp    ls -la    pwd
${result}=    Execute Multiple Commands Sequentially    ${commands}
Should Be True    ${result}[all_passed]
```

#### 10. Execute Command And Extract Regex
Extract data using regex patterns.

```robot
Execute Command And Extract Regex
    [Arguments]    ${command}    ${regex_pattern}    ${group}=0
```

**Example:**
```robot
${result}=    Execute Command And Extract Regex    echo "Score: 95"    [0-9]+
Log    Matches: ${result}[matches]
```

#### 11. Execute Command And Monitor Performance
Track execution performance metrics.

```robot
Execute Command And Monitor Performance
    [Arguments]    ${command}    ${timeout}=30    ${collect_metrics}=True
```

**Example:**
```robot
${result}=    Execute Command And Monitor Performance    find / -name "*.log"    60
Log    Execution time: ${result}[execution_time_ms]ms
Log    CPU time: ${result}[cpu_time_ms]ms
Log    Memory peak: ${result}[memory_peak_mb]MB
```

#### 12. Validate Command Output Contains
Assert output contains text.

```robot
Validate Command Output Contains
    [Arguments]    ${command}    ${expected_text}    ${timeout}=30
```

**Example:**
```robot
Validate Command Output Contains    echo "Process completed"    completed
```

#### 13. Validate Command Output NOT Contains
Assert output does not contain text.

```robot
Validate Command Output NOT Contains
    [Arguments]    ${command}    ${unexpected_text}    ${timeout}=30
```

**Example:**
```robot
Validate Command Output NOT Contains    ./test.sh    ERROR
```

#### 14. Validate Command Output Matches Regex
Assert output matches pattern.

```robot
Validate Command Output Matches Regex
    [Arguments]    ${command}    ${regex_pattern}    ${timeout}=30
```

**Example:**
```robot
Validate Command Output Matches Regex    date    ^[A-Z][a-z]{2}\s+[A-Z][a-z]{2}
```

#### 15. Execute Command And Validate JSON
Validate JSON output.

```robot
Execute Command And Validate JSON Output
    [Arguments]    ${command}    ${schema_validation}=False    ${timeout}=30
```

#### 16. Execute Command And Validate CSV
Validate CSV output.

```robot
Execute Command And Validate CSV Output
    [Arguments]    ${command}    ${delimiter}=,    ${timeout}=30
```

---

## Test Suites

### External Tools Test Suite
Location: `tests/external_tools/external_tools_demo.robot`

Run external tools tests:
```bash
poetry run robot tests/external_tools/external_tools_demo.robot
```

Run specific tool tests:
```bash
# iPerf tests
poetry run robot -i iperf tests/external_tools/

# DNS tests
poetry run robot -i dns tests/external_tools/

# Load testing
poetry run robot -i load-testing tests/external_tools/
```

### Terminal Validation Test Suite
Location: `tests/terminal/terminal_validation_demo.robot`

Run terminal tests:
```bash
poetry run robot tests/terminal/terminal_validation_demo.robot
```

Run specific validation tests:
```bash
# Exit code validation
poetry run robot -i exit-code tests/terminal/

# Output validation
poetry run robot -i validation tests/terminal/

# Regex extraction
poetry run robot -i regex tests/terminal/
```

---

## Advanced Scenarios

### Scenario 1: Network Diagnostics Automation
```robot
*** Test Cases ***
Complete Network Diagnostics
    [Tags]    network    diagnostics    advanced
    
    # Test connectivity
    ${ping}=    Run Ping Test    8.8.8.8    10
    Should Be Equal As Numbers    ${ping}[packet_loss_percent]    0
    
    # Measure latency
    ${latency}=    Run Latency Measurement    8.8.8.8    ping    50
    Log    Average latency: ${latency}[average_ms]ms
    
    # Trace route
    ${trace}=    Run Traceroute Test    8.8.8.8    30
    Log    Hops: ${trace}[hops_count]
    
    # Check DNS
    ${dns}=    Run DNS Lookup    google.com
    Log    Resolved to: ${dns}[ip_addresses]
```

### Scenario 2: API Performance Testing
```robot
*** Test Cases ***
API Performance Analysis
    [Tags]    api    performance    advanced
    
    # Test request
    ${request}=    Run HTTP Request With Curl    https://api.example.com    GET    30
    Should Be Equal As Numbers    ${request}[http_code]    200
    
    # Load test
    ${load}=    Run Load Testing With Apache Bench    https://api.example.com    20    500
    Log    RPS: ${load}[requests_per_second]
    
    # Analyze headers
    ${headers}=    Run HTTP Header Analysis    https://api.example.com
    Log    Server: ${headers}[headers][server]
```

### Scenario 3: Terminal Command Validation Pipeline
```robot
*** Test Cases ***
System Health Check
    [Tags]    terminal    system    health
    
    # Check disk space
    ${disk}=    Execute Terminal Command    df -h /    30
    Should Contain    ${disk}[stdout]    /dev
    
    # Check running processes
    ${procs}=    Execute Command And Validate Output    ps aux    java    30
    
    # Validate log files
    ${logs}=    Execute Grep Search    ERROR    /var/log/app.log    True
    Log    Errors found: ${logs}[matches_found]
    
    # Performance metrics
    ${metrics}=    Execute Command And Monitor Performance    top -b -n 1    30
    Log    Execution time: ${metrics}[execution_time_ms]ms
```

### Scenario 4: SSL Certificate Monitoring
```robot
*** Test Cases ***
SSL Certificate Health Check
    [Tags]    ssl    security    monitoring
    
    # Validate certificate
    ${ssl}=    Run SSL Certificate Validation    example.com    443
    Should Be True    ${ssl}[certificate_valid]
    
    # Check expiry
    Should Be Greater Than    ${ssl}[days_until_expiry]    30
    Log    Days until expiry: ${ssl}[days_until_expiry]
    
    # Verify protocol
    Should Be Equal    ${ssl}[protocol_version]    TLSv1.3
```

---

## Integration with CI/CD

### GitHub Actions Example
```yaml
- name: Run External Tools Tests
  run: poetry run robot tests/external_tools/

- name: Run Terminal Validation Tests
  run: poetry run robot tests/terminal/
```

### Jenkins Example
```groovy
stage('External Tools Tests') {
    steps {
        sh 'poetry run robot tests/external_tools/'
    }
}

stage('Terminal Validation') {
    steps {
        sh 'poetry run robot tests/terminal/'
    }
}
```

---

## Best Practices

### External Tools Testing
1. **Handle Network Variations** - Tests may vary based on network conditions
2. **Use Appropriate Timeouts** - Network operations need sufficient time
3. **Parse Results Accurately** - Different tools have different output formats
4. **Validate Thresholds** - Set realistic performance baselines
5. **Monitor Resources** - Track system resource usage during tests

### Terminal Validation
1. **Escape Special Characters** - Handle shell special characters properly
2. **Validate Exit Codes** - Always check command execution status
3. **Parse Structured Output** - Use JSON/CSV parsing when available
4. **Implement Retries** - Network commands may be flaky
5. **Capture Metrics** - Monitor execution time and resource usage

---

## Troubleshooting

### External Tools Issues

**iPerf Not Available:**
```bash
sudo apt-get install iperf3
```

**Ping Blocked:**
- Check firewall rules
- Verify ICMP is allowed

**Traceroute Issues:**
- Ensure proper network access
- Check route availability

### Terminal Validation Issues

**Command Timeout:**
- Increase timeout parameter
- Check if command is hanging

**Output Parsing Fails:**
- Verify delimiter is correct
- Check command output format

---

## Summary

The OpenRobo Web Framework now supports:
- **20+ External Tools** (iPerf, Ping, DNS, Curl, etc.)
- **30+ Terminal Validation Keywords**
- **Comprehensive Result Parsing**
- **Performance Metrics Collection**
- **Structured Output Handling**

**Total: 50+ new keywords for testing with external tools and terminal commands!**

---

**Ready to test with external tools? Start with `tests/external_tools/` and `tests/terminal/`! 🚀**
