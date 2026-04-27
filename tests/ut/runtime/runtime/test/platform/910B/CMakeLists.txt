# -----------------------------------------------------------------------------------------------------------
# Copyright (c) 2025 Huawei Technologies Co., Ltd.
# This program is free software, you can redistribute it and/or modify it under the terms and conditions of
# CANN Open Software License Agreement Version 2.0 (the "License").
# Please refer to the License for details. You may not use this file except in compliance with the License.
# THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
# INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
# See LICENSE in the root of the software repository for the full text of the License.
# -----------------------------------------------------------------------------------------------------------
include_directories(${CANN_3RD_LIB_PATH}/boost-1.87.0)
include_directories(${CANN_3RD_LIB_PATH}/mockcpp_src/include)

set(runtime_raw_device_adpt_common_list
    ${TOP_DIR}/src/runtime/core/src/device/raw_device_adpt_comm.cc
)

set(runtimeut_common_src_task_list
    ${TOP_DIR}/src/runtime/core/src/task/task.cc
    ${TOP_DIR}/src/runtime/core/src/task/task_execute_time.cc
    ${TOP_DIR}/src/runtime/core/src/task/task_res_manage/task_res.cc
    ${TOP_DIR}/src/runtime/core/src/task/task_submit/v100/task_submit.cc
    ${TOP_DIR}/src/runtime/core/src/task/task_info/task_manager.cc
    ${TOP_DIR}/src/runtime/core/src/task/task_info/task_info.cc
    ${TOP_DIR}/src/runtime/feature/ffts/ffts_task.cc
    ${TOP_DIR}/src/runtime/feature/ffts/davinci_kernel_task.cc
    ${TOP_DIR}/src/runtime/core/src/task/task_info/model/model_execute_task.cc
    ${TOP_DIR}/src/runtime/core/src/task/task_info/davinci_kernel_task.cc
    ${TOP_DIR}/src/runtime/core/src/task/task_info/event/event_task.cc
    ${TOP_DIR}/src/runtime/core/src/task/task_info/event/event_task_v100.cc
    ${TOP_DIR}/src/runtime/core/src/task/task_info/memory/memory_task.cc
    ${TOP_DIR}/src/runtime/core/src/task/task_info/memory/memory_task_v100.cc
    ${TOP_DIR}/src/runtime/core/src/task/task_info/rdma_task.cc
    ${TOP_DIR}/src/runtime/feature/ffts/rdma_task.cc
    ${TOP_DIR}/src/runtime/core/src/task/task_info/reduce_task.cc
    ${TOP_DIR}/src/runtime/core/src/task/task_info/cond_op/cond_op_stream_task.cc
    ${TOP_DIR}/src/runtime/core/src/task/task_info/cond_op/cond_op_stream_task_v100.cc
    ${TOP_DIR}/src/runtime/core/src/task/task_info/cond_op/cond_op_label_task.cc
    ${TOP_DIR}/src/runtime/core/src/task/task_info/cond_op/cond_op_label_task_v100.cc
    ${TOP_DIR}/src/runtime/core/src/task/task_info/profiling/profiling_task.cc
    ${TOP_DIR}/src/runtime/core/src/task/task_info/dump/dump_task.cc
    ${TOP_DIR}/src/runtime/core/src/task/task_info/stream/stream_task.cc
    ${TOP_DIR}/src/runtime/core/src/task/task_info/davinci_multiple_task.cc
    ${TOP_DIR}/src/runtime/core/src/task/task_info/stars_common_task.cc
    ${TOP_DIR}/src/runtime/core/src/task/task_info/random_num_task.cc
    ${TOP_DIR}/src/runtime/core/src/task/task_info/barrier/barrier_task.cc
    ${TOP_DIR}/src/runtime/core/src/task/task_info/cmo/cmo_task.cc
    ${TOP_DIR}/src/runtime/core/src/task/task_info/model/model_maintaince_task.cc
    ${TOP_DIR}/src/runtime/core/src/task/task_info/event/notify_task.cc
    ${TOP_DIR}/src/runtime/core/src/task/task_info/event/notify_task_v100.cc
    ${TOP_DIR}/src/runtime/core/src/task/task_info/timeout_set_task.cc
    ${TOP_DIR}/src/runtime/core/src/task/task_info/ringbuffer_maintain_task.cc
    ${TOP_DIR}/src/runtime/core/src/task/task_info/model/model_update_task.cc
    ${TOP_DIR}/src/runtime/core/src/task/task_info/model/model_graph_task.cc
    ${TOP_DIR}/src/runtime/core/src/task/task_info/model/model_to_aicpu_task.cc
    ${TOP_DIR}/src/runtime/core/src/task/task_info/maintenance_task.cc
)

