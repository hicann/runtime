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
include(${CMAKE_CURRENT_SOURCE_DIR}/../../inc/runtime/runtime_headers.cmake)

set(libruntime_cmodel_v100_task_src_files
    src/task/task.cc
    src/task/task_submit/v100/task_submit.cc
    src/task/task_res_manage/task_res.cc
    src/task/task_info/task_manager.cc
    src/task/task_info/task_info.cc
    src/task/task_info/model/model_execute_task_info.cc
    src/task/task_info/davinci_kernel_task.cc
    src/task/task_info/event_task.cc
    src/task/task_info/memory_task.cc
    src/task/task_info/reduce_task.cc
    src/task/task_info/cond_op/cond_op_label_task.cc
    src/task/task_info/cond_op/cond_op_stream_task.cc
    src/task/task_info/profiling_task.cc
    src/task/task_info/dump_task.cc
    src/task/task_info/stream/stream_task.cc
    src/task/task_execute_time.cc
    src/task/task_info/davinci_multiple_task.cc
    src/task/task_info/stars_common_task.cc
    src/task/task_info/random_num_task.cc
    src/task/task_info/barrier_task.cc
    src/task/task_info/cmo_task.cc
    src/task/task_info/model/model_maintaince_task.cc
    src/task/task_info/notify_record_task.cc
    src/task/task_info/timeout_set_task.cc
    src/task/task_info/ringbuffer_maintain_task.cc
    src/task/task_info/model/model_update_task.cc
    src/task/task_info/end_graph_task.cc
    src/task/task_info/model/model_to_aicpu_task.cc
    src/task/task_info/maintenance_task.cc

    src/task/v100/davinci_task.cc
    src/task/v100/task_proc_func_register.cc
    src/task/v100/task_checker.cc
    src/task/v100/memory_task.cc
)

set(david_series_common_task_src_file_cmodel
    src/task/task.cc
    src/task/task_submit/v100/task_submit.cc
    src/task/task_res_manage/task_res.cc
    src/task/task_info/task_manager.cc
    src/task/task_info/task_info.cc
    src/task/task_info/model/model_execute_task_info.cc
    src/task/task_info/davinci_kernel_task.cc
    src/task/task_info/event_task.cc
    src/task/task_info/david_event_task.cc
    src/task/task_info/memory_task.cc
    src/task/task_info/reduce_task.cc
    src/task/task_info/cond_op/cond_op_label_task.cc
    src/task/task_info/cond_op/cond_op_stream_task.cc
    src/task/task_info/profiling_task.cc
    src/task/task_info/dump_task.cc
    src/task/task_info/stream/stream_task.cc
    src/task/task_execute_time.cc
    src/task/task_info/davinci_multiple_task.cc
    src/task/task_info/stars_common_task.cc
    src/task/task_info/random_num_task.cc
    src/task/task_info/barrier_task.cc
    src/task/task_info/cmo_task.cc
    src/task/task_info/ubdma_task_david.cc
    src/task/task_info/cond_op/cond_op_task_david.cc
    src/task/task_info/model/model_maintaince_task.cc
    src/task/task_info/notify_record_task.cc
    src/task/task_info/timeout_set_task.cc
    src/task/task_info/ringbuffer_maintain_task.cc
    src/task/task_info/model/model_update_task.cc
    src/task/task_info/model/model_update_task_david.cc
    src/task/task_info/notify/notify_task_david.cc
    src/task/task_info/end_graph_task.cc
    src/task/task_info/model/model_to_aicpu_task.cc
    src/task/task_info/maintenance_task.cc
    src/task/task_recycle/v200/task_recycle_dvpp.cc
    src/task/task_submit/v200/task_david.cc
    src/task/task_recycle/v200/task_recycle_send_sync.cc
    src/task/task_res_manage/v200/task_res_da.cc
    src/task/task_recycle/v200/task_recycle.cc
    src/task/task_recycle/v200/task_recycle_common_base.cc
    src/task/task_recycle/v200/task_recycle_cqrpt_base.cc
    src/task/task_info/task_manager_david.cc
    src/task/v200_base/davinci_task.cc
    src/task/v200_base/davinci_task_launch_config.cc
    src/task/v200_base/memcpy_sqe_common_proc.cc
    src/task/v200_base/aicpu_sqe_common_proc.cc
    src/task/v200_base/memory_task.cc
)

