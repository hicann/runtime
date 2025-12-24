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
#include <memory>
#include <nlohmann/json.hpp>
#include "gtest/gtest.h"
#include "mockcpp/mockcpp.hpp"
#include "device_simulator_manager.h"
#include "errno/error_code.h"
#include "msprof_start.h"
#include "mmpa_api.h"
#include "data_manager.h"
#include "osal/osal.h"
#include "osal/osal_mem.h"
#include "osal/osal_linux.h"
#include "osal/osal_thread.h"
#include "utils/utils.h"
#include "hal_dsmi.h"
#include "hal_prof.h"
#include "ascend_hal.h"
#include "cstl/cstl_list.h"
#include "domain/transport/transport.h"
#include "json/info_json.h"
#include "json/json_parser.h"
#include "json/sort_vector.h"
#include "json/vector.h"
#include "report/report_manager.h"
#include "report/hash_dic.h"
#include "report/report_buffer_mgr.h"
#include "domain/transport/uploader.h"
#include "param/profile_param.h"
#include "job/collection_job.h"

#define VECTOR_BASIC_STEP 8

static const char NANOC_RM_RF[] = "rm -rf ./acljsonnanostest_workspace";
static const char NANOC_MKDIR[] = "mkdir ./acljsonnanostest_workspace";
static const char NANOC_OUTPUT_DIR[] = "./acljsonnanostest_workspace/output";

class AclJsonNanoCStest: public testing::Test {
protected:
    virtual void SetUp()
    {
        DlStub();
        const ::testing::TestInfo* curTest = ::testing::UnitTest::GetInstance()->current_test_info();
        DataMgr().Init("", "acljson");
        optind = 1;
        system(NANOC_RM_RF);
        system(NANOC_MKDIR);
        EXPECT_EQ(2, SimulatorMgr().CreateDeviceSimulator(2, StPlatformType::CHIP_NANO_V1));
    }
    virtual void TearDown()
    {
        GlobalMockObject::verify();
        EXPECT_EQ(2, SimulatorMgr().DelDeviceSimulator(2, StPlatformType::CHIP_NANO_V1));
        DataMgr().UnInit();
        MsprofMgr().UnInit();
        system(NANOC_RM_RF);
    }
    void DlStub()
    {
        MOCKER(dlopen).stubs().will(invoke(mmDlopen));
        MOCKER(dlsym).stubs().will(invoke(mmDlsym));
        MOCKER(dlclose).stubs().will(invoke(mmDlclose));
        MOCKER(dlerror).stubs().will(invoke(mmDlerror));
    }
};

extern "C" {
    typedef struct {
        bool isStart;
        bool quit;
        uint32_t deviceId;
        const ProfileParam *params;
        ICollectionJob* collectionJobs[1];
    } JobManagerAttribute;
    int32_t JobManagerStart(JobManagerAttribute *attr);
    int32_t JobManagerStop(JobManagerAttribute *attr);
}

TEST_F(AclJsonNanoCStest, TestStartThreadFailed)
{
    nlohmann::json data;
    data["output"] = NANOC_OUTPUT_DIR;
    MOCKER(pthread_attr_init)
        .stubs().
        will(returnValue(1));
    EXPECT_EQ(-1, MsprofMgr().AclJsonStart(0, data));
}

uint32_t g_osalJoinTime = 0;
uint32_t GetJoinCount()
{
    return g_osalJoinTime;
}

int32_t LinuxJoinTaskStub(OsalThread *threadHandle)
{
    g_osalJoinTime++;
    pthread_join(*threadHandle, NULL);
    return OSAL_EN_ERROR;
}

TEST_F(AclJsonNanoCStest, TestJoinThreadFailed)
{
    nlohmann::json data;
    data["output"] = NANOC_OUTPUT_DIR;
    MOCKER(LinuxJoinTask)
        .stubs().
        will(invoke(LinuxJoinTaskStub));
    EXPECT_EQ(0, MsprofMgr().AclJsonStart(0, data));
    EXPECT_EQ(0, GetJoinCount());
}

int MemsetStub(void *dest, int dest_max, int c, int count)
{
    memset(dest, 0, count);
    return 0;
}
int g_memsetSuccessCnt = 0;
int MemsetTest(void *dest, int dest_max, int c, int count)
{
    int32_t ret = -1;
    if (g_memsetSuccessCnt != 0) {
        ret = MemsetStub(dest, dest_max, c, count);
    } 
    g_memsetSuccessCnt--;
    return ret;
}

