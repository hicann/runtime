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

set(libruntime_v100_task_src_files
    ${RUNTIME_CORE_DIR}/src/task/ctrl_res_pool.cpp
    ${RUNTIME_CORE_DIR}/src/task/host_task.cc
    ${RUNTIME_CORE_DIR}/src/task/stars_cond_isa_helper.cc
    ${RUNTIME_CORE_DIR}/src/task/task.cc
    ${RUNTIME_CORE_DIR}/src/task/task_execute_time.cc
    ${RUNTIME_CORE_DIR}/src/task/task_info/barrier/barrier_task.cc
    ${RUNTIME_CORE_DIR}/src/task/task_info/cmo/cmo_task.cc
    ${RUNTIME_CORE_DIR}/src/task/task_info/cond_op/cond_op_label_task.cc
    ${RUNTIME_CORE_DIR}/src/task/task_info/cond_op/cond_op_stream_task.cc
    ${RUNTIME_CORE_DIR}/src/task/task_info/davinci/davinci_multiple_task.cc
    ${RUNTIME_CORE_DIR}/src/task/task_info/dump/dump_task.cc
    ${RUNTIME_CORE_DIR}/src/task/task_info/memory/memory_task.cc
    ${RUNTIME_CORE_DIR}/src/task/task_info/random_num_task.cc
    ${RUNTIME_CORE_DIR}/src/task/task_info/ringbuffer_maintain/ringbuffer_maintain_task.cc
    ${RUNTIME_CORE_DIR}/src/task/task_info/stream/stream_task.cc
    ${RUNTIME_CORE_DIR}/src/task/task_info/timeout_set/timeout_set_task.cc
    ${RUNTIME_CORE_DIR}/src/task/task_res_manage/task_res.cc
    ${RUNTIME_CORE_DIR}/src/task/task_submit/v100/task_submit.cc
    ${RUNTIME_CORE_DIR}/src/task/v100/stub_task.cc
    ${RUNTIME_CORE_DIR}/src/task/v100/task_checker.cc
)

set(libruntime_api_src_files
    ${RUNTIME_DIR}/src/runtime/api/api.cc
    ${RUNTIME_DIR}/src/runtime/api/api_c.cc
    ${RUNTIME_DIR}/src/runtime/api/api_c_context.cc
    ${RUNTIME_DIR}/src/runtime/api/api_c_device.cc
    ${RUNTIME_DIR}/src/runtime/api/api_c_event.cc
    ${RUNTIME_DIR}/src/runtime/api/api_c_kernel.cc
    ${RUNTIME_DIR}/src/runtime/api/api_c_mbuf.cc
    ${RUNTIME_DIR}/src/runtime/api/api_c_memory.cc
    ${RUNTIME_DIR}/src/runtime/api/api_c_model.cc
    ${RUNTIME_DIR}/src/runtime/api/api_c_soc.cc
    ${RUNTIME_DIR}/src/runtime/api/api_c_stream.cc
    ${RUNTIME_DIR}/src/runtime/api/api_c_tiny_stub.cc
    ${RUNTIME_DIR}/src/runtime/api/api_global_err.cc
    ${RUNTIME_DIR}/src/runtime/api/api_handle_guard.cc
    ${RUNTIME_DIR}/src/runtime/api/inner.cc
)

set(libruntime_api_impl_src_files
    ${RUNTIME_CORE_DIR}/src/api_impl/api_decorator.cc
    ${RUNTIME_CORE_DIR}/src/api_impl/api_error.cc
    ${RUNTIME_CORE_DIR}/src/api_impl/api_impl.cc
    ${RUNTIME_CORE_DIR}/src/api_impl/api_impl_creator.cc
    ${RUNTIME_CORE_DIR}/src/api_impl/api_impl_mbuf.cc
    ${RUNTIME_CORE_DIR}/src/api_impl/v100/api_impl_creator_c.cc
)

