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

# Create a non-root user for testing
RUN useradd -m -s /bin/bash devuser && \
    mkdir -p /home/devuser/.bin /home/devuser/.local && \
    chown -R devuser:devuser /home/devuser

# Switch to non-root user
USER devuser

# Default working directory
WORKDIR /home/devuser

# Clone the basic-ssh-config repo and run installation
RUN git clone https://github.com/Raina-Hardik/basic-ssh-config.git /tmp/basic-ssh-config && \
    cd /tmp/basic-ssh-config && \
    make install && \
    echo "✅ Installation completed as non-root user!" && \
    echo "" && \
    echo "Installed tools in ~/.bin:" && \
    ls -lah ~/.bin/ 2>/dev/null && \
    echo "" && \
    echo "Testing basic CLI tools:" && \
    ~/.bin/rg --version && \
    ~/.bin/fd --version && \
    ~/.bin/bat --version && \
    ~/.bin/fzf --version && \
    echo "" && \
    echo "Testing development tools:" && \
    ~/.local/nvim/bin/nvim --version | head -1 && \
    ~/.local/go/bin/go version && \
    ~/.cargo/bin/rustc --version && \
    echo "" && \
    echo "✅ All installations work as non-root user!"

# Example: print versions to confirm installation
CMD bash -i