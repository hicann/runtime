/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "mockcpp/mockcpp.hpp"
#include "gtest/gtest.h"
#include <atomic>
#include <map>
#include <string>
#include "msprof_dlog.h"
#include "prof_inner_api.h"
#include "prof_acl_plugin.h"
#include "prof_cann_plugin.h"
#include "prof_plugin_manager.h"
#include "mmpa_api.h"
#include "mmpa_stub.h"

#include "prof_api.h"
#include "aprof_pub.h"
#include "queue/report_buffer.h"
#include "prof_report_api.h"
#include "prof_plugin.h"

using namespace analysis::dvvp::common::error;

#ifdef PROF_API_STUB
extern void profOstreamStub(void);
#endif

namespace {
#ifndef ascend031
uint32_t registerDataCallbackCallCount = 0;
std::atomic<uint32_t> profStartCallCount{0};

int32_t ProfRegisterDataCallbackStub(uint32_t type, void* callback)
{
    (void)type;
    (void)callback;
    registerDataCallbackCallCount++;
    return 0;
}

int32_t ProfRegisterDataCallbackFailStub(uint32_t type, void* callback)
{
    (void)type;
    (void)callback;
    registerDataCallbackCallCount++;
    return PROFILING_FAILED;
}

int32_t ProfSetHookStub() { return 0; }

int32_t ProfGetHookStub() { return 0; }

int32_t ProfStartTrackingStub(uint32_t, const void*, uint32_t)
{
    profStartCallCount.fetch_add(1);
    return PROFILING_SUCCESS;
}

std::atomic<bool> initSawSetHook{false};
std::atomic<bool> initSawGetHook{false};
std::atomic<bool> oldHandleClosedObserved{false};
std::atomic<bool> initSawOldHandleClosed{false};
std::atomic<uint32_t> initCallCount{0};

int32_t ProfAclToolInitializeStub()
{
    initCallCount.fetch_add(1);
    initSawSetHook.store(MsprofGetInjectionFunc(PROF_HOOK_SET) != nullptr);
    initSawGetHook.store(MsprofGetInjectionFunc(PROF_HOOK_GET) != nullptr);
    return (initSawSetHook.load() && initSawGetHook.load()) ? PROFILING_SUCCESS : PROFILING_FAILED;
}

int32_t ProfAclToolInitializeOldHandleStub()
{
    initCallCount.fetch_add(1);
    initSawOldHandleClosed.store(oldHandleClosedObserved.load());
    return PROFILING_SUCCESS;
}

int32_t ProfAclToolInitializeFailedStub()
{
    initCallCount.fetch_add(1);
    return PROFILING_FAILED;
}

int32_t ProfInjectionDlcloseStub(void* handle)
{
    if (handle != nullptr) {
        oldHandleClosedObserved.store(true);
    }
    return mmDlclose(handle);
}
#endif

void ResetInjectionStateForTest()
{
    unsetenv("ACL_API_INJECTION");
    auto plugin = ProfAPI::ProfCannPlugin::instance();
    plugin->ProfResetInjectionState();
    plugin->profRegisterDataCallback_ = nullptr;
#ifndef ascend031
    initSawSetHook.store(false);
    initSawGetHook.store(false);
    oldHandleClosedObserved.store(false);
    initSawOldHandleClosed.store(false);
    initCallCount.store(0);
    registerDataCallbackCallCount = 0;
    profStartCallCount.store(0);
#endif
}
} // namespace

static int32_t ProfStartFuncStub(uint32_t dataType, const void* data, uint32_t length);

class PROF_API_PLUGIN_UTTEST : public testing::Test {
protected:
    virtual void SetUp()
    {
        MOCKER(dlopen).stubs().will(invoke(mmDlopen));
        MOCKER(dlsym).stubs().will(invoke(mmDlsym));
        MOCKER(dlclose).stubs().will(invoke(mmDlclose));
        MOCKER(dlerror).stubs().will(invoke(mmDlerror));
        ResetInjectionStateForTest();
    }
    virtual void TearDown() { ResetInjectionStateForTest(); }
};

int ProfApiInitStub(void)
{
    ProfAPI::ProfCannPlugin::instance()->ProfApiInit();
    return 0;
}

