FROM ubuntu:19.10

RUN apt-get update

# Install compilation toolchain, GCC 9 by default
RUN apt install -y build-essential gcc gcc-9 gnat-9 g++-9 
RUN update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-9 100
RUN update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-9 100

# Install dependencies
RUN apt install -y libisl-dev libgmp-dev libmpc-dev gcc-avr

# Build avr-ada
RUN mkdir              /tmp/build_avr_ada
COPY bin               /tmp/build_avr_ada 
COPY build-avr-ada.sh  /tmp/build_avr_ada
COPY patches           /tmp/build_avr_ada
COPY rts               /tmp/build_avr_ada 
RUN (cd /tmp/build_avr_ada && ./build-avr-ada.sh && rm -rf /tmp/build_avr_ada)

# Clean apt caches
RUN apt-get clean
