FROM ubuntu:latest
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get install -y --no-install-recommends apt-utils
RUN apt-get update && apt-get upgrade -y && apt-get -y install \
    tzdata \
    python-pip \
    python3 \
    nmap \
    curl \
    libffi-dev \
    build-essential \
    libssl-dev && \
    rm -rf /var/lib/apt/lists/*
RUN ln -fs /usr/share/zoneinfo/Etc/UTC /etc/localtime && dpkg-reconfigure --frontend noninteractive tzdata
ADD requirements.txt /
RUN pip3 install --upgrade setuptools pip
RUN pip3 install -r /requirements.txt
RUN pip3 install honcho
ADD . /
RUN find -name "*.sh" -exec chmod 755 {} \;
CMD honcho start
