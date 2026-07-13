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
#include "gtest/gtest.h"
#include "mockcpp/mockcpp.hpp"
#include "securec.h"
#include <stdalign.h>
#include <thread>
#include <vector>
#define private public
#define protected public
#include "runtime.hpp"
#include "model.hpp"
#include "raw_device.hpp"
#include "module.hpp"
#include "notify.hpp"
#include "event.hpp"
#include "task_info.hpp"
#include "ffts_task.h"
#include "device/device_error_proc.hpp"
#include "device_error_proc_c.hpp"
#include "program.hpp"
#include "uma_arg_loader.hpp"
#include "npu_driver.hpp"
#include "ctrl_res_pool.hpp"
#include "stream_sqcq_manage.hpp"
#include "davinci_kernel_task.h"
#include "api_impl.hpp"
#include "aicpu_err_msg.hpp"
#include "profiler.hpp"
#include "thread_local_container.hpp"
#include "stars_david.hpp"
#include "rt_unwrap.h"
#undef private
#undef protected
#include "rdma_task.h"
#include "device_sq_cq_pool.hpp"
#include "sq_addr_memory_pool.hpp"

using namespace testing;
using namespace cce::runtime;

rtError_t CheckFusionKernelErrorInfoStub(const StarsDeviceErrorInfo * const info,
    const uint64_t errorNumber, const Device * const dev, const DeviceErrorProc * const insPtr)
{
    EXPECT_EQ(info->u.fusionKernelErrorInfo.aicInfo.info[1].coreId, 25U);
    EXPECT_EQ(info->u.fusionKernelErrorInfo.aicInfo.info[1].aicCond, 0x1234U);
    EXPECT_EQ(info->u.fusionKernelErrorInfo.aicInfo.info[1].rsvExt[0], 0x13579BDFU);
    EXPECT_EQ(info->u.fusionKernelErrorInfo.aivInfo.info[1].coreId, 27U);
    EXPECT_EQ(info->u.fusionKernelErrorInfo.aivInfo.info[1].aicCond, 0x9abcU);
    EXPECT_EQ(info->u.fusionKernelErrorInfo.aivInfo.info[1].rsvExt[0], 0x13579BDFU);
    return RT_ERROR_NONE;
}

class DeviceTestDavid : public testing::Test
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
    }

    virtual void TearDown()
    {
        rtDeviceReset(0);
        GlobalMockObject::verify();
    }
public:
    Device *device_ = nullptr;
    Stream *stream_ = nullptr;
    Engine *engine_ = nullptr;
    rtStream_t streamHandle_ = 0;
    static void *binHandle_;
    static char function_;
    static uint32_t binary_[32];
};

static void InitStarv2ExtRingBufferCtl(DevRingBufferCtlInfo* ctlInfo, uint32_t tail)
{
    memset_s(ctlInfo, DEVICE_ERROR_EXT_RINGBUFFER_SIZE, 0, DEVICE_ERROR_EXT_RINGBUFFER_SIZE);
    ctlInfo->tail = tail;
    ctlInfo->head = 0;
    ctlInfo->magic = RINGBUFFER_MAGIC;
    ctlInfo->ringBufferLen = RINGBUFFER_LEN;
    ctlInfo->elementSize = RINGBUFFER_EXT_ONE_ELEMENT_LENGTH_ON_DAVID;
}

