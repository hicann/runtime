# -----------------------------------------------------------------------------------------------------------
# Copyright (c) 2025 Huawei Technologies Co., Ltd.
# This program is free software, you can redistribute it and/or modify it under the terms and conditions of
# CANN Open Software License Agreement Version 2.0 (the "License").
# Please refer to the License for details. You may not use this file except in compliance with the License.
# THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
# INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
# See LICENSE in the root of the software repository for the full text of the License.
# -----------------------------------------------------------------------------------------------------------
add_executable(asc_dumper
    stacktrace_dumper_bin.c
    stacktrace_parse.c
    ${ATRACE_DIR}/atrace/utils/trace_system_api.c
    ${ATRACE_DIR}/atrace/utils/trace_load_library.c
    ${ATRACE_DIR}/common/adiag_utils.c
    ${ATRACE_DIR}/common/adiag_list.c
    ${ATRACE_DIR}/common/adiag_lock.c
    ${CMAKE_CURRENT_SOURCE_DIR}/stacktrace_dumper/scd_dwarf.c
    ${CMAKE_CURRENT_SOURCE_DIR}/stacktrace_dumper/scd_memory.c
    ${CMAKE_CURRENT_SOURCE_DIR}/stacktrace_dumper/scd_memory_local.c
    ${CMAKE_CURRENT_SOURCE_DIR}/stacktrace_dumper/scd_memory_remote.c
    ${CMAKE_CURRENT_SOURCE_DIR}/stacktrace_dumper/scd_core.c
    ${CMAKE_CURRENT_SOURCE_DIR}/stacktrace_dumper/scd_dl.c
    ${CMAKE_CURRENT_SOURCE_DIR}/stacktrace_dumper/scd_elf.c
    ${CMAKE_CURRENT_SOURCE_DIR}/stacktrace_dumper/scd_frame.c
    ${CMAKE_CURRENT_SOURCE_DIR}/stacktrace_dumper/scd_frames.c
    ${CMAKE_CURRENT_SOURCE_DIR}/stacktrace_dumper/scd_layout.c
    ${CMAKE_CURRENT_SOURCE_DIR}/stacktrace_dumper/scd_map.c
    ${CMAKE_CURRENT_SOURCE_DIR}/stacktrace_dumper/scd_maps.c
    ${CMAKE_CURRENT_SOURCE_DIR}/stacktrace_dumper/scd_process.c
    ${CMAKE_CURRENT_SOURCE_DIR}/stacktrace_dumper/scd_ptrace.c
    ${CMAKE_CURRENT_SOURCE_DIR}/stacktrace_dumper/scd_regs_arm_64.c
    ${CMAKE_CURRENT_SOURCE_DIR}/stacktrace_dumper/scd_regs_x86_64.c
    ${CMAKE_CURRENT_SOURCE_DIR}/stacktrace_dumper/scd_thread.c
    ${CMAKE_CURRENT_SOURCE_DIR}/stacktrace_dumper/scd_threads.c
    ${CMAKE_CURRENT_SOURCE_DIR}/stacktrace_dumper/scd_util.c

    ${CMAKE_CURRENT_SOURCE_DIR}/stacktrace_unwind.c
    ${CMAKE_CURRENT_SOURCE_DIR}/stacktrace_unwind_inner.c
    ${CMAKE_CURRENT_SOURCE_DIR}/stacktrace_unwind_instr.c
    ${CMAKE_CURRENT_SOURCE_DIR}/stacktrace_unwind_dfx.c
    ${CMAKE_CURRENT_SOURCE_DIR}/stacktrace_logger.c
)

target_include_directories(asc_dumper PRIVATE
    ${ATRACE_DIR}/common/
    ${CMAKE_CURRENT_SOURCE_DIR}
    ${CMAKE_CURRENT_SOURCE_DIR}/stacktrace_dumper
    ${CMAKE_CURRENT_SOURCE_DIR}/../../utils
    ${LIBC_SEC_HEADER}
    ${ATRACE_DIR}/inc/toolchain
    ${ATRACE_DIR}/../../../pkg_inc/mmpa
    ${ATRACE_DIR}/../../../pkg_inc/trace
)

target_compile_options(asc_dumper PRIVATE
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
)

target_compile_definitions(asc_dumper PRIVATE
    OS_TYPE=0
    _GNU_SOURCE
    ENABLE_SCD
)

target_link_options(asc_dumper PRIVATE
    -Wl,-Bsymbolic
    -Wl,--exclude-libs=ALL
    -ldl
    -lstdc++
)

target_link_libraries(asc_dumper PRIVATE
    PRIVATE
        $<BUILD_INTERFACE:intf_pub>
        $<BUILD_INTERFACE:slog_headers>
        $<BUILD_INTERFACE:mmpa_headers>
        mmpa
        c_sec
        unified_dlog
)

set_target_properties(asc_dumper
    PROPERTIES
    OUTPUT_NAME asc_dumper
    LIBRARY_OUTPUT_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/
)

install(TARGETS asc_dumper OPTIONAL
    LIBRARY DESTINATION ${INSTALL_LIBRARY_DIR}
)
