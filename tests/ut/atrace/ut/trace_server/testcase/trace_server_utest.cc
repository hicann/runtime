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
#include "atrace_types.h"
#include "trace_server.h"
#include "ktrace_ts.h"
#include "trace_system_api.h"
#include "utrace_socket.h"
#include "utrace_api.h"
#include "trace_session_mgr.h"
#include "trace_server_socket.h"
#include "utrace_socket.h"
#include "adx_component_api_c.h"
#include "ascend_hal_stub.h"

extern "C" {
    void TraceInit(void);
    void TraceExit(void);
}

class TraceServerUtest: public testing::Test {
protected:
    virtual void SetUp()
    {
        Clear();
        system("echo [DBG][TEST][`date +%Y-%m-%d-%H-%M-%S`] Start test case");
        system("mkdir -p " LLT_TEST_DIR );
        MOCKER(lchown).stubs().will(returnValue(0));
    }

    void Clear()
    {
        system("rm -rf " LLT_TEST_DIR "/*");
    }
    virtual void TearDown()
    {
        system("echo [DBG][TEST][`date +%Y-%m-%d-%H-%M-%S`] End test case");
        GlobalMockObject::verify();
        system("rm -rf " LLT_TEST_DIR );
    }

    static void SetUpTestCase()
    {
    }

    static void TearDownTestCase()
    {
    }
};
extern "C" int32_t TraceServerGetDevId(void);
TEST_F(TraceServerUtest, TraceServerInitPf)
{
    TraceServerInit(-1);
    EXPECT_EQ(-1, TraceServerGetDevId());
    EXPECT_EQ(TRACE_SUCCESS, TraceServerProcess());
    TraceServerExit();
}

TEST_F(TraceServerUtest, TraceServerInitPfServiceFailed)
{
    MOCKER(AdxRegisterService).stubs().will(returnValue(-1));
    TraceServerInit(-1);
    EXPECT_EQ(-1, TraceServerGetDevId());
    EXPECT_EQ(TRACE_FAILURE, TraceServerProcess());
    TraceServerExit();
}

TEST_F(TraceServerUtest, TraceServerInitPfDevIdFailed)
{
    MOCKER(halGetDevIDsEx).stubs().will(returnValue(1));
    TraceServerInit(-1);
    EXPECT_EQ(-1, TraceServerGetDevId());
    EXPECT_EQ(TRACE_FAILURE, TraceServerProcess());
    TraceServerExit();

    MOCKER(halGetDevNumEx).stubs().will(returnValue(1));
    TraceServerInit(-1);
    EXPECT_EQ(-1, TraceServerGetDevId());
    EXPECT_EQ(TRACE_FAILURE, TraceServerProcess());
    TraceServerExit();
}

TEST_F(TraceServerUtest, TraceServerInitPfThreadFailed)
{
    MOCKER(mmCreateTaskWithThreadAttr).stubs().will(returnValue(-1)).then(returnValue(0)).then(returnValue(-1));
    TraceServerInit(-1);
    EXPECT_EQ(-1, TraceServerGetDevId());
    EXPECT_EQ(TRACE_FAILURE, TraceServerProcess());
    TraceServerExit();

    TraceServerInit(-1);
    EXPECT_EQ(-1, TraceServerGetDevId());
    EXPECT_EQ(TRACE_FAILURE, TraceServerProcess());
    TraceServerExit();
}

TEST_F(TraceServerUtest, TraceServerPfProcessCreateSocketFailed)
{
    MOCKER(vsprintf_s).stubs().will(returnValue(-1));
    TraceServerInit(-1);
    EXPECT_EQ(-1, TraceServerGetDevId());
    EXPECT_EQ(TRACE_FAILURE, TraceServerProcess());
    TraceServerExit();
}

TEST_F(TraceServerUtest, TraceServerInitVf)
{
    TraceServerInit(32);
    EXPECT_EQ(32, TraceServerGetDevId());
    EXPECT_EQ(TRACE_SUCCESS, TraceServerProcess());
    TraceServerExit();
}

