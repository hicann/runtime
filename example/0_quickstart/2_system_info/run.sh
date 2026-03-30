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

set -e

_ASCEND_INSTALL_PATH=$ASCEND_INSTALL_PATH
source $_ASCEND_INSTALL_PATH/bin/setenv.bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "${SCRIPT_DIR}"

BUILD_DIR="${SCRIPT_DIR}/build"
mkdir -p "${BUILD_DIR}"
cd "${BUILD_DIR}"

echo "Configuring CMake..."
cmake .. \
    -DASCEND_CANN_PACKAGE_PATH=${_ASCEND_INSTALL_PATH}

echo "Building..."
make -j$(nproc)

cd "${SCRIPT_DIR}"

echo "Build completed successfully!"
echo "Executable location: ${SCRIPT_DIR}/build/main"
echo "Run the sample: ./build/main"
./build/main
