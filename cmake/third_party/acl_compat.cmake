# -----------------------------------------------------------------------------------------------------------
# Copyright (c) 2025 Huawei Technologies Co., Ltd.
# This program is free software, you can redistribute it and/or modify it under the terms and conditions of
# CANN Open Software License Agreement Version 2.0 (the "License").
# Please refer to the License for details. You may not use this file except in compliance with the License.
# THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
# INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
# See LICENSE in the root of the software repository for the full text of the License.
# -----------------------------------------------------------------------------------------------------------

add_custom_target(copy_acl_headers_and_libs)
if (BUILD_WITH_INSTALLED_DEPENDENCY_CANN_PKG AND NOT EXISTS "${CMAKE_BINARY_DIR}/include_acl")
    include(ExternalProject)
    set(ACL_DOWNLOAD_DIR "${CMAKE_BINARY_DIR}/download")
    set(ACL_SOURCE_DIR "${CMAKE_BINARY_DIR}/acl")

    string(TOLOWER "${CMAKE_SYSTEM_PROCESSOR}" ARCH_LOW)
    if(ARCH_LOW MATCHES "x86_64|amd64")
        set(TARGET_ARCH "x86_64")
    elseif(ARCH_LOW MATCHES "aarch64|arm64")
        set(TARGET_ARCH "aarch64")
    else()
        message(FATAL_ERROR "Unsupported architecture: ${CMAKE_SYSTEM_PROCESSOR}")
    endif()

    set(REQ_URL "https://mirrors.huaweicloud.com/artifactory/cann-run/8.5.0/inner/${TARGET_ARCH}/acl-compat_8.5.0_linux-${TARGET_ARCH}.tar.gz")
    include(ExternalProject)
    ExternalProject_Add(acl_compat_tar
            URL ${REQ_URL}
            TLS_VERIFY OFF
            DOWNLOAD_DIR ${ACL_DOWNLOAD_DIR}
            SOURCE_DIR ${ACL_SOURCE_DIR}
            CONFIGURE_COMMAND ""
            BUILD_COMMAND ""
            INSTALL_COMMAND ""
            UPDATE_COMMAND ""
    )
    set(DST_LIB_DIR "${CMAKE_BINARY_DIR}/lib_acl")
    set(DST_INCLUDE_DIR "${CMAKE_BINARY_DIR}/include_acl")
    add_custom_target(_copy_acl_headers_and_libs ALL
        COMMAND ${CMAKE_COMMAND} -E make_directory "${DST_LIB_DIR}"
        COMMAND ${CMAKE_COMMAND} -E copy_directory "${ACL_SOURCE_DIR}/lib64" "${DST_LIB_DIR}"
        COMMAND ${CMAKE_COMMAND} -E make_directory "${DST_INCLUDE_DIR}"
        COMMAND ${CMAKE_COMMAND} -E copy_directory "${ACL_SOURCE_DIR}/include" "${DST_INCLUDE_DIR}"
        DEPENDS acl_compat_tar 
        COMMENT "Copying ACL lib/include to lib_acl and include_acl"
        VERBATIM
    )
    add_dependencies(copy_acl_headers_and_libs _copy_acl_headers_and_libs)
endif()