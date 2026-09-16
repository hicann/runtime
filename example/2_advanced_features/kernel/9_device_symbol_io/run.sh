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

# Resolve the CANN path, SOC version, and native ASC CMake modules.
if [[ -z "${ASCEND_INSTALL_PATH:-${ASCEND_HOME_PATH:-}}" || -z "${SOC_VERSION:-}" || \
      -z "${ASCENDC_CMAKE_DIR:-}" ]]; then
    [[ -f "${EXAMPLE_DIR}/set_sample_env.sh" ]] || \
        die "Source the CANN set_env.sh or export ASCEND_INSTALL_PATH=<cann_path>."
    set +eu
    source "${EXAMPLE_DIR}/set_sample_env.sh"
    ret=$?
    set -euo pipefail
    [[ "${ret}" -eq 0 ]] || die "Failed to detect the sample environment."
fi

export ASCEND_INSTALL_PATH="${ASCEND_INSTALL_PATH:-${ASCEND_HOME_PATH}}"
export ASCEND_HOME_PATH="${ASCEND_HOME_PATH:-${ASCEND_INSTALL_PATH}}"
[[ -n "${SOC_VERSION:-}" ]] || die "SOC_VERSION is not set."
[[ -f "${ASCENDC_CMAKE_DIR:-}/asc_modules/FindASC.cmake" ]] || \
    die "The native ASC CMake modules were not found; install or source the CANN Toolkit first."
[[ -f "${ASCEND_INSTALL_PATH}/lib64/libacl_rt.so" ]] || \
    die "libacl_rt.so was not found under ASCEND_INSTALL_PATH."

case "$(uname -m)" in
    aarch64|arm64) CANN_ARCH_DIR="aarch64-linux" ;;
    x86_64|amd64) CANN_ARCH_DIR="x86_64-linux" ;;
    *) die "Unsupported host architecture: $(uname -m)" ;;
esac

cd "${SCRIPT_DIR}"
echo "[INFO] ASCEND_HOME_PATH=${ASCEND_HOME_PATH}"
echo "[INFO] SOC_VERSION=${SOC_VERSION}"
echo "[INFO] ASCENDC_CMAKE_DIR=${ASCENDC_CMAKE_DIR}"

rm -rf "${BUILD_DIR}" "${OUTPUT_DIR}"
cmake -S "${SCRIPT_DIR}" -B "${BUILD_DIR}" \
    -DASCEND_CANN_PACKAGE_PATH="${ASCEND_INSTALL_PATH}" \
    -DASCENDC_CMAKE_DIR="${ASCENDC_CMAKE_DIR}" \
    -DSOC_VERSION="${SOC_VERSION}"
cmake --build "${BUILD_DIR}" -j"$(nproc)"
cmake --install "${BUILD_DIR}"

HOST_BINARY="${OUTPUT_DIR}/bin/main"
[[ -x "${HOST_BINARY}" ]] || die "Host executable was not generated: ${HOST_BINARY}"

export LD_LIBRARY_PATH="${ASCEND_INSTALL_PATH}/runtime/lib64:"\
"${ASCEND_INSTALL_PATH}/lib64:"\
"${ASCEND_INSTALL_PATH}/${CANN_ARCH_DIR}/lib64:"\
"${LD_LIBRARY_PATH:-}"

"${HOST_BINARY}" | tee output_msg.txt
