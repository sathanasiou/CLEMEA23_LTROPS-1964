*** Settings ***
Library    CXTA
Resource   cxta.robot
Suite Setup   setup-test

*** Variables ***
${testbed}   testbed.yaml
${apic}      apic1
${nxos01_device}    NX-OS-1

*** Test Cases ***

Verify in-band BD Configuration
    ${tenant_name} =  Set Variable  mgmt
    ${bd_name} =  Set Variable  inb
    ${uri} =  Set Variable  /api/mo/uni/tn-${tenant_name}/BD-${bd_name}
    ACI REST login on "${apic}"
    @{return}=  via ACI REST API retrieve "${uri}" from "${apic}" as "xml"
    Should Be Equal as Integers     ${return}[0]    200
    Should Contain  ${return}[1]  <imdata totalCount="1">
    Should Contain  ${return}[1]  dn="uni/tn-mgmt/BD-inb"


ACI logout
    ACI REST logout on apic1
    
*** Keywords ***
setup-test
    load testbed "${testbed}"
