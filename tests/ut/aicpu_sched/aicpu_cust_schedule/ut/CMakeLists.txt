# -----------------------------------------------------------------------------------------------------------
# Copyright (c) 2025 Huawei Technologies Co., Ltd.
# This program is free software, you can redistribute it and/or modify it under the terms and conditions of
# CANN Open Software License Agreement Version 2.0 (the "License").
# Please refer to the License for details. You may not use this file except in compliance with the License.
# THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
# INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
# See LICENSE in the root of the software repository for the full text of the License.
# -----------------------------------------------------------------------------------------------------------

set(SRC_PATH
    ${AICPU_SCHED_PATH}/aicpu_cust_schedule
)

set(proto_src_files
    ${SRC_PATH}/proto/dump_data.proto
    ${SRC_PATH}/proto/op_mapping_info.proto
)

protobuf_generate(aicpu_custom_proto PROTO_SRCS PROTO_HDRS ${proto_src_files} TARGET)

set(LOCAL_SRC_FILES
    ${SRC_PATH}/execute/main.cpp
    ${SRC_PATH}/common/feature_ctrl_open_source.cpp
    ${SRC_PATH}/common/feature_ctrl_common.cpp
    ${SRC_PATH}/common/aicpusd_sqe_adapter.cpp
    ${SRC_PATH}/core/aicpusd_args_parser.cpp
    ${SRC_PATH}/core/aicpusd_interface_process.cpp
    ${SRC_PATH}/core/aicpusd_event_manager.cpp
    ${SRC_PATH}/core/aicpusd_event_process.cpp
    ${SRC_PATH}/core/aicpusd_drv_manager.cpp
    ${SRC_PATH}/core/aicpusd_threads_process.cpp
    ${SRC_PATH}/core/aicpusd_op_executor.cpp
    ${SRC_PATH}/core/dfx/aicpusd_monitor.cpp
    ${SRC_PATH}/core/aicpusd_worker.cpp
    ${SRC_PATH}/core/aicpusd_task_queue.cpp
    ${SRC_PATH}/core/aicpusd_resource_limit.cpp
    ${SRC_PATH}/stub/proc_mgr/proc_mgr_sys_operator_agent.cpp
    ${SRC_PATH}/core/dfx/dump_task.cpp
    ${SRC_PATH}/core/dfx/aicpu_cust_sd_dump_process.cpp
    ${SRC_PATH}/core/cust_platform_info/aicpu_cust_platform_info_process.cpp
    ${SRC_PATH}/core/cust_mc2_maintenance/aicpu_cust_sd_mc2_maintenance_thread.cpp
    main_ut.cc
    testcase/c_stub.c
    testcase/slog_stub.cpp
    testcase/cpp_stub.cc
    testcase/driver_interface.cc
    testcase/aicpu_cust_schedule_test.cc
    testcase/aicpusd_args_parser_test.cc
    testcase/aicpusd_event_manager_test.cc
    testcase/aicpu_cust_monitor_test.cc
    testcase/aicpu_cust_work_test.cc
    testcase/aicpusd_task_queue_test.cc
    testcase/aicpusd_threads_process_test.cc
    ${PROTO_SRCS}
)

