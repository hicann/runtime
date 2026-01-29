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
#include "task_res.hpp"
#include "davinci_kernel_task.h"
using namespace testing;
using namespace cce::runtime;

rtError_t stubGetHardVerBySocVer(const uint32_t deviceId, int64_t &hardwareVersion)
{
    hardwareVersion = PLATFORMCONFIG_CLOUD_V2;
    return DRV_ERROR_NONE;
}

class StarsTaskTest : public testing::Test {
protected:
    static void SetUpTestCase()
    {
        flag = ((Runtime *)Runtime::Instance())->GetDisableThread();
        std::cout << "StarsTaskTest start" << std::endl;
    }

    static void TearDownTestCase()
    {
        std::cout << "StarsTaskTest end" << std::endl;
        ((Runtime *)Runtime::Instance())->SetDisableThread(flag);
    }

    virtual void SetUp()
    {
        GlobalMockObject::verify();
        MOCKER(GetHardVerBySocVer).stubs().will(invoke(stubGetHardVerBySocVer));
        (void)rtSetSocVersion("Ascend910B1");
        Runtime *rtInstance = (Runtime *)Runtime::Instance();
        int32_t devId = -1;
        rtSetDevice(0);
        rtGetDevice(&devId);
        dev_ = ((Runtime *)Runtime::Instance())->DeviceRetain(devId, 0);
        old = dev_->GetPlatformType();
        dev_->SetPlatformType(PLATFORM_CLOUD_V2);

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
bool StarsTaskTest::flag = false;

TEST_F(StarsTaskTest, CheckSqeSize)
{
    constexpr size_t sqeSize = 64;
    EXPECT_EQ(sizeof(rtStarsSqe_t), sqeSize);
    EXPECT_EQ(sizeof(cce::runtime::rtStarsCommonSqe_t), sqeSize);
    EXPECT_EQ(sizeof(RtStarsKernelSqe), sqeSize);
    EXPECT_EQ(sizeof(RtStarsAicpuKernelSqe), sqeSize);
    EXPECT_EQ(sizeof(RtStarsPhSqe), sqeSize);
    EXPECT_EQ(sizeof(RtStarsEventSqe), sqeSize);
    EXPECT_EQ(sizeof(RtStarsNotifySqe), sqeSize);
    EXPECT_EQ(sizeof(RtStarsWriteValueSqe), sqeSize);
    EXPECT_EQ(sizeof(RtStarsMemcpyAsyncSqe), sqeSize);
    EXPECT_EQ(sizeof(RtStarsStreamSwitchSqe), sqeSize);
    EXPECT_EQ(sizeof(RtStarsRdmaSinkSqe1), sqeSize);
    EXPECT_EQ(sizeof(RtStarsRdmaSinkSqe2), sqeSize);
    EXPECT_EQ(sizeof(RtStarsStreamResetHeadSqe), sqeSize);
}

TEST_F(StarsTaskTest, StreamSwitch)
{
    Stream *trueStream = new Stream(dev_, 0);
    trueStream->Setup();

    std::vector<rtCondition_t> conds = {RT_EQUAL, RT_NOT_EQUAL, RT_GREATER,
                                        RT_GREATER_OR_EQUAL, RT_LESS, RT_LESS_OR_EQUAL};
    // stars cond op is not same as runtime.
    // when condition is true, it jump to end adn do nothing, but runtime is need jump to true stream.
    std::vector<rtStarsCondIsaBranchFunc3_t> expectStarsConds = {RT_STARS_COND_ISA_BRANCH_FUNC3_BNE,
                                                                 RT_STARS_COND_ISA_BRANCH_FUNC3_BEQ,
                                                                 RT_STARS_COND_ISA_BRANCH_FUNC3_BGE,
                                                                 RT_STARS_COND_ISA_BRANCH_FUNC3_BLT,
                                                                 RT_STARS_COND_ISA_BRANCH_FUNC3_BGE,
                                                                 RT_STARS_COND_ISA_BRANCH_FUNC3_BLT};

    ASSERT_EQ(conds.size(), expectStarsConds.size());

    int64_t varData = 0;
    int64_t value = 0;
    for (int i = 0; i < conds.size(); ++i) {
        TaskInfo task = {};
        task.id = i;
        InitByStream(&task, stream_);
        rtError_t ret = StreamSwitchTaskInitV1(&task, &varData, conds[i], value, trueStream);
        EXPECT_EQ(ret, RT_ERROR_NONE);
        rtStarsSqe_t sqe = {};
        auto &streamSwitchSqe = sqe.fuctionCallSqe;
        ToConstructSqe(&task, &sqe);
        PrintErrorInfo(&task, dev_->Id_());
        TaskUnInitProc(&task);
    }
    DeleteStream(trueStream);
}

TEST_F(StarsTaskTest, StreamSwitchEx)
{
    Stream *trueStreams = new Stream(dev_, 0);
    trueStreams->Setup();
    uint32_t trueStreamSqId = trueStreams->GetSqId();
    uint32_t currentStreamId = (uint32_t) stream_->Id_();
    uint32_t currentStreamSqId = stream_->GetSqId();

    std::vector<rtCondition_t> conds = {RT_EQUAL, RT_NOT_EQUAL, RT_GREATER,
                                        RT_GREATER_OR_EQUAL, RT_LESS, RT_LESS_OR_EQUAL};

    // stars cond op is not same as runtime.
    // when condition is true, it jump to end adn do nothing, but runtime is need jump to true stream.
    std::vector<rtStarsCondIsaBranchFunc3_t> expectStarsConds = {RT_STARS_COND_ISA_BRANCH_FUNC3_BNE,
                                                                 RT_STARS_COND_ISA_BRANCH_FUNC3_BEQ,
                                                                 RT_STARS_COND_ISA_BRANCH_FUNC3_BGE,
                                                                 RT_STARS_COND_ISA_BRANCH_FUNC3_BLT,
                                                                 RT_STARS_COND_ISA_BRANCH_FUNC3_BGE,
                                                                 RT_STARS_COND_ISA_BRANCH_FUNC3_BLT};

    ASSERT_EQ(conds.size(), expectStarsConds.size());

    int64_t varData = 0;
    int64_t value = 0;

    std::vector<rtSwitchDataType_t> dataTypes = {RT_SWITCH_INT32, RT_SWITCH_INT64};

    for (auto dataType:dataTypes) {
        rtStarsCondIsaLoadImmFunc3_t expectLdFunc3 =
                (dataType == RT_SWITCH_INT64) ? RT_STARS_COND_ISA_LOAD_IMM_FUNC3_LD
                                              : RT_STARS_COND_ISA_LOAD_IMM_FUNC3_LW;
        for (int i = 0; i < conds.size(); ++i) {
            TaskInfo task = {};
            task.id = i;
            InitByStream(&task, stream_);
            rtError_t ret = StreamSwitchTaskInitV2(&task, &varData, conds[i], trueStreams, &value, dataType);
            EXPECT_EQ(ret, RT_ERROR_NONE);
            rtStarsSqe_t sqe = {};
            auto &streamSwitchExSqe = sqe.fuctionCallSqe;
            ToConstructSqe(&task, &sqe);
            TaskUnInitProc(&task);
        }
    }
    DeleteStream(trueStreams);
}

TEST_F(StarsTaskTest, RdmaNoSink)
{
    TaskInfo rdmaNoSinkTask = {};
    uint32_t dbIndex = 0x6000U;
    uint64_t dbInfo = 0x500000001ULL;

    InitByStream(&rdmaNoSinkTask, stream_);
    rtError_t ret = RdmaDbSendTaskInit(&rdmaNoSinkTask, dbIndex, dbInfo, 0U);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    uint32_t sqeNum = GetSendSqeNum(&rdmaNoSinkTask);
    EXPECT_EQ(sqeNum, 1U);

    TaskInfo *task = &rdmaNoSinkTask;
    rtStarsSqe_t command = {};
    RtStarsWriteValueSqe &sqe = command.writeValueSqe;
    ToConstructSqe(task, &command);
    EXPECT_EQ(sqe.header.type, RT_STARS_SQE_TYPE_WRITE_VALUE);
    EXPECT_EQ(sqe.header.wr_cqe, 0);
    EXPECT_EQ(sqe.va, 0U);
    EXPECT_EQ(sqe.write_value_part0, dbInfo & MASK_32_BIT);
    EXPECT_EQ(sqe.write_value_part1, dbInfo >> UINT32_BIT_NUM);
}

TEST_F(StarsTaskTest, RdmaSink)
{
    rtError_t ret;
    rtModel_t model;
    Stream *stream;

    ret = rtStreamCreate((rtStream_t*)&stream, 0);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    ret = rtModelCreate(&model, 0);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    ret = rtModelBindStream(model, stream, 0);
    EXPECT_NE(ret, RT_ERROR_NONE);

    uint16_t *svm = stream->GetExecutedTimesSvm();
    uintptr_t svmAddr = (uintptr_t)svm;
    EXPECT_NE(svm, nullptr);

    TaskInfo rdmaSinkTask1 = {};
    TaskInfo rdmaSinkTask2 = {};
    rtRdmaDbIndex_t dbIndex;
    rtRdmaDbInfo_t dbInfo;
    dbInfo.cmd.sqProducerIdx = 5U;
    dbIndex.dbIndexStars.sqDepthBitWidth = 6U;
    dbIndex.dbIndexStars.vfId = 0U;
    dbIndex.dbIndexStars.dieId = 0U;

    stream->SetBindFlag(true);
    InitByStream(&rdmaSinkTask1, stream);
    ret = RdmaDbSendTaskInit(&rdmaSinkTask1, dbIndex.value, dbInfo.value, 1);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    uint32_t sqeNum = GetSendSqeNum(&rdmaSinkTask1);
    EXPECT_EQ(sqeNum, 1U);

    TaskInfo *task1 = &rdmaSinkTask1;
    rtStarsSqe_t command1 = {};
    RtStarsRdmaSinkSqe1 &sqe1 = command1.rdmaSinkSqe1;
    ToConstructSqe(task1, &command1);

    EXPECT_EQ(sqe1.sqeHeader.type, RT_STARS_SQE_TYPE_COND);
    EXPECT_EQ(sqe1.sqeHeader.wr_cqe, 0U);
    EXPECT_EQ(sqe1.sqeHeader.l1_lock, 1U);
    EXPECT_EQ(sqe1.sqeHeader.l1_unlock, 0U);
    EXPECT_EQ(sqe1.csc, 1U);
    EXPECT_EQ(sqe1.slli1.shamt, dbIndex.dbIndexStars.sqDepthBitWidth);
    EXPECT_EQ(sqe1.addi.immd, dbInfo.cmd.sqProducerIdx);
    EXPECT_EQ(sqe1.lhu.immdAddrHigh, svmAddr >> UINT32_BIT_NUM);
    EXPECT_EQ(sqe1.lhu.immdAddrLow, svmAddr & MASK_32_BIT);

    InitByStream(&rdmaSinkTask2, stream);
    ret = RdmaDbSendTaskInit(&rdmaSinkTask2, dbIndex.value, dbInfo.value, 2);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    sqeNum = GetSendSqeNum(&rdmaSinkTask2);
    EXPECT_EQ(sqeNum, 1U);

    TaskInfo *task2 = &rdmaSinkTask2;
    rtStarsSqe_t command2 = {};
    RtStarsRdmaSinkSqe2 &sqe2 = command2.rdmaSinkSqe2;
    ToConstructSqe(task2, &command2);
    EXPECT_EQ(sqe2.sqeHeader.type, RT_STARS_SQE_TYPE_COND);
    EXPECT_EQ(sqe2.sqeHeader.wr_cqe, 0U);
    EXPECT_EQ(sqe2.sqeHeader.l1_lock, 0U);
    EXPECT_EQ(sqe2.sqeHeader.l1_unlock, 1U);
    EXPECT_EQ(sqe2.csc, 0U);
  
    ret = rtModelUnbindStream(model, stream);
    EXPECT_NE(ret, ACL_RT_SUCCESS);
    stream->DelModel((Model*)model);
    ret = rtStreamDestroy(stream);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    ((Model*)model)->ModelRemoveStream(stream);
    ret = rtModelDestroy(model);
    EXPECT_EQ(ret, RT_ERROR_NONE);
}

TEST_F(StarsTaskTest, ModelExecute)
{
    rtError_t ret;
    rtModel_t model;
    TaskInfo mdlExecTask = {};
    
    Stream *headSream;
    ret = rtStreamCreate((rtStream_t*)&headSream, 0);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    ret = rtModelCreate(&model, 0);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    ret = rtModelBindStream(model, headSream, RT_HEAD_STREAM);
    EXPECT_NE(ret, RT_ERROR_NONE);
    headSream->SetBindFlag(true);

    InitByStream(&mdlExecTask, headSream);

    ret = ModelExecuteTaskInit(&mdlExecTask, (Model *)model, ((Model *)model)->Id_(), 0);
    EXPECT_NE(ret, RT_ERROR_NONE);
    uint32_t sqeNum = GetSendSqeNum(&mdlExecTask);
    EXPECT_EQ(sqeNum, 1U);

    TaskInfo *task = &mdlExecTask;
    rtStarsSqe_t command[3] = {};
    ToConstructSqe(task, command);
    EXPECT_NE(ret, RT_ERROR_NONE);
    TaskUnInitProc(task);
    ret = rtModelUnbindStream(model, headSream);
    EXPECT_NE(ret, ACL_RT_SUCCESS);
    headSream->DelModel((Model*)model);
    ret = rtStreamDestroy(headSream);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    ((Model*)model)->ModelRemoveStream(headSream);
    ret = rtModelDestroy(model);
    EXPECT_EQ(ret, RT_ERROR_NONE);
}

TEST_F(StarsTaskTest, ModelExecute_failed)
{
    rtError_t ret;
    rtModel_t model;
    TaskInfo mdlExecTask = {};
    Stream *headSream;
    ret = rtStreamCreate((rtStream_t*)&headSream, 0);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    ret = rtModelCreate(&model, 0);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    ret = rtModelBindStream(model, headSream, RT_HEAD_STREAM);
    EXPECT_NE(ret, RT_ERROR_NONE);
    headSream->SetBindFlag(true);

    InitByStream(&mdlExecTask, headSream);
    MOCKER(memcpy_s).stubs().will(returnValue(EINVAL));
    ret = ModelExecuteTaskInit(&mdlExecTask, (Model *)model, ((Model *)model)->Id_(), 0);
    EXPECT_NE(ret, RT_ERROR_SEC_HANDLE);

    ret = rtModelUnbindStream(model, headSream);
    EXPECT_NE(ret, RT_ERROR_NONE);
    headSream->DelModel((Model*)model);
    ret = rtStreamDestroy(headSream);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    ((Model*)model)->ModelRemoveStream(headSream);
    ret = rtModelDestroy(model);
    EXPECT_EQ(ret, RT_ERROR_NONE);
}

TEST_F(StarsTaskTest, FuncCallAllocDevMem_devMem_failed)
{
    rtError_t ret;
    rtModel_t model;
    TaskInfo mdlExecTask = {};
    Stream *headSream;
    ret = rtStreamCreate((rtStream_t*)&headSream, 0);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    ret = rtModelCreate(&model, 0);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    ret = rtModelBindStream(model, headSream, RT_HEAD_STREAM);
    EXPECT_NE(ret, RT_ERROR_NONE);
    headSream->SetBindFlag(true);

    InitByStream(&mdlExecTask, headSream);
    MOCKER_CPP_VIRTUAL(dev_->Driver_(), &Driver::DevMemAlloc).stubs().will(returnValue(RT_ERROR_DRV_INPUT));
    ret = ModelExecuteTaskInit(&mdlExecTask, (Model *)model, ((Model *)model)->Id_(), 0);
    EXPECT_NE(ret, RT_ERROR_DRV_INPUT);

    ret = rtModelUnbindStream(model, headSream);
    EXPECT_NE(ret, RT_ERROR_NONE);
    headSream->DelModel((Model*)model);
    ret = rtStreamDestroy(headSream);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    ((Model*)model)->ModelRemoveStream(headSream);
    ret = rtModelDestroy(model);
    EXPECT_EQ(ret, RT_ERROR_NONE);
}

TEST_F(StarsTaskTest, ModelMaintaince)
{
    rtError_t ret;
    Model *model;
    Stream *stream;

    ret = rtStreamCreate((rtStream_t *)&stream, 0);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    ret = rtModelCreate((rtModel_t *)&model, 0);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    TaskInfo maintainceTask = {};
    TaskInfo *task = &maintainceTask;
    rtStarsSqe_t sqe = {};

    InitByStream(&maintainceTask, stream_);
    (void)ModelMaintainceTaskInit(&maintainceTask, MMT_STREAM_ADD, model, stream, RT_MODEL_HEAD_STREAM, 0U);
    ToConstructSqe(task, &sqe);
    EXPECT_EQ(sqe.phSqe.pre_p, 1U);

    (void)ModelMaintainceTaskInit(&maintainceTask, MMT_STREAM_LOAD_COMPLETE, model, stream, RT_MODEL_HEAD_STREAM, 0U);
    ToConstructSqe(task, &sqe);
    (void)ModelMaintainceTaskInit(&maintainceTask, MMT_MODEL_LOAD_COMPLETE, model, stream, RT_MODEL_HEAD_STREAM, 0U);
    ToConstructSqe(task, &sqe);

    (void)ModelMaintainceTaskInit(&maintainceTask, MMT_MODEL_ABORT, model, stream, RT_MODEL_HEAD_STREAM, 0U);
    ToConstructSqe(task, &sqe);

    (void)ModelMaintainceTaskInit(&maintainceTask, MMT_STREAM_DEL, model, stream, RT_MODEL_HEAD_STREAM, 0U);
    ToConstructSqe(task, &sqe);
    EXPECT_EQ(stream->GetBindFlag(), false);
    EXPECT_EQ(sqe.phSqe.pre_p, 1U);

    ret = rtStreamDestroy(stream);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    ret = rtModelDestroy(model);
    EXPECT_EQ(ret, RT_ERROR_NONE);
}

TEST_F(StarsTaskTest, MaintainceTaskForceRecycle)
{
    TaskInfo maintainceTask = {};
    TaskInfo *task = &maintainceTask;
    rtStarsSqe_t sqe = {};

    InitByStream(&maintainceTask, stream_);
    (void)MaintenanceTaskInit(&maintainceTask, MT_STREAM_RECYCLE_TASK, 100U, 1U);
    ToConstructSqe(task, &sqe);

    EXPECT_EQ(sqe.phSqe.pre_p, 1U);
}

TEST_F(StarsTaskTest, WaitEndgraphError)
{
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
    ret = NotifyWaitTaskInit(&task, 0, 0, nullptr, nullptr, false);
    rtStarsSqe_t sqe;
    ToConstructSqe(&task, &sqe);
    uint32_t errorcode = 10;

    rtLogicCqReport_t wait_cqe = {};
    wait_cqe.errorType = 1U;
    wait_cqe.errorCode = 0U;

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
}

TEST_F(StarsTaskTest, DoCompleteStarsError)
{
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
    ret = NotifyWaitTaskInit(&task, 0, 0, nullptr, nullptr, false);
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
}

TEST_F(StarsTaskTest, DoCompleteStarsError2)
{
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
    ret = NotifyWaitTaskInit(&task, 0, 0, nullptr, nullptr, false);
    rtStarsSqe_t sqe;
    ToConstructSqe(&task, &sqe);
    uint32_t errorcode = 10;

    rtLogicCqReport_t wait_cqe = {};
    wait_cqe.errorType = 1U;
    wait_cqe.errorCode = 2U;

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
}

TEST_F(StarsTaskTest, DoCompleteStarsError3)
{
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
    ret = NotifyWaitTaskInit(&task, 0, 0, nullptr, nullptr, false);
    rtStarsSqe_t sqe;
    ToConstructSqe(&task, &sqe);
    uint32_t errorcode = 10;

    rtLogicCqReport_t wait_cqe = {};
    wait_cqe.errorType = 1U;
    wait_cqe.errorCode = 3U;

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
}

TEST_F(StarsTaskTest, DoCompleteStarsSdmaError)
{
    Model *model;
    Stream *stream;

    rtError_t ret = rtStreamCreate((rtStream_t *)&stream, 0);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    ret = rtModelCreate((rtModel_t *)&model, 0);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    TaskInfo task = {};
    InitByStream(&task, stream);

    TaskInfo execTask = {};
    execTask.stream = stream;
    ModelExecuteTaskInit(&execTask, model, 0, 0);

    execTask.errorCode = 0x221;
    execTask.mte_error = 0x221;
    MOCKER(GetRealReportFaultTaskForModelExecuteTask)
        .stubs()
        .will(returnValue(&execTask));
    Complete(&execTask, 0);

    GlobalMockObject::verify();

    execTask.errorCode = 0x221;
    execTask.mte_error = 0xFFFF;
    MOCKER(GetRealReportFaultTaskForModelExecuteTask)
        .stubs()
        .will(returnValue(&execTask));
    Complete(&execTask, 0);

    ret = rtStreamDestroy(stream);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    ret = rtModelDestroy(model);
    EXPECT_EQ(ret, RT_ERROR_NONE);
}

TEST_F(StarsTaskTest, RingBufferMaintain)
{
    TaskInfo maintainceTask = {};
    TaskInfo *task = &maintainceTask;
    rtStarsSqe_t sqe = {};

    InitByStream(&maintainceTask, stream_);
    rtError_t ret = RingBufferMaintainTaskInit(&maintainceTask, (void *)0x100, 0, 10);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    ToConstructSqe(task, &sqe);
    EXPECT_EQ(sqe.phSqe.pre_p, 1U);
}

TEST_F(StarsTaskTest, SetStarsEventWaitTask)
{
    TaskInfo execTask = {};
    execTask.errorCode = 1U;
    execTask.type = TS_TASK_TYPE_STREAM_WAIT_EVENT;

    rtLogicCqReport_t wait_cqe = {};
    wait_cqe.errorCode = 3U;

    SetStarsResult(&execTask, wait_cqe);
    EXPECT_EQ(execTask.errorCode, 3U);
}

TEST_F(StarsTaskTest, DeviceSatMode)
{
    rtError_t ret;
    rtFloatOverflowMode_t mode = RT_OVERFLOW_MODE_UNDEF;

    ret = rtGetDeviceSatMode(&mode);
    EXPECT_EQ(ret, ACL_RT_SUCCESS);
    EXPECT_EQ(mode, RT_OVERFLOW_MODE_INFNAN);

    ret = rtSetDeviceSatMode(RT_OVERFLOW_MODE_INFNAN);
    EXPECT_EQ(ret, ACL_RT_SUCCESS);
    ret = rtGetDeviceSatMode(&mode);
    EXPECT_EQ(ret, ACL_RT_SUCCESS);
    EXPECT_EQ(mode, RT_OVERFLOW_MODE_INFNAN);

    rtStream_t stream;
    ret = rtStreamCreate(&stream, 0);
    EXPECT_EQ(ret, ACL_RT_SUCCESS);
    ret = rtGetDeviceSatModeForStream(stream, &mode);
    EXPECT_EQ(ret, ACL_RT_SUCCESS);
    EXPECT_EQ(mode, RT_OVERFLOW_MODE_INFNAN);
    ret = rtGetDeviceSatModeForStream(nullptr, &mode);
    EXPECT_EQ(ret, ACL_RT_SUCCESS);
    EXPECT_EQ(mode, RT_OVERFLOW_MODE_INFNAN);

    ret = rtSetDeviceSatMode(RT_OVERFLOW_MODE_UNDEF);
    EXPECT_EQ(ret, ACL_ERROR_RT_PARAM_INVALID);
    ret = rtSetDeviceSatMode(RT_OVERFLOW_MODE_SATURATION);
    EXPECT_EQ(ret, ACL_RT_SUCCESS);
}

TEST_F(StarsTaskTest, OverflowSwitch)
{
    rtError_t ret;
    rtStream_t stream;
    ret = rtStreamCreate(&stream, 0);
    EXPECT_EQ(ret, ACL_RT_SUCCESS);

    uint32_t flags = 0U;
    ret = rtGetStreamOverflowSwitch(stream, &flags);
    EXPECT_EQ(ret, ACL_RT_SUCCESS);
    EXPECT_EQ(flags, 0U);

    ret = rtSetDeviceSatMode(RT_OVERFLOW_MODE_INFNAN);
    EXPECT_EQ(ret, ACL_RT_SUCCESS);
    ret = rtSetStreamOverflowSwitch(stream, 1U);
    EXPECT_EQ(ret, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
    ret = rtGetStreamOverflowSwitch(stream, &flags);
    EXPECT_EQ(ret, ACL_RT_SUCCESS);
    EXPECT_EQ(flags, 0U);

    ret = rtSetDeviceSatMode(RT_OVERFLOW_MODE_SATURATION);
    EXPECT_EQ(ret, ACL_RT_SUCCESS);
    ret = rtSetStreamOverflowSwitch(stream, 1U);
    EXPECT_EQ(ret, ACL_RT_SUCCESS);
    ret = rtGetStreamOverflowSwitch(stream, &flags);
    EXPECT_EQ(ret, ACL_RT_SUCCESS);
    EXPECT_EQ(flags, 1U);
}

TEST_F(StarsTaskTest, OverflowSwitchSetTask)
{
    rtError_t ret;
    rtModel_t model;

    Stream *stm = new Stream(dev_, 0);
    // std::unique_ptr<Stream> streamGuard(stm);
    stm->Setup();
    TaskInfo tsk = {};
    InitByStream(&tsk, stm);
    ret = OverflowSwitchSetTaskInit(&tsk, stm, 1U);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    rtStarsSqe_t command = {};
    ToConstructSqe(&tsk, &command);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    DeleteStream(stm);
}

TEST_F(StarsTaskTest, DataDumpLoadInfoTask)
{
    rtError_t ret;
    Model *model;
    Stream *stream;
    ret = rtStreamCreate((rtStream_t *)&stream, 0);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    TaskInfo task = {};
    InitByStream(&task, stream);
    DataDumpLoadInfoTaskInit(&task, nullptr, 1, 1);

    uint32_t errorcode = 10;
    SetResult(&task, (const uint32_t *)&errorcode, 1);
    DoCompleteSuccess(&task, 0);

    rtLogicCqReport_t cqe = {};
    cqe.errorType = 1U;
    SetStarsResult(&task, cqe);
}

TEST_F(StarsTaskTest, AllocDsaAddrTask)
{
    rtError_t ret;
    Model *model;
    Stream *stream;
    ret = rtStreamCreate((rtStream_t *)&stream, 0);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    TaskInfo task = {};
    InitByStream(&task, stream);
    AllocDsaAddrTaskInit(&task, 1);

    rtStarsSqe_t command = {};
    ToConstructSqe(&task, &command);
    rtStreamDestroy((rtStream_t *)stream);
}

void DvppGrpCallbackFunc(rtDvppGrpRptInfo_t *report)
{
    UNUSED(report);
}

TEST_F(StarsTaskTest, DvppGrpTestFail)
{
    rtError_t ret;
    rtStream_t stream;
    rtDvppGrp_t grp = nullptr;

    ret = rtStreamCreateByGrp(&stream, 0, 0, grp);
    EXPECT_EQ(ret, ACL_ERROR_RT_PARAM_INVALID);

    ret = rtDvppWaitGroupReport(grp, nullptr, -1);
    EXPECT_EQ(ret, ACL_ERROR_RT_PARAM_INVALID);

    ret = rtDvppGroupDestory(grp);
    EXPECT_EQ(ret, ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(StarsTaskTest, DvppGrpTest)
{
    rtError_t ret;
    rtStream_t stream;
    rtDvppGrp_t grp = nullptr;

    ret = rtDvppGroupCreate(&grp, 0);
    EXPECT_EQ(ret, ACL_RT_SUCCESS);

    ret = rtStreamCreateByGrp(&stream, 0, 0, grp);
    EXPECT_EQ(ret, ACL_RT_SUCCESS);

    ret = rtDvppWaitGroupReport(grp, DvppGrpCallbackFunc, 0);
    EXPECT_EQ(ret, ACL_RT_SUCCESS);

    ret = rtStreamDestroy(stream);
    EXPECT_EQ(ret, ACL_RT_SUCCESS);

    ret = rtDvppGroupDestory(grp);
    EXPECT_EQ(ret, ACL_RT_SUCCESS);
}

TEST_F(StarsTaskTest, WriteValueTaskTest)
{
    cce::runtime::rtStarsCommonSqe_t vpcSqe = {};
    rtError_t ret;

    vpcSqe.sqeHeader.type = RT_STARS_SQE_TYPE_VPC;
    ctx_->StarsLaunch((void*)&vpcSqe, sizeof(cce::runtime::rtStarsCommonSqe_t), stream_, 0);

    uint8_t value[WRITE_VALUE_SIZE_MAX_LEN] = {};
    rtStarsSqe_t cmd;
    uint64_t addr = static_cast<uint64_t>(reinterpret_cast<uintptr_t>(stream_->GetDvppRRTaskAddr()));

    rtStreamSynchronize(stream_);

    TaskInfo *writeValueTask = dev_->GetTaskFactory()->Alloc(stream_, TS_TASK_TYPE_WRITE_VALUE, ret);
    ret = WriteValueTaskInit(writeValueTask, addr, WRITE_VALUE_SIZE_32_BYTE, value, TASK_WR_CQE_NEVER);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    ToConstructSqe(writeValueTask, &cmd);

    ret =  WriteValueTaskInit(writeValueTask, addr, WRITE_VALUE_SIZE_32_BYTE, value, TASK_WR_CQE_DEFAULT);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    ToConstructSqe(writeValueTask, &cmd);

    ret =  WriteValueTaskInit(writeValueTask, addr, WRITE_VALUE_SIZE_32_BYTE, value, TASK_WR_CQE_ALWAYS);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    ToConstructSqe(writeValueTask, &cmd);

    (void)dev_->GetTaskFactory()->Recycle(writeValueTask);
}

TEST_F(StarsTaskTest, NotifyIpcTaskHccsTest)
{
    TaskInfo ntyRecordTask = {};
    InitByStream(&ntyRecordTask, stream_);
    SingleBitNotifyRecordInfo single_bit_notify_info = {true, false, false, false, 1, 0, false};
    Notify *single_notify = new (std::nothrow) Notify(0, 0);
    rtError_t ret = NotifyRecordTaskInit(&ntyRecordTask, 0, 1, 1,
        &single_bit_notify_info, nullptr, single_notify, false);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    NpuDriver drv;
    TaskInfo *task = &ntyRecordTask;
    rtStarsSqe_t sqe = {};

    single_notify->srvId_ = 0U;
    int64_t topologyType = TOPOLOGY_HCCS;
    MOCKER_CPP_VIRTUAL(drv, &NpuDriver::GetPairDevicesInfo).expects(once())
        .with(mockcpp::any(), mockcpp::any(), mockcpp::any(), outBoundP(&topologyType, sizeof(topologyType))).will(returnValue(RT_ERROR_NONE));
    ToConstructSqe(task, &sqe);
    uint64_t addr = (uint64_t)sqe.writeValueSqe.write_addr_high << 32 | sqe.writeValueSqe.write_addr_low;
    EXPECT_EQ(addr & RT_STARS_BASE_ADDR, RT_STARS_BASE_ADDR);
    delete single_notify;
}

TEST_F(StarsTaskTest, NotifyIpcTaskPixTest)
{
    TaskInfo ntyRecordTask = {};
    InitByStream(&ntyRecordTask, stream_);
    SingleBitNotifyRecordInfo single_bit_notify_info = {true, false, false, false, 1, 0, false};
    Notify *single_notify = new (std::nothrow) Notify(0, 0);
    rtError_t ret = NotifyRecordTaskInit(&ntyRecordTask, 0, 1, 1,
        &single_bit_notify_info, nullptr, single_notify, false);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    NpuDriver drv;
    TaskInfo *task = &ntyRecordTask;
    rtStarsSqe_t sqe = {};

    single_notify->srvId_ = 0U;
    int64_t topologyType = TOPOLOGY_PIX;
    MOCKER_CPP_VIRTUAL(drv, &NpuDriver::GetPairDevicesInfo).expects(once())
        .with(mockcpp::any(), mockcpp::any(), mockcpp::any(), outBoundP(&topologyType, sizeof(topologyType))).will(returnValue(RT_ERROR_NONE));
    ToConstructSqe(task, &sqe);
    uint64_t addr = (uint64_t)sqe.writeValueSqe.write_addr_high << 32 | sqe.writeValueSqe.write_addr_low;
    EXPECT_EQ(addr & RT_STARS_PCIE_BASE_ADDR, RT_STARS_PCIE_BASE_ADDR);
    delete single_notify;
}

TEST_F(StarsTaskTest, NotifyIpcTaskErrTest)
{
    TaskInfo ntyRecordTask = {};
    InitByStream(&ntyRecordTask, stream_);
    SingleBitNotifyRecordInfo single_bit_notify_info = {true, false, false, false, 1, 0, false};
    Notify *single_notify = new (std::nothrow) Notify(0, 0);
    rtError_t ret = NotifyRecordTaskInit(&ntyRecordTask, 0, 1, 1,
        &single_bit_notify_info, nullptr, single_notify, false);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    NpuDriver drv;
    TaskInfo *task = &ntyRecordTask;
    rtStarsSqe_t sqe = {};

    single_notify->srvId_ = 0U;
    int64_t topologyType = TOPOLOGY_PIB;
    MOCKER_CPP_VIRTUAL(drv, &NpuDriver::GetPairDevicesInfo).expects(once())
        .with(mockcpp::any(), mockcpp::any(), mockcpp::any(), outBoundP(&topologyType, sizeof(topologyType))).will(returnValue(RT_ERROR_NONE));
    ToConstructSqe(task, &sqe);
    uint64_t addr = (uint64_t)sqe.writeValueSqe.write_addr_high << 32 | sqe.writeValueSqe.write_addr_low;
    EXPECT_EQ(addr, 0);
    delete single_notify;
}

TEST_F(StarsTaskTest, NotifyIpcTaskErrTestDevid64)
{
    TaskInfo ntyRecordTask = {};
    InitByStream(&ntyRecordTask, stream_);
    SingleBitNotifyRecordInfo single_bit_notify_info = {true, false, false, false, 64, 0, false};
    Notify *single_notify = new (std::nothrow) Notify(0, 0);
    rtError_t ret = NotifyRecordTaskInit(&ntyRecordTask, 0, 1, 1,
        &single_bit_notify_info, nullptr, single_notify, false);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    rtStarsSqe_t sqe = {};
    ToConstructSqe(&ntyRecordTask, &sqe);
    delete single_notify;
}

TEST_F(StarsTaskTest, EventResetTask_DoCompleteSuccess)
{
    rtError_t ret;
    Stream *stream;
    ret = rtStreamCreate((rtStream_t *)&stream, 0);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    TaskInfo task = {};
    InitByStream(&task, stream);
    EventResetTaskInit(&task, nullptr, false, -1);

    uint32_t errorcode = 10;
    SetResult(&task, (const uint32_t *)&errorcode, 1);
    Complete(&task, 0);

    rtLogicCqReport_t cqe = {};
    cqe.errorType = 1U;
    SetStarsResult(&task, cqe);
}

TEST_F(StarsTaskTest, MemcpyAsyncTask_sdma_posion_error)
{

    rtError_t error = RT_ERROR_NONE;
    rtStarsSqe_t cmd;
    uint64_t addr = static_cast<uint64_t>(reinterpret_cast<uintptr_t>(stream_->GetDvppRRTaskAddr()));

    TaskInfo *task = dev_->GetTaskFactory()->Alloc(stream_, TS_TASK_TYPE_MEMCPY, error);
    MemcpyAsyncTaskInitV1(task, nullptr, RT_MEMCPY_HOST_TO_DEVICE);
    task->errorCode = 0x221;
    task->mte_error = 0x221;
    ConstructPcieDmaSqe(task, &cmd);
    Complete(task, 0);

    task->errorCode = 0x220;
    task->mte_error = 0x220;
    ConstructPcieDmaSqe(task, &cmd);
    Complete(task, 0);

    task->errorCode = 0x217;
    task->mte_error = 0x217;
    ConstructPcieDmaSqe(task, &cmd);
    Complete(task, 0);

    rtError_t ret;
    ret = dev_->GetTaskFactory()->Recycle(task);
    EXPECT_EQ(ret, RT_ERROR_NONE);
}

TEST_F(StarsTaskTest, MemcpyAsyncTask_ConstructPcieDmaSqe)
{
    rtError_t error = RT_ERROR_NONE;
    rtStarsSqe_t cmd;
    uint64_t addr = static_cast<uint64_t>(reinterpret_cast<uintptr_t>(stream_->GetDvppRRTaskAddr()));

    TaskInfo *task = dev_->GetTaskFactory()->Alloc(stream_, TS_TASK_TYPE_MEMCPY, error);
    MemcpyAsyncTaskInitV1(task, nullptr, RT_MEMCPY_HOST_TO_DEVICE);
    ConstructPcieDmaSqe(task, &cmd);

    Complete(task, 0);
    rtError_t ret;
    ret = dev_->GetTaskFactory()->Recycle(task);
    EXPECT_EQ(ret, RT_ERROR_NONE);
}


TEST_F(StarsTaskTest, MemcpyAsyncTask_ConstructPcieDmaSqe_2)
{
    rtError_t error = RT_ERROR_NONE;
    rtStarsSqe_t cmd;
    uint64_t addr = static_cast<uint64_t>(reinterpret_cast<uintptr_t>(stream_->GetDvppRRTaskAddr()));

    TaskInfo *task = dev_->GetTaskFactory()->Alloc(stream_, TS_TASK_TYPE_MEMCPY, error);
    MemcpyAsyncTaskInitV1(task, nullptr, RT_MEMCPY_HOST_TO_DEVICE);
    task->u.memcpyAsyncTaskInfo.dmaKernelConvertFlag = true;

    ConstructPcieDmaSqe(task, &cmd);
    Complete(task, 0);
    rtError_t ret;
    ret = dev_->GetTaskFactory()->Recycle(task);
    EXPECT_EQ(ret, RT_ERROR_NONE);
}

TEST_F(StarsTaskTest, MemcpyAsyncTask_ConstructPcieDmaSqe_3)
{
    rtError_t error = RT_ERROR_NONE;
    rtStarsSqe_t cmd;
    uint64_t addr = static_cast<uint64_t>(reinterpret_cast<uintptr_t>(stream_->GetDvppRRTaskAddr()));

    TaskInfo *task = dev_->GetTaskFactory()->Alloc(stream_, TS_TASK_TYPE_MEMCPY, error);
    MemcpyAsyncD2HTaskInit(task, nullptr, 40U, 2U, 3U);
    task->u.memcpyAsyncTaskInfo.dmaKernelConvertFlag = false;
    task->u.memcpyAsyncTaskInfo.dsaSqeUpdateFlag = true;

    ConstructPcieDmaSqe(task, &cmd);
    Complete(task, 0);
    rtError_t ret;
    ret = dev_->GetTaskFactory()->Recycle(task);
    EXPECT_EQ(ret, RT_ERROR_NONE);
}

TEST_F(StarsTaskTest, stars_label_switch_by_index)
{
    rtStream_t stream = NULL;
    rtError_t error = rtStreamCreate(&stream, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);
    rtLabel_t label;
    rtModel_t model;
    error = rtModelCreate(&model, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = rtModelBindStream(model, stream, 0);
    EXPECT_NE(error, RT_ERROR_NONE);
    error = rtLabelCreateV2(&label, model);
    EXPECT_EQ(error, RT_ERROR_NONE);

    TaskInfo task = {};

    uint64_t  ptr = 0;
    uint32_t  max = 1;
    uint32_t  labelInfoPtr[16] = {0};
    rtStarsSqe_t sqe;
    InitByStream(&task, (Stream *)stream);
    error = StreamLabelSwitchByIndexTaskInit(&task, (void *)&ptr, max, (void *)labelInfoPtr);
    ToConstructSqe(&task, &sqe);
    error = rtLabelDestroy(label);
    EXPECT_EQ(error, RT_ERROR_NONE);
    TaskUnInitProc(&task);
    error = rtModelUnbindStream(model, stream);
    EXPECT_NE(error, RT_ERROR_NONE);
    ((Stream*)stream)->DelModel((Model*)model);
    error = rtStreamDestroy(stream);
    EXPECT_EQ(error, RT_ERROR_NONE);
    ((Model*)model)->ModelRemoveStream((Stream*)stream);
    error = rtModelDestroy(model);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(StarsTaskTest, stars_wait_env)
{
    TaskInfo task = {};
    TaskInfo waittask = {};
    rtError_t error;
    rtStream_t stream = NULL;
    Event evt;
    uint32_t event_id = 0;
    error = rtSetDevice(0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtStreamCreate(&stream, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    rtStarsSqe_t sqe;
    InitByStream(&task, (Stream *)stream);
    NotifyWaitTaskInit(&task, 0, 0, nullptr, nullptr, false);
    ToConstructSqe(&task, &sqe);

    InitByStream(&waittask, (Stream *)stream);
    EventWaitTaskInit(&waittask, &evt, event_id, 0, 0);
    ToConstructSqe(&waittask, &sqe);
    waittask.u.eventWaitTaskInfo.event->DeleteWaitFromMap(&waittask);

    rtStreamDestroy(stream);
    error = rtDeviceReset(0);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(StarsTaskTest, DsaErrorProc)
{
    cce::runtime::rtStarsCommonSqe_t sqe = {};
    rtStarsDsaSqe_t *dsaSqe = (rtStarsDsaSqe_t *)&sqe;
    dsaSqe->sqeHeader.type = RT_STARS_SQE_TYPE_DSA;
    dsaSqe->paramAddrValBitmap = 0x1f;
    TaskInfo task = {};
    InitByStream(&task, stream_);
    StarsCommonTaskInit(&task, sqe, 0U);
    EXPECT_EQ(task.type, TS_TASK_TYPE_STARS_COMMON);
    PrintErrorInfo(&task, dev_->Id_());
}

TEST_F(StarsTaskTest, DsaFftsplusErrorProc)
{
    rtFftsPlusTaskErrInfo_t errInfo = {};
    rtFftsPlusTaskInfo_t  fftsPlusTaskInfo = {};
    rtStarsDsaSqe_t *dsa_sqe = (rtStarsDsaSqe_t *)&errInfo.dsaSqe;
    dsa_sqe->sqeHeader.type = RT_STARS_SQE_TYPE_DSA;
    dsa_sqe->paramAddrValBitmap = 0x1f;
    TaskInfo task = {};

    MOCKER(FillFftsPlusSqe)
        .stubs()
        .will(returnValue(RT_ERROR_NONE));

    InitByStream(&task, stream_);
    FftsPlusTaskInit(&task, &fftsPlusTaskInfo, 0);
    EXPECT_EQ(task.type, TS_TASK_TYPE_FFTS_PLUS);
    PrintDsaErrorInfoForFftsPlusTask(&task, errInfo, dev_->Id_());
}

TEST_F(StarsTaskTest, FftsPlusTaskInitTest)
{
    rtError_t error;
    rtFftsPlusTaskErrInfo_t errInfo = {};
    rtFftsPlusTaskInfo_t  fftsPlusTaskInfo = {};
    rtStarsDsaSqe_t *dsa_sqe = (rtStarsDsaSqe_t *)&errInfo.dsaSqe;
    dsa_sqe->sqeHeader.type = RT_STARS_SQE_TYPE_DSA;
    dsa_sqe->paramAddrValBitmap = 0x1f;
    TaskInfo task = {};

    MOCKER(FillFftsPlusSqe)
        .stubs()
        .will(returnValue(RT_ERROR_NONE));

    InitByStream(&task, stream_);
    error = FftsPlusTaskInit(&task, &fftsPlusTaskInfo, 0);
    EXPECT_EQ(error, RT_ERROR_INVALID_VALUE);
    fftsPlusTaskInfo.descBufLen = PCIE_BAR_COPY_SIZE + 1;
    MOCKER_CPP_VIRTUAL(dev_->Driver_(), &Driver::DevMemAlloc).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL(dev_->Driver_(), &Driver::MemCopySync).stubs().will(returnValue(RT_ERROR_NONE));
    error = FftsPlusTaskInit(&task, &fftsPlusTaskInfo, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(StarsTaskTest, FillFftsPlusSqeTest)
{
    TaskInfo task = {};
    stream_->context_ = ctx_;
    InitByStream(&task, stream_);
    FftsPlusTaskInfo *fftsPlusTask = &task.u.fftsPlusTask;
    fftsPlusTask->fftsSqe.subType = RT_STARS_FFTSPLUS_HCCL_WITHOUT_AICAIV_FLAG;
    std::vector<cce::runtime::rtFftsPlusTaskErrInfo_t>* ss= new std::vector<rtFftsPlusTaskErrInfo_t>();
    fftsPlusTask->errInfo = ss;

    MOCKER_CPP_VIRTUAL(dev_, &Device::CheckFeatureSupport)
        .stubs()
        .will(returnValue(true));
    uint16_t timeout = 180;
    fftsPlusTask->fftsSqe.timeout = timeout;
    FillFftsPlusSqe(&task, NULL);
    EXPECT_EQ(fftsPlusTask->fftsSqe.timeout, timeout);

    // 0转换为1770
    timeout = 0U;
    fftsPlusTask->fftsSqe.timeout = timeout;
    FillFftsPlusSqe(&task, NULL);
    EXPECT_EQ(fftsPlusTask->fftsSqe.timeout, RT_STARS_DEFAULT_HCCL_FFTSPLUS_TIMEOUT);

    // 65535转换为0
    timeout = 65535U;
    fftsPlusTask->fftsSqe.timeout = timeout;
    FillFftsPlusSqe(&task, NULL);
    EXPECT_EQ(fftsPlusTask->fftsSqe.timeout, 0U);
    delete ss;
}

TEST_F(StarsTaskTest, StarsVersionTask)
{
    rtError_t ret;

    TaskInfo starsVersionTask = {};
    InitByStream(&starsVersionTask, stream_);
    ret = StarsVersionTaskInit(&starsVersionTask);
    starsVersionTask.type = TS_TASK_TYPE_GET_STARS_VERSION;
    EXPECT_EQ(ret, RT_ERROR_NONE);

    rtStarsSqe_t command = {};
    ToConstructSqe(&starsVersionTask, &command);

    RtStarsPhSqe *const sqe = &(command.phSqe);

    EXPECT_EQ(sqe->type, RT_STARS_SQE_TYPE_PLACE_HOLDER);
    EXPECT_EQ(sqe->pre_p, 1U);
    EXPECT_EQ(sqe->task_type, TS_TASK_TYPE_GET_STARS_VERSION);

    rtLogicCqReport_t logicCq = {0};
    logicCq.errorCode = 16;
    logicCq.sqeType = 3;

    SetStarsResultForStarsVersionTask(&starsVersionTask, logicCq);
    EXPECT_EQ(starsVersionTask.errorCode, 16);

    DoCompleteSuccessForStarsVersionTask(&starsVersionTask, 0);
}

TEST_F(StarsTaskTest, HCCLFftsPlusTaskInitTest)
{
    rtFftsPlusSqe_t fftsSqe = {{0}, 0};
    fftsSqe.subType = 90;
    fftsSqe.timeout = 151;
    void * descBuf = malloc(256);
    uint32_t descBufLen = 256;
    rtFftsPlusTaskInfo_t  fftsPlusTaskInfo = {&fftsSqe, descBuf, descBufLen, {NULL, NULL, 0, 0}};
    TaskInfo task = {};

    rtStream_t stm;
    Stream *stream = nullptr;
    dev_->SetTschVersion(((uint32_t)TS_BRANCH_TRUNK << 16) | TS_VERSION_FFTSPLUS_TIMEOUT);
    rtStreamCreate(&stm, 0);
    stream = static_cast<Stream *>(stm);

    InitByStream(&task, stream);

    MOCKER_CPP_VIRTUAL(dev_->Driver_(), &Driver::DevMemAlloc).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL(dev_->Driver_(), &Driver::MemCopySync).stubs().will(returnValue(RT_ERROR_NONE));
    std::vector<cce::runtime::rtFftsPlusTaskErrInfo_t>* ss= new std::vector<rtFftsPlusTaskErrInfo_t>();
    task.stream->SetBindFlag(false);
    task.u.fftsPlusTask.errInfo = ss;
    FftsPlusTaskInit(&task, &fftsPlusTaskInfo, 0);
    EXPECT_EQ(task.type, TS_TASK_TYPE_FFTS_PLUS);
    rtStreamDestroy(stm);
    dev_->SetTschVersion(0);
    free((void *)fftsPlusTaskInfo.descBuf);
    stream = nullptr;
    delete ss;
}
TEST_F(StarsTaskTest, HCCLFftsPlusTaskInitTest2)
{
    rtFftsPlusSqe_t fftsSqe = {{0}, 0};
    rtStarsSqe_t cmd;
    fftsSqe.subType = 90;
    void * descBuf = malloc(256);
    uint32_t descBufLen = 256;
    rtFftsPlusTaskInfo_t  fftsPlusTaskInfo = {&fftsSqe, descBuf, descBufLen, {NULL, NULL, 0, 0}};
    TaskInfo task = {};
    rtStream_t stm;
    Stream *stream = nullptr;
    dev_->SetTschVersion(((uint32_t)TS_BRANCH_TRUNK << 16) | TS_VERSION_FFTSPLUS_TASKID_SAME_FIX);
    rtStreamCreate(&stm, 0);
    stream = static_cast<Stream *>(stm);
    InitByStream(&task, stream);
    MOCKER_CPP_VIRTUAL(dev_->Driver_(), &Driver::DevMemAlloc).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL(dev_->Driver_(), &Driver::MemCopySync).stubs().will(returnValue(RT_ERROR_NONE));
    std::vector<cce::runtime::rtFftsPlusTaskErrInfo_t>* ss= new std::vector<rtFftsPlusTaskErrInfo_t>();
    task.u.fftsPlusTask.errInfo = ss;
    FftsPlusTaskInit(&task, &fftsPlusTaskInfo, 0);
    EXPECT_EQ(task.type, TS_TASK_TYPE_FFTS_PLUS);
    ToConstructSqe(&task, &cmd);
    stream->hcclIndex_ = 0xFFFFU;
    ToConstructSqe(&task, &cmd);
    MOCKER_CPP_VIRTUAL(dev_, &Device::AllocHcclIndex).stubs().will(returnValue(false));
    stream->hcclIndex_ = 0xFFFFU;
    ToConstructSqe(&task, &cmd);
    fftsSqe.subType = 0U;
    FftsPlusTaskInit(&task, &fftsPlusTaskInfo, 0);
    EXPECT_EQ(task.type, TS_TASK_TYPE_FFTS_PLUS);
    ToConstructSqe(&task, &cmd);
    stream->hcclIndex_ = 0x0U;
    rtStreamDestroy(stm);
    dev_->FreeHcclIndex(0);
    dev_->SetTschVersion(0);
    free((void *)fftsPlusTaskInfo.descBuf);
    stream = nullptr;
    delete ss;
}

TEST_F(StarsTaskTest, SameTaskIdForAll)
{
    rtFftsPlusSqe_t fftsSqe = {{0}, 0};
    rtStarsSqe_t cmd;
    fftsSqe.subType = 90;
    void * descBuf = malloc(256);
    uint32_t descBufLen = 256;
    rtFftsPlusTaskInfo_t  fftsPlusTaskInfo = {&fftsSqe, descBuf, descBufLen, {NULL, NULL, 0, 0}};
    TaskInfo task = {};
    rtStream_t stm;
    Stream *stream = nullptr;
    dev_->SetTschVersion(((uint32_t)TS_BRANCH_TRUNK << 16) | TS_VERSION_TASK_SAME_FOR_ALL);
    rtStreamCreate(&stm, 0);
    stream = static_cast<Stream *>(stm);
    InitByStream(&task, stream);
    MOCKER_CPP_VIRTUAL(dev_->Driver_(), &Driver::DevMemAlloc).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL(dev_->Driver_(), &Driver::MemCopySync).stubs().will(returnValue(RT_ERROR_NONE));
    std::vector<cce::runtime::rtFftsPlusTaskErrInfo_t>* ss= new std::vector<rtFftsPlusTaskErrInfo_t>();
    task.u.fftsPlusTask.errInfo = ss;
    FftsPlusTaskInit(&task, &fftsPlusTaskInfo, 0);
    EXPECT_EQ(task.type, TS_TASK_TYPE_FFTS_PLUS);
    ToConstructSqe(&task, &cmd);
    rtStreamDestroy(stm);
    dev_->SetTschVersion(0);
    free((void *)fftsPlusTaskInfo.descBuf);
    stream = nullptr;
    delete ss;
}

TEST_F(StarsTaskTest, TransExeTimeoutCfgToKernelCredit_Test)
{
    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    rtSocType_t socType = rtInstance->GetSocType();
    rtInstance->SetSocType(SOC_AS31XM1X);
    bool oldflag1 = rtInstance->timeoutConfig_.isCfgOpExcTaskTimeout;
    bool oldflag2 = rtInstance->timeoutConfig_.isCfgOpWaitTaskTimeout;
    rtInstance->timeoutConfig_.isCfgOpExcTaskTimeout = true;
    rtInstance->timeoutConfig_.opExcTaskTimeout = 10;
    GetAicoreKernelCredit(0);
    uint16_t kernelCredit = GetAicoreKernelCredit(UINT64_MAX); // never timeout
    EXPECT_EQ(kernelCredit, RT_STARS_NEVER_TIMEOUT_KERNEL_CREDIT);
    rtInstance->SetSocType(socType);
    rtInstance->timeoutConfig_.isCfgOpExcTaskTimeout = oldflag1;
    rtInstance->timeoutConfig_.isCfgOpWaitTaskTimeout = oldflag2;
}

TEST_F(StarsTaskTest, streamclear_ConstructSqe)
{
    rtError_t error = RT_ERROR_NONE;
    rtStarsSqe_t cmd;
    TaskInfo rtCommonCmdTask = {0};
    TaskInfo *task = dev_->GetTaskFactory()->Alloc(stream_, TS_TASK_TYPE_COMMON_CMD, error);
    CommonCmdTaskInfo cmdInfo;
    cmdInfo.streamId = 1;
    cmdInfo.step = RT_STREAM_STOP;
    CommonCmdTaskInit(task, CMD_STREAM_CLEAR, &cmdInfo);
    EXPECT_EQ(task->type, TS_TASK_TYPE_COMMON_CMD);
    ToConstructSqe(task, &cmd);
    Complete(task, 0);
    (void)dev_->GetTaskFactory()->Recycle(task);
}

TEST_F(StarsTaskTest, notifyreset_ConstructSqe)
{
    rtError_t error = RT_ERROR_NONE;
    rtStarsSqe_t cmd;
    TaskInfo rtCommonCmdTask = {0};
    TaskInfo *task = dev_->GetTaskFactory()->Alloc(stream_, TS_TASK_TYPE_COMMON_CMD, error);
    CommonCmdTaskInfo cmdInfo;
    cmdInfo.notifyId = 1;
    CommonCmdTaskInit(task, CMD_NOTIFY_RESET, &cmdInfo);
    EXPECT_EQ(task->type, TS_TASK_TYPE_COMMON_CMD);
    ToConstructSqe(task, &cmd);
    Complete(task, 0);
    (void)dev_->GetTaskFactory()->Recycle(task);
}

TEST_F(StarsTaskTest, hcclIndexAlloc)
{
    Device * device = new RawDevice(0);
    device->Init();
    uint16_t hcclIndex = UINT16_MAX;
    uint16_t stmid= 0;
    bool result;
    device->FreeHcclIndex(1);
    result = device->AllocHcclIndex(hcclIndex, stmid);
    EXPECT_EQ(result, true);
    EXPECT_EQ(hcclIndex, 0);
    result = device->AllocHcclIndex(hcclIndex, stmid + 1);
    EXPECT_EQ(result, true);
    EXPECT_EQ(hcclIndex, 1);
    result = device->AllocHcclIndex(hcclIndex, stmid + 2);
    EXPECT_EQ(result, true);
    EXPECT_EQ(hcclIndex, 2);
    result = device->AllocHcclIndex(hcclIndex, stmid + 3);
    EXPECT_EQ(result, true);
    EXPECT_EQ(hcclIndex, 3);
    result = device->AllocHcclIndex(hcclIndex, stmid + 4);
    EXPECT_EQ(result, true);
    EXPECT_EQ(hcclIndex, 4);
    result = device->AllocHcclIndex(hcclIndex, stmid + 5);
    EXPECT_EQ(result, true);
    EXPECT_EQ(hcclIndex, 5);
    result = device->AllocHcclIndex(hcclIndex, stmid + 6);
    EXPECT_EQ(result, true);
    EXPECT_EQ(hcclIndex, 6);
    result = device->AllocHcclIndex(hcclIndex, stmid + 7);
    EXPECT_EQ(result, true);
    EXPECT_EQ(hcclIndex, 7);
    result = device->AllocHcclIndex(hcclIndex, stmid + 8);
    EXPECT_EQ(result, false);
    device->FreeHcclIndex(stmid + 8);
    device->FreeHcclIndex(stmid + 7);
    device->FreeHcclIndex(stmid + 6);
    device->FreeHcclIndex(stmid + 5);
    device->FreeHcclIndex(stmid + 4);
    device->FreeHcclIndex(stmid + 3);
    device->FreeHcclIndex(stmid + 2);
    device->FreeHcclIndex(stmid + 1);
    device->PrintExceedLimitHcclStream();
    delete device;
}

TEST_F(StarsTaskTest, IsCapturedTask)
{
    rtError_t error = RT_ERROR_NONE;
    TaskInfo *task = dev_->GetTaskFactory()->Alloc(stream_, TS_TASK_TYPE_KERNEL_AICORE, error);
    EXPECT_EQ(IsCapturedTask(stream_, task), false);
    (void)dev_->GetTaskFactory()->Recycle(task);
}

TEST_F(StarsTaskTest, DoCompleteStarsModelExcuteError)
{
    Model *model;
    Stream *stream;

    rtError_t ret = rtStreamCreate((rtStream_t *)&stream, 0);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    ret = rtModelCreate((rtModel_t *)&model, 0);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    TaskInfo task = {};
    InitByStream(&task, stream);

    TaskInfo execTask = {};
    execTask.stream = stream;
    ModelExecuteTaskInit(&execTask, model, 0, 0);

    execTask.errorCode = TS_ERROR_AICORE_MTE_ERROR;
    execTask.mte_error = TS_ERROR_AICORE_MTE_ERROR;
    MOCKER(GetRealReportFaultTaskForModelExecuteTask)
        .stubs()
        .will(returnValue(&execTask));
    Complete(&execTask, 0);

    GlobalMockObject::verify();

    execTask.errorCode = TS_ERROR_AICORE_MTE_ERROR;
    execTask.mte_error = 0xFFFF;
    MOCKER(GetRealReportFaultTaskForModelExecuteTask)
        .stubs()
        .will(returnValue(&execTask));
    Complete(&execTask, 0);

    ret = rtStreamDestroy(stream);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    ret = rtModelDestroy(model);
    EXPECT_EQ(ret, RT_ERROR_NONE);
}

TEST_F(StarsTaskTest, DoCompleteStarsError_1)
{
    Runtime *rtInstance = (Runtime *)Runtime::Instance();

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
}

TEST_F(StarsTaskTest, SQE_SET_SchedMode)
{
    TaskInfo taskInfo{};
    AicTaskInfo aicTaskInfo;
    PlainProgram stubProg(Program::MACH_AI_CPU);
    Program *program = &stubProg;
    int32_t fun1;
    Kernel * k1 = new Kernel(&fun1, "f1", "", program, 10);

    k1->SetMixType(NO_MIX);

    taskInfo.u.aicTaskInfo = aicTaskInfo;
    taskInfo.u.aicTaskInfo.kernel = k1;
    taskInfo.type = TS_TASK_TYPE_KERNEL_AICORE;

    rtStarsSqe_t sqe;
    RtFftsPlusKernelSqe fftsPlusKernelSqe;
    sqe.fftsPlusKernelSqe = fftsPlusKernelSqe;

    rtStream_t stream = NULL;
    auto error = rtStreamCreate(&stream, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);
    taskInfo.stream = (Stream* )stream;

    // 优先级配置校验1
    taskInfo.u.aicTaskInfo.schemMode = RT_SCHEM_MODE_NORMAL;
    k1->SetSchedMode(RT_SCHEM_MODE_BATCH);
    ConstructAicAivSqeForDavinciTask(&taskInfo, &sqe);
    EXPECT_EQ(sqe.fftsPlusKernelSqe.schem, RT_SCHEM_MODE_NORMAL);

    // 优先级配置校验2
    taskInfo.u.aicTaskInfo.schemMode = RT_SCHEM_MODE_END;
    k1->SetSchedMode(RT_SCHEM_MODE_BATCH);
    ConstructAicAivSqeForDavinciTask(&taskInfo, &sqe);
    EXPECT_EQ(sqe.fftsPlusKernelSqe.schem, RT_SCHEM_MODE_BATCH);

    rtStreamDestroy(stream);
    delete k1;
}

TEST_F(StarsTaskTest, SchedMode_CheckBlockDim)
{
    TaskInfo taskInfo{};
    AicTaskInfo aicTaskInfo;
    PlainProgram stubProg(Program::MACH_AI_CPU);
    Program *program = &stubProg;
    int32_t fun1;
    Kernel * k1 = new Kernel(&fun1, "f1", "", program, 10);

    k1->SetMixType(NO_MIX);
    k1->SetSchedMode(RT_SCHEM_MODE_BATCH);

    taskInfo.u.aicTaskInfo = aicTaskInfo;
    taskInfo.u.aicTaskInfo.kernel = k1;
    taskInfo.type = TS_TASK_TYPE_KERNEL_AICORE;
    taskInfo.u.aicTaskInfo.schemMode = RT_SCHEM_MODE_END;
    
    rtStarsSqe_t sqe;
    RtFftsPlusKernelSqe fftsPlusKernelSqe;
    sqe.fftsPlusKernelSqe = fftsPlusKernelSqe;

    rtStream_t stream = NULL;
    auto error = rtStreamCreate(&stream, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);
    taskInfo.stream = (Stream* )stream;

    // blockDim校验
    taskInfo.u.aicTaskInfo.comm.dim = 10;
    ConstructAicAivSqeForDavinciTask(&taskInfo, &sqe);

    // sqeType
    taskInfo.u.aicTaskInfo.machine = 2;
    ConstructAicAivSqeForDavinciTask(&taskInfo, &sqe);

    taskInfo.u.aicTaskInfo.machine = 3;
    ConstructAicAivSqeForDavinciTask(&taskInfo, &sqe);

    taskInfo.u.aicTaskInfo.machine = 4;
    ConstructAicAivSqeForDavinciTask(&taskInfo, &sqe);

    rtFftsPlusMixAicAivCtx_t fftsCtx;
    fftsCtx.contextType = RT_CTX_TYPE_MIX_AIC;
    uint32_t minStackSize = 0;
    taskInfo.u.aicTaskInfo.kernel->SetMixType(MIX_AIC);
    FillFftsAicAivCtxForDavinciTask(&taskInfo, &fftsCtx, minStackSize);

    taskInfo.u.aicTaskInfo.kernel->SetMixType(MIX_AIV);
    FillFftsAicAivCtxForDavinciTask(&taskInfo, &fftsCtx, minStackSize);

    taskInfo.u.aicTaskInfo.kernel->SetMixType(NO_MIX);
    FillFftsAicAivCtxForDavinciTask(&taskInfo, &fftsCtx, minStackSize);

    rtCommand_t command{};

    taskInfo.type = TS_TASK_TYPE_KERNEL_AICORE;
    ToCommandBodyForAicAivTask(&taskInfo, &command);

    taskInfo.type = TS_TASK_TYPE_KERNEL_AIVEC;
    ToCommandBodyForAicAivTask(&taskInfo, &command);

    taskInfo.type = TS_TASK_TYPE_KERNEL_MIX_AIC;
    ToCommandBodyForAicAivTask(&taskInfo, &command);

    rtStreamDestroy(stream);
    delete k1;
}