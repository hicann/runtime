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
set(MDC_LINUX_SDK_DIR ${TOP_DIR}/build/bin/os/aos_libs/aos_x86_ubuntu_18_04_adk/aos-libs/usr)

###################################################################
set(libhdclogHostSrc
    ${LOG_SOURCE_PATH}/liblog/slog/alog_to_slog.c
    ${LOG_SOURCE_PATH}/liblog/slog/slog_api.cpp
    ${LOG_SOURCE_PATH}/liblog/slog/dlog_core_iam.c
    ${LOG_SOURCE_PATH}/liblog/slog/dlog_message.c
    ${LOG_SOURCE_PATH}/liblog/slog/dlog_async_process.c
    ${LOG_SOURCE_PATH}/liblog/slog/dlog_unified_timer_api.c
    ${LOG_SOURCE_PATH}/liblog/slog/dlog_iam.c
    ${LOG_SOURCE_PATH}/liblog/slog/dlog_time.c
    ${LOG_SOURCE_PATH}/liblog/slog/dlog_attr.c
    ${LOG_SOURCE_PATH}/liblog/slog/dlog_level_iam.c
    ${LOG_SOURCE_PATH}/liblog/slog/dlog_level_mgr.c
    ${LOG_SOURCE_PATH}/liblog/slog/dlog_level_env.c
    ${LOG_SOURCE_PATH}/syslog/slog/log_server/log_classify/firmware_log/log_recv_interface.c
    ${LOG_SOURCE_PATH}/syslog/slog/log_server/log_classify/firmware_log/log_recv.c
    ${LOG_SOURCE_PATH}/syslog/slog/log_server/log_classify/firmware_log/slogd_firmware_log.c
    ${LOG_SOURCE_PATH}/syslog/log_daemon/log_daemon.c
    ${LOG_SOURCE_PATH}/syslog/log_daemon/log_daemon_server.c
    ${LOG_SOURCE_PATH}/syslog/log_daemon/file_dump/log_get_file.cpp
    ${LOG_SOURCE_PATH}/syslog/log_daemon/file_dump/log_file_dump_c.cpp
    ${LOG_SOURCE_PATH}/syslog/log_daemon/file_dump/log_process_util.cpp
    ${LOG_SOURCE_PATH}/syslog/log_daemon/file_dump/log_dsmi_drv.cpp
    ${LOG_SOURCE_PATH}/syslog/log_daemon/file_dump/log_file_utils.cpp
    ${LOG_SOURCE_PATH}/syslog/log_daemon/file_monitor/file_monitor_common.c
    ${LOG_SOURCE_PATH}/syslog/log_daemon/file_monitor/file_monitor_core.c
    ${LOG_SOURCE_PATH}/syslog/log_daemon/file_monitor/file_bbox_monitor.c
    ${LOG_SOURCE_PATH}/syslog/log_daemon/file_monitor/stackcore_file_monitor.c
    ${LOG_SOURCE_PATH}/syslog/log_daemon/file_monitor/file_slogdlog_monitor.c
    ${LOG_SOURCE_PATH}/syslog/log_daemon/file_monitor/file_device_app_monitor.c
    ${LOG_SOURCE_PATH}/syslog/log_daemon/event_process/event_process_core.c
    ${LOG_SOURCE_PATH}/syslog/log_daemon/server_mgr/server_mgr.c
    ${LOG_SOURCE_PATH}/syslog/log_daemon/cpu_detect/cpu_detect.c
    ${LOG_SOURCE_PATH}/syslog/log_daemon/lib_load/lib_load.c
    ${LOG_SOURCE_PATH}/syslog/slog/log_server/log_mgr/level_mgr/slogd_shm_mgr.c
    ${LOG_SOURCE_PATH}/syslog/slog/log_server/slogd_dev_mgr.c
    ${LOG_SOURCE_PATH}/syslog/slog/log_server/slogd_thread_mgr.c
    ${LOG_SOURCE_PATH}/syslog/slog/log_server/log_classify/sys_log/slogd_syslog.c
    ${LOG_SOURCE_PATH}/syslog/slog/log_server/log_classify/sys_log/slogd_kernel_log.c
    ${LOG_SOURCE_PATH}/syslog/slog/log_server/log_classify/app_log/slogd_applog_core.c
    ${LOG_SOURCE_PATH}/syslog/slog/log_server/log_classify/app_log/slogd_applog_flush.c
    ${LOG_SOURCE_PATH}/syslog/slog/log_server/log_classify/app_log/slogd_appnum_watch.c
    ${LOG_SOURCE_PATH}/syslog/slog/log_server/log_classify/event_log/slogd_eventlog.c
    ${LOG_SOURCE_PATH}/syslog/slog/log_server/log_pre_process/slogd_recv_core.c
    ${LOG_SOURCE_PATH}/syslog/slog/log_server/log_pre_process/slogd_parse_msg.c
    ${LOG_SOURCE_PATH}/syslog/slog/log_server/log_pre_process/slogd_recv_msg.c
    ${LOG_SOURCE_PATH}/syslog/slog/log_server/log_pre_process/log_communication/slogd_communication.c
    ${LOG_SOURCE_PATH}/syslog/slog/log_server/log_pre_process/log_communication/slogd_communication_socket.c
    ${LOG_SOURCE_PATH}/syslog/slog/log_server/log_post_process/slogd_flush.c
    ${LOG_SOURCE_PATH}/syslog/slog/log_server/log_post_process/session_mgr/log_session_manage.c
    ${LOG_SOURCE_PATH}/syslog/slog/log_server/log_mgr/buffer_mgr/slogd_buffer.c
    ${LOG_SOURCE_PATH}/syslog/slog/log_server/log_mgr/file_mgr/slogd_compress.c
    ${LOG_SOURCE_PATH}/syslog/slog/log_server/log_mgr/level_mgr/operate_loglevel.c
    ${LOG_SOURCE_PATH}/syslog/slog/log_server/log_mgr/level_mgr/slogd_dynamic_level.c
    ${LOG_SOURCE_PATH}/syslog/slog/log_server/log_mgr/level_mgr/slogd_firmware_level.c
    ${LOG_SOURCE_PATH}/syslog/slog/log_server/log_mgr/level_mgr/log_level_parse.c
    ${LOG_SOURCE_PATH}/syslog/slog/log_server/log_mgr/config_mgr/slogd_config_mgr.c
    ${LOG_SOURCE_PATH}/syslog/slog/log_server/log_classify/group_log/slogd_group_log.c
    ${LOG_SOURCE_PATH}/syslog/common/log_path_mgr.c
    ${LOG_SOURCE_PATH}/syslog/common/log_print_selflog.c
    ${LOG_SOURCE_PATH}/syslog/slog/log_server/log_mgr/file_mgr/log_to_file.c
    ${LOG_SOURCE_PATH}/syslog/slog/log_server/log_mgr/file_mgr/slogd_write_limit.c
    ${LOG_SOURCE_PATH}/syslog/common/pm/log_pm_sig.c
    ${LOG_SOURCE_PATH}/syslog/common/pm/log_pm.c
    ${LOG_SOURCE_PATH}/syslog/common/pm/log_monitor.c
    ${LOG_SOURCE_PATH}/syslog/common/pm/start_single_process.c
    ${LOG_SOURCE_PATH}/syslog/common/pm/log_pm_sr.c
    ${LOG_SOURCE_PATH}/syslog/common/config/log_config_list.c
    ${LOG_SOURCE_PATH}/syslog/common/config/log_config_block.c
    ${LOG_SOURCE_PATH}/syslog/common/config/log_config_common.c
    ${LOG_SOURCE_PATH}/syslog/common/config/log_config_api.c
    ${LOG_SOURCE_PATH}/syslog/common/config/log_config_group.c
    ${LOG_SOURCE_PATH}/syslog/common/driver/log_drv.c
    ${LOG_SOURCE_PATH}/syslog/common/driver/driver_api.c
    ${LOG_SOURCE_PATH}/utils/log_print_syslog.c
    ${LOG_SOURCE_PATH}/utils/msg_queue.c
    ${LOG_SOURCE_PATH}/utils/log_common.c
    ${LOG_SOURCE_PATH}/utils/log_queue.c
    ${LOG_SOURCE_PATH}/utils/share_mem.c
    ${LOG_SOURCE_PATH}/utils/log_compress/log_compress.c
    ${LOG_SOURCE_PATH}/utils/high_mem.c
    ${LOG_SOURCE_PATH}/utils/log_buffer/log_ring_buffer.c
    ${LOG_SOURCE_PATH}/utils/log_time.c
    ${LOG_SOURCE_PATH}/utils/log_file_util.c
    ${LOG_SOURCE_PATH}/utils/library_load.c
    ${CMAKE_CURRENT_SOURCE_DIR}/test/main.cc
    ${CMAKE_CURRENT_SOURCE_DIR}/test/log_queue_ut.cc
    ${CMAKE_CURRENT_SOURCE_DIR}/test/log_daemon_ut.cc
    ${CMAKE_CURRENT_SOURCE_DIR}/test/slog_iam_ut.cc
    ${CMAKE_CURRENT_SOURCE_DIR}/test/hdc_log_recv_ut.cc
    ${CMAKE_CURRENT_SOURCE_DIR}/test/cfg-file-parse-ut.cc
    ${CMAKE_CURRENT_SOURCE_DIR}/stub/log_daemon_ut_stub.c
    ${CMAKE_CURRENT_SOURCE_DIR}/stub/file_dump_ut_stub.c
    ${CMAKE_CURRENT_SOURCE_DIR}/stub/hdclog_ut_stub.c
    ${CMAKE_CURRENT_SOURCE_DIR}/stub/hdclog_hdc_ut_stub.c
    ${CMAKE_CURRENT_SOURCE_DIR}/stub/iam_stub.c
    ${CMAKE_CURRENT_SOURCE_DIR}/test/adx_get_file_server_utest.cc
    ${CMAKE_CURRENT_SOURCE_DIR}/test/adx_get_file_utest.cc
    ${CMAKE_CURRENT_SOURCE_DIR}/test/ide_process_util_test.cc
    ${CMAKE_CURRENT_SOURCE_DIR}/test/log_file_utils_utest.cc
    ${CMAKE_CURRENT_SOURCE_DIR}/../stub/ascend_hal_stub.c
)

