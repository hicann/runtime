/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "scd_frame.h"
#include "scd_regs.h"
#include "scd_maps.h"
#include "scd_log.h"
#include "adiag_utils.h"

ScdFrame *ScdFrameCreate(ScdMap *map, uintptr_t pc, uintptr_t sp, uintptr_t fp)
{
    ScdFrame *frame = AdiagMalloc(sizeof(ScdFrame));
    if (frame != NULL) {
        frame->map = map;
        frame->num = 0;
        frame->fp = fp;
        frame->sp = sp;
        frame->pc = pc;
        frame->relPc = pc;
        frame->tid = 0;
        frame->funcName[0] = '\0';
        frame->funcOffset = 0;
        errno_t err = strcpy_s(frame->soName, SCD_DL_NAME_LENGTH, map->name);
        if (err != EOK) {
            SCD_DLOG_ERR("strcpy_s failed! err=%d\n", (int32_t)err);
        }
    }
    return frame;
}

void ScdFrameDestroy(ScdFrame **frame)
{
    if ((frame != NULL) && (*frame != NULL)) {
        ADIAG_SAFE_FREE(*frame);
    }
}