static void FillFusionKernelBase(RingBufferElementInfo* info)
{
    StarsDeviceErrorInfoRingBuffer* errorInfo = reinterpret_cast<StarsDeviceErrorInfoRingBuffer*>(info + 1);
    info->errorType = FUSION_KERNEL_ERROR;
    errorInfo->u.fusionKernelErrorInfo.aicError = 1;
    errorInfo->u.fusionKernelErrorInfo.aivError = 1;
    errorInfo->u.fusionKernelErrorInfo.aicInfo.comm.type = AICORE_ERROR;
    errorInfo->u.fusionKernelErrorInfo.aicInfo.comm.coreNum = 2;
    errorInfo->u.fusionKernelErrorInfo.aicInfo.info[0].coreId = 5;
    errorInfo->u.fusionKernelErrorInfo.aicInfo.info[1].coreId = 25;
    errorInfo->u.fusionKernelErrorInfo.aivInfo.comm.type = AIVECTOR_ERROR;
    errorInfo->u.fusionKernelErrorInfo.aivInfo.comm.coreNum = 2;
    errorInfo->u.fusionKernelErrorInfo.aivInfo.info[0].coreId = 7;
    errorInfo->u.fusionKernelErrorInfo.aivInfo.info[1].coreId = 27;
}

static void FillStarv2CoreExt(
    RingBufferElementInfo* info, rtErrorType errorType, uint32_t coreIndex, uint32_t coreId, uint64_t aicCond)
{
    DavidCoreErrorInfoExt* extData = reinterpret_cast<DavidCoreErrorInfoExt*>(info + 1);
    info->errorType = errorType;
    extData->comm.coreNum = coreIndex + 1U;
    extData->info[coreIndex].coreId = coreId;
    extData->info[coreIndex].validSize = sizeof(extData->info[coreIndex].aicCond) + sizeof(extData->info[coreIndex].rsv[0]);
    extData->info[coreIndex].aicCond = aicCond;
    extData->info[coreIndex].rsv[0] = 0x13579BDFU;
}

TEST_F(DeviceTestDavid, STARS_CORE_Normal_0)
{
    rtSetDevice(1);
    Device* device= ((Runtime *)Runtime::Instance())->DeviceRetain(1, 0);
    DeviceErrorProc *errorProc = new DeviceErrorProc(device);
    DevRingBufferCtlInfo *ctlInfo  = (DevRingBufferCtlInfo *)malloc(DEVICE_ERROR_EXT_RINGBUFFER_SIZE);
    EXPECT_NE(ctlInfo, nullptr);
    if (ctlInfo == nullptr) {
        return;
    }

    memset_s(ctlInfo, DEVICE_ERROR_EXT_RINGBUFFER_SIZE, 0, DEVICE_ERROR_EXT_RINGBUFFER_SIZE);
    ctlInfo->tail = 1;
    ctlInfo->head = 0;
    ctlInfo->magic = RINGBUFFER_MAGIC;
    ctlInfo->ringBufferLen  = RINGBUFFER_LEN;

    // element size is invalid
    rtError_t error = errorProc->ProcessStarv2OneElementInRingBuffer(ctlInfo, 0, 1);
    EXPECT_EQ(error, RT_ERROR_INVALID_VALUE);

    // init element size
    ctlInfo->elementSize = RINGBUFFER_EXT_ONE_ELEMENT_LENGTH_ON_DAVID;
    uint64_t oneElementLen = sizeof(StarsDeviceErrorInfo) + sizeof(RingBufferElementInfo);
    uintptr_t infoAddr = reinterpret_cast<uintptr_t>(ctlInfo) +
                            sizeof(DevRingBufferCtlInfo) +
                            ctlInfo->head * oneElementLen;
    RingBufferElementInfo *info = (RingBufferElementInfo *)infoAddr;
    StarsDeviceErrorInfo *errorInfo = reinterpret_cast<StarsDeviceErrorInfo *>(info + 1);
    info->errorType = AICORE_ERROR;
    errorInfo->u.davidCoreErrorInfo.comm.type = AICORE_ERROR;
    errorInfo->u.davidCoreErrorInfo.comm.coreNum = 1;
    errorInfo->u.davidCoreErrorInfo.info[0].coreId = 1;
    errorInfo->u.davidCoreErrorInfo.info[0].scError = 0x6;
    error = errorProc->ProcessStarv2OneElementInRingBuffer(ctlInfo, 0, 1);
    EXPECT_EQ(error, RT_ERROR_NONE);

    errorInfo->u.davidCoreErrorInfo.comm.type = AIVECTOR_ERROR;
    errorInfo->u.davidCoreErrorInfo.comm.coreNum = 2;
    errorInfo->u.davidCoreErrorInfo.comm.exceptionSlotId = 3;
    errorInfo->u.davidCoreErrorInfo.comm.dieId = 4;
    errorInfo->u.davidCoreErrorInfo.info[0].coreId = 5;
    errorInfo->u.davidCoreErrorInfo.info[0].vecError = 0x6;
    errorInfo->u.davidCoreErrorInfo.info[1].coreId = 25;

    error = errorProc->ProcessStarv2OneElementInRingBuffer(ctlInfo, 0, 1);
    EXPECT_EQ(error, RT_ERROR_NONE);
    free(ctlInfo);

    errorProc->deviceRingBufferAddr_ = nullptr;
    delete errorProc;
    ((Runtime *)Runtime::Instance())->DeviceRelease(device);
    rtDeviceReset(1);
}

