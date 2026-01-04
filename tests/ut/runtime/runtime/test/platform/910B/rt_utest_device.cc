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
#include "platform/platform_info.h"

using namespace testing;
using namespace cce::runtime;

namespace cce {
namespace runtime {
    void ConvertErrorCodeForFastReport(StarsOpExceptionInfo *report);
}
}

class CloudV2DeviceTest : public testing::Test
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
        rtDeviceReset(0);
        std::cout << "a test TearDown" << std::endl;
        Runtime *rtInstance = const_cast<Runtime *>(Runtime::Instance());
        EXPECT_NE(rtInstance, nullptr);
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

private:
    rtChipType_t originType;
};

uint32_t CloudV2DeviceTest::g_case_num = 0;
uint32_t CloudV2DeviceTest::g_streamId = 0;
uint16_t CloudV2DeviceTest::g_sId = 0;
uint16_t CloudV2DeviceTest::g_tId = 0;
uint32_t CloudV2DeviceTest::g_printType = 0;

TEST_F(CloudV2DeviceTest, STARS_FFTSPLUS_ERROR_PROC)
{
    Device* device = ((Runtime *)Runtime::Instance())->DeviceRetain(0, 0);
    DeviceErrorProc *errorProc = new DeviceErrorProc(device);
    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    bool oldDisableThread = rtInstance->GetDisableThread();
    MOCKER_CPP(&Stream::StarsWaitForTask).stubs().will(returnValue(RT_ERROR_NONE));
    Runtime::Instance()->SetDisableThread(true);
    Stream *stm = new Stream(device, 1);
    stm->streamId_ = 1;
    rtError_t errCode = RT_ERROR_NONE;
    TaskInfo * const tsk = device->GetTaskFactory()->Alloc(stm, TS_TASK_TYPE_FFTS_PLUS, errCode);
    device->GetTaskFactory()->SetSerialId(stm, tsk);
    tsk->u.fftsPlusTask.errInfo = new std::vector<rtFftsPlusTaskErrInfo_t>();
    DevRingBufferCtlInfo *ctlInfo  = (DevRingBufferCtlInfo *)malloc(DEVICE_ERROR_EXT_RINGBUFFER_SIZE);
    memset_s(ctlInfo, DEVICE_ERROR_EXT_RINGBUFFER_SIZE, 0, DEVICE_ERROR_EXT_RINGBUFFER_SIZE);
        if (ctlInfo != nullptr) {
        ctlInfo->tail = 1;
        ctlInfo->head = 0;
        ctlInfo->magic = RINGBUFFER_MAGIC;
        ctlInfo->ringBufferLen  = RINGBUFFER_LEN;
        uint64_t oneElementLen = sizeof(StarsDeviceErrorInfo) + sizeof(RingBufferElementInfo);
        uintptr_t infoAddr = reinterpret_cast<uintptr_t>(ctlInfo) +
                             sizeof(DevRingBufferCtlInfo) +
                             ctlInfo->head * oneElementLen;
        RingBufferElementInfo *info = (RingBufferElementInfo *)infoAddr;
        StarsDeviceErrorInfo *errorInfo = reinterpret_cast<StarsDeviceErrorInfo *>(info + 1);
        info->errorType = FFTS_PLUS_AICORE_ERROR;
        errorInfo->u.coreErrorInfo.comm.type = FFTS_PLUS_AICORE_ERROR;
        errorInfo->u.coreErrorInfo.comm.coreNum = 1;
        errorInfo->u.coreErrorInfo.comm.streamId = stm->streamId_;
        errorInfo->u.coreErrorInfo.comm.taskId = tsk->id;
        errorInfo->u.coreErrorInfo.info[0].coreId = 1;
        errorInfo->u.coreErrorInfo.info[0].fsmCxtId = 0x6;
        errorInfo->u.coreErrorInfo.info[0].fsmThreadId = 0x6;
        rtError_t error = errorProc->ProcessStarsOneElementInRingBuffer(ctlInfo, 0, 1);
        info->errorType = FFTS_PLUS_SDMA_ERROR;
        errorInfo->u.sdmaErrorInfo.comm.type = FFTS_PLUS_SDMA_ERROR;
        errorInfo->u.sdmaErrorInfo.comm.coreNum = 1;
        errorInfo->u.sdmaErrorInfo.comm.streamId = stm->streamId_;
        errorInfo->u.sdmaErrorInfo.comm.taskId = tsk->id;
        errorInfo->u.sdmaErrorInfo.sdma.fftsPlusInfo[0].sdmaChannelId = 1;
        errorInfo->u.sdmaErrorInfo.sdma.fftsPlusInfo[0].sdmaCxtid = 0x6;
        errorInfo->u.sdmaErrorInfo.sdma.fftsPlusInfo[0].sdmaThreadid = 0x6;
        error = errorProc->ProcessStarsOneElementInRingBuffer(ctlInfo, 0, 1);
        EXPECT_EQ(error, RT_ERROR_NONE);
        info->errorType = FFTS_PLUS_AICPU_ERROR;
        errorInfo->u.aicpuErrorInfo.comm.type = FFTS_PLUS_AICPU_ERROR;
        errorInfo->u.aicpuErrorInfo.comm.coreNum = 1;
        errorInfo->u.aicpuErrorInfo.comm.streamId = stm->streamId_;
        errorInfo->u.aicpuErrorInfo.comm.taskId = tsk->id;;
        errorInfo->u.aicpuErrorInfo.aicpu.info[0].aicpuCxtid = 0x6;
        errorInfo->u.aicpuErrorInfo.aicpu.info[0].aicpuThreadid = 0x6;
        error = errorProc->ProcessStarsOneElementInRingBuffer(ctlInfo, 0, 1);
        info->errorType = AICORE_ERROR;
        errorInfo->u.coreErrorInfo.comm.flag = 1U;
        error = errorProc->ProcessStarsOneElementInRingBuffer(ctlInfo, 0, 1);
        free(ctlInfo);
        ctlInfo = nullptr;
    }

    (void)device->GetTaskFactory()->Recycle(tsk);
    delete stm;
    delete errorProc;
    ((Runtime *)Runtime::Instance())->DeviceRelease(device);
    Runtime::Instance()->SetDisableThread(oldDisableThread);
}

TEST_F(CloudV2DeviceTest, PrintStreamTimeoutSnapshotInfo_test)
{
    Device* device = ((Runtime *)Runtime::Instance())->DeviceRetain(0, 0);
    device->SetSnapshotFlag(false);
    DeviceErrorProc *errorProc = new DeviceErrorProc(device);
    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    rtChipType_t chipOld = rtInstance->GetChipType();
    MOCKER_CPP_VIRTUAL(device->Driver_(), &Driver::MemCopySync).stubs().will(invoke(MemCopySyncStub0));

    device->IsPrintStreamTimeoutSnapshot();
    device->GetSnapshotAddr();
    device->GetSnapshotLen();
    errorProc->GetSnapshotAddr();
    errorProc->GetSnapshotLen();
    device->SetSnapshotFlag(true);

    rtError_t error = errorProc->PrintStreamTimeoutSnapshotInfo();
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
    errorProc->deviceRingBufferAddr_ = nullptr;
    delete errorProc;
    delete stm;
    MOCKER_CPP(&Stream::StarsWaitForTask).stubs().will(returnValue(RT_ERROR_NONE));
    ((Runtime *)Runtime::Instance())->DeviceRelease(device);
}

TEST_F(CloudV2DeviceTest, device_reportRingbuffer_02)
{
    Device* device = ((Runtime *)Runtime::Instance())->DeviceRetain(0, 0);
    DeviceErrorProc *errorProc = new DeviceErrorProc(device);
    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    std::unique_ptr<char[]> hostAddr(new (std::nothrow)  char[16]);
    uint16_t streamId;
    rtError_t error = errorProc->ProcRingBufferTask(hostAddr.get(), false, 1);
    EXPECT_EQ(error, RT_ERROR_NONE);

    errorProc->deviceRingBufferAddr_ = hostAddr.get();

    MOCKER_CPP_VIRTUAL(device->Driver_(), &Driver::MemCopySync).stubs().will(invoke(MemCopySyncForRingBuffer));
    MOCKER_CPP(&DeviceErrorProc::CheckValid).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP(&Stream::StarsWaitForTask).stubs().will(returnValue(RT_ERROR_NONE));
    error = errorProc->ReportRingBuffer(&streamId);
    EXPECT_EQ(error, RT_ERROR_DRV_INPUT);
    g_case_num = FFTS_PLUS_AICORE_ERROR;
    error = errorProc->ReportRingBuffer(&streamId);
    EXPECT_EQ(error, RT_ERROR_TASK_MONITOR);
    errorProc->deviceRingBufferAddr_ = nullptr;
    GlobalMockObject::verify();
    delete errorProc;
    ((Runtime *)Runtime::Instance())->DeviceRelease(device);
}

TEST_F(CloudV2DeviceTest, device_reportRingbuffer_03)
{
    rtModel_t  model;
    rtStream_t stream;
    rtError_t error;
    uint16_t streamId;
    Device* device = ((Runtime *)Runtime::Instance())->DeviceRetain(0, 0);
    DeviceErrorProc *errorProc = new DeviceErrorProc(device);
    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    std::unique_ptr<char[]> hostAddr(new (std::nothrow)  char[16]);

    error = rtStreamCreate(&stream, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);
    g_streamId = ((Stream *)stream)->Id_();

    std::shared_ptr<Stream> stm = nullptr;
    device->GetStreamSqCqManage()->SetStreamIdToStream(static_cast<const uint32_t>(g_streamId), (Stream *)stream);
    error = device->GetStreamSqCqManage()->GetStreamSharedPtrById(static_cast<const uint32_t>(g_streamId), stm);
    EXPECT_EQ(error, RT_ERROR_NONE);
    EXPECT_NE(stm, nullptr);

    error = errorProc->ProcRingBufferTask(hostAddr.get(), false, 1);
    EXPECT_EQ(error, RT_ERROR_NONE);

    errorProc->deviceRingBufferAddr_ = hostAddr.get();

    MOCKER_CPP_VIRTUAL(device->Driver_(), &Driver::MemCopySync).stubs().will(invoke(MemCopySyncForRingBuffer));
    MOCKER_CPP(&DeviceErrorProc::CheckValid).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP(&Stream::StarsWaitForTask).stubs().will(returnValue(RT_ERROR_NONE));
    g_case_num = FFTS_PLUS_AIVECTOR_ERROR;
    error = errorProc->ReportRingBuffer(&streamId);
    EXPECT_EQ(error, RT_ERROR_TASK_MONITOR);
    EXPECT_EQ(streamId, g_streamId);

    g_case_num = FFTS_PLUS_SDMA_ERROR;
    error = errorProc->ReportRingBuffer(&streamId);
    EXPECT_EQ(error, RT_ERROR_TASK_MONITOR);
    EXPECT_EQ(streamId, g_streamId);

    g_case_num = FFTS_PLUS_AICPU_ERROR;
    error = errorProc->ReportRingBuffer(&streamId);
    EXPECT_EQ(error, RT_ERROR_TASK_MONITOR);
    EXPECT_EQ(streamId, g_streamId);

    g_case_num = DVPP_ERROR;
    error = errorProc->ReportRingBuffer(&streamId);
    EXPECT_EQ(error, RT_ERROR_TASK_MONITOR);
    EXPECT_EQ(streamId, g_streamId);

    g_case_num = SQE_ERROR;
    error = errorProc->ReportRingBuffer(&streamId);
    EXPECT_EQ(error, RT_ERROR_TASK_MONITOR);
    EXPECT_EQ(streamId, g_streamId);

    g_case_num = FFTS_PLUS_DSA_ERROR;
    error = errorProc->ReportRingBuffer(&streamId);
    EXPECT_EQ(error, RT_ERROR_TASK_MONITOR);
    EXPECT_EQ(streamId, g_streamId);

    g_case_num = WAIT_TIMEOUT_ERROR;
    error = errorProc->ReportRingBuffer(&streamId);
    EXPECT_EQ(error, RT_ERROR_TASK_MONITOR);
    EXPECT_EQ(streamId, g_streamId);

    g_case_num = HCCL_FFTSPLUS_TIMEOUT_ERROR;
    error = errorProc->ReportRingBuffer(&streamId);
    EXPECT_EQ(error, RT_ERROR_TASK_MONITOR);
    EXPECT_EQ(streamId, g_streamId);

    g_case_num = FUSION_KERNEL_ERROR;
    error = errorProc->ReportRingBuffer(&streamId);
    EXPECT_EQ(error, RT_ERROR_TASK_MONITOR);
    EXPECT_EQ(streamId, g_streamId);

    g_case_num = CCU_ERROR;
    error = errorProc->ReportRingBuffer(&streamId);
    EXPECT_EQ(error, RT_ERROR_TASK_MONITOR);
    EXPECT_EQ(streamId, g_streamId);

    g_case_num = 200U;
    error = errorProc->ReportRingBuffer(&streamId);
    EXPECT_EQ(error, RT_ERROR_TASK_MONITOR);

    error = rtStreamDestroy(stream);
    EXPECT_EQ(error, RT_ERROR_NONE);
    errorProc->deviceRingBufferAddr_ = nullptr;
    GlobalMockObject::verify();
    delete errorProc;
    ((Runtime *)Runtime::Instance())->DeviceRelease(device);
}

TEST_F(CloudV2DeviceTest, device_reportRingbuffer_04)
{
    Device* device = ((Runtime *)Runtime::Instance())->DeviceRetain(0, 0);
    DeviceErrorProc *errorProc = new DeviceErrorProc(device);
    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    std::unique_ptr<char[]> hostAddr(new (std::nothrow)  char[16]);
    uint16_t streamId;
    rtError_t error = errorProc->ProcRingBufferTask(hostAddr.get(), false, 1);
    EXPECT_EQ(error, RT_ERROR_NONE);

    errorProc->deviceRingBufferAddr_ = hostAddr.get();

    MOCKER_CPP_VIRTUAL(device->Driver_(), &Driver::MemCopySync).stubs().will(invoke(MemCopySyncForRingBuffer));
    MOCKER_CPP(&DeviceErrorProc::CheckValid).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP(&Stream::StarsWaitForTask).stubs().will(returnValue(RT_ERROR_NONE));
    g_case_num = 100U;
    error = errorProc->ReportRingBuffer(&streamId);
    EXPECT_EQ(error, RT_ERROR_NONE);
    errorProc->deviceRingBufferAddr_ = nullptr;
    GlobalMockObject::verify();
    delete errorProc;
    ((Runtime *)Runtime::Instance())->DeviceRelease(device);
}

