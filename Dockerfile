FROM debian:buster

RUN apt-get update -y && apt-get install -y git python3 python3-pip wget
WORKDIR /usr/local/bin
SHELL ["/bin/bash", "-o", "pipefail", "-c"]
RUN wget -O- -q https://github.com/kubernetes-sigs/kustomize/releases/download/kustomize%2Fv4.1.2/kustomize_v4.1.2_linux_amd64.tar.gz | tar xzf -

RUN useradd deploy -u 1030 -d /home/deploy -m
WORKDIR /deploy
COPY . /deploy
RUN chmod 755 /deploy/deploy.sh
RUN chown -R 1030 /deploy
USER 1030
