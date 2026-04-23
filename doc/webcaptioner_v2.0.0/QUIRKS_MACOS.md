# Wosebitosće za MacOS

## Model za spóznawanje twarić

* jenož modele, kiž w tabulce maja křižik pola "coreml", wužiwać!
* potom sćěhowace skripty wuwjesć:

```bash
cd coreml/
./0001_venv.sh
./0005_install.sh
./0010_convert_coreml.sh
cd ..
```

## sotra

```bash
nano Dockerfile # abo hinaši editor

# po lince "WORKDIR /app" sćěhowace zapisać

RUN apt update && apt install -y cmake libboost-all-dev libre2-dev python3-pybind11

# dataju składować (CTRL+X y)

```

