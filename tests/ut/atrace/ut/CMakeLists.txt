add_subdirectory(utrace)
add_subdirectory(awatchdog)

set(ATRACE_UT_TARGETS
    # utrace_utest
    awatchdog_utest
    # awatchdog_stub_utest
)

add_custom_target(atrace_ut DEPENDS ${ATRACE_UT_TARGETS})