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
#include "stars_david.hpp"

namespace cce {
namespace runtime {

static bool RdmaTaskRegister()
{
    TaskFuncSingle rdmaSendFuncs = {
        .toCommandFunc = &ToCommandBodyForRdmaSendTask,
        .toSqeFunc = nullptr,
        .doCompleteSuccFunc = &DoCompleteSuccess,
        .taskUnInitFunc = nullptr,
        .waitAsyncCpCompleteFunc = nullptr,
        .printErrorInfoFunc = &PrintErrorInfoCommon,
        .setResultFunc = nullptr,
        .setStarsResultFunc = &SetStarsResultCommonForDavid,
    };
    TaskFuncSingle rdmaDbSendFuncs = {
        .toCommandFunc = &ToCommandBodyForRdmaDbSendTask,
        .toSqeFunc = nullptr,
        .doCompleteSuccFunc = &DoCompleteSuccess,
        .taskUnInitFunc = nullptr,
        .waitAsyncCpCompleteFunc = nullptr,
        .printErrorInfoFunc = &PrintErrorInfoCommon,
        .setResultFunc = nullptr,
        .setStarsResultFunc = &SetStarsResultCommonForDavid,
    };

    const auto &chips = GetDavidChips();
    for (auto chip : chips) {
        RegTaskFunc(chip, TS_TASK_TYPE_RDMA_SEND, rdmaSendFuncs);
        RegTaskFunc(chip, TS_TASK_TYPE_RDMA_DB_SEND, rdmaDbSendFuncs);
    }

    RegDavidSqeFunc(TS_TASK_TYPE_RDMA_SEND, &ConstructDavidSqeBase);
    RegDavidSqeFunc(TS_TASK_TYPE_RDMA_DB_SEND, &ConstructDavidSqeBase);
    return true;
}

static bool g_rdmaTaskRegister = RdmaTaskRegister();

}  // namespace runtime
}  // namespace cce
