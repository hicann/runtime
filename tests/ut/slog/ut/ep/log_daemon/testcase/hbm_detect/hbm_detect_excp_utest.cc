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

extern "C" {
extern int32_t HbmDetectGetResult(const CommHandle *handle);
}

class EP_HBM_DETECT_EXCP_UTEST : public testing::Test
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

TEST(EP_HBM_DETECT_EXCP_UTEST, HbmDetectHandleInvalid)
{
    OptHandle session = (OptHandle)0x123456;
    AmlHbmDetectInfo info = { 0 };
    info.magic = HBM_AML_MAGIC_NUM;
    info.version = HBM_AML_VERSION;
    info.operate = OPERATE_RUN;
    LogDataMsg *msg = (LogDataMsg *)malloc(sizeof(LogDataMsg) + sizeof(AmlHbmDetectInfo));
    (void)memcpy_s(msg->data, sizeof(AmlHbmDetectInfo), &info, sizeof(AmlHbmDetectInfo));
    int ret = HbmDetectProcess(NULL, (void*)msg, sizeof(LogDataMsg) + sizeof(AmlHbmDetectInfo));
    EXPECT_EQ(-1, ret);
    free(msg);
    GlobalMockObject::verify();
}

TEST(EP_HBM_DETECT_EXCP_UTEST, HbmDetectValueInvalid)
{
    OptHandle session = (OptHandle)0x123456;
    CommHandle handle = {COMM_HDC, session, COMPONENT_HBM_DETECT, -1, nullptr};
    int ret = HbmDetectProcess(&handle, NULL, sizeof(LogDataMsg) + sizeof(AmlHbmDetectInfo));
    EXPECT_EQ(-1, ret);
    GlobalMockObject::verify();
}

TEST(EP_HBM_DETECT_EXCP_UTEST, HbmDetectLengthInvalid)
{
    OptHandle session = (OptHandle)0x123456;
    CommHandle handle = {COMM_HDC, session, COMPONENT_HBM_DETECT, -1, nullptr};
    AmlHbmDetectInfo info = { 0 };
    info.magic = HBM_AML_MAGIC_NUM;
    info.version = HBM_AML_VERSION;
    info.operate = OPERATE_RUN;
    LogDataMsg *msg = (LogDataMsg *)malloc(sizeof(LogDataMsg) + sizeof(AmlHbmDetectInfo));
    (void)memcpy_s(msg->data, sizeof(AmlHbmDetectInfo), &info, sizeof(AmlHbmDetectInfo));
    int ret = HbmDetectProcess(&handle, (void*)msg, 0);
    EXPECT_EQ(-1, ret);
    free(msg);
    GlobalMockObject::verify();
}

TEST(EP_HBM_DETECT_EXCP_UTEST, HbmDetectMagicInvalid)
{
    OptHandle session = (OptHandle)0x123456;
    CommHandle handle = {COMM_HDC, session, COMPONENT_HBM_DETECT, -1, nullptr};
    AmlHbmDetectInfo info = { 0 };
    info.magic = HBM_AML_MAGIC_NUM + 1;
    info.version = HBM_AML_VERSION;
    info.operate = OPERATE_RUN;
    LogDataMsg *msg = (LogDataMsg *)malloc(sizeof(LogDataMsg) + sizeof(AmlHbmDetectInfo));
    (void)memcpy_s(msg->data, sizeof(AmlHbmDetectInfo), &info, sizeof(AmlHbmDetectInfo));
    MOCKER(ToolAccessWithMode).stubs().will(returnValue(0));
    int ret = HbmDetectProcess(&handle, (void*)msg, sizeof(LogDataMsg) + sizeof(AmlHbmDetectInfo));
    EXPECT_EQ(-1, ret);
    free(msg);
    GlobalMockObject::verify();
}

