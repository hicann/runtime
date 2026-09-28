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
#include "gtest/gtest.h"
#include "mockcpp/mockcpp.hpp"
#define protected public
#include "engine.hpp"
#undef protected
#include "event.hpp"
#include "scheduler.hpp"
#include "stars.hpp"
#include "stars_david.hpp"
#include "stream_david.hpp"
#include "hwts.hpp"
#include "npu_driver.hpp"
#include "event.hpp"
#include "subscribe.hpp"
#include "../../rt_utest_config_define.hpp"
#include "task_res.hpp"
#include "task_recycle.hpp"
#include "task_david.hpp"
#include "task_submit.hpp"
#include "raw_device.hpp"
#include "stars_engine.hpp"
#include "task_res_da.hpp"
#include "stream_sqcq_manage.hpp"
#include "model.hpp"
#include <thread>
#include <chrono>
#include "stream.hpp"
#include "runtime.hpp"
#include "driver/ascend_hal.h"
#include "osal.hpp"
#include "api.hpp"
#include "profiler_c.hpp"
#include "thread_local_container.hpp"
#include "dvpp_c.hpp"
#include "rt_unwrap.h"
using namespace testing;
using namespace cce::runtime;

static bool g_disableThread;
static rtChipType_t g_chipType;

extern int64_t g_device_driver_version_stub;

static drvError_t stubDavidGetDeviceInfo(uint32_t devId, int32_t moduleType, int32_t infoType, int64_t* value)
{
    if (value) {
        if (moduleType == MODULE_TYPE_SYSTEM && infoType == INFO_TYPE_VERSION) {
            *value = PLATFORMCONFIG_DAVID_950PR_9599;
        } else if (moduleType == MODULE_TYPE_SYSTEM && infoType == INFO_TYPE_CORE_NUM) {
            *value = g_device_driver_version_stub;
        } else {
            *value = 0;
        }
    }
    return DRV_ERROR_NONE;
}

static void VerifyStarsTaskMetadataAtConstruction(TaskInfo* taskInfo, void* const sqe, const TaskSqeInfo& sqeInfo)
{
    UNUSED(sqe);
    UNUSED(sqeInfo);
    EXPECT_EQ(taskInfo->sqeNum, GetSendSqeNum(taskInfo));
    EXPECT_EQ(taskInfo->pkgStat[RT_PACKAGE_TYPE_TASK_REPORT].expectPackage, 7U);
}

class DavidTaskSendTest : public testing::Test {
protected:
    static void SetUpTestCase()
    {
        // backup oringal attribute of runtime
        MOCKER(halGetDeviceInfo).stubs().will(invoke(stubDavidGetDeviceInfo));
        char* socVer = "Ascend950PR_9599";
        MOCKER(halGetSocVersion)
            .stubs()
            .with(mockcpp::any(), outBoundP(socVer, strlen("Ascend950PR_9599")), mockcpp::any())
            .will(returnValue(DRV_ERROR_NONE));
        Runtime* rtInstance = (Runtime*)Runtime::Instance();
        g_disableThread = rtInstance->GetDisableThread();
        g_chipType = rtInstance->GetChipType();
        rtInstance->SetDisableThread(true);
        rtInstance->SetChipType(CHIP_DAVID);
        GlobalContainer::SetRtChipType(CHIP_DAVID);
    }

    static void TearDownTestCase()
    {
        // restore oringal attribute
        Runtime* rtInstance = (Runtime*)Runtime::Instance();
        rtInstance->SetDisableThread(g_disableThread);
        rtInstance->SetChipType(g_chipType);
        GlobalContainer::SetRtChipType(g_chipType);
    }

    virtual void SetUp()
    {
        int64_t hardwareVersion = ((ARCH_V100 << 16) | (CHIP_DAVID << 8) | (VER_NA));
        Driver* driver = ((Runtime*)Runtime::Instance())->driverFactory_.GetDriver(NPU_DRIVER);
        MOCKER_CPP_VIRTUAL(driver, &Driver::GetDevInfo)
            .stubs()
            .with(mockcpp::any(), mockcpp::any(), mockcpp::any(), outBoundP(&hardwareVersion, sizeof(hardwareVersion)))
            .will(returnValue(RT_ERROR_NONE));
        char* socVer = "Ascend950PR_9599";
        MOCKER(halGetSocVersion)
            .stubs()
            .with(mockcpp::any(), outBoundP(socVer, strlen("Ascend950PR_9599")), mockcpp::any())
            .will(returnValue(DRV_ERROR_NONE));

        MOCKER_CPP_VIRTUAL(driver, &Driver::StreamBindLogicCq).stubs().will(returnValue(RT_ERROR_NONE));

        MOCKER_CPP_VIRTUAL(driver, &Driver::StreamUnBindLogicCq).stubs().will(returnValue(RT_ERROR_NONE));

        bool enable = false;
        MOCKER_CPP_VIRTUAL(driver, &Driver::GetSqEnable)
            .stubs()
            .with(mockcpp::any(), mockcpp::any(), mockcpp::any(), outBound(enable))
            .will(returnValue(RT_ERROR_NONE));

        MOCKER_CPP_VIRTUAL(driver, &Driver::SetSqHead).stubs().will(returnValue(RT_ERROR_NONE));
        MOCKER_CPP_VIRTUAL(driver, &Driver::EnableSq).stubs().will(returnValue(RT_ERROR_NONE));
        rtSetDevice(0);

        (void)rtSetSocVersion("Ascend950PR_9599");
        ((Runtime*)Runtime::Instance())->SetIsUserSetSocVersion(false);

        device_ = ((Runtime*)Runtime::Instance())->DeviceRetain(0, 0);
        device_->SetChipType(CHIP_DAVID);
        engine_ = ((RawDevice*)device_)->engine_;

        rtError_t res = rtStreamCreate(&streamHandle_, 0);
        EXPECT_EQ(res, RT_ERROR_NONE);
        stream_ = rt_ut::UnwrapOrNull<Stream>(streamHandle_);

        stream_->SetSqMemAttr(false);
        TaskResManageDavid* taskResMang = ((TaskResManageDavid*)(static_cast<Stream*>(stream_)->taskResMang_));
        MOCKER_CPP_VIRTUAL(driver, &Driver::GetSqHead)
            .stubs()
            .with(mockcpp::any(), mockcpp::any(), mockcpp::any(), outBound(taskResMang->GetResTail()))
            .will(returnValue(RT_ERROR_NONE));
    }

