/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include <string>
#include <memory>
#include <fstream>
#include <stdio.h>
#include <errno.h>
#include "gtest/gtest.h"
#include "mockcpp/mockcpp.hpp"
#include <google/protobuf/util/json_util.h>
#include "config/config_manager.h"
#include "singleton/singleton.h"
#include "platform_interface.h"
#include "utils/utils.h"
#include "platform.h"
#include "config/config.h"
#include "ai_drv_dev_api.h"
#include "errno/error_code.h"
#include "message/codec.h"
#include "cloud_v2_platform.h"
#include "cloud_platform.h"
#include "mdc_lite_platform.h"
#include "mdc_platform.h"
#include "tiny_v1_platform.h"
#include "dc_platform.h"
#include "mini_platform.h"
#include "validation/param_validation.h"

using namespace Analysis::Dvvp::Common::Config;
using namespace analysis::dvvp::common::error;
using namespace analysis::dvvp::common::validation;
using namespace Analysis::Dvvp::Common::Platform;
using namespace Dvvp::Collect::Platform;

class COMMON_PLATFORM_TEST: public testing::Test {
protected:
    virtual void SetUp() {
        GlobalMockObject::verify();
    }
    virtual void TearDown() {
    }
};

TEST_F(COMMON_PLATFORM_TEST, DrvGetApiVersion) {
    auto platform = Platform::instance();
    EXPECT_EQ(PROFILING_SUCCESS, platform->Init());
    EXPECT_EQ(0x071905, platform->DrvGetApiVersion());
    MOCKER(halGetAPIVersion).stubs().will(returnValue(1));
    EXPECT_EQ(0, platform->DrvGetApiVersion());
}

extern "C" drvError_t drvGetDeviceSplitMode(unsigned int dev_id, unsigned int *mode);

TEST_F(COMMON_PLATFORM_TEST, CheckIfSupportAdprof) {
    constexpr uint32_t SUPPORT_ADPROF_VERSION = 0x72316;

    auto platform = Platform::instance();
    EXPECT_EQ(PROFILING_SUCCESS, platform->Init());
    MOCKER_CPP(&Platform::DrvGetApiVersion)
        .stubs()
        .will(returnValue(SUPPORT_ADPROF_VERSION - 1))
        .then(returnValue(SUPPORT_ADPROF_VERSION));
    EXPECT_EQ(false, platform->CheckIfSupportAdprof(0));
    MOCKER_CPP(&Platform::GetPlatformType)
        .stubs()
        .will(returnValue(CHIP_CLOUD));
    uint32_t mode = 0;
    MOCKER(drvGetDeviceSplitMode)
        .stubs()
        .with(any(), outBoundP(&mode))
        .will(returnValue(1))
        .then(returnValue(DRV_ERROR_NONE));
    EXPECT_EQ(false, platform->CheckIfSupportAdprof(0));
    EXPECT_EQ(true, platform->CheckIfSupportAdprof(0));
}

TEST_F(COMMON_PLATFORM_TEST, AscendHal) {
    auto platform = Platform::instance();

    uint32_t devId = 0;
    struct esched_query_gid_output gidOut = {0};
    struct esched_query_gid_input gidIn = {0, {0}};
    struct esched_output_info outPut = {&gidOut, sizeof(struct esched_query_gid_output)};
    struct esched_input_info inPut = {&gidIn, sizeof(struct esched_query_gid_input)};
    EXPECT_EQ(0, platform->HalEschedQueryInfo(devId, QUERY_TYPE_LOCAL_GRP_ID, &inPut, &outPut));
    struct esched_grp_para grpPara = {GRP_TYPE_BIND_CP_CPU, 1, {0}, {0}};
    uint32_t grpId = 0;
    EXPECT_EQ(0, platform->HalEschedCreateGrpEx(devId, &grpPara, &grpId));
}

drvError_t halGetDeviceInfoStub(uint32_t devId, int32_t moduleType, int32_t infoType, int64_t *value) {
    if (moduleType == static_cast<int32_t>(MODULE_TYPE_SYSTEM) &&
        (infoType == static_cast<int32_t>(INFO_TYPE_DEV_OSC_FREQUE) ||
        infoType == static_cast<int32_t>(INFO_TYPE_HOST_OSC_FREQUE))) {
        *value = 1000;
    } else {
        *value = 1000; // 2500 >> 8 = 9  nano type
    }
    return DRV_ERROR_NONE;
}

TEST_F(COMMON_PLATFORM_TEST, PlatformInterfaceTest) {
    GlobalMockObject::verify();
    std::shared_ptr<PlatformInterface> platformInterface(new PlatformInterface());
    EXPECT_EQ(EMPTY_FREQUENCY, platformInterface->GetDeviceOscDefaultFreq());
    EXPECT_EQ(EMPTY_FREQUENCY, platformInterface->GetAicDefaultFreq());
    EXPECT_EQ(EMPTY_FREQUENCY, platformInterface->GetAivDefaultFreq());
    EXPECT_EQ(INTERFACE_L2CACHEEVENT, platformInterface->GetL2CacheEvents());
    EXPECT_EQ(INTERFACE_AIRTHMETICUTILIZATION, platformInterface->GetArithmeticUtilizationMetrics());
    EXPECT_EQ(INTERFACE_PIPEUTILIZATION, platformInterface->GetPipeUtilizationMetrics());
    EXPECT_EQ(INTERFACE_PIPELINEEXECUTEUTILIZATION, platformInterface->GetPipelineExecuteUtilizationMetrics());
    EXPECT_EQ(INTERFACE_RESOURCECONFLICTRATIO, platformInterface->GetResourceConflictRatioMetrics());
    EXPECT_EQ(INTERFACE_PIPELINEEXECUTEUTILIZATION, platformInterface->GetPipeStallCycleMetrics());
    EXPECT_EQ(INTERFACE_MEMORY, platformInterface->GetMemoryMetrics());
    EXPECT_EQ(INTERFACE_MEMORYL0, platformInterface->GetMemoryL0Metrics());
    EXPECT_EQ(INTERFACE_MEMORYUB, platformInterface->GetMemoryUBMetrics());
    EXPECT_EQ(EMPTY_FREQUENCY, platformInterface->GetScalarMetrics());
    EXPECT_EQ(INTERFACE_L2CACHE, platformInterface->GetL2CacheMetrics());
    EXPECT_EQ(PlatformFeature::PLATFORM_FEATURE_INVALID, platformInterface->PmuMetricsToFeature("AbsMetrics"));
    EXPECT_EQ(EMPTY_FREQUENCY, platformInterface->GetMetricsValue(PlatformFeature::PLATFORM_COLLECTOR_TYPES_MAX));
}

