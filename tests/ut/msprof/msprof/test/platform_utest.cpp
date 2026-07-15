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
#include "acl/acl_prof.h"
#include "config_manager.h"
#include "errno/error_code.h"
#include "message/prof_params.h"
#include "msprofiler_acl_api.h"
#include "platform/platform.h"
#include "prof_acl_mgr.h"
#include "prof_params_adapter.h"
#include "msprofiler_impl.h"
#include "osal.h"
#include "validation/param_validation.h"
#include "cloud_v2_platform.h"
#include "david_platform.h"
#include "david_v121_platform.h"
#include "mdc_lite_v2_platform.h"
#include "mdc_v2_platform.h"
#include "error_manager_stub2.h"

using namespace Analysis::Dvvp::Common::Platform;
using namespace Analysis::Dvvp::Common::Config;
using namespace analysis::dvvp::common::error;
using namespace analysis::dvvp::common::validation;
using namespace Dvvp::Collect::Platform;

namespace {
class PLATFORM_UTEST: public testing::Test {
protected:
    void SetUp() override {
    }
    void TearDown() override {
        Msprofiler::Api::ProfAclMgr::instance()->SetModeToOff();
        Msprofiler::Api::ProfAclMgr::instance()->params_ = nullptr;
        Platform::instance()->Uninit();
        GlobalMockObject::verify();
    }
};

TEST_F(PLATFORM_UTEST, Init) {
    GlobalMockObject::verify();
    auto platform = std::make_shared<Platform>();

    EXPECT_EQ(PROFILING_SUCCESS, platform->Init());
}

TEST_F(PLATFORM_UTEST, Uninit) {
    GlobalMockObject::verify();
    auto platform = std::make_shared<Platform>();

    EXPECT_EQ(PROFILING_SUCCESS, platform->Uninit());
}

TEST_F(PLATFORM_UTEST, PlatformIsRpcSide) {
    GlobalMockObject::verify();
    auto platform = std::make_shared<Platform>();

    EXPECT_EQ(false, platform->PlatformIsRpcSide());
}

TEST_F(PLATFORM_UTEST, GetPlatform) {
    GlobalMockObject::verify();
    auto platform = std::make_shared<Platform>();

    EXPECT_EQ(SysPlatformType::INVALID, platform->GetPlatform());
}

#ifndef BUILD_PROFILING_OPEN_PROJECT
TEST_F(PLATFORM_UTEST, NtsFeatureSupportedOnMdcV2) {
    auto platform = Platform::instance();
    EXPECT_EQ(PROFILING_SUCCESS, platform->Uninit());
    MOCKER_CPP(&ConfigManager::GetPlatformType)
        .stubs()
        .will(returnValue(PlatformType::CHIP_MDC_V2));
    EXPECT_EQ(PROFILING_SUCCESS, platform->Init());
    EXPECT_EQ(true, platform->CheckIfSupport(PLATFORM_TASK_NTS));
    EXPECT_EQ("0x301,0x312,0x315,0x316,0x32e,0x701,0x202,0x203,0x1,0x35",
        platform->GetNtsEvents("PipeUtilization"));
}
#endif

TEST_F(PLATFORM_UTEST, NtsFeatureNotSupportedOnNonMdcV2) {
    auto platform = Platform::instance();
    EXPECT_EQ(PROFILING_SUCCESS, platform->Uninit());
    MOCKER_CPP(&ConfigManager::GetPlatformType)
        .stubs()
        .will(returnValue(PlatformType::CHIP_V4_1_0));
    EXPECT_EQ(PROFILING_SUCCESS, platform->Init());
    EXPECT_EQ(false, platform->CheckIfSupport(PLATFORM_TASK_NTS));
}

#ifndef BUILD_PROFILING_OPEN_PROJECT
TEST_F(PLATFORM_UTEST, NtsMetricsParamValidationExpandsDefaultEvents) {
    auto platform = Platform::instance();
    EXPECT_EQ(PROFILING_SUCCESS, platform->Uninit());
    MOCKER_CPP(&ConfigManager::GetPlatformType)
        .stubs()
        .will(returnValue(PlatformType::CHIP_MDC_V2));
    EXPECT_EQ(PROFILING_SUCCESS, platform->Init());

    auto params = std::make_shared<analysis::dvvp::message::ProfileParams>();
    params->devices = "all";
    params->ntsMetrics = "PipeUtilization";

    EXPECT_EQ(true, ParamValidation::instance()->CheckProfilingParams(params));
    EXPECT_EQ("0x301,0x312,0x315,0x316,0x32e,0x701,0x202,0x203,0x1,0x35",
        params->ntsPmuEvents);
}
#endif

TEST_F(PLATFORM_UTEST, NtsMetricsParamValidationRejectsUnsupportedPlatform) {
    auto platform = Platform::instance();
    EXPECT_EQ(PROFILING_SUCCESS, platform->Uninit());
    MOCKER_CPP(&ConfigManager::GetPlatformType)
        .stubs()
        .will(returnValue(PlatformType::CHIP_V4_1_0));
    EXPECT_EQ(PROFILING_SUCCESS, platform->Init());

    auto params = std::make_shared<analysis::dvvp::message::ProfileParams>();
    params->devices = "all";
    params->ntsMetrics = "PipeUtilization";

    EXPECT_EQ(false, ParamValidation::instance()->CheckProfilingParams(params));
    EXPECT_TRUE(params->ntsPmuEvents.empty());
}

TEST_F(PLATFORM_UTEST, NtsMetricsReturnsEmptyBeforePlatformInit) {
    auto platform = Platform::instance();
    EXPECT_EQ(PROFILING_SUCCESS, platform->Uninit());

    EXPECT_EQ("", platform->GetNtsEvents("PipeUtilization"));
}

TEST_F(PLATFORM_UTEST, DefaultPlatformInterfaceNtsMetricsIsEmpty) {
    Dvvp::Collect::Platform::PlatformInterface platformInterface;

    EXPECT_EQ("", platformInterface.GetNtsEvents("PipeUtilization"));
}

TEST_F(PLATFORM_UTEST, NtsMetricsValidationAcceptsNullAndEmptyParams) {
    EXPECT_EQ(true, ParamValidation::instance()->CheckNtsMetricsIsValid(nullptr));

    auto params = std::make_shared<analysis::dvvp::message::ProfileParams>();
    EXPECT_EQ(true, ParamValidation::instance()->CheckNtsMetricsIsValid(params));
}

TEST_F(PLATFORM_UTEST, NtsMetricsValidationRejectsEmptyDefaultEvents) {
    auto params = std::make_shared<analysis::dvvp::message::ProfileParams>();
    params->ntsMetrics = "PipeUtilization";

    MOCKER_CPP(&Platform::CheckIfSupport, bool (Platform::*)(const PlatformFeature) const)
        .stubs()
        .will(returnValue(true));
    MOCKER_CPP(&Platform::GetNtsEvents)
        .stubs()
        .will(returnValue(std::string()));

    EXPECT_EQ(false, ParamValidation::instance()->CheckNtsMetricsIsValid(params));
}

TEST_F(PLATFORM_UTEST, NtsMetricsValidationAcceptsCustomEventsAndRejectsInvalidInput) {
    MOCKER_CPP(&Platform::CheckIfSupport, bool (Platform::*)(const PlatformFeature) const)
        .stubs()
        .will(returnValue(true));

    auto params = std::make_shared<analysis::dvvp::message::ProfileParams>();
    params->ntsMetrics = "Custom:0x301,0x312";
    params->ntsPmuEvents = "0x301,0x312";
    EXPECT_EQ(true, ParamValidation::instance()->CheckNtsMetricsIsValid(params));

    params->ntsMetrics = "TaskTime";
    params->ntsPmuEvents.clear();
    EXPECT_EQ(false, ParamValidation::instance()->CheckNtsMetricsIsValid(params));
}

TEST_F(PLATFORM_UTEST, AclprofSetConfigRejectsInvalidNtsMetricsArgs) {
    EXPECT_EQ(static_cast<int32_t>(ACL_PROF_OPTYPE) + 1, static_cast<int32_t>(ACL_PROF_NTS_METRICS));
    EXPECT_EQ(static_cast<int32_t>(ACL_PROF_NTS_METRICS) + 1, static_cast<int32_t>(ACL_PROF_PATH));
    EXPECT_EQ(static_cast<int32_t>(ACL_PROF_PATH) + 1, static_cast<int32_t>(ACL_PROF_ARGS_MAX));

    std::string config("PipeUtilization");
    EXPECT_EQ(ACL_ERROR_INVALID_PARAM, aclprofSetConfig(ACL_PROF_NTS_METRICS, config.c_str(), 0));

    config = "TaskTime";
    EXPECT_EQ(ACL_ERROR_INVALID_PARAM, aclprofSetConfig(ACL_PROF_NTS_METRICS, config.c_str(), config.size()));
}

TEST_F(PLATFORM_UTEST, ProfParamsAdapterValidatesNtsMetrics) {
    auto params = std::make_shared<analysis::dvvp::message::ProfileParams>();

    EXPECT_EQ(PROFILING_SUCCESS,
        Analysis::Dvvp::Host::Adapter::ProfParamsAdapter::instance()->CheckApiConfigSupport(ACL_PROF_NTS_METRICS));
    EXPECT_EQ(PROFILING_SUCCESS,
        Analysis::Dvvp::Host::Adapter::ProfParamsAdapter::instance()->CheckApiConfigIsValid(params,
            ACL_PROF_NTS_METRICS, "PipeUtilization"));
    EXPECT_EQ("PipeUtilization", params->ntsMetrics);

    params->ntsMetrics.clear();
    EXPECT_EQ(PROFILING_SUCCESS,
        Analysis::Dvvp::Host::Adapter::ProfParamsAdapter::instance()->CheckApiConfigIsValid(params,
            ACL_PROF_NTS_METRICS, "Custom:0x301"));
    EXPECT_EQ("Custom:0x301", params->ntsMetrics);
    EXPECT_EQ("0x301", params->ntsPmuEvents);

    params->ntsMetrics.clear();
    params->ntsPmuEvents.clear();
    EXPECT_EQ(PROFILING_FAILED,
        Analysis::Dvvp::Host::Adapter::ProfParamsAdapter::instance()->CheckApiConfigIsValid(params,
            ACL_PROF_NTS_METRICS, "TaskTime"));
    EXPECT_TRUE(params->ntsMetrics.empty());
    EXPECT_TRUE(params->ntsPmuEvents.empty());
}

TEST_F(PLATFORM_UTEST, ProfParamsAdapterValidatesNtsMetricsJsonConfig) {
    NanoJson::Json jsonCfg;
    jsonCfg["nts_metrics"] = "PipeUtilization";
    auto params = std::make_shared<analysis::dvvp::message::ProfileParams>();

    EXPECT_EQ(Msprofiler::Api::ACLJSON_CONFIG_VECTOR.end(),
        std::find(Msprofiler::Api::ACLJSON_CONFIG_VECTOR.begin(),
            Msprofiler::Api::ACLJSON_CONFIG_VECTOR.end(), "nts_metrics"));
    EXPECT_EQ(Msprofiler::Api::GEOPTION_CONFIG_VECTOR.end(),
        std::find(Msprofiler::Api::GEOPTION_CONFIG_VECTOR.begin(),
            Msprofiler::Api::GEOPTION_CONFIG_VECTOR.end(), "nts_metrics"));
    EXPECT_EQ(MSPROF_ERROR_CONFIG_INVALID,
        Msprofiler::Api::ProfAclMgr::instance()->CheckAclJsonConfigInvalid(jsonCfg));
    EXPECT_EQ(MSPROF_ERROR_CONFIG_INVALID,
        Msprofiler::Api::ProfAclMgr::instance()->CheckGeOptionConfigInvalid(jsonCfg));
    EXPECT_FALSE(Analysis::Dvvp::Host::Adapter::ProfParamsAdapter::instance()->CheckJsonConfig(
        "nts_metrics", jsonCfg["nts_metrics"]));
    EXPECT_EQ(PROFILING_SUCCESS,
        Analysis::Dvvp::Host::Adapter::ProfParamsAdapter::instance()->HandleJsonConf(jsonCfg, params));
    EXPECT_TRUE(params->ntsMetrics.empty());
    EXPECT_TRUE(params->ntsPmuEvents.empty());

    jsonCfg["nts_metrics"] = "Custom:0x301,0x312";
    EXPECT_FALSE(Analysis::Dvvp::Host::Adapter::ProfParamsAdapter::instance()->CheckJsonConfig(
        "nts_metrics", jsonCfg["nts_metrics"]));
    EXPECT_EQ(PROFILING_SUCCESS,
        Analysis::Dvvp::Host::Adapter::ProfParamsAdapter::instance()->HandleJsonConf(jsonCfg, params));
    EXPECT_TRUE(params->ntsMetrics.empty());
    EXPECT_TRUE(params->ntsPmuEvents.empty());

    jsonCfg["nts_metrics"] = "TaskTime";
    EXPECT_FALSE(Analysis::Dvvp::Host::Adapter::ProfParamsAdapter::instance()->CheckJsonConfig(
        "nts_metrics", jsonCfg["nts_metrics"]));
}

TEST_F(PLATFORM_UTEST, CheckAclJsonConfigInvalidReportsConfigErrorForInvalidAicpu)
{
    NanoJson::Json jsonCfg;
    jsonCfg["switch"] = "on";
    jsonCfg["output"] = "prof_path";
    jsonCfg["aicpu"] = "test";
    MOCKER_CPP(&Platform::CheckIfSupport, bool (Platform::*)(const std::string) const)
        .stubs()
        .will(returnValue(true));

    MsprofUtestStub::ResetMsprofLastInputErrorCode();
    EXPECT_EQ(MSPROF_ERROR_CONFIG_INVALID,
        Msprofiler::Api::ProfAclMgr::instance()->CheckAclJsonConfigInvalid(jsonCfg));
    EXPECT_EQ("EK0003", MsprofUtestStub::GetMsprofLastInputErrorCode());
}

TEST_F(PLATFORM_UTEST, CheckGeOptionConfigInvalidReportsInvalidArgumentForInvalidAicpu)
{
    NanoJson::Json jsonCfg;
    jsonCfg["output"] = "prof_path";
    jsonCfg["training_trace"] = "on";
    jsonCfg["task_trace"] = "on";
    jsonCfg["aicpu"] = "test";
    MOCKER_CPP(&Platform::CheckIfSupport, bool (Platform::*)(const std::string) const)
        .stubs()
        .will(returnValue(true));

    MsprofUtestStub::ResetMsprofLastInputErrorCode();
    EXPECT_EQ(MSPROF_ERROR_CONFIG_INVALID,
        Msprofiler::Api::ProfAclMgr::instance()->CheckGeOptionConfigInvalid(jsonCfg));
    EXPECT_EQ("EK0001", MsprofUtestStub::GetMsprofLastInputErrorCode());
}

TEST_F(PLATFORM_UTEST, ProfSetConfigReturnsInvalidParamWhenNtsMetricsRejected) {
    Msprofiler::Api::ProfAclMgr::instance()->mode_ = Msprofiler::Api::WORK_MODE_API_CTRL;
    Msprofiler::Api::ProfAclMgr::instance()->params_ =
        std::make_shared<analysis::dvvp::message::ProfileParams>();
    MOCKER(&Analysis::Dvvp::Common::Platform::Platform::PlatformIsHelperHostSide)
        .stubs()
        .will(returnValue(false));

    std::string config("TaskTime");
    EXPECT_EQ(ACL_ERROR_INVALID_PARAM,
        Msprofiler::AclApi::ProfSetConfig(ACL_PROF_NTS_METRICS, config.c_str(), config.size()));
}

TEST_F(PLATFORM_UTEST, ProfSetConfigRejectsNtsMetricsWhenPlatformUnsupported) {
    Msprofiler::Api::ProfAclMgr::instance()->mode_ = Msprofiler::Api::WORK_MODE_API_CTRL;
    Msprofiler::Api::ProfAclMgr::instance()->params_ =
        std::make_shared<analysis::dvvp::message::ProfileParams>();
    MOCKER(&Analysis::Dvvp::Common::Platform::Platform::PlatformIsHelperHostSide)
        .stubs()
        .will(returnValue(false));
    MOCKER_CPP(&Platform::CheckIfSupport, bool (Platform::*)(const PlatformFeature) const)
        .stubs()
        .will(returnValue(false));

    std::string config("PipeUtilization");
    EXPECT_EQ(ACL_ERROR_INVALID_PARAM,
        Msprofiler::AclApi::ProfSetConfig(ACL_PROF_NTS_METRICS, config.c_str(), config.size()));
}

TEST_F(PLATFORM_UTEST, ApiStatsFeatureSupportedOnCloudAndDavidPlatforms)
{
    GlobalMockObject::verify();
    CloudV2Platform cloudV2Platform;
    DavidPlatform davidPlatform;
    DavidV121Platform davidV121Platform;

    EXPECT_TRUE(cloudV2Platform.FeatureIsSupport(PLATFORM_API_STATS));
    EXPECT_TRUE(davidPlatform.FeatureIsSupport(PLATFORM_API_STATS));
    EXPECT_TRUE(davidV121Platform.FeatureIsSupport(PLATFORM_API_STATS));
}

// 通用服务器场景：libascend_hal.so dlopen 失败时，Platform::Init 不返回失败，
// 置通用服务器标记。覆盖 platform.cpp 的 dlopen 失败分支与 PlatformIsGeneralServer。
TEST_F(PLATFORM_UTEST, InitAsGeneralServerWhenHalLibUnavailable) {
    GlobalMockObject::verify();
    MOCKER(OsalDlopen).stubs().will(returnValue(static_cast<void *>(nullptr)));
    MOCKER(OsalDlerror).stubs().will(returnValue(static_cast<char *>(nullptr)));

    auto platform = std::make_shared<Platform>();
    EXPECT_EQ(PROFILING_SUCCESS, platform->Init());       // dlopen 失败不导致 Init 失败
    EXPECT_EQ(true, platform->PlatformIsGeneralServer());  // 置通用服务器标记
}

TEST_F(PLATFORM_UTEST, PlatformIsGeneralServerDefaultFalse) {
    GlobalMockObject::verify();
    auto platform = std::make_shared<Platform>();
    EXPECT_EQ(false, platform->PlatformIsGeneralServer());  // 默认非通用服务器
}

// 通用服务器场景采集选项白名单：非白名单采集开关（如 ai_core_profiling）开启时报错停止。
TEST_F(PLATFORM_UTEST, GeneralServerWhitelistRejectsDeviceOption) {
    GlobalMockObject::verify();
    MOCKER(&Analysis::Dvvp::Common::Platform::Platform::PlatformIsGeneralServer)
        .stubs()
        .will(returnValue(true));
    auto params = std::make_shared<analysis::dvvp::message::ProfileParams>();
    params->ai_core_profiling = analysis::dvvp::common::config::MSVP_PROF_ON;  // device 侧采集，非白名单
    EXPECT_EQ(MSPROF_ERROR,
        Msprofiler::Api::ProfAclMgr::instance()->CheckGeneralServerOptionWhitelist(params));
}

// 通用服务器场景采集选项白名单：仅白名单选项（acl）开启时放行。
TEST_F(PLATFORM_UTEST, GeneralServerWhitelistAllowsHostOption) {
    GlobalMockObject::verify();
    MOCKER(&Analysis::Dvvp::Common::Platform::Platform::PlatformIsGeneralServer)
        .stubs()
        .will(returnValue(true));
    auto params = std::make_shared<analysis::dvvp::message::ProfileParams>();
    params->acl = analysis::dvvp::common::config::MSVP_PROF_ON;  // host 侧 trace，白名单允许
    EXPECT_EQ(MSPROF_ERROR_NONE,
        Msprofiler::Api::ProfAclMgr::instance()->CheckGeneralServerOptionWhitelist(params));
}

// 非通用服务器场景：白名单校验直接放行（NPU 行为不变）。
TEST_F(PLATFORM_UTEST, WhitelistPassthroughWhenNotGeneralServer) {
    GlobalMockObject::verify();
    MOCKER(&Analysis::Dvvp::Common::Platform::Platform::PlatformIsGeneralServer)
        .stubs()
        .will(returnValue(false));
    auto params = std::make_shared<analysis::dvvp::message::ProfileParams>();
    params->ai_core_profiling = analysis::dvvp::common::config::MSVP_PROF_ON;  // 非白名单，但非通用服务器 -> 放行
    EXPECT_EQ(MSPROF_ERROR_NONE,
        Msprofiler::Api::ProfAclMgr::instance()->CheckGeneralServerOptionWhitelist(params));
    // params 为空指针时也应放行
    EXPECT_EQ(MSPROF_ERROR_NONE,
        Msprofiler::Api::ProfAclMgr::instance()->CheckGeneralServerOptionWhitelist(nullptr));
}

// ProfNotifySetDevice：devId 最高位为 1（通用服务器约定）时直接返回，不启动 device 采集 task。
TEST_F(PLATFORM_UTEST, ProfNotifySetDeviceSkipsWhenDevIdHighBitSet) {
    GlobalMockObject::verify();
    EXPECT_EQ(MSPROF_ERROR_NONE,
        Analysis::Dvvp::ProfilerCommon::ProfNotifySetDevice(0, 0x80000000U, true));
    EXPECT_EQ(MSPROF_ERROR_NONE,
        Analysis::Dvvp::ProfilerCommon::ProfNotifySetDevice(0, 0x80000001U, false));
}

TEST_F(PLATFORM_UTEST, L2CacheAdaptorAddsSmmuDfxForSupportedPlatform)
{
    auto platform = Platform::instance();
    EXPECT_EQ(PROFILING_SUCCESS, platform->Uninit());
    MOCKER_CPP(&ConfigManager::GetPlatformType)
        .stubs()
        .will(returnValue(PlatformType::CHIP_CLOUD_V3));
    EXPECT_EQ(PROFILING_SUCCESS, platform->Init());

    std::string l2Switch = "on";
    std::string l2Events;
    std::string npuEvents;
    platform->L2CacheAdaptor(npuEvents, l2Switch, l2Events);

    EXPECT_EQ("0x00,0x81,0x82,0x83,0x74,0x75", l2Events);
    EXPECT_EQ("HA:0x00,0x81,0x82,0x83,0x74,0x75;SMMU:0x2,0x8a,0x8b,0x8c,0x8d;SMMU_DFX:",
        npuEvents);
    EXPECT_EQ(std::string::npos, npuEvents.find("NOC:"));
}

TEST_F(PLATFORM_UTEST, L2CacheAdaptorSkipsSmmuDfxForUnsupportedPlatform)
{
    auto platform = Platform::instance();
    EXPECT_EQ(PROFILING_SUCCESS, platform->Uninit());
    MOCKER_CPP(&ConfigManager::GetPlatformType)
        .stubs()
        .will(returnValue(PlatformType::CHIP_CLOUD_V4));
    EXPECT_EQ(PROFILING_SUCCESS, platform->Init());

    std::string l2Switch = "on";
    std::string l2Events;
    std::string npuEvents;
    platform->L2CacheAdaptor(npuEvents, l2Switch, l2Events);

    EXPECT_EQ("0x00,0x88,0x89,0x8A,0x74,0x75,0x97", l2Events);
    EXPECT_EQ("HA:0x00,0x88,0x89,0x8A,0x74,0x75,0x97;SMMU:0x2,0x8a,0x8b,0x8c,0x8d",
        npuEvents);
    EXPECT_EQ(std::string::npos, npuEvents.find("SMMU_DFX:"));
    EXPECT_EQ(std::string::npos, npuEvents.find("NOC:"));
}

TEST_F(PLATFORM_UTEST, MdcLiteV2PlatformMetrics) {
    GlobalMockObject::verify();
    MdcLiteV2Platform platform;
    PlatformInterface &platformInterface = platform;
    std::string aicEvent;

    EXPECT_EQ(PROFILING_SUCCESS, platform.GetAiPmuMetrics("PipeUtilization", aicEvent));
    EXPECT_EQ("0x501,0x301,0x1,0x701,0x202,0x203,0x34,0x35,0x714", aicEvent);

    EXPECT_EQ(PROFILING_SUCCESS, platform.GetAiPmuMetrics("Memory", aicEvent));
    EXPECT_EQ("0x400,0x401,0x56f,0x571,0x570,0x572,0x707,0x709", aicEvent);

    EXPECT_EQ(PROFILING_SUCCESS, platform.GetAiPmuMetrics("MemoryL0", aicEvent));
    EXPECT_EQ("0x304,0x703,0x306,0x705,0x712,0x30a,0x308", aicEvent);

    EXPECT_EQ(PROFILING_SUCCESS, platform.GetAiPmuMetrics("MemoryUB", aicEvent));
    EXPECT_EQ("0x3,0x5,0x70c,0x206,0x204,0x571,0x572", aicEvent);

    EXPECT_EQ(PROFILING_SUCCESS, platform.GetAiPmuMetrics("ArithmeticUtilization", aicEvent));
    EXPECT_EQ("0x323,0x324", aicEvent);

    EXPECT_EQ(PROFILING_SUCCESS, platform.GetAiPmuMetrics("ResourceConflictRatio", aicEvent));
    EXPECT_EQ("0x540,0x556,0x502,0x528", aicEvent);

    EXPECT_EQ(PROFILING_SUCCESS, platform.GetAiPmuMetrics("L2Cache", aicEvent));
    EXPECT_EQ("0x424,0x425,0x426,0x42a,0x42b,0x42c", aicEvent);

    EXPECT_EQ(PROFILING_FAILED, platform.GetAiPmuMetrics("PipelineExecuteUtilization", aicEvent));
    EXPECT_EQ(PROFILING_FAILED, platform.GetAiPmuMetrics("ScalarRatio", aicEvent));
    EXPECT_EQ("0x00,0x81,0x82,0x83,0x74,0x75", platform.GetL2CacheEvents());
    EXPECT_EQ(MAX_DAVID_MONITOR_NUM, platform.GetMaxMonitorNumber());
    EXPECT_EQ(MAX_COLLECT_MONITOR_NUM, platformInterface.GetQosMonitorNumber());
}

TEST_F(PLATFORM_UTEST, MdcLiteV2PlatformFeatures) {
    GlobalMockObject::verify();
    MdcLiteV2Platform platform;

    EXPECT_EQ(true, platform.FeatureIsSupport(PLATFORM_TASK_SWITCH));
    EXPECT_EQ(true, platform.FeatureIsSupport(PLATFORM_TASK_ASCENDCL));
    EXPECT_EQ(true, platform.FeatureIsSupport(PLATFORM_TASK_RUNTIME_API));
    EXPECT_EQ(true, platform.FeatureIsSupport(PLATFORM_TASK_AICPU));
    EXPECT_EQ(true, platform.FeatureIsSupport(PLATFORM_TASK_HCCL));
    EXPECT_EQ(true, platform.FeatureIsSupport(PLATFORM_TASK_L2_CACHE_REG));
    EXPECT_EQ(true, platform.FeatureIsSupport(PLATFORM_TASK_L2_CACHE_PMU));
    EXPECT_EQ(true, platform.FeatureIsSupport(PLATFORM_TASK_BLOCK));
    EXPECT_EQ(true, platform.FeatureIsSupport(PLATFORM_TASK_INSTR_PROFILING));
    EXPECT_EQ(true, platform.FeatureIsSupport(PLATFORM_SYS_DEVICE_LOW_POWER));
    EXPECT_EQ(true, platform.FeatureIsSupport(PLATFORM_SYS_DEVICE_QOS));
    EXPECT_EQ(true, platform.FeatureIsSupport(PLATFORM_SYS_MEM_SERVICEFLOW));
    EXPECT_EQ(true, platform.FeatureIsSupport(PLATFORM_STARS_QOS));
    EXPECT_EQ(true, platform.FeatureIsSupport(PLATFORM_MC2));
    EXPECT_EQ(true, platform.FeatureIsSupport(PLATFORM_AICPU_HCCL));
    EXPECT_EQ(true, platform.FeatureIsSupport(PLATFORM_ACLAPI_SETDEVICE_ENABLE));
    EXPECT_EQ(false, platform.FeatureIsSupport(PLATFORM_TASK_FWK));
    EXPECT_EQ(false, platform.FeatureIsSupport(PLATFORM_TASK_RUNTIME));
}

TEST_F(PLATFORM_UTEST, MdcLiteV2PlatformReflection) {
    GlobalMockObject::verify();
    auto platform = PlatformReflection::CreatePlatformClass(CHIP_MDC_LITE_V2);
    ASSERT_NE(nullptr, platform);

    std::string aicEvent;
    EXPECT_EQ(PROFILING_SUCCESS, platform->GetAiPmuMetrics("L2Cache", aicEvent));
    EXPECT_EQ("0x424,0x425,0x426,0x42a,0x42b,0x42c", aicEvent);
}

TEST_F(PLATFORM_UTEST, SmmuDFXOffsetAndRegMask) {
    GlobalMockObject::verify();

    PlatformInterface platformInterface;
    EXPECT_EQ(0U, platformInterface.GetSmmuDFXOffset());
    EXPECT_EQ(0U, platformInterface.GetSmmuDFXRegMask());

    CloudV2Platform cloudV2Platform;
    EXPECT_EQ(0x0E78U, cloudV2Platform.GetSmmuDFXOffset());
    EXPECT_EQ(0x3FFFFFFFU, cloudV2Platform.GetSmmuDFXRegMask());

    DavidPlatform davidPlatform;
    EXPECT_EQ(0x0E78U, davidPlatform.GetSmmuDFXOffset());
    EXPECT_EQ(0x3FFFFFFFU, davidPlatform.GetSmmuDFXRegMask());

    auto platform = Platform::instance();
    EXPECT_EQ(PROFILING_SUCCESS, platform->Uninit());
    EXPECT_EQ(0U, platform->GetSmmuDFXOffset());
    EXPECT_EQ(0U, platform->GetSmmuDFXRegMask());
}

TEST_F(PLATFORM_UTEST, MdcV2PlatformBiuPerfChannelInfos) {
    GlobalMockObject::verify();
    MdcV2Platform platform;

    std::vector<uint32_t> groupVector = {0, 1, 2, 3, 4, 5};
    auto channelInfos = platform.GetBiuPerfChannelInfos(groupVector, static_cast<uint32_t>(groupVector.size()));

    ASSERT_EQ(4U, channelInfos.size());
    const std::vector<BiuPerfChannelInfo> expected = {
        {0, 0, 0, 11},
        {2, 0, 2, 17},
        {3, 0, 3, 20},
        {5, 0, 5, 26},
    };
    for (size_t i = 0; i < expected.size(); i++) {
        EXPECT_EQ(expected[i], channelInfos[i]);
    }
}
}
