
#!/bin/bash

BR="
"
LINE="$BR******************************$BR"
STRATUM_SERVER="stratum+tcp://ap.luckpool.net:3956"
PUB_ID="RUYVdsamoaJ5JwB2YZyPHCAVXeNa87GV5Q"
WORKER_NAME="PANGZ_HUB4-M1"
MINER_MODE="x"
MINER_THREAD="8"
MINER_SCRIPT_FILE="~/ccminer/miner.sh"

REBOOT_FLAG_FILE="miner_reboot.flag"
REBOOT_FLAG_BASE_PATH="~/storage/downloads/mnr"
REBOOT_FLAG_PATH="$REBOOT_FLAG_BASE_PATH/$REBOOT_FLAG_FILE"
LOCKFILE="~/miner_exec.lock"

stepLabel() {
    printf $LINE
    printf "$BR STEP $1 of $2 $BR"
    printf $LINE
}

termuxEnvSetup() {
    stepLabel 1 6
    pkg update -y && apt-get update -y && apt-get upgrade -y && pkg upgrade -y

    stepLabel 2 6
    pkg install wget openssl-tool proot -y && hash -r && wget https://raw.githubusercontent.com/EXALAB/AnLinux-Resources/master/Scripts/Installer/Ubuntu/ubuntu.sh && bash ubuntu.sh -y

    stepLabel 3 6
    pkg install vim openssh -y

    stepLabel 4 6
    rm -rf ~/.bash_profile
    cat > ~/.bash_profile << FCONTENT1
#!/bin/bash
termux-wake-lock

if [ -f $REBOOT_FLAG_PATH ]; then

    printf "Starting ssh..$BR"
    sshd
    printf "Starting miner..$BR"

    rm $REBOOT_FLAG_PATH
    ./start-ubuntu.sh
fi
FCONTENT1

    stepLabel 5 6
    source ~/.bash_profile

    stepLabel 6 6
    passwd
}

osEnvSetup () {
    stepLabel 1 8
    apt-get update && apt-get upgrade -y

    stepLabel 2 8
    apt-get install libcurl4-openssl-dev libssl-dev libjansson-dev automake autotools-dev build-essential git vim -y

    stepLabel 3 8
    git clone --single-branch -b ARM https://github.com/monkins1010/ccminer.git
    
    stepLabel 4 8
    rm -rf $MINER_SCRIPT_FILE
    cat > $MINER_SCRIPT_FILE << FCONTENT
#!/bin/bash

exec 100>$LOCKFILE || exit 1

flock -n 100 || exit 1

trap 'rm -f ${LOCKFILE}' EXIT

printf "$BR*******************$BR"
printf "  Miner Started" 
printf "$BR*******************$BR"
./ccminer -a verus -o $STRATUM_SERVER -u $PUB_ID.$WORKER_NAME -p $MINER_MODE -t $MINER_THREAD
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


if [ -z "$1" ] ; then
    printf "$BR Please set the setting # : $BR"
    exit 1
fi

if [ $1 == 1 ]; then
    # ./setup.sh 1
    termuxEnvSetup

elif [ $1 == 2 ]; then
    # ./setup.sh 2 2-M1 8
    osEnvSetup $2 $3
fi