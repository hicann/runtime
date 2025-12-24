/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "log_communication_stub.h"

#define MAX_LOOP    10
int32_t LogGetSigNo_stub(void)
{
    static int32_t count = 0;
    count++;
    if (count < MAX_LOOP) {
        return 0;
    }
    return 1;
}

static char g_buffer[1024] = { 0 };
void SlogdFlushToBuf_stub(const char *msg, uint32_t msgLen, const LogInfo *info)
{
    memcpy_s(g_buffer, 1023, msg, msgLen);
    (void)info;
}

const char *GetBufferStr(void)
{
    return g_buffer;
}