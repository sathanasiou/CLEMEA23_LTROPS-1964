*** Settings ***
Library    CXTA
Resource   cxta.robot

*** Variables ***
${testbed}  testbed.yaml

*** Test Cases ***
Connect
    use testbed "${testbed}"
    connect to device "XRv-1"

Execute some commands
    execute "show ip int brief" on device "R1"
    select device "R1" using alias "default"
    execute "show version"
    execute "show ip protocols"
