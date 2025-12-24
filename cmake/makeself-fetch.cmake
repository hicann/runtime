# -----------------------------------------------------------------------------------------------------------
# Copyright (c) 2025 Huawei Technologies Co., Ltd.
# This program is free software, you can redistribute it and/or modify it under the terms and conditions of
# CANN Open Software License Agreement Version 2.0 (the "License").
# Please refer to the License for details. You may not use this file except in compliance with the License.
# THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
# INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
# See LICENSE in the root of the software repository for the full text of the License.
# -----------------------------------------------------------------------------------------------------------

set(MAKESELF_NAME "makeself")
set(OPEN_SOURCE_MAKESELF_PATH "${OPEN_SOURCE_DIR}/${MAKESELF_NAME}")
set(MAKESELF_PATH "${CMAKE_BINARY_DIR}/${MAKESELF_NAME}")

# 检查是否已有 makeself 文件
if(EXISTS "${OPEN_SOURCE_MAKESELF_PATH}/makeself-header.sh" AND
   EXISTS "${OPEN_SOURCE_MAKESELF_PATH}/makeself.sh")

    message(STATUS "get makeself from open_source success")
    file(MAKE_DIRECTORY "${MAKESELF_PATH}")
    execute_process(
        COMMAND ${CMAKE_COMMAND} -E copy
            "${OPEN_SOURCE_MAKESELF_PATH}/makeself-header.sh"
            "${OPEN_SOURCE_MAKESELF_PATH}/makeself.sh"
            "${MAKESELF_PATH}"
        RESULT_VARIABLE copy_result
    )
    if(NOT copy_result EQUAL 0)
        message(FATAL_ERROR "Failed to copy makeself files.")
    endif()

else()
    # 从网络下载 makeself
    set(MAKESELF_URL "https://gitcode.com/cann-src-third-party/makeself/releases/download/release-2.5.0-patch1.0/makeself-release-2.5.0-patch1.tar.gz")
    set(MAKESELF_TAR "${CMAKE_BINARY_DIR}/makeself.tar.gz")
    set(EXTRACT_TEMP_DIR "${CMAKE_BINARY_DIR}/makeself-tmp")

    message(STATUS "Downloading ${MAKESELF_NAME} from ${MAKESELF_URL}")

    # 1. 下载 tar.gz
    file(DOWNLOAD
        "${MAKESELF_URL}"
        "${MAKESELF_TAR}"
        EXPECTED_HASH SHA256=bfa730a5763cdb267904a130e02b2e48e464986909c0733ff1c96495f620369a
        SHOW_PROGRESS
    )

    # 2. 创建临时解压目录
    file(MAKE_DIRECTORY "${EXTRACT_TEMP_DIR}")

    # 3. 解压 tar.gz 到临时目录
    execute_process(
        COMMAND ${CMAKE_COMMAND} -E tar xzf "${MAKESELF_TAR}"
        WORKING_DIRECTORY "${EXTRACT_TEMP_DIR}"
        RESULT_VARIABLE extract_result
    )
    if(NOT extract_result EQUAL 0)
        message(FATAL_ERROR "Failed to extract makeself archive.")
    endif()

    # 4. 找到解压后的子目录（如 makeself-release-2.5.0-patch1/）
    file(GLOB EXTRACTED_SUBDIRS LIST_DIRECTORIES true RELATIVE "${EXTRACT_TEMP_DIR}" "${EXTRACT_TEMP_DIR}/*")
    list(LENGTH EXTRACTED_SUBDIRS N_DIRS)
    if(N_DIRS EQUAL 0)
        message(FATAL_ERROR "No directory found after extracting makeself archive.")
    endif()
    list(GET EXTRACTED_SUBDIRS 0 FIRST_SUBDIR)
    set(SRC_DIR "${EXTRACT_TEMP_DIR}/${FIRST_SUBDIR}")

    # 5. 确保所需文件存在
    if(NOT EXISTS "${SRC_DIR}/makeself-header.sh" OR NOT EXISTS "${SRC_DIR}/makeself.sh")
        message(FATAL_ERROR "makeself archive missing required files.")
    endif()

    # 6. 复制到目标目录 MAKESELF_PATH
    file(MAKE_DIRECTORY "${MAKESELF_PATH}")
    execute_process(
        COMMAND ${CMAKE_COMMAND} -E copy
            "${SRC_DIR}/makeself-header.sh"
            "${SRC_DIR}/makeself.sh"
            "${MAKESELF_PATH}"
        RESULT_VARIABLE copy_result
    )
    if(NOT copy_result EQUAL 0)
        message(FATAL_ERROR "Failed to copy makeself files from extracted archive.")
    endif()

    
    # （可选）清理临时文件
    # file(REMOVE_RECURSE "${MAKESELF_TAR}" "${EXTRACT_TEMP_DIR}")
endif()

# 7. 设置可执行权限
execute_process(
    COMMAND chmod 700 "${MAKESELF_PATH}/makeself.sh"
    RESULT_VARIABLE CHMOD_RESULT1
)
execute_process(
    COMMAND chmod 700 "${MAKESELF_PATH}/makeself-header.sh"
    RESULT_VARIABLE CHMOD_RESULT2
)

if(NOT CHMOD_RESULT1 EQUAL 0 OR NOT CHMOD_RESULT2 EQUAL 0)
    message(WARNING "Failed to chmod makeself scripts (may be on Windows).")
endif()