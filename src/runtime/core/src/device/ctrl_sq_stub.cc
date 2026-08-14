/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "base.hpp"
#include "ctrl_sq.hpp"

namespace cce {
namespace runtime {

CtrlSQ::CtrlSQ(Device* const dev) : NoCopy(), device_(dev) {}

CtrlSQ::~CtrlSQ() noexcept {}

rtError_t CtrlSQ::Setup() { return RT_ERROR_FEATURE_NOT_SUPPORT; }

rtError_t CtrlSQ::SendStreamClearMsg(const Stream* const stm, rtClearStep_t step)
{
    UNUSED(stm);
    UNUSED(step);
    return RT_ERROR_FEATURE_NOT_SUPPORT;
}

rtError_t CtrlSQ::SendStreamRecycleMsg(const RtMaintainceParam& maintenanceParam, TaskInfo*& task)
{
    UNUSED(maintenanceParam);
    UNUSED(task);
    return RT_ERROR_FEATURE_NOT_SUPPORT;
}

rtError_t CtrlSQ::SendNotifyResetMsg(uint32_t notifyId)
{
    UNUSED(notifyId);
    return RT_ERROR_FEATURE_NOT_SUPPORT;
}

rtError_t CtrlSQ::SendModelUnbindMsg(Model* const mdl, Stream* const streamIn, const bool force)
{
    UNUSED(mdl);
    UNUSED(streamIn);
    UNUSED(force);
    return RT_ERROR_FEATURE_NOT_SUPPORT;
}

rtError_t CtrlSQ::SendModelUnbindMsgOnly(Model* const mdl, Stream* const streamIn)
{
    UNUSED(mdl);
    UNUSED(streamIn);
    return RT_ERROR_FEATURE_NOT_SUPPORT;
}

rtError_t CtrlSQ::SendModelBindMsg(Model* const mdl, Stream* const streamIn, const uint32_t flag)
{
    UNUSED(mdl);
    UNUSED(streamIn);
    UNUSED(flag);
    return RT_ERROR_FEATURE_NOT_SUPPORT;
}

rtError_t CtrlSQ::SendModelBindMsgOnly(Model* const mdl, Stream* const streamIn, const uint32_t flag)
{
    UNUSED(mdl);
    UNUSED(streamIn);
    UNUSED(flag);
    return RT_ERROR_FEATURE_NOT_SUPPORT;
}

rtError_t CtrlSQ::SendModelAbortMsg(Model* const mdl)
{
    UNUSED(mdl);
    return RT_ERROR_FEATURE_NOT_SUPPORT;
}

rtError_t CtrlSQ::SendModelLoadCompleteMsg(const Model* const mdl, uint32_t firstTaskId)
{
    UNUSED(mdl);
    UNUSED(firstTaskId);
    return RT_ERROR_FEATURE_NOT_SUPPORT;
}

rtError_t CtrlSQ::SendAicpuModelMsg(RtCtrlMsgType msgType, const RtAicpuModelParam& aicpuModelParam)
{
    UNUSED(msgType);
    UNUSED(aicpuModelParam);
    return RT_ERROR_FEATURE_NOT_SUPPORT;
}

rtError_t CtrlSQ::SendDataDumpLoadInfoMsg(RtCtrlMsgType msgType, const RtDataDumpLoadInfoParam& datadumpLoadInfoParam)
{
    UNUSED(msgType);
    UNUSED(datadumpLoadInfoParam);
    return RT_ERROR_FEATURE_NOT_SUPPORT;
}

rtError_t CtrlSQ::SendAicpuInfoLoadMsg(RtCtrlMsgType msgType, const RtAicpuInfoLoadParam& aicpuInfoLoadParam)
{
    UNUSED(msgType);
    UNUSED(aicpuInfoLoadParam);
    return RT_ERROR_FEATURE_NOT_SUPPORT;
}

rtError_t CtrlSQ::SendDebugRegisterMsg(
    RtCtrlMsgType msgType, const RtDebugRegisterParam& debugRegisterParam, uint32_t* const flipTaskId)
{
    UNUSED(msgType);
    UNUSED(debugRegisterParam);
    UNUSED(flipTaskId);
    return RT_ERROR_FEATURE_NOT_SUPPORT;
}

rtError_t CtrlSQ::SendDebugUnRegisterMsg(RtCtrlMsgType msgType, const RtDebugUnRegisterParam& debugUnRegisterParam)
{
    UNUSED(msgType);
    UNUSED(debugUnRegisterParam);
    return RT_ERROR_FEATURE_NOT_SUPPORT;
}

rtError_t CtrlSQ::SendOverflowSwitchSetMsg(
    RtCtrlMsgType msgType, const RtOverflowSwitchSetParam& overflowSwitchSetParam, uint32_t* const flipTaskId)
{
    UNUSED(msgType);
    UNUSED(overflowSwitchSetParam);
    UNUSED(flipTaskId);
    return RT_ERROR_FEATURE_NOT_SUPPORT;
}

rtError_t CtrlSQ::SendSetStreamTagMsg(
    RtCtrlMsgType msgType, const RtSetStreamTagParam& setStreamTagParam, uint32_t* const flipTaskId)
{
    UNUSED(msgType);
    UNUSED(setStreamTagParam);
    UNUSED(flipTaskId);
    return RT_ERROR_FEATURE_NOT_SUPPORT;
}

} // namespace runtime
} // namespace cce