set(libruntime_cmodel_v200_task_src_files
    ${david_series_common_task_src_file_cmodel}

    # david & solomon 专用差异化文件
    src/task/v200_base/task_proc_func_register.cc
    src/task/v200/memcpy_task_to_sqe.cc
    src/task/v200/task_checker.cc
)

set(libruntime_cmodel_api_src_files
    src/api/api_c.cc
    src/api/api_c_context.cc
    src/api/api_c_device.cc
    src/api/api_c_kernel.cc
    src/api/api_c_memory.cc
    src/api/api_c_stream.cc
    src/api/api_c_model.cc
    src/api/api_c_event.cc
    src/api/api_c_mbuf.cc
    src/api/inner.cc
    src/api/api_global_err.cc
    src/api/api_c_soc.cc
)

set(common_src_files_cmodel
    src/common/error_code.cc
    src/common/thread_local_container.cc
    src/common/utils.cc
    src/common/heterogenous.cc
    src/common/soc_info.cc
    src/common/context_data_manage.cc
    src/common/profiling_agent.cc
    src/common/errcode_manage.cc
    src/common/error_message_manage.cc
    src/common/task_fail_callback_data_manager.cc
    src/common/performance_record.cc
    src/common/prof_ctrl_callback_manager.cc
    src/common/rt_log.cc
    src/common/dev_info_manage.cc
    src/common/global_state_manager.cc
    src/common/register_memory.cc
)

set(libruntime_cmodel_context_src_files
    src/context/context.cc
    src/context/context_manage.cc
    src/context/context_protect.cc
)

set(libruntime_cmodel_stream_common_src_files
    src/stream/stream_sqcq_manage.cc
    src/stream/engine_stream_observer.cc
    src/stream/stream.cc
    src/stream/ctrl_stream.cc
    src/stream/coprocessor_stream.cc
    src/stream/tsch_stream.cc
    src/stream/stream_factory.cc
)

# v100
set(libruntime_cmodel_stream_src_files
    ${libruntime_cmodel_stream_common_src_files}

    src/stream/v100/stream_creator_c.cc
)

# david
set(libruntime_cmodel_v200_stream_src_files
    ${libruntime_cmodel_stream_common_src_files}

    src/stream/stream_c.cc
    src/stream/stream_david.cc
    src/stream/v200/stream_creator_c.cc
)

set(libruntime_cmodel_profile_src_files
    src/profiler/profiler.cc
    src/profiler/api_profile_decorator.cc
    src/profiler/api_profile_log_decorator.cc
    src/profiler/prof_map_ge_model_device.cc
    src/profiler/profile_log_record.cc
    src/profiler/npu_driver_record.cc
)
set(libruntime_cmodel_arg_loader_files
    src/kernel/arg_loader/uma_arg_loader.cc
)

set(libruntime_cmodel_callback_files
    src/device/device_state_callback_manager.cc
    src/task/task_fail_callback_manager.cc
    src/stream/stream_state_callback_manager.cc
)

#------------------------- exclude these files in tiny(ascend031) ---------------------
set(libruntime_cmodel_src_files_optional
    src/api_impl/api_error_standard_soc.cc
    src/api_impl/api_impl_standard_soc.cc
    src/context/context_standard_soc.cc
    src/dfx/fp16_t.cpp
    src/dfx/hifloat.cpp
    src/dfx/printf.cc
    src/drv/npu_driver_standard_soc.cc
    src/engine/hwts/direct_hwts_engine.cc
    src/engine/hwts/hwts_engine.cc
    src/engine/hwts/async_hwts_engine.cc
    src/engine/hwts/shm_cq.cc
    src/engine/engine_factory.cc
    src/kernel/binary_loader.cc
    src/kernel/v100/binary_loader_c.cc
    src/kernel/json_parse.cc
    src/profiler/api_profile_decorator_standard_soc.cc
    src/profiler/api_profile_log_decoratoc_standard_soc.cc
    src/task/task_to_sqe.cc
    src/task/task_info/rdma_task.cc
    src/task/task_info/ffts_task.cc
    src/event/ipc_event.cc
    src/pool/event_expanding.cc
    src/pool/event_pool.cc
)

set(libruntime_cmodel_api_src_files
    src/api/api_c_standard_soc.cc
    src/api/api_preload_task.cc
    src/api/api_c_dqs.cc
    src/api/api_c_snapshot.cc
    src/api/api_david.cc
)

