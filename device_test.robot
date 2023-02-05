*** Settings ***
Library    CXTA
Resource   cxta.robot
Library  CXTA.robot.platforms.iosxr.config
Resource    community/generic.robot
# Resource    community/iosxr.robot


*** Variables ***
# ${testbed}      testbed.yaml
# ${iosxr01_device}  iosxrv-1
# ${iosxr02_software_version}  7.3.3

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
    # connect to device "${iosxr02_device}"
    connect to device "${iosxr02_device}"
    # connect to device "${nxos01_device}"
    
Execute some commands on iosxrv1 device
    execute "show ip int brief" on device "${iosxr01_device}"
    # execute "show version" on device "${iosxr01_device}"
    # execute "show ip protocols" on device "${iosxr01_device}"

Verify device software version for iosxr devices
    execute "show version" on device "${iosxr01_device}"
    output contains "${iosxr_software_version}"
    # execute "show version" on device "${iosxr02_device}"
    # output contains "${iosxr_software_version}"

#Delete
Verify device software version using Keyword
    Connect to device "${iosxr01_device}" and verify is running "${iosxr_software_version}"
#     Connect to device "${iosxr02_device}" and verify is running "${iosxr_software_version}"

#Delete
Verify software version using iosxr Keywords
    Verify Software Release  ${iosxr01_device}  ${iosxr_software_version}

## Negative Test Cases
Verify device software version using Keyword
    continue on failure enabled
    Connect to device "${iosxr01_device}" and verify is running "${iosxr_software_version}"
    Connect to device "${iosxr02_device}" and verify is running "${iosxr02_software_version}"

Verify vlan configuration
    compare config "validation_files/vlan_config_negative.txt" to "configuration/vlan_config.txt"

*** Keywords ***

Connect to device "${device_name}" and verify is running "${software_version}"
    connect to device "${device_name}"
    execute "show version" on device "${device_name}"
    output contains "${software_version}"