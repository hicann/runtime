/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include <string>
#include <iostream>

#include "dlog_pub.h"
#include "plog.h"

#include <gtest/gtest.h>
#include <gmock/gmock.h>

#ifndef private
#define private public
#include "acl/acl.h"
#include "acl/acl_mdl.h"
#include "common/log_inner.h"
#include "common/json_parser.h"
#include "common/prof_reporter.h"
#include "toolchain/dump.h"
#include "toolchain/profiling.h"
#include "toolchain/profiling_manager.h"
#include "aprof_pub.h"
#include "acl/acl_prof.h"
#include "acl_stub.h"
#undef private
#endif

using namespace testing;
using namespace std;
using namespace acl;
using testing::Return;

std::vector<uint32_t> profTypeCnt;
#ifdef __cplusplus
extern "C" {
#endif

extern ACL_FUNC_VISIBILITY aclError aclmdlInitDump();
extern ACL_FUNC_VISIBILITY aclError aclmdlSetDump(const char *dumpCfgPath);
extern ACL_FUNC_VISIBILITY aclError aclmdlFinalizeDump();

typedef aclError (*aclDumpSetCallbackFunc)(const char *configStr);
extern ACL_FUNC_VISIBILITY aclError aclDumpSetCallbackRegister(aclDumpSetCallbackFunc cbFunc);
extern ACL_FUNC_VISIBILITY aclError aclDumpSetCallbackUnRegister();
typedef aclError (*aclDumpUnSetCallbackFunc)();
extern ACL_FUNC_VISIBILITY aclError aclDumpUnsetCallbackRegister(aclDumpUnSetCallbackFunc cbFunc);
extern ACL_FUNC_VISIBILITY aclError aclDumpUnsetCallbackUnRegister();

#ifdef __cplusplus
}
#endif

namespace acl {
extern void resetAclJsonHash();
}

class UTEST_ACL_toolchain : public testing::Test
{
    public:
        UTEST_ACL_toolchain(){}
    protected:
        virtual void SetUp() {}
        virtual void TearDown() {
            Mock::VerifyAndClear((void *)(&MockFunctionTest::aclStubInstance()));
        }
        static void SetUpTestCase() {
            resetAclJsonHash();
            (void)aclInit(nullptr);
        }
        static void TearDownTestCase()
        {
            (void)aclFinalize();
        }
};

static int32_t MsprofRegTypeInfoStub(uint16_t level, uint32_t typeId, const char *typeName)
{
    (void) level;
    (void) typeId;
    (void) typeName;
    return 2;
}

static int32_t MsprofRegTypeInfoStub2(uint16_t level, uint32_t typeId, const char *typeName)
{
    (void) level;
    (void) typeName;
    if ((typeId > MSPROF_REPORT_ACL_RUNTIME_BASE_TYPE) && (typeId < MSPROF_REPORT_ACL_OTHERS_BASE_TYPE)) {
        return 2;
    }
    return 0;
}

static int32_t MsprofRegTypeInfoStubForCnt(uint16_t level, uint32_t typeId, const char *typeName)
{
    (void) level;
    (void) typeName;
    profTypeCnt.emplace_back(typeId);
    return 0;
}

static int AdxDataDumpServerInitInvoke()
{
    int initRet = 1;
    return initRet;
}

TEST_F(UTEST_ACL_toolchain, dumpInitFailed)
{
    acl::AclDump::GetInstance().adxInitFromAclInitFlag_ = true;
    EXPECT_CALL(MockFunctionTest::aclStubInstance(), AdxDataDumpServerInit())
        .WillRepeatedly(Invoke(AdxDataDumpServerInitInvoke));
    aclError ret = aclmdlInitDump();
    EXPECT_EQ(ret, ACL_ERROR_INTERNAL_ERROR);
}

aclError DumpSetCallbackFunc(const char *configStr)
{
    (void)configStr;
    return ACL_ERROR_INTERNAL_ERROR;
}

TEST_F(UTEST_ACL_toolchain, dumpParamTest)
{
    acl::AclDump aclDump;
    acl::AclDump::GetInstance().adxInitFromAclInitFlag_ = false;
    aclError ret = aclmdlInitDump();
    EXPECT_EQ(ret, ACL_SUCCESS);

    acl::AclDump::GetInstance().adxInitFromAclInitFlag_ = false;
    ret = aclmdlSetDump(ACL_BASE_DIR "/tests/ut/acl/json/testDump1.json");
    EXPECT_EQ(ret, ACL_SUCCESS);

    // aclInit dump
    ret = aclDump.HandleDumpConfig(ACL_BASE_DIR "/tests/ut/acl/json/dumpConfig.json");
    EXPECT_EQ(ret, ACL_SUCCESS);

    ret = aclDump.HandleDumpConfig(ACL_BASE_DIR "/tests/ut/acl/json/testDump_DumpLevelOp.json");
    EXPECT_EQ(ret, ACL_SUCCESS);

    ret = aclDump.HandleDumpConfig(ACL_BASE_DIR "/tests/ut/acl/json/testDump_DumpLevelKernel.json");
    EXPECT_EQ(ret, ACL_SUCCESS);

    EXPECT_CALL(MockFunctionTest::aclStubInstance(), AdumpSetDump(_, _)).WillOnce(Return(1));
    ret = aclDump.HandleDumpConfig(ACL_BASE_DIR "/tests/ut/acl/json/testDump_DumpLevelKernel.json");
    EXPECT_NE(ret, ACL_SUCCESS);
}

