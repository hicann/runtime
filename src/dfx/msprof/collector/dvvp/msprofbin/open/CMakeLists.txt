# -----------------------------------------------------------------------------------------------------------
# Copyright (c) 2025 Huawei Technologies Co., Ltd.
# This program is free software, you can redistribute it and/or modify it under the terms and conditions of
# CANN Open Software License Agreement Version 2.0 (the "License").
# Please refer to the License for details. You may not use this file except in compliance with the License.
# THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
# INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
# See LICENSE in the root of the software repository for the full text of the License.
# -----------------------------------------------------------------------------------------------------------
protobuf_generate(msprofbin_proto
    CppPath
    HeaderPath
    ${CMAKE_CURRENT_SOURCE_DIR}/../../proto/profiler.proto
    TARGET
)

set(msprofBinHeader
    ../include
    ../../
    ../../app
    ${LIBC_SEC_HEADER}
    ${RUNTIME_DIR}/include/driver
    ${RUNTIME_DIR}/inc/aicpu
    ${RUNTIME_DIR}/src/inc/
    ${RUNTIME_DIR}/src/dfx/msprof/inc/toolchain
    ${RUNTIME_DIR}/src/dfx/error_manager
    ${RUNTIME_DIR}/src/dfx/msprof/inc
    ../../common/utils
    ../../msprof/engine/include
    ../../host/include/
    ../../message/
    ../../common
    ../../common/json
    ../../common/logger
    ../../common/queue
    ../../common/statistics
    ../../common/validation
    ../../common/platform
    ../../common/json
    ../../common/config/open
    ${PROF_BASIC_DIR}/osal
    ../../common/errno
    ../../depend/include/stub
    ../../msprof/common/include/
    ../../msprof/dynamic_profiling/include/
    ../../profimpl/adapter/inc
    ../../profimpl/platform
    ../../profimpl/platform/open
    ../../profimpl/collect/job_wrapper/include
    ../../profimpl/inc
    ../../msprof/msproftx/mstx/inc
    ../../profhal/adx/inc
    ../../profhal/halinc
    ../../driver/inc
    ../../task_handle/include
    ../../transport
    ../../profhal/adx/inc
)

set(hdcCpp
    ../../profhal/adx/stub/adx_prof_api.cpp
    ../../profhal/adx/wrapper/hdc_api.cpp
    ../../profhal/adx/wrapper/memory_utils.cpp
)

set(msprofbinCpp
    ../src/msprof_bin.cpp
    ../src/msopprof_manager.cpp
    ../src/msprof_manager.cpp
    ../src/msprof_task.cpp
    ../src/msprof_params_adapter.cpp
    ../src/msprof_params_adapter_open.cpp
    ../src/input_parser.cpp
    ../src/input_parser_open.cpp
    ../src/running_mode.cpp
    ../src/running_mode_open.cpp
    ../../app/application.cpp
    ../../app/env_manager.cpp
    ../../common/cmd_log/cmd_log.cpp
    ../../common/utils/utils.cpp
    ../../common/json/json.cpp
    ${PROF_BASIC_DIR}/osal/osal.c
    ../../common/config/open/config_manager.cpp
    ../../common/memory/chunk_pool.cpp
    ../../common/thread/thread.cpp
    ../../common/thread/thread_pool.cpp
    ../../common/socket/local_socket.cpp
    ../../common/statistics/perf_count.cpp
    ../../common/validation/param_validation.cpp
    ../../common/validation/param_validation_open.cpp
    ../../common/platform/platform.cpp
    ../../common/platform/platform_open.cpp
    ../../common/json/json.cpp
    ../../depend/stub/error_manager/msprof_error_manager_stub.cpp
    ../../driver/devmgmt/ai_drv_dev_api.cpp
    ../../driver/devmgmt/ai_drv_dev_api_open.cpp
    ../../driver/devmgmt/ai_drv_dsmi_api.cpp
    ../../driver/devmgmt/ai_drv_dsmi_api_open.cpp
    ../../driver/channel/ai_drv_prof_api.cpp
    ../../profimpl/collect/job_wrapper/src/collection_job.cpp
    ../../profimpl/collect/job_wrapper/src/collection_register.cpp
    ../../profimpl/collect/job_wrapper/src/job_factory.cpp
    ../../profimpl/collect/job_wrapper/src/job_device_rpc.cpp
    ../../profimpl/collect/job_wrapper/src/prof_comm_job.cpp
    ../../profimpl/collect/job_wrapper/src/prof_soc_pmu_job.cpp
    ../../profimpl/collect/job_wrapper/src/prof_l2cache_job.cpp
    ../../profimpl/collect/job_wrapper/src/prof_ts_job.cpp
    ../../profimpl/collect/job_wrapper/src/prof_stars_job.cpp
    ../../profimpl/collect/job_wrapper/src/prof_ccu_job.cpp
    ../../profimpl/collect/job_wrapper/src/prof_hwts_log_job.cpp
    ../../profimpl/collect/job_wrapper/src/prof_instr_perf_job.cpp
    ../../profimpl/collect/job_wrapper/src/prof_biu_perf_job.cpp
    ../../profimpl/collect/job_wrapper/src/prof_aicore_job.cpp
    ../../profimpl/collect/job_wrapper/src/prof_aicpu_job.cpp
    ../../profimpl/collect/job_wrapper/src/prof_sys_info_job.cpp
    ../../profimpl/collect/job_wrapper/src/prof_hardware_mem_job.cpp
    ../../profimpl/collect/job_wrapper/src/prof_hardware_mem_job_open.cpp
    ../../profimpl/collect/job_wrapper/src/prof_dvpp_job.cpp
    ../../profimpl/collect/job_wrapper/src/prof_lpm_job.cpp
    ../../profimpl/collect/job_wrapper/src/prof_inter_connection_job.cpp
    ../../profimpl/collect/job_wrapper/src/prof_io_job.cpp
    ../../profimpl/collect/job_wrapper/src/prof_timer.cpp
    ../../profimpl/collect/job_wrapper/src/prof_perf_job.cpp
    ../../profimpl/collect/job_wrapper/src/prof_host_job.cpp
    ../../profimpl/collect/job_wrapper/src/prof_diagnostic_job.cpp
    ../../profimpl/collect/job_wrapper/src/prof_aicpu_job.cpp
    ../../profimpl/collect/job_wrapper/src/prof_channel_manager.cpp
    ../../profimpl/collect/job_wrapper/src/prof_adprof_job.cpp
    ../../profimpl/collect/job_wrapper/src/prof_adprof_job_open.cpp
    ../../profimpl/collect/job_wrapper/src/prof_drv_event.cpp
    ../../profimpl/collect/job_wrapper/src/job_device_soc.cpp
    ../../profimpl/collect/job_wrapper/src/adprof_collector_proxy.cpp
    ../../msprof/dynamic_profiling/src/dyn_prof_client.cpp
    ../../profimpl/adapter/src/json_parser.cpp
    ../../profimpl/platform/platform_interface.cpp
    ../../profimpl/platform/base_analyzer.cpp
    ../../profimpl/platform/cloud_platform.cpp
    ../../profimpl/platform/cloud_v2_platform.cpp
    ../../profimpl/platform/dc_platform.cpp
    ../../profimpl/platform/mini_v3_platform.cpp
    ../../message/codec.cpp
    ../../transport/file_transport.cpp
    ../../transport/pipe_transport.cpp
    ../../transport/prof_channel.cpp
    ../../transport/uploader_mgr.cpp
    ../../transport/hash_data.cpp
    ../../transport/uploader.cpp
    ../../transport/file_ageing.cpp
    ../../transport/file_ageing_open.cpp
    ../../transport/file_slice.cpp
    ../../task_handle/src/info_json.cpp
    ../../task_handle/src/task_relationship_mgr.cpp
    ../../transport/hdc/data_handle.cpp
    ../../transport/hdc/hdc_transport.cpp
    ../../transport/hdc/helper_transport.cpp
    ../../transport/hdc/device_transport.cpp
    ../../transport/hdc/platform/rpc/dev_mgr_api.cpp
    ${hdcCpp}
    ${CppPath}
)

