set(TEST_STUB_SRC
    ${CMAKE_CURRENT_SOURCE_DIR}/../stub/slog_stub.cc
    ${CMAKE_CURRENT_SOURCE_DIR}/../stub/ascend_hal_stub.c
    ${CMAKE_CURRENT_SOURCE_DIR}/../stub/mmpa_stub.c
    ${CMAKE_CURRENT_SOURCE_DIR}/../stub/adcore_stub.c
)

set(STACKTRACE_COMMON_SRC
    ${TOP_DIR}/src/dfx/trace/common/adiag_lock.c
    ${TOP_DIR}/src/dfx/trace/common/adiag_list.c
    ${TOP_DIR}/src/dfx/trace/common/adiag_utils.c
    ${TOP_DIR}/src/dfx/trace/atrace/utils/trace_system_api.c
    ${TOP_DIR}/src/dfx/trace/atrace/utils/trace_load_library.c
)

set(STACKTRACE_DUMPER_SRC
    ${ATRACE_SOURCE_DIR}/utrace/stacktrace/stacktrace_dumper/scd_core.c
    ${ATRACE_SOURCE_DIR}/utrace/stacktrace/stacktrace_dumper/scd_dl.c
    ${ATRACE_SOURCE_DIR}/utrace/stacktrace/stacktrace_dumper/scd_dwarf.c
    ${ATRACE_SOURCE_DIR}/utrace/stacktrace/stacktrace_dumper/scd_elf.c
    ${ATRACE_SOURCE_DIR}/utrace/stacktrace/stacktrace_dumper/scd_frame.c
    ${ATRACE_SOURCE_DIR}/utrace/stacktrace/stacktrace_dumper/scd_frames.c
    ${ATRACE_SOURCE_DIR}/utrace/stacktrace/stacktrace_dumper/scd_layout.c
    ${ATRACE_SOURCE_DIR}/utrace/stacktrace/stacktrace_dumper/scd_map.c
    ${ATRACE_SOURCE_DIR}/utrace/stacktrace/stacktrace_dumper/scd_maps.c
    ${ATRACE_SOURCE_DIR}/utrace/stacktrace/stacktrace_dumper/scd_memory.c
    ${ATRACE_SOURCE_DIR}/utrace/stacktrace/stacktrace_dumper/scd_memory_local.c
    ${ATRACE_SOURCE_DIR}/utrace/stacktrace/stacktrace_dumper/scd_memory_remote.c
    ${ATRACE_SOURCE_DIR}/utrace/stacktrace/stacktrace_dumper/scd_process.c
    ${ATRACE_SOURCE_DIR}/utrace/stacktrace/stacktrace_dumper/scd_ptrace.c
    ${ATRACE_SOURCE_DIR}/utrace/stacktrace/stacktrace_dumper/scd_regs_arm_64.c
    ${ATRACE_SOURCE_DIR}/utrace/stacktrace/stacktrace_dumper/scd_regs_x86_64.c
    ${ATRACE_SOURCE_DIR}/utrace/stacktrace/stacktrace_dumper/scd_thread.c
    ${ATRACE_SOURCE_DIR}/utrace/stacktrace/stacktrace_dumper/scd_threads.c
    ${ATRACE_SOURCE_DIR}/utrace/stacktrace/stacktrace_dumper/scd_util.c
    ${STACKTRACE_COMMON_SRC}
)

