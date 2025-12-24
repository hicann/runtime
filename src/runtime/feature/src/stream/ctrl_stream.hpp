/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef CCE_RUNTIME_CTRL_STREAM_HPP
#define CCE_RUNTIME_CTRL_STREAM_HPP

#include "stream.hpp"
 
namespace cce {
namespace runtime {
class CtrlStream : public Stream {
public:
    explicit CtrlStream(Device * const dev) : Stream(dev, 0, 0U)
    {
        isCtrlStream_ = true;
    }
    ~CtrlStream() noexcept override;

    // init stream
    rtError_t Setup() override;
    rtError_t GetTaskIdByPos(const uint16_t recycleHead, uint32_t &taskId) override;
    rtError_t GetHeadPosFromCtrlSq(uint32_t &sqHead);
    rtError_t Synchronize();
    rtError_t AddTaskToStream(const uint32_t pos, const TaskInfo * const tsk);
    void DelPosToCtrlTaskIdMap(uint16_t pos);
    // total sqsize if 1024, last two sq is used as head(index:1022) and tail(index:1023), only 1022 is available
    const uint32_t sqDepth = 1022;
private:
    std::mutex posToCtrlTaskIdMapLock_;
    std::unordered_map<uint16_t, uint16_t> posToCtrlTaskIdMap_;
};
}  // namespace runtime
}  // namespace cce
 
#endif  // CCE_RUNTIME_CTRL_STREAM_HPP