TEST_F(COMMON_PLATFORM_TEST, NanoPlatformTest) {
    GlobalMockObject::verify();
    MOCKER(halGetDeviceInfo)
        .stubs()
        .will(invoke(halGetDeviceInfoStub));
    MOCKER_CPP(&Analysis::Dvvp::Common::Config::ConfigManager::GetPlatformType)
        .stubs()
        .will(returnValue(Analysis::Dvvp::Common::Config::PlatformType::CHIP_NANO_V1));

    auto platform = Analysis::Dvvp::Common::Platform::Platform::instance();

    EXPECT_EQ(PROFILING_SUCCESS, platform->Uninit());
    EXPECT_EQ(PROFILING_SUCCESS, platform->Init());
    platform->SetPlatformSoc();
    EXPECT_EQ(Analysis::Dvvp::Common::Platform::SysPlatformType::DEVICE, platform->GetPlatform());

    std::string pmuType = "ArithmeticUtilization";
    std::string aicEvent;
    EXPECT_EQ(PROFILING_FAILED, platform->GetAicoreEvents(pmuType, aicEvent));

    pmuType = "PipelineExecuteUtilization";
    EXPECT_EQ(PROFILING_FAILED, platform->GetAicoreEvents(pmuType, aicEvent));

    pmuType = "L2Cache";
    EXPECT_EQ(PROFILING_FAILED, platform->GetAicoreEvents(pmuType, aicEvent));

    pmuType = "MemoryL0";
    EXPECT_EQ(PROFILING_FAILED, platform->GetAicoreEvents(pmuType, aicEvent));

    pmuType = "ResourceConflictRatio";
    EXPECT_EQ(PROFILING_FAILED, platform->GetAicoreEvents(pmuType, aicEvent));

    pmuType = "PipeUtilization";
    EXPECT_EQ(PROFILING_SUCCESS, platform->GetAicoreEvents(pmuType, aicEvent));
    EXPECT_EQ("0x300,0x400,0x100,0x200,0x201,0x202,0x302,0x203,0x101,0x102", aicEvent);

    pmuType = "PipeStallCycle";
    EXPECT_EQ(PROFILING_SUCCESS, platform->GetAicoreEvents(pmuType, aicEvent));
    EXPECT_EQ("0x406,0x305,0x600,0x601,0x602,0x603,0x604,0x605,0x606,0x607", aicEvent);

    pmuType = "Memory";
    EXPECT_EQ(PROFILING_SUCCESS, platform->GetAicoreEvents(pmuType, aicEvent));
    EXPECT_EQ("0x201,0x202,0x204,0x205", aicEvent);

    pmuType = "MemoryUB";
    EXPECT_EQ(PROFILING_SUCCESS, platform->GetAicoreEvents(pmuType, aicEvent));
    EXPECT_EQ("0x206,0x207,0x208,0x209,0x303,0x304,0x106,0x107", aicEvent);

    pmuType = "ScalarRatio";
    EXPECT_EQ(PROFILING_SUCCESS, platform->GetAicoreEvents(pmuType, aicEvent));
    EXPECT_EQ("0x103,0x104,0x105", aicEvent);

    EXPECT_EQ(true, ParamValidation::instance()->CheckParamL0L1Invalid("task_trace", "on"));
    EXPECT_EQ(false, ParamValidation::instance()->CheckParamL0L1Invalid("ge_api", "on"));
    EXPECT_EQ(false, ParamValidation::instance()->CheckParamEmptyInvalid("l2", "on"));
    EXPECT_EQ(false, ParamValidation::instance()->CheckParamEmptyInvalid("aicpu", "on"));
    EXPECT_EQ(false, ParamValidation::instance()->CheckParamL0L1Invalid("task_trace", "l3"));

    EXPECT_EQ(false, platform->CheckIfSupport(PLATFORM_TASK_L2_CACHE_REG));
}

TEST_F(COMMON_PLATFORM_TEST, MdcMiniV3PlatformTest) {
    GlobalMockObject::verify();
    MOCKER(halGetDeviceInfo)
        .stubs()
        .will(invoke(halGetDeviceInfoStub));
    MOCKER_CPP(&Analysis::Dvvp::Common::Config::ConfigManager::GetPlatformType)
        .stubs()
        .will(returnValue(Analysis::Dvvp::Common::Config::PlatformType::CHIP_MDC_MINI_V3));

    auto platform = Analysis::Dvvp::Common::Platform::Platform::instance();

    EXPECT_EQ(PROFILING_SUCCESS, platform->Uninit());
    EXPECT_EQ(PROFILING_SUCCESS, platform->Init());
    platform->SetPlatformSoc();
    EXPECT_EQ(Analysis::Dvvp::Common::Platform::SysPlatformType::DEVICE, platform->GetPlatform());

    // pmu
    std::string pmuType = "ArithmeticUtilization";
    std::string aicEvent;
    EXPECT_EQ(PROFILING_SUCCESS, platform->GetAicoreEvents(pmuType, aicEvent));
    EXPECT_EQ("0x49,0x4a,0x4b,0x4c,0x4d,0x4e,0x4f", aicEvent);

    pmuType = "PipeUtilization";
    EXPECT_EQ(PROFILING_SUCCESS, platform->GetAicoreEvents(pmuType, aicEvent));
    EXPECT_EQ("0x8,0xa,0x9,0xb,0xc,0xd,0x54,0x55", aicEvent);

    pmuType = "PipelineExecuteUtilization";
    EXPECT_EQ(PROFILING_SUCCESS, platform->GetAicoreEvents(pmuType, aicEvent));
    EXPECT_EQ("0x12c,0x49,0x4a,0x9,0x302,0xc,0xd,0x303", aicEvent);

    pmuType = "Memory";
    EXPECT_EQ(PROFILING_SUCCESS, platform->GetAicoreEvents(pmuType, aicEvent));
    EXPECT_EQ("0x15,0x16,0x31,0x32,0xf,0x10,0x12,0x13", aicEvent);

    pmuType = "MemoryL0";
    EXPECT_EQ(PROFILING_SUCCESS, platform->GetAicoreEvents(pmuType, aicEvent));
    EXPECT_EQ("0x1b,0x1c,0x21,0x22,0x27,0x28,0x29,0x2a", aicEvent);

    pmuType = "MemoryUB";
    EXPECT_EQ(PROFILING_SUCCESS, platform->GetAicoreEvents(pmuType, aicEvent));
    EXPECT_EQ("0x37,0x38,0x1a5,0x1a6,0x17f,0x180,0x191", aicEvent);

    pmuType = "L2Cache";
    EXPECT_EQ(PROFILING_SUCCESS, platform->GetAicoreEvents(pmuType, aicEvent));
    EXPECT_EQ("0x500,0x502,0x504,0x506,0x508,0x50a", aicEvent);

    pmuType = "ResourceConflictRatio";
    EXPECT_EQ(PROFILING_SUCCESS, platform->GetAicoreEvents(pmuType, aicEvent));
    EXPECT_EQ("0x64,0x65,0x66", aicEvent);

    pmuType = "PipeStallCycle";
    EXPECT_EQ(PROFILING_FAILED, platform->GetAicoreEvents(pmuType, aicEvent));

    pmuType = "ScalarRatio";
    EXPECT_EQ(PROFILING_FAILED, platform->GetAicoreEvents(pmuType, aicEvent));

    // feature
    std::string featureType = "switch";
    EXPECT_EQ(true, platform->CheckIfSupport(featureType));

    featureType = "ge_api";
    EXPECT_EQ(true, platform->CheckIfSupport(featureType));

    featureType = "task_trace";
    EXPECT_EQ(true, platform->CheckIfSupport(featureType));

    featureType = "aicpu";
    EXPECT_EQ(false, platform->CheckIfSupport(featureType));

    featureType = "l2";
    EXPECT_EQ(true, platform->CheckIfSupport(featureType));

    featureType = "hccl";
    EXPECT_EQ(true, platform->CheckIfSupport(featureType));

    featureType = "msproftx";
    EXPECT_EQ(true, platform->CheckIfSupport(featureType));

    featureType = "instr_profiling";
    EXPECT_EQ(false, platform->CheckIfSupport(featureType));

    featureType = "task_tsfw";
    EXPECT_EQ(true, platform->CheckIfSupport(featureType));

    featureType = "task_framework";
    EXPECT_EQ(false, platform->CheckIfSupport(featureType));

    featureType = "ascendcl";
    EXPECT_EQ(true, platform->CheckIfSupport(featureType));

    featureType = "task_block";
    EXPECT_EQ(false, platform->CheckIfSupport(featureType));

    featureType = "sys_lp_freq";
    EXPECT_EQ(false, platform->CheckIfSupport(featureType));

    featureType = "training_trace";
    EXPECT_EQ(true, platform->CheckIfSupport(featureType));

    std::string l2Switch = "on";
    std::string l2Events = "";
    std::string npuEvent = "";
    platform->L2CacheAdaptor(npuEvent, l2Switch, l2Events);
    EXPECT_EQ("0xF6,0xFB,0xFC,0xBF,0x90,0x91,0x9C,0x9D", l2Events);
}

