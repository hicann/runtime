# -----------------------------------------------------------------------------------------------------------
# Copyright (c) 2025 Huawei Technologies Co., Ltd.
# This program is free software, you can redistribute it and/or modify it under the terms and conditions of
# CANN Open Software License Agreement Version 2.0 (the "License").
# Please refer to the License for details. You may not use this file except in compliance with the License.
# THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
# INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
# See LICENSE in the root of the software repository for the full text of the License.
# -----------------------------------------------------------------------------------------------------------
include_guard(GLOBAL)
include(${RUNTIME_DIR}/pkg_inc/runtime/runtime/runtime_headers.cmake)

set(libruntime_cmodel_v100_task_src_files
    ${RUNTIME_CORE_DIR}/src/task/task.cc
    ${RUNTIME_CORE_DIR}/src/task/task_submit/v100/task_submit.cc
    ${RUNTIME_CORE_DIR}/src/task/task_res_manage/task_res.cc
    ${RUNTIME_CORE_DIR}/src/task/task_info/task_manager.cc
    ${RUNTIME_CORE_DIR}/src/task/task_info/task_info.cc
    ${RUNTIME_CORE_DIR}/src/task/task_info/model/model_execute_task_info.cc
    ${RUNTIME_CORE_DIR}/src/task/task_info/davinci_kernel_task.cc
    ${RUNTIME_CORE_DIR}/src/task/task_info/event_task.cc
    ${RUNTIME_CORE_DIR}/src/task/task_info/memory_task.cc
    ${RUNTIME_CORE_DIR}/src/task/task_info/reduce_task.cc
    ${RUNTIME_CORE_DIR}/src/task/task_info/cond_op/cond_op_label_task.cc
    ${RUNTIME_CORE_DIR}/src/task/task_info/cond_op/cond_op_stream_task.cc
    ${RUNTIME_CORE_DIR}/src/task/task_info/profiling_task.cc
    ${RUNTIME_CORE_DIR}/src/task/task_info/dump_task.cc
    ${RUNTIME_CORE_DIR}/src/task/task_info/stream/stream_task.cc
    ${RUNTIME_CORE_DIR}/src/task/task_execute_time.cc
    ${RUNTIME_CORE_DIR}/src/task/task_info/davinci_multiple_task.cc
    ${RUNTIME_CORE_DIR}/src/task/task_info/stars_common_task.cc
    ${RUNTIME_CORE_DIR}/src/task/task_info/random_num_task.cc
    ${RUNTIME_CORE_DIR}/src/task/task_info/barrier_task.cc
    ${RUNTIME_CORE_DIR}/src/task/task_info/cmo_task.cc
    ${RUNTIME_CORE_DIR}/src/task/task_info/model/model_maintaince_task.cc
    ${RUNTIME_CORE_DIR}/src/task/task_info/notify_record_task.cc
    ${RUNTIME_CORE_DIR}/src/task/task_info/timeout_set_task.cc
    ${RUNTIME_CORE_DIR}/src/task/task_info/ringbuffer_maintain_task.cc
    ${RUNTIME_CORE_DIR}/src/task/task_info/model/model_update_task.cc
    ${RUNTIME_CORE_DIR}/src/task/task_info/end_graph_task.cc
    ${RUNTIME_CORE_DIR}/src/task/task_info/model/model_to_aicpu_task.cc
    ${RUNTIME_CORE_DIR}/src/task/task_info/maintenance_task.cc

    ${RUNTIME_CORE_DIR}/src/task/v100/davinci_task.cc
    ${RUNTIME_CORE_DIR}/src/task/v100/task_proc_func_register.cc
    ${RUNTIME_CORE_DIR}/src/task/v100/task_checker.cc
    ${RUNTIME_CORE_DIR}/src/task/v100/memory_task.cc
    ${RUNTIME_CORE_DIR}/src/launch/memcpy_stars.cc
    ${RUNTIME_CORE_DIR}/src/launch/dvpp_stars.cc
)

set(david_series_common_task_src_file_cmodel
    ${RUNTIME_CORE_DIR}/src/task/task.cc
    ${RUNTIME_CORE_DIR}/src/task/task_submit/v100/task_submit.cc
    ${RUNTIME_CORE_DIR}/src/task/task_res_manage/task_res.cc
    ${RUNTIME_CORE_DIR}/src/task/task_info/task_manager.cc
    ${RUNTIME_CORE_DIR}/src/task/task_info/task_info.cc
    ${RUNTIME_CORE_DIR}/src/task/task_info/model/model_execute_task_info.cc
    ${RUNTIME_CORE_DIR}/src/task/task_info/davinci_kernel_task.cc
    ${RUNTIME_CORE_DIR}/src/task/task_info/event_task.cc
    ${RUNTIME_CORE_DIR}/src/task/task_info/david_event_task.cc
    ${RUNTIME_CORE_DIR}/src/task/task_info/memory_task.cc
    ${RUNTIME_CORE_DIR}/src/task/task_info/reduce_task.cc
    ${RUNTIME_CORE_DIR}/src/task/task_info/cond_op/cond_op_label_task.cc
    ${RUNTIME_CORE_DIR}/src/task/task_info/cond_op/cond_op_stream_task.cc
    ${RUNTIME_CORE_DIR}/src/task/task_info/profiling_task.cc
    ${RUNTIME_CORE_DIR}/src/task/task_info/dump_task.cc
    ${RUNTIME_CORE_DIR}/src/task/task_info/stream/stream_task.cc
    ${RUNTIME_CORE_DIR}/src/task/task_execute_time.cc
    ${RUNTIME_CORE_DIR}/src/task/task_info/davinci_multiple_task.cc
    ${RUNTIME_CORE_DIR}/src/task/task_info/stars_common_task.cc
    ${RUNTIME_CORE_DIR}/src/task/task_info/random_num_task.cc
    ${RUNTIME_CORE_DIR}/src/task/task_info/barrier_task.cc
    ${RUNTIME_CORE_DIR}/src/task/task_info/cmo_task.cc
    ${RUNTIME_CORE_DIR}/src/task/task_info/ubdma_task_david.cc
    ${RUNTIME_CORE_DIR}/src/task/task_info/cond_op/cond_op_task_david.cc
    ${RUNTIME_CORE_DIR}/src/task/task_info/model/model_maintaince_task.cc
    ${RUNTIME_CORE_DIR}/src/task/task_info/notify_record_task.cc
    ${RUNTIME_CORE_DIR}/src/task/task_info/timeout_set_task.cc
    ${RUNTIME_CORE_DIR}/src/task/task_info/ringbuffer_maintain_task.cc
    ${RUNTIME_CORE_DIR}/src/task/task_info/model/model_update_task.cc
    ${RUNTIME_CORE_DIR}/src/task/task_info/model/model_update_task_david.cc
    ${RUNTIME_CORE_DIR}/src/task/task_info/notify/notify_task_david.cc
    ${RUNTIME_CORE_DIR}/src/task/task_info/end_graph_task.cc
    ${RUNTIME_CORE_DIR}/src/task/task_info/model/model_to_aicpu_task.cc
    ${RUNTIME_CORE_DIR}/src/task/task_info/maintenance_task.cc
    ${RUNTIME_CORE_DIR}/src/task/task_recycle/v200/task_recycle_dvpp.cc
    ${RUNTIME_CORE_DIR}/src/task/task_submit/v200/task_david.cc
    ${RUNTIME_CORE_DIR}/src/task/task_recycle/v200/task_recycle_send_sync.cc
    ${RUNTIME_CORE_DIR}/src/task/task_res_manage/v200/task_res_da.cc
    ${RUNTIME_CORE_DIR}/src/task/task_recycle/v200/task_recycle.cc
    ${RUNTIME_CORE_DIR}/src/task/task_recycle/v200/task_recycle_common_base.cc
    ${RUNTIME_CORE_DIR}/src/task/task_recycle/v200/task_recycle_cqrpt_base.cc
    ${RUNTIME_CORE_DIR}/src/task/task_info/task_manager_david.cc
    ${RUNTIME_CORE_DIR}/src/task/v200_base/davinci_task.cc
    ${RUNTIME_CORE_DIR}/src/task/v200_base/davinci_task_launch_config.cc
    ${RUNTIME_CORE_DIR}/src/task/v200_base/memcpy_sqe_common_proc.cc
    ${RUNTIME_CORE_DIR}/src/task/v200_base/aicpu_sqe_common_proc.cc
    ${RUNTIME_CORE_DIR}/src/task/v200_base/memory_task.cc
)

