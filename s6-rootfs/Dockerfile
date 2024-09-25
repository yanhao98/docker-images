# https://github.com/just-containers/s6-overlay

FROM alpine:3@sha256:cdacfe818cee9df48aa1d6d87000500138926a798917f4c2993285aac3dbd8a1 as download-s6-overlay
# renovate: datasource=github-releases depName=just-containers/s6-overlay versioning=loose
ARG S6_OVERLAY_VERSION=v3.2.0.0
ARG S6_OVERLAY_BASE_URL=https://github.com/just-containers/s6-overlay/releases/download
RUN set -x && \
  apk add --no-cache --virtual .build-deps curl && \
  mkdir /s6-rootfs && \
  curl --fail ${S6_OVERLAY_BASE_URL}/${S6_OVERLAY_VERSION}/s6-overlay-noarch.tar.xz -SLo- | tar -C /s6-rootfs -Jxpf - && \
  curl --fail ${S6_OVERLAY_BASE_URL}/${S6_OVERLAY_VERSION}/s6-overlay-`uname -m| sed 's/armv7l/armhf/g'`.tar.xz -SLo- | tar -C /s6-rootfs -Jxpf - && \
  apk del .build-deps

# 🐳
FROM scratch
COPY --from=download-s6-overlay ["/s6-rootfs", "/"]