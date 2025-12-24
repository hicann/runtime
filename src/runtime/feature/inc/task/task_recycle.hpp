/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef RUNTIME_TASK_RECYCLE_H
#define RUNTIME_TASK_RECYCLE_H
#include "task_info.hpp"
#include "dvpp_grp.hpp"
#include "rt_stars.h"
namespace cce {
namespace runtime {

// ====================不对recycle外部使用，用于recycle内部多个文件之间调用=========================//
bool CompleteProcMultipleTaskReport(TaskInfo * const workTask, const rtLogicCqReport_t &report);
void ProcLogicCqReport(Device * const dev, rtLogicCqReport_t &logicCq, TaskInfo *reportTask);
rtError_t FinishedTaskReclaim(const Stream * const stm, const bool limited, const uint16_t curPos,
    const uint16_t tarPos);
rtError_t GetDrvSqHead(const Stream * const stm, uint16_t &sqHead, bool needLog = true);
bool ProcReportIsDvppErrorAndRetry(const rtLogicCqReport_t& report, TaskInfo *const reportTask);
void TryReclaimToTask(TaskInfo *workTask);
rtError_t ProcReport(Device * const dev, uint32_t streamId, const uint32_t syncPos, const uint32_t cnt,
    rtLogicCqReport_t * const logicReport, bool &isFinished);
void ProcCqReportException(Device * const dev, rtLogicCqReport_t &logicCq,
    TaskInfo *reportTask, uint16_t streamId);
// 处理完异常CQE后rt侧拉起sq
rtError_t StarsResumeRtsq(const rtLogicCqReport_t *logicCq, const TaskInfo * const taskInfo);
rtError_t RecycleTaskBySqHead(const Stream * const stm);
rtError_t AdjustRecycleTaskID(const Stream * const stm, const uint32_t endTaskId, const uint16_t recyclePos);

// ===================== 对外API =================================================================//
TaskInfo* GetTaskInfo(const Device * const dev, uint32_t streamId, uint32_t pos);
// 模型流中的任务回收
void RecycleModelBindStreamAllTask(Stream * const stm, const bool cleanFlag);

// 上层使用时，一定要加流同步锁StreamSyncLock
rtError_t SyncTask(Stream * const stm, const uint32_t taskResPos, int32_t timeout);
rtError_t TaskReclaimByStream(const Stream * const stm, const bool limited, const bool needLog = true);

// device stop时，全量回收。异常析构流程可能进，因此跟老形态保持一致，不能加锁，加锁可能会出现递归锁
rtError_t TaskReclaimAllStream(const Device * const dev);

// 下发流程中进行的task回收， 内部已经有流同步锁，上层不能加
rtError_t TryRecycleTask(Stream * const stm);

// dvpp专用，老代码未见加锁
rtError_t DvppWaitGroup(const Device * const dev, const DvppGrp *grp, rtDvppGrpCallback callBackFunc,
    const int32_t timeout);
}
}
#endif

