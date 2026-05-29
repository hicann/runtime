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
#include "validation/param_validation.h"
#include "mdc_lite_v2_platform.h"

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

TEST_F(PLATFORM_UTEST, NtsFeatureNotSupportedOnNonMdcV2) {
    auto platform = Platform::instance();
    EXPECT_EQ(PROFILING_SUCCESS, platform->Uninit());
    MOCKER_CPP(&ConfigManager::GetPlatformType)
        .stubs()
        .will(returnValue(PlatformType::CHIP_V4_1_0));
    EXPECT_EQ(PROFILING_SUCCESS, platform->Init());
    EXPECT_EQ(false, platform->CheckIfSupport(PLATFORM_TASK_NTS));
}

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
    EXPECT_EQ(static_cast<int32_t>(ACL_PROF_NTS_METRICS) + 1, static_cast<int32_t>(ACL_PROF_ARGS_MAX));

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
}