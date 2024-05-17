*** Settings ***
Library    CXTA
Resource   cxta.robot
Library  CXTA.robot.platforms.iosxr.config
Resource    community/generic.robot

*** Variables ***
${testbed}      testbed.yaml 
${dnac}     DNAC_server
${DNAC_DEVICE_TEMPLATE}     dnac_device.j2


*** Keywords *** 
connect to DNAC and add devices to testbed
    [Documentation]    adds devices from DNAC to testbed
    [Arguments]    ${dnac} 
    VAR     ${filter}   hostname=sw.*

    DNAC connect to "${dnac}"
    ${devices}=     DNAC Add Devices To Testbed  template=${DNAC_DEVICE_TEMPLATE}   query_filter=${filter}
    RETURN    @{devices}  
 
*** Test Cases ***
Add devices into testbed
    use testbed "${testbed}"
    connect to DNAC and add devices to testbed   ${dnac}
    
    