#ifndef ascend031
TEST_F(PROF_API_PLUGIN_UTTEST, PROF_INJECTION_API_COLD_START)
{
    EXPECT_EQ(PROFILING_SUCCESS, MsprofSetInjectionFunc(PROF_HOOK_SET, reinterpret_cast<void*>(ProfSetHookStub)));
    EXPECT_EQ(PROFILING_SUCCESS, MsprofSetInjectionFunc(PROF_HOOK_GET, reinterpret_cast<void*>(ProfGetHookStub)));
    EXPECT_EQ(
        PROFILING_SUCCESS, MsprofSetInjectionFunc(PROF_HOOK_INIT, reinterpret_cast<void*>(ProfAclToolInitializeStub)));
    EXPECT_EQ(nullptr, MsprofGetInjectionFunc(PROF_HOOK_SET));
    EXPECT_EQ(PROFILING_SUCCESS, MsprofInjectionInitialize());
    EXPECT_EQ(1U, initCallCount.load());
    EXPECT_TRUE(initSawSetHook.load());
    EXPECT_TRUE(initSawGetHook.load());
    EXPECT_NE(nullptr, MsprofGetInjectionFunc(PROF_HOOK_SET));
    EXPECT_NE(nullptr, MsprofGetInjectionFunc(PROF_HOOK_GET));
    EXPECT_EQ(nullptr, MsprofGetInjectionFunc(PROF_HOOK_INIT));
}

TEST_F(PROF_API_PLUGIN_UTTEST, PROF_INJECTION_API_SYMBOL_NULL)
{
    EXPECT_EQ(PROFILING_FAILED, MsprofSetInjectionFunc(PROF_HOOK_SET, nullptr));
    EXPECT_EQ(PROFILING_FAILED, MsprofSetInjectionFunc(3, reinterpret_cast<void*>(ProfAclToolInitializeStub)));
    EXPECT_EQ(nullptr, MsprofGetInjectionFunc(PROF_HOOK_SET));
    EXPECT_EQ(PROFILING_SUCCESS, MsprofInjectionInitialize());
    EXPECT_EQ(nullptr, MsprofGetInjectionFunc(PROF_HOOK_GET));
    EXPECT_EQ(
        PROFILING_FAILED,
        ProfAPI::ProfCannPlugin::instance()->ProfRegisterDataCallback(PROF_DATA_CALLBACK_COMPUTE, nullptr));
}

TEST_F(PROF_API_PLUGIN_UTTEST, PROF_INJECTION_API_INIT_HOOK_REQUIRES_SET_GET_HOOKS)
{
    EXPECT_EQ(
        PROFILING_SUCCESS, MsprofSetInjectionFunc(PROF_HOOK_INIT, reinterpret_cast<void*>(ProfAclToolInitializeStub)));
    EXPECT_EQ(PROFILING_FAILED, MsprofInjectionInitialize());
    EXPECT_EQ(0U, initCallCount.load());
}

TEST_F(PROF_API_PLUGIN_UTTEST, PROF_INJECTION_API_INIT_HOOK_FAILED)
{
    EXPECT_EQ(PROFILING_SUCCESS, MsprofSetInjectionFunc(PROF_HOOK_SET, reinterpret_cast<void*>(ProfSetHookStub)));
    EXPECT_EQ(PROFILING_SUCCESS, MsprofSetInjectionFunc(PROF_HOOK_GET, reinterpret_cast<void*>(ProfGetHookStub)));
    EXPECT_EQ(
        PROFILING_SUCCESS,
        MsprofSetInjectionFunc(PROF_HOOK_INIT, reinterpret_cast<void*>(ProfAclToolInitializeFailedStub)));
    EXPECT_EQ(PROFILING_FAILED, MsprofInjectionInitialize());
    EXPECT_EQ(nullptr, MsprofGetInjectionFunc(PROF_HOOK_SET));
}

