/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef CCE_RUNTIME_CTRL_SQ_HPP
#define CCE_RUNTIME_CTRL_SQ_HPP
#include <functional>
#include "stream.hpp"
#include "ctrl_msg.hpp"

namespace cce {
namespace runtime {

class CtrlSQ : public NoCopy {
public:
    explicit CtrlSQ(Device * const dev);
    ~CtrlSQ() noexcept override;

    rtError_t Setup();

    /**
        create ctrl task, alloc task and init task
        in: msgType
        in: param
        out: msgId
     */
    rtError_t CreateCtrlMsg(RtCtrlMsgType msgType, const RtCtrlMsgParam &param, uint32_t * const msgId = nullptr);

    /**
        wait ctrl msg complete
     */
    rtError_t WaitComplete(const bool isNeedWaitSyncCq = false, int32_t timeout = -1);

    rtError_t SendStreamClearMsg(const Stream * const stm, rtClearStep_t step, rtTaskGenCallback callback);

    rtError_t SendStreamRecycleMsg(const RtMaintainceParam &maintenanceParam, TaskInfo *&task);

    rtError_t SendNotifyResetMsg(uint32_t notifyId);

    rtError_t SendModelUnbindMsg(Model * const mdl, Stream * const streamIn, const bool force);

    rtError_t SendModelBindMsg(Model * const mdl, Stream * const streamIn, const uint32_t flag);

    rtError_t SendModelAbortMsg(Model * const mdl);

    rtError_t SendModelLoadCompleteMsg(Model * const mdl, uint32_t firstTaskId);

    rtError_t SendAicpuModelMsg(RtCtrlMsgType msgType, const RtAicpuModelParam &aicpuModelParam);

    rtError_t SendDataDumpLoadInfoMsg(
    RtCtrlMsgType msgType, const RtDataDumpLoadInfoParam &datadumpLoadInfoParam, rtTaskGenCallback callback);

    rtError_t SendAicpuInfoLoadMsg(
        RtCtrlMsgType msgType, const RtAicpuInfoLoadParam &aicpuInfoLoadParam, rtTaskGenCallback callback);

    rtError_t SendDebugRegisterMsg(RtCtrlMsgType msgType, const RtDebugRegisterParam &debugRegisterParam,
        rtTaskGenCallback callback, uint32_t *const flipTaskId);

    rtError_t SendDebugUnRegisterMsg(
        RtCtrlMsgType msgType, const RtDebugUnRegisterParam &debugUnRegisterParam, rtTaskGenCallback callback);

    rtError_t SendOverflowSwitchSetMsg(RtCtrlMsgType msgType, const RtOverflowSwitchSetParam &overflowSwitchSetParam,
        rtTaskGenCallback callback, uint32_t *const flipTaskId);

    Stream *GetStream() const
    {
        return stream_;
    }
private:
    void RegCtrlMsgInitFunc(void) const;
    Device* device_;
    Stream* stream_; // 内部下任务对应的stream
};
}  // namespace runtime
}  // namespace cce
#endif
