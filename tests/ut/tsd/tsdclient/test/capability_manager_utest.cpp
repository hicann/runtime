/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "gtest/gtest.h"
#include "mockcpp/mockcpp.hpp"
#include "tsd/status.h"
#define private public
#define protected public
#include "capability_manager.h"
#include "hdc_message_builder.h"
#include "inc/process_mode_manager.h"
#include "device_comm.h"
#include "tsd_hdc_client.h"
#include "weak_ascend_hal.h"
#undef private
#undef protected

using namespace tsd;
using namespace std;

namespace {
static const int deviceId = 0;

struct StubDeviceComm : public DeviceComm {
    explicit StubDeviceComm(uint32_t devId) : DeviceComm(devId, DeviceCommType::HDC) {}
};
} // namespace

class CapabilityManagerTest : public testing::Test {
protected:
    virtual void SetUp() { cout << "Before CapabilityManagerTest" << endl; }
    virtual void TearDown()
    {
        cout << "After CapabilityManagerTest" << endl;
        GlobalMockObject::verify();
        GlobalMockObject::reset();
    }
};

TEST_F(CapabilityManagerTest, IsOkToGetCapability_Level_True)
{
    ProcessModeManager pm(deviceId, 0);
    EXPECT_TRUE(pm.capabilityMgr_.IsOkToGetCapability(TSD_CAPABILITY_LEVEL));
}

TEST_F(CapabilityManagerTest, IsOkToGetCapability_OmInnerDec_True)
{
    ProcessModeManager pm(deviceId, 0);
    EXPECT_TRUE(pm.capabilityMgr_.IsOkToGetCapability(TSD_CAPABILITY_OM_INNER_DEC));
}

TEST_F(CapabilityManagerTest, IsOkToGetCapability_BuiltinUdf_True)
{
    ProcessModeManager pm(deviceId, 0);
    EXPECT_TRUE(pm.capabilityMgr_.IsOkToGetCapability(TSD_CAPABILITY_BUILTIN_UDF));
}

TEST_F(CapabilityManagerTest, IsOkToGetCapability_Adprof_True)
{
    ProcessModeManager pm(deviceId, 0);
    EXPECT_TRUE(pm.capabilityMgr_.IsOkToGetCapability(TSD_CAPABILITY_ADPROF));
}

TEST_F(CapabilityManagerTest, IsOkToGetCapability_MultipleHccp_True)
{
    ProcessModeManager pm(deviceId, 0);
    EXPECT_TRUE(pm.capabilityMgr_.IsOkToGetCapability(TSD_CAPABILITY_MUTIPLE_HCCP));
}

TEST_F(CapabilityManagerTest, IsOkToGetCapability_DriverVersion_True)
{
    ProcessModeManager pm(deviceId, 0);
    EXPECT_TRUE(pm.capabilityMgr_.IsOkToGetCapability(TSD_CAPABILITY_DRIVER_VERSION));
}

TEST_F(CapabilityManagerTest, IsOkToGetCapability_PidQos_StartCpFalse_False)
{
    ProcessModeManager pm(deviceId, 0);
    pm.capabilityMgr_.SetStartCpStatus(false);
    EXPECT_FALSE(pm.capabilityMgr_.IsOkToGetCapability(TSD_CAPABILITY_PIDQOS));
}

TEST_F(CapabilityManagerTest, IsOkToGetCapability_PidQos_StartCpTrue_NoComm_False)
{
    ProcessModeManager pm(deviceId, 0);
    pm.capabilityMgr_.SetStartCpStatus(true);
    EXPECT_FALSE(pm.capabilityMgr_.IsOkToGetCapability(TSD_CAPABILITY_PIDQOS));
}

TEST_F(CapabilityManagerTest, IsOkToGetCapability_PidQos_StartCpTrue_WithComm_True)
{
    ProcessModeManager pm(deviceId, 0);
    pm.capabilityMgr_.SetStartCpStatus(true);
    pm.commAgent_.devCommClient_ = DeviceComm::GetInstance(deviceId, DeviceCommType::HDC);
    EXPECT_TRUE(pm.capabilityMgr_.IsOkToGetCapability(TSD_CAPABILITY_PIDQOS));
}

