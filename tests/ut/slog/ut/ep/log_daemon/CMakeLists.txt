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

set(logDaemonSrc
    ${LOG_SOURCE_PATH}/syslog/log_daemon/log_daemon.c
    ${LOG_SOURCE_PATH}/syslog/log_daemon/log_daemon_server.c
    ${LOG_SOURCE_PATH}/syslog/log_daemon/config_cmd/msn_config.c
    ${LOG_SOURCE_PATH}/syslog/log_daemon/config_cmd/log_cmd.c
    ${LOG_SOURCE_PATH}/syslog/log_daemon/config_cmd/ts_cmd.c
    ${LOG_SOURCE_PATH}/syslog/log_daemon/event_process/event_process_core.c
    ${LOG_SOURCE_PATH}/syslog/log_daemon/file_monitor/file_monitor_core.c
    ${LOG_SOURCE_PATH}/syslog/log_daemon/file_monitor/file_monitor_common.c
    ${LOG_SOURCE_PATH}/syslog/log_daemon/file_monitor/file_bbox_monitor.c
    ${LOG_SOURCE_PATH}/syslog/log_daemon/file_monitor/stackcore_file_monitor.c
    ${LOG_SOURCE_PATH}/syslog/log_daemon/file_monitor/file_slogdlog_monitor.c
    ${LOG_SOURCE_PATH}/syslog/log_daemon/file_monitor/file_device_app_monitor.c
    ${LOG_SOURCE_PATH}/syslog/log_daemon/server_mgr/server_mgr.c
    # ${LOG_SOURCE_PATH}/syslog/log_daemon/file_dump/log_get_file.cpp
    ${LOG_SOURCE_PATH}/syslog/common/pm/log_pm.c
    ${LOG_SOURCE_PATH}/syslog/common/pm/log_monitor.c
    ${LOG_SOURCE_PATH}/syslog/common/pm/start_single_process.c
    ${LOG_SOURCE_PATH}/syslog/common/pm/log_pm_sr.c
    ${LOG_SOURCE_PATH}/syslog/common/pm/log_pm_sig.c
    ${LOG_SOURCE_PATH}/syslog/common/log_path_mgr.c
    #${LOG_SOURCE_PATH}/syslog/common/log_print_selflog.c
    ${LOG_SOURCE_PATH}/syslog/common/driver/log_drv.c
    ${LOG_SOURCE_PATH}/syslog/common/driver/driver_api.c
    ${LOG_SOURCE_PATH}/syslog/common/config/log_config_list.c
    ${LOG_SOURCE_PATH}/syslog/common/config/log_config_block.c
    ${LOG_SOURCE_PATH}/syslog/common/config/log_config_common.c
    ${LOG_SOURCE_PATH}/syslog/common/config/log_config_api.c
    #${LOG_SOURCE_PATH}/utils/log_print_syslog.c
    ${LOG_SOURCE_PATH}/utils/log_file_util.c
    ${LOG_SOURCE_PATH}/utils/log_system_api.c
    ${LOG_SOURCE_PATH}/utils/log_common.c
    ${LOG_SOURCE_PATH}/utils/log_time.c
    ${LOG_SOURCE_PATH}/utils/msg_queue.c
    ${LOG_SOURCE_PATH}/utils/library_load.c

    ${CMAKE_CURRENT_SOURCE_DIR}/stub/log_daemon_stub.c
    ${UT_SOURCE_PATH}/stub/self_log_stub.c
    ${UT_SOURCE_PATH}/stub/ascend_hal_stub.c

    # file_dump
    ${LOG_SOURCE_PATH}/syslog/log_daemon/file_dump/
    ${CMAKE_CURRENT_SOURCE_DIR}/testcase/file_dump/file_dump_func_utest.cc
    ${CMAKE_CURRENT_SOURCE_DIR}/testcase/file_dump/file_dump_excp_utest.cc
    ${CMAKE_CURRENT_SOURCE_DIR}/testcase/log_daemon_func_utest.cc
    # config_cmd
    ${CMAKE_CURRENT_SOURCE_DIR}/testcase/config_cmd/log_cmd.cc
    # sys_monitor
    ${CMAKE_CURRENT_SOURCE_DIR}/testcase/sys_monitor/sys_monitor_func_utest.cc
    ${CMAKE_CURRENT_SOURCE_DIR}/testcase/sys_monitor/sys_monitor_excp_utest.cc
    ${LOG_SOURCE_PATH}/syslog/log_daemon/sys_monitor/sys_monitor_frame.c
    ${LOG_SOURCE_PATH}/syslog/log_daemon/sys_monitor/sys_cpu_monitor.c
    ${LOG_SOURCE_PATH}/syslog/log_daemon/sys_monitor/sys_memory_monitor.c
    ${LOG_SOURCE_PATH}/syslog/log_daemon/sys_monitor/sys_fd_monitor.c
    ${LOG_SOURCE_PATH}/syslog/log_daemon/sys_monitor/sys_zp_monitor.c
    # hbm-detect
    ${CMAKE_CURRENT_SOURCE_DIR}/testcase/hbm_detect/hbm_detect_func_utest.cc
    ${CMAKE_CURRENT_SOURCE_DIR}/testcase/hbm_detect/hbm_detect_excp_utest.cc
    ${LOG_SOURCE_PATH}/syslog/log_daemon/hbm_detect/hbm_detect.c
    #server-mgr
    ${LOG_SOURCE_PATH}/syslog/log_daemon/server_mgr/server_mgr.c
    # cpu-detect
    ${CMAKE_CURRENT_SOURCE_DIR}/testcase/cpu_detect/cpu_detect_utest.cc
    ${LOG_SOURCE_PATH}/syslog/log_daemon/cpu_detect/cpu_detect.c
    # event process
    ${CMAKE_CURRENT_SOURCE_DIR}/testcase/event_process/event_process_func_utest.cc
    # file monitor
    ${CMAKE_CURRENT_SOURCE_DIR}/testcase/file_monitor/file_monitor_func_utest.cc
    # library load
    ${LOG_SOURCE_PATH}/syslog/log_daemon/lib_load/lib_load.c
    ${CMAKE_CURRENT_SOURCE_DIR}/testcase/lib_load/lib_load_utest.cc
)

