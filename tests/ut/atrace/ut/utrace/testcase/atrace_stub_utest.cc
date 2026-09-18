/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 * -----------------------------------------------------------------------------------------------------------
 * Description: libascend_trace.so 桩库单元测试。覆盖两类场景:
 *   1. AtraceStubUtest: 直接链接桩源码 atrace_stub.c, 验证静默成功语义;
 *   2. AtraceStubDlUtest: dlopen 实际构建产物 libascend_trace.so(桩),
 *      验证符号导出与接口返回值, 模拟下游加载包内 so 的场景。
 */

#include "gtest/gtest.h"
#include "mockcpp/mockcpp.hpp"
#include <dlfcn.h>
#include <stdint.h>
#include "atrace_api.h"
#include "atrace_stackcore_api.h"

namespace {
constexpr TraHandle ATRACE_STUB_FAKE_HANDLE = 1;
constexpr TraEventHandle ATRACE_STUB_FAKE_EVENT_HANDLE = 1;

const char* GetStubSoPath() { return ATRACE_STUB_SO_PATH; }
} // namespace

class AtraceStubUtest : public testing::Test {
protected:
    virtual void SetUp() {}
    virtual void TearDown() { GlobalMockObject::verify(); }
    static void SetUpTestCase() {}
    static void TearDownTestCase() {}
};

/*
 * @tc.name: TestHandleCreateReturnFakeHandle
 * @tc.desc: Handle 创建类接口返回固定有效假句柄(非负), 不被调用方(如 runtime.cc 判 handle < 0)认为失败
 */
TEST_F(AtraceStubUtest, TestHandleCreateReturnFakeHandle)
{
    EXPECT_EQ(AtraceCreate(TRACER_TYPE_SCHEDULE, "stub_ut"), ATRACE_STUB_FAKE_HANDLE);
    EXPECT_GE(AtraceCreate(TRACER_TYPE_SCHEDULE, "stub_ut"), 0);

    TraceAttr attr = {0};
    EXPECT_EQ(AtraceCreateWithAttr(TRACER_TYPE_SCHEDULE, "stub_ut", &attr), ATRACE_STUB_FAKE_HANDLE);
    EXPECT_GE(AtraceCreateWithAttr(TRACER_TYPE_SCHEDULE, "stub_ut", &attr), 0);

    EXPECT_EQ(AtraceGetHandle(TRACER_TYPE_SCHEDULE, "stub_ut"), ATRACE_STUB_FAKE_HANDLE);
    EXPECT_GE(AtraceGetHandle(TRACER_TYPE_SCHEDULE, "stub_ut"), 0);

    EXPECT_EQ(AtraceEventCreate("stub_ut"), ATRACE_STUB_FAKE_EVENT_HANDLE);
    EXPECT_GE(AtraceEventCreate("stub_ut"), 0);

    EXPECT_EQ(AtraceEventGetHandle("stub_ut"), ATRACE_STUB_FAKE_EVENT_HANDLE);
    EXPECT_GE(AtraceEventGetHandle("stub_ut"), 0);
}

/*
 * @tc.name: TestStructEntryCreateReturnDummy
 * @tc.desc: AtraceStructEntryCreate 返回非 NULL 哑指针, 避免调用方判 NULL 认为失败
 */
TEST_F(AtraceStubUtest, TestStructEntryCreateReturnDummy)
{
    TraceStructEntry* entry = AtraceStructEntryCreate("stub_ut");
    EXPECT_NE(entry, nullptr);
    EXPECT_NE(AtraceStructEntryCreate("stub_ut_2nd"), nullptr);
}

/*
 * @tc.name: TestStatusInterfacesReturnSuccess
 * @tc.desc: 状态类接口统一返回 TRACE_SUCCESS, 保证调用方(如 runtime.cc 检查 ret != TRACE_SUCCESS 打告警)无感知
 */