TEST(EP_HBM_DETECT_EXCP_UTEST, HbmDetectVersionInvalid)
{
    OptHandle session = (OptHandle)0x123456;
    CommHandle handle = {COMM_HDC, session, COMPONENT_HBM_DETECT, -1, nullptr};
    AmlHbmDetectInfo info = { 0 };
    info.magic = HBM_AML_MAGIC_NUM;
    info.version = HBM_AML_VERSION - 1;
    info.operate = OPERATE_RUN;
    LogDataMsg *msg = (LogDataMsg *)malloc(sizeof(LogDataMsg) + sizeof(AmlHbmDetectInfo));
    (void)memcpy_s(msg->data, sizeof(AmlHbmDetectInfo), &info, sizeof(AmlHbmDetectInfo));
    MOCKER(ToolAccessWithMode).stubs().will(returnValue(0));
    int ret = HbmDetectProcess(&handle, (void*)msg, sizeof(LogDataMsg) + sizeof(AmlHbmDetectInfo));
    EXPECT_EQ(-1, ret);
    free(msg);
    GlobalMockObject::verify();
}

TEST(EP_HBM_DETECT_EXCP_UTEST, HbmDetectHbmOperateInvalid)
{
    OptHandle session = (OptHandle)0x123456;
    CommHandle handle = {COMM_HDC, session, COMPONENT_HBM_DETECT, -1, nullptr};
    AmlHbmDetectInfo info = { 0 };
    info.magic = HBM_AML_MAGIC_NUM;
    info.version = HBM_AML_VERSION;
    info.operate = (AmlHbmOperate)9;
    LogDataMsg *msg = (LogDataMsg *)malloc(sizeof(LogDataMsg) + sizeof(AmlHbmDetectInfo));
    (void)memcpy_s(msg->data, sizeof(AmlHbmDetectInfo), &info, sizeof(AmlHbmDetectInfo));
    MOCKER(ToolAccessWithMode).stubs().will(returnValue(0));
    int ret = HbmDetectProcess(&handle, (void*)msg, sizeof(LogDataMsg) + sizeof(AmlHbmDetectInfo));
    EXPECT_EQ(-1, ret);
    free(msg);
    GlobalMockObject::verify();
}

drvError_t halHdcGetSessionAttrStatusClosed(HDC_SESSION session, int attr, int *value)
{
    (void)session;
    if (attr == HDC_SESSION_ATTR_STATUS) {
        *value = 2; // 1 connect; 2 closed
        return DRV_ERROR_NONE;
    }
    if (attr == HDC_SESSION_ATTR_RUN_ENV) {
        *value = 1; // 1 non-docker; 2 docker
        return DRV_ERROR_NONE;
    }
    return DRV_ERROR_NONE;
}

drvError_t halHdcGetSessionAttrRunEnvGetFailed(HDC_SESSION session, int attr, int *value)
{
    (void)session;
    if (attr == HDC_SESSION_ATTR_RUN_ENV) {
        *value = 1; // 1 non-docker; 2 docker
        return DRV_ERROR_NO_DEVICE;
    }
    return DRV_ERROR_NONE;
}

drvError_t halHdcGetSessionAttrStatusRunEnvDocker(HDC_SESSION session, int attr, int *value)
{
    (void)session;
    if (attr == HDC_SESSION_ATTR_RUN_ENV) {
        *value = 2; // 1 non-docker; 2 docker
        return DRV_ERROR_NONE;
    }
    return DRV_ERROR_NONE;
}

TEST(EP_HBM_DETECT_EXCP_UTEST, HbmDetectHandleGetRunEnvFailed)
{
    OptHandle session = (OptHandle)0x123456;
    CommHandle handle = {COMM_HDC, session, COMPONENT_HBM_DETECT, -1, nullptr};
    AmlHbmDetectInfo info = { 0 };
    info.magic = HBM_AML_MAGIC_NUM;
    info.version = HBM_AML_VERSION;
    info.operate = OPERATE_RUN_FREE;
    LogDataMsg *msg = (LogDataMsg *)malloc(sizeof(LogDataMsg) + sizeof(AmlHbmDetectInfo));
    (void)memcpy_s(msg->data, sizeof(AmlHbmDetectInfo), &info, sizeof(AmlHbmDetectInfo));
    MOCKER(ToolAccessWithMode).stubs().will(returnValue(0));
    MOCKER(halHdcGetSessionAttr).stubs().will(invoke(halHdcGetSessionAttrRunEnvGetFailed));
    int ret = HbmDetectProcess(&handle, (void*)msg, sizeof(LogDataMsg) + sizeof(AmlHbmDetectInfo));
    EXPECT_EQ(0, ret);
    free(msg);
    GlobalMockObject::verify();
}

