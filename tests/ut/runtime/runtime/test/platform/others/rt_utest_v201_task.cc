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
#include <unistd.h>

#include "driver/ascend_hal.h"
#include "runtime/rt.h"
#include "rts_dqs.h"
#include "gtest/gtest.h"
#include "mockcpp/mockcpp.hpp"
#include "engine.hpp"
#include "cond_c.hpp"
#include "task_res.hpp"
#include "stream.hpp"
#include "stream_sqcq_manage.hpp"
#include "scheduler.hpp"
#include "runtime.hpp"
#include "event.hpp"
#include "event_david.hpp"
#include "raw_device.hpp"
#include "task_info.hpp"
#include "context.hpp"
#include "stream_david.hpp"
#include "stars_david.hpp"
#include "task_david.hpp"
#include "event_c.hpp"
#include "notify_c.hpp"
#include "stream_c.hpp"
#include "cond_c.hpp"
#include "memcpy_c.hpp"
#include "model_c.hpp"
#include "task_recycle.hpp"
#include "securec.h"
#include "npu_driver.hpp"
#include "task_submit.hpp"
#include "thread_local_container.hpp"
#include "config_define.hpp"
#include "task_res_da.hpp"
#include "task_manager_david.h"
#include "stars_model_execute_cond_isa_define.hpp"
#include "stars_cond_isa_helper.hpp"
#include "stars_dqs_cond_isa_helper.hpp"
#include "stream_creator_c.hpp"
#include "stream_with_dqs.hpp"
#include "dqs_c.hpp"
#include "task_info.hpp"
#include "dqs_task_info.hpp"
#include "ioctl_utils.hpp"
#include "notify.hpp"
#include "config_define_adc.hpp"
#include "driver/ascend_hal.h"
#include "api_impl_david.hpp"
#include "aicpu_c.hpp"
#include "aix_c.hpp"
#include "para_convertor.hpp"
#include "api_decorator.hpp"

using namespace testing;
using namespace cce::runtime;
extern int64_t g_device_driver_version_stub;
static rtChipType_t g_chipType;
static drvError_t halGetDeviceInfoStub(uint32_t devId, int32_t moduleType, int32_t infoType, int64_t *value)
{
    if (value) {
        if (moduleType == MODULE_TYPE_SYSTEM && infoType == INFO_TYPE_VERSION) {
            *value = PLATFORMCONFIG_MC62CM12A;
        } else if (moduleType == MODULE_TYPE_SYSTEM && infoType == INFO_TYPE_CORE_NUM) { // tsnum
            *value = 2;
        } else if (moduleType == MODULE_TYPE_AICORE && infoType == INFO_TYPE_DIE_NUM) {  // P dienum
            *value = 1;
        } else {
        }
    }
    return DRV_ERROR_NONE;
}

static drvError_t halGetDeviceInfoStubF(uint32_t devId, int32_t moduleType, int32_t infoType, int64_t *value)
{
    if (value) {
        if (moduleType == MODULE_TYPE_SYSTEM && infoType == INFO_TYPE_VERSION) {
            *value = PLATFORMCONFIG_MC62CM12A;
        } else if (moduleType == MODULE_TYPE_SYSTEM && infoType == INFO_TYPE_CORE_NUM) { // tsnum
            *value = 2;
        } else if (moduleType == MODULE_TYPE_AICORE && infoType == INFO_TYPE_DIE_NUM) {  // dienum
            *value = 0;
        } else {
        }
    }
    return DRV_ERROR_NONE;
}

rtError_t TmpCloseFd()
{
    throw std::runtime_error("close exception");
    return RT_ERROR_NONE;
}

// Developers can stub the IoctlByCmd calls for different commands here.
rtError_t IoctlByCmdMockRes(IoctlUtil *that, const stars_ioctl_cmd_t cmd, const stars_ioctl_cmd_args_t *args)
{
    static stars_dqs_ctrl_space_t ctrlSpace = {};
    stars_dqs_ctrl_space_result_t *csResult = nullptr;
    stars_dqs_queue_mbuf_pool_result_t *mbufPoolRes = nullptr;
    stars_get_queue_mbuf_pool_info_param_t *mbufPoolInfoParam = nullptr;
    switch (cmd) {
        case STARS_IOCTL_CMD_DQS_CONTROL_SPACE:
            csResult = static_cast<stars_dqs_ctrl_space_result_t *>(args->output_ptr);
            if (csResult == nullptr) {
                return RT_ERROR_INVALID_VALUE;
            }
            csResult->cs_va = &ctrlSpace;
            break;
        case STARS_IOCTL_CMD_GET_QUEUE_MBUF_POOL:
            mbufPoolRes = static_cast<stars_dqs_queue_mbuf_pool_result_t *>(args->output_ptr);
            mbufPoolInfoParam = static_cast<stars_get_queue_mbuf_pool_info_param_t *>(args->input_ptr);
            mbufPoolRes->count = mbufPoolInfoParam->count;
            if ((mbufPoolRes == nullptr) || (mbufPoolInfoParam == nullptr) ||
                (mbufPoolInfoParam->count > STARS_DQS_MAX_OUTPUT_QUEUE_NUM)) {
                return RT_ERROR_INVALID_VALUE;
            }
            for (uint32_t i = 0; i < mbufPoolRes->count; i++) {
                mbufPoolRes->queue_mbuf_pool_list[i].qid = mbufPoolInfoParam->queue_list[i];
            }
            break; 
        default:
            break;
    }

    return RT_ERROR_NONE;
}

rtError_t StubGetDqsQueInfo(NpuDriver *drv, const uint32_t devId, const uint32_t qid, DqsQueueInfo *queInfo)
{
    queInfo->queType = QMNGR_ENTITY_TYPE;
    if (qid >= 512) {
        queInfo->queType = GQM_ENTITY_TYPE;
    }

    return RT_ERROR_NONE;
}

class TaskTestV201 : public testing::Test {
protected:
    static void SetUpTestCase()
    {
        MOCKER(halGetDeviceInfo).stubs().will(invoke(halGetDeviceInfoStub));
        MOCKER_CPP(&IoctlUtil::CloseFd).stubs().will(invoke(TmpCloseFd));
        char *socVer = "MC62CM12AA";
        MOCKER(halGetSocVersion)
            .stubs()
            .with(mockcpp::any(), outBoundP(socVer, strlen("MC62CM12AA")))
            .will(returnValue(DRV_ERROR_NONE));
        MOCKER(halSqTaskSend).stubs().will(returnValue(RT_ERROR_NONE));
        std::cout << "TaskTestV201 SetUP" << std::endl;
        Runtime *rtInstance = (Runtime *)Runtime::Instance();
        rtInstance->SetDisableThread(true);
        g_chipType = rtInstance->GetChipType();
        rtInstance->SetChipType(CHIP_MC62CM12A);
        GlobalContainer::SetRtChipType(CHIP_MC62CM12A);
        rtInstance->SetConnectUbFlag(false);
        std::cout << "TaskTestDavid start" << std::endl;
    }

    static void TearDownTestCase()
    {
        MOCKER(halGetDeviceInfo).stubs().will(invoke(halGetDeviceInfoStub));
        MOCKER_CPP(&IoctlUtil::CloseFd).stubs().will(invoke(TmpCloseFd));
        Runtime *rtInstance = (Runtime *)Runtime::Instance();
        rtInstance->SetChipType(g_chipType);
        GlobalContainer::SetRtChipType(g_chipType);
        rtInstance->SetDisableThread(false);
        rtInstance->SetConnectUbFlag(false);
        std::cout << "UbStreamTest end" << std::endl;
    }

    virtual void SetUp()
    {
        MOCKER(halGetDeviceInfo).stubs().will(invoke(halGetDeviceInfoStub));
        MOCKER_CPP(&IoctlUtil::CloseFd).stubs().will(invoke(TmpCloseFd));
        Driver *driver = ((Runtime *)Runtime::Instance())->driverFactory_.GetDriver(NPU_DRIVER);
        char *socVer = "MC62CM12AA";
        MOCKER(halGetSocVersion)
            .stubs()
            .with(mockcpp::any(), outBoundP(socVer, strlen("MC62CM12AA")))
            .will(returnValue(DRV_ERROR_NONE));
        MOCKER(halSqTaskSend).stubs().will(returnValue(RT_ERROR_NONE));
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

        (void)rtSetSocVersion("MC62CM12AA");

        device_ = ((Runtime *)Runtime::Instance())->DeviceRetain(0, 0);
        device_->SetPlatformType(PLATFORM_MC62CM12A);
        engine_ = ((RawDevice *)device_)->engine_;

        MOCKER_CPP(&IoctlUtil::IoctlByCmd).defaults().will(invoke(IoctlByCmdMockRes));
        rtError_t res = rtStreamCreateWithFlags(&streamHandle_, 0, RT_STREAM_DQS_CTRL);
        EXPECT_EQ(res, RT_ERROR_NONE);
        stream_ = (Stream *)streamHandle_;

        stream_->SetSqMemAttr(false);
        TaskResManageDavid *taskResMang = ((TaskResManageDavid *)(static_cast<Stream *>(stream_)->taskResMang_));
        MOCKER_CPP_VIRTUAL(driver, &Driver::GetSqHead)
            .stubs()
            .with(mockcpp::any(), mockcpp::any(), mockcpp::any(), outBound(taskResMang->GetTaskPosTail()))
            .will(returnValue(RT_ERROR_NONE));
    }

    virtual void TearDown()
    {
        MOCKER(halGetDeviceInfo).stubs().will(invoke(halGetDeviceInfoStub));
        MOCKER_CPP(&IoctlUtil::CloseFd).stubs().will(invoke(TmpCloseFd));
        while (stream_->GetPendingNum() > 0) {
            stream_->pendingNum_.Sub(1U);
        }
        while (engine_->GetPendingNum() > 0) {
            engine_->pendingNum_.Set(0U);
        }
        rtStreamDestroy(streamHandle_);
        stream_ = nullptr;
        engine_ = nullptr;
        ((Runtime *)Runtime::Instance())->DeviceRelease(device_);
        rtDeviceReset(0);
        GlobalMockObject::reset();
    }

public:
    Device *device_ = nullptr;
    Stream *stream_ = nullptr;
    Engine *engine_ = nullptr;
    rtStream_t streamHandle_ = 0;
};