    virtual void TearDown()
    {
        while (stream_->GetPendingNum() > 0) {
            stream_->pendingNum_.Sub(1U);
        }
        while (engine_->GetPendingNum() > 0) {
            engine_->pendingNum_.Set(0U);
        }
        rtStreamDestroy(streamHandle_);
        stream_ = nullptr;
        engine_ = nullptr;
        ((Runtime*)Runtime::Instance())->DeviceRelease(device_);
        ((Runtime*)Runtime::Instance())->SetIsUserSetSocVersion(false);
        rtDeviceReset(0);
        GlobalMockObject::reset();
    }

    void VerifyStarsSendTaskMetadataBeforeConstruction(const tsTaskType_t taskType, const uint8_t expectedSqeNum)
    {
        constexpr uint16_t initialReportNum = 7U;
        TaskInfo task = {};
        InitByStream(&task, stream_);
        task.type = taskType;
        task.typeName = "REPORT_COUNT_TEST";
        task.pkgStat[RT_PACKAGE_TYPE_TASK_REPORT].expectPackage = initialReportNum;
        if (taskType == TS_TASK_TYPE_MULTIPLE_TASK) {
            task.u.davinciMultiTaskInfo.sqeNum = expectedSqeNum;
        }

        TaskResManage* const taskResManage = stream_->taskResMang_;
        stream_->taskResMang_ = nullptr;
        const ScopeGuard restoreTaskResManage([&]() { stream_->taskResMang_ = taskResManage; });
        MOCKER_CPP_VIRTUAL(engine_, &Engine::TryRecycleTask).stubs().will(returnValue(RT_ERROR_NONE));
        MOCKER(ToConstructSqe).expects(once()).will(invoke(VerifyStarsTaskMetadataAtConstruction));
        MOCKER_CPP(&StarsEngine::AddTaskToStream).expects(once()).will(returnValue(RT_ERROR_INVALID_VALUE));

        const rtError_t error = StarsAllocTaskAndSend(&task, stream_, nullptr);

        EXPECT_EQ(error, RT_ERROR_INVALID_VALUE);
        EXPECT_EQ(task.sqeNum, expectedSqeNum);
    }

    void VerifyDavidSendTaskMetadataAfterConstruction(
        TaskInfo& task, const uint8_t expectedSqeNum, const uint16_t expectedReportNum)
    {
        task.id = 0U;
        task.sqeNum = expectedSqeNum;
        task.pkgStat[RT_PACKAGE_TYPE_TASK_REPORT].expectPackage = 1U;
        TaskSqeBuffer sqeBuffer = {};
        const uint64_t oldSqBaseAddr = stream_->GetSqBaseAddr();
        stream_->SetSqBaseAddr(RtPtrToValue(sqeBuffer.data));
        const ScopeGuard restoreSqBaseAddr([&]() { stream_->SetSqBaseAddr(oldSqBaseAddr); });
        MOCKER_CPP_VIRTUAL(stream_, &Stream::StarsAddTaskToStream)
            .expects(once())
            .will(returnValue(RT_ERROR_INVALID_VALUE));

        const rtError_t error = DavidSendTask(&task, stream_);

        EXPECT_EQ(error, RT_ERROR_INVALID_VALUE);
        EXPECT_EQ(task.sqeNum, expectedSqeNum);
        EXPECT_EQ(task.pkgStat[RT_PACKAGE_TYPE_TASK_REPORT].expectPackage, expectedReportNum);
    }

public:
    Device* device_ = nullptr;
    Stream* stream_ = nullptr;
    Engine* engine_ = nullptr;
    rtStream_t streamHandle_ = 0;
};