TEST_F(DeviceTestDavid, FUSION_KERNEL_Merge_Base_WithStarv2Ext)
{
    rtSetDevice(1);
    Device* device = ((Runtime*)Runtime::Instance())->DeviceRetain(1, 0);
    DeviceErrorProc* errorProc = new DeviceErrorProc(device);
    DevRingBufferCtlInfo* ctlInfo = (DevRingBufferCtlInfo*)malloc(DEVICE_ERROR_EXT_RINGBUFFER_SIZE);
    EXPECT_NE(ctlInfo, nullptr);
    if (ctlInfo == nullptr) {
        return;
    }

    InitStarv2ExtRingBufferCtl(ctlInfo, 3);

    uintptr_t infoAddr = reinterpret_cast<uintptr_t>(ctlInfo) + sizeof(DevRingBufferCtlInfo);
    RingBufferElementInfo* info = (RingBufferElementInfo*)infoAddr;
    FillFusionKernelBase(info);

    uintptr_t aicExtAddr = infoAddr + RINGBUFFER_EXT_ONE_ELEMENT_LENGTH_ON_DAVID;
    RingBufferElementInfo* aicExtInfo = (RingBufferElementInfo*)aicExtAddr;
    FillStarv2CoreExt(aicExtInfo, AICORE_EXT_ERROR, 1U, 25, 0x1234U);

    uintptr_t aivExtAddr = aicExtAddr + RINGBUFFER_EXT_ONE_ELEMENT_LENGTH_ON_DAVID;
    RingBufferElementInfo* aivExtInfo = (RingBufferElementInfo*)aivExtAddr;
    FillStarv2CoreExt(aivExtInfo, AIVECTOR_EXT_ERROR, 1U, 27, 0x9abcU);

    MOCKER(ProcessDavidStarsFusionKernelErrorInfo).stubs().will(invoke(CheckFusionKernelErrorInfoStub));
    rtError_t error = errorProc->ProcessStarv2OneElementInRingBuffer(ctlInfo, 0, 3);
    EXPECT_EQ(error, RT_ERROR_NONE);
    free(ctlInfo);

    errorProc->deviceRingBufferAddr_ = nullptr;
    delete errorProc;
    ((Runtime*)Runtime::Instance())->DeviceRelease(device);
    rtDeviceReset(1);
}

