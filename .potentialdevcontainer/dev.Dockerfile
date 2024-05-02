FROM hashicorp/packer:full

RUN apk add python3 gcc musl-dev libffi-dev openssl-dev python3-dev
RUN pip3 install ansible

CMD ["ls"]