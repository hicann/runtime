/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include <thread>
#include "mockcpp/mockcpp.hpp"
#include "gtest/gtest.h"
#include "msprof_dlog.h"
#include "prof_acl_plugin.h"
#include "prof_cann_plugin.h"
#include "prof_runtime_plugin.h"
#include "prof_atls_plugin.h"
#include "errno/error_code.h"
#include "mmpa_api.h"
#include "acl/acl_base.h"
#include "runtime/base.h"
#include "prof_plugin.h"

using namespace analysis::dvvp::common::error;
using namespace ProfAPI;
class PROF_API_PLUGIN_STTEST : public testing::Test {
protected:
    virtual void SetUp() {}
    virtual void TearDown() {}
};

int32_t TestCallbackHandle(uint32_t dataType, void *data, uint32_t dataLen) { return 0; };
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

int32_t TestRegTypeInfoCallbackC(uint16_t level, uint32_t typeId, const char* typeName, size_t len) { return 0; };
int32_t TestRegTypeInfoCallback(uint16_t level, uint32_t typeId, const std::string &typeName) { return 0; };

uint64_t TestGetHashIdCallbackC(const char* info, size_t len) { return 0; };
uint64_t TestGetHashIdCallback(const std::string &info) { return 0; };

TEST_F(PROF_API_PLUGIN_STTEST, PROF_ATLAS_THREAD)
{
    std::vector<std::thread> th;
    for (int i = 0; i < 8; i++) {
        th.push_back(std::thread([]() -> void {
            EXPECT_EQ(0, ProfAPI::ProfAtlsPlugin::instance()->ProfRegisterCallback(0, *TestCallbackHandle));
            EXPECT_EQ(0, ProfAPI::ProfAtlsPlugin::instance()->ProfNotifySetDevice(0, 0, true));
            EXPECT_EQ(0, ProfAPI::ProfAtlsPlugin::instance()->ProfNotifySetDevice(0, 0, false));
            EXPECT_EQ(0, ProfAPI::ProfAtlsPlugin::instance()->ProfNotifySetDevice(0, 0, false));

            // set profSetDevice_ to nullptr
            auto handle = ProfAPI::ProfAtlsPlugin::instance()->profSetDevice_;
            ProfAPI::ProfAtlsPlugin::instance()->profSetDevice_ = nullptr;
            EXPECT_EQ(0, ProfAPI::ProfAtlsPlugin::instance()->ProfNotifySetDevice(0, 0, true));
            ProfAPI::ProfAtlsPlugin::instance()->profSetDevice_ = handle;

            EXPECT_EQ(0, ProfAPI::ProfAtlsPlugin::instance()->ProfSetDeviceIdByGeModelIdx(0, 0));
            EXPECT_EQ(0, ProfAPI::ProfAtlsPlugin::instance()->ProfUnSetDeviceIdByGeModelIdx(0, 0));
        }));
    }
    for_each(th.begin(), th.end(), std::mem_fn(&std::thread::join));
}

TEST_F(PROF_API_PLUGIN_STTEST, PROF_REGISTER_REPORTER)
{
    EXPECT_EQ(0, ProfAPI::ProfAtlsPlugin::instance()->ProfRegisterReporter(*TestReporterHandle));
}

TEST_F(PROF_API_PLUGIN_STTEST, PROF_REGISTER_CTRL)
{
    EXPECT_EQ(0, ProfAPI::ProfAtlsPlugin::instance()->ProfRegisterCtrl(*TestCtrlHandle));
}

TEST_F(PROF_API_PLUGIN_STTEST, PROF_REGISTER_DEVICE_NOTIFY)
{
    EXPECT_EQ(0, ProfAPI::ProfAtlsPlugin::instance()->ProfRegisterDeviceNotify(*TestDeviceHandle));
}

TEST_F(PROF_API_PLUGIN_STTEST, PROF_SET_PROF_COMMAND)
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