TEST_F(COMMON_PLATFORM_TEST, CloudV2PlatformTest) {

    Dvvp::Collect::Platform::CloudV2Platform platform;

    // pmu
    std::string aicEvent;
    EXPECT_EQ(PROFILING_SUCCESS, platform.GetAiPmuMetrics("ArithmeticUtilization", aicEvent));
    EXPECT_EQ("0x49,0x4a,0x4b,0x4c,0x4d,0x4e,0x4f", aicEvent);

    EXPECT_EQ(PROFILING_SUCCESS, platform.GetAiPmuMetrics("PipeUtilization", aicEvent));
    EXPECT_EQ("0x8,0xa,0x9,0xb,0xc,0xd,0x54,0x55", aicEvent);

    EXPECT_EQ(PROFILING_SUCCESS, platform.GetAiPmuMetrics("PipeUtilizationExct", aicEvent));
    EXPECT_EQ("0x416,0x417,0x9,0x302,0xc,0x303,0x54,0x55", aicEvent);

    EXPECT_EQ(PROFILING_FAILED, platform.GetAiPmuMetrics("PipelineExecuteUtilization", aicEvent));

    EXPECT_EQ(PROFILING_SUCCESS, platform.GetAiPmuMetrics("Memory", aicEvent));
    EXPECT_EQ("0x15,0x16,0x31,0x32,0xf,0x10,0x12,0x13", aicEvent);

    EXPECT_EQ(PROFILING_SUCCESS, platform.GetAiPmuMetrics("MemoryL0", aicEvent));
    EXPECT_EQ("0x1b,0x1c,0x21,0x22,0x27,0x28,0x29,0x2a", aicEvent);

    EXPECT_EQ(PROFILING_SUCCESS, platform.GetAiPmuMetrics("MemoryUB", aicEvent));
    EXPECT_EQ("0x10,0x13,0x37,0x38,0x3d,0x3e,0x43,0x44", aicEvent);

    EXPECT_EQ(PROFILING_SUCCESS, platform.GetAiPmuMetrics("L2Cache", aicEvent));
    EXPECT_EQ("0x500,0x502,0x504,0x506,0x508,0x50a", aicEvent);

    EXPECT_EQ(PROFILING_SUCCESS, platform.GetAiPmuMetrics("ResourceConflictRatio", aicEvent));
    EXPECT_EQ("0x64,0x65,0x66", aicEvent);

    EXPECT_EQ(PROFILING_FAILED, platform.GetAiPmuMetrics("PipeStallCycle", aicEvent));
    EXPECT_EQ(PROFILING_FAILED, platform.GetAiPmuMetrics("ScalarRatio", aicEvent));

    // feature
    EXPECT_EQ(true, platform.FeatureIsSupport(PlatformFeature::PLATFORM_TASK_SWITCH));
    EXPECT_EQ(true, platform.FeatureIsSupport(PlatformFeature::PLATFORM_TASK_GE_API));
    EXPECT_EQ(true, platform.FeatureIsSupport(PlatformFeature::PLATFORM_TASK_TRACE));
    EXPECT_EQ(true, platform.FeatureIsSupport(PlatformFeature::PLATFORM_TASK_AICPU));
    EXPECT_EQ(true, platform.FeatureIsSupport(PlatformFeature::PLATFORM_TASK_L2_CACHE_REG));
    EXPECT_EQ(true, platform.FeatureIsSupport(PlatformFeature::PLATFORM_TASK_HCCL));
    EXPECT_EQ(true, platform.FeatureIsSupport(PlatformFeature::PLATFORM_TASK_MSPROFTX));
    EXPECT_EQ(true, platform.FeatureIsSupport(PlatformFeature::PLATFORM_SYS_DEVICE_INSTR_PROFILING));
    EXPECT_EQ(true, platform.FeatureIsSupport(PlatformFeature::PLATFORM_TASK_TSFW));
    EXPECT_EQ(true, platform.FeatureIsSupport(PlatformFeature::PLATFORM_TASK_RUNTIME_API));
    EXPECT_EQ(true, platform.FeatureIsSupport(PlatformFeature::PLATFORM_TASK_ASCENDCL));
    EXPECT_EQ(true, platform.FeatureIsSupport(PlatformFeature::PLATFORM_TASK_BLOCK));
    EXPECT_EQ(false, platform.FeatureIsSupport(PlatformFeature::PLATFORM_SYS_DEVICE_LOW_POWER));
    EXPECT_EQ(true, platform.FeatureIsSupport(PlatformFeature::PLATFORM_TASK_TRAINING_TRACE));

    EXPECT_EQ("0xF6,0xFB,0xFC,0xBF,0x90,0x91,0x9C,0x9D", platform.GetL2CacheEvents());
}

TEST_F(COMMON_PLATFORM_TEST, CloudPlatformTest) {

    Dvvp::Collect::Platform::CloudPlatform platform;

    // pmu
    std::string aicEvent;
    EXPECT_EQ(PROFILING_SUCCESS, platform.GetAiPmuMetrics("ArithmeticUtilization", aicEvent));
    EXPECT_EQ("0x49,0x4a,0x4b,0x4c,0x4d,0x4e,0x4f", aicEvent);

    EXPECT_EQ(PROFILING_SUCCESS, platform.GetAiPmuMetrics("PipeUtilization", aicEvent));
    EXPECT_EQ("0x8,0xa,0x9,0xb,0xc,0xd,0x54,0x55", aicEvent);

    EXPECT_EQ(PROFILING_SUCCESS, platform.GetAiPmuMetrics("Memory", aicEvent));
    EXPECT_EQ("0x15,0x16,0x31,0x32,0xf,0x10,0x12,0x13", aicEvent);

    EXPECT_EQ(PROFILING_SUCCESS, platform.GetAiPmuMetrics("MemoryL0", aicEvent));
    EXPECT_EQ("0x1b,0x1c,0x21,0x22,0x27,0x28,0x29,0x2a", aicEvent);

    EXPECT_EQ(PROFILING_SUCCESS, platform.GetAiPmuMetrics("MemoryUB", aicEvent));
    EXPECT_EQ("0x10,0x13,0x37,0x38,0x3d,0x3e,0x43,0x44", aicEvent);

    EXPECT_EQ(PROFILING_SUCCESS, platform.GetAiPmuMetrics("ResourceConflictRatio", aicEvent));
    EXPECT_EQ("0x64,0x65,0x66", aicEvent);

    EXPECT_EQ(PROFILING_FAILED, platform.GetAiPmuMetrics("PipeUtilizationExct", aicEvent));
    EXPECT_EQ(PROFILING_FAILED, platform.GetAiPmuMetrics("PipelineExecuteUtilization", aicEvent));
    EXPECT_EQ(PROFILING_FAILED, platform.GetAiPmuMetrics("PipeStallCycle", aicEvent));
    EXPECT_EQ(PROFILING_FAILED, platform.GetAiPmuMetrics("ScalarRatio", aicEvent));
    EXPECT_EQ(PROFILING_FAILED, platform.GetAiPmuMetrics("L2Cache", aicEvent));

    EXPECT_EQ("0x5b,0x59,0x5c,0x7d,0x7e,0x71,0x79,0x7c", platform.GetL2CacheEvents());
}

TEST_F(COMMON_PLATFORM_TEST, DcPlatformTest) {

    Dvvp::Collect::Platform::DcPlatform platform;

    // pmu
    std::string aicEvent;
    EXPECT_EQ(PROFILING_SUCCESS, platform.GetAiPmuMetrics("ArithmeticUtilization", aicEvent));
    EXPECT_EQ("0x49,0x4a,0x4b,0x4c,0x4d,0x4e,0x4f", aicEvent);

    EXPECT_EQ(PROFILING_SUCCESS, platform.GetAiPmuMetrics("PipeUtilization", aicEvent));
    EXPECT_EQ("0x8,0xa,0x9,0xb,0xc,0xd,0x54,0x55", aicEvent);

    EXPECT_EQ(PROFILING_SUCCESS, platform.GetAiPmuMetrics("Memory", aicEvent));
    EXPECT_EQ("0x15,0x16,0x31,0x32,0xf,0x10,0x12,0x13", aicEvent);

    EXPECT_EQ(PROFILING_SUCCESS, platform.GetAiPmuMetrics("MemoryL0", aicEvent));
    EXPECT_EQ("0x1b,0x1c,0x21,0x22,0x27,0x28,0x29,0x2a", aicEvent);

    EXPECT_EQ(PROFILING_SUCCESS, platform.GetAiPmuMetrics("MemoryUB", aicEvent));
    EXPECT_EQ("0x10,0x13,0x37,0x38,0x3d,0x3e,0x43,0x44", aicEvent);

    EXPECT_EQ(PROFILING_SUCCESS, platform.GetAiPmuMetrics("ResourceConflictRatio", aicEvent));
    EXPECT_EQ("0x64,0x65,0x66", aicEvent);

    EXPECT_EQ(PROFILING_FAILED, platform.GetAiPmuMetrics("PipeUtilizationExct", aicEvent));
    EXPECT_EQ(PROFILING_FAILED, platform.GetAiPmuMetrics("PipelineExecuteUtilization", aicEvent));
    EXPECT_EQ(PROFILING_FAILED, platform.GetAiPmuMetrics("PipeStallCycle", aicEvent));
    EXPECT_EQ(PROFILING_FAILED, platform.GetAiPmuMetrics("ScalarRatio", aicEvent));
    EXPECT_EQ(PROFILING_FAILED, platform.GetAiPmuMetrics("L2Cache", aicEvent));

    EXPECT_EQ("0x78,0x79,0x77,0x71,0x6a,0x6c,0x74,0x62", platform.GetL2CacheEvents());
}

