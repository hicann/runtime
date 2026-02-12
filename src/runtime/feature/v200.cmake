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

set(xpu_tprt_api_file
    src/api_impl/api_error_xpu.cc
    src/api_impl/v100/api_impl_v100.cc
    src/api_impl/api_decorator_xpu.cc
)

set(xpu_tprt_src_file
    src/task/task_submit/xpu/task_xpu.cc
    src/task/task_info/task_manager_xpu.cc
    src/task/task_info/xpu_kernel_task.cc
    src/task/task_recycle/xpu/task_xpu_recycle.cc
    src/context/xpu_context.cc
    src/stream/stream_sqcq_manage_xpu.cc
    src/stream/stream_xpu.cc
    src/stream/stream_xpu_c.cc
    src/device/xpu_device.cc
    src/pool/h2h_copy_mgr.cc
    src/drv/xpu_driver.cc
    src/kernel/arg_loader/arg_loader_xpu.cc
    src/kernel/arg_loader/arg_manage_xpu.cc
    src/launch/xpu_aicpu_c.cc
    src/kernel/xpu/binary_loader_plat.cc
    src/kernel/xpu/program_plat.cc
    src/kernel/json_parse.cc
    src/api_impl/v200/api_impl_v200.cc
    src/kernel/v200_base/binary_loader_c.cc
)

