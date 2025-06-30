# n8n-workflows

Custom n8n Docker image with enhanced capabilities for media processing and Ethereum operations.

## Features

This custom n8n image extends the official n8n image with:

### Media Processing
- **FFmpeg** - Audio/video processing, format conversion, streaming
- **ImageMagick** - Image manipulation and processing
- **PCM to WAV conversion** - Audio format conversion capabilities

### Ethereum & Crypto
- **Viem** - Modern Ethereum library for transaction signing and smart contract interaction
- **Wagmi** - React hooks for Ethereum (core functions available in n8n)
- **ECDSA Support** - Built-in Node.js crypto module for digital signatures
- **Multi-chain Support** - Support for various Ethereum networks

## Usage

### Local Development
```bash
# Build the custom image
docker build -t n8n-custom .

# Run with Docker
docker run -it --rm \
  --name n8n \
  -p 5678:5678 \
  -v ~/.n8n:/home/node/.n8n \
  n8n-custom
```

### Railway Deployment
This image is configured for Railway deployment with:
- Alpine Linux base for smaller image size
- Optimized package installation
- Proper user permissions

## Code Examples

### FFmpeg Operations
```javascript
// PCM to WAV conversion
const { exec } = require('child_process');

exec('ffmpeg -f s16le -ar 44100 -ac 1 -i input.pcm output.wav', (error, stdout, stderr) => {
  if (error) {
    console.error(`Error: ${error}`);
    return;
  }
  console.log('Conversion complete');
});
```

### Ethereum Operations
```javascript
const { createWalletClient, http } = require('viem');
const { privateKeyToAccount } = require('viem/accounts');
const { mainnet } = require('viem/chains');

// Create wallet from private key
const account = privateKeyToAccount('your-private-key');
const client = createWalletClient({
  account,
  chain: mainnet,
  transport: http()
});

// Sign and send transaction
const hash = await client.sendTransaction({
  to: '0x...',
  value: parseEther('0.1')
});
```

### ECDSA Signing
```javascript
const crypto = require('crypto');

// Create ECDSA key pair
const { privateKey, publicKey } = crypto.generateKeyPairSync('ec', {
  namedCurve: 'secp256k1'
});

// Sign data
const data = Buffer.from('Hello World');
const signature = crypto.sign('sha256', data, privateKey);
```

## Security Notes

- Store private keys securely using environment variables
- Never hardcode sensitive data in workflow code
- Use Railway's environment variable system for secrets
- Consider using hardware wallets for production environments

## Dependencies

### System Packages (Alpine Linux)
- `ffmpeg` - Media processing
- `ffmpeg-dev` - Development headers
- `imagemagick` - Image processing

### Node.js Packages
- `@ffmpeg-installer/ffmpeg` - Modern ffmpeg wrapper
- `wagmi` - Ethereum React hooks
- `viem` - Modern Ethereum library
- `@wagmi/core` - Core utilities
- `@viem/chains` - Chain definitions

## License

[Add your license here]
