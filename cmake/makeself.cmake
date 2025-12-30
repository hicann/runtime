# -----------------------------------------------------------------------------------------------------------
# Copyright (c) 2025 Huawei Technologies Co., Ltd.
# This program is free software, you can redistribute it and/or modify it under the terms and conditions of
# CANN Open Software License Agreement Version 2.0 (the "License").
# Please refer to the License for details. You may not use this file except in compliance with the License.
# THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
# INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
# See LICENSE in the root of the software repository for the full text of the License.
# -----------------------------------------------------------------------------------------------------------

# makeself.cmake - 自定义 makeself 打包脚本
message(STATUS "CPACK_CMAKE_SOURCE_DIR = ${CPACK_CMAKE_SOURCE_DIR}")
message(STATUS "CPACK_CMAKE_CURRENT_SOURCE_DIR = ${CPACK_CMAKE_CURRENT_SOURCE_DIR}")
message(STATUS "CPACK_CMAKE_BINARY_DIR = ${CPACK_CMAKE_BINARY_DIR}")
message(STATUS "CPACK_PACKAGE_FILE_NAME = ${CPACK_PACKAGE_FILE_NAME}")
message(STATUS "CPACK_CMAKE_INSTALL_PREFIX = ${CPACK_CMAKE_INSTALL_PREFIX}")
message(STATUS "CMAKE_COMMAND = ${CMAKE_COMMAND}")
message(STATUS "CPACK_TEMPORARY_DIRECTORY = ${CPACK_TEMPORARY_DIRECTORY}")

# 创建临时安装目录
set(STAGING_DIR "${CPACK_CMAKE_BINARY_DIR}/_CPack_Packages/makeself_staging")
message(STATUS "STAGING_DIR = ${STAGING_DIR}")
file(MAKE_DIRECTORY "${STAGING_DIR}")
file(MAKE_DIRECTORY "${CPACK_CMAKE_INSTALL_PREFIX}")

# 设置 makeself 路径
set(MAKESELF_EXE ${CPACK_CMAKE_BINARY_DIR}/makeself/makeself.sh)
set(MAKESELF_HEADER_EXE ${CPACK_CMAKE_BINARY_DIR}/makeself/makeself-header.sh)
if(NOT MAKESELF_EXE)
    message(FATAL_ERROR "makeself not found! Install it with: sudo apt install makeself")
endif()

# 执行安装到临时目录
execute_process(
    COMMAND "${CMAKE_COMMAND}" --install "${CPACK_CMAKE_BINARY_DIR}" --prefix "${STAGING_DIR}"
    RESULT_VARIABLE INSTALL_RESULT
)

if(NOT INSTALL_RESULT EQUAL 0)
    message(FATAL_ERROR "Installation to staging directory failed: ${INSTALL_RESULT}")
endif()

# 生成安装配置文件
set(CSV_OUTPUT ${CPACK_CMAKE_BINARY_DIR}/filelist.csv)
execute_process(
    COMMAND python3 -B ${CPACK_CMAKE_SOURCE_DIR}/scripts/package/package.py --pkg_name runtime --os_arch linux-${CPACK_ARCH}
    WORKING_DIRECTORY ${CPACK_CMAKE_BINARY_DIR}
    OUTPUT_VARIABLE result
    ERROR_VARIABLE error
    RESULT_VARIABLE code
    OUTPUT_STRIP_TRAILING_WHITESPACE
)
message(STATUS "package.py result: ${code}")
message(STATUS "package.py result: ${error}")
message(STATUS "package.py result: ${result}")
if (NOT code EQUAL 0)
    message(FATAL_ERROR "Filelist generation failed: ${error}")
else ()
    message(STATUS "Filelist generated successfully: ${result}")

    if (NOT EXISTS ${CSV_OUTPUT})
        message(FATAL_ERROR "Output file not created: ${CSV_OUTPUT}")
    endif ()
endif ()
set(VERSION_OUT_PUT
    ${CPACK_CMAKE_BINARY_DIR}/version.info
)
set(SCENE_OUT_PUT
    ${CPACK_CMAKE_BINARY_DIR}/scene.info
)
set(CANN_VERSION_OUT_PUT
    ${CPACK_CMAKE_BINARY_DIR}/cann_version.h
)
set(RUNTIME_VERSION_OUT_PUT
    ${CPACK_CMAKE_BINARY_DIR}/runtime_version.h
)
configure_file(
    ${SCENE_OUT_PUT}
    ${STAGING_DIR}/share/info/runtime/
    COPYONLY
)
configure_file(
    ${CSV_OUTPUT}
    ${STAGING_DIR}/share/info/runtime/script/
    COPYONLY
)
configure_file(
    ${CANN_VERSION_OUT_PUT}
    ${STAGING_DIR}/runtime/
    COPYONLY
)
configure_file(
    ${RUNTIME_VERSION_OUT_PUT}
    ${STAGING_DIR}/runtime/
    COPYONLY
)
# makeself打包
file(STRINGS ${CPACK_CMAKE_BINARY_DIR}/makeself.txt script_output)
string(REPLACE " " ";" makeself_param_string "${script_output}")

list(LENGTH makeself_param_string LIST_LENGTH)
math(EXPR INSERT_INDEX "${LIST_LENGTH} - 2")
list(INSERT makeself_param_string ${INSERT_INDEX} "${STAGING_DIR}")

message(STATUS "script output: ${script_output}")
message(STATUS "makeself: ${makeself_param_string}")

execute_process(COMMAND bash ${MAKESELF_EXE}
        --header ${MAKESELF_HEADER_EXE}
        --help-header share/info/runtime/script/help.info
        ${makeself_param_string} share/info/runtime/script/install.sh
        WORKING_DIRECTORY ${STAGING_DIR}
        RESULT_VARIABLE EXEC_RESULT
        ERROR_VARIABLE  EXEC_ERROR
)

if(NOT EXEC_RESULT EQUAL 0)
    message(FATAL_ERROR "makeself packaging failed: ${EXEC_ERROR}")
endif()

execute_process(
    COMMAND find ${STAGING_DIR} -mindepth 1 -maxdepth 1 -name "cann-*.run"
    COMMAND xargs cp --target-directory=${CPACK_CMAKE_INSTALL_PREFIX}
    WORKING_DIRECTORY ${STAGING_DIR}
    RESULT_VARIABLE EXEC_RESULT
    ERROR_VARIABLE  EXEC_ERROR
)

if(NOT EXEC_RESULT EQUAL 0)
    message(FATAL_ERROR "makeself copy package failed: ${EXEC_ERROR}")
endif()
