# -----------------------------------------------------------------------------------------------------------
# Copyright (c) 2025 Huawei Technologies Co., Ltd.
# This program is free software, you can redistribute it and/or modify it under the terms and conditions of
# CANN Open Software License Agreement Version 2.0 (the "License").
# Please refer to the License for details. You may not use this file except in compliance with the License.
# THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
# INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
# See LICENSE in the root of the software repository for the full text of the License.
# -----------------------------------------------------------------------------------------------------------
####################### acp #######################
set(acpBinHeader
    ${RUNTIME_DIR}/src/dfx/error_manager
    ${RUNTIME_DIR}/include/driver
    ${RUNTIME_DIR}/src/dfx/msprof/inc/toolchain
    ${LIBC_SEC_HEADER}
    ../include
    ../../
    ../../app
    ../../common
    ../../common/argparse
    ../../common/cmd_log
    ../../common/utils
    ../../common/errno
    ../../common/logger
    ../../common/config
    ../../common/config/closed
    ../../common/singleton
    ../../common/platform
    ../../common/validation
    ../../msprofbin/include
    ../../profimpl/platform
    ../../profimpl/platform/closed
    ../../profimpl/adapter/inc
    ../../profimpl/collect/job_wrapper/include
    ../../depend/include/stub
    ../../msprof/dynamic_profiling/include/
    ../../driver/inc
    ../../transport
    ../../task_handle/include
    ${PROF_BASIC_DIR}/osal
)

set(acpBinCpp
    ../src/acp_bin.cpp
    ../src/acp_command.cpp
    ../src/acp_pipe_transfer.cpp
    ../../app/application.cpp
    ../../app/env_manager.cpp
    ../../common/argparse/argparser.cpp
    ../../common/utils/utils.cpp
    ../../common/cmd_log/cmd_log.cpp
    ../../common/validation/param_validation.cpp
    ../../common/validation/param_validation_closed.cpp
    ../../common/thread/thread.cpp
    ../../common/thread/thread_pool.cpp
    ../../common/socket/local_socket.cpp
    ../../common/json/json.cpp
    ../../common/platform/platform.cpp
    ../../common/platform/platform_closed.cpp
    ../../common/statistics/perf_count.cpp
    ../../driver/devmgmt/ai_drv_dev_api.cpp
    ../../driver/devmgmt/ai_drv_dev_api_closed.cpp
    ../../driver/channel/ai_drv_prof_api.cpp
    ../../depend/stub/error_manager/msprof_error_manager_stub.cpp
    ../../msprof/dynamic_profiling/src/dyn_prof_client.cpp
    ../../task_handle/src/task_relationship_mgr.cpp
    ../../profimpl/adapter/src/json_parser.cpp
    ../../profimpl/platform/platform_interface.cpp
    ../../common/config/closed/config_manager.cpp
    ../../profimpl/platform/cloud_v2_platform.cpp
    ../../profimpl/platform/david_platform.cpp
    ../../profimpl/platform/david_v121_platform.cpp
    ../../profimpl/platform/base_analyzer.cpp
    ../../profimpl/collect/job_wrapper/src/collection_job.cpp
    ../../profimpl/collect/job_wrapper/src/collection_register.cpp
    ../../profimpl/collect/job_wrapper/src/prof_comm_job.cpp
    ../../profimpl/collect/job_wrapper/src/prof_channel_manager.cpp
    ../../profimpl/collect/job_wrapper/src/prof_stars_job.cpp
    ../../transport/prof_channel.cpp
    ../../transport/uploader_mgr.cpp
    ../../transport/uploader.cpp
    ${PROF_BASIC_DIR}/osal/osal.c
)

add_executable(acp
    ${acpBinCpp}
)

target_include_directories(acp PRIVATE
    ${acpBinHeader}
    ${CMAKE_CURRENT_SOURCE_DIR}
)


