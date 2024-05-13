*** Settings ***
Library    CXTA
Resource   cxta.robot
Suite setup   Setup browser

*** Variables ***
${dnac_url}          https://sandboxdnac.cisco.com/
${dnac_username}     devnetuser
${dnac_password}     Cisco123!


*** Test Cases ***
Add Network settings via GUI
    Click on DNAC main menu section "Design"
    Click on DNAC header section "Network Settings"
    Click on DNAC header section "Network"
    Click on DNAC plus sign for Network properties section "DHCP"
    Enter "1.2.3.4" in DNAC input text box "DHCP"
    Sleep  5s

Navigate on the GUI
    Click on DNAC Settings menu
    Click on DNAC option "Audit Logs"
    Click on DNAC home
    Click on DNAC menu sub-section "Discovery"
    Click on DNAC App menu
 

*** Keywords ***
Setup browser
    Start local browser
    Login to DNAC web interface "${dnac_url}" with credentials "${dnac_username}/${dnac_password}"
    Sleep  5s
    Save Screenshot
