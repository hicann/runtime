# -----------------------------------------------------------------------------------------------------------
# Copyright (c) 2026 Huawei Technologies Co., Ltd.
# This program is free software, you can redistribute it and/or modify it under the terms and conditions of
# CANN Open Software License Agreement Version 2.0 (the "License").
# Please refer to the License for details. You may not use this file except in compliance with the License.
# THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
# INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
# See LICENSE in the root of the software repository for the full text of the License.
# -----------------------------------------------------------------------------------------------------------

cmake_minimum_required(VERSION 3.14)
project (rts)

if(NOT ENABLE_COV AND NOT ENABLE_UT)
    set(RUNTIME_DIR "${CMAKE_CURRENT_SOURCE_DIR}/.." CACHE PATH "Project top directory")
    include(${RUNTIME_DIR}/cmake/func.cmake)
    set_common_params("${RUNTIME_DIR}")
    set_runtime_params()
endif()

include(${RUNTIME_DIR}/src/inc/runtime/runtime_inner_headers.cmake)

add_subdirectory(aicpu_sched)
add_subdirectory(queue_schedule)
add_subdirectory(mmpa)
add_subdirectory(../cmake/stub cmake/stub)
add_subdirectory(dfx/log/liblog)
add_subdirectory(dfx/trace)
add_subdirectory(tsd)
add_subdirectory(dfx/error_manager)
add_subdirectory(dfx/msprof)
add_subdirectory(platform)
add_subdirectory(dfx/adump)
add_subdirectory(runtime)
add_subdirectory(acl/aclrt_impl)
add_subdirectory(acl/aclrt)
add_subdirectory(acl/acl_tdt_queue)
add_subdirectory(acl/acl_tdt_channel)
add_subdirectory(../stub stub)
add_subdirectory(tprt)

include(${RUNTIME_DIR}/version.cmake)
if(ENABLE_OPEN_SRC)
    check_pkg_build_deps("npu-runtime")
endif()
add_version_info_targets()

if(NOT ENABLE_COV AND NOT ENABLE_UT)
    add_dependencies(mmpa c_sec)
    add_dependencies(static_mmpa c_sec)
    add_dependencies(runtime_platform_others c_sec)
    add_dependencies(runtime_platform_tiny c_sec)
    add_dependencies(runtime_platform_910B c_sec)
    add_dependencies(runtime_platform_kirin c_sec)
    add_custom_target(pre_npu_runtime DEPENDS c_sec)
    foreach(depend ${NPU_DEPENDENCIES})
        add_dependencies(${depend} pre_npu_runtime)
    endforeach()

    include(${RUNTIME_DIR}/cmake/package.cmake)
endif()
