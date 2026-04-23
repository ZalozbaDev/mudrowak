# Wosebitosće za MacOS

## Model za spóznawanje twarić

* jenož modele, kiž w tabulce maja křižik pola "coreml", wužiwać!
* potom sćěhowace skripty wuwjesć:

```bash
cd coreml/
./0001_venv.sh
./0005_install.sh
./0010_convert_coreml.sh
cd ..
```

## sotra

```bash
nano Dockerfile # abo hinaši editor

# po lince "WORKDIR /app" sćěhowace zapisać

RUN apt update && apt install -y cmake libboost-all-dev libre2-dev python3-pybind11

# dataju składować (CTRL+X y)

```

## vosk

```bash
cd docker_vosk
git checkout v2.0.0RC7
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
cd vosk-api && git checkout 7ac989311dd23d4d9e3e12de170f076eb5b77be6
cd ..

git clone https://github.com/ZalozbaDev/vosk-server.git vosk-server
cd vosk-server && git checkout aeb031987fb948941933936ffc802bf9c00ac461
cd ..

rm -rf whisper_out/
mkdir -p whisper_out/

cp common/*.h common/*.cpp whisper_out/

cp vosk_server_whisper/VoskRecognizer.cpp vosk_server_whisper/VoskRecognizer.h whisper_out/

cp whisper.cpp/build/src/*.dylib       whisper_out/
cp whisper.cpp/build/ggml/src/*.dylib  whisper_out/

cp vosk-api/src/vosk_api.h whisper_out/
cp vosk-server/websocket-cpp/asr_server.cpp whisper_out/

cp ~/mudrowak/doc/webcaptioner_v2.0.0/macos_vosk_compile_helper.sh .
./macos_vosk_compile_helper.sh
```

Hdyž so tule zmylki pokazaja, prošu w skripće te jednotliwe wersije wuporjedźić.

