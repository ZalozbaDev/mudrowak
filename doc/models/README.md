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

|model name|ggml support|coreml support|ct2 support|
|----------|------------|--------------|-----------|
|Korla/hsb_stt_demo                                            |x| | |
|Korla/whisper-large-hsb                                       |x| | |
|danielzoba/whisper_small_adapted_2024_06_03                   |x| | |
|DILHTWD/whisper-large-v3-hsb                                  |x| | |
|zalozbadev/whisper_small_v3_2024_10                           |x| | |
|Korla/whisper-large-v3-turbo-hsb                              |x|x| |
|DILHTWD/whisper-large-v3-turbo-hsb                            |x| | |
|DigitalLabs42/whisper-medium-hsb-v1                           |x| | |
|DigitalLabs42/whisper-large-hsb-v1                            |x| | |
|DigitalLabs42/whisper-large-hsb-v1-version2 (separate branch) |x| | |
|Korla/whisper-large-v3-turbo-dsb                              |x| | |
|Korla/Wav2Vec2BertForCTC-hsb-2024                             | | | |
|Korla/Wav2Vec2BertForCTC-hsb-2025                             | | | |

replace MODEL variable with "USERNAME/MODELNAME" 

```code

docker build --progress=plain -t convert_to_ggml .
mkdir ~/cache
mkdir ~/whisper_models/
docker run -e MODEL="Korla/hsb_stt_demo" --mount type=bind,source=$HOME/cache,target=/cache/ --mount type=bind,source=$HOME/whisper_models,target=/output/ -it convert_to_ggml /convert.sh 

```

# CoreML support

There are additional steps required to use CoreML on Mac. 

* Install a required python version (3.11.x at the moment)
    * run "Update Shell Profile.command" in "/Applications/Python\ 3.11/" to make this version the default on cmdline
* Install the required python modules as per whisper.cpp documentation
    * pip3 install ane_transformers
    * pip3 install openai-whisper
    * pip3 install coremltools
* Create the GGML (see above) of the selected model. Copy it to "whisper.cpp/models/" and name it "ggml-WHISPERBASEMODEL.bin"
    * Example: "whisper.cpp/models/ggml-large-v3-turbo.bin"
* Run the script for generation of additional CoreML files (from the same repo you created the GGML from)
    * Example: "./models/generate-coreml-model.sh -h5 large-v3-turbo /Users/danielzoba/whisper-large-v3-turbo-hsb/"
    * This creates additional files and folders in the "models" directory.
* For model usage, refer to the GGML file (loading of additional files is done automatically)
    * Example: "./build/bin/whisper-cli -m models/ggml-large-v3-turbo.bin my/file.wav"