TEST_F(AtraceStubUtest, TestStatusInterfacesReturnSuccess)
{
    const TraHandle handle = AtraceCreate(TRACER_TYPE_SCHEDULE, "stub_ut");
    const TraEventHandle eventHandle = AtraceEventCreate("stub_ut");
    uint8_t buffer[16] = {0};

    EXPECT_EQ(AtraceSubmit(handle, buffer, sizeof(buffer)), TRACE_SUCCESS);
    EXPECT_EQ(AtraceSubmitByType(handle, 0, buffer, sizeof(buffer)), TRACE_SUCCESS);
    EXPECT_EQ(AtraceSave(TRACER_TYPE_SCHEDULE, true), TRACE_SUCCESS);
    EXPECT_EQ(AtraceStackcoreParse("stub_ut", 0U), TRACE_SUCCESS);

    TraceEventAttr eventAttr = {0};
    eventAttr.limitedNum = 1U;
    EXPECT_EQ(AtraceEventSetAttr(eventHandle, &eventAttr), TRACE_SUCCESS);
    EXPECT_EQ(AtraceEventBindTrace(eventHandle, handle), TRACE_SUCCESS);
    EXPECT_EQ(AtraceEventReportSync(eventHandle), TRACE_SUCCESS);
    EXPECT_EQ(AtraceEventReport(eventHandle), TRACE_SUCCESS);

    EXPECT_EQ(AtraceReportStart(0), TRACE_SUCCESS);

    TraceGlobalAttr globalAttr = {0};
    EXPECT_EQ(AtraceSetGlobalAttr(&globalAttr), TRACE_SUCCESS);
}

/*
 * @tc.name: TestVoidInterfacesNoCrash
 * @tc.desc: void 类接口空实现, 任意句柄(含无效句柄与 NULL 入参)调用不崩溃
 */
TEST_F(AtraceStubUtest, TestVoidInterfacesNoCrash)
{
    AtraceDestroy((TraHandle)1);
    AtraceDestroy((TraHandle)(-1));
    AtraceEventDestroy((TraEventHandle)1);
    AtraceReportStop(0);

    TraceStructEntry* entry = AtraceStructEntryCreate("stub_ut");
    ASSERT_NE(entry, nullptr);
    AtraceStructItemFieldSet(entry, "item", TRACE_STRUCT_FIELD_TYPE_UINT32, TRACE_STRUCT_SHOW_MODE_DEC, 4U);
    AtraceStructItemArraySet(entry, "array", TRACE_STRUCT_ARRAY_TYPE_UINT8, TRACE_STRUCT_SHOW_MODE_HEX, 8U);
    AtraceStructItemSet(entry, "item", TRACE_STRUCT_FIELD_TYPE_UINT32, TRACE_STRUCT_SHOW_MODE_DEC, 4U);
    AtraceStructEntryName(entry, "stub_ut");
    TraceAttr attr = {0};
    AtraceStructSetAttr(entry, 0, &attr);
    AtraceStructEntryExit(entry);
    AtraceStructEntryDestroy(entry);

    AtraceStructItemFieldSet(nullptr, nullptr, 0U, 0U, 0U);
    AtraceStructItemArraySet(nullptr, nullptr, 0U, 0U, 0U);
    AtraceStructSetAttr(nullptr, 0U, nullptr);
    AtraceStructEntryDestroy(nullptr);
}

/*
 * @tc.name: TestStructEntryListInit
 * @tc.desc: AtraceStructEntryListInit 为 TRACE_STRUCT_INIT_ENTRY 宏依赖接口, 返回 NULL 与哑 entry.list 一致
 */
TEST_F(AtraceStubUtest, TestStructEntryListInit) { EXPECT_EQ(AtraceStructEntryListInit(), nullptr); }

class AtraceStubDlUtest : public testing::Test {
protected:
    virtual void SetUp() { handle_ = dlopen(GetStubSoPath(), RTLD_NOW); }
    virtual void TearDown()
    {
        if (handle_ != nullptr) {
            dlclose(handle_);
            handle_ = nullptr;
        }
    }
    static void SetUpTestCase() {}
    static void TearDownTestCase() {}

    void* handle_ = nullptr;
};

/*
 * @tc.name: TestDlopenStubSo
 * @tc.desc: 实际构建产物桩 libascend_trace.so 可被 dlopen(RTLD_NOW) 加载
 */
TEST_F(AtraceStubDlUtest, TestDlopenStubSo)
{
    ASSERT_NE(handle_, nullptr) << "dlopen " << GetStubSoPath() << " failed: " << dlerror();
}