TEST_F(TraceServerUtest, TraceServerInitVfThreadFailed)
{
    MOCKER(mmCreateTaskWithThreadAttr).stubs().will(returnValue(-1)).then(returnValue(0)).then(returnValue(-1));
    TraceServerInit(32);
    EXPECT_EQ(32, TraceServerGetDevId());
    EXPECT_EQ(TRACE_FAILURE, TraceServerProcess());
    TraceServerExit();

    TraceServerInit(32);
    EXPECT_EQ(32, TraceServerGetDevId());
    EXPECT_EQ(TRACE_FAILURE, TraceServerProcess());
    TraceServerExit();
}

TEST_F(TraceServerUtest, TraceServerVfProcessCreateSocketFailed)
{
    MOCKER(vsprintf_s).stubs().will(returnValue(-1));
    TraceServerInit(32);
    EXPECT_EQ(32, TraceServerGetDevId());
    EXPECT_EQ(TRACE_FAILURE, TraceServerProcess());
    TraceServerExit();
}

TEST_F(TraceServerUtest, TraceServerInitInvalidDevId)
{
    TraceServerInit(100);
    EXPECT_EQ(100, TraceServerGetDevId());
    EXPECT_EQ(TRACE_FAILURE, TraceServerProcess());
    TraceServerExit();
}

TEST_F(TraceServerUtest, KtraceTsCreateThreadThread)
{
    uint32_t devIdArray[2] = { 0U, 1U };
    EXPECT_EQ(TRACE_SUCCESS, KtraceTsCreateThread(2U, devIdArray));
    KtraceTsDestroyThread();
}

TEST_F(TraceServerUtest, KtraceTsCreateThreadInvalidInput)
{
    EXPECT_EQ(TRACE_FAILURE, KtraceTsCreateThread(100, NULL));
    KtraceTsDestroyThread();
    EXPECT_EQ(TRACE_FAILURE, KtraceTsCreateThread(0, NULL));
    KtraceTsDestroyThread();
}

TEST_F(TraceServerUtest, KtraceTsCreateThreadMallocFailed)
{
    MOCKER(AdiagMalloc).stubs().will(returnValue((void *)NULL));
    uint32_t devIdArray[1] = { 0U };
    EXPECT_EQ(TRACE_FAILURE, KtraceTsCreateThread(1U, devIdArray));
    KtraceTsDestroyThread();
}

TEST_F(TraceServerUtest, KtraceTsCreateThreadThreadFailed)
{
    MOCKER(TraceCreateTaskWithThreadAttr).stubs().will(returnValue(TRACE_FAILURE));
    uint32_t devIdArray[2] = { 0U, 1U };
    EXPECT_EQ(TRACE_FAILURE, KtraceTsCreateThread(2U, devIdArray));
    KtraceTsDestroyThread();
}

TEST_F(TraceServerUtest, UtraceSocket)
{
    MOCKER(mmSetCurrentThreadName).stubs().will(returnValue(TRACE_FAILURE));
    // pf
    TraceServerInit(-1);
    EXPECT_EQ(TRACE_SUCCESS, TraceServerProcess());
    int32_t sockFd = UtraceCreateSocket(0);
    EXPECT_NE(TRACE_FAILURE, sockFd);
    UtraceSetSocketFd(sockFd);
    EXPECT_EQ(sockFd, UtraceGetSocketFd());
    EXPECT_EQ(true, UtraceIsSocketFdValid());
    UtraceCloseSocket();
    TraceServerExit();

    // vf
    TraceServerInit(33);
    EXPECT_EQ(TRACE_SUCCESS, TraceServerProcess());
    sockFd = UtraceCreateSocket(33);
    EXPECT_NE(TRACE_FAILURE, sockFd);
    UtraceSetSocketFd(sockFd);
    EXPECT_EQ(sockFd, UtraceGetSocketFd());
    EXPECT_EQ(true, UtraceIsSocketFdValid());
    UtraceCloseSocket();
    TraceServerExit();
}

TEST_F(TraceServerUtest, UtraceSocketConnectFailed)
{
    // server not ready, connect failed
    int32_t sockFd = UtraceCreateSocket(0);
    EXPECT_EQ(TRACE_FAILURE, sockFd);
    UtraceCloseSocket();
}

TEST_F(TraceServerUtest, UtraceSocketGetPathFailed)
{
    MOCKER(vsnprintf_s).stubs().will(returnValue(-1));
    int32_t sockFd = UtraceCreateSocket(0);
    EXPECT_EQ(TRACE_FAILURE, sockFd);
    sockFd = UtraceCreateSocket(33);
    EXPECT_EQ(TRACE_FAILURE, sockFd);
}

