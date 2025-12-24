set(UTRACE_SOURCE_DIR ${ATRACE_SOURCE_DIR}/utrace)
############################# libutrace.so(linux)   ###########################
set(libutraceSrcFiles
    ${UTRACE_SOURCE_DIR}/atrace_api.c
    ${UTRACE_SOURCE_DIR}/trace_core.c
    ${UTRACE_SOURCE_DIR}/trace_attr.c
    ${UTRACE_SOURCE_DIR}/stacktrace/stacktrace_signal.c
    ${UTRACE_SOURCE_DIR}/event/trace_event.c
    ${UTRACE_SOURCE_DIR}/recorder/trace_recorder.c
    ${UTRACE_SOURCE_DIR}/tracer/tracer_core.c
    ${UTRACE_SOURCE_DIR}/tracer/tracer_schedule.c
    ${UTRACE_SOURCE_DIR}/tracer/tracer_mgr_operate.c
    ${UTRACE_SOURCE_DIR}/tracer/tracer_mgr_operate_utrace.c
    ${UTRACE_SOURCE_DIR}/stacktrace/stacktrace_fp.c
    ${UTRACE_SOURCE_DIR}/stacktrace/stacktrace_safe_recorder.c
    ${UTRACE_SOURCE_DIR}/stacktrace/stacktrace_unwind.c
    ${UTRACE_SOURCE_DIR}/stacktrace/stacktrace_unwind_inner.c
    ${UTRACE_SOURCE_DIR}/stacktrace/stacktrace_unwind_instr.c
    ${UTRACE_SOURCE_DIR}/stacktrace/stacktrace_unwind_dfx.c
    ${UTRACE_SOURCE_DIR}/stacktrace/stacktrace_logger.c
    ${UTRACE_SOURCE_DIR}/stacktrace/stacktrace_dumper.c
    ${UTRACE_SOURCE_DIR}/stacktrace/stacktrace_monitor.c
    ${UTRACE_SOURCE_DIR}/stacktrace/stacktrace_dumper/scd_util.c
    ${UTRACE_SOURCE_DIR}/stacktrace/dumper_process/dumper_core.c
    ${UTRACE_SOURCE_DIR}/stacktrace/dumper_process/dumper_process.c
    ${UTRACE_SOURCE_DIR}/stacktrace/dumper_process/dumper_thread.c
    ${UTRACE_SOURCE_DIR}/stacktrace/stacktrace_parse.c
    ${UTRACE_SOURCE_DIR}/utrace_client/utrace_socket.c
    ${UTRACE_SOURCE_DIR}/util/trace_driver_api.c
    ${TOP_DIR}/abl/atrace/common/adiag_list.c
    ${TOP_DIR}/abl/atrace/common/adiag_utils.c
    ${TOP_DIR}/abl/atrace/common/adiag_lock.c
    ${UTRACE_SOURCE_DIR}/ringbuffer/trace_rb_log.c
    ${UTRACE_SOURCE_DIR}/../utils/trace_load_library.c
    ${UTRACE_SOURCE_DIR}/../utils/trace_system_api.c
)
 
 
set(STACKTRACE_DUMPER_SRC
     ${UTRACE_SOURCE_DIR}/stacktrace/stacktrace_dumper/scd_dwarf.c
     ${UTRACE_SOURCE_DIR}/stacktrace/stacktrace_dumper/scd_memory.c
     ${UTRACE_SOURCE_DIR}/stacktrace/stacktrace_dumper/scd_memory_local.c
     ${UTRACE_SOURCE_DIR}/stacktrace/stacktrace_dumper/scd_memory_remote.c
     ${UTRACE_SOURCE_DIR}/stacktrace/stacktrace_dumper/scd_util.c
)
set(libutraceHeaderDir
    ${UTRACE_SOURCE_DIR}
    ${UTRACE_SOURCE_DIR}/utrace_client
    ${UTRACE_SOURCE_DIR}/event
    ${UTRACE_SOURCE_DIR}/recorder
    ${UTRACE_SOURCE_DIR}/ringbuffer
    ${UTRACE_SOURCE_DIR}/tracer
    ${UTRACE_SOURCE_DIR}/stacktrace
    ${UTRACE_SOURCE_DIR}/stacktrace/dumper_process
    ${UTRACE_SOURCE_DIR}/stacktrace/stacktrace_dumper
    ${UTRACE_SOURCE_DIR}/util
    ${UTRACE_SOURCE_DIR}/include
    ${UTRACE_SOURCE_DIR}/../utils
    ${ADIAG_DIR}/inc/utrace
    ${TOP_DIR}/abl/libc_sec/include
    ${TOP_DIR}/inc/driver
    ${TOP_DIR}/abl/adump/inc/adump
    ${TOP_DIR}/abl/adump/external
    ${TOP_DIR}/abl/atrace/common
)
 
 
add_library(utrace_share_utest
    SHARED
        ${libutraceSrcFiles}
        ${STACKTRACE_DUMPER_SRC})
 
target_include_directories(utrace_share_utest
    PRIVATE
        ${TOP_DIR}/abl/libc_sec/include
        ${libutraceHeaderDir})
 
target_compile_definitions(utrace_share_utest
    PRIVATE
    PUBLIC
        ADX_LIB_C
        UTRACE_API
)
 
