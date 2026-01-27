# -----------------------------------------------------------------------------------------------------------
# Copyright (c) 2025 Huawei Technologies Co., Ltd.
# This program is free software, you can redistribute it and/or modify it under the terms and conditions of
# CANN Open Software License Agreement Version 2.0 (the "License").
# Please refer to the License for details. You may not use this file except in compliance with the License.
# THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
# INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
# See LICENSE in the root of the software repository for the full text of the License.
# -----------------------------------------------------------------------------------------------------------
if (BUILD_WITH_INSTALLED_DEPENDENCY_CANN_PKG)
    message(STATUS "openssl libpath: ${OPEN_SOURCE_DIR}/lib_cache_ge/openssl")
    find_file(CRYPTO_LIB_PATH
        NAMES libcrypto.a
        PATHS ${OPEN_SOURCE_DIR}/lib_cache_ge/openssl
        PATH_SUFFIXES lib lib64
        NO_DEFAULT_PATH)
    if (CRYPTO_LIB_PATH)
        message(STATUS "Use local libcrypto: ${CRYPTO_LIB_PATH}")
    else()
        include(ExternalProject)

        # ========== 基本路径配置 ==========
        set(OPENSSL_TARBALL https://gitcode.com/cann-src-third-party/openssl/releases/download/openssl-3.0.9/openssl-openssl-3.0.9.tar.gz)   # 源码包
        set(OPENSSL_SRC_DIR ${CMAKE_BINARY_DIR}/openssl-src)        # 解压后的源码路径
        set(OPENSSL_INSTALL_DIR ${CMAKE_BINARY_DIR}/openssl-install) # 安装路径
        set(OPENSSL_INSTALL_LIBDIR ${OPENSSL_INSTALL_DIR}/lib)

        # ========== 工具链配置（根据系统架构判断） ==========
        if(CMAKE_SYSTEM_PROCESSOR STREQUAL "x86_64")
            set(OPENSSL_PLATFORM linux-x86_64)
            set(OPENSSL_INSTALL_LIBDIR ${OPENSSL_INSTALL_DIR}/lib64)
        elseif(CMAKE_SYSTEM_PROCESSOR STREQUAL "aarch64")
            set(OPENSSL_PLATFORM linux-aarch64)
        elseif(CMAKE_SYSTEM_PROCESSOR STREQUAL "arm")
            set(OPENSSL_PLATFORM linux-armv4)
        else()
            set(OPENSSL_PLATFORM linux-generic64)
        endif()

        # ========== 编译选项 ==========
        set(OPENSSL_OPTION "-fstack-protector-all -D_FORTIFY_SOURCE=2 -O2 -Wl,-z,relro,-z,now,-z,noexecstack -Wl,--build-id=none -s")

        if("${DEVICE_TOOLCHAIN}" STREQUAL "arm-tiny-hcc-toolchain.cmake")
            set(OPENSSL_OPTION "-mcpu=cortex-a55 -mfloat-abi=hard ${OPENSSL_OPTION}")
        elseif("${DEVICE_TOOLCHAIN}" STREQUAL "arm-nano-hcc-toolchain.cmake")
            set(OPENSSL_OPTION "-mcpu=cortex-a9 -mfloat-abi=soft ${OPENSSL_OPTION}")
        endif()

        find_program(CCACHE_PROGRAM ccache)
        if(CCACHE_PROGRAM)
            set(OPENSSL_CC "${CCACHE_PROGRAM} ${CMAKE_C_COMPILER}")
            set(OPENSSL_CXX "${CCACHE_PROGRAM} ${CMAKE_CXX_COMPILER}")
        else()
            set(OPENSSL_CC "${CMAKE_C_COMPILER}")
            set(OPENSSL_CXX "${CMAKE_CXX_COMPILER}")
        endif()

        # ========== Perl 路径(OpenSSL 的 configure 依赖 Perl)==========
        find_program(PERL_PATH perl REQUIRED)

        # ========== 构建命令 ==========
        set(OPENSSL_MAKE_CMD make)
        set(OPENSSL_INSTALL_CMD make install_dev)
        # ========== ExternalProject_Add ==========
        if (NOT EXISTS "${OPEN_SOURCE_DIR}/openssl/Configure")
            message("openssl:not use cache")
            ExternalProject_Add(openssl_project
                URL ${OPENSSL_TARBALL}                        # 从本地 tar.gz 获取源码
                #URL_HASH SHA256=SKIP                          # 可加校验哈希，也可用 SKIP
                DOWNLOAD_DIR ${CMAKE_BINARY_DIR}/downloads
                SOURCE_DIR ${OPENSSL_SRC_DIR}                 # 解压后的源码目录
                CONFIGURE_COMMAND
                    unset CROSS_COMPILE &&
                    export NO_OSSL_RENAME_VERSION=1 &&
                    ${PERL_PATH} <SOURCE_DIR>/Configure
                    ${OPENSSL_PLATFORM}
                    no-asm enable-shared threads enable-ssl3-method no-tests
                    ${OPENSSL_OPTION}
                    CC=${OPENSSL_CC}
                    CXX=${OPENSSL_CXX}
                    --prefix=${OPENSSL_INSTALL_DIR}
                BUILD_COMMAND ${OPENSSL_MAKE_CMD}
                INSTALL_COMMAND ${OPENSSL_INSTALL_CMD}
                BUILD_IN_SOURCE TRUE                          # OpenSSL 不支持分离构建目录
            )
        else()
            message("compile openssl use cache")
            ExternalProject_Add(openssl_project
                SOURCE_DIR ${OPEN_SOURCE_DIR}/openssl
                CONFIGURE_COMMAND
                    unset CROSS_COMPILE &&
                    export NO_OSSL_RENAME_VERSION=1 &&
                    ${PERL_PATH} <SOURCE_DIR>/Configure
                    ${OPENSSL_PLATFORM}
                    no-asm enable-shared threads enable-ssl3-method no-tests
                    ${OPENSSL_OPTION}
                    CC=${OPENSSL_CC}
                    CXX=${OPENSSL_CXX}
                    --prefix=${OPENSSL_INSTALL_DIR}
                BUILD_COMMAND ${OPENSSL_MAKE_CMD}
                INSTALL_COMMAND ${OPENSSL_INSTALL_CMD}
                BUILD_IN_SOURCE TRUE                          # OpenSSL 不支持分离构建目录
            )
        endif()
        set(CRYPTO_LIB_PATH "${OPENSSL_INSTALL_LIBDIR}/libcrypto.a")
    endif()

    message(STATUS "libcrypto: ${CRYPTO_LIB_PATH}")
    add_library(crypto_static STATIC IMPORTED)
    add_dependencies(crypto_static openssl_project)
    set_target_properties(crypto_static PROPERTIES
            IMPORTED_LOCATION             "${CRYPTO_LIB_PATH}"
    )
endif()