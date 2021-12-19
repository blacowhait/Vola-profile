# Repo for volatility profile i was made

i make volatility profile with 2 method:
1. Docker
2. Manual

## Docker
build docker image with target linux and kernel version. I learn this from [hanasuru Github](https://github.com/hanasuru/vol_profile_builder)
1. Make Dockerfile
```
FROM <DISTRO>:<TAG-VERSION> # distro or target OS
RUN apt update

# install kernel 
RUN apt -y install linux-tools-<KERNEL-VERSION>
RUN apt -y install linux-headers-<KERNEL-VERSION>
RUN apt -y install linux-modules-<KERNEL-VERSION>

RUN apt -y install zip git build-essential dwarfdump
RUN git clone https://github.com/volatilityfoundation/volatility.git
RUN sed -i 's/\$(shell uname -r)/"<KERNEL-VERSION>"/' volatility/tools/linux/Makefile
RUN cd volatility/tools/linux/ && make
RUN zip /<DISTRO-VERSION>-<KERNEL-VERSION>.zip volatility/tools/linux/module.dwarf /boot/System.map-<KERNEL-VERSION>
```
2. Build docker and get vola profile
```
docker build -t volatility:<DISTRO-VERSION> .
docker run --name profile volatility<DISTRO-VERSION>
docker cp profile:<DISTRO-VERSION>-<KERNEL-VERSION>.zip /root/<DISTRO-VERSION>-<KERNEL-VERSION>.zip
```
3. Move profile to volatility folder
4. for example [Dockerfile](Dockerfile)

## Manual
use virtualBox with target linux version
```
git clone https://github.com/volatilityfoundation/volatility.git
cd volatility/tools/linux/ && make
cd ../../../
zip $(lsb_release -i -s)_$(uname -r)_profile.zip ./volatility/tools/linux/module.dwarf /boot/System.map-$(uname -r)
rm -rf ./volatility
```
if kernel version doesnt match, just use
```
sudo apt install <KERNEL-VERSION>
```
