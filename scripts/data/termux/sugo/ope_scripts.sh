#!/bin/bash
TERMUX_IMPORT_PATH="/data/data/com.termux/files"
rename_miner() {
    echo "ope_lib.sh inside guys $1"
}

initial_setup() {
    local backup_path=$1
    [ ! -f "$backup_path" ] && "Initial setup cannot start. Backup file does not exist" && return
    cd $TERMUX_IMPORT_PATH
    tar -zxf $backup_path --recursive-unlink --preserve-permission
    echo "Setup Successful"
}
