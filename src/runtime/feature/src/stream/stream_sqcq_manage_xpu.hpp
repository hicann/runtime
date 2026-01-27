/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef CCE_RUNTIME_STREAM_SQCQ_MANAGE_XPU_HPP
#define CCE_RUNTIME_STREAM_SQCQ_MANAGE_XPU_HPP

#include "stream_sqcq_manage.hpp"

namespace cce {
namespace runtime {

class XpuStreamSqCqManage : public StreamSqCqManage {
public:
    explicit XpuStreamSqCqManage(Device * const dev);
    ~XpuStreamSqCqManage() override = default;
    rtError_t AllocXpuStreamSqCq(const Stream* const newStm);
    rtError_t SetXpuTprtSqCqStatus(const uint32_t devId, const uint32_t sqId) const;
    rtError_t DeAllocXpuStreamSqCq(const uint32_t devId, const uint32_t streamId);
};

}  // namespace runtime
}  // namespace cce

#endif  // CCE_RUNTIME_STREAM_SQCQ_MANAGE_HPP