class TaskTestV201F : public testing::Test {
protected:
    static void SetUpTestCase()
    {
        MOCKER(halGetDeviceInfo).stubs().will(invoke(halGetDeviceInfoStubF));
        MOCKER_CPP(&IoctlUtil::CloseFd).stubs().will(invoke(TmpCloseFd));
        char *socVer = "MC62CM12AA";
        MOCKER(halGetSocVersion)
            .stubs()
            .with(mockcpp::any(), outBoundP(socVer, strlen("MC62CM12AA")))
            .will(returnValue(DRV_ERROR_NONE));
        MOCKER(halSqTaskSend).stubs().will(returnValue(RT_ERROR_NONE));
        std::cout << "TaskTestV201 SetUP" << std::endl;
        Runtime *rtInstance = (Runtime *)Runtime::Instance();
        rtInstance->SetDisableThread(true);
        g_chipType = rtInstance->GetChipType();
        rtInstance->SetChipType(CHIP_MC62CM12A);
        GlobalContainer::SetRtChipType(CHIP_MC62CM12A);
        rtInstance->SetConnectUbFlag(false);
        std::cout << "TaskTestDavid start" << std::endl;
    }

    static void TearDownTestCase()
    {
        MOCKER(halGetDeviceInfo).stubs().will(invoke(halGetDeviceInfoStub));
        MOCKER_CPP(&IoctlUtil::CloseFd).stubs().will(invoke(TmpCloseFd));
        Runtime *rtInstance = (Runtime *)Runtime::Instance();
        rtInstance->SetChipType(g_chipType);
        GlobalContainer::SetRtChipType(g_chipType);
        rtInstance->SetDisableThread(false);
        rtInstance->SetConnectUbFlag(false);
        std::cout << "UbStreamTest end" << std::endl;
    }

    virtual void SetUp()
    {
        MOCKER(halGetDeviceInfo).stubs().will(invoke(halGetDeviceInfoStub));
        MOCKER_CPP(&IoctlUtil::CloseFd).stubs().will(invoke(TmpCloseFd));
        Driver *driver = ((Runtime *)Runtime::Instance())->driverFactory_.GetDriver(NPU_DRIVER);
        char *socVer = "MC62CM12AA";
        MOCKER(halGetSocVersion)
            .stubs()
            .with(mockcpp::any(), outBoundP(socVer, strlen("MC62CM12AA")))
            .will(returnValue(DRV_ERROR_NONE));
        MOCKER(halSqTaskSend).stubs().will(returnValue(RT_ERROR_NONE));
        MOCKER_CPP_VIRTUAL(driver, &Driver::StreamBindLogicCq).stubs().will(returnValue(RT_ERROR_NONE));
        MOCKER_CPP_VIRTUAL(driver, &Driver::StreamUnBindLogicCq).stubs().will(returnValue(RT_ERROR_NONE));

        bool enable = false;
        MOCKER_CPP_VIRTUAL(driver, &Driver::GetSqEnable)
            .stubs()
            .with(mockcpp::any(), mockcpp::any(), mockcpp::any(), outBound(enable))
            .will(returnValue(RT_ERROR_NONE));

        MOCKER_CPP_VIRTUAL(driver, &Driver::SetSqHead).stubs().will(returnValue(RT_ERROR_NONE));
        MOCKER_CPP_VIRTUAL(driver, &Driver::EnableSq).stubs().will(returnValue(RT_ERROR_NONE));
        rtSetTSDevice(1);
        rtSetDevice(0);

        (void)rtSetSocVersion("MC62CM12AA");

        device_ = ((Runtime *)Runtime::Instance())->DeviceRetain(0, 0);
        device_->SetPlatformType(PLATFORM_MC62CM12A);
        engine_ = ((RawDevice *)device_)->engine_;

        MOCKER_CPP(&IoctlUtil::IoctlByCmd).defaults().will(invoke(IoctlByCmdMockRes));
        rtError_t res = rtStreamCreateWithFlags(&streamHandle_, 0, RT_STREAM_DQS_CTRL);
        EXPECT_EQ(res, RT_ERROR_NONE);
        stream_ = (Stream *)streamHandle_;

        stream_->SetSqMemAttr(false);
        TaskResManageDavid *taskResMang = ((TaskResManageDavid *)(static_cast<Stream *>(stream_)->taskResMang_));
        MOCKER_CPP_VIRTUAL(driver, &Driver::GetSqHead)
            .stubs()
            .with(mockcpp::any(), mockcpp::any(), mockcpp::any(), outBound(taskResMang->GetTaskPosTail()))
            .will(returnValue(RT_ERROR_NONE));
    }

    virtual void TearDown()
    {
        MOCKER(halGetDeviceInfo).stubs().will(invoke(halGetDeviceInfoStub));
        MOCKER_CPP(&IoctlUtil::CloseFd).stubs().will(invoke(TmpCloseFd));
        while (stream_->GetPendingNum() > 0) {
            stream_->pendingNum_.Sub(1U);
        }
        while (engine_->GetPendingNum() > 0) {
            engine_->pendingNum_.Set(0U);
        }
        rtStreamDestroy(streamHandle_);
        stream_ = nullptr;
        engine_ = nullptr;
        ((Runtime *)Runtime::Instance())->DeviceRelease(device_);
        rtDeviceReset(0);
        GlobalMockObject::reset();
    }

public:
    Device *device_ = nullptr;
    Stream *stream_ = nullptr;
    Engine *engine_ = nullptr;
    rtStream_t streamHandle_ = 0;
};