TEST_F(AclJsonNanoCStest, TestMemsetFailed)
{
    nlohmann::json data;
    data["output"] = NANOC_OUTPUT_DIR;
    int32_t successCnt = 5;
    MOCKER(memset_s).stubs().will(invoke(MemsetTest));
    MOCKER(CreateInfoJson).stubs().will(returnValue(PROFILING_SUCCESS));
    MOCKER(SaveTypeInfoData).stubs();
    // Failed to malloc threadId of threadPool
    printf("1 test memset============================================\n");
    g_memsetSuccessCnt = successCnt++;
    EXPECT_EQ(-1, MsprofMgr().AclJsonStart(0, data));
    // Failed to calloc uploaderList
    printf("2 test memset============================================\n");
    g_memsetSuccessCnt = successCnt++;
    EXPECT_EQ(-1, MsprofMgr().AclJsonStart(0, data));
    // host
    // Failed to calloc for uploader
    printf("3 test memset============================================\n");
    successCnt += 33;
    g_memsetSuccessCnt = successCnt;
    EXPECT_EQ(-1, MsprofMgr().AclJsonStart(0, data));
    // Failed to malloc transport for uploader
    printf("4 test memset============================================\n");
    g_memsetSuccessCnt = successCnt++;
    EXPECT_EQ(-1, MsprofMgr().AclJsonStart(0, data));
    // Failed to malloc data queue for uploader
    printf("5 test memset============================================\n");
    g_memsetSuccessCnt = successCnt++;
    EXPECT_EQ(-1, MsprofMgr().AclJsonStart(0, data));
}

void* MallocStub(int size)
{
    return malloc(size);
}
int g_mallocSuccessCnt = 0;
void* MallocTest(int size)
{
    void* ret = nullptr;
    if (g_mallocSuccessCnt != 0) {
        ret = MallocStub(size);
    } 
    g_mallocSuccessCnt--;
    return ret;
}
 
int StrcpyStub(char* strDest,int destMax,const char* strSrc)
{
    strcpy(strDest, strSrc);
    return 0;
}
int g_strcpySuccessCnt = 0;
int StrcpyTest(char* strDest,int destMax,const char* strSrc)
{
    int ret = -1;
    if (g_strcpySuccessCnt != 0) {
        ret = StrcpyStub(strDest, destMax, strSrc);
    } 
    g_strcpySuccessCnt--;
    return ret;
}

TEST_F(AclJsonNanoCStest, TestStrcpyFailed)
{
    nlohmann::json data;
    data["output"] = NANOC_OUTPUT_DIR;
    int32_t cnt = 6;
    MOCKER(strcpy_s).stubs().will(invoke(StrcpyTest));
    for (int i = 0; i < cnt; i++) {
        g_strcpySuccessCnt = i;
        EXPECT_EQ(-1, MsprofMgr().AclJsonStart(0, data));
    }
}

TEST_F(AclJsonNanoCStest, TestChannelPollFailedOne)
{
    nlohmann::json data;
    data["output"] = NANOC_OUTPUT_DIR;
    MOCKER(prof_channel_poll).stubs().will(returnValue(PROF_ERROR));
    std::vector<std::string> dataList = {};
    std::vector<std::string> blackDataList = {"nano_stars_profile.data"};
    MsprofMgr().SetDeviceCheckList(dataList, blackDataList);
    EXPECT_EQ(0, MsprofMgr().AclJsonStart(0, data));
}

TEST_F(AclJsonNanoCStest, TestChannelPollFailedTwo)
{
    nlohmann::json data;
    data["output"] = NANOC_OUTPUT_DIR;
    MOCKER(prof_channel_poll).stubs().will(returnValue(PROF_STOPPED_ALREADY));
    std::vector<std::string> dataList = {};
    std::vector<std::string> blackDataList = {"nano_stars_profile.data"};
    MsprofMgr().SetDeviceCheckList(dataList, blackDataList);
    EXPECT_EQ(0, MsprofMgr().AclJsonStart(0, data));
}

TEST_F(AclJsonNanoCStest, TestChannelReadFailed)
{
    nlohmann::json data;
    data["output"] = NANOC_OUTPUT_DIR;
    MOCKER(prof_channel_read).stubs().will(returnValue(-1));
    std::vector<std::string> dataList = {};
    std::vector<std::string> blackDataList = {"nano_stars_profile.data"};
    MsprofMgr().SetDeviceCheckList(dataList, blackDataList);
    EXPECT_EQ(0, MsprofMgr().AclJsonStart(0, data));
}

