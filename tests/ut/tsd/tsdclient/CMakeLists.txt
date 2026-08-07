# -----------------------------------------------------------------------------------------------------------
# Copyright (c) 2025 Huawei Technologies Co., Ltd.
# This program is free software, you can redistribute it and/or modify it under the terms and conditions of
# CANN Open Software License Agreement Version 2.0 (the "License").
# Please refer to the License for details. You may not use this file except in compliance with the License.
# THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
# INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
# See LICENSE in the root of the software repository for the full text of the License.
# -----------------------------------------------------------------------------------------------------------
set(TSD_CLIENT_SRC_FILE
    ${TSD_SRC_PATH}/tsdclient/src/client_manager.cpp
    ${TSD_SRC_PATH}/pub_facility/env_manager/env_internal_api.cpp
    ${TSD_SRC_PATH}/pub_facility/env_manager/env_internal_api.h
    ${TSD_SRC_PATH}/tsdclient/src/process_mode_manager.cpp
    ${TSD_SRC_PATH}/tsdclient/src/response_msg_dispatcher.cpp
    ${TSD_SRC_PATH}/tsdclient/src/sub_process_controller.cpp
    ${TSD_SRC_PATH}/tsdclient/src/tsd_process_controller.cpp
    ${TSD_SRC_PATH}/tsdclient/src/thread_mode_manager.cpp
    ${TSD_SRC_PATH}/interface/tsd_client.cpp
    ${TSD_SRC_PATH}/common/stub/stub_dc.cpp
)

set(TSD_COMMON_SRC_FILE
    ${TSD_SRC_PATH}/basic_component/package_manager/src/aicpu_package_process.cpp
    ${TSD_SRC_PATH}/basic_component/package_manager/src/aicpu_thread_package_worker.cpp
    ${TSD_SRC_PATH}/basic_component/package_manager/src/base_package_worker.cpp
    ${TSD_SRC_PATH}/basic_component/device_comm/device_comm.cpp
    ${TSD_SRC_PATH}/basic_component/device_comm/device_comm_agent.cpp
    ${TSD_SRC_PATH}/basic_component/device_comm/hdc_client.cpp
    ${TSD_SRC_PATH}/basic_component/device_comm/hdc_common.cpp
    ${TSD_SRC_PATH}/basic_component/message_builder/hdc_message_builder.cpp
    ${TSD_SRC_PATH}/basic_component/capability/capability_manager.cpp
    ${TSD_SRC_PATH}/pub_facility/util_func/tsd_util_func.cpp
    ${TSD_SRC_PATH}/pub_facility/util_func/tsd_sha256.cpp
    ${TSD_SRC_PATH}/basic_component/message_rsp_handler/message_parse_client.cpp
    ${TSD_SRC_PATH}/basic_component/message_rsp_handler/message_parse_interface.cpp
    ${TSD_SRC_PATH}/basic_component/package_manager/src/package_manager.cpp
    ${TSD_SRC_PATH}/basic_component/package_manager/src/package_loader.cpp
    ${TSD_SRC_PATH}/basic_component/package_manager/src/package_check_code_service.cpp
    ${TSD_SRC_PATH}/basic_component/package_manager/src/package_sender.cpp
    ${TSD_SRC_PATH}/basic_component/package_manager/src/package_env_info.cpp
    ${TSD_SRC_PATH}/basic_component/package_manager/src/package_hash_store.cpp
    ${TSD_SRC_PATH}/basic_component/package_manager/src/plugin_version_manager.cpp
    ${TSD_SRC_PATH}/basic_component/package_manager/src/plugin_pkg_version.cpp
    ${TSD_SRC_PATH}/basic_component/package_manager/src/package_process_config.cpp
    ${TSD_SRC_PATH}/basic_component/package_manager/src/package_verify.cpp
    ${TSD_SRC_PATH}/basic_component/package_manager/src/package_worker.cpp
    ${TSD_SRC_PATH}/basic_component/package_manager/src/package_worker_factory.cpp
    ${TSD_SRC_PATH}/basic_component/package_manager/src/package_worker_utils.cpp
    ${TSD_SRC_PATH}/basic_component/package_manager/src/tsd_path_mgr.cpp
    ${TSD_SRC_PATH}/basic_component/device_comm/version_verify.cpp
)

# SHA256实现为性能关键路径，即使Debug构建也需要-O2优化
# ARM加速路径需要 -march=armv8-a+crypto，仅对该文件生效，避免影响其他代码
if(CMAKE_SYSTEM_PROCESSOR STREQUAL "aarch64")
    set_source_files_properties(
        ${TSD_SRC_PATH}/pub_facility/util_func/tsd_sha256.cpp
        PROPERTIES COMPILE_FLAGS "-O2 -march=armv8-a+crypto"
    )
else()
    set_source_files_properties(
        ${TSD_SRC_PATH}/pub_facility/util_func/tsd_sha256.cpp
        PROPERTIES COMPILE_FLAGS "-O2"
    )
endif()

