# -----------------------------------------------------------------------------------------------------------
# Copyright (c) 2026 Huawei Technologies Co., Ltd.
# This program is free software, you can redistribute it and/or modify it under the terms and conditions of
# CANN Open Software License Agreement Version 2.0 (the "License").
# Please refer to the License for details. You may not use this file except in compliance with the License.
# THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
# INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
# See LICENSE in the root of the software repository for the full text of the License.
# -----------------------------------------------------------------------------------------------------------
set(BASE_DIR ${CMAKE_CURRENT_SOURCE_DIR})

set(runtimeut_src_task_list
    ${TOP_DIR}/src/runtime/core/src/task/ctrl_res_pool.cpp
    ${TOP_DIR}/src/runtime/core/src/task/host_task.cc
    ${TOP_DIR}/src/runtime/core/src/task/stars_cond_isa_helper.cc
    ${TOP_DIR}/src/runtime/core/src/task/task.cc
    ${TOP_DIR}/src/runtime/core/src/task/task_execute_time.cc
    ${TOP_DIR}/src/runtime/core/src/task/task_info/barrier/barrier_task.cc
    ${TOP_DIR}/src/runtime/core/src/task/task_info/cmo/cmo_task.cc
    ${TOP_DIR}/src/runtime/core/src/task/task_info/common/common_task.cc
    ${TOP_DIR}/src/runtime/core/src/task/task_info/common/common_task_v100.cc
    ${TOP_DIR}/src/runtime/core/src/task/task_info/cond_op/cond_op_label_task.cc
    ${TOP_DIR}/src/runtime/core/src/task/task_info/cond_op/cond_op_stream_task.cc
    ${TOP_DIR}/src/runtime/core/src/task/task_info/davinci/davinci_kernel_task.cc
    ${TOP_DIR}/src/runtime/core/src/task/task_info/davinci/davinci_multiple_task.cc
    ${TOP_DIR}/src/runtime/core/src/task/task_info/dump/dump_task.cc
    ${TOP_DIR}/src/runtime/core/src/task/task_info/dump/dump_task_v100.cc
    ${TOP_DIR}/src/runtime/core/src/task/task_info/event/event_task.cc
    ${TOP_DIR}/src/runtime/core/src/task/task_info/event/event_task_v100.cc
    ${TOP_DIR}/src/runtime/core/src/task/task_info/event/notify_task.cc
    ${TOP_DIR}/src/runtime/core/src/task/task_info/event/notify_task_v100.cc
    ${TOP_DIR}/src/runtime/core/src/task/task_info/maintenance/float_status_task.cc
    ${TOP_DIR}/src/runtime/core/src/task/task_info/maintenance/maintenance_task.cc
    ${TOP_DIR}/src/runtime/core/src/task/task_info/maintenance/maintenance_task_v100.cc
    ${TOP_DIR}/src/runtime/core/src/task/task_info/memory/memory_task.cc
    ${TOP_DIR}/src/runtime/core/src/task/task_info/memory/memory_task_v100.cc
    ${TOP_DIR}/src/runtime/core/src/task/task_info/model/kernel_fusion_task.cc
    ${TOP_DIR}/src/runtime/core/src/task/task_info/model/model_execute_task.cc
    ${TOP_DIR}/src/runtime/core/src/task/task_info/model/model_graph_task.cc
    ${TOP_DIR}/src/runtime/core/src/task/task_info/model/model_maintaince_task.cc
    ${TOP_DIR}/src/runtime/core/src/task/task_info/model/model_to_aicpu_task.cc
    ${TOP_DIR}/src/runtime/core/src/task/task_info/model/model_update_task.cc
    ${TOP_DIR}/src/runtime/core/src/task/task_info/profiling/profiling_task.cc
    ${TOP_DIR}/src/runtime/core/src/task/task_info/random_num_task.cc
    ${TOP_DIR}/src/runtime/core/src/task/task_info/reduce/reduce_task.cc
    ${TOP_DIR}/src/runtime/core/src/task/task_info/reduce/reduce_task_v100.cc
    ${TOP_DIR}/src/runtime/core/src/task/task_info/ringbuffer_maintain/ringbuffer_maintain_task.cc
    ${TOP_DIR}/src/runtime/core/src/task/task_info/ringbuffer_maintain/ringbuffer_maintain_task_v100.cc
    ${TOP_DIR}/src/runtime/core/src/task/task_info/stream/stream_task.cc
    ${TOP_DIR}/src/runtime/core/src/task/task_info/task_manager.cc
    ${TOP_DIR}/src/runtime/core/src/task/task_info/timeout_set/timeout_set_task.cc
    ${TOP_DIR}/src/runtime/core/src/task/task_info/timeout_set/timeout_set_task_v100.cc
    ${TOP_DIR}/src/runtime/core/src/task/task_res_manage/task_res.cc
    ${TOP_DIR}/src/runtime/core/src/task/task_submit/v100/task_submit.cc
    ${TOP_DIR}/src/runtime/core/src/task/tiny/memory_task_v100_external_event_tiny_stub.cc
    ${TOP_DIR}/src/runtime/core/src/task/v100/memory_corruption_checker.cc
    ${TOP_DIR}/src/runtime/core/src/task/v100/stub_task.cc
    ${TOP_DIR}/src/runtime/core/src/task/v100/task_adpter.cc
    ${TOP_DIR}/src/runtime/core/src/task/v100/task_checker.cc
)

