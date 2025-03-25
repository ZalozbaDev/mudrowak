# Overview of all (useful) whisper models

## Korla

https://huggingface.co/spaces/Korla/hsb_stt_demo

https://huggingface.co/Korla/whisper-large-hsb

https://huggingface.co/Korla/whisper-large-v3-turbo-hsb

## danielzoba

https://huggingface.co/danielzoba/whisper_small_adapted_2024_06_03

## DILHTWD

https://huggingface.co/DILHTWD/whisper-large-v3-hsb

https://huggingface.co/DILHTWD/whisper-large-v3-turbo-hsb

## zalozbadev

https://huggingface.co/zalozbadev/whisper_small_v3_2024_10

## DigitalLabs42

https://huggingface.co/DigitalLabs42/whisper-medium-hsb-v1

https://huggingface.co/DigitalLabs42/whisper-large-hsb-v1

# GGML conversion

replace MODEL variable with "USERNAME/MODELNAME" 

supported models:

* Korla/hsb_stt_demo
* Korla/whisper-large-hsb
* danielzoba/whisper_small_adapted_2024_06_03
* DILHTWD/whisper-large-v3-hsb
* zalozbadev/whisper_small_v3_2024_10
* Korla/whisper-large-v3-turbo-hsb
* DILHTWD/whisper-large-v3-turbo-hsb
* DigitalLabs42/whisper-medium-hsb-v1
* DigitalLabs42/whisper-large-hsb-v1

non-working models:

* Korla/Wav2Vec2BertForCTC-hsb

* none

```code

docker build --progress=plain -t convert_to_ggml .
mkdir ~/cache
mkdir ~/whisper_models/
docker run -e MODEL="Korla/hsb_stt_demo" --mount type=bind,source=$HOME/cache,target=/cache/ --mount type=bind,source=$HOME/whisper_models,target=/output/ -it convert_to_ggml /convert.sh 

```