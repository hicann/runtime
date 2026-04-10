/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "stars_david.hpp"
#include "stream.hpp"

namespace cce {
namespace runtime {

void ConstructDavidSqeForCmoTask(TaskInfo * const taskInfo, rtDavidSqe_t *const davidSqe, uint64_t sqBaseAddr)
{
    UNUSED(sqBaseAddr);
    Stream * const stm = taskInfo->stream;
    Model *cmoModel = stm->Model_();
    CmoTaskInfo * const cmoTsk = &(taskInfo->u.cmoTask);
    if (cmoModel == nullptr) {
        if ((cmoTsk->cmoSqeInfo.opCode == RT_CMO_PREFETCH) || (cmoTsk->cmoSqeInfo.opCode == RT_CMO_WRITEBACK)) {
            ConstructDavidCmoSqe(taskInfo, davidSqe, sqBaseAddr);
        } else {
            ConstructDavidCmoSdmaSqe(taskInfo, davidSqe, sqBaseAddr);
        }
    } else {
        // CmoTask for model stream.
        ConstructDavidCmoAddrSqe(taskInfo, davidSqe, sqBaseAddr);
    }
}

}  // namespace runtime
}  // namespace cce
