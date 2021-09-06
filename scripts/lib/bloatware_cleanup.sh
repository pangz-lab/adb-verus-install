#!/bin/bash
FLAG_3RD_PARTY=-3
FLAG_SYSTEM=-s

function get_packages {
    return `adb shell pm list packages -$1`
}

function get_packages_3P {
    return get_packages -3
}

function get_packages_system {
    return get_packages -s
}

function uninstall_apps {
    APP_LIST=`adb shell pm list packages $1`
	echo " Uninstalling Apps : "
	echo $APP_LIST

    for value in ${APP_LIST}
    do
        IFS=':' read -ra NAME_ARRAY <<< "$value"
        local PKG_NAME=${NAME_ARRAY[1]}
        local PKG=$(echo ${PKG_NAME} | tr -d '\n\r')
        echo " ... uninstalling ${PKG_NAME}"

        local TMP_RESULT=$(adb uninstall ${PKG} 2>/dev/null)
        echo $TMP_RESULT
        RESULT=$(echo $TMP_RESULT | grep -c 'Success')
	    [ "$RESULT" > 0 ] && echo "result : OK" || echo "result : NG"
        echo "---------------------------------"
    done
}

function uninstall_apps_system {
    uninstall_apps $FLAG_SYSTEM
}

function uninstall_apps_3P {
    uninstall_apps $FLAG_3RD_PARTY
}

function disable_apps {
    APP_LIST=`adb shell pm list packages $1`
	echo " Disabling Apps : "
	echo $APP_LIST
	
    for value in ${APP_LIST}
    do
        echo $value

        IFS=':' read -ra NAME_ARRAY <<< "$value"
        local PKG_NAME=${NAME_ARRAY[1]}
        local PKG=$(echo ${PKG_NAME} | tr -d '\n\r')

        echo " ... disabling ${PKG}"
        local TMP_RESULT=$(adb shell pm disable-user ${PKG})
        echo $TMP_RESULT
        RESULT=$(echo $TMP_RESULT | grep -c 'Success')
	    [ "$RESULT" > 0 ] && echo "result : OK" || echo "result : NG"
    done
}

function brand_remove_apps {
    APP_LIST=`adb shell pm list packages | grep $1`
	echo " Search result : "
	echo $APP_LIST

    for value in ${APP_LIST}
    do
        IFS=':' read -ra NAME_ARRAY <<< "$value"
        local PKG_NAME=${NAME_ARRAY[1]}
        local PKG=$(echo ${PKG_NAME} | tr -d '\n\r')
        echo " ... uninstalling ${PKG_NAME}"
		
		local TMP_RESULT=$(adb uninstall ${PKG} 2>/dev/null)
        echo $TMP_RESULT
        RESULT=$(echo $TMP_RESULT | grep -c 'Success')
	    [ "$RESULT" > 0 ] && echo "result : OK" || echo "result : NG"
		
		echo " ... disabling ${PKG_NAME}"
		# local TMP_RESULT=$(adb shell pm uninstall -k –user 0 ${PKG})
		# local TMP_RESULT=$(adb shell pm disable --user 0 ${PKG})
		local TMP_RESULT=$(adb shell pm disable-user ${PKG})
		 echo $TMP_RESULT
        RESULT=$(echo $TMP_RESULT | grep -c 'Success')
	    [ "$RESULT" > 0 ] && echo "result : OK" || echo "result : NG"
        echo "---------------------------------"
    done
}

function disable_apps_3P {
    disable_apps $FLAG_3RD_PARTY
}

function disable_apps_system {
    disable_apps $FLAG_SYSTEM
}


function cleanup_bloatware {
	KEYWORD_FILENAME=$1
	LINES=$(cat $KEYWORD_FILENAME)
	
	# for key in $LINES
	# do
		# echo " Bloatware searched keyword : ${key}"
		# brand_remove_apps $key
	# done
	
	brand_remove_apps google
	brand_remove_apps microsoft
	brand_remove_apps office
	brand_remove_apps anshin
	brand_remove_apps au
	brand_remove_apps yahoo
	brand_remove_apps facebook
	brand_remove_apps softbank
	brand_remove_apps messenger
	brand_remove_apps twitter
	brand_remove_apps tiktok
	brand_remove_apps aquos
	brand_remove_apps sharp
	
	uninstall_apps_3P
	disable_apps_3P
	# disable_apps_system
}