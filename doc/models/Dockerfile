FROM python:3.10.12-slim-bookworm

# docker build --progress=plain -t convert_to_ggml .

COPY requirements.txt /

RUN pip install -r /requirements.txt

RUN apt update && apt install -y git git-lfs

RUN git clone https://github.com/ggerganov/whisper.cpp /whisper.cpp_v1_7_1 && cd whisper.cpp_v1_7_1 && git checkout v1.7.1

RUN git clone https://github.com/ggerganov/whisper.cpp /whisper.cpp_v1_7_2 && cd whisper.cpp_v1_7_2 && git checkout v1.7.2

RUN git clone https://github.com/ggerganov/whisper.cpp /whisper.cpp_v1_7_4 && cd whisper.cpp_v1_7_4 && git checkout v1.7.4

COPY convert.sh /

COPY convert-safetensors-to-ggml.py /

RUN chmod 755 convert.sh

RUN mkdir -p /cache/ /output/

RUN git lfs install
