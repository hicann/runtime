/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "task_info_v100.h"
#include "task_info.hpp"
#include "stars_sqe.hpp"
#include "cond_op_stream_task.h"
#include "stream.hpp"
#include "runtime.hpp"
#include "model.hpp"
#include "stars_cond_isa_helper.hpp"
#include "runtime_task_manager.h"
#include "cond_op_label_task.h"
#include "kernel.hpp"
#include "enum_desc.hpp"

namespace cce {
namespace runtime {

#if F_DESC("LabelSetTask")
void ConstructSqeForLabelSetTask(TaskInfo* taskInfo, rtStarsSqe_t* const command)
{
    RtStarsPhSqe* const sqe = (RtStarsPhSqe*)&(command->phSqe);
    Stream* const stm = taskInfo->stream;
    sqe->header.type = RT_STARS_SQE_TYPE_PLACE_HOLDER;
    sqe->header.l1Lock = 0U;
    sqe->header.l1UnLock = 0U;
    sqe->header.ie = RT_STARS_SQE_INT_DIR_NO;
    sqe->header.preP = RT_STARS_SQE_INT_DIR_NO;
    sqe->header.postP = RT_STARS_SQE_INT_DIR_NO;
    sqe->header.wrCqe = stm->GetStarsWrCqeFlag();
    sqe->header.res1 = 0U;
    sqe->header.rdConds = 0U;
    sqe->header.u.sqeSubType = RT_SQE_SUBTYPE_CONDS_LABEL_SET;
    sqe->header.taskId = taskInfo->id;
    sqe->header.rtStreamId = static_cast<uint16_t>(stm->Id_());

    sqe->u.labelSetInfo.labelId = taskInfo->u.labelSetTask.labelId;
    Model* mdl = stm->Model_();
    if (mdl != nullptr) {
        mdl->LabelCountInc();
    }
    PrintSqe(command, "LabelSet");
    RT_LOG(RT_LOG_INFO, "LabelSetTask stream_id:%d task_id:%u", stm->Id_(), static_cast<uint32_t>(taskInfo->id));
}
#endif

#if F_DESC("StreamSwitchTask")

rtError_t StreamSwitchTaskInitV2(
    TaskInfo* taskInfo, const void* const ptrAddr, const rtCondition_t condi, const Stream* const trueStream,
    const void* const valPtr, const rtSwitchDataType_t taskDataType)
{
    TaskCommonInfoInit(taskInfo);
    taskInfo->type = TS_TASK_TYPE_STREAM_SWITCH;
    taskInfo->typeName = "STREAM_SWITCH";

    StreamSwitchTaskInfo* streamSwitchTask = &(taskInfo->u.streamswitchTask);
    streamSwitchTask->value = 0L;
    streamSwitchTask->funcCallSvmMem = nullptr;
    streamSwitchTask->baseFuncCallSvmMem = nullptr;
    streamSwitchTask->dfxPtr = nullptr;

    streamSwitchTask->ptr = RtPtrToValue(ptrAddr);
    streamSwitchTask->valuePtr = RtPtrToValue(valPtr);
    streamSwitchTask->condition = condi;
    streamSwitchTask->trueStreamId = static_cast<uint32_t>(trueStream->Id_());
    streamSwitchTask->dataType = taskDataType;
    streamSwitchTask->isCondEx = true;
    streamSwitchTask->trueStream = const_cast<Stream*>(trueStream);
    streamSwitchTask->funCallMemSize = sizeof(rtStarsStreamSwitchExFc_t);
    streamSwitchTask->phyPtr = 0UL;
    streamSwitchTask->phyValuePtr = 0UL;
    return RT_ERROR_NONE;
}

void ConstructSqeForStreamSwitchTask(TaskInfo* taskInfo, rtStarsSqe_t* const command)
{
    Stream* const stm = taskInfo->stream;
    StreamSwitchTaskInfo* streamSwitchTask = &(taskInfo->u.streamswitchTask);
    RtStarsPhSqe* const sqe = (RtStarsPhSqe*)&(command->phSqe);

    sqe->header.postP = RT_STARS_SQE_INT_DIR_NO;
    sqe->header.wrCqe = stm->GetStarsWrCqeFlag();
    sqe->header.rdConds = 0U;
    sqe->header.res1 = 0U;
    sqe->header.u.sqeSubType = RT_SQE_SUBTYPE_CONDS_STREAM_SWITCH_EX;
    sqe->header.rtStreamId = static_cast<uint16_t>(stm->Id_());
    sqe->header.taskId = taskInfo->id;
    sqe->header.type = RT_STARS_SQE_TYPE_PLACE_HOLDER;
    sqe->header.l1Lock = 0U;
    sqe->header.l1UnLock = 0U;
    sqe->header.ie = RT_STARS_SQE_INT_DIR_NO;
    sqe->header.preP = RT_STARS_SQE_INT_DIR_TO_TSCPU;

    sqe->u.streamSwitchExInfo.trueStreamId = streamSwitchTask->trueStreamId;
    sqe->u.streamSwitchExInfo.condition = streamSwitchTask->condition;
    sqe->u.streamSwitchExInfo.dataType = streamSwitchTask->dataType;
    sqe->u.streamSwitchExInfo.varPtr = streamSwitchTask->ptr;
    sqe->u.streamSwitchExInfo.valPtr = streamSwitchTask->valuePtr;
    PrintSqe(command, "StreamSwitchTask");
    RT_LOG(
        RT_LOG_INFO,
        "StreamSwitchTask current streamId=%d, taskId=%hu, trueStreamId=%u, type=%u, sqeSubType=%" PRIu16
        ", preP=%u, condition=%s, dataType=%s, leftPtr=%" PRIu64 ", rightPtr=%" PRIu64 ".",
        stm->Id_(), taskInfo->id, streamSwitchTask->trueStreamId, static_cast<unsigned int>(sqe->header.type),
        sqe->header.u.sqeSubType, static_cast<unsigned int>(sqe->header.preP),
        ConditionToString(streamSwitchTask->condition).c_str(),
        SwitchDataTypeToString(streamSwitchTask->dataType).c_str(), sqe->u.streamSwitchExInfo.varPtr,
        sqe->u.streamSwitchExInfo.valPtr);

    return;
}
#endif

#if F_DESC("StreamLabelSwitchByIndexTask")

rtError_t StreamLabelSwitchByIndexTaskInit(
    TaskInfo* taskInfo, void* const idPtr, const uint32_t maxIndex, void* const labelPtr)
{
    TaskCommonInfoInit(taskInfo);
    taskInfo->typeName = "STREAM_LABEL_SWITCH_BY_INDEX";
    taskInfo->type = TS_TASK_TYPE_STREAM_LABEL_SWITCH_BY_INDEX;
    taskInfo->u.stmLabelSwitchIdxTask.indexPtr = idPtr;
    taskInfo->u.stmLabelSwitchIdxTask.labelInfoPtr = labelPtr;
    taskInfo->u.stmLabelSwitchIdxTask.phyIndexPtr = 0ULL;
    taskInfo->u.stmLabelSwitchIdxTask.phyLabelInfoPtr = 0ULL;
    taskInfo->u.stmLabelSwitchIdxTask.max = maxIndex;
    taskInfo->u.stmLabelSwitchIdxTask.funCallMemSize = 0UL;
    taskInfo->u.stmLabelSwitchIdxTask.funcCallSvmMem = nullptr;
    taskInfo->u.stmLabelSwitchIdxTask.dfxPtr = nullptr;
    taskInfo->u.stmLabelSwitchIdxTask.baseFuncCallSvmMem = nullptr;

    RT_LOG(RT_LOG_DEBUG, "Stream label switch task, max=%u.", taskInfo->u.stmLabelSwitchIdxTask.max);
    return RT_ERROR_NONE;
}

void ConstructSqeForStreamLabelSwitchByIndexTask(TaskInfo* taskInfo, rtStarsSqe_t* const command)
{
    RtStarsPhSqe* const sqe = (RtStarsPhSqe*)&(command->phSqe);
    Stream* const stm = taskInfo->stream;
    sqe->header.type = RT_STARS_SQE_TYPE_PLACE_HOLDER;
    sqe->header.l1Lock = 0U;
    sqe->header.l1UnLock = 0U;
    sqe->header.ie = RT_STARS_SQE_INT_DIR_NO;
    sqe->header.preP = RT_STARS_SQE_INT_DIR_TO_TSCPU;
    sqe->header.postP = RT_STARS_SQE_INT_DIR_NO;
    sqe->header.wrCqe = stm->GetStarsWrCqeFlag();
    sqe->header.res1 = 0U;
    sqe->header.rdConds = 0U;
    sqe->header.u.sqeSubType = RT_SQE_SUBTYPE_CONDS_LABEL_SWITCH_BY_INDEX;

    sqe->header.taskId = taskInfo->id;
    sqe->header.rtStreamId = static_cast<uint16_t>(stm->Id_());

    sqe->u.labelSwitchInfo.indexPtr = RtPtrToValue<void*>(taskInfo->u.stmLabelSwitchIdxTask.indexPtr);
    sqe->u.labelSwitchInfo.labelInfoPtr = RtPtrToValue<void*>(taskInfo->u.stmLabelSwitchIdxTask.labelInfoPtr);
    if (stm->Model_() != nullptr) {
        sqe->u.labelSwitchInfo.labelCountPtr = stm->Model_()->GetLabelCountdevPtr();
    }
    sqe->u.labelSwitchInfo.labelMax = taskInfo->u.stmLabelSwitchIdxTask.max;
    PrintSqe(command, "StreamLabelSwitchByIndexTask");
    RT_LOG(
        RT_LOG_INFO, "LabelSwitchByIndexTask stream_id:%d task_id:%u", stm->Id_(), static_cast<uint32_t>(taskInfo->id));
}
#endif

static bool CondOpLabelTaskRegister()
{
    TaskFuncSingle labelSetFuncs = {
        .toCommandFunc = nullptr,
        .toSqeFunc = &ConstructSqeForLabelSetTask,
        .doCompleteSuccFunc = nullptr,
        .taskUnInitFunc = nullptr,
        .waitAsyncCpCompleteFunc = nullptr,
        .printErrorInfoFunc = nullptr,
        .setResultFunc = nullptr,
        .setStarsResultFunc = &SetStarsResultCommon,
    };

    RegTaskFunc(CHIP_5162A, TS_TASK_TYPE_LABEL_SET, labelSetFuncs);

    return true;
}

static bool CondOpStreamTaskRegister()
{
    TaskFuncSingle streamSwitchFuncs = {
        .toCommandFunc = nullptr,
        .toSqeFunc = &ConstructSqeForStreamSwitchTask,
        .doCompleteSuccFunc = &DoCompleteSuccess,
        .taskUnInitFunc = nullptr,
        .waitAsyncCpCompleteFunc = nullptr,
        .printErrorInfoFunc = nullptr,
        .setResultFunc = nullptr,
        .setStarsResultFunc = &SetStarsResultCommon,
    };
    TaskFuncSingle streamLabelSwitchByIndexFuncs = {
        .toCommandFunc = nullptr,
        .toSqeFunc = &ConstructSqeForStreamLabelSwitchByIndexTask,
        .doCompleteSuccFunc = &DoCompleteSuccess,
        .taskUnInitFunc = nullptr,
        .waitAsyncCpCompleteFunc = nullptr,
        .printErrorInfoFunc = nullptr,
        .setResultFunc = nullptr,
        .setStarsResultFunc = &SetStarsResultCommon,
    };

    RegTaskFunc(CHIP_5162A, TS_TASK_TYPE_STREAM_SWITCH, streamSwitchFuncs);
    RegTaskFunc(CHIP_5162A, TS_TASK_TYPE_STREAM_LABEL_SWITCH_BY_INDEX, streamLabelSwitchByIndexFuncs);

    return true;
}

static bool g_condOpStreamTaskRegister = CondOpStreamTaskRegister();
static bool g_condOpLabelTaskRegister = CondOpLabelTaskRegister();

} // namespace runtime
} // namespace cce