# -----------------------------------------------------------------------------------------------------------
# Copyright (c) 2025 Huawei Technologies Co., Ltd.
# This program is free software, you can redistribute it and/or modify it under the terms and conditions of
# CANN Open Software License Agreement Version 2.0 (the "License").
# Please refer to the License for details. You may not use this file except in compliance with the License.
# THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
# INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
# See LICENSE in the root of the software repository for the full text of the License.
# -----------------------------------------------------------------------------------------------------------

#################### libadump.so begin ####################
set(adumpHeaderList
    ${LIBC_SEC_HEADER}
    ${ADUMP_ADUMP_DIR}/
    ${ADUMP_ADUMP_DIR}/common
    ${ADUMP_DIR}/adcore/device
    ${ADUMP_DIR}/adcore/common
)

set(adumpSrcList
    ${ADUMP_DIR}/adcore/commopts/adx_comm_opt_manager.cpp
    ${ADUMP_DIR}/adcore/common/memory_utils.cpp
    ${ADUMP_DIR}/adcore/common/file_utils.cpp
    ${ADUMP_DIR}/adcore/protocol/adx_msg_proto.cpp
    ${ADUMP_DIR}/adcore/common/string_utils.cpp
    ${ADUMP_DIR}/adcore/device/adx_device.cpp
    ${ADUMP_DIR}/adcore/device/adx_sock_device.cpp
    ${ADUMP_DIR}/adcore/commopts/sock_api.cpp
    ${ADUMP_DIR}/adcore/commopts/sock_comm_opt.cpp
    ${ADUMP_DIR}/adcore/common/thread.cpp
    ${ADUMP_ADUMP_DIR}/adx_dump_process.cpp
    ${ADUMP_ADUMP_DIR}/device/adx_dump_soc_helper.cpp
    ${ADUMP_ADUMP_DIR}/device/adx_datadump_server_soc.cpp
    ${ADUMP_ADUMP_DIR}/adx_dump_record.cpp
    # for hdc api
    ${ADUMP_DIR}/adcore/device/adx_dsmi.cpp
    ${ADUMP_DIR}/adcore/device/adx_device.cpp
    ${ADUMP_DIR}/adcore/device/adx_hdc_device.cpp
    ${ADUMP_DIR}/adcore/hdc/hdc_api.cpp
    ${ADUMP_DIR}/adcore/adcore_api.cpp
    ${ADUMP_DIR}/adcore/commopts/hdc_comm_opt.cpp
    ${ADUMP_DIR}/adcore/component/adx_server_manager.cpp
    ${ADUMP_DIR}/adcore/component/adx_common_component.cpp
    ${ADUMP_DIR}/adcore/component/adx_component_api_c.cpp
    ${ADUMP_DIR}/adcore/epoll/adx_hdc_epoll.cpp
    ${ADUMP_DIR}/adcore/common/create_func.cpp
    ${ADUMP_DIR}/adcore/component/server_register.cpp
    ${ADUMP_ADUMP_DIR}/device/adx_dump_hdc_helper.cpp
    ${ADUMP_ADUMP_DIR}/device/adx_dump_hdc_api.cpp
    ${ADUMP_ADUMP_DIR}/common/sys_utils.cpp
    ${ADUMP_DIR}/adcore/common/thread_comm.cpp
)

add_library(adump SHARED
    ${adumpSrcList}
)

target_include_directories(adump PRIVATE
    ${adumpHeaderList}
)

target_compile_options(adump PRIVATE
    -Werror
    -Wextra
    -Wfloat-equal
    -std=c++11
    -fstack-protector-strong
    -fPIC
    -fno-common
    -fno-strict-aliasing
    -fvisibility=hidden
    -fvisibility-inlines-hidden
    $<$<CONFIG:Debug>:-ftrapv>
)

target_compile_definitions(adump PRIVATE
    ADX_LIB
    OS_TYPE=0
    ADUMP_SOC_HOST=0
)

target_link_libraries(adump PRIVATE
    $<BUILD_INTERFACE:intf_pub>
    $<BUILD_INTERFACE:mmpa_headers>
    $<BUILD_INTERFACE:adump_headers>
    $<BUILD_INTERFACE:slog_headers>
    $<BUILD_INTERFACE:adcore_headers>
    -Wl,--no-as-needed
    c_sec
    mmpa
    unified_dlog
    -Wl,--as-needed
)

target_link_options(adump PRIVATE
    -Wl,-z,relro,-z,now,-z,noexecstack
    -Wl,-Bsymbolic
)

install(TARGETS adump OPTIONAL
    LIBRARY DESTINATION ${INSTALL_LIBRARY_DIR}
)
#################### libadump.so end ####################
