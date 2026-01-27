/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "ctrl_sq.hpp"
#include "ctrl_msg.hpp"
#include "task_info.hpp"
#include "stream_factory.hpp"
#include "error_message_manage.hpp"
#include "task.hpp"
#include "model.hpp"
#include "stream.hpp"

namespace cce {
namespace runtime {
using PfnCtrlMsgInit = rtError_t (*)(TaskInfo* taskInfo, const RtCtrlMsgParam& param);
static PfnCtrlMsgInit ctrlMsgHandlerArr[static_cast<uint32_t>(RtCtrlMsgType::RT_CTRL_MSG_MAX)] = {};
CtrlSQ::CtrlSQ(Device * const dev): NoCopy(), device_(dev), stream_(nullptr)
{
}

CtrlSQ::~CtrlSQ() noexcept
{
    (void)DeleteStream(stream_);
}

rtError_t CtrlSQ::Setup()
{
    RegCtrlMsgInitFunc();
    // alloc resource: sq cq streamid
    stream_ = StreamFactory::CreateStream(device_, 0U, RT_STREAM_PRIMARY_DEFAULT);
    COND_RETURN_ERROR_MSG_CALL(ERR_MODULE_SYSTEM, stream_ == nullptr, RT_ERROR_STREAM_NEW,
        "CtrlSQ Setup failed.");
    RT_LOG(RT_LOG_INFO, "CtrlSQ create success, stream_id=%d.", stream_->Id_());

    const rtError_t error = stream_->Setup();
    ERROR_PROC_RETURN_MSG_INNER(error, DeleteStream(stream_);,
        "CtrlSQ setup failed, retCode=%#x.", error);
    RT_LOG(RT_LOG_INFO, "CtrlSQ setup success, stream_id=%d.", stream_->Id_());
    return error;
}

rtError_t CtrlSQ::CreateCtrlMsg(RtCtrlMsgType msgType, const RtCtrlMsgParam &param, uint32_t * const msgId)
{
    NULL_PTR_RETURN_MSG(stream_, RT_ERROR_STREAM_NULL);
    TaskInfo submitTask = {};
    rtError_t error;
    TaskInfo *taskInfo = stream_->AllocTask(&submitTask, param.taskType, error);
    NULL_PTR_RETURN_MSG(taskInfo, error);
    RT_LOG(RT_LOG_INFO, "taskInfo type, type=%u, taskType=%u.", taskInfo->type, param.taskType);
    // 根据type找到对应的setupFunc
    const uint32_t idx = static_cast<uint32_t>(msgType);
    if (ctrlMsgHandlerArr[idx] != nullptr) {
        error = ctrlMsgHandlerArr[idx](taskInfo, param);
    } else {
        RT_LOG(RT_LOG_ERROR, "Ctrl msg handler not found, msgType=%u.", static_cast<uint32_t>(msgType));
    }
    RT_LOG(RT_LOG_INFO, "Ctrl msg create success, msgType=%u.", static_cast<uint32_t>(msgType));

    error = device_->SubmitTask(taskInfo, param.sendParam.callback, msgId, param.sendParam.timeout);
    if (error != RT_ERROR_NONE) {
         (void)device_->GetTaskFactory()->Recycle(taskInfo);
    }
    RT_LOG(RT_LOG_INFO, "Ctrl msg send success, msgType=%u.", static_cast<uint32_t>(msgType));
    return error;
}

// 收cq 判断任务是否完成
rtError_t CtrlSQ::WaitComplete(const bool isNeedWaitSyncCq, int32_t timeout)
{
    NULL_PTR_RETURN_MSG(stream_, RT_ERROR_STREAM_NULL);
    return stream_->Synchronize(isNeedWaitSyncCq, timeout);
}

void CtrlSQ::RegCtrlMsgInitFunc(void) const
{
    ctrlMsgHandlerArr[static_cast<uint32_t>(RtCtrlMsgType::RT_CTRL_MSG_STREAM_CLEAR)] = &CtrlMsgStreamClearInit;
    ctrlMsgHandlerArr[static_cast<uint32_t>(RtCtrlMsgType::RT_CTRL_MSG_STREAM_RECYCLE)] = &CtrlMsgStreamRecycleInit;
    ctrlMsgHandlerArr[static_cast<uint32_t>(RtCtrlMsgType::RT_CTRL_MSG_NOTIFY_RESET)] = &CtrlMsgNotifyResetInit;
    ctrlMsgHandlerArr[static_cast<uint32_t>(RtCtrlMsgType::RT_CTRL_MSG_MODEL_BIND_STREAM)] = &CtrlMsgModelTaskInit;
    ctrlMsgHandlerArr[static_cast<uint32_t>(RtCtrlMsgType::RT_CTRL_MSG_MODEL_UNBIND_STREAM)] = &CtrlMsgModelTaskInit;
    ctrlMsgHandlerArr[static_cast<uint32_t>(RtCtrlMsgType::RT_CTRL_MSG_MODEL_LOAD_COMPLETE)] = &CtrlMsgModelTaskInit;
    ctrlMsgHandlerArr[static_cast<uint32_t>(RtCtrlMsgType::RT_CTRL_MSG_MODEL_ABORT)] = &CtrlMsgModelTaskInit;
    ctrlMsgHandlerArr[static_cast<uint32_t>(RtCtrlMsgType::RT_CTRL_MSG_DATADUMP_INFOLOAD)] = &CtrlMsgDumpLoadInfoInit;
    ctrlMsgHandlerArr[static_cast<uint32_t>(RtCtrlMsgType::RT_CTRL_MSG_AICPU_INFOLOAD)] = &CtrlMsgAicpuInfoLoadInit;
    ctrlMsgHandlerArr[static_cast<uint32_t>(RtCtrlMsgType::RT_CTRL_MSG_DEBUG_REGISTER)] = &CtrlMsgDebugRegisteInit;
    ctrlMsgHandlerArr[static_cast<uint32_t>(RtCtrlMsgType::RT_CTRL_MSG_DEBUG_UNREGISTER)] = &CtrlMsgDebugUnRegisteInit;
    ctrlMsgHandlerArr[static_cast<uint32_t>(RtCtrlMsgType::RT_CTRL_MSG_SET_OVERFLOW_SWITCH)] = &CtrlMsgOverflowSwitchSetInit;
    ctrlMsgHandlerArr[static_cast<uint32_t>(RtCtrlMsgType::RT_CTRL_MSG_AICPU_MODEL_DESTROY)] = &CtrlMsgAicpuModelInit;
}

rtError_t CtrlSQ::SendStreamClearMsg(const Stream * const stm, rtClearStep_t step, rtTaskGenCallback callback)
{
    const uint32_t streamId = static_cast<uint32_t>(stm->Id_());
    RtCtrlMsgParam param = {};
    param.taskType = TS_TASK_TYPE_COMMON_CMD;
    param.commonCmdParam = { CMD_STREAM_CLEAR, streamId, step, 0U};
    param.sendParam.callback = callback;
    rtError_t error = CreateCtrlMsg(RtCtrlMsgType::RT_CTRL_MSG_STREAM_CLEAR, param);
    ERROR_RETURN_MSG_INNER(error, "Ctrl msg send failed, retCode=%#x", static_cast<uint32_t>(error));

    error = WaitComplete();
    ERROR_RETURN_MSG_INNER(error, "Ctrl msg wait failed, retCode=%#x", static_cast<uint32_t>(error));
    return RT_ERROR_NONE;
}

rtError_t CtrlSQ::SendStreamRecycleMsg(const RtMaintainceParam &maintenanceParam, TaskInfo *&task)
{
    RtCtrlMsgParam param = {};
    param.taskType = TS_TASK_TYPE_MAINTENANCE;
    param.maintenanceParam = maintenanceParam;
    uint32_t taskId = 0U;
    const rtError_t error = CreateCtrlMsg(RtCtrlMsgType::RT_CTRL_MSG_STREAM_RECYCLE, param, &taskId);
    ERROR_RETURN_MSG_INNER(error, "Ctrl msg send failed, retCode=%#x", static_cast<uint32_t>(error));
    task = device_->GetTaskFactory()->GetTask(GetStream()->Id_(), taskId);
    return RT_ERROR_NONE;
}

rtError_t CtrlSQ::SendNotifyResetMsg(uint32_t notifyId)
{
    RtCtrlMsgParam param = {};
    param.taskType = TS_TASK_TYPE_COMMON_CMD;

    param.commonCmdParam.cmdType = CMD_NOTIFY_RESET;
    param.commonCmdParam.notifyId = notifyId;
    rtError_t error = CreateCtrlMsg(RtCtrlMsgType::RT_CTRL_MSG_NOTIFY_RESET, param);
    ERROR_RETURN_MSG_INNER(error, "Ctrl msg send failed, retCode=%#x", static_cast<uint32_t>(error));

    error = WaitComplete();
    ERROR_RETURN_MSG_INNER(error, "Ctrl msg wait failed, retCode=%#x", static_cast<uint32_t>(error));
    return RT_ERROR_NONE;
}

rtError_t CtrlSQ::SendModelUnbindMsg(Model * const mdl, Stream * const streamIn, const bool force)
{
    RtCtrlMsgParam param = {};
    param.taskType = TS_TASK_TYPE_MODEL_MAINTAINCE;
    param.modelMaintenanceParam = { MMT_STREAM_DEL, mdl, streamIn, RT_MODEL_HEAD_STREAM, 0U };
    rtError_t error = CreateCtrlMsg(RtCtrlMsgType::RT_CTRL_MSG_MODEL_UNBIND_STREAM, param);
    if ((!force) && (error != RT_ERROR_NONE)) {
        mdl->ModelPushFrontStream(streamIn);
        ERROR_RETURN_MSG_INNER(error, "Ctrl msg send failed, retCode=%#x", static_cast<uint32_t>(error));
        return error;
    }
    error = WaitComplete();
    if (error != RT_ERROR_NONE) {
        mdl->ModelPushFrontStream(streamIn);
        ERROR_RETURN_MSG_INNER(error, "Ctrl msg wait failed, retCode=%#x", static_cast<uint32_t>(error));
    }
    return RT_ERROR_NONE;
}

rtError_t CtrlSQ::SendModelBindMsg(Model * const mdl, Stream * const streamIn, const uint32_t flag)
{
    RtCtrlMsgParam param = {};
    param.taskType = TS_TASK_TYPE_MODEL_MAINTAINCE;
    const rtModelStreamType_t streamType =
        (flag == static_cast<uint32_t>(RT_HEAD_STREAM)) ? RT_MODEL_HEAD_STREAM : RT_MODEL_WAIT_ACTIVE_STREAM;

    param.modelMaintenanceParam = { MMT_STREAM_ADD, mdl, streamIn, streamType, 0U };
    rtError_t error = CreateCtrlMsg(RtCtrlMsgType::RT_CTRL_MSG_MODEL_BIND_STREAM, param);

    error = WaitComplete();
    ERROR_RETURN_MSG_INNER(error, "Ctrl msg wait failed, retCode=%#x", static_cast<uint32_t>(error));
    return RT_ERROR_NONE;
}

rtError_t CtrlSQ::SendModelAbortMsg(Model * const mdl)
{
    RtCtrlMsgParam param = {};
    param.taskType = TS_TASK_TYPE_MODEL_MAINTAINCE;
    param.modelMaintenanceParam = { MMT_MODEL_ABORT, mdl, GetStream(), RT_MODEL_HEAD_STREAM, 0U };
    
    rtError_t error = CreateCtrlMsg(RtCtrlMsgType::RT_CTRL_MSG_MODEL_ABORT, param);
    ERROR_RETURN_MSG_INNER(error, "Ctrl msg send failed, retCode=%#x", static_cast<uint32_t>(error));

    error = WaitComplete();
    ERROR_RETURN_MSG_INNER(error, "Ctrl msg wait failed, retCode=%#x", static_cast<uint32_t>(error));
    return RT_ERROR_NONE;
}

rtError_t CtrlSQ::SendModelLoadCompleteMsg(Model * const mdl, uint32_t firstTaskId)
{
    RtCtrlMsgParam param = {};
    GetStream()->SetLatestModlId(static_cast<int32_t>(mdl->Id_()));
    param.taskType = TS_TASK_TYPE_MODEL_MAINTAINCE;
    param.modelMaintenanceParam = { MMT_MODEL_PRE_PROC, mdl, GetStream(), RT_MODEL_HEAD_STREAM, firstTaskId };
    
    const rtError_t error = CreateCtrlMsg(RtCtrlMsgType::RT_CTRL_MSG_MODEL_LOAD_COMPLETE, param);
    ERROR_RETURN_MSG_INNER(error, "Ctrl msg send failed, retCode=%#x", static_cast<uint32_t>(error));
    return RT_ERROR_NONE;
}

rtError_t CtrlSQ::SendAicpuModelMsg(RtCtrlMsgType msgType, const RtAicpuModelParam &aicpuModelParam)
{
    RtCtrlMsgParam param = {};
    param.taskType = TS_TASK_TYPE_MODEL_TO_AICPU;
    param.aicpuModelParam = aicpuModelParam;
    
    rtError_t error = CreateCtrlMsg(msgType, param);
    ERROR_RETURN_MSG_INNER(error, "Ctrl msg send failed, retCode=%#x", static_cast<uint32_t>(error));

    error = WaitComplete();
    ERROR_RETURN_MSG_INNER(error, "Ctrl msg wait failed, retCode=%#x", static_cast<uint32_t>(error));

    return RT_ERROR_NONE;
}

rtError_t CtrlSQ::SendDataDumpLoadInfoMsg(
    RtCtrlMsgType msgType, const RtDataDumpLoadInfoParam &datadumpLoadInfoParam, rtTaskGenCallback callback)
{
    RtCtrlMsgParam param = {};
    param.taskType = TS_TASK_TYPE_DATADUMP_LOADINFO;
    param.datadumpLoadInfoParam = datadumpLoadInfoParam;
    param.sendParam.callback = callback;
    rtError_t error = CreateCtrlMsg(msgType, param);
    ERROR_RETURN_MSG_INNER(error, "Ctrl msg send failed, retCode=%#x", static_cast<uint32_t>(error));

    error = WaitComplete();
    ERROR_RETURN_MSG_INNER(error, "Ctrl msg wait failed, retCode=%#x", static_cast<uint32_t>(error));

    return RT_ERROR_NONE;
}

rtError_t CtrlSQ::SendAicpuInfoLoadMsg(
    RtCtrlMsgType msgType, const RtAicpuInfoLoadParam &aicpuInfoLoadParam, rtTaskGenCallback callback)
{
    RtCtrlMsgParam param = {};
    param.taskType = TS_TASK_TYPE_AICPU_INFO_LOAD;
    param.aicpuInfoLoadParam = aicpuInfoLoadParam;
    param.sendParam.callback = callback;
    rtError_t error = CreateCtrlMsg(msgType, param);
    ERROR_RETURN_MSG_INNER(error, "Ctrl msg send failed, retCode=%#x", static_cast<uint32_t>(error));

    error = WaitComplete();
    ERROR_RETURN_MSG_INNER(error, "Ctrl msg wait failed, retCode=%#x", static_cast<uint32_t>(error));

    return RT_ERROR_NONE;
}

rtError_t CtrlSQ::SendDebugRegisterMsg(RtCtrlMsgType msgType, const RtDebugRegisterParam &debugRegisterParam,
    rtTaskGenCallback callback, uint32_t *const flipTaskId)
{
    RtCtrlMsgParam param = {};
    param.taskType = TS_TASK_TYPE_DEBUG_REGISTER;
    param.debugRegisterParam = debugRegisterParam;
    param.sendParam.callback = callback;

    rtError_t error = CreateCtrlMsg(msgType, param, flipTaskId);
    ERROR_RETURN_MSG_INNER(error, "Ctrl msg send failed, retCode=%#x", static_cast<uint32_t>(error));

    error = WaitComplete();
    ERROR_RETURN_MSG_INNER(error, "Ctrl msg wait failed, retCode=%#x", static_cast<uint32_t>(error));

    return RT_ERROR_NONE;
}

rtError_t CtrlSQ::SendDebugUnRegisterMsg(
    RtCtrlMsgType msgType, const RtDebugUnRegisterParam &debugUnRegisterParam, rtTaskGenCallback callback)
{
    RtCtrlMsgParam param = {};
    param.taskType = TS_TASK_TYPE_DEBUG_UNREGISTER;
    param.debugUnRegisterParam = debugUnRegisterParam;
    param.sendParam.callback = callback;
    rtError_t error = CreateCtrlMsg(msgType, param);
    ERROR_RETURN_MSG_INNER(error, "Ctrl msg send failed, retCode=%#x", static_cast<uint32_t>(error));

    error = WaitComplete();
    ERROR_RETURN_MSG_INNER(error, "Ctrl msg wait failed, retCode=%#x", static_cast<uint32_t>(error));

    return RT_ERROR_NONE;
}

rtError_t CtrlSQ::SendOverflowSwitchSetMsg(RtCtrlMsgType msgType, const RtOverflowSwitchSetParam &overflowSwitchSetParam,
    rtTaskGenCallback callback, uint32_t *const flipTaskId)
{
    RtCtrlMsgParam param = {};
    param.taskType = TS_TASK_TYPE_SET_OVERFLOW_SWITCH;
    param.overflowSwitchSetParam = overflowSwitchSetParam;
    param.sendParam.callback = callback;
    const rtError_t error = CreateCtrlMsg(msgType, param, flipTaskId);
    ERROR_RETURN_MSG_INNER(error, "Ctrl msg send failed, retCode=%#x", static_cast<uint32_t>(error));
    return RT_ERROR_NONE;
}

}
}