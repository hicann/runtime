# -----------------------------------------------------------------------------------------------------------
# Copyright (c) 2025 Huawei Technologies Co., Ltd.
# This program is free software, you can redistribute it and/or modify it under the terms and conditions of
# CANN Open Software License Agreement Version 2.0 (the "License").
# Please refer to the License for details. You may not use this file except in compliance with the License.
# THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
# INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
# See LICENSE in the root of the software repository for the full text of the License.
# -----------------------------------------------------------------------------------------------------------
#  cmakelist for adx st
set(SRC_CODE_ROOT_PATH ${TOP_DIR}/abl/adump)
set(LLT_CODE_ROOT_PATH ${TOP_DIR}/tests/ut/adump/ut)

set(adxSrcList
    ${SRC_CODE_ROOT_PATH}/adcore/hdc/hdc_api.cpp
    ${SRC_CODE_ROOT_PATH}/adcore/adcore_api.cpp
    ${SRC_CODE_ROOT_PATH}/adcore/device/adx_dsmi.cpp
    ${SRC_CODE_ROOT_PATH}/adcore/common/memory_utils.cpp
    ${SRC_CODE_ROOT_PATH}/adcore/common/thread.cpp
    ${SRC_CODE_ROOT_PATH}/adcore/common/thread_comm.cpp
    ${SRC_CODE_ROOT_PATH}/adcore/commopts/adx_comm_opt_manager.cpp
    ${SRC_CODE_ROOT_PATH}/adcore/commopts/hdc_comm_opt.cpp
    ${SRC_CODE_ROOT_PATH}/adcore/component/adx_server_manager.cpp
    ${SRC_CODE_ROOT_PATH}/adcore/epoll/adx_hdc_epoll.cpp
    ${SRC_CODE_ROOT_PATH}/adcore/protocol/adx_msg_proto.cpp
    ${SRC_CODE_ROOT_PATH}/adcore/device/adx_device.cpp
    ${SRC_CODE_ROOT_PATH}/adcore/device/adx_hdc_device.cpp
    ${SRC_CODE_ROOT_PATH}/adcore/device/adx_sock_device.cpp
    ${SRC_CODE_ROOT_PATH}/adcore/adx_api.cpp
    ${SRC_CODE_ROOT_PATH}/adcore/commopts/sock_api.cpp
    ${SRC_CODE_ROOT_PATH}/adcore/commopts/sock_comm_opt.cpp
    ${SRC_CODE_ROOT_PATH}/adump/adx_dump_process.cpp
    ${SRC_CODE_ROOT_PATH}/adump/adx_dump_record.cpp
    ${SRC_CODE_ROOT_PATH}/adump/common/adump_dsmi.cpp
    ${SRC_CODE_ROOT_PATH}/adcore/epoll/adx_sock_epoll.cpp
    ${SRC_CODE_ROOT_PATH}/adcore/common/file_utils.cpp
    ${SRC_CODE_ROOT_PATH}/adcore/common/string_utils.cpp
    ${SRC_CODE_ROOT_PATH}/adcore/common/create_func.cpp
    ${SRC_CODE_ROOT_PATH}/adcore/component/server_register.cpp
    ${SRC_CODE_ROOT_PATH}/adcore/component/adx_component_api_c.cpp
    ${SRC_CODE_ROOT_PATH}/adump/device/adx_dump_hdc_helper.cpp
    ${SRC_CODE_ROOT_PATH}/adump/host/adx_dump_receive.cpp
    ${SRC_CODE_ROOT_PATH}/adump/device/adx_dump_hdc_api.cpp
    ${SRC_CODE_ROOT_PATH}/adump/device/adx_dump_soc_helper.cpp
    ${SRC_CODE_ROOT_PATH}/adump/device/adx_datadump_server_soc.cpp
    ${SRC_CODE_ROOT_PATH}/adcore/component/adx_common_component.cpp
    ${SRC_CODE_ROOT_PATH}/adump/host/adx_datadump_server.cpp
    ${SRC_CODE_ROOT_PATH}/adump/common/sys_utils.cpp
)