if(${TARGET_SYSTEM_NAME} STREQUAL "Windows")
set(msprofbinCpp
    ../src/win/msprof_bin.cpp
)
endif()
add_executable(msprofbin
    ${msprofbinCpp}
)
target_include_directories(msprofbin PRIVATE
    ${msprofBinHeader}
    ${CMAKE_CURRENT_SOURCE_DIR}/../
    ${CMAKE_BINARY_DIR}/proto/msprofbin_proto
)


target_compile_options(msprofbin PRIVATE
    -fPIE
    -fno-strict-aliasing
    -fno-common
    -Wall
    $<$<NOT:$<STREQUAL:${TARGET_SYSTEM_NAME},Windows>>:-Wfloat-equal>
    $<$<NOT:$<STREQUAL:${TARGET_SYSTEM_NAME},Windows>>:-Wextra>
    $<$<NOT:$<STREQUAL:${TARGET_SYSTEM_NAME},Windows>>:-Wno-unused-parameter>
    $<$<NOT:$<STREQUAL:${TARGET_SYSTEM_NAME},Windows>>:-Wno-missing-field-initializers>
    $<$<NOT:$<STREQUAL:${TARGET_SYSTEM_NAME},Windows>>:-Werror>
    $<$<AND:$<STREQUAL:${TARGET_SYSTEM_NAME},Windows>,$<STREQUAL:${CMAKE_CONFIGURATION_TYPES},Debug>>:/MTd>
    $<$<AND:$<STREQUAL:${TARGET_SYSTEM_NAME},Windows>,$<STREQUAL:${CMAKE_CONFIGURATION_TYPES},Release>>:/MT>
)

target_compile_definitions(msprofbin PRIVATE
    SECUREC_USING_STD_SECURE_LIB=0
    google=ascend_private
    $<$<STREQUAL:${TARGET_SYSTEM_NAME},Windows>:NOMINMAX>
)

target_link_options(msprofbin PRIVATE
    -Wl,-Bsymbolic
    -Wl,--exclude-libs=ALL
    -ldl
)

target_link_libraries(msprofbin PRIVATE
    $<BUILD_INTERFACE:mmpa_headers>
    $<BUILD_INTERFACE:adump_headers>
    $<BUILD_INTERFACE:slog_headers>
    $<BUILD_INTERFACE:msprofbinOnetrack_pub>
)

set_target_properties(msprofbin
    PROPERTIES
    OUTPUT_NAME msprof
    LIBRARY_OUTPUT_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/../
)

install(TARGETS msprofbin OPTIONAL
    LIBRARY DESTINATION ${INSTALL_LIBRARY_DIR}
)

### onetrack target interface

add_library(msprofbinOnetrack_pub INTERFACE)

target_link_libraries(msprofbinOnetrack_pub INTERFACE
    $<BUILD_INTERFACE:intf_pub>
    c_sec
    unified_dlog
    mmpa
    $<IF:$<STREQUAL:${TARGET_SYSTEM_NAME},Windows>,ascend_hal,ascend_hal_stub>
    ascend_protobuf_static
    -lpthread
    -ldl
)

add_dependencies(msprofbin msprofbin_proto)