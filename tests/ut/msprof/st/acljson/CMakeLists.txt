# -----------------------------------------------------------------------------------------------------------
# Copyright (c) 2025 Huawei Technologies Co., Ltd.
# This program is free software, you can redistribute it and/or modify it under the terms and conditions of
# CANN Open Software License Agreement Version 2.0 (the "License").
# Please refer to the License for details. You may not use this file except in compliance with the License.
# THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
# INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
# See LICENSE in the root of the software repository for the full text of the License.
# -----------------------------------------------------------------------------------------------------------
set(ACLJSON_STUB_DIR
    ${TOP_DIR}/llt/abl/msprof/st/stub
)

set(LLT_DATA_DIR
    ${TOP_DIR}/llt/abl/msprof/st/data/
)

set(testStubSrc
    ${ACLJSON_STUB_DIR}/hdc-api-stub.cpp
    ${ACLJSON_STUB_DIR}/hdc-log-stub.cpp
    ${ACLJSON_STUB_DIR}/ide-cmd-stub.cpp
    ${ACLJSON_STUB_DIR}/device/device_drv_prof_stub.cpp
    ${ACLJSON_STUB_DIR}/device/device_simulator_manager.cpp
    ${ACLJSON_STUB_DIR}/device/device_simulator.cpp
    ${ACLJSON_STUB_DIR}/device/stars_device_simulator.cpp
    ${ACLJSON_STUB_DIR}/device/david_device_simulator.cpp
    ${ACLJSON_STUB_DIR}/device/david_v121_device_simulator.cpp
    ${ACLJSON_STUB_DIR}/device/cloud_device_simulator.cpp
    ${ACLJSON_STUB_DIR}/device/tiny_device_simulator.cpp
    ${ACLJSON_STUB_DIR}/device/data_report_manager.cpp
    ${ACLJSON_STUB_DIR}/device/data_report.cpp
    ${ACLJSON_STUB_DIR}/device/data_check.cpp
    ${ACLJSON_STUB_DIR}/device/dc_device_simulator.cpp
    ${ACLJSON_STUB_DIR}/device/mdc_device_simulator.cpp
    ${ACLJSON_STUB_DIR}/device/mdc_lite_device_simulator.cpp
    ${ACLJSON_STUB_DIR}/device/mini_device_simulator.cpp
    ${ACLJSON_STUB_DIR}/device/nano_device_simulator.cpp
    ${ACLJSON_STUB_DIR}/device/mdc_mini_v3_device_simulator.cpp
    ${ACLJSON_STUB_DIR}/device/msprof_start.cpp
    ${ACLJSON_STUB_DIR}/device/rpc_device_manager_stub.cpp
    ${ACLJSON_STUB_DIR}/device/nano_device_simulator.cpp
    ${ACLJSON_STUB_DIR}/device/mini_stars_device_simulator.cpp
    ${ACLJSON_STUB_DIR}/device/tsd_stub.cpp
    ${ACLJSON_STUB_DIR}/host/msprof_stub.cpp
)

set(testSrc
    testcase/main.cpp
    testcase/acljson_milan_stest.cpp
    testcase/acljson_mdc_mini_v3_steat.cpp
    testcase/acljson_prof_json_stest.cpp
    testcase/acljson_miniv3_ep_stest.cpp
    testcase/acljson_miniv3_rc_stest.cpp
    testcase/acljson_mdc_stest.cpp
    testcase/acljson_mdc_lite_stest.cpp
    testcase/acljson_dc_stest.cpp
    testcase/acljson_cloud_stest.cpp
    testcase/acljson_david_stest.cpp
    testcase/acljson_david_v121_stest.cpp
)

