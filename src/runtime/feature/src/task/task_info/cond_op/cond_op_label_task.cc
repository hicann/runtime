/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "stream.hpp"
#include "runtime.hpp"
#include "context.hpp"
#include "stars_cond_isa_helper.hpp"
#include "cond_op_task.h"

namespace cce {
namespace runtime {

#if F_DESC("LabelSetTask")
rtError_t LabelSetTaskInit(TaskInfo* taskInfo, const uint16_t labelIndex, void * const devDestAddr)
{
    TaskCommonInfoInit(taskInfo);
    taskInfo->type = TS_TASK_TYPE_LABEL_SET;
    taskInfo->typeName = "LABEL_SET";
    taskInfo->u.labelSetTask.labelId = labelIndex;
    taskInfo->u.labelSetTask.devDstAddr = devDestAddr;
    return RT_ERROR_NONE;
}

void ToCommandBodyForLabelSetTask(TaskInfo* taskInfo, rtCommand_t * const command)
{
    command->u.labelSetTask.labelId = taskInfo->u.labelSetTask.labelId;
    Stream * const stm = taskInfo->stream;
    if (stm->Device_()->GetTschVersion() >= TS_VERSION_MORE_LABEL) {
        uint64_t pptr;
        const rtError_t error = taskInfo->stream->Device_()->Driver_()->MemAddressTranslate(
            static_cast<int32_t>(stm->Device_()->Id_()),
            RtPtrToValue(taskInfo->u.labelSetTask.devDstAddr), &pptr);
        COND_RETURN_VOID(error != RT_ERROR_NONE, "convert memory address from virtual to physic failed");
        command->u.labelSetTask.labelPtr = pptr;
        RT_LOG(RT_LOG_DEBUG, "ts support 64k table,add label dev addr=%" PRIu64 " to command.", pptr);
    }
}

void ConstructSqeForLabelSetTask(TaskInfo* taskInfo, rtStarsSqe_t * const command)
{
    Stream * const stm = taskInfo->stream;
    command->phSqe.type = RT_STARS_SQE_TYPE_PLACE_HOLDER;
    command->phSqe.l2_lock = 0U;
    command->phSqe.ie = 0U;
    command->phSqe.pre_p = 0U;
    command->phSqe.post_p = 0U;
    command->phSqe.wr_cqe = stm->GetStarsWrCqeFlag();
    command->phSqe.res0 = 0U;

    command->phSqe.task_type = TS_TASK_TYPE_LABEL_SET;
    command->phSqe.task_id = taskInfo->id;
    command->phSqe.rt_streamID = static_cast<uint16_t>(stm->Id_());
    command->phSqe.kernel_credit = RT_STARS_DEFAULT_KERNEL_CREDIT;
    Model *mdl = stm->Model_();
    if (mdl != nullptr) {
        mdl->LabelCountInc();
    }
    PrintSqe(command, "LabelSet");
    RT_LOG(RT_LOG_INFO, "LabelSetTask stream_id:%d task_id:%u", stm->Id_(), static_cast<uint32_t>(taskInfo->id));
}

// The format : rtsq_id=R1[10:0], head=R1[31:16].
// stSq_id    : the ID of sq which label belong to
// head       : The position of label in sq
void SetLabelInfoForLabelSetTask(TaskInfo* taskInfo, const uint32_t pos)
{
    Stream * const stm = taskInfo->stream;
    const uint32_t labelId = static_cast<uint32_t>(taskInfo->u.labelSetTask.labelId);
    void *devDstAddr = taskInfo->u.labelSetTask.devDstAddr;
    const uint32_t sqId = stm->GetSqId();
    uint16_t * const execTimesSvm = stm->GetExecutedTimesSvm();
    const uint64_t streamExecTimesAddr = RtPtrToValue((execTimesSvm));
    uint32_t labelInfo[RT_CHIP_910_B_93_LABEL_INFO_SIZE/sizeof(uint32_t)];
    // labelInfo format: rtsq_id=R1[10:0], head=R1[31:16]
    labelInfo[0U] = (sqId & 0x7FFU) + (pos << 16U);
    labelInfo[2U] = static_cast<uint32_t>(streamExecTimesAddr & 0x00000000FFFFFFFFU);
    labelInfo[3U] = static_cast<uint32_t>((streamExecTimesAddr & 0xFFFFFFFF00000000U) >> UINT32_BIT_NUM);
    RT_LOG(RT_LOG_DEBUG,
        "LabelSetTask, set label position in sq, labelId:%u, sqId:%u, pos:%u, labelInfo:%u, devDstAddr=%#" PRIx64,
        static_cast<uint32_t>(labelId), sqId, pos, labelInfo,
        RtPtrToValue((devDstAddr)));

    const rtError_t error = taskInfo->stream->Device_()->Driver_()->MemCopySync(devDstAddr,
        RT_CHIP_910_B_93_LABEL_INFO_SIZE, static_cast<void *>(labelInfo), RT_CHIP_910_B_93_LABEL_INFO_SIZE,
        RT_MEMCPY_HOST_TO_DEVICE);
    if (error != RT_ERROR_NONE) {
        RT_LOG_INNER_MSG(RT_LOG_ERROR,
            "labelSetTask set label position in sq failed, label_id=%u, sq_id=%u, pos=%u, retCode=%#x",
            static_cast<uint32_t>(labelId), sqId, pos, static_cast<uint32_t>(error));
    }
}

#endif

#if F_DESC("LabelSwitchTask")
rtError_t LabelSwitchTaskInit(TaskInfo* taskInfo, const void *const ptr, const rtCondition_t cond,
                              const uint32_t val, const uint16_t labelId)
{
    LabelSwitchTaskInfo *labelSwitchTask = &(taskInfo->u.labelSwitchTask);
    TaskCommonInfoInit(taskInfo);
    taskInfo->type = TS_TASK_TYPE_LABEL_SWITCH;
    taskInfo->typeName = "LABEL_SWITCH";

    uint64_t physicPtr;
    const rtError_t error =
        taskInfo->stream->Device_()->Driver_()->MemAddressTranslate(
            static_cast<int32_t>(taskInfo->stream->Device_()->Id_()),
            RtPtrToValue(ptr), &physicPtr);
    ERROR_RETURN_MSG_INNER(error, "Convert memory address from virtual to physic failed,retCode=%#x.", static_cast<uint32_t>(error));

    labelSwitchTask->pptr = physicPtr;
    labelSwitchTask->condition = cond;
    labelSwitchTask->value = val;
    labelSwitchTask->trueLabelId = labelId;
    return RT_ERROR_NONE;
}

void ToCommandBodyForLabelSwitchTask(TaskInfo* taskInfo, rtCommand_t *const command)
{
    LabelSwitchTaskInfo *labelSwitchTask = &(taskInfo->u.labelSwitchTask);
    command->u.labelSwitchTask.pptr = labelSwitchTask->pptr;
    command->u.labelSwitchTask.condition = labelSwitchTask->condition;
    command->u.labelSwitchTask.value = labelSwitchTask->value;
    command->u.labelSwitchTask.true_label_id = labelSwitchTask->trueLabelId;
    command->u.labelSwitchTask.virAddr = MAX_UINT32_NUM;
}

#endif

#if F_DESC("LabelGotoTask")
rtError_t LabelGotoTaskInit(TaskInfo* taskInfo, const uint16_t lblId)
{
    TaskCommonInfoInit(taskInfo);
    taskInfo->type = TS_TASK_TYPE_LABEL_GOTO;
    taskInfo->typeName = "LABEL_GOTO";
    taskInfo->u.labelGotoTask.labelId = lblId;
    return RT_ERROR_NONE;
}

void ToCommandBodyForLabelGotoTask(TaskInfo* taskInfo, rtCommand_t *const command)
{
    command->u.labelGotoTask.labelId = taskInfo->u.labelGotoTask.labelId;
}

#endif

}  // namespace runtime
}  // namespace cce