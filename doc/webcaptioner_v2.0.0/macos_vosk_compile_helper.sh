#!/bin/bash

export BREW_ICU_VERSION=icu4c@77
export BREW_BOOST_VERSION=1.89.0_1
export BREW_ONNX_VERSION=1.22.2_6
export BREW_RESAMPLE_VERSION=0.1.3

echo "Checking ICU library ${BREW_ICU_VERSION}"
if [ ! -e /opt/homebrew/opt/${BREW_ICU_VERSION}/ ] ; then 
    echo "Error! ICU library ${BREW_ICU_VERSION} not found." ; 
    exit 1; 
fi

echo "Checking boost library ${BREW_BOOST_VERSION}"
if [[ ! -e /opt/homebrew/Cellar/boost/${BREW_BOOST_VERSION}/ ]] ; then 
    echo "Error! Boost library ${BREW_BOOST_VERSION} not found."
    exit 1
fi

echo "Checking ONNX runtime ${BREW_ONNX_VERSION}"
if [[ ! -e /opt/homebrew/Cellar/onnxruntime/${BREW_ONNX_VERSION}/ ]] ; then 
    echo "Error! ONNX library ${BREW_ONNX_VERSION} not found."
    exit 1
fi

echo "Checking libresample version ${BREW_RESAMPLE_VERSION}"
if [[ ! -e /opt/homebrew/Cellar/libresample/${BREW_RESAMPLE_VERSION}/ ]] ; then 
    echo "Error! Resample library ${BREW_RESAMPLE_VERSION} not found."
    exit 1
fi

g++ -Wall -Wno-write-strings -O3 -g3 -std=c++17 -O3 -fPIC -o whisper_out/vosk_whisper_server \
-DVAD_FRAME_CONVERT_FLOAT \
-Wno-mismatched-tags \
-DGGML_BACKEND_SHARED -DGGML_SHARED -DGGML_USE_BLAS -DGGML_USE_CPU -DGGML_USE_METAL \
-I/opt/homebrew/opt/${BREW_ICU_VERSION}/include -I/opt/homebrew/opt/hunspell/include/hunspell -I/opt/homebrew/opt/libsndfile/include \
-I/opt/homebrew/Cellar/boost/${BREW_BOOST_VERSION}/include/ \
-I/opt/homebrew/Cellar/libresample/${BREW_RESAMPLE_VERSION}/include/ \
-I/opt/homebrew/Cellar/onnxruntime/${BREW_ONNX_VERSION}/include/onnxruntime/ \
-Iwhisper_out/ -I. -Iwebrtc-audio-processing/webrtc/ -Iwhisper.cpp/ -Iwhisper.cpp/examples/ \
-Iwhisper.cpp/include/ -Iwhisper.cpp/ggml/include/ \
whisper_out/asr_server.cpp \
whisper_out/AudioLogger.cpp whisper_out/CustomPostProc.cpp whisper_out/HunspellPostProc.cpp whisper_out/RecognitionResultSplitter.cpp \
whisper_out/RecognizerBase.cpp whisper_out/RepetitionRemover.cpp whisper_out/ResamplerLibResample_48_16.cpp whisper_out/ResamplerWebRTC_48_16.cpp \
whisper_out/SileroVadIterator.cpp whisper_out/VADWrapperSilero.cpp whisper_out/VADWrapperWebRTC.cpp whisper_out/vosk_api_wrapper.cpp whisper_out/VoskRecognizer.cpp \
webrtc-audio-processing/build/webrtc/common_audio/libcommon_audio.a \
-ldl -lpthread -lhunspell-1.7 -licuio -licuuc -lsndfile -lonnxruntime -lresample -lwhisper -lggml -lggml-cpu -lggml-base -Lwhisper_out/ \
-L/opt/homebrew/opt/hunspell/lib/ -L/opt/homebrew/opt/${BREW_ICU_VERSION}/lib/ -L/opt/homebrew/opt/libsndfile/lib/ -L/opt/homebrew/opt/libresample/lib \
-L/opt/homebrew/Cellar/onnxruntime/${BREW_ONNX_VERSION}/lib
