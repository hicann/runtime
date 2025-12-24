# -----------------------------------------------------------------------------------------------------------
# Copyright (c) 2025 Huawei Technologies Co., Ltd.
# This program is free software, you can redistribute it and/or modify it under the terms and conditions of
# CANN Open Software License Agreement Version 2.0 (the "License").
# Please refer to the License for details. You may not use this file except in compliance with the License.
# THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
# INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
# See LICENSE in the root of the software repository for the full text of the License.
# -----------------------------------------------------------------------------------------------------------

cmake_minimum_required(VERSION 3.14)
project (device_rts)

set(PRODUCT_SIDE device)
include(../func.cmake)
include(../intf_pub_linux.cmake)

set(CMAKE_CXX_STANDARD 17)

set(RUNTIME_DIR "${CMAKE_CURRENT_SOURCE_DIR}/../../" CACHE PATH "Project top directory")
set(TARGET_SYSTEM_NAME Linux)

if(CMAKE_GENERATOR STREQUAL "Unix Makefiles")
    set(CMAKE_CXX_COMPILE_OBJECT
        "<CMAKE_CXX_COMPILER> <DEFINES> -D__FILE__='\"$(notdir $(abspath <SOURCE>))\"' -Wno-builtin-macro-redefined <INCLUDES> <FLAGS> -o <OBJECT> -c <SOURCE>"
    )
    set(CMAKE_C_COMPILE_OBJECT
        "<CMAKE_C_COMPILER> <DEFINES> -D__FILE__='\"$(notdir $(abspath <SOURCE>))\"' -Wno-builtin-macro-redefined <INCLUDES> <FLAGS> -o <OBJECT> -c <SOURCE>"
    )
endif()

include(${RUNTIME_DIR}/cmake/third_party/protobuf.cmake)
include(${RUNTIME_DIR}/cmake/third_party/csec.cmake)
include(${RUNTIME_DIR}/cmake/third_party/json.cmake)
add_subdirectory(${RUNTIME_DIR}/src/mmpa ${CMAKE_BINARY_DIR}/src/mmpa)
add_subdirectory(${RUNTIME_DIR}/src/dfx/log/liblog ${CMAKE_BINARY_DIR}/liblog)
add_subdirectory(${RUNTIME_DIR}/src/platform ${CMAKE_BINARY_DIR}/platform)
add_subdirectory(${RUNTIME_DIR}/src/aicpu_sched/aicpu_kernel ${CMAKE_BINARY_DIR}/aicpu_kernel)
add_subdirectory(${RUNTIME_DIR}/cmake/stub ${CMAKE_BINARY_DIR}/stub)
add_dependencies(mmpa c_sec)
add_dependencies(static_mmpa c_sec)
add_dependencies(platform c_sec)

install(FILES
  ${RUNTIME_DIR}/build/lib_aicpu/cann-tsch-compat.tar.gz
  DESTINATION runtime
)
