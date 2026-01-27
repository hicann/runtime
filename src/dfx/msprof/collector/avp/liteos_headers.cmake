# -----------------------------------------------------------------------------------------------------------
# Copyright (c) 2025 Huawei Technologies Co., Ltd.
# This program is free software, you can redistribute it and/or modify it under the terms and conditions of
# CANN Open Software License Agreement Version 2.0 (the "License").
# Please refer to the License for details. You may not use this file except in compliance with the License.
# THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
# INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
# See LICENSE in the root of the software repository for the full text of the License.
# -----------------------------------------------------------------------------------------------------------
set(NANO_LITEOS_CMC_PATH
    ${RUNTIME_DIR}/build/platform/linglong/liteos/Hi1A71_turing_cmc_package/fpga/vendor
)

set(NANO_LITEOS_HEADERS_PATH
    ${NANO_LITEOS_CMC_PATH}/hisi/audiodsp/platform_bt/include/npu
    ${NANO_LITEOS_CMC_PATH}/hisi/audiodsp/custom/bt/include/utils
    ${NANO_LITEOS_CMC_PATH}/hisi/audiodsp/liteos/arch/linglong/include
    ${NANO_LITEOS_CMC_PATH}/hisi/audiodsp/custom/bt/include/drv/ll1139
    ${NANO_LITEOS_CMC_PATH}/hisi/audiodsp/liteos/arch/linglong/include/arch
    ${NANO_LITEOS_CMC_PATH}/huaweiplatform/liteos/Huawei_LiteOS_208.7_B008/kernel/include/
    ${NANO_LITEOS_CMC_PATH}/huaweiplatform/liteos/Huawei_LiteOS_208.7_B008/targets/audiodsp_linglong/include
    ${NANO_LITEOS_CMC_PATH}/huaweiplatform/liteos/Huawei_LiteOS_208.7_B008/drivers/interrupt/include
    ${NANO_LITEOS_CMC_PATH}/huaweiplatform/liteos/Huawei_LiteOS_208.7_B008/drivers/timer/include
    ${NANO_LITEOS_CMC_PATH}/huaweiplatform/liteos/Huawei_LiteOS_208.7_B008/open_source/musl/include
    ${NANO_LITEOS_CMC_PATH}/huaweiplatform/liteos/Huawei_LiteOS_208.7_B008/open_source/musl/arch/linglong
    ${NANO_LITEOS_CMC_PATH}/huaweiplatform/liteos/Huawei_LiteOS_208.7_B008/open_source/musl/src/include
    ${NANO_LITEOS_CMC_PATH}/huaweiplatform/liteos/Huawei_LiteOS_208.7_B008/open_source/musl/src/internal
    ${NANO_LITEOS_CMC_PATH}/huaweiplatform/liteos/Huawei_LiteOS_208.7_B008/open_source/musl/src/crypt
    ${NANO_LITEOS_CMC_PATH}/huaweiplatform/liteos/Huawei_LiteOS_208.7_B008/open_source/musl/src/ctype
    ${NANO_LITEOS_CMC_PATH}/huaweiplatform/liteos/Huawei_LiteOS_208.7_B008/open_source/musl/src/dirent
    ${NANO_LITEOS_CMC_PATH}/huaweiplatform/liteos/Huawei_LiteOS_208.7_B008/open_source/musl/src/errno
    ${NANO_LITEOS_CMC_PATH}/huaweiplatform/liteos/Huawei_LiteOS_208.7_B008/open_source/musl/src/ipc
    ${NANO_LITEOS_CMC_PATH}/huaweiplatform/liteos/Huawei_LiteOS_208.7_B008/open_source/musl/src/locale
    ${NANO_LITEOS_CMC_PATH}/huaweiplatform/liteos/Huawei_LiteOS_208.7_B008/open_source/musl/src/math
    ${NANO_LITEOS_CMC_PATH}/huaweiplatform/liteos/Huawei_LiteOS_208.7_B008/open_source/musl/src/multibyte
    ${NANO_LITEOS_CMC_PATH}/huaweiplatform/liteos/Huawei_LiteOS_208.7_B008/open_source/musl/src/networknetwork
    ${NANO_LITEOS_CMC_PATH}/huaweiplatform/liteos/Huawei_LiteOS_208.7_B008/open_source/musl/src/passwd
    ${NANO_LITEOS_CMC_PATH}/huaweiplatform/liteos/Huawei_LiteOS_208.7_B008/open_source/musl/src/prng
    ${NANO_LITEOS_CMC_PATH}/huaweiplatform/liteos/Huawei_LiteOS_208.7_B008/open_source/musl/src/process
    ${NANO_LITEOS_CMC_PATH}/huaweiplatform/liteos/Huawei_LiteOS_208.7_B008/open_source/musl/src/regex
    ${NANO_LITEOS_CMC_PATH}/huaweiplatform/liteos/Huawei_LiteOS_208.7_B008/open_source/musl/src/search
    ${NANO_LITEOS_CMC_PATH}/huaweiplatform/liteos/Huawei_LiteOS_208.7_B008/open_source/musl/src/time
    ${NANO_LITEOS_CMC_PATH}/huaweiplatform/liteos/Huawei_LiteOS_208.7_B008/open_source/musl/arch/generic
    ${NANO_LITEOS_CMC_PATH}/huaweiplatform/liteos/Huawei_LiteOS_208.7_B008/lib/liteos_libc/pthread
    ${NANO_LITEOS_CMC_PATH}/huaweiplatform/liteos/Huawei_LiteOS_208.7_B008/lib/liteos_libc/mq
    ${NANO_LITEOS_CMC_PATH}/huaweiplatform/liteos/Huawei_LiteOS_208.7_B008/lib/liteos_libc/errno
    ${NANO_LITEOS_CMC_PATH}/huaweiplatform/liteos/Huawei_LiteOS_208.7_B008/lib/liteos_libc/tzdst
    ${NANO_LITEOS_CMC_PATH}/huaweiplatform/liteos/Huawei_LiteOS_208.7_B008/lib/liteos_libc/lock
    ${NANO_LITEOS_CMC_PATH}/huaweiplatform/liteos/Huawei_LiteOS_208.7_B008/lib/liteos_libc/locale
    ${NANO_LITEOS_CMC_PATH}/huaweiplatform/liteos/Huawei_LiteOS_208.7_B008/lib/liteos_libc/init
    ${NANO_LITEOS_CMC_PATH}/huaweiplatform/liteos/Huawei_LiteOS_208.7_B008/lib/liteos_libc/include
    ${NANO_LITEOS_CMC_PATH}/huaweiplatform/liteos/Huawei_LiteOS_208.7_B008/lib/liteos_libc/time
)