set(libruntime_src_files_include_for_arch5162
    ${TOP_DIR}/src/runtime/core/src/api_impl/api_error_tiny_stub.cc
    ${TOP_DIR}/src/runtime/core/src/api_impl/api_impl_tiny_stub.cc
    ${TOP_DIR}/src/runtime/core/src/api_impl/v100/api_impl_v100.cc
    ${TOP_DIR}/src/runtime/core/src/context/context_tiny_stub.cc
    ${TOP_DIR}/src/runtime/core/src/dfx/printf_tiny_stub.cc
    ${TOP_DIR}/src/runtime/core/src/event/ipc_event_tiny_stub.cc
    ${TOP_DIR}/src/runtime/core/src/pool/event_pool_tiny_stub.cc
    ${TOP_DIR}/src/runtime/core/src/pool/event_expanding_tiny_stub.cc
    ${TOP_DIR}/src/runtime/driver/npu_driver_tiny_stub.cc
    ${TOP_DIR}/src/runtime/core/src/engine/engine_factory_tiny_stub.cc
    ${TOP_DIR}/src/runtime/core/src/task/tiny/rdma_task_tiny_stub.cc
    ${TOP_DIR}/src/runtime/feature/ffts/ffts_task_tiny_stub.cc

    ${TOP_DIR}/src/runtime/feature/snapshot/tiny/device_snapshot_tiny_stub.cc
    ${TOP_DIR}/src/runtime/feature/snapshot/tiny/snapshot_callback_manager_tiny_stub.cc
    ${TOP_DIR}/src/runtime/feature/snapshot/tiny/snapshot_process_helper_tiny_stub.cc

    ${TOP_DIR}/src/runtime/core/src/task/tiny/task_tiny_stub.cc
    ${TOP_DIR}/src/runtime/core/src/profiler/api_profile_decorator_tiny_stub.cc
    ${TOP_DIR}/src/runtime/core/src/profiler/api_profile_log_decoratoc_tiny_stub.cc
)

set(runtimeut_src_api_list
    ${TOP_DIR}/src/runtime/api/api.cc
    ${TOP_DIR}/src/runtime/api/api_c.cc
    ${TOP_DIR}/src/runtime/api/api_c_context.cc
    ${TOP_DIR}/src/runtime/api/api_c_device.cc
    ${TOP_DIR}/src/runtime/api/api_c_event.cc
    ${TOP_DIR}/src/runtime/api/api_c_kernel.cc
    ${TOP_DIR}/src/runtime/api/api_c_mbuf.cc
    ${TOP_DIR}/src/runtime/api/api_c_memory.cc
    ${TOP_DIR}/src/runtime/api/api_c_model.cc
    ${TOP_DIR}/src/runtime/api/api_c_soc.cc
    ${TOP_DIR}/src/runtime/api/api_c_stream.cc
    ${TOP_DIR}/src/runtime/api/api_c_tiny_stub.cc
    ${TOP_DIR}/src/runtime/api/api_global_err.cc
    ${TOP_DIR}/src/runtime/api/api_handle_guard.cc
    ${TOP_DIR}/src/runtime/api/inner.cc
)

