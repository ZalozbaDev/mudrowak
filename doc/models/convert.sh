#!/bin/bash

case $MODEL in
	
	Korla/hsb_stt_demo)
		if [ ! -e /cache/Korla_hsb_stt_demo ]; then
			git clone https://huggingface.co/spaces/Korla/hsb_stt_demo /cache/Korla_hsb_stt_demo
		fi
		if [ ! -e /cache/openai_whisper ]; then
			git clone https://github.com/openai/whisper                /cache/openai_whisper
		fi
		if [ ! -e /cache/openai_whisper_small ]; then
			GIT_LFS_SKIP_SMUDGE=1 git clone https://huggingface.co/openai/whisper-small      /cache/openai_whisper_small
		fi
		
		cp /cache/openai_whisper_small/vocab.json        /cache/Korla_hsb_stt_demo/hsb_whisper/
		cp /cache/openai_whisper_small/added_tokens.json /cache/Korla_hsb_stt_demo/hsb_whisper/
		
		mkdir -p /output/Korla/hsb_stt_demo
		cd whisper.cpp
		python3 ./models/convert-h5-to-ggml.py /cache/Korla_hsb_stt_demo/hsb_whisper/ /cache/openai_whisper/ /output/Korla/hsb_stt_demo/
		;;
	
	*)
		echo "Model $MODEL unknown!"
		;;
	
esac
	