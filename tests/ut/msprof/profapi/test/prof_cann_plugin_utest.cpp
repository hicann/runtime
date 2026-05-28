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
#include "prof_cann_plugin.h"
#include "prof_runtime_plugin.h"
#include "errno/error_code.h"

using namespace ProfAPI;
using namespace analysis::dvvp::common::error;

namespace {

int g_atlsReportApi = 0;
int g_atlsReportEvent = 0;
int g_atlsReportCompact = 0;
int g_atlsReportAdditional = 0;
int g_atlsReportRegType = 0;
int g_atlsHashIdCalled = 0;
int g_atlsHostFreqCalled = 0;
int g_atlsSetDeviceCalled = 0;

int32_t StubAtlsReportApi(uint32_t, const MsprofApi*) { ++g_atlsReportApi; return 0; }
int32_t StubAtlsReportEvent(uint32_t, const MsprofEvent*) { ++g_atlsReportEvent; return 0; }
int32_t StubAtlsReportCompact(uint32_t, const VOID_PTR, uint32_t) { ++g_atlsReportCompact; return 0; }
int32_t StubAtlsReportAdditional(uint32_t, const VOID_PTR, uint32_t) { ++g_atlsReportAdditional; return 0; }
int32_t StubAtlsReportRegType(uint16_t, uint32_t, const char*, size_t) { ++g_atlsReportRegType; return 0; }
uint64_t StubAtlsGetHashId(const char*, size_t) { ++g_atlsHashIdCalled; return 0xABCDEF12U; }
int8_t StubAtlsHostFreq() { ++g_atlsHostFreqCalled; return 1; }
int32_t StubAtlsSetDevice(VOID_PTR, uint32_t) { ++g_atlsSetDeviceCalled; return 0; }

int32_t StubProfReportRegDataFormat(uint16_t, uint32_t, const std::string&) { return 7; }
std::string StubProfReportGetHashInfo(uint64_t) { return "stub-hash-info"; }
std::string StubProfGetPath() { return "/var/tmp/prof"; }
bool StubProfHostFreqIsEnable() { return true; }
int32_t StubProfGetFeatureIsOn(uint64_t) { return 1; }
int32_t StubProfSubscribeRawData(MsprofRawDataCallback) { return 0; }
int32_t StubProfUnSubscribeRawData() { return 0; }
int32_t StubProfSetCommand(VOID_PTR, uint32_t) { return 0; }
int32_t StubProfNotifySetDevice(uint32_t, uint32_t, bool) { return 0; }
void* StubProfBatchAddBufPop(const ProfBatchAddBufPopCallback) { return nullptr; }
void StubProfBatchAddBufIndexShift(const ProfBatchAddBufIndexShiftCallBack) {}

void ResetAtlsCounters()
{
    g_atlsReportApi = 0;
    g_atlsReportEvent = 0;
    g_atlsReportCompact = 0;
    g_atlsReportAdditional = 0;
    g_atlsReportRegType = 0;
    g_atlsHashIdCalled = 0;
    g_atlsHostFreqCalled = 0;
    g_atlsSetDeviceCalled = 0;
}

void ClearAtlsHooks()
{
    auto plugin = ProfCannPlugin::instance();
    plugin->atlsReportApi_ = nullptr;
    plugin->atlsReportEvent_ = nullptr;
    plugin->atlsReportCompactInfo_ = nullptr;
    plugin->atlsReportAdditionalInfo_ = nullptr;
    plugin->atlsReportRegTypeInfo_ = nullptr;
    plugin->atlsReportGetHashId_ = nullptr;
    plugin->atlsHostFreqIsEnable_ = nullptr;
    plugin->atlsSetDevice_ = nullptr;
}

void ClearProfHooks()
{
    auto plugin = ProfCannPlugin::instance();
    plugin->profReportRegDataFormat_ = nullptr;
    plugin->profReportGetHashInfo_ = nullptr;
    plugin->profGetPath_ = nullptr;
    plugin->profHostFreqIsEnable_ = nullptr;
    plugin->profGetFeatureIsOn_ = nullptr;
    plugin->profSubscribeRawData_ = nullptr;
    plugin->profUnSubscribeRawData_ = nullptr;
    plugin->profSetProfCommand_ = nullptr;
    plugin->profNotifySetDevice_ = nullptr;
    plugin->profBatchAddBufPop_ = nullptr;
    plugin->profBatchAddBufIndexShift_ = nullptr;
}

}  // namespace

