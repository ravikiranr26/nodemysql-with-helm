## Node MySql App with helm charts for deploying

** Architecture
![Architecture](screencaptures/architecture.png)

** Node App
npm i
npm start
![App](screencaptures/app-interface-api.png)

** MySql DB
we will use the mysql to deploy via dependencies
![Docker](screencaptures/docker-hub-images.png)

** CI
we will use Jenkins and declartive file to generate the pipeline and publish the image
![CI](screencaptures/jenkins.png)

** CD
we will use AgroCD to deploy the application on local minikube
![CD](screencaptures/agrocd.png)


** TODO
use sonar cube with qualitiy gets
