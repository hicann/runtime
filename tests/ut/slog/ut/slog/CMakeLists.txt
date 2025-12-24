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
set(slogSrc
    ${LOG_SOURCE_PATH}/liblog/slog/alog_to_slog.c
    ${LOG_SOURCE_PATH}/liblog/slog/slog_api.cpp
    ${LOG_SOURCE_PATH}/liblog/slog/dlog_core.c
    ${LOG_SOURCE_PATH}/liblog/slog/dlog_message.c
    ${LOG_SOURCE_PATH}/liblog/slog/dlog_console.c
    ${LOG_SOURCE_PATH}/liblog/slog/dlog_time.c
    ${LOG_SOURCE_PATH}/liblog/slog/dlog_communication/dlog_socket.c
    ${LOG_SOURCE_PATH}/liblog/slog/dlog_communication/dlog_shm_control.c
    ${LOG_SOURCE_PATH}/liblog/slog/dlog_attr.c
    ${LOG_SOURCE_PATH}/liblog/slog/dlog_level_shm.c
    ${LOG_SOURCE_PATH}/liblog/slog/dlog_level_mgr.c
    ${LOG_SOURCE_PATH}/liblog/slog/dlog_level_env.c
    ${LOG_SOURCE_PATH}/syslog/sklog/klogd.c
    ${LOG_SOURCE_PATH}/syslog/slog/log_server/log_mgr/level_mgr/operate_loglevel.c
    ${LOG_SOURCE_PATH}/syslog/slog/log_server/log_mgr/level_mgr/slogd_dynamic_level.c
    ${LOG_SOURCE_PATH}/syslog/slog/log_server/log_mgr/level_mgr/slogd_firmware_level.c
    ${LOG_SOURCE_PATH}/syslog/slog/log_server/log_mgr/level_mgr/log_level_parse.c
    ${LOG_SOURCE_PATH}/syslog/slog/log_server/log_mgr/config_mgr/slogd_config_mgr.c
    ${LOG_SOURCE_PATH}/syslog/slog/log_server/log_pre_process/slogd_recv_core.c
    ${LOG_SOURCE_PATH}/syslog/slog/log_server/log_pre_process/slogd_parse_msg.c
    ${LOG_SOURCE_PATH}/syslog/slog/log_server/log_pre_process/slogd_recv_msg.c
    ${LOG_SOURCE_PATH}/syslog/slog/log_server/log_pre_process/log_communication/slogd_communication.c
    ${LOG_SOURCE_PATH}/syslog/slog/log_server/log_pre_process/log_communication/slogd_communication_socket.c
    ${LOG_SOURCE_PATH}/syslog/slog/log_server/log_post_process/slogd_flush.c
    ${LOG_SOURCE_PATH}/syslog/slog/log_server/log_mgr/buffer_mgr/slogd_buffer.c
    ${LOG_SOURCE_PATH}/syslog/slog/log_server/log_pre_process/cmd_process/slogd_collect_log.c
    ${LOG_SOURCE_PATH}/syslog/slog/log_server/log_mgr/file_mgr/slogd_compress.c
    ${LOG_SOURCE_PATH}/syslog/slog/log_server/log_classify/sys_log/slogd_syslog.c
    ${LOG_SOURCE_PATH}/syslog/slog/log_server/log_classify/sys_log/slogd_kernel_log.c
    ${LOG_SOURCE_PATH}/syslog/slog/log_server/log_classify/app_log/slogd_applog_core.c
    ${LOG_SOURCE_PATH}/syslog/slog/log_server/log_classify/app_log/slogd_applog_flush.c
    ${LOG_SOURCE_PATH}/syslog/slog/log_server/log_classify/app_log/slogd_appnum_watch.c
    ${LOG_SOURCE_PATH}/syslog/slog/slogd_main.c
    ${LOG_SOURCE_PATH}/syslog/slog/slogd_argv.c
    ${LOG_SOURCE_PATH}/syslog/slog/trace_server/slogd_trace_server.c
    ${LOG_SOURCE_PATH}/syslog/slog/log_server/log_classify/app_log/slogd_applog_report.c
    ${LOG_SOURCE_PATH}/syslog/slog/log_server/log_classify/app_log/slogd_appnum_watch.c
    ${LOG_SOURCE_PATH}/syslog/slog/log_server/log_classify/event_log/slogd_eventlog.c
    ${LOG_SOURCE_PATH}/syslog/slog/log_server/log_mgr/level_mgr/slogd_shm_mgr.c
    ${LOG_SOURCE_PATH}/syslog/slog/log_server/log_post_process/session_mgr/log_session_manage.c
    ${LOG_SOURCE_PATH}/syslog/slog/log_server/slogd_service.c
    ${LOG_SOURCE_PATH}/syslog/slog/log_server/slogd_dev_mgr.c
    ${LOG_SOURCE_PATH}/syslog/slog/log_server/slogd_thread_mgr.c
    ${LOG_SOURCE_PATH}/syslog/slog/log_server/log_classify/firmware_log/slogd_firmware_log.c
    ${LOG_SOURCE_PATH}/syslog/slog/log_server/log_classify/firmware_log/log_recv.c
    ${LOG_SOURCE_PATH}/syslog/slog/log_server/log_classify/firmware_log/log_recv_interface.c
    ${LOG_SOURCE_PATH}/syslog/slog/log_server/log_post_process/session_mgr/log_hdc_server.cpp
    ${LOG_SOURCE_PATH}/syslog/slog/log_server/log_post_process/sys_get/log_sys_get.c
    ${LOG_SOURCE_PATH}/syslog/slog/log_server/log_post_process/sys_report/log_sys_report.c
    ${LOG_SOURCE_PATH}/syslog/slog/log_server/log_post_process/app_report/log_hdc.cpp
    ${LOG_SOURCE_PATH}/syslog/slog/log_server/log_classify/group_log/slogd_group_log.c
    ${LOG_SOURCE_PATH}/syslog/slog/log_server/log_mgr/file_mgr/log_to_file.c
    ${LOG_SOURCE_PATH}/syslog/slog/log_server/log_mgr/file_mgr/slogd_write_limit.c
    ${LOG_SOURCE_PATH}/syslog/common/pm/log_pm_sig.c
    ${LOG_SOURCE_PATH}/syslog/common/log_path_mgr.c
    ${LOG_SOURCE_PATH}/syslog/common/log_print_selflog.c
    ${LOG_SOURCE_PATH}/syslog/common/driver/log_drv.c
    ${LOG_SOURCE_PATH}/syslog/common/driver/driver_api.c
    ${LOG_SOURCE_PATH}/syslog/common/pm/log_pm.c
    ${LOG_SOURCE_PATH}/syslog/common/pm/log_monitor.c
    ${LOG_SOURCE_PATH}/syslog/common/pm/log_pm_sr.c
    ${LOG_SOURCE_PATH}/syslog/common/config/log_config_list.c
    ${LOG_SOURCE_PATH}/syslog/common/config/log_config_block.c
    ${LOG_SOURCE_PATH}/syslog/common/config/log_config_common.c
    ${LOG_SOURCE_PATH}/syslog/common/config/log_config_api.c
    ${LOG_SOURCE_PATH}/syslog/common/config/log_config_group.c
    ${LOG_SOURCE_PATH}/utils/msg_queue.c
    ${LOG_SOURCE_PATH}/utils/log_queue.c
    ${LOG_SOURCE_PATH}/utils/log_compress/log_compress.c
    ${LOG_SOURCE_PATH}/utils/share_mem.c
    ${LOG_SOURCE_PATH}/utils/log_common.c
    ${LOG_SOURCE_PATH}/utils/log_buffer/log_ring_buffer.c
    ${LOG_SOURCE_PATH}/utils/log_time.c
    ${LOG_SOURCE_PATH}/utils/log_file_util.c
    ${LOG_SOURCE_PATH}/utils/log_print_syslog.c
    ${LOG_SOURCE_PATH}/utils/library_load.c
    ${CMAKE_CURRENT_SOURCE_DIR}/../stub/ascend_hal_stub.c
    ${CMAKE_CURRENT_SOURCE_DIR}/testcase/main.cc
    ${CMAKE_CURRENT_SOURCE_DIR}/stub/slogd_utest_stub.c
    ${CMAKE_CURRENT_SOURCE_DIR}/stub/adx_comm_opt_manager_stub.cc
    ${CMAKE_CURRENT_SOURCE_DIR}/testcase/slogd_main_ut.cc
    ${CMAKE_CURRENT_SOURCE_DIR}/testcase/slogd_share_mem_unittest.cc
    ${CMAKE_CURRENT_SOURCE_DIR}/testcase/slogd_log_monitor_unittest.cc
    ${CMAKE_CURRENT_SOURCE_DIR}/testcase/slogd_msg_queue_unittest.cc
    ${CMAKE_CURRENT_SOURCE_DIR}/testcase/slogd_sklogd_unittest.cc
    ${CMAKE_CURRENT_SOURCE_DIR}/testcase/slogd_log_common_util.cc
    ${CMAKE_CURRENT_SOURCE_DIR}/testcase/slogd_set_loglevel_unittest.cc
    ${CMAKE_CURRENT_SOURCE_DIR}/testcase/slogd_common_unittest.cc
    ${CMAKE_CURRENT_SOURCE_DIR}/testcase/slogd_log_to_file_unittest.cc
    ${CMAKE_CURRENT_SOURCE_DIR}/testcase/slogd_syslogd_unittest.cc
    ${CMAKE_CURRENT_SOURCE_DIR}/testcase/slogd_slog_unittest.cc
    ${CMAKE_CURRENT_SOURCE_DIR}/testcase/slogd_app_log_watch_unittest.cc
    ${CMAKE_CURRENT_SOURCE_DIR}/testcase/slogd_log_session_manage_unittest.cc
    # ${CMAKE_CURRENT_SOURCE_DIR}/testcase/log_group_ut.cc
    ${CMAKE_CURRENT_SOURCE_DIR}/testcase/log_buffer_utest.cc
    ${CMAKE_CURRENT_SOURCE_DIR}/testcase/log_hdc_server_ut.cc
    ${CMAKE_CURRENT_SOURCE_DIR}/testcase/log_hdc_ut.cc
)