TEST_F(PROF_API_PLUGIN_UTTEST, PROF_INJECTION_API_ENV_OFF_CLEARS_OLD_STATE)
{
    EXPECT_EQ(PROFILING_SUCCESS, MsprofSetInjectionFunc(PROF_HOOK_SET, reinterpret_cast<void*>(ProfSetHookStub)));
    EXPECT_EQ(PROFILING_SUCCESS, MsprofSetInjectionFunc(PROF_HOOK_GET, reinterpret_cast<void*>(ProfGetHookStub)));
    RegisterMmDlsymStub("acltoolInitialize", reinterpret_cast<void*>(ProfAclToolInitializeStub));
    EXPECT_EQ(0, setenv("ACL_API_INJECTION", "libprofimpl.so", 1));
    EXPECT_EQ(PROFILING_SUCCESS, MsprofInjectionInitialize());
    EXPECT_NE(nullptr, MsprofGetInjectionFunc(PROF_HOOK_SET));

    unsetenv("ACL_API_INJECTION");
    EXPECT_EQ(PROFILING_SUCCESS, MsprofInjectionInitialize());
    EXPECT_EQ(nullptr, MsprofGetInjectionFunc(PROF_HOOK_SET));
}

TEST_F(PROF_API_PLUGIN_UTTEST, PROF_INJECTION_API_ENV_OFF_KEEPS_OLD_HANDLE_LIVE_DURING_INIT)
{
    MOCKER(dlclose).stubs().will(invoke(ProfInjectionDlcloseStub));
    EXPECT_EQ(PROFILING_SUCCESS, MsprofSetInjectionFunc(PROF_HOOK_SET, reinterpret_cast<void*>(ProfSetHookStub)));
    EXPECT_EQ(PROFILING_SUCCESS, MsprofSetInjectionFunc(PROF_HOOK_GET, reinterpret_cast<void*>(ProfGetHookStub)));
    EXPECT_EQ(
        PROFILING_SUCCESS,
        MsprofSetInjectionFunc(PROF_HOOK_INIT, reinterpret_cast<void*>(ProfAclToolInitializeOldHandleStub)));
    RegisterMmDlsymStub("acltoolInitialize", reinterpret_cast<void*>(ProfAclToolInitializeOldHandleStub));
    EXPECT_EQ(0, setenv("ACL_API_INJECTION", "libprofimpl.so", 1));
    EXPECT_EQ(PROFILING_SUCCESS, MsprofInjectionInitialize());
    EXPECT_EQ(1U, initCallCount.load());

    oldHandleClosedObserved.store(false);
    initSawOldHandleClosed.store(false);
    EXPECT_EQ(PROFILING_SUCCESS, MsprofInjectionInitialize());
    EXPECT_EQ(2U, initCallCount.load());
    EXPECT_FALSE(initSawOldHandleClosed.load());
}

TEST_F(PROF_API_PLUGIN_UTTEST, PROF_REGISTER_DATA_CALLBACK_CACHE_AND_SYNC)
{
    auto plugin = ProfAPI::ProfCannPlugin::instance();
    EXPECT_EQ(PROFILING_FAILED, plugin->ProfRegisterDataCallback(PROF_DATA_CALLBACK_COMPUTE, nullptr));
    EXPECT_EQ(
        PROFILING_SUCCESS,
        MsprofRegisterDataCallback(PROF_DATA_CALLBACK_COMPUTE, reinterpret_cast<void*>(ProfSetHookStub)));
    EXPECT_EQ(0U, registerDataCallbackCallCount);

    RegisterMmDlsymStub("MsprofRegisterDataCallback", reinterpret_cast<void*>(ProfRegisterDataCallbackStub));
    plugin->profRegisterDataCallback_ = ProfRegisterDataCallbackStub;
    plugin->profStart_ = ProfStartFuncStub;
    EXPECT_EQ(PROFILING_SUCCESS, plugin->ProfStart(MSPROF_CTRL_INIT_COMPUTE, nullptr, 0));
    EXPECT_EQ(1U, registerDataCallbackCallCount);
    EXPECT_EQ(PROFILING_SUCCESS, plugin->ProfStart(MSPROF_CTRL_INIT_COMPUTE, nullptr, 0));
    EXPECT_EQ(1U, registerDataCallbackCallCount);
}

