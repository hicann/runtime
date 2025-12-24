# -----------------------------------------------------------------------------------------------------------
# Copyright (c) 2025 Huawei Technologies Co., Ltd.
# This program is free software, you can redistribute it and/or modify it under the terms and conditions of
# CANN Open Software License Agreement Version 2.0 (the "License").
# Please refer to the License for details. You may not use this file except in compliance with the License.
# THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
# INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
# See LICENSE in the root of the software repository for the full text of the License.
# -----------------------------------------------------------------------------------------------------------

include(ExternalProject)

if (BUILD_WITH_INSTALLED_DEPENDENCY_CANN_PKG)
    set(REQ_URL "https://gitcode.com/cann-src-third-party/libboundscheck/releases/download/v1.1.16/libboundscheck-v1.1.16.tar.gz")
    set(CSEC_DOWNLOAD_DIR ${CMAKE_BINARY_DIR}/libc_sec)
    set(CSEC_SOURCE_DIR ${CMAKE_BINARY_DIR}/libc_sec/source)
    set(SO_NEW_NAME libc_sec.so)
    set(STATIC_NEW_NAME libc_sec.a)
    set(SO_ORIGINAL_NAME libboundscheck.so)
    if (BUILD_WITH_INSTALLED_DEPENDENCY_CANN_PKG_COMMUNITY)
        message("secc not use cache")
        # 下载/解压 libc_sec 源码
        ExternalProject_Add(csec_src
            URL               ${REQ_URL}
            DOWNLOAD_DIR      ${CSEC_DOWNLOAD_DIR}
            SOURCE_DIR        ${CSEC_SOURCE_DIR}
            PATCH_COMMAND ${CMAKE_COMMAND}
                -D CSEC_SOURCE_DIR=<SOURCE_DIR> 
                -P ${CMAKE_CURRENT_LIST_DIR}/csec_patch.cmake
            CONFIGURE_COMMAND ""
            BUILD_IN_SOURCE 1
            BUILD_COMMAND 
                ${CMAKE_MAKE_PROGRAM} -C <SOURCE_DIR> lib
                CC=${CMAKE_C_COMPILER}
                AR=${CMAKE_AR}
                LINK=${CMAKE_C_COMPILER}
            INSTALL_COMMAND ${CMAKE_COMMAND} -E copy <SOURCE_DIR>/lib/${SO_ORIGINAL_NAME} <SOURCE_DIR>/lib/${SO_NEW_NAME}
        )
        add_library(shared_c_sec_lib SHARED IMPORTED)
        set_property(TARGET shared_c_sec_lib PROPERTY
            IMPORTED_LOCATION ${CSEC_SOURCE_DIR}/lib/${SO_NEW_NAME}
        )

        add_library(shared_c_sec INTERFACE)
        target_link_libraries(shared_c_sec INTERFACE shared_c_sec_lib)
        add_dependencies(shared_c_sec csec_src)
        add_custom_target(csec_build DEPENDS csec_src)
        add_library(c_sec ALIAS shared_c_sec)
    
        install(FILES
            ${CSEC_SOURCE_DIR}/lib/${SO_NEW_NAME} ${CSEC_SOURCE_DIR}/lib/${STATIC_NEW_NAME}
            DESTINATION runtime/lib
        )
        set(LIBC_SEC_HEADER ${CSEC_SOURCE_DIR}/include)
    else()
        message("secc use cache。")
        add_subdirectory(${RUNTIME_DIR}/third_party/libc_sec ${CMAKE_BINARY_DIR}/libc_sec)
        set(LIBC_SEC_HEADER ${RUNTIME_DIR}/third_party/libc_sec/include)
    endif()
else()
    set(LIBC_SEC_HEADER ${RUNTIME_DIR}/third_party/libc_sec/include)
endif()





