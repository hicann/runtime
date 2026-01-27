/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "base.hpp"
#include "base_info.hpp"
#include "internal_error_define.hpp"
#include "stars_david.hpp"

namespace cce {
namespace runtime {
rtError_t GetLaunchConfigAttr(rtLaunchAttribute_t* attr, LaunchTaskCfgInfo_t* launchTaskCfg)
{
    rtError_t error = RT_ERROR_NONE;
    switch (attr->id) {
        case RT_LAUNCH_ATTRIBUTE_BLOCKDIM:
            launchTaskCfg->blockDim = attr->value.blockDim;
            break;
        case RT_LAUNCH_ATTRIBUTE_DYNAMIC_SHARE_MEM_SIZE:
            launchTaskCfg->dynamicShareMemSize = attr->value.dynamicShareMemSize;
            break;
        case RT_LAUNCH_ATTRIBUTE_GROUP:
            launchTaskCfg->Group.groupDim = attr->value.Group.groupDim;
            launchTaskCfg->Group.groupBlockDim = attr->value.Group.groupBlockDim;
            break;
        case RT_LAUNCH_ATTRIBUTE_QOS:
            launchTaskCfg->qos = attr->value.qos;
            break;
        case RT_LAUNCH_ATTRIBUTE_PARTID:
            launchTaskCfg->partId = attr->value.partId;
            break;
        case RT_LAUNCH_ATTRIBUTE_SCHEMMODE:
            launchTaskCfg->schemMode = attr->value.schemMode;
            break;
        case RT_LAUNCH_ATTRIBUTE_BLOCKDIM_OFFSET:
            launchTaskCfg->blockDimOffset = attr->value.blockDimOffset;
            break;
        case RT_LAUNCH_ATTRIBUTE_DUMPFLAG:
            launchTaskCfg->dumpflag = attr->value.dumpflag;
            break;
        default:
            RT_LOG_OUTER_MSG_INVALID_PARAM(attr->id,
                "[" + std::to_string(RT_LAUNCH_ATTRIBUTE_BLOCKDIM) + ", " + std::to_string(RT_LAUNCH_ATTRIBUTE_MAX) + ")");
            error = RT_ERROR_INVALID_VALUE;
            break;
    }
    return error;
}

static rtError_t CheckLaunchCfg(const LaunchTaskCfgInfo_t* const launchTaskCfg)
{
    if (launchTaskCfg->schemMode >= RT_SCHEM_MODE_END) {
        RT_LOG_OUTER_MSG_INVALID_PARAM(launchTaskCfg->schemMode, "[0, " + std::to_string(RT_SCHEM_MODE_END) + ")");
        return RT_ERROR_INVALID_VALUE;
    }

    const uint32_t blockDim = launchTaskCfg->blockDim;
    const uint32_t groupDim = launchTaskCfg->Group.groupDim;
    const uint32_t groupBlockDim = launchTaskCfg->Group.groupBlockDim;

    if ((blockDim > UINT16_MAX) || (groupDim > UINT16_MAX) || (groupBlockDim > UINT16_MAX)) {
        RT_LOG_OUTER_MSG(RT_INVALID_ARGUMENT_ERROR,
            "Invalid block_dim(=%#x), group_dim(=%#x), or group_block_dim(=%#x). It exceeds 0xffff.",
            blockDim, groupDim, groupBlockDim);
        return RT_ERROR_INVALID_VALUE;
    }

    if (((groupDim != 0U) && (groupBlockDim == 0U)) || ((groupDim == 0U) && (groupBlockDim != 0U))) {
        RT_LOG_OUTER_MSG(RT_INVALID_ARGUMENT_ERROR,  "groupDim=%u and groupBlockDim=%u must both be zero or non-zero.",
            groupDim, groupBlockDim);
        return RT_ERROR_INVALID_VALUE;
    }

    if ((blockDim == 0) && (groupDim == 0)) {
        RT_LOG_OUTER_MSG(RT_INVALID_ARGUMENT_ERROR, "Invalid block_dim and group_dim/group_block_dim. They must all be 0.");
        return RT_ERROR_INVALID_VALUE;
    }

    if ((groupDim * groupBlockDim) > UINT16_MAX) {
        RT_LOG_OUTER_MSG(RT_INVALID_ARGUMENT_ERROR,
            "Invalid product of group_dim(=%#x) and group_block_dim(=%#x). It exceeds 0xffff.",
            groupDim, groupBlockDim);
        return RT_ERROR_INVALID_VALUE;
    }

    RT_LOG(RT_LOG_DEBUG, "Launch kernel, blockDim=%u, groupDim=%u, groupBlockDim=%u, schemMode=%hhu.",
        blockDim, groupDim, groupBlockDim, launchTaskCfg->schemMode);
    return RT_ERROR_NONE;
}

rtError_t GetLaunchConfigInfo(const rtLaunchConfig_t * const launchConfig, LaunchTaskCfgInfo_t* launchTaskCfg)
{
    rtError_t error = RT_ERROR_NONE;
    for (uint32_t i = 0U; i < launchConfig->numAttrs; i++) {
        rtLaunchAttribute_t* attr = &(launchConfig->attrs[i]);
        error = GetLaunchConfigAttr(attr, launchTaskCfg);
        COND_RETURN_WITH_NOLOG((error != RT_ERROR_NONE), error);
    }
    error = CheckLaunchCfg(launchTaskCfg);
    return error;
}

}  // namespace runtime
}  // namespace cce