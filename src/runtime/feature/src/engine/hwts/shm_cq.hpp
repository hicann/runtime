/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef __CCE_RUNTIME_SHM_CQ_HPP__
#define __CCE_RUNTIME_SHM_CQ_HPP__
#include "driver.hpp"
#include "device.hpp"

namespace cce {
namespace runtime {
// Runtime engine for task processing, including sending command
// and receiving report.
class ShmCq {
public:
    explicit ShmCq();
    ~ShmCq() noexcept;

    rtError_t Init(Device *dev);
    rtError_t InitCqShm(const uint32_t streamId);
    rtError_t QueryLatestTaskId(const uint32_t streamId, uint32_t &taskId) const;
    rtError_t QueryCqShm(const uint32_t streamId, rtShmQuery_t &shareMemInfo);
    uint32_t GetTaskIdFromStreamShmTaskId(const uint32_t streamId) const;

    uint32_t GetShareSqId() const
    {
        return vSqId_;
    }

private:
    Device *dev_{nullptr};
    Driver *driver_{nullptr};
    bool vSqReadonly_{false};

    uint32_t vSqId_{MAX_UINT32_NUM};
    uint32_t vCqId_{MAX_UINT32_NUM};
    uint8_t *vSqBase_{nullptr};
    uint32_t deviceId_{MAX_UINT32_NUM};
    uint32_t tsId_{MAX_UINT32_NUM};
    uint32_t *streamShmTaskId_{nullptr};
};
}  // namespace runtime
}  // namespace cce
#endif  // __CCE_RUNTIME_SHM_CQ_HPP__