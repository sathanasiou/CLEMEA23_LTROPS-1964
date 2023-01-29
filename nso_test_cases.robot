*** Settings ***
Library     CXTA
Resource    cxta.robot

Suite Setup     Suite Setup Actions
Suite Teardown  Suite Teardown Actions

*** Variables ***
${nso}        nso

*** Test Cases ***

Test case 1
    Configure NSO with "services if-description Test1 device iosxrv-1 interface GigabitEthernet id 0/0/0/1 description Test1"
    check command "show interfaces GigabitEthernet 0/0/0/1 description | include 0/0/0/1" from device "XRv-1" for regex "GigabitEthernet 0/0/0/1 Test1"

Test case 2 - negative
    Configure NSO with "services if-description Test2 device iosxrv-2 interface GigabitEthernet id 0/0/0/2 description Test2"
    check command "show interfaces GigabitEthernet 0/0/0/2 description | include 0/0/0/2" from device "IOS-XRv-2" for regex "GigabitEthernet 0/0/0/2 Test2"

*** Keywords ***

Suite Setup Actions
    use testbed "testbed.yaml"
    retrieve latest NSO rollback number from "${nso}"
    connect to all devices
    Set NSO cli style to "cisco"

Suite Teardown Actions
    rollback NSO "${nso}" to rollback retrieved
