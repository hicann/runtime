# -----------------------------------------------------------------------------------------------------------
# Copyright (c) 2025 Huawei Technologies Co., Ltd.
# This program is free software, you can redistribute it and/or modify it under the terms and conditions of
# CANN Open Software License Agreement Version 2.0 (the "License").
# Please refer to the License for details. You may not use this file except in compliance with the License.
# THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
# INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
# See LICENSE in the root of the software repository for the full text of the License.
# -----------------------------------------------------------------------------------------------------------
include_guard(GLOBAL)
include(${RUNTIME_DIR}/pkg_inc/runtime/runtime/runtime_headers.cmake)


set(RUNTIME_INC_DIR_COMMON_PLATFORM
    ${RUNTIME_DIR}/src/runtime/inc
    ${RUNTIME_DIR}/src/runtime/inc/args
    ${RUNTIME_DIR}/src/runtime/inc/arg_loader
    ${RUNTIME_DIR}/src/runtime/inc/common
    ${RUNTIME_DIR}/src/runtime/inc/context
    ${RUNTIME_DIR}/src/runtime/inc/device
    ${RUNTIME_DIR}/src/runtime/inc/dfx
    ${RUNTIME_DIR}/src/runtime/inc/drv
    ${RUNTIME_DIR}/src/runtime/inc/engine
    ${RUNTIME_DIR}/src/runtime/inc/engine/hwts
    ${RUNTIME_DIR}/src/runtime/inc/event
    ${RUNTIME_DIR}/src/runtime/inc/kernel
    ${RUNTIME_DIR}/src/runtime/inc/launch
    ${RUNTIME_DIR}/src/runtime/inc/model
    ${RUNTIME_DIR}/src/runtime/inc/notify
    ${RUNTIME_DIR}/src/runtime/inc/profiler
    ${RUNTIME_DIR}/src/runtime/inc/soc
    ${RUNTIME_DIR}/src/runtime/inc/spec
    ${RUNTIME_DIR}/src/runtime/inc/sqe
    ${RUNTIME_DIR}/src/runtime/inc/stars
    ${RUNTIME_DIR}/src/runtime/inc/stream
    ${RUNTIME_DIR}/src/runtime/inc/task
    ${RUNTIME_DIR}/src/runtime/inc/utils
    ${RUNTIME_DIR}/src/runtime/api
    ${RUNTIME_CORE_DIR}/src/api_impl
    ${RUNTIME_CORE_DIR}/src/engine
    ${RUNTIME_CORE_DIR}/src/engine/hwts
    ${RUNTIME_CORE_DIR}/src/engine/stars
    ${RUNTIME_CORE_DIR}/src/stream
    ${RUNTIME_CORE_DIR}/src/task/inc
    ${RUNTIME_CORE_DIR}/src/profiler
    ${RUNTIME_CORE_DIR}/src/pool
    ${RUNTIME_CORE_DIR}/src/ttlv
    ${RUNTIME_CORE_DIR}/src/device
    ${RUNTIME_DIR}/src/runtime/driver
    ${RUNTIME_CORE_DIR}/src/common
    ${RUNTIME_CORE_DIR}/src/plugin_manage
    ${RUNTIME_CORE_DIR}/src/kernel
    ${RUNTIME_CORE_DIR}/src/kernel/arg_loader
    ${RUNTIME_CORE_DIR}/src/kernel/args
    ${RUNTIME_CORE_DIR}/src/memory
    ${RUNTIME_FEATURE_DIR}/soma
    ${RUNTIME_FEATURE_DIR}/cntnotify
    ${RUNTIME_CORE_DIR}/src/uvm
    ${RUNTIME_CORE_DIR}/src/event
    ${RUNTIME_DIR}/src/runtime/inc/cond_isa/v100
    ## not open
    ${RUNTIME_DIR}/src/runtime/inc/dqs
    ${RUNTIME_DIR}/src/runtime/inc/sqe/v200
    ${RUNTIME_DIR}/src/runtime/inc/sqe/v200_base
    ${RUNTIME_DIR}/src/inc
    ${RUNTIME_DIR}/pkg_inc/tsd/
    ${RUNTIME_DIR}/pkg_inc/aicpu_sched/
    ${RUNTIME_DIR}/pkg_inc/aicpu_sched/common
    ${RUNTIME_DIR}/src/queue_schedule/dgwclient/inc/
    ${RUNTIME_DIR}/src/dfx/error_manager
    ${LIBC_SEC_HEADER}
    ${RUNTIME_DIR}/src/runtime/dfx/include/trace/awatchdog/
    ${RUNTIME_DIR}/include/driver
    ${RUNTIME_DIR}/include/trace/utrace
    ${RUNTIME_DIR}/pkg_inc
    ${RUNTIME_DIR}/include/external/acl
    ${RUNTIME_DIR}/include/trace/awatchdog
    ${RUNTIME_DIR}/include
    ${RUNTIME_DIR}/src/dfx/adump/inc/metadef
    ${RUNTIME_DIR}/src/platform
    ${RUNTIME_DIR}/include/external/acl/error_codes
)

