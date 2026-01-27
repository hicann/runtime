
set(WATCHDOG_SOURCE_DIR ${TOP_DIR}/src/dfx/trace/awatchdog)
set(TEST_STUB_SRC
    ${CMAKE_CURRENT_SOURCE_DIR}/../stub/slog_stub.cc
    ${CMAKE_CURRENT_SOURCE_DIR}/../stub/mmpa_stub.c
    ${CMAKE_CURRENT_SOURCE_DIR}/../stub/ascend_hal_stub.c
)
set(SRC_FILE
    ${WATCHDOG_SOURCE_DIR}/awatchdog_core.c
    ${WATCHDOG_SOURCE_DIR}/awatchdog.c
    ${WATCHDOG_SOURCE_DIR}/awatchdog_monitor.c
    ${TOP_DIR}/src/dfx/trace/common/adiag_list.c
    ${TOP_DIR}/src/dfx/trace/common/adiag_utils.c
    ${TOP_DIR}/src/dfx/trace/common/adiag_lock.c
)

set(INCLUDE_DIR
    ${WATCHDOG_SOURCE_DIR}/
    ${TOP_DIR}/src/dfx/trace/common/
    ${TOP_DIR}/include/driver
    ${CMAKE_CURRENT_SOURCE_DIR}/../stub/
    ${LIBC_SEC_HEADER}
)

set(TEST_SRC
    awatchdog_utest.cc
    awatchdog_monitor_utest.cc
    main.cc
)

add_executable(awatchdog_utest
    ${TEST_STUB_SRC}
    ${TEST_SRC}
    ${SRC_FILE}
)

target_include_directories(awatchdog_utest PRIVATE
    ${INCLUDE_DIR}
)

target_compile_options(awatchdog_utest PRIVATE
    -g
    -Wall
    -Werror
    -ldl
)

target_compile_definitions(awatchdog_utest PRIVATE
    C_SEC
    LLT_TEST_DIR="/tmp/awatchdog_utest"
    _ADIAG_LLT_
)

target_link_options(awatchdog_utest PRIVATE
   -ldl
   -lpthread
)

target_link_libraries(awatchdog_utest PRIVATE
    $<BUILD_INTERFACE:intf_llt_pub>
    $<BUILD_INTERFACE:slog_headers>
    $<BUILD_INTERFACE:mmpa_headers>
    $<BUILD_INTERFACE:atrace_headers>
    $<BUILD_INTERFACE:awatchdog_headers>
    c_sec
    dl
)

set_target_properties(awatchdog_utest
    PROPERTIES
    OUTPUT_NAME awatchdog_utest
    LIBRARY_OUTPUT_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}
)

############################# awatchdog_stub_utest (linux)   #############################
set(TEST_STUB_SRC
    ${CMAKE_CURRENT_SOURCE_DIR}/../stub/slog_stub.cc
    ${CMAKE_CURRENT_SOURCE_DIR}/../stub/mmpa_stub.c
    ${CMAKE_CURRENT_SOURCE_DIR}/../stub/ascend_hal_stub.c
)
set(SRC_FILE
    ${WATCHDOG_SOURCE_DIR}/awatchdog_stub.c
)

set(INCLUDE_DIR
    ${WATCHDOG_SOURCE_DIR}/
    ${TOP_DIR}/include/driver
    ${LIBC_SEC_HEADER}
)

set(TEST_SRC
    awatchdog_stub_utest.cc
    main.cc
)

add_executable(awatchdog_stub_utest
    ${TEST_STUB_SRC}
    ${TEST_SRC}
    ${SRC_FILE}
)

target_include_directories(awatchdog_stub_utest PRIVATE
    ${INCLUDE_DIR}
)

target_compile_options(awatchdog_stub_utest PRIVATE
    -g
    -Wall
    -Werror
    -ldl
)

target_compile_definitions(awatchdog_stub_utest PRIVATE
    C_SEC
    LLT_TEST_DIR="/tmp/awatchdog_stub_utest"
    _WATCHDOG_LLT_
    
)

target_link_options(awatchdog_stub_utest PRIVATE
   -ldl
   -lpthread
)

target_link_libraries(awatchdog_stub_utest PRIVATE
    $<BUILD_INTERFACE:intf_llt_pub>
    $<BUILD_INTERFACE:slog_headers>
    $<BUILD_INTERFACE:mmpa_headers>
    $<BUILD_INTERFACE:atrace_headers>
    $<BUILD_INTERFACE:awatchdog_headers>
    c_sec
    dl
)

set_target_properties(awatchdog_stub_utest
    PROPERTIES
    OUTPUT_NAME awatchdog_stub_utest
    LIBRARY_OUTPUT_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}
)
