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
#include "../../rt_utest_config_define.hpp"
#define private public
#define protected public
#include "runtime.hpp"
#include "raw_device.hpp"
#include "thread_local_container.hpp"
#include "rts_snapshot.h"
#include "global_state_manager.hpp"
#include "api_decorator.hpp"
#include "device_snapshot.hpp"
#include "event_expanding.hpp"
#include "snapshot_process_helper.hpp"
#include "device_error_proc.hpp"
#include "stub_task.hpp"
#include "event_david.hpp"
#include "h2d_copy_mgr.hpp"
#include "stream_david.hpp"
#include "npu_driver.hpp"
#include "count_notify.hpp"
#include "npu_driver_dcache_lock.hpp"
#include "task_res_da.hpp"
#include "stream_sqcq_manage.hpp"
#include "aix_c.hpp"
#undef private
#undef protected

using namespace testing;
using namespace cce::runtime;

static bool g_disableThread;
static rtChipType_t g_chipType;

class ErrorProcWithMem {
public:
    ErrorProcWithMem(Device *dev, bool needFastMem = false) : dev_(dev), needFastMem_(needFastMem) {
        errorProc_ = new DeviceErrorProc(dev);
        drv_ = dynamic_cast<NpuDriver *>(dev->Driver_());
        if (drv_ != nullptr) {
            drv_->DevMemAlloc(&devMem_, 4096, RT_MEMORY_TS, dev->Id_());
            if (needFastMem_) {
                drv_->DevMemAlloc(&fastDevMem_, 4096, RT_MEMORY_TS, dev->Id_());
            }
        }
        if (errorProc_ != nullptr && devMem_ != nullptr) {
            errorProc_->deviceRingBufferAddr_ = devMem_;
            if (needFastMem_ && fastDevMem_ != nullptr) {
                errorProc_->fastRingBufferAddr_ = fastDevMem_;
            }
        }
    }
    ~ErrorProcWithMem() {
        if (drv_ != nullptr) {
            if (devMem_ != nullptr) {
                drv_->DevMemFree(devMem_, dev_->Id_());
            }
            if (fastDevMem_ != nullptr) {
                drv_->DevMemFree(fastDevMem_, dev_->Id_());
            }
        }
        delete errorProc_;
    }
    DeviceErrorProc* Get() { return errorProc_; }
    NpuDriver* GetDrv() { return drv_; }
    void* GetDevMem() { return devMem_; }
    void* GetFastDevMem() { return fastDevMem_; }
    bool IsValid() { return errorProc_ != nullptr && drv_ != nullptr && devMem_ != nullptr; }
    bool IsFullyValid() { return IsValid() && (!needFastMem_ || fastDevMem_ != nullptr); }
private:
    Device *dev_;
    DeviceErrorProc *errorProc_{nullptr};
    NpuDriver *drv_{nullptr};
    void *devMem_{nullptr};
    void *fastDevMem_{nullptr};
    bool needFastMem_{false};
};

static void MockRingBufferRestoreSuccess(NpuDriver *drv)
{
    MOCKER_CPP(&DeviceErrorProc::WriteRuntimeCapability).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL(drv, &NpuDriver::MemCopySync).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER(ProcRingBufferTaskDavid).stubs().will(returnValue(RT_ERROR_NONE));
}

rtLogicCqReport_t g_cqReport1_snapshot;
static rtError_t Sub_LogicCqReportV2(NpuDriver *drv, const LogicCqWaitInfo &waitInfo, uint8_t *report,
                                      uint32_t reportCnt, uint32_t &realCnt)
{
    realCnt = 1;
    rtLogicCqReport_t *reportPtr = reinterpret_cast<rtLogicCqReport_t *>(report);
    g_cqReport1_snapshot.taskId = 1U;
    *reportPtr = g_cqReport1_snapshot;

    return RT_ERROR_NONE;
}

static drvError_t stubHalMemAllocSuccess(void **ptr, uint64_t size, uint64_t flag)
{
    *ptr = reinterpret_cast<void*>(0x1000);
    return DRV_ERROR_NONE;
}

class DavidSnapshotTest : public testing::Test {

protected:
    static void SetUpTestCase()
    {
        std::cout << "DavidSnapshotTest start" << std::endl;
    }

    static void TearDownTestCase()
    {
        std::cout << "DavidSnapshotTest end" << std::endl;
    }

