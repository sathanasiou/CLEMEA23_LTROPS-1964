*** Settings ***
Library     CXTA
Resource    cxta.robot

*** Test Cases ***
Verify CXTA
    ${version}=   CXTA Version
    Set Test Message    CXTA version ${version} installed

setup-my-environment
    [Documentation]     load the yaml topology file and connect to all devices defined therein
    use testbed "testbed.yaml"
    connect to all devices

