<div align="center">
	<p><img src="https://em-content.zobj.net/thumbs/160/apple/391/fire_1f525.png" width="100px"></p>
	<h1>snmp_exporter</h1>
	<p>Built-from-source container image of <a href="https://github.com/prometheus/snmp_exporter">snmp_exporter</a></p>
	<code>docker pull quay.io/ricardbejarano/snmp_exporter</code>
</div>


## Features

* Compiled from source during build time
* Updates bundled Go dependencies to the versions listed below
* Built `FROM scratch`, with zero bloat
* Reduced attack surface (no shell, no UNIX tools, no package manager...)
* Runs as unprivileged (non-`root`) user


## Tags

### Docker Hub

Available on Docker Hub as [`docker.io/ricardbejarano/snmp_exporter`](https://hub.docker.com/r/ricardbejarano/snmp_exporter):

- [`0.31.0`, `latest` *(Dockerfile)*](Dockerfile)

### RedHat Quay

Available on RedHat Quay as [`quay.io/ricardbejarano/snmp_exporter`](https://quay.io/repository/ricardbejarano/snmp_exporter):

- [`0.31.0`, `latest` *(Dockerfile)*](Dockerfile)


## Configuration

### Volumes

- Mount your **configuration** at `/snmp.yml`.


## Go dependency updates

The v0.31.0 source archive remains checksum-pinned. The build applies these
module updates before compiling; Go verifies downloads using its checksum database.
Unused modules are removed by `go mod tidy`.

| Module | Version |
| --- | --- |
| `github.com/prometheus/common` | `v0.74.0` |
| `github.com/prometheus/exporter-toolkit` | `v0.21.0` |
| `go.yaml.in/yaml/v2` | `v2.4.5` |
| `github.com/mdlayher/socket` | `v0.8.0` |
| `github.com/mdlayher/vsock` | `v1.4.0` |
| `github.com/jpillora/backoff` | `v1.1.0` |
| `github.com/prometheus/procfs` | `v0.23.0` |
| `github.com/xhit/go-str2duration/v2` | `v2.2.0` |
| `golang.org/x/crypto` | `v0.59.0` |
| `golang.org/x/sync` | `v0.25.0` |
| `golang.org/x/oauth2` | `v0.38.0` |
| `golang.org/x/net` | `v0.63.0` |
| `golang.org/x/text` | `v0.44.0` |
| `golang.org/x/time` | `v0.16.0` |
| `golang.org/x/sys` | `v0.50.0` |