set(runtimeut_src_task_list
    ${runtimeut_common_src_task_list}
    ${TOP_DIR}/src/runtime/core/src/task/v100/davinci_task.cc
    ${TOP_DIR}/src/runtime/core/src/task/v100/task_proc_func_register_xpu.cc
    ${TOP_DIR}/src/runtime/core/src/task/v100/task_checker.cc
    ${TOP_DIR}/src/runtime/core/src/task/v100/memory_corruption_checker.cc
    ${TOP_DIR}/src/runtime/core/src/task/task_info/barrier/barrier_task_v100.cc
    ${TOP_DIR}/src/runtime/core/src/task/task_info/cmo/cmo_task_v100.cc
    ${TOP_DIR}/src/runtime/core/src/task/task_info/profiling/profiling_task_v100.cc
    ${TOP_DIR}/src/runtime/core/src/task/task_info/stream/stream_task_v100.cc
    ${TOP_DIR}/src/runtime/core/src/task/task_info/dump/dump_task_v100.cc
    ${TOP_DIR}/src/runtime/core/src/task/task_info/model/model_execute_task_v100.cc
    ${TOP_DIR}/src/runtime/core/src/task/task_info/model/model_maintaince_task_v100.cc
    ${TOP_DIR}/src/runtime/core/src/task/task_info/model/model_to_aicpu_task_v100.cc
    ${TOP_DIR}/src/runtime/core/src/task/task_info/model/model_update_task_v100.cc
    ${TOP_DIR}/src/runtime/core/src/task/task_info/model/model_graph_task_v100.cc
)

set(runtimeut_src_api_list
    ${TOP_DIR}/src/runtime/api/api_c.cc
    ${TOP_DIR}/src/runtime/api/api_c_standard_soc.cc
    ${TOP_DIR}/src/runtime/api/api_c_soma.cc
    ${TOP_DIR}/src/runtime/api/api_david.cc
    ${TOP_DIR}/src/runtime/api/api_preload_task.cc
    ${TOP_DIR}/src/runtime/api/api_c_context.cc
    ${TOP_DIR}/src/runtime/api/api_c_device.cc
    ${TOP_DIR}/src/runtime/api/api_c_kernel.cc
    ${TOP_DIR}/src/runtime/api/api_c_memory.cc
    ${TOP_DIR}/src/runtime/api/api_c_stream.cc
    ${TOP_DIR}/src/runtime/api/api_c_task.cc
    ${TOP_DIR}/src/runtime/api/api_c_model.cc
    ${TOP_DIR}/src/runtime/api/api_c_event.cc
    ${TOP_DIR}/src/runtime/api/api_c_mbuf.cc
    ${TOP_DIR}/src/runtime/api/api_handle_guard.cc
    ${TOP_DIR}/src/runtime/api/inner.cc
    ${TOP_DIR}/src/runtime/api/api_handle_guard.cc
    ${TOP_DIR}/src/runtime/api/api_global_err.cc
    ${TOP_DIR}/src/runtime/api/api_c_soc.cc
    ${TOP_DIR}/src/runtime/api/api_c_dqs.cc
    ${TOP_DIR}/src/runtime/api/api_c_snapshot.cc
    ${TOP_DIR}/src/runtime/api/api_c_uvm.cc
)

set(runtimeut_src_context_list
    ${TOP_DIR}/src/runtime/core/src/context/context.cc
    ${TOP_DIR}/src/runtime/core/src/context/context_standard_soc.cc
    ${TOP_DIR}/src/runtime/feature/aclgraph/context_standard_soc_aclgraph.cc
    ${TOP_DIR}/src/runtime/feature/ffts/context_ffts_standard_soc.cc
    ${TOP_DIR}/src/runtime/core/src/context/context_manage.cc
    ${TOP_DIR}/src/runtime/core/src/context/context_protect.cc
)

set(runtimeut_src_aclgraph_list
    ${TOP_DIR}/src/runtime/feature/aclgraph/api_decorator_aclgraph.cc
    ${TOP_DIR}/src/runtime/feature/aclgraph/v100/api_impl_aclgraph.cc
    ${TOP_DIR}/src/runtime/feature/aclgraph/v100/api_impl_capture_event.cc
    ${TOP_DIR}/src/runtime/feature/aclgraph/api_error_aclgraph.cc
    ${TOP_DIR}/src/runtime/feature/aclgraph/context_aclgraph.cc
    ${TOP_DIR}/src/runtime/feature/aclgraph/model_aclgraph.cc
    ${TOP_DIR}/src/runtime/feature/aclgraph/capture_model.cc
    ${TOP_DIR}/src/runtime/feature/aclgraph/capture_model_utils.cc
    ${TOP_DIR}/src/runtime/feature/aclgraph/event_capture.cc
    ${TOP_DIR}/src/runtime/feature/aclgraph/stream_capture.cc
)

set(runtimeut_common_src_stream_list
    ${TOP_DIR}/src/runtime/core/src/stream/stream_sqcq_manage.cc
    ${TOP_DIR}/src/runtime/core/src/stream/engine_stream_observer.cc
    ${TOP_DIR}/src/runtime/core/src/stream/stream.cc
    ${TOP_DIR}/src/runtime/core/src/stream/ctrl_stream.cc
    ${TOP_DIR}/src/runtime/core/src/stream/coprocessor_stream.cc
    ${TOP_DIR}/src/runtime/core/src/stream/tsch_stream.cc
    ${TOP_DIR}/src/runtime/core/src/stream/stream_factory.cc
)

