/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "dvpp_grp.hpp"
#include "context.hpp"
#include "device.hpp"

namespace cce {
namespace runtime {

DvppGrp::DvppGrp(Device *const dev, const uint32_t flag)
    : device_(dev), flag_(flag), logicCq_(UINT32_MAX), context_(nullptr)
{
}

DvppGrp::~DvppGrp() noexcept
{
    if (logicCq_ != UINT32_MAX) {
        (void)device_->Driver_()->LogicCqFree(device_->Id_(), device_->DevGetTsId(), logicCq_);
        RT_LOG(RT_LOG_INFO, "dvpp grp logicCq=%u free success", logicCq_);
        logicCq_ = UINT32_MAX;
    }

    device_ = nullptr;
    context_ = nullptr;
}

rtError_t DvppGrp::Setup()
{
    uint32_t logicCqId;
    rtError_t error = device_->Driver_()->LogicCqAllocateV2(device_->Id_(), device_->DevGetTsId(),
        RT_MAX_STREAM_ID, logicCqId, true);

    ERROR_RETURN_MSG_INNER(error, "Failed to alloc logic cq");
    logicCq_ = logicCqId;
    RT_LOG(RT_LOG_INFO, "dvpp grp logicCq=%u alloc success", logicCq_);
    return RT_ERROR_NONE;
}

}  // namespace runtime
}  // namespace cce
