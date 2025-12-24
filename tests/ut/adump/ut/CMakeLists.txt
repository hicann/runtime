# -----------------------------------------------------------------------------------------------------------
# Copyright (c) 2025 Huawei Technologies Co., Ltd.
# This program is free software, you can redistribute it and/or modify it under the terms and conditions of
# CANN Open Software License Agreement Version 2.0 (the "License").
# Please refer to the License for details. You may not use this file except in compliance with the License.
# THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
# INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
# See LICENSE in the root of the software repository for the full text of the License.
# -----------------------------------------------------------------------------------------------------------
#  cmakelist for adx ut
set(SRC_CODE_ROOT_PATH ${TOP_DIR}/src/dfx/adump)

set(adumpBaseProtoList
    "${TOP_DIR}/src/dfx/adump/proto/op_mapping.proto"
    "${TOP_DIR}/src/dfx/adump/proto/dump_task.proto"
)
protobuf_generate(adump_base_proto adumpBaseProtoSrc adumBaseProtoHeaders ${adumpBaseProtoList} TARGET)
add_dependencies(adump_base_proto protobuf_host_build ascend_protobuf_static)

set(adxSrcList
    ${SRC_CODE_ROOT_PATH}/adcore/hdc/hdc_api.cpp
    ${SRC_CODE_ROOT_PATH}/adcore/device/adx_dsmi.cpp
    ${SRC_CODE_ROOT_PATH}/adcore/common/memory_utils.cpp
    ${SRC_CODE_ROOT_PATH}/adcore/common/thread.cpp
    ${SRC_CODE_ROOT_PATH}/adcore/common/thread_comm.cpp
    ${SRC_CODE_ROOT_PATH}/adcore/commopts/adx_comm_opt_manager.cpp
    ${SRC_CODE_ROOT_PATH}/adcore/commopts/hdc_comm_opt.cpp
    ${SRC_CODE_ROOT_PATH}/adcore/component/adx_server_manager.cpp
    ${SRC_CODE_ROOT_PATH}/adump/adx_dump_record.cpp
    ${SRC_CODE_ROOT_PATH}/adump/common/adump_dsmi.cpp
    ${SRC_CODE_ROOT_PATH}/adcore/epoll/adx_hdc_epoll.cpp
    ${SRC_CODE_ROOT_PATH}/adcore/protocol/adx_msg_proto.cpp
    ${SRC_CODE_ROOT_PATH}/adcore/device/adx_device.cpp
    ${SRC_CODE_ROOT_PATH}/adcore/device/adx_hdc_device.cpp
    ${SRC_CODE_ROOT_PATH}/adcore/device/adx_sock_device.cpp
    ${SRC_CODE_ROOT_PATH}/adcore/adx_api.cpp
    ${SRC_CODE_ROOT_PATH}/adump/host/adx_datadump_server.cpp
    ${SRC_CODE_ROOT_PATH}/adcore/commopts/sock_api.cpp
    ${SRC_CODE_ROOT_PATH}/adcore/commopts/sock_comm_opt.cpp
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
    ${SRC_CODE_ROOT_PATH}/adump/host/adx_datadump_callback.cpp
    ${SRC_CODE_ROOT_PATH}/adump/device/adx_datadump_server_soc.cpp
    ${SRC_CODE_ROOT_PATH}/adcore/component/adx_common_component.cpp
    ${SRC_CODE_ROOT_PATH}/adump/adx_dump_process.cpp
    ${SRC_CODE_ROOT_PATH}/adcore/adcore_api.cpp
    ${SRC_CODE_ROOT_PATH}/adump/common/sys_utils.cpp
)

set(adxHeaders
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
    ${TOP_DIR}/inc/external/acl
    ${CMAKE_CURRENT_SOURCE_DIR}/common_stub
    ${ASCEND_PROTOBUF_SHARED_INCLUDE_DIR}
    ${TOP_DIR}/metadef/inc/external
    ${TOP_DIR}/ace/npuruntime/runtime/platform/inc
    ${CMAKE_BINARY_DIR}/proto/adump_base_proto
    ${TOP_DIR}/abl/msprof/inc
)

