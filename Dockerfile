FROM golang:latest as builder
COPY . /srv/gorpxy
RUN cd /srv/gorpxy &&\
    go build -o goproxy &&\
    ls -l

# 下载证书
# FROM alpine:latest as ca
# RUN apk --no-cache add ca-certificates

#
FROM scratch
LABEL source.url="https://github.com/fimreal/gorpxy"

# COPY --from=ca /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/
COPY --from=builder /srv/gorpxy/goproxy /gorpxy

ENTRYPOINT [ "/goproxy" ]