TEST_F(TraceServerUtest, UtraceTracerSubmitWithNoSession)
{
    TraceServerInit(-1);
    EXPECT_EQ(TRACE_SUCCESS, TraceServerProcess());
    TraceInit();
    TraceGlobalAttr globalAttr = { 1, 0, 0 };
    UtraceSetGlobalAttr(&globalAttr);
    TraceAttr attr = { 0 };
    attr.exitSave = true;
    attr.msgSize = DEFAULT_ATRACE_MSG_SIZE;
    attr.msgNum = DEFAULT_ATRACE_MSG_NUM;
    TracerType tracerType = TRACER_TYPE_SCHEDULE;
    const char objName[] = "HCCL";
    const char buffer[] = "msg";
    uint32_t bufSize = sizeof(buffer);

    auto handle = UtraceCreateWithAttr(tracerType, objName, &attr);
    EXPECT_NE(TRACE_INVALID_HANDLE, handle);
    auto status = UtraceSubmit(handle, buffer, bufSize);
    EXPECT_EQ(TRACE_SUCCESS, status);
    UtraceSave(tracerType, false);
    UtraceDestroy(handle);
    TraceExit();
    TraceServerExit();
}

TEST_F(TraceServerUtest, TestUtraceSubmit_MemcpyFailed)
{
    TraceInit();
    TraceAttr attr = { 0 };
    attr.exitSave = true;
    attr.msgSize = DEFAULT_ATRACE_MSG_SIZE;
    attr.msgNum = DEFAULT_ATRACE_MSG_NUM;
    attr.noLock = TRACE_LOCK_FREE;
    TracerType tracerType = TRACER_TYPE_SCHEDULE;
    const char objName[] = "HCCL";
    std::string buffer = std::string(128, '*');

    auto handle = UtraceCreateWithAttr(tracerType, objName, &attr);
    EXPECT_NE(TRACE_INVALID_HANDLE, handle);
    MOCKER(memcpy_s).stubs().will(returnValue(-1));
    auto status = UtraceSubmit(handle, buffer.c_str(), buffer.size());
    EXPECT_EQ(TRACE_FAILURE, status);
    status = UtraceSubmit(handle, nullptr, 0);
    EXPECT_EQ(TRACE_INVALID_PARAM, status);
    UtraceDestroy(handle);
    TraceExit();
}

TEST_F(TraceServerUtest, TestUtraceSubmitLockFree_MemcpyFailed)
{
    TraceInit();
    TraceAttr attr = { 0 };
    attr.exitSave = true;
    attr.msgSize = DEFAULT_ATRACE_MSG_SIZE;
    attr.msgNum = DEFAULT_ATRACE_MSG_NUM;
    TracerType tracerType = TRACER_TYPE_SCHEDULE;
    const char objName[] = "HCCL";
    std::string buffer = std::string(128, '*');

    auto handle = UtraceCreateWithAttr(tracerType, objName, &attr);
    EXPECT_NE(TRACE_INVALID_HANDLE, handle);
    MOCKER(memcpy_s).stubs().will(returnValue(-1));
    auto status = UtraceSubmit(handle, buffer.c_str(), buffer.size());
    EXPECT_EQ(TRACE_FAILURE, status);
    status = UtraceSubmit(handle, nullptr, 0);
    EXPECT_EQ(TRACE_INVALID_PARAM, status);
    UtraceDestroy(handle);
    TraceExit();
}

struct demoStructAlign {
    uint32_t tid;
    uint32_t count;
    char tag[32];
    uint64_t buf;
    uint32_t streamId;
    uint32_t deviceLogicId;
    uint8_t dataType;
    uint8_t root;
    uint8_t deviceIdArray[2];
    int8_t hostIdArray[4];
};

