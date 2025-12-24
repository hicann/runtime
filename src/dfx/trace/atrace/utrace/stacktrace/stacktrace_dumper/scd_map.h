/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef SCD_MAP_H
#define SCD_MAP_H

#include "atrace_types.h"
#include "scd_dl.h"
#include "scd_util.h"
#include "scd_dwarf.h"

#ifdef __cplusplus
extern "C" {
#endif // __cplusplus

typedef struct ScdMap {
    //base info from /proc/<PID>/maps
    uintptr_t  start;
    uintptr_t  end;
    size_t     offset;
    size_t     nameLength;
    char      *name;

    // dl
    ScdDl      dl;
} ScdMap;

uintptr_t ScdMapGetRelPc(ScdMap *map, uintptr_t absPc);
uintptr_t ScdMapGetBase(ScdMap *map);
TraStatus ScdMapUpdata(ScdMap *map, uintptr_t start, uintptr_t end, size_t offset);
ScdMap *ScdMapCreate(uintptr_t start, uintptr_t end, size_t offset, const char *name);
void ScdMapDestroy(ScdMap **map);

#ifdef __cplusplus
}
#endif // __cplusplus
#endif