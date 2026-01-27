# -----------------------------------------------------------------------------------------------------------
# Copyright (c) 2025 Huawei Technologies Co., Ltd.
# This program is free software, you can redistribute it and/or modify it under the terms and conditions of
# CANN Open Software License Agreement Version 2.0 (the "License").
# Please refer to the License for details. You may not use this file except in compliance with the License.
# THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
# INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
# See LICENSE in the root of the software repository for the full text of the License.
# -----------------------------------------------------------------------------------------------------------

set(BASE_DIR ${CMAKE_CURRENT_SOURCE_DIR})
set(RUNTIME_DIR ${CMAKE_CURRENT_SOURCE_DIR}/../../..)

include(${RUNTIME_DIR}/cmake/third_party/eigen.cmake)

set(proto_src_files
    ${CMAKE_CURRENT_SOURCE_DIR}/proto/dump_data.proto
    ${CMAKE_CURRENT_SOURCE_DIR}/proto/op_mapping_info.proto
    ${CMAKE_CURRENT_SOURCE_DIR}/proto/dynamic_sched.proto
)

protobuf_generate(aicpu PROTO_SRCS PROTO_HDRS ${proto_src_files})

set(statistic_src_file
    ${CMAKE_CURRENT_SOURCE_DIR}/statistic/aicpusd_period_statistic.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/statistic/aicpusd_proc_mem_statistic.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/statistic/aicpusd_model_statistic.cpp
)

# TRANSFER_DUMP_INFO
set(TRANSFER_DUMP_INFO false)  
if (PRODUCT_SIDE STREQUAL "device")
    set(TRANSFER_DUMP_INFO true)
endif()

# EVENT_SCH_SENDER_CHECK
set(EVENT_SCH_SENDER_CHECK false)
if (${PRODUCT_SIDE} STREQUAL "device")
    set(EVENT_SCH_SENDER_CHECK true)
endif()


set(PRODUCT_TYPE "DEFAULT")
set(lhisi_product false)
set(compatible_product true)

# depend means link, if not depend, we should stub
set(tdt_server_depend false)
# useless means neither depend nor stub
set(tdt_server_useless false)
set(tsd_event_client_depend true)
set(dp_depend true)
set(shard_depend true)
set(aicpu_prof_depend true)
set(proc_mgr_depend false)

# default
set(thread_process_src_files
    ${CMAKE_CURRENT_SOURCE_DIR}/core/aicpusd_threads_process.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/core/aicpusd_worker.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/core/aicpusd_task_queue.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/core/aicpusd_so_manager.cpp
)

set(stub_monitor false)
set(stub_meminfo true)
set(stub_profiler true)
set(need_proto_src true)