class PROF_CANN_PLUGIN_UTEST : public testing::Test {
protected:
    virtual void SetUp()
    {
        ResetAtlsCounters();
        ClearAtlsHooks();
        ClearProfHooks();
    }
    virtual void TearDown()
    {
        ClearAtlsHooks();
        ClearProfHooks();
        GlobalMockObject::verify();
    }
};

TEST_F(PROF_CANN_PLUGIN_UTEST, ProfReportRegDataFormat_Variants)
{
    auto plugin = ProfCannPlugin::instance();
    EXPECT_EQ(0, plugin->ProfReportRegDataFormat(0, 1, "fmt", 3));
    plugin->profReportRegDataFormat_ = StubProfReportRegDataFormat;
    EXPECT_EQ(7, plugin->ProfReportRegDataFormat(0, 1, "fmt", 3));
}

TEST_F(PROF_CANN_PLUGIN_UTEST, ProfReportGetHashInfo_Variants)
{
    auto plugin = ProfCannPlugin::instance();
    char *p = plugin->ProfReportGetHashInfo(123);
    EXPECT_NE(nullptr, p);
    plugin->profReportGetHashInfo_ = StubProfReportGetHashInfo;
    p = plugin->ProfReportGetHashInfo(456);
    EXPECT_STREQ("stub-hash-info", p);
}

TEST_F(PROF_CANN_PLUGIN_UTEST, ProfGetPath_Variants)
{
    auto plugin = ProfCannPlugin::instance();
    char *p = plugin->profGetPath();
    EXPECT_NE(nullptr, p);
    plugin->profGetPath_ = StubProfGetPath;
    p = plugin->profGetPath();
    EXPECT_STREQ("/var/tmp/prof", p);
}

TEST_F(PROF_CANN_PLUGIN_UTEST, ProfHostFreqIsEnable_Branches)
{
    auto plugin = ProfCannPlugin::instance();
    EXPECT_FALSE(plugin->ProfHostFreqIsEnable());
    plugin->profHostFreqIsEnable_ = StubProfHostFreqIsEnable;
    EXPECT_TRUE(plugin->ProfHostFreqIsEnable());
    plugin->atlsHostFreqIsEnable_ = StubAtlsHostFreq;
    EXPECT_TRUE(plugin->ProfHostFreqIsEnable());
    EXPECT_GE(g_atlsHostFreqCalled, 1);
}

TEST_F(PROF_CANN_PLUGIN_UTEST, ProfReportGetHashId_AtlsAndCb)
{
    auto plugin = ProfCannPlugin::instance();
    plugin->atlsReportGetHashId_ = StubAtlsGetHashId;
    EXPECT_EQ(0xABCDEF12ULL, plugin->ProfReportGetHashId("aa", 2));
    EXPECT_GE(g_atlsHashIdCalled, 1);
}

TEST_F(PROF_CANN_PLUGIN_UTEST, ProfReportApi_AtlsHook)
{
    auto plugin = ProfCannPlugin::instance();
    plugin->atlsReportApi_ = StubAtlsReportApi;
    MsprofApi api{};
    EXPECT_EQ(0, plugin->ProfReportApi(0, &api));
    EXPECT_EQ(1, g_atlsReportApi);
}

TEST_F(PROF_CANN_PLUGIN_UTEST, ProfReportEvent_AtlsHook)
{
    auto plugin = ProfCannPlugin::instance();
    plugin->atlsReportEvent_ = StubAtlsReportEvent;
    MsprofEvent ev{};
    EXPECT_EQ(0, plugin->ProfReportEvent(0, &ev));
    EXPECT_EQ(1, g_atlsReportEvent);
}

TEST_F(PROF_CANN_PLUGIN_UTEST, ProfReportCompactInfo_AtlsHook)
{
    auto plugin = ProfCannPlugin::instance();
    plugin->atlsReportCompactInfo_ = StubAtlsReportCompact;
    MsprofCompactInfo info{};
    EXPECT_EQ(0, plugin->ProfReportCompactInfo(0, &info, sizeof(info)));
    EXPECT_EQ(1, g_atlsReportCompact);
}

TEST_F(PROF_CANN_PLUGIN_UTEST, ProfReportAdditionalInfo_AtlsHook)
{
    auto plugin = ProfCannPlugin::instance();
    plugin->atlsReportAdditionalInfo_ = StubAtlsReportAdditional;
    MsprofAdditionalInfo info{};
    EXPECT_EQ(0, plugin->ProfReportAdditionalInfo(0, &info, sizeof(info)));
    EXPECT_EQ(1, g_atlsReportAdditional);
}

