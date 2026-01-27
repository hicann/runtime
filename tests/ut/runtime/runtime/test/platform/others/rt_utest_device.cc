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

using namespace testing;
using namespace cce::runtime;

class ChipDeviceTest : public testing::Test
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
		GlobalMockObject::verify();
    }

    virtual void TearDown()
    {
        rtDeviceReset(0);
        std::cout << "a test TearDown" << std::endl;
        GlobalMockObject::verify();
    }
public:
    static uint32_t g_case_num;
    static uint32_t g_streamId;
    static uint16_t g_sId;
    static uint16_t g_tId;
    static uint32_t g_printType;
    static rtError_t MemCopySyncForRingBuffer(Driver *drv, void *dst, uint64_t destMax, const void *src, uint64_t size, rtMemcpyKind_t kind)
    {
        if (g_case_num == 0) {
            return RT_ERROR_DRV_INPUT;
        }
        if (g_case_num == 100) {
            DevRingBufferCtlInfo *tmpCtrlInfo = reinterpret_cast<DevRingBufferCtlInfo *>(dst);
            tmpCtrlInfo->magic = RINGBUFFER_MAGIC;
            tmpCtrlInfo->tail = 0;
            tmpCtrlInfo->head = 0;
            return RT_ERROR_NONE;
        }
        if (size == sizeof(DevRingBufferCtlInfo)) {
            DevRingBufferCtlInfo *tmpCtrlInfo = reinterpret_cast<DevRingBufferCtlInfo *>(dst);
            tmpCtrlInfo->magic = RINGBUFFER_MAGIC;
            tmpCtrlInfo->tail = 1;
            tmpCtrlInfo->head = 0;
            return RT_ERROR_NONE;
        }
        if (size == (sizeof(RingBufferElementInfo) + sizeof(StarsDeviceErrorInfo))) {
            RingBufferElementInfo *info = reinterpret_cast<RingBufferElementInfo *>(dst);
            info->errorType = g_case_num;
            StarsDeviceErrorInfo *errorInfo = reinterpret_cast<StarsDeviceErrorInfo *>(info + 1);
            switch (g_case_num) {
                case FFTS_PLUS_AIVECTOR_ERROR:
                    errorInfo->u.coreErrorInfo.comm.streamId = g_streamId;
                    break;
                case FFTS_PLUS_SDMA_ERROR:
                    errorInfo->u.sdmaErrorInfo.comm.streamId = g_streamId;
                    break;
                case FFTS_PLUS_AICPU_ERROR:
                    errorInfo->u.aicpuErrorInfo.comm.streamId = g_streamId;
                    break;
                case DVPP_ERROR:
                    errorInfo->u.dvppErrorInfo.streamId = g_streamId;
                    break;
                case FFTS_PLUS_DSA_ERROR:
                    errorInfo->u.dsaErrorInfo.sqe.sqeHeader.rt_stream_id = g_streamId;
                    break;
                case SQE_ERROR:
                    errorInfo->u.sqeErrorInfo.streamId = g_streamId;
                    break;
                case WAIT_TIMEOUT_ERROR:
                    errorInfo->u.timeoutErrorInfo.streamId = g_streamId;
                    break;
                case HCCL_FFTSPLUS_TIMEOUT_ERROR:
                    errorInfo->u.hcclFftsplusTimeoutInfo.common.streamId = g_streamId;
                    break;
                case FUSION_KERNEL_ERROR:
                    errorInfo->u.fusionKernelErrorInfo.comm.streamId = g_streamId;
                    break;
                case CCU_ERROR:
                    errorInfo->u.ccuErrorInfo.comm.streamId = g_streamId;
                    break;
                default:
                    break;
            }
        }
        return RT_ERROR_NONE;
    }

    static rtError_t MemCopySyncForRingBuffer2(Driver *drv, void *dst, uint64_t destMax, const void *src, uint64_t size, rtMemcpyKind_t kind)
    {
        uint32_t DEVICE_RINGBUFFER_SIZE = 2U * 1024U * 1024U;
        uint32_t RINGBUFFER_EXT_ONE_ELEMENT_LENGTH = 12288U; // 4K + 8K
        if (size == DEVICE_RINGBUFFER_SIZE) {
            // ringbuffer 头
            DevRingBufferCtlInfo *tmpCtrlInfo = reinterpret_cast<DevRingBufferCtlInfo *>(dst);
            tmpCtrlInfo->magic = RINGBUFFER_MAGIC;
            tmpCtrlInfo->tail = 1;
            tmpCtrlInfo->head = 0;

            size_t headSize = sizeof(DevRingBufferCtlInfo);
            size_t elementSize = RINGBUFFER_EXT_ONE_ELEMENT_LENGTH;
            uint8_t * infoAddr =  reinterpret_cast<uint8_t *>(tmpCtrlInfo) + headSize + (tmpCtrlInfo->head * elementSize);
            RingBufferElementInfo * info = reinterpret_cast<RingBufferElementInfo *>(infoAddr);
            info->errorType = AICORE_ERROR;
            StarsDeviceErrorInfo *errorInfo = reinterpret_cast<StarsDeviceErrorInfo *>(info + 1);
            errorInfo->u.coreErrorInfo.comm.streamId = g_sId;
            errorInfo->u.coreErrorInfo.comm.taskId = g_tId;
            errorInfo->u.coreErrorInfo.comm.coreNum = 0U;
        }
        return RT_ERROR_NONE;
    }

    static rtError_t MemCopySyncStub0(Driver *drv, void *dst, uint64_t destMax, const void *src, uint64_t size, rtMemcpyKind_t kind)
    {
        RtsTimeoutStreamSnapshot *Snapshot = reinterpret_cast<RtsTimeoutStreamSnapshot *>(dst);
        if (g_printType == 0) {
            Snapshot->stream_num = 0;
        } else if (g_printType == 1) {
            Snapshot->stream_num = 1;
        } else if (g_printType == 2) {
            Snapshot->stream_num = 1;
            Snapshot->detailInfo[0].stream_id = 1;
            Snapshot->detailInfo[0].task_id = 0;
        } else if (g_printType == 3) {
            Snapshot->stream_num = 1;
            Snapshot->detailInfo[0].stream_id = 1;
            Snapshot->detailInfo[0].task_id = 1;
        } else if (g_printType == 4) {
            Snapshot->stream_num = 1;
            Snapshot->detailInfo[0].stream_id = 1;
            Snapshot->detailInfo[0].task_id = 2;
        } else if (g_printType == 5) {
            Snapshot->stream_num = 1;
            Snapshot->detailInfo[0].stream_id = 1;
            Snapshot->detailInfo[0].task_id = 3;
        } else if (g_printType == 6) {
            Snapshot->stream_num = 1;
            Snapshot->detailInfo[0].stream_id = 1;
            Snapshot->detailInfo[0].task_id = 4;
        } else if (g_printType == 7) {
            Snapshot->stream_num = 1;
            Snapshot->detailInfo[0].stream_id = 1;
            Snapshot->detailInfo[0].task_id = 5;
        } else if(g_printType == 8) {
            Snapshot->stream_num = 1;
            Snapshot->detailInfo[0].stream_id = 1;
            Snapshot->detailInfo[0].task_id = 6;
        } else if(g_printType == 9) {
            Snapshot->stream_num = 1;
            Snapshot->detailInfo[0].stream_id = 1;
            Snapshot->detailInfo[0].task_id = 7;
        }

        return DRV_ERROR_NONE;
    }

    static rtError_t MemCopySyncStub1(Driver *drv, void *dst, uint64_t destMax, const void *src, uint64_t size, rtMemcpyKind_t kind)
    {
        DevRingBufferCtlInfo *tmpCtrlInfo = reinterpret_cast<DevRingBufferCtlInfo *>(dst);
        tmpCtrlInfo->magic = 0;
        tmpCtrlInfo->ringBufferLen = 0;
        return DRV_ERROR_NONE;
    }
