# -----------------------------------------------------------------------------------------------------------
# Copyright (c) 2025 Huawei Technologies Co., Ltd.
# This program is free software, you can redistribute it and/or modify it under the terms and conditions of
# CANN Open Software License Agreement Version 2.0 (the "License").
# Please refer to the License for details. You may not use this file except in compliance with the License.
# THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
# INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
# See LICENSE in the root of the software repository for the full text of the License.
# -----------------------------------------------------------------------------------------------------------
set(hdcCpp
    ../profhal/adx/stub/adx_prof_api.cpp
    ../profhal/adx/wrapper/hdc_api.cpp
    ../profhal/adx/wrapper/memory_utils.cpp
)

####################### libprofimpl.so ###########################
set(profimplCpp
    ../analyze/src/analyzer.cpp
    ../analyze/src/analyzer_base.cpp
    ../analyze/src/analyzer_ge.cpp
    ../analyze/src/analyzer_hwts.cpp
    ../analyze/src/analyzer_ffts.cpp
    ../analyze/src/analyzer_ts.cpp
    ../analyze/src/analyzer_rt.cpp
    ../analyze/src/op_desc_parser.cpp
    ../common/cmd_log/cmd_log.cpp
    ../common/config/open/config_manager.cpp
    ../common/config/feature_manager.cpp
    ../common/memory/chunk_pool.cpp
    ../common/platform/platform.cpp
    ../common/platform/platform_open.cpp
    ../common/socket/local_socket.cpp
    ../common/statistics/perf_count.cpp
    ../common/thread/thread.cpp
    ../common/thread/thread_pool.cpp
    ../common/utils/utils.cpp
    ../common/json/json.cpp
    ${PROF_BASIC_DIR}/osal/osal.c
    ../common/validation/param_validation.cpp
    ../common/validation/param_validation_open.cpp
    ../common/json/json.cpp
    ../driver/channel/ai_drv_prof_api.cpp
    ../driver/devmgmt/ai_drv_dev_api.cpp
    ../driver/devmgmt/ai_drv_dev_api_open.cpp
    ../driver/devmgmt/ai_drv_dsmi_api.cpp
    ../driver/devmgmt/ai_drv_dsmi_api_open.cpp
    ../profimpl/collect/job_wrapper/src/collection_job.cpp
    ../profimpl/collect/job_wrapper/src/collection_register.cpp
    ../profimpl/collect/job_wrapper/src/job_device_soc.cpp
    ../profimpl/collect/job_wrapper/src/job_factory.cpp
    ../profimpl/collect/job_wrapper/src/prof_channel_manager.cpp
    ../profimpl/collect/job_wrapper/src/prof_comm_job.cpp
    ../profimpl/collect/job_wrapper/src/prof_soc_pmu_job.cpp
    ../profimpl/collect/job_wrapper/src/prof_l2cache_job.cpp
    ../profimpl/collect/job_wrapper/src/prof_ts_job.cpp
    ../profimpl/collect/job_wrapper/src/prof_stars_job.cpp
    ../profimpl/collect/job_wrapper/src/prof_ccu_job.cpp
    ../profimpl/collect/job_wrapper/src/prof_hwts_log_job.cpp
    ../profimpl/collect/job_wrapper/src/prof_instr_perf_job.cpp
    ../profimpl/collect/job_wrapper/src/prof_biu_perf_job.cpp
    ../profimpl/collect/job_wrapper/src/prof_aicore_job.cpp
    ../profimpl/collect/job_wrapper/src/prof_aicpu_job.cpp
    ../profimpl/collect/job_wrapper/src/prof_sys_info_job.cpp
    ../profimpl/collect/job_wrapper/src/prof_hardware_mem_job.cpp
    ../profimpl/collect/job_wrapper/src/prof_hardware_mem_job_open.cpp
    ../profimpl/collect/job_wrapper/src/prof_dvpp_job.cpp
    ../profimpl/collect/job_wrapper/src/prof_lpm_job.cpp
    ../profimpl/collect/job_wrapper/src/prof_inter_connection_job.cpp
    ../profimpl/collect/job_wrapper/src/prof_io_job.cpp
    ../profimpl/collect/job_wrapper/src/prof_timer.cpp
    ../profimpl/collect/job_wrapper/src/prof_perf_job.cpp
    ../profimpl/collect/job_wrapper/src/prof_host_job.cpp
    ../profimpl/collect/job_wrapper/src/prof_diagnostic_job.cpp
    ../profimpl/collect/job_wrapper/src/prof_adprof_job.cpp
    ../profimpl/collect/job_wrapper/src/prof_adprof_job_open.cpp
    ../profimpl/collect/job_wrapper/src/prof_drv_event.cpp
    ../profimpl/collect/job_wrapper/src/adprof_collector_proxy.cpp
    ../msprof/common/src/receive_data.cpp
    ../msprof/common/src/msprof_reporter.cpp
    ../msprof/dynamic_profiling/src/dyn_prof_server.cpp
    ../msprof/dynamic_profiling/src/dyn_prof_thread.cpp
    ../msprof/dynamic_profiling/src/dyn_prof_mgr.cpp
    ../msprof/engine/src/prof_acl_mgr.cpp
    ../msprof/engine/src/prof_acl_mgr_open.cpp
    ../msprof/engine/src/uploader_dumper.cpp
    ../msprof/msproftx/src/msprof_tx_manager.cpp
    ../msprof/msproftx/src/msprof_tx_reporter.cpp
    ../msprof/msproftx/src/prof_stamp_pool.cpp
    ../msprof/msproftx/mstx/src/mstx_domain_mgr.cpp
    ../msprof/msproftx/mstx/src/mstx_inject.cpp
    ../msprof/msproftx/mstx/src/mstx_data_handler.cpp
    ../msprof/devprof/src/devprof_drv_aicpu.cpp
    ../msprof/devprof/src/devprof_common.cpp
    ../profimpl/adapter/src/command_handle.cpp
    ../profimpl/adapter/src/msprofiler_impl.cpp
    ../profimpl/adapter/src/msprofiler_adaptor.cpp
    ../profimpl/adapter/src/msproftx_adaptor.cpp
    ../profimpl/adapter/src/msprofiler_acl_api.cpp
    ../profimpl/adapter/src/json_parser.cpp
    ../profimpl/report/prof_reporter_mgr.cpp
    ../profimpl/aicpu/prof_aicpu_api.cpp
    ../profimpl/aicpu/prof_hal_plugin.cpp
    ../profimpl/platform/platform_interface.cpp
    ../profimpl/platform/base_analyzer.cpp
    ../profimpl/platform/mini_v3_platform.cpp
    ../profimpl/platform/cloud_v2_platform.cpp
    ../profimpl/platform/cloud_platform.cpp
    ../profimpl/platform/dc_platform.cpp
    ../task_handle/src/device.cpp
    ../task_handle/src/info_json.cpp
    ../task_handle/src/prof_manager.cpp
    ../task_handle/src/prof_params_adapter.cpp
    ../task_handle/src/prof_params_adapter_open.cpp
    ../task_handle/src/prof_task.cpp
    ../task_handle/src/task_relationship_mgr.cpp
    ../transport/file_ageing.cpp
    ../transport/file_ageing_open.cpp
    ../transport/file_slice.cpp
    ../transport/file_transport.cpp
    ../transport/pipe_transport.cpp
    ../transport/parser_transport.cpp
    ../transport/prof_channel.cpp
    ../transport/uploader.cpp
    ../transport/uploader_mgr.cpp
    ../transport/hash_data.cpp
    ../transport/hdc/helper_transport.cpp
    ../transport/ctrl_files_dumper.cpp
    ${CppPath}
)