TEST_F(COMMON_PLATFORM_TEST, MiniPlatformTest) {

    Dvvp::Collect::Platform::MiniPlatform platform;

    // pmu
    std::string aicEvent;
    EXPECT_EQ(PROFILING_SUCCESS, platform.GetAiPmuMetrics("ArithmeticUtilization", aicEvent));
    EXPECT_EQ("0x49,0x4a,0x4b,0x4c,0x4d,0x4e,0x4f", aicEvent);

    EXPECT_EQ(PROFILING_SUCCESS, platform.GetAiPmuMetrics("PipeUtilization", aicEvent));
    EXPECT_EQ("0x8,0xa,0x9,0xb,0xc,0xd,0x54,0x55", aicEvent);

    EXPECT_EQ(PROFILING_SUCCESS, platform.GetAiPmuMetrics("Memory", aicEvent));
    EXPECT_EQ("0x15,0x16,0x31,0x32,0xf,0x10,0x12,0x13", aicEvent);

    EXPECT_EQ(PROFILING_SUCCESS, platform.GetAiPmuMetrics("MemoryL0", aicEvent));
    EXPECT_EQ("0x1b,0x1c,0x21,0x22,0x27,0x28,0x29,0x2a", aicEvent);

    EXPECT_EQ(PROFILING_SUCCESS, platform.GetAiPmuMetrics("MemoryUB", aicEvent));
    EXPECT_EQ("0x10,0x13,0x37,0x38,0x3d,0x3e,0x43,0x44", aicEvent);

    EXPECT_EQ(PROFILING_SUCCESS, platform.GetAiPmuMetrics("ResourceConflictRatio", aicEvent));
    EXPECT_EQ("0x64,0x65,0x66", aicEvent);

    EXPECT_EQ(PROFILING_SUCCESS, platform.GetAiPmuMetrics("Custom:0x500,0x502,0x504,0x506,0x508,0x50a,0xc,0xd", aicEvent));
    EXPECT_EQ(PROFILING_FAILED, platform.GetAiPmuMetrics("PipeUtilizationExct", aicEvent));
    EXPECT_EQ(PROFILING_FAILED, platform.GetAiPmuMetrics("PipelineExecuteUtilization", aicEvent));
    EXPECT_EQ(PROFILING_FAILED, platform.GetAiPmuMetrics("PipeStallCycle", aicEvent));
    EXPECT_EQ(PROFILING_FAILED, platform.GetAiPmuMetrics("ScalarRatio", aicEvent));
    EXPECT_EQ(PROFILING_FAILED, platform.GetAiPmuMetrics("L2Cache", aicEvent));

    EXPECT_EQ(false, platform.FeatureIsSupport(PLATFORM_TASK_L2_CACHE_REG));
}

TEST_F(COMMON_PLATFORM_TEST, MdcPlatformTest) {

    Dvvp::Collect::Platform::MdcPlatform platform;

    // pmu
    std::string aicEvent;
    EXPECT_EQ(PROFILING_SUCCESS, platform.GetAiPmuMetrics("ArithmeticUtilization", aicEvent));
    EXPECT_EQ("0x49,0x4a,0x4b,0x4c,0x4d,0x4e,0x4f", aicEvent);

    EXPECT_EQ(PROFILING_SUCCESS, platform.GetAiPmuMetrics("PipeUtilization", aicEvent));
    EXPECT_EQ("0x8,0xa,0x9,0xb,0xc,0xd,0x54,0x55", aicEvent);

    EXPECT_EQ(PROFILING_SUCCESS, platform.GetAiPmuMetrics("Memory", aicEvent));
    EXPECT_EQ("0x15,0x16,0x31,0x32,0xf,0x10,0x12,0x13", aicEvent);

    EXPECT_EQ(PROFILING_SUCCESS, platform.GetAiPmuMetrics("MemoryL0", aicEvent));
    EXPECT_EQ("0x1b,0x1c,0x21,0x22,0x27,0x28,0x29,0x2a", aicEvent);

    EXPECT_EQ(PROFILING_SUCCESS, platform.GetAiPmuMetrics("MemoryUB", aicEvent));
    EXPECT_EQ("0x10,0x13,0x37,0x38,0x3d,0x3e,0x43,0x44", aicEvent);

    EXPECT_EQ(PROFILING_SUCCESS, platform.GetAiPmuMetrics("ResourceConflictRatio", aicEvent));
    EXPECT_EQ("0x64,0x65,0x66", aicEvent);

    EXPECT_EQ(PROFILING_FAILED, platform.GetAiPmuMetrics("PipeUtilizationExct", aicEvent));
    EXPECT_EQ(PROFILING_FAILED, platform.GetAiPmuMetrics("PipelineExecuteUtilization", aicEvent));
    EXPECT_EQ(PROFILING_FAILED, platform.GetAiPmuMetrics("PipeStallCycle", aicEvent));
    EXPECT_EQ(PROFILING_FAILED, platform.GetAiPmuMetrics("ScalarRatio", aicEvent));
    EXPECT_EQ(PROFILING_FAILED, platform.GetAiPmuMetrics("L2Cache", aicEvent));

    EXPECT_EQ(true, platform.FeatureIsSupport(PLATFORM_TASK_AICPU));
    EXPECT_EQ(true, platform.FeatureIsSupport(PLATFORM_TASK_ASCENDCL));
    EXPECT_EQ(true, platform.FeatureIsSupport(PLATFORM_TASK_AIC_METRICS));
    EXPECT_EQ(true, platform.FeatureIsSupport(PLATFORM_TASK_AIV_METRICS));
    EXPECT_EQ(true, platform.FeatureIsSupport(PLATFORM_TASK_GE_API));
    EXPECT_EQ(true, platform.FeatureIsSupport(PLATFORM_TASK_HCCL));
    EXPECT_EQ(true, platform.FeatureIsSupport(PLATFORM_TASK_L2_CACHE_REG));
    EXPECT_EQ(true, platform.FeatureIsSupport(PLATFORM_TASK_MSPROFTX));
    EXPECT_EQ(true, platform.FeatureIsSupport(PLATFORM_TASK_RUNTIME_API));
    EXPECT_EQ(true, platform.FeatureIsSupport(PLATFORM_TASK_SWITCH));
    EXPECT_EQ(true, platform.FeatureIsSupport(PLATFORM_TASK_TRACE));
    EXPECT_EQ(true, platform.FeatureIsSupport(PLATFORM_TASK_TSFW));
    EXPECT_EQ(true, platform.FeatureIsSupport(PLATFORM_TASK_TS_MEMCPY));
    EXPECT_EQ(false, platform.FeatureIsSupport(PLATFORM_TASK_BLOCK));
    EXPECT_EQ(true, platform.FeatureIsSupport(PLATFORM_TASK_TS_KEYPOINT));
    EXPECT_EQ(true, platform.FeatureIsSupport(PLATFORM_TASK_TRAINING_TRACE));
    EXPECT_EQ(true, platform.FeatureIsSupport(PLATFORM_TASK_METRICS));
    EXPECT_EQ(true, platform.FeatureIsSupport(PLATFORM_TASK_MEMORY));
    EXPECT_EQ(false, platform.FeatureIsSupport(PLATFORM_SYS_DEVICE_INSTR_PROFILING));
    EXPECT_EQ(false, platform.FeatureIsSupport(PLATFORM_SYS_DEVICE_LOW_POWER));
    EXPECT_EQ(true, platform.FeatureIsSupport(PLATFORM_SYS_DEVICE_DVPP_EX));
    EXPECT_EQ(true, platform.FeatureIsSupport(PLATFORM_SYS_DEVICE_DDR));
    EXPECT_EQ(true, platform.FeatureIsSupport(PLATFORM_SYS_DEVICE_HBM));
    EXPECT_EQ(true, platform.FeatureIsSupport(PLATFORM_SYS_DEVICE_LLC));

    EXPECT_EQ("0x78,0x79,0x77,0x71,0x6a,0x6c,0x74,0x62", platform.GetL2CacheEvents());
}

