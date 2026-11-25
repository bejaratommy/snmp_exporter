FROM docker.io/golang:alpine AS build
WORKDIR /src
ADD --checksum=sha256:9c52951606f9138af758fd28693497181ad119b48433c0a542b4a2128049bd04 https://github.com/prometheus/snmp_exporter/archive/v0.31.0.tar.gz /tmp/snmp_exporter.tar.gz
RUN tar -xzvf /tmp/snmp_exporter.tar.gz --strip-components=1 \
    && go get \
      github.com/prometheus/common@v0.74.0 \
      github.com/prometheus/exporter-toolkit@v0.21.0 \
      go.yaml.in/yaml/v2@v2.4.5 \
      github.com/mdlayher/socket@v0.8.0 \
      github.com/mdlayher/vsock@v1.4.0 \
      github.com/jpillora/backoff@v1.1.0 \
      github.com/prometheus/procfs@v0.23.0 \
      github.com/xhit/go-str2duration/v2@v2.2.0 \
      golang.org/x/crypto@v0.59.0 \
      golang.org/x/sync@v0.25.0 \
      golang.org/x/oauth2@v0.38.0 \
      golang.org/x/net@v0.63.0 \
      golang.org/x/text@v0.44.0 \
      golang.org/x/time@v0.16.0 \
      golang.org/x/sys@v0.50.0 \
    && go mod tidy \
    && go install
RUN mkdir /rootfs \
      && cp /src/snmp.yml /rootfs/ \
    && mkdir /rootfs/bin \
      && cp /go/bin/snmp_exporter /rootfs/bin/ \
    && mkdir /rootfs/etc \
      && echo 'nogroup:*:10000:nobody' > /rootfs/etc/group \
      && echo 'nobody:*:10000:10000:::' > /rootfs/etc/passwd

FROM scratch
COPY --from=build --chown=10000:10000 /rootfs /
USER 10000:10000
EXPOSE 9116/tcp
ENTRYPOINT ["/bin/snmp_exporter"]
