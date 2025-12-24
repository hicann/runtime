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
#include "atrace_api.h"
#include "tracer_core.h"
#include "stacktrace_signal.h"
#include "trace_attr.h"
#include "adiag_list.h"
#include "adiag_utils.h"
#include "trace_system_api.h"
#include <pwd.h>

extern "C" {
    void TraceInit(void);
    void TraceExit(void);
}

class UtraceUtest: public testing::Test {
protected:
    static void SetUpTestCase()
    {
        system("mkdir -p " LLT_TEST_DIR);
        struct passwd *pwd = getpwuid(getuid());
        pwd->pw_dir = LLT_TEST_DIR;
        MOCKER(getpwuid).stubs().will(returnValue(pwd));

        TraceInit();
    }
    virtual void SetUp()
    {
    }
    virtual void TearDown()
    {
        GlobalMockObject::verify();
    }
    static void TearDownTestCase()
    {
        TraceExit();
        system("rm -rf " LLT_TEST_DIR);
    }
};

static TraHandle handle_ = -1;
TEST_F(UtraceUtest, TestAtraceCreateAndDestroy)
{
    TracerType tracerType = TRACER_TYPE_SCHEDULE;
    const char objName[] = "HCCL";
    handle_ = AtraceCreate(tracerType, objName);
    EXPECT_NE(TRACE_INVALID_HANDLE, handle_);
    auto handle = AtraceCreate(tracerType, objName);
    EXPECT_NE(handle_, handle);
}

TEST_F(UtraceUtest, TestAtraceGetHandle)
{
    TracerType tracerType = TRACER_TYPE_SCHEDULE;
    const char objName[] = "HCCL";
    auto handle = AtraceGetHandle(tracerType, objName);
    EXPECT_EQ(handle_, handle);
}

TEST_F(UtraceUtest, TestAtraceSubmit)
{
    const char buffer[] = "msg";
    uint32_t bufSize = sizeof(buffer);
    auto status = AtraceSubmit(handle_, buffer, bufSize);
    EXPECT_EQ(TRACE_SUCCESS, status);
    AtraceDestroy(handle_);
}

TEST_F(UtraceUtest, TestAtraceSave)
{
    TracerType tracerType = TRACER_TYPE_SCHEDULE;
    auto status = AtraceSave(tracerType, false);
    EXPECT_EQ(TRACE_SUCCESS, status);

    status = TracerSave(tracerType, true);
    EXPECT_EQ(TRACE_SUCCESS, status);
}

TEST_F(UtraceUtest, TestAtraceCreateWithAttr)
{
    TraceAttr attr = { 0 };
    attr.exitSave = true;
    attr.msgSize = DEFAULT_ATRACE_MSG_SIZE;
    attr.msgNum = DEFAULT_ATRACE_MSG_NUM;
    TracerType tracerType = TRACER_TYPE_SCHEDULE;
    const char objName[] = "HCCL";
    const char buffer[] = "msg";
    uint32_t bufSize = sizeof(buffer);

    auto handle = AtraceCreateWithAttr(tracerType, objName, &attr);
    EXPECT_NE(TRACE_INVALID_HANDLE, handle);
    auto status = AtraceSubmit(handle, buffer, bufSize);
    EXPECT_EQ(TRACE_SUCCESS, status);
    AtraceDestroy(handle);
}

TEST_F(UtraceUtest, TestAtraceCreateWithAttrLockFree)
{
    TraceAttr attr = { 0 };
    attr.exitSave = true;
    attr.msgSize = DEFAULT_ATRACE_MSG_SIZE;
    attr.msgNum = DEFAULT_ATRACE_MSG_NUM;
    attr.noLock = TRACE_LOCK_FREE;
    TracerType tracerType = TRACER_TYPE_SCHEDULE;
    const char objName[] = "HCCL";
    const char buffer[] = "msg";
    uint32_t bufSize = sizeof(buffer);

    auto handle = AtraceCreateWithAttr(tracerType, objName, &attr);
    EXPECT_NE(TRACE_INVALID_HANDLE, handle);
    auto status = AtraceSubmit(handle, buffer, bufSize);
    EXPECT_EQ(TRACE_SUCCESS, status);
    AtraceDestroy(handle);
}

