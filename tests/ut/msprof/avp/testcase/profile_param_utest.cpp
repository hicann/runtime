/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include <iostream>
#include <fstream>
#include "json/json_parser.h"
#include "gtest/gtest.h"
#include "mockcpp/mockcpp.hpp"
#include "mmpa_api.h"
#include "osal/osal.h"
#include "data_manager.h"
#include "toolchain/prof_api.h"
#include "errno/error_code.h"
#include "osal/osal.h"
#include "platform_feature.h"
#include "platform.h"
#include "utils/utils.h"
#include "hal/hal_dsmi.h"

extern "C" {
    #define DEFAULT_PROFILING_INTERVAL_10MS 10
    #define DEFAULT_OUTPUT_MAX_LEGTH 512
    #define DEFAULT_FEATURES_BYTE_MAP 5
    #define DEFAULT_MAX_BYTE_LENGTH 31
    #define STORAGE_MINIMUM_LENGTH 5

    static const PlatformFeature featureList[] = {
        // 模拟platform当前支持的参数
        PLATFORM_TASK_ASCENDCL,
        PLATFORM_TASK_SWITCH,
        PLATFORM_TASK_AIC_METRICS,
        PLATFORM_TASK_AIV_METRICS,
        PLATFORM_TASK_TS_TIMELINE,
        PLATFORM_TASK_STARS_ACSQ,
        PLATFORM_TASK_TS_KEYPOINT,
        PLATFORM_TASK_AIC_HWTS,
        PLATFORM_TASK_TS_MEMCPY,
        PLATFORM_TASK_RUNTIME_TRACE,
        PLATFORM_TASK_RUNTIME_API
    };

    typedef struct {
        char aiCoreMetrics[32];
        PlatformFeature feature;
    } MetricsMap;

    static const MetricsMap metricsMap[5] = {
        // 模拟platform当前支持的参数
        {"PipeUtilization", PLATFORM_TASK_PU_PMU},
        {"PipeStallCycle", PLATFORM_TASK_PSC_PMU},
        {"Memory", PLATFORM_TASK_MEMORY_PMU},
        {"MemoryUB", PLATFORM_TASK_MEMORYUB_PMU},
        {"ScalarRatio", PLATFORM_TASK_SCALAR_RATIO_PMU}
    };

    static const PlatformFeature DefaultSwitchList[] = {
        // 设置默认开启的开关
        PLATFORM_TASK_ASCENDCL,
        PLATFORM_TASK_AIC_METRICS,
        PLATFORM_TASK_AIV_METRICS,
        PLATFORM_TASK_TS_TIMELINE,
        PLATFORM_TASK_TS_MEMCPY,
        PLATFORM_TASK_RUNTIME_TRACE,
        PLATFORM_TASK_TS_KEYPOINT,
        PLATFORM_TASK_STARS_ACSQ,
        PLATFORM_TASK_AIC_HWTS,
        PLATFORM_TASK_RUNTIME_API
    };

    typedef struct {
        uint32_t features[DEFAULT_FEATURES_BYTE_MAP]; // 31 * DEFAULT_FEATURES_BYTE_MAP
        uint32_t aicSamplingInterval;
        uint32_t aivSamplingInterval;
        uint32_t hostPid;
        int32_t jobId;
        char storageLimit[16]; // 4294967295MB
        char taskTrace[4];
        char resultDir[DEFAULT_OUTPUT_MAX_LEGTH];
        char aiCoreMetrics[32];
        char aicEvents[128];
        char aiCoreProfilingMode[16];
        char aiVectMetrics[32];
        char aivEvents[128];
        char aiVectProfilingMode[16];
        char profLevel[8];
    } ParmasList;

    typedef struct {
        bool hostProfiling;   // 标识是否启用host侧的采集任务
        bool deviceProfiling; // 标识是否启用host侧的采集任务
        uint64_t dataTypeConfig;
        ParmasList config;
    } ProfileParam;
    bool IsSwitch(PlatformFeature feature);
    bool IsEnable(ParmasList *param, PlatformFeature feature);
    int32_t GenProfileParam(uint32_t dataType, OsalVoidPtr data, uint32_t dataLength, ProfileParam *param);
    CHAR* Slice(CHAR* str, int32_t start, int32_t end);
}

