/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include <dlfcn.h>
#include <vector>
#include "core/aicpusd_resource_manager.h"
#include "core/aicpusd_drv_manager.h"
#include "gtest/gtest.h"
#include "mockcpp/mockcpp.hpp"
#include "ascend_hal.h"
#include "aicpusd_info.h"
#include "aicpusd_interface.h"
#include "aicpusd_status.h"
#include "aicpusd_util.h"
#include "aicpu_sched/common/aicpu_task_struct.h"
#define private public
#include "aicpusd_interface_process.h"
#include "task_queue.h"
#include "dump_task.h"
#include "aicpu_sharder.h"
#include "aicpusd_threads_process.h"
#include "aicpusd_task_queue.h"
#include "tdt_server.h"
#include "aicpusd_event_process.h"
#include "aicpusd_msg_send.h"
#include "aicpusd_model_execute.h"
#undef private

using namespace AicpuSchedule;
using namespace aicpu;

class AicpuEventProcessTEST : public testing::Test {
protected:
    static void SetUpTestCase() {
        std::cout << "AicpuEventProcessTEST SetUpTestCase" << std::endl;
    }

    static void TearDownTestCase() {
        std::cout << "AicpuEventProcessTEST TearDownTestCase" << std::endl;
    }

    virtual void SetUp()
    {
        std::cout << "AicpuEventProcessTEST SetUP" << std::endl;
    }

    virtual void TearDown()
    {
        GlobalMockObject::verify();
        std::cout << "AicpuEventProcessTEST TearDown" << std::endl;
    }
};

aicpu::status_t GetAicpuThreadRunMode(aicpu::AicpuRunMode &runMode)
{
    runMode = aicpu::AicpuRunMode::THREAD_MODE;
    return aicpu::AICPU_ERROR_NONE;
}

aicpu::status_t GetAicpuPcieRunMode(aicpu::AicpuRunMode &runMode)
{
    runMode = aicpu::AicpuRunMode::PROCESS_PCIE_MODE;
    return aicpu::AICPU_ERROR_NONE;
}

TEST_F(AicpuEventProcessTEST, InitQueueFlag) {
    AicpuEventProcess::GetInstance().InitQueueFlag();
    EXPECT_EQ(AicpuEventProcess::GetInstance().exitQueueFlag_, true);
}

TEST_F(AicpuEventProcessTEST, ProcessTaskReportEvent_failed1) {
    TsToAicpuTaskReport info;
    info.model_id = 1;

    AicpuModel *model = nullptr;
    MOCKER_CPP(&AicpuModelManager::GetModel)
        .stubs()
        .will(returnValue(model));
    TsAicpuSqe sqe{};
    sqe.u.ts_to_aicpu_task_report.model_id = info.model_id;
    AicpuSqeAdapter ada(sqe, 0U);
    int ret = AicpuEventProcess::GetInstance().ProcessTaskReportEvent(ada);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_MODEL_NOT_FOUND);
}

TEST_F(AicpuEventProcessTEST, ProcessTaskReportEvent_failed2) {
    TsToAicpuTaskReport info;
    info.model_id = 1;

    AicpuModel *model = new AicpuModel();
    MOCKER_CPP(&AicpuModelManager::GetModel)
        .stubs()
        .will(returnValue(model));
    TsAicpuSqe sqe{};
    sqe.u.ts_to_aicpu_task_report.model_id = info.model_id;
    AicpuSqeAdapter ada(sqe, 0U);
    int ret = AicpuEventProcess::GetInstance().ProcessTaskReportEvent(ada);

    delete model;
    model = nullptr;
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_MODEL_STATUS_NOT_ALLOW_OPERATE);
}

TEST_F(AicpuEventProcessTEST, ProcessTaskReportEvent_failed3) {
    TsToAicpuTaskReport info;
    info.model_id = 1;

    AicpuModel *model = new AicpuModel();
    MOCKER_CPP(&AicpuModelManager::GetModel)
        .stubs()
        .will(returnValue(model));
    AicpuEventProcess::GetInstance().exitQueueFlag_ = false;
    TsAicpuSqe sqe{};
    sqe.u.ts_to_aicpu_task_report.model_id = info.model_id;
    AicpuSqeAdapter ada(sqe, 0U);
    int ret = AicpuEventProcess::GetInstance().ProcessTaskReportEvent(ada);

    delete model;
    model = nullptr;
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_MODEL_STATUS_NOT_ALLOW_OPERATE);
}

