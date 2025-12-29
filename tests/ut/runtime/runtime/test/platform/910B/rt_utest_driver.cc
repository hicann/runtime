/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#define private public
#include "npu_driver.hpp"
#undef private
#include "driver/ascend_hal.h"
#include "event.hpp"
#include "gtest/gtest.h"
#include "mockcpp/mockcpp.hpp"
#include "driver.hpp"
#include "cmodel_driver.h"
using namespace testing;
using namespace cce::runtime;


class DriverTest : public testing::Test
{
protected:
    static void SetUpTestCase()
    {
        std::cout<<"Driver test start"<<std::endl;

    }

    static void TearDownTestCase()
    {
        std::cout<<"Driver test start end"<<std::endl;

    }

    virtual void SetUp()
    {
        rtSetDevice(0);
    }

    virtual void TearDown()
    {
        rtDeviceReset(0);
        GlobalMockObject::verify();
    }
};

TEST_F(DriverTest, bitmap)
{
    Bitmap map(70);
    int id = -1;
    for (int i = 0; i < 70; i++)
    {
        id = map.AllocId();
        EXPECT_NE(id, -1);
    }
    id = map.AllocId();
    EXPECT_EQ(id, -1);

    uint32_t numOfRes = 15*1024;
    uint32_t curMaxNumOfRes = 11*1024;
    Bitmap map2(numOfRes);
    for (int i = 0; i < curMaxNumOfRes; i++) {
        id = map2.AllocId(curMaxNumOfRes);
        EXPECT_NE(id, -1);
    }

    for (int i =0; i < 1025; i++) {     // utilization: 11*1024 - 1025, available: 1025
        map2.FreeId(i);
    }

    id = map2.AllocId(curMaxNumOfRes);  // available: 1024
    EXPECT_NE(id, -1);

    id = map2.AllocId(curMaxNumOfRes);  // available: 1023
    EXPECT_NE(id, -1);

    id = map2.AllocId(curMaxNumOfRes);
    EXPECT_EQ(id, -1);
}

TEST_F(DriverTest, get_plat_info_succ)
{
    uint32_t info = 0;

    MOCKER(drvGetPlatformInfo)
        .stubs()
        .will(returnValue(DRV_ERROR_NONE));

    NpuDriver * rawDrv = new NpuDriver();

    info = rawDrv->RtGetRunMode();
    EXPECT_EQ(info, RT_RUN_MODE_RESERVED);
    GlobalMockObject::verify();

    delete rawDrv;
}

TEST_F(DriverTest, get_plat_info_fail)
{
    uint32_t info = 0;

    MOCKER(drvGetPlatformInfo)
        .stubs()
        .will(returnValue(DRV_ERROR_INVALID_VALUE));

    NpuDriver * rawDrv = new NpuDriver();

    info = rawDrv->RtGetRunMode();
    EXPECT_EQ(info, RT_RUN_MODE_RESERVED);
    delete rawDrv;
}


TEST_F(DriverTest, register_driver_fail)
{
    DriverFactory * rawDrv = new DriverFactory();
    bool ret = rawDrv->RegDriver(NPU_DRIVER, nullptr);
    EXPECT_EQ(ret, false);
    delete rawDrv;
}

TEST_F(DriverTest, get_sq_head)
{
    rtError_t error;
    NpuDriver drv;
    struct halSqCqQueryInfo queryInfoIn = {};
    uint16_t head;

    queryInfoIn.type = DRV_NORMAL_TYPE;
    queryInfoIn.tsId = 0U;
    queryInfoIn.sqId = 1U;
    queryInfoIn.cqId = 1U;
    queryInfoIn.prop = DRV_SQCQ_PROP_SQ_HEAD;
    queryInfoIn.value[0] = 0xffff;

    MOCKER(halSqCqQuery)
        .stubs()
        .with(mockcpp::any(), outBoundP(&queryInfoIn, sizeof(queryInfoIn)))
        .will(returnValue(DRV_ERROR_NONE));

    error = drv.GetSqHead(0U, 0U, 1U, head);
    EXPECT_EQ(error, RT_ERROR_NONE);
    EXPECT_EQ(head, 0xffff);
}