TEST_F(PROF_API_PLUGIN_UTTEST, PROF_REGISTER_DATA_CALLBACK_SYNC_FAIL_BEFORE_RESOURCE_INIT)
{
    auto plugin = ProfAPI::ProfCannPlugin::instance();
    EXPECT_EQ(
        PROFILING_SUCCESS,
        MsprofRegisterDataCallback(PROF_DATA_CALLBACK_COMPUTE, reinterpret_cast<void*>(ProfSetHookStub)));
    plugin->profRegisterDataCallback_ = ProfRegisterDataCallbackFailStub;
    plugin->profStart_ = ProfStartTrackingStub;

    MOCKER_CPP(&ProfAPI::ProfCannPlugin::ProfInitReportBuf).expects(never());
    MOCKER_CPP(&ProfAPI::ProfCannPlugin::ProfTxInit).expects(never());

    EXPECT_EQ(PROFILING_FAILED, plugin->ProfStart(MSPROF_CTRL_INIT_COMPUTE, nullptr, 0));
    EXPECT_EQ(1U, registerDataCallbackCallCount);
    EXPECT_EQ(0U, profStartCallCount.load());
}
#endif

TEST_F(PROF_API_PLUGIN_UTTEST, PROF_API_INIT)
{
    GlobalMockObject::verify();
    EXPECT_EQ(0, ProfApiInitStub());
}

static int32_t ProfStartFuncStub(uint32_t dataType, const void* data, uint32_t length)
{
    (void)dataType;
    (void)data;
    (void)length;
    return 0;
}

static int32_t ProfStopFuncStub(uint32_t dataType, const void* data, uint32_t length)
{
    (void)dataType;
    (void)data;
    (void)length;
    return 0;
}

static bool ProfCheckOpSwitchFuncStubTrue(uint32_t type, const char* op, size_t len)
{
    (void)type;
    (void)op;
    (void)len;
    return true;
}

static bool ProfCheckOpSwitchFuncStubFalse(uint32_t type, const char* op, size_t len)
{
    (void)type;
    (void)op;
    (void)len;
    return false;
}

TEST_F(PROF_API_PLUGIN_UTTEST, PROF_START_STOP)
{
    EXPECT_EQ(0, ProfAPI::ProfCannPlugin::instance()->ProfStart(0, nullptr, 0));
    ProfAPI::ProfCannPlugin::instance()->profStart_ = ProfStartFuncStub;
    EXPECT_EQ(0, ProfAPI::ProfCannPlugin::instance()->ProfStart(0, nullptr, 0));

    EXPECT_EQ(0, ProfAPI::ProfCannPlugin::instance()->ProfStop(0, nullptr, 0));
    ProfAPI::ProfCannPlugin::instance()->profStop_ = ProfStopFuncStub;
    EXPECT_EQ(0, ProfAPI::ProfCannPlugin::instance()->ProfStop(0, nullptr, 0));
}

TEST_F(PROF_API_PLUGIN_UTTEST, PROF_CHECKOPSWITCH_NULLPTR)
{
    EXPECT_EQ(false, ProfAPI::ProfCannPlugin::instance()->ProfCheckOpSwitch(0, nullptr, 0));
    EXPECT_EQ(false, ProfAPI::ProfCannPlugin::instance()->ProfCheckOpSwitch(0, nullptr, 6));
    EXPECT_EQ(false, ProfAPI::ProfCannPlugin::instance()->ProfCheckOpSwitch(1, nullptr, 0));
    EXPECT_EQ(false, ProfAPI::ProfCannPlugin::instance()->ProfCheckOpSwitch(1, nullptr, 6));
}

TEST_F(PROF_API_PLUGIN_UTTEST, PROF_CHECKOPSWITCH_VALID_OP)
{
    const char* opName = "MatMul";
    EXPECT_EQ(false, ProfAPI::ProfCannPlugin::instance()->ProfCheckOpSwitch(0, opName, 6));
    EXPECT_EQ(false, ProfAPI::ProfCannPlugin::instance()->ProfCheckOpSwitch(0, opName, 0));
    EXPECT_EQ(false, ProfAPI::ProfCannPlugin::instance()->ProfCheckOpSwitch(1, "Add", 3));
    EXPECT_EQ(false, ProfAPI::ProfCannPlugin::instance()->ProfCheckOpSwitch(2, "Relu", 4));
}

