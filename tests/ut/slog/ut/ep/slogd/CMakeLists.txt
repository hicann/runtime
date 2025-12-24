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

set(libSlogdSrc
    ${LOG_SOURCE_PATH}/syslog/slog/slogd_main.c
    ${LOG_SOURCE_PATH}/syslog/slog/slogd_argv.c
    ${LOG_SOURCE_PATH}/syslog/slog/trace_server/slogd_trace_server.c
    ${LOG_SOURCE_PATH}/syslog/slog/log_server/slogd_service.c
    ${LOG_SOURCE_PATH}/syslog/slog/log_server/slogd_dev_mgr.c
    ${LOG_SOURCE_PATH}/syslog/slog/log_server/slogd_thread_mgr.c

    ${LOG_SOURCE_PATH}/syslog/common/log_path_mgr.c
    #${LOG_SOURCE_PATH}/syslog/common/log_print_selflog.c
    ${LOG_SOURCE_PATH}/syslog/common/pm/log_pm.c
    ${LOG_SOURCE_PATH}/syslog/common/pm/log_monitor.c
    ${LOG_SOURCE_PATH}/syslog/common/pm/start_single_process.c
    ${LOG_SOURCE_PATH}/syslog/common/pm/log_pm_sr.c
    ${LOG_SOURCE_PATH}/syslog/common/pm/log_pm_sig.c
    ${LOG_SOURCE_PATH}/syslog/common/config/log_config_list.c
    ${LOG_SOURCE_PATH}/syslog/common/config/log_config_block.c
    ${LOG_SOURCE_PATH}/syslog/common/config/log_config_common.c
    ${LOG_SOURCE_PATH}/syslog/common/config/log_config_api.c
    ${LOG_SOURCE_PATH}/syslog/common/config/log_config_group.c
    ${LOG_SOURCE_PATH}/syslog/common/driver/log_drv.c
    ${LOG_SOURCE_PATH}/syslog/common/driver/driver_api.c

    ${LOG_SOURCE_PATH}/utils/msg_queue.c
    ${LOG_SOURCE_PATH}/utils/log_queue.c
    ${LOG_SOURCE_PATH}/utils/share_mem.c
    ${LOG_SOURCE_PATH}/utils/log_system_api.c
    ${LOG_SOURCE_PATH}/utils/log_common.c
    ${LOG_SOURCE_PATH}/utils/log_compress/log_compress.c
    ${LOG_SOURCE_PATH}/utils/log_compress/log_software_zip.c
    ${LOG_SOURCE_PATH}/utils/log_time.c
    #${LOG_SOURCE_PATH}/utils/log_print_syslog.c
    ${LOG_SOURCE_PATH}/utils/log_file_util.c

    ${LOG_SOURCE_PATH}/syslog/slog/log_server/log_pre_process/log_communication/slogd_communication.c
    ${LOG_SOURCE_PATH}/syslog/slog/log_server/log_pre_process/log_communication/slogd_communication_socket.c
    ${LOG_SOURCE_PATH}/syslog/slog/log_server/log_pre_process/slogd_recv_msg.c
    ${LOG_SOURCE_PATH}/syslog/slog/log_server/log_pre_process/slogd_parse_msg.c
    ${LOG_SOURCE_PATH}/syslog/slog/log_server/log_pre_process/slogd_recv_core.c
    ${LOG_SOURCE_PATH}/syslog/slog/log_server/log_mgr/buffer_mgr/slogd_buffer.c
    ${LOG_SOURCE_PATH}/syslog/slog/log_server/log_post_process/slogd_flush.c
    ${LOG_SOURCE_PATH}/syslog/slog/log_server/log_mgr/file_mgr/slogd_compress.c
    ${LOG_SOURCE_PATH}/syslog/slog/log_server/log_classify/sys_log/slogd_syslog.c
    ${LOG_SOURCE_PATH}/syslog/slog/log_server/log_classify/sys_log/slogd_kernel_log.c
    ${LOG_SOURCE_PATH}/syslog/slog/log_server/log_classify/app_log/slogd_applog_core.c
    ${LOG_SOURCE_PATH}/syslog/slog/log_server/log_classify/app_log/slogd_applog_flush.c
    ${LOG_SOURCE_PATH}/syslog/slog/log_server/log_classify/app_log/slogd_applog_report.c
    ${LOG_SOURCE_PATH}/syslog/slog/log_server/log_classify/app_log/slogd_appnum_watch.c
    ${LOG_SOURCE_PATH}/syslog/slog/log_server/log_classify/event_log/slogd_eventlog.c
    ${LOG_SOURCE_PATH}/syslog/slog/log_server/log_classify/group_log/slogd_group_log.c
    ${LOG_SOURCE_PATH}/syslog/slog/log_server/log_classify/firmware_log/log_recv.c
    ${LOG_SOURCE_PATH}/syslog/slog/log_server/log_classify/firmware_log/log_recv_interface.c
    ${LOG_SOURCE_PATH}/syslog/slog/log_server/log_classify/firmware_log/slogd_firmware_log.c
    ${LOG_SOURCE_PATH}/syslog/slog/log_server/log_mgr/file_mgr/log_to_file.c
    ${LOG_SOURCE_PATH}/syslog/slog/log_server/log_mgr/file_mgr/slogd_write_limit.c
    ${LOG_SOURCE_PATH}/syslog/slog/log_server/log_mgr/level_mgr/operate_loglevel.c
    ${LOG_SOURCE_PATH}/syslog/slog/log_server/log_mgr/level_mgr/slogd_dynamic_level.c
    ${LOG_SOURCE_PATH}/syslog/slog/log_server/log_mgr/level_mgr/slogd_firmware_level.c
    ${LOG_SOURCE_PATH}/syslog/slog/log_server/log_mgr/level_mgr/log_level_parse.c
    ${LOG_SOURCE_PATH}/syslog/slog/log_server/log_mgr/level_mgr/slogd_shm_mgr.c
    ${LOG_SOURCE_PATH}/syslog/slog/log_server/log_mgr/config_mgr/slogd_config_mgr.c

    #log_server.a
    #${LOG_SOURCE_PATH}/syslog/slog/log_server/app_report/log_hdc_server.cpp
    #${LOG_SOURCE_PATH}/syslog/slog/log_server/app_report/log_hdc.cpp
    ${LOG_SOURCE_PATH}/syslog/slog/log_server/log_post_process/session_mgr/log_session_manage.c
    ${LOG_SOURCE_PATH}/syslog/slog/log_server/log_post_process/sys_report/log_sys_report.c
    ${LOG_SOURCE_PATH}/syslog/slog/log_server/log_post_process/sys_get/log_sys_get.c
    ${UT_SOURCE_PATH}/ep/stub/system_api_stub.c
    ${UT_SOURCE_PATH}/ep/slogd/stub/ascend_hal_stub.c
    ${UT_SOURCE_PATH}/ep/slogd/stub/adcore_stub.cc
    ${UT_SOURCE_PATH}/stub/self_log_stub.c
    ${UT_SOURCE_PATH}/stub/ascend_hal_stub.c
    ${CMAKE_CURRENT_SOURCE_DIR}/slogd/stub/trace_server_stub.c
)

