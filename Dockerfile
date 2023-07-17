FROM golang:latest as builder
COPY . /srv/goproxy
RUN cd /srv/goproxy &&\
    go build -o goproxy &&\
    ls -l

# 下载证书
# FROM alpine:latest as ca
# RUN apk --no-cache add ca-certificates

#
FROM scratch
LABEL source.url="https://github.com/fimreal/goproxy"

# COPY --from=ca /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/
COPY --from=builder /srv/goproxy/goproxy /goproxy

ENTRYPOINT [ "/goproxy" ]