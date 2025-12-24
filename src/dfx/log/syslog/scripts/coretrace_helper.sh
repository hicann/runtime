#!/bin/bash
# This script collect coretrace files to target directory
# -----------------------------------------------------------------------------------------------------------
# Copyright (c) 2025 Huawei Technologies Co., Ltd.
# This program is free software, you can redistribute it and/or modify it under the terms and conditions of
# CANN Open Software License Agreement Version 2.0 (the "License").
# Please refer to the License for details. You may not use this file except in compliance with the License.
# THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
# INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
# See LICENSE in the root of the software repository for the full text of the License.
# -----------------------------------------------------------------------------------------------------------

set -e
# parameter list: $1：process name, $2: timestamp, $3: singal, $4: process id, $5: group id
if [ "$#" -ne 5 ]; then
    exit 1
fi
for arg in "$@"; do
    if [[ $arg =~ [\;\'\"\`\$] ]]; then
        exit 1
    fi
done

CORETRACE_PATH="/var/log/coretrace"
if [ ! -d "$CORETRACE_PATH" ]; then
    /usr/sbin/mkdir $CORETRACE_PATH
    /usr/bin/chmod 755 $CORETRACE_PATH
fi
if [ ! -d "$CORETRACE_PATH" ]; then
    exit 1
fi

GROUP_ID=$5
if [ -z "$GROUP_ID" ]; then
    exit 1
fi
GROUP_NAME=$(grep ^.*:x:$GROUP_ID: /etc/group | cut -d : -f 1)
if [ -z "$GROUP_NAME" ]; then
    exit 1
fi

GROUP_TYPE=0
if [ "$GROUP_NAME" = "HwHiAiUser" ]; then
    GROUP_TYPE=1
fi
if [ "$GROUP_TYPE" = 0 ]; then
    FILE_NUM=$(/usr/bin/ls $CORETRACE_PATH | /usr/sbin/wc -l)
    while [ $FILE_NUM -ge 5 ]; do
        FILE=$(find $CORETRACE_PATH -maxdepth 1 -type f -printf '%T@ %p \0' | sort -n -z | cut -d ' ' -f2 | tr -d '\0')
        if [ -f "$FILE" ]; then
            /usr/bin/rm -f "$FILE"
        fi
        if [ -f "$FILE" ]; then
            exit 1
        fi
        FILE_NUM=$(/usr/bin/ls $CORETRACE_PATH | /usr/sbin/wc -l)
    done
    cat <&0 > $CORETRACE_PATH/coretrace.$1.$4.$3.$2
    if [ ! -f "$CORETRACE_PATH/coretrace.$1.$4.$3.$2" ]; then
        exit 1
    fi
    /usr/bin/chmod 440 $CORETRACE_PATH/coretrace.$1.$4.$3.$2
    exit 0
fi

COREDUMP_PATH="/var/log/npu/coredump"
if [ ! -d "$COREDUMP_PATH" ]; then
    exit 1
fi
FILE_NUM=$(/usr/bin/ls $COREDUMP_PATH | /usr/sbin/wc -l)
AGING_NUM=0
# prevent continuous file creation in COREDUMP_PATH, limit the upper limit of each aging file
while [ $FILE_NUM -ge 20 ] && [ $AGING_NUM -le 25 ]; do
    FILE=$(find $COREDUMP_PATH -maxdepth 1 -type f -printf '%T@ %p \0' | sort -n -z | cut -d ' ' -f2 | tr -d '\0')
    if [ -f "$FILE" ]; then
        su - HwHiAiUser -c "/usr/bin/rm -f "$FILE""
    fi
    if [ -f "$FILE" ]; then
        exit 1
    fi
    FILE_NUM=$(/usr/bin/ls $COREDUMP_PATH | /usr/sbin/wc -l)
    ((AGING_NUM+=1))
done
cat <&0 > $CORETRACE_PATH/coretrace.$1.$4.$3.$2
if [ ! -f "$CORETRACE_PATH/coretrace.$1.$4.$3.$2" ]; then
    exit 1
fi
# prevent COREDUMP_PATH is soft link, using user HwHiAiUser to move file
/usr/bin/chmod 444 $CORETRACE_PATH/coretrace.$1.$4.$3.$2
su - HwHiAiUser -c "cat $CORETRACE_PATH/coretrace.$1.$4.$3.$2 > $COREDUMP_PATH/coretrace.$1.$4.$3.$2"
su - HwHiAiUser -c "/usr/bin/chmod 440 $COREDUMP_PATH/coretrace.$1.$4.$3.$2"
/usr/bin/rm -f $CORETRACE_PATH/coretrace.$1.$4.$3.$2
if [ ! -f "$COREDUMP_PATH/coretrace.$1.$4.$3.$2" ]; then
    exit 1
fi
exit 0