set(libruntime_cmodel_v200_task_src_files
    ${david_series_common_task_src_file_cmodel}

    # david & solomon 专用差异化文件
    ${RUNTIME_CORE_DIR}/src/task/v200_base/task_proc_func_register.cc
    ${RUNTIME_CORE_DIR}/src/task/v200/memcpy_task_to_sqe.cc
    ${RUNTIME_CORE_DIR}/src/task/v200/task_checker.cc
    ${RUNTIME_CORE_DIR}/src/task/v200/aicpu_task_to_sqe.cc
    ${RUNTIME_CORE_DIR}/src/task/v200/notify_task_to_sqe.cc
)

set(libruntime_cmodel_api_src_files_cmodel
    ${RUNTIME_DIR}/src/runtime/api/api_c.cc
    ${RUNTIME_DIR}/src/runtime/api/api_c_context.cc
    ${RUNTIME_DIR}/src/runtime/api/api_c_device.cc
    ${RUNTIME_DIR}/src/runtime/api/api_c_kernel.cc
    ${RUNTIME_DIR}/src/runtime/api/api_c_memory.cc
    ${RUNTIME_DIR}/src/runtime/api/api_c_stream.cc
    ${RUNTIME_DIR}/src/runtime/api/api_c_task.cc
    ${RUNTIME_DIR}/src/runtime/api/api_c_model.cc
    ${RUNTIME_DIR}/src/runtime/api/api_c_event.cc
    ${RUNTIME_DIR}/src/runtime/api/api_c_mbuf.cc
    ${RUNTIME_DIR}/src/runtime/api/inner.cc
    ${RUNTIME_DIR}/src/runtime/api/api_global_err.cc
    ${RUNTIME_DIR}/src/runtime/api/api_c_soc.cc
)

set(common_src_files_cmodel
    ${RUNTIME_CORE_DIR}/src/common/error_code.cc
    ${RUNTIME_CORE_DIR}/src/common/thread_local_container.cc
    ${RUNTIME_CORE_DIR}/src/common/utils.cc
    ${RUNTIME_CORE_DIR}/src/common/heterogenous.cc
    ${RUNTIME_CORE_DIR}/src/common/soc_info.cc
    ${RUNTIME_CORE_DIR}/src/common/context_data_manage.cc
    ${RUNTIME_CORE_DIR}/src/common/profiling_agent.cc
    ${RUNTIME_CORE_DIR}/src/common/errcode_manage.cc
    ${RUNTIME_CORE_DIR}/src/common/error_message_manage.cc
    ${RUNTIME_CORE_DIR}/src/common/task_fail_callback_data_manager.cc
    ${RUNTIME_FEATURE_DIR}/xpu/xpu_task_fail_callback_data_manager.cc
    ${RUNTIME_CORE_DIR}/src/common/performance_record.cc
    ${RUNTIME_CORE_DIR}/src/common/prof_ctrl_callback_manager.cc
    ${RUNTIME_CORE_DIR}/src/common/rt_log.cc
    ${RUNTIME_CORE_DIR}/src/common/dev_info_manage.cc
    ${RUNTIME_CORE_DIR}/src/common/global_state_manager.cc
    ${RUNTIME_CORE_DIR}/src/common/register_memory.cc
    ${RUNTIME_CORE_DIR}/src/launch/label_common.cc
    ${RUNTIME_CORE_DIR}/src/launch/cmo_barrier_common.cc
)

set(libruntime_cmodel_context_src_files
    ${RUNTIME_CORE_DIR}/src/context/context.cc
    ${RUNTIME_CORE_DIR}/src/context/context_manage.cc
    ${RUNTIME_CORE_DIR}/src/context/context_protect.cc
)

set(libruntime_cmodel_stream_common_src_files
    ${RUNTIME_CORE_DIR}/src/stream/stream_sqcq_manage.cc
    ${RUNTIME_CORE_DIR}/src/stream/engine_stream_observer.cc
    ${RUNTIME_CORE_DIR}/src/stream/stream.cc
    ${RUNTIME_CORE_DIR}/src/stream/ctrl_stream.cc
    ${RUNTIME_CORE_DIR}/src/stream/coprocessor_stream.cc
    ${RUNTIME_CORE_DIR}/src/stream/tsch_stream.cc
    ${RUNTIME_CORE_DIR}/src/stream/stream_factory.cc
)

