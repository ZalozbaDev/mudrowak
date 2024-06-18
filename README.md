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

## Wužiwanje & Aktualizować

```bash
docker-compose -f docker-compose.yml -f jibri.yml -f etherpad.yml -f jigasi.yml up -d --build
```