set(adprof_src
    ${MSPROF_SOURCE_DIR}/dvvp/msprof/devprof/src/adprof_collector.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/msprof/devprof/src/devprof_drv_aicpu.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/msprof/devprof/src/devprof_drv_adprof.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/msprof/devprof/src/devprof_common.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/msprof/devprof/src/aicpu_report_hdc.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/msprof/devprof/src/devprof_api.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/msprof/drvprof/src/engine_mgr.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/msprof/drvprof/src/module_job.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/msprof/drvprof/src/rpc_data_handle.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/msprof/drvprof/src/rpc_dumper.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/transport/hdc/hdc_sender.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/streamio/client/src/sender.cpp
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
    ${MSPROF_SOURCE_DIR}/dvvp/msprofbin/src/msprof_bin.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/msprofbin/src/msprof_manager.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/msprofbin/src/msprof_params_adapter.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/msprofbin/src/input_parser.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/msprofbin/src/msprof_task.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/msprofbin/src/running_mode.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/app/application.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/app/env_manager.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/common/utils/utils.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/common/cmd_log/cmd_log.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/common/socket/local_socket.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/common/config/config_manager.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/common/config/feature_manager.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/common/memory/chunk_pool.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/common/thread/thread.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/common/thread/thread_pool.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/common/statistics/perf_count.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/common/validation/param_validation.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/common/platform/platform.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/common/json/json.cpp
    ${MSPROF_SOURCE_DIR}/basic/osal/osal.c
    ${MSPROF_SOURCE_DIR}/dvvp/driver/channel/ai_drv_prof_api.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/driver/devmgmt/ai_drv_dev_api.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/driver/devmgmt/ai_drv_dsmi_api.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/profimpl/collect/job_wrapper/src/collection_job.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/profimpl/collect/job_wrapper/src/collection_register.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/profimpl/collect/job_wrapper/src/job_factory.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/profimpl/collect/job_wrapper/src/job_device_rpc.cpp
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
    ${MSPROF_SOURCE_DIR}/dvvp/profimpl/collect/job_wrapper/src/prof_channel_manager.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/profimpl/collect/job_wrapper/src/job_device_soc.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/profimpl/collect/job_wrapper/src/adprof_collector_proxy.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/message/codec.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/msprof/common/src/msprof_reporter.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/msprof/common/src/receive_data.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/msprof/engine/src/prof_acl_mgr.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/msprof/engine/src/uploader_dumper.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/msprof/msproftx/src/msprof_tx_manager.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/msprof/msproftx/src/msprof_tx_reporter.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/msprof/msproftx/src/prof_stamp_pool.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/profimpl/adapter/src/json_parser.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/profimpl/adapter/src/msprofiler_adaptor.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/profimpl/adapter/src/msprofiler_impl.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/profimpl/adapter/src/msprofiler_acl_api.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/profimpl/adapter/src/command_handle.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/profimpl/report/prof_reporter_mgr.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/profimpl/aicpu/prof_aicpu_api.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/profimpl/aicpu/prof_hal_plugin.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/profimpl/platform/platform_interface.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/profimpl/platform/base_analyzer.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/profimpl/platform/nano_platform.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/profimpl/platform/mini_v3_platform.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/profimpl/platform/mdc_mini_v3_platform.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/profimpl/platform/cloud_v2_platform.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/profimpl/platform/david_platform.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/profimpl/platform/david_v121_platform.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/profimpl/platform/mdc_lite_platform.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/profimpl/platform/cloud_platform.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/profimpl/platform/dc_platform.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/profimpl/platform/mini_platform.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/profimpl/platform/mdc_platform.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/profimpl/platform/tiny_v1_platform.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/profimpl/collect/channel/nano_stars_profile.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/profimpl/collect/channel/channel_job.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/transport/file_transport.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/transport/prof_channel.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/transport/uploader_mgr.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/transport/uploader.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/transport/file_slice.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/transport/file_ageing.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/transport/hdc/data_handle.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/transport/hdc/hdc_transport.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/transport/hdc/helper_transport.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/transport/hdc/device_transport.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/transport/hash_data.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/transport/parser_transport.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/task_handle/src/device.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/task_handle/src/info_json.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/task_handle/src/prof_manager.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/task_handle/src/prof_params_adapter.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/task_handle/src/prof_task.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/task_handle/src/task_relationship_mgr.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/msprof/dynamic_profiling/src/dyn_prof_client.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/msprof/dynamic_profiling/src/dyn_prof_server.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/msprof/dynamic_profiling/src/dyn_prof_thread.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/msprof/dynamic_profiling/src/dyn_prof_mgr.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/common/argparse/argparser.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/acp/src/acp_bin.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/acp/src/acp_command.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/acp/src/acp_pipe_transfer.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/acp/src/acp_compute_device_job.cpp
    ${adprof_src}
)