set(adxHeaders
    ${CMAKE_CURRENT_SOURCE_DIR}
    ${CMAKE_CURRENT_SOURCE_DIR}/stub
    ${SRC_CODE_ROOT_PATH}/external
    ${SRC_CODE_ROOT_PATH}/adcore
    ${SRC_CODE_ROOT_PATH}/adcore/common
    ${SRC_CODE_ROOT_PATH}/adcore/log
    ${SRC_CODE_ROOT_PATH}/adcore/commopts
    ${SRC_CODE_ROOT_PATH}/adcore/component
    ${SRC_CODE_ROOT_PATH}/adcore/protocol
    ${SRC_CODE_ROOT_PATH}/adcore/device
    ${SRC_CODE_ROOT_PATH}/adcore/hdc
    ${SRC_CODE_ROOT_PATH}/adump
    ${SRC_CODE_ROOT_PATH}/adump/device
    ${SRC_CODE_ROOT_PATH}/adump/host
    ${SRC_CODE_ROOT_PATH}/adump/common
    ${TOP_DIR}/inc/driver
    ${TOP_DIR}/abl/libc_sec/include
    ${TOP_DIR}/ace/npuruntime/acl/inc/external/acl/
    ${CMAKE_CURRENT_SOURCE_DIR}/common_stub
    ${ASCEND_PROTOBUF_SHARED_INCLUDE_DIR}
    ${TOP_DIR}/metadef/inc/external
    ${TOP_DIR}/ace/npuruntime/runtime/platform/inc
    ${CMAKE_BINARY_DIR}/proto/adump_base_proto
    ${TOP_DIR}/abl/msprof/inc
)

set(adxStSrcList
    ${CMAKE_CURRENT_SOURCE_DIR}/stub/ide_hdc_stub.cc
    ${CMAKE_CURRENT_SOURCE_DIR}/stub/ide_dsmi_stub.cc
    ${CMAKE_CURRENT_SOURCE_DIR}/stub/ide_daemon_stub.cc
    ${CMAKE_CURRENT_SOURCE_DIR}/stub/peripheral_aip_stub.c
    ${CMAKE_CURRENT_SOURCE_DIR}/stub/mmpa_stub.c
    ${CMAKE_CURRENT_SOURCE_DIR}/common_stub/mmpa_stub.cc
    ${CMAKE_CURRENT_SOURCE_DIR}/common_stub/sec_stub.cc
    ${CMAKE_CURRENT_SOURCE_DIR}/testcase/adx_data_dump_stest.cc
    ${CMAKE_CURRENT_SOURCE_DIR}/testcase/adx_api_stest.cc
    ${CMAKE_CURRENT_SOURCE_DIR}/testcase/adx_commopt_manager_stest.cc
    ${CMAKE_CURRENT_SOURCE_DIR}/testcase/adx_dump_server_stest.cc
    ${CMAKE_CURRENT_SOURCE_DIR}/testcase/adx_hdc_interface_stest.cc
    ${CMAKE_CURRENT_SOURCE_DIR}/testcase/adx_msg_proto_stest.cc
    ${CMAKE_CURRENT_SOURCE_DIR}/testcase/adx_server_manager_stest.cc
    ${CMAKE_CURRENT_SOURCE_DIR}/testcase/adx_dump_soc_helper_stest.cc
)

add_executable(adx_host_stest
    ${adxStSrcList}
    ${adxSrcList}
)

target_include_directories(adx_host_stest PRIVATE
    ${adxHeaders}
)

add_dependencies(adx_host_stest adump_base_proto)

target_compile_definitions(adx_host_stest PRIVATE
    -DADUMP_SOC_HOST=1
    __IDE_ST
    IDE_DEBUG
    CFG_BUILD_DEBUG
    IDE_DAEMON_DEVICE
    IDE_DAEMON_CLOUD
    IDE_DAEMON_RC
    PLATFORM_MONITOR
    FW_UPGRADE_LOG=\"${LOCAL_PATH}/stub/firmware_upgrade_progress.log\"
)

target_link_libraries(adx_host_stest PRIVATE
    $<BUILD_INTERFACE:adx_host_stestonetrack_pub>
    c_sec_static
)

