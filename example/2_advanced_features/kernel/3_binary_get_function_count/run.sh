#!/usr/bin/env bash
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

# set_sample_env.sh resolves the CANN path and exports ASCEND_INSTALL_PATH,
# ASCEND_HOME_PATH, SOC_VERSION and ASCENDC_CMAKE_DIR automatically.
if [[ -z "${ASCEND_INSTALL_PATH:-${ASCEND_HOME_PATH:-}}" || -z "${SOC_VERSION:-}" || -z "${ASCENDC_CMAKE_DIR:-}" ]]; then
    if [[ ! -f "${EXAMPLE_DIR}/set_sample_env.sh" ]]; then
        echo "[ERROR]: Source the CANN set_env.sh or export ASCEND_INSTALL_PATH=<cann_path>."
        exit 1
    fi
    set +eu
    source "${EXAMPLE_DIR}/set_sample_env.sh"
    ret=$?
    set -euo pipefail
    if [[ "${ret}" -ne 0 ]]; then
        echo "[ERROR]: Failed to auto detect the sample environment. Please source ${EXAMPLE_DIR}/set_sample_env.sh manually."
        exit 1
    fi
fi

ASCEND_INSTALL_PATH="${ASCEND_INSTALL_PATH:-${ASCEND_HOME_PATH}}"
export ASCEND_HOME_PATH="${ASCEND_HOME_PATH:-${ASCEND_INSTALL_PATH}}"

case "$(uname -m)" in
    aarch64|arm64)
        CANN_ARCH_DIR="aarch64-linux"
        ;;
    x86_64|amd64)
        CANN_ARCH_DIR="x86_64-linux"
        ;;
    *)
        echo "[ERROR] Unsupported host architecture: $(uname -m)"
        exit 1
        ;;
esac

if [[ -z "${ASCENDC_CMAKE_DIR:-}" ]]; then
    ASCENDC_CANDIDATES=(
        "${ASCEND_INSTALL_PATH}/${CANN_ARCH_DIR}/tikcpp/ascendc_kernel_cmake"
        "${ASCEND_INSTALL_PATH}/tikcpp/ascendc_kernel_cmake"
    )
    for candidate in "${ASCENDC_CANDIDATES[@]}"; do
        if [[ -f "${candidate}/ascendc.cmake" ]]; then
            export ASCENDC_CMAKE_DIR="${candidate}"
            break
        fi
    done
fi

if [[ ! -f "${ASCENDC_CMAKE_DIR:-}/ascendc.cmake" ]]; then
    echo "[ERROR] ascendc.cmake was not found; install or source the CANN Toolkit first."
    exit 1
fi

if [[ -z "${SOC_VERSION:-}" ]]; then
    echo "[ERROR] SOC_VERSION is not set, for example:"
    echo "        SOC_VERSION=Ascend910B1 bash run.sh"
    exit 1
fi

rm -rf "${BUILD_DIR}" "${OUTPUT_DIR}"

echo "[INFO] ASCEND_HOME_PATH=${ASCEND_HOME_PATH}"
echo "[INFO] ASCENDC_CMAKE_DIR=${ASCENDC_CMAKE_DIR}"
echo "[INFO] SOC_VERSION=${SOC_VERSION}"

cmake -S "${SCRIPT_DIR}" -B "${BUILD_DIR}" \
    -DCMAKE_BUILD_TYPE=Debug \
    -DCMAKE_INSTALL_PREFIX="${OUTPUT_DIR}" \
    -DASCEND_CANN_PACKAGE_PATH="${ASCEND_INSTALL_PATH}" \
    -DASCENDC_CMAKE_DIR="${ASCENDC_CMAKE_DIR}" \
    -DSOC_VERSION="${SOC_VERSION}"

cmake --build "${BUILD_DIR}" -j"$(nproc)"
cmake --install "${BUILD_DIR}"

KERNEL_BINARY="${OUTPUT_DIR}/fatbin/custom_kernels/custom_kernels.o"
HOST_BINARY="${OUTPUT_DIR}/bin/binary_get_function_count"

if [[ ! -f "${KERNEL_BINARY}" ]]; then
    echo "[ERROR] Kernel binary was not generated: ${KERNEL_BINARY}"
    exit 1
fi

if [[ ! -x "${HOST_BINARY}" ]]; then
    echo "[ERROR] Host executable was not generated: ${HOST_BINARY}"
    exit 1
fi

export LD_LIBRARY_PATH="${ASCEND_INSTALL_PATH}/runtime/lib64:"\
"${ASCEND_INSTALL_PATH}/lib64:"\
"${ASCEND_INSTALL_PATH}/${CANN_ARCH_DIR}/lib64:"\
"${LD_LIBRARY_PATH:-}"

"${HOST_BINARY}" "${KERNEL_BINARY}"
