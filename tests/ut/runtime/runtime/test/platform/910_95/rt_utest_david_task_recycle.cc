/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "runtime/rt.h"
#include "event.hpp"
#include "scheduler.hpp"
#include "gtest/gtest.h"
#include "stars.hpp"
#include "hwts.hpp"
#include "npu_driver.hpp"
#include "event.hpp"
#include "subscribe.hpp"
#include "config_define.hpp"
#include "task_res.hpp"
#include "task_recycle.hpp"
#include "raw_device.hpp"
#include "device.hpp"
#include "stars_engine.hpp"
#include "cond_op_task.h"
#include "task_res_da.hpp"
#include "stream_sqcq_manage.hpp"
#include <thread>
#include <chrono>
#include "stream.hpp"
#include "stream_david.hpp"
#include "runtime.hpp"
#include "config.hpp"
#include "mockcpp/mockcpp.hpp"
#include "driver/ascend_hal.h"
#include "osal.hpp"
#include "api.hpp"
#include "task_info.h"
#include "memory_task.h"
#include "thread_local_container.hpp"
#include "device_error_info.hpp"
#include "task_scheduler_error.h"
using namespace testing;
using namespace cce::runtime;
namespace {
constexpr uint32_t TS_CCU_STATUS_DDRC_ERROR = 0x02;
constexpr uint32_t TS_CCU_STATUS_POISON_ERROR = 0x03;
constexpr uint32_t TS_CCU_STATUS_DDRC_ERROR_SUBSTATUS = 0x0;
}

static bool g_disableThread;
static rtChipType_t g_chipType;

extern int64_t g_device_driver_version_stub;

static drvError_t stubDavidGetDeviceInfo(uint32_t devId, int32_t moduleType, int32_t infoType, int64_t *value)
{
    if (value) {
        if (moduleType == MODULE_TYPE_SYSTEM && infoType == INFO_TYPE_VERSION) {
            *value = PLATFORMCONFIG_DAVID_910_9599;
        } else if (moduleType == MODULE_TYPE_SYSTEM && infoType == INFO_TYPE_CORE_NUM) {
            *value = g_device_driver_version_stub;
        } else {
            *value = 0;
        }
    }
    return DRV_ERROR_NONE;
}

class DavidTaskRecycleTest : public testing::Test {
protected:
    static void SetUpTestCase()
    {
        // backup oringal attribute of runtime
        MOCKER(halGetDeviceInfo).stubs().will(invoke(stubDavidGetDeviceInfo));
        char *socVer = "Ascend910_9599";
        MOCKER(halGetSocVersion)
            .stubs()
            .with(mockcpp::any(), outBoundP(socVer, strlen("Ascend910_9599")), mockcpp::any())
            .will(returnValue(DRV_ERROR_NONE));
        Runtime *rtInstance = (Runtime *)Runtime::Instance();
        g_disableThread = rtInstance->GetDisableThread();
        g_chipType = rtInstance->GetChipType();
        rtInstance->SetDisableThread(true);
        rtInstance->SetChipType(CHIP_DAVID);
        GlobalContainer::SetRtChipType(CHIP_DAVID);
    }

    static void TearDownTestCase()
    {
        // restore oringal attribute
        Runtime *rtInstance = (Runtime *)Runtime::Instance();
        rtInstance->SetDisableThread(g_disableThread);
        rtInstance->SetChipType(g_chipType);
        GlobalContainer::SetRtChipType(g_chipType);
    }

    virtual void SetUp()
    {
        std::cout << "TaskResManageTest SetUp start" << std::endl;
        Driver *driver_ = ((Runtime *)Runtime::Instance())->driverFactory_.GetDriver(NPU_DRIVER);
        MOCKER_CPP_VIRTUAL((NpuDriver *)(driver_), &NpuDriver::GetRunMode)
            .stubs()
            .will(returnValue((uint32_t)RT_RUN_MODE_ONLINE));
        MOCKER(halGetDeviceInfo).stubs().will(invoke(stubDavidGetDeviceInfo));
        char *socVer = "Ascend910_9599";
        MOCKER(halGetSocVersion)
            .stubs()
            .with(mockcpp::any(), outBoundP(socVer, strlen("Ascend910_9599")), mockcpp::any())
            .will(returnValue(DRV_ERROR_NONE));
        MOCKER(TaskUnInitProc).stubs().will(returnValue(0));
        rtSetDevice(0);
        std::cout << "TaskResManageTest SetUp end" << std::endl;
    }

    virtual void TearDown()
    {
        std::cout << "TaskResManageTest TearDown start" << std::endl;
        rtDeviceReset(0);
        GlobalMockObject::verify();
        std::cout << "TaskResManageTest TearDown end" << std::endl;
    }
};