TEST_F(AclJsonNanoCStest, TestOsalMallocFailed)
{
    nlohmann::json data;
    data["output"] = NANOC_OUTPUT_DIR;
    MOCKER(OsalMalloc).stubs().will(invoke(MallocTest));
    MOCKER(SaveTypeInfoData).stubs();
    MOCKER(SaveHashData).stubs();
    MOCKER(AddCompactNode).stubs();
    MOCKER(AddAdditionalNode).stubs();
    MOCKER(DumpApi).stubs();
    MOCKER(DumpCompact).stubs();
    MOCKER(DumpAdditional).stubs();
    MOCKER(JobManagerStart).stubs().will(returnValue(PROFILING_SUCCESS));
    MOCKER(JobManagerStop).stubs().will(returnValue(PROFILING_SUCCESS));
    int32_t successCnt = 0;
    printf("1 test============================================\n");
    // Failed to calloc for platform interface
    g_mallocSuccessCnt = successCnt;
    EXPECT_EQ(-1, MsprofMgr().AclJsonStart(0, data));
    printf("2 test============================================\n");
    // JsonObj malloc failed
    g_mallocSuccessCnt = successCnt++;
    g_mallocSuccessCnt = successCnt++;
    EXPECT_EQ(-1, MsprofMgr().AclJsonStart(0, data));
    printf("3 test============================================\n");
    // string malloc failed
    g_mallocSuccessCnt = successCnt++;
    EXPECT_EQ(-1, MsprofMgr().AclJsonStart(0, data));
    printf("4 test============================================\n");
    // string malloc failed
    g_mallocSuccessCnt = successCnt++;
    EXPECT_EQ(-1, MsprofMgr().AclJsonStart(0, data));
    printf("5 test============================================\n");
    // Parse json failed
    g_mallocSuccessCnt = successCnt++;
    EXPECT_EQ(-1, MsprofMgr().AclJsonStart(0, data));
    printf("6 test============================================\n");
    // string malloc failed
    g_mallocSuccessCnt = successCnt++;
    EXPECT_EQ(-1, MsprofMgr().AclJsonStart(0, data));
    printf("7 test============================================\n");
    // string malloc failed
    g_mallocSuccessCnt = successCnt++;
    EXPECT_EQ(-1, MsprofMgr().AclJsonStart(0, data));
    printf("8 test============================================\n");
    // Init host report failed
    successCnt += 28;
    g_mallocSuccessCnt = successCnt;
    EXPECT_EQ(-1, MsprofMgr().AclJsonStart(0, data));
    printf("16 test============================================\n");
    // Init additional data list failed.
    g_mallocSuccessCnt = successCnt++;
    EXPECT_EQ(-1, MsprofMgr().AclJsonStart(0, data));
    printf("17 test============================================\n");
    // Init compact data list failed.
    g_mallocSuccessCnt = successCnt++;
    EXPECT_EQ(-1, MsprofMgr().AclJsonStart(0, data));
    printf("18 test============================================\n");
    // Failed to transfer to char for timeSinceEpoch
    g_mallocSuccessCnt = successCnt++; 
    EXPECT_EQ(-1, MsprofMgr().AclJsonStart(0, data));
    printf("19 test============================================\n");
    // Failed to transfer to char for timeStamp
    g_mallocSuccessCnt = successCnt++;
    EXPECT_EQ(-1, MsprofMgr().AclJsonStart(0, data));
    printf("20 test============================================\n");
    // Failed to calloc for uploader, device: 64
    g_mallocSuccessCnt = successCnt++; 
    EXPECT_EQ(-1, MsprofMgr().AclJsonStart(0, data));
    printf("21 test============================================\n");
    // Failed to malloc transport for uploader, device: 64
    g_mallocSuccessCnt = successCnt++; 
    EXPECT_EQ(-1, MsprofMgr().AclJsonStart(0, data));
    printf("22 test============================================\n");
    // Failed to malloc data queue for uploader, device: 64
    g_mallocSuccessCnt = successCnt++; 
    EXPECT_EQ(-1, MsprofMgr().AclJsonStart(0, data));
}

TEST_F(AclJsonNanoCStest, TestOsalCreateThreadFailed)
{
    nlohmann::json data;
    data["output"] = NANOC_OUTPUT_DIR;
    MOCKER(OsalCreateThread)
        .stubs()
        .will(returnValue(OSAL_EN_INVALID_PARAM))
        .then(returnValue(OSAL_EN_ERROR));
    EXPECT_EQ(-1, MsprofMgr().AclJsonStart(0, data));
    EXPECT_EQ(-1, MsprofMgr().AclJsonStart(0, data));
}