TEST_F(UTEST_ACL_toolchain, dumpNotInitTest)
{
    aclmdlFinalizeDump();
    aclError ret = aclmdlSetDump("llt/acl/ut/json/dumpConfig.json");
    EXPECT_NE(ret, ACL_SUCCESS);
    EXPECT_NE(aclmdlFinalizeDump(), ACL_SUCCESS);
}

TEST_F(UTEST_ACL_toolchain, repeatExecuteAclmdlInitDumpTest)
{
    acl::AclDump::GetInstance().adxInitFromAclInitFlag_ = false;
    aclError ret = aclmdlInitDump();
    EXPECT_EQ(ret, ACL_SUCCESS);
    EXPECT_NE(aclmdlInitDump(), ACL_SUCCESS);
    ret = aclmdlFinalizeDump();
    EXPECT_EQ(ret, ACL_SUCCESS);
}

TEST_F(UTEST_ACL_toolchain, AdumpSetDumpFailedTest)
{
    acl::AclDump::GetInstance().adxInitFromAclInitFlag_ = false;
    aclError ret = aclmdlInitDump();
    EXPECT_EQ(ret, ACL_SUCCESS);

    EXPECT_CALL(MockFunctionTest::aclStubInstance(), AdumpSetDump(_, _)).WillOnce(Return(1));
    ret = aclmdlSetDump(ACL_BASE_DIR "/tests/ut/acl/json/dumpConfig.json");
    EXPECT_NE(ret, ACL_SUCCESS);

    Mock::VerifyAndClear((void *) (&MockFunctionTest::aclStubInstance()));
    ret = aclmdlFinalizeDump();
    EXPECT_EQ(ret, ACL_SUCCESS);
}

TEST_F(UTEST_ACL_toolchain, dumpFinalizeFailedTest)
{
    acl::AclDump::GetInstance().adxInitFromAclInitFlag_ = false;
    aclError ret = aclmdlInitDump();
    EXPECT_EQ(ret, ACL_SUCCESS);

    // Clear dump config failed in aclmdlFinalizeDump
    EXPECT_CALL(MockFunctionTest::aclStubInstance(), AdumpUnSetDump()).WillOnce(Return((1)));
    ret = aclmdlFinalizeDump();
    EXPECT_NE(ret, ACL_SUCCESS);
    Mock::VerifyAndClear((void *) (&MockFunctionTest::aclStubInstance()));

    // kill dump server failed
    EXPECT_CALL(MockFunctionTest::aclStubInstance(), AdxDataDumpServerUnInit()).WillOnce(Return(1));
    ret = aclmdlFinalizeDump();
    EXPECT_EQ(ret, ACL_ERROR_INTERNAL_ERROR);

    Mock::VerifyAndClear((void *) (&MockFunctionTest::aclStubInstance()));
    (void) aclmdlFinalizeDump();  // to acl dump init flag
}

TEST_F(UTEST_ACL_toolchain, LiteExceptionDumpTest)
{
    acl::AclDump aclDump;
    acl::AclDump::GetInstance().adxInitFromAclInitFlag_ = false;
    auto ret = aclDump.HandleDumpConfig(ACL_BASE_DIR "/tests/ut/acl/json/testLiteExceptionDump.json");
    EXPECT_EQ(ret, ACL_SUCCESS);

    ret = aclDump.HandleDumpConfig(ACL_BASE_DIR "/tests/ut/acl/json/testLiteException_debug_off.json");
    EXPECT_EQ(ret, ACL_SUCCESS);
}

TEST_F(UTEST_ACL_toolchain, ExceptionDumpTest)
{
    acl::AclDump aclDump;
    aclError ret;
    acl::AclDump::GetInstance().adxInitFromAclInitFlag_ = false;
    ret = aclDump.HandleDumpConfig(ACL_BASE_DIR "/tests/ut/acl/json/testExceptionDump_brief.json");
    EXPECT_EQ(ret, ACL_SUCCESS);
    EXPECT_EQ(acl::AclDump::GetInstance().adxInitFromAclInitFlag_, true);
}