TEST_F(PROF_API_PLUGIN_UTTEST, PROF_CHECKOPSWITCH_WITH_CALLBACK_TRUE)
{
    ProfAPI::ProfCannPlugin::instance()->profCheckOpSwitch_ = ProfCheckOpSwitchFuncStubTrue;
    EXPECT_EQ(true, ProfAPI::ProfCannPlugin::instance()->ProfCheckOpSwitch(0, nullptr, 0));
    EXPECT_EQ(true, ProfAPI::ProfCannPlugin::instance()->ProfCheckOpSwitch(0, "MatMul", 6));
    EXPECT_EQ(true, ProfAPI::ProfCannPlugin::instance()->ProfCheckOpSwitch(1, "Add", 3));
    EXPECT_EQ(true, ProfAPI::ProfCannPlugin::instance()->ProfCheckOpSwitch(2, nullptr, 0));
}

TEST_F(PROF_API_PLUGIN_UTTEST, PROF_CHECKOPSWITCH_WITH_CALLBACK_FALSE)
{
    ProfAPI::ProfCannPlugin::instance()->profCheckOpSwitch_ = ProfCheckOpSwitchFuncStubFalse;
    EXPECT_EQ(false, ProfAPI::ProfCannPlugin::instance()->ProfCheckOpSwitch(0, nullptr, 0));
    EXPECT_EQ(false, ProfAPI::ProfCannPlugin::instance()->ProfCheckOpSwitch(0, "MatMul", 6));
    EXPECT_EQ(false, ProfAPI::ProfCannPlugin::instance()->ProfCheckOpSwitch(1, "Add", 3));
    EXPECT_EQ(false, ProfAPI::ProfCannPlugin::instance()->ProfCheckOpSwitch(2, nullptr, 0));
}

TEST_F(PROF_API_PLUGIN_UTTEST, PROF_INIT)
{
    EXPECT_EQ(0, ProfAPI::ProfCannPlugin::instance()->ProfInit(0, nullptr, 0));
}

int32_t fake_callback(uint32_t, void*, uint32_t) { return 0; };
TEST_F(PROF_API_PLUGIN_UTTEST, PROF_REGISTER_CALLBACK)
{
    EXPECT_EQ(-1, ProfAPI::ProfCannPlugin::instance()->ProfRegisterCallback(0, nullptr));
    EXPECT_EQ(0, ProfAPI::ProfCannPlugin::instance()->ProfRegisterCallback(0, &fake_callback));
}

TEST_F(PROF_API_PLUGIN_UTTEST, PROF_REPORT_DATA)
{
    EXPECT_EQ(0, ProfAPI::ProfCannPlugin::instance()->ProfReportData(0, 0, nullptr, 0));
}

TEST_F(PROF_API_PLUGIN_UTTEST, PROF_SETDEVICEIDBYGEMODELIDX)
{
    EXPECT_EQ(0, ProfAPI::ProfCannPlugin::instance()->ProfSetDeviceIdByGeModelIdx(0, 0));
}

TEST_F(PROF_API_PLUGIN_UTTEST, PROF_PROFNOTIFYSETDEVICE)
{
    EXPECT_EQ(0, ProfAPI::ProfCannPlugin::instance()->ProfNotifySetDevice(0, 0, 0));
}

TEST_F(PROF_API_PLUGIN_UTTEST, PROF_PROFFINALIZE)
{
    ProfAPI::ProfCannPlugin::instance()->ProfUnInitReportBuf();
    EXPECT_EQ(0, ProfAPI::ProfCannPlugin::instance()->ProfFinalize());
}

TEST_F(PROF_API_PLUGIN_UTTEST, PROF_UNSETDEVICEIDBYGEMODELIDX)
{
    EXPECT_EQ(0, ProfAPI::ProfCannPlugin::instance()->ProfUnSetDeviceIdByGeModelIdx(0, 0));
}

TEST_F(PROF_API_PLUGIN_UTTEST, PROF_REPORT_API)
{
    MsprofApi api;
    EXPECT_EQ(MSPROF_ERROR_UNINITIALIZE, ProfAPI::ProfCannPlugin::instance()->ProfReportApi(0, &api));
}