set(INCLUDE_DIR
    ${ACLJSON_STUB_DIR}/device
    ${ACLJSON_STUB_DIR}/host
    ${TOP_DIR}/inc/driver
    ${TOP_DIR}/inc/aicpu
    ${TOP_DIR}/inc/external
    ${TOP_DIR}/inc/external/acl
    ${TOP_DIR}/abl/libc_sec/include
    ${TOP_DIR}/ace/npuruntime/inc
    ${TOP_DIR}/ace/npuruntime/inc/external/
    ${TOP_DIR}/abl/msprof/inc
    ${TOP_DIR}/abl/msprof/inc/external
    ${TOP_DIR}/metadef/inc
    ${TOP_DIR}/metadef/inc/external
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
    ${MSPROF_SOURCE_DIR}/dvvp/msprofiler
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
    ${MSPROF_SOURCE_DIR}/dvvp/msprof/engine/include
    ${MSPROF_SOURCE_DIR}/dvvp/msprof/msproftx/include
    ${MSPROF_SOURCE_DIR}/dvvp/msprof/platform/include
    ${MSPROF_SOURCE_DIR}/dvvp/msprof/common/include
    ${MSPROF_SOURCE_DIR}/dvvp/msprof/devprof/include
    ${MSPROF_SOURCE_DIR}/dvvp/msprof/drvprof/include
    ${MSPROF_SOURCE_DIR}/dvvp/msprof/dynamic_profiling/include
    ${MSPROF_SOURCE_DIR}/dvvp/msprof/include
    ${MSPROF_SOURCE_DIR}/dvvp/message
    ${MSPROF_SOURCE_DIR}/dvvp/profapi/inc
    ${MSPROF_SOURCE_DIR}/dvvp/common/argparse
    ${MSPROF_SOURCE_DIR}/dvvp/acp/include
    ${CMAKE_BINARY_DIR}/proto/profiler
)

protobuf_generate(profiler
    CppPath
    HeaderPath
    ${MSPROF_SOURCE_DIR}/dvvp/proto/profiler.proto
)

add_executable(acljson_stest
    ${testStubSrc}
    ${ACLJSON_STUB_DIR}/device/mmpa_stub.cpp
    ../../stub/error_manager_stub.cpp
    ${testSrc}
    ${MSPROF_SOURCE_DIR}/dvvp/depend/stub/error_manager/msprof_error_manager_stub.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/profimpl/adapter/src/msproftx_adaptor.cpp
    ${src_file}
    ${CppPath}
)

target_include_directories(acljson_stest PRIVATE
    ${INCLUDE_DIR}
    ${MSPROF_SOURCE_DIR}/dvvp/depend/include/stub
    ${LLT_DATA_DIR}
)

target_compile_options(acljson_stest PRIVATE
    -g
    -Wall
    -std=c++11
    -fno-access-control
    -Werror
)

target_compile_definitions(acljson_stest PRIVATE
    C_SEC
    __PROF_LLT
    google=ascend_private
    LLT_DATA_DIR="${LLT_DATA_DIR}"
)

target_link_options(acljson_stest PRIVATE
   -ldl
   -lpthread
)

target_link_libraries(acljson_stest PRIVATE
    $<BUILD_INTERFACE:intf_llt_pub>
    $<BUILD_INTERFACE:mmpa_headers>
    $<BUILD_INTERFACE:slog_headers>
    $<BUILD_INTERFACE:adump_headers>
    profapi_share_st
    ascend_protobuf
    c_sec
    json
)

set_target_properties(acljson_stest
    PROPERTIES
    OUTPUT_NAME acljson_stest
    LIBRARY_OUTPUT_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}
)

run_llt_test(
    TARGET acljson_stest
    TASK_NUM 1
)

####################### acljson_nano_c_stest ###########################