TEST_F(CapabilityManagerTest, IsOkToGetCapability_InvalidType_False)
{
    ProcessModeManager pm(deviceId, 0);
    EXPECT_FALSE(pm.capabilityMgr_.IsOkToGetCapability(TSD_CAPABILITY_BUT));
}

TEST_F(CapabilityManagerTest, BuildCapability_PidQos)
{
    MessageContext ctx{};
    ctx.logicDeviceId = static_cast<uint32_t>(deviceId);
    ctx.capabilityType = TSD_CAPABILITY_PIDQOS;
    HDCMessage msg;
    EXPECT_EQ(HdcMessageBuilder::BuildCapability(msg, ctx), TSD_OK);
    EXPECT_EQ(msg.type(), HDCMessage::TSD_GET_PID_QOS);
    EXPECT_EQ(msg.device_id(), deviceId % PER_OS_CHIP_NUM);
    EXPECT_EQ(msg.real_device_id(), static_cast<uint32_t>(deviceId));
}

TEST_F(CapabilityManagerTest, BuildCapability_Level)
{
    MessageContext ctx{};
    ctx.logicDeviceId = static_cast<uint32_t>(deviceId);
    ctx.capabilityType = TSD_CAPABILITY_LEVEL;
    HDCMessage msg;
    EXPECT_EQ(HdcMessageBuilder::BuildCapability(msg, ctx), TSD_OK);
    EXPECT_EQ(msg.type(), HDCMessage::TSD_GET_SUPPORT_CAPABILITY_LEVEL);
    EXPECT_EQ(msg.device_id(), deviceId % PER_OS_CHIP_NUM);
    EXPECT_EQ(msg.real_device_id(), static_cast<uint32_t>(deviceId));
}

TEST_F(CapabilityManagerTest, BuildCapability_BuiltinUdf)
{
    MessageContext ctx{};
    ctx.logicDeviceId = static_cast<uint32_t>(deviceId);
    ctx.capabilityType = TSD_CAPABILITY_BUILTIN_UDF;
    HDCMessage msg;
    EXPECT_EQ(HdcMessageBuilder::BuildCapability(msg, ctx), TSD_OK);
    EXPECT_EQ(msg.type(), HDCMessage::TSD_GET_SUPPORT_CAPABILITY_LEVEL);
}

TEST_F(CapabilityManagerTest, BuildCapability_MultipleHccp)
{
    MessageContext ctx{};
    ctx.logicDeviceId = static_cast<uint32_t>(deviceId);
    ctx.capabilityType = TSD_CAPABILITY_MUTIPLE_HCCP;
    HDCMessage msg;
    EXPECT_EQ(HdcMessageBuilder::BuildCapability(msg, ctx), TSD_OK);
    EXPECT_EQ(msg.type(), HDCMessage::TSD_GET_SUPPORT_CAPABILITY_LEVEL);
}

TEST_F(CapabilityManagerTest, BuildCapability_OmInnerDec)
{
    MessageContext ctx{};
    ctx.logicDeviceId = static_cast<uint32_t>(deviceId);
    ctx.capabilityType = TSD_CAPABILITY_OM_INNER_DEC;
    HDCMessage msg;
    EXPECT_EQ(HdcMessageBuilder::BuildCapability(msg, ctx), TSD_OK);
    EXPECT_EQ(msg.type(), HDCMessage::TSD_SUPPORT_OM_INNER_DEC);
}

TEST_F(CapabilityManagerTest, BuildCapability_Adprof)
{
    MessageContext ctx{};
    ctx.logicDeviceId = static_cast<uint32_t>(deviceId);
    ctx.capabilityType = TSD_CAPABILITY_ADPROF;
    HDCMessage msg;
    EXPECT_EQ(HdcMessageBuilder::BuildCapability(msg, ctx), TSD_OK);
    EXPECT_EQ(msg.type(), HDCMessage::TSD_GET_SUPPORT_ADPROF);
}

