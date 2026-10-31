FROM docker.io/golang:alpine AS build
ADD --checksum=sha256:9c52951606f9138af758fd28693497181ad119b48433c0a542b4a2128049bd04 https://github.com/prometheus/snmp_exporter/archive/v0.31.0.tar.gz /tmp/snmp_exporter.tar.gz
RUN tar -xzvf /tmp/snmp_exporter.tar.gz --strip-components=1 \
    && go get \
      github.com/prometheus/common@v0.73.1 \
      github.com/jpillora/backoff@v1.1.0 \
      github.com/mdlayher/socket@v0.8.0 \
      github.com/prometheus/procfs@v0.23.0 \
      github.com/xhit/go-str2duration/v2@v2.2.0 \
      golang.org/x/net@v0.62.0 \
      golang.org/x/time@v0.16.0 \
    && go mod tidy \
    && go install
RUN mkdir /rootfs \
      && cp /go/snmp.yml /rootfs/ \
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