set(operator_kernel_src_file
    ${CMAKE_CURRENT_SOURCE_DIR}/core/operator_kernel/operator_kernel_common.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/core/operator_kernel/operator_kernel_register.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/core/operator_kernel/operator_kernel.cpp
    # communication
    ${CMAKE_CURRENT_SOURCE_DIR}/core/operator_kernel/communication/operator_kernel_batch_process.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/core/operator_kernel/communication/operator_kernel_get_update_req.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/core/operator_kernel/communication/operator_kernel_lookup_req.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/core/operator_kernel/communication/operator_kernel_lookup_resp.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/core/operator_kernel/communication/operator_kernel_remote_comm.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/core/operator_kernel/communication/operator_kernel_set_update_resp.cpp
    # control_flow
    ${CMAKE_CURRENT_SOURCE_DIR}/core/operator_kernel/control_flow/operator_kernel_active_entry_stream.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/core/operator_kernel/control_flow/operator_kernel_active_model.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/core/operator_kernel/control_flow/operator_kernel_end_graph.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/core/operator_kernel/control_flow/operator_kernel_lock_table.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/core/operator_kernel/control_flow/operator_kernel_mark_step.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/core/operator_kernel/control_flow/operator_kernel_model_repeat.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/core/operator_kernel/control_flow/operator_kernel_model_report_status.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/core/operator_kernel/control_flow/operator_kernel_model_wait_end_graph.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/core/operator_kernel/control_flow/operator_kernel_record_notify.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/core/operator_kernel/control_flow/operator_kernel_stream_repeat.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/core/operator_kernel/control_flow/operator_kernel_unlock_table.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/core/operator_kernel/control_flow/operator_kernel_wait_notify.cpp
    # dequeue
    ${CMAKE_CURRENT_SOURCE_DIR}/core/operator_kernel/dequeue/operator_kernel_dequeue_base.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/core/operator_kernel/dequeue/operator_kernel_gather_dequeue.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/core/operator_kernel/dequeue/operator_kernel_model_batch_dequeue_buff.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/core/operator_kernel/dequeue/operator_kernel_model_batch_dequeue.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/core/operator_kernel/dequeue/operator_kernel_model_dequeue.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/core/operator_kernel/dequeue/operator_kernel_model_prepare.cpp
    # enqueue
    ${CMAKE_CURRENT_SOURCE_DIR}/core/operator_kernel/enqueue/operator_kernel_enqueue_base.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/core/operator_kernel/enqueue/operator_kernel_model_batch_enqueue.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/core/operator_kernel/enqueue/operator_kernel_model_enqueue_buff.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/core/operator_kernel/enqueue/operator_kernel_model_enqueue.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/core/operator_kernel/enqueue/operator_kernel_model_postpare.cpp
    # other
    ${CMAKE_CURRENT_SOURCE_DIR}/core/operator_kernel/other/operator_kernel_check_input_tensor_desc.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/core/operator_kernel/other/operator_kernel_zero_cpy.cpp
    # postprocess
    ${CMAKE_CURRENT_SOURCE_DIR}/core/operator_kernel/postprocess/operator_kernel_dyn_output_post_process.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/core/operator_kernel/postprocess/operator_kernel_post_process_dynamic_output.cpp
    # preprocess
    ${CMAKE_CURRENT_SOURCE_DIR}/core/operator_kernel/preprocess/operator_kernel_model_prepare_non_zero_copy_input.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/core/operator_kernel/preprocess/operator_kernel_model_prepare_output.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/core/operator_kernel/preprocess/operator_kernel_prepare_dynamic_input_output.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/core/operator_kernel/preprocess/operator_kernel_prepare_mem.cpp
)

set(hwts_kernel_src_file
    ${CMAKE_CURRENT_SOURCE_DIR}/core/hwts_kernel/hwts_kernel_common.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/core/hwts_kernel/hwts_kernel_register.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/core/hwts_kernel/hwts_kernel.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/core/hwts_kernel/hwts_kernel_model_process.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/core/hwts_kernel/hwts_kernel_dfx.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/core/hwts_kernel/hwts_kernel_cust_so.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/core/hwts_kernel/hwts_kernel_queue.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/core/hwts_kernel/hwts_kernel_model_control.cpp
)