#------------------------- runtime platform -------------------------
macro(runtime_platform_910B_obj target_name)
    add_library(runtime_platform_910B OBJECT
        ${RUNTIME_DIR}/src/runtime/config/910_B_93/dev_info_reg.cc
    )

    target_include_directories(runtime_platform_910B PRIVATE
        ${RUNTIME_INC_DIR_COMMON_PLATFORM}
    )

    target_compile_options(runtime_platform_910B PRIVATE
            $<$<CONFIG:Debug>:-O0>
            $<$<NOT:$<CONFIG:Debug>>:-O3>
            -fvisibility=hidden
            -fno-common
            -fno-strict-aliasing
            -Werror
            -Wextra
            $<$<NOT:$<STREQUAL:${TARGET_SYSTEM_NAME},Windows>>:-Wfloat-equal>
    )

    target_link_libraries(runtime_platform_910B PRIVATE
        $<BUILD_INTERFACE:intf_pub>
        $<BUILD_INTERFACE:mmpa_headers>
        $<BUILD_INTERFACE:msprof_headers>
        $<BUILD_INTERFACE:slog_headers>
        $<BUILD_INTERFACE:npu_runtime_headers>
        $<BUILD_INTERFACE:npu_runtime_inner_headers>
        $<BUILD_INTERFACE:atrace_headers>
    )
endmacro()

macro(runtime_platform_kirin_obj target_name)
    add_library(runtime_platform_kirin OBJECT
        ${RUNTIME_DIR}/src/runtime/config/kirinx90/dev_info_reg.cc
        ${RUNTIME_DIR}/src/runtime/config/kirin9030/dev_info_reg.cc
    )

    target_include_directories(runtime_platform_kirin PRIVATE
        ${RUNTIME_INC_DIR_COMMON_PLATFORM}
    )

    target_compile_options(runtime_platform_kirin PRIVATE
            $<$<CONFIG:Debug>:-O0>
            $<$<NOT:$<CONFIG:Debug>>:-O3>
            -fvisibility=hidden
            -fno-common
            -fno-strict-aliasing
            -Werror
            -Wextra
            $<$<NOT:$<STREQUAL:${TARGET_SYSTEM_NAME},Windows>>:-Wfloat-equal>
    )

    target_link_libraries(runtime_platform_kirin PRIVATE
        $<BUILD_INTERFACE:intf_pub>
        $<BUILD_INTERFACE:mmpa_headers>
        $<BUILD_INTERFACE:msprof_headers>
        $<BUILD_INTERFACE:slog_headers>
        $<BUILD_INTERFACE:npu_runtime_headers>
        $<BUILD_INTERFACE:npu_runtime_inner_headers>
        $<BUILD_INTERFACE:atrace_headers>
    )