TEST_F(DriverTest, get_sq_tail)
{
    rtError_t error;
    NpuDriver drv;
    struct halSqCqQueryInfo queryInfoIn = {};
    uint16_t tail;

    queryInfoIn.type = DRV_NORMAL_TYPE;
    queryInfoIn.tsId = 0U;
    queryInfoIn.sqId = 1U;
    queryInfoIn.cqId = 1U;
    queryInfoIn.prop = DRV_SQCQ_PROP_SQ_TAIL;
    queryInfoIn.value[0] = 0xffff;

    MOCKER(halSqCqQuery)
        .stubs()
        .with(mockcpp::any(), outBoundP(&queryInfoIn, sizeof(queryInfoIn)))
        .will(returnValue(DRV_ERROR_NONE));

    error = drv.GetSqTail(0U, 0U, 1U, tail);
    EXPECT_EQ(error, RT_ERROR_NONE);
    EXPECT_EQ(tail, 0xffff);

    drv.addrMode_ = 1;
    drv.sysMode_ = 1;
    drv.HostAddrRegister(nullptr, 0, 0);
    drv.HostAddrUnRegister(nullptr, 0);
}

TEST_F(DriverTest, GetStarsInfo_Success)
{
    NpuDriver *npuDrv = new NpuDriver();

    MOCKER(halTsdrvCtl)
        .stubs()
        .will(returnValue(DRV_ERROR_NONE));
    
    uint64_t addr;
    rtError_t error = npuDrv->GetStarsInfo(0U, 0U, addr);
    EXPECT_EQ(error, RT_ERROR_NONE);
    delete npuDrv;
}

TEST_F(DriverTest, GetTsfwVersion_Success)
{
    NpuDriver *npuDrv = new NpuDriver();

    MOCKER(halTsdrvCtl)
        .stubs()
        .will(returnValue(DRV_ERROR_NONE));
    
    uint32_t version;
    uint32_t isSupportHcomcpu;
    rtError_t error = npuDrv->GetTsfwVersion(0U, 0U, version, isSupportHcomcpu);
    EXPECT_EQ(error, RT_ERROR_NONE);
    delete npuDrv;
}

TEST_F(DriverTest, QueryUbInfo_test)
{
    NpuDriver *npuDrv = new NpuDriver();

    MOCKER(halMemGetInfo)
        .stubs()
        .will(returnValue(DRV_ERROR_NONE))
        .then(returnValue(DRV_ERROR_INVALID_VALUE));

    rtMemUbTokenInfo *info = (rtMemUbTokenInfo *)malloc(sizeof(rtMemUbTokenInfo));
    ASSERT_NE(info, nullptr);
    info->va = 0;
    info->size = 1;
    rtError_t error = npuDrv->QueryUbInfo(0, QUERY_PROCESS_TOKEN, info);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = npuDrv->QueryUbInfo(0, QUERY_PROCESS_TOKEN, info);
    EXPECT_EQ(error, RT_ERROR_DRV_INPUT);
    delete npuDrv;
    free(info);
}

