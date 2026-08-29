/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef DUMP_STATS_PRINTF_H
#define DUMP_STATS_PRINTF_H

#include <cstdint>
#include "dump_stats_param.h"
#include "dump_stats_server.h"
#include "dump_stats_task.h"

namespace kfc_dump_stats {
class KfcDumpPrintf {
public:
    static void PrintKfcDumpInitParam(KfcDumpOpInitParam* kfcInitParam);

    static void PrintKfcDumpStreamCtx(KfcDumpStreamCtx* streamCtx);

    static void PrintSqeV2(uint8_t* sqeIn);

    static void PrintMsg(KfcDumpStatsMsg& msg);

    static void PrintDumpContext(KfcDumpContext* dumpContext);

    static void PrintSqeV1(uint8_t* sqeIn);

    static void PrintSqeCloudV4(uint8_t* sqeIn);

    static void PrintSqeCloudV5(uint8_t* sqeIn);
};
} // namespace kfc_dump_stats

#endif // DUMP_STATS_PRINTF_H