target_compile_options(acp PRIVATE
    -fPIE
    -fno-strict-aliasing
    -fno-common
    -Wall
    $<$<CONFIG:Release>:-D_FORTIFY_SOURCE=2 -Os>
    $<$<CONFIG:Debug>:-D_FORTIFY_SOURCE=2 -Os>
    $<$<NOT:$<STREQUAL:${TARGET_SYSTEM_NAME},Windows>>:-Wfloat-equal>
    $<$<NOT:$<STREQUAL:${TARGET_SYSTEM_NAME},Windows>>:-Wextra>
    $<$<NOT:$<STREQUAL:${TARGET_SYSTEM_NAME},Windows>>:-Wno-unused-parameter>
    $<$<NOT:$<STREQUAL:${TARGET_SYSTEM_NAME},Windows>>:-Wno-missing-field-initializers>
    $<$<NOT:$<STREQUAL:${TARGET_SYSTEM_NAME},Windows>>:-Werror>
    $<$<AND:$<STREQUAL:${TARGET_SYSTEM_NAME},Windows>,$<STREQUAL:${CMAKE_CONFIGURATION_TYPES},Debug>>:/MTd>
    $<$<AND:$<STREQUAL:${TARGET_SYSTEM_NAME},Windows>,$<STREQUAL:${CMAKE_CONFIGURATION_TYPES},Release>>:/MT>
)

target_compile_definitions(acp PRIVATE
    $<$<STREQUAL:${TARGET_SYSTEM_NAME},Windows>:NOMINMAX>
)

target_link_options(acp PRIVATE
    -Wl,-Bsymbolic
    -Wl,--exclude-libs=ALL
    -Wl,--start-group
    -ldl
)

target_link_libraries(acp PRIVATE
    $<BUILD_INTERFACE:intf_pub>
    $<BUILD_INTERFACE:mmpa_headers>
    $<BUILD_INTERFACE:adump_headers>
    $<BUILD_INTERFACE:slog_headers>
    $<IF:$<STREQUAL:${TARGET_SYSTEM_NAME},Windows>,ascend_hal,ascend_hal_stub>
    c_sec
    slog
    mmpa
    ascend_hal_stub
)

set_target_properties(acp
    PROPERTIES
    OUTPUT_NAME acp
    LIBRARY_OUTPUT_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/
)

install(TARGETS acp OPTIONAL
    LIBRARY DESTINATION ${INSTALL_LIBRARY_DIR}
)

####################### acp end #######################


####################### libascend_profinj.so #######################
set(profinjCpp
    ${PROF_BASIC_DIR}/osal/osal.c
    ../src/acp_command.cpp
    ../src/acp_pipe_transfer.cpp
    ../src/acp_runtime_api.cpp
    ../src/acp_manager.cpp
    ../src/acp_api_plugin.cpp
    ../src/acp_compute_device_job.cpp
    ../src/op_transport.cpp
    ../src/op_data_manager.cpp
    ../src/op_analyzer.cpp
    ../src/op_analyzer_base.cpp
    ../src/op_analyzer_pmu.cpp
    ../src/op_analyzer_biu.cpp
    ../src/op_analyzer_pc_sampling.cpp
    ../../transport/uploader.cpp
    ../../transport/uploader_mgr.cpp
    ../../transport/prof_channel.cpp
    ../../profimpl/platform/platform_interface.cpp
    ../../profimpl/platform/cloud_v2_platform.cpp
    ../../common/config/closed/config_manager.cpp
    ../../profimpl/platform/david_platform.cpp
    ../../profimpl/platform/david_v121_platform.cpp
    ../../profimpl/platform/base_analyzer.cpp
    ../../profimpl/adapter/src/json_parser.cpp
    ../../profimpl/collect/job_wrapper/src/collection_job.cpp
    ../../profimpl/collect/job_wrapper/src/collection_register.cpp
    ../../profimpl/collect/job_wrapper/src/prof_comm_job.cpp
    ../../profimpl/collect/job_wrapper/src/prof_channel_manager.cpp
    ../../profimpl/collect/job_wrapper/src/prof_stars_job.cpp
    ../../profimpl/collect/job_wrapper/src/prof_biu_perf_job.cpp
    ../../common/platform/platform.cpp
    ../../common/platform/platform_closed.cpp
    ../../common/utils/utils.cpp
    ../../common/statistics/perf_count.cpp
    ../../common/json/json.cpp
    ../../common/cmd_log/cmd_log.cpp
    ../../common/validation/param_validation.cpp
    ../../common/validation/param_validation_closed.cpp
    ../../common/thread/thread.cpp
    ../../common/thread/thread_pool.cpp
    ../../common/socket/local_socket.cpp
    ../../common/argparse/argparser.cpp
    ../../driver/devmgmt/ai_drv_dev_api.cpp
    ../../driver/devmgmt/ai_drv_dev_api_closed.cpp
    ../../driver/channel/ai_drv_prof_api.cpp
    ../../driver/devmgmt/ai_drv_dsmi_api.cpp
    ../../driver/devmgmt/ai_drv_dsmi_api_closed.cpp
    ${PROF_BASIC_DIR}/osal/osal.c
    ../../app/application.cpp
    ../../app/env_manager.cpp
    ../../depend/stub/error_manager/msprof_error_manager_stub.cpp
    ../../msprof/dynamic_profiling/src/dyn_prof_client.cpp
    ../../task_handle/src/task_relationship_mgr.cpp
)

