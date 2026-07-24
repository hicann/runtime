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
// This struct is the single migration anchor for moving HDC message assembly
// out of ProcessModeManager. Every field a message type may need is pre-embedded
// here so that:
//   1. ProcessModeManager fills the common, manager-derived fields exactly once
//      (see ProcessModeManager::BuildBaseMessageContext), avoiding the duplicated
//      "copy member -> message" code that exists per message type today.
//   2. A new BuildXxx in HdcMessageBuilder only reads the fields it cares about;
//      unused fields stay value-initialized and are ignored.
// Enum-typed values are stored as the raw integer already cast from the caller's
// enum so this header does not pull in tsdclient-internal enum definitions.
struct MessageContext {
    // ---- Device / process identity (common, manager-derived) ----
    uint32_t logicDeviceId = 0U;
    uint32_t rankSize = 0U;
    process_sign procSign = {};

    // ---- Profiling ----
    uint32_t profilingMode = 0U;

    // ---- Log levels ----
    std::string logLevel;
    std::string ccecpuLogLevel;
    std::string aicpuLogLevel;

    // ---- Package host check codes ----
    uint32_t aicpuKernelCheckCode = 0U;
    uint32_t aicpuExtendKernelCheckCode = 0U;
    uint32_t ascendcppCheckCode = 0U;

    // ---- AICPU / scheduler ----
    uint32_t aicpuDeviceMode = 0U;
    SchedMode aicpuSchedMode = {};

    // ---- Queue schedule (QS) ----
    std::string qsInitGroupName;
    uint64_t schedPolicy = 0UL;

    // ---- Start flags ----
    bool startHccp = false;
    bool startCp = false;
    bool startQs = false;

    // ---- Paths / misc flags ----
    std::string ascendInstallPath;
    bool waitFlag = false;
    bool asan = false;

    // ---- Generic package operation (per-call) ----
    uint32_t msgType = 0U; // raw HDCMessage::MsgType for generic builders
    uint32_t checkCode = 0U;
    uint32_t packageType = 0U;
    uint32_t packageWorkerType = 0U;
    uint32_t packageMaxProcessTime = 0U;
    bool beforeSendPkg = false;
    std::string packageName;
    std::string hashCode;

    // ---- Check-package query (per-call, TSD_CHECK_PACKAGE) ----
    uint32_t extendpkgCheckCode = 0U;

    // ---- Normal check-code with plugin version (per-call, TSD_GET_DEVICE_PACKAGE_CHECKCODE_NORMAL) ----
    // Optional: when version is non-empty, a host_plugin_versions entry is appended.
    struct {
        std::string version;
        std::string timestamp;
        bool Empty() const { return version.empty() && timestamp.empty(); }
    } hostPluginVersion;

    // ---- Capability query (per-call) ----
    // Raw TsdCapabilityType (cast from the caller's enum) used to derive the
    // HDCMessage::MsgType for capability-query messages.
    int32_t capabilityType = 0;

    // ---- File operations (per-call) ----
    std::string omfileName;
    std::string removeFilePath;

    // ---- Sub-process control (per-call) ----
    uint32_t closeSubProcPid = 0U;

    // ---- Sub-process status / close lists (per-call) ----
    // Parallel arrays describing the sub-process entries carried by
    // TSD_GET_SUB_PROC_STATUS / TSD_CLOSE_SUB_PROC_LIST. subProcTypeList may be
    // empty (e.g. GetSubProcStatus carries only pids).
    std::vector<uint32_t> subProcPidList;
    std::vector<uint32_t> subProcTypeList;

    // ---- Common open sub-process (per-call, TSD_OPEN_SUB_PROC) ----
    uint32_t subProcOpenType = 0U; // helper_sub_proc.process_type
    bool hasSubProcFilePath = false;
    std::string subProcFilePath;
    bool withSubProcLogLevel = false;                                // include log_level (HCCP case)
    std::vector<std::pair<std::string, std::string>> subProcEnvList; // (env_name, env_value)
    std::vector<std::string> subProcExtParamList;
};

// Pure HDC message assembler.
// Responsibility scope: given an immutable MessageContext + per-call inputs,
// populate the HDCMessage proto. Methods are static, side-effect free w.r.t.
// any owning object (only logging and env-lookup happen internally).
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

    // Build TSD_CHECK_PACKAGE_RETRY.
    // Reads ctx.checkCode / packageType / logicDeviceId / procSign / waitFlag.
    static TSD_StatusT BuildCheckPackageRetry(HDCMessage& msg, const MessageContext& ctx);

    // Build TSD_CHECK_PACKAGE.
    // Reads ctx.checkCode / extendpkgCheckCode / ascendcppCheckCode / asan /
    // logicDeviceId / procSign.
    static TSD_StatusT BuildCheckPackage(HDCMessage& msg, const MessageContext& ctx);

    // Build TSD_UPDATE_PACKAGE_PROCESS_CONFIG.
    // Reads ctx.logicDeviceId / procSign. The caller is responsible for
    // filling package config fields via PackageProcessConfig::ConstructPkgConfigMsg
    // after this builder sets the header.
    static TSD_StatusT BuildUpdatePackageConfig(HDCMessage& msg, const MessageContext& ctx);

    // Build TSD_GET_DEVICE_PACKAGE_CHECKCODE_NORMAL.
    // Reads ctx.packageName / hashCode / packageWorkerType / packageMaxProcessTime /
    // packageType / logicDeviceId. Optionally appends a host_plugin_versions entry
    // when ctx.hostPluginVersion is non-empty.
    static TSD_StatusT BuildNormalCheckCode(HDCMessage& msg, const MessageContext& ctx);
};
} // namespace tsd
#endif // TSD_BASIC_COMPONENT_MESSAGE_BUILDER_HDC_MESSAGE_BUILDER_H
