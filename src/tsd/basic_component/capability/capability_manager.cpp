/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "capability_manager.h"
#include "error_manager.h"
#include "tsd_log.h"
#include "tsd/status.h"
#include "tsd_util_func.h"
#include "tsd/tsd_client.h"

namespace tsd {
namespace {
constexpr uint32_t COMMON_SUPPORT_TIMEOUT = 10000U;
constexpr uint32_t SUPPORT_OM_INNER_DEC_MSG_TIMEOUT = 10000U;
constexpr uint64_t TSD_SUPPORT_OM_INNER_DEC = 1UL;
constexpr uint64_t TSD_NOT_SUPPORT_OM_INNER_DEC = 0UL;

// ===========================================================================
// Strategy functions — one set per capability type.
// Each group of free functions below encapsulates the per-type "business"
// that was previously scattered across multiple switch-case blocks.  They are
// wired into the kCapabilitySpecs table as function pointers, so the member
// functions of CapabilityManager contain **zero** switch statements.
// Adding a new capability type that reuses an existing strategy only requires
// appending one row to kCapabilitySpecs.  Only a brand-new result-write or
// state-update strategy requires writing a new strategy function — no existing
// function body changes.
// ===========================================================================

// ---- PID_QOS ----
bool PidQosTryUseStored(CapabilityManager& mgr, uint64_t ptr)
{
    (void)mgr;
    (void)ptr;
    return false;
}

TSD_StatusT PidQosSaveResult(const CapabilityManager& mgr, uint64_t ptr)
{
    uint64_t* const resultPtr = reinterpret_cast<uint64_t*>(static_cast<uintptr_t>(ptr));
    if (resultPtr == nullptr) {
        TSD_ERROR("input ptr is null");
        return TSD_CLT_OPEN_FAILED;
    }
    const int64_t pidQos = mgr.GetPidQos();
    if (pidQos != -1) {
        *resultPtr = static_cast<uint64_t>(pidQos);
    }
    return TSD_OK;
}

void PidQosWriteUnsupported(uint64_t ptr) { *reinterpret_cast<uint64_t*>(static_cast<uintptr_t>(ptr)) = 0UL; }

void PidQosUpdateState(CapabilityManager& mgr, const HDCMessage& msg) { mgr.SetPidQos(msg.pid_of_qos()); }

// ---- SUPPORT_LEVEL ----
bool LevelTryUseStored(CapabilityManager& mgr, uint64_t ptr)
{
    const uint32_t level = mgr.GetTsdSupportLevel();
    if (TSD_BITMAP_GET(level, TSD_SUPPORT_HS_AISERVER_FEATURE_BIT) != 0U) {
        uint32_t* const resultPtr = PtrToPtr<void, uint32_t>(ValueToPtr(static_cast<uintptr_t>(ptr)));
        *resultPtr = level;
        return true;
    }
    return false;
}

TSD_StatusT LevelSaveResult(const CapabilityManager& mgr, uint64_t ptr)
{
    uint32_t* const resultPtr = PtrToPtr<void, uint32_t>(ValueToPtr(static_cast<uintptr_t>(ptr)));
    if (resultPtr == nullptr) {
        TSD_ERROR("input ptr is null");
        return TSD_CLT_OPEN_FAILED;
    }
    *resultPtr = static_cast<uint32_t>(mgr.GetTsdSupportLevel());
    return TSD_OK;
}

void LevelWriteUnsupported(uint64_t ptr) { *reinterpret_cast<uint32_t*>(static_cast<uintptr_t>(ptr)) = 0U; }

void LevelUpdateState(CapabilityManager& mgr, const HDCMessage& msg)
{
    const uint32_t level = msg.capability_level();
    if ((msg.tsd_rsp_code() == 0U) && (level != 0U)) {
        mgr.SetTsdSupportLevel(level);
    }
}

// ---- OM_INNER_DEC ----
bool OmInnerDecTryUseStored(CapabilityManager& mgr, uint64_t ptr)
{
    if (mgr.IsSupportOmInnerDec()) {
        uint64_t* const resultPtr = reinterpret_cast<uint64_t*>(static_cast<uintptr_t>(ptr));
        *resultPtr = TSD_SUPPORT_OM_INNER_DEC;
        return true;
    }
    return false;
}

TSD_StatusT OmInnerDecSaveResult(const CapabilityManager& mgr, uint64_t ptr)
{
    uint64_t* const resultPtr = reinterpret_cast<uint64_t*>(static_cast<uintptr_t>(ptr));
    *resultPtr = mgr.IsSupportOmInnerDec() ? TSD_SUPPORT_OM_INNER_DEC : TSD_NOT_SUPPORT_OM_INNER_DEC;
    return TSD_OK;
}

void OmInnerDecWriteUnsupported(uint64_t ptr) { *reinterpret_cast<uint64_t*>(static_cast<uintptr_t>(ptr)) = 0UL; }

void OmInnerDecUpdateState(CapabilityManager& mgr, const HDCMessage& msg)
{
    mgr.SetSupportOmInnerDec(msg.tsd_rsp_code() == 0U);
}

// ---- BUILTIN_UDF ----
bool BuiltinUdfTryUseStored(CapabilityManager& mgr, uint64_t ptr)
{
    if (TSD_BITMAP_GET(mgr.GetTsdSupportLevel(), TSD_SUPPORT_BUILTIN_UDF_BIT)) {
        bool* const resultPtr = reinterpret_cast<bool*>(static_cast<uintptr_t>(ptr));
        *resultPtr = true;
        return true;
    }
    return false;
}

TSD_StatusT BuiltinUdfSaveResult(const CapabilityManager& mgr, uint64_t ptr)
{
    bool* const resultPtr = reinterpret_cast<bool*>(static_cast<uintptr_t>(ptr));
    *resultPtr = TSD_BITMAP_GET(mgr.GetTsdSupportLevel(), TSD_SUPPORT_BUILTIN_UDF_BIT) ? true : false;
    return TSD_OK;
}

void BuiltinUdfWriteUnsupported(uint64_t ptr) { *reinterpret_cast<bool*>(static_cast<uintptr_t>(ptr)) = false; }

// ---- DRIVER_VERSION ----
bool DriverVersionTryUseStored(CapabilityManager& mgr, uint64_t ptr)
{
    (void)mgr;
    uint64_t* const resultPtr = PtrToPtr<void, uint64_t>(ValueToPtr(static_cast<uintptr_t>(ptr)));
    *resultPtr = 0UL;
    return true;
}

TSD_StatusT DriverVersionSaveResult(const CapabilityManager& mgr, uint64_t ptr)
{
    (void)mgr;
    (void)ptr;
    // DRIVER_VERSION is always served by tryUseStored; reaching saveResult
    // indicates a logic error.
    return TSD_CLT_OPEN_FAILED;
}

void DriverVersionWriteUnsupported(uint64_t ptr) { *reinterpret_cast<uint64_t*>(static_cast<uintptr_t>(ptr)) = 0UL; }

// ---- ADPROF ----
bool AdprofTryUseStored(CapabilityManager& mgr, uint64_t ptr)
{
    if (mgr.IsAdprofSupport()) {
        bool* const resultPtr = reinterpret_cast<bool*>(static_cast<uintptr_t>(ptr));
        *resultPtr = true;
        return true;
    }
    return false;
}

TSD_StatusT AdprofSaveResult(const CapabilityManager& mgr, uint64_t ptr)
{
    bool* const resultPtr = reinterpret_cast<bool*>(static_cast<uintptr_t>(ptr));
    if (resultPtr == nullptr) {
        TSD_ERROR("input ptr is null");
        return TSD_CLT_OPEN_FAILED;
    }
    *resultPtr = mgr.IsAdprofSupport();
    return TSD_OK;
}

void AdprofWriteUnsupported(uint64_t ptr) { *reinterpret_cast<bool*>(static_cast<uintptr_t>(ptr)) = false; }

void AdprofUpdateState(CapabilityManager& mgr, const HDCMessage& msg) { mgr.SetAdprofSupport(msg.support_adprof()); }

// ---- MULTIPLE_HCCP ----
bool MultipleHccpTryUseStored(CapabilityManager& mgr, uint64_t ptr)
{
    if (TSD_BITMAP_GET(mgr.GetTsdSupportLevel(), TSD_SUPPORT_MUL_HCCP) != 0U) {
        bool* const resultPtr = reinterpret_cast<bool*>(static_cast<uintptr_t>(ptr));
        *resultPtr = true;
        return true;
    }
    return false;
}

TSD_StatusT MultipleHccpSaveResult(const CapabilityManager& mgr, uint64_t ptr)
{
    bool* const resultPtr = reinterpret_cast<bool*>(static_cast<uintptr_t>(ptr));
    *resultPtr = TSD_BITMAP_GET(mgr.GetTsdSupportLevel(), TSD_SUPPORT_MUL_HCCP) != 0U ? true : false;
    return TSD_OK;
}

void MultipleHccpWriteUnsupported(uint64_t ptr) { *reinterpret_cast<bool*>(static_cast<uintptr_t>(ptr)) = false; }

// ===========================================================================
// The single registration point — one row per capability type.
// Note: BUILTIN_UDF and MULTIPLE_HCCP share the same rspMsgType as LEVEL
// (TSD_GET_SUPPORT_CAPABILITY_LEVEL_RSP). In UpdateStateFromMsg the first
// matching spec with a non-null updateStateFromMsg wins; since BUILTIN_UDF
// and MULTIPLE_HCCP have updateStateFromMsg=nullptr they are skipped, and
// LEVEL's handler processes the shared response. This is intentional —
// those types read their result from the same tsdSupportLevel_ bitmap.
// ===========================================================================
const CapabilitySpec kCapabilitySpecs[] = {
    {
        TSD_CAPABILITY_PIDQOS,
        HDCMessage::TSD_GET_PID_QOS,
        HDCMessage::TSD_GET_PID_QOS_RSP,
        true,
        0U,
        false,
        false,
        PidQosTryUseStored,
        PidQosSaveResult,
        PidQosWriteUnsupported,
        PidQosUpdateState,
    },
    {
        TSD_CAPABILITY_LEVEL,
        HDCMessage::TSD_GET_SUPPORT_CAPABILITY_LEVEL,
        HDCMessage::TSD_GET_SUPPORT_CAPABILITY_LEVEL_RSP,
        false,
        COMMON_SUPPORT_TIMEOUT,
        true,
        false,
        LevelTryUseStored,
        LevelSaveResult,
        LevelWriteUnsupported,
        LevelUpdateState,
    },
    {
        TSD_CAPABILITY_OM_INNER_DEC,
        HDCMessage::TSD_SUPPORT_OM_INNER_DEC,
        HDCMessage::TSD_SUPPORT_OM_INNER_DEC_RSP,
        false,
        SUPPORT_OM_INNER_DEC_MSG_TIMEOUT,
        true,
        true,
        OmInnerDecTryUseStored,
        OmInnerDecSaveResult,
        OmInnerDecWriteUnsupported,
        OmInnerDecUpdateState,
    },
    {
        TSD_CAPABILITY_BUILTIN_UDF,
        HDCMessage::TSD_GET_SUPPORT_CAPABILITY_LEVEL,
        HDCMessage::TSD_GET_SUPPORT_CAPABILITY_LEVEL_RSP,
        false,
        COMMON_SUPPORT_TIMEOUT,
        true,
        false,
        BuiltinUdfTryUseStored,
        BuiltinUdfSaveResult,
        BuiltinUdfWriteUnsupported,
        nullptr,
    },
    {
        TSD_CAPABILITY_DRIVER_VERSION,
        HDCMessage::INIT,
        HDCMessage::INIT,
        false,
        0U,
        false,
        false,
        DriverVersionTryUseStored,
        DriverVersionSaveResult,
        DriverVersionWriteUnsupported,
        nullptr,
    },
    {
        TSD_CAPABILITY_ADPROF,
        HDCMessage::TSD_GET_SUPPORT_ADPROF,
        HDCMessage::TSD_GET_SUPPORT_ADPROF_RSP,
        false,
        COMMON_SUPPORT_TIMEOUT,
        true,
        false,
        AdprofTryUseStored,
        AdprofSaveResult,
        AdprofWriteUnsupported,
        AdprofUpdateState,
    },
    {
        TSD_CAPABILITY_MUTIPLE_HCCP,
        HDCMessage::TSD_GET_SUPPORT_CAPABILITY_LEVEL,
        HDCMessage::TSD_GET_SUPPORT_CAPABILITY_LEVEL_RSP,
        false,
        COMMON_SUPPORT_TIMEOUT,
        true,
        false,
        MultipleHccpTryUseStored,
        MultipleHccpSaveResult,
        MultipleHccpWriteUnsupported,
        nullptr,
    },
};
} // namespace

const CapabilitySpec* FindCapabilitySpec(const int32_t type)
{
    for (const CapabilitySpec& spec : kCapabilitySpecs) {
        if (spec.type == type) {
            return &spec;
        }
    }
    return nullptr;
}

CapabilityManager::CapabilityManager(uint32_t logicDeviceId, DeviceCommAgent& commAgent, bool isAdcEnv)
    : logicDeviceId_(logicDeviceId), commAgent_(commAgent), isAdcEnv_(isAdcEnv)
{}

CapabilityManager::~CapabilityManager() {}

void CapabilityManager::ConstructCapabilityMsg(HDCMessage& msg, const int32_t type)
{
    MessageContext ctx{};
    ctx.logicDeviceId = logicDeviceId_;
    ctx.procSign = commAgent_.GetProcSign();
    ctx.capabilityType = type;
    (void)HdcMessageBuilder::BuildCapability(msg, ctx);
}

bool CapabilityManager::IsOkToGetCapability(const int32_t type) const
{
    const CapabilitySpec* spec = FindCapabilitySpec(type);
    if (spec == nullptr) {
        return false;
    }
    if (!spec->requiresStartCpAndComm) {
        return true;
    }
    return tsdStartCp_ && (commAgent_.GetDeviceComm() != nullptr);
}

TSD_StatusT CapabilityManager::SendCapabilityMsg(const int32_t type)
{
    if (!commAgent_.IsInit()) {
        TSD_WARN("[TsdClient] tsd client need open first");
        return TSD_OK;
    }
    HDCMessage msg;
    ConstructCapabilityMsg(msg, type);
    const TSD_StatusT ret = commAgent_.SendMsg(msg);
    return ret;
}

bool CapabilityManager::IsSupportCommonInterface(const uint32_t level)
{
    const uint32_t tsdSupportLevel = tsdSupportLevel_;
    if (tsdSupportLevel != 0U) {
        return TSD_BITMAP_GET(tsdSupportLevel, level) != 0U;
    }

    TSD_StatusT ret = commAgent_.InitTsdClient(isAdcEnv_);
    if ((ret != TSD_OK) || (commAgent_.GetDeviceComm() == nullptr)) {
        TSD_ERROR("Init hdc client failed.");
        return false;
    }
    ret = SendCapabilityMsg(TSD_CAPABILITY_LEVEL);
    if (ret != TSD_OK) {
        TSD_ERROR("SendCapabilityMsg failed");
        return false;
    }
    ret = commAgent_.RecvData(true, COMMON_SUPPORT_TIMEOUT);
    if (ret != TSD_OK) {
        TSD_RUN_INFO("TSD_CAPABILITY_LEVEL is not supported");
        return false;
    }
    const uint32_t curSupportLevel = tsdSupportLevel_;
    if (TSD_BITMAP_GET(curSupportLevel, level)) {
        return true;
    }

    TSD_RUN_INFO(
        "IsSupportCommonInterface check was not successful, level[%u], tsd support level[%u]", level, curSupportLevel);
    return false;
}

bool CapabilityManager::IsSupportCommonSink()
{
    if (!hasGetHostSoPath_) {
        hostSoPath_ = tsd::GetHostSoPath();
        hasGetHostSoPath_ = true;
    }
    if (!hostSoPath_.empty()) {
        const std::string mutexFile = hostSoPath_ + MUTEX_FILE_PREFIX + "0.cfg";
        if (CheckRealPath(mutexFile)) {
            TSD_RUN_INFO("mutexFile[%s] found means supporting common sink", mutexFile.c_str());
            return true;
        }
    }

    TSD_INFO("hostSoPath is %s.", hostSoPath_.c_str());
    return IsSupportCommonInterface(TSD_SUPPORT_COMMON_SINK_PKG_CONFIG);
}

bool CapabilityManager::CheckSubProcSupported(SubProcType procType)
{
    struct SubProcCapabilityEntry {
        SubProcType procType;
        uint32_t capabilityBit;
    };
    static const SubProcCapabilityEntry kSubProcCapabilityMap[] = {
        {TSD_SUB_PROC_UDF, TSD_SUPPORT_HS_AISERVER_FEATURE_BIT},
        {TSD_SUB_PROC_NPU, TSD_SUPPORT_HS_AISERVER_FEATURE_BIT},
        {TSD_SUB_PROC_BUILTIN_UDF, TSD_SUPPORT_BUILTIN_UDF_BIT},
        {TSD_SUB_PROC_ADPROF, TSD_SUPPORT_ADPROF_BIT},
    };
    for (const SubProcCapabilityEntry& entry : kSubProcCapabilityMap) {
        if (entry.procType == procType) {
            return IsSupportCommonInterface(entry.capabilityBit);
        }
    }
    return true;
}

bool CapabilityManager::UseStoredCapabityInfo(const int32_t type, const uint64_t ptr)
{
    const CapabilitySpec* spec = FindCapabilitySpec(type);
    if (spec == nullptr) {
        return false;
    }
    return spec->tryUseStored(*this, ptr);
}

// Thin wrapper around commAgent_.RecvData().
// The legacy ProcessModeManager::WaitRsp() additionally checked rspCode_ and
// mapped structured error codes via MapFailCodeToStatus(). That check is
// omitted here because all capability-query responses on the device side are
// written with rspCode_ = SUCCESS (0) unconditionally — the device never
// returns a non-zero rspCode_ for capability queries. Therefore the rspCode_
// branch was dead code for this path, and its removal does not change
// observable behaviour. Error reporting granularity is limited to the
// RecvData return value, which is sufficient for the ignoreFail=true
// majority of capability queries.
TSD_StatusT CapabilityManager::WaitRspForCapability(const uint32_t timeout, const bool ignoreRecvErr)
{
    const TSD_StatusT ret = commAgent_.RecvData(ignoreRecvErr, timeout);
    if (ret != TSD_OK) {
        if (!ignoreRecvErr) {
            TSD_ERROR("tsd client wait capability response fail, ret=%u", static_cast<uint32_t>(ret));
            TSD_REPORT_INNER_ERROR("tsd client wait capability response fail, ret=%u", static_cast<uint32_t>(ret));
        }
        return TSD_CLT_OPEN_FAILED;
    }
    return TSD_OK;
}

TSD_StatusT CapabilityManager::WaitCapabilityRsp(const int32_t type, const uint64_t ptr)
{
    const CapabilitySpec* spec = FindCapabilitySpec(type);
    const uint32_t timeout = (spec != nullptr) ? spec->waitTimeout : 0U;
    const bool ignoreFail = (spec != nullptr) ? spec->waitIgnoreFail : false;

    const TSD_StatusT ret = WaitRspForCapability(timeout, ignoreFail);
    if ((ignoreFail) && (ret != TSD_OK)) {
        TSD_RUN_INFO("not recv capability:%d rsp", type);
        if ((spec != nullptr) && (spec->hasTimeoutFallback)) {
            spec->writeUnsupported(ptr);
        }
        return TSD_OK;
    }
    TSD_CHECK(ret == TSD_OK, ret, "Wait capability response from device failed.");
    const TSD_StatusT saveRet = SaveCapabilityResult(type, ptr);
    TSD_CHECK(saveRet == TSD_OK, saveRet, "SaveCapabilityResult failed.");
    return TSD_OK;
}

TSD_StatusT CapabilityManager::CapabilityGet(const int32_t type, const uint64_t ptr)
{
    if ((!commAgent_.IsInit()) && (type == TSD_CAPABILITY_PIDQOS)) {
        TSD_WARN("[CapabilityManager] tsd client need open first");
        return TSD_OK;
    }

    TSD_RUN_INFO("[CapabilityManager] enter into CapabilityGet process deviceId[%u] type[%d].", logicDeviceId_, type);
    if (ptr == 0UL) {
        TSD_ERROR("input ptr is null");
        return TSD_CLT_OPEN_FAILED;
    }
    if (!IsOkToGetCapability(type)) {
        TSD_ERROR(
            "[CapabilityManager] startCp[%u],type[%d],sessionid[%u]", static_cast<uint32_t>(tsdStartCp_), type,
            commAgent_.GetSessionId());
        return TSD_CLT_OPEN_FAILED;
    }
    if (UseStoredCapabityInfo(type, ptr)) {
        return TSD_OK;
    }
    TSD_StatusT ret = commAgent_.InitTsdClient(isAdcEnv_);
    TSD_CHECK(ret == TSD_OK, ret, "Init hdc client failed.");

    TSD_CHECK_NULLPTR(
        commAgent_.GetDeviceComm(), TSD_INSTANCE_NOT_INITIALED,
        "[CapabilityManager] devCommClient_ is null in Close function.");
    ret = SendCapabilityMsg(type);
    TSD_CHECK(ret == TSD_OK, ret, "SendCapabilityMsg failed.");

    TSD_RUN_INFO(
        "[CapabilityManager][deviceId=%u] [sessionId=%u] [type=%d]send capability successfully.", logicDeviceId_,
        commAgent_.GetSessionId(), type);

    ret = WaitCapabilityRsp(type, ptr);

    TSD_RUN_INFO(
        "[CapabilityManager][logicDeviceId_=%u][type=%d][pidQos=%lld][ret=%u]recv capability response finished.",
        logicDeviceId_, type, pidQos_, ret);
    return TSD_OK;
}

TSD_StatusT CapabilityManager::SaveCapabilityResult(const int32_t type, const uint64_t ptr) const
{
    const CapabilitySpec* spec = FindCapabilitySpec(type);
    if (spec == nullptr) {
        return TSD_CLT_OPEN_FAILED;
    }
    return spec->saveResult(*this, ptr);
}

void CapabilityManager::UpdateStateFromMsg(const HDCMessage& msg)
{
    const HDCMessage::MsgType msgType = msg.type();
    bool handledBySpec = false;
    for (const CapabilitySpec& spec : kCapabilitySpecs) {
        if ((spec.rspMsgType != msgType) || (spec.updateStateFromMsg == nullptr)) {
            continue;
        }
        spec.updateStateFromMsg(*this, msg);
        handledBySpec = true;
        break;
    }
    // Fallback: for messages other than TSD_GET_SUPPORT_CAPABILITY_LEVEL_RSP,
    // any non-zero capability_level still updates tsdSupportLevel_ (legacy
    // behaviour preserved). LEVEL_RSP is fully handled by its spec handler
    // (which checks rsp_code) and must not be overridden here.
    if (!handledBySpec || (msgType != HDCMessage::TSD_GET_SUPPORT_CAPABILITY_LEVEL_RSP)) {
        if (msg.capability_level() != 0U) {
            tsdSupportLevel_ = msg.capability_level();
        }
    }
}

void CapabilityManager::HandlePidQosRsp(const HDCMessage& msg)
{
    pidQos_ = msg.pid_of_qos();
    const uint32_t realDeviceId = msg.real_device_id();
    const uint32_t deviceId = msg.device_id();
    const HDCMessage::MsgType msgType = msg.type();
    TSD_RUN_INFO(
        "[TsdClient] PidQosMsgProc recvMsg realDeviceId[%u] msgType[%u] localDevId[%u] rspCode[%u],pidqos[%lld]",
        realDeviceId, static_cast<uint32_t>(msgType), deviceId, msg.tsd_rsp_code(), pidQos_);
}

} // namespace tsd