set(profimplInc
    ${RUNTIME_DIR}/graphengine/inc/external
    ${RUNTIME_DIR}/graphengine/inc/framework/common
    ${RUNTIME_DIR}/inc
    ${RUNTIME_DIR}/pkg_inc/aicpu
    ${RUNTIME_DIR}/src/queue_schedule/dgwclient/inc
    ${RUNTIME_DIR}/include/driver
    ${RUNTIME_DIR}/include/external
    ${RUNTIME_DIR}/include/external/acl
    ${LIBC_SEC_HEADER}
    ${RUNTIME_DIR}/src/inc
    ${RUNTIME_DIR}/src/dfx/error_manager
    ${RUNTIME_DIR}/src/dfx/msprof/inc/toolchain
    ../msprof/dynamic_profiling/include
    ../msprof/engine/include
    ../msprof/common/include
    ../msprof/drvprof/include
    ../msprof/devprof/include
    ../msprof/platform/include
    ../msprof/msproftx/include
    ../msprof/msproftx/mstx/inc
    ../analyze/inc
    ../common
    ../common/errno
    ../common/json
    ${PROF_BASIC_DIR}/osal
    ../common/logger
    ../common/queue
    ../common/singleton
    ../common/utils
    ../common/config
    ../common/config/open
    ../common/validation
    ../common/statistics
    ../common/platform
    ../profhal/adx/inc
    ../profhal/halinc
    ../profimpl/adapter/inc
    ../profimpl/report
    ../profimpl/aicpu
    ../profimpl/platform
    ../profimpl/platform/open
    ../profimpl/inc
    ../msprofiler/
    ../msprof/common/include
    ../message
    ../transport
    ../task_handle/include
    ../driver/inc
    ../profimpl/collect/job_wrapper/include
    ${CMAKE_CURRENT_SOURCE_DIR}/../
)