TEST_F(DavidTaskRecycleTest, TestTaskRes)
{
    TaskResManageDavid *taskResMng = new (std::nothrow) TaskResManageDavid;
    taskResMng->taskPoolNum_ = 2049;
    Device *device = ((Runtime *)Runtime::Instance())->DeviceRetain(0, 0);
    uint32_t support = RT_CAPABILITY_SUPPORT;
    MOCKER_CPP_VIRTUAL(device->Driver_(), &Driver::CheckSupportPcieBarCopy)
        .stubs()
        .with(mockcpp::any(), outBound(support), mockcpp::any())
        .will(returnValue(RT_ERROR_NONE));

    void *addr = &support;
    MOCKER_CPP_VIRTUAL(device->Driver_(), &Driver::DevMemAlloc)
        .stubs()
        .will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL(device->Driver_(), &Driver::PcieHostRegister).stubs().will(returnValue(RT_ERROR_NONE));

    rtStream_t stream = nullptr;
    rtError_t error = rtStreamCreate(&stream, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);
    bool ret = taskResMng->CreateTaskRes(static_cast<Stream *>(stream));
    EXPECT_EQ(ret, true);

    uint32_t pos = UINT32_MAX;
    TaskInfo *task = nullptr;
    error = taskResMng->AllocTaskInfoAndPos(3U, pos, &task);
    EXPECT_EQ(error, RT_ERROR_NONE);
    EXPECT_EQ(pos, 0);

    for (uint32_t i = 0; i < 64; i++) {
        error = taskResMng->AllocTaskInfoAndPos(1U, pos, &task);
        EXPECT_EQ(error, RT_ERROR_NONE);
        EXPECT_EQ(pos, 3 + i);
    }

    uint16_t head = UINT16_MAX;
    uint16_t tail = UINT16_MAX;
    taskResMng->GetHeadTail(head, tail);
    EXPECT_EQ(head, 0);
    EXPECT_EQ(tail, 67);
    TaskInfo *getTask = taskResMng->GetTaskInfo(10);
    EXPECT_NE(getTask, nullptr);
    getTask = taskResMng->GetTaskInfo(66);
    EXPECT_NE(getTask, nullptr);
    getTask = taskResMng->GetTaskInfo(67);
    EXPECT_EQ(getTask, nullptr);
    getTask = taskResMng->GetTaskInfo(0);
    EXPECT_NE(getTask, nullptr);
    getTask = taskResMng->GetTaskInfo(1);
    EXPECT_NE(getTask, nullptr);
    getTask = taskResMng->GetTaskInfo(2);
    EXPECT_NE(getTask, nullptr);

    bool recycleFlag = taskResMng->RecycleTaskInfo(0, 3);
    EXPECT_EQ(recycleFlag, true);
    recycleFlag = taskResMng->RecycleTaskInfo(50, 1);
    EXPECT_EQ(recycleFlag, true);

    taskResMng->GetHeadTail(head, tail);
    EXPECT_EQ(head, 51);
    EXPECT_EQ(tail, 67);

    error = taskResMng->AllocTaskInfoAndPos(2049, pos, &task);
    EXPECT_EQ(error, RT_ERROR_INVALID_VALUE);

    recycleFlag = taskResMng->RecycleTaskInfo(2049, 1);
    EXPECT_EQ(recycleFlag, false);
    recycleFlag = taskResMng->RecycleTaskInfo(49, 1);
    EXPECT_EQ(recycleFlag, false);
    recycleFlag = taskResMng->RecycleTaskInfo(67, 1);
    EXPECT_EQ(recycleFlag, false);

    getTask = taskResMng->GetTaskInfo(2049);
    EXPECT_EQ(getTask, nullptr);

    getTask = taskResMng->GetTaskInfo(50);
    EXPECT_EQ(getTask, nullptr);

    getTask = taskResMng->GetTaskInfo(67);
    EXPECT_EQ(getTask, nullptr);

    recycleFlag = taskResMng->RecycleTaskInfo(50, 1);
    EXPECT_EQ(recycleFlag, true);
    recycleFlag = taskResMng->RecycleTaskInfo(66, 1);
    EXPECT_EQ(recycleFlag, true);

    for (uint32_t i = 0; i < 2000; i++) {
        error = taskResMng->AllocTaskInfoAndPos(1U, pos, &task);
        EXPECT_EQ(error, RT_ERROR_NONE);
    }
    taskResMng->GetHeadTail(head, tail);
    EXPECT_EQ(head, 67);
    EXPECT_EQ(tail, 18);

    getTask = taskResMng->GetTaskInfo(67);
    EXPECT_NE(getTask, nullptr);
    getTask = taskResMng->GetTaskInfo(17);
    EXPECT_NE(getTask, nullptr);
    getTask = taskResMng->GetTaskInfo(66);
    EXPECT_EQ(getTask, nullptr);
    getTask = taskResMng->GetTaskInfo(18);
    EXPECT_EQ(getTask, nullptr);

    recycleFlag = taskResMng->RecycleTaskInfo(65, 1);
    EXPECT_EQ(recycleFlag, false);
    recycleFlag = taskResMng->RecycleTaskInfo(18, 1);
    EXPECT_EQ(recycleFlag, false);
    recycleFlag = taskResMng->RecycleTaskInfo(66, 1);
    EXPECT_EQ(recycleFlag, true);
    recycleFlag = taskResMng->RecycleTaskInfo(17, 1);
    EXPECT_EQ(recycleFlag, true);

    taskResMng->ResetTaskRes();
    getTask = taskResMng->GetTaskInfo(0);
    EXPECT_EQ(getTask, nullptr);

    for (uint32_t i = 0; i < 2048; i++) {
        error = taskResMng->AllocTaskInfoAndPos(1U, pos, &task);
        EXPECT_EQ(error, RT_ERROR_NONE);
    }
    error = taskResMng->AllocTaskInfoAndPos(1U, pos, &task);
    EXPECT_EQ(error, RT_ERROR_TASKRES_QUEUE_FULL);
    taskResMng->RollbackTail(pos);

    taskResMng->ResetTaskRes();
    error = taskResMng->AllocTaskInfoAndPos(3U, pos, &task);
    EXPECT_EQ(error, RT_ERROR_NONE);
    getTask = taskResMng->GetTaskInfo(pos);
    EXPECT_NE(getTask, nullptr);
    getTask->id = 3;
    getTask = taskResMng->GetTaskInfo(pos);
    EXPECT_EQ(getTask, nullptr);

    taskResMng->ReleaseTaskResource(static_cast<Stream *>(stream));
    rtStreamDestroy(stream);
    ((Runtime *)Runtime::Instance())->DeviceRelease(device);
    delete taskResMng;
}

TEST_F(DavidTaskRecycleTest, SyncTaskRecycleBySqHead)
{
    Device *device = ((Runtime *)Runtime::Instance())->DeviceRetain(0, 0);
    uint32_t support = RT_CAPABILITY_SUPPORT;
    MOCKER_CPP_VIRTUAL(device->Driver_(), &Driver::CheckSupportPcieBarCopy)
        .stubs()
        .with(mockcpp::any(), outBound(support), mockcpp::any())
        .will(returnValue(RT_ERROR_NONE));

    void *addr = &support;
    MOCKER_CPP_VIRTUAL(device->Driver_(), &Driver::DevMemAlloc)
        .stubs()
        .with(outBoundP(&addr, sizeof(void *)), mockcpp::any(), mockcpp::any(), mockcpp::any(), mockcpp::any(), mockcpp::any())
        .will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL(device->Driver_(), &Driver::PcieHostRegister).stubs().will(returnValue(RT_ERROR_NONE));

    rtStream_t stream = nullptr;
    rtError_t error = rtStreamCreate(&stream, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);
    static_cast<Stream *>(stream)->SetSqMemAttr(false);

    uint32_t pos = UINT32_MAX;
    TaskInfo *task = nullptr;
    TaskResManageDavid *taskResMang = ((TaskResManageDavid *)(static_cast<Stream *>(stream)->taskResMang_));

    for (uint32_t i = 0; i < 1; i++) {
        error = taskResMang->AllocTaskInfoAndPos(1U, pos, &task);
        task->stream = static_cast<Stream *>(stream);
        task->sqeNum = 1U;
        task->type = TS_TASK_TYPE_KERNEL_AICORE;
        EXPECT_EQ(error, RT_ERROR_NONE);
        EXPECT_EQ(pos, i);
    }

    uint16_t sqHead = 1;
    Driver *driver;
    driver = ((Runtime *)Runtime::Instance())->driverFactory_.GetDriver(NPU_DRIVER);
    MOCKER_CPP_VIRTUAL(driver, &Driver::GetSqHead)
        .stubs()
        .with(mockcpp::any(), mockcpp::any(), mockcpp::any(), outBound(sqHead))
        .will(returnValue(RT_ERROR_NONE));

    MOCKER_CPP_VIRTUAL(driver, &Driver::LogicCqReportV2).stubs().will(returnValue(RT_ERROR_LOST_HEARTBEAT));

    error = SyncTask(static_cast<Stream *>(stream), 0, 50);
    EXPECT_EQ(error, RT_ERROR_LOST_HEARTBEAT);

    rtStreamDestroy(stream);
    ((Runtime *)Runtime::Instance())->DeviceRelease(device);
}

