/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef RUNTIME_TASK_MANAGER_H
#define RUNTIME_TASK_MANAGER_H

#include "stream.hpp"
#include "driver.hpp"
#include "stars.hpp"

namespace cce {
namespace runtime {

// record task error info for other thread sync
#define STREAM_REPORT_ERR_MSG(STREAM, ERR_MODULE, format, ...) \
    do { \
        char_t errRecordMsg[MSG_LENGTH] = {};                                          \
        char_t * const errStrDes = errRecordMsg;                        \
        (void)snprintf_truncated_s(errStrDes, static_cast<size_t>(MSG_LENGTH), (format), ##__VA_ARGS__); \
        (STREAM)->ReportErrorMessage((ERR_MODULE), std::string(errStrDes)); \
        RT_LOG(RT_LOG_ERROR, "%s", errStrDes); \
    } while (false)

Stream* GetReportStream(Stream *stream);
void PrintErrorSqe(const rtStarsSqe_t * const sqe, const char_t *desc);
uint64_t CombineTo64Bit(uint32_t high, uint32_t low);
void SetStarsResultCommon(TaskInfo *taskInfo, const rtLogicCqReport_t &logicCq);
void TaskFuncReg(void);
void RegTaskToCommandFunc(const std::vector<rtChipType_t> &chipTypes);

using PfnTaskToCmd = void (*)(TaskInfo *const taskInfo, rtCommand_t *const command);
using PfnTaskToSqe = void (*)(TaskInfo* taskInfo, rtStarsSqe_t *const command);
using PfnWaitAsyncCpCompleteFunc = rtError_t (*)(TaskInfo* taskInfo);
using PfnTaskSetResult = void (*)(TaskInfo *taskInfo, const void *const data, const uint32_t dataSize);
using PfnDoCompleteSucc = void (*)(TaskInfo *taskInfo, const uint32_t devId);
using PfnTaskUnInit = void (*)(TaskInfo *taskInfo);
using PfnPrintErrorInfo = void (*)(TaskInfo *taskInfo, const uint32_t devId);
using PfnTaskSetStarsResult = void (*)(TaskInfo *taskInfo, const rtLogicCqReport_t &logicCq);

enum class TaskFuncOpType : uint8_t {
    TO_COMMAND = 0,
    TO_SQE = 1,
    DO_COMPLETE_SUCC = 2,
    TASK_UNINIT = 3,
    WAIT_ASYNC_COMPLETE = 4,
    PRINT_ERROR_INFO = 5,
    SET_RESULT = 6,
    SET_STARS_RESULT = 7,
    MAX_OP_TYPE
};

struct TaskFuncArrays {
    PfnTaskToCmd toCommandFunc[TS_TASK_TYPE_RESERVED];
    PfnTaskToSqe toSqeFunc[TS_TASK_TYPE_RESERVED];
    PfnDoCompleteSucc doCompleteSuccFunc[TS_TASK_TYPE_RESERVED];
    PfnTaskUnInit taskUnInitFunc[TS_TASK_TYPE_RESERVED];
    PfnWaitAsyncCpCompleteFunc waitAsyncCpCompleteFunc[TS_TASK_TYPE_RESERVED];
    PfnPrintErrorInfo printErrorInfoFunc[TS_TASK_TYPE_RESERVED];
    PfnTaskSetResult setResultFunc[TS_TASK_TYPE_RESERVED];
    PfnTaskSetStarsResult setStarsResultFunc[TS_TASK_TYPE_RESERVED];
};

extern TaskFuncArrays g_taskFuncArrays[CHIP_END];
extern PfnTaskUnInit *g_taskUnInitFunc;

void RefreshTaskFuncPointer(rtChipType_t chipType);
rtError_t RegTaskFunc(rtChipType_t chipType, tsTaskType_t taskType, TaskFuncOpType opType, void* func);

}  // namespace runtime
}  // namespace cce
#endif  // RUNTIME_TASK_MANAGER_H