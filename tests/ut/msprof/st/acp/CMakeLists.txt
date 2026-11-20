# -----------------------------------------------------------------------------------------------------------
# Copyright (c) 2025 Huawei Technologies Co., Ltd.
# This program is free software, you can redistribute it and/or modify it under the terms and conditions of
# CANN Open Software License Agreement Version 2.0 (the "License").
# Please refer to the License for details. You may not use this file except in compliance with the License.
# THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
# INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
# See LICENSE in the root of the software repository for the full text of the License.
# -----------------------------------------------------------------------------------------------------------
set(testSrc
    testcase/main.cpp
    testcase/acp_bin_stest.cpp
)

set(src_file
    ../stub/drv_stub.cpp
    ../stub/mmpa_stub.cpp
    ../stub/hdc-log-stub.cpp
    ../stub/devdrv_runtime_api_stub.cpp
    ../stub/profile_drv_user_stub.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/acp/src/acp_bin.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/acp/src/acp_command.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/acp/src/acp_pipe_transfer.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/app/application.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/app/env_manager.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/common/argparse/argparser.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/common/utils/utils.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/common/cmd_log/cmd_log.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/common/config/config_manager.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/common/validation/param_validation.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/common/thread/thread.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/common/thread/thread_pool.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/common/socket/local_socket.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/common/json/json.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/common/platform/platform.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/common/statistics/perf_count.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/driver/devmgmt/ai_drv_dev_api.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/driver/devmgmt/msprof_drv_api.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/driver/channel/ai_drv_prof_api.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/depend/stub/error_manager/msprof_error_manager_stub.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/msprof/dynamic_profiling/src/dyn_prof_client.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/task_handle/src/task_relationship_mgr.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/profimpl/adapter/src/json_parser.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/profimpl/platform/platform_interface.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/profimpl/platform/cloud_v2_platform.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/profimpl/platform/david_platform.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/profimpl/platform/david_lite_platform.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/profimpl/platform/david_v121_platform.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/profimpl/platform/base_analyzer.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/profimpl/collect/job_wrapper/src/collection_job.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/profimpl/collect/job_wrapper/src/collection_register.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/profimpl/collect/job_wrapper/src/prof_comm_job.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/profimpl/collect/job_wrapper/src/prof_channel_manager.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/profimpl/collect/job_wrapper/src/prof_stars_job.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/profimpl/collect/job_wrapper/src/prof_ccu_job.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/transport/prof_channel.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/transport/uploader_mgr.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/transport/uploader.cpp
    ${MSPROF_SOURCE_DIR}/basic/osal/osal.c
)

add_executable(acp_stest
    ${testSrc}
    ${src_file}
)