add_library(profinj SHARED
    ${profinjCpp}
)

target_include_directories(profinj PRIVATE
    ${RUNTIME_DIR}/src/inc/
    ${RUNTIME_DIR}/src/inc/external/
    ${RUNTIME_DIR}/src/dfx/msprof/inc/toolchain/
    ${RUNTIME_DIR}/src/dfx/msprof/inc/
    ${RUNTIME_DIR}/pkg_inc/runtime/
    ${LIBC_SEC_HEADER}
    ${RUNTIME_DIR}/include/driver/
    ${RUNTIME_DIR}/include/external/
    ${RUNTIME_DIR}/include/external/acl/
    ${RUNTIME_DIR}/src/dfx/error_manager/
    ${CMAKE_CURRENT_SOURCE_DIR}/../
    ${CMAKE_BINARY_DIR}/proto/profiler_proto/
    ${PROF_BASIC_DIR}/osal
    ../include/
    ../../
    ../../depend/include/stub
    ../../transport/
    ../../common/
    ../../common/logger
    ../../common/statistics
    ../../common/utils
    ../../common/validation
    ../../common/queue
    ../../common/json
    ../../common/config
    ../../common/config/closed
    ../../common/singleton
    ../../analyze/inc
    ../../profimpl/platform
    ../../profimpl/platform/closed
    ../../profimpl/adapter/inc
    ../../driver/inc
    ../../message
    ../../profimpl/collect/job_wrapper/include/
    ../../profapi/inc/
    ../../app
    ../../common/
    ../../common/argparse/
    ../../common/cmd_log
    ../../common/errno
    ../../msprof/dynamic_profiling/include/
    ../../task_handle/include
)

set_target_properties(profinj
    PROPERTIES
    OUTPUT_NAME $<IF:$<STREQUAL:${TARGET_SYSTEM_NAME},Windows>,libascend_profinj,ascend_profinj>
    LIBRARY_OUTPUT_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/
)

target_compile_options(profinj PRIVATE
    -fPIC
    -fstack-protector-all
    -fvisibility=hidden
    -fno-strict-aliasing
    -fno-common
    -Wfloat-equal
    -Wextra
    -Wall
    -Werror
    $<$<CONFIG:Release>:-D_FORTIFY_SOURCE=2 -Os>
    $<$<CONFIG:Debug>:-D_FORTIFY_SOURCE=2 -Os>
    $<$<AND:$<STREQUAL:${TARGET_SYSTEM_NAME},Windows>,$<STREQUAL:${CMAKE_CONFIGURATION_TYPES},Debug>>:/MTd>
    $<$<AND:$<STREQUAL:${TARGET_SYSTEM_NAME},Windows>,$<STREQUAL:${CMAKE_CONFIGURATION_TYPES},Release>>:/MT>
)

set (CMAKE_CXX_FLAGS "-std=c++17 -fvisibility-inlines-hidden" ${CMAKE_CXX_FLAGS})
set (CMAKE_C_FLAGS "-std=c11" ${CMAKE_C_FLAGS})

target_compile_definitions(profinj PRIVATE
    MSPROF_LIB
)

target_link_options(profinj PRIVATE
    -Wl,-z,relro,-z,now,-z,noexecstack
    -Wl,-Bsymbolic
    -Wl,--exclude-libs=ALL
)

target_link_libraries(profinj PRIVATE
    $<BUILD_INTERFACE:msprof_headers>
    $<BUILD_INTERFACE:slog_headers>
    $<BUILD_INTERFACE:mmpa_headers>
    $<BUILD_INTERFACE:adump_headers>
    $<IF:$<STREQUAL:${TARGET_SYSTEM_NAME},Windows>,ascend_hal,ascend_hal_stub>
    c_sec
    mmpa
    slog
    ascend_hal_stub
)

install(TARGETS profinj OPTIONAL
    LIBRARY DESTINATION ${INSTALL_LIBRARY_DIR}
)
####################### libascend_profinj.so ###########################
