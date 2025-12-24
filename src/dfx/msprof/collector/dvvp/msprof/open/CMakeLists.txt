# -----------------------------------------------------------------------------------------------------------
# Copyright (c) 2025 Huawei Technologies Co., Ltd.
# This program is free software, you can redistribute it and/or modify it under the terms and conditions of
# CANN Open Software License Agreement Version 2.0 (the "License").
# Please refer to the License for details. You may not use this file except in compliance with the License.
# THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
# INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
# See LICENSE in the root of the software repository for the full text of the License.
# -----------------------------------------------------------------------------------------------------------
protobuf_generate(profiler_proto
    CppPath
    HeaderPath
    ${CMAKE_CURRENT_SOURCE_DIR}/../../proto/profiler.proto
    TARGET
)

set(hdcCpp
    ../../profhal/adx/stub/adx_prof_api.cpp
    ../../profhal/adx/wrapper/hdc_api.cpp
    ../../profhal/adx/wrapper/memory_utils.cpp
)

####################### libascend_devprof.so #########################

if (PRODUCT)
if (${PRODUCT} STREQUAL "ascend310Brc")

set(msprofCpp
    ../common/src/receive_data.cpp
    ../drvprof/src/engine_mgr.cpp
    ../drvprof/src/module_job.cpp
    ../drvprof/src/rpc_data_handle.cpp
    ../drvprof/src/rpc_dumper.cpp
    ../devprof/src/devprof_drv_aicpu.cpp
    ../devprof/src/devprof_drv_adprof.cpp
    ../devprof/src/devprof_common.cpp
    ../devprof/src/adprof_collector.cpp
    ../devprof/src/devprof_msprof_api.cpp
    ../devprof/src/devprof_adprof_api.cpp
    ${PROF_BASIC_DIR}/osal/osal.c
    ../../common/config/open/config_manager.cpp
    ../../common/memory/chunk_pool.cpp
    ../../common/statistics/perf_count.cpp
    ../../common/thread/thread.cpp
    ../../common/thread/thread_pool.cpp
    ../../common/utils/utils.cpp
    ../../common/cmd_log/cmd_log.cpp
    ../../common/validation/param_validation.cpp
    ../../common/validation/param_validation_open.cpp
    ../../common/platform/platform.cpp
    ../../common/platform/platform_open.cpp
    ../../depend/stub/error_manager/msprof_error_manager_stub.cpp
    ../../driver/devmgmt/ai_drv_dev_api.cpp
    ../../driver/devmgmt/ai_drv_dev_api_open.cpp
    ../../message/codec.cpp
    ../../common/json/json.cpp
    ../../streamio/client/src/sender.cpp
    ../../transport/hdc/hdc_transport.cpp
    ../../transport/hdc/helper_transport.cpp
    ../../transport/hdc/hdc_sender.cpp
    ../../transport/uploader.cpp
    ../../transport/uploader_mgr.cpp
    ../../transport/hash_data.cpp
    ../../profimpl/platform/platform_interface.cpp
    ../../profimpl/platform/base_analyzer.cpp
    ../../profimpl/adapter/src/json_parser.cpp
    ../../profimpl/collect/job_wrapper/src/prof_perf_job.cpp
    ../../profimpl/collect/job_wrapper/src/adprof_collector_proxy.cpp
    ../../profimpl/collect/job_wrapper/src/prof_hardware_mem_job.cpp
    ../../profimpl/collect/job_wrapper/src/prof_hardware_mem_job_open.cpp
    ../../profimpl/collect/job_wrapper/src/prof_sys_info_job.cpp
    ../../profimpl/collect/job_wrapper/src/prof_timer.cpp
    ../../profimpl/collect/job_wrapper/src/collection_job.cpp
    ../../profimpl/collect/job_wrapper/src/prof_comm_job.cpp
    ../../profimpl/collect/job_wrapper/src/prof_channel_manager.cpp
    ../../profhal/adx/stub/adx_prof_api.cpp
    ../../profhal/adx/wrapper/hdc_api.cpp
    ../../driver/channel/ai_drv_prof_api.cpp
    ../../transport/prof_channel.cpp
    ../../profhal/adx/wrapper/memory_utils.cpp
    ${hdcCpp}
    ${CppPath}
)

add_library(ascend_devprof SHARED
    ${msprofCpp}
)

