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
set(libhdclogDeviceSrc
    ${LOG_SOURCE_PATH}/syslog/log_daemon/config_cmd/hdclog_device_init.c
    ${LOG_SOURCE_PATH}/syslog/log_daemon/config_cmd/log_cmd.c
    ${LOG_SOURCE_PATH}/syslog/slog/log_server/log_pre_process/slogd_recv_core.c
    ${LOG_SOURCE_PATH}/syslog/slog/log_server/log_pre_process/slogd_parse_msg.c
    ${LOG_SOURCE_PATH}/syslog/slog/log_server/log_pre_process/slogd_recv_msg.c
    ${LOG_SOURCE_PATH}/syslog/slog/log_server/log_pre_process/log_communication/slogd_communication.c
    ${LOG_SOURCE_PATH}/syslog/slog/log_server/log_pre_process/log_communication/slogd_communication_socket.c
    ${LOG_SOURCE_PATH}/syslog/slog/log_server/log_post_process/slogd_flush.c
    ${LOG_SOURCE_PATH}/syslog/slog/log_server/log_mgr/buffer_mgr/slogd_buffer.c
    ${LOG_SOURCE_PATH}/syslog/slog/log_server/log_mgr/file_mgr/slogd_compress.c
    ${LOG_SOURCE_PATH}/syslog/slog/log_server/log_classify/sys_log/slogd_syslog.c
    ${LOG_SOURCE_PATH}/syslog/slog/log_server/log_classify/sys_log/slogd_kernel_log.c
    ${LOG_SOURCE_PATH}/syslog/slog/log_server/log_classify/app_log/slogd_applog_core.c
    ${LOG_SOURCE_PATH}/syslog/slog/log_server/log_classify/app_log/slogd_applog_flush.c
    ${LOG_SOURCE_PATH}/syslog/slog/log_server/log_classify/app_log/slogd_appnum_watch.c
    ${LOG_SOURCE_PATH}/syslog/slog/log_server/log_classify/event_log/slogd_eventlog.c
    ${LOG_SOURCE_PATH}/syslog/slog/log_server/log_classify/firmware_log/slogd_firmware_log.c
    ${LOG_SOURCE_PATH}/syslog/slog/log_server/log_classify/firmware_log/log_recv.c
    ${LOG_SOURCE_PATH}/syslog/slog/log_server/log_classify/firmware_log/log_recv_interface.c
    ${LOG_SOURCE_PATH}/syslog/slog/log_server/log_mgr/level_mgr/operate_loglevel.c
    ${LOG_SOURCE_PATH}/syslog/slog/log_server/log_mgr/level_mgr/slogd_dynamic_level.c
    ${LOG_SOURCE_PATH}/syslog/slog/log_server/log_mgr/level_mgr/slogd_firmware_level.c
    ${LOG_SOURCE_PATH}/syslog/slog/log_server/log_mgr/level_mgr/log_level_parse.c
    ${LOG_SOURCE_PATH}/syslog/slog/log_server/log_mgr/config_mgr/slogd_config_mgr.c
    ${LOG_SOURCE_PATH}/syslog/slog/log_server/log_mgr/level_mgr/slogd_shm_mgr.c
    ${LOG_SOURCE_PATH}/syslog/slog/log_server/log_post_process/session_mgr/log_session_manage.c
    ${LOG_SOURCE_PATH}/syslog/slog/log_server/slogd_dev_mgr.c
    ${LOG_SOURCE_PATH}/syslog/slog/log_server/slogd_thread_mgr.c
    ${LOG_SOURCE_PATH}/syslog/slog/log_server/log_mgr/file_mgr/log_to_file.c
    ${LOG_SOURCE_PATH}/syslog/slog/log_server/log_mgr/file_mgr/slogd_write_limit.c
    ${LOG_SOURCE_PATH}/syslog/common/pm/log_pm.c
    ${LOG_SOURCE_PATH}/syslog/common/pm/log_monitor.c
    ${LOG_SOURCE_PATH}/syslog/common/pm/log_pm_sr.c
    ${LOG_SOURCE_PATH}/syslog/common/config/log_config_list.c
    ${LOG_SOURCE_PATH}/syslog/common/config/log_config_block.c
    ${LOG_SOURCE_PATH}/syslog/common/config/log_config_common.c
    ${LOG_SOURCE_PATH}/syslog/common/config/log_config_api.c
    ${LOG_SOURCE_PATH}/syslog/common/config/log_config_group.c
    ${LOG_SOURCE_PATH}/syslog/common/driver/log_drv.c
    ${LOG_SOURCE_PATH}/syslog/common/driver/driver_api.c
    ${LOG_SOURCE_PATH}/utils/log_file_util.c
    ${LOG_SOURCE_PATH}/syslog/common/log_path_mgr.c
    ${LOG_SOURCE_PATH}/utils/share_mem.c
    ${LOG_SOURCE_PATH}/syslog/common/pm/log_pm_sig.c
    ${LOG_SOURCE_PATH}/utils/log_common.c
    ${LOG_SOURCE_PATH}/utils/msg_queue.c
    ${LOG_SOURCE_PATH}/utils/log_queue.c
    ${LOG_SOURCE_PATH}/utils/log_system_api.c
    ${LOG_SOURCE_PATH}/utils/log_compress/log_compress.c
    ${LOG_SOURCE_PATH}/utils/log_compress/log_software_zip.c
    ${LOG_SOURCE_PATH}/utils/log_time.c
    ${CMAKE_CURRENT_SOURCE_DIR}/test/main.cc
    ${CMAKE_CURRENT_SOURCE_DIR}/test/hdclog_device_init_ut.cc
    ${CMAKE_CURRENT_SOURCE_DIR}/stub/ide_log_device_stub.c
    ${CMAKE_CURRENT_SOURCE_DIR}/test/log-zip-ut.cc
    ${CMAKE_CURRENT_SOURCE_DIR}/../stub/ascend_hal_stub.c
)

