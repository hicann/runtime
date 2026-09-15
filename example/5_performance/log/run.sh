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

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "${SCRIPT_DIR}/../../common/resolve_cann_env.sh"
resolve_cann_env

cd "${SCRIPT_DIR}"
rm -rf build
cmake -B build -DASCEND_CANN_PACKAGE_PATH="${ASCEND_INSTALL_PATH}"
cmake --build build -j"$(nproc)"

output_file="output_msg.txt"
if ./build/0_acl_log/acl_log_sample | tee "${output_file}"; then
    if grep -q "\[SUCCESS\] ACL log sample completed successfully." "${output_file}"; then
        echo "[SUCCESS] ACL log sample executed successfully."
    else
        echo "[FAILURE] ACL log sample did not print the expected success marker."
        exit 1
    fi
else
    echo "[FAILURE] ACL log sample failed."
    exit 1
fi