TEST_F(PROF_CANN_PLUGIN_UTEST, ProfReportAdditionalInfo_LengthBoundary)
{
    auto plugin = ProfCannPlugin::instance();
    char buf[STANDARD_ADDITIONAL_INFO_LENGTH + 16] = {0};
    EXPECT_EQ(PROFILING_FAILED, plugin->ProfReportAdditionalInfo(0, buf, MAX_VARIABLE_DATA_LENGTH + 1));
    plugin->variableAdditionalBuffer_.Init("variable");
    EXPECT_EQ(0, plugin->ProfReportAdditionalInfo(0, buf, STANDARD_ADDITIONAL_INFO_LENGTH + 16));
    plugin->variableAdditionalBuffer_.UnInit();
}

TEST_F(PROF_CANN_PLUGIN_UTEST, ProfReportRegTypeInfo_AtlsHook)
{
    auto plugin = ProfCannPlugin::instance();
    plugin->atlsReportRegTypeInfo_ = StubAtlsReportRegType;
    EXPECT_EQ(0, plugin->ProfReportRegTypeInfo(0, 1, "type", 4));
    EXPECT_EQ(1, g_atlsReportRegType);
}

TEST_F(PROF_CANN_PLUGIN_UTEST, RegisterProfileCallback_AtlsTypes)
{
    auto plugin = ProfCannPlugin::instance();
    EXPECT_EQ(PROFILING_SUCCESS, plugin->RegisterProfileCallback(PROFILE_CTRL_CALLBACK, nullptr, 0));
    EXPECT_EQ(PROFILING_SUCCESS, plugin->RegisterProfileCallback(PROFILE_DEVICE_STATE_CALLBACK, nullptr, 0));
    EXPECT_EQ(PROFILING_SUCCESS, plugin->RegisterProfileCallback(PROFILE_REPORT_API_CALLBACK, nullptr, 0));
    EXPECT_EQ(PROFILING_SUCCESS, plugin->RegisterProfileCallback(PROFILE_REPORT_EVENT_CALLBACK, nullptr, 0));
    EXPECT_EQ(PROFILING_SUCCESS, plugin->RegisterProfileCallback(PROFILE_REPORT_REG_TYPE_INFO_CALLBACK, nullptr, 0));
    EXPECT_EQ(PROFILING_SUCCESS, plugin->RegisterProfileCallback(PROFILE_REPORT_REG_DATA_FORMAT_CALLBACK, nullptr, 0));
    EXPECT_EQ(PROFILING_SUCCESS, plugin->RegisterProfileCallback(PROFILE_REPORT_GET_HASH_ID_CALLBACK, nullptr, 0));
    EXPECT_EQ(PROFILING_SUCCESS, plugin->RegisterProfileCallback(PROFILE_HOST_FREQ_IS_ENABLE_CALLBACK, nullptr, 0));
    EXPECT_EQ(PROFILING_SUCCESS, plugin->RegisterProfileCallback(PROFILE_REPORT_COMPACT_CALLBACK,
        reinterpret_cast<VOID_PTR>(StubAtlsReportCompact), 0));
    EXPECT_EQ(PROFILING_SUCCESS, plugin->RegisterProfileCallback(PROFILE_REPORT_ADDITIONAL_CALLBACK,
        reinterpret_cast<VOID_PTR>(StubAtlsReportAdditional), 0));
}

TEST_F(PROF_CANN_PLUGIN_UTEST, RegisterProfileCallback_AtlsForkCases)
{
    auto plugin = ProfCannPlugin::instance();
    EXPECT_EQ(PROFILING_SUCCESS, plugin->RegisterProfileCallback(PROFILE_REPORT_API_C_CALLBACK,
        reinterpret_cast<VOID_PTR>(StubAtlsReportApi), 0));
    EXPECT_EQ(PROFILING_SUCCESS, plugin->RegisterProfileCallback(PROFILE_REPORT_EVENT_C_CALLBACK,
        reinterpret_cast<VOID_PTR>(StubAtlsReportEvent), 0));
    EXPECT_EQ(PROFILING_SUCCESS, plugin->RegisterProfileCallback(PROFILE_REPORT_REG_TYPE_INFO_C_CALLBACK,
        reinterpret_cast<VOID_PTR>(StubAtlsReportRegType), 0));
    EXPECT_EQ(PROFILING_SUCCESS, plugin->RegisterProfileCallback(PROFILE_REPORT_REG_DATA_FORMAT_C_CALLBACK,
        nullptr, 0));
    EXPECT_EQ(PROFILING_SUCCESS, plugin->RegisterProfileCallback(PROFILE_REPORT_GET_HASH_ID_C_CALLBACK,
        reinterpret_cast<VOID_PTR>(StubAtlsGetHashId), 0));
    EXPECT_EQ(PROFILING_SUCCESS, plugin->RegisterProfileCallback(PROFILE_HOST_FREQ_IS_ENABLE_C_CALLBACK,
        reinterpret_cast<VOID_PTR>(StubAtlsHostFreq), 0));
    EXPECT_EQ(PROFILING_SUCCESS, plugin->RegisterProfileCallback(PROFILE_DEVICE_STATE_C_CALLBACK,
        reinterpret_cast<VOID_PTR>(StubAtlsSetDevice), 0));
    EXPECT_EQ(PROFILING_FAILED, plugin->RegisterProfileCallback(0xFFFF, nullptr, 0));
}