if(${PRODUCT_SIDE} STREQUAL host)
set(commom_src_file
    ${operator_kernel_src_file}
    ${hwts_kernel_src_file}
    ${CMAKE_CURRENT_SOURCE_DIR}/interface/aicpusd_interface.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/common/aicpusd_args_parser.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/core/aicpusd_interface_process.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/core/aicpusd_event_manager.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/core/aicpusd_event_process.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/core/aicpusd_resource_manager.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/core/aicpusd_drv_manager.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/core/aicpusd_model.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/core/aicpusd_model_execute.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/core/aicpusd_msg_send.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/core/aicpusd_cust_so_manager.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/core/aicpusd_worker.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/core/aicpusd_threads_process.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/core/aicpusd_resource_limit.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/core/aicpusd_model_err_process.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/core/aicpusd_meminfo_process.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/core/dfx/aicpusd_lastword.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/core/aicpusd_so_manager.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/core/aicpusd_message_queue.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/stub/aicpusd_monitor.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/stub/host_cpu_scheduler.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/stub/aicpusd_profiler.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/stub/proc_mgr/proc_mgr_sys_operator_agent.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/stub/aicpu_context.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/stub/aicpu_sharder.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/stub/host_cpu_driver.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/common/aicpusd_hccl_api.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/stub/stub_transfer_dump.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/stub/aicpusd_cust_dump_process_stub.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/stub/aicpusd_mc2_maintenance_thread_stub.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/common/aicpusd_util.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/common/aicpusd_feature_ctrl_open_source.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/common/feature_ctrl_common.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/common/aicpusd_sqe_adapter.cpp
    ${PROTO_SRCS}
    ${statistic_src_file}
)
else()
# PRODUCT_SIDE: device
set(commom_src_file
    ${operator_kernel_src_file}
    ${hwts_kernel_src_file}
    ${CMAKE_CURRENT_SOURCE_DIR}/interface/aicpusd_interface.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/common/aicpusd_args_parser.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/core/aicpusd_interface_process.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/core/aicpusd_event_manager.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/core/aicpusd_event_process.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/core/aicpusd_queue_event_process.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/core/dfx/dump_task.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/core/dfx/dump_task_manager.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/core/dfx/dump_task_kfc.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/core/aicpusd_resource_limit.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/core/aicpusd_resource_manager.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/core/aicpusd_drv_manager.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/core/aicpusd_model.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/core/aicpusd_model_execute.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/core/aicpusd_msg_send.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/core/aicpusd_cust_so_manager.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/core/aicpusd_mpi_mgr.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/core/aicpusd_model_err_process.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/core/dfx/aicpusd_lastword.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/core/aicpusd_message_queue.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/common/aicpusd_context.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/common/aicpusd_hccl_api.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/common/aicpusd_util.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/common/aicpusd_sqe_adapter.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/interface/aicpusd_sub_module_interface.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/stub/stub_transfer_dump.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/core/dfx/aicpusd_cust_dump_process.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/core/platform_info/aicpusd_send_platform_Info_to_custom.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/mc2_maintenance/aicpusd_mc2_maintenance_thread.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/common/aicpusd_feature_ctrl_open_source.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/common/feature_ctrl_common.cpp

    ${thread_process_src_files}
    $<$<AND:$<STREQUAL:${tdt_server_depend},false>,$<STREQUAL:${tdt_server_useless},false>>:${CMAKE_CURRENT_SOURCE_DIR}/stub/aicpusd_stub_tdtserver.cpp>
    $<$<STREQUAL:${tsd_event_client_depend},false>:${CMAKE_CURRENT_SOURCE_DIR}/stub/stub_tsd_event_client.cpp>
    $<$<STREQUAL:${dp_depend},false>:${CMAKE_CURRENT_SOURCE_DIR}/stub/stub_dp.cpp>
    $<$<STREQUAL:${shard_depend},false>:${CMAKE_CURRENT_SOURCE_DIR}/stub/stub_shard.cpp>
    $<$<STREQUAL:${proc_mgr_depend},false>:${CMAKE_CURRENT_SOURCE_DIR}/stub/proc_mgr/proc_mgr_sys_operator_agent.cpp>
    
    $<$<STREQUAL:${stub_monitor},true>:${CMAKE_CURRENT_SOURCE_DIR}/stub/aicpusd_monitor.cpp>
    $<$<STREQUAL:${stub_monitor},false>:${CMAKE_CURRENT_SOURCE_DIR}/core/dfx/aicpusd_monitor.cpp>
    #stub_meminfo
    $<$<STREQUAL:${stub_meminfo},true>:${CMAKE_CURRENT_SOURCE_DIR}/stub/aicpusd_meminfo_process.cpp>
    $<$<STREQUAL:${stub_meminfo},false>:${CMAKE_CURRENT_SOURCE_DIR}/core/aicpusd_meminfo_process.cpp>
    #stub_profiler
    $<$<STREQUAL:${stub_profiler},true>:${CMAKE_CURRENT_SOURCE_DIR}/stub/aicpusd_profiler.cpp>
    $<$<STREQUAL:${stub_profiler},false>:${CMAKE_CURRENT_SOURCE_DIR}/core/dfx/aicpusd_profiler.cpp>
    #need_proto_src
    $<$<STREQUAL:${need_proto_src},true>:${PROTO_SRCS}>
    ${statistic_src_file}
)
endif()