# v100
set(libruntime_cmodel_stream_src_files
    ${libruntime_cmodel_stream_common_src_files}

    ${RUNTIME_CORE_DIR}/src/stream/v100/stream_creator_c.cc
)

# david
set(libruntime_cmodel_v200_stream_src_files
    ${libruntime_cmodel_stream_common_src_files}

    ${RUNTIME_CORE_DIR}/src/stream/stream_c.cc
    ${RUNTIME_CORE_DIR}/src/stream/stream_david.cc
    ${RUNTIME_CORE_DIR}/src/stream/v200/stream_creator_c.cc
)

set(libruntime_cmodel_profile_src_files
    ${RUNTIME_CORE_DIR}/src/profiler/profiler.cc
    ${RUNTIME_CORE_DIR}/src/profiler/api_profile_decorator.cc
    ${RUNTIME_CORE_DIR}/src/profiler/api_profile_log_decorator.cc
    ${RUNTIME_CORE_DIR}/src/profiler/prof_map_ge_model_device.cc
    ${RUNTIME_CORE_DIR}/src/profiler/profile_log_record.cc
    ${RUNTIME_CORE_DIR}/src/profiler/npu_driver_record.cc
)
set(libruntime_cmodel_arg_loader_files
    ${RUNTIME_CORE_DIR}/src/kernel/arg_loader/uma_arg_loader.cc
)

set(libruntime_cmodel_callback_files
    ${RUNTIME_CORE_DIR}/src/device/device_state_callback_manager.cc
    ${RUNTIME_CORE_DIR}/src/task/task_fail_callback_manager.cc
    ${RUNTIME_CORE_DIR}/src/stream/stream_state_callback_manager.cc
    ${RUNTIME_CORE_DIR}/src/event/event_state_callback_manager.cc
)

#------------------------- exclude these files in tiny(ascend031) ---------------------
set(libruntime_cmodel_src_files_optional
    ${RUNTIME_CORE_DIR}/src/api_impl/api_error_standard_soc.cc
    ${RUNTIME_CORE_DIR}/src/api_impl/api_impl_standard_soc.cc
    ${RUNTIME_CORE_DIR}/src/api_impl/api_impl_soma.cc
    ${RUNTIME_CORE_DIR}/src/api_impl/api_error_uvm.cc
    ${RUNTIME_CORE_DIR}/src/api_impl/api_impl_uvm.cc
    ${RUNTIME_CORE_DIR}/src/context/context_standard_soc.cc
    ${RUNTIME_CORE_DIR}/src/dfx/fp16_t.cpp
    ${RUNTIME_CORE_DIR}/src/dfx/hifloat.cpp
    ${RUNTIME_CORE_DIR}/src/dfx/printf.cc
    ${RUNTIME_CORE_DIR}/src/dfx/kernel_dfx_info.cc
    ${RUNTIME_DIR}/src/runtime/driver/npu_driver_standard_soc.cc
    ${RUNTIME_CORE_DIR}/src/engine/hwts/direct_hwts_engine.cc
    ${RUNTIME_CORE_DIR}/src/engine/hwts/hwts_engine.cc
    ${RUNTIME_CORE_DIR}/src/engine/hwts/async_hwts_engine.cc
    ${RUNTIME_CORE_DIR}/src/engine/hwts/shm_cq.cc
    ${RUNTIME_CORE_DIR}/src/engine/engine_factory.cc
    ${RUNTIME_CORE_DIR}/src/kernel/binary_loader.cc
    ${RUNTIME_CORE_DIR}/src/kernel/json_parse.cc
    ${RUNTIME_CORE_DIR}/src/profiler/api_profile_decorator_standard_soc.cc
    ${RUNTIME_CORE_DIR}/src/profiler/api_profile_log_decoratoc_standard_soc.cc
    ${RUNTIME_CORE_DIR}/src/task/task_to_sqe.cc
    ${RUNTIME_CORE_DIR}/src/task/task_info/rdma_task.cc
    ${RUNTIME_CORE_DIR}/src/task/task_info/ffts_task.cc
    ${RUNTIME_CORE_DIR}/src/event/ipc_event.cc
    ${RUNTIME_CORE_DIR}/src/event/ipc_event_starsV2.cc
    ${RUNTIME_CORE_DIR}/src/pool/event_expanding.cc
    ${RUNTIME_CORE_DIR}/src/pool/event_pool.cc
)

set(libruntime_cmodel_api_src_files
    ${RUNTIME_DIR}/src/runtime/api/api_c_standard_soc.cc
    ${RUNTIME_DIR}/src/runtime/api/api_c_soma.cc
    ${RUNTIME_DIR}/src/runtime/api/api_c_xpu.cc
    ${RUNTIME_DIR}/src/runtime/api/api_preload_task.cc
    ${RUNTIME_DIR}/src/runtime/api/api_c_dqs.cc
    ${RUNTIME_DIR}/src/runtime/api/api_c_snapshot.cc
    ${RUNTIME_DIR}/src/runtime/api/api_david.cc
    ${RUNTIME_DIR}/src/runtime/api/api_c_uvm.cc
)

set(xpu_tprt_api_file
    ${RUNTIME_FEATURE_DIR}/xpu/api_error_xpu.cc
    ${RUNTIME_CORE_DIR}/src/api_impl/v100/api_impl_v100.cc
    ${RUNTIME_FEATURE_DIR}/xpu/api_decorator_xpu.cc
)

