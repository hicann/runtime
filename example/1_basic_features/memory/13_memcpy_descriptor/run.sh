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
EXAMPLE_DIR="$(cd "${SCRIPT_DIR}/../../.." && pwd)"

source "${EXAMPLE_DIR}/common/resolve_cann_env.sh"
resolve_cann_env

cd "${SCRIPT_DIR}"

BUILD_DIR="${SCRIPT_DIR}/build"
rm -rf "${BUILD_DIR}"

echo "Configuring CMake..."
cmake -B "${BUILD_DIR}" \
    -DASCEND_CANN_PACKAGE_PATH="${ASCEND_INSTALL_PATH}"

echo "Building..."
cmake --build "${BUILD_DIR}" -j"$(nproc)"

SAMPLE_LOG="$(mktemp)"
trap 'rm -f "${SAMPLE_LOG}"' EXIT
if ! "${BUILD_DIR}/main" | tee "${SAMPLE_LOG}"; then
    echo "[FAILURE] Memcpy descriptor sample failed."
    exit 1
fi

if grep -q '\[SUCCESS\] Memcpy descriptor sample completed successfully' "${SAMPLE_LOG}"; then
    echo "[SUCCESS] Memcpy descriptor sample executed successfully."
else
    echo "[FAILURE] Memcpy descriptor sample did not print the expected success marker."
    exit 1
fi