private:
    rtChipType_t originType;
};

uint32_t ChipDeviceTest::g_case_num = 0;
uint32_t ChipDeviceTest::g_streamId = 0;
uint16_t ChipDeviceTest::g_sId = 0;
uint16_t ChipDeviceTest::g_tId = 0;
uint32_t ChipDeviceTest::g_printType = 0;


TEST_F(ChipDeviceTest, device_error_proc1)
{
    Device* device = ((Runtime *)Runtime::Instance())->DeviceRetain(0, 0);
    DeviceErrorProc *errorProc = new DeviceErrorProc(device);
    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    rtChipType_t chipOld = rtInstance->GetChipType();
    rtInstance->SetChipType(CHIP_DC);
    GlobalContainer::SetRtChipType(CHIP_DC);
    void *memBase = (void*)100;
    MOCKER_CPP_VIRTUAL((NpuDriver*)(device->Driver_()),&NpuDriver::DevMemAlloc)
        .stubs()
        .with(outBoundP(&memBase, sizeof(memBase)), mockcpp::any(), mockcpp::any(), mockcpp::any())
        .will(returnValue(RT_ERROR_NONE));
    rtError_t error = errorProc->CreateDeviceRingBufferAndSendTask();
    EXPECT_EQ(error, RT_ERROR_NONE);

    errorProc->deviceRingBufferAddr_ = (void *)0xffff;
    MOCKER_CPP(&DeviceErrorProc::ProcRingBufferTask)
        .stubs()
        .will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL((NpuDriver*)(device->Driver_()),&NpuDriver::DevMemFree)
        .stubs()
        .will(returnValue(RT_ERROR_NONE));
    error = errorProc->SendTaskToStopUseRingBuffer();
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = errorProc->DestroyDeviceRingBuffer();
    EXPECT_EQ(error, RT_ERROR_NONE);

    errorProc->deviceRingBufferAddr_ = nullptr;
    error = errorProc->SendTaskToStopUseRingBuffer();
    EXPECT_EQ(error, RT_ERROR_NONE);

    errorProc->fastRingBufferAddr_ = (void *)1;
    error = errorProc->SendTaskToStopUseRingBuffer();
    EXPECT_EQ(error, RT_ERROR_NONE);

    MOCKER_CPP_VIRTUAL((NpuDriver*)(device->Driver_()),&NpuDriver::DevMemFree)
        .stubs()
        .will(returnValue(RT_ERROR_NONE));
    error = errorProc->DestroyDeviceRingBuffer();
    EXPECT_EQ(error, RT_ERROR_NONE);

    DeviceErrorInfo coreInfo;
    coreInfo.u.coreErrorInfo.coreNum = 1;
    coreInfo.u.coreErrorInfo.info[0].aicError = 0;
    error = errorProc->ProcessCoreErrorInfo(&coreInfo, 0, device);
    EXPECT_EQ(error, RT_ERROR_NONE);

    coreInfo.u.coreErrorInfo.type = AICORE_ERROR;
    coreInfo.u.coreErrorInfo.dhaNum = 1;
    uint32_t tsVersion = device->GetTschVersion();
    device->SetTschVersion(TS_VERSION_AIC_ERR_DHA_INFO);
    error = errorProc->ProcessCoreErrorInfo(&coreInfo, 0, device);
    EXPECT_EQ(error, RT_ERROR_NONE);
    device->SetTschVersion(tsVersion);
    coreInfo.u.coreErrorInfo.type = AIVECTOR_ERROR;
    coreInfo.u.coreErrorInfo.info[0].aicError = 1;
    error = errorProc->ProcessCoreErrorInfo(&coreInfo, 0, device);
    EXPECT_EQ(error, RT_ERROR_NONE);

    coreInfo.u.sdmaErrorInfo.channelStatus = 1 << 16;
    error = errorProc->ProcessSdmaErrorInfo(&coreInfo, 0, device);
    EXPECT_EQ(error, RT_ERROR_NONE);
    coreInfo.u.sdmaErrorInfo.channelStatus = 1 << 1;
    error = errorProc->ProcessSdmaErrorInfo(&coreInfo, 0, device);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = errorProc->ProcessAicpuErrorInfo(&coreInfo, 0, device);
    EXPECT_EQ(error, RT_ERROR_NONE);

    DevRingBufferCtlInfo ctrlInfo;
    ctrlInfo.ringBufferLen = 0;
    error = errorProc->CheckValid(&ctrlInfo);
    EXPECT_EQ(error, RT_ERROR_INVALID_VALUE);
    ctrlInfo.ringBufferLen = 1;
    ctrlInfo.magic = 0;
    error = errorProc->CheckValid(&ctrlInfo);
    EXPECT_EQ(error, RT_ERROR_INVALID_VALUE);
    ctrlInfo.magic = 0xA55A2020;
    ctrlInfo.head = 16;
    error = errorProc->CheckValid(&ctrlInfo);
    EXPECT_EQ(error, RT_ERROR_INVALID_VALUE);

    rtInstance->SetChipType(chipOld);
    GlobalContainer::SetRtChipType(chipOld);
    GlobalMockObject::verify();

    delete errorProc;
    ((Runtime *)Runtime::Instance())->DeviceRelease(device);
}