TEST_F(CapabilityManagerTest, BuildCapability_InvalidType)
{
    MessageContext ctx{};
    ctx.logicDeviceId = static_cast<uint32_t>(deviceId);
    ctx.capabilityType = TSD_CAPABILITY_BUT;
    HDCMessage msg;
    EXPECT_EQ(HdcMessageBuilder::BuildCapability(msg, ctx), TSD_OK);
    EXPECT_EQ(msg.type(), HDCMessage::INIT);
}

TEST_F(CapabilityManagerTest, BuildCapability_ProcSignPid)
{
    MessageContext ctx{};
    ctx.logicDeviceId = static_cast<uint32_t>(deviceId);
    ctx.capabilityType = TSD_CAPABILITY_LEVEL;
    ctx.procSign.tgid = 4321;
    HDCMessage msg;
    EXPECT_EQ(HdcMessageBuilder::BuildCapability(msg, ctx), TSD_OK);
    EXPECT_EQ(msg.proc_sign_pid().proc_pid(), 4321U);
}

TEST_F(CapabilityManagerTest, ConstructCapabilityMsg_SetsFields)
{
    ProcessModeManager pm(deviceId, 0);
    HDCMessage msg;
    pm.capabilityMgr_.ConstructCapabilityMsg(msg, TSD_CAPABILITY_LEVEL);
    EXPECT_EQ(msg.device_id(), deviceId % PER_OS_CHIP_NUM);
    EXPECT_EQ(msg.real_device_id(), static_cast<uint32_t>(deviceId));
    EXPECT_EQ(msg.type(), HDCMessage::TSD_GET_SUPPORT_CAPABILITY_LEVEL);
}

TEST_F(CapabilityManagerTest, ConstructCapabilityMsg_PidQos)
{
    ProcessModeManager pm(deviceId, 0);
    HDCMessage msg;
    pm.capabilityMgr_.ConstructCapabilityMsg(msg, TSD_CAPABILITY_PIDQOS);
    EXPECT_EQ(msg.type(), HDCMessage::TSD_GET_PID_QOS);
    EXPECT_EQ(msg.device_id(), deviceId % PER_OS_CHIP_NUM);
    EXPECT_EQ(msg.real_device_id(), static_cast<uint32_t>(deviceId));
}

TEST_F(CapabilityManagerTest, ConstructCapabilityMsg_OmInnerDec)
{
    ProcessModeManager pm(deviceId, 0);
    HDCMessage msg;
    pm.capabilityMgr_.ConstructCapabilityMsg(msg, TSD_CAPABILITY_OM_INNER_DEC);
    EXPECT_EQ(msg.type(), HDCMessage::TSD_SUPPORT_OM_INNER_DEC);
}

TEST_F(CapabilityManagerTest, ConstructCapabilityMsg_Adprof)
{
    ProcessModeManager pm(deviceId, 0);
    HDCMessage msg;
    pm.capabilityMgr_.ConstructCapabilityMsg(msg, TSD_CAPABILITY_ADPROF);
    EXPECT_EQ(msg.type(), HDCMessage::TSD_GET_SUPPORT_ADPROF);
}

TEST_F(CapabilityManagerTest, UseStoredCapabityInfo_Level_Hit)
{
    ProcessModeManager pm(deviceId, 0);
    pm.capabilityMgr_.tsdSupportLevel_ = 1U;
    uint32_t result = 0;
    uint64_t ptr = reinterpret_cast<uint64_t>(&result);
    EXPECT_TRUE(pm.capabilityMgr_.UseStoredCapabityInfo(TSD_CAPABILITY_LEVEL, ptr));
    EXPECT_EQ(result, 1U);
}

