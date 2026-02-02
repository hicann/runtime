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
    ${TSD_SRC_PATH}/tsdclient/src/aicpu_thread_mode_manager.cpp
    ${TSD_SRC_PATH}/tsdclient/src/client_manager.cpp
    ${TSD_SRC_PATH}/tsdclient/src/env_internal_api.cpp
    ${TSD_SRC_PATH}/tsdclient/src/env_internal_api.h
    ${TSD_SRC_PATH}/tsdclient/src/process_mode_base.cpp
    ${TSD_SRC_PATH}/tsdclient/src/process_mode_manager.cpp
    ${TSD_SRC_PATH}/tsdclient/src/process_mode_msg_parse.cpp
    ${TSD_SRC_PATH}/tsdclient/src/thread_mode_manager.cpp
    ${TSD_SRC_PATH}/tsdclient/src/tsd_client.cpp
    ${TSD_SRC_PATH}/tsdclient/src/stub/stub_dc.cpp
    ${TSD_SRC_PATH}/tsdclient/src/stub/stub_process_mode_nowin.cpp
)

set(TSD_COMMON_SRC_FILE
    ${TSD_SRC_PATH}/common/src/aicpu_package_process.cpp
    ${TSD_SRC_PATH}/common/src/aicpu_process_package_worker.cpp
    ${TSD_SRC_PATH}/common/src/aicpu_thread_package_worker.cpp
    ${TSD_SRC_PATH}/common/src/base_package_worker.cpp
    ${TSD_SRC_PATH}/common/src/common_sink_package_worker.cpp
    ${TSD_SRC_PATH}/common/src/dshape_package_worker.cpp
    ${TSD_SRC_PATH}/common/src/hdc_client.cpp
    ${TSD_SRC_PATH}/common/src/hdc_common.cpp
    ${TSD_SRC_PATH}/common/src/internal_api.cpp
    ${TSD_SRC_PATH}/common/src/log.cpp
    ${TSD_SRC_PATH}/common/src/message_parse_client.cpp
    ${TSD_SRC_PATH}/common/src/message_parse_interface.cpp
    ${TSD_SRC_PATH}/common/src/om_package_worker.cpp
    ${TSD_SRC_PATH}/common/src/package_process_config.cpp
    ${TSD_SRC_PATH}/common/src/package_verify.cpp
    ${TSD_SRC_PATH}/common/src/package_worker.cpp
    ${TSD_SRC_PATH}/common/src/package_worker_factory.cpp
    ${TSD_SRC_PATH}/common/src/package_worker_utils.cpp
    ${TSD_SRC_PATH}/common/src/process_util_common.cpp
    ${TSD_SRC_PATH}/common/src/runtime_package_worker.cpp
    ${TSD_SRC_PATH}/common/src/tsd_hash_verify.cpp
    ${TSD_SRC_PATH}/common/src/tsd_path_mgr.cpp
    ${TSD_SRC_PATH}/common/src/version_verify.cpp
    ${TSD_SRC_PATH}/common/src/message_parse_server.cpp
)
set(TSD_UT_TEST_SRC_FILE
    test/aicpu_package_process_utest.cpp
    test/aicpu_process_package_worker_utest.cpp
    test/aicpu_thread_mode_utest.cpp
    test/aicpu_thread_package_worker_utest.cpp
    test/client_manager_utest.cpp
    test/process_manager_utest.cpp
    test/thread_manager_utest.cpp
    test/dshape_package_worker_utest.cpp
    test/common_sink_package_worker_utest.cpp
    test/om_package_worker_utest.cpp
    test/package_process_config_utest.cpp
    test/package_verify_utest.cpp
    test/package_worker_factory_utest.cpp
    test/package_worker_utest.cpp
    test/tsdclient_utest.cpp
    test/version_verify_utest.cpp
    test/runtime_package_worker_utest.cpp
    test/process_util_utest.cpp
    test/package_worker_utils_utest.cpp
    test/hash_verify_utest.cpp
    test/path_mgr_utest.cpp
    test/log_utest.cpp
    test/internal_api_utest.cpp
    test/main.cpp
    ../stub/stub_mmpa.cpp
    ../stub/stub_appmon.cpp
    ../stub/stub_hdc.cpp
    ../stub/stub_driver.cpp
    ../stub/stub_openssl.cpp
    ../stub/stub_log.cpp
    ../stub/log_writer.cpp
    ../stub/stub_devdrv_runtime.cpp
    ../stub/stub_ezcom.cpp
    ../stub/error_manager.h
    ../stub/stub_SsToOwnerClient.cpp
    ../stub/stub_ProcMgrGrpOwnerClient.cpp
)
set(TSD_PROTO_SRC_FILE
    ${TSD_SRC_PATH}/common/tsd_message.proto
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
    ${TSD_SRC_PATH}/common/
    ${TSD_SRC_PATH}/tsdaemon/
    ${TSD_SRC_PATH}/tsdclient/
    ${CMAKE_BINARY_DIR}/proto/tsd_client_proto/
    ${TSD_SRC_PATH}/tsdclient/inc/
    ${RUNTIME_DIR}/include/
    ${RUNTIME_DIR}/src/tsd/
    ${RUNTIME_DIR}/src/tsd/client/common/inc/
    ${RUNTIME_DIR}/src/tsd/client/common/inc/stub/
    ${RUNTIME_DIR}/src/inc/
    ${RUNTIME_DIR}/pkg_inc/
    ${RUNTIME_DIR}/pkg_inc/profiling
    ../stub/
    ../stub/local_stub/
    ${RUNTIME_DIR}/src/dfx/error_manager/
    ${RUNTIME_DIR}/pkg_inc/aicpu_sched/
)

target_compile_definitions(tsd_client_utest PRIVATE
    LLT_MODE=1
    PLATFORM_MODE=1
    TDT_HOST_LIB
    google=ascend_private
)
target_link_libraries(tsd_client_utest PRIVATE
    $<BUILD_INTERFACE:intf_tsd_llt_pub>
    $<BUILD_INTERFACE:slog_headers>
    ascend_protobuf
    c_sec
    dl
    pthread
    c_sec_headers
)