TEST_F(COMMON_PLATFORM_TEST, TinyV1PlatformTest) {

    Dvvp::Collect::Platform::TinyV1Platform platform;

    // pmu
    std::string aicEvent;
    EXPECT_EQ(PROFILING_SUCCESS, platform.GetAiPmuMetrics("ArithmeticUtilization", aicEvent));
    EXPECT_EQ("0x49,0x4a,0x4b,0x4c,0x4d,0x4e,0x4f", aicEvent);

    EXPECT_EQ(PROFILING_SUCCESS, platform.GetAiPmuMetrics("PipeUtilization", aicEvent));
    EXPECT_EQ("0x8,0xa,0x9,0xb,0xc,0xd,0x54,0x55", aicEvent);

    EXPECT_EQ(PROFILING_SUCCESS, platform.GetAiPmuMetrics("Memory", aicEvent));
    EXPECT_EQ("0x15,0x16,0x31,0x32,0xf,0x10,0x12,0x13", aicEvent);

    EXPECT_EQ(PROFILING_SUCCESS, platform.GetAiPmuMetrics("MemoryL0", aicEvent));
    EXPECT_EQ("0x1b,0x1c,0x21,0x22,0x27,0x28,0x29,0x2a", aicEvent);

    EXPECT_EQ(PROFILING_SUCCESS, platform.GetAiPmuMetrics("MemoryUB", aicEvent));
    EXPECT_EQ("0x37,0x38,0x1a5,0x1a6,0x17f,0x180,0x191", aicEvent);

    EXPECT_EQ(PROFILING_SUCCESS, platform.GetAiPmuMetrics("ResourceConflictRatio", aicEvent));
    EXPECT_EQ("0x64,0x65,0x66", aicEvent);

    EXPECT_EQ(PROFILING_SUCCESS, platform.GetAiPmuMetrics("PipelineExecuteUtilization", aicEvent));
    EXPECT_EQ("0x12c,0x49,0x4a,0x9,0x302,0xc,0xd,0x303", aicEvent);

    EXPECT_EQ(PROFILING_SUCCESS, platform.GetAiPmuMetrics("L2Cache", aicEvent));
    EXPECT_EQ("0x500,0x502,0x504,0x506,0x508,0x50a", aicEvent);

    EXPECT_EQ(PROFILING_FAILED, platform.GetAiPmuMetrics("PipeUtilizationExct", aicEvent));
    EXPECT_EQ(PROFILING_FAILED, platform.GetAiPmuMetrics("PipeStallCycle", aicEvent));
    EXPECT_EQ(PROFILING_FAILED, platform.GetAiPmuMetrics("ScalarRatio", aicEvent));

    EXPECT_EQ(true, platform.FeatureIsSupport(PLATFORM_TASK_SWITCH));
    EXPECT_EQ(true, platform.FeatureIsSupport(PLATFORM_TASK_ASCENDCL));
    EXPECT_EQ(true, platform.FeatureIsSupport(PLATFORM_TASK_FWK));
    EXPECT_EQ(true, platform.FeatureIsSupport(PLATFORM_TASK_RUNTIME));
    EXPECT_EQ(false, platform.FeatureIsSupport(PLATFORM_TASK_AICPU));
    EXPECT_EQ(true, platform.FeatureIsSupport(PLATFORM_TASK_HCCL));
    EXPECT_EQ(true, platform.FeatureIsSupport(PLATFORM_TASK_L2_CACHE_REG));

    EXPECT_EQ(true, platform.FeatureIsSupport(PLATFORM_TASK_TS_KEYPOINT));
    EXPECT_EQ(true, platform.FeatureIsSupport(PLATFORM_TASK_TS_MEMCPY));
    EXPECT_EQ(true, platform.FeatureIsSupport(PLATFORM_TASK_AIC_METRICS));
    EXPECT_EQ(true, platform.FeatureIsSupport(PLATFORM_TASK_AIV_METRICS));
    EXPECT_EQ(true, platform.FeatureIsSupport(PLATFORM_TASK_STARS_ACSQ));
    EXPECT_EQ(true, platform.FeatureIsSupport(PLATFORM_TASK_GE_API));
    EXPECT_EQ(true, platform.FeatureIsSupport(PLATFORM_TASK_TRACE));
    EXPECT_EQ(true, platform.FeatureIsSupport(PLATFORM_TASK_MSPROFTX));
    EXPECT_EQ(true, platform.FeatureIsSupport(PLATFORM_TASK_TSFW));
    EXPECT_EQ(true, platform.FeatureIsSupport(PLATFORM_TASK_RUNTIME_API));
    EXPECT_EQ(false, platform.FeatureIsSupport(PLATFORM_TASK_BLOCK));
    EXPECT_EQ(true, platform.FeatureIsSupport(PLATFORM_TASK_METRICS));
    EXPECT_EQ(true, platform.FeatureIsSupport(PLATFORM_TASK_TRAINING_TRACE));
    EXPECT_EQ(true, platform.FeatureIsSupport(PLATFORM_TASK_MEMORY));
    EXPECT_EQ(true, platform.FeatureIsSupport(PLATFORM_SYS_DEVICE_SYS_CPU_MEM_USAGE));
    EXPECT_EQ(true, platform.FeatureIsSupport(PLATFORM_SYS_DEVICE_ALL_PID_CPU_MEM_USAGE));
    EXPECT_EQ(true, platform.FeatureIsSupport(PLATFORM_SYS_DEVICE_AI_CTRL_CPU_HOT_FUNC_PMU));
    EXPECT_EQ(true, platform.FeatureIsSupport(PLATFORM_SYS_DEVICE_NPU_MODULE_MEM));
    EXPECT_EQ(true, platform.FeatureIsSupport(PLATFORM_SYS_DEVICE_LLC));
    EXPECT_EQ(true, platform.FeatureIsSupport(PLATFORM_SYS_DEVICE_DDR));
    EXPECT_EQ(false, platform.FeatureIsSupport(PLATFORM_SYS_DEVICE_NIC));
    EXPECT_EQ(true, platform.FeatureIsSupport(PLATFORM_SYS_DEVICE_DVPP));
    EXPECT_EQ(true, platform.FeatureIsSupport(PLATFORM_SYS_HOST_ONE_PID_CPU));
    EXPECT_EQ(true, platform.FeatureIsSupport(PLATFORM_SYS_HOST_ALL_PID_CPU));
    EXPECT_EQ(true, platform.FeatureIsSupport(PLATFORM_SYS_HOST_ONE_PID_MEM));
    EXPECT_EQ(true, platform.FeatureIsSupport(PLATFORM_SYS_HOST_ALL_PID_MEM));
    EXPECT_EQ(true, platform.FeatureIsSupport(PLATFORM_SYS_HOST_ONE_PID_DISK));
    EXPECT_EQ(true, platform.FeatureIsSupport(PLATFORM_SYS_HOST_ONE_PID_OSRT));
    EXPECT_EQ(true, platform.FeatureIsSupport(PLATFORM_SYS_HOST_NETWORK));
    EXPECT_EQ(true, platform.FeatureIsSupport(PLATFORM_SYS_HOST_SYS_CPU));
    EXPECT_EQ(true, platform.FeatureIsSupport(PLATFORM_SYS_HOST_SYS_MEM));

    EXPECT_EQ("0xF6,0xFB,0xFC,0xBF,0x90,0x91,0x9C,0x9D", platform.GetL2CacheEvents());
}