TEST(EP_HBM_DETECT_EXCP_UTEST, HbmDetectHandleInDocker)
{
    OptHandle session = (OptHandle)0x123456;
    CommHandle handle = {COMM_HDC, session, COMPONENT_HBM_DETECT, -1, nullptr};
    AmlHbmDetectInfo info = { 0 };
    info.magic = HBM_AML_MAGIC_NUM;
    info.version = HBM_AML_VERSION;
    info.operate = OPERATE_RUN_FREE;
    LogDataMsg *msg = (LogDataMsg *)malloc(sizeof(LogDataMsg) + sizeof(AmlHbmDetectInfo));
    (void)memcpy_s(msg->data, sizeof(AmlHbmDetectInfo), &info, sizeof(AmlHbmDetectInfo));
    MOCKER(ToolAccessWithMode).stubs().will(returnValue(0));
    MOCKER(halHdcGetSessionAttr).stubs().will(invoke(halHdcGetSessionAttrStatusRunEnvDocker));
    int ret = HbmDetectProcess(&handle, (void*)msg, sizeof(LogDataMsg) + sizeof(AmlHbmDetectInfo));
    EXPECT_EQ(0, ret);
    free(msg);
    GlobalMockObject::verify();
}


TEST(EP_HBM_DETECT_EXCP_UTEST, HbmDetectHandleInterrupts)
{
    OptHandle session = (OptHandle)0x123456;
    CommHandle handle = {COMM_HDC, session, COMPONENT_HBM_DETECT, -1, nullptr};
    AmlHbmDetectInfo info = { 0 };
    info.magic = HBM_AML_MAGIC_NUM;
    info.version = HBM_AML_VERSION;
    info.operate = OPERATE_RUN_FREE;
    LogDataMsg *msg = (LogDataMsg *)malloc(sizeof(LogDataMsg) + sizeof(AmlHbmDetectInfo));
    (void)memcpy_s(msg->data, sizeof(AmlHbmDetectInfo), &info, sizeof(AmlHbmDetectInfo));
    MOCKER(ToolAccessWithMode).stubs().will(returnValue(0));
    MOCKER(halHdcGetSessionAttr).stubs().will(invoke(halHdcGetSessionAttrStatusClosed));
    int ret = HbmDetectProcess(&handle, (void*)msg, sizeof(LogDataMsg) + sizeof(AmlHbmDetectInfo));
    EXPECT_EQ(0, ret);
    free(msg);
    GlobalMockObject::verify();
}

TEST(EP_HBM_DETECT_EXCP_UTEST, HbmDetectCreateThreadFailed)
{
    OptHandle session = (OptHandle)0x123456;
    CommHandle handle = {COMM_HDC, session, COMPONENT_HBM_DETECT, -1, nullptr};
    AmlHbmDetectInfo info = { 0 };
    info.magic = HBM_AML_MAGIC_NUM;
    info.version = HBM_AML_VERSION;
    info.operate = OPERATE_RUN_FREE;
    LogDataMsg *msg = (LogDataMsg *)malloc(sizeof(LogDataMsg) + sizeof(AmlHbmDetectInfo));
    (void)memcpy_s(msg->data, sizeof(AmlHbmDetectInfo), &info, sizeof(AmlHbmDetectInfo));
    MOCKER(ToolAccessWithMode).stubs().will(returnValue(0));
    MOCKER(ToolCreateTaskWithThreadAttr).stubs().will(returnValue(-1));
    int ret = HbmDetectProcess(&handle, (void*)msg, sizeof(LogDataMsg) + sizeof(AmlHbmDetectInfo));
    EXPECT_EQ(-1, ret);
    free(msg);
    GlobalMockObject::verify();
}