TEST_F(CloudV2DeviceTest, device_error_fast_ringbuffer)
{
    Device* device = ((Runtime *)Runtime::Instance())->DeviceRetain(0, 0);
    DeviceErrorProc *errorProc = new DeviceErrorProc(device);
    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    std::unique_ptr<char[]> hostAddr(new (std::nothrow)  char[100]);
    memset_s(hostAddr.get(), 100, 0, 100);

    MOCKER_CPP_VIRTUAL(device, &Device::CheckFeatureSupport)
        .stubs().will(returnValue(true));
    MOCKER_CPP_VIRTUAL(device->Driver_(), &Driver::AllocFastRingBufferAndDispatch)
        .stubs().will(returnValue(RT_ERROR_NONE));
    rtError_t error = errorProc->CreateFastRingbuffer();
    EXPECT_EQ(error, RT_ERROR_NONE);
    errorProc->fastRingBufferAddr_ = hostAddr.get();
    DevRingBufferCtlInfo *ctrlInfo = RtPtrToPtr<DevRingBufferCtlInfo *>(errorProc->fastRingBufferAddr_);
    ctrlInfo->magic = 0; // no exception
    errorProc->ProcessReportFastRingBuffer();

    Stream *stm = new Stream(device, 1);
    TaskInfo fftsPlusTask = {};
    fftsPlusTask.stream = stm;
    MOCKER_CPP(&TaskFactory::GetTask)
        .stubs().with(mockcpp::any(), mockcpp::any()).will(returnValue(&fftsPlusTask));
    ctrlInfo->magic = RINGBUFFER_MAGIC; // have exception
    errorProc->ProcessReportFastRingBuffer();

    RawDevice *rewDevice = (RawDevice *)device;
    rewDevice->deviceErrorProc_ = errorProc;
    errorProc->fastRingBufferAddr_ = nullptr;
    device->ProcClearFastRingBuffer();
    errorProc->fastRingBufferAddr_ = hostAddr.get();
    device->ProcClearFastRingBuffer();
    Runtime::Instance()->timeoutConfig_.isInit = false;
    Runtime::Instance()->timeoutConfig_.interval = RT_STARS_TASK_KERNEL_CREDIT_SCALE_US;

    rewDevice->deviceErrorProc_ = nullptr;
    rewDevice->ProcessReportFastRingBuffer();
    delete stm;
    GlobalMockObject::verify();
    errorProc->fastRingBufferAddr_ = nullptr;
    delete errorProc;
    ((Runtime *)Runtime::Instance())->DeviceRelease(device);
}

TEST_F(CloudV2DeviceTest, ConvertErrorCodeForFastReport_1)
{
    StarsOpExceptionInfo report = {};
    report.sqeType = RT_STARS_SQE_TYPE_FFTS;
    report.errorCode = TS_ERROR_TASK_EXCEPTION;
    ConvertErrorCodeForFastReport(&report);
    EXPECT_EQ(report.errorCode, TS_ERROR_AICORE_EXCEPTION);
    report.errorCode = TS_ERROR_TASK_TIMEOUT;
    ConvertErrorCodeForFastReport(&report);
    EXPECT_EQ(report.errorCode, TS_ERROR_AICORE_TIMEOUT);
    report.errorCode = TS_ERROR_TASK_TRAP;
    ConvertErrorCodeForFastReport(&report);
    EXPECT_EQ(report.errorCode, TS_ERROR_AICORE_TRAP_EXCEPTION);

    report.sqeType = RT_STARS_SQE_TYPE_AICPU;
    report.errorCode = TS_ERROR_TASK_EXCEPTION;
    ConvertErrorCodeForFastReport(&report);
    EXPECT_EQ(report.errorCode, TS_ERROR_AICPU_EXCEPTION);
    report.errorCode = TS_ERROR_TASK_TIMEOUT;
    ConvertErrorCodeForFastReport(&report);
    EXPECT_EQ(report.errorCode, TS_ERROR_AICPU_TIMEOUT);
    report.errorCode = TS_ERROR_TASK_TRAP;
    ConvertErrorCodeForFastReport(&report);
    EXPECT_EQ(report.errorCode, TS_ERROR_TASK_TRAP);

    report.sqeType = RT_STARS_SQE_TYPE_SDMA;
    report.errorCode = TS_ERROR_TASK_EXCEPTION;
    ConvertErrorCodeForFastReport(&report);
    EXPECT_EQ(report.errorCode, TS_ERROR_SDMA_ERROR);
    report.errorCode = TS_ERROR_TASK_TIMEOUT;
    ConvertErrorCodeForFastReport(&report);
    EXPECT_EQ(report.errorCode, TS_ERROR_SDMA_TIMEOUT);
    report.errorCode = TS_ERROR_TASK_TRAP;
    ConvertErrorCodeForFastReport(&report);
    EXPECT_EQ(report.errorCode, TS_ERROR_TASK_TRAP);

    report.sqeType = 63;
    report.errorCode = TS_ERROR_TASK_EXCEPTION;
    ConvertErrorCodeForFastReport(&report);
    EXPECT_EQ(report.errorCode, TS_ERROR_TASK_EXCEPTION);
}

TEST_F(CloudV2DeviceTest, module_alloc)
{
    rtError_t error;
    Program *program;
    rtDevBinary_t bin;
    Module * module1;
    Module * module2;

    Runtime *rt = ((Runtime *)Runtime::Instance());

    MOCKER(drvMemAllocL2buffAddr).stubs().will(returnValue(DRV_ERROR_INVALID_VALUE));

    bin.magic = RT_DEV_BINARY_MAGIC_PLAIN;
    bin.version = 1;
    bin.data = &bin;
    bin.length = sizeof(bin);
    error = rt->ProgramRegister(&bin, &program);
    EXPECT_EQ(error, RT_ERROR_NONE);

    RawDevice *dev = new RawDevice(1);
    dev->Init();

    MOCKER(memcpy_s).stubs().will(returnValue(NULL));

    module1 = dev->ModuleAlloc(program);
    EXPECT_NE(module1, (Module*)NULL);

    module2 = dev->ModuleAlloc(program);
    EXPECT_EQ(module2, module1);

    dev->ModuleRelease(module1);
    dev->ModuleRelease(module2);

    delete dev;

    rt->PutProgram(program);
}

TEST_F(CloudV2DeviceTest, module_alloc_02)
{
    rtError_t error;
    Program *program;
    rtDevBinary_t bin;
    Module * module1;
    Module * module2;

    Runtime *rt = ((Runtime *)Runtime::Instance());

    MOCKER(drvMemAllocL2buffAddr).stubs().will(returnValue(DRV_ERROR_INVALID_VALUE));

    bin.magic = RT_DEV_BINARY_MAGIC_PLAIN;
    bin.version = 1;
    bin.data = &bin;
    bin.length = sizeof(bin);
    error = rt->ProgramRegister(&bin, &program);
    EXPECT_EQ(error, RT_ERROR_NONE);

    RawDevice *dev = new RawDevice(1);
    dev->Init();

    MOCKER(memcpy_s).stubs().will(returnValue(NULL));

    const char * kernelName = "test";
    (void)program->AppendKernelName(kernelName);

    program->machine_ = Program::MACH_AI_CPU;
    module1 = dev->ModuleAlloc(program);
    EXPECT_NE(module1, (Module*)NULL);
    uint32_t cnt = 0U;
    Kernel *kernel = (Kernel *)malloc(sizeof(Kernel));
    module1->GetPrefetchCnt(kernel, cnt);

    module2 = dev->ModuleAlloc(program);
    EXPECT_EQ(module2, module1);

    dev->ModuleRelease(module1);
    dev->ModuleRelease(module2);

    free(kernel);
    delete dev;

    rt->PutProgram(program);
}

TEST_F(CloudV2DeviceTest, module_alloc_02_test_001)
{
    rtError_t error;
    Program *program;
    rtDevBinary_t bin;
    Module * module1;

    Runtime *rt = ((Runtime *)Runtime::Instance());

    MOCKER(drvMemAllocL2buffAddr).stubs().will(returnValue(DRV_ERROR_INVALID_VALUE));

    bin.magic = RT_DEV_BINARY_MAGIC_PLAIN;
    bin.version = 1;
    bin.data = &bin;
    bin.length = sizeof(bin);
    error = rt->ProgramRegister(&bin, &program);
    EXPECT_EQ(error, RT_ERROR_NONE);

    RawDevice *dev = new RawDevice(1);
    dev->Init();

    MOCKER(memcpy_s).stubs().will(returnValue(NULL));

    const char * kernelName = "test";
    (void)program->AppendKernelName(kernelName);

    program->machine_ = Program::MACH_AI_CPU;
    module1 = dev->ModuleAlloc(program);
    EXPECT_NE(module1, (Module*)NULL);

    uint32_t cnt = 0U;
    uint32_t cnt1 = 0U;
    uint32_t cnt2 = 0U;
    Kernel *kernel = (Kernel *)malloc(sizeof(Kernel));

    module1->GetProgram()->SetMachine(Program::MACH_AI_MIX_KERNEL);
    module1->GetPrefetchCnt(kernel, cnt);

    rtError_t errNum = RT_ERROR_NONE;
    kernel->SetMixType(NO_MIX);
    module1->GetProgram()->SetMachine(Program::MACH_INVALID_CPU);
    errNum = module1->GetPrefetchCnt(kernel, cnt1, cnt2);
    EXPECT_EQ(errNum, RT_ERROR_INVALID_VALUE);
    EXPECT_EQ(cnt1, 0);
    EXPECT_EQ(cnt2, 0);
    module1->GetProgram()->SetMachine(Program::MACH_AI_CPU);
    module1->GetPrefetchCnt(kernel, cnt1, cnt2);
    EXPECT_EQ(cnt1, 0);
    EXPECT_EQ(cnt2, 0);
    module1->GetProgram()->SetMachine(Program::MACH_AI_CVMIX);
    module1->GetPrefetchCnt(kernel, cnt);
    module1->GetProgram()->SetMachine(Program::MACH_AI_VECTOR);
    module1->GetPrefetchCnt(kernel, cnt);
    module1->GetProgram()->SetMachine(Program::MACH_AI_CPU);

    uint64_t x = 0x11;
    uint64_t y = 0x22;
    uint64_t a = 0x33;
    uint64_t b = 0x44;
    kernel->SetOffset2(a);
    module1->GetFunction(kernel, &x, &y);

    dev->ModuleRelease(module1);

    free(kernel);
    delete dev;

    rt->PutProgram(program);
}

TEST_F(CloudV2DeviceTest, module_alloc_03)
{
    rtError_t error;
    Program *program;
    rtDevBinary_t bin;
    Module * module1;
    Runtime *rt = ((Runtime *)Runtime::Instance());
    MOCKER(drvMemAllocL2buffAddr).stubs().will(returnValue(DRV_ERROR_INVALID_VALUE));

    bin.magic = RT_DEV_BINARY_MAGIC_PLAIN;
    bin.version = 1;
    bin.data = &bin;
    bin.length = sizeof(bin);
    error = rt->ProgramRegister(&bin, &program);
    EXPECT_EQ(error, RT_ERROR_NONE);
    program->SetProgMemType(Program::PROGRAM_MEM_FAST);

    RawDevice *dev = new RawDevice(1);
    dev->Init();
    dev->platformConfig_ = 0x00;
    dev->l2buffer_ = &bin;

    NpuDriver drv;
    dev->driver_ = &drv;
    MOCKER_CPP_VIRTUAL(&drv, &NpuDriver::LoadProgram)
        .stubs()
        .will(returnValue(RT_ERROR_NONE));


    MOCKER(memcpy_s).stubs().will(returnValue(NULL));

    const char * kernelName = "test";
    (void)program->AppendKernelName(kernelName);

    program->machine_ = Program::MACH_AI_VECTOR;
    module1 = dev->ModuleAlloc(program);
    EXPECT_NE(module1, (Module*)NULL);
    program->SetProgMemType(Program::PROGRAM_MEM_FAST);

    dev->ModuleRelease(module1);

    delete dev;

    rt->PutProgram(program);
}

TEST_F(CloudV2DeviceTest, module_alloc_04)
{
    rtError_t error;
    Program *program;
    rtDevBinary_t bin;
    Module *module1;
    Module *module2;

    Runtime *rt = ((Runtime *)Runtime::Instance());

    MOCKER(drvMemAllocL2buffAddr).stubs().will(returnValue(DRV_ERROR_INVALID_VALUE));

    bin.magic = RT_DEV_BINARY_MAGIC_PLAIN;
    bin.version = 1;
    bin.data = &bin;
    bin.length = sizeof(bin);
    error = rt->ProgramRegister(&bin, &program);
    EXPECT_EQ(error, RT_ERROR_NONE);

    RawDevice *dev = new RawDevice(1);
    dev->Init();

    MOCKER(memcpy_s).stubs().will(returnValue(NULL));

    const char *kernelName = "test";
    (void)program->AppendKernelName(kernelName);

    program->machine_ = Program::MACH_AI_CPU;
    module1 = dev->ModuleAlloc(program);
    EXPECT_NE(module1, (Module*)NULL);
    uint32_t cnt1 = 0U;
    uint32_t cnt2 = 0U;
    Kernel *kernel = (Kernel *)malloc(sizeof(Kernel));
    kernel->SetMixType(MIX_AIC);
    module1->GetPrefetchCnt(kernel, cnt1, cnt2);
    kernel->SetMixType(MIX_AIV);
    module1->GetPrefetchCnt(kernel, cnt1, cnt2);
    kernel->SetMixType(MIX_AIC_AIV_MAIN_AIC);
    module1->GetPrefetchCnt(kernel, cnt1, cnt2);
    kernel->SetMixType(NO_MIX);

    module2 = dev->ModuleAlloc(program);
    EXPECT_EQ(module2, module1);

    dev->ModuleRelease(module1);
    dev->ModuleRelease(module2);

    free(kernel);
    delete dev;

    rt->PutProgram(program);
}

