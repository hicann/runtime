#!/bin/bash
# -----------------------------------------------------------------------------------------------------------
# Copyright (c) 2025 Huawei Technologies Co., Ltd.
# This program is free software, you can redistribute it and/or modify it under the terms and conditions of
# CANN Open Software License Agreement Version 2.0 (the "License").
# Please refer to the License for details. You may not use this file except in compliance with the License.
# THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
# INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
# See LICENSE in the root of the software repository for the full text of the License.
# -----------------------------------------------------------------------------------------------------------

ide_log_file="/var/log/npu/ide_daemon/run/ide_monitor_log.txt"
installinfo="/lib/davinci.conf"
int=1
if [ -f "${installinfo}" ];then
    . $installinfo
    HIAI_DIR=$DAVINCI_HOME_PATH
fi

if [ -f "${installinfo}" ] && [ -d "${HIAI_DIR}" ];then
    process="${HIAI_DIR}/driver/tools/ada"
    DATE_FORMATE="+%F %T.%3N"
else
    process="/var/adda"
    DATE_FORMATE="+%F %T"
fi

date > $ide_log_file
if [ "$(ps -ef | grep -v grep | grep -c $process)" -ne 0 ];then
    echo "kill $process: $1" >> $ide_log_file
    kill -31 "$1"
    while(( $int<=15 ))
    do
        if [ "$(ps -ef | grep -v grep | grep -c $process)" -ne 0 ];then
            echo "wait to kill $process: $1" >> $ide_log_file
            sleep 1
        fi
        let "int++"
    done
fi
echo "raise $process " >> $ide_log_file
if [ -f "$process" ]; then
    if [ -f "${installinfo}" ] && [ -d "${HIAI_DIR}" ];then
        nohup nice -n 30 ${HIAI_DIR}/driver/tools/ada >/dev/null 2>&1 &
    else
        nice -n 30 /var/adda &
    fi
    int=1
    while(( $int<=5 ))
    do
        date "$DATE_FORMATE" >> $ide_log_file
        ps -ef | grep $process | grep -v grep >> $ide_log_file
        sleep 0.5
        let "int++"
    done
else
    echo "$process is not existed" >> $ide_log_file
fi
date "$DATE_FORMATE" >> $ide_log_file
ps -ef | grep $process | grep -v grep >> $ide_log_file
