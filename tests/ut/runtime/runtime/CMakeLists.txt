# -----------------------------------------------------------------------------------------------------------
# Copyright (c) 2025 Huawei Technologies Co., Ltd.
# This program is free software, you can redistribute it and/or modify it under the terms and conditions of
# CANN Open Software License Agreement Version 2.0 (the "License").
# Please refer to the License for details. You may not use this file except in compliance with the License.
# THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
# INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
# See LICENSE in the root of the software repository for the full text of the License.
# -----------------------------------------------------------------------------------------------------------
add_subdirectory(test)
set(BASE_DIR ${CMAKE_CURRENT_SOURCE_DIR})
include_directories(${OPEN_SOURCE_DIR}/boost-1.87.0)

set(runtimeut_common_src_task_list
    ${TOP_DIR}/src/runtime/feature/src/task/task.cc
    ${TOP_DIR}/src/runtime/feature/src/task/task_execute_time.cc
    ${TOP_DIR}/src/runtime/feature/src/task/task_res_manage/task_res.cc
    ${TOP_DIR}/src/runtime/feature/src/task/task_submit/v100/task_submit.cc
    ${TOP_DIR}/src/runtime/feature/src/task/task_info/task_manager.cc
    ${TOP_DIR}/src/runtime/feature/src/task/task_info/task_info.cc
    ${TOP_DIR}/src/runtime/feature/src/task/task_info/ffts_task.cc
    ${TOP_DIR}/src/runtime/feature/src/task/task_info/model/model_execute_task_info.cc
    ${TOP_DIR}/src/runtime/feature/src/task/task_info/davinci_kernel_task.cc
    ${TOP_DIR}/src/runtime/feature/src/task/task_info/event_task.cc
    ${TOP_DIR}/src/runtime/feature/src/task/task_info/memory_task.cc
    ${TOP_DIR}/src/runtime/feature/src/task/task_info/rdma_task.cc
    ${TOP_DIR}/src/runtime/feature/src/task/task_info/reduce_task.cc
    ${TOP_DIR}/src/runtime/feature/src/task/task_info/cond_op/cond_op_label_task.cc
    ${TOP_DIR}/src/runtime/feature/src/task/task_info/cond_op/cond_op_stream_task.cc
    ${TOP_DIR}/src/runtime/feature/src/task/task_info/profiling_task.cc
    ${TOP_DIR}/src/runtime/feature/src/task/task_info/dump_task.cc
    ${TOP_DIR}/src/runtime/feature/src/task/task_info/stream/stream_task.cc
    ${TOP_DIR}/src/runtime/feature/src/task/task_info/davinci_multiple_task.cc
    ${TOP_DIR}/src/runtime/feature/src/task/task_info/stars_common_task.cc
    ${TOP_DIR}/src/runtime/feature/src/task/task_info/random_num_task.cc
    ${TOP_DIR}/src/runtime/feature/src/task/task_info/barrier_task.cc
    ${TOP_DIR}/src/runtime/feature/src/task/task_info/cmo_task.cc
    ${TOP_DIR}/src/runtime/feature/src/task/task_info/model/model_maintaince_task.cc
    ${TOP_DIR}/src/runtime/feature/src/task/task_info/notify_record_task.cc
    ${TOP_DIR}/src/runtime/feature/src/task/task_info/timeout_set_task.cc
    ${TOP_DIR}/src/runtime/feature/src/task/task_info/ringbuffer_maintain_task.cc
    ${TOP_DIR}/src/runtime/feature/src/task/task_info/model/model_update_task.cc
    ${TOP_DIR}/src/runtime/feature/src/task/task_info/end_graph_task.cc
    ${TOP_DIR}/src/runtime/feature/src/task/task_info/model/model_to_aicpu_task.cc
    ${TOP_DIR}/src/runtime/feature/src/task/task_info/maintenance_task.cc
)

set(runtimeut_src_task_list
    ${runtimeut_common_src_task_list}
    ${TOP_DIR}/src/runtime/feature/src/task/v100/davinci_task.cc
    ${TOP_DIR}/src/runtime/feature/src/task/v100/task_proc_func_register.cc
    ${TOP_DIR}/src/runtime/feature/src/task/v100/task_checker.cc
    ${TOP_DIR}/src/runtime/feature/src/task/v100/memory_task.cc
)

set(runtimeut_david_series_common_src_task_list
    ${runtimeut_common_src_task_list}
    ${TOP_DIR}/src/runtime/feature/src/task/task_submit/v200/task_david.cc
    ${TOP_DIR}/src/runtime/feature/src/task/task_res_manage/v200/task_res_da.cc
    ${TOP_DIR}/src/runtime/feature/src/task/task_recycle/v200/task_recycle.cc
    ${TOP_DIR}/src/runtime/feature/src/task/task_recycle/v200/task_recycle_common_base.cc
    ${TOP_DIR}/src/runtime/feature/src/task/task_recycle/v200/task_recycle_cqrpt_base.cc
    ${TOP_DIR}/src/runtime/feature/src/task/task_recycle/v200/task_recycle_dvpp.cc
    ${TOP_DIR}/src/runtime/feature/src/task/task_recycle/v200/task_recycle_send_sync.cc
    ${TOP_DIR}/src/runtime/feature/src/task/task_info/task_manager_david.cc
    ${TOP_DIR}/src/runtime/feature/src/task/task_info/david_event_task.cc
    ${TOP_DIR}/src/runtime/feature/src/task/task_info/ubdma_task_david.cc
    ${TOP_DIR}/src/runtime/feature/src/task/task_info/cond_op/cond_op_task_david.cc
    ${TOP_DIR}/src/runtime/feature/src/task/task_info/model/model_update_task_david.cc
    ${TOP_DIR}/src/runtime/feature/src/task/task_info/notify/notify_task_david.cc
    ${TOP_DIR}/src/runtime/feature/src/kernel/arg_loader/arg_loader_ub.cc
    ${TOP_DIR}/src/runtime/feature/src/kernel/arg_loader/arg_manage_ub.cc
    ${TOP_DIR}/src/runtime/feature/src/kernel/arg_loader/arg_manage_pcie.cc
    ${TOP_DIR}/src/runtime/feature/src/kernel/arg_loader/arg_manage_david.cc
    ${TOP_DIR}/src/runtime/feature/src/notify/count_notify.cc
    ${TOP_DIR}/src/runtime/feature/src/event/event_david.cc
    ${TOP_DIR}/src/runtime/feature/src/task/v200_base/davinci_task.cc
    ${TOP_DIR}/src/runtime/feature/src/task/v200_base/davinci_task_launch_config.cc
    ${TOP_DIR}/src/runtime/feature/src/task/v200_base/memcpy_sqe_common_proc.cc
    ${TOP_DIR}/src/runtime/feature/src/task/v200_base/aicpu_sqe_common_proc.cc
    ${TOP_DIR}/src/runtime/feature/src/task/v200_base/memory_task.cc
    ${TOP_DIR}/src/runtime/feature/src/task/v200_base/stars_david.cc
)

set(runtimeut_david_src_task_list
    ${runtimeut_david_series_common_src_task_list}
    # david & solomon 专用差异化文件
    ${TOP_DIR}/src/runtime/feature/src/task/v200/task_proc_func_register.cc
    ${TOP_DIR}/src/runtime/feature/src/task/v200/memcpy_task_to_sqe.cc
    ${TOP_DIR}/src/runtime/feature/src/task/v200/aicpu_task_to_sqe.cc
    ${TOP_DIR}/src/runtime/feature/src/task/v200/task_checker.cc
)

set(runtimeut_src_api_list
    ${TOP_DIR}/src/runtime/feature/src/api/api_c.cc
    ${TOP_DIR}/src/runtime/feature/src/api/api_c_standard_soc.cc
    ${TOP_DIR}/src/runtime/feature/src/api/api_david.cc
    ${TOP_DIR}/src/runtime/feature/src/api/api_preload_task.cc
    ${TOP_DIR}/src/runtime/feature/src/api/api_c_context.cc
    ${TOP_DIR}/src/runtime/feature/src/api/api_c_device.cc
    ${TOP_DIR}/src/runtime/feature/src/api/api_c_kernel.cc
    ${TOP_DIR}/src/runtime/feature/src/api/api_c_memory.cc
    ${TOP_DIR}/src/runtime/feature/src/api/api_c_stream.cc
    ${TOP_DIR}/src/runtime/feature/src/api/api_c_model.cc
    ${TOP_DIR}/src/runtime/feature/src/api/api_c_event.cc
    ${TOP_DIR}/src/runtime/feature/src/api/api_c_mbuf.cc
    ${TOP_DIR}/src/runtime/feature/src/api/inner.cc
    ${TOP_DIR}/src/runtime/feature/src/api/api_global_err.cc
    ${TOP_DIR}/src/runtime/feature/src/api/api_c_soc.cc
    ${TOP_DIR}/src/runtime/feature/src/api/api_c_dqs.cc
    ${TOP_DIR}/src/runtime/feature/src/api/api_c_snapshot.cc
)

set(runtimeut_src_david_series_common_c_list
    ${TOP_DIR}/src/runtime/feature/src/launch/aix_c.cc
    ${TOP_DIR}/src/runtime/feature/src/launch/aicpu_c.cc
    ${TOP_DIR}/src/runtime/feature/src/launch/dvpp_c.cc
    ${TOP_DIR}/src/runtime/feature/src/launch/fusion_c.cc

    ${TOP_DIR}/src/runtime/feature/src/stream/stream_c.cc
    ${TOP_DIR}/src/runtime/feature/src/dfx/coredump_c.cc
    ${TOP_DIR}/src/runtime/feature/src/dfx/fast_recover.cc
    ${TOP_DIR}/src/runtime/feature/src/launch/memcpy_c.cc
    ${TOP_DIR}/src/runtime/feature/src/device/v200_base/device_error_proc_c.cc
    ${TOP_DIR}/src/runtime/feature/src/launch/cond_c.cc
    ${TOP_DIR}/src/runtime/feature/src/notify/notify_c.cc
    ${TOP_DIR}/src/runtime/feature/src/event/event_c.cc
    ${TOP_DIR}/src/runtime/feature/src/model/model_c.cc
    ${TOP_DIR}/src/runtime/feature/src/profiler/profiler_c.cc
)

set(runtimeut_src_david_c_list
    ${runtimeut_src_david_series_common_c_list}
)

set(runtimeut_src_v201_c_list
    ${runtimeut_src_david_series_common_c_list}
)

set(runtimeut_src_common_list
    ${TOP_DIR}/src/runtime/feature/src/common/error_code.cc
    ${TOP_DIR}/src/runtime/feature/src/common/thread_local_container.cc
    ${TOP_DIR}/src/runtime/feature/src/common/utils.cc
    ${TOP_DIR}/src/runtime/feature/src/common/heterogenous.cc
    ${TOP_DIR}/src/runtime/feature/src/common/soc_info.cc
    ${TOP_DIR}/src/runtime/feature/src/common/context_data_manage.cc
    ${TOP_DIR}/src/runtime/feature/src/common/task_fail_callback_data_manager.cc
    ${TOP_DIR}/src/runtime/feature/src/common/performance_record.cc
    ${TOP_DIR}/src/runtime/feature/src/common/profiling_agent.cc
    ${TOP_DIR}/src/runtime/feature/src/common/errcode_manage.cc
    ${TOP_DIR}/src/runtime/feature/src/common/error_message_manage.cc
    ${TOP_DIR}/src/runtime/feature/src/common/prof_ctrl_callback_manager.cc
    ${TOP_DIR}/src/runtime/feature/src/common/rt_log.cc
    ${TOP_DIR}/src/runtime/feature/src/common/dev_info_manage.cc
    ${TOP_DIR}/src/runtime/feature/src/common/global_state_manager.cc
    ${TOP_DIR}/src/runtime/feature/src/common/register_memory.cc
)

