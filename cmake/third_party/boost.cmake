# -----------------------------------------------------------------------------------------------------------
# Copyright (c) 2025 Huawei Technologies Co., Ltd.
# This program is free software, you can redistribute it and/or modify it under the terms and conditions of
# CANN Open Software License Agreement Version 2.0 (the "License").
# Please refer to the License for details. You may not use this file except in compliance with the License.
# THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
# INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
# See LICENSE in the root of the software repository for the full text of the License.
# -----------------------------------------------------------------------------------------------------------
set(BOOST_NAME "boost")
set(BOOST_PATH ${OPEN_SOURCE_DIR}/boost-1.87.0)

# 默认配置的boost不存在则下载
if (NOT EXISTS "${BOOST_PATH}/boost/config.hpp")
    message("boost not use cache, start download")
    set(BOOST_URL "https://gitcode.com/cann-src-third-party/boost/releases/download/v1.87.0/boost_1_87_0.tar.gz")
    message(STATUS "Downloading ${BOOST_NAME} from ${BOOST_URL}")

    include(FetchContent)
    FetchContent_Declare(
        ${BOOST_NAME}
        URL ${BOOST_URL}
        URL_HASH SHA256=f55c340aa49763b1925ccf02b2e83f35fdcf634c9d5164a2acb87540173c741d
        DOWNLOAD_DIR ${third_party_TEM_DIR}
        SOURCE_DIR "${BOOST_PATH}"  # 直接解压到此目录
        TLS_VERIFY OFF
    )
    FetchContent_MakeAvailable(${BOOST_NAME})
else ()
    message("boost use cache")
endif()