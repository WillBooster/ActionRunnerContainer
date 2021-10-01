FROM ubuntu
LABEL maintainer "Kazunori Sakamoto <exkazuu@willbooster.com>"

RUN apt-get update && apt-get upgrade -y \
    && ln -fs /usr/share/zoneinfo/Asia/Tokyo /etc/localtime \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y tzdata \
    && dpkg-reconfigure --frontend noninteractive tzdata \
    && apt-get install -y nodejs npm git curl wget php build-essential make \
    && npm install -g yarn \
    && useradd --create-home --shell /bin/bash ci \
    && apt-get autoremove -y \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

USER ci
WORKDIR /home/ci

RUN curl -o actions-runner-linux-x64-2.283.1.tar.gz -L https://github.com/actions/runner/releases/download/v2.283.1/actions-runner-linux-x64-2.283.1.tar.gz \
    && tar xzf ./actions-runner-linux-x64-2.283.1.tar.gz
