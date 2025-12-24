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

set(msprofSrcList
    ${MSPROF_SOURCE_DIR}/dvvp/common/memory/chunk_pool.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/common/thread/thread.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/common/socket/local_socket.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/common/config/config_manager.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/common/thread/thread_pool.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/common/statistics/perf_count.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/common/utils/utils.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/common/cmd_log/cmd_log.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/common/validation/param_validation.cpp
    ${MSPROF_SOURCE_DIR}/basic/osal/osal.c
    ${MSPROF_SOURCE_DIR}/dvvp/depend/stub/error_manager/msprof_error_manager_stub.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/driver/devmgmt/ai_drv_dev_api.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/driver/devmgmt/ai_drv_dsmi_api.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/driver/channel/ai_drv_prof_api.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/message/codec.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/common/platform/platform.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/profimpl/adapter/src/json_parser.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/profimpl/platform/platform_interface.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/profimpl/platform/nano_platform.cpp
    ${MSPROF_SOURCE_DIR}//dvvp/common/json/json.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/acp/src/acp_manager.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/acp/src/acp_api_plugin.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/acp/src/op_transport.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/acp/src/op_analyzer.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/acp/src/op_data_manager.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/acp/src/op_analyzer_base.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/acp/src/op_analyzer_pmu.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/acp/src/op_analyzer_biu.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/acp/src/op_analyzer_pc_sampling.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/transport/uploader.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/transport/uploader_mgr.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/transport/prof_channel.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/profimpl/collect/job_wrapper/src/collection_job.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/profimpl/collect/job_wrapper/src/collection_register.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/profimpl/collect/job_wrapper/src/prof_comm_job.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/profimpl/collect/job_wrapper/src/prof_channel_manager.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/profimpl/collect/job_wrapper/src/prof_stars_job.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/profimpl/collect/job_wrapper/src/prof_biu_perf_job.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/acp/src/acp_compute_device_job.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/acp/src/acp_pipe_transfer.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/profimpl/platform/base_analyzer.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/profimpl/platform/cloud_v2_platform.cpp
    ${CppPath}
)

set(testCfgSrcFile
    ../stub/common-utils-stub.cpp
    ../stub/devdrv_runtime_api_stub.cpp
    ../stub/profile_drv_user_stub.cpp
    ../stub/hdc-log-stub.cpp
    testcase/main.cpp
    testcase/config_manager_stest.cpp
    testcase/local_socket_stest.cpp
    testcase/nano_json_test.cpp
    testcase/utils_stest.cpp
    testcase/ring_buffer_stest.cpp
    testcase/platform_stest.cpp
    ${msprofSrcList}
)

add_executable(
    common_stest
    ${testCfgSrcFile}
)

target_include_directories(common_stest PRIVATE
    ../
    ../stub
    ${TOP_DIR}/llt/abl/msprof/ut/stub
    ${TOP_DIR}/abl/libc_sec/include
    ${TOP_DIR}/inc/driver
    ${TOP_DIR}/inc/external
    ${TOP_DIR}/abl/adump
    ${TOP_DIR}/ace/npuruntime/inc
    ${TOP_DIR}/abl/msprof/inc
    ${TOP_DIR}/metadef/inc
    ${TOP_DIR}/metadef/inc/external
    ${TOP_DIR}/abl/msprof/inc/toolchain
    ${MSPROF_SOURCE_DIR}/dvvp
    ${MSPROF_SOURCE_DIR}/dvvp/acp/include
    ${MSPROF_SOURCE_DIR}/dvvp/analyze/inc
    ${MSPROF_SOURCE_DIR}/dvvp/common
    ${MSPROF_SOURCE_DIR}/dvvp/common/statistics
    ${MSPROF_SOURCE_DIR}/dvvp/common/logger
    ${MSPROF_SOURCE_DIR}/dvvp/driver/inc
    ${MSPROF_SOURCE_DIR}/dvvp/profapi/inc
    ${MSPROF_SOURCE_DIR}/dvvp/common/errno
    ${MSPROF_SOURCE_DIR}/dvvp/common/validation
    ${MSPROF_SOURCE_DIR}/dvvp/common/config
    ${MSPROF_SOURCE_DIR}/dvvp/common/platform
    ${MSPROF_SOURCE_DIR}/dvvp/message
    ${MSPROF_SOURCE_DIR}/dvvp/transport
    ${MSPROF_SOURCE_DIR}/dvvp/common/cmd_log
    ${MSPROF_SOURCE_DIR}/basic/osal
    ${CMAKE_BINARY_DIR}/proto/profiler/
    ${MSPROF_SOURCE_DIR}/dvvp/depend/include/stub
    ${MSPROF_SOURCE_DIR}/dvvp/profimpl/adapter/inc
    ${MSPROF_SOURCE_DIR}/dvvp/profimpl/platform
    ${MSPROF_SOURCE_DIR}/dvvp/profimpl/inc
    ${MSPROF_SOURCE_DIR}/dvvp/profimpl/collect/job_wrapper/include
    ${MSPROF_SOURCE_DIR}/dvvp/task_handle/include
    ${TOP_DIR}/ace/npuruntime/inc/external/
)

