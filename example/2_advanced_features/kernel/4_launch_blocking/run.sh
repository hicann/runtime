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
BUILD_DIR="${SCRIPT_DIR}/build"
OUTPUT_DIR="${SCRIPT_DIR}/out"

source "${EXAMPLE_DIR}/common/resolve_cann_env.sh"

detect_sample_env() {
    if [ -n "${SOC_VERSION:-}" ] && [ -n "${ASCENDC_CMAKE_DIR:-}" ]; then
        return 0
    fi
    if [ ! -f "${EXAMPLE_DIR}/set_sample_env.sh" ]; then
        return 0
    fi

    set +eu
    source "${EXAMPLE_DIR}/set_sample_env.sh"
    local ret=$?
    set -euo pipefail
    return "${ret}"
}

resolve_cann_env

if ! detect_sample_env; then
    echo "[ERROR] Failed to detect SOC_VERSION or ASCENDC_CMAKE_DIR. Source ${EXAMPLE_DIR}/set_sample_env.sh first."
    exit 1
fi
if [ -z "${ASCENDC_CMAKE_DIR:-}" ] || [ ! -f "${ASCENDC_CMAKE_DIR}/ascendc.cmake" ]; then
    echo "[ERROR] ASCENDC_CMAKE_DIR is invalid."
    exit 1
fi
if [ -z "${SOC_VERSION:-}" ]; then
    echo "[ERROR] SOC_VERSION is not set."
    exit 1
fi

cd "${SCRIPT_DIR}"
export ASCEND_TOOLKIT_HOME="${ASCEND_INSTALL_PATH}"
export ASCEND_HOME_PATH="${ASCEND_INSTALL_PATH}"

rm -rf "${BUILD_DIR}" "${OUTPUT_DIR}"

cmake -S "${SCRIPT_DIR}" -B "${BUILD_DIR}" \
    -DSOC_VERSION="${SOC_VERSION}" \
    -DCMAKE_BUILD_TYPE=Debug \
    -DCMAKE_INSTALL_PREFIX="${OUTPUT_DIR}" \
    -DASCEND_CANN_PACKAGE_PATH="${ASCEND_INSTALL_PATH}"
cmake --build "${BUILD_DIR}" -j"$(nproc)"
cmake --install "${BUILD_DIR}"

export LD_LIBRARY_PATH="${OUTPUT_DIR}/lib:${OUTPUT_DIR}/lib64:${ASCEND_INSTALL_PATH}/lib64:${LD_LIBRARY_PATH:-}"

run_case() {
    local env_value=$1
    local scenario=$2
    echo "========== ASCEND_RT_LAUNCH_BLOCKING=${env_value}, scenario=${scenario} =========="
    env ASCEND_RT_LAUNCH_BLOCKING="${env_value}" "${OUTPUT_DIR}/bin/launch_blocking" "${scenario}"
}

run_case 0 env-control
run_case 1 env-control
run_case 0 stream-mode
run_case 1 stream-mode
run_case 1 non-blocking-section

echo "All launch blocking scenarios passed."