TEST_F(AicpuEventProcessTEST, ProcessTaskReportEvent_failed4) {
    TsToAicpuTaskReport info;
    info.model_id = 1;
    info.result_code = 0x91;
    AicpuModel *model = new AicpuModel();
    MOCKER_CPP(&AicpuModelManager::GetModel)
        .stubs()
        .will(returnValue(model));
    TsAicpuSqe sqe{};
    sqe.u.ts_to_aicpu_task_report.model_id = info.model_id;
    sqe.u.ts_to_aicpu_task_report.result_code = info.result_code;
    AicpuSqeAdapter ada(sqe, 0U);
    int ret = AicpuEventProcess::GetInstance().ProcessTaskReportEvent(ada);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_MODEL_STATUS_NOT_ALLOW_OPERATE);

    delete model;
    model = nullptr;
}

TEST_F(AicpuEventProcessTEST, ProcessTaskReportEvent_failed6) {
    TsToAicpuTaskReport info;
    info.model_id = 1;

    AicpuModel *model = new AicpuModel();
    MOCKER_CPP(&AicpuModelManager::GetModel)
        .stubs()
        .will(returnValue(model));
    AicpuEventProcess::GetInstance().exitQueueFlag_ = true;
    MOCKER_CPP(&AicpuModel::ModelAbort)
        .stubs()
        .will(returnValue(0));
    TsAicpuSqe sqe{};
    sqe.u.ts_to_aicpu_task_report.model_id = info.model_id;
    AicpuSqeAdapter ada(sqe, 0U);
    int ret = AicpuEventProcess::GetInstance().ProcessTaskReportEvent(ada);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
    delete model;
    model = nullptr;
}

TEST_F(AicpuEventProcessTEST, ProcessTaskReportEvent_failed5) {
    TsToAicpuTaskReport info;
    info.model_id = 1;
    info.result_code = 0x90;
    AicpuModel *model = new AicpuModel();
    MOCKER_CPP(&AicpuModelManager::GetModel)
        .stubs()
        .will(returnValue(model));
    TsAicpuSqe sqe{};
    sqe.u.ts_to_aicpu_task_report.model_id = info.model_id;
    sqe.u.ts_to_aicpu_task_report.result_code = info.result_code;
    AicpuSqeAdapter ada(sqe, 0U);
    int ret = AicpuEventProcess::GetInstance().ProcessTaskReportEvent(ada);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_MODEL_STATUS_NOT_ALLOW_OPERATE);

    delete model;
    model = nullptr;
}

TEST_F(AicpuEventProcessTEST, ProcessQueueNotEmptyEvent_success) {
    uint32_t queueId = 1;
    int ret = AicpuEventProcess::GetInstance().ProcessQueueNotEmptyEvent(queueId);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
}

TEST_F(AicpuEventProcessTEST, ProcessQueueNotFullEvent_success) {
    uint32_t queueId = 1;
    int ret = AicpuEventProcess::GetInstance().ProcessQueueNotFullEvent(queueId);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
}

TEST_F(AicpuEventProcessTEST, CheckCustAicpuKernel_failed1) {
    MOCKER(aicpu::GetAicpuRunMode).stubs().will(returnValue(1));
    auto ret = AicpuUtil::CheckCustAicpuThreadMode();
    EXPECT_NE(ret, AICPU_SCHEDULE_OK);
}

TEST_F(AicpuEventProcessTEST, CheckCustAicpuKernel_failed2) {
    MOCKER(aicpu::GetAicpuRunMode).stubs().will(invoke(GetAicpuPcieRunMode));
    auto ret = AicpuUtil::CheckCustAicpuThreadMode();
    EXPECT_NE(ret, AICPU_SCHEDULE_OK);
}

TEST_F(AicpuEventProcessTEST, CheckCustAicpuKernel_success) {
    MOCKER(aicpu::GetAicpuRunMode).stubs().will(invoke(GetAicpuThreadRunMode));
    auto ret = AicpuUtil::CheckCustAicpuThreadMode();
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
}

TEST_F(AicpuEventProcessTEST, AICPUEventPrepareMem) {
    AicpuModel aicpuModel;
    MOCKER_CPP(&AicpuModelManager::GetModel).stubs().will(returnValue(&aicpuModel));
    MOCKER_CPP(&AicpuModel::RecoverStream).stubs().will(returnValue(AICPU_SCHEDULE_OK));

    bool needWait = false;
    EventWaitManager::PrepareMemWaitManager().WaitEvent(0, 0, needWait);
    AICPUSubEventInfo event;
    auto ret = AicpuEventProcess::GetInstance().AICPUEventPrepareMem(event);
    EXPECT_EQ(ret, static_cast<int32_t>(AICPU_SCHEDULE_OK));
}