TEST_F(AclJsonNanoCStest, TestHalGetDeviceNumberFailed)
{
    nlohmann::json data;
    data["output"] = NANOC_OUTPUT_DIR;
    MOCKER(HalGetDeviceNumber)
        .stubs()
        .will(returnValue(uint32_t(0)));
    EXPECT_EQ(-1, MsprofMgr().AclJsonStart(0, data));
}

TEST_F(AclJsonNanoCStest, TestCstlListInitFailed)
{
    nlohmann::json data;
    data["output"] = NANOC_OUTPUT_DIR;
    MOCKER(CstlListInit)
        .stubs()
        .will(returnValue(CSTL_ERR));
    EXPECT_EQ(-1, MsprofMgr().AclJsonStart(0, data));
}

TEST_F(AclJsonNanoCStest, TestHalProfGetChannelListFailed)
{
    nlohmann::json data;
    data["output"] = NANOC_OUTPUT_DIR;
    MOCKER(HalProfGetChannelList)
        .stubs()
        .will(returnValue(PROFILING_FAILED));
    EXPECT_EQ(-1, MsprofMgr().AclJsonStart(0, data));
}

TEST_F(AclJsonNanoCStest, TestOsalMutexInitFailed)
{
    nlohmann::json data;
    data["output"] = NANOC_OUTPUT_DIR;
    MOCKER(OsalMutexInit)
        .stubs()
        .will(returnValue(-1));
    EXPECT_EQ(-1, MsprofMgr().AclJsonStart(0, data));
}

TEST_F(AclJsonNanoCStest, TestOsalCondInitFailed)
{
    nlohmann::json data;
    data["output"] = NANOC_OUTPUT_DIR;
    MOCKER(OsalCondInit)
        .stubs()
        .will(returnValue(-1));
    EXPECT_EQ(-1, MsprofMgr().AclJsonStart(0, data));
}

TEST_F(AclJsonNanoCStest, TestCreateDirectoryFailed)
{
    nlohmann::json data;
    data["output"] = NANOC_OUTPUT_DIR;
    MOCKER(OsalMkdir)
        .stubs()
        .will(returnValue(OSAL_EN_ERR));
    EXPECT_EQ(-1, MsprofMgr().AclJsonStart(0, data));
}

TEST_F(AclJsonNanoCStest, TestOsalGetLocalTimeFailed)
{
    nlohmann::json data;
    data["output"] = NANOC_OUTPUT_DIR;
    MOCKER(OsalGetLocalTime)
        .stubs()
        .will(returnValue(OSAL_EN_ERROR));
    EXPECT_EQ(-1, MsprofMgr().AclJsonStart(0, data));
}

TEST_F(AclJsonNanoCStest, ReapeatInitFinalizeBase)
{
    nlohmann::json data;
    data["output"] = NANOC_OUTPUT_DIR;
    data["task_trace"] = "on";
    std::string aclJson = data.dump();
    auto jsonData = (void *)(const_cast<char *>(aclJson.c_str()));
    int32_t ret = MsprofInit(MSPROF_CTRL_INIT_ACL_JSON, jsonData, aclJson.size());
    EXPECT_EQ(ret, PROFILING_SUCCESS);
    ret = MsprofInit(MSPROF_CTRL_INIT_ACL_JSON, jsonData, aclJson.size());
    EXPECT_EQ(ret, PROFILING_SUCCESS);
    ret = MsprofInit(MSPROF_CTRL_INIT_ACL_JSON, jsonData, aclJson.size());
    EXPECT_EQ(ret, PROFILING_SUCCESS);
    ret = MsprofInit(MSPROF_CTRL_INIT_ACL_JSON, jsonData, aclJson.size());
    EXPECT_EQ(ret, PROFILING_SUCCESS);
    ret = MsprofInit(MSPROF_CTRL_INIT_ACL_JSON, jsonData, aclJson.size());
    EXPECT_EQ(ret, PROFILING_SUCCESS);

    ret = MsprofNotifySetDevice(0, 0, true);
    EXPECT_EQ(ret, PROFILING_SUCCESS);

    ret = MsprofFinalize();
    EXPECT_EQ(ret, PROFILING_SUCCESS);
    ret = MsprofFinalize();
    EXPECT_EQ(ret, PROFILING_SUCCESS);
    ret = MsprofFinalize();
    EXPECT_EQ(ret, PROFILING_SUCCESS);
    ret = MsprofFinalize();
    EXPECT_EQ(ret, PROFILING_SUCCESS);
    ret = MsprofFinalize();
    EXPECT_EQ(ret, PROFILING_SUCCESS);
}

