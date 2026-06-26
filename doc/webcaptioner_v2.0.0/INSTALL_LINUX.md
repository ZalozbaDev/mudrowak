# Linux

## Ubuntu 24.04 instalować

- eksistowacy Windows njedyrbi so nuznje wumazać, Ubuntu móžeće "pódla" instalować
    - hasńće pak w tutym padźe prošu "Bitlocker" za dobu instalacije
- slědujće nawodom tule: https://ubuntu.com/download/desktop 
- wužiwajće USB-stick ze znajmjeńša 8GB za wutworjenje instalaciskeho systema
- startujće ličak znowa (Windows dyrbi so "čiste" skónčić, nic jenož "Herunterfahren") a wuzwolće start z USB
- prošu znajmjeńša 100GB skład za Linux zarjadować
- w tutym nawodźe so za wužiwarja a hesła přeco samsne słowo "lucija" wužiwa


## Ubuntu 24.04 nastajić

- přepruwować, zo je NVIDIA ćěrjak instalowane:

```bash
nvidia-smi
```

Tu dyrbja so wšelakore kajkosće wašeje grafikoweje karće pokazać.

- tak mjenowane "unattended upgrades" su poprawom dobra myslička, za naš zaměr pak mylace:

```bash
sudo apt remove --purge unattended-upgrades
```

- trěbne pakćiki instalować a zarjadować

```bash
sudo apt install -y git git-lfs docker.io docker-compose docker-buildx jedit
sudo systemctl enable docker
sudo adduser lucija docker
```

Opcionelnje wobstarajće sebi "Visual Studio Code" za Linux.

- wužiwarja wotzjewić a zaso přizjewić, kontrola:

```bash
docker ps
```

beži bjez zmylkow (njepokaza drje hišće žane "kontejnery", njesmě pak tež žadyn zmylk pokazać)

## Pokiwy za starše (popawm njpodpěrowane) grafikowe karty

Jenož za ekspertow! Wuspěch njeje garantowane!

- "Ubuntu 22.04" instalować 

abo 

- starše pakćiki na Ubuntu 24.04 instalować:

* CUDA 10.2 direktnje wot NVIDIA
    * žane ćěrjaki instalować
    * tón "compiler check" přeskoćić
* gcc 8.5 ze žórłami instalować:

```bash
./configure --disable-multilib --disable-bootstrap --enable-languages=c,c++ --prefix=/opt/gcc-8/
make -j 4
sudo make install
```

* wone pakćiki jako standard za našu potrjebu nastajić

```bash
cd /usr/local/cuda-10.2/bin/
sudo ln -s /opt/gcc-8/bin/gcc gcc
sudo ln -s /opt/gcc-8/bin/g++ g++

export PATH=/usr/local/cuda-10.2/bin/:$PATH
export LD_LIBRARY_PATH=/usr/local/cuda-10.2/lib64/:$LD_LIBRARY_PATH
```

