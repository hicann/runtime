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

set(mdc310SlogdSrc
    ${LOG_SOURCE_PATH}/syslog/slog/slogd_argv.c
    ${LOG_SOURCE_PATH}/syslog/slog/slogd_main.c
    ${LOG_SOURCE_PATH}/syslog/slog/trace_server/slogd_trace_server.c
    ${LOG_SOURCE_PATH}/syslog/slog/log_server/log_mgr/level_mgr/slogd_shm_mgr.c
    ${LOG_SOURCE_PATH}/syslog/slog/log_server/slogd_service.c
    ${LOG_SOURCE_PATH}/syslog/slog/log_server/slogd_dev_mgr.c
    ${LOG_SOURCE_PATH}/syslog/slog/log_server/slogd_thread_mgr.c
    ${LOG_SOURCE_PATH}/syslog/slog/log_server/log_pre_process/cmd_process/slogd_collect_log.c
    ${LOG_SOURCE_PATH}/syslog/slog/log_server/log_classify/group_log/slogd_group_log.c
    ${LOG_SOURCE_PATH}/syslog/slog/log_server/log_mgr/file_mgr/log_to_file.c
    ${LOG_SOURCE_PATH}/syslog/slog/log_server/log_mgr/file_mgr/slogd_write_limit.c
    ${LOG_SOURCE_PATH}/syslog/slog/log_server/log_post_process/slogd_flush.c
    ${LOG_SOURCE_PATH}/syslog/slog/log_server/log_mgr/buffer_mgr/slogd_buffer.c
    ${LOG_SOURCE_PATH}/syslog/slog/log_server/log_pre_process/slogd_recv_core.c
    ${LOG_SOURCE_PATH}/syslog/slog/log_server/log_pre_process/slogd_parse_msg.c
    ${LOG_SOURCE_PATH}/syslog/slog/log_server/log_pre_process/slogd_recv_msg.c
    ${LOG_SOURCE_PATH}/syslog/slog/log_server/log_pre_process/log_communication/slogd_communication.c
    ${LOG_SOURCE_PATH}/syslog/slog/log_server/log_pre_process/log_communication/slogd_communication_iam.c
    ${LOG_SOURCE_PATH}/syslog/slog/log_server/log_mgr/file_mgr/slogd_compress.c
    ${LOG_SOURCE_PATH}/syslog/slog/log_server/log_classify/app_log/slogd_appnum_watch.c
    ${LOG_SOURCE_PATH}/syslog/slog/log_server/log_classify/app_log/slogd_applog_flush.c
    ${LOG_SOURCE_PATH}/syslog/slog/log_server/log_classify/app_log/slogd_applog_core.c
    ${LOG_SOURCE_PATH}/syslog/slog/log_server/log_classify/app_log/slogd_applog_report.c
    ${LOG_SOURCE_PATH}/syslog/slog/log_server/log_classify/event_log/slogd_eventlog.c
    ${LOG_SOURCE_PATH}/syslog/slog/log_server/log_classify/sys_log/slogd_syslog.c
    ${LOG_SOURCE_PATH}/syslog/slog/log_server/log_classify/sys_log/slogd_kernel_log.c
    ${LOG_SOURCE_PATH}/syslog/slog/log_server/log_mgr/level_mgr/operate_loglevel.c
    ${LOG_SOURCE_PATH}/syslog/slog/log_server/log_mgr/level_mgr/slogd_dynamic_level.c
    ${LOG_SOURCE_PATH}/syslog/slog/log_server/log_mgr/level_mgr/slogd_firmware_level.c
    ${LOG_SOURCE_PATH}/syslog/slog/log_server/log_mgr/level_mgr/log_level_parse.c
    ${LOG_SOURCE_PATH}/syslog/slog/log_server/log_classify/firmware_log/log_recv.c
    ${LOG_SOURCE_PATH}/syslog/slog/log_server/log_classify/firmware_log/log_recv_interface.c
    ${LOG_SOURCE_PATH}/syslog/slog/log_server/log_classify/firmware_log/slogd_firmware_log.c
    ${LOG_SOURCE_PATH}/syslog/slog/log_server/log_mgr/config_mgr/slogd_config_mgr.c
    ${LOG_SOURCE_PATH}/syslog/common/pm/log_pm_sig.c
    ${LOG_SOURCE_PATH}/syslog/common/log_path_mgr.c
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
    ${LOG_SOURCE_PATH}/utils/log_system_api.c
    ${LOG_SOURCE_PATH}/utils/msg_queue.c
    ${LOG_SOURCE_PATH}/utils/log_queue.c
    ${LOG_SOURCE_PATH}/utils/share_mem.c
    ${LOG_SOURCE_PATH}/utils/log_common.c
    ${LOG_SOURCE_PATH}/utils/log_buffer/log_ring_buffer.c
    ${LOG_SOURCE_PATH}/utils/log_compress/log_compress.c
    ${LOG_SOURCE_PATH}/utils/log_compress/log_software_zip.c
    ${LOG_SOURCE_PATH}/utils/log_compress/log_hardware_zip.c
    ${LOG_SOURCE_PATH}/utils/log_time.c
    ${LOG_SOURCE_PATH}/utils/log_file_util.c
    ${CMAKE_CURRENT_SOURCE_DIR}/log_compress/testcase/log_software_compress_func_utest.cc
    ${CMAKE_CURRENT_SOURCE_DIR}/log_compress/testcase/log_software_compress_excp_utest.cc
    ${UT_SOURCE_PATH}/mdc/stub/slogd_stub.c
    ${UT_SOURCE_PATH}/stub/self_log_stub.c
    ${UT_SOURCE_PATH}/stub/ascend_hal_stub.c
)