TEST_F(PROF_CANN_PLUGIN_UTEST, ProfNotifyCachedDevice_WithSetDevice)
{
    auto plugin = ProfCannPlugin::instance();
    plugin->ProfNotifySetDevice(1, 2, true);
    plugin->atlsSetDevice_ = StubAtlsSetDevice;
    plugin->ProfNotifyCachedDevice();
    EXPECT_GE(g_atlsSetDeviceCalled, 1);
}

TEST_F(PROF_CANN_PLUGIN_UTEST, ProfNotifyCachedDevice_NullCallback)
{
    auto plugin = ProfCannPlugin::instance();
    plugin->atlsSetDevice_ = nullptr;
    plugin->ProfNotifyCachedDevice();
    EXPECT_EQ(0, g_atlsSetDeviceCalled);
}

TEST_F(PROF_CANN_PLUGIN_UTEST, ProfNotifySetDevice_AtlsBranch)
{
    auto plugin = ProfCannPlugin::instance();
    plugin->atlsSetDevice_ = StubAtlsSetDevice;
    EXPECT_EQ(0, plugin->ProfNotifySetDevice(3, 4, true));
    EXPECT_GE(g_atlsSetDeviceCalled, 1);
}

TEST_F(PROF_CANN_PLUGIN_UTEST, ProfNotifySetDevice_NotifyCallback)
{
    auto plugin = ProfCannPlugin::instance();
    plugin->profNotifySetDevice_ = StubProfNotifySetDevice;
    EXPECT_EQ(0, plugin->ProfNotifySetDevice(5, 6, false));
}

TEST_F(PROF_CANN_PLUGIN_UTEST, ProfSetStepInfo_RuntimeInitFail)
{
    auto plugin = ProfCannPlugin::instance();
    MOCKER_CPP(&ProfRuntimePlugin::RuntimeApiInit).stubs().will(returnValue((int32_t)PROFILING_FAILED));
    EXPECT_EQ(PROFILING_FAILED, plugin->ProfSetStepInfo(1, 2, nullptr));
}

TEST_F(PROF_CANN_PLUGIN_UTEST, ProfSetStepInfo_MarkExFail)
{
    auto plugin = ProfCannPlugin::instance();
    MOCKER_CPP(&ProfRuntimePlugin::RuntimeApiInit).stubs().will(returnValue((int32_t)PROFILING_SUCCESS));
    MOCKER_CPP(&ProfRuntimePlugin::ProfMarkEx).stubs().will(returnValue((int32_t)1));
    EXPECT_EQ(1, plugin->ProfSetStepInfo(1, 2, nullptr));
}

TEST_F(PROF_CANN_PLUGIN_UTEST, ProfSetStepInfo_Success)
{
    auto plugin = ProfCannPlugin::instance();
    MOCKER_CPP(&ProfRuntimePlugin::RuntimeApiInit).stubs().will(returnValue((int32_t)PROFILING_SUCCESS));
    MOCKER_CPP(&ProfRuntimePlugin::ProfMarkEx).stubs().will(returnValue((int32_t)RT_ERROR_NONE));
    EXPECT_EQ(PROFILING_SUCCESS, plugin->ProfSetStepInfo(1, 2, nullptr));
}

TEST_F(PROF_CANN_PLUGIN_UTEST, BuildApiInfo_FillsFields)
{
    auto plugin = ProfCannPlugin::instance();
    MsprofApi api{};
    plugin->BuildApiInfo({100ULL, 200ULL}, 99, 7ULL, api);
    EXPECT_EQ(7ULL, api.itemId);
    EXPECT_EQ(100ULL, api.beginTime);
    EXPECT_EQ(200ULL, api.endTime);
    EXPECT_EQ(99u, api.type);
    EXPECT_EQ(MSPROF_REPORT_NODE_LEVEL, api.level);
}