set(TSD_UT_TEST_SRC_FILE
    ../interface/tsd_client_utest.cpp
    ../basic_component/package_manager/aicpu_package_process_utest.cpp
    ../basic_component/package_manager/aicpu_thread_package_worker_utest.cpp
    ../basic_component/package_manager/base_package_worker_utest.cpp
    ../basic_component/package_manager/package_check_code_service_utest.cpp
    ../basic_component/package_manager/package_env_info_utest.cpp
    ../basic_component/package_manager/package_hash_store_utest.cpp
    ../basic_component/package_manager/package_loader_utest.cpp
    ../basic_component/package_manager/package_manager_utest.cpp
    ../basic_component/package_manager/package_sender_utest.cpp
    ../basic_component/package_manager/plugin_pkg_version_utest.cpp
    ../basic_component/package_manager/plugin_version_manager_utest.cpp
    ../basic_component/capability/capability_manager_utest.cpp
    client_manager_utest.cpp
    process_mode_manager_utest.cpp
    response_msg_dispatcher_utest.cpp
    sub_process_controller_utest.cpp
    tsd_process_controller_utest.cpp
    thread_mode_manager_utest.cpp
    ../basic_component/package_manager/package_process_config_utest.cpp
    ../basic_component/package_manager/package_verify_utest.cpp
    ../basic_component/package_manager/package_worker_factory_utest.cpp
    ../basic_component/package_manager/package_worker_utest.cpp
    ../basic_component/device_comm/version_verify_utest.cpp
    ../basic_component/package_manager/package_worker_utils_utest.cpp
    ../basic_component/package_manager/tsd_path_mgr_utest.cpp
    ../pub_facility/util_func/tsd_util_func_utest.cpp
    ../basic_component/message_rsp_handler/message_parse_client_utest.cpp
    ../pub_facility/util_func/tsd_sha256_utest.cpp
    ../pub_facility/env_manager/env_internal_api_utest.cpp
    ../basic_component/device_comm/hdc_client_utest.cpp
    ../basic_component/device_comm/hdc_common_utest.cpp
    ../basic_component/message_builder/hdc_message_builder_utest.cpp
    ../basic_component/device_comm/device_comm_utest.cpp
    ../basic_component/device_comm/device_comm_agent_utest.cpp
    ../basic_component/message_rsp_handler/message_parse_interface_utest.cpp
    ../common/stub/stub_dc_utest.cpp
    ../common/main.cpp
    ../common/common_util_func.cpp
    ../stub/stub_server_reply.cpp
    ../stub/stub_server_msg_impl.cpp
    ../stub/stub_server_msg_proc_def.cpp
    ../stub/stub_mmpa.cpp
    ../stub/stub_hdc.cpp
    ../stub/stub_driver.cpp
    ../stub/stub_log.cpp
    ../stub/stub_devdrv_runtime.cpp
    ../stub/error_manager.h
)
set(TSD_PROTO_SRC_FILE
    ${TSD_SRC_PATH}/pub_facility/proto/tsd_message.proto
)
file(GLOB_RECURSE RTOTO_LIST RELATIVE ${CMAKE_CURRENT_LIST_DIR}
    ${TSD_PROTO_SRC_FILE}
)
protobuf_generate(tsd_client_proto PROTO_SRCS PROTO_HDRS ${RTOTO_LIST})

add_executable(tsd_client_utest
    ${TSD_CLIENT_SRC_FILE}
    ${TSD_COMMON_SRC_FILE}
    ${PROTO_SRCS}
    ${TSD_UT_TEST_SRC_FILE}
)

target_include_directories(tsd_client_utest PRIVATE
    ${CMAKE_CURRENT_LIST_DIR}/../common
    ${TSD_SRC_PATH}/common/
    ${TSD_SRC_PATH}/tsdclient/
    ${CMAKE_BINARY_DIR}/proto/tsd_client_proto/
    ${TSD_SRC_PATH}/tsdclient/inc/
    ${TSD_SRC_PATH}/basic_component/package_manager/inc/
    ${RUNTIME_DIR}/include/
    ${RUNTIME_DIR}/src/tsd/
    ${RUNTIME_DIR}/src/tsd/pub_facility/tsdlog/
    ${RUNTIME_DIR}/src/tsd/pub_facility/util_func/
    ${RUNTIME_DIR}/src/tsd/pub_facility/env_manager/
    ${RUNTIME_DIR}/src/tsd/basic_component/device_comm/
    ${RUNTIME_DIR}/src/tsd/basic_component/message_builder/
    ${RUNTIME_DIR}/src/tsd/basic_component/capability/
    ${RUNTIME_DIR}/src/tsd/basic_component/message_rsp_handler/
    ${RUNTIME_DIR}/src/tsd/client/common/inc/
    ${RUNTIME_DIR}/src/tsd/client/common/inc/stub/
    ${RUNTIME_DIR}/src/inc/
    ${RUNTIME_DIR}/src/platform/
    ${RUNTIME_DIR}/pkg_inc/runtime/
    ${RUNTIME_DIR}/pkg_inc/
    ${RUNTIME_DIR}/pkg_inc/profiling
    ${RUNTIME_DIR}/pkg_inc/platform
    ../stub/
    ${RUNTIME_DIR}/src/dfx/error_manager/
    ${RUNTIME_DIR}/pkg_inc/aicpu_sched/
)

target_compile_definitions(tsd_client_utest PRIVATE
    LLT_MODE=1
    PLATFORM_MODE=1
    TDT_HOST_LIB
    TSD_HOST_LIB
    tsd_UT
    NOT_COVERAGE_BY_UT
    google=ascend_private
)

target_link_libraries(tsd_client_utest PRIVATE
    $<BUILD_INTERFACE:intf_tsd_llt_pub>
    $<BUILD_INTERFACE:slog_headers>
    ascend_protobuf_static
    c_sec
    dl
    pthread
    c_sec_headers
    platform
)

add_dependencies(tsd_client_utest platform)

if(UNIX AND NOT APPLE)
    set_target_properties(tsd_client_utest PROPERTIES
        BUILD_RPATH "\$ORIGIN/../../../../src/platform"
    )
    target_link_options(tsd_client_utest PRIVATE "-Wl,--disable-new-dtags")
endif()