set(common_src_files
    ${RUNTIME_CORE_DIR}/src/common/args_buffer_guard.cc
    ${RUNTIME_CORE_DIR}/src/common/context_data_manage.cc
    ${RUNTIME_CORE_DIR}/src/common/dev_info_manage.cc
    ${RUNTIME_CORE_DIR}/src/common/errcode_manage.cc
    ${RUNTIME_CORE_DIR}/src/common/error_code.cc
    ${RUNTIME_CORE_DIR}/src/common/error_message_manage.cc
    ${RUNTIME_CORE_DIR}/src/common/global_state_manager.cc
    ${RUNTIME_CORE_DIR}/src/common/heterogenous.cc
    ${RUNTIME_CORE_DIR}/src/common/inner_thread_local.cpp
    ${RUNTIME_CORE_DIR}/src/common/performance_record.cc
    ${RUNTIME_CORE_DIR}/src/common/prof_ctrl_callback_manager.cc
    ${RUNTIME_CORE_DIR}/src/common/profiling_agent.cc
    ${RUNTIME_CORE_DIR}/src/common/register_memory.cc
    ${RUNTIME_CORE_DIR}/src/common/rt_log.cc
    ${RUNTIME_CORE_DIR}/src/common/runtime_handle_guard.cc
    ${RUNTIME_CORE_DIR}/src/common/soc_info.cc
    ${RUNTIME_CORE_DIR}/src/common/task_fail_callback_data_manager.cc
    ${RUNTIME_CORE_DIR}/src/common/thread_local_container.cc
    ${RUNTIME_CORE_DIR}/src/common/utils.cc
    ${RUNTIME_FEATURE_DIR}/xpu/xpu_task_fail_callback_data_manager.cc
)

set(libruntime_context_src_files
    ${RUNTIME_CORE_DIR}/src/context/context.cc
    ${RUNTIME_CORE_DIR}/src/context/context_manage.cc
)

set(libruntime_stream_common_src_files
    ${RUNTIME_CORE_DIR}/src/stream/coprocessor_stream.cc
    ${RUNTIME_CORE_DIR}/src/stream/ctrl_stream.cc
    ${RUNTIME_CORE_DIR}/src/stream/dvpp_grp.cc
    ${RUNTIME_CORE_DIR}/src/stream/engine_stream_observer.cc
    ${RUNTIME_CORE_DIR}/src/stream/stream.cc
    ${RUNTIME_CORE_DIR}/src/stream/stream_factory.cc
    ${RUNTIME_CORE_DIR}/src/stream/stream_sqcq_manage.cc
)

# v100
set(libruntime_stream_src_files
    ${libruntime_stream_common_src_files}
    ${RUNTIME_CORE_DIR}/src/stream/v100/stream_creator_c.cc
)

set(libruntime_profile_src_files
    ${RUNTIME_CORE_DIR}/src/profiler/api_profile_decorator.cc
    ${RUNTIME_CORE_DIR}/src/profiler/api_profile_log_decorator.cc
    ${RUNTIME_CORE_DIR}/src/profiler/npu_driver_record.cc
    ${RUNTIME_CORE_DIR}/src/profiler/onlineprof.cc
    ${RUNTIME_CORE_DIR}/src/profiler/prof_map_ge_model_device.cc
    ${RUNTIME_CORE_DIR}/src/profiler/profile_log_record.cc
    ${RUNTIME_CORE_DIR}/src/profiler/profiler.cc
)
set(libruntime_arg_loader_files
    ${RUNTIME_CORE_DIR}/src/kernel/arg_loader/uma_arg_loader.cc
    ${RUNTIME_CORE_DIR}/src/kernel/arg_loader/load_policy.cc
    ${RUNTIME_CORE_DIR}/src/kernel/arg_loader/stars_arg_manager.cc
)

