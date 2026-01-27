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
    ${AICPU_SCHED_PATH}/aicpu_schedule
)

set(proto_src_files
    ${SRC_PATH}/proto/dump_data.proto
    ${SRC_PATH}/proto/op_mapping_info.proto
    ${SRC_PATH}/proto/dynamic_sched.proto
)

protobuf_generate(aicpu_st_proto PROTO_SRCS PROTO_HDRS ${proto_src_files} TARGET)

set(statistic_src_file
    ${SRC_PATH}/statistic/aicpusd_period_statistic.cpp
    ${SRC_PATH}/statistic/aicpusd_proc_mem_statistic.cpp
    ${SRC_PATH}/statistic/aicpusd_model_statistic.cpp
)

set(statistic_test_src_file
    testcase/aicpusd_model_statistic_test.cc
    testcase/aicpusd_period_statistic_test.cc
    testcase/aicpusd_proc_mem_statistic_test.cc
)

set(COMMON_C_INCLUDES
    ${SRC_PATH}/core/operator_kernel/communication
    ${SRC_PATH}/core/operator_kernel/control_flow
    ${SRC_PATH}/core/operator_kernel/dequeue
    ${SRC_PATH}/core/operator_kernel/enqueue
    ${SRC_PATH}/core/operator_kernel/other
    ${SRC_PATH}/core/operator_kernel/postprocess
    ${SRC_PATH}/core/operator_kernel/preprocess
    ${SRC_PATH}/core/operator_kernel
    ${SRC_PATH}/core/hwts_kernel
    ${SRC_PATH}/core/platform_info
    ${SRC_PATH}/core/dfx
    ${SRC_PATH}/core
    ${SRC_PATH}/interface
    ${SRC_PATH}/mc2_maintenance
    ${SRC_PATH}/common
    ${SRC_PATH}/statistic
    ${SRC_PATH}/stub/proc_mgr
    ${SRC_PATH}/stub
    ${SRC_PATH}
    ${AICPU_SCHED_PATH}/aicpu_processer
    ${AICPU_SCHED_PATH}/aicpu_sharder
    ${AICPU_SCHED_PATH}/aicpu_prof
    ${AICPU_SCHED_PATH}/extern_include
    ${AICPU_SCHED_PATH}
    ${RUNTIME_DIR}/pkg_inc/aicpu_sched/common
    ${RUNTIME_DIR}/pkg_inc/tsd
    ${RUNTIME_DIR}/pkg_inc/aicpu_sched
    ${RUNTIME_DIR}/pkg_inc/queue_schedule
    ${RUNTIME_DIR}/pkg_inc
    ${RUNTIME_DIR}/pkg_inc/profiling
    ${RUNTIME_DIR}/pkg_inc/base
    ${RUNTIME_DIR}/pkg_inc/aicpu_sched/aicpu_schedule
    ${RUNTIME_DIR}/pkg_inc/runtime/runtime
    ${RUNTIME_DIR}/pkg_inc/runtime
    ${RUNTIME_DIR}/src/inc/tdt
    ${RUNTIME_DIR}/src/inc/
    ${RUNTIME_DIR}/include
    ${RUNTIME_DIR}/include/driver
    ${RUNTIME_DIR}/src/dfx/adump/inc/metadef
    ${RUNTIME_DIR}/src/dfx/adump/inc
    ${RUNTIME_DIR}/src/dfx/msprof/inc/toolchain
    ${RUNTIME_DIR}/src/aicpu_sched/aicpu_schedule/common 
    ${CMAKE_BINARY_DIR}/proto/aicpu_st_proto/proto
)

set(COMMON_C_LINK
    -Wno-reorder
    c_sec
    -lrt
    -ldl
    ascend_protobuf
    Eigen3::Eigen
    $<BUILD_INTERFACE:intf_aicpu_llt_pub>
    $<BUILD_INTERFACE:slog_headers>
    pthread
    c_sec_headers
)

set(COMMON_DEF
    AICPUFW_UT
    DT_COMPILE_GCC
    CFG_SOC_PLATFORM_CLOUD
    aicpusd_UT
    RUN_TEST
    google=ascend_private
)

set(COMMON_COMPILE_OPTIONS
    -DEIGEN_MPL2_ONLY
)

