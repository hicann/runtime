# -----------------------------------------------------------------------------------------------------------
# Copyright (c) 2025 Huawei Technologies Co., Ltd.
# This program is free software, you can redistribute it and/or modify it under the terms and conditions of
# CANN Open Software License Agreement Version 2.0 (the "License").
# Please refer to the License for details. You may not use this file except in compliance with the License.
# THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
# INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
# See LICENSE in the root of the software repository for the full text of the License.
# -----------------------------------------------------------------------------------------------------------
add_subdirectory(stacktrace)

set(libtraceSrcFiles
    ${CMAKE_CURRENT_SOURCE_DIR}/atrace_api.c
    ${CMAKE_CURRENT_SOURCE_DIR}/atrace_stackcore_api.c
    ${CMAKE_CURRENT_SOURCE_DIR}/trace_core.c
    ${CMAKE_CURRENT_SOURCE_DIR}/trace_attr.c
    ${CMAKE_CURRENT_SOURCE_DIR}/event/trace_event.c
    ${CMAKE_CURRENT_SOURCE_DIR}/recorder/trace_recorder.c
    ${CMAKE_CURRENT_SOURCE_DIR}/tracer/tracer_core.c
    ${CMAKE_CURRENT_SOURCE_DIR}/tracer/tracer_schedule.c
    ${CMAKE_CURRENT_SOURCE_DIR}/tracer/tracer_mgr_operate.c
    ${CMAKE_CURRENT_SOURCE_DIR}/stacktrace/stacktrace_signal.c
    ${CMAKE_CURRENT_SOURCE_DIR}/stacktrace/stacktrace_fp.c
    ${CMAKE_CURRENT_SOURCE_DIR}/stacktrace/stacktrace_dumper.c
    ${CMAKE_CURRENT_SOURCE_DIR}/stacktrace/stacktrace_safe_recorder.c
    ${CMAKE_CURRENT_SOURCE_DIR}/stacktrace/dumper_process/dumper_core.c
    ${CMAKE_CURRENT_SOURCE_DIR}/stacktrace/dumper_process/dumper_process.c
    ${CMAKE_CURRENT_SOURCE_DIR}/stacktrace/dumper_process/dumper_thread.c
    ${CMAKE_CURRENT_SOURCE_DIR}/stacktrace/stacktrace_unwind.c
    ${CMAKE_CURRENT_SOURCE_DIR}/stacktrace/stacktrace_unwind_inner.c
    ${CMAKE_CURRENT_SOURCE_DIR}/stacktrace/stacktrace_unwind_instr.c
    ${CMAKE_CURRENT_SOURCE_DIR}/stacktrace/stacktrace_unwind_dfx.c
    ${CMAKE_CURRENT_SOURCE_DIR}/stacktrace/stacktrace_monitor.c
    ${CMAKE_CURRENT_SOURCE_DIR}/stacktrace/stacktrace_parse.c
    ${CMAKE_CURRENT_SOURCE_DIR}/stacktrace/stacktrace_exec.c
    ${CMAKE_CURRENT_SOURCE_DIR}/stacktrace/stacktrace_logger.c
    ${CMAKE_CURRENT_SOURCE_DIR}/stacktrace/stacktrace_dumper/scd_dwarf.c
    ${CMAKE_CURRENT_SOURCE_DIR}/stacktrace/stacktrace_dumper/scd_memory.c
    ${CMAKE_CURRENT_SOURCE_DIR}/stacktrace/stacktrace_dumper/scd_memory_local.c
    ${CMAKE_CURRENT_SOURCE_DIR}/stacktrace/stacktrace_dumper/scd_memory_remote.c
    ${CMAKE_CURRENT_SOURCE_DIR}/stacktrace/stacktrace_dumper/scd_util.c
    ${CMAKE_CURRENT_SOURCE_DIR}/util/trace_driver_api.c
    ${CMAKE_CURRENT_SOURCE_DIR}/ringbuffer/trace_rb_log.c
    ${CMAKE_CURRENT_SOURCE_DIR}/../utils/trace_load_library.c
    ${CMAKE_CURRENT_SOURCE_DIR}/../utils/trace_system_api.c
)

