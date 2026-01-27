# -----------------------------------------------------------------------------------------------------------
# Copyright (c) 2025 Huawei Technologies Co., Ltd.
# This program is free software, you can redistribute it and/or modify it under the terms and conditions of
# CANN Open Software License Agreement Version 2.0 (the "License").
# Please refer to the License for details. You may not use this file except in compliance with the License.
# THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
# INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
# See LICENSE in the root of the software repository for the full text of the License.
# -----------------------------------------------------------------------------------------------------------
####################### libprofcore.a ###########################
set(basicSrc
    ${PROF_BASIC_DIR}/osal/osal.c
    ${PROF_BASIC_DIR}/osal/osal_linux.c
    ${PROF_BASIC_DIR}/osal/osal_liteos_mem.c
    ${PROF_BASIC_DIR}/osal/osal_thread.c
    basic/json/info_json.c
    basic/json/json_parser.c
    basic/json/json_generator.c
    basic/json/sort_vector.c
    basic/json/vector.c
    basic/json/sample_json.c
    basic/utils/utils.c
    basic/thread/thread_pool.c
    basic/cstl/cstl_list.c
    basic/hal/hal_dsmi.c
    basic/hal/hal_prof.c
    basic/atomic/atomic_liteos.c
)

set(basicInc
    basic/
    ${PROF_BASIC_DIR}
    ${PROF_BASIC_DIR}/osal
    basic/utils
    baisc/thread
    basic/errno
    basic/logger
    basic/cstl
    basic/hal
    basic/json
    basic/atomic
)

set(libcSecSrc
    ${RUNTIME_DIR}/third_party/libc_sec/src/memset_s.c
    ${RUNTIME_DIR}/third_party/libc_sec/src/strcat_s.c
)

set(domainSrc
    domain/platform/platform.c
    domain/platform/platform_interface.c
    domain/platform/platform_table.c
    domain/platform/chip/chip_nano_v1.c
    domain/param/profile_param.c
    domain/transport/uploader.c
    domain/transport/transport.c
    domain/transport/file_transport.c
    domain/transport/flash_transport.c
    domain/collect/report/report_manager.c
    domain/collect/report/hash_dic.c
    domain/collect/report/report_buffer_mgr.c
    domain/collect/report/start_time.c
    domain/collect/task/task_manager.c
    domain/collect/task/task_slot.c
    domain/collect/task/task_pool.c
    domain/collect/channel/channel_manager.c
    domain/collect/channel/channel_reader.c
    domain/collect/job/job_manager.c
    domain/collect/job/collection_job.c
    domain/collect/job/nano_stars_job.c
)

set(domainInc
    domain/
    domain/collect/
    domain/param/
    domain/platform/
    domain/transport/
    domain/collect/channel/
)

set(serviceSrc
    service/api/prof_api.c
    service/impl/service_impl.c
    service/impl/service_task.c
    service/impl/service_param.c
    service/impl/service_report.c
)

set(serviceInc
    service/
    service/impl
)

include(
    liteos_headers.cmake
)

add_library(profcore_static STATIC
    ${basicSrc}
    ${domainSrc}
    ${serviceSrc}
    ${libcSecSrc}
)

target_include_directories(profcore_static PRIVATE
    ${LIBC_SEC_HEADER}
    ${RUNTIME_DIR}/include/driver
    ${RUNTIME_DIR}/tests/ut/msprof/ut/common/stub
    ${RUNTIME_DIR}/tests/ut/msprof/ut/avp/stub
    ${basicInc}
    ${domainInc}
    ${serviceInc}
    $<$<STREQUAL:${TARGET_SYSTEM_NAME},LiteOS>:$<BUILD_INTERFACE:${NANO_LITEOS_HEADERS_PATH}>>
)

set_target_properties(profcore_static
    PROPERTIES
    OUTPUT_NAME profcore
    LIBRARY_OUTPUT_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/
)

target_compile_definitions(profcore_static PRIVATE
    OSAL
    LITE_OS
    __linux
    __LITEOS__
    SECUREC_IN_KERNEL=0
    __LITEOS_ONETRACK__
    _ALL_SOURCE
)

