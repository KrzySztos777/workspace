#goto system catalog
cd ~

#install dependencies
sudo apt-get update
sudo apt install cmake python3 build-essential gcc-arm-none-eabi libnewlib-arm-none-eabi libstdc++-arm-none-eabi-newlib git

#lets create pico catalogue and go to it
mkdir pico
cd pico

#clone pico-sdk, examples and freertos
git clone -b master --recurse-submodules https://github.com/raspberrypi/pico-sdk.git
git clone -b master --recurse-submodules https://github.com/raspberrypi/pico-examples.git

#don't if official FreeRTOS Kernel already support RP2350
#git clone --recurse-submodules https://github.com/FreeRTOS/FreeRTOS-Kernel.git #official FreeRTOS-Kernel doesnt support it yet
git clone --recurse-submodules https://github.com/raspberrypi/FreeRTOS-Kernel

#add environment variables
echo 'export PICO_SDK_PATH=~/pico/pico-sdk' >> ~/.bashrc
echo 'export PICO_EXAMPLES_PATH=~/pico/pico-examples' >> ~/.bashrc
echo 'export FREERTOS_KERNEL_PATH=~/pico/FreeRTOS-Kernel' >> ~/.bashrc
source ~/.bashrc

#install picotool. exmpales need it so it is good to install once only
git clone https://github.com/raspberrypi/picotool.git
cd picotool
mkdir build
cd build
cmake ..
make -j$(nproc)
sudo make install

#build examples for pico
cd $PICO_EXAMPLES_PATH
mkdir build_pico
cd build_pico/
cmake -DPICO_PLATFORM=rp2040 -DPICO_BOARD=pico ..
make -j$(nproc)

#build examples for pico2
cd $PICO_EXAMPLES_PATH
mkdir build_pico2
cd build_pico2/
cmake -DPICO_PLATFORM=rp2350 -DPICO_BOARD=pico2 ..
make -j$(nproc)

#Debugger (TODO)