set(profimplFwcSrc
    ${profimplCpp}
)

add_library(profimpl_fwk_share SHARED
    ${profimplFwcSrc}
    ../depend/wrapper/error_manager/msprof_error_manager.cpp
    ${hdcCpp}
)

target_include_directories(profimpl_fwk_share PRIVATE
    ${profimplInc}
    ${RUNTIME_DIR}/graphengine/inc
    ${RUNTIME_DIR}/graphengine/inc/framework
    ../depend/include/wrapper
    ../profapi/inc
)

set_target_properties(profimpl_fwk_share
    PROPERTIES
    OUTPUT_NAME $<IF:$<STREQUAL:${TARGET_SYSTEM_NAME},Windows>,libprofimpl,profimpl>
    LIBRARY_OUTPUT_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/../
)

target_compile_definitions(profimpl_fwk_share PRIVATE
    $<$<STREQUAL:${CMAKE_BUILD_TYPE},Debug>:MSPROF_DEBUG>
    $<$<STREQUAL:${TARGET_SYSTEM_NAME},Windows>:NOMINMAX>
    $<$<STREQUAL:${TARGET_SYSTEM_NAME},Windows>:WIN32>
)

target_compile_options(profimpl_fwk_share PRIVATE
    -fPIC
    -shared
    -fstack-protector-all
    -fno-strict-aliasing
    -fno-common
    -Wall
    -Wextra
    -Wfloat-equal
    $<$<CONFIG:Release>:-D_FORTIFY_SOURCE=2 -Os>
    $<$<CONFIG:Debug>:-D_FORTIFY_SOURCE=2 -Os>
    $<$<AND:$<STREQUAL:${TARGET_SYSTEM_NAME},Windows>,$<STREQUAL:${CMAKE_CONFIGURATION_TYPES},Debug>>:/MTd>
    $<$<AND:$<STREQUAL:${TARGET_SYSTEM_NAME},Windows>,$<STREQUAL:${CMAKE_CONFIGURATION_TYPES},Release>>:/MT>
)

target_link_options(profimpl_fwk_share PRIVATE
    -Wl,-z,relro,-z,now,-z,noexecstack
    -Wl,-Bsymbolic
    -Wl,--exclude-libs=ALL
)

if (PRODUCT)
    if (${TARGET_SYSTEM_NAME} STREQUAL "Windows")
        target_link_libraries(profimpl_fwk_share PRIVATE
            ascend_hal
        )
    else()
        target_link_libraries(profimpl_fwk_share PRIVATE
            ascend_hal_stub
        )
    endif()
endif()

target_link_libraries(profimpl_fwk_share PRIVATE
    $<BUILD_INTERFACE:intf_pub>
    $<BUILD_INTERFACE:mmpa_headers>
    $<BUILD_INTERFACE:msprof_headers>
    $<BUILD_INTERFACE:adump_headers>
    $<BUILD_INTERFACE:slog_headers>
    $<BUILD_INTERFACE:npu_runtime_headers>
    -Wl,--no-as-needed
    c_sec
    alog
    mmpa
    ascend_hal_stub
    error_manager
    -Wl,--as-needed
)

install(TARGETS profimpl_fwk_share OPTIONAL
    LIBRARY DESTINATION ${INSTALL_LIBRARY_DIR}
)
####################### libprofimpl.so ###########################

####################### libprofimpl.so for device ###########################
 