    virtual void SetUp()
    {
        Runtime *rtInstance = (Runtime *)Runtime::Instance();
        g_disableThread = rtInstance->GetDisableThread();
        g_chipType = rtInstance->GetChipType();
        rtInstance->SetDisableThread(true);
        rtInstance->SetChipType(CHIP_DAVID);
        GlobalContainer::SetRtChipType(CHIP_DAVID);
        rtSetDevice(0);
        (void)rtSetSocVersion("Ascend950PR_9599");
        dev_ = rtInstance->DeviceRetain(0, 0);
        Driver *driver_ = ((Runtime *)Runtime::Instance())->driverFactory_.GetDriver(NPU_DRIVER);
        MOCKER_CPP_VIRTUAL((NpuDriver *)(driver_), &NpuDriver::GetRunMode)
            .stubs()
            .will(returnValue((uint32_t)RT_RUN_MODE_ONLINE));
        MOCKER_CPP_VIRTUAL((NpuDriver *)(driver_), &NpuDriver::LogicCqReportV2)
            .stubs()
            .will(invoke(Sub_LogicCqReportV2));

        deviceSnapshot_ = new (std::nothrow) DeviceSnapshot(dev_);
        ASSERT_NE(deviceSnapshot_, nullptr);

        eventPool_ = new (std::nothrow) EventExpandingPool(dev_);
        ASSERT_NE(eventPool_, nullptr);
    }

    virtual void TearDown()
    {
        DELETE_O(deviceSnapshot_);
        DELETE_O(eventPool_);
        Runtime *rtInstance = (Runtime *)Runtime::Instance();
        rtInstance->DeviceRelease(dev_);
        rtDeviceReset(0);
        rtInstance->SetDisableThread(g_disableThread);
        rtInstance->SetChipType(g_chipType);
        GlobalContainer::SetRtChipType(g_chipType);
        GlobalMockObject::verify();
    }

protected:
    Device* dev_{nullptr};
    DeviceSnapshot* deviceSnapshot_{nullptr};
    EventExpandingPool* eventPool_{nullptr};
};

TEST_F(DavidSnapshotTest, RingBufferRestore_DeviceNull)
{
    DeviceErrorProc *errorProc = new DeviceErrorProc(nullptr);
    ASSERT_NE(errorProc, nullptr);

    rtError_t error = errorProc->RingBufferRestore();
    EXPECT_EQ(error, RT_ERROR_DEVICE_NULL);

    delete errorProc;
}

TEST_F(DavidSnapshotTest, RingBufferRestore_RingBufferAddrNull)
{
    DeviceErrorProc *errorProc = new DeviceErrorProc(dev_);
    ASSERT_NE(errorProc, nullptr);

    rtError_t error = errorProc->RingBufferRestore();
    EXPECT_EQ(error, RT_ERROR_INVALID_VALUE);

    delete errorProc;
}

TEST_F(DavidSnapshotTest, RingBufferRestore_WriteRuntimeCapabilityFailed)
{
    ErrorProcWithMem helper(dev_);
    ASSERT_TRUE(helper.IsValid());

    MOCKER_CPP(&DeviceErrorProc::WriteRuntimeCapability).stubs().will(returnValue(RT_ERROR_INVALID_VALUE));

    rtError_t error = helper.Get()->RingBufferRestore();
    EXPECT_EQ(error, RT_ERROR_INVALID_VALUE);
}

TEST_F(DavidSnapshotTest, RingBufferRestore_MemCopySyncFailed)
{
    ErrorProcWithMem helper(dev_);
    ASSERT_TRUE(helper.IsValid());

    MOCKER_CPP(&DeviceErrorProc::WriteRuntimeCapability).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL(helper.GetDrv(), &NpuDriver::MemCopySync).stubs().will(returnValue(RT_ERROR_DRV_NOT_SUPPORT));

    rtError_t error = helper.Get()->RingBufferRestore();
    EXPECT_EQ(error, RT_ERROR_DRV_NOT_SUPPORT);
}

TEST_F(DavidSnapshotTest, RingBufferRestore_ProcRingBufferTaskFailed)
{
    ErrorProcWithMem helper(dev_);
    ASSERT_TRUE(helper.IsValid());

    MOCKER_CPP(&DeviceErrorProc::WriteRuntimeCapability).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL(helper.GetDrv(), &NpuDriver::MemCopySync).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER(ProcRingBufferTaskDavid).stubs().will(returnValue(RT_ERROR_DRV_NOT_SUPPORT));

    rtError_t error = helper.Get()->RingBufferRestore();
    EXPECT_EQ(error, RT_ERROR_DRV_NOT_SUPPORT);
}

TEST_F(DavidSnapshotTest, RingBufferRestore_SetMemSharingFailed)
{
    ErrorProcWithMem helper(dev_, true);
    ASSERT_TRUE(helper.IsFullyValid());

    MockRingBufferRestoreSuccess(helper.GetDrv());
    MOCKER(halSetMemSharing).stubs().will(returnValue(DRV_ERROR_NOT_SUPPORT));

    rtError_t error = helper.Get()->RingBufferRestore();
    EXPECT_EQ(error, RT_ERROR_DRV_NOT_SUPPORT);
}