target_compile_options(utrace_share_utest
    PRIVATE
        -Wall
        -Wfloat-equal
        -Wextra
        -Wunused
        -Wshadow
        -Wundef
        -Werror
        $<$<CONFIG:Debug>:-g -O0>
        $<$<CONFIG:Release>:-Os>
        -std=gnu11
        -fPIC
        -fstack-protector-strong
        -fno-common
        -fsigned-char
        -fno-strict-aliasing
        -fdata-sections
        -ffunction-sections
)
 
target_link_options(utrace_share_utest
    PRIVATE
        -Wl,-z,relro,-z,now,-z,noexecstack
        -Wl,--gc-sections
)
 
target_link_libraries(utrace_share_utest
    PRIVATE
        $<BUILD_INTERFACE:intf_llt_pub>
        $<BUILD_INTERFACE:slog_headers>
        $<BUILD_INTERFACE:mmpa_headers>
    PUBLIC
        atrace_headers
)
 
target_compile_definitions(utrace_share_utest
    PRIVATE
        OS_TYPE=0
        _GNU_SOURCE
        C_SEC
        LLT_TEST_DIR="/tmp/trace_server_utest"
        _ADIAG_LLT_
        UTRACE_API
        TRACE_SERVER_USER_NAME="root"
        SOCKET_FILE_DIR="/tmp"
)
 
set_target_properties(utrace_share_utest
    PROPERTIES
    WINDOWS_EXPORT_ALL_SYMBOLS TRUE
    OUTPUT_NAME utrace
)

############################# trace_server_utest(linux)   #############################
set(TEST_STUB_SRC
    ${CMAKE_CURRENT_SOURCE_DIR}/../stub/slog_stub.cc
    ${CMAKE_CURRENT_SOURCE_DIR}/../stub/ascend_hal_stub.c
    ${CMAKE_CURRENT_SOURCE_DIR}/../stub/mmpa_stub.c
    ${CMAKE_CURRENT_SOURCE_DIR}/../stub/adx_stub.c
)

set(SRC_FILE
    ${ATRACE_SOURCE_DIR}/trace_server/trace_server.c
    ${ATRACE_SOURCE_DIR}/trace_server/trace_server_core.c
    ${ATRACE_SOURCE_DIR}/trace_server/ktrace_ts/ktrace_ts.c
    ${ATRACE_SOURCE_DIR}/trace_server/send_mgr/trace_send_mgr.c
    ${ATRACE_SOURCE_DIR}/trace_server/send_mgr/trace_adx_api.c
    ${ATRACE_SOURCE_DIR}/trace_server/send_mgr/trace_server_mgr.c
    ${ATRACE_SOURCE_DIR}/trace_server/session_mgr/trace_session_mgr.c
    ${ATRACE_SOURCE_DIR}/trace_server/session_mgr/trace_queue.c
    ${ATRACE_SOURCE_DIR}/trace_server/session_mgr/trace_node.c
    ${ATRACE_SOURCE_DIR}/trace_server/utrace_server/trace_server_socket.c
    ${ATRACE_SOURCE_DIR}/utils/trace_system_api.c
    ${TOP_DIR}/abl/atrace/common/adiag_lock.c
    ${TOP_DIR}/abl/atrace/common/adiag_list.c
)

set(INCLUDE_DIR
    testcase
    ${CMAKE_CURRENT_SOURCE_DIR}/../stub
    ${ADIAG_DIR}/inc/utrace
    ${ADIAG_DIR}/inc/trace_server
    ${ATRACE_SOURCE_DIR}/trace_server
    ${ATRACE_SOURCE_DIR}/trace_server/ktrace_ts
    ${ATRACE_SOURCE_DIR}/trace_server/send_mgr
    ${ATRACE_SOURCE_DIR}/trace_server/session_mgr
    ${ATRACE_SOURCE_DIR}/trace_server/utrace_server
    ${ATRACE_SOURCE_DIR}/utrace
    ${UTRACE_SOURCE_DIR}/utrace_client
    ${ATRACE_SOURCE_DIR}/utils
    ${TOP_DIR}/abl/libc_sec/include
    ${TOP_DIR}/inc/driver
    ${TOP_DIR}/abl/adump/inc/adump
    ${TOP_DIR}/abl/adump/external
    ${TOP_DIR}/abl/atrace/common
)

set(TEST_SRC
    testcase/trace_server_utest.cc
    testcase/trace_session_utest.cc
    testcase/trace_send_utest.cc
    testcase/trace_ts_utest.cc
)

add_executable(trace_server_utest
    ${TEST_STUB_SRC}
    ${TEST_SRC}
    ${SRC_FILE}
)

target_include_directories(trace_server_utest PRIVATE
    ${INCLUDE_DIR}
)

target_compile_options(trace_server_utest PRIVATE
    -g
    -Wall
    -Werror
    -std=c++11
)

target_compile_definitions(trace_server_utest PRIVATE
    C_SEC
    LLT_TEST_DIR="/tmp/trace_server_utest"
    _ADIAG_LLT_
    UTRACE_API
    TRACE_SERVER_USER_NAME="root"
    SOCKET_FILE_DIR="/tmp"
)

target_link_options(trace_server_utest PRIVATE
   -ldl
   -lpthread
)

target_link_libraries(trace_server_utest PRIVATE
    $<BUILD_INTERFACE:intf_llt_pub>
    $<BUILD_INTERFACE:slog_headers>
    $<BUILD_INTERFACE:mmpa_headers>
    c_sec
    utrace_share_utest
)

set_target_properties(trace_server_utest
    PROPERTIES
    OUTPUT_NAME trace_server_utest
    LIBRARY_OUTPUT_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}
)

run_llt_test(
    TARGET trace_server_utest
    TASK_NUM 1
)