# docker-alpine-sslocalproxy
Tiny image which brings you a http proxy by using privoxy and shadowsocks-libev

# Usage

1. Create a Shadowsocks client configuration file at **<some_path>/ss-client.json** for example, with content:
```
{
    "server":"<server_ip>",
    "server_port":<server_port>,
    "local_port":1080,
    "password":"<password>",
    "timeout":180,
    "method":"<encryption>"
}
```
2. Run the following command:
```
docker run -d \
    -p <http_port>:8118 \
    -p <socks_port>:1080 \
    -v <some_path>/ss-client.json:/etc/shadowsocks-libev/config.json \
    sgrio/alpine-sslocalproxy
```
3. Now you have a HTTP proxy listening at port **8118** and a SOCKS proxy listening at port **1080**, go configure your browser with any of it.