set(runtimeut_platform_list
    ${TOP_DIR}/src/runtime/feature/platform/610_lite/dev_info_reg.cc
    ${TOP_DIR}/src/runtime/feature/platform/950/dev_info_reg.cc
    ${TOP_DIR}/src/runtime/feature/platform/910_B_93/dev_info_reg.cc
    ${TOP_DIR}/src/runtime/feature/platform/as31xm1/dev_info_reg.cc
    ${TOP_DIR}/src/runtime/feature/platform/bs9sx1a/dev_info_reg.cc
    ${TOP_DIR}/src/runtime/feature/platform/cloud/dev_info_reg.cc
    ${TOP_DIR}/src/runtime/feature/platform/dc/dev_info_reg.cc
    ${TOP_DIR}/src/runtime/feature/platform/mc62cm12a/dev_info_reg.cc
    ${TOP_DIR}/src/runtime/feature/platform/adc/dev_info_reg.cc
    ${TOP_DIR}/src/runtime/feature/platform/mini/dev_info_reg.cc
    ${TOP_DIR}/src/runtime/feature/platform/mini_v3/dev_info_reg.cc
    ${TOP_DIR}/src/runtime/feature/platform/nano/dev_info_reg.cc
    ${TOP_DIR}/src/runtime/feature/platform/tiny/dev_info_reg.cc
    ${TOP_DIR}/src/runtime/feature/platform/910_96/dev_info_reg.cc
    ${TOP_DIR}/src/runtime/feature/platform/xpu/dev_info_reg.cc
    ${TOP_DIR}/src/runtime/feature/platform/kirinx90/dev_info_reg.cc
    ${TOP_DIR}/src/runtime/feature/platform/kirin9030/dev_info_reg.cc
    ${TOP_DIR}/src/runtime/feature/platform/610_lite/dev_info_proc_func.cc
    ${TOP_DIR}/src/runtime/feature/platform/950/dev_info_proc_func.cc
    ${TOP_DIR}/src/runtime/feature/platform/910_B_93/dev_info_proc_func.cc
    ${TOP_DIR}/src/runtime/feature/platform/as31xm1/dev_info_proc_func.cc
    ${TOP_DIR}/src/runtime/feature/platform/cloud/dev_info_proc_func.cc
    ${TOP_DIR}/src/runtime/feature/platform/dc/dev_info_proc_func.cc
    ${TOP_DIR}/src/runtime/feature/platform/mc62cm12a/dev_info_proc_func.cc
    ${TOP_DIR}/src/runtime/feature/platform/adc/dev_info_proc_func.cc
    ${TOP_DIR}/src/runtime/feature/platform/mini/dev_info_proc_func.cc
    ${TOP_DIR}/src/runtime/feature/platform/mini_v3/dev_info_proc_func.cc
    ${TOP_DIR}/src/runtime/feature/platform/tiny/dev_info_proc_func.cc
    ${TOP_DIR}/src/runtime/feature/platform/910_96/dev_info_proc_func.cc
)

set(runtimeut_src_context_list
    ${TOP_DIR}/src/runtime/feature/src/context/context.cc
    ${TOP_DIR}/src/runtime/feature/src/context/context_standard_soc.cc
    ${TOP_DIR}/src/runtime/feature/src/context/context_manage.cc
    ${TOP_DIR}/src/runtime/feature/src/context/context_protect.cc
)

set(runtimeut_common_src_stream_list
    ${TOP_DIR}/src/runtime/feature/src/stream/stream_sqcq_manage.cc
    ${TOP_DIR}/src/runtime/feature/src/stream/engine_stream_observer.cc
    ${TOP_DIR}/src/runtime/feature/src/stream/stream.cc
    ${TOP_DIR}/src/runtime/feature/src/stream/ctrl_stream.cc
    ${TOP_DIR}/src/runtime/feature/src/stream/coprocessor_stream.cc
    ${TOP_DIR}/src/runtime/feature/src/stream/tsch_stream.cc
    ${TOP_DIR}/src/runtime/feature/src/stream/stream_factory.cc
)

set(runtimeut_src_stream_list
    ${runtimeut_common_src_stream_list}

    ${TOP_DIR}/src/runtime/feature/src/stream/v100/stream_creator_c.cc
)

set(runtimeut_david_src_stream_list
    ${runtimeut_common_src_stream_list}

    ${TOP_DIR}/src/runtime/feature/src/stream/stream_david.cc
    ${TOP_DIR}/src/runtime/feature/src/stream/v200/stream_creator_c.cc
)

set(runtimeut_src_profile_list
    ${TOP_DIR}/src/runtime/feature/src/profiler/profiler.cc
    ${TOP_DIR}/src/runtime/feature/src/profiler/api_profile_decorator.cc
    ${TOP_DIR}/src/runtime/feature/src/profiler/api_profile_log_decorator.cc
    ${TOP_DIR}/src/runtime/feature/src/profiler/api_profile_decorator_standard_soc.cc
    ${TOP_DIR}/src/runtime/feature/src/profiler/api_profile_log_decoratoc_standard_soc.cc
    ${TOP_DIR}/src/runtime/feature/src/profiler/prof_map_ge_model_device.cc
    ${TOP_DIR}/src/runtime/feature/src/profiler/profile_log_record.cc
    ${TOP_DIR}/src/runtime/feature/src/profiler/npu_driver_record.cc
)

set(runtime_src_arg_loader_list
    ${TOP_DIR}/src/runtime/feature/src/kernel/arg_loader/uma_arg_loader.cc
    ${TOP_DIR}/src/runtime/feature/src/pool/memory_list.cc
    ${TOP_DIR}/src/runtime/feature/src/pool/memory_pool.cc
    ${TOP_DIR}/src/runtime/feature/src/pool/memory_pool_manager.cc
)

set(runtimeut_src_pool_list
    ${TOP_DIR}/src/runtime/feature/src/pool/bitmap.cc
    ${TOP_DIR}/src/runtime/feature/src/pool/buffer_allocator.cc
    ${TOP_DIR}/src/runtime/feature/src/pool/task_allocator.cc
    ${TOP_DIR}/src/runtime/feature/src/pool/spm_pool.cc
    ${TOP_DIR}/src/runtime/feature/src/pool/h2d_copy_mgr.cc
    ${TOP_DIR}/src/runtime/feature/src/pool/event_pool.cc
    ${TOP_DIR}/src/runtime/feature/src/pool/event_expanding.cc
)

set(runtimeut_src_ttlv_list
    ${TOP_DIR}/src/runtime/feature/src/ttlv/ttlv_decoder_utils.cc
    ${TOP_DIR}/src/runtime/feature/src/ttlv/ttlv.cc
    ${TOP_DIR}/src/runtime/feature/src/ttlv/ttlv_word_decoder.cc
    ${TOP_DIR}/src/runtime/feature/src/ttlv/ttlv_sentence_decoder.cc
    ${TOP_DIR}/src/runtime/feature/src/ttlv/ttlv_paragraph_decoder.cc
)

set(runtimeut_src_callback_list
    ${TOP_DIR}/src/runtime/feature/src/device/device_state_callback_manager.cc
    ${TOP_DIR}/src/runtime/feature/src/task/task_fail_callback_manager.cc
    ${TOP_DIR}/src/runtime/feature/src/stream/stream_state_callback_manager.cc
)

set(runtimeut_src_tiny_exclude_list
    ${TOP_DIR}/src/runtime/feature/src/api/api_c_dqs.cc
    ${TOP_DIR}/src/runtime/feature/src/api/api_c_standard_soc.cc
    ${TOP_DIR}/src/runtime/feature/src/api/api_david.cc
    ${TOP_DIR}/src/runtime/feature/src/api/api_preload_task.cc
    ${TOP_DIR}/src/runtime/feature/src/api/api_c_snapshot.cc
    ${TOP_DIR}/src/runtime/feature/src/api_impl/api_error_standard_soc.cc
    ${TOP_DIR}/src/runtime/feature/src/api_impl/api_decorator_xpu.cc
    ${TOP_DIR}/src/runtime/feature/src/api_impl/api_impl_standard_soc.cc
    ${TOP_DIR}/src/runtime/feature/src/api_impl/api_impl_david.cc
    ${TOP_DIR}/src/runtime/feature/src/api_impl/api_error_xpu.cc
    ${TOP_DIR}/src/runtime/feature/src/context/context_standard_soc.cc
    ${TOP_DIR}/src/runtime/feature/src/drv/npu_driver_standard_soc.cc
    ${TOP_DIR}/src/runtime/feature/src/engine/hwts/direct_hwts_engine.cc
    ${TOP_DIR}/src/runtime/feature/src/engine/hwts/hwts_engine.cc
    ${TOP_DIR}/src/runtime/feature/src/engine/hwts/async_hwts_engine.cc
    ${TOP_DIR}/src/runtime/feature/src/engine/hwts/shm_cq.cc
    ${TOP_DIR}/src/runtime/feature/src/engine/engine_factory.cc
    ${TOP_DIR}/src/runtime/feature/src/kernel/binary_loader.cc
    ${TOP_DIR}/src/runtime/feature/src/dfx/fp16_t.cpp
    ${TOP_DIR}/src/runtime/feature/src/dfx/hifloat.cpp
    ${TOP_DIR}/src/runtime/feature/src/dfx/printf.cc
    ${TOP_DIR}/src/runtime/feature/src/notify/count_notify.cc
    ${TOP_DIR}/src/runtime/feature/src/profiler/api_profile_decorator_standard_soc.cc
    ${TOP_DIR}/src/runtime/feature/src/profiler/api_profile_log_decoratoc_standard_soc.cc
    ${TOP_DIR}/src/runtime/feature/src/task/task_to_sqe.cc
    ${TOP_DIR}/src/runtime/feature/src/task/cond_op/cond_op_task_david.cc
    ${TOP_DIR}/src/runtime/feature/src/task/task_info/rdma_task.cc
    ${TOP_DIR}/src/runtime/feature/src/task/task_info/ffts_task.cc
    ${TOP_DIR}/src/runtime/feature/src/task/task_info/ubdma_task_david.cc
    ${TOP_DIR}/src/runtime/feature/src/task/task_info/model/model_update_task_david.cc
    ${TOP_DIR}/src/runtime/feature/src/task/task_info/notify/notify_task_david.cc
    ${TOP_DIR}/src/runtime/feature/src/task/v200_base/stars_david.cc
    ${TOP_DIR}/src/runtime/feature/src/task/v200/memcpy_task_to_sqe.cc
    ${TOP_DIR}/src/runtime/feature/src/task/v200/aicpu_task_to_sqe.cc
    ${TOP_DIR}/src/runtime/feature/src/task/v200/src/task/v200/task_proc_func_register.cc
    ${TOP_DIR}/src/runtime/feature/src/event/ipc_event.cc
    ${TOP_DIR}/src/runtime/feature/src/pool/event_pool.cc
    ${TOP_DIR}/src/runtime/feature/src/pool/event_expanding.cc
)

