*** Settings ***
Library    CXTA
Resource   cxta.robot
Library  CXTA.robot.platforms.iosxr.config
Resource    community/iosxr.robot
Resource    community/generic.robot


*** Variables ***
${testbed}      testbed.yaml
${iosxr01_device}  iosxrv-1
${iosxr02_device}  iosxrv-2
${iosxr_software_version}  7.3.2 
${iosxr02_software_version}  7.3.3
${nxos01_device}    NX-OS-1

*** Test Cases ***
Connect
    use testbed "${testbed}"
    connect to device "${iosxr01_device}"
    connect to device "${iosxr02_device}"
    connect to device "${nxos01_device}"
    
Execute some commands on iosxrv1 device
    execute "show ip int brief" on device "${iosxr01_device}"
    execute "show version"
    execute "show ip protocols"

Verify device software version for iosxr devices
    execute "show version" on device "${iosxr01_device}"
    output contains "${iosxr_software_version}"
    execute "show version" on device "${iosxr02_device}"
    output contains "${iosxr_software_version}"

Verify device software version using Keyword
    Connect to device "${iosxr01_device}" and verify is running "${iosxr_software_version}"
    Connect to device "${iosxr02_device}" and verify is running "${iosxr_software_version}"

Verify software version using iosxr Keywords
    Verify Software Release  ${iosxr01_device}  ${iosxr_software_version}

Send configuration to device using file
    execute commands from file "configuration/iosxr_configuration.txt" on device "${iosxr01_device}"

Save device running config
    connect to device "${iosxr01_device}"
    download running config as "configuration/running.txt"
    
### NX-OS test case

Add vlan in nxos device and validate
    Add Vlan to Vlan Database in NX-OS or IOS   ${nxos01_device}   9-11
    execute command "show vlan" on device "${nxos01_device}" and store in file "configuration/vlan_config.txt"
    compare config "validation_files/vlan_config.txt" to "configuration/vlan_config.txt"

#Negative test case
Verify device software version using Keyword
    Connect to device "${iosxr01_device}" and verify is running "${iosxr_software_version}"
    Connect to device "${iosxr02_device}" and verify is running "${iosxr02_software_version}"

Verify vlan configuration
    compare config "validation_files/vlan_config_negative.txt" to "configuration/vlan_config.txt"

*** Keywords ***

Connect to device "${device_name}" and verify is running "${software_version}"
    connect to device "${device_name}"
    execute "show version" on device "${device_name}"
    output contains "${software_version}"
