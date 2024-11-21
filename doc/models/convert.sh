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
	
	Korla/whisper-large-hsb)
		if [ ! -e /cache/Korla_whisper_large_hsb ]; then
			git clone https://huggingface.co/Korla/whisper-large-hsb /cache/Korla_whisper_large_hsb
		fi
		if [ ! -e /cache/openai_whisper ]; then
			git clone https://github.com/openai/whisper                /cache/openai_whisper
		fi
		
		mkdir -p /output/Korla/whisper_large_hsb
		cd whisper.cpp
		python3 ./models/convert-h5-to-ggml.py /cache/Korla_whisper_large_hsb/ /cache/openai_whisper/ /output/Korla/whisper_large_hsb/
		;;
	
	danielzoba/whisper_small_adapted_2024_06_03)
		if [ ! -e /cache/danielzoba_whisper_small_adapted_2024_06_03 ]; then
			git clone https://huggingface.co/danielzoba/whisper_small_adapted_2024_06_03 /cache/danielzoba_whisper_small_adapted_2024_06_03
		fi

		# TODO is this really the best snapshot?
		
		cp /cache/danielzoba_whisper_small_adapted_2024_06_03/0015_even_more_2024_recordings_0001/vocab.json        /cache/danielzoba_whisper_small_adapted_2024_06_03/0015_even_more_2024_recordings_0001/checkpoint-3800/
		cp /cache/danielzoba_whisper_small_adapted_2024_06_03/0015_even_more_2024_recordings_0001/added_tokens.json /cache/danielzoba_whisper_small_adapted_2024_06_03/0015_even_more_2024_recordings_0001/checkpoint-3800/
		
		mkdir -p /output/danielzoba/whisper_small_adapted_2024_06_03
		cd whisper.cpp
		python3 ./models/convert-h5-to-ggml.py /cache/danielzoba_whisper_small_adapted_2024_06_03/0015_even_more_2024_recordings_0001/checkpoint-3800/ /cache/openai_whisper/ /output/danielzoba/whisper_small_adapted_2024_06_03
		;;
		
	*)
		echo "Model $MODEL unknown!"
		;;
	
esac
	