set(runtimeut_src_tiny_include_list
    ${TOP_DIR}/src/runtime/feature/src/api/api_c_tiny_stub.cc
    ${TOP_DIR}/src/runtime/feature/src/api_impl/api_error_tiny_stub.cc
    ${TOP_DIR}/src/runtime/feature/src/api_impl/api_impl_tiny_stub.cc
    ${TOP_DIR}/src/runtime/feature/src/api_impl/v100/api_impl_v100.cc
    ${TOP_DIR}/src/runtime/feature/src/context/context_tiny_stub.cc
    ${TOP_DIR}/src/runtime/feature/src/dfx/printf_tiny_stub.cc
    ${TOP_DIR}/src/runtime/feature/src/drv/npu_driver_tiny_stub.cc
    ${TOP_DIR}/src/runtime/feature/src/engine/engine_factory_tiny_stub.cc
    ${TOP_DIR}/src/runtime/feature/src/kernel/binary_loader_tiny_stub.cc
    ${TOP_DIR}/src/runtime/feature/src/kernel/program_common.cc
    ${TOP_DIR}/src/runtime/feature/src/profiler/api_profile_log_decoratoc_tiny_stub.cc
    ${TOP_DIR}/src/runtime/feature/src/profiler/api_profile_decorator_tiny_stub.cc
    ${TOP_DIR}/src/runtime/feature/src/task/tiny/rdma_task_tiny_stub.cc
    ${TOP_DIR}/src/runtime/feature/src/task/tiny/ffts_task_tiny_stub.cc
    ${TOP_DIR}/src/runtime/feature/src/task/tiny/task_tiny_stub.cc
    ${TOP_DIR}/src/runtime/feature/src/pool/event_pool_tiny_stub.cc
    ${TOP_DIR}/src/runtime/feature/src/event/ipc_event_tiny_stub.cc
    ${TOP_DIR}/src/runtime/feature/src/pool/event_expanding_tiny_stub.cc
)

set(runtime_raw_device_adpt_common_list
    ${TOP_DIR}/src/runtime/feature/src/device/raw_device_adpt_comm.cc
)
set(runtime_raw_device_adpt_david_list
    ${TOP_DIR}/src/runtime/feature/src/device/raw_device_adpt_david.cc
    ${TOP_DIR}/src/runtime/feature/src/drv/npu_driver_dcache_lock_david.cpp
)

set(runtimeut_src_list
    ${runtimeut_src_task_list}
    ${runtimeut_src_api_list}
    ${runtimeut_src_context_list}
    ${runtimeut_src_stream_list}
    ${runtimeut_src_profile_list}
    ${runtime_src_arg_loader_list}
    ${runtimeut_src_pool_list}
    ${runtimeut_src_ttlv_list}
    ${runtimeut_src_callback_list}
    ${runtime_xpu_src}
    ${TOP_DIR}/src/runtime/feature/src/api/api.cc
    ${TOP_DIR}/src/runtime/feature/src/api_impl/api_decorator_xpu.cc
    ${TOP_DIR}/src/runtime/feature/src/api_impl/api_decorator.cc
    ${TOP_DIR}/src/runtime/feature/src/api_impl/v100/api_impl_v100.cc
    ${TOP_DIR}/src/runtime/feature/src/api_impl/api_impl.cc
    ${TOP_DIR}/src/runtime/feature/src/api_impl/api_impl_mbuf.cc
    ${TOP_DIR}/src/runtime/feature/src/api_impl/api_impl_standard_soc.cc
    ${TOP_DIR}/src/runtime/feature/src/api_impl/api_error_xpu.cc
    ${TOP_DIR}/src/runtime/feature/src/api_impl/api_error.cc
    ${TOP_DIR}/src/runtime/feature/src/api_impl/api_error_standard_soc.cc
    ${TOP_DIR}/src/runtime/feature/src/api_impl/api_impl_creator.cc
    ${TOP_DIR}/src/runtime/feature/src/api_impl/v100/api_impl_creator_c.cc
    ${TOP_DIR}/src/runtime/feature/src/config.cc
    ${TOP_DIR}/src/runtime/feature/src/context/context.cc
    ${TOP_DIR}/src/runtime/feature/src/context/context_standard_soc.cc
    ${TOP_DIR}/src/runtime/feature/src/device/device.cc
    ${TOP_DIR}/src/runtime/feature/src/device/raw_device.cc
    ${TOP_DIR}/src/runtime/feature/src/device/raw_device_res.cc
    ${TOP_DIR}/src/runtime/feature/src/device/device_snapshot.cc
    ${TOP_DIR}/src/runtime/feature/src/device/device_sq_cq_pool.cc
    ${TOP_DIR}/src/runtime/feature/src/device/sq_addr_memory_pool.cc
    ${TOP_DIR}/src/runtime/feature/src/device/ctrl_sq.cc
    ${TOP_DIR}/src/runtime/feature/src/device/ctrl_msg.cc
    ${TOP_DIR}/src/runtime/feature/src/drv/driver.cc
    ${TOP_DIR}/src/runtime/feature/src/drv/npu_driver_dcache_lock_common.cpp
    ${TOP_DIR}/src/runtime/feature/src/model/model.cc
    ${TOP_DIR}/src/runtime/feature/src/model/model_rebuild.cc
    ${TOP_DIR}/src/runtime/feature/src/model/capture_model.cc
    ${TOP_DIR}/src/runtime/feature/src/model/capture_model_utils.cc
    ${TOP_DIR}/src/runtime/feature/src/model/v100/capture_adapt.cc
    ${TOP_DIR}/src/runtime/feature/src/kernel/args/args_handle_allocator.cc
    ${TOP_DIR}/src/runtime/feature/src/kernel/args/para_convertor.cc
    ${TOP_DIR}/src/runtime/feature/src/kernel/binary_loader.cc
    ${TOP_DIR}/src/runtime/feature/src/kernel/v100/binary_loader_c.cc
    ${TOP_DIR}/src/runtime/feature/src/kernel/elf.cc
    ${TOP_DIR}/src/runtime/feature/src/kernel/json_parse.cc
    ${TOP_DIR}/src/runtime/feature/src/kernel/kernel.cc
    ${TOP_DIR}/src/runtime/feature/src/kernel/module.cc
    ${TOP_DIR}/src/runtime/feature/src/kernel/program_common.cc
    ${TOP_DIR}/src/runtime/feature/src/kernel/program.cc
    ${TOP_DIR}/src/runtime/feature/src/launch/label.cc
    ${TOP_DIR}/src/runtime/feature/src/device/aicpu_err_msg.cc
    ${TOP_DIR}/src/runtime/feature/src/notify/notify.cc
    ${TOP_DIR}/src/runtime/feature/src/event/event.cc
    ${TOP_DIR}/src/runtime/feature/src/event/ipc_event.cc
    ${TOP_DIR}/src/runtime/feature/src/engine/logger.cc
    ${TOP_DIR}/src/runtime/feature/src/runtime.cc
    ${TOP_DIR}/src/runtime/feature/src/memory/mem_type.cc
    ${TOP_DIR}/src/runtime/feature/src/plugin_manage/runtime_keeper.cc
    ${TOP_DIR}/src/runtime/feature/src/plugin_manage/v100/plugin_old_arch.cc
    ${TOP_DIR}/src/runtime/feature/src/utils/capability.cc
    ${TOP_DIR}/src/runtime/feature/src/task/ctrl_res_pool.cpp
    ${TOP_DIR}/src/runtime/feature/src/utils/osal.cc
    ${TOP_DIR}/src/runtime/feature/src/engine/hwts/scheduler.cc
    ${TOP_DIR}/src/runtime/feature/src/profiler/profiler.cc
    ${TOP_DIR}/src/runtime/feature/src/dfx/atrace_log.cc
    ${TOP_DIR}/src/runtime/feature/src/dfx/fp16_t.cpp
    ${TOP_DIR}/src/runtime/feature/src/dfx/hifloat.cpp
    ${TOP_DIR}/src/runtime/feature/src/dfx/pctrace.cc
    ${TOP_DIR}/src/runtime/feature/src/dfx/printf.cc
    ${TOP_DIR}/src/runtime/feature/src/utils/subscribe.cc
    ${TOP_DIR}/src/runtime/feature/src/profiler/onlineprof.cc
    ${TOP_DIR}/src/runtime/feature/src/device/device_error_proc.cc
    ${TOP_DIR}/src/runtime/feature/src/device/v100/device_error_proc.cc
    ${TOP_DIR}/src/runtime/feature/src/device/device_error_core_proc.cc
    ${TOP_DIR}/src/runtime/feature/src/task/stars_cond_isa_helper.cc
    ${TOP_DIR}/src/runtime/feature/src/common/thread_local_container.cc
    ${TOP_DIR}/src/runtime/feature/src/common/inner_thread_local.cpp
    ${TOP_DIR}/src/runtime/feature/src/device/device_msg_handler.cc
    ${TOP_DIR}/src/runtime/feature/src/utils/aicpu_scheduler_agent.cc
    ${TOP_DIR}/src/runtime/feature/src/task/host_task.cc
    ${TOP_DIR}/src/runtime/feature/src/stream/dvpp_grp.cc
    ${TOP_DIR}/src/runtime/feature/src/api/inner.cc
    ${TOP_DIR}/src/runtime/feature/src/task/task_to_sqe.cc
    ${TOP_DIR}/src/runtime/feature/src/drv/npu_driver_tiny.cpp
    ${TOP_DIR}/src/runtime/feature/src/engine/engine.cc
    ${TOP_DIR}/src/runtime/feature/src/engine/hwts/package_rebuilder.cc
    ${TOP_DIR}/src/runtime/feature/src/engine/stars/stars_engine.cc
    ${TOP_DIR}/src/runtime/feature/src/engine/hwts/hwts_engine.cc
    ${TOP_DIR}/src/runtime/feature/src/engine/hwts/async_hwts_engine.cc
    ${TOP_DIR}/src/runtime/feature/src/engine/hwts/direct_hwts_engine.cc
    ${TOP_DIR}/src/runtime/feature/src/engine/engine_factory.cc
    ${TOP_DIR}/src/runtime/feature/src/engine/hwts/shm_cq.cc
    ${TOP_DIR}/src/runtime/feature/src/runtime_v100/runtime_adapt.cc
    ${runtimeut_src_common_list}
    ${runtimeut_platform_list}
)

###################################################################################################
set(runtime_xpu_src
    ${TOP_DIR}/src/runtime/feature/src/api/api_c_xpu.cc
    ${TOP_DIR}/src/runtime/feature/src/kernel/json_parse.cc
    ${TOP_DIR}/src/runtime/feature/src/task/task_info/task_manager_xpu.cc
    ${TOP_DIR}/src/runtime/feature/src/stream/stream_xpu.cc
    ${TOP_DIR}/src/runtime/feature/inc_c/xpu_aicpu_c.hpp
    ${TOP_DIR}/src/runtime/feature/src/context/xpu_context.cc
    ${TOP_DIR}/src/runtime/feature/src/device/xpu_device.cc
    ${TOP_DIR}/src/runtime/feature/src/drv/xpu_driver.cc
    ${TOP_DIR}/src/runtime/feature/src/launch/xpu_aicpu_c.cc
    ${TOP_DIR}/src/runtime/feature/src/stream/stream_sqcq_manage_xpu.cc
    ${TOP_DIR}/src/runtime/feature/src/stream/stream_xpu.cc
    ${TOP_DIR}/src/runtime/feature/src/task/task_submit/xpu/task_xpu.cc
    ${TOP_DIR}/src/runtime/tprt/c/tprt_api.cc
    ${TOP_DIR}/src/runtime/tprt/feature/src/tprt.cc
    ${TOP_DIR}/src/runtime/tprt/feature/src/tprt_cqhandle.cc
    ${TOP_DIR}/src/runtime/tprt/feature/src/tprt_device.cc
    ${TOP_DIR}/src/runtime/tprt/feature/src/tprt_log.cc
    ${TOP_DIR}/src/runtime/tprt/feature/src/tprt_sqhandle.cc
    ${TOP_DIR}/src/runtime/tprt/feature/src/tprt_worker.cc
    ${TOP_DIR}/src/runtime/feature/src/task/task_res_manage/v200/task_res_da.cc
    ${TOP_DIR}/src/runtime/feature/src/task/task_recycle/xpu/task_xpu_recycle.cc
    ${TOP_DIR}/src/runtime/feature/src/kernel/arg_loader/arg_manage_david.cc
    ${TOP_DIR}/src/runtime/feature/src/kernel/arg_loader/arg_manage_xpu.cc
    ${TOP_DIR}/src/runtime/feature/src/pool/h2h_copy_mgr.cc
    ${TOP_DIR}/src/runtime/feature/src/kernel/arg_loader/arg_loader_xpu.cc
    ${TOP_DIR}/src/runtime/feature/src/stream/stream_xpu_c.cc
    ${TOP_DIR}/src/runtime/feature/src/task/task_info/xpu_kernel_task.cc
)