set(SRC_FILE
    ${ATRACE_SOURCE_DIR}/utrace/atrace_api.c
    ${ATRACE_SOURCE_DIR}/utrace/atrace_stackcore_api.c
    ${ATRACE_SOURCE_DIR}/utrace/trace_core.c
    ${ATRACE_SOURCE_DIR}/utrace/trace_attr.c
    ${ATRACE_SOURCE_DIR}/utrace/stacktrace/stacktrace_signal.c
    ${ATRACE_SOURCE_DIR}/utrace/event/trace_event.c
    ${ATRACE_SOURCE_DIR}/utrace/tracer/tracer_core.c
    ${ATRACE_SOURCE_DIR}/utrace/tracer/tracer_schedule.c
    ${ATRACE_SOURCE_DIR}/utrace/tracer/tracer_mgr_operate.c
    ${ATRACE_SOURCE_DIR}/utrace/tracer/tracer_mgr_operate_atrace.c
    ${ATRACE_SOURCE_DIR}/utrace/stacktrace/stacktrace_fp.c
    ${ATRACE_SOURCE_DIR}/utrace/stacktrace/stacktrace_safe_recorder.c
    ${ATRACE_SOURCE_DIR}/utrace/stacktrace/stacktrace_dumper.c
    ${ATRACE_SOURCE_DIR}/utrace/stacktrace/stacktrace_dumper_bin.c
    ${ATRACE_SOURCE_DIR}/utrace/stacktrace/stacktrace_unwind.c
    ${ATRACE_SOURCE_DIR}/utrace/stacktrace/stacktrace_unwind_inner.c
    ${ATRACE_SOURCE_DIR}/utrace/stacktrace/stacktrace_unwind_instr.c
    ${ATRACE_SOURCE_DIR}/utrace/stacktrace/stacktrace_unwind_dfx.c
    ${ATRACE_SOURCE_DIR}/utrace/stacktrace/stacktrace_dumper/scd_process.c
    ${ATRACE_SOURCE_DIR}/utrace/stacktrace/stacktrace_monitor.c
    ${ATRACE_SOURCE_DIR}/utrace/stacktrace/stacktrace_exec.c
    ${ATRACE_SOURCE_DIR}/utrace/stacktrace/stacktrace_logger.c
    ${ATRACE_SOURCE_DIR}/utrace/stacktrace/dumper_process/dumper_core.c
    ${ATRACE_SOURCE_DIR}/utrace/stacktrace/dumper_process/dumper_process.c
    ${ATRACE_SOURCE_DIR}/utrace/stacktrace/dumper_process/dumper_thread.c
    ${ATRACE_SOURCE_DIR}/utrace/stacktrace/stacktrace_parse.c
    ${ATRACE_SOURCE_DIR}/utrace/recorder/trace_recorder.c
    ${ATRACE_SOURCE_DIR}/utrace/ringbuffer/trace_rb_log.c
    ${ATRACE_SOURCE_DIR}/utrace/trace_client/atrace_client_api.c
    ${ATRACE_SOURCE_DIR}/utrace/trace_client/atrace_client_core.c
    ${ATRACE_SOURCE_DIR}/utrace/trace_client/atrace_client_thread.c
    ${ATRACE_SOURCE_DIR}/utrace/trace_client/atrace_client_communication.c
    ${ATRACE_SOURCE_DIR}/utrace/util/trace_driver_api.c
    ${ATRACE_SOURCE_DIR}/utils/trace_load_library.c
    ${ATRACE_SOURCE_DIR}/utils/trace_system_api.c
    ${STACKTRACE_DUMPER_SRC}
    ${TOP_DIR}/src/dfx/trace/common/adiag_list.c
    ${TOP_DIR}/src/dfx/trace/common/adiag_lock.c
    ${TOP_DIR}/src/dfx/trace/common/adiag_utils.c
)

set(INCLUDE_DIR
    ${CMAKE_CURRENT_SOURCE_DIR}/../stub
    ${ADIAG_DIR}/inc/utrace
    ${ATRACE_SOURCE_DIR}/utrace
    ${ATRACE_SOURCE_DIR}/utrace/event
    ${ATRACE_SOURCE_DIR}/utrace/recorder
    ${ATRACE_SOURCE_DIR}/utrace/ringbuffer
    ${ATRACE_SOURCE_DIR}/utrace/trace_client
    ${ATRACE_SOURCE_DIR}/utrace/stacktrace
    ${ATRACE_SOURCE_DIR}/utrace/stacktrace/dumper_process
    ${ATRACE_SOURCE_DIR}/utrace/stacktrace/stacktrace_dumper
    ${ATRACE_SOURCE_DIR}/utrace/tracer
    ${ATRACE_SOURCE_DIR}/utrace/util
    ${ATRACE_SOURCE_DIR}/utrace/include
    ${ATRACE_SOURCE_DIR}/utils
    ${LIBC_SEC_HEADER}
    ${TOP_DIR}/pkg_inc/trace
    ${TOP_DIR}/src/dfx/trace/inc/toolchain
    ${TOP_DIR}/src/dfx/trace/common
    ${TOP_DIR}/src/dfx/adump/inc/adump
    ${TOP_DIR}/src/dfx/adump/external
    ${TOP_DIR}/src/dfx/adump
    ${TOP_DIR}/include/driver
    ${TOP_DIR}/src/dfx/adump/inc/adump
)

