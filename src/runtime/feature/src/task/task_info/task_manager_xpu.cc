/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "task_manager_xpu.hpp"
#include "xpu_kernel_task.h"
#include "task_res_da.hpp"
#include "stream_xpu.hpp"
#include "stream.hpp"
#include "task_info.h"

namespace cce {
namespace runtime {

PfnTaskToTprtSqe g_toXpuSqeFunc[TS_TASK_TYPE_RESERVED] = {};
PfnTaskUnInit g_taskXpuUnInitFunc[TS_TASK_TYPE_RESERVED] = {};
PfnDoCompleteSucc g_doXpuCompleteSuccFunc[TS_TASK_TYPE_RESERVED] = {};
PfnTaskSetTprtResult g_setXpuResultFunc[TS_TASK_TYPE_RESERVED] = {};
PfnPrintErrorInfo g_printXpuErrorInfoFunc[TS_TASK_TYPE_RESERVED] = {};
static const char_t *g_xpuSqeTypeStr[] = {
    "aicpu",
    "invalid",
};

static void RegTaskToXpuSqefunc(void)
{
    for (uint32_t i = 0U; i < TS_TASK_TYPE_RESERVED; i++) {
        g_toXpuSqeFunc[i] = nullptr;
    }
    g_toXpuSqeFunc[TS_TASK_TYPE_KERNEL_AICPU] = &ConstructTprtAICpuSqeForDavinciTask;
}

void ToConstructXpuSqe(TaskInfo *taskInfo, TprtSqe_t *const tprtSqe)
{
    if (g_toXpuSqeFunc[taskInfo->type] != nullptr) {
        g_toXpuSqeFunc[taskInfo->type](taskInfo, tprtSqe);
    }
}

static void XpuRegTaskUnInitFunc(void)
{
    for (uint32_t i = 0U; i < TS_TASK_TYPE_RESERVED; i++) {
        g_taskXpuUnInitFunc[i] = nullptr;
    }
    g_taskXpuUnInitFunc[TS_TASK_TYPE_KERNEL_AICPU] = &TprtDavinciTaskUnInit;
}

static void XpuRegDoCompleteSuccFunc(void)
{
    for (auto &item : g_doXpuCompleteSuccFunc) {
        item = nullptr;
    }
    g_doXpuCompleteSuccFunc[TS_TASK_TYPE_KERNEL_AICPU] = &DoCompleteSuccessForXpuDavinciTask;
}

static void XpuRegSetResultFunc(void)
{
    for (auto &item : g_setXpuResultFunc) {
        item = nullptr;
    }
    g_setXpuResultFunc[TS_TASK_TYPE_KERNEL_AICPU] = &SetTprtResultForDavinciTask;
}

void XpuComplete(TaskInfo *const taskInfo, const uint32_t devId)
{
    if (g_doXpuCompleteSuccFunc[taskInfo->type] != nullptr) {
        g_doXpuCompleteSuccFunc[taskInfo->type](taskInfo, devId);
    } else {
        // no operation
    }
}

void XpuSetStarsResult(TaskInfo *taskInfo, const TprtLogicCqReport_t &logicCq)
{
    if (taskInfo->type >= TS_TASK_TYPE_RESERVED) {
        return;
    }

    if (g_setXpuResultFunc[taskInfo->type] != nullptr) {
        g_setXpuResultFunc[taskInfo->type](taskInfo, logicCq);
    }
}

void XpuPrintErrorInfo(TaskInfo *taskInfo, const uint32_t devId)
{
    if (taskInfo->type >= TS_TASK_TYPE_RESERVED) {
        return;
    }

    if (g_printXpuErrorInfoFunc[taskInfo->type] != nullptr) {
        g_printXpuErrorInfoFunc[taskInfo->type](taskInfo, devId);
    }
}

static void XpuRegPrintErrorInfoFunc(void)
{
    for (auto &item : g_printXpuErrorInfoFunc) {
        item = &PrintErrorInfoCommon;
    }
    g_printXpuErrorInfoFunc[TS_TASK_TYPE_KERNEL_AICPU] = &XpuPrintAICpuErrorInfoForDavinciTask;
}

const char_t* GetXpuSqeDescByType(const uint8_t sqeType)
{
    const uint8_t arraySize = static_cast<uint8_t>(sizeof(g_xpuSqeTypeStr) / sizeof(g_xpuSqeTypeStr[0]));

    if (sqeType >= arraySize) {
        return "unknown";
    }
    return g_xpuSqeTypeStr[sqeType];
}

void XpuTaskUnInitProc(TaskInfo *taskInfo)
{
    if (taskInfo->type >= TS_TASK_TYPE_RESERVED) {
        return;
    }

    if (g_taskUnInitFunc[taskInfo->type] != nullptr) {
        g_taskXpuUnInitFunc[taskInfo->type](taskInfo);
    }
}

void RegXpuTaskFunc(void)
{
    RegTaskToXpuSqefunc();
    XpuRegTaskUnInitFunc();
    XpuRegDoCompleteSuccFunc();
    XpuRegSetResultFunc();
    XpuRegPrintErrorInfoFunc();
}
}  // namespace runtime
}  // namespace cce
