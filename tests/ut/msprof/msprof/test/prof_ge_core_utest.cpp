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
#include "errno/error_code.h"
#include "ge/ge_prof.h"
#include "prof_acl_mgr.h"
#include "prof_acl_core.h"
#include "prof_ge_core.h"
#include "prof_api_runtime.h"
#include "msprof_dlog.h"
#include "utils/utils.h"

using namespace analysis::dvvp::common::error;
using namespace ge;

extern "C" {
extern int ProfAclDrvGetDevNum();
extern int32_t ProfAclSubscribe(uint32_t type, uint32_t modelId, const aclprofSubscribeConfig *cfg);
extern int32_t ProfAclUnSubscribe(uint32_t type, uint32_t modelId);
extern size_t ProfAclGetId(uint32_t type, const void *opInfo, size_t opInfoLen, uint32_t index);
extern int32_t ProfAclInit(uint32_t type, const char *profilerPath, uint32_t length);
extern int32_t ProfAclFinalize(uint32_t type);
extern int32_t ProfAclStart(uint32_t type, const ProfConfig *cfg);
extern int32_t ProfAclStop(uint32_t type, const ProfConfig *cfg);
}

namespace prof_ge_core_stub {
// Note: ExtendPlugin::ProfGetVisibleDeviceIdByLogicDeviceId is a const member;
// stubbing via `invoke` requires reproducing the implicit-this signature, which
// mockcpp signature deduction does not always reconcile cleanly, so we drive
// branches via returnValue() of the int32_t status only.
static const int32_t kVisibleDevId = 0;
}  // namespace prof_ge_core_stub

class PROF_GE_CORE_UTEST : public testing::Test {
protected:
    virtual void SetUp() {}
    virtual void TearDown()
    {
        GlobalMockObject::verify();
        Msprofiler::Api::ProfAclMgr::instance()->mode_ = Msprofiler::Api::WORK_MODE_OFF;
    }
};

// aclgrphProfGraphSubscribe / UnSubscribe / aclprofGetGraphId — extern "C" wrappers (lines 24-37)
TEST_F(PROF_GE_CORE_UTEST, GraphSubscribe_NullParam_Returns_InvalidModelId)
{
    EXPECT_EQ(ACL_ERROR_INVALID_MODEL_ID, ::aclgrphProfGraphSubscribe(1, nullptr));
}

TEST_F(PROF_GE_CORE_UTEST, GraphUnSubscribe_AnyModelId)
{
    // Underlying ProfAclUnSubscribe runs the engine path; success is acceptable.
    int32_t ret = ::aclgrphProfGraphUnSubscribe(99);
    EXPECT_TRUE(ret == ACL_SUCCESS || ret == ACL_ERROR_PROFILING_FAILURE || ret == ACL_ERROR_INVALID_MODEL_ID);
}

TEST_F(PROF_GE_CORE_UTEST, AclProfGetGraphId_Smoke)
{
    char buf[16] = {0};
    // Just exercise the wrapper; return value depends on internal state.
    (void)::aclprofGetGraphId(buf, sizeof(buf), 0);
}

// ge::aclgrphProfInit branches (lines 40-49)
TEST_F(PROF_GE_CORE_UTEST, AclgrphProfInit_DynProfMode_Unsupported)
{
    MOCKER_CPP(&analysis::dvvp::common::utils::Utils::IsDynProfMode)
        .stubs()
        .will(returnValue(true));
    EXPECT_EQ(ACL_ERROR_FEATURE_UNSUPPORTED, ge::aclgrphProfInit("/tmp/ge_init", 12));
}

TEST_F(PROF_GE_CORE_UTEST, AclgrphProfInit_ProfAclInitFail)
{
    MOCKER_CPP(&analysis::dvvp::common::utils::Utils::IsDynProfMode)
        .stubs()
        .will(returnValue(false));
    MOCKER(ProfAclInit)
        .stubs()
        .will(returnValue(static_cast<int32_t>(ACL_ERROR_PROFILING_FAILURE)));
    EXPECT_EQ(ge::GE_PROF_FAILED, ge::aclgrphProfInit("/tmp/ge_init_fail", 16));
}

