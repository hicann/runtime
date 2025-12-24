#!/bin/csh
# -----------------------------------------------------------------------------------------------------------
# Copyright (c) 2025 Huawei Technologies Co., Ltd.
# This program is free software, you can redistribute it and/or modify it under the terms and conditions of
# CANN Open Software License Agreement Version 2.0 (the "License").
# Please refer to the License for details. You may not use this file except in compliance with the License.
# THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
# INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
# See LICENSE in the root of the software repository for the full text of the License.
# -----------------------------------------------------------------------------------------------------------

set MIN_PIP_VERSION=19
set PYTHON_VERSION=3.7.5

set version=`pip3 --version | cut -d" " -f2 | cut -d"." -f1`
if (${version} < ${MIN_PIP_VERSION}) then
    echo "pip3 version is lower than ${MIN_PIP_VERSION}"
endif

set python_version=`python3 --version | cut -d" " -f2`
foreach num (1 2 3)
    set version_num=`echo ${python_version} | cut -d"." -f${num}`
    set min_version_num=`echo ${PYTHON_VERSION} | cut -d"." -f${num}`
    if (${version_num} < ${min_version_num}) then
        echo "python version ${python_version} is lower than ${PYTHON_VERSION}."
        break
    endif
end
