# -----------------------------------------------------------------------------------------------------------
# Copyright (c) 2025 Huawei Technologies Co., Ltd.
# This program is free software, you can redistribute it and/or modify it under the terms and conditions of
# CANN Open Software License Agreement Version 2.0 (the "License").
# Please refer to the License for details. You may not use this file except in compliance with the License.
# THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
# INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
# See LICENSE in the root of the software repository for the full text of the License.
# -----------------------------------------------------------------------------------------------------------

set(SRC_PATH
    ${AICPU_SCHED_PATH}/aicpu_prof
)

set(local_lib_dp_src_files
    dp_main_ut.cpp
    dp/profiling_adp_ut.cpp
    ../stub/slog_stub.cpp
)
set(LOCAL_AICPU_PROFILING_SRC_FILES
    ${SRC_PATH}/profiling_adp.cc
    ${SRC_PATH}/prof_so_manager.cpp
)

set(inc_path
    ${SRC_PATH}
    ${RUNTIME_DIR}/pkg_inc/aicpu_sched
    ${RUNTIME_DIR}/pkg_inc/aicpu_sched/aicpu_schedule
    ${AICPU_SCHED_PATH}
    ${RUNTIME_DIR}/pkg_inc/base
    ${RUNTIME_DIR}/src/dfx/msprof/inc/toolchain
    ${RUNTIME_DIR}/pkg_inc/profiling
)

##llt datapreprocess ut for x86
add_executable(aicpu_prof_llt_ut
    ${local_lib_dp_src_files}
    ${LOCAL_AICPU_PROFILING_SRC_FILES}
)

target_compile_definitions(aicpu_prof_llt_ut PRIVATE
    LLT_MODE=1
    PLATFORM_MODE=1
)
target_link_libraries(aicpu_prof_llt_ut PRIVATE
    $<BUILD_INTERFACE:intf_aicpu_llt_pub>
    $<BUILD_INTERFACE:slog_headers>
    c_sec
    -ldl
    c_sec_headers
)

target_include_directories(aicpu_prof_llt_ut PRIVATE
    ${inc_path}
)