set(libtraceHeaderDir
    ${CMAKE_CURRENT_SOURCE_DIR}
    ${CMAKE_CURRENT_SOURCE_DIR}/event
    ${CMAKE_CURRENT_SOURCE_DIR}/recorder
    ${CMAKE_CURRENT_SOURCE_DIR}/ringbuffer
    ${CMAKE_CURRENT_SOURCE_DIR}/tracer
    ${CMAKE_CURRENT_SOURCE_DIR}/stacktrace
    ${CMAKE_CURRENT_SOURCE_DIR}/stacktrace/dumper_process
    ${CMAKE_CURRENT_SOURCE_DIR}/stacktrace/stacktrace_dumper
    ${CMAKE_CURRENT_SOURCE_DIR}/util
    ${CMAKE_CURRENT_SOURCE_DIR}/../utils
    ${ATRACE_DIR}/common
    ${LIBC_SEC_HEADER}
    ${ATRACE_DIR}/../../../include/driver
    ${ATRACE_DIR}/../../../pkg_inc/trace
    ${ATRACE_DIR}/../../../pkg_inc/dump
)

############################# libascend_trace.so(linux)   #############################
set(libatraceSrcFiles
    ${CMAKE_CURRENT_SOURCE_DIR}/tracer/tracer_mgr_operate_atrace.c
    ${CMAKE_CURRENT_SOURCE_DIR}/trace_client/atrace_client_api.c
    ${CMAKE_CURRENT_SOURCE_DIR}/trace_client/atrace_client_core.c
    ${CMAKE_CURRENT_SOURCE_DIR}/trace_client/atrace_client_thread.c
    ${CMAKE_CURRENT_SOURCE_DIR}/trace_client/atrace_client_communication.c
)

set(libatraceStackcoreSrcFiles
    ${CMAKE_CURRENT_SOURCE_DIR}/stacktrace/stacktrace_dumper/scd_dwarf.c
    ${CMAKE_CURRENT_SOURCE_DIR}/stacktrace/stacktrace_dumper/scd_memory.c
    ${CMAKE_CURRENT_SOURCE_DIR}/stacktrace/stacktrace_dumper/scd_memory_local.c
    ${CMAKE_CURRENT_SOURCE_DIR}/stacktrace/stacktrace_dumper/scd_memory_remote.c
    ${CMAKE_CURRENT_SOURCE_DIR}/stacktrace/stacktrace_dumper/scd_dl.c
    ${CMAKE_CURRENT_SOURCE_DIR}/stacktrace/stacktrace_dumper/scd_elf.c
    ${CMAKE_CURRENT_SOURCE_DIR}/stacktrace/stacktrace_dumper/scd_frame.c
    ${CMAKE_CURRENT_SOURCE_DIR}/stacktrace/stacktrace_dumper/scd_frames.c
    ${CMAKE_CURRENT_SOURCE_DIR}/stacktrace/stacktrace_dumper/scd_layout.c
    ${CMAKE_CURRENT_SOURCE_DIR}/stacktrace/stacktrace_dumper/scd_map.c
    ${CMAKE_CURRENT_SOURCE_DIR}/stacktrace/stacktrace_dumper/scd_maps.c
    ${CMAKE_CURRENT_SOURCE_DIR}/stacktrace/stacktrace_dumper/scd_process.c
    ${CMAKE_CURRENT_SOURCE_DIR}/stacktrace/stacktrace_dumper/scd_ptrace.c
    ${CMAKE_CURRENT_SOURCE_DIR}/stacktrace/stacktrace_dumper/scd_regs_arm_64.c
    ${CMAKE_CURRENT_SOURCE_DIR}/stacktrace/stacktrace_dumper/scd_regs_x86_64.c
    ${CMAKE_CURRENT_SOURCE_DIR}/stacktrace/stacktrace_dumper/scd_thread.c
    ${CMAKE_CURRENT_SOURCE_DIR}/stacktrace/stacktrace_dumper/scd_threads.c
    ${CMAKE_CURRENT_SOURCE_DIR}/stacktrace/stacktrace_dumper/scd_util.c
)

set(libatraceHeaderDir
    ${CMAKE_CURRENT_SOURCE_DIR}/trace_client
)

add_library(atrace_share
    SHARED
        ${libtraceSrcFiles}
        ${libatraceStackcoreSrcFiles}
        ${libatraceSrcFiles}
        ${adiagCommonFiles})

target_include_directories(atrace_share
    PRIVATE
        ${LIBC_SEC_HEADER}
        ${libtraceHeaderDir}
        ${libatraceHeaderDir})

target_compile_definitions(atrace_share
    PRIVATE
    PUBLIC
        ADX_LIB_C
        ATRACE_API
        ENABLE_SCD
)