set(libhdclogHostInc
    ${TOP_DIR}/abl/slog/inc/msnpureport
    ${TOP_DIR}/inc/driver
    ${TOP_DIR}/abl/libc_sec/include
    ${TOP_DIR}/abl/adump/external
    ${TOP_DIR}/abl/adump/adcore
    ${TOP_DIR}/abl/adump/adcore/commopts
    ${TOP_DIR}/abl/adump/adcore/component
    ${TOP_DIR}/abl/adump/adcore/common
    ${TOP_DIR}/abl/adump/adcore/protocol
    ${LOG_SOURCE_PATH}/syslog/log_daemon
    ${LOG_SOURCE_PATH}/syslog/log_daemon/config_cmd
    ${LOG_SOURCE_PATH}/syslog/log_daemon/file_dump
    ${LOG_SOURCE_PATH}/syslog/log_daemon/hbm_detect
    ${LOG_SOURCE_PATH}/syslog/log_daemon/cpu_detect
    ${LOG_SOURCE_PATH}/syslog/log_daemon/include
    ${LOG_SOURCE_PATH}/syslog/log_daemon/server_mgr
    ${LOG_SOURCE_PATH}/syslog/log_daemon/file_monitor
    ${LOG_SOURCE_PATH}/syslog/log_daemon/event_process
    ${LOG_SOURCE_PATH}/syslog/log_daemon/lib_load
    ${LOG_SOURCE_PATH}/shared
    ${LOG_SOURCE_PATH}/utils
    ${LOG_SOURCE_PATH}/utils/log_compress
    ${LOG_SOURCE_PATH}/syslog/slog
    ${LOG_SOURCE_PATH}/syslog/slog/log_server
    ${LOG_SOURCE_PATH}/syslog/slog/log_server/log_server
    ${LOG_SOURCE_PATH}/syslog/slog/log_server/log_mgr/level_mgr
    ${LOG_SOURCE_PATH}/syslog/slog/log_server/log_mgr/file_mgr
    ${LOG_SOURCE_PATH}/syslog/slog/log_server/log_classify/firmware_log
    ${LOG_SOURCE_PATH}/syslog/slog/log_server/log_classify/sys_log
    ${LOG_SOURCE_PATH}/syslog/slog/log_server/log_classify/group_log
    ${LOG_SOURCE_PATH}/syslog/slog/log_server/log_mgr/config_mgr
    ${LOG_SOURCE_PATH}/syslog/slog/log_server/log_mgr/buffer_mgr
    ${LOG_SOURCE_PATH}/syslog/slog/log_server/log_post_process/app_report
    ${LOG_SOURCE_PATH}/syslog/slog/log_server/log_post_process/session_mgr
    ${LOG_SOURCE_PATH}/syslog/slog/log_server/log_classify/app_log
    ${LOG_SOURCE_PATH}/syslog/slog/log_server/log_classify/event_log
    ${LOG_SOURCE_PATH}/syslog/slog/log_server/log_pre_process
    ${LOG_SOURCE_PATH}/syslog/slog/log_server/log_pre_process/log_communication
    ${LOG_SOURCE_PATH}/syslog/slog/log_server/log_mgr
    ${LOG_SOURCE_PATH}/syslog/slog/log_server/log_post_process
    ${LOG_SOURCE_PATH}/syslog/common
    ${LOG_SOURCE_PATH}/syslog/common/driver
    ${LOG_SOURCE_PATH}/syslog/common/pm
    ${LOG_SOURCE_PATH}/syslog/common/config
    ${LOG_SOURCE_PATH}/liblog/slog
    ${LOG_SOURCE_PATH}/utils/log_buffer
    ${ADX_SOURCE_PATH}/external
    ${CMAKE_CURRENT_SOURCE_DIR}/stub
    ${MDC_LINUX_SDK_DIR}/include
    #${IAM_HEADER_DIR}/include
    ${TOP_DIR}/manager/resmgr/secmgr/include
)