TEST_F(CapabilityManagerTest, UseStoredCapabityInfo_OmInnerDec_Hit)
{
    ProcessModeManager pm(deviceId, 0);
    pm.capabilityMgr_.supportOmInnerDec_ = true;
    uint64_t result = 0;
    uint64_t ptr = reinterpret_cast<uint64_t>(&result);
    EXPECT_TRUE(pm.capabilityMgr_.UseStoredCapabityInfo(TSD_CAPABILITY_OM_INNER_DEC, ptr));
    EXPECT_EQ(result, 1UL);
}

TEST_F(CapabilityManagerTest, UseStoredCapabityInfo_BuiltinUdf_Hit)
{
    ProcessModeManager pm(deviceId, 0);
    pm.capabilityMgr_.tsdSupportLevel_ = (1U << TSD_SUPPORT_BUILTIN_UDF_BIT);
    bool result = false;
    uint64_t ptr = reinterpret_cast<uint64_t>(&result);
    EXPECT_TRUE(pm.capabilityMgr_.UseStoredCapabityInfo(TSD_CAPABILITY_BUILTIN_UDF, ptr));
    EXPECT_TRUE(result);
}

TEST_F(CapabilityManagerTest, UseStoredCapabityInfo_DriverVersion_Hit)
{
    ProcessModeManager pm(deviceId, 0);
    uint64_t result = 99UL;
    uint64_t ptr = reinterpret_cast<uint64_t>(&result);
    EXPECT_TRUE(pm.capabilityMgr_.UseStoredCapabityInfo(TSD_CAPABILITY_DRIVER_VERSION, ptr));
    EXPECT_EQ(result, 0UL);
}

TEST_F(CapabilityManagerTest, UseStoredCapabityInfo_Adprof_Hit)
{
    ProcessModeManager pm(deviceId, 0);
    pm.capabilityMgr_.adprofSupport_ = true;
    bool result = false;
    uint64_t ptr = reinterpret_cast<uint64_t>(&result);
    EXPECT_TRUE(pm.capabilityMgr_.UseStoredCapabityInfo(TSD_CAPABILITY_ADPROF, ptr));
    EXPECT_TRUE(result);
}

TEST_F(CapabilityManagerTest, UseStoredCapabityInfo_MultipleHccp_Hit)
{
    ProcessModeManager pm(deviceId, 0);
    pm.capabilityMgr_.tsdSupportLevel_ = (1U << TSD_SUPPORT_MUL_HCCP);
    bool result = false;
    uint64_t ptr = reinterpret_cast<uint64_t>(&result);
    EXPECT_TRUE(pm.capabilityMgr_.UseStoredCapabityInfo(TSD_CAPABILITY_MUTIPLE_HCCP, ptr));
    EXPECT_TRUE(result);
}

TEST_F(CapabilityManagerTest, UseStoredCapabityInfo_Level_Miss)
{
    ProcessModeManager pm(deviceId, 0);
    pm.capabilityMgr_.tsdSupportLevel_ = 0U;
    uint32_t result = 0;
    uint64_t ptr = reinterpret_cast<uint64_t>(&result);
    EXPECT_FALSE(pm.capabilityMgr_.UseStoredCapabityInfo(TSD_CAPABILITY_LEVEL, ptr));
}

TEST_F(CapabilityManagerTest, UseStoredCapabityInfo_InvalidType_False)
{
    ProcessModeManager pm(deviceId, 0);
    uint64_t result = 0;
    uint64_t ptr = reinterpret_cast<uint64_t>(&result);
    EXPECT_FALSE(pm.capabilityMgr_.UseStoredCapabityInfo(TSD_CAPABILITY_BUT, ptr));
}

TEST_F(CapabilityManagerTest, UseStoredCapabityInfo_PidQos_NoStored_False)
{
    ProcessModeManager pm(deviceId, 0);
    pm.capabilityMgr_.pidQos_ = 100;
    uint64_t result = 0;
    uint64_t ptr = reinterpret_cast<uint64_t>(&result);
    EXPECT_FALSE(pm.capabilityMgr_.UseStoredCapabityInfo(TSD_CAPABILITY_PIDQOS, ptr));
}

