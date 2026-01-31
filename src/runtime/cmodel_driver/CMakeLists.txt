# -----------------------------------------------------------------------------------------------------------
# Copyright (c) 2025 Huawei Technologies Co., Ltd.
# This program is free software, you can redistribute it and/or modify it under the terms and conditions of
# CANN Open Software License Agreement Version 2.0 (the "License").
# Please refer to the License for details. You may not use this file except in compliance with the License.
# THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
# INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
# See LICENSE in the root of the software repository for the full text of the License.
# -----------------------------------------------------------------------------------------------------------
SET(PRODUCT_TYPE_LIST ascend310 ascend610 bs9sx1a ascend310p ascend910 hi3796cv300es hi3796cv300cs ascend910B1 ascend310B ascend610Lite ascend950pr_9599 mc62cm12a)

SET(CMODEL_DRIVER_SRC
    driver_api.c
    driver_impl.c
    driver_mem.c
    driver_queue.c
    )

SET(CMODEL_DRIVER_INCLUDE
    ${RUNTIME_DIR}/inc
    ${RUNTIME_DIR}/inc/external
    ${RUNTIME_DIR}/abl/libc_sec/include
    )

foreach(product_type ${PRODUCT_TYPE_LIST})
    if("${product_type}" STREQUAL "ascend610" OR "${product_type}" STREQUAL "ascend310p")
        SET(MODEL_VERSION MODEL_V200)
    elseif("${product_type}" STREQUAL "hi3796cv300es" OR "${product_type}" STREQUAL "hi3796cv300cs")
        SET(MODEL_VERSION MODEL_V200)
    elseif("${product_type}" STREQUAL "ascend610Lite")
        SET(MODEL_VERSION MODEL_V310)
    else()
        SET(MODEL_VERSION MODEL_V100)
    endif()

    if("${product_type}" STREQUAL "ascend310" OR "${product_type}" STREQUAL "ascend950pr_9599" OR "${product_type}" STREQUAL "mc62cm12a")
        SET(MODEL_DRIVER_ADAPT_DEFINITIONS PLATFORM_MINI_V1)
    elseif("${product_type}" STREQUAL "ascend610" OR "${product_type}" STREQUAL "ascend310p")
        SET(MODEL_DRIVER_ADAPT_DEFINITIONS PLATFORM_MINI_V2)
    elseif("${product_type}" STREQUAL "ascend910")
        SET(MODEL_DRIVER_ADAPT_DEFINITIONS PLATFORM_CLOUD_V1)
    elseif("${product_type}" STREQUAL "hi3796cv300es" OR "${product_type}" STREQUAL "hi3796cv300cs")
        SET(MODEL_DRIVER_ADAPT_DEFINITIONS PLATFORM_LHISI_ES)
    elseif("${product_type}" STREQUAL "ascend610Lite")
        SET(MODEL_DRIVER_ADAPT_DEFINITIONS PLATFORM_ADC_LITE)
    endif()

    # ---------------------------------- npu_drv ----------------------------------
    add_library(npu_drv_${product_type}
        SHARED
        ${CMODEL_DRIVER_SRC}
        )

    target_include_directories(npu_drv_${product_type} PRIVATE
        ${CMODEL_DRIVER_INCLUDE}
    )

    target_compile_definitions(npu_drv_${product_type} PRIVATE
        FEATURE_NOTIFY
        ${MODEL_VERSION}
        ${MODEL_DRIVER_ADAPT_DEFINITIONS}
    )

    # 非llt场景下添加如下编译宏
    if(NOT PACKAGE STREQUAL "ut" AND NOT PACKAGE STREQUAL "st")
        target_compile_definitions(npu_drv_${product_type} PRIVATE
            __DRV_CFG_DEV_PLATFORM_ESL__
            )
    endif()

    target_compile_options(npu_drv_${product_type} PRIVATE
        -O3
        -fno-common
        -fno-strict-aliasing
        -fsigned-char
    )

    target_link_libraries(npu_drv_${product_type} PRIVATE
        $<BUILD_INTERFACE:intf_pub>
	$<BUILD_INTERFACE:model_headers>
        c_sec
    )

    set_target_properties(npu_drv_${product_type} PROPERTIES
        OUTPUT_NAME npu_drv
        LIBRARY_OUTPUT_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/${product_type}
    )

    install(TARGETS npu_drv_${product_type}
            LIBRARY DESTINATION lib/${product_type} OPTIONAL
            )

    # -------------------------------- npu_drv_pvmodel --------------------------------
    add_library(npu_drv_pvmodel_${product_type}
        SHARED
        ${CMODEL_DRIVER_SRC}
        )

    target_include_directories(npu_drv_pvmodel_${product_type} PRIVATE
        ${CMODEL_DRIVER_INCLUDE}
    )

    target_compile_definitions(npu_drv_pvmodel_${product_type} PRIVATE
        ${MODEL_VERSION}
        ${MODEL_DRIVER_ADAPT_DEFINITIONS}
    )

    if("${product_type}" STREQUAL "hi3796cv300es"  OR "${product_type}" STREQUAL "hi3796cv300cs")
        target_compile_options(npu_drv_pvmodel_${product_type} PRIVATE
            -O3
        )
    endif()

    target_compile_options(npu_drv_pvmodel_${product_type} PRIVATE
        -fno-common
        -fno-strict-aliasing
        -fsigned-char
    )

    if("${product_type}" STREQUAL "ascend910B1" OR "${product_type}" STREQUAL "ascend310B" OR "${product_type}" STREQUAL "ascend950pr_9599" OR "${product_type}" STREQUAL "mc62cm12a")
        target_link_libraries(npu_drv_pvmodel_${product_type} PRIVATE
            $<BUILD_INTERFACE:intf_pub>
            $<BUILD_INTERFACE:tsch_headers>
            $<BUILD_INTERFACE:model_headers>
            c_sec
        )

    else()
        target_link_libraries(npu_drv_pvmodel_${product_type} PRIVATE
            $<BUILD_INTERFACE:intf_pub>
            $<BUILD_INTERFACE:tsch_headers>
            $<BUILD_INTERFACE:model_headers>
            c_sec
            tsch_${product_type}
            pvmodel_${product_type}
        )
    endif()

    set_target_properties(npu_drv_pvmodel_${product_type} PROPERTIES
        OUTPUT_NAME npu_drv_pvmodel
        LIBRARY_OUTPUT_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/${product_type}
    )

    install(TARGETS npu_drv_pvmodel_${product_type}
            LIBRARY DESTINATION lib/${product_type} OPTIONAL
            )

    # -------------------------------- npu_drv_camodel --------------------------------
    add_library(npu_drv_camodel_${product_type}
        SHARED
        ${CMODEL_DRIVER_SRC}
        )

    target_include_directories(npu_drv_camodel_${product_type} PRIVATE
        ${CMODEL_DRIVER_INCLUDE}
    )

    target_compile_definitions(npu_drv_camodel_${product_type} PRIVATE
        ${MODEL_VERSION}
        ${MODEL_DRIVER_ADAPT_DEFINITIONS}
    )

    if("${product_type}" STREQUAL "hi3796cv300es"  OR "${product_type}" STREQUAL "hi3796cv300cs")
        target_compile_options(npu_drv_camodel_${product_type} PRIVATE
            -O3
        )
    endif()

    target_compile_options(npu_drv_camodel_${product_type} PRIVATE
        -fno-common
        -fno-strict-aliasing
        -fsigned-char
    )

    if("${product_type}" STREQUAL "ascend910B1" OR "${product_type}" STREQUAL "ascend310B" OR "${product_type}" STREQUAL "ascend950pr_9599" OR "${product_type}" STREQUAL "mc62cm12a")
        target_link_libraries(npu_drv_camodel_${product_type} PRIVATE
            $<BUILD_INTERFACE:intf_pub>
            $<BUILD_INTERFACE:tsch_headers>
            $<BUILD_INTERFACE:model_headers>
            c_sec
        )
    elseif("${product_type}" STREQUAL "ascend610Lite")
        target_link_libraries(npu_drv_camodel_${product_type} PRIVATE
            $<BUILD_INTERFACE:intf_pub>
            $<BUILD_INTERFACE:tsch_headers>
            $<BUILD_INTERFACE:model_headers>
            c_sec
            tsch_camodel_${product_type}
            davinci_model_top
        )
    else()
        target_link_libraries(npu_drv_camodel_${product_type} PRIVATE
            $<BUILD_INTERFACE:intf_pub>
            $<BUILD_INTERFACE:tsch_headers>
            $<BUILD_INTERFACE:model_headers>
            c_sec
            tsch_camodel_${product_type}
            camodel_${product_type}
        )
    endif()

    set_target_properties(npu_drv_camodel_${product_type} PROPERTIES
        OUTPUT_NAME npu_drv_camodel
        LIBRARY_OUTPUT_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/${product_type}
    )

    install(TARGETS npu_drv_camodel_${product_type}
            LIBRARY DESTINATION lib/${product_type} OPTIONAL
            )
endforeach()
