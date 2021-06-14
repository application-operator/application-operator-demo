FROM alpine:3.13.5

RUN apk update && apk upgrade
WORKDIR /usr/local/bin
SHELL ["/bin/ash", "-o", "pipefail", "-c"]
RUN wget -O- -q https://github.com/kubernetes-sigs/kustomize/releases/download/kustomize%2Fv4.1.2/kustomize_v4.1.2_linux_amd64.tar.gz | tar xzf -
RUN wget -O kubectl -q https://dl.k8s.io/release/v1.21.1/bin/linux/amd64/kubectl
RUN chmod 755 kubectl

RUN adduser deploy -u 1030 -h /home/deploy -D
WORKDIR /deploy
COPY . /deploy
RUN chmod 755 /deploy/deploy.sh
RUN chown -R 1030 /deploy
USER 1030
