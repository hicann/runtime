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

# 1. Resolve the CANN environment: prefer preset variables, otherwise auto-detect.
env_script="${EXAMPLE_DIR}/common/resolve_cann_env.sh"
if [[ -n "${ASCEND_INSTALL_PATH:-${ASCEND_HOME_PATH:-}}" ]]; then
    export ASCEND_INSTALL_PATH="${ASCEND_INSTALL_PATH:-${ASCEND_HOME_PATH}}"
    export ASCEND_HOME_PATH="${ASCEND_HOME_PATH:-${ASCEND_INSTALL_PATH}}"
elif [[ -f "${env_script}" ]]; then
    source "${env_script}"
    resolve_cann_env
else
    echo "[ERROR]: Source the CANN set_env.sh or export ASCEND_INSTALL_PATH=<cann_path>."
    exit 1
fi

# 2. Auto-detect SOC_VERSION and ASCENDC_CMAKE_DIR when they are not preset.
if [[ -z "${SOC_VERSION:-}" || -z "${ASCENDC_CMAKE_DIR:-}" ]]; then
    if ! source "${EXAMPLE_DIR}/set_sample_env.sh"; then
        echo "[ERROR] Failed to auto detect SOC_VERSION/ASCENDC_CMAKE_DIR."
        echo "        Please export SOC_VERSION (e.g. SOC_VERSION=Ascend910B1) and ASCENDC_CMAKE_DIR."
        exit 1
    fi
fi

# 3. Build the device kernels and the host executable. CMakeLists.txt reads
#    SOC_VERSION / ASCENDC_CMAKE_DIR / ASCEND_HOME_PATH from the environment.
cmake -S "${SCRIPT_DIR}" -B "${BUILD_DIR}"
cmake --build "${BUILD_DIR}" -j"$(nproc)"
cmake --install "${BUILD_DIR}"

# 4. Run the sample.
KERNEL_BINARY="${OUTPUT_DIR}/fatbin/custom_kernels/custom_kernels.o"
HOST_BINARY="${OUTPUT_DIR}/bin/binary_enumerate_functions"

[[ -f "${KERNEL_BINARY}" ]] || { echo "[ERROR] Kernel binary was not generated: ${KERNEL_BINARY}"; exit 1; }
[[ -x "${HOST_BINARY}" ]] || { echo "[ERROR] Host executable was not generated: ${HOST_BINARY}"; exit 1; }

case "$(uname -m)" in
    aarch64|arm64) arch_dir="aarch64-linux" ;;
    *)             arch_dir="x86_64-linux" ;;
esac
export LD_LIBRARY_PATH="${ASCEND_INSTALL_PATH}/runtime/lib64:${ASCEND_INSTALL_PATH}/lib64:${ASCEND_INSTALL_PATH}/${arch_dir}/lib64:${LD_LIBRARY_PATH:-}"

"${HOST_BINARY}" "${KERNEL_BINARY}"
