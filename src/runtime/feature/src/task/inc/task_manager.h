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
TaskInfo* GetRealReportFaultTaskForNotifyWaitTask(TaskInfo *taskInfo, const void *info);
void SetLabelInfoForLabelSetTask(TaskInfo* taskInfo, const uint32_t pos);
void TaskFuncReg(void);
}  // namespace runtime
}  // namespace cce
#endif  // RUNTIME_TASK_MANAGER_H