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

#include "log_session_manage.h"
#include "log_sys_report.h"
#include "log_sys_get.h"
using namespace std;
using namespace testing;

extern "C" {
    //  extern
}

class EP_SLOGD_SESSION_MGR_FUNC_UTEST : public testing::Test
{
protected:
    virtual void SetUp()
    {
        system("echo [DBG][TEST][`date +%Y-%m-%d-%H-%M-%S`] Start test case");
        ResetErrLog();
    }
 
    virtual void TearDown()
    {
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

#define SESSION_MESSAGE    "session_message"
TEST_F(EP_SLOGD_SESSION_MGR_FUNC_UTEST, ContinuousSession)
{
    AdxCommHandle session = static_cast<AdxCommHandle>(LogMalloc(sizeof(CommHandle)));
    session->type = OptType::COMM_HDC;
    session->session = 0x123456;
    session->comp = ComponentType::COMPONENT_SYS_REPORT;
    session->timeout = 0;
    session->client = nullptr;
    SessionItem item;
    item.session = (void *)session;
    item.type = SESSION_CONTINUES_EXPORT;
    MOCKER(AdxSendMsg).stubs().will(returnValue(0));
    SessionMgrDeleteSession(&item);
    EXPECT_EQ(0, SessionMgrAddSession(&item));
    EXPECT_EQ(0, SessionMgrGetSession(&item));
    EXPECT_EQ(0, SessionMgrSendMsg(&item, SESSION_MESSAGE, sizeof(SESSION_MESSAGE)));
    EXPECT_EQ(0, SessionMgrDeleteSession(&item));
}

TEST_F(EP_SLOGD_SESSION_MGR_FUNC_UTEST, ContinuousSessionError)
{
    AdxCommHandle session = static_cast<AdxCommHandle>(LogMalloc(sizeof(CommHandle)));
    session->type = OptType::COMM_HDC;
    session->session = 0x123456;
    session->comp = ComponentType::COMPONENT_SYS_REPORT;
    session->timeout = 0;
    session->client = nullptr;
    SessionItem item;
    item.session = (void *)session;
    item.type = SESSION_CONTINUES_EXPORT;
    EXPECT_EQ(SessionMgrAddSession(&item), 0);
    EXPECT_EQ(SessionMgrAddSession(&item), -1);
    EXPECT_EQ(SessionMgrDeleteSession(&item), 0);
    EXPECT_EQ(SessionMgrGetSession(&item), -1);
}

TEST_F(EP_SLOGD_SESSION_MGR_FUNC_UTEST, SingleSession)
{
    CommHandle session = {OptType::COMM_HDC, -1, NR_COMPONENTS, -1, nullptr};
    SessionItem item;
    item.session = (void *)&session;
    item.type = SESSION_SINGLE_EXPORT;
    EXPECT_EQ(SessionMgrAddSession(&item), 0);
    EXPECT_EQ(SessionMgrDeleteSession(&item), 0);
}

TEST_F(EP_SLOGD_SESSION_MGR_FUNC_UTEST, SingleSessionError)
{
    CommHandle session = {OptType::COMM_HDC, -1, NR_COMPONENTS, -1, nullptr};
    SessionItem item;
    item.session = (void *)&session;
    item.type = SESSION_SINGLE_EXPORT;
    EXPECT_EQ(SessionMgrAddSession(&item), 0);
    EXPECT_EQ(SessionMgrAddSession(&item), 0);
    EXPECT_EQ(SessionMgrAddSession(&item), 0);
    EXPECT_EQ(SessionMgrAddSession(&item), 0);
    EXPECT_EQ(SessionMgrAddSession(&item), 0);
    EXPECT_EQ(SessionMgrAddSession(&item), 0);
    EXPECT_EQ(SessionMgrAddSession(&item), 0);
    EXPECT_EQ(SessionMgrAddSession(&item), 0);
    EXPECT_EQ(SessionMgrAddSession(&item), 0);
    EXPECT_EQ(SessionMgrAddSession(&item), 0);
    EXPECT_EQ(SessionMgrAddSession(&item), 0);
    EXPECT_EQ(SessionMgrAddSession(&item), 0);
    EXPECT_EQ(SessionMgrAddSession(&item), 0);
    EXPECT_EQ(SessionMgrAddSession(&item), 0);
    EXPECT_EQ(SessionMgrAddSession(&item), 0);
    EXPECT_EQ(SessionMgrAddSession(&item), 0);
    EXPECT_EQ(SessionMgrAddSession(&item), -1);
    EXPECT_EQ(SessionMgrGetSession(&item), -1);
    EXPECT_EQ(SessionMgrDeleteSession(&item), 0);
    EXPECT_EQ(SessionMgrDeleteSession(&item), 0);
    EXPECT_EQ(SessionMgrDeleteSession(&item), 0);
    EXPECT_EQ(SessionMgrDeleteSession(&item), 0);
    EXPECT_EQ(SessionMgrDeleteSession(&item), 0);
    EXPECT_EQ(SessionMgrDeleteSession(&item), 0);
    EXPECT_EQ(SessionMgrDeleteSession(&item), 0);
    EXPECT_EQ(SessionMgrDeleteSession(&item), 0);
    EXPECT_EQ(SessionMgrDeleteSession(&item), 0);
    EXPECT_EQ(SessionMgrDeleteSession(&item), 0);
    EXPECT_EQ(SessionMgrDeleteSession(&item), 0);
    EXPECT_EQ(SessionMgrDeleteSession(&item), 0);
    EXPECT_EQ(SessionMgrDeleteSession(&item), 0);
    EXPECT_EQ(SessionMgrDeleteSession(&item), 0);
    EXPECT_EQ(SessionMgrDeleteSession(&item), 0);
    EXPECT_EQ(SessionMgrDeleteSession(&item), 0);
    EXPECT_EQ(SessionMgrDeleteSession(&item), -1);
}

TEST_F(EP_SLOGD_SESSION_MGR_FUNC_UTEST, InValidType)
{
    SessionType invalidType = (SessionType)99;
    CommHandle session = {OptType::COMM_HDC, -1, NR_COMPONENTS, -1, nullptr};
    SessionItem item;
    item.session = (void *)&session;
    item.type = invalidType;
    EXPECT_EQ(SessionMgrAddSession(&item), -1);
    EXPECT_EQ(SessionMgrGetSession(&item), -1);
    EXPECT_EQ(SessionMgrDeleteSession(&item), -1);
}

TEST_F(EP_SLOGD_SESSION_MGR_FUNC_UTEST, InvalidItem)
{
    SessionItem *item = nullptr;
    EXPECT_EQ(SessionMgrAddSession(item), -1);
    EXPECT_EQ(SessionMgrSendMsg(item, SESSION_MESSAGE, sizeof(SESSION_MESSAGE)), -1);
}

TEST_F(EP_SLOGD_SESSION_MGR_FUNC_UTEST, InvalidSession)
{
    CommHandle *session = nullptr;
    SessionItem item;
    item.session = (void *)session;
    item.type = SESSION_SINGLE_EXPORT;
    EXPECT_EQ(SessionMgrAddSession(&item), -1);
    EXPECT_EQ(SessionMgrSendMsg(&item, SESSION_MESSAGE, sizeof(SESSION_MESSAGE)), -1);
}

TEST_F(EP_SLOGD_SESSION_MGR_FUNC_UTEST, InvalidData)
{
    CommHandle session = {OptType::COMM_HDC, -1, NR_COMPONENTS, -1, nullptr};
    SessionItem item;
    item.session = (void *)&session;
    item.type = SESSION_SINGLE_EXPORT;
    EXPECT_EQ(SessionMgrSendMsg(&item, nullptr, sizeof(SESSION_MESSAGE)), -1);
    EXPECT_EQ(SessionMgrSendMsg(&item, SESSION_MESSAGE, 0), -1);
}

int32_t AdxGetAttrByCommHandleStub(const CommHandle *handle, int32_t attr, int32_t *value)
{
    (void)handle;
    if (attr == HDC_SESSION_ATTR_STATUS) {
        *value = 2; // closed
        return 0;
    }
    *value = 0;
    return 0;
}

TEST_F(EP_SLOGD_SESSION_MGR_FUNC_UTEST, ContinuousGetStatusFailed)
{
    AdxCommHandle session = static_cast<AdxCommHandle>(LogMalloc(sizeof(CommHandle)));
    session->type = OptType::COMM_HDC;
    session->session = 0x123456;
    session->comp = ComponentType::COMPONENT_SYS_REPORT;
    session->timeout = 0;
    session->client = nullptr;
    SessionItem item;
    item.session = (void *)session;
    item.type = SESSION_CONTINUES_EXPORT;
    MOCKER(AdxGetAttrByCommHandle)
        .stubs()
        .will(invoke(AdxGetAttrByCommHandleStub));
    EXPECT_EQ(SessionMgrAddSession(&item), 0);
    EXPECT_EQ(SessionMgrGetSession(&item), -1);
    EXPECT_EQ(SessionMgrDeleteSession(&item), 0);
}

#define SESSION_ERROR_WAIT_TIMEOUT      16
TEST_F(EP_SLOGD_SESSION_MGR_FUNC_UTEST, SendMsgSingleTimeoutTwice)
{
    CommHandle session = {OptType::COMM_HDC, -1, NR_COMPONENTS, -1, nullptr};
    SessionItem item;
    item.session = (void *)&session;
    item.type = SESSION_SINGLE_EXPORT;
    MOCKER(AdxSendMsg)
        .stubs()
        .will(returnValue(SESSION_ERROR_WAIT_TIMEOUT))
        .then(returnValue(SESSION_ERROR_WAIT_TIMEOUT))
        .then(returnValue(0));
    EXPECT_EQ(SessionMgrSendMsg(&item, SESSION_MESSAGE, sizeof(SESSION_MESSAGE)), 0);
}

TEST_F(EP_SLOGD_SESSION_MGR_FUNC_UTEST, SendMsgSingleTimeoutAllAlong)
{
    CommHandle session = {OptType::COMM_HDC, -1, NR_COMPONENTS, -1, nullptr};
    SessionItem item;
    item.session = (void *)&session;
    item.type = SESSION_SINGLE_EXPORT;
    MOCKER(AdxSendMsg)
        .stubs()
        .will(returnValue(SESSION_ERROR_WAIT_TIMEOUT));
    EXPECT_EQ(SessionMgrSendMsg(&item, SESSION_MESSAGE, sizeof(SESSION_MESSAGE)), -1);
}

TEST_F(EP_SLOGD_SESSION_MGR_FUNC_UTEST, SendMsgContinuousTimeoutTwice)
{
    AdxCommHandle session = static_cast<AdxCommHandle>(LogMalloc(sizeof(CommHandle)));
    session->type = OptType::COMM_HDC;
    session->session = 0x123456;
    session->comp = ComponentType::COMPONENT_SYS_REPORT;
    session->timeout = 0;
    session->client = nullptr;
    SessionItem item;
    item.session = (void *)session;
    item.type = SESSION_CONTINUES_EXPORT;
    MOCKER(AdxSendMsg)
        .stubs()
        .will(returnValue(0))
        .then(returnValue(SESSION_ERROR_WAIT_TIMEOUT))
        .then(returnValue(SESSION_ERROR_WAIT_TIMEOUT))
        .then(returnValue(0));
    EXPECT_EQ(SessionMgrAddSession(&item), 0);
    EXPECT_EQ(SessionMgrSendMsg(&item, SESSION_MESSAGE, sizeof(SESSION_MESSAGE)), 0);
    EXPECT_EQ(SessionMgrDeleteSession(&item), 0);
}

TEST_F(EP_SLOGD_SESSION_MGR_FUNC_UTEST, SendMsgContinuousSendFailed)
{
    AdxCommHandle session = static_cast<AdxCommHandle>(LogMalloc(sizeof(CommHandle)));
    session->type = OptType::COMM_HDC;
    session->session = 0x123456;
    session->comp = ComponentType::COMPONENT_SYS_REPORT;
    session->timeout = 0;
    session->client = nullptr;
    SessionItem item;
    item.session = (void *)session;
    item.type = SESSION_CONTINUES_EXPORT;
    MOCKER(AdxSendMsg)
        .stubs()
        .will(returnValue(-1))
        .then(returnValue(0));
    EXPECT_EQ(SessionMgrAddSession(&item), -1);
    EXPECT_EQ(SessionMgrAddSession(&item), 0);
    EXPECT_EQ(SessionMgrSendMsg(&item, SESSION_MESSAGE, sizeof(SESSION_MESSAGE)), 0);
    EXPECT_EQ(SessionMgrDeleteSession(&item), 0);
}

TEST_F(EP_SLOGD_SESSION_MGR_FUNC_UTEST, SendMsgContinuousTimeoutAllAlong)
{
    AdxCommHandle session = static_cast<AdxCommHandle>(LogMalloc(sizeof(CommHandle)));
    session->type = OptType::COMM_HDC;
    session->session = 0x123456;
    session->comp = ComponentType::COMPONENT_SYS_REPORT;
    session->timeout = 0;
    session->client = nullptr;
    SessionItem item;
    item.session = (void *)session;
    item.type = SESSION_CONTINUES_EXPORT;
    MOCKER(AdxSendMsg)
        .stubs()
        .will(returnValue(0))
        .then(returnValue(SESSION_ERROR_WAIT_TIMEOUT));
    EXPECT_EQ(SessionMgrAddSession(&item), 0);
    EXPECT_EQ(SessionMgrSendMsg(&item, SESSION_MESSAGE, sizeof(SESSION_MESSAGE)), -1);
}

TEST_F(EP_SLOGD_SESSION_MGR_FUNC_UTEST, SendMsgContinuousWithoutAdd)
{
    AdxCommHandle session = nullptr;
    SessionItem item;
    item.session = (void *)session;
    item.type = SESSION_CONTINUES_EXPORT;
    EXPECT_EQ(SessionMgrSendMsg(&item, SESSION_MESSAGE, sizeof(SESSION_MESSAGE)), -1);
}