set(libruntime_cmodel_src_files
    ${RUNTIME_CORE_DIR}/src/common/inner_thread_local.cpp
    ${RUNTIME_DIR}/src/runtime/api/api.cc
    ${RUNTIME_DIR}/src/runtime/api/api_global_err.cc
    ${RUNTIME_CORE_DIR}/src/api_impl/api_decorator.cc
    ${RUNTIME_CORE_DIR}/src/api_impl/api_error.cc
    ${RUNTIME_CORE_DIR}/src/api_impl/api_impl.cc
    ${RUNTIME_CORE_DIR}/src/api_impl/api_impl_mbuf.cc
    ${RUNTIME_CORE_DIR}/src/uvm/uvm_callback.cc

    # for V100
    ${RUNTIME_CORE_DIR}/src/api_impl/api_impl_creator.cc
    ${RUNTIME_CORE_DIR}/src/api_impl/v100/api_impl_creator_c.cc
    ${RUNTIME_CORE_DIR}/src/device/ctrl_msg.cc
    ${RUNTIME_CORE_DIR}/src/device/ctrl_sq.cc
    ${RUNTIME_DIR}/src/runtime/driver/v100/
    ${RUNTIME_CORE_DIR}/src/config.cc
    ${RUNTIME_CORE_DIR}/src/device/device.cc
    ${RUNTIME_CORE_DIR}/src/device/raw_device.cc
    ${RUNTIME_CORE_DIR}/src/device/raw_device_res_camodel.cc
    ${RUNTIME_FEATURE_DIR}/snapshot/device_snapshot.cc
    ${RUNTIME_FEATURE_DIR}/snapshot/snapshot_process_helper.cc
    ${RUNTIME_CORE_DIR}/src/device/raw_device_adpt_comm.cc
    ${RUNTIME_DIR}/src/runtime/driver/driver.cc
    ${RUNTIME_DIR}/src/runtime/driver/v100/npu_driver.cc
    ${RUNTIME_CORE_DIR}/src/pool/bitmap.cc
    ${RUNTIME_CORE_DIR}/src/pool/buffer_allocator.cc
    ${RUNTIME_CORE_DIR}/src/pool/task_allocator.cc
    ${RUNTIME_CORE_DIR}/src/pool/spm_pool.cc
    ${RUNTIME_CORE_DIR}/src/pool/h2d_copy_mgr.cc
    ${RUNTIME_CORE_DIR}/src/pool/memory_list.cc
    ${RUNTIME_CORE_DIR}/src/pool/memory_pool.cc
    ${RUNTIME_CORE_DIR}/src/pool/memory_pool_manager.cc
    ${RUNTIME_CORE_DIR}/src/model/model.cc
    ${RUNTIME_CORE_DIR}/src/model/model_rebuild.cc
    ${RUNTIME_CORE_DIR}/src/model/capture_model.cc
    ${RUNTIME_CORE_DIR}/src/model/capture_model_utils.cc
    ${RUNTIME_CORE_DIR}/src/model/v100/capture_adapt.cc
    ${RUNTIME_CORE_DIR}/src/model/v100/capture_model_adapt.cc
    ${RUNTIME_CORE_DIR}/src/kernel/args/args_handle_allocator.cc
    ${RUNTIME_CORE_DIR}/src/kernel/args/para_convertor.cc
    ${RUNTIME_CORE_DIR}/src/kernel/v100/kernel.cc
    ${RUNTIME_CORE_DIR}/src/kernel/v100/program_plat.cc
    ${RUNTIME_CORE_DIR}/src/kernel/elf.cc
    ${RUNTIME_CORE_DIR}/src/kernel/kernel.cc
    ${RUNTIME_CORE_DIR}/src/kernel/module.cc
    ${RUNTIME_CORE_DIR}/src/kernel/program.cc
    ${RUNTIME_CORE_DIR}/src/kernel/program_common.cc
    ${RUNTIME_CORE_DIR}/src/kernel/kernel_utils.cc
    ${RUNTIME_FEATURE_DIR}/soma/soma.cc
    ${RUNTIME_FEATURE_DIR}/soma/stream_mem_pool.cc
    ${RUNTIME_CORE_DIR}/src/launch/label.cc
    ${RUNTIME_CORE_DIR}/src/launch/aicpu_stars.cc
    ${RUNTIME_CORE_DIR}/src/event/event.cc
    ${RUNTIME_CORE_DIR}/src/notify/notify.cc
    ${RUNTIME_CORE_DIR}/src/engine/logger.cc
    ${RUNTIME_CORE_DIR}/src/runtime.cc
    ${RUNTIME_CORE_DIR}/src/runtime_v100/runtime_adapt.cc
    ${RUNTIME_CORE_DIR}/src/plugin_manage/runtime_keeper.cc
    ${RUNTIME_CORE_DIR}/src/utils/capability.cc
    ${RUNTIME_CORE_DIR}/src/utils/osal.cc
    ${RUNTIME_CORE_DIR}/src/engine/hwts/scheduler.cc
    ${RUNTIME_CORE_DIR}/src/dfx/atrace_log.cc
    ${RUNTIME_CORE_DIR}/src/dfx/pctrace.cc
    ${RUNTIME_CORE_DIR}/src/utils/subscribe.cc
    ${RUNTIME_CORE_DIR}/src/profiler/onlineprof.cc
    ${RUNTIME_CORE_DIR}/src/ttlv/ttlv_decoder_utils.cc
    ${RUNTIME_CORE_DIR}/src/ttlv/ttlv.cc
    ${RUNTIME_CORE_DIR}/src/ttlv/ttlv_word_decoder.cc
    ${RUNTIME_CORE_DIR}/src/ttlv/ttlv_sentence_decoder.cc
    ${RUNTIME_CORE_DIR}/src/ttlv/ttlv_paragraph_decoder.cc
    ${RUNTIME_CORE_DIR}/src/device/device_error_core_proc.cc
    ${RUNTIME_CORE_DIR}/src/device/device_error_proc.cc
    ${RUNTIME_CORE_DIR}/src/device/v100/device_error_proc.cc
    ${RUNTIME_CORE_DIR}/src/device/device_sq_cq_pool.cc
    ${RUNTIME_CORE_DIR}/src/device/sq_addr_memory_pool.cc
    ${RUNTIME_CORE_DIR}/src/utils/aicpu_scheduler_agent.cc
    ${RUNTIME_CORE_DIR}/src/device/device_msg_handler.cc
    ${RUNTIME_CORE_DIR}/src/device/aicpu_err_msg.cc
    ${RUNTIME_CORE_DIR}/src/stream/dvpp_grp.cc
    ${RUNTIME_CORE_DIR}/src/engine/engine.cc
    ${RUNTIME_CORE_DIR}/src/engine/hwts/package_rebuilder.cc
    ${RUNTIME_CORE_DIR}/src/engine/stars/stars_engine.cc
    ${RUNTIME_CORE_DIR}/src/task/ctrl_res_pool.cpp
    ${RUNTIME_CORE_DIR}/src/task/host_task.cc
    ${RUNTIME_CORE_DIR}/src/task/stars_cond_isa_helper.cc
    ${RUNTIME_CORE_DIR}/src/task/v100/stub_task.cc
    ${RUNTIME_CORE_DIR}/src/launch/cond_stars.cc
    ${RUNTIME_CORE_DIR}/src/launch/label_stars.cc
    ${RUNTIME_CORE_DIR}/src/launch/cmo_barrier_stars.cc
    ${RUNTIME_CORE_DIR}/src/memory/mem_type.cc
    ${libruntime_cmodel_v100_task_src_files}
    ${libruntime_cmodel_api_src_files}
    ${libruntime_cmodel_context_src_files}
    ${libruntime_cmodel_stream_src_files}
    ${libruntime_cmodel_profile_src_files}
    ${libruntime_cmodel_arg_loader_files}
    ${libruntime_cmodel_callback_files}
    ${common_src_files_cmodel}
    ${libruntime_cmodel_src_files_optional}
    ${libruntime_cmodel_api_src_files_cmodel}
    ${xpu_tprt_api_file}
)

