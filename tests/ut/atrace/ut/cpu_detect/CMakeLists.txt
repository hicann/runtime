set(CPU_DETECT_SOURCE_DIR 
    ${TOP_DIR}/abl/atrace/cpu_detect
)

set(SRC_FILE
    ${CPU_DETECT_SOURCE_DIR}/cpu_detect.c
    ${CPU_DETECT_SOURCE_DIR}/cpu_detect_core.c
    ${CPU_DETECT_SOURCE_DIR}/cpu_detect_test.c
)

set(INCLUDE_DIR
    ${CPU_DETECT_SOURCE_DIR}/
    ${CPU_DETECT_SOURCE_DIR}/../stub/
    ${TOP_DIR}/abl/atrace/inc/cpu_detect
    ${TOP_DIR}/inc/driver
)

set(TEST_SRC
    cpu_detect_utest.cc
    cpu_detect_core_utest.cc
    cpu_detect_test_utest.cc
)

set(TEST_STUB_SRC
    ${CMAKE_CURRENT_SOURCE_DIR}/../stub/slog_stub.c
    ${CMAKE_CURRENT_SOURCE_DIR}/../stub/mmpa_stub.c
    ${CMAKE_CURRENT_SOURCE_DIR}/../stub/ascend_hal_stub.c
    ${CMAKE_CURRENT_SOURCE_DIR}/stub/cpu_detect_testcase_stub.c
)

add_executable(cpu_detect_utest
    ${TEST_STUB_SRC}
    ${TEST_SRC}
    ${SRC_FILE}
)

target_include_directories(cpu_detect_utest 
    PRIVATE
        ${INCLUDE_DIR}
)

target_compile_options(cpu_detect_utest 
    PRIVATE
        -g
        -Wall
        -Werror
)

target_compile_definitions(cpu_detect_utest 
    PRIVATE
        _CPU_DETECT_LLT_
        C_SEC
        LOG_CPP
        LLT_TEST_DIR="/tmp/cpu_detect_utest"
)

target_link_options(cpu_detect_utest 
    PRIVATE
        -ldl
        -lpthread
)

target_link_libraries(cpu_detect_utest 
    PRIVATE
        $<BUILD_INTERFACE:intf_llt_pub>
        $<BUILD_INTERFACE:slog_headers>
        $<BUILD_INTERFACE:mmpa_headers>
        c_sec
        pthread
)

set_target_properties(cpu_detect_utest
    PROPERTIES
    OUTPUT_NAME cpu_detect_utest
    LIBRARY_OUTPUT_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}
)

run_llt_test(
    TARGET cpu_detect_utest
    TASK_NUM 1
)