set(runtimeut_david_src_list
    ${runtimeut_david_src_task_list}
    ${runtimeut_src_api_list}
    ${runtimeut_src_context_list}
    ${runtimeut_david_src_stream_list}
    ${runtimeut_src_profile_list}
    ${runtime_src_arg_loader_list}
    ${runtimeut_src_pool_list}
    ${runtimeut_src_ttlv_list}
    ${runtimeut_src_callback_list}
    ${runtimeut_src_david_c_list}
    ${runtime_raw_device_adpt_david_list}
    ${runtime_xpu_src}
    ${TOP_DIR}/src/runtime/feature/src/api/api.cc
    ${TOP_DIR}/src/runtime/feature/src/api_impl/api_decorator_xpu.cc
    ${TOP_DIR}/src/runtime/feature/src/api_impl/api_decorator.cc
    ${TOP_DIR}/src/runtime/feature/src/api_impl/api_impl.cc
    ${TOP_DIR}/src/runtime/feature/src/api_impl/api_impl_mbuf.cc
    ${TOP_DIR}/src/runtime/feature/src/api_impl/api_impl_david.cc
    ${TOP_DIR}/src/runtime/feature/src/api_impl/api_impl_creator.cc
    ${TOP_DIR}/src/runtime/feature/src/api_impl/v200/api_impl_creator_c.cc
    ${TOP_DIR}/src/runtime/feature/src/api_impl/api_impl_standard_soc.cc
    ${TOP_DIR}/src/runtime/feature/src/api_impl/api_error_xpu.cc
    ${TOP_DIR}/src/runtime/feature/src/api_impl/api_error.cc
    ${TOP_DIR}/src/runtime/feature/src/api_impl/api_error_standard_soc.cc
    ${TOP_DIR}/src/runtime/feature/src/api_impl/v200/api_impl_v200.cc
    ${TOP_DIR}/src/runtime/feature/src/api_impl/v100/api_impl_v100.cc
    ${TOP_DIR}/src/runtime/feature/src/config.cc
    ${TOP_DIR}/src/runtime/feature/src/context/context.cc
    ${TOP_DIR}/src/runtime/feature/src/context/context_standard_soc.cc
    ${TOP_DIR}/src/runtime/feature/src/device/device.cc
    ${TOP_DIR}/src/runtime/feature/src/device/raw_device.cc
    ${TOP_DIR}/src/runtime/feature/src/device/raw_device_res.cc
    ${TOP_DIR}/src/runtime/feature/src/device/device_snapshot.cc
    ${TOP_DIR}/src/runtime/feature/src/device/device_sq_cq_pool.cc
    ${TOP_DIR}/src/runtime/feature/src/device/sq_addr_memory_pool.cc
    ${TOP_DIR}/src/runtime/feature/src/drv/driver.cc
    ${TOP_DIR}/src/runtime/feature/src/device/ctrl_sq.cc
    ${TOP_DIR}/src/runtime/feature/src/device/ctrl_msg.cc
    ${TOP_DIR}/src/runtime/feature/src/drv/v200/npu_driver.cc
    ${TOP_DIR}/src/runtime/feature/src/drv/npu_driver_dcache_lock_common.cpp
    ${TOP_DIR}/src/runtime/feature/src/model/model.cc
    ${TOP_DIR}/src/runtime/feature/src/model/model_rebuild.cc
    ${TOP_DIR}/src/runtime/feature/src/model/capture_model.cc
    ${TOP_DIR}/src/runtime/feature/src/model/capture_model_utils.cc
    ${TOP_DIR}/src/runtime/feature/src/model/v200/capture_adapt.cc
    ${TOP_DIR}/src/runtime/feature/src/kernel/args/args_handle_allocator.cc
    ${TOP_DIR}/src/runtime/feature/src/kernel/args/para_convertor.cc
    ${TOP_DIR}/src/runtime/feature/src/kernel/v200_base/kernel.cc
    ${TOP_DIR}/src/runtime/feature/src/kernel/binary_loader.cc
    ${TOP_DIR}/src/runtime/feature/src/kernel/v200_base/binary_loader_c.cc
    ${TOP_DIR}/src/runtime/feature/src/kernel/elf.cc
    ${TOP_DIR}/src/runtime/feature/src/kernel/kernel.cc
    ${TOP_DIR}/src/runtime/feature/src/kernel/module.cc
    ${TOP_DIR}/src/runtime/feature/src/kernel/program.cc
    ${TOP_DIR}/src/runtime/feature/src/launch/label.cc
    ${TOP_DIR}/src/runtime/feature/src/device/aicpu_err_msg.cc
    ${TOP_DIR}/src/runtime/feature/src/notify/notify.cc
    ${TOP_DIR}/src/runtime/feature/src/event/event.cc
    ${TOP_DIR}/src/runtime/feature/src/event/ipc_event.cc
    ${TOP_DIR}/src/runtime/feature/src/engine/logger.cc
    ${TOP_DIR}/src/runtime/feature/src/runtime.cc
    ${TOP_DIR}/src/runtime/feature/src/memory/mem_type.cc
    ${TOP_DIR}/src/runtime/feature/src/plugin_manage/runtime_keeper.cc
    ${TOP_DIR}/src/runtime/feature/src/plugin_manage/v200/plugin_old_arch.cc
    ${TOP_DIR}/src/runtime/feature/src/utils/capability.cc
    ${TOP_DIR}/src/runtime/feature/src/task/ctrl_res_pool.cpp
    ${TOP_DIR}/src/runtime/feature/src/utils/osal.cc
    ${TOP_DIR}/src/runtime/feature/src/engine/hwts/scheduler.cc
    ${TOP_DIR}/src/runtime/feature/src/profiler/profiler.cc
    ${TOP_DIR}/src/runtime/feature/src/dfx/atrace_log.cc
    ${TOP_DIR}/src/runtime/feature/src/dfx/fp16_t.cpp
    ${TOP_DIR}/src/runtime/feature/src/dfx/hifloat.cpp
    ${TOP_DIR}/src/runtime/feature/src/dfx/pctrace.cc
    ${TOP_DIR}/src/runtime/feature/src/dfx/printf.cc
    ${TOP_DIR}/src/runtime/feature/src/utils/subscribe.cc
    ${TOP_DIR}/src/runtime/feature/src/profiler/onlineprof.cc
    ${TOP_DIR}/src/runtime/feature/src/device/device_error_proc.cc
    ${TOP_DIR}/src/runtime/feature/src/device/v200_base/device_error_proc.cc
    ${TOP_DIR}/src/runtime/feature/src/device/device_error_core_proc.cc
    ${TOP_DIR}/src/runtime/feature/src/task/stars_cond_isa_helper.cc
    ${TOP_DIR}/src/runtime/feature/src/common/thread_local_container.cc
    ${TOP_DIR}/src/runtime/feature/src/common/inner_thread_local.cpp
    ${TOP_DIR}/src/runtime/feature/src/device/device_msg_handler.cc
    ${TOP_DIR}/src/runtime/feature/src/utils/aicpu_scheduler_agent.cc
    ${TOP_DIR}/src/runtime/feature/src/task/host_task.cc
    ${TOP_DIR}/src/runtime/feature/src/stream/dvpp_grp.cc
    ${TOP_DIR}/src/runtime/feature/src/api/inner.cc
    ${TOP_DIR}/src/runtime/feature/src/task/task_to_sqe.cc
    ${TOP_DIR}/src/runtime/feature/src/drv/npu_driver_tiny.cpp
    ${TOP_DIR}/src/runtime/feature/src/engine/engine.cc
    ${TOP_DIR}/src/runtime/feature/src/engine/hwts/package_rebuilder.cc
    ${TOP_DIR}/src/runtime/feature/src/engine/stars/stars_engine.cc
    ${TOP_DIR}/src/runtime/feature/src/engine/hwts/hwts_engine.cc
    ${TOP_DIR}/src/runtime/feature/src/engine/hwts/async_hwts_engine.cc
    ${TOP_DIR}/src/runtime/feature/src/engine/hwts/direct_hwts_engine.cc
    ${TOP_DIR}/src/runtime/feature/src/engine/engine_factory.cc
    ${TOP_DIR}/src/runtime/feature/src/engine/hwts/shm_cq.cc
    ${TOP_DIR}/src/runtime/feature/src/task/task_info/profiling_task.cc
    ${TOP_DIR}/src/runtime/feature/src/drv/npu_driver_res.cc
    ${TOP_DIR}/src/runtime/feature/src/drv/npu_driver_mem.cc
    ${TOP_DIR}/src/runtime/feature/src/drv/npu_driver_queue.cc
    ${TOP_DIR}/src/runtime/feature/src/runtime_v200/runtime_adapt.cc
    ${TOP_DIR}/src/runtime/feature/src/kernel/xpu/program_plat.cc
    ${TOP_DIR}/src/runtime/feature/src/kernel/xpu/binary_loader_plat.cc
    ${TOP_DIR}/src/runtime/feature/src/kernel/program.cc
    ${TOP_DIR}/src/runtime/feature/src/kernel/program_common.cc
    ${TOP_DIR}/src/runtime/feature/src/kernel/json_parse.cc
    ${TOP_DIR}/src/runtime/feature/src/kernel/v200_base/binary_loader_c.cc
    ${runtimeut_src_common_list}
    ${runtimeut_platform_list}
)
add_library(runtime_ut_david_static_lib STATIC ${runtimeut_david_src_list})

target_include_directories(
    runtime_ut_david_static_lib PUBLIC 
    ${RUNTIME_DIR}/src/inc/runtime
    ${TOP_DIR}/src/runtime/tprt/inc/external
    ${TOP_DIR}/src/runtime/tprt/feature/inc
    ${TOP_DIR}/abl/slog/inc
    ${TOP_DIR}/abl/mmpa/inc
    ${TOP_DIR}/abl/libc_sec/include
)

target_compile_definitions(runtime_ut_david_static_lib PUBLIC
    XPU_UT
    TEMP_PERFORMANCE
    TEMP_PERFORMANCE_NOT_OUTPUT
)
target_link_libraries(runtime_ut_david_static_lib PRIVATE $<BUILD_INTERFACE:runtime_utest_intf_pub>)
###################################################################################################
add_library(runtimeut_src_static_lib STATIC ${runtimeut_src_list})

target_include_directories(
    runtimeut_src_static_lib PUBLIC 
    ${TOP_DIR}/src/runtime/tprt/inc/external
    ${TOP_DIR}/src/runtime/tprt/feature/inc
    ${TOP_DIR}/abl/slog/inc
    ${TOP_DIR}/abl/mmpa/inc
    ${TOP_DIR}/abl/libc_sec/include
)

target_compile_definitions(runtimeut_src_static_lib PUBLIC
    TEMP_PERFORMANCE
    TEMP_PERFORMANCE_NOT_OUTPUT
)

target_link_libraries(runtimeut_src_static_lib PRIVATE $<BUILD_INTERFACE:runtime_utest_intf_pub>)
###################################################################################################
set(stub_src_list
    stub/atrace_stub.cc
    stub/awatch_dog_stub.cc
    stub/error_manager_stub.cc
    stub/log_stub.cc
    stub/prof_stub.cc
    stub/platform_stub.cc
)
add_library(runtime_ut_stub_static_lib STATIC ${stub_src_list})

target_link_libraries(runtime_ut_stub_static_lib PRIVATE $<BUILD_INTERFACE:runtime_utest_intf_pub>)

