/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef REPORT_API_H
#define REPORT_API_H

#include <cstdint>
#include "prof_api.h"
#include "mstx_def.h"

#ifdef __cplusplus
extern "C" {
#endif // __cplusplus
enum ProfRegisterType {
    REPORT_API_POP,
    REPORT_COMPACCT_POP,
    REPORT_ADDITIONAL_POP,
    REPORT_BUF_EMPTY,
    REPORT_ADDITIONAL_PUSH,
    PROF_MARK_EX,
    REPORT_ADPROF_POP,
    REPORT_ADPROF_INDEX_SHIFT,
    REPORT_VARIABLE_ADDITIONAL_POP,
    REPORT_VARIABLE_ADDITIONAL_INDEX_SHIFT
};

struct ProfImplInfo {
    size_t sysFreeRam;
    uint32_t profType;
    bool profInitFlag;
};

typedef bool (*ProfApiBufPopCallback)(uint32_t &aging, MsprofApi& data);
typedef bool (*ProfCompactBufPopCallback)(uint32_t &aging, MsprofCompactInfo& data);
typedef bool (*ProfAdditionalBufPopCallback)(uint32_t &aging, MsprofAdditionalInfo& data);
typedef bool (*ProfReportBufEmptyCallback)();
typedef void (*ProfUnInitReportBufCallback)();
typedef int32_t (*ProfAdditionalBufPushCallback)(uint32_t aging, const VOID_PTR data, uint32_t len);
typedef int32_t (*ProfMarkExCallback)(uint64_t indexId, uint64_t modelId, uint16_t tagId, VOID_PTR stm);
typedef void* (*ProfBatchAddBufPopCallback)(size_t &popSize, bool popForce);
typedef void (*ProfBatchAddBufIndexShiftCallBack)(void *popPtr, const size_t popSize);
typedef void (*ProfRegisterMstxFuncCallback)(MstxInitInjectionFunc mstxInitFunc, ProfModule module);

typedef void* (*ProfVarAddBlockBufPopCallback)(size_t &popSize);
typedef void (*ProfVarAddBufIndexShiftCallBack)(void *popPtr, const size_t popSize);

#ifdef __cplusplus
}
#endif

#endif
