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

set(RUNTIME_API_STUB_GENERATOR_TEST
    ${CMAKE_CURRENT_SOURCE_DIR}/cmake/test_generate_runtime_api_stubs.py
)
add_custom_target(runtime_api_stub_generator_ut
    COMMAND ${Python3_EXECUTABLE} ${RUNTIME_API_STUB_GENERATOR_TEST}
    WORKING_DIRECTORY ${TOP_DIR}
    COMMENT "Running Runtime API stub generator unit tests"
    VERBATIM
)

add_subdirectory(platform)