set(xpu_tprt_api_file
    src/api_impl/api_error_xpu.cc
    src/api_impl/v100/api_impl_v100.cc
    src/api_impl/api_decorator_xpu.cc
)

set(libruntime_cmodel_src_files
    src/common/inner_thread_local.cpp
    src/api/api.cc
    src/api_impl/api_decorator.cc
    src/api_impl/api_error.cc
    src/api_impl/api_impl.cc
    src/api_impl/api_impl_mbuf.cc

    # for V100
    src/api_impl/api_impl_creator.cc
    src/api_impl/v100/api_impl_creator_c.cc
    src/device/ctrl_msg.cc
    src/device/ctrl_sq.cc
    src/drv/v100/npu_driver.cc
    src/config.cc
    src/device/device.cc
    src/device/raw_device.cc
    src/device/raw_device_res_camodel.cc
    src/device/device_snapshot.cc
    src/device/raw_device_adpt_comm.cc
    src/drv/driver.cc
    src/drv/v100/npu_driver.cc
    src/pool/bitmap.cc
    src/pool/buffer_allocator.cc
    src/pool/task_allocator.cc
    src/pool/spm_pool.cc
    src/pool/h2d_copy_mgr.cc
    src/pool/memory_list.cc
    src/pool/memory_pool.cc
    src/pool/memory_pool_manager.cc
    src/model/model.cc
    src/model/model_rebuild.cc
    src/model/capture_model.cc
    src/model/capture_model_utils.cc
    src/model/v100/capture_adapt.cc
    src/kernel/args/args_handle_allocator.cc
    src/kernel/args/para_convertor.cc
    src/kernel/v100/kernel.cc
    src/kernel/v100/program_plat.cc
    src/kernel/v100/binary_loader_plat.cc
    src/kernel/elf.cc
    src/kernel/kernel.cc
    src/kernel/module.cc
    src/kernel/program.cc
    src/kernel/program_common.cc
    src/launch/label.cc
    src/event/event.cc
    src/notify/notify.cc
    src/engine/logger.cc
    src/runtime.cc
    src/runtime_v100/runtime_adapt.cc
    src/plugin_manage/runtime_keeper.cc
    src/utils/capability.cc
    src/utils/osal.cc
    src/engine/hwts/scheduler.cc
    src/dfx/atrace_log.cc
    src/dfx/pctrace.cc
    src/utils/subscribe.cc
    src/profiler/onlineprof.cc
    src/ttlv/ttlv_decoder_utils.cc
    src/ttlv/ttlv.cc
    src/ttlv/ttlv_word_decoder.cc
    src/ttlv/ttlv_sentence_decoder.cc
    src/ttlv/ttlv_paragraph_decoder.cc
    src/device/device_error_core_proc.cc
    src/device/device_error_proc.cc
    src/device/v100/device_error_proc.cc
    src/device/device_sq_cq_pool.cc
    src/device/sq_addr_memory_pool.cc
    src/utils/aicpu_scheduler_agent.cc
    src/device/device_msg_handler.cc
    src/device/aicpu_err_msg.cc
    src/stream/dvpp_grp.cc
    src/engine/engine.cc
    src/engine/hwts/package_rebuilder.cc
    src/engine/stars/stars_engine.cc
    src/task/ctrl_res_pool.cpp
    src/task/host_task.cc
    src/task/stars_cond_isa_helper.cc
    src/task/v100/stub_task.cc
    ${libruntime_cmodel_v100_task_src_files}
    ${libruntime_cmodel_api_src_files}
    ${libruntime_cmodel_context_src_files}
    ${libruntime_cmodel_stream_src_files}
    ${libruntime_cmodel_profile_src_files}
    ${libruntime_cmodel_arg_loader_files}
    ${libruntime_cmodel_callback_files}
    ${common_src_files_cmodel}
    ${libruntime_cmodel_src_files_optional}
    ${libruntime_cmodel_api_src_files}
    ${xpu_tprt_api_file}
)