TEST_F(UTEST_ACL_toolchain, FinalizeDumpTest)
{
    aclError ret;
    ret = aclmdlInitDump();
    EXPECT_EQ(ret, ACL_SUCCESS);

    ret = aclmdlSetDump(ACL_BASE_DIR "/tests/ut/acl/json/testExceptionDump_brief.json");
    EXPECT_EQ(ret, ACL_SUCCESS);

    ret = aclmdlFinalizeDump();
    EXPECT_EQ(ret, ACL_SUCCESS);
}

TEST_F(UTEST_ACL_toolchain, FinalizeDumpTest_AdumpSetDumpConfig_Failed)
{
    aclError ret;
    ret = aclmdlInitDump();
    EXPECT_EQ(ret, ACL_SUCCESS);

    ret = aclmdlSetDump(ACL_BASE_DIR "/tests/ut/acl/json/testExceptionDump_brief.json");
    EXPECT_EQ(ret, ACL_SUCCESS);

    EXPECT_CALL(MockFunctionTest::aclStubInstance(), AdumpUnSetDump()).WillOnce(Return(1));
    ret = aclmdlFinalizeDump();
    EXPECT_NE(ret, ACL_SUCCESS);

    Mock::VerifyAndClear((void *) (&MockFunctionTest::aclStubInstance()));
    ret = aclmdlFinalizeDump();
    EXPECT_EQ(ret, ACL_SUCCESS);
}
// ========================== profiling testcase =============================

TEST_F(UTEST_ACL_toolchain, setDeviceSuccess)
{
    acl::AclProfilingManager aclProfManager;
    uint32_t deviceIdList[] = {1, 2, 3};
    aclError ret = aclProfManager.AddDeviceList(nullptr, 0);
    EXPECT_EQ(ret, ACL_SUCCESS);
    ret = aclProfManager.AddDeviceList(deviceIdList, 3);
    EXPECT_EQ(ret, ACL_SUCCESS);
    ret = aclProfManager.RemoveDeviceList(nullptr, 0);
    EXPECT_EQ(ret, ACL_SUCCESS);
    ret = aclProfManager.RemoveDeviceList(deviceIdList, 3);
    EXPECT_EQ(ret, ACL_SUCCESS);
}

TEST_F(UTEST_ACL_toolchain, AclProfilingManagerInitFailed)
{
    EXPECT_CALL(MockFunctionTest::aclStubInstance(), MsprofRegTypeInfo(_,_,_))
    .WillRepeatedly(Return(2));
    acl::AclProfilingManager aclProfManager;
    aclError ret = aclProfManager.Init();
    EXPECT_NE(ret, ACL_SUCCESS);
}

TEST_F(UTEST_ACL_toolchain, HandleProfilingConfig)
{
    acl::AclProfiling aclProf;
    aclError ret = aclProf.HandleProfilingConfig(nullptr);
    EXPECT_EQ(ret, ACL_SUCCESS);

    ret = aclProf.HandleProfilingConfig(ACL_BASE_DIR "/tests/ut/acl/json/profConfig.json");
    EXPECT_EQ(ret, ACL_SUCCESS);

    ret = aclProf.HandleProfilingConfig(ACL_BASE_DIR "/tests/ut/acl/json/profilingConfig.json");
    EXPECT_EQ(ret, ACL_SUCCESS);
}

TEST_F(UTEST_ACL_toolchain, HandleProfilingCommand)
{
    acl::AclProfiling aclprof;
    const string config = "test";
    bool configFileFlag = false;
    bool noValidConfig = false;
    EXPECT_CALL(MockFunctionTest::aclStubInstance(), MsprofInit(_,_,_))
        .WillRepeatedly(Return(1));
    EXPECT_CALL(MockFunctionTest::aclStubInstance(), MsprofInit(_,_,_))
    .WillRepeatedly(Return(1));
    aclError ret = aclprof.HandleProfilingCommand(config, configFileFlag, noValidConfig);
    EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);

    configFileFlag = true;
    noValidConfig = false;
    ret = aclprof.HandleProfilingCommand(config, configFileFlag, noValidConfig);
    EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);
}

int32_t MsprofReporterCallbackImpl(uint32_t moduleId, uint32_t type, void *data, uint32_t len)
{
    (void) moduleId;
    (void) type;
    (void) data;
    (void) len;
    return 0;
}