TEST_F(AicpuEventProcessTEST, AICPUEventTableUnlock_success) {
    AicpuModel aicpuModel;
    aicpuModel.modelId_ = 0U;
    std::vector<AicpuModel*> aicpuModels = {&aicpuModel};
    MOCKER_CPP(&AicpuModelManager::GetModelsByTableId).stubs().will(returnValue(aicpuModels));
    MOCKER_CPP(&AicpuModel::RecoverStream).stubs().will(returnValue(AICPU_SCHEDULE_OK));

    bool needWait = false;
    EventWaitManager::TableUnlockWaitManager().WaitEvent(0, 0, needWait);
    AICPUSubEventInfo subEventInfo = {};
    auto ret = AicpuEventProcess::GetInstance().AICPUEventTableUnlock(subEventInfo);
    EXPECT_EQ(ret, static_cast<int32_t>(AICPU_SCHEDULE_OK));
}

TEST_F(AicpuEventProcessTEST, AICPUEventSupplyEnque_success) {
    AicpuModel aicpuModel;
    aicpuModel.modelId_ = 0U;
    aicpuModel.gatheredMbuf_[0U][0U].Init(1U);
    MOCKER_CPP(&AicpuModelManager::GetModel).stubs().will(returnValue(&aicpuModel));
    MOCKER_CPP(&AicpuModel::RecoverStream).stubs().will(returnValue(AICPU_SCHEDULE_OK));

    bool needWait = false;
    EventWaitManager::AnyQueNotEmptyWaitManager().WaitEvent(0, 0, needWait);
    AICPUSubEventInfo subEventInfo = {};
    auto ret = AicpuEventProcess::GetInstance().AICPUEventSupplyEnque(subEventInfo);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
    EventWaitManager::AnyQueNotEmptyWaitManager().ClearBatch({0});
}

TEST_F(AicpuEventProcessTEST, AICPUEventSupplyEnque_fail_noWait) {
    AicpuModel aicpuModel;
    aicpuModel.modelId_ = 0U;
    aicpuModel.gatheredMbuf_[0U][0U].Init(1U);
    MOCKER_CPP(&AicpuModelManager::GetModel).stubs().will(returnValue(&aicpuModel));
    AICPUSubEventInfo subEventInfo = {};
    auto ret = AicpuEventProcess::GetInstance().AICPUEventSupplyEnque(subEventInfo);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
    EventWaitManager::AnyQueNotEmptyWaitManager().ClearBatch({0});
}

TEST_F(AicpuEventProcessTEST, AICPUEventSupplyEnque_fail_GetModel) {
    AicpuModel *aicpuModel = nullptr;
    MOCKER_CPP(&AicpuModelManager::GetModel).stubs().will(returnValue(aicpuModel));

    AICPUSubEventInfo subEventInfo = {};
    auto ret = AicpuEventProcess::GetInstance().AICPUEventSupplyEnque(subEventInfo);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_STREAM_NOT_FOUND);
    EventWaitManager::AnyQueNotEmptyWaitManager().ClearBatch({0});
}

TEST_F(AicpuEventProcessTEST, AICPUEventSupplyEnque_fail_RecoverStream) {
    AicpuModel aicpuModel;
    aicpuModel.modelId_ = 0U;
    aicpuModel.gatheredMbuf_[0U][0U].Init(1U);
    MOCKER_CPP(&AicpuModelManager::GetModel).stubs().will(returnValue(&aicpuModel));
    MOCKER_CPP(&AicpuModel::RecoverStream).stubs().will(returnValue(AICPU_SCHEDULE_ERROR_STREAM_NOT_FOUND));

    bool needWait = false;
    EventWaitManager::AnyQueNotEmptyWaitManager().WaitEvent(0, 0, needWait);
    AICPUSubEventInfo subEventInfo = {};
    auto ret = AicpuEventProcess::GetInstance().AICPUEventSupplyEnque(subEventInfo);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_STREAM_NOT_FOUND);
    EventWaitManager::AnyQueNotEmptyWaitManager().ClearBatch({0});
}