set(libruntime_cmodel_v200_src_files
    src/common/inner_thread_local.cpp
    src/api/api.cc
    src/api_impl/api_decorator.cc
    src/api_impl/api_error.cc
    src/api_impl/api_impl.cc
    src/api_impl/api_impl_mbuf.cc
    src/api_impl/api_impl_david.cc

    # for V200
    src/api_impl/api_impl_creator.cc
    src/api_impl/v200/api_impl_creator_c.cc

    src/config.cc
    src/context/context.cc
    src/device/device.cc
    src/device/raw_device.cc
    src/device/raw_device_res_camodel.cc
    src/device/device_snapshot.cc
    src/device/raw_device_adpt_david.cc
    src/device/ctrl_msg.cc
    src/device/ctrl_sq.cc
    src/pool/bitmap.cc
    src/pool/buffer_allocator.cc
    src/pool/task_allocator.cc
    src/pool/spm_pool.cc
    src/pool/h2d_copy_mgr.cc
    src/pool/memory_list.cc
    src/pool/memory_pool.cc
    src/pool/memory_pool_manager.cc
    src/drv/driver.cc
    src/drv/v200/npu_driver.cc
    src/model/model.cc
    src/model/model_rebuild.cc
    src/model/capture_model.cc
    src/model/capture_model_utils.cc
    src/model/v200/capture_adapt.cc
    src/kernel/arg_loader/arg_loader_ub.cc
    src/kernel/arg_loader/arg_manage_david.cc
    src/kernel/arg_loader/arg_manage_pcie.cc
    src/kernel/arg_loader/arg_manage_ub.cc
    src/kernel/args/args_handle_allocator.cc
    src/kernel/args/para_convertor.cc
    src/kernel/v200_base/kernel.cc
    src/kernel/elf.cc
    src/kernel/kernel.cc
    src/kernel/v100/program_plat.cc
    src/kernel/v100/binary_loader_plat.cc
    src/kernel/module.cc
    src/kernel/program.cc
    src/kernel/program_common.cc
    src/launch/label.cc
    src/event/event.cc
    src/event/event_david.cc
    src/notify/notify.cc
    src/engine/logger.cc
    src/runtime.cc
    src/runtime_v100/runtime_adapt.cc
    src/utils/capability.cc
    src/utils/osal.cc
    src/engine/hwts/scheduler.cc
    src/dfx/atrace_log.cc
    src/dfx/coredump_c.cc
    src/dfx/fast_recover.cc
    src/dfx/pctrace.cc
    src/utils/subscribe.cc
    src/profiler/onlineprof.cc
    src/ttlv/ttlv_decoder_utils.cc
    src/ttlv/ttlv.cc
    src/ttlv/ttlv_word_decoder.cc
    src/ttlv/ttlv_sentence_decoder.cc
    src/ttlv/ttlv_paragraph_decoder.cc
    src/device/device_error_core_proc.cc
    src/device/device_error_proc.cc
    src/device/v200_base/device_error_proc.cc
    src/device/device_sq_cq_pool.cc
    src/device/sq_addr_memory_pool.cc
    src/task/stars_cond_isa_helper.cc
    src/utils/aicpu_scheduler_agent.cc
    src/device/device_msg_handler.cc
    src/device/aicpu_err_msg.cc
    src/task/host_task.cc
    src/stream/dvpp_grp.cc
    src/task/ctrl_res_pool.cpp
    src/engine/engine.cc
    src/engine/hwts/package_rebuilder.cc
    src/engine/stars/stars_engine.cc
    src/engine/hwts/direct_hwts_engine.cc
    src/task/v200_base/stars_david.cc
    src/notify/count_notify.cc
    src/launch/aix_c.cc
    src/launch/aicpu_c.cc
    src/launch/fusion_c.cc
    src/launch/dvpp_c.cc
    src/launch/cond_c.cc
    src/device/v200_base/device_error_proc_c.cc
    src/event/event_c.cc
    src/launch/memcpy_c.cc
    src/model/model_c.cc
    src/notify/notify_c.cc
    src/profiler/profiler_c.cc
    ${libruntime_cmodel_v200_task_src_files}
    ${libruntime_cmodel_api_src_files}
    ${libruntime_cmodel_context_src_files}
    ${libruntime_cmodel_v200_stream_src_files}
    ${libruntime_cmodel_profile_src_files}
    ${libruntime_cmodel_arg_loader_files}
    ${libruntime_cmodel_callback_files}
    src/plugin_manage/v200/plugin_old_arch.cc
    src/plugin_manage/runtime_keeper.cc
    ${common_src_files_cmodel}
    src/api_impl/v201/api_impl_v200_adapt.cc
    ${xpu_tprt_api_file}
    $<$<NOT:$<STREQUAL:${PRODUCT},ascend031>>:${libruntime_cmodel_src_files_optional}>
    $<$<NOT:$<STREQUAL:${PRODUCT},ascend031>>:${libruntime_cmodel_api_src_files}>
    $<$<STREQUAL:${PRODUCT},ascend031>:${libruntime_api_src_files_include_for_tiny}>
    $<$<STREQUAL:${PRODUCT},ascend031>:${libruntime_src_files_include_for_tiny}>
)

