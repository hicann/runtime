set(BASE_DIR ${CMAKE_CURRENT_SOURCE_DIR})

set(LOCAL_SRC_FILES
    ${RUNTIME_DIR}/src/aicpu_sched/aicpu_kernel/load_platform_info.cpp
    testcase/load_platform_info_ut.cc
    ../stub/slog_stub.cpp
    main_ut.cc
)

add_executable(aicpu_kernel_utest
    ${LOCAL_SRC_FILES}
)

target_include_directories (aicpu_kernel_utest PRIVATE
    ${RUNTIME_DIR}/src/aicpu_sched/aicpu_kernel/
    ${RUNTIME_DIR}/pkg_inc/base
    ${RUNTIME_DIR}/src/dfx/log/inc/toolchain
    ${CMAKE_CURRENT_SOURCE_DIR}/../stub/
)

target_link_libraries(aicpu_kernel_utest PRIVATE
    c_sec
    $<BUILD_INTERFACE:intf_aicpu_llt_pub>
)

target_compile_definitions(aicpu_kernel_utest PRIVATE
    AICPU_KERNEL_UTST
)