set(src_c_file
    ${MSPROF_SOURCE_DIR}/basic/osal/osal.c
    ${MSPROF_SOURCE_DIR}/basic/osal/osal_linux.c
    ${MSPROF_SOURCE_DIR}/basic/osal/osal_linux_mem.c
    ${MSPROF_SOURCE_DIR}/basic/osal/osal_thread.c
    ${MSPROF_SOURCE_DIR}/avp/basic/json/info_json.c
    ${MSPROF_SOURCE_DIR}/avp/basic/json/json_parser.c
    ${MSPROF_SOURCE_DIR}/avp/basic/json/json_generator.c
    ${MSPROF_SOURCE_DIR}/avp/basic/json/sort_vector.c
    ${MSPROF_SOURCE_DIR}/avp/basic/json/vector.c
    ${MSPROF_SOURCE_DIR}/avp/basic/json/sample_json.c
    ${MSPROF_SOURCE_DIR}/avp/basic/utils/utils.c
    ${MSPROF_SOURCE_DIR}/avp/basic/thread/thread_pool.c
    ${MSPROF_SOURCE_DIR}/avp/basic/cstl/cstl_list.c
    ${MSPROF_SOURCE_DIR}/avp/basic/hal/hal_dsmi.c
    ${MSPROF_SOURCE_DIR}/avp/basic/hal/hal_prof.c
    ${MSPROF_SOURCE_DIR}/avp/basic/atomic/atomic_linux.c
    ${MSPROF_SOURCE_DIR}/avp/domain/platform/platform.c
    ${MSPROF_SOURCE_DIR}/avp/domain/platform/platform_interface.c
    ${MSPROF_SOURCE_DIR}/avp/domain/platform/platform_table.c
    ${MSPROF_SOURCE_DIR}/avp/domain/platform/chip/chip_nano_v1.c
    ${MSPROF_SOURCE_DIR}/avp/domain/param/profile_param.c
    ${MSPROF_SOURCE_DIR}/avp/domain/transport/uploader.c
    ${MSPROF_SOURCE_DIR}/avp/domain/transport/transport.c
    ${MSPROF_SOURCE_DIR}/avp/domain/transport/file_transport.c
    ${MSPROF_SOURCE_DIR}/avp/domain/transport/flash_transport.c
    ${MSPROF_SOURCE_DIR}/avp/domain/collect/report/report_manager.c
    ${MSPROF_SOURCE_DIR}/avp/domain/collect/report/hash_dic.c
    ${MSPROF_SOURCE_DIR}/avp/domain/collect/report/start_time.c
    ${MSPROF_SOURCE_DIR}/avp/domain/collect/report/report_buffer_mgr.c
    ${MSPROF_SOURCE_DIR}/avp/domain/collect/task/task_manager.c
    ${MSPROF_SOURCE_DIR}/avp/domain/collect/task/task_slot.c
    ${MSPROF_SOURCE_DIR}/avp/domain/collect/task/task_pool.c
    ${MSPROF_SOURCE_DIR}/avp/domain/collect/channel/channel_manager.c
    ${MSPROF_SOURCE_DIR}/avp/domain/collect/channel/channel_reader.c
    ${MSPROF_SOURCE_DIR}/avp/domain/collect/job/job_manager.c
    ${MSPROF_SOURCE_DIR}/avp/domain/collect/job/collection_job.c
    ${MSPROF_SOURCE_DIR}/avp/domain/collect/job/nano_stars_job.c
    ${MSPROF_SOURCE_DIR}/avp/service/api/prof_api.c
    ${MSPROF_SOURCE_DIR}/avp/service/impl/service_impl.c
    ${MSPROF_SOURCE_DIR}/avp/service/impl/service_task.c
    ${MSPROF_SOURCE_DIR}/avp/service/impl/service_param.c
    ${MSPROF_SOURCE_DIR}/avp/service/impl/service_report.c
)