TEST_F(AicpuEventProcessTEST, SendLoadPlatformFromBufMsgRsp_01) {
    TsAicpuSqe ctrlMsg = {};
    MOCKER(tsDevSendMsgAsync).stubs().will(returnValue(0));
    AicpuSqeAdapter adapter(ctrlMsg, 0U);
    auto ret = AicpuEventProcess::GetInstance().SendLoadPlatformFromBufMsgRsp(123, adapter);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
    GlobalMockObject::verify();
}

TEST_F(AicpuEventProcessTEST, SendLoadPlatformFromBufMsgRsp_02) {
    TsAicpuSqe ctrlMsg = {};
    MOCKER(tsDevSendMsgAsync).stubs().will(returnValue(1));
    AicpuSqeAdapter adapter(ctrlMsg, 0U);
    auto ret = AicpuEventProcess::GetInstance().SendLoadPlatformFromBufMsgRsp(123, adapter);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_INNER_ERROR);
    GlobalMockObject::verify();
}

TEST_F(AicpuEventProcessTEST, ProcessLoadPlatformFromBuf) {
    TsAicpuSqe ctrlMsg = {};
    AicpuSqeAdapter adapter(ctrlMsg, 0U);
    auto ret = AicpuEventProcess::GetInstance().ProcessLoadPlatformFromBuf(adapter);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID);
}

TEST_F(AicpuEventProcessTEST, GetAicpuExtendSoPlatformFuncPtr) {
    auto ret = AicpuEventProcess::GetInstance().GetAicpuExtendSoPlatformFuncPtr();
    EXPECT_EQ(ret, nullptr);
}

int32_t FakePlatformKernels(uint64_t addr, uint32_t infolen)
{
    if (infolen == 0U) {
        return 1;
    }
    return 0;
}

TEST_F(AicpuEventProcessTEST, GetAicpuExtendSoPlatformFuncPtr_01) {
    AicpuEventProcess::GetInstance().platformFuncPtr_ = FakePlatformKernels;
    auto ret = AicpuEventProcess::GetInstance().GetAicpuExtendSoPlatformFuncPtr();
    EXPECT_EQ(ret, FakePlatformKernels);
}

void *dlsymStubPlatformKernels(void *const soHandle, const char_t * const funcName)
{
    std::cout << "enter dlsymStub" << std::endl;
    return (reinterpret_cast<void *>(FakePlatformKernels));
}

TEST_F(AicpuEventProcessTEST, ProcessLoadPlatformFromBuf_01) {
    AicpuEventProcess::GetInstance().platformFuncPtr_ = FakePlatformKernels;
    MOCKER(tsDevSendMsgAsync).stubs().will(returnValue(0));
    TsAicpuSqe ctrlMsg = {};
    ctrlMsg.u.ts_to_aicpu_info.length = 0U;
    AicpuSqeAdapter adapter1(ctrlMsg, 0U);
    auto ret = AicpuEventProcess::GetInstance().ProcessLoadPlatformFromBuf(adapter1);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
    ctrlMsg.u.ts_to_aicpu_info.length = 10U;
    AicpuSqeAdapter adapter2(ctrlMsg, 0U);
    ret = AicpuEventProcess::GetInstance().ProcessLoadPlatformFromBuf(adapter2);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
}

TEST_F(AicpuEventProcessTEST, AICPUEventRepeatModelNoModel)
{
    MOCKER_CPP(&AicpuModelManager::GetModel).stubs().will(returnValue((AicpuModel*)nullptr));
    AICPUSubEventInfo event;
    int ret = AicpuEventProcess::GetInstance().AICPUEventRepeatModel(event);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_MODEL_NOT_FOUND);
}

TEST_F(AicpuEventProcessTEST, AICPUEventRecoveryStreamNoModel)
{
    MOCKER_CPP(&AicpuModelManager::GetModel).stubs().will(returnValue((AicpuModel*)nullptr));
    AICPUSubEventInfo event;
    AICPUSubEventStreamInfo streamInfo;
    streamInfo.streamId = 0;
    event.para.streamInfo = streamInfo;
    int ret = AicpuEventProcess::GetInstance().AICPUEventRecoveryStream(event);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_MODEL_NOT_FOUND);
}

TEST_F(AicpuEventProcessTEST, ProcessEndGraphAbort)
{
    AicpuModel aicpuModel;
    aicpuModel.abnormalEnabled_ = false;
    AICPUSubEventInfo info = {};
    info.para.endGraphInfo.result = 1U;
    MOCKER_CPP(&AicpuModelManager::GetModel).stubs().will(returnValue(&aicpuModel));
    MOCKER_CPP(&AicpuModel::EndGraph).stubs().will(returnValue(0));
    int modelId = 1;
    int ret = AicpuEventProcess::GetInstance().AICPUEventEndGraph(info);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_MODEL_STATUS_NOT_ALLOW_OPERATE);
}

