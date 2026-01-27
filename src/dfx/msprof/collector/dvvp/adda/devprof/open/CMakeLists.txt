# -----------------------------------------------------------------------------------------------------------
# Copyright (c) 2025 Huawei Technologies Co., Ltd.
# This program is free software, you can redistribute it and/or modify it under the terms and conditions of
# CANN Open Software License Agreement Version 2.0 (the "License").
# Please refer to the License for details. You may not use this file except in compliance with the License.
# THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
# INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
# See LICENSE in the root of the software repository for the full text of the License.
# -----------------------------------------------------------------------------------------------------------
####################### prof_collect begin ###########################
add_custom_target(prof_collect_sh
    COMMAND ${CMAKE_COMMAND} -E copy ${CMAKE_CURRENT_SOURCE_DIR}/../prof_collect.sh ${CMAKE_CURRENT_BINARY_DIR}/../
)

install(FILES
    ${CMAKE_CURRENT_BINARY_DIR}/../prof_collect.sh
    DESTINATION ${INSTALL_LIBRARY_DIR} OPTIONAL
)
####################### prof_collect end ###########################

####################### libdevprof begin ###########################
protobuf_generate(devprof_proto
    CppPath
    HeaderPath
    ${CMAKE_CURRENT_SOURCE_DIR}/../../../proto/profiler.proto
    TARGET
)

set(devProfCppList
    ../../../profhal/adx/wrapper/adx_prof_api.cpp
    ../../../profhal/adx/wrapper/hdc_api.cpp
    ../../../profhal/adx/wrapper/memory_utils.cpp
    ../../../common/config/open/config_manager.cpp
    ../../../common/memory/chunk_pool.cpp
    ../../../common/platform/platform.cpp
    ../../../common/platform/platform_open.cpp
    ../../../common/statistics/perf_count.cpp
    ../../../common/thread/thread.cpp
    ../../../common/thread/thread_pool.cpp
    ../../../common/utils/utils.cpp
    ../../../common/cmd_log/cmd_log.cpp
    ../../../common/json/json.cpp
    ${PROF_BASIC_DIR}/osal/osal.c
    ../../../common/validation/param_validation.cpp
    ../../../common/validation/param_validation_open.cpp
    ../../../depend/stub/error_manager/msprof_error_manager_stub.cpp
    ../device/src/collect_engine.cpp
    ../device/src/collection_entry.cpp
    ../device/src/prof_device_core.cpp
    ../device/src/prof_job_handler.cpp
    ../device/src/prof_msg_handler.cpp
    ../device/src/task_manager.cpp
    ../../../driver/channel/ai_drv_prof_api.cpp
    ../../../driver/devmgmt/ai_drv_dev_api.cpp
    ../../../driver/devmgmt/ai_drv_dev_api_open.cpp
    ../../../profimpl/collect/job_wrapper/src/collection_job.cpp
    ../../../profimpl/collect/job_wrapper/src/collection_register.cpp
    ../../../profimpl/collect/job_wrapper/src/prof_channel_manager.cpp
    ../../../profimpl/collect/job_wrapper/src/prof_comm_job.cpp
    ../../../profimpl/collect/job_wrapper/src/prof_l2cache_job.cpp
    ../../../profimpl/collect/job_wrapper/src/prof_ts_job.cpp
    ../../../profimpl/collect/job_wrapper/src/prof_stars_job.cpp
    ../../../profimpl/collect/job_wrapper/src/prof_ccu_job.cpp
    ../../../profimpl/collect/job_wrapper/src/prof_hwts_log_job.cpp
    ../../../profimpl/collect/job_wrapper/src/prof_instr_perf_job.cpp
    ../../../profimpl/collect/job_wrapper/src/prof_biu_perf_job.cpp
    ../../../profimpl/collect/job_wrapper/src/prof_aicore_job.cpp
    ../../../profimpl/collect/job_wrapper/src/prof_sys_info_job.cpp
    ../../../profimpl/collect/job_wrapper/src/prof_hardware_mem_job.cpp
    ../../../profimpl/collect/job_wrapper/src/prof_hardware_mem_job_open.cpp
    ../../../profimpl/collect/job_wrapper/src/prof_dvpp_job.cpp
    ../../../profimpl/collect/job_wrapper/src/prof_lpm_job.cpp
    ../../../profimpl/collect/job_wrapper/src/prof_inter_connection_job.cpp
    ../../../profimpl/collect/job_wrapper/src/prof_io_job.cpp
    ../../../profimpl/collect/job_wrapper/src/prof_timer.cpp
    ../../../profimpl/collect/job_wrapper/src/prof_perf_job.cpp
    ../../../profimpl/collect/job_wrapper/src/prof_host_job.cpp
    ../../../profimpl/collect/job_wrapper/src/adprof_collector_proxy.cpp
    ../../../profimpl/adapter/src/json_parser.cpp
    ../../../profimpl/platform/platform_interface.cpp
    ../../../profimpl/platform/base_analyzer.cpp
    ../../../message/codec.cpp
    ../../../message/dispatcher.cpp
    ../../../task_handle/src/task_relationship_mgr.cpp
    ../../../transport/hdc/hdc_transport.cpp
    ../../../transport/prof_channel.cpp
    ../../../transport/receiver.cpp
    ../../../transport/uploader.cpp
    ../../../transport/uploader_mgr.cpp
    ../../../transport/hash_data.cpp
    ../../../msprof/devprof/src/adprof_collector.cpp
    ${CppPath}
)

