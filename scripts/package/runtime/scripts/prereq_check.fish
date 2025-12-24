#!/usr/bin/fish
# -----------------------------------------------------------------------------------------------------------
# Copyright (c) 2025 Huawei Technologies Co., Ltd.
# This program is free software, you can redistribute it and/or modify it under the terms and conditions of
# CANN Open Software License Agreement Version 2.0 (the "License").
# Please refer to the License for details. You may not use this file except in compliance with the License.
# THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
# INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
# See LICENSE in the root of the software repository for the full text of the License.
# -----------------------------------------------------------------------------------------------------------

set -x MIN_PIP_VERSION 19
set -x PYTHON_VERSION 3.7.5

set -lx version (pip3 --version | cut -d" " -f2 | cut -d"." -f1)
if test {$version} -lt {$MIN_PIP_VERSION}
    echo "pip3 version is lower than $MIN_PIP_VERSION.x.x"
end

set -lx python_version (python3 --version | cut -d" " -f2)
for num in (seq 1 3)
    set -lx version_num (echo {$python_version} | cut -d"." -f{$num})
    set -lx min_version_num (echo {$PYTHON_VERSION} | cut -d"." -f{$num})
    if test {$version_num} -lt {$min_version_num}
        echo "python version $python_version is lower than $PYTHON_VERSION."
        break
    end
end
