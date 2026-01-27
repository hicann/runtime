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
    ${LOG_SOURCE_PATH}/utils/log_common.c
    ${LOG_SOURCE_PATH}/utils/library_load.c

    ${CMAKE_CURRENT_SOURCE_DIR}/testcase/alog_func_utest.cc
    ${CMAKE_CURRENT_SOURCE_DIR}/stub/alog_stub.c
    ${UT_SOURCE_PATH}/stub/self_log_stub.c
)

set(libAlogInc
    ${TOP_DIR}/inc/driver
    ${TOP_DIR}/abl/libc_sec/include
    ${LOG_SOURCE_PATH}/liblog/slog
    ${LOG_SOURCE_PATH}/liblog/slog/dlog_communication
    ${LOG_SOURCE_PATH}/utils
    ${CMAKE_CURRENT_SOURCE_DIR}/stub
    ${UT_SOURCE_PATH}/stub
)


add_executable(rc_alog_utest
    ${libAlogSrc}
)

target_include_directories(rc_alog_utest PRIVATE
    ${libAlogInc}
)

target_compile_definitions(rc_alog_utest PRIVATE
    _LOG_UT_
    LOG_CPP
    WRITE_TO_SYSLOG
    PATH_ROOT="/tmp/rc_alog_utest_B4E9752a12F4b5e95"
)

target_link_libraries(rc_alog_utest PRIVATE
    $<BUILD_INTERFACE:intf_llt_pub>
    $<BUILD_INTERFACE:slog_headers>
    $<BUILD_INTERFACE:mmpa_headers>
    mmpa
    c_sec
)

target_compile_options(rc_alog_utest PRIVATE
    -Werror
)

set_target_properties(rc_alog_utest
    PROPERTIES
    OUTPUT_NAME toolchain_rc_alog_utest
    LIBRARY_OUTPUT_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/
)

run_llt_test(
    TARGET rc_alog_utest
    TASK_NUM 1
)

###################################################################
set(INSTALL_BASE_DIR "")
set(INSTALL_INCLUDE_DIR include)
set(INSTALL_LIBRARY_DIR lib)
set(INSTALL_RUNTIME_DIR bin)
set(INSTALL_CONFIG_DIR  lib/cmake)

include(CMakePackageConfigHelpers)

install(TARGETS rc_alog_utest OPTIONAL
    LIBRARY OPTIONAL DESTINATION ${INSTALL_LIBRARY_DIR}
    ARCHIVE OPTIONAL DESTINATION ${INSTALL_LIBRARY_DIR}
)