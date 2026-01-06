# -----------------------------------------------------------------------------------------------------------
# Copyright (c) 2025 Huawei Technologies Co., Ltd.
# This program is free software, you can redistribute it and/or modify it under the terms and conditions of
# CANN Open Software License Agreement Version 2.0 (the "License").
# Please refer to the License for details. You may not use this file except in compliance with the License.
# THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
# INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
# See LICENSE in the root of the software repository for the full text of the License.
# -----------------------------------------------------------------------------------------------------------

#  cmakelist for adx hdc data dump ut
include_directories(${OPEN_SOURCE_DIR}/boost)
include_directories(${OPEN_SOURCE_DIR}/mockcpp_src/include)

set(adxHdcDumpApiSrcList
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
    ${SRC_CODE_ROOT_PATH}/external
    ${SRC_CODE_ROOT_PATH}/inc/adump
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

    ${LLT_CODE_ROOT_PATH}/stub
    ${LLT_CODE_ROOT_PATH}/common_stub

    ${TOP_DIR}/include/driver
    ${TOP_DIR}/include/external
    ${TOP_DIR}/include/external/acl
    ${TOP_DIR}/pkg_inc/
    ${TOP_DIR}/pkg_inc/dump/

    ${ASCEND_PROTOBUF_SHARED_INCLUDE_DIR}
    ${CMAKE_BINARY_DIR}/proto/adump_base_proto
)

set(adxHdcDumpApiUtSrcList
    ${LLT_CODE_ROOT_PATH}/stub/ide_hdc_stub.cc
    ${LLT_CODE_ROOT_PATH}/stub/ide_dsmi_stub.c
    ${LLT_CODE_ROOT_PATH}/stub/ide_daemon_stub.cc
    ${LLT_CODE_ROOT_PATH}/stub/peripheral_aip_stub.c
    ${LLT_CODE_ROOT_PATH}/stub/mmpa_stub.c
    ${LLT_CODE_ROOT_PATH}/common_stub/sec_stub.cc
    ${LLT_CODE_ROOT_PATH}/common_stub/mmpa_stub.cc
    ${LLT_CODE_ROOT_PATH}/testcase/file_utils_utest.cc
    ${LLT_CODE_ROOT_PATH}/testcase/create_func_utest.cc
    ${LLT_CODE_ROOT_PATH}/testcase/adx_server_register_utest.cc
    ${LLT_CODE_ROOT_PATH}/testcase/ide_daemon_msg_test.cc
    ${LLT_CODE_ROOT_PATH}/testcase/adx_dump_record_utest.cc
    ${LLT_CODE_ROOT_PATH}/testcase/adx_commopt_manager_utest.cc
    ${LLT_CODE_ROOT_PATH}/testcase/adx_hdc_commopt_utest.cc
    ${LLT_CODE_ROOT_PATH}/testcase/adx_common_component_utest.cc
    ${LLT_CODE_ROOT_PATH}/testcase/adx_server_manager_utest.cc
    ${LLT_CODE_ROOT_PATH}/testcase/adx_component_api_c_utest.cc
    ${LLT_CODE_ROOT_PATH}/testcase/adx_api_utest.cc
    ${LLT_CODE_ROOT_PATH}/testcase/adx_hdc_epoll_utest.cc
    ${LLT_CODE_ROOT_PATH}/testcase/adx_sock_epoll_utest.cc
    ${LLT_CODE_ROOT_PATH}/testcase/adx_dump_hdc_helper_utest.cc
    ${LLT_CODE_ROOT_PATH}/testcase/adx_dump_soc_helper_utest.cc
    ${LLT_CODE_ROOT_PATH}/testcase/adx_dump_receive_utest.cc
    ${LLT_CODE_ROOT_PATH}/testcase/adx_sock_device_utest.cc
    ${LLT_CODE_ROOT_PATH}/testcase/adx_dump_server_utest.cc
    ${LLT_CODE_ROOT_PATH}/testcase/adx_dump_callback_utest.cc
    ${LLT_CODE_ROOT_PATH}/testcase/adx_hdc_interface_utest.cc
    ${LLT_CODE_ROOT_PATH}/testcase/adx_msg_proto_utest.cc
    ${LLT_CODE_ROOT_PATH}/testcase/adx_data_dump_utest.cc
    ${LLT_CODE_ROOT_PATH}/testcase/acl_dump_utest.cc
    ${LLT_CODE_ROOT_PATH}/testcase/main.cc
)

add_executable(adx_hdc_dump_utest
    ${adxHdcDumpApiSrcList}
    ${adxHdcDumpApiUtSrcList}
)

add_dependencies(adx_hdc_dump_utest adump_base_proto)

target_include_directories(adx_hdc_dump_utest PRIVATE
    ${LIBC_SEC_HEADER}
    ${adxHeaders}
)

target_compile_definitions(adx_hdc_dump_utest PRIVATE
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

target_link_libraries(adx_hdc_dump_utest PRIVATE
    $<BUILD_INTERFACE:adx_utestonetrack_pub>
)

target_compile_options(adx_hdc_dump_utest PRIVATE
    -Wall
    -Werror
    -Wextra
)

target_link_options(adx_hdc_dump_utest PRIVATE
)
