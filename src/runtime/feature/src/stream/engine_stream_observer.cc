/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "engine_stream_observer.hpp"
#include "runtime.hpp"

namespace cce {
namespace runtime {
void EngineStreamObserver::TaskSubmited(Device * const dev, TaskInfo * const tsk)
{
    UNUSED(dev);
    Stream * const stm = tsk->stream;

    if (!stm->IsCtrlStream()) {
        stm->pendingNum_.Add(1U);
    }

    // no-sink stream push create stream task and l2 task to FIFO
    if (stm->NeedSubmitTask()) {
        stm->SetNeedSubmitTask(false);
    }
}

void EngineStreamObserver::TaskFinished(const uint32_t devId, const TaskInfo * const tsk)
{
    UNUSED(devId);
    Stream * const stm = tsk->stream;
    if (stm != nullptr) {
        if (!stm->IsCtrlStream()) {
            stm->pendingNum_.Sub(1U);
        }
    }
}

}  // namespace runtime
}  // namespace cce
