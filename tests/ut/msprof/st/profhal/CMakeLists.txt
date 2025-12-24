# -----------------------------------------------------------------------------------------------------------
# Copyright (c) 2025 Huawei Technologies Co., Ltd.
# This program is free software, you can redistribute it and/or modify it under the terms and conditions of
# CANN Open Software License Agreement Version 2.0 (the "License").
# Please refer to the License for details. You may not use this file except in compliance with the License.
# THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
# INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
# See LICENSE in the root of the software repository for the full text of the License.
# -----------------------------------------------------------------------------------------------------------
protobuf_generate(profiler
    CppPath
    HeaderPath
    ${MSPROF_SOURCE_DIR}/dvvp/proto/profiler.proto
)

set(src_file
    ${MSPROF_SOURCE_DIR}/dvvp/profhal/adx/stub/adx_prof_api.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/profhal/adx/wrapper/memory_utils.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/analyze/src/analyzer.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/analyze/src/analyzer_base.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/analyze/src/analyzer_ge.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/analyze/src/analyzer_ffts.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/analyze/src/analyzer_hwts.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/analyze/src/analyzer_ts.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/analyze/src/analyzer_rt.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/analyze/src/op_desc_parser.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/common/cmd_log/cmd_log.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/common/socket/local_socket.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/common/config/config_manager.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/common/config/feature_manager.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/common/memory/chunk_pool.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/common/platform/platform.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/common/statistics/perf_count.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/common/thread/thread.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/common/thread/thread_pool.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/common/utils/utils.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/common/validation/param_validation.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/common/json/json.cpp
    ${MSPROF_SOURCE_DIR}/basic/osal/osal.c
    ${MSPROF_SOURCE_DIR}/dvvp/depend/stub/error_manager/msprof_error_manager_stub.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/driver/channel/ai_drv_prof_api.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/driver/devmgmt/ai_drv_dev_api.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/driver/devmgmt/mini/ai_drv_dsmi_api.cpp
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
    ${MSPROF_SOURCE_DIR}/dvvp/msprof/common/src/msprof_reporter.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/msprof/common/src/receive_data.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/msprof/dynamic_profiling/src/dyn_prof_client.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/msprof/dynamic_profiling/src/dyn_prof_server.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/msprof/dynamic_profiling/src/dyn_prof_thread.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/msprof/dynamic_profiling/src/dyn_prof_mgr.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/msprof/engine/src/prof_acl_mgr.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/msprofiler/prof_ge_core.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/msprofiler/prof_acl_core.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/msprofiler/prof_api_common.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/msprofiler/prof_api_runtime.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/msprof/engine/src/uploader_dumper.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/msprof/msproftx/src/msprof_tx_manager.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/msprof/msproftx/src/msprof_tx_reporter.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/msprof/msproftx/src/prof_stamp_pool.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/profhal/halimpl/prof_hdc_server.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/profhal/halimpl/prof_helper_server.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/profhal/halimpl/prof_server_manager.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/profhal/halimpl/prof_hal_api.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/profimpl/adapter/src/command_handle.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/task_handle/src/device.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/task_handle/src/info_json.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/task_handle/src/prof_manager.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/task_handle/src/prof_params_adapter.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/task_handle/src/prof_task.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/task_handle/src/task_relationship_mgr.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/transport/file_slice.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/transport/file_ageing.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/transport/file_transport.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/transport/hdc/hdc_transport.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/transport/hdc/helper_transport.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/transport/hdc/platform/soc/dev_mgr_api.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/transport/parser_transport.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/transport/prof_channel.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/transport/uploader.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/transport/uploader_mgr.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/transport/hash_data.cpp
    ${CppPath}
    ${MSPROF_SOURCE_DIR}/dvvp/profimpl/adapter/src/msproftx_adaptor.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/profimpl/adapter/src/msprofiler_adaptor.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/profimpl/adapter/src/msprofiler_impl.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/profimpl/adapter/src/msprofiler_acl_api.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/profimpl/adapter/src/json_parser.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/profimpl/report/prof_reporter_mgr.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/profimpl/aicpu/prof_hal_plugin.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/profimpl/platform/platform_interface.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/profimpl/platform/base_analyzer.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/profimpl/platform/nano_platform.cpp
)

add_executable(prof_hal_stest
    test/main.cpp
    test/hal_server_stest.cpp
    test/aicpu_plugin_stest.cpp
    stub/mmpa_stub.cpp
    ../stub/mmpa_stub.cpp
    ../stub/prof_api_stub.cpp
    ../stub/hdc-log-stub.cpp
    ../stub/devdrv_runtime_api_stub.cpp
    ../stub/profile_drv_user_stub.cpp
    ../stub/hdc-api-stub.cpp
    # ../stub/adx_prof_api_stub.cpp
    ../../stub/error_manager_stub.cpp
    ${src_file}
)

