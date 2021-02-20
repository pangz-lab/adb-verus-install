#!/bin/bash
TERM_DIR=/data/data/com.termux/files
DOWNLOAD_FOLDER=$TERM_DIR/home/storage/downloads
EXPORT_FILE=$DOWNLOAD_FOLDER/termbk-temp.tar.gz
ALLOWED_OPERATION=( export_environment init_environment )
OPE_INDEX=1

main() {
    echo ""
    printf " [ Select Operation ]\n"
    for OPE in ${ALLOWED_OPERATION[@]}; do
        echo " " $OPE_INDEX. $OPE
	((OPE_INDEX++))
    done
    
    while read -p " [ Run # ] : " -n1 input
    do
	[ -z $input ] && echo " >> error: select an operation" && continue
	[ -z ${ALLOWED_OPERATION[$input-1]} ] && echo " >> error: unknown operation" && continue

	read -p " Proceed (y) : " -n1 proceed
	if [ -z $proceed ] || [ $proceed = "y" ];
	then
	    echo " >> Proceed "
	    echo " ============================= "
	    ${ALLOWED_OPERATION[$input-1]}
	    echo " ============================= "
    	else
	    echo " >> Cancelled "
	fi
    done
}

export_environment() {
    echo " Starting export..."
    cd $TERM_DIR
    tar -zcvf $EXPORT_FILE home usr
    echo " Export Finished!"
}

init_environment() {
    echo " Starting init setup script.."
    cp $DOWNLOAD_FOLDER/term_bash_setup.sh $TERM_DIR/home/.bash_profile
    cp $DOWNLOAD_FOLDER/term_miner.sh $TERM_DIR/home/ccminer/miner.sh
    chmod +x $TERM_DIR/home/ccminer/miner.sh

    echo " Init Script Finished!"
}

#export_backup

#setup_init_scripts
main
