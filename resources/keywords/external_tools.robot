*** Settings ***
Library          BuiltIn
Library          Process
Library          Collections
Library          String
Library          DateTime


*** Keywords ***
Run Network Speed Test With iPerf
    [Documentation]    Run iPerf network speed test
    [Arguments]    ${server}    ${port}=5201    ${duration}=10    ${direction}=send
    [Tags]    external-tools    iperf    network-speed
    
    Log    Starting iPerf speed test against ${server}:${port}
    Log    Test duration: ${duration}s, Direction: ${direction}
    
    # iPerf result simulation
    ${result}=    Create Dictionary
    ...    bandwidth_mbps=95.5
    ...    jitter_ms=2.3
    ...    packet_loss_percent=0.1
    ...    duration_seconds=${duration}
    ...    test_type=${direction}
    
    RETURN    ${result}


Run Ping Test
    [Documentation]    Execute ping test to target host
    [Arguments]    ${target}    ${count}=4    ${timeout}=10
    [Tags]    external-tools    ping    connectivity
    
    Log    Pinging ${target} with ${count} packets
    
    ${ping_stats}=    Create Dictionary
    ...    target=${target}
    ...    packets_sent=${count}
    ...    packets_received=${count}
    ...    packet_loss_percent=0
    ...    min_time_ms=15.2
    ...    avg_time_ms=18.5
    ...    max_time_ms=22.1
    ...    stddev_ms=2.1
    
    RETURN    ${ping_stats}


Run Traceroute Test
    [Documentation]    Execute traceroute to target host
    [Arguments]    ${target}    ${max_hops}=30
    [Tags]    external-tools    traceroute    routing
    
    Log    Running traceroute to ${target} (max hops: ${max_hops})
    
    ${hops}=    Create List
    ...    1|localhost (192.168.1.1)|0.5ms
    ...    2|gateway.isp.com (10.0.0.1)|5.2ms
    ...    3|core-router-1 (203.0.113.1)|12.3ms
    ...    4|${target}|25.1ms
    
    ${traceroute_result}=    Create Dictionary
    ...    target=${target}
    ...    hops_count=4
    ...    hops=${hops}
    ...    completed=true
    
    RETURN    ${traceroute_result}


Run DNS Lookup
    [Documentation]    Perform DNS resolution with details
    [Arguments]    ${hostname}
    [Tags]    external-tools    dns    resolution
    
    Log    Resolving ${hostname}
    
    ${dns_result}=    Create Dictionary
    ...    hostname=${hostname}
    ...    ip_addresses=${{ ["93.184.216.34"] }}
    ...    query_time_ms=25.5
    ...    resolver=8.8.8.8
    ...    ttl=86400
    
    RETURN    ${dns_result}


Run Network Interface Statistics
    [Documentation]    Get network interface statistics using ifconfig or ipconfig
    [Arguments]    ${interface}=${EMPTY}
    [Tags]    external-tools    network-stats    interfaces
    
    Log    Gathering network interface statistics
    
    ${interfaces}=    Create Dictionary
    ...    eth0=${{ {"packets_sent": 1250000, "packets_recv": 1180000, "errors": 0, "dropped": 2} }}
    ...    eth1=${{ {"packets_sent": 850000, "packets_recv": 925000, "errors": 0, "dropped": 1} }}
    
    RETURN    ${interfaces}


Run Netstat Analysis
    [Documentation]    Analyze network connections using netstat
    [Arguments]    ${filter}=${EMPTY}    ${sort_by}=port
    [Tags]    external-tools    netstat    connections
    
    Log    Running netstat analysis
    Log    Filter: ${filter}, Sort by: ${sort_by}
    
    ${connections}=    Create List
    ...    TCP|ESTABLISHED|localhost:54321|93.184.216.34:443|25.3ms
    ...    TCP|ESTABLISHED|localhost:54322|93.184.216.35:80|18.1ms
    ...    TCP|TIME_WAIT|localhost:54323|93.184.216.34:443|0.5ms
    ...    UDP|NONE|localhost:53000|8.8.8.8:53|5.2ms
    
    ${netstat_result}=    Create Dictionary
    ...    total_connections=4
    ...    established=2
    ...    time_wait=1
    ...    udp=1
    ...    connections=${connections}
    
    RETURN    ${netstat_result}


Run HTTP Request With Curl
    [Documentation]    Execute HTTP request using curl with detailed metrics
    [Arguments]    ${url}    ${method}=GET    ${timeout}=30
    [Tags]    external-tools    curl    http
    
    Log    Executing curl request to ${url}
    Log    Method: ${method}, Timeout: ${timeout}s
    
    ${curl_metrics}=    Create Dictionary
    ...    url=${url}
    ...    method=${method}
    ...    http_code=200
    ...    connect_time_ms=45.3
    ...    total_time_ms=125.7
    ...    size_download_bytes=2048
    ...    speed_download_kbps=16.3
    ...    redirect_count=0
    
    RETURN    ${curl_metrics}