#########   library for camodel specific features;
set(runtimeut_camodel_src_list ${runtimeut_src_list})
list(REMOVE_ITEM runtimeut_camodel_src_list
    "${TOP_DIR}/src/runtime/feature/src/device/raw_device_res.cc"
)
add_library(runtimeut_camodel_src_static_lib STATIC
    ${runtimeut_camodel_src_list}
    ${TOP_DIR}/src/runtime/feature/src/device/raw_device_res_camodel.cc
)

target_compile_definitions(runtimeut_camodel_src_static_lib PUBLIC
    TEMP_PERFORMANCE
    TEMP_PERFORMANCE_NOT_OUTPUT
)

target_link_libraries(runtimeut_camodel_src_static_lib PRIVATE $<BUILD_INTERFACE:runtime_utest_intf_pub>)

###################################################################################################

set(runtimeut_camodel_src_list_v200 ${runtimeut_src_list})
list(REMOVE_ITEM runtimeut_camodel_src_list_v200
    "${TOP_DIR}/src/runtime/feature/src/device/raw_device_res.cc"
    "${TOP_DIR}/src/runtime/feature/src/task/v100/task_proc_func_register.cc"
)
add_library(runtimeut_camodel_src_v200_static_lib STATIC
    ${runtimeut_camodel_src_list_v200}
    ${TOP_DIR}/src/runtime/feature/src/device/raw_device_res_camodel.cc
    ${TOP_DIR}/src/runtime/feature/src/task/v200_base/task_proc_func_register.cc
)


target_compile_definitions(runtimeut_camodel_src_v200_static_lib PUBLIC
    TEMP_PERFORMANCE
    TEMP_PERFORMANCE_NOT_OUTPUT
)

target_link_libraries(runtimeut_camodel_src_v200_static_lib PRIVATE $<BUILD_INTERFACE:runtime_utest_intf_pub>)

###################################################################################################
add_executable(runtime_utest
    ${runtime_raw_device_adpt_common_list}
    ${TOP_DIR}/src/runtime/feature/src/drv/npu_driver.cc
    ${TOP_DIR}/src/runtime/feature/src/drv/npu_driver_mem.cc
    ${TOP_DIR}/src/runtime/feature/src/drv/npu_driver_queue.cc
    ${TOP_DIR}/src/runtime/feature/src/drv/npu_driver_res.cc
    ${TOP_DIR}/src/runtime/feature/src/drv/npu_driver_dcache_lock_opb.cpp
    ${TOP_DIR}/src/runtime/feature/src/drv/npu_driver_standard_soc.cc
    ${TOP_DIR}/src/runtime/feature/src/drv/v100/npu_driver.cc
    ${TOP_DIR}/src/runtime/feature/src/kernel/v100/kernel.cc
    ${TOP_DIR}/src/runtime/feature/src/task/v100/stub_task.cc
    stub/hal_stub.cc
    test/main.cc
    test/rt_utest_ctrl_stream.cc
    test/rt_utest_kernellaunch.cc
    test/rt_utest_ctrl_res_pool.cc
    test/rt_utest_stream.cc
    test/rt_utest_osal.cc
    test/rt_utest_module.cc
    test/rt_utest_elf.cc
    test/rt_utest_program.cc
    test/rt_utest_runtime.cc
    test/rt_utest_kernel.cc
    test/rt_utest_config.cc
    test/rt_utest_driver.cc
    test/rt_utest_device.cc
    test/rt_utest_arg_loader.cc
    test/rt_utest_context.cc
    test/rt_utest_pool.cc
    test/rt_utest_agent.cc
    test/rt_utest_aicpu_err_msg.cc
    test/rt_utest_aicpu_scheduler_agent.cc
    test/rt_utest_ttlv.cc
    #test/rt_utest_atrace_log.cc
    test/rt_error_code_test.cc
    test/rt_utest_set_soc_type.cc
    test/common/dev_info_manage_test.cc
    test/platform/others/rt_utest_device.cc
    #test/platform/cloudv2/rt_utest_ffts.cc
    test/rt_utest_task_stars.cc
    test/platform/others/rt_utest_memory_pool.cc
    test/rt_utest_binary_loader.cc
    test/platform/others/rt_utest_cloudv2_disable_thread_test.cc
    test/platform/others/rt_utest_stream.cc
    test/platform/others/rt_utest_notify.cc
    test/platform/others/rt_utest_elf.cc
    test/platform/others/rt_utest_npu_driver.cc
    test/platform/others/rt_utest_runtime.cc
    test/platform/others/rt_utest_kernel.cc
    test/platform/others/rt_utest_driver.cc
    test/platform/others/rt_utest_arg_loader.cc
    test/platform/others/rt_utest_context.cc
    test/platform/others/rt_utest_ffts.cc
    test/platform/others/rt_utest_task_stars.cc
    test/platform/others/rt_utest_parma_build_sqe.cc
    test/platform/others/rt_utest_binary_loader.cc
)

target_compile_definitions(runtime_utest PUBLIC
    TEMP_PERFORMANCE
    TEMP_PERFORMANCE_NOT_OUTPUT
)

target_link_libraries(runtime_utest PRIVATE
    $<BUILD_INTERFACE:runtime_utest_intf_pub>
    -Wl,--whole-archive
     runtimeut_src_static_lib
     runtime_ut_stub_static_lib
    -Wl,--no-whole-archive
)

##### build ut target specific for camodel;
add_executable(runtime_utest_camodel
    ${runtime_raw_device_adpt_common_list}
    ${TOP_DIR}/src/runtime/feature/src/drv/npu_driver.cc
    ${TOP_DIR}/src/runtime/feature/src/drv/npu_driver_mem.cc
    ${TOP_DIR}/src/runtime/feature/src/drv/npu_driver_queue.cc
    ${TOP_DIR}/src/runtime/feature/src/drv/npu_driver_res.cc
    ${TOP_DIR}/src/runtime/feature/src/drv/npu_driver_dcache_lock_opb.cpp
    ${TOP_DIR}/src/runtime/feature/src/drv/npu_driver_standard_soc.cc
    ${TOP_DIR}/src/runtime/feature/src/drv/v100/npu_driver.cc
    ${TOP_DIR}/src/runtime/feature/src/kernel/v100/kernel.cc
    ${TOP_DIR}/src/runtime/feature/src/task/v100/stub_task.cc

    stub/hal_stub.cc
    test/main.cc
    test/rt_utest_device.cc
)

target_compile_definitions(runtime_utest_camodel PUBLIC
    TEMP_PERFORMANCE
    TEMP_PERFORMANCE_NOT_OUTPUT
)

target_link_libraries(runtime_utest_camodel PRIVATE
    $<BUILD_INTERFACE:runtime_utest_intf_pub>
    -Wl,--whole-archive
    runtimeut_camodel_src_static_lib
    runtime_ut_stub_static_lib
    -Wl,--no-whole-archive
)

###################################################################################################
add_executable(runtime_camodel_utest_v200
    ${runtime_raw_device_adpt_common_list}
    ${TOP_DIR}/src/runtime/feature/src/drv/npu_driver.cc
    ${TOP_DIR}/src/runtime/feature/src/drv/npu_driver_mem.cc
    ${TOP_DIR}/src/runtime/feature/src/drv/npu_driver_queue.cc
    ${TOP_DIR}/src/runtime/feature/src/drv/npu_driver_res.cc
    ${TOP_DIR}/src/runtime/feature/src/drv/npu_driver_dcache_lock_opb.cpp
    ${TOP_DIR}/src/runtime/feature/src/drv/npu_driver_standard_soc.cc
    ${TOP_DIR}/src/runtime/feature/src/drv/v100/npu_driver.cc
    ${TOP_DIR}/src/runtime/feature/src/kernel/v100/kernel.cc
    ${TOP_DIR}/src/runtime/feature/src/task/v100/stub_task.cc
    stub/hal_stub.cc
    test/main.cc
    test/rt_utest_camodel_v200.cc
)

target_compile_definitions(runtime_camodel_utest_v200 PUBLIC
    TEMP_PERFORMANCE
    TEMP_PERFORMANCE_NOT_OUTPUT
)

target_link_libraries(runtime_camodel_utest_v200 PRIVATE
    $<BUILD_INTERFACE:runtime_utest_intf_pub>
    -Wl,--whole-archive
    runtimeut_camodel_src_v200_static_lib
    runtime_ut_stub_static_lib
    -Wl,--no-whole-archive
)

###################################################################################################
add_executable(runtime_utest_model
    ${runtime_raw_device_adpt_common_list}
    ${TOP_DIR}/src/runtime/feature/src/drv/npu_driver.cc
    ${TOP_DIR}/src/runtime/feature/src/drv/npu_driver_mem.cc
    ${TOP_DIR}/src/runtime/feature/src/drv/npu_driver_queue.cc
    ${TOP_DIR}/src/runtime/feature/src/drv/npu_driver_res.cc
    ${TOP_DIR}/src/runtime/feature/src/drv/npu_driver_dcache_lock_opb.cpp
    ${TOP_DIR}/src/runtime/feature/src/drv/npu_driver_standard_soc.cc
    ${TOP_DIR}/src/runtime/feature/src/drv/v100/npu_driver.cc
    ${TOP_DIR}/src/runtime/feature/src/kernel/v100/kernel.cc
    ${TOP_DIR}/src/runtime/feature/src/task/v100/stub_task.cc
    stub/hal_stub.cc
    test/main.cc
    test/rt_utest_label.cc
    test/rt_utest_model.cc
    test/platform/others/rt_utest_model.cc
)

target_compile_definitions(runtime_utest_model PUBLIC
    TEMP_PERFORMANCE
    TEMP_PERFORMANCE_NOT_OUTPUT
)

target_link_libraries(runtime_utest_model PRIVATE
    $<BUILD_INTERFACE:runtime_utest_intf_pub>
    -Wl,--whole-archive
     runtimeut_src_static_lib
     runtime_ut_stub_static_lib
    -Wl,--no-whole-archive
)

###################################################################################################
add_executable(runtime_utest_engine
    ${runtime_raw_device_adpt_common_list}
    ${TOP_DIR}/src/runtime/feature/src/drv/npu_driver.cc
    ${TOP_DIR}/src/runtime/feature/src/drv/npu_driver_mem.cc
    ${TOP_DIR}/src/runtime/feature/src/drv/npu_driver_queue.cc
    ${TOP_DIR}/src/runtime/feature/src/drv/npu_driver_res.cc
    ${TOP_DIR}/src/runtime/feature/src/drv/npu_driver_dcache_lock_opb.cpp
    ${TOP_DIR}/src/runtime/feature/src/drv/npu_driver_standard_soc.cc
    ${TOP_DIR}/src/runtime/feature/src/drv/v100/npu_driver.cc
    ${TOP_DIR}/src/runtime/feature/src/kernel/v100/kernel.cc
    ${TOP_DIR}/src/runtime/feature/src/task/v100/stub_task.cc
    stub/hal_stub.cc
    test/main.cc
    test/rt_utest_engine.cc
    test/platform/others/rt_utest_stars_engine.cc
    test/rt_utest_package_rebuilder.cc
    test/rt_utest_direct_hwts_engine.cc
    test/platform/others/rt_utest_direct_hwts_engine.cc
    # test/platform/others/rt_utest_async_hwts_engine.cc
)

target_compile_definitions(runtime_utest_engine PUBLIC
    TEMP_PERFORMANCE
    TEMP_PERFORMANCE_NOT_OUTPUT
)