set(runtimeut_src_api_impl_list
    ${TOP_DIR}/src/runtime/core/src/api_impl/api_decorator.cc
    ${TOP_DIR}/src/runtime/core/src/api_impl/api_error.cc
    ${TOP_DIR}/src/runtime/core/src/api_impl/api_impl.cc
    ${TOP_DIR}/src/runtime/core/src/api_impl/api_impl_creator.cc
    ${TOP_DIR}/src/runtime/core/src/api_impl/api_impl_mbuf.cc
    ${TOP_DIR}/src/runtime/core/src/api_impl/v100/api_impl_creator_c.cc
)

set(runtimeut_src_common_list
    ${TOP_DIR}/src/runtime/core/src/common/args_buffer_guard.cc
    ${TOP_DIR}/src/runtime/core/src/common/context_data_manage.cc
    ${TOP_DIR}/src/runtime/core/src/common/dev_info_manage.cc
    ${TOP_DIR}/src/runtime/core/src/common/errcode_manage.cc
    ${TOP_DIR}/src/runtime/core/src/common/error_code.cc
    ${TOP_DIR}/src/runtime/core/src/common/error_message_manage.cc
    ${TOP_DIR}/src/runtime/core/src/common/global_state_manager.cc
    ${TOP_DIR}/src/runtime/core/src/common/heterogenous.cc
    ${TOP_DIR}/src/runtime/core/src/common/inner_thread_local.cpp
    ${TOP_DIR}/src/runtime/core/src/common/performance_record.cc
    ${TOP_DIR}/src/runtime/core/src/common/prof_ctrl_callback_manager.cc
    ${TOP_DIR}/src/runtime/core/src/common/profiling_agent.cc
    ${TOP_DIR}/src/runtime/core/src/common/register_memory.cc
    ${TOP_DIR}/src/runtime/core/src/common/rt_log.cc
    ${TOP_DIR}/src/runtime/core/src/common/runtime_handle_guard.cc
    ${TOP_DIR}/src/runtime/core/src/common/soc_info.cc
    ${TOP_DIR}/src/runtime/core/src/common/task_fail_callback_data_manager.cc
    ${TOP_DIR}/src/runtime/core/src/common/thread_local_container.cc
    ${TOP_DIR}/src/runtime/core/src/common/utils.cc
    ${TOP_DIR}/src/runtime/feature/xpu/xpu_task_fail_callback_data_manager.cc
)

set(runtimeut_src_context_list
    ${TOP_DIR}/src/runtime/core/src/context/context.cc
    ${TOP_DIR}/src/runtime/core/src/context/context_manage.cc
)

set(runtimeut_common_src_stream_list
    ${TOP_DIR}/src/runtime/core/src/stream/coprocessor_stream.cc
    ${TOP_DIR}/src/runtime/core/src/stream/ctrl_stream.cc
    ${TOP_DIR}/src/runtime/core/src/stream/dvpp_grp.cc
    ${TOP_DIR}/src/runtime/core/src/stream/engine_stream_observer.cc
    ${TOP_DIR}/src/runtime/core/src/stream/stream.cc
    ${TOP_DIR}/src/runtime/core/src/stream/stream_factory.cc
    ${TOP_DIR}/src/runtime/core/src/stream/stream_sqcq_manage.cc
)

set(runtimeut_src_stream_list
    ${runtimeut_common_src_stream_list}
    ${TOP_DIR}/src/runtime/core/src/stream/v100/stream_creator_c.cc
)

set(runtimeut_src_profile_list
    ${TOP_DIR}/src/runtime/core/src/profiler/api_profile_decorator.cc
    ${TOP_DIR}/src/runtime/core/src/profiler/api_profile_log_decorator.cc
    ${TOP_DIR}/src/runtime/core/src/profiler/npu_driver_record.cc
    ${TOP_DIR}/src/runtime/core/src/profiler/onlineprof.cc
    ${TOP_DIR}/src/runtime/core/src/profiler/prof_map_ge_model_device.cc
    ${TOP_DIR}/src/runtime/core/src/profiler/profile_log_record.cc
    ${TOP_DIR}/src/runtime/core/src/profiler/profiler.cc
)

set(runtime_src_arg_loader_list
    ${TOP_DIR}/src/runtime/core/src/kernel/arg_loader/arg_manage_pcie.cc
    ${TOP_DIR}/src/runtime/core/src/kernel/arg_loader/load_policy.cc
    ${TOP_DIR}/src/runtime/core/src/kernel/arg_loader/stars_arg_manager.cc
    ${TOP_DIR}/src/runtime/core/src/kernel/arg_loader/uma_arg_loader.cc
)