set(runtime_src_pool_list
    ${RUNTIME_CORE_DIR}/src/pool/bitmap.cc
    ${RUNTIME_CORE_DIR}/src/pool/buffer_allocator.cc
    ${RUNTIME_CORE_DIR}/src/pool/h2d_copy_mgr.cc
    ${RUNTIME_CORE_DIR}/src/pool/memory_list.cc
    ${RUNTIME_CORE_DIR}/src/pool/memory_pool.cc
    ${RUNTIME_CORE_DIR}/src/pool/memory_pool_manager.cc
    ${RUNTIME_CORE_DIR}/src/pool/spm_pool.cc
    ${RUNTIME_CORE_DIR}/src/pool/task_allocator.cc
)

set(runtime_src_ttlv_list
    ${RUNTIME_CORE_DIR}/src/ttlv/ttlv.cc
    ${RUNTIME_CORE_DIR}/src/ttlv/ttlv_decoder_utils.cc
    ${RUNTIME_CORE_DIR}/src/ttlv/ttlv_paragraph_decoder.cc
    ${RUNTIME_CORE_DIR}/src/ttlv/ttlv_sentence_decoder.cc
    ${RUNTIME_CORE_DIR}/src/ttlv/ttlv_word_decoder.cc
)

set(libruntime_callback_files
    ${RUNTIME_CORE_DIR}/src/device/device_state_callback_manager.cc
    ${RUNTIME_CORE_DIR}/src/task/task_fail_callback_manager.cc
    ${RUNTIME_CORE_DIR}/src/stream/stream_state_callback_manager.cc
    ${RUNTIME_CORE_DIR}/src/event/event_state_callback_manager.cc
)

set(runtime_raw_device_adpt_common_list
    ${RUNTIME_CORE_DIR}/src/device/raw_device_adpt_comm.cc
)

set(runtime_src_aclgraph_list
    ${RUNTIME_CORE_DIR}/src/task/task_info/cond_op/aclgraph_cond_task.cc
    ${RUNTIME_FEATURE_DIR}/aclgraph/api_decorator_aclgraph.cc
    ${RUNTIME_FEATURE_DIR}/aclgraph/capture_model_utils.cc
    ${RUNTIME_FEATURE_DIR}/aclgraph/cond_handle.cc
    ${RUNTIME_FEATURE_DIR}/aclgraph/event_capture.cc
    ${RUNTIME_FEATURE_DIR}/aclgraph/model_aclgraph.cc
    ${RUNTIME_FEATURE_DIR}/aclgraph/stream_capture.cc
    ${RUNTIME_FEATURE_DIR}/aclgraph/tiny/capture_adapt_tiny_stub.cc
    ${RUNTIME_FEATURE_DIR}/aclgraph/tiny/capture_model_tiny_stub.cc
    ${RUNTIME_FEATURE_DIR}/aclgraph/tiny/context_tiny_stub_aclgraph.cc
    ${RUNTIME_FEATURE_DIR}/jetty/jetty_stub.cc
)

set(libruntime_src_files_include_for_arch5162
    ${RUNTIME_CORE_DIR}/src/api_impl/api_error_tiny_stub.cc
    ${RUNTIME_CORE_DIR}/src/api_impl/v100/api_impl_v100.cc
    ${RUNTIME_CORE_DIR}/src/context/context_tiny_stub.cc
    ${RUNTIME_CORE_DIR}/src/dfx/printf_tiny_stub.cc
    ${RUNTIME_CORE_DIR}/src/event/ipc_event_tiny_stub.cc
    ${RUNTIME_CORE_DIR}/src/pool/event_pool_tiny_stub.cc
    ${RUNTIME_CORE_DIR}/src/pool/event_expanding_tiny_stub.cc
    ${RUNTIME_DIR}/src/runtime/driver/npu_driver_tiny_stub.cc
    ${RUNTIME_CORE_DIR}/src/engine/engine_factory_tiny_stub.cc
    ${RUNTIME_CORE_DIR}/src/task/tiny/rdma_task_tiny_stub.cc
    ${RUNTIME_FEATURE_DIR}/ffts/ffts_task_tiny_stub.cc
    ${RUNTIME_FEATURE_DIR}/snapshot/tiny/device_snapshot_tiny_stub.cc
    ${RUNTIME_FEATURE_DIR}/snapshot/tiny/snapshot_callback_manager_tiny_stub.cc
    ${RUNTIME_FEATURE_DIR}/snapshot/tiny/snapshot_process_helper_tiny_stub.cc
    ${RUNTIME_CORE_DIR}/src/task/tiny/task_tiny_stub.cc
    ${RUNTIME_CORE_DIR}/src/profiler/api_profile_decorator_tiny_stub.cc
    ${RUNTIME_CORE_DIR}/src/profiler/api_profile_log_decoratoc_tiny_stub.cc
)