target_link_libraries(runtime_utest_engine PRIVATE
    $<BUILD_INTERFACE:runtime_utest_intf_pub>
    -Wl,--whole-archive
     runtimeut_src_static_lib
     runtime_ut_stub_static_lib
    -Wl,--no-whole-archive
)
###################################################################################################
add_executable(runtime_utest_api
    ${runtime_raw_device_adpt_common_list}
    ${TOP_DIR}/src/runtime/feature/src/drv/npu_driver.cc
    ${TOP_DIR}/src/runtime/feature/src/drv/npu_driver_mem.cc
    ${TOP_DIR}/src/runtime/feature/src/drv/npu_driver_queue.cc
    ${TOP_DIR}/src/runtime/feature/src/drv/npu_driver_res.cc
    ${TOP_DIR}/src/runtime/feature/src/drv/npu_driver_dcache_lock_opb.cpp
    ${TOP_DIR}/src/runtime/feature/src/drv/npu_driver_standard_soc.cc
    ${TOP_DIR}/src/runtime/feature/src/drv/v100/npu_driver.cc
    ${TOP_DIR}/src/runtime/feature/src/kernel/v100/kernel.cc
    ${TOP_DIR}/src/runtime/feature/src/task/v100/stub_task.cc
    stub/hal_stub.cc
    test/main.cc
    test/rt_utest_api_common_defination.cc
    test/rt_utest_api_can_not_run.cc
    #test/rt_utest_api.cc
    test/rt_utest_api_stream.cc
    test/rt_utest_api_context.cc
    test/rt_utest_api_device.cc
    test/rt_utest_api_kernel.cc
    test/rt_utest_api_impl.cc
    test/rt_api_test.cc
    test/rt_utest_set_device_failure_mode.cc
    test/rt_utest_profiler.cc
    test/rt_utest_profileapi.cc
    test/rt_utest_api_exception.cc
)

target_compile_definitions(runtime_utest_api PUBLIC
    TEMP_PERFORMANCE
    TEMP_PERFORMANCE_NOT_OUTPUT
)

target_link_libraries(runtime_utest_api PRIVATE
    $<BUILD_INTERFACE:runtime_utest_intf_pub>
    -Wl,--whole-archive
     runtimeut_src_static_lib
     runtime_ut_stub_static_lib
    -Wl,--no-whole-archive
)

target_include_directories(runtime_utest_api PRIVATE
    ${CMAKE_CURRENT_SOURCE_DIR}
    ${CMAKE_CURRENT_SOURCE_DIR}/test
)
###################################################################################################
add_executable(runtime_utest_api_ext_others
    ${runtime_raw_device_adpt_common_list}
    ${TOP_DIR}/src/runtime/feature/src/drv/npu_driver.cc
    ${TOP_DIR}/src/runtime/feature/src/drv/npu_driver_mem.cc
    ${TOP_DIR}/src/runtime/feature/src/drv/npu_driver_queue.cc
    ${TOP_DIR}/src/runtime/feature/src/drv/npu_driver_res.cc
    ${TOP_DIR}/src/runtime/feature/src/drv/npu_driver_dcache_lock_opb.cpp
    ${TOP_DIR}/src/runtime/feature/src/drv/npu_driver_standard_soc.cc
    ${TOP_DIR}/src/runtime/feature/src/drv/v100/npu_driver.cc
    ${TOP_DIR}/src/runtime/feature/src/kernel/v100/kernel.cc
    ${TOP_DIR}/src/runtime/feature/src/task/v100/stub_task.cc
    stub/hal_stub.cc
    test/main.cc
    test/platform/others/rt_utest_api_dfx.cc
    test/platform/others/rt_utest_api_kernel.cc
    test/platform/others/rt_api_test.cc
    test/platform/others/rt_utest_api_impl.cc
    test/platform/others/rt_utest_api_test6.cc
    test/platform/others/rt_utest_set_device_failure_mode.cc
    test/platform/others/rt_utest_dcache_lock.cc
    test/platform/others/rt_utest_customer_stack_size.cc
)

target_compile_definitions(runtime_utest_api_ext_others PUBLIC
    TEMP_PERFORMANCE
    TEMP_PERFORMANCE_NOT_OUTPUT
)

target_link_libraries(runtime_utest_api_ext_others PRIVATE
    $<BUILD_INTERFACE:runtime_utest_intf_pub>
    -Wl,--whole-archive
     runtimeut_src_static_lib
     runtime_ut_stub_static_lib
    -Wl,--no-whole-archive
)
###################################################################################################
add_executable(runtime_utest_task_normal
    ${runtime_raw_device_adpt_common_list}
    ${TOP_DIR}/src/runtime/feature/src/drv/npu_driver.cc
    ${TOP_DIR}/src/runtime/feature/src/drv/npu_driver_mem.cc
    ${TOP_DIR}/src/runtime/feature/src/drv/npu_driver_queue.cc
    ${TOP_DIR}/src/runtime/feature/src/drv/npu_driver_res.cc
    ${TOP_DIR}/src/runtime/feature/src/drv/npu_driver_dcache_lock_opb.cpp
    ${TOP_DIR}/src/runtime/feature/src/drv/npu_driver_standard_soc.cc
    ${TOP_DIR}/src/runtime/feature/src/drv/v100/npu_driver.cc
    ${TOP_DIR}/src/runtime/feature/src/kernel/v100/kernel.cc
    ${TOP_DIR}/src/runtime/feature/src/task/v100/stub_task.cc
    ${TOP_DIR}/src/runtime/feature/src/kernel/v100/binary_loader_plat.cc
    ${TOP_DIR}/src/runtime/feature/src/kernel/v100/program_plat.cc
    stub/hal_stub.cc
    test/main.cc
    test/rt_utest_task.cc
)

target_compile_definitions(runtime_utest_task_normal PUBLIC
    TEMP_PERFORMANCE
    TEMP_PERFORMANCE_NOT_OUTPUT
)

target_link_libraries(runtime_utest_task_normal PRIVATE
    $<BUILD_INTERFACE:runtime_utest_intf_pub>
    -Wl,--whole-archive
     runtimeut_src_static_lib
     runtime_ut_stub_static_lib
    -Wl,--no-whole-archive
)
###################################################################################################

add_executable(runtime_utest_dfx
    ${runtime_raw_device_adpt_common_list}
    ${TOP_DIR}/src/runtime/feature/src/drv/npu_driver.cc
    ${TOP_DIR}/src/runtime/feature/src/drv/npu_driver_mem.cc
    ${TOP_DIR}/src/runtime/feature/src/drv/npu_driver_queue.cc
    ${TOP_DIR}/src/runtime/feature/src/drv/npu_driver_res.cc
    ${TOP_DIR}/src/runtime/feature/src/drv/npu_driver_dcache_lock_opb.cpp
    ${TOP_DIR}/src/runtime/feature/src/drv/npu_driver_standard_soc.cc
    ${TOP_DIR}/src/runtime/feature/src/drv/v100/npu_driver.cc
    ${TOP_DIR}/src/runtime/feature/src/kernel/v100/kernel.cc
    ${TOP_DIR}/src/runtime/feature/src/task/v100/stub_task.cc
    stub/hal_stub.cc
    test/main.cc
    test/rt_utest_pctrace.cc
    test/rt_utest_dfx_api.cc
    test/rt_utest_printf.cc
)

target_compile_definitions(runtime_utest_dfx PUBLIC
    TEMP_PERFORMANCE
    TEMP_PERFORMANCE_NOT_OUTPUT
)

target_link_libraries(runtime_utest_dfx PRIVATE
    $<BUILD_INTERFACE:runtime_utest_intf_pub>
    -Wl,--whole-archive
     runtimeut_src_static_lib
     runtime_ut_stub_static_lib
    -Wl,--no-whole-archive
)
target_include_directories(runtime_utest_dfx PRIVATE
    ${TOP_DIR}/src/inc
    ${TOP_DIR}/src/inc/external
    ${TOP_DIR}/pkg_inc/runtime/runtime
    ${TOP_DIR}/pkg_inc/runtime/runtime/rts
    ${TOP_DIR}/pkg_inc/platform
    ${TOP_DIR}/src/platform
)
##################################################################################################

set(runtimeut_src_tiny_list_all
    ${runtimeut_src_list}
    ${runtime_raw_device_adpt_common_list}
    ${TOP_DIR}/src/runtime/feature/src/drv/npu_driver.cc
    ${TOP_DIR}/src/runtime/feature/src/drv/npu_driver_mem.cc
    ${TOP_DIR}/src/runtime/feature/src/drv/npu_driver_queue.cc
    ${TOP_DIR}/src/runtime/feature/src/drv/npu_driver_res.cc
    ${TOP_DIR}/src/runtime/feature/src/drv/npu_driver_dcache_lock_opb.cpp
    ${TOP_DIR}/src/runtime/feature/src/drv/npu_driver_standard_soc.cc
    ${TOP_DIR}/src/runtime/feature/src/drv/v100/npu_driver.cc
    ${TOP_DIR}/src/runtime/feature/src/kernel/v100/kernel.cc
    ${TOP_DIR}/src/runtime/feature/src/runtime.cc
    ${TOP_DIR}/src/runtime/feature/src/memory/mem_type.cc
    ${TOP_DIR}/src/runtime/feature/src/task/v100/stub_task.cc
)

list(REMOVE_ITEM runtimeut_src_tiny_list_all
    ${runtimeut_src_tiny_exclude_list}
)

add_executable(runtime_utest_tiny_stub
    ${runtimeut_src_tiny_list_all}
    ${runtimeut_src_tiny_include_list}
    stub/hal_stub.cc
    test/main.cc
    test/rt_utest_tiny_stub.cc
)

target_compile_definitions(runtime_utest_tiny_stub PUBLIC
    TEMP_PERFORMANCE
    TEMP_PERFORMANCE_NOT_OUTPUT
)

target_link_libraries(runtime_utest_tiny_stub PRIVATE
    $<BUILD_INTERFACE:runtime_utest_intf_pub>
    -Wl,--whole-archive
     runtime_ut_stub_static_lib
    -Wl,--no-whole-archive
)
##################################################################################################
add_library(runtime_utest_intf_pub INTERFACE)