set(david_series_common_task_src_file
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

set(libruntime_v200_task_src_files
    ${david_series_common_task_src_file}

    # david & solomon 专用差异化文件
    src/task/v200/task_proc_func_register.cc
    src/task/v200/memcpy_task_to_sqe.cc
    src/task/v200/aicpu_task_to_sqe.cc
    src/task/v200/task_checker.cc
)

set(libruntime_v201_task_src_files
   ${david_series_common_task_src_file}

    # v201 专用差异化文件
    src/task/v201/task_proc_func_register.cc
    src/task/v201/dqs_task.cc
    src/task/v201/memcpy_task_to_sqe.cc
    src/task/v201/task_checker.cc
    src/task/v201/aicpu_task_to_sqe.cc
    src/launch/v201/dqs_c.cc
)

set(libruntime_v200_context_src_files
    src/context/context.cc
    src/context/context_manage.cc
    src/context/context_protect.cc
)

set(libruntime_v200_stream_common_src_files
    src/stream/stream_sqcq_manage.cc
    src/stream/engine_stream_observer.cc
    src/stream/stream.cc
    src/stream/ctrl_stream.cc
    src/stream/coprocessor_stream.cc
    src/stream/tsch_stream.cc
    src/stream/stream_factory.cc
)

# david
set(libruntime_v200_stream_src_files
    ${libruntime_v200_stream_common_src_files}

    src/stream/stream_c.cc
    src/stream/stream_david.cc
    src/stream/v200/stream_creator_c.cc
)

# v201
set(libruntime_v201_stream_src_files
    ${libruntime_v200_stream_common_src_files}

    src/stream/stream_c.cc
    src/stream/stream_david.cc
    src/stream/v201/stream_with_dqs.cc
    src/stream/v201/stream_creator_c.cc
)

set(libruntime_v200_profile_src_files
    src/profiler/profiler.cc
    src/profiler/api_profile_decorator.cc
    src/profiler/api_profile_log_decorator.cc
    src/profiler/prof_map_ge_model_device.cc
    src/profiler/profile_log_record.cc
    src/profiler/npu_driver_record.cc
)
set(libruntime_v200_arg_loader_files
    src/kernel/arg_loader/uma_arg_loader.cc
)

set(libruntime_v200_callback_files
    src/device/device_state_callback_manager.cc
    src/task/task_fail_callback_manager.cc
    src/stream/stream_state_callback_manager.cc
)

#------------------------- exclude these files in tiny(ascend031) ---------------------
set(libruntime_v200_src_files_exclude_for_tiny
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

# v201 v200 common files, so please check carefully
set(libruntime_v200_v201_common_src_files
    src/common/inner_thread_local.cpp
    src/api_impl/api_decorator.cc
    src/api_impl/api_error.cc
    src/api_impl/api_impl_david.cc
    src/api_impl/api_impl.cc
    src/api_impl/api_impl_mbuf.cc
    src/config.cc
    src/context/context.cc
    src/device/device.cc
    src/device/raw_device.cc
    src/device/raw_device_res.cc
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
    src/model/model.cc
    src/model/model_rebuild.cc
    src/model/v200/capture_adapt.cc
    src/model/capture_model.cc
    src/model/capture_model_utils.cc
    src/kernel/arg_loader/arg_loader_ub.cc
    src/kernel/arg_loader/arg_manage_david.cc
    src/kernel/arg_loader/arg_manage_pcie.cc
    src/kernel/arg_loader/arg_manage_ub.cc
    src/kernel/args/args_handle_allocator.cc
    src/kernel/args/para_convertor.cc
    src/kernel/v200_base/kernel.cc
    src/kernel/elf.cc
    src/kernel/kernel.cc
    src/kernel/module.cc
    src/kernel/program.cc
    src/kernel/program_common.cc
    src/launch/label.cc
    src/event/event.cc
    src/event/event_david.cc
    src/notify/notify.cc
    src/engine/logger.cc
    src/runtime.cc
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
    src/memory/mem_type.cc
)

#------------------------- runtime v200 -------------------------
set(libruntime_v200_src_files
    ${libruntime_v200_v201_common_src_files}

    # for v200
    src/api_impl/api_impl_creator.cc
    src/api_impl/v200/api_impl_creator_c.cc
    src/drv/v200/npu_driver.cc
    src/runtime_v200/runtime_adapt.cc
    ${libruntime_v200_task_src_files}
    ${libruntime_v200_context_src_files}
    ${libruntime_v200_stream_src_files}
    ${libruntime_v200_profile_src_files}
    ${libruntime_v200_arg_loader_files}
    ${libruntime_v200_callback_files}
    ${xpu_tprt_api_file}
    ${xpu_tprt_src_file}
    src/plugin_manage/v200/plugin_old_arch.cc
    $<$<NOT:$<STREQUAL:${PRODUCT},ascend031>>:${libruntime_v200_src_files_exclude_for_tiny}>
    $<$<STREQUAL:${PRODUCT},ascend031>:${libruntime_src_files_include_for_tiny}>
)

#-------------------------------- runtime v201 -------------------------
set(libruntime_v201_src_files
    ${libruntime_v200_v201_common_src_files}

    # for v201
    src/runtime_v100/runtime_adapt.cc
    src/api_impl/api_impl_creator.cc
    src/api_impl/v201/api_impl_creator_c.cc
    src/api_impl/v201/api_impl_v201.cc
    src/api_impl/v201/api_impl_v200_adapt.cc
    src/common/ioctl/v201/ioctl_utils.cc
    src/drv/v201/npu_driver.cc
    src/task/v201/stars_dqs_cond_isa_helper.cc
    src/kernel/v100/binary_loader_c.cc
    src/kernel/v100/program_plat.cc
    src/kernel/v100/binary_loader_plat.cc
    src/device/device_snapshot.cc
    ${libruntime_v201_task_src_files}
    ${libruntime_v200_context_src_files}
    ${libruntime_v201_stream_src_files}
    ${libruntime_v200_profile_src_files}
    ${libruntime_v200_arg_loader_files}
    ${libruntime_v200_callback_files}
    ${xpu_tprt_api_file}
    src/plugin_manage/v100/plugin_old_arch.cc
    $<$<NOT:$<STREQUAL:${PRODUCT},ascend031>>:${libruntime_v200_src_files_exclude_for_tiny}>
)
#---------------------------------------------------------------------------------------
set(XPU_TPRT_INC_DIR
    ${RUNTIME_DIR}/src/runtime/tprt/inc/external
    ${RUNTIME_DIR}/src/runtime/tprt/feature/inc
)

set(RUNTIME_INC_DIR_COMMON_V200
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
    ${CMAKE_CURRENT_SOURCE_DIR}/src/memory
    ${RUNTIME_DIR}/src/inc
    ${RUNTIME_DIR}/src/inc/runtime
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

set(RUNTIME_INC_DIR
    ${RUNTIME_INC_DIR_COMMON_V200}
    ${CMAKE_CURRENT_SOURCE_DIR}/inc/sqe/v200
    ${CMAKE_CURRENT_SOURCE_DIR}/inc/cond_isa/v100
    ${XPU_TPRT_INC_DIR}
)

set(RUNTIME_INC_DIR_V201
    ${RUNTIME_INC_DIR_COMMON_V200}
    ${CMAKE_CURRENT_SOURCE_DIR}/inc/sqe/v201
    ${CMAKE_CURRENT_SOURCE_DIR}/inc/cond_isa/v201
    ${CMAKE_CURRENT_SOURCE_DIR}/src/task/inc/v201
    ${CMAKE_CURRENT_SOURCE_DIR}/src/stream/v201
    ${CMAKE_CURRENT_SOURCE_DIR}/src/common/ioctl/v201
)

set(libruntime_v200_dev_info_src_files
    platform/950/dev_info_proc_func.cc
    platform/910_96/dev_info_proc_func.cc
    platform/610_lite/dev_info_proc_func.cc
    platform/910_B_93/dev_info_proc_func.cc
    platform/as31xm1/dev_info_proc_func.cc
    platform/cloud/dev_info_proc_func.cc
    platform/dc/dev_info_proc_func.cc
    platform/adc/dev_info_proc_func.cc
    platform/mini/dev_info_proc_func.cc
    platform/mini_v3/dev_info_proc_func.cc
    platform/tiny/dev_info_proc_func.cc
    platform/mc62cm12a/dev_info_proc_func.cc
)

set(libruntime_v201_dev_info_src_files
    platform/mc62cm12a/dev_info_proc_func.cc
)

#------------------------- runtime -------------------------
macro(add_runtime_v200_library target_name)
    if(${TARGET_SYSTEM_NAME} STREQUAL "Windows")
        add_library(${target_name} SHARED
            ${libruntime_v200_src_files}
            ${libruntime_v200_dev_info_src_files}
            src/drv/npu_driver.cc
            src/drv/npu_driver_win.cc
            src/drv/npu_driver_tiny.cpp
            src/drv/npu_driver_dcache_lock_common.cpp
            src/drv/npu_driver_dcache_lock_opb.cpp
            $<TARGET_OBJECTS:profapi_stub>
        )
    else()
        add_library(${target_name} SHARED
            ${libruntime_v200_src_files}
            ${libruntime_v200_dev_info_src_files}
            src/drv/npu_driver.cc
            src/drv/npu_driver_mem.cc
            src/drv/npu_driver_queue.cc
            src/drv/npu_driver_res.cc
            src/drv/npu_driver_tiny.cpp
            src/drv/npu_driver_dcache_lock_common.cpp
            src/drv/npu_driver_dcache_lock_david.cpp
        )
    endif()

    target_compile_definitions(${target_name} PRIVATE
        LOG_CPP
        CANN_RUNTIME
        -DSTATIC_RT_LIB=0
        -DRUNTIME_API=0
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
        $<$<STREQUAL:${CMAKE_CXX_COMPILER_VERSION},7.3.0>:-Werror>
        $<$<NOT:$<STREQUAL:${TARGET_SYSTEM_NAME},Windows>>:-Wextra>
        $<$<NOT:$<STREQUAL:${TARGET_SYSTEM_NAME},Windows>>:-Wfloat-equal>
    )

    target_include_directories(${target_name} PRIVATE
        ${RUNTIME_INC_DIR}
    )

    target_link_libraries(${target_name}
        PRIVATE
            $<BUILD_INTERFACE:intf_pub>
            $<BUILD_INTERFACE:mmpa_headers>
            $<BUILD_INTERFACE:msprof_headers>
            $<BUILD_INTERFACE:slog_headers>
            $<BUILD_INTERFACE:npu_runtime_headers>
            $<BUILD_INTERFACE:atrace_headers>
            $<$<NOT:$<STREQUAL:${TARGET_SYSTEM_NAME},Windows>>:dl>
            $<$<NOT:$<STREQUAL:${TARGET_SYSTEM_NAME},Windows>>:rt>
            -Wl,--no-as-needed
            mmpa
            c_sec
            $<$<NOT:$<STREQUAL:${TARGET_SYSTEM_NAME},Windows>>:profapi_share>
            # error_manager仅在windows形态暂不需要
            $<$<NOT:$<STREQUAL:${TARGET_SYSTEM_NAME},Windows>>:error_manager>
            # ascend_hal仅在windows形态需要,小海思形态不需要链接ascend_hal，其他形态均链接ascend_hal_stub
            $<$<STREQUAL:${TARGET_SYSTEM_NAME},Windows>:ascend_hal>
            $<$<AND:$<NOT:$<STREQUAL:${TARGET_SYSTEM_NAME},Windows>>,$<NOT:$<STREQUAL:${ENABLE_TSD},true>>>:ascend_hal_stub>
            awatchdog_share
            unified_dlog
            $<$<AND:$<NOT:$<STREQUAL:${PRODUCT},ascend031>>,$<NOT:$<STREQUAL:${PRODUCT},ascend610>>,$<NOT:$<STREQUAL:${PRODUCT},ascend610Lite>>>:atrace_share>
            $<$<NOT:$<STREQUAL:${PRODUCT},ascend031>>:json>
            platform
            xpu_tprt
            runtime_common
            -Wl,--as-needed
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

#------------------------- runtime v201 -------------------------
macro(add_runtime_v201_library target_name)
    if(${TARGET_SYSTEM_NAME} STREQUAL "Windows")
        add_library(${target_name} SHARED
            ${libruntime_v201_src_files}
            ${libruntime_v201_dev_info_src_files}
            src/drv/npu_driver.cc
            src/drv/npu_driver_win.cc
            src/drv/npu_driver_tiny.cpp
            src/drv/npu_driver_dcache_lock_common.cpp
            src/drv/npu_driver_dcache_lock_opb.cpp
            $<TARGET_OBJECTS:profapi_stub>
        )
    else()
        add_library(${target_name} SHARED
            ${libruntime_v201_src_files}
            ${libruntime_v201_dev_info_src_files}
            src/drv/npu_driver.cc
            src/drv/npu_driver_mem.cc
            src/drv/npu_driver_queue.cc
            src/drv/npu_driver_res.cc
            src/drv/npu_driver_tiny.cpp
            src/drv/npu_driver_dcache_lock_common.cpp
            src/drv/npu_driver_dcache_lock_david.cpp
        )
    endif()

    target_compile_definitions(${target_name} PRIVATE
        LOG_CPP
        CANN_RUNTIME
        -DSTATIC_RT_LIB=0
        -DRUNTIME_API=0
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
        $<$<NOT:$<STREQUAL:${TARGET_SYSTEM_NAME},Windows>>:-Wextra>
        $<$<NOT:$<STREQUAL:${TARGET_SYSTEM_NAME},Windows>>:-Wfloat-equal>
    )

    target_include_directories(${target_name} PRIVATE
        ${RUNTIME_INC_DIR_V201}
    )

    target_link_libraries(${target_name}
        PRIVATE
            $<BUILD_INTERFACE:intf_pub>
            $<BUILD_INTERFACE:mmpa_headers>
            $<BUILD_INTERFACE:msprof_headers>
            $<BUILD_INTERFACE:slog_headers>
            $<BUILD_INTERFACE:npu_runtime_headers>
            $<BUILD_INTERFACE:atrace_headers>
            $<$<NOT:$<STREQUAL:${TARGET_SYSTEM_NAME},Windows>>:dl>
            $<$<NOT:$<STREQUAL:${TARGET_SYSTEM_NAME},Windows>>:rt>
            -Wl,--no-as-needed
            mmpa
            c_sec
            $<$<NOT:$<STREQUAL:${TARGET_SYSTEM_NAME},Windows>>:profapi_share>
            # error_manager仅在windows形态暂不需要
            $<$<NOT:$<STREQUAL:${TARGET_SYSTEM_NAME},Windows>>:error_manager>
            # ascend_hal仅在windows形态需要,小海思形态不需要链接ascend_hal，其他形态均链接ascend_hal_stub
            $<$<STREQUAL:${TARGET_SYSTEM_NAME},Windows>:ascend_hal>
            $<$<AND:$<NOT:$<STREQUAL:${TARGET_SYSTEM_NAME},Windows>>,$<NOT:$<STREQUAL:${ENABLE_TSD},true>>>:ascend_hal_stub>
            awatchdog_share
            unified_dlog
            $<$<AND:$<NOT:$<STREQUAL:${PRODUCT},ascend031>>,$<NOT:$<STREQUAL:${PRODUCT},ascend610>>,$<NOT:$<STREQUAL:${PRODUCT},ascend610Lite>>>:atrace_share>
            $<$<NOT:$<STREQUAL:${PRODUCT},ascend031>>:json>
            platform
            runtime_common
            -Wl,--as-needed
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

add_runtime_v200_library(runtime_v200)
add_runtime_v201_library(runtime_v201)

install(TARGETS runtime_v200 DESTINATION ${INSTALL_LIBRARY_DIR} OPTIONAL)
install(TARGETS runtime_v201 DESTINATION ${INSTALL_LIBRARY_DIR} OPTIONAL)