TEST_F(ChipDeviceTest, device_error_proc2)
{
    Device* device = ((Runtime *)Runtime::Instance())->DeviceRetain(0, 0);
    DeviceErrorProc *errorProc = new DeviceErrorProc(device);
    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    std::unique_ptr<char[]> hostAddr(new (std::nothrow)  char[16]);
    rtChipType_t chipOld = rtInstance->GetChipType();
    rtInstance->SetChipType(CHIP_DC);
    GlobalContainer::SetRtChipType(CHIP_DC);

    rtError_t error = errorProc->ProcRingBufferTask(hostAddr.get(), false, 1);
    EXPECT_EQ(error, RT_ERROR_NONE);

    errorProc->deviceRingBufferAddr_ = hostAddr.get();

    MOCKER_CPP_VIRTUAL((NpuDriver*)(device->Driver_()),&NpuDriver::MemCopySync)
        .stubs()
        .will(returnValue(RT_ERROR_NONE));
    error = errorProc->ProcErrorInfo();
    EXPECT_EQ(error, RT_ERROR_INVALID_VALUE);
    GlobalMockObject::verify();
    delete errorProc;
    ((Runtime *)Runtime::Instance())->DeviceRelease(device);
    rtInstance->SetChipType(chipOld);
    GlobalContainer::SetRtChipType(chipOld);
}


