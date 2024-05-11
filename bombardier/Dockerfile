# TODO: Play with Docker
# bombardier -n 1000 -c 50 http://129.154.225.249:20001/

FROM golang:latest as builder
# TODO: [下载就行了](https://github.com/codesenberg/bombardier/releases)
RUN go install github.com/codesenberg/bombardier@latest

FROM debian:stable-slim
COPY --from=builder /go/bin/bombardier /usr/local/bin/bombardier
ENTRYPOINT ["/usr/local/bin/bombardier"]
CMD ["--help"]