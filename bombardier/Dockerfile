# TODO: Play with Docker
# docker run --rm yanhao98/bombardier -n 1000 -c 50 https://oo1.dev/

FROM golang:latest as builder
# TODO: [下载就行了](https://github.com/codesenberg/bombardier/releases)
RUN go install github.com/codesenberg/bombardier@latest

FROM debian:stable-slim
COPY --from=builder /go/bin/bombardier /usr/local/bin/bombardier
RUN apt-get update && apt-get install -y ca-certificates && rm -rf /var/lib/apt/lists/*
ENTRYPOINT ["/usr/local/bin/bombardier"]
CMD ["--help"]