TEST_F(DavidTaskSendTest, StarsSendMemWaitCachesThreeSqesBeforeConstruction)
{
    VerifyStarsSendTaskMetadataBeforeConstruction(TS_TASK_TYPE_MEM_WAIT_VALUE, MEM_WAIT_V2_SQE_NUM);
}

TEST_F(DavidTaskSendTest, StarsSendCcuCachesTwoSqesBeforeConstruction)
{
    VerifyStarsSendTaskMetadataBeforeConstruction(TS_TASK_TYPE_CCU_LAUNCH, 2U);
}

TEST_F(DavidTaskSendTest, StarsSendMultipleCachesFourSqesBeforeConstruction)
{
    VerifyStarsSendTaskMetadataBeforeConstruction(TS_TASK_TYPE_MULTIPLE_TASK, 4U);
}

TEST_F(DavidTaskSendTest, DavidSendExternalWaitKeepsThreeSqesAndOneReportAfterConstruction)
{
    TaskInfo task = {};
    InitByStream(&task, stream_);
    task.type = TS_TASK_TYPE_CAPTURE_WAIT_EXTERNAL;
    task.typeName = "CAPTURE_WAIT_EXTERNAL";

    VerifyDavidSendTaskMetadataAfterConstruction(task, MEM_WAIT_V2_SQE_NUM, 1U);
}

TEST_F(DavidTaskSendTest, DavidSendCcuKeepsTwoSqesAndOneReportAfterConstruction)
{
    uint32_t args[RT_CCU_SQE_ARGS_LEN * 2U] = {};
    TaskInfo task = {};
    InitByStream(&task, stream_);
    task.type = TS_TASK_TYPE_CCU_LAUNCH;
    task.typeName = "CCU_LAUNCH";
    task.u.ccuLaunchTask.args = args;

    VerifyDavidSendTaskMetadataAfterConstruction(task, 2U, 1U);
}

TEST_F(DavidTaskSendTest, DavidSendMultipleSetsOneReportPerSqeAfterConstruction)
{
    constexpr uint8_t sqeNum = 4U;
    rtTaskDesc_t taskDesc[sqeNum] = {};
    uint8_t cmdListMarker = 0U;
    const uint64_t cmdListAddr = RtPtrToValue(&cmdListMarker);
    for (auto& desc : taskDesc) {
        desc.u.dvppTaskDesc.sqe.commandCustom[STARS_DVPP_SQE_CMDLIST_ADDR_LOW_IDX] =
            static_cast<uint32_t>(cmdListAddr & 0xFFFFFFFFULL);
        desc.u.dvppTaskDesc.sqe.commandCustom[STARS_DVPP_SQE_CMDLIST_ADDR_HIGH_IDX] =
            static_cast<uint32_t>(cmdListAddr >> UINT32_BIT_NUM);
    }
    rtMultipleTaskInfo_t multipleTaskInfo = {sqeNum, taskDesc};
    std::vector<void*> cmdListVec;
    TaskInfo task = {};
    InitByStream(&task, stream_);
    task.type = TS_TASK_TYPE_MULTIPLE_TASK;
    task.typeName = "MULTIPLE_TASK";
    task.u.davinciMultiTaskInfo.multipleTaskInfo = &multipleTaskInfo;
    task.u.davinciMultiTaskInfo.cmdListVec = &cmdListVec;

    VerifyDavidSendTaskMetadataAfterConstruction(task, sqeNum, sqeNum);
}

TEST_F(DavidTaskSendTest, DavidAllocAndSendFlipTask_Fail)
{
    Runtime::Instance()->SetTrackProfFlag(true);
    ((DavidStream*)stream_)->SetSqMemAttr(false);
    rtDavidSqe_t* sqe = (rtDavidSqe_t*)malloc(sizeof(rtDavidSqe_t));
    uint64_t oldSqAddr = stream_->GetSqBaseAddr();
    uint64_t newSqAddr = reinterpret_cast<uint64_t>(sqe);
    stream_->SetSqBaseAddr(newSqAddr);
    MOCKER_CPP_VIRTUAL((DavidStream*)stream_, &DavidStream::StarsAddTaskToStream).stubs().will(returnValue(1));
    rtError_t res = DavidAllocAndSendFlipTask(stream_, 2048);
    EXPECT_NE(res, RT_ERROR_NONE);
    stream_->SetSqBaseAddr(oldSqAddr);
    free(sqe);
    Runtime::Instance()->SetTrackProfFlag(false);
}

TEST_F(DavidTaskSendTest, david_send_aicpu_msg_version_task)
{
    Stream* const primaryStream = device_->PrimaryStream_();
    ASSERT_NE(primaryStream, nullptr);
    const uint16_t head = static_cast<uint16_t>((primaryStream->GetTaskPosTail() + 1U) % primaryStream->GetSqDepth());
    Driver* driver = ((Runtime*)Runtime::Instance())->driverFactory_.GetDriver(NPU_DRIVER);
    MOCKER(GetDrvSqHead).stubs().with(mockcpp::any(), outBound(head)).will(returnValue(RT_ERROR_NONE));
    primaryStream->SetSqBaseAddr(0U);
    device_->SendTopicMsgVersionToAicpu();
    GlobalMockObject::verify();
}