TEST_F(COMMON_PLATFORM_TEST, MdcLitePlatformTest) {
    GlobalMockObject::verify();
    MOCKER(halGetDeviceInfo)
        .stubs()
        .will(invoke(halGetDeviceInfoStub));
    MOCKER_CPP(&Analysis::Dvvp::Common::Config::ConfigManager::GetPlatformType)
        .stubs()
        .will(returnValue(Analysis::Dvvp::Common::Config::PlatformType::CHIP_MDC_LITE));

    auto platform = Analysis::Dvvp::Common::Platform::Platform::instance();

    EXPECT_EQ(PROFILING_SUCCESS, platform->Uninit());
    EXPECT_EQ(PROFILING_SUCCESS, platform->Init());
    platform->SetPlatformSoc();
    EXPECT_EQ(Analysis::Dvvp::Common::Platform::SysPlatformType::DEVICE, platform->GetPlatform());

    // pmu
    std::string pmuType = "ArithmeticUtilization";
    std::string aicEvent;
    EXPECT_EQ(PROFILING_SUCCESS, platform->GetAicoreEvents(pmuType, aicEvent));
    EXPECT_EQ("0x302,0x303", aicEvent);

    pmuType = "PipeUtilization";
    EXPECT_EQ(PROFILING_SUCCESS, platform->GetAicoreEvents(pmuType, aicEvent));
    EXPECT_EQ("0x500,0x301,0x1,0x701,0x202,0x203,0x34,0x35", aicEvent);

    pmuType = "PipelineExecuteUtilization";
    EXPECT_EQ(PROFILING_SUCCESS, platform->GetAicoreEvents(pmuType, aicEvent));
    EXPECT_EQ("0x500,0x301,0x1,0x701,0x202,0x203,0x714", aicEvent);

    pmuType = "Memory";
    EXPECT_EQ(PROFILING_SUCCESS, platform->GetAicoreEvents(pmuType, aicEvent));
    EXPECT_EQ("0x404,0x406,0x566,0x567,0x707,0x709", aicEvent);

    pmuType = "MemoryL0";
    EXPECT_EQ(PROFILING_SUCCESS, platform->GetAicoreEvents(pmuType, aicEvent));
    EXPECT_EQ("0x304,0x702,0x306,0x703,0x712,0x30a,0x308", aicEvent);

    pmuType = "MemoryUB";
    EXPECT_EQ(PROFILING_SUCCESS, platform->GetAicoreEvents(pmuType, aicEvent));
    EXPECT_EQ("0x3,0x5,0x70c,0x206,0x204,0x57b,0x57c", aicEvent);

    pmuType = "ResourceConflictRatio";
    EXPECT_EQ(PROFILING_SUCCESS, platform->GetAicoreEvents(pmuType, aicEvent));
    EXPECT_EQ("0x54f,0x551,0x552,0x561,0x563,0x564,0x557", aicEvent);

    pmuType = "L2Cache";
    EXPECT_EQ(PROFILING_FAILED, platform->GetAicoreEvents(pmuType, aicEvent));

    // feature
    std::string featureType = "switch";
    EXPECT_EQ(true, platform->CheckIfSupport(featureType));

    featureType = "ge_api";
    EXPECT_EQ(true, platform->CheckIfSupport(featureType));

    featureType = "task_trace";
    EXPECT_EQ(true, platform->CheckIfSupport(featureType));

    featureType = "aicpu";
    EXPECT_EQ(false, platform->CheckIfSupport(featureType));

    featureType = "l2";
    EXPECT_EQ(true, platform->CheckIfSupport(featureType));

    featureType = "hccl";
    EXPECT_EQ(true, platform->CheckIfSupport(featureType));

    featureType = "msproftx";
    EXPECT_EQ(true, platform->CheckIfSupport(featureType));

    featureType = "instr_profiling";
    EXPECT_EQ(false, platform->CheckIfSupport(featureType));

    featureType = "task_tsfw";
    EXPECT_EQ(true, platform->CheckIfSupport(featureType));

    featureType = "task_framework";
    EXPECT_EQ(false, platform->CheckIfSupport(featureType));

    featureType = "runtime_api";
    EXPECT_EQ(true, platform->CheckIfSupport(featureType));

    featureType = "ascendcl";
    EXPECT_EQ(true, platform->CheckIfSupport(featureType));

    featureType = "task_block";
    EXPECT_EQ(false, platform->CheckIfSupport(featureType));

    featureType = "sys_lp_freq";
    EXPECT_EQ(false, platform->CheckIfSupport(featureType));

    featureType = "training_trace";
    EXPECT_EQ(true, platform->CheckIfSupport(featureType));

    std::string l2Switch = "on";
    std::string l2Events = "";
    std::string npuEvent = "";
    platform->L2CacheAdaptor(npuEvent, l2Switch, l2Events);
    EXPECT_EQ("0x78,0x79,0x77,0x71,0x6a,0x6c,0x74,0x62", l2Events);
}

TEST_F(COMMON_PLATFORM_TEST, MiniV3PlatformTest) {
    GlobalMockObject::verify();
    MOCKER(halGetDeviceInfo)
        .stubs()
        .will(invoke(halGetDeviceInfoStub));
    MOCKER_CPP(&Analysis::Dvvp::Common::Config::ConfigManager::GetPlatformType)
        .stubs()
        .will(returnValue(Analysis::Dvvp::Common::Config::PlatformType::MINI_V3_TYPE));
 
    auto platform = Analysis::Dvvp::Common::Platform::Platform::instance();
 
    EXPECT_EQ(PROFILING_SUCCESS, platform->Uninit());
    EXPECT_EQ(PROFILING_SUCCESS, platform->Init());
    platform->SetPlatformSoc();
    EXPECT_EQ(Analysis::Dvvp::Common::Platform::SysPlatformType::DEVICE, platform->GetPlatform());
 
    // pmu
    std::string pmuType = "ArithmeticUtilization";
    std::string aicEvent;
    EXPECT_EQ(PROFILING_SUCCESS, platform->GetAicoreEvents(pmuType, aicEvent));
    EXPECT_EQ("0x49,0x4a,0x4b,0x4c,0x4d,0x4e,0x4f", aicEvent);
 
    pmuType = "PipeUtilization";
    EXPECT_EQ(PROFILING_SUCCESS, platform->GetAicoreEvents(pmuType, aicEvent));
    EXPECT_EQ("0x8,0xa,0x9,0xb,0xc,0xd,0x54,0x55", aicEvent);
 
    pmuType = "PipelineExecuteUtilization";
    EXPECT_EQ(PROFILING_SUCCESS, platform->GetAicoreEvents(pmuType, aicEvent));
    EXPECT_EQ("0x12c,0x49,0x4a,0x9,0x302,0xc,0xd,0x303", aicEvent);
 
    pmuType = "Memory";
    EXPECT_EQ(PROFILING_SUCCESS, platform->GetAicoreEvents(pmuType, aicEvent));
    EXPECT_EQ("0x15,0x16,0x31,0x32,0xf,0x10,0x12,0x13", aicEvent);
 
    pmuType = "MemoryL0";
    EXPECT_EQ(PROFILING_SUCCESS, platform->GetAicoreEvents(pmuType, aicEvent));
    EXPECT_EQ("0x1b,0x1c,0x21,0x22,0x27,0x28,0x29,0x2a", aicEvent);
 
    pmuType = "MemoryUB";
    EXPECT_EQ(PROFILING_SUCCESS, platform->GetAicoreEvents(pmuType, aicEvent));
    EXPECT_EQ("0x37,0x38,0x1a5,0x1a6,0x17f,0x180,0x191", aicEvent);
 
    pmuType = "L2Cache";
    EXPECT_EQ(PROFILING_SUCCESS, platform->GetAicoreEvents(pmuType, aicEvent));
    EXPECT_EQ("0x500,0x502,0x504,0x506,0x508,0x50a", aicEvent);
 
    pmuType = "ResourceConflictRatio";
    EXPECT_EQ(PROFILING_SUCCESS, platform->GetAicoreEvents(pmuType, aicEvent));
    EXPECT_EQ("0x64,0x65,0x66", aicEvent);
 
    pmuType = "PipeStallCycle";
    EXPECT_EQ(PROFILING_FAILED, platform->GetAicoreEvents(pmuType, aicEvent));
 
    pmuType = "ScalarRatio";
    EXPECT_EQ(PROFILING_FAILED, platform->GetAicoreEvents(pmuType, aicEvent));
 
    // feature
    std::string featureType = "switch";
    EXPECT_EQ(true, platform->CheckIfSupport(featureType));
 
    featureType = "ge_api";
    EXPECT_EQ(true, platform->CheckIfSupport(featureType));
 
    featureType = "task_trace";
    EXPECT_EQ(true, platform->CheckIfSupport(featureType));
 
    featureType = "aicpu";
    EXPECT_EQ(true, platform->CheckIfSupport(featureType));
 
    featureType = "l2";
    EXPECT_EQ(true, platform->CheckIfSupport(featureType));
 
    featureType = "hccl";
    EXPECT_EQ(true, platform->CheckIfSupport(featureType));
 
    featureType = "msproftx";
    EXPECT_EQ(true, platform->CheckIfSupport(featureType));
 
    featureType = "instr_profiling";
    EXPECT_EQ(false, platform->CheckIfSupport(featureType));
 
    featureType = "task_tsfw";
    EXPECT_EQ(true, platform->CheckIfSupport(featureType));
 
    featureType = "task_framework";
    EXPECT_EQ(false, platform->CheckIfSupport(featureType));
 
    featureType = "runtime_api";
    EXPECT_EQ(true, platform->CheckIfSupport(featureType));
 
    featureType = "ascendcl";
    EXPECT_EQ(true, platform->CheckIfSupport(featureType));
 
    featureType = "task_block";
    EXPECT_EQ(true, platform->CheckIfSupport(featureType));
 
    featureType = "sys_lp_freq";
    EXPECT_EQ(false, platform->CheckIfSupport(featureType));
 
    featureType = "training_trace";
    EXPECT_EQ(true, platform->CheckIfSupport(featureType));

    std::string l2Switch = "on";
    std::string l2Events = "";
    std::string npuEvent = "";
    platform->L2CacheAdaptor(npuEvent, l2Switch, l2Events);
    EXPECT_EQ("0xF6,0xFB,0xFC,0xBF,0x90,0x91,0x9C,0x9D", l2Events);
}

