# -----------------------------------------------------------------------------------------------------------
# Copyright (c) 2025 Huawei Technologies Co., Ltd.
# This program is free software, you can redistribute it and/or modify it under the terms and conditions of
# CANN Open Software License Agreement Version 2.0 (the "License").
# Please refer to the License for details. You may not use this file except in compliance with the License.
# THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
# INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
# See LICENSE in the root of the software repository for the full text of the License.
# -----------------------------------------------------------------------------------------------------------
set(ADIAG_DIR ${TOP_DIR}/src/dfx/trace)
set(ATRACE_SOURCE_DIR ${ADIAG_DIR}/atrace)
include_directories(${CANN_3RD_LIB_PATH}/mockcpp_src/include)
# mockcpp 头文件包含 <boost/typeof/typeof.hpp>，需要把 boost include 路径补上，
# 否则单独构建 atrace UT 时会报 boost/typeof/typeof.hpp not found
include_directories(${CANN_3RD_LIB_PATH}/boost-1.87.0)

add_subdirectory(ut)