set(runtime_src_device_list
    ${RUNTIME_CORE_DIR}/src/device/aicpu_err_msg.cc
    ${RUNTIME_CORE_DIR}/src/device/ctrl_msg.cc
    ${RUNTIME_CORE_DIR}/src/device/ctrl_sq.cc
    ${RUNTIME_CORE_DIR}/src/device/device.cc
    ${RUNTIME_CORE_DIR}/src/device/device_error_core_proc.cc
    ${RUNTIME_CORE_DIR}/src/device/device_error_proc.cc
    ${RUNTIME_CORE_DIR}/src/device/device_msg_handler.cc
    ${RUNTIME_CORE_DIR}/src/device/device_sq_cq_pool.cc
    ${RUNTIME_CORE_DIR}/src/device/ini_parse_utils.cc
    ${RUNTIME_CORE_DIR}/src/device/raw_device.cc
    ${RUNTIME_CORE_DIR}/src/device/raw_device_res.cc
    ${RUNTIME_CORE_DIR}/src/device/sq_addr_memory_pool.cc
    ${RUNTIME_CORE_DIR}/src/device/v100/device_error_proc.cc
)

set(runtime_src_kernel_list
    ${RUNTIME_CORE_DIR}/src/kernel/args/args_handle_allocator.cc
    ${RUNTIME_CORE_DIR}/src/kernel/args/para_convertor.cc
    ${RUNTIME_CORE_DIR}/src/kernel/binary_loader.cc
    ${RUNTIME_CORE_DIR}/src/kernel/elf.cc
    ${RUNTIME_CORE_DIR}/src/kernel/funcsymbol_table.cc
    ${RUNTIME_CORE_DIR}/src/kernel/json_parse.cc
    ${RUNTIME_CORE_DIR}/src/kernel/kernel.cc
    ${RUNTIME_CORE_DIR}/src/kernel/kernel_utils.cc
    ${RUNTIME_CORE_DIR}/src/kernel/module.cc
    ${RUNTIME_CORE_DIR}/src/kernel/program.cc
    ${RUNTIME_CORE_DIR}/src/kernel/program_common.cc
    ${RUNTIME_CORE_DIR}/src/kernel/symbol_table.cc
    ${RUNTIME_CORE_DIR}/src/kernel/v100/kernel.cc
    ${RUNTIME_CORE_DIR}/src/kernel/v100/program_plat.cc
)

