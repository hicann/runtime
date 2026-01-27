/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "ascend_hal.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <map>
#include <vector>

drvError_t halGetVdevNum(uint32_t *num_dev)
{
    (void)num_dev;
    return DRV_ERROR_NONE;
}
drvError_t halGetVdevIDs(uint32_t *devices, uint32_t len)
{
    (void)devices;
    (void)len;
    return DRV_ERROR_NONE;
}
drvError_t halGetChipInfo(uint32_t devId, halChipInfo *chipInfo)
{
    (void)devId;
    (void)chipInfo;
    return DRV_ERROR_NONE;
}

drvError_t halGetAPIVersion(int32_t *halAPIVersion)
{
    *halAPIVersion = 467735;
    return DRV_ERROR_NONE;
}