set(runtimeut_src_stream_list
    ${runtimeut_common_src_stream_list}
    ${TOP_DIR}/src/runtime/core/src/stream/v100/stream_creator_c.cc
)

set(runtimeut_src_profile_list
    ${TOP_DIR}/src/runtime/core/src/profiler/profiler.cc
    ${TOP_DIR}/src/runtime/core/src/profiler/api_profile_decorator.cc
    ${TOP_DIR}/src/runtime/core/src/profiler/api_profile_log_decorator.cc
    ${TOP_DIR}/src/runtime/core/src/profiler/api_profile_decorator_standard_soc.cc
    ${TOP_DIR}/src/runtime/core/src/profiler/api_profile_log_decoratoc_standard_soc.cc
    ${TOP_DIR}/src/runtime/core/src/profiler/prof_map_ge_model_device.cc
    ${TOP_DIR}/src/runtime/core/src/profiler/profile_log_record.cc
    ${TOP_DIR}/src/runtime/core/src/profiler/npu_driver_record.cc
)

set(runtime_src_arg_loader_list
    ${TOP_DIR}/src/runtime/core/src/kernel/arg_loader/uma_arg_loader.cc
    ${TOP_DIR}/src/runtime/core/src/pool/memory_list.cc
    ${TOP_DIR}/src/runtime/core/src/pool/memory_pool.cc
    ${TOP_DIR}/src/runtime/core/src/pool/memory_pool_manager.cc
)

set(runtimeut_src_pool_list
    ${TOP_DIR}/src/runtime/core/src/pool/bitmap.cc
    ${TOP_DIR}/src/runtime/core/src/pool/buffer_allocator.cc
    ${TOP_DIR}/src/runtime/core/src/pool/task_allocator.cc
    ${TOP_DIR}/src/runtime/core/src/pool/spm_pool.cc
    ${TOP_DIR}/src/runtime/core/src/pool/h2d_copy_mgr.cc
    ${TOP_DIR}/src/runtime/core/src/pool/event_pool.cc
    ${TOP_DIR}/src/runtime/core/src/pool/event_expanding.cc
)

set(runtimeut_src_ttlv_list
    ${TOP_DIR}/src/runtime/core/src/ttlv/ttlv_decoder_utils.cc
    ${TOP_DIR}/src/runtime/core/src/ttlv/ttlv.cc
    ${TOP_DIR}/src/runtime/core/src/ttlv/ttlv_word_decoder.cc
    ${TOP_DIR}/src/runtime/core/src/ttlv/ttlv_sentence_decoder.cc
    ${TOP_DIR}/src/runtime/core/src/ttlv/ttlv_paragraph_decoder.cc
)

set(runtimeut_src_callback_list
    ${TOP_DIR}/src/runtime/core/src/device/device_state_callback_manager.cc
    ${TOP_DIR}/src/runtime/core/src/task/task_fail_callback_manager.cc
    ${TOP_DIR}/src/runtime/core/src/stream/stream_state_callback_manager.cc
    ${TOP_DIR}/src/runtime/core/src/event/event_state_callback_manager.cc
)

set(runtimeut_src_common_list
    ${TOP_DIR}/src/runtime/core/src/common/error_code.cc
    ${TOP_DIR}/src/runtime/core/src/common/thread_local_container.cc
    ${TOP_DIR}/src/runtime/core/src/common/utils.cc
    ${TOP_DIR}/src/runtime/core/src/common/heterogenous.cc
    ${TOP_DIR}/src/runtime/core/src/common/soc_info.cc
    ${TOP_DIR}/src/runtime/core/src/common/context_data_manage.cc
    ${TOP_DIR}/src/runtime/core/src/common/task_fail_callback_data_manager.cc
    ${TOP_DIR}/src/runtime/feature/xpu/xpu_task_fail_callback_data_manager.cc
    ${TOP_DIR}/src/runtime/core/src/common/performance_record.cc
    ${TOP_DIR}/src/runtime/core/src/common/profiling_agent.cc
    ${TOP_DIR}/src/runtime/core/src/common/errcode_manage.cc
    ${TOP_DIR}/src/runtime/core/src/common/error_message_manage.cc
    ${TOP_DIR}/src/runtime/core/src/common/prof_ctrl_callback_manager.cc
    ${TOP_DIR}/src/runtime/core/src/common/rt_log.cc
    ${TOP_DIR}/src/runtime/core/src/common/dev_info_manage.cc
    ${TOP_DIR}/src/runtime/core/src/common/global_state_manager.cc
    ${TOP_DIR}/src/runtime/core/src/common/runtime_handle_guard.cc
    ${TOP_DIR}/src/runtime/core/src/common/register_memory.cc
)

