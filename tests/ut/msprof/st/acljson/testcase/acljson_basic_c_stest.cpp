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
#include "gtest/gtest.h"
#include "mockcpp/mockcpp.hpp"
#include "mmpa_api.h"
#include "osal/osal.h"
#include "osal/osal_mem.h"
#include "errno/error_code.h"
#include "hal/hal_prof.h"
#include "hal/hal_dsmi.h"
#include "platform.h"
#include "platform_define.h"
#include "platform_table.h"
#include "platform_interface.h"
#include "platform_feature.h"
#include "chip/chip_nano_v1.h"
#include "json/json_parser.h"
#include "json/json_generator.h"
#include "securec.h"
#include "prof_api.h"
#include "thread_pool.h"
#include "channel_manager.h"
#include "param/profile_param.h"
#include "transport/uploader.h"
#include "flash_transport.h"

static const char C_RM_RF[] = "rm -rf ./acljsonCstest_workspace";
static const char C_MKDIR[] = "mkdir ./acljsonCstest_workspace";
static const char C_OUTPUT_DIR[] = "./acljsonCstest_workspace/output";

class BasicCStest: public testing::Test {
protected:
    virtual void SetUp()
    {
    }
    virtual void TearDown()
    {
        GlobalMockObject::verify();
    }
};

TEST_F(BasicCStest, PlatformBase)
{
    MOCKER(HalGetChipVersion)
        .stubs()
        .will(returnValue(uint32_t(PlatformType::CHIP_NANO_V1)));
    MOCKER(HalGetHostFreq)
        .stubs()
        .will(returnValue((uint64_t)10000));
    uint32_t count = 0;
    int32_t ret = PlatformInitialize(&count);
    EXPECT_EQ(ret, PROFILING_SUCCESS);
    MOCKER(HalGetDeviceFreq)
        .stubs()
        .will(returnValue((uint64_t)50000))
        .then(returnValue((uint64_t)0));
    // default device freq
    EXPECT_EQ(PlatformGetDefaultDevFreq(), (uint64_t)NANO_HWTS_DEFAULT_FREQ);
    // device freq
    EXPECT_EQ(PlatformGetDevFreq(0), 50);
    EXPECT_EQ(PlatformGetDevFreq(0), 50);
    // host freq
    EXPECT_EQ(PlatformGetHostFreq(), 10);
    // IsSupportBit
    EXPECT_EQ(IsSupportBit(PROF_AICORE_METRICS), true);
    EXPECT_EQ(IsSupportBit(PROF_AICPU_TRACE), false);
    // version info
    const char *versionInfo = PlatformGetVersionInfo();
    EXPECT_EQ(strcmp(versionInfo, "1.0"), 0);
    // default metrics
    char* metrics = PlatformGetDefaultMetrics();
    EXPECT_EQ(strcmp(metrics, "PipeUtilization"), 0);
    PlatformFinalize(&count);
    // not init
    EXPECT_EQ(IsSupportBit(PROF_AICORE_METRICS), false);
    EXPECT_EQ(PlatformGetHostFreq(), 0);
    EXPECT_EQ(PlatformGetDevFreq(0), 0);
    EXPECT_EQ(PlatformGetDefaultDevFreq(), 0);
    char* metrics2 = PlatformGetDefaultMetrics();
    EXPECT_EQ((metrics2 == NULL), true);
}

TEST_F(BasicCStest, MsprofSysCycleTimeBase)
{
    MOCKER(HalGetChipVersion)
        .stubs()
        .will(returnValue(uint32_t(PlatformType::CHIP_NANO_V1)));
    MOCKER(HalGetHostFreq)
        .stubs()
        .will(returnValue((uint32_t)10000));
    uint32_t count = 0;
    int32_t ret = PlatformInitialize(&count);
    EXPECT_EQ(ret, PROFILING_SUCCESS);
    EXPECT_EQ(PlatformHostFreqIsEnable(), true);

    MOCKER(PlatformHostFreqIsEnable)
        .stubs()
        .will(returnValue(true))
        .then(returnValue(false));
    uint64_t cycleTime = MsprofSysCycleTime();
    EXPECT_EQ((cycleTime > 0), true);
    cycleTime = MsprofSysCycleTime();
    EXPECT_EQ((cycleTime > 0), true);
}

void* MallocStubC(int size)
{
    return malloc(size);
}
int32_t g_mallocCCnt = 0;
void* MallocTestC(int size)
{
    void* ret = nullptr;
    if (g_mallocCCnt != 0) {
        ret = MallocStubC(size);
    }
    g_mallocCCnt--;
    return ret;
}