TEST_F(DeviceTestDavid, ProcessReportRingBuffer_Test)
{
    uint16_t errorStreamId;
    rtSetDevice(1);
    Device* device= ((Runtime *)Runtime::Instance())->DeviceRetain(1, 0);
    DeviceErrorProc *errorProc = new DeviceErrorProc(device);
    DevRingBufferCtlInfo ctlInfo  = {RINGBUFFER_MAGIC, 0U, 1U, RINGBUFFER_LEN, 0U, 0U, 0U};
    Driver *driver = ((Runtime *)Runtime::Instance())->driverFactory_.GetDriver(NPU_DRIVER);

    // element size is error.
    rtError_t error = errorProc->ProcessReportRingBuffer(&ctlInfo, driver, &errorStreamId);
    EXPECT_EQ(error, RT_ERROR_INVALID_VALUE);

    errorProc->deviceRingBufferAddr_ = nullptr;
    delete errorProc;
    ((Runtime *)Runtime::Instance())->DeviceRelease(device);
    rtDeviceReset(1);
}

TEST_F(DeviceTestDavid, AllocSqRegVirtualAddr)
{
    rtSetDevice(1);
    Device* device = ((Runtime*)Runtime::Instance())->DeviceRetain(1, 0);
    DeviceSqCqPool *deviceSqCqPool = device->GetDeviceSqCqManage();
    rtError_t expectRet = 1;
    uint64_t sqRegVirtualAddr = 2U;

    MOCKER_CPP_VIRTUAL((NpuDriver*)(device->Driver_()),&NpuDriver::GetSqRegVirtualAddrBySqid).stubs()
        .will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP(&DeviceSqCqPool::SetSqRegVirtualAddrToDevice).stubs()
        .will(returnValue(expectRet));
    MOCKER_CPP_VIRTUAL((NpuDriver*)(device->Driver_()),&NpuDriver::UnmapSqRegVirtualAddrBySqid).stubs()
        .will(returnValue(RT_ERROR_NONE));

    rtError_t ret = deviceSqCqPool->AllocSqRegVirtualAddr(1U, sqRegVirtualAddr);
    EXPECT_EQ(ret, expectRet);

    ((Runtime *)Runtime::Instance())->DeviceRelease(device);
    rtDeviceReset(1);
}

TEST_F(DeviceTestDavid, AddAddrKernelNameMapTableTest)
{
    RawDevice dev(0);
    dev.Init();
    dev.chipType_ = static_cast<rtChipType_t>(PLAT_GET_CHIP(static_cast<uint64_t>(0x500)));
    rtAddrKernelName_t mapInfo;
    mapInfo.addr = 0;
    mapInfo.kernelName = "testKernel";
    auto error = dev.AddAddrKernelNameMapTable(mapInfo);
    EXPECT_EQ(error, RT_ERROR_FEATURE_NOT_SUPPORT);
}

class DavidDeviceLimitTest : public testing::Test {
protected:
    static void SetUpTestCase() {}

    static void TearDownTestCase() {}

    virtual void SetUp()
    {
        Runtime* rtInstance = (Runtime*)Runtime::Instance();
        oldChipType = rtInstance->GetChipType();
        rtInstance->SetChipType(CHIP_DAVID);
        GlobalContainer::SetRtChipType(CHIP_DAVID);
        int64_t hardwareVersion = CHIP_DAVID << 8;
        Driver* driver_ = ((Runtime*)Runtime::Instance())->driverFactory_.GetDriver(NPU_DRIVER);
        MOCKER_CPP_VIRTUAL(driver_, &Driver::GetDevInfo)
            .stubs()
            .with(mockcpp::any(), mockcpp::any(), mockcpp::any(), outBoundP(&hardwareVersion, sizeof(hardwareVersion)))
            .will(returnValue(RT_ERROR_NONE));
        char* socVer = "Ascend950PR_9599";
        MOCKER(halGetSocVersion)
            .stubs()
            .with(mockcpp::any(), outBoundP(socVer, strlen("Ascend950PR_9599")), mockcpp::any())
            .will(returnValue(DRV_ERROR_NONE));
        oldDeviceCustomerStackSize = rtInstance->deviceCustomerStackSize_;
        oldSimtWarpStkSize = rtInstance->simtWarpStkSize_;
        oldSimtDvgWarpStkSize = rtInstance->simtDvgWarpStkSize_;
        oldPrintblockLen = rtInstance->printblockLen_;
        oldSimtPrintLen = rtInstance->simtPrintLen_;
        rtInstance->deviceCustomerStackSize_ = KERNEL_STACK_SIZE_32K;
        isCfgOpWaitTaskTimeout = rtInstance->timeoutConfig_.isCfgOpWaitTaskTimeout;
        isCfgOpExcTaskTimeout = rtInstance->timeoutConfig_.isCfgOpExcTaskTimeout;
        rtInstance->timeoutConfig_.isCfgOpWaitTaskTimeout = false;
        rtInstance->timeoutConfig_.isCfgOpExcTaskTimeout = false;
        rtSetDevice(0);
    }