set(runtimeut_platform_list
    ${TOP_DIR}/src/runtime/config/610_lite/dev_info_reg.cc
    ${TOP_DIR}/src/runtime/config/950/dev_info_reg.cc
    ${TOP_DIR}/src/runtime/config/910_B_93/dev_info_reg.cc
    ${TOP_DIR}/src/runtime/config/as31xm1/dev_info_reg.cc
    ${TOP_DIR}/src/runtime/config/bs9sx1a/dev_info_reg.cc
    ${TOP_DIR}/src/runtime/config/cloud/dev_info_reg.cc
    ${TOP_DIR}/src/runtime/config/dc/dev_info_reg.cc
    ${TOP_DIR}/src/runtime/config/mc62cm12a/dev_info_reg.cc
    ${TOP_DIR}/src/runtime/config/adc/dev_info_reg.cc
    ${TOP_DIR}/src/runtime/config/mini/dev_info_reg.cc
    ${TOP_DIR}/src/runtime/config/mini_v3/dev_info_reg.cc
    ${TOP_DIR}/src/runtime/config/nano/dev_info_reg.cc
    ${TOP_DIR}/src/runtime/config/tiny/dev_info_reg.cc
    ${TOP_DIR}/src/runtime/config/910_96/dev_info_reg.cc
    ${TOP_DIR}/src/runtime/config/910_B_93/dev_info_proc_func.cc
)