set(slogInc
    ${TOP_DIR}/inc/driver
    ${TOP_DIR}/abl/libc_sec/include
    ${LOG_SOURCE_PATH}/inc/stackcore
    ${LOG_SOURCE_PATH}/shared
    ${LOG_SOURCE_PATH}/utils
    ${LOG_SOURCE_PATH}/utils/log_compress
    ${LOG_SOURCE_PATH}/syslog/slog
    ${LOG_SOURCE_PATH}/syslog/slog/log_server
    ${LOG_SOURCE_PATH}/syslog/slog/log_server/log_server
    ${LOG_SOURCE_PATH}/syslog/slog/log_server/log_classify/app_log
    ${LOG_SOURCE_PATH}/syslog/slog/log_server/log_classify/event_log
    ${LOG_SOURCE_PATH}/syslog/slog/log_server/log_mgr/file_mgr
    ${LOG_SOURCE_PATH}/syslog/slog/log_server/log_mgr/level_mgr
    ${LOG_SOURCE_PATH}/syslog/slog/log_server/log_classify/firmware_log
    ${LOG_SOURCE_PATH}/syslog/slog/log_server/log_mgr/config_mgr
    ${LOG_SOURCE_PATH}/syslog/slog/log_server/log_mgr/buffer_mgr
    ${LOG_SOURCE_PATH}/syslog/slog/log_server/log_classify/group_log
    ${LOG_SOURCE_PATH}/syslog/slog/log_server/log_classify/sys_log
    ${LOG_SOURCE_PATH}/syslog/slog/log_server/log_post_process/app_report
    ${LOG_SOURCE_PATH}/syslog/slog/log_server/log_post_process/sys_report
    ${LOG_SOURCE_PATH}/syslog/slog/log_server/log_post_process/sys_get
    ${LOG_SOURCE_PATH}/syslog/slog/log_server/log_post_process/session_mgr
    ${LOG_SOURCE_PATH}/syslog/slog/log_server/log_post_process
    ${LOG_SOURCE_PATH}/syslog/slog/log_server/log_mgr
    ${LOG_SOURCE_PATH}/syslog/slog/log_server/log_pre_process
    ${LOG_SOURCE_PATH}/syslog/slog/log_server/log_pre_process/cmd_process
    ${LOG_SOURCE_PATH}/syslog/slog/log_server/log_pre_process/log_communication
    ${LOG_SOURCE_PATH}/syslog/slog/trace_server
    ${LOG_SOURCE_PATH}/syslog/sklog
    ${LOG_SOURCE_PATH}/syslog/common
    ${LOG_SOURCE_PATH}/syslog/common/driver
    ${LOG_SOURCE_PATH}/syslog/common/pm
    ${LOG_SOURCE_PATH}/syslog/common/config
    ${LOG_SOURCE_PATH}/liblog/slog
    ${LOG_SOURCE_PATH}/liblog/slog/dlog_communication
    ${LOG_SOURCE_PATH}/utils/log_buffer/
    ${CMAKE_CURRENT_SOURCE_DIR}/stub
    ${TOP_DIR}/abl/adump/external
    ${TOP_DIR}/abl/adump/adcore
    ${TOP_DIR}/abl/adump/adcore/commopts
    ${TOP_DIR}/abl/adump/adcore/component
    ${TOP_DIR}/abl/adump/adcore/common
    ${TOP_DIR}/abl/adump/adcore/protocol
    ${TOP_DIR}/abl/adump/adcore/hdc
)