    virtual void TearDown()
    {
        rtDeviceReset(0);
        Runtime* rtInstance = (Runtime*)Runtime::Instance();
        rtInstance->timeoutConfig_.isCfgOpWaitTaskTimeout = isCfgOpWaitTaskTimeout;
        rtInstance->timeoutConfig_.isCfgOpExcTaskTimeout = isCfgOpExcTaskTimeout;
        rtInstance->SetChipType(oldChipType);
        GlobalContainer::SetRtChipType(oldChipType);
        rtInstance->deviceCustomerStackSize_ = oldDeviceCustomerStackSize;
        rtInstance->simtWarpStkSize_ = oldSimtWarpStkSize;
        rtInstance->simtDvgWarpStkSize_ = oldSimtDvgWarpStkSize;
        rtInstance->printblockLen_ = oldPrintblockLen;
        rtInstance->simtPrintLen_ = oldSimtPrintLen;
        GlobalMockObject::verify();
    }

private:
    rtChipType_t oldChipType;
    uint32_t oldDeviceCustomerStackSize{KERNEL_STACK_SIZE_32K};
    uint64_t oldSimtWarpStkSize{0};
    uint32_t oldSimtDvgWarpStkSize{0};
    uint32_t oldPrintblockLen{0};
    uint32_t oldSimtPrintLen{0};
    bool isCfgOpWaitTaskTimeout{false};
    bool isCfgOpExcTaskTimeout{false};
};

TEST_F(DavidDeviceLimitTest, SetAndGetLimit_StackSize_Success)
{
    rtError_t ret = rtDeviceSetLimit(0, RT_LIMIT_TYPE_STACK_SIZE, 65536U);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    uint32_t val = 0U;
    ret = rtDeviceGetLimit(RT_LIMIT_TYPE_STACK_SIZE, &val);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    EXPECT_EQ(val, 65536U);
}

TEST_F(DavidDeviceLimitTest, SetAndGetLimit_SimtStackSize_Success)
{
    rtError_t ret = rtDeviceSetLimit(0, RT_LIMIT_TYPE_SIMT_STACK_SIZE, 256U);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    uint32_t val = 0U;
    ret = rtDeviceGetLimit(RT_LIMIT_TYPE_SIMT_STACK_SIZE, &val);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    EXPECT_EQ(val, 256U * RT_MAX_THREAD_NUM_PER_WARP);
}

TEST_F(DavidDeviceLimitTest, SetLimit_SimtStackSize_AlignTo128B)
{
    rtError_t ret = rtDeviceSetLimit(0, RT_LIMIT_TYPE_SIMT_STACK_SIZE, 200U);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    uint32_t val = 0U;
    ret = rtDeviceGetLimit(RT_LIMIT_TYPE_SIMT_STACK_SIZE, &val);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    EXPECT_EQ(val, 256U * RT_MAX_THREAD_NUM_PER_WARP);
}

