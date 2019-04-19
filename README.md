# Infer.NET in python

This repository contains a jupyter notebook that demonstrates how the [Infer.NET](https://dotnet.github.io/infer/default.html) framework for graph Bayesian inference can be invoked in python using [pythonnet](http://pythonnet.github.io/) on Ubuntu 18.04.

## To run the notebook:

* Install [Docker](https://hub.docker.com/editions/community/docker-ce-server-ubuntu)
* Download or clone this repository
* Move into the repository and build the Docker image: type `sudo docker build --rm -t infer_pythonnet .`
* Run the image by typing `sudo docker run -it -p 8888:8888 -v ${PWD}:/root/dev infer_pythonnet`
* The container will start a Jupyter notebook server. Go to <http://localhost:8888> and login with the token that is printed out in the terminal

## Limitations

Python.net cannot handle overloads of generic methods properly (see [issue](https://github.com/pythonnet/pythonnet/issues/821)). Calling `Variable.Observed(Array[Double]([...]))` returns `Variable[Double[]]` instead of `VariableArray[Double]`. To enforce a correct return type, we could do `Variable.Observed[Double](Array[Double]([...])))`, but python.net throws an exception. 

Possible soultions:

* Do the reflections manually, but this doesn't seem to work because `Variable` is an *abstract* class in Infer.Net and `Observed` is a static method. So the following does not work:

```python
lib = clr.AddReference("Microsoft.ML.Probabilistic")
var_type = lib.GetType("Microsoft.ML.Probabilistic.Models.Variable")
method = var_type.GetMethod("Observed")
...
```

`GetType` returns a None-type, since `Variable` is abstract.  
 
* Write C# library that wraps the function in a non-generic function. This seems to work, but in the end it is not needed (yet) because usage of `Variable.Observed` can be avoided in the simple examples.

## Notes on the usage of Infer.Net inside Jupyter Notebook

* Make sure to create `Variable` objects and assign to them in the **same** cell. Infer.Net doesn't allow to assign to a same Variable multiple times.

## Next

Try more complicated examples with visualizations of the network and inference results in python.

