#!/bin/bash

#GET DEVICE DETAIL 
#adb -s 353023082502118 shell getprop
#GET Pacakge List
#adb -t 39 shell 'pm list packages -f' | sed -e 's/.*=//' | sort
#-t 39 = transport id
DEVICE_SERIAL="$PHONE_SERIAL"

function check_device_connection {
	#TODO Check for TCP/IP 
	label_header "Verifying Connection"
	label_body "checking ..."
	local DEVICE_DETAIL=$(adb -s $DEVICE_SERIAL get-state | grep device)
	[ -z "$DEVICE_DETAIL" ] && label_body "No device found. Check your connection" && exit
	label_body "device found"
	label_body "Serial Number : "$DEVICE_SERIAL
}

function create_miner_script {
    label_header "Creating miner script"
    local MINER_NAME=$MINER_PREFIX$1
    local MODE=$2
    local THREAD=$3
    label_body "creating ..."
    echo "./ccminer -a verus -o $MINER_STRAT -u $MINER_PUB_KEY.$MINER_NAME -p $MODE -t $THREAD" > $TERMUX_DATA/$MINER_FILE
    [ ! -f "$TERMUX_DATA/$MINER_FILE" ] && echo "result : NG" && exit
    label_body "result : OK"
}

function install_apk_collection {
	label_header "Installing APKs"
	for apk in ${APK_COLLECTION[@]};
	do
		install_apk $APK_PATH/default/$apk $apk
	done
}

function install_apk {
	if [ ! -f "$1" ];
	then
		label_body "APK $1 does not exist"
		return 0
	fi
	
	label_body "installing ${2} ..."
	local RESULT=$(adb -s $DEVICE_SERIAL install -r $1 | grep -c Success)
	
	[ "$RESULT" > 0 ] && label_body "result : OK" || label_body "result : NG" 
}

function import_termux_backup {
	label_header "Importing Termux Data"
	label_body "checking ..."
	local SHARING_FOLDER=$(adb -s $DEVICE_SERIAL shell stat $PHONE_SHARING_PATH 2>/dev/null | grep -c -o Inode)
	[ ! -d "$TERMUX_DATA" ] && label_body "Cannot import. Termux data does not exist!" && exit
	[ "$SHARING_FOLDER" == 0 ] && label_body "Cannot import. Share folder does not exist!" && exit
	
	label_body "setup found ..."
    label_body "importing script and backup ..."
	local RESULT=$(adb -s $DEVICE_SERIAL push $TERMUX_DATA/term* $PHONE_SHARING_PATH | grep -c 'file pushed')
	[ "$RESULT" > 0 ] && label_body "result : OK" || label_body "result : NG"
    
    # label_body "importing bash script ..."
    # local RESULT=$(adb -s $DEVICE_SERIAL push $TERMUX_DATA/bash_setup.sh $PHONE_SHARING_PATH | grep -c 'file pushed')
	# [ "$RESULT" > 0 ] && label_body "result : OK" || label_body "result : NG"
    
    label_body "importing sugo ..."
    adb -s $DEVICE_SERIAL shell mkdir $PHONE_SHARING_SUGO_PATH
    local RESULT=$(adb -s $DEVICE_SERIAL push $TERMUX_DATA/sugo/ope* $PHONE_SHARING_SUGO_PATH | grep -c 'file pushed')
	[ "$RESULT" > 0 ] && label_body "result : OK" || label_body "result : NG"
    
}

function prepare_build_directory {
	[ -d "$BUILD_PATH" ] && rm -rf $BUILD_PATH
	mkdir $BUILD_PATH
}

function show_initial_steps() {
    label_header " Open Termux "
    label_body " - From the phone, type the following commands"
    label_body ""
    label_body "1. $ pkg install termux-api"
    label_body "2. $ termux-setup-storage"
    label_body "   - a prompt will appear; allow termux to access your storage"
    label_body "3. $ cp ./storage/downloads/term_bash_setup.sh .bash_profile"
    label_body "4. $ source .bash_profile"
    label_body "5. Relaunch termux. Proceed with the following methods"
    label_body ""
    label_body " [ Method 1 ]"
    label_body "   1. $ cp ./storage/downloads/term_bash_setup.sh .bash_profile"
    label_body "   2. $ cp ./storage/downloads/term_miner.sh ccminer/miner.sh"
    label_body "   3. $ chmod +x ccminer/miner.sh"
    label_body "   4. Exit and relaunch termux"
    label_body ""
    label_body " [ Method 2 ]"
    label_body "   1. $ util"
    label_body "   2. Choose #2"
    label_body "   3. Exit and relaunch termux"
}

function disable_apps {
	#TODO Revise
	# local PACKAGE_LIST=( $(adb -t 40 shell pm list packages -d) )
	local PACKAGE_LIST=""
	local APP=""
	
	while IFS= read -r app; do
		echo $app
		APP=$(echo $app | awk '{ print substr ($0, 9 ) }')
		echo $APP
		#adb -t 40 shell pm disable $APP &1>/dev/null
		adb shell pm disable $APP &1>/dev/null
		# $app 
		# adb -t 40 shell pm disable-user --user 0 $app 
		#PACKAGE_LIST+=( "$app" )
	#done < <( adb -t 40 shell pm list packages -d )
	done < <( adb shell pm list packages -d )
}

function generate_phone_scripts {
	label_header "Template Scripts Generation"
	cp $TEMPLATE_PATH/$TMP_TERMUX_BASH_PROF $BUILD_PATH/$TMP_TERMUX_BASH_PROF
}

function help {
	echo "setup.sh [PHONE MODEL]<space>[MINER NAME]"
}

function label_header {
	echo ""
	echo " [ $1 ]"
}

function label_body {
	echo "${FMT_TAB}>> $1"
}

function help {
    echo ""
    echo "  [ Help ]"
    echo "  ./setup.sh <serial no.> <miner name> <mode> <thread>"
    exit
}