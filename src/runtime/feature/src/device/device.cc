/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "device.hpp"
#include <chrono>
#include "raw_device.hpp"
#include "uma_arg_loader.hpp"
#include "runtime.hpp"
#include "ctrl_stream.hpp"
#include "tsch_stream.hpp"
#include "stream_sqcq_manage.hpp"
#include "program.hpp"
#include "module.hpp"
#include "api.hpp"
#include "driver/ascend_hal.h"
#include "task.hpp"
#include "device/device_error_proc.hpp"
#include "error_message_manage.hpp"
#include "thread_local_container.hpp"
#include "inner_thread_local.hpp"
#include "aicpu_err_msg.hpp"
#include "dvpp_grp.hpp"
#include "task_info.hpp"
#include "task_submit.hpp"
#include "event.hpp"
#include "ctrl_res_pool.hpp"
#include "stream_factory.hpp"

namespace cce {
namespace runtime {
constexpr int32_t MIN_GROUP_ID = 0;
bool g_isAddrFlatDevice = false;

rtError_t GroupDevice::FillCache(struct capability_group_info capGroupInfos[], const uint32_t groupCount)
{
    const rtError_t error = Driver_()->GetCapabilityGroupInfo(static_cast<int32_t>(Id_()),
        static_cast<int32_t>(DevGetTsId()), -1,  capGroupInfos, static_cast<int32_t>(groupCount));
    COND_RETURN_WITH_NOLOG((error != RT_ERROR_NONE), error);

    groupInfoCache_.clear();
    defaultGroup_ = -1;
    for (uint32_t i = 0U; i < groupCount; i++) {
        if (capGroupInfos[i].state == 0U) {
            continue;
        }
        if (groupInfoCache_.find(static_cast<int32_t>(capGroupInfos[i].group_id)) != groupInfoCache_.end()) {
            RT_LOG_INNER_MSG(RT_LOG_ERROR, "Group id %u already exists.", capGroupInfos[i].group_id);
            groupInfoCache_.clear();
            return RT_ERROR_GROUP_NOT_CREATE;
        }
        rtGroupInfo_t rtGrpInfo;
        rtGrpInfo.groupId = static_cast<int32_t>(capGroupInfos[i].group_id);
        rtGrpInfo.flag = capGroupInfos[i].extend_attribute;
        rtGrpInfo.aicoreNum = capGroupInfos[i].aicore_number;
        rtGrpInfo.aicpuNum = capGroupInfos[i].aicpu_number;
        rtGrpInfo.aivectorNum = capGroupInfos[i].aivector_number;
        rtGrpInfo.sdmaNum = capGroupInfos[i].sdma_number;
        rtGrpInfo.activeStreamNum = capGroupInfos[i].active_sq_number;
        RT_LOG(RT_LOG_INFO, "get groupID=%u, extend_attribute=%u, vfID=%u, poolID=%u, poolIDMax=%u, "
            "aicoreNum=%u, aivectorNum=%u.",
            capGroupInfos[i].group_id, capGroupInfos[i].extend_attribute, capGroupInfos[i].vfid,
            capGroupInfos[i].poolid, capGroupInfos[i].poolid_max, capGroupInfos[i].aicore_number,
            capGroupInfos[i].aivector_number);
        if ((rtGrpInfo.flag & 0x01U) == 0x01U) { // git bit 0
            if (defaultGroup_ == -1) {
                defaultGroup_ = rtGrpInfo.groupId;
            } else {
                RT_LOG_INNER_MSG(RT_LOG_ERROR, "More than one default group: %d and %d", defaultGroup_,
                    rtGrpInfo.groupId);
                groupInfoCache_.clear();
                defaultGroup_ = -1;
                return RT_ERROR_GROUP_NOT_CREATE;
            }
        }
        (void)groupInfoCache_.insert(std::pair<int32_t, rtGroupInfo_t>(capGroupInfos[i].group_id, rtGrpInfo));
    }
    return RT_ERROR_NONE;
}

rtError_t GroupDevice::GroupInfoSetup()
{
    halCapabilityInfo capabilityInfo;
    (void)memset_s(&capabilityInfo, sizeof(halCapabilityInfo), 0U, sizeof(halCapabilityInfo));
    rtError_t error = Driver_()->GetChipCapability(Id_(), &capabilityInfo);
    if (error != RT_ERROR_NONE) {
        RT_LOG_INNER_MSG(RT_LOG_ERROR, "GetChipCapability failed, retCode=%#x, deviceId=%u.",
                         static_cast<uint32_t>(error), Id_());
        return error;
    }
    RT_LOG(RT_LOG_INFO, "ts_group_number=%u.", capabilityInfo.ts_group_number);
    if (capabilityInfo.ts_group_number > 0U) {
        capability_group_info * const capGroupInfos =
            new (std::nothrow) capability_group_info[capabilityInfo.ts_group_number];
        NULL_PTR_RETURN_MSG(capGroupInfos, RT_ERROR_MEMORY_ALLOCATION);
        (void)memset_s(capGroupInfos, sizeof(capability_group_info) * capabilityInfo.ts_group_number,
            0U, sizeof(capability_group_info) * capabilityInfo.ts_group_number);
        error = FillCache(capGroupInfos, capabilityInfo.ts_group_number);
        delete []capGroupInfos;
        if (error == RT_ERROR_DRV_NOT_SUPPORT) {
            return RT_ERROR_NONE;
        }
        if (error != RT_ERROR_NONE) {
            RT_LOG_INNER_MSG(RT_LOG_ERROR, "FillCache failed, retCode=%#x, tsGroupNum=%u.",
                             static_cast<uint32_t>(error), capabilityInfo.ts_group_number);
            return error;
        }
    }

    if ((groupInfoCache_.size() > 1U) && (defaultGroup_ == -1)) {
        RT_LOG(RT_LOG_WARNING, "Multiple groups have been created, but no default group exists."
                               "Please use rtSetGroup to set a group first!");
    }

    return RT_ERROR_NONE;
}

rtError_t GroupDevice::QueryGroupInfo()
{
    uint32_t info = static_cast<uint32_t>(RT_RUN_MODE_RESERVED);
    (void)drvGetPlatformInfo(&info);
    RT_LOG(RT_LOG_DEBUG, "[drv api]drvGetPlatformInfo info=%u.", info);
    isFirstQryGrpInfoMux_.lock();
    if ((info == RT_RUN_MODE_OFFLINE) && isFirstQryGrpInfo_) {
        const rtError_t error = GroupInfoSetup();
        if (error != RT_ERROR_NONE) {
            isFirstQryGrpInfoMux_.unlock();
            RT_LOG(RT_LOG_ERROR, "GroupInfoSetup fail, error=%d, info=%u.", error, info);
            return error;
        }
        isFirstQryGrpInfo_ = false;
        RT_LOG(RT_LOG_DEBUG, "isFirstQryGrpInfo_=%d.", isFirstQryGrpInfo_);
    }
    isFirstQryGrpInfoMux_.unlock();
    return RT_ERROR_NONE;
}
rtError_t GroupDevice::GetGroupInfo(const int32_t grpId, rtGroupInfo_t * const info, const uint32_t cnt)
{
    if (IsSupportFeature(RtOptionalFeatureType::RT_FEATURE_DEVICE_GROUP_INFO_SETUP_DOT_ON_DEMIND)) {
        (void)QueryGroupInfo();
    }

    if (groupInfoCache_.empty() || ((grpId != -1) && (groupInfoCache_.find(grpId) == groupInfoCache_.end()))) {
        RT_LOG_INNER_MSG(RT_LOG_ERROR, "Get group info failed, groupId=%d, count=%u, groupInfo size=%zu(bytes)",
                         grpId, cnt, groupInfoCache_.size());
        return RT_ERROR_GROUP_NOT_CREATE;
    }
    if (grpId == -1) {
        uint32_t i = 0U;
        for (const auto &it:groupInfoCache_) {
            info[i] = it.second;
            i++;
        }
    } else {
        *info = groupInfoCache_[grpId];
    }
    return RT_ERROR_NONE;
}

rtError_t GroupDevice::GetGroupCount(uint32_t * const cnt)
{
    NULL_PTR_RETURN_MSG_OUTER(cnt, RT_ERROR_INVALID_VALUE);

    if (IsSupportFeature(RtOptionalFeatureType::RT_FEATURE_DEVICE_GROUP_INFO_SETUP_DOT_ON_DEMIND)) {
        (void)QueryGroupInfo();
    }

    *cnt = static_cast<uint32_t>(groupInfoCache_.size());
    return RT_ERROR_NONE;
}

rtError_t GroupDevice::SetGroup(const int32_t grpId)
{
    const int32_t maxGroupId = GetDevProperties().maxGroupId;
    if ((grpId < MIN_GROUP_ID) || (grpId > maxGroupId)) {
        RT_LOG_OUTER_MSG_INVALID_PARAM(grpId,
            "[" + std::to_string(MIN_GROUP_ID) + ", " + std::to_string(maxGroupId) + "]");
        return RT_ERROR_INVALID_VALUE;
    }

    if (IsSupportFeature(RtOptionalFeatureType::RT_FEATURE_DEVICE_GROUP_DOT_ON_DEMAND)) {
        (void)QueryGroupInfo();
    }

    if (groupInfoCache_.find(grpId) == groupInfoCache_.end()) {
        RT_LOG_INNER_MSG(RT_LOG_ERROR, "Group id %d does not exist.", grpId);
        return RT_ERROR_GROUP_NOT_CREATE;
    }

    if (IsSupportFeature(RtOptionalFeatureType::RT_FEATURE_DEVICE_GROUP_THREAD_LOCAL)) {
        InnerThreadLocalContainer::SetGroupId(static_cast<uint8_t>(grpId));
    }

    groupId_ = static_cast<uint8_t>(grpId);
    return RT_ERROR_NONE;
}

rtError_t GroupDevice::ResetGroup()
{
    groupId_ = lastGroupId_;
    vfId_ = lastVfId_;
    Driver_()->vfId_ = lastVfId_;
    poolId_ = lastPoolId_;
    poolIdMax_ = lastPoolIdMax_;
    return RT_ERROR_NONE;
}
}  // namespace runtime
}  // namespace cce