TEST_F(DavidTaskRecycleTest, SyncTaskRecycleBySqHeadV2)
{
    Device *device = ((Runtime *)Runtime::Instance())->DeviceRetain(0, 0);
    uint32_t support = RT_CAPABILITY_SUPPORT;
    MOCKER_CPP_VIRTUAL(device->Driver_(), &Driver::CheckSupportPcieBarCopy)
        .stubs()
        .with(mockcpp::any(), outBound(support), mockcpp::any())
        .will(returnValue(RT_ERROR_NONE));

    void *addr = &support;
    MOCKER_CPP_VIRTUAL(device->Driver_(), &Driver::DevMemAlloc)
        .stubs()
        .with(outBoundP(&addr, sizeof(void *)), mockcpp::any(), mockcpp::any(), mockcpp::any(), mockcpp::any(), mockcpp::any())
        .will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL(device->Driver_(), &Driver::PcieHostRegister).stubs().will(returnValue(RT_ERROR_NONE));

    rtStream_t stream = nullptr;
    rtError_t error = rtStreamCreate(&stream, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);
    static_cast<Stream *>(stream)->SetSqMemAttr(false);

    uint32_t pos = UINT32_MAX;
    TaskInfo *task = nullptr;
    TaskResManageDavid *taskResMang = ((TaskResManageDavid *)(static_cast<Stream *>(stream)->taskResMang_));

    for (uint32_t i = 0; i < 1; i++) {
        error = taskResMang->AllocTaskInfoAndPos(1U, pos, &task);
        task->stream = static_cast<Stream *>(stream);
        task->sqeNum = 1U;
        task->type = TS_TASK_TYPE_KERNEL_AICORE;
        EXPECT_EQ(error, RT_ERROR_NONE);
        EXPECT_EQ(pos, i);
    }

    uint16_t sqHead = 1;
    Driver *driver;
    driver = ((Runtime *)Runtime::Instance())->driverFactory_.GetDriver(NPU_DRIVER);
    MOCKER_CPP_VIRTUAL(driver, &Driver::GetSqHead)
        .stubs()
        .with(mockcpp::any(), mockcpp::any(), mockcpp::any(), outBound(sqHead))
        .will(returnValue(RT_ERROR_NONE));

    MOCKER_CPP_VIRTUAL(driver, &Driver::LogicCqReportV2).stubs().will(returnValue(RT_ERROR_REPORT_TIMEOUT));

    error = SyncTask(static_cast<Stream *>(stream), 0, 50);
    EXPECT_EQ(error, RT_ERROR_NONE);

    rtStreamDestroy(stream);
    ((Runtime *)Runtime::Instance())->DeviceRelease(device);
}
rtLogicCqReport_t g_cqReport;
rtError_t Sub_LogicCqReportV2(NpuDriver *drv, const LogicCqWaitInfo &waitInfo, uint8_t *report, uint32_t reportCnt,
                              uint32_t &realCnt)
{
    realCnt = 1;
    rtLogicCqReport_t *reportPtr = reinterpret_cast<rtLogicCqReport_t *>(report);
    *reportPtr = g_cqReport;

    return RT_ERROR_NONE;
}
void DvppGrpCallbackFunc(rtDvppGrpRptInfo_t *report)
{
    UNUSED(report);
}

TEST_F(DavidTaskRecycleTest, DvppWaitGroup)
{
    rtError_t ret;
    rtStream_t stream = nullptr;
    rtDvppGrp_t grp = nullptr;

    ret = rtDvppGroupCreate(&grp, 0);
    EXPECT_EQ(ret, ACL_RT_SUCCESS);

    ret = rtStreamCreateByGrp(&stream, 0, 0, grp);
    EXPECT_EQ(ret, ACL_RT_SUCCESS);
    ((DvppGrp *)grp)->getContext()->Device_()->GetStreamSqCqManage()->sqIdToStreamIdMap_[0] =
        static_cast<Stream *>(stream)->Id_();
    static_cast<Stream *>(stream)->SetSqMemAttr(false);
    Driver *driver;
    driver = ((Runtime *)Runtime::Instance())->driverFactory_.GetDriver(NPU_DRIVER);
    MOCKER_CPP_VIRTUAL((NpuDriver *)(driver), &NpuDriver::LogicCqReportV2).stubs().will(invoke(Sub_LogicCqReportV2));
    ret = rtDvppWaitGroupReport(grp, DvppGrpCallbackFunc, 0);
    EXPECT_EQ(ret, ACL_RT_SUCCESS);

    ret = rtStreamDestroy(stream);
    EXPECT_EQ(ret, ACL_RT_SUCCESS);

    ret = rtDvppGroupDestory(grp);
    EXPECT_EQ(ret, ACL_RT_SUCCESS);
}

TEST_F(DavidTaskRecycleTest, DvppWaitGroupCommonTaskReportLogicCq)
{
    rtError_t ret;
    rtStream_t stream = nullptr;
    rtDvppGrp_t grp = nullptr;

    ret = rtDvppGroupCreate(&grp, 0);
    EXPECT_EQ(ret, ACL_RT_SUCCESS);

    ret = rtStreamCreateByGrp(&stream, 0, 0, grp);
    EXPECT_EQ(ret, ACL_RT_SUCCESS);
    static_cast<Stream *>(stream)->SetSqMemAttr(false);
    ((DvppGrp *)grp)->getContext()->Device_()->GetStreamSqCqManage()->sqIdToStreamIdMap_[0] =
        static_cast<Stream *>(stream)->Id_();

    uint32_t pos = UINT32_MAX;
    TaskInfo *task = nullptr;
    TaskResManageDavid *taskResMang = ((TaskResManageDavid *)(static_cast<Stream *>(stream)->taskResMang_));

    for (uint32_t i = 0; i < 1; i++) {
        ret = taskResMang->AllocTaskInfoAndPos(1U, pos, &task);
        task->stream = static_cast<Stream *>(stream);
        task->sqeNum = 1U;
        task->type = TS_TASK_TYPE_KERNEL_AICORE;
        EXPECT_EQ(ret, RT_ERROR_NONE);
        EXPECT_EQ(pos, i);
    }

    task->pkgStat[RT_PACKAGE_TYPE_TASK_REPORT].expectPackage = 1U;

    g_cqReport.streamId = static_cast<Stream *>(stream)->Id_();
    g_cqReport.taskId = pos;

    Driver *driver;
    driver = ((Runtime *)Runtime::Instance())->driverFactory_.GetDriver(NPU_DRIVER);
    MOCKER_CPP_VIRTUAL((NpuDriver *)(driver), &NpuDriver::LogicCqReportV2).stubs().will(invoke(Sub_LogicCqReportV2));

    ret = rtDvppWaitGroupReport(grp, DvppGrpCallbackFunc, 0);
    EXPECT_EQ(ret, ACL_RT_SUCCESS);

    ret = rtStreamDestroy(stream);
    EXPECT_EQ(ret, ACL_RT_SUCCESS);

    ret = rtDvppGroupDestory(grp);
    EXPECT_EQ(ret, ACL_RT_SUCCESS);
}

