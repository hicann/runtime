# -----------------------------------------------------------------------------------------------------------
# Copyright (c) 2026 Huawei Technologies Co., Ltd.
# This program is free software, you can redistribute it and/or modify it under the terms and conditions of
# CANN Open Software License Agreement Version 2.0 (the "License").
# Please refer to the License for details. You may not use this file except in compliance with the License.
# THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
# INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
# See LICENSE in the root of the software repository for the full text of the License.
# -----------------------------------------------------------------------------------------------------------
include_guard(GLOBAL)
include(${RUNTIME_DIR}/pkg_inc/runtime/runtime/runtime_headers.cmake)

set(XPU_TPRT_INC_DIR
    ${RUNTIME_DIR}/src/tprt/inc/external
    ${RUNTIME_DIR}/src/tprt/feature/inc
)

set(libruntime_v100_task_src_files
    ${RUNTIME_CORE_DIR}/src/task/task.cc
    ${RUNTIME_CORE_DIR}/src/task/task_submit/v100/task_submit.cc
    ${RUNTIME_CORE_DIR}/src/task/task_res_manage/task_res.cc
    ${RUNTIME_CORE_DIR}/src/task/task_info/task_manager.cc
    ${RUNTIME_CORE_DIR}/src/task/task_info/task_info.cc
    ${RUNTIME_CORE_DIR}/src/task/task_info/model/model_execute_task_info.cc
    ${RUNTIME_CORE_DIR}/src/task/task_info/davinci_kernel_task.cc
    ${RUNTIME_FEATURE_DIR}/ffts/davinci_kernel_task.cc
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
    ${RUNTIME_CORE_DIR}/src/task/task_info/barrier/barrier_task.cc
    ${RUNTIME_CORE_DIR}/src/task/task_info/barrier/barrier_task_v100.cc
    ${RUNTIME_CORE_DIR}/src/task/task_info/cmo/cmo_task.cc
    ${RUNTIME_CORE_DIR}/src/task/task_info/cmo/cmo_task_v100.cc
    ${RUNTIME_CORE_DIR}/src/task/task_info/model/model_maintaince_task.cc
    ${RUNTIME_CORE_DIR}/src/task/task_info/notify_record_task.cc
    ${RUNTIME_CORE_DIR}/src/task/task_info/timeout_set_task.cc
    ${RUNTIME_CORE_DIR}/src/task/task_info/ringbuffer_maintain_task.cc
    ${RUNTIME_CORE_DIR}/src/task/task_info/model/model_update_task.cc
    ${RUNTIME_CORE_DIR}/src/task/task_info/end_graph_task.cc
    ${RUNTIME_CORE_DIR}/src/task/task_info/model/model_to_aicpu_task.cc
    ${RUNTIME_CORE_DIR}/src/task/task_info/maintenance_task.cc

    ${RUNTIME_CORE_DIR}/src/task/v100/davinci_task.cc
    ${RUNTIME_CORE_DIR}/src/task/v100/task_proc_func_register_xpu.cc
    ${RUNTIME_CORE_DIR}/src/task/v100/task_checker.cc
    ${RUNTIME_CORE_DIR}/src/task/v100/memory_task.cc
    ${RUNTIME_CORE_DIR}/src/task/v100/memory_corruption_checker.cc
)

