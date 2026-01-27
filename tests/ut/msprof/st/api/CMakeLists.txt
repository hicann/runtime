# -----------------------------------------------------------------------------------------------------------
# Copyright (c) 2025 Huawei Technologies Co., Ltd.
# This program is free software, you can redistribute it and/or modify it under the terms and conditions of
# CANN Open Software License Agreement Version 2.0 (the "License").
# Please refer to the License for details. You may not use this file except in compliance with the License.
# THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
# INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
# See LICENSE in the root of the software repository for the full text of the License.
# -----------------------------------------------------------------------------------------------------------
set(API_STUB_DIR
    ${TOP_DIR}/tests/ut/msprof/st/stub
)

set(LLT_DATA_DIR
    ${TOP_DIR}/tests/ut/msprof/st/data
)

set(TEST_STUB_SRC
    ${API_STUB_DIR}/device/data_report_manager.cpp
    ${API_STUB_DIR}/device/data_report.cpp
    ${API_STUB_DIR}/device/device_drv_prof_stub.cpp
    ${API_STUB_DIR}/device/device_simulator_manager.cpp
    ${API_STUB_DIR}/device/device_simulator.cpp
    ${API_STUB_DIR}/device/stars_device_simulator.cpp
    ${API_STUB_DIR}/device/david_device_simulator.cpp
    ${API_STUB_DIR}/device/david_v121_device_simulator.cpp
    ${API_STUB_DIR}/device/cloud_device_simulator.cpp
    ${API_STUB_DIR}/device/dc_device_simulator.cpp
    ${API_STUB_DIR}/device/mdc_device_simulator.cpp
    ${API_STUB_DIR}/device/mdc_lite_device_simulator.cpp
    ${API_STUB_DIR}/device/mini_device_simulator.cpp
    ${API_STUB_DIR}/device/tiny_device_simulator.cpp
    ${API_STUB_DIR}/device/nano_device_simulator.cpp
    ${API_STUB_DIR}/device/mdc_mini_v3_device_simulator.cpp
    ${API_STUB_DIR}/device/mini_stars_device_simulator.cpp
    ${API_STUB_DIR}/host/msprof_stub.cpp
    ${API_STUB_DIR}/mmpa_stub.cpp
    ${API_STUB_DIR}/hdc-log-stub.cpp
    ${API_STUB_DIR}/ide-cmd-stub.cpp
    ${API_STUB_DIR}/ide_hdc_stub.cc
    ${API_STUB_DIR}/error_manager_stub.cpp
    stub/mmpa_stub.cpp
)

set(MSPROFILER_SRC_FILE
    ${MSPROF_SOURCE_DIR}/dvvp/msprofiler/prof_acl_api.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/msprofiler/prof_api_common.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/msprofiler/prof_ge_core.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/msprofiler/prof_acl_core.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/msprofiler/prof_api_runtime.cpp
)
set(MSPROFAPI_SRC_FILE
    ${MSPROF_SOURCE_DIR}/dvvp/profapi/src/prof_plugin_manager.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/profapi/src/prof_plugin.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/profapi/src/prof_cann_plugin.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/profapi/src/prof_atls_plugin.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/profapi/src/prof_tx_plugin.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/profapi/src/prof_acl_plugin.cpp
)
set(HDC_SRC_FILE
    ${MSPROF_SOURCE_DIR}/dvvp/profhal/adx/stub/adx_prof_api.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/profhal/adx/wrapper/hdc_api.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/profhal/adx/wrapper/memory_utils.cpp
)

