# adjustments for running on Windows using WSL2

make sure your system meets the requirements mentioned here

https://docs.nvidia.com/cuda/wsl-user-guide/index.html 

# differences to the Linux "README.md"

## Ubuntu nastajić

Please follow these instructions to make NVIDIA cards accessible with WSL2 docker:

https://docs.nvidia.com/ai-enterprise/deployment/vmware/latest/docker.html

## Jednotliwe containery twarić

### vosk

```bash
cd docker_vosk
git checkout 2dbfde5ceabbd698cc4b5d1495866468f7c7244e
```

Detecting the CUDA capabilities using a compiled program does not seem to work, this step can be skipped.
Use the link https://arnon.dk/matching-sm-architectures-arch-and-gencode-for-various-nvidia-cards/ from the Linux README to find the proper CUDA architecture.

To specify the driver and version, go to https://packages.ubuntu.com and find a driver version that matches the output of "nvidia-smi" in WSL best. It is unlikely to match 100%

Example cmdline to build the vosk container:

docker build -f vosk_server_whisper/Dockerfile --build-arg NVIDIA_DRIVER_PACKAGE=nvidia-driver-570 \
--build-arg NVIDIA_DRIVER_VERSION=570.195.03-0ubuntu0.24.04.1 \
--build-arg NVIDIA_CUDA_ARCHITECTURE=86 --progress=plain -t vosk_server_whisper .

## system startować

cd mudrowak/doc/webcaptioner
cp env.example .env
cp -r ../../../modele/sotra-lsf-ds/Docker/models1 .
cp ../../../modele/ctranslate-ol/version.txt .
cp -r ../../../whisper_models/Korla whisper/
sudo apt install -y python3-distutils-extra docker-compose-v2
sudo apt remove docker-compose
docker compose up -d


