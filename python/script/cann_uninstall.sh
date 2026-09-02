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

SHELL_DIR="$(dirname "${BASH_SOURCE:-$0}")"
INSTALL_PATH="$(cd "${SHELL_DIR}" && pwd)"
TOTAL_RET="0"

uninstall_package() {
    local path="$1"
    local ret

    cd "${INSTALL_PATH}/${path}"
    ./uninstall.sh
    ret="$?" && [ ${ret} -ne 0 ] && TOTAL_RET="1"
    return ${ret}
}

if [ ! "$*" = "" ]; then
    cur_date=$(date +"%Y-%m-%d %H:%M:%S")
    echo "[$cur_date] [ERROR]: $*, parameter is not supported."
    exit 1
fi

exit ${TOTAL_RET}
