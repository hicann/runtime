/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "driver/ascend_hal.h"
#include "event.hpp"
#include "gtest/gtest.h"
#include "mockcpp/mockcpp.hpp"
#include "driver.hpp"
#include "npu_driver.hpp"
#include "runtime/dev.h"
#include "runtime/mem.h"
#include "runtime.hpp"
#include "config.hpp"
#include "cmodel_driver.h"
#include "raw_device.hpp"
#include "thread_local_container.hpp"

using namespace testing;
using namespace cce::runtime;

DVresult drvMemGetAttribute_1(DVdeviceptr vptr, struct DVattribute *attr);
DVresult drvMemGetAttribute_2(DVdeviceptr vptr, struct DVattribute *attr);

class CloudV2NpuDriverTest : public testing::Test
{
protected:
    static void SetUpTestCase()
    {

    }

    static void TearDownTestCase()
    {

    }

    virtual void SetUp()
    {
        rtSetDevice(0);
        std::cout << "a test SetUP" << std::endl;
        rtError_t error;
        Runtime *rtInstance = const_cast<Runtime *>(Runtime::Instance());
        EXPECT_NE(rtInstance, nullptr);
        GlobalContainer::SetHardwareChipType(CHIP_END);
		GlobalMockObject::verify();
    }

    virtual void TearDown()
    {
        GlobalMockObject::verify();
        std::cout << "a test TearDown" << std::endl;
        Runtime *rtInstance = const_cast<Runtime *>(Runtime::Instance());
        EXPECT_NE(rtInstance, nullptr);
        rtDeviceReset(0);
    }
private:
    rtChipType_t originType;
};

TEST_F(CloudV2NpuDriverTest, mem_get_info_ex_00)
{
    rtError_t error;
    size_t free;
    size_t total;
    NpuDriver * rawDrv = new NpuDriver();

    error = rawDrv->MemGetInfoEx(0, RT_MEMORYINFO_DDR_HUGE, &free, &total);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = rawDrv->MemGetInfoEx(0, RT_MEMORYINFO_DDR_NORMAL, &free, &total);
    EXPECT_EQ(error, RT_ERROR_NONE);

    Runtime *rtInstance = (Runtime *)Runtime::Instance();

    error = rawDrv->MemGetInfoEx(0, RT_MEMORYINFO_HBM_HUGE1G, &free, &total);
    EXPECT_EQ(error, RT_ERROR_NONE);

    rtInstance->SetIsSupport1GHugePage(false);

    error = rawDrv->MemGetInfoEx(0, RT_MEMORYINFO_HBM_P2P_HUGE1G, &free, &total);
    EXPECT_EQ(error, RT_ERROR_NONE);

    delete rawDrv;
}

TEST_F(CloudV2NpuDriverTest, DevMemAlloc1GHugePage_1)
{
    rtError_t error;
    uint32_t size = 100;
    void *ptr = malloc(size);
    NpuDriver * rawDrv = new NpuDriver();

    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    rtInstance->SetIsSupport1GHugePage(false);

    MOCKER(halMemAlloc).stubs().will(returnValue(DRV_ERROR_IOCRL_FAIL));
    error = rawDrv->DevMemAlloc1GHugePage(&ptr, size, RT_MEMORY_HBM,  RT_MEMORY_POLICY_HUGE1G_PAGE_ONLY, 255, false);
    EXPECT_EQ(error, RT_ERROR_DRV_IOCTRL);

    error = rawDrv->DevMemAlloc1GHugePage(&ptr, size, RT_MEMORY_HBM, RT_MEMORY_POLICY_HUGE1G_PAGE_ONLY_P2P, 255, true);
    EXPECT_EQ(error, RT_ERROR_DRV_IOCTRL);
    delete rawDrv;
    free(ptr);
}

TEST_F(CloudV2NpuDriverTest, DevMemAlloc1GHugePage_2)
{
    rtError_t error;
    uint32_t size = 100;
    void *ptr = malloc(size);
    NpuDriver * rawDrv = new NpuDriver();

    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    rtInstance->SetIsSupport1GHugePage(false);

    MOCKER(halMemCtl).stubs().will(returnValue(DRV_ERROR_IOCRL_FAIL));
    error = rawDrv->NpuDriver::CheckIfSupport1GHugePage();
    EXPECT_EQ(error, RT_ERROR_FEATURE_NOT_SUPPORT );

    delete rawDrv;
    free(ptr);
}

drvError_t halGetDeviceInfoStub_Cube(uint32_t devId, int32_t moduleType, int32_t infoType, int64_t *value)
{
    *value = RT_AICORE_NUM_25;
    return DRV_ERROR_NONE;
}

TEST_F(CloudV2NpuDriverTest, get_dev_info_for_cubeNum)
{
    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    rtError_t error;
    int32_t devid = 0;
    int64_t core_num = RT_AICORE_NUM_25;
    MOCKER(halGetDeviceInfo).stubs().will(invoke(halGetDeviceInfoStub_Cube));
    error = rtGetDeviceInfo(devid, MODULE_TYPE_AICORE, INFO_TYPE_CUBE_NUM, &core_num);
    EXPECT_EQ(core_num, RT_AICORE_NUM_25 - 1U);
}

TEST_F(CloudV2NpuDriverTest, MemAllocPolicyOffline_fail_2) {
    MOCKER(halMemAlloc)
        .stubs()
        .will(returnValue(DRV_ERROR_INVALID_VALUE));

    rtError_t error;
    NpuDriver * rawDrv = new NpuDriver();
    void *ptr;

    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    rtInstance->SetIsSupport1GHugePage(false);
    error = rawDrv->MemAllocPolicyOffline(&ptr, 10, RT_MEMORY_POLICY_HUGE1G_PAGE_ONLY, RT_MEMORY_HBM, 0);
    EXPECT_EQ(error, RT_ERROR_FEATURE_NOT_SUPPORT);

    delete rawDrv;
}

TEST_F(CloudV2NpuDriverTest, memCopy_sync_adapter)
{
    rtError_t error;
    void *hostPtr;
    void *devPtr;
    size_t free;
    size_t total;
    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    error = rtMalloc(&hostPtr, 64, RT_MEMORY_HBM, DEFAULT_MODULEID);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtMalloc(&devPtr, 64, RT_MEMORY_HBM, DEFAULT_MODULEID);
    EXPECT_EQ(error, RT_ERROR_NONE);

    NpuDriver *rawDrv = new NpuDriver();
    drvError_t drvRet;
    drvRet = rawDrv->MemCopySyncAdapter(devPtr, 64, hostPtr, 64, RT_MEMCPY_HOST_TO_DEVICE, 0xFFFFU);
    EXPECT_EQ(error, DRV_ERROR_NONE);
    drvRet = rawDrv->MemCopySyncAdapter(devPtr, 64, hostPtr, 64, RT_MEMCPY_HOST_TO_DEVICE, 0x1U);
    error = rtFree(devPtr);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtFree(hostPtr);
    EXPECT_EQ(error, RT_ERROR_NONE);
    delete rawDrv;
}

TEST_F(CloudV2NpuDriverTest, DevMemAlloc1GHugePage_3)
{
    rtError_t error;
    uint32_t size = 100;
    void *ptr = malloc(size);
    NpuDriver * rawDrv = new NpuDriver();

    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    rtInstance->SetIsSupport1GHugePage(false);

    MOCKER(halMemAlloc).stubs().will(returnValue(DRV_ERROR_NONE));
    error = rawDrv->DevMemAlloc1GHugePage(&ptr, size, RT_MEMORY_HBM, RT_MEMORY_POLICY_DEFAULT_PAGE_ONLY_P2P, 255, false, true);
    EXPECT_EQ(error, RT_ERROR_FEATURE_NOT_SUPPORT);
    delete rawDrv;
    free(ptr);
}

TEST_F(CloudV2NpuDriverTest, DevMemAlloc1GHugePage_4)
{
    rtError_t error;
    uint32_t size = 100;
    void *ptr = malloc(size);
    NpuDriver * rawDrv = new NpuDriver();

    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    rtInstance->SetIsSupport1GHugePage(false);

    error = rawDrv->DevMemAlloc1GHugePage(&ptr, size, RT_MEMORY_DEFAULT, RT_MEMORY_POLICY_DEFAULT_PAGE_ONLY_P2P, 255, false, true);
    EXPECT_EQ(error, RT_ERROR_FEATURE_NOT_SUPPORT);

    error = rawDrv->DevMemAlloc1GHugePage(&ptr, size, RT_MEMORY_HOST, RT_MEMORY_POLICY_DEFAULT_PAGE_ONLY_P2P, 255, false, true);
    EXPECT_EQ(error, RT_ERROR_INVALID_VALUE);
    delete rawDrv;
    free(ptr);
}