set(PROFIMPL_SRC_FILE
    ${MSPROF_SOURCE_DIR}/dvvp/analyze/src/analyzer.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/analyze/src/analyzer_base.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/analyze/src/analyzer_ge.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/analyze/src/analyzer_hwts.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/analyze/src/analyzer_ffts.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/analyze/src/analyzer_ts.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/analyze/src/analyzer_rt.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/analyze/src/op_desc_parser.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/common/cmd_log/cmd_log.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/common/config/closed/config_manager.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/common/config/feature_manager.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/common/memory/chunk_pool.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/common/platform/platform.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/common/socket/local_socket.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/common/statistics/perf_count.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/common/thread/thread.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/common/thread/thread_pool.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/common/json/json.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/common/utils/utils.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/common/validation/param_validation.cpp
    ${MSPROF_SOURCE_DIR}/basic/osal/osal.c
    ${MSPROF_SOURCE_DIR}/dvvp/driver/channel/ai_drv_prof_api.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/driver/devmgmt/ai_drv_dev_api.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/driver/devmgmt/ai_drv_dsmi_api.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/profimpl/collect/job_wrapper/src/collection_job.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/profimpl/collect/job_wrapper/src/collection_register.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/profimpl/collect/job_wrapper/src/job_device_soc.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/profimpl/collect/job_wrapper/src/job_factory.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/profimpl/collect/job_wrapper/src/prof_channel_manager.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/profimpl/collect/job_wrapper/src/prof_comm_job.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/profimpl/collect/job_wrapper/src/prof_hardware_mem_job.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/profimpl/collect/job_wrapper/src/prof_dvpp_job.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/profimpl/collect/job_wrapper/src/prof_lpm_job.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/profimpl/collect/job_wrapper/src/prof_inter_connection_job.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/profimpl/collect/job_wrapper/src/prof_io_job.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/profimpl/collect/job_wrapper/src/prof_ts_job.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/profimpl/collect/job_wrapper/src/prof_stars_job.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/profimpl/collect/job_wrapper/src/prof_ccu_job.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/profimpl/collect/job_wrapper/src/prof_hwts_log_job.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/profimpl/collect/job_wrapper/src/prof_instr_perf_job.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/profimpl/collect/job_wrapper/src/prof_biu_perf_job.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/profimpl/collect/job_wrapper/src/prof_aicore_job.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/profimpl/collect/job_wrapper/src/prof_aicpu_job.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/profimpl/collect/job_wrapper/src/prof_adprof_job.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/profimpl/collect/job_wrapper/src/prof_sys_info_job.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/profimpl/collect/job_wrapper/src/prof_l2cache_job.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/profimpl/collect/job_wrapper/src/prof_soc_pmu_job.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/profimpl/collect/job_wrapper/src/prof_perf_job.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/profimpl/collect/job_wrapper/src/prof_timer.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/profimpl/collect/job_wrapper/src/prof_host_job.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/profimpl/collect/job_wrapper/src/prof_diagnostic_job.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/profimpl/collect/job_wrapper/src/prof_drv_event.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/profimpl/collect/job_wrapper/src/adprof_collector_proxy.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/message/codec.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/msprof/common/src/receive_data.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/msprof/common/src/msprof_reporter.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/msprof/dynamic_profiling/src/dyn_prof_server.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/msprof/dynamic_profiling/src/dyn_prof_thread.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/msprof/dynamic_profiling/src/dyn_prof_mgr.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/msprof/engine/src/prof_acl_mgr.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/msprof/engine/src/uploader_dumper.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/msprof/msproftx/src/msprof_tx_manager.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/msprof/msproftx/src/msprof_tx_reporter.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/msprof/msproftx/src/prof_stamp_pool.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/profimpl/adapter/src/command_handle.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/profimpl/adapter/src/msproftx_adaptor.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/profimpl/adapter/src/msprofiler_impl.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/profimpl/adapter/src/msprofiler_adaptor.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/profimpl/adapter/src/msprofiler_acl_api.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/profimpl/adapter/src/json_parser.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/profimpl/report/prof_reporter_mgr.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/profimpl/aicpu/prof_aicpu_api.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/profimpl/aicpu/prof_hal_plugin.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/profimpl/platform/platform_interface.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/profimpl/platform/base_analyzer.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/profimpl/platform/cloud_platform.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/profimpl/platform/cloud_v2_platform.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/profimpl/platform/david_platform.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/profimpl/platform/david_v121_platform.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/profimpl/platform/dc_platform.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/profimpl/platform/mdc_lite_platform.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/profimpl/platform/mdc_mini_v3_platform.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/profimpl/platform/mdc_platform.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/profimpl/platform/mini_platform.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/profimpl/platform/mini_v3_platform.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/profimpl/platform/nano_platform.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/profimpl/platform/tiny_v1_platform.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/profimpl/collect/channel/nano_stars_profile.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/profimpl/collect/channel/channel_job.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/task_handle/src/device.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/task_handle/src/info_json.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/task_handle/src/prof_manager.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/task_handle/src/prof_params_adapter.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/task_handle/src/prof_task.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/task_handle/src/task_relationship_mgr.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/transport/file_ageing.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/transport/file_slice.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/transport/file_transport.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/transport/hdc/hdc_transport.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/transport/hdc/helper_transport.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/transport/hdc/platform/soc/dev_mgr_api.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/transport/parser_transport.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/transport/prof_channel.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/transport/uploader.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/transport/uploader_mgr.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/transport/hash_data.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/depend/wrapper/error_manager/msprof_error_manager.cpp
    ${HDC_SRC_FILE}
)