set(INCLUDE_DIR
    ${MSPROF_SOURCE_DIR}/dvvp/transport
    ${MSPROF_SOURCE_DIR}/basic/
    ${MSPROF_SOURCE_DIR}/basic/osal
    ${MSPROF_SOURCE_DIR}/avp/
    ${MSPROF_SOURCE_DIR}/avp/basic
    ${MSPROF_SOURCE_DIR}/avp/basic/thread
    ${MSPROF_SOURCE_DIR}/avp/basic/hal/
    ${MSPROF_SOURCE_DIR}/avp/basic/utils
    ${MSPROF_SOURCE_DIR}/avp/basic/errno
    ${MSPROF_SOURCE_DIR}/avp/basic/logger
    ${MSPROF_SOURCE_DIR}/avp/basic/cstl
    ${MSPROF_SOURCE_DIR}/avp/basic/json
    ${MSPROF_SOURCE_DIR}/avp/basic/atomic
    ${MSPROF_SOURCE_DIR}/avp/domain
    ${MSPROF_SOURCE_DIR}/avp/domain/collect/
    ${MSPROF_SOURCE_DIR}/avp/domain/collect/channel/
    ${MSPROF_SOURCE_DIR}/avp/domain/param/
    ${MSPROF_SOURCE_DIR}/avp/domain/platform/
    ${MSPROF_SOURCE_DIR}/avp/domain/transport/
    ${MSPROF_SOURCE_DIR}/avp/service/
    ${MSPROF_SOURCE_DIR}/avp/service/impl
    ${MSPROF_SOURCE_DIR}/avp/inc
    ${TOP_DIR}/metadef/inc
    ${TOP_DIR}/metadef/inc/external
    ${TOP_DIR}/inc/driver
    ${TOP_DIR}/inc/external/acl
    ${TOP_DIR}/inc/external/
    ${TOP_DIR}/llt/abl/msprof/st/data/
    ${TOP_DIR}/ace/npuruntime/inc
    ${TOP_DIR}/inc/
    ${ACLJSON_STUB_DIR}/device
    ${ACLJSON_STUB_DIR}/host
    ${ACLJSON_STUB_DIR}/common
    ${ACLJSON_STUB_DIR}/
)

set(test_file
    testcase/main.cpp
    ../acljson/testcase/acljson_nano_stest.cpp
    ../acljson/testcase/acljson_nano_c_stest.cpp
    ../acljson/testcase/acljson_basic_c_stest.cpp
)

set(stub_file
    ../stub/slog_stub.cc
    ${ACLJSON_STUB_DIR}/device/msprof_start.cpp
    ${ACLJSON_STUB_DIR}/device/data_report_manager.cpp
    ${ACLJSON_STUB_DIR}/device/data_report.cpp
    ${ACLJSON_STUB_DIR}/device/data_check.cpp
    ${ACLJSON_STUB_DIR}/device/device_drv_prof_stub.cpp
    ${ACLJSON_STUB_DIR}/device/device_simulator_manager.cpp
    ${ACLJSON_STUB_DIR}/device/tiny_device_simulator.cpp
    ${ACLJSON_STUB_DIR}/device/mini_device_simulator.cpp
    ${ACLJSON_STUB_DIR}/device/cloud_device_simulator.cpp
    ${ACLJSON_STUB_DIR}/device/mdc_mini_v3_device_simulator.cpp
    ${ACLJSON_STUB_DIR}/device/mini_stars_device_simulator.cpp
    ${ACLJSON_STUB_DIR}/device/stars_device_simulator.cpp
    ${ACLJSON_STUB_DIR}/device/david_device_simulator.cpp
    ${ACLJSON_STUB_DIR}/device/david_v121_device_simulator.cpp
    ${ACLJSON_STUB_DIR}/device/mdc_lite_device_simulator.cpp
    ${ACLJSON_STUB_DIR}/device/mdc_device_simulator.cpp
    ${ACLJSON_STUB_DIR}/device/dc_device_simulator.cpp
    ${ACLJSON_STUB_DIR}/device/nano_device_simulator.cpp
    ${ACLJSON_STUB_DIR}/device/device_simulator.cpp
    ${ACLJSON_STUB_DIR}/host/msprof_stub.cpp
    stub/mmpa_c_stub.cpp
)

add_executable(acljson_nano_c_stest
    ${src_c_file}
    ${test_file}
    ${stub_file}
)


target_include_directories(acljson_nano_c_stest PRIVATE
    ${INCLUDE_DIR}
)

target_compile_options(acljson_nano_c_stest PRIVATE
    -g
    -Wall
    -Werror
)

target_compile_definitions(acljson_nano_c_stest PRIVATE
    C_SEC
    OSAL
    __PROF_LLT
    google=ascend_private
    MSPROF_C
    LLT_DATA_DIR="${LLT_DATA_DIR}"
)

target_link_options(acljson_nano_c_stest PRIVATE
   -ldl
   -lpthread
)

target_link_libraries(acljson_nano_c_stest PRIVATE
    $<BUILD_INTERFACE:intf_llt_pub>
    $<BUILD_INTERFACE:mmpa_headers>
    $<BUILD_INTERFACE:slog_headers>
    $<BUILD_INTERFACE:adump_headers>
    $<BUILD_INTERFACE:msprof_headers>
    proftransport_st_static
    profapi_lite_st
    json
    c_sec
)

