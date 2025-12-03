# Simultan přełožowar na swójskim ličaku

Sćěhujće nawodom [tule](../webcaptioner/README.macos.md) wot započatka hač do wotrězka "Software wobstarać"

## Model za spóznawanje twarić

hlej [tule](README.md#model-za-spóznawanje-twarić) ze sćěhowacymi změnami:

* jenož modele, kiž w tabulce maja křižik pola "coreml", wužiwać!
* potom sćěhowace skripty wuwjesć:

```bash
cd coreml/
./0001_venv.sh
./0005_install.sh
./0010_convert_coreml.sh
cd ..
```

## Jednotliwe containery twarić

### webcaptioner

hlej [tule](README.md#webcaptioner)

### sotra

Hlej [tule](../webcaptioner/README.macos.md#sotra)

### bamborak

```bash
git clone https://github.com/ZalozbaDev/bamborak
git lfs install
git clone https://huggingface.co/Thorsten-Voice/VITS
cd bamborak
git checkout ea78647e4f26fb42cd005d4a47f6322892c5f050
cd backend
brew install python@3.11 sox
./0001_venv.sh
./0005_install.sh
```

### vosk

```bash
cd docker_vosk
git checkout 20ecb6aded304d30cb156985c02e40e7597ff499
git clone https://github.com/ZalozbaDev/webrtc-audio-processing.git webrtc-audio-processing
cd webrtc-audio-processing && git checkout 8f54329708f2d5eef477b76339d44d9a31583118
brew install meson abseil cmake 
meson . build -Dprefix=$PWD/install && ninja -C build
cd ..

git clone https://github.com/ZalozbaDev/whisper.cpp.git whisper.cpp
cd whisper.cpp && git checkout v1.7.4
cmake -B build -DWHISPER_COREML=1 && cmake --build build -j --config Release
cd ..

brew install libsndfile hunspell icu4c boost onnxruntime libresample

git clone https://github.com/ZalozbaDev/vosk-api.git vosk-api
cd vosk-api && git checkout 1053cfa0f80039d2956de7e05a05c0b8db90c3c0
cd ..

git clone https://github.com/ZalozbaDev/vosk-server.git vosk-server
cd vosk-server && git checkout 3d4ecb85bf5a8f39ead3749f49e7726fed3eed42
cd ..

rm -rf whisper_out/
mkdir -p whisper_out/

cp common/*.h common/*.cpp whisper_out/

cp vosk_server_whisper/VoskRecognizer.cpp vosk_server_whisper/VoskRecognizer.h whisper_out/

cp whisper.cpp/build/src/*.dylib       whisper_out/
cp whisper.cpp/build/ggml/src/*.dylib  whisper_out/

cp vosk-api/src/vosk_api.h whisper_out/
cp vosk-server/websocket-cpp/asr_server.cpp whisper_out/

export BREW_ICU_VERSION=icu4c@77
export BREW_BOOST_VERSION=1.89.0_1
export BREW_ONNX_VERSION=1.22.2_6
export BREW_RESAMPLE_VERSION=0.1.3

echo $BREW_ICU_VERSION; if [ ! -e /opt/homebrew/opt/${BREW_ICU_VERSION}/ ] ; then echo "Error! ICU library ${BREW_ICU_VERSION} not found." ; fi

echo $BREW_BOOST_VERSION; if [[ ! -e /opt/homebrew/Cellar/boost/${BREW_BOOST_VERSION}/ ]] ; then echo "Error! Boost library ${BREW_BOOST_VERSION} not found." ; fi

echo $BREW_ONNX_VERSION; if [[ ! -e /opt/homebrew/Cellar/onnxruntime/${BREW_ONNX_VERSION}/ ]] ; then echo "Error! ONNX library ${BREW_ONNX_VERSION} not found." ; fi

echo $BREW_RESAMPLE_VERSION; if [[ ! -e /opt/homebrew/Cellar/libresample/${BREW_RESAMPLE_VERSION}/ ]] ; then echo "Error! Resample library ${BREW_RESAMPLE_VERSION} not found." ; fi


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
```

## system startować

```bash
cd mudrowak/doc/webcaptioner_v1.6.4
cp env.mac.example .env
cp -r ../../../modele/sotra-lsf-ds/Docker/models1 .
cp ../../../modele/ctranslate-ol/version.txt .
docker compose -f docker-compose.macos.yml up -d
```

```bash
cd docker_vosk
DYLD_LIBRARY_PATH=./whisper_out/ VOSK_SAMPLE_RATE=48000 VOSK_WHISPER_NO_FALLBACK=true VOSK_SHOW_WORDS=True VOSK_REPLACEMENT_FILE=~/mudrowak/doc/models/replacement_lists/Korla_whisper_large_v3_turbo_hsb-0.txt ./whisper_out/vosk_whisper_server 0.0.0.0 2700 1 ~/whisper_models/Korla/whisper_large_v3_turbo_hsb/coreml/ggml-large-v3-turbo.bin
```

```bash
cd bamborak/backend
mkdir -p temp/
source pythonenv/bin/activate
PYTORCH_ENABLE_MPS_FALLBACK=1 python3.11 app.py
```

## komfort

echo "....." > ~/Desktop/spóznawanje.command
echo "....." > ~/Desktop/předčitanje.command
chmod 755 ~/Desktop/spóznawanje.command
chmod 755 ~/Desktop/předčitanje.command