set(DEVPROF_SRC_FILE
    ${MSPROF_SOURCE_DIR}/dvvp/msprof/devprof/src/adprof_collector.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/msprof/devprof/src/devprof_drv_aicpu.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/msprof/devprof/src/devprof_drv_adprof.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/msprof/devprof/src/devprof_common.cpp
    #${MSPROF_SOURCE_DIR}/dvvp/msprof/devprof/src/aicpu_report_hdc.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/msprof/devprof/src/devprof_api.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/msprof/drvprof/src/engine_mgr.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/msprof/drvprof/src/module_job.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/msprof/drvprof/src/rpc_data_handle.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/msprof/drvprof/src/rpc_dumper.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/transport/hdc/hdc_sender.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/streamio/client/src/sender.cpp
)


set(SRC_FILE
    ${PROFIMPL_SRC_FILE}
    ${DEVPROF_SRC_FILE}
)

protobuf_generate(profiler
    CppPath
    HeaderPath
    ${MSPROF_SOURCE_DIR}/dvvp/proto/profiler.proto
)

set(libmsprofHeaderDir
    ${LIBC_SEC_HEADER}
    ${TOP_DIR}/output/third_party/gtest_shared/include
    ${TOP_DIR}/third_party/libc_sec/include
    ${TOP_DIR}/include/driver
    ${TOP_DIR}/include/external
    ${TOP_DIR}/include/external/acl
    ${TOP_DIR}/src/dfx/error_manager
    ${TOP_DIR}/src/inc
    ${TOP_DIR}/pkg_inc/dump
    ${TOP_DIR}/pkg_inc/aicpu
    ${TOP_DIR}/pkg_inc/base
    ${TOP_DIR}/src/dfx/adump/inc/metadef/external
    ${MSPROF_SOURCE_DIR}/dvvp/msprof/msproftx/mstx/inc
    ${MSPROF_SOURCE_DIR}/dvvp/profimpl/platform/closed
    ${MSPROF_SOURCE_DIR}/dvvp/common/config/closed
    ${MSPROF_SOURCE_DIR}/dvvp/profapi/inc
    ${MSPROF_SOURCE_DIR}/dvvp/msprof/devprof/include
)