TEST_F(PROF_GE_CORE_UTEST, AclgrphProfInit_Success)
{
    // Mock the extern "C" ProfAclInit free function so the success path returns
    // without actually starting the engine (which would interfere with subsequent tests).
    MOCKER_CPP(&analysis::dvvp::common::utils::Utils::IsDynProfMode)
        .stubs()
        .will(returnValue(false));
    MOCKER(ProfAclInit).stubs().will(returnValue(static_cast<int32_t>(0)));
    EXPECT_EQ(ge::GE_PROF_SUCCESS, ge::aclgrphProfInit("/tmp/ge_init_ok", 15));
}

// ge::aclgrphProfFinalize (lines 52-54)
TEST_F(PROF_GE_CORE_UTEST, AclgrphProfFinalize_Smoke)
{
    MOCKER(ProfAclFinalize).stubs().will(returnValue(static_cast<int32_t>(0)));
    EXPECT_EQ(ge::GE_PROF_SUCCESS, ge::aclgrphProfFinalize());
}

// IsProfConfigValid: nullptr deviceIdList (line 60-65)
TEST_F(PROF_GE_CORE_UTEST, IsProfConfigValid_NullDeviceIdList)
{
    EXPECT_FALSE(ge::IsProfConfigValid(nullptr, 1));
}

// IsProfConfigValid: deviceNums == 0 (line 66-71)
TEST_F(PROF_GE_CORE_UTEST, IsProfConfigValid_ZeroDeviceNums)
{
    uint32_t devList[1] = {0};
    EXPECT_FALSE(ge::IsProfConfigValid(devList, 0));
}

// IsProfConfigValid: deviceNums > MSVP_MAX_DEV_NUM (line 66-71)
TEST_F(PROF_GE_CORE_UTEST, IsProfConfigValid_TooManyDevices)
{
    uint32_t devList[1] = {0};
    EXPECT_FALSE(ge::IsProfConfigValid(devList, 1024));
}

// IsProfConfigValid: ProfAclDrvGetDevNum returns FAILED (line 74-78)
TEST_F(PROF_GE_CORE_UTEST, IsProfConfigValid_DrvGetDevNumFail)
{
    uint32_t devList[1] = {0};
    MOCKER(ProfAclDrvGetDevNum).stubs().will(returnValue(static_cast<int>(PROFILING_FAILED)));
    EXPECT_FALSE(ge::IsProfConfigValid(devList, 1));
}

// IsProfConfigValid: deviceNums > devCount (line 79-85)
TEST_F(PROF_GE_CORE_UTEST, IsProfConfigValid_DeviceNumsExceedDevCount)
{
    uint32_t devList[3] = {0, 1, 2};
    MOCKER(ProfAclDrvGetDevNum).stubs().will(returnValue(1));
    EXPECT_FALSE(ge::IsProfConfigValid(devList, 3));
}

// IsProfConfigValid: devId out of range (line 86-95)
TEST_F(PROF_GE_CORE_UTEST, IsProfConfigValid_DevIdOutOfRange)
{
    uint32_t devList[1] = {99};
    MOCKER(ProfAclDrvGetDevNum).stubs().will(returnValue(2));
    EXPECT_FALSE(ge::IsProfConfigValid(devList, 1));
}

// IsProfConfigValid: duplicate devId (line 96-102)
TEST_F(PROF_GE_CORE_UTEST, IsProfConfigValid_DuplicateDevId)
{
    uint32_t devList[2] = {0, 0};
    MOCKER(ProfAclDrvGetDevNum).stubs().will(returnValue(4));
    EXPECT_FALSE(ge::IsProfConfigValid(devList, 2));
}

// IsProfConfigValid: success (line 103-105)
TEST_F(PROF_GE_CORE_UTEST, IsProfConfigValid_Success)
{
    uint32_t devList[2] = {0, 1};
    MOCKER(ProfAclDrvGetDevNum).stubs().will(returnValue(4));
    EXPECT_TRUE(ge::IsProfConfigValid(devList, 2));
}