TEST_F(DavidDeviceLimitTest, SetAndGetLimit_SimtDvgWarpStackSize_Success)
{
    rtError_t ret = rtDeviceSetLimit(0, RT_LIMIT_TYPE_SIMT_DVG_WARP_STACK_SIZE, 512U);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    uint32_t val = 0U;
    ret = rtDeviceGetLimit(RT_LIMIT_TYPE_SIMT_DVG_WARP_STACK_SIZE, &val);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    EXPECT_EQ(val, 512U);
}

TEST_F(DavidDeviceLimitTest, SetAndGetLimit_SimtPrintfFifo_Success)
{
    rtError_t ret = rtDeviceSetLimit(0, RT_LIMIT_TYPE_SIMT_PRINTF_FIFO_SIZE, 2097152U);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    uint32_t val = 0U;
    ret = rtDeviceGetLimit(RT_LIMIT_TYPE_SIMT_PRINTF_FIFO_SIZE, &val);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    EXPECT_EQ(val, 2097152U);
}

TEST_F(DavidDeviceLimitTest, SetAndGetLimit_SimdPrintfFifo_Success)
{
    rtError_t ret = rtDeviceSetLimit(0, RT_LIMIT_TYPE_SIMD_PRINTF_FIFO_SIZE_PER_CORE, 65536U);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    uint32_t val = 0U;
    ret = rtDeviceGetLimit(RT_LIMIT_TYPE_SIMD_PRINTF_FIFO_SIZE_PER_CORE, &val);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    EXPECT_EQ(val, 65536U);
}

TEST_F(DavidDeviceLimitTest, SetLimit_Concurrent_SimtStackSize_NoCrash)
{
    const int32_t threadNum = 4;
    std::vector<std::thread> threads;
    for (int32_t i = 0; i < threadNum; i++) {
        threads.emplace_back([i]() {
            uint32_t val = 256U + static_cast<uint32_t>(i) * 128U;
            rtDeviceSetLimit(0, RT_LIMIT_TYPE_SIMT_STACK_SIZE, val);
        });
    }
    for (auto &t : threads) { t.join(); }

    uint32_t val = 0U;
    rtError_t ret = rtDeviceGetLimit(RT_LIMIT_TYPE_SIMT_STACK_SIZE, &val);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    EXPECT_GE(val, 256U * RT_MAX_THREAD_NUM_PER_WARP);
}

TEST_F(DavidDeviceLimitTest, SetLimit_Concurrent_SimtDvgStackSize_NoCrash)
{
    const int32_t threadNum = 4;
    std::vector<std::thread> threads;
    for (int32_t i = 0; i < threadNum; i++) {
        threads.emplace_back([i]() {
            uint32_t val = 512U + static_cast<uint32_t>(i) * 128U;
            rtDeviceSetLimit(0, RT_LIMIT_TYPE_SIMT_DVG_WARP_STACK_SIZE, val);
        });
    }
    for (auto &t : threads) { t.join(); }

    uint32_t val = 0U;
    rtError_t ret = rtDeviceGetLimit(RT_LIMIT_TYPE_SIMT_DVG_WARP_STACK_SIZE, &val);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    EXPECT_GE(val, 512U);
}

TEST_F(DavidDeviceLimitTest, SetLimit_Concurrent_SimtStack_SetAndGet_NoCrash)
{
    const int32_t writerNum = 2;
    const int32_t readerNum = 2;
    std::vector<std::thread> threads;

    for (int32_t i = 0; i < writerNum; i++) {
        threads.emplace_back([i]() {
            for (int32_t j = 0; j < 100; j++) {
                uint32_t val = 256U + static_cast<uint32_t>(i) * 128U;
                rtDeviceSetLimit(0, RT_LIMIT_TYPE_SIMT_STACK_SIZE, val);
            }
        });
    }
    for (int32_t i = 0; i < readerNum; i++) {
        threads.emplace_back([]() {
            for (int32_t j = 0; j < 100; j++) {
                uint32_t val = 0U;
                rtDeviceGetLimit(RT_LIMIT_TYPE_SIMT_STACK_SIZE, &val);
            }
        });
    }
    for (auto &t : threads) { t.join(); }

    uint32_t val = 0U;
    rtError_t ret = rtDeviceGetLimit(RT_LIMIT_TYPE_SIMT_STACK_SIZE, &val);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    EXPECT_GE(val, 256U * RT_MAX_THREAD_NUM_PER_WARP);
}

