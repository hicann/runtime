# -----------------------------------------------------------------------------------------------------------
# Copyright (c) 2025 Huawei Technologies Co., Ltd.
# This program is free software, you can redistribute it and/or modify it under the terms and conditions of
# CANN Open Software License Agreement Version 2.0 (the "License").
# Please refer to the License for details. You may not use this file except in compliance with the License.
# THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
# INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
# See LICENSE in the root of the software repository for the full text of the License.
# -----------------------------------------------------------------------------------------------------------

add_custom_target(copy_aicpu_libs)

include(ExternalProject)
set(AICPU_DOWNLOAD_DIR "${CMAKE_BINARY_DIR}/download")
set(AICPU_SOURCE_DIR "${CMAKE_BINARY_DIR}/aicpu")

string(TOLOWER "${CMAKE_SYSTEM_PROCESSOR}" ARCH_LOW)
if(ARCH_LOW MATCHES "x86_64|amd64")
    set(TARGET_ARCH "x86_64")
elseif(ARCH_LOW MATCHES "aarch64|arm64")
    set(TARGET_ARCH "aarch64")
else()
    message(FATAL_ERROR "Unsupported architecture: ${CMAKE_SYSTEM_PROCESSOR}")
endif()

set(REQ_URL "https://ascend.devcloud.huaweicloud.com/cann/run/dependency/8.5.0-beta.1/${TARGET_ARCH}/basic/cann-runtime-binary-${TARGET_ARCH}.tar.gz")
include(ExternalProject)
ExternalProject_Add(aicpu_tar_fetcher
        URL ${REQ_URL}
        TLS_VERIFY OFF
        DOWNLOAD_DIR ${AICPU_DOWNLOAD_DIR}
        SOURCE_DIR ${AICPU_SOURCE_DIR}
        CONFIGURE_COMMAND ""
        BUILD_COMMAND ""
        INSTALL_COMMAND ""
        UPDATE_COMMAND ""
)
set(DST_LIB_DIR "${CMAKE_BINARY_DIR}/lib_aicpu")
add_custom_target(_copy_aicpu_libs ALL
    COMMAND ${CMAKE_COMMAND} -E make_directory "${DST_LIB_DIR}"
    COMMAND ${CMAKE_COMMAND} -E copy_directory "${AICPU_SOURCE_DIR}" "${DST_LIB_DIR}"
    DEPENDS aicpu_tar_fetcher 
    COMMENT "Copying AICPU libs to lib_aicpu"
    VERBATIM
)
add_dependencies(copy_aicpu_libs _copy_aicpu_libs)