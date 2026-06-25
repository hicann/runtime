/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "aclgraph_cond_task.h"
#include "stars_david.hpp"
#include "task_manager.h"

namespace cce {
namespace runtime {

static bool AclgraphCondTaskRegister()
{
    TaskFuncSingle funcs = {
        .toCommandFunc = nullptr,
        .toSqeFunc = nullptr,
        .doCompleteSuccFunc = &DoCompleteSuccess,
        .taskUnInitFunc = &CaptureConditionTaskUnInit,
        .waitAsyncCpCompleteFunc = nullptr,
        .printErrorInfoFunc = &PrintErrorInfoCommon,
        .setResultFunc = nullptr,
        .setStarsResultFunc = &SetStarsResultCommonForDavid,
    };

    const auto& chips = GetDavidChips();
    for (const auto chip : chips) {
        RegTaskFunc(chip, TS_TASK_TYPE_CAPTURE_CONDITION, funcs);
    }

    RegDavidSqeFunc(TS_TASK_TYPE_CAPTURE_CONDITION, &ConstructDavidSqeForCaptureConditionTask);
    return true;
}

static bool g_aclgraphCondTaskRegister = AclgraphCondTaskRegister();

}  // namespace runtime
}  // namespace cce