extern "C" {
int32_t UploadCollectionTimeInfo(uint32_t deviceId, char* content, size_t contentLen, const char* fileName);
}

static int32_t UploaderUploadDataStub2(ProfFileChunk *chunk)
{
    OSAL_MEM_FREE(chunk->chunk);
    OSAL_MEM_FREE(chunk);
    return PROFILING_SUCCESS;
}

TEST_F(AclJsonNanoCStest, UploadCollectionTimeInfoTest)
{
    MOCKER(UploaderUploadData)
        .stubs()
        .will(invoke(UploaderUploadDataStub2));
    MOCKER(strcpy_s)
        .stubs()
        .will(returnValue(-1));
    char *content = (char *)OsalMalloc(100);
    int ret = UploadCollectionTimeInfo(1, content, 100, "test");
    EXPECT_EQ(ret, PROFILING_FAILED);
}

TEST_F(AclJsonNanoCStest, ToHeapStrMemoryLeakTest)
{
    testing::internal::CaptureStdout();

    JsonObj *dstObj = JsonInit();
    JsonObj *obj = JsonInit();
    obj->SetValueByKey(obj, "s", {"abc", CJSON_STRING});
    MOCKER(memcpy_s)
        .stubs()
        .will(returnValue(-1));

    JsonCopy(dstObj, obj);
    JsonFree(obj);
    JsonFree(dstObj);

    std::string outputLog = testing::internal::GetCapturedStdout();
    EXPECT_NE(outputLog.find("memcpy_s failed"), std::string::npos); 
}

void TestNumber(double expect, char *json)
{
    JsonObj *jsonObj = JsonParse(json);
    EXPECT_EQ(true, jsonObj != NULL);
    EXPECT_EQ(true, JsonIsDouble(jsonObj));
    EXPECT_EQ(expect, GetJsonDouble(jsonObj));
    JsonFree(jsonObj);
}

TEST_F(AclJsonNanoCStest, JsonTest)
{
    TestNumber(0.0, "0.0");
    TestNumber(1.5, "1.5");
    TestNumber(-1.5, "-1.5");
    TestNumber(3.1416, "3.1416");
    TestNumber(999999999999999.0, "999999999999999.0");
    TestNumber(1.0000000000000002, "1.0000000000000002");
}

typedef struct {
    uint32_t key;
    uint32_t value;
} StubPair;

int StubPairCmp(void *a, void *b, void *appInfo)
{
    return ((StubPair *)a)->key - ((StubPair *)b)->key;
}

TEST_F(AclJsonNanoCStest, SortVectorCaseBasic)
{
    SortVector a;
    StubPair pair = {10, 1};
    InitCSortVector(&a, sizeof(StubPair), StubPairCmp, NULL);
    EXPECT_EQ(FindCSortVector(&a, &pair), CSortVectorSize(&a));
    EmplaceCSortVector(&a, &pair);
    EXPECT_EQ(CSortVectorSize(&a), 1);
    size_t index = FindCSortVector(&a, &pair);
    EXPECT_EQ(index, 0);
    EXPECT_EQ(((StubPair *)CSortVectorAt(&a, index))->key, 10);
    EXPECT_EQ(((StubPair *)CSortVectorAt(&a, index))->value, 1);

    pair.key++;
    EmplaceCSortVector(&a, &pair);
    EXPECT_EQ(CSortVectorSize(&a), 2);
    index = FindCSortVector(&a, &pair);
    EXPECT_EQ(index, 1);
    EXPECT_EQ(((StubPair *)CSortVectorAt(&a, index))->key, 11);
    EXPECT_EQ(((StubPair *)CSortVectorAt(&a, index))->value, 1);

    pair.key -= 2;
    EmplaceCSortVector(&a, &pair);
    EXPECT_EQ(CSortVectorSize(&a), 3);
    index = FindCSortVector(&a, &pair);
    EXPECT_EQ(index, 0);
    EXPECT_EQ(((StubPair *)CSortVectorAt(&a, index))->key, 9);
    EXPECT_EQ(((StubPair *)CSortVectorAt(&a, index))->value, 1);

    EmplaceCSortVector(&a, &pair);
    EXPECT_EQ(CSortVectorSize(&a), 3);
    index = FindCSortVector(&a, &pair);
    EXPECT_EQ(index, 0);
    EXPECT_EQ(((StubPair *)CSortVectorAt(&a, index))->key, 9);
    EXPECT_EQ(((StubPair *)CSortVectorAt(&a, index))->value, 1);

    RemoveCSortVector(&a, 0);
    EXPECT_EQ(CSortVectorSize(&a), 2);
    index = FindCSortVector(&a, &pair);
    EXPECT_EQ(index, CSortVectorSize(&a));
    EmplaceCSortVector(&a, &pair);
    EXPECT_EQ(CSortVectorSize(&a), 3);

    RemoveCSortVector(&a, 2);
    EXPECT_EQ(CSortVectorSize(&a), 2);
    pair.key = 11;
    index = FindCSortVector(&a, &pair);
    EXPECT_EQ(index, CSortVectorSize(&a));
    EmplaceCSortVector(&a, &pair);

    RemoveCSortVector(&a, 1);
    EXPECT_EQ(CSortVectorSize(&a), 2);
    pair.key = 10;
    index = FindCSortVector(&a, &pair);
    EXPECT_EQ(index, CSortVectorSize(&a));

    RemoveCSortVector(&a, 1);
    EXPECT_EQ(CSortVectorSize(&a), 1);

    RemoveCSortVector(&a, 1);
    EXPECT_EQ(CSortVectorSize(&a), 1);

    RemoveCSortVector(&a, 0);
    EXPECT_EQ(CSortVectorSize(&a), 0);

    DeInitCSortVector(&a);

    EXPECT_EQ((a.vector.data == NULL), true);
    EXPECT_EQ(a.vector.size, 0);
    EXPECT_EQ(a.vector.capacity, 0);
    EXPECT_EQ(a.vector.itemSize, 0);
}