set_target_properties(acljson_nano_c_stest
    PROPERTIES
    OUTPUT_NAME acljson_nano_c_stest
    LIBRARY_OUTPUT_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}
)

run_llt_test(
    TARGET acljson_nano_c_stest
    TASK_NUM 1
)

####################### libproftransport.a ###########################
set(proftransportCpp
    ${MSPROF_SOURCE_DIR}/dvvp/common/utils/utils.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/common/cmd_log/cmd_log.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/common/config/config_manager.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/common/statistics/perf_count.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/transport/file_ageing.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/transport/file_slice.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/transport/file_transport.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/transport/file_manager.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/transport/file_interface.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/driver/devmgmt/ai_drv_dev_api.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/depend/stub/error_manager/msprof_error_manager_stub.cpp
    ../../stub/error_manager_stub.cpp
)

set(proftransportInc
    ${MSPROF_SOURCE_DIR}/dvvp
    ${MSPROF_SOURCE_DIR}/dvvp/common
    ${MSPROF_SOURCE_DIR}/dvvp/common/singleton
    ${MSPROF_SOURCE_DIR}/dvvp/common/utils
    ${MSPROF_SOURCE_DIR}/dvvp/common/cmd_log
    ${MSPROF_SOURCE_DIR}/dvvp/common/config
    ${MSPROF_SOURCE_DIR}/dvvp/common/logger
    ${MSPROF_SOURCE_DIR}/dvvp/common/statistics
    ${MSPROF_SOURCE_DIR}/dvvp/transport
    ${MSPROF_SOURCE_DIR}/dvvp/driver/inc
    ${MSPROF_SOURCE_DIR}/dvvp/depend/include/stub
    ${MSPROF_SOURCE_DIR}/basic/
    ${MSPROF_SOURCE_DIR}/basic/osal
    ${MSPROF_SOURCE_DIR}/avp/
    ${TOP_DIR}/inc/driver
    ${CMAKE_CURRENT_SOURCE_DIR}
)

add_library(proftransport_st_static STATIC
    ${MSPROF_SOURCE_DIR}/basic/osal/osal.c
    ${MSPROF_SOURCE_DIR}/basic/osal/osal_linux.c
    ${proftransportCpp}
    ../stub/slog_stub.cc
)

target_include_directories(proftransport_st_static PRIVATE
    ${proftransportInc}
    ${TOP_DIR}/graphengine/inc
    ${TOP_DIR}/graphengine/inc/framework
    ${TOP_DIR}/metadef/inc
    ${TOP_DIR}/metadef/inc/external
    ${MSPROF_SOURCE_DIR}/dvvp/depend/c_base
)

set_target_properties(proftransport_st_static
    PROPERTIES
    OUTPUT_NAME proftransport
    LIBRARY_OUTPUT_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/
)

target_compile_definitions(proftransport_st_static PRIVATE
    OSAL
)

target_compile_options(proftransport_st_static PRIVATE
    -g
    -Wall
    -Werror
)

target_link_options(proftransport_st_static PRIVATE
    -Wl,-z,relro,-z,now,-z,noexecstack
    -Wl,-Bsymbolic
    -Wl,--exclude-libs=ALL
)

target_link_libraries(proftransport_st_static PRIVATE
    $<BUILD_INTERFACE:intf_pub>
    $<BUILD_INTERFACE:msprof_headers>
    $<BUILD_INTERFACE:slog_headers>
    -Wl,--no-as-needed
    c_sec
    -Wl,--as-needed
)

install(TARGETS proftransport_st_static OPTIONAL
    LIBRARY DESTINATION ${INSTALL_LIBRARY_DIR}
)
####################### libproftransport.a ###########################

####################### libprofapi_lite.so ###########################
set(prof_api_src_file
    ${MSPROF_SOURCE_DIR}/dvvp/profapi/src/prof_avp_inner_api.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/profapi/src/prof_avp_plugin.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/profapi/src/prof_plugin.cpp
)

add_library(profapi_lite_st SHARED
    ${prof_api_src_file}
    # add stub files in target profapi_lite_st to call api in prof_inner_api.cpp
    ${ACLJSON_STUB_DIR}/host/acl_stub.cpp
    ${ACLJSON_STUB_DIR}/host/ge_stub.cpp
    ${LLT_DATA_DIR}/data_manager.cpp
    ../stub/slog_stub.cc
)

