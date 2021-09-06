#!/bin/bash
FLAG_3RD_PARTY=-3
FLAG_SYSTEM=-s
# pm list packages | grep 
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

    for value in ${APP_LIST}
    do
        # read -ra NAME_ARRAY <<< "$value"
        IFS=':' read -ra NAME_ARRAY <<< "$value"
        local PKG_NAME=${NAME_ARRAY[1]}
        local PKG=$(echo ${PKG_NAME} | tr -d '\n\r')
        echo " ... uninstalling ${PKG_NAME}"

        # local RESULT=$(adb shell pm uninstall --user 0 ${PKG_NAME##*( )})
        # local RESULT=$(adb shell pm uninstall --user 0 ${PKG} | grep -c 'Success')
        local TMP_RESULT=$(adb uninstall ${PKG} 2>/dev/null)
        # local RESULT=$(adb shell pm uninstall --user 0 ${NAME_ARRAY[1]}  2>/dev/null | grep -c 'Error')
	    # [ "$RESULT" > 0 ] && label_body "result : OK" || label_body "result : NG"
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


function enable_apps {
    # adb shell pm list packages $1 >> packages.txt
    # exit
    APP_LIST=`adb shell pm list packages $1`
    # mapfile -t APP_LIST < packages.txt

    # while IFS= read -r line;
    # do 
    #     # echo ">>$line<<";
    #     IFS=':' read -ra NAME_ARRAY <<< "$line"
    #     local PKG_NAME=${NAME_ARRAY[1]}
    #     local PKG=$(echo ${PKG_NAME} | tr -d '\n\r')
    #     local RESULT=$(adb shell pm disable ${PKG} | grep -c 'Error')
	#     # [ "$RESULT" > 0 ] && echo "result : NG" || echo "result : OK"

    # done < packages.txt
    # exit

    for value in ${APP_LIST}
    do
        # read -ra NAME_ARRAY <<< "$value"
        echo $value

        IFS=':' read -ra NAME_ARRAY <<< "$value"
        local PKG_NAME=${NAME_ARRAY[1]}
        local PKG=$(echo ${PKG_NAME} | tr -d '\n\r')
        # echo $PKG_NAME

        echo " ... disabling ${PKG}"
        # local RESULT=`adb shell pm disable-user ${PKG_NAME}`
        local TMP_RESULT=$(adb shell pm enable --user 0 ${PKG})
        echo $TMP_RESULT
        RESULT=$(echo $TMP_RESULT | grep -c 'Success')
	    # [ "$RESULT" > 0 ] && label_body "result : OK" || label_body "result : NG"
	    [ "$RESULT" > 0 ] && echo "result : OK" || echo "result : NG"
    done
}


function disable_apps {
    # adb shell pm list packages $1 >> packages.txt
    # exit
    APP_LIST=`adb shell pm list packages $1`
    # mapfile -t APP_LIST < packages.txt

    # while IFS= read -r line;
    # do 
    #     # echo ">>$line<<";
    #     IFS=':' read -ra NAME_ARRAY <<< "$line"
    #     local PKG_NAME=${NAME_ARRAY[1]}
    #     local PKG=$(echo ${PKG_NAME} | tr -d '\n\r')
    #     local RESULT=$(adb shell pm disable ${PKG} | grep -c 'Error')
	#     # [ "$RESULT" > 0 ] && echo "result : NG" || echo "result : OK"

    # done < packages.txt
    # exit

    for value in ${APP_LIST}
    do
        # read -ra NAME_ARRAY <<< "$value"
        echo $value

        IFS=':' read -ra NAME_ARRAY <<< "$value"
        local PKG_NAME=${NAME_ARRAY[1]}
        local PKG=$(echo ${PKG_NAME} | tr -d '\n\r')
        # echo $PKG_NAME

        echo " ... disabling ${PKG}"
        # local RESULT=`adb shell pm disable-user ${PKG_NAME}`
        local TMP_RESULT=$(adb shell pm disable-user ${PKG})
        echo $TMP_RESULT
        RESULT=$(echo $TMP_RESULT | grep -c 'Success')
	    # [ "$RESULT" > 0 ] && label_body "result : OK" || label_body "result : NG"
	    [ "$RESULT" > 0 ] && echo "result : OK" || echo "result : NG"
    done
}

function brand_remove_apps {
    # APP_LIST=`adb shell pm list packages | grep samsung`
    # APP_LIST=`adb shell pm list packages | grep docomo`
    APP_LIST=`adb shell pm list packages | grep $1`

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

function enable_apps_system {
    enable_apps $FLAG_SYSTEM
}


# disable_apps_3P
## disable_apps_system
## uninstall_apps_3P
# uninstall_apps_system

# brand_remove_apps docomo
# brand_remove_apps samsung
brand_remove_apps google
# disable_apps_3P
# uninstall_apps_3P


