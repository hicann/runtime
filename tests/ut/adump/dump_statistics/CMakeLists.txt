# -----------------------------------------------------------------------------------------------------------
# Copyright (c) 2026 Huawei Technologies Co., Ltd.
# This program is free software, you can redistribute it and/or modify it under the terms and conditions of
# CANN Open Software License Agreement Version 2.0 (the "License").
# Please refer to the License for details. You may not use this file except in compliance with the License.
# THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
# INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
# See LICENSE in the root of the software repository for the full text of the License.
# -----------------------------------------------------------------------------------------------------------
############ adump_dump_stat_fw utest ################################
set(DUMP_STAT_UT_ROOT_PATH ${TOP_DIR}/tests/ut/adump/dump_statistics)
set(DUMP_STAT_FW_SRC_PATH ${SRC_CODE_ROOT_PATH}/adump/dump_statistics/dump_stat_fw)

set(dumpStatFwSrcList
    ${DUMP_STAT_FW_SRC_PATH}/dump_stats_interface.cpp
    ${DUMP_STAT_FW_SRC_PATH}/dump_stats_printf.cpp
    ${DUMP_STAT_FW_SRC_PATH}/dump_stats_process.cpp
    ${DUMP_STAT_FW_SRC_PATH}/dump_stats_server.cpp
    ${DUMP_STAT_FW_SRC_PATH}/dump_stats_task.cpp
)

set(dumpStatFwStubSrcList
    ${DUMP_STAT_UT_ROOT_PATH}/stub/ascend_stub.cpp
    ${DUMP_STAT_UT_ROOT_PATH}/stub/datadump_kfc_interface.cpp
    ${DUMP_STAT_UT_ROOT_PATH}/../adump_base/stub/slog_stub.cpp
    ${DUMP_STAT_UT_ROOT_PATH}/../adump_base/stub/mmpa_stub.cpp
)

set(dumpStatFwUtestSrcList
    ${DUMP_STAT_UT_ROOT_PATH}/testcase/main.cpp
    ${DUMP_STAT_UT_ROOT_PATH}/testcase/dump_stat_fw_utest.cpp
)

set(dumpStatFwHeaders
    ${DUMP_STAT_FW_SRC_PATH}/
    ${SRC_CODE_ROOT_PATH}/adcore/log/
    ${SRC_CODE_ROOT_PATH}/adcore/common/
    ${SRC_CODE_ROOT_PATH}/adump/
    ${SRC_CODE_ROOT_PATH}/adump/common/
    ${SRC_CODE_ROOT_PATH}/adump/operator/operator_preliminary/
    ${SRC_CODE_ROOT_PATH}/adump/impl/
    ${TOP_DIR}/pkg_inc/
    ${TOP_DIR}/pkg_inc/base/
    ${TOP_DIR}/pkg_inc/mmpa/
    ${TOP_DIR}/pkg_inc/dump/
    ${TOP_DIR}/pkg_inc/driver
    ${TOP_DIR}/src/inc/aicpu_sched/

    ${DUMP_STAT_UT_ROOT_PATH}/
    ${DUMP_STAT_UT_ROOT_PATH}/stub/
)

add_executable(adump_dump_stat_fw_utest
    ${dumpStatFwSrcList}
    ${dumpStatFwStubSrcList}
    ${dumpStatFwUtestSrcList}
)

target_include_directories(adump_dump_stat_fw_utest PRIVATE
    ${LIBC_SEC_HEADER}
    ${dumpStatFwHeaders}
)

target_compile_definitions(adump_dump_stat_fw_utest PRIVATE
    ADX_LIB
    -DADUMP_SOC_HOST=0
    __ADUMP_LLT
)

target_link_libraries(adump_dump_stat_fw_utest PRIVATE
    $<BUILD_INTERFACE:adx_utestonetrack_pub>
    -Wl,--no-as-needed
    -ldl
    -lpthread
)

target_compile_options(adump_dump_stat_fw_utest PRIVATE
    -Wall
    -Werror
    -Wextra
    -fno-access-control
)

target_link_options(adump_dump_stat_fw_utest PRIVATE
    -Wl,-z,relro,-z,now,-z,noexecstack
)

############ adump_dump_stat_op utest ################################
set(DUMP_STAT_OP_SRC_PATH ${SRC_CODE_ROOT_PATH}/adump/dump_statistics/dump_stat_op)

add_executable(adump_dump_stat_op_utest
    ${DUMP_STAT_UT_ROOT_PATH}/testcase/main.cpp
    ${DUMP_STAT_UT_ROOT_PATH}/testcase/dump_stat_op_utest.cpp
    # kfc_dump_stat.cpp 不单独编译：其中入口函数均为 __aicore__ inline（内部链接），
    # 由 dump_stat_op_utest.cpp 直接 include 覆盖
)

target_include_directories(adump_dump_stat_op_utest PRIVATE
    ${DUMP_STAT_UT_ROOT_PATH}/stub
    ${DUMP_STAT_OP_SRC_PATH}
    ${LIBC_SEC_HEADER}
)

target_compile_definitions(adump_dump_stat_op_utest PRIVATE
    __ADUMP_LLT
    # 启用 David 架构分支：覆盖 fp8（hifloat8/fp8_e5m2/fp8_e4m3fn）分发与尾块填充路径，
    # stub 已提供 SyncAll<true>/三参数 DCCI 等 David 依赖 API 的 host 侧实现
    __NPU_ARCH__=3510
    __DAV_VEC__
)

target_link_libraries(adump_dump_stat_op_utest PRIVATE
    $<BUILD_INTERFACE:adump_intf_llt_pub>
)

target_compile_options(adump_dump_stat_op_utest PRIVATE
    -Wall
    -Werror
    -Wno-sign-compare
    -Wno-unused-parameter
    -Wno-unused-but-set-parameter
    -Wno-unused-variable
)

target_link_options(adump_dump_stat_op_utest PRIVATE
    -Wl,-z,relro,-z,now,-z,noexecstack
)
