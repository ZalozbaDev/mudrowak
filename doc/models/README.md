# Overview of all (useful) whisper models

## Korla

https://huggingface.co/spaces/Korla/hsb_stt_demo

https://huggingface.co/Korla/whisper-large-hsb

https://huggingface.co/Korla/whisper-large-v3-turbo-hsb

https://huggingface.co/Korla/whisper-large-v3-turbo-dsb

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

# model conversion

|model name|language(s)|ggml support|coreml support|ct2 support|forcealign|lm fusion|
|----------|-----------|------------|--------------|-----------|----------|---------|
|Korla/hsb_stt_demo                                            |hsb|x| | | | |
|Korla/whisper-large-hsb                                       |hsb|x| | | | |
|danielzoba/whisper_small_adapted_2024_06_03                   |hsb|x| | | | |
|DILHTWD/whisper-large-v3-hsb                                  |hsb|x| | | | |
|zalozbadev/whisper_small_v3_2024_10                           |hsb|x| | | | |
|Korla/whisper-large-v3-turbo-hsb                              |hsb|x|x| | | |
|Korla/whisper-large-v3-turbo-hsb-0                            |hsb|x|x| | | |
|DILHTWD/whisper-large-v3-turbo-hsb                            |hsb|x| | | | |
|DigitalLabs42/whisper-medium-hsb-v1                           |hsb|x| | | | |
|DigitalLabs42/whisper-large-hsb-v1                            |hsb|x| | | | |
|DigitalLabs42/whisper-large-hsb-v1-version2 (separate branch) |hsb|x| | | | |
|Korla/whisper-large-v3-turbo-dsb                              |dsb|x| | | | |
|Korla/Wav2Vec2BertForCTC-hsb-2024                             |hsb| | | |x|x|
|Korla/Wav2Vec2BertForCTC-hsb-2025                             |hsb| | | |x|x|
|zalozbadev/whisper-large-v3-turbo-hsb                         |hsb|x| | | | |
|zalozbadev/whisper-large-v3-turbo-hsb-aug                     |hsb|x| | | | |
|zalozbadev/whisper-large-v3-turbo-hsb-aug-longest-trained     |hsb|x| | | | |
|primeline/whisper-large-v3-german                             |de |x| | | | |

replace MODEL variable with "USERNAME/MODELNAME" 

```code

docker build --progress=plain -t convert_to_ggml .
mkdir ~/cache
mkdir ~/whisper_models/
docker run -e MODEL="Korla/whisper-large-v3-turbo-hsb" --mount type=bind,source=$HOME/cache,target=/cache/ --mount type=bind,source=$HOME/whisper_models,target=/output/ -it convert_to_ggml /convert.sh 

```

(for MacOS do not forget the special instructions for the "coreml/" folder!)
