/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "task_info_base.hpp"
#include "cq_adapter.hpp"

namespace cce {
namespace runtime {

void ConvertLogicCqeToRtCqe(const rtLogicCqReport_t* const logicCqe, rtCqReport_t* const rtCqe)
{
    rtCqe->streamId = logicCqe->streamId;
    rtCqe->taskId = logicCqe->taskId;
    rtCqe->errorCode = logicCqe->errorCode;
    rtCqe->errorType = logicCqe->errorType;
    rtCqe->sqeType = logicCqe->sqeType;
    rtCqe->sqId = logicCqe->sqId;
    rtCqe->sqHead = logicCqe->sqHead;
    rtCqe->nextTaskVld = logicCqe->nextTaskVld;
    rtCqe->notifyAttached = logicCqe->notifyAttached;
    rtCqe->reserved0 = 0U;
    rtCqe->reserved1 = 0U;
    rtCqe->reserved2 = 0UL;
    (void)memcpy_s(
        RtPtrToPtr<void*>(&rtCqe->u), sizeof(rtCqe->u), RtPtrToPtr<const void*>(&logicCqe->u1), sizeof(logicCqe->u1));

    return;
}

} // namespace runtime
} // namespace cce