TEST_F(BasicCStest, ThreadPoolBase)
{
    GlobalMockObject::verify();
    int32_t ret = ProfThreadPoolInit(1000, 5, 20);
    EXPECT_EQ(ret, PROFILING_SUCCESS);
    ProfThreadPoolFinalize();

    MOCKER(OsalMalloc)
        .stubs()
        .will(invoke(MallocTestC));
    int32_t successCnt = 0;
    g_mallocCCnt = successCnt++;
    ret = ProfThreadPoolInit(1000, 5, 20);
    EXPECT_EQ(ret, PROFILING_FAILED);

    g_mallocCCnt = successCnt++;
    ret = ProfThreadPoolInit(1000, 5, 20);
    EXPECT_EQ(ret, PROFILING_FAILED);

    g_mallocCCnt = successCnt++;
    ret = ProfThreadPoolInit(1000, 5, 20);
    EXPECT_EQ(ret, PROFILING_FAILED);
    ProfThreadPoolFinalize();
}

TEST_F(BasicCStest, ChannelMgrFlushUnInit)
{
    GlobalMockObject::verify();
    EXPECT_EQ(GetChannelIdByIndex(0, 0), 0);
}

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

TEST_F(BasicCStest, FactoryCreateJobError)
{
    GlobalMockObject::verify();
    bool ret = false;
    if (FactoryCreateJob(0) == nullptr) {
        ret = true;
    }
    EXPECT_TRUE(ret);
}

TEST_F(BasicCStest, SliceBase)
{
    GlobalMockObject::verify();
    char* numStr = Slice("200MB", 3, 4);
    bool ret = false;
    if (numStr == nullptr) {
        ret = true;
    }
    EXPECT_EQ(ret, false);
    OSAL_MEM_FREE(numStr);
}

TEST_F(BasicCStest, CheckDataTypeBase)
{
    GlobalMockObject::verify();
    ProfileParam ut_profileParam = { 0 };
    uint32_t errorType = 100;
    const int32_t DEFSIZE = 4096;
    char data[DEFSIZE] = "{\"aic_metrics\":\"PipeStallCycle\",\"output\":\"./output_dir\",\"switch\":\"on\",\"task_trace\":\"off\"}";
    EXPECT_EQ(GenProfileParam(MSPROF_CTRL_INIT_ACL_JSON, data, sizeof(data), &ut_profileParam), PROFILING_SUCCESS);
    EXPECT_EQ(GenProfileParam(MSPROF_CTRL_INIT_GE_OPTIONS, data, sizeof(data), &ut_profileParam), PROFILING_SUCCESS);
    EXPECT_EQ(GenProfileParam(MSPROF_CTRL_INIT_HELPER, data, sizeof(data), &ut_profileParam), PROFILING_SUCCESS);
    EXPECT_EQ(GenProfileParam(MSPROF_CTRL_INIT_PURE_CPU, data, sizeof(data), &ut_profileParam), PROFILING_SUCCESS);
    EXPECT_EQ(GenProfileParam(UINT32_MAX, data, sizeof(data), &ut_profileParam), PROFILING_FAILED);
}

TEST_F(BasicCStest, StorageLimitBase)
{
    GlobalMockObject::verify();
    ProfileParam ut_profileParam = { 0 };
    uint32_t errorType = 100;
    const int32_t DEFSIZE = 4096;
    char data[DEFSIZE] = "{\"aic_metrics\":\"PipeUtilization\",\"output\":\"./output_dir\",\"switch\":\"on\",\"task_trace\":\"on\",\"storage_limit\":\"200MB\"}";
    EXPECT_EQ(GenProfileParam(MSPROF_CTRL_INIT_ACL_JSON, data, sizeof(data), &ut_profileParam), PROFILING_FAILED);
    MOCKER(IsSupportSwitch)
        .stubs()
        .will(returnValue(true));
    EXPECT_EQ(GenProfileParam(MSPROF_CTRL_INIT_ACL_JSON, data, sizeof(data), &ut_profileParam), PROFILING_SUCCESS);
}

TEST_F(BasicCStest, HalGetChipVersionBase)
{
    int64_t info = -1;
    MOCKER(halGetDeviceInfo)
        .stubs()
        .with(any(), any(), any(), outBoundP(&info, sizeof(info)))
        .will(returnValue(DRV_ERROR_INVALID_VALUE));
    EXPECT_EQ(0, HalGetChipVersion());
}

TEST_F(BasicCStest, HalGetHostFreqBase)
{
    int64_t info = 1;
    MOCKER(HalGetDeviceInfo)
        .stubs()
        .with(any(), any(), outBoundP(&info, sizeof(info)))
        .will(returnValue(PROFILING_SUCCESS));
    EXPECT_EQ(1, HalGetHostFreq());
}

TEST_F(BasicCStest, HalGetDeviceFreqBase)
{
    int64_t info = 1;
    MOCKER(HalGetDeviceInfo)
        .stubs()
        .with(any(), any(), outBoundP(&info, sizeof(info)))
        .will(returnValue(PROFILING_SUCCESS));
    EXPECT_EQ(1, HalGetDeviceFreq(0));
}

