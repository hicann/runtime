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

# shellcheck source=/dev/null
source "${EXAMPLE_DIR}/common/resolve_cann_env.sh"
resolve_cann_env

if [[ -z "${SOC_VERSION:-}" || -z "${ASCENDC_CMAKE_DIR:-}" ]]; then
    if [[ ! -f "${EXAMPLE_DIR}/set_sample_env.sh" ]]; then
        echo "[ERROR]: ${EXAMPLE_DIR}/set_sample_env.sh does not exist."
        exit 1
    fi
    # shellcheck source=/dev/null
    source "${EXAMPLE_DIR}/set_sample_env.sh"
fi

if [[ -z "${SOC_VERSION:-}" ]]; then
    echo "[ERROR]: SOC_VERSION is not set. Please export SOC_VERSION before building this sample."
    exit 1
fi

if [[ -z "${ASCENDC_CMAKE_DIR:-}" ]]; then
    echo "[ERROR]: ASCENDC_CMAKE_DIR is not set. Please export ASCENDC_CMAKE_DIR before building this sample."
    exit 1
fi

if [[ ! -f "${ASCENDC_CMAKE_DIR}/ascendc.cmake" ]]; then
    echo "[ERROR]: ${ASCENDC_CMAKE_DIR}/ascendc.cmake does not exist."
    exit 1
fi

echo "[INFO]: Current compile soc version is ${SOC_VERSION}"

cd "${SCRIPT_DIR}"
BUILD_DIR="${SCRIPT_DIR}/build"
rm -rf "${BUILD_DIR}"

echo "Configuring CMake..."
cmake -B "${BUILD_DIR}" \
    -DASCEND_CANN_PACKAGE_PATH="${ASCEND_INSTALL_PATH}"

echo "Building..."
cmake --build "${BUILD_DIR}" -j"$(nproc)"

OUTPUT_FILE="${SCRIPT_DIR}/output_msg.txt"
"${BUILD_DIR}/main" | tee "${OUTPUT_FILE}"

if grep -q "\[SUCCESS\] Event wait diagnostics sample completed successfully" "${OUTPUT_FILE}"; then
    echo "[SUCCESS] Event wait diagnostics sample executed successfully."
else
    echo "[FAILURE] Event wait diagnostics sample did not print the expected success marker."
    exit 1
fi
