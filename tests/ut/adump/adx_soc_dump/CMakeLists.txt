# -----------------------------------------------------------------------------------------------------------
# Copyright (c) 2025 Huawei Technologies Co., Ltd.
# This program is free software, you can redistribute it and/or modify it under the terms and conditions of
# CANN Open Software License Agreement Version 2.0 (the "License").
# Please refer to the License for details. You may not use this file except in compliance with the License.
# THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
# INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
# See LICENSE in the root of the software repository for the full text of the License.
# -----------------------------------------------------------------------------------------------------------

############ adx_dump_soc_api ###########
include_directories(${OPEN_SOURCE_DIR}/boost)
include_directories(${OPEN_SOURCE_DIR}/mockcpp_src/include)

set(adxSocDumpApiSrcList
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

set(adxSocDumpApiUtSrcList
    ${LLT_CODE_ROOT_PATH}/stub/ide_hdc_stub.cc
    ${LLT_CODE_ROOT_PATH}/stub/ide_dsmi_stub.c
    ${LLT_CODE_ROOT_PATH}/stub/ide_daemon_stub.cc
    ${LLT_CODE_ROOT_PATH}/stub/peripheral_aip_stub.c
    ${LLT_CODE_ROOT_PATH}/stub/mmpa_stub.c
    ${LLT_CODE_ROOT_PATH}/common_stub/sec_stub.cc
    ${LLT_CODE_ROOT_PATH}/common_stub/mmpa_stub.cc
    ${LLT_CODE_ROOT_PATH}/testcase/adx_dump_soc_api_utest.cc
    ${LLT_CODE_ROOT_PATH}/testcase/adx_dump_server_stub_utest.cc
    ${LLT_CODE_ROOT_PATH}/testcase/main.cc
)

set(adxSocDumpApiUtHeaderList
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

    ${LLT_CODE_ROOT_PATH}/common_stub
    ${ASCEND_PROTOBUF_SHARED_INCLUDE_DIR}
    ${CMAKE_BINARY_DIR}/proto/adump_base_proto
)

add_executable(adx_soc_dump_utest
    ${adxSocDumpApiSrcList}
    ${adxSocDumpApiUtSrcList}
)

target_include_directories(adx_soc_dump_utest PRIVATE
    ${adxSocDumpApiUtHeaderList}
)

add_dependencies(adx_soc_dump_utest adump_base_proto)

target_compile_definitions(adx_soc_dump_utest PRIVATE
    -DADUMP_SOC_HOST=1
    __IDE_UT
    IDE_DEBUG
    CFG_BUILD_DEBUG
    IDE_DAEMON_DEVICE
    IDE_DAEMON_RC
    PLATFORM_MONITOR
    IDE_DAEMON_CFG=\"ide_daemon.cfg\"
)

target_link_libraries(adx_soc_dump_utest PRIVATE
    $<BUILD_INTERFACE:adx_utestonetrack_pub>
    -Wl,-rpath,${TOP_DIR}/output/llt/c_sec/lib
    c_sec_static
    ascend_protobuf_static
    GTest::gtest
)

target_compile_options(adx_soc_dump_utest PRIVATE
    -Wall
    -Werror
    -Wextra
)

target_link_options(adx_soc_dump_utest PRIVATE
    -Wl,-z,relro,-z,now,-z,noexecstack
)