set(runtimeut_src_pool_list
    ${TOP_DIR}/src/runtime/core/src/pool/bitmap.cc
    ${TOP_DIR}/src/runtime/core/src/pool/buffer_allocator.cc
    ${TOP_DIR}/src/runtime/core/src/pool/h2d_copy_mgr.cc
    ${TOP_DIR}/src/runtime/core/src/pool/memory_list.cc
    ${TOP_DIR}/src/runtime/core/src/pool/memory_pool.cc
    ${TOP_DIR}/src/runtime/core/src/pool/memory_pool_manager.cc
    ${TOP_DIR}/src/runtime/core/src/pool/spm_pool.cc
    ${TOP_DIR}/src/runtime/core/src/pool/task_allocator.cc
)

set(runtimeut_src_ttlv_list
    ${TOP_DIR}/src/runtime/core/src/ttlv/ttlv.cc
    ${TOP_DIR}/src/runtime/core/src/ttlv/ttlv_decoder_utils.cc
    ${TOP_DIR}/src/runtime/core/src/ttlv/ttlv_paragraph_decoder.cc
    ${TOP_DIR}/src/runtime/core/src/ttlv/ttlv_sentence_decoder.cc
    ${TOP_DIR}/src/runtime/core/src/ttlv/ttlv_word_decoder.cc
)

set(runtimeut_src_callback_list
    ${TOP_DIR}/src/runtime/core/src/device/device_state_callback_manager.cc
    ${TOP_DIR}/src/runtime/core/src/event/event_state_callback_manager.cc
    ${TOP_DIR}/src/runtime/core/src/stream/stream_state_callback_manager.cc
    ${TOP_DIR}/src/runtime/core/src/task/task_fail_callback_manager.cc
)


set(runtime_raw_device_adpt_common_list
    ${TOP_DIR}/src/runtime/core/src/device/raw_device_adpt_comm.cc
)


set(runtimeut_src_aclgraph_list
    ${TOP_DIR}/src/runtime/core/src/task/task_info/cond_op/aclgraph_cond_task.cc
    ${TOP_DIR}/src/runtime/feature/aclgraph/api_decorator_aclgraph.cc
    ${TOP_DIR}/src/runtime/feature/aclgraph/capture_model_utils.cc
    ${TOP_DIR}/src/runtime/feature/aclgraph/cond_handle.cc
    ${TOP_DIR}/src/runtime/feature/aclgraph/event_capture.cc
    ${TOP_DIR}/src/runtime/feature/aclgraph/model_aclgraph.cc
    ${TOP_DIR}/src/runtime/feature/aclgraph/stream_capture.cc
    ${TOP_DIR}/src/runtime/feature/aclgraph/tiny/capture_adapt_tiny_stub.cc
    ${TOP_DIR}/src/runtime/feature/aclgraph/tiny/capture_model_tiny_stub.cc
    ${TOP_DIR}/src/runtime/feature/aclgraph/tiny/context_tiny_stub_aclgraph.cc
    ${TOP_DIR}/src/runtime/feature/jetty/jetty_stub.cc
)

set(runtimeut_src_device_list
    ${TOP_DIR}/src/runtime/core/src/device/aicpu_err_msg.cc
    ${TOP_DIR}/src/runtime/core/src/device/ctrl_msg.cc
    ${TOP_DIR}/src/runtime/core/src/device/ctrl_sq.cc
    ${TOP_DIR}/src/runtime/core/src/device/device.cc
    ${TOP_DIR}/src/runtime/core/src/device/device_error_core_proc.cc
    ${TOP_DIR}/src/runtime/core/src/device/device_error_proc.cc
    ${TOP_DIR}/src/runtime/core/src/device/device_msg_handler.cc
    ${TOP_DIR}/src/runtime/core/src/device/device_sq_cq_pool.cc
    ${TOP_DIR}/src/runtime/core/src/device/ini_parse_utils.cc
    ${TOP_DIR}/src/runtime/core/src/device/raw_device.cc
    ${TOP_DIR}/src/runtime/core/src/device/raw_device_res.cc
    ${TOP_DIR}/src/runtime/core/src/device/sq_addr_memory_pool.cc
    ${TOP_DIR}/src/runtime/core/src/device/v100/device_error_proc.cc
)