TEST_F(DavidDeviceLimitTest, SetLimit_Concurrent_BothSimtStacks_NoCrash)
{
    const int32_t threadNum = 4;
    std::vector<std::thread> threads;
    for (int32_t i = 0; i < threadNum; i++) {
        threads.emplace_back([i]() {
            if (i % 2 == 0) {
                rtDeviceSetLimit(0, RT_LIMIT_TYPE_SIMT_STACK_SIZE, 256U + static_cast<uint32_t>(i) * 128U);
            } else {
                rtDeviceSetLimit(0, RT_LIMIT_TYPE_SIMT_DVG_WARP_STACK_SIZE, 512U + static_cast<uint32_t>(i) * 128U);
            }
        });
    }
    for (auto &t : threads) { t.join(); }

    uint32_t val = 0U;
    rtError_t ret = rtDeviceGetLimit(RT_LIMIT_TYPE_SIMT_STACK_SIZE, &val);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    EXPECT_GE(val, 256U * RT_MAX_THREAD_NUM_PER_WARP);

    val = 0U;
    ret = rtDeviceGetLimit(RT_LIMIT_TYPE_SIMT_DVG_WARP_STACK_SIZE, &val);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    EXPECT_GE(val, 512U);
}

TEST_F(DavidDeviceLimitTest, SetLimit_SimtFifo_NegativeOne_ReturnsError)
{
    rtError_t ret = rtDeviceSetLimit(0, RT_LIMIT_TYPE_SIMT_PRINTF_FIFO_SIZE, static_cast<uint32_t>(-1));
    EXPECT_NE(ret, RT_ERROR_NONE);
}

TEST_F(DavidDeviceLimitTest, SetLimit_SimdFifo_NegativeOne_ReturnsError)
{
    rtError_t ret = rtDeviceSetLimit(0, RT_LIMIT_TYPE_SIMD_PRINTF_FIFO_SIZE_PER_CORE, static_cast<uint32_t>(-1));
    EXPECT_NE(ret, RT_ERROR_NONE);
}

TEST_F(DavidDeviceLimitTest, SetLimit_SimtFifo_BelowMin_ReturnsError)
{
    rtError_t ret = rtDeviceSetLimit(0, RT_LIMIT_TYPE_SIMT_PRINTF_FIFO_SIZE, 512U * 1024U);
    EXPECT_NE(ret, RT_ERROR_NONE);
}

TEST_F(DavidDeviceLimitTest, SetAndGetLimit_LowPowerTimeout_Placeholder)
{
    rtError_t ret = rtDeviceSetLimit(0, RT_LIMIT_TYPE_LOW_POWER_TIMEOUT, 1000U);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    uint32_t val = 999U;
    ret = rtDeviceGetLimit(RT_LIMIT_TYPE_LOW_POWER_TIMEOUT, &val);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    EXPECT_EQ(val, 0U);
}

TEST_F(DavidDeviceLimitTest, GetLimit_NullValue_ReturnsError)
{
    rtError_t ret = rtDeviceGetLimit(RT_LIMIT_TYPE_STACK_SIZE, nullptr);
    EXPECT_NE(ret, RT_ERROR_NONE);
}

TEST_F(DavidDeviceLimitTest, SetLimit_InvalidDevId_ReturnsError)
{
    rtError_t ret = rtDeviceSetLimit(-1, RT_LIMIT_TYPE_STACK_SIZE, 65536U);
    EXPECT_NE(ret, RT_ERROR_NONE);
}

