#!/bin/bash

case $MODEL in
	
	Korla/Wav2Vec2BertForCTC-hsb-2024)
		if [ ! -e /cache/Korla_Wav2Vec2BertForCTC-hsb-2024 ]; then
			git clone https://huggingface.co/Korla/Wav2Vec2BertForCTC-hsb /cache/Korla_Wav2Vec2BertForCTC-hsb-2024
		fi
		
		pushd /cache/Korla_Wav2Vec2BertForCTC-hsb-2024
		git checkout f24ed5bdee8bee672db9f9cc758a03e1482b2450
		popd
		;;
		
	Korla/Wav2Vec2BertForCTC-hsb-2025)
		if [ ! -e /cache/Korla_Wav2Vec2BertForCTC-hsb-2025 ]; then
			git clone https://huggingface.co/Korla/Wav2Vec2BertForCTC-hsb /cache/Korla_Wav2Vec2BertForCTC-hsb-2025
		fi
		
		pushd /cache/Korla_Wav2Vec2BertForCTC-hsb-2025
		git checkout 585ce204aaf6471087cf981677f0d6e35cce8f17
		popd
		;;
		
	Korla/Wav2Vec2BertForCTC-hsb-0)
		if [ ! -e /cache/Korla_Wav2Vec2BertForCTC-hsb-0 ]; then
			git clone https://huggingface.co/Korla/Wav2Vec2BertForCTC-hsb-0 /cache/Korla_Wav2Vec2BertForCTC-hsb-0
		fi
		
		pushd /cache/Korla_Wav2Vec2BertForCTC-hsb-0
		# git checkout 585ce204aaf6471087cf981677f0d6e35cce8f17
		popd
		
		mkdir -p /output/Korla_Wav2Vec2BertForCTC-hsb-0
		python3 ./convert-to-onnx.py /cache/Korla_Wav2Vec2BertForCTC-hsb-0//output/Korla_Wav2Vec2BertForCTC-hsb-0/wav2vec2.onnx 
		
		;;
		
	*)
		echo "Model $MODEL unknown!"
		;;
	
esac