set(runtimeut_src_kernel_list
    ${TOP_DIR}/src/runtime/core/src/kernel/args/args_handle_allocator.cc
    ${TOP_DIR}/src/runtime/core/src/kernel/args/para_convertor.cc
    ${TOP_DIR}/src/runtime/core/src/kernel/binary_loader.cc
    ${TOP_DIR}/src/runtime/core/src/kernel/elf.cc
    ${TOP_DIR}/src/runtime/core/src/kernel/funcsymbol_table.cc
    ${TOP_DIR}/src/runtime/core/src/kernel/json_parse.cc
    ${TOP_DIR}/src/runtime/core/src/kernel/kernel.cc
    ${TOP_DIR}/src/runtime/core/src/kernel/kernel_utils.cc
    ${TOP_DIR}/src/runtime/core/src/kernel/module.cc
    ${TOP_DIR}/src/runtime/core/src/kernel/program.cc
    ${TOP_DIR}/src/runtime/core/src/kernel/program_common.cc
    ${TOP_DIR}/src/runtime/core/src/kernel/symbol_table.cc
    ${TOP_DIR}/src/runtime/core/src/kernel/v100/kernel.cc
    ${TOP_DIR}/src/runtime/core/src/kernel/v100/program_plat.cc
)

set(runtimeut_src_list
    ${runtimeut_src_task_list}
    ${runtimeut_src_api_list}
    ${runtimeut_src_aclgraph_list}
    ${runtimeut_src_context_list}
    ${runtimeut_src_stream_list}
    ${runtimeut_src_profile_list}
    ${runtime_src_arg_loader_list}
    ${runtimeut_src_pool_list}
    ${runtimeut_src_ttlv_list}
    ${runtimeut_src_callback_list}
    ${runtime_xpu_src}
    ${runtimeut_src_common_list}
    ${libruntime_src_files_include_for_arch5162}
    ${runtimeut_src_api_impl_list}
    ${runtimeut_src_device_list}
    ${runtimeut_src_kernel_list}
    ${TOP_DIR}/src/runtime/core/src/dfx/atrace_log.cc
    ${TOP_DIR}/src/runtime/core/src/dfx/fast_recover.cc
    ${TOP_DIR}/src/runtime/core/src/dfx/kernel_dfx_info.cc
    ${TOP_DIR}/src/runtime/core/src/dfx/pctrace.cc
    ${TOP_DIR}/src/runtime/core/src/engine/engine.cc
    ${TOP_DIR}/src/runtime/core/src/engine/hwts/package_rebuilder.cc
    ${TOP_DIR}/src/runtime/core/src/engine/hwts/scheduler.cc
    ${TOP_DIR}/src/runtime/core/src/engine/logger.cc
    ${TOP_DIR}/src/runtime/core/src/engine/stars/stars_engine.cc
    ${TOP_DIR}/src/runtime/core/src/event/event.cc
    ${TOP_DIR}/src/runtime/core/src/launch/aicpu_stars.cc
    ${TOP_DIR}/src/runtime/core/src/launch/aix_stars.cc
    ${TOP_DIR}/src/runtime/core/src/launch/cmo_barrier_common.cc
    ${TOP_DIR}/src/runtime/core/src/launch/cmo_barrier_stars.cc
    ${TOP_DIR}/src/runtime/core/src/launch/cond_stars.cc
    ${TOP_DIR}/src/runtime/core/src/launch/dvpp_stars.cc
    ${TOP_DIR}/src/runtime/core/src/launch/label.cc
    ${TOP_DIR}/src/runtime/core/src/launch/label_common.cc
    ${TOP_DIR}/src/runtime/core/src/launch/label_stars.cc
    ${TOP_DIR}/src/runtime/core/src/launch/memcpy_stars.cc
    ${TOP_DIR}/src/runtime/core/src/launch/memory_common.cc
    ${TOP_DIR}/src/runtime/core/src/launch/memory_stars.cc
    ${TOP_DIR}/src/runtime/core/src/launch/xpu_aicpu_c_stub.cc
    ${TOP_DIR}/src/runtime/core/src/memory/mem_type.cc
    ${TOP_DIR}/src/runtime/core/src/notify/notify.cc
    ${TOP_DIR}/src/runtime/core/src/plugin_manage/runtime_keeper.cc
    ${TOP_DIR}/src/runtime/core/src/plugin_manage/v100/plugin_old_arch.cc
    ${TOP_DIR}/src/runtime/core/src/runtime.cc
    ${TOP_DIR}/src/runtime/core/src/runtime_v100/runtime_adapt.cc 
    ${TOP_DIR}/src/runtime/core/src/utils/aicpu_scheduler_agent.cc
    ${TOP_DIR}/src/runtime/core/src/utils/capability.cc
    ${TOP_DIR}/src/runtime/core/src/utils/osal.cc
    ${TOP_DIR}/src/runtime/core/src/utils/subscribe.cc
    ${TOP_DIR}/src/runtime/core/src/uvm/uvm_callback.cc
    ${TOP_DIR}/src/runtime/driver/driver.cc
    ${TOP_DIR}/src/runtime/driver/npu_driver_dcache_lock_common.cpp
    ${TOP_DIR}/src/runtime/driver/npu_driver_tiny.cpp
    ${TOP_DIR}/src/runtime/feature/model/model.cc
    ${TOP_DIR}/src/runtime/feature/model/model_rebuild.cc
    ${TOP_DIR}/src/runtime/feature/soma/soma.cc
    ${TOP_DIR}/src/runtime/feature/soma/stream_mem_pool.cc 
)

