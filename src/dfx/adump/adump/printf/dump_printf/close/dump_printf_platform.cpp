/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include <cstring>
#include "runtime/base.h"
#include "runtime/dev.h"
#include "dump_printf_platform.h"

namespace {
constexpr size_t ADX_CORETYPE_ID_OFFSET = 50U;
constexpr size_t ADX_BLOCK_NUM = 75U;
constexpr size_t ADX_MAX_STR_LEN = 1024U * 1024U;
constexpr size_t ADX_SOC_VERSION_MAX = 50U;
constexpr const char* PREFIX_ASCEND910_95 = "Ascend910_95";
constexpr size_t ADX_MAX_AICORE_ON_ASCEND910_95 = 36U;
constexpr uint32_t ADX_SYNC_TIMEOUT = 60000U;
constexpr uint32_t ADX_DAVID_TIMEOUT = 60000U * 30U;
} // namespace

#ifdef __cplusplus
extern "C" {
#endif

bool AdxIsAscend91095();

bool AdxIsAscend91095()
{
    char socType[ADX_SOC_VERSION_MAX];
    if ((rtGetSocVersion(socType, ADX_SOC_VERSION_MAX) == RT_ERROR_NONE) &&
        (strncmp(socType, PREFIX_ASCEND910_95, strlen(PREFIX_ASCEND910_95)) == 0)) {
        return true;
    }

    return false;
}

size_t AdxGetCoreTypeIDOffset()
{
    if (AdxIsAscend91095()) {
        return ADX_MAX_AICORE_ON_ASCEND910_95 * 2;  //  2: 2 vector core in aicore
    }

    return ADX_CORETYPE_ID_OFFSET;
}

size_t AdxGetBlockNum() {
    if (AdxIsAscend91095()) {
        return ADX_MAX_AICORE_ON_ASCEND910_95 * 3;  //  3: 2 vector and 1 cube in aicore
    }

    return ADX_BLOCK_NUM;
}

bool AdxEnableSimtDump(size_t dumpWorkSpaceSize)
{
    // AdxGetBlockNum() * ADX_MAX_STR_LEN is the max dump workspace size for simd.
    return AdxIsAscend91095() && dumpWorkSpaceSize > AdxGetBlockNum() * ADX_MAX_STR_LEN;
}

 int32_t GetStreamSynchronizeTimeout()
{
    int32_t timeout = ADX_SYNC_TIMEOUT; // 超时时间设置为1分钟
    if (AdxIsAscend91095()) {
        timeout = ADX_DAVID_TIMEOUT;  // 82暂时设置30分钟
    }
    return timeout;
}

#ifdef __cplusplus
}
#endif