set(LOCAL_SRC_FILES
    ${SRC_PATH}/interface/aicpusd_interface.cpp
    ${SRC_PATH}/interface/aicpusd_sub_module_interface.cpp
    ${SRC_PATH}/common/aicpusd_args_parser.cpp
    ${SRC_PATH}/common/aicpusd_feature_ctrl_open_source.cpp
    ${SRC_PATH}/common/feature_ctrl_common.cpp
    ${SRC_PATH}/common/aicpusd_sqe_adapter.cpp
    ${SRC_PATH}/core/aicpusd_drv_manager.cpp
    ${SRC_PATH}/core/aicpusd_event_manager.cpp
    ${SRC_PATH}/core/aicpusd_event_process.cpp
    ${SRC_PATH}/core/aicpusd_interface_process.cpp
    ${SRC_PATH}/core/aicpusd_model.cpp
    ${SRC_PATH}/core/aicpusd_model_execute.cpp
    ${SRC_PATH}/core/aicpusd_queue_event_process.cpp
    ${SRC_PATH}/core/aicpusd_resource_manager.cpp
    ${SRC_PATH}/core/aicpusd_meminfo_process.cpp
    ${SRC_PATH}/core/aicpusd_resource_limit.cpp
    ${SRC_PATH}/core/aicpusd_task_queue.cpp
    ${SRC_PATH}/core/aicpusd_threads_process.cpp
    ${SRC_PATH}/core/dfx/dump_task.cpp
    ${SRC_PATH}/core/dfx/dump_task_manager.cpp
    ${SRC_PATH}/core/dfx/dump_task_kfc.cpp
    ${SRC_PATH}/core/aicpusd_msg_send.cpp
    ${SRC_PATH}/stub/aicpusd_profiler.cpp
    ${SRC_PATH}/stub/stub_transfer_dump.cpp
    ${SRC_PATH}/core/dfx/aicpusd_monitor.cpp
    ${SRC_PATH}/core/dfx/aicpusd_lastword.cpp
    ${SRC_PATH}/core/aicpusd_worker.cpp
    ${SRC_PATH}/core/aicpusd_so_manager.cpp
    ${SRC_PATH}/execute/main.cpp
    ${SRC_PATH}/core/aicpusd_mpi_mgr.cpp
    ${SRC_PATH}/core/aicpusd_cust_so_manager.cpp
    ${SRC_PATH}/core/aicpusd_model_err_process.cpp
    ${SRC_PATH}/common/aicpusd_context.cpp
    ${SRC_PATH}/common/aicpusd_hccl_api.cpp
    ${SRC_PATH}/common/aicpusd_util.cpp
    ${SRC_PATH}/core/dfx/aicpusd_cust_dump_process.cpp
    ${SRC_PATH}/core/platform_info/aicpusd_send_platform_Info_to_custom.cpp
    ${SRC_PATH}/stub/proc_mgr/proc_mgr_sys_operator_agent.cpp
    ${SRC_PATH}/mc2_maintenance/aicpusd_mc2_maintenance_thread.cpp
    ${SRC_PATH}/core/aicpusd_message_queue.cpp
    ${AICPU_SCHED_PATH}/aicpu_sharder/aicpu_pulse.cc
    ${AICPU_SCHED_PATH}/aicpu_sharder/aicpu_sharder.cc
    ${AICPU_SCHED_PATH}/aicpu_sharder/aicpu_context.cc
    ${AICPU_SCHED_PATH}/aicpu_sharder/aicpu_async_event.cc
    ${AICPU_SCHED_PATH}/aicpu_sharder/aicpu_timer.cpp
    
    ${RUNTIME_DIR}/tests/ut/aicpu_sched/aicpu_schedule/stub/aicpusd_context.cpp
    ${RUNTIME_DIR}/tests/ut/aicpu_sched/aicpu_schedule/stub/stub_driver.cpp
    ${RUNTIME_DIR}/tests/ut/aicpu_sched/aicpu_schedule/stub/slog_stub.cpp
    ${RUNTIME_DIR}/tests/ut/aicpu_sched/aicpu_schedule/stub/stub_profiling.cpp
    
    testcase/aicpu_context.cc
    testcase/aicpusd_args_parser_test.cc
    testcase/aicpusd_interface_process_test.cc
    testcase/aicpusd_cust_so_manager_test.cc
    testcase/aicpusd_model_err_process_test.cc
    testcase/aicpusd_model_execute_test.cc
    testcase/aicpu_schedule_test.cc
    testcase/aicpusd_monitor_test.cc
    testcase/aicpusd_lastword_test.cc
    testcase/driver_interface.cc
    testcase/aicpusd_work_test.cc
    testcase/aicpusd_resource_manager_test.cc
    testcase/aicpusd_meminfo_process_test.cc
    testcase/aicpusd_queue_event_process_test.cc
    testcase/aicpusd_sub_module_interface_test.cc
    testcase/aicpusd_dump_task_test.cc
    testcase/aicpusd_task_queue_test.cc
    testcase/aicpusd_threads_process_test.cc
    testcase/c_stub.c
    main_st.cc
    ${PROTO_SRCS}
    ${statistic_src_file}
    ${statistic_test_src_file}
)