TEST_F(DavidDeviceLimitTest, GetLimit_NullValue_ErrMsg_ReturnsInvalidValue)
{
    rtError_t ret = rtDeviceGetLimit(RT_LIMIT_TYPE_STACK_SIZE, nullptr);
    EXPECT_NE(ret, RT_ERROR_NONE);
}

TEST_F(DavidDeviceLimitTest, GetLimit_UnsupportedType_ErrMsg_ReturnsError)
{
    uint32_t val = 999U;
    rtError_t ret = rtDeviceGetLimit(static_cast<rtLimitType_t>(99), &val);
    EXPECT_NE(ret, RT_ERROR_NONE);
}

TEST_F(DavidDeviceLimitTest, GetLimit_AllTypes_DefaultValues)
{
    uint32_t val = 0U;

    rtError_t ret = rtDeviceGetLimit(RT_LIMIT_TYPE_STACK_SIZE, &val);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    EXPECT_EQ(val, KERNEL_STACK_SIZE_32K);

    ret = rtDeviceGetLimit(RT_LIMIT_TYPE_SIMT_STACK_SIZE, &val);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    ret = rtDeviceGetLimit(RT_LIMIT_TYPE_SIMT_DVG_WARP_STACK_SIZE, &val);
    EXPECT_EQ(ret, RT_ERROR_NONE);
}

TEST_F(DavidDeviceLimitTest, GetLimit_UnsupportedType_ReturnsNotSupport)
{
    uint32_t val = 999U;
    rtError_t ret = rtDeviceGetLimit(static_cast<rtLimitType_t>(99), &val);
    EXPECT_NE(ret, RT_ERROR_NONE);
}

TEST_F(DavidDeviceLimitTest, SetLimit_BothSimtStacksZero_ReturnsError)
{
    rtError_t ret = rtDeviceSetLimit(0, RT_LIMIT_TYPE_SIMT_STACK_SIZE, 0U);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    ret = rtDeviceSetLimit(0, RT_LIMIT_TYPE_SIMT_DVG_WARP_STACK_SIZE, 0U);
    EXPECT_NE(ret, RT_ERROR_NONE);
}

TEST_F(DavidDeviceLimitTest, SetLimit_SimtStackSize_LargeValue)
{
    const uint32_t largeVal = 256U * 1024U * 1024U;
    rtError_t ret = rtDeviceSetLimit(0, RT_LIMIT_TYPE_SIMT_STACK_SIZE, largeVal);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    uint32_t val = 0U;
    ret = rtDeviceGetLimit(RT_LIMIT_TYPE_SIMT_STACK_SIZE, &val);
    EXPECT_EQ(ret, RT_ERROR_NONE);
}

TEST_F(DavidDeviceLimitTest, SetLimit_SimtFifo_Zero_ReturnsError)
{
    rtError_t ret = rtDeviceSetLimit(0, RT_LIMIT_TYPE_SIMT_PRINTF_FIFO_SIZE, 0U);
    EXPECT_NE(ret, RT_ERROR_NONE);
}

TEST_F(DavidDeviceLimitTest, SetLimit_SimtFifo_MinValue_Success)
{
    rtError_t ret = rtDeviceSetLimit(0, RT_LIMIT_TYPE_SIMT_PRINTF_FIFO_SIZE, 1U * 1024U * 1024U);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    uint32_t val = 0U;
    ret = rtDeviceGetLimit(RT_LIMIT_TYPE_SIMT_PRINTF_FIFO_SIZE, &val);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    EXPECT_GE(val, 1U * 1024U * 1024U);
}

TEST_F(DavidDeviceLimitTest, SetLimit_SimtFifo_MaxValue_Success)
{
    rtError_t ret = rtDeviceSetLimit(0, RT_LIMIT_TYPE_SIMT_PRINTF_FIFO_SIZE, 64U * 1024U * 1024U);
    EXPECT_EQ(ret, RT_ERROR_NONE);
}
