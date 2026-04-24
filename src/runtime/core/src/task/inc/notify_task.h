/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef RUNTIME_NOTIFY_TASK_H
#define RUNTIME_NOTIFY_TASK_H

#include "driver.hpp"
#include "stars.hpp"

namespace cce {
namespace runtime {
rtError_t NotifyRecordTaskInit(TaskInfo *taskInfo, const uint32_t notifyIndex, const int32_t deviceIndex,
                               const uint32_t phyIndex,
                               const SingleBitNotifyRecordInfo * const singleInfo,
                               const rtCntNtyRecordInfo_t * const countInfo,
                               void* const notify, bool isCountNotify = false);
rtError_t NotifyResetTaskInit(TaskInfo *taskInfo, const uint32_t notifyIndex,
    const SingleBitNotifyRecordInfo * const singleInfo, void * const notify);
void ToCommandBodyForNotifyRecordTask(TaskInfo *taskInfo, rtCommand_t *const command);
void DoCompleteSuccessForNotifyRecordTask(TaskInfo *taskInfo, const uint32_t devId);
rtError_t GetIpcSqeWriteAddrForNotifyRecordTask(TaskInfo *taskInfo, uint64_t &addr);

rtError_t NotifyWaitTaskInit(TaskInfo *taskInfo, const uint32_t notifyIndex, const uint32_t timeOutNum,
    const CountNotifyWaitInfo * const cntNtfyInfo, void * const inNotify, const bool isCountNotify = false);
void ToCommandBodyForNotifyWaitTask(TaskInfo *taskInfo, rtCommand_t *const command);
void DoCompleteSuccessForNotifyWaitTask(TaskInfo *taskInfo, const uint32_t devId);
void PrintErrorInfoForNotifyWaitTask(TaskInfo *const taskInfo, const uint32_t devId);
TaskInfo* GetRealReportFaultTaskForNotifyWaitTask(TaskInfo *taskInfo, const void *info);
}  // namespace runtime
}  // namespace cce
#endif  // RUNTIME_NOTIFY_TASK_H