set(libhdclogDeviceInc
    ${TOP_DIR}/inc/driver
    ${TOP_DIR}/abl/libc_sec/include
    ${LOG_SOURCE_PATH}/syslog/log_daemon/config_cmd
    ${LOG_SOURCE_PATH}/syslog/common
    ${LOG_SOURCE_PATH}/syslog/common/driver
    ${LOG_SOURCE_PATH}/syslog/common/pm
    ${LOG_SOURCE_PATH}/syslog/common/config
    ${LOG_SOURCE_PATH}/shared
    ${LOG_SOURCE_PATH}/utils
    ${LOG_SOURCE_PATH}/utils/log_compress
    ${LOG_SOURCE_PATH}/shared/external
    ${LOG_SOURCE_PATH}/syslog/slog
    ${LOG_SOURCE_PATH}/syslog/slog/log_server
    ${LOG_SOURCE_PATH}/syslog/slog/log_server/log_server
    ${LOG_SOURCE_PATH}/syslog/slog/log_server/log_mgr/level_mgr
    ${LOG_SOURCE_PATH}/syslog/slog/log_server/log_mgr/file_mgr
    ${LOG_SOURCE_PATH}/syslog/slog/log_server/log_classify/firmware_log
    ${LOG_SOURCE_PATH}/syslog/slog/log_server/log_classify/app_log
    ${LOG_SOURCE_PATH}/syslog/slog/log_server/log_classify/event_log
    ${LOG_SOURCE_PATH}/syslog/slog/log_server/log_classify/sys_log
    ${LOG_SOURCE_PATH}/syslog/slog/log_server/log_classify/group_log
    ${LOG_SOURCE_PATH}/syslog/slog/log_server/log_mgr/config_mgr
    ${LOG_SOURCE_PATH}/syslog/slog/log_server/log_mgr/buffer_mgr
    ${LOG_SOURCE_PATH}/syslog/slog/log_server/log_post_process/app_report
    ${LOG_SOURCE_PATH}/syslog/slog/log_server/log_post_process/sys_report
    ${LOG_SOURCE_PATH}/syslog/slog/log_server/log_post_process/sys_get
    ${LOG_SOURCE_PATH}/syslog/slog/log_server/log_post_process/session_mgr
    ${LOG_SOURCE_PATH}/syslog/slog/log_server/log_post_process
    ${LOG_SOURCE_PATH}/syslog/slog/log_server/log_mgr
    ${LOG_SOURCE_PATH}/syslog/slog/log_server/log_pre_process
    ${LOG_SOURCE_PATH}/syslog/slog/log_server/log_pre_process/log_communication
    ${LOG_SOURCE_PATH}/syslog/msnpureport
    ${LOG_SOURCE_PATH}/liblog/slog
    ${ADX_SOURCE_PATH}/external
    ${CMAKE_CURRENT_SOURCE_DIR}/stub
    ${TOP_DIR}/abl/slog/inc/msnpureport
)

add_executable(hdclog_device_utest
    ${libhdclogDeviceSrc}
)

target_include_directories(hdclog_device_utest PRIVATE
    ${libhdclogDeviceInc}
)

target_compile_definitions(hdclog_device_utest PRIVATE
    _LOG_UT_
    __IDE_UT
    SORTED_LOG
    ROOT_PATH="/tmp/logzip_A8sdJFDE823h9"
    LOG_PATH="/tmp/logzip_A8sdJFDE823h9/logfile.log"
    APP_LOG_WATCH
)

target_link_libraries(hdclog_device_utest PRIVATE
    $<BUILD_INTERFACE:intf_llt_pub>
    $<BUILD_INTERFACE:mmpa_headers>
    $<BUILD_INTERFACE:adump_headers>
    $<BUILD_INTERFACE:slog_headers>
    c_sec
    mmpa
    -Wl,-rpath,${TOP_DIR}/output/llt/c_sec/lib
    -Wl,-rpath,${CMAKE_CURRENT_BINARY_DIR}/../../../../../../../../llt_gcc4.9.3-prefix/src/llt_gcc4.9.3-build/abl/mmpa
    -Wl,-rpath,${CMAKE_CURRENT_BINARY_DIR}/../../../../../../../../llt_gcc4.9.3-prefix/src/llt_gcc4.9.3-build/abl/slog/slog/slog/host
    -lz
)

target_compile_options(hdclog_device_utest PRIVATE
    -Werror
)

set_target_properties(hdclog_device_utest
    PROPERTIES
    OUTPUT_NAME toolchain_hdclog_device_utest
    LIBRARY_OUTPUT_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/
)

run_llt_test(
    TARGET hdclog_device_utest
    TASK_NUM 1
)

###################################################################
set(INSTALL_BASE_DIR "")
set(INSTALL_INCLUDE_DIR include)
set(INSTALL_LIBRARY_DIR lib)
set(INSTALL_RUNTIME_DIR bin)
set(INSTALL_CONFIG_DIR  lib/cmake)

include(CMakePackageConfigHelpers)

install(TARGETS hdclog_device_utest OPTIONAL
    LIBRARY OPTIONAL DESTINATION ${INSTALL_LIBRARY_DIR}
    ARCHIVE OPTIONAL DESTINATION ${INSTALL_LIBRARY_DIR}
)