set(mdc310SlogdInc
    ${TOP_DIR}/abl/libc_sec/include
    ${LOG_SOURCE_PATH}/syslog/common
    ${LOG_SOURCE_PATH}/syslog/common/pm
    ${LOG_SOURCE_PATH}/syslog/common/config
    ${LOG_SOURCE_PATH}/syslog/common/driver
    ${LOG_SOURCE_PATH}/syslog/slog
    ${LOG_SOURCE_PATH}/utils
    ${LOG_SOURCE_PATH}/shared
    ${LOG_SOURCE_PATH}/utils/log_buffer
    ${LOG_SOURCE_PATH}/utils/log_compress
    ${TOP_DIR}/kernel/vendor/nve/inlcude/linux/mtd
    ${MDC_LINUX_SDK_DIR}/include
    ${TOP_DIR}/inc/driver
    ${TOP_DIR}/abl/adump/external
    ${LOG_SOURCE_PATH}/syslog/slog
    ${LOG_SOURCE_PATH}/syslog/slog/log_server
    ${LOG_SOURCE_PATH}/syslog/slog/log_server/log_classify/app_log
    ${LOG_SOURCE_PATH}/syslog/slog/log_server/log_classify/event_log
    ${LOG_SOURCE_PATH}/syslog/slog/log_server/log_mgr/level_mgr
    ${LOG_SOURCE_PATH}/syslog/slog/log_server/log_classify/firmware_log
    ${LOG_SOURCE_PATH}/syslog/slog/log_server/log_mgr/config_mgr
    ${LOG_SOURCE_PATH}/syslog/slog/log_server/log_classify/group_log
    ${LOG_SOURCE_PATH}/syslog/slog/log_server/log_classify/sys_log
    ${LOG_SOURCE_PATH}/syslog/slog/log_server/log_server
    ${LOG_SOURCE_PATH}/syslog/slog/log_server/log_post_process
    ${LOG_SOURCE_PATH}/syslog/slog/log_server/log_post_process/app_report
    ${LOG_SOURCE_PATH}/syslog/slog/log_server/log_post_process/session_mgr
    ${LOG_SOURCE_PATH}/syslog/slog/log_server/log_mgr/file_mgr
    ${LOG_SOURCE_PATH}/syslog/slog/log_server/log_mgr/buffer_mgr
    ${LOG_SOURCE_PATH}/syslog/slog/log_server/log_mgr
    ${LOG_SOURCE_PATH}/syslog/slog/log_server/log_pre_process
    ${LOG_SOURCE_PATH}/syslog/slog/log_server/log_pre_process/cmd_process
    ${LOG_SOURCE_PATH}/syslog/slog/log_server/log_pre_process/log_communication
    ${LOG_SOURCE_PATH}/syslog/slog/trace_server
    ${UT_SOURCE_PATH}/stub
    ${UT_SOURCE_PATH}/mdc/stub
    ${CMAKE_CURRENT_SOURCE_DIR}/log_compress/stub
    ${CMAKE_CURRENT_SOURCE_DIR}/log_time/stub
    ${CMAKE_CURRENT_SOURCE_DIR}/slogd_flush/stub
    ${CMAKE_CURRENT_SOURCE_DIR}/log_communication/stub/
    ${TOP_DIR}/manager/resmgr/secmgr/include
)