target_include_directories(ascend_devprof PRIVATE
    ${RUNTIME_DIR}/src/inc/
    ${RUNTIME_DIR}/src/dfx/msprof/inc/toolchain
    ${RUNTIME_DIR}/src/dfx/msprof/inc
    ${LIBC_SEC_HEADER}
    ${RUNTIME_DIR}/include/driver
    ${RUNTIME_DIR}/include/external
    ${RUNTIME_DIR}/src/dfx/error_manager
    ../../
    ../../msprof/
    ../../msprof/drvprof
    ../../msprof/drvprof/include
    ../../msprof/devprof/include
    ../../msprof/common/include
    ../../msprof/platform/include
    ../../msprof/engine/include
    ../../common
    ../../common/validation
    ../../common/errno
    ../../common/logger
    ../../common/queue
    ../../common/singleton
    ../../common/utils
    ../../common/cmd_log
    ../../common/json
    ${PROF_BASIC_DIR}/osal
    ../../common/config
    ../../common/config/open
    ../../driver/inc
    ../../depend/include/stub
    ../../message
    ../../transport
    ../../profhal/adx/inc
    ../../profhal/halinc
    ../../profimpl/inc
    ../../msprof/msproftx/mstx/inc
    ../../profimpl/platform
    ../../profimpl/platform/open
    ../../profimpl/adapter/inc
    ../../profimpl/collect/job_wrapper/include
    ../../streamio/client/include
    ../../streamio/common/include
    ../../driver/inc
    ${CMAKE_CURRENT_SOURCE_DIR}/../
    ${CMAKE_BINARY_DIR}/proto/profiler_proto
)

target_compile_options(ascend_devprof PRIVATE
    -fPIC
    -fstack-protector-all
    -fvisibility-inlines-hidden
    -fno-strict-aliasing
    -fno-common
    -Wfloat-equal
    -Wextra
    -Wall
    $<$<AND:$<STREQUAL:${TARGET_SYSTEM_NAME},Windows>,$<STREQUAL:${CMAKE_CONFIGURATION_TYPES},Debug>>:/MTd>
    $<$<AND:$<STREQUAL:${TARGET_SYSTEM_NAME},Windows>,$<STREQUAL:${CMAKE_CONFIGURATION_TYPES},Release>>:/MT>
)

target_compile_definitions(ascend_devprof PRIVATE
    MSPROF_LIB
    google=ascend_private
    RC_MODE
)

target_link_libraries(ascend_devprof PRIVATE
    $<BUILD_INTERFACE:intf_pub>
    $<BUILD_INTERFACE:mmpa_headers>
    $<BUILD_INTERFACE:slog_headers>
    $<BUILD_INTERFACE:adump_headers>
    $<BUILD_INTERFACE:msprof_headers>
    ${linklibs}
    c_sec
    unified_dlog
    mmpa
    ascend_hal
    ascend_protobuf_static
    $<$<STREQUAL:${TARGET_SYSTEM_NAME},Android>:log>
)

add_dependencies(ascend_devprof profiler_proto)

else()

    add_library(ascend_devprof SHARED
        ../devprof/src/devprof_api.cpp
    )

    target_include_directories(ascend_devprof PRIVATE
        ../devprof/include
        ../../common
        ../../common/logger
        ../../common/errno
    )

    target_compile_options(ascend_devprof PRIVATE
        -fPIC
        -fstack-protector-all
        -fvisibility-inlines-hidden
        -fno-strict-aliasing
        -fno-common
        -Wfloat-equal
        -Wextra
        -Wall
    )
    target_compile_definitions(ascend_devprof PRIVATE
        MSPROF_LIB
        google=ascend_private
        EP_MODE
    )
    target_link_libraries(ascend_devprof PRIVATE
        $<BUILD_INTERFACE:intf_pub>
        $<BUILD_INTERFACE:slog_headers>
        $<BUILD_INTERFACE:msprof_headers>
        unified_dlog
    )

endif()
    
target_link_options(ascend_devprof PRIVATE
    -Wl,-z,relro,-z,now,-z,noexecstack
    -Wl,-Bsymbolic
    -Wl,--exclude-libs=ALL
)

set_target_properties(ascend_devprof
    PROPERTIES
    OUTPUT_NAME ascend_devprof
    LIBRARY_OUTPUT_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/
)

install(TARGETS ascend_devprof OPTIONAL
    LIBRARY DESTINATION ${INSTALL_LIBRARY_DIR}
)
endif()
####################### libascend_devprof.so ###########################