TEST_F(PROF_API_PLUGIN_UTTEST, PROF_REPORT_EVENT)
{
    MsprofEvent event;
    EXPECT_EQ(MSPROF_ERROR_UNINITIALIZE, ProfAPI::ProfCannPlugin::instance()->ProfReportEvent(0, &event));
}

TEST_F(PROF_API_PLUGIN_UTTEST, PROF_REPORT_COMPACTINFO)
{
    MsprofCompactInfo compact;
    EXPECT_EQ(
        MSPROF_ERROR_UNINITIALIZE,
        ProfAPI::ProfCannPlugin::instance()->ProfReportCompactInfo(0, &compact, sizeof(compact)));
}

TEST_F(PROF_API_PLUGIN_UTTEST, PROF_REPORT_ADDINFO)
{
    MsprofAdditionalInfo additional;
    EXPECT_EQ(
        MSPROF_ERROR_UNINITIALIZE,
        ProfAPI::ProfCannPlugin::instance()->ProfReportAdditionalInfo(0, &additional, sizeof(additional)));
}

TEST_F(PROF_API_PLUGIN_UTTEST, PROF_GET_SYS_FREERAM)
{
    ProfImplInfo info;
    ProfAPI::ProfCannPlugin::instance()->ProfGetImplInfo(info);
    EXPECT_NE(0, info.sysFreeRam);
}

static void ProfApiBufPopFuncStub(const ProfApiBufPopCallback func) {}

static void ProfCompactBufPopFuncStub(const ProfCompactBufPopCallback func) {}

static void ProfAdditionalBufPopFuncStub(const ProfAdditionalBufPopCallback func) {}

static void ProfReportBufEmptyFuncStub(const ProfReportBufEmptyCallback func) {}

static void ProfAdditionalBufPushFuncStub(const ProfAdditionalBufPushCallback func) {}

static void ProfMarkExFuncStub(const ProfMarkExCallback func) {}

TEST_F(PROF_API_PLUGIN_UTTEST, PROF_REPORT_BUF_SIMULATION)
{
    using namespace ProfAPI;
    uint32_t aging = 1;
    MsprofApi data1;
    MsprofCompactInfo data2;
    MsprofAdditionalInfo data3;
    ProfAPI::ProfCannPlugin::instance()->ProfInitReportBuf(5);
    ProfCannPlugin::instance()->profApiBufPop_ = ProfApiBufPopFuncStub;
    ProfCannPlugin::instance()->profCompactBufPop_ = ProfCompactBufPopFuncStub;
    ProfCannPlugin::instance()->profAdditionalBufPop_ = ProfAdditionalBufPopFuncStub;
    ProfCannPlugin::instance()->profReportBufEmpty_ = ProfReportBufEmptyFuncStub;
    ProfCannPlugin::instance()->profAdditionalBufPush_ = ProfAdditionalBufPushFuncStub;
    ProfCannPlugin::instance()->profMarkEx_ = ProfMarkExFuncStub;
    EXPECT_EQ(true, ProfAPI::IsReportBufEmpty());
    ProfCannPlugin::instance()->ProfRegisterFunc(REPORT_API_POP, reinterpret_cast<VOID_PTR>(TryPopApiBuf));
    ProfCannPlugin::instance()->ProfRegisterFunc(REPORT_COMPACCT_POP, reinterpret_cast<VOID_PTR>(TryPopCompactBuf));
    ProfCannPlugin::instance()->ProfRegisterFunc(
        REPORT_ADDITIONAL_POP, reinterpret_cast<VOID_PTR>(TryPopAdditionalBuf));
    ProfCannPlugin::instance()->ProfRegisterFunc(REPORT_BUF_EMPTY, reinterpret_cast<VOID_PTR>(IsReportBufEmpty));
    ProfCannPlugin::instance()->ProfRegisterFunc(
        REPORT_ADDITIONAL_PUSH, reinterpret_cast<VOID_PTR>(TryPushAdditionalBuf));
    ProfCannPlugin::instance()->ProfRegisterFunc(PROF_MARK_EX, reinterpret_cast<VOID_PTR>(TryMarkEx));
    ProfCannPlugin::instance()->ProfReportApi(aging, &data1);
    ProfCannPlugin::instance()->ProfReportCompactInfo(aging, &data2, sizeof(data2));
    ProfCannPlugin::instance()->ProfReportAdditionalInfo(aging, &data3, sizeof(data3));
    EXPECT_EQ(false, ProfAPI::IsReportBufEmpty());
    EXPECT_EQ(true, ProfAPI::TryPopApiBuf(aging, data1));
    EXPECT_EQ(true, ProfAPI::TryPopCompactBuf(aging, data2));
    EXPECT_EQ(true, ProfAPI::TryPopAdditionalBuf(aging, data3));
    ProfAPI::ProfCannPlugin::instance()->ProfUnInitReportBuf();
}