set(libruntime_src_files
    ${runtime_src_pool_list}
    ${runtime_src_ttlv_list}
    ${libruntime_callback_files}
    ${runtime_src_aclgraph_list}
    ${runtime_raw_device_adpt_common_list}
    ${libruntime_v100_task_src_files}
    ${libruntime_context_src_files}
    ${libruntime_stream_src_files}
    ${libruntime_arg_loader_files}
    ${libruntime_src_files_include_for_arch5162}
    ${libruntime_api_impl_src_files}
    ${runtime_src_device_list}
    ${runtime_src_kernel_list}
    ${RUNTIME_CORE_DIR}/src/dfx/atrace_log.cc
    ${RUNTIME_CORE_DIR}/src/dfx/fast_recover.cc
    ${RUNTIME_CORE_DIR}/src/dfx/kernel_dfx_info.cc
    ${RUNTIME_CORE_DIR}/src/dfx/pctrace.cc
    ${RUNTIME_CORE_DIR}/src/engine/engine.cc
    ${RUNTIME_CORE_DIR}/src/engine/hwts/package_rebuilder.cc
    ${RUNTIME_CORE_DIR}/src/engine/hwts/scheduler.cc
    ${RUNTIME_CORE_DIR}/src/engine/logger.cc
    ${RUNTIME_CORE_DIR}/src/engine/stars/stars_engine.cc
    ${RUNTIME_CORE_DIR}/src/event/event.cc
    ${RUNTIME_CORE_DIR}/src/launch/aicpu_stars.cc
    ${RUNTIME_CORE_DIR}/src/launch/aix_stars.cc
    ${RUNTIME_CORE_DIR}/src/launch/cmo_barrier_common.cc
    ${RUNTIME_CORE_DIR}/src/launch/cmo_barrier_stars.cc
    ${RUNTIME_CORE_DIR}/src/launch/cond_stars.cc
    ${RUNTIME_CORE_DIR}/src/launch/dvpp_stars.cc
    ${RUNTIME_CORE_DIR}/src/launch/label.cc
    ${RUNTIME_CORE_DIR}/src/launch/label_common.cc
    ${RUNTIME_CORE_DIR}/src/launch/label_stars.cc
    ${RUNTIME_CORE_DIR}/src/launch/memcpy_stars.cc
    ${RUNTIME_CORE_DIR}/src/launch/memory_common.cc
    ${RUNTIME_CORE_DIR}/src/launch/memory_stars.cc
    ${RUNTIME_CORE_DIR}/src/launch/xpu_aicpu_c_stub.cc
    ${RUNTIME_CORE_DIR}/src/memory/mem_type.cc
    ${RUNTIME_CORE_DIR}/src/notify/notify.cc
    ${RUNTIME_CORE_DIR}/src/plugin_manage/runtime_keeper.cc
    ${RUNTIME_CORE_DIR}/src/plugin_manage/v100/plugin_old_arch.cc
    ${RUNTIME_CORE_DIR}/src/runtime.cc
    ${RUNTIME_CORE_DIR}/src/runtime_v100/runtime_adapt.cc
    ${RUNTIME_CORE_DIR}/src/utils/aicpu_scheduler_agent.cc
    ${RUNTIME_CORE_DIR}/src/utils/capability.cc
    ${RUNTIME_CORE_DIR}/src/utils/osal.cc
    ${RUNTIME_CORE_DIR}/src/utils/subscribe.cc
    ${RUNTIME_DIR}/src/runtime/driver/driver.cc
    ${RUNTIME_DIR}/src/runtime/driver/v100/npu_driver.cc
    ${RUNTIME_FEATURE_DIR}/model/model.cc
    ${RUNTIME_FEATURE_DIR}/model/model_rebuild.cc
    ${RUNTIME_FEATURE_DIR}/soma/soma.cc
    ${RUNTIME_FEATURE_DIR}/soma/stream_mem_pool.cc
)

set(XPU_TPRT_INC_DIR
    ${RUNTIME_DIR}/src/tprt/inc/external
    ${RUNTIME_DIR}/src/tprt/feature/inc
)

