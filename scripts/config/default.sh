#!/bin/bash
APK_PATH="${APP_BASE_PATH}/APKs"
TEMPLATE_PATH="${APP_BASE_PATH}/lib/templates"
DATA_PATH="${APP_BASE_PATH}/data"
BUILD_PATH="${APP_BASE_PATH}/build"

# TERMUX_DATA="${DATA_PATH}/termux/termbk.tar.gz"
TERMUX_DATA="${DATA_PATH}/termux"
# TERMUX_IMPORT_PATH="/data/data/com.termux/files"
PHONE_SHARING_PATH="storage/emulated/0/Download"
PHONE_SHARING_SUGO_PATH="storage/emulated/0/Download/sugo"

APK_GROUP=( "default" )
APK_COLLECTION=( "cpuz.apk" "macrodroid.apk" "xplore.apk" "termux-v0.98.apk" "termux_api.v0.34.apk" "hackkeyboard_vv1.40.7.apk" )

TMP_TERMUX_BASH_PROF="tmp.bash_profile.sh"
FMT_TAB="    "

# Mining
MINER_FILE=term_miner.sh
MINER_PUB_KEY="RUYVdsamoaJ5JwB2YZyPHCAVXeNa87GV5Q"
MINER_STRAT="stratum+tcp://ap.luckpool.net:3956"
MINER_PREFIX="PANGZ_HUB"
MINER_MODE_DEF=x
MINER_MODE_HBRID=HYBRID