set(adxUtSrcList
    ${CMAKE_CURRENT_SOURCE_DIR}/stub/ide_hdc_stub.cc
    ${CMAKE_CURRENT_SOURCE_DIR}/stub/ide_dsmi_stub.c
    ${CMAKE_CURRENT_SOURCE_DIR}/stub/ide_daemon_stub.cc
    ${CMAKE_CURRENT_SOURCE_DIR}/stub/peripheral_aip_stub.c
    ${CMAKE_CURRENT_SOURCE_DIR}/stub/mmpa_stub.c
    ${CMAKE_CURRENT_SOURCE_DIR}/common_stub/sec_stub.cc
    ${CMAKE_CURRENT_SOURCE_DIR}/common_stub/mmpa_stub.cc
    ${CMAKE_CURRENT_SOURCE_DIR}/testcase/file_utils_utest.cc
    ${CMAKE_CURRENT_SOURCE_DIR}/testcase/create_func_utest.cc
    ${CMAKE_CURRENT_SOURCE_DIR}/testcase/adx_server_register_utest.cc
    ${CMAKE_CURRENT_SOURCE_DIR}/testcase/ide_daemon_msg_test.cc
    ${CMAKE_CURRENT_SOURCE_DIR}/testcase/adx_dump_record_utest.cc
    ${CMAKE_CURRENT_SOURCE_DIR}/testcase/adx_commopt_manager_utest.cc
    ${CMAKE_CURRENT_SOURCE_DIR}/testcase/adx_hdc_commopt_utest.cc
    ${CMAKE_CURRENT_SOURCE_DIR}/testcase/adx_common_component_utest.cc
    ${CMAKE_CURRENT_SOURCE_DIR}/testcase/adx_server_manager_utest.cc
    ${CMAKE_CURRENT_SOURCE_DIR}/testcase/adx_component_api_c_utest.cc
    ${CMAKE_CURRENT_SOURCE_DIR}/testcase/adx_api_utest.cc
    ${CMAKE_CURRENT_SOURCE_DIR}/testcase/adx_hdc_epoll_utest.cc
    ${CMAKE_CURRENT_SOURCE_DIR}/testcase/adx_sock_epoll_utest.cc
    ${CMAKE_CURRENT_SOURCE_DIR}/testcase/adx_dump_hdc_helper_utest.cc
    ${CMAKE_CURRENT_SOURCE_DIR}/testcase/adx_dump_soc_helper_utest.cc
    ${CMAKE_CURRENT_SOURCE_DIR}/testcase/adx_dump_receive_utest.cc
    ${CMAKE_CURRENT_SOURCE_DIR}/testcase/adx_sock_device_utest.cc
    ${CMAKE_CURRENT_SOURCE_DIR}/testcase/adx_dump_server_utest.cc
    ${CMAKE_CURRENT_SOURCE_DIR}/testcase/adx_dump_callback_utest.cc
    ${CMAKE_CURRENT_SOURCE_DIR}/testcase/adx_hdc_interface_utest.cc
    ${CMAKE_CURRENT_SOURCE_DIR}/testcase/adx_msg_proto_utest.cc
    ${CMAKE_CURRENT_SOURCE_DIR}/testcase/adx_data_dump_utest.cc
    ${CMAKE_CURRENT_SOURCE_DIR}/testcase/acl_dump_utest.cc
)

add_executable(adx_utest
    ${adxUtSrcList}
    ${adxSrcList}
)

add_dependencies(adx_utest adump_base_proto)

target_include_directories(adx_utest PRIVATE
    ${adxHeaders}
)

target_compile_definitions(adx_utest PRIVATE
    -DADUMP_SOC_HOST=1
    __IDE_UT
    IDE_DEBUG
    CFG_BUILD_DEBUG
    IDE_DAEMON_DEVICE
    IDE_DAEMON_RC
    PLATFORM_MONITOR
    IDE_DAEMON_CFG=\"ide_daemon.cfg\"
    ADX_LIB_DEVICE_DRV
    ADUMP_BASE_DIR=\"${SRC_CODE_ROOT_PATH}\"
)

target_link_libraries(adx_utest PRIVATE
    $<BUILD_INTERFACE:adx_utestonetrack_pub>
    c_sec_static
)

target_compile_options(adx_utest PRIVATE
    -Wall
    -Werror
    -Wextra
)

target_link_options(adx_utest PRIVATE
)

add_library(adx_utestonetrack_pub INTERFACE)

target_link_libraries(adx_utestonetrack_pub INTERFACE
    #c_sec
    $<BUILD_INTERFACE:intf_llt_pub>
    $<BUILD_INTERFACE:mmpa_headers>
    $<BUILD_INTERFACE:adump_headers>
    $<BUILD_INTERFACE:slog_headers>
    $<BUILD_INTERFACE:runtime_headers>
    -Wl,--as-needed
    -lpthread
)

run_llt_test(
    TARGET adx_utest
    TASK_NUM 1
)

