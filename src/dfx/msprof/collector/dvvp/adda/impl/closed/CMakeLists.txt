# -----------------------------------------------------------------------------------------------------------
# Copyright (c) 2025 Huawei Technologies Co., Ltd.
# This program is free software, you can redistribute it and/or modify it under the terms and conditions of
# CANN Open Software License Agreement Version 2.0 (the "License").
# Please refer to the License for details. You may not use this file except in compliance with the License.
# THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
# INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
# See LICENSE in the root of the software repository for the full text of the License.
# -----------------------------------------------------------------------------------------------------------
set(BASE_DIR ${CMAKE_CURRENT_SOURCE_DIR}/../)
set(INSTALL_LIBRARY_DIR lib)

############### adda ###################
set(addaCppList
    ${BASE_DIR}/adx_dsmi.cpp
    ${BASE_DIR}/ide_daemon.cpp
    ${BASE_DIR}/ide_daemon_hdc.cpp
    ${BASE_DIR}/ide_daemon_monitor.cpp
    ${BASE_DIR}/ide_task_register.cpp
    ${BASE_DIR}/impl_utils.cpp
    ${BASE_DIR}/ide_common_util.cpp
    ${BASE_DIR}/ide_platform_util.cpp
    ../../../common/utils/utils.cpp
    ../../../common/cmd_log/cmd_log.cpp
    ${PROF_BASIC_DIR}/osal/osal.c
    ../../../profhal/adx/wrapper/memory_utils.cpp
    ../../../depend/stub/error_manager/msprof_error_manager_stub.cpp
)

set(addaHeaderList
    ../../../
    ../../../common
    ${PROF_BASIC_DIR}/osal
    ../../../common/logger
    ../../../profhal/adx/inc
    ../../../depend/include/stub
    ${RUNTIME_DIR}/src/dfx/error_manager
)
if (PRODUCT)
if (${PRODUCT} STREQUAL "ascend310p" OR ${PRODUCT} STREQUAL "ascend910" OR ${PRODUCT} STREQUAL "ascend910B" OR ${PRODUCT} STREQUAL "ascend310B" OR ${PRODUCT} STREQUAL "ascend310Brc" OR ${PRODUCT} STREQUAL "ascend310Besl")
    list(APPEND addaHeaderList
        ${IAM_HEADER_DIR}/include
        ${MDC_LINUX_SDK_DIR}/include)
endif ()
endif ()
add_executable(adda
    ${addaCppList}
)

set_target_properties(adda
    PROPERTIES
    OUTPUT_NAME adda
    LIBRARY_OUTPUT_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/
)

target_include_directories(adda PRIVATE
    ${addaHeaderList}
)

target_compile_options(adda PRIVATE
    -Werror
    -fPIE
    -Wall
    -fstack-protector-strong
    -fno-common
    -fno-strict-aliasing
)

target_link_options(adda PRIVATE
    -Wl,-z,relro,-z,now,-z,noexecstack
    $<$<STREQUAL:${PRODUCT},ascend920esl>:-Wl,-rpath-link,${CMAKE_BINARY_DIR}/extend_rootfs/lib64>
    $<$<STREQUAL:${PRODUCT},ascend310Besl>:-Wl,-rpath-link,${CMAKE_BINARY_DIR}/extend_rootfs/lib64>
)

target_link_options(adda PRIVATE
    -Wl,-z,relro,-z,now,-z,noexecstack
    $<$<STREQUAL:${PRODUCT},ascend310p>:-Wl,-rpath-link,${CMAKE_BINARY_DIR}/extend_rootfs/lib64>
    $<$<STREQUAL:${PRODUCT},ascend910>:-Wl,-rpath-link,${CMAKE_BINARY_DIR}/extend_rootfs/lib64>
    $<$<STREQUAL:${PRODUCT},ascend910B>:-Wl,-rpath-link,${CMAKE_BINARY_DIR}/extend_rootfs/lib64>
    $<$<STREQUAL:${PRODUCT},ascend310B>:-Wl,-rpath-link,${CMAKE_BINARY_DIR}/extend_rootfs/lib64>
    $<$<STREQUAL:${PRODUCT},ascend310Brc>:-Wl,-rpath-link,${CMAKE_BINARY_DIR}/extend_rootfs/lib64>
    $<$<STREQUAL:${PRODUCT},ascend310Besl>:-Wl,-rpath-link,${CMAKE_BINARY_DIR}/extend_rootfs/lib64>
)

