/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "ctrl_stream.hpp"
#include "error_message_manage.hpp"

namespace cce {
namespace runtime {
rtError_t CtrlStream::Setup()
{
    // alloc sq cq id, logic id, use primary stream id for ctrlstream id
    uint32_t sqId = 0U;
    uint32_t cqId = 0U;
    uint32_t logicCqId = 0U;
    bool isFastCq = false;
    rtError_t error = Device_()->Driver_()->LogicCqAllocate(Device_()->Id_(), Device_()->DevGetTsId(),
        static_cast<uint32_t>(Id_()), false, logicCqId, isFastCq, true);
    if (error != RT_ERROR_NONE) {
        RT_LOG(RT_LOG_WARNING, "[ctrlsq]Alloc logicCq fail, retCode=%#x.", error);
        return error;
    }
    error = Device_()->Driver_()->CtrlSqCqAllocate(Device_()->Id_(), Device_()->DevGetTsId(),
        &sqId, &cqId, logicCqId);
    if (error != RT_ERROR_NONE) {
        RT_LOG(RT_LOG_WARNING, "[ctrlsq]Alloc sq cq fail, retCode=%#x.", error);
        const rtError_t error0 = Device_()->Driver_()->LogicCqFree(Device_()->Id_(), Device_()->DevGetTsId(), logicCqId);
        if (error0 != RT_ERROR_NONE) {
            RT_LOG(RT_LOG_WARNING, "[ctrlsq]free logic_cq=%u, retCode=%#x.", logicCqId, error);
        }
        return error;
    }

    RT_LOG(RT_LOG_INFO, "[ctrlsq]alloc sq cq success: deviceId=%u, sqId=%u, cqId=%u",
           Device_()->Id_(), sqId, cqId);
    sqId_ = sqId;
    cqId_ = cqId;
    SetLogicalCqId(logicCqId);
    return RT_ERROR_NONE;
}

CtrlStream::~CtrlStream() noexcept
{
    rtError_t error = RT_ERROR_NONE;
    if (!posToCtrlTaskIdMap_.empty()) {
        Synchronize();
    }

    if ((sqId_ != UINT32_MAX) && (cqId_ != UINT32_MAX)) {
        error = Device_()->Driver_()->CtrlSqCqFree(Device_()->Id_(), Device_()->DevGetTsId(), sqId_, cqId_);
        if (error != RT_ERROR_NONE) {
            RT_LOG(RT_LOG_WARNING, "[ctrlsq]free sq=%u cq=%u fail, retCode=%#x.", sqId_, cqId_, error);
        }
    }

    if (GetLogicalCqId() != UINT32_MAX) {
        error = Device_()->Driver_()->LogicCqFree(Device_()->Id_(), Device_()->DevGetTsId(), GetLogicalCqId());
        if (error != RT_ERROR_NONE) {
            RT_LOG(RT_LOG_WARNING, "[ctrlsq]free logic_cq=%u, retCode=%#x.", GetLogicalCqId(), error);
        }
    }
}

rtError_t CtrlStream::GetTaskIdByPos(const uint16_t recycleHead, uint32_t &taskId)
{
    const std::lock_guard<std::mutex> stmLock(posToCtrlTaskIdMapLock_);
    std::unordered_map<uint16_t, uint16_t>::iterator it = posToCtrlTaskIdMap_.find(recycleHead);
    if (it == posToCtrlTaskIdMap_.end()) {
        RT_LOG(RT_LOG_DEBUG, "[ctrlsq]recycleHead=%hu is not in map.", recycleHead);
        return RT_ERROR_INVALID_VALUE;
    }
    taskId = it->second;
    RT_LOG(RT_LOG_INFO, "[ctrlsq]Get task_id=%u by recycleHead=%hu success.", taskId, recycleHead);
    return RT_ERROR_NONE;
}

rtError_t CtrlStream::GetHeadPosFromCtrlSq(uint32_t &sqHead)
{
    uint16_t pos = 0U;
    const uint32_t sqId = GetSqId();
    const uint32_t tsId = Device_()->DevGetTsId();

    const rtError_t error = Device_()->Driver_()->GetCtrlSqHead(Device_()->Id_(), tsId, sqId, pos);
    COND_RETURN_ERROR_MSG_INNER(error != RT_ERROR_NONE, error, "Query sq head failed, retCode=%#x",
        static_cast<uint32_t>(error));
    sqHead = (sqDepth + pos - 1U) % sqDepth;
    RT_LOG(RT_LOG_DEBUG, "[ctrlsq]get ctrl sq head tsId=%u, sqId=%u, pos=%u, sqHead=%u.", tsId, sqId, pos, sqHead);
    return RT_ERROR_NONE;
}

rtError_t CtrlStream::Synchronize()
{
    constexpr bool queryFlag = true;
    uint32_t currPosId = UINT32_MAX;
    const uint32_t lastPosId = sqTailPos_;
    uint32_t taskId = UINT32_MAX;
    rtError_t error;
    uint16_t tryCount = 0U;
    RT_LOG(RT_LOG_DEBUG, "[ctrlsq]start:Synchronize stream_id=%d, tailPos=%u.", Id_(), lastPosId);
    while (queryFlag && (device_->GetDevRunningState() == static_cast<uint32_t>(DEV_RUNNING_NORMAL))) {
        StreamSyncLock();
        error = GetHeadPosFromCtrlSq(currPosId);
        if (error != RT_ERROR_NONE) {
            RT_LOG(RT_LOG_ERROR, "GetHeadPosFromCtrlSq fail, error=%d", error);
            StreamSyncUnLock();
            return error;
        }
        Device_()->CtrlTaskReclaimByPos(this, currPosId);
        error = GetTaskIdByPos(lastPosId, taskId);
        StreamSyncUnLock();
        if (error != RT_ERROR_NONE) {
            RT_LOG(RT_LOG_INFO, "[ctrlsq] lastPosId=%u is recycled.", lastPosId);
            break;
        }
        if (tryCount >= CTRLSQ_SYNC_CNT) {
            (void)mmSleep(1U);
        }
        tryCount++;
    }
    return RT_ERROR_NONE;
}

rtError_t CtrlStream::AddTaskToStream(const uint32_t pos, const TaskInfo * const tsk)
{
    NULL_PTR_RETURN_MSG(tsk, RT_ERROR_TASK_NULL);

    RT_LOG(RT_LOG_INFO, "[ctrlsq]ctrl stream_id=%d, task_id=%hu, type=%d(%s), pos=%u",
        streamId_, tsk->id, static_cast<int32_t>(tsk->type), tsk->typeName, pos);

    const std::lock_guard<std::mutex> stmLock(posToCtrlTaskIdMapLock_);
    posToCtrlTaskIdMap_[pos] = tsk->id;

    return RT_ERROR_NONE;
}

void CtrlStream::DelPosToCtrlTaskIdMap(uint16_t pos)
{
    const std::lock_guard<std::mutex> stmLock(posToCtrlTaskIdMapLock_);
    const auto it = posToCtrlTaskIdMap_.find(pos);
    if (it == posToCtrlTaskIdMap_.end()) {
        RT_LOG(RT_LOG_INFO, "[ctrlsq]pos=%u is not in ctrl map", pos);
        return;
    }
    RT_LOG(RT_LOG_DEBUG, "[ctrlsq]pos=%u is deleted in ctrl map", pos);
    (void)posToCtrlTaskIdMap_.erase(pos);
}

}  // namespace runtime
}  // namespace cce