set(RUNTIME_INC_DIR_ARCH5162
    ${RUNTIME_DIR}/src/runtime/core/inc
    ${RUNTIME_CORE_DIR}/inc_c
    ${RUNTIME_FEATURE_DIR}/fusion
    ${RUNTIME_FEATURE_DIR}/ccu
    ${RUNTIME_DIR}/src/runtime/core/inc/args
    ${RUNTIME_DIR}/src/runtime/core/inc/arg_loader
    ${RUNTIME_DIR}/src/runtime/inc/common
    ${RUNTIME_DIR}/src/runtime/core/inc/common
    ${RUNTIME_DIR}/src/runtime/core/inc/cond_handle
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
    ${RUNTIME_DIR}/src/runtime/feature/jetty
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
    ${RUNTIME_DIR}/src/runtime/core/inc/dqs
    ${RUNTIME_DIR}/src/runtime/core/inc/sqe/v200
    ${RUNTIME_DIR}/src/runtime/core/inc/sqe/v200_base
    ${RUNTIME_DIR}/src/inc
    ${RUNTIME_DIR}/pkg_inc/tsd/
    ${RUNTIME_DIR}/pkg_inc/aicpu_sched/
    ${RUNTIME_DIR}/pkg_inc/aicpu_sched/common
    ${RUNTIME_DIR}/src/queue_schedule/dgwclient/inc/
    ${RUNTIME_DIR}/src/dfx/error_manager
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

set(libruntime_aclrt_impl_src_files
    ${RUNTIME_DIR}/src/acl/aclrt_impl/acl.cpp
    ${RUNTIME_DIR}/src/acl/aclrt_impl/log.cpp
    ${RUNTIME_DIR}/src/acl/aclrt_impl/device.cpp
    ${RUNTIME_DIR}/src/acl/aclrt_impl/dfx.cpp
    ${RUNTIME_DIR}/src/acl/aclrt_impl/event.cpp
    ${RUNTIME_DIR}/src/acl/aclrt_impl/stream.cpp
    ${RUNTIME_DIR}/src/acl/aclrt_impl/memory.cpp
    ${RUNTIME_DIR}/src/acl/aclrt_impl/context.cpp
    ${RUNTIME_DIR}/src/acl/aclrt_impl/callback.cpp
    ${RUNTIME_DIR}/src/acl/aclrt_impl/group.cpp
    ${RUNTIME_DIR}/src/acl/aclrt_impl/kernel.cpp
    ${RUNTIME_DIR}/src/acl/aclrt_impl/notify.cpp
    ${RUNTIME_DIR}/src/acl/aclrt_impl/label.cpp
    ${RUNTIME_DIR}/src/acl/aclrt_impl/acl_rt_impl_base.cpp
    ${RUNTIME_DIR}/src/acl/aclrt_impl/model_ri.cpp
    ${RUNTIME_DIR}/src/acl/aclrt_impl/data_buffer.cpp
    ${RUNTIME_DIR}/src/acl/aclrt_impl/allocator.cpp
    ${RUNTIME_DIR}/src/acl/aclrt_impl/callback_api.cpp
    ${RUNTIME_DIR}/src/acl/aclrt_impl/init_callback_manager.cpp
    ${RUNTIME_DIR}/src/acl/aclrt_impl/snapshot.cpp
    ${RUNTIME_DIR}/src/acl/aclrt_impl/types/fp16.cpp
    ${RUNTIME_DIR}/src/acl/aclrt_impl/types/fp16_impl.cpp
    ${RUNTIME_DIR}/src/acl/common/log_inner.cpp
    ${RUNTIME_DIR}/src/acl/common/prof_reporter.cpp
    ${RUNTIME_DIR}/src/acl/common/resource_statistics.cpp
    ${RUNTIME_DIR}/src/acl/common/json_parser.cpp
    ${RUNTIME_DIR}/src/acl/utils/string_utils.cpp
    ${RUNTIME_DIR}/src/acl/utils/cann_info_utils.cpp
    ${RUNTIME_DIR}/src/acl/utils/hash_utils.cpp
    ${RUNTIME_DIR}/src/acl/utils/file_utils.cpp
    ${RUNTIME_DIR}/src/acl/aclrt_impl/toolchain/dump.cpp
    ${RUNTIME_DIR}/src/acl/aclrt_impl/toolchain/profiling.cpp
    ${RUNTIME_DIR}/src/acl/aclrt_impl/toolchain/profiling_manager.cpp
    ${RUNTIME_DIR}/src/acl/aclrt_impl/toolchain/dump_shim.cpp
)

set_source_files_properties(${libruntime_aclrt_impl_src_files}
    PROPERTIES
        COMPILE_OPTIONS "-O2;-ftrapv"
        COMPILE_DEFINITIONS "OS_TYPE=0;FUNC_VISIBILITY"
)

macro(add_runtime_library target_name)
    add_library(${target_name} SHARED
        ${common_src_files}
        ${libruntime_api_src_files}
        ${libruntime_src_files}
        ${libruntime_aclrt_impl_src_files}
        ${RUNTIME_DIR}/src/runtime/driver/npu_driver.cc
        ${RUNTIME_DIR}/src/runtime/driver/npu_driver_mem.cc
        ${RUNTIME_DIR}/src/runtime/driver/npu_driver_queue.cc
        ${RUNTIME_DIR}/src/runtime/driver/npu_driver_res.cc
        ${RUNTIME_DIR}/src/runtime/driver/npu_driver_tiny.cpp
        ${RUNTIME_DIR}/src/runtime/driver/npu_driver_dcache_lock_common.cpp
        ${RUNTIME_DIR}/src/runtime/driver/npu_driver_dcache_lock_opb.cpp
        $<TARGET_OBJECTS:runtime_platform_arch5162>
    )

    target_compile_definitions(${target_name} PRIVATE
        LOG_CPP
        -DSTATIC_RT_LIB=1  # set 1 when not split so
        -DRUNTIME_API=0  # set 1 when split so and in libruntime.so
    )

    set_target_properties(${target_name}
        PROPERTIES
        OUTPUT_NAME ${target_name}
    )

    target_compile_options(${target_name} PRIVATE
        -O2
        -fvisibility=hidden
        -fno-common
        -fno-strict-aliasing
        -Werror
        -Wextra
        -Wfloat-equal
    )

    target_include_directories(${target_name} PRIVATE
        ${RUNTIME_INC_DIR_ARCH5162}
        ${RUNTIME_DIR}/include
        ${RUNTIME_DIR}/src/acl/aclrt_impl
        ${RUNTIME_DIR}/src/acl/common
        ${RUNTIME_DIR}/src/acl/utils
        ${RUNTIME_DIR}/src/acl
        ${RUNTIME_DIR}/include/external
        ${RUNTIME_DIR}/pkg_inc
        ${RUNTIME_DIR}/pkg_inc/runtime
        ${RUNTIME_DIR}/pkg_inc/runtime/runtime
        ${RUNTIME_DIR}/pkg_inc/dump
        ${RUNTIME_DIR}/src/dfx/error_manager
        ${RUNTIME_DIR}/src/dfx/adump/inc/metadef/external
        ${RUNTIME_DIR}/include/dfx
    )

    target_link_libraries(${target_name}
        PRIVATE
            $<BUILD_INTERFACE:intf_pub>
            $<BUILD_INTERFACE:runtime_warning_options>
            $<BUILD_INTERFACE:platform_headers>
            $<BUILD_INTERFACE:mmpa_headers>
            $<BUILD_INTERFACE:msprof_headers>
            $<BUILD_INTERFACE:slog_headers>
            $<BUILD_INTERFACE:awatchdog_headers>
            $<BUILD_INTERFACE:npu_runtime_headers>
            $<BUILD_INTERFACE:npu_runtime_inner_headers>
            $<BUILD_INTERFACE:atrace_headers>
            dl
            rt
            -Wl,--no-as-needed
            mmpa
            c_sec
            profapi_share
            error_manager
            ascend_hal_stub
            awatchdog_share
            unified_dlog
            json
            platform
            -Wl,--as-needed
            -Wl,-Bsymbolic
        PUBLIC
            npu_runtime_headers
    )
    if(ENABLE_ASAN)
        target_compile_definitions(${target_name} PRIVATE
                __RT_ENABLE_ASAN__)
    endif()
endmacro()

add_runtime_library(runtime)

install(TARGETS runtime DESTINATION ${INSTALL_LIBRARY_DIR} OPTIONAL)
