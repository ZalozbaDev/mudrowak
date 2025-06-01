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
checkout git@github.com:danielzoba/whisper.cpp.git branch v1.7.4_CUDA10
checkout git@github.com:danielzoba/whisper.cpp.git branch v1.7.5_CUDA10

cmake -B build -DGGML_CUDA=1 -DCMAKE_CUDA_ARCHITECTURES=30 -DCMAKE_CUDA_STANDARD=14 -DCMAKE_CUDA_STANDARD_REQUIRED=true && cmake --build build -j 4 --config Release

# comparison

## 1.7.5

./build/bin/whisper-cli -m ~/whisper_models/Korla/whisper_large_v3_turbo_hsb/ggml-model.bin ../testdata/0001_16.wav ../testdata/0002_16.wav

### CUDA (compute_30)

whisper_print_timings:     load time =  3996.09 ms
whisper_print_timings:     fallbacks =   0 p /   0 h
whisper_print_timings:      mel time =   281.67 ms
whisper_print_timings:   sample time =  2553.69 ms /  3673 runs (    0.70 ms per run)
whisper_print_timings:   encode time = 69165.73 ms /     7 runs ( 9880.82 ms per run)
whisper_print_timings:   decode time =    36.39 ms /     1 runs (   36.39 ms per run)
whisper_print_timings:   batchd time = 129628.92 ms /  3643 runs (   35.58 ms per run)
whisper_print_timings:   prompt time =  2186.57 ms /   987 runs (    2.22 ms per run)
whisper_print_timings:    total time = 207976.19 ms

### CPU (n_threads = 4 / 8)

whisper_print_timings:     load time =   701.88 ms
whisper_print_timings:     fallbacks =   0 p /   0 h
whisper_print_timings:      mel time =   299.45 ms
whisper_print_timings:   sample time =  3699.55 ms /  3673 runs (    1.01 ms per run)
whisper_print_timings:   encode time = 351173.44 ms /     7 runs (50167.63 ms per run)
whisper_print_timings:   decode time =    20.23 ms /     1 runs (   20.23 ms per run)
whisper_print_timings:   batchd time = 31874.24 ms /  3643 runs (    8.75 ms per run)
whisper_print_timings:   prompt time =  7167.88 ms /   987 runs (    7.26 ms per run)
whisper_print_timings:    total time = 395129.84 ms

## 1.7.4

./build/bin/whisper-cli -m ~/whisper_models/Korla/whisper_large_v3_turbo_hsb/ggml-model.bin ../testdata/0001_16.wav ../testdata/0002_16.wav

### CUDA (compute_30)

whisper_print_timings:     load time =   805.83 ms
whisper_print_timings:     fallbacks =   0 p /   0 h
whisper_print_timings:      mel time =   283.92 ms
whisper_print_timings:   sample time =  2658.02 ms /  3569 runs (    0.74 ms per run)
whisper_print_timings:   encode time = 68710.68 ms /     7 runs ( 9815.81 ms per run)
whisper_print_timings:   decode time =    72.77 ms /     2 runs (   36.38 ms per run)
whisper_print_timings:   batchd time = 126101.39 ms /  3538 runs (   35.64 ms per run)
whisper_print_timings:   prompt time =  2194.75 ms /   987 runs (    2.22 ms per run)
whisper_print_timings:    total time = 200941.19 ms

### CPU (n_threads = 4 / 8)

whisper_print_timings:     load time =   709.63 ms
whisper_print_timings:     fallbacks =   0 p /   0 h
whisper_print_timings:      mel time =   403.36 ms
whisper_print_timings:   sample time =  3872.78 ms /  3569 runs (    1.09 ms per run)
whisper_print_timings:   encode time = 388621.84 ms /     7 runs (55517.41 ms per run)
whisper_print_timings:   decode time =    45.61 ms /     2 runs (   22.81 ms per run)
whisper_print_timings:   batchd time = 34667.16 ms /  3538 runs (    9.80 ms per run)
whisper_print_timings:   prompt time =  7737.62 ms /   987 runs (    7.84 ms per run)
whisper_print_timings:    total time = 436285.00 ms

# quantization

## 1.7.4 (CUDA compute_30)