TEST_F(PROF_CANN_PLUGIN_UTEST, ReportApiInfo_Path)
{
    auto plugin = ProfCannPlugin::instance();
    plugin->ProfInitReportBuf(MSPROF_CTRL_INIT_ACL_ENV);
    EXPECT_EQ(PROFILING_SUCCESS, plugin->ReportApiInfo(1, 2, 3, 4));
    plugin->ProfUnInitReportBuf();
}

TEST_F(PROF_CANN_PLUGIN_UTEST, AdprofFeature_And_RawData)
{
    auto plugin = ProfCannPlugin::instance();
    EXPECT_EQ(0, plugin->ProfAdprofCheckFeatureIsOn(1));
    plugin->profGetFeatureIsOn_ = StubProfGetFeatureIsOn;
    EXPECT_EQ(1, plugin->ProfAdprofCheckFeatureIsOn(1));

    EXPECT_EQ(0, plugin->ProfSubscribeRawData(nullptr));
    plugin->profSubscribeRawData_ = StubProfSubscribeRawData;
    EXPECT_EQ(0, plugin->ProfSubscribeRawData(nullptr));

    EXPECT_EQ(0, plugin->ProfUnSubscribeRawData());
    plugin->profUnSubscribeRawData_ = StubProfUnSubscribeRawData;
    EXPECT_EQ(0, plugin->ProfUnSubscribeRawData());
}

TEST_F(PROF_CANN_PLUGIN_UTEST, BatchReport_PopAndIndexShift)
{
    auto plugin = ProfCannPlugin::instance();
    plugin->ProfInitDevReportBuf();
    MsprofAdditionalInfo info{};
    EXPECT_EQ(0, plugin->ProfReportBatchAdditionalInfo(0, &info, sizeof(info)));
    EXPECT_EQ(static_cast<size_t>(131072), plugin->ProfGetBatchReportMaxSize(MSPROF_BATCH_ADDITIONAL_INFO));
    EXPECT_EQ(static_cast<size_t>(0), plugin->ProfGetBatchReportMaxSize(0xFFFF));
    size_t popSize = 0;
    void *ptr = TryPopAdprofBuf(popSize, true);
    if (ptr != nullptr) {
        TryIndexShiftAdprofBuf(ptr, popSize);
    }
    plugin->profBatchAddBufPop_ = StubProfBatchAddBufPop;
    plugin->profBatchAddBufIndexShift_ = StubProfBatchAddBufIndexShift;
    plugin->ProfRegisterFunc(REPORT_ADPROF_POP, reinterpret_cast<VOID_PTR>(TryPopAdprofBuf));
    plugin->ProfRegisterFunc(REPORT_ADPROF_INDEX_SHIFT, reinterpret_cast<VOID_PTR>(TryIndexShiftAdprofBuf));
}

TEST_F(PROF_CANN_PLUGIN_UTEST, VariableAdditional_PopAndIndexShift)
{
    auto plugin = ProfCannPlugin::instance();
    plugin->ProfInitReportBuf(MSPROF_CTRL_INIT_ACL_ENV);
    size_t popSize = 0;
    void *ptr = TryPopVariableAdditionalBuf(popSize);
    if (ptr != nullptr) {
        TryIndexShiftVariableAddBuf(ptr, popSize);
    }
    plugin->ProfUnInitReportBuf();
}

TEST_F(PROF_CANN_PLUGIN_UTEST, ProfRegisterFunc_AllBranches)
{
    auto plugin = ProfCannPlugin::instance();
    plugin->ProfRegisterFunc(0xDEADBEEF, nullptr);
    plugin->ProfRegisterFunc(REPORT_VARIABLE_ADDITIONAL_POP,
        reinterpret_cast<VOID_PTR>(TryPopVariableAdditionalBuf));
    plugin->ProfRegisterFunc(REPORT_VARIABLE_ADDITIONAL_INDEX_SHIFT,
        reinterpret_cast<VOID_PTR>(TryIndexShiftVariableAddBuf));
}

TEST_F(PROF_CANN_PLUGIN_UTEST, ProfSetProfCommand_NullAndCb)
{
    auto plugin = ProfCannPlugin::instance();
    EXPECT_EQ(PROFILING_FAILED, plugin->ProfSetProfCommand(nullptr, 0));
    plugin->profSetProfCommand_ = StubProfSetCommand;
    EXPECT_EQ(0, plugin->ProfSetProfCommand(nullptr, 0));
}

TEST_F(PROF_CANN_PLUGIN_UTEST, ProfCheckCommandLine_NoEnv)
{
    auto plugin = ProfCannPlugin::instance();
    (void)plugin->ProfCheckCommandLine();
}