TEST_F(DavidTaskRecycleTest, DvppWaitGroupCommonTaskReportLogicCqVPC)
{
    rtError_t ret;
    rtStream_t stream = nullptr;
    rtDvppGrp_t grp = nullptr;

    ret = rtDvppGroupCreate(&grp, 0);
    EXPECT_EQ(ret, ACL_RT_SUCCESS);

    ret = rtStreamCreateByGrp(&stream, 0, 0, grp);
    EXPECT_EQ(ret, ACL_RT_SUCCESS);
    static_cast<Stream *>(stream)->SetSqMemAttr(false);

    ((DvppGrp *)grp)->getContext()->Device_()->GetStreamSqCqManage()->sqIdToStreamIdMap_[0] =
        static_cast<Stream *>(stream)->Id_();

    uint32_t pos = UINT32_MAX;
    TaskInfo *task = nullptr;
    TaskResManageDavid *taskResMang = ((TaskResManageDavid *)(static_cast<Stream *>(stream)->taskResMang_));

    for (uint32_t i = 0; i < 1; i++) {
        ret = taskResMang->AllocTaskInfoAndPos(1U, pos, &task);
        task->stream = static_cast<Stream *>(stream);
        task->sqeNum = 1U;
        task->type = TS_TASK_TYPE_KERNEL_AICORE;
        EXPECT_EQ(ret, RT_ERROR_NONE);
        EXPECT_EQ(pos, i);
    }

    task->pkgStat[RT_PACKAGE_TYPE_TASK_REPORT].expectPackage = 1U;

    g_cqReport.streamId = static_cast<Stream *>(stream)->Id_();
    g_cqReport.taskId = pos;
    g_cqReport.errorType = RT_STARS_CQE_ERR_TYPE_EXCEPTION;
    g_cqReport.sqeType = RT_STARS_SQE_TYPE_VPC;
    Driver *driver;
    driver = ((Runtime *)Runtime::Instance())->driverFactory_.GetDriver(NPU_DRIVER);
    MOCKER_CPP_VIRTUAL((NpuDriver *)(driver), &NpuDriver::LogicCqReportV2).stubs().will(invoke(Sub_LogicCqReportV2));

    bool enable = false;
    MOCKER_CPP_VIRTUAL(driver, &Driver::GetSqEnable)
        .stubs()
        .with(mockcpp::any(), mockcpp::any(), mockcpp::any(), outBound(enable))
        .will(returnValue(RT_ERROR_NONE));

    ret = rtDvppWaitGroupReport(grp, DvppGrpCallbackFunc, 0);
    EXPECT_EQ(ret, ACL_ERROR_RT_STREAM_SYNC_TIMEOUT);

    TaskReclaimByStream(static_cast<Stream *>(stream), false);
    ret = rtStreamDestroy(stream);
    EXPECT_EQ(ret, ACL_RT_SUCCESS);

    ret = rtDvppGroupDestory(grp);
    EXPECT_EQ(ret, ACL_RT_SUCCESS);
    g_cqReport.errorType = 0U;
    g_cqReport.sqeType = 0U;
}

TEST_F(DavidTaskRecycleTest, ProcLogicCqReport)
{
    Device *device = ((Runtime *)Runtime::Instance())->DeviceRetain(0, 0);
    uint32_t support = RT_CAPABILITY_SUPPORT;
    MOCKER_CPP_VIRTUAL(device->Driver_(), &Driver::CheckSupportPcieBarCopy)
        .stubs()
        .with(mockcpp::any(), outBound(support), mockcpp::any())
        .will(returnValue(RT_ERROR_NONE));

    void *addr = &support;
    MOCKER_CPP_VIRTUAL(device->Driver_(), &Driver::DevMemAlloc)
        .stubs()
        .with(outBoundP(&addr, sizeof(void *)), mockcpp::any(), mockcpp::any(), mockcpp::any(), mockcpp::any(), mockcpp::any())
        .will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL(device->Driver_(), &Driver::PcieHostRegister).stubs().will(returnValue(RT_ERROR_NONE));

    rtStream_t stream = nullptr;
    rtError_t error = rtStreamCreate(&stream, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);
    static_cast<Stream *>(stream)->SetSqMemAttr(false);
    TaskInfo taskInfo = {0};
    taskInfo.stream = static_cast<Stream *>(stream);
    static_cast<Stream *>(stream)->SetSyncRemainTime(1);
    rtLogicCqReport_t report = {0};
    report.errorType = RT_STARS_EXIST_ERROR;
    device->SetHasTaskError(true);
    static_cast<Stream *>(stream)->SetFailureMode(STOP_ON_FAILURE);
    MOCKER_CPP(&Stream::GetError).stubs().will(returnValue(RT_ERROR_MODEL_ABORT_NORMAL));
    ProcLogicCqReport(device, report, &taskInfo);
    GlobalMockObject::verify();
    error = rtStreamDestroy(stream);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
    ((Runtime *)Runtime::Instance())->DeviceRelease(device);
}

TEST_F(DavidTaskRecycleTest, TryRecycleTaskV2)
{
    Device *device = ((Runtime *)Runtime::Instance())->DeviceRetain(0, 0);
    uint32_t support = RT_CAPABILITY_SUPPORT;
    MOCKER_CPP_VIRTUAL(device->Driver_(), &Driver::CheckSupportPcieBarCopy)
        .stubs()
        .with(mockcpp::any(), outBound(support), mockcpp::any())
        .will(returnValue(RT_ERROR_NONE));

    void *addr = &support;
    MOCKER_CPP_VIRTUAL(device->Driver_(), &Driver::DevMemAlloc)
        .stubs()
        .with(outBoundP(&addr, sizeof(void *)), mockcpp::any(), mockcpp::any(), mockcpp::any(), mockcpp::any(), mockcpp::any())
        .will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL(device->Driver_(), &Driver::PcieHostRegister).stubs().will(returnValue(RT_ERROR_NONE));

    rtStream_t stream = nullptr;
    rtError_t error = rtStreamCreate(&stream, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);
    static_cast<Stream *>(stream)->SetSqMemAttr(false);
    static_cast<Stream *>(stream)->SetRecycleFlag(true);
    static_cast<Stream *>(stream)->SetNeedRecvCqeFlag(true);

    Driver *driver;
    driver = ((Runtime *)Runtime::Instance())->driverFactory_.GetDriver(NPU_DRIVER);
    MOCKER_CPP_VIRTUAL(driver, &Driver::LogicCqReportV2)
        .stubs()
        .will(returnValue(RT_ERROR_NONE))
        .then(returnValue(RT_ERROR_LOST_HEARTBEAT));
    uint16_t sqHead = 0;
    MOCKER_CPP_VIRTUAL(driver, &Driver::GetSqHead)
        .stubs()
        .with(mockcpp::any(), mockcpp::any(), mockcpp::any(), outBound(sqHead))
        .will(returnValue(RT_ERROR_NONE));

    error = TryRecycleTask(static_cast<Stream *>(stream));
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtStreamDestroy(stream);
    EXPECT_EQ(error, RT_ERROR_NONE);
    ((Runtime *)Runtime::Instance())->DeviceRelease(device);
}