set(INCLUDE_DIR
    ${libmsprofHeaderDir}
    stub
    data
    testcase/common
    ${API_STUB_DIR}/device
    ${API_STUB_DIR}/host
    ${TOP_DIR}/inc/driver
    ${TOP_DIR}/inc/aicpu
    ${TOP_DIR}/inc/external
    ${TOP_DIR}/inc/external/acl
    ${TOP_DIR}/abl/libc_sec/include
    ${TOP_DIR}/ace/npuruntime/inc
    ${TOP_DIR}/ace/npuruntime/inc/external
    ${TOP_DIR}/abl/msprof/inc
    ${TOP_DIR}/abl/msprof/inc/external
    ${TOP_DIR}/abl/msprof/inc/toolchain
    ${TOP_DIR}/graphengine/inc
    ${TOP_DIR}/graphengine/inc/external
    ${TOP_DIR}/graphengine/inc/framework/common
    ${MSPROF_SOURCE_DIR}/dvvp/profhal/adx/inc
    ${MSPROF_SOURCE_DIR}/dvvp/profhal/halinc
    ${MSPROF_SOURCE_DIR}/dvvp/msprofiler
    ${MSPROF_SOURCE_DIR}/dvvp/msprofbin/include
    ${MSPROF_SOURCE_DIR}/dvvp/msprofbin
    ${MSPROF_SOURCE_DIR}/dvvp/app
    ${MSPROF_SOURCE_DIR}/dvvp/
    ${MSPROF_SOURCE_DIR}/dvvp/analyze/inc
    ${MSPROF_SOURCE_DIR}/dvvp/host/include
    ${MSPROF_SOURCE_DIR}/dvvp/common
    ${MSPROF_SOURCE_DIR}/dvvp/common/errno
    ${MSPROF_SOURCE_DIR}/dvvp/common/logger
    ${MSPROF_SOURCE_DIR}/dvvp/common/statistics
    ${MSPROF_SOURCE_DIR}/dvvp/common/singleton
    ${MSPROF_SOURCE_DIR}/dvvp/common/validation
    ${MSPROF_SOURCE_DIR}/dvvp/common/platform
    ${MSPROF_SOURCE_DIR}/dvvp/common/queue
    ${MSPROF_SOURCE_DIR}/dvvp/common/utils
    ${MSPROF_SOURCE_DIR}/dvvp/common/memory
    ${MSPROF_SOURCE_DIR}/dvvp/common/json
    ${MSPROF_SOURCE_DIR}/dvvp/common/config
    ${MSPROF_SOURCE_DIR}/basic/osal
    ${MSPROF_SOURCE_DIR}/dvvp/transport
    ${MSPROF_SOURCE_DIR}/dvvp/profimpl/collect/job_wrapper/include
    ${MSPROF_SOURCE_DIR}/dvvp/driver/inc
    ${MSPROF_SOURCE_DIR}/dvvp/task_handle/include
    ${MSPROF_SOURCE_DIR}/dvvp/profimpl/adapter/inc
    ${MSPROF_SOURCE_DIR}/dvvp/profimpl/report
    ${MSPROF_SOURCE_DIR}/dvvp/profimpl/aicpu
    ${MSPROF_SOURCE_DIR}/dvvp/profimpl/platform
    ${MSPROF_SOURCE_DIR}/dvvp/profimpl/collect
    ${MSPROF_SOURCE_DIR}/dvvp/profimpl/collect/channel
    ${MSPROF_SOURCE_DIR}/dvvp/profimpl/inc
    ${MSPROF_SOURCE_DIR}/dvvp/stub
    ${MSPROF_SOURCE_DIR}/dvvp/streamio/client/include
    ${MSPROF_SOURCE_DIR}/dvvp/streamio/common/include
    ${MSPROF_SOURCE_DIR}/dvvp/streamio/server/include
    ${MSPROF_SOURCE_DIR}/dvvp/depend/include/stub
    ${MSPROF_SOURCE_DIR}/dvvp/msprof/engine/include
    ${MSPROF_SOURCE_DIR}/dvvp/msprof/msproftx/include
    ${MSPROF_SOURCE_DIR}/dvvp/msprof/platform/include
    ${MSPROF_SOURCE_DIR}/dvvp/msprof/common/include
    ${MSPROF_SOURCE_DIR}/dvvp/msprof/drvprof/include
    ${MSPROF_SOURCE_DIR}/dvvp/msprof/dynamic_profiling/include
    ${MSPROF_SOURCE_DIR}/dvvp/msprof/include
    ${MSPROF_SOURCE_DIR}/dvvp/msprof/devprof/include
    ${MSPROF_SOURCE_DIR}/dvvp/message
    ${MSPROF_SOURCE_DIR}/dvvp/profapi/inc
    ${CMAKE_BINARY_DIR}/proto/profiler
    ${LLT_DATA_DIR}
)

