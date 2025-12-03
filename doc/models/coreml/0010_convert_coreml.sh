#!/bin/bash

source pythonenv/bin/activate

for i in Korla/whisper_large_v3_turbo_hsb Korla/whisper_large_v3_turbo_hsb-0 ; do
    
    # remove leftovers from previous runs
    pushd whisper.cpp/
    git reset --hard
    git clean -fdx
    popd

    echo
    echo "================================================"
    echo "Checking model $i for conversion"
    echo "================================================"
    echo
    CACHEDIR=$(echo $i | tr '/' '_')

    if [ -e ~/cache/${CACHEDIR} ] && [ -e ~/whisper_models/${i} ]; then

        echo "Running coreml conversion."

        # this is hard-coded until we need to distinguish the model type/arch
        MODEL_TYPE_ARCH=large-v3-turbo

        cp ~/whisper_models/$i/ggml-model.bin whisper.cpp/models/ggml-${MODEL_TYPE_ARCH}.bin

        pushd whisper.cpp

        ./models/generate-coreml-model.sh -h5 ${MODEL_TYPE_ARCH} ~/cache/$CACHEDIR/

        rm -rf ~/whisper_models/$i/coreml/
        mkdir -p ~/whisper_models/$i/coreml/
        cp models/ggml-${MODEL_TYPE_ARCH}.bin                     ~/whisper_models/$i/coreml/
        cp -r models/ggml-${MODEL_TYPE_ARCH}-encoder.mlmodelc ~/whisper_models/$i/coreml/

        popd

    else

        echo "Skipping $i - did not find cache at ~/cache/${CACHEDIR} and output directory at ~/whisper_models/${i}! You might need to regenerate it."
        echo

    fi

done