add_executable(log_slogd_utest
    ${slogSrc}
)

target_include_directories(log_slogd_utest PRIVATE
    ${slogInc}
)

target_compile_definitions(log_slogd_utest PRIVATE
    __IDE_UT
    _LOG_UT_
    COMMON_BUFSIZE=20
    OS_TYPE=0
    _DEV_1910_
    _SLOG_DEVICE_
    SCRIPT_MONITOR
    LOG_COREDUMP_HDCPATH
    APP_LOG_REPORT
    APP_LOG_WATCH
    SORTED_LOG
)

target_link_libraries(log_slogd_utest PRIVATE
    $<BUILD_INTERFACE:intf_llt_pub>
    $<BUILD_INTERFACE:mmpa_headers>
    $<BUILD_INTERFACE:slog_headers>
    $<BUILD_INTERFACE:adump_headers>
    mmpa
    c_sec
    -Wl,-rpath,${TOP_DIR}/output/llt/c_sec/lib
)

target_compile_options(log_slogd_utest PRIVATE
    -Werror
)

set_target_properties(log_slogd_utest
    PROPERTIES
    OUTPUT_NAME toolchain_log_slogd_ut
    LIBRARY_OUTPUT_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/
)

run_llt_test(
    TARGET log_slogd_utest
    TASK_NUM 1
)

###################################################################
set(INSTALL_BASE_DIR "")
set(INSTALL_INCLUDE_DIR include)
set(INSTALL_LIBRARY_DIR lib)
set(INSTALL_RUNTIME_DIR bin)
set(INSTALL_CONFIG_DIR  lib/cmake)

include(CMakePackageConfigHelpers)

install(TARGETS log_slogd_utest OPTIONAL
    LIBRARY OPTIONAL DESTINATION ${INSTALL_LIBRARY_DIR}
    ARCHIVE OPTIONAL DESTINATION ${INSTALL_LIBRARY_DIR}
)