TEST_F(TaskTestV201, Test_DqsTask_Config_multi_channel)
{
    rtDqsTaskCfg_t cfg = {};
    rtDqsSchedCfg_t schedCfg = {};
    schedCfg.inputQueueNum = 2;
    schedCfg.outputQueueNum = 2;
    schedCfg.type = 1;
    schedCfg.inputQueueIds[0] = 513U;
    schedCfg.inputQueueIds[1] = 514U;
    schedCfg.outputQueueIds[0] = 0U;
    schedCfg.outputQueueIds[1] = 1U;
    cfg.cfg = &schedCfg;
    cfg.type = RT_DQS_TASK_SCHED_CONFIG;
    MOCKER_CPP_VIRTUAL((NpuDriver*)(device_->Driver_()), &NpuDriver::GetDqsQueInfo).stubs().will(invoke(StubGetDqsQueInfo));
    rtError_t error = DqsLaunchTask(stream_, &cfg);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(TaskTestV201, Test_DqsTask_01)
{
    MOCKER(DavidSendTask).stubs().will(returnValue(RT_ERROR_FEATURE_NOT_SUPPORT));
    MOCKER(CheckTaskCanSend).stubs().will(returnValue(RT_ERROR_NONE));
    Stream *stm = CreateStreamAndGet(device_, 0, RT_STREAM_DQS_CTRL, nullptr);
    EXPECT_NE(stm, nullptr);

    TaskInfo task1 = {};
    DqsCommonTaskInfo dqsDequeueTask = {};
    task1.u.dqsDequeueTask = dqsDequeueTask;
    TaskInfo *tmpTask = &task1;

    stars_dqs_ctrl_space_t ctrlSpace = {};
    StreamWithDqs *streamWithDqs = (StreamWithDqs *)stm;
    streamWithDqs->SetDqsCtrlSpace(&ctrlSpace);
    MOCKER(AllocTaskInfo).stubs().with(outBoundP(&tmpTask)).will(returnValue(RT_ERROR_NONE));
    rtDqsTaskCfg_t cfg = {};
    cfg.type = RT_DQS_TASK_DEQUEUE;
    rtError_t error = DqsLaunchTask(stm, &cfg);
    EXPECT_NE(error, RT_ERROR_NONE);
    rtDqsPrepareCfg_t prepareCfg = {};
    cfg.type = RT_DQS_TASK_PREPARE_OUT;
    cfg.cfg = &prepareCfg;
    error = DqsLaunchTask(stm, &cfg);
    EXPECT_NE(error, RT_ERROR_NONE);

    delete stm;
}

TEST_F(TaskTestV201, Test_Batch_Deque_Task_Send_Excepiton) // DavidSendTask失败场景校验
{
    MOCKER(DavidSendTask).stubs().will(returnValue(RT_ERROR_FEATURE_NOT_SUPPORT));
    MOCKER(CheckTaskCanSend).stubs().will(returnValue(RT_ERROR_NONE));
    Stream *stm = CreateStreamAndGet(device_, 0, RT_STREAM_DQS_CTRL, nullptr);
    EXPECT_NE(stm, nullptr);

    TaskInfo task1 = {};
    DqsCommonTaskInfo dqsBatchDequeueTask = {};
    task1.u.dqsBatchDequeueTask = dqsBatchDequeueTask;
    TaskInfo *tmpTask = &task1;

    stars_dqs_ctrl_space_t ctrlSpace = {};
    StreamWithDqs *streamWithDqs = (StreamWithDqs *)stm;
    ctrlSpace.input_queue_num = 3; /* 3为多通路场景 */
    streamWithDqs->SetDqsCtrlSpace(&ctrlSpace);
    MOCKER(AllocTaskInfo).stubs().with(outBoundP(&tmpTask)).will(returnValue(RT_ERROR_NONE)); // AllocTaskInfo返回tmpTask，返回值为RT_ERROR_NONE

    rtDqsTaskCfg_t cfg = {};
    cfg.type = RT_DQS_TASK_DEQUEUE;
    cfg.cfg = nullptr;
    rtError_t error = DqsLaunchTask(stm, &cfg);
    EXPECT_NE(error, RT_ERROR_NONE); // 期待返回值报错

    delete stm;
}

TEST_F(TaskTestV201, Test_Batch_Deque_Task_Copy_Excepiton) // device_->Driver_()返回RT_ERROR_DRV_ERR场景校验
{
    MOCKER(CheckTaskCanSend).stubs().will(returnValue(RT_ERROR_NONE));
    Stream *stm = CreateStreamAndGet(device_, 0, RT_STREAM_DQS_CTRL, nullptr);
    EXPECT_NE(stm, nullptr);
    TaskInfo task1 = {};
    DqsCommonTaskInfo dqsBatchDequeueTask = {};
    task1.u.dqsBatchDequeueTask = dqsBatchDequeueTask;
    TaskInfo *tmpTask = &task1;

    MOCKER(AllocTaskInfo).stubs().with(outBoundP(&tmpTask)).will(returnValue(RT_ERROR_NONE)); // AllocTaskInfo的出参返回tmpTask
    MOCKER_CPP_VIRTUAL(device_->Driver_(), &Driver::MemCopySync).stubs().will(returnValue(RT_ERROR_DRV_ERR)); // device_->Driver_()返回RT_ERROR_DRV_ERR
    stars_dqs_ctrl_space_t ctrlSpace = {};
    ctrlSpace.input_queue_num = 3; /* 3为多通路场景 */
    StreamWithDqs *streamWithDqs = (StreamWithDqs *)stm;
    streamWithDqs->SetDqsCtrlSpace(&ctrlSpace);
    rtDqsTaskCfg_t cfg = {};
    cfg.type = RT_DQS_TASK_DEQUEUE;
    cfg.cfg = nullptr;
    rtError_t error = DqsLaunchTask(stm, &cfg);
    EXPECT_NE(error, RT_ERROR_NONE);

    delete stm;
}

TEST_F(TaskTestV201, Test_Batch_Deque_Task_ChipID_Excepiton) // halCentreNotifyGet返回异常场景校验
{
    MOCKER(CheckTaskCanSend).stubs().will(returnValue(RT_ERROR_NONE));
    Stream *stm = CreateStreamAndGet(device_, 0, RT_STREAM_DQS_CTRL, nullptr);
    EXPECT_NE(stm, nullptr);
    TaskInfo task1 = {};
    DqsCommonTaskInfo dqsBatchDequeueTask = {};
    task1.u.dqsBatchDequeueTask = dqsBatchDequeueTask;
    TaskInfo *tmpTask = &task1;
    MOCKER(halCentreNotifyGet).stubs().will(returnValue(DRV_ERROR_NO_DEVICE)); // 打桩halCentreNotifyGet异常场景
    MOCKER(AllocTaskInfoForCapture).stubs().with(outBoundP(&tmpTask)).will(returnValue(RT_ERROR_NONE));
    MOCKER(AllocTaskInfo).stubs().with(outBoundP(&tmpTask)).will(returnValue(RT_ERROR_NONE)); // AllocTaskInfo的出参返回tmpTask
    stars_dqs_ctrl_space_t ctrlSpace = {};
    ctrlSpace.input_queue_num = 2U;
    StreamWithDqs *streamWithDqs = (StreamWithDqs *)stm;
    streamWithDqs->SetDqsCtrlSpace(&ctrlSpace);

    TaskInfo task2 = {};
    NotifyWaitTaskInfo notifyWaitTask = {};
    task2.u.notifywaitTask = notifyWaitTask;
    TaskInfo *waitTask = &task2;

    MOCKER_CPP(&Stream::AllocTask).stubs().will(returnValue(waitTask));
    MOCKER(SubmitTaskPostProc).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP(&IoctlUtil::IoctlByCmd).stubs().will(returnValue(RT_ERROR_NONE));

    rtDqsTaskCfg_t cfg = {};
    cfg.type = RT_DQS_TASK_NOTIFY_WAIT;
    cfg.cfg = nullptr;
    rtError_t error = DqsLaunchTask(stm, &cfg);
    EXPECT_EQ(error, RT_ERROR_NONE);

    cfg = {};
    cfg.type = RT_DQS_TASK_DEQUEUE;
    cfg.cfg = nullptr;
    error = DqsLaunchTask(stm, &cfg);
    EXPECT_NE(error, RT_ERROR_NONE); // 期待返回值报错

    delete stm;
}

TEST_F(TaskTestV201, Test_Batch_Deque_Task) // halCentreNotifyGet正常返回场景
{
    MOCKER(CheckTaskCanSend).stubs().will(returnValue(RT_ERROR_NONE));
    Stream *stm = CreateStreamAndGet(device_, 0, RT_STREAM_DQS_CTRL, nullptr);
    EXPECT_NE(stm, nullptr);
    TaskInfo task1 = {};
    DqsCommonTaskInfo dqsBatchDequeueTask = {};
    task1.u.dqsBatchDequeueTask = dqsBatchDequeueTask;
    TaskInfo *tmpTask = &task1;
    MOCKER(halCentreNotifyGet).stubs().will(returnValue(DRV_ERROR_NONE)); // 打桩halCentreNotifyGet异常场景
    MOCKER(AllocTaskInfoForCapture).stubs().with(outBoundP(&tmpTask)).will(returnValue(RT_ERROR_NONE));
    MOCKER(AllocTaskInfo).stubs().with(outBoundP(&tmpTask)).will(returnValue(RT_ERROR_NONE)); // AllocTaskInfo的出参返回tmpTask
    stars_dqs_ctrl_space_t ctrlSpace = {};
    ctrlSpace.input_queue_num = 2U;
    StreamWithDqs *streamWithDqs = (StreamWithDqs *)stm;
    streamWithDqs->SetDqsCtrlSpace(&ctrlSpace);

    TaskInfo task2 = {};
    NotifyWaitTaskInfo notifyWaitTask = {};
    task2.u.notifywaitTask = notifyWaitTask;
    TaskInfo *waitTask = &task2;

    MOCKER_CPP(&Stream::AllocTask).stubs().will(returnValue(waitTask));
    MOCKER(SubmitTaskPostProc).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP(&IoctlUtil::IoctlByCmd).stubs().will(returnValue(RT_ERROR_NONE));

    rtDqsTaskCfg_t cfg = {};
    cfg.type = RT_DQS_TASK_NOTIFY_WAIT;
    cfg.cfg = nullptr;
    rtError_t error = DqsLaunchTask(stm, &cfg);
    EXPECT_EQ(error, RT_ERROR_NONE);

    cfg = {};
    cfg.type = RT_DQS_TASK_DEQUEUE;
    cfg.cfg = nullptr;
    error = DqsLaunchTask(stm, &cfg);
    EXPECT_EQ(error, RT_ERROR_NONE); // 期待返回值报错

    delete stm;
}

TEST_F(TaskTestV201, Test_DqsTask_Enqueue_Deque_exception)
{
    MOCKER(CheckTaskCanSend).stubs().will(returnValue(RT_ERROR_NONE));
    Stream *stm = CreateStreamAndGet(device_, 0, RT_STREAM_DQS_CTRL, nullptr);
    EXPECT_NE(stm, nullptr);
    TaskInfo task1 = {};
    DqsCommonTaskInfo dqsDequeueTask = {};
    task1.u.dqsDequeueTask = dqsDequeueTask;
    TaskInfo *tmpTask = &task1;

    MOCKER(AllocTaskInfo).stubs().with(outBoundP(&tmpTask)).will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL(device_->Driver_(), &Driver::MemCopySync).stubs().will(returnValue(RT_ERROR_DRV_ERR));
    stars_dqs_ctrl_space_t ctrlSpace = {};
    StreamWithDqs *streamWithDqs = (StreamWithDqs *)stm;
    streamWithDqs->SetDqsCtrlSpace(&ctrlSpace);

    rtDqsTaskCfg_t cfg = {};
    cfg.type = RT_DQS_TASK_ENQUEUE;
    rtError_t error = DqsLaunchTask(stm, &cfg);
    EXPECT_NE(error, RT_ERROR_NONE);

    DqsCommonTaskInfo enqueueTask = {};
    task1.u.dqsEnqueueTask = enqueueTask;
    tmpTask = &task1;

    cfg.type = RT_DQS_TASK_ENQUEUE;
    error = DqsLaunchTask(stm, &cfg);
    EXPECT_NE(error, RT_ERROR_NONE);

    delete stm;
}

TEST_F(TaskTestV201, Test_DqsTask_SchedConfig_hal_error)
{
    MOCKER(CheckTaskCanSend).stubs().will(returnValue(RT_ERROR_NONE));
    Stream *stm = CreateStreamAndGet(device_, 0, RT_STREAM_DQS_CTRL, nullptr);
    EXPECT_NE(stm, nullptr);
    MOCKER(halQueueGetDqsQueInfo).stubs().will(returnValue(DRV_ERROR_NOT_SUPPORT));
    rtDqsSchedCfg_t schedCfg = {};
    schedCfg.type = 1U;
    schedCfg.inputQueueNum = 2;
    schedCfg.outputQueueNum = 2;
    rtDqsTaskCfg_t cfg = {};
    cfg.type = RT_DQS_TASK_SCHED_CONFIG;
    cfg.cfg = &schedCfg;
    rtError_t error = DqsLaunchTask(stm, &cfg);
    EXPECT_NE(error, RT_ERROR_NONE);

    MOCKER(halQueueGetDqsQueInfo).stubs().will(returnValue(DRV_ERROR_NONE));
    MOCKER(halBuffGetDQSPoolInfoById).stubs().will(returnValue(DRV_ERROR_NOT_SUPPORT));
    error = DqsLaunchTask(stm, &cfg);
    EXPECT_NE(error, RT_ERROR_NONE);

    delete stm;
}

TEST_F(TaskTestV201, Test_DqsTask_SchedConfig_muti_channel)
{
    MOCKER(CheckTaskCanSend).stubs().will(returnValue(RT_ERROR_NONE));
    Stream *stm = CreateStreamAndGet(device_, 0, RT_STREAM_DQS_CTRL, nullptr);
    EXPECT_NE(stm, nullptr);
    MOCKER(halQueueGetDqsQueInfo).stubs().will(returnValue(DRV_ERROR_NOT_SUPPORT));
    rtDqsSchedCfg_t schedCfg = {};
    uint64_t a = 1U;
    schedCfg.type = 1U;
    schedCfg.inputQueueNum = 2;
    schedCfg.outputQueueNum = 2;
    rtDqsTaskCfg_t cfg = {};
    cfg.type = RT_DQS_TASK_SCHED_CONFIG;
    cfg.cfg = &schedCfg;
    rtError_t error = DqsLaunchTask(stm, &cfg);
    EXPECT_NE(error, RT_ERROR_NONE);

    MOCKER(halQueueGetDqsQueInfo).stubs().will(returnValue(DRV_ERROR_NONE));
    MOCKER(halBuffGetDQSPoolInfoById).stubs().will(returnValue(DRV_ERROR_NOT_SUPPORT));
    error = DqsLaunchTask(stm, &cfg);
    EXPECT_NE(error, RT_ERROR_NONE);

    delete stm;
}

TEST_F(TaskTestV201, Test_DqsTask_02)
{
    MOCKER(CheckTaskCanSend).stubs().will(returnValue(RT_ERROR_NONE));
    Stream *stm = CreateStreamAndGet(device_, 0, RT_STREAM_DQS_CTRL, nullptr);
    EXPECT_NE(stm, nullptr);
    TaskInfo task1 = {};
    DqsCommonTaskInfo dqsDequeueTask = {};
    task1.u.dqsDequeueTask = dqsDequeueTask;
    TaskInfo *tmpTask = &task1;

    MOCKER(AllocTaskInfo).stubs().with(outBoundP(&tmpTask)).will(returnValue(RT_ERROR_NONE));

    stars_dqs_ctrl_space_t ctrlSpace = {};
    ctrlSpace.input_queue_num = 1U;

    StreamWithDqs *streamWithDqs = (StreamWithDqs *)stm;
    streamWithDqs->SetDqsCtrlSpace(&ctrlSpace);

    rtDqsTaskCfg_t cfg = {};
    cfg.type = RT_DQS_TASK_DEQUEUE;
    rtError_t error = DqsLaunchTask(stm, &cfg);
    EXPECT_EQ(error, RT_ERROR_NONE);
    DqsCommonTaskInfo dqsEnqueueTask = {};
    task1.u.dqsEnqueueTask = dqsEnqueueTask;

    TaskInfo task2 = {};
    NotifyWaitTaskInfo notifyWaitTask = {};
    task2.u.notifywaitTask = notifyWaitTask;
    TaskInfo *waitTask = &task2;

    MOCKER(CheckTaskCanSend).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER(AllocTaskInfoForCapture).stubs().with(outBoundP(&tmpTask)).will(returnValue(RT_ERROR_NONE));
    MOCKER(SubmitTaskPostProc).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP(&Stream::AllocTask).stubs().will(returnValue(waitTask));
    MOCKER_CPP(&IoctlUtil::IoctlByCmd).stubs().will(returnValue(RT_ERROR_NONE));

    cfg.type = RT_DQS_TASK_NOTIFY_WAIT;
    error = DqsLaunchTask(stm, &cfg);
    EXPECT_EQ(error, RT_ERROR_NONE);

    DqsQueueInfo queueInfo = {};
    queueInfo.queType = GQM_ENTITY_TYPE;
    MOCKER_CPP_VIRTUAL((NpuDriver *)(device_->Driver_()), &NpuDriver::GetDqsQueInfo).stubs()
        .with(mockcpp::any(), mockcpp::any(), outBoundP(&queueInfo)).will(returnValue(RT_ERROR_NONE));
    rtDqsSchedCfg_t schedCfg = {};
    schedCfg.inputQueueNum = 1;
    schedCfg.outputQueueNum = 1;
    schedCfg.type = 1;
    cfg.cfg = &schedCfg;
    cfg.type = RT_DQS_TASK_SCHED_CONFIG;
    error = DqsLaunchTask(stm, &cfg);
    EXPECT_NE(error, RT_ERROR_NONE);

    cfg.type = RT_DQS_TASK_ENQUEUE;
    error = DqsLaunchTask(stm, &cfg);
    EXPECT_EQ(error, RT_ERROR_NONE);

    DqsCommonTaskInfo dqsMbufFreeTask = {};
    task1.u.dqsMbufFreeTask = dqsMbufFreeTask;
    MOCKER(halSqTaskSend).stubs().will(returnValue(RT_ERROR_NONE));

    cfg.type = RT_DQS_TASK_FREE;
    error = DqsLaunchTask(stm, &cfg);
    EXPECT_EQ(error, RT_ERROR_NONE);

    cfg.type = RT_DQS_TASK_PREPARE_OUT;
    error = DqsLaunchTask(stm, &cfg);
    EXPECT_EQ(error, RT_ERROR_NONE);

    cfg.type = RT_DQS_TASK_FREE;
    error = DqsLaunchTask(stm, &cfg);
    EXPECT_EQ(error, RT_ERROR_NONE);

    cfg.type = RT_DQS_TASK_SCHED_END;
    error = DqsLaunchTask(stm, &cfg);
    EXPECT_EQ(error, RT_ERROR_NONE);

    cfg.type = RT_DQS_TASK_FRAME_ALIGN;
    error = DqsLaunchTask(stm, &cfg);
    EXPECT_EQ(error, RT_ERROR_NONE);

    cfg.type = RT_DQS_TASK_MAX;
    error = DqsLaunchTask(stm, &cfg);
    EXPECT_EQ(error, RT_ERROR_INVALID_VALUE);

    TaskInfo task = {};
    task.stream = stm;
    DqsCommonTaskInfo qsEnqueueTask = {};
    task.u.dqsEnqueueTask = qsEnqueueTask;
    error = DqsEnqueueTaskInit(&task, stm, nullptr);
    EXPECT_EQ(error, RT_ERROR_NONE);
    DqsCommonTaskInfo qsDequeueTask = {};
    task.u.dqsDequeueTask = qsDequeueTask;
    error = DqsDequeueTaskInit(&task, stm, nullptr);
    EXPECT_EQ(error, RT_ERROR_NONE);

    rtDavidSqe_t davidSqe = {};
    MemcpyAsyncTaskInfo memcpyAsyncTaskInfo = {};
    task.u.memcpyAsyncTaskInfo = memcpyAsyncTaskInfo;
    ConstructDavidSqeForMemcpyAsyncTask(&task, &davidSqe, 0);

    ConstructDavidSqeForCmoTask(&task, &davidSqe, 0);

    delete stm;
}

TEST_F(TaskTestV201, Test_DqsTask_03)
{
    MOCKER(CheckTaskCanSend).stubs().will(returnValue(RT_ERROR_NONE));
    Stream *stm = CreateStreamAndGet(device_, 0, RT_STREAM_DQS_CTRL, nullptr);
    EXPECT_NE(stm, nullptr);
    StreamWithDqs *streamWithDqs = (StreamWithDqs *)stm;
    EXPECT_NE(streamWithDqs, nullptr);

    stars_dqs_ctrl_space_t ctrlSpace = {};
    ctrlSpace.output_queue_num = 1U;
    ctrlSpace.output_queue_ids[0] = 1U;
    ctrlSpace.output_mbuf_pool_ids[0] = 1U;

    streamWithDqs->SetDqsCtrlSpace(&ctrlSpace);

    rtDqsSchedCfg_t schedCfg = {};
    schedCfg.type = 1U;
    schedCfg.inputQueueNum = 1U;
    schedCfg.outputQueueNum = 1U;
    schedCfg.inputQueueIds[0] = 512U;
    schedCfg.outputQueueIds[0] = 1U;

    DqsQueueInfo inputQueueInfo = {};
    inputQueueInfo.queType = GQM_ENTITY_TYPE;
    DqsQueueInfo outputQueueInfo = {};
    outputQueueInfo.prodqOwAddr = 1U;
    outputQueueInfo.enqueOpAddr = 1U;
    outputQueueInfo.queType = QMNGR_ENTITY_TYPE;
    MOCKER_CPP_VIRTUAL((NpuDriver*)(device_->Driver_()),
        &NpuDriver::GetDqsQueInfo).stubs().will(invoke(StubGetDqsQueInfo));

    DqsPoolInfo dqsPoolInfo = {};
    dqsPoolInfo.freeOpAddr = 2U;

    MOCKER_CPP_VIRTUAL((NpuDriver *)(device_->Driver_()), &NpuDriver::GetDqsMbufPoolInfo)
        .stubs()
        .with(mockcpp::any(), outBoundP(&dqsPoolInfo))
        .will(returnValue(RT_ERROR_NONE));

    rtDqsTaskCfg_t cfg = {};
    cfg.cfg = &schedCfg;
    cfg.type = RT_DQS_TASK_SCHED_CONFIG;
    rtError_t error = DqsLaunchTask(stm, &cfg);
    EXPECT_EQ(error, RT_ERROR_NONE);

    delete stm;
}

TEST_F(TaskTestV201, Test_dqs_cond_construct_fc_01)
{
    RtStarsDqsMbufFreeFc fc = {};
    RtDqsMbufFreeFcPara funcCallPara = {};
    ConstructMbufFreeInstrFc(fc, funcCallPara);

    RtStarsDqsEnqueueFc fc1 = {};
    RtStarsDqsFcPara fcp1 = {};
    ConstructDqsEnqueueFc(fc1, fcp1);
    EXPECT_EQ(fc1.andi1.opCode, RT_STARS_COND_ISA_OP_CODE_OP_IMM);

    RtStarsDqsDequeueFc fc2 = {};
    ConstructDqsDequeueFc(fc2, fcp1);
    EXPECT_EQ(fc2.llwi1.opCode, RT_STARS_COND_ISA_OP_CODE_LWI);

    RtStarsDqsPrepareFcPara funcCallPara1 = {};
    RtStarsDqsPrepareOutFc fc3 = {};
    ConstructDqsPrepareFc(fc3, funcCallPara1);
    EXPECT_EQ(fc3.addi1.opCode, RT_STARS_COND_ISA_OP_CODE_OP_IMM);

    RtStarsDqsZeroCopyPara funcCallPara2 = {};
    RtStarsDqsZeroCopyFc fc4 = {};
    ConstructDqsZeroCopyFc(fc4, funcCallPara2);
    EXPECT_EQ(fc4.addi1.opCode, RT_STARS_COND_ISA_OP_CODE_OP_IMM);

    RtStarsDqsInterChipPreProcPara funcCallPara3 = {};
    RtStarsDqsInterChipPreProcFc fc5 = {};
    ConstructDqsInterChipPreProcFc(fc5, funcCallPara3);
    EXPECT_EQ(fc5.llwi1.opCode, RT_STARS_COND_ISA_OP_CODE_LWI);

    RtStarsDqsInterChipPostProcPara funcCallPara4 = {};
    RtStarsDqsInterChipPostProcFc fc6 = {};
    ConstructDqsInterChipPostProcFc(fc6, funcCallPara4);
    EXPECT_EQ(fc6.llwi1.opCode, RT_STARS_COND_ISA_OP_CODE_LWI);

    RtStarsDqsBatchDeqFcPara fcp2;
    RtStarsDqsBatchDequeueFc fc7 = {};
    ConstructDqsBatchDequeueFc(fc7, fcp2);
    EXPECT_EQ(fc7.llwiAddrMask.opCode, RT_STARS_COND_ISA_OP_CODE_LWI);
}

TEST_F(TaskTestV201, Test_DqsTask_04)
{
    MOCKER(CheckTaskCanSend).stubs().will(returnValue(RT_ERROR_NONE));
    Stream *stm = CreateStreamAndGet(device_, 0, RT_STREAM_DQS_CTRL, nullptr);
    EXPECT_NE(stm, nullptr);

    TaskInfo task1 = {};
    DqsCommonTaskInfo dqsMbufFreeTask = {};
    task1.u.dqsMbufFreeTask = dqsMbufFreeTask;

    TaskInfo *tmpTask = &task1;
    MOCKER(AllocTaskInfo).stubs().with(outBoundP(&tmpTask)).will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL((NpuDriver *)(device_->Driver_()), &NpuDriver::MemCopySync)
        .stubs()
        .will(returnValue(RT_ERROR_DRV_MEMORY));
    rtDqsTaskCfg_t cfg = {};
    cfg.type = RT_DQS_TASK_FREE;
    rtError_t error = DqsLaunchTask(stm, &cfg);
    EXPECT_NE(error, RT_ERROR_NONE);

    delete stm;
}

TEST_F(TaskTestV201, Test_DqsTask_05)
{
    MOCKER(CheckTaskCanSend).stubs().will(returnValue(RT_ERROR_NONE));
    Stream *stm = CreateStreamAndGet(device_, 0, RT_STREAM_DQS_CTRL, nullptr);
    EXPECT_NE(stm, nullptr);
    TaskInfo task1 = {};
    DqsZeroCopyTaskInfo dqsZeroCopyTask = {};
    task1.u.dqsZeroCopyTask = dqsZeroCopyTask;
    TaskInfo *tmpTask = &task1;

    stars_dqs_ctrl_space_t ctrlSpace = {};
    StreamWithDqs *streamWithDqs = (StreamWithDqs *)stm;
    streamWithDqs->SetDqsCtrlSpace(&ctrlSpace);

    MOCKER(AllocTaskInfo).stubs().with(outBoundP(&tmpTask)).will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL((NpuDriver *)(device_->Driver_()), &NpuDriver::MemCopySync)
        .stubs()
        .will(returnValue(RT_ERROR_NONE));
    uint64_t dest[] = {0xFF};
    uint64_t offset[] = {0xFF};
    rtDqsZeroCopyCfg_t zeroCopyCfg = {};
    zeroCopyCfg.queueId = 0;
    zeroCopyCfg.copyType = RT_DQS_ZERO_COPY_INPUT;
    zeroCopyCfg.count = 1;
    zeroCopyCfg.offset = offset;
    zeroCopyCfg.dest = dest;
    ctrlSpace.input_queue_num = 1U;
    ctrlSpace.input_queue_ids[0] = 0;
    rtDqsTaskCfg_t cfg = {};
    cfg.type = RT_DQS_TASK_ZERO_COPY;
    cfg.cfg = &zeroCopyCfg;
    rtError_t error = DqsLaunchTask(stm, &cfg);
    EXPECT_EQ(error, RT_ERROR_NONE);
    zeroCopyCfg.copyType = RT_DQS_ZERO_COPY_OUTPUT;
    ctrlSpace.output_queue_num = 1U;
    ctrlSpace.output_queue_ids[0] = 0;
    error = DqsLaunchTask(stm, &cfg);
    EXPECT_EQ(error, RT_ERROR_NONE);
    cfg.cfg = nullptr;
    error = DqsLaunchTask(stm, &cfg);
    EXPECT_NE(error, RT_ERROR_NONE);
    zeroCopyCfg.copyType = RT_DQS_ZERO_COPY_INPUT;
    error = DqsLaunchTask(stm, &cfg);
    EXPECT_NE(error, RT_ERROR_NONE);

    delete stm;
}

TEST_F(TaskTestV201, Test_DqsTask_06)
{
    MOCKER(CheckTaskCanSend).stubs().will(returnValue(RT_ERROR_NONE));
    Stream *stm = CreateStreamAndGet(device_, 0, RT_STREAM_DQS_CTRL, nullptr);
    EXPECT_NE(stm, nullptr);
    TaskInfo task1 = {};
    DqsZeroCopyTaskInfo dqsZeroCopyTask = {};
    task1.u.dqsZeroCopyTask = dqsZeroCopyTask;
    task1.stream = stm;
    TaskInfo *tmpTask = &task1;
    

    stars_dqs_ctrl_space_t ctrlSpace = {};
    StreamWithDqs *streamWithDqs = (StreamWithDqs *)stm;
    streamWithDqs->SetDqsCtrlSpace(&ctrlSpace);

    MOCKER(AllocTaskInfo).stubs().with(outBoundP(&tmpTask)).will(returnValue(RT_ERROR_NONE));
    rtDqsZeroCopyCfg_t zeroCopyCfg = {};
    zeroCopyCfg.queueId = 0;
    zeroCopyCfg.copyType = RT_DQS_ZERO_COPY_INPUT;
    ctrlSpace.input_queue_num = 1U;
    ctrlSpace.input_queue_ids[0] = 0;
    MOCKER_CPP_VIRTUAL((NpuDriver *)(device_->Driver_()), &NpuDriver::MemCopySync).stubs().will(returnValue(1));

    rtDqsTaskCfg_t cfg = {};
    cfg.type = RT_DQS_TASK_ZERO_COPY;
    rtError_t error = DqsLaunchTask(stm, &cfg);
    EXPECT_NE(error, RT_ERROR_NONE);

    cfg.cfg = nullptr;
    error = DqsLaunchTask(stm, &cfg);
    EXPECT_NE(error, RT_ERROR_NONE);

    MOCKER_CPP_VIRTUAL((NpuDriver *)(device_->Driver_()), &NpuDriver::DevMemAlloc)
        .stubs()
        .will(returnValue(RT_ERROR_NONE));
    DqsTaskConfig taskCfg = {};
    taskCfg.zeroCopyCfg= &zeroCopyCfg;
    error = DqsZeroCopyTaskInit(&task1, stm, &taskCfg);
    EXPECT_NE(error, RT_ERROR_NONE);

    uint32_t devId = 0;
    PrintErrorInfoForDqsMbufFreeTask(tmpTask, devId);
    EXPECT_EQ(0, devId);

    DqsCommonTaskInfo prepareTask = {};
    task1.u.dqsPrepareTask = prepareTask;
    PrintErrorInfoForDqsPrepareTask(tmpTask, devId);
    DqsPrepareTaskUnInit(tmpTask);

    DqsZeroCopyTaskInfo zeroCopyTask = {};
    task1.u.dqsZeroCopyTask = zeroCopyTask;
    PrintErrorInfoForDqsZeroCopyTask(tmpTask, devId);
    DqsZeroCopyTaskUnInit(tmpTask);

    DqsInterChipProcTaskInfo dqsInterChipPreProcTask = {};
    task1.u.dqsInterChipPreProcTask = dqsInterChipPreProcTask;
    PrintErrorInfoForDqsInterChipPreProcTask(tmpTask, devId);
    DqsInterChipPreProcTaskUnInit(tmpTask);

    DqsInterChipProcTaskInfo dqsInterChipPostProcTask = {};
    task1.u.dqsInterChipPostProcTask = dqsInterChipPostProcTask;
    PrintErrorInfoForDqsInterChipPostProcTask(tmpTask, devId);
    DqsInterChipPostProcTaskUnInit(tmpTask);

    rtDavidSqe_t davidSqe = {};
    ConstructSqeForDqsPrepareTask(tmpTask, &davidSqe, 0ULL);
    PrintErrorInfoForDqsAdspcTask(tmpTask, devId);

    PrintErrorInfoForDqsBatchDequeueTask(tmpTask, devId);
    DqsBatchDequeTaskUnInit(tmpTask);

    DqsFrameAlignTaskUnInit(tmpTask);

    delete stm;
}

TEST_F(TaskTestV201, Test_DqsTask_07)
{
    MOCKER(CheckTaskCanSend).stubs().will(returnValue(RT_ERROR_NONE));
    Stream *stm = CreateStreamAndGet(device_, 0, RT_STREAM_DQS_CTRL, nullptr);
    EXPECT_NE(stm, nullptr);
    TaskInfo task1 = {};
    DqsCommonTaskInfo dqsCondCopyTask = {};
    task1.u.dqsCondCopyTask = dqsCondCopyTask;
    task1.stream = stm;
    TaskInfo *tmpTask = &task1;

    stars_dqs_ctrl_space_t ctrlSpace = {};
    StreamWithDqs *streamWithDqs = (StreamWithDqs *)stm;
    streamWithDqs->SetDqsCtrlSpace(&ctrlSpace);

    MOCKER(AllocTaskInfo).stubs().with(outBoundP(&tmpTask)).will(returnValue(RT_ERROR_NONE));
    rtDqsTaskCfg_t cfg = {};
    rtDqsConditionCopyCfg_t condCopyCfg = {};
    uint64_t condition = 1;
    uint8_t dst[32] = {0};
    uint8_t src[32] = {0};
    cfg.cfg = &condCopyCfg;
    cfg.type = RT_DQS_TASK_CONDITION_COPY;
    condCopyCfg.condition = &condition;
    condCopyCfg.dst = (void *)&dst;
    condCopyCfg.src = (void *)&src;
    condCopyCfg.cnt = 32;
    condCopyCfg.destMax = 32;
    DqsTaskConfig dqsTaskConfig;
    dqsTaskConfig.condCopyCfg = &condCopyCfg;
    MOCKER_CPP_VIRTUAL((NpuDriver *)(device_->Driver_()), &NpuDriver::MemCopySync).stubs().will(returnValue(1));
    rtError_t error = DqsLaunchTask(stm, &cfg);
    EXPECT_NE(error, RT_ERROR_NONE);

    MOCKER_CPP_VIRTUAL((NpuDriver *)(device_->Driver_()), &NpuDriver::DevMemAlloc)
        .stubs().will(returnValue(RT_ERROR_NONE));
    error = DqsConditionCopyTaskInit(&task1, stm, &dqsTaskConfig);
    EXPECT_NE(error, RT_ERROR_NONE);

    uint32_t devId = 0;
    rtDavidSqe_t davidSqe = {};
    ConstructSqeForDqsConditionCopyTask(tmpTask, &davidSqe, 0ULL);
    PrintErrorInfoForDqsConditionCopyTask(tmpTask, devId);

    delete stm;
}

TEST_F(TaskTestV201, Test_DqsInterChipTask_01)
{
    MOCKER(CheckTaskCanSend).stubs().will(returnValue(RT_ERROR_NONE));
    Stream *stm = CreateStreamAndGet(device_, 0, RT_STREAM_DQS_CTRL, nullptr);
    EXPECT_NE(stm, nullptr);
    TaskInfo task1 = {};
    DqsInterChipProcTaskInfo dqsInterChipProcTask = {};
    task1.u.dqsInterChipPreProcTask = dqsInterChipProcTask;
    TaskInfo *tmpTask = &task1;

    MOCKER(AllocTaskInfo).stubs().with(outBoundP(&tmpTask)).will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL(stm, &Stream::AddTaskToList).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER(MemcpyAsyncTaskInitV1).stubs().will(returnValue(RT_ERROR_NONE));

    stars_dqs_inter_chip_space_t interChipSpace = {};
    StreamWithDqs *streamWithDqs = (StreamWithDqs *)stm;
    streamWithDqs->SetDqsInterChipSpace(&interChipSpace);

    rtDqsTaskCfg_t cfg = {};
    cfg.type = RT_DQS_TASK_INTER_CHIP_INIT;
    cfg.cfg = nullptr;
    rtError_t error = DqsLaunchTask(stm, &cfg);
    EXPECT_EQ(error, RT_ERROR_NONE);

    MOCKER_CPP_VIRTUAL((NpuDriver *)(device_->Driver_()), &NpuDriver::MemCopySync)
        .stubs()
        .will(returnValue(1))
        .then(returnValue(0))
        .then(returnValue(1));
    error = DqsLaunchTask(stm, &cfg);
    EXPECT_NE(error, RT_ERROR_NONE);

    error = DqsLaunchTask(stm, &cfg);
    EXPECT_NE(error, RT_ERROR_NONE);

    error = DqsInterChipMemcpyTaskInit(tmpTask, 0, DqsInterChipTaskType::DQS_INTER_CHIP_TASK_PREPROC);
    EXPECT_NE(error, RT_ERROR_NONE);

    delete stm;
}

TEST_F(TaskTestV201, TestDqsAdspcTaskWithParamError)
{
    MOCKER(CheckTaskCanSend).stubs().will(returnValue(RT_ERROR_NONE));
    Stream *stm = CreateStreamAndGet(device_, 0, 0, nullptr);
    EXPECT_NE(stm, nullptr);
    TaskInfo task = {};
    TaskInfo *tmpTask = &task;

    MOCKER(AllocTaskInfo).stubs().with(outBoundP(&tmpTask)).will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL(stm, &Stream::AddTaskToList).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER(MemcpyAsyncTaskInitV1).stubs().will(returnValue(RT_ERROR_NONE));

    rtDqsTaskCfg_t cfg = {};
    cfg.type = RT_DQS_TASK_ADSPC;
    rtDqsAdspcTaskParam_t param = {};
    cfg.cfg = &param;
    rtError_t error = DqsLaunchTask(stm, &cfg);
    EXPECT_EQ(error, RT_ERROR_INVALID_VALUE);
    delete stm;
}

TEST_F(TaskTestV201, TestDqsAdspcTaskWithSuccess)
{
    MOCKER(CheckTaskCanSend).stubs().will(returnValue(RT_ERROR_NONE));
    Stream *stm = CreateStreamAndGet(device_, 0, 0, nullptr);
    EXPECT_NE(stm, nullptr);
    TaskInfo task = {};
    TaskInfo *tmpTask = &task;
    DqsQueueInfo queueInfo = {};
    queueInfo.prodqOwAddr = 1U;
    queueInfo.enqueOpAddr = 1U;
    queueInfo.queType = QMNGR_ENTITY_TYPE;

    MOCKER(AllocTaskInfo).stubs().with(outBoundP(&tmpTask)).will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL(stm, &Stream::AddTaskToList).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER(MemcpyAsyncTaskInitV1).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL((NpuDriver *)(device_->Driver_()), &NpuDriver::GetDqsQueInfo)
        .stubs()
        .with(mockcpp::any(), mockcpp::any(), outBoundP(&queueInfo))
        .will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL((NpuDriver *)(device_->Driver_()), &NpuDriver::GetDqsMbufPoolInfo)
        .stubs()
        .will(returnValue(RT_ERROR_NONE));

    rtDqsAdspcTaskCfg_t param = {};
    param.cqeSize = 32U;
    param.cqDepth = 8U;
    param.cqeBaseAddr = 0x5A;
    param.cqeCopyAddr = 0x5B;
    param.cqHeadRegAddr = 0x5C;
    param.cqTailRegAddr = 0x5D;
    rtDqsTaskCfg_t cfg = {};
    cfg.type = RT_DQS_TASK_ADSPC;
    cfg.cfg = &param;
    rtError_t error = DqsLaunchTask(stm, &cfg);
    EXPECT_EQ(error, RT_ERROR_NONE);
    delete stm;
}

TEST_F(TaskTestV201, TestDqsAdspcTaskWithCqeDepthError)
{
    MOCKER(CheckTaskCanSend).stubs().will(returnValue(RT_ERROR_NONE));
    Stream *stm = CreateStreamAndGet(device_, 0, 0, nullptr);
    EXPECT_NE(stm, nullptr);
    TaskInfo task = {};
    TaskInfo *tmpTask = &task;
    DqsQueueInfo queueInfo = {};
    queueInfo.prodqOwAddr = 1U;
    queueInfo.enqueOpAddr = 1U;
    queueInfo.queType = QMNGR_ENTITY_TYPE;

    MOCKER(AllocTaskInfo).stubs().with(outBoundP(&tmpTask)).will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL(stm, &Stream::AddTaskToList).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER(MemcpyAsyncTaskInitV1).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL((NpuDriver *)(device_->Driver_()), &NpuDriver::GetDqsQueInfo)
        .stubs()
        .with(mockcpp::any(), mockcpp::any(), outBoundP(&queueInfo))
        .will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL((NpuDriver *)(device_->Driver_()), &NpuDriver::GetDqsMbufPoolInfo)
        .stubs()
        .will(returnValue(RT_ERROR_NONE));

    rtDqsTaskCfg_t cfg = {};
    cfg.type = RT_DQS_TASK_ADSPC;
    rtDqsAdspcTaskParam_t param = {};
    param.cqDepth = 7U;
    cfg.cfg = &param;
    rtError_t error = DqsLaunchTask(stm, &cfg);
    EXPECT_EQ(error, RT_ERROR_INVALID_VALUE);
    delete stm;
}

TEST_F(TaskTestV201, Test_MacroInit)
{
    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    EXPECT_NE(rtInstance, nullptr);

    rtInstance->MacroInit(CHIP_MC62CM12A);
    EXPECT_EQ(Runtime::macroValue_.rtsqDepth, 1024U);
}

TEST_F(TaskTestV201, Test_SetSocTypeByChipType)
{
    Runtime *rtInstance = ((Runtime *)Runtime::Instance());
    rtChipType_t oriChipType = rtInstance->GetChipType();
    rtSocType_t oriSocType = rtInstance->GetSocType();
    rtInstance->SetChipType(CHIP_MC62CM12A);
    GlobalContainer::SetRtChipType(CHIP_MC62CM12A);
    rtError_t ret = rtInstance->SetSocTypeByChipType(PLAT_COMBINE(ARCH_M510, CHIP_MC62CM12A, VER_NA), 0, 0);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    rtInstance->SetChipType(oriChipType);
    GlobalContainer::SetRtChipType(oriChipType);
    rtInstance->SetSocType(oriSocType);
}

TEST_F(TaskTestV201, Test_DqsCountNotifyWait)
{
    MOCKER(CheckTaskCanSend).stubs().will(returnValue(RT_ERROR_NONE));
    Stream *stm = CreateStreamAndGet(device_, 0, RT_STREAM_DQS_CTRL, nullptr);
    EXPECT_NE(stm, nullptr);
    TaskInfo task1 = {};
    DqsCommonTaskInfo dqsDequeueTask = {};
    task1.u.dqsDequeueTask = dqsDequeueTask;
    TaskInfo *tmpTask = &task1;

    MOCKER(AllocTaskInfoForCapture).stubs().with(outBoundP(&tmpTask)).will(returnValue(RT_ERROR_NONE));
    MOCKER(AllocTaskInfo).stubs().with(outBoundP(&tmpTask)).will(returnValue(RT_ERROR_NONE));

    stars_dqs_ctrl_space_t ctrlSpace = {};
    ctrlSpace.input_queue_num = 2U;

    StreamWithDqs *streamWithDqs = (StreamWithDqs *)stm;
    streamWithDqs->SetDqsCtrlSpace(&ctrlSpace);

    rtDqsTaskCfg_t cfg = {};
    cfg.type = RT_DQS_TASK_DEQUEUE;
    rtError_t error = DqsLaunchTask(stm, &cfg);
    EXPECT_EQ(error, RT_ERROR_NONE);

    TaskInfo task2 = {};
    NotifyWaitTaskInfo notifyWaitTask = {};
    task2.u.notifywaitTask = notifyWaitTask;
    TaskInfo *waitTask = &task2;

    MOCKER_CPP(&Stream::AllocTask).stubs().will(returnValue(waitTask));
    MOCKER(SubmitTaskPostProc).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP(&IoctlUtil::IoctlByCmd).stubs().will(returnValue(RT_ERROR_NONE));
    cfg.type = RT_DQS_TASK_NOTIFY_WAIT;
    error = DqsLaunchTask(stm, &cfg);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = DqsLaunchTask(stm, &cfg);
    EXPECT_EQ(error, RT_ERROR_NONE);

    delete stm;
}

TEST_F(TaskTestV201, Test_DqsNotifyWaitWithInvalidQueNum)
{
    MOCKER(CheckTaskCanSend).stubs().will(returnValue(RT_ERROR_NONE));
    Stream *stm = CreateStreamAndGet(device_, 0, RT_STREAM_DQS_CTRL, nullptr);
    EXPECT_NE(stm, nullptr);
    TaskInfo task1 = {};
    DqsCommonTaskInfo dqsDequeueTask = {};
    task1.u.dqsDequeueTask = dqsDequeueTask;
    TaskInfo *tmpTask = &task1;

    MOCKER(AllocTaskInfo).stubs().with(outBoundP(&tmpTask)).will(returnValue(RT_ERROR_NONE));

    stars_dqs_ctrl_space_t ctrlSpace = {};
    ctrlSpace.input_queue_num = 11U;

    StreamWithDqs *streamWithDqs = (StreamWithDqs *)stm;
    streamWithDqs->SetDqsCtrlSpace(&ctrlSpace);
    rtDqsTaskCfg_t cfg = {};
    cfg.type = RT_DQS_TASK_DEQUEUE;
    rtError_t error = DqsLaunchTask(stm, &cfg);
    EXPECT_EQ(error, RT_ERROR_NONE);

    cfg.type = RT_DQS_TASK_NOTIFY_WAIT;
    error = DqsLaunchTask(stm, &cfg);
    EXPECT_EQ(error, RT_ERROR_INVALID_VALUE);

    delete stm;
}

TEST_F(TaskTestV201, Test_CondIsaHelper)
{
    Runtime *rtInstance = ((Runtime *)Runtime::Instance());
    rtChipType_t oriChipType = rtInstance->GetChipType();
    rtSocType_t oriSocType = rtInstance->GetSocType();
    rtInstance->SetChipType(CHIP_MC62CM12A);
    GlobalContainer::SetRtChipType(CHIP_MC62CM12A);

    rtStarsModelExeFuncCallPara_t funcCallPara = {};
    RtStarsModelExeCheckSqFsm checkSqFsm = {};
    ConstrucModelExeCheckSqFsm(funcCallPara, checkSqFsm);

    rtStarsStreamSwitchFc_t fc1 = {};
    rtStarsStreamSwitchFcPara_t fcPara1 = {};
    ConstructStreamSwitchFc(fc1, fcPara1);

    rtInstance->SetChipType(oriChipType);
    GlobalContainer::SetRtChipType(oriChipType);
    rtInstance->SetSocType(oriSocType);
}

TEST_F(TaskTestV201, Test_ioctl_utils_success)
{
    GlobalMockObject::reset();
    MOCKER(mmOpen2).stubs().will(returnValue(0));
    stars_ioctl_cmd_args_t args = {};
    rtError_t error = IoctlUtil::GetInstance().IoctlByCmd(STARS_IOCTL_CMD_BIND_QUEUE, &args);
    EXPECT_NE(error, RT_ERROR_NONE);
}

TEST_F(TaskTestV201, Test_GetIpcSqeWriteAddrForNotifyRecordTask)
{
    Runtime *rtInstance = ((Runtime *)Runtime::Instance());
    rtChipType_t oriChipType = rtInstance->GetChipType();
    rtSocType_t oriSocType = rtInstance->GetSocType();
    rtInstance->SetChipType(CHIP_MC62CM12A);
    GlobalContainer::SetRtChipType(CHIP_MC62CM12A);
    Stream *stm = CreateStreamAndGet(device_, 0, RT_STREAM_DQS_CTRL, nullptr);
    EXPECT_NE(stm, nullptr);
    TaskInfo task1 = {};
    task1.stream = stm;
    Notify *notify = new Notify(0, 0);
    NotifyRecordTaskInfo *notifyRecord = &(task1.u.notifyrecordTask);
    notifyRecord->uPtr.notify = notify;
    TaskInfo *tmpTask = &task1;
    uint64_t addr = 0ULL;
    rtError_t error = GetIpcSqeWriteAddrForNotifyRecordTask(tmpTask, addr);
    EXPECT_EQ(error, RT_ERROR_NONE);
    notify->adcDieId_ = 2;
    error = GetIpcSqeWriteAddrForNotifyRecordTask(tmpTask, addr);
    EXPECT_EQ(error, RT_ERROR_NONE);
    MOCKER(halMemAlloc).stubs().will(returnValue(DRV_ERROR_NONE));
    void *dptr = nullptr;
    error = ((NpuDriver *)(device_->Driver_()))
                ->MemAllocHugePolicyPageOffline(&dptr, HUGE_PAGE_MEM_CRITICAL_VALUE + 1, RT_MEMORY_P2P_DDR, 0, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = ((NpuDriver *)(device_->Driver_()))
                ->MemAllocHugePolicyPageOffline(&dptr, HUGE_PAGE_MEM_CRITICAL_VALUE, RT_MEMORY_P2P_DDR, 0, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);
    rtInstance->SetChipType(oriChipType);
    GlobalContainer::SetRtChipType(oriChipType);
    rtInstance->SetSocType(oriSocType);
    delete notify;
    delete stm;
}

rtError_t IoctlByCmdMock(IoctlUtil *that, const stars_ioctl_cmd_t cmd, const stars_ioctl_cmd_args_t *args)
{
    static stars_dqs_inter_chip_space_t space = {};
    stars_dqs_inter_chip_space_result_t *result = (stars_dqs_inter_chip_space_result_t *)args->output_ptr;
    result->inter_chip_space_va = &space;
    return RT_ERROR_NONE;
}

TEST_F(TaskTestV201, TestDqsInterChipStreamCreateSuccess)
{
    MOCKER_CPP(&IoctlUtil::IoctlByCmd).stubs().will(invoke(IoctlByCmdMock));

    rtStream_t stream;
    rtStreamCreateConfig_t config = {};
    rtStreamCreateAttr_t attr = {};
    config.attrs = &attr;
    config.numAttrs = 1;
    attr.id = RT_STREAM_CREATE_ATTR_FLAGS;
    attr.value.flags = RT_STREAM_DQS_INTER_CHIP;
    auto error = rtsStreamCreate(&stream, &config);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtsStreamDestroy(stream, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(TaskTestV201, TestDqsInterChipStreamCreateFailed)
{
    MOCKER_CPP(&IoctlUtil::IoctlByCmd).stubs().will(returnValue(RT_ERROR_NONE));
    rtStream_t stream;
    rtStreamCreateConfig_t config = {};
    rtStreamCreateAttr_t attr = {};
    config.attrs = &attr;
    config.numAttrs = 1;
    attr.id = RT_STREAM_CREATE_ATTR_FLAGS;
    attr.value.flags = RT_STREAM_DQS_INTER_CHIP;
    auto error = rtsStreamCreate(&stream, &config);
    EXPECT_EQ(error, ACL_ERROR_RT_DRV_INTERNAL_ERROR);
}

TEST_F(TaskTestV201, construct_sqe_for_stars_memcpy_async_sqe_d2d)
{
    void *dst = nullptr;
    void *src = nullptr;
    uint64_t count = 1;
    rtMemcpyKind_t kind = RT_MEMCPY_DEVICE_TO_DEVICE;

    TaskInfo task = {};
    task.u.memcpyAsyncTaskInfo.copyDataType = RT_DATA_TYPE_BFP16;
    (void)ReduceOpcodeHigh(&task);

    rtDavidSqe_t sqe;
    uint64_t sqBaseAddr = 0U;
    InitByStream(&task, stream_);
    MemcpyAsyncTaskInitV3(&task, kind, src, dst, count, 0, NULL);
    ToConstructDavidSqe(&task, &sqe, sqBaseAddr);
    EXPECT_EQ(sqe.memcpyAsyncSqe.header.type, RT_DAVID_SQE_TYPE_SDMA);
    task.id = 0;
    ToConstructDavidSqe(&task, &sqe, sqBaseAddr);
    TaskUnInitProc(&task);
}

TEST_F(TaskTestV201, Test_Construct_Sqe)
{
    TaskInfo task = {};
 
    rtDavidSqe_t *sqe = (rtDavidSqe_t *)malloc(sizeof(rtDavidSqe_t));
    uint64_t sqBaseAddr = 0U;
    InitByStream(&task, stream_);
    AicpuTaskInit(&task, 1, (uint32_t)0);
    task.u.aicpuTaskInfo.aicpuKernelType = KERNEL_TYPE_AICPU_KFC;
    ToConstructDavidSqe(&task, sqe, sqBaseAddr);
 
    task.u.aicpuTaskInfo.comm.kernelFlag = 0x40;
    ToConstructDavidSqe(&task, sqe, sqBaseAddr);
 
    task.u.aicpuTaskInfo.comm.kernelFlag = 0x10;
    ToConstructDavidSqe(&task, sqe, sqBaseAddr);
    free(sqe);
    sqe = nullptr;
}

TEST_F(TaskTestV201, Test_Construct_Fusion_Sqe)
{
    const void *stubFunc = (void *)0x02;
    const char *stubName = "abc";
    Kernel *kernel = NULL;
    PlainProgram stubProg(Program::MACH_AI_CORE);
    Program *program = &stubProg;
    kernel = new (std::nothrow) Kernel(stubFunc, stubName, "", program, 0);

    rtError_t error;
    rtDavidSqe_t sqe[5];
    TaskInfo kernTask = {};
    InitByStream(&kernTask, stream_);

    uint64_t arg = 0x123456789;
    rtFusionArgsEx_t argsInfo = {};
    argsInfo.args = &arg;
    argsInfo.argsSize = sizeof(arg);
    argsInfo.aicpuNum = 1;
    argsInfo.aicpuArgs[0].kfcArgsFmtOffset = 0xFFFF;
    argsInfo.aicpuArgs[0].kernelNameAddrOffset = 0;
    argsInfo.aicpuArgs[0].soNameAddrOffset = 0;

    rtFunsionTaskInfo_t fusionInfo = {};
    fusionInfo.subTaskNum = 2U;
    fusionInfo.subTask[0].type = RT_FUSION_AICPU;
    fusionInfo.subTask[0].task.aicpuInfo.kernelType = 0;
    fusionInfo.subTask[0].task.aicpuInfo.flags = 0;
    fusionInfo.subTask[0].task.aicpuInfo.blockDim = 2U;

    rtLaunchAttribute_t attrs[1];
    attrs[0].id = RT_LAUNCH_ATTRIBUTE_BLOCKDIM;
    attrs[0].value.blockDim = 1;

    rtLaunchConfig_t launchConfig = {};
    launchConfig.numAttrs = 1;
    launchConfig.attrs = attrs;
    fusionInfo.subTask[1].type = RT_FUSION_AICORE;
    fusionInfo.subTask[1].task.aicoreInfo.hdl = nullptr;
    fusionInfo.subTask[1].task.aicoreInfo.config = &launchConfig;

    rtAicAivFusionInfo_t aicAivInfo = {};
    LaunchTaskCfgInfo_t taskCfgInfo;
    aicAivInfo.launchTaskCfg = &taskCfgInfo;
    FusionKernelTaskInit(&kernTask);
    AixKernelTaskInitForFusion(&kernTask, &aicAivInfo, &taskCfgInfo);
    kernTask.u.fusionKernelTask.fusionKernelInfo = static_cast<void *>(&fusionInfo);
    kernTask.u.fusionKernelTask.argsInfo = &argsInfo;
    kernTask.u.fusionKernelTask.argsSize = argsInfo.argsSize;
    kernTask.u.fusionKernelTask.args = argsInfo.args;
    kernTask.u.fusionKernelTask.sqeLen = 6U;
    rtArgsSizeInfo_t argsSizeInfo;
    argsSizeInfo.infoAddr = (void *)0x12345678;
    argsSizeInfo.atomicIndex = 0x87654321;
    error = rtSetExceptionExtInfo(&argsSizeInfo);
    AixKernelTaskInitForFusion(&kernTask, &aicAivInfo, &taskCfgInfo);
    kernTask.u.fusionKernelTask.aicAivType = 0;  //aic no mix
    uint64_t sqBaseAddr = 0U;
    ToConstructDavidSqe(&kernTask, sqe, sqBaseAddr);
    EXPECT_EQ(sqe[0].aicpuSqe.header.type, RT_DAVID_SQE_TYPE_FUSION);

    TaskUnInitProc(&kernTask);
    delete kernel;
}

TEST_F(TaskTestV201, TestCpuKernelLaunch)
{
    rtError_t error;
    ApiImplDavid apiImpl;
    void *args[] = {&error, NULL};
    rtAicpuArgsEx_t argsInfo = {};
    argsInfo.args = args;
    argsInfo.argsSize = sizeof(args);
    char_t* opName = "testOp";
    MOCKER(StreamLaunchCpuKernelExWithArgs).stubs().will(returnValue(RT_ERROR_NONE));
    error = apiImpl.CpuKernelLaunchExWithArgs(opName, 1, &argsInfo, NULL, NULL,2,2);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(TaskTestV201, TestSetXpuDevice)
{
    ApiImplDavid apiImpl;
    rtError_t error = apiImpl.SetXpuDevice(RT_DEV_TYPE_DPU,0);
    EXPECT_EQ(error, RT_ERROR_FEATURE_NOT_SUPPORT);
}

TEST_F(TaskTestV201, TestGetXpuDevCount)
{
    ApiImplDavid apiImpl;
    rtError_t error = apiImpl.GetXpuDevCount(RT_DEV_TYPE_DPU,0);
    EXPECT_EQ(error, RT_ERROR_FEATURE_NOT_SUPPORT);
}

TEST_F(TaskTestV201, TestResetXpuDevice)
{
    ApiImplDavid apiImpl;
    rtError_t error = apiImpl.ResetXpuDevice(RT_DEV_TYPE_DPU,0);
    EXPECT_EQ(error, RT_ERROR_FEATURE_NOT_SUPPORT);
}

TEST_F(TaskTestV201, LaunchKernelV2_AICPU)
{
    Device *device = ((Runtime *)Runtime::Instance())->DeviceRetain(0, 0);
    MOCKER_CPP(&ApiImplDavid::CpuKernelLaunchExAll).stubs().will(returnValue(RT_ERROR_NONE));
    PlainProgram stubProg(Program::MACH_AI_CPU);
    Program *program = &stubProg;
    const char* stub = "";
    void* stubFunc = nullptr;
    Kernel * kernel = new (std::nothrow) Kernel(stubFunc, stub, static_cast<uint64_t>(0), program, 0);
    kernel->SetKernelRegisterType(RT_KERNEL_REG_TYPE_CPU);
    kernel->SetKernelType_(KERNEL_TYPE_AICPU);
    rtStream_t stream;
    rtError_t error = rtsStreamCreate(&stream, nullptr);
    EXPECT_EQ(error, RT_ERROR_NONE);

    RtArgsWithType argsWithType{};
    argsWithType.type = RT_ARGS_CPU_EX;
    rtCpuKernelArgs_t cpuArgsInfo = rtCpuKernelArgs_t{};
    argsWithType.args.cpuArgsInfo = &cpuArgsInfo;
    rtAicpuArgsEx_t baseArgs = rtAicpuArgsEx_t{};
    cpuArgsInfo.baseArgs = baseArgs;

    rtKernelLaunchCfg_t taskCfg;
    taskCfg.numAttrs = 1;
    rtLaunchKernelAttr_t attrs[1];
    attrs[0].id = RT_LAUNCH_KERNEL_ATTR_DATA_DUMP;
    taskCfg.attrs = attrs;

    ApiImplDavid impl;
    error = impl.LaunchKernelV2(kernel, 1, &argsWithType, RtPtrToPtr<Stream *>(stream), &taskCfg);
    EXPECT_EQ(error, RT_ERROR_NONE);

    delete kernel;
    error = rtStreamDestroy(stream);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    ((Runtime *)Runtime::Instance())->DeviceRelease(device);
}

TEST_F(TaskTestV201, LaunchKernelV2_NonCPU)
{
    Device *device = ((Runtime *)Runtime::Instance())->DeviceRetain(0, 0);
    MOCKER(StreamLaunchKernelV2).stubs().will(returnValue(RT_ERROR_NONE));
    
    PlainProgram stubProg(Program::MACH_AI_CORE);
    Program *program = &stubProg;
    const char* stub = "";
    void* stubFunc = nullptr;
    Kernel * kernel = new (std::nothrow) Kernel(stubFunc, stub, static_cast<uint64_t>(0), program, 0);
    kernel->SetKernelRegisterType(RT_KERNEL_REG_TYPE_NON_CPU);
    rtStream_t stream;
    rtError_t error = rtsStreamCreate(&stream, nullptr);
    EXPECT_EQ(error, RT_ERROR_NONE);

    RtArgsWithType argsWithType{};
    argsWithType.type = RT_ARGS_NON_CPU_EX;
    rtCpuKernelArgs_t cpuArgsInfo = rtCpuKernelArgs_t{};
    argsWithType.args.cpuArgsInfo = &cpuArgsInfo;
    rtAicpuArgsEx_t baseArgs = rtAicpuArgsEx_t{};
    cpuArgsInfo.baseArgs = baseArgs;

    rtKernelLaunchCfg_t taskCfg;
    taskCfg.numAttrs = 1;
    rtLaunchKernelAttr_t attrs[1];
    attrs[0].id = RT_LAUNCH_KERNEL_ATTR_BLOCK_TASK_PREFETCH;
    attrs[0].value.isBlockTaskPrefetch = BLOCK_PREFETCH_ENABLE;
    taskCfg.attrs = attrs;

    ApiImplDavid impl;
    MOCKER_CPP_VIRTUAL(impl, &ApiImplDavid::NopTask).stubs().will(returnValue(RT_ERROR_NONE));
    error = impl.LaunchKernelV2(kernel, 1, &argsWithType, RtPtrToPtr<Stream *>(stream), &taskCfg);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtStreamDestroy(stream);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
    delete kernel;
    ((Runtime *)Runtime::Instance())->DeviceRelease(device);
}

TEST_F(TaskTestV201, LaunchKernelV2_Handle)
{
    Device *device = ((Runtime *)Runtime::Instance())->DeviceRetain(0, 0);
    MOCKER_CPP(&ApiImplDavid::LaunchKernelByHandle).stubs().will(returnValue(RT_ERROR_NONE));
    PlainProgram stubProg(Program::MACH_AI_CPU);
    Program *program = &stubProg;
    const char* stub = "";
    void* stubFunc = nullptr;
    Kernel * kernel = new (std::nothrow) Kernel(stubFunc, stub, static_cast<uint64_t>(0), program, 0);
    kernel->SetKernelRegisterType(RT_KERNEL_REG_TYPE_CPU);
    kernel->SetKernelType_(KERNEL_TYPE_AICPU);
    rtStream_t stream;
    rtError_t error = rtsStreamCreate(&stream, nullptr);
    EXPECT_EQ(error, RT_ERROR_NONE);

    RtArgsWithType argsWithType{};
    argsWithType.type = RT_ARGS_HANDLE;
    rtCpuKernelArgs_t cpuArgsInfo = rtCpuKernelArgs_t{};
    argsWithType.args.cpuArgsInfo = &cpuArgsInfo;
    rtAicpuArgsEx_t baseArgs = rtAicpuArgsEx_t{};
    cpuArgsInfo.baseArgs = baseArgs;

    rtKernelLaunchCfg_t taskCfg;
    taskCfg.numAttrs = 1;
    rtLaunchKernelAttr_t attrs[1];
    attrs[0].id = RT_LAUNCH_KERNEL_ATTR_DATA_DUMP;
    taskCfg.attrs = attrs;

    ApiImplDavid impl;
    error = impl.LaunchKernelV2(kernel, 1, &argsWithType, RtPtrToPtr<Stream *>(stream), &taskCfg);
    EXPECT_EQ(error, RT_ERROR_NONE);

    delete kernel;
    error = rtStreamDestroy(stream);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    ((Runtime *)Runtime::Instance())->DeviceRelease(device);
}

TEST_F(TaskTestV201, LaunchKernelV2_RT_ARGS_MAX)
{
    Device *device = ((Runtime *)Runtime::Instance())->DeviceRetain(0, 0);
    MOCKER_CPP(&ApiImplDavid::LaunchKernelByHandle).stubs().will(returnValue(RT_ERROR_NONE));
    PlainProgram stubProg(Program::MACH_AI_CPU);
    Program *program = &stubProg;
    const char* stub = "";
    void* stubFunc = nullptr;
    Kernel * kernel = new (std::nothrow) Kernel(stubFunc, stub, static_cast<uint64_t>(0), program, 0);
    kernel->SetKernelRegisterType(RT_KERNEL_REG_TYPE_CPU);
    kernel->SetKernelType_(KERNEL_TYPE_AICPU);
    rtStream_t stream;
    rtError_t error = rtsStreamCreate(&stream, nullptr);
    EXPECT_EQ(error, RT_ERROR_NONE);

    RtArgsWithType argsWithType{};
    argsWithType.type = RT_ARGS_MAX;
    rtCpuKernelArgs_t cpuArgsInfo = rtCpuKernelArgs_t{};
    argsWithType.args.cpuArgsInfo = &cpuArgsInfo;
    rtAicpuArgsEx_t baseArgs = rtAicpuArgsEx_t{};
    cpuArgsInfo.baseArgs = baseArgs;

    rtKernelLaunchCfg_t taskCfg;
    taskCfg.numAttrs = 1;
    rtLaunchKernelAttr_t attrs[1];
    attrs[0].id = RT_LAUNCH_KERNEL_ATTR_DATA_DUMP;
    taskCfg.attrs = attrs;

    ApiImplDavid impl;
    error = impl.LaunchKernelV2(kernel, 1, &argsWithType, RtPtrToPtr<Stream *>(stream), &taskCfg);
    EXPECT_EQ(error, RT_ERROR_INVALID_VALUE);

    delete kernel;
    error = rtStreamDestroy(stream);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    ((Runtime *)Runtime::Instance())->DeviceRelease(device);
}

TEST_F(TaskTestV201F, TestCpuKernelLaunch)
{
    rtError_t error;
    ApiImplDavid apiImpl;
    void *args[] = {&error, NULL};
    rtAicpuArgsEx_t argsInfo = {};
    argsInfo.args = args;
    argsInfo.argsSize = sizeof(args);
    char_t* opName = "testOp";
    MOCKER(StreamLaunchCpuKernelExWithArgs).stubs().will(returnValue(RT_ERROR_NONE));
    error = apiImpl.CpuKernelLaunchExWithArgs(opName, 1, &argsInfo, NULL, NULL,2,2);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(TaskTestV201, Test_Construct_Simt_Sqe)
{
    TaskInfo task = {};
 
    rtDavidSqe_t *sqe = (rtDavidSqe_t *)malloc(sizeof(rtDavidSqe_t));
    InitByStream(&task, stream_);

    const void *stubFunc = (void *)0x02;
    const char *stubName = "abc";
    Kernel *kernel = NULL;
    PlainProgram stubProg(Program::MACH_AI_CORE);
    Program *program = &stubProg;
    program->kernelNames_ = {'a', 'b', 'c', 'd', '\0'};
    kernel = new (std::nothrow) Kernel(stubFunc, stubName, "", program, 0);
    ((Runtime *)Runtime::Instance())->kernelTable_.Add(kernel);
    kernel->SetKernelVfType_(static_cast<uint32_t>(AivTypeFlag::AIV_TYPE_SIMT_VF_ONLY));
    kernel->SetShareMemSize_(8192);

    uint64_t sqBaseAddr = 0U;
    rtDavidSqe_t *sqeAddr = sqe;
    uint16_t pos = task.id;
    uint64_t oldSqAddr = stream_->GetSqBaseAddr();
    uint64_t newSqAddr = reinterpret_cast<uint64_t>(sqe);
    stream_->SetSqBaseAddr(newSqAddr);
    sqeAddr = reinterpret_cast<rtDavidSqe_t *>(stream_->GetSqBaseAddr() + (pos << SHIFT_SIX_SIZE));

    AicTaskInit(&task, Program::MACH_AI_CORE, 1, 1, nullptr);
    EXPECT_EQ(task.type, TS_TASK_TYPE_KERNEL_AICORE);
    task.id = 0;
    task.u.aicTaskInfo.kernel = kernel;
    task.u.aicTaskInfo.dynamicShareMemSize = 8192;
    ToConstructDavidSqe(&task, sqeAddr, stream_->GetSqBaseAddr());
    EXPECT_EQ(sqe->aicpuControlSqe.header.type, RT_DAVID_SQE_TYPE_AIC);

    free(sqe);
    sqe = nullptr;
}