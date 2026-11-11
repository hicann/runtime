# -----------------------------------------------------------------------------------------------------------
# Copyright (c) 2026 Huawei Technologies Co., Ltd.
# This program is free software, you can redistribute it and/or modify it under the terms and conditions of
# CANN Open Software License Agreement Version 2.0 (the "License").
# Please refer to the License for details. You may not use this file except in compliance with the License.
# THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
# INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
# See LICENSE in the root of the software repository for the full text of the License.
# -----------------------------------------------------------------------------------------------------------

# Check at build time because the source directory may be created by ExternalProject.
if(IS_DIRECTORY "${SOURCE_DIR}")
    execute_process(
        COMMAND "${CMAKE_COMMAND}" -E copy_directory "${SOURCE_DIR}" "${DESTINATION_DIR}"
        RESULT_VARIABLE copy_result
    )
    if(NOT "${copy_result}" STREQUAL "0")
        message(FATAL_ERROR "Failed to copy directory '${SOURCE_DIR}' to '${DESTINATION_DIR}'")
    endif()
endif()
