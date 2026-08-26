# -----------------------------------------------------------------------------------------------------------
# Copyright (c) 2026 Huawei Technologies Co., Ltd.
# This program is free software, you can redistribute it and/or modify it under the terms and conditions of
# CANN Open Software License Agreement Version 2.0 (the "License").
# Please refer to the License for details. You may not use this file except in compliance with the License.
# THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
# INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
# See LICENSE in the root of the software repository for the full text of the License.
# -----------------------------------------------------------------------------------------------------------
# 本文件定义 tsdclient 的源文件列表与头文件包含目录，供 CMakeLists.txt include 使用。
# 使用前调用方需先定义 RUNTIME_TSD_DIR (指向 src/tsd) 与 RUNTIME_DIR (指向仓库根) 两个变量。

# tdt 公共源文件列表
set(tdt_common_files
    ${RUNTIME_TSD_DIR}/basic_component/device_comm/hdc_common.cpp
    ${RUNTIME_TSD_DIR}/basic_component/message_rsp_handler/message_parse_interface.cpp
    ${RUNTIME_TSD_DIR}/pub_facility/util_func/tsd_util_func.cpp
    ${RUNTIME_TSD_DIR}/pub_facility/util_func/tsd_sha256.cpp
    ${RUNTIME_TSD_DIR}/basic_component/device_comm/device_comm.cpp
    ${RUNTIME_TSD_DIR}/basic_component/device_comm/device_comm_agent.cpp
    ${RUNTIME_TSD_DIR}/basic_component/device_comm/hdc_client.cpp
    ${RUNTIME_TSD_DIR}/basic_component/message_builder/hdc_message_builder.cpp
    ${RUNTIME_TSD_DIR}/basic_component/capability/capability_manager.cpp
    ${RUNTIME_TSD_DIR}/basic_component/message_rsp_handler/message_parse_client.cpp
    ${RUNTIME_TSD_DIR}/basic_component/device_comm/version_verify.cpp
)

# tsdclient 源文件列表
set(tsdclient_all_sources
    ${RUNTIME_TSD_DIR}/interface/tsd_client.cpp
    ${RUNTIME_TSD_DIR}/tsdclient/src/client_manager.cpp
    ${RUNTIME_TSD_DIR}/tsdclient/src/process_mode_manager.cpp
    ${RUNTIME_TSD_DIR}/tsdclient/src/response_msg_dispatcher.cpp
    ${RUNTIME_TSD_DIR}/tsdclient/src/sub_process_controller.cpp
    ${RUNTIME_TSD_DIR}/tsdclient/src/tsd_process_controller.cpp
    ${RUNTIME_TSD_DIR}/tsdclient/src/thread_mode_manager.cpp
    ${RUNTIME_TSD_DIR}/pub_facility/env_manager/env_internal_api.cpp
    ${RUNTIME_TSD_DIR}/basic_component/package_manager/src/package_manager.cpp
    ${RUNTIME_TSD_DIR}/basic_component/package_manager/src/package_loader.cpp
    ${RUNTIME_TSD_DIR}/basic_component/package_manager/src/package_check_code_service.cpp
    ${RUNTIME_TSD_DIR}/basic_component/package_manager/src/package_sender.cpp
    ${RUNTIME_TSD_DIR}/basic_component/package_manager/src/package_env_info.cpp
    ${RUNTIME_TSD_DIR}/basic_component/package_manager/src/package_hash_store.cpp
    ${RUNTIME_TSD_DIR}/basic_component/package_manager/src/plugin_version_manager.cpp
    ${RUNTIME_TSD_DIR}/basic_component/package_manager/src/plugin_pkg_version.cpp
    ${RUNTIME_TSD_DIR}/basic_component/package_manager/src/package_worker.cpp
    ${RUNTIME_TSD_DIR}/basic_component/package_manager/src/package_worker_utils.cpp
    ${RUNTIME_TSD_DIR}/basic_component/package_manager/src/package_worker_factory.cpp
    ${RUNTIME_TSD_DIR}/basic_component/package_manager/src/package_verify.cpp
    ${RUNTIME_TSD_DIR}/basic_component/package_manager/src/base_package_worker.cpp
    ${RUNTIME_TSD_DIR}/basic_component/package_manager/src/aicpu_thread_package_worker.cpp
    ${RUNTIME_TSD_DIR}/basic_component/package_manager/src/aicpu_package_process.cpp
    ${RUNTIME_TSD_DIR}/basic_component/package_manager/src/package_process_config.cpp
    ${RUNTIME_TSD_DIR}/basic_component/package_manager/src/tsd_path_mgr.cpp
    ${tdt_common_files}
)

# tsdclient 头文件包含目录
set(tsdclient_include_dirs
    ${RUNTIME_TSD_DIR}/common/
    ${RUNTIME_TSD_DIR}/tsdclient
    ${RUNTIME_TSD_DIR}/tsdclient/inc/
    ${RUNTIME_TSD_DIR}/basic_component/package_manager/inc/
    ${RUNTIME_DIR}/include/
    ${RUNTIME_TSD_DIR}/
    ${RUNTIME_TSD_DIR}/pub_facility/tsdlog/
    ${RUNTIME_TSD_DIR}/pub_facility/util_func/
    ${RUNTIME_TSD_DIR}/pub_facility/env_manager/
    ${RUNTIME_TSD_DIR}/basic_component/device_comm/
    ${RUNTIME_TSD_DIR}/basic_component/message_builder/
    ${RUNTIME_TSD_DIR}/basic_component/capability/
    ${RUNTIME_TSD_DIR}/basic_component/message_rsp_handler/
    ${RUNTIME_DIR}/src/inc/
    ${RUNTIME_DIR}/pkg_inc/profiling
    ${RUNTIME_DIR}/pkg_inc/platform
    ${RUNTIME_DIR}/src/dfx/error_manager/
    ${RUNTIME_DIR}/pkg_inc/aicpu_sched/
    ${RUNTIME_DIR}/pkg_inc
)

# tsdclient 外部依赖打桩源文件列表
set(tsdclient_stub_sources
    ${RUNTIME_TSD_DIR}/stub/stub_external_deps.cpp
)
