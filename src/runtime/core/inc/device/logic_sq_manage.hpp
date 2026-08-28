/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef __CCE_RUNTIME_LOGIC_SQ_MANAGE_HPP__
#define __CCE_RUNTIME_LOGIC_SQ_MANAGE_HPP__

#include <cstdint>
#include <map>
#include <mutex>
#include <vector>
#include "base.hpp"

namespace cce {
namespace runtime {

class LogicSq;
class Device;

class LogicSqManage {
public:
    explicit LogicSqManage(Device* const device) : device_(device) {}
    ~LogicSqManage();
    rtError_t CreateLogicSq(LogicSq*& logicSq);
    void FreeLogicSq(const uint32_t logicSqId);
    rtError_t BindRtsqToLogicSq(const uint32_t rtsqId, const uint32_t logicSqId);
    void UnbindRtsqFromLogicSq(const uint32_t rtsqId);
    rtError_t GetLogicSqIdByRtsqId(const uint32_t rtsqId, uint32_t& logicSqId) const;
    rtError_t GetLogicSqById(const uint32_t logicSqId, LogicSq*& logicSq) const;

private:
    Device* device_{nullptr};
    mutable std::mutex lock_;
    std::map<uint32_t, uint32_t> rtsqIdToLogicSqIdMap_;
    std::map<uint32_t, LogicSq*> logicSqIdToLogicSqMap_;
};

} // namespace runtime
} // namespace cce

#endif // __CCE_RUNTIME_LOGIC_SQ_MANAGE_HPP__
