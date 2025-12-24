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

#include "log_sys_report.h"
#include "log_sys_get.h"
#include "log_session_manage.h"
#include "log_drv.h"
using namespace std;
using namespace testing;

extern "C" {
    //  extern
}
#define SINGLE_EXPORT_LOG        "slog_single"
#define CONTINUOUS_EXPORT_LOG    "slog_continuous"
#define INVALID_MSG              "invalid"
#define MSG_STATUS_LONG_LINK     12

class EP_SLOGD_SYS_REPORT_FUNC_UTEST : public testing::Test
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

TEST_F(EP_SLOGD_SYS_REPORT_FUNC_UTEST, SysReportInit)
{
    EXPECT_EQ(0, SysReportInit());
}

TEST_F(EP_SLOGD_SYS_REPORT_FUNC_UTEST, SysReportDestroy)
{
    EXPECT_EQ(0, SysReportDestroy());
}

TEST_F(EP_SLOGD_SYS_REPORT_FUNC_UTEST, SysGetInit)
{
    EXPECT_EQ(0, SysGetInit());
}

TEST_F(EP_SLOGD_SYS_REPORT_FUNC_UTEST, SysGetDestroy)
{
    EXPECT_EQ(0, SysGetDestroy());
}

TEST_F(EP_SLOGD_SYS_REPORT_FUNC_UTEST, SysGetSingleProcess)
{
    AdxCommHandle handle = static_cast<AdxCommHandle>(LogMalloc(sizeof(CommHandle)));
    handle->type = OptType::COMM_HDC;
    handle->session = 0x123456;
    handle->comp = ComponentType::COMPONENT_SYS_GET;
    handle->timeout = 0;
    handle->client = nullptr;
    size_t len = sizeof(LogDataMsg) + strlen(SINGLE_EXPORT_LOG) + 1;
    LogDataMsg *value = (LogDataMsg *)malloc(len);
    memset_s(value, len, 0, len);
    value->devId = 0;
    value->sliceLen = strlen(SINGLE_EXPORT_LOG);
    memcpy_s(value->data, strlen(SINGLE_EXPORT_LOG), SINGLE_EXPORT_LOG, strlen(SINGLE_EXPORT_LOG));

    EXPECT_EQ(0, SysGetProcess(handle, value, len));
    XFREE(handle);
    XFREE(value);
}

TEST_F(EP_SLOGD_SYS_REPORT_FUNC_UTEST, SysReportContinuousProcess)
{
    AdxCommHandle handle = static_cast<AdxCommHandle>(LogMalloc(sizeof(CommHandle)));
    handle->type = OptType::COMM_HDC;
    handle->session = 0x123456;
    handle->comp = ComponentType::COMPONENT_SYS_REPORT;
    handle->timeout = 0;
    handle->client = nullptr;

    size_t len = sizeof(LogDataMsg) + 1;
    LogDataMsg *value = (LogDataMsg *)malloc(len);
    memset_s(value, len, 0, len);
    value->status = MSG_STATUS_LONG_LINK;
    value->devId = 0;
    value->sliceLen = 0;

    EXPECT_EQ(0, SysReportProcess(handle, value, len));
    XFREE(value);
}

TEST_F(EP_SLOGD_SYS_REPORT_FUNC_UTEST, SysReportInvalidProcess)
{
    AdxCommHandle handle = static_cast<AdxCommHandle>(LogMalloc(sizeof(CommHandle)));
    handle->type = OptType::COMM_HDC;
    handle->session = 0x123456;
    handle->comp = ComponentType::COMPONENT_SYS_REPORT;
    handle->timeout = 0;
    handle->client = nullptr;

    size_t len = sizeof(LogDataMsg) + strlen(INVALID_MSG) + 1;
    LogDataMsg *value = (LogDataMsg *)malloc(len);
    memset_s(value, len, 0, len);
    value->devId = 0;
    value->sliceLen = strlen(INVALID_MSG);
    memcpy_s(value->data, strlen(INVALID_MSG), INVALID_MSG, strlen(INVALID_MSG));

    EXPECT_EQ(SysReportProcess(handle, value, len), -1);
    XFREE(value);
}