set(runtimeut_910b_src_list
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
    ${TOP_DIR}/src/runtime/api/api.cc
    ${TOP_DIR}/src/runtime/core/src/api_impl/api_decorator.cc
    ${TOP_DIR}/src/runtime/core/src/api_impl/api_impl.cc
    ${TOP_DIR}/src/runtime/core/src/api_impl/api_impl_mbuf.cc
    ${TOP_DIR}/src/runtime/core/src/api_impl/api_impl_standard_soc.cc
    ${TOP_DIR}/src/runtime/core/src/api_impl/api_impl_soma.cc
    ${TOP_DIR}/src/runtime/core/src/api_impl/api_error.cc
    ${TOP_DIR}/src/runtime/core/src/api_impl/api_error_standard_soc.cc
    ${TOP_DIR}/src/runtime/core/src/api_impl/api_error_uvm.cc
    ${TOP_DIR}/src/runtime/core/src/api_impl/api_impl_uvm.cc
    ${TOP_DIR}/src/runtime/core/src/uvm/uvm_callback.cc
    ${TOP_DIR}/src/runtime/core/src/context/context.cc
    ${TOP_DIR}/src/runtime/core/src/context/context_standard_soc.cc
    ${TOP_DIR}/src/runtime/core/src/device/device.cc
    ${TOP_DIR}/src/runtime/core/src/device/raw_device.cc
    ${TOP_DIR}/src/runtime/core/src/device/raw_device_res.cc
    ${TOP_DIR}/src/runtime/feature/snapshot/device_snapshot.cc
    ${TOP_DIR}/src/runtime/feature/snapshot/snapshot_process_helper.cc
    ${TOP_DIR}/src/runtime/core/src/device/device_sq_cq_pool.cc
    ${TOP_DIR}/src/runtime/core/src/device/sq_addr_memory_pool.cc
    ${TOP_DIR}/src/runtime/core/src/device/ctrl_sq.cc
    ${TOP_DIR}/src/runtime/core/src/device/ctrl_msg.cc
    ${TOP_DIR}/src/runtime/driver/driver.cc
    ${TOP_DIR}/src/runtime/driver/npu_driver_dcache_lock_common.cpp
    ${TOP_DIR}/src/runtime/feature/model/model.cc
    ${TOP_DIR}/src/runtime/feature/model/model_rebuild.cc
    ${TOP_DIR}/src/runtime/feature/model/v100/capture_adapt.cc
    ${TOP_DIR}/src/runtime/feature/aclgraph/v100/capture_adapt_v100.cc
    ${TOP_DIR}/src/runtime/feature/aclgraph/v100/capture_model_adapt_v100.cc
    ${TOP_DIR}/src/runtime/core/src/kernel/args/args_handle_allocator.cc
    ${TOP_DIR}/src/runtime/core/src/kernel/args/para_convertor.cc
    ${TOP_DIR}/src/runtime/core/src/kernel/binary_loader.cc
    ${TOP_DIR}/src/runtime/core/src/kernel/elf.cc
    ${TOP_DIR}/src/runtime/core/src/kernel/kernel.cc
    ${TOP_DIR}/src/runtime/core/src/kernel/module.cc
    ${TOP_DIR}/src/runtime/core/src/kernel/program.cc
    ${TOP_DIR}/src/runtime/feature/soma/soma.cc
    ${TOP_DIR}/src/runtime/feature/soma/stream_mem_pool.cc
    ${TOP_DIR}/src/runtime/core/src/launch/cmo_barrier_common.cc
    ${TOP_DIR}/src/runtime/core/src/launch/cmo_barrier_stars.cc
    ${TOP_DIR}/src/runtime/core/src/launch/label.cc
    ${TOP_DIR}/src/runtime/core/src/launch/cond_stars.cc
    ${TOP_DIR}/src/runtime/core/src/launch/label_common.cc
    ${TOP_DIR}/src/runtime/core/src/launch/label_stars.cc
    ${TOP_DIR}/src/runtime/core/src/launch/memcpy_stars.cc
    ${TOP_DIR}/src/runtime/core/src/launch/aicpu_stars.cc
    ${TOP_DIR}/src/runtime/core/src/launch/dvpp_stars.cc
    ${TOP_DIR}/src/runtime/core/src/device/aicpu_err_msg.cc
    ${TOP_DIR}/src/runtime/core/src/notify/notify.cc
    ${TOP_DIR}/src/runtime/core/src/event/event.cc
    ${TOP_DIR}/src/runtime/core/src/event/ipc_event.cc
    ${TOP_DIR}/src/runtime/core/src/engine/logger.cc
    ${TOP_DIR}/src/runtime/core/src/runtime.cc
    ${TOP_DIR}/src/runtime/core/src/device/ini_parse_utils.cc
    ${TOP_DIR}/src/runtime/core/src/memory/mem_type.cc
    ${TOP_DIR}/src/runtime/core/src/plugin_manage/runtime_keeper.cc
    ${TOP_DIR}/src/runtime/core/src/plugin_manage/v200/plugin_old_arch.cc
    ${TOP_DIR}/src/runtime/core/src/utils/capability.cc
    ${TOP_DIR}/src/runtime/core/src/task/ctrl_res_pool.cpp
    ${TOP_DIR}/src/runtime/core/src/utils/osal.cc
    ${TOP_DIR}/src/runtime/core/src/engine/hwts/scheduler.cc
    ${TOP_DIR}/src/runtime/core/src/profiler/profiler.cc
    ${TOP_DIR}/src/runtime/core/src/dfx/atrace_log.cc
    ${TOP_DIR}/src/runtime/core/src/dfx/fp16_t.cpp
    ${TOP_DIR}/src/runtime/core/src/dfx/hifloat.cpp
    ${TOP_DIR}/src/runtime/core/src/dfx/pctrace.cc
    ${TOP_DIR}/src/runtime/core/src/dfx/printf.cc
    ${TOP_DIR}/src/runtime/core/src/dfx/kernel_dfx_info.cc
    ${TOP_DIR}/src/runtime/core/src/utils/subscribe.cc
    ${TOP_DIR}/src/runtime/core/src/profiler/onlineprof.cc
    ${TOP_DIR}/src/runtime/core/src/device/device_error_proc.cc
    ${TOP_DIR}/src/runtime/core/src/device/v100/device_error_proc.cc
    ${TOP_DIR}/src/runtime/core/src/device/device_error_core_proc.cc
    ${TOP_DIR}/src/runtime/core/src/task/stars_cond_isa_helper.cc
    ${TOP_DIR}/src/runtime/core/src/common/thread_local_container.cc
    ${TOP_DIR}/src/runtime/core/src/common/inner_thread_local.cpp
    ${TOP_DIR}/src/runtime/core/src/device/device_msg_handler.cc
    ${TOP_DIR}/src/runtime/core/src/utils/aicpu_scheduler_agent.cc
    ${TOP_DIR}/src/runtime/core/src/task/host_task.cc
    ${TOP_DIR}/src/runtime/core/src/stream/dvpp_grp.cc
    ${TOP_DIR}/src/runtime/api/inner.cc
    ${TOP_DIR}/src/runtime/core/src/task/task_to_sqe.cc
    ${TOP_DIR}/src/runtime/driver/npu_driver_tiny.cpp
    ${TOP_DIR}/src/runtime/core/src/engine/engine.cc
    ${TOP_DIR}/src/runtime/core/src/engine/hwts/package_rebuilder.cc
    ${TOP_DIR}/src/runtime/core/src/engine/stars/stars_engine.cc
    ${TOP_DIR}/src/runtime/core/src/engine/hwts/hwts_engine.cc
    ${TOP_DIR}/src/runtime/core/src/engine/hwts/async_hwts_engine.cc
    ${TOP_DIR}/src/runtime/core/src/engine/hwts/direct_hwts_engine.cc
    ${TOP_DIR}/src/runtime/core/src/engine/engine_factory.cc
    ${TOP_DIR}/src/runtime/core/src/engine/hwts/shm_cq.cc
    ${TOP_DIR}/src/runtime/core/src/api_impl/api_impl_creator.cc
    ${TOP_DIR}/src/runtime/core/src/api_impl/v100/api_impl_creator_c.cc
    ${runtimeut_src_common_list}
    ${runtimeut_platform_list}
    ${TOP_DIR}/src/runtime/feature/xpu/api_decorator_xpu.cc
    ${TOP_DIR}/src/runtime/core/src/api_impl/v100/api_impl_v100_xpu.cc
    ${TOP_DIR}/src/runtime/feature/xpu/api_error_xpu.cc
    ${TOP_DIR}/src/runtime/core/src/api_impl/api_impl_creator.cc
 	${TOP_DIR}/src/runtime/core/src/api_impl/v100/api_impl_creator_c.cc
    ${TOP_DIR}/src/runtime/core/src/kernel/json_parse.cc
    ${TOP_DIR}/src/runtime/core/src/kernel/program_common.cc
    ${TOP_DIR}/src/runtime/core/src/kernel/kernel_utils.cc
    ${TOP_DIR}/src/runtime/api/api_c_xpu.cc
    ${TOP_DIR}/src/runtime/core/src/runtime_v200/runtime_adapt.cc
    ${TOP_DIR}/src/runtime/feature/xpu/task_xpu.cc
    ${TOP_DIR}/src/runtime/feature/xpu/task_manager_xpu.cc
    ${TOP_DIR}/src/runtime/feature/xpu/xpu_kernel_task.cc
    ${TOP_DIR}/src/runtime/feature/xpu/task_xpu_recycle.cc
    ${TOP_DIR}/src/runtime/feature/xpu/xpu_context.cc
    ${TOP_DIR}/src/runtime/feature/xpu/stream_sqcq_manage_xpu.cc
    ${TOP_DIR}/src/runtime/core/src/task/task_res_manage/v200/task_res_da.cc
    ${TOP_DIR}/src/runtime/feature/xpu/stream_xpu.cc
    ${TOP_DIR}/src/runtime/feature/xpu/stream_xpu_c.cc
    ${TOP_DIR}/src/runtime/feature/xpu/xpu_device.cc
    ${TOP_DIR}/src/runtime/core/src/pool/h2h_copy_mgr.cc
    ${TOP_DIR}/src/runtime/driver/xpu_driver.cc
    ${TOP_DIR}/src/runtime/feature/xpu/arg_loader_xpu.cc
    ${TOP_DIR}/src/runtime/core/src/kernel/arg_loader/arg_manage_david.cc
    ${TOP_DIR}/src/runtime/feature/xpu/arg_manage_xpu.cc
    ${TOP_DIR}/src/runtime/feature/xpu/xpu_aicpu_c.cc
    ${TOP_DIR}/src/runtime/feature/xpu/program_plat.cc
    ${TOP_DIR}/src/runtime/core/src/kernel/json_parse.cc
    ${TOP_DIR}/src/runtime/feature/xpu/runtime_xpu_adapt.cc
    ${TOP_DIR}/src/tprt/c/tprt_api.cc
    ${TOP_DIR}/src/tprt/feature/src/tprt.cc
    ${TOP_DIR}/src/tprt/feature/src/tprt_cqhandle.cc
    ${TOP_DIR}/src/tprt/feature/src/tprt_device.cc
    ${TOP_DIR}/src/tprt/feature/src/tprt_log.cc
    ${TOP_DIR}/src/tprt/feature/src/tprt_sqhandle.cc
    ${TOP_DIR}/src/tprt/feature/src/tprt_worker.cc
    ${TOP_DIR}/src/tprt/feature/src/tprt_timer.cc
    ${TOP_DIR}/src/tprt/feature/src/tprt_profiling.cc
)
###################################################################################################
add_library(runtime_ut_910b_static_lib STATIC ${runtimeut_910b_src_list})

