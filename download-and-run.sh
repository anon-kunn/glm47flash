#!/bin/bash

# Model path (baked into image during build)
MODEL_URL="https://huggingface.co/unsloth/GLM-4.7-Flash-REAP-23B-A3B-GGUF/resolve/main/GLM-4.7-Flash-REAP-23B-A3B-UD-Q4_K_XL.gguf"
MODEL_PATH="/app/GLM-4.7-Flash-REAP-23B-A3B-UD-Q4_K_XL.gguf"

echo "[INFO] Starting GLM-4.7-Flash-REAP-23B-A3B initialization..."
sleep 1

if [ ! -f "$MODEL_PATH" ]; then
    echo "[INFO] Model not found, downloading from HuggingFace..."
    sleep 1
    echo "[INFO] Download URL: $MODEL_URL"
    sleep 1
    wget -O "$MODEL_PATH" "$MODEL_URL"
    sleep 1
    echo "[INFO] Model downloaded successfully!"
    sleep 1
else
    echo "[INFO] Model found at $MODEL_PATH (baked into image)"
    sleep 1
fi

# Authentication credentials from environment variables
echo "[INFO] Configuring authentication..."
sleep 1
LLAMA_USERNAME="${LLAMA_USERNAME:-admin}"
LLAMA_PASSWORD="${LLAMA_PASSWORD:-$(head /dev/urandom | tr -dc A-Za-z0-9 | head -c 32)}"

# Display credentials on first run
if [ ! -f "/app/.credentials_shown" ]; then
    echo "[INFO] First run - displaying credentials..."
    sleep 1
    echo "=========================================="
    echo "  SERVER AUTHENTICATION CREDENTIALS"
    echo "=========================================="
    echo "  Username: $LLAMA_USERNAME"
    echo "  Password: $LLAMA_PASSWORD"
    echo "  Port: 8765"
    echo "=========================================="
    sleep 1
    touch /app/.credentials_shown
else
    echo "[INFO] Credentials already configured (check logs for first run details)"
    sleep 1
fi

# Start llama-server with authentication and port 8765
echo "[INFO] Starting llama-server..."
sleep 1
echo "[INFO] Configuration:"
echo "  - Model: $MODEL_PATH"
echo "  - Host: 0.0.0.0"
echo "  - Port: 8765"
echo "  - Context size: 202752"
echo "  - Auth: Enabled"
sleep 1
echo "[INFO] Server starting..."

exec /app/llama-server \
    --model "$MODEL_PATH" \
    --host 0.0.0.0 \
    --port 8765 \
    --ctx-size 202752 \
    --api-key "$LLAMA_USERNAME:$LLAMA_PASSWORD"