TEST_F(ChipDeviceTest, device_error_report_ringbuffer_01)
{
    uint16_t streamId;
    Device* device = ((Runtime *)Runtime::Instance())->DeviceRetain(0, 0);
    DeviceErrorProc *errorProc = new DeviceErrorProc(device);
    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    std::unique_ptr<char[]> hostAddr(new (std::nothrow) char[16]);
    rtChipType_t chipOld = rtInstance->GetChipType();
    rtInstance->SetChipType(CHIP_DC);
    GlobalContainer::SetRtChipType(CHIP_DC);

    rtError_t error = errorProc->ProcRingBufferTask(hostAddr.get(), false, 1);
    EXPECT_EQ(error, RT_ERROR_NONE);

    errorProc->deviceRingBufferAddr_ = hostAddr.get();
    EXPECT_NE(errorProc->deviceRingBufferAddr_, nullptr);
    DevRingBufferCtlInfo *tmpCtrlInfo = reinterpret_cast<DevRingBufferCtlInfo *>(errorProc->deviceRingBufferAddr_);
    tmpCtrlInfo->magic = RINGBUFFER_MAGIC;
    tmpCtrlInfo->head = 0;
    tmpCtrlInfo->tail = 1;

    MOCKER_CPP_VIRTUAL((NpuDriver*)(device->Driver_()),&NpuDriver::MemCopySync)
        .stubs()
        .will(returnValue(RT_ERROR_NONE));
    error = errorProc->ReportRingBuffer(&streamId);
    EXPECT_EQ(error, RT_ERROR_NONE);

    GlobalMockObject::verify();
    delete errorProc;
    ((Runtime *)Runtime::Instance())->DeviceRelease(device);
    rtInstance->SetChipType(chipOld);
    GlobalContainer::SetRtChipType(chipOld);
}

TEST_F(ChipDeviceTest, device_error_clean_ringbuffer_01)
{
    Device* device = ((Runtime *)Runtime::Instance())->DeviceRetain(0, 0);
    DeviceErrorProc *errorProc = new DeviceErrorProc(device);
    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    std::unique_ptr<char[]> hostAddr(new (std::nothrow) char[16]);
    rtChipType_t chipOld = rtInstance->GetChipType();
    rtInstance->SetChipType(CHIP_DC);
    GlobalContainer::SetRtChipType(CHIP_DC);

    rtError_t error = errorProc->ProcRingBufferTask(hostAddr.get(), false, 1);
    EXPECT_EQ(error, RT_ERROR_NONE);

    errorProc->deviceRingBufferAddr_ = hostAddr.get();
    EXPECT_NE(errorProc->deviceRingBufferAddr_, nullptr);
    DevRingBufferCtlInfo *tmpCtrlInfo = reinterpret_cast<DevRingBufferCtlInfo *>(errorProc->deviceRingBufferAddr_);
    tmpCtrlInfo->magic = RINGBUFFER_MAGIC;
    tmpCtrlInfo->head = 0;
    tmpCtrlInfo->tail = 1;

    MOCKER_CPP_VIRTUAL((NpuDriver*)(device->Driver_()),&NpuDriver::MemCopySync)
        .stubs()
        .will(returnValue(RT_ERROR_NONE));

    MOCKER_CPP(&DeviceErrorProc::CheckValid)
    .stubs()
    .will(returnValue(RT_ERROR_NONE));

    error = errorProc->ProcCleanRingbuffer();
    EXPECT_EQ(error, RT_ERROR_NONE);
    GlobalMockObject::verify();
    delete errorProc;
    ((Runtime *)Runtime::Instance())->DeviceRelease(device);
    rtInstance->SetChipType(chipOld);
    GlobalContainer::SetRtChipType(chipOld);
}

