*** Settings ***
Documentation     External Tools Integration Test Suite
...               Tests for iPerf, terminal validation, and system commands
Library           BuiltIn
Library           Collections
Library           String
Resource          ${EXECDIR}/resources/config/base.robot
Resource          ${EXECDIR}/resources/keywords/external_tools.robot

Suite Setup       Log    Starting External Tools Testing Suite
Suite Teardown    Log    External Tools Testing Complete


*** Test Cases ***
Test iPerf Network Speed Test
    [Documentation]    Run iPerf network speed test
    [Tags]    external-tools    iperf    speed-test    smoke
    Log    Testing iPerf network speed measurement
    ${result}=    Run Network Speed Test With iPerf    192.168.1.1    5201    10    send
    Should Not Be Empty    ${result}
    Dictionary Should Contain Key    ${result}    bandwidth_mbps


Test Ping Connectivity
    [Documentation]    Test ping connectivity to host
    [Tags]    external-tools    ping    connectivity    smoke
    Log    Testing ping connectivity
    ${result}=    Run Ping Test    8.8.8.8    4    10
    Should Not Be Empty    ${result}
    Dictionary Should Contain Key    ${result}    packet_loss_percent


Test Traceroute Analysis
    [Documentation]    Test traceroute path analysis
    [Tags]    external-tools    traceroute    routing
    Log    Testing traceroute to destination
    ${result}=    Run Traceroute Test    8.8.8.8    30
    Should Not Be Empty    ${result}
    Dictionary Should Contain Key    ${result}    hops


Test DNS Lookup
    [Documentation]    Test DNS resolution
    [Tags]    external-tools    dns    resolution    smoke
    Log    Testing DNS lookup
    ${result}=    Run DNS Lookup    example.com
    Should Not Be Empty    ${result}
    Dictionary Should Contain Key    ${result}    ip_addresses


Test Network Interface Statistics
    [Documentation]    Get network interface statistics
    [Tags]    external-tools    ifconfig    statistics
    Log    Testing network interface stats
    ${result}=    Run Network Interface Statistics    eth0
    Should Not Be Empty    ${result}


Test Netstat Connection Analysis
    [Documentation]    Analyze network connections with netstat
    [Tags]    external-tools    netstat    connections    advanced
    Log    Testing netstat analysis
    ${result}=    Run Netstat Analysis    ${EMPTY}    port
    Should Not Be Empty    ${result}
    Dictionary Should Contain Key    ${result}    total_connections


Test HTTP Request With Curl
    [Documentation]    Execute HTTP request with curl
    [Tags]    external-tools    curl    http    api
    Log    Testing curl HTTP request
    ${result}=    Run HTTP Request With Curl    https://httpbin.org/get    GET    30
    Should Not Be Empty    ${result}
    Dictionary Should Contain Key    ${result}    http_code


Test Load Testing With Apache Bench
    [Documentation]    Run load test with Apache Bench
    [Tags]    external-tools    apache-bench    load-testing    advanced
    Log    Testing Apache Bench load test
    ${result}=    Run Load Testing With Apache Bench    ${BASE_URL}    10    100
    Should Not Be Empty    ${result}
    Dictionary Should Contain Key    ${result}    requests_per_second


Test Bandwidth Speedtest
    [Documentation]    Run speedtest-cli for bandwidth measurement
    [Tags]    external-tools    speedtest    bandwidth    advanced
    Log    Testing speedtest bandwidth measurement
    ${result}=    Run Bandwidth Test With Speedtest    ${EMPTY}
    Should Not Be Empty    ${result}
    Dictionary Should Contain Key    ${result}    download_mbps


Test MTR Combined Test
    [Documentation]    Run MTR (My Traceroute) combined test
    [Tags]    external-tools    mtr    combined    advanced
    Log    Testing MTR analysis
    ${result}=    Run MTR (My Traceroute) Test    8.8.8.8    100
    Should Not Be Empty    ${result}
    Dictionary Should Contain Key    ${result}    packet_loss_percent


