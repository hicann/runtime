# -----------------------------------------------------------------------------------------------------------
# Copyright (c) 2025 Huawei Technologies Co., Ltd.
# This program is free software, you can redistribute it and/or modify it under the terms and conditions of
# CANN Open Software License Agreement Version 2.0 (the "License").
# Please refer to the License for details. You may not use this file except in compliance with the License.
# THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
# INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
# See LICENSE in the root of the software repository for the full text of the License.
# -----------------------------------------------------------------------------------------------------------
set(TOP_DIR "${CMAKE_CURRENT_SOURCE_DIR}../../../../" CACHE PATH "Project top directory") 
set(PACKAGE_FILE_PATH_PREFIX ${TOP_DIR}/build/platform/linglong/liteos/Hi1A71_turing_cmc_package/fpga/vendor)

set(NANO_LITEOS_HEADER_FILES_PATH
    ${PACKAGE_FILE_PATH_PREFIX}/hisi/audiodsp/custom/bt/include/utils
    ${PACKAGE_FILE_PATH_PREFIX}/hisi/audiodsp/liteos/arch/linglong/include
    ${PACKAGE_FILE_PATH_PREFIX}/hisi/audiodsp/custom/bt/include/drv/ll1139
    ${PACKAGE_FILE_PATH_PREFIX}/hisi/audiodsp/liteos/arch/linglong/include/arch
    ${PACKAGE_FILE_PATH_PREFIX}/hisi/audiodsp/platform_bt/include/npu
    ${PACKAGE_FILE_PATH_PREFIX}/huaweiplatform/liteos/Huawei_LiteOS_208.7_B008/kernel/include
    ${PACKAGE_FILE_PATH_PREFIX}/huaweiplatform/liteos/Huawei_LiteOS_208.7_B008/targets/audiodsp_linglong/include
    ${PACKAGE_FILE_PATH_PREFIX}/huaweiplatform/liteos/Huawei_LiteOS_208.7_B008/drivers/interrupt/include
    ${PACKAGE_FILE_PATH_PREFIX}/huaweiplatform/liteos/Huawei_LiteOS_208.7_B008/drivers/timer/include
    ${PACKAGE_FILE_PATH_PREFIX}/huaweiplatform/liteos/Huawei_LiteOS_208.7_B008/open_source/musl/include
    ${PACKAGE_FILE_PATH_PREFIX}/huaweiplatform/liteos/Huawei_LiteOS_208.7_B008/open_source/musl/arch/linglong
    ${PACKAGE_FILE_PATH_PREFIX}/huaweiplatform/liteos/Huawei_LiteOS_208.7_B008/open_source/musl/src/include
    ${PACKAGE_FILE_PATH_PREFIX}/huaweiplatform/liteos/Huawei_LiteOS_208.7_B008/open_source/musl/src/internal
    ${PACKAGE_FILE_PATH_PREFIX}/huaweiplatform/liteos/Huawei_LiteOS_208.7_B008/open_source/musl/src/crypt
    ${PACKAGE_FILE_PATH_PREFIX}/huaweiplatform/liteos/Huawei_LiteOS_208.7_B008/open_source/musl/src/ctype
    ${PACKAGE_FILE_PATH_PREFIX}/huaweiplatform/liteos/Huawei_LiteOS_208.7_B008/open_source/musl/src/dirent
    ${PACKAGE_FILE_PATH_PREFIX}/huaweiplatform/liteos/Huawei_LiteOS_208.7_B008/open_source/musl/src/errno
    ${PACKAGE_FILE_PATH_PREFIX}/huaweiplatform/liteos/Huawei_LiteOS_208.7_B008/open_source/musl/src/ipc
    ${PACKAGE_FILE_PATH_PREFIX}/huaweiplatform/liteos/Huawei_LiteOS_208.7_B008/open_source/musl/src/locale
    ${PACKAGE_FILE_PATH_PREFIX}/huaweiplatform/liteos/Huawei_LiteOS_208.7_B008/open_source/musl/src/math
    ${PACKAGE_FILE_PATH_PREFIX}/huaweiplatform/liteos/Huawei_LiteOS_208.7_B008/open_source/musl/src/multibyte
    ${PACKAGE_FILE_PATH_PREFIX}/huaweiplatform/liteos/Huawei_LiteOS_208.7_B008/open_source/musl/src/networknetwork
    ${PACKAGE_FILE_PATH_PREFIX}/huaweiplatform/liteos/Huawei_LiteOS_208.7_B008/open_source/musl/src/passwd
    ${PACKAGE_FILE_PATH_PREFIX}/huaweiplatform/liteos/Huawei_LiteOS_208.7_B008/open_source/musl/src/prng
    ${PACKAGE_FILE_PATH_PREFIX}/huaweiplatform/liteos/Huawei_LiteOS_208.7_B008/open_source/musl/src/process
    ${PACKAGE_FILE_PATH_PREFIX}/huaweiplatform/liteos/Huawei_LiteOS_208.7_B008/open_source/musl/src/regex
    ${PACKAGE_FILE_PATH_PREFIX}/huaweiplatform/liteos/Huawei_LiteOS_208.7_B008/open_source/musl/src/search
    ${PACKAGE_FILE_PATH_PREFIX}/huaweiplatform/liteos/Huawei_LiteOS_208.7_B008/open_source/musl/src/time
    ${PACKAGE_FILE_PATH_PREFIX}/huaweiplatform/liteos/Huawei_LiteOS_208.7_B008/open_source/musl/arch/generic
    ${PACKAGE_FILE_PATH_PREFIX}/huaweiplatform/liteos/Huawei_LiteOS_208.7_B008/lib/liteos_libc/pthread
    ${PACKAGE_FILE_PATH_PREFIX}/huaweiplatform/liteos/Huawei_LiteOS_208.7_B008/lib/liteos_libc/mq
    ${PACKAGE_FILE_PATH_PREFIX}/huaweiplatform/liteos/Huawei_LiteOS_208.7_B008/lib/liteos_libc/errno
    ${PACKAGE_FILE_PATH_PREFIX}/huaweiplatform/liteos/Huawei_LiteOS_208.7_B008/lib/liteos_libc/tzdst
    ${PACKAGE_FILE_PATH_PREFIX}/huaweiplatform/liteos/Huawei_LiteOS_208.7_B008/lib/liteos_libc/lock
    ${PACKAGE_FILE_PATH_PREFIX}/huaweiplatform/liteos/Huawei_LiteOS_208.7_B008/lib/liteos_libc/locale
    ${PACKAGE_FILE_PATH_PREFIX}/huaweiplatform/liteos/Huawei_LiteOS_208.7_B008/lib/liteos_libc/init
    ${PACKAGE_FILE_PATH_PREFIX}/huaweiplatform/liteos/Huawei_LiteOS_208.7_B008/lib/liteos_libc/include
    ${PACKAGE_FILE_PATH_PREFIX}/huaweiplatform/liteos/Huawei_LiteOS_208.7_B008/lib/liteos_libc/time
)