set(LOCAL_C_INCLUDES
    ${SRC_PATH}/core/cust_platform_info
    ${SRC_PATH}/core/cust_mc2_maintenance
    ${SRC_PATH}/core/dfx
    ${SRC_PATH}/core
    ${SRC_PATH}/common
    ${SRC_PATH}/stub/proc_mgr
    ${SRC_PATH}/stub
    ${SRC_PATH}
    ${AICPU_SCHED_PATH}/aicpu_processer
    ${AICPU_SCHED_PATH}/aicpu_sharder
    ${AICPU_SCHED_PATH}/aicpu_prof
    ${AICPU_SCHED_PATH}/extern_include
    ${AICPU_SCHED_PATH}
    ${RUNTIME_DIR}/pkg_inc/aicpu_sched/aicpu_schedule
    ${RUNTIME_DIR}/pkg_inc/aicpu_sched/cpu_kernels
    ${RUNTIME_DIR}/pkg_inc/profiling
    ${RUNTIME_DIR}/pkg_inc/base
    ${RUNTIME_DIR}/pkg_inc/aicpu_sched/common
    ${RUNTIME_DIR}/pkg_inc/tsd
    ${RUNTIME_DIR}/pkg_inc/aicpu_sched
    ${RUNTIME_DIR}/pkg_inc/runtime
    ${RUNTIME_DIR}/pkg_inc/runtime/runtime
    ${RUNTIME_DIR}/pkg_inc
    ${RUNTIME_DIR}/src/dfx/msprof/inc/toolchain
    ${RUNTIME_DIR}/src/dfx/adump/inc
    ${RUNTIME_DIR}/src/dfx/adump/inc/metadef
    ${RUNTIME_DIR}/src/inc
    ${RUNTIME_DIR}/include
    ${RUNTIME_DIR}/include/driver
    ${CMAKE_BINARY_DIR}/proto/aicpu_custom_proto/proto/
)

add_executable(aicpu_custom_schedule_utest
    ${LOCAL_SRC_FILES}
)

add_dependencies(aicpu_custom_schedule_utest aicpu_custom_proto)

target_include_directories(aicpu_custom_schedule_utest PRIVATE
    ${LOCAL_C_INCLUDES}
)

target_link_libraries(aicpu_custom_schedule_utest PRIVATE
    c_sec
    -ldl
    $<BUILD_INTERFACE:intf_aicpu_llt_pub>
    $<BUILD_INTERFACE:slog_headers>
    ascend_protobuf_static
    pthread
    seccomp_headers
    seccomp_stub
    c_sec_headers
)

target_compile_definitions(aicpu_custom_schedule_utest PRIVATE
    DT_COMPILE_GCC
    CFG_SOC_PLATFORM_CLOUD
    aicpusd_UT
    google=ascend_private
)

# test for stub? to delete
add_executable(aicpu_custom_schedule_utest_dc
    ${SRC_PATH}/stub/dc.cpp
    ${SRC_PATH}/stub/adc_prof.cpp
    ${SRC_PATH}/stub/aicpusd_resource_limit.cpp
    ${SRC_PATH}/../stub/seccomp_stub.cpp
    testcase/aicpu_cust_monitor_dc_test.cc
    testcase/aicpu_cust_adc_prof_test.cc
    main_ut.cc
)

target_include_directories(aicpu_custom_schedule_utest_dc PRIVATE
    ${LOCAL_C_INCLUDES}
)

target_compile_definitions(aicpu_custom_schedule_utest_dc PRIVATE
    DT_COMPILE_GCC
    CFG_SOC_PLATFORM_CLOUD
    aicpusd_UT
    RUN_TEST
    google=ascend_private
)

target_link_libraries(aicpu_custom_schedule_utest_dc PRIVATE
    c_sec
    -ldl
    $<BUILD_INTERFACE:intf_aicpu_llt_pub>
    $<BUILD_INTERFACE:slog_headers>
    ascend_protobuf_static
    c_sec_headers
    seccomp_headers
)

add_executable(aicpu_custom_schedule_utest_open
    ${SRC_PATH}/common/feature_ctrl_open_source.cpp
    ${SRC_PATH}/common/feature_ctrl_common.cpp
    testcase/open_aicpu_test.cc
    testcase/c_stub.c
    main_ut.cc
)

target_include_directories(aicpu_custom_schedule_utest_open PRIVATE
    ${LOCAL_C_INCLUDES}
)

target_link_libraries(aicpu_custom_schedule_utest_open PRIVATE
    $<BUILD_INTERFACE:intf_aicpu_llt_pub>
    $<BUILD_INTERFACE:slog_headers>
)