/*
 * @tc.name: TestAllSymbolsExported
 * @tc.desc: 桩 so 导出与真实库一致的 27 个公开符号(atrace_pub.h 19 个 + atrace_api.h 7 个 + stackcore 1 个)
 */
TEST_F(AtraceStubDlUtest, TestAllSymbolsExported)
{
    ASSERT_NE(handle_, nullptr) << "dlopen " << GetStubSoPath() << " failed: " << dlerror();
    const char* symbols[] = {
        "AtraceCreate",
        "AtraceCreateWithAttr",
        "AtraceGetHandle",
        "AtraceSubmit",
        "AtraceSubmitByType",
        "AtraceDestroy",
        "AtraceSave",
        "AtraceStructEntryCreate",
        "AtraceStructEntryDestroy",
        "AtraceStructItemFieldSet",
        "AtraceStructItemArraySet",
        "AtraceStructSetAttr",
        "AtraceEventCreate",
        "AtraceEventGetHandle",
        "AtraceEventDestroy",
        "AtraceEventBindTrace",
        "AtraceEventSetAttr",
        "AtraceEventReportSync",
        "AtraceSetGlobalAttr",
        "AtraceStructEntryListInit",
        "AtraceStructEntryName",
        "AtraceStructItemSet",
        "AtraceStructEntryExit",
        "AtraceEventReport",
        "AtraceReportStart",
        "AtraceReportStop",
        "AtraceStackcoreParse",
    };
    constexpr size_t symbolNum = sizeof(symbols) / sizeof(symbols[0]);
    for (size_t i = 0; i < symbolNum; i++) {
        void* sym = dlsym(handle_, symbols[i]);
        EXPECT_NE(sym, nullptr) << "symbol " << symbols[i] << " not exported by stub so";
    }
}

#define ATRACE_DLSYM(type, var, name)                        \
    auto var = reinterpret_cast<type>(dlsym(handle_, name)); \
    ASSERT_NE(var, nullptr) << name << " not found";

/*
 * @tc.name: TestDynamicHandleCreate
 * @tc.desc: dlsym 动态调用 Handle 创建类接口, 断言返回固定有效假句柄(模拟下游加载包内 so 调用)
 */
TEST_F(AtraceStubDlUtest, TestDynamicHandleCreate)
{
    ASSERT_NE(handle_, nullptr) << "dlopen " << GetStubSoPath() << " failed: " << dlerror();

    using CreateFunc = TraHandle (*)(TracerType, const char*);
    using CreateWithAttrFunc = TraHandle (*)(TracerType, const char*, const TraceAttr*);
    using GetHandleFunc = TraHandle (*)(TracerType, const char*);
    using EventCreateFunc = TraEventHandle (*)(const char*);

    ATRACE_DLSYM(CreateFunc, create, "AtraceCreate");
    ATRACE_DLSYM(CreateWithAttrFunc, createWithAttr, "AtraceCreateWithAttr");
    ATRACE_DLSYM(GetHandleFunc, getHandle, "AtraceGetHandle");
    ATRACE_DLSYM(EventCreateFunc, eventCreate, "AtraceEventCreate");
    ATRACE_DLSYM(EventCreateFunc, eventGetHandle, "AtraceEventGetHandle");

    const TraHandle handle = create(TRACER_TYPE_SCHEDULE, "stub_dl_ut");
    EXPECT_EQ(handle, ATRACE_STUB_FAKE_HANDLE);
    TraceAttr attr = {0};
    EXPECT_EQ(createWithAttr(TRACER_TYPE_SCHEDULE, "stub_dl_ut", &attr), ATRACE_STUB_FAKE_HANDLE);
    EXPECT_EQ(getHandle(TRACER_TYPE_SCHEDULE, "stub_dl_ut"), ATRACE_STUB_FAKE_HANDLE);
    const TraEventHandle eventHandle = eventCreate("stub_dl_ut");
    EXPECT_EQ(eventHandle, ATRACE_STUB_FAKE_EVENT_HANDLE);
    EXPECT_EQ(eventGetHandle("stub_dl_ut"), ATRACE_STUB_FAKE_EVENT_HANDLE);
}

