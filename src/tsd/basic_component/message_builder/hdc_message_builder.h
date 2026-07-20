/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
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
#include <utility>
#include <vector>

#include "driver/ascend_hal_base.h" // process_sign
#include "proto/tsd_message.pb.h"
#include "tsd/status.h"
#include "tsd/tsd_client.h" // SchedMode

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
    uint32_t msgType; // raw HDCMessage::MsgType for generic builders
    uint32_t checkCode;
    uint32_t packageType;
    uint32_t packageWorkerType;
    uint32_t packageMaxProcessTime;
    bool beforeSendPkg;
    std::string packageName;
    std::string hashCode;

    // ---- Capability query (per-call) ----
    // Raw TsdCapabilityType (cast from the caller's enum) used to derive the
    // HDCMessage::MsgType for capability-query messages.
    int32_t capabilityType = 0;

    // ---- File operations (per-call) ----
    std::string omfileName;
    std::string removeFilePath;

    // ---- Sub-process control (per-call) ----
    uint32_t closeSubProcPid;

    // ---- Sub-process status / close lists (per-call) ----
    // Parallel arrays describing the sub-process entries carried by
    // TSD_GET_SUB_PROC_STATUS / TSD_CLOSE_SUB_PROC_LIST. subProcTypeList may be
    // empty (e.g. GetSubProcStatus carries only pids).
    std::vector<uint32_t> subProcPidList;
    std::vector<uint32_t> subProcTypeList;

    // ---- Common open sub-process (per-call, TSD_OPEN_SUB_PROC) ----
    uint32_t subProcOpenType; // helper_sub_proc.process_type
    bool hasSubProcFilePath;
    std::string subProcFilePath;
    bool withSubProcLogLevel;                                        // include log_level (HCCP case)
    std::vector<std::pair<std::string, std::string>> subProcEnvList; // (env_name, env_value)
    std::vector<std::string> subProcExtParamList;
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
    HdcMessageBuilder(const HdcMessageBuilder&) = delete;
    HdcMessageBuilder(HdcMessageBuilder&&) = delete;
    HdcMessageBuilder& operator=(const HdcMessageBuilder&) = delete;
    HdcMessageBuilder& operator=(HdcMessageBuilder&&) = delete;

    // Build TSD_START_PROC_MSG.
    // Byte-equivalent to the legacy ProcessModeManager::ConstructOpenMsg.
    static TSD_StatusT BuildOpen(HDCMessage& msg, const MessageContext& ctx);

    // Build TSD_CLOSE_PROC_MSG.
    // Byte-equivalent to the legacy ProcessModeManager::ConstructCloseMsg.
    static TSD_StatusT BuildClose(HDCMessage& msg, const MessageContext& ctx);

    // Build TSD_UPDATE_PROIFILING_MSG.
    // Reads ctx.profilingMode / rankSize / logicDeviceId / procSign.
    static TSD_StatusT BuildUpdateProfiling(HDCMessage& msg, const MessageContext& ctx);

    // Build TSD_OM_PKG_DECOMPRESS_STATUS.
    // Reads ctx.omfileName / logicDeviceId / procSign.
    static TSD_StatusT BuildOmFileDecompress(HDCMessage& msg, const MessageContext& ctx);

    // Build a generic package check-code message. The concrete proto type is
    // carried by ctx.msgType (raw HDCMessage::MsgType), and the body uses
    // ctx.checkCode / beforeSendPkg / logicDeviceId / procSign.
    static TSD_StatusT BuildPackageCheckCode(HDCMessage& msg, const MessageContext& ctx);

    // Build a capability-query message.
    // Reads ctx.capabilityType (raw TsdCapabilityType) to derive the proto
    // message type, plus ctx.logicDeviceId / ctx.procSign.
    static TSD_StatusT BuildCapability(HDCMessage& msg, const MessageContext& ctx);

    // Build TSD_CLOSE_SUB_PROC.
    // Reads ctx.closeSubProcPid / logicDeviceId / procSign.
    static TSD_StatusT BuildCloseSubProc(HDCMessage& msg, const MessageContext& ctx);

    // Build TSD_REMOVE_FILE.
    // Reads ctx.removeFilePath / logicDeviceId / procSign.
    static TSD_StatusT BuildRemoveFile(HDCMessage& msg, const MessageContext& ctx);

    // Build TSD_GET_DEVICE_CANN_HS_CHECKCODE.
    // Reads ctx.packageMaxProcessTime / packageWorkerType / packageType /
    // packageName / hashCode / logicDeviceId.
    static TSD_StatusT BuildCannHsCheckCode(HDCMessage& msg, const MessageContext& ctx);

    // Build TSD_GET_SUB_PROC_STATUS.
    // Reads ctx.subProcPidList (+ optional ctx.subProcTypeList) / logicDeviceId /
    // procSign. Handles both GetSubProcStatus (pids only) and GetSubProcListStatus
    // (pids + types).
    static TSD_StatusT BuildGetSubProcStatus(HDCMessage& msg, const MessageContext& ctx);

    // Build TSD_CLOSE_SUB_PROC_LIST.
    // Reads ctx.subProcPidList / subProcTypeList / logicDeviceId / procSign.
    static TSD_StatusT BuildCloseSubProcList(HDCMessage& msg, const MessageContext& ctx);

    // Build TSD_OPEN_SUB_PROC (common open).
    // Reads ctx.subProcOpenType / subProcFilePath / subProcEnvList /
    // subProcExtParamList / ascendInstallPath / withSubProcLogLevel / logLevel /
    // logicDeviceId / procSign.
    static TSD_StatusT BuildCommonOpen(HDCMessage& msg, const MessageContext& ctx);
};
} // namespace tsd
#endif // TSD_BASIC_COMPONENT_MESSAGE_BUILDER_HDC_MESSAGE_BUILDER_H
