*** Settings ***
Library    CXTA
Resource   cxta.robot

*** Variables ***
${testbed}      testbed.yaml
${device_name}  iosxrv-1

*** Test Cases ***
Connect
    use testbed "${testbed}"
    connect to device "${device_name}"

Execute some commands
    execute "show ip int brief" on device "${device_name}"
    select device "${device_name}" using alias "default"
    execute "show version"
    execute "show ip protocols"
