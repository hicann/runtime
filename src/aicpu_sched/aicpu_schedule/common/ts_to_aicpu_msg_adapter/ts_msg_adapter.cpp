/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "ts_msg_adapter.h"

namespace AicpuSchedule {
TsMsgAdapter::TsMsgAdapter(
    const uint32_t pid, const uint8_t cmdType, const uint8_t vfId, const uint8_t tid, const uint8_t tsId)
    : pid_(pid), cmdType_(cmdType), vfId_(vfId), tid_(tid), tsId_(tsId)
{}

TsMsgAdapter::TsMsgAdapter() : pid_(0U), cmdType_(0U), vfId_(0U), tid_(0U), tsId_(0U)
{}

int32_t TsMsgAdapter::ResponseToTs(
    TsAicpuSqe& aicpuSqe, unsigned int handleId, unsigned int devId, unsigned int tsId) const
{
    aicpusd_info("Response start: payload=sqe.");
    const auto ret = tsDevSendMsgAsync(
        devId, static_cast<uint32_t>(tsId), PtrToPtr<TsAicpuSqe, char_t>(&aicpuSqe),
        static_cast<uint32_t>(sizeof(TsAicpuSqe)), handleId);
    AICPUSD_CHECK(
        (ret == DRV_ERROR_NONE), AICPU_SCHEDULE_ERROR_INNER_ERROR,
        "Response send failed: api=tsDevSendMsgAsync ret=%d",
        ret);
    aicpusd_info("Response finish: payload=sqe.");
    return AICPU_SCHEDULE_OK;
}

int32_t TsMsgAdapter::ResponseToTs(
    TsAicpuMsgInfo& aicpuMsgInfo, unsigned int handleId, unsigned int devId, unsigned int tsId) const
{
    aicpusd_info("Response start: payload=msg_info.");
    const auto ret = tsDevSendMsgAsync(
        devId, static_cast<uint32_t>(tsId), PtrToPtr<TsAicpuMsgInfo, char_t>(&aicpuMsgInfo),
        static_cast<uint32_t>(sizeof(TsAicpuMsgInfo)), handleId);
    AICPUSD_CHECK(
        (ret == DRV_ERROR_NONE), AICPU_SCHEDULE_ERROR_INNER_ERROR,
        "Response send failed: api=tsDevSendMsgAsync ret=%d",
        ret);
    aicpusd_info("Response finish: payload=msg_info.");
    return AICPU_SCHEDULE_OK;
}

int32_t TsMsgAdapter::ResponseToTs(
    hwts_response_t& hwtsResp, uint32_t devId, EVENT_ID eventId, uint32_t subeventId) const
{
    aicpusd_info("Response start: payload=hwts_response.");
    const drvError_t ret = halEschedAckEvent(
        devId, eventId, subeventId, PtrToPtr<hwts_response_t, char_t>(&hwtsResp),
        static_cast<uint32_t>(sizeof(hwts_response_t)));
    AICPUSD_CHECK(
        (ret == DRV_ERROR_NONE), AICPU_SCHEDULE_ERROR_INNER_ERROR,
        "Response send failed: api=halEschedAckEvent ret=%d",
        ret);
    aicpusd_info("Response finish: payload=hwts_response.");
    return AICPU_SCHEDULE_OK;
}
} // namespace AicpuSchedule