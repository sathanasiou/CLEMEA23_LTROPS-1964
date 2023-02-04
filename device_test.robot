*** Settings ***
Library    CXTA
Resource   cxta.robot
Library  CXTA.robot.platforms.iosxr.config

*** Variables ***
${testbed}      testbed.yaml
${iosxr01_device}  iosxrv-1
${iosxr02_device}  iosxrv-2
${iosxr_software_version}  7.3.2 
${iosxr02_software_version}  7.3.3

*** Test Cases ***
Connect
    use testbed "${testbed}"
    connect to device "${iosxr01_device}"
    connect to device "${iosxr02_device}"
    

Execute some commands on iosxrv1 device
    execute "show ip int brief" on device "${iosxr01_device}"
    select device "${iosxr01_device}" using alias "default"
    execute "show version"
    execute "show ip protocols"

Verify device software version for iosxr devices
    execute "show version"
    output contains "${iosxr_software_version}"
    execute "show version" on device "${iosxr02_device}"
    output contains "${iosxr_software_version}"
    Verify Software Release ${iosxr01_device} ${iosxr_software_version}


Verify device software version using Keyword
    Connect to device "${iosxr01_device}" and verify is running "${iosxr_software_version}"
    Connect to device "${iosxr02_device}" and verify is running "${iosxr_software_version}"

Send configuration to device using file
    execute commands from file "configuration/iosxr_configuration.txt" on device "${iosxr01_device}"
    download running config as "configuration/running.txt"
    

# Negative test case scenario for device
Verify device software version using Keyword
    Connect to device "${iosxr01_device}" and verify is running "${iosxr_software_version}"
    Connect to device "${iosxr02_device}" and verify is running "${iosxr02_software_version}"

*** Keywords ***

Connect to device "${device_name}" and verify is running "${software_version}"
    connect to device "${device_name}"
    execute "show version" on device "${device_name}"
    output contains "${software_version}"