###################################################################################################
add_library(runtimeut_src_static_lib_5162a STATIC ${runtimeut_src_list})

target_include_directories(
    runtimeut_src_static_lib_5162a PUBLIC 
    ${TOP_DIR}/src/runtime/tprt/inc/external
    ${TOP_DIR}/src/runtime/tprt/feature/inc
    ${TOP_DIR}/abl/slog/inc
    ${TOP_DIR}/abl/mmpa/inc
    ${TOP_DIR}/abl/libc_sec/include
)

target_compile_definitions(runtimeut_src_static_lib_5162a PUBLIC
    TEMP_PERFORMANCE
    TEMP_PERFORMANCE_NOT_OUTPUT
)

target_link_libraries(runtimeut_src_static_lib_5162a PRIVATE $<BUILD_INTERFACE:runtime_utest_intf_pub_arch5162>)
###################################################################################################
set(stub_src_list
    ${TOP_DIR}/tests/ut/runtime/runtime/stub/atrace_stub.cc
    ${TOP_DIR}/tests/ut/runtime/runtime/stub/awatch_dog_stub.cc
    ${TOP_DIR}/tests/ut/runtime/runtime/stub/error_manager_stub.cc
    ${TOP_DIR}/tests/ut/runtime/runtime/stub/log_stub.cc
    ${TOP_DIR}/tests/ut/runtime/runtime/stub/prof_stub.cc
    ${TOP_DIR}/tests/ut/runtime/runtime/stub/platform_stub.cc
)
add_library(runtime_ut_stub_static_lib_5162a STATIC ${stub_src_list})

target_link_libraries(runtime_ut_stub_static_lib_5162a PRIVATE $<BUILD_INTERFACE:runtime_utest_intf_pub_arch5162>)

###################################################################################################
add_executable(runtime_utest_arch5162
    ${runtime_raw_device_adpt_common_list}
    ${TOP_DIR}/src/runtime/driver/npu_driver.cc
    ${TOP_DIR}/src/runtime/driver/npu_driver_mem.cc
    ${TOP_DIR}/src/runtime/driver/npu_driver_queue.cc
    ${TOP_DIR}/src/runtime/driver/npu_driver_res.cc
    ${TOP_DIR}/src/runtime/driver/npu_driver_dcache_lock_opb.cpp
    ${TOP_DIR}/src/runtime/driver/v100/npu_driver.cc
    stub/hal_stub.cc
    main.cc
)

target_compile_definitions(runtime_utest_arch5162 PUBLIC
    TEMP_PERFORMANCE
    TEMP_PERFORMANCE_NOT_OUTPUT
)

target_link_libraries(runtime_utest_arch5162 PRIVATE
    $<BUILD_INTERFACE:runtime_utest_intf_pub_arch5162>
    -Wl,--whole-archive
     runtimeut_src_static_lib_5162a
     runtime_ut_stub_static_lib_5162a
    -Wl,--no-whole-archive
)
###################################################################################################


##################################################################################################
add_library(runtime_utest_intf_pub_arch5162 INTERFACE)

target_compile_definitions(runtime_utest_intf_pub_arch5162 INTERFACE
    __RUNTIME_PRODUCT_DRV_MINI__
    _GLIBCXX_USE_CXX11_ABI=0
    FEATURE_NOTIFY
    FEATURE_PCTRACE
    FEATURE_DEBUG
    CFG_DEV_PLATFORM_PC
    STATIC_RT_LIB
    TEMP_PERFORMANCE
    TEMP_PERFORMANCE_NOT_OUTPUT
)