set(testSrc
    ${CMAKE_CURRENT_SOURCE_DIR}/log_flush/testcase/log_flush_func_utest.cc
    ${CMAKE_CURRENT_SOURCE_DIR}/log_flush/testcase/log_flush_excp_utest.cc
    ${CMAKE_CURRENT_SOURCE_DIR}/slogd/testcase/thread_mgr_utest.cc
    ${CMAKE_CURRENT_SOURCE_DIR}/slogd/testcase/slogd_flush_utest.cc
    ${CMAKE_CURRENT_SOURCE_DIR}/slogd/testcase/slogd_recv_utest.cc
    ${CMAKE_CURRENT_SOURCE_DIR}/log_level/testcase/log_level_func_utest.cc
    ${CMAKE_CURRENT_SOURCE_DIR}/log_level/stub/log_level_stub.c
    ${CMAKE_CURRENT_SOURCE_DIR}/firmware_log/testcase/firmware_log_func_utest.cc
    ${CMAKE_CURRENT_SOURCE_DIR}/config/testcase/slogd_config_func_utest.cc
    ${CMAKE_CURRENT_SOURCE_DIR}/config/testcase/slogd_config_excp_utest.cc
    ${CMAKE_CURRENT_SOURCE_DIR}/pm/testcase/slogd_pm_func_utest.cc
    ${CMAKE_CURRENT_SOURCE_DIR}/file_mgr/testcase/file_mgr_func_utest.cc
    ${CMAKE_CURRENT_SOURCE_DIR}/file_mgr/testcase/file_mgr_excp_utest.cc
    ${CMAKE_CURRENT_SOURCE_DIR}/log_path/testcase/slogd_log_path_utest.cc
    ${CMAKE_CURRENT_SOURCE_DIR}/session_mgr/testcase/slogd_session_mgr_func_utest.cc
    ${CMAKE_CURRENT_SOURCE_DIR}/msn_report/testcase/slogd_msn_report_func_utest.cc
    ${CMAKE_CURRENT_SOURCE_DIR}/buffer_mgr/testcase/buf_mgr_func_utest.cc
    ${CMAKE_CURRENT_SOURCE_DIR}/buffer_mgr/testcase/buf_mgr_excp_utest.cc
    ${CMAKE_CURRENT_SOURCE_DIR}/slogd/testcase/slogd_func_utest.cc
    ${CMAKE_CURRENT_SOURCE_DIR}/event_log/testcase/event_log_utest.cc
    ${CMAKE_CURRENT_SOURCE_DIR}/sys_log/testcase/sys_log_func_utest.cc
)

