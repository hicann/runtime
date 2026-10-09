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
: "${ASCEND_INSTALL_PATH:?Please set ASCEND_INSTALL_PATH to the CANN installation directory}"
if [[ ! -f "${ASCEND_INSTALL_PATH}/set_env.sh" ||
      ! -f "${ASCEND_INSTALL_PATH}/include/acl/acl.h" ||
      ! -f "${ASCEND_INSTALL_PATH}/lib64/libacl_rt.so" ]]; then
    echo "[ERROR] CANN environment script, headers, or libacl_rt.so are missing."
    exit 1
fi
source "${ASCEND_INSTALL_PATH}/set_env.sh"

cd "${SCRIPT_DIR}"
mkdir -p build
cd build
echo "Configuring CMake..."
cmake .. -DASCEND_CANN_PACKAGE_PATH="${ASCEND_INSTALL_PATH}"
echo "Building..."
make -j"$(nproc)"
./main
