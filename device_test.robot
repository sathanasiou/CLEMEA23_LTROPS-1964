*** Settings ***
Library    CXTA
Resource   cxta.robot
Library  CXTA.robot.platforms.iosxr.config
Resource    community/generic.robot

*** Variables ***
${testbed}      testbed.yaml
${iosxr01_device}  iosxrv-1
${iosxr02_software_version}  7.3.3

*** Test Cases ***
Connect
    use testbed "${testbed}"
    connect to device "${iosxr01_device}"

Execute some commands on iosxrv1 device
    execute "show ip int brief" on device "${iosxr01_device}"

Verify device software version for iosxr devices
    execute "show version" on device "${iosxr01_device}"
    output contains "${iosxr_software_version}"




*** Keywords ***