target_compile_definitions(profapi_lite_st PRIVATE
    MSPROF_C
    # special macro for libprofapi.so using for prof c architecture
    MSPROF_C_CPP
    $<$<STREQUAL:${TARGET_SYSTEM_NAME},Windows>:WIN32>
    LLT_DATA_DIR="${LLT_DATA_DIR}"
)

set_target_properties(profapi_lite_st
    PROPERTIES
    OUTPUT_NAME profapi
    LIBRARY_OUTPUT_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/
)

target_compile_options(profapi_lite_st PRIVATE
    -fstack-protector-all
    -Wall
    -Wextra
    -Wfloat-equal
    -g
    -O0
    -Werror
)

target_link_options(profapi_lite_st PRIVATE
    -Wl,-z,relro,-z,now,-z,noexecstack
    -Wl,-Bsymbolic
    -Wl,--exclude-libs=ALL
)

target_include_directories(profapi_lite_st PRIVATE
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
    ${TOP_DIR}/inc/external
    ${TOP_DIR}/metadef/inc
    ${TOP_DIR}/metadef/inc/external
    ${ACLJSON_STUB_DIR}/device
    ${ACLJSON_STUB_DIR}/host
    ${LLT_DATA_DIR}
    data
)

target_link_libraries(profapi_lite_st
    PRIVATE
        intf_pub
        mmpa_headers
        slog_headers
    PUBLIC
        msprof_headers
    json
    $<$<STREQUAL:${TARGET_SYSTEM_NAME},Linux>:dl>
)

install(TARGETS profapi_lite_st OPTIONAL
    LIBRARY DESTINATION ${CMAKE_CURRENT_BINARY_DIR}
)

####################### acljson_liteos_stest ###########################

set(src_c_file
    ${MSPROF_SOURCE_DIR}/basic/osal/osal.c
    ${MSPROF_SOURCE_DIR}/basic/osal/osal_linux.c
    ${MSPROF_SOURCE_DIR}/basic/osal/osal_thread.c
    ${MSPROF_SOURCE_DIR}/avp/domain/transport/flash_transport.c
    ${MSPROF_SOURCE_DIR}/avp/domain/param/profile_param.c
    ${MSPROF_SOURCE_DIR}/avp/domain/platform/platform.c
    ${MSPROF_SOURCE_DIR}/avp/domain/platform/platform_interface.c
    ${MSPROF_SOURCE_DIR}/avp/domain/platform/platform_table.c
    ${MSPROF_SOURCE_DIR}/avp/basic/utils/utils.c
    ${MSPROF_SOURCE_DIR}/avp/basic/hal/hal_dsmi.c
    ${MSPROF_SOURCE_DIR}/avp/basic/json/json_parser.c
    ${MSPROF_SOURCE_DIR}/avp/basic/json/sort_vector.c
    ${MSPROF_SOURCE_DIR}/avp/basic/json/vector.c
    ${MSPROF_SOURCE_DIR}/avp/domain/platform/chip/chip_nano_v1.c
)

set(INCLUDE_DIR
    ${MSPROF_SOURCE_DIR}/dvvp/transport
    ${MSPROF_SOURCE_DIR}/basic/
    ${MSPROF_SOURCE_DIR}/basic/osal
    ${MSPROF_SOURCE_DIR}/avp/
    ${MSPROF_SOURCE_DIR}/avp/basic
    ${MSPROF_SOURCE_DIR}/avp/basic/thread
    ${MSPROF_SOURCE_DIR}/avp/basic/hal/
    ${MSPROF_SOURCE_DIR}/avp/basic/utils
    ${MSPROF_SOURCE_DIR}/avp/basic/errno
    ${MSPROF_SOURCE_DIR}/avp/basic/logger
    ${MSPROF_SOURCE_DIR}/avp/basic/cstl
    ${MSPROF_SOURCE_DIR}/avp/basic/json
    ${MSPROF_SOURCE_DIR}/avp/basic/atomic
    ${MSPROF_SOURCE_DIR}/avp/domain
    ${MSPROF_SOURCE_DIR}/avp/domain/collect/
    ${MSPROF_SOURCE_DIR}/avp/domain/collect/channel/
    ${MSPROF_SOURCE_DIR}/avp/domain/param/
    ${MSPROF_SOURCE_DIR}/avp/domain/platform/
    ${MSPROF_SOURCE_DIR}/avp/domain/transport/
    ${MSPROF_SOURCE_DIR}/avp/service/
    ${MSPROF_SOURCE_DIR}/avp/service/impl
    ${MSPROF_SOURCE_DIR}/avp/inc
    ${TOP_DIR}/metadef/inc
    ${TOP_DIR}/metadef/inc/external
    ${TOP_DIR}/inc/driver
    ${TOP_DIR}/inc/external/acl
    ${TOP_DIR}/inc/external/
    ${TOP_DIR}/llt/abl/msprof/st/data/
    ${TOP_DIR}/ace/npuruntime/inc
    ${TOP_DIR}/inc/
    ${ACLJSON_STUB_DIR}/device
    ${ACLJSON_STUB_DIR}/host
    ${ACLJSON_STUB_DIR}/common
    ${ACLJSON_STUB_DIR}/
    stub/
)

