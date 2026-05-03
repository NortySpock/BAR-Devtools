FROM docker.io/debian:trixie-slim

RUN apt-get -y update \
  && apt-get -y upgrade \
  && DEBIAN_FRONTEND=noninteractive apt-get -y --no-install-recommends install \
  ca-certificates \
  wget \
  iproute2 \
  perl-modules-5.40 \
  libffi-platypus-perl \
  libio-socket-ssl-perl \
  libdbd-sqlite3-perl \
  libanyevent-perl \
  libinline-python-perl \
  && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /opt/spads

WORKDIR /opt/spads
RUN wget http://planetspads.free.fr/spads/installer/spadsInstaller.tar -qO - | tar x
RUN perl spadsInstaller.pl --auto BarLanServerTest

EXPOSE 8200/tcp 8452/udp

ENTRYPOINT ["/usr/bin/perl","spads.pl","etc/spads.conf"]
