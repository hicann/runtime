/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef SCD_MAPS_H
#define SCD_MAPS_H

#include "scd_map.h"
#include "scd_util.h"

#ifdef __cplusplus
extern "C" {
#endif // __cplusplus

typedef struct ScdMaps {
    int32_t          pid;
    struct AdiagList mapList;
} ScdMaps;

TraStatus ScdMapsLoad(ScdMaps *maps);
TraStatus ScdMapsInit(ScdMaps *maps, int32_t pid);
void ScdMapsUninit(ScdMaps *maps);
ScdMaps *ScdMapsGet(void);
ScdMap *ScdMapsGetMapByPc(ScdMaps *maps, uintptr_t pc);

#ifdef __cplusplus
}
#endif // __cplusplus
#endif