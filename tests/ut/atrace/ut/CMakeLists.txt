add_subdirectory(utrace)
add_subdirectory(awatchdog)
add_subdirectory(trace_server)
add_subdirectory(cpu_detect)

set(ATRACE_UT_TARGETS
    utrace_utest
    utrace_arm_utest
    awatchdog_utest
    awatchdog_stub_utest
    trace_server_utest
    cpu_detect_utest
)

add_custom_target(atrace_ut DEPENDS ${ATRACE_UT_TARGETS})