TEST_F(EP_SLOGD_SYS_REPORT_FUNC_UTEST, SysGetInvalidProcess)
{
    AdxCommHandle handle = static_cast<AdxCommHandle>(LogMalloc(sizeof(CommHandle)));
    handle->type = OptType::COMM_HDC;
    handle->session = 0x123456;
    handle->comp = ComponentType::COMPONENT_SYS_GET;
    handle->timeout = 0;
    handle->client = nullptr;

    size_t len = sizeof(LogDataMsg) + strlen(INVALID_MSG) + 1;
    LogDataMsg *value = (LogDataMsg *)malloc(len);
    memset_s(value, len, 0, len);
    value->devId = 0;
    value->sliceLen = strlen(INVALID_MSG);
    memcpy_s(value->data, strlen(INVALID_MSG), INVALID_MSG, strlen(INVALID_MSG));

    EXPECT_EQ(SysGetProcess(handle, value, len), -1);
    XFREE(handle);
    XFREE(value);
}

TEST_F(EP_SLOGD_SYS_REPORT_FUNC_UTEST, SysProcessHandleFailed)
{
    CommHandle *handle = nullptr;

    size_t len = sizeof(LogDataMsg) + strlen(SINGLE_EXPORT_LOG) + 1;
    LogDataMsg *value = (LogDataMsg *)malloc(len);
    memset_s(value, len, 0, len);
    value->devId = 0;
    value->sliceLen = strlen(SINGLE_EXPORT_LOG);
    memcpy_s(value->data, strlen(SINGLE_EXPORT_LOG), SINGLE_EXPORT_LOG, strlen(SINGLE_EXPORT_LOG));

    EXPECT_EQ(SysReportProcess(handle, value, len), -1);
    EXPECT_EQ(SysGetProcess(handle, value, len), -1);
    XFREE(value);
}

TEST_F(EP_SLOGD_SYS_REPORT_FUNC_UTEST, SysReportProcessValueFailed)
{
    AdxCommHandle handle = static_cast<AdxCommHandle>(LogMalloc(sizeof(CommHandle)));
    handle->type = OptType::COMM_HDC;
    handle->session = 0x123456;
    handle->comp = ComponentType::COMPONENT_SYS_REPORT;
    handle->timeout = 0;
    handle->client = nullptr;

    size_t len = sizeof(LogDataMsg) + strlen(SINGLE_EXPORT_LOG) + 1;
    LogDataMsg *value = nullptr;

    EXPECT_EQ(SysReportProcess(handle, value, len), -1);
}

TEST_F(EP_SLOGD_SYS_REPORT_FUNC_UTEST, SysGetProcessValueFailed)
{
    AdxCommHandle handle = static_cast<AdxCommHandle>(LogMalloc(sizeof(CommHandle)));
    handle->type = OptType::COMM_HDC;
    handle->session = 0x123456;
    handle->comp = ComponentType::COMPONENT_SYS_GET;
    handle->timeout = 0;
    handle->client = nullptr;

    size_t len = sizeof(LogDataMsg) + strlen(SINGLE_EXPORT_LOG) + 1;
    LogDataMsg *value = nullptr;

    EXPECT_EQ(SysGetProcess(handle, value, len), -1);
    XFREE(handle);
}

TEST_F(EP_SLOGD_SYS_REPORT_FUNC_UTEST, SysReportProcessLenFailed)
{
    AdxCommHandle handle = static_cast<AdxCommHandle>(LogMalloc(sizeof(CommHandle)));
    handle->type = OptType::COMM_HDC;
    handle->session = 0x123456;
    handle->comp = ComponentType::COMPONENT_SYS_REPORT;
    handle->timeout = 0;
    handle->client = nullptr;

    size_t len = sizeof(LogDataMsg) + strlen(SINGLE_EXPORT_LOG) + 1;
    LogDataMsg *value = (LogDataMsg *)malloc(len);
    memset_s(value, len, 0, len);
    value->devId = 0;
    value->sliceLen = strlen(SINGLE_EXPORT_LOG);
    memcpy_s(value->data, strlen(SINGLE_EXPORT_LOG), SINGLE_EXPORT_LOG, strlen(SINGLE_EXPORT_LOG));

    EXPECT_EQ(-1, SysReportProcess(handle, value, 0));
    XFREE(value);
}

