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

|model name|ggml support|coreml support|ct2 support|forcealign|lm fusion|
|----------|------------|--------------|-----------|----------|---------|
|Korla/hsb_stt_demo                                            |x| | | | |
|Korla/whisper-large-hsb                                       |x| | | | |
|danielzoba/whisper_small_adapted_2024_06_03                   |x| | | | |
|DILHTWD/whisper-large-v3-hsb                                  |x| | | | |
|zalozbadev/whisper_small_v3_2024_10                           |x| | | | |
|Korla/whisper-large-v3-turbo-hsb                              |x|x| | | |
|Korla/whisper-large-v3-turbo-hsb-0                            |x|x| | | |
|DILHTWD/whisper-large-v3-turbo-hsb                            |x| | | | |
|DigitalLabs42/whisper-medium-hsb-v1                           |x| | | | |
|DigitalLabs42/whisper-large-hsb-v1                            |x| | | | |
|DigitalLabs42/whisper-large-hsb-v1-version2 (separate branch) |x| | | | |
|Korla/whisper-large-v3-turbo-dsb                              |x| | | | |
|Korla/Wav2Vec2BertForCTC-hsb-2024                             | | | |x|x|
|Korla/Wav2Vec2BertForCTC-hsb-2025                             | | | |x|x|
|zalozbadev/whisper-large-v3-turbo-hsb                         |x| | | | |
|zalozbadev/whisper-large-v3-turbo-hsb-aug                     |x| | | | |
|zalozbadev/whisper-large-v3-turbo-hsb-aug-longest-trained     |x| | | | |

replace MODEL variable with "USERNAME/MODELNAME" 

```code

docker build --progress=plain -t convert_to_ggml .
mkdir ~/cache
mkdir ~/whisper_models/
docker run -e MODEL="Korla/whisper-large-v3-turbo-hsb" --mount type=bind,source=$HOME/cache,target=/cache/ --mount type=bind,source=$HOME/whisper_models,target=/output/ -it convert_to_ggml /convert.sh 

```

(for MacOS do not forget the special instructions for the "coreml/" folder!)
