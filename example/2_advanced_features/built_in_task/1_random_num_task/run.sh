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

# 获取 CANN 安装路径
_ASCEND_INSTALL_PATH=$ASCEND_INSTALL_PATH
source $_ASCEND_INSTALL_PATH/bin/setenv.bash

# 获取脚本所在目录
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "${SCRIPT_DIR}"

# 构建目录
BUILD_DIR="${SCRIPT_DIR}/build"
mkdir -p "${BUILD_DIR}"
cd "${BUILD_DIR}"

# 执行 cmake 配置
echo "Configuring CMake..."
cmake .. \
    -DASCEND_CANN_PACKAGE_PATH=${_ASCEND_INSTALL_PATH}

# 编译
echo "Building..."
make -j$(nproc)

# 返回脚本目录
cd "${SCRIPT_DIR}"

echo "Build completed successfully!"
echo "Executable location: ${SCRIPT_DIR}/build/main"
echo "Run the sample: ./build/main"