# CME.Runtime

CM Elements portable runtime

Рантаймы доставляются через Unity packages, которые доступны для каждой ОС:
* [com.cm.cme.runtime.osx](https://github.com/ggaller/com.cm.cme.runtime.osx)
* [com.cm.cme.runtime.win](https://github.com/ggaller/com.cm.cme.runtime.win)

## Создание .Net runtime
Версия .Net SDK `6.0.101`.

```sh
> ./scripts/dotnet-install.sh -v 6.0.101 -i runtimes/com.cm.cme.runtime.osx/.Bin/runtimes/dotnet --arch x64 --os osx --no-path

> ./scripts/dotnet-install.ps1 -Version 6.0.101 -InstallDir runtimes/com.cm.cme.runtime.win/.Bin/runtimes/dotnet x64 -Architecture x64 -NoPath
```

## Создание Node runtime
Версия Node `16.13.2`, пакета aws-cdk `2.8.0`.

```sh
> mkdir -p ./runtimes/com.cm.cme.runtime.osx/.Bin/runtimes/node && ./scripts/install-node.sh --version=16.13.2 --platform=darwin --prefix=runtimes/com.cm.cme.runtime.osx/.Bin/runtimes/node --arch=x64 -f
# https://nodejs.org/dist/v16.13.2/node-v16.13.2-darwin-x64.tar.gz

> npm install --no-save --prefix ./runtimes/com.cm.cme.runtime.osx/.Bin/tools/node aws-cdk@2.8.0
```

Для Windows окружения нужно скачать архив https://nodejs.org/download/release/latest-v16.x/node-v16.13.2-win-x64.zip и распаковать его в `./runtimes/com.cm.cme.runtime.win/.Bin/runtimes/node`

```sh
> npm install --no-save --prefix ./runtimes/com.cm.cme.runtime.win/.Bin/tools/node aws-cdk@2.8.0
```

## Тестирование runtime

Для тестирования рантайма можно переключиться на него командой:

```sh
> source osx-x64.env
```