set(libSlogdInc
    ${TOP_DIR}/inc/driver
    ${TOP_DIR}/abl/libc_sec/include
    ${TOP_DIR}/abl/adump/external
    ${TOP_DIR}/abl/adump/inc/adump
    ${TOP_DIR}/abl/atrace/inc/trace_server
    ${TOP_DIR}/abl/atrace/inc/utrace
    ${LOG_SOURCE_PATH}/syslog/slog
    ${LOG_SOURCE_PATH}/syslog/slog/log_server
    ${LOG_SOURCE_PATH}/syslog/slog/log_server/log_pre_process
    ${LOG_SOURCE_PATH}/syslog/slog/log_server/log_pre_process/log_communication
    ${LOG_SOURCE_PATH}/syslog/slog/log_server/log_classify/sys_log
    ${LOG_SOURCE_PATH}/syslog/slog/log_server/log_classify/app_log
    ${LOG_SOURCE_PATH}/syslog/slog/log_server/log_classify/event_log
    ${LOG_SOURCE_PATH}/syslog/slog/log_server/log_classify/app_report
    ${LOG_SOURCE_PATH}/syslog/slog/log_server/log_classify/firmware_log
    ${LOG_SOURCE_PATH}/syslog/slog/log_server/log_classify/group_log
    ${LOG_SOURCE_PATH}/syslog/slog/log_server/log_mgr/config_mgr
    ${LOG_SOURCE_PATH}/syslog/slog/log_server/log_mgr/level_mgr
    ${LOG_SOURCE_PATH}/syslog/slog/log_server/log_mgr/file_mgr
    ${LOG_SOURCE_PATH}/syslog/slog/log_server/log_mgr/buffer_mgr
    ${LOG_SOURCE_PATH}/syslog/slog/log_server/log_post_process
    ${LOG_SOURCE_PATH}/syslog/slog/log_server/log_post_process/app_report
    ${LOG_SOURCE_PATH}/syslog/slog/log_server/log_post_process/sys_report
    ${LOG_SOURCE_PATH}/syslog/slog/log_server/log_post_process/sys_get
    ${LOG_SOURCE_PATH}/syslog/slog/log_server/log_post_process/session_mgr
    ${LOG_SOURCE_PATH}/syslog/slog/trace_server
    ${LOG_SOURCE_PATH}/syslog/common
    ${LOG_SOURCE_PATH}/syslog/common/pm
    ${LOG_SOURCE_PATH}/syslog/common/config
    ${LOG_SOURCE_PATH}/syslog/common/driver
    ${LOG_SOURCE_PATH}/shared
    ${LOG_SOURCE_PATH}/utils
    ${LOG_SOURCE_PATH}/utils/log_compress
    ${CMAKE_CURRENT_SOURCE_DIR}/slogd/stub
    ${UT_SOURCE_PATH}/ep/stub
    ${UT_SOURCE_PATH}/ep/slogd/config/stub
    ${UT_SOURCE_PATH}/ep/slogd/log_level/stub
    ${UT_SOURCE_PATH}/ep/slogd/stub
    ${UT_SOURCE_PATH}/stub
)


