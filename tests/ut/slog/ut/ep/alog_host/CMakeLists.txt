# -----------------------------------------------------------------------------------------------------------
# Copyright (c) 2025 Huawei Technologies Co., Ltd.
# This program is free software, you can redistribute it and/or modify it under the terms and conditions of
# CANN Open Software License Agreement Version 2.0 (the "License").
# Please refer to the License for details. You may not use this file except in compliance with the License.
# THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
# INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
# See LICENSE in the root of the software repository for the full text of the License.
# -----------------------------------------------------------------------------------------------------------
set(LOG_SOURCE_PATH ${TOP_DIR}/abl/slog)
set(UT_SOURCE_PATH ${TOP_DIR}/llt/abl/slog/ut)

set(libAlogSrc
    ${LOG_SOURCE_PATH}/liblog/slog/alog_to_slog.c
    ${LOG_SOURCE_PATH}/liblog/slog/dlog_core.c
    ${LOG_SOURCE_PATH}/liblog/slog/slog_api.cpp
    ${LOG_SOURCE_PATH}/liblog/slog/dlog_communication/dlog_socket.c
    ${LOG_SOURCE_PATH}/liblog/slog/dlog_communication/dlog_shm_control.c
    ${LOG_SOURCE_PATH}/liblog/slog/dlog_time.c
    ${LOG_SOURCE_PATH}/liblog/slog/dlog_attr.c
    ${LOG_SOURCE_PATH}/liblog/slog/dlog_message.c
    ${LOG_SOURCE_PATH}/liblog/slog/dlog_console.c
    ${LOG_SOURCE_PATH}/liblog/slog/dlog_level_env.c
    ${LOG_SOURCE_PATH}/liblog/slog/dlog_level_mgr.c
    ${LOG_SOURCE_PATH}/utils/log_system_api.c
    ${LOG_SOURCE_PATH}/utils/share_mem.c
    ${LOG_SOURCE_PATH}/utils/log_time.c

    ${LOG_SOURCE_PATH}/liblog/slog/plog/plog_core.c
    ${LOG_SOURCE_PATH}/liblog/slog/plog/plog_device_log.c
    ${LOG_SOURCE_PATH}/liblog/slog/plog/plog_host_log.c
    ${LOG_SOURCE_PATH}/liblog/slog/plog/plog_thread.c
    ${LOG_SOURCE_PATH}/liblog/slog/plog/plog_file_mgr.c
    ${LOG_SOURCE_PATH}/liblog/slog/plog/plog_driver_log.c
    ${LOG_SOURCE_PATH}/liblog/slog/plog/plog_drv.c
    ${LOG_SOURCE_PATH}/liblog/slog/plog/plog_driver_api.c
    ${LOG_SOURCE_PATH}/liblog/slog/plog/plog_buffer_mgr.c
    ${LOG_SOURCE_PATH}/liblog/slog/plog/plog_api.cpp
    ${LOG_SOURCE_PATH}/utils/library_load.c
    ${LOG_SOURCE_PATH}/utils/log_common.c
    ${LOG_SOURCE_PATH}/utils/log_file_util.c

    ${CMAKE_CURRENT_SOURCE_DIR}/testcase/alog_host_excp_utest.cc
    ${CMAKE_CURRENT_SOURCE_DIR}/testcase/alog_host_func_utest.cc
    ${CMAKE_CURRENT_SOURCE_DIR}/testcase/alog_host_perf_utest.cc
    ${CMAKE_CURRENT_SOURCE_DIR}/testcase/plog_buffer_utest.cc
    ${CMAKE_CURRENT_SOURCE_DIR}/testcase/plog_host_log_utest.cc
    ${CMAKE_CURRENT_SOURCE_DIR}/stub/ascend_hal_stub.c
    ${CMAKE_CURRENT_SOURCE_DIR}/stub/plog_stub.cc
    ${UT_SOURCE_PATH}/ep/stub/system_api_stub.c
    ${UT_SOURCE_PATH}/stub/self_log_stub.c
)

set(libAlogInc
    ${TOP_DIR}/abl/libc_sec/include
    ${TOP_DIR}/inc/driver
    ${TOP_DIR}/abl/adump/inc/adump
    ${LOG_SOURCE_PATH}/liblog/slog
    ${LOG_SOURCE_PATH}/liblog/slog/plog
    ${LOG_SOURCE_PATH}/liblog/slog/dlog_communication
    ${LOG_SOURCE_PATH}/shared
    ${LOG_SOURCE_PATH}/utils
    ${CMAKE_CURRENT_SOURCE_DIR}/stub
    ${UT_SOURCE_PATH}/ep/stub
    ${UT_SOURCE_PATH}/stub
)


add_executable(ep_alog_host_utest
    ${libAlogSrc}
)

target_include_directories(ep_alog_host_utest PRIVATE
    ${libAlogInc}
)

target_compile_definitions(ep_alog_host_utest PRIVATE
    _LOG_UT_
    LOG_CPP
    WRITE_TO_SYSLOG
    PATH_ROOT="/tmp/log_libalog_C12Jbi3o9LBsd72"
    HAL_REGISTER_ALOG
    PROCESS_LOG
    LLT_DEBUG
)

target_link_libraries(ep_alog_host_utest PRIVATE
    $<BUILD_INTERFACE:intf_llt_pub>
    $<BUILD_INTERFACE:slog_headers>
    $<BUILD_INTERFACE:mmpa_headers>
    mmpa
    c_sec
)

target_compile_options(ep_alog_host_utest PRIVATE
    -Werror
)

set_target_properties(ep_alog_host_utest
    PROPERTIES
    OUTPUT_NAME toolchain_ep_alog_host_utest
    LIBRARY_OUTPUT_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/
)

run_llt_test(
    TARGET ep_alog_host_utest
    TASK_NUM 1
)

###################################################################
set(INSTALL_BASE_DIR "")
set(INSTALL_INCLUDE_DIR include)
set(INSTALL_LIBRARY_DIR lib)
set(INSTALL_RUNTIME_DIR bin)
set(INSTALL_CONFIG_DIR  lib/cmake)

include(CMakePackageConfigHelpers)

install(TARGETS ep_alog_host_utest OPTIONAL
    LIBRARY OPTIONAL DESTINATION ${INSTALL_LIBRARY_DIR}
    ARCHIVE OPTIONAL DESTINATION ${INSTALL_LIBRARY_DIR}
)