TEST_F(CloudV2DeviceTest, module_alloc_05)
{
    rtError_t error;
    Program *program;
    rtDevBinary_t bin;
    Module *module1;
    Module *module2;

    Runtime *rt = ((Runtime *)Runtime::Instance());

    MOCKER(drvMemAllocL2buffAddr).stubs().will(returnValue(DRV_ERROR_INVALID_VALUE));

    bin.magic = RT_DEV_BINARY_MAGIC_PLAIN_AIVEC;
    bin.version = 1;
    bin.data = &bin;
    bin.length = sizeof(bin);
    error = rt->ProgramRegister(&bin, &program);
    EXPECT_EQ(error, RT_ERROR_NONE);

    RawDevice *dev = new RawDevice(1);
    dev->Init();

    MOCKER(memcpy_s).stubs().will(returnValue(NULL));

    const char *kernelName = "test";
    (void)program->AppendKernelName(kernelName);

    program->machine_ = Program::MACH_AI_VECTOR;
    module1 = dev->ModuleAlloc(program);
    EXPECT_NE(module1, (Module*)NULL);
    uint32_t cnt1 = 0U;
    uint32_t cnt2 = 0U;
    Kernel *kernel = (Kernel *)malloc(sizeof(Kernel));
    module1->GetPrefetchCnt(kernel, cnt1, cnt2);

    module2 = dev->ModuleAlloc(program);
    EXPECT_EQ(module2, module1);

    dev->ModuleRelease(module1);
    dev->ModuleRelease(module2);

    free(kernel);
    delete dev;

    rt->PutProgram(program);
}

TEST_F(CloudV2DeviceTest, module_alloc_load_fail_in_rawdev)
{
    rtError_t error;
    Program *program;
    rtDevBinary_t bin;
    Module * module1;

    Runtime *rt = ((Runtime *)Runtime::Instance());

    MOCKER(drvMemAllocL2buffAddr).stubs().will(returnValue(DRV_ERROR_INVALID_VALUE));
    MOCKER_CPP(&Module::Load)
        .stubs()
        .will(returnValue(RT_ERROR_INVALID_VALUE));

    bin.magic = RT_DEV_BINARY_MAGIC_PLAIN;
    bin.version = 1;
    bin.data = &bin;
    bin.length = sizeof(bin);
    error = rt->ProgramRegister(&bin, &program);
    EXPECT_EQ(error, RT_ERROR_NONE);

    RawDevice *dev = new RawDevice(1);
    dev->Init();

    MOCKER(memcpy_s).stubs().will(returnValue(NULL));

    module1 = dev->ModuleAlloc(program);
    EXPECT_EQ(module1, (Module*)NULL);

    delete dev;

    rt->PutProgram(program);
}

TEST_F(CloudV2DeviceTest, module_alloc_load_fail_in_stubdev)
{
    rtError_t error;
    Program *program;
    rtDevBinary_t bin;
    Module * module1;

    Runtime *rt = ((Runtime *)Runtime::Instance());

    MOCKER(drvMemAllocL2buffAddr).stubs().will(returnValue(DRV_ERROR_INVALID_VALUE));
    MOCKER_CPP(&Module::Load)
        .stubs()
        .will(returnValue(RT_ERROR_INVALID_VALUE));

    bin.magic = RT_DEV_BINARY_MAGIC_PLAIN;
    bin.version = 1;
    bin.data = &bin;
    bin.length = sizeof(bin);
    error = rt->ProgramRegister(&bin, &program);
    EXPECT_EQ(error, RT_ERROR_NONE);

    rt->PutProgram(program);
}

TEST_F(CloudV2DeviceTest, START_TEST_1)
{
    rtError_t error;
    int32_t devId = 1;
    RawDevice *device = new RawDevice(1);
    error = device->Init();
    EXPECT_EQ(error, RT_ERROR_NONE);

    Stream * stream = new Stream(device, 0);

    device->primaryStream_ = stream;
    device->GetPendingNum();
    delete(device);
}

TEST_F(CloudV2DeviceTest, START_TEST_2)
{
    rtError_t error;
    int32_t devId = 1;
    RawDevice *device = new RawDevice(1);
    device->Init();

    MOCKER_CPP_VIRTUAL(device->engine_, &Engine::Start)
        .stubs()
        .will(returnValue(RT_ERROR_INVALID_VALUE));
    error = device->Start();
    device->ProcDeviceErrorInfo();
    device->Stop();
    EXPECT_EQ(error, RT_ERROR_INVALID_VALUE);
    delete device;
}

TEST_F(CloudV2DeviceTest, raw_device_init)
{
    rtError_t error;

    RawDevice *device = new RawDevice(1);

    UmaArgLoader *argLoader = new UmaArgLoader(device);

    MOCKER_CPP_VIRTUAL(argLoader, &UmaArgLoader::Init).stubs().will(returnValue(RT_ERROR_INVALID_VALUE));

    error = device->Init();

    EXPECT_EQ(error, RT_ERROR_INVALID_VALUE);

    delete(argLoader);
    delete(device);
}

TEST_F(CloudV2DeviceTest, raw_device_task_factory)
{
    rtError_t error;

    RawDevice *device = new RawDevice(1);

    MOCKER_CPP(&TaskFactory::Init).stubs().will(returnValue(RT_ERROR_INVALID_VALUE));

    error = device->Init();
    EXPECT_EQ(error, RT_ERROR_INVALID_VALUE);

    delete(device);
}

TEST_F(CloudV2DeviceTest, device_error_proc3)
{
    Device* device= ((Runtime *)Runtime::Instance())->DeviceRetain(1, 0);
    DeviceErrorProc *errorProc = new DeviceErrorProc(device, 524288);
    EXPECT_NE(device, nullptr);

    delete errorProc;
    ((Runtime *)Runtime::Instance())->DeviceRelease(device);
}

TEST_F(CloudV2DeviceTest, device_error_proc6)
{
    Device* device= ((Runtime *)Runtime::Instance())->DeviceRetain(1, 0);
    DeviceErrorProc *errorProc = new DeviceErrorProc(device, 524288);
    EXPECT_NE(device, nullptr);
    TaskInfo task = {};
    task.isNoRingbuffer = 1U;
    errorProc->ProcErrorInfo(&task);
    delete errorProc;
    ((Runtime *)Runtime::Instance())->DeviceRelease(device);
}

uint16_t g_sId = 0;
uint16_t g_tId = 0;
rtError_t MemCopySyncForRingBuffer2(Driver *drv, void *dst, uint64_t destMax, const void *src, uint64_t size, rtMemcpyKind_t kind)
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

TEST_F(CloudV2DeviceTest, device_error_report_ringbuffer_02)
{
    uint16_t streamId;
    rtSetDevice(1);
    Device* device = ((Runtime *)Runtime::Instance())->DeviceRetain(1, 0);
    DeviceErrorProc *errorProc = new DeviceErrorProc(device);
    DevRingBufferCtlInfo *ctlInfo  = (DevRingBufferCtlInfo *)malloc(DEVICE_ERROR_RINGBUFFER_SIZE);
    memset(ctlInfo, 0, DEVICE_ERROR_RINGBUFFER_SIZE);
    if (ctlInfo != nullptr) {
        ctlInfo->tail = 1;
        ctlInfo->head = 0;
        ctlInfo->magic = RINGBUFFER_MAGIC;
        ctlInfo->ringBufferLen  = (DEVICE_ERROR_RINGBUFFER_SIZE - sizeof(DevRingBufferCtlInfo));
        uint64_t oneElementLen = sizeof(DeviceErrorInfo) + sizeof(RingBufferElementInfo);
        uintptr_t infoAddr = reinterpret_cast<uintptr_t>(ctlInfo) +
                             sizeof(DevRingBufferCtlInfo) +
                             ctlInfo->head * oneElementLen;
        RingBufferElementInfo *info = (RingBufferElementInfo *)infoAddr;
        DeviceErrorInfo *errorInfo = reinterpret_cast<DeviceErrorInfo *>(info + 1);
        info->errorType = AICORE_ERROR;
        errorInfo->u.coreErrorInfo.coreNum = 1;
        errorInfo->u.coreErrorInfo.type = AICORE_ERROR;
        errorInfo->u.coreErrorInfo.info[0].aicError = 1;
        rtError_t error = errorProc->ProcessOneElementInRingBuffer(ctlInfo, 0, 1);
        EXPECT_EQ(error, RT_ERROR_NONE);

        free(ctlInfo);
    }

    errorProc->deviceRingBufferAddr_ = nullptr;
    errorProc->ReportRingBuffer(&streamId);
    delete errorProc;
    ((Runtime *)Runtime::Instance())->DeviceRelease(device);
    rtDeviceReset(1);
}

rtError_t MemCopySyncStub1(Driver *drv, void *dst, uint64_t destMax, const void *src, uint64_t size, rtMemcpyKind_t kind)
{
    DevRingBufferCtlInfo *tmpCtrlInfo = reinterpret_cast<DevRingBufferCtlInfo *>(dst);
    tmpCtrlInfo->magic = 0;
    tmpCtrlInfo->ringBufferLen = 0;
    return DRV_ERROR_NONE;
}

TEST_F(CloudV2DeviceTest, AICORE_Normal)
{
//    MOCKER(halMemAlloc).stubs().will(invoke(halMemAllocStub));
    rtSetDevice(1);
    Device* device= ((Runtime *)Runtime::Instance())->DeviceRetain(1, 0);
    DeviceErrorProc *errorProc = new DeviceErrorProc(device);
    DevRingBufferCtlInfo *ctlInfo  = (DevRingBufferCtlInfo *)malloc(DEVICE_ERROR_RINGBUFFER_SIZE);
    if (ctlInfo != nullptr) {
        ctlInfo->tail = 1;
        ctlInfo->head = 0;
        ctlInfo->magic = RINGBUFFER_MAGIC;
        ctlInfo->ringBufferLen  = (DEVICE_ERROR_RINGBUFFER_SIZE - sizeof(DevRingBufferCtlInfo));
        uint64_t oneElementLen = sizeof(DeviceErrorInfo) + sizeof(RingBufferElementInfo);
        uintptr_t infoAddr = reinterpret_cast<uintptr_t>(ctlInfo) +
                             sizeof(DevRingBufferCtlInfo) +
                             ctlInfo->head * oneElementLen;
        RingBufferElementInfo *info = (RingBufferElementInfo *)infoAddr;
        DeviceErrorInfo *errorInfo = reinterpret_cast<DeviceErrorInfo *>(info + 1);
        info->errorType = AICORE_ERROR;
        errorInfo->u.coreErrorInfo.coreNum = 1;
        errorInfo->u.coreErrorInfo.type = AICORE_ERROR;
        errorInfo->u.coreErrorInfo.info[0].aicError = 1;
        errorProc->ProcessOneElementInRingBuffer(ctlInfo, 0, 1);
        free(ctlInfo);
    }

    errorProc->deviceRingBufferAddr_ = nullptr;
    delete errorProc;
    ((Runtime *)Runtime::Instance())->DeviceRelease(device);
    rtError_t ret = rtDeviceReset(1);
    EXPECT_EQ(ret, RT_ERROR_NONE);
}

TEST_F(CloudV2DeviceTest, SDMA_Normal)
{
    rtSetDevice(1);
    Device* device= ((Runtime *)Runtime::Instance())->DeviceRetain(1, 0);
    DeviceErrorProc *errorProc = new DeviceErrorProc(device);
    DevRingBufferCtlInfo *ctlInfo  = (DevRingBufferCtlInfo *)malloc(DEVICE_ERROR_RINGBUFFER_SIZE);
    if (ctlInfo != nullptr) {
        ctlInfo->tail = 1;
        ctlInfo->head = 0;
        ctlInfo->magic = RINGBUFFER_MAGIC;
        ctlInfo->ringBufferLen  = (DEVICE_ERROR_RINGBUFFER_SIZE - sizeof(DevRingBufferCtlInfo));
        uint64_t oneElementLen = sizeof(DeviceErrorInfo) + sizeof(RingBufferElementInfo);
        uintptr_t infoAddr = reinterpret_cast<uintptr_t>(ctlInfo) +
                             sizeof(DevRingBufferCtlInfo) +
                             ctlInfo->head * oneElementLen;
        RingBufferElementInfo *info = (RingBufferElementInfo *)infoAddr;
        DeviceErrorInfo *errorInfo = reinterpret_cast<DeviceErrorInfo *>(info + 1);
        info->errorType = SDMA_ERROR;
        errorInfo->u.sdmaErrorInfo.channelStatus = 1;
        errorInfo->u.sdmaErrorInfo.cqeStatus = 1;
        errorProc->ProcessOneElementInRingBuffer(ctlInfo, 0, 1);
        free(ctlInfo);
    }

    errorProc->deviceRingBufferAddr_ = nullptr;
    delete errorProc;
    ((Runtime *)Runtime::Instance())->DeviceRelease(device);
    rtError_t ret = rtDeviceReset(1);
    EXPECT_EQ(ret, RT_ERROR_NONE);
}

TEST_F(CloudV2DeviceTest, AICPU_Normal_0)
{
    rtSetDevice(1);
    Device* device= ((Runtime *)Runtime::Instance())->DeviceRetain(1, 0);
    DeviceErrorProc *errorProc = new DeviceErrorProc(device);
    DevRingBufferCtlInfo *ctlInfo  = (DevRingBufferCtlInfo *)malloc(DEVICE_ERROR_RINGBUFFER_SIZE);
    if (ctlInfo != nullptr) {
        ctlInfo->tail = 1;
        ctlInfo->head = 0;
        ctlInfo->magic = RINGBUFFER_MAGIC;
        ctlInfo->ringBufferLen  = (DEVICE_ERROR_RINGBUFFER_SIZE - sizeof(DevRingBufferCtlInfo));
        uint64_t oneElementLen = sizeof(DeviceErrorInfo) + sizeof(RingBufferElementInfo);
        uintptr_t infoAddr = reinterpret_cast<uintptr_t>(ctlInfo) +
                             sizeof(DevRingBufferCtlInfo) +
                             ctlInfo->head * oneElementLen;
        RingBufferElementInfo *info = (RingBufferElementInfo *)infoAddr;
        DeviceErrorInfo *errorInfo = reinterpret_cast<DeviceErrorInfo *>(info + 1);
        info->errorType = AICPU_ERROR;
        errorInfo->u.aicpuErrorInfo.errcode = 21001;
        errorProc->ProcessOneElementInRingBuffer(ctlInfo, 0, 1);
        free(ctlInfo);
    }

    errorProc->deviceRingBufferAddr_ = nullptr;
    delete errorProc;
    ((Runtime *)Runtime::Instance())->DeviceRelease(device);
    rtError_t ret = rtDeviceReset(1);
    EXPECT_EQ(ret, RT_ERROR_NONE);
}

