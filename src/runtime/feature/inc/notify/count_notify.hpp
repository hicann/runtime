/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef __CCE_RUNTIME_COUNT_NOTIFY_HPP__
#define __CCE_RUNTIME_COUNT_NOTIFY_HPP__

#include <string>
#include "context.hpp"
#include "device.hpp"

namespace cce {
namespace runtime {
class CountNotify : public NoCopy {
public:
    CountNotify(const uint32_t devId, const uint32_t taskSchId);
    ~CountNotify() noexcept override;
    rtError_t GetCntNotifyAddress(uint64_t &addr, rtNotifyType_t regType);
    rtError_t Record(Stream * const streamIn, const rtCntNtyRecordInfo_t * const info);
    rtError_t Setup();
    rtError_t Wait(Stream * const streamIn, const rtCntNtyWaitInfo_t * const info);

    uint32_t GetCntNotifyId() const
    {
        return notifyid_;
    }

    void SetNotifyFlag(uint32_t flag)
    {
        notifyFlag_ = flag;
    }

    uint32_t GetTsId() const
    {
        return tsId_;
    }

private:
    uint32_t notifyid_{MAX_UINT32_NUM};
    uint32_t phyId_{0U};
    Driver *driver_{nullptr};
    uint32_t tsId_;
    uint32_t deviceId_;
    uint32_t notifyFlag_{0U};
};
}
}

#endif  // __CCE_RUNTIME_COUNT_NOTIFY_HPP__