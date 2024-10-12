# Headscale Docker Project

This repository contains the necessary files to build and run a Headscale server using Docker and deploy it on Fly.io.

## Contents

1. `Dockerfile`: Defines the Docker image for Headscale
2. `config.yaml`: Configuration file for Headscale
3. `fly.toml`: Configuration file for deploying to Fly.io

## Dockerfile

The Dockerfile is based on Alpine Linux 3.17.1 and installs Headscale version 0.19.0. It includes the following steps:

- Updates and upgrades the system
- Installs wget
- Downloads and installs Headscale
- Verifies the Headscale installation
- Copies the configuration file

## Headscale Configuration

The `config.yaml` file contains the configuration for the Headscale server. Key settings include:

- Server URL: `https://vpn.ammarf.sa:443`
- Listen address: `0.0.0.0:8080`
- Metrics address: `127.0.0.1:9090`
- IP prefixes: `100.64.0.0/10` and `fd7a:115c:a1e0::/48`
- Embedded DERP server enabled
- SQLite database
- DNS configuration with Google DNS (8.8.8.8)
- Magic DNS enabled with base domain `ammarf.sa`

## Fly.io Deployment

The `fly.toml` file configures the deployment to Fly.io:

- App name: `ammarf-headscale`
- Primary region: `cdg` (Paris)
- VM specifications: 1GB memory, 1 shared CPU
- Exposed ports: 80 (HTTP) and 443 (HTTPS)
- Health checks configured
- Persistent volume mounted at `/data`

## Usage

1. Build the Docker image:
   ```
   docker build -t headscale .
   ```

2. Run the container locally:
   ```
   docker run -p 8080:8080 -v /path/to/data:/data headscale
   ```

3. Deploy to Fly.io:
   ```
   fly deploy
   ```

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

