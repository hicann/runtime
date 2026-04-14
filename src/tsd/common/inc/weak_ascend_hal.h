/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef TSD_WEAK_ASCEND_HAL_H
#define TSD_WEAK_ASCEND_HAL_H

#include "driver/ascend_inpackage_hal.h"

extern "C" {
int __attribute__((weak)) halGetDeviceVfMax(unsigned int devId, unsigned int *vf_max_num);
DLLEXPORT __attribute__((weak)) drvError_t drvHdcSendFileV2(int peer_node, int peer_devid, const char *file,
    const char *dst_path, void (*progress_notifier)(struct drvHdcProgInfo *));
DLLEXPORT __attribute__((weak)) drvError_t drvHdcGetTrustedBasePathV2(int peer_node, int peer_devid, char *base_path,
    unsigned int path_len);
drvError_t __attribute__((weak)) halGetSocVersion(uint32_t devId, char *socVersion, uint32_t len);
}
#endif  // TSD_WEAK_ASCEND_HAL_H