set(RUNTIME_CMODEL_INC_DIR_COMMON
    ${CMAKE_CURRENT_SOURCE_DIR}/inc
    ${CMAKE_CURRENT_SOURCE_DIR}/inc_c
    ${CMAKE_CURRENT_SOURCE_DIR}/inc/args
    ${CMAKE_CURRENT_SOURCE_DIR}/inc/arg_loader
    ${CMAKE_CURRENT_SOURCE_DIR}/inc/common
    ${CMAKE_CURRENT_SOURCE_DIR}/inc/context
    ${CMAKE_CURRENT_SOURCE_DIR}/inc/device
    ${CMAKE_CURRENT_SOURCE_DIR}/inc/dfx
    ${CMAKE_CURRENT_SOURCE_DIR}/inc/dqs
    ${CMAKE_CURRENT_SOURCE_DIR}/inc/drv
    ${CMAKE_CURRENT_SOURCE_DIR}/inc/engine
    ${CMAKE_CURRENT_SOURCE_DIR}/inc/engine/hwts
    ${CMAKE_CURRENT_SOURCE_DIR}/inc/event
    ${CMAKE_CURRENT_SOURCE_DIR}/inc/kernel
    ${CMAKE_CURRENT_SOURCE_DIR}/inc/launch
    ${CMAKE_CURRENT_SOURCE_DIR}/inc/model
    ${CMAKE_CURRENT_SOURCE_DIR}/inc/notify
    ${CMAKE_CURRENT_SOURCE_DIR}/inc/profiler
    ${CMAKE_CURRENT_SOURCE_DIR}/inc/soc
    ${CMAKE_CURRENT_SOURCE_DIR}/inc/spec
    ${CMAKE_CURRENT_SOURCE_DIR}/inc/sqe/v200_base
    ${CMAKE_CURRENT_SOURCE_DIR}/inc/sqe
    ${CMAKE_CURRENT_SOURCE_DIR}/inc/stars
    ${CMAKE_CURRENT_SOURCE_DIR}/inc/stream
    ${CMAKE_CURRENT_SOURCE_DIR}/inc/task
    ${CMAKE_CURRENT_SOURCE_DIR}/inc/utils
    ${CMAKE_CURRENT_SOURCE_DIR}/src/api
    ${CMAKE_CURRENT_SOURCE_DIR}/src/api_impl
    ${CMAKE_CURRENT_SOURCE_DIR}/src/engine
    ${CMAKE_CURRENT_SOURCE_DIR}/src/engine/hwts
    ${CMAKE_CURRENT_SOURCE_DIR}/src/engine/stars
    ${CMAKE_CURRENT_SOURCE_DIR}/src/stream
    ${CMAKE_CURRENT_SOURCE_DIR}/src/task/inc
    ${CMAKE_CURRENT_SOURCE_DIR}/src/profiler
    ${CMAKE_CURRENT_SOURCE_DIR}/src/pool
    ${CMAKE_CURRENT_SOURCE_DIR}/src/ttlv
    ${CMAKE_CURRENT_SOURCE_DIR}/src/device
    ${CMAKE_CURRENT_SOURCE_DIR}/src/drv
    ${CMAKE_CURRENT_SOURCE_DIR}/src/common
    ${CMAKE_CURRENT_SOURCE_DIR}/src/plugin_manage
    ${CMAKE_CURRENT_SOURCE_DIR}/src/kernel
    ${CMAKE_CURRENT_SOURCE_DIR}/src/kernel/arg_loader
    ${CMAKE_CURRENT_SOURCE_DIR}/src/kernel/args
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
    ${CMAKE_CURRENT_SOURCE_DIR}/inc/sqe/v200
    ${CMAKE_CURRENT_SOURCE_DIR}/inc/cond_isa/v100
)