target_include_directories(prof_hal_stest PRIVATE
    ${MSPROF_SOURCE_DIR}/dvvp/msprof/engine/include
    ${MSPROF_SOURCE_DIR}/dvvp/common/utils
    ${TOP_DIR}/abl/msprof/inc/toolchain
    ../stub/
    ../stub/host
    ${TOP_DIR}/llt/abl/msprof/st/stub
    ${TOP_DIR}/abl/libc_sec/include
    ${TOP_DIR}/metadef/inc
    ${TOP_DIR}/metadef/inc/external
    ${TOP_DIR}/abl/msprof/inc/toolchain
    ${MSPROF_SOURCE_DIR}/dvvp/analyze/inc
    ${MSPROF_SOURCE_DIR}/dvvp/msprof/engine/include
    ${MSPROF_SOURCE_DIR}/dvvp/msprof/common/include
    ${MSPROF_SOURCE_DIR}/dvvp/msprof/drvprof/include
    ${MSPROF_SOURCE_DIR}/dvvp/msprof/dynamic_profiling/include
    ${MSPROF_SOURCE_DIR}/dvvp/msprof/platform/include
    ${MSPROF_SOURCE_DIR}/dvvp/msprof/msproftx/include
    ${MSPROF_SOURCE_DIR}/dvvp/msprof/include
    ${MSPROF_SOURCE_DIR}/dvvp/common
    ${MSPROF_SOURCE_DIR}/dvvp/common/errno
    ${MSPROF_SOURCE_DIR}/dvvp/common/logger
    ${MSPROF_SOURCE_DIR}/dvvp/common/validation
    ${MSPROF_SOURCE_DIR}/dvvp/common/queue
    ${MSPROF_SOURCE_DIR}/dvvp/common/singleton
    ${MSPROF_SOURCE_DIR}/dvvp/common/utils
    ${MSPROF_SOURCE_DIR}/dvvp/common/config
    ${MSPROF_SOURCE_DIR}/dvvp/common/json
    ${MSPROF_SOURCE_DIR}/basic/osal
    ${MSPROF_SOURCE_DIR}/dvvp/message
    ${MSPROF_SOURCE_DIR}/dvvp/transport
    ${MSPROF_SOURCE_DIR}/dvvp/common/memory/
    ${MSPROF_SOURCE_DIR}/dvvp/streamio/client/include
    ${MSPROF_SOURCE_DIR}/dvvp/streamio/common/include
    ${MSPROF_SOURCE_DIR}/dvvp/streamio/server/include
    ${MSPROF_SOURCE_DIR}/dvvp
    ${MSPROF_SOURCE_DIR}/dvvp/msprofiler
    ${MSPROF_SOURCE_DIR}/dvvp/task_handle/include
    ${MSPROF_SOURCE_DIR}/dvvp/driver/inc
    ${MSPROF_SOURCE_DIR}/dvvp/profimpl/collect/job_wrapper/include
    ${MSPROF_SOURCE_DIR}/dvvp/profhal/adx/inc
    ${MSPROF_SOURCE_DIR}/dvvp/profhal/halimpl
    ${MSPROF_SOURCE_DIR}/dvvp/profhal/halinc
    ${MSPROF_SOURCE_DIR}/dvvp/profimpl/adapter/inc
    ${MSPROF_SOURCE_DIR}/dvvp/profimpl/report
    ${MSPROF_SOURCE_DIR}/dvvp/profimpl/aicpu
    ${MSPROF_SOURCE_DIR}/dvvp/profimpl/platform
    ${MSPROF_SOURCE_DIR}/dvvp/profimpl/inc
    ${TOP_DIR}/graphengine/inc/external
    ${TOP_DIR}/inc
    ${TOP_DIR}/inc/driver
    ${TOP_DIR}/inc/aicpu
    ${TOP_DIR}/inc/external
    ${TOP_DIR}/inc/external/acl
    ${TOP_DIR}/ace/npuruntime/inc
    ${TOP_DIR}/abl/msprof/inc
    ${CMAKE_BINARY_DIR}/proto/profiler/
    ${MSPROF_SOURCE_DIR}/dvvp/depend/include/stub
    ${MSPROF_SOURCE_DIR}/dvvp/profapi/inc
)


target_compile_options(prof_hal_stest PRIVATE
    -g
    -pipe
    -Wall
    -std=c++11
    -fno-access-control
    -Wfloat-equal
    -Wextra
    -Werror
)

target_compile_definitions(prof_hal_stest PRIVATE
    C_SEC
    MSPROF_DEBUG
    google=ascend_private
)

target_link_libraries(prof_hal_stest PRIVATE
    $<BUILD_INTERFACE:intf_llt_pub>
    $<BUILD_INTERFACE:mmpa_headers>
    $<BUILD_INTERFACE:slog_headers>
    $<BUILD_INTERFACE:adump_headers>
    $<BUILD_INTERFACE:msprof_headers>
    ascend_protobuf
    c_sec
)

set_target_properties(prof_hal_stest
    PROPERTIES
    OUTPUT_NAME profhal_stest
    LIBRARY_OUTPUT_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}
)

run_llt_test(
    TARGET prof_hal_stest
    TASK_NUM 1
)
