FROM local/llama.cpp:server-cuda
WORKDIR /app

# Download model during build
RUN wget https://huggingface.co/unsloth/GLM-4.7-Flash-REAP-23B-A3B-GGUF/resolve/main/GLM-4.7-Flash-REAP-23B-A3B-UD-Q4_K_XL.gguf

COPY download-and-run.sh /app/
RUN chmod +x /app/download-and-run.sh
EXPOSE 8765
ENTRYPOINT ["/app/download-and-run.sh"]