TEST_F(UtraceUtest, TestGetHandleAfterDestroy)
{
    TracerType tracerType = TRACER_TYPE_SCHEDULE;
    std::string buffer = "msg";
    size_t bufSize = buffer.length();
    const char objName[] = "FE";    
    auto handle = AtraceCreate(tracerType, objName);
    EXPECT_NE(TRACE_INVALID_HANDLE, handle);
    auto ret = AtraceSubmit(handle, buffer.c_str(), bufSize);
    EXPECT_EQ(ret, TRACE_SUCCESS);

    // restoration
    AtraceDestroy(handle);
    handle = AtraceGetHandle(tracerType, objName);
    EXPECT_EQ(TRACE_INVALID_HANDLE, handle);
    ret = AtraceSubmit(handle, buffer.c_str(), bufSize);
    EXPECT_EQ(ret, TRACE_FAILURE);
}

TEST_F(UtraceUtest, TestApiNotSupported)
{
    MOCKER(AtraceCheckSupported)
        .stubs()
        .will(returnValue(false));
    TracerType tracerType = TRACER_TYPE_SCHEDULE;
    const char objName[] = "HCCL";
    const char buffer[] = "msg";
    uint32_t bufSize = sizeof(buffer);
    TraceAttr attr = { 0 };
    attr.exitSave = true;

    auto handle = AtraceCreate(tracerType, objName);
    EXPECT_EQ(handle, TRACE_UNSUPPORTED_HANDLE);
    handle = AtraceCreateWithAttr(tracerType, objName, &attr);
    EXPECT_EQ(handle, TRACE_UNSUPPORTED_HANDLE);
    handle = AtraceGetHandle(tracerType, objName);
    EXPECT_EQ(handle, TRACE_UNSUPPORTED_HANDLE);
    auto status = AtraceSave(tracerType, false);
    EXPECT_EQ(status, TRACE_UNSUPPORTED);

    AtraceDestroy(handle);
}

TEST_F(UtraceUtest, TestOpenFailed)
{
    MOCKER(TraceOpen)
        .stubs()
        .will(returnValue(-1));
    TracerType tracerType = TRACER_TYPE_SCHEDULE;
    const char objName[] = "HCCL";
    const char buffer[] = "msg";
    uint32_t bufSize = sizeof(buffer);

    auto handle = AtraceCreate(tracerType, objName);
    EXPECT_LT(TRACE_INVALID_HANDLE, handle);
    handle = AtraceGetHandle(tracerType, objName);
    EXPECT_LT(TRACE_INVALID_HANDLE, handle);
    auto status = AtraceSubmit(handle, buffer, bufSize);
    EXPECT_EQ(TRACE_SUCCESS, status);
    status = AtraceSave(tracerType, false);
    EXPECT_EQ(TRACE_SUCCESS, status);

    AtraceDestroy(handle);
}

TEST_F(UtraceUtest, TestAtraceCreatelongerName)
{
    TracerType tracerType = TRACER_TYPE_SCHEDULE;
    const char objName[] = "TestName_CurentNameIsLongerThan34";
    RbLogCtrl head = {"name", 0, 0, 0, 0, 0, 0, 0, 0, 0};
    RbLog data = {head};
    MOCKER(TraceRbLogCreate)
        .stubs()
        .will(returnValue(&data));
    MOCKER(TraceRbLogDestroy)
        .stubs();

    auto handle = AtraceCreate(tracerType, objName);
    EXPECT_EQ(TRACE_INVALID_HANDLE, handle);
}

