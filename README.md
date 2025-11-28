# mudrowak

Nawod za instalaciju swójskeho systema za spóznawanje a simultany přełožk.

## Přihotowanja

### Spóznawanski system

```code
git clone git@github.com:ZalozbaDev/docker_vosk.git
cd docker_vosk/
git checkout unify_recognizers # TBD fixed commit hash
./detect_whisper_options.sh
head vosk_server_whisper/Dockerfile
docker build ...
```
Pohladaj za to tež na tutón nawod za [webcaptioner](doc/webcaptioner/README.md#vosk).


### sotra.app za přełožk (z "libretranslate API")

```code
git clone git@github.com:ZalozbaDev/sotra_modele.git
cd sotra_modele/sotra-lsf-ds/Docker/
git checkout workaround_jitsi_limitation # TBD fixed commit hash
docker build -t sotra_libretranslate .
```

### "Jitsi Meet" jako "docker"

https://github.com/jitsi/docker-jitsi-meet/releases

wobstaraće sebi najnowši pakćik (.zip)

testowane su:

* 10184
* (10655)?

přihotujće sebi wšitko za instalaciju:

```code
rm -rf deploy/
mkdir -p deploy/
cd deploy/
unzip ../docker-jitsi-meet-stable-WERSIJA.zip
```

#### nastajenja

přidatne nastajenja za spóznawanje a přełožk:

```code
cd deploy/docker-jitsi-meet-stable-WERSIJA/
cp ../../config/custom.yml .
cp env.example .env
cat ../../config/env_append.txt >> .env
```

potom dataju ".env" wobdźěłać a sćěhowace nastajenja přiměrić:

* PUBLIC_URL
* JVB_ADVERTISE_IPS

přidatne dataje za spóznawanje wobstarać a składować, hlej za spóznawanski model
tutón [nawod](doc/webcaptioner/README.md#model-za-spóznawanje-twarić)

```code
mkdir -p logs/ whisper/ model/
cp -r ../../../whisper_models/SELECTED_MODEL whisper/
cp ../../doc/models/replacement_lists/*.txt whisper/
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

```bash
docker-compose -f docker-compose.yml -f transcriber.yml -f jibri.yml -f custom.yml up -d
```