###################################################################
add_executable(hdclog_host_utest
    ${libhdclogHostSrc}
)

target_include_directories(hdclog_host_utest PRIVATE
    ${libhdclogHostInc}
)

target_compile_definitions(hdclog_host_utest PRIVATE
    __IDE_UT
    _LOG_UT_
    LOG_SOCKET
    SORTED_LOG
    SR_MONITOR
    SCRIPT_MONITOR
    APP_LOG_WATCH
    WRITE_TO_SYSLOG
)

target_link_libraries(hdclog_host_utest PRIVATE
    $<BUILD_INTERFACE:intf_llt_pub>
    $<BUILD_INTERFACE:mmpa_headers>
    $<BUILD_INTERFACE:slog_headers>
    $<BUILD_INTERFACE:adump_headers>
    mmpa
    c_sec
    -Wl,-rpath,${TOP_DIR}/output/llt/c_sec/lib
)

target_compile_options(hdclog_host_utest PRIVATE
    -Werror
)

set_target_properties(hdclog_host_utest
    PROPERTIES
    OUTPUT_NAME toolchain_hdclog_host_utest
    LIBRARY_OUTPUT_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/
)

run_llt_test(
    TARGET hdclog_host_utest
    TASK_NUM 1
)

###################################################################
set(logDaemonSrc
    ${LOG_SOURCE_PATH}/syslog/log_daemon/log_daemon.c
    ${LOG_SOURCE_PATH}/syslog/log_daemon/log_daemon_server.c
    ${LOG_SOURCE_PATH}/syslog/log_daemon/file_dump/log_get_file.cpp
    ${LOG_SOURCE_PATH}/syslog/log_daemon/file_dump/log_file_dump_c.cpp
    ${LOG_SOURCE_PATH}/syslog/log_daemon/file_dump/log_process_util.cpp
    ${LOG_SOURCE_PATH}/syslog/log_daemon/file_dump/log_dsmi_drv.cpp
    ${LOG_SOURCE_PATH}/syslog/log_daemon/file_dump/log_file_utils.cpp
    ${LOG_SOURCE_PATH}/syslog/log_daemon/server_mgr/server_mgr.c
    ${LOG_SOURCE_PATH}/syslog/log_daemon/file_monitor/file_monitor_common.c
    ${LOG_SOURCE_PATH}/syslog/log_daemon/file_monitor/file_monitor_core.c
    ${LOG_SOURCE_PATH}/syslog/log_daemon/file_monitor/file_bbox_monitor.c
    ${LOG_SOURCE_PATH}/syslog/log_daemon/file_monitor/stackcore_file_monitor.c
    ${LOG_SOURCE_PATH}/syslog/log_daemon/file_monitor/file_slogdlog_monitor.c
    ${LOG_SOURCE_PATH}/syslog/log_daemon/file_monitor/file_device_app_monitor.c
    ${LOG_SOURCE_PATH}/syslog/log_daemon/cpu_detect/cpu_detect.c
    ${LOG_SOURCE_PATH}/syslog/log_daemon/lib_load/lib_load.c
    ${LOG_SOURCE_PATH}/syslog/log_daemon/event_process/event_process_core.c
    ${LOG_SOURCE_PATH}/syslog/slog/log_server/log_mgr/level_mgr/slogd_shm_mgr.c
    ${LOG_SOURCE_PATH}/syslog/slog/log_server/slogd_dev_mgr.c
    ${LOG_SOURCE_PATH}/syslog/slog/log_server/slogd_thread_mgr.c
    ${LOG_SOURCE_PATH}/syslog/slog/log_server/log_pre_process/slogd_recv_core.c
    ${LOG_SOURCE_PATH}/syslog/slog/log_server/log_pre_process/slogd_parse_msg.c
    ${LOG_SOURCE_PATH}/syslog/slog/log_server/log_pre_process/slogd_recv_msg.c
    ${LOG_SOURCE_PATH}/syslog/slog/log_server/log_pre_process/log_communication/slogd_communication.c
    ${LOG_SOURCE_PATH}/syslog/slog/log_server/log_pre_process/log_communication/slogd_communication_iam.c
    ${LOG_SOURCE_PATH}/syslog/slog/log_server/log_post_process/slogd_flush.c
    ${LOG_SOURCE_PATH}/syslog/slog/log_server/log_post_process/session_mgr/log_session_manage.c
    ${LOG_SOURCE_PATH}/syslog/slog/log_server/log_mgr/buffer_mgr/slogd_buffer.c
    ${LOG_SOURCE_PATH}/syslog/slog/log_server/log_pre_process/cmd_process/slogd_collect_log.c
    ${LOG_SOURCE_PATH}/syslog/slog/log_server/log_mgr/file_mgr/slogd_compress.c
    ${LOG_SOURCE_PATH}/syslog/slog/log_server/log_classify/app_log/slogd_applog_flush.c
    ${LOG_SOURCE_PATH}/syslog/slog/log_server/log_classify/app_log/slogd_applog_core.c
    ${LOG_SOURCE_PATH}/syslog/slog/log_server/log_classify/app_log/slogd_appnum_watch.c
    ${LOG_SOURCE_PATH}/syslog/slog/log_server/log_classify/event_log/slogd_eventlog.c
    ${LOG_SOURCE_PATH}/syslog/slog/log_server/log_classify/sys_log/slogd_syslog.c
    ${LOG_SOURCE_PATH}/syslog/slog/log_server/log_classify/sys_log/slogd_kernel_log.c
    ${LOG_SOURCE_PATH}/syslog/slog/log_server/log_classify/group_log/slogd_group_log.c
    ${LOG_SOURCE_PATH}/syslog/slog/log_server/log_classify/firmware_log/slogd_firmware_log.c
    ${LOG_SOURCE_PATH}/syslog/slog/log_server/log_classify/firmware_log/log_recv_interface.c
    ${LOG_SOURCE_PATH}/syslog/slog/log_server/log_classify/firmware_log/log_recv.c
    ${LOG_SOURCE_PATH}/syslog/slog/log_server/log_mgr/level_mgr/operate_loglevel.c
    ${LOG_SOURCE_PATH}/syslog/slog/log_server/log_mgr/level_mgr/slogd_dynamic_level.c
    ${LOG_SOURCE_PATH}/syslog/slog/log_server/log_mgr/level_mgr/slogd_firmware_level.c
    ${LOG_SOURCE_PATH}/syslog/slog/log_server/log_mgr/level_mgr/log_level_parse.c
    ${LOG_SOURCE_PATH}/syslog/slog/log_server/log_mgr/config_mgr/slogd_config_mgr.c
    ${LOG_SOURCE_PATH}/syslog/common/pm/log_pm_sig.c
    ${LOG_SOURCE_PATH}/syslog/common/log_path_mgr.c
    ${LOG_SOURCE_PATH}/syslog/common/log_print_selflog.c
    ${LOG_SOURCE_PATH}/syslog/common/log_print_selflog.c
    ${LOG_SOURCE_PATH}/utils/log_queue.c
    ${LOG_SOURCE_PATH}/utils/msg_queue.c
    ${LOG_SOURCE_PATH}/utils/share_mem.c
    ${LOG_SOURCE_PATH}/utils/log_common.c
    ${LOG_SOURCE_PATH}/utils/log_compress/log_compress.c
    ${LOG_SOURCE_PATH}/utils/log_compress/log_hardware_zip.c
    ${LOG_SOURCE_PATH}/syslog/common/pm/log_pm.c
    ${LOG_SOURCE_PATH}/syslog/common/pm/log_monitor.c
    ${LOG_SOURCE_PATH}/syslog/common/pm/start_single_process.c
    ${LOG_SOURCE_PATH}/syslog/common/pm/log_pm_sr.c
    ${LOG_SOURCE_PATH}/syslog/common/config/log_config_list.c
    ${LOG_SOURCE_PATH}/syslog/common/config/log_config_block.c
    ${LOG_SOURCE_PATH}/syslog/common/config/log_config_common.c
    ${LOG_SOURCE_PATH}/syslog/common/config/log_config_api.c
    ${LOG_SOURCE_PATH}/syslog/common/config/log_config_group.c
    ${LOG_SOURCE_PATH}/syslog/common/driver/log_drv.c
    ${LOG_SOURCE_PATH}/syslog/common/driver/driver_api.c
    ${LOG_SOURCE_PATH}/utils/log_file_util.c
    ${LOG_SOURCE_PATH}/utils/library_load.c
    ${LOG_SOURCE_PATH}/syslog/slog/log_server/log_mgr/file_mgr/log_to_file.c
    ${LOG_SOURCE_PATH}/syslog/slog/log_server/log_mgr/file_mgr/slogd_write_limit.c
    ${LOG_SOURCE_PATH}/utils/log_print_syslog.c
    ${CMAKE_CURRENT_SOURCE_DIR}/test/log_hardware_zip_ut.cc
    ${LOG_SOURCE_PATH}/utils/log_buffer/log_ring_buffer.c
    ${LOG_SOURCE_PATH}/utils/log_time.c
    ${CMAKE_CURRENT_SOURCE_DIR}/test/main.cc
    ${CMAKE_CURRENT_SOURCE_DIR}/stub/log_daemon_ut_stub.c
    ${CMAKE_CURRENT_SOURCE_DIR}/stub/file_dump_ut_stub.c
    ${CMAKE_CURRENT_SOURCE_DIR}/stub/iam_stub.c
    ${CMAKE_CURRENT_SOURCE_DIR}/../stub/ascend_hal_stub.c
    ${CMAKE_CURRENT_SOURCE_DIR}/test/log_daemon_ut.cc
    ${CMAKE_CURRENT_SOURCE_DIR}/test/log_queue_ut.cc
    ${CMAKE_CURRENT_SOURCE_DIR}/test/hdc_log_recv_ut.cc
    ${CMAKE_CURRENT_SOURCE_DIR}/test/syslogd_iam_ut.cc
    ${CMAKE_CURRENT_SOURCE_DIR}/test/adx_get_file_server_utest.cc
    ${CMAKE_CURRENT_SOURCE_DIR}/test/adx_get_file_utest.cc
    ${CMAKE_CURRENT_SOURCE_DIR}/test/ide_process_util_test.cc
    ${CMAKE_CURRENT_SOURCE_DIR}/test/log_file_utils_utest.cc
)