Test TCP Port Connectivity
    [Documentation]    Test TCP connectivity to specific port
    [Tags]    external-tools    tcp    port-test
    Log    Testing TCP connectivity
    ${result}=    Run TCP Port Connectivity Test    example.com    443    5
    Should Not Be Empty    ${result}
    Dictionary Should Contain Key    ${result}    reachable


Test Network Packet Capture
    [Documentation]    Capture network packets with tcpdump
    [Tags]    external-tools    tcpdump    packet-capture    advanced
    Log    Testing packet capture
    ${result}=    Run Network Packet Capture    eth0    ${EMPTY}    100
    Should Not Be Empty    ${result}
    Dictionary Should Contain Key    ${result}    packets_captured


Test Latency Measurement
    [Documentation]    Measure network latency
    [Tags]    external-tools    latency    metrics    smoke
    Log    Testing latency measurement
    ${result}=    Run Latency Measurement    8.8.8.8    ping    10
    Should Not Be Empty    ${result}
    Dictionary Should Contain Key    ${result}    average_ms


Test Jitter Analysis
    [Documentation]    Analyze network jitter
    [Tags]    external-tools    jitter    analysis    advanced
    Log    Testing jitter analysis
    ${result}=    Run Jitter Analysis    8.8.8.8    60
    Should Not Be Empty    ${result}
    Dictionary Should Contain Key    ${result}    jitter_ms


Test Packet Loss Analysis
    [Documentation]    Analyze packet loss rate
    [Tags]    external-tools    packet-loss    reliability
    Log    Testing packet loss analysis
    ${result}=    Run Packet Loss Analysis    8.8.8.8    1000
    Should Not Be Empty    ${result}
    Dictionary Should Contain Key    ${result}    loss_percent


Test System Resource Monitoring
    [Documentation]    Monitor system resources
    [Tags]    external-tools    system-monitoring    resources    smoke
    Log    Testing system resource monitoring
    ${result}=    Run System Resource Monitor    60    5
    Should Not Be Empty    ${result}
    Dictionary Should Contain Key    ${result}    cpu_usage_percent


Test Route Information
    [Documentation]    Get network routing information
    [Tags]    external-tools    routing    network-paths
    Log    Testing route information
    ${result}=    Run Route Information Test    ${EMPTY}
    Should Not Be Empty    ${result}
    Dictionary Should Contain Key    ${result}    routes


Test HTTP Header Analysis
    [Documentation]    Analyze HTTP response headers
    [Tags]    external-tools    http-headers    analysis
    Log    Testing HTTP header analysis
    ${result}=    Run HTTP Header Analysis    ${BASE_URL}
    Should Not Be Empty    ${result}
    Dictionary Should Contain Key    ${result}    headers


Test Firewall Rule Validation
    [Documentation]    Validate firewall rules
    [Tags]    external-tools    firewall    security    advanced
    Log    Testing firewall rule validation
    ${result}=    Run Firewall Rule Validation    inbound
    Should Not Be Empty    ${result}
    Dictionary Should Contain Key    ${result}    active_rules


Test SSL Certificate Validation
    [Documentation]    Validate SSL/TLS certificate
    [Tags]    external-tools    ssl    security    advanced
    Log    Testing SSL certificate validation
    ${result}=    Run SSL Certificate Validation    example.com    443
    Should Not Be Empty    ${result}
    Dictionary Should Contain Key    ${result}    certificate_valid


Test Network Interface Diagnostics
    [Documentation]    Run network interface diagnostics
    [Tags]    external-tools    diagnostics    interfaces
    Log    Testing network interface diagnostics
    ${result}=    Run Network Interface Diagnostics    eth0
    Should Not Be Empty    ${result}
    Dictionary Should Contain Key    ${result}    status


Test DNS Propagation Check
    [Documentation]    Check DNS propagation across servers
    [Tags]    external-tools    dns-propagation    global-dns    advanced
    Log    Testing DNS propagation
    ${result}=    Run DNS Propagation Check    example.com
    Should Not Be Empty    ${result}
    Dictionary Should Contain Key    ${result}    propagated