TEST_F(UTEST_ACL_toolchain, MsprofCtrlHandle)
{
    EXPECT_CALL(MockFunctionTest::aclStubInstance(), MsprofRegTypeInfo(_,_,_))
    .WillRepeatedly(Return(2));
    rtProfCommandHandle_t command;
    command.profSwitch = 1;
    command.devNums = 1;
    command.devIdList[0] = 0;
    command.type = 1;
    auto ret = AclProfCtrlHandle(RT_PROF_CTRL_SWITCH, static_cast<void *>(&command), sizeof(rtProfCommandHandle_t));
    EXPECT_NE(ret, ACL_SUCCESS);

    ret = AclProfCtrlHandle(RT_PROF_CTRL_SWITCH, static_cast<void *>(&command), sizeof(rtProfCommandHandle_t) - 1);
    EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);
}

TEST_F(UTEST_ACL_toolchain, AclProfilingReporter)
{
    AclProfilingManager::GetInstance().isProfiling_ = true;
    AclProfilingManager::GetInstance().deviceList_.insert(-1);
    AclProfilingManager::GetInstance().deviceList_.insert(0);
    AclProfilingReporter reporter(acl::AclProfType::AclrtCreateStream);
    EXPECT_EQ(reporter.aclApi_, acl::AclProfType::AclrtCreateStream);
    reporter.~AclProfilingReporter();
    AclProfilingReporter reporter1(acl::AclProfType::AclmdlRIExecuteAsync);
    EXPECT_EQ(reporter1.aclApi_, acl::AclProfType::AclmdlRIExecuteAsync);
    reporter1.~AclProfilingReporter();
    AclProfilingManager::GetInstance().isProfiling_ = false;
    AclProfilingManager::GetInstance().deviceList_.erase(-1);
    AclProfilingManager::GetInstance().deviceList_.erase(0);
}

TEST_F(UTEST_ACL_toolchain, AclProfilingReporter_2)
{
    AclProfilingManager::GetInstance().isProfiling_ = true;
    AclProfilingManager::GetInstance().deviceList_.insert(-1);
    AclProfilingManager::GetInstance().deviceList_.insert(0);
    AclProfilingReporter reporter(acl::AclProfType::AclrtCreateStream);
    EXPECT_EQ(reporter.aclApi_, acl::AclProfType::AclrtCreateStream);
    reporter.~AclProfilingReporter();
    AclProfilingManager::GetInstance().isProfiling_ = false;
    AclProfilingManager::GetInstance().deviceList_.erase(-1);
    AclProfilingManager::GetInstance().deviceList_.erase(0);
}

TEST_F(UTEST_ACL_toolchain, AclProfilingReporter_3)
{
    AclProfilingManager::GetInstance().isProfiling_ = true;
    AclProfilingManager::GetInstance().deviceList_.insert(-1);
    AclProfilingManager::GetInstance().deviceList_.insert(0);
    AclProfilingReporter reporter(acl::AclProfType::AclrtCreateStream);
    EXPECT_EQ(reporter.aclApi_, acl::AclProfType::AclrtCreateStream);
    reporter.~AclProfilingReporter();
    AclProfilingManager::GetInstance().isProfiling_ = false;
    AclProfilingManager::GetInstance().deviceList_.erase(-1);
    AclProfilingManager::GetInstance().deviceList_.erase(0);
}

TEST_F(UTEST_ACL_toolchain, AclProfilingReporter_4)
{
    EXPECT_CALL(MockFunctionTest::aclStubInstance(), MsprofRegTypeInfo(_,_,_))
    .WillRepeatedly(Return(0));
    EXPECT_EQ(AclProfilingManager::GetInstance().Init(), ACL_SUCCESS);
}

TEST_F(UTEST_ACL_toolchain, AclProfilingReporter_5)
{
    EXPECT_CALL(MockFunctionTest::aclStubInstance(), MsprofRegTypeInfo(_,_,_))
    .WillRepeatedly(Invoke(MsprofRegTypeInfoStub));
    EXPECT_NE(AclProfilingManager::GetInstance().Init(), ACL_SUCCESS);
}

TEST_F(UTEST_ACL_toolchain, AclProfilingReporter_6)
{
    EXPECT_CALL(MockFunctionTest::aclStubInstance(), MsprofRegTypeInfo(_,_,_))
    .WillRepeatedly(Invoke(MsprofRegTypeInfoStub2));
    EXPECT_NE(AclProfilingManager::GetInstance().Init(), ACL_SUCCESS);
}

TEST_F(UTEST_ACL_toolchain, AclProfiling_PROF_TYPE_TO_NAMES)
{
    EXPECT_CALL(MockFunctionTest::aclStubInstance(), MsprofRegTypeInfo(_,_,_))
    .WillRepeatedly(Invoke(MsprofRegTypeInfoStubForCnt));
    AclProfilingManager::GetInstance().RegisterProfilingType();
    size_t cnt = (AclProfType::AclRtProfTypeEnd - AclProfType::AclRtProfTypeStart - 1);
    EXPECT_EQ(profTypeCnt.size(), cnt);
}
