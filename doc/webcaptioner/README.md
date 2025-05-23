# Simultan přełožowar na swójskim ličaku

- přistup na syć po instalacije njeje trjeba!

## Ličak wupytać

- grafikowa karta wot NVIDIA je trěbna, njedyrbi pak najnowša być
- hlej přehlad: https://arnon.dk/matching-sm-architectures-arch-and-gencode-for-various-nvidia-cards/
- karty pod nadpismom "Pascal" abo nowše su kmani
- spomjatkujće sebi tu ličbu zady "SM" (na přikład "61" za kartu "GTX 1060")
- karta dyrbi 4GB GPU RAM měć (hdyž ma samo 8GB GPU RAM, mamy wjetši wuběrk spóznawanskich modelow)
- někak 100..150GB městna swobodne na tačele

## Ubuntu 24.04 instalować

- eksistowacy Windows njedyrbi so nuznje wumazać, Ubuntu móžeće "pódla" instalować
    - hasnće pak w tutym padźe prošu "Bitlocker" za dobu instalacije
- slědujće nawodom tule: https://ubuntu.com/download/desktop 
- wužiwajće USB-stick ze znajmjeńša 8GB za wutworjenje instalaciskeho systema
- startujće ličak znowa (Windows dyrbi so "čiste" skónčić, nic jenož "Herunterfahren") a wuzwolće start z USB

## Ubuntu nastajić

- přepruwować, zo je NVIDIA čěrjak instalowane:

- tak mjenowane "unattended updates" su poprawom dobra myslička, za naš zaměr pak mylace:

```bash
sudo apt remove --purge unattended-updates
```

- trěbne pakćiki instalować a zarjadować

```bash
sudo apt install -y git git-lfs docker.io docker-compose docker-buildx jedit
systemctl enable docker
adduser lucija docker
```
- wužiwarja wotzjewić a zaso přizjewić, kontrola:

```bash
docker ps
```

beži bjez zmylkow

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
atd
```

- model pozdźišo do praweho rjadowaka kopěrować

## Jednotliwe containery twarić

### webcaptioner

```bash
cd webcaptioner-ng
git checkout ng_1.3.2
cat README.md
docker build -f docker/Dockerfile -t webcaptioner-ng .
```

```bash
cd webcaptioner-ng-server
git checkout ng_1.3.2
cat README.md
docker build -f docker/Dockerfile -t webcaptioner-ng-back .
```

### sotra

```bash
cd modele
git checkout 89242e4fee9a59290b5e79531cc10319b9933ee7
cd sotra-lsf-ds/
cat README.md
docker build -t sotra-lsf .

cd ..
cd ctranslate-ol/
cat README.md
docker build -t ctranslator .
```

- přidatne dataja pozdźišo do praweho rjadowaka kopěrować

### vosk

```bash
cd docker_vosk
git checkout 2dbfde5ceabbd698cc4b5d1495866468f7c7244e
sudo apt install -f nvidia-cuda-toolkit
./detect_whisper_options.sh
docker build ...
```

## system startować

```bash
cd mudrowak/doc/webcaptioner
cp env.example .env
cp -r ../../../modele/sotra-lsf-ds/Docker/models1 .
cp ../../../modele/ctranslate-ol/version.txt .
cp -r ../../../whisper_models/Korla whisper/
docker-compose up -d
```

- system přeco awtomatisce zabeži, hdyž so ličak zaswěći

- kontrola

```bash
docker-compose logs -f
```

- wuspytać z Firefox

http://localhost

hdyž browser to na "https" změni, ručne zaso na "http" stajić

