This repository contains everything you need to build a Docker image for https://github.com/JarodMica/index-tts

## Instructions
- clone the repository
  - git clone https://github.com/gordon-vart/indextts-docker.git
- change into the directory where the repository is located
  - cd indextts-docker/
- change the permissions on the build script so that it can be executed
  - chmod +x build.sh
- run the build script
  - uses sudo therefore you may need to provide your credentials
- the image is created in your docker instance. run the following command to see the images
  - sudo docker images

## Docker Compose