TEST_F(TraceServerUtest, TestAtraceCreateWithAttrDataStructDefineAlignWithNoSession)
{
    TraceServerInit(-1);
    EXPECT_EQ(TRACE_SUCCESS, TraceServerProcess());
    TraceInit();
    TraceGlobalAttr globalAttr = { 1, 0, 0 };
    UtraceSetGlobalAttr(&globalAttr);
    TraceAttr attr = { true, DEFAULT_ATRACE_MSG_NUM, DEFAULT_ATRACE_MSG_SIZE, NULL };
    TRACE_STRUCT_DEFINE_ENTRY(demoSt);
    TRACE_STRUCT_DEFINE_ENTRY_NAME(demoSt, "demo");
    TRACE_STRUCT_DEFINE_FIELD_UINT32(demoSt, tid, TRACE_STRUCT_SHOW_MODE_DEC);
    TRACE_STRUCT_DEFINE_FIELD_UINT32(demoSt, count, TRACE_STRUCT_SHOW_MODE_DEC);
    TRACE_STRUCT_DEFINE_ARRAY_CHAR(demoSt, tag, 32);
    TRACE_STRUCT_DEFINE_FIELD_UINT64(demoSt, buf, TRACE_STRUCT_SHOW_MODE_DEC);
    TRACE_STRUCT_DEFINE_FIELD_UINT32(demoSt, streamId, TRACE_STRUCT_SHOW_MODE_DEC);
    TRACE_STRUCT_DEFINE_FIELD_UINT32(demoSt, deviceLogicId, TRACE_STRUCT_SHOW_MODE_DEC);
    TRACE_STRUCT_DEFINE_FIELD_UINT8(demoSt, dataType, TRACE_STRUCT_SHOW_MODE_DEC);
    TRACE_STRUCT_DEFINE_FIELD_UINT8(demoSt, root, TRACE_STRUCT_SHOW_MODE_DEC);
    TRACE_STRUCT_DEFINE_ARRAY_UINT8(demoSt, deviceIdArray, TRACE_STRUCT_SHOW_MODE_DEC, 2);
    TRACE_STRUCT_DEFINE_ARRAY_INT8(demoSt, hostIdArray, 4);
    TRACE_STRUCT_SET_ATTR(demoSt, 0, &attr);
    auto handle = UtraceCreateWithAttr(TRACER_TYPE_SCHEDULE, "demo", &attr);
    EXPECT_NE(TRACE_INVALID_HANDLE, handle);

    std::vector<struct demoStructAlign> structList(10);
    for (int i = 0; i < structList.size(); i++) {
        structList[i].tid = i;
        strcpy_s(structList[i].tag, 32, "struct tag");
        structList[i].buf = i;
        structList[i].count = i;
        structList[i].dataType = i;
        structList[i].root = i;
        structList[i].streamId = i;
        structList[i].deviceLogicId = i;
        structList[i].deviceIdArray[0] = i;
        structList[i].deviceIdArray[1] = i + 1;
        structList[i].hostIdArray[0] = i + 1;
        structList[i].hostIdArray[1] = i + 2;
        structList[i].hostIdArray[2] = i + 3;
        structList[i].hostIdArray[3] = i + 4;
        auto ret = UtraceSubmit(handle, (void *)&structList[i], sizeof(struct demoStructAlign));
        EXPECT_EQ(ret, TRACE_SUCCESS);
    }
    UtraceSave(TRACER_TYPE_SCHEDULE, false);
    UtraceDestroy(handle);
    TRACE_STRUCT_UNDEFINE_ENTRY(demoSt);
    TraceExit();
    TraceServerExit();
}

TEST_F(TraceServerUtest, UtraceTracerSubmit)
{
    TraceServerInit(-1);
    EXPECT_EQ(TRACE_SUCCESS, TraceServerProcess());
    TraceInit();
    TraceGlobalAttr globalAttr = { 1, 0, 10 };
    UtraceSetGlobalAttr(&globalAttr);

    // insert session node
    void *sessionHandle = malloc(10);
    int32_t pid = 10;
    int32_t devId = 0;
    int32_t timeout = 0;
    EXPECT_EQ(NULL, TraceServerGetSessionNode(pid, devId));
    EXPECT_EQ(TRACE_SUCCESS, TraceServerInsertSessionNode(sessionHandle, pid, devId, timeout));

    TraceAttr attr = { 0 };
    attr.exitSave = true;
    attr.msgSize = DEFAULT_ATRACE_MSG_SIZE;
    attr.msgNum = DEFAULT_ATRACE_MSG_NUM;
    TracerType tracerType = TRACER_TYPE_SCHEDULE;
    const char objName1[] = "HCCL";
    const char buffer1[] = "msg";
    uint32_t bufSize = sizeof(buffer1);

    auto handle1 = UtraceCreateWithAttr(tracerType, objName1, &attr);
    EXPECT_NE(TRACE_INVALID_HANDLE, handle1);
    auto status = UtraceSubmit(handle1, buffer1, bufSize);
    EXPECT_EQ(TRACE_SUCCESS, status);
    const char objName2[] = "RUNTIME";
    auto handle2 = UtraceCreateWithAttr(tracerType, objName2, &attr);
    EXPECT_NE(TRACE_INVALID_HANDLE, handle2);
    UtraceSave(tracerType, false);
    UtraceDestroy(handle1);
    UtraceDestroy(handle2);
    TraceExit();
    // delete session node
    EXPECT_EQ(TRACE_SUCCESS, TraceServerDeleteSessionNode(sessionHandle, pid, devId));
    TraceServerExit();
}