TEST_F(CapabilityManagerTest, SaveCapabilityResult_PidQos)
{
    ProcessModeManager pm(deviceId, 0);
    pm.capabilityMgr_.pidQos_ = 42;
    uint64_t result = 0;
    uint64_t ptr = reinterpret_cast<uint64_t>(&result);
    EXPECT_EQ(pm.capabilityMgr_.SaveCapabilityResult(TSD_CAPABILITY_PIDQOS, ptr), TSD_OK);
    EXPECT_EQ(result, 42UL);
}

TEST_F(CapabilityManagerTest, SaveCapabilityResult_Level)
{
    ProcessModeManager pm(deviceId, 0);
    pm.capabilityMgr_.tsdSupportLevel_ = 5U;
    uint32_t result = 0;
    uint64_t ptr = reinterpret_cast<uint64_t>(&result);
    EXPECT_EQ(pm.capabilityMgr_.SaveCapabilityResult(TSD_CAPABILITY_LEVEL, ptr), TSD_OK);
    EXPECT_EQ(result, 5U);
}

TEST_F(CapabilityManagerTest, SaveCapabilityResult_OmInnerDec_Supported)
{
    ProcessModeManager pm(deviceId, 0);
    pm.capabilityMgr_.supportOmInnerDec_ = true;
    uint64_t result = 0;
    uint64_t ptr = reinterpret_cast<uint64_t>(&result);
    EXPECT_EQ(pm.capabilityMgr_.SaveCapabilityResult(TSD_CAPABILITY_OM_INNER_DEC, ptr), TSD_OK);
    EXPECT_EQ(result, 1UL);
}

TEST_F(CapabilityManagerTest, SaveCapabilityResult_OmInnerDec_NotSupported)
{
    ProcessModeManager pm(deviceId, 0);
    pm.capabilityMgr_.supportOmInnerDec_ = false;
    uint64_t result = 0;
    uint64_t ptr = reinterpret_cast<uint64_t>(&result);
    EXPECT_EQ(pm.capabilityMgr_.SaveCapabilityResult(TSD_CAPABILITY_OM_INNER_DEC, ptr), TSD_OK);
    EXPECT_EQ(result, 0UL);
}

TEST_F(CapabilityManagerTest, SaveCapabilityResult_BuiltinUdf)
{
    ProcessModeManager pm(deviceId, 0);
    pm.capabilityMgr_.tsdSupportLevel_ = (1U << TSD_SUPPORT_BUILTIN_UDF_BIT);
    bool result = false;
    uint64_t ptr = reinterpret_cast<uint64_t>(&result);
    EXPECT_EQ(pm.capabilityMgr_.SaveCapabilityResult(TSD_CAPABILITY_BUILTIN_UDF, ptr), TSD_OK);
    EXPECT_TRUE(result);
}

TEST_F(CapabilityManagerTest, SaveCapabilityResult_Adprof)
{
    ProcessModeManager pm(deviceId, 0);
    pm.capabilityMgr_.adprofSupport_ = true;
    bool result = false;
    uint64_t ptr = reinterpret_cast<uint64_t>(&result);
    EXPECT_EQ(pm.capabilityMgr_.SaveCapabilityResult(TSD_CAPABILITY_ADPROF, ptr), TSD_OK);
    EXPECT_TRUE(result);
}

TEST_F(CapabilityManagerTest, SaveCapabilityResult_MultipleHccp)
{
    ProcessModeManager pm(deviceId, 0);
    pm.capabilityMgr_.tsdSupportLevel_ = (1U << TSD_SUPPORT_MUL_HCCP);
    bool result = false;
    uint64_t ptr = reinterpret_cast<uint64_t>(&result);
    EXPECT_EQ(pm.capabilityMgr_.SaveCapabilityResult(TSD_CAPABILITY_MUTIPLE_HCCP, ptr), TSD_OK);
    EXPECT_TRUE(result);
}

