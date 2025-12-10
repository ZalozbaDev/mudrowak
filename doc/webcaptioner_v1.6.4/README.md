# Simultan přełožowar na swójskim ličaku

## Powšitkowne přihoty

Sćěhujće nawodom [tule](../webcaptioner/README.md) wot zapoatka hač do wotrězka "Software wobstarać"

## Model za spóznawanje twarić

```bash
cd mudrowak/doc/models/
jedit README.md
--> dźěl spody "code" linku-po-lince wuwjesć, při tym pak prawy model wuzwolić, tule doporučeny model:

docker run -e MODEL="Korla/whisper-large-v3-turbo-hsb-0" --mount type=bind,source=$HOME/cache,target=/cache/ --mount type=bind,source=$HOME/whisper_models,target=/output/ -it convert_to_ggml /convert.sh 
```

- model pozdźišo do praweho rjadowaka kopěrować

## Jednotliwe containery twarić

### webcaptioner

```bash
cd webcaptioner-ng
git checkout v1.6.4
cat README.md
docker build -f docker/Dockerfile -t webcaptioner-ng .
```

```bash
cd webcaptioner-ng-server
git checkout v1.6.4
cat README.md
docker build -f docker/Dockerfile -t webcaptioner-ng-back .
```

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
docker build -t ctranslator .
```

- přidatne dataja pozdźišo do praweho rjadowaka kopěrować

### vosk

```bash
cd docker_vosk
git checkout 05baa5b31d0b4a712a8b13082b91a1c76f4f8d43
sudo apt install -y nvidia-cuda-toolkit gcc g++
./detect_whisper_options.sh
head vosk_server_whisper/Dockerfile 
docker build ...
```

### bamborak

```bash
git clone https://github.com/ZalozbaDev/bamborak
git lfs install
git clone https://huggingface.co/Thorsten-Voice/VITS
cd bamborak
git checkout c88859ea3d3cfa97b7ae7c935de228707c70fda2
git checkout 0c8a2163e9f8929259482e1736e3916bf843aba6 -- backend/config.json
./detect_accel_options.sh
cd backend
docker build ...
```

nowše ličaki (najnowše NVIDIA karty), prošu hinaši "Dokerfile" wužiwać:

```bash
...
git checkout 0c8a2163e9f8929259482e1736e3916bf843aba6 -- backend/config.json
git checkout b551453d751adb9bdd505e9857764034b986201c -- backend/Dockerfile.py312.cuda
...

...
cd backend
docker build -f Dockerfile.py312.cuda ...
```

## system startować

```bash
cd mudrowak/doc/webcaptioner_v1.6.4
cp env.example .env
cp -r ../../../modele/sotra-lsf-ds/Docker/models1 .
cp ../../../modele/ctranslate-ol/version.txt .
cp -r ../../../whisper_models/Korla whisper/
cp ../models/replacement_lists/Korla_whisper_large_v3_turbo_hsb-0.txt whisper/
mkdir logs
mkdir tts-modele
cp ../../../VITS/config.json     tts-modele/thorsten.json
cp ../../../VITS/model_file.pth  tts-modele/thorsten.pth
sudo apt install -y python3-distutils-extra
docker-compose up -d
```

- system přeco awtomatisce zaběži, hdyž so ličak zaswěći

- kontrola

```bash
docker-compose logs -f
```

- wuspytać z Firefox

http://localhost

hdyž browser to na "https" změni, ručne zaso na "http" stajić

