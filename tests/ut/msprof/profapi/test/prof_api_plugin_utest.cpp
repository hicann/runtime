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
#include <map>
#include <string>
#include "msprof_dlog.h"
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

#ifdef PROF_API_STUB
extern void profOstreamStub(void);
#endif

namespace {
uint32_t setInjectionFuncCallCount = 0;
uint32_t injectionInitializeCallCount = 0;
uint32_t getInjectionFuncCallCount = 0;
uint32_t registerDataCallbackCallCount = 0;
void* injectionFuncStub = reinterpret_cast<void*>(&getInjectionFuncCallCount);

int32_t ProfSetInjectionFuncStub(uint32_t type, void* func)
{
    (void)type;
    (void)func;
    setInjectionFuncCallCount++;
    return 0;
}

int32_t ProfInjectionInitializeStub()
{
    injectionInitializeCallCount++;
    return 0;
}

void* ProfGetInjectionFuncStub(uint32_t type)
{
    (void)type;
    getInjectionFuncCallCount++;
    return injectionFuncStub;
}

int32_t ProfRegisterDataCallbackStub(uint32_t type, void* callback)
{
    (void)type;
    (void)callback;
    registerDataCallbackCallCount++;
    return 0;
}

void RegisterInjectionApiStubs()
{
    RegisterMmDlsymStub("MsprofSetInjectionFunc", reinterpret_cast<void*>(ProfSetInjectionFuncStub));
    RegisterMmDlsymStub("MsprofInjectionInitialize", reinterpret_cast<void*>(ProfInjectionInitializeStub));
    RegisterMmDlsymStub("MsprofGetInjectionFunc", reinterpret_cast<void*>(ProfGetInjectionFuncStub));
    RegisterMmDlsymStub("MsprofRegisterDataCallback", reinterpret_cast<void*>(ProfRegisterDataCallbackStub));
}

void ResetInjectionApiStubCount()
{
    setInjectionFuncCallCount = 0;
    injectionInitializeCallCount = 0;
    getInjectionFuncCallCount = 0;
    registerDataCallbackCallCount = 0;
}

void ResetProfApiLoadState()
{
    auto plugin = ProfAPI::ProfCannPlugin::instance();
    plugin->msProfLibHandle_ = nullptr;
    plugin->profApiLoadFlag_ = PTHREAD_ONCE_INIT;
    plugin->profSetInjectionFunc_ = nullptr;
    plugin->profInjectionInitialize_ = nullptr;
    plugin->profGetInjectionFunc_ = nullptr;
    plugin->profRegisterDataCallback_ = nullptr;
}
} // namespace

class PROF_API_PLUGIN_UTTEST : public testing::Test {
protected:
    virtual void SetUp()
    {
        MOCKER(dlopen).stubs().will(invoke(mmDlopen));
        MOCKER(dlsym).stubs().will(invoke(mmDlsym));
        MOCKER(dlclose).stubs().will(invoke(mmDlclose));
        MOCKER(dlerror).stubs().will(invoke(mmDlerror));
    }
    virtual void TearDown() {}
};

int ProfApiInitStub(void)
{
    ProfAPI::ProfCannPlugin::instance()->ProfApiInit();
    return 0;
}

TEST_F(PROF_API_PLUGIN_UTTEST, PROF_INJECTION_API_COLD_START)
{
    RegisterInjectionApiStubs();
    ResetInjectionApiStubCount();
    ResetProfApiLoadState();
    EXPECT_EQ(
        0, ProfAPI::ProfCannPlugin::instance()->ProfSetInjectionFunc(
               PROF_HOOK_SET, reinterpret_cast<void*>(ProfSetInjectionFuncStub)));
    EXPECT_EQ(1U, setInjectionFuncCallCount);
    EXPECT_EQ(0, ProfAPI::ProfCannPlugin::instance()->ProfInjectionInitialize());
    EXPECT_EQ(1U, injectionInitializeCallCount);
    EXPECT_EQ(injectionFuncStub, ProfAPI::ProfCannPlugin::instance()->ProfGetInjectionFunc(PROF_HOOK_GET));
    EXPECT_EQ(1U, getInjectionFuncCallCount);
    EXPECT_EQ(
        0, ProfAPI::ProfCannPlugin::instance()->ProfRegisterDataCallback(
               PROF_DATA_CALLBACK_COMPUTE, reinterpret_cast<void*>(ProfRegisterDataCallbackStub)));
    EXPECT_EQ(1U, registerDataCallbackCallCount);
}

TEST_F(PROF_API_PLUGIN_UTTEST, PROF_INJECTION_API_SYMBOL_NULL)
{
    ProfAPI::ProfCannPlugin::instance()->profSetInjectionFunc_ = nullptr;
    ProfAPI::ProfCannPlugin::instance()->profInjectionInitialize_ = nullptr;
    ProfAPI::ProfCannPlugin::instance()->profGetInjectionFunc_ = nullptr;
    ProfAPI::ProfCannPlugin::instance()->profRegisterDataCallback_ = nullptr;
    EXPECT_EQ(-1, ProfAPI::ProfCannPlugin::instance()->ProfSetInjectionFunc(PROF_HOOK_SET, nullptr));
    EXPECT_EQ(-1, ProfAPI::ProfCannPlugin::instance()->ProfInjectionInitialize());
    EXPECT_EQ(nullptr, ProfAPI::ProfCannPlugin::instance()->ProfGetInjectionFunc(PROF_HOOK_GET));
    EXPECT_EQ(-1, ProfAPI::ProfCannPlugin::instance()->ProfRegisterDataCallback(PROF_DATA_CALLBACK_COMPUTE, nullptr));
    RegisterInjectionApiStubs();
    ProfAPI::ProfCannPlugin::instance()->LoadProfRawDataApi();
}

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
