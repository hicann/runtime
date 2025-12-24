/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "scd_memory_local.h"
#include "scd_memory.h"
#include "scd_log.h"
#include "securec.h"

size_t ScdMemoryLocalRead(uintptr_t addr , void *dst, size_t size)
{
    errno_t err = memcpy_s(dst, size, (const void *)addr, size);
    if (err != EOK) {
        SCD_DLOG_ERR("memcpy_s failed, err = %d, size : %zu", (int32_t)err, size);
        return 0;
    }
    return size;
}