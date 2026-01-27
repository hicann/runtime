/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef QUEUE_SCHEDULE_HAL_INTERFACE_REF_H
#define QUEUE_SCHEDULE_HAL_INTERFACE_REF_H
#include <unistd.h>
#include "driver/ascend_hal_error.h"
#include "driver/ascend_hal.h"
#ifdef __cplusplus
extern "C" {
#endif
DLLEXPORT drvError_t __attribute__((weak)) halGetVdevNum(uint32_t *num_dev);
drvError_t __attribute__((weak)) drvQueryProcessHostPid(int pid, unsigned int *chip_id, unsigned int *vfid,
    unsigned int *host_pid, unsigned int *cp_type);
DLLEXPORT __attribute__((weak)) drvError_t drvGetLocalDevIDByHostDevID(uint32_t host_dev_id, uint32_t *local_dev_id);
DLLEXPORT __attribute__((weak)) drvError_t halShrIdGetAttribute(const char *name, enum shrIdAttrType type,
    struct shrIdAttr *attr);
#ifdef __cplusplus
}
#endif
#endif