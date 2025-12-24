# -----------------------------------------------------------------------------------------------------------
# Copyright (c) 2025 Huawei Technologies Co., Ltd.
# This program is free software, you can redistribute it and/or modify it under the terms and conditions of
# CANN Open Software License Agreement Version 2.0 (the "License").
# Please refer to the License for details. You may not use this file except in compliance with the License.
# THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
# INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
# See LICENSE in the root of the software repository for the full text of the License.
# -----------------------------------------------------------------------------------------------------------
protobuf_generate(host_utest_proto
    CppPath
    HeaderPath
    ${MSPROF_SOURCE_DIR}/dvvp/proto/profiler.proto
)
set(commonSrcFiles
    ${MSPROF_SOURCE_DIR}//dvvp/profhal/adx/wrapper/adx_prof_api.cpp
    ${MSPROF_SOURCE_DIR}//dvvp/common/utils/utils.cpp
    ${MSPROF_SOURCE_DIR}//dvvp/common/config/config_manager.cpp
    ${MSPROF_SOURCE_DIR}//dvvp/common/thread/thread.cpp
    ${MSPROF_SOURCE_DIR}//dvvp/common/thread/thread_pool.cpp
    ${MSPROF_SOURCE_DIR}//dvvp/common/memory/chunk_pool.cpp
    ${MSPROF_SOURCE_DIR}//dvvp/common/platform/platform.cpp
    ${MSPROF_SOURCE_DIR}//dvvp/common/statistics/perf_count.cpp
    ${MSPROF_SOURCE_DIR}/basic/osal/osal.c
    ${MSPROF_SOURCE_DIR}//dvvp/app/application.cpp
    ${MSPROF_SOURCE_DIR}//dvvp/message/codec.cpp
    ${MSPROF_SOURCE_DIR}//dvvp/message/dispatcher.cpp
    ${MSPROF_SOURCE_DIR}//dvvp/transport/file_transport.cpp
    ${MSPROF_SOURCE_DIR}//dvvp/driver/devmgmt/ai_drv_dev_api.cpp
    ${MSPROF_SOURCE_DIR}//dvvp/driver/devmgmt/mini/ai_drv_dsmi_api.cpp
    ${MSPROF_SOURCE_DIR}//dvvp/driver/channel/ai_drv_prof_api.cpp
    ${MSPROF_SOURCE_DIR}//dvvp/transport/file_slice.cpp
    ${MSPROF_SOURCE_DIR}//dvvp/transport/file_ageing.cpp
    ${CppPath}
)

set(profilerSrcFiles
    ${MSPROF_SOURCE_DIR}//dvvp/task_handle/src/prof_manager.cpp
    ${MSPROF_SOURCE_DIR}//dvvp/task_handle/src/prof_task.cpp
    ${MSPROF_SOURCE_DIR}//dvvp/task_handle/src/device.cpp
    ${MSPROF_SOURCE_DIR}//dvvp/task_handle/src/info_json.cpp
    ${MSPROF_SOURCE_DIR}//dvvp/task_handle/src/prof_params_adapter.cpp
    ${MSPROF_SOURCE_DIR}//dvvp/task_handle/src/task_relationship_mgr.cpp
    ${MSPROF_SOURCE_DIR}//dvvp/profimpl/collect/job_wrapper/src/prof_channel_manager.cpp
    ${MSPROF_SOURCE_DIR}//dvvp/profimpl/collect/job_wrapper/src/job_factory.cpp
    ${MSPROF_SOURCE_DIR}//dvvp/profimpl/collect/job_wrapper/src/job_device_rpc.cpp
    ${MSPROF_SOURCE_DIR}//dvvp/profimpl/collect/job_wrapper/src/job_device_soc.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/profimpl/collect/job_wrapper/src/collection_job.cpp
    ${MSPROF_SOURCE_DIR}//dvvp/profimpl/collect/job_wrapper/src/collection_register.cpp
    ${MSPROF_SOURCE_DIR}//dvvp/profimpl/collect/job_wrapper/src/prof_timer.cpp
    ${MSPROF_SOURCE_DIR}//dvvp/profimpl/collect/job_wrapper/src/prof_comm_job.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/profimpl/collect/job_wrapper/src/prof_hardware_mem_job.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/profimpl/collect/job_wrapper/src/prof_dvpp_job.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/profimpl/collect/job_wrapper/src/prof_lpm_job.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/profimpl/collect/job_wrapper/src/prof_inter_connection_job.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/profimpl/collect/job_wrapper/src/prof_io_job.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/profimpl/collect/job_wrapper/src/prof_perf_job.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/profimpl/collect/job_wrapper/src/prof_comm_job.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/profimpl/collect/job_wrapper/src/prof_ts_job.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/profimpl/collect/job_wrapper/src/prof_stars_job.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/profimpl/collect/job_wrapper/src/prof_ccu_job.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/profimpl/collect/job_wrapper/src/prof_hwts_log_job.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/profimpl/collect/job_wrapper/src/prof_instr_perf_job.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/profimpl/collect/job_wrapper/src/prof_biu_perf_job.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/profimpl/collect/job_wrapper/src/prof_aicore_job.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/profimpl/collect/job_wrapper/src/prof_sys_info_job.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/profimpl/collect/job_wrapper/src/prof_l2cache_job.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/profimpl/collect/job_wrapper/src/prof_soc_pmu_job.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/profimpl/collect/job_wrapper/src/adprof_collector_proxy.cpp
    ${MSPROF_SOURCE_DIR}//dvvp/transport/prof_channel.cpp
    ${MSPROF_SOURCE_DIR}//dvvp/transport/uploader.cpp
    ${MSPROF_SOURCE_DIR}//dvvp/transport/uploader_mgr.cpp
    ${MSPROF_SOURCE_DIR}//dvvp/transport/hdc/device_transport.cpp
    ${MSPROF_SOURCE_DIR}//dvvp/transport/hdc/hdc_transport.cpp
    ${MSPROF_SOURCE_DIR}//dvvp/transport/hdc/platform/rpc/dev_mgr_api.cpp
    ${MSPROF_SOURCE_DIR}//dvvp/common/validation/param_validation.cpp
    ${commonSrcFiles}
)

