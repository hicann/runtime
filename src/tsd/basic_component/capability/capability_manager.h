/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef TSD_BASIC_COMPONENT_CAPABILITY_CAPABILITY_MANAGER_H
#define TSD_BASIC_COMPONENT_CAPABILITY_CAPABILITY_MANAGER_H

#include "device_comm_agent.h"
#include "hdc_message_builder.h"
#include "inc/client_manager.h"
#include "inc/basic_define.h"
#include "proto/tsd_message.pb.h"
#include "tsd/tsd_client.h" // SubProcType

#include <string>

namespace tsd {

// ---------------------------------------------------------------------------
// tsdSupportLevel_ bitmap definitions — each bit identifies a device
// capability negotiated via the TSD_CAPABILITY_LEVEL query.
// ---------------------------------------------------------------------------
constexpr uint32_t TSD_SUPPORT_HS_AISERVER_FEATURE_BIT = 0U;
constexpr uint32_t TSD_SUPPORT_BUILTIN_UDF_BIT = 1U;
constexpr uint32_t TSD_SUPPORT_CLOSE_LIST_BIT = 2U;
constexpr uint32_t TSD_SUPPORT_ADPROF_BIT = 3U;
constexpr uint32_t TSD_SUPPORT_EXTEND_PKG = 4U;
constexpr uint32_t TSD_SUPPORT_MUL_HCCP = 5U;
constexpr uint32_t TSD_SUPPORT_DRIVER_EXTEND_BIT = 6U;
constexpr uint32_t TSD_SUPPORT_ASCENDCPP_PKG = 7U;
constexpr uint32_t TSD_SUPPORT_COMMON_SINK_PKG_CONFIG = 8U;
constexpr uint32_t TSD_SUPPORT_CANN_HCOMM_COMPAT_910B = 9U;

const std::string MUTEX_FILE_PREFIX = "sink_file_mutex_";

class CapabilityManager;

// Function-pointer strategy table entry — one row per capability type.
// Every per-type behaviour is expressed as data (a function pointer) rather
// than a switch-case branch, so adding a new capability type only requires
// appending one row to the table in capability_manager.cpp.
//
// The functions receive a CapabilityManager reference so they can access
// member getters/setters without friendship.
struct CapabilitySpec {
    int32_t type;
    HDCMessage::MsgType msgType;    // request: type → proto MsgType
    HDCMessage::MsgType rspMsgType; // response: proto MsgType for device rsp
    bool requiresStartCpAndComm;    // IsOkToGetCapability gate
    uint32_t waitTimeout;           // WaitCapabilityRsp timeout (ms)
    bool waitIgnoreFail;            // WaitCapabilityRsp tolerate failure
    bool hasTimeoutFallback;        // write "unsupported" value on timeout

    // Try to serve the result from already-cached state.
    // Returns true if the output pointer was written and no device round-trip
    // is needed.
    bool (*tryUseStored)(CapabilityManager& mgr, uint64_t ptr);

    // Write the current member state to the caller's output pointer.
    // Returns TSD_OK on success.
    TSD_StatusT (*saveResult)(const CapabilityManager& mgr, uint64_t ptr);

    // Write the "unsupported / zero" value to the caller's output pointer.
    // Used by WaitCapabilityRsp when hasTimeoutFallback is set and the
    // device response times out.
    void (*writeUnsupported)(uint64_t ptr);

    // Update internal member state from a device response message.
    void (*updateStateFromMsg)(CapabilityManager& mgr, const HDCMessage& msg);
};

// Look up the spec for a given capability type.  Returns nullptr if unknown.
const CapabilitySpec* FindCapabilitySpec(int32_t type);

class CapabilityManager {
public:
    CapabilityManager(uint32_t logicDeviceId, DeviceCommAgent& commAgent, bool isAdcEnv);
    ~CapabilityManager();

    TSD_StatusT CapabilityGet(const int32_t type, const uint64_t ptr);

    bool IsSupportCommonInterface(const uint32_t level);
    bool IsSupportCommonSink();

    // Check whether the given sub-process type is supported by the device.
    // Returns true if supported (or if no check is registered for the type).
    bool CheckSubProcSupported(SubProcType procType);

    bool IsOkToGetCapability(const int32_t type) const;
    void ConstructCapabilityMsg(HDCMessage& msg, const int32_t type);
    TSD_StatusT SendCapabilityMsg(const int32_t type);
    TSD_StatusT WaitCapabilityRsp(const int32_t type, const uint64_t ptr);
    TSD_StatusT SaveCapabilityResult(const int32_t type, const uint64_t ptr) const;

    void UpdateStateFromMsg(const HDCMessage& msg);
    void HandlePidQosRsp(const HDCMessage& msg);
    void SetStartCpStatus(bool startCp) { tsdStartCp_ = startCp; }

    // --- accessors used by CapabilitySpec strategy functions ---
    int64_t GetPidQos() const { return pidQos_; }
    uint32_t GetTsdSupportLevel() const { return tsdSupportLevel_; }
    bool IsSupportOmInnerDec() const { return supportOmInnerDec_; }
    bool IsAdprofSupport() const { return adprofSupport_; }
    bool IsStartCp() const { return tsdStartCp_; }
    DeviceCommAgent& GetCommAgent() { return commAgent_; }
    const DeviceCommAgent& GetCommAgent() const { return commAgent_; }

    // --- mutators used by CapabilitySpec strategy functions ---
    void SetTsdSupportLevel(uint32_t level) { tsdSupportLevel_ = level; }
    void SetAdprofSupport(bool support) { adprofSupport_ = support; }
    void SetSupportOmInnerDec(bool support) { supportOmInnerDec_ = support; }
    void SetPidQos(int64_t pidQos) { pidQos_ = pidQos; }

private:
    TSD_StatusT WaitRspForCapability(const uint32_t timeout, const bool ignoreRecvErr);
    bool UseStoredCapabityInfo(const int32_t type, const uint64_t ptr);

    uint32_t logicDeviceId_;
    DeviceCommAgent& commAgent_;
    bool isAdcEnv_;

    uint32_t tsdSupportLevel_ = 0U;
    bool supportOmInnerDec_ = false;
    bool adprofSupport_ = false;
    int64_t pidQos_ = -1;
    bool tsdStartCp_ = false;
    std::string hostSoPath_;
    bool hasGetHostSoPath_ = false;
};

} // namespace tsd
#endif // TSD_BASIC_COMPONENT_CAPABILITY_CAPABILITY_MANAGER_H