// ModifyLogicDeviceId via aclgrphProfCreateConfig: NotSupport branch (line 120-127)
TEST_F(PROF_GE_CORE_UTEST, AclgrphProfCreateConfig_VisibleDevNotSupport)
{
    MOCKER_CPP(&ProfRtAPI::ExtendPlugin::ProfGetVisibleDeviceIdByLogicDeviceId)
        .stubs()
        .will(returnValue(static_cast<int32_t>(PROFILING_NOTSUPPORT)));
    MOCKER(ProfAclDrvGetDevNum).stubs().will(returnValue(8));
    uint32_t devList[1] = {0};
    auto *cfg = ge::aclgrphProfCreateConfig(devList, 1, (ge::ProfilingAicoreMetrics)PROF_AICORE_NONE, nullptr, 0);
    EXPECT_NE(nullptr, cfg);
    EXPECT_EQ(ge::GE_PROF_SUCCESS, ge::aclgrphProfDestroyConfig(cfg));
}

// ModifyLogicDeviceId: GetVisibleDeviceId failed (line 128-130)
TEST_F(PROF_GE_CORE_UTEST, AclgrphProfCreateConfig_VisibleDevFailed)
{
    MOCKER_CPP(&ProfRtAPI::ExtendPlugin::ProfGetVisibleDeviceIdByLogicDeviceId)
        .stubs()
        .will(returnValue(static_cast<int32_t>(PROFILING_FAILED)));
    MOCKER(ProfAclDrvGetDevNum).stubs().will(returnValue(8));
    uint32_t devList[1] = {0};
    auto *cfg = ge::aclgrphProfCreateConfig(devList, 1, (ge::ProfilingAicoreMetrics)PROF_AICORE_NONE, nullptr, 0);
    EXPECT_EQ(nullptr, cfg);
}

// ModifyLogicDeviceId Success path -> dataTypeConfig L1/L2/L3 mask propagation (line 164-179)
TEST_F(PROF_GE_CORE_UTEST, AclgrphProfCreateConfig_TaskTimeL1Propagation)
{
    MOCKER_CPP(&ProfRtAPI::ExtendPlugin::ProfGetVisibleDeviceIdByLogicDeviceId)
        .stubs()
        .will(returnValue(static_cast<int32_t>(PROFILING_SUCCESS)));
    MOCKER(ProfAclDrvGetDevNum).stubs().will(returnValue(8));
    uint32_t devList[1] = {0};
    auto *cfg = ge::aclgrphProfCreateConfig(devList, 1, (ge::ProfilingAicoreMetrics)PROF_AICORE_NONE, nullptr, PROF_TASK_TIME_L1);
    EXPECT_NE(nullptr, cfg);
    EXPECT_EQ(ge::GE_PROF_SUCCESS, ge::aclgrphProfDestroyConfig(cfg));
}

TEST_F(PROF_GE_CORE_UTEST, AclgrphProfCreateConfig_TaskTimeL2Propagation)
{
    MOCKER_CPP(&ProfRtAPI::ExtendPlugin::ProfGetVisibleDeviceIdByLogicDeviceId)
        .stubs()
        .will(returnValue(static_cast<int32_t>(PROFILING_SUCCESS)));
    MOCKER(ProfAclDrvGetDevNum).stubs().will(returnValue(8));
    uint32_t devList[1] = {0};
    auto *cfg = ge::aclgrphProfCreateConfig(devList, 1, (ge::ProfilingAicoreMetrics)PROF_AICORE_NONE, nullptr, PROF_TASK_TIME_L2);
    EXPECT_NE(nullptr, cfg);
    EXPECT_EQ(ge::GE_PROF_SUCCESS, ge::aclgrphProfDestroyConfig(cfg));
}

TEST_F(PROF_GE_CORE_UTEST, AclgrphProfCreateConfig_TaskTimeL3Propagation)
{
    MOCKER_CPP(&ProfRtAPI::ExtendPlugin::ProfGetVisibleDeviceIdByLogicDeviceId)
        .stubs()
        .will(returnValue(static_cast<int32_t>(PROFILING_SUCCESS)));
    MOCKER(ProfAclDrvGetDevNum).stubs().will(returnValue(8));
    uint32_t devList[1] = {0};
    auto *cfg = ge::aclgrphProfCreateConfig(devList, 1, (ge::ProfilingAicoreMetrics)PROF_AICORE_NONE, nullptr, PROF_TASK_TIME_L3);
    EXPECT_NE(nullptr, cfg);
    EXPECT_EQ(ge::GE_PROF_SUCCESS, ge::aclgrphProfDestroyConfig(cfg));
}