set(logDaemonInc
    ${TOP_DIR}/abl/slog/inc/msnpureport
    ${TOP_DIR}/inc/driver
    ${TOP_DIR}/abl/libc_sec/include
    ${TOP_DIR}/abl/adump/external
    ${TOP_DIR}/abl/adump/adcore
    ${TOP_DIR}/abl/adump/adcore/commopts
    ${TOP_DIR}/abl/adump/adcore/component
    ${TOP_DIR}/abl/adump/adcore/common
    ${TOP_DIR}/abl/adump/adcore/protocol
    ${LOG_SOURCE_PATH}/liblog/slog
    ${LOG_SOURCE_PATH}/syslog/log_daemon
    ${LOG_SOURCE_PATH}/syslog/log_daemon/config_cmd
    ${LOG_SOURCE_PATH}/syslog/log_daemon/file_dump
    ${LOG_SOURCE_PATH}/syslog/log_daemon/hbm_detect
    ${LOG_SOURCE_PATH}/syslog/log_daemon/cpu_detect
    ${LOG_SOURCE_PATH}/syslog/log_daemon/include
    ${LOG_SOURCE_PATH}/syslog/log_daemon/server_mgr
    ${LOG_SOURCE_PATH}/syslog/log_daemon/stackcore
    ${LOG_SOURCE_PATH}/syslog/log_daemon/file_monitor
    ${LOG_SOURCE_PATH}/syslog/log_daemon/event_process
    ${LOG_SOURCE_PATH}/syslog/log_daemon/lib_load
    ${LOG_SOURCE_PATH}/shared
    ${LOG_SOURCE_PATH}/utils
    ${LOG_SOURCE_PATH}/utils/log_compress
    ${LOG_SOURCE_PATH}/syslog/slog
    ${LOG_SOURCE_PATH}/syslog/slog/log_server
    ${LOG_SOURCE_PATH}/syslog/slog/log_server/log_server
    ${LOG_SOURCE_PATH}/syslog/slog/log_server/log_mgr/level_mgr
    ${LOG_SOURCE_PATH}/syslog/slog/log_server/log_post_process
    ${LOG_SOURCE_PATH}/syslog/slog/log_server/log_post_process/session_mgr
    ${LOG_SOURCE_PATH}/syslog/slog/log_server/log_mgr/file_mgr
    ${LOG_SOURCE_PATH}/syslog/slog/log_server/log_mgr
    ${LOG_SOURCE_PATH}/syslog/slog/log_server/log_classify/firmware_log
    ${LOG_SOURCE_PATH}/syslog/slog/log_server/log_classify/app_log
    ${LOG_SOURCE_PATH}/syslog/slog/log_server/log_classify/event_log
    ${LOG_SOURCE_PATH}/syslog/slog/log_server/log_classify/group_log
    ${LOG_SOURCE_PATH}/syslog/slog/log_server/log_classify/sys_log
    ${LOG_SOURCE_PATH}/syslog/slog/log_server/log_mgr/config_mgr
    ${LOG_SOURCE_PATH}/syslog/slog/log_server/log_mgr/buffer_mgr
    ${LOG_SOURCE_PATH}/syslog/slog/log_server/log_pre_process
    ${LOG_SOURCE_PATH}/syslog/slog/log_server/log_pre_process/log_communication
    ${LOG_SOURCE_PATH}/syslog/slog/log_server/log_pre_process/cmd_process
    ${LOG_SOURCE_PATH}/syslog/common
    ${LOG_SOURCE_PATH}/syslog/common/driver
    ${LOG_SOURCE_PATH}/syslog/common/pm
    ${LOG_SOURCE_PATH}/syslog/common/config
    ${LOG_SOURCE_PATH}/utils/log_buffer
    ${LOG_SOURCE_PATH}/liblog/slog
    ${CMAKE_CURRENT_SOURCE_DIR}/stub
    ${MDC_LINUX_SDK_DIR}/include
    #${IAM_HEADER_DIR}/include
    ${TOP_DIR}/manager/resmgr/secmgr/include
)

