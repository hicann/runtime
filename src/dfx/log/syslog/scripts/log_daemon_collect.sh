#!/bin/bash
# This script collect device log to target directory
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
FOLDER_PATH="/var/log/ide_daemon/message"
INPUT_MODE=$1
INPUT_NUM=$2

if grep -qE '^[[:digit:]]+$' <<< "${INPUT_MODE}" && grep -qE '^[[:digit:]]+$' <<< "${INPUT_NUM}"; then
    if [[ ${INPUT_MODE} -eq 1 ]]; then
        # only get first two digits to avoid numbers over range
        TARGET_DIR=${INPUT_NUM:0:2}
        if [[ ${TARGET_DIR} -le 32 ]]; then
            mkdir -p "${FOLDER_PATH}/${TARGET_DIR}"
            chown -RPf root:root "${FOLDER_PATH}/${TARGET_DIR}"
            chmod 755 "${FOLDER_PATH}"
            chmod 755 "${FOLDER_PATH}/${TARGET_DIR}"
            if cp /var/log/messages "${FOLDER_PATH}/${TARGET_DIR}"; then
                chmod 644 "${FOLDER_PATH}/${TARGET_DIR}/messages"
            fi
            if cp /var/log/messages.0 "${FOLDER_PATH}/${TARGET_DIR}"; then
                chmod 644 "${FOLDER_PATH}/${TARGET_DIR}/messages.0"
            fi
        fi
    elif [[ ${INPUT_MODE} -eq 2 ]]; then
        rm -rf "${FOLDER_PATH}/${INPUT_NUM}"
    else
        exit 1
    fi
else
    exit 1
fi