set(libruntime_cmodel_v200_src_files
    ${RUNTIME_CORE_DIR}/src/common/inner_thread_local.cpp
    ${RUNTIME_DIR}/src/runtime/api/api.cc
    ${RUNTIME_CORE_DIR}/src/api_impl/api_decorator.cc
    ${RUNTIME_CORE_DIR}/src/api_impl/api_error.cc
    ${RUNTIME_CORE_DIR}/src/api_impl/api_impl.cc
    ${RUNTIME_CORE_DIR}/src/api_impl/api_impl_mbuf.cc
    ${RUNTIME_CORE_DIR}/src/api_impl/api_impl_david.cc
    ${RUNTIME_CORE_DIR}/src/uvm/uvm_callback.cc

    # for V200
    ${RUNTIME_CORE_DIR}/src/api_impl/api_impl_creator.cc
    ${RUNTIME_CORE_DIR}/src/api_impl/v200/api_impl_creator_c.cc

    ${RUNTIME_CORE_DIR}/src/config.cc
    ${RUNTIME_CORE_DIR}/src/context/context.cc
    ${RUNTIME_CORE_DIR}/src/device/device.cc
    ${RUNTIME_CORE_DIR}/src/device/raw_device.cc
    ${RUNTIME_CORE_DIR}/src/device/raw_device_res_camodel.cc
    ${RUNTIME_FEATURE_DIR}/snapshot/device_snapshot.cc
    ${RUNTIME_FEATURE_DIR}/snapshot/snapshot_process_helper.cc
    ${RUNTIME_CORE_DIR}/src/device/raw_device_adpt_david.cc
    ${RUNTIME_CORE_DIR}/src/device/ctrl_msg.cc
    ${RUNTIME_CORE_DIR}/src/device/ctrl_sq.cc
    ${RUNTIME_CORE_DIR}/src/pool/bitmap.cc
    ${RUNTIME_CORE_DIR}/src/pool/buffer_allocator.cc
    ${RUNTIME_CORE_DIR}/src/pool/task_allocator.cc
    ${RUNTIME_CORE_DIR}/src/pool/spm_pool.cc
    ${RUNTIME_CORE_DIR}/src/pool/h2d_copy_mgr.cc
    ${RUNTIME_CORE_DIR}/src/pool/memory_list.cc
    ${RUNTIME_CORE_DIR}/src/pool/memory_pool.cc
    ${RUNTIME_CORE_DIR}/src/pool/memory_pool_manager.cc
    ${RUNTIME_DIR}/src/runtime/driver/driver.cc
    ${RUNTIME_DIR}/src/runtime/driver/v200/npu_driver.cc
    ${RUNTIME_CORE_DIR}/src/model/model.cc
    ${RUNTIME_CORE_DIR}/src/model/model_rebuild.cc
    ${RUNTIME_CORE_DIR}/src/model/capture_model.cc
    ${RUNTIME_CORE_DIR}/src/model/capture_model_utils.cc
    ${RUNTIME_CORE_DIR}/src/model/v200/capture_adapt.cc
    ${RUNTIME_CORE_DIR}/src/model/v200/capture_model_adapt.cc
    ${RUNTIME_CORE_DIR}/src/kernel/arg_loader/arg_loader_ub.cc
    ${RUNTIME_CORE_DIR}/src/kernel/arg_loader/arg_manage_david.cc
    ${RUNTIME_CORE_DIR}/src/kernel/arg_loader/arg_manage_pcie.cc
    ${RUNTIME_CORE_DIR}/src/kernel/arg_loader/arg_manage_ub.cc
    ${RUNTIME_CORE_DIR}/src/kernel/args/args_handle_allocator.cc
    ${RUNTIME_CORE_DIR}/src/kernel/args/para_convertor.cc
    ${RUNTIME_CORE_DIR}/src/kernel/v200_base/kernel.cc
    ${RUNTIME_CORE_DIR}/src/kernel/elf.cc
    ${RUNTIME_CORE_DIR}/src/kernel/kernel.cc
    ${RUNTIME_CORE_DIR}/src/kernel/v100/program_plat.cc
    ${RUNTIME_CORE_DIR}/src/kernel/module.cc
    ${RUNTIME_CORE_DIR}/src/kernel/program.cc
    ${RUNTIME_CORE_DIR}/src/kernel/program_common.cc
    ${RUNTIME_CORE_DIR}/src/kernel/kernel_utils.cc
    ${RUNTIME_FEATURE_DIR}/soma/soma.cc
    ${RUNTIME_FEATURE_DIR}/soma/stream_mem_pool.cc
    ${RUNTIME_CORE_DIR}/src/launch/label.cc
    ${RUNTIME_CORE_DIR}/src/event/event.cc
    ${RUNTIME_CORE_DIR}/src/event/event_david.cc
    ${RUNTIME_CORE_DIR}/src/notify/notify.cc
    ${RUNTIME_CORE_DIR}/src/engine/logger.cc
    ${RUNTIME_CORE_DIR}/src/runtime.cc
    ${RUNTIME_CORE_DIR}/src/runtime_v100/runtime_adapt.cc
    ${RUNTIME_CORE_DIR}/src/utils/capability.cc
    ${RUNTIME_CORE_DIR}/src/utils/osal.cc
    ${RUNTIME_CORE_DIR}/src/engine/hwts/scheduler.cc
    ${RUNTIME_CORE_DIR}/src/dfx/atrace_log.cc
    ${RUNTIME_CORE_DIR}/src/dfx/coredump_c.cc
    ${RUNTIME_CORE_DIR}/src/dfx/fast_recover.cc
    ${RUNTIME_CORE_DIR}/src/dfx/pctrace.cc
    ${RUNTIME_CORE_DIR}/src/utils/subscribe.cc
    ${RUNTIME_CORE_DIR}/src/profiler/onlineprof.cc
    ${RUNTIME_CORE_DIR}/src/ttlv/ttlv_decoder_utils.cc
    ${RUNTIME_CORE_DIR}/src/ttlv/ttlv.cc
    ${RUNTIME_CORE_DIR}/src/ttlv/ttlv_word_decoder.cc
    ${RUNTIME_CORE_DIR}/src/ttlv/ttlv_sentence_decoder.cc
    ${RUNTIME_CORE_DIR}/src/ttlv/ttlv_paragraph_decoder.cc
    ${RUNTIME_CORE_DIR}/src/device/device_error_core_proc.cc
    ${RUNTIME_CORE_DIR}/src/device/device_error_proc.cc
    ${RUNTIME_CORE_DIR}/src/device/v200_base/device_error_proc.cc
    ${RUNTIME_CORE_DIR}/src/device/device_sq_cq_pool.cc
    ${RUNTIME_CORE_DIR}/src/device/sq_addr_memory_pool.cc
    ${RUNTIME_CORE_DIR}/src/task/stars_cond_isa_helper.cc
    ${RUNTIME_CORE_DIR}/src/utils/aicpu_scheduler_agent.cc
    ${RUNTIME_CORE_DIR}/src/device/device_msg_handler.cc
    ${RUNTIME_CORE_DIR}/src/device/aicpu_err_msg.cc
    ${RUNTIME_CORE_DIR}/src/task/host_task.cc
    ${RUNTIME_CORE_DIR}/src/stream/dvpp_grp.cc
    ${RUNTIME_CORE_DIR}/src/task/ctrl_res_pool.cpp
    ${RUNTIME_CORE_DIR}/src/engine/engine.cc
    ${RUNTIME_CORE_DIR}/src/engine/hwts/package_rebuilder.cc
    ${RUNTIME_CORE_DIR}/src/engine/stars/stars_engine.cc
    ${RUNTIME_CORE_DIR}/src/engine/hwts/direct_hwts_engine.cc
    ${RUNTIME_CORE_DIR}/src/task/v200_base/stars_david.cc
    ${RUNTIME_FEATURE_DIR}/cntnotify/count_notify.cc
    ${RUNTIME_CORE_DIR}/src/launch/aix_c.cc
    ${RUNTIME_CORE_DIR}/src/launch/aicpu_starsv2.cc
    ${RUNTIME_CORE_DIR}/src/launch/fusion_c.cc
    ${RUNTIME_CORE_DIR}/src/launch/dvpp_starsv2.cc
    ${RUNTIME_CORE_DIR}/src/launch/cond_starsv2.cc
    ${RUNTIME_CORE_DIR}/src/launch/label_starsv2.cc
    ${RUNTIME_CORE_DIR}/src/launch/cmo_barrier_starsv2.cc
    ${RUNTIME_CORE_DIR}/src/device/v200_base/device_error_proc_c.cc
    ${RUNTIME_CORE_DIR}/src/event/event_c.cc
    ${RUNTIME_CORE_DIR}/src/launch/memcpy_starsv2.cc
    ${RUNTIME_CORE_DIR}/src/model/model_c.cc
    ${RUNTIME_CORE_DIR}/src/notify/notify_c.cc
    ${RUNTIME_CORE_DIR}/src/profiler/profiler_c.cc
    ${RUNTIME_CORE_DIR}/src/memory/mem_type.cc
    ${libruntime_cmodel_v200_task_src_files}
    ${libruntime_cmodel_api_src_files}
    ${libruntime_cmodel_context_src_files}
    ${libruntime_cmodel_v200_stream_src_files}
    ${libruntime_cmodel_profile_src_files}
    ${libruntime_cmodel_arg_loader_files}
    ${libruntime_cmodel_callback_files}
    ${RUNTIME_CORE_DIR}/src/plugin_manage/v200/plugin_old_arch.cc
    ${RUNTIME_CORE_DIR}/src/plugin_manage/runtime_keeper.cc
    ${common_src_files_cmodel}
    ${RUNTIME_CORE_DIR}/src/api_impl/v201/api_impl_v200_adapt.cc
    ${xpu_tprt_api_file}
    ${libruntime_cmodel_src_files_optional}
 	${libruntime_cmodel_api_src_files_cmodel}
)

