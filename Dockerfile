FROM alpine:latest
LABEL description="Dnsproxy with custom configuration. Only dns servers from Cloudflare, Quad9 and Cisco OpenDNS are used."
LABEL org.opencontainers.image.authors="Maksim Prianichnikov, https://github.com/prianichnikov"

RUN cd /tmp \
    && wget "https://github.com/AdguardTeam/dnsproxy/releases/download/v0.49.1/dnsproxy-linux-amd64-v0.49.1.tar.gz" -O - | tar xz \
    && mv linux-amd64/dnsproxy /usr/bin/ \
    && dnsproxy --version \
    && rm -rf /tmp/linux-amd64

EXPOSE 53/udp

ENV ARGS="--tls-min-version=1.2 -u tls://cloudflare-dns.com -u tls://dns10.quad9.net -u tls://dns.opendns.com -b 1.0.0.1 -b 9.9.9.10 -b 208.67.222.222"

CMD /usr/bin/dnsproxy ${ARGS}