./build/bin/quantize ~/whisper_models/Korla/whisper_large_v3_turbo_hsb/ggml-model.bin ../ggml-model.q8_0.bin q8_0
./build/bin/quantize ~/whisper_models/Korla/whisper_large_v3_turbo_hsb/ggml-model.bin ../ggml-model.q4_0.bin q4_0
./build/bin/quantize ~/whisper_models/Korla/whisper_large_v3_turbo_hsb/ggml-model.bin ../ggml-model.q6_k.bin q6_k
./build/bin/quantize ~/whisper_models/Korla/whisper_large_v3_turbo_hsb/ggml-model.bin ../ggml-model.q5_1.bin q5_1

### unquantized

[00:00:00.000 --> 00:00:29.980]  Słyšimy čitanje z lista swjateho japoštowa pawoła romjanam bratře a sotry jeli je bóh za nas štó je přećiwo nam wón njeje swojeho syna přelutował ale je jeho za nas wšěch podał kak by nam wón z nim wšitko njedarił štó budźe skoržić přećiwo wuzwolenym božim hdyž bóh wusprawnja štó móhł tamać.
[00:00:30.000 --> 00:00:42.180]   Jězus chrystus kiž je wumrěł haj kiž bu ze smjerće zbudźeny je při božej prawicy a nas zastupuje słyšeli smy słowo bože.
[00:00:00.000 --> 00:00:29.040]  Haj ty sy swjaty wulki božo a sy wšitkim ludźom napřećo dobry dźakujemy so ći za to wosebje dźakujemy so ći za jězusa chrystusa wón je wšitkich ludźi pozbudźał kotřiž so před tobu bojachu je chcył wšěch nawróćić kotřiž běchu před tobu ćeknyli wón je ludźom wodawał kotřiž běchu jemu njeprawdu činili a z hrěšnikami je sedźał za blido z nimi jědł.
[00:00:30.000 --> 00:00:45.460]  Wón je nas nětko tu za jedne wědo zhromadźił zo bychmy činili štož je wón činił tohodla smy chlěb a wino přihotowali a prosymy će wótře poswětujtej daraj zo byše nam dyrłoj ćěło a krej jězusa chrystusa.
[00:00:45.460 --> 00:00:55.420]   Jězus běše wječor do swojeje smjerće ze swojimi wučobnikami hromadźe zo by z nimi jutrownu hosćinu swjećił.
[00:00:56.200 --> 00:01:09.500]   Wón je wzał chlěb je so ći dźakował je chlěb rozłamał jón swojim wučobnikam dał a prajił wzmiće a jěsće wšitcy wot toho to je moje ćěło kotryž budźe za was podate.
[00:01:10.200 --> 00:01:37.100]   Potom je wzał keluch z winom je so ći dźakował je keluch swojim wučobnikam podał a prajił wzmiće a piće wšitcy z njeho to je keluch noweho a wěčneho zakonja.
[00:01:37.200 --> 00:01:46.660]   Moja krej kotraž budźe za was a za mnohich přelata k wodawanju hrěchow potom praji čińće to na mnje spominaj.

whisper_print_timings:     load time =   805.83 ms
whisper_print_timings:     fallbacks =   0 p /   0 h
whisper_print_timings:      mel time =   283.92 ms
whisper_print_timings:   sample time =  2658.02 ms /  3569 runs (    0.74 ms per run)
whisper_print_timings:   encode time = 68710.68 ms /     7 runs ( 9815.81 ms per run)
whisper_print_timings:   decode time =    72.77 ms /     2 runs (   36.38 ms per run)
whisper_print_timings:   batchd time = 126101.39 ms /  3538 runs (   35.64 ms per run)
whisper_print_timings:   prompt time =  2194.75 ms /   987 runs (    2.22 ms per run)
whisper_print_timings:    total time = 200941.19 ms

### q8_0

