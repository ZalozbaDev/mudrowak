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

TBD

## system startować

```bash
cd mudrowak/doc/webcaptioner_v1.6.4
cp env.example .env
cp -r ../../../modele/sotra-lsf-ds/Docker/models1 .
cp ../../../modele/ctranslate-ol/version.txt .
cp -r ../../../whisper_models/Korla whisper/
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