set(operator_kernel_src_file
    ${SRC_PATH}/core/operator_kernel/operator_kernel_common.cpp
    ${SRC_PATH}/core/operator_kernel/operator_kernel_register.cpp
    ${SRC_PATH}/core/operator_kernel/operator_kernel.cpp
    # communication
    ${SRC_PATH}/core/operator_kernel/communication/operator_kernel_batch_process.cpp
    ${SRC_PATH}/core/operator_kernel/communication/operator_kernel_get_update_req.cpp
    ${SRC_PATH}/core/operator_kernel/communication/operator_kernel_lookup_req.cpp
    ${SRC_PATH}/core/operator_kernel/communication/operator_kernel_lookup_resp.cpp
    ${SRC_PATH}/core/operator_kernel/communication/operator_kernel_remote_comm.cpp
    ${SRC_PATH}/core/operator_kernel/communication/operator_kernel_set_update_resp.cpp
    # control_flow
    ${SRC_PATH}/core/operator_kernel/control_flow/operator_kernel_active_entry_stream.cpp
    ${SRC_PATH}/core/operator_kernel/control_flow/operator_kernel_active_model.cpp
    ${SRC_PATH}/core/operator_kernel/control_flow/operator_kernel_end_graph.cpp
    ${SRC_PATH}/core/operator_kernel/control_flow/operator_kernel_lock_table.cpp
    ${SRC_PATH}/core/operator_kernel/control_flow/operator_kernel_mark_step.cpp
    ${SRC_PATH}/core/operator_kernel/control_flow/operator_kernel_model_repeat.cpp
    ${SRC_PATH}/core/operator_kernel/control_flow/operator_kernel_model_report_status.cpp
    ${SRC_PATH}/core/operator_kernel/control_flow/operator_kernel_model_wait_end_graph.cpp
    ${SRC_PATH}/core/operator_kernel/control_flow/operator_kernel_record_notify.cpp
    ${SRC_PATH}/core/operator_kernel/control_flow/operator_kernel_stream_repeat.cpp
    ${SRC_PATH}/core/operator_kernel/control_flow/operator_kernel_unlock_table.cpp
    ${SRC_PATH}/core/operator_kernel/control_flow/operator_kernel_wait_notify.cpp
    # dequeue
    ${SRC_PATH}/core/operator_kernel/dequeue/operator_kernel_dequeue_base.cpp
    ${SRC_PATH}/core/operator_kernel/dequeue/operator_kernel_gather_dequeue.cpp
    ${SRC_PATH}/core/operator_kernel/dequeue/operator_kernel_model_batch_dequeue_buff.cpp
    ${SRC_PATH}/core/operator_kernel/dequeue/operator_kernel_model_batch_dequeue.cpp
    ${SRC_PATH}/core/operator_kernel/dequeue/operator_kernel_model_dequeue.cpp
    ${SRC_PATH}/core/operator_kernel/dequeue/operator_kernel_model_prepare.cpp
    # enqueue
    ${SRC_PATH}/core/operator_kernel/enqueue/operator_kernel_enqueue_base.cpp
    ${SRC_PATH}/core/operator_kernel/enqueue/operator_kernel_model_batch_enqueue.cpp
    ${SRC_PATH}/core/operator_kernel/enqueue/operator_kernel_model_enqueue_buff.cpp
    ${SRC_PATH}/core/operator_kernel/enqueue/operator_kernel_model_enqueue.cpp
    ${SRC_PATH}/core/operator_kernel/enqueue/operator_kernel_model_postpare.cpp
    # other
    ${SRC_PATH}/core/operator_kernel/other/operator_kernel_check_input_tensor_desc.cpp
    ${SRC_PATH}/core/operator_kernel/other/operator_kernel_zero_cpy.cpp
    # postprocess
    ${SRC_PATH}/core/operator_kernel/postprocess/operator_kernel_dyn_output_post_process.cpp
    ${SRC_PATH}/core/operator_kernel/postprocess/operator_kernel_post_process_dynamic_output.cpp
    # preprocess
    ${SRC_PATH}/core/operator_kernel/preprocess/operator_kernel_model_prepare_non_zero_copy_input.cpp
    ${SRC_PATH}/core/operator_kernel/preprocess/operator_kernel_model_prepare_output.cpp
    ${SRC_PATH}/core/operator_kernel/preprocess/operator_kernel_prepare_dynamic_input_output.cpp
    ${SRC_PATH}/core/operator_kernel/preprocess/operator_kernel_prepare_mem.cpp
)

