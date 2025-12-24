###################################################################
set(libsysDeviceSrcFiles
    ${CMAKE_CURRENT_SOURCE_DIR}/log_sys_report.c
    ${CMAKE_CURRENT_SOURCE_DIR}/../sys_get/log_sys_get.c
    ${CMAKE_CURRENT_SOURCE_DIR}/../../../../common/log_path_mgr.c
    ${CMAKE_CURRENT_SOURCE_DIR}/../../../../common/log_print_selflog.c
    ${CMAKE_CURRENT_SOURCE_DIR}/../../../../common/config/log_config_list.c
    ${CMAKE_CURRENT_SOURCE_DIR}/../../../../common/config/log_config_block.c
    ${CMAKE_CURRENT_SOURCE_DIR}/../../../../common/config/log_config_common.c
    ${CMAKE_CURRENT_SOURCE_DIR}/../../../../common/config/log_config_api.c
    ${CMAKE_CURRENT_SOURCE_DIR}/../../../../common/driver/log_drv.c
    ${CMAKE_CURRENT_SOURCE_DIR}/../../../../common/driver/driver_api.c
    ${CMAKE_CURRENT_SOURCE_DIR}/../../../../../utils/log_file_util.c
    ${CMAKE_CURRENT_SOURCE_DIR}/../../../../../utils/log_system_api.c
    ${CMAKE_CURRENT_SOURCE_DIR}/../../../../../utils/log_print_syslog.c
)

set(libsysDeviceDir
    ${RUNTIME_DIR}/inc/driver
    ${RUNTIME_DIR}/abl/libc_sec/include
    ${TOOLAHCIN_LOG_DIR}/utils
    ${TOOLAHCIN_LOG_DIR}/shared
    ${TOOLAHCIN_LOG_DIR}/syslog/common
    ${TOOLAHCIN_LOG_DIR}/syslog/common/driver
    ${TOOLAHCIN_LOG_DIR}/syslog/common/config
    ${TOOLAHCIN_LOG_DIR}/syslog/slog/log_server
    ${TOOLAHCIN_LOG_DIR}/syslog/slog/log_server/log_post_process
    ${TOOLAHCIN_LOG_DIR}/syslog/slog/log_server/log_post_process/sys_report
    ${TOOLAHCIN_LOG_DIR}/syslog/slog/log_server/log_post_process/sys_get
    ${TOOLAHCIN_LOG_DIR}/syslog/slog/log_server/log_mgr/file_mgr
    ${TOOLAHCIN_LOG_DIR}/syslog/slog/log_server/log_mgr/buffer_mgr
    ${TOOLAHCIN_LOG_DIR}/syslog/slog/log_server/log_pre_process
    ${RUNTIME_DIR}/abl/adump/external
    ${CMAKE_CURRENT_SOURCE_DIR}/../app_report
    ${CMAKE_CURRENT_SOURCE_DIR}/../session_mgr
)

###################################################################
add_library(msn_report STATIC
    ${libsysDeviceSrcFiles})

target_include_directories(msn_report PRIVATE
    ${libsysDeviceDir})

target_compile_definitions(msn_report PRIVATE
    $<$<STREQUAL:${TARGET_SYSTEM_NAME},Windows>:OS_TYPE_DEF=1>
    $<$<NOT:$<STREQUAL:${TARGET_SYSTEM_NAME},Windows>>:OS_TYPE_DEF=0>
)

target_compile_options(msn_report PRIVATE
    -Wfloat-equal -Wextra
    $<$<CONFIG:Debug>:-g -O0>
    $<$<CONFIG:Release>:-Os>
    -Wunused
    -Wshadow
    -Wundef
    -Werror
    -fPIE
    -fstack-protector-strong
    -fno-common
    -fsigned-char
    -fno-strict-aliasing
    -fdata-sections
    -ffunction-sections
    -std=gnu11
)

target_link_options(msn_report PRIVATE
    -Wl,-z,relro,-z,now,-z,noexecstack
    -Wl,--gc-sections
)

target_link_libraries(msn_report PRIVATE
    $<BUILD_INTERFACE:intf_pub>
    $<BUILD_INTERFACE:mmpa_headers>
    $<BUILD_INTERFACE:adump_headers>
    $<BUILD_INTERFACE:slog_headers>
    $<BUILD_INTERFACE:adcore_headers>
    adcore
    log_server
    c_sec
)

set_target_properties(msn_report
    PROPERTIES
    OUTPUT_NAME msn_report
)