class ProfileParamUtest: public testing::Test {
protected:
    virtual void SetUp()
    {
        MOCKER(HalGetChipVersion)
            .stubs()
            .will(returnValue(uint32_t(CHIP_NANO_V1)));
    }
    virtual void TearDown()
    {
        GlobalMockObject::verify();
    }
};

TEST_F(ProfileParamUtest, AclJsonParamTest)
{
    uint32_t dataType = MSPROF_CTRL_INIT_ACL_JSON;
    const int32_t DEFSIZE = 4096;
    char data[DEFSIZE] = "{\"aic_metrics\":\"PipeUtilization\",\"output\":\"./output_dir\",\"switch\":\"on\",\"task_trace\":\"on\"}";
    EXPECT_EQ(MsprofInit(dataType, data, sizeof(data)), PROFILING_SUCCESS);
    MsprofFinalize();
    // 默认output
    strcpy_s(data, DEFSIZE, "{\"aic_metrics\":\"PipeUtilization\",\"switch\":\"on\"}");
    EXPECT_EQ(MsprofInit(dataType, data, sizeof(data)), PROFILING_SUCCESS);
    MsprofFinalize();
    // 输入不支持的参数
    strcpy_s(data, DEFSIZE, "{\"aiv\":\"PipeUtilization\",\"switch\":\"on\"}");
    EXPECT_EQ(MsprofInit(dataType, data, sizeof(data)), PROFILING_FAILED);
    MsprofFinalize();
    // 输入异常参数配置
    strcpy_s(data, DEFSIZE, "{\"aic_metrics\":\"Pipe\",\"switch\":\"on\"}");
    EXPECT_EQ(MsprofInit(dataType, data, sizeof(data)), PROFILING_FAILED);
    MsprofFinalize();
    // aicMetrics测试
    strcpy_s(data, DEFSIZE, "{\"aic_metrics\":\"ttk\",\"switch\":\"on\"}");
    EXPECT_EQ(MsprofInit(dataType, data, sizeof(data)), PROFILING_FAILED);
    MsprofFinalize();
    strcpy_s(data, DEFSIZE, "{\"aic_metrics\":\"PipeUtilization\",\"switch\":\"on\"}");
    EXPECT_EQ(MsprofInit(dataType, data, sizeof(data)), PROFILING_SUCCESS);
    MsprofFinalize();
    strcpy_s(data, DEFSIZE, "{\"aic_metrics\":\"PipeStallCycle\",\"switch\":\"on\"}");
    EXPECT_EQ(MsprofInit(dataType, data, sizeof(data)), PROFILING_SUCCESS);
    MsprofFinalize();
    strcpy_s(data, DEFSIZE, "{\"aic_metrics\":\"Memory\",\"switch\":\"on\"}");
    EXPECT_EQ(MsprofInit(dataType, data, sizeof(data)), PROFILING_SUCCESS);
    MsprofFinalize();
    strcpy_s(data, DEFSIZE, "{\"aic_metrics\":\"MemoryUB\",\"switch\":\"on\"}");
    EXPECT_EQ(MsprofInit(dataType, data, sizeof(data)), PROFILING_SUCCESS);
    MsprofFinalize();
    strcpy_s(data, DEFSIZE, "{\"aic_metrics\":\"ScalarRatio\",\"switch\":\"on\"}");
    EXPECT_EQ(MsprofInit(dataType, data, sizeof(data)), PROFILING_SUCCESS);
    MsprofFinalize();
 
    // task_trace测试
    strcpy_s(data, DEFSIZE, "{\"task_trace\":\"ttk\",\"switch\":\"on\"}");
    EXPECT_EQ(MsprofInit(dataType, data, sizeof(data)), PROFILING_FAILED);
    MsprofFinalize();
    strcpy_s(data, DEFSIZE, "{\"task_trace\":\"l0\",\"switch\":\"on\"}");
    EXPECT_EQ(MsprofInit(dataType, data, sizeof(data)), PROFILING_SUCCESS);
    MsprofFinalize();
    strcpy_s(data, DEFSIZE, "{\"task_trace\":\"l1\",\"switch\":\"on\"}");
    EXPECT_EQ(MsprofInit(dataType, data, sizeof(data)), PROFILING_SUCCESS);
    MsprofFinalize();
    strcpy_s(data, DEFSIZE, "{\"task_trace\":\"l2\",\"switch\":\"on\"}");
    EXPECT_EQ(MsprofInit(dataType, data, sizeof(data)), PROFILING_SUCCESS);
    MsprofFinalize();
    strcpy_s(data, DEFSIZE, "{\"task_trace\":\"on\",\"switch\":\"on\"}");
    EXPECT_EQ(MsprofInit(dataType, data, sizeof(data)), PROFILING_SUCCESS);
    MsprofFinalize();
    strcpy_s(data, DEFSIZE, "{\"task_trace\":\"off\",\"switch\":\"on\"}");
    EXPECT_EQ(MsprofInit(dataType, data, sizeof(data)), PROFILING_SUCCESS);
    MsprofFinalize();
}