TEST_F(AclJsonNanoCStest, SortVectorCaseNewDestroy)
{
    SortVector *a = NewSortVector(StubPair, StubPairCmp, NULL);
    StubPair pair = {10, 1};
    EXPECT_EQ(FindCSortVector(a, &pair), CSortVectorSize(a));
    InitCSortVector(a, sizeof(StubPair), StubPairCmp, NULL);
    EmplaceCSortVector(a, &pair);
    EXPECT_EQ(CSortVectorSize(a), 1);
    size_t index = FindCSortVector(a, &pair);
    EXPECT_EQ(index, 0);
    EXPECT_EQ(((StubPair *)CSortVectorAt(a, index))->key, 10);
    EXPECT_EQ(((StubPair *)CSortVectorAt(a, index))->value, 1);
    DestroyCSortVector(a);
}

TEST_F(AclJsonNanoCStest, SortVectorCaseDefaultCmp)
{
    SortVector a;
    StubPair pair = {10, 1};
    InitCSortVector(&a, sizeof(StubPair), NULL, (void *)&pair);  // appInfo 无效测试
    EXPECT_EQ(FindCSortVector(&a, &pair), CSortVectorSize(&a));
    EmplaceCSortVector(&a, &pair);
    EXPECT_EQ(CSortVectorSize(&a), 1);
    size_t index = FindCSortVector(&a, &pair);
    EXPECT_EQ(index, 0);
    EXPECT_EQ(((StubPair *)CSortVectorAt(&a, index))->key, 10);
    EXPECT_EQ(((StubPair *)CSortVectorAt(&a, index))->value, 1);

    pair.key++;
    EmplaceCSortVector(&a, &pair);
    EXPECT_EQ(CSortVectorSize(&a), 2);
    index = FindCSortVector(&a, &pair);
    EXPECT_EQ(index, 1);
    EXPECT_EQ(((StubPair *)CSortVectorAt(&a, index))->key, 11);
    EXPECT_EQ(((StubPair *)CSortVectorAt(&a, index))->value, 1);

    pair.key -= 2;
    EmplaceCSortVector(&a, &pair);
    EXPECT_EQ(CSortVectorSize(&a), 3);
    index = FindCSortVector(&a, &pair);
    EXPECT_EQ(index, 0);
    EXPECT_EQ(((StubPair *)CSortVectorAt(&a, index))->key, 9);
    EXPECT_EQ(((StubPair *)CSortVectorAt(&a, index))->value, 1);

    EmplaceCSortVector(&a, &pair);
    EXPECT_EQ(CSortVectorSize(&a), 3);
    index = FindCSortVector(&a, &pair);
    EXPECT_EQ(index, 0);
    EXPECT_EQ(((StubPair *)CSortVectorAt(&a, index))->key, 9);
    EXPECT_EQ(((StubPair *)CSortVectorAt(&a, index))->value, 1);

    RemoveCSortVector(&a, 0);
    EXPECT_EQ(CSortVectorSize(&a), 2);
    index = FindCSortVector(&a, &pair);
    EXPECT_EQ(index, CSortVectorSize(&a));
    EmplaceCSortVector(&a, &pair);
    EXPECT_EQ(CSortVectorSize(&a), 3);

    RemoveCSortVector(&a, 2);
    EXPECT_EQ(CSortVectorSize(&a), 2);
    pair.key = 11;
    index = FindCSortVector(&a, &pair);
    EXPECT_EQ(index, CSortVectorSize(&a));
    EmplaceCSortVector(&a, &pair);

    RemoveCSortVector(&a, 1);
    EXPECT_EQ(CSortVectorSize(&a), 2);
    pair.key = 10;
    index = FindCSortVector(&a, &pair);
    EXPECT_EQ(index, CSortVectorSize(&a));

    RemoveCSortVector(&a, 1);
    EXPECT_EQ(CSortVectorSize(&a), 1);

    RemoveCSortVector(&a, 1);
    EXPECT_EQ(CSortVectorSize(&a), 1);

    RemoveCSortVector(&a, 0);
    EXPECT_EQ(CSortVectorSize(&a), 0);

    DeInitCSortVector(&a);

    EXPECT_EQ((a.vector.data == NULL), true);
    EXPECT_EQ(a.vector.size, 0);
    EXPECT_EQ(a.vector.capacity, 0);
    EXPECT_EQ(a.vector.itemSize, 0);
}

