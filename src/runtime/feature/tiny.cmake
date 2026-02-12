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

set(libruntime_v100_task_src_files
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

set(libruntime_api_src_files
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

set(common_src_files
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

set(libruntime_context_src_files
    src/context/context.cc
    src/context/context_manage.cc
    src/context/context_protect.cc
)

set(libruntime_stream_common_src_files
    src/stream/stream_sqcq_manage.cc
    src/stream/engine_stream_observer.cc
    src/stream/stream.cc
    src/stream/ctrl_stream.cc
    src/stream/coprocessor_stream.cc
    src/stream/tsch_stream.cc
    src/stream/stream_factory.cc
)

# v100
set(libruntime_stream_src_files
    ${libruntime_stream_common_src_files}

    src/stream/v100/stream_creator_c.cc
)

set(libruntime_profile_src_files
    src/profiler/profiler.cc
    src/profiler/api_profile_decorator.cc
    src/profiler/api_profile_log_decorator.cc
    src/profiler/prof_map_ge_model_device.cc
    src/profiler/profile_log_record.cc
    src/profiler/npu_driver_record.cc
)
set(libruntime_arg_loader_files
    src/kernel/arg_loader/uma_arg_loader.cc
)

set(libruntime_callback_files
    src/device/device_state_callback_manager.cc
    src/task/task_fail_callback_manager.cc
    src/stream/stream_state_callback_manager.cc
)

set(libruntime_src_files_include_for_tiny
    src/api_impl/api_error_tiny_stub.cc
    src/api_impl/api_impl_tiny_stub.cc
    src/api_impl/v100/api_impl_v100.cc
    src/context/context_tiny_stub.cc
    src/dfx/printf_tiny_stub.cc
    src/event/ipc_event_tiny_stub.cc
    src/pool/event_pool_tiny_stub.cc
    src/pool/event_expanding_tiny_stub.cc
    src/drv/npu_driver_tiny_stub.cc
    src/engine/engine_factory_tiny_stub.cc
    src/kernel/binary_loader.cc
    src/kernel/json_parse.cc
    src/kernel/v100/binary_loader_c.cc
    src/task/tiny/rdma_task_tiny_stub.cc
    src/task/tiny/ffts_task_tiny_stub.cc
    src/task/tiny/task_tiny_stub.cc
    src/profiler/api_profile_decorator_tiny_stub.cc
    src/profiler/api_profile_log_decoratoc_tiny_stub.cc
)

set(libruntime_api_src_files_exclude_for_tiny
    src/api/api_c_standard_soc.cc
    src/api/api_preload_task.cc
    src/api/api_c_dqs.cc
    src/api/api_c_snapshot.cc
    src/api/api_david.cc
)

set(libruntime_api_src_files_include_for_tiny
    src/api/api_c_tiny_stub.cc
)

set(libruntime_common_src_files
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

    src/config.cc
    src/device/device.cc
    src/device/raw_device.cc
    src/device/raw_device_res.cc
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
    src/kernel/elf.cc
    src/kernel/kernel.cc
    src/kernel/module.cc
    src/kernel/program.cc
    src/kernel/program_common.cc
    src/kernel/v100/program_plat.cc
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
    src/memory/mem_type.cc
    ${libruntime_v100_task_src_files}
    ${libruntime_api_src_files}
    ${libruntime_context_src_files}
    ${libruntime_stream_src_files}
    ${libruntime_profile_src_files}
    ${libruntime_arg_loader_files}
    ${libruntime_callback_files}
    ${common_src_files}
    $<$<STREQUAL:${PRODUCT},ascend031>:${libruntime_api_src_files_include_for_tiny}>
    $<$<STREQUAL:${PRODUCT},ascend031>:${libruntime_src_files_include_for_tiny}>
)

set(libruntime_dev_info_src_files
    platform/tiny/dev_info_proc_func.cc
)

#------------------------- runtime v100 -------------------------
set(libruntime_v100_src_files
    src/common/inner_thread_local.cpp
    src/api_impl/api_decorator.cc
    src/api_impl/api_impl.cc
    src/api_impl/api_error.cc

    # for V100
    src/api_impl/v100/api_impl_creator_c.cc

    src/config.cc
    src/device/device.cc
    src/device/raw_device.cc
    src/device/raw_device_res.cc
    src/device/device_snapshot.cc
    src/device/raw_device_adpt_comm.cc
    src/device/ctrl_msg.cc
    src/device/ctrl_sq.cc
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
    src/model/v100/capture_adapt.cc
    src/model/capture_model.cc
    src/model/capture_model_utils.cc
    src/kernel/args/args_handle_allocator.cc
    src/kernel/args/para_convertor.cc
    src/kernel/v100/kernel.cc
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
    src/task/task_fail_callback_manager.cc
    src/task/v100/stub_task.cc
    src/memory/mem_type.cc
    ${libruntime_v100_task_src_files}
    ${libruntime_context_src_files}
    ${libruntime_stream_src_files}
    src/profiler/profiler.cc
    src/profiler/api_profile_decorator.cc
    src/profiler/api_profile_log_decorator.cc
    src/profiler/profile_log_record.cc
    src/profiler/npu_driver_record.cc
    ${libruntime_arg_loader_files}
    src/device/device_state_callback_manager.cc
    src/stream/stream_state_callback_manager.cc
    src/plugin_manage/v100/plugin_old_arch.cc
    ${libruntime_dev_info_src_files}
    ${libruntime_src_files_include_for_tiny}
)

set(RUNTIME_INC_DIR_TINY
    ${CMAKE_CURRENT_SOURCE_DIR}/inc
    ${CMAKE_CURRENT_SOURCE_DIR}/inc/args
    ${CMAKE_CURRENT_SOURCE_DIR}/inc/arg_loader
    ${CMAKE_CURRENT_SOURCE_DIR}/inc/common
    ${CMAKE_CURRENT_SOURCE_DIR}/inc/context
    ${CMAKE_CURRENT_SOURCE_DIR}/inc/device
    ${CMAKE_CURRENT_SOURCE_DIR}/inc/dfx
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
    ${CMAKE_CURRENT_SOURCE_DIR}/inc/cond_isa/v100
    ## not open
    ${CMAKE_CURRENT_SOURCE_DIR}/inc/dqs
    ${CMAKE_CURRENT_SOURCE_DIR}/inc/sqe/v200
    ${CMAKE_CURRENT_SOURCE_DIR}/inc/sqe/v200_base
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

#------------------------- runtime common -------------------------
macro(add_runtime_common_library target_name)
    add_library(${target_name} SHARED
        ${common_src_files}
    )

    target_compile_definitions(${target_name} PRIVATE
        LOG_CPP
        CANN_RUNTIME
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
        ${RUNTIME_INC_DIR_TINY}
        ${RUNTIME_DIR}/include
    )

    target_link_libraries(${target_name}
        PRIVATE
            $<BUILD_INTERFACE:intf_pub>
            $<BUILD_INTERFACE:mmpa_headers>
            $<BUILD_INTERFACE:msprof_headers>
            $<BUILD_INTERFACE:slog_headers>
            $<BUILD_INTERFACE:npu_runtime_headers>
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
            # ascend_hal仅在windows形态需要,小海思形态不需要链接ascend_hal，其他形态均链接ascend_hal_stub
            $<$<STREQUAL:${TARGET_SYSTEM_NAME},Windows>:ascend_hal>
            $<$<AND:$<NOT:$<STREQUAL:${TARGET_SYSTEM_NAME},Windows>>,$<NOT:$<STREQUAL:${ENABLE_TSD},true>>>:ascend_hal_stub>
            awatchdog_share
            unified_dlog
            $<$<AND:$<NOT:$<STREQUAL:${PRODUCT},ascend031>>,$<NOT:$<STREQUAL:${PRODUCT},ascend610>>,$<NOT:$<STREQUAL:${PRODUCT},ascend610Lite>>>:atrace_share>
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
    if(${TARGET_SYSTEM_NAME} STREQUAL "Windows")
        add_library(${target_name} SHARED
            ${libruntime_api_src_files}
            $<$<NOT:$<STREQUAL:${PRODUCT},ascend031>>:${libruntime_api_src_files_exclude_for_tiny}>
            $<$<STREQUAL:${PRODUCT},ascend031>:${libruntime_api_src_files_include_for_tiny}>
            src/api/api.cc
            src/profiler/prof_map_ge_model_device.cc
            src/plugin_manage/runtime_keeper.cc
            $<TARGET_OBJECTS:profapi_stub>
            $<$<STREQUAL:${PRODUCT},ascend031>:$<TARGET_OBJECTS:runtime_platform_tiny>>
        )
    else()
        add_library(${target_name} SHARED
            ${libruntime_api_src_files}
            $<$<NOT:$<STREQUAL:${PRODUCT},ascend031>>:${libruntime_api_src_files_exclude_for_tiny}>
            $<$<STREQUAL:${PRODUCT},ascend031>:${libruntime_api_src_files_include_for_tiny}>
            src/api/api.cc
            src/profiler/prof_map_ge_model_device.cc
            src/plugin_manage/runtime_keeper.cc
            $<$<STREQUAL:${PRODUCT},ascend031>:$<TARGET_OBJECTS:runtime_platform_tiny>>
        )
    endif()

    target_compile_definitions(${target_name} PRIVATE
        LOG_CPP
        CANN_RUNTIME
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
        ${RUNTIME_INC_DIR_TINY}
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


macro(add_runtime_v100_library target_name)
    add_library(${target_name} SHARED
        ${libruntime_v100_src_files}
        src/drv/npu_driver.cc
        src/drv/npu_driver_mem.cc
        src/drv/npu_driver_queue.cc
        src/drv/npu_driver_res.cc
        src/drv/npu_driver_tiny.cpp
        src/drv/npu_driver_dcache_lock_common.cpp
        src/drv/npu_driver_dcache_lock_opb.cpp
    )

    target_compile_definitions(${target_name} PRIVATE
        LOG_CPP
        CANN_RUNTIME
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
        ${RUNTIME_INC_DIR_TINY}
        ${RUNTIME_DIR}/include
    )

    target_link_libraries(${target_name}
        PRIVATE
            $<BUILD_INTERFACE:intf_pub>
            $<BUILD_INTERFACE:mmpa_headers>
            $<BUILD_INTERFACE:msprof_headers>
            $<BUILD_INTERFACE:slog_headers>
            $<BUILD_INTERFACE:npu_runtime_headers>
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
            # ascend_hal仅在windows形态需要,小海思形态不需要链接ascend_hal，其他形态均链接ascend_hal_stub
            $<$<STREQUAL:${TARGET_SYSTEM_NAME},Windows>:ascend_hal>
            $<$<AND:$<NOT:$<STREQUAL:${TARGET_SYSTEM_NAME},Windows>>,$<NOT:$<STREQUAL:${ENABLE_TSD},true>>>:ascend_hal_stub>
            awatchdog_share
            unified_dlog
            $<$<AND:$<NOT:$<STREQUAL:${PRODUCT},ascend031>>,$<NOT:$<STREQUAL:${PRODUCT},ascend610>>,$<NOT:$<STREQUAL:${PRODUCT},ascend610Lite>>>:atrace_share>
            json
            platform
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


if(${TARGET_SYSTEM_NAME} STREQUAL "Windows")
    add_library(static_runtime STATIC
        ${libruntime_common_src_files}
        src/drv/npu_driver.cc
        src/drv/npu_driver_win.cc
        src/drv/npu_driver_tiny.cpp
        src/drv/npu_driver_dcache_lock_common.cpp
        src/drv/npu_driver_dcache_lock_opb.cpp
        $<TARGET_OBJECTS:profapi_stub>
        $<$<STREQUAL:${PRODUCT},ascend031>:$<TARGET_OBJECTS:runtime_platform_tiny>>
    )
else()
    add_library(static_runtime STATIC
        ${libruntime_common_src_files}
        src/drv/npu_driver.cc
        src/drv/npu_driver_mem.cc
        src/drv/npu_driver_queue.cc
        src/drv/npu_driver_res.cc
        src/drv/npu_driver_tiny.cpp
        src/drv/npu_driver_dcache_lock_common.cpp
        src/drv/npu_driver_dcache_lock_opb.cpp
        $<$<STREQUAL:${PRODUCT},ascend031>:$<TARGET_OBJECTS:runtime_platform_tiny>>
    )
endif()

target_compile_definitions(static_runtime PRIVATE
    LOG_CPP
    -DSTATIC_RT_LIB=1
    -DRUNTIME_API=0
)

set_target_properties(static_runtime
    PROPERTIES
    WINDOWS_EXPORT_ALL_SYMBOLS TRUE
    OUTPUT_NAME $<IF:$<STREQUAL:${TARGET_SYSTEM_NAME},Windows>,libruntime,runtime>
)

target_compile_options(static_runtime PRIVATE
    $<$<CONFIG:Debug>:-O0>
    $<$<NOT:$<CONFIG:Debug>>:-O3>
    -fvisibility=hidden
    -fno-common
    -fno-strict-aliasing
    -ffunction-sections
    -fdata-sections
    $<$<STREQUAL:${CMAKE_CXX_COMPILER_VERSION},7.3.0>:-Werror>
    $<$<NOT:$<STREQUAL:${TARGET_SYSTEM_NAME},Windows>>:-Wextra>
)

target_include_directories(static_runtime PRIVATE
    ${RUNTIME_INC_DIR}
    ${RUNTIME_DIR}/include
)

if("${ENABLE_TSD}" STREQUAL "true")
    if("${TARGET_LINUX_DISTRIBUTOR_ID}" STREQUAL lhisilinux)
        if("${TARGET_LINUX_DISTRIBUTOR_RELEASE}" STREQUAL 100)
            target_link_libraries(static_runtime PRIVATE -L${RUNTIME_DIR}/vendor/sdk/hi3796/drv)
        elseif("${TARGET_LINUX_DISTRIBUTOR_RELEASE}" STREQUAL 200)
            target_link_libraries(static_runtime PRIVATE -L${RUNTIME_DIR}/vendor/sdk/hi3559dv100/drv)
        endif()
    endif()

    target_link_libraries(static_runtime PRIVATE drvdevdrv aicpu_scheduler_so)
endif()

if("${hostchip}" STREQUAL "hi3559a")
    target_compile_definitions(static_runtime PRIVATE
            __RT_CFG_HOST_CHIP_HI3559A__)
endif()

target_link_libraries(static_runtime
    PRIVATE
        $<BUILD_INTERFACE:intf_pub>
        $<BUILD_INTERFACE:mmpa_headers>
        $<BUILD_INTERFACE:msprof_headers>
        $<BUILD_INTERFACE:slog_headers>
        $<BUILD_INTERFACE:tsch_headers>
        $<BUILD_INTERFACE:npu_runtime_headers>
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
        # ascend_hal仅在windows形态需要,小海思形态不需要链接ascend_hal，其他形态均链接ascend_hal_stub
        $<$<STREQUAL:${TARGET_SYSTEM_NAME},Windows>:ascend_hal>
        $<$<AND:$<NOT:$<STREQUAL:${TARGET_SYSTEM_NAME},Windows>>,$<NOT:$<STREQUAL:${ENABLE_TSD},true>>>:ascend_hal_stub>
        unified_dlog
        json
        -Wl,--as-needed
    PUBLIC
        json
        npu_runtime_headers
)

install(TARGETS static_runtime
    ARCHIVE DESTINATION ${INSTALL_LIBRARY_DIR} OPTIONAL
)

install(TARGETS runtime DESTINATION ${INSTALL_LIBRARY_DIR} OPTIONAL)
install(TARGETS runtime_common DESTINATION ${INSTALL_LIBRARY_DIR} OPTIONAL)
install(TARGETS runtime_v100 DESTINATION ${INSTALL_LIBRARY_DIR} OPTIONAL)