target_compile_options(adx_host_stest PRIVATE
    -Wall
    -Werror
    -Wextra
)

target_link_options(adx_host_stest PRIVATE
)

add_library(adx_host_stestonetrack_pub INTERFACE)

target_link_libraries(adx_host_stestonetrack_pub INTERFACE
    $<BUILD_INTERFACE:intf_llt_pub>
    $<BUILD_INTERFACE:mmpa_headers>
    $<BUILD_INTERFACE:adump_headers>
    $<BUILD_INTERFACE:slog_headers>
    $<BUILD_INTERFACE:runtime_headers>
    -Wl,--as-needed
    -lpthread
)

run_llt_test(
    TARGET adx_host_stest
    TASK_NUM 1
)

# device stest
set(adxSrcList
    ${SRC_CODE_ROOT_PATH}/adcore/hdc/hdc_api.cpp
    ${SRC_CODE_ROOT_PATH}/adcore/adcore_api.cpp
    ${SRC_CODE_ROOT_PATH}/adcore/common/thread.cpp
    ${SRC_CODE_ROOT_PATH}/adcore/common/thread_comm.cpp
    ${SRC_CODE_ROOT_PATH}/adcore/common/memory_utils.cpp
    ${SRC_CODE_ROOT_PATH}/adcore/common/file_utils.cpp
    ${SRC_CODE_ROOT_PATH}/adcore/common/string_utils.cpp
    ${SRC_CODE_ROOT_PATH}/adcore/common/create_func.cpp
    ${SRC_CODE_ROOT_PATH}/adcore/component/server_register.cpp
    ${SRC_CODE_ROOT_PATH}/adcore/component/adx_component_api_c.cpp
    ${SRC_CODE_ROOT_PATH}/adcore/device/adx_dsmi.cpp
    ${SRC_CODE_ROOT_PATH}/adcore/device/adx_device.cpp
    ${SRC_CODE_ROOT_PATH}/adcore/device/adx_sock_device.cpp
    ${SRC_CODE_ROOT_PATH}/adcore/device/adx_hdc_device.cpp
    ${SRC_CODE_ROOT_PATH}/adcore/commopts/adx_comm_opt_manager.cpp
    ${SRC_CODE_ROOT_PATH}/adcore/commopts/hdc_comm_opt.cpp
    ${SRC_CODE_ROOT_PATH}/adcore/commopts/sock_api.cpp
    ${SRC_CODE_ROOT_PATH}/adcore/commopts/sock_comm_opt.cpp
    ${SRC_CODE_ROOT_PATH}/adcore/component/adx_server_manager.cpp
    ${SRC_CODE_ROOT_PATH}/adcore/component/adx_common_component.cpp
    ${SRC_CODE_ROOT_PATH}/adump/host/adx_dump_receive.cpp
    ${SRC_CODE_ROOT_PATH}/adump/adx_dump_process.cpp
    ${SRC_CODE_ROOT_PATH}/adump/adx_dump_record.cpp
    ${SRC_CODE_ROOT_PATH}/adump/common/adump_dsmi.cpp
    ${SRC_CODE_ROOT_PATH}/adcore/epoll/adx_hdc_epoll.cpp
    ${SRC_CODE_ROOT_PATH}/adcore/epoll/adx_sock_epoll.cpp
    ${SRC_CODE_ROOT_PATH}/adcore/protocol/adx_msg_proto.cpp
    ${SRC_CODE_ROOT_PATH}/adcore/adx_api.cpp
    ${SRC_CODE_ROOT_PATH}/adump/host/adx_datadump_callback.cpp
    ${SRC_CODE_ROOT_PATH}/adump/host/adx_datadump_server_stub.cpp
)

set(adxDevSrcList
    ${SRC_CODE_ROOT_PATH}/adump/device/adx_dump_soc_helper.cpp
    ${SRC_CODE_ROOT_PATH}/adump/device/adx_dump_soc_api.cpp
    ${SRC_CODE_ROOT_PATH}/adump/device/adx_datadump_server_soc.cpp
    ${adxSrcList}
)