TEST_F(ChipDeviceTest, device_error_clean_ringbuffer_02)
{
    Device* device = ((Runtime *)Runtime::Instance())->DeviceRetain(0, 0);
    DeviceErrorProc *errorProc = new DeviceErrorProc(device);
    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    std::unique_ptr<char[]> hostAddr(new (std::nothrow) char[16]);
    rtChipType_t chipOld = rtInstance->GetChipType();
    rtInstance->SetChipType(CHIP_DC);
    GlobalContainer::SetRtChipType(CHIP_DC);

    rtError_t error = errorProc->ProcRingBufferTask(hostAddr.get(), false, 1);
    EXPECT_EQ(error, RT_ERROR_NONE);

    errorProc->deviceRingBufferAddr_ = hostAddr.get();
    EXPECT_NE(errorProc->deviceRingBufferAddr_, nullptr);
    DevRingBufferCtlInfo *tmpCtrlInfo = reinterpret_cast<DevRingBufferCtlInfo *>(errorProc->deviceRingBufferAddr_);
    tmpCtrlInfo->magic = RINGBUFFER_MAGIC;
    tmpCtrlInfo->head = 0;
    tmpCtrlInfo->tail = 1;
    tmpCtrlInfo->ringBufferLen = 0;
    
    MOCKER_CPP_VIRTUAL(device->Driver_(), &Driver::MemCopySync).stubs().will(invoke(MemCopySyncStub1));

    MOCKER_CPP(&DeviceErrorProc::CheckValid)
    .stubs()
    .will(returnValue(RT_ERROR_NONE));

    error = errorProc->ProcCleanRingbuffer();
    EXPECT_EQ(error, RT_ERROR_NONE);
    GlobalMockObject::verify();
    delete errorProc;
    ((Runtime *)Runtime::Instance())->DeviceRelease(device);
    rtInstance->SetChipType(chipOld);
    GlobalContainer::SetRtChipType(chipOld);
}

