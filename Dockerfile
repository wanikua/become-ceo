FROM node:22-slim

LABEL maintainer="wanikua" \
      description="Become CEO - One-click AI Agent deployment" \
      org.opencontainers.image.source="https://github.com/wanikua/become-ceo"

# System dependencies
RUN apt-get update -qq && \
    apt-get install -y --no-install-recommends \
        curl git ca-certificates gnupg \
        chromium python3 python3-pip python3-venv && \
    # gh CLI
    curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg \
        | dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg 2>/dev/null && \
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] \
        https://cli.github.com/packages stable main" \
        > /etc/apt/sources.list.d/github-cli.list && \
    apt-get update -qq && apt-get install -y --no-install-recommends gh && \
    # Cleanup
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Chromium path
ENV PUPPETEER_EXECUTABLE_PATH=/usr/bin/chromium
ENV PUPPETEER_SKIP_CHROMIUM_DOWNLOAD=true

# OpenClaw
RUN npm install -g openclaw --loglevel=error

# OpenViking (Python dependencies)
RUN python3 -m venv /opt/openviking && \
    /opt/openviking/bin/pip install --no-cache-dir openviking && \
    ln -s /opt/openviking/bin/openviking /usr/local/bin/openviking 2>/dev/null || true
ENV PATH="/opt/openviking/bin:$PATH"

# Workspace (using $HOME for non-root compatibility)
ARG WORKSPACE=/root/clawd
RUN mkdir -p ${WORKSPACE}/memory ${WORKSPACE}/skills /root/.openclaw
WORKDIR ${WORKSPACE}

# Copy template files and init scripts
COPY docker/entrypoint.sh /entrypoint.sh
COPY docker/init-docker.sh /init-docker.sh
RUN chmod +x /entrypoint.sh /init-docker.sh

# Copy skills and templates
COPY skills/ ${WORKSPACE}/skills/

# Copy and build GUI Dashboard
COPY gui/ /opt/gui/
RUN cd /opt/gui && npm install --loglevel=error 2>/dev/null || true && \
    cd /opt/gui/server && npm install --loglevel=error 2>/dev/null || true

# Ports: Gateway WebUI + CEO Dashboard (optional)
EXPOSE 18789 18795

ENTRYPOINT ["/entrypoint.sh"]
CMD ["openclaw", "gateway", "--verbose"]
