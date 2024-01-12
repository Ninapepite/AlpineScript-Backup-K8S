FROM alpine:latest

RUN apk add --no-cache python3 py3-pip tar gzip curl jq tzdata
RUN pip3 install --upgrade pip
RUN pip3 install --upgrade pip --no-cache-dir awscli awscli_plugin_endpoint
RUN rm -rf /var/cache/apk/*

ENV TZ=Europe/Paris

ENV VOL_TMPDIR /backup

RUN mkdir /${VOL_TMPDIR} && chmod 770 /${VOL_TMPDIR}

VOLUME [ "/${VOL_TMPDIR}" ]

RUN curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl

RUN chmod +x ./kubectl
RUN mv ./kubectl /usr/local/bin

COPY entrypoint.sh ./entrypoint.sh
COPY cronScript.sh /usr/local/bin/cronScript.sh
COPY ./s3config.sh ./s3config.sh
COPY ./s3push.sh ./s3push.sh
RUN chmod +x ./s3config.sh ./s3push.sh ./entrypoint.sh /usr/local/bin/cronScript.sh
RUN mv ./s3push.sh /usr/local/bin
RUN mv ./s3config.sh /usr/local/bin

ENTRYPOINT [ "/entrypoint.sh" ]
CMD [ "/bin/sh" ]

# COPY ./crontab /etc/crontabs/root

# RUN chown root:root /etc/crontabs/root && chmod 600 /etc/crontabs/root