set(RUNTIME_TEST_INC_DIR_COMMON
    ${TOP_DIR}/include/driver
    ${TOP_DIR}/pkg_inc/aicpu_sched
    ${TOP_DIR}/pkg_inc/aicpu_sched/common
    ${TOP_DIR}/src/tsd/tsdclient/inc/tsd
    ${TOP_DIR}/src/tsd/tsdclient/inc
    ${TOP_DIR}/inc/external
    ${TOP_DIR}/abl/libc_sec/include
    ${TOP_DIR}/src/runtime/core/inc
    ${TOP_DIR}/src/runtime/core/inc_c
    ${TOP_DIR}/src/runtime/core/inc/context
    ${TOP_DIR}/src/runtime/core/inc/spec
    ${TOP_DIR}/src/runtime/inc/common
    ${TOP_DIR}/src/runtime/core/inc/common
    ${TOP_DIR}/src/runtime/core/inc/cond_handle
    ${TOP_DIR}/src/runtime/inc/device
    ${TOP_DIR}/src/runtime/inc/sqe
    ${TOP_DIR}/src/runtime/core/inc/sqe/v200_base
    ${TOP_DIR}/src/runtime/core/inc/runtime
    ${TOP_DIR}/src/runtime/core/inc/device
    ${TOP_DIR}/src/runtime/core/inc/drv
    ${TOP_DIR}/src/runtime/core/inc/task
    ${TOP_DIR}/src/runtime/core/inc/utils
    ${TOP_DIR}/src/runtime/core/inc/engine
    ${TOP_DIR}/src/runtime/core/inc/dfx
    ${TOP_DIR}/src/runtime/core/inc/kernel
    ${TOP_DIR}/src/runtime/core/inc/soc
    ${TOP_DIR}/src/runtime/core/inc/stars
    ${TOP_DIR}/src/runtime/core/inc/stream
    ${TOP_DIR}/src/runtime/core/inc/launch
    ${TOP_DIR}/src/runtime/core/inc/model
    ${TOP_DIR}/src/runtime/feature/jetty
    ${TOP_DIR}/src/runtime/core/inc/event
    ${TOP_DIR}/src/runtime/core/inc/arg_loader
    ${TOP_DIR}/src/runtime/core/inc/notify
    ${TOP_DIR}/src/runtime/core/inc/profiler
    ${TOP_DIR}/src/runtime/feature/cntnotify
    ${TOP_DIR}/src/runtime/core/inc/engine/hwts
    ${TOP_DIR}/src/runtime/core/inc/dqs
    ${TOP_DIR}/src/runtime/api
    ${TOP_DIR}/src/runtime/core/src/api_impl
    ${TOP_DIR}/src/runtime/core/src/engine
    ${TOP_DIR}/src/runtime/core/src/engine/hwts
    ${TOP_DIR}/src/runtime/core/src/engine/stars
    ${TOP_DIR}/src/runtime/core/src/dfx
    ${TOP_DIR}/src/runtime/core/src/stream
    ${TOP_DIR}/src/runtime/core/src/task/inc
    ${TOP_DIR}/src/runtime/feature/ffts
    ${TOP_DIR}/src/runtime/core/src/profiler
    ${TOP_DIR}/src/runtime/core/src/pool
    ${TOP_DIR}/src/runtime/core/src/ttlv
    ${TOP_DIR}/src/runtime/core/src/device
    ${TOP_DIR}/src/runtime/driver
    ${TOP_DIR}/src/runtime/core/src/common
    ${TOP_DIR}/src/runtime/core/src/plugin_manage
    ${TOP_DIR}/src/runtime/core/src/kernel
    ${TOP_DIR}/src/runtime/core/src/kernel/arg_loader
    ${TOP_DIR}/src/runtime/core/src/kernel/args
    ${TOP_DIR}/src/runtime/core/src/uvm
    ${TOP_DIR}/src
    ${TOP_DIR}/src/inc/runtime
    ${TOP_DIR}/src/runtime/raw_driver
    ${TOP_DIR}/src/cmodel_driver
    ${TOP_DIR}/src/runtime_compact/feature/inc
    ${TOP_DIR}/metadef/inc
    ${TOP_DIR}/src/dfx/adump/inc/metadef
    ${TOP_DIR}/metadef/inc/external
    ${TOP_DIR}/tests/ut/runtime/runtime/stub/
    ${TOP_DIR}/tests/ut/runtime/runtime/test/common
    ${TOP_DIR}/include
    ${TOP_DIR}/pkg_inc/tsd
    ${TOP_DIR}/pkg_inc/trace
    ${TOP_DIR}/src/dfx/trace/inc/toolchain
    ${TOP_DIR}/pkg_inc/watchdog
    ${TOP_DIR}/pkg_inc/profiling
    ${TOP_DIR}/abl/atrace/inc/awatchdog/
    ${TOP_DIR}/src/runtime/core/src/task/
    ${TOP_DIR}/pkg_inc
    ${TOP_DIR}/src/queue_schedule/dgwclient/inc
    ${TOP_DIR}/src/dfx/msprof/include/external/runtime/rts
    ${TOP_DIR}/src/inc
    ${TOP_DIR}/src/inc/external
    ${TOP_DIR}/include/external/acl
    ${TOP_DIR}/include/external/acl/error_codes
    ${TOP_DIR}/pkg_inc/runtime/runtime
    ${TOP_DIR}/pkg_inc/runtime/runtime/rts
    ${TOP_DIR}/pkg_inc/platform
    ${TOP_DIR}/src/platform
    ${TOP_DIR}/src/runtime/core/src/memory/
    ${TOP_DIR}/src/runtime/feature/soma/
    ${TOP_DIR}/src/runtime/feature/snapshot/
    ${TOP_DIR}/src/runtime/feature/xpu/
    ${TOP_DIR}/src/runtime/core/src/event
    ${C_SEC_INCLUDE}
)