if(${PRODUCT_SIDE} STREQUAL host)
SET(commom_inc_path
    ${CMAKE_CURRENT_SOURCE_DIR}
    ${CMAKE_CURRENT_SOURCE_DIR}/core/operator_kernel
    ${CMAKE_CURRENT_SOURCE_DIR}/core/hwts_kernel
    ${CMAKE_CURRENT_SOURCE_DIR}/interface
    ${CMAKE_CURRENT_SOURCE_DIR}/mc2_maintenance
    ${CMAKE_CURRENT_SOURCE_DIR}/../aicpu_processer
    ${CMAKE_CURRENT_SOURCE_DIR}/../aicpu_sharder
    ${CMAKE_CURRENT_SOURCE_DIR}/../aicpu_prof
    ${CMAKE_CURRENT_SOURCE_DIR}/../extern_include
    ${CMAKE_CURRENT_SOURCE_DIR}/..
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

    ${CMAKE_CURRENT_SOURCE_DIR}/core
    ${CMAKE_CURRENT_SOURCE_DIR}/core/platform_info
    ${CMAKE_CURRENT_SOURCE_DIR}/core/dfx
    ${CMAKE_CURRENT_SOURCE_DIR}/common
    ${CMAKE_CURRENT_SOURCE_DIR}/statistic
    ${CMAKE_CURRENT_SOURCE_DIR}/stub/proc_mgr
    ${CMAKE_CURRENT_SOURCE_DIR}/stub
    ${CMAKE_BINARY_DIR}/proto/aicpu/proto
)
else()
# PRODUCT_SIDE: device
SET(commom_inc_path
    ${CMAKE_CURRENT_SOURCE_DIR}
    ${CMAKE_CURRENT_SOURCE_DIR}/core/operator_kernel
    ${CMAKE_CURRENT_SOURCE_DIR}/core/hwts_kernel
    ${CMAKE_CURRENT_SOURCE_DIR}/interface
    ${CMAKE_CURRENT_SOURCE_DIR}/mc2_maintenance
    ${CMAKE_CURRENT_SOURCE_DIR}/../aicpu_processer
    ${CMAKE_CURRENT_SOURCE_DIR}/../aicpu_sharder
    ${CMAKE_CURRENT_SOURCE_DIR}/../aicpu_prof
    ${CMAKE_CURRENT_SOURCE_DIR}/../extern_include
    ${CMAKE_CURRENT_SOURCE_DIR}/..
    ${RUNTIME_DIR}/pkg_inc/runtime/runtime
    ${RUNTIME_DIR}/pkg_inc/runtime
    ${RUNTIME_DIR}/pkg_inc/aicpu_sched/common
    ${RUNTIME_DIR}/pkg_inc/tsd
    ${RUNTIME_DIR}/pkg_inc/aicpu_sched
    ${RUNTIME_DIR}/pkg_inc
    ${RUNTIME_DIR}/pkg_inc/profiling
    ${RUNTIME_DIR}/pkg_inc/base
    ${RUNTIME_DIR}/pkg_inc/aicpu_sched/aicpu_schedule
    ${RUNTIME_DIR}/pkg_inc/queue_schedule
    ${RUNTIME_DIR}/src/inc/tdt
    ${RUNTIME_DIR}/src/inc/
    ${RUNTIME_DIR}/include
    ${RUNTIME_DIR}/include/driver
    ${RUNTIME_DIR}/src/dfx/adump/inc/metadef
    ${RUNTIME_DIR}/src/dfx/adump/inc
    ${RUNTIME_DIR}/src/dfx/msprof/inc/toolchain
    ${RUNTIME_DIR}/src/aicpu_sched/aicpu_schedule/common 

    ${CMAKE_CURRENT_SOURCE_DIR}/core
    ${CMAKE_CURRENT_SOURCE_DIR}/core/platform_info
    ${CMAKE_CURRENT_SOURCE_DIR}/core/dfx
    ${CMAKE_CURRENT_SOURCE_DIR}/common
    ${CMAKE_CURRENT_SOURCE_DIR}/statistic
    ${CMAKE_CURRENT_SOURCE_DIR}/stub/proc_mgr
    ${CMAKE_CURRENT_SOURCE_DIR}/stub
    ${CMAKE_BINARY_DIR}/proto/aicpu/proto

    $<$<STREQUAL:${proc_mgr_depend},false>:${CMAKE_CURRENT_SOURCE_DIR}/stub/proc_mgr>
    ${CMAKE_CURRENT_SOURCE_DIR}/stub
    $<$<STREQUAL:${need_proto_src},false>:${ASCEND_PROTOBUF_SHARED_INCLUDE_DIR}>
    ${CMAKE_BINARY_DIR}/proto/aicpu/proto

)
endif()