TEST_F(UtraceUtest, TestAtraceDestroyFailed)
{
    TracerType tracerType = TRACER_TYPE_SCHEDULE;
    const char objName[] = "HCCL";
    const char buffer[] = "msg";
    uint32_t bufSize = sizeof(buffer);

    auto handle = AtraceCreate(tracerType, objName);
    EXPECT_LT(TRACE_INVALID_HANDLE, handle);
    MOCKER(AdiagMalloc)
    .stubs()
    .will(returnValue((void *)0));

    AtraceDestroy(handle);
    GlobalMockObject::verify();

    MOCKER(AdiagListInsert)
    .stubs()
    .will(returnValue(TRACE_FAILURE));
    AtraceDestroy(handle);

    GlobalMockObject::verify();
    AtraceDestroy(handle);

    AtraceDestroy(TRACE_INVALID_HANDLE);
    AtraceDestroy(0);
}

TEST_F(UtraceUtest, TestAtraceSaveFailed)
{
    TracerType tracerType = TRACER_TYPE_SCHEDULE;
    const char objName[] = "HCCL";
    const char buffer[] = "msg";
    uint32_t bufSize = sizeof(buffer);

    auto handle = AtraceCreate(tracerType, objName);
    EXPECT_LT(TRACE_INVALID_HANDLE, handle);
    auto status = AtraceSubmit(handle, buffer, bufSize);
    EXPECT_EQ(TRACE_SUCCESS, status);
    // TraceRecorderGetDirPath failed
    MOCKER(AdiagMalloc)
    .stubs()
    .will(returnValue((void *)0));

    status = AtraceSave(tracerType, false);
    EXPECT_EQ(TRACE_FAILURE, status);
    GlobalMockObject::verify();

    // TraceRbLogGetCopyOfRingBuffer failed
    MOCKER(TraceRbLogGetCopyOfRingBuffer)
    .stubs()
    .will(returnValue(TRACE_FAILURE));
    status = AtraceSave(tracerType, false);
    EXPECT_EQ(TRACE_FAILURE, status);

    GlobalMockObject::verify();
    AtraceDestroy(handle);
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

TEST_F(UtraceUtest, TestAtraceCreateWithAttrDataStructDefineAlign)
{
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
    auto handle = AtraceCreateWithAttr(TRACER_TYPE_SCHEDULE, "demo", &attr);
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
        auto ret = AtraceSubmit(handle, (void *)&structList[i], sizeof(struct demoStructAlign));
        EXPECT_EQ(ret, TRACE_SUCCESS);
    }

    AtraceDestroy(handle);
    TRACE_STRUCT_UNDEFINE_ENTRY(demoSt);
}

TEST_F(UtraceUtest, TestAtraceCreateWithAttrDataStructDefineMallocFailed)
{
    TraceAttr attr = { true, DEFAULT_ATRACE_MSG_NUM, DEFAULT_ATRACE_MSG_SIZE, NULL };
    MOCKER(AdiagMalloc).stubs().will(returnValue((void*)NULL));
    TRACE_STRUCT_DEFINE_ENTRY(demoSt);
    TRACE_STRUCT_DEFINE_ENTRY_NAME(demoSt, "demo");
    TRACE_STRUCT_DEFINE_FIELD_UINT32(demoSt, tid, TRACE_STRUCT_SHOW_MODE_DEC);
    TRACE_STRUCT_SET_ATTR(demoSt, 0, &attr);
    auto handle = AtraceCreateWithAttr(TRACER_TYPE_SCHEDULE, "demo", &attr);
    EXPECT_EQ(TRACE_INVALID_HANDLE, handle);
    EXPECT_EQ(demoSt.list, (void*)NULL);
    AtraceDestroy(handle);
    TRACE_STRUCT_UNDEFINE_ENTRY(demoSt);
}