TEST_F(EP_SLOGD_SYS_REPORT_FUNC_UTEST, SysGetProcessLenFailed)
{
    AdxCommHandle handle = static_cast<AdxCommHandle>(LogMalloc(sizeof(CommHandle)));
    handle->type = OptType::COMM_HDC;
    handle->session = 0x123456;
    handle->comp = ComponentType::COMPONENT_SYS_GET;
    handle->timeout = 0;
    handle->client = nullptr;

    size_t len = sizeof(LogDataMsg) + strlen(SINGLE_EXPORT_LOG) + 1;
    LogDataMsg *value = (LogDataMsg *)malloc(len);
    memset_s(value, len, 0, len);
    value->devId = 0;
    value->sliceLen = strlen(SINGLE_EXPORT_LOG);
    memcpy_s(value->data, strlen(SINGLE_EXPORT_LOG), SINGLE_EXPORT_LOG, strlen(SINGLE_EXPORT_LOG));

    EXPECT_EQ(-1, SysGetProcess(handle, value, 0));
    XFREE(handle);
    XFREE(value);
}

TEST_F(EP_SLOGD_SYS_REPORT_FUNC_UTEST, SysReportContainerFailed)
{
    AdxCommHandle handle = static_cast<AdxCommHandle>(LogMalloc(sizeof(CommHandle)));
    handle->type = OptType::COMM_HDC;
    handle->session = 0x123456;
    handle->comp = ComponentType::COMPONENT_SYS_REPORT;
    handle->timeout = 0;
    handle->client = nullptr;

    size_t len = sizeof(LogDataMsg) + strlen(SINGLE_EXPORT_LOG) + 1;
    LogDataMsg *value = (LogDataMsg *)malloc(len);
    memset_s(value, len, 0, len);
    value->devId = 0;
    value->sliceLen = strlen(SINGLE_EXPORT_LOG);
    memcpy_s(value->data, strlen(SINGLE_EXPORT_LOG), SINGLE_EXPORT_LOG, strlen(SINGLE_EXPORT_LOG));

    MOCKER(AdxGetAttrByCommHandle)
        .stubs()
        .will(returnValue(-1));

    EXPECT_EQ(SysReportProcess(handle, value, len), -1);
    XFREE(value);
}

TEST_F(EP_SLOGD_SYS_REPORT_FUNC_UTEST, SysGetContainerFailed)
{
    AdxCommHandle handle = static_cast<AdxCommHandle>(LogMalloc(sizeof(CommHandle)));
    handle->type = OptType::COMM_HDC;
    handle->session = 0x123456;
    handle->comp = ComponentType::COMPONENT_SYS_GET;
    handle->timeout = 0;
    handle->client = nullptr;

    size_t len = sizeof(LogDataMsg) + strlen(SINGLE_EXPORT_LOG) + 1;
    LogDataMsg *value = (LogDataMsg *)malloc(len);
    memset_s(value, len, 0, len);
    value->devId = 0;
    value->sliceLen = strlen(SINGLE_EXPORT_LOG);
    memcpy_s(value->data, strlen(SINGLE_EXPORT_LOG), SINGLE_EXPORT_LOG, strlen(SINGLE_EXPORT_LOG));

    MOCKER(AdxGetAttrByCommHandle)
        .stubs()
        .will(returnValue(-1));

    EXPECT_EQ(SysGetProcess(handle, value, len), -1);
    XFREE(handle);
    XFREE(value);
}

int32_t AdxGetAttrIsDockerStub(const CommHandle *handle, int32_t attr, int32_t *value)
{
    *value = 2;
    return 0;
}

TEST_F(EP_SLOGD_SYS_REPORT_FUNC_UTEST, SysReportIsContainer)
{
    AdxCommHandle handle = static_cast<AdxCommHandle>(LogMalloc(sizeof(CommHandle)));
    handle->type = OptType::COMM_HDC;
    handle->session = 0x123456;
    handle->comp = ComponentType::COMPONENT_SYS_REPORT;
    handle->timeout = 0;
    handle->client = nullptr;

    size_t len = sizeof(LogDataMsg) + strlen(SINGLE_EXPORT_LOG) + 1;
    LogDataMsg *value = (LogDataMsg *)malloc(len);
    memset_s(value, len, 0, len);
    value->devId = 0;
    value->sliceLen = strlen(SINGLE_EXPORT_LOG);
    memcpy_s(value->data, strlen(SINGLE_EXPORT_LOG), SINGLE_EXPORT_LOG, strlen(SINGLE_EXPORT_LOG));

    MOCKER(AdxGetAttrByCommHandle)
        .stubs()
        .will(invoke(AdxGetAttrIsDockerStub));

    EXPECT_EQ(SysReportProcess(handle, value, len), 0);
    XFREE(value);
}

