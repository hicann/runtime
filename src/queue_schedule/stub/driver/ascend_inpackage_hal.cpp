/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "driver/ascend_hal.h"
DLLEXPORT drvError_t drvQueryProcessHostPid(int pid, unsigned int *chip_id, unsigned int *vfid,
                                            unsigned int *host_pid, unsigned int *cp_type)
{
    (void)pid;
    (void)chip_id;
    (void)vfid;
    (void)host_pid;
    (void)cp_type;
    if (chip_id == nullptr) {
        chip_id = nullptr;
    }
    if (vfid == nullptr) {
        vfid = nullptr;
    }
    if (host_pid == nullptr) {
        host_pid = nullptr;
    }
    if (cp_type == nullptr) {
        cp_type = nullptr;
    }
    return DRV_ERROR_NONE;
}