target_compile_definitions(runtime_utest_intf_pub INTERFACE
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
    ${TOP_DIR}/src/runtime/feature/inc
    ${TOP_DIR}/src/runtime/feature/inc_c
    ${TOP_DIR}/src/runtime/feature/inc/context
    ${TOP_DIR}/src/runtime/feature/inc/spec
    ${TOP_DIR}/src/runtime/feature/inc/common
    ${TOP_DIR}/src/runtime/feature/inc/sqe/v200_base
    ${TOP_DIR}/src/runtime/feature/inc/runtime
    ${TOP_DIR}/src/runtime/feature/inc/device
    ${TOP_DIR}/src/runtime/feature/inc/drv
    ${TOP_DIR}/src/runtime/feature/inc/task
    ${TOP_DIR}/src/runtime/feature/inc/utils
    ${TOP_DIR}/src/runtime/feature/inc/engine
    ${TOP_DIR}/src/runtime/feature/inc/dfx
    ${TOP_DIR}/src/runtime/feature/inc/kernel
    ${TOP_DIR}/src/runtime/feature/inc/soc
    ${TOP_DIR}/src/runtime/feature/inc/stars
    ${TOP_DIR}/src/runtime/feature/inc/stream
    ${TOP_DIR}/src/runtime/feature/inc/launch
    ${TOP_DIR}/src/runtime/feature/inc/model
    ${TOP_DIR}/src/runtime/feature/inc/event
    ${TOP_DIR}/src/runtime/feature/inc/arg_loader
    ${TOP_DIR}/src/runtime/feature/inc/notify
    ${TOP_DIR}/src/runtime/feature/inc/profiler
    ${TOP_DIR}/src/runtime/feature/inc/engine/hwts
    ${TOP_DIR}/src/runtime/feature/inc/dqs
    ${TOP_DIR}/src/runtime/feature/src/api
    ${TOP_DIR}/src/runtime/feature/src/api_impl
    ${TOP_DIR}/src/runtime/feature/src/engine
    ${TOP_DIR}/src/runtime/feature/src/engine/hwts
    ${TOP_DIR}/src/runtime/feature/src/engine/stars
    ${TOP_DIR}/src/runtime/feature/src/dfx
    ${TOP_DIR}/src/runtime/feature/src/stream
    ${TOP_DIR}/src/runtime/feature/src/task/inc
    ${TOP_DIR}/src/runtime/feature/src/profiler
    ${TOP_DIR}/src/runtime/feature/src/pool
    ${TOP_DIR}/src/runtime/feature/src/ttlv
    ${TOP_DIR}/src/runtime/feature/src/device
    ${TOP_DIR}/src/runtime/feature/src/drv
    ${TOP_DIR}/src/runtime/feature/src/common
    ${TOP_DIR}/src/runtime/feature/src/plugin_manage
    ${TOP_DIR}/src/runtime/feature/src/kernel
    ${TOP_DIR}/src/runtime/feature/src/kernel/arg_loader
    ${TOP_DIR}/src/runtime/feature/src/kernel/args
    ${TOP_DIR}/src/runtime/feature/src/task/
    ${TOP_DIR}/src/runtime/feature/src/memory/
    ${TOP_DIR}/src
    ${TOP_DIR}/src/runtime/raw_driver
    ${TOP_DIR}/src/runtime/cmodel_driver
    ${TOP_DIR}/src/runtime/c/feature/inc
    ${TOP_DIR}/metadef/inc
    ${TOP_DIR}/src/dfx/adump/inc/metadef
    ${TOP_DIR}/metadef/inc/external
    ${TOP_DIR}/pkg_inc/aicpu_sched/common
    ${TOP_DIR}/tests/ut/runtime/runtime/stub/
    ${TOP_DIR}/include
    ${TOP_DIR}/pkg_inc/tsd
    ${TOP_DIR}/pkg_inc/trace
    ${TOP_DIR}/pkg_inc/watchdog
    ${TOP_DIR}/pkg_inc/profiling
    ${TOP_DIR}/abl/atrace/inc/awatchdog/
    ${TOP_DIR}/pkg_inc
    ${TOP_DIR}/src/queue_schedule/dgwclient/inc
    ${TOP_DIR}/src/dfx/msprof/include/external/runtime/rts
    ${TOP_DIR}/src/inc/external
    ${TOP_DIR}/include/external/acl
    ${TOP_DIR}/include/external/acl/error_codes
    ${TOP_DIR}/pkg_inc/runtime/runtime
    ${TOP_DIR}/pkg_inc/runtime/runtime/rts
    ${TOP_DIR}/pkg_inc/platform
    ${TOP_DIR}/src/platform
    ${C_SEC_INCLUDE}
)

set(RUNTIME_TEST_INC_DIR
    ${RUNTIME_TEST_INC_DIR_COMMON}
    ${TOP_DIR}/src/runtime/feature/inc/sqe/v200
    ${TOP_DIR}/src/runtime/feature/inc/cond_isa/v100
)

target_include_directories(runtime_utest_intf_pub INTERFACE
    ${RUNTIME_TEST_INC_DIR}
)

target_compile_options(runtime_utest_intf_pub INTERFACE
    -Wformat
    -Wall
    -Wextra
    -fno-access-control
    -fno-devirtualize
    -fno-inline-small-functions
)

target_link_libraries(runtime_utest_intf_pub INTERFACE
    mmpa
    json
    GTest::gtest
    GTest::gtest_main
    c_sec
    -lrt
    -ldl
    -lpthread
    -lgcov
    $<BUILD_INTERFACE:intf_llt_pub>
    $<BUILD_INTERFACE:mmpa_headers>
    $<BUILD_INTERFACE:c_sec_headers>
    $<BUILD_INTERFACE:msprof_headers>
    $<BUILD_INTERFACE:slog_headers>
    $<BUILD_INTERFACE:npu_runtime_headers>
)

target_link_options(runtime_utest_intf_pub INTERFACE
    -Wl,--wrap=malloc,-lrt
    -rdynamic
)

add_library(intf_llt_pub INTERFACE)

target_include_directories(intf_llt_pub INTERFACE
)

target_compile_definitions(intf_llt_pub INTERFACE
    CFG_BUILD_DEBUG
    _GLIBCXX_USE_CXX11_ABI=0
)

target_compile_options(intf_llt_pub INTERFACE
    -g
    -w
    $<$<BOOL:${ENABLE_GCOV}>:-fprofile-arcs -ftest-coverage>
    $<$<BOOL:${ENABLE_ASAN}>:-fsanitize=address -fno-omit-frame-pointer -static-libasan -fsanitize=undefined -static-libubsan -fsanitize=leak -static-libtsan>
    -fPIC
    -pipe
)

target_link_options(intf_llt_pub INTERFACE
    $<$<BOOL:${ENABLE_GCOV}>:-fprofile-arcs -ftest-coverage>
    $<$<BOOL:${ENABLE_ASAN}>:-fsanitize=address -static-libasan -fsanitize=undefined  -static-libubsan -fsanitize=leak -static-libtsan>
)

target_link_directories(intf_llt_pub INTERFACE
)

target_link_libraries(intf_llt_pub INTERFACE
    GTest::gtest
    ${OPEN_SOURCE_DIR}/mockcpp/lib/libmockcpp.a
    -lpthread
    $<$<BOOL:${ENABLE_GCOV}>:-lgcov>
)

############################################## UT V201 ###########################################
set(runtimeut_v201_src_stream_list
    ${runtimeut_common_src_stream_list}

    ${TOP_DIR}/src/runtime/feature/src/stream/stream_david.cc
    ${TOP_DIR}/src/runtime/feature/src/stream/v201/stream_with_dqs.cc
    ${TOP_DIR}/src/runtime/feature/src/stream/v201/stream_creator_c.cc
)

set(runtimeut_v201_src_task_list
    ${runtimeut_david_series_common_src_task_list}
    # v201
    ${TOP_DIR}/src/runtime/feature/src/task/v201/task_proc_func_register.cc
    ${TOP_DIR}/src/runtime/feature/src/task/v201/memcpy_task_to_sqe.cc
    ${TOP_DIR}/src/runtime/feature/src/task/v201/aicpu_task_to_sqe.cc
    ${TOP_DIR}/src/runtime/feature/src/task/v201/task_checker.cc
    ${TOP_DIR}/src/runtime/feature/src/task/v201/dqs_task.cc
    ${TOP_DIR}/src/runtime/feature/src/launch/v201/dqs_c.cc
    ${TOP_DIR}/src/runtime/feature/src/api_impl/v201/api_impl_v200_adapt.cc
)

set(runtimeut_v201_src_list
    ${runtimeut_v201_src_task_list}
    ${runtimeut_src_api_list}
    ${runtimeut_src_context_list}
    ${runtimeut_v201_src_stream_list}
    ${runtimeut_src_profile_list}
    ${runtime_src_arg_loader_list}
    ${runtimeut_src_pool_list}
    ${runtimeut_src_ttlv_list}
    ${runtimeut_src_callback_list}
    ${runtimeut_src_david_c_list}
    ${runtime_raw_device_adpt_david_list}
    ${runtime_xpu_src}
    ${TOP_DIR}/src/runtime/feature/src/api/api.cc
    ${TOP_DIR}/src/runtime/feature/src/api_impl/api_decorator_xpu.cc
    ${TOP_DIR}/src/runtime/feature/src/api_impl/api_decorator.cc
    ${TOP_DIR}/src/runtime/feature/src/api_impl/api_impl.cc
    ${TOP_DIR}/src/runtime/feature/src/api_impl/api_impl_mbuf.cc
    ${TOP_DIR}/src/runtime/feature/src/api_impl/api_impl_david.cc
    ${TOP_DIR}/src/runtime/feature/src/api_impl/api_impl_creator.cc
    ${TOP_DIR}/src/runtime/feature/src/api_impl/v100/api_impl_v100.cc
    ${TOP_DIR}/src/runtime/feature/src/api_impl/v201/api_impl_v201.cc
    ${TOP_DIR}/src/runtime/feature/src/api_impl/v201/api_impl_v200_adapt.cc
    ${TOP_DIR}/src/runtime/feature/src/api_impl/v201/api_impl_creator_c.cc
    ${TOP_DIR}/src/runtime/feature/src/api_impl/api_impl_standard_soc.cc
    ${TOP_DIR}/src/runtime/feature/src/api_impl/api_error_xpu.cc
    ${TOP_DIR}/src/runtime/feature/src/api_impl/api_error.cc
    ${TOP_DIR}/src/runtime/feature/src/api_impl/api_error_standard_soc.cc
    ${TOP_DIR}/src/runtime/feature/src/config.cc
    ${TOP_DIR}/src/runtime/feature/src/context/context.cc
    ${TOP_DIR}/src/runtime/feature/src/context/context_standard_soc.cc
    ${TOP_DIR}/src/runtime/feature/src/device/device.cc
    ${TOP_DIR}/src/runtime/feature/src/device/raw_device.cc
    ${TOP_DIR}/src/runtime/feature/src/device/raw_device_res.cc
    ${TOP_DIR}/src/runtime/feature/src/device/device_snapshot.cc
    ${TOP_DIR}/src/runtime/feature/src/device/device_sq_cq_pool.cc
    ${TOP_DIR}/src/runtime/feature/src/device/sq_addr_memory_pool.cc
    ${TOP_DIR}/src/runtime/feature/src/drv/driver.cc
    ${TOP_DIR}/src/runtime/feature/src/device/ctrl_sq.cc
    ${TOP_DIR}/src/runtime/feature/src/device/ctrl_msg.cc
    ${TOP_DIR}/src/runtime/feature/src/drv/v201/npu_driver.cc
    ${TOP_DIR}/src/runtime/feature/src/drv/npu_driver_dcache_lock_common.cpp
    ${TOP_DIR}/src/runtime/feature/src/model/model.cc
    ${TOP_DIR}/src/runtime/feature/src/model/model_rebuild.cc
    ${TOP_DIR}/src/runtime/feature/src/model/capture_model.cc
    ${TOP_DIR}/src/runtime/feature/src/model/capture_model_utils.cc
    ${TOP_DIR}/src/runtime/feature/src/model/v200/capture_adapt.cc
    ${TOP_DIR}/src/runtime/feature/src/kernel/args/args_handle_allocator.cc
    ${TOP_DIR}/src/runtime/feature/src/kernel/args/para_convertor.cc
    ${TOP_DIR}/src/runtime/feature/src/kernel/v200_base/kernel.cc
    ${TOP_DIR}/src/runtime/feature/src/kernel/binary_loader.cc
    ${TOP_DIR}/src/runtime/feature/src/kernel/v200_base/binary_loader_c.cc
    ${TOP_DIR}/src/runtime/feature/src/kernel/program_common.cc
    ${TOP_DIR}/src/runtime/feature/src/kernel/json_parse.cc
    ${TOP_DIR}/src/runtime/feature/src/kernel/elf.cc
    ${TOP_DIR}/src/runtime/feature/src/kernel/module.cc
    ${TOP_DIR}/src/runtime/feature/src/kernel/kernel.cc
    ${TOP_DIR}/src/runtime/feature/src/kernel/program.cc
    ${TOP_DIR}/src/runtime/feature/src/kernel/xpu/binary_loader_plat.cc
    ${TOP_DIR}/src/runtime/feature/src/runtime_v200/runtime_adapt.cc
    ${TOP_DIR}/src/runtime/feature/src/kernel/xpu/program_plat.cc
    ${TOP_DIR}/src/runtime/feature/src/launch/label.cc
    ${TOP_DIR}/src/runtime/feature/src/device/aicpu_err_msg.cc
    ${TOP_DIR}/src/runtime/feature/src/notify/notify.cc
    ${TOP_DIR}/src/runtime/feature/src/event/event.cc
    ${TOP_DIR}/src/runtime/feature/src/event/ipc_event.cc
    ${TOP_DIR}/src/runtime/feature/src/engine/logger.cc
    ${TOP_DIR}/src/runtime/feature/src/runtime.cc
    ${TOP_DIR}/src/runtime/feature/src/memory/mem_type.cc
    ${TOP_DIR}/src/runtime/feature/src/plugin_manage/runtime_keeper.cc
    ${TOP_DIR}/src/runtime/feature/src/plugin_manage/v200/plugin_old_arch.cc
    ${TOP_DIR}/src/runtime/feature/src/utils/capability.cc
    ${TOP_DIR}/src/runtime/feature/src/task/ctrl_res_pool.cpp
    ${TOP_DIR}/src/runtime/feature/src/utils/osal.cc
    ${TOP_DIR}/src/runtime/feature/src/engine/hwts/scheduler.cc
    ${TOP_DIR}/src/runtime/feature/src/profiler/profiler.cc
    ${TOP_DIR}/src/runtime/feature/src/dfx/atrace_log.cc
    ${TOP_DIR}/src/runtime/feature/src/dfx/fp16_t.cpp
    ${TOP_DIR}/src/runtime/feature/src/dfx/hifloat.cpp
    ${TOP_DIR}/src/runtime/feature/src/dfx/printf.cc
    ${TOP_DIR}/src/runtime/feature/src/dfx/pctrace.cc
    ${TOP_DIR}/src/runtime/feature/src/utils/subscribe.cc
    ${TOP_DIR}/src/runtime/feature/src/profiler/onlineprof.cc
    ${TOP_DIR}/src/runtime/feature/src/device/device_error_proc.cc
    ${TOP_DIR}/src/runtime/feature/src/device/v200_base/device_error_proc.cc
    ${TOP_DIR}/src/runtime/feature/src/device/device_error_core_proc
    ${TOP_DIR}/src/runtime/feature/src/task/stars_cond_isa_helper.cc
    ${TOP_DIR}/src/runtime/feature/src/task/v201/stars_dqs_cond_isa_helper.cc
    ${TOP_DIR}/src/runtime/feature/src/common/thread_local_container.cc
    ${TOP_DIR}/src/runtime/feature/src/common/inner_thread_local.cpp
    ${TOP_DIR}/src/runtime/feature/src/utils/aicpu_scheduler_agent.cc
    ${TOP_DIR}/src/runtime/feature/src/device/device_msg_handler.cc
    ${TOP_DIR}/src/runtime/feature/src/task/host_task.cc
    ${TOP_DIR}/src/runtime/feature/src/stream/dvpp_grp.cc
    ${TOP_DIR}/src/runtime/feature/src/api/inner.cc
    ${TOP_DIR}/src/runtime/feature/src/task/task_to_sqe.cc
    ${TOP_DIR}/src/runtime/feature/src/drv/npu_driver_tiny.cpp
    ${TOP_DIR}/src/runtime/feature/src/engine/engine.cc
    ${TOP_DIR}/src/runtime/feature/src/engine/hwts/package_rebuilder.cc
    ${TOP_DIR}/src/runtime/feature/src/engine/stars/stars_engine.cc
    ${TOP_DIR}/src/runtime/feature/src/engine/hwts/hwts_engine.cc
    ${TOP_DIR}/src/runtime/feature/src/engine/hwts/async_hwts_engine.cc
    ${TOP_DIR}/src/runtime/feature/src/engine/hwts/direct_hwts_engine.cc
    ${TOP_DIR}/src/runtime/feature/src/engine/engine_factory.cc
    ${TOP_DIR}/src/runtime/feature/src/engine/hwts/shm_cq.cc
    ${runtimeut_src_common_list}
    ${runtimeut_platform_list}
    ${TOP_DIR}/src/runtime/feature/src/common/ioctl/v201/ioctl_utils.cc
)

