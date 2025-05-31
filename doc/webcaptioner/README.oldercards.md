# remember steps for older NVIDIA cards

- install CUDA 10.2 from NVIDIA
- do not install drivers
- skip compiler check

- install gcc-8 from source (gcc 8.5)
- install required build deps
- use this cmdline to configure build

./configure --disable-multilib --disable-bootstrap --enable-languages=c,c++ --prefix=/opt/gcc-8/
make -j 4
sudo make install

- link gcc-8 compiler into CUDA bindir and set PATH appropriately

cd /usr/local/cuda-10.2/bin/
sudo ln -s /opt/gcc-8/bin/gcc gcc
sudo ln -s /opt/gcc-8/bin/g++ g++


export PATH=/usr/local/cuda-10.2/bin/:$PATH
export LD_LIBRARY_PATH=/usr/local/cuda-10.2/lib64/:$LD_LIBRARY_PATH

checkout git@github.com:danielzoba/whisper.cpp.git branch v1.7.0_CUDA10
checkout git@github.com:danielzoba/whisper.cpp.git branch v1.7.1_CUDA10
checkout git@github.com:danielzoba/whisper.cpp.git branch v1.7.2_CUDA10

CC=/opt/gcc-8/bin/gcc CXX=/opt/gcc-8/bin/g++ GGML_CUDA=1 CUDA_DOCKER_ARCH=compute_30 make -j 4 main

checkout git@github.com:danielzoba/whisper.cpp.git branch v1.7.3_CUDA10

cmake -B build -DGGML_CUDA=1 -DCMAKE_CUDA_ARCHITECTURES=30 -DCMAKE_CUDA_STANDARD=14 -DCMAKE_CUDA_STANDARD_REQUIRED=true && cmake --build build -j 4 --config Release

