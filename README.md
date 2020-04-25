# Windfire Restaurant DevOps
This repository holds code and scripts for Infrastructure as Code and deployment automation of a sample application I developed for test and experimentation purposes, the *Windfire Restaurants* management application.

The *Windfire Restaurants* management application is composed by the following microservices:

* *Windfire Restaurants UI* microservice for the overall User Interface rendering, developed using Angular technology. Code and detailed infos are available at this GitHub repository: *https://github.com/robipozzi/windfire-restaurants-ui.git*
* *Windfire Restaurants Backend* microservice, developed using Spring Boot technology to implement the services for actual restaurants management. Code and detailed infos are available at this GitHub repository *https://github.com/robipozzi/windfire-restaurants-backend.git*. A Node.js based version of this microservice is also available (see *https://github.com/robipozzi/windfire-restaurants-node.git*).

The application can be deployed on different target architectures, see the following for details

* [Windfire Restaurants - AWS Single Zone Architecture](aws/README.md)

More architecture targets will be added and documented.