target_include_directories(acp_stest PRIVATE
    ${CLI_STUB_DIR}/device
    ${TOP_DIR}/inc/driver
    ${TOP_DIR}/inc/external
    ${TOP_DIR}/inc/external/acl
    ${TOP_DIR}/abl/libc_sec/include
    ${TOP_DIR}/ace/npuruntime/inc
    ${TOP_DIR}/abl/msprof/inc
    ${TOP_DIR}/abl/msprof/inc/external
    ${TOP_DIR}/metadef/inc
    ${TOP_DIR}/metadef/inc/external
    ${TOP_DIR}/abl/msprof/inc/toolchain
    ${MSPROF_SOURCE_DIR}/dvvp/acp/include
    ${MSPROF_SOURCE_DIR}/dvvp/
    ${MSPROF_SOURCE_DIR}/dvvp/app
    ${MSPROF_SOURCE_DIR}/dvvp/common
    ${MSPROF_SOURCE_DIR}/dvvp/common/argparse
    ${MSPROF_SOURCE_DIR}/dvvp/common/cmd_log
    ${MSPROF_SOURCE_DIR}/dvvp/common/errno
    ${MSPROF_SOURCE_DIR}/dvvp/common/logger
    ${MSPROF_SOURCE_DIR}/dvvp/common/config
    ${MSPROF_SOURCE_DIR}/dvvp/common/singleton
    ${MSPROF_SOURCE_DIR}/dvvp/common/validation
    ${MSPROF_SOURCE_DIR}/dvvp/profimpl/platform
    ${MSPROF_SOURCE_DIR}/dvvp/profimpl/adapter/inc
    ${MSPROF_SOURCE_DIR}/dvvp/profimpl/collect/job_wrapper/include
    ${MSPROF_SOURCE_DIR}/dvvp/depend/include/stub
    ${MSPROF_SOURCE_DIR}/dvvp/msprof/dynamic_profiling/include/
    ${MSPROF_SOURCE_DIR}/dvvp/driver/inc
    ${MSPROF_SOURCE_DIR}/dvvp/transport
    ${MSPROF_SOURCE_DIR}/dvvp/task_handle/include
    ${MSPROF_SOURCE_DIR}/basic/osal
    ${TOP_DIR}/pkg_inc/driver
    ${TOP_DIR}/pkg_inc/runtime
    ${TOP_DIR}/pkg_inc/runtime/runtime
    ${TOP_DIR}/pkg_inc/base
    ${TOP_DIR}/pkg_inc/aicpu_sched
    ${TOP_DIR}/include/external/acl
    ${TOP_DIR}/include/external
    ${TOP_DIR}/src/inc
    ${MSPROF_SOURCE_DIR}/dvvp/msprof/msproftx/mstx/inc
    ${MSPROF_SOURCE_DIR}/dvvp/msprofbin/include
    ${MSPROF_SOURCE_DIR}/dvvp/common/utils
    ${MSPROF_SOURCE_DIR}/dvvp/analyze/inc
    ${TOP_DIR}/pkg_inc/profiling
    ${TOP_DIR}/src/dfx/msprof/inc/toolchain
)

target_compile_options(acp_stest PRIVATE
    -g
    -Wall
    -std=c++14
    -Werror
)

target_compile_definitions(acp_stest PRIVATE
    C_SEC
    __PROF_LLT
    google=ascend_private
)

target_link_options(acp_stest PRIVATE
   -ldl
   -lpthread
)

target_link_libraries(acp_stest PRIVATE
    $<BUILD_INTERFACE:intf_llt_pub>
    $<BUILD_INTERFACE:mmpa_headers>
    $<BUILD_INTERFACE:slog_headers>
    $<BUILD_INTERFACE:adump_headers>
    ascend_protobuf
    c_sec
    json
)

set_target_properties(acp_stest
    PROPERTIES
    OUTPUT_NAME acp_stest
    LIBRARY_OUTPUT_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}
)

run_llt_test(
    TARGET acp_stest
    TASK_NUM 1
)

add_executable(acp_manager_stest
    testcase/main.cpp
    testcase/acp_compute_device_job_stest.cpp
    testcase/dlclose_stub.cpp
    ../../acp/testcase/acp_manager_utest.cpp
    ${src_file}
    ${MSPROF_SOURCE_DIR}/dvvp/acp/src/acp_manager.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/driver/devmgmt/ai_drv_dsmi_api.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/profimpl/collect/job_wrapper/src/prof_biu_perf_job.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/profimpl/collect/job_wrapper/src/prof_collect_info.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/acp/src/acp_api_plugin.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/acp/src/acp_runtime_api.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/acp/src/acp_compute_device_job.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/acp/src/op_analyzer_base.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/acp/src/op_analyzer_pmu.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/acp/src/op_analyzer_biu.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/acp/src/op_analyzer_pc_sampling.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/acp/src/op_analyzer.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/acp/src/op_data_manager.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/acp/src/op_transport.cpp
)