set(TEST_SRC
    stub/acl_api_stub.cpp
    testcase/common/main.cpp
    testcase/common/api_stest.cpp
    testcase/common/api_inner_stest.cpp
)

####################### api_dc_stest ###########################

add_executable(api_dc_stest
    ${TEST_STUB_SRC}
    ${TEST_SRC}
    ${SRC_FILE}
    ${CppPath}
    testcase/api_dc_stest.cpp
)

target_compile_options(api_dc_stest PRIVATE
    -g
    -Wall
    -fno-access-control
)

target_include_directories(api_dc_stest PRIVATE
    ${INCLUDE_DIR}
)

target_compile_definitions(api_dc_stest PRIVATE
    __PROF_LLT
    google=ascend_private
    LLT_DATA_DIR="${LLT_DATA_DIR}"
    API_STEST
    PLATFORM_TYPE=4
    SOC_TYPE="dc"
)

target_link_options(api_dc_stest PRIVATE
   -ldl
   -lpthread
)

target_link_libraries(api_dc_stest PRIVATE
    $<BUILD_INTERFACE:msprof_utestonetrack_pub>
    c_sec
)

set_target_properties(api_dc_stest
    PROPERTIES
    OUTPUT_NAME api_dc_stest
    LIBRARY_OUTPUT_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}
)

####################### api_david_stest ###########################

add_executable(api_david_stest
    ${TEST_STUB_SRC}
    ${TEST_SRC}
    ${SRC_FILE}
    ${CppPath}
    testcase/api_david_stest.cpp
)

target_include_directories(api_david_stest PRIVATE
    ${INCLUDE_DIR}
)

target_compile_options(api_david_stest PRIVATE
    -g
    -Wall
    -std=c++11
    -fno-access-control
    -Werror
)

target_compile_definitions(api_david_stest PRIVATE
    C_SEC
    __PROF_LLT
    google=ascend_private
    LLT_DATA_DIR="${LLT_DATA_DIR}"
    API_STEST
    PLATFORM_TYPE=15
    SOC_TYPE="david"
)

target_link_options(api_david_stest PRIVATE
   -ldl
   -lpthread
)

target_link_libraries(api_david_stest PRIVATE
    $<BUILD_INTERFACE:intf_llt_pub>
    $<BUILD_INTERFACE:mmpa_headers>
    $<BUILD_INTERFACE:slog_headers>
    $<BUILD_INTERFACE:adump_headers>
    profapi_share_st
    ascend_protobuf
    c_sec
    json
)

set_target_properties(api_david_stest
    PROPERTIES
    OUTPUT_NAME api_david_stest
    LIBRARY_OUTPUT_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}
)

####################### api_mini_v3_stest ###########################

add_executable(api_mini_v3_stest
    ${TEST_STUB_SRC}
    ${TEST_SRC}
    ${SRC_FILE}
    ${CppPath}
    testcase/api_mini_v3_stest.cpp
)

target_include_directories(api_mini_v3_stest PRIVATE
    ${INCLUDE_DIR}
)

target_compile_options(api_mini_v3_stest PRIVATE
    -g
    -Wall
    -std=c++11
    -fno-access-control
    -Werror
)

target_compile_definitions(api_mini_v3_stest PRIVATE
    C_SEC
    __PROF_LLT
    google=ascend_private
    LLT_DATA_DIR="${LLT_DATA_DIR}"
    API_STEST
    PLATFORM_TYPE=7
    SOC_TYPE="mini_v3"
)

target_link_options(api_mini_v3_stest PRIVATE
   -ldl
   -lpthread
)

target_link_libraries(api_mini_v3_stest PRIVATE
    $<BUILD_INTERFACE:intf_llt_pub>
    $<BUILD_INTERFACE:mmpa_headers>
    $<BUILD_INTERFACE:slog_headers>
    $<BUILD_INTERFACE:adump_headers>
    profapi_share_st
    ascend_protobuf
    c_sec
    json
)