ProfFileChunk * CreateChunk(uint8_t deviceId, uint32_t chunkSize, FileChunkType type)
{
    ProfFileChunk *chunk = (ProfFileChunk *)OsalMalloc(sizeof(ProfFileChunk));
    chunk->deviceId = deviceId;
    chunk->chunkSize = chunkSize;
    chunk->chunkType = type;
    chunk->isLastChunk = false;
    chunk->offset = -1;
    chunk->chunk = (uint8_t*)OsalMalloc(MAX_READER_BUFFER_SIZE);
    (void)memset_s(chunk->fileName, sizeof(chunk->fileName), 0, sizeof(chunk->fileName));
    (void)sprintf_s(chunk->fileName, sizeof(chunk->fileName), "%s", "nano_stars_profile.data");
    return chunk;
}

TEST_F(BasicCStest, FlashSendBufferTest)
{
    const char* dir = "./";
    ProfFileChunk *chunk = CreateChunk(0, 1, PROF_DEVICE_DATA);
    EXPECT_EQ(FlashSendBuffer(chunk, dir), PROFILING_SUCCESS);

    ProfFileChunk *chunk2 = CreateChunk(64, 1, PROF_HOST_DATA);
    EXPECT_EQ(FlashSendBuffer(chunk2, dir), PROFILING_SUCCESS);

    ProfFileChunk *chunk3 = CreateChunk(64, 1, PROF_CTRL_DATA);
    EXPECT_EQ(FlashSendBuffer(chunk3, dir), PROFILING_SUCCESS);
}

TEST_F(BasicCStest, GetSelfPathTest)
{
    MOCKER(readlink)
        .stubs()
        .will(returnValue(-1))
        .then(returnValue(4097));
    MOCKER(strcpy_s)
        .stubs()
        .will(returnValue(0));
    EXPECT_EQ(false, GetSelfPath("./"));
}

TEST_F(BasicCStest, TestJsonMakeString)
{
    JsonObj *emptyObj = JsonInit();
    char *emptyStr = JsonToString(emptyObj);
    EXPECT_EQ(0, strcmp("null", emptyStr));
    JsonFree(emptyObj);
    free(emptyStr);

    JsonObj *subObj = JsonInit();
    subObj->SetValueByKey(subObj, "1", {"1", CJSON_STRING})
        ->SetValueByKey(subObj, "2", {"2", CJSON_STRING})
        ->SetValueByKey(subObj, "3", {"3", CJSON_STRING});

    JsonObj *arr = JsonInit();
    arr->AddArrayItem(arr, {{.intValue = 1}, .type = CJSON_INT})
        ->AddArrayItem(arr, {{.intValue = 2}, .type = CJSON_INT})
        ->AddArrayItem(arr, {{.intValue = 3}, .type = CJSON_INT});

    JsonObj *obj = JsonInit();
    obj->SetValueByKey(obj, "s", {"abc", CJSON_STRING})
        ->SetValueByKey(obj, "t", {{.boolValue = true}, .type = CJSON_BOOL})
        ->SetValueByKey(obj, "f", {{.boolValue = false}, .type = CJSON_BOOL})
        ->SetValueByKey(obj, "i", {{.intValue = 123}, .type = CJSON_INT})
        ->SetValueByKey(obj, "d", {{.doubleValue = 1.5}, .type = CJSON_DOUBLE})
        ->SetValueByKey(obj, "a", *arr)
        ->SetValueByKey(obj, "o", *subObj);

    JsonObj *objPtr = obj;
    objPtr->TravelByKey(&objPtr, "o")->SetValueByKey(objPtr, "1", {{.intValue = 111}, .type = CJSON_INT});
    EXPECT_EQ(CJSON_OBJ, objPtr->type);

    char *json3 = JsonToString(obj);
    char *expectJson = "{\"a\":[1,2,3],\"d\":1.5,\"f\":false,\"i\":123,\"o\":{\"1\":111,\"2\":\"2\",\"3\":\"3\"},\"s\":"
                       "\"abc\",\"t\":true}";
    EXPECT_EQ(0, strcmp(expectJson, json3));

    // test Contains
    EXPECT_EQ(true, obj->Contains(obj, "s"));
    EXPECT_EQ(false, obj->Contains(obj, "not_exist"));

    // test GetValueByKey
    void *notExist = obj->GetValueByKey(obj, "not_exist");
    EXPECT_EQ(NULL, notExist);
    const char *gotStr = obj->GetValueByKey(obj, "s")->stringValue;
    EXPECT_EQ(0, strcmp("abc", gotStr));
    int64_t gotInt = obj->GetValueByKey(obj, "i")->intValue;
    EXPECT_EQ(123, gotInt);
    bool gotTrue = obj->GetValueByKey(obj, "t")->boolValue;
    EXPECT_EQ(true, gotTrue);
    double gotDouble = obj->GetValueByKey(obj, "d")->doubleValue;
    EXPECT_EQ(1.5, gotDouble);

    free(json3);
    JsonFree(subObj);
    JsonFree(arr);
    JsonFree(obj);
}