TEST_F(ChipDeviceTest, PrintSnapshotInfo)
{
    Device* device = ((Runtime *)Runtime::Instance())->DeviceRetain(0, 0);
    device->SetSnapshotFlag(false);
    DeviceErrorProc *errorProc = new DeviceErrorProc(device);
    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    rtChipType_t chipOld = rtInstance->GetChipType();
    rtInstance->SetChipType(CHIP_CLOUD);
    GlobalContainer::SetRtChipType(CHIP_CLOUD);
    MOCKER_CPP_VIRTUAL(device->Driver_(), &Driver::MemCopySync).stubs().will(invoke(MemCopySyncStub0));
    device->SetTschVersion(TS_VERSION_STREAM_TIMEOUT_SNAPSHOT);
    device->IsPrintStreamTimeoutSnapshot();
    device->GetSnapshotAddr();
    device->GetSnapshotLen();
    errorProc->GetSnapshotAddr();
    errorProc->GetSnapshotLen();
    device->SetSnapshotFlag(true);
    errorProc->ProduceProcNum();
    errorProc->ConsumeProcNum(0);
    rtInstance->SetChipType(CHIP_CLOUD);
    GlobalContainer::SetRtChipType(CHIP_CLOUD);

    Stream *stm = new Stream(device, 1);
    stm->streamId_ = 1;
    rtError_t error;
    device->GetTaskFactory()->Alloc(stm, TS_TASK_TYPE_EVENT_RECORD, error);
    device->SetSnapshotFlag(true);

    g_printType = 0;
    error = errorProc->PrintStreamTimeoutSnapshotInfo();
    EXPECT_EQ(error, RT_ERROR_NONE);
    g_printType = 3;
    error = errorProc->PrintStreamTimeoutSnapshotInfo();
    EXPECT_EQ(error, RT_ERROR_NONE);

    device->GetTaskFactory()->Alloc(stm, TS_TASK_TYPE_STREAM_WAIT_EVENT, error);
    device->SetSnapshotFlag(true);
    g_printType = 4;
    error = errorProc->PrintStreamTimeoutSnapshotInfo();
    EXPECT_EQ(error, RT_ERROR_NONE);

    device->GetTaskFactory()->Alloc(stm, TS_TASK_TYPE_NOTIFY_RECORD, error);
    device->SetSnapshotFlag(true);
    g_printType = 5;
    error = errorProc->PrintStreamTimeoutSnapshotInfo();
    EXPECT_EQ(error, RT_ERROR_NONE);

    device->GetTaskFactory()->Alloc(stm, TS_TASK_TYPE_NOTIFY_WAIT, error);
    device->SetSnapshotFlag(true);
    g_printType = 6;
    error = errorProc->PrintStreamTimeoutSnapshotInfo();
    EXPECT_EQ(error, RT_ERROR_NONE);

    device->GetTaskFactory()->Alloc(stm, TS_TASK_TYPE_KERNEL_AICORE, error);
    device->SetSnapshotFlag(true);
    g_printType = 7;
    error = errorProc->PrintStreamTimeoutSnapshotInfo();
    EXPECT_EQ(error, RT_ERROR_NONE);

    device->GetTaskFactory()->Alloc(stm, TS_TASK_TYPE_KERNEL_AICPU, error);
    device->SetSnapshotFlag(true);
    g_printType = 8;
    error = errorProc->PrintStreamTimeoutSnapshotInfo();
    EXPECT_EQ(error, RT_ERROR_NONE);

    device->GetTaskFactory()->Alloc(stm, TS_TASK_TYPE_MODEL_END_GRAPH, error);
    device->SetSnapshotFlag(true);
    g_printType = 9;
    error = errorProc->PrintStreamTimeoutSnapshotInfo();
    EXPECT_EQ(error, RT_ERROR_NONE);

    DELETE_A(errorProc->deviceRingBufferAddr_);
    delete errorProc;
    delete stm;
    ((Runtime *)Runtime::Instance())->DeviceRelease(device);
    rtInstance->SetChipType(chipOld);
    GlobalContainer::SetRtChipType(chipOld);
}