TEST_F(EP_SLOGD_SYS_REPORT_FUNC_UTEST, SysGetIsContainer)
{
    AdxCommHandle handle = static_cast<AdxCommHandle>(LogMalloc(sizeof(CommHandle)));
    handle->type = OptType::COMM_HDC;
    handle->session = 0x123456;
    handle->comp = ComponentType::COMPONENT_SYS_GET;
    handle->timeout = 0;
    handle->client = nullptr;

    size_t len = sizeof(LogDataMsg) + strlen(SINGLE_EXPORT_LOG) + 1;
    LogDataMsg *value = (LogDataMsg *)malloc(len);
    memset_s(value, len, 0, len);
    value->devId = 0;
    value->sliceLen = strlen(SINGLE_EXPORT_LOG);
    memcpy_s(value->data, strlen(SINGLE_EXPORT_LOG), SINGLE_EXPORT_LOG, strlen(SINGLE_EXPORT_LOG));

    MOCKER(AdxGetAttrByCommHandle)
        .stubs()
        .will(invoke(AdxGetAttrIsDockerStub));

    EXPECT_EQ(SysGetProcess(handle, value, len), 0);
    XFREE(handle);
    XFREE(value);
}

TEST_F(EP_SLOGD_SYS_REPORT_FUNC_UTEST, SysGetSingleAddFail)
{
    AdxCommHandle handle = static_cast<AdxCommHandle>(LogMalloc(sizeof(CommHandle)));
    handle->type = OptType::COMM_HDC;
    handle->session = 0x123456;
    handle->comp = ComponentType::COMPONENT_SYS_GET;
    handle->timeout = 0;
    handle->client = nullptr;

    size_t len = sizeof(LogDataMsg) + strlen(SINGLE_EXPORT_LOG) + 1;
    LogDataMsg *value = (LogDataMsg *)malloc(len);
    memset_s(value, len, 0, len);
    value->devId = 0;
    value->sliceLen = strlen(SINGLE_EXPORT_LOG);
    memcpy_s(value->data, strlen(SINGLE_EXPORT_LOG), SINGLE_EXPORT_LOG, strlen(SINGLE_EXPORT_LOG));

    MOCKER(SessionMgrAddSession)
        .stubs()
        .will(returnValue(-1));

    EXPECT_EQ(SysGetProcess(handle, value, len), -1);
    XFREE(handle);
    XFREE(value);
}

TEST_F(EP_SLOGD_SYS_REPORT_FUNC_UTEST, SysGetSingleDeleteFail)
{
    AdxCommHandle handle = static_cast<AdxCommHandle>(LogMalloc(sizeof(CommHandle)));
    handle->type = OptType::COMM_HDC;
    handle->session = 0x123456;
    handle->comp = ComponentType::COMPONENT_SYS_GET;
    handle->timeout = 0;
    handle->client = nullptr;

    size_t len = sizeof(LogDataMsg) + strlen(SINGLE_EXPORT_LOG) + 1;
    LogDataMsg *value = (LogDataMsg *)malloc(len);
    memset_s(value, len, 0, len);
    value->devId = 0;
    value->sliceLen = strlen(SINGLE_EXPORT_LOG);
    memcpy_s(value->data, strlen(SINGLE_EXPORT_LOG), SINGLE_EXPORT_LOG, strlen(SINGLE_EXPORT_LOG));

    MOCKER(SessionMgrDeleteSession)
        .stubs()
        .will(returnValue(-1));

    EXPECT_EQ(SysGetProcess(handle, value, len), -1);
    XFREE(handle);
    XFREE(value);
}

TEST_F(EP_SLOGD_SYS_REPORT_FUNC_UTEST, SysReportContinuousAddFailed)
{
    AdxCommHandle handle = static_cast<AdxCommHandle>(LogMalloc(sizeof(CommHandle)));
    handle->type = OptType::COMM_HDC;
    handle->session = 0x123456;
    handle->comp = ComponentType::COMPONENT_SYS_REPORT;
    handle->timeout = 0;
    handle->client = nullptr;

    size_t len = sizeof(LogDataMsg) + 1;
    LogDataMsg *value = (LogDataMsg *)malloc(len);
    memset_s(value, len, 0, len);
    value->status = MSG_STATUS_LONG_LINK;
    value->devId = 0;
    value->sliceLen = 0;

    MOCKER(SessionMgrAddSession)
        .stubs()
        .will(returnValue(-1));

    EXPECT_EQ(SysReportProcess(handle, value, len), -1);
    XFREE(value);
}