set(devprofHeader
    ${LIBC_SEC_HEADER}
    ${RUNTIME_DIR}/src/dfx/msprof/inc
    ${RUNTIME_DIR}/src/dfx/msprof/inc/toolchain
    ${RUNTIME_DIR}/src/inc/
    ${RUNTIME_DIR}/include/driver
    ${RUNTIME_DIR}/src/dfx/error_manager
    ${RUNTIME_DIR}/abl/ascend_hal/user_space/inc
    ../device/include
    ${CMAKE_CURRENT_SOURCE_DIR}/../
    ../../../
    ../../../message/
    ../../../common
    ../../../common/logger
    ../../../common/validation
    ../../../common/statistics
    ../../../common/platform
    ../../../common/utils
    ../../../common/cmd_log
    ../../../common/queue
    ../../../common/json
    ../../../common/config/open
    ${PROF_BASIC_DIR}/osal
    ../../../common/errno
    ../../../depend/include/stub
    ../../../driver/inc
    ../../../profhal/adx/inc
    ../../../profimpl/collect/job_wrapper/include
    ../../../task_handle/include
    ../../../transport
    ../../../msprof/engine/include
    ../../../msprof/common/include
    ../../../msprof/devprof/include
    ../../../profimpl/adapter/inc
    ../../../profimpl/platform
    ../../../profimpl/platform/open
    ../../../profimpl/inc
    ../../../msprof/msproftx/mstx/inc
    ${CMAKE_BINARY_DIR}/proto/devprof_proto
    ${PROTOBUF_STATIC_PKG_DIR}/include
)

add_library(devprof STATIC
    ${devProfCppList})

set_target_properties(devprof
    PROPERTIES
    OUTPUT_NAME devprof
    WINDOWS_EXPORT_ALL_SYMBOLS TRUE
    LIBRARY_OUTPUT_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/../)

target_compile_options(devprof PRIVATE
    -fPIC
    -fstack-protector-all
    -fvisibility=hidden
    -fvisibility-inlines-hidden
    -fno-strict-aliasing
    -fno-common
    -Wfloat-equal
    -Wextra
    -Wall
    $<$<AND:$<STREQUAL:${TARGET_SYSTEM_NAME},Windows>,$<STREQUAL:${CMAKE_CONFIGURATION_TYPES},Debug>>:/MTd>
    $<$<AND:$<STREQUAL:${TARGET_SYSTEM_NAME},Windows>,$<STREQUAL:${CMAKE_CONFIGURATION_TYPES},Release>>:/MT>
)

target_compile_definitions(devprof PRIVATE
    google=ascend_private
)

target_include_directories(devprof PRIVATE
    ${devprofHeader}
)

target_link_libraries(devprof PRIVATE
    $<BUILD_INTERFACE:intf_pub>
    $<BUILD_INTERFACE:adump_headers>
    $<BUILD_INTERFACE:slog_headers>
    $<BUILD_INTERFACE:mmpa_headers>
    -lm
)

add_dependencies(devprof devprof_proto)
####################### libdevprof end ###########################
