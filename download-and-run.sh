#!/bin/bash

# Download GLM-4.7-Flash-REAP-23B-A3B-UD-Q4_K_XL.gguf model if not present
MODEL_URL="https://huggingface.co/unsloth/GLM-4.7-Flash-REAP-23B-A3B-GGUF/resolve/main/GLM-4.7-Flash-REAP-23B-A3B-UD-Q4_K_XL.gguf"
MODEL_PATH="/app/GLM-4.7-Flash-REAP-23B-A3B-UD-Q4_K_XL.gguf"

if [ ! -f "$MODEL_PATH" ]; then
    echo "Downloading model from HuggingFace..."
    wget -O "$MODEL_PATH" "$MODEL_URL"
    echo "Model downloaded successfully!"
fi

# Start llama-server with max context length (202752)
exec /app/llama-server \
    --model "$MODEL_PATH" \
    --host 0.0.0.0 \
    --port 8080 \
    --ctx-size 202752
