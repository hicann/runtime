#!/bin/bash
# -----------------------------------------------------------------------------------------------------------
# Copyright (c) 2026 Huawei Technologies Co., Ltd.
# This program is free software, you can redistribute it and/or modify it under the terms and conditions of
# CANN Open Software License Agreement Version 2.0 (the "License").
# Please refer to the License for details. You may not use this file except in compliance with the License.
# THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
# INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
# See LICENSE in the root of the software repository for the full text of the License.
# -----------------------------------------------------------------------------------------------------------

CURRENT_DIR=$(dirname $(readlink -f $0)) # 脚本目录

for dir in $(ls -d ${CURRENT_DIR}/*/); do
    if [ -f "${dir}/rollback_precheck.sh" ]; then
        "${dir}/rollback_precheck.sh"
        ret=$?
        if [ ${ret} -ne 0 ]; then
            echo "[All] [$(date +"%Y-%m-%d %H:%M:%S")] [ERROR]: ${dir}/rollback_precheck.sh fialed !"
            exit ${ret}
        fi
    fi
done

for dir in $(ls -d ${CURRENT_DIR}/*/); do
    if [ -f "${dir}/rollback.sh" ] && [ "$(stat -c %a "${dir}/rollback.sh")" = "500" ]; then
        "${dir}/rollback.sh"
        ret=$?
        if [ ${ret} -ne 0 ]; then
            echo "[All] [$(date +"%Y-%m-%d %H:%M:%S")] [ERROR]: ${dir}/rollback.sh failed !"
            exit ${ret}
        fi
    fi
done

"${CURRENT_DIR}/uninstall.sh"
ret=$?
if [ ${ret} -ne 0 ]; then
    echo "[All] [$(date +"%Y-%m-%d %H:%M:%S")] [WARNING]: ${CURRENT_DIR}/uninstall.sh failed !"
fi

echo "[All] [$(date +"%Y-%m-%d %H:%M:%S")] [INFO]: patch rolled back successfully !"
exit 0
