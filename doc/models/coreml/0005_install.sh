#!/bin/bash

source pythonenv/bin/activate

pip3 install -r requirements.txt

git clone https://github.com/ggerganov/whisper.cpp && cd whisper.cpp && git checkout v1.7.4

