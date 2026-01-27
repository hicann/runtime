/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "ctrl_msg.hpp"
#include "ctrl_sq.hpp"
#include "task_info.hpp"
#include "model.hpp"
#include "stream.hpp"
#include "raw_device.hpp"
#include "error_message_manage.hpp"
#include "task.hpp"
#include "context.hpp"

namespace cce {
namespace runtime {

rtError_t CtrlMsgStreamClearInit(TaskInfo * taskInfo, const RtCtrlMsgParam &param)
{
    RtCommonCmdParam taskParam = param.commonCmdParam;
    CommonCmdTaskInfo cmdInfo;
    cmdInfo.streamId = static_cast<uint16_t>(taskParam.streamId);
    cmdInfo.step = taskParam.step;
    CommonCmdTaskInit(taskInfo, taskParam.cmdType, &cmdInfo);
    return RT_ERROR_NONE;
}

rtError_t CtrlMsgStreamRecycleInit(TaskInfo * taskInfo, const RtCtrlMsgParam &param)
{
    RtMaintainceParam taskParam = param.maintenanceParam;
    (void)MaintenanceTaskInit(
        taskInfo,
        MT_STREAM_RECYCLE_TASK, 
        static_cast<uint32_t>(taskParam.streamId), 
        taskParam.isForceRecycle);
    taskInfo->u.maintenanceTaskInfo.waitCqId = static_cast<uint16_t>(taskParam.logicCqId);
    return RT_ERROR_NONE;
}

rtError_t CtrlMsgNotifyResetInit(TaskInfo * taskInfo, const RtCtrlMsgParam &param)
{
    RtCommonCmdParam taskParam = param.commonCmdParam;
    CommonCmdTaskInfo cmdInfo;
    cmdInfo.notifyId = taskParam.notifyId;
    CommonCmdTaskInit(taskInfo, taskParam.cmdType, &cmdInfo);
    return RT_ERROR_NONE;
}

rtError_t CtrlMsgModelTaskInit(TaskInfo * taskInfo, const RtCtrlMsgParam &param)
{
    RtModelMaintainceParam taskParam = param.modelMaintenanceParam;
    (void)ModelMaintainceTaskInit(taskInfo, taskParam.mType, taskParam.modelPtr, taskParam.opStreamPtr,
        taskParam.modelStreamType, taskParam.firstTaskIndex);
    return RT_ERROR_NONE;
}

rtError_t CtrlMsgAicpuModelInit(TaskInfo *taskInfo, const RtCtrlMsgParam &param)
{
    RtAicpuModelParam taskParam = param.aicpuModelParam;
    (void)ModelToAicpuTaskInit(taskInfo, taskParam.modelIndex, taskParam.controlType,
        taskParam.exeFlag, taskParam.modelPtr);
    return RT_ERROR_NONE;
}

rtError_t CtrlMsgDumpLoadInfoInit(TaskInfo *taskInfo, const RtCtrlMsgParam &param)
{
    RtDataDumpLoadInfoParam taskParam = param.datadumpLoadInfoParam;
    return DataDumpLoadInfoTaskInit(taskInfo, taskParam.dumpInfo, taskParam.length, taskParam.kernelType);
}

rtError_t CtrlMsgAicpuInfoLoadInit(TaskInfo *taskInfo, const RtCtrlMsgParam &param)
{
    RtAicpuInfoLoadParam taskParam = param.aicpuInfoLoadParam;
    return AicpuInfoLoadTaskInit(taskInfo, taskParam.aicpuInfo, taskParam.length);
}

rtError_t CtrlMsgDebugRegisteInit(TaskInfo *taskInfo, const RtCtrlMsgParam &param)
{
    RtDebugRegisterParam taskParam = param.debugRegisterParam;
    return DebugRegisterTaskInit(taskInfo, taskParam.modelId, taskParam.addr, taskParam.flag);
}

rtError_t CtrlMsgDebugUnRegisteInit(TaskInfo *taskInfo, const RtCtrlMsgParam &param)
{
    RtDebugUnRegisterParam taskParam = param.debugUnRegisterParam;
    return DebugUnRegisterTaskInit(taskInfo, taskParam.modelId);
}

rtError_t CtrlMsgOverflowSwitchSetInit(TaskInfo *taskInfo, const RtCtrlMsgParam &param)
{
    RtOverflowSwitchSetParam taskParam = param.overflowSwitchSetParam;
    return OverflowSwitchSetTaskInit(taskInfo, taskParam.targetStm, taskParam.switchFlag);
}
}
}