target_include_directories(acp_manager_stest PRIVATE
    ${TOP_DIR}/output/third_party/lib_cache/gtest_shared/googletest/include
    ${TOP_DIR}/output/third_party/lib_cache/mockcpp/include
    ${TOP_DIR}/output/third_party/boost
    ${TOP_DIR}/output/third_party/lib_cache/csec/include
    ${TOP_DIR}/src/dfx/log/inc/toolchain
    ${MSPROF_SOURCE_DIR}/basic/osal
    ${TOP_DIR}/output/third_party/gtest_shared/include
    ${TOP_DIR}/output/third_party/lib_cache/mockcpp/include
    ${TOP_DIR}/src/inc
    ${TOP_DIR}/include
    ${TOP_DIR}/include/dfx
    ${TOP_DIR}/pkg_inc
    ${TOP_DIR}/pkg_inc/mmpa
    ${TOP_DIR}/pkg_inc/base
    ${TOP_DIR}/pkg_inc/runtime
    ${TOP_DIR}/pkg_inc/aicpu_sched
    ${TOP_DIR}/pkg_inc/driver
    ${TOP_DIR}/pkg_inc/profiling
    ${TOP_DIR}/include/external/acl
    ${TOP_DIR}/include/external
    ${TOP_DIR}/src/dfx/msprof/inc/toolchain
    ${MSPROF_SOURCE_DIR}/dvvp/app
    ${TOP_DIR}/include/external/acl
    ${MSPROF_SOURCE_DIR}/dvvp
    ${MSPROF_SOURCE_DIR}/dvvp/acp/include
    ${MSPROF_SOURCE_DIR}/dvvp/common
    ${MSPROF_SOURCE_DIR}/dvvp/common/argparse
    ${MSPROF_SOURCE_DIR}/dvvp/common/config
    ${MSPROF_SOURCE_DIR}/dvvp/common/errno
    ${MSPROF_SOURCE_DIR}/dvvp/common/logger
    ${MSPROF_SOURCE_DIR}/dvvp/common/validation
    ${MSPROF_SOURCE_DIR}/dvvp/common/platform
    ${MSPROF_SOURCE_DIR}/dvvp/common/utils
    ${MSPROF_SOURCE_DIR}/dvvp/common/json
    ${MSPROF_SOURCE_DIR}/dvvp/message
    ${MSPROF_SOURCE_DIR}/dvvp/analyze/inc
    ${MSPROF_SOURCE_DIR}/dvvp/transport
    ${MSPROF_SOURCE_DIR}/dvvp/task_handle/include
    ${MSPROF_SOURCE_DIR}/dvvp/profimpl/adapter/inc
    ${MSPROF_SOURCE_DIR}/dvvp/profimpl/platform
    ${MSPROF_SOURCE_DIR}/dvvp/profimpl/collect/job_wrapper/include
    ${MSPROF_SOURCE_DIR}/dvvp/msprof/engine/include
    ${MSPROF_SOURCE_DIR}/dvvp/msprof/dynamic_profiling/include
    ${MSPROF_SOURCE_DIR}/dvvp/msprof/msproftx/mstx/inc
    ${MSPROF_SOURCE_DIR}/dvvp/driver/inc
    ${MSPROF_SOURCE_DIR}/dvvp/profapi/inc
    ../acp/stub
    ../stub
    ${MSPROF_SOURCE_DIR}/dvvp/depend/include/stub
    ../../acp/stub
)

target_compile_options(acp_manager_stest PRIVATE
    -g
    -Wall
    -std=c++14
)

target_compile_definitions(acp_manager_stest PRIVATE
    __PROF_LLT
    C_SEC
    google=ascend_private
    BUILD_PROFILING_OPEN_PROJECT
)

target_link_options(acp_manager_stest PRIVATE
    -ldl
    -lpthread
)

target_link_libraries(acp_manager_stest PRIVATE
    $<BUILD_INTERFACE:msprof_utestonetrack_pub>
    c_sec
    ascend_protobuf_static
)

set_target_properties(acp_manager_stest
    PROPERTIES
    OUTPUT_NAME acp_manager_stest
    LIBRARY_OUTPUT_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}
)

run_llt_test(
    TARGET acp_manager_stest
    TASK_NUM 1
)
