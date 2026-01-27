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
#include "msprof_dlog.h"
#include "prof_acl_plugin.h"
#include "prof_cann_plugin.h"
#include "prof_atls_plugin.h"
#include "prof_plugin_manager.h"
#include "mmpa_api.h"

#include "prof_api.h"
#include "queue/report_buffer.h"
#include "prof_report_api.h"
#include "prof_plugin.h"

#ifdef PROF_API_STUB
extern void profOstreamStub(void);
#endif
class PROF_API_PLUGIN_UTTEST : public testing::Test {
protected:
    virtual void SetUp() {
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

TEST_F(PROF_API_PLUGIN_UTTEST, PROF_API_INIT)
{
    GlobalMockObject::verify();
    EXPECT_EQ(0, ProfApiInitStub());
}
static int32_t TestCallbackHandle(uint32_t dataType, void *data, uint32_t dataLen) { return 0; };
static int32_t g_count = 0;
static int32_t TestCallbackHandle1(uint32_t dataType, void *data, uint32_t dataLen)
{
    g_count++;
    return 0;
};
static int32_t TestCallbackHandle2(uint32_t dataType, void *data, uint32_t dataLen)
{
    g_count++;
    return 0;
};
int32_t TestReporterHandle(uint32_t moduleId, uint32_t type, void *data, uint32_t len) { return 0; };
int32_t TestCtrlHandle(uint32_t type, void *data, uint32_t len) { return 0; };
int32_t TestDeviceHandle(void *data, uint32_t len) { return 0; };
TEST_F(PROF_API_PLUGIN_UTTEST, PROF_REGISTER_REPORTER)
{
    EXPECT_EQ(0, ProfAPI::ProfAtlsPlugin::instance()->ProfRegisterReporter(*TestReporterHandle));
}

TEST_F(PROF_API_PLUGIN_UTTEST, PROF_REGISTER_CTRL)
{
    EXPECT_EQ(0, ProfAPI::ProfAtlsPlugin::instance()->ProfRegisterCtrl(*TestCtrlHandle));
}

TEST_F(PROF_API_PLUGIN_UTTEST, PROF_REGISTER_DEVICE_NOTIFY)
{
    EXPECT_EQ(0, ProfAPI::ProfAtlsPlugin::instance()->ProfRegisterDeviceNotify(*TestDeviceHandle));
}

TEST_F(PROF_API_PLUGIN_UTTEST, PROF_SET_PROF_COMMAND)
{
    MsprofCommandHandle command1;
    command1.type = PROF_COMMANDHANDLE_TYPE_INIT;
    auto data1 = reinterpret_cast<void *>(&command1);
    EXPECT_EQ(0, ProfAPI::ProfAtlsPlugin::instance()->ProfSetProfCommand(data1, 0));
    EXPECT_EQ(0, ProfAPI::ProfAtlsPlugin::instance()->ProfRegisterCallback(7, *TestCallbackHandle1));

    EXPECT_EQ(0, ProfAPI::ProfAtlsPlugin::instance()->ProfSetProfCommand(data1, 0));
    EXPECT_EQ(0, ProfAPI::ProfAtlsPlugin::instance()->ProfRegisterCallback(7, *TestCallbackHandle2));
    EXPECT_EQ(3, g_count);

    MsprofCommandHandle command2;
    command2.type = PROF_COMMANDHANDLE_TYPE_START;
    auto data2 = reinterpret_cast<void *>(&command2);
    EXPECT_EQ(0, ProfAPI::ProfAtlsPlugin::instance()->ProfSetProfCommand(data2, 0));
    EXPECT_EQ(5, g_count);
    EXPECT_EQ(0, ProfAPI::ProfAtlsPlugin::instance()->ProfRegisterCallback(8, *TestCallbackHandle));

    MsprofCommandHandle command3;
    command3.type = PROF_COMMANDHANDLE_TYPE_MODEL_SUBSCRIBE;
    auto data3 = reinterpret_cast<void *>(&command3);
    EXPECT_EQ(0, ProfAPI::ProfAtlsPlugin::instance()->ProfSetProfCommand(data3, 0));
    EXPECT_EQ(7, g_count);
    EXPECT_EQ(0, ProfAPI::ProfAtlsPlugin::instance()->ProfRegisterCallback(9, *TestCallbackHandle));
}

TEST_F(PROF_API_PLUGIN_UTTEST, PROF_SET_PROF_INIT)
{
    EXPECT_EQ(0, ProfAPI::ProfAtlsPlugin::instance()->ProfInit(0, nullptr, 0));
}

TEST_F(PROF_API_PLUGIN_UTTEST, PROF_SET_REGISTER_CALLBACK)
{
    EXPECT_EQ(0, ProfAPI::ProfAtlsPlugin::instance()->ProfRegisterCallback(0, *TestCallbackHandle));
}

TEST_F(PROF_API_PLUGIN_UTTEST, PROF_SET_DEVICEID_BY_GEMODELIDX)
{
    EXPECT_EQ(0, ProfAPI::ProfAtlsPlugin::instance()->ProfSetDeviceIdByGeModelIdx(0, 0));
}

TEST_F(PROF_API_PLUGIN_UTTEST, PROF_UNSET_DEVICEID_BY_GEMODELIDX)
{
    EXPECT_EQ(0, ProfAPI::ProfAtlsPlugin::instance()->ProfUnSetDeviceIdByGeModelIdx(0, 0));
}

TEST_F(PROF_API_PLUGIN_UTTEST, PROF_GET_DEVICEID_BY_GEMODELIDX)
{
    EXPECT_EQ(-1, ProfAPI::ProfAtlsPlugin::instance()->ProfGetDeviceIdByGeModelIdx(0, nullptr));
}

TEST_F(PROF_API_PLUGIN_UTTEST, PROF_NOTIFY_SETDEVICE)
{
    // set profSetDevice_ to nullptr
    auto handle = ProfAPI::ProfAtlsPlugin::instance()->profSetDevice_;
    ProfAPI::ProfAtlsPlugin::instance()->profSetDevice_ = nullptr;
    EXPECT_EQ(0, ProfAPI::ProfAtlsPlugin::instance()->ProfNotifySetDevice(0, 0, true));
    ProfAPI::ProfAtlsPlugin::instance()->profSetDevice_ = handle;

    EXPECT_EQ(0, ProfAPI::ProfAtlsPlugin::instance()->ProfNotifySetDevice(0, 0, true));
}

TEST_F(PROF_API_PLUGIN_UTTEST, PROF_PROF_START)
{
    EXPECT_EQ(0, ProfAPI::ProfAtlsPlugin::instance()->ProfStart(0, nullptr, 0));
}

TEST_F(PROF_API_PLUGIN_UTTEST, PROF_PROF_STOP)
{
    EXPECT_EQ(0, ProfAPI::ProfAtlsPlugin::instance()->ProfStop(0, nullptr, 0));
}

int32_t ProfApiCallbackC(uint32_t agingFlag, const MsprofApi* data)
{
    return 0;
}

int32_t ProfApiCallback(uint32_t agingFlag, const MsprofApi& data)
{
    return 0;
}

TEST_F(PROF_API_PLUGIN_UTTEST, PROF_Atls_REPORT_API)
{
    EXPECT_EQ(0, ProfAPI::ProfAtlsPlugin::instance()->RegisterProfileCallback(PROFILE_REPORT_API_C_CALLBACK,
        (void*)ProfApiCallbackC, sizeof(void*)));
    MsprofApi api;
    EXPECT_EQ(0, ProfAPI::ProfAtlsPlugin::instance()->ProfReportApi(0, &api));
    EXPECT_EQ(0, ProfAPI::ProfAtlsPlugin::instance()->RegisterProfileCallback(PROFILE_REPORT_API_CALLBACK,
        (void*)ProfApiCallback, sizeof(void*)));
    EXPECT_EQ(0, ProfAPI::ProfAtlsPlugin::instance()->ProfReportApi(0, &api));
}

int32_t ProfEventCallbackC(uint32_t agingFlag, const MsprofEvent* event)
{
    return 0;
}

int32_t ProfEventCallback(uint32_t agingFlag, const MsprofEvent& event)
{
    return 0;
}

TEST_F(PROF_API_PLUGIN_UTTEST, PROF_Atls_REPORT_EVENT)
{
    EXPECT_EQ(0, ProfAPI::ProfAtlsPlugin::instance()->RegisterProfileCallback(PROFILE_REPORT_EVENT_C_CALLBACK,
        (void*)ProfEventCallbackC, sizeof(void*)));
    MsprofEvent event;
    EXPECT_EQ(0, ProfAPI::ProfAtlsPlugin::instance()->ProfReportEvent(0, &event));
    EXPECT_EQ(0, ProfAPI::ProfAtlsPlugin::instance()->RegisterProfileCallback(PROFILE_REPORT_EVENT_CALLBACK,
        (void*)ProfEventCallback, sizeof(void*)));
    EXPECT_EQ(0, ProfAPI::ProfAtlsPlugin::instance()->ProfReportEvent(0, &event));
}

TEST_F(PROF_API_PLUGIN_UTTEST, PROF_Atls_REPORT_COMPACTINFO)
{
    EXPECT_EQ(0, ProfAPI::ProfAtlsPlugin::instance()->ProfReportCompactInfo(0, nullptr, 0));
}

TEST_F(PROF_API_PLUGIN_UTTEST, PROF_Atls_REPORT_ADDINFO)
{
    EXPECT_EQ(0, ProfAPI::ProfAtlsPlugin::instance()->ProfReportAdditionalInfo(0, nullptr, 0));
}

int32_t RegTypeCallbackC(uint16_t level, uint32_t typeId, const char* typeName, size_t len)
{
    return 0;
}

int32_t RegTypeCallback(uint16_t level, uint32_t typeId, const std::string& type)
{
    return 0;
}

TEST_F(PROF_API_PLUGIN_UTTEST, PROF_Atls_REG_TYPE_INFO)
{
    const char* type = "type";
    EXPECT_EQ(0, ProfAPI::ProfAtlsPlugin::instance()->RegisterProfileCallback(PROFILE_REPORT_REG_TYPE_INFO_C_CALLBACK,
        (void*)RegTypeCallbackC, sizeof(void*)));
    EXPECT_EQ(0, ProfAPI::ProfAtlsPlugin::instance()->ProfReportRegTypeInfo(0, 0, type, strlen(type)));
    EXPECT_EQ(0, ProfAPI::ProfAtlsPlugin::instance()->RegisterProfileCallback(PROFILE_REPORT_REG_TYPE_INFO_CALLBACK,
        (void*)RegTypeCallback, sizeof(void*)));
    EXPECT_EQ(0, ProfAPI::ProfAtlsPlugin::instance()->ProfReportRegTypeInfo(0, 0, type, strlen(type)));
}

uint64_t GetHashIdCallbackC(const char* info, size_t len)
{
    return 0;
}

uint64_t GetHashIdCallback(const std::string& info)
{
    return 0;
}

TEST_F(PROF_API_PLUGIN_UTTEST, ProfAtlasGetHashId)
{
    const char* info = "hello";
    EXPECT_EQ(0, ProfAPI::ProfAtlsPlugin::instance()->RegisterProfileCallback(PROFILE_REPORT_GET_HASH_ID_C_CALLBACK,
        (void*)GetHashIdCallbackC, sizeof(void*)));
    EXPECT_EQ(0, ProfAPI::ProfAtlsPlugin::instance()->ProfReportGetHashId(info, strlen(info)));
    EXPECT_EQ(0, ProfAPI::ProfAtlsPlugin::instance()->RegisterProfileCallback(PROFILE_REPORT_GET_HASH_ID_CALLBACK,
        (void*)GetHashIdCallback, sizeof(void*)));
    EXPECT_EQ(0, ProfAPI::ProfAtlsPlugin::instance()->ProfReportGetHashId(info, strlen(info)));
}

TEST_F(PROF_API_PLUGIN_UTTEST, PORF_Atlas_PROFFINALIZE)
{
    EXPECT_EQ(0, ProfAPI::ProfAtlsPlugin::instance()->ProfFinalize());
}

TEST_F(PROF_API_PLUGIN_UTTEST, ProfAtlasRegisterProfileCallback)
{
    void *handle = (void *)0x00010000ULL;
    EXPECT_EQ(-1, ProfAPI::ProfAtlsPlugin::instance()->RegisterProfileCallback(PROFILE_CTRL_CALLBACK, nullptr, 0));
    EXPECT_EQ(-1, ProfAPI::ProfAtlsPlugin::instance()->RegisterProfileCallback(100, handle, 0)); // invalid callback type
    EXPECT_EQ(0, ProfAPI::ProfAtlsPlugin::instance()->RegisterProfileCallback(PROFILE_CTRL_CALLBACK, handle, 0));
    EXPECT_EQ(0, ProfAPI::ProfAtlsPlugin::instance()->RegisterProfileCallback(PROFILE_DEVICE_STATE_CALLBACK, handle, 0));
    EXPECT_EQ(0, ProfAPI::ProfAtlsPlugin::instance()->RegisterProfileCallback(PROFILE_REPORT_API_CALLBACK, handle, 0));
    EXPECT_EQ(0, ProfAPI::ProfAtlsPlugin::instance()->RegisterProfileCallback(PROFILE_REPORT_EVENT_CALLBACK, handle, 0));
    EXPECT_EQ(0, ProfAPI::ProfAtlsPlugin::instance()->RegisterProfileCallback(PROFILE_REPORT_COMPACT_CALLBACK, handle, 0));
    EXPECT_EQ(0, ProfAPI::ProfAtlsPlugin::instance()->RegisterProfileCallback(PROFILE_REPORT_ADDITIONAL_CALLBACK, handle, 0));
    EXPECT_EQ(0, ProfAPI::ProfAtlsPlugin::instance()->RegisterProfileCallback(PROFILE_REPORT_REG_TYPE_INFO_CALLBACK, handle, 0));
    EXPECT_EQ(0, ProfAPI::ProfAtlsPlugin::instance()->RegisterProfileCallback(PROFILE_REPORT_GET_HASH_ID_CALLBACK, handle, 0));
    EXPECT_EQ(0, ProfAPI::ProfAtlsPlugin::instance()->RegisterProfileCallback(PROFILE_HOST_FREQ_IS_ENABLE_CALLBACK, handle, 0));
    EXPECT_EQ(0, ProfAPI::ProfAtlsPlugin::instance()->RegisterProfileCallback(PROFILE_REPORT_API_C_CALLBACK, handle, 0));
    EXPECT_EQ(0, ProfAPI::ProfAtlsPlugin::instance()->RegisterProfileCallback(PROFILE_REPORT_EVENT_C_CALLBACK, handle, 0));
    EXPECT_EQ(0, ProfAPI::ProfAtlsPlugin::instance()->RegisterProfileCallback(PROFILE_REPORT_REG_TYPE_INFO_C_CALLBACK, handle, 0));
    EXPECT_EQ(0, ProfAPI::ProfAtlsPlugin::instance()->RegisterProfileCallback(PROFILE_REPORT_GET_HASH_ID_C_CALLBACK, handle, 0));
    EXPECT_EQ(0, ProfAPI::ProfAtlsPlugin::instance()->RegisterProfileCallback(PROFILE_HOST_FREQ_IS_ENABLE_C_CALLBACK, handle, 0));
}

static int32_t ProfStartFuncStub(uint32_t dataType, const void *data, uint32_t length)
{
    (void)dataType;
    (void)data;
    (void)length;
    return 0;
}

static int32_t ProfStopFuncStub(uint32_t dataType, const void *data, uint32_t length)
{
    (void)dataType;
    (void)data;
    (void)length;
    return 0;
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

TEST_F(PROF_API_PLUGIN_UTTEST, PROF_INIT)
{
    EXPECT_EQ(0, ProfAPI::ProfCannPlugin::instance()->ProfInit(0, nullptr, 0));
}

int32_t fake_callback(uint32_t, void *, uint32_t) {return 0;};
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
    EXPECT_EQ(MSPROF_ERROR_UNINITIALIZE, ProfAPI::ProfCannPlugin::instance()->ProfReportCompactInfo(0, &compact, sizeof(compact)));
}

TEST_F(PROF_API_PLUGIN_UTTEST, PROF_REPORT_ADDINFO)
{
    MsprofAdditionalInfo additional;
    EXPECT_EQ(MSPROF_ERROR_UNINITIALIZE, ProfAPI::ProfCannPlugin::instance()->ProfReportAdditionalInfo(0, &additional, sizeof(additional)));
}

TEST_F(PROF_API_PLUGIN_UTTEST, PROF_GET_SYS_FREERAM)
{
    ProfImplInfo info;
    ProfAPI::ProfCannPlugin::instance()->ProfGetImplInfo(info);
    EXPECT_NE(0, info.sysFreeRam);
}

static void ProfApiBufPopFuncStub(const ProfApiBufPopCallback func)
{
}

static void ProfCompactBufPopFuncStub(const ProfCompactBufPopCallback func)
{
}

static void ProfAdditionalBufPopFuncStub(const ProfAdditionalBufPopCallback func)
{
}

static void ProfReportBufEmptyFuncStub(const ProfReportBufEmptyCallback func)
{
}

static void ProfAdditionalBufPushFuncStub(const ProfAdditionalBufPushCallback func)
{
}

static void ProfMarkExFuncStub(const ProfMarkExCallback func)
{
}

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
    ProfCannPlugin::instance()->ProfRegisterFunc(REPORT_ADDITIONAL_POP, reinterpret_cast<VOID_PTR>(TryPopAdditionalBuf));
    ProfCannPlugin::instance()->ProfRegisterFunc(REPORT_BUF_EMPTY, reinterpret_cast<VOID_PTR>(IsReportBufEmpty));
    ProfCannPlugin::instance()->ProfRegisterFunc(REPORT_ADDITIONAL_PUSH, reinterpret_cast<VOID_PTR>(TryPushAdditionalBuf));
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
