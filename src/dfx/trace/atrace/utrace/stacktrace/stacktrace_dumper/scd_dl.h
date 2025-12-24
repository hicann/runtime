/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef SCD_DL_H
#define SCD_DL_H

#include "atrace_types.h"
#include "scd_elf.h"
#include "scd_memory.h"

#ifdef __cplusplus
extern "C" {
#endif // __cplusplus


typedef struct ScdDl {
    int32_t   pid;
    int32_t   fd;
    ScdMemory memory;
    
    //ELF
    ScdElf     elf;
    bool       elfLoaded;
} ScdDl;


TraStatus ScdDlLoad(ScdDl *dl, int32_t pid, const char *dlName);
TraStatus ScdDlInit(ScdDl *dl);
void ScdDlUninit(ScdDl *dl);

#ifdef __cplusplus
}
#endif // __cplusplus
#endif