TEST_F(DavidTaskRecycleTest, TryRecycleTaskAbort)
{
    Device *device = ((Runtime *)Runtime::Instance())->DeviceRetain(0, 0);
    uint32_t support = RT_CAPABILITY_SUPPORT;
    MOCKER_CPP_VIRTUAL(device->Driver_(), &Driver::CheckSupportPcieBarCopy)
        .stubs()
        .with(mockcpp::any(), outBound(support), mockcpp::any())
        .will(returnValue(RT_ERROR_NONE));

    void *addr = &support;
    MOCKER_CPP_VIRTUAL(device->Driver_(), &Driver::DevMemAlloc)
        .stubs()
        .with(outBoundP(&addr, sizeof(void *)), mockcpp::any(), mockcpp::any(), mockcpp::any(), mockcpp::any(), mockcpp::any())
        .will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL(device->Driver_(), &Driver::PcieHostRegister).stubs().will(returnValue(RT_ERROR_NONE));

    rtStream_t stream = nullptr;
    rtError_t error = rtStreamCreate(&stream, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);
    static_cast<Stream *>(stream)->SetSqMemAttr(false);
    static_cast<Stream *>(stream)->SetRecycleFlag(true);
    static_cast<Stream *>(stream)->SetNeedRecvCqeFlag(true);
    ((Stream *)stream)->Device_()->SetDeviceStatus(RT_ERROR_DEVICE_TASK_ABORT);
    static_cast<Stream *>(stream)->SetAbortStatus(RT_ERROR_STREAM_ABORT);
    Driver *driver;
    driver = ((Runtime *)Runtime::Instance())->driverFactory_.GetDriver(NPU_DRIVER);
    MOCKER_CPP_VIRTUAL(driver, &Driver::LogicCqReportV2)
        .stubs()
        .will(returnValue(RT_ERROR_NONE))
        .then(returnValue(RT_ERROR_LOST_HEARTBEAT));
    uint16_t sqHead = 0;
    MOCKER_CPP_VIRTUAL(driver, &Driver::GetSqHead)
        .stubs()
        .with(mockcpp::any(), mockcpp::any(), mockcpp::any(), outBound(sqHead))
        .will(returnValue(RT_ERROR_NONE));

    error = TryRecycleTask(static_cast<Stream *>(stream));
    EXPECT_EQ(error, RT_ERROR_DEVICE_TASK_ABORT);

    error = rtStreamDestroy(stream);
    EXPECT_EQ(error, RT_ERROR_NONE);
    ((Runtime *)Runtime::Instance())->DeviceRelease(device);
}

TEST_F(DavidTaskRecycleTest, TaskReclaimByStreamV2)
{
    Device *device = ((Runtime *)Runtime::Instance())->DeviceRetain(0, 0);
    uint32_t support = RT_CAPABILITY_SUPPORT;
    MOCKER_CPP_VIRTUAL(device->Driver_(), &Driver::CheckSupportPcieBarCopy)
        .stubs()
        .with(mockcpp::any(), outBound(support), mockcpp::any())
        .will(returnValue(RT_ERROR_NONE));

    void *addr = &support;
    MOCKER_CPP_VIRTUAL(device->Driver_(), &Driver::DevMemAlloc)
        .stubs()
        .with(outBoundP(&addr, sizeof(void *)), mockcpp::any(), mockcpp::any(), mockcpp::any(), mockcpp::any(), mockcpp::any())
        .will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL(device->Driver_(), &Driver::PcieHostRegister).stubs().will(returnValue(RT_ERROR_NONE));

    MOCKER(FinishedTaskReclaim).stubs().will(returnValue(RT_ERROR_NONE));
    rtStream_t stream = nullptr;
    rtError_t error = rtStreamCreate(&stream, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);
    static_cast<Stream *>(stream)->SetSqMemAttr(false);
    static_cast<Stream *>(stream)->SetFailureMode(ABORT_ON_FAILURE);

    static_cast<Stream *>(stream)->flags_ = RT_STREAM_PERSISTENT;
    error = TaskReclaimByStream(static_cast<Stream *>(stream), false);
    EXPECT_EQ(error, RT_ERROR_STREAM_INVALID);
    static_cast<Stream *>(stream)->flags_ = 0;

    error = TaskReclaimByStream(static_cast<Stream *>(stream), false);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = rtStreamDestroy(stream);
    EXPECT_EQ(error, RT_ERROR_NONE);
    ((Runtime *)Runtime::Instance())->DeviceRelease(device);
}

TEST_F(DavidTaskRecycleTest, TryReclaimToTask)
{
    Device *device = ((Runtime *)Runtime::Instance())->DeviceRetain(0, 0);
    ((RawDevice *)device)->platformType_ = PLATFORM_DAVID_910_9599;
    uint32_t support = RT_CAPABILITY_SUPPORT;
    MOCKER_CPP_VIRTUAL(device->Driver_(), &Driver::CheckSupportPcieBarCopy)
        .stubs()
        .with(mockcpp::any(), outBound(support), mockcpp::any())
        .will(returnValue(RT_ERROR_NONE));

    void *addr = &support;
    MOCKER_CPP_VIRTUAL(device->Driver_(), &Driver::DevMemAlloc)
        .stubs()
        .with(outBoundP(&addr, sizeof(void *)), mockcpp::any(), mockcpp::any(), mockcpp::any(), mockcpp::any(), mockcpp::any())
        .will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL(device->Driver_(), &Driver::PcieHostRegister).stubs().will(returnValue(RT_ERROR_NONE));

    rtStream_t stream = nullptr;
    rtError_t error = rtStreamCreate(&stream, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);
    static_cast<Stream *>(stream)->SetSqMemAttr(false);
    TaskInfo taskInfo = {0};
    taskInfo.stream = static_cast<Stream *>(stream);
    taskInfo.type = TS_TASK_TYPE_MODEL_EXECUTE;

    uint16_t delPos = 0;
    MOCKER_CPP_VIRTUAL((DavidStream *)(stream), &DavidStream::StarsGetPublicTaskHead)
        .stubs()
        .with(mockcpp::any(), mockcpp::any(), mockcpp::any(), outBoundP(&delPos))
        .will(returnValue(RT_ERROR_NONE));
    //delWorkTask == nullptr abnormal
    TryReclaimToTask(&taskInfo);

    // check cqe
    TaskResManageDavid *taskResMang = ((TaskResManageDavid *)(static_cast<Stream *>(stream)->taskResMang_));
    taskResMang->taskResATail_.Set(1);
    taskResMang->taskRes_[0].taskInfo.id = 0;
    taskResMang->taskRes_[0].taskInfo.isCqeNeedConcern = true;
    taskResMang->taskRes_[0].taskInfo.stream = static_cast<Stream *>(stream);
    TryReclaimToTask(&taskInfo);
    taskResMang->taskRes_[0].taskInfo.isCqeNeedConcern = false;

    // DavidUpdatePublicQueue fail
    MOCKER_CPP_VIRTUAL((DavidStream *)(stream), &DavidStream::DavidUpdatePublicQueue)
        .stubs()
        .will(returnValue(RT_ERROR_STREAM_INVALID));
    TryReclaimToTask(&taskInfo);

    taskResMang->taskResATail_.Set(0);
    error = rtStreamDestroy(stream);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
    ((Runtime *)Runtime::Instance())->DeviceRelease(device);
}

TEST_F(DavidTaskRecycleTest, FinishedTaskReclaim)
{
    Device *device = ((Runtime *)Runtime::Instance())->DeviceRetain(0, 0);
    uint32_t support = RT_CAPABILITY_SUPPORT;
    MOCKER_CPP_VIRTUAL(device->Driver_(), &Driver::CheckSupportPcieBarCopy)
        .stubs()
        .with(mockcpp::any(), outBound(support), mockcpp::any())
        .will(returnValue(RT_ERROR_NONE));

    void *addr = &support;
    MOCKER_CPP_VIRTUAL(device->Driver_(), &Driver::DevMemAlloc)
        .stubs()
        .with(outBoundP(&addr, sizeof(void *)), mockcpp::any(), mockcpp::any(), mockcpp::any(), mockcpp::any(), mockcpp::any())
        .will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL(device->Driver_(), &Driver::PcieHostRegister).stubs().will(returnValue(RT_ERROR_NONE));

    rtStream_t stream = nullptr;
    rtError_t error = rtStreamCreate(&stream, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);
    static_cast<Stream *>(stream)->SetSqMemAttr(false);
    static_cast<Stream *>(stream)->SetRecycleEndTaskId(0);

    error = FinishedTaskReclaim(static_cast<Stream *>(stream), true, 64, 129);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = FinishedTaskReclaim(static_cast<Stream *>(stream), true, 129, 64);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtStreamDestroy(stream);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
    ((Runtime *)Runtime::Instance())->DeviceRelease(device);
}