TEST_F(ChipDeviceTest, PrintStreamTimeoutSnapshotInfo_test)
{
    Device* device = ((Runtime *)Runtime::Instance())->DeviceRetain(0, 0);
    device->SetSnapshotFlag(false);
    DeviceErrorProc *errorProc = new DeviceErrorProc(device);
    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    rtChipType_t chipOld = rtInstance->GetChipType();
    rtInstance->SetChipType(CHIP_CLOUD);
    GlobalContainer::SetRtChipType(CHIP_CLOUD);
    MOCKER_CPP_VIRTUAL(device->Driver_(), &Driver::MemCopySync).stubs().will(invoke(MemCopySyncStub0));

    device->IsPrintStreamTimeoutSnapshot();
    device->GetSnapshotAddr();
    device->GetSnapshotLen();
    errorProc->GetSnapshotAddr();
    errorProc->GetSnapshotLen();
    device->SetSnapshotFlag(true);

    rtInstance->SetChipType(CHIP_DC);
    GlobalContainer::SetRtChipType(CHIP_DC);
    rtError_t error = errorProc->PrintStreamTimeoutSnapshotInfo();
    EXPECT_EQ(error, RT_ERROR_NONE);

    rtInstance->SetChipType(CHIP_CLOUD);
    GlobalContainer::SetRtChipType(CHIP_CLOUD);
    device->SetTschVersion(TS_VERSION_SET_STREAM_MODE);
    error = errorProc->PrintStreamTimeoutSnapshotInfo();
    EXPECT_EQ(error, RT_ERROR_NONE);


    device->SetTschVersion(TS_VERSION_STREAM_TIMEOUT_SNAPSHOT);
    error = errorProc->PrintStreamTimeoutSnapshotInfo();
    EXPECT_EQ(error, RT_ERROR_NONE);


    g_printType = 1;
    error = errorProc->PrintStreamTimeoutSnapshotInfo();
    EXPECT_EQ(error, RT_ERROR_NONE);

    Stream *stm = new Stream(device, 1);
    stm->streamId_ = 1;
    g_printType = 2;
    device->GetTaskFactory()->Alloc(stm, TS_TASK_TYPE_KERNEL_AICORE, error);
    device->SetSnapshotFlag(true);
    error = errorProc->PrintStreamTimeoutSnapshotInfo();
    EXPECT_EQ(error, RT_ERROR_NONE);

    device->GetTaskFactory()->Alloc(stm, TS_TASK_TYPE_EVENT_RECORD, error);
    device->SetSnapshotFlag(true);
    g_printType = 3;
    error = errorProc->PrintStreamTimeoutSnapshotInfo();
    EXPECT_EQ(error, RT_ERROR_NONE);

    device->GetTaskFactory()->Alloc(stm, TS_TASK_TYPE_STREAM_WAIT_EVENT, error);
    device->SetSnapshotFlag(true);
    g_printType = 4;
    error = errorProc->PrintStreamTimeoutSnapshotInfo();
    EXPECT_EQ(error, RT_ERROR_NONE);

    device->GetTaskFactory()->Alloc(stm, TS_TASK_TYPE_NOTIFY_RECORD, error);
    device->SetSnapshotFlag(true);
    g_printType = 5;
    error = errorProc->PrintStreamTimeoutSnapshotInfo();
    EXPECT_EQ(error, RT_ERROR_NONE);

    device->GetTaskFactory()->Alloc(stm, TS_TASK_TYPE_NOTIFY_WAIT, error);
    device->SetSnapshotFlag(true);
    g_printType = 6;
    error = errorProc->PrintStreamTimeoutSnapshotInfo();
    EXPECT_EQ(error, RT_ERROR_NONE);

    device->GetTaskFactory()->Alloc(stm, TS_TASK_TYPE_KERNEL_AICPU, error);
    device->SetSnapshotFlag(true);
    g_printType = 7;
    error = errorProc->PrintStreamTimeoutSnapshotInfo();
    EXPECT_EQ(error, RT_ERROR_NONE);

    std::unique_ptr<char[]> hostAddr(new (std::nothrow) char[16]);
    error = errorProc->ProcRingBufferTask(hostAddr.get(), false, 1);
    EXPECT_EQ(error, RT_ERROR_NONE);

    errorProc->deviceRingBufferAddr_ = hostAddr.get();
    EXPECT_NE(errorProc->deviceRingBufferAddr_, nullptr);

    device->GetTaskFactory()->Alloc(stm, TS_TASK_TYPE_KERNEL_AICPU, error);
    device->SetSnapshotFlag(true);
    g_printType = 7;
    error = errorProc->PrintStreamTimeoutSnapshotInfo();
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = errorProc->ProcCleanRingbuffer();
    delete errorProc;
    delete stm;
    ((Runtime *)Runtime::Instance())->DeviceRelease(device);
    rtInstance->SetChipType(chipOld);
    GlobalContainer::SetRtChipType(chipOld);
}

