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
SPC_DIR="$(dirname "${CURRENT_DIR}")"
INSTALL_DIR="$(dirname "${SPC_DIR}")"

# 目录非空或无权限访问返回2
is_dir_empty() {
    [ ! -d "$1" ] && return 1
    [ "$(ls -A "$1" 2>&1)" != "" ] && return 2
    return 0
}

# 删除空目录
remove_dir_if_empty() {
    local dirpath="$1"
    is_dir_empty "${dirpath}"
    if [ $? -eq 0 ]; then
        rm -rf "${dirpath}"
    fi
    return 0
}

for dir in $(ls -d ${CURRENT_DIR}/*/); do
    if [ -f "${dir}/uninstall.sh" ]; then
        "${dir}/uninstall.sh"
        ret=$?
        if [ ${ret} -ne 0 ]; then
            echo "[All] [$(date +"%Y-%m-%d %H:%M:%S")] [ERROR]: ${dir}/uninstall.sh failed !"
            exit ${ret}
        fi
    fi
done

rm -rf "${CURRENT_DIR}/rollback.sh"

rm -rf "${CURRENT_DIR}/uninstall.sh"

# 清理当前空目录
remove_dir_if_empty "${CURRENT_DIR}"

# 清理spc安装目录
remove_dir_if_empty "${SPC_DIR}"

# 清理安装根目录
remove_dir_if_empty "${INSTALL_DIR}"

echo "[All] [$(date +"%Y-%m-%d %H:%M:%S")] [INFO]: patch uninstalled successfully !"
exit 0
