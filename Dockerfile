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
    fuse \
    && rm -rf /var/lib/apt/lists/*

# Set default shell to bash
SHELL ["/bin/bash", "-c"]

# Create a non-root user for testing
RUN useradd -m -s /bin/bash devuser && \
    mkdir -p /home/devuser/.local && \
    chown -R devuser:devuser /home/devuser

# Switch to non-root user
USER devuser

# Set GitHub token for higher API rate limits (build arg, override with: docker build --build-arg GITHUB_TOKEN=your_token)
ARG GITHUB_TOKEN=""
ENV GITHUB_TOKEN=${GITHUB_TOKEN}

# Default working directory
WORKDIR /home/devuser

# Copy local context (build context) into the container
COPY --chown=devuser:devuser . /tmp/bootstrap

# Step 1: Install mise and trust .mise.toml
RUN cd /tmp/bootstrap && \
    curl https://mise.jdx.dev/install.sh | sh - && \
    /home/devuser/.local/bin/mise trust

# Step 2: Run make install to install all configured tools
RUN cd /tmp/bootstrap && \
    make install && \
    echo "✅ Installation completed as non-root user!"

# Step 3: Verify installation and test basic CLI tools
RUN export PATH="/home/devuser/.local/bin:$PATH" && \
    echo "Installed tools in mise:" && \
    mise ls --current && \
    echo "" && \
    echo "Testing basic CLI tools:" && \
    rg --version && \
    fd --version && \
    bat --version && \
    fzf --version && \
    echo "" && \
    echo "Testing development tools:" && \
    nvim --version | head -1 && \
    go version && \
    rustc --version && \
    echo "" && \
    echo "✅ All installations work as non-root user!"

# Example: print versions to confirm installation
CMD bash -i