target_compile_definitions(runtime_ut_910b_static_lib PUBLIC
    TEMP_PERFORMANCE
    TEMP_PERFORMANCE_NOT_OUTPUT
)

target_include_directories(runtime_ut_910b_static_lib PRIVATE
    ${TOP_DIR}/src/tprt/inc/external
    ${TOP_DIR}/src/tprt/feature/inc
)

target_link_libraries(runtime_ut_910b_static_lib PRIVATE $<BUILD_INTERFACE:runtime_ut_910b_intf_pub>)
###################################################################################################
set(runtimeut_910b_stub_list
    ${TOP_DIR}/tests/ut/runtime/runtime/stub/atrace_stub.cc
    ${TOP_DIR}/tests/ut/runtime/runtime/stub/awatch_dog_stub.cc
    ${TOP_DIR}/tests/ut/runtime/runtime/stub/error_manager_stub.cc
    ${TOP_DIR}/tests/ut/runtime/runtime/stub/log_stub.cc
    ${TOP_DIR}/tests/ut/runtime/runtime/stub/prof_stub.cc
    ${TOP_DIR}/tests/ut/runtime/runtime/stub/platform_stub.cc
)

add_library(runtimeut_910b_stub_static_lib STATIC ${runtimeut_910b_stub_list})

target_link_libraries(runtimeut_910b_stub_static_lib PRIVATE $<BUILD_INTERFACE:runtime_ut_910b_intf_pub>)
##################################################################################################
add_library(runtime_ut_910b_intf_pub INTERFACE)

