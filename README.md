# Infer.NET in python

This repository contains a jupyter notebook that demonstrates how the [Infer.NET](https://dotnet.github.io/infer/default.html) framework for graph Bayesian inference can be invoked in python using [pythonnet](http://pythonnet.github.io/) on Ubuntu 18.04.

## To run the notebook:

* Install [Docker](https://hub.docker.com/editions/community/docker-ce-server-ubuntu)
* Download or clone this repository
* Move into the repository and build the Docker image: type `sudo docker build --rm -t infer_pythonnet .`
* Run the image by typing `sudo docker run -it -p 8888:8888 -v ${PWD}:/root/dev infer_pythonnet`
* The container will start a Jupyter notebook server. Go to <http://localhost:8888> and login with the token that is printed out in the terminal

## Caveat

As explained in the notebook, the solution is not fully functional. Pythonnet currently still lacks support to handle generic methods with overloads. Hopefully this will be resolved soon. 