TEST_F(ChipDeviceTest, PrintStreamTimeoutSnapshotInfo_add)
{
    Device* device = ((Runtime *)Runtime::Instance())->DeviceRetain(0, 0);
    device->SetSnapshotFlag(false);
    DeviceErrorProc *errorProc = new DeviceErrorProc(device);
    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    rtChipType_t chipOld = rtInstance->GetChipType();
    rtInstance->SetChipType(CHIP_CLOUD);
    GlobalContainer::SetRtChipType(CHIP_CLOUD);
    MOCKER_CPP_VIRTUAL(device->Driver_(), &Driver::MemCopySync).stubs().will(invoke(MemCopySyncStub0));

    device->GetSnapshotAddr();
    device->GetSnapshotLen();
    errorProc->GetSnapshotAddr();
    errorProc->GetSnapshotLen();
    device->SetSnapshotFlag(true);
    MOCKER_CPP(&DeviceErrorProc::IsPrintStreamTimeoutSnapshot).stubs().will(returnValue(true));
    g_printType = 0;
    rtError_t error = errorProc->PrintStreamTimeoutSnapshotInfo();
    EXPECT_EQ(error, RT_ERROR_NONE);

    Stream *stm = new Stream(device, 1);
    stm->streamId_ = 1;
    g_printType = 2;
    device->GetTaskFactory()->Alloc(stm, TS_TASK_TYPE_KERNEL_AICORE, error);
    device->SetSnapshotFlag(true);
    error = errorProc->PrintStreamTimeoutSnapshotInfo();
    EXPECT_EQ(error, RT_ERROR_NONE);

    device->GetTaskFactory()->Alloc(stm, TS_TASK_TYPE_EVENT_RECORD, error);
    device->SetSnapshotFlag(true);
    g_printType = 3;
    error = errorProc->PrintStreamTimeoutSnapshotInfo();
    EXPECT_EQ(error, RT_ERROR_NONE);

    device->GetTaskFactory()->Alloc(stm, TS_TASK_TYPE_STREAM_WAIT_EVENT, error);
    device->SetSnapshotFlag(true);
    g_printType = 4;
    error = errorProc->PrintStreamTimeoutSnapshotInfo();
    EXPECT_EQ(error, RT_ERROR_NONE);

    rtInstance->SetChipType(CHIP_DAVID);
    GlobalContainer::SetRtChipType(CHIP_DAVID);

    device->GetTaskFactory()->Alloc(stm, TS_TASK_TYPE_STREAM_WAIT_EVENT, error);
    device->SetSnapshotFlag(true);
    g_printType = 4;
    error = errorProc->PrintStreamTimeoutSnapshotInfo();
    EXPECT_EQ(error, RT_ERROR_NONE);

    rtInstance->SetChipType(CHIP_CLOUD);
    GlobalContainer::SetRtChipType(CHIP_CLOUD);

    device->GetTaskFactory()->Alloc(stm, TS_TASK_TYPE_NOTIFY_RECORD, error);
    device->SetSnapshotFlag(true);
    g_printType = 5;
    error = errorProc->PrintStreamTimeoutSnapshotInfo();
    EXPECT_EQ(error, RT_ERROR_NONE);

    device->GetTaskFactory()->Alloc(stm, TS_TASK_TYPE_NOTIFY_WAIT, error);
    device->SetSnapshotFlag(true);
    g_printType = 6;
    error = errorProc->PrintStreamTimeoutSnapshotInfo();
    EXPECT_EQ(error, RT_ERROR_NONE);

    device->GetTaskFactory()->Alloc(stm, TS_TASK_TYPE_KERNEL_AICPU, error);
    device->SetSnapshotFlag(true);
    g_printType = 7;
    error = errorProc->PrintStreamTimeoutSnapshotInfo();
    EXPECT_EQ(error, RT_ERROR_NONE);

    DELETE_A(errorProc->deviceRingBufferAddr_);
    delete errorProc;
    delete stm;
    ((Runtime *)Runtime::Instance())->DeviceRelease(device);
    rtInstance->SetChipType(chipOld);
    GlobalContainer::SetRtChipType(chipOld);
}

TEST_F(ChipDeviceTest, get_davidDieNum_failed)
{
    rtError_t error;
    int32_t devId = 1;
    RawDevice *device = new RawDevice(1);
    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    rtChipType_t chipOld = rtInstance->GetChipType();
    rtInstance->SetChipType(CHIP_DAVID);
    GlobalContainer::SetRtChipType(CHIP_DAVID);

    Driver *driver = ((Runtime *)Runtime::Instance())->driverFactory_.GetDriver(NPU_DRIVER);
    MOCKER_CPP_VIRTUAL(driver,
            &Driver::GetDevInfo).stubs().with(mockcpp::any(), mockcpp::any(), mockcpp::any(), mockcpp::any())
            .will(returnValue(RT_ERROR_DRV_INPUT));
    MOCKER(halGetSocVersion).stubs().with(mockcpp::any(), mockcpp::any(), mockcpp::any()).will(returnValue(DRV_ERROR_NOT_SUPPORT));
    MOCKER(halGetDeviceInfo).stubs().with(mockcpp::any(), mockcpp::any(), mockcpp::any(), mockcpp::any()).will(returnValue(DRV_ERROR_INVALID_VALUE));

    error = device->Init();
    EXPECT_EQ(error, RT_ERROR_DRV_INPUT);
    rtInstance->SetChipType(chipOld);
    GlobalContainer::SetRtChipType(chipOld);
    delete(device);
}

TEST_F(ChipDeviceTest, AS31XM1X_SPM_TEST)
{
    rtError_t error;
    RawDevice *dev = new RawDevice(1);
    error = GET_CHIP_FEATURE_SET(CHIP_AS31XM1, dev->featureSet_);
    EXPECT_EQ(error, RT_ERROR_NONE);
    bool isSPM = dev->IsSPM(nullptr);
    EXPECT_EQ(isSPM, false);
    error = dev->FreeSPM(nullptr);
    EXPECT_EQ(error, RT_ERROR_NONE);
    delete dev;
}