TEST_F(DavidTaskRecycleTest, ProcReport)
{
    Device *device = ((Runtime *)Runtime::Instance())->DeviceRetain(0, 0);
    TaskInfo *reportTask = nullptr;
    MOCKER(GetTaskInfo).stubs().will(returnValue(reportTask));
    rtLogicCqReport_t report = {0};
    bool isFinished = false;
    uint32_t pos = ProcReport(device, 0U, 65535, 1, &report, isFinished);
    EXPECT_EQ(pos, 0);
    ((Runtime *)Runtime::Instance())->DeviceRelease(device);
}

TEST_F(DavidTaskRecycleTest, ProcReportWithTaskMultiple)
{
    Device *device = ((Runtime *)Runtime::Instance())->DeviceRetain(0, 0);
    TaskInfo reportTask = {};
    reportTask.type = TS_TASK_TYPE_MULTIPLE_TASK;
    MOCKER(GetSendDavidSqeNum).stubs().will(returnValue(2));
    MOCKER(GetTaskInfo).stubs().will(returnValue(&reportTask));
    MOCKER(ProcLogicCqReport).stubs();
    MOCKER(CompleteProcMultipleTaskReport).stubs().will(returnValue(true));
    MOCKER(StarsResumeRtsq).stubs().will(returnValue(RT_ERROR_NONE));
    rtLogicCqReport_t report = {0};
    bool isFinished = false;
    uint32_t pos = ProcReport(device, 0U, 65535, 1, &report, isFinished);
    EXPECT_EQ(pos, 0);

    reportTask.type = TS_TASK_TYPE_KERNEL_AICORE;
    pos = ProcReport(device, 0U, 65535, 1, &report, isFinished);
    EXPECT_EQ(pos, 0);

    ((Runtime *)Runtime::Instance())->DeviceRelease(device);
}

TEST_F(DavidTaskRecycleTest, ProcCqReportException)
{
    Device *device = ((Runtime *)Runtime::Instance())->DeviceRetain(0, 0);
    TaskInfo reportTask = {};
    rtLogicCqReport_t report = {0};
    report.sqeType = TS_TASK_TYPE_KERNEL_AICORE;
    report.errorType = RT_STARS_CQE_ERR_TYPE_EXCEPTION;
    report.errorCode = TS_ERROR_AICORE_OVERFLOW;
    ProcCqReportException(device, report, &reportTask, 0U);
    EXPECT_EQ(reportTask.type, 0);

    report.sqeType = RT_STARS_SQE_TYPE_NOTIFY_WAIT;
    report.errorType = RT_STARS_CQE_ERR_TYPE_EXCEPTION;
    report.errorCode = 0x40000000;
    ProcCqReportException(device, report, &reportTask, 0U);
    EXPECT_EQ(reportTask.type, 0);
    report.sqeType = RT_STARS_SQE_TYPE_EVENT_WAIT;
    report.errorType = RT_STARS_CQE_ERR_TYPE_EXCEPTION;
    report.errorCode = TS_ERROR_END_OF_SEQUENCE;
    ProcCqReportException(device, report, &reportTask, 0U);
    EXPECT_EQ(reportTask.type, 0);
    ((Runtime *)Runtime::Instance())->DeviceRelease(device);
}

TEST_F(DavidTaskRecycleTest, StarsResumeRtsq_01)
{
    rtError_t ret;
    Device *device = ((Runtime *)Runtime::Instance())->DeviceRetain(0, 0);
    Stream *stream;
    ret = rtStreamCreate((rtStream_t *)&stream, 0);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    stream->device_ = device;

    MOCKER_CPP_VIRTUAL(device->Driver_(), &Driver::GetSqEnable)
        .stubs()
        .with(mockcpp::any(), mockcpp::any(), mockcpp::any(), outBound(false))
        .will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL(device->Driver_(), &Driver::SetSqHead).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL(device->Driver_(), &Driver::EnableSq).stubs().will(returnValue(RT_ERROR_NONE));

    TaskInfo reportTask = {};
    rtLogicCqReport_t report = {0};
    reportTask.type = TS_TASK_TYPE_FUSION_KERNEL;
    reportTask.stream = stream;
    report.sqeType = RT_STARS_SQE_TYPE_EVENT_WAIT;
    report.errorType = RT_STARS_CQE_ERR_TYPE_EXCEPTION;
    report.errorCode = TS_ERROR_END_OF_SEQUENCE;
    ret = StarsResumeRtsq(&report, &reportTask);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    ret = rtStreamDestroy(stream);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    ((Runtime *)Runtime::Instance())->DeviceRelease(device);
}

TEST_F(DavidTaskRecycleTest, StarsResumeRtsq_02)
{
    rtError_t ret;
    Device *device = ((Runtime *)Runtime::Instance())->DeviceRetain(0, 0);
    Stream *stream;
    ret = rtStreamCreate((rtStream_t *)&stream, 0);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    stream->device_ = device;
    stream->SetAbortStatus(RT_ERROR_STREAM_ABORT);

    MOCKER_CPP_VIRTUAL(device->Driver_(), &Driver::GetSqEnable)
        .stubs()
        .with(mockcpp::any(), mockcpp::any(), mockcpp::any(), outBound(true))
        .will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL(device->Driver_(), &Driver::SetSqHead).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL(device->Driver_(), &Driver::EnableSq).stubs().will(returnValue(RT_ERROR_NONE));

    TaskInfo reportTask = {};
    rtLogicCqReport_t report = {0};
    reportTask.type = TS_TASK_TYPE_FUSION_KERNEL;
    reportTask.stream = stream;
    report.sqeType = RT_STARS_SQE_TYPE_EVENT_WAIT;
    report.errorType = RT_STARS_CQE_ERR_TYPE_EXCEPTION;
    report.errorCode = TS_ERROR_END_OF_SEQUENCE;
    ret = StarsResumeRtsq(&report, &reportTask);
    EXPECT_EQ(ret, RT_ERROR_STREAM_ABORT);
    ret = rtStreamDestroy(stream);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    ((Runtime *)Runtime::Instance())->DeviceRelease(device);
}

TEST_F(DavidTaskRecycleTest, DoCompleteSuccessForNotifyWaitTask)
{
    rtError_t ret;
    Device *device = ((Runtime *)Runtime::Instance())->DeviceRetain(0, 0);
    Model *model;
    Stream *stream;
    Notify *notify;

    ret = rtStreamCreate((rtStream_t *)&stream, 0);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    ret = rtModelCreate((rtModel_t *)&model, 0);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    ret = rtNotifyCreate(0, (rtNotify_t *)&notify);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    notify->SetEndGraphModel(model);

    TaskInfo taskInfo = {0};
    taskInfo.errorCode = TS_ERROR_TASK_TIMEOUT;
    taskInfo.stream = stream;
    taskInfo.u.notifywaitTask.u.notify = notify;
    taskInfo.type = TS_TASK_TYPE_MODEL_EXECUTE;

    DoCompleteSuccessForNotifyWaitTask(&taskInfo, 0);

    ret = rtNotifyDestroy(notify);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    ret = rtStreamDestroy(stream);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    ret = rtModelDestroy(model);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    ((Runtime *)Runtime::Instance())->DeviceRelease(device);
}