TEST_F(PROF_API_PLUGIN_UTTEST, PROF_ACLINIT)
{
    ProfAPI::ProfAclPlugin::instance()->ProfAclApiInit(nullptr);
    EXPECT_EQ(0, ProfAPI::ProfAclPlugin::instance()->ProfAclInit(0, nullptr, 0));
}

TEST_F(PROF_API_PLUGIN_UTTEST, PROF_ACLSTART)
{
    EXPECT_EQ(0, ProfAPI::ProfAclPlugin::instance()->ProfAclStart(0, nullptr));
}

TEST_F(PROF_API_PLUGIN_UTTEST, PROF_ACLSTOP)
{
    EXPECT_EQ(0, ProfAPI::ProfAclPlugin::instance()->ProfAclStop(0, nullptr));
}

TEST_F(PROF_API_PLUGIN_UTTEST, PROF_ACLFINALIZE)
{
    EXPECT_EQ(0, ProfAPI::ProfAclPlugin::instance()->ProfAclFinalize(0));
}

TEST_F(PROF_API_PLUGIN_UTTEST, PROF_ACLSUBSCRIBE)
{
    EXPECT_EQ(0, ProfAPI::ProfAclPlugin::instance()->ProfAclSubscribe(0, 0, nullptr));
}

TEST_F(PROF_API_PLUGIN_UTTEST, PROF_ACLUNSUBSCRIBE)
{
    EXPECT_EQ(0, ProfAPI::ProfAclPlugin::instance()->ProfAclUnSubscribe(0, 0));
}

TEST_F(PROF_API_PLUGIN_UTTEST, PROF_OPSUBSCRIBE)
{
    EXPECT_EQ(0, ProfAPI::ProfAclPlugin::instance()->ProfOpSubscribe(0, nullptr));
}

TEST_F(PROF_API_PLUGIN_UTTEST, PROF_OPUNSUBSCRIBE)
{
    EXPECT_EQ(0, ProfAPI::ProfAclPlugin::instance()->ProfOpUnSubscribe(0));
}

TEST_F(PROF_API_PLUGIN_UTTEST, PROF_ACLDRVGETDEVNUM)
{
    EXPECT_EQ(-1, ProfAPI::ProfAclPlugin::instance()->ProfAclDrvGetDevNum());
}

TEST_F(PROF_API_PLUGIN_UTTEST, PROF_ACLGETOPTIME)
{
    EXPECT_EQ(0, ProfAPI::ProfAclPlugin::instance()->ProfAclGetOpTime(0, nullptr, 0, 0));
}

TEST_F(PROF_API_PLUGIN_UTTEST, PROF_ACLGETID)
{
    EXPECT_EQ(0, ProfAPI::ProfAclPlugin::instance()->ProfAclGetId(0, nullptr, 0, 0));
}

TEST_F(PROF_API_PLUGIN_UTTEST, PROF_ACLGETOPVAL)
{
    EXPECT_EQ(0, ProfAPI::ProfAclPlugin::instance()->ProfAclGetOpVal(0, nullptr, 0, 0, nullptr, 0));
}

TEST_F(PROF_API_PLUGIN_UTTEST, PROF_ACLGETOPEXECUTIONTIME)
{
    EXPECT_EQ(0, ProfAPI::ProfAclPlugin::instance()->ProfGetOpExecutionTime(nullptr, 0, 0));
}

int ProfApiSutb(void)
{
    profOstreamStub();
    return 0;
}
#ifdef PROF_API_STUB
TEST_F(PROF_API_PLUGIN_UTTEST, PROF_API_STUB)
{
    GlobalMockObject::verify();
    EXPECT_EQ(0, ProfApiSutb());
}
#endif