set(localSrcFiles
    test/main.cpp
    ../stub/hdc-api-stub.cpp
    ../stub/hdc-log-stub.cpp
    ../stub/collect_io_server_stub.cpp
    ../stub/common-utils-stub.cpp
    ../stub/devdrv_runtime_api_stub.cpp
    ../stub/profile_drv_user_stub.cpp
    test/data_handle_utest.cpp
    test/prof_host_core_utest.cpp
    test/prof_manager_utest.cpp
    test/prof_task_utest.cpp
    test/prof_write_info_utest.cpp
    test/prof_device_utest.cpp
    test/prof_params_adapter_utest.cpp
)

add_executable(host_utest
    ${profilerSrcFiles}
    ${localSrcFiles}
)

target_include_directories(host_utest PRIVATE
    ${TOP_DIR}/abl/libc_sec/include
    ${TOP_DIR}/inc/driver
    ${TOP_DIR}/inc/tsch
    ${TOP_DIR}/inc/external/acl
    ${TOP_DIR}/abl/adump
    ${TOP_DIR}/abl/adump/external
    ${TOP_DIR}/ace/npuruntime/inc
    ${TOP_DIR}/metadef/inc
    ../stub/
    ${TOP_DIR}/llt/abl/msprof/st/stub
    ${MSPROF_SOURCE_DIR}/dvvp
    ${MSPROF_SOURCE_DIR}/dvvp/profhal/adx/inc
    ${MSPROF_SOURCE_DIR}/dvvp/aging
    ${MSPROF_SOURCE_DIR}/dvvp/common
    ${MSPROF_SOURCE_DIR}/dvvp/common/config
    ${MSPROF_SOURCE_DIR}/dvvp/common/logger
    ${MSPROF_SOURCE_DIR}/dvvp/common/validation
    ${MSPROF_SOURCE_DIR}/dvvp/common/statistics
    ${MSPROF_SOURCE_DIR}/basic/osal
    ${MSPROF_SOURCE_DIR}/dvvp/common/errno
    ${MSPROF_SOURCE_DIR}/dvvp/host/include
    ${MSPROF_SOURCE_DIR}/dvvp/streamio/server/include
    ${MSPROF_SOURCE_DIR}/dvvp/profimpl/collect/job_wrapper/include
    ${MSPROF_SOURCE_DIR}/dvvp/driver/inc
    ${MSPROF_SOURCE_DIR}/dvvp/transport
    ${MSPROF_SOURCE_DIR}/dvvp/task_handle/include
    ${MSPROF_SOURCE_DIR}/dvvp/streamio/common/include
    ${CMAKE_BINARY_DIR}/proto/host_utest_proto/
    ${MSPROF_SOURCE_DIR}/dvvp/depend/include/stub
)

target_compile_options(host_utest PRIVATE
    -g
    -pipe
    -Wall
    -std=c++11
    -fno-access-control
    -Wfloat-equal
    -Wextra
    -Werror
)

target_compile_definitions(host_utest PRIVATE
    C_SEC
    MSPROF_DEBUG
    google=ascend_private
)

target_link_libraries(host_utest PRIVATE
    $<BUILD_INTERFACE:intf_llt_pub>
    $<BUILD_INTERFACE:mmpa_headers>
    ascend_protobuf
    c_sec
)

set_target_properties(host_utest
    PROPERTIES
    OUTPUT_NAME host_utest
    LIBRARY_OUTPUT_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}
)

run_llt_test(
    TARGET host_utest
    TASK_NUM 1
)