TEST_F(UtraceUtest, TestAtraceCreateWithAttrDataStructDefineNameNull)
{
    TraceAttr attr = { true, DEFAULT_ATRACE_MSG_NUM, DEFAULT_ATRACE_MSG_SIZE, NULL };
    TRACE_STRUCT_DEFINE_ENTRY(demoSt);
    TRACE_STRUCT_DEFINE_ENTRY_NAME(demoSt, "");
    TRACE_STRUCT_DEFINE_FIELD_UINT32(demoSt, tid, TRACE_STRUCT_SHOW_MODE_DEC);
    TRACE_STRUCT_SET_ATTR(demoSt, 0, &attr);
    auto handle = AtraceCreateWithAttr(TRACER_TYPE_SCHEDULE, "demo", &attr);
    EXPECT_NE(TRACE_INVALID_HANDLE, handle);
    EXPECT_STREQ(demoSt.name, "");
    AtraceDestroy(handle);
    TRACE_STRUCT_UNDEFINE_ENTRY(demoSt);
}

TEST_F(UtraceUtest, TestAtraceCreateWithAttrDataStructDefineStrcpyFailed)
{
    MOCKER(strcpy_s).stubs().will(returnValue(-1));
    TraceAttr attr = { true, DEFAULT_ATRACE_MSG_NUM, DEFAULT_ATRACE_MSG_SIZE, NULL };
    TRACE_STRUCT_DEFINE_ENTRY(demoSt);
    TRACE_STRUCT_DEFINE_ENTRY_NAME(demoSt, "demo");
    TRACE_STRUCT_DEFINE_FIELD_UINT32(demoSt, tid, TRACE_STRUCT_SHOW_MODE_DEC);
    TRACE_STRUCT_SET_ATTR(demoSt, 0, &attr);
    auto handle = AtraceCreateWithAttr(TRACER_TYPE_SCHEDULE, "demo", &attr);
    EXPECT_EQ(TRACE_INVALID_HANDLE, handle);
    EXPECT_STREQ(demoSt.name, "");
    AtraceDestroy(handle);
    TRACE_STRUCT_UNDEFINE_ENTRY(demoSt);
}

TEST_F(UtraceUtest, TestAtraceCreateWithAttrDataStructDefineListNull)
{
    TraceAttr attr = { true, DEFAULT_ATRACE_MSG_NUM, DEFAULT_ATRACE_MSG_SIZE, NULL };
    TRACE_STRUCT_DEFINE_ENTRY(demoSt);
    TRACE_STRUCT_DEFINE_ENTRY_NAME(demoSt, "demo");
    TRACE_STRUCT_SET_ATTR(demoSt, 0, &attr);
    auto handle = AtraceCreateWithAttr(TRACER_TYPE_SCHEDULE, "demo", &attr);
    EXPECT_NE(TRACE_INVALID_HANDLE, handle);
    EXPECT_STREQ(demoSt.name, "demo");
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
        auto ret = AtraceSubmit(handle, (void *)&structList[i], sizeof(struct demoStructAlign));
        EXPECT_EQ(ret, TRACE_SUCCESS);
    }
    AtraceDestroy(handle);
    TRACE_STRUCT_UNDEFINE_ENTRY(demoSt);
}

TEST_F(UtraceUtest, TestAtraceCreateWithAttrDataStructDefineAlignSafe)
{
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
    auto handle = AtraceCreateWithAttr(TRACER_TYPE_SCHEDULE, "demo", &attr);
    EXPECT_NE(TRACE_INVALID_HANDLE, handle);

    std::vector<struct demoStructAlign> structList(1);
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
        auto ret = AtraceSubmit(handle, (void *)&structList[i], sizeof(struct demoStructAlign));
        EXPECT_EQ(ret, TRACE_SUCCESS);
    }
    raise(SIGTERM);
    AtraceDestroy(handle);
    TRACE_STRUCT_UNDEFINE_ENTRY(demoSt);
}

TEST_F(UtraceUtest, TestAtraceSafeSave)
{
    TraceExit();
    TraceInit();
    TracerType tracerType = TRACER_TYPE_SCHEDULE;
    const char objName[] = "HCCL";
    const char buffer[] = "msg";
    uint32_t bufSize = sizeof(buffer);

    auto handle = AtraceCreate(tracerType, objName);
    EXPECT_LT(TRACE_INVALID_HANDLE, handle);
    auto status = AtraceSubmit(handle, buffer, bufSize);
    EXPECT_EQ(TRACE_SUCCESS, status);

    raise(SIGINT);
    AtraceDestroy(handle);
}