set(hwts_kernel_src_file
    ${SRC_PATH}/core/hwts_kernel/hwts_kernel_common.cpp
    ${SRC_PATH}/core/hwts_kernel/hwts_kernel_register.cpp
    ${SRC_PATH}/core/hwts_kernel/hwts_kernel.cpp
    ${SRC_PATH}/core/hwts_kernel/hwts_kernel_model_process.cpp
    ${SRC_PATH}/core/hwts_kernel/hwts_kernel_dfx.cpp
    ${SRC_PATH}/core/hwts_kernel/hwts_kernel_cust_so.cpp
    ${SRC_PATH}/core/hwts_kernel/hwts_kernel_queue.cpp
    ${SRC_PATH}/core/hwts_kernel/hwts_kernel_model_control.cpp
)

add_executable(aicpu_aicpuschedule_stest
    ${LOCAL_SRC_FILES}
    ${operator_kernel_src_file}
    ${hwts_kernel_src_file}
)
add_dependencies(aicpu_aicpuschedule_stest aicpu_st_proto)

target_include_directories(aicpu_aicpuschedule_stest PRIVATE
    ${COMMON_C_INCLUDES}
    ${SRC_PATH}/stub
    ${RUNTIME_DIR}/tests/ut/aicpu_sched/aicpu_schedule
)

target_compile_definitions(aicpu_aicpuschedule_stest PRIVATE
    ${COMMON_DEF}
)

target_compile_options(aicpu_aicpuschedule_stest PRIVATE
    ${COMMON_COMPILE_OPTIONS}
)

target_link_libraries(aicpu_aicpuschedule_stest PRIVATE
   ${COMMON_C_LINK}
    json
)

add_executable(aicpu_aicpuschedule_stest_host_cpu
    ${SRC_PATH}/stub/aicpu_context.cpp
    ${SRC_PATH}/stub/aicpu_sharder.cpp
    ${SRC_PATH}/stub/aicpusd_interface.cpp
    ${SRC_PATH}/stub/host_cpu_driver.cpp
    ${SRC_PATH}/stub/host_cpu_scheduler.cpp
    ${SRC_PATH}/stub/aicpusd_cust_dump_process_stub.cpp
    ${SRC_PATH}/stub/aicpusd_mc2_maintenance_thread_stub.cpp
    ${SRC_PATH}/core/aicpusd_message_queue.cpp
    ${SRC_PATH}/common/aicpusd_feature_ctrl_open_source.cpp
    ${SRC_PATH}/common/feature_ctrl_common.cpp
    ${RUNTIME_DIR}/tests/ut/aicpu_sched/aicpu_schedule/stub/slog_stub.cpp
    testcase/host_cpu_stub.c
    testcase/aicpu_context_stub.cc
    testcase/aicpu_sharder.cc
    testcase/aicpusd_interface.cc
    testcase/host_cpu_driver.cc
    testcase/host_cpu_scheduler.cc
    main_st.cc
)
add_dependencies(aicpu_aicpuschedule_stest_host_cpu aicpu_proto)