set(RUNTIME_TEST_INC_DIR
    ${RUNTIME_TEST_INC_DIR_COMMON}
    ${TOP_DIR}/src/runtime/core/inc/sqe/v200
    ${TOP_DIR}/src/runtime/core/inc/cond_isa/v100
)

target_include_directories(runtime_utest_intf_pub_arch5162 INTERFACE
    ${RUNTIME_TEST_INC_DIR}
)

target_compile_options(runtime_utest_intf_pub_arch5162 INTERFACE
    -Wformat
    -Wall
    -Wextra
    -fno-access-control
    -fno-devirtualize
    -fno-inline-small-functions
    $<$<STREQUAL: ${CMAKE_SYSTEM_PROCESSOR}, aarch64>:-falign-functions=32>
)

target_link_libraries(runtime_utest_intf_pub_arch5162 INTERFACE
    mmpa
    json
    GTestShared::gtest
    GTestShared::gtest_main
    c_sec
    -lrt
    -ldl
    -lpthread
    -lgcov
    $<BUILD_INTERFACE:intf_llt_pub_arch5162>
    $<BUILD_INTERFACE:mmpa_headers>
    $<BUILD_INTERFACE:c_sec_headers>
    $<BUILD_INTERFACE:msprof_headers>
    $<BUILD_INTERFACE:slog_headers>
    $<BUILD_INTERFACE:npu_runtime_headers>
)

target_link_options(runtime_utest_intf_pub_arch5162 INTERFACE
    -Wl,--wrap=malloc,-lrt
    -rdynamic
)

add_library(intf_llt_pub_arch5162 INTERFACE)

target_include_directories(intf_llt_pub_arch5162 INTERFACE
)

target_compile_definitions(intf_llt_pub_arch5162 INTERFACE
    CFG_BUILD_DEBUG
    _GLIBCXX_USE_CXX11_ABI=0
)

target_compile_options(intf_llt_pub_arch5162 INTERFACE
    -g
    -w
    $<$<BOOL:${ENABLE_GCOV}>:-fprofile-arcs -ftest-coverage>
    $<$<BOOL:${ENABLE_ASAN}>:-fsanitize=address -fno-omit-frame-pointer -static-libasan -fsanitize=undefined -static-libubsan -fsanitize=leak -static-libtsan>
    -fPIC
    -pipe
)

target_link_options(intf_llt_pub_arch5162 INTERFACE
    $<$<BOOL:${ENABLE_GCOV}>:-fprofile-arcs -ftest-coverage>
    $<$<BOOL:${ENABLE_ASAN}>:-fsanitize=address -static-libasan -fsanitize=undefined  -static-libubsan -fsanitize=leak -static-libtsan>
)

target_link_directories(intf_llt_pub_arch5162 INTERFACE
)

target_link_libraries(intf_llt_pub_arch5162 INTERFACE
    GTestShared::gtest
    mockcpp
    -lpthread
    $<$<BOOL:${ENABLE_GCOV}>:-lgcov>
)
