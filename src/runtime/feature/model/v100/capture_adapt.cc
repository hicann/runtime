/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "capture_adapt.hpp"
#include "task_info.hpp"
#include "capture_model.hpp"
#include "thread_local_container.hpp"
namespace cce {
namespace runtime {

TaskInfo* GetStreamTaskInfo(const Device * const dev, uint16_t streamId, uint16_t pos)
{
    if (dev != nullptr) {
        return dev->GetTaskFactory()->GetTask(static_cast<int32_t>(streamId), pos);
    }
    return nullptr;
}
} // namespace runtime
} // namespace cce