set(adxDevStSrcList
    ${CMAKE_CURRENT_SOURCE_DIR}/stub/ide_hdc_stub.cc
    ${CMAKE_CURRENT_SOURCE_DIR}/stub/ide_dsmi_stub.cc
    ${CMAKE_CURRENT_SOURCE_DIR}/stub/ide_daemon_stub.cc
    ${CMAKE_CURRENT_SOURCE_DIR}/stub/peripheral_aip_stub.c
    ${CMAKE_CURRENT_SOURCE_DIR}/stub/mmpa_stub.c
    ${CMAKE_CURRENT_SOURCE_DIR}/common_stub/mmpa_stub.cc
    ${CMAKE_CURRENT_SOURCE_DIR}/common_stub/sec_stub.cc
    ${CMAKE_CURRENT_SOURCE_DIR}/testcase/adx_dump_record_stest.cc
    ${CMAKE_CURRENT_SOURCE_DIR}/testcase/adx_data_dump_soc_stest.cc
    ${CMAKE_CURRENT_SOURCE_DIR}/testcase/file_utils_stest.cc
    ${CMAKE_CURRENT_SOURCE_DIR}/testcase/create_func_stest.cc
    ${CMAKE_CURRENT_SOURCE_DIR}/testcase/adx_server_register_stest.cc
    ${CMAKE_CURRENT_SOURCE_DIR}/testcase/adx_component_api_c_stest.cc
    ${CMAKE_CURRENT_SOURCE_DIR}/testcase/adx_common_component_stest.cc
    ${CMAKE_CURRENT_SOURCE_DIR}/testcase/adx_dump_callback_stest.cc
    ${CMAKE_CURRENT_SOURCE_DIR}/testcase/adx_dump_server_stub_stest.cc
    ${CMAKE_CURRENT_SOURCE_DIR}/testcase/acl_dump_stest.cc
    ${CMAKE_CURRENT_SOURCE_DIR}/testcase/adx_sock_device_stest.cc
    ${CMAKE_CURRENT_SOURCE_DIR}/testcase/adx_sock_epoll_stest.cc
    ${CMAKE_CURRENT_SOURCE_DIR}/testcase/adx_hdc_epoll_stest.cc
    ${adxDevSrcList}
)

set(adxDeviceHeaders
    ${CMAKE_CURRENT_SOURCE_DIR}
    ${CMAKE_CURRENT_SOURCE_DIR}/stub
    ${SRC_CODE_ROOT_PATH}/external
    ${SRC_CODE_ROOT_PATH}/adcore
    ${SRC_CODE_ROOT_PATH}/adcore/common
    ${SRC_CODE_ROOT_PATH}/adcore/log
    ${SRC_CODE_ROOT_PATH}/adcore/commopts
    ${SRC_CODE_ROOT_PATH}/adcore/component
    ${SRC_CODE_ROOT_PATH}/adcore/protocol
    ${SRC_CODE_ROOT_PATH}/adcore/device
    ${SRC_CODE_ROOT_PATH}/adcore/hdc
    ${SRC_CODE_ROOT_PATH}/adump
    ${SRC_CODE_ROOT_PATH}/adump/device
    ${SRC_CODE_ROOT_PATH}/adump/host
    ${SRC_CODE_ROOT_PATH}/adump/common
    ${TOP_DIR}/inc/driver
    ${TOP_DIR}/abl/libc_sec/include
    ${TOP_DIR}/inc/toolchain
    ${TOP_DIR}/abl/slog/shared
    ${TOP_DIR}/abl/slog/utils
    ${TOP_DIR}/abl/slog/syslog/slog/src
    ${TOP_DIR}/ace/npuruntime/acl/inc/external/acl/
    ${CMAKE_CURRENT_SOURCE_DIR}/common_stub
    ${CMAKE_CURRENT_SOURCE_DIR}/kmc/include
    ${ASCEND_PROTOBUF_SHARED_INCLUDE_DIR}
    ${TOP_DIR}/inc/external/acl
    ${TOP_DIR}/metadef/inc/external
    ${TOP_DIR}/ace/npuruntime/runtime/platform/inc
    ${CMAKE_BINARY_DIR}/proto/adump_base_proto
    ${TOP_DIR}/abl/msprof/inc
)