/*
 * @tc.name: TestDynamicStructEntryCreate
 * @tc.desc: dlsym 动态调用指针创建类接口, 断言返回非 NULL 哑指针 / ListInit 返回 NULL
 */
TEST_F(AtraceStubDlUtest, TestDynamicStructEntryCreate)
{
    ASSERT_NE(handle_, nullptr) << "dlopen " << GetStubSoPath() << " failed: " << dlerror();

    using StructEntryCreateFunc = TraceStructEntry* (*)(const char*);
    using StructEntryListInitFunc = void* (*)(void);

    ATRACE_DLSYM(StructEntryCreateFunc, structEntryCreate, "AtraceStructEntryCreate");
    ATRACE_DLSYM(StructEntryListInitFunc, structEntryListInit, "AtraceStructEntryListInit");

    TraceStructEntry* entry = structEntryCreate("stub_dl_ut");
    EXPECT_NE(entry, nullptr);
    EXPECT_EQ(structEntryListInit(), nullptr);
}

/*
 * @tc.name: TestDynamicStatusInterfaces
 * @tc.desc: dlsym 动态调用状态类接口, 断言统一返回 TRACE_SUCCESS
 */
TEST_F(AtraceStubDlUtest, TestDynamicStatusInterfaces)
{
    ASSERT_NE(handle_, nullptr) << "dlopen " << GetStubSoPath() << " failed: " << dlerror();

    using SubmitFunc = TraStatus (*)(TraHandle, const void*, uint32_t);
    using SubmitByTypeFunc = TraStatus (*)(TraHandle, uint8_t, const void*, uint32_t);
    using SaveFunc = TraStatus (*)(TracerType, bool);
    using EventSetAttrFunc = TraStatus (*)(TraEventHandle, const TraceEventAttr*);
    using EventBindTraceFunc = TraStatus (*)(TraEventHandle, TraHandle);
    using EventReportFunc = TraStatus (*)(TraEventHandle);
    using ReportStartFunc = TraStatus (*)(int32_t);
    using SetGlobalAttrFunc = TraStatus (*)(const TraceGlobalAttr*);
    using StackcoreParseFunc = TraStatus (*)(const char*, uint32_t);

    ATRACE_DLSYM(SubmitFunc, submit, "AtraceSubmit");
    ATRACE_DLSYM(SubmitByTypeFunc, submitByType, "AtraceSubmitByType");
    ATRACE_DLSYM(SaveFunc, save, "AtraceSave");
    ATRACE_DLSYM(EventSetAttrFunc, eventSetAttr, "AtraceEventSetAttr");
    ATRACE_DLSYM(EventBindTraceFunc, eventBindTrace, "AtraceEventBindTrace");
    ATRACE_DLSYM(EventReportFunc, eventReportSync, "AtraceEventReportSync");
    ATRACE_DLSYM(EventReportFunc, eventReport, "AtraceEventReport");
    ATRACE_DLSYM(ReportStartFunc, reportStart, "AtraceReportStart");
    ATRACE_DLSYM(SetGlobalAttrFunc, setGlobalAttr, "AtraceSetGlobalAttr");
    ATRACE_DLSYM(StackcoreParseFunc, stackcoreParse, "AtraceStackcoreParse");

    const TraHandle handle = ATRACE_STUB_FAKE_HANDLE;
    const TraEventHandle eventHandle = ATRACE_STUB_FAKE_EVENT_HANDLE;
    uint8_t buffer[8] = {0};
    EXPECT_EQ(submit(handle, buffer, sizeof(buffer)), TRACE_SUCCESS);
    EXPECT_EQ(submitByType(handle, 0, buffer, sizeof(buffer)), TRACE_SUCCESS);
    EXPECT_EQ(save(TRACER_TYPE_SCHEDULE, true), TRACE_SUCCESS);
    TraceEventAttr eventAttr = {0};
    eventAttr.limitedNum = 1U;
    EXPECT_EQ(eventSetAttr(eventHandle, &eventAttr), TRACE_SUCCESS);
    EXPECT_EQ(eventBindTrace(eventHandle, handle), TRACE_SUCCESS);
    EXPECT_EQ(eventReportSync(eventHandle), TRACE_SUCCESS);
    EXPECT_EQ(eventReport(eventHandle), TRACE_SUCCESS);
    EXPECT_EQ(reportStart(0), TRACE_SUCCESS);
    TraceGlobalAttr globalAttr = {0};
    EXPECT_EQ(setGlobalAttr(&globalAttr), TRACE_SUCCESS);
    EXPECT_EQ(stackcoreParse("stub_dl_ut", 0U), TRACE_SUCCESS);
}

