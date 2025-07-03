# Start from official n8n image
FROM n8nio/n8n:latest

# Switch to root for installing OS-level packages
USER root

# Install system dependencies like ffmpeg and imagemagick
RUN apk update && apk add --no-cache \
    ffmpeg \
    ffmpeg-dev \
    imagemagick \
 && rm -rf /var/cache/apk/*

# Set environment variables for Code node permissions
ENV NODE_FUNCTION_ALLOW_BUILTIN=fs,path,crypto
ENV NODE_FUNCTION_ALLOW_EXTERNAL=@ffmpeg-installer/ffmpeg,wagmi,viem,@wagmi/core

# Set working directory for user-level node_modules
WORKDIR /home/node/.n8n

# Install your external packages where n8n Code nodes can access them
RUN pnpm add @ffmpeg-installer/ffmpeg wagmi viem @wagmi/core

# Switch back to the node user as required by n8n
USER node