TEST_F(UtraceUtest, TestAtraceCreateWithAttrDataStructListInitFailed)
{
    MOCKER(mmMutexInit).stubs().will(returnValue(-1));
    TRACE_STRUCT_DEFINE_ENTRY(en);
    EXPECT_EQ(en.list, (void *)NULL);
    TRACE_STRUCT_UNDEFINE_ENTRY(en);
}

TEST_F(UtraceUtest, TestAtraceCreateWithAttrDataStructListItemFailed)
{
    TRACE_STRUCT_DEFINE_ENTRY(en);
    TRACE_STRUCT_DEFINE_ENTRY_NAME(en, "demo");
    MOCKER(AdiagMalloc).stubs().will(returnValue((void *)NULL));
    TRACE_STRUCT_DEFINE_FIELD_UINT32(en, tid, TRACE_STRUCT_SHOW_MODE_DEC);
    EXPECT_EQ(ListEmpty(&((struct AdiagList *)en.list)->list), true);
    TRACE_STRUCT_UNDEFINE_ENTRY(en);
}

TEST_F(UtraceUtest, TestAtraceCreateWithAttrDataStructFuncDefineAlign)
{
    TraceAttr attr = { true, DEFAULT_ATRACE_MSG_NUM, DEFAULT_ATRACE_MSG_SIZE, NULL };
    TraceStructEntry *demoSt = AtraceStructEntryCreate("demo");
    AtraceStructItemFieldSet(demoSt, "tid", TRACE_STRUCT_FIELD_TYPE_UINT32, TRACE_STRUCT_SHOW_MODE_DEC, 4);
    AtraceStructItemFieldSet(demoSt, "count", TRACE_STRUCT_FIELD_TYPE_UINT32, TRACE_STRUCT_SHOW_MODE_DEC, 4);
    AtraceStructItemArraySet(demoSt, "tag", TRACE_STRUCT_ARRAY_TYPE_CHAR, TRACE_STRUCT_SHOW_MODE_CHAR, 32);
    AtraceStructItemFieldSet(demoSt, "buf", TRACE_STRUCT_FIELD_TYPE_UINT64, TRACE_STRUCT_SHOW_MODE_DEC, 8);
    AtraceStructItemFieldSet(demoSt, "streamId", TRACE_STRUCT_FIELD_TYPE_UINT32, TRACE_STRUCT_SHOW_MODE_DEC, 4);
    AtraceStructItemFieldSet(demoSt, "deviceLogicId", TRACE_STRUCT_FIELD_TYPE_UINT32, TRACE_STRUCT_SHOW_MODE_DEC, 4);
    AtraceStructItemFieldSet(demoSt, "dataType", TRACE_STRUCT_FIELD_TYPE_UINT8, TRACE_STRUCT_SHOW_MODE_DEC, 1);
    AtraceStructItemFieldSet(demoSt, "root", TRACE_STRUCT_FIELD_TYPE_UINT8, TRACE_STRUCT_SHOW_MODE_DEC, 1);
    AtraceStructItemArraySet(demoSt, "deviceIdArray", TRACE_STRUCT_ARRAY_TYPE_UINT8, TRACE_STRUCT_SHOW_MODE_DEC, 2);
    AtraceStructItemArraySet(demoSt, "hostIdArray", TRACE_STRUCT_ARRAY_TYPE_INT8, TRACE_STRUCT_SHOW_MODE_DEC, 4);
    AtraceStructSetAttr(demoSt, 0, &attr);
    auto handle = AtraceCreateWithAttr(TRACER_TYPE_SCHEDULE, "demo", &attr);
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
        auto ret = AtraceSubmit(handle, (void *)&structList[i], sizeof(struct demoStructAlign));
        EXPECT_EQ(ret, TRACE_SUCCESS);
    }

    AtraceDestroy(handle);
    AtraceStructEntryDestroy(demoSt);
}

