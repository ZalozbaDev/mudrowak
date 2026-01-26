#!/bin/bash

export WHISPER_V1_7_1=whisper.cpp_v1_7_1
export WHISPER_V1_7_2=whisper.cpp_v1_7_2
export WHISPER_V1_7_4=whisper.cpp_v1_7_4

# could be that some conversions depend on OpenAI releases?
export OPENAI_WHISPER_TAG_LATEST=v20240930
 
case $MODEL in
	
	Korla/hsb_stt_demo)
		if [ ! -e /cache/Korla_hsb_stt_demo ]; then
			git clone https://huggingface.co/spaces/Korla/hsb_stt_demo /cache/Korla_hsb_stt_demo
		fi
		if [ ! -e /cache/openai_whisper ]; then
			git clone https://github.com/openai/whisper                /cache/openai_whisper
		fi
		pushd /cache/openai_whisper && git checkout $OPENAI_WHISPER_TAG_LATEST && popd
		if [ ! -e /cache/openai_whisper_small ]; then
			GIT_LFS_SKIP_SMUDGE=1 git clone https://huggingface.co/openai/whisper-small      /cache/openai_whisper_small
		fi
		
		cp /cache/openai_whisper_small/vocab.json        /cache/Korla_hsb_stt_demo/hsb_whisper/
		cp /cache/openai_whisper_small/added_tokens.json /cache/Korla_hsb_stt_demo/hsb_whisper/
		
		mkdir -p /output/Korla/hsb_stt_demo
		cd $WHISPER_V1_7_1
		python3 ./models/convert-h5-to-ggml.py /cache/Korla_hsb_stt_demo/hsb_whisper/ /cache/openai_whisper/ /output/Korla/hsb_stt_demo/
		;;
	
	Korla/whisper-large-hsb)
		if [ ! -e /cache/Korla_whisper_large_hsb ]; then
			git clone https://huggingface.co/Korla/whisper-large-hsb /cache/Korla_whisper_large_hsb
		fi
		if [ ! -e /cache/openai_whisper ]; then
			git clone https://github.com/openai/whisper                /cache/openai_whisper
		fi
		pushd /cache/openai_whisper && git checkout $OPENAI_WHISPER_TAG_LATEST && popd
		
		mkdir -p /output/Korla/whisper_large_hsb
		cd $WHISPER_V1_7_1
		python3 ./models/convert-h5-to-ggml.py /cache/Korla_whisper_large_hsb/ /cache/openai_whisper/ /output/Korla/whisper_large_hsb/
		;;
	
	Korla/whisper-large-v3-turbo-hsb)
		if [ ! -e /cache/Korla_whisper_large_v3_turbo_hsb ]; then
			git clone https://huggingface.co/Korla/whisper-large-v3-turbo-hsb /cache/Korla_whisper_large_v3_turbo_hsb
		fi
		if [ ! -e /cache/openai_whisper ]; then
			git clone https://github.com/openai/whisper                /cache/openai_whisper
		fi
		pushd /cache/openai_whisper && git checkout $OPENAI_WHISPER_TAG_LATEST && popd
		if [ ! -e /cache/openai_whisper_large_v3_turbo ]; then
			GIT_LFS_SKIP_SMUDGE=1 git clone https://huggingface.co/openai/whisper-large-v3-turbo      /cache/openai_whisper_large_v3_turbo
		fi

		cp /cache/openai_whisper_large_v3_turbo/vocab.json        /cache/Korla_whisper_large_v3_turbo_hsb/
		cp /cache/openai_whisper_large_v3_turbo/added_tokens.json /cache/Korla_whisper_large_v3_turbo_hsb/
		
		# not necessary for this python script, but required when creating ct2 model
		cp /cache/openai_whisper_large_v3_turbo/merges.txt               /cache/Korla_whisper_large_v3_turbo_hsb/
		cp /cache/openai_whisper_large_v3_turbo/tokenizer.json           /cache/Korla_whisper_large_v3_turbo_hsb/
		cp /cache/openai_whisper_large_v3_turbo/preprocessor_config.json /cache/Korla_whisper_large_v3_turbo_hsb/
		
        ## GGML ##

		mkdir -p /output/Korla/whisper_large_v3_turbo_hsb
		cd $WHISPER_V1_7_4
		python3 ./models/convert-h5-to-ggml.py /cache/Korla_whisper_large_v3_turbo_hsb/ /cache/openai_whisper/ /output/Korla/whisper_large_v3_turbo_hsb/
		;;
	
	Korla/whisper-large-v3-turbo-hsb-0)
		if [ ! -e /cache/Korla_whisper_large_v3_turbo_hsb-0 ]; then
			git clone https://huggingface.co/Korla/whisper-large-v3-turbo-hsb-0 /cache/Korla_whisper_large_v3_turbo_hsb-0
		fi
		if [ ! -e /cache/openai_whisper ]; then
			git clone https://github.com/openai/whisper                /cache/openai_whisper
		fi
		pushd /cache/openai_whisper && git checkout $OPENAI_WHISPER_TAG_LATEST && popd
		if [ ! -e /cache/openai_whisper_large_v3_turbo ]; then
			GIT_LFS_SKIP_SMUDGE=1 git clone https://huggingface.co/openai/whisper-large-v3-turbo      /cache/openai_whisper_large_v3_turbo
		fi

		# files are now present in repo
		# cp /cache/openai_whisper_large_v3_turbo/vocab.json        /cache/Korla_whisper_large_v3_turbo_hsb-0/
		# cp /cache/openai_whisper_large_v3_turbo/added_tokens.json /cache/Korla_whisper_large_v3_turbo_hsb-0/
		
		if [ ! -e /cache/Korla_whisper_large_v3_turbo_hsb-0/generation_config.json ]; then
			cp /cache/openai_whisper_large_v3_turbo/generation_config.json        /cache/Korla_whisper_large_v3_turbo_hsb-0/
		fi
		
        ## GGML ##

		mkdir -p /output/Korla/whisper_large_v3_turbo_hsb-0
		cd $WHISPER_V1_7_4
		python3 ./models/convert-h5-to-ggml.py /cache/Korla_whisper_large_v3_turbo_hsb-0/ /cache/openai_whisper/ /output/Korla/whisper_large_v3_turbo_hsb-0/
		;;
	
	Korla/whisper-large-v3-turbo-dsb)
		if [ ! -e /cache/Korla_whisper_large_v3_turbo_dsb ]; then
			git clone https://huggingface.co/Korla/whisper-large-v3-turbo-dsb /cache/Korla_whisper_large_v3_turbo_dsb
		fi
		if [ ! -e /cache/openai_whisper ]; then
			git clone https://github.com/openai/whisper                /cache/openai_whisper
		fi
		pushd /cache/openai_whisper && git checkout $OPENAI_WHISPER_TAG_LATEST && popd
		if [ ! -e /cache/openai_whisper_large_v3_turbo ]; then
			GIT_LFS_SKIP_SMUDGE=1 git clone https://huggingface.co/openai/whisper-large-v3-turbo      /cache/openai_whisper_large_v3_turbo
		fi

		mkdir -p /output/Korla/whisper_large_v3_turbo_dsb
		cd $WHISPER_V1_7_2
		python3 ./models/convert-h5-to-ggml.py /cache/Korla_whisper_large_v3_turbo_dsb/ /cache/openai_whisper/ /output/Korla/whisper_large_v3_turbo_dsb/
		;;
	
	danielzoba/whisper_small_adapted_2024_06_03)
		if [ ! -e /cache/danielzoba_whisper_small_adapted_2024_06_03 ]; then
			git clone https://huggingface.co/danielzoba/whisper_small_adapted_2024_06_03 /cache/danielzoba_whisper_small_adapted_2024_06_03
		fi
		if [ ! -e /cache/openai_whisper ]; then
			git clone https://github.com/openai/whisper                /cache/openai_whisper
		fi
		pushd /cache/openai_whisper && git checkout $OPENAI_WHISPER_TAG_LATEST && popd

		# TODO is this really the best snapshot?
		
		cp /cache/danielzoba_whisper_small_adapted_2024_06_03/0015_even_more_2024_recordings_0001/vocab.json        /cache/danielzoba_whisper_small_adapted_2024_06_03/0015_even_more_2024_recordings_0001/checkpoint-3800/
		cp /cache/danielzoba_whisper_small_adapted_2024_06_03/0015_even_more_2024_recordings_0001/added_tokens.json /cache/danielzoba_whisper_small_adapted_2024_06_03/0015_even_more_2024_recordings_0001/checkpoint-3800/
		
		mkdir -p /output/danielzoba/whisper_small_adapted_2024_06_03
		cd $WHISPER_V1_7_1
		python3 ./models/convert-h5-to-ggml.py /cache/danielzoba_whisper_small_adapted_2024_06_03/0015_even_more_2024_recordings_0001/checkpoint-3800/ /cache/openai_whisper/ /output/danielzoba/whisper_small_adapted_2024_06_03
		;;

	DILHTWD/whisper-large-v3-hsb)
		if [ ! -e /cache/DILHTWD_whisper_large_v3_hsb ]; then
			git clone https://huggingface.co/DILHTWD/whisper-large-v3-hsb /cache/DILHTWD_whisper_large_v3_hsb
		fi
		if [ ! -e /cache/openai_whisper ]; then
			git clone https://github.com/openai/whisper                /cache/openai_whisper
		fi
		pushd /cache/openai_whisper && git checkout $OPENAI_WHISPER_TAG_LATEST && popd
		
		mkdir -p /output/DILHTWD/whisper_large_v3_hsb
		cd $WHISPER_V1_7_1
		python3 ./models/convert-h5-to-ggml.py /cache/DILHTWD_whisper_large_v3_hsb/ /cache/openai_whisper/ /output/DILHTWD/whisper_large_v3_hsb/
		;;
		
	DILHTWD/whisper-large-v3-turbo-hsb)
		if [ ! -e /cache/DILHTWD_whisper_large_v3_turbo_hsb ]; then
			git clone https://huggingface.co/DILHTWD/whisper-large-v3-turbo-hsb /cache/DILHTWD_whisper_large_v3_turbo_hsb
		fi
		if [ ! -e /cache/openai_whisper ]; then
			git clone https://github.com/openai/whisper                /cache/openai_whisper
		fi
		pushd /cache/openai_whisper && git checkout $OPENAI_WHISPER_TAG_LATEST && popd
		if [ ! -e /cache/openai_whisper_large_v3_turbo ]; then
			GIT_LFS_SKIP_SMUDGE=1 git clone https://huggingface.co/openai/whisper-large-v3-turbo      /cache/openai_whisper_large_v3_turbo
		fi

		cp /cache/openai_whisper_large_v3_turbo/vocab.json        /cache/DILHTWD_whisper_large_v3_turbo_hsb/
		cp /cache/openai_whisper_large_v3_turbo/added_tokens.json /cache/DILHTWD_whisper_large_v3_turbo_hsb/
		
		mkdir -p /output/DILHTWD/whisper_large_v3_turbo_hsb
		cd $WHISPER_V1_7_2
		python3 ./models/convert-h5-to-ggml.py /cache/DILHTWD_whisper_large_v3_turbo_hsb/ /cache/openai_whisper/ /output/DILHTWD/whisper_large_v3_turbo_hsb/
		;;
	
	zalozbadev/whisper_small_v3_2024_10)
		if [ ! -e /cache/zalozbadev_whisper_small_v3_2024_10 ]; then
			git clone https://huggingface.co/zalozbadev/whisper_small_v3_2024_10 /cache/zalozbadev_whisper_small_v3_2024_10
		fi
		if [ ! -e /cache/openai_whisper ]; then
			git clone https://github.com/openai/whisper                /cache/openai_whisper
		fi
		pushd /cache/openai_whisper && git checkout $OPENAI_WHISPER_TAG_LATEST && popd
		
		mkdir -p /output/zalozbadev/whisper_small_v3_2024_10
		cd $WHISPER_V1_7_1
		python3 ./models/convert-h5-to-ggml.py /cache/zalozbadev_whisper_small_v3_2024_10/ /cache/openai_whisper/ /output/zalozbadev/whisper_small_v3_2024_10/
		;;
		
	DigitalLabs42/whisper-medium-hsb-v1)
		if [ ! -e /cache/DigitalLabs42_whisper_medium_hsb_v1 ]; then
			git clone https://huggingface.co/DigitalLabs42/whisper-medium-hsb-v1 /cache/DigitalLabs42_whisper_medium_hsb_v1
		fi
		if [ ! -e /cache/openai_whisper ]; then
			git clone https://github.com/openai/whisper                /cache/openai_whisper
		fi
		pushd /cache/openai_whisper && git checkout $OPENAI_WHISPER_TAG_LATEST && popd
		if [ ! -e /cache/openai_whisper_medium ]; then
			GIT_LFS_SKIP_SMUDGE=1 git clone https://huggingface.co/openai/whisper-medium      /cache/openai_whisper_medium
		fi

		cp /cache/openai_whisper_medium/vocab.json        /cache/DigitalLabs42_whisper_medium_hsb_v1/
		cp /cache/openai_whisper_medium/added_tokens.json /cache/DigitalLabs42_whisper_medium_hsb_v1/
		
		mkdir -p /output/DigitalLabs42/whisper_medium_hsb_v1
		rm -rf $WHISPER_V1_7_4.safetensors
		cp -r $WHISPER_V1_7_4 $WHISPER_V1_7_4.safetensors
		cp convert-safetensors-to-ggml.py $WHISPER_V1_7_4.safetensors/models/
		cd $WHISPER_V1_7_4.safetensors
		python3 ./models/convert-safetensors-to-ggml.py /cache/DigitalLabs42_whisper_medium_hsb_v1/ /cache/openai_whisper/ /output/DigitalLabs42/whisper_medium_hsb_v1/
		;;
		
	DigitalLabs42/whisper-large-hsb-v1)
		if [ ! -e /cache/DigitalLabs42_whisper-large-hsb-v1 ]; then
			git clone https://huggingface.co/DigitalLabs42/whisper-large-hsb-v1 /cache/DigitalLabs42_whisper_large_hsb_v1
		fi
		if [ ! -e /cache/openai_whisper ]; then
			git clone https://github.com/openai/whisper                /cache/openai_whisper
		fi
		pushd /cache/openai_whisper && git checkout $OPENAI_WHISPER_TAG_LATEST && popd
		if [ ! -e /cache/openai_whisper_large_v3 ]; then
			GIT_LFS_SKIP_SMUDGE=1 git clone https://huggingface.co/openai/whisper-large-v3      /cache/openai_whisper_large_v3
		fi

		cp /cache/openai_whisper_large_v3/vocab.json        /cache/DigitalLabs42_whisper_large_hsb_v1/
		cp /cache/openai_whisper_large_v3/added_tokens.json /cache/DigitalLabs42_whisper_large_hsb_v1/
		
		mkdir -p /output/DigitalLabs42/whisper_large_hsb_v1
		rm -rf $WHISPER_V1_7_4.safetensors
		cp -r $WHISPER_V1_7_4 $WHISPER_V1_7_4.safetensors
		cp convert-safetensors-to-ggml.py $WHISPER_V1_7_4.safetensors/models/
		cd $WHISPER_V1_7_4.safetensors
		python3 ./models/convert-safetensors-to-ggml.py /cache/DigitalLabs42_whisper_large_hsb_v1/ /cache/openai_whisper/ /output/DigitalLabs42/whisper_large_hsb_v1/
		;;

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
		
	DigitalLabs42/whisper-large-hsb-v1-version2)
		if [ ! -e /cache/DigitalLabs42_whisper-large-hsb-v1-version2 ]; then
			git clone https://huggingface.co/DigitalLabs42/whisper-large-hsb-v1 /cache/DigitalLabs42_whisper_large_hsb_v1_version2
		fi
		pushd /cache/DigitalLabs42_whisper_large_hsb_v1_version2
		git checkout version2
		if [ ! -e model.safetensors ]; then
			ln -s model-01.safetensors model.safetensors
		fi
		popd
		if [ ! -e /cache/openai_whisper ]; then
			git clone https://github.com/openai/whisper                /cache/openai_whisper
		fi
		pushd /cache/openai_whisper && git checkout $OPENAI_WHISPER_TAG_LATEST && popd
		if [ ! -e /cache/openai_whisper_large_v3 ]; then
			GIT_LFS_SKIP_SMUDGE=1 git clone https://huggingface.co/openai/whisper-large-v3      /cache/openai_whisper_large_v3
		fi

		cp /cache/openai_whisper_large_v3/vocab.json        /cache/DigitalLabs42_whisper_large_hsb_v1_version2/
		cp /cache/openai_whisper_large_v3/added_tokens.json /cache/DigitalLabs42_whisper_large_hsb_v1_version2/
		
		mkdir -p /output/DigitalLabs42/whisper_large_hsb_v1_version2
		rm -rf $WHISPER_V1_7_4.safetensors
		cp -r $WHISPER_V1_7_4 $WHISPER_V1_7_4.safetensors
		cp convert-safetensors-to-ggml.py $WHISPER_V1_7_4.safetensors/models/
		cd $WHISPER_V1_7_4.safetensors
		python3 ./models/convert-safetensors-to-ggml.py /cache/DigitalLabs42_whisper_large_hsb_v1_version2/ /cache/openai_whisper/ /output/DigitalLabs42/whisper_large_hsb_v1_version2/
		;;

	zalozbadev/whisper-large-v3-turbo-hsb)
		if [ ! -e /cache/zalozbadev_whisper_large_v3_turbo_hsb ]; then
			git clone https://huggingface.co/zalozbadev/whisper-large-v3-turbo-hsb /cache/zalozbadev_whisper_large_v3_turbo_hsb
		fi
		if [ ! -e /cache/openai_whisper ]; then
			git clone https://github.com/openai/whisper                /cache/openai_whisper
		fi
		pushd /cache/openai_whisper && git checkout $OPENAI_WHISPER_TAG_LATEST && popd
		if [ ! -e /cache/openai_whisper_large_v3_turbo ]; then
			GIT_LFS_SKIP_SMUDGE=1 git clone https://huggingface.co/openai/whisper-large-v3-turbo      /cache/openai_whisper_large_v3_turbo
		fi

		#cp /cache/openai_whisper_large_v3_turbo/vocab.json        /cache/Korla_whisper_large_v3_turbo_hsb/
		#cp /cache/openai_whisper_large_v3_turbo/added_tokens.json /cache/Korla_whisper_large_v3_turbo_hsb/
		
		# not necessary for this python script, but required when creating ct2 model
		#cp /cache/openai_whisper_large_v3_turbo/merges.txt               /cache/Korla_whisper_large_v3_turbo_hsb/
		#cp /cache/openai_whisper_large_v3_turbo/tokenizer.json           /cache/Korla_whisper_large_v3_turbo_hsb/
		#cp /cache/openai_whisper_large_v3_turbo/preprocessor_config.json /cache/Korla_whisper_large_v3_turbo_hsb/
		
        ## GGML ##

		mkdir -p /output/zalozbadev/whisper_large_v3_turbo_hsb
		cd $WHISPER_V1_7_4
		python3 ./models/convert-h5-to-ggml.py /cache/zalozbadev_whisper_large_v3_turbo_hsb/ /cache/openai_whisper/ /output/zalozbadev/whisper_large_v3_turbo_hsb/
		;;
	
	zalozbadev/whisper-large-v3-turbo-hsb-aug)
		if [ ! -e /cache/zalozbadev_whisper_large_v3_turbo_hsb_aug ]; then
			git clone https://huggingface.co/zalozbadev/whisper-large-v3-turbo-hsb-aug /cache/zalozbadev_whisper_large_v3_turbo_hsb_aug
		fi
		if [ ! -e /cache/openai_whisper ]; then
			git clone https://github.com/openai/whisper                /cache/openai_whisper
		fi
		pushd /cache/openai_whisper && git checkout $OPENAI_WHISPER_TAG_LATEST && popd
		if [ ! -e /cache/openai_whisper_large_v3_turbo ]; then
			GIT_LFS_SKIP_SMUDGE=1 git clone https://huggingface.co/openai/whisper-large-v3-turbo      /cache/openai_whisper_large_v3_turbo
		fi

		#cp /cache/openai_whisper_large_v3_turbo/vocab.json        /cache/Korla_whisper_large_v3_turbo_hsb/
		#cp /cache/openai_whisper_large_v3_turbo/added_tokens.json /cache/Korla_whisper_large_v3_turbo_hsb/
		
		# not necessary for this python script, but required when creating ct2 model
		#cp /cache/openai_whisper_large_v3_turbo/merges.txt               /cache/Korla_whisper_large_v3_turbo_hsb/
		#cp /cache/openai_whisper_large_v3_turbo/tokenizer.json           /cache/Korla_whisper_large_v3_turbo_hsb/
		#cp /cache/openai_whisper_large_v3_turbo/preprocessor_config.json /cache/Korla_whisper_large_v3_turbo_hsb/
		
        ## GGML ##

		mkdir -p /output/zalozbadev/whisper_large_v3_turbo_hsb_aug
		cd $WHISPER_V1_7_4
		python3 ./models/convert-h5-to-ggml.py /cache/zalozbadev_whisper_large_v3_turbo_hsb_aug/ /cache/openai_whisper/ /output/zalozbadev/whisper_large_v3_turbo_hsb_aug/
		;;
	
	zalozbadev/whisper-large-v3-turbo-hsb-aug-longest-trained)
		if [ ! -e /cache/zalozbadev_whisper_large_v3_turbo_hsb_aug_longest_trained ]; then
			git clone https://huggingface.co/zalozbadev/whisper-large-v3-turbo-hsb-aug /cache/zalozbadev_whisper_large_v3_turbo_hsb_aug_longest_trained
		fi
		
		pushd /cache/zalozbadev_whisper_large_v3_turbo_hsb_aug_longest_trained
		git checkout longest_trained
		popd
		
		if [ ! -e /cache/openai_whisper ]; then
			git clone https://github.com/openai/whisper                /cache/openai_whisper
		fi
		pushd /cache/openai_whisper && git checkout $OPENAI_WHISPER_TAG_LATEST && popd
		if [ ! -e /cache/openai_whisper_large_v3_turbo ]; then
			GIT_LFS_SKIP_SMUDGE=1 git clone https://huggingface.co/openai/whisper-large-v3-turbo      /cache/openai_whisper_large_v3_turbo
		fi

		#cp /cache/openai_whisper_large_v3_turbo/vocab.json        /cache/Korla_whisper_large_v3_turbo_hsb/
		#cp /cache/openai_whisper_large_v3_turbo/added_tokens.json /cache/Korla_whisper_large_v3_turbo_hsb/
		
		# not necessary for this python script, but required when creating ct2 model
		#cp /cache/openai_whisper_large_v3_turbo/merges.txt               /cache/Korla_whisper_large_v3_turbo_hsb/
		#cp /cache/openai_whisper_large_v3_turbo/tokenizer.json           /cache/Korla_whisper_large_v3_turbo_hsb/
		#cp /cache/openai_whisper_large_v3_turbo/preprocessor_config.json /cache/Korla_whisper_large_v3_turbo_hsb/
		
        ## GGML ##

		mkdir -p /output/zalozbadev/whisper_large_v3_turbo_hsb_aug_longest_trained
		cd $WHISPER_V1_7_4
		python3 ./models/convert-h5-to-ggml.py /cache/zalozbadev_whisper_large_v3_turbo_hsb_aug_longest_trained/ /cache/openai_whisper/ /output/zalozbadev/whisper_large_v3_turbo_hsb_aug_longest_trained/
		;;
	
	primeline/whisper-large-v3-german)
		if [ ! -e /cache/primeline_whisper-large-v3-german ]; then
			git clone https://huggingface.co/primeline/whisper-large-v3-german /cache/primeline_whisper-large-v3-german
		fi
		if [ ! -e /cache/openai_whisper ]; then
			git clone https://github.com/openai/whisper                /cache/openai_whisper
		fi
		pushd /cache/openai_whisper && git checkout $OPENAI_WHISPER_TAG_LATEST && popd
		if [ ! -e /cache/openai_whisper_large_v3_turbo ]; then
			GIT_LFS_SKIP_SMUDGE=1 git clone https://huggingface.co/openai/whisper-large-v3-turbo      /cache/openai_whisper_large_v3_turbo
		fi

		#cp /cache/openai_whisper_large_v3_turbo/vocab.json        /cache/Korla_whisper_large_v3_turbo_hsb/
		#cp /cache/openai_whisper_large_v3_turbo/added_tokens.json /cache/Korla_whisper_large_v3_turbo_hsb/
		
		# not necessary for this python script, but required when creating ct2 model
		#cp /cache/openai_whisper_large_v3_turbo/merges.txt               /cache/Korla_whisper_large_v3_turbo_hsb/
		#cp /cache/openai_whisper_large_v3_turbo/tokenizer.json           /cache/Korla_whisper_large_v3_turbo_hsb/
		#cp /cache/openai_whisper_large_v3_turbo/preprocessor_config.json /cache/Korla_whisper_large_v3_turbo_hsb/
		
        ## GGML ##

		mkdir -p /output/primeline/whisper-large-v3-german
		cd $WHISPER_V1_7_4
		python3 ./models/convert-h5-to-ggml.py /cache/primeline_whisper-large-v3-german/ /cache/openai_whisper/ /output/primeline/whisper-large-v3-german/
		;;
	
	*)
		echo "Model $MODEL unknown!"
		;;
	
esac
	