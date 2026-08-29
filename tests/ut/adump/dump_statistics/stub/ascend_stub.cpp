/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "ascend_hal.h"
#include "kfc_dump_data_stub.h"
uint8_t sqBuffer[64 * 2048];

// 模拟 sq head/tail 的递增计数器。每次查询自增一次，使被测代码的
// "等待 sqHead 前进" 循环能够退出。该计数器是跨调用的模拟状态，
// 必须在每个用例开始前由 ResetSqCqStub() 重置，否则累积到 sqDepth
// 之后 sqHead 会越界，导致 WaitTaskFinish 的判断失效。
static uint32_t g_sqCqQueryCount = 0;

// 模拟驱动返回的 sq 深度。默认 2048，用例可改写以构造非法深度等场景。
static uint32_t g_stubSqDepth = STUB_DEFAULT_SQ_DEPTH;

static bool g_devIdConvertFail = false;
static int32_t g_sqQueryFailProp = -1;
static bool g_sqConfigFail = false;
static int64_t g_fixedSqHead = -1;

void ResetSqCqStub()
{
    g_sqCqQueryCount = 0;
    g_stubSqDepth = STUB_DEFAULT_SQ_DEPTH;
    g_devIdConvertFail = false;
    g_sqQueryFailProp = -1;
    g_sqConfigFail = false;
    g_fixedSqHead = -1;
}

void SetStubSqDepth(uint32_t depth) { g_stubSqDepth = depth; }

void SetStubDevIdConvertFail(bool fail) { g_devIdConvertFail = fail; }

void SetStubSqQueryFailProp(int32_t prop) { g_sqQueryFailProp = prop; }

void SetStubSqConfigFail(bool fail) { g_sqConfigFail = fail; }

void SetStubFixedSqHead(int64_t head) { g_fixedSqHead = head; }

drvError_t drvGetLocalDevIDByHostDevID(uint32_t hostDevId, uint32_t* localDevId)
{
    if (localDevId == nullptr) {
        return DRV_ERROR_INVALID_VALUE;
    }
    if (g_devIdConvertFail) {
        return DRV_ERROR_INNER_ERR;
    }
    *localDevId = hostDevId;
    return DRV_ERROR_NONE;
}

drvError_t halSqCqQuery(uint32_t devId, struct halSqCqQueryInfo* info)
{
    (void)devId;
    if (info == nullptr) {
        return DRV_ERROR_INNER_ERR;
    }
    uint32_t& count = g_sqCqQueryCount;
    auto queryInfo = *info;
    if (g_sqQueryFailProp >= 0 && static_cast<int32_t>(queryInfo.prop) == g_sqQueryFailProp) {
        return DRV_ERROR_INNER_ERR;
    }
    switch (queryInfo.prop) {
        case DRV_SQCQ_PROP_SQ_HEAD: {
            // 固定 head 用于构造 "head 不前进"：SQ 满等待与任务完成等待均会超时
            info->value[0] = (g_fixedSqHead >= 0) ? static_cast<uint32_t>(g_fixedSqHead) : count;
            if (g_fixedSqHead < 0) {
                count++;
            }
            return DRV_ERROR_NONE;
        }
        case DRV_SQCQ_PROP_SQ_DEPTH: {
            info->value[0] = g_stubSqDepth;
            return DRV_ERROR_NONE;
        }
        case DRV_SQCQ_PROP_SQ_TAIL: {
            info->value[0] = count;
            count++;
            return DRV_ERROR_NONE;
        }
        case DRV_SQCQ_PROP_SQ_BASE: {
            uint8_t* buffer = sqBuffer;
            info->value[0] = reinterpret_cast<uintptr_t>(buffer) & 0xFFFFFFFF;
            info->value[1] = reinterpret_cast<uintptr_t>(buffer) >> 32;
            return DRV_ERROR_NONE;
        }
        default:
            return DRV_ERROR_NONE;
    }
}

drvError_t halSqCqConfig(uint32_t devId, struct halSqCqConfigInfo* configInfo)
{
    (void)devId;
    (void)configInfo;
    if (g_sqConfigFail) {
        return DRV_ERROR_INNER_ERR;
    }
    return DRV_ERROR_NONE;
}
