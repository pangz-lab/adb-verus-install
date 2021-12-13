#!/bin/bash
APK_PATH="${APP_BASE_PATH}/APKs"
TEMPLATE_PATH="${APP_BASE_PATH}/lib/templates"
DATA_PATH="${APP_BASE_PATH}/data"
BUILD_PATH="${APP_BASE_PATH}/build"

TERMUX_DATA="${DATA_PATH}/termux"
PHONE_SHARING_PATH="storage/emulated/0/Download"
PHONE_SHARING_SUGO_PATH="storage/emulated/0/Download/sugo"

APK_GROUP=( "default" )
# Placing the app name in the 'APK_COLLECTION' array allows installation of the apps during the setup.
# Place the APK of any compatible apps in /scripts/APKs/default folder then specify the name in the 
# 'APK_COLLECTION' array as shown in the following.
#APK_COLLECTION=( "cpuz.apk" "macrodroid.apk" "xplore.apk" "termux-v0.98.apk" "termux_api.v0.34.apk" "hackkeyboard_vv1.40.7.apk" )
APK_COLLECTION=( "termux-v0.98.apk" "termux_api.v0.34.apk" )

TMP_TERMUX_BASH_PROF="tmp.bash_profile.sh"
FMT_TAB="    "

# Mining
#Change the Public Address
MINER_PUB_KEY="RUYVdsamoaJ5JwB2YZyPHCAVXeNa87GV5Q"
MINER_PREFIX="PANGZ_HUB"
MINER_STRAT="stratum+tcp://ap.luckpool.net:3956"
MINER_MODE_DEF=x
MINER_FILE=term_miner.sh
MINER_MODE_HBRID=HYBRID