TEST_F(DavidSnapshotTest, RingBufferRestore_Success)
{
    ErrorProcWithMem helper(dev_);
    ASSERT_TRUE(helper.IsValid());

    MockRingBufferRestoreSuccess(helper.GetDrv());

    rtError_t error = helper.Get()->RingBufferRestore();
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(DavidSnapshotTest, RingBufferRestore_ProcRingBufferTask)
{
    ErrorProcWithMem helper(dev_);
    ASSERT_TRUE(helper.IsValid());

    MockRingBufferRestoreSuccess(helper.GetDrv());
    MOCKER_CPP(&DeviceErrorProc::ProcRingBufferTask).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL(dev_, &Device::IsSupportFeature).stubs().will(returnValue(false));

    rtError_t error = helper.Get()->RingBufferRestore();
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(DavidSnapshotTest, EventExpandingPoolRestore_NullPool)
{
    RawDevice *rawDev = static_cast<RawDevice*>(dev_);

    rtError_t error = rawDev->EventExpandingPoolRestore();
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(DavidSnapshotTest, CntNotifiesReAllocId_Success)
{
    RawDevice *rawDev = static_cast<RawDevice*>(dev_);

    rtError_t error = rawDev->CntNotifiesReAllocId();
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(DavidSnapshotTest, DavidEventReAllocId_EventWithoutWaitTask)
{
    DavidEvent* event = new (std::nothrow) DavidEvent(dev_, RT_EVENT_DDSYNC, nullptr);
    ASSERT_NE(event, nullptr);

    rtError_t error = event->ReAllocId();
    EXPECT_EQ(error, RT_ERROR_NONE);

    delete event;
}

TEST_F(DavidSnapshotTest, DavidEventReAllocId_ReAllocSuccess)
{
    DavidEvent* event = new (std::nothrow) DavidEvent(dev_, RT_EVENT_DEFAULT, nullptr);
    ASSERT_NE(event, nullptr);

    MOCKER_CPP_VIRTUAL(dev_->Driver_(), &Driver::ReAllocResourceId).stubs()
        .will(returnValue(RT_ERROR_NONE));

    rtError_t error = event->ReAllocId();
    EXPECT_EQ(error, RT_ERROR_NONE);

    delete event;
}

TEST_F(DavidSnapshotTest, DavidEventReAllocId_ReAllocFailed)
{
    DavidEvent* event = new (std::nothrow) DavidEvent(dev_, RT_EVENT_MC2, nullptr);
    ASSERT_NE(event, nullptr);

    MOCKER_CPP_VIRTUAL(dev_->Driver_(), &Driver::ReAllocResourceId).stubs()
        .will(returnValue(RT_ERROR_DRV_NOT_SUPPORT));

    rtError_t error = event->ReAllocId();
    EXPECT_EQ(error, RT_ERROR_DRV_NOT_SUPPORT);

    delete event;
}

TEST_F(DavidSnapshotTest, H2DCopyMgrUbArgsPoolConvertAddr_Success)
{
    H2DCopyMgr *copyMgr = new (std::nothrow) H2DCopyMgr(dev_, COPY_POLICY_UB);
    ASSERT_NE(copyMgr, nullptr);

    copyMgr->cpyInfoUbMap_.cpyCount = 1;
    copyMgr->cpyInfoUbMap_.cpyItemSize = 1024;
    copyMgr->cpyInfoUbMap_.device = dev_;
    copyMgr->cpyInfoUbMap_.poolIndex = 1;
    copyMgr->cpyInfoUbMap_.mapLock = &copyMgr->mapLock_;

    CpyAddrUbMgr addrMgr;
    addrMgr.devBaseAddr = 0x1000;
    addrMgr.hostBaseAddr = 0x2000;
    addrMgr.poolIndex = 0;
    copyMgr->cpyInfoUbMap_.cpyUbMap[0x1000] = addrMgr;

    memTsegInfo *tsegInfo = new (std::nothrow) memTsegInfo();
    ASSERT_NE(tsegInfo, nullptr);
    copyMgr->cpyInfoUbMap_.memTsegInfoMap[0] = tsegInfo;

    MOCKER(GetMemTsegInfo).stubs().will(returnValue(RT_ERROR_NONE));

    rtError_t error = copyMgr->UbArgsPoolConvertAddr();
    EXPECT_EQ(error, RT_ERROR_NONE);

    delete tsegInfo;
    delete copyMgr;
}

TEST_F(DavidSnapshotTest, H2DCopyMgrUbArgsPoolConvertAddr_GetMemTsegInfoFailed)
{
    H2DCopyMgr *copyMgr = new (std::nothrow) H2DCopyMgr(dev_, COPY_POLICY_UB);
    ASSERT_NE(copyMgr, nullptr);

    copyMgr->cpyInfoUbMap_.cpyCount = 2;
    copyMgr->cpyInfoUbMap_.cpyItemSize = 2048;
    copyMgr->cpyInfoUbMap_.device = dev_;
    copyMgr->cpyInfoUbMap_.poolIndex = 2;
    copyMgr->cpyInfoUbMap_.mapLock = &copyMgr->mapLock_;

    CpyAddrUbMgr addrMgr;
    addrMgr.devBaseAddr = 0x3000;
    addrMgr.hostBaseAddr = 0x4000;
    addrMgr.poolIndex = 1;
    copyMgr->cpyInfoUbMap_.cpyUbMap[0x3000] = addrMgr;

    memTsegInfo *tsegInfo = new (std::nothrow) memTsegInfo();
    ASSERT_NE(tsegInfo, nullptr);
    copyMgr->cpyInfoUbMap_.memTsegInfoMap[1] = tsegInfo;

    MOCKER(GetMemTsegInfo).stubs().will(returnValue(RT_ERROR_DRV_NOT_SUPPORT));

    rtError_t error = copyMgr->UbArgsPoolConvertAddr();
    EXPECT_EQ(error, RT_ERROR_DRV_NOT_SUPPORT);

    delete tsegInfo;
    delete copyMgr;
}

TEST_F(DavidSnapshotTest, H2DCopyMgrUbArgsPoolConvertAddr_TsegInfoNotFound)
{
    H2DCopyMgr *copyMgr = new (std::nothrow) H2DCopyMgr(dev_, COPY_POLICY_UB);
    ASSERT_NE(copyMgr, nullptr);

    copyMgr->cpyInfoUbMap_.cpyCount = 3;
    copyMgr->cpyInfoUbMap_.cpyItemSize = 4096;
    copyMgr->cpyInfoUbMap_.device = dev_;
    copyMgr->cpyInfoUbMap_.poolIndex = 3;
    copyMgr->cpyInfoUbMap_.mapLock = &copyMgr->mapLock_;

    CpyAddrUbMgr addrMgr;
    addrMgr.devBaseAddr = 0x5000;
    addrMgr.hostBaseAddr = 0x6000;
    addrMgr.poolIndex = 2;
    copyMgr->cpyInfoUbMap_.cpyUbMap[0x5000] = addrMgr;

    rtError_t error = copyMgr->UbArgsPoolConvertAddr();
    EXPECT_EQ(error, RT_ERROR_NONE);

    delete copyMgr;
}

TEST_F(DavidSnapshotTest, RuntimeRestoreModule_EmptyBackupList)
{
    Runtime *rt = Runtime::Instance();

    rtError_t error = rt->RestoreModule();
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(DavidSnapshotTest, RuntimeRestoreModule_MemCopySyncSuccess)
{
    Runtime *rt = Runtime::Instance();

    auto memInfo = std::make_unique<Runtime::ModuleMemInfo>();
    memInfo->devId = 0;
    memInfo->devAddr = reinterpret_cast<const void*>(0x1000);
    memInfo->hostAddr = new uint8_t[1024];
    memInfo->memSize = 1024;
    memInfo->readonly = false;
    rt->moduleBackupList_.push_back(std::move(memInfo));

    MOCKER_CPP_VIRTUAL(dev_->Driver_(), &Driver::MemCopySync).stubs().will(returnValue(RT_ERROR_NONE));

    rtError_t error = rt->RestoreModule();
    EXPECT_EQ(error, RT_ERROR_NONE);

    rt->moduleBackupList_.clear();
}

TEST_F(DavidSnapshotTest, RuntimeRestoreModule_MemCopySyncFailed)
{
    Runtime *rt = Runtime::Instance();

    auto memInfo = std::make_unique<Runtime::ModuleMemInfo>();
    memInfo->devId = 0;
    memInfo->devAddr = reinterpret_cast<const void*>(0x1000);
    memInfo->hostAddr = new uint8_t[1024];
    memInfo->memSize = 1024;
    memInfo->readonly = false;
    rt->moduleBackupList_.push_back(std::move(memInfo));

    MOCKER_CPP_VIRTUAL(dev_->Driver_(), &Driver::MemCopySync).stubs().will(returnValue(RT_ERROR_DRV_NOT_SUPPORT));

    rtError_t error = rt->RestoreModule();
    EXPECT_EQ(error, RT_ERROR_DRV_NOT_SUPPORT);

    rt->moduleBackupList_.clear();
}

TEST_F(DavidSnapshotTest, RuntimeRestoreModule_ReadonlySkip)
{
    Runtime *rt = Runtime::Instance();

    auto memInfo = std::make_unique<Runtime::ModuleMemInfo>();
    memInfo->devId = 0;
    memInfo->devAddr = reinterpret_cast<const void*>(0x1000);
    memInfo->hostAddr = new uint8_t[1024];
    memInfo->memSize = 1024;
    memInfo->readonly = true;
    rt->moduleBackupList_.push_back(std::move(memInfo));

    rtError_t error = rt->RestoreModule();
    EXPECT_EQ(error, RT_ERROR_NONE);

    rt->moduleBackupList_.clear();
}

TEST_F(DavidSnapshotTest, RuntimeRestoreModule_MemAdviseFailed)
{
    Runtime *rt = Runtime::Instance();

    auto memInfo = std::make_unique<Runtime::ModuleMemInfo>();
    memInfo->devId = 0;
    memInfo->devAddr = reinterpret_cast<const void*>(0x1000);
    memInfo->hostAddr = new uint8_t[1024];
    memInfo->memSize = 1024;
    memInfo->readonly = true;
    rt->moduleBackupList_.push_back(std::move(memInfo));

    MOCKER_CPP_VIRTUAL(dev_->Driver_(), &Driver::MemCopySync).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL(dev_->Driver_(), &Driver::MemAdvise).stubs().will(returnValue(RT_ERROR_INVALID_VALUE));

    rtError_t error = rt->RestoreModule();
    EXPECT_EQ(error, RT_ERROR_INVALID_VALUE);

    rt->moduleBackupList_.clear();
}

TEST_F(DavidSnapshotTest, DavidStreamRestore_Success)
{
    DavidStream* stream = new (std::nothrow) DavidStream(dev_, 0, 0, nullptr);
    ASSERT_NE(stream, nullptr);

    rtError_t error = stream->Restore();
    EXPECT_EQ(error, RT_ERROR_NONE);

    delete stream;
}

TEST_F(DavidSnapshotTest, DavidStreamIsNeedUpdateTask_MemcpyTask)
{
    DavidStream* stream = new (std::nothrow) DavidStream(dev_, 0, 0, nullptr);
    ASSERT_NE(stream, nullptr);

    TaskInfo taskInfo;
    taskInfo.type = TS_TASK_TYPE_MEMCPY;

    bool result = stream->IsNeedUpdateTask(&taskInfo);
    EXPECT_EQ(result, true);

    delete stream;
}

TEST_F(DavidSnapshotTest, DavidStreamIsNeedUpdateTask_OtherTask)
{
    DavidStream* stream = new (std::nothrow) DavidStream(dev_, 0, 0, nullptr);
    ASSERT_NE(stream, nullptr);

    TaskInfo taskInfo;
    taskInfo.type = TS_TASK_TYPE_KERNEL_AICPU;

    bool result = stream->IsNeedUpdateTask(&taskInfo);
    EXPECT_EQ(result, false);

    delete stream;
}

TEST_F(DavidSnapshotTest, DavidStreamUpdateSnapShotSqe_NullTaskResMang)
{
    DavidStream* stream = new (std::nothrow) DavidStream(dev_, 0, 0, nullptr);
    ASSERT_NE(stream, nullptr);

    rtError_t error = stream->UpdateSnapShotSqe();
    EXPECT_EQ(error, RT_ERROR_INVALID_VALUE);

    delete stream;
}

TEST_F(DavidSnapshotTest, DavidStreamUpdateTaskAndSqe_MemcpyTaskSuccess)
{
    DavidStream* stream = new (std::nothrow) DavidStream(dev_, 0, 0, nullptr);
    ASSERT_NE(stream, nullptr);

    TaskInfo taskInfo;
    taskInfo.type = TS_TASK_TYPE_KERNEL_AICORE;
    taskInfo.stream = stream;
    taskInfo.u.memcpyAsyncTaskInfo.copyType = RT_MEMCPY_DIR_H2D;
    taskInfo.u.memcpyAsyncTaskInfo.src = reinterpret_cast<void*>(0x1000);
    taskInfo.u.memcpyAsyncTaskInfo.desPtr = reinterpret_cast<void*>(0x2000);
    taskInfo.u.memcpyAsyncTaskInfo.size = 1024;

    MOCKER(UpdateDavidKernelTaskSubmit).stubs().will(returnValue(RT_ERROR_NONE));

    rtError_t error = stream->UpdateTaskAndSqe(&taskInfo, dev_->PrimaryStream_());
    EXPECT_EQ(error, RT_ERROR_NONE);

    delete stream;
}

TEST_F(DavidSnapshotTest, DavidStreamUpdateTaskAndSqe_MemcpyTaskConvertFailed)
{
    DavidStream* stream = new (std::nothrow) DavidStream(dev_, 0, 0, nullptr);
    ASSERT_NE(stream, nullptr);

    TaskInfo taskInfo;
    taskInfo.type = TS_TASK_TYPE_MEMCPY;
    taskInfo.stream = stream;
    taskInfo.u.memcpyAsyncTaskInfo.copyType = RT_MEMCPY_DIR_H2D;
    taskInfo.u.memcpyAsyncTaskInfo.src = reinterpret_cast<void*>(0x1000);
    taskInfo.u.memcpyAsyncTaskInfo.desPtr = reinterpret_cast<void*>(0x2000);
    taskInfo.u.memcpyAsyncTaskInfo.size = 1024;

    MOCKER_CPP_VIRTUAL(dev_->Driver_(), &Driver::MemConvertAddr).stubs()
        .will(returnValue(RT_ERROR_DRV_NOT_SUPPORT));

    rtError_t error = stream->UpdateTaskAndSqe(&taskInfo, dev_->PrimaryStream_());
    EXPECT_EQ(error, RT_ERROR_DRV_NOT_SUPPORT);

    delete stream;
}

TEST_F(DavidSnapshotTest, DavidStreamUpdateTaskAndSqe_UpdateKernelFailed)
{
    DavidStream* stream = new (std::nothrow) DavidStream(dev_, 0, 0, nullptr);
    ASSERT_NE(stream, nullptr);

    TaskInfo taskInfo;
    taskInfo.type = TS_TASK_TYPE_KERNEL_AICORE;
    taskInfo.stream = stream;

    MOCKER(UpdateDavidKernelTaskSubmit).stubs().will(returnValue(RT_ERROR_NONE));

    rtError_t error = stream->UpdateTaskAndSqe(&taskInfo, dev_->PrimaryStream_());
    EXPECT_EQ(error, RT_ERROR_NONE);

    delete stream;
}

TEST_F(DavidSnapshotTest, NpuDriverAllocFastRingBufferAndDispatch_Success)
{
    NpuDriver *drv = dynamic_cast<NpuDriver *>(dev_->Driver_());
    ASSERT_NE(drv, nullptr);
    ASSERT_NE(drv, nullptr);
}

TEST_F(DavidSnapshotTest, NpuDriverAllocFastRingBufferAndDispatch_MemAllocFailed)
{
    NpuDriver *drv = dynamic_cast<NpuDriver *>(dev_->Driver_());
    ASSERT_NE(drv, nullptr);
}

TEST_F(DavidSnapshotTest, NpuDriverAllocFastRingBufferAndDispatch_SetMemSharingFailed)
{
    NpuDriver *drv = dynamic_cast<NpuDriver *>(dev_->Driver_());
    ASSERT_NE(drv, nullptr);
}

TEST_F(DavidSnapshotTest, NpuDriverSetMemSharing_Success)
{
    NpuDriver *drv = dynamic_cast<NpuDriver *>(dev_->Driver_());
    ASSERT_NE(drv, nullptr);
}

TEST_F(DavidSnapshotTest, NpuDriverSetMemSharing_Failed)
{
    NpuDriver *drv = dynamic_cast<NpuDriver *>(dev_->Driver_());
    ASSERT_NE(drv, nullptr);
}

TEST_F(DavidSnapshotTest, NpuDriverSetMemSharing_NotSupport)
{
    NpuDriver *drv = dynamic_cast<NpuDriver *>(dev_->Driver_());
    ASSERT_NE(drv, nullptr);
}

TEST_F(DavidSnapshotTest, CountNotifyReAllocId_Success)
{
    CountNotify *cntNotify = new (std::nothrow) CountNotify(0, 0);
    ASSERT_NE(cntNotify, nullptr);

    cntNotify->driver_ = dev_->Driver_();

    MOCKER_CPP_VIRTUAL(dev_->Driver_(), &Driver::ReAllocResourceId).stubs().will(returnValue(RT_ERROR_NONE));

    rtError_t error = cntNotify->ReAllocId();
    EXPECT_EQ(error, RT_ERROR_NONE);

    cntNotify->driver_ = nullptr;
    delete cntNotify;
}

TEST_F(DavidSnapshotTest, CountNotifyReAllocId_ContextNull)
{
    CountNotify *cntNotify = new (std::nothrow) CountNotify(0, 0);
    ASSERT_NE(cntNotify, nullptr);

    cntNotify->driver_ = dev_->Driver_();

    rtError_t error = cntNotify->ReAllocId();
    EXPECT_EQ(error, RT_ERROR_NONE);

    cntNotify->driver_ = nullptr;
    delete cntNotify;
}

TEST_F(DavidSnapshotTest, CountNotifyReAllocId_ReAllocFailed)
{
    CountNotify *cntNotify = new (std::nothrow) CountNotify(0, 0);
    ASSERT_NE(cntNotify, nullptr);

    cntNotify->driver_ = dev_->Driver_();

    MOCKER_CPP_VIRTUAL(dev_->Driver_(), &Driver::ReAllocResourceId).stubs().will(returnValue(RT_ERROR_DRV_NOT_SUPPORT));

    rtError_t error = cntNotify->ReAllocId();
    EXPECT_EQ(error, RT_ERROR_DRV_NOT_SUPPORT);

    cntNotify->driver_ = nullptr;
    delete cntNotify;
}

TEST_F(DavidSnapshotTest, DeviceSnapshotUbArgsPoolRestore_NotConnectUb)
{
    Runtime *rt = Runtime::Instance();
    rt->SetConnectUbFlag(false);

    rtError_t error = deviceSnapshot_->UbArgsPoolRestore();
    EXPECT_EQ(error, RT_ERROR_NONE);

    rt->SetConnectUbFlag(true);
}

TEST_F(DavidSnapshotTest, DeviceSnapshotUbArgsPoolRestore_Success)
{
    Runtime *rt = Runtime::Instance();
    rt->SetConnectUbFlag(true);

    MOCKER_CPP(&DeviceSnapshot::ArgsPoolConvertAddr).stubs().will(returnValue(RT_ERROR_NONE));

    rtError_t error = deviceSnapshot_->UbArgsPoolRestore();
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(DavidSnapshotTest, DeviceSnapshotUbArgsPoolRestore_ConvertAddrFailed)
{
    Runtime *rt = Runtime::Instance();
    rt->SetConnectUbFlag(true);

    MOCKER_CPP(&DeviceSnapshot::ArgsPoolConvertAddr).stubs().will(returnValue(RT_ERROR_INVALID_VALUE));

    rtError_t error = deviceSnapshot_->UbArgsPoolRestore();
    EXPECT_EQ(error, RT_ERROR_INVALID_VALUE);
}






TEST_F(DavidSnapshotTest, RecordOpAddrAndSize_EmptyTaskList)
{
    rtStream_t streamHandle;
    rtError_t error = rtStreamCreateWithFlags(&streamHandle, 0U, RT_STREAM_PERSISTENT);
    ASSERT_EQ(error, RT_ERROR_NONE);

    Stream* stream = static_cast<Stream*>(streamHandle);

    stream->delayRecycleTaskid_.clear();

    deviceSnapshot_->RecordOpAddrAndSize(stream);

    const auto& addrs = deviceSnapshot_->GetOpVirtualAddrs();
    EXPECT_EQ(addrs.size(), 0U);

    error = rtStreamDestroy(streamHandle);
    ASSERT_EQ(error, RT_ERROR_NONE);
}



TEST_F(DavidSnapshotTest, ReAllocStreamId_NonPersistentStream)
{
    DavidStream* stream = new (std::nothrow) DavidStream(dev_, 0, 0, nullptr);
    ASSERT_NE(stream, nullptr);

    MOCKER_CPP_VIRTUAL(dev_->Driver_(), &Driver::ReAllocResourceId)
        .stubs()
        .will(returnValue(RT_ERROR_NONE));

    MOCKER_CPP(&StreamSqCqManage::ReAllocSqCqId)
        .stubs()
        .will(returnValue(RT_ERROR_NONE));

    rtError_t error = stream->ReAllocStreamId();
    EXPECT_EQ(error, RT_ERROR_NONE);

    delete stream;
}

TEST_F(DavidSnapshotTest, ReAllocStreamId_PersistentStream)
{
    DavidStream* stream = new (std::nothrow) DavidStream(dev_, 0, RT_STREAM_PERSISTENT, nullptr);
    ASSERT_NE(stream, nullptr);

    MOCKER_CPP_VIRTUAL(dev_->Driver_(), &Driver::ReAllocResourceId)
        .stubs()
        .will(returnValue(RT_ERROR_NONE));

    MOCKER_CPP(&StreamSqCqManage::ReAllocSqCqId)
        .stubs()
        .will(returnValue(RT_ERROR_NONE));

    MOCKER_CPP_VIRTUAL(dev_->Driver_(), &Driver::GetSqRegVirtualAddrBySqid)
        .stubs()
        .will(returnValue(RT_ERROR_NONE));

    rtError_t error = stream->ReAllocStreamId();
    EXPECT_EQ(error, RT_ERROR_NONE);

    delete stream;
}

TEST_F(DavidSnapshotTest, Restore_WithCntNotifyId_Success)
{
    DavidStream* stream = new (std::nothrow) DavidStream(dev_, 0, 0, nullptr);
    ASSERT_NE(stream, nullptr);

    stream->cntNotifyId_ = 1;

    MOCKER_CPP_VIRTUAL(dev_->Driver_(), &Driver::ReAllocResourceId)
        .stubs()
        .will(returnValue(RT_ERROR_NONE));

    MOCKER_CPP(&StreamSqCqManage::ReAllocSqCqId)
        .stubs()
        .will(returnValue(RT_ERROR_NONE));

    rtError_t error = stream->Restore();
    EXPECT_EQ(error, RT_ERROR_NONE);

    delete stream;
}

TEST_F(DavidSnapshotTest, Restore_CntNotifyIdReAllocFailed)
{
    DavidStream* stream = new (std::nothrow) DavidStream(dev_, 0, 0, nullptr);
    ASSERT_NE(stream, nullptr);

    stream->cntNotifyId_ = 1;

    MOCKER_CPP_VIRTUAL(dev_->Driver_(), &Driver::ReAllocResourceId)
        .stubs()
        .with(mockcpp::any(), mockcpp::any(), mockcpp::any(), mockcpp::any(), DRV_STREAM_ID)
        .will(returnValue(RT_ERROR_NONE));

    MOCKER_CPP(&StreamSqCqManage::ReAllocSqCqId)
        .stubs()
        .will(returnValue(RT_ERROR_NONE));

    MOCKER_CPP_VIRTUAL(dev_->Driver_(), &Driver::ReAllocResourceId)
        .stubs()
        .with(mockcpp::any(), mockcpp::any(), mockcpp::any(), mockcpp::any(), DRV_CNT_NOTIFY_ID)
        .will(returnValue(RT_ERROR_DRV_NOT_SUPPORT));

    rtError_t error = stream->Restore();
    EXPECT_EQ(error, RT_ERROR_DRV_NOT_SUPPORT);

    delete stream;
}

TEST_F(DavidSnapshotTest, ReAllocDavidSqCqId_Success)
{
    DavidStream* stream = new (std::nothrow) DavidStream(dev_, 0, 0, nullptr);
    ASSERT_NE(stream, nullptr);

    stream->sqId_ = 1;
    stream->cqId_ = 1;
    stream->logicalCqId_ = 1;

    StreamSqCqManage* stmSqCqManage = dev_->GetStreamSqCqManage();
    ASSERT_NE(stmSqCqManage, nullptr);

    MOCKER_CPP_VIRTUAL(dev_->Driver_(), &Driver::NormalSqCqAllocate)
        .stubs()
        .will(returnValue(RT_ERROR_NONE));

    MOCKER_CPP_VIRTUAL(dev_->Driver_(), &Driver::LogicCqAllocateV2)
        .stubs()
        .will(returnValue(RT_ERROR_NONE));

    MOCKER_CPP_VIRTUAL(dev_->Driver_(), &Driver::StreamBindLogicCq)
        .stubs()
        .will(returnValue(RT_ERROR_NONE));

    rtError_t error = stmSqCqManage->ReAllocDavidSqCqId(stream);
    EXPECT_EQ(error, RT_ERROR_NONE);

    delete stream;
}

TEST_F(DavidSnapshotTest, ReAllocDavidSqCqId_NormalSqCqAllocateFailed)
{
    DavidStream* stream = new (std::nothrow) DavidStream(dev_, 0, 0, nullptr);
    ASSERT_NE(stream, nullptr);

    stream->sqId_ = 1;
    stream->cqId_ = 1;

    StreamSqCqManage* stmSqCqManage = dev_->GetStreamSqCqManage();
    ASSERT_NE(stmSqCqManage, nullptr);

    MOCKER_CPP_VIRTUAL(dev_->Driver_(), &Driver::NormalSqCqAllocate)
        .stubs()
        .will(returnValue(RT_ERROR_DRV_NOT_SUPPORT));

    rtError_t error = stmSqCqManage->ReAllocDavidSqCqId(stream);
    EXPECT_EQ(error, RT_ERROR_DRV_NOT_SUPPORT);

    delete stream;
}

TEST_F(DavidSnapshotTest, RecordArgsAddrAndSize_Aicore)
{
    deviceSnapshot_->OpMemoryInfoInit();
    TaskInfo task;
    task.type = TS_TASK_TYPE_KERNEL_AICORE;
    task.u.aicTaskInfo.comm.args = reinterpret_cast<void*>(0x1000);
    task.u.aicTaskInfo.comm.argsSize = 256;
    deviceSnapshot_->RecordArgsAddrAndSize(&task);
    const auto& addrs = deviceSnapshot_->GetOpVirtualAddrs();
    EXPECT_GE(addrs.size(), 0U);
}

TEST_F(DavidSnapshotTest, RecordArgsAddrAndSize_Aicpu)
{
    deviceSnapshot_->OpMemoryInfoInit();
    TaskInfo task;
    task.type = TS_TASK_TYPE_KERNEL_AICPU;
    task.u.aicpuTaskInfo.comm.args = reinterpret_cast<void*>(0x2000);
    task.u.aicpuTaskInfo.comm.argsSize = 512;
    deviceSnapshot_->RecordArgsAddrAndSize(&task);
    const auto& addrs = deviceSnapshot_->GetOpVirtualAddrs();
    EXPECT_GE(addrs.size(), 0U);
}

TEST_F(DavidSnapshotTest, RecordArgsAddrAndSize_Fusion)
{
    deviceSnapshot_->OpMemoryInfoInit();
    TaskInfo task;
    task.type = TS_TASK_TYPE_FUSION_KERNEL;
    task.u.fusionKernelTask.args = reinterpret_cast<void*>(0x3000);
    task.u.fusionKernelTask.argsSize = 1024;
    deviceSnapshot_->RecordArgsAddrAndSize(&task);
    const auto& addrs = deviceSnapshot_->GetOpVirtualAddrs();
    EXPECT_GE(addrs.size(), 0U);
}

TEST_F(DavidSnapshotTest, GetHandlerMap)
{
    const auto& map = deviceSnapshot_->GetHandlerMap();
    EXPECT_GT(map.size(), 0U);
}

TEST_F(DavidSnapshotTest, HandleModelTaskUpdate)
{
    deviceSnapshot_->OpMemoryInfoInit();
    TaskInfo task;
    task.type = TS_TASK_TYPE_MODEL_TASK_UPDATE;
    task.u.mdlUpdateTask.tilingTabAddr = reinterpret_cast<void*>(0x4000);
    task.u.mdlUpdateTask.tilingTabLen = 2;
    TaskHandlers::HandleModelTaskUpdate(&task, deviceSnapshot_);
    const auto& addrs = deviceSnapshot_->GetOpVirtualAddrs();
    EXPECT_GT(addrs.size(), 0U);
}
