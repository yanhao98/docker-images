# TODO: Play with Docker
# docker run --rm yanhao98/bombardier -n 1000 -c 50 https://oo1.dev/

FROM golang:latest@sha256:72e8f4d661b29c3974572ee8add5cf99985804a85cd5678b912c5b2a4002c56f as builder
# TODO: [下载就行了](https://github.com/codesenberg/bombardier/releases)
RUN go install github.com/codesenberg/bombardier@latest

FROM debian:stable-slim@sha256:2b2e35d67c8fda0ba853d40cd18e57b99ab12d82fd3200607015eb09784068bd
COPY --from=builder /go/bin/bombardier /usr/local/bin/bombardier
RUN apt-get update && apt-get install -y ca-certificates && rm -rf /var/lib/apt/lists/*
ENTRYPOINT ["/usr/local/bin/bombardier"]
CMD ["--help"]