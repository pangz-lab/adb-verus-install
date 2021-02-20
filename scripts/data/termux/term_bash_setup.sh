CURRENT_PATH=$(pwd)

UBUNTU_BASE_PATH=/root/ccminer
TERMUX_BASE_PATH=/data/data/com.termux/files/home
TERMUX_STORAGE=$TERMUX_BASE_PATH/storage/downloads
SUGO_SCRIPTS=$TERMUX_BASE_PATH/sugo_scripts
SUGO_SHARING_FOLDER=$TERMUX_STORAGE/sugo
SUGO_LAST_FOLDER=$TERMUX_STORAGE/last_sugo

OPE_SCRIPT_FILE=ope_scripts.sh
OPE_FILE=$SUGO_SHARING_FOLDER/ope
OPE_PARAM=$SUGO_SHARING_FOLDER/ope_param
OPE_SCRIPTS=$SUGO_SHARING_FOLDER/$OPE_SCRIPT_FILE

#echo $CURRENT_PATH
#echo $SUGO_SHARING_FOLDER

exec_request() {
    echo "Starting sugo..."
    echo $SUGO_SHARING_FOLDER
    local message1="Operation does not exist! Ending sugo request..."
    local message2="Sugo parameter does not exist! Ending sugo request.."
    local message3="Sugo script does not exist! Ending sugo request.."

    [ ! -f "$OPE_FILE" ] && printf $message1 && return
    [ ! -f "$OPE_PARAM" ] && printf $message2 && return
    [ ! -f "$OPE_SCRIPTS" ] && printf $message3 && return

    cp $OPE_SCRIPTS ./$OPE_SCRIPT_FILE
    source ./$OPE_SCRIPT_FILE

    local operation=$(cat $OPE_FILE)
    $operation $(cat $OPE_PARAM)
    mkdir $SUGO_LAST_FOLDER
    mv $SUGO_SHARING_FOLDER/* $SUGO_LAST_FOLDER
    rm -rf $SUGO_SHARING_FOLDER
    echo "operation $operation ended.." > ./sugo.log
    echo "Sugo ended..."
    exit
}

log_file_size() {
    echo $(stat -c%s "$UBUNTU_BASE_PATH/mine.log")
}

[ -d "$SUGO_SHARING_FOLDER" ] && exec_request

if [ $TERMUX_BASE_PATH = $CURRENT_PATH ]
then
    printf " [ Starting miner ] "
    printf " >> enabling wake lock ..."
    termux-wake-lock
    printf " >> starting sshd ..."
    sshd
    printf " >> starting ubuntu ..."
    ./start-ubuntu.sh
else
    LOG_SIZE="$(log_file_size)"
    sleep 5
    echo $LOG_SIZE
    echo $(log_file_size)
    if [ $LOG_SIZE = $(log_file_size) ] 
    then
        printf " >> starting miner ..."
        cd $UBUNTU_BASE_PATH && ./miner.sh > ./mine.log
    fi
fi

