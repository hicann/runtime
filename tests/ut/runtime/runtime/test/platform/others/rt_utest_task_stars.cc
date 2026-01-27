/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "gtest/gtest.h"
#include "mockcpp/mockcpp.hpp"
#include "securec.h"
#define protected public
#define private public
#include "base.hpp"
#include "task.hpp"
#include "stars.hpp"
#include "hwts.hpp"
#include "notify.hpp"
#include "count_notify.hpp"
#undef protected
#undef private
#include "ffts_task.h"
#include "rdma_task.h"
#include "context.hpp"
#include "runtime.hpp"
#include "uma_arg_loader.hpp"
#include "stars_cond_isa_define.hpp"
#include "thread_local_container.hpp"
#include "raw_device.hpp"
#include "task_execute_time.h"
#include "capture_model_utils.hpp"
#include "config_define.hpp"
using namespace testing;
using namespace cce::runtime;

class StarsTaskTest : public testing::Test {
protected:
    static void SetUpTestCase()
    {
        std::cout << "StarsTaskTest start" << std::endl;
    }

    static void TearDownTestCase()
    {
        std::cout << "StarsTaskTest end" << std::endl;
    }

    virtual void SetUp()
    {
        oriChipType = GlobalContainer::GetRtChipType();
        int32_t devId = -1;
        rtSetDevice(0);
        rtGetDevice(&devId);
        dev_ = ((Runtime *)Runtime::Instance())->DeviceRetain(devId, 0);
        old = dev_->GetPlatformType();

        rtStreamCreate((rtStream_t*)&stream_, 0);
        ctx_ = Runtime::Instance()->CurrentContext();
        std::cout<<"RtsStApi test start start. old platform="<<old<<std::endl;
    }
    virtual void TearDown()
    {
        GlobalMockObject::verify();
        rtStreamDestroy(stream_);
        dev_->SetPlatformType(old);
        ((Runtime *)Runtime::Instance())->DeviceRelease(dev_);
        rtDeviceReset(0);
        stream_ = nullptr;
        dev_ = nullptr;
        GlobalContainer::SetRtChipType(oriChipType);
        std::cout<<"RtsStApi test start end"<<std::endl;
    }

protected:
    rtChipType_t oriChipType;
    Stream *stream_ = nullptr;
    Device *dev_ = nullptr;
    Context *ctx_ = nullptr;
    rtPlatformType_t old;
    static bool flag;
};

TEST_F(StarsTaskTest, DoCompleteStarsError_david)
{
    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    rtChipType_t oriChipType = rtInstance->GetChipType();
    rtInstance->SetChipType(CHIP_DAVID);
    GlobalContainer::SetRtChipType(CHIP_DAVID);

    rtError_t ret;
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

    TaskInfo task = {};
    InitByStream(&task, stream);

    task.u.notifywaitTask.u.notify = notify;
    ret = NotifyWaitTaskInit(&task, 0, 0, nullptr, notify, false);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    rtStarsSqe_t sqe;
    ToConstructSqe(&task, &sqe);
    uint32_t errorcode = 10;

    rtLogicCqReport_t wait_cqe = {};
    wait_cqe.errorType = 1U;
    wait_cqe.errorCode = 1U;

    TaskInfo *errTask = dev_->GetTaskFactory()->Alloc(stream_, TS_TASK_TYPE_KERNEL_AICORE, ret);
    dev_->GetTaskFactory()->SetSerialId(stream_, errTask);
    AicTaskInit(errTask, 0, 1, 0, nullptr);
    EXPECT_EQ(errTask->type, TS_TASK_TYPE_KERNEL_AICORE);

    rtStarsCqeSwStatus_t sw_status;
    sw_status.model_exec.stream_id = errTask->stream->Id_();
    sw_status.model_exec.task_id = errTask->id;
    GetRealReportFaultTask(&task, static_cast<const void *>(&sw_status));
    (void)dev_->GetTaskFactory()->Recycle(errTask);
    SetStarsResult(&task, wait_cqe);
    Complete(&task, 0);

    TaskInfo execTask = {};
    execTask.stream = stream;
    ModelExecuteTaskInit(&execTask, model, 0, 0);
    rtLogicCqReport_t cqe = {};
    cqe.errorType = 1U;
    SetStarsResult(&execTask, cqe);

    ret = rtNotifyDestroy(notify);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    ret = rtStreamDestroy(stream);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    ret = rtModelDestroy(model);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    rtInstance->SetChipType(oriChipType);
    GlobalContainer::SetRtChipType(oriChipType);
}