set(libruntime_api_src_files
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

set(common_src_files
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
)

set(libruntime_context_src_files
    ${RUNTIME_CORE_DIR}/src/context/context.cc
    ${RUNTIME_FEATURE_DIR}/aclgraph/context_aclgraph.cc
    ${RUNTIME_CORE_DIR}/src/context/context_manage.cc
    ${RUNTIME_CORE_DIR}/src/context/context_protect.cc
)

set(libruntime_stream_common_src_files
    ${RUNTIME_CORE_DIR}/src/stream/stream_sqcq_manage.cc
    ${RUNTIME_CORE_DIR}/src/stream/engine_stream_observer.cc
    ${RUNTIME_CORE_DIR}/src/stream/stream.cc
    ${RUNTIME_FEATURE_DIR}/aclgraph/stream_capture.cc
    ${RUNTIME_CORE_DIR}/src/stream/ctrl_stream.cc
    ${RUNTIME_CORE_DIR}/src/stream/coprocessor_stream.cc
    ${RUNTIME_CORE_DIR}/src/stream/tsch_stream.cc
    ${RUNTIME_CORE_DIR}/src/stream/stream_factory.cc
)

# v100
set(libruntime_stream_src_files
    ${libruntime_stream_common_src_files}

    ${RUNTIME_CORE_DIR}/src/stream/v100/stream_creator_c.cc
)

set(libruntime_profile_src_files
    ${RUNTIME_CORE_DIR}/src/profiler/profiler.cc
    ${RUNTIME_CORE_DIR}/src/profiler/api_profile_decorator.cc
    ${RUNTIME_CORE_DIR}/src/profiler/api_profile_log_decorator.cc
    ${RUNTIME_CORE_DIR}/src/profiler/prof_map_ge_model_device.cc
    ${RUNTIME_CORE_DIR}/src/profiler/profile_log_record.cc
    ${RUNTIME_CORE_DIR}/src/profiler/npu_driver_record.cc
)
set(libruntime_arg_loader_files
    ${RUNTIME_CORE_DIR}/src/kernel/arg_loader/uma_arg_loader.cc
)

set(libruntime_callback_files
    ${RUNTIME_CORE_DIR}/src/device/device_state_callback_manager.cc
    ${RUNTIME_CORE_DIR}/src/task/task_fail_callback_manager.cc
    ${RUNTIME_CORE_DIR}/src/stream/stream_state_callback_manager.cc
    ${RUNTIME_CORE_DIR}/src/event/event_state_callback_manager.cc
)

set(libruntime_src_files_optional
    ${RUNTIME_CORE_DIR}/src/api_impl/api_error_standard_soc.cc
    ${RUNTIME_CORE_DIR}/src/api_impl/api_impl_standard_soc.cc
    ${RUNTIME_CORE_DIR}/src/api_impl/api_impl_soma.cc
    ${RUNTIME_CORE_DIR}/src/api_impl/api_error_uvm.cc
    ${RUNTIME_CORE_DIR}/src/api_impl/api_impl_uvm.cc
    ${RUNTIME_CORE_DIR}/src/context/context_standard_soc.cc
    ${RUNTIME_FEATURE_DIR}/aclgraph/context_standard_soc_aclgraph.cc
    ${RUNTIME_FEATURE_DIR}/ffts/context_ffts_standard_soc.cc
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
    ${RUNTIME_CORE_DIR}/src/event/ipc_event.cc
    ${RUNTIME_CORE_DIR}/src/kernel/binary_loader.cc
    ${RUNTIME_CORE_DIR}/src/kernel/json_parse.cc
    ${RUNTIME_CORE_DIR}/src/profiler/api_profile_decorator_standard_soc.cc
    ${RUNTIME_CORE_DIR}/src/profiler/api_profile_log_decoratoc_standard_soc.cc
    ${RUNTIME_CORE_DIR}/src/task/task_to_sqe.cc
    ${RUNTIME_CORE_DIR}/src/task/task_info/rdma_task.cc
    ${RUNTIME_FEATURE_DIR}/ffts/rdma_task.cc
    ${RUNTIME_FEATURE_DIR}/ffts/ffts_task.cc
    ${RUNTIME_CORE_DIR}/src/pool/event_expanding.cc
    ${RUNTIME_CORE_DIR}/src/pool/event_pool.cc
)

set(libruntime_api_src_files_optional
    ${RUNTIME_DIR}/src/runtime/api/api_c_standard_soc.cc
    ${RUNTIME_DIR}/src/runtime/api/api_c_soma.cc
    ${RUNTIME_DIR}/src/runtime/api/api_preload_task.cc
    ${RUNTIME_DIR}/src/runtime/api/api_c_dqs.cc
    ${RUNTIME_DIR}/src/runtime/api/api_c_snapshot.cc
    ${RUNTIME_DIR}/src/runtime/api/api_david.cc
    ${RUNTIME_DIR}/src/runtime/api/api_c_xpu.cc
    ${RUNTIME_DIR}/src/runtime/api/api_c_uvm.cc
)

#------------------------- runtime v100 -------------------------
set(xpu_tprt_api_file
    ${RUNTIME_FEATURE_DIR}/xpu/api_error_xpu.cc
    ${RUNTIME_CORE_DIR}/src/api_impl/v100/api_impl_v100_xpu.cc
    ${RUNTIME_FEATURE_DIR}/xpu/api_decorator_xpu.cc
)

set(xpu_tprt_src_file
    ${RUNTIME_FEATURE_DIR}/xpu/task_xpu.cc
    ${RUNTIME_FEATURE_DIR}/xpu/task_manager_xpu.cc
    ${RUNTIME_FEATURE_DIR}/xpu/xpu_kernel_task.cc
    ${RUNTIME_FEATURE_DIR}/xpu/task_xpu_recycle.cc
    ${RUNTIME_FEATURE_DIR}/xpu/xpu_context.cc
    ${RUNTIME_FEATURE_DIR}/xpu/stream_sqcq_manage_xpu.cc
    ${RUNTIME_CORE_DIR}/src/task/task_res_manage/v200/task_res_da.cc
    ${RUNTIME_FEATURE_DIR}/xpu/stream_xpu.cc
    ${RUNTIME_FEATURE_DIR}/xpu/stream_xpu_c.cc
    ${RUNTIME_FEATURE_DIR}/xpu/xpu_device.cc
    ${RUNTIME_CORE_DIR}/src/pool/h2h_copy_mgr.cc
    ${RUNTIME_DIR}/src/runtime/driver/xpu_driver.cc
    ${RUNTIME_FEATURE_DIR}/xpu/arg_loader_xpu.cc
    ${RUNTIME_CORE_DIR}/src/kernel/arg_loader/arg_manage_david.cc
    ${RUNTIME_FEATURE_DIR}/xpu/arg_manage_xpu.cc
    ${RUNTIME_FEATURE_DIR}/xpu/xpu_aicpu_c.cc
    ${RUNTIME_FEATURE_DIR}/xpu/program_plat.cc
    ${RUNTIME_CORE_DIR}/src/kernel/json_parse.cc
    ${RUNTIME_FEATURE_DIR}/xpu/runtime_xpu_adapt.cc
)

set(libruntime_v100_src_files
    ${RUNTIME_CORE_DIR}/src/common/inner_thread_local.cpp
    ${RUNTIME_CORE_DIR}/src/api_impl/api_decorator.cc
    ${RUNTIME_FEATURE_DIR}/aclgraph/api_decorator_aclgraph.cc
    ${RUNTIME_CORE_DIR}/src/api_impl/api_impl.cc
    ${RUNTIME_FEATURE_DIR}/aclgraph/v100/api_impl_aclgraph.cc
    ${RUNTIME_FEATURE_DIR}/aclgraph/v100/api_impl_capture_event.cc
    ${RUNTIME_CORE_DIR}/src/api_impl/api_impl_mbuf.cc
    ${RUNTIME_CORE_DIR}/src/api_impl/api_error.cc
    ${RUNTIME_FEATURE_DIR}/aclgraph/api_error_aclgraph.cc
    ${RUNTIME_CORE_DIR}/src/uvm/uvm_callback.cc

    # for V100
    ${RUNTIME_CORE_DIR}/src/api_impl/api_impl_creator.cc
    ${RUNTIME_CORE_DIR}/src/api_impl/v100/api_impl_creator_c.cc
    ${RUNTIME_CORE_DIR}/src/device/ctrl_sq.cc
    ${RUNTIME_CORE_DIR}/src/device/ctrl_msg.cc
    ${RUNTIME_CORE_DIR}/src/device/device.cc
    ${RUNTIME_CORE_DIR}/src/device/raw_device.cc
    ${RUNTIME_CORE_DIR}/src/device/raw_device_res.cc
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
    ${RUNTIME_FEATURE_DIR}/aclgraph/model_aclgraph.cc
    ${RUNTIME_CORE_DIR}/src/model/model_rebuild.cc
    ${RUNTIME_CORE_DIR}/src/model/v100/capture_adapt.cc
    ${RUNTIME_FEATURE_DIR}/aclgraph/v100/capture_adapt_v100.cc
    ${RUNTIME_FEATURE_DIR}/aclgraph/v100/capture_model_adapt_v100.cc
    ${RUNTIME_FEATURE_DIR}/aclgraph/capture_model.cc
    ${RUNTIME_FEATURE_DIR}/aclgraph/capture_model_utils.cc
    ${RUNTIME_CORE_DIR}/src/kernel/args/args_handle_allocator.cc
    ${RUNTIME_CORE_DIR}/src/kernel/args/para_convertor.cc
    ${RUNTIME_CORE_DIR}/src/kernel/v100/kernel.cc
    ${RUNTIME_CORE_DIR}/src/kernel/elf.cc
    ${RUNTIME_CORE_DIR}/src/kernel/kernel.cc
    ${RUNTIME_CORE_DIR}/src/kernel/module.cc
    ${RUNTIME_CORE_DIR}/src/kernel/program.cc
    ${RUNTIME_CORE_DIR}/src/kernel/program_common.cc
    ${RUNTIME_CORE_DIR}/src/kernel/kernel_utils.cc
    ${RUNTIME_FEATURE_DIR}/soma/soma.cc
    ${RUNTIME_FEATURE_DIR}/soma/stream_mem_pool.cc
    ${RUNTIME_CORE_DIR}/src/launch/memcpy_stars.cc
    ${RUNTIME_CORE_DIR}/src/launch/cmo_barrier_common.cc
    ${RUNTIME_CORE_DIR}/src/launch/cmo_barrier_stars.cc
    ${RUNTIME_CORE_DIR}/src/launch/label.cc
    ${RUNTIME_CORE_DIR}/src/launch/cond_stars.cc
    ${RUNTIME_CORE_DIR}/src/launch/label_common.cc
    ${RUNTIME_CORE_DIR}/src/launch/label_stars.cc
    ${RUNTIME_CORE_DIR}/src/launch/aicpu_stars.cc
    ${RUNTIME_CORE_DIR}/src/launch/dvpp_stars.cc
    ${RUNTIME_CORE_DIR}/src/event/event.cc
    ${RUNTIME_FEATURE_DIR}/aclgraph/event_capture.cc
    ${RUNTIME_CORE_DIR}/src/notify/notify.cc
    ${RUNTIME_CORE_DIR}/src/engine/logger.cc
    ${RUNTIME_CORE_DIR}/src/runtime.cc
    ${RUNTIME_CORE_DIR}/src/runtime_v200/runtime_adapt.cc
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
    ${RUNTIME_CORE_DIR}/src/device/ini_parse_utils.cc
    ${RUNTIME_CORE_DIR}/src/stream/dvpp_grp.cc
    ${RUNTIME_CORE_DIR}/src/engine/engine.cc
    ${RUNTIME_CORE_DIR}/src/engine/hwts/package_rebuilder.cc
    ${RUNTIME_CORE_DIR}/src/engine/stars/stars_engine.cc
    ${RUNTIME_CORE_DIR}/src/task/ctrl_res_pool.cpp
    ${RUNTIME_CORE_DIR}/src/task/host_task.cc
    ${RUNTIME_CORE_DIR}/src/task/stars_cond_isa_helper.cc
    ${RUNTIME_CORE_DIR}/src/task/task_fail_callback_manager.cc
    ${RUNTIME_CORE_DIR}/src/task/v100/stub_task.cc
    ${RUNTIME_CORE_DIR}/src/memory/mem_type.cc
    ${libruntime_v100_task_src_files}
    ${libruntime_context_src_files}
    ${libruntime_stream_src_files}
    ${RUNTIME_CORE_DIR}/src/profiler/profiler.cc
    ${RUNTIME_CORE_DIR}/src/profiler/api_profile_decorator.cc
    ${RUNTIME_CORE_DIR}/src/profiler/api_profile_log_decorator.cc
    ${RUNTIME_CORE_DIR}/src/profiler/profile_log_record.cc
    ${RUNTIME_CORE_DIR}/src/profiler/npu_driver_record.cc
    ${libruntime_arg_loader_files}
    ${RUNTIME_CORE_DIR}/src/device/device_state_callback_manager.cc
    ${RUNTIME_CORE_DIR}/src/stream/stream_state_callback_manager.cc
    ${RUNTIME_CORE_DIR}/src/event/event_state_callback_manager.cc
    ${RUNTIME_CORE_DIR}/src/plugin_manage/v200/plugin_old_arch.cc
    ${libruntime_src_files_optional}
    ${xpu_tprt_api_file}
    ${xpu_tprt_src_file}
)

set(RUNTIME_INC_DIR_OPEN
    ${RUNTIME_DIR}/src/runtime/core/inc
    ${RUNTIME_CORE_DIR}/inc_c
    ${RUNTIME_FEATURE_DIR}/fusion
    ${RUNTIME_FEATURE_DIR}/ccu
    ${RUNTIME_DIR}/src/runtime/core/inc/args
    ${RUNTIME_DIR}/src/runtime/core/inc/arg_loader
    ${RUNTIME_DIR}/src/runtime/core/inc/common
    ${RUNTIME_DIR}/src/runtime/core/inc/context
    ${RUNTIME_DIR}/src/runtime/core/inc/device
    ${RUNTIME_DIR}/src/runtime/core/inc/dfx
    ${RUNTIME_DIR}/src/runtime/core/inc/drv
    ${RUNTIME_DIR}/src/runtime/core/inc/engine
    ${RUNTIME_DIR}/src/runtime/core/inc/engine/hwts
    ${RUNTIME_DIR}/src/runtime/core/inc/event
    ${RUNTIME_DIR}/src/runtime/core/inc/kernel
    ${RUNTIME_DIR}/src/runtime/core/inc/launch
    ${RUNTIME_DIR}/src/runtime/core/inc/model
    ${RUNTIME_DIR}/src/runtime/core/inc/notify
    ${RUNTIME_DIR}/src/runtime/core/inc/profiler
    ${RUNTIME_DIR}/src/runtime/core/inc/soc
    ${RUNTIME_DIR}/src/runtime/core/inc/spec
    ${RUNTIME_DIR}/src/runtime/core/inc/sqe
    ${RUNTIME_DIR}/src/runtime/inc/device
    ${RUNTIME_DIR}/src/runtime/inc/sqe
    ${RUNTIME_DIR}/src/runtime/core/inc/stars
    ${RUNTIME_DIR}/src/runtime/core/inc/stream
    ${RUNTIME_DIR}/src/runtime/core/inc/task
    ${RUNTIME_DIR}/src/runtime/core/inc/utils
    ${RUNTIME_DIR}/src/runtime/api
    ${RUNTIME_CORE_DIR}/src/api_impl
    ${RUNTIME_CORE_DIR}/src/engine
    ${RUNTIME_CORE_DIR}/src/engine/hwts
    ${RUNTIME_CORE_DIR}/src/engine/stars
    ${RUNTIME_CORE_DIR}/src/stream
    ${RUNTIME_CORE_DIR}/src/task/inc
    ${RUNTIME_FEATURE_DIR}/ffts
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
    ${RUNTIME_FEATURE_DIR}/ccu
    ${RUNTIME_FEATURE_DIR}/ffts
    ${RUNTIME_FEATURE_DIR}/xpu
    ${RUNTIME_CORE_DIR}/src/uvm
    ${RUNTIME_CORE_DIR}/src/event
    ${RUNTIME_DIR}/src/runtime/core/inc/cond_isa/v100
    ## not open
    ${RUNTIME_DIR}/src/runtime/core/inc/dqs
    ${RUNTIME_DIR}/src/runtime/core/inc/sqe/v200
    ${RUNTIME_DIR}/src/runtime/core/inc/sqe/v200_base
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
    ${XPU_TPRT_INC_DIR}
)

#------------------------- runtime common -------------------------
macro(add_runtime_common_library target_name)
    add_library(${target_name} SHARED
        ${common_src_files}
    )

    target_compile_definitions(${target_name} PRIVATE
        LOG_CPP
        -DSTATIC_RT_LIB=0
        -DRUNTIME_API=0
    )

    target_compile_options(${target_name} PRIVATE
        $<$<CONFIG:Debug>:-O0>
        $<$<NOT:$<CONFIG:Debug>>:-O3>
        -fno-common
        -fno-strict-aliasing
        -Werror
        -Wextra
        $<$<NOT:$<STREQUAL:${TARGET_SYSTEM_NAME},Windows>>:-Wfloat-equal>
    )

    target_include_directories(${target_name} PRIVATE
        ${RUNTIME_INC_DIR_OPEN}
        ${RUNTIME_DIR}/include
    )

    target_link_libraries(${target_name}
        PRIVATE
            $<BUILD_INTERFACE:intf_pub>
            $<BUILD_INTERFACE:mmpa_headers>
            $<BUILD_INTERFACE:msprof_headers>
            $<BUILD_INTERFACE:slog_headers>
            $<BUILD_INTERFACE:npu_runtime_headers>
            $<BUILD_INTERFACE:npu_runtime_inner_headers>
            $<BUILD_INTERFACE:awatchdog_headers>
            $<BUILD_INTERFACE:platform_headers>
            $<BUILD_INTERFACE:atrace_headers>
            $<$<NOT:$<STREQUAL:${TARGET_SYSTEM_NAME},Windows>>:dl>
            $<$<NOT:$<STREQUAL:${TARGET_SYSTEM_NAME},Windows>>:rt>
            -Wl,--no-as-needed
            mmpa
            c_sec
            $<$<NOT:$<STREQUAL:${TARGET_SYSTEM_NAME},Windows>>:profapi_share>
            # error_manager仅在windows形态暂不需要
            $<$<NOT:$<STREQUAL:${TARGET_SYSTEM_NAME},Windows>>:error_manager>
            $<$<STREQUAL:${TARGET_SYSTEM_NAME},Windows>:ascend_hal>
            $<$<AND:$<NOT:$<STREQUAL:${TARGET_SYSTEM_NAME},Windows>>,$<NOT:$<STREQUAL:${ENABLE_TSD},true>>>:ascend_hal_stub>
            awatchdog_share
            unified_dlog
            $<$<AND:$<NOT:$<STREQUAL:${PRODUCT},ascend610>>,$<NOT:$<STREQUAL:${PRODUCT},ascend610Lite>>>:atrace_share>
            json
            platform
            -Wl,--as-needed
            -Wl,-Bsymbolic
        PUBLIC
            npu_runtime_headers
    )
    if("${ENABLE_TSD}" STREQUAL "true")
        if("${TARGET_LINUX_DISTRIBUTOR_ID}" STREQUAL lhisilinux)
            if("${TARGET_LINUX_DISTRIBUTOR_RELEASE}" STREQUAL 100)
                target_link_libraries(${target_name} PRIVATE -L${RUNTIME_DIR}/vendor/sdk/hi3796/drv)
            elseif("${TARGET_LINUX_DISTRIBUTOR_RELEASE}" STREQUAL 200)
                target_link_libraries(${target_name} PRIVATE -L${RUNTIME_DIR}/vendor/sdk/hi3559dv100/drv)
            endif()
        endif()

        target_link_libraries(${target_name} PRIVATE drvdevdrv aicpu_scheduler_so)
    endif()

    if(ENABLE_ASAN)
        target_compile_definitions(${target_name} PRIVATE
                __RT_ENABLE_ASAN__)
    endif()
endmacro()

#------------------------- runtime only api -------------------------
macro(add_runtime_api_library target_name)
    add_library(${target_name} SHARED
        ${libruntime_api_src_files}
        ${libruntime_api_src_files_optional}
        ${RUNTIME_DIR}/src/runtime/api/api.cc
        ${RUNTIME_CORE_DIR}/src/profiler/prof_map_ge_model_device.cc
        ${RUNTIME_CORE_DIR}/src/plugin_manage/runtime_keeper.cc
        $<TARGET_OBJECTS:runtime_platform_910B>
        $<TARGET_OBJECTS:runtime_platform_kirin>
        $<TARGET_OBJECTS:runtime_platform_others>
        $<TARGET_OBJECTS:runtime_platform_tiny>
    )

    target_compile_definitions(${target_name} PRIVATE
        LOG_CPP
        -DSTATIC_RT_LIB=0  # set 1 when not split so
        -DRUNTIME_API=1  # set 1 when split so and in libruntime.so
    )

    set_target_properties(${target_name}
        PROPERTIES
        WINDOWS_EXPORT_ALL_SYMBOLS TRUE
        OUTPUT_NAME $<IF:$<STREQUAL:${TARGET_SYSTEM_NAME},Windows>,lib${target_name},${target_name}>
    )

    target_compile_options(${target_name} PRIVATE
        $<$<CONFIG:Debug>:-O0>
        $<$<NOT:$<CONFIG:Debug>>:-O3>
        -fvisibility=hidden
        -fno-common
        -fno-strict-aliasing
        -Werror
        -Wextra
        $<$<NOT:$<STREQUAL:${TARGET_SYSTEM_NAME},Windows>>:-Wfloat-equal>
    )

    target_include_directories(${target_name} PRIVATE
        ${RUNTIME_INC_DIR_OPEN}
        ${RUNTIME_DIR}/include
    )

    target_link_libraries(${target_name}
        PRIVATE
            $<BUILD_INTERFACE:intf_pub>
            $<BUILD_INTERFACE:platform_headers>
            $<BUILD_INTERFACE:mmpa_headers>
            $<BUILD_INTERFACE:msprof_headers>
            $<BUILD_INTERFACE:slog_headers>
            $<BUILD_INTERFACE:awatchdog_headers>
            $<BUILD_INTERFACE:npu_runtime_headers>
            $<BUILD_INTERFACE:npu_runtime_inner_headers>
            $<BUILD_INTERFACE:atrace_headers>
            $<$<NOT:$<STREQUAL:${TARGET_SYSTEM_NAME},Windows>>:dl>
            $<$<NOT:$<STREQUAL:${TARGET_SYSTEM_NAME},Windows>>:rt>
            -Wl,--no-as-needed
            mmpa
            c_sec
            $<$<NOT:$<STREQUAL:${TARGET_SYSTEM_NAME},Windows>>:profapi_share>
            # error_manager仅在windows形态暂不需要
            $<$<NOT:$<STREQUAL:${TARGET_SYSTEM_NAME},Windows>>:error_manager>
            $<$<STREQUAL:${TARGET_SYSTEM_NAME},Windows>:ascend_hal>
            $<$<AND:$<NOT:$<STREQUAL:${TARGET_SYSTEM_NAME},Windows>>,$<NOT:$<STREQUAL:${ENABLE_TSD},true>>>:ascend_hal_stub>
            awatchdog_share
            unified_dlog
            $<$<AND:$<NOT:$<STREQUAL:${PRODUCT},ascend610>>,$<NOT:$<STREQUAL:${PRODUCT},ascend610Lite>>>:atrace_share>
            json
            platform
            runtime_common
            -Wl,--as-needed
            #-Wl,-Bsymbolic
        PUBLIC
            npu_runtime_headers
    )
    if("${ENABLE_TSD}" STREQUAL "true")
        if("${TARGET_LINUX_DISTRIBUTOR_ID}" STREQUAL lhisilinux)
            if("${TARGET_LINUX_DISTRIBUTOR_RELEASE}" STREQUAL 100)
                target_link_libraries(${target_name} PRIVATE -L${RUNTIME_DIR}/vendor/sdk/hi3796/drv)
            elseif("${TARGET_LINUX_DISTRIBUTOR_RELEASE}" STREQUAL 200)
                target_link_libraries(${target_name} PRIVATE -L${RUNTIME_DIR}/vendor/sdk/hi3559dv100/drv)
            endif()
        endif()

        target_link_libraries(${target_name} PRIVATE drvdevdrv aicpu_scheduler_so)
    endif()

    if("${hostchip}" STREQUAL "hi3559a")
        target_compile_definitions(${target_name} PRIVATE
                __RT_CFG_HOST_CHIP_HI3559A__)
    endif()

    if(ENABLE_ASAN)
        target_compile_definitions(${target_name} PRIVATE
                __RT_ENABLE_ASAN__)
    endif()
endmacro()

set(libruntime_dev_info_src_files
    ${RUNTIME_DIR}/src/runtime/config/910_B_93/dev_info_proc_func.cc
)

macro(add_runtime_v100_library target_name)
    add_library(${target_name} SHARED
        ${libruntime_v100_src_files}
        ${libruntime_dev_info_src_files}
        ${RUNTIME_DIR}/src/runtime/driver/npu_driver.cc
        ${RUNTIME_DIR}/src/runtime/driver/npu_driver_mem.cc
        ${RUNTIME_DIR}/src/runtime/driver/npu_driver_queue.cc
        ${RUNTIME_DIR}/src/runtime/driver/npu_driver_res.cc
        ${RUNTIME_DIR}/src/runtime/driver/npu_driver_tiny.cpp
        ${RUNTIME_DIR}/src/runtime/driver/npu_driver_dcache_lock_common.cpp
        ${RUNTIME_DIR}/src/runtime/driver/npu_driver_dcache_lock_opb.cpp
    )

    target_compile_definitions(${target_name} PRIVATE
        LOG_CPP
        -DSTATIC_RT_LIB=0
        -DRUNTIME_API=0
    )

    target_compile_options(${target_name} PRIVATE
        $<$<CONFIG:Debug>:-O0>
        $<$<NOT:$<CONFIG:Debug>>:-O3>
        -fvisibility=hidden
        -fno-common
        -fno-strict-aliasing
        $<$<STREQUAL:${CMAKE_CXX_COMPILER_VERSION},7.3.0>:-Werror>
        $<$<NOT:$<STREQUAL:${TARGET_SYSTEM_NAME},Windows>>:-Wextra>
        $<$<NOT:$<STREQUAL:${TARGET_SYSTEM_NAME},Windows>>:-Wfloat-equal>
    )

    target_include_directories(${target_name} PRIVATE
        ${RUNTIME_INC_DIR_OPEN}
        ${RUNTIME_DIR}/include
    )

    target_link_libraries(${target_name}
        PRIVATE
            $<BUILD_INTERFACE:intf_pub>
            $<BUILD_INTERFACE:mmpa_headers>
            $<BUILD_INTERFACE:msprof_headers>
            $<BUILD_INTERFACE:slog_headers>
            $<BUILD_INTERFACE:npu_runtime_headers>
            $<BUILD_INTERFACE:npu_runtime_inner_headers>
            $<BUILD_INTERFACE:atrace_headers>
            $<BUILD_INTERFACE:awatchdog_headers>
            $<BUILD_INTERFACE:platform_headers>
            $<$<NOT:$<STREQUAL:${TARGET_SYSTEM_NAME},Windows>>:dl>
            $<$<NOT:$<STREQUAL:${TARGET_SYSTEM_NAME},Windows>>:rt>
            -Wl,--no-as-needed
            mmpa
            c_sec
            $<$<NOT:$<STREQUAL:${TARGET_SYSTEM_NAME},Windows>>:profapi_share>
            # error_manager仅在windows形态暂不需要
            $<$<NOT:$<STREQUAL:${TARGET_SYSTEM_NAME},Windows>>:error_manager>
            $<$<STREQUAL:${TARGET_SYSTEM_NAME},Windows>:ascend_hal>
            $<$<AND:$<NOT:$<STREQUAL:${TARGET_SYSTEM_NAME},Windows>>,$<NOT:$<STREQUAL:${ENABLE_TSD},true>>>:ascend_hal_stub>
            awatchdog_share
            unified_dlog
            $<$<AND:$<NOT:$<STREQUAL:${PRODUCT},ascend610>>,$<NOT:$<STREQUAL:${PRODUCT},ascend610Lite>>>:atrace_share>
            json
            platform
            xpu_tprt
            runtime_common
            -Wl,--as-needed
            -Wl,-Bsymbolic
        PUBLIC
            npu_runtime_headers
    )
    if("${ENABLE_TSD}" STREQUAL "true")
        if("${TARGET_LINUX_DISTRIBUTOR_ID}" STREQUAL lhisilinux)
            if("${TARGET_LINUX_DISTRIBUTOR_RELEASE}" STREQUAL 100)
                target_link_libraries(${target_name} PRIVATE -L${RUNTIME_DIR}/vendor/sdk/hi3796/drv)
            elseif("${TARGET_LINUX_DISTRIBUTOR_RELEASE}" STREQUAL 200)
                target_link_libraries(${target_name} PRIVATE -L${RUNTIME_DIR}/vendor/sdk/hi3559dv100/drv)
            endif()
        endif()

        target_link_libraries(${target_name} PRIVATE drvdevdrv aicpu_scheduler_so)
    endif()

    if(ENABLE_ASAN)
        target_compile_definitions(${target_name} PRIVATE
                __RT_ENABLE_ASAN__)
    endif()
endmacro()

add_runtime_api_library(runtime)
add_runtime_common_library(runtime_common)
add_runtime_v100_library(runtime_v100)
add_dependencies(runtime runtime_v100)

install(TARGETS runtime DESTINATION ${INSTALL_LIBRARY_DIR} OPTIONAL)
install(TARGETS runtime_common DESTINATION ${INSTALL_LIBRARY_DIR} OPTIONAL)
install(TARGETS runtime_v100 DESTINATION ${INSTALL_LIBRARY_DIR} OPTIONAL)