target_compile_options(atrace_share
    PRIVATE
        -Wcast-qual
        ${ADIAG_COMMON_COMPILE_OPTIONS}
        $<$<CONFIG:Debug>:-g -O0>
        $<$<CONFIG:Release>:-Os -D_FORTIFY_SOURCE=2>
        -std=gnu11
        -fPIC
        -fstack-protector-strong
        -fno-common
        -fsigned-char
        -fno-strict-aliasing
        -fdata-sections
        -ffunction-sections
        -fvisibility=hidden
)

target_link_options(atrace_share
    PRIVATE
        -Wl,-z,relro,-z,now,-z,noexecstack
        -Wl,--gc-sections
)

target_link_libraries(atrace_share
    PRIVATE
        $<BUILD_INTERFACE:intf_pub>
        $<BUILD_INTERFACE:slog_headers>
        $<BUILD_INTERFACE:mmpa_headers>
        # $<BUILD_INTERFACE:adcore_headers>
        # $<$<STREQUAL:${PRODUCT_SIDE},host>:ascend_hal_stub>
        $<$<STREQUAL:${PRODUCT_SIDE},device>:ascend_hal>
        adcore
        mmpa
        unified_dlog
    PUBLIC
        atrace_headers
)

target_compile_definitions(atrace_share
    PRIVATE
        OS_TYPE=0
        _GNU_SOURCE
        ENABLE_UNWIND
)
set_target_properties(atrace_share
    PROPERTIES
    WINDOWS_EXPORT_ALL_SYMBOLS TRUE
    OUTPUT_NAME ascend_trace
)

# install_package(
#     PACKAGE atrace
#     TARGETS atrace_share atrace_headers
#     FILES   ${ATRACE_DIR}/../../include/utrace/atrace_api.h
#             ${ATRACE_DIR}/../../include/utrace/atrace_pub.h
#             ${ATRACE_DIR}/../../include/utrace/atrace_types.h
#             ${ATRACE_DIR}/../../include/utrace/atrace_stackcore_api.h
#     DESTINATION ${INSTALL_INCLUDE_DIR}/atrace/utrace
# )

############################# libutrace.so(linux)   #############################
set(libutraceSrcFiles
    ${CMAKE_CURRENT_SOURCE_DIR}/tracer/tracer_mgr_operate_utrace.c
    ${CMAKE_CURRENT_SOURCE_DIR}/utrace_client/utrace_socket.c
)

set(libutraceHeaderDir
    ${CMAKE_CURRENT_SOURCE_DIR}/utrace_client
)

add_library(utrace_share
    SHARED
        ${libtraceSrcFiles}
        ${libutraceSrcFiles}
        ${adiagCommonFiles})

target_include_directories(utrace_share
    PRIVATE
        ${LIBC_SEC_HEADER}
        ${libtraceHeaderDir}
        ${libutraceHeaderDir})

target_compile_definitions(utrace_share
    PRIVATE
    PUBLIC
        ADX_LIB_C
        UTRACE_API
)

target_compile_options(utrace_share
    PRIVATE
        -Wcast-qual
        ${ADIAG_COMMON_COMPILE_OPTIONS}
        $<$<CONFIG:Debug>:-g -O0>
        $<$<CONFIG:Release>:-Os -D_FORTIFY_SOURCE=2>
        -std=gnu11
        -fPIC
        -fstack-protector-strong
        -fno-common
        -fsigned-char
        -fno-strict-aliasing
        -fdata-sections
        -ffunction-sections
        -fvisibility=hidden
)

target_link_options(utrace_share
    PRIVATE
        -Wl,-z,relro,-z,now,-z,noexecstack
        -Wl,--gc-sections
)

target_link_libraries(utrace_share
    PRIVATE
        $<BUILD_INTERFACE:intf_pub>
        $<BUILD_INTERFACE:slog_headers>
        $<BUILD_INTERFACE:mmpa_headers>
        # $<BUILD_INTERFACE:adcore_headers>
        adcore
        mmpa
        unified_dlog
    PUBLIC
        atrace_headers
)

target_compile_definitions(utrace_share
    PRIVATE
        OS_TYPE=0
        ATRACE_ROOT_PATH="/var/log/npu/slog"
        _GNU_SOURCE
)
set_target_properties(utrace_share
    PROPERTIES
    WINDOWS_EXPORT_ALL_SYMBOLS TRUE
    OUTPUT_NAME utrace
)

# install_package(
#     TARGETS utrace_share
#     DESTINATION ${INSTALL_INCLUDE_DIR}/atrace/utrace
# )