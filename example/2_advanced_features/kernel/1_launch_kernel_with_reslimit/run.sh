#!/bin/bash
# -----------------------------------------------------------------------------------------------------------
# Copyright (c) 2025 Huawei Technologies Co., Ltd.
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
    echo "[ERROR]: Failed to auto detect SOC_VERSION or ASCENDC_CMAKE_DIR. Please source ${EXAMPLE_DIR}/set_sample_env.sh manually."
    exit 1
fi

if [ -z "${ASCENDC_CMAKE_DIR:-}" ]; then
    echo "[ERROR]: ASCENDC_CMAKE_DIR is not set. Please export ASCENDC_CMAKE_DIR before building this sample."
    exit 1
fi

if [ -z "${SOC_VERSION:-}" ]; then
    echo "[ERROR]: SOC_VERSION is not set. Please export SOC_VERSION before building this sample."
    exit 1
fi

if [ ! -f "${ASCENDC_CMAKE_DIR}/ascendc.cmake" ]; then
    echo "[ERROR]: ${ASCENDC_CMAKE_DIR}/ascendc.cmake does not exist."
    exit 1
fi

echo "[INFO]: Current compile soc version is ${SOC_VERSION}"

cd "${SCRIPT_DIR}"

BUILD_DIR="${SCRIPT_DIR}/build"
mkdir -p "${BUILD_DIR}"

echo "Configuring CMake..."
cmake -B "${BUILD_DIR}" \
    -DASCEND_CANN_PACKAGE_PATH="${ASCEND_INSTALL_PATH}"

echo "Building..."
cmake --build "${BUILD_DIR}" -j"$(nproc)"

check_msg="Hello World"
file_path="${SCRIPT_DIR}/output_msg.txt"
"${BUILD_DIR}/main" | tee "${file_path}"
count=$(grep -c "${check_msg}" "${file_path}" || true)

if [ "${count}" -ne 8 ]; then
    echo "[FAILURE]: Expected 8 occurrences of ${check_msg}, but found ${count} occurrences."
    exit 1
else
    echo "[SUCCESS]: Launch kernels under resource limits successfully."
fi
