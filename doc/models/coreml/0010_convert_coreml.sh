#!/bin/bash

source pythonenv/bin/activate

# remove leftovers from previous runs

cd whisper.cpp/
git reset --hard
git clean -fdx
cd ..

## hard-coded to convert one model only

cp ~/whisper_models/Korla/whisper_large_v3_turbo_hsb/ggml-model.bin whisper.cpp/models/ggml-large-v3-turbo.bin

cd whisper.cpp

./models/generate-coreml-model.sh -h5 large-v3-turbo ~/cache/Korla_whisper_large_v3_turbo_hsb/

rm -rf ~/whisper_models/Korla/whisper_large_v3_turbo_hsb/coreml/
mkdir -p ~/whisper_models/Korla/whisper_large_v3_turbo_hsb/coreml/
cp models/ggml-large-v3-turbo.bin                 ~/whisper_models/Korla/whisper_large_v3_turbo_hsb/coreml/
cp -r models/ggml-large-v3-turbo-encoder.mlmodelc ~/whisper_models/Korla/whisper_large_v3_turbo_hsb/coreml/

cd ..

