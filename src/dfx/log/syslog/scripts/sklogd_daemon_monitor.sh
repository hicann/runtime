#!/bin/bash
# This script restart sklogd process by appmond.
# -----------------------------------------------------------------------------------------------------------
# Copyright (c) 2025 Huawei Technologies Co., Ltd.
# This program is free software, you can redistribute it and/or modify it under the terms and conditions of
# CANN Open Software License Agreement Version 2.0 (the "License").
# Please refer to the License for details. You may not use this file except in compliance with the License.
# THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
# INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
# See LICENSE in the root of the software repository for the full text of the License.
# -----------------------------------------------------------------------------------------------------------

LOG_FILE="/usr/slog/sklogd_monitor_log.txt"
INSTALL_FILE="/etc/ascend_install.info"
int=1

date > $LOG_FILE

PID_VAR=$(echo "$1" | tr -cd '[0-9]')
if [ $1 -eq $PID_VAR ];then
    echo "Process ID of the input parameter: $PID_VAR" >> $LOG_FILE
else
    echo "Invalid input parameter: $PID_VAR, effective value should be Process Number" >> $LOG_FILE
    exit 1
fi

PROCESS="/var/sklogd"
DATE_FORMATE="+%F %T"

## Determine if the sklogd process exists or not
## if  process exists, kill it
if [ $(ps -ef | grep -v grep | grep -c $PROCESS$) -ne 0 ];then
    echo "kill $PROCESS: $PID_VAR" >> $LOG_FILE
    kill -31 "$PID_VAR"
    while(( $int<=10 ))
    do
        if [ $(ps -ef | grep -v grep | grep -c $PROCESS$) -ne 0 ];then
            echo "wait to kill $PROCESS: $PID_VAR" >> $LOG_FILE
            sleep 1
        fi
        let "int++"
    done
fi

## restart sklogd process
echo "raise $PROCESS " >> $LOG_FILE
if [ -f "$PROCESS" ]; then
    nice -n 20 /var/sklogd &
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