add_executable(runtime_utest_task_v201
    ${runtimeut_v201_src_list}
    ${TOP_DIR}/src/runtime/feature/src/drv/npu_driver.cc
    ${TOP_DIR}/src/runtime/feature/src/drv/npu_driver_mem.cc
    ${TOP_DIR}/src/runtime/feature/src/drv/npu_driver_queue.cc
    ${TOP_DIR}/src/runtime/feature/src/drv/npu_driver_res.cc
    ${TOP_DIR}/src/runtime/feature/src/drv/npu_driver_standard_soc.cc
    stub/hal_stub.cc
    test/main.cc
    test/platform/others/rt_utest_v201_task.cc
)

target_include_directories(
    runtime_utest_task_v201 PUBLIC
    ${RUNTIME_DIR}/src/inc/runtime 
    ${TOP_DIR}/src/runtime/tprt/inc/external
    ${TOP_DIR}/src/runtime/tprt/feature/inc
    ${TOP_DIR}/abl/slog/inc
    ${TOP_DIR}/abl/mmpa/inc
    ${TOP_DIR}/abl/libc_sec/include
)

target_compile_options(runtime_utest_task_v201 PUBLIC
    -fno-access-control
)

target_compile_definitions(runtime_utest_task_v201 PUBLIC
    TEMP_PERFORMANCE
    TEMP_PERFORMANCE_NOT_OUTPUT
)

target_link_libraries(runtime_utest_task_v201 PRIVATE
    $<BUILD_INTERFACE:runtime_utest_v201_intf_pub>
    -Wl,--whole-archive
     runtime_ut_stub_static_lib
    -Wl,--no-whole-archive
)

add_library(runtime_utest_v201_intf_pub INTERFACE)

target_compile_definitions(runtime_utest_v201_intf_pub INTERFACE
    __RUNTIME_PRODUCT_DRV_MINI__
    FEATURE_NOTIFY
    FEATURE_PCTRACE
    FEATURE_DEBUG
    CFG_DEV_PLATFORM_PC
    STATIC_RT_LIB
    TEMP_PERFORMANCE
    TEMP_PERFORMANCE_NOT_OUTPUT
)

set(RUNTIME_V201_INC_DIR
    ${RUNTIME_TEST_INC_DIR_COMMON}
    ${TOP_DIR}/src/runtime/feature/inc/sqe/v201
    ${TOP_DIR}/src/runtime/feature/inc/cond_isa/v201
    ${TOP_DIR}/src/runtime/feature/src/task/inc/v201
    ${TOP_DIR}/src/runtime/feature/src/api_impl/v201
    ${TOP_DIR}/src/runtime/feature/src/stream/v201
    ${TOP_DIR}/src/runtime/feature/src/common/ioctl/v201
)

target_include_directories(runtime_utest_v201_intf_pub INTERFACE
    ${RUNTIME_V201_INC_DIR}
)

target_compile_options(runtime_utest_v201_intf_pub INTERFACE
    -Wformat
    -Wall
    -Werror
    -Wextra
)

target_link_libraries(runtime_utest_v201_intf_pub INTERFACE
    mmpa
    json
    c_sec
    rt
    $<BUILD_INTERFACE:intf_llt_pub>
    $<BUILD_INTERFACE:mmpa_headers>
    $<BUILD_INTERFACE:c_sec_headers>
    $<BUILD_INTERFACE:msprof_headers>
    $<BUILD_INTERFACE:slog_headers>
    $<BUILD_INTERFACE:npu_runtime_headers>
)

target_link_options(runtime_utest_v201_intf_pub INTERFACE
    -Wl,--wrap=malloc,-lrt
    -rdynamic
)
###################################################################################################
add_executable(runtime_utest_api_normal
    ${runtime_raw_device_adpt_common_list}
    ${TOP_DIR}/src/runtime/feature/src/drv/npu_driver.cc
    ${TOP_DIR}/src/runtime/feature/src/drv/npu_driver_mem.cc
    ${TOP_DIR}/src/runtime/feature/src/drv/npu_driver_queue.cc
    ${TOP_DIR}/src/runtime/feature/src/drv/npu_driver_res.cc
    ${TOP_DIR}/src/runtime/feature/src/drv/npu_driver_dcache_lock_opb.cpp
    ${TOP_DIR}/src/runtime/feature/src/drv/npu_driver_standard_soc.cc
    ${TOP_DIR}/src/runtime/feature/src/drv/v100/npu_driver.cc
    ${TOP_DIR}/src/runtime/feature/src/kernel/v100/kernel.cc
    ${TOP_DIR}/src/runtime/feature/src/task/v100/stub_task.cc
    stub/hal_stub.cc
    test/main.cc
    test/rt_utest_api_common_defination.cc
    #test/rt_utest_api.cc
    test/rt_utest_engine.cc
)

target_compile_definitions(runtime_utest_api_normal PUBLIC
    TEMP_PERFORMANCE
    TEMP_PERFORMANCE_NOT_OUTPUT
)

target_link_libraries(runtime_utest_api_normal PRIVATE
    $<BUILD_INTERFACE:runtime_utest_intf_pub>
    -Wl,--whole-archive
     runtimeut_src_static_lib
     runtime_ut_stub_static_lib
    -Wl,--no-whole-archive
    -lgcov
)
###################################################################################################
add_executable(runtime_utest_api_others
    ${runtime_raw_device_adpt_common_list}
    ${TOP_DIR}/src/runtime/feature/src/drv/npu_driver.cc
    ${TOP_DIR}/src/runtime/feature/src/drv/npu_driver_mem.cc
    ${TOP_DIR}/src/runtime/feature/src/drv/npu_driver_queue.cc
    ${TOP_DIR}/src/runtime/feature/src/drv/npu_driver_res.cc
    ${TOP_DIR}/src/runtime/feature/src/drv/npu_driver_dcache_lock_opb.cpp
    ${TOP_DIR}/src/runtime/feature/src/drv/npu_driver_standard_soc.cc
    ${TOP_DIR}/src/runtime/feature/src/drv/v100/npu_driver.cc
    ${TOP_DIR}/src/runtime/feature/src/kernel/v100/kernel.cc
    ${TOP_DIR}/src/runtime/feature/src/task/v100/stub_task.cc
    stub/hal_stub.cc
    test/main.cc
    test/rt_utest_api_common_defination.cc
    test/platform/others/rt_utest_api.cc
    test/platform/others/rt_api_dc_disable_thread_offline_test.cc
    test/platform/others/rt_api_dc_disable_thread_test.cc
    test/platform/others/rt_utest_stars_engine.cc
    test/platform/others/rt_utest_api_cloud_disable_thread.cc
    test/platform/others/rt_utest_api_event_notify.cc
    test/platform/others/rt_utest_event_cloud_v2.cc
    test/platform/others/rt_utest_api_others.cc
)

target_compile_definitions(runtime_utest_api_others PUBLIC
    TEMP_PERFORMANCE
    TEMP_PERFORMANCE_NOT_OUTPUT
)

target_link_libraries(runtime_utest_api_others PRIVATE
    $<BUILD_INTERFACE:runtime_utest_intf_pub>
    -Wl,--whole-archive
     runtimeut_src_static_lib
     runtime_ut_stub_static_lib
    -Wl,--no-whole-archive
)

###################################################################################################

include(CMakePackageConfigHelpers)

set(RUNTIME_TARGET
    runtime_utest_dfx
    runtime_utest_model
    runtime_utest_engine
    runtime_utest_task_v201
    runtime_utest_api_david
    runtime_utest_api_ext_others
    runtime_utest_tiny_stub
    runtime_utest
    runtime_utest_camodel
    runtime_camodel_utest_v200
    runtime_utest_task_910B
    runtime_utest_task_normal
    runtime_utest_task_david
    runtime_utest_xpu
    runtime_utest_dc
    runtime_utest_api_others
    runtime_utest_api_normal
    runtime_utest_api_910B
    runtime_utest_api
    runtime_utest_cloud
    runtime_utest_adc
    runtime_utest_mini_v3
)
add_custom_target(runtime_ut DEPENDS ${RUNTIME_TARGET})
include_directories(${OPEN_SOURCE_DIR}/mockcpp_src/include)
