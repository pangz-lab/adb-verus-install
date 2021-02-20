#!/bin/bash
APP_BASE_PATH=$(pwd)
PHONE_SERIAL=${1}
NAME=${2}
MODE=${3}
THREAD=${4}
NUMBER_REGEX='^[0-9]+$'
source $APP_BASE_PATH/config/default.sh
source $APP_BASE_PATH/lib/lib.sh

[ -z "$PHONE_SERIAL" ] && echo "Serial number not found" && help
[ -z "$NAME" ] && echo "Name not found" && help
[ -z "$MODE" ] && echo "Mode not found" && help
[ "$MODE" != "$MINER_MODE_DEF" ] && [ "$MODE" != "$MINER_MODE_HBRID" ] && echo "Miner Mode unknown" && help
[ -z "$THREAD" ] && echo "Thread not found" && help
! [[ $THREAD =~ $NUMBER_REGEX ]] && echo "Thread should be numeric" && help

# disable_apps
echo " [ START ] $(date '+%d/%m/%Y %H:%M:%S')"
echo " [ Setup Start ]"
check_device_connection
create_miner_script $NAME $MODE $THREAD
install_apk_collection
import_termux_backup
show_initial_steps
echo " [ Setup Completed ] "
echo " [ END ] $(date '+%d/%m/%Y %H:%M:%S')"