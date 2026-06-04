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
#define private public
#define protected public
#include "runtime.hpp"
#include "raw_device.hpp"
#include "module.hpp"
#include "event.hpp"
#include "task_info.hpp"
#include "device/device_error_proc.hpp"
#include "device_error_proc_c.hpp"
#include "program.hpp"
#include "uma_arg_loader.hpp"
#include "npu_driver.hpp"
#include "ctrl_res_pool.hpp"
#include "stream_sqcq_manage.hpp"
#include "api_impl.hpp"
#include "aicpu_err_msg.hpp"
#include "thread_local_container.hpp"
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
