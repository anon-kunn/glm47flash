FROM local/llama.cpp:server-cuda
WORKDIR /app
COPY download-and-run.sh /app/
RUN chmod +x /app/download-and-run.sh
EXPOSE 8080
CMD ["/app/download-and-run.sh"]