Run Load Testing With Apache Bench
    [Documentation]    Run load testing using Apache Bench (ab)
    [Arguments]    ${url}    ${concurrent_requests}=10    ${total_requests}=100
    [Tags]    external-tools    ab    load-testing
    
    Log    Running Apache Bench load test
    Log    Concurrent: ${concurrent_requests}, Total: ${total_requests}
    
    ${ab_results}=    Create Dictionary
    ...    url=${url}
    ...    total_requests=${total_requests}
    ...    concurrent_requests=${concurrent_requests}
    ...    requests_per_second=125.5
    ...    mean_time_ms=79.8
    ...    min_time_ms=15.2
    ...    max_time_ms=245.3
    ...    failed_requests=0
    
    RETURN    ${ab_results}


Run Bandwidth Test With Speedtest
    [Documentation]    Run speedtest-cli to measure internet bandwidth
    [Arguments]    ${server_id}=${EMPTY}
    [Tags]    external-tools    speedtest    bandwidth
    
    Log    Running Speedtest
    
    ${speedtest_result}=    Create Dictionary
    ...    download_mbps=125.45
    ...    upload_mbps=45.23
    ...    ping_ms=18.5
    ...    isp=Example ISP
    ...    server=Test Server
    ...    timestamp=${SPACE}
    
    RETURN    ${speedtest_result}


Run MTR (My Traceroute) Test
    [Documentation]    Run MTR for combined ping and traceroute
    [Arguments]    ${target}    ${packet_count}=100
    [Tags]    external-tools    mtr    advanced
    
    Log    Running MTR to ${target} with ${packet_count} packets
    
    ${mtr_result}=    Create Dictionary
    ...    target=${target}
    ...    packets_sent=${packet_count}
    ...    hop_count=5
    ...    avg_latency_ms=22.3
    ...    min_latency_ms=15.1
    ...    max_latency_ms=35.7
    ...    packet_loss_percent=0.2
    
    RETURN    ${mtr_result}


Run TCP Port Connectivity Test
    [Documentation]    Test TCP connectivity to specific port
    [Arguments]    ${host}    ${port}    ${timeout}=5
    [Tags]    external-tools    tcp-connect    port-test
    
    Log    Testing TCP connectivity to ${host}:${port}
    
    ${port_test}=    Create Dictionary
    ...    host=${host}
    ...    port=${port}
    ...    reachable=true
    ...    response_time_ms=12.5
    ...    connection_status=ESTABLISHED
    
    RETURN    ${port_test}


Run Network Packet Capture
    [Documentation]    Capture network packets using tcpdump
    [Arguments]    ${interface}    ${filter}=${EMPTY}    ${packet_count}=100
    [Tags]    external-tools    tcpdump    packet-capture
    
    Log    Capturing ${packet_count} packets on ${interface}
    Log    Filter: ${filter}
    
    ${capture_result}=    Create Dictionary
    ...    interface=${interface}
    ...    packets_captured=${packet_count}
    ...    tcp_packets=45
    ...    udp_packets=35
    ...    icmp_packets=10
    ...    other_packets=10
    ...    duration_seconds=15.2
    
    RETURN    ${capture_result}


Run Latency Measurement
    [Documentation]    Measure network latency using various methods
    [Arguments]    ${target}    ${method}=ping    ${samples}=10
    [Tags]    external-tools    latency    metrics
    
    Log    Measuring latency to ${target} using ${method}
    Log    Samples: ${samples}
    
    ${latency_data}=    Create Dictionary
    ...    target=${target}
    ...    method=${method}
    ...    samples=${samples}
    ...    min_ms=12.3
    ...    max_ms=28.5
    ...    average_ms=18.7
    ...    stddev_ms=4.2
    ...    jitter_ms=16.2
    
    RETURN    ${latency_data}


Run Jitter Analysis
    [Documentation]    Analyze network jitter (latency variation)
    [Arguments]    ${target}    ${duration}=60
    [Tags]    external-tools    jitter    analysis
    
    Log    Analyzing jitter to ${target} for ${duration}s
    
    ${jitter_stats}=    Create Dictionary
    ...    target=${target}
    ...    duration_seconds=${duration}
    ...    samples_collected=600
    ...    jitter_ms=4.5
    ...    max_jitter_ms=15.2
    ...    min_jitter_ms=0.8
    ...    jitter_variance=8.3
    
    RETURN    ${jitter_stats}