TEST_F(COMMON_PLATFORM_TEST, DavidPlatformTest) {
    GlobalMockObject::verify();
    MOCKER(halGetDeviceInfo)
        .stubs()
        .will(invoke(halGetDeviceInfoStub));

    MOCKER_CPP(&Analysis::Dvvp::Common::Config::ConfigManager::GetPlatformType)
        .stubs()
        .will(returnValue(Analysis::Dvvp::Common::Config::PlatformType::CHIP_CLOUD_V3));

    auto platform = Analysis::Dvvp::Common::Platform::Platform::instance();

    EXPECT_EQ(PROFILING_SUCCESS, platform->Uninit());
    EXPECT_EQ(PROFILING_SUCCESS, platform->Init());
    platform->SetPlatformSoc();
    EXPECT_EQ(Analysis::Dvvp::Common::Platform::SysPlatformType::DEVICE, platform->GetPlatform());

    // pmu
    std::string pmuType = "ArithmeticUtilization";
    std::string aicEvent;
    EXPECT_EQ(PROFILING_SUCCESS, platform->GetAicoreEvents(pmuType, aicEvent));
    EXPECT_EQ("0x323,0x324", aicEvent);

    pmuType = "PipeUtilization";
    EXPECT_EQ(PROFILING_SUCCESS, platform->GetAicoreEvents(pmuType, aicEvent));
    EXPECT_EQ("0x501,0x301,0x1,0x701,0x202,0x203,0x34,0x35,0x714", aicEvent);

    pmuType = "Memory";
    EXPECT_EQ(PROFILING_SUCCESS, platform->GetAicoreEvents(pmuType, aicEvent));
    EXPECT_EQ("0x400,0x401,0x56f,0x571,0x570,0x572,0x707,0x709", aicEvent);

    pmuType = "MemoryL0";
    EXPECT_EQ(PROFILING_SUCCESS, platform->GetAicoreEvents(pmuType, aicEvent));
    EXPECT_EQ("0x304,0x703,0x306,0x705,0x712,0x30a,0x308", aicEvent);

    pmuType = "MemoryUB";
    EXPECT_EQ(PROFILING_SUCCESS, platform->GetAicoreEvents(pmuType, aicEvent));
    EXPECT_EQ("0x3,0x5,0x70c,0x206,0x204,0x571,0x572", aicEvent);

    pmuType = "ResourceConflictRatio";
    EXPECT_EQ(PROFILING_SUCCESS, platform->GetAicoreEvents(pmuType, aicEvent));
    EXPECT_EQ("0x540,0x556,0x502,0x528", aicEvent);

    pmuType = "L2Cache";
    EXPECT_EQ(PROFILING_SUCCESS, platform->GetAicoreEvents(pmuType, aicEvent));
    EXPECT_EQ("0x424,0x425,0x426,0x42a,0x42b,0x42c", aicEvent);

    // feature
    std::string featureType = "switch";
    EXPECT_EQ(true, platform->CheckIfSupport(featureType));

    featureType = "ge_api";
    EXPECT_EQ(true, platform->CheckIfSupport(featureType));

    featureType = "task_trace";
    EXPECT_EQ(true, platform->CheckIfSupport(featureType));

    featureType = "aicpu";
    EXPECT_EQ(true, platform->CheckIfSupport(featureType));

    featureType = "l2";
    EXPECT_EQ(true, platform->CheckIfSupport(featureType));

    featureType = "hccl";
    EXPECT_EQ(true, platform->CheckIfSupport(featureType));

    featureType = "msproftx";
    EXPECT_EQ(true, platform->CheckIfSupport(featureType));

    featureType = "instr_profiling";
    EXPECT_EQ(true, platform->CheckIfSupport(featureType));

    featureType = "runtime_api";
    EXPECT_EQ(true, platform->CheckIfSupport(featureType));

    featureType = "ascendcl";
    EXPECT_EQ(true, platform->CheckIfSupport(featureType));

    featureType = "task_block";
    EXPECT_EQ(true, platform->CheckIfSupport(featureType));

    featureType = "sys_lp_freq";
    EXPECT_EQ(true, platform->CheckIfSupport(featureType));

    featureType = "training_trace";
    EXPECT_EQ(true, platform->CheckIfSupport(featureType));

    EXPECT_EQ(true, platform->CheckIfSupport(PLATFORM_COLLECTOR_ACP));

    std::string l2Switch = "on";
    std::string l2Events = "";
    std::string npuEvent = "";
    platform->L2CacheAdaptor(npuEvent, l2Switch, l2Events);
    EXPECT_EQ("0x00,0x88,0x89,0x8A,0x74,0x75,0x97", l2Events);
}

