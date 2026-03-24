/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef CCE_RUNTIME_AICPU_SCHEDULER_AGENT_HPP
#define CCE_RUNTIME_AICPU_SCHEDULER_AGENT_HPP

#include "base.hpp"

namespace cce {
namespace runtime {
using FUNC_AICPU_MODEL_LOAD = int32_t (*)(void *);
using FUNC_AICPU_MODEL_OPERATE = int32_t (*)(uint32_t);
using FUNC_AICPU_LOAD_OP_MAPPING_INFO = int32_t(*)(const void *, uint32_t);

class AicpuSchedulerAgent {
public:
    AicpuSchedulerAgent() = default;

    ~AicpuSchedulerAgent();

    rtError_t Init();

    void Destroy() noexcept;

    rtError_t AicpuModelLoad(void * const funcArg) const;

    rtError_t AicpuModelDestroy(const uint32_t modelId) const;

    rtError_t AicpuModelExecute(const uint32_t modelId) const;

    rtError_t DatadumpInfoLoad(const void * const dumpInfo, const uint32_t length) const;

    // not support copy and move
    AicpuSchedulerAgent(const AicpuSchedulerAgent &other) = delete;

    AicpuSchedulerAgent &operator=(const AicpuSchedulerAgent &other) = delete;

    AicpuSchedulerAgent(AicpuSchedulerAgent &&other) = delete;

    AicpuSchedulerAgent &operator=(AicpuSchedulerAgent &&other) = delete;

private:
    void *aicpuSchedulerHandle_ = nullptr;
    FUNC_AICPU_MODEL_LOAD loadModelFunc_ = nullptr;
    FUNC_AICPU_MODEL_OPERATE modelExecuteFunc_ = nullptr;
    FUNC_AICPU_MODEL_OPERATE modelDestroyFunc_ = nullptr;
    FUNC_AICPU_LOAD_OP_MAPPING_INFO loadOpMappingInfoFunc_ = nullptr;
};

}
}

#endif // CCE_RUNTIME_AICPU_SCHEDULER_AGENT_HPP