set(RUNTIME_CMODEL_INC_DIR_COMMON
    ${RUNTIME_DIR}/src/runtime/inc
    ${RUNTIME_CORE_DIR}/inc_c
    ${RUNTIME_DIR}/src/runtime/inc/args
    ${RUNTIME_DIR}/src/runtime/inc/arg_loader
    ${RUNTIME_DIR}/src/runtime/inc/common
    ${RUNTIME_DIR}/src/runtime/inc/context
    ${RUNTIME_DIR}/src/runtime/inc/device
    ${RUNTIME_DIR}/src/runtime/inc/dfx
    ${RUNTIME_DIR}/src/runtime/inc/dqs
    ${RUNTIME_DIR}/src/runtime/inc/drv
    ${RUNTIME_DIR}/src/runtime/inc/engine
    ${RUNTIME_DIR}/src/runtime/inc/engine/hwts
    ${RUNTIME_DIR}/src/runtime/inc/event
    ${RUNTIME_DIR}/src/runtime/inc/kernel
    ${RUNTIME_DIR}/src/runtime/inc/launch
    ${RUNTIME_DIR}/src/runtime/inc/model
    ${RUNTIME_DIR}/src/runtime/inc/notify
    ${RUNTIME_DIR}/src/runtime/inc/profiler
    ${RUNTIME_DIR}/src/runtime/inc/soc
    ${RUNTIME_DIR}/src/runtime/inc/spec
    ${RUNTIME_DIR}/src/runtime/inc/sqe/v200_base
    ${RUNTIME_DIR}/src/runtime/inc/sqe
    ${RUNTIME_DIR}/src/runtime/inc/stars
    ${RUNTIME_DIR}/src/runtime/inc/stream
    ${RUNTIME_DIR}/src/runtime/inc/task
    ${RUNTIME_DIR}/src/runtime/inc/utils
    ${RUNTIME_DIR}/src/runtime/api
    ${RUNTIME_CORE_DIR}/src/api_impl
    ${RUNTIME_CORE_DIR}/src/engine
    ${RUNTIME_CORE_DIR}/src/engine/hwts
    ${RUNTIME_CORE_DIR}/src/engine/stars
    ${RUNTIME_CORE_DIR}/src/stream
    ${RUNTIME_CORE_DIR}/src/task/inc
    ${RUNTIME_CORE_DIR}/src/profiler
    ${RUNTIME_CORE_DIR}/src/pool
    ${RUNTIME_CORE_DIR}/src/ttlv
    ${RUNTIME_CORE_DIR}/src/device
    ${RUNTIME_DIR}/src/runtime/driver
    ${RUNTIME_CORE_DIR}/src/common
    ${RUNTIME_CORE_DIR}/src/plugin_manage
    ${RUNTIME_CORE_DIR}/src/kernel
    ${RUNTIME_CORE_DIR}/src/kernel/arg_loader
    ${RUNTIME_CORE_DIR}/src/kernel/args
    ${RUNTIME_CORE_DIR}/src/memory
    ${RUNTIME_FEATURE_DIR}/soma
    ${RUNTIME_FEATURE_DIR}/cntnotify
    ${RUNTIME_FEATURE_DIR}/snapshot
    ${RUNTIME_FEATURE_DIR}/xpu
    ${RUNTIME_CORE_DIR}/src/uvm
    ${RUNTIME_CORE_DIR}/src/event
    ${RUNTIME_DIR}/src/inc
    ${RUNTIME_DIR}/pkg_inc/tsd/
    ${RUNTIME_DIR}/pkg_inc/aicpu_sched/
    ${RUNTIME_DIR}/pkg_inc/aicpu_sched/common
    ${RUNTIME_DIR}/src/queue_schedule/dgwclient/inc/
    ${RUNTIME_DIR}/src/dfx/error_manager
    ${LIBC_SEC_HEADER}
    ${RUNTIME_DIR}/src/runtime/dfx/include/trace/awatchdog/
    ${RUNTIME_DIR}/include/driver
    ${RUNTIME_DIR}/include/trace/utrace
    ${RUNTIME_DIR}/pkg_inc
    ${RUNTIME_DIR}/include/external/acl
    ${RUNTIME_DIR}/include/trace/awatchdog
    ${RUNTIME_DIR}/include
    ${RUNTIME_DIR}/src/dfx/adump/inc/metadef
    ${RUNTIME_DIR}/src/platform
)

