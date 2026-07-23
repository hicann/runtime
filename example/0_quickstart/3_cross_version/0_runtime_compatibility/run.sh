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
source "$(cd "${SCRIPT_DIR}/../../.." && pwd)/common/resolve_cann_env.sh" && resolve_cann_env

set -euo pipefail

cd "${SCRIPT_DIR}"

rm -rf build
cmake -B build \
    -DASCEND_CANN_PACKAGE_PATH="${ASCEND_INSTALL_PATH}"
cmake --build build -j

file_path=output_msg.txt
if ! ./build/main | tee "${file_path}"; then
    echo "[FAILURE] Runtime compatibility sample failed."
    exit 1
fi

if grep -q "\\[SUCCESS\\] Runtime compatibility sample completed successfully" "${file_path}"; then
    echo "[SUCCESS] Runtime compatibility sample executed successfully."
else
    echo "[FAILURE] Runtime compatibility sample did not print the expected success marker."
    exit 1
fi