target_compile_options(profcore_static PRIVATE
    -fPIC
    -fstack-protector-all
    -fno-strict-aliasing
    -fno-common
    -Wall
    -Wextra
    -Wfloat-equal
    $<$<AND:$<STREQUAL:${TARGET_SYSTEM_NAME},Windows>,$<STREQUAL:${CMAKE_CONFIGURATION_TYPES},Debug>>:/MTd>
    $<$<AND:$<STREQUAL:${TARGET_SYSTEM_NAME},Windows>,$<STREQUAL:${CMAKE_CONFIGURATION_TYPES},Release>>:/MT>
    ${CMAKE_EXTRA_COMPILE_OPTIONS}
)

target_link_options(profcore_static PRIVATE
    -Wl,-z,relro,-z,now,-z,noexecstack
    -Wl,-Bsymbolic
    -Wl,--gc-sections
    -Wl,--exclude-libs=ALL
)

target_link_libraries(profcore_static PRIVATE
    $<BUILD_INTERFACE:intf_pub>
    $<BUILD_INTERFACE:msprof_headers>
    $<BUILD_INTERFACE:slog_headers>
    -Wl,--no-as-needed
    -Wl,--as-needed
)

install(TARGETS profcore_static OPTIONAL
    LIBRARY DESTINATION ${INSTALL_LIBRARY_DIR}
)
####################### libprofcore.a ###########################

set(PROF_AVP_DIR "${CMAKE_CURRENT_SOURCE_DIR}" PARENT_SCOPE)

####################### libprofimpl_lite.so ###########################
set(BasicImplSrc
    ${PROF_BASIC_DIR}/osal/osal.c
    ${PROF_BASIC_DIR}/osal/osal_linux.c
    ${PROF_BASIC_DIR}/osal/osal_linux_mem.c
    ${PROF_BASIC_DIR}/osal/osal_thread.c
    basic/json/info_json.c
    basic/json/json_parser.c
    basic/json/json_generator.c
    basic/json/sort_vector.c
    basic/json/vector.c
    basic/json/sample_json.c
    basic/utils/utils.c
    basic/thread/thread_pool.c
    basic/cstl/cstl_list.c
    basic/hal/hal_dsmi.c
    basic/hal/hal_prof.c
    basic/atomic/atomic_linux.c
)

set(profimplLiteInc
    ./
    ../dvvp/transport
    ${PROF_BASIC_DIR}
    ${PROF_BASIC_DIR}/osal
    ${basicInc}
    ${domainInc}
    ${serviceInc}
    ${RUNTIME_DIR}/include/driver
    ${LIBC_SEC_HEADER}
    ${CMAKE_CURRENT_SOURCE_DIR}
)

add_library(profimpl_fwk_lite_share SHARED
    ${BasicImplSrc}
    ${domainSrc}
    ${serviceSrc}
)

target_include_directories(profimpl_fwk_lite_share PRIVATE
    ${profimplLiteInc}
)

set_target_properties(profimpl_fwk_lite_share
    PROPERTIES
    OUTPUT_NAME profimpl
    LIBRARY_OUTPUT_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/proflib
)

target_compile_definitions(profimpl_fwk_lite_share PRIVATE
    OSAL
)

target_compile_options(profimpl_fwk_lite_share PRIVATE
    -fPIC
    -fstack-protector-all
    -fno-strict-aliasing
    -fno-common
    -Wall
    -Wextra
    -Wfloat-equal
    -std=gnu11
    $<$<AND:$<STREQUAL:${TARGET_SYSTEM_NAME},Windows>,$<STREQUAL:${CMAKE_CONFIGURATION_TYPES},Debug>>:/MTd>
    $<$<AND:$<STREQUAL:${TARGET_SYSTEM_NAME},Windows>,$<STREQUAL:${CMAKE_CONFIGURATION_TYPES},Release>>:/MT>
)

target_link_options(profimpl_fwk_lite_share PRIVATE
    -Wl,-z,relro,-z,now,-z,noexecstack
    -Wl,-Bsymbolic
    -Wl,--gc-sections
    -Wl,--exclude-libs=ALL
)

target_link_libraries(profimpl_fwk_lite_share PRIVATE
    $<BUILD_INTERFACE:intf_pub>
    $<BUILD_INTERFACE:msprof_headers>
    proftransport_static
    -Wl,--no-as-needed
    c_sec
    -Wl,--as-needed
    $<IF:$<STREQUAL:${PRODUCT_SIDE},host>,alog,slog>
)

install(TARGETS profimpl_fwk_lite_share OPTIONAL
    LIBRARY DESTINATION ${INSTALL_LIBRARY_DIR}/lib
)
####################### libprofimpl_lite.so ###########################

