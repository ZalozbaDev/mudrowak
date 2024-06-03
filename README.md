# mudrowak

Nawod za instalaciju swójskeho systema za spóznawanje a simultany přełožk.

## Přihotowanja

### File system

as root:

```bash
mkdir -p /containers/jitsi-meet/inst_9220/.jitsi-meet-cfg/{web,transcripts,prosody/config,prosody/prosody-plugins-custom,jicofo,jvb,jigasi,jibri}
```

### Environment configuration

Prepare configuration file:

```bash
cp env.example .env
./gen-passwords.sh 
```

Search & replace all "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX" values.
If you don't have an API key for the custom translation, leave it as-is.

Then adjust the config to your needs.

### Additional data

#### Whisper model

Fetch all required repos:

```bash
git lfs install
git submodule init
git submodule update
```

Convert and quantize model using docker:
```bash
docker build -t quantized-whisper .
docker run --rm --entrypoint /bin/sh quantized-whisper -c "cat /app/ggml-model.q8_0.bin" > ./ggml-model.q8_0.bin
```

Copy the resulting quantized model to the place specified by the config key "MODEL_PATH_FULL" in ".env".

### Whisper container

TBD currently this container only works with Ubuntu 22.04 LTS and CUDA enabled.
Patches welcome to support other platforms & configs.

```bash
git clone git@github.com:ZalozbaDev/docker_vosk
pushd docker_vosk
docker build -f vosk_server_whisper/Dockerfile --progress=plain -t vosk_server_whisper .
popd
```

## Wužiwanje

```bash
docker-compose -f docker-compose.yml -f jibri.yml -f etherpad.yml -f jigasi.yml up -d
```

### Update whisper container

After rebuilding the whisper container, run this sequence:

```bash
docker-compose -f docker-compose.yml -f jibri.yml -f etherpad.yml -f jigasi.yml stop vosk-hsb-whisper
docker-compose -f docker-compose.yml -f jibri.yml -f etherpad.yml -f jigasi.yml create vosk-hsb-whisper
docker-compose -f docker-compose.yml -f jibri.yml -f etherpad.yml -f jigasi.yml start vosk-hsb-whisper
docker-compose -f docker-compose.yml -f jibri.yml -f etherpad.yml -f jigasi.yml logs -f vosk-hsb-whisper
```
