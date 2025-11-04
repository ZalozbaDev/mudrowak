# Simultan přełožowar na swójskim ličaku

- přistup na syć po instalacije njeje trjeba!

## Ličak wupytać

- Trjebaće jedyn Mac z "Apple Silicon" za spěšne spóznawanje (takmjenowany "CoreML support")

## Trěbnu software instalować

- Visual Studio Code (https://code.visualstudio.com/)
- XCode "Command line tools"
    - "xcode-select --install" za instalaciju
    - "softwareupdate --list" a "softwareupdate --install" za najnowšu wersiju
- Docker Desktop (https://docs.docker.com/desktop/setup/install/mac-install/)
- Homebrew (https://brew.sh/)
- python 3.11 (https://www.python.org/downloads/macos/) (snano tež "Homebrew" funguje)

## Docker startować

Program "Docker Desktop" startować, potom w terminalu spytać, hač běži:

```bash
docker ps
```

beži bjez zmylkow

## Software wobstarać

hlej README.md 

## Model za spóznawanje twarić

hlej README.md ze sćěhowacymi změnami:

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

hlej README.md

### sotra

```bash
cd modele
git checkout 89242e4fee9a59290b5e79531cc10319b9933ee7
cd sotra-lsf-ds/
cat README.md
cd Docker/
docker build -t sotra-lsf .

cd ../../
cd ctranslate-ol/
cat README.md

nano Dockerfile
--> po lince "WORKDIR /app" sćěhowace zapisać
RUN apt update && apt install -y cmake libboost-all-dev libre2-dev python3-pybind11
--> dataju składować (CTRL+X y)

docker build -t ctranslator .
```

- přidatne dataja pozdźišo do praweho rjadowaka kopěrować

### vosk

```bash
cd docker_vosk
git checkout 989035739ed43b5b388e5ae409ccfa5b265f098b
git clone https://github.com/ZalozbaDev/webrtc-audio-processing.git webrtc-audio-processing
cd webrtc-audio-processing && git checkout 8f54329708f2d5eef477b76339d44d9a31583118
brew install meson abseil cmake 
meson . build -Dprefix=$PWD/install && ninja -C build
cd ..

git clone https://github.com/ZalozbaDev/whisper.cpp.git whisper.cpp
cd whisper.cpp && git checkout v1.7.4
cmake -B build -DWHISPER_COREML=1 && cmake --build build -j --config Release
cd ..

brew install libsndfile hunspell icu4c boost

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

g++ -Wall -Wno-write-strings -O3 -g3 -std=c++17 -O3 -fPIC -o whisper_out/vosk_whisper_server \
-DVAD_FRAME_CONVERT_FLOAT \
-DGGML_BACKEND_SHARED -DGGML_SHARED -DGGML_USE_BLAS -DGGML_USE_CPU -DGGML_USE_METAL \
-I/opt/homebrew/opt/icu4c@77/include -I/opt/homebrew/opt/hunspell/include/hunspell -I/opt/homebrew/opt/libsndfile/include \
-I/opt/homebrew/Cellar/boost/1.89.0/include/ \
-Iwhisper_out/ -I. -Iwebrtc-audio-processing/webrtc/ -Iwhisper.cpp/ -Iwhisper.cpp/examples/ \
-Iwhisper.cpp/include/ -Iwhisper.cpp/ggml/include/ \
whisper_out/RecognizerBase.cpp \
whisper_out/vosk_api_wrapper.cpp whisper_out/VoskRecognizer.cpp whisper_out/VADWrapper.cpp whisper_out/AudioLogger.cpp \
whisper_out/HunspellPostProc.cpp whisper_out/CustomPostProc.cpp \
whisper_out/asr_server.cpp \
webrtc-audio-processing/build/webrtc/common_audio/libcommon_audio.a \
-ldl -lpthread -lhunspell-1.7 -licuio -licuuc -lsndfile -lwhisper -lggml -lggml-cpu -lggml-base -Lwhisper_out/ \
-L /opt/homebrew/opt/hunspell/lib/ -L/opt/homebrew/opt/icu4c@77/lib/ -L/opt/homebrew/opt/libsndfile/lib/ 
```

## system startować

```bash
cd mudrowak/doc/webcaptioner
cp env.mac.example .env
cp -r ../../../modele/sotra-lsf-ds/Docker/models1 .
cp ../../../modele/ctranslate-ol/version.txt .
docker compose -f docker-compose.macos.yml up -d
```

```bash
cd docker_vosk
DYLD_LIBRARY_PATH=./whisper_out/ VOSK_SAMPLE_RATE=48000 ./whisper_out/vosk_whisper_server 0.0.0.0 2700 1 ~/whisper_models/Korla/whisper_large_v3_turbo_hsb/coreml/ggml-large-v3-turbo.bin
```

