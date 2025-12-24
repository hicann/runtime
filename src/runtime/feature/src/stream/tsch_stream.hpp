/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef CCE_RUNTIME_TSCH_STREAM_HPP
#define CCE_RUNTIME_TSCH_STREAM_HPP

#include "stream.hpp"
 
namespace cce {
namespace runtime {
class TschStream : public Stream {
public:
    TschStream(Device * const dev, const uint32_t prio, const RtSqAllocType type);
    ~TschStream() = default;

    rtError_t Setup() override;
    rtError_t TearDown(const bool terminal = false, bool flag = true) override
    {
        UNUSED(terminal);
        UNUSED(flag);
        return RT_ERROR_NONE;
    }

    RtSqAllocType GetTsSqAllocType() const override
    {
        return type_;
    }
    rtError_t AllocDsaSqAddr() const override;
private:
    RtSqAllocType type_;
};
}  // namespace runtime
}  // namespace cce
 
#endif  // CCE_RUNTIME_TSCH_STREAM_HPP