set(TEST_SRC
    testcase/main.cc
    testcase/utrace_utest.cc
    testcase/utrace_event_utest.cc
    testcase/trace_attr_utest.cc
    testcase/trace_rb_log_utest.cc
    testcase/trace_recorder_utest.cc
    testcase/trace_client_utest.cc
    testcase/trace_util_utest.cc

    testcase/stacktrace/stacktrace_utest.cc
    testcase/stacktrace/dumper_process_utest.cc
    testcase/stacktrace/stacktrace_exec_utest.cc
    testcase/stacktrace/stacktrace_unwind_utest.cc
    testcase/stacktrace/stacktrace_unwind_instr_utest.cc
    testcase/stacktrace/stacktrace_unwind_inner_utest.cc
    testcase/stacktrace/stacktrace_dumper_bin_utest.cc

    testcase/stacktrace_dumper/scd_core_utest.cc
    testcase/stacktrace_dumper/scd_maps_utest.cc
    testcase/stacktrace_dumper/scd_process_utest.cc
    testcase/stacktrace_dumper/scd_registers_utest.cc
    testcase/stacktrace_dumper/scd_threads_utest.cc
    testcase/stacktrace_dumper/scd_utils_utest.cc
    testcase/stacktrace_dumper/scd_memory_utest.cc
    testcase/stacktrace_dumper/scd_dwarf_utest.cc
)

############################# utrace_utest(x86_64)   #############################
add_executable(utrace_utest
    ${TEST_STUB_SRC}
    ${TEST_SRC}
    ${SRC_FILE}
)

target_include_directories(utrace_utest PRIVATE
    ${INCLUDE_DIR}
)

target_compile_options(utrace_utest PRIVATE
    -g
    -Wall
    -Werror
)

target_compile_definitions(utrace_utest PRIVATE
    ATRACE_API
    ATRACE_HOST
    _ADIAG_LLT_
    LLT_TEST_DIR="/tmp/atrace_utest"
    _GNU_SOURCE
    ENABLE_UNWIND
)

target_link_options(utrace_utest PRIVATE
   -ldl
   -lpthread
)

target_link_libraries(utrace_utest PRIVATE
    c_sec
    $<BUILD_INTERFACE:intf_llt_pub>
    $<BUILD_INTERFACE:slog_headers>
    $<BUILD_INTERFACE:mmpa_headers>
    dl
)

set_target_properties(utrace_utest
    PROPERTIES
    OUTPUT_NAME utrace_utest
    LIBRARY_OUTPUT_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}
)

#############################  utrace_arm_utest(arm64)   #############################
add_executable(utrace_arm_utest
    ${ATRACE_SOURCE_DIR}/utrace/stacktrace/stacktrace_dumper/scd_regs_arm_64.c
    ${ATRACE_SOURCE_DIR}/utrace/stacktrace/stacktrace_dumper/scd_util.c
    ${ATRACE_SOURCE_DIR}/utrace/stacktrace/stacktrace_logger.c
    ${STACKTRACE_COMMON_SRC}
    testcase/stacktrace_dumper/scd_registers_utest.cc
    testcase/main.cc
    ${TEST_STUB_SRC}
)

target_include_directories(utrace_arm_utest PRIVATE
    ${INCLUDE_DIR}
)


target_compile_options(utrace_arm_utest PRIVATE
    -g
    -Wall
    -Werror
)

target_compile_definitions(utrace_arm_utest PRIVATE
    C_SEC
    LLT_TEST_DIR="/tmp/atrace_utest"
    LLT_DATA_DIR="${LLT_DATA_DIR}"
    _ADIAG_LLT_ARM_
)

target_link_options(utrace_arm_utest PRIVATE
   -ldl
   -lpthread
)

target_link_libraries(utrace_arm_utest PRIVATE
    $<BUILD_INTERFACE:intf_llt_pub>
    $<BUILD_INTERFACE:slog_headers>
    $<BUILD_INTERFACE:mmpa_headers>
    c_sec
    dl
)

set_target_properties(utrace_arm_utest
    PROPERTIES
    OUTPUT_NAME utrace_arm_utest
    LIBRARY_OUTPUT_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}
)