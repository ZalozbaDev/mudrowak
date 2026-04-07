#!/usr/bin/env python3

from transformers import AutoModelForCTC, AutoProcessor, AutoTokenizer
import librosa
import torch

dir_model   = Path(sys.argv[1])
path_out    = Path(sys.argv[2])

model = AutoModelForCTC.from_pretrained(dir_model).to("cpu").eval().to(torch.float16)
processor = AutoProcessor.from_pretrained(dir_model)

from torch.export.dynamic_shapes import Dim
dummy = torch.randn(1,16000, dtype=torch.float32)
inputs = processor(dummy, sampling_rate=16000, return_tensors="pt").to(torch.float16)

dynamic_shapes = {
    "input": {0: 1, 1: Dim.AUTO, 2: 160},
    "output": {0: 1, 1: Dim.AUTO, 2: 41}, # vocab size
}

torch.onnx.export(model, inputs["input_features"], path_out, input_names=["input"], output_names=["output"], dynamic_axes=dynamic_shapes, dynamo=True)

