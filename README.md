# Repo for volatility profile i was made

i make volatility profile with 2 method:
1. Docker
2. Manual

## Docker
build docker image with target linux and kernel version. You can see in [hanasuru Github](https://github.com/hanasuru/vol_profile_builder)

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
