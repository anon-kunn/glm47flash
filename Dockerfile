FROM nvidia/cuda:12.1.0-runtime-ubuntu22.04
RUN apt-get update && apt-get install -y \
    wget \
    && rm -rf /var/lib/apt/lists/*
WORKDIR /app
RUN wget https://huggingface.co/unsloth/GLM-4.7-Flash-GGUF/resolve/main/GLM-4.7-Flash-Q4_K_M.gguf
RUN wget https://github.com/ggerganov/llama.cpp/releases/download/b7852/llama-b7852-bin-ubuntu-x64.tar.gz && \
    tar -xzf llama-b7852-bin-ubuntu-x64.tar.gz && \
    mv llama-b7852/llama-server . && \
    mv llama-b7852/lib* . && \
    rm -rf llama-b7852 llama-b7852-bin-ubuntu-x64.tar.gz
ENV LD_LIBRARY_PATH=/app:$LD_LIBRARY_PATH
EXPOSE 8080
CMD ["/app/llama-server", \
    "--model", "/app/GLM-4.7-Flash-Q4_K_M.gguf", \
    "--host", "0.0.0.0", \
    "--port", "8080", \
    "--ctx-size", "8192"]
