# -----------------------------------------------------------------------------------------------------------
# Copyright (c) 2025 Huawei Technologies Co., Ltd.
# This program is free software, you can redistribute it and/or modify it under the terms and conditions of
# CANN Open Software License Agreement Version 2.0 (the "License").
# Please refer to the License for details. You may not use this file except in compliance with the License.
# THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
# INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
# See LICENSE in the root of the software repository for the full text of the License.
# -----------------------------------------------------------------------------------------------------------
find_package(Python3 REQUIRED COMPONENTS Interpreter)

add_custom_target(runtime_enum_log_metadata_sync_ut
    COMMAND ${CMAKE_COMMAND} -E env --unset=PYTHONHOME --unset=PYTHONPATH
        ${Python3_EXECUTABLE} ${CMAKE_CURRENT_SOURCE_DIR}/cmake/test_enum_log_metadata_sync.py
    WORKING_DIRECTORY ${TOP_DIR}
    COMMENT "Checking Runtime enum log metadata synchronization"
    VERBATIM
)

set(RUNTIME_API_STUB_GENERATOR_TEST
    ${CMAKE_CURRENT_SOURCE_DIR}/cmake/test_generate_runtime_api_stubs.py
)
set(ACL_API_STUB_GENERATOR_TEST
    ${CMAKE_CURRENT_SOURCE_DIR}/cmake/test_generate_acl_api_stubs.py
)
add_custom_target(runtime_api_stub_generator_ut
    COMMAND ${CMAKE_COMMAND} -E env --unset=PYTHONHOME --unset=PYTHONPATH ${Python3_EXECUTABLE} ${RUNTIME_API_STUB_GENERATOR_TEST}
    COMMAND ${CMAKE_COMMAND} -E env --unset=PYTHONHOME --unset=PYTHONPATH ${Python3_EXECUTABLE} ${ACL_API_STUB_GENERATOR_TEST}
    COMMAND ${CMAKE_COMMAND} -E env --unset=PYTHONHOME --unset=PYTHONPATH ${Python3_EXECUTABLE} ${CMAKE_CURRENT_SOURCE_DIR}/cmake/test_gen_dynamic_stub_multiline.py
    COMMAND ${CMAKE_COMMAND} -E env --unset=PYTHONHOME --unset=PYTHONPATH ${Python3_EXECUTABLE} ${CMAKE_CURRENT_SOURCE_DIR}/cmake/test_h2c_default_output.py
    COMMAND ${CMAKE_COMMAND} -E env --unset=PYTHONHOME --unset=PYTHONPATH ${Python3_EXECUTABLE} ${CMAKE_CURRENT_SOURCE_DIR}/cmake/test_h2c_comment_termination.py
    COMMAND ${CMAKE_COMMAND} -E env --unset=PYTHONHOME --unset=PYTHONPATH ${Python3_EXECUTABLE} ${CMAKE_CURRENT_SOURCE_DIR}/cmake/test_error_manager_stub_eof.py
    COMMAND ${CMAKE_COMMAND} -E env --unset=PYTHONHOME --unset=PYTHONPATH ${Python3_EXECUTABLE} ${CMAKE_CURRENT_SOURCE_DIR}/cmake/test_h2c_empty_guard.py
    COMMAND ${CMAKE_COMMAND} -E env --unset=PYTHONHOME --unset=PYTHONPATH ${Python3_EXECUTABLE} ${CMAKE_CURRENT_SOURCE_DIR}/cmake/test_unzip_tool_output.py
    COMMAND ${CMAKE_COMMAND} -E env --unset=PYTHONHOME --unset=PYTHONPATH ${Python3_EXECUTABLE} ${CMAKE_CURRENT_SOURCE_DIR}/cmake/test_unzip_tool_exit_status.py
    WORKING_DIRECTORY ${TOP_DIR}
    COMMENT "Running Runtime and ACL API stub generator unit tests"
    VERBATIM
)

add_subdirectory(platform)

# Compile the private log implementation in both modes without Runtime/device fixtures.
set(RUNTIME_CORE_DIR ${TOP_DIR}/src/runtime/core)
foreach(enum_log_mode full stub)
    set(enum_log_target runtime_utest_enum_log_${enum_log_mode})
    add_executable(${enum_log_target}
        rt_utest_enum_log.cc
        rt_utest_driver_enum_log.cc
        ${RUNTIME_CORE_DIR}/src/common/api_enum_log.cc
        ${RUNTIME_CORE_DIR}/src/common/internal_enum_log.cc
        ${RUNTIME_CORE_DIR}/src/common/callback_enum_log.cc
    )
    target_include_directories(${enum_log_target} PRIVATE
        ${RUNTIME_CORE_DIR}/inc
        ${TOP_DIR}/pkg_inc
        ${TOP_DIR}/pkg_inc/runtime
    )
    target_compile_definitions(${enum_log_target} PRIVATE _GLIBCXX_USE_CXX11_ABI=0)
    target_compile_options(${enum_log_target} PRIVATE
        -Wall -Wextra -Wformat -Werror=format
        $<$<BOOL:${ENABLE_GCOV}>:-fprofile-arcs -ftest-coverage>
    )
    target_link_options(${enum_log_target} PRIVATE
        $<$<BOOL:${ENABLE_GCOV}>:-fprofile-arcs -ftest-coverage>
    )
    target_link_libraries(${enum_log_target} PRIVATE GTestShared::gtest GTestShared::gtest_main)
    target_include_directories(${enum_log_target} PRIVATE
        $<TARGET_PROPERTY:runtime_utest_intf_pub,INTERFACE_INCLUDE_DIRECTORIES>
        ${TOP_DIR}/src/dfx/error_manager
    )
    target_link_libraries(${enum_log_target} PRIVATE
        npu_runtime_headers mmpa_headers c_sec c_sec_headers slog_headers
    )
    if(enum_log_mode STREQUAL "full")
        target_compile_definitions(${enum_log_target} PRIVATE
            RUNTIME_ENABLE_ENUM_LOG_NAMES=$<BOOL:ON>
        )
    else()
        target_compile_definitions(${enum_log_target} PRIVATE
            RUNTIME_ENABLE_ENUM_LOG_NAMES=$<BOOL:OFF>
        )
    endif()
endforeach()