[00:00:00.000 --> 00:00:29.980]  Słyšimy čitanje z lista swjateho japoštowa pawoła romjanam bratře a sotry jeli je bóh za nas štó je přećiwo nam wón njeje swojeho syna přelutował ale je jeho za nas wšěch podał kak by nam wón z nim wšitko njedarił štó budźe skoržić přećiwo wuzwolenym božim hdyž bóh wusprawnja štó móhł tamać.
[00:00:30.000 --> 00:00:42.200]   Jězus chrystus kiž je wumrěł haj kiž bu ze smjerće zbudźeny je při božej prawicy a nas zastupuje słyšeli smy słowo bože.
[00:00:00.000 --> 00:00:29.040]  Haj ty sy swjaty wulki božo a sy wšitkim ludźom napřećo dobry dźakujemy so ći za to wosebje dźakujemy so ći za jězusa chrystusa wón je wšitkich ludźi pozbudźał kotřiž so před tobu bojachu je chcył wšěch nawróćić kotřiž běchu před tobu ćeknyli wón je ludźom wodawał kotřiž běchu jemu njeprawdu činili a z hrěšnikami je sedźał za blido z nimi jědł.
[00:00:30.000 --> 00:00:45.460]  Wón je nas nětko tu za jedne wědo zhromadźił zo bychmy činili štož je wón činił tohodla smy chlěb a wino přihotowali a prosymy će wótře poswětujtej daraj zo byše nam dyrłoj ćěło a krej jězusa chrystusa.
[00:00:45.460 --> 00:00:55.420]   Jězus běše wječor do swojeje smjerće ze swojimi wučobnikami hromadźe zo by z nimi jutrownu hosćinu swjećił.
[00:00:56.200 --> 00:01:09.500]   Wón je wzał chlěb je so ći dźakował je chlěb rozłamał jón swojim wučobnikam dał a prajił wzmiće a jěsće wšitcy wot toho to je moje ćěło kotryž budźe za was podate.
[00:01:10.200 --> 00:01:37.100]   Potom je wzał keluch z winom je so ći dźakował je keluch swojim wučobnikam podał a prajił wzmiće a piće wšitcy z njeho to je keluch noweho a wěčneho zakonja.
[00:01:37.200 --> 00:01:46.660]   Moja krej kotraž budźe za was a za mnohich přelata k wodawanju hrěchow potom praji čińće to na mnje spominaj.

whisper_print_timings:     load time =   503.48 ms
whisper_print_timings:     fallbacks =   0 p /   0 h
whisper_print_timings:      mel time =   305.56 ms
whisper_print_timings:   sample time =  2575.06 ms /  3585 runs (    0.72 ms per run)
whisper_print_timings:   encode time = 68356.22 ms /     7 runs ( 9765.17 ms per run)
whisper_print_timings:   decode time =    66.60 ms /     2 runs (   33.30 ms per run)
whisper_print_timings:   batchd time = 51484.68 ms /  3554 runs (   14.49 ms per run)
whisper_print_timings:   prompt time =  2145.27 ms /   987 runs (    2.17 ms per run)
whisper_print_timings:    total time = 125552.00 ms

only timing diff to unquantized

### q4_0

[00:00:00.000 --> 00:00:29.980]  Słyšimy čitanje z lista sej a toho japoštowa pawoła romjanam bratřeja sotry jeli je bóh za nas štó je přećiwo nam wón njeje swojeho syna přelutował ale je jeho za nas wšěch podał kak by nam wón z nim wšitko njedarił štó budźe skoržić přećiwo wuzwolenym božim hdyž bóh wusprawnja štó móhł tamać.
[00:00:30.000 --> 00:00:42.200]   Jězus chrystus kiž je wumrěł haj kiž bu ze smjerće zbudźeny je při božej prawicy a nas zastupuje słyšeli smy słowo bože.
[00:00:00.000 --> 00:00:29.040]  Haj ty sy swjaty wulki božo a sy wšitkim ludźom napřećo dobry dźakujemy so ći za to wosebje dźakujemy so ći za jězusa chrystusa wón je wšitkich ludźi pozbudźał kotřiž so před tobu bojachu je chcył wšěch nawróćić kotřiž běchu před tobu ćeknyli wón je ludźom wodawał kotřiž běchu jemu njeprawdu činili a z hrěšnikami je sedźał za blido z nimi jědł.
[00:00:30.000 --> 00:00:45.420]  Wón je nas nětko tu za jedne wědo zhromadźił zo bychmy činili štož je wón činił tohodla smy chlěb a wino přihotowali a prosymy će wótře poswětujtej daraj zo byše nam dyrłoj ćěło a kreji jězusa chrystusa.
[00:00:45.420 --> 00:00:59.000]   Jězus běše wječor do swojeje smjerće ze swojimi wučobnikami hromadźe zo by z nimi jutrownu hosćinu swjećił wón je wzał chlěb je so ći dźakował.
[00:01:00.000 --> 00:01:09.000]   Je keluch swojim wón swojim wón swojim wučobnikam dał a prajił zmiće a jěsće wšitcy wot toho to je moje ćěło potryž budźe za was podate.
[00:01:09.000 --> 00:01:36.000]   Potom je wzał keluch z winom je so ći dźakował je keluch swojim wučobnikam podał a prajił zmiće a piće wšitcy z njeho to je keluch noweho a wěčneho zakonja.
[00:01:36.000 --> 00:01:54.560]   moja kreji kotraž budźe za was a za mnohich přelata k wodawanju hrěchow potom praji čińće to na mnje spominaj.


