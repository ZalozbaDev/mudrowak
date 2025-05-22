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

- takmjenowane "unattented updates" su poprawom dobra myslička, za naš zaměr pak mylace:

```bash
sudo apt remove --purge unattended-updates
```