set(RUNTIME_CMODEL_INC_DIR
    ${RUNTIME_CMODEL_INC_DIR_COMMON}
    ${RUNTIME_DIR}/src/runtime/inc/sqe/v200
    ${RUNTIME_DIR}/src/runtime/inc/cond_isa/v100
)

set(libruntime_model_dev_info_src_files
    ${RUNTIME_DIR}/src/runtime/config/610_lite/dev_info_proc_func.cc
    ${RUNTIME_DIR}/src/runtime/config/910_B_93/dev_info_proc_func.cc
    ${RUNTIME_DIR}/src/runtime/config/as31xm1/dev_info_proc_func.cc
    ${RUNTIME_DIR}/src/runtime/config/cloud/dev_info_proc_func.cc
    ${RUNTIME_DIR}/src/runtime/config/dc/dev_info_proc_func.cc
    ${RUNTIME_DIR}/src/runtime/config/adc/dev_info_proc_func.cc
    ${RUNTIME_DIR}/src/runtime/config/mini/dev_info_proc_func.cc
    ${RUNTIME_DIR}/src/runtime/config/mini_v3/dev_info_proc_func.cc
    ${RUNTIME_DIR}/src/runtime/config/tiny/dev_info_proc_func.cc
)

if(NOT ${TARGET_SYSTEM_NAME} STREQUAL "Windows")

# ---------------------------------- runtime_cmodel runtime_camodel ----------------------------------
SET(PRODUCT_TYPE_LIST ascend310 ascend610 bs9sx1a ascend310p ascend910 hi3796cv300es hi3796cv300cs ascend910B1 ascend310B ascend610Lite ascend950pr_9599 mc62cm12a)

add_library(runtime_model OBJECT EXCLUDE_FROM_ALL
    ${libruntime_cmodel_src_files}
    ${libruntime_model_dev_info_src_files}
    ${RUNTIME_DIR}/src/runtime/driver/npu_driver.cc
    ${RUNTIME_DIR}/src/runtime/driver/npu_driver_mem.cc
    ${RUNTIME_DIR}/src/runtime/driver/npu_driver_queue.cc
    ${RUNTIME_DIR}/src/runtime/driver/npu_driver_res.cc
    ${RUNTIME_DIR}/src/runtime/driver/npu_driver_tiny.cpp
    ${RUNTIME_DIR}/src/runtime/driver/npu_driver_dcache_lock_common.cpp
    ${RUNTIME_DIR}/src/runtime/driver/npu_driver_dcache_lock_opb.cpp
    ${RUNTIME_DIR}/src/dfx/msprof/collector/dvvp/profapi/stub/profapi_stub.cpp
)

target_include_directories(runtime_model PRIVATE
    ${RUNTIME_CMODEL_INC_DIR}
    ${RUNTIME_DIR}/src/cmodel_driver
    ${RUNTIME_DIR}/src/dfx/msprof/inc/toolchain
)

target_compile_definitions(runtime_model PRIVATE
    CFG_DEV_PLATFORM_PC
    -DSTATIC_RT_LIB=1
    -DRUNTIME_API=0
)

target_compile_options(runtime_model PRIVATE
    -fno-common
    -fno-strict-aliasing
    -Wextra
    -Wfloat-equal
)

target_link_libraries(runtime_model PRIVATE
    $<BUILD_INTERFACE:intf_pub>
    $<BUILD_INTERFACE:mmpa_headers>
    $<BUILD_INTERFACE:msprof_headers>
    $<BUILD_INTERFACE:slog_headers>
    $<BUILD_INTERFACE:tsch_headers>
    $<BUILD_INTERFACE:npu_runtime_headers>
    $<BUILD_INTERFACE:npu_runtime_inner_headers>
    $<BUILD_INTERFACE:atrace_headers>
    $<BUILD_INTERFACE:platform_headers>
    $<BUILD_INTERFACE:awatchdog_headers>
    json
)

