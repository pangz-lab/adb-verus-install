CURRENT_PATH=$(pwd)
TERMUX_BASE_PATH=/data/data/com.termux/files/home
TERMUX_STORAGE=$TERMUX_BASE_PATH/storage/downloads
SUGO_SCRIPTS=$TERMUX_BASE_PATH/sugo_scripts
SUGO_FOLDER=$TERMUX_STORAGE/sugo
BASE_PATH=/root/ccminer
echo $CURRENT_PATH
echo $SUGO_FOLDER

exec_request() {
    echo $SUGO_FOLDER
    source $SUGO_SCRIPTS/ope_lib.sh
    [ ! -f "$SUGO_FOLDER/ope" ] && printf "Operation does not exist! Ending sugo request..." && return
    [ ! -f "$SUGO_FOLDER/ope_param" ] && printf "Sugo parameter does not exist! Endign sugo request.." && return

    [ -f $SUGO_FOLDER/ope_scripts.sh ] && source $SUGO_FOLDER/ope_scripts.sh

    local operation=$(cat $SUGO_FOLDER/ope)
    $operation $(cat $SUGO_FOLDER/ope_param)
    rm -rf $SUGO_FOLDER
    echo "operation $operation ended.." > ./sugo.log
    exit
}


log_file_size() {
    echo $(stat -c%s "$BASE_PATH/mine.log")
}

[ -d "$SUGO_FOLDER" ] && exec_request

if [ $TERMUX_BASE_PATH = $CURRENT_PATH ]
then
    termux-wake-lock
    ./start-ubuntu.sh
else
    LOG_SIZE="$(log_file_size)"
    sleep 5
    echo $LOG_SIZE
    echo $(log_file_size)
    if [ $LOG_SIZE = $(log_file_size) ] 
    then
	cd $BASE_PATH && ./miner.sh > ./mine.log
    fi
fi

