# Docker Warehouse  
This is a collection of customised docker image Dockerfiles used in a developer's daily life. 

## Badges  

[![MIT License](https://img.shields.io/badge/License-MIT-green.svg)](https://choosealicense.com/licenses/mit/)  
 
# Table of contents  
1. [Introduction](#introduction)  

## Run Locally  

Clone the project  

~~~bash  
  git clone https://github.com/otter13/dockers.git
~~~

Go to the project directory  

~~~bash  
  cd dockers
~~~

Build image

~~~bash  
npm run build
~~~

Build image to a specific os platform / cpu arch type

~~~bash  
npm run buildx
~~~

Push to 

~~~bash  
npm run push
~~~

## For building a vulnerability free image to build with npm
~~~bash 
cd vulnerability_free_builder
docker build . -t limosmiley/vulfree-node-16.19-bulleye
docker scan limosmiley/vulfree-node-16.19-bulleye 
docker push limosmiley/vulfree-node-16.19-bulleye    
~~~
The repo can be found at Docker Hub
https://hub.docker.com/r/limosmiley/vulfree-node-16.19-bulleye

## Environment Variables  

To run this project, you will need to add the following environment variables to your .env file  
`API_KEY`  

`ANOTHER_API_KEY` 

## Refs  

- [Docker buildx](https://docs.docker.com/build/building/multi-platform/)
- [Cypress image build](https://kushalbhalaik.xyz/blog/building-custom-docker-images-from-cypress-included/)

## Feedback  

If you have any feedback, please reach out to us at limosmiley@gmail.com

## License  

[MIT](https://choosealicense.com/licenses/mit/)
