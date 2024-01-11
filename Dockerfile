FROM alpine:latest

RUN apk add --no-cache python3 py3-pip tar gzip curl jq
RUN pip3 install --upgrade pip
RUN pip3 install --upgrade pip --no-cache-dir awscli awscli_plugin_endpoint
RUN rm -rf /var/cache/apk/*

ENV VOL_TMPDIR /backup

RUN mkdir /${VOL_TMPDIR} && chmod 770 /${VOL_TMPDIR}


VOLUME [ "/${VOL_TMPDIR}" ]

RUN curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl

RUN chmod +x ./kubectl
RUN mv ./kubectl /usr/local/bin

COPY entrypoint.sh ./entrypoint.sh
COPY ./s3config.sh ./s3config.sh
COPY ./s3push.sh ./s3push.sh
RUN chmod +x ./s3config.sh ./s3push.sh
RUN mv ./s3push.sh /usr/local/bin
RUN mv ./s3config.sh /usr/local/bin

ENTRYPOINT [ "entrypoint.sh" ]