###################################################################
add_executable(log_daemon_utest
    ${logDaemonSrc}
)

target_include_directories(log_daemon_utest PRIVATE
    ${logDaemonInc}
)

target_compile_definitions(log_daemon_utest PRIVATE
    __IDE_UT
    _LOG_UT_
    SR_MONITOR
    GROUP_LOG
    IAM
    HARDWARE_ZIP
    LOG_COREDUMP
    SCRIPT_MONITOR
    SLOGD_COLLECT
    APP_LOG_WATCH
    ROOT_PATH="/tmp/syslog_iam_AxG0YIS9dSIN1OiB4"
    COLLECT_PATH="/tmp/syslog_iam_AxG0YIS9dSIN1OiB4/ascendmerge.log.gz"
)

target_link_libraries(log_daemon_utest PRIVATE
    $<BUILD_INTERFACE:intf_llt_pub>
    $<BUILD_INTERFACE:mmpa_headers>
    $<BUILD_INTERFACE:slog_headers>
    $<BUILD_INTERFACE:adump_headers>
    c_sec
    -Wl,-rpath,${TOP_DIR}/output/llt/c_sec/lib
    -Wl,-rpath,${CMAKE_CURRENT_BINARY_DIR}/../../../../../../../../llt_gcc4.9.3-prefix/src/llt_gcc4.9.3-build/abl/slog/slog/slog/host
)

target_compile_options(log_daemon_utest PRIVATE
    -Werror
)

set_target_properties(log_daemon_utest
    PROPERTIES
    OUTPUT_NAME toolchain_log_daemon_ut
    LIBRARY_OUTPUT_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/
)

run_llt_test(
    TARGET log_daemon_utest
    TASK_NUM 1
)

###################################################################
set(INSTALL_BASE_DIR "")
set(INSTALL_INCLUDE_DIR include)
set(INSTALL_LIBRARY_DIR lib)
set(INSTALL_RUNTIME_DIR bin)
set(INSTALL_CONFIG_DIR  lib/cmake)

include(CMakePackageConfigHelpers)

install(TARGETS hdclog_host_utest log_daemon_utest OPTIONAL
    LIBRARY OPTIONAL DESTINATION ${INSTALL_LIBRARY_DIR}
    ARCHIVE OPTIONAL DESTINATION ${INSTALL_LIBRARY_DIR}
)