TEST_F(AclJsonNanoCStest, VectorCaseBasic)
{
    Vector a;
    uint8_t value = 1;
    InitCVector(&a, sizeof(uint8_t));
    EXPECT_EQ(ReSizeCVector(&a, 0), 0);
    EXPECT_EQ(CapacityCVector(&a, 0), 0);
    EmplaceBackCVector(&a, &value);
    value++;
    EXPECT_EQ(ReSizeCVector(&a, 0), 1);
    EXPECT_EQ(*(uint8_t *)CVectorAt(&a, 0), 1);
    EXPECT_EQ(ReSizeCVector(&a, 2), 2);

    EXPECT_EQ((uint8_t *)CVectorAt(&a, 1), ((uint8_t *)CVectorAt(&a, 0)) + 1);
    *(uint8_t *)CVectorAt(&a, 1) = 2;
    RemoveCVector(&a, 0);
    EXPECT_EQ(*(uint8_t *)CVectorAt(&a, 0), 2);
    EXPECT_EQ(ReSizeCVector(&a, 0), 1);
    DeInitCVector(&a);
    EXPECT_EQ((a.data == NULL), true);
    EXPECT_EQ(a.size, 0);
    EXPECT_EQ(a.capacity, 0);
    EXPECT_EQ(a.itemSize, 0);
}

TEST_F(AclJsonNanoCStest, VectorCaseBasic_capacity)
{
    Vector a;
    uint8_t value = 1;
    InitCVector(&a, sizeof(uint8_t));
    EXPECT_EQ(ReSizeCVector(&a, 1), 1);
    EXPECT_EQ(CapacityCVector(&a, 0), 1);
    *(uint8_t *)CVectorAt(&a, 0) = value;
    EmplaceBackCVector(&a, &value);
    EXPECT_EQ(CapacityCVector(&a, 0), VECTOR_BASIC_STEP);
    EXPECT_EQ(ReSizeCVector(&a, 0), 2);
    EXPECT_EQ(*(uint8_t *)CVectorAt(&a, 0), value);
    EXPECT_EQ(*(uint8_t *)CVectorAt(&a, 1), value);

    for (int i = 2; i < VECTOR_BASIC_STEP + 1; i++) {
        value = (uint8_t)i;
        EmplaceBackCVector(&a, &value);
    }
    value = 1;
    EXPECT_EQ(*(uint8_t *)CVectorAt(&a, 0), value);
    EXPECT_EQ(*(uint8_t *)CVectorAt(&a, 1), value);
    for (int i = 2; i < VECTOR_BASIC_STEP + 1; i++) {
        value = (uint8_t)i;
        EXPECT_EQ(*(uint8_t *)CVectorAt(&a, i), value);
    }
    EXPECT_EQ(CapacityCVector(&a, 0), VECTOR_BASIC_STEP * 2);

    DeInitCVector(&a);
}

