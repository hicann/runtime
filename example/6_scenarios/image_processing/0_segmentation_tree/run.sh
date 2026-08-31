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

env_script="${SCRIPT_DIR}/../../../set_sample_env.sh"
if [[ -n "${ASCEND_INSTALL_PATH:-${ASCEND_HOME_PATH:-}}" ]]; then
    export ASCEND_INSTALL_PATH="${ASCEND_INSTALL_PATH:-${ASCEND_HOME_PATH}}"
    export ASCEND_HOME_PATH="${ASCEND_HOME_PATH:-${ASCEND_INSTALL_PATH}}"
fi

if [[ ! -f "${env_script}" ]]; then
    echo "[ERROR]: Cannot find ${env_script}."
    exit 1
fi
source "${env_script}"

if [[ -z "${SOC_VERSION:-}" || -z "${ASCENDC_CMAKE_DIR:-}" ]]; then
    echo "[ERROR]: SOC_VERSION and ASCENDC_CMAKE_DIR must be set by ${env_script}."
    exit 1
fi
cd "${SCRIPT_DIR}"

echo "[INFO]: Current compile soc version is ${SOC_VERSION}"

rm -rf build
mkdir -p build
cmake -B build \
    -DASCEND_CANN_PACKAGE_PATH="${ASCEND_HOME_PATH}"
cmake --build build -j
cmake --install build

file_path=output_msg.txt
./build/main | tee "${file_path}"
