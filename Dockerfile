# Download base image ubuntu 18.04
FROM ubuntu:18.04

# Use bash instead of shell
SHELL ["/bin/bash", "-c"]

# Update Ubuntu Software repository
RUN apt-get update && apt-get install -y \
        curl \
        wget \
        python3-pip \
        software-properties-common \
        unzip \
        clang \
        libglib2.0-dev \
        python3.6-dev \
        graphviz

# install Mono and nuget (needed for pythonnet)
RUN apt install gnupg ca-certificates \
    && apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF \
    && echo "deb https://download.mono-project.com/repo/ubuntu stable-bionic main" | tee /etc/apt/sources.list.d/mono-official-stable.list \
    && apt-get update \ 
    && apt-get install -y mono-complete \
    && curl -o /usr/local/bin/nuget.exe https://dist.nuget.org/win-x86-commandline/latest/nuget.exe

# install infer.net packages and copy all dlls to same folder (so pythonnet can find them) 
RUN mkdir -p /root/dotNet/packages && cd /root/dotNet/packages \
    && export NUGET="mono /usr/local/bin/nuget.exe install -ExcludeVersion" \
    && ${NUGET} Microsoft.ML.Probabilistic \
    && ${NUGET} Microsoft.ML.Probabilistic.Compiler \
    && ${NUGET} Microsoft.ML.Probabilistic.Learners \
    && mkdir -p /root/dotNet/libs \
    && find /root/dotNet/packages/ -type f -name '*.dll' -exec cp -n {} /root/dotNet/libs ';'

# install pythonnet and jupyter notebook
RUN mkdir /root/Downloads && cd /root/Downloads \
    && pip3 install pycparser \
    && pip3 install -U setuptools \
    && pip3 install -U wheel \
    && wget https://github.com/pythonnet/pythonnet/archive/master.zip \
    && unzip master.zip \
    && rm master.zip \
    && cd pythonnet-master \
    && pip3 install . \
    && pip3 install jupyter

RUN pip3 install bokeh==1.0.4 matplotlib numpy scipy pymc3

WORKDIR /root/dev

ENTRYPOINT ["jupyter", "notebook", "--no-browser", "--allow-root", "--ip=0.0.0.0", "--port=8888"]