TEST_F(AclJsonNanoCStest, VectorCaseBasic_Emplace)
{
    Vector a;
    uint8_t value = 1;
    InitCVector(&a, sizeof(uint8_t));
    EmplaceCVector(&a, 0, &value);
    EXPECT_EQ(*(uint8_t *)CVectorAt(&a, 0), value);
    value++;
    EmplaceCVector(&a, 1, &value);
    EXPECT_EQ(*(uint8_t *)CVectorAt(&a, 1), value);
    value++;
    EmplaceCVector(&a, 0, &value);
    EXPECT_EQ(*(uint8_t *)CVectorAt(&a, 0), value);
    EXPECT_EQ(*(uint8_t *)CVectorAt(&a, 1), 1);
    EXPECT_EQ(*(uint8_t *)CVectorAt(&a, 2), 2);
    value++;

    EmplaceHeadCVector(&a, &value);
    EXPECT_EQ(*(uint8_t *)CVectorAt(&a, 0), value);
    EXPECT_EQ(ReSizeCVector(&a, 0), 4);
    DeInitCVector(&a);
}

TEST_F(AclJsonNanoCStest, VectorCaseBasic_new)
{
    Vector *a = NewVector(uint8_t);
    uint8_t value = 1;
    InitCVector(a, sizeof(uint8_t));
    EXPECT_EQ(ReSizeCVector(a, 1), 1);
    EXPECT_EQ(CapacityCVector(a, 0), 1);
    *(uint8_t *)CVectorAt(a, 0) = value;
    EmplaceBackCVector(a, &value);
    EXPECT_EQ(CapacityCVector(a, 0), VECTOR_BASIC_STEP);
    EXPECT_EQ(ReSizeCVector(a, 0), 2);
    EXPECT_EQ(*(uint8_t *)CVectorAt(a, 0), value);
    EXPECT_EQ(*(uint8_t *)CVectorAt(a, 1), value);

    for (int i = 2; i < VECTOR_BASIC_STEP + 1; i++) {
        value = (uint8_t)i;
        EmplaceBackCVector(a, &value);
    }
    value = 1;
    EXPECT_EQ(*(uint8_t *)CVectorAt(a, 0), value);
    EXPECT_EQ(*(uint8_t *)CVectorAt(a, 1), value);
    for (int i = 2; i < VECTOR_BASIC_STEP + 1; i++) {
        value = (uint8_t)i;
        EXPECT_EQ(*(uint8_t *)CVectorAt(a, i), value);
    }
    EXPECT_EQ(CapacityCVector(a, 0), VECTOR_BASIC_STEP * 2);

    DestroyCVector(a);
}

TEST_F(AclJsonNanoCStest, VectorCaseBasic_ConstVector)
{
    Vector a;
    uint8_t value = 1;
    InitCVector(&a, sizeof(uint8_t));
    EmplaceBackCVector(&a, &value);
    EXPECT_EQ(*(const uint8_t *)ConstCVectorAt(&a, 0), 1);
    EXPECT_EQ(((const uint8_t *)ConstCVectorAt(&a, 1) == NULL), true);

    DeInitCVector(&a);
    EXPECT_EQ((a.data == NULL), true);
    EXPECT_EQ(a.size, 0);
    EXPECT_EQ(a.capacity, 0);
    EXPECT_EQ(a.itemSize, 0);
}

TEST_F(AclJsonNanoCStest, VectorCaseBasic_ClearVector)
{
    Vector a;
    uint8_t value = 1;
    InitCVector(&a, sizeof(uint8_t));
    EmplaceCVector(&a, 0, &value);
    EXPECT_EQ(*(uint8_t *)CVectorAt(&a, 0), 1);
    value++;
    EmplaceCVector(&a, 1, &value);
    EXPECT_EQ(*(uint8_t *)CVectorAt(&a, 1), 2);
    ClearCVector(&a);
    EXPECT_EQ(CVectorSize(&a), 0);

    value++;
    EmplaceCVector(&a, 0, &value);
    EXPECT_EQ(*(uint8_t *)CVectorAt(&a, 0), 3);
    value++;
    EmplaceHeadCVector(&a, &value);
    EXPECT_EQ(*(uint8_t *)CVectorAt(&a, 0), 4);
    EXPECT_EQ(*(uint8_t *)CVectorAt(&a, 1), 3);
    EXPECT_EQ(ReSizeCVector(&a, 0), 2);

    DeInitCVector(&a);
    EXPECT_EQ((a.data == NULL), true);
    EXPECT_EQ(a.size, 0);
    EXPECT_EQ(a.capacity, 0);
    EXPECT_EQ(a.itemSize, 0);
}