# host_aicpu_scheduler_so
if(${PRODUCT_SIDE} STREQUAL host)
    add_library(host_aicpu_scheduler_so SHARED
        ${commom_src_file}
    )
    target_include_directories(host_aicpu_scheduler_so PRIVATE
        ${commom_inc_path}
    )
    target_link_libraries(host_aicpu_scheduler_so PRIVATE
        $<BUILD_INTERFACE:intf_pub_cxx17>
        PUBLIC c_sec
        ascend_hal_stub
        protobuf_static 
        json
        mmpa
        Eigen3::Eigen
        dl
        $<BUILD_INTERFACE:c_sec_headers>
    )
    target_link_options(host_aicpu_scheduler_so PRIVATE
        -Wl,-Bsymbolic
    )
    target_compile_options(host_aicpu_scheduler_so PRIVATE
        -fno-common
        -fno-strict-aliasing
        -O2
        -Werror -Wall
        -Wno-error=array-bounds       # For controlling the compiler's warnings and errors regarding array out-of-bounds access.
        -Wno-unused-variable          # Used to suppress warnings about unused variables.
        -Wno-unused-but-set-variable  # Used to suppress warnings about assigned but unused variables.
        -Wno-unused-private-field     # To disable warnings about unused private fields.
        -Wno-c++20-compat             # To suppress warnings related to C++20 compatibility.
        $<$<STREQUAL:${CMAKE_CXX_COMPILER_VERSION},13.3.0>:-Wno-deprecated-declarations> #Do not warn about the use of deprecated declarations
        $<$<STREQUAL:${RESERVED_SYMBOL},true>:-g>
    )
    target_compile_definitions(host_aicpu_scheduler_so PRIVATE
        google=ascend_private
        $<$<STREQUAL:${TRANSFER_DUMP_INFO},true>:TRANSFER_DUMP_INFO>
    )
    set_target_properties(host_aicpu_scheduler_so
        PROPERTIES
        OUTPUT_NAME host_aicpu_scheduler
    )

