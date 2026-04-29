# mudrowak

Nawod za instalaciju swójskeho systema za spóznawanje a simultany přełožk.

## Přihotowanja

### Spóznawanski system

#### Whisper

Hdyž NVIDIA grafikowu kartu maš.

```code
git clone https://github.com/ZalozbaDev/docker_vosk
cd docker_vosk/
git checkout unify_recognizers # TBD fixed commit hash
./detect_whisper_options.sh
head vosk_server_whisper/Dockerfile
docker build ...
```

Pohladaj za to tež na tutón nawod za [webcaptioner](doc/webcaptioner/README.md#vosk).

#### Wav2vec2

Hdyž grafikowu kartu nimaš.

```code
git clone https://github.com/ZalozbaDev/docker_vosk
cd docker_vosk/
git checkout unify_recognizers # TBD fixed commit hash
cd vosk_server_wav2vec2
docker build -t vosk_server_wav2vec2 --progress=plain .
```

### sotra.app za přełožk (z "libretranslate API")

```code
git clone https://github.com/ZalozbaDev/sotra_modele
cd sotra_modele/sotra-lsf-ds/Docker/
git checkout workaround_jitsi_limitation # TBD fixed commit hash
docker build -t sotra_libretranslate .
```

### "Jitsi Meet" jako "docker"

https://github.com/jitsi/docker-jitsi-meet/releases

wobstaraće sebi najnowši pakćik (.zip)

testowane su:

* 10184
* 10655

přihotujće sebi wšitko za instalaciju:

```code
rm -rf deploy/
mkdir -p deploy/
cd deploy/
unzip ../docker-jitsi-meet-stable-WERSIJA.zip
```

#### nastajenja

##### Whisper

```code
cd deploy/docker-jitsi-meet-stable-WERSIJA/
cp ../../config/custom.yml .
cp env.example .env
cat ../../config/env_append.txt >> .env
```

přidatne dataje za spóznawanje wobstarać a składować, hlej za spóznawanski model
tutón [nawod](doc/webcaptioner/README.md#model-za-spóznawanje-twarić)

```code
mkdir -p logs/ whisper/ model/
cp -r ../../../whisper_models/SELECTED_MODEL whisper/
cp ../../doc/models/replacement_lists/*.txt whisper/
```

##### Wav2vec2

```code
cd deploy/docker-jitsi-meet-stable-WERSIJA/
cp ../../config/wav2vec2/wav2vec2.yml .
cp env.example .env
cat ../../config/wav2vec2/env_append.txt >> .env
cp ../../config/wav2vec2/asr_server_config.json .
```

přidatne dataje za spóznawanje wobstarać a składować

```code
cd doc/models/wav2vec2/
cat README.md
```

model "Korla/Wav2Vec2BertForCTC-hsb-0" twarić.

potom trěbne dataje kopěrować:

```code
cd deploy/docker-jitsi-meet-stable-WERSIJA/
mkdir -p models/Korla/Wav2Vec2BertForCTC-hsb-0/
cp ../../../cache/Korla_Wav2Vec2BertForCTC-hsb-0/* models/Korla/Wav2Vec2BertForCTC-hsb-0/
cp ../../../onnx_models/Korla_Wav2Vec2BertForCTC-hsb-0/wav2vec2.onnx* models/Korla/Wav2Vec2BertForCTC-hsb-0/
```

##### zhromadne nastajenja

potom dataju ".env" wobdźěłać a sćěhowace nastajenja přiměrić:

* PUBLIC_URL
* JVB_ADVERTISE_IPS

přidatne dataje za přełožk wobstarać

```code
cp -r ~/sotra_modele/sotra-lsf-ds/Docker/models1 .
```

nowe hesła za cyły system wutworić

```code
./gen-passwords.sh 
```

### trěbne rjadowaki

tute rjadowaki wutworić / za nowu wersiju Jitsi wuprózdnić:

```bash
mkdir -p ~/.jitsi-meet-cfg/{web,transcripts,prosody/config,prosody/prosody-plugins-custom,jicofo,jvb,jigasi,jibri}
```

## Wužiwanje

### Zakładna wersija

```bash
docker-compose -f docker-compose.yml -f transcriber.yml -f jibri.yml -f custom.yml up -d
# abo
docker-compose -f docker-compose.yml -f transcriber.yml -f jibri.yml -f wav2vec2.yml up -d
```

### Přidawki

#### Etherpad

wukomentuj "ETHERPAD_URL_BASE=" w .env a startuj aplikaciju tak:

```bash
docker-compose -f docker-compose.yml -f transcriber.yml -f jibri.yml -f custom.yml -f etherpad.yml up -d
# abo
docker-compose -f docker-compose.yml -f transcriber.yml -f jibri.yml -f wav2vec2.yml -f etherpad.yml up -d
```

KEDŹBU! Tu njeje datowa banka za Etherpad nastajena! Pads so trajne njeskładuja!

#### Whiteboard (Excalidraw)

wukomentuj "WHITEBOARD_COLLAB_SERVER_URL_BASE=" w .env a startuj aplikaciju tak:

```bash
docker-compose -f docker-compose.yml -f transcriber.yml -f jibri.yml -f custom.yml -f whiteboard.yml up -d
# abo
docker-compose -f docker-compose.yml -f transcriber.yml -f jibri.yml -f wav2vec2.yml -f whiteboard.yml up -d
```
#### Wšitko hromadźe

```bash
docker-compose -f docker-compose.yml -f transcriber.yml -f jibri.yml -f custom.yml -f etherpad.yml -f whiteboard.yml up -d
# abo
docker-compose -f docker-compose.yml -f transcriber.yml -f jibri.yml -f wav2vec2.yml -f etherpad.yml -f whiteboard.yml up -d
```

### Wěstota

w ".env" tute 3 opcije zaswěćić:

* ENABLE_AUTH=1
* ENABLE_GUESTS=1
* AUTH_TYPE=internal

nastajenje wuẑiwarjow w contejneru "prosody"

wužiwarske mjeno a hesło přidać:

```bash
docker-compose exec prosody /bin/bash
prosodyctl --config /config/prosody.cfg.lua register WUŽIWARSKE_MJENO meet.jitsi HESŁO
```

wužiwarjo pokazać a wumazać:

```bash
find /config/data/meet%2ejitsi/ -type f -exec basename {} .dat \;
prosodyctl --config /config/prosody.cfg.lua unregister WUŽIWARSKE_MJENO meet.jitsi
```
