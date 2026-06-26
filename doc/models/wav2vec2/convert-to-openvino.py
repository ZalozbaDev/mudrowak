#!/usr/bin/env python3

import openvino as ov
import openvino.properties as props
import openvino.properties.hint as hints
import openvino.properties.intel_cpu as cpu_props

from pathlib import Path
import sys
import os

onnx_file_in      = Path(sys.argv[1])
openvino_file_out = Path(sys.argv[2])

core = ov.Core()

def make_ov_config():
    return {
        hints.performance_mode:       hints.PerformanceMode.LATENCY,
        props.inference_num_threads:  OV_THREADS,
        hints.scheduling_core_type:   hints.SchedulingCoreType.ECORE_ONLY,
        hints.enable_hyper_threading: False,
        cpu_props.denormals_optimization: True,
    }

print(f"Building FP16 IR from ONNX and saving to {openvino_file_out}...")
Path(os.path.dirname(openvino_file_out)).mkdir(parents=True, exist_ok=True)
# os.makedirs(os.path.dirname(openvino_file_out), exist_ok=True)
ov.save_model(core.read_model(onnx_file_in), openvino_file_out)

print("OV FP16 IR ready.")