TEST(EP_HBM_DETECT_EXCP_UTEST, HbmDetectHbmtesterNotExist)
{
    OptHandle session = (OptHandle)0x123456;
    CommHandle handle = {COMM_HDC, session, COMPONENT_HBM_DETECT, -1, nullptr};
    AmlHbmDetectInfo info = { 0 };
    info.magic = HBM_AML_MAGIC_NUM;
    info.version = HBM_AML_VERSION;
    info.operate = OPERATE_RUN_FREE;
    LogDataMsg *msg = (LogDataMsg *)malloc(sizeof(LogDataMsg) + sizeof(AmlHbmDetectInfo));
    (void)memcpy_s(msg->data, sizeof(AmlHbmDetectInfo), &info, sizeof(AmlHbmDetectInfo));
    MOCKER(ToolAccessWithMode).stubs().will(returnValue(-1));
    int ret = HbmDetectProcess(&handle, (void*)msg, sizeof(LogDataMsg) + sizeof(AmlHbmDetectInfo));
    EXPECT_EQ(-1, ret);
    free(msg);
    GlobalMockObject::verify();
}

TEST(EP_HBM_DETECT_EXCP_UTEST, HbmDetectSetThreadNameFailed)
{
    OptHandle session = (OptHandle)0x123456;
    CommHandle handle = {COMM_HDC, session, COMPONENT_HBM_DETECT, -1, nullptr};
    AmlHbmDetectInfo info = { 0 };
    info.magic = HBM_AML_MAGIC_NUM;
    info.version = HBM_AML_VERSION;
    info.operate = OPERATE_RUN_FREE;
    LogDataMsg *msg = (LogDataMsg *)malloc(sizeof(LogDataMsg) + sizeof(AmlHbmDetectInfo));
    (void)memcpy_s(msg->data, sizeof(AmlHbmDetectInfo), &info, sizeof(AmlHbmDetectInfo));
    MOCKER(ToolAccessWithMode).stubs().will(returnValue(0));
    MOCKER(ToolSetThreadName).stubs().will(returnValue(-1));
    int ret = HbmDetectProcess(&handle, (void*)msg, sizeof(LogDataMsg) + sizeof(AmlHbmDetectInfo));
    EXPECT_EQ(0, ret);
    free(msg);
    GlobalMockObject::verify();
}

TEST(EP_HBM_DETECT_EXCP_UTEST, HbmDetectSetAddrExeFailed)
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
    MOCKER(HbmDetectGetResult).stubs().will(returnValue(-1));
    int ret = HbmDetectProcess(&handle, (void*)msg, sizeof(LogDataMsg) + sizeof(AmlHbmDetectInfo));
    EXPECT_EQ(-1, ret);
    free(msg);
    GlobalMockObject::verify();
}

TEST(EP_HBM_DETECT_EXCP_UTEST, HbmDetectRunExeFailed)
{
    OptHandle session = (OptHandle)0x123456;
    CommHandle handle = {COMM_HDC, session, COMPONENT_HBM_DETECT, -1, nullptr};
    AmlHbmDetectInfo info = { 0 };
    info.magic = HBM_AML_MAGIC_NUM;
    info.version = HBM_AML_VERSION;
    info.operate = OPERATE_RUN;
    info.num = 1;
    info.info[0].startAddr = 0x123456;
    info.info[0].endAddr = 0x123456 + 0x1000;
    LogDataMsg *msg = (LogDataMsg *)malloc(sizeof(LogDataMsg) + sizeof(AmlHbmDetectInfo));
    (void)memcpy_s(msg->data, sizeof(AmlHbmDetectInfo), &info, sizeof(AmlHbmDetectInfo));
    MOCKER(ToolAccessWithMode).stubs().will(returnValue(0));
    MOCKER(HbmDetectGetResult).stubs().will(returnValue(-1));
    int ret = HbmDetectProcess(&handle, (void*)msg, sizeof(LogDataMsg) + sizeof(AmlHbmDetectInfo));
    EXPECT_EQ(-1, ret);
    free(msg);
    GlobalMockObject::verify();
}