TEST_F(CloudV2NpuDriverTest, AllocFastRingBufferAndDispatch)
{
    NpuDriver *rawDrv = new NpuDriver();
     rtError_t error;
    void *ptr = nullptr;
    error = rawDrv->AllocFastRingBufferAndDispatch(&ptr, 2, 0, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    uint64_t timeoutInterval;
    error = rawDrv->QueryOpExecTimeoutInterval(0, 0, timeoutInterval);
    EXPECT_EQ(error, RT_ERROR_NONE);
    rawDrv->FreeFastRingBuffer(ptr, 2, 0);
    delete rawDrv;
}

TEST_F(CloudV2NpuDriverTest, DrvEschedManage_stub_swapout)
{
    rtError_t error;

    uint32_t devId = 0;
    int32_t timeout = 100;
    uint32_t eschedTid = 50;
    uint32_t grpId = 10;
    struct halReportRecvInfo info;
    info.report_cqe_num = 0;

    NpuDriver *rawDrv = new NpuDriver();

    MOCKER(halEschedThreadSwapout).stubs().will(returnValue(DRV_ERROR_INVALID_VALUE));
    error = rawDrv->DrvEschedManage(devId, timeout, eschedTid, grpId, &info);
    EXPECT_EQ(error, DRV_ERROR_INVALID_VALUE);

    delete rawDrv;
}

TEST_F(CloudV2NpuDriverTest, DrvEschedManage_stub_swapout_waitEvent)
{
    rtError_t error;

    uint32_t devId = 0;
    int32_t timeout = 100;
    uint32_t eschedTid = 50;
    uint32_t grpId = 10;
    struct halReportRecvInfo info;
    info.report_cqe_num = 0;

    NpuDriver *rawDrv = new NpuDriver();

    MOCKER(halEschedThreadSwapout).stubs().will(returnValue(DRV_ERROR_NONE));
    MOCKER(halEschedWaitEvent).stubs().will(returnValue(DRV_ERROR_INVALID_VALUE));
    error = rawDrv->DrvEschedManage(devId, timeout, eschedTid, grpId, &info);
    EXPECT_EQ(error, DRV_ERROR_INVALID_VALUE);

    delete rawDrv;
}

TEST_F(CloudV2NpuDriverTest, DrvEschedManage_stub_swapout_waitEvent_ReportRecv)
{
    rtError_t error;

    uint32_t devId = 0;
    int32_t timeout = 100;
    uint32_t eschedTid = 50;
    uint32_t grpId = 10;
    struct halReportRecvInfo info;
    info.report_cqe_num = 0;

    NpuDriver *rawDrv = new NpuDriver();

    MOCKER(halEschedThreadSwapout).stubs().will(returnValue(DRV_ERROR_NONE));
    MOCKER(halEschedWaitEvent).stubs().will(returnValue(DRV_ERROR_NONE));
    MOCKER(halCqReportRecv).stubs().will(returnValue(DRV_ERROR_INVALID_VALUE));
    error = rawDrv->DrvEschedManage(devId, timeout, eschedTid, grpId, &info);
    EXPECT_EQ(error, DRV_ERROR_INVALID_VALUE);

    delete rawDrv;
}

TEST_F(CloudV2NpuDriverTest, host_register)
{
    rtError_t error;
    int ptr = 10;
    void **devPtr;
    NpuDriver *rawDrv = new NpuDriver();

    MOCKER(halHostRegister)
        .stubs()
        .will(returnValue(DRV_ERROR_NONE));

    MOCKER(halHostUnregisterEx)
        .stubs()
        .will(returnValue(DRV_ERROR_NONE));

    error = rawDrv->HostRegister(&ptr, 100 ,RT_HOST_REGISTER_MAPPED, devPtr, 0);
    EXPECT_EQ(error, DRV_ERROR_NONE);

    error = rawDrv->HostUnregister(&ptr, 0);
    EXPECT_EQ(error, DRV_ERROR_NONE);

    delete rawDrv;
}

TEST_F(CloudV2NpuDriverTest, memcpy_all_type)
{
    rtError_t error;
    uint32_t dst=0, src=0;

    MOCKER(drvMemcpy)
        .stubs()
        .will(returnValue(DRV_ERROR_NONE));
    NpuDriver * rawDrv = new NpuDriver();

    error = rawDrv->MemCopySync(&dst, 4, &src, 4, RT_MEMCPY_HOST_TO_HOST);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rawDrv->MemCopySync(&dst, 4, &src, 4, RT_MEMCPY_HOST_TO_DEVICE);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rawDrv->MemCopySync(&dst, 4, &src, 4, RT_MEMCPY_DEVICE_TO_HOST);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rawDrv->MemCopySync(&dst, 4, &src, 4, RT_MEMCPY_DEVICE_TO_DEVICE);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rawDrv->MemCopySync(&dst, 4, &src, 4, RT_MEMCPY_MANAGED);
    EXPECT_EQ(error, RT_ERROR_NONE);

    volatile uint64_t copyFd = 0;
    error = rawDrv->MemCopyAsync(&dst, 4, &src, 4, RT_MEMCPY_RESERVED, copyFd);
    EXPECT_NE(error, RT_ERROR_NONE);
    error = rawDrv->MemCopyAsyncWaitFinish(copyFd);
    EXPECT_EQ(error, RT_ERROR_NONE);
    delete rawDrv;
}

TEST_F(CloudV2NpuDriverTest, drv_memcpy_not_support)
{
    uint32_t dst = 0U, src = 0U;
    NpuDriver * rawDrv = new NpuDriver();
    MOCKER(cmodelDrvMemcpy)
        .stubs()
        .will(returnValue(DRV_ERROR_NOT_SUPPORT));

    rtError_t error = rawDrv->MemCopySync(&dst, 4, &src, 4, RT_MEMCPY_HOST_TO_HOST);
    EXPECT_EQ(error, RT_ERROR_DRV_NOT_SUPPORT);
    delete rawDrv;
}

TEST_F(CloudV2NpuDriverTest, memcpy_invalid_type)
{
    rtError_t error;
    uint32_t dst=0, src=0;
    NpuDriver * rawDrv = new NpuDriver();

    error = rawDrv->MemCopySync(&dst, 4, &src, 4, RT_MEMCPY_RESERVED);
    EXPECT_NE(error, RT_ERROR_NONE);

    MOCKER(drvMemcpy).stubs().will(returnValue(DRV_ERROR_INVALID_VALUE));
    error = rawDrv->MemCopySync(&dst, 4, &src, 4, RT_MEMCPY_RESERVED);
    EXPECT_NE(error, RT_ERROR_NONE);

    MOCKER(cmodelDrvMemcpy).stubs().will(returnValue(DRV_ERROR_INVALID_VALUE));
    volatile uint64_t copyFd = 0;
    error = rawDrv->MemCopyAsync(&dst, 4, &src, 4, RT_MEMCPY_DEVICE_TO_HOST, copyFd);
    EXPECT_NE(error, RT_ERROR_NONE);
    delete rawDrv;
}

TEST_F(CloudV2NpuDriverTest, mem_get_info_ex_01)
{
    rtError_t error;
    size_t free;
    size_t total;
    NpuDriver * rawDrv = new NpuDriver();
    MOCKER(halMemGetInfo).stubs().will(returnValue(DRV_ERROR_INVALID_VALUE));

    error = rawDrv->MemGetInfoEx(0, RT_MEMORYINFO_DDR_HUGE, &free, &total);
    EXPECT_EQ(error, RT_ERROR_DRV_INPUT);
    delete rawDrv;
}

TEST_F(CloudV2NpuDriverTest, mem_get_info)
{
    rtError_t error;
    size_t free;
    size_t total;
    NpuDriver * rawDrv = new NpuDriver();
    MOCKER(halMemGetInfo).stubs().will(returnValue(DRV_ERROR_INVALID_VALUE));

    error = rawDrv->MemGetInfo(0, true, &free, &total);
    EXPECT_EQ(error, RT_ERROR_DRV_INPUT);
    delete rawDrv;
}

TEST_F(CloudV2NpuDriverTest, get_device_info_failed)
{
    rtError_t error;
    size_t free;
    size_t total;
    NpuDriver * rawDrv = new NpuDriver();
    MOCKER(halGetDeviceInfo).stubs().will(returnValue(DRV_ERROR_INVALID_VALUE));

    int64_t hardwareVersion = 0;
    error = rawDrv->GetDevInfo(0, MODULE_TYPE_SYSTEM, INFO_TYPE_VERSION, &hardwareVersion);
    EXPECT_EQ(error, RT_ERROR_DRV_INPUT);
    delete rawDrv;
}

TEST_F(CloudV2NpuDriverTest, SupportNumaTsMemCtrl)
{
    NpuDriver * driver = new NpuDriver();
    int64_t val = RT_CAPABILITY_SUPPORT;
    auto ret = driver->SupportNumaTsMemCtrl(val);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    EXPECT_EQ(val, RT_CAPABILITY_NOT_SUPPORT);
    delete driver;
    GlobalMockObject::verify();
}

TEST_F(CloudV2NpuDriverTest, get_aicpu_deploy_raw)
{
    NpuDriver * driver = new NpuDriver();
    uint32_t res;
    res = driver->GetAicpuDeploy();
    EXPECT_NE(res, AICPU_DEPLOY_CROSS_THREAD);
    delete driver;
}

TEST_F(CloudV2NpuDriverTest, mem_alloc_ex)
{
    rtError_t error;
    uint32_t dst=0, src=0;
    NpuDriver * rawDrv = new NpuDriver();

    error = rawDrv->MemAllocEx(NULL, 0, RT_MEMORY_DDR_NC);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rawDrv->MemFreeEx(NULL);
    EXPECT_EQ(error, RT_ERROR_NONE);
    delete rawDrv;

}

TEST_F(CloudV2NpuDriverTest, memory_attributes_fail)
{
    rtError_t error;
    NpuDriver * rawDrv = new NpuDriver();
    rtPointerAttributes_t attributes;

        MOCKER(drvMemGetAttribute)
        .stubs()
        .will(returnValue(DRV_ERROR_NONE));

    error = rawDrv->PointerGetAttributes(&attributes,NULL);
    EXPECT_NE(error, RT_ERROR_NONE);

    delete rawDrv;
}

TEST_F(CloudV2NpuDriverTest, event_id_alloc)
{
    rtError_t error;
    int32_t id = 0;
    uint32_t tsId = 0;

    MOCKER(halResourceIdAlloc).stubs().will(returnValue(DRV_ERROR_NO_EVENT_RESOURCES));
    NpuDriver * rawDrv = new NpuDriver();

    error = rawDrv->EventIdAlloc(&id, 1, tsId, 0x01U, 0U);
    ASSERT_EQ(error, RT_ERROR_DRV_NO_EVENT_RESOURCES);

    delete rawDrv;
}

TEST_F(CloudV2NpuDriverTest, dev_memory_failed)
{
    void *mem;
    rtError_t error;

    MOCKER(halMemAlloc)
        .stubs()
        .will(returnValue(DRV_ERROR_INVALID_VALUE));

    MOCKER(halMemFree)
        .stubs()
        .will(returnValue(DRV_ERROR_INVALID_VALUE));

    error = rtMalloc(&mem, 128, RT_MEMORY_HBM, DEFAULT_MODULEID);
    EXPECT_NE(error, RT_ERROR_NONE);

    error = rtFree(&error);
    EXPECT_NE(error, RT_ERROR_NONE);
}

TEST_F(CloudV2NpuDriverTest, host_memory_failed)
{
    void *mem;
    rtError_t error;

    MOCKER(halMemAlloc)
        .stubs()
        .will(returnValue(DRV_ERROR_INVALID_VALUE));

    MOCKER(cmodelDrvFreeHost)
        .stubs()
        .will(returnValue(DRV_ERROR_INVALID_VALUE));

    error = rtMallocHost(&mem, 128, DEFAULT_MODULEID);
    EXPECT_NE(error, RT_ERROR_NONE);

    error = rtFreeHost(&error);
    EXPECT_NE(error, RT_ERROR_NONE);
}

TEST_F(CloudV2NpuDriverTest, managed_memory_failed)
{
    void *mem;
    rtError_t error;

    MOCKER(halMemAlloc)
        .stubs()
        .will(returnValue(DRV_ERROR_INVALID_VALUE));

    NpuDriver * rawDrv = new NpuDriver();
    MOCKER_CPP_VIRTUAL(rawDrv, &NpuDriver::ManagedMemFree)
        .stubs()
        .will(returnValue(RT_ERROR_INVALID_VALUE));

    error = rtMemAllocManaged(&mem, 128, 0, DEFAULT_MODULEID);
    EXPECT_NE(error, RT_ERROR_NONE);

    error = rtMemFreeManaged(&error);
    EXPECT_NE(error, RT_ERROR_NONE);
    delete rawDrv;
}

TEST_F(CloudV2NpuDriverTest, huge_page_managed_memory_failed_02)
{
    void *mem;
    rtError_t error;

    MOCKER(halMemAlloc)
        .stubs()
        .will(returnValue(DRV_ERROR_INVALID_VALUE));

    error = rtMemAllocManaged(&mem, 1024*1025, 0, DEFAULT_MODULEID);
    EXPECT_NE(error, RT_ERROR_NONE);
}

TEST_F(CloudV2NpuDriverTest, huge_page_managed_memory_failed_03)
{
    void *mem;
    rtError_t error;

    MOCKER(halMemAlloc)
        .stubs()
        .will(returnValue(DRV_ERROR_OUT_OF_MEMORY));

    error = rtMemAllocManaged(&mem, 1024*1024*1025, 0, DEFAULT_MODULEID);
    EXPECT_NE(error, RT_ERROR_NONE);
}

TEST_F(CloudV2NpuDriverTest, huge_page_managed_memory_failed_04)
{
    void *mem;
    rtError_t error;

    MOCKER(halMemAlloc)
        .stubs()
        .will(returnValue(DRV_ERROR_OUT_OF_MEMORY));

    error = rtMemAllocManaged(NULL, 10, 0, DEFAULT_MODULEID);
    EXPECT_NE(error, RT_ERROR_NONE);
}

TEST_F(CloudV2NpuDriverTest, utils_get_module_name)
{
    std::string moduleName = RT_GET_MODULE_NAME(RUNTIME_MODULE_ID);
    EXPECT_EQ(moduleName, "RUNTIME");
}

TEST_F(CloudV2NpuDriverTest, memory_failed)
{
    void *mem;
    rtError_t error;

    MOCKER(cmodelDrvMemcpy)
        .stubs()
        .will(returnValue(DRV_ERROR_INVALID_VALUE));

    error = rtMemcpy(&error, 100, &mem, 100, RT_MEMCPY_DEVICE_TO_DEVICE);
    EXPECT_NE(error, RT_ERROR_NONE);
}

drvError_t halSqMemGet_stub(uint32_t devId, struct halSqMemGetInput *sqMemGetInput, struct halSqMemGetOutput *sqMemGetOutput )
{
    drvError_t error = DRV_ERROR_INVALID_DEVICE;
    return error;
}

TEST_F(CloudV2NpuDriverTest, command_send_fail)
{

    rtError_t rt;
    int32_t cmdCount = 0;
    NpuDriver * rawDrv = new NpuDriver();
    uint32_t tsId = 0;
    int32_t deviceId = 0;
    int32_t sqId = 0;
	uint32_t cqId = 0;
    uint32_t pos = 0;
    rtTsCmdSqBuf_t * command;

    MOCKER(halSqMemGet)
             .stubs()
             .will(invoke(halSqMemGet_stub));

    rt = rawDrv->CommandOccupy(sqId, &command, 1, deviceId, tsId, &pos);
    EXPECT_NE(rt, RT_ERROR_NONE);

    MOCKER(halSqMsgSend).stubs().will(returnValue(DRV_ERROR_INVALID_VALUE));

    rt = rawDrv->CommandSend(sqId, command, 1, deviceId, tsId, 1);
    EXPECT_NE(rt, RT_ERROR_NONE);

    MOCKER(halCqReportGet).stubs().will(returnValue(DRV_ERROR_INVALID_VALUE));
    rt = rawDrv->ReportWait((void **)NULL, &cmdCount, deviceId, tsId, cqId);
    EXPECT_NE(rt, RT_ERROR_NONE);

    MOCKER(halCqReportIrqWait).stubs().will(returnValue(DRV_ERROR_INVALID_VALUE));
    rt = rawDrv->ReportWait((void **)NULL, &cmdCount, deviceId, tsId, cqId);
    EXPECT_NE(rt, RT_ERROR_NONE);

    MOCKER(halReportRelease).stubs().will(returnValue(DRV_ERROR_INVALID_VALUE));
    rt = rawDrv->ReportRelease(deviceId, tsId, cqId, DRV_NORMAL_TYPE);
    EXPECT_NE(rt, RT_ERROR_NONE);

    delete rawDrv;
}

TEST_F(CloudV2NpuDriverTest, devm_memory_pctrace)
{
    rtError_t error;
    NpuDriver * rawDrv = new NpuDriver();

    MOCKER(halMemAlloc).stubs().will(returnValue(DRV_ERROR_INVALID_VALUE));
    error = rawDrv->DevMemAllocForPctrace((void **)NULL, 0, 0);
    EXPECT_NE(error, RT_ERROR_NONE);

    MOCKER(halMemFree).stubs().will(returnValue(DRV_ERROR_INVALID_VALUE));
    error = rawDrv->DevMemFreeForPctrace((void *)NULL);
    EXPECT_NE(error, RT_ERROR_NONE);

    delete rawDrv;
}

TEST_F(CloudV2NpuDriverTest, devm_memory_pctrace_online)
{
    rtError_t error;
    NpuDriver * rawDrv = new NpuDriver();

    MOCKER_CPP_VIRTUAL(rawDrv, &NpuDriver::GetRunMode)
                        .stubs()
                        .will(returnValue(1));

    MOCKER(halMemAlloc).stubs().will(returnValue(DRV_ERROR_INVALID_VALUE));
    error = rawDrv->DevMemAllocForPctrace((void **)NULL, 0, 0);
    EXPECT_NE(error, RT_ERROR_NONE);

    delete rawDrv;
}

TEST_F(CloudV2NpuDriverTest, device_memory_alloc)
{
    rtError_t error;
    NpuDriver * rawDrv = new NpuDriver();
    uint64_t size = HUGE_PAGE_MEM_CRITICAL_VALUE + 1;

    MOCKER(halMemAlloc).stubs().will(returnValue(DRV_ERROR_INVALID_VALUE));
    error = rawDrv->DevMemAlloc((void **)NULL, size , (rtMemType_t)0, 0);
    EXPECT_NE(error, RT_ERROR_NONE);

    error = rawDrv->DevMemAlloc((void **)NULL, 100 , (rtMemType_t)0, 0);
    EXPECT_NE(error, RT_ERROR_NONE);

    MOCKER(halMemFree).stubs().will(returnValue(DRV_ERROR_INVALID_VALUE));
    error = rawDrv->DevMemFree((void *)NULL, 0);
    EXPECT_NE(error, RT_ERROR_NONE);

    delete rawDrv;
}

TEST_F(CloudV2NpuDriverTest, device_memory_alloc_offline_p2p)
{
    rtError_t error;
    NpuDriver * rawDrv = new NpuDriver();
    uint32_t size = 100;
    void *ptr = NULL;

    rawDrv->runMode_ = RT_RUN_MODE_OFFLINE;

    error = rawDrv->DevMemAlloc(&ptr, size , (rtMemType_t)RT_MEMORY_POLICY_HUGE_PAGE_FIRST_P2P, 0);
    EXPECT_EQ(error, RT_ERROR_FEATURE_NOT_SUPPORT);

    error = rawDrv->DevMemAlloc(&ptr, size , (rtMemType_t)RT_MEMORY_POLICY_HUGE_PAGE_ONLY_P2P, 0);
    EXPECT_EQ(error, RT_ERROR_FEATURE_NOT_SUPPORT);

    error = rawDrv->DevMemAlloc(&ptr, size , (rtMemType_t)RT_MEMORY_POLICY_DEFAULT_PAGE_ONLY_P2P, 0);
    EXPECT_EQ(error, RT_ERROR_FEATURE_NOT_SUPPORT);

    delete rawDrv;
}

TEST_F(CloudV2NpuDriverTest, con_device_memory_alloc)
{
    rtError_t error;
    void *pp, *pt;
    NpuDriver * rawDrv = new NpuDriver();
    uint64_t size = HUGE_PAGE_MEM_CRITICAL_VALUE + 1;

    MOCKER(halMemAlloc).stubs().will(returnValue(DRV_ERROR_NONE));
    error = rawDrv->DevMemAllocConPhy(&pp, size , (rtMemType_t)0, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    MOCKER(halMemFree).stubs().will(returnValue(DRV_ERROR_NONE));
    error = rawDrv->DevMemConPhyFree(pp, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    delete rawDrv;
}

TEST_F(CloudV2NpuDriverTest, cached_memory_alloc_failed)
{
    rtError_t error;
    void *pp, *pt;
    NpuDriver * rawDrv = new NpuDriver();
    uint64_t size = HUGE_PAGE_MEM_CRITICAL_VALUE + 1;

    MOCKER(halMemAlloc).stubs().will(returnValue(DRV_ERROR_INVALID_VALUE));
    error = rawDrv->DevMemAllocCached(&pp, size, (rtMemType_t)0, 0);
    EXPECT_NE(error, RT_ERROR_NONE);

    delete rawDrv;
}

TEST_F(CloudV2NpuDriverTest, cached_memory_alloc_HUGE_PAGE)
{
    rtError_t error;
    void *pp, *pt;
    NpuDriver * rawDrv = new NpuDriver();
    uint64_t size = HUGE_PAGE_MEM_CRITICAL_VALUE + 1;

    error = rawDrv->DevMemAllocCached(&pp, size, RT_MEMORY_POLICY_HUGE_PAGE_ONLY, 0);
    EXPECT_NE(error, RT_ERROR_NONE);

    delete rawDrv;
}

TEST_F(CloudV2NpuDriverTest, invalidate_cache)
{
    rtError_t error;
    void *pp, *pt;
    NpuDriver * rawDrv = new NpuDriver();
    uint64_t size = HUGE_PAGE_MEM_CRITICAL_VALUE + 1;

    error = rawDrv->DevMemInvalidCache((uint64_t)(uintptr_t)pp, size);
    EXPECT_EQ(error, RT_ERROR_NONE);

    delete rawDrv;
}

TEST_F(CloudV2NpuDriverTest, con_device_memory_alloc_fail)
{
    rtError_t error;
    void *pp, *pt;
    NpuDriver * rawDrv = new NpuDriver();
    uint64_t size = HUGE_PAGE_MEM_CRITICAL_VALUE + 1;

    MOCKER(halMemAlloc).stubs().will(returnValue(DRV_ERROR_INVALID_VALUE));
    error = rawDrv->DevMemAllocConPhy(&pt, size , (rtMemType_t)0, 0);
    EXPECT_NE(error, RT_ERROR_NONE);

    MOCKER(halMemFree).stubs().will(returnValue(DRV_ERROR_INVALID_VALUE));
    error = rawDrv->DevMemConPhyFree(pt, 0);
    EXPECT_NE(error, RT_ERROR_NONE);

    delete rawDrv;
}


TEST_F(CloudV2NpuDriverTest, memory_dev_alloc_online_01)
{
    rtError_t error;
    NpuDriver * rawDrv = new NpuDriver();
    uint64_t size = HUGE_PAGE_MEM_CRITICAL_VALUE + 1;

    MOCKER(halMemAlloc).stubs().will(returnValue(DRV_ERROR_INVALID_VALUE));
    error = rawDrv->DevMemAllocOnline((void **)NULL, size , (rtMemType_t)0, 0);
    EXPECT_NE(error, RT_ERROR_NONE);

    error = rawDrv->DevMemAllocOnline((void **)NULL, 100 , (rtMemType_t)0, 0);
    EXPECT_NE(error, RT_ERROR_NONE);

    MOCKER(halMemFree).stubs().will(returnValue(DRV_ERROR_INVALID_VALUE));
    error = rawDrv->DevMemFree((void *)NULL, 0);
    EXPECT_NE(error, RT_ERROR_NONE);

    delete rawDrv;
}

TEST_F(CloudV2NpuDriverTest, memory_dev_free_online_01)
{
    rtError_t error;

    uint32_t size = 100;
    void *ptr = NULL;
    NpuDriver * rawDrv = new NpuDriver();

    error = rawDrv->DevMemAlloc(&ptr, size , (rtMemType_t)0, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    MOCKER_CPP_VIRTUAL(rawDrv, &NpuDriver::GetRunMode)
                        .stubs()
                        .will(returnValue(1));

    MOCKER(halMemFree).stubs().will(returnValue(DRV_ERROR_NONE));
    error = rawDrv->DevMemFree(ptr, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    GlobalMockObject::verify();

    MOCKER_CPP_VIRTUAL(rawDrv, &NpuDriver::GetRunMode)
                        .stubs()
                        .will(returnValue(3));

    error = rawDrv->DevMemFree(ptr, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    delete rawDrv;
}

TEST_F(CloudV2NpuDriverTest, memory_dev_alloc_online_04)
{
    rtError_t error;
    uint32_t size = 100;
    void *ptr = malloc(size);
    NpuDriver * rawDrv = new NpuDriver();

    MOCKER(halMemAlloc).stubs().will(returnValue(DRV_ERROR_NONE));
    error = rawDrv->DevMemAllocOnline(&ptr, size , (rtMemType_t)0, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    delete rawDrv;
    free(ptr);
}

TEST_F(CloudV2NpuDriverTest, memory_dev_alloc_online_05)
{
    rtError_t error;
    uint32_t size = 100;
    void *ptr = malloc(size);
    NpuDriver * rawDrv = new NpuDriver();

    MOCKER(halMemAlloc).stubs().will(returnValue(DRV_ERROR_NONE));
    error = rawDrv->DevMemAllocOnline(&ptr, size , (rtMemType_t)RT_MEMORY_P2P_HBM, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    delete rawDrv;
    free(ptr);
}

TEST_F(CloudV2NpuDriverTest, memory_dev_alloc_online_06)
{
    rtError_t error;
    uint32_t size = 100;
    void *ptr = malloc(size);
    NpuDriver * rawDrv = new NpuDriver();

    MOCKER(halMemAlloc).stubs().will(returnValue(DRV_ERROR_NONE));
    error = rawDrv->DevMemAllocHugePageManaged(&ptr, size ,RT_MEMORY_HBM, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);
    delete rawDrv;
    free(ptr);
}

TEST_F(CloudV2NpuDriverTest, memory_dev_alloc_online_07)
{
    rtError_t error;
    uint32_t size = 100;
    void *ptr = malloc(size);
    //void *ptr;
    NpuDriver * rawDrv = new NpuDriver();

    MOCKER(halMemAlloc).stubs().will(returnValue(DRV_ERROR_NONE));
    error = rawDrv->DevMemAllocHugePageManaged(&ptr, size ,RT_MEMORY_HBM, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);
    delete rawDrv;
    free(ptr);
}

TEST_F(CloudV2NpuDriverTest, memory_dev_alloc_online_10)
{
    rtError_t error;
    uint32_t size = 100;
    void *ptr = malloc(size);
    //void *ptr;
    NpuDriver * rawDrv = new NpuDriver();

    MOCKER(halMemAlloc).stubs().will(returnValue(DRV_ERROR_NONE));
    error = rawDrv->DevMemAllocHugePageManaged(&ptr, size ,RT_MEMORY_HOST_SVM, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);
    delete rawDrv;
    free(ptr);
}

TEST_F(CloudV2NpuDriverTest, memory_dev_alloc_online_11)
{
    rtError_t error;
    uint32_t size = 100;
    void *ptr = malloc(size);
    NpuDriver * rawDrv = new NpuDriver();

    MOCKER(halMemAlloc).stubs().will(returnValue(DRV_ERROR_IOCRL_FAIL));
    error = rawDrv->DevMemAllocHugePageManaged(&ptr, size, RT_MEMORY_HBM, 0, 255, false, true);
    EXPECT_EQ(error, RT_ERROR_DRV_IOCTRL);
    delete rawDrv;
    free(ptr);
}


TEST_F(CloudV2NpuDriverTest, DevMemAllocManaged_11)
{
    rtError_t error;
    uint32_t size = 100;
    void *ptr = malloc(size);
    NpuDriver * rawDrv = new NpuDriver();

    MOCKER(halMemAlloc).stubs().will(returnValue(DRV_ERROR_IOCRL_FAIL));
    error = rawDrv->DevMemAllocManaged(&ptr, size, RT_MEMORY_HBM, 0, 255, false, true);
    EXPECT_EQ(error, RT_ERROR_DRV_IOCTRL);
    delete rawDrv;
    free(ptr);
}

TEST_F(CloudV2NpuDriverTest, memory_dev_alloc_offline_01)
{
    rtError_t error;
    uint32_t size = 100;
    void *ptr = NULL;
    NpuDriver * rawDrv = new NpuDriver();
    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    rtInstance->SetIsSupport1GHugePage(false);

    error = rawDrv->DevMemAllocOffline(&ptr, size, RT_MEMORY_HBM | RT_MEMORY_POLICY_HUGE1G_PAGE_ONLY, 0);
    EXPECT_EQ(error, RT_ERROR_FEATURE_NOT_SUPPORT);

    delete rawDrv;
}

TEST_F(CloudV2NpuDriverTest, managed_memory_alloc)
{
    rtError_t error;
    NpuDriver * rawDrv = new NpuDriver();

    MOCKER(halMemFree).stubs().will(returnValue(DRV_ERROR_INVALID_VALUE));
    error = rawDrv->ManagedMemFree((void *)NULL);
    EXPECT_NE(error, RT_ERROR_NONE);

    delete rawDrv;
}

TEST_F(CloudV2NpuDriverTest, get_device_count)
{
    rtError_t error;
    int32_t devHandle;
    NpuDriver * rawDrv = new NpuDriver();
    int32_t deviceCount = 1;
    uint32_t deviceId = 1;

    MOCKER(drvGetDevNum).stubs().will(returnValue(DRV_ERROR_INVALID_VALUE));
    error = rawDrv->GetDeviceCount(&deviceCount);
    EXPECT_NE(error, RT_ERROR_NONE);

    MOCKER(drvGetDevIDs).stubs().will(returnValue(DRV_ERROR_INVALID_VALUE));
    error = rawDrv->GetDeviceIDs(&deviceId, 0);
    EXPECT_NE(error, RT_ERROR_NONE);

    delete rawDrv;
}

TEST_F(CloudV2NpuDriverTest, stream_event_id_alloc_fail)
{
    rtError_t error;
    int32_t id = 1;
    int32_t idOverFlow = 9999;

    MOCKER(halResourceIdFree).stubs().will(returnValue(DRV_ERROR_INVALID_VALUE));
    NpuDriver * rawDrv = new NpuDriver();

    error = rawDrv->StreamIdFree(idOverFlow, -1, 0);
    EXPECT_NE(error, RT_ERROR_NONE);

    error = rawDrv->EventIdFree(idOverFlow, 0, 0);
    EXPECT_NE(error, RT_ERROR_NONE);

    error = rawDrv->EventIdFree(1024, 0, 0);
    EXPECT_EQ(error, RT_ERROR_DRV_INPUT);

    error = rawDrv->EventIdFree(idOverFlow, 0, -1);
    EXPECT_EQ(error, RT_ERROR_DRV_INPUT);

    error = rawDrv->EventIdFree(idOverFlow, 0, 100);
    EXPECT_EQ(error, RT_ERROR_DRV_INPUT);

    error = rawDrv->ModelIdFree(idOverFlow, 0, 0);
    EXPECT_EQ(error, RT_ERROR_DRV_INPUT);

    delete rawDrv;
}

TEST_F(CloudV2NpuDriverTest, memory_address)
{
    rtError_t error;
    NpuDriver * rawDrv = new NpuDriver();
    DMA_ADDR dmaAddr;
    dmaAddr.fixed_size = 0;

    MOCKER(drvMemConvertAddr)
            .stubs()
            .will(returnValue(DRV_ERROR_NONE));

    error = rawDrv->MemConvertAddr(0, 0, 0, &dmaAddr);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rawDrv->MemDestroyAddr((struct DMA_ADDR *)NULL);
    EXPECT_EQ(error, RT_ERROR_NONE);

    dmaAddr.fixed_size = 1;
    error = rawDrv->MemConvertAddr(0, 0, 0, &dmaAddr);
    EXPECT_NE(error, RT_ERROR_NONE);

    error = rawDrv->MemDestroyAddr((struct DMA_ADDR *)NULL);
    EXPECT_EQ(error, RT_ERROR_NONE);

    dmaAddr.fixed_size = 0;
    error = rawDrv->MemConvertAddr(0, 0, 1, &dmaAddr);
    EXPECT_NE(error, RT_ERROR_NONE);

    error = rawDrv->MemDestroyAddr((struct DMA_ADDR *)NULL);
    EXPECT_EQ(error, RT_ERROR_NONE);

    MOCKER(drvMemDestroyAddr).stubs().will(returnValue(DRV_ERROR_INVALID_VALUE));
    error = rawDrv->MemDestroyAddr((struct DMA_ADDR *)NULL);
    EXPECT_EQ(error, RT_ERROR_DRV_INPUT);
    delete rawDrv;
}

TEST_F(CloudV2NpuDriverTest, get_dev_info)
{
    rtError_t error;
    int32_t devid = 0;
    int64_t hardwareVersion = 0;
    error = rtGetDeviceInfo(devid, MODULE_TYPE_SYSTEM, INFO_TYPE_VERSION, &hardwareVersion);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtGetDeviceInfo(devid, MODULE_TYPE_SYSTEM, INFO_TYPE_VERSION, NULL);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(CloudV2NpuDriverTest, buffer_allocator_count)
{
    BufferAllocator alloc(sizeof(uint32_t), 16, 8);
    EXPECT_EQ(alloc.itemSize_, sizeof(uint32_t));
    EXPECT_EQ(alloc.initCount_, 8);
    EXPECT_EQ(alloc.maxCount_, 8);
    EXPECT_EQ(alloc.currentCount_, 8);

    BufferAllocator alloc1(sizeof(uint32_t), 1000, 2000);
    EXPECT_EQ(alloc1.initCount_, 1000);
    EXPECT_EQ(alloc1.maxCount_, 2000);
}

TEST_F(CloudV2NpuDriverTest, buffer_allocator_test)
{
    BufferAllocator alloc(sizeof(uint32_t), 64, 128);
    uint32_t *temp, *temp1;
    uint32_t id, id1;
    id = alloc.AllocId();
    temp = (uint32_t*)alloc.GetItemById(id);
    EXPECT_NE(alloc.bitmap_.freeBitmap_[0], -1);

    alloc.FreeByItem(temp);
    EXPECT_EQ(alloc.bitmap_.freeBitmap_[0], -1);

    temp1 = (uint32_t*)alloc.GetItemById(id);
    EXPECT_EQ((uint64_t)temp1, 0);

    id1 = alloc.GetIdByItem(temp);
    EXPECT_EQ(id1, -1);

    for (int i = 0; i <128; i++)
    {
        id = alloc.AllocId();
        temp = (uint32_t*)alloc.GetItemById(id);
        id1 = alloc.GetIdByItem(temp);
        EXPECT_EQ(id, id1);
    }
    EXPECT_EQ(alloc.bitmap_.freeBitmap_[0], 0);
    EXPECT_EQ(alloc.bitmap_.freeBitmap_[1], 0);
}

TEST_F(CloudV2NpuDriverTest, buffer_allocator_test1)
{
    BufferAllocator alloc(sizeof(int32_t), 64, 128);
    int32_t id = 0;
    alloc.currentCount_ = alloc.maxCount_;
    MOCKER_CPP(&Bitmap::AllocId)
        .stubs()
        .will(returnValue(-1));
    id = alloc.AllocId();
    EXPECT_EQ(id, -1);
}

// itemSzie = 0,  constructor error
TEST_F(CloudV2NpuDriverTest, buffer_allocator_error1)
{
    BufferAllocator alloc(0);  // itemSize = 0

    auto id = alloc.AllocId();
    EXPECT_EQ(id, -1);

    auto ptr = alloc.GetItemById(0); // pool_ null return
    EXPECT_EQ(ptr, nullptr);

    id = alloc.GetIdByItem(ptr); // pool_ null return
    EXPECT_EQ(id, -1);
}

void *DefaultAllocFail(size_t size, void *para)
{
    return nullptr;
}

void FreeFuncFail(void *addr, void *para)
{
    return;
}

// allocFunc return null,  constructor error
TEST_F(CloudV2NpuDriverTest, buffer_allocator_error2)
{
    BufferAllocator alloc(sizeof(uint32_t), 64, 128, BufferAllocator::LINEAR, DefaultAllocFail, FreeFuncFail);

    auto id = alloc.AllocId();
    EXPECT_EQ(id, -1);  // pool null return -1
}

// 1st call ok, 2end call fail
void *DefaultAllocFail2(size_t size, void *para)
{
    static int flag = 0;

    if(flag > 0) {
        return nullptr;
    }

    flag = 1;
    return malloc(size);
}

void FreeFuncFail2(void *addr, void *para)
{
    free(addr);
}

// allocFunc return ok then return nok
// init size 4, alloc 4 times
// then call allocFunc return fail
TEST_F(CloudV2NpuDriverTest, buffer_allocator_error3)
{
    BufferAllocator alloc(sizeof(uint32_t), 4, 8, BufferAllocator::LINEAR, DefaultAllocFail2, FreeFuncFail2);

    auto id = alloc.AllocId();
    id = alloc.AllocId();
    id = alloc.AllocId();
    id = alloc.AllocId();
    EXPECT_NE(id, -1);

    id = alloc.AllocId();
    EXPECT_EQ(id, -1);  // allc func fail return -1
}

TEST_F(CloudV2NpuDriverTest, bitmap_occypy_test1)
{
    Bitmap bitmap(128);
    auto err = bitmap.AllocBitmap();
    EXPECT_EQ(err, RT_ERROR_NONE);
    bitmap.OccupyId(1);
    auto isOccupy = bitmap.IsIdOccupied(1);
    EXPECT_EQ(isOccupy, true);
}

TEST_F(CloudV2NpuDriverTest, driver_memory_fail_01)
{
    rtError_t error;
    uint64_t ptr1 = 0x00;
    NpuDriver * rawDrv = new NpuDriver();
    g_isAddrFlatDevice = true;

    MOCKER(halMemFree)
        .stubs()
        .will(returnValue(DRV_ERROR_RESERVED));

    error = rawDrv->CloseIpcMem(0x1000000);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rawDrv->CreateIpcMem((void *)0x2000000, 0x00, "mem1", 4);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rawDrv->SetIpcMemAttr("mem1", RT_ATTR_TYPE_MEM_MAP, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    MOCKER(halShmemCreateHandle)
        .stubs()
        .will(returnValue(DRV_ERROR_RESERVED));

    error = rawDrv->CreateIpcMem((void *)0x2000000, 0x00, "mem2", 4);    

    error = rawDrv->CreateIpcMem((void *)0x1000000, 0x00, "mem2", 4);

    MOCKER(halShmemOpenHandle)
        .stubs()
        .will(returnValue(DRV_ERROR_RESERVED));

    error = rawDrv->OpenIpcMem("mem3", &ptr1, 0);
    EXPECT_EQ(error, RT_ERROR_DRV_ERR);

    MOCKER(halShmemCloseHandle)
        .stubs()
        .will(returnValue(DRV_ERROR_RESERVED));

    error = rawDrv->DevMemFree((void*)0x2000000, 0);
    EXPECT_EQ(error, RT_ERROR_DRV_ERR);

    error = rawDrv->ManagedMemFree((void*)0x2000000);
    EXPECT_EQ(error, RT_ERROR_DRV_ERR);

    MOCKER(halShmemDestroyHandle)
        .stubs()
        .will(returnValue(DRV_ERROR_RESERVED));

    error = rawDrv->CloseIpcMem(0x2000000);

    error = rawDrv->DestroyIpcMem("mem1");
    EXPECT_EQ(error, RT_ERROR_DRV_ERR);

    error = rawDrv->DestroyIpcMem("mem2");
    EXPECT_EQ(error, RT_ERROR_DRV_ERR);

    GlobalMockObject::verify();

    delete rawDrv;
}

TEST_F(CloudV2NpuDriverTest, driver_memory_fail_02)
{
    rtError_t error;
    uint64_t ptr1 = 0x00;
    NpuDriver * rawDrv = new NpuDriver();

    MOCKER(halMemFree)
        .stubs()
        .will(returnValue(DRV_ERROR_RESERVED));

    error = rawDrv->CloseIpcMem(0x1000000);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rawDrv->CreateIpcMem((void *)0x2000000, 0x00, "mem1", 4);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rawDrv->CreateIpcMem((void *)0x2000000, 0x00, "mem2", 4);

    error = rawDrv->CreateIpcMem((void *)0x1000000, 0x00, "mem2", 4);

    error = rawDrv->OpenIpcMem("mem3", &ptr1, 0);

    error = rawDrv->DevMemFree((void*)0x2000000, 0);

    error = rawDrv->ManagedMemFree((void*)0x2000000);
    EXPECT_EQ(error, RT_ERROR_DRV_ERR);

    error = rawDrv->CloseIpcMem(0x2000000);

    error = rawDrv->DestroyIpcMem("mem1");

    error = rawDrv->DestroyIpcMem("mem2");
    GlobalMockObject::verify();

    delete rawDrv;
}

TEST_F(CloudV2NpuDriverTest, memtranslate_cmodel)
{
    NpuDriver * rawDrv = new NpuDriver();
    uint64_t addr;
    rtError_t error = rawDrv->MemAddressTranslate(0, 0, &addr);
    EXPECT_EQ(error, RT_ERROR_NONE);
    delete rawDrv;
}


TEST_F(CloudV2NpuDriverTest, MEMCPY_TEST_1)
{
    rtError_t error;
    void *mem;
    NpuDriver * rawDrv = new NpuDriver();
    drvError_t drvError = DRV_ERROR_NONE;

    MOCKER(cmodelDrvMemcpy).stubs().will(returnValue(DRV_ERROR_INVALID_VALUE));

    error = rawDrv->MemCopySync(&error, 100, &mem, 100, RT_MEMCPY_DEVICE_TO_HOST);
    EXPECT_EQ(error, RT_ERROR_DRV_INPUT);

    delete rawDrv;
}


TEST_F(CloudV2NpuDriverTest, MEMCPY_TEST_2)
{
    rtError_t error;
    void *mem;
    NpuDriver * rawDrv = new NpuDriver();
    drvError_t drvError = DRV_ERROR_NONE;

    MOCKER(drvMemcpy).stubs().will(returnValue(DRV_ERROR_NONE));

    error = rawDrv->MemCopySync(&error, 100, &mem, 100, RT_MEMCPY_HOST_TO_DEVICE);
    EXPECT_EQ(error, RT_ERROR_NONE);

    delete rawDrv;
}

TEST_F(CloudV2NpuDriverTest, NOTIFY_TEST_3)
{
    rtError_t error;
    NpuDriver * rawDrv = new NpuDriver();
    drvError_t drvError = DRV_ERROR_NONE;
    IpcNotifyOpenPara openPara = {"test", RT_NOTIFY_FLAG_DEFAULT, 0, 0};
    uint32_t phyId;
    uint32_t notifyId;
    uint32_t tsId;
    uint32_t isPod;

    error = rawDrv->OpenIpcNotify(openPara, &phyId, &notifyId, &tsId, &isPod);
    EXPECT_EQ(error, RT_ERROR_NONE);

    delete rawDrv;
}

TEST_F(CloudV2NpuDriverTest, GET_TRANS_WAY)
{

    MOCKER(drvDeviceGetTransWay).stubs().will(returnValue(DRV_ERROR_INVALID_VALUE));

    rtError_t error;
    NpuDriver * rawDrv = new NpuDriver();
    drvError_t drvError = DRV_ERROR_NONE;
    int32_t devId;
    uint32_t notifyId;
    error = rawDrv->GetTransWayByAddr(NULL ,NULL, NULL);
    EXPECT_NE(error, RT_ERROR_NONE);

    delete rawDrv;
}

TEST_F(CloudV2NpuDriverTest, P2P_HBM)
{

    MOCKER(halMemAlloc).stubs().will(returnValue(DRV_ERROR_NONE));
    rtError_t error;
    NpuDriver * rawDrv = new NpuDriver();
    drvError_t drvError = DRV_ERROR_NONE;
    int32_t devId;
    uint32_t notifyId;
    uint32_t dval = 0;
    uint32_t* dptr = &dval;
    error = rawDrv->DevMemAllocOnline((void**)&dptr ,1, RT_MEMORY_P2P_HBM, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    delete rawDrv;
}

TEST_F(CloudV2NpuDriverTest, P2P_DDR)
{

    MOCKER(halMemAlloc).stubs().will(returnValue(DRV_ERROR_NONE));
    rtError_t error;
    NpuDriver * rawDrv = new NpuDriver();
    drvError_t drvError = DRV_ERROR_NONE;
    int32_t devId;
    uint32_t notifyId;
    uint32_t dval = 0;
    uint32_t* dptr = &dval;
    error = rawDrv->DevMemAllocOnline((void**)&dptr ,1, RT_MEMORY_P2P_DDR, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    delete rawDrv;
}

TEST_F(CloudV2NpuDriverTest, NOTIFY_TEST_4)
{

    MOCKER(drvDestroyIpcNotify).stubs().will(returnValue(DRV_ERROR_INVALID_VALUE));

    rtError_t error;
    void *mem;
    NpuDriver * rawDrv = new NpuDriver();
    drvError_t drvError = DRV_ERROR_NONE;

    error = rawDrv->DestroyIpcNotify("test", 0, 0, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    delete rawDrv;
}

TEST_F(CloudV2NpuDriverTest, load_program)
{
    rtError_t error;
    NpuDriver * rawDrv = new NpuDriver();

    MOCKER(drvLoadProgram).stubs().will(returnValue(DRV_ERROR_INVALID_VALUE));
    error = rawDrv->LoadProgram (0, NULL, 0, 0, NULL);
    EXPECT_EQ(error, RT_ERROR_DRV_INPUT);

    delete rawDrv;
}

TEST_F(CloudV2NpuDriverTest, sc_mem_free)
{
    rtError_t error;
    NpuDriver * rawDrv = new NpuDriver();

    MOCKER(drvCustomCall).stubs().will(returnValue(DRV_ERROR_NONE));

    error = rawDrv->DevSCMemFree((void *)NULL, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    delete rawDrv;
}

TEST_F(CloudV2NpuDriverTest, sc_mem_free_failed)
{
    rtError_t error;
    NpuDriver * rawDrv = new NpuDriver();

    MOCKER(drvCustomCall).stubs().will(returnValue(DRV_ERROR_INVALID_VALUE));

    error = rawDrv->DevSCMemFree((void *)NULL, 0);
    EXPECT_EQ(error, RT_ERROR_DRV_INPUT);

    delete rawDrv;
}

TEST_F(CloudV2NpuDriverTest, devm_continuous_memory)
{
    rtError_t error;
    NpuDriver * rawDrv = new NpuDriver();

    MOCKER(drvCustomCall).stubs().will(returnValue(DRV_ERROR_NONE));
    error = rawDrv->DevContinuousMemAlloc((void **)NULL, 0, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rawDrv->DevContinuousMemFree((void *)NULL, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    delete rawDrv;
}

TEST_F(CloudV2NpuDriverTest, devm_continuous_memory_failed)
{
    rtError_t error;
    NpuDriver * rawDrv = new NpuDriver();

    MOCKER(drvCustomCall).stubs().will(returnValue(DRV_ERROR_INVALID_VALUE));
    error = rawDrv->DevContinuousMemAlloc((void **)NULL, 0, 0);
    EXPECT_EQ(error, RT_ERROR_DRV_INPUT);

    error = rawDrv->DevContinuousMemFree((void *)NULL, 0);
    EXPECT_EQ(error, RT_ERROR_DRV_INPUT);

    delete rawDrv;
}

TEST_F(CloudV2NpuDriverTest, driver_sq_cq)
{
    rtError_t error;
    NpuDriver driver;
    uint32_t sqID = 0;
    uint32_t cqID = 0;

    error = driver.SqCqAllocate(0, 0, 0, &sqID, &cqID);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = driver.SqCqFree(sqID, cqID, 0, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(CloudV2NpuDriverTest, halCqReportGet)
{
    rtError_t error;
    NpuDriver driver;
    uint32_t cnt = 0;
    rtHostFuncCqReport_t *report;
    rtHostFuncCommand_t *cmd;

    MOCKER(halSqCqFree).stubs().will(returnValue(DRV_ERROR_INVALID_DEVICE));
    MOCKER(halCqReportGet).stubs().will(returnValue(DRV_ERROR_INVALID_DEVICE));
    MOCKER(halSqMemGet).stubs().will(returnValue(DRV_ERROR_INVALID_DEVICE));

    error = driver.SqCqFree(0, 0, 0, 0);
    EXPECT_EQ(error, RT_ERROR_DRV_INVALID_DEVICE);

    error = driver.CqReportGet(0, 0, 0, &report, &cnt);
    EXPECT_EQ(error, RT_ERROR_DRV_INVALID_DEVICE);

    error = driver.SqCommandOccupy(0,0,0,&cmd,1);
    EXPECT_EQ(error, RT_ERROR_DRV_INVALID_DEVICE);
}

TEST_F(CloudV2NpuDriverTest, driver_cb_sq_cq)
{
    rtError_t error;
    NpuDriver driver;
    rtHostFuncCommand_t *command = NULL;

    MOCKER(halSqMemGet).stubs().will(returnValue(DRV_ERROR_NONE));
    error = driver.SqCommandOccupy(0, 0, 0, &command, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);
    MOCKER(halSqMsgSend).stubs().will(returnValue(DRV_ERROR_NONE));
    error = driver.SqCommandSend(0, 0, 0, command, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(CloudV2NpuDriverTest, alloc_ctrl_sq_ce)
{
    rtError_t error;
    NpuDriver driver;
    uint32_t sqId = 0;
    uint32_t cqId = 0;
    MOCKER(halSqCqAllocate).
        stubs().
        will(returnValue(DRV_ERROR_NONE)).
        then(returnValue(DRV_ERROR_SQID_FULL)).
        then(returnValue(DRV_ERROR_INVALID_HANDLE));
    error = driver.CtrlSqCqAllocate(0, 0, &sqId, &cqId, false);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = driver.CtrlSqCqAllocate(0, 0, &sqId, &cqId, false);
    EXPECT_EQ(error, RT_ERROR_SQID_FULL);

    error = driver.CtrlSqCqAllocate(0, 0, &sqId, &cqId, false);
    EXPECT_EQ(error, RT_ERROR_DRV_INVALID_HANDLE);
}

TEST_F(CloudV2NpuDriverTest, free_ctrl_sq_ce)
{
    rtError_t error;
    NpuDriver driver;
    MOCKER(halSqCqFree).
        stubs().
        will(returnValue(DRV_ERROR_NONE)).
        then(returnValue(DRV_ERROR_INVALID_VALUE));
    error = driver.CtrlSqCqFree(0, 0, 0, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = driver.CtrlSqCqFree(0, 0, 0, 0);
    EXPECT_EQ(error, RT_GET_DRV_ERRCODE(DRV_ERROR_INVALID_VALUE));
}

TEST_F(CloudV2NpuDriverTest, get_ctrl_sq_head)
{
    uint16_t head;
    rtError_t error;
    NpuDriver driver;
    MOCKER(halSqCqQuery)
        .stubs()
        .will(returnValue(DRV_ERROR_INVALID_VALUE))
        .then(returnValue(DRV_ERROR_NONE));
    error = driver.GetCtrlSqHead(0, 0, 0, head);
    EXPECT_EQ(error, RT_GET_DRV_ERRCODE(DRV_ERROR_INVALID_VALUE));
    error = driver.GetCtrlSqHead(0, 0, 0, head);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(CloudV2NpuDriverTest, raw_driver)
{
    NpuDriver driver;
    IpcNotifyOpenPara openPara = {"tmp", RT_NOTIFY_FLAG_DEFAULT, 0, 0};
    rtError_t error;
    int32_t devId;
    uint32_t tsId;
    uint32_t notifyId;
    uint32_t len;

    uint64_t devAddrOffset;
    uint32_t devIndex;
    uint32_t phyId;
    uint32_t pid;
    uint32_t isPod;
    error = driver.NotifyIdAlloc(devId, &notifyId, tsId);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = driver.NotifyIdFree(devId, notifyId, tsId);
    EXPECT_EQ(error, RT_ERROR_NONE);
    
    MOCKER(halResourceIdFree).stubs().will(returnValue(DRV_ERROR_INVALID_VALUE));
    error = driver.NotifyIdFree(devId, notifyId, tsId);
    EXPECT_EQ(error, RT_ERROR_DRV_INPUT);
    error = driver.CreateIpcNotify("tmp", len, devId, &notifyId, tsId);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = driver.OpenIpcNotify(openPara, &phyId, &notifyId, &tsId, &isPod);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = driver.NotifyGetAddrOffset(devId, notifyId, &devAddrOffset, tsId);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = driver.DestroyIpcNotify("tmp", devId, notifyId, tsId);
    EXPECT_EQ(error, RT_ERROR_NONE);

    MOCKER(halShrIdDestroy).stubs().will(returnValue(DRV_ERROR_INVALID_VALUE));
    error = driver.DestroyIpcNotify("tmp", devId, notifyId, tsId);
    EXPECT_EQ(error, RT_ERROR_DRV_INPUT);
    error = driver.CloseIpcNotify("tmp", devId, notifyId, tsId);
    EXPECT_EQ(error, RT_ERROR_NONE);
    MOCKER(drvCloseIpcNotify).stubs().will(returnValue(DRV_ERROR_INVALID_VALUE));
    error = driver.CloseIpcNotify("tmp", devId, notifyId, tsId);
    EXPECT_EQ(error, RT_ERROR_DRV_INPUT);
    error = driver.GetDeviceIndexByPhyId(phyId, &devIndex);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = driver.GetDevicePhyIdByIndex(devIndex, &phyId);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = driver.DeviceGetBareTgid(&pid);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(CloudV2NpuDriverTest, TestDevDvppMemAlloc_01)
{
    MOCKER(halMemAlloc)
        .stubs()
        .will(returnValue(DRV_ERROR_NONE));
    rtError_t error;
    NpuDriver * rawDrv = new NpuDriver();
    uint32_t dval = 0;
    uint32_t* dptr = &dval;
    uint32_t flag = RT_MEMORY_POLICY_HUGE1G_PAGE_ONLY;
    error = rawDrv->DevDvppMemAlloc((void**)&dptr, 100, 0, flag);
    EXPECT_EQ(error, RT_ERROR_NONE);

    delete rawDrv;
}

TEST_F(CloudV2NpuDriverTest, DvppCmdListMemAlloc)
{
    MOCKER(halMemAlloc)
        .stubs()
        .will(returnValue(DRV_ERROR_NONE))
        .then(returnValue(DRV_ERROR_INVALID_VALUE));
    rtError_t error;
    NpuDriver * rawDrv = new NpuDriver();
    uint32_t dval = 0;
    uint32_t* dptr = &dval;
    uint32_t flag = 0;
    error = rawDrv->DvppCmdListMemAlloc((void**)&dptr, 100, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = rawDrv->DvppCmdListMemAlloc((void**)&dptr, 100, 0);
    EXPECT_EQ(error, RT_ERROR_DRV_INPUT);

    delete rawDrv;

}

TEST_F(CloudV2NpuDriverTest, trans_mem_attributr)
{
    rtError_t error;
    rtMemType_t type;

    NpuDriver * rawDrv = new NpuDriver();

    type = RT_MEMORY_DEFAULT;
    error = rawDrv->transMemAttribute(RT_MEMORY_POLICY_DEFAULT_PAGE_ONLY_P2P, &type);
    EXPECT_EQ(error, RT_ERROR_NONE);

    type = RT_MEMORY_HBM;
    error = rawDrv->transMemAttribute(RT_MEMORY_POLICY_DEFAULT_PAGE_ONLY_P2P, &type);
    EXPECT_EQ(error, RT_ERROR_NONE);

    type = RT_MEMORY_DDR;
    error = rawDrv->transMemAttribute(RT_MEMORY_POLICY_DEFAULT_PAGE_ONLY_P2P, &type);
    EXPECT_EQ(error, RT_ERROR_NONE);

    delete rawDrv;
}

TEST_F(CloudV2NpuDriverTest, mem_addr_translate_failed)
{
    rtError_t error;
    NpuDriver * rawDrv = new NpuDriver();

    MOCKER(drvMemAddressTranslate).stubs().will(returnValue(DRV_ERROR_INVALID_VALUE));
    error = rawDrv->MemAddressTranslate(0, 0, nullptr);
    EXPECT_EQ(error, RT_ERROR_DRV_INPUT);
    delete rawDrv;
}

TEST_F(CloudV2NpuDriverTest, mem_addr_convert_failed)
{
    DMA_ADDR dmaAddr;
    rtError_t error;
    NpuDriver * rawDrv = new NpuDriver();

    MOCKER(drvMemConvertAddr).stubs().will(returnValue(DRV_ERROR_INVALID_VALUE));
    error = rawDrv->MemConvertAddr(0, 0, 0, &dmaAddr);
    EXPECT_EQ(error, RT_ERROR_DRV_INPUT);
    delete rawDrv;
}

TEST_F(CloudV2NpuDriverTest, halmemcpy2d_failed)
{
    DMA_ADDR dmaAddr = {0};
    rtError_t error;
    NpuDriver * rawDrv = new NpuDriver();

    MOCKER(halMemcpy2D).stubs().will(returnValue(DRV_ERROR_INVALID_VALUE));

    error = rawDrv->MemCopy2D(0, 0, 0, 0, 0, 0, 0, 0, 0, &dmaAddr);
    EXPECT_EQ(error, RT_ERROR_DRV_INPUT);
    delete rawDrv;
}

TEST_F(CloudV2NpuDriverTest, NormalSqCqFree_fail) {
    MOCKER(halSqCqFree)
        .stubs()
        .will(returnValue(DRV_ERROR_INVALID_VALUE));

    rtError_t error;
    NpuDriver * rawDrv = new NpuDriver();
    error = rawDrv->NormalSqCqFree(0, 0, 0, 0, 0);
    EXPECT_EQ(error, RT_ERROR_DRV_INPUT);
    delete rawDrv;
}

TEST_F(CloudV2NpuDriverTest, LogicCqFree_fail) {
    MOCKER(halSqCqFree)
        .stubs()
        .will(returnValue(DRV_ERROR_INVALID_VALUE));

    rtError_t error;
    NpuDriver * rawDrv = new NpuDriver();
    error = rawDrv->LogicCqFree(0, 0, 0);
    EXPECT_EQ(error, RT_ERROR_DRV_ERR);
    delete rawDrv;
}

TEST_F(CloudV2NpuDriverTest, MemAllocPolicyOffline_fail) {
    MOCKER(halMemAlloc)
        .stubs()
        .will(returnValue(DRV_ERROR_INVALID_VALUE));

    rtError_t error;
    NpuDriver * rawDrv = new NpuDriver();
    void *ptr;
    error = rawDrv->MemAllocPolicyOffline(&ptr, 10, RT_MEMORY_POLICY_DEFAULT_PAGE_ONLY, 0, 0);
    EXPECT_EQ(error, RT_ERROR_DRV_INPUT);
    delete rawDrv;
}

TEST_F(CloudV2NpuDriverTest, MemAdvise_fail) {
    MOCKER(halMemAdvise)
        .stubs()
        .will(returnValue(DRV_ERROR_INVALID_VALUE));

    rtError_t error;
    NpuDriver * rawDrv = new NpuDriver();
    int32_t tmp = 0;
    error = rawDrv->MemAdvise(&tmp, 0, 0, 0);
    EXPECT_EQ(error, RT_ERROR_DRV_INPUT);
    delete rawDrv;
}

TEST_F(CloudV2NpuDriverTest, MemPrefetchToDevice_fail) {
    MOCKER(drvDeviceGetIndexByPhyId)
        .stubs()
        .will(returnValue(DRV_ERROR_INVALID_VALUE));

    rtError_t error;
    NpuDriver * rawDrv = new NpuDriver();
    int32_t tmp = 0;
    error = rawDrv->MemPrefetchToDevice(&tmp, 0, 0);
    EXPECT_EQ(error, RT_ERROR_DRV_INPUT);
    delete rawDrv;
}

TEST_F(CloudV2NpuDriverTest, DeviceOpen_fail1) {
    rtError_t error;
    NpuDriver *rawDrv = new NpuDriver();
    uint32_t SSID = 0;

    MOCKER(drvMemSmmuQuery)
        .stubs()
        .will(returnValue(DRV_ERROR_INVALID_VALUE));

    MOCKER(drvMemDeviceClose)
        .stubs()
        .will(returnValue(3));

    MOCKER(drvDeviceClose)
        .stubs()
        .will(returnValue(DRV_ERROR_INVALID_VALUE));
    error = rawDrv->DeviceOpen(0, 0, &SSID);
    EXPECT_EQ(error, RT_ERROR_DRV_INPUT);

    delete rawDrv;
}

TEST_F(CloudV2NpuDriverTest, DeviceOpen_fail2) {
    rtError_t error;
    NpuDriver *rawDrv = new NpuDriver();
    uint32_t SSID = 0;

    MOCKER(drvMemDeviceOpen)
        .stubs()
        .will(returnValue(3)).then(returnValue(0));
    error = rawDrv->DeviceOpen(0, 0, &SSID);
    EXPECT_EQ(error, RT_ERROR_DRV_INPUT);

    MOCKER(drvDeviceOpen)
        .stubs()
        .will(returnValue(3)).then(returnValue(0));
    MOCKER(drvMemDeviceClose)
        .stubs()
        .will(returnValue(3));
    error = rawDrv->DeviceOpen(0, 0, &SSID);
    EXPECT_EQ(error, RT_ERROR_DRV_INPUT);
    delete rawDrv;
}

TEST_F(CloudV2NpuDriverTest, DeviceOpen_fail3) {
    rtError_t error;
    NpuDriver *rawDrv = new NpuDriver();
    uint32_t SSID = 0;
    MOCKER(drvMemSmmuQuery)
        .stubs()
        .will(returnValue(DRV_ERROR_INVALID_VALUE));
    MOCKER(drvMemDeviceClose)
        .stubs()
        .will(returnValue(3));
    error = rawDrv->DeviceOpen(0, 0, &SSID);
    EXPECT_NE(error, RT_ERROR_NONE);

    delete rawDrv;
}

TEST_F(CloudV2NpuDriverTest, DeviceOpen_fail4) {
    rtError_t error;
    NpuDriver * rawDrv = new NpuDriver();
    uint32_t SSID = 0;

    MOCKER(drvMemSmmuQuery)
        .stubs()
        .will(returnValue(DRV_ERROR_INVALID_VALUE));
    error = rawDrv->DeviceOpen(0, 0, &SSID);
    EXPECT_EQ(error, RT_ERROR_DRV_INPUT);
    delete rawDrv;
}

TEST_F(CloudV2NpuDriverTest, DeviceOpen_success) {
    rtError_t error;
    NpuDriver * rawDrv = new NpuDriver();
    uint32_t SSID = 0;

    MOCKER(drvMemDeviceOpen)
        .stubs()
        .will(returnValue(0));

    MOCKER(drvDeviceOpen)
        .stubs()
        .will(returnValue(0));

    MOCKER(drvMemSmmuQuery)
        .stubs()
        .will(returnValue(0));
    error = rawDrv->DeviceOpen(0, 1, &SSID);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rawDrv->DeviceOpen(0, 0, &SSID);
    EXPECT_EQ(error, RT_ERROR_NONE);

    delete rawDrv;
}

TEST_F(CloudV2NpuDriverTest, DeviceClose_fail1) {
    rtError_t error;
    NpuDriver * rawDrv = new NpuDriver();

    MOCKER(drvDeviceClose)
        .stubs()
        .will(returnValue(DRV_ERROR_INVALID_VALUE));
    MOCKER(drvMemDeviceClose)
        .stubs()
        .will(returnValue(3));
    error = rawDrv->DeviceClose(0, 0);
    EXPECT_EQ(error, RT_ERROR_DRV_INPUT);

    delete rawDrv;
}

TEST_F(CloudV2NpuDriverTest, DeviceClose_success) {
    rtError_t error;
    NpuDriver * rawDrv = new NpuDriver();
    rawDrv->isTscOpen_ = true;
    rawDrv->isTsvOpen_ = true;

    MOCKER(drvDeviceClose)
        .stubs()
        .will(returnValue(0));
    MOCKER(drvMemDeviceClose)
        .stubs()
        .will(returnValue(0));
    error = rawDrv->DeviceClose(0, 1);
    EXPECT_EQ(error, RT_ERROR_NONE);

    rawDrv->isTsvOpen_ = true;
    error = rawDrv->DeviceClose(0, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);
    delete rawDrv;
}


TEST_F(CloudV2NpuDriverTest, CreateIpcMem_fail) {
    rtError_t error;
    NpuDriver * rawDrv = new NpuDriver();

    MOCKER(halShmemCreateHandle)
        .stubs()
        .will(returnValue(DRV_ERROR_INVALID_VALUE));
    error = rawDrv->CreateIpcMem(nullptr, 0, "test", 4);
    EXPECT_EQ(error, RT_ERROR_DRV_INPUT);

    delete rawDrv;
}

TEST_F(CloudV2NpuDriverTest, SetIpcMemAttr_fail) {
    rtError_t error;
    NpuDriver * rawDrv = new NpuDriver();
    g_isAddrFlatDevice = true;

    error = rawDrv->CreateIpcMem((void *)0x2000000, 0x00, "mem1", 4);
    EXPECT_EQ(error, RT_ERROR_NONE);

    MOCKER(halShmemSetAttribute)
        .stubs()
        .will(returnValue(DRV_ERROR_NOT_SUPPORT))
        .then(returnValue(DRV_ERROR_INVALID_VALUE));
    error = rawDrv->SetIpcMemAttr("test", RT_ATTR_TYPE_MEM_MAP, 0);
    EXPECT_EQ(error, RT_ERROR_DRV_NOT_SUPPORT);

    error = rawDrv->SetIpcMemAttr(NULL, RT_ATTR_TYPE_MEM_MAP, 0);
    EXPECT_EQ(error, RT_ERROR_DRV_INPUT);

    delete rawDrv;
}

TEST_F(CloudV2NpuDriverTest, OpenIpcMem_fail) {
    rtError_t error;
    NpuDriver * rawDrv = new NpuDriver();

    MOCKER(halShmemOpenHandle)
        .stubs()
        .will(returnValue(DRV_ERROR_INVALID_VALUE));
    error = rawDrv->OpenIpcMem("test", nullptr, 0);
    EXPECT_EQ(error, RT_ERROR_DRV_INPUT);

    delete rawDrv;
}

TEST_F(CloudV2NpuDriverTest, CloseIpcMem_fail) {
    rtError_t error;
    NpuDriver * rawDrv = new NpuDriver();

    MOCKER(halShmemCloseHandle)
        .stubs()
        .will(returnValue(DRV_ERROR_INVALID_VALUE));
    error = rawDrv->CloseIpcMem(0);
    EXPECT_EQ(error, RT_ERROR_DRV_INPUT);

    delete rawDrv;
}

TEST_F(CloudV2NpuDriverTest, SetIpcMemPid_fail) {
    rtError_t error;
    NpuDriver * rawDrv = new NpuDriver();

    MOCKER(halShmemSetPidHandle)
        .stubs()
        .will(returnValue(DRV_ERROR_INVALID_VALUE));
    int32_t pid[1];
    error = rawDrv->SetIpcMemPid("test", pid, 0);
    EXPECT_EQ(error, RT_ERROR_DRV_INPUT);

    delete rawDrv;
}

TEST_F(CloudV2NpuDriverTest, GetDeviceIndexByPhyId_fail) {
    rtError_t error;
    NpuDriver * rawDrv = new NpuDriver();

    MOCKER(drvDeviceGetIndexByPhyId)
        .stubs()
        .will(returnValue(DRV_ERROR_INVALID_VALUE));
    error = rawDrv->GetDeviceIndexByPhyId(0, nullptr);
    EXPECT_EQ(error, RT_ERROR_DRV_INPUT);

    delete rawDrv;
}

TEST_F(CloudV2NpuDriverTest, SqCqAllocate_fail) {
    rtError_t error;
    NpuDriver * rawDrv = new NpuDriver();

    MOCKER(halSqCqAllocate)
        .stubs()
        .will(returnValue(DRV_ERROR_INVALID_VALUE));
    uint32_t sqId;
    uint32_t cqId;
    error = rawDrv->SqCqAllocate(0, 0, 0, &sqId, &cqId);
    EXPECT_EQ(error, RT_ERROR_DRV_INPUT);

    delete rawDrv;
}

TEST_F(CloudV2NpuDriverTest, NormalSqCqAllocate_failed)
{
    rtError_t error;
    NpuDriver *rawDrv = new NpuDriver();
    uint32_t info[5] = {};
    uint32_t msg[1] = {0};
    uint32_t sqId = 0U;
    uint32_t cqId = 0U;

    MOCKER(halSqCqAllocate).stubs().will(returnValue(DRV_ERROR_INVALID_VALUE));
    error = rawDrv->NormalSqCqAllocate(1, 1, 0, &sqId, &cqId, info, sizeof(info), msg, sizeof(msg));
    EXPECT_EQ(error, RT_ERROR_DRV_INPUT);

    delete rawDrv;
}

TEST_F(CloudV2NpuDriverTest, NormalSqCqAllocate_failed_81)
{
    g_isAddrFlatDevice = true;
    rtError_t error;
    NpuDriver *rawDrv = new NpuDriver();
    uint32_t info[5] = {};
    uint32_t msg[1] = {0};
    uint32_t sqId = 0U;
    uint32_t cqId = 0U;

    MOCKER(halSqCqAllocate).stubs().will(returnValue(DRV_ERROR_INVALID_VALUE));
    error = rawDrv->NormalSqCqAllocate(1, 1, 0, &sqId, &cqId, info, sizeof(info), msg, sizeof(msg));
    EXPECT_EQ(error, RT_ERROR_DRV_INPUT);

    delete rawDrv;
    g_isAddrFlatDevice = false;
}

TEST_F(CloudV2NpuDriverTest, EschedSubscribeEvent)
{
    rtError_t error;
    NpuDriver *rawDrv = new NpuDriver();

    MOCKER(halEschedSubscribeEvent).stubs().will(returnValue(DRV_ERROR_INVALID_VALUE));
    error = rawDrv->EschedSubscribeEvent(0, 0, 0, 0);
    EXPECT_EQ(error, RT_ERROR_DRV_INPUT);

    delete rawDrv;
}

TEST_F(CloudV2NpuDriverTest, EnableSq_failed)
{
    rtError_t error;
    NpuDriver *rawDrv = new NpuDriver();

    MOCKER(halSqCqConfig).stubs().will(returnValue(DRV_ERROR_INVALID_VALUE));
    error = rawDrv->EnableSq(0, 0, 0);
    EXPECT_EQ(error, RT_ERROR_DRV_INPUT);

    delete rawDrv;
}

TEST_F(CloudV2NpuDriverTest, DisableSq_failed)
{
    rtError_t error;
    NpuDriver *rawDrv = new NpuDriver();

    MOCKER(halSqCqConfig).stubs().will(returnValue(DRV_ERROR_INVALID_VALUE));
    error = rawDrv->DisableSq(0, 0, 0);
    EXPECT_EQ(error, RT_ERROR_DRV_INPUT);

    delete rawDrv;
}


TEST_F(CloudV2NpuDriverTest, SetSqHead_failed)
{
    rtError_t error;
    NpuDriver *rawDrv = new NpuDriver();

    MOCKER(halSqCqConfig).stubs().will(returnValue(DRV_ERROR_INVALID_VALUE));
    error = rawDrv->SetSqHead(0, 0, 0, 0);
    EXPECT_EQ(error, RT_ERROR_DRV_INPUT);

    delete rawDrv;
}

TEST_F(CloudV2NpuDriverTest, GetChipCapability_failed)
{
    rtError_t error;
    NpuDriver *rawDrv = new NpuDriver();

    MOCKER(halGetChipCapability).stubs().will(returnValue(DRV_ERROR_INVALID_VALUE));
    error = rawDrv->GetChipCapability(0, nullptr);
    EXPECT_EQ(error, RT_ERROR_DRV_INPUT);

    delete rawDrv;
}

TEST_F(CloudV2NpuDriverTest, GetCapabilityGroupInfo_failed)
{
    rtError_t error;
    NpuDriver *rawDrv = new NpuDriver();

    MOCKER(halGetCapabilityGroupInfo).stubs().will(returnValue(DRV_ERROR_INVALID_VALUE));
    error = rawDrv->GetCapabilityGroupInfo(0, 0, 0, nullptr, 0);
    EXPECT_EQ(error, RT_ERROR_DRV_INPUT);

    delete rawDrv;
}

TEST_F(CloudV2NpuDriverTest, GetC2cCtrlAddr_failed)
{
    rtError_t error;
    NpuDriver *rawDrv = new NpuDriver();
    uint64_t addr;
    uint32_t len;

    MOCKER(halMemCtl).stubs().will(returnValue(DRV_ERROR_INVALID_VALUE));
    error = rawDrv->GetC2cCtrlAddr(0, &addr, &len);
    EXPECT_EQ(error, RT_ERROR_DRV_INPUT);

    delete rawDrv;
}

TEST_F(CloudV2NpuDriverTest, MemCopyAsyncEx_failed)
{
    rtError_t error;
    NpuDriver *rawDrv = new NpuDriver();

    MOCKER(halMemcpySumbit).stubs().will(returnValue(DRV_ERROR_INVALID_VALUE));
    error = rawDrv->MemCopyAsyncEx(nullptr);
    EXPECT_EQ(error, RT_ERROR_DRV_INPUT);

    delete rawDrv;
}

TEST_F(CloudV2NpuDriverTest, MemCopyAsyncWaitFinishEx_failed)
{
    rtError_t error;
    NpuDriver *rawDrv = new NpuDriver();

    MOCKER(halMemcpyWait).stubs().will(returnValue(DRV_ERROR_INVALID_VALUE));
    error = rawDrv->MemCopyAsyncWaitFinishEx(nullptr);
    EXPECT_EQ(error, RT_ERROR_DRV_INPUT);

    delete rawDrv;
}

TEST_F(CloudV2NpuDriverTest, GetSqHead)
{
    rtError_t error;
    uint16_t head;
    NpuDriver rawDrv;

    MOCKER(halSqCqQuery)
        .stubs()
        .will(returnValue(DRV_ERROR_INVALID_VALUE))
        .then(returnValue(DRV_ERROR_NONE));

    error = rawDrv.GetSqHead(0,0,0,head);
    EXPECT_NE(error, RT_ERROR_NONE);

    error = rawDrv.GetSqHead(0,0,0,head);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(CloudV2NpuDriverTest, GetSqTail)
{
    rtError_t error;
    uint16_t tail;
    NpuDriver rawDrv;

    MOCKER(halSqCqQuery).stubs()
        .will(returnValue(DRV_ERROR_INVALID_VALUE))
        .then(returnValue(DRV_ERROR_NONE));

    error = rawDrv.GetSqTail(0,0,0,tail);
    EXPECT_NE(error, RT_ERROR_NONE);

    error = rawDrv.GetSqTail(0,0,0,tail);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(CloudV2NpuDriverTest, GetSqEnable)
{
    rtError_t error;
    bool en;
    NpuDriver rawDrv;

    MOCKER(halSqCqQuery).stubs()
        .will(returnValue(DRV_ERROR_INVALID_VALUE))
        .then(returnValue(DRV_ERROR_NONE));

    error = rawDrv.GetSqEnable(0,0,0,en);
    EXPECT_NE(error, RT_ERROR_NONE);

    error = rawDrv.GetSqEnable(0,0,0,en);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(CloudV2NpuDriverTest, StreamBindLogicCq)
{
    rtError_t error;
    NpuDriver rawDrv;

    MOCKER(halResourceConfig).stubs()
        .will(returnValue(DRV_ERROR_INVALID_VALUE))
        .then(returnValue(DRV_ERROR_NONE));

    error = rawDrv.StreamBindLogicCq(0,0,0,0);
    EXPECT_NE(error, RT_ERROR_NONE);

    error = rawDrv.StreamBindLogicCq(0,0,0,0);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(CloudV2NpuDriverTest, StreamUnBindLogicCq)
{
    rtError_t error;
    NpuDriver rawDrv;

    MOCKER(halResourceConfig).stubs()
        .will(returnValue(DRV_ERROR_INVALID_VALUE))
        .then(returnValue(DRV_ERROR_NONE));

    error = rawDrv.StreamUnBindLogicCq(0,0,0,0);
    EXPECT_NE(error, RT_ERROR_NONE);

    error = rawDrv.StreamUnBindLogicCq(0,0,0,0);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(CloudV2NpuDriverTest, LogicCqAllocateV2)
{
    rtError_t error;
    NpuDriver rawDrv;
    uint32_t cqId;

    MOCKER(halSqCqAllocate).stubs()
        .will(returnValue(DRV_ERROR_INVALID_VALUE))
        .then(returnValue(DRV_ERROR_NONE));

    error = rawDrv.LogicCqAllocateV2(0,0,0,cqId);
    EXPECT_NE(error, RT_ERROR_NONE);

    error = rawDrv.LogicCqAllocateV2(0,0,0,cqId);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(CloudV2NpuDriverTest, LogicCqAllocateV2_001)
{
    rtError_t error;
    NpuDriver rawDrv;
    uint32_t cqId;

    MOCKER(halSqCqAllocate).stubs()
        .will(returnValue(DRV_ERROR_INVALID_VALUE))
        .then(returnValue(DRV_ERROR_NONE));

    error = rawDrv.LogicCqAllocateV2(0,0,0,cqId,true);
    EXPECT_NE(error, RT_ERROR_NONE);

    error = rawDrv.LogicCqAllocateV2(0,0,0,cqId);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

int32_t halMapErrorCode(drvError_t drvErrCode) {
    if (static_cast<uint32_t>(drvErrCode) == 1) {
        return -1;
    } else if (static_cast<uint32_t>(drvErrCode) == 2) {
        return 2;
    } else {
        return 9999;
    }
}

TEST_F(CloudV2NpuDriverTest, DRV_ERROR_PROCESS_test) {
    std::vector<std::string> tmpErrorCodes;
#define REPORT_INPUT_ERROR(error_code, key, value) tmpErrorCodes.push_back(error_code);
#define RT_LOG_CALL_MSG(model_type, format, ...) tmpErrorCodes.push_back("call_error");
    DRV_ERROR_PROCESS(static_cast<drvError_t>(1), "%s", "test call_error");
    EXPECT_EQ(tmpErrorCodes.size(), 1);
    EXPECT_STREQ(tmpErrorCodes[0].c_str(), "call_error");

    DRV_ERROR_PROCESS(static_cast<drvError_t>(2), "%s", "test EL0002");
    EXPECT_EQ(tmpErrorCodes.size(), 2);
    EXPECT_STREQ(tmpErrorCodes[1].c_str(), "EL0002");

    DRV_ERROR_PROCESS(static_cast<drvError_t>(3), "%s", "test EL9999");
    EXPECT_EQ(tmpErrorCodes.size(), 3);
    EXPECT_STREQ(tmpErrorCodes[2].c_str(), "call_error");
}

TEST_F(CloudV2NpuDriverTest, Hal_API_failed)
{
    MOCKER(halSqCqAllocate).stubs().will(returnValue(DRV_ERROR_INVALID_VALUE)).then(returnValue(DRV_ERROR_SQID_FULL));

    NpuDriver rawDrv;
    uint32_t sqId = 0;
    uint32_t cqId = 0;
    bool isFastCq = false;
    uint8_t *addr = nullptr;
    bool isShmSqReadonly = false;
    EXPECT_EQ(rawDrv.VirtualCqAllocate(0, 0, sqId, cqId, addr, isShmSqReadonly), RT_ERROR_DRV_INPUT);
    EXPECT_EQ(rawDrv.VirtualCqAllocate(0, 0, sqId, cqId, addr, isShmSqReadonly), RT_ERROR_DRV_ERR);

    EXPECT_EQ(rawDrv.LogicCqAllocate(0, 0, 0, false, cqId, isFastCq, false), RT_ERROR_DRV_ERR);

    MOCKER(halReportRelease).stubs().will(returnValue(DRV_ERROR_INVALID_VALUE));

    EXPECT_EQ(rawDrv.ReportRelease(0, 0, cqId, DRV_LOGIC_TYPE), RT_ERROR_DRV_INPUT);

    MOCKER(halCqReportIrqWait).stubs().will(returnValue(DRV_ERROR_NONE)).then(returnValue(DRV_ERROR_NOT_SUPPORT));
    MOCKER(halCqReportGet).stubs().will(returnValue(DRV_ERROR_INVALID_VALUE));

    rtLogicReport_t *report = nullptr;
    uint32_t count = 0;
    LogicCqWaitInfo input = {};

    EXPECT_EQ(rawDrv.LogicCqReport(input, report, count), RT_ERROR_DRV_INPUT);      // DRV_ERROR_BUS_DOWN
    EXPECT_EQ(rawDrv.LogicCqReport(input, report, count), RT_ERROR_DRV_NOT_SUPPORT);      // DRV_ERROR_NOT_SUPPORT
}

TEST_F(CloudV2NpuDriverTest, driver_logic_cq_v2)
{
    uint32_t count = 0;

    NpuDriver rawDrv;
    MOCKER(halCqReportIrqWait).stubs()
        .will(returnValue(DRV_ERROR_NOT_SUPPORT))
        .then(returnValue(DRV_ERROR_NONE))
        .then(returnValue(DRV_ERROR_NONE));

    MOCKER(halCqReportRecv).stubs().will(returnValue(DRV_ERROR_WAIT_TIMEOUT));
    LogicCqWaitInfo input = {};
    rtLogicCqReport_t logic = {};
    // drv error
    EXPECT_EQ(rawDrv.LogicCqReportV2(input, reinterpret_cast<uint8_t *>(&logic), 1, count), RT_ERROR_REPORT_TIMEOUT);

    input.isFastCq = true;
    EXPECT_EQ(rawDrv.LogicCqReportV2(input, reinterpret_cast<uint8_t *>(&logic), 1, count), RT_ERROR_DRV_NOT_SUPPORT);

    input.isFastCq = false;
    EXPECT_EQ(rawDrv.LogicCqReportV2(input, reinterpret_cast<uint8_t *>(&logic), 1, count), RT_ERROR_REPORT_TIMEOUT);
}

TEST_F(CloudV2NpuDriverTest, sqConfig)
{
    rtError_t error;
    MOCKER(halSqCqConfig)
        .stubs()
        .will(returnValue(DRV_ERROR_NONE));
    NpuDriver *rawDrv = new NpuDriver();
    error = rawDrv->EnableSq(0,0,0);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = rawDrv->DisableSq(0,0,0);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = rawDrv->SetSqHead(0,0,0,0);
    EXPECT_EQ(error, RT_ERROR_NONE);
    delete rawDrv;
}

TEST_F(CloudV2NpuDriverTest, chipList)
{
    MOCKER(halGetChipCount)
        .stubs()
        .will(returnValue(DRV_ERROR_NONE));
    MOCKER(halGetChipList)
        .stubs()
        .will(returnValue(DRV_ERROR_NONE));
    MOCKER(halGetDeviceCountFromChip)
        .stubs()
        .will(returnValue(DRV_ERROR_NONE));

    uint32_t count;
    NpuDriver *rawDrv = new NpuDriver();
    rtError_t error;
    error = rawDrv->GetChipCount(&count);
    EXPECT_EQ(error, RT_ERROR_NONE);
    uint32_t chipList[3];
    count = 3;
    error = rawDrv->GetChipList(chipList, count);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = rawDrv->GetDeviceCountFromChip(0, &count);
    EXPECT_EQ(error, RT_ERROR_NONE);
    uint32_t devList[3];
    error = rawDrv->GetDeviceFromChip(0, devList, 1);
    EXPECT_EQ(error, RT_ERROR_NONE);
    delete rawDrv;
}

TEST_F(CloudV2NpuDriverTest, getMaxModelNum)
{
    rtError_t error;
    NpuDriver *rawDrv = new NpuDriver();
    uint32_t maxModelCount = 0;
    MOCKER(halResourceInfoQuery).stubs().will(returnValue(DRV_ERROR_NONE));
    error = rawDrv->GetMaxModelNum(0, 0, &maxModelCount);
    EXPECT_EQ(error, RT_ERROR_NONE);

    delete rawDrv;
}

drvError_t drvGetDeviceAicpuNor(DVdevice device, processType_t processType, processStatus_t status, bool *isMatched)
{
    *isMatched = false;
    return DRV_ERROR_NONE;
}

drvError_t drvGetDeviceAicpuOOM(DVdevice device, processType_t processType, processStatus_t status, bool *isMatched)
{
    *isMatched = true;
    return DRV_ERROR_NONE;
}

TEST_F(CloudV2NpuDriverTest, getDeviceAicpuStat_01)
{
    rtError_t error;
    NpuDriver *rawDrv = new NpuDriver();
    MOCKER(halCheckProcessStatus).stubs().will(invoke(drvGetDeviceAicpuNor));
    error = rawDrv->GetDeviceAicpuStat(0);

    EXPECT_EQ(error, RT_ERROR_NONE);

    delete rawDrv;
}

TEST_F(CloudV2NpuDriverTest, getDeviceAicpuStat_02)
{
    rtError_t error;
    NpuDriver *rawDrv = new NpuDriver();
    MOCKER(halCheckProcessStatus).stubs().will(invoke(drvGetDeviceAicpuOOM));
    error = rawDrv->GetDeviceAicpuStat(0);

    EXPECT_EQ(error, RT_ERROR_DEVICE_OOM);

    delete rawDrv;
}

TEST_F(CloudV2NpuDriverTest, GetPageFaultCount_01)
{
    NpuDriver *rawDrv = new NpuDriver();
    uint32_t value = 0U;

    MOCKER(halCheckProcessStatusEx).stubs().will(returnValue(DRV_ERROR_NONE));
    rtError_t err = rawDrv->GetPageFaultCount(0, &value);
    EXPECT_EQ(err, RT_ERROR_NONE);

    delete rawDrv;
}

TEST_F(CloudV2NpuDriverTest, GetPageFaultCount_02)
{
    NpuDriver *rawDrv = new NpuDriver();
    uint32_t value = 0U;

    MOCKER(halCheckProcessStatusEx).stubs().will(returnValue(DRV_ERROR_INVALID_VALUE));
    rtError_t err = rawDrv->GetPageFaultCount(0, &value);
    EXPECT_EQ(err, RT_ERROR_DRV_INPUT);

    delete rawDrv;
}

TEST_F(CloudV2NpuDriverTest, memory_dev_alloc_offline_mini)
{
    rtError_t error;
    uint32_t size = 100;
    void *ptr = malloc(size);
    NpuDriver * rawDrv = new NpuDriver();

    MOCKER(halMemAlloc).stubs().will(returnValue(DRV_ERROR_INVALID_VALUE));
    error = rawDrv->DevMemAllocOffline(&ptr, size , (rtMemType_t)RT_MEMORY_TS, 0);
    ASSERT_EQ(error, RT_ERROR_DRV_INPUT);

    delete rawDrv;
    free(ptr);
}

drvError_t drvGetPlatformInfo_online(uint32_t *info)
{
    *info = RT_RUN_MODE_ONLINE;
    return DRV_ERROR_NONE;
}

drvError_t drvGetPlatformInfo_aicpu_sched(uint32_t *info)
{
    *info = RT_RUN_MODE_AICPU_SCHED;
    return DRV_ERROR_NONE;
}

drvError_t drvGetPlatformInfo_offline(uint32_t *info)
{
    *info = RT_RUN_MODE_OFFLINE;
    return DRV_ERROR_NONE;
}

TEST_F(CloudV2NpuDriverTest, get_aicpu_deploy_online)
{
    MOCKER(drvGetPlatformInfo).stubs().will(invoke(drvGetPlatformInfo_online));
    NpuDriver *rawDrv = new NpuDriver();
    uint32_t aicpuDeploy;
    aicpuDeploy = rawDrv->GetAicpuDeploy();
    EXPECT_EQ(aicpuDeploy, AICPU_DEPLOY_CROSS_OS);
    delete rawDrv;
}

TEST_F(CloudV2NpuDriverTest, get_aicpu_deploy_aicpu_offline)
{
    MOCKER(drvGetPlatformInfo).stubs().will(invoke(drvGetPlatformInfo_offline));
    NpuDriver *rawDrv = new NpuDriver();
    uint32_t aicpuDeploy;
    aicpuDeploy = rawDrv->GetAicpuDeploy();
    EXPECT_EQ(aicpuDeploy, AICPU_DEPLOY_CROSS_PROCESS);
    delete rawDrv;
}

TEST_F(CloudV2NpuDriverTest, get_aicpu_deploy_aicpu_sched)
{
    MOCKER(drvGetPlatformInfo).stubs().will(invoke(drvGetPlatformInfo_aicpu_sched));
    NpuDriver *rawDrv = new NpuDriver();
    uint32_t aicpuDeploy;
    aicpuDeploy = rawDrv->GetAicpuDeploy();
    EXPECT_EQ(aicpuDeploy, AICPU_DEPLOY_CROSS_THREAD);
    delete rawDrv;
}

TEST_F(CloudV2NpuDriverTest, NpuDriverCMOTest1)
{
    NpuDriver *rawDrv = new NpuDriver();
    int32_t cmoid = 0;
    MOCKER(halResourceIdAlloc).stubs().will(returnValue(DRV_ERROR_INVALID_VALUE));
    rtError_t err = rawDrv->CmoIdAlloc(&cmoid, 0, 0);
    EXPECT_EQ(err, RT_ERROR_DRV_INPUT);

    MOCKER(halResourceIdFree).stubs().will(returnValue(DRV_ERROR_INVALID_VALUE));
    err = rawDrv->CmoIdFree(cmoid, 0, 0);
    EXPECT_EQ(err, RT_ERROR_DRV_INPUT);
    delete rawDrv;
}

TEST_F(CloudV2NpuDriverTest, check_pcie_bar_copy)
{
    rtError_t error;
    uint32_t val;

    MOCKER(halMemCtl)
        .stubs()
        .will(returnValue(DRV_ERROR_NONE));
    NpuDriver * rawDrv = new NpuDriver();
    MOCKER_CPP_VIRTUAL(rawDrv, &NpuDriver::GetRunMode)
                        .stubs()
                        .will(returnValue(1));
    error = rawDrv->CheckSupportPcieBarCopy(0, val);

    MOCKER_CPP_VIRTUAL(rawDrv, &NpuDriver::GetRunMode)
                        .stubs()
                        .will(returnValue(0));
    error = rawDrv->CheckSupportPcieBarCopy(0, val);
    void *addr = nullptr;
    void *outAddr = nullptr;
    MOCKER(halHostRegister)
        .stubs()
        .will(returnValue(DRV_ERROR_NONE));
    error = rawDrv->PcieHostRegister(addr, 0, 0, outAddr);
    EXPECT_EQ(error, RT_ERROR_NONE);
    MOCKER(halHostUnregister)
        .stubs()
        .will(returnValue(DRV_ERROR_NONE));
    error = rawDrv->PcieHostUnRegister(addr, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    delete rawDrv;
}

TEST_F(CloudV2NpuDriverTest, NpuDriverCMOTest2)
{
    NpuDriver *rawDrv = new NpuDriver();
    int32_t cmoid = 0;

    MOCKER(halResourceIdAlloc).stubs().will(returnValue(DRV_ERROR_NONE));
    rtError_t err = rawDrv->CmoIdAlloc(&cmoid, 0, 0);
    EXPECT_EQ(err, RT_ERROR_NONE);

    MOCKER(halResourceIdFree).stubs().will(returnValue(DRV_ERROR_NONE));
    err = rawDrv->CmoIdFree(cmoid, 0, 0);
    EXPECT_EQ(err, RT_ERROR_NONE);
    delete rawDrv;
}

TEST_F(CloudV2NpuDriverTest, GetSqAddrInfoTest)
{
    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    NpuDriver *rawDrv = new NpuDriver();
    struct halSqCqQueryInfo queryInfoIn = {};
    queryInfoIn.type = DRV_NORMAL_TYPE;
    queryInfoIn.value[0] = 0;
    uint64_t sqAddr;

    MOCKER(halSqCqQuery)
        .stubs()
        .with(mockcpp::any(), outBound(&queryInfoIn))
        .will(returnValue(DRV_ERROR_NONE));
    rtError_t err = rawDrv->GetSqAddrInfo(0, 0, 0, sqAddr);
    EXPECT_EQ(err, RT_ERROR_NONE);
    delete rawDrv;
}

TEST_F(CloudV2NpuDriverTest, check_pcie_bar_error_copy)
{
    rtError_t error;
    uint32_t val;

    NpuDriver * rawDrv = new NpuDriver();
    MOCKER(halMemCtl)
        .stubs()
        .will(returnValue(2));
    MOCKER_CPP_VIRTUAL(rawDrv, &NpuDriver::GetRunMode)
                        .stubs()
                        .will(returnValue(1));
    error = rawDrv->CheckSupportPcieBarCopy(0, val);
    ASSERT_EQ(error, RT_ERROR_DRV_ERR);
    void *addr = nullptr;
    void *outAddr = nullptr;

    MOCKER(halHostRegister)
        .stubs()
        .will(returnValue(2));
    error = rawDrv->PcieHostRegister(addr, 0, 0, outAddr);
    ASSERT_EQ(error, RT_ERROR_DRV_ERR);
    MOCKER(halHostUnregister)
        .stubs()
        .will(returnValue(2));
    error = rawDrv->PcieHostUnRegister(addr, 0);
    ASSERT_EQ(error, RT_ERROR_DRV_ERR);

    delete rawDrv;
}

TEST_F(CloudV2NpuDriverTest, NpuDriverSetSqTail)
{
    NpuDriver *npuDrv = new NpuDriver();

    MOCKER(halSqCqConfig)
    .stubs()
    .will(returnValue(DRV_ERROR_NONE))
    .then(returnValue(DRV_ERROR_INVALID_VALUE));
    rtError_t error = npuDrv->SetSqTail(0, 0, 0, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = npuDrv->SetSqTail(0, 0, 0, 0);
    EXPECT_EQ(error, RT_ERROR_DRV_INPUT);
    delete npuDrv;
}

TEST_F(CloudV2NpuDriverTest, NpuDriverTaskKill)
{
    NpuDriver *npuDrv = new NpuDriver();

    uint32_t status;

    MOCKER(halTsdrvCtl)
        .stubs()
        .will(returnValue(DRV_ERROR_NONE));
    rtError_t error = npuDrv->TaskAbortByType(0, 0, 5, 1, status);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = npuDrv->TaskAbortByType(0, 0, 6, 1, status);
    EXPECT_EQ(error, RT_ERROR_NONE);
    delete npuDrv;
}

TEST_F(CloudV2NpuDriverTest, NpuDriverQuerySq)
{
    NpuDriver *npuDrv = new NpuDriver();
    uint32_t status;
    MOCKER(halTsdrvCtl)
    .stubs()
    .will(returnValue(DRV_ERROR_NONE));
    rtError_t error = npuDrv->QueryAbortStatusByType(0, 0, 0, 0, status);
    EXPECT_EQ(error, RT_ERROR_NONE);
    delete npuDrv;
}

TEST_F(CloudV2NpuDriverTest, NpuDriverRecoverAbortByType)
{
    NpuDriver *npuDrv = new NpuDriver();

    uint32_t status;
    MOCKER(halTsdrvCtl)
    .stubs()
    .will(returnValue(DRV_ERROR_NONE));
    rtError_t error = npuDrv->RecoverAbortByType(0, 0, 7, 1, status);
    EXPECT_EQ(error, RT_ERROR_NONE);
    delete npuDrv;
}

TEST_F(CloudV2NpuDriverTest, NpuDriverQueryRecoverStatusByType)
{
    NpuDriver *npuDrv = new NpuDriver();
    uint32_t status;
    MOCKER(halTsdrvCtl)
    .stubs()
    .will(returnValue(DRV_ERROR_NONE));
    rtError_t error = npuDrv->QueryRecoverStatusByType(0, 0, 0, 0, status);
    EXPECT_EQ(error, RT_ERROR_NONE);
    delete npuDrv;
}

TEST_F(CloudV2NpuDriverTest, NpuDriverResetSqCq)
{
    NpuDriver *npuDrv = new NpuDriver();

    MOCKER(halSqCqConfig)
    .stubs()
    .will(returnValue(DRV_ERROR_NONE))
    .then(returnValue(DRV_ERROR_INVALID_VALUE));
    rtError_t error = npuDrv->ResetSqCq(0, 0, 0, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = npuDrv->ResetSqCq(0, 0, 0, 0);
    EXPECT_EQ(error, RT_ERROR_DRV_INPUT);
    delete npuDrv;
}

TEST_F(CloudV2NpuDriverTest, NpuDriverResetLogicCq)
{
    NpuDriver *npuDrv = new NpuDriver();

    MOCKER(halSqCqConfig)
    .stubs()
    .will(returnValue(DRV_ERROR_NONE))
    .then(returnValue(DRV_ERROR_INVALID_VALUE));
    rtError_t error = npuDrv->ResetLogicCq(0, 0, 0, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = npuDrv->ResetLogicCq(0, 0, 0, 0);
    EXPECT_EQ(error, RT_ERROR_DRV_INPUT);
    delete npuDrv;
}

TEST_F(CloudV2NpuDriverTest, NpuDriverStopSqSend)
{
    NpuDriver *npuDrv = new NpuDriver();
    uint32_t status;
    MOCKER(halSqCqConfig)
    .stubs()
    .will(returnValue(DRV_ERROR_NONE))
    .then(returnValue(DRV_ERROR_INVALID_VALUE));
    rtError_t error = npuDrv->StopSqSend(0, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = npuDrv->StopSqSend(0, 0);
    EXPECT_EQ(error, RT_ERROR_DRV_INPUT);
    delete npuDrv;
}

TEST_F(CloudV2NpuDriverTest, NpuDriverResumeSqSend)
{
    NpuDriver *npuDrv = new NpuDriver();
    uint32_t status;
    MOCKER(halSqCqConfig)
    .stubs()
    .will(returnValue(DRV_ERROR_NONE))
    .then(returnValue(DRV_ERROR_INVALID_VALUE));
    rtError_t error = npuDrv->ResumeSqSend(0, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = npuDrv->ResumeSqSend(0, 0);
    EXPECT_EQ(error, RT_ERROR_DRV_INPUT);
    delete npuDrv;
}

TEST_F(CloudV2NpuDriverTest, StubDriverResourceResetfail)
{
    NpuDriver *npuDrv = new NpuDriver();
    MOCKER(halResourceConfig).stubs()
        .will(returnValue(DRV_ERROR_NONE))
        .then(returnValue(DRV_ERROR_NO_DEVICE));
    rtError_t err = npuDrv->ResourceReset(0, 0, DRV_NOTIFY_ID);
    ASSERT_EQ(err, RT_ERROR_DRV_NO_DEVICE);
    delete npuDrv;
}


TEST_F(CloudV2NpuDriverTest, NpuDriverNormalSqCqAllocate)
{
    NpuDriver *rawDrv = new NpuDriver();
    uint32_t info[5] = {};
    uint32_t msg[1] = {0};
    uint32_t sqId = 0U;
    uint32_t cqId = 0U;

    MOCKER(halSqCqAllocate).stubs().will(returnValue(DRV_ERROR_NONE));
    rtError_t err = rawDrv->NormalSqCqAllocate(1, 1, 0, &sqId, &cqId, info, sizeof(info), msg, sizeof(msg));
    EXPECT_EQ(err, RT_ERROR_NONE);

    err = rawDrv->NormalSqCqAllocate(1, 1, 0, &sqId, &cqId, info, sizeof(info), msg, sizeof(msg));
    EXPECT_EQ(err, RT_ERROR_NONE);

    delete rawDrv;
}

TEST_F(CloudV2NpuDriverTest, GetMaxStreamAndTask)
{
    NpuDriver *rawDrv = new NpuDriver();
    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    uint32_t maxCnt = 0U;

    MOCKER(halResourceInfoQuery).stubs().will(returnValue(DRV_ERROR_NONE));
    rtError_t err = rawDrv->GetMaxStreamAndTask(0, 0, &maxCnt);
    EXPECT_EQ(err, RT_ERROR_NONE);
    delete rawDrv;
}

TEST_F(CloudV2NpuDriverTest, GetMaxStreamAndTask_fail)
{
    NpuDriver *rawDrv = new NpuDriver();
    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    uint32_t maxCnt = 0U;

    MOCKER(halResourceInfoQuery).stubs().will(returnValue(1));
    rtError_t err = rawDrv->GetMaxStreamAndTask(0, 0, &maxCnt);
    EXPECT_NE(err, RT_ERROR_NONE);
    delete rawDrv;
}

TEST_F(CloudV2NpuDriverTest, create_destory_wqe)
{
    rtError_t error;
    NpuDriver * rawDrv = new NpuDriver();
    AsyncDmaWqeInputInfo input;
    AsyncDmaWqeOutputInfo output;
    AsyncDmaWqeDestroyInfo destoryPara;
    int32_t devId = 0;
    error = rawDrv->CreateAsyncDmaWqe(devId, input, &output);
    EXPECT_EQ(error, RT_ERROR_NONE);
 
    error = rawDrv->DestroyAsyncDmaWqe(devId, &destoryPara);
    EXPECT_EQ(error, RT_ERROR_NONE);
 
    MOCKER(halAsyncDmaCreate)
    .stubs()
    .will(returnValue(DRV_ERROR_INVALID_VALUE));
    error = rawDrv->CreateAsyncDmaWqe(devId, input, &output);
    EXPECT_EQ(error, RT_ERROR_DRV_ERR);
    MOCKER(halAsyncDmaDestory)
    .stubs()
    .will(returnValue(DRV_ERROR_INVALID_VALUE));
    error = rawDrv->DestroyAsyncDmaWqe(devId, &destoryPara);
    EXPECT_EQ(error, RT_ERROR_DRV_INPUT);
    delete rawDrv;
}

TEST_F(CloudV2NpuDriverTest, WriteNotifyRecord)
{
    rtError_t error;
    NpuDriver * rawDrv = new NpuDriver();
    const uint32_t deviceId = 0;
    const uint32_t tsId = 0;
    const uint32_t notifyId = 0;
    error = rawDrv->WriteNotifyRecord(deviceId, tsId, notifyId);
    EXPECT_EQ(error, RT_ERROR_NONE);

    MOCKER(halResourceConfig)
    .stubs()
    .will(returnValue(DRV_ERROR_INVALID_VALUE));
    error = rawDrv->WriteNotifyRecord(deviceId, tsId, notifyId);
    EXPECT_EQ(error, RT_ERROR_DRV_INPUT);
    delete rawDrv;
}

TEST_F(CloudV2NpuDriverTest, Support1GHugePageMemCtrl_1)
{
    NpuDriver * driver = new NpuDriver();
    int64_t val = RT_CAPABILITY_SUPPORT;
    auto ret = driver->Support1GHugePageCtrl();
    EXPECT_EQ(ret, RT_ERROR_NONE);

    MOCKER(halMemCtl).stubs().will(returnValue(DRV_ERROR_INVALID_VALUE));
    ret = driver->Support1GHugePageCtrl();
    EXPECT_EQ(ret, RT_ERROR_DRV_INPUT);

    delete driver;
    GlobalMockObject::verify();
}
 
TEST_F(CloudV2NpuDriverTest, host_register_02)
{
    rtError_t error;
    int ptr = 10;
    void **devPtr;
    NpuDriver *rawDrv = new NpuDriver();
 
    MOCKER(halHostRegister)
        .stubs()
        .will(returnValue(DRV_ERROR_NONE));
 
    MOCKER(halHostUnregisterEx)
        .stubs()
        .will(returnValue(DRV_ERROR_NONE));
 
    error = rawDrv->HostRegister(&ptr, 100 ,RT_HOST_REGISTER_MAPPED, devPtr, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);
 
    error = rawDrv->HostUnregister(&ptr, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    delete rawDrv;
}

TEST_F(CloudV2NpuDriverTest, host_register_03)
{
    rtError_t error;
    int ptr = 10;
    void **devPtr = nullptr;

    error = rtsHostRegister(&ptr, 100, RT_HOST_REGISTER_MAX, devPtr);
    EXPECT_EQ(error, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);

    error = rtsHostRegister(&ptr, 100, RT_HOST_REGISTER_MAPPED, nullptr);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);

    error = rtsHostUnregister(nullptr);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(CloudV2NpuDriverTest, host_register_06)
{ 
    rtError_t error;
    uintptr_t address_val = 0x00200000;
    void* ptr = nullptr;
    errno_t ret = memcpy_s(&ptr, sizeof(void*), &address_val, sizeof(uintptr_t));
    if (ret != 0) {
        ptr = nullptr;
    }
    void **devPtr;
    NpuDriver *rawDrv = new NpuDriver();
    g_isAddrFlatDevice = true;
    MOCKER(NpuDriver::CheckIsSupportFeature).stubs().will(returnValue(false));
    MOCKER(drvMemGetAttribute).stubs().will(invoke(drvMemGetAttribute_2));

    error = rawDrv->HostRegister(ptr, 100, RT_HOST_REGISTER_IOMEMORY, devPtr, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);     

    error = rawDrv->HostRegister(ptr, 100, RT_HOST_REGISTER_READONLY, devPtr, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);   
    error = rawDrv->HostUnregister(ptr, 0);
    EXPECT_EQ(error, RT_ERROR_NONE); 
    
    MOCKER(drvMemGetAttribute).stubs().will(invoke(drvMemGetAttribute_1));
    error = rawDrv->HostRegister(ptr, 0, static_cast<rtHostRegisterType>(RT_HOST_REGISTER_IOMEMORY | RT_HOST_REGISTER_READONLY), devPtr, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);   

    delete rawDrv;
}

TEST_F(CloudV2NpuDriverTest, GetDqsQueInfo_GetDqsMbufPoolInfo_Test)
{
    NpuDriver *rawDrv = new NpuDriver();
    MOCKER(halQueueGetDqsQueInfo).stubs().will(returnValue(DRV_ERROR_NOT_SUPPORT));
    MOCKER(halBuffGetDQSPooInfoById).stubs().will(returnValue(DRV_ERROR_NOT_SUPPORT));

    DqsQueueInfo queInfo = {};
    rtError_t error = rawDrv->GetDqsQueInfo(0, 0, &queInfo);
    EXPECT_NE(error, RT_ERROR_NONE);

    DqsPoolInfo dqsPoolInfo = {};
    error = rawDrv->GetDqsMbufPoolInfo(0, &dqsPoolInfo);
    EXPECT_NE(error, RT_ERROR_NONE);

    delete rawDrv;
}

TEST_F(CloudV2NpuDriverTest, CheckIsSupportFeature_invalid)
{
    NpuDriver *rawDrv = new NpuDriver();

    bool ret;
    int32_t feature = static_cast<int32_t>(FEATURE_MAX);
    ret = rawDrv->CheckIsSupportFeature(0, feature);
    EXPECT_FALSE(ret);

    feature += 1;
    ret = rawDrv->CheckIsSupportFeature(0, feature);
    EXPECT_FALSE(ret);
    delete rawDrv;
}