TEST_F(CapabilityManagerTest, SaveCapabilityResult_InvalidType)
{
    ProcessModeManager pm(deviceId, 0);
    uint64_t result = 0;
    uint64_t ptr = reinterpret_cast<uint64_t>(&result);
    EXPECT_EQ(pm.capabilityMgr_.SaveCapabilityResult(TSD_CAPABILITY_BUT, ptr), TSD_CLT_OPEN_FAILED);
}

TEST_F(CapabilityManagerTest, SaveCapabilityResult_DriverVersion_Fail)
{
    ProcessModeManager pm(deviceId, 0);
    uint64_t result = 0;
    uint64_t ptr = reinterpret_cast<uint64_t>(&result);
    // DRIVER_VERSION is always served by UseStoredCapabityInfo, so
    // SaveCapabilityResult returns failure for it.
    EXPECT_EQ(pm.capabilityMgr_.SaveCapabilityResult(TSD_CAPABILITY_DRIVER_VERSION, ptr), TSD_CLT_OPEN_FAILED);
}

TEST_F(CapabilityManagerTest, WaitCapabilityRsp_InvalidType_DefaultBehavior)
{
    ProcessModeManager pm(deviceId, 0);
    uint64_t result = 0;
    uint64_t ptr = reinterpret_cast<uint64_t>(&result);
    // Unknown type uses timeout=0, ignoreFail=false.
    MOCKER_CPP(&CapabilityManager::WaitRspForCapability)
        .stubs()
        .will(returnValue(static_cast<uint32_t>(TSD_CLT_OPEN_FAILED)));
    EXPECT_EQ(pm.capabilityMgr_.WaitCapabilityRsp(TSD_CAPABILITY_BUT, ptr), TSD_CLT_OPEN_FAILED);
    GlobalMockObject::verify();
}

TEST_F(CapabilityManagerTest, UpdateStateFromMsg_CapabilityLevelRsp)
{
    ProcessModeManager pm(deviceId, 0);
    HDCMessage msg;
    msg.set_type(HDCMessage::TSD_GET_SUPPORT_CAPABILITY_LEVEL_RSP);
    msg.set_capability_level(7);
    msg.set_tsd_rsp_code(0);
    pm.capabilityMgr_.UpdateStateFromMsg(msg);
    EXPECT_EQ(pm.capabilityMgr_.tsdSupportLevel_, 7U);
}

TEST_F(CapabilityManagerTest, UpdateStateFromMsg_CapabilityLevelRsp_RspCodeFail)
{
    ProcessModeManager pm(deviceId, 0);
    HDCMessage msg;
    msg.set_type(HDCMessage::TSD_GET_SUPPORT_CAPABILITY_LEVEL_RSP);
    msg.set_capability_level(7);
    msg.set_tsd_rsp_code(1);
    pm.capabilityMgr_.tsdSupportLevel_ = 0;
    pm.capabilityMgr_.UpdateStateFromMsg(msg);
    EXPECT_EQ(pm.capabilityMgr_.tsdSupportLevel_, 0U);
}

TEST_F(CapabilityManagerTest, UpdateStateFromMsg_AdprofRsp)
{
    ProcessModeManager pm(deviceId, 0);
    HDCMessage msg;
    msg.set_type(HDCMessage::TSD_GET_SUPPORT_ADPROF_RSP);
    msg.set_support_adprof(true);
    pm.capabilityMgr_.UpdateStateFromMsg(msg);
    EXPECT_TRUE(pm.capabilityMgr_.adprofSupport_);
}

TEST_F(CapabilityManagerTest, UpdateStateFromMsg_OmInnerDecRsp_Success)
{
    ProcessModeManager pm(deviceId, 0);
    HDCMessage msg;
    msg.set_type(HDCMessage::TSD_SUPPORT_OM_INNER_DEC_RSP);
    msg.set_tsd_rsp_code(0);
    pm.capabilityMgr_.UpdateStateFromMsg(msg);
    EXPECT_TRUE(pm.capabilityMgr_.supportOmInnerDec_);
}