add_executable(adx_device_stest
    ${adxDevStSrcList}
)

add_dependencies(adx_device_stest adump_base_proto)

target_include_directories(adx_device_stest PRIVATE
    ${adxDeviceHeaders}
)

target_compile_definitions(adx_device_stest PRIVATE
    -DADUMP_SOC_HOST=1
    __IDE_ST
    IDE_DEBUG
    CFG_BUILD_DEBUG
    IDE_DAEMON_DEVICE
    IDE_DAEMON_RC
)

target_link_libraries(adx_device_stest PRIVATE
    $<BUILD_INTERFACE:adx_device_stestonetrack_pub>
)

target_compile_options(adx_device_stest PRIVATE
    -Wall
    -Werror
    -Wextra
)

target_link_options(adx_device_stest PRIVATE
)

add_library(adx_device_stestonetrack_pub INTERFACE)

target_link_libraries(adx_device_stestonetrack_pub INTERFACE
    $<BUILD_INTERFACE:intf_llt_pub>
    $<BUILD_INTERFACE:mmpa_headers>
    $<BUILD_INTERFACE:adump_headers>
    $<BUILD_INTERFACE:slog_headers>
    $<BUILD_INTERFACE:runtime_headers>
    -Wl,--as-needed
    -lpthread
)

run_llt_test(
    TARGET adx_device_stest
    TASK_NUM 1
)

# api stest
set(adxSrcList
    ${SRC_CODE_ROOT_PATH}/adcore/hdc/hdc_api.cpp
    ${SRC_CODE_ROOT_PATH}/adcore/adcore_api.cpp
    ${SRC_CODE_ROOT_PATH}/adcore/common/thread.cpp
    ${SRC_CODE_ROOT_PATH}/adcore/common/thread_comm.cpp
    ${SRC_CODE_ROOT_PATH}/adcore/common/memory_utils.cpp
    ${SRC_CODE_ROOT_PATH}/adcore/common/file_utils.cpp
    ${SRC_CODE_ROOT_PATH}/adcore/common/string_utils.cpp
    ${SRC_CODE_ROOT_PATH}/adcore/common/create_func.cpp
    ${SRC_CODE_ROOT_PATH}/adcore/component/server_register.cpp
    ${SRC_CODE_ROOT_PATH}/adcore/component/adx_component_api_c.cpp
    ${SRC_CODE_ROOT_PATH}/adcore/device/adx_dsmi.cpp
    ${SRC_CODE_ROOT_PATH}/adcore/device/adx_device.cpp
    ${SRC_CODE_ROOT_PATH}/adcore/device/adx_sock_device.cpp
    ${SRC_CODE_ROOT_PATH}/adcore/device/adx_hdc_device.cpp
    ${SRC_CODE_ROOT_PATH}/adcore/commopts/adx_comm_opt_manager.cpp
    ${SRC_CODE_ROOT_PATH}/adcore/commopts/hdc_comm_opt.cpp
    ${SRC_CODE_ROOT_PATH}/adcore/commopts/sock_api.cpp
    ${SRC_CODE_ROOT_PATH}/adcore/commopts/sock_comm_opt.cpp
    ${SRC_CODE_ROOT_PATH}/adcore/component/adx_server_manager.cpp
    ${SRC_CODE_ROOT_PATH}/adcore/component/adx_common_component.cpp
    ${SRC_CODE_ROOT_PATH}/adump/host/adx_dump_receive.cpp
    ${SRC_CODE_ROOT_PATH}/adump/adx_dump_process.cpp
    ${SRC_CODE_ROOT_PATH}/adump/adx_dump_record.cpp
    ${SRC_CODE_ROOT_PATH}/adump/common/adump_dsmi.cpp
    ${SRC_CODE_ROOT_PATH}/adcore/epoll/adx_hdc_epoll.cpp
    ${SRC_CODE_ROOT_PATH}/adcore/epoll/adx_sock_epoll.cpp
    ${SRC_CODE_ROOT_PATH}/adcore/protocol/adx_msg_proto.cpp
    ${SRC_CODE_ROOT_PATH}/adcore/adx_api.cpp
)