set(test_file
    testcase/main.cpp
    ../acljson/testcase/acljson_basic_liteos_stest.cpp
)

set(stub_file
    ../stub/slog_stub.cc
    ${ACLJSON_STUB_DIR}/device/msprof_start.cpp
    ${ACLJSON_STUB_DIR}/device/data_report_manager.cpp
    ${ACLJSON_STUB_DIR}/device/data_report.cpp
    ${ACLJSON_STUB_DIR}/device/data_check.cpp
    ${ACLJSON_STUB_DIR}/device/device_drv_prof_stub.cpp
    ${ACLJSON_STUB_DIR}/device/device_simulator_manager.cpp
    ${ACLJSON_STUB_DIR}/device/tiny_device_simulator.cpp
    ${ACLJSON_STUB_DIR}/device/mini_device_simulator.cpp
    ${ACLJSON_STUB_DIR}/device/cloud_device_simulator.cpp
    ${ACLJSON_STUB_DIR}/device/mdc_mini_v3_device_simulator.cpp
    ${ACLJSON_STUB_DIR}/device/mini_stars_device_simulator.cpp
    ${ACLJSON_STUB_DIR}/device/stars_device_simulator.cpp
    ${ACLJSON_STUB_DIR}/device/david_device_simulator.cpp
    ${ACLJSON_STUB_DIR}/device/david_v121_device_simulator.cpp
    ${ACLJSON_STUB_DIR}/device/mdc_lite_device_simulator.cpp
    ${ACLJSON_STUB_DIR}/device/mdc_device_simulator.cpp
    ${ACLJSON_STUB_DIR}/device/dc_device_simulator.cpp
    ${ACLJSON_STUB_DIR}/device/nano_device_simulator.cpp
    ${ACLJSON_STUB_DIR}/device/device_simulator.cpp
    ${ACLJSON_STUB_DIR}/host/msprof_stub.cpp
    stub/mmpa_c_stub.cpp
)

add_executable(acljson_liteos_stest
    ${src_c_file}
    ${test_file}
    ${stub_file}
)


target_include_directories(acljson_liteos_stest PRIVATE
    ${INCLUDE_DIR}
)

target_compile_options(acljson_liteos_stest PRIVATE
    -g
    -Wall
    -Werror
)

target_compile_definitions(acljson_liteos_stest PRIVATE
    C_SEC
    OSAL
    __PROF_LLT
    google=ascend_private
    MSPROF_C
    LITE_OS
    LLT_DATA_DIR="${LLT_DATA_DIR}"
)

target_link_options(acljson_liteos_stest PRIVATE
   -ldl
   -lpthread
)

target_link_libraries(acljson_liteos_stest PRIVATE
    $<BUILD_INTERFACE:intf_llt_pub>
    $<BUILD_INTERFACE:mmpa_headers>
    $<BUILD_INTERFACE:slog_headers>
    $<BUILD_INTERFACE:adump_headers>
    $<BUILD_INTERFACE:msprof_headers>
    proftransport_st_static
    profapi_lite_st
    json
    c_sec
)

set_target_properties(acljson_liteos_stest
    PROPERTIES
    OUTPUT_NAME acljson_liteos_stest
    LIBRARY_OUTPUT_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}
)

run_llt_test(
    TARGET acljson_liteos_stest
    TASK_NUM 1
)