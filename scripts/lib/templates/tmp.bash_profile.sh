#!/bin/bash
CURRENT_PATH=$(pwd)
TERMUX_BASE_PATH=/data/data/com.termux/files/home
BASE_PATH=/root/ccminer

echo $CURRENT_PATH
log_file_size() {
	echo $(stat -c%s "$BASE_PATH/mine.log")
}

if [ $TERMUX_BASE_PATH = $CURRENT_PATH ]then
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