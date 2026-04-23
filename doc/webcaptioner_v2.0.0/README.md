# Simultan přełožowar na swójskim ličaku

Systm zasadnje běži na ličakach z Linux (+ GPU), Windows (+ GPU) a MacOS (+ Apple Silicon). Najlěpje testowana je wersija z Linux.

Ličak móže so po instalacije ze syći wotpinyć, to rěka zo so při wužiwanju žane daty do syće njepřenjesu.

## Powšitkowne přihoty ličaka

## Ličak wupytać

### Linux a Windows

- grafikowa karta wot NVIDIA je trěbna, njedyrbi pak najnowša być
- hlej přehlad: https://arnon.dk/matching-sm-architectures-arch-and-gencode-for-various-nvidia-cards/
- karty pod nadpismom "Pascal" abo nowše su kmani
- spomjatkujće sebi tu ličbu zady "SM" (na přikład "61" za kartu "GTX 1060")
- karta dyrbi 4GB GPU RAM měć (hdyž ma samo 8GB GPU RAM, mamy wjetši wuběrk spóznawanskich modelow)
- někak 100..150GB městna swobodne na tačele

### MacOS

- Wšitke ličaki z "Apple Silicon" su kmani
- Husto maja nekajke "M" a po tym ličbu w mjenje ("MacBook Air M3" abo tak)

## Ličak přihotować

Za instalaciju a přihot Linux systema hladajće prošu [tu](./INSTALL_LINUX.md).

Za přihot Windows systema hladajće prošu [tu](./INSTALL_WINDOWS.md).

Za přihot MacOS systema hladajće prošu [tu](./INSTALL_MACOS.md).

## Software wobstarać

```bash
git clone https://github.com/ZalozbaDev/mudrowak
git clone https://github.com/ZalozbaDev/docker_vosk
git clone https://github.com/ZalozbaDev/webcaptioner-ng
git clone https://github.com/ZalozbaDev/webcaptioner-ng-server
git clone https://github.com/WitajSotra/modele
```

## Model za spóznawanje twarić

```bash
cd mudrowak/doc/models/
cat README.md

# dźěl spody "code" linku-po-lince wuwjesć, při tym pak prawy model wuzwolić, tule doporučeny model:

docker run -e MODEL="Korla/whisper-large-v3-turbo-hsb-0" --mount type=bind,source=$HOME/cache,target=/cache/ --mount type=bind,source=$HOME/whisper_models,target=/output/ -it convert_to_ggml /convert.sh 
```

Za MacOS prošu sćěhowace přidatne kročele přewjesć, hlej [tule](./QUIRKS_MACOS.md#model-za-spóznawanje-twarić).

- sebi spomjatkować, zo model pozdźišo do praweho rjadowaka kopěrować dyrbiće

## Jednotliwe containery twarić

### webcaptioner powjerch a backend

```bash
cd webcaptioner-ng
git checkout v2.0.0RC7
cat README.md
docker build -f docker/Dockerfile -t webcaptioner-ng .
```

```bash
cd webcaptioner-ng-server
git checkout v2.0.0RC7
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

Njeda-li so druhi kontejner za MacOS twarić, hlej pokiw [tule](./QUIRKS_MACOS.md#sotra).

- přidatne dataja pozdźišo do praweho rjadowaka kopěrować

### vosk

Za MacOS prošu hinašu wariantu za instalaciju wužiwać: [vosk](./QUIRKS_MACOS.md#vosk).

```bash
cd docker_vosk
git checkout v2.0.0RC7
sudo apt install -y nvidia-cuda-toolkit gcc g++
./detect_whisper_options.sh
head vosk_server_whisper/Dockerfile 
docker build ...
```

### bamborak

Za MacOS prošu hinašu wariantu za instalaciju wužiwać: [bamborak](./QUIRKS_MACOS.md#bamborak).

```bash
git clone https://github.com/ZalozbaDev/bamborak
brew install git-lfs
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

MacOS system dyrbi so hinak startować: [Mac OS start](./QUIRKS_MACOS.md#system-startować).

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