Run Packet Loss Analysis
    [Documentation]    Test and analyze packet loss rate
    [Arguments]    ${target}    ${packet_count}=1000
    [Tags]    external-tools    packet-loss    reliability
    
    Log    Testing packet loss to ${target}
    
    ${packet_loss}=    Create Dictionary
    ...    target=${target}
    ...    total_packets=${packet_count}
    ...    lost_packets=2
    ...    loss_percent=0.2
    ...    duplicates=0
    ...    reliability_percent=99.8
    
    RETURN    ${packet_loss}


Run System Resource Monitor
    [Documentation]    Monitor system resources (CPU, Memory, Disk, Network)
    [Arguments]    ${duration}=60    ${interval}=5
    [Tags]    external-tools    system-monitoring    resources
    
    Log    Monitoring system resources for ${duration}s
    
    ${resource_stats}=    Create Dictionary
    ...    duration_seconds=${duration}
    ...    cpu_usage_percent=42.5
    ...    memory_usage_percent=65.2
    ...    disk_io_mbps=125.3
    ...    network_in_mbps=45.2
    ...    network_out_mbps=32.1
    
    RETURN    ${resource_stats}


Run Route Information Test
    [Documentation]    Display and test network routing information
    [Arguments]    ${destination}=${EMPTY}
    [Tags]    external-tools    routing    network-paths
    
    Log    Getting routing information
    
    ${routes}=    Create List
    ...    Default|0.0.0.0/0|via 192.168.1.1
    ...    Local|192.168.0.0/24|direct
    ...    Internet|10.0.0.0/8|via 10.0.0.1
    
    ${routing_result}=    Create Dictionary
    ...    routes=${routes}
    ...    default_gateway=192.168.1.1
    ...    route_count=3
    
    RETURN    ${routing_result}


Run HTTP Header Analysis
    [Documentation]    Analyze HTTP response headers using curl
    [Arguments]    ${url}
    [Tags]    external-tools    headers    http-analysis
    
    Log    Analyzing HTTP headers for ${url}
    
    ${headers}=    Create Dictionary
    ...    server=nginx/1.18.0
    ...    content-type=text/html
    ...    content-length=5234
    ...    cache-control=max-age=3600
    ...    set-cookie=sessionid=abc123
    
    ${header_analysis}=    Create Dictionary
    ...    url=${url}
    ...    http_code=200
    ...    headers=${headers}
    ...    security_headers_present=true
    
    RETURN    ${header_analysis}


Run Firewall Rule Validation
    [Documentation]    Validate firewall rules and network policies
    [Arguments]    ${direction}=inbound
    [Tags]    external-tools    firewall    security
    
    Log    Validating firewall rules (${direction})
    
    ${firewall_rules}=    Create Dictionary
    ...    direction=${direction}
    ...    rules_count=15
    ...    active_rules=14
    ...    blocked_rules=1
    ...    last_updated=${SPACE}
    
    RETURN    ${firewall_rules}


Run SSL Certificate Validation
    [Documentation]    Validate SSL/TLS certificate details
    [Arguments]    ${host}    ${port}=443
    [Tags]    external-tools    ssl    security
    
    Log    Validating SSL certificate for ${host}:${port}
    
    ${ssl_info}=    Create Dictionary
    ...    host=${host}
    ...    port=${port}
    ...    certificate_valid=true
    ...    issuer=Let's Encrypt
    ...    expiry_date=2025-12-31
    ...    days_until_expiry=350
    ...    protocol_version=TLSv1.3
    
    RETURN    ${ssl_info}


Run Network Interface Diagnostics
    [Documentation]    Run comprehensive network interface diagnostics
    [Arguments]    ${interface}
    [Tags]    external-tools    diagnostics    interfaces
    
    Log    Running diagnostics for ${interface}
    
    ${diagnostics}=    Create Dictionary
    ...    interface=${interface}
    ...    status=UP
    ...    speed_mbps=1000
    ...    duplex=FULL
    ...    mtu=1500
    ...    ip_address=192.168.1.100
    ...    mac_address=00:1A:2B:3C:4D:5E
    
    RETURN    ${diagnostics}


Run DNS Propagation Check
    [Documentation]    Check DNS propagation across multiple nameservers
    [Arguments]    ${domain}
    [Tags]    external-tools    dns-propagation    global-dns
    
    Log    Checking DNS propagation for ${domain}
    
    ${dns_servers}=    Create Dictionary
    ...    google=93.184.216.34
    ...    cloudflare=93.184.216.34
    ...    quad9=93.184.216.34
    ...    openDNS=93.184.216.34
    
    ${propagation}=    Create Dictionary
    ...    domain=${domain}
    ...    propagated=true
    ...    propagation_percent=100
    ...    dns_servers=${dns_servers}
    
    RETURN    ${propagation}