set_target_properties(api_mini_v3_stest
    PROPERTIES
    OUTPUT_NAME api_mini_v3_stest
    LIBRARY_OUTPUT_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}
)

####################### api_mdc_mini_v3_stest ###########################

add_executable(api_mdc_mini_v3_stest
    ${TEST_STUB_SRC}
    ${TEST_SRC}
    ${SRC_FILE}
    ${CppPath}
    testcase/api_mdc_mini_v3_stest.cpp
)

target_include_directories(api_mdc_mini_v3_stest PRIVATE
    ${INCLUDE_DIR}
)

target_compile_options(api_mdc_mini_v3_stest PRIVATE
    -g
    -Wall
    -std=c++11
    -fno-access-control
    -Werror
)

target_compile_definitions(api_mdc_mini_v3_stest PRIVATE
    C_SEC
    __PROF_LLT
    google=ascend_private
    LLT_DATA_DIR="${LLT_DATA_DIR}"
    API_STEST
    PLATFORM_TYPE=11
    SOC_TYPE="mdc_mini_v3"
)

target_link_options(api_mdc_mini_v3_stest PRIVATE
   -ldl
   -lpthread
)

target_link_libraries(api_mdc_mini_v3_stest PRIVATE
    $<BUILD_INTERFACE:intf_llt_pub>
    $<BUILD_INTERFACE:mmpa_headers>
    $<BUILD_INTERFACE:slog_headers>
    $<BUILD_INTERFACE:adump_headers>
    profapi_share_st
    ascend_protobuf
    c_sec
    json
)

set_target_properties(api_mdc_mini_v3_stest
    PROPERTIES
    OUTPUT_NAME api_mdc_mini_v3_stest
    LIBRARY_OUTPUT_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}
)

####################### api_cloud_stest ###########################

add_executable(api_cloud_stest
    ${TEST_STUB_SRC}
    ${TEST_SRC}
    ${SRC_FILE}
    ${CppPath}
    testcase/api_cloud_stest.cpp
)

target_include_directories(api_cloud_stest PRIVATE
    ${INCLUDE_DIR}
)

target_compile_options(api_cloud_stest PRIVATE
    -g
    -Wall
    -std=c++11
    -fno-access-control
    -Werror
)

target_compile_definitions(api_cloud_stest PRIVATE
    C_SEC
    __PROF_LLT
    google=ascend_private
    LLT_DATA_DIR="${LLT_DATA_DIR}"
    API_STEST
    PLATFORM_TYPE=1
    SOC_TYPE="cloud"
)

target_link_options(api_cloud_stest PRIVATE
   -ldl
   -lpthread
)

target_link_libraries(api_cloud_stest PRIVATE
    $<BUILD_INTERFACE:intf_llt_pub>
    $<BUILD_INTERFACE:mmpa_headers>
    $<BUILD_INTERFACE:slog_headers>
    $<BUILD_INTERFACE:adump_headers>
    profapi_share_st
    ascend_protobuf
    c_sec
    json
)

set_target_properties(api_cloud_stest
    PROPERTIES
    OUTPUT_NAME api_cloud_stest
    LIBRARY_OUTPUT_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}
)

####################### api_mdc_stest ###########################

add_executable(api_mdc_stest
    ${TEST_STUB_SRC}
    ${TEST_SRC}
    ${SRC_FILE}
    ${CppPath}
)

target_include_directories(api_mdc_stest PRIVATE
    ${INCLUDE_DIR}
)

target_compile_options(api_mdc_stest PRIVATE
    -g
    -Wall
    -std=c++11
    -fno-access-control
    -Werror
)

target_compile_definitions(api_mdc_stest PRIVATE
    C_SEC
    __PROF_LLT
    google=ascend_private
    LLT_DATA_DIR="${LLT_DATA_DIR}"
    API_STEST
    PLATFORM_TYPE=2
    SOC_TYPE="mdc"
)

target_link_options(api_mdc_stest PRIVATE
   -ldl
   -lpthread
)