whisper_print_timings:     load time =   334.76 ms
whisper_print_timings:     fallbacks =   0 p /   0 h
whisper_print_timings:      mel time =   323.73 ms
whisper_print_timings:   sample time =  2227.70 ms /  3022 runs (    0.74 ms per run)
whisper_print_timings:   encode time = 69488.99 ms /     7 runs ( 9927.00 ms per run)
whisper_print_timings:   decode time =    90.12 ms /     3 runs (   30.04 ms per run)
whisper_print_timings:   batchd time = 54181.95 ms /  2990 runs (   18.12 ms per run)
whisper_print_timings:   prompt time =  2297.10 ms /   988 runs (    2.32 ms per run)
whisper_print_timings:    total time = 129068.53 ms

many timing diffs, some content diff to unquantized

### q6_k

does not work with compute_30

### q5_1

[00:00:00.000 --> 00:00:29.980]  Słyšimy čitanje z lista swjateho japoštowa pawoła romjanam bratře a sotry jeli je bóh za nas štó je přećiwo nam wón njeje swojeho syna přelutował ale je jeho za nas wšěch podał kak by nam wón z nim wšitko njedarił štó budźe skoržić přećiwo wuzwolenym božim hdyž bóh wusprawnja štó móhł tamać.
[00:00:30.000 --> 00:00:42.200]   Jězus chrystus kiž je wumrěł haj kiž bu ze smjerće zbudźeny je při božej prawicy a nas zastupuje słyšeli smy słowo bože.
[00:00:00.000 --> 00:00:29.080]  Haj ty sy swjaty wulki božo a sy wšitkim ludźom napřećo dobry dźakujemy so ći za to wosebje dźakujemy so ći za jězusa chrystusa wón je wšitkich ludźi pozbudźał kotřiž so před tobu bojachu je chcył wšěch nawróćić kotřiž běchu před tobu ćeknyli wón je ludźom wodawał kotřiž běchu jemu njeprawdu činili a z hrěšnikami je sedźał za blido z nimi jědł.
[00:00:30.000 --> 00:00:45.460]  Wón je nas nětko tu za jedne wědo zhromadźił zo bychmy činili štož je wón činił tohodla smy chlěb a wino přihotowali a prosymy će wótře poswětujtej daraj zo byše nam dyrłoj ćěło a krej jězusa chrystusa.
[00:00:45.460 --> 00:00:55.420]   Jězus běše wječor do swojeje smjerće ze swojimi wučobnikami hromadźe zo by z nimi jutrownu hosćinu swjećił.
[00:00:56.180 --> 00:01:09.520]   Wón je wzał chlěb je so ći dźakował je chlěb rozłamał jón swojim wučobnikam dał a prajił wzmiće a jěsće wšitcy wot toho to je moje ćěło kotryž budźe za was podate.
[00:01:22.180 --> 00:01:42.420]   Potom je wzał keluch z winom je so ći dźakował je keluch swojim wučobnikam podał a prajił wzmiće a pijće wšitcy z njeho to je keluch noweho a wěčneho zakonja moja krej kotraž budźe za was a za mnohich přelata k wodawanju hrěchow.
[00:01:42.420 --> 00:01:46.720]   Potom praji čińće to na mnje spominaj.

whisper_print_timings:     load time =   429.61 ms
whisper_print_timings:     fallbacks =   0 p /   0 h
whisper_print_timings:      mel time =   301.81 ms
whisper_print_timings:   sample time =  2674.76 ms /  3721 runs (    0.72 ms per run)
whisper_print_timings:   encode time = 68785.28 ms /     7 runs ( 9826.47 ms per run)
whisper_print_timings:   decode time =    32.07 ms /     1 runs (   32.07 ms per run)
whisper_print_timings:   batchd time = 64660.17 ms /  3691 runs (   17.52 ms per run)
whisper_print_timings:   prompt time =  2209.41 ms /   987 runs (    2.24 ms per run)
whisper_print_timings:    total time = 139210.62 ms

some timing diff, almost equal content to unquantized