/*
 * @tc.name: TestDynamicVoidInterfaces
 * @tc.desc: dlsym 动态调用 void 类接口, 任意句柄(含 NULL 入参)调用不崩溃
 */
TEST_F(AtraceStubDlUtest, TestDynamicVoidInterfaces)
{
    ASSERT_NE(handle_, nullptr) << "dlopen " << GetStubSoPath() << " failed: " << dlerror();

    using StructEntryCreateFunc = TraceStructEntry* (*)(const char*);
    using DestroyFunc = void (*)(TraHandle);
    using EventDestroyFunc = void (*)(TraEventHandle);
    using ReportStopFunc = void (*)(int32_t);
    using StructEntryDestroyFunc = void (*)(TraceStructEntry*);
    using StructItemSetFunc = void (*)(TraceStructEntry*, const char*, uint8_t, uint8_t, uint16_t);
    using StructEntryNameFunc = void (*)(TraceStructEntry*, const char*);
    using StructSetAttrFunc = void (*)(TraceStructEntry*, uint8_t, TraceAttr*);
    using StructEntryExitFunc = void (*)(TraceStructEntry*);

    ATRACE_DLSYM(StructEntryCreateFunc, structEntryCreate, "AtraceStructEntryCreate");
    ATRACE_DLSYM(DestroyFunc, destroy, "AtraceDestroy");
    ATRACE_DLSYM(EventDestroyFunc, eventDestroy, "AtraceEventDestroy");
    ATRACE_DLSYM(ReportStopFunc, reportStop, "AtraceReportStop");
    ATRACE_DLSYM(StructEntryDestroyFunc, structEntryDestroy, "AtraceStructEntryDestroy");
    ATRACE_DLSYM(StructItemSetFunc, structItemFieldSet, "AtraceStructItemFieldSet");
    ATRACE_DLSYM(StructItemSetFunc, structItemArraySet, "AtraceStructItemArraySet");
    ATRACE_DLSYM(StructItemSetFunc, structItemSet, "AtraceStructItemSet");
    ATRACE_DLSYM(StructEntryNameFunc, structEntryName, "AtraceStructEntryName");
    ATRACE_DLSYM(StructSetAttrFunc, structSetAttr, "AtraceStructSetAttr");
    ATRACE_DLSYM(StructEntryExitFunc, structEntryExit, "AtraceStructEntryExit");

    const TraHandle handle = ATRACE_STUB_FAKE_HANDLE;
    const TraEventHandle eventHandle = ATRACE_STUB_FAKE_EVENT_HANDLE;
    TraceStructEntry* entry = structEntryCreate("stub_dl_ut");
    ASSERT_NE(entry, nullptr);
    TraceAttr attr = {0};

    destroy(handle);
    destroy((TraHandle)(-1));
    eventDestroy(eventHandle);
    reportStop(0);
    structItemFieldSet(entry, "item", TRACE_STRUCT_FIELD_TYPE_UINT32, TRACE_STRUCT_SHOW_MODE_DEC, 4U);
    structItemArraySet(entry, "array", TRACE_STRUCT_ARRAY_TYPE_UINT8, TRACE_STRUCT_SHOW_MODE_HEX, 8U);
    structItemSet(entry, "item", TRACE_STRUCT_FIELD_TYPE_UINT32, TRACE_STRUCT_SHOW_MODE_DEC, 4U);
    structEntryName(entry, "stub_dl_ut");
    structSetAttr(entry, 0, &attr);
    structEntryExit(entry);
    structEntryDestroy(entry);
    structItemFieldSet(nullptr, nullptr, 0U, 0U, 0U);
    structEntryDestroy(nullptr);
}
