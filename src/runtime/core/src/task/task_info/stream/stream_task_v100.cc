/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "stars_cond_isa_helper.hpp"
#include "task_manager.h"
#include "stream_sqcq_manage.hpp"
#include "stream_task.h"
#include "task_info_v100.h"
#include "stub_task.hpp"
#include "arg_loader/arg_loader.hpp"

namespace cce {
namespace runtime {

#if F_DESC("CreateStreamTask")
void SetResultForCreateStreamTask(TaskInfo * const taskInfo, const void *const data, const uint32_t dataSize)
{
    UNUSED(dataSize);
    Stream * const stream = taskInfo->stream;

    if ((stream->Flags() & RT_STREAM_PRIMARY_FIRST_DEFAULT) != 0U) {
        const uint32_t *const tsData = static_cast<const uint32_t *>(data);
        const uint32_t payLoad = *tsData;
        // for create stream task, payLoad(0~11 bit): error code, payLoad(12~31 bit): tsch build version
        const uint32_t tschVersion = static_cast<uint32_t>(payLoad >> 12U);
        Device *const devicePtr = stream->Device_();
        const Stream *const defaultStream = devicePtr->PrimaryStream_();
        if (defaultStream == nullptr) {
            RT_LOG_INNER_MSG(RT_LOG_ERROR,
                "SetResultForCreateStreamTask failed because defaultStream cannot be a NULL pointer, deviceId=%u.",
                taskInfo->stream->Device_()->Id_());
            return;
        }
        if (stream->Id_() == defaultStream->Id_()) {
            devicePtr->SetTschVersion(tschVersion);
        }
        RT_LOG(RT_LOG_DEBUG, "CreateStreamTask set result, payLoad=%u.", payLoad);
    }
}
#endif

#if F_DESC("SetSqLockUnlockTask")
// Construct the sq lock or unlock sqe.
void ConstructSqeForSetSqLockUnlockTask(TaskInfo* taskInfo, rtStarsSqe_t *const command)
{
    Stream * const stm = taskInfo->stream;
    RtStarsPhSqe *const sqe = &(command->phSqe);
    sqe->type = RT_STARS_SQE_TYPE_PLACE_HOLDER;
    sqe->ie = 0U;
    sqe->pre_p = 0U;
    sqe->post_p = 0U;
    sqe->l2_lock = taskInfo->u.sqLockUnlockTask.sqLock;
    sqe->l2_unlock = taskInfo->u.sqLockUnlockTask.sqUnlock;
    sqe->wr_cqe = 0U;
    sqe->res0 = 0U;
    sqe->rt_streamID = static_cast<uint16_t>(stm->Id_());
    sqe->task_id = taskInfo->id;
    sqe->task_type = TS_TASK_TYPE_SET_SQ_LOCK_UNLOCK;
    sqe->kernel_credit = RT_STARS_DEFAULT_KERNEL_CREDIT;

    PrintSqe(command, "SetSqLockUnlock");
    RT_LOG(RT_LOG_INFO, "send SetSqLockUnlock succ,"
        "sqe_type=%u,pre_p=%u,stream_id=%u,task_id=%u,task_type=%u.",
        sqe->type, sqe->pre_p, sqe->rt_streamID, sqe->task_id, sqe->task_type);

    return;
}
#endif

#if F_DESC("StreamActiveTask")
void ConstructSqeForStreamActiveTask(TaskInfo* taskInfo, rtStarsSqe_t * const command)
{
    StreamActiveTaskInfo *streamActiveTask = &(taskInfo->u.streamactiveTask);
    Stream * const stream = taskInfo->stream;
    RtStarsFunctionCallSqe &sqe = command->fuctionCallSqe;
    sqe.kernel_credit = RT_STARS_DEFAULT_KERNEL_CREDIT;
    sqe.csc = 1U;
    sqe.sqeHeader.l1_lock = 0U;
    sqe.sqeHeader.l1_unlock = 0U;
    sqe.sqeHeader.type = RT_STARS_SQE_TYPE_COND;
    sqe.sqeHeader.wr_cqe = stream->GetStarsWrCqeFlag();
    sqe.sqeHeader.block_dim = 0U;
    sqe.sqeHeader.rt_stream_id = static_cast<uint16_t>(stream->Id_());
    sqe.sqeHeader.task_id = taskInfo->id;
    sqe.conds_sub_type = CONDS_SUB_TYPE_STREAM_ACTIVE;

    const uint64_t funcAddr = RtPtrToValue<void *>(streamActiveTask->funcCallSvmMem);
    constexpr uint64_t funcCallSize = static_cast<uint64_t>(sizeof(RtStarsStreamActiveFc));

    // func call size is rs2[19:0]*4Byte
    ConstructFunctionCallInstr(funcAddr, (funcCallSize / 4UL), sqe);

    PrintSqe(command, "StreamActiveTask");
    RT_LOG(RT_LOG_INFO, "StreamActiveTask stream_id=%d,task_id=%hu,active_stream_id=%u.",
        stream->Id_(), taskInfo->id, streamActiveTask->activeStreamId);
}

#endif

#if F_DESC("OverflowSwitchSetTask")
void ConstructSqeForOverflowSwitchSetTask(TaskInfo* taskInfo, rtStarsSqe_t *const command)
{
    RtStarsPhSqe * const sqe = &(command->phSqe);
    OverflowSwitchSetTaskInfo *overflowSwiSet = &taskInfo->u.overflowSwitchSetTask;

    sqe->type = RT_STARS_SQE_TYPE_PLACE_HOLDER;
    sqe->pre_p = 1U;
    sqe->wr_cqe = taskInfo->stream->GetStarsWrCqeFlag();
    sqe->res0 = 0U;
    sqe->task_type = TS_TASK_TYPE_SET_OVERFLOW_SWITCH;
    sqe->rt_streamID = static_cast<uint16_t>(taskInfo->stream->Id_());
    sqe->task_id = taskInfo->id;
    sqe->kernel_credit = RT_STARS_DEFAULT_KERNEL_CREDIT;

    sqe->u.stream_overflow_switch_info.streamId = static_cast<uint16_t>(overflowSwiSet->targetStm->Id_());
    sqe->u.stream_overflow_switch_info.isSwitchOn = overflowSwiSet->switchFlag ? 1U : 0U;

    PrintSqe(command, "OverflowSwitchSetTask");
    const std::string switchFlag = overflowSwiSet->switchFlag ? "on" : "off";
    RT_LOG(RT_LOG_INFO, "OverflowSwitchSetTask target stream_id=%d switch %s",
        overflowSwiSet->targetStm->Id_(), switchFlag.c_str());
}
#endif

#if F_DESC("StreamTagSetTask")
void ConstructSqeForStreamTagSetTask(TaskInfo* taskInfo, rtStarsSqe_t *const command)
{
    StreamTagSetTaskInfo *stmTagSetTsk = &taskInfo->u.stmTagSetTask;

    RtStarsPhSqe * const sqe = &(command->phSqe);
    sqe->type = RT_STARS_SQE_TYPE_PLACE_HOLDER;
    sqe->pre_p = 1U;
    sqe->wr_cqe = taskInfo->stream->GetStarsWrCqeFlag();
    sqe->res0 = 0U;
    sqe->task_type = TS_TASK_TYPE_SET_STREAM_GE_OP_TAG;
    sqe->rt_streamID = static_cast<uint16_t>(taskInfo->stream->Id_());
    sqe->task_id = taskInfo->id;
    sqe->kernel_credit = RT_STARS_DEFAULT_KERNEL_CREDIT;

    sqe->u.stream_set_tag_info.streamId = static_cast<uint16_t>(stmTagSetTsk->targetStm->Id_());
    sqe->u.stream_set_tag_info.geOpTag = stmTagSetTsk->geOpTag;

    PrintSqe(command, "StreamTagSetTask");
    RT_LOG(RT_LOG_INFO, "StreamTagSetTask target stream id=%d, sqe stream id =%hu, geOpTag=%u",
        stmTagSetTsk->targetStm->Id_(), sqe->rt_streamID, stmTagSetTsk->geOpTag);
}
#endif

#if F_DESC("CallbackLaunchTask")
void ConstructSqeForCallbackLaunchTask(TaskInfo* taskInfo, rtStarsSqe_t *const command)
{
    uint32_t pid = 0U;
    RtStarsHostfuncCallbackSqe *const sqe = &(command->callbackSqe);
    Stream *stm = taskInfo->stream;

    sqe->header.type = RT_STARS_SQE_TYPE_AICPU;
    sqe->header.l1_lock = 0U;
    sqe->header.l1_unlock = 0U;
    sqe->header.ie = RT_STARS_SQE_INT_DIR_NO;
    sqe->header.pre_p = RT_STARS_SQE_INT_DIR_NO;
    sqe->header.post_p = RT_STARS_SQE_INT_DIR_NO;
    sqe->header.wr_cqe = 1U;    // callback need write cqe
    sqe->header.reserved = 0U;
    sqe->header.block_dim = 1U;
    sqe->header.rt_stream_id = static_cast<uint16_t>(stm->Id_());
    sqe->header.task_id = taskInfo->id;

    sqe->kernel_type = static_cast<uint16_t>(TS_AICPU_KERNEL_NON);
    sqe->batch_mode = 0U;

    if (taskInfo->stream->Device_()->Driver_()->GetRunMode() == RT_RUN_MODE_OFFLINE) {
        sqe->topic_type = TOPIC_TYPE_DEVICE_CTRL_CPU;
        // TSCPU, Device CtrlCPU and DvppCPU must init dest_pid
        (void)taskInfo->stream->Device_()->Driver_()->DeviceGetBareTgid(&pid);
    } else {
        sqe->topic_type = TOPIC_TYPE_HOST_CTRL_CPU;
    }

    sqe->qos = 0U;
    sqe->res1 = 0U;
    sqe->sqe_index = 0U; // useless
    sqe->kernel_credit = RT_STARS_DEFAULT_KERNEL_CREDIT;

    sqe->cb_cq_id = static_cast<uint16_t>(stm->GetCbRptCqid());
    sqe->cb_group_id = static_cast<uint16_t>(stm->GetCbGrpId());
    sqe->dev_id = static_cast<uint16_t>(stm->Device_()->Id_());
    sqe->stream_id = static_cast<uint16_t>(stm->Id_());

    sqe->event_id = static_cast<uint16_t>(taskInfo->u.callbackLaunchTask.eventId);
    sqe->isBlock = taskInfo->u.callbackLaunchTask.isBlock;
    sqe->task_id = taskInfo->id;  //  send taskId callback cqe

    uint64_t addr = RtPtrToValue<rtCallback_t>(taskInfo->u.callbackLaunchTask.callBackFunc);
    sqe->hostfunc_addr_low = static_cast<uint32_t>(addr);
    sqe->hostfuncAddrHigh = static_cast<uint16_t>(addr >> UINT32_BIT_NUM);

    addr = RtPtrToValue<void *>(taskInfo->u.callbackLaunchTask.fnData);
    sqe->fndata_low = static_cast<uint32_t>(addr);
    sqe->fndata_high = static_cast<uint16_t>(addr >> UINT32_BIT_NUM);

    sqe->subTopicId = 0U;
    sqe->topicId = 26U;     // EVENT_TS_CALLBACK_MSG
    sqe->group_id = 11U;     // 11U, drv defined
    sqe->usr_data_len = 32U; // word 4 to word 11
    sqe->dest_pid = pid;

    PrintSqe(command, "CallbackLaunch");
    RT_LOG(RT_LOG_INFO, "CallbackLaunch, topic_type=%hu, stream_id=%hu, task_id=%hu, event_id=%hu, isBlock=%hu, pid=%u",
        sqe->topic_type, sqe->stream_id, taskInfo->id, sqe->event_id, sqe->isBlock, sqe->dest_pid);
}
#endif

#if F_DESC("SqeUpdateTask")
rtError_t WaitAsyncCopyCompleteForUpdateTask(TaskInfo* taskInfo)
{
    SqeUpdateTaskInfo *sqeUpdateTask = &(taskInfo->u.sqeUpdateTask);
    if (sqeUpdateTask->updateArgHandle == nullptr) {
        return RT_ERROR_NONE;
    }
    Handle *argHdl = static_cast<Handle *>(sqeUpdateTask->updateArgHandle);
    if (!(argHdl->freeArgs) || argHdl->argsAlloc == nullptr || argHdl->kerArgs == nullptr) {
        return RT_ERROR_NONE;
    }
    const rtError_t error = argHdl->argsAlloc->H2DMemCopyWaitFinish(argHdl->kerArgs);
    if (error != RT_ERROR_NONE) {
        RT_LOG_INNER_MSG(RT_LOG_ERROR, "H2DMemCopyWaitFinish for args cpy result failed, retCode=%#x.", static_cast<uint32_t>(error));
        return error;
    }

    return RT_ERROR_NONE;
}
#endif

#if F_DESC("FlipTask")
void ConstructSqeForFlipTask(TaskInfo* taskInfo, rtStarsSqe_t *const command)
{
    FlipTaskInfo *flipTaskInfo = &(taskInfo->u.flipTask);
    Stream *const stm = taskInfo->stream;
    RtStarsPhSqe *const sqe = &(command->phSqe);
    sqe->type = RT_STARS_SQE_TYPE_PLACE_HOLDER;
    sqe->ie = 0U;
    sqe->pre_p = 1U;
    sqe->post_p = 0U;
    sqe->wr_cqe = 0U;
    sqe->res0 = 0U;
    sqe->rt_streamID = static_cast<uint16_t>(stm->Id_());
    if (flipTaskInfo->subType == RT_FLIP_TASK_STREAM_ID) {
        sqe->task_id = RT_MILAN_TASK_ID_MAX;
    } else {
        sqe->task_id = taskInfo->id;
    }
    sqe->task_type = TS_TASK_TYPE_FLIP;
    sqe->kernel_credit = RT_STARS_DEFAULT_KERNEL_CREDIT;
    sqe->u.flip_task_info.flipNumReport = flipTaskInfo->flipNumReport;
    sqe->u.flip_task_info.streamId = flipTaskInfo->streamId;
    sqe->u.flip_task_info.subType = flipTaskInfo->subType;
    PrintSqe(command, "FlipTask");
    RT_LOG(RT_LOG_INFO, "launch FlipTask succ, sqe_type=%u, pre_p=%u, stream_id=%u, task_id=%u, flip_num=%u, sub_type=%u.",
           sqe->type, sqe->pre_p, sqe->rt_streamID, sqe->task_id, flipTaskInfo->flipNumReport, sqe->u.flip_task_info.subType);
}
#endif

static bool StreamTaskRegister()
{
    TaskFuncSingle createStreamFuncs = {
        .toCommandFunc = &ToCommandBodyForCreateStreamTask,
        .toSqeFunc = &ConstructSqeBase,
        .doCompleteSuccFunc = &DoCompleteSuccess,
        .taskUnInitFunc = nullptr,
        .waitAsyncCpCompleteFunc = nullptr,
        .printErrorInfoFunc = &PrintErrorInfoCommon,
        .setResultFunc = &SetResultForCreateStreamTask,
        .setStarsResultFunc = &SetStarsResultCommon,
    };
    TaskFuncSingle streamActiveFuncs = {
        .toCommandFunc = &ToCommandBodyForStreamActiveTask,
        .toSqeFunc = &ConstructSqeForStreamActiveTask,
        .doCompleteSuccFunc = &DoCompleteSuccess,
        .taskUnInitFunc = &StreamActiveTaskUnInit,
        .waitAsyncCpCompleteFunc = nullptr,
        .printErrorInfoFunc = &PrintErrorInfoForStreamActiveTask,
        .setResultFunc = &SetResultCommon,
        .setStarsResultFunc = &SetStarsResultCommon,
    };
    TaskFuncSingle activeAicpuStreamFuncs = {
        .toCommandFunc = &ToCmdBodyForActiveAicpuStreamTask,
        .toSqeFunc = &ConstructSqeBase,
        .doCompleteSuccFunc = &DoCompleteSuccess,
        .taskUnInitFunc = nullptr,
        .waitAsyncCpCompleteFunc = nullptr,
        .printErrorInfoFunc = &PrintErrorInfoCommon,
        .setResultFunc = &SetResultCommon,
        .setStarsResultFunc = &SetStarsResultCommon,
    };
    TaskFuncSingle callbackLaunchFuncs = {
        .toCommandFunc = &ToCmdBodyForCallbackLaunchTask,
        .toSqeFunc = &ConstructSqeForCallbackLaunchTask,
        .doCompleteSuccFunc = &DoCompleteSuccess,
        .taskUnInitFunc = nullptr,
        .waitAsyncCpCompleteFunc = nullptr,
        .printErrorInfoFunc = &PrintErrorInfoCommon,
        .setResultFunc = &SetResultCommon,
        .setStarsResultFunc = &SetStarsResultCommon,
    };
    TaskFuncSingle overflowSwitchFuncs = {
        .toCommandFunc = nullptr,
        .toSqeFunc = &ConstructSqeForOverflowSwitchSetTask,
        .doCompleteSuccFunc = &DoCompleteSuccess,
        .taskUnInitFunc = nullptr,
        .waitAsyncCpCompleteFunc = nullptr,
        .printErrorInfoFunc = &PrintErrorInfoCommon,
        .setResultFunc = &SetResultCommon,
        .setStarsResultFunc = &SetStarsResultCommon,
    };
    TaskFuncSingle streamTagFuncs = {
        .toCommandFunc = nullptr,
        .toSqeFunc = &ConstructSqeForStreamTagSetTask,
        .doCompleteSuccFunc = &DoCompleteSuccess,
        .taskUnInitFunc = nullptr,
        .waitAsyncCpCompleteFunc = nullptr,
        .printErrorInfoFunc = &PrintErrorInfoCommon,
        .setResultFunc = &SetResultCommon,
        .setStarsResultFunc = &SetStarsResultCommon,
    };
    TaskFuncSingle streamModeFuncs = {
        .toCommandFunc = &ToCmdBodyForSetStreamModeTask,
        .toSqeFunc = &ConstructSqeBase,
        .doCompleteSuccFunc = nullptr,
        .taskUnInitFunc = nullptr,
        .waitAsyncCpCompleteFunc = nullptr,
        .printErrorInfoFunc = &PrintErrorInfoCommon,
        .setResultFunc = &SetResultCommon,
        .setStarsResultFunc = &SetStarsResultCommon,
    };
    TaskFuncSingle sqLockUnlockFuncs = {
        .toCommandFunc = nullptr,
        .toSqeFunc = &ConstructSqeForSetSqLockUnlockTask,
        .doCompleteSuccFunc = &DoCompleteSuccess,
        .taskUnInitFunc = nullptr,
        .waitAsyncCpCompleteFunc = nullptr,
        .printErrorInfoFunc = &PrintErrorInfoCommon,
        .setResultFunc = &SetResultCommon,
        .setStarsResultFunc = &SetStarsResultCommon,
    };
    TaskFuncSingle flipFuncs = {
        .toCommandFunc = &ToCmdBodyForFlipTask,
        .toSqeFunc = &ConstructSqeForFlipTask,
        .doCompleteSuccFunc = nullptr,
        .taskUnInitFunc = nullptr,
        .waitAsyncCpCompleteFunc = nullptr,
        .printErrorInfoFunc = &PrintErrorInfoCommon,
        .setResultFunc = &SetResultCommon,
        .setStarsResultFunc = &SetStarsResultCommon,
    };
    TaskFuncSingle sqeUpdateFuncs = {
        .toCommandFunc = &ToCommandBodyForSqeUpdateTask,
        .toSqeFunc = nullptr,
        .doCompleteSuccFunc = &DoCompleteSuccess,
        .taskUnInitFunc = nullptr,
        .waitAsyncCpCompleteFunc = &WaitAsyncCopyCompleteForUpdateTask,
        .printErrorInfoFunc = &PrintErrorInfoCommon,
        .setResultFunc = &SetResultCommon,
        .setStarsResultFunc = &SetStarsResultCommon,
    };

    const auto& chips = GetV100Chips();
    for (const auto chip : chips) {
        RegTaskFunc(chip, TS_TASK_TYPE_CREATE_STREAM, createStreamFuncs);
        RegTaskFunc(chip, TS_TASK_TYPE_STREAM_ACTIVE, streamActiveFuncs);
        RegTaskFunc(chip, TS_TASK_TYPE_ACTIVE_AICPU_STREAM, activeAicpuStreamFuncs);
        RegTaskFunc(chip, TS_TASK_TYPE_HOSTFUNC_CALLBACK, callbackLaunchFuncs);
        RegTaskFunc(chip, TS_TASK_TYPE_SET_OVERFLOW_SWITCH, overflowSwitchFuncs);
        RegTaskFunc(chip, TS_TASK_TYPE_SET_STREAM_GE_OP_TAG, streamTagFuncs);
        RegTaskFunc(chip, TS_TASK_TYPE_SET_STREAM_MODE, streamModeFuncs);
        RegTaskFunc(chip, TS_TASK_TYPE_SET_SQ_LOCK_UNLOCK, sqLockUnlockFuncs);
        RegTaskFunc(chip, TS_TASK_TYPE_FLIP, flipFuncs);
        RegTaskFunc(chip, TS_TASK_TYPE_TASK_SQE_UPDATE, sqeUpdateFuncs);
    }

    return true;
}

static bool g_streamTaskRegister = StreamTaskRegister();

}  // namespace runtime
}  // namespace cce