####################### libproftransport.a ###########################
set(proftransportCpp
    ../dvvp/common/utils/utils.cpp
    ../dvvp/common/cmd_log/cmd_log.cpp
    ../dvvp/common/config/closed/config_manager.cpp
    ../dvvp/common/statistics/perf_count.cpp
    ../dvvp/transport/file_ageing.cpp
    ../dvvp/transport/file_ageing_closed.cpp
    ../dvvp/transport/file_slice.cpp
    ../dvvp/transport/file_transport.cpp
    ../dvvp/transport/file_manager.cpp
    ../dvvp/transport/file_interface.cpp
    ../dvvp/driver/devmgmt/ai_drv_dev_api.cpp
    ../dvvp/driver/devmgmt/ai_drv_dev_api_closed.cpp
    ${CppPath}
)

set(proftransportInc
    ../dvvp
    ../dvvp/common
    ../dvvp/common/singleton
    ../dvvp/common/utils
    ../dvvp/common/cmd_log
    ../dvvp/common/config
    ../dvvp/common/config/closed
    ../dvvp/common/logger
    ../dvvp/common/statistics
    ../dvvp/driver/inc
    ../dvvp/transport
    ./
    ${RUNTIME_DIR}/include/driver
    ${CMAKE_CURRENT_SOURCE_DIR}
    ${PROF_BASIC_DIR}
    ${PROF_BASIC_DIR}/osal
)

add_library(proftransport_static STATIC
    ${PROF_BASIC_DIR}/osal/osal.c
    ${PROF_BASIC_DIR}/osal/osal_linux.c
    ${PROF_BASIC_DIR}/osal/osal_linux_mem.c
    ${PROF_BASIC_DIR}/osal/osal_thread.c
    ${proftransportCpp}
    ../dvvp/depend/c_base/msprof_error_manager.cpp
)

target_include_directories(proftransport_static PRIVATE
    ${proftransportInc}
    ${RUNTIME_DIR}/graphengine/inc
    ${RUNTIME_DIR}/graphengine/inc/framework
    ${LIBC_SEC_HEADER}
    ${RUNTIME_DIR}/src/runtime/c/c_base/inc
    ${MSPROF_DIR}/inc/external
    ../dvvp/depend/c_base
)

set_target_properties(proftransport_static
    PROPERTIES
    OUTPUT_NAME proftransport
    LIBRARY_OUTPUT_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/
)

target_compile_definitions(proftransport_static PRIVATE
    OSAL
    $<$<STREQUAL:${CMAKE_BUILD_TYPE},Debug>:MSPROF_DEBUG>
    $<$<STREQUAL:${TARGET_SYSTEM_NAME},Windows>:NOMINMAX>
    $<$<STREQUAL:${TARGET_SYSTEM_NAME},Windows>:WIN32>
)

target_compile_options(proftransport_static PRIVATE
    -fPIC
    -shared
    -fstack-protector-all
    -fno-strict-aliasing
    -fno-common
    -fvisibility=hidden
    -fvisibility-inlines-hidden
    -Os
    -fdata-sections
    -ffunction-sections
    -Wall
    -Wextra
    -Wfloat-equal
    $<$<AND:$<STREQUAL:${TARGET_SYSTEM_NAME},Windows>,$<STREQUAL:${CMAKE_CONFIGURATION_TYPES},Debug>>:/MTd>
    $<$<AND:$<STREQUAL:${TARGET_SYSTEM_NAME},Windows>,$<STREQUAL:${CMAKE_CONFIGURATION_TYPES},Release>>:/MT>
)

target_link_options(proftransport_static PRIVATE
    -Wl,-z,relro,-z,now,-z,noexecstack
    -Wl,-Bsymbolic
    -Wl,--gc-sections
    -Wl,--exclude-libs=ALL
)

target_link_libraries(proftransport_static PRIVATE
    $<BUILD_INTERFACE:intf_pub>
    $<BUILD_INTERFACE:msprof_headers>
    # $<BUILD_INTERFACE:c_base_headers>
    -Wl,--no-as-needed
    c_sec
    -Wl,--as-needed
    $<IF:$<STREQUAL:${PRODUCT_SIDE},host>,alog,slog>
)

install(TARGETS proftransport_static OPTIONAL
    LIBRARY DESTINATION ${INSTALL_LIBRARY_DIR}
)
####################### libproftransport.a ###########################