TEST_F(PROF_API_PLUGIN_STTEST, PROF_SET_STEP_INFO)
{
    EXPECT_EQ(-1, ProfAPI::ProfAtlsPlugin::instance()->ProfSetStepInfo(0, 0, nullptr));
    EXPECT_EQ(-1, ProfAPI::ProfCannPlugin::instance()->ProfSetStepInfo(0, 0, nullptr));
    EXPECT_NE(0, ProfAPI::ProfPlugin::ReadProfCommandHandle());
    EXPECT_EQ(0, ProfAPI::ProfAtlsPlugin::instance()->ProfRegisterCallback(45, *TestCallbackHandle1));
    EXPECT_EQ(0, ProfAPI::ProfAtlsPlugin::instance()->ProfRegisterCallback(45, *TestCallbackHandle2));
    EXPECT_EQ(0, ProfAPI::ProfAtlsPlugin::instance()->ProfSetStepInfo(0, 0, nullptr));
    EXPECT_NE(0, ProfAPI::ProfPlugin::ReadProfCommandHandle());
    EXPECT_EQ(11, g_count);
    EXPECT_EQ(0, ProfAPI::ProfCannPlugin::instance()->ProfRegisterCallback(45, *TestCallbackHandle1));
    EXPECT_EQ(0, ProfAPI::ProfCannPlugin::instance()->ProfRegisterCallback(45, *TestCallbackHandle2));
    EXPECT_EQ(0, ProfAPI::ProfCannPlugin::instance()->ProfSetStepInfo(0, 0, nullptr));
    EXPECT_EQ(13, g_count);
}

TEST_F(PROF_API_PLUGIN_STTEST, PROF_SET_PROF_INIT)
{
    EXPECT_EQ(0, ProfAPI::ProfAtlsPlugin::instance()->ProfInit(0, nullptr, 0));
}

TEST_F(PROF_API_PLUGIN_STTEST, PROF_PROF_START)
{
    EXPECT_EQ(0, ProfAPI::ProfAtlsPlugin::instance()->ProfStart(0, nullptr, 0));
}
 
TEST_F(PROF_API_PLUGIN_STTEST, PROF_PROF_STOP)
{
    EXPECT_EQ(0, ProfAPI::ProfAtlsPlugin::instance()->ProfStop(0, nullptr, 0));
}

TEST_F(PROF_API_PLUGIN_STTEST, PROF_GET_DEVICEID_BY_GEMODELIDX)
{
    EXPECT_EQ(-1, ProfAPI::ProfAtlsPlugin::instance()->ProfGetDeviceIdByGeModelIdx(0, nullptr));
}

TEST_F(PROF_API_PLUGIN_STTEST, PROF_Atls_REPORT_API)
{
    MsprofApi api;
    EXPECT_EQ(0, ProfAPI::ProfAtlsPlugin::instance()->ProfReportApi(0, &api));
}

TEST_F(PROF_API_PLUGIN_STTEST, PROF_Atls_REPORT_EVENT)
{
    MsprofEvent event;
    EXPECT_EQ(0, ProfAPI::ProfAtlsPlugin::instance()->ProfReportEvent(0, &event));
}

TEST_F(PROF_API_PLUGIN_STTEST, PROF_Atls_REPORT_COMPACTINFO)
{
    EXPECT_EQ(0, ProfAPI::ProfAtlsPlugin::instance()->ProfReportCompactInfo(0, nullptr, 0));
}

TEST_F(PROF_API_PLUGIN_STTEST, PROF_Atls_REPORT_ADDINFO)
{
    EXPECT_EQ(0, ProfAPI::ProfAtlsPlugin::instance()->ProfReportAdditionalInfo(0, nullptr, 0));
}

TEST_F(PROF_API_PLUGIN_STTEST, PROF_Atlas_REPORT_TYPE_INFO)
{
    const char* type = "test";
    EXPECT_EQ(0, ProfAPI::ProfAtlsPlugin::instance()->ProfReportRegTypeInfo(0, 0, type, strlen(type)));
}

TEST_F(PROF_API_PLUGIN_STTEST, PROF_Atlas_REPORT_TYPE_INFO_WITH_VALID_CALLBACKIMPL)
{
    const char* type = "test";
    ProfAPI::ProfAtlsPlugin::instance()->RegisterProfileCallback(PROFILE_REPORT_REG_TYPE_INFO_CALLBACK, reinterpret_cast<VOID_PTR>(TestRegTypeInfoCallback), 0);
    ProfAPI::ProfAtlsPlugin::instance()->RegisterProfileCallback(PROFILE_REPORT_REG_TYPE_INFO_C_CALLBACK, reinterpret_cast<VOID_PTR>(TestRegTypeInfoCallbackC), 0);
    EXPECT_EQ(0, ProfAPI::ProfAtlsPlugin::instance()->ProfReportRegTypeInfo(0, 0, type, strlen(type)));
}

