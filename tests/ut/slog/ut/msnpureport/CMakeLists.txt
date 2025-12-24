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
set(ADX_SOURCE_PATH ${TOP_DIR}/abl/adump)

###################################################################
set(msnpureportSrc
    ${LOG_SOURCE_PATH}/syslog/msnpureport/msnpureport.c
    ${LOG_SOURCE_PATH}/syslog/msnpureport/utils/msnpureport_print.c
    ${LOG_SOURCE_PATH}/syslog/msnpureport/utils/msnpureport_utils.c
    ${LOG_SOURCE_PATH}/syslog/msnpureport/config/msnpureport_level.c
    ${LOG_SOURCE_PATH}/syslog/msnpureport/config/msnpureport_config.c
    ${LOG_SOURCE_PATH}/syslog/msnpureport/config/msn_operate_log_level.c
    ${LOG_SOURCE_PATH}/syslog/msnpureport/options/msnpureport_options_old.c
    ${LOG_SOURCE_PATH}/syslog/msnpureport/options/msnpureport_options.c
    ${LOG_SOURCE_PATH}/syslog/msnpureport/report/msnpureport_report.c
    ${LOG_SOURCE_PATH}/syslog/msnpureport/report/msnpureport_file_mgr.c
    ${LOG_SOURCE_PATH}/utils/log_system_api.c
    ${LOG_SOURCE_PATH}/utils/log_common.c
    ${CMAKE_CURRENT_SOURCE_DIR}/test/main.cc
    ${CMAKE_CURRENT_SOURCE_DIR}/test/msnpureport_main.cc
    ${CMAKE_CURRENT_SOURCE_DIR}/test/msnpureport_test.cc
    ${CMAKE_CURRENT_SOURCE_DIR}/test/msn_operate_log_level_utest.cc
    ${CMAKE_CURRENT_SOURCE_DIR}/stub/msnpureport_stub.c

)

set(msnpureportInc
    ${TOP_DIR}/inc/driver
    ${TOP_DIR}/abl/libc_sec/include
    ${TOP_DIR}/abl/adump/inc/adump
    ${TOP_DIR}/abl/adump/external
    ${LOG_SOURCE_PATH}/syslog/msnpureport/
    ${LOG_SOURCE_PATH}/syslog/msnpureport/utils
    ${LOG_SOURCE_PATH}/syslog/msnpureport/config
    ${LOG_SOURCE_PATH}/syslog/msnpureport/options
    ${LOG_SOURCE_PATH}/syslog/msnpureport/report
    ${ADX_SOURCE_PATH}/external
    ${CMAKE_CURRENT_SOURCE_DIR}/stub
    ${TOP_DIR}/abl/slog/shared
    ${TOP_DIR}/abl/slog/utils
    ${TOP_DIR}/abl/slog/inc/msnpureport
)

add_executable(msnpureport_utest
    ${msnpureportSrc}
)

target_include_directories(msnpureport_utest PRIVATE
    ${msnpureportInc}
)

target_compile_definitions(msnpureport_utest PRIVATE
    _LOG_UT_
    PERMANENT_EXPORT
    PATH_ROOT="/tmp/msnpureport_ut_UHD89ydwhq"
)

target_link_libraries(msnpureport_utest PRIVATE
    $<BUILD_INTERFACE:intf_llt_pub>
    $<BUILD_INTERFACE:mmpa_headers>
    $<BUILD_INTERFACE:slog_headers>
    c_sec
    mmpa
    -Wl,-rpath,${TOP_DIR}/output/llt/c_sec/lib
    -Wl,-rpath,${CMAKE_CURRENT_BINARY_DIR}/../../../../../../../../llt_gcc4.9.3-prefix/src/llt_gcc4.9.3-build/abl/mmpa
)

target_compile_options(msnpureport_utest PRIVATE
    -Werror
)

set_target_properties(msnpureport_utest
    PROPERTIES
    OUTPUT_NAME msnpureport_utest
    LIBRARY_OUTPUT_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/
)

run_llt_test(
    TARGET msnpureport_utest
    TASK_NUM 1
)

###################################################################
set(INSTALL_BASE_DIR "")
set(INSTALL_INCLUDE_DIR include)
set(INSTALL_LIBRARY_DIR lib)
set(INSTALL_RUNTIME_DIR bin)
set(INSTALL_CONFIG_DIR  lib/cmake)

include(CMakePackageConfigHelpers)

install(TARGETS msnpureport_utest OPTIONAL
    LIBRARY OPTIONAL DESTINATION ${INSTALL_LIBRARY_DIR}
    ARCHIVE OPTIONAL DESTINATION ${INSTALL_LIBRARY_DIR}
)