############ adx_dump_soc_api ###########
set(adxdumpsocapiSrcList
    ${SRC_CODE_ROOT_PATH}/adcore/hdc/hdc_api.cpp
    ${SRC_CODE_ROOT_PATH}/adcore/device/adx_dsmi.cpp
    ${SRC_CODE_ROOT_PATH}/adcore/common/memory_utils.cpp
    ${SRC_CODE_ROOT_PATH}/adcore/common/thread.cpp
    ${SRC_CODE_ROOT_PATH}/adcore/common/thread_comm.cpp
    ${SRC_CODE_ROOT_PATH}/adcore/commopts/adx_comm_opt_manager.cpp
    ${SRC_CODE_ROOT_PATH}/adcore/common/memory_utils.cpp
    ${SRC_CODE_ROOT_PATH}/adump/adx_dump_record.cpp
    ${SRC_CODE_ROOT_PATH}/adcore/common/file_utils.cpp
    ${SRC_CODE_ROOT_PATH}/adcore/protocol/adx_msg_proto.cpp
    ${SRC_CODE_ROOT_PATH}/adcore/common/string_utils.cpp
    ${SRC_CODE_ROOT_PATH}/adump/device/adx_dump_soc_helper.cpp
    ${SRC_CODE_ROOT_PATH}/adump/device/adx_datadump_server_soc.cpp
    ${SRC_CODE_ROOT_PATH}/adcore/device/adx_device.cpp
    ${SRC_CODE_ROOT_PATH}/adcore/device/adx_sock_device.cpp
    ${SRC_CODE_ROOT_PATH}/adcore/commopts/sock_api.cpp
    ${SRC_CODE_ROOT_PATH}/adcore/commopts/sock_comm_opt.cpp
    ${SRC_CODE_ROOT_PATH}/adcore/common/thread.cpp
    ${SRC_CODE_ROOT_PATH}/adump/device/adx_dump_soc_api.cpp
    ${SRC_CODE_ROOT_PATH}/adump/host/adx_datadump_server_stub.cpp
    ${SRC_CODE_ROOT_PATH}/adump/adx_dump_process.cpp
)

set(adxdumpsocapiUtSrcList
    ${CMAKE_CURRENT_SOURCE_DIR}/stub/ide_hdc_stub.cc
    ${CMAKE_CURRENT_SOURCE_DIR}/stub/ide_dsmi_stub.c
    ${CMAKE_CURRENT_SOURCE_DIR}/stub/ide_daemon_stub.cc
    ${CMAKE_CURRENT_SOURCE_DIR}/stub/peripheral_aip_stub.c
    ${CMAKE_CURRENT_SOURCE_DIR}/stub/mmpa_stub.c
    ${CMAKE_CURRENT_SOURCE_DIR}/common_stub/sec_stub.cc
    ${CMAKE_CURRENT_SOURCE_DIR}/common_stub/mmpa_stub.cc
    ${CMAKE_CURRENT_SOURCE_DIR}/testcase/adx_dump_soc_api_utest.cc
    ${CMAKE_CURRENT_SOURCE_DIR}/testcase/adx_dump_server_stub_utest.cc
    ${adxdumpsocapiSrcList}
)

set(adxdumpsocapiHeaders
    ${adxHeaders}
)

add_executable(adxdumpsocapi_utest
    ${adxdumpsocapiUtSrcList}
)

target_include_directories(adxdumpsocapi_utest PRIVATE
    ${adxdumpsocapiHeaders}
)

target_compile_definitions(adxdumpsocapi_utest PRIVATE
    -DADUMP_SOC_HOST=1
    __IDE_UT
    IDE_DEBUG
    CFG_BUILD_DEBUG
    IDE_DAEMON_DEVICE
    IDE_DAEMON_RC
    PLATFORM_MONITOR
    IDE_DAEMON_CFG=\"ide_daemon.cfg\"
)

target_link_libraries(adxdumpsocapi_utest PRIVATE
    $<BUILD_INTERFACE:adx_dumpsocapi_pub>
    $<BUILD_INTERFACE:intf_llt_pub>
    $<BUILD_INTERFACE:adump_headers>
    c_sec
    -Wl,-rpath,${TOP_DIR}/output/llt/c_sec/lib
)

target_compile_options(adxdumpsocapi_utest PRIVATE
    -std=c99
    -std=c++11
    -Wall
    -Werror
    -Wextra
)

target_link_options(adxdumpsocapi_utest PRIVATE
    -Wl,-z,relro,-z,now,-z,noexecstack
)

add_library(adx_dumpsocapi_pub INTERFACE)

target_link_libraries(adx_dumpsocapi_pub INTERFACE
    #c_sec
    $<BUILD_INTERFACE:intf_llt_pub>
    $<BUILD_INTERFACE:mmpa_headers>
    $<BUILD_INTERFACE:adump_headers>
    $<BUILD_INTERFACE:slog_headers>
    $<BUILD_INTERFACE:runtime_headers>
    -Wl,--as-needed
    -lpthread
)

run_llt_test(
    TARGET adxdumpsocapi_utest
    TASK_NUM 1
)