TEST_F(PROF_API_PLUGIN_STTEST, ProfAtlsGetHashId)
{
    const char* info = "hello";
    EXPECT_EQ(0, ProfAPI::ProfAtlsPlugin::instance()->ProfReportGetHashId(info, strlen(info)));
}

TEST_F(PROF_API_PLUGIN_STTEST, ProfAtlsGetHashIdWithValidCallbackImpl)
{
    const char* info = "hello";
    ProfAPI::ProfAtlsPlugin::instance()->RegisterProfileCallback(PROFILE_REPORT_GET_HASH_ID_CALLBACK, reinterpret_cast<VOID_PTR>(TestGetHashIdCallback), 0);
    ProfAPI::ProfAtlsPlugin::instance()->RegisterProfileCallback(PROFILE_REPORT_GET_HASH_ID_C_CALLBACK, reinterpret_cast<VOID_PTR>(TestGetHashIdCallbackC), 0);
    EXPECT_EQ(0, ProfAPI::ProfAtlsPlugin::instance()->ProfReportGetHashId(info, strlen(info)));
}

TEST_F(PROF_API_PLUGIN_STTEST, ProfAtlasRegisterProfileCallback)
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
    EXPECT_EQ(0, ProfAPI::ProfAtlsPlugin::instance()->RegisterProfileCallback(PROFILE_REPORT_API_C_CALLBACK, handle, 0));
    EXPECT_EQ(0, ProfAPI::ProfAtlsPlugin::instance()->RegisterProfileCallback(PROFILE_REPORT_EVENT_C_CALLBACK, handle, 0));
    EXPECT_EQ(0, ProfAPI::ProfAtlsPlugin::instance()->RegisterProfileCallback(PROFILE_REPORT_REG_TYPE_INFO_C_CALLBACK, handle, 0));
    EXPECT_EQ(0, ProfAPI::ProfAtlsPlugin::instance()->RegisterProfileCallback(PROFILE_REPORT_GET_HASH_ID_C_CALLBACK, handle, 0));
    EXPECT_EQ(0, ProfAPI::ProfAtlsPlugin::instance()->RegisterProfileCallback(PROFILE_HOST_FREQ_IS_ENABLE_C_CALLBACK, handle, 0));
}

rtError_t rtProfilerTraceExStub3(uint64_t indexId, uint64_t modelId, uint16_t tagId, rtStream_t stm)
{
    (void)indexId;
    (void)modelId;
    (void)tagId;
    (void)stm;
    return -1;
}
 
TEST_F(PROF_API_PLUGIN_STTEST, RuntimePluginBase)
{
    std::shared_ptr<ProfRuntimePlugin> plugin;
    plugin = std::make_shared<ProfRuntimePlugin>();
    // Failed to get api stub[rtProfilerTraceEx] func
    EXPECT_EQ(PROFILING_SUCCESS, plugin->RuntimeApiInit());
    EXPECT_EQ(PROFILING_FAILED, plugin->ProfMarkEx(0, 0, 0, nullptr));
    MOCKER(&ProfRuntimePlugin::GetPluginApiFunc)
        .stubs()
        .will(returnValue((void *)&rtProfilerTraceExStub3));
    EXPECT_EQ(PROFILING_FAILED, plugin->ProfMarkEx(0, 0, 0, nullptr));
    plugin->runtimeLibHandle_ = nullptr;
    plugin->runtimeApiInfoMap_.clear();
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

TEST_F(PROF_API_PLUGIN_STTEST, PROF_START_STOP)
{
    EXPECT_EQ(0, ProfAPI::ProfCannPlugin::instance()->ProfStart(0, nullptr, 0));
    ProfAPI::ProfCannPlugin::instance()->profStart_ = ProfStartFuncStub;
    EXPECT_EQ(0, ProfAPI::ProfCannPlugin::instance()->ProfStart(0, nullptr, 0));

    EXPECT_EQ(0, ProfAPI::ProfCannPlugin::instance()->ProfStop(0, nullptr, 0));
    ProfAPI::ProfCannPlugin::instance()->profStop_ = ProfStopFuncStub;
    EXPECT_EQ(0, ProfAPI::ProfCannPlugin::instance()->ProfStop(0, nullptr, 0));
}