TEST_F(TraceServerUtest, TestAtraceCreateWithAttrDataStructDefineAlign)
{
    TraceServerInit(-1);
    EXPECT_EQ(TRACE_SUCCESS, TraceServerProcess());
    TraceInit();
    TraceGlobalAttr globalAttr = { 1, 0, 10 };
    UtraceSetGlobalAttr(&globalAttr);

    // insert session node
    void *sessionHandle = malloc(10);
    int32_t pid = 10;
    int32_t devId = 0;
    int32_t timeout = 0;
    EXPECT_EQ(NULL, TraceServerGetSessionNode(pid, devId));
    EXPECT_EQ(TRACE_SUCCESS, TraceServerInsertSessionNode(sessionHandle, pid, devId, timeout));

    TraceAttr attr = { true, DEFAULT_ATRACE_MSG_NUM, DEFAULT_ATRACE_MSG_SIZE, NULL };
    TRACE_STRUCT_DEFINE_ENTRY(demoSt);
    TRACE_STRUCT_DEFINE_ENTRY_NAME(demoSt, "demo");
    TRACE_STRUCT_DEFINE_FIELD_UINT32(demoSt, tid, TRACE_STRUCT_SHOW_MODE_DEC);
    TRACE_STRUCT_DEFINE_FIELD_UINT32(demoSt, count, TRACE_STRUCT_SHOW_MODE_DEC);
    TRACE_STRUCT_DEFINE_ARRAY_CHAR(demoSt, tag, 32);
    TRACE_STRUCT_DEFINE_FIELD_UINT64(demoSt, buf, TRACE_STRUCT_SHOW_MODE_DEC);
    TRACE_STRUCT_DEFINE_FIELD_UINT32(demoSt, streamId, TRACE_STRUCT_SHOW_MODE_DEC);
    TRACE_STRUCT_DEFINE_FIELD_UINT32(demoSt, deviceLogicId, TRACE_STRUCT_SHOW_MODE_DEC);
    TRACE_STRUCT_DEFINE_FIELD_UINT8(demoSt, dataType, TRACE_STRUCT_SHOW_MODE_DEC);
    TRACE_STRUCT_DEFINE_FIELD_UINT8(demoSt, root, TRACE_STRUCT_SHOW_MODE_DEC);
    TRACE_STRUCT_DEFINE_ARRAY_UINT8(demoSt, deviceIdArray, TRACE_STRUCT_SHOW_MODE_DEC, 2);
    TRACE_STRUCT_DEFINE_ARRAY_INT8(demoSt, hostIdArray, 4);
    TRACE_STRUCT_SET_ATTR(demoSt, 0, &attr);
    auto handle = UtraceCreateWithAttr(TRACER_TYPE_SCHEDULE, "demo", &attr);
    EXPECT_NE(TRACE_INVALID_HANDLE, handle);

    std::vector<struct demoStructAlign> structList(10);
    for (int i = 0; i < structList.size(); i++) {
        structList[i].tid = i;
        strcpy_s(structList[i].tag, 32, "struct tag");
        structList[i].buf = i;
        structList[i].count = i;
        structList[i].dataType = i;
        structList[i].root = i;
        structList[i].streamId = i;
        structList[i].deviceLogicId = i;
        structList[i].deviceIdArray[0] = i;
        structList[i].deviceIdArray[1] = i + 1;
        structList[i].hostIdArray[0] = i + 1;
        structList[i].hostIdArray[1] = i + 2;
        structList[i].hostIdArray[2] = i + 3;
        structList[i].hostIdArray[3] = i + 4;
        auto ret = UtraceSubmit(handle, (void *)&structList[i], sizeof(struct demoStructAlign));
        EXPECT_EQ(ret, TRACE_SUCCESS);
    }
    UtraceSave(TRACER_TYPE_SCHEDULE, false);
    UtraceDestroy(handle);
    TRACE_STRUCT_UNDEFINE_ENTRY(demoSt);
    TraceExit();
    // delete session node
    EXPECT_EQ(TRACE_SUCCESS, TraceServerDeleteSessionNode(sessionHandle, pid, devId));
    TraceServerExit();
}

