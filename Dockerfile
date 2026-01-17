# Start from a full Ubuntu base image
FROM ubuntu:latest

# Prevent interactive prompts during package installation
ENV DEBIAN_FRONTEND=noninteractive

# Update and install all the basics
RUN apt-get update && apt-get install -y \
    build-essential \
    software-properties-common \
    apt-utils \
    pkg-config \
    git \
    curl \
    wget \
    vim \
    nano \
    unzip \
    bzip2 \
    ca-certificates \
    man-db \
    libevent-dev \
    libncurses5-dev \
    libncursesw5-dev \
    bison \
    flex \
    python3 \
    python3-pip \
    net-tools \
    iputils-ping \
    openssh-client \
    libssl-dev \
    zlib1g-dev \
    automake \
    autoconf \
    texinfo \
    perl \
    && rm -rf /var/lib/apt/lists/*

# Set default shell to bash
SHELL ["/bin/bash", "-c"]

# Default working directory
WORKDIR /root

# Example: print versions to confirm installation
CMD gcc --version && g++ --version && make --version && \
    git --version && curl --version && wget --version && \
    python3 --version && pip3 --version