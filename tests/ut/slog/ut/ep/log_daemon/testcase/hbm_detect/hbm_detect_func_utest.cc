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
#include "self_log_stub.h"
#include "log_daemon_stub.h"
#include "hbm_detect.h"
#include "log_drv.h"
#include "adcore_api.h"
using namespace std;
using namespace testing;
int32_t ServerCreateHbmDetectStub(ComponentType type, AdxComponentInit init, AdxComponentProcess process, AdxComponentUnInit uninit)
{
    return 0;
}
class EP_HBM_DETECT_FUNC_UTEST : public testing::Test
{
protected:
    virtual void SetUp()
    {
        system("echo [DBG][TEST][`date +%Y-%m-%d-%H-%M-%S`] Start test case");
        ResetErrLog();
    }

    virtual void TearDown()
    {
        EXPECT_EQ(0, GetErrLogNum());
        system("rm -rf " PATH_ROOT "/*");
        system("echo [DBG][TEST][`date +%Y-%m-%d-%H-%M-%S`] End test case");
        GlobalMockObject::verify();
    }

    static void SetUpTestCase()
    {
        system("rm -rf " PATH_ROOT);
        system("mkdir -p " PATH_ROOT);
        system("echo [DBG][TEST][`date +%Y-%m-%d-%H-%M-%S`] Start test suite");
    }

    static void TearDownTestCase()
    {
        system("rm -rf " PATH_ROOT);
        system("echo [DBG][TEST][`date +%Y-%m-%d-%H-%M-%S`] End test suite");
    }
};

TEST(EP_HBM_DETECT_FUNC_UTEST, HbmDetectRunFree)
{
    EXPECT_EQ(0, HbmDetectServerInit(ServerCreateHbmDetectStub));
    OptHandle session = (OptHandle)0x123456;
    CommHandle handle = {COMM_HDC, session, COMPONENT_HBM_DETECT, -1, nullptr};
    AmlHbmDetectInfo info = { 0 };
    info.magic = HBM_AML_MAGIC_NUM;
    info.version = HBM_AML_VERSION;
    info.operate = OPERATE_RUN_FREE;
    LogDataMsg *msg = (LogDataMsg *)malloc(sizeof(LogDataMsg) + sizeof(AmlHbmDetectInfo));
    (void)memcpy_s(msg->data, sizeof(AmlHbmDetectInfo), &info, sizeof(AmlHbmDetectInfo));
    MOCKER(ToolAccessWithMode).stubs().will(returnValue(0));
    int ret = HbmDetectProcess(&handle, (void*)msg, sizeof(LogDataMsg) + sizeof(AmlHbmDetectInfo));
    EXPECT_EQ(0, ret);
    free(msg);
}

TEST(EP_HBM_DETECT_FUNC_UTEST, HbmDetectSetAddr)
{
    OptHandle session = (OptHandle)0x123456;
    CommHandle handle = {COMM_HDC, session, COMPONENT_HBM_DETECT, -1, nullptr};
    AmlHbmDetectInfo info = { 0 };
    info.magic = HBM_AML_MAGIC_NUM;
    info.version = HBM_AML_VERSION;
    info.operate = OPERATE_SET_ADDR;
    info.num = 1;
    info.info[0].startAddr = 0x123456;
    info.info[0].endAddr = 0x123456 + 0x1000;
    LogDataMsg *msg = (LogDataMsg *)malloc(sizeof(LogDataMsg) + sizeof(AmlHbmDetectInfo));
    (void)memcpy_s(msg->data, sizeof(AmlHbmDetectInfo), &info, sizeof(AmlHbmDetectInfo));
    MOCKER(ToolAccessWithMode).stubs().will(returnValue(0));
    int ret = HbmDetectProcess(&handle, (void*)msg, sizeof(LogDataMsg) + sizeof(AmlHbmDetectInfo));
    EXPECT_EQ(0, ret);
    free(msg);
}

TEST(EP_HBM_DETECT_FUNC_UTEST, HbmDetectInit)
{
    EXPECT_EQ(0, HbmDetectInit());
}

TEST(EP_HBM_DETECT_FUNC_UTEST, HbmDetectDestroy)
{
    EXPECT_EQ(0, HbmDetectDestroy());
}