TEST_F(UtraceUtest, TestAtraceCreateWithAttrDataStructDefineAlignWithNodata)
{
    TraceAttr attr = { true, DEFAULT_ATRACE_MSG_NUM, DEFAULT_ATRACE_MSG_SIZE, NULL };
    auto handle1 = AtraceCreateWithAttr(TRACER_TYPE_SCHEDULE, "demo", &attr);
    EXPECT_NE(TRACE_INVALID_HANDLE, handle1);
    TRACE_STRUCT_DEFINE_ENTRY(demoSt);
    TRACE_STRUCT_DEFINE_ENTRY_NAME(demoSt, "demo");
    TRACE_STRUCT_DEFINE_FIELD_UINT32(demoSt, tid, TRACE_STRUCT_SHOW_MODE_DEC);
    TRACE_STRUCT_DEFINE_FIELD_UINT32(demoSt, count, TRACE_STRUCT_SHOW_MODE_DEC);
    TRACE_STRUCT_SET_ATTR(demoSt, 0, &attr);
    auto handle2 = AtraceCreateWithAttr(TRACER_TYPE_SCHEDULE, "demo", &attr);
    EXPECT_NE(TRACE_INVALID_HANDLE, handle2);

    AtraceDestroy(handle1);
    AtraceDestroy(handle2);
    TRACE_STRUCT_UNDEFINE_ENTRY(demoSt);
}

TEST_F(UtraceUtest, TraceTimeDstInitFailed)
{
    MOCKER(mmGetTimeOfDay).stubs().will(returnValue(-1)).then(returnValue(0));
    MOCKER(mmLocalTimeR).stubs().will(returnValue(-1));
    EXPECT_EQ(TRACE_FAILURE, TraceTimeDstInit());
    EXPECT_EQ(TRACE_FAILURE, TraceTimeDstInit());
}

TEST_F(UtraceUtest, TimestampToStrFailed)
{
    MOCKER(vsprintf_s).stubs().will(returnValue(-1));
    EXPECT_EQ(TRACE_RING_BUFFER_SPRINTF_FAILED, TimestampToStr(0, NULL, 0));
    EXPECT_EQ(TRACE_RING_BUFFER_SPRINTF_FAILED, TimestampToFileStr(0, NULL, 0));
}

TEST_F(UtraceUtest, TimestampOffsetFailed)
{
    MOCKER(mmGetTimeOfDay).stubs().will(returnValue(-1)).then(returnValue(0));
    MOCKER(localtime_r).stubs().will(returnValue((struct tm *)NULL));
    int32_t time = 0;
    EXPECT_EQ(TRACE_FAILURE, TraceGetTimeOffset(&time));
    EXPECT_EQ(TRACE_FAILURE, TraceGetTimeOffset(&time));
}

TEST_F(UtraceUtest, TraceAttrInitTimeFailed)
{
    MOCKER(mmGetTimeOfDay).stubs().will(returnValue(-1));
    EXPECT_EQ(TRACE_FAILURE, TraceAttrInit());
}

TEST_F(UtraceUtest, TestExitSave_SameObjName)
{
    TraceAttr attr = { 0 };
    attr.exitSave = true;
    attr.msgSize = DEFAULT_ATRACE_MSG_SIZE;
    attr.msgNum = DEFAULT_ATRACE_MSG_NUM;
    TracerType tracerType = TRACER_TYPE_SCHEDULE;
    const char objName[] = "HCCL";
    std::string buffer = std::string(128, '*');

    for (int i = 0; i < 2; i++) {
        auto handle = AtraceCreateWithAttr(tracerType, objName, &attr);
        EXPECT_NE(TRACE_INVALID_HANDLE, handle);
        for (uint32_t i = 0; i < 2048; i++) {
            auto status = AtraceSubmit(handle, buffer.c_str(), buffer.size());
            EXPECT_EQ(TRACE_SUCCESS, status);
        }
        AtraceDestroy(handle);
    }
    TraceExit();
}