set(logDaemonInc
    ${TOP_DIR}/inc/driver
    ${TOP_DIR}/abl/adump/external
    ${TOP_DIR}/abl/adump/inc/adump
    ${TOP_DIR}/abl/libc_sec/include
    ${TOP_DIR}/ace/csruntime/inc/tsch
    ${LOG_SOURCE_PATH}/shared
    ${LOG_SOURCE_PATH}/utils
    ${LOG_SOURCE_PATH}/syslog/common
    ${LOG_SOURCE_PATH}/syslog/common/pm
    ${LOG_SOURCE_PATH}/syslog/common/config
    ${LOG_SOURCE_PATH}/syslog/common/driver
    ${LOG_SOURCE_PATH}/syslog/log_daemon
    ${LOG_SOURCE_PATH}/syslog/log_daemon/file_dump
    ${LOG_SOURCE_PATH}/syslog/log_daemon/sys_monitor
    ${LOG_SOURCE_PATH}/syslog/log_daemon/hbm_detect
    ${LOG_SOURCE_PATH}/syslog/log_daemon/config_cmd
    ${LOG_SOURCE_PATH}/syslog/log_daemon/stackcore
    ${LOG_SOURCE_PATH}/syslog/log_daemon/event_process
    ${LOG_SOURCE_PATH}/syslog/log_daemon/file_monitor
    ${LOG_SOURCE_PATH}/syslog/log_daemon/server_mgr
    ${LOG_SOURCE_PATH}/syslog/log_daemon/include
    ${LOG_SOURCE_PATH}/syslog/log_daemon/cpu_detect
    ${LOG_SOURCE_PATH}/syslog/log_daemon/lib_load
    ${LOG_SOURCE_PATH}/syslog/msnpureport
    ${UT_SOURCE_PATH}/stub
    ${UT_SOURCE_PATH}/ep/stub
    ${CMAKE_CURRENT_SOURCE_DIR}/stub
)

add_executable(ep_log_daemon_utest
    ${logDaemonSrc}
)

target_include_directories(ep_log_daemon_utest PRIVATE
    ${logDaemonInc}
)

target_compile_definitions(ep_log_daemon_utest PRIVATE
    __IDE_UT
    _LOG_UT_
    LOG_COREDUMP
    EP_MODE
    PATH_ROOT="/tmp/ep_log_daemon_utest_Df08d882dACa4"
    BBOX_DIR_MONITOR="/tmp/ep_log_daemon_utest_Df08d882dACa4/hisi_logs/"
    CORE_DEFAULT_PATH="/tmp/ep_log_daemon_utest_Df08d882dACa4/coredump/"
    SLOGDLOG_FILE_PATH="/tmp/ep_log_daemon_utest_Df08d882dACa4/slog/slogd/slogdlog"
    SLOGDLOG_OLD_FILE_PATH="/tmp/ep_log_daemon_utest_Df08d882dACa4/slog/slogd/slogdlog.old"
    SLOG_PATH="/tmp/ep_log_daemon_utest_Df08d882dACa4/slog"
    LLT_DEBUG
    CONFIG_EXPAND
)

target_link_libraries(ep_log_daemon_utest PRIVATE
    $<BUILD_INTERFACE:intf_llt_pub>
    $<BUILD_INTERFACE:slog_headers>
    $<BUILD_INTERFACE:mmpa_headers>
    mmpa
    c_sec
    -ldl
)

target_compile_options(ep_log_daemon_utest PRIVATE
    -Werror
)

set_target_properties(ep_log_daemon_utest
    PROPERTIES
    OUTPUT_NAME toolchain_ep_log_daemon_utest
    LIBRARY_OUTPUT_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/
)

run_llt_test(
    TARGET ep_log_daemon_utest
    TASK_NUM 1
)

###################################################################
set(INSTALL_BASE_DIR "")
set(INSTALL_INCLUDE_DIR include)
set(INSTALL_LIBRARY_DIR lib)
set(INSTALL_RUNTIME_DIR bin)
set(INSTALL_CONFIG_DIR  lib/cmake)

include(CMakePackageConfigHelpers)

install(TARGETS ep_log_daemon_utest OPTIONAL
    LIBRARY OPTIONAL DESTINATION ${INSTALL_LIBRARY_DIR}
    ARCHIVE OPTIONAL DESTINATION ${INSTALL_LIBRARY_DIR}
)