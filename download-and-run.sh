#!/bin/bash

# Download GLM-4.7-Flash-REAP-23B-A3B-UD-Q4_K_XL.gguf model if not present
MODEL_URL="https://huggingface.co/unsloth/GLM-4.7-Flash-REAP-23B-A3B-GGUF/resolve/main/GLM-4.7-Flash-REAP-23B-A3B-UD-Q4_K_XL.gguf"
MODEL_PATH="/app/GLM-4.7-Flash-REAP-23B-A3B-UD-Q4_K_XL.gguf"

if [ ! -f "$MODEL_PATH" ]; then
    echo "Downloading model from HuggingFace..."
    wget -O "$MODEL_PATH" "$MODEL_URL"
    echo "Model downloaded successfully!"
fi

# Authentication credentials from environment variables
LLAMA_USERNAME="${LLAMA_USERNAME:-admin}"
LLAMA_PASSWORD="${LLAMA_PASSWORD:-$(head /dev/urandom | tr -dc A-Za-z0-9 | head -c 32)}"

# Display credentials on first run
if [ ! -f "/app/.credentials_shown" ]; then
    echo "=========================================="
    echo "  SERVER AUTHENTICATION CREDENTIALS"
    echo "=========================================="
    echo "  Username: $LLAMA_USERNAME"
    echo "  Password: $LLAMA_PASSWORD"
    echo "  Port: 8765"
    echo "=========================================="
    touch /app/.credentials_shown
fi

# Start llama-server with authentication and port 8765
exec /app/llama-server \
    --model "$MODEL_PATH" \
    --host 0.0.0.0 \
    --port 8765 \
    --ctx-size 202752 \
    --api-key "$LLAMA_USERNAME:$LLAMA_PASSWORD"
