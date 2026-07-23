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
EXAMPLE_DIR="$(cd "${SCRIPT_DIR}/../.." && pwd)"

if [[ ! -f "${EXAMPLE_DIR}/set_sample_env.sh" ]]; then
    echo "[ERROR]: ${EXAMPLE_DIR}/set_sample_env.sh does not exist."
    exit 1
fi

set +eu
# shellcheck source=/dev/null
source "${EXAMPLE_DIR}/set_sample_env.sh"
ret=$?
set -euo pipefail
if [[ "${ret}" -ne 0 ]]; then
    echo "[ERROR]: Failed to detect CANN environment via ${EXAMPLE_DIR}/set_sample_env.sh. Please check the location of set_sample_env.sh."
    exit 1
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

cd "${SCRIPT_DIR}"

BUILD_DIR="${SCRIPT_DIR}/build"
mkdir -p "${BUILD_DIR}"
cd "${BUILD_DIR}"

echo "Configuring CMake..."
cmake .. \
    -DASCEND_CANN_PACKAGE_PATH="${ASCEND_INSTALL_PATH}"

echo "Building..."
make -j"$(nproc)"

cd "${SCRIPT_DIR}"

echo "Build completed successfully!"
echo "Executable location: ${SCRIPT_DIR}/build/main"
echo "Run the sample: ./build/main"
./build/main
