*** Settings ***
Library    CXTA
Resource   cxta.robot

*** Variables ***
${testbed}      testbed.yaml
${iosxr01_device_name}  iosxrv-1
${iosxr02_device_name}  iosxrv-2
${iosxr_software_version}  7.3.2 

*** Test Cases ***
Connect
    use testbed "${testbed}"
    connect to device "${iosxr01_device_name}"

Execute some commands in iosxrv1 device
    execute "show ip int brief" on device "${iosxr01_device_name}"
    select device "${iosxr01_device_name}" using alias "default"
    execute "show version"
    execute "show ip protocols"

Verify device software version for iosxr devices
    execute "show version"
    output contains "${iosxr_software_version}"


    

