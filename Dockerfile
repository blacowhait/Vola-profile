FROM ubuntu:18.04

RUN apt update 
RUN apt -y install linux-tools-4.15.0-163-generic
RUN apt -y install linux-headers-4.15.0-163-generic
RUN apt -y install linux-modules-4.15.0-163-generic
RUN apt -y install zip git build-essential dwarfdump

RUN git clone https://github.com/volatilityfoundation/volatility.git
RUN sed -i 's/\$(shell uname -r)/"4.15.0-163-generic"/' volatility/tools/linux/Makefile
RUN cd volatility/tools/linux/ && make
RUN zip /Ubuntu18.04.6-4.15.0-163-generic.zip volatility/tools/linux/module.dwarf /boot/System.map-4.15.0-163-generic