target_compile_options(common_stest PRIVATE
    -g
    -pipe
    -Wall
    -std=c++11
    -fno-access-control
    -Wfloat-equal
    -Wextra
    -Werror
)

target_compile_definitions(common_stest PRIVATE
    C_SEC
    MSPROF_DEBUG
    google=ascend_private
)

target_link_options(common_stest PRIVATE
   -ldl
   -lpthread
)

target_link_libraries(common_stest PRIVATE
    $<BUILD_INTERFACE:intf_llt_pub>
    $<BUILD_INTERFACE:mmpa_headers>
    $<BUILD_INTERFACE:slog_headers>
    $<BUILD_INTERFACE:adump_headers>
    ascend_protobuf
    c_sec
)

set_target_properties(common_stest
    PROPERTIES
    OUTPUT_NAME common_stest
    LIBRARY_OUTPUT_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}
)

run_llt_test(
    TARGET common_stest
    TASK_NUM 1
)

###################### osal_linux_stest ###########################
set(osalLinuxSrc
    testcase/main.cpp
    testcase/osal_linux_stest.cpp
    ${MSPROF_SOURCE_DIR}/basic/osal/osal_linux.c
    ${MSPROF_SOURCE_DIR}/basic/osal/osal_linux_mem.c
    ../stub/common-utils-stub.cpp
    ../stub/hdc-log-stub.cpp
)

add_executable(osal_linux_stest
    ${osalLinuxSrc}
)

target_include_directories(osal_linux_stest PRIVATE
    ${MSPROF_SOURCE_DIR}/dvvp/common
    ${MSPROF_SOURCE_DIR}/basic/osal
)

target_compile_options(osal_linux_stest PRIVATE
    -g
    -pipe
    -Wall
    -std=c++11
    -fno-access-control
    -Wfloat-equal
    -Wextra
    -Werror
)

target_compile_definitions(osal_linux_stest PRIVATE
    C_SEC
    OSAL
    google=ascend_private
)

target_link_options(osal_linux_stest PRIVATE
   -ldl
   -lpthread
)

target_link_libraries(osal_linux_stest PRIVATE
    $<BUILD_INTERFACE:intf_llt_pub>
    $<BUILD_INTERFACE:mmpa_headers>
    $<BUILD_INTERFACE:slog_headers>
    c_sec
)

set_target_properties(osal_linux_stest
    PROPERTIES
    OUTPUT_NAME osal_linux_stest
    LIBRARY_OUTPUT_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}
)

run_llt_test(
    TARGET osal_linux_stest
    TASK_NUM 1
)

###################### osal_liteos_stest ###########################
set(osalLinuxSrc
    testcase/main.cpp
    testcase/osal_liteos_stest.cpp
    ${MSPROF_SOURCE_DIR}/basic/osal/osal_linux.c
    ${MSPROF_SOURCE_DIR}/basic/osal/osal_liteos_mem.c
    ${MSPROF_SOURCE_DIR}/avp/basic/atomic/atomic_liteos.c
    stub/hal_ts_stub.cpp
    stub/los_atomic_stub.cpp
    ../stub/common-utils-stub.cpp
)

add_executable(osal_liteos_stest
    ${osalLinuxSrc}
)

target_include_directories(osal_liteos_stest PRIVATE
    ${MSPROF_SOURCE_DIR}/dvvp/common
    ${MSPROF_SOURCE_DIR}/basic/osal
    ${MSPROF_SOURCE_DIR}/avp/basic/atomic
    stub/
)

target_compile_options(osal_liteos_stest PRIVATE
    -g
    -pipe
    -Wall
    -std=c++11
    -fno-access-control
    -Wfloat-equal
    -Wextra
    -Werror
)

target_compile_definitions(osal_liteos_stest PRIVATE
    C_SEC
    OSAL
    google=ascend_private
)

target_link_options(osal_liteos_stest PRIVATE
   -ldl
   -lpthread
)

target_link_libraries(osal_liteos_stest PRIVATE
    $<BUILD_INTERFACE:intf_llt_pub>
    $<BUILD_INTERFACE:mmpa_headers>
    $<BUILD_INTERFACE:slog_headers>
    c_sec
)

set_target_properties(osal_liteos_stest
    PROPERTIES
    OUTPUT_NAME osal_liteos_stest
    LIBRARY_OUTPUT_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}
)

run_llt_test(
    TARGET osal_liteos_stest
    TASK_NUM 1
)