set(libruntime_cmodel_v200_dev_info_src_files
    ${RUNTIME_DIR}/src/runtime/config/950/dev_info_proc_func.cc
    ${RUNTIME_DIR}/src/runtime/config/mc62cm12a/dev_info_proc_func.cc
    ${RUNTIME_DIR}/src/runtime/config/910_96/dev_info_proc_func.cc
)

add_library(runtime_model_v200 OBJECT EXCLUDE_FROM_ALL
    ${libruntime_cmodel_v200_src_files}
    ${libruntime_cmodel_v200_dev_info_src_files}
    ${RUNTIME_DIR}/src/runtime/driver/npu_driver.cc
    ${RUNTIME_DIR}/src/runtime/driver/npu_driver_mem.cc
    ${RUNTIME_DIR}/src/runtime/driver/npu_driver_queue.cc
    ${RUNTIME_DIR}/src/runtime/driver/npu_driver_res.cc
    ${RUNTIME_DIR}/src/runtime/driver/npu_driver_tiny.cpp
    ${RUNTIME_DIR}/src/runtime/driver/npu_driver_dcache_lock_common.cpp
    ${RUNTIME_DIR}/src/runtime/driver/npu_driver_dcache_lock_david.cpp
    ${RUNTIME_DIR}/src/dfx/msprof/collector/dvvp/profapi/stub/profapi_stub.cpp
)

target_include_directories(runtime_model_v200 PRIVATE
    ${RUNTIME_CMODEL_INC_DIR}
    ${RUNTIME_DIR}/src/cmodel_driver
    ${RUNTIME_DIR}/src/dfx/msprof/inc/toolchain
    ${RUNTIME_DIR}/src/inc/runtime
)

target_compile_definitions(runtime_model_v200 PRIVATE
    CFG_DEV_PLATFORM_PC
    -DSTATIC_RT_LIB=1
    -DRUNTIME_API=0
)

target_compile_options(runtime_model_v200 PRIVATE
    -fno-common
    -fno-strict-aliasing
    -Wextra
    -Wfloat-equal
)

target_link_libraries(runtime_model_v200 PRIVATE
    $<BUILD_INTERFACE:intf_pub>
    $<BUILD_INTERFACE:mmpa_headers>
    $<BUILD_INTERFACE:msprof_headers>
    $<BUILD_INTERFACE:slog_headers>
    $<BUILD_INTERFACE:tsch_headers>
    $<BUILD_INTERFACE:npu_runtime_headers>
    $<BUILD_INTERFACE:npu_runtime_inner_headers>
    $<BUILD_INTERFACE:awatchdog_headers>
    $<BUILD_INTERFACE:platform_headers>
    $<BUILD_INTERFACE:atrace_headers>
    json
)

foreach(product_type ${PRODUCT_TYPE_LIST})
    # ---------------------------------- runtime_cmodel ----------------------------------
    if("${product_type}" STREQUAL "ascend950pr_9599")
    add_library(runtime_cmodel_${product_type}
        SHARED EXCLUDE_FROM_ALL
        $<TARGET_OBJECTS:runtime_model_v200>
        $<TARGET_OBJECTS:runtime_platform_others>
        $<TARGET_OBJECTS:runtime_platform_910B>
        )
    else()
    add_library(runtime_cmodel_${product_type}
        SHARED EXCLUDE_FROM_ALL
        $<TARGET_OBJECTS:runtime_model>
        $<TARGET_OBJECTS:runtime_platform_others>
        $<TARGET_OBJECTS:runtime_platform_910B>
        )
    endif()

    target_compile_options(runtime_cmodel_${product_type} PRIVATE
        -fno-common
        -fno-strict-aliasing
        -Wextra
        -Wfloat-equal
    )

    target_link_libraries(runtime_cmodel_${product_type} PRIVATE
        mmpa
        platform
        $<BUILD_INTERFACE:intf_pub>
        dl
        rt
        c_sec
        npu_drv_pvmodel_${product_type}
        -Wl,--no-as-needed
        unified_dlog
        -Wl,--as-needed
        json
        awatchdog_share
    )

    set_target_properties(runtime_cmodel_${product_type} PROPERTIES
        OUTPUT_NAME runtime_cmodel
        LIBRARY_OUTPUT_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/${product_type}
    )

    install(TARGETS runtime_cmodel_${product_type}
            LIBRARY DESTINATION lib/${product_type} OPTIONAL
            )

    # -------------------------------- runtime_camodel --------------------------------
    if("${product_type}" STREQUAL "ascend950pr_9599" OR "${product_type}" STREQUAL "mc62cm12a")
    add_library(runtime_camodel_${product_type}
        SHARED EXCLUDE_FROM_ALL
        $<TARGET_OBJECTS:runtime_model_v200>
        $<TARGET_OBJECTS:runtime_platform_others>
        $<TARGET_OBJECTS:runtime_platform_910B>
        )
    else()
    add_library(runtime_camodel_${product_type}
        SHARED EXCLUDE_FROM_ALL
        $<TARGET_OBJECTS:runtime_model>
        $<TARGET_OBJECTS:runtime_platform_others>
        $<TARGET_OBJECTS:runtime_platform_910B>
        )
    endif()
    target_compile_options(runtime_camodel_${product_type} PRIVATE
        -fno-common
        -fno-strict-aliasing
        -Wextra
        -Wfloat-equal
    )
    target_link_libraries(runtime_camodel_${product_type} PRIVATE
        mmpa
        platform
        $<BUILD_INTERFACE:intf_pub>
        dl
        rt
        c_sec
        npu_drv_camodel_${product_type}
        -Wl,--no-as-needed
        unified_dlog
        -Wl,--as-needed
        json
        awatchdog_share
    )

    set_target_properties(runtime_camodel_${product_type} PROPERTIES
        OUTPUT_NAME runtime_camodel
        LIBRARY_OUTPUT_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/${product_type}
    )

    install(TARGETS runtime_camodel_${product_type}
            LIBRARY DESTINATION lib/${product_type} OPTIONAL
            )

endforeach()
endif()