extern int32_t faultEventFlag;
TEST_F(DavidTaskRecycleTest, DoCompleteSuccessForNotifyWaitTaskForAiCpu)
{
    rtError_t ret;
    Device *device = ((Runtime *)Runtime::Instance())->DeviceRetain(0, 0);
    Model *model;
    Stream *stream;
    Notify *notify;

    ret = rtStreamCreate((rtStream_t *)&stream, 0);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    ret = rtModelCreate((rtModel_t *)&model, 0);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    ret = rtNotifyCreate(0, (rtNotify_t *)&notify);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    notify->SetEndGraphModel(model);

    TaskInfo taskInfo = {0};
    taskInfo.errorCode = AICPU_HCCL_OP_UB_DDRC_FAILED;
    taskInfo.stream = stream;
    taskInfo.type = TS_TASK_TYPE_MODEL_EXECUTE;

    taskInfo.stream->Device_()->SetDeviceRas(true);
    faultEventFlag = 2;

    DoCompleteSuccessForNotifyWaitTask(&taskInfo, 0);

    taskInfo.errorCode = AICPU_HCCL_OP_UB_POISON_FAILED;
    taskInfo.stream->Device_()->SetDeviceRas(false);
    faultEventFlag = 7;

    DoCompleteSuccessForNotifyWaitTask(&taskInfo, 0);

    ret = rtNotifyDestroy(notify);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    ret = rtStreamDestroy(stream);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    ret = rtModelDestroy(model);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    ((Runtime *)Runtime::Instance())->DeviceRelease(device);
}

TEST_F(DavidTaskRecycleTest, PrintErrorInfo)
{
    rtError_t ret;
    Device *device = ((Runtime *)Runtime::Instance())->DeviceRetain(0, 0);
    Model *model;
    Stream *stream;
    Notify *notify;
    ret = rtStreamCreate((rtStream_t *)&stream, 0);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    TaskInfo taskInfo = {0};
    taskInfo.errorCode = TS_ERROR_TASK_TIMEOUT;
    taskInfo.stream = stream;
    taskInfo.type = TS_TASK_TYPE_STARS_COMMON;
    PrintErrorInfo(&taskInfo, 0);

    taskInfo.errorCode = TS_ERROR_TASK_TIMEOUT;
    taskInfo.stream = stream;
    taskInfo.drvErr == static_cast<uint32_t>(RT_ERROR_SOCKET_CLOSE);
    taskInfo.type = TS_TASK_TYPE_MODEL_EXECUTE;
    MOCKER(GetTaskInfo).stubs().will(returnValue(&taskInfo));
    MOCKER(PrintErrorInfoForModelExecuteTask).stubs();

    PrintErrorInfo(&taskInfo, 0);

    ret = rtStreamDestroy(stream);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    ((Runtime *)Runtime::Instance())->DeviceRelease(device);
}

TEST_F(DavidTaskRecycleTest, CCUTask)
{
    rtError_t ret;
    Device *device = ((Runtime *)Runtime::Instance())->DeviceRetain(0, 0);
    Stream *stream;
    ret = rtStreamCreate((rtStream_t *)&stream, 0);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    TaskInfo taskInfo = {0};
    taskInfo.errorCode = TS_ERROR_TASK_TIMEOUT;
    taskInfo.stream = stream;
    taskInfo.type = TS_TASK_TYPE_CCU_LAUNCH;

    rtLogicCqReport_t wait_cqe = {};
    wait_cqe.errorType = RT_STARS_EXIST_ERROR | STARS_CCU_EXIST_ERROR;
    wait_cqe.errorCode = 1U;

    SetStarsResult(&taskInfo, wait_cqe);
    Complete(&taskInfo, 0);

    ret = rtStreamDestroy(stream);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    ((Runtime *)Runtime::Instance())->DeviceRelease(device);
}

extern int32_t faultEventFlag;
TEST_F(DavidTaskRecycleTest, CCUTaskHBMError)
{
    rtError_t ret;
    Device *device = ((Runtime *)Runtime::Instance())->DeviceRetain(0, 0);
    Stream *stream;
    ret = rtStreamCreate((rtStream_t *)&stream, 0);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    TaskInfo taskInfo = {0};
    taskInfo.errorCode = TS_ERROR_TASK_TIMEOUT;
    taskInfo.stream = stream;
    taskInfo.type = TS_TASK_TYPE_CCU_LAUNCH;

    rtLogicCqReport_t wait_cqe = {};
    wait_cqe.errorType = RT_STARS_EXIST_ERROR | STARS_CCU_EXIST_ERROR;
    wait_cqe.errorCode = 1U;

    SetStarsResult(&taskInfo, wait_cqe);
    taskInfo.u.ccuLaunchTask.errInfo.err = 0xFF01U;
    taskInfo.u.ccuLaunchTask.errInfo.info.status = TS_CCU_STATUS_DDRC_ERROR;
    taskInfo.u.ccuLaunchTask.errInfo.info.subStatus = TS_CCU_STATUS_DDRC_ERROR_SUBSTATUS;
    taskInfo.stream->Device_()->SetDeviceRas(true);
    faultEventFlag = 7;
    Complete(&taskInfo, 0);

    taskInfo.u.ccuLaunchTask.errInfo.info.status = TS_CCU_STATUS_POISON_ERROR;
    taskInfo.stream->Device_()->SetDeviceRas(false);
    faultEventFlag = 7;
    Complete(&taskInfo, 0);
    faultEventFlag = 0;

    ret = rtStreamDestroy(stream);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    ((Runtime *)Runtime::Instance())->DeviceRelease(device);
}

TEST_F(DavidTaskRecycleTest, FusionTaskAbort)
{
    rtError_t ret;
    Device *device = ((Runtime *)Runtime::Instance())->DeviceRetain(0, 0);
    Stream *stream;
    ret = rtStreamCreate((rtStream_t *)&stream, 0);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    TaskInfo taskInfo = {0};
    taskInfo.errorCode = TS_ERROR_TASK_TIMEOUT;
    taskInfo.stream = stream;
    taskInfo.type = TS_TASK_TYPE_FUSION_KERNEL;

    rtLogicCqReport_t wait_cqe = {};
    wait_cqe.errorType = RT_STARS_EXIST_ERROR | STARS_CCU_EXIST_ERROR;
    wait_cqe.errorCode = 1U;
    taskInfo.mte_error = TS_ERROR_AICORE_MTE_ERROR;
    SetStarsResult(&taskInfo, wait_cqe);
    Complete(&taskInfo, 0);

    ret = rtStreamDestroy(stream);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    ((Runtime *)Runtime::Instance())->DeviceRelease(device);
}

TEST_F(DavidTaskRecycleTest, DoCompleteSuccessForMemcpyAsyncTask)
{
    rtError_t ret;
    Device *device = ((Runtime *)Runtime::Instance())->DeviceRetain(0, 0);
    Stream *stream;
    ret = rtStreamCreate((rtStream_t *)&stream, 0);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    MOCKER(PrintErrorInfoForMemcpyAsyncTask).stubs();

    TaskInfo taskInfo = {0};
    taskInfo.errorCode = TS_ERROR_TASK_TIMEOUT;
    taskInfo.stream = stream;
    taskInfo.type = TS_TASK_TYPE_MEMCPY;
    Complete(&taskInfo, 0);

    ret = rtStreamDestroy(stream);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    ((Runtime *)Runtime::Instance())->DeviceRelease(device);
}