TEST_F(CapabilityManagerTest, UpdateStateFromMsg_OmInnerDecRsp_Fail)
{
    ProcessModeManager pm(deviceId, 0);
    HDCMessage msg;
    msg.set_type(HDCMessage::TSD_SUPPORT_OM_INNER_DEC_RSP);
    msg.set_tsd_rsp_code(1);
    pm.capabilityMgr_.UpdateStateFromMsg(msg);
    EXPECT_FALSE(pm.capabilityMgr_.supportOmInnerDec_);
}

TEST_F(CapabilityManagerTest, UpdateStateFromMsg_Fallback_UnknownMsgWithCapabilityLevel)
{
    ProcessModeManager pm(deviceId, 0);
    HDCMessage msg;
    msg.set_type(HDCMessage::TSD_CHECK_PACKAGE_RSP);
    msg.set_capability_level(42);
    pm.capabilityMgr_.UpdateStateFromMsg(msg);
    EXPECT_EQ(pm.capabilityMgr_.tsdSupportLevel_, 42U);
}

TEST_F(CapabilityManagerTest, UpdateStateFromMsg_Fallback_UnknownMsgZeroLevel_NoUpdate)
{
    ProcessModeManager pm(deviceId, 0);
    pm.capabilityMgr_.tsdSupportLevel_ = 99U;
    HDCMessage msg;
    msg.set_type(HDCMessage::TSD_CHECK_PACKAGE_RSP);
    msg.set_capability_level(0);
    pm.capabilityMgr_.UpdateStateFromMsg(msg);
    EXPECT_EQ(pm.capabilityMgr_.tsdSupportLevel_, 99U);
}

TEST_F(CapabilityManagerTest, UpdateStateFromMsg_AdprofRsp_WithCapabilityLevel)
{
    ProcessModeManager pm(deviceId, 0);
    HDCMessage msg;
    msg.set_type(HDCMessage::TSD_GET_SUPPORT_ADPROF_RSP);
    msg.set_support_adprof(true);
    msg.set_capability_level(42);
    pm.capabilityMgr_.UpdateStateFromMsg(msg);
    EXPECT_TRUE(pm.capabilityMgr_.adprofSupport_);
    EXPECT_EQ(pm.capabilityMgr_.tsdSupportLevel_, 42U);
}

TEST_F(CapabilityManagerTest, UpdateStateFromMsg_OmInnerDecRsp_WithCapabilityLevel)
{
    ProcessModeManager pm(deviceId, 0);
    HDCMessage msg;
    msg.set_type(HDCMessage::TSD_SUPPORT_OM_INNER_DEC_RSP);
    msg.set_tsd_rsp_code(0);
    msg.set_capability_level(7);
    pm.capabilityMgr_.UpdateStateFromMsg(msg);
    EXPECT_TRUE(pm.capabilityMgr_.supportOmInnerDec_);
    EXPECT_EQ(pm.capabilityMgr_.tsdSupportLevel_, 7U);
}

TEST_F(CapabilityManagerTest, HandlePidQosRsp_SetsPidQos)
{
    ProcessModeManager pm(deviceId, 0);
    HDCMessage msg;
    msg.set_pid_of_qos(123);
    pm.capabilityMgr_.HandlePidQosRsp(msg);
    EXPECT_EQ(pm.capabilityMgr_.pidQos_, 123);
}

TEST_F(CapabilityManagerTest, HandlePidQosRsp_NegativePidQos)
{
    ProcessModeManager pm(deviceId, 0);
    HDCMessage msg;
    msg.set_pid_of_qos(-1);
    pm.capabilityMgr_.HandlePidQosRsp(msg);
    EXPECT_EQ(pm.capabilityMgr_.pidQos_, -1);
}