TEST_F(TraceServerUtest, UtraceTracerSubmitWithNoSocket)
{
    // server not ready
    TraceInit();
    TraceGlobalAttr globalAttr = { 1, 0, 0 };
    UtraceSetGlobalAttr(&globalAttr);
    TraceAttr attr = { 0 };
    attr.exitSave = true;
    attr.msgSize = DEFAULT_ATRACE_MSG_SIZE;
    attr.msgNum = DEFAULT_ATRACE_MSG_NUM;
    TracerType tracerType = TRACER_TYPE_SCHEDULE;
    const char objName[] = "HCCL";
    const char buffer[] = "msg";
    uint32_t bufSize = sizeof(buffer);

    auto handle = UtraceCreateWithAttr(tracerType, objName, &attr);
    EXPECT_NE(TRACE_INVALID_HANDLE, handle);
    auto status = UtraceSubmit(handle, buffer, bufSize);
    EXPECT_EQ(TRACE_SUCCESS, status);
    UtraceSave(tracerType, false);
    UtraceDestroy(handle);
    TraceExit();
}

TEST_F(TraceServerUtest, TestAtraceCreateWithAttrDataStructDefineAlignWithNoSocket)
{
    // server not ready
    TraceInit();
    TraceGlobalAttr globalAttr = { 1, 0, 0 };
    UtraceSetGlobalAttr(&globalAttr);

    TraceAttr attr = { true, DEFAULT_ATRACE_MSG_NUM, DEFAULT_ATRACE_MSG_SIZE, NULL };
    TRACE_STRUCT_DEFINE_ENTRY(demoSt);
    TRACE_STRUCT_DEFINE_ENTRY_NAME(demoSt, "demo");
    TRACE_STRUCT_DEFINE_FIELD_UINT32(demoSt, tid, TRACE_STRUCT_SHOW_MODE_DEC);
    TRACE_STRUCT_DEFINE_FIELD_UINT32(demoSt, count, TRACE_STRUCT_SHOW_MODE_DEC);
    TRACE_STRUCT_DEFINE_ARRAY_CHAR(demoSt, tag, 32);
    TRACE_STRUCT_DEFINE_FIELD_UINT64(demoSt, buf, TRACE_STRUCT_SHOW_MODE_DEC);
    TRACE_STRUCT_DEFINE_FIELD_UINT32(demoSt, streamId, TRACE_STRUCT_SHOW_MODE_DEC);
    TRACE_STRUCT_DEFINE_FIELD_UINT32(demoSt, deviceLogicId, TRACE_STRUCT_SHOW_MODE_DEC);
    TRACE_STRUCT_DEFINE_FIELD_UINT8(demoSt, dataType, TRACE_STRUCT_SHOW_MODE_DEC);
    TRACE_STRUCT_DEFINE_FIELD_UINT8(demoSt, root, TRACE_STRUCT_SHOW_MODE_DEC);
    TRACE_STRUCT_DEFINE_ARRAY_UINT8(demoSt, deviceIdArray, TRACE_STRUCT_SHOW_MODE_DEC, 2);
    TRACE_STRUCT_DEFINE_ARRAY_INT8(demoSt, hostIdArray, 4);
    TRACE_STRUCT_SET_ATTR(demoSt, 0, &attr);
    auto handle = UtraceCreateWithAttr(TRACER_TYPE_SCHEDULE, "demo", &attr);
    EXPECT_NE(TRACE_INVALID_HANDLE, handle);

    std::vector<struct demoStructAlign> structList(10);
    for (int i = 0; i < structList.size(); i++) {
        structList[i].tid = i;
        strcpy_s(structList[i].tag, 32, "struct tag");
        structList[i].buf = i;
        structList[i].count = i;
        structList[i].dataType = i;
        structList[i].root = i;
        structList[i].streamId = i;
        structList[i].deviceLogicId = i;
        structList[i].deviceIdArray[0] = i;
        structList[i].deviceIdArray[1] = i + 1;
        structList[i].hostIdArray[0] = i + 1;
        structList[i].hostIdArray[1] = i + 2;
        structList[i].hostIdArray[2] = i + 3;
        structList[i].hostIdArray[3] = i + 4;
        auto ret = UtraceSubmit(handle, (void *)&structList[i], sizeof(struct demoStructAlign));
        EXPECT_EQ(ret, TRACE_SUCCESS);
    }
    UtraceSave(TRACER_TYPE_SCHEDULE, false);
    UtraceDestroy(handle);
    TRACE_STRUCT_UNDEFINE_ENTRY(demoSt);
    TraceExit();
}

