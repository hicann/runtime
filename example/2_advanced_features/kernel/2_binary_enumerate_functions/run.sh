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

die() { echo "[ERROR] $*" >&2; exit 1; }

# 1. Resolve the CANN environment: prefer preset variables, otherwise auto-detect.
if [[ -z "${ASCEND_INSTALL_PATH:-${ASCEND_HOME_PATH:-}}" ]]; then
    env_script="${EXAMPLE_DIR}/common/resolve_cann_env.sh"
    [[ -f "${env_script}" ]] || die "Source the CANN set_env.sh or export ASCEND_INSTALL_PATH=<cann_path>."
    source "${env_script}"
    resolve_cann_env
fi
export ASCEND_INSTALL_PATH="${ASCEND_INSTALL_PATH:-${ASCEND_HOME_PATH}}"
export ASCEND_HOME_PATH="${ASCEND_HOME_PATH:-${ASCEND_INSTALL_PATH}}"

# 2. Auto-detect SOC_VERSION and ASCENDC_CMAKE_DIR when they are not preset.
if [[ -z "${SOC_VERSION:-}" || -z "${ASCENDC_CMAKE_DIR:-}" ]]; then
    source "${EXAMPLE_DIR}/set_sample_env.sh" || die "Failed to auto detect SOC_VERSION/ASCENDC_CMAKE_DIR.
        Please export SOC_VERSION (e.g. SOC_VERSION=Ascend910B1) and ASCENDC_CMAKE_DIR."
fi
[[ -f "${ASCENDC_CMAKE_DIR:-}/ascendc.cmake" ]] || \
    die "ascendc.cmake was not found; install or source the CANN Toolkit first."

echo "[INFO] ASCEND_HOME_PATH=${ASCEND_HOME_PATH}"
echo "[INFO] SOC_VERSION=${SOC_VERSION}"
echo "[INFO] ASCENDC_CMAKE_DIR=${ASCENDC_CMAKE_DIR}"

# 3. Clean previous build/install artifacts so repeated runs always start
rm -rf "${BUILD_DIR}" "${OUTPUT_DIR}"
cmake -S "${SCRIPT_DIR}" -B "${BUILD_DIR}"
cmake --build "${BUILD_DIR}" -j"$(nproc)"
cmake --install "${BUILD_DIR}"

# 4. Run the sample.
KERNEL_BINARY="${OUTPUT_DIR}/fatbin/custom_kernels/custom_kernels.o"
HOST_BINARY="${OUTPUT_DIR}/bin/binary_enumerate_functions"
[[ -f "${KERNEL_BINARY}" ]] || die "Kernel binary was not generated: ${KERNEL_BINARY}"
[[ -x "${HOST_BINARY}" ]] || die "Host executable was not generated: ${HOST_BINARY}"

case "$(uname -m)" in
    aarch64|arm64) arch_dir="aarch64-linux" ;;
    *)             arch_dir="x86_64-linux" ;;
esac
export LD_LIBRARY_PATH="${ASCEND_INSTALL_PATH}/runtime/lib64:"\
"${ASCEND_INSTALL_PATH}/lib64:"\
"${ASCEND_INSTALL_PATH}/${arch_dir}/lib64:"\
"${LD_LIBRARY_PATH:-}"

"${HOST_BINARY}" "${KERNEL_BINARY}"
