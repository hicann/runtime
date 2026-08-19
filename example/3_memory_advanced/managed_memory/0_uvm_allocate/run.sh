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

cd "${SCRIPT_DIR}"

BUILD_TYPE="Debug"
INSTALL_PREFIX="${SCRIPT_DIR}/out"
RUN_MODE="simple"

export ASCEND_TOOLKIT_HOME="${ASCEND_INSTALL_PATH}"
export ASCEND_HOME_PATH="${ASCEND_INSTALL_PATH}"

BUILD_DIR="${SCRIPT_DIR}/build"
rm -rf "${BUILD_DIR}"
mkdir -p "${BUILD_DIR}"

echo "Configuring CMake..."
cmake -B "${BUILD_DIR}" \
    -DSOC_VERSION="${SOC_VERSION}" \
    -DCMAKE_BUILD_TYPE="${BUILD_TYPE}" \
    -DCMAKE_INSTALL_PREFIX="${INSTALL_PREFIX}" \
    -DASCEND_CANN_PACKAGE_PATH="${ASCEND_INSTALL_PATH}"

echo "Building..."
cmake --build "${BUILD_DIR}" -j"$(nproc)"
cmake --install "${BUILD_DIR}"

rm -rf input output
mkdir -p input output

if ! python3 -c "import numpy" &> /dev/null; then
    echo "[ERROR]: numpy is not installed. Please install numpy before running this sample."
    exit 1
fi

python3 scripts/gen_data.py

export LD_LIBRARY_PATH="${SCRIPT_DIR}/out/lib:${SCRIPT_DIR}/out/lib64:${ASCEND_INSTALL_PATH}/lib64:${LD_LIBRARY_PATH:-}"

SAMPLE_LOG="${SCRIPT_DIR}/output_msg.txt"
if ! "${SCRIPT_DIR}/out/bin/ascendc_kernels_bbit" "${RUN_MODE}" | tee "${SAMPLE_LOG}"; then
    echo "[FAILURE] Run the uvm_allocate sample failed."
    exit 1
fi

if grep -q '\[SKIP\]' "${SAMPLE_LOG}"; then
    echo "[SUCCESS] uvm_allocate sample skipped because the current SOC does not support UVM."
    exit 0
fi

md5sum output/*.bin
python3 scripts/verify_result.py output/output_z.bin output/golden.bin