add_executable(ep_slogd_utest
    ${libSlogdSrc}
    ${testSrc}
)

target_include_directories(ep_slogd_utest PRIVATE
    ${libSlogdInc}
)

target_compile_definitions(ep_slogd_utest PRIVATE
    _LOG_UT_
    __IDE_UT
    SCRIPT_MONITOR
    APP_LOG_REPORT
    EP_MODE
    KERNEL_LOG

    PATH_ROOT="/tmp/ep_slogd_utest_6cEd5299d8d9Be97"
    DEFAULT_LOG_WORKSPACE="/tmp/ep_slogd_utest_6cEd5299d8d9Be97/usr/slog"
    LOG_FILE_PATH="/tmp/ep_slogd_utest_6cEd5299d8d9Be97/var/log/npu/slog"
    SLOG_CONF_FILE_PATH="/tmp/ep_slogd_utest_6cEd5299d8d9Be97/slog.conf"
    KERNEL_LOG_PATH="/tmp/ep_slogd_utest_6cEd5299d8d9Be97/kernel.log"
    CONF_PATH="${CMAKE_CURRENT_SOURCE_DIR}/slog.conf"
    SLOGD_SERVER_USER_NAME="root"
    STATIC_BUFFER
    DRV_EVENT_LOG
    APP_LOG_PID_RECORD
)

target_link_libraries(ep_slogd_utest PRIVATE
    $<BUILD_INTERFACE:intf_llt_pub>
    $<BUILD_INTERFACE:slog_headers>
    c_sec
)

target_compile_options(ep_slogd_utest PRIVATE
    -Werror
)

set_target_properties(ep_slogd_utest
    PROPERTIES
    OUTPUT_NAME toolchain_ep_slogd_utest
    LIBRARY_OUTPUT_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/
)

run_llt_test(
    TARGET ep_slogd_utest
    TASK_NUM 1
)

add_executable(ep_slogd_milan_utest
    ${libSlogdSrc}
    ${CMAKE_CURRENT_SOURCE_DIR}/config/testcase/slogd_config_func_milan_utest.cc
)

target_include_directories(ep_slogd_milan_utest PRIVATE
    ${libSlogdInc}
)

target_compile_definitions(ep_slogd_milan_utest PRIVATE
    _LOG_UT_
    __IDE_UT
    SCRIPT_MONITOR
    APP_LOG_REPORT
    EP_MODE

    PATH_ROOT="/tmp/ep_slogd_utest_g54tersdf43"
    DEFAULT_LOG_WORKSPACE="/tmp/ep_slogd_utest_g54tersdf43/usr/slog"
    LOG_FILE_PATH="/tmp/ep_slogd_utest_g54tersdf43/var/log/npu/slog"
    SLOG_CONF_FILE_PATH="/tmp/ep_slogd_utest_g54tersdf43/slog.conf"
    CONF_PATH="${CMAKE_CURRENT_SOURCE_DIR}/slog.conf"
    SLOGD_SERVER_USER_NAME="root"
    STATIC_BUFFER
    DRIVER_STATIC_BUFFER
)

target_link_libraries(ep_slogd_milan_utest PRIVATE
    $<BUILD_INTERFACE:intf_llt_pub>
    $<BUILD_INTERFACE:slog_headers>
    c_sec
)

target_compile_options(ep_slogd_milan_utest PRIVATE
    -Werror
)

set_target_properties(ep_slogd_milan_utest
    PROPERTIES
    OUTPUT_NAME toolchain_ep_slogd_milan_utest
    LIBRARY_OUTPUT_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/
)

run_llt_test(
    TARGET ep_slogd_milan_utest
    TASK_NUM 1
)

###################################################################
set(INSTALL_BASE_DIR "")
set(INSTALL_INCLUDE_DIR include)
set(INSTALL_LIBRARY_DIR lib)
set(INSTALL_RUNTIME_DIR bin)
set(INSTALL_CONFIG_DIR  lib/cmake)

include(CMakePackageConfigHelpers)

install(TARGETS ep_slogd_utest OPTIONAL
    LIBRARY OPTIONAL DESTINATION ${INSTALL_LIBRARY_DIR}
    ARCHIVE OPTIONAL DESTINATION ${INSTALL_LIBRARY_DIR}
)