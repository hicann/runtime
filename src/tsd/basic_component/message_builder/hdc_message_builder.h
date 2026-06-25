/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef TSD_BASIC_COMPONENT_MESSAGE_BUILDER_HDC_MESSAGE_BUILDER_H
#define TSD_BASIC_COMPONENT_MESSAGE_BUILDER_HDC_MESSAGE_BUILDER_H

#include <cstdint>
#include <string>

#include "driver/ascend_hal_base.h"   // process_sign
#include "proto/tsd_message.pb.h"
#include "tsd/status.h"
#include "tsd/tsd_client.h"           // SchedMode

namespace tsd {
// Pure value-type snapshot of the inputs required to assemble an HDC message.
// Constructed at the call site (e.g. inside ProcessModeManager::Construct*Msg)
// and consumed in the same call frame; no references, no lifetime coupling.
//
// This struct is the single migration anchor for moving HDC message assembly
// out of ProcessModeManager. Every field a message type may need is pre-embedded
// here so that:
//   1. ProcessModeManager fills the common, manager-derived fields exactly once
//      (see ProcessModeManager::BuildBaseMessageContext), avoiding the duplicated
//      "copy member -> message" code that exists per message type today.
//   2. A new BuildXxx in HdcMessageBuilder only reads the fields it cares about;
//      unused fields stay value-initialized and are ignored.
//
// Enum-typed values are stored as the raw integer already cast from the caller's
// enum so this header does not pull in tsdclient-internal enum definitions.
struct MessageContext {
    // ---- Device / process identity (common, manager-derived) ----
    uint32_t logicDeviceId;
    uint32_t rankSize;
    process_sign procSign;

    // ---- Profiling ----
    uint32_t profilingMode;

    // ---- Log levels ----
    std::string logLevel;
    std::string ccecpuLogLevel;
    std::string aicpuLogLevel;

    // ---- Package host check codes ----
    uint32_t aicpuKernelCheckCode;
    uint32_t aicpuExtendKernelCheckCode;
    uint32_t ascendcppCheckCode;

    // ---- AICPU / scheduler ----
    uint32_t aicpuDeviceMode;
    SchedMode aicpuSchedMode;

    // ---- Queue schedule (QS) ----
    std::string qsInitGroupName;
    uint64_t schedPolicy;

    // ---- Start flags ----
    bool startHccp;
    bool startCp;
    bool startQs;

    // ---- Paths / misc flags ----
    std::string ascendInstallPath;
    bool waitFlag;
    bool asan;

    // ---- Generic package operation (per-call) ----
    uint32_t msgType;                // raw HDCMessage::MsgType for generic builders
    uint32_t checkCode;
    uint32_t packageType;
    uint32_t packageWorkerType;
    uint32_t packageMaxProcessTime;
    bool beforeSendPkg;
    std::string packageName;
    std::string hashCode;

    // ---- File operations (per-call) ----
    std::string omfileName;
    std::string removeFilePath;

    // ---- Sub-process control (per-call) ----
    uint32_t closeSubProcPid;
};

// Pure HDC message assembler.
//
// Responsibility scope: given an immutable MessageContext + per-call inputs,
// populate the HDCMessage proto. Methods are static, side-effect free w.r.t.
// any owning object (only logging and env-lookup happen internally).
//
// Sending the message (devCommClient_->Send, WaitRsp, ...) is NOT part of
// this class and remains in ProcessModeManager.
class HdcMessageBuilder {
public:
    HdcMessageBuilder() = delete;
    ~HdcMessageBuilder() = delete;
    HdcMessageBuilder(const HdcMessageBuilder &) = delete;
    HdcMessageBuilder(HdcMessageBuilder &&) = delete;
    HdcMessageBuilder &operator=(const HdcMessageBuilder &) = delete;
    HdcMessageBuilder &operator=(HdcMessageBuilder &&) = delete;

    // Build TSD_START_PROC_MSG.
    // Byte-equivalent to the legacy ProcessModeManager::ConstructOpenMsg.
    static TSD_StatusT BuildOpen(HDCMessage &msg, const MessageContext &ctx);

    // Build TSD_CLOSE_PROC_MSG.
    // Byte-equivalent to the legacy ProcessModeManager::ConstructCloseMsg.
    static TSD_StatusT BuildClose(HDCMessage &msg, const MessageContext &ctx);
};
}  // namespace tsd
#endif  // TSD_BASIC_COMPONENT_MESSAGE_BUILDER_HDC_MESSAGE_BUILDER_H