set(localCflags
    -DIDE_DAEMON_DEVICE
    -DOS_TYPE=0
    google=ascend_private
)

set(localSharedLibraries
    c_sec
    ascend_hal_stub
    ascend_protobuf
    unified_dlog
    mmpa
    devprof
    adcore
)

if(PRODUCT)
    if(${PRODUCT} STREQUAL "ascend310rc")
        list(APPEND localCflags -DIDE_DAEMON_RC)
        list(APPEND localSharedLibraries stackcore ascend_monitor)
    elseif(${PRODUCT} STREQUAL "ascend310")
        list(APPEND localCflags -DPLATFORM_MONITOR)
        list(APPEND localSharedLibraries stackcore ascend_monitor)
    elseif(${PRODUCT} STREQUAL "ascend310B")
        list(APPEND localCflags -DIAM)
        list(APPEND localSharedLibraries stackcore iam)
    elseif(${PRODUCT} STREQUAL "ascend310Besl")
        list(APPEND localCflags -DIAM)
        list(APPEND localSharedLibraries stackcore iam)
    elseif(${PRODUCT} STREQUAL "ascend310Bemu")
        list(APPEND localSharedLibraries stackcore ascend_monitor)
        list(APPEND localCflags -DPLATFORM_MONITOR)
    elseif(${PRODUCT} STREQUAL "ascend310Brc")
        list(APPEND localCflags -DPLATFORM_MONITOR)
        list(APPEND localSharedLibraries stackcore ascend_monitor)
        list(APPEND localCflags -DIAM)
        list(APPEND localSharedLibraries iam)
    elseif(${PRODUCT} STREQUAL "ascend310Brcesl")
        list(APPEND localCflags -DPLATFORM_MONITOR)
    elseif(${PRODUCT} STREQUAL "ascend310Brcemu")
        list(APPEND localCflags -DPLATFORM_MONITOR)
        list(APPEND localSharedLibraries stackcore ascend_monitor)
    elseif(${PRODUCT} STREQUAL "ascend310p")
        list(APPEND localCflags -DIAM)
        list(APPEND localSharedLibraries stackcore iam)
    elseif(${PRODUCT} STREQUAL "ascend910")
        list(APPEND localCflags -DUSE_TRUSTED_BASE_PATH -DIAM)
        list(APPEND localSharedLibraries stackcore iam)
    elseif(${PRODUCT} STREQUAL "ascend910B")
        list(APPEND localCflags -DIAM)
        list(APPEND localSharedLibraries stackcore iam)
    endif()
endif()

target_compile_definitions(adda PRIVATE
    $<$<STREQUAL:${PRODUCT_SIDE},device>:ADX_LIB_DEVICE_DRV>
    ${localCflags}
)

target_link_libraries(adda PRIVATE
    $<BUILD_INTERFACE:intf_pub>
    $<BUILD_INTERFACE:mmpa_headers>
    $<BUILD_INTERFACE:adump_headers>
    $<BUILD_INTERFACE:slog_headers>
    $<BUILD_INTERFACE:adcore_headers>
    -Wl,--no-as-needed
    ${localSharedLibraries}
    -Wl,--as-needed
)

install(TARGETS adda OPTIONAL
    LIBRARY DESTINATION ${INSTALL_LIBRARY_DIR}
)

############### cfg and cert files ###################
add_custom_target(AddaCfgCertFiles
    COMMAND ${CMAKE_COMMAND} -E copy ${BASE_DIR}/../devprof/ide_daemon_monitor.sh ${CMAKE_CURRENT_BINARY_DIR}
)

install(FILES
    ${CMAKE_CURRENT_BINARY_DIR}/ide_daemon_monitor.sh
    DESTINATION ${INSTALL_LIBRARY_DIR} OPTIONAL
)