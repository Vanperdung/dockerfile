# Start from a basic Debian or Ubuntu image
FROM ubuntu:20.04

ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=UTC

# Install required dependencies for OpenWrt build
RUN apt-get update && \
    apt-get install -y \
        build-essential \
        git \
        subversion \
        libncurses5-dev \
        zlib1g-dev \
        gawk \
        flex \
        quilt \
        gettext \
        libssl-dev \
        xsltproc \
        rsync \
        unzip \
        file \
        python3 \
        python3-distutils \
        wget \
        time \
        sudo

RUN mkdir -p /opt/
COPY ./entrypoint.sh /opt

RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

ENTRYPOINT ["/opt/entrypoint.sh"]
CMD ["/bin/bash"]