TEST_F(AicpuEventProcessTEST, ProcessEndGraph)
{
    AicpuModel aicpuModel;
    aicpuModel.abnormalEnabled_ = true;
    AICPUSubEventInfo info = {};
    info.para.endGraphInfo.result = 1U;
    MOCKER_CPP(&AicpuModelManager::GetModel).stubs().will(returnValue(&aicpuModel));
    MOCKER_CPP(&AicpuModel::EndGraph).stubs().will(returnValue(0));
    int modelId = 1;
    int ret = AicpuEventProcess::GetInstance().AICPUEventEndGraph(info);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
    EXPECT_EQ(aicpuModel.GetModelRetCode(), 1);
}

TEST_F(AicpuEventProcessTEST, ProcessEndGraphHasWait)
{
    AicpuModel aicpuModel;
    aicpuModel.abnormalEnabled_ = true;
    AICPUSubEventInfo info = {};
    info.modelId = 1U;
    info.para.endGraphInfo.result = 1U;
    MOCKER_CPP(&AicpuModelManager::GetModel).stubs().will(returnValue(&aicpuModel));
    MOCKER_CPP(&AicpuModel::EndGraph).stubs().will(returnValue(0));
    uint32_t waitStreamId = 11;
    bool hasWait = false;
    EventWaitManager::EndGraphWaitManager().WaitEvent(static_cast<size_t>(info.modelId), waitStreamId, hasWait);
    MOCKER_CPP(&AicpuMsgSend::SendAICPUSubEvent).stubs().will(returnValue(0));
    int ret = AicpuEventProcess::GetInstance().AICPUEventEndGraph(info);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
    EXPECT_EQ(aicpuModel.GetModelRetCode(), 1);
}

TEST_F(AicpuEventProcessTEST, AICPUEventPrepareMemNoModel) {
    MOCKER_CPP(&AicpuModelManager::GetModel).stubs().will(returnValue((AicpuModel*)nullptr));
    MOCKER_CPP(&AicpuModel::RecoverStream).stubs().will(returnValue(AICPU_SCHEDULE_OK));

    AICPUSubEventInfo event;
    event.modelId = 111;
    bool needWait = true;
    EventWaitManager::PrepareMemWaitManager().WaitEvent(event.modelId, 0, needWait);
    
    auto ret = AicpuEventProcess::GetInstance().AICPUEventPrepareMem(event);
    EXPECT_EQ(ret, static_cast<int32_t>(AICPU_SCHEDULE_ERROR_MODEL_NOT_FOUND));
}

TEST_F(AicpuEventProcessTEST, AICPUEventPrepareMemRecoverFail) {
    AicpuModel model;
    MOCKER_CPP(&AicpuModelManager::GetModel).stubs().will(returnValue(&model));
    MOCKER_CPP(&AicpuModel::RecoverStream).stubs().will(returnValue(AICPU_SCHEDULE_ERROR_INNER_ERROR));

    AICPUSubEventInfo event;
    event.modelId = 112;
    bool needWait = true;
    EventWaitManager::PrepareMemWaitManager().WaitEvent(event.modelId, 0, needWait);
    
    auto ret = AicpuEventProcess::GetInstance().AICPUEventPrepareMem(event);
    EXPECT_EQ(ret, static_cast<int32_t>(AICPU_SCHEDULE_ERROR_INNER_ERROR));
}

TEST_F(AicpuEventProcessTEST, AICPUEventSupplyEnqueNoModel) {
    AicpuModel aicpuModel;
    aicpuModel.modelId_ = 0U;
    MOCKER_CPP(&AicpuModelManager::GetModel).stubs().will(returnValue(&aicpuModel));
    MOCKER_CPP(&AicpuModel::RecoverStream).stubs().will(returnValue(AICPU_SCHEDULE_OK));

    bool needWait = false;
    EventWaitManager::AnyQueNotEmptyWaitManager().WaitEvent(0, 0, needWait);
    AICPUSubEventInfo subEventInfo = {};
    auto ret = AicpuEventProcess::GetInstance().AICPUEventSupplyEnque(subEventInfo);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
    EventWaitManager::AnyQueNotEmptyWaitManager().ClearBatch({0});
}