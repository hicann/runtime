/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef CCE_RUNTIME_ATRACE_LOG_HPP
#define CCE_RUNTIME_ATRACE_LOG_HPP

#include "base.hpp"
#include "atrace_api.h"

namespace cce {
namespace runtime {

namespace {
    constexpr uint32_t PER_ATRACE_LOG_LEN = 112U;
}

typedef enum TagTaskRecycleFuncType {
    TYPE_SENDINGWAIT    = 0,
    TYPE_TRYRECYCLETASK,
    TYPE_FUNC_RESERVED
} TaskRecycleFuncType;

typedef struct TagCqReportParams {
    uint32_t cqId;
    uint32_t errCode;
    uint8_t  cqType;
} CqReportParams;

typedef struct tagTaskRecycleParams {
    uint32_t lastTaskId;
    uint32_t exeTaskId;
    TaskRecycleFuncType funcType;
} TaskRecycleParams;

typedef struct tagEventWaitParams {
    int32_t eventId;
    bool isCountNotify;
    // Because of security concerns, only the low-order 8 bits of the address are printed
    uintptr_t eventAddrLowEightBit;
} EventWaitParams;

struct EventRecordParams {
    int32_t  eventId;
    uint32_t waitCqFlag;
    uint16_t waitCqId;
    bool isCountNotify;
    // Because of security concerns, only the low-order 8 bits of the address are printed
    uintptr_t eventAddrLowEightBit;
};

typedef struct TagEventResetParams {
    int32_t eventId;
    uint16_t isNotify;
    // Because of security concerns, only the low-order 8 bits of the address are printed
    uintptr_t eventAddrLowEightBit;
} EventResetParams;

typedef struct tagNotifyWaitParams {
    uint32_t notifyId;
    uint32_t timeout;
    bool isCountNotify;
    // Because of security concerns, only the low-order 8 bits of the address are printed
    uintptr_t notifyWaitAddrLowEightBit;
} NotifyWaitParams;

typedef struct tagNotifyRecordParams {
    uint32_t notifyId;
    uint32_t remoteDevice;
    uint16_t isIpc;
    bool isCountNotify;
    // Because of security concerns, only the low-order 8 bits of the address are printed
    uintptr_t notifyWaitAddrLowEightBit;
} NotifyRecordParams;

struct AtraceParams {
    uint32_t deviceId;
    uint32_t streamId;
    uint16_t taskId;
    uint32_t tid;
    TraHandle handle;
    union {
        CqReportParams cqReportParams;
        TaskRecycleParams taskRecycleParams;
        EventWaitParams eventWaitParams;
        EventRecordParams eventRecordParams;
        EventResetParams eventResetParams;
        NotifyWaitParams notifyWaitParams;
        NotifyRecordParams notifyRecordParams;
    } u;
};

typedef enum tagAtraceSubmitType {
    TYPE_CQ_REPORT         = 0,
    TYPE_TASK_RECYCLE      = 1,
    TYPE_EVENT_WAIT        = 2,
    TYPE_EVENT_RECORD      = 3,
    TYPE_EVENT_RESET       = 4,
    TYPE_NOTIFY_WAIT       = 5,
    TYPE_NOTIFY_RECORD     = 6,
    TYPE_RESERVED          = 7
} AtraceSubmitType;

void AtraceSubmitLog(AtraceSubmitType type, const AtraceParams &atraceParams);
void TrySaveAtraceLogs(TraEventHandle handle);
void RegAtraceInfoInit(void);
rtError_t AtraceSubmitForEventWait(const AtraceParams &atraceParams);
rtError_t AtraceSubmitForNotifyWait(const AtraceParams &atraceParams);
rtError_t AtraceSubmitForEventRecord(const AtraceParams &atraceParams);
rtError_t AtraceSubmitForLogicCqRecord(const AtraceParams &atraceParams);
}
}

#endif // CCE_RUNTIME_ATRACE_LOG_HPP