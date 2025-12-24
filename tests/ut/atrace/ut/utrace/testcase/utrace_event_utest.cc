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
#include <pwd.h>
#include "trace_event.h"
#include "ascend_hal.h"
#include "tracer_core.h"

extern "C" {
    void TraceInit(void);
    void TraceExit(void);
    TraStatus TraceEventInit(void);
    TraStatus TraceEventSave(void *arg);
    void *AdiagMalloc(size_t size);
    TraStatus AdiagListInit(struct AdiagList *traList);
    bool AtraceCheckSupported(void);
}

class UtraceEventUtest: public testing::Test {
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

TEST_F(UtraceEventUtest, TestTraceEventNotSupport)
{
    MOCKER(AtraceCheckSupported).stubs().will(returnValue(false));
    char eventName[] = "tmp";
    EXPECT_EQ(AtraceEventCreate(eventName), TRACE_UNSUPPORTED_HANDLE);
    EXPECT_EQ(AtraceEventGetHandle(eventName), TRACE_UNSUPPORTED_HANDLE);
    TraEventHandle eventHandle;
    TraHandle handle;
    EXPECT_EQ(AtraceEventBindTrace(eventHandle, handle), TRACE_UNSUPPORTED);
    EXPECT_EQ(AtraceEventSetAttr(eventHandle, nullptr), TRACE_UNSUPPORTED);
    AtraceEventDestroy(eventHandle);
}

TEST_F(UtraceEventUtest, TestTraceEventInitMallocFailed)
{
    TraceExit();
    MOCKER(AdiagMalloc).stubs().will(returnValue((void*)nullptr));
    EXPECT_EQ(TraceEventInit(), TRACE_FAILURE);
    GlobalMockObject::verify();
    TraceInit();
}

TEST_F(UtraceEventUtest, TestTraceEventInitListInitFailed)
{
    TraceExit();
    MOCKER(AdiagListInit).stubs()
        .will(returnValue(TRACE_FAILURE))
        .then(returnValue(TRACE_SUCCESS))
        .then(returnValue(TRACE_FAILURE));
    EXPECT_EQ(TraceEventInit(), TRACE_FAILURE);
    EXPECT_EQ(TraceEventInit(), TRACE_FAILURE);
    GlobalMockObject::verify();
    TraceInit();
}

TEST_F(UtraceEventUtest, TestAtraceEventCreate)
{
    TraEventHandle handle = AtraceEventCreate(NULL);
    EXPECT_EQ(handle, TRACE_INVALID_HANDLE);

    std::string name = std::string(32, 'a');
    handle = AtraceEventCreate(name.c_str());
    EXPECT_EQ(handle, TRACE_INVALID_HANDLE);

    name = std::string(31, 'a');
    handle = AtraceEventCreate(name.c_str());
    EXPECT_NE(handle, TRACE_INVALID_HANDLE);

    auto handle2 = AtraceEventCreate(name.c_str());
    EXPECT_EQ(handle2, TRACE_INVALID_HANDLE);

    AtraceEventDestroy(handle);
}

TEST_F(UtraceEventUtest, TestAtraceEventGetHandle)
{
    TraEventHandle ceratedHandle = AtraceEventCreate("1234");
    EXPECT_NE(ceratedHandle, TRACE_INVALID_HANDLE);

    std::string name = std::string(31, 'a');
    ceratedHandle = AtraceEventCreate(name.c_str());
    EXPECT_NE(ceratedHandle, TRACE_INVALID_HANDLE);

    TraEventHandle handle = AtraceEventGetHandle(NULL);
    EXPECT_EQ(handle, TRACE_INVALID_HANDLE);

    std::string name2 = std::string(32, 'a');
    handle = AtraceEventGetHandle(name2.c_str());
    EXPECT_EQ(handle, TRACE_INVALID_HANDLE);

    handle = AtraceEventGetHandle(name.c_str());
    EXPECT_EQ(handle, ceratedHandle);

    AtraceEventDestroy(-2);
    AtraceEventDestroy(-1);
    AtraceEventDestroy(ceratedHandle);
}

TEST_F(UtraceEventUtest, TestAtraceEventSetAttr)
{
    TraEventHandle eventHandle = AtraceEventCreate("event");
    TraceEventAttr attr = {0};
    std::set<int> invalidHandleList = {-1, 0, 1};
    for (auto invalidHandle : invalidHandleList) {
        TraStatus ret = AtraceEventSetAttr(invalidHandle, &attr);
        EXPECT_NE(ret, TRACE_SUCCESS);
    }
}

TEST_F(UtraceEventUtest, TestAtraceEventBindTrace)
{
    TraEventHandle eventHandle = AtraceEventCreate("event");
    TraHandle handle = AtraceCreate(TRACER_TYPE_SCHEDULE, "trace");
    std::set<int> invalidHandleList = {-1, 0};
    for (auto invalidHandle : invalidHandleList) {
        TraStatus ret = AtraceEventBindTrace(invalidHandle, handle);
        EXPECT_NE(ret, TRACE_SUCCESS);
        ret = AtraceEventBindTrace(eventHandle, invalidHandle);
        EXPECT_NE(ret, TRACE_SUCCESS);
    }
    AtraceEventDestroy(eventHandle);
    AtraceDestroy(handle);
}

using TestEventFunc = std::function<void(TraHandle &)>;
void TestEvent(TestEventFunc func)
{
    TracerType tracerType = TRACER_TYPE_SCHEDULE;
    const char objName1[] = "HCCL";    
    auto handle1 = AtraceCreate(tracerType, objName1);
    auto ret = AtraceSubmit(handle1, objName1, sizeof(objName1));
    EXPECT_EQ(ret, TRACE_SUCCESS);
    const char objName2[] = "RUNTIME";
    auto handle2 = AtraceCreate(tracerType, objName2);
    ret = AtraceSubmit(handle2, objName2, sizeof(objName2));
    EXPECT_EQ(ret, TRACE_SUCCESS);

    // Check
    func(handle1);

    // restoration
    AtraceDestroy(handle1);
    AtraceDestroy(handle2);
}

TEST_F(UtraceEventUtest, TestTraceEventReportBindOne)
{
    TestEvent([](TraHandle &handle) -> void {
        auto eventHandle = AtraceEventCreate("save_hccl");
        TraStatus ret = AtraceEventBindTrace(eventHandle, handle);
        EXPECT_EQ(ret, TRACE_SUCCESS);
        AtraceEventReport(eventHandle);
        AtraceEventDestroy(eventHandle);
    });
}

TEST_F(UtraceEventUtest, TestTraceEventReportSyncBindOne)
{
    TestEvent([](TraHandle &handle) -> void {
        auto eventHandle = AtraceEventCreate("save_hccl");
        TraStatus ret = AtraceEventBindTrace(eventHandle, handle);
        EXPECT_EQ(ret, TRACE_SUCCESS);
        AtraceEventReportSync(eventHandle);
        AtraceEventDestroy(eventHandle);
    });
}

static drvError_t drvGetPlatformInfoStub(uint32_t *info)
{
    *info = 0; // DEVICE_SIDE
    return DRV_ERROR_NONE;
}

TEST_F(UtraceEventUtest, TestTraceEventReportSyncNotSupport)
{
    TraceExit();
    MOCKER(drvGetPlatformInfo)
        .stubs()
        .will(invoke(drvGetPlatformInfoStub));
    TraceInit();
    EXPECT_EQ(TRACE_UNSUPPORTED, AtraceEventReportSync(0));
    GlobalMockObject::verify();
    TraceExit();
    TraceInit();
}

TEST_F(UtraceEventUtest, TestTraceEventReportLimitedNum)
{
    std::map<int, int> limitedNumMap = {
        {-1, 2},  // not set limited num, expect unlimied
        {0, 2},   // set unlimited, expect unlimied
        {1, 1},   // set limited num 1, expect 1
        {2, 2},   // set limited num 2, expect 2
        {3, 2},   // set limited num 3, expect 2
    };
    for (auto limitedNum : limitedNumMap) {
        TestEvent([&limitedNum](TraHandle &handle) -> void {
            auto eventHandle = AtraceEventCreate("save_hccl");
            TraStatus ret = AtraceEventBindTrace(eventHandle, handle);

            if (limitedNum.first != -1) {
                TraceEventAttr attr = {0};
                attr.limitedNum = limitedNum.first;
                AtraceEventSetAttr(eventHandle, &attr);
            }
            EXPECT_EQ(ret, TRACE_SUCCESS);
            for (int i = 0; i < limitedNum.first; i++) {
                EXPECT_EQ(AtraceEventReport(eventHandle), TRACE_SUCCESS);
            }
            AtraceEventDestroy(eventHandle);
        });
    }
}

TEST_F(UtraceEventUtest, TestTraceEventReportUpperLimitedNum)
{
    uint32_t limitedNum = 65535;
    MOCKER(TraceEventSave).expects(exactly(limitedNum)).will(returnValue(TRACE_SUCCESS));
    TestEvent([&limitedNum](TraHandle &handle) -> void {
        auto eventHandle = AtraceEventCreate("save_hccl");
        TraStatus ret = AtraceEventBindTrace(eventHandle, handle);

        if (limitedNum != -1) {
            TraceEventAttr attr = {0};
            attr.limitedNum = limitedNum;
            AtraceEventSetAttr(eventHandle, &attr);
        }
        EXPECT_EQ(ret, TRACE_SUCCESS);
        for (int i = 0; i < limitedNum; i++) {
            EXPECT_EQ(AtraceEventReport(eventHandle), TRACE_SUCCESS);
        }
        AtraceEventReport(eventHandle);
        AtraceEventDestroy(eventHandle);
    });

}

TEST_F(UtraceEventUtest, TestTraceEventReportAsync)
{
    TracerType tracerType = TRACER_TYPE_SCHEDULE;
    const char objName[] = "HCCL";    
    auto handle = AtraceCreate(tracerType, objName);
    auto ret = AtraceSubmit(handle, objName, sizeof(objName));
    EXPECT_EQ(ret, TRACE_SUCCESS);

    // Check
    auto eventHandle = AtraceEventCreate("save_hccl");
    ret = AtraceEventBindTrace(eventHandle, handle);
    TraceEventAttr attr = {0};
    AtraceEventSetAttr(eventHandle, &attr);
    EXPECT_EQ(ret, TRACE_SUCCESS);
    AtraceEventReport(eventHandle);

    AtraceDestroy(handle);
    AtraceEventDestroy(eventHandle);
}

TEST_F(UtraceEventUtest, TestDestroyHandleBeforeDestroyEvent)
{
    TracerType tracerType = TRACER_TYPE_SCHEDULE;
    const char objName[] = "HCCL";    
    auto handle = AtraceCreate(tracerType, objName);
    auto ret = AtraceSubmit(handle, objName, sizeof(objName));
    EXPECT_EQ(ret, TRACE_SUCCESS);

    // Check
    auto eventHandle = AtraceEventCreate("save_hccl");
    ret = AtraceEventBindTrace(eventHandle, handle);
    EXPECT_EQ(ret, TRACE_SUCCESS);
    AtraceEventReport(eventHandle);

    AtraceDestroy(handle);
    AtraceEventDestroy(eventHandle);
}

TEST_F(UtraceEventUtest, TestTraceEventReportUnsupported)
{
    TracerHandle tracerHandle;
    TraHandle traHandle;
    EXPECT_EQ(TRACE_INVALID_PARAM, TraceEventBindTracer(-1, tracerHandle));
    EXPECT_EQ(TRACE_INVALID_PARAM, TraceEventUnbindTracer(-1, tracerHandle));
    EXPECT_EQ(TRACE_INVALID_PARAM, TraceEventUnbindTrace(-1, traHandle));
    EXPECT_EQ(TRACE_INVALID_HANDLE, TraceEventReport(-1));

    EXPECT_EQ(TRACE_INVALID_PARAM, TraceBindEvent(-1, -1));
    EXPECT_EQ(TRACE_INVALID_PARAM, TraceUnbindEvent(-1, -1));
}
