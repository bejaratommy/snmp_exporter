FROM docker.io/golang:alpine AS build
ADD --checksum=sha256:b6f8f01909e798eefd7ead07bdc263914221b4454c60c40097a1b23b73bac7b2 https://github.com/prometheus/snmp_exporter/archive/v0.29.0.tar.gz /tmp/snmp_exporter.tar.gz
RUN tar -xzvf /tmp/snmp_exporter.tar.gz --strip-components=1 \
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
