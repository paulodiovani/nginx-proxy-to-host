# nginx-proxy-to-host

Reverse proxy configuration to connect to apps running or exposed to host ports.

Using [nginx-proxy] Docker image.

[nginx-proxy]: https://hub.docker.com/r/nginxproxy/nginx-proxy

## Usage

1. Create a `docker-compose.override.yml` based on the example.

```bash
cp docker-compose.override.yml.example docker-compose.override.yml
```

2. Edit the `docker-compose.override.yml` with as many services you need,
  setting their host names and listened port.

```yaml
# vi: ft=yaml
version: '3.9'

services:
  myservice-001:
    extends:
      file: docker/proxy-to-host.yml
      service: proxy-to-host
    profiles: []
    environment:
      - VIRTUAL_HOST=myservice-001.local
      - HOST_PORT=8000

  myservice-002:
    extends:
      file: docker/proxy-to-host.yml
      service: proxy-to-host
    profiles: []
    environment:
      - VIRTUAL_HOST=myservice-002.local
      - HOST_PORT=9000
```

3. (Optional) To be able to use `HTTPS`, copy the certs `.crt` and `.key` files to `nginx/certs/` folder. The cert and key filename must match the domain mains.
  + `mysservice-001.local.crt`
  + `mysservice-001.local.key`
  + `mysservice-002.local.crt`
  + `mysservice-002.local.key`

3. (Optional) Set the domain names on your `/etc/hosts`, if you're using anything different from `*.localhost`

```hosts
127.0.0.1 myservice-001.local
127.0.0.1 myservice-002.local
```

4. Start the services

```bash
docker compose up
```

5. Access your domains as normal from the browser.

  + http://myservice-001.local
  + http://myservice-002.local

