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

cp vosk_server_whisper/*.cpp vosk_server_whisper/*.h  vosk_server_whisper/VoskRecognizer.h whisper_out/

cp whisper.cpp/build/src/*.dylib       whisper_out/
cp whisper.cpp/build/ggml/src/*.dylib  whisper_out/

cp vosk-api/src/vosk_api.h whisper_out/
cp vosk-server/websocket-cpp/*.cpp vosk-server/websocket-cpp/*.h whisper_out/
cp -r vosk-server/websocket-cpp/nlohmann whisper_out/

cp ~/mudrowak/doc/webcaptioner_v2.0.0/macos_vosk_compile_helper.sh .
./macos_vosk_compile_helper.sh
```

Hdyž so tule zmylki pokazaja, prošu w skripće te jednotliwe wersije wuporjedźić.

## bamborak

```bash
git clone https://github.com/ZalozbaDev/bamborak
git lfs install
git clone https://huggingface.co/Thorsten-Voice/VITS
cd bamborak
git checkout 0c8a2163e9f8929259482e1736e3916bf843aba6
cd backend
brew install python@3.13 sox
./0001_venv.sh
./0005_install.sh
```

## system startować

### skripty přihotować za komfortabelny start słužbow

Dokelž spóznawanja a předčitanje na Mac OS separatnje běžeć dyrbi, wutworimy sebi skripty, kiž so z kliknjenjom na symbol wuwjesć daja.

```bash
echo "cd docker_vosk && DYLD_LIBRARY_PATH=./whisper_out/ VOSK_SAMPLE_RATE=48000 VOSK_WHISPER_NO_FALLBACK=true VOSK_SHOW_WORDS=True VOSK_REPLACEMENT_FILE=~/mudrowak/doc/models/replacement_lists/Korla_whisper_large_v3_turbo_hsb-0.txt ./whisper_out/vosk_whisper_server 0.0.0.0 2700 1 ~/whisper_models/Korla/whisper_large_v3_turbo_hsb-0/coreml/ggml-large-v3-turbo.bin" > ~/Desktop/spóznawanje.command
echo "cd bamborak/backend && mkdir -p temp/ && source pythonenv/bin/activate && python3.13 app.py" > ~/Desktop/předčitanje.command
chmod 755 ~/Desktop/spóznawanje.command
chmod 755 ~/Desktop/předčitanje.command
```

### start

Skripty "spóznawanje" a "předčitanje" wuwjesć.

```bash
cd mudrowak/doc/webcaptioner_v2.0.0
cp env.mac.example .env
cp -r ../../../modele/sotra-lsf-ds/Docker/models1 .
cp ../../../modele/ctranslate-ol/version.txt .
docker compose -f docker-compose.macos.yml up -d
```