TEST_F(COMMON_PLATFORM_TEST, DavidV121PlatformTest) {
    GlobalMockObject::verify();
    MOCKER(halGetDeviceInfo)
        .stubs()
        .will(invoke(halGetDeviceInfoStub));

    MOCKER_CPP(&Analysis::Dvvp::Common::Config::ConfigManager::GetPlatformType)
        .stubs()
        .will(returnValue(Analysis::Dvvp::Common::Config::PlatformType::CHIP_CLOUD_V4));

    auto platform = Analysis::Dvvp::Common::Platform::Platform::instance();

    EXPECT_EQ(PROFILING_SUCCESS, platform->Uninit());
    EXPECT_EQ(PROFILING_SUCCESS, platform->Init());
    platform->SetPlatformSoc();
    EXPECT_EQ(Analysis::Dvvp::Common::Platform::SysPlatformType::DEVICE, platform->GetPlatform());

    // pmu
    std::string pmuType = "ArithmeticUtilization";
    std::string aicEvent;
    EXPECT_EQ(PROFILING_SUCCESS, platform->GetAicoreEvents(pmuType, aicEvent));
    EXPECT_EQ("0x323,0x324", aicEvent);

    pmuType = "PipeUtilization";
    EXPECT_EQ(PROFILING_SUCCESS, platform->GetAicoreEvents(pmuType, aicEvent));
    EXPECT_EQ("0x501,0x301,0x1,0x701,0x202,0x203,0x34,0x35,0x714", aicEvent);

    pmuType = "Memory";
    EXPECT_EQ(PROFILING_SUCCESS, platform->GetAicoreEvents(pmuType, aicEvent));
    EXPECT_EQ("0x400,0x401,0x56f,0x571,0x570,0x572,0x707,0x709", aicEvent);

    pmuType = "MemoryL0";
    EXPECT_EQ(PROFILING_SUCCESS, platform->GetAicoreEvents(pmuType, aicEvent));
    EXPECT_EQ("0x304,0x703,0x306,0x705,0x712,0x30a,0x308", aicEvent);

    pmuType = "MemoryUB";
    EXPECT_EQ(PROFILING_SUCCESS, platform->GetAicoreEvents(pmuType, aicEvent));
    EXPECT_EQ("0x3,0x5,0x70c,0x206,0x204,0x571,0x572", aicEvent);

    pmuType = "ResourceConflictRatio";
    EXPECT_EQ(PROFILING_SUCCESS, platform->GetAicoreEvents(pmuType, aicEvent));
    EXPECT_EQ("0x540,0x556,0x502,0x528", aicEvent);

    pmuType = "L2Cache";
    EXPECT_EQ(PROFILING_SUCCESS, platform->GetAicoreEvents(pmuType, aicEvent));
    EXPECT_EQ("0x424,0x425,0x426,0x42a,0x42b,0x42c", aicEvent);

    // feature
    std::string featureType = "switch";
    EXPECT_EQ(true, platform->CheckIfSupport(featureType));

    featureType = "ge_api";
    EXPECT_EQ(true, platform->CheckIfSupport(featureType));

    featureType = "task_trace";
    EXPECT_EQ(true, platform->CheckIfSupport(featureType));

    featureType = "aicpu";
    EXPECT_EQ(true, platform->CheckIfSupport(featureType));

    featureType = "l2";
    EXPECT_EQ(true, platform->CheckIfSupport(featureType));

    featureType = "hccl";
    EXPECT_EQ(true, platform->CheckIfSupport(featureType));

    featureType = "msproftx";
    EXPECT_EQ(true, platform->CheckIfSupport(featureType));

    featureType = "instr_profiling";
    EXPECT_EQ(true, platform->CheckIfSupport(featureType));

    featureType = "runtime_api";
    EXPECT_EQ(true, platform->CheckIfSupport(featureType));

    featureType = "ascendcl";
    EXPECT_EQ(true, platform->CheckIfSupport(featureType));

    featureType = "task_block";
    EXPECT_EQ(true, platform->CheckIfSupport(featureType));

    featureType = "sys_lp_freq";
    EXPECT_EQ(true, platform->CheckIfSupport(featureType));

    featureType = "training_trace";
    EXPECT_EQ(true, platform->CheckIfSupport(featureType));

    EXPECT_EQ(true, platform->CheckIfSupport(PLATFORM_COLLECTOR_ACP));

    std::string l2Switch = "on";
    std::string l2Events = "";
    std::string npuEvent = "";
    platform->L2CacheAdaptor(npuEvent, l2Switch, l2Events);
    EXPECT_EQ("0x00,0x88,0x89,0x8A,0x74,0x75,0x97", l2Events);
}

TEST_F(COMMON_PLATFORM_TEST, PlatformAnalyzerBase) {
    GlobalMockObject::verify();
    MOCKER_CPP(&Analysis::Dvvp::Common::Config::ConfigManager::GetPlatformType)
        .stubs()
        .will(returnValue(PlatformType::CHIP_V4_1_0))
        .then(returnValue(15));
    MOCKER_CPP(&Analysis::Dvvp::Common::Platform::AscendHalAdaptor::Init)
        .stubs()
        .will(returnValue(PROFILING_SUCCESS));
    Platform::instance()->Uninit();
    Platform::instance()->Init();
    std::string pmu = "ArithmeticUtilization";
    // check analyzer not init
    EXPECT_EQ(0, Platform::instance()->GetMetricsPmuNum(pmu));
    EXPECT_EQ("", Platform::instance()->GetMetricsTopName(pmu));
    EXPECT_EQ(nullptr, Platform::instance()->GetMetricsFunc(pmu, 0));
    // init analyzer
    EXPECT_EQ(PROFILING_SUCCESS, Platform::instance()->InitOnlineAnalyzer());
    std::string res = "";
    res = Platform::instance()->GetMetricsTopName(pmu);
    int32_t count = 0;
    size_t pos = res.find("mac_fp16_ratio"); // 0x49
    while (pos != std::string::npos) {
        count++;
        pos = res.find("mac_fp16_ratio", pos + 1);
    }
    EXPECT_EQ(2, count);
    EXPECT_NE(nullptr, Platform::instance()->GetMetricsFunc(pmu, 0));
    EXPECT_EQ(nullptr, Platform::instance()->GetMetricsFunc(pmu, 7));
    // check milan pmu partical
    pmu = "PipeUtilization";
    res = "";
    count = 0;
    res = Platform::instance()->GetMetricsTopName(pmu);
    pos = res.find("mac_fp_ratio"); // 0x416
    while (pos != std::string::npos) {
        count++;
        pos = res.find("mac_fp_ratio", pos + 1);
    }
    EXPECT_EQ(1, count);
    EXPECT_NE(nullptr, Platform::instance()->GetMetricsFunc(pmu, 0));
    EXPECT_NE(nullptr, Platform::instance()->GetMetricsFunc(pmu, 8));
    Platform::instance()->Uninit();
    // check platform not init
    // Platform::instance()->Init();
    EXPECT_EQ(PROFILING_FAILED, Platform::instance()->InitOnlineAnalyzer());
    EXPECT_EQ(0, Platform::instance()->GetMetricsPmuNum(pmu));
    EXPECT_EQ("", Platform::instance()->GetMetricsTopName(pmu));
    EXPECT_EQ(nullptr, Platform::instance()->GetMetricsFunc(pmu, 0));
    Platform::instance()->Uninit();
}

TEST_F(COMMON_PLATFORM_TEST, PlatformAnalyzerDavid) {
    GlobalMockObject::verify();
    MOCKER_CPP(&Analysis::Dvvp::Common::Config::ConfigManager::GetPlatformType)
        .stubs()
        .will(returnValue(PlatformType::CHIP_CLOUD_V3))
        .then(returnValue(17));
    MOCKER_CPP(&Analysis::Dvvp::Common::Platform::AscendHalAdaptor::Init)
        .stubs()
        .will(returnValue(PROFILING_SUCCESS));
    Platform::instance()->Init();
    std::string pmu = "L2Cache";
    // check analyzer not init
    EXPECT_EQ(0, Platform::instance()->GetMetricsPmuNum(pmu));
    EXPECT_EQ("", Platform::instance()->GetMetricsTopName(pmu));
    EXPECT_EQ(nullptr, Platform::instance()->GetMetricsFunc(pmu, 0));
    // init analyzer
    EXPECT_EQ(PROFILING_SUCCESS, Platform::instance()->InitOnlineAnalyzer());
    std::string res = "";
    res = Platform::instance()->GetMetricsTopName(pmu);
    int32_t count = 0;
    size_t pos = res.find("aic_bif_sc_pmu_ar_close_l2_miss_core");
    while (pos != std::string::npos) {
        count++;
        pos = res.find("aiv_bif_sc_pmu_ar_close_l2_miss_core", pos + 1);
    }
    EXPECT_EQ(2, count);
    EXPECT_NE(nullptr, Platform::instance()->GetMetricsFunc(pmu, 5));
    EXPECT_EQ(nullptr, Platform::instance()->GetMetricsFunc(pmu, 6));
    Platform::instance()->Uninit();
    // check platform not init
    Platform::instance()->Init();
    EXPECT_EQ(PROFILING_FAILED, Platform::instance()->InitOnlineAnalyzer());
    EXPECT_EQ(0, Platform::instance()->GetMetricsPmuNum(pmu));
    EXPECT_EQ("", Platform::instance()->GetMetricsTopName(pmu));
    EXPECT_EQ(nullptr, Platform::instance()->GetMetricsFunc(pmu, 0));
    Platform::instance()->Uninit();
}