else()
    # PRODUCT_SIDE: device
    add_library(dp_stub SHARED ${CMAKE_CURRENT_SOURCE_DIR}/stub/stub_dp.cpp)
    target_include_directories(dp_stub PRIVATE
        ${CMAKE_CURRENT_SOURCE_DIR}/stub
        ${RUNTIME}/include
    )
    set_target_properties(dp_stub
        PROPERTIES
        OUTPUT_NAME dp
    )

    add_library(aicpu_scheduler_so SHARED
    ${commom_src_file}
    )

    target_link_libraries(aicpu_scheduler_so PRIVATE
        $<BUILD_INTERFACE:intf_pub_cxx17>
        PUBLIC c_sec
        $<$<STREQUAL:${tdt_server_depend},true>:tdtserver>
        $<$<STREQUAL:${tsd_event_client_depend},true>:tsd_eventclient_stub>
        $<$<STREQUAL:${dp_depend},true>:dp_stub>
        $<$<STREQUAL:${shard_depend},true>:aicpu_sharder>
        $<$<STREQUAL:${aicpu_prof_depend},true>:aicpu_prof>
        $<$<STREQUAL:${proc_mgr_depend},true>:procMgrSysOperatorAgent>
        $<$<STREQUAL:${stub_profiler},false>:hiperf>
        # pthread
        aicpu_processer
        ascend_hal_stub
        ascend_protobuf_static
        adump_stub
        stackcore_stub
        Eigen3::Eigen
        json
        $<BUILD_INTERFACE:c_sec_headers>
    )

    target_include_directories(aicpu_scheduler_so PRIVATE
        ${commom_inc_path}
    )

    target_compile_definitions(aicpu_scheduler_so PRIVATE
        $<$<STREQUAL:${compatible_product},true>:_FORTIFY_SOURCE=2>
        google=ascend_private

        $<$<STREQUAL:${compatible_product},true>:MODELID_EXT>
        $<$<STREQUAL:${EVENT_SCH_SENDER_CHECK},true>:EVENT_SCH_SENDER_CHECK>

        $<$<STREQUAL:${TRANSFER_DUMP_INFO},true>:TRANSFER_DUMP_INFO>
    )

    target_compile_options(aicpu_scheduler_so PRIVATE
        -O2
        -Werror -Wall
        -Wno-error=array-bounds       # For controlling the compiler's warnings and errors regarding array out-of-bounds access.
        -Wno-unused-variable          # Used to suppress warnings about unused variables.
        -Wno-unused-but-set-variable  # Used to suppress warnings about assigned but unused variables.
        -Wno-unused-private-field     # To disable warnings about unused private fields.
        -Wno-c++20-compat             # To suppress warnings related to C++20 compatibility.
        -Wno-unknown-attributes       # Some compiler not support optimize o0 attribute.
        -fno-common
        -fno-strict-aliasing
        -fvisibility=hidden
        -fvisibility-inlines-hidden
        -DEIGEN_MPL2_ONLY
        -fdata-sections
        -ffunction-sections
        $<$<STREQUAL:${RESERVED_SYMBOL},true>:-g>
    )

    target_link_options(aicpu_scheduler_so PRIVATE
        -Wl,--gc-sections
        -Wl,-Bsymbolic
    )

    # aicpu_scheduler
    add_executable(aicpu_scheduler
        ${CMAKE_CURRENT_SOURCE_DIR}/execute/main.cpp
        ${CMAKE_CURRENT_SOURCE_DIR}/common/aicpusd_args_parser.cpp
    )

    target_compile_definitions(aicpu_scheduler PRIVATE
        $<$<STREQUAL:${compatible_product},true>:_FORTIFY_SOURCE=2>
        $<$<STREQUAL:${compatible_product},true>:google=ascend_private>
    )

    target_compile_options(aicpu_scheduler PRIVATE
        -O2
        -Werror -Wall
        -Wno-error=array-bounds       # For controlling the compiler's warnings and errors regarding array out-of-bounds access.
        -Wno-unused-variable          # Used to suppress warnings about unused variables.
        -Wno-unused-but-set-variable  # Used to suppress warnings about assigned but unused variables.
        -Wno-unused-private-field     # To disable warnings about unused private fields.
        -Wno-c++20-compat             # To suppress warnings related to C++20 compatibility.
        -fno-common
        -fno-strict-aliasing
        -DEIGEN_MPL2_ONLY
        $<$<STREQUAL:${RESERVED_SYMBOL},true>:-g>
        -fPIE
    )

    target_link_options(aicpu_scheduler PRIVATE
        -pie
    )

    target_include_directories(aicpu_scheduler PRIVATE
        ${commom_inc_path}
    )

    target_link_libraries(aicpu_scheduler PRIVATE
        $<BUILD_INTERFACE:intf_pub_cxx17>
        PUBLIC c_sec
        unified_dlog
        aicpu_scheduler_so
        ascend_hal_stub
        aicpu_processer 
        dp_stub
        aicpu_prof
        aicpu_sharder
        $<$<STREQUAL:${tdt_server_depend},true>:tdtserver>
        tsd_eventclient_stub 
        adump_stub
        stackcore_stub 
        Eigen3::Eigen
        json
        -ldl
        $<BUILD_INTERFACE:c_sec_headers>
    )

    set_target_properties(aicpu_scheduler_so
        PROPERTIES
        OUTPUT_NAME aicpu_scheduler
    )

    install(TARGETS aicpu_scheduler_so OPTIONAL
        EXPORT aicpu_scheduler_so-targets
        LIBRARY DESTINATION ${INSTALL_LIBRARY_DIR}
   )
   
   install(TARGETS aicpu_scheduler OPTIONAL
       EXPORT aicpu_scheduler-targets
       LIBRARY DESTINATION ${INSTALL_LIBRARY_DIR}
   )

endif()
