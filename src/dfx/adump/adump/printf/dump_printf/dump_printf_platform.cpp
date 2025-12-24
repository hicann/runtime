/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "dump_printf_platform.h"
#include "log/adx_log.h"

namespace {
constexpr size_t ADX_CORETYPE_ID_OFFSET = 50U;
constexpr size_t ADX_BLOCK_NUM = 75U;
constexpr uint32_t ADX_SYNC_TIMEOUT = 60000U;
} // namespace

#ifdef __cplusplus
extern "C" {
#endif

size_t AdxGetCoreTypeIDOffset()
{
    return ADX_CORETYPE_ID_OFFSET;
}

size_t AdxGetBlockNum() {
    return ADX_BLOCK_NUM;
}

bool AdxEnableSimtDump(size_t dumpWorkSpaceSize)
{
    UNUSED(dumpWorkSpaceSize);
    return false;
}

int32_t GetStreamSynchronizeTimeout()
{
    int32_t timeout = ADX_SYNC_TIMEOUT; // 超时时间设置为1分钟
    return timeout;
}

#ifdef __cplusplus
}
#endif
