FROM ghcr.io/ggerganov/whisper.cpp:main as quantize

FROM python:3 as convertmodel
WORKDIR /opt

RUN pip install torch numpy transformers

COPY --from=quantize /app/models/convert-h5-to-ggml.py .
COPY whisper ./whisper
COPY hsb_stt_demo ./hsb_stt_demo

RUN python ./convert-h5-to-ggml.py ./hsb_stt_demo/hsb_whisper/ ./whisper .


FROM quantize
COPY --from=convertmodel /opt/ggml-model.bin ./
RUN ./quantize ./ggml-model.bin ./ggml-model.q8_0.bin q8_0

CMD exit 0
