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
#include "errno/error_code.h"
#include "channel/channel_manager.h"
#include "param/profile_param.h"
#include "hal/hal_prof.h"

class JobManagerUtest: public testing::Test {
protected:
    virtual void SetUp()
    {
    }
    virtual void TearDown()
    {
    }
};

extern "C" {
typedef struct ICollectionJob {
    int32_t channelId;
    int32_t devId;
    int32_t jobId;
    const ProfileParam *params;
    int32_t (*Init)(struct ICollectionJob*);
    int32_t (*Process)(struct ICollectionJob*);
    int32_t (*Uninit)(struct ICollectionJob*);
} ICollectionJob;
typedef struct {
    bool isStart;
    bool quit;
    uint32_t deviceId;
    const ProfileParam *params;
    ICollectionJob* collectionJobs[PROF_CHANNEL_MAX];
} JobManagerAttribute;
#define NANO_PMU_EVENT_MAX_NUM 10
typedef struct {
    uint32_t tag;                                  // 0-enable immediately, 1-enable delay
    uint32_t eventNum;                             // PMU count
    uint16_t event[NANO_PMU_EVENT_MAX_NUM];        // PMU value
} TagNanoStarsProfileConfig;
typedef struct {
    ICollectionJob baseJob;
} NanoStarsJobAttribute;

ICollectionJob* FactoryCreateJob(int32_t channelId);
int32_t JobManagerStart(JobManagerAttribute *attr);
int32_t JobManagerStop(JobManagerAttribute *attr);
int32_t NanoJobInit(ICollectionJob *attr);
int32_t NanoJobProcess(ICollectionJob *attr);
int32_t NanoJobUninit(ICollectionJob *attr);
}

TEST_F(JobManagerUtest, JobManager)
{
    ParmasList config = {
        .features = {0}, 
        .aicSamplingInterval = 100,
        .aivSamplingInterval = 100,
        .hostPid = 1,
        .jobId = 1,
        "1",              
        "on",  //taskTrace
        "/output", //resultDir
        "", //aiCoreMetrics
        "0x103,0x104,0x105", //aicEvents
        "", //aiCoreProfilingMode
        "", //aiVectMetrics
        "", //aivEvents
        "", //aiVectProfilingMode
        "", //profLevel
    };
    ProfileParam myParam = {
        .hostProfiling = false,
        .deviceProfiling = true,
        .dataTypeConfig = 0,
        .config = config
    };
    MOCKER(prof_drv_start).stubs().will(returnValue(PROF_OK));
    MOCKER(prof_stop).stubs().will(returnValue(PROFILING_SUCCESS));
    JobManagerAttribute* jobManager = (JobManagerAttribute*) malloc (sizeof (JobManagerAttribute));
    jobManager->isStart = false;
    jobManager->quit = true;
    jobManager->deviceId = 0;
    jobManager->params = &myParam;
    // Device job is not support
    myParam.hostProfiling = true;
    EXPECT_EQ(PROFILING_SUCCESS, JobManagerStart(jobManager));

    myParam.hostProfiling = false;
    jobManager->isStart = false;
    MOCKER(prof_drv_get_channels).stubs().will(returnValue(PROF_OK));
    MOCKER(ChannelMgrInitialize).stubs().will(returnValue(PROFILING_SUCCESS));
    EXPECT_EQ(PROFILING_SUCCESS, JobManagerStart(jobManager));
    EXPECT_EQ(PROFILING_SUCCESS, JobManagerStop(jobManager));

    jobManager->isStart = true;
    EXPECT_EQ(PROFILING_FAILED, JobManagerStart(jobManager));
    free(jobManager);
}

TEST_F(JobManagerUtest, NanoStarsJob)
{
    ParmasList config = {
        .features = {0}, 
        .aicSamplingInterval = 100,
        .aivSamplingInterval = 100,
        .hostPid = 1,
        .jobId = 1,
        "1",              
        "on",  //taskTrace
        "/output", //resultDir
        "", //aiCoreMetrics
        "0x103,0x104,0x105", //aicEvents
        "", //aiCoreProfilingMode
        "", //aiVectMetrics
        "", //aivEvents
        "", //aiVectProfilingMode
        "", //profLevel
    };
    ProfileParam myParam = {
        .hostProfiling = false,
        .deviceProfiling = true,
        .dataTypeConfig = 0,
        .config = config
    };

    ICollectionJob* job = FactoryCreateJob(150);
    job->params = &myParam;
    job->devId = 0;
    EXPECT_EQ(PROFILING_SUCCESS, job->Init(job));
    EXPECT_EQ(PROFILING_SUCCESS, job->Process(job));
    EXPECT_EQ(PROFILING_SUCCESS, job->Uninit(job));

    myParam.hostProfiling = true;
    EXPECT_EQ(PROFILING_FAILED, job->Init(job));

    EXPECT_EQ(PROFILING_SUCCESS, NanoJobProcess(job));

    strncpy(myParam.config.aicEvents, "dsfasd", sizeof(myParam.config.aicEvents));
    EXPECT_EQ(PROFILING_FAILED, NanoJobProcess(job));
    strncpy(myParam.config.aicEvents, "", sizeof(myParam.config.aicEvents));
    EXPECT_EQ(PROFILING_FAILED, NanoJobProcess(job));

    free(job);
}
