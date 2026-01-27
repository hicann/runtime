# -----------------------------------------------------------------------------------------------------------
# Copyright (c) 2025 Huawei Technologies Co., Ltd.
# This program is free software, you can redistribute it and/or modify it under the terms and conditions of
# CANN Open Software License Agreement Version 2.0 (the "License").
# Please refer to the License for details. You may not use this file except in compliance with the License.
# THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
# INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
# See LICENSE in the root of the software repository for the full text of the License.
# -----------------------------------------------------------------------------------------------------------

set(BASE_DIR ${CMAKE_CURRENT_SOURCE_DIR})
set(RUNTIME_DIR ${CMAKE_CURRENT_SOURCE_DIR}/../../..)

set(PRODUCT_TYPE "DEFAULT")
set(lhisi_product false)
set(need_proto_src true)

set(proto_src_files
    ${CMAKE_CURRENT_SOURCE_DIR}/proto/dump_data.proto
    ${CMAKE_CURRENT_SOURCE_DIR}/proto/op_mapping_info.proto
)

protobuf_generate(aicpu_cust PROTO_SRCS PROTO_HDRS ${proto_src_files})

set(AICPU_TS_SRC_FILES
    ${CMAKE_CURRENT_SOURCE_DIR}/core/aicpusd_interface_process.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/core/aicpusd_event_manager.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/core/aicpusd_event_process.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/core/dfx/dump_task.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/core/dfx/aicpu_cust_sd_dump_process.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/core/cust_platform_info/aicpu_cust_platform_info_process.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/core/aicpusd_drv_manager.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/core/aicpusd_threads_process.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/core/aicpusd_op_executor.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/core/cust_mc2_maintenance/aicpu_cust_sd_mc2_maintenance_thread.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/common/feature_ctrl_open_source.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/common/feature_ctrl_common.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/common/aicpusd_sqe_adapter.cpp

    ${CMAKE_CURRENT_SOURCE_DIR}/core/aicpusd_args_parser.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/core/dfx/aicpusd_monitor.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/core/aicpusd_task_queue.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/core/aicpusd_worker.cpp

    ${CMAKE_CURRENT_SOURCE_DIR}/stub/proc_mgr/proc_mgr_sys_operator_agent.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/core/aicpusd_resource_limit.cpp
    #need_proto_src
    $<$<STREQUAL:${need_proto_src},true>:${PROTO_SRCS}>
)

set(AICPU_TS_C_INCLUDES
    ${CMAKE_CURRENT_SOURCE_DIR}
    ${CMAKE_CURRENT_SOURCE_DIR}/core
    ${CMAKE_CURRENT_SOURCE_DIR}/core/cust_platform_info
    ${CMAKE_CURRENT_SOURCE_DIR}/core/cust_mc2_maintenance
    ${CMAKE_CURRENT_SOURCE_DIR}/core/dfx
    ${CMAKE_CURRENT_SOURCE_DIR}/common
    ${RUNTIME_DIR}/pkg_inc/aicpu_sched/aicpu_schedule
    ${RUNTIME_DIR}/pkg_inc/aicpu_sched/cpu_kernels
    ${RUNTIME_DIR}/pkg_inc/profiling
    ${RUNTIME_DIR}/pkg_inc/base
    ${RUNTIME_DIR}/pkg_inc/aicpu_sched/common
    ${RUNTIME_DIR}/pkg_inc/tsd
    ${RUNTIME_DIR}/pkg_inc/aicpu_sched
    ${RUNTIME_DIR}/pkg_inc/runtime
    ${RUNTIME_DIR}/pkg_inc/runtime/runtime
    ${RUNTIME_DIR}/pkg_inc
    ${CMAKE_CURRENT_SOURCE_DIR}/../aicpu_processer
    ${CMAKE_CURRENT_SOURCE_DIR}/../aicpu_sharder
    ${CMAKE_CURRENT_SOURCE_DIR}/../aicpu_prof
    ${CMAKE_CURRENT_SOURCE_DIR}/../extern_include
    ${CMAKE_CURRENT_SOURCE_DIR}/..
    ${RUNTIME_DIR}/src/dfx/msprof/inc/toolchain
    ${RUNTIME_DIR}/src/dfx/adump/inc
    ${RUNTIME_DIR}/src/dfx/adump/inc/metadef
    ${RUNTIME_DIR}/include
    ${RUNTIME_DIR}/include/driver
    ${CMAKE_CURRENT_SOURCE_DIR}/stub/proc_mgr
    ${CMAKE_BINARY_DIR}/proto/aicpu_cust/proto/
)
add_library(aicpu_custom_scheduler_so SHARED
    ${AICPU_TS_SRC_FILES}
)

add_executable(aicpu_custom_scheduler
    ${CMAKE_CURRENT_SOURCE_DIR}/execute/main.cpp
)

target_link_libraries(aicpu_custom_scheduler_so PRIVATE
    -ldl
    $<BUILD_INTERFACE:intf_pub_cxx17>
    c_sec
    ascend_hal_stub
    aicpu_processer
    aicpu_prof
    aicpu_sharder
    tsd_eventclient_stub
    ascend_protobuf_static
    adump_stub
    stackcore_stub
    seccomp_stub
    seccomp_headers
    -rdynamic
    $<BUILD_INTERFACE:c_sec_headers>
)

target_include_directories(aicpu_custom_scheduler_so PRIVATE
    ${AICPU_TS_C_INCLUDES}
)

target_include_directories(aicpu_custom_scheduler PRIVATE
    ${AICPU_TS_C_INCLUDES}
)
target_compile_definitions(aicpu_custom_scheduler_so PRIVATE
    google=ascend_private
)

target_compile_options(aicpu_custom_scheduler PRIVATE
   -fstack-protector
   -fno-common
   -fno-strict-aliasing
   -Werror -Wall
   -Wno-error=array-bounds     # For controlling the compiler's warnings and errors regarding array out-of-bounds access.
)

target_compile_options(aicpu_custom_scheduler_so PRIVATE
    -O2
    -Werror -Wall
    -Wno-error=array-bounds    # For controlling the compiler's warnings and errors regarding array out-of-bounds access.
    -Wno-pessimizing-move      # Used to disable the warning about using std::move to prevent copy elision.
    -Wno-unused-private-field  # To disable warnings about unused private fields.
    -fstack-protector
    -fno-common
    -fno-strict-aliasing
    -fvisibility=hidden
    -fvisibility-inlines-hidden
    -flto
    -fdata-sections
    -ffunction-sections
    $<$<STREQUAL:${RESERVED_SYMBOL},true>:-g>
)

target_link_options(aicpu_custom_scheduler_so PRIVATE
    -flto
    -Wl,--gc-sections
)

set_target_properties(aicpu_custom_scheduler_so
    PROPERTIES
    OUTPUT_NAME aicpu_custom_scheduler
)

install(TARGETS aicpu_custom_scheduler_so OPTIONAL
    EXPORT aicpu_custom_scheduler_so-targets
    LIBRARY DESTINATION ${INSTALL_LIBRARY_DIR}
)

target_link_libraries(aicpu_custom_scheduler PRIVATE
    $<BUILD_INTERFACE:intf_pub_cxx17>
    c_sec
    unified_dlog
    aicpu_custom_scheduler_so
    ascend_hal_stub
    aicpu_processer
    aicpu_prof
    aicpu_sharder
    tsd_eventclient_stub
    adump_stub
    -rdynamic
    -ldl
    -lm
    $<BUILD_INTERFACE:c_sec_headers>
)
