*** Settings ***
Library    CXTA
Resource   cxta.robot
Suite Setup   setup-test

*** Variables ***
${testbed}   testbed.yaml
${apic}      apic1

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

Verify overlay-1 VRF Configuration
    ${vrf} =  Set Variable  overlay-1
    ${filter} =  Set Variable  query-target-filter=eq(fvCtx.name,"${vrf}")
    ${uri} =  Set Variable  /api/class/fvCtx
    @{return}=  via filtered ACI REST API retrieve "${uri}" using filter "${filter}" from "${apic}" as "json"
    Should Be Equal as Integers     ${return}[0]    200
    Should Contain  ${return}[1]  "totalCount":"1"
    Should Contain  ${return}[1]  "dn":"uni/tn-infra/ctx-overlay-1"

Configure Tenant
    ${payload}=  Set Variable  {"fvTenant": {"attributes": {"name": "CXTA-TESTING", "status": ""} } }
    ${uri} =  Set Variable  /api/mo/uni
    @{return}=  via ACI REST API configure device "${apic}" at URI "${uri}" using "json" payload "${payload}"
    Should Be Equal as Integers     ${return}[0]    200
    Should Contain  ${return}[1]  {"totalCount":"0","imdata":[]}

Delete Tenant
    ${payload}=  Set Variable  {"fvTenant": {"attributes": {"name": "CXTA-TESTING", "status": "deleted"} } }
    ${uri} =  Set Variable  /api/mo/uni
    @{return}=  via ACI REST API configure device "${apic}" at URI "${uri}" using "json" payload "${payload}"
    Should Be Equal as Integers     ${return}[0]    200
    Should Contain  ${return}[1]  {"totalCount":"0","imdata":[]}

ACI logout
    ACI REST logout on apic1

*** Keywords ***
setup-test
    load testbed "${testbed}"