target_compile_definitions(runtime_ut_910b_intf_pub INTERFACE
    __RUNTIME_PRODUCT_DRV_MINI__
    _GLIBCXX_USE_CXX11_ABI=0
    RT_UT_TEST
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
    ${TOP_DIR}/src/runtime/core/inc/common
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
    ${TOP_DIR}/src/runtime/core/inc_c
    ${TOP_DIR}/src/runtime/core/inc/model
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
    ${TOP_DIR}/pkg_inc/aicpu_sched/common
    ${TOP_DIR}/tests/ut/runtime/runtime/stub/
    ${TOP_DIR}/tests/ut/runtime/runtime/test/common
    ${TOP_DIR}/include
    ${TOP_DIR}/pkg_inc/tsd
    ${TOP_DIR}/pkg_inc/trace
    ${TOP_DIR}/pkg_inc/watchdog
    ${TOP_DIR}/pkg_inc/profiling
    ${TOP_DIR}/abl/atrace/inc/awatchdog/
    ${TOP_DIR}/src/runtime/core/src/task/
    ${TOP_DIR}/pkg_inc
    ${TOP_DIR}/src/queue_schedule/dgwclient/inc
    ${TOP_DIR}/src/dfx/msprof/include/external/runtime/rts
    ${TOP_DIR}/src/inc
    ${TOP_DIR}/src/inc/external
    ${TOP_DIR}/src/inc/runtime
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

target_include_directories(runtime_ut_910b_intf_pub INTERFACE
    ${RUNTIME_TEST_INC_DIR}
)

target_compile_options(runtime_ut_910b_intf_pub INTERFACE
    -Wformat
    -Wall
    -Wextra
    -fno-access-control
    -fno-devirtualize
    -fno-inline-small-functions
    $<$<STREQUAL: ${CMAKE_SYSTEM_PROCESSOR}, aarch64>:-falign-functions=32>
)

target_link_libraries(runtime_ut_910b_intf_pub INTERFACE
    mmpa
    json
    GTest::gtest
    GTest::gtest_main
    c_sec
    -lrt
    -ldl
    -lpthread
    -lgcov
    $<BUILD_INTERFACE:intf_910b_llt_pub>
    $<BUILD_INTERFACE:mmpa_headers>
    $<BUILD_INTERFACE:c_sec_headers>
    $<BUILD_INTERFACE:msprof_headers>
    $<BUILD_INTERFACE:slog_headers>
    $<BUILD_INTERFACE:npu_runtime_headers>
)

target_link_options(runtime_ut_910b_intf_pub INTERFACE
    -Wl,--wrap=malloc,-lrt
    -rdynamic
)

add_library(intf_910b_llt_pub INTERFACE)

target_include_directories(intf_910b_llt_pub INTERFACE
)

target_compile_definitions(intf_910b_llt_pub INTERFACE
    CFG_BUILD_DEBUG
    _GLIBCXX_USE_CXX11_ABI=0
)

target_compile_options(intf_910b_llt_pub INTERFACE
    -g
    -w
    $<$<BOOL:${ENABLE_GCOV}>:-fprofile-arcs -ftest-coverage>
    $<$<BOOL:${ENABLE_ASAN}>:-fsanitize=address -fno-omit-frame-pointer -static-libasan -fsanitize=undefined -static-libubsan -fsanitize=leak -static-libtsan>
    -fPIC
    -pipe
)

target_link_options(intf_910b_llt_pub INTERFACE
    $<$<BOOL:${ENABLE_GCOV}>:-fprofile-arcs -ftest-coverage>
    $<$<BOOL:${ENABLE_ASAN}>:-fsanitize=address -static-libasan -fsanitize=undefined  -static-libubsan -fsanitize=leak -static-libtsan>
)

target_link_directories(intf_910b_llt_pub INTERFACE
)

target_link_libraries(intf_910b_llt_pub INTERFACE
    GTest::gtest
    ${CANN_3RD_LIB_PATH}/mockcpp/lib/libmockcpp.a
    -lpthread
    $<$<BOOL:${ENABLE_GCOV}>:-lgcov>
)
###################################################################################################
add_executable(runtime_utest_task_910B
    ${runtime_raw_device_adpt_common_list}
    ${TOP_DIR}/src/runtime/driver/npu_driver.cc
    ${TOP_DIR}/src/runtime/driver/npu_driver_mem.cc
    ${TOP_DIR}/src/runtime/driver/npu_driver_queue.cc
    ${TOP_DIR}/src/runtime/driver/npu_driver_res.cc
    ${TOP_DIR}/src/runtime/driver/npu_driver_dcache_lock_opb.cpp
    ${TOP_DIR}/src/runtime/driver/npu_driver_standard_soc.cc
    ${TOP_DIR}/src/runtime/driver/v100/npu_driver.cc
    ${TOP_DIR}/src/runtime/core/src/kernel/v100/kernel.cc
    ${TOP_DIR}/src/runtime/core/src/task/v100/stub_task.cc
    stub/hal_stub.cc
    stub/rt_utest_api_common_defination.cc
    main.cc
    rt_utest_api_device_limit.cc
    rt_utest_api_stream_limit.cc
    rt_utest_api_test6.cc
    rt_utest_api_device.cc
    rt_utest_api_kernel.cc
    rt_utest_memory_type.cc
    rt_api_test.cc
    rt_utest_api_memory.cc
    rt_utest_api_mbuf_queue.cc
    rt_utest_api_impl.cc
    rt_utest_api_impl_spec.cc
    rt_utest_set_device_failure_mode.cc
    rt_utest_dcache_lock.cc
    rt_utest_capture_mode_update.cc
    rt_utest_capture_mode.cc
    rt_utest_customer_stack_size.cc
    rt_utest_ipc.cc
    rt_utest_task_res.cc
    rt_utest_task.cc
    rt_utest_task_stars.cc
)

target_compile_definitions(runtime_utest_task_910B PUBLIC
    TEMP_PERFORMANCE
    TEMP_PERFORMANCE_NOT_OUTPUT
)

target_link_libraries(runtime_utest_task_910B PRIVATE
    $<BUILD_INTERFACE:runtime_ut_910b_intf_pub>
    -Wl,--whole-archive
     runtime_ut_910b_static_lib
     runtimeut_910b_stub_static_lib
    -Wl,--no-whole-archive
)
###################################################################################################
add_executable(runtime_utest_api_910B
    ${runtime_raw_device_adpt_common_list}
    ${TOP_DIR}/src/runtime/driver/npu_driver.cc
    ${TOP_DIR}/src/runtime/driver/npu_driver_mem.cc
    ${TOP_DIR}/src/runtime/driver/npu_driver_queue.cc
    ${TOP_DIR}/src/runtime/driver/npu_driver_res.cc
    ${TOP_DIR}/src/runtime/driver/npu_driver_dcache_lock_opb.cpp
    ${TOP_DIR}/src/runtime/driver/npu_driver_standard_soc.cc
    ${TOP_DIR}/src/runtime/driver/v100/npu_driver.cc
    ${TOP_DIR}/src/runtime/core/src/kernel/v100/kernel.cc
    ${TOP_DIR}/src/runtime/core/src/task/v100/stub_task.cc
    stub/hal_stub.cc
    stub/rt_utest_api_common_defination.cc
    main.cc
    rt_utest_api_cloudv2.cc
    rt_utest_api.cc
    rt_utest_api_test.cc
    rt_error_code_test.cc
    rt_utest_agent.cc
    rt_utest_aicpu_scheduler_agent.cc
    rt_utest_arg_loader.cc
    rt_utest_config.cc
    rt_utest_atrace_log.cc
    rt_utest_api_context.cc
    rt_utest_stars_engine.cc
    rt_utest_event_cloud_v2.cc
    rt_utest_FftsPlustTaskLaunch.cc
    rt_utest_stream.cc
    rt_utest_elf.cc
    rt_utest_npu_driver.cc
    rt_utest_device.cc
    rt_utest_aicpu_err_msg.cc
    rt_utest_aicpu_kernel_launch.cc
    rt_utest_runtime.cc
    rt_utest_snapshot.cc
    rt_utest_ipc_event.cc
    rt_utest_macro_value.cc
    rt_utest_dfx_api.cc
    rt_utest_direct_hwts_engine.cc
    rt_utest_driver.cc
    rt_utest_engine.cc
    rt_utest_context.cc
    rt_utest_api_dfx.cc
    rt_utest_kernel.cc
    rt_utest_kernellaunch.cc
    rt_utest_osal.cc
    rt_utest_pctrace.cc
    rt_utest_printf.cc
    rt_utest_profileapi.cc
    rt_utest_profiler.cc
    rt_utest_api_others.cc
    rt_utest_api_910b.cc
    rt_utest_uvm.cc
    rt_utest_api_soma.cc
    rt_utest_soma.cc
    rt_utest_api_impl_task_source.cc
)

target_include_directories(runtime_utest_api_910B PRIVATE
    ${TOP_DIR}/tests/ut/runtime/runtime
)

target_compile_definitions(runtime_utest_api_910B PUBLIC
    TEMP_PERFORMANCE
    TEMP_PERFORMANCE_NOT_OUTPUT
)

target_link_libraries(runtime_utest_api_910B PRIVATE
    $<BUILD_INTERFACE:runtime_ut_910b_intf_pub>
    -Wl,--whole-archive
     runtime_ut_910b_static_lib
     runtimeut_910b_stub_static_lib
    -Wl,--no-whole-archive
)
###################################################################################################
add_executable(runtime_utest_xpu_910B
    ${runtime_raw_device_adpt_common_list}
    ${TOP_DIR}/src/runtime/driver/npu_driver.cc
    ${TOP_DIR}/src/runtime/driver/npu_driver_mem.cc
    ${TOP_DIR}/src/runtime/driver/npu_driver_queue.cc
    ${TOP_DIR}/src/runtime/driver/npu_driver_res.cc
    ${TOP_DIR}/src/runtime/driver/npu_driver_dcache_lock_opb.cpp
    ${TOP_DIR}/src/runtime/driver/npu_driver_standard_soc.cc
    ${TOP_DIR}/src/runtime/driver/v100/npu_driver.cc
    ${TOP_DIR}/src/runtime/core/src/kernel/v100/kernel.cc
    ${TOP_DIR}/src/runtime/core/src/task/v100/stub_task.cc
    stub/hal_stub.cc
    stub/xpu_stub.cc
    stub/rt_utest_api_common_defination.cc
    main.cc
    rt_utest_xpu_api_impl.cc
    rt_utest_xpu_aicpu_c_stub.cc
    rt_utest_task_proc_func_register_xpu.cc
)

target_include_directories(runtime_utest_xpu_910B PRIVATE
    ${TOP_DIR}/tests/ut/runtime/runtime
    ${TOP_DIR}/src/tprt/inc/external
    ${TOP_DIR}/src/tprt/feature/inc
    stub
)

target_compile_definitions(runtime_utest_xpu_910B PUBLIC
    TEMP_PERFORMANCE
    TEMP_PERFORMANCE_NOT_OUTPUT
)

target_link_libraries(runtime_utest_xpu_910B PRIVATE
    $<BUILD_INTERFACE:runtime_ut_910b_intf_pub>
    -Wl,--whole-archive
     runtime_ut_910b_static_lib
     runtimeut_910b_stub_static_lib
    -Wl,--no-whole-archive
)
