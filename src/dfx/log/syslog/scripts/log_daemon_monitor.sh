#!/bin/bash
# This script restart log-daemon process by appmond ###
# -----------------------------------------------------------------------------------------------------------
# Copyright (c) 2025 Huawei Technologies Co., Ltd.
# This program is free software, you can redistribute it and/or modify it under the terms and conditions of
# CANN Open Software License Agreement Version 2.0 (the "License").
# Please refer to the License for details. You may not use this file except in compliance with the License.
# THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
# INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
# See LICENSE in the root of the software repository for the full text of the License.
# -----------------------------------------------------------------------------------------------------------

LOG_FILE="/usr/slog/log_monitor_log.txt"
INSTALL_FILE="/etc/ascend_install.info"
int=1

date > $LOG_FILE
if grep '^[[:digit:]]*$' <<< "$1";then
    echo "Process ID of the input parameter: $1" >> $LOG_FILE
else
    echo "Invalid input parameter: $1, effective value should be Process Number" >> $LOG_FILE
    exit 1
fi

PROCESS="/var/log-daemon"
DATE_FORMATE="+%F %T"

## Determine if the log-daemon process exists or not
## if  process exists, kill it
if [ $(ps -ef | grep -v grep | grep -c "${PROCESS}$") -ne 0 ];then
    echo "kill $PROCESS: $1" >> $LOG_FILE
    kill -31 "$1"
    while(( $int<=10 ))
    do
        if [ $(ps -ef | grep -v grep | grep -c "${PROCESS}$") -ne 0 ];then
            echo "wait to kill $PROCESS: $1" >> $LOG_FILE
            sleep 1
        fi
        let "int++"
    done
fi

## restart log-daemon process
echo "raise $PROCESS " >> $LOG_FILE
if [ -f "$PROCESS" ]; then
    BBOX_MONITOR_SH="${HIAI_DIR}/driver/tools/bbox_daemon_monitor.sh"
    if [ -f "${BBOX_MONITOR_SH}" ]; then
        . "${BBOX_MONITOR_SH}"
        recover_bbox_conf "${HIAI_DIR}" $LOG_FILE >> $LOG_FILE 2>&1
    fi
    nice -n 20 /var/log-daemon &
    int=1
    while(( $int<=5 ))
    do
        date "$DATE_FORMATE" >> $LOG_FILE
        ps -ef | grep "${PROCESS}$" | grep -v grep >> $LOG_FILE
        sleep 0.5
        let "int++"
    done
else
    echo "$PROCESS is not existed" >> $LOG_FILE
fi
date "$DATE_FORMATE" >> $LOG_FILE
ps -ef | grep "${PROCESS}$" | grep -v grep >> $LOG_FILE
