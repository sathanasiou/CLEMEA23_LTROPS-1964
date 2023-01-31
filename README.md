# CLEMEA23_LTROPS-1964
Cisco Live CXTA Instructor Led Lab

Important commands:
  git clone https://github.com/sathanasiou/CLEMEA23_LTROPS-1964.git
  git pull
  docker run -d -p 80:80 --name cxta_docs dockerhub.cisco.com/cxta-docker/cxta_docs:22.26
  docker run -it -u 1000 -v ${PWD}:/home/cisco/cxta --name cxta dockerhub.cisco.com/cxta-docker/cxta:22.26 bash
  docker exec -it cxta bash
  