TEST_F(ProfileParamUtest, AclProfileParam)
{
    uint32_t count = 0;
    int32_t ret = PlatformInitialize(&count);
    EXPECT_EQ(ret, PROFILING_SUCCESS);
    ProfileParam ut_profileParam;
    uint32_t aclType = MSPROF_CTRL_INIT_ACL_JSON;
    uint32_t errorType = 100;
    const int32_t DEFSIZE = 4096;
    char data[DEFSIZE] = "{\"aic_metrics\":\"PipeStallCycle\",\"output\":\"./output_dir\",\"switch\":\"on\",\"task_trace\":\"off\"}";
    EXPECT_EQ(GenProfileParam(aclType, data, sizeof(data), &ut_profileParam), PROFILING_SUCCESS);

    EXPECT_EQ(strcmp(ut_profileParam.config.taskTrace, "off"), 0);
    EXPECT_EQ(strcmp(ut_profileParam.config.profLevel, "off"), 0);
    EXPECT_EQ(strcmp(ut_profileParam.config.aiCoreMetrics, "PipeStallCycle"), 0);
    EXPECT_EQ(strcmp(ut_profileParam.config.aicEvents, "0x406,0x305,0x600,0x601,0x602,0x603,0x604,0x605,0x606,0x607"), 0);
    EXPECT_EQ(strcmp(ut_profileParam.config.aiCoreProfilingMode, "task-based"), 0);
    EXPECT_EQ(ut_profileParam.config.aicSamplingInterval, 10);
    EXPECT_EQ(strcmp(ut_profileParam.config.aiVectMetrics, "PipeStallCycle"), 0);
    EXPECT_EQ(strcmp(ut_profileParam.config.aivEvents, "0x406,0x305,0x600,0x601,0x602,0x603,0x604,0x605,0x606,0x607"), 0);
    EXPECT_EQ(strcmp(ut_profileParam.config.aiVectProfilingMode, "task-based"), 0);
    EXPECT_EQ(ut_profileParam.config.aivSamplingInterval, 10);

    EXPECT_FALSE(IsEnable(&ut_profileParam.config, PLATFORM_TASK_TS_TIMELINE));
    EXPECT_FALSE(IsEnable(&ut_profileParam.config, PLATFORM_TASK_STARS_ACSQ));
    EXPECT_FALSE(IsEnable(&ut_profileParam.config, PLATFORM_TASK_AIC_HWTS));
    EXPECT_FALSE(IsEnable(&ut_profileParam.config, PLATFORM_TASK_RUNTIME_TRACE));

    EXPECT_TRUE(IsEnable(&ut_profileParam.config, PLATFORM_TASK_ASCENDCL));
    EXPECT_TRUE(IsEnable(&ut_profileParam.config, PLATFORM_TASK_AIC_METRICS));
    EXPECT_TRUE(IsEnable(&ut_profileParam.config, PLATFORM_TASK_AIV_METRICS));
    EXPECT_TRUE(IsEnable(&ut_profileParam.config, PLATFORM_TASK_TS_KEYPOINT));
    EXPECT_TRUE(IsEnable(&ut_profileParam.config, PLATFORM_TASK_RUNTIME_API));
    EXPECT_TRUE(IsEnable(&ut_profileParam.config, PLATFORM_TASK_TS_MEMCPY));

    // 异常
    EXPECT_FALSE(IsEnable(&ut_profileParam.config, PLATFORM_SYS_HOST_SYS_MEM));
    EXPECT_FALSE(IsEnable(&ut_profileParam.config, (PlatformFeature)10));
    PlatformFinalize(&count);
}