set(adxApiSrcList
    ${adxSrcList}
)

set(adxApiStSrcList
    ${CMAKE_CURRENT_SOURCE_DIR}/stub/ide_hdc_stub.cc
    ${CMAKE_CURRENT_SOURCE_DIR}/stub/ide_dsmi_stub.cc
    ${CMAKE_CURRENT_SOURCE_DIR}/stub/ide_daemon_stub.cc
    ${CMAKE_CURRENT_SOURCE_DIR}/stub/peripheral_aip_stub.c
    ${CMAKE_CURRENT_SOURCE_DIR}/stub/mmpa_stub.c
    ${CMAKE_CURRENT_SOURCE_DIR}/common_stub/mmpa_stub.cc
    ${CMAKE_CURRENT_SOURCE_DIR}/common_stub/sec_stub.cc
    ${adxApiSrcList}
)

set(adxApiHeaders
    ${CMAKE_CURRENT_SOURCE_DIR}
    ${CMAKE_CURRENT_SOURCE_DIR}/stub
    ${SRC_CODE_ROOT_PATH}/external
    ${SRC_CODE_ROOT_PATH}/adcore
    ${SRC_CODE_ROOT_PATH}/adcore/common
    ${SRC_CODE_ROOT_PATH}/adcore/log
    ${SRC_CODE_ROOT_PATH}/adcore/commopts
    ${SRC_CODE_ROOT_PATH}/adcore/component
    ${SRC_CODE_ROOT_PATH}/adcore/protocol
    ${SRC_CODE_ROOT_PATH}/adcore/device
    ${SRC_CODE_ROOT_PATH}/adcore/hdc
    ${SRC_CODE_ROOT_PATH}/adump
    ${SRC_CODE_ROOT_PATH}/adump/device
    ${SRC_CODE_ROOT_PATH}/adump/host
    ${TOP_DIR}/inc/driver
    ${TOP_DIR}/abl/libc_sec/include
    ${TOP_DIR}/inc/toolchain
    ${TOP_DIR}/ace/npuruntime/acl/inc/external/acl/
    ${CMAKE_CURRENT_SOURCE_DIR}/common_stub
    ${ASCEND_PROTOBUF_SHARED_INCLUDE_DIR}
    ${TOP_DIR}/inc/external/acl
    ${TOP_DIR}/metadef/inc/external
    ${TOP_DIR}/ace/npuruntime/runtime/platform/inc
    ${CMAKE_BINARY_DIR}/proto/adump_base_proto
    ${TOP_DIR}/abl/msprof/inc
)

add_executable(adx_api_stest
    ${adxApiStSrcList}
)

add_dependencies(adx_api_stest adump_base_proto)

target_include_directories(adx_api_stest PRIVATE
    ${adxApiHeaders}
)

target_compile_definitions(adx_api_stest PRIVATE
    -DADUMP_SOC_HOST=1
    __IDE_ST
    IDE_DEBUG
    CFG_BUILD_DEBUG
    IDE_DAEMON_DEVICE
    IDE_DAEMON_RC
)

target_link_libraries(adx_api_stest PRIVATE
    $<BUILD_INTERFACE:adx_api_stestonetrack_pub>
)

target_compile_options(adx_api_stest PRIVATE
    -Wall
    -Werror
    -Wextra
)

target_link_options(adx_api_stest PRIVATE
)

add_library(adx_api_stestonetrack_pub INTERFACE)

target_link_libraries(adx_api_stestonetrack_pub INTERFACE
    $<BUILD_INTERFACE:intf_llt_pub>
    $<BUILD_INTERFACE:mmpa_headers>
    $<BUILD_INTERFACE:adump_headers>
    $<BUILD_INTERFACE:slog_headers>
    $<BUILD_INTERFACE:runtime_headers>
    -Wl,--as-needed
    -lpthread
)

run_llt_test(
    TARGET adx_api_stest
    TASK_NUM 1
)

############ adump stest ###########
add_subdirectory(adump_base)
add_subdirectory(adump_base_dup)
add_subdirectory(adump_base_tiny)