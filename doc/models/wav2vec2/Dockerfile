FROM python:3.10.12-slim-bookworm

# docker build --progress=plain -t convert_to_onnx .

COPY requirements.txt /

RUN pip install -r /requirements.txt

RUN apt update && apt install -y git git-lfs

COPY convert.sh /

COPY convert-to-onnx.py /
COPY convert-to-openvino.py /

RUN chmod 755 convert.sh

RUN mkdir -p /cache/ /output/

RUN git lfs install

