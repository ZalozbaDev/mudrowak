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
git checkout 0c8a2163e9f8929259482e1736e3916bf843aba6
cd backend
brew install python@3.13 sox
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

cp ~/mudrowak/doc/webcaptioner_v1.6.4/macos_vosk_compile_helper.sh .
./macos_vosk_compile_helper.sh
```

Hdyž so tule zmylki pokazaja, prošu w skripće te jednotliwe wersije wuporjedźić.

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
python3.13 app.py
```

## komfort

```bash
echo "....." > ~/Desktop/spóznawanje.command
echo "....." > ~/Desktop/předčitanje.command
chmod 755 ~/Desktop/spóznawanje.command
chmod 755 ~/Desktop/předčitanje.command
```

