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
#include "stars_cond_isa_define.hpp"
#include "stars_cond_isa_helper.hpp"
#include "stars_david.hpp"
#include "error_code.h"

namespace cce {
namespace runtime {
void ConstructDavidSqeForStreamLabelSwitchByIndexTask(TaskInfo * const taskInfo, rtDavidSqe_t * const davidSqe, uint64_t sqBaseAddr)
{
    UNUSED(sqBaseAddr);
    ConstructDavidSqeForHeadCommon(taskInfo, davidSqe);
    RtDavidStarsFunctionCallSqe &sqe = davidSqe->fuctionCallSqe;
    StmLabelSwitchByIdxTaskInfo * const stmLblSwiByIdx = &(taskInfo->u.stmLabelSwitchIdxTask);
    sqe.header.type = RT_DAVID_SQE_TYPE_COND;
    sqe.condsSubType = CONDS_SUB_TYPE_LABEL_SWITCH_BY_INDEX;
    sqe.kernelCredit = RT_STARS_DEFAULT_KERNEL_CREDIT_DAVID;
    sqe.sqeLength = 0U;
    sqe.csc = 1U;

    const uint64_t funcAddr = RtPtrToValue(stmLblSwiByIdx->funcCallSvmMem);
    const uint64_t funcCallSize = static_cast<uint64_t>(sizeof(rtStarsLabelSwitchByIndexFc_t));

    // func call size is rs2[19:0]*4Byte
    ConstructFunctionCallInstr(funcAddr, (funcCallSize / 4UL), sqe);

    PrintDavidSqe(davidSqe, "StreamLabelSwitchByIndexTask");
    RT_LOG(RT_LOG_INFO, "StreamLabelSwitchByIndex, deviceId=%u, streamId=%d, taskId=%hu",
        taskInfo->stream->Device_()->Id_(), taskInfo->stream->Id_(), taskInfo->id);
}

void ConstructDavidSqeForStreamSwitchTask(TaskInfo * const taskInfo, rtDavidSqe_t *const davidSqe, uint64_t sqBaseAddr)
{
    Stream * const stm = taskInfo->stream;
    StreamSwitchTaskInfo * const streamSwitchTask = &(taskInfo->u.streamswitchTask);
    UNUSED(sqBaseAddr);
    ConstructDavidSqeForHeadCommon(taskInfo, davidSqe);
    RtDavidStarsFunctionCallSqe &sqe = davidSqe->fuctionCallSqe;

    sqe.header.type = RT_DAVID_SQE_TYPE_COND;
    if (streamSwitchTask->isCondEx) {
        sqe.condsSubType = CONDS_SUB_TYPE_STREAM_SWITCH_EX;
    } else {
        sqe.condsSubType = CONDS_SUB_TYPE_STREAM_SWITCH;
    }

    sqe.kernelCredit = RT_STARS_DEFAULT_KERNEL_CREDIT_DAVID;
    sqe.sqeLength = 0U;
    sqe.csc = 1U;

    const uint64_t funcAddr = RtPtrToValue(streamSwitchTask->funcCallSvmMem);

    // func call size is rs2[19:0]*4Byte
    ConstructFunctionCallInstr(funcAddr, (streamSwitchTask->funCallMemSize / 4UL), sqe);

    PrintDavidSqe(davidSqe, "StreamSwitchTask");
    RT_LOG(RT_LOG_INFO, "StreamSwitchTask, deviceId=%u, streamId=%d, taskId=%hu, trueStreamId=%u.",
        stm->Device_()->Id_(), stm->Id_(), taskInfo->id, streamSwitchTask->trueStreamId);
    return;
}

void ConstructDavidSqeForStreamActiveTask(TaskInfo * const taskInfo, rtDavidSqe_t * const davidSqe, uint64_t sqBaseAddr)
{
    StreamActiveTaskInfo * const streamActiveTask = &(taskInfo->u.streamactiveTask);
    Stream * const stream = taskInfo->stream;
    UNUSED(sqBaseAddr);
    ConstructDavidSqeForHeadCommon(taskInfo, davidSqe);
    RtDavidStarsFunctionCallSqe &sqe = davidSqe->fuctionCallSqe;

    sqe.header.type = RT_DAVID_SQE_TYPE_COND;
    sqe.condsSubType = CONDS_SUB_TYPE_STREAM_ACTIVE;

    sqe.kernelCredit = RT_STARS_DEFAULT_KERNEL_CREDIT_DAVID;
    sqe.sqeLength = 0U;
    sqe.csc = 1U;

    const uint64_t funcAddr = RtPtrToValue(streamActiveTask->funcCallSvmMem);
    const uint64_t funcCallSize = static_cast<uint64_t>(sizeof(RtStarsStreamActiveFc));

    // func call size is rs2[19:0]*4Byte
    ConstructFunctionCallInstr(funcAddr, (funcCallSize / 4UL), sqe);

    PrintDavidSqe(davidSqe, "StreamActiveTask");
    RT_LOG(RT_LOG_INFO, "StreamActiveTask, deviceId=%u, streamId=%d, taskId=%hu, activeStreamId=%u.",
        stream->Device_()->Id_(), stream->Id_(), taskInfo->id, streamActiveTask->activeStreamId);
}

void ConstructDavidSqeForLabelSetTask(TaskInfo * const taskInfo, rtDavidSqe_t * const davidSqe, uint64_t sqBaseAddr)
{
    UNUSED(sqBaseAddr);
    Stream * const stm = taskInfo->stream;
    ConstructDavidSqeForHeadCommon(taskInfo, davidSqe);
    RtDavidPlaceHolderSqe * const sqe = &(davidSqe->phSqe);
    sqe->header.type = RT_DAVID_SQE_TYPE_PLACE_HOLDER;
    sqe->taskType = TS_TASK_TYPE_LABEL_SET;
    sqe->kernelCredit = RT_STARS_DEFAULT_KERNEL_CREDIT_DAVID;
    Model *mdl = stm->Model_();
    if (mdl != nullptr) {
        mdl->LabelCountInc();
    }
    PrintDavidSqe(davidSqe, "LabelSet");
    RT_LOG(RT_LOG_INFO, "LabelSetTask, deviceId=%u, streamId=%d taskId=%hu", stm->Device_()->Id_(), stm->Id_(),
        taskInfo->id);
}

void ConstructDavidSqeForMemWaitValueTask(TaskInfo* taskInfo, rtDavidSqe_t *const davidSqe, uint64_t sqBaseAddr)
{
    constexpr uint8_t MEM_WAIT_SQE_INDEX_1 = 1U;
    constexpr uint8_t MEM_WAIT_SQE_INDEX_2 = 2U;

    RtStarsMemWaitValueInstrFcPara fcPara = {};
    MemWaitValueTaskInfo *memWaitValueTask = &taskInfo->u.memWaitValueTask;
    Stream * const stream = taskInfo->stream;

    fcPara.devAddr = memWaitValueTask->devAddr;
    fcPara.value = memWaitValueTask->value;
    fcPara.flag = memWaitValueTask->flag;
    fcPara.maxLoop = 30ULL;  /* the max loop num */
    fcPara.sqId = stream->GetSqId();
    fcPara.sqHeadPre = (taskInfo->id + 1) % stream->GetSqDepth(); /* = taskResATail_ before alloc */
    fcPara.awSize = memWaitValueTask->awSize;

    // two sqes probably trigger a software constraint when the stream is full, add a nop sqe to evade
    ConstructNopSqeForMemWaitValueTask(taskInfo, davidSqe);

    rtDavidSqe_t *writeSqeAddr = &davidSqe[MEM_WAIT_SQE_INDEX_1];
    if (sqBaseAddr != 0ULL) {
        const uint32_t pos = taskInfo->id + MEM_WAIT_SQE_INDEX_1;
        writeSqeAddr = GetSqPosAddr(sqBaseAddr, pos);
    }
    ConstructFirstDavidSqeForMemWaitValueTask(taskInfo, writeSqeAddr);

    rtDavidSqe_t *condSqeAddr = &davidSqe[MEM_WAIT_SQE_INDEX_2];
    if (sqBaseAddr != 0ULL) {
        const uint32_t pos = taskInfo->id + MEM_WAIT_SQE_INDEX_2;
        condSqeAddr = GetSqPosAddr(sqBaseAddr, pos);
    }
    ConstructSecondDavidSqeForMemWaitValueTask(taskInfo, condSqeAddr, fcPara);
}

void ConstructNopSqeForMemWaitValueTask(TaskInfo* taskInfo, rtDavidSqe_t *const davidSqe)
{
    ConstructDavidSqeForHeadCommon(taskInfo, davidSqe);

    RtDavidPlaceHolderSqe *const sqe = &(davidSqe->phSqe);
    sqe->header.type = RT_DAVID_SQE_TYPE_PLACE_HOLDER;
    sqe->taskType = TS_TASK_TYPE_NOP;
    sqe->kernelCredit = RT_STARS_DEFAULT_KERNEL_CREDIT_DAVID;
    PrintDavidSqe(davidSqe, "MemWaitValueTask nop sqe");
}

void ConstructFirstDavidSqeForMemWaitValueTask(TaskInfo* taskInfo, rtDavidSqe_t *const davidSqe)
{
    ConstructDavidSqeForHeadCommon(taskInfo, davidSqe);

    Stream * const stream = taskInfo->stream;
    RtDavidStarsWriteValueSqe *sqe = &(davidSqe->writeValueSqe);

    sqe->header.type = RT_DAVID_SQE_TYPE_WRITE_VALUE;
    sqe->va = 1U;
    sqe->kernelCredit = RT_STARS_DEFAULT_KERNEL_CREDIT_DAVID;
    sqe->awsize = RT_STARS_WRITE_VALUE_SIZE_TYPE_64BIT;

    constexpr uint64_t value = 0ULL;
    const uint64_t devAddr = RtPtrToValue(taskInfo->u.memWaitValueTask.writeValueAddr);
    if (devAddr == 0ULL) {
        sqe->header.type = RT_DAVID_SQE_TYPE_INVALID;
        return;
    }
    sqe->writeValuePart[0] = static_cast<uint32_t>(value & MASK_32_BIT);
    sqe->writeValuePart[1] = static_cast<uint32_t>(value >> UINT32_BIT_NUM);
    sqe->writeAddrLow = static_cast<uint32_t>(devAddr & MASK_32_BIT);
    sqe->writeAddrHigh = static_cast<uint32_t>((devAddr >> UINT32_BIT_NUM) & MASK_17_BIT);

    PrintDavidSqe(davidSqe, "MemWaitValueTask value write sqe");
    RT_LOG(RT_LOG_INFO, "MemWaitValueTask value write sqe, stream_id=%d, task_id=%hu, devAddr=0x%llx, "
        "value=0x%llx, taskSn=%u", stream->Id_(), taskInfo->id, devAddr, value, taskInfo->taskSn);
}

void ConstructSecondDavidSqeForMemWaitValueTask(TaskInfo* taskInfo, rtDavidSqe_t *const davidSqe,
    const RtStarsMemWaitValueInstrFcPara &fcPara)
{
    ConstructDavidSqeForHeadCommon(taskInfo, davidSqe);

    RtStarsMemWaitValueLastInstrFc fc = {};
    MemWaitValueTaskInfo *memWaitValueTask = &taskInfo->u.memWaitValueTask;
    RtDavidStarsFunctionCallSqe &sqe = davidSqe->fuctionCallSqe;

    ConstructMemWaitValueInstr2(fc, fcPara);

    Stream *stream = taskInfo->stream;
    Device *dev = stream->Device_();
    const rtError_t ret = dev->Driver_()->MemCopySync(memWaitValueTask->funcCallSvmMem2,
        memWaitValueTask->funCallMemSize2, &fc, sizeof(RtStarsMemWaitValueLastInstrFc),
        RT_MEMCPY_HOST_TO_DEVICE);
    if (ret != RT_ERROR_NONE) {
        sqe.header.type = RT_DAVID_SQE_TYPE_INVALID;
        return;
    }

    sqe.header.type = RT_DAVID_SQE_TYPE_COND;
    sqe.kernelCredit = RT_STARS_DEFAULT_KERNEL_CREDIT_DAVID;
    sqe.csc = 1U;
    sqe.condsSubType = CONDS_SUB_TYPE_MEM_WAIT_VALUE;

    const uint64_t funcAddr = RtPtrToValue(memWaitValueTask->funcCallSvmMem2);
    constexpr uint64_t funcCallSize = static_cast<uint64_t>(sizeof(RtStarsMemWaitValueLastInstrFc));

    // func call size is rs2[19:0]*4Byte
    ConstructFunctionCallInstr(funcAddr, (funcCallSize / 4UL), sqe);

    PrintDavidSqe(davidSqe, "MemWaitValueTask condition sqe");
    RT_LOG(RT_LOG_INFO, "MemWaitValueTask condition sqe, stream_id=%d, task_id=%hu, devAddr=0x%llx, "
        "value=0x%llx, sqHeadPre=%u, flag=%u, taskSn=%u", taskInfo->stream->Id_(), taskInfo->id,
        fcPara.devAddr, fcPara.value, fcPara.sqHeadPre, fcPara.flag, taskInfo->taskSn);
}

}  // namespace runtime
}  // namespace cce