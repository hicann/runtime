# -----------------------------------------------------------------------------------------------------------
# Copyright (c) 2025 Huawei Technologies Co., Ltd.
# This program is free software, you can redistribute it and/or modify it under the terms and conditions of
# CANN Open Software License Agreement Version 2.0 (the "License").
# Please refer to the License for details. You may not use this file except in compliance with the License.
# THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
# INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
# See LICENSE in the root of the software repository for the full text of the License.
# -----------------------------------------------------------------------------------------------------------
get_filename_component(BASE_DIR "${CMAKE_CURRENT_LIST_DIR}" ABSOLUTE)

set(DUMP_CONFIG ${CMAKE_CURRENT_SOURCE_DIR}/dump_tool_config.ini)

if(NOT EXISTS ${DUMP_CONFIG})
    message(FATAL_ERROR "Cannot find config file ${DUMP_CONFIG}.")
endif()

add_custom_target(dump_conf
    COMMAND ${CMAKE_COMMAND} -E copy ${DUMP_CONFIG} ${CMAKE_CURRENT_BINARY_DIR}
)

install(FILES ${CMAKE_CURRENT_BINARY_DIR}/dump_tool_config.ini
    OPTIONAL DESTINATION ${INSTALL_LIBRARY_DIR}
)