add_executable(mdc310_slogd_utest
    ${mdc310SlogdSrc}
)

target_include_directories(mdc310_slogd_utest PRIVATE
    ${mdc310SlogdInc}
)

target_compile_definitions(mdc310_slogd_utest PRIVATE
    _LOG_UT_
    __IDE_UT
    SOFTWARE_ZIP
    GETCLOCK_VIRTUAL
    APP_LOG_WATCH
    RC_MODE
    IAM
    LINUX_ETC_CONF
    GROUP_LOG
    IAM_MONITOR
    SLOGD_COLLECT
    GROUP_LOG
    PATH_ROOT="/tmp/mdc310_slogd_YSDdg1uy23c97qdi"
    FILE_PATH="/tmp/mdc310_slogd_YSDdg1uy23c97qdi/testcase.log"
    FILE_PATH_BAK="/tmp/mdc310_slogd_YSDdg1uy23c97qdi/testcase.log.bak"
    BOOTARGS_FILE_PATH="/tmp/mdc310_slogd_YSDdg1uy23c97qdi/cmdline"
    FILE_STUB_DIR="${UT_SOURCE_PATH}/mdc/310slogd/stub/"
    FILE_DIR="/tmp/mdc310_slogd_YSDdg1uy23c97qdi/log"
    SLOG_CONF_FILE_PATH="/tmp/mdc310_slogd_YSDdg1uy23c97qdi/slog.conf"
    CONF_PATH="${UT_SOURCE_PATH}/mdc/310slogd/stub/mdc310_slogd_YSDdg1uy23c97qdi.conf"
)

target_link_libraries(mdc310_slogd_utest PRIVATE
    $<BUILD_INTERFACE:intf_llt_pub>
    $<BUILD_INTERFACE:slog_headers>
    c_sec
    -lz
)

target_compile_options(mdc310_slogd_utest PRIVATE
    -Werror
)

set_target_properties(mdc310_slogd_utest
    PROPERTIES
    OUTPUT_NAME toolchain_mdc310_slogd_utest
    LIBRARY_OUTPUT_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/
)

run_llt_test(
    TARGET mdc310_slogd_utest
    TASK_NUM 1
)

###################################################################
set(INSTALL_BASE_DIR "")
set(INSTALL_INCLUDE_DIR include)
set(INSTALL_LIBRARY_DIR lib)
set(INSTALL_RUNTIME_DIR bin)
set(INSTALL_CONFIG_DIR  lib/cmake)

include(CMakePackageConfigHelpers)

install(TARGETS mdc310_slogd_utest OPTIONAL
    LIBRARY OPTIONAL DESTINATION ${INSTALL_LIBRARY_DIR}
    ARCHIVE OPTIONAL DESTINATION ${INSTALL_LIBRARY_DIR}
)