TEST_F(CapabilityManagerTest, WaitCapabilityRsp_OmInnerDec_TimeoutReturnsOk)
{
    ProcessModeManager pm(deviceId, 0);
    uint64_t result = 0;
    uint64_t ptr = reinterpret_cast<uint64_t>(&result);
    MOCKER_CPP(&CapabilityManager::WaitRspForCapability).stubs().will(returnValue(static_cast<uint32_t>(1U)));
    EXPECT_EQ(pm.capabilityMgr_.WaitCapabilityRsp(TSD_CAPABILITY_OM_INNER_DEC, ptr), TSD_OK);
    EXPECT_EQ(result, 0UL);
    GlobalMockObject::verify();
}

TEST_F(CapabilityManagerTest, WaitCapabilityRsp_Level_TimeoutReturnsOk)
{
    ProcessModeManager pm(deviceId, 0);
    uint32_t result = 0;
    uint64_t ptr = reinterpret_cast<uint64_t>(&result);
    MOCKER_CPP(&CapabilityManager::WaitRspForCapability).stubs().will(returnValue(static_cast<uint32_t>(1U)));
    EXPECT_EQ(pm.capabilityMgr_.WaitCapabilityRsp(TSD_CAPABILITY_LEVEL, ptr), TSD_OK);
    GlobalMockObject::verify();
}

TEST_F(CapabilityManagerTest, WaitCapabilityRsp_Success)
{
    ProcessModeManager pm(deviceId, 0);
    uint64_t result = 0;
    uint64_t ptr = reinterpret_cast<uint64_t>(&result);
    pm.capabilityMgr_.pidQos_ = 55;
    MOCKER_CPP(&CapabilityManager::WaitRspForCapability).stubs().will(returnValue(static_cast<uint32_t>(TSD_OK)));
    EXPECT_EQ(pm.capabilityMgr_.WaitCapabilityRsp(TSD_CAPABILITY_PIDQOS, ptr), TSD_OK);
    EXPECT_EQ(result, 55UL);
    GlobalMockObject::verify();
}

TEST_F(CapabilityManagerTest, CapabilityGet_NullPtr_Fail)
{
    ProcessModeManager pm(deviceId, 0);
    EXPECT_EQ(pm.capabilityMgr_.CapabilityGet(TSD_CAPABILITY_LEVEL, 0UL), TSD_CLT_OPEN_FAILED);
}

TEST_F(CapabilityManagerTest, CapabilityGet_PidQos_NotInit_ReturnsOk)
{
    ProcessModeManager pm(deviceId, 0);
    uint64_t result = 0;
    uint64_t ptr = reinterpret_cast<uint64_t>(&result);
    EXPECT_EQ(pm.capabilityMgr_.CapabilityGet(TSD_CAPABILITY_PIDQOS, ptr), TSD_OK);
}

TEST_F(CapabilityManagerTest, CapabilityGet_Level_UseStored_ReturnsOk)
{
    ProcessModeManager pm(deviceId, 0);
    pm.capabilityMgr_.tsdSupportLevel_ = 1U;
    uint32_t result = 0;
    uint64_t ptr = reinterpret_cast<uint64_t>(&result);
    EXPECT_EQ(pm.capabilityMgr_.CapabilityGet(TSD_CAPABILITY_LEVEL, ptr), TSD_OK);
    EXPECT_EQ(result, 1U);
}

TEST_F(CapabilityManagerTest, CapabilityGet_NotOkToGet_Fail)
{
    ProcessModeManager pm(deviceId, 0);
    pm.commAgent_.devCommClient_ = DeviceComm::GetInstance(deviceId, DeviceCommType::HDC);
    pm.capabilityMgr_.SetStartCpStatus(false);
    uint64_t result = 0;
    uint64_t ptr = reinterpret_cast<uint64_t>(&result);
    EXPECT_EQ(pm.capabilityMgr_.CapabilityGet(TSD_CAPABILITY_PIDQOS, ptr), TSD_CLT_OPEN_FAILED);
}