set(devprofimplCpp
    ../msprof/common/src/receive_data.cpp
    ../msprof/devprof/src/devprof_drv_aicpu.cpp
    ../msprof/devprof/src/devprof_drv_adprof.cpp
    ../msprof/devprof/src/devprof_common.cpp
    ../msprof/devprof/src/adprof_collector.cpp
    ../msprof/devprof/src/devprof_msprof_api.cpp
    ../msprof/devprof/src/devprof_adprof_api.cpp
    ${PROF_BASIC_DIR}/osal/osal.c
    ../common/config/open/config_manager.cpp
    ../common/memory/chunk_pool.cpp
    ../common/statistics/perf_count.cpp
    ../common/thread/thread.cpp
    ../common/thread/thread_pool.cpp
    ../common/utils/utils.cpp
    ../common/cmd_log/cmd_log.cpp
    ../common/validation/param_validation.cpp
    ../common/validation/param_validation_open.cpp
    ../common/platform/platform.cpp
    ../common/platform/platform_open.cpp
    ../depend/stub/error_manager/msprof_error_manager_stub.cpp
    ../driver/devmgmt/ai_drv_dev_api.cpp
    ../driver/devmgmt/ai_drv_dev_api_open.cpp
    ../message/codec.cpp
    ../common/json/json.cpp
    ../transport/hdc/helper_transport.cpp
    ../transport/uploader.cpp
    ../transport/uploader_mgr.cpp
    ../transport/hash_data.cpp
    ../profimpl/platform/platform_interface.cpp
    ../profimpl/platform/base_analyzer.cpp
    ../profimpl/adapter/src/json_parser.cpp
    ../profimpl/collect/job_wrapper/src/prof_perf_job.cpp
    ../profimpl/collect/job_wrapper/src/adprof_collector_proxy.cpp
    ../profimpl/collect/job_wrapper/src/prof_hardware_mem_job.cpp
    ../profimpl/collect/job_wrapper/src/prof_hardware_mem_job_open.cpp
    ../profimpl/collect/job_wrapper/src/prof_sys_info_job.cpp
    ../profimpl/collect/job_wrapper/src/prof_timer.cpp
    ../profimpl/collect/job_wrapper/src/collection_job.cpp
    ../profimpl/collect/job_wrapper/src/prof_comm_job.cpp
    ../profimpl/collect/job_wrapper/src/prof_channel_manager.cpp
    ../profhal/adx/stub/adx_prof_api.cpp
    ../profhal/adx/wrapper/hdc_api.cpp
    ../driver/channel/ai_drv_prof_api.cpp
    ../transport/prof_channel.cpp
    ../profhal/adx/wrapper/memory_utils.cpp
    ${CppPath}
)
 
add_library(profimpl_share_device SHARED
    ${devprofimplCpp}
)
 
target_include_directories(profimpl_share_device PRIVATE
    ${RUNTIME_DIR}/src/inc/
    ${RUNTIME_DIR}/src/dfx/msprof/inc/toolchain
    ${RUNTIME_DIR}/src/dfx/msprof/inc
    ${RUNTIME_DIR}/third_party/libc_sec/include
    ${RUNTIME_DIR}/include/driver
    ${RUNTIME_DIR}/include/external
    ${RUNTIME_DIR}/src/dfx/error_manager
    ../msprof/
    ../msprof/drvprof
    ../msprof/drvprof/include
    ../msprof/devprof/include
    ../msprof/common/include
    ../msprof/platform/include
    ../msprof/engine/include
    ../
    ../common
    ../common/validation
    ../common/errno
    ../common/logger
    ../common/queue
    ../common/singleton
    ../common/utils
    ../common/cmd_log
    ../common/json
    ${PROF_BASIC_DIR}/osal
    ../common/config
    ../common/config/open
    ../driver/inc
    ../depend/include/stub
    ../message
    ../transport
    ../profhal/adx/inc
    ../profhal/halinc
    ../profimpl/inc
    ../msprof/msproftx/mstx/inc
    ../profimpl/platform
    ../profimpl/platform/open
    ../profimpl/adapter/inc
    ../profimpl/collect/job_wrapper/include
    ../driver/inc
    ${CMAKE_CURRENT_SOURCE_DIR}
)
 
target_compile_definitions(profimpl_share_device PRIVATE
    MSPROF_LIB
    google=ascend_private
    EP_MODE
)
 
set_target_properties(profimpl_share_device
    PROPERTIES
    OUTPUT_NAME profimpl
    LIBRARY_OUTPUT_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/
)
 
target_compile_options(profimpl_share_device PRIVATE
    -fPIC
    -shared
    -fstack-protector-all
    -fno-strict-aliasing
    -fno-common
    -Wall
    -Wextra
    -Wfloat-equal
    $<$<CONFIG:Release>:-D_FORTIFY_SOURCE=2 -Os>
    $<$<CONFIG:Debug>:-D_FORTIFY_SOURCE=2 -Os>
)
 
target_link_options(profimpl_share_device PRIVATE
    -Wl,-z,relro,-z,now,-z,noexecstack
    -Wl,-Bsymbolic
    -Wl,--exclude-libs=ALL
)
 
target_link_libraries(profimpl_share_device PRIVATE
    $<BUILD_INTERFACE:intf_pub>
    $<BUILD_INTERFACE:mmpa_headers>
    $<BUILD_INTERFACE:slog_headers>
    $<BUILD_INTERFACE:adump_headers>
    $<BUILD_INTERFACE:msprof_headers>
    c_sec
    unified_dlog
    mmpa
    ascend_hal_stub
    ascend_protobuf_static
)
 
install(TARGETS profimpl_share_device OPTIONAL
    LIBRARY DESTINATION ${INSTALL_LIBRARY_DIR}
)