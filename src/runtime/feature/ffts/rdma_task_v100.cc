/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "rdma_task.h"
#include "task_manager.h"

namespace cce {
namespace runtime {

static bool RdmaPiValueModifyTaskRegister()
{
    TaskFuncSingle funcs = {
        .toCommandFunc = nullptr,
        .toSqeFunc = &ConstructSqeRdmaPiValueModifyTask,
        .doCompleteSuccFunc = &DoCompleteSuccess,
        .taskUnInitFunc = &RdmaPiValueModifyTaskUnInit,
        .waitAsyncCpCompleteFunc = nullptr,
        .printErrorInfoFunc = &PrintErrorInfoForRDMAPiValueModifyTask,
        .setResultFunc = &SetResultCommon,
        .setStarsResultFunc = &SetStarsResultCommon,
    };

    const auto &chips = GetV100Chips();
    for (auto chip : chips) {
        RegTaskFunc(chip, TS_TASK_TYPE_RDMA_PI_VALUE_MODIFY, funcs);
    }

    return true;
}

static bool g_rdmaPiValueModifyTaskRegister = RdmaPiValueModifyTaskRegister();

}  // namespace runtime
}  // namespace cce
