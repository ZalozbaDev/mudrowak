# mudrowak

Nawod za instalaciju swójskeho systema za spóznawanje a simultany přełožk.

## Přihotowanja

## Spóznawanski system

```code
git clone git@github.com:ZalozbaDev/docker_vosk.git
cd docker_vosk/
git checkout unify_recognizers # TBD fixed commit hash
./detect_whisper_options.sh
head vosk_server_whisper/Dockerfile
docker build ...
```

## sotra.app za přełožk (z "libretranslate API")

```code
git clone git@github.com:ZalozbaDev/sotra_modele.git
cd sotra_modele/sotra-lsf-ds/Docker/
git checkout workaround_jitsi_limitation # TBD fixed commit hash
docker build -t sotra_libretranslate .
```

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

## Wužiwanje & Aktualizować

```bash
docker-compose -f docker-compose.yml -f jibri.yml -f etherpad.yml -f jigasi.yml up -d --build
```
