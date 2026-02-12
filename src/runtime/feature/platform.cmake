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
    ${CMAKE_CURRENT_SOURCE_DIR}/inc
    ${CMAKE_CURRENT_SOURCE_DIR}/inc/args
    ${CMAKE_CURRENT_SOURCE_DIR}/inc/arg_loader
    ${CMAKE_CURRENT_SOURCE_DIR}/inc/common
    ${CMAKE_CURRENT_SOURCE_DIR}/inc/context
    ${CMAKE_CURRENT_SOURCE_DIR}/inc/device
    ${CMAKE_CURRENT_SOURCE_DIR}/inc/dfx
    ${CMAKE_CURRENT_SOURCE_DIR}/inc/drv
    ${CMAKE_CURRENT_SOURCE_DIR}/inc/engine
    ${CMAKE_CURRENT_SOURCE_DIR}/inc/engine/hwts
    ${CMAKE_CURRENT_SOURCE_DIR}/inc/event
    ${CMAKE_CURRENT_SOURCE_DIR}/inc/kernel
    ${CMAKE_CURRENT_SOURCE_DIR}/inc/launch
    ${CMAKE_CURRENT_SOURCE_DIR}/inc/model
    ${CMAKE_CURRENT_SOURCE_DIR}/inc/notify
    ${CMAKE_CURRENT_SOURCE_DIR}/inc/profiler
    ${CMAKE_CURRENT_SOURCE_DIR}/inc/soc
    ${CMAKE_CURRENT_SOURCE_DIR}/inc/spec
    ${CMAKE_CURRENT_SOURCE_DIR}/inc/sqe
    ${CMAKE_CURRENT_SOURCE_DIR}/inc/stars
    ${CMAKE_CURRENT_SOURCE_DIR}/inc/stream
    ${CMAKE_CURRENT_SOURCE_DIR}/inc/task
    ${CMAKE_CURRENT_SOURCE_DIR}/inc/utils
    ${CMAKE_CURRENT_SOURCE_DIR}/src/api
    ${CMAKE_CURRENT_SOURCE_DIR}/src/api_impl
    ${CMAKE_CURRENT_SOURCE_DIR}/src/engine
    ${CMAKE_CURRENT_SOURCE_DIR}/src/engine/hwts
    ${CMAKE_CURRENT_SOURCE_DIR}/src/engine/stars
    ${CMAKE_CURRENT_SOURCE_DIR}/src/stream
    ${CMAKE_CURRENT_SOURCE_DIR}/src/task/inc
    ${CMAKE_CURRENT_SOURCE_DIR}/src/profiler
    ${CMAKE_CURRENT_SOURCE_DIR}/src/pool
    ${CMAKE_CURRENT_SOURCE_DIR}/src/ttlv
    ${CMAKE_CURRENT_SOURCE_DIR}/src/device
    ${CMAKE_CURRENT_SOURCE_DIR}/src/drv
    ${CMAKE_CURRENT_SOURCE_DIR}/src/common
    ${CMAKE_CURRENT_SOURCE_DIR}/src/plugin_manage
    ${CMAKE_CURRENT_SOURCE_DIR}/src/kernel
    ${CMAKE_CURRENT_SOURCE_DIR}/src/kernel/arg_loader
    ${CMAKE_CURRENT_SOURCE_DIR}/src/kernel/args
    ${CMAKE_CURRENT_SOURCE_DIR}/src/memory
    ${CMAKE_CURRENT_SOURCE_DIR}/inc/cond_isa/v100
    ## not open
    ${CMAKE_CURRENT_SOURCE_DIR}/inc/dqs
    ${CMAKE_CURRENT_SOURCE_DIR}/inc/sqe/v200
    ${CMAKE_CURRENT_SOURCE_DIR}/inc/sqe/v200_base
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
        platform/910_B_93/dev_info_reg.cc
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
        $<BUILD_INTERFACE:atrace_headers>
    )
endmacro()

macro(runtime_platform_kirin_obj target_name)
    add_library(runtime_platform_kirin OBJECT
        platform/kirinx90/dev_info_reg.cc
        platform/kirin9030/dev_info_reg.cc
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
        $<BUILD_INTERFACE:atrace_headers>
    )
endmacro()

macro(runtime_platform_others_obj target_name)
    add_library(runtime_platform_others OBJECT
        platform/610_lite/dev_info_reg.cc
        platform/950/dev_info_reg.cc
        platform/as31xm1/dev_info_reg.cc
        platform/bs9sx1a/dev_info_reg.cc
        platform/cloud/dev_info_reg.cc
        platform/dc/dev_info_reg.cc
        platform/mc62cm12a/dev_info_reg.cc
        platform/adc/dev_info_reg.cc
        platform/mini/dev_info_reg.cc
        platform/mini_v3/dev_info_reg.cc
        platform/nano/dev_info_reg.cc
        platform/tiny/dev_info_reg.cc
        platform/910_96/dev_info_reg.cc
        platform/xpu/dev_info_reg.cc
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
        $<BUILD_INTERFACE:atrace_headers>
    )
endmacro()

macro(runtime_platform_tiny_obj target_name)
add_library(runtime_platform_tiny OBJECT
    platform/tiny/dev_info_reg.cc
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
    $<BUILD_INTERFACE:atrace_headers>
)
endmacro()