TEST_F(DavidTaskRecycleTest, DoCompleteSuccessForMemcpyAsyncTaskForSDMALinkError)
{
    rtError_t ret;
    Device *device = ((Runtime *)Runtime::Instance())->DeviceRetain(0, 0);
    Stream *stream;
    ret = rtStreamCreate((rtStream_t *)&stream, 0);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    
    MOCKER(PrintErrorInfoForMemcpyAsyncTask).stubs();

    TaskInfo taskInfo = {0};
    taskInfo.errorCode = TS_ERROR_TASK_TIMEOUT;
    taskInfo.stream = stream;
    taskInfo.type = TS_TASK_TYPE_MEMCPY;
    taskInfo.mte_error = TS_ERROR_SDMA_LINK_ERROR;
    Complete(&taskInfo, 0);

    ret = rtStreamDestroy(stream);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    ((Runtime *)Runtime::Instance())->DeviceRelease(device);
}


TEST_F(DavidTaskRecycleTest, PrintErrorInfoForStreamLabelSwitchByIndexTask)
{
    rtError_t ret;
    Device *device = ((Runtime *)Runtime::Instance())->DeviceRetain(0, 0);
    Stream *stream;
    ret = rtStreamCreate((rtStream_t *)&stream, 0);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    TaskInfo taskInfo = {0};
    taskInfo.errorCode = TS_ERROR_TASK_TIMEOUT;
    taskInfo.stream = stream;
    taskInfo.type = TS_TASK_TYPE_STREAM_LABEL_SWITCH_BY_INDEX;

    MOCKER_CPP_VIRTUAL(device->Driver_(), &Driver::MemCopySync).stubs().will(returnValue(RT_ERROR_NONE));

    PrintErrorInfoForStreamLabelSwitchByIndexTask(&taskInfo, 0);

    ret = rtStreamDestroy(stream);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    ((Runtime *)Runtime::Instance())->DeviceRelease(device);
}

TEST_F(DavidTaskRecycleTest, RecycleModeLabel)
{
    Device *device = ((Runtime *)Runtime::Instance())->DeviceRetain(0, 0);
    uint32_t support = RT_CAPABILITY_SUPPORT;
    MOCKER_CPP_VIRTUAL(device->Driver_(), &Driver::CheckSupportPcieBarCopy)
        .stubs()
        .with(mockcpp::any(), outBound(support), mockcpp::any())
        .will(returnValue(RT_ERROR_NONE));

    void *addr = &support;
    MOCKER_CPP_VIRTUAL(device->Driver_(), &Driver::DevMemAlloc)
        .stubs()
        .with(outBoundP(&addr, sizeof(void *)), mockcpp::any(), mockcpp::any(), mockcpp::any(), mockcpp::any(), mockcpp::any())
        .will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL(device->Driver_(), &Driver::PcieHostRegister).stubs().will(returnValue(RT_ERROR_NONE));

    rtStream_t stream = nullptr;
    rtError_t error = rtStreamCreate(&stream, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);
    static_cast<Stream *>(stream)->SetSqMemAttr(false);
    rtModel_t model;
    rtLabel_t label;
    error = rtModelCreate(&model, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = rtLabelCreateV2(&label, model);
    EXPECT_EQ(error, RT_ERROR_NONE);

    uint32_t val = 0x123;
    ((Label *)label)->SetLabelDevAddr((void *)(&val));
    ((Stream *)stream)->models_.insert((Model *)model);
    ((Stream *)stream)->SetLatestModlId(((Model *)model)->Id_());
    static_cast<Stream *>(stream)->InsertLabelList(static_cast<Label *>(label));

    uint32_t pos = UINT32_MAX;
    TaskInfo *task = nullptr;
    TaskResManageDavid *taskResMang = ((TaskResManageDavid *)(static_cast<Stream *>(stream)->taskResMang_));
    error = taskResMang->AllocTaskInfoAndPos(1U, pos, &task);
    task->stream = static_cast<Stream *>(stream);
    task->sqeNum = 1U;
    task->type = TS_TASK_TYPE_LABEL_SET;
    task->u.labelSetTask.labelId = ((Label *)label)->Id_();
    EXPECT_EQ(error, RT_ERROR_NONE);
    EXPECT_EQ(pos, 0);

    RecycleModelBindStreamAllTask(static_cast<Stream *>(stream), true);
    ((Stream *)stream)->models_.erase((Model *)model);

    error = rtLabelDestroy(label);
    EXPECT_EQ(error, RT_ERROR_NONE);
    rtStreamDestroy(stream);

    error = rtModelDestroy(model);
    EXPECT_EQ(error, RT_ERROR_NONE);
    ((Runtime *)Runtime::Instance())->DeviceRelease(device);
}

class DavidTaskRecycleTest1 : public testing::Test {
protected:
    static void SetUpTestCase()
    {
        // backup oringal attribute of runtime
        MOCKER(halGetDeviceInfo).stubs().will(invoke(stubDavidGetDeviceInfo));
        char *socVer = "Ascend910_9599";
        MOCKER(halGetSocVersion)
            .stubs()
            .with(mockcpp::any(), outBoundP(socVer, strlen("Ascend910_9599")), mockcpp::any())
            .will(returnValue(DRV_ERROR_NONE));
        Runtime *rtInstance = (Runtime *)Runtime::Instance();
        g_disableThread = rtInstance->GetDisableThread();
        g_chipType = rtInstance->GetChipType();
        rtInstance->SetDisableThread(true);
        rtInstance->SetChipType(CHIP_DAVID);
        GlobalContainer::SetRtChipType(CHIP_DAVID);
    }

    static void TearDownTestCase()
    {
        // restore oringal attribute
        Runtime *rtInstance = (Runtime *)Runtime::Instance();
        rtInstance->SetDisableThread(g_disableThread);
        rtInstance->SetChipType(g_chipType);
        GlobalContainer::SetRtChipType(g_chipType);
    }

    virtual void SetUp()
    {
        std::cout << "TaskResManageTest SetUp start" << std::endl;
        Driver *driver_ = ((Runtime *)Runtime::Instance())->driverFactory_.GetDriver(NPU_DRIVER);
        MOCKER_CPP_VIRTUAL((NpuDriver *)(driver_), &NpuDriver::GetRunMode)
            .stubs()
            .will(returnValue((uint32_t)RT_RUN_MODE_ONLINE));
        MOCKER(halGetDeviceInfo).stubs().will(invoke(stubDavidGetDeviceInfo));
        char *socVer = "Ascend910_9599";
        MOCKER(halGetSocVersion)
            .stubs()
            .with(mockcpp::any(), outBoundP(socVer, strlen("Ascend910_9599")), mockcpp::any())
            .will(returnValue(DRV_ERROR_NONE));
        rtSetDevice(0);
        std::cout << "TaskResManageTest SetUp end" << std::endl;
    }

    virtual void TearDown()
    {
        std::cout << "TaskResManageTest TearDown start" << std::endl;
        rtDeviceReset(0);
        GlobalMockObject::verify();
        std::cout << "TaskResManageTest TearDown end" << std::endl;
    }
};