endmacro()

macro(runtime_platform_others_obj target_name)
    add_library(runtime_platform_others OBJECT
        ${RUNTIME_DIR}/src/runtime/config/610_lite/dev_info_reg.cc
        ${RUNTIME_DIR}/src/runtime/config/950/dev_info_reg.cc
        ${RUNTIME_DIR}/src/runtime/config/as31xm1/dev_info_reg.cc
        ${RUNTIME_DIR}/src/runtime/config/bs9sx1a/dev_info_reg.cc
        ${RUNTIME_DIR}/src/runtime/config/cloud/dev_info_reg.cc
        ${RUNTIME_DIR}/src/runtime/config/dc/dev_info_reg.cc
        ${RUNTIME_DIR}/src/runtime/config/mc62cm12a/dev_info_reg.cc
        ${RUNTIME_DIR}/src/runtime/config/adc/dev_info_reg.cc
        ${RUNTIME_DIR}/src/runtime/config/mini/dev_info_reg.cc
        ${RUNTIME_DIR}/src/runtime/config/mini_v3/dev_info_reg.cc
        ${RUNTIME_DIR}/src/runtime/config/nano/dev_info_reg.cc
        ${RUNTIME_DIR}/src/runtime/config/tiny/dev_info_reg.cc
        ${RUNTIME_DIR}/src/runtime/config/910_96/dev_info_reg.cc
        ${RUNTIME_DIR}/src/runtime/config/xpu/dev_info_reg.cc
    )

    target_include_directories(runtime_platform_others PRIVATE
        ${RUNTIME_INC_DIR_COMMON_PLATFORM}
    )

    target_compile_options(runtime_platform_others PRIVATE
            $<$<CONFIG:Debug>:-O0>
            $<$<NOT:$<CONFIG:Debug>>:-O3>
            -fvisibility=hidden
            -fno-common
            -fno-strict-aliasing
            -Werror
            -Wextra
            $<$<NOT:$<STREQUAL:${TARGET_SYSTEM_NAME},Windows>>:-Wfloat-equal>
    )

    target_link_libraries(runtime_platform_others PRIVATE
        $<BUILD_INTERFACE:intf_pub>
        $<BUILD_INTERFACE:mmpa_headers>
        $<BUILD_INTERFACE:msprof_headers>
        $<BUILD_INTERFACE:slog_headers>
        $<BUILD_INTERFACE:npu_runtime_headers>
        $<BUILD_INTERFACE:npu_runtime_inner_headers>
        $<BUILD_INTERFACE:atrace_headers>
    )
endmacro()

macro(runtime_platform_tiny_obj target_name)
add_library(runtime_platform_tiny OBJECT
    ${RUNTIME_DIR}/src/runtime/config/tiny/dev_info_reg.cc
)

target_include_directories(runtime_platform_tiny PRIVATE
    ${RUNTIME_INC_DIR_COMMON_PLATFORM}
)

target_compile_options(runtime_platform_tiny PRIVATE
        $<$<CONFIG:Debug>:-O0>
        $<$<NOT:$<CONFIG:Debug>>:-O3>
        -fvisibility=hidden
        -fno-common
        -fno-strict-aliasing
        -Werror
        -Wextra
        $<$<NOT:$<STREQUAL:${TARGET_SYSTEM_NAME},Windows>>:-Wfloat-equal>
)

target_link_libraries(runtime_platform_tiny PRIVATE
    $<BUILD_INTERFACE:intf_pub>
    $<BUILD_INTERFACE:mmpa_headers>
    $<BUILD_INTERFACE:msprof_headers>
    $<BUILD_INTERFACE:slog_headers>
    $<BUILD_INTERFACE:npu_runtime_headers>
    $<BUILD_INTERFACE:npu_runtime_inner_headers>
    $<BUILD_INTERFACE:atrace_headers>
)
endmacro()
