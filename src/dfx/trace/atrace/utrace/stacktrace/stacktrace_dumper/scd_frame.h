/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef SCD_FRAME_H
#define SCD_FRAME_H

#include "atrace_types.h"
#include "scd_map.h"

#ifdef __cplusplus
extern "C" {
#endif // __cplusplus

#define SCD_FRAME_LENGTH  1024U

typedef struct ScdFrame {
    ScdMap    *map;
    uint32_t   num;
    int32_t    tid;
    uintptr_t  pc;
    uintptr_t  relPc;   // pc in exec process
    uintptr_t  sp;
    uintptr_t  fp;
    uintptr_t  base;
    char       soName[SCD_DL_NAME_LENGTH];
    char       funcName[SCD_FUNC_NAME_LENGTH];
    size_t     funcOffset;
} ScdFrame;

ScdFrame *ScdFrameCreate(ScdMap *map, uintptr_t pc, uintptr_t sp, uintptr_t fp);
void ScdFrameDestroy(ScdFrame **frame);

#ifdef __cplusplus
}
#endif // __cplusplus
#endif