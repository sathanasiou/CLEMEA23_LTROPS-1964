# CLEMEA23_LTROPS-1964
Cisco Live CXTA Instructor Led Lab

Environment initiation if needed:
  Workstation:
    $ git clone https://github.com/sathanasiou/CLEMEA23_LTROPS-1964.git
    $ docker run -d -p 80:80 --name cxta_docs dockerhub.cisco.com/cxta-docker/cxta_docs:22.26
    $ docker run -it -u 1000 -v ${PWD}:/home/cisco/cxta --name cxta dockerhub.cisco.com/cxta-docker/cxta:22.26 bash

Commands for restarted pod:
  NSO:
    $ cd ~/ncs-run
    $ ncs
    $ ncs_cli -C -u admin
      # devices sync-from
  Workstation:
    $ docker start cxta cxta_docs
    $ git pull
    $ docker exec -it cxta bash
