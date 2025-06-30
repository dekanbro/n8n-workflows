# Start from official n8n image
FROM n8nio/n8n:latest

# Install ffmpeg and any needed system tools
USER root
RUN apk update && \
    apk add --no-cache \
        ffmpeg \
        ffmpeg-dev \
        imagemagick \
        && \
    rm -rf /var/cache/apk/*

# Switch back to node user
USER node

# Install crypto and media processing packages
RUN pnpm add fluent-ffmpeg wagmi viem @wagmi/core @viem/chains @viem/wallet

# Done — the rest is inherited from the n8n image 