set(libruntime_model_dev_info_src_files
    platform/610_lite/dev_info_proc_func.cc
    platform/910_B_93/dev_info_proc_func.cc
    platform/as31xm1/dev_info_proc_func.cc
    platform/cloud/dev_info_proc_func.cc
    platform/dc/dev_info_proc_func.cc
    platform/adc/dev_info_proc_func.cc
    platform/mini/dev_info_proc_func.cc
    platform/mini_v3/dev_info_proc_func.cc
    platform/tiny/dev_info_proc_func.cc
)

if(NOT ${TARGET_SYSTEM_NAME} STREQUAL "Windows")

# ---------------------------------- runtime_cmodel runtime_camodel ----------------------------------
SET(PRODUCT_TYPE_LIST ascend310 ascend610 bs9sx1a ascend310p ascend910 hi3796cv300es hi3796cv300cs ascend910B1 ascend310B ascend610Lite ascend950pr_9599 mc62cm12a)

add_library(runtime_model OBJECT
    ${libruntime_cmodel_src_files}
    ${libruntime_model_dev_info_src_files}
    src/drv/npu_driver.cc
    src/drv/npu_driver_mem.cc
    src/drv/npu_driver_queue.cc
    src/drv/npu_driver_res.cc
    src/drv/npu_driver_tiny.cpp
    src/drv/npu_driver_dcache_lock_common.cpp
    src/drv/npu_driver_dcache_lock_opb.cpp
    ${RUNTIME_DIR}/src/dfx/msprof/collector/dvvp/profapi/stub/profapi_stub.cpp
)

target_include_directories(runtime_model PRIVATE
    ${RUNTIME_CMODEL_INC_DIR}
    ${CMAKE_CURRENT_SOURCE_DIR}/../cmodel_driver
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
    $<BUILD_INTERFACE:atrace_headers>
    $<BUILD_INTERFACE:platform_headers>
    $<BUILD_INTERFACE:awatchdog_headers>
    json
)

set(libruntime_cmodel_v200_dev_info_src_files
    platform/950/dev_info_proc_func.cc
    platform/mc62cm12a/dev_info_proc_func.cc
    platform/910_96/dev_info_proc_func.cc
)

add_library(runtime_model_v200 OBJECT
    ${libruntime_cmodel_v200_src_files}
    ${libruntime_cmodel_v200_dev_info_src_files}
    src/drv/npu_driver.cc
    src/drv/npu_driver_mem.cc
    src/drv/npu_driver_queue.cc
    src/drv/npu_driver_res.cc
    src/drv/npu_driver_tiny.cpp
    src/drv/npu_driver_dcache_lock_common.cpp
    src/drv/npu_driver_dcache_lock_david.cpp
    ${RUNTIME_DIR}/src/dfx/msprof/collector/dvvp/profapi/stub/profapi_stub.cpp
)

target_include_directories(runtime_model_v200 PRIVATE
    ${RUNTIME_CMODEL_INC_DIR}
    ${CMAKE_CURRENT_SOURCE_DIR}/../cmodel_driver
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
    $<BUILD_INTERFACE:awatchdog_headers>
    $<BUILD_INTERFACE:platform_headers>
    $<BUILD_INTERFACE:atrace_headers>
    json
)

foreach(product_type ${PRODUCT_TYPE_LIST})
    # ---------------------------------- runtime_cmodel ----------------------------------
    if("${product_type}" STREQUAL "ascend950pr_9599")
    add_library(runtime_cmodel_${product_type}
        SHARED
        $<TARGET_OBJECTS:runtime_model_v200>
        $<TARGET_OBJECTS:runtime_platform_others>
        $<TARGET_OBJECTS:runtime_platform_910B>
        )
    else()
    add_library(runtime_cmodel_${product_type}
        SHARED
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
        -Wl, --no-as-needed
        unified_dlog
        -Wl, --as-needed
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
        SHARED
        $<TARGET_OBJECTS:runtime_model_v200>
        $<TARGET_OBJECTS:runtime_platform_others>
        $<TARGET_OBJECTS:runtime_platform_910B>
        )
    else()
    add_library(runtime_camodel_${product_type}
        SHARED
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
        -Wl, --no-as-needed
        unified_dlog
        -Wl, --as-needed
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