TEST_F(ProfileParamUtest, GeProfileParam)
{
    uint32_t count = 0;
    int32_t ret = PlatformInitialize(&count);
    EXPECT_EQ(ret, PROFILING_SUCCESS);
    ProfileParam ut_profileParam;
    uint32_t geType = MSPROF_CTRL_INIT_GE_OPTIONS;
    uint32_t errorType = 100;
    const int32_t DEFSIZE = 4096;
    char data[DEFSIZE] = "{\"aic_metrics\":\"PipeUtilization\",\"output\":\"./output_dir\",\"switch\":\"on\",\"task_trace\":\"on\",\"storage_limit\":\"200MB\"}";
    EXPECT_EQ(GenProfileParam(geType, data, sizeof(data), &ut_profileParam), PROFILING_FAILED);
    MOCKER(IsSupportSwitch)
        .stubs()
        .will(returnValue(true));
    EXPECT_EQ(GenProfileParam(geType, data, sizeof(data), &ut_profileParam), PROFILING_SUCCESS);
    PlatformFinalize(&count);
}

TEST_F(ProfileParamUtest, HelperProfileParam)
{
    uint32_t count = 0;
    int32_t ret = PlatformInitialize(&count);
    EXPECT_EQ(ret, PROFILING_SUCCESS);
    ProfileParam ut_profileParam;
    uint32_t helperType = MSPROF_CTRL_INIT_HELPER;
    uint32_t errorType = 100;
    const int32_t DEFSIZE = 4096;
    char data[DEFSIZE] = "{\"aic_metrics\":\"PipeUtilization\",\"output\":\"./output_dir\",\"switch\":\"on\",\"task_trace\":\"on\"}";
    EXPECT_EQ(GenProfileParam(helperType, data, sizeof(data), &ut_profileParam), PROFILING_SUCCESS);
    PlatformFinalize(&count);
}

TEST_F(ProfileParamUtest, PureCpuProfileParam)
{
    uint32_t count = 0;
    int32_t ret = PlatformInitialize(&count);
    EXPECT_EQ(ret, PROFILING_SUCCESS);
    ProfileParam ut_profileParam;
    uint32_t PureType = MSPROF_CTRL_INIT_PURE_CPU;
    uint32_t errorType = 100;
    const int32_t DEFSIZE = 4096;
    char data[DEFSIZE] = "{\"aic_metrics\":\"PipeUtilization\",\"output\":\"./output_dir\",\"switch\":\"on\",\"task_trace\":\"on\"}";
    EXPECT_EQ(GenProfileParam(PureType, data, sizeof(data), &ut_profileParam), PROFILING_SUCCESS);
    PlatformFinalize(&count);
}

TEST_F(ProfileParamUtest, OtherProfileParam)
{
    uint32_t count = 0;
    int32_t ret = PlatformInitialize(&count);
    EXPECT_EQ(ret, PROFILING_SUCCESS);
    ProfileParam ut_profileParam;
    uint32_t OtherType = MSPROF_CTRL_INIT_DYNA;
    uint32_t errorType = 100;
    const int32_t DEFSIZE = 4096;
    char data[DEFSIZE] = "{\"aic_metrics\":\"PipeUtilization\",\"output\":\"./output_dir\",\"switch\":\"on\",\"task_trace\":\"on\"}";
    EXPECT_EQ(GenProfileParam(OtherType, data, sizeof(data), &ut_profileParam), PROFILING_FAILED);
    PlatformFinalize(&count);
}

TEST_F(ProfileParamUtest, CreateMapFailed)
{
    uint32_t count = 0;
    int32_t ret = PlatformInitialize(&count);
    EXPECT_EQ(ret, PROFILING_SUCCESS);
    ProfileParam ut_profileParam;
    uint32_t profType = MSPROF_CTRL_INIT_ACL_JSON;
    const int32_t DEFSIZE = 4096;
    char data[DEFSIZE] = "{\"aic_metrics\":\"PipeUtilization\",\"output\":\"./output_dir\",\"switch\":\"on\",\"task_trace\":\"on\"}";
    
    MOCKER(JsonParse)
        .stubs()
        .will(returnValue((JsonObj*)NULL));
    EXPECT_EQ(GenProfileParam(profType, data, sizeof(data), &ut_profileParam), PROFILING_FAILED);
    PlatformFinalize(&count);
}

TEST_F(ProfileParamUtest, TestSlice)
{
    char *str = "aaa bbb";
    char * ret = Slice(str, 0, 4);
    EXPECT_EQ(0, strcmp(ret, "aaa b"));
    free(ret);
}