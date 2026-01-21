/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "capability.hpp"
#include "runtime.hpp"

namespace cce {
namespace runtime {
// 能力集请在此处添加
static uint32_t g_rtCapabilityTbl[] = {
    RUNTIME_FEATURE_BASE,
    RUNTIME_FEATURE_MORE_LABEL,
    RUNTIME_FEATURE_AIC_ERR_EXT_REG,
    RUNTIME_FEATURE_SNAPSHOT_ERR,
    RUNTIME_FEATURE_D2D_CPY_OFFSET,
    RUNTIME_FEATURE_LOG_TOHOST,
    RUNTIME_FEATURE_SEND_DEVICE_ID,
    RUNTIME_FEATURE_MC2_ENHANCE,
    RUNTIME_FEATURE_STREAM_EXPAND
};

const uint32_t *GetRtCapabilityTbl(void)
{
    return g_rtCapabilityTbl;
}

uint32_t GetRtCapabilityTblLen(void)
{
    return (sizeof(g_rtCapabilityTbl) / sizeof(g_rtCapabilityTbl[0]));
}

static uint16_t g_featureToTsVersionMapForTRUNK[RT_FEATURE_MAX] = {0U};
static uint16_t g_featureToTsVersionMapForV1R1C13[RT_FEATURE_MAX] = {0U};
static uint16_t g_featureToTsVersionMapForV1R1C30[RT_FEATURE_MAX] = {0U};
static uint16_t g_featureToTsVersionMapForV1R1C15[RT_FEATURE_MAX] = {0U};
static uint16_t g_featureToTsVersionMapForV1R1C17[RT_FEATURE_MAX] = {0U};
static uint16_t g_featureToTsVersionMapForV1R1C18[RT_FEATURE_MAX] = {0U};

void FeatureToTsVersionInit(void)
{
    /* br_hisi_trunk_ai */
    g_featureToTsVersionMapForTRUNK[RT_FEATURE_STARS_COMPATIBILITY] = 16U;
    g_featureToTsVersionMapForTRUNK[RT_FEATURE_IPC_NOTICE_DC] = 17U;
    g_featureToTsVersionMapForTRUNK[RT_FEATURE_OVER_FLOW_DEBUG] = 18U;
    g_featureToTsVersionMapForTRUNK[RT_FEATURE_D2D_ADDR_ASYNC] = 19U;
    g_featureToTsVersionMapForTRUNK[RT_FEATURE_FLIPTASK] = 20U;
    g_featureToTsVersionMapForTRUNK[RT_FEATURE_FFTSPLUS_TIMEOUT] = 21U;
    g_featureToTsVersionMapForTRUNK[RT_FEATURE_FFTSPLUS_TASKID_SAME_FIX] = 22U;
    g_featureToTsVersionMapForTRUNK[RT_FEATURE_MC2_RTS_SUPPORT_HCCL] = 23U;
    g_featureToTsVersionMapForTRUNK[RT_FEATURE_IPC_NOTICE_910_B_93] = 24U;
    g_featureToTsVersionMapForTRUNK[RT_FEATURE_MC2_RTS_SUPPORT_HCCL_DC] = 25U;
    g_featureToTsVersionMapForTRUNK[RT_FEATURE_SUPPORT_REDUCEASYNC_V2_DC] = 26U;
    g_featureToTsVersionMapForTRUNK[RT_FEATURE_TILING_KEY_SINK] = TS_VERSION_TILING_KEY_SINK;
    g_featureToTsVersionMapForTRUNK[RT_FEATURE_MC2_ENHANCE] = TS_VERSION_MC2_ENHANCE;
    g_featureToTsVersionMapForTRUNK[RT_FEATURE_FFTSPLUS_TASKID_SAME_FOR_ALL] = TS_VERSION_TASK_SAME_FOR_ALL;
    g_featureToTsVersionMapForTRUNK[RT_FEATURE_TASK_ABORT] = TS_VERSION_TASK_ABORT;

    g_featureToTsVersionMapForV1R1C30[RT_FEATURE_STARS_COMPATIBILITY] = 16U;
    g_featureToTsVersionMapForV1R1C30[RT_FEATURE_FFTSPLUS_TASKID_SAME_FIX] = 17U;

    g_featureToTsVersionMapForV1R1C13[RT_FEATURE_STARS_COMPATIBILITY] = 16U;
    g_featureToTsVersionMapForV1R1C13[RT_FEATURE_IPC_NOTICE_DC] = 17U;
    g_featureToTsVersionMapForV1R1C13[RT_FEATURE_FFTSPLUS_TASKID_SAME_FIX] = 18U;

    g_featureToTsVersionMapForV1R1C15[RT_FEATURE_STARS_COMPATIBILITY] = 16U;
    g_featureToTsVersionMapForV1R1C15[RT_FEATURE_IPC_NOTICE_DC] = 17U;
    g_featureToTsVersionMapForV1R1C15[RT_FEATURE_OVER_FLOW_DEBUG] = 18U;
    g_featureToTsVersionMapForV1R1C15[RT_FEATURE_D2D_ADDR_ASYNC] = 19U;
    g_featureToTsVersionMapForV1R1C15[RT_FEATURE_FLIPTASK] = 20U;
    g_featureToTsVersionMapForV1R1C15[RT_FEATURE_FFTSPLUS_TIMEOUT] = 21U;
    g_featureToTsVersionMapForV1R1C15[RT_FEATURE_FFTSPLUS_TASKID_SAME_FIX] = 22U;
    g_featureToTsVersionMapForV1R1C15[RT_FEATURE_MC2_RTS_SUPPORT_HCCL] = 23U;
    g_featureToTsVersionMapForV1R1C15[RT_FEATURE_MC2_RTS_SUPPORT_HCCL_DC] = 0xFFU; // not support mc2
    g_featureToTsVersionMapForV1R1C15[RT_FEATURE_SUPPORT_REDUCEASYNC_V2_DC] = 26U;
    g_featureToTsVersionMapForV1R1C15[RT_FEATURE_FFTSPLUS_TASKID_SAME_FOR_ALL] = 27U;

    g_featureToTsVersionMapForV1R1C17[RT_FEATURE_STARS_COMPATIBILITY] = 16U;
    g_featureToTsVersionMapForV1R1C17[RT_FEATURE_IPC_NOTICE_DC] = 17U;
    g_featureToTsVersionMapForV1R1C17[RT_FEATURE_OVER_FLOW_DEBUG] = 18U;
    g_featureToTsVersionMapForV1R1C17[RT_FEATURE_D2D_ADDR_ASYNC] = 19U;
    g_featureToTsVersionMapForV1R1C17[RT_FEATURE_FLIPTASK] = 20U;
    g_featureToTsVersionMapForV1R1C17[RT_FEATURE_FFTSPLUS_TIMEOUT] = 21U;
    g_featureToTsVersionMapForV1R1C17[RT_FEATURE_FFTSPLUS_TASKID_SAME_FIX] = 22U;
    g_featureToTsVersionMapForV1R1C17[RT_FEATURE_MC2_RTS_SUPPORT_HCCL] = 23U;
    g_featureToTsVersionMapForV1R1C17[RT_FEATURE_IPC_NOTICE_910_B_93] = 24U;
    g_featureToTsVersionMapForV1R1C17[RT_FEATURE_MC2_RTS_SUPPORT_HCCL_DC] = 25U;
    g_featureToTsVersionMapForV1R1C17[RT_FEATURE_SUPPORT_REDUCEASYNC_V2_DC] = 26U;

    g_featureToTsVersionMapForV1R1C18[RT_FEATURE_STARS_COMPATIBILITY] = 16U;
    g_featureToTsVersionMapForV1R1C18[RT_FEATURE_IPC_NOTICE_DC] = 17U;
    g_featureToTsVersionMapForV1R1C18[RT_FEATURE_OVER_FLOW_DEBUG] = 18U;
    g_featureToTsVersionMapForV1R1C18[RT_FEATURE_D2D_ADDR_ASYNC] = 19U;
    g_featureToTsVersionMapForV1R1C18[RT_FEATURE_FLIPTASK] = 20U;
    g_featureToTsVersionMapForV1R1C18[RT_FEATURE_FFTSPLUS_TIMEOUT] = 21U;
    g_featureToTsVersionMapForV1R1C18[RT_FEATURE_FFTSPLUS_TASKID_SAME_FIX] = 22U;
    g_featureToTsVersionMapForV1R1C18[RT_FEATURE_MC2_RTS_SUPPORT_HCCL] = 23U;
    g_featureToTsVersionMapForV1R1C18[RT_FEATURE_IPC_NOTICE_910_B_93] = 24U;
    g_featureToTsVersionMapForV1R1C18[RT_FEATURE_MC2_RTS_SUPPORT_HCCL_DC] = 25U;
    g_featureToTsVersionMapForV1R1C18[RT_FEATURE_SUPPORT_REDUCEASYNC_V2_DC] = 26U;
    g_featureToTsVersionMapForV1R1C18[RT_FEATURE_TILING_KEY_SINK] = TS_VERSION_TILING_KEY_SINK;
    g_featureToTsVersionMapForV1R1C18[RT_FEATURE_MC2_ENHANCE] = TS_VERSION_MC2_ENHANCE;
    g_featureToTsVersionMapForV1R1C18[RT_FEATURE_FFTSPLUS_TASKID_SAME_FOR_ALL] = TS_VERSION_TASK_SAME_FOR_ALL;
    return;
}

bool CheckFeatureIsSupportOld(const uint32_t tschVersion, rtFeature feature)
{
    if (feature >= RT_FEATURE_MAX) {
        RT_LOG(RT_LOG_WARNING, "bad feature=%d, tschVersion=%u", feature, tschVersion);
        return false;
    }
    // Not stars, use the code branch, this is TS_BRANCH_TRUNK.
    const RtTschBranch branch = static_cast<RtTschBranch>(tschVersion >> 16U);
    const uint16_t actualTsVersion = static_cast<uint16_t>(tschVersion & 0xFFFFU);
    uint16_t expectVersion;

    switch (branch) {
        case TS_BRANCH_V1R1C13: {
            expectVersion = g_featureToTsVersionMapForV1R1C13[feature];
            break;
        }
        case TS_BRANCH_V1R1C30: {
            expectVersion = g_featureToTsVersionMapForV1R1C30[feature];
            break;
        }
        case TS_BRANCH_TRUNK: {
            expectVersion = g_featureToTsVersionMapForTRUNK[feature];
            break;
        }
        case TS_BRANCH_V1R1C15: {
            expectVersion = g_featureToTsVersionMapForV1R1C15[feature];
            break;
        }
        case TS_BRANCH_V1R1C17: {
            expectVersion = g_featureToTsVersionMapForV1R1C17[feature];
            break;
        }
        case TS_BRANCH_V1R1C18: {
            expectVersion = g_featureToTsVersionMapForV1R1C18[feature];
            break;
        }
        default:
            return false;
    }
    if (expectVersion == 0U) {
        return false;
    }
    if (actualTsVersion >= expectVersion) {
        RT_LOG(RT_LOG_DEBUG, "support feature=%d, tschVersion=%u, expectVersion=%u",
            feature, tschVersion, expectVersion);
        return true;
    }
    return false;
}

bool CheckSupportMC2Feature(Device * const dev)
{
    uint32_t tsFeature = dev->GetDevProperties().mc2FeatureFlag;
    if (tsFeature == 0U) {
        return false;
    }
    return dev->CheckFeatureSupport(tsFeature);
}

bool CheckSupportTilingKeyWhenCompile()
{
    const uint8_t tilingKeyFlag = Runtime::Instance()->GetTilingkeyFlag();
    if (tilingKeyFlag != UINT8_MAX) { // support capability solution
        return static_cast<bool>(tilingKeyFlag);
    } else {
        const int32_t tschVersion = Runtime::Instance()->GetTsVersion();
        const bool isSupport = CheckFeatureIsSupportOld(tschVersion, RT_FEATURE_TILING_KEY_SINK);
        return isSupport;
    }
}
}  // namespace runtime
}  // namespace cce