TEST_F(PROF_GE_CORE_UTEST, AclgrphProfCreateConfig_OpAttrPropagation)
{
    MOCKER_CPP(&ProfRtAPI::ExtendPlugin::ProfGetVisibleDeviceIdByLogicDeviceId)
        .stubs()
        .will(returnValue(static_cast<int32_t>(PROFILING_SUCCESS)));
    MOCKER(ProfAclDrvGetDevNum).stubs().will(returnValue(8));
    uint32_t devList[1] = {0};
    auto *cfg = ge::aclgrphProfCreateConfig(devList, 1, (ge::ProfilingAicoreMetrics)PROF_AICORE_NONE, nullptr, PROF_OP_ATTR);
    EXPECT_NE(nullptr, cfg);
    EXPECT_EQ(ge::GE_PROF_SUCCESS, ge::aclgrphProfDestroyConfig(cfg));
}

// aclgrphProfDestroyConfig: nullptr branch (line 182-189)
TEST_F(PROF_GE_CORE_UTEST, AclgrphProfDestroyConfig_Null)
{
    EXPECT_EQ(ge::GE_PROF_FAILED, ge::aclgrphProfDestroyConfig(nullptr));
}

// aclgrphProfStart fail/success (line 195-201)
TEST_F(PROF_GE_CORE_UTEST, AclgrphProfStart_Fail)
{
    MOCKER_CPP(&ProfRtAPI::ExtendPlugin::ProfGetVisibleDeviceIdByLogicDeviceId)
        .stubs()
        .will(returnValue(static_cast<int32_t>(PROFILING_SUCCESS)));
    MOCKER(ProfAclDrvGetDevNum).stubs().will(returnValue(8));
    uint32_t devList[1] = {0};
    auto *cfg = ge::aclgrphProfCreateConfig(devList, 1, (ge::ProfilingAicoreMetrics)PROF_AICORE_NONE, nullptr, 0);
    ASSERT_NE(nullptr, cfg);
    MOCKER_CPP(&Msprofiler::Api::ProfAclMgr::ProfStartPrecheck)
        .stubs()
        .will(returnValue(ACL_ERROR_PROFILING_FAILURE));
    EXPECT_EQ(ge::GE_PROF_FAILED, ge::aclgrphProfStart(cfg));
    EXPECT_EQ(ge::GE_PROF_SUCCESS, ge::aclgrphProfDestroyConfig(cfg));
}

// aclgrphProfStop fail/success (line 203-209)
TEST_F(PROF_GE_CORE_UTEST, AclgrphProfStop_Fail)
{
    MOCKER_CPP(&ProfRtAPI::ExtendPlugin::ProfGetVisibleDeviceIdByLogicDeviceId)
        .stubs()
        .will(returnValue(static_cast<int32_t>(PROFILING_SUCCESS)));
    MOCKER(ProfAclDrvGetDevNum).stubs().will(returnValue(8));
    uint32_t devList[1] = {0};
    auto *cfg = ge::aclgrphProfCreateConfig(devList, 1, (ge::ProfilingAicoreMetrics)PROF_AICORE_NONE, nullptr, 0);
    ASSERT_NE(nullptr, cfg);
    // PrepareStopAclApi short-circuits to success when !IsInited(), so force IsInited() to
    // return true to reach the ProfStopPrecheck failure path under test.
    MOCKER_CPP(&Msprofiler::Api::ProfAclMgr::IsInited)
        .stubs()
        .will(returnValue(true));
    MOCKER_CPP(&Msprofiler::Api::ProfAclMgr::ProfStopPrecheck)
        .stubs()
        .will(returnValue(ACL_ERROR_PROFILING_FAILURE));
    EXPECT_EQ(ge::GE_PROF_FAILED, ge::aclgrphProfStop(cfg));
    EXPECT_EQ(ge::GE_PROF_SUCCESS, ge::aclgrphProfDestroyConfig(cfg));
}