TEST_F(TraceServerUtest, TraceServerSocketThreadFailed)
{
    MOCKER(TraceCreateTaskWithThreadAttr).stubs().will(returnValue(TRACE_FAILURE));
    EXPECT_EQ(TRACE_FAILURE, TraceServerCreateSocketRecv(-1));
}

TEST_F(TraceServerUtest, TraceServerSocketPathFailed)
{
    MOCKER(vsprintf_s).stubs().will(returnValue(-1));
    EXPECT_EQ(TRACE_FAILURE, TraceServerCreateSocketRecv(-1));
    EXPECT_EQ(TRACE_FAILURE, TraceServerCreateSocketRecv(32));
}

TEST_F(TraceServerUtest, TraceServerSetSocketFailed)
{
    MOCKER(setsockopt).stubs().will(returnValue(-1)).then(returnValue(0));
    MOCKER(mmBind).stubs().will(returnValue(-1)).then(returnValue(0));
    MOCKER(chmod).stubs().will(returnValue(-1)).then(returnValue(0));
    EXPECT_EQ(TRACE_FAILURE, TraceServerCreateSocketRecv(-1));
    EXPECT_EQ(TRACE_FAILURE, TraceServerCreateSocketRecv(-1));
    EXPECT_EQ(TRACE_FAILURE, TraceServerCreateSocketRecv(-1));
}

TEST_F(TraceServerUtest, UtraceSetSocketFailed)
{
    MOCKER(setsockopt).stubs().will(returnValue(-1)).then(returnValue(0));
    MOCKER(strcpy_s).stubs().will(returnValue(EOK + 1));
    MOCKER(mmCloseSocket).stubs().will(returnValue(-1));
    EXPECT_EQ(TRACE_FAILURE, UtraceCreateSocket(-1));
    EXPECT_EQ(TRACE_FAILURE, UtraceCreateSocket(-1));
}

TEST_F(TraceServerUtest, UtraceWithNodata)
{
    TraceInit();
    TraceGlobalAttr globalAttr = { 1, 0, 0 };
    UtraceSetGlobalAttr(&globalAttr);
    TraceAttr attr = { true, DEFAULT_ATRACE_MSG_NUM, DEFAULT_ATRACE_MSG_SIZE, NULL };
    auto handle1 = UtraceCreateWithAttr(TRACER_TYPE_SCHEDULE, "demo", &attr);
    EXPECT_NE(TRACE_INVALID_HANDLE, handle1);
    TRACE_STRUCT_DEFINE_ENTRY(demoSt);
    TRACE_STRUCT_DEFINE_ENTRY_NAME(demoSt, "demo");
    TRACE_STRUCT_DEFINE_FIELD_UINT32(demoSt, tid, TRACE_STRUCT_SHOW_MODE_DEC);
    TRACE_STRUCT_DEFINE_FIELD_UINT32(demoSt, count, TRACE_STRUCT_SHOW_MODE_DEC);
    TRACE_STRUCT_SET_ATTR(demoSt, 0, &attr);
    auto handle2 = UtraceCreateWithAttr(TRACER_TYPE_SCHEDULE, "demo", &attr);
    EXPECT_NE(TRACE_INVALID_HANDLE, handle2);

    UtraceDestroy(handle1);
    UtraceDestroy(handle2);
    TRACE_STRUCT_UNDEFINE_ENTRY(demoSt);
    TraceExit();
}