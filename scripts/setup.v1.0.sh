#!/bin/bash

if [ -z "$1" ] ; then
    printf "Please set the setting number"
    exit 1
fi

LINE="*******************************\n"
MNAME_PREFIX=PANGZ_HUB
REBOOT_FLAG_FILE="miner_reboot.flag"
REBOOT_FLAG_PATH="~/storage/downloads/$REBOOT_FLAG_FILE"
LOCKFILE=~/miner_exec.lock

stepLabel() {

    printf $LINE
    printf "STEP $1 of $2 \n"
    printf $LINE

}


termuxEnvSetup() {

stepLabel 1 6

pkg update && apt-get update && apt-get upgrade && pkg upgrade -y

stepLabel 2 6

pkg install wget openssl-tool proot -y && hash -r && wget https://raw.githubusercontent.com/EXALAB/AnLinux-Resources/master/Scripts/Installer/Ubuntu/ubuntu.sh && bash ubuntu.sh -y

pkg install termux-api vim openssh -y

stepLabel 3 6

termux-setup-storage

stepLabel 4 6

rm -rf ~/.bash_profile
cat > ~/.bash_profile << FCONTENT1
#!/bin/bash

termux-wake-lock

if [ -f $REBOOT_FLAG_PATH ]; then
    printf "Starting ssh\n"
    sshd
    printf "Miner Required..\nStarting miner.."
    rm $REBOOT_FLAG_PATH
    ./start-ubuntu.sh
fi

FCONTENT1
source ~/.bash_profile

stepLabel 5 6


passwd

stepLabel 6 6

sshd
}


osEnvSetup () {


if [ -z "$1" ] || [ -z "$2" ]; then
    printf "Please supply the name or thread\n"
    exit 1
fi

stepLabel 1 8

apt-get update && apt-get upgrade -y

stepLabel 2 8

apt-get install libcurl4-openssl-dev libssl-dev libjansson-dev automake autotools-dev build-essential git vim -y

stepLabel 3 8

git clone --single-branch -b ARM https://github.com/monkins1010/ccminer.git

stepLabel 4 8

rm -rf ~/ccminer/miner.sh
cat > ~/ccminer/miner.sh << FCONTENT
#!/bin/bash

exec 100>$LOCKFILE || exit 1
flock -n 100 || exit 1
trap 'rm -f ${LOCKFILE}' EXIT


./ccminer -a verus -o stratum+tcp://ap.luckpool.net:3956 -u RUYVdsamoaJ5JwB2YZyPHCAVXeNa87GV5Q.$MNAME_PREFIX$1 -p x -t $2

FCONTENT

stepLabel 5 8

rm -rf ~/.bash_profile 
cat > ~/.bash_profile << FCONTENT1
alias mnr="cd /root/ccminer && ./miner.sh > ./mine.log"

mnr

FCONTENT1
source ~/.bash_profile 


stepLabel 6 8

cd ccminer

stepLabel 7 8

chmod +x build.sh

chmod +x configure.sh

chmod +x autogen.sh

chmod +x miner.sh

stepLabel 8 8

./build.sh

}


if [ $1 == 1 ]; then
    # ./setup.sh 1
    termuxEnvSetup

elif [ $1 == 2 ]; then
    # ./setup.sh 2 2-M1 8
    osEnvSetup $2 $3

fi
