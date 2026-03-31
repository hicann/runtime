/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "stream_sqcq_manage_xpu.hpp"
#include "base.hpp"
#include "xpu_driver.hpp"
#include "stream_xpu.hpp"
#include "error_message_manage.hpp"

namespace cce {
namespace runtime {
XpuStreamSqCqManage::XpuStreamSqCqManage(Device *const dev) : StreamSqCqManage(dev)
{}

rtError_t XpuStreamSqCqManage::AllocXpuStreamSqCq(const Stream *const newStm)
{
    const std::lock_guard<std::mutex> stmLock(streamMapLock_);
    int32_t streamId = newStm->Id_();
    const auto sqItor = streamIdToSqIdMap_.find(streamId);
    if (unlikely(sqItor != streamIdToSqIdMap_.end())) {
        RT_LOG(RT_LOG_ERROR, "SQ id is duplicate, stream_id=%d.", streamId);
        return RT_ERROR_STREAM_DUPLICATE;
    }

    const auto cqItor = streamIdToCqIdMap_.find(streamId);
    if (unlikely(cqItor != streamIdToCqIdMap_.end())) {
        RT_LOG(RT_LOG_ERROR, "CQ id is duplicate, stream_id=%d.", streamId);
        return RT_ERROR_STREAM_DUPLICATE;
    }

    XpuDriver *xpuDriver = static_cast<XpuDriver *>(Device_()->Driver_());
    rtError_t error =
        xpuDriver->XpuDriverDeviceSqCqAlloc(newStm->Device_()->Id_(), newStm->GetSqId(), newStm->GetCqId());
    COND_RETURN_ERROR_MSG_INNER(
        error != RT_ERROR_NONE, RT_ERROR_STREAM_NEW, "Alloc xpu sq cq failed, stream_id=%d.", streamId);
    streamIdToSqIdMap_[streamId] = newStm->GetSqId();
    streamIdToCqIdMap_[streamId] = newStm->GetCqId();
    return RT_ERROR_NONE;
}

rtError_t XpuStreamSqCqManage::SetXpuTprtSqCqStatus(const uint32_t devId, const uint32_t sqId) const
{
    rtError_t error = static_cast<XpuDriver *>(Device_()->Driver_())->XpuDriverSetSqCqStatus(devId, sqId);
    return error;
}

rtError_t XpuStreamSqCqManage::DeAllocXpuStreamSqCq(const uint32_t devId, const uint32_t streamId)
{
    const std::lock_guard<std::mutex> stmLock(streamMapLock_);
    const auto sqItor = streamIdToSqIdMap_.find(streamId);
    if (unlikely(sqItor == streamIdToSqIdMap_.end())) {
        RT_LOG(RT_LOG_INFO, "There is no sq, stream_id=%u.", streamId);
        return RT_ERROR_NONE;
    }

    const auto cqItor = streamIdToCqIdMap_.find(streamId);
    if (unlikely(cqItor == streamIdToCqIdMap_.end())) {
        RT_LOG(RT_LOG_INFO, "There is no cq, stream_id=%u.", streamId);
        return RT_ERROR_NONE;
    }
    const uint32_t sqId = sqItor->second;
    const uint32_t cqId = cqItor->second;

    streamIdToSqIdMap_.erase(streamId);
    streamIdToCqIdMap_.erase(streamId);

    rtError_t error = static_cast<XpuDriver *>(Device_()->Driver_())->XpuDriverSqCqDestroy(devId, sqId, cqId);
    RT_LOG(RT_LOG_INFO, "[SqCqManage]success to release sq, sq_id=%u, cq_id=%u, stream_id=%u", sqId, cqId, streamId);
    return error;
}

}  // namespace runtime
}  // namespace cce