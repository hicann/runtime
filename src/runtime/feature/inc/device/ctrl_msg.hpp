/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef CCE_RUNTIME_CTRL_MSG_HPP
#define CCE_RUNTIME_CTRL_MSG_HPP
#include "stream.hpp"
 
namespace cce {
namespace runtime {
enum class RtCtrlMsgType : std::uint32_t {
    RT_CTRL_MSG_STREAM_CLEAR,
    RT_CTRL_MSG_STREAM_RECYCLE,
    RT_CTRL_MSG_NOTIFY_RESET,
    RT_CTRL_MSG_MODEL_BIND_STREAM,
    RT_CTRL_MSG_MODEL_UNBIND_STREAM,
    RT_CTRL_MSG_MODEL_LOAD_COMPLETE,
    RT_CTRL_MSG_MODEL_ABORT,
    RT_CTRL_MSG_DATADUMP_INFOLOAD,
    RT_CTRL_MSG_AICPU_INFOLOAD,
    RT_CTRL_MSG_DEBUG_REGISTER,
    RT_CTRL_MSG_DEBUG_UNREGISTER,
    RT_CTRL_MSG_SET_OVERFLOW_SWITCH,
    RT_CTRL_MSG_AICPU_MODEL_DESTROY,
    RT_CTRL_MSG_MAX,
};

struct RtCommonCmdParam {
    PhCmdType cmdType;
    uint32_t streamId;
    rtClearStep_t step;
    uint32_t notifyId;
};

struct RtMaintainceParam {
    int32_t streamId;
    bool isForceRecycle;
    uint16_t logicCqId;
};

struct RtModelMaintainceParam {
    MmtType mType;
    Model *modelPtr;
    Stream *opStreamPtr; 
    rtModelStreamType_t modelStreamType;
    uint32_t firstTaskIndex;
};

struct RtAicpuModelParam {
    uint32_t modelIndex;
    uint32_t controlType;
    uint32_t exeFlag;
    uint64_t modelPtr;
};

struct RtDataDumpLoadInfoParam {
    const void *dumpInfo;
    uint32_t length;
    uint16_t kernelType;
};

struct RtAicpuInfoLoadParam {
    const void *aicpuInfo;
    uint32_t length;
};

struct RtDebugRegisterParam {
    const void *addr;
    uint32_t modelId;
    uint32_t flag;
};

struct RtDebugUnRegisterParam {
    uint32_t modelId;
};

struct RtOverflowSwitchSetParam {
    Stream *targetStm;
    uint32_t switchFlag;
};

struct RtCtrlMsgSendParam {
    rtTaskGenCallback callback = nullptr;
    int32_t timeout = -1;
};

struct RtCtrlMsgParam {
    tsTaskType_t taskType;
    RtCtrlMsgSendParam sendParam;
    union {
        RtCommonCmdParam commonCmdParam;
        RtMaintainceParam maintenanceParam;
        RtModelMaintainceParam modelMaintenanceParam;
        RtAicpuModelParam aicpuModelParam;
        RtDataDumpLoadInfoParam datadumpLoadInfoParam;
        RtAicpuInfoLoadParam aicpuInfoLoadParam;
        RtDebugRegisterParam debugRegisterParam;
        RtDebugUnRegisterParam debugUnRegisterParam;
        RtOverflowSwitchSetParam overflowSwitchSetParam;
    };
};

struct RtCtrlMsg {
    RtCtrlMsgType msgType;
    RtCtrlMsgParam msgParam;
    TaskInfo* taskInfo;
    uint8_t version;
};

rtError_t CtrlMsgStreamClearInit(TaskInfo *taskInfo, const RtCtrlMsgParam &param);

rtError_t CtrlMsgStreamRecycleInit(TaskInfo *taskInfo, const RtCtrlMsgParam &param);

rtError_t CtrlMsgNotifyResetInit(TaskInfo *taskInfo, const RtCtrlMsgParam &param);

rtError_t CtrlMsgModelTaskInit(TaskInfo *taskInfo, const RtCtrlMsgParam &param);

rtError_t CtrlMsgAicpuModelInit(TaskInfo *taskInfo, const RtCtrlMsgParam &param);

rtError_t CtrlMsgDumpLoadInfoInit(TaskInfo *taskInfo, const RtCtrlMsgParam &param);

rtError_t CtrlMsgAicpuInfoLoadInit(TaskInfo *taskInfo, const RtCtrlMsgParam &param);

rtError_t CtrlMsgDebugRegisteInit(TaskInfo *taskInfo, const RtCtrlMsgParam &param);

rtError_t CtrlMsgDebugUnRegisteInit(TaskInfo *taskInfo, const RtCtrlMsgParam &param);

rtError_t CtrlMsgOverflowSwitchSetInit(TaskInfo *taskInfo, const RtCtrlMsgParam &param);

}  // namespace runtime
}  // namespace cce
#endif