TEST_F(DriverTest, GetDevResAddress_test)
{
    NpuDriver *npuDrv = new NpuDriver();

    MOCKER(memset_s)
        .stubs()
        .will(returnValue(0));
    MOCKER(halResAddrMap)
        .stubs()
        .will(returnValue(DRV_ERROR_NONE))
        .then(returnValue(DRV_ERROR_INVALID_VALUE));

    rtDevResInfo *info = (rtDevResInfo *)malloc(sizeof(rtDevResInfo));
    ASSERT_NE(info, nullptr);
    info->dieId = 0;
    info->procType = RT_PROCESS_CP1;
    info->resType = RT_RES_TYPE_STARS_NOTIFY_RECORD;
    info->resId = 123;
    info->flag = 0;
    rtError_t error = npuDrv->GetDevResAddress(0, info, 0, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = npuDrv->GetDevResAddress(0, info, 0, 0);
    EXPECT_EQ(error, RT_ERROR_DRV_INPUT);
    delete npuDrv;
    free(info);
}

TEST_F(DriverTest, ReleaseDevResAddress_test)
{
    NpuDriver *npuDrv = new NpuDriver();

    MOCKER(memset_s)
        .stubs()
        .will(returnValue(0));
    MOCKER(halResAddrUnmap)
        .stubs()
        .will(returnValue(DRV_ERROR_NONE))
        .then(returnValue(DRV_ERROR_INVALID_VALUE));

    rtDevResInfo *info = (rtDevResInfo *)malloc(sizeof(rtDevResInfo));
    ASSERT_NE(info, nullptr);
    info->dieId = 0;
    info->procType = RT_PROCESS_CP1;
    info->resType = RT_RES_TYPE_STARS_NOTIFY_RECORD;
    info->resId = 123;
    info->flag = 0;
    rtError_t error = npuDrv->ReleaseDevResAddress(0, info);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = npuDrv->ReleaseDevResAddress(0, info);
    EXPECT_EQ(error, RT_ERROR_DRV_INPUT);
    delete npuDrv;
    free(info);
}

TEST_F(DriverTest, SqArgsCopyWithUb_test)
{
    NpuDriver *npuDrv = new NpuDriver();

    MOCKER(halSqTaskArgsAsyncCopy)
        .stubs()
        .will(returnValue(DRV_ERROR_NONE))
        .then(returnValue(DRV_ERROR_INVALID_VALUE));

    rtError_t error = npuDrv->SqArgsCopyWithUb(0, nullptr);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = npuDrv->SqArgsCopyWithUb(0, nullptr);
    EXPECT_EQ(error, RT_ERROR_DRV_INPUT);
    delete npuDrv;
}

TEST_F(DriverTest, GetSqRegVirtualAddrBySqidForStarsV2_test)
{
    NpuDriver *npuDrv = new NpuDriver();

    MOCKER(memset_s)
        .stubs()
        .will(returnValue(0));
    MOCKER(halResAddrMap)
        .stubs()
        .will(returnValue(DRV_ERROR_NONE))
        .then(returnValue(DRV_ERROR_INVALID_VALUE));

    uint64_t addr = 0;
    rtError_t error = npuDrv->GetSqRegVirtualAddrBySqidForStarsV2(0, 0, 0, &addr);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = npuDrv->GetSqRegVirtualAddrBySqidForStarsV2(0, 0, 0, &addr);
    EXPECT_EQ(error, RT_ERROR_DRV_INPUT);
    delete npuDrv;
}

int stat_stub(const char* path, struct stat* buf)
{
    buf->st_size = 1024;
    return 0;
}

TEST_F(DriverTest, FreeHostSharedMemory_test)
{
    NpuDriver *npuDrv = new NpuDriver();

    MOCKER(strcpy_s).stubs().will(returnValue(0));
    MOCKER(strcat_s).stubs().will(returnValue(0));
    MOCKER(munmap).stubs().will(returnValue(0));
    MOCKER(close).stubs().will(returnValue(0));
    MOCKER(shm_unlink).stubs().will(returnValue(0));
    MOCKER(stat).stubs().will(invoke(stat_stub));

    MOCKER(halHostUnregister)
        .stubs()
        .will(returnValue(DRV_ERROR_NONE))
        .then(returnValue(DRV_ERROR_INVALID_VALUE));

    rtFreeHostSharedMemoryIn in = {"test", 1024, 0};

    rtError_t error = npuDrv->FreeHostSharedMemory(&in, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = npuDrv->FreeHostSharedMemory(&in, 0);;
    EXPECT_EQ(error, RT_ERROR_DRV_INPUT);
    delete npuDrv;
}

TEST_F(DriverTest, GetMemUceInfo_test)
{
    NpuDriver *npuDrv = new NpuDriver();

    MOCKER(halGetDeviceInfoByBuff)
        .stubs()
        .will(returnValue(DRV_ERROR_NONE))
        .then(returnValue(DRV_ERROR_INVALID_VALUE));

    rtError_t error = npuDrv->GetMemUceInfo(0, nullptr);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = npuDrv->GetMemUceInfo(0, nullptr);
    EXPECT_EQ(error, RT_ERROR_DRV_INPUT);
    delete npuDrv;
}

TEST_F(DriverTest, GetDeviceInfoByBuff_test)
{
    NpuDriver *npuDrv = new NpuDriver();

    MOCKER(halGetDeviceInfoByBuff)
        .stubs()
        .will(returnValue(DRV_ERROR_NONE))
        .then(returnValue(DRV_ERROR_INVALID_VALUE));

    rtError_t error = npuDrv->GetDeviceInfoByBuff(0, 0, 0, nullptr, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = npuDrv->GetDeviceInfoByBuff(0, 0, 0, nullptr, 0);
    EXPECT_EQ(error, RT_ERROR_DRV_INPUT);
    delete npuDrv;
}

TEST_F(DriverTest, SetDeviceInfoByBuff_test)
{
    NpuDriver *npuDrv = new NpuDriver();

    MOCKER(halSetDeviceInfoByBuff)
        .stubs()
        .will(returnValue(DRV_ERROR_NONE))
        .then(returnValue(DRV_ERROR_INVALID_VALUE));

    rtError_t error = npuDrv->SetDeviceInfoByBuff(0, 0, 0, nullptr, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = npuDrv->SetDeviceInfoByBuff(0, 0, 0, nullptr, 0);
    EXPECT_EQ(error, RT_ERROR_DRV_INPUT);
    delete npuDrv;
}

TEST_F(DriverTest, MemUceRepair_test)
{
    NpuDriver *npuDrv = new NpuDriver();

    MOCKER(halMemCtl)
        .stubs()
        .will(returnValue(DRV_ERROR_NONE))
        .then(returnValue(DRV_ERROR_INVALID_VALUE));

    rtError_t error = npuDrv->MemUceRepair(0, nullptr);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = npuDrv->MemUceRepair(0, nullptr);
    EXPECT_EQ(error, RT_ERROR_DRV_INPUT);
    delete npuDrv;
}

TEST_F(DriverTest, StreamEnableStmSyncEsched_test)
{
    NpuDriver *npuDrv = new NpuDriver();

    MOCKER(memset_s)
        .stubs()
        .will(returnValue(0));
    MOCKER(halResourceConfig)
        .stubs()
        .will(returnValue(DRV_ERROR_NONE))
        .then(returnValue(DRV_ERROR_INVALID_VALUE));

    rtError_t error = npuDrv->StreamEnableStmSyncEsched(0, 0, 0, 0, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = npuDrv->StreamEnableStmSyncEsched(0, 0, 0, 0, 0);
    EXPECT_EQ(error, RT_ERROR_DRV_INPUT);
    delete npuDrv;
}

TEST_F(DriverTest, DebugSqTaskSend_test)
{
    NpuDriver *npuDrv = new NpuDriver();

    MOCKER(halSqTaskSend)
        .stubs()
        .will(returnValue(DRV_ERROR_NONE))
        .then(returnValue(DRV_ERROR_INVALID_VALUE));

    rtError_t error = npuDrv->DebugSqTaskSend(0, nullptr, 0, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = npuDrv->DebugSqTaskSend(0, nullptr, 0, 0);
    EXPECT_EQ(error, RT_ERROR_DRV_INPUT);
    delete npuDrv;
}

TEST_F(DriverTest, DebugSqCqAllocate_test)
{
    NpuDriver *npuDrv = new NpuDriver();

    MOCKER(halSqCqAllocate)
        .stubs()
        .will(returnValue(DRV_ERROR_NONE))
        .then(returnValue(DRV_ERROR_INVALID_VALUE));

    uint32_t sqId;
    uint32_t cqId;
    rtError_t error = npuDrv->DebugSqCqAllocate(0, 0, sqId, cqId);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = npuDrv->DebugSqCqAllocate(0, 0, sqId, cqId);
    EXPECT_EQ(error, RT_ERROR_DRV_INPUT);
    delete npuDrv;
}

TEST_F(DriverTest, VirtualCqFree_test)
{
    NpuDriver *npuDrv = new NpuDriver();

    MOCKER(halSqCqFree)
        .stubs()
        .will(returnValue(DRV_ERROR_NONE));

    rtError_t error = npuDrv->VirtualCqFree(0, 0, 0, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);
    delete npuDrv;
}

TEST_F(DriverTest, DebugCqReport_test)
{
    NpuDriver *npuDrv = new NpuDriver();

    MOCKER(halCqReportRecv)
        .stubs()
        .will(returnValue(DRV_ERROR_NONE))
        .then(returnValue(DRV_ERROR_INVALID_VALUE));

    uint32_t realCnt;
    rtError_t error = npuDrv->DebugCqReport(0, 0, 0, nullptr, realCnt);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = npuDrv->DebugCqReport(0, 0, 0, nullptr, realCnt);
    EXPECT_EQ(error, RT_ERROR_DRV_INPUT);
    delete npuDrv;
}

TEST_F(DriverTest, ProcessResRestore_test)
{
    NpuDriver *npuDrv = new NpuDriver();

    MOCKER(halProcessResRestore)
        .stubs()
        .will(returnValue(DRV_ERROR_NONE))
        .then(returnValue(DRV_ERROR_INVALID_VALUE));

    rtError_t error = npuDrv->ProcessResRestore();
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = npuDrv->ProcessResRestore();
    EXPECT_EQ(error, RT_ERROR_DRV_INPUT);
    delete npuDrv;
}

TEST_F(DriverTest, HostDeviceClose_test)
{
    NpuDriver *npuDrv = new NpuDriver();

    MOCKER(halDeviceClose)
        .stubs()
        .will(returnValue(DRV_ERROR_NONE))
        .then(returnValue(DRV_ERROR_INVALID_VALUE));

    rtError_t error = npuDrv->HostDeviceClose(0);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = npuDrv->HostDeviceClose(0);
    EXPECT_EQ(error, RT_ERROR_DRV_INPUT);
    delete npuDrv;
}

TEST_F(DriverTest, CqReportRelease_test)
{
    NpuDriver *npuDrv = new NpuDriver();

    MOCKER(halReportRelease)
        .stubs()
        .will(returnValue(DRV_ERROR_NONE))
        .then(returnValue(DRV_ERROR_INVALID_VALUE));

    rtHostFuncCqReport_t report = {};
    rtError_t error = npuDrv->CqReportRelease(&report, 0, 0, 0, false);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = npuDrv->CqReportRelease(&report, 0, 0, 0, false);
    EXPECT_EQ(error, RT_ERROR_DRV_INPUT);
    delete npuDrv;
}

TEST_F(DriverTest, MemQueueExport_test)
{
    NpuDriver *npuDrv = new NpuDriver();

    MOCKER(strcpy_s)
        .stubs()
        .will(returnValue(0));
    MOCKER(halQueueExport)
        .stubs()
        .will(returnValue(DRV_ERROR_NONE))
        .then(returnValue(DRV_ERROR_INVALID_VALUE));

    char name[] = "test";
    rtError_t error = npuDrv->MemQueueExport(0, 0, 0, name);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = npuDrv->MemQueueExport(0, 0, 0, name);
    EXPECT_EQ(error, RT_ERROR_DRV_INPUT);
    delete npuDrv;
}

TEST_F(DriverTest, MemQueueUnExport_test)
{
    NpuDriver *npuDrv = new NpuDriver();

    MOCKER(strcpy_s)
        .stubs()
        .will(returnValue(0));
    MOCKER(halQueueUnexport)
        .stubs()
        .will(returnValue(DRV_ERROR_NONE))
        .then(returnValue(DRV_ERROR_INVALID_VALUE));

    char name[] = "test";
    rtError_t error = npuDrv->MemQueueUnExport(0, 0, 0, name);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = npuDrv->MemQueueUnExport(0, 0, 0, name);
    EXPECT_EQ(error, RT_ERROR_DRV_INPUT);
    delete npuDrv;
}

TEST_F(DriverTest, MemQueueImport_test)
{
    NpuDriver *npuDrv = new NpuDriver();

    MOCKER(strcpy_s)
        .stubs()
        .will(returnValue(0));
    MOCKER(halQueueImport)
        .stubs()
        .will(returnValue(DRV_ERROR_NONE))
        .then(returnValue(DRV_ERROR_INVALID_VALUE));

    char name[] = "test";
    uint32_t qid = 1;
    rtError_t error = npuDrv->MemQueueImport(0, 0, name, &qid);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = npuDrv->MemQueueImport(0, 0, name, &qid);
    EXPECT_EQ(error, RT_ERROR_DRV_INPUT);
    delete npuDrv;
}

TEST_F(DriverTest, MemQueueUnImport_test)
{
    NpuDriver *npuDrv = new NpuDriver();

    MOCKER(strcpy_s)
        .stubs()
        .will(returnValue(0));
    MOCKER(halQueueUnimport)
        .stubs()
        .will(returnValue(DRV_ERROR_NONE))
        .then(returnValue(DRV_ERROR_INVALID_VALUE));

    char name[] = "test";
    rtError_t error = npuDrv->MemQueueUnImport(0, 0, 0, name);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = npuDrv->MemQueueUnImport(0, 0, 0, name);
    EXPECT_EQ(error, RT_ERROR_DRV_INPUT);
    delete npuDrv;
}

TEST_F(DriverTest, MemQueueReset_test)
{
    NpuDriver *npuDrv = new NpuDriver();

    MOCKER(halQueueReset)
        .stubs()
        .will(returnValue(DRV_ERROR_NONE))
        .then(returnValue(DRV_ERROR_INVALID_VALUE));

    rtError_t error = npuDrv->MemQueueReset(0, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = npuDrv->MemQueueReset(0, 0);
    EXPECT_EQ(error, RT_ERROR_DRV_INPUT);
    delete npuDrv;
}

TEST_F(DriverTest, MemQueueGrant_test)
{
    NpuDriver *npuDrv = new NpuDriver();

    MOCKER(halQueueGrant)
        .stubs()
        .will(returnValue(DRV_ERROR_NONE))
        .then(returnValue(DRV_ERROR_INVALID_VALUE));

    rtMemQueueShareAttr_t attr = {};
    rtError_t error = npuDrv->MemQueueGrant(0, 0, 0, &attr);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = npuDrv->MemQueueGrant(0, 0, 0, &attr);
    EXPECT_EQ(error, RT_ERROR_DRV_INPUT);
    delete npuDrv;
}

TEST_F(DriverTest, QueueSubscribe_test)
{
    NpuDriver *npuDrv = new NpuDriver();

    MOCKER(halQueueSubscribe)
        .stubs()
        .will(returnValue(DRV_ERROR_NONE))
        .then(returnValue(DRV_ERROR_INVALID_VALUE));

    rtError_t error = npuDrv->QueueSubscribe(0, 0, 0, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = npuDrv->QueueSubscribe(0, 0, 0, 0);
    EXPECT_EQ(error, RT_ERROR_DRV_INPUT);
    delete npuDrv;
}

TEST_F(DriverTest, QueueSubF2NFEvent_test)
{
    NpuDriver *npuDrv = new NpuDriver();

    MOCKER(halQueueSubF2NFEvent)
        .stubs()
        .will(returnValue(DRV_ERROR_NONE))
        .then(returnValue(DRV_ERROR_INVALID_VALUE));

    rtError_t error = npuDrv->QueueSubF2NFEvent(0, 0, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = npuDrv->QueueSubF2NFEvent(0, 0, 0);
    EXPECT_EQ(error, RT_ERROR_DRV_INPUT);
    delete npuDrv;
}

TEST_F(DriverTest, GetChipFromDevice_test)
{
    NpuDriver *npuDrv = new NpuDriver();

    MOCKER(halGetChipFromDevice)
        .stubs()
        .will(returnValue(DRV_ERROR_NONE))
        .then(returnValue(DRV_ERROR_INVALID_VALUE));

    uint32_t chipId = 0;
    rtError_t error = npuDrv->GetChipFromDevice(0, &chipId);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = npuDrv->GetChipFromDevice(0, &chipId);
    EXPECT_EQ(error, RT_ERROR_DRV_INPUT);
    delete npuDrv;
}

TEST_F(DriverTest, MemcpyBatch_test)
{
    NpuDriver *npuDrv = new NpuDriver();

    MOCKER(halMemcpyBatch)
        .stubs()
        .will(returnValue(DRV_ERROR_NONE))
        .then(returnValue(DRV_ERROR_INVALID_VALUE));

    size_t count = 1;
    uint64_t dsts[count] = {0};
    uint64_t srcs[count] = {0};
    size_t sizes[count] = {0};
    rtError_t error = npuDrv->MemcpyBatch(dsts, srcs, sizes, count);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = npuDrv->MemcpyBatch(dsts, srcs, sizes, count);
    EXPECT_EQ(error, RT_ERROR_DRV_INPUT);
    delete npuDrv;
}