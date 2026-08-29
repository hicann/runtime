/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef DUMP_STATS_PROCESS_H
#define DUMP_STATS_PROCESS_H

#include <memory>
#include <string>
#include <vector>
#include "securec.h"

#include "datadump_kfc_interface.h"
#include "dump_stats_param.h"
#include "dump_stats_task.h"
#include "dump_stats_printf.h"

namespace kfc_dump_stats {
using AddOneStatDumpTask = void (*)(uint8_t* sqeIn, KfcDumpOpInitParam* dumpParam, KfcDumpContext* dumpContext);
using PrintSqeInfo = void (*)(uint8_t* sqeIn);

KfcDumpResult InitSqCqFunction();

class KfcDumpProcess {
public:
    explicit KfcDumpProcess() = default;

    ~KfcDumpProcess() = default;

    static KfcDumpResult InitKfcDumpInfo(KfcDumpOpInitParam* dumpParam);

    static bool GetStatsOpInitStatus();

    static void ResetForTest();

    static KfcDumpResult GetAivDumpContext();

    static KfcDumpResult KfcDumpRunStatServer(KfcDumpTask* dumpTask, KfcDumpInfo* dumpInfo);

    static KfcDumpResult PostDumpResults(OpStatsResult& opStatsResult, KfcDumpTask* dumpTask, uint32_t resultNum);

    static KfcDumpResult WaitTaskFinish();

    static KfcDumpResult FillAivArgs(KfcDumpContext* kfcAivArgs);

    static KfcDumpResult UpdateDumpResult(
        const InputOutputKfcDumpInfo& dumpTensor, TensorStatsResult& statsResult, KfcDumpStatsMsg* gMsg,
        TensorType tensorType);

    static KfcDumpResult KfcDumpStatClientProcess(
        KfcDumpTask* dumpTask, const std::vector<InputOutputKfcDumpInfo>& dumpTensorList, KfcDumpStatsServer& dump,
        OpStatsResult& dumpResult, TensorType tensorType);

private:
    // KFC 算子已拉起后的统计收发阶段。本阶段失败不得直接返回调用者，
    // 必须由 KfcDumpRunStatServer 补发 FINISHED 让 AIV 退出，否则该实例永久占核。
    static KfcDumpResult RunStatsExchange(
        KfcDumpTask* dumpTask, KfcDumpInfo* dumpInfo, KfcDumpStatsServer& dump, OpStatsResult& dumpResult,
        uint32_t tensorNum);

    // 通知 AIV 结束退出并等待其真正退出。统计阶段无论成败都必须执行。
    static KfcDumpResult FinishStatsTask(KfcDumpStatsServer& dump);
};
} // namespace kfc_dump_stats
#endif // DUMP_STATS_PROCESS_H
