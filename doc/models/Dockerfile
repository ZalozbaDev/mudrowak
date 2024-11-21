FROM python:3.10.12-slim-bookworm

# docker build --progress=plain -t convert_to_ggml .

RUN pip install torch==2.5.1 numpy==2.1.3 transformers==4.46.3

RUN apt update && apt install -y git git-lfs

RUN git clone https://github.com/ggerganov/whisper.cpp && cd whisper.cpp && git checkout v1.7.1

COPY convert.sh /

RUN chmod 755 convert.sh

RUN mkdir -p /cache/ /output/

RUN git lfs install
