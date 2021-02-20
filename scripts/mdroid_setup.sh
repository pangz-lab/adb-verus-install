#!/bin/bash
[v=sh.BR]
LINE="$BR******************************$BR"
STRATUM_SERVER="[v=sh.STRATUM_SERVER]"
PUB_ID="[v=sh.PUBLIC_ADDRESS]"
WORKER_NAME="[v=sh.WORKER_NAME]"
MINER_MODE="[v=sh.MINER_MODE]"
MINER_THREAD="[v=sh.MINER_THREAD]"
MINER_SCRIPT_FILE="[v=sh.MINER_SCRIPT_FILE]"
REBOOT_FLAG_FILE="[v=sh.REBOOT_FILE]"
REBOOT_FLAG_BASE_PATH="[v=sh.REBOOT_FLAG_BASE_PATH]"
REBOOT_FLAG_PATH="[v=sh.REBOOT_FLAG_PATH]"
LOCKFILE="[v=sh.MINER_LOCK_FILE]"

stepLabel() {
	printf $LINE    printf "$BR STEP $1 of $2 $BR"    printf $LINE
}

termuxEnvSetup() {
	stepLabel 1 6    
	[v=sh.TERMUX_UPDATE_CMD]
    stepLabel 2 6    
	[v=sh.DISTRO_DL_CMD]
    stepLabel 3 6    
	pkg install vim openssh -y
    stepLabel 4 6    
	rm -rf ~/.bash_profile    cat > ~/.bash_profile<< FCONTENT1
	[v=sh.BASH_PROF_TERMUX]
	FCONTENT1
    stepLabel 5 6    source ~/.bash_profile
    stepLabel 6 6    passwd
}

osEnvSetup () {
	stepLabel 1 8    [v=sh.DISTRO_UPDATE_CMD]
    stepLabel 2 8    [v=sh.MINING_SCRIPT_LIB_DL]
    stepLabel 3 8    [v=sh.MINING_SCRIPT_DL]        
	stepLabel 4 8    rm -rf $MINER_SCRIPT_FILE
	cat > $MINER_SCRIPT_FILE << FCONTENT
	[v=sh.MINER_SCRIPT]
	FCONTENT
    stepLabel 5 8    rm -rf ~/.bash_profile    cat > ~/.bash_profile << FCONTENT1
	[v=sh.BASH_PROF_DISTRO]
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

if [ -z "$1" ] ; then    printf "$BR Please set the setting # : $BR"    exit 1fi
if [ $1 == 1 ]; then    # ./setup.sh 1    termuxEnvSetup
elif [ $1 == 2 ]; then    # ./setup.sh 2 2-M1 8    osEnvSetup $2 $3fi