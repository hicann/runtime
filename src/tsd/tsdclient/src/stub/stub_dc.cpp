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
#include "driver/ascend_inpackage_hal.h"

int halGetDeviceVfMax(unsigned int devId, unsigned int *vf_max_num)
{
    (void)devId;
    if (vf_max_num != nullptr) {
        *vf_max_num = 0U;
    }
    return static_cast<int>(DRV_ERROR_NONE);
}

int halGetDeviceVfList(unsigned int devId, unsigned int *vf_list, unsigned int list_len, unsigned int *vf_num)
{
    (void)devId;
    (void)vf_list;
    (void)list_len;
    (void)vf_num;
    return static_cast<int>(DRV_ERROR_NONE);
}
