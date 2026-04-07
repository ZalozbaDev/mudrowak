# Overview of all useful wav2vec2 models

## model conversion to ONNX

|model name|language(s)|ggml support|coreml support|ct2 support|forcealign|lm fusion|
|----------|-----------|------------|--------------|-----------|----------|---------|
|Korla/Wav2Vec2BertForCTC-hsb-2024                             |hsb| | | |x|x|
|Korla/Wav2Vec2BertForCTC-hsb-2025                             |hsb| | | |x|x|
|Korla/Wav2Vec2BertForCTC-hsb-0                                |hsb| | | |x|x|


replace MODEL variable with "USERNAME/MODELNAME" 

```code

docker build --progress=plain -t convert_to_onnx .
mkdir ~/cache
mkdir ~/onnx_models/
docker run -e MODEL="Korla/Wav2Vec2BertForCTC-hsb-0" --mount type=bind,source=$HOME/cache,target=/cache/ --mount type=bind,source=$HOME/onnx_models,target=/output/ -it convert_to_onnx /convert.sh 

```