target_include_directories(aicpu_aicpuschedule_stest_host_cpu PRIVATE
    ${COMMON_C_INCLUDES}
    ${SRC_PATH}/stub
)

target_compile_definitions(aicpu_aicpuschedule_stest_host_cpu PRIVATE
    ${COMMON_DEF}
)

target_link_libraries(aicpu_aicpuschedule_stest_host_cpu PRIVATE
    ${COMMON_C_LINK}
)

add_executable(aicpu_aicpuschedule_stest_hostaicpu
    ${SRC_PATH}/stub/hostaicpu.cpp
    ${SRC_PATH}/stub/hostaicpu.cpp
    ${SRC_PATH}/core/aicpusd_resource_limit.cpp
    ${SRC_PATH}/core/aicpusd_message_queue.cpp
    ${SRC_PATH}/common/aicpusd_feature_ctrl_open_source.cpp
    ${SRC_PATH}/common/feature_ctrl_common.cpp
    ${RUNTIME_DIR}/tests/ut/aicpu_sched/aicpu_schedule/stub/slog_stub.cpp
    testcase/host_cpu_stub.c
    testcase/hostaicpu_driver.cc
    main_st.cc
)

target_include_directories(aicpu_aicpuschedule_stest_hostaicpu PRIVATE
    ${COMMON_C_INCLUDES}
    ${SRC_PATH}/stub
)

target_compile_definitions(aicpu_aicpuschedule_stest_hostaicpu PRIVATE
    ${COMMON_DEF}
)

target_link_libraries(aicpu_aicpuschedule_stest_hostaicpu PRIVATE
    ${COMMON_C_LINK}
)

add_executable(aicpu_thread_datadump_stest
    ${SRC_PATH}/datadump/datadump_interface.cpp
    ${SRC_PATH}/common/aicpusd_sqe_adapter.cpp
    ${SRC_PATH}/datadump/datadump_interface_process.cpp
    ${SRC_PATH}/datadump/datadump_event_manager.cpp
    ${SRC_PATH}/datadump/datadump_event_process.cpp
    ${SRC_PATH}/datadump/datadump_worker.cpp
    ${SRC_PATH}/core/dfx/dump_task.cpp
    ${SRC_PATH}/core/dfx/dump_task_manager.cpp
    ${SRC_PATH}/core/dfx/dump_task_kfc.cpp
    ${SRC_PATH}/datadump/datadump_threads_process.cpp
    ${SRC_PATH}/core/aicpusd_drv_manager.cpp
    ${SRC_PATH}/core/aicpusd_msg_send.cpp
    ${SRC_PATH}/common/aicpusd_context.cpp
    ${SRC_PATH}/common/aicpusd_util.cpp
    ${SRC_PATH}/common/aicpusd_feature_ctrl_open_source.cpp
    ${SRC_PATH}/common/feature_ctrl_common.cpp
    ${SRC_PATH}/stub/stub_transfer_dump.cpp
    ${SRC_PATH}/stub/stub_thread_datadump.cpp
    ${SRC_PATH}/core/aicpusd_message_queue.cpp
    ${RUNTIME_DIR}/tests/ut/aicpu_sched/aicpu_schedule/stub/slog_stub.cpp
    ${RUNTIME_DIR}/tests/ut/aicpu_sched/aicpu_schedule/stub/stub_driver.cpp
    testcase/c_stub.c
    testcase/aicpu_thread_datadump_test.cc
    main_st.cc
    ${PROTO_SRCS}
    ${statistic_src_file}
    
)
add_dependencies(aicpu_thread_datadump_stest aicpu_st_proto)

target_include_directories(aicpu_thread_datadump_stest PRIVATE
    ${COMMON_C_INCLUDES}
    ${SRC_PATH}/stub
)

target_compile_definitions(aicpu_thread_datadump_stest PRIVATE
    ${COMMON_DEF}
)

target_compile_options(aicpu_thread_datadump_stest PRIVATE
    ${COMMON_COMPILE_OPTIONS}
)

target_link_libraries(aicpu_thread_datadump_stest PRIVATE
    ${COMMON_C_LINK}
)