TEST_F(CloudV2DeviceTest, AICPU_Normal_1)
{
    rtSetDevice(1);
    Device* device= ((Runtime *)Runtime::Instance())->DeviceRetain(1, 0);
    DeviceErrorProc *errorProc = new DeviceErrorProc(device);
    DevRingBufferCtlInfo *ctlInfo  = (DevRingBufferCtlInfo *)malloc(DEVICE_ERROR_RINGBUFFER_SIZE);
    if (ctlInfo != nullptr) {
        ctlInfo->tail = 1;
        ctlInfo->head = 0;
        ctlInfo->magic = RINGBUFFER_MAGIC;
        ctlInfo->ringBufferLen  = (DEVICE_ERROR_RINGBUFFER_SIZE - sizeof(DevRingBufferCtlInfo));
        uint64_t oneElementLen = sizeof(DeviceErrorInfo) + sizeof(RingBufferElementInfo);
        uintptr_t infoAddr = reinterpret_cast<uintptr_t>(ctlInfo) +
                             sizeof(DevRingBufferCtlInfo) +
                             ctlInfo->head * oneElementLen;
        RingBufferElementInfo *info = (RingBufferElementInfo *)infoAddr;
        DeviceErrorInfo *errorInfo = reinterpret_cast<DeviceErrorInfo *>(info + 1);
        info->errorType = AICPU_ERROR;
        errorInfo->u.aicpuErrorInfo.errcode = 99999;
        errorProc->ProcessOneElementInRingBuffer(ctlInfo, 0, 1);
        free(ctlInfo);
    }

    errorProc->deviceRingBufferAddr_ = nullptr;
    delete errorProc;
    ((Runtime *)Runtime::Instance())->DeviceRelease(device);
    rtError_t ret = rtDeviceReset(1);
    EXPECT_EQ(ret, RT_ERROR_NONE);
}

TEST_F(CloudV2DeviceTest, raw_device_aicpu_model_load)
{
    RawDevice device(0);
    rtError_t error = device.AicpuModelLoad(NULL);
    EXPECT_NE(error, RT_ERROR_NONE);
}

TEST_F(CloudV2DeviceTest, raw_device_aicpu_model_execute)
{
    RawDevice device(0);
    uint32_t modelId = 0;
    rtError_t error = device.AicpuModelExecute(modelId);
    EXPECT_NE(error, RT_ERROR_NONE);
}

TEST_F(CloudV2DeviceTest, raw_device_aicpu_model_destroy)
{
    RawDevice device(0);
    uint32_t modelId = 0;
    rtError_t error = device.AicpuModelDestroy(modelId);
    EXPECT_NE(error, RT_ERROR_NONE);
}

TEST_F(CloudV2DeviceTest, raw_device_aicpu_model_abort)
{
    uint32_t modelId = 0;
    RawDevice device(0);
    rtError_t error = device.AicpuModelAbort(modelId);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(CloudV2DeviceTest, DevSetLimit_in_rawdev)
{
    rtSetDevice(1);
     rtLimitType_t type = (rtLimitType_t)0U;
    Device *dev = ((Runtime *)Runtime::Instance())->DeviceRetain(1, 0);
    rtError_t error = rtDeviceSetLimit(1, type, 0U);
    EXPECT_EQ(error, RT_ERROR_NONE);

    ((Runtime *)Runtime::Instance())->DeviceRelease(dev);
    rtDeviceReset(1);
}

TEST_F(CloudV2DeviceTest, DevSetLimit_in_rawdev_01)
{
    rtSetDevice(1);
    rtLimitType_t type = (rtLimitType_t)1U;
    Device *dev = ((Runtime *)Runtime::Instance())->DeviceRetain(1, 0);
    rtError_t error = rtDeviceSetLimit(1, type, 0U);
    EXPECT_EQ(error, RT_ERROR_NONE);

    ((Runtime *)Runtime::Instance())->DeviceRelease(dev);
    rtDeviceReset(1);
}

TEST_F(CloudV2DeviceTest, STARS_AICPU_Normal_0)
{
    rtSetDevice(1);
    Device* device= ((Runtime *)Runtime::Instance())->DeviceRetain(1, 0);
    DeviceErrorProc *errorProc = new DeviceErrorProc(device);
    DevRingBufferCtlInfo *ctlInfo  = (DevRingBufferCtlInfo *)malloc(DEVICE_ERROR_EXT_RINGBUFFER_SIZE);
    memset_s(ctlInfo, DEVICE_ERROR_EXT_RINGBUFFER_SIZE, 0, DEVICE_ERROR_EXT_RINGBUFFER_SIZE);
    if (ctlInfo != nullptr) {
        ctlInfo->tail = 1;
        ctlInfo->head = 0;
        ctlInfo->magic = RINGBUFFER_MAGIC;
        ctlInfo->ringBufferLen  = RINGBUFFER_LEN;
        uint64_t oneElementLen = sizeof(StarsDeviceErrorInfo) + sizeof(RingBufferElementInfo);
        uintptr_t infoAddr = reinterpret_cast<uintptr_t>(ctlInfo) +
                             sizeof(DevRingBufferCtlInfo) +
                             ctlInfo->head * oneElementLen;
        RingBufferElementInfo *info = (RingBufferElementInfo *)infoAddr;
        StarsDeviceErrorInfo *errorInfo = reinterpret_cast<StarsDeviceErrorInfo *>(info + 1);
        info->errorType = AICPU_ERROR;
        errorInfo->u.aicpuErrorInfo.comm.type = AICPU_ERROR;
        errorInfo->u.aicpuErrorInfo.comm.coreNum = 1;
        errorInfo->u.aicpuErrorInfo.aicpu.rspErrorInfo.errcode = 21001;
        rtError_t error = errorProc->ProcessStarsOneElementInRingBuffer(ctlInfo, 0, 1);
        EXPECT_EQ(error, RT_ERROR_NONE);

        errorInfo->u.aicpuErrorInfo.comm.type = FFTS_PLUS_AICPU_ERROR;
        errorInfo->u.aicpuErrorInfo.comm.coreNum = 2;
        errorInfo->u.aicpuErrorInfo.comm.exceptionSlotId = 3;
        errorInfo->u.aicpuErrorInfo.comm.dieId = 4;
        errorInfo->u.aicpuErrorInfo.aicpu.info[0].aicpuId = 5;
        errorInfo->u.aicpuErrorInfo.aicpu.info[0].aicpuState = 0x6;
        errorInfo->u.aicpuErrorInfo.aicpu.info[1].aicpuId = 15;
        errorInfo->u.aicpuErrorInfo.aicpu.info[1].aicpuCxtid = 0x8;

        error = errorProc->ProcessStarsOneElementInRingBuffer(ctlInfo, 0, 1);
        EXPECT_EQ(error, RT_ERROR_NONE);
        free(ctlInfo);
    }

    errorProc->deviceRingBufferAddr_ = nullptr;
    delete errorProc;
    ((Runtime *)Runtime::Instance())->DeviceRelease(device);
    rtDeviceReset(1);
}

TEST_F(CloudV2DeviceTest, STARS_AICPU_Normal_02)
{
    rtSetDevice(1);
    Device* device= ((Runtime *)Runtime::Instance())->DeviceRetain(1, 0);
    DeviceErrorProc *errorProc = new DeviceErrorProc(device);
    DevRingBufferCtlInfo *ctlInfo  = (DevRingBufferCtlInfo *)malloc(DEVICE_ERROR_EXT_RINGBUFFER_SIZE);
    memset_s(ctlInfo, DEVICE_ERROR_EXT_RINGBUFFER_SIZE, 0, DEVICE_ERROR_EXT_RINGBUFFER_SIZE);
    if (ctlInfo != nullptr) {
        ctlInfo->tail = 1;
        ctlInfo->head = 0;
        ctlInfo->magic = RINGBUFFER_MAGIC;
        ctlInfo->ringBufferLen  = RINGBUFFER_LEN;
        uint64_t oneElementLen = sizeof(StarsDeviceErrorInfo) + sizeof(RingBufferElementInfo);
        uintptr_t infoAddr = reinterpret_cast<uintptr_t>(ctlInfo) +
                             sizeof(DevRingBufferCtlInfo) +
                             ctlInfo->head * oneElementLen;
        RingBufferElementInfo *info = (RingBufferElementInfo *)infoAddr;
        StarsDeviceErrorInfo *errorInfo = reinterpret_cast<StarsDeviceErrorInfo *>(info + 1);
        info->errorType = AICPU_ERROR;
        errorInfo->u.aicpuErrorInfo.comm.type = AICPU_ERROR;
        errorInfo->u.aicpuErrorInfo.comm.coreNum = 1;
        errorInfo->u.aicpuErrorInfo.aicpu.rspErrorInfo.errcode = 21001;
        rtError_t error = errorProc->ProcessStarsOneElementInRingBuffer(ctlInfo, 0, 1, true);
        EXPECT_EQ(error, RT_ERROR_NONE);

        errorInfo->u.aicpuErrorInfo.comm.type = FFTS_PLUS_AICPU_ERROR;
        errorInfo->u.aicpuErrorInfo.comm.coreNum = 2;
        errorInfo->u.aicpuErrorInfo.comm.exceptionSlotId = 3;
        errorInfo->u.aicpuErrorInfo.comm.dieId = 4;
        errorInfo->u.aicpuErrorInfo.aicpu.info[0].aicpuId = 5;
        errorInfo->u.aicpuErrorInfo.aicpu.info[0].aicpuState = 0x6;
        errorInfo->u.aicpuErrorInfo.aicpu.info[1].aicpuId = 15;
        errorInfo->u.aicpuErrorInfo.aicpu.info[1].aicpuCxtid = 0x8;

        error = errorProc->ProcessStarsOneElementInRingBuffer(ctlInfo, 0, 1, true);
        EXPECT_EQ(error, RT_ERROR_NONE);
        free(ctlInfo);
    }

    errorProc->deviceRingBufferAddr_ = nullptr;
    delete errorProc;
    ((Runtime *)Runtime::Instance())->DeviceRelease(device);
    rtDeviceReset(1);
}

TEST_F(CloudV2DeviceTest, STARS_SDMA_Normal_0)
{
    rtSetDevice(1);
    Device* device= ((Runtime *)Runtime::Instance())->DeviceRetain(1, 0);
    DeviceErrorProc *errorProc = new DeviceErrorProc(device);
    DevRingBufferCtlInfo *ctlInfo  = (DevRingBufferCtlInfo *)malloc(DEVICE_ERROR_EXT_RINGBUFFER_SIZE);
    memset_s(ctlInfo, DEVICE_ERROR_EXT_RINGBUFFER_SIZE, 0, DEVICE_ERROR_EXT_RINGBUFFER_SIZE);
    if (ctlInfo != nullptr) {
        ctlInfo->tail = 1;
        ctlInfo->head = 0;
        ctlInfo->magic = RINGBUFFER_MAGIC;
        ctlInfo->ringBufferLen  = RINGBUFFER_LEN;
        uint64_t oneElementLen = sizeof(StarsDeviceErrorInfo) + sizeof(RingBufferElementInfo);
        uintptr_t infoAddr = reinterpret_cast<uintptr_t>(ctlInfo) +
                             sizeof(DevRingBufferCtlInfo) +
                             ctlInfo->head * oneElementLen;
        RingBufferElementInfo *info = (RingBufferElementInfo *)infoAddr;
        StarsDeviceErrorInfo *errorInfo = reinterpret_cast<StarsDeviceErrorInfo *>(info + 1);
        info->errorType = SDMA_ERROR;
        errorInfo->u.sdmaErrorInfo.comm.type = SDMA_ERROR;
        errorInfo->u.sdmaErrorInfo.comm.coreNum = 1;
        errorInfo->u.sdmaErrorInfo.sdma.starsInfo[0].sdmaChannelId = 1;
        rtError_t error = errorProc->ProcessStarsOneElementInRingBuffer(ctlInfo, 0, 1);
        EXPECT_EQ(error, RT_ERROR_NONE);

        errorInfo->u.coreErrorInfo.comm.coreNum = 1;
        errorInfo->u.coreErrorInfo.info[0].coreId = 1;
        errorInfo->u.coreErrorInfo.info[0].aicError[0] = 0x0;
        errorInfo->u.coreErrorInfo.info[0].aicError[1] = 0x0;
        errorInfo->u.coreErrorInfo.info[0].aicError[2] = 0x0;
        error = errorProc->ProcessStarsOneElementInRingBuffer(ctlInfo, 0, 1);
        EXPECT_EQ(error, RT_ERROR_NONE);

        errorInfo->u.sdmaErrorInfo.comm.type = FFTS_PLUS_SDMA_ERROR;
        errorInfo->u.sdmaErrorInfo.comm.coreNum = 2;
        errorInfo->u.sdmaErrorInfo.comm.exceptionSlotId = 3;
        errorInfo->u.sdmaErrorInfo.comm.dieId = 4;
        errorInfo->u.sdmaErrorInfo.sdma.fftsPlusInfo[0].sdmaChannelId = 5;
        errorInfo->u.sdmaErrorInfo.sdma.fftsPlusInfo[0].sdmaState = 0x6;
        errorInfo->u.sdmaErrorInfo.sdma.fftsPlusInfo[1].sdmaChannelId = 25;
        errorInfo->u.sdmaErrorInfo.sdma.fftsPlusInfo[1].sdmaState = 0x26;

        error = errorProc->ProcessStarsOneElementInRingBuffer(ctlInfo, 0, 1);
        EXPECT_EQ(error, RT_ERROR_NONE);
        free(ctlInfo);
    }

    errorProc->deviceRingBufferAddr_ = nullptr;
    delete errorProc;
    ((Runtime *)Runtime::Instance())->DeviceRelease(device);
    rtDeviceReset(1);
}

TEST_F(CloudV2DeviceTest, STARS_CORE_Normal_0)
{
    rtSetDevice(1);
    Device* device= ((Runtime *)Runtime::Instance())->DeviceRetain(1, 0);
    DeviceErrorProc *errorProc = new DeviceErrorProc(device);
    DevRingBufferCtlInfo *ctlInfo  = (DevRingBufferCtlInfo *)malloc(DEVICE_ERROR_EXT_RINGBUFFER_SIZE);
    memset_s(ctlInfo, DEVICE_ERROR_EXT_RINGBUFFER_SIZE, 0, DEVICE_ERROR_EXT_RINGBUFFER_SIZE);
    if (ctlInfo != nullptr) {
        ctlInfo->tail = 1;
        ctlInfo->head = 0;
        ctlInfo->magic = RINGBUFFER_MAGIC;
        ctlInfo->ringBufferLen  = RINGBUFFER_LEN;
        uint64_t oneElementLen = sizeof(StarsDeviceErrorInfo) + sizeof(RingBufferElementInfo);
        uintptr_t infoAddr = reinterpret_cast<uintptr_t>(ctlInfo) +
                             sizeof(DevRingBufferCtlInfo) +
                             ctlInfo->head * oneElementLen;
        RingBufferElementInfo *info = (RingBufferElementInfo *)infoAddr;
        StarsDeviceErrorInfo *errorInfo = reinterpret_cast<StarsDeviceErrorInfo *>(info + 1);
        info->errorType = AICORE_ERROR;
        errorInfo->u.coreErrorInfo.comm.type = AICORE_ERROR;
        errorInfo->u.coreErrorInfo.comm.coreNum = 1;
        errorInfo->u.coreErrorInfo.info[0].coreId = 1;
        errorInfo->u.coreErrorInfo.info[0].aicError[1] = 0x6;
        rtError_t error = errorProc->ProcessStarsOneElementInRingBuffer(ctlInfo, 0, 1);
        EXPECT_EQ(error, RT_ERROR_NONE);

        errorInfo->u.coreErrorInfo.comm.type = AIVECTOR_ERROR;
        errorInfo->u.coreErrorInfo.comm.coreNum = 2;
        errorInfo->u.coreErrorInfo.comm.exceptionSlotId = 3;
        errorInfo->u.coreErrorInfo.comm.dieId = 4;
        errorInfo->u.coreErrorInfo.info[0].coreId = 5;
        errorInfo->u.coreErrorInfo.info[0].aicError[0] = 0x6;
        errorInfo->u.coreErrorInfo.info[1].coreId = 25;
        errorInfo->u.coreErrorInfo.info[1].aicError[5] = 0x27;

        error = errorProc->ProcessStarsOneElementInRingBuffer(ctlInfo, 0, 1);
        EXPECT_EQ(error, RT_ERROR_NONE);
        free(ctlInfo);
    }

    errorProc->deviceRingBufferAddr_ = nullptr;
    delete errorProc;
    ((Runtime *)Runtime::Instance())->DeviceRelease(device);
    rtDeviceReset(1);
}

TEST_F(CloudV2DeviceTest, STARS_DVPP_ErrorInfo)
{
    rtSetDevice(1);
    Device* device= ((Runtime *)Runtime::Instance())->DeviceRetain(1, 0);
    DeviceErrorProc *errorProc = new DeviceErrorProc(device);
    StarsDeviceErrorInfo errorInfo = {};

    rtError_t ret = errorProc->ProcessStarsDvppErrorInfo(nullptr, 0, device, nullptr);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    ret = errorProc->ProcessStarsDvppErrorInfo(&errorInfo, 0, device, nullptr);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    delete errorProc;
    ((Runtime *)Runtime::Instance())->DeviceRelease(device);
    rtDeviceReset(1);
}


TEST_F(CloudV2DeviceTest, STARS_SQE_ErrorInfo)
{
    rtSetDevice(1);
    Device* device= ((Runtime *)Runtime::Instance())->DeviceRetain(1, 0);
    DeviceErrorProc *errorProc = new DeviceErrorProc(device);
    StarsDeviceErrorInfo errorInfo = {};

    rtError_t ret = errorProc->ProcessStarsSqeErrorInfo(nullptr, 0, device, nullptr);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    ret = errorProc->ProcessStarsSqeErrorInfo(&errorInfo, 0, device, nullptr);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    delete errorProc;
    ((Runtime *)Runtime::Instance())->DeviceRelease(device);
    rtDeviceReset(1);
}

TEST_F(CloudV2DeviceTest, STARS_HcclTimeout_ErrorInfo)
{
    rtSetDevice(1);
    TaskInfo task = {};
    Device* device= ((Runtime *)Runtime::Instance())->DeviceRetain(1, 0);
    DeviceErrorProc *errorProc = new DeviceErrorProc(device);
    StarsDeviceErrorInfo errorInfo = {};

    MOCKER(PushBackErrInfo)
        .stubs()
        .will(returnValue(0));

    rtError_t ret = errorProc->ProcessStarsHcclFftsPlusTimeoutErrorInfo(nullptr, 0, device, errorProc);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    errorInfo.u.hcclFftsplusTimeoutInfo.errConetxtNum = 2;
    errorInfo.u.hcclFftsplusTimeoutInfo.common.timeout = 1770;
    ret = errorProc->ProcessStarsHcclFftsPlusTimeoutErrorInfo(&errorInfo, 0, device, errorProc);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    delete errorProc;
    ((Runtime *)Runtime::Instance())->DeviceRelease(device);
    rtDeviceReset(1);
}

TEST_F(CloudV2DeviceTest, STARS_HcclTimeout_ErrorInfo1)
{
    rtSetDevice(1);
    TaskInfo task = {};
    Device* device= ((Runtime *)Runtime::Instance())->DeviceRetain(1, 0);
    DeviceErrorProc *errorProc = new DeviceErrorProc(device);
    StarsDeviceErrorInfo errorInfo = {};

    MOCKER(PushBackErrInfo)
        .stubs()
        .will(returnValue(0));

    rtError_t ret = errorProc->ProcessStarsHcclFftsPlusTimeoutErrorInfo(nullptr, 0, device, errorProc);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    errorInfo.u.hcclFftsplusTimeoutInfo.errConetxtNum = 2;
    errorInfo.u.hcclFftsplusTimeoutInfo.common.timeout = 1800;
    ret = errorProc->ProcessStarsHcclFftsPlusTimeoutErrorInfo(&errorInfo, 0, device, errorProc);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    delete errorProc;
    ((Runtime *)Runtime::Instance())->DeviceRelease(device);
    rtDeviceReset(1);
}

TEST_F(CloudV2DeviceTest, STARS_dsa_ErrorInfo)
{
    rtSetDevice(1);
    Device* device= ((Runtime *)Runtime::Instance())->DeviceRetain(1, 0);
    DeviceErrorProc *errorProc = new DeviceErrorProc(device);
    StarsDeviceErrorInfo errorInfo = {};
    TaskInfo taskInfo = {};
    errorInfo.u.dsaErrorInfo.coreNum = 1;
    rtError_t ret = errorProc->ProcessStarsDsaErrorInfo(nullptr, 0, device, errorProc);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    TaskInfo fftsPlusTask = {};
    fftsPlusTask.type = TS_TASK_TYPE_FFTS_PLUS;
    errorProc->SetRealFaultTaskPtr(&fftsPlusTask);
    MOCKER(PushBackErrInfo).stubs().will(returnValue(0));
    ret = errorProc->ProcessStarsDsaErrorInfo(&errorInfo, 0, device, errorProc);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    MOCKER_CPP(&TaskFactory::GetTask)
    .stubs()
    .with(mockcpp::any(), mockcpp::any())
    .will(returnValue(&taskInfo));
    errorInfo.u.dsaErrorInfo.type = DSA_ERROR;
    ret = errorProc->ProcessStarsDsaErrorInfo(&errorInfo, 0, device, errorProc);
    GlobalMockObject::verify();
    EXPECT_EQ(ret, RT_ERROR_NONE);

    delete errorProc;
    ((Runtime *)Runtime::Instance())->DeviceRelease(device);
    rtDeviceReset(1);
}
TEST_F(CloudV2DeviceTest, STARS_AicoreTimeoutDfx)
{
    rtSetDevice(1);
    Device* device = ((Runtime *)Runtime::Instance())->DeviceRetain(1, 0);

    Stream *stm = new Stream(device, 1);
    stm->streamId_ = 1;
    rtError_t errCode = RT_ERROR_NONE;
    TaskInfo * const tsk = device->GetTaskFactory()->Alloc(stm, TS_TASK_TYPE_KERNEL_AICORE, errCode);
    AicTaskInit(tsk, 1, 1, 0U, nullptr);

    const void *stubFunc = (void *)0x03;
    const char *stubName = "efgexample";
    Kernel *kernel = NULL;
    PlainProgram stubProg(Program::MACH_AI_CPU);
    Program *program = &stubProg;
    program->kernelNames_ = {'e', 'f', 'g', 'h', '\0'};

    MOCKER_CPP(&Runtime::GetProgram)
        .stubs()
        .will(returnValue(true));
    MOCKER_CPP(&Runtime::GetProgram)
        .stubs()
        .will(ignoreReturnValue());
    kernel = new (std::nothrow) Kernel(stubFunc, stubName, "", program, 0);
    ((Runtime *)Runtime::Instance())->kernelTable_.Add(kernel);
    AicTaskInfo *aicTaskInfo = &(tsk->u.aicTaskInfo);
    aicTaskInfo->kernel = kernel;

    device->GetTaskFactory()->SetSerialId(stm, tsk);

    DeviceErrorProc *errorProc = new DeviceErrorProc(device);
    StarsDeviceErrorInfo errorInfo = {};

    rtError_t ret = errorProc->ProcessStarsCoreTimeoutDfxInfo(nullptr, 0, device, errorProc);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    StarsErrorCommonInfo common = {};
    common.slotNum = 1U;
    common.coreNum = 1U;
    errorInfo.u.coreTimeoutDfxInfo.comm = common;
    StarsOneTimeoutSlotDfxInfo slotInfo0 = {};
    slotInfo0.streamId = 1;
    slotInfo0.taskId = tsk->id;
    errorInfo.u.coreTimeoutDfxInfo.slotInfo[0] = slotInfo0;

    StarsOneTimeoutCoreDfxInfo coreInfo0 = {};
    coreInfo0.subError = 1U;
    errorInfo.u.coreTimeoutDfxInfo.coreInfo[0] = coreInfo0;
    ret = errorProc->ProcessStarsCoreTimeoutDfxInfo(&errorInfo, 0, device, errorProc);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    (void)device->GetTaskFactory()->Recycle(tsk);
    delete stm;
    delete errorProc;
    ((Runtime *)Runtime::Instance())->DeviceRelease(device);
    rtDeviceReset(1);
}

TEST_F(CloudV2DeviceTest, STARS_AicoreTimeoutDfx1)
{
    // mix
    rtSetDevice(1);
    Device* device = ((Runtime *)Runtime::Instance())->DeviceRetain(1, 0);

    Stream *stm = new Stream(device, 1);
    stm->streamId_ = 1;
    TaskInfo taskInfo = {};
    taskInfo.stream = stm;

    const void *stubFunc = (void *)0x03;
    const char *stubName = "abcd";
    PlainProgram stubProg(Program::MACH_AI_CORE);
    Program *program = &stubProg;
    program->kernelNames_ = {'a', 'b', 'c', '\0'};
    Kernel *kernel = new (std::nothrow) Kernel(stubFunc, stubName, "", program, 0);
    taskInfo.u.aicTaskInfo.kernel = kernel;
    taskInfo.u.aicTaskInfo.kernel->mixType_ = 1;
    DeviceErrorProc *errorProc = new DeviceErrorProc(device);
    StarsDeviceErrorInfo errorInfo = {};

    rtError_t ret = errorProc->ProcessStarsCoreTimeoutDfxInfo(nullptr, 0, device, errorProc);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    StarsErrorCommonInfo common = {};
    common.slotNum = 1U;
    common.coreNum = 1U;
    errorInfo.u.coreTimeoutDfxInfo.comm = common;
    StarsOneTimeoutSlotDfxInfo slotInfo0 = {};
    slotInfo0.streamId = 1;
    slotInfo0.fftsType = RT_FFTS_PLUS_TYPE;
    errorInfo.u.coreTimeoutDfxInfo.slotInfo[0] = slotInfo0;

    StarsOneTimeoutCoreDfxInfo coreInfo0 = {};
    coreInfo0.subError = 1U;
    errorInfo.u.coreTimeoutDfxInfo.coreInfo[0] = coreInfo0;
    MOCKER_CPP(&TaskFactory::GetTask)
        .stubs()
        .with(mockcpp::any(), mockcpp::any())
        .will(returnValue(&taskInfo));
    ret = errorProc->ProcessStarsCoreTimeoutDfxInfo(&errorInfo, 0, device, errorProc);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    GlobalMockObject::verify();
    EXPECT_EQ(ret, RT_ERROR_NONE);

    delete stm;
    delete errorProc;
    DELETE_O(kernel);
    ((Runtime *)Runtime::Instance())->DeviceRelease(device);
    rtDeviceReset(1);
}

TEST_F(CloudV2DeviceTest, STARS_AicoreTimeoutDfx2)
{
    // ffts+
    rtSetDevice(1);
    Device* device = ((Runtime *)Runtime::Instance())->DeviceRetain(1, 0);
    Stream *stm = new Stream(device, 1);
    stm->streamId_ = 1;
    TaskInfo taskInfo = {};
    taskInfo.stream = stm;
    DeviceErrorProc *errorProc = new DeviceErrorProc(device);
    StarsDeviceErrorInfo errorInfo = {};

    rtError_t ret = errorProc->ProcessStarsCoreTimeoutDfxInfo(nullptr, 0, device, errorProc);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    StarsErrorCommonInfo common = {};
    common.slotNum = 1U;
    common.coreNum = 1U;
    errorInfo.u.coreTimeoutDfxInfo.comm = common;
    StarsOneTimeoutSlotDfxInfo slotInfo0 = {};
    slotInfo0.streamId = 1;
    slotInfo0.fftsType = RT_FFTS_PLUS_TYPE;
    errorInfo.u.coreTimeoutDfxInfo.slotInfo[0] = slotInfo0;

    StarsOneTimeoutCoreDfxInfo coreInfo0 = {};
    coreInfo0.subError = 1U;
    errorInfo.u.coreTimeoutDfxInfo.coreInfo[0] = coreInfo0;
    MOCKER_CPP(&TaskFactory::GetTask)
        .stubs()
        .with(mockcpp::any(), mockcpp::any())
        .will(returnValue(&taskInfo));
    ret = errorProc->ProcessStarsCoreTimeoutDfxInfo(&errorInfo, 0, device, errorProc);

    EXPECT_EQ(ret, RT_ERROR_NONE);
    GlobalMockObject::verify();
    delete stm;
    delete errorProc;
    ((Runtime *)Runtime::Instance())->DeviceRelease(device);
    auto error = rtDeviceReset(1);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(CloudV2DeviceTest, STARS_AicoreTimeoutDfx3)
{
    // ffts+
    rtSetDevice(1);
    Device* device = ((Runtime *)Runtime::Instance())->DeviceRetain(1, 0);
    Stream *stm = new Stream(device, 1);
    stm->streamId_ = 1;

    TaskInfo taskInfo = {};
    taskInfo.stream = stm;
    DeviceErrorProc *errorProc = new DeviceErrorProc(device);
    StarsDeviceErrorInfo errorInfo = {};

    StarsErrorCommonInfo common = {};
    common.slotNum = 1U;
    common.coreNum = 1U;
    errorInfo.u.coreTimeoutDfxInfo.comm = common;
    StarsOneTimeoutSlotDfxInfo slotInfo0 = {};
    slotInfo0.streamId = 1;
    slotInfo0.fftsType = RT_FFTS_PLUS_TYPE;
    errorInfo.u.coreTimeoutDfxInfo.slotInfo[0] = slotInfo0;

    StarsOneTimeoutCoreDfxInfo coreInfo0 = {};
    coreInfo0.subError = 1U;
    errorInfo.u.coreTimeoutDfxInfo.coreInfo[0] = coreInfo0;
    rtError_t ret = errorProc->ProcessStarsCoreTimeoutDfxInfo(&errorInfo, 0, device, errorProc);

    EXPECT_EQ(ret, RT_ERROR_NONE);
    delete stm;
    delete errorProc;
    ((Runtime *)Runtime::Instance())->DeviceRelease(device);
    auto error = rtDeviceReset(1);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(CloudV2DeviceTest, STARS_AicoreTimeoutDfxSlotInfo1)
{
    // no ffts+
    rtSetDevice(1);
    Device* device = ((Runtime *)Runtime::Instance())->DeviceRetain(1, 0);

    DeviceErrorProc *errorProc = new DeviceErrorProc(device);
    StarsDeviceErrorInfo errorInfo = {};

    errorProc->ProcessStarsTimeoutDfxSlotInfo(nullptr, device, 0);
    StarsErrorCommonInfo common = {};
    common.slotNum = 1U;
    common.coreNum = 1U;
    errorInfo.u.coreTimeoutDfxInfo.comm = common;
    StarsOneTimeoutSlotDfxInfo slotInfo0 = {};
    slotInfo0.streamId = 1;
    errorInfo.u.coreTimeoutDfxInfo.slotInfo[0] = slotInfo0;

    StarsOneTimeoutCoreDfxInfo coreInfo0 = {};
    coreInfo0.subError = 1U;
    errorInfo.u.coreTimeoutDfxInfo.coreInfo[0] = coreInfo0;
    errorProc->ProcessStarsTimeoutDfxSlotInfo(&errorInfo, device, 0);

    delete errorProc;
    ((Runtime *)Runtime::Instance())->DeviceRelease(device);
    auto error = rtDeviceReset(1);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(CloudV2DeviceTest, STARS_AicoreTimeoutDfxSlotInfo4FftsPlus)
{
    // ffts+ aicore contexit
    rtSetDevice(1);
    TaskInfo taskInfo = {};
    FftsPlusTaskInfo *fftsPlusTaskInfo = &(taskInfo.u.fftsPlusTask);
    fftsPlusTaskInfo->descAlignBuf = malloc(256);
    fftsPlusTaskInfo->descBufLen = 256;
    Device* device = ((Runtime *)Runtime::Instance())->DeviceRetain(1, 0);
    Stream *stm = new Stream(device, 1);
    stm->streamId_ = 1;
    taskInfo.stream = stm;
    DeviceErrorProc *errorProc = new DeviceErrorProc(device);
    StarsDeviceErrorInfo errorInfo = {};

    errorProc->ProcessStarsTimeoutDfxSlotInfo4FftsPlus(nullptr, device, 0);
    StarsErrorCommonInfo common = {};
    common.slotNum = 1U;
    common.coreNum = 1U;
    errorInfo.u.coreTimeoutDfxInfo.comm = common;
    StarsOneTimeoutSlotDfxInfo slotInfo0 = {};
    slotInfo0.fftsType = 4U;
    errorInfo.u.coreTimeoutDfxInfo.slotInfo[0] = slotInfo0;

    StarsOneTimeoutCoreDfxInfo coreInfo0 = {};
    errorInfo.u.coreTimeoutDfxInfo.coreInfo[0] = coreInfo0;

    errorProc->ProcessStarsTimeoutDfxSlotInfo4FftsPlus(&errorInfo, device, 0);

    rtFftsPlusAicAivCtx_t temp = {};
    temp.contextType = RT_CTX_TYPE_AICORE;
    void *addr = reinterpret_cast<void  *>(&temp);

    MOCKER_CPP_VIRTUAL(device->Driver_(), &Driver::MemCopySync).stubs()
    .with(outBoundP(addr, sizeof(temp)), mockcpp::any(), mockcpp::any(), mockcpp::any(), mockcpp::any())
    .will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP(&TaskFactory::GetTask)
        .stubs()
        .with(mockcpp::any(), mockcpp::any())
        .will(returnValue(&taskInfo));
    errorProc->ProcessStarsTimeoutDfxSlotInfo4FftsPlus(&errorInfo, device, 0);
    GlobalMockObject::verify();
    delete stm;
    free(fftsPlusTaskInfo->descAlignBuf);
    delete errorProc;
    ((Runtime *)Runtime::Instance())->DeviceRelease(device);
    auto error = rtDeviceReset(1);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(CloudV2DeviceTest, STARS_AicoreTimeoutDfxSlotInfo4FftsPlus1)
{
    // ffts+ mix contexit
    rtSetDevice(1);
    TaskInfo taskInfo = {};
    FftsPlusTaskInfo *fftsPlusTaskInfo = &(taskInfo.u.fftsPlusTask);
    fftsPlusTaskInfo->descAlignBuf = malloc(256);
    fftsPlusTaskInfo->descBufLen = 256;
    Device* device = ((Runtime *)Runtime::Instance())->DeviceRetain(1, 0);
    Stream *stm = new Stream(device, 1);
    stm->streamId_ = 1;
    taskInfo.stream = stm;
    DeviceErrorProc *errorProc = new DeviceErrorProc(device);
    StarsDeviceErrorInfo errorInfo = {};

    errorProc->ProcessStarsTimeoutDfxSlotInfo4FftsPlus(nullptr, device, 0);
    StarsErrorCommonInfo common = {};
    common.slotNum = 1U;
    common.coreNum = 1U;
    errorInfo.u.coreTimeoutDfxInfo.comm = common;
    StarsOneTimeoutSlotDfxInfo slotInfo0 = {};
    slotInfo0.fftsType = 4U;
    errorInfo.u.coreTimeoutDfxInfo.slotInfo[0] = slotInfo0;

    StarsOneTimeoutCoreDfxInfo coreInfo0 = {};
    errorInfo.u.coreTimeoutDfxInfo.coreInfo[0] = coreInfo0;

    rtFftsPlusAicAivCtx_t temp = {};
    temp.contextType = RT_CTX_TYPE_MIX_AIC;
    void *addr = reinterpret_cast<void  *>(&temp);

    MOCKER_CPP_VIRTUAL(device->Driver_(), &Driver::MemCopySync).stubs()
    .with(outBoundP(addr, sizeof(temp)), mockcpp::any(), mockcpp::any(), mockcpp::any(), mockcpp::any())
    .will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP(&TaskFactory::GetTask)
        .stubs()
        .with(mockcpp::any(), mockcpp::any())
        .will(returnValue(&taskInfo));
    errorProc->ProcessStarsTimeoutDfxSlotInfo4FftsPlus(&errorInfo, device, 0);
    GlobalMockObject::verify();
    delete stm;
    free(fftsPlusTaskInfo->descAlignBuf);
    delete errorProc;
    ((Runtime *)Runtime::Instance())->DeviceRelease(device);
    auto error = rtDeviceReset(1);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(CloudV2DeviceTest, message_queue_add_test)
{
    RawDevice *device = new RawDevice(0);
    device->Init();
    EXPECT_NE(device->messageQueue_, nullptr);

    Stream *stream1 = new Stream(device, 0);
    Stream *stream2 = new Stream(device, 0);

    device->AddStreamToMessageQueue(stream1);
    device->AddStreamToMessageQueue(stream2);
    device->DelStreamFromMessageQueue(stream1);
    device->DelStreamFromMessageQueue(stream2);

    Stream *recycleStream = device->GetNextRecycleStream();
    EXPECT_EQ(recycleStream, nullptr);

    delete stream1;
    delete stream2;
    delete device;
}

TEST_F(CloudV2DeviceTest, message_queue_add_full_test)
{
    RawDevice *device = new RawDevice(0);
    device->Init();
    device->messageQueueSize_ = 2U;
    EXPECT_NE(device->messageQueue_, nullptr);

    Stream *stream1 = new Stream(device, 0);
    Stream *stream2 = new Stream(device, 0);
    Stream *stream3 = new Stream(device, 0);

    for (int i = 0; i < 3073; i++) {
        device->AddStreamToMessageQueue(stream1);
        device->AddStreamToMessageQueue(stream2);
    }

    bool ret = device->AddStreamToMessageQueue(stream3);
    EXPECT_EQ(ret, false);

    device->DelStreamFromMessageQueue(stream1);
    device->DelStreamFromMessageQueue(stream2);

    Stream *recycleStream = device->GetNextRecycleStream();
    EXPECT_EQ(recycleStream, nullptr);

    delete stream1;
    delete stream2;
    delete stream3;
    delete device;
}

TEST_F(CloudV2DeviceTest, message_queue_get_test)
{
    RawDevice *device = new RawDevice(0);
    device->Init();
    EXPECT_NE(device->messageQueue_, nullptr);

    Stream *stream = new Stream(device, 0);

    device->AddStreamToMessageQueue(stream);
    Stream *recycleStream = device->GetNextRecycleStream();
    EXPECT_EQ(recycleStream, stream);
    recycleStream = device->GetNextRecycleStream();
    EXPECT_EQ(recycleStream, nullptr);

    delete stream;
    delete device;
}

TEST_F(CloudV2DeviceTest, message_queue_add_repeat_test)
{
    RawDevice *device = new RawDevice(0);
    device->Init();
    EXPECT_NE(device->messageQueue_, nullptr);
    Stream *stream = new Stream(device, 0);

    device->AddStreamToMessageQueue(stream);
    device->AddStreamToMessageQueue(stream);
    Stream *recycleStream = device->GetNextRecycleStream();
    EXPECT_EQ(recycleStream, stream);

    device->DelStreamFromMessageQueue(stream);

    recycleStream = device->GetNextRecycleStream();
    EXPECT_EQ(recycleStream, nullptr);

    delete stream;
    delete device;
}

TEST_F(CloudV2DeviceTest, message_queue_null_test)
{
    RawDevice *device = new RawDevice(0);
    device->Init();
    Stream *stream = new Stream(device, 0);

    MOCKER(mmSemPost).stubs().will(returnValue(0));
    device->AddStreamToMessageQueue(stream);
    Stream *recycleStream = device->GetNextRecycleStream();
    EXPECT_NE(recycleStream, nullptr);

    device->DelStreamFromMessageQueue(stream);

    delete stream;
    delete device;
}

TEST_F(CloudV2DeviceTest, CtrlResEntrySetupFailTest)
{
    MOCKER_CPP(&CtrlResEntry::Init)
        .stubs()
        .will(returnValue(RT_ERROR_MEMORY_ALLOCATION));
    RawDevice *device = new RawDevice(1);
    device->CtrlResEntrySetup();
    EXPECT_EQ(device->ctrlRes_, nullptr);
    DELETE_O(device);
}

TEST_F(CloudV2DeviceTest, CtrlResEntryInitFailTest)
{
    uint8_t stub;
    RawDevice *device = new RawDevice(1);
    device->Init();
    device->ctrlRes_ = new (std::nothrow) CtrlResEntry();
    device->ctrlRes_->taskBaseAddr_ = new uint8_t[1];
    const rtError_t error = device->ctrlRes_->Init(device);
    EXPECT_EQ(error, RT_ERROR_NONE);
    DELETE_O(device->ctrlRes_);
    DELETE_O(device);
}

TEST_F(CloudV2DeviceTest, CtrlStreamSetupTest)
{
    RawDevice *device = new RawDevice(1);
    device->Init();
    device->ctrlRes_ = new (std::nothrow) CtrlResEntry();
    device->ctrlRes_->Init(device);
    device->CtrlStreamSetup();
    EXPECT_NE(device->ctrlStream_, nullptr);
    DELETE_O(device->ctrlRes_);
    DELETE_O(device);
}
TEST_F(CloudV2DeviceTest, CtrlStreamFailSetupTest)
{
    RawDevice *device = new RawDevice(1);
    device->CtrlStreamSetup();
    EXPECT_EQ(device->ctrlStream_, nullptr);
    DELETE_O(device);
}

TEST_F(CloudV2DeviceTest, STARS_CORE_FFTSPLUS_0)
{
    rtSetDevice(0);
    rtStream_t stream = nullptr;
    rtError_t error = rtStreamCreate(&stream, 0);
    TaskInfo fftsPlusTask = {};
    InitByStream(&fftsPlusTask, (Stream *)stream);
    fftsPlusTask.id = 0;

    Device* device = ((Runtime *)Runtime::Instance())->DeviceRetain(0, 0);
    DeviceErrorProc *errorProc = new DeviceErrorProc(device);
    errorProc->SetRealFaultTaskPtr(&fftsPlusTask);
    DevRingBufferCtlInfo *ctlInfo  = (DevRingBufferCtlInfo *)malloc(DEVICE_ERROR_EXT_RINGBUFFER_SIZE);
    memset_s(ctlInfo, DEVICE_ERROR_EXT_RINGBUFFER_SIZE, 0, DEVICE_ERROR_EXT_RINGBUFFER_SIZE);
    if (ctlInfo != nullptr) {
        ctlInfo->tail = 1;
        ctlInfo->head = 0;
        ctlInfo->magic = RINGBUFFER_MAGIC;
        ctlInfo->ringBufferLen  = RINGBUFFER_LEN;
        uint64_t oneElementLen = sizeof(StarsDeviceErrorInfo) + sizeof(RingBufferElementInfo);
        uintptr_t infoAddr = reinterpret_cast<uintptr_t>(ctlInfo) +
                             sizeof(DevRingBufferCtlInfo) +
                             ctlInfo->head * oneElementLen;
        RingBufferElementInfo *info = (RingBufferElementInfo *)infoAddr;
        StarsDeviceErrorInfo *errorInfo = reinterpret_cast<StarsDeviceErrorInfo *>(info + 1);
        info->errorType = FFTS_PLUS_AICORE_ERROR;
        errorInfo->u.coreErrorInfo.comm.type = FFTS_PLUS_AICORE_ERROR;
        errorInfo->u.coreErrorInfo.comm.coreNum = 1;
        errorInfo->u.coreErrorInfo.comm.streamId = ((Stream *)stream)->Id_();
        errorInfo->u.coreErrorInfo.comm.taskId = fftsPlusTask.id;
        errorInfo->u.coreErrorInfo.info[0].coreId = 1;
        errorInfo->u.coreErrorInfo.info[0].fsmCxtId = 0x6;
        errorInfo->u.coreErrorInfo.info[0].fsmThreadId = 0x6;
        rtError_t error = errorProc->ProcessStarsOneElementInRingBuffer(ctlInfo, 0, 1);
        EXPECT_EQ(error, RT_ERROR_NONE);
        info->errorType = FFTS_PLUS_AIVECTOR_ERROR;
        errorInfo->u.coreErrorInfo.comm.type = FFTS_PLUS_AIVECTOR_ERROR;
        errorInfo->u.coreErrorInfo.comm.coreNum = 1;
        errorInfo->u.coreErrorInfo.comm.streamId = ((Stream *)stream)->Id_();
        errorInfo->u.coreErrorInfo.comm.taskId = fftsPlusTask.id;
        errorInfo->u.coreErrorInfo.info[0].coreId = 1;
        errorInfo->u.coreErrorInfo.info[0].fsmCxtId = 0x6;
        errorInfo->u.coreErrorInfo.info[0].fsmThreadId = 0x6;
        error = errorProc->ProcessStarsOneElementInRingBuffer(ctlInfo, 0, 1);
        EXPECT_EQ(error, RT_ERROR_NONE);
        free(ctlInfo);
        ctlInfo = nullptr;
    }

    errorProc->deviceRingBufferAddr_ = nullptr;
    delete errorProc;
    rtStreamDestroy(stream);
    ((Runtime *)Runtime::Instance())->DeviceRelease(device);
    rtDeviceReset(0);
}

TEST_F(CloudV2DeviceTest, STARS_CORE_FFTSPLUS_1)
{
    rtSetDevice(0);
    rtStream_t stream = nullptr;
    rtError_t error = rtStreamCreate(&stream, 0);
    TaskInfo fftsPlusTask = {};
    InitByStream(&fftsPlusTask, (Stream *)stream);
    fftsPlusTask.id = 0;

    Device* device = ((Runtime *)Runtime::Instance())->DeviceRetain(0, 0);
    DeviceErrorProc *errorProc = new DeviceErrorProc(device);
    errorProc->SetRealFaultTaskPtr(&fftsPlusTask);
    DevRingBufferCtlInfo *ctlInfo  = (DevRingBufferCtlInfo *)malloc(DEVICE_ERROR_EXT_RINGBUFFER_SIZE);
    memset_s(ctlInfo, DEVICE_ERROR_EXT_RINGBUFFER_SIZE, 0, DEVICE_ERROR_EXT_RINGBUFFER_SIZE);
    if (ctlInfo != nullptr) {
        ctlInfo->tail = 1;
        ctlInfo->head = 0;
        ctlInfo->magic = RINGBUFFER_MAGIC;
        ctlInfo->ringBufferLen  = RINGBUFFER_LEN;
        uint64_t oneElementLen = sizeof(StarsDeviceErrorInfo) + sizeof(RingBufferElementInfo);
        uintptr_t infoAddr = reinterpret_cast<uintptr_t>(ctlInfo) +
                             sizeof(DevRingBufferCtlInfo) +
                             ctlInfo->head * oneElementLen;
        RingBufferElementInfo *info = (RingBufferElementInfo *)infoAddr;
        StarsDeviceErrorInfo *errorInfo = reinterpret_cast<StarsDeviceErrorInfo *>(info + 1);
        info->errorType = FFTS_PLUS_SDMA_ERROR;
        errorInfo->u.sdmaErrorInfo.comm.type = FFTS_PLUS_SDMA_ERROR;
        errorInfo->u.sdmaErrorInfo.comm.coreNum = 1;
        errorInfo->u.sdmaErrorInfo.comm.streamId = ((Stream *)stream)->Id_();
        errorInfo->u.sdmaErrorInfo.comm.taskId = fftsPlusTask.id;
        errorInfo->u.sdmaErrorInfo.sdma.fftsPlusInfo[0].sdmaChannelId = 1;
        errorInfo->u.sdmaErrorInfo.sdma.fftsPlusInfo[0].sdmaCxtid = 0x6;
        errorInfo->u.sdmaErrorInfo.sdma.fftsPlusInfo[0].sdmaThreadid = 0x6;
        rtError_t error = errorProc->ProcessStarsOneElementInRingBuffer(ctlInfo, 0, 1);
        EXPECT_EQ(error, RT_ERROR_NONE);
        info->errorType = FFTS_PLUS_AICPU_ERROR;
        errorInfo->u.aicpuErrorInfo.comm.type = FFTS_PLUS_AICPU_ERROR;
        errorInfo->u.aicpuErrorInfo.comm.coreNum = 1;
        errorInfo->u.aicpuErrorInfo.comm.streamId = ((Stream *)stream)->Id_();
        errorInfo->u.aicpuErrorInfo.comm.taskId = fftsPlusTask.id;
        errorInfo->u.aicpuErrorInfo.aicpu.info[0].aicpuCxtid = 0x6;
        errorInfo->u.aicpuErrorInfo.aicpu.info[0].aicpuThreadid = 0x6;
        error = errorProc->ProcessStarsOneElementInRingBuffer(ctlInfo, 0, 1);
        EXPECT_EQ(error, RT_ERROR_NONE);
        free(ctlInfo);
        ctlInfo = nullptr;
    }

    errorProc->deviceRingBufferAddr_ = nullptr;
    delete errorProc;
    rtStreamDestroy(stream);
    ((Runtime *)Runtime::Instance())->DeviceRelease(device);
    rtDeviceReset(0);
}

TEST_F(CloudV2DeviceTest, STARS_CORE_FFTSPLUS_2)
{
    rtSetDevice(0);
    rtStream_t stream = nullptr;
    rtError_t error = rtStreamCreate(&stream, 0);
    TaskInfo fftsPlusTask = {};
    InitByStream(&fftsPlusTask, (Stream *)stream);
    fftsPlusTask.id = 0;

    Device* device = ((Runtime *)Runtime::Instance())->DeviceRetain(0, 0);
    DeviceErrorProc *errorProc = new DeviceErrorProc(device);
    errorProc->SetRealFaultTaskPtr(&fftsPlusTask);
    DevRingBufferCtlInfo *ctlInfo  = (DevRingBufferCtlInfo *)malloc(DEVICE_ERROR_EXT_RINGBUFFER_SIZE);
    memset_s(ctlInfo, DEVICE_ERROR_EXT_RINGBUFFER_SIZE, 0, DEVICE_ERROR_EXT_RINGBUFFER_SIZE);
    if (ctlInfo != nullptr) {
        ctlInfo->tail = 1;
        ctlInfo->head = 0;
        ctlInfo->magic = RINGBUFFER_MAGIC;
        ctlInfo->ringBufferLen  = RINGBUFFER_LEN;
        uint64_t oneElementLen = sizeof(StarsDeviceErrorInfo) + sizeof(RingBufferElementInfo);
        uintptr_t infoAddr = reinterpret_cast<uintptr_t>(ctlInfo) +
                             sizeof(DevRingBufferCtlInfo) +
                             ctlInfo->head * oneElementLen;
        RingBufferElementInfo *info = (RingBufferElementInfo *)infoAddr;
        StarsDeviceErrorInfo *errorInfo = reinterpret_cast<StarsDeviceErrorInfo *>(info + 1);
        info->errorType = FFTS_PLUS_DSA_ERROR;
        errorInfo->u.dsaErrorInfo.type = FFTS_PLUS_DSA_ERROR;
        errorInfo->u.dsaErrorInfo.coreNum = 1;
        errorInfo->u.dsaErrorInfo.info[0].ctxId = 0x6;
        errorInfo->u.dsaErrorInfo.info[0].threadId = 0x6;
        rtError_t error = errorProc->ProcessStarsOneElementInRingBuffer(ctlInfo, 0, 1);
        EXPECT_EQ(error, RT_ERROR_NONE);
        free(ctlInfo);
        ctlInfo = nullptr;
    }

    errorProc->deviceRingBufferAddr_ = nullptr;
    delete errorProc;
    rtStreamDestroy(stream);
    ((Runtime *)Runtime::Instance())->DeviceRelease(device);
    rtDeviceReset(0);
}

TEST_F(CloudV2DeviceTest, AddAddrKernelNameMapTableTest)
{
    RawDevice dev(0);
    dev.Init();
    dev.platformConfig_ = 0x500;
    rtAddrKernelName_t mapInfo;
    mapInfo.addr = 0;
    mapInfo.kernelName = "testKernel";
    dev.AddAddrKernelNameMapTable(mapInfo);
    string ret = dev.LookupKernelNameByAddr(1);
    EXPECT_EQ(ret, "not found kernel name");
    ret = dev.LookupKernelNameByAddr(0);
    EXPECT_EQ(ret, "testKernel");
}

TEST_F(CloudV2DeviceTest, AddAddrBinHandleTableTest)
{
    RawDevice dev(0);
    dev.Init();
    dev.AddAddrBinHandleMapTable(0, (void *)0x10);
    auto ret = dev.LookupBinHandleByAddr(1);
    EXPECT_EQ(ret, nullptr);
    ret = dev.LookupBinHandleByAddr(0);
    EXPECT_EQ(ret, (void *)0x10);
}

uint32_t g_printType = 0;
rtError_t MemCopySyncStub0(Driver *drv, void *dst, uint64_t destMax, const void *src, uint64_t size, rtMemcpyKind_t kind)
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

TEST_F(CloudV2DeviceTest, Eventid_FreeEventIdFromDrv)
{
    RawDevice *stub = new RawDevice(0);
    stub->platformType_ = PLATFORM_910B1;
    NpuDriver drv;
    stub->driver_ = &drv;
    MOCKER_CPP_VIRTUAL(drv, &NpuDriver::NotifyIdFree).stubs().will(returnValue(RT_ERROR_NONE));
    rtError_t error = stub->FreeEventIdFromDrv(0, RT_EVENT_MC2);
    EXPECT_EQ(error, RT_ERROR_NONE);
    delete stub;
}

TEST_F(CloudV2DeviceTest, AllocSimtStackPhyBase)
{
    rtError_t error;
    int32_t devId = 1;
    RawDevice *device = new RawDevice(1);
    device->Init();

    MOCKER_CPP_VIRTUAL(device->engine_, &Engine::Start)
        .stubs()
        .will(returnValue(RT_ERROR_INVALID_VALUE));
    device->Start();

    error = device->AllocSimtStackPhyBase(CHIP_910_B_93);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = device->AllocSimtStackPhyBase(CHIP_910_B_93);
    EXPECT_EQ(error, RT_ERROR_NONE);

    device->Stop();

    delete device;
}

rtError_t StubStart(RawDevice *device)
{
    device->deviceErrorProc_ = new (std::nothrow) DeviceErrorProc(device);
}

uint32_t g_case_num = 0;
uint32_t g_streamId = 0;
rtError_t MemCopySyncForRingBuffer(Driver *drv, void *dst, uint64_t destMax, const void *src, uint64_t size, rtMemcpyKind_t kind)
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

rtError_t MemCopySyncStub(Driver *drv, void *dst, uint64_t destMax, const void *src, uint64_t size, rtMemcpyKind_t kind)
{
    memcpy_s(dst, destMax, src, size);
    return DRV_ERROR_NONE;
}

TEST_F(CloudV2DeviceTest, TschStreamTest)
{
    RawDevice dev(0);
    dev.Init();
    rtError_t ret = dev.TschStreamAllocDsaAddr();
    EXPECT_EQ(ret, RT_ERROR_NONE);
    dev.platformConfig_ = 0x500;
    MOCKER_CPP_VIRTUAL(*(dev.Driver_()),&Driver::LogicCqAllocate)
        .stubs()
        .will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL(*(dev.Driver_()),&Driver::CtrlSqCqAllocate)
        .stubs()
        .will(returnValue(RT_ERROR_NONE));
    dev.TschStreamSetup();
    dev.TschStreamAllocDsaAddr();
}

TEST_F(CloudV2DeviceTest, DevInvalidParamTest)
{
    RawDevice dev(0);
    dev.ModuleAlloc(nullptr);
    dev.ModuleRelease(nullptr);
    // dev 析构会释放deviceErrorProc_
    dev.deviceErrorProc_ = new (std::nothrow) DeviceErrorProc(nullptr);
    dev.IsPrintStreamTimeoutSnapshot();
    dev.PrintStreamTimeoutSnapshotInfo();
    dev.GetSnapshotAddr();
    dev.GetSnapshotLen();
    EXPECT_EQ(dev.ModuleRetain(nullptr), false);
}

TEST_F(CloudV2DeviceTest, SetCurGroupInfoTest)
{
    RawDevice dev(0);
    dev.Init();
    MOCKER_CPP_VIRTUAL(dev, &RawDevice::GetDevRunningState).stubs().will(returnValue(0U));
 
    dev.deviceErrorProc_ = new (std::nothrow) DeviceErrorProc(nullptr);  
    MOCKER_CPP(&DeviceErrorProc::SendTaskToStopUseRingBuffer)
        .stubs()
        .will(returnValue(RT_ERROR_DEVICE_NULL));
    rtError_t error = dev.SetCurGroupInfo();
    EXPECT_EQ(error, RT_ERROR_DEVICE_NULL);
}

TEST_F(CloudV2DeviceTest, WriteDevString)
{
    RawDevice dev(0);
    dev.Init();

    const size_t size = 128U;
    char dest[size] = { 0 };
    const rtError_t error = dev.WriteDevString(dest, size, "ABC");
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(CloudV2DeviceTest, WriteDevString_MemSetSync_error)
{
    RawDevice dev(0);
    dev.Init();

    MOCKER(drvMemsetD8)
        .stubs()
        .will(returnValue(DRV_ERROR_INVALID_VALUE));
    const size_t size = 128U;
    char dest[size] = { 0 };
    const rtError_t error = dev.WriteDevString(dest, size, "ABC");
    EXPECT_EQ(error, RT_ERROR_DRV_INPUT);
}

TEST_F(CloudV2DeviceTest, WriteDevValue)
{
    RawDevice dev(0);
    dev.Init();

    uint32_t data = 8U;
    uint32_t result = 0;
    const rtError_t error = dev.WriteDevValue(&result, sizeof(uint32_t), &data);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(CloudV2DeviceTest, WriteDevValue_MemSetSync_error)
{
    RawDevice dev(0);
    dev.Init();

    MOCKER(drvMemsetD8)
        .stubs()
        .will(returnValue(DRV_ERROR_INVALID_VALUE));
    uint32_t data = 8U;
    uint32_t result = 0;
    const rtError_t error = dev.WriteDevValue(&result, sizeof(uint32_t), &data);
    EXPECT_EQ(error, RT_ERROR_DRV_INPUT);
}

TEST_F(CloudV2DeviceTest, InitDeviceSqCqpool)
{
    RawDevice *device = new RawDevice(0);
    device->Init();
 
    DeviceSqCqPool *deviceSqCqPool = device->GetDeviceSqCqManage();
 
    uint32_t allcocNum = 1U;
    rtDeviceSqCqInfo_t sqCqList = {};
    deviceSqCqPool->PreAllocSqCq();

    rtError_t ret = deviceSqCqPool->AllocSqCq(0U, &sqCqList);
    EXPECT_NE(ret, RT_ERROR_NONE);

    ret = deviceSqCqPool->AllocSqCq(allcocNum, &sqCqList);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    allcocNum = 2U;
    rtDeviceSqCqInfo_t sqCqList2[2] = {};
    ret = deviceSqCqPool->AllocSqCq(allcocNum, &sqCqList2[0]);
    EXPECT_EQ(ret, RT_ERROR_NONE);
 
    ret = deviceSqCqPool->FreeSqCqLazy(&sqCqList2[0], 2);
    EXPECT_EQ(ret, RT_ERROR_NONE);
 
    sqCqList2[0].sqId = 1U;
    sqCqList2[0].cqId = 2U;
    sqCqList2[1].sqId = 3U;
    sqCqList2[1].cqId = 4U;
    ret = deviceSqCqPool->FreeSqCqLazy(&sqCqList2[0], 0U);
    EXPECT_NE(ret, RT_ERROR_NONE);
 
    ret = deviceSqCqPool->AllocSqCq(allcocNum, &sqCqList2[0]);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    ret = deviceSqCqPool->FreeSqCqImmediately(&sqCqList2[0], 2U);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    delete device;
}

TEST_F(CloudV2DeviceTest, AllocSqCqMemcpyFail)
{
    RawDevice *device = new RawDevice(0);
    device->Init();
 
    DeviceSqCqPool *deviceSqCqPool = device->GetDeviceSqCqManage();
 
    uint32_t allcocNum = 1U;
    rtDeviceSqCqInfo_t sqCqList = {};
    deviceSqCqPool->PreAllocSqCq();

    rtError_t ret = deviceSqCqPool->AllocSqCq(1U, &sqCqList);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    ret = deviceSqCqPool->FreeSqCqImmediately(&sqCqList, 1U);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    MOCKER_CPP_VIRTUAL((NpuDriver*)(device->Driver_()),&NpuDriver::NormalSqCqAllocate).stubs().will(returnValue(1));
    ret = deviceSqCqPool->AllocSqCq(1U, &sqCqList);
    EXPECT_NE(ret, RT_ERROR_NONE);

    delete device;
}

TEST_F(CloudV2DeviceTest, AllocSqCqDrvFail)
{
    RawDevice *device = new RawDevice(0);
    device->Init();
 
    DeviceSqCqPool *deviceSqCqPool = device->GetDeviceSqCqManage();
 
    uint32_t allcocNum = 1U;
    rtDeviceSqCqInfo_t sqCqList = {};
    deviceSqCqPool->PreAllocSqCq();

    MOCKER_CPP_VIRTUAL((NpuDriver*)(device->Driver_()),&NpuDriver::NormalSqCqAllocate).stubs().will(returnValue(1));
    rtError_t ret = deviceSqCqPool->AllocSqCqFromDrv(&sqCqList);
    EXPECT_NE(ret, RT_ERROR_NONE);

    ret = deviceSqCqPool->AllocSqCq(0U, &sqCqList);
    EXPECT_NE(ret, RT_ERROR_NONE);

    delete device;
}

TEST_F(CloudV2DeviceTest, GetSqRegVirtualAddrBySqidFail)
{
    RawDevice *device = new RawDevice(0);
    device->Init();
 
    DeviceSqCqPool *deviceSqCqPool = device->GetDeviceSqCqManage();
 
    MOCKER_CPP_VIRTUAL((NpuDriver*)(device->Driver_()),&NpuDriver::GetSqRegVirtualAddrBySqid).stubs().will(returnValue(1));
    uint32_t allcocNum = 1U;
    rtDeviceSqCqInfo_t sqCqList = {};
    rtError_t ret = deviceSqCqPool->AllocSqCq(allcocNum, &sqCqList);
    EXPECT_NE(ret, RT_ERROR_NONE);

    delete device;
}

TEST_F(CloudV2DeviceTest, SetSqRegVirtualAddrToDeviceTest)
{
    RawDevice *device = new RawDevice(0);
    device->Init();
 
    DeviceSqCqPool *deviceSqCqPool = device->GetDeviceSqCqManage();
 
    uint32_t allcocNum = 1U;
    rtDeviceSqCqInfo_t sqCqList = {};
    deviceSqCqPool->PreAllocSqCq();

    uint64_t sqRegVirtualAddr = 2U;
    rtError_t ret = deviceSqCqPool->SetSqRegVirtualAddrToDevice(1U, sqRegVirtualAddr);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    ret = deviceSqCqPool->GetSqCqPoolTotalResNum();
    EXPECT_EQ(ret, 1U);

    delete device;
}

TEST_F(CloudV2DeviceTest, GetSqCqPoolFreeResNum)
{
    RawDevice *device = new RawDevice(0);
    device->Init();
 
    DeviceSqCqPool *deviceSqCqPool = device->GetDeviceSqCqManage();
 
    uint32_t allcocNum = 1U;
    rtDeviceSqCqInfo_t sqCqList = {};
    deviceSqCqPool->PreAllocSqCq();

    rtError_t ret = deviceSqCqPool->GetSqCqPoolFreeResNum();
    EXPECT_EQ(ret, 1U);

    delete device;
}

TEST_F(CloudV2DeviceTest, TryFreeSqCqToDrv)
{
    RawDevice *device = new RawDevice(0);
    device->Init();
 
    DeviceSqCqPool *deviceSqCqPool = device->GetDeviceSqCqManage();
 
    uint32_t allcocNum = 1U;
    rtDeviceSqCqInfo_t sqCqList = {};
    deviceSqCqPool->PreAllocSqCq();

    rtError_t ret = deviceSqCqPool->GetSqCqPoolFreeResNum();
    EXPECT_EQ(ret, 1U);

    deviceSqCqPool->TryFreeSqCqToDrv();

    ret = deviceSqCqPool->GetSqCqPoolFreeResNum();
    EXPECT_EQ(ret, 0U);

    delete device;
}

TEST_F(CloudV2DeviceTest, StreamSetupTryAlloc)
{
    RawDevice *device = new RawDevice(0);
    device->Init();
    Stream *stream = new Stream(device, 0);

    DeviceSqCqPool *deviceSqCqPool = device->GetDeviceSqCqManage();
 
    uint32_t allcocNum = 1U;
    rtDeviceSqCqInfo_t sqCqList = {};
    deviceSqCqPool->PreAllocSqCq();

    MOCKER_CPP(&StreamSqCqManage::AllocStreamSqCq).stubs().will(returnValue(RT_ERROR_DRV_NO_RESOURCES));
    rtError_t ret = stream->Setup();
    ASSERT_EQ(ret, RT_ERROR_DRV_NO_RESOURCES);

    ret = deviceSqCqPool->GetSqCqPoolFreeResNum();
    EXPECT_EQ(ret, 0U);

    GlobalMockObject::verify();
    delete stream;
    delete device;
}

TEST_F(CloudV2DeviceTest, FreeSqCqFail)
{
    RawDevice *device = new RawDevice(0);
    device->Init();
 
    DeviceSqCqPool *deviceSqCqPool = device->GetDeviceSqCqManage();
 
    uint32_t allcocNum = 1U;
    rtDeviceSqCqInfo_t sqCqList = {};
    deviceSqCqPool->PreAllocSqCq();

    rtError_t ret = deviceSqCqPool->AllocSqCq(allcocNum, &sqCqList);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    MOCKER_CPP_VIRTUAL((NpuDriver*)(device->Driver_()),&NpuDriver::NormalSqCqFree).stubs().will(returnValue(1U));
    ret = deviceSqCqPool->FreeSqCqLazy(&sqCqList, allcocNum);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    ret = deviceSqCqPool->AllocSqCq(allcocNum, &sqCqList);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    GlobalMockObject::verify();
    delete device;
}

TEST_F(CloudV2DeviceTest, SqAddrPoolAllocFail)
{
    RawDevice *device = new RawDevice(0);
    device->Init();
 
    SqAddrMemoryOrder *sqAddrMemoryManage = device->GetSqAddrMemoryManage();
    uint64_t *sqAddr = nullptr;

    MOCKER_CPP_VIRTUAL((NpuDriver*)(device->Driver_()),&NpuDriver::DevMemAlloc).stubs().will(returnValue(1U));
    rtError_t ret = sqAddrMemoryManage->AllocSqAddr(static_cast<SQ_ADDR_MEM_ORDER_TYPE>(11), &sqAddr);
    EXPECT_NE(ret, RT_ERROR_NONE);

    delete device;
}

TEST_F(CloudV2DeviceTest, SqAddrPoolAllocFree)
{
    RawDevice *device = new RawDevice(0);
    device->Init();
 
    SqAddrMemoryOrder *sqAddrMemoryManage = device->GetSqAddrMemoryManage();
    uint64_t *sqAddr = nullptr;
    rtError_t ret = sqAddrMemoryManage->AllocSqAddr(11U, &sqAddr);
    EXPECT_NE(ret, RT_ERROR_NONE);

    ret = sqAddrMemoryManage->AllocSqAddr(SQ_ADDR_MEM_ORDER_TYPE_32K, &sqAddr);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    ret = sqAddrMemoryManage->FreeSqAddr(sqAddr, SQ_ADDR_MEM_ORDER_TYPE_32K);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    ret = sqAddrMemoryManage->FreeSqAddr(sqAddr, 11U);
    EXPECT_NE(ret, RT_ERROR_NONE);

    ret = sqAddrMemoryManage->FreeSqAddr(reinterpret_cast<uint64_t *>(static_cast<uintptr_t>(0x1234)), 11U);
    EXPECT_NE(ret, RT_ERROR_NONE);

    delete device;
}

TEST_F(CloudV2DeviceTest, SqAddrPoolAllocFreeException)
{
    RawDevice *device = new RawDevice(0);
    device->Init();
 
    SqAddrMemoryOrder *sqAddrMemoryManage = device->GetSqAddrMemoryManage();
    uint64_t *sqAddr = nullptr;
    uint32_t ret = sqAddrMemoryManage->GetMemOrderSizeByMemOrderType(11U);
    EXPECT_NE(ret, RT_ERROR_NONE);

    ret = sqAddrMemoryManage->GetMemOrderSizeByMemOrderType(SQ_ADDR_MEM_ORDER_TYPE_32K);
    EXPECT_EQ(ret, 32U * 1024U);

    ret = sqAddrMemoryManage->GetMemOrderTypeByMemSize(32U * 1024U);
    EXPECT_EQ(ret, SQ_ADDR_MEM_ORDER_TYPE_32K);

    ret = sqAddrMemoryManage->GetMemOrderTypeByMemSize(2U * 1024U * 1024U + 1U);
    EXPECT_EQ(ret, cce::runtime::SQ_ADDR_MEM_ORDER_TYPE_MAX);

    delete device;
}

TEST_F(CloudV2DeviceTest, ResourceTest)
{
    RawDevice *device = new RawDevice(0);
    device->Init();
    device->InsertResInit(RT_DEV_RES_CUBE_CORE, 2);
    uint32_t ret = device->GetResInitValue(RT_DEV_RES_CUBE_CORE);
    EXPECT_EQ(ret, 2);

    device->InsertResLimit(RT_DEV_RES_CUBE_CORE, 48);
    ret = device->GetResValue(RT_DEV_RES_CUBE_CORE);
    EXPECT_EQ(ret, 48);

    device->ResetResLimit();
    ret = device->GetResValue(RT_DEV_RES_CUBE_CORE);
    EXPECT_EQ(ret, 2);

    delete device;
}

TEST_F(CloudV2DeviceTest, InitResource_01)
{
    RawDevice *device = new RawDevice(0);
    device->Init();

    int64_t value;
    uint32_t ret;
    MOCKER_CPP(&fe::PlatformInfoManager::InitRuntimePlatformInfos).stubs().will(returnValue(1));
    device->InitResource();

    delete device;
}

TEST_F(CloudV2DeviceTest, InitResource_02)
{
    RawDevice *device = new RawDevice(0);
    device->Init();

    int64_t value;
    uint32_t ret;
    uint32_t retValue = 0;
    MOCKER_CPP(&fe::PlatformInfoManager::InitRuntimePlatformInfos).stubs().will(returnValue(retValue));
    MOCKER_CPP(&fe::PlatformInfoManager::GetRuntimePlatformInfosByDevice).stubs().will(returnValue(1));
    device->InitResource();

    delete device;
}

TEST_F(CloudV2DeviceTest, InitResource_03)
{
    RawDevice *device = new RawDevice(0);
    device->Init();

    int64_t value;
    uint32_t ret;
    uint32_t retValue = 0;
    std::map<std::string, std::string> res = {{"ai_core_cnt", "@@@@"}};
    MOCKER_CPP(&fe::PlatformInfoManager::InitRuntimePlatformInfos).stubs().will(returnValue(retValue));
    MOCKER_CPP(&fe::PlatformInfoManager::GetRuntimePlatformInfosByDevice).stubs().will(returnValue((uint32_t)0));
    MOCKER_CPP(&fe::PlatFormInfos::GetPlatformResWithLock,
        bool(fe::PlatFormInfos::*)(const std::string &label, std::map<std::string, std::string> &res))
        .stubs()
        .will(returnValue(false));
        device->InitResource();

    delete device;
}

TEST_F(CloudV2DeviceTest, InitResource_04)
{
    RawDevice *device = new RawDevice(0);
    device->Init();

    int64_t value;
    uint32_t ret;
    uint32_t retValue = 0;
    std::map<std::string, std::string> res = {{"ai_core_cnt", "@@@@"}};
    MOCKER_CPP(&fe::PlatformInfoManager::InitRuntimePlatformInfos).stubs().will(returnValue(retValue));
    MOCKER_CPP(&fe::PlatformInfoManager::GetRuntimePlatformInfosByDevice).stubs().will(returnValue((uint32_t)0));
    MOCKER_CPP(&fe::PlatFormInfos::GetPlatformResWithLock,
        bool(fe::PlatFormInfos::*)(const std::string &label, std::map<std::string, std::string> &res))
        .stubs()
        .will(returnValue(true));
    device->InitResource();

    delete device;
}

TEST_F(CloudV2DeviceTest, IllegalResType)
{
    RawDevice *device = new RawDevice(0);
    device->Init();
    device->InsertResInit(RT_DEV_RES_TYPE_MAX, 0);
    device->InsertResLimit(RT_DEV_RES_TYPE_MAX, 0);
    uint32_t ret = device->GetResValue(RT_DEV_RES_TYPE_MAX);
    EXPECT_EQ(ret, 0);
    ret = device->GetResInitValue(RT_DEV_RES_TYPE_MAX);
    EXPECT_EQ(ret, 0);

    delete device;
}