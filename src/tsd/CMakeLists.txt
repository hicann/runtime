# -----------------------------------------------------------------------------------------------------------
# Copyright (c) 2025 Huawei Technologies Co., Ltd.
# This program is free software, you can redistribute it and/or modify it under the terms and conditions of
# CANN Open Software License Agreement Version 2.0 (the "License").
# Please refer to the License for details. You may not use this file except in compliance with the License.
# THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
# INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
# See LICENSE in the root of the software repository for the full text of the License.
# -----------------------------------------------------------------------------------------------------------
set(CMAKE_VERBOSE_MAKEFILE ON)
set(BASE_DIR ${CMAKE_CURRENT_SOURCE_DIR})
project (tsd)
set(INSTALL_LIBRARY_DIR lib)
set(INSTALL_RUNTIME_DIR bin)
if (AOSCORE_LLVM_MUSL)
    add_definitions(-D_AOSCORE_)
endif()

message("-- INSTALL_LIBRARY_DIR   " ${INSTALL_LIBRARY_DIR}})
message("-- INSTALL_RUNTIME_DIR   " ${INSTALL_RUNTIME_DIR}})


include(CMakePackageConfigHelpers)

SET(SUPPORT_IAM false)
SET(SUPPORT_SELINUX false)
if (PRODUCT)
    if ((${PRODUCT} STREQUAL ascend310p) OR (${PRODUCT} STREQUAL ascend910) OR
        (${PRODUCT} STREQUAL ascend910B) OR
        (${PRODUCT} STREQUAL ascend310B) OR (${PRODUCT} STREQUAL ascend310Brc) OR
        (${PRODUCT} STREQUAL ascend910_95) OR (${PRODUCT} STREQUAL ascend910_95esl) OR
        (${PRODUCT} STREQUAL ascend910_96) OR (${PRODUCT} STREQUAL ascend910_96esl) OR
        (${PRODUCT} STREQUAL helper310p))
        SET(SUPPORT_IAM true)
    endif()
    if ((${PRODUCT} STREQUAL ascend310p) OR
        (${PRODUCT} STREQUAL ascend310B) OR (${PRODUCT} STREQUAL ascend310Brc))
        SET(SUPPORT_SELINUX true)
    endif()
endif()

SET(CMS_CBB_VERIFY_PKT false)

if (PRODUCT)
    if ((${PRODUCT} STREQUAL ascend910B) OR (${PRODUCT} STREQUAL ascend910C) OR
        (${PRODUCT} STREQUAL ascend310B) OR (${PRODUCT} STREQUAL ascend310Brc) OR
        (${PRODUCT} STREQUAL ascend910_95) OR (${PRODUCT} STREQUAL ascend910_95esl) OR
        (${PRODUCT} STREQUAL ascend910_96) OR (${PRODUCT} STREQUAL ascend910_96esl) OR
        (${PRODUCT} STREQUAL ascend))
        SET(CMS_CBB_VERIFY_PKT true)
    endif()
endif()

SET(TSD_DEPLOY_ON_HOST false)

if (PRODUCT)
    if (((${PRODUCT} STREQUAL ascend910B) OR (${PRODUCT} STREQUAL ascend910C) OR
         (${PRODUCT} STREQUAL ascend910_95) OR (${PRODUCT} STREQUAL ascend910_95esl) OR
         (${PRODUCT} STREQUAL ascend910_96) OR (${PRODUCT} STREQUAL ascend910_96esl)) AND (${PRODUCT_SIDE} STREQUAL "host"))
        SET(TSD_DEPLOY_ON_HOST true)
    endif()
endif()

SET(TSD_SUPPORT_SUBPROC_SAFE_START false)

if (PRODUCT)
    if (((${PRODUCT} STREQUAL ascend910B) OR (${PRODUCT} STREQUAL ascend910C) OR (${PRODUCT} STREQUAL ascend310p) OR
         (${PRODUCT} STREQUAL ascend910_95) OR (${PRODUCT} STREQUAL ascend910_95esl) OR
         (${PRODUCT} STREQUAL ascend910_96) OR (${PRODUCT} STREQUAL ascend910_96esl)) AND
        (${PRODUCT_SIDE} STREQUAL "device"))
        SET(TSD_SUPPORT_SUBPROC_SAFE_START true)
    endif()
endif()

SET(NUMA_CHECK_OOM false)

if (PRODUCT)
    if (((${PRODUCT} STREQUAL ascend910B) OR (${PRODUCT} STREQUAL ascend910C)) AND
        (${PRODUCT_SIDE} STREQUAL "device"))
        SET(NUMA_CHECK_OOM true)
    endif()
endif()

set(CMS_VERIFY_SIGNED_PKG false)

if(ENABLE_SIGNATURE)
    set(CMS_VERIFY_SIGNED_PKG true)
endif()

SET(SUPPORT_ASCEND_MONITOR false)
if (PRODUCT)
    if ((${SUPPORT_IAM} STREQUAL false) AND ((NOT (${PRODUCT} STREQUAL ascend610)) AND
                                             (NOT (${PRODUCT} STREQUAL ascend615)) AND
                                             (NOT (${PRODUCT} STREQUAL as31xm1)) AND
                                             (NOT (${PRODUCT} STREQUAL ascend610Lite))))
        SET(SUPPORT_ASCEND_MONITOR true)
    endif()
endif()

SET(TSD_SUPPORT_AI_SERVER_NO310P false)

if (PRODUCT)
    if (((${PRODUCT} STREQUAL ascend910B) OR (${PRODUCT} STREQUAL ascend910C) OR
         (${PRODUCT} STREQUAL ascend910_95) OR (${PRODUCT} STREQUAL ascend910_95esl) OR
         (${PRODUCT} STREQUAL ascend910_96) OR (${PRODUCT} STREQUAL ascend910_96esl)) AND (${PRODUCT_SIDE} STREQUAL "device"))
        SET(TSD_SUPPORT_AI_SERVER_NO310P true)
    endif()
endif()

SET(UDF_SAFE_START false)

if (PRODUCT)
    if ((${PRODUCT} STREQUAL helper310p) OR
        (((${PRODUCT} STREQUAL ascend910B) OR (${PRODUCT} STREQUAL ascend910C) OR
          (${PRODUCT} STREQUAL ascend910_95) OR (${PRODUCT} STREQUAL ascend910_95esl) OR
          (${PRODUCT} STREQUAL ascend910_96) OR (${PRODUCT} STREQUAL ascend910_96esl)) AND
        (${PRODUCT_SIDE} STREQUAL "device")))
        SET(UDF_SAFE_START true)
    endif()
endif()

SET(AICPU_CUST_SAFE_START false)
SET(TSD_VF_MODE false)
SET(TSD_VDEVICE_MODE false)
SET(TSD_SET_FIFO_MODE false)
SET(EVENT_SCH_SENDER_CHECK false)
SET(TSD_SUPPORT_DRIVER_EXTEND false)
SET(TSD_SUPPORT_ASCENDCPP false)
SET(TSD_STARS_PRODUCT false)
if (PRODUCT)
    if ((${PRODUCT} STREQUAL ascend310p) OR 
        (${PRODUCT} STREQUAL helper310p) OR
        (${PRODUCT} STREQUAL ascend910) OR
        (${PRODUCT} STREQUAL ascend310B) OR
        (((${PRODUCT} STREQUAL ascend910B) OR (${PRODUCT} STREQUAL ascend910C) OR
          (${PRODUCT} STREQUAL ascend910_95) OR (${PRODUCT} STREQUAL ascend910_95esl)) AND
        (${PRODUCT_SIDE} STREQUAL "device")))
        SET(AICPU_CUST_SAFE_START true)
    endif()

    if ((${PRODUCT} STREQUAL ascend310p) OR (${PRODUCT} STREQUAL helper310p) OR (${PRODUCT} STREQUAL ascend910))
        SET(TSD_VF_MODE true)
    endif()

    if ((${PRODUCT} STREQUAL ascend910B) OR (${PRODUCT} STREQUAL ascend910C) OR (${PRODUCT} STREQUAL ascend310B) OR
        (${PRODUCT} STREQUAL ascend910_95) OR (${PRODUCT} STREQUAL ascend910_95esl) OR
        (${PRODUCT} STREQUAL ascend910_96) OR (${PRODUCT} STREQUAL ascend910_96esl))
        SET(TSD_VDEVICE_MODE true)
    endif()

    if (((${PRODUCT} STREQUAL ascend910B) OR (${PRODUCT} STREQUAL ascend910C) OR (${PRODUCT} STREQUAL helper310p) OR
         (${PRODUCT} STREQUAL ascend910_95) OR (${PRODUCT} STREQUAL ascend910_95esl) OR
         (${PRODUCT} STREQUAL ascend910_96) OR (${PRODUCT} STREQUAL ascend910_96esl))
         AND (${PRODUCT_SIDE} STREQUAL "device"))
        SET(TSD_SET_FIFO_MODE true)
    endif()

     if (((${PRODUCT} STREQUAL ascend910B) OR (${PRODUCT} STREQUAL ascend910C)) AND (${PRODUCT_SIDE} STREQUAL "device"))
        SET(EVENT_SCH_SENDER_CHECK true)
    endif()

    if (((${PRODUCT} STREQUAL ascend910B) OR (${PRODUCT} STREQUAL ascend910C))
         AND (${PRODUCT_SIDE} STREQUAL "device"))
        SET(TSD_SUPPORT_DRIVER_EXTEND true)
    endif()

    if (((${PRODUCT} STREQUAL ascend910B) OR (${PRODUCT} STREQUAL ascend910_95) OR (${PRODUCT} STREQUAL ascend910_95esl) OR
         (${PRODUCT} STREQUAL ascend910_96) OR (${PRODUCT} STREQUAL ascend910_96esl))
         AND (${PRODUCT_SIDE} STREQUAL "device"))
        SET(TSD_SUPPORT_ASCENDCPP true)
    endif()

    if (((${PRODUCT} STREQUAL ascend910B) OR (${PRODUCT} STREQUAL ascend910C))
         AND (${PRODUCT_SIDE} STREQUAL "device"))
        SET(TSD_STARS_PRODUCT true)
    endif()
endif()


add_subdirectory(tsdclient)
install_package(
    PACKAGE tsd
    TARGETS tsdclient
)