target_link_libraries(api_mdc_stest PRIVATE
    $<BUILD_INTERFACE:intf_llt_pub>
    $<BUILD_INTERFACE:mmpa_headers>
    $<BUILD_INTERFACE:slog_headers>
    $<BUILD_INTERFACE:adump_headers>
    profapi_share_st
    ascend_protobuf
    c_sec
    json
)

set_target_properties(api_mdc_stest
    PROPERTIES
    OUTPUT_NAME api_mdc_stest
    LIBRARY_OUTPUT_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}
)

####################### acl_api_stest ###########################

add_executable(acl_api_stest
    ${TEST_STUB_SRC}
    ${TEST_SRC}
    ${SRC_FILE}
    ${CppPath}
    testcase/api_milan_stest.cpp
    testcase/acl_api/api_milan_stest.cpp
    testcase/acl_api/api_david_stest.cpp
    testcase/acl_api/api_david_v121_stest.cpp
    testcase/acl_api/api_mdc_stest.cpp
    testcase/acl_api/api_cloud_stest.cpp
    testcase/acl_api/api_mdc_mini_v3_stest.cpp
    testcase/acl_api/api_dc_stest.cpp
    testcase/acl_api/api_mini_v3_stest.cpp
)

target_include_directories(acl_api_stest PRIVATE
    ${INCLUDE_DIR}
)

target_compile_options(acl_api_stest PRIVATE
    -g
    -Wall
    -std=c++11
    -fno-access-control
    -Werror
)

target_compile_definitions(acl_api_stest PRIVATE
    C_SEC
    __PROF_LLT
    google=ascend_private
    LLT_DATA_DIR="${LLT_DATA_DIR}"
    API_STEST
    PLATFORM_TYPE=5
    SOC_TYPE="milan"
)

target_link_options(acl_api_stest PRIVATE
   -ldl
   -lpthread
)

target_link_libraries(acl_api_stest PRIVATE
    $<BUILD_INTERFACE:intf_llt_pub>
    $<BUILD_INTERFACE:mmpa_headers>
    $<BUILD_INTERFACE:slog_headers>
    $<BUILD_INTERFACE:adump_headers>
    profapi_share_st
    ascend_protobuf
    c_sec
    json
)

set_target_properties(acl_api_stest
    PROPERTIES
    OUTPUT_NAME acl_api_stest
    LIBRARY_OUTPUT_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}
)

####################### api_tiny_stest ###########################

add_executable(api_tiny_stest
    ${TEST_STUB_SRC}
    ${TEST_SRC}
    ${SRC_FILE}
    ${CppPath}
    testcase/api_tiny_stest.cpp
)

target_include_directories(api_tiny_stest PRIVATE
    ${INCLUDE_DIR}
)

target_compile_options(api_tiny_stest PRIVATE
    -g
    -Wall
    -std=c++11
    -fno-access-control
    -Werror
)

target_compile_definitions(api_tiny_stest PRIVATE
    C_SEC
    __PROF_LLT
    google=ascend_private
    LLT_DATA_DIR="${LLT_DATA_DIR}"
    API_STEST
    PLATFORM_TYPE=8
    SOC_TYPE="tiny"
)

target_link_options(api_tiny_stest PRIVATE
   -ldl
   -lpthread
)

target_link_libraries(api_tiny_stest PRIVATE
    $<BUILD_INTERFACE:intf_llt_pub>
    $<BUILD_INTERFACE:mmpa_headers>
    $<BUILD_INTERFACE:slog_headers>
    $<BUILD_INTERFACE:adump_headers>
    profapi_share_st
    ascend_protobuf
    c_sec
    json
)

set_target_properties(api_tiny_stest
    PROPERTIES
    OUTPUT_NAME api_tiny_stest
    LIBRARY_OUTPUT_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}
)

####################### libprofapi.so ###########################
set(prof_api_src_file
    ${MSPROF_SOURCE_DIR}/dvvp/profapi/src/prof_inner_api.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/profapi/src/prof_acl_inner_api.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/profapi/src/prof_impl_inner_api.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/profapi/src/prof_plugin_manager.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/profapi/src/prof_plugin.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/profapi/src/prof_cann_plugin.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/profapi/src/prof_atls_plugin.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/profapi/src/prof_tx_plugin.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/profapi/src/prof_acl_plugin.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/profapi/src/prof_runtime_plugin.cpp
)

add_library(profapi_share_st SHARED
    ${prof_api_src_file}
    # add stub files in target profapi_share_st to call api in prof_inner_api.cpp
    ${API_STUB_DIR}/host/acl_stub.cpp
    ${API_STUB_DIR}/host/ge_stub.cpp
    ${LLT_DATA_DIR}/data_manager.cpp
    # add msprofiler files to call api in prof_acl_inner_api.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/common/utils/utils.cpp
    ${MSPROF_SOURCE_DIR}/basic/osal/osal.c
    ${MSPROFILER_SRC_FILE}
    stub/aoe_stub.cpp
    ../../stub/error_manager_stub.cpp
)

target_compile_definitions(profapi_share_st PRIVATE
    $<$<STREQUAL:${TARGET_SYSTEM_NAME},Windows>:WIN32>
    LLT_DATA_DIR="${LLT_DATA_DIR}"
)

set_target_properties(profapi_share_st
    PROPERTIES
    OUTPUT_NAME profapi
    LIBRARY_OUTPUT_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/
)

target_compile_options(profapi_share_st PRIVATE
    -fstack-protector-all
    -Wall
    -Wextra
    -Wfloat-equal
    -g
    -O0
    -Werror
)

target_link_options(profapi_share_st PRIVATE
    -Wl,-z,relro,-z,now,-z,noexecstack
    -Wl,-Bsymbolic
    -Wl,--exclude-libs=ALL
)

target_include_directories(profapi_share_st PRIVATE
    ${MSPROF_SOURCE_DIR}/dvvp/profapi/inc
    ${MSPROF_SOURCE_DIR}/dvvp/analyze/inc
    ${MSPROF_SOURCE_DIR}/dvvp
    ${MSPROF_SOURCE_DIR}/dvvp/common
    ${MSPROF_SOURCE_DIR}/dvvp/common/logger
    ${MSPROF_SOURCE_DIR}/dvvp/common/json
    ${MSPROF_SOURCE_DIR}/basic/osal
    ${MSPROF_SOURCE_DIR}/dvvp/transport
    ${MSPROF_SOURCE_DIR}/dvvp/depend/include/wrapper
    ${MSPROF_SOURCE_DIR}/dvvp/profimpl/inc
    ${MSPROF_SOURCE_DIR}/dvvp/common/utils
    ${TOP_DIR}/abl/msprof/inc/toolchain
    ${TOP_DIR}/abl/msprof/inc/external/acl
    ${TOP_DIR}/abl/msprof/inc/external/ge
    ${TOP_DIR}/abl/msprof/inc/external
    ${TOP_DIR}/abl/msprof/inc
    ${TOP_DIR}/inc/external/acl
    ${TOP_DIR}/graphengine/inc
    ${TOP_DIR}/graphengine/inc/external
    ${TOP_DIR}/graphengine/inc/framework/common
    ${TOP_DIR}/abl/libc_sec/include
    ${TOP_DIR}/ace/npuruntime/inc
    ${TOP_DIR}/ace/npuruntime/inc/external
    ${TOP_DIR}/inc/external
    ${API_STUB_DIR}/device
    ${API_STUB_DIR}/host
    ${LLT_DATA_DIR}
    data
)

target_link_libraries(profapi_share_st
    PRIVATE
        intf_pub
        mmpa_headers
        slog_headers
    PUBLIC
        msprof_headers
    json
    $<$<STREQUAL:${TARGET_SYSTEM_NAME},Linux>:dl>
)

install(TARGETS profapi_share_st OPTIONAL
    LIBRARY DESTINATION ${CMAKE_CURRENT_BINARY_DIR}
)
