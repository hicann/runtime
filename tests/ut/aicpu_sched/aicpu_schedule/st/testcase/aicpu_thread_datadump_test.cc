/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "datadump/datadump_interface.h"
#include "ascend_hal.h"
#include "gtest/gtest.h"

#include <dlfcn.h>
#include <iostream>
#include <memory>
#include <map>
#include <thread>
#include <sys/types.h>
#include <sys/file.h>
#include <sys/ioctl.h>
#include <sstream>
#include <dlfcn.h>
#include "gtest/gtest.h"
#include "mockcpp/mockcpp.hpp"
#define private public
#include "aicpusd_info.h"
#include "aicpusd_interface.h"
#include "aicpusd_status.h"
#include "aicpusd_model_execute.h"
#include "task_queue.h"
#include "tdt_server.h"
#include "adump/ide_daemon_api.h"
#include "aicpu_task_struct.h"
#include "ascend_hal.h"
#include "aicpu_context.h"
#include "aicpusd_worker.h"
#include "aicpu_event_struct.h"
#include "aicpu_pulse.h"
#include "aicpusd_cust_so_manager.h"
#include "profiling_adp.h"
#include "aicpusd_resource_manager.h"
#include "aicpusd_monitor.h"
#include "aicpusd_interface_process.h"
#include "aicpusd_event_process.h"
#include "aicpusd_event_manager.h"
#include "aicpusd_drv_manager.h"
#include "aicpusd_threads_process.h"
#include "aicpusd_queue_event_process.h"
#include "aicpu_sharder.h"
#include "dump_task.h"
#include "aicpusd_task_queue.h"
#include "aicpu_engine.h"
#include "aicpusd_so_manager.h"
#include "aicpusd_cust_dump_process.h"
#undef private
using namespace AicpuSchedule;
using namespace aicpu;

class AiCPUThreadDatadumpSt : public ::testing::Test {
public:
    virtual void SetUp()
    {}

    virtual void TearDown()
    {
        GlobalMockObject::verify();
    }
};

TEST_F(AiCPUThreadDatadumpSt, DatadumpInitAICPUDatadumpStSuccess)
{
    MOCKER_CPP(&ThreadPool::CreateOneWorker)
        .stubs()
        .will(returnValue(0));
    MOCKER(sem_init)
        .stubs()
        .will(returnValue(0));
    MOCKER(sem_wait)
        .stubs()
        .will(returnValue(0));
    MOCKER(sem_destroy)
        .stubs()
        .will(returnValue(0));
    MOCKER(signal)
        .stubs()
        .will(returnValue(sighandler_t(1)));
    MOCKER_CPP(&ThreadPool::PostSem)
        .stubs();
    MOCKER_CPP(&AicpuEventManager::LoopProcess)
        .stubs()
        .will(returnValue(0));
    MOCKER(halEschedWaitEvent)
    .stubs()
    .will(returnValue(DRV_ERROR_SCHED_PROCESS_EXIT));
    StopAICPUDatadump(0, 0);
    InitAICPUDatadump(0, 0);
    int32_t ret =StopAICPUDatadump(0, 0);
    EXPECT_EQ(ret, 0);
}

TEST_F(AiCPUThreadDatadumpSt, InitAICPUDatadumpStSuccess) {

    aicpu::dump::OpMappingInfo opMappingInfo;
    const uint32_t taskId = 3333;
    const uint32_t streamId = 3;
    const uint32_t contextid = 1;
    const uint32_t threadid = 2;
    const uint32_t modelId = 33;
    const int32_t dataType = 3;
    uint64_t stepId = 1;
    uint64_t iterationsPerLoop = 1;
    uint64_t loopCond = 1;
    opMappingInfo.set_step_id_addr(reinterpret_cast<uint64_t>(&stepId));
    opMappingInfo.set_iterations_per_loop_addr(reinterpret_cast<uint64_t>(&iterationsPerLoop));
    opMappingInfo.set_loop_cond_addr(reinterpret_cast<uint64_t>(&loopCond));
    opMappingInfo.set_dump_path("dump_path");
    opMappingInfo.set_model_name("model_debug");
    opMappingInfo.set_model_id(modelId);

    opMappingInfo.set_flag(0x01);
    aicpu::dump::Task *task = opMappingInfo.add_task();
    task->set_task_id(taskId);
    task->set_stream_id(streamId);
    task->set_context_id(INVALID_VAL);
    task->set_tasktype(aicpu::dump::Task::DEBUG);

    aicpu::dump::Op *op = task->mutable_op();
    op->set_op_name("op_debug");
    op->set_op_type("op_debug");

    aicpu::dump::Output *output = task->add_output();
    output->set_data_type(dataType);
    output->set_format(1);
    aicpu::dump::Shape *shape = output->mutable_shape();
    shape->add_dim(2);
    shape->add_dim(2);
    int32_t data[4] = {1, 2, 3, 4};
    int *p = &data[0];
    output->set_address(reinterpret_cast<uint64_t>(&p));
    output->set_original_name("original_name");
    output->set_original_output_index(11);
    output->set_original_output_data_type(dataType);
    output->set_original_output_format(1);
    output->set_size(sizeof(data));

    aicpu::dump::OpBuffer *opBuffer = task->add_buffer();
    opBuffer->set_buffer_type(aicpu::dump::BufferType::L1);
    opBuffer->set_address(uint64_t(p));
    opBuffer->set_size(sizeof(data));

    aicpu::dump::Input *input = task->add_input();
    input->set_data_type(dataType);
    input->set_format(1);
    aicpu::dump::Shape *inShape = input->mutable_shape();
    inShape->add_dim(2);
    inShape->add_dim(2);
    int32_t inData[4] = {10, 20, 30, 40};
    int32_t *q = &inData[0];
    input->set_address(reinterpret_cast<uint64_t>(&q));
    input->set_size(sizeof(inData));

    std::string opMappingInfoStr;
    opMappingInfo.SerializeToString(&opMappingInfoStr);
    OpDumpTaskManager &opDumpTaskMgr = OpDumpTaskManager::GetInstance();
    // load op mapping info
    EXPECT_EQ(opDumpTaskMgr.LoadOpMappingInfo(opMappingInfoStr.c_str(), opMappingInfoStr.length()), AICPU_SCHEDULE_OK);


    TaskInfoExt dumpTaskInfo(streamId, taskId);
    EXPECT_EQ(opDumpTaskMgr.DumpOpInfo(dumpTaskInfo, streamId, taskId, contextid, threadid), AICPU_SCHEDULE_OK);

    MOCKER_CPP(&OpDumpTask::IsEndGraph).stubs().will(returnValue(true));
    EXPECT_EQ(opDumpTaskMgr.DumpOpInfo(dumpTaskInfo, streamId, taskId, contextid, threadid), AICPU_SCHEDULE_OK);
    MOCKER_CPP(&OpDumpTask::GetModelId).stubs().will(returnValue(false));
    EXPECT_EQ(opDumpTaskMgr.DumpOpInfo(dumpTaskInfo, streamId, taskId, contextid, threadid), AICPU_SCHEDULE_OK);
    std::string opMappingInfoStr1 = "1234";
    EXPECT_EQ(opDumpTaskMgr.LoadOpMappingInfo(opMappingInfoStr1.c_str(), opMappingInfoStr1.length()), AICPU_SCHEDULE_ERROR_DUMP_FAILED);
    opMappingInfo.set_flag(0x02);
    opMappingInfo.SerializeToString(&opMappingInfoStr);
    EXPECT_EQ(opDumpTaskMgr.LoadOpMappingInfo(opMappingInfoStr.c_str(), opMappingInfoStr.length()), AICPU_SCHEDULE_ERROR_DUMP_FAILED);

    // unload model
    opMappingInfo.set_flag(0x00);
    opMappingInfo.SerializeToString(&opMappingInfoStr);
    EXPECT_EQ(opDumpTaskMgr.LoadOpMappingInfo(opMappingInfoStr.c_str(), opMappingInfoStr.length()), AICPU_SCHEDULE_OK);
    opMappingInfo.set_model_id(3);
    opMappingInfo.SerializeToString(&opMappingInfoStr);
    opDumpTaskMgr.modelIdToTask_.clear();
    EXPECT_EQ(opDumpTaskMgr.LoadOpMappingInfo(opMappingInfoStr.c_str(), opMappingInfoStr.length()), AICPU_SCHEDULE_OK);
}

struct event_info g_event1 = {
    .comm = {
        .event_id = EVENT_ID(1),
        .subevent_id = 2,
        .pid = 3,
        .host_pid = 4,
        .grp_id = 5,
        .submit_timestamp = 6,
        .sched_timestamp = 7
    },
    .priv = {
        .msg_len = EVENT_MAX_MSG_LEN,
        .msg = {0}
    }
};

TEST_F(AiCPUThreadDatadumpSt, DoOnceTest11) {
    MOCKER(halEschedWaitEvent)
        .stubs()
        .will(returnValue(DRV_ERROR_SCHED_PARA_ERR));
    AicpuEventManager::GetInstance().DoOnce(0, 0);
    event_info eventInfo = g_event1;
    AicpuEventManager::GetInstance().ProcTsCtrlEvent(eventInfo, 0);
    int32_t ret = AicpuEventManager::GetInstance().ProcessEvent(eventInfo, 0);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_NOT_FOUND_EVENT);
}

TEST_F(AiCPUThreadDatadumpSt, DoOnceTest12) {
    MOCKER(halEschedWaitEvent)
        .stubs()
        .will(returnValue(DRV_ERROR_SCHED_RUN_IN_ILLEGAL_CPU));
    int32_t ret = AicpuEventManager::GetInstance().DoOnce(0, 0);
    EXPECT_EQ(ret, DRV_ERROR_SCHED_RUN_IN_ILLEGAL_CPU);
}

TEST_F(AiCPUThreadDatadumpSt, adapterVersion) {
    TsAicpuSqe sqe{};
    TsAicpuMsgInfo msgInfo{};
    AicpuSqeAdapter ada0(sqe, 0U);
    AicpuSqeAdapter ada1(msgInfo, 1U);
    AicpuSqeAdapter ada3(msgInfo, 3U);
    MOCKER_CPP(tsDevSendMsgAsync)
        .stubs()
        .will(returnValue(0));
    MOCKER_CPP(halEschedAckEvent)
        .stubs()
        .will(returnValue(0));
    AicpuSqeAdapter::AicpuOpMappingDumpTaskInfo taskInfo(0, 0, 0, 0);
    ada1.IsOpMappingDumpTaskInfoVaild(taskInfo);
    ada1.AicpuMsgVersionResponseToTs(0U);

    AicpuSqeAdapter::AicpuModelOperateInfo operInfo{};
    ada0.GetAicpuModelOperateInfo(operInfo);
    ada1.GetAicpuModelOperateInfo(operInfo);
    ada3.GetAicpuModelOperateInfo(operInfo);

    int32_t ret = 0;
    ret = ada0.AicpuModelOperateResponseToTs(0U, 0U);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
    ret = ada1.AicpuModelOperateResponseToTs(0U, 0U);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
    ret = ada3.AicpuModelOperateResponseToTs(0U, 0U);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_NOT_FOUND_FUNCTION);

    AicpuSqeAdapter::AicpuTaskReportInfo reportInfo{};
    ada1.GetAicpuTaskReportInfo(reportInfo);
    ada3.GetAicpuTaskReportInfo(reportInfo);

    AicpuSqeAdapter::AicpuOpMappingDumpTaskInfo mappingTaskInfo(0, 0, 0, 0);
    AicpuSqeAdapter::AicpuDumpTaskInfo dumpTaskInfo{};
    ada1.GetAicpuDumpTaskInfo(mappingTaskInfo, dumpTaskInfo);
    ada3.GetAicpuDumpTaskInfo(mappingTaskInfo, dumpTaskInfo);

    AicpuSqeAdapter::AicpuDataDumpInfo dataDumpInfo;
    TsAicpuMsgInfo msgInfo1{};
    msgInfo1.cmd_type = TS_AICPU_DEBUG_DATADUMP_REPORT;
    AicpuSqeAdapter ada4(msgInfo1, 1U);
    ada4.GetAicpuDataDumpInfo(dataDumpInfo);
    TsAicpuMsgInfo msgInfo2{};
    msgInfo2.cmd_type = TS_AICPU_NORMAL_DATADUMP_REPORT;
    AicpuSqeAdapter ada5(msgInfo2, 1U);
    ada5.GetAicpuDataDumpInfo(dataDumpInfo);
    ada3.GetAicpuDataDumpInfo(dataDumpInfo);
    TsAicpuMsgInfo msgInfo3{};
    msgInfo3.cmd_type = TS_INVALID_AICPU_CMD;
    AicpuSqeAdapter ada6(msgInfo3, 1U);
    ada6.GetAicpuDataDumpInfo(dataDumpInfo);

    ret = ada3.AicpuDumpResponseToTs(0U);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_NOT_FOUND_FUNCTION);
    ret = ada4.AicpuDumpResponseToTs(0U);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
    ret = ada5.AicpuDumpResponseToTs(0U);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
    ret = ada6.AicpuDumpResponseToTs(0U);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_INNER_ERROR);

    AicpuSqeAdapter::AicpuDataDumpInfoLoad dumpInfoLoad;
    ada1.GetAicpuDataDumpInfoLoad(dumpInfoLoad);
    ada3.GetAicpuDataDumpInfoLoad(dumpInfoLoad);

    ret = ada1.AicpuDataDumpLoadResponseToTs(0U);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
    ret = ada3.AicpuDataDumpLoadResponseToTs(0U);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_NOT_FOUND_FUNCTION);

    AicpuSqeAdapter::AicpuTimeOutConfigInfo  timeOutConfigInfo;
    ada1.GetAicpuTimeOutConfigInfo(timeOutConfigInfo);

    AicpuSqeAdapter::AicpuInfoLoad infoLoad;
    ada1.GetAicpuInfoLoad(infoLoad);
    ada3.GetAicpuInfoLoad(infoLoad);

    AicpuSqeAdapter::ErrMsgRspInfo rspInfo(0, 0, 0, 0, 0, 0);
    ret = ada1.ErrorMsgResponseToTs(rspInfo);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
    ret = ada3.ErrorMsgResponseToTs(rspInfo);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_NOT_FOUND_FUNCTION);

    AicpuSqeAdapter::ActiveStreamInfo activeStreamInfo(0, 0, 0, 0, 0);
    ada1.AicpuActiveStreamSetMsg(activeStreamInfo);
    ada3.AicpuActiveStreamSetMsg(activeStreamInfo);

    AicpuSqeAdapter::AicpuRecordInfo recordInfo(0, 0, 0, 0, 0, 0, 0);
    MOCKER_CPP(halTsDevRecord)
        .stubs()
        .will(returnValue(1));
    ret = ada0.AicpuRecordResponseToTs(recordInfo);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_FROM_DRV);
    ret = ada3.AicpuRecordResponseToTs(recordInfo);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_NOT_FOUND_FUNCTION);
    ret = ada1.AicpuRecordResponseToTs(recordInfo);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);


    ret = ada3.AicpuTimeOutConfigResponseToTs(0);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_NOT_FOUND_FUNCTION);
    ret = ada1.AicpuTimeOutConfigResponseToTs(0);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);

    ret = ada3.AicpuInfoLoadResponseToTs(0);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_NOT_FOUND_FUNCTION);
    ret = ada1.AicpuInfoLoadResponseToTs(0);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);

    AicpuSqeAdapter::AicErrReportInfo  aicErrorMsgInfo;
    aicErrorMsgInfo.u.aicErrorMsg.aic_bitmap_num = 1;
    aicErrorMsgInfo.u.aicErrorMsg.aiv_bitmap_num = 1;
    ada1.GetAicErrReportInfo(aicErrorMsgInfo);

    AicpuSqeAdapter::AicErrReportInfo  aicErrorInfo;
    ada0.GetAicErrReportInfo(aicErrorInfo);
}

TEST_F(AiCPUThreadDatadumpSt, 1ProcessHWTSControlEventTest) {
    event_info eventInfo = g_event1;
    eventInfo.priv.msg_len = sizeof(TsAicpuSqe);
    TsAicpuSqe *ctrlMsg = reinterpret_cast<TsAicpuSqe *>(eventInfo.priv.msg);
    ctrlMsg->cmd_type = AIC_TASK_REPORT;
    int ret = 0;
    ctrlMsg->cmd_type = AICPU_DATADUMP_REPORT;
    ret = AicpuEventManager::GetInstance().ProcessHWTSControlEvent(eventInfo);
    ctrlMsg->cmd_type = AICPU_DATADUMP_LOADINFO;
    ret = AicpuEventManager::GetInstance().ProcessHWTSControlEvent(eventInfo);
    ctrlMsg->cmd_type = AICPU_FFTS_PLUS_DATADUMP_REPORT;
    ret = AicpuEventManager::GetInstance().ProcessHWTSControlEvent(eventInfo);
    ctrlMsg->cmd_type = 20;
    ret = AicpuEventManager::GetInstance().ProcessHWTSControlEvent(eventInfo);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_NOT_FOUND_EVENT);
}

TEST_F(AiCPUThreadDatadumpSt, AddPidToTask_Success1)
{
    MOCKER_CPP(&FeatureCtrl::IsBindPidByHal).stubs().will(returnValue(true));
    MOCKER(&halBindCgroup).stubs().will(returnValue(0));
    ThreadPool tp;
    tp.threadStatusList_ = std::move(std::vector<ThreadStatus>(1, ThreadStatus::THREAD_INIT));
    EXPECT_EQ(tp.AddPidToTask(0), AICPU_SCHEDULE_OK);
}
TEST_F(AiCPUThreadDatadumpSt, WorkTest_Fail1) {
    MOCKER(halEschedSubscribeEvent)
        .stubs()
        .will(returnValue(1));
    MOCKER_CPP(&ThreadPool::PostSem)
        .stubs();
    ThreadPool tp;
    const AicpuSchedMode schedMode = SCHED_MODE_INTERRUPT;
    tp.Work(0, 0, schedMode);
    EXPECT_EQ(AicpuSchedule::AicpuEventManager::GetInstance().runningFlag_, false);
}

TEST_F(AiCPUThreadDatadumpSt, AicpuScheduleInterface_InitAICPUScheduler_Fail2) {

    MOCKER(halEschedDettachDevice)
        .stubs()
        .will(returnValue(DRV_ERROR_NONE));
    std::vector<uint32_t> deviceVec;
    deviceVec.push_back(1);
    int32_t ret = AicpuScheduleInterface::GetInstance().DettachDeviceInDestroy(deviceVec);
    EXPECT_EQ(ret, DRV_ERROR_NONE);
}

TEST_F(AiCPUThreadDatadumpSt, AicpuScheduleInterface_InitAICPUScheduler_Fail1) {

    MOCKER(halEschedDettachDevice)
        .stubs()
        .will(returnValue(DRV_ERROR_NO_DEVICE));
    std::vector<uint32_t> deviceVec;
    deviceVec.clear();
    deviceVec.push_back(1);
    int32_t ret = AicpuScheduleInterface::GetInstance().DettachDeviceInDestroy(deviceVec);
    EXPECT_EQ(ret, DRV_ERROR_NO_DEVICE);
}


TEST_F(AiCPUThreadDatadumpSt, WriteTidForAffinityTest11) {
    const size_t threadIndex = 1;
    const size_t aicpuNum = 3;
    ThreadPool::Instance().threadStatusList_ = std::move(std::vector<ThreadStatus>(aicpuNum, ThreadStatus::THREAD_INIT));
    MOCKER(vfork).stubs().will(returnValue(1));
    MOCKER(waitpid).stubs().will(returnValue(0));
    int32_t ret = ThreadPool::Instance().WriteTidForAffinity(threadIndex);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
}

TEST_F(AiCPUThreadDatadumpSt, WriteTidForAffinityTest12) {
    const size_t threadIndex = 100;
    const size_t aicpuNum = 3;
    ThreadPool::Instance().threadStatusList_ = std::move(std::vector<ThreadStatus>(aicpuNum, ThreadStatus::THREAD_INIT));
    MOCKER(vfork).stubs().will(returnValue(1));
    MOCKER(waitpid).stubs().will(returnValue(0));
    int32_t ret = ThreadPool::Instance().WriteTidForAffinity(threadIndex);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_INIT_FAILED);
}
struct event_info g_event27 = {
    .comm = {
        .event_id = 27,
        .subevent_id = 2,
        .pid = 3,
        .host_pid = 4,
        .grp_id = 5,
        .submit_timestamp = 6,
        .sched_timestamp = 7
    },
    .priv = {
        .msg_len = EVENT_MAX_MSG_LEN,
        .msg = {0}
    }
};
TEST_F(AiCPUThreadDatadumpSt, DoOnceTestSt_Cpu_Illegal_get_event) {
    MOCKER(halEschedWaitEvent)
    .stubs()
    .will(returnValue(DRV_ERROR_SCHED_RUN_IN_ILLEGAL_CPU));
    event_info eventInfo = g_event27;
    AicpuEventManager::GetInstance().ProcTsCtrlEvent(eventInfo, 0);
    AicpuEventManager::GetInstance().ProcessEvent(eventInfo, 0);
    int32_t ret = AicpuEventManager::GetInstance().DoOnce(0, 0);
    EXPECT_EQ(ret, DRV_ERROR_SCHED_RUN_IN_ILLEGAL_CPU);
}

TEST_F(AiCPUThreadDatadumpSt, DoOnceTestSt_Unknown_event_type) {
    MOCKER(halEschedWaitEvent)
        .stubs()
        .will(returnValue(80));
    event_info eventInfo = g_event27;
    AicpuEventManager::GetInstance().ProcTsCtrlEvent(eventInfo, 0);
    AicpuEventManager::GetInstance().ProcessEvent(eventInfo, 0);
    int32_t ret = AicpuEventManager::GetInstance().DoOnce(0, 0);
    EXPECT_EQ(ret, 80);
}

TEST_F(AiCPUThreadDatadumpSt, ProcessHWTSControlEventTestSt_fail) {
    MOCKER(tsDevSendMsgAsync)
    .stubs()
    .will(returnValue(80));
    event_info eventInfo = g_event1;
    eventInfo.priv.msg_len = sizeof(TsAicpuSqe);
    TsAicpuSqe *ctrlMsg = reinterpret_cast<TsAicpuSqe *>(eventInfo.priv.msg);
    ctrlMsg->cmd_type = AIC_TASK_REPORT;
    int ret = 0;
    ctrlMsg->cmd_type = AICPU_DATADUMP_REPORT;
    ret = AicpuEventManager::GetInstance().ProcessHWTSControlEvent(eventInfo);
    ctrlMsg->cmd_type = AICPU_DATADUMP_LOADINFO;
    ret = AicpuEventManager::GetInstance().ProcessHWTSControlEvent(eventInfo);
    ctrlMsg->cmd_type = AICPU_FFTS_PLUS_DATADUMP_REPORT;
    ret = AicpuEventManager::GetInstance().ProcessHWTSControlEvent(eventInfo);
    ctrlMsg->cmd_type = 20;
    ret = AicpuEventManager::GetInstance().ProcessHWTSControlEvent(eventInfo);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_NOT_FOUND_EVENT);
}

TEST_F(AiCPUThreadDatadumpSt, GetCurrentRunMode_St_Error) {
    bool isOnline = true;
    auto ret = AicpuScheduleInterface::GetInstance().GetCurrentRunMode(isOnline);
    EXPECT_NE(ret, AICPU_SCHEDULE_OK);
}

TEST_F(AiCPUThreadDatadumpSt, InitAICPUSchedulerTest_St_SUCCESS) {

    MOCKER_CPP(&ThreadPool::CreateWorker)
        .stubs()
        .will(returnValue(0));

    std::string ch = "000000000000000000000000000000000000000000000000";

    MOCKER_CPP(&AicpuDrvManager::CheckBindHostPid)
        .stubs()
        .will(returnValue(0));
    std::vector<uint32_t> deviceVec;
    int ret = 0;
    AicpuScheduleInterface::GetInstance().initFlag_ = true;
    ret = AicpuScheduleInterface::GetInstance().InitAICPUScheduler(deviceVec, 0, ch, (ProfilingMode)0, 0, true, SCHED_MODE_INTERRUPT);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);

    AicpuScheduleInterface::GetInstance().initFlag_ = false;
    ret = AicpuScheduleInterface::GetInstance().InitAICPUScheduler(deviceVec, 0, ch, (ProfilingMode)0, 0, true, SCHED_MODE_INTERRUPT);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_DRV_ERR);

    deviceVec.push_back(0);
    ret = AicpuScheduleInterface::GetInstance().InitAICPUScheduler(deviceVec, 0, ch, (ProfilingMode)0, 1, true, SCHED_MODE_INTERRUPT);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_INIT_CP_FAILED);

    ret = AicpuScheduleInterface::GetInstance().InitAICPUScheduler(deviceVec, 0, ch, (ProfilingMode)0, 0, false, SCHED_MODE_INTERRUPT);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);

    AicpuScheduleInterface::GetInstance().initFlag_ = false;
    MOCKER_CPP(&AicpuDrvManager::CheckBindHostPid)
        .stubs()
        .will(returnValue(-1));
    ret = AicpuScheduleInterface::GetInstance().InitAICPUScheduler(deviceVec, 0, ch, (ProfilingMode)0, 0, false, SCHED_MODE_INTERRUPT);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);

    MOCKER_CPP(&AicpuDrvManager::InitDrvSchedModule)
        .stubs()
        .will(returnValue(1));
    AicpuScheduleInterface::GetInstance().initFlag_ = false;
    ret = AicpuScheduleInterface::GetInstance().InitAICPUScheduler(deviceVec, 0, ch, (ProfilingMode)0, 0, false, SCHED_MODE_INTERRUPT);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_DRV_ERR); 

    MOCKER_CPP(&AicpuScheduleInterface::BindHostPid)
        .stubs()
        .will(returnValue(1));
    AicpuScheduleInterface::GetInstance().initFlag_ = false;
    ret = AicpuScheduleInterface::GetInstance().InitAICPUScheduler(deviceVec, 0, ch, (ProfilingMode)0, 0, false, SCHED_MODE_INTERRUPT);
    EXPECT_EQ(ret, 1); 

    MOCKER_CPP(&GetAicpuDeployContext)
        .stubs()
        .will(returnValue(1));
    AicpuScheduleInterface::GetInstance().initFlag_ = false;
    ret = AicpuScheduleInterface::GetInstance().InitAICPUScheduler(deviceVec, 0, ch, (ProfilingMode)0, 0, false, SCHED_MODE_INTERRUPT);
    EXPECT_EQ(ret, 1);

    MOCKER_CPP(&AicpuDrvManager::InitDrvMgr)
        .stubs()
        .will(returnValue(1));
    AicpuScheduleInterface::GetInstance().initFlag_ = false;
    ret = AicpuScheduleInterface::GetInstance().InitAICPUScheduler(deviceVec, 0, ch, (ProfilingMode)0, 0, false, SCHED_MODE_INTERRUPT);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_DRV_ERR);
 
    AicpuScheduleInterface::GetInstance().initFlag_ = true;
    ret = AicpuScheduleInterface::GetInstance().InitAICPUScheduler(deviceVec, 0, ch, (ProfilingMode)0, 0, true, SCHED_MODE_INTERRUPT);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
}

TEST_F(AiCPUThreadDatadumpSt, CreateOneWorkTest_St) {
    ThreadPool tp;
    MOCKER(sem_init)
        .stubs()
        .will(returnValue(0));
    MOCKER(sem_wait)
        .stubs()
        .will(returnValue(0));
    MOCKER(sem_destroy)
        .stubs()
        .will(returnValue(0));
    MOCKER(signal)
        .stubs()
        .will(returnValue(sighandler_t(1)));
    MOCKER_CPP(&ThreadPool::PostSem)
        .stubs();

    std::vector<uint32_t> deviceId;
    deviceId.push_back(0);
    AicpuDrvManager::GetInstance().InitDrvMgr(deviceId, 0, 0, true);
    const AicpuSchedMode schedMode = SCHED_MODE_INTERRUPT;
    tp.CreateWorker(schedMode);
    MOCKER_CPP(&AicpuDrvManager::GetAicpuNum).stubs().will(returnValue((uint32_t)0));
    int ret = tp.CreateWorker(schedMode);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
}

TEST_F(AiCPUThreadDatadumpSt, AddPidToTask_St_Fail)
{
    AicpuEventManager::GetInstance().runningFlag_ = false;
    AicpuEventManager::GetInstance().LoopProcess(0);
    MOCKER_CPP(&FeatureCtrl::IsBindPidByHal).stubs().will(returnValue(true));
    MOCKER(&halBindCgroup).stubs().will(returnValue(1));
    ThreadPool tp;
    tp.threadStatusList_ = std::move(std::vector<ThreadStatus>(1, ThreadStatus::THREAD_INIT));
    EXPECT_EQ(tp.AddPidToTask(0), AICPU_SCHEDULE_ERROR_FROM_DRV);
}

TEST_F(AiCPUThreadDatadumpSt, CreateOneWorkTest_Ut1) {
    ThreadPool tp;
    MOCKER(sem_init)
        .stubs()
        .will(returnValue(0));
    MOCKER(sem_wait)
        .stubs()
        .will(returnValue(-1));
    MOCKER(sem_destroy)
        .stubs()
        .will(returnValue(0));
    MOCKER(signal)
        .stubs()
        .will(returnValue(sighandler_t(1)));
    MOCKER_CPP(&ThreadPool::PostSem)
        .stubs();

    std::vector<uint32_t> deviceId;
    deviceId.push_back(0);
    const auto ret = AicpuDrvManager::GetInstance().InitDrvMgr(deviceId, 0, 0, true);
    const AicpuSchedMode schedMode = SCHED_MODE_INTERRUPT;
    tp.CreateWorker(schedMode);
    MOCKER_CPP(&ThreadPool::CreateOneWorker)
        .stubs()
        .will(returnValue(1));
    tp.CreateWorker(schedMode);
    EXPECT_EQ(ret , 0);
}

TEST_F(AiCPUThreadDatadumpSt, CreateOneWorkTest_Ut2) {
    ThreadPool tp;
    MOCKER(sem_init)
        .stubs()
        .will(returnValue(-1));
    MOCKER(sem_wait)
        .stubs()
        .will(returnValue(-1));
    MOCKER(sem_destroy)
        .stubs()
        .will(returnValue(0));
    MOCKER(signal)
        .stubs()
        .will(returnValue(sighandler_t(1)));
    MOCKER_CPP(&ThreadPool::PostSem)
        .stubs();

    std::vector<uint32_t> deviceId;
    deviceId.push_back(0);
    int32_t ret = AicpuDrvManager::GetInstance().InitDrvMgr(deviceId, 0, 0, true);
    const AicpuSchedMode schedMode = SCHED_MODE_INTERRUPT;
    tp.CreateWorker(schedMode);
    EXPECT_EQ(ret , 0);
}

TEST_F(AiCPUThreadDatadumpSt, WorkTest_Fail2) {
    MOCKER(halEschedSubscribeEvent)
        .stubs()
        .will(returnValue(1));
    MOCKER_CPP(&ThreadPool::PostSem)
        .stubs();
    ThreadPool tp;
    const AicpuSchedMode schedMode = SCHED_MODE_INTERRUPT;
    tp.Work(0, 0, schedMode);
    MOCKER_CPP(&GetAicpuDeployContext)
    .stubs()
    .will(returnValue(1));
    tp.Work(0, 0, schedMode);
    GlobalMockObject::verify();
    MOCKER_CPP(&GetAicpuDeployContext)
    .stubs()
    .will(returnValue(0));
    MOCKER_CPP(&ThreadPool::SetAffinity)
        .stubs()
        .will(returnValue(1));
    tp.Work(0, 0, schedMode);
    GlobalMockObject::verify();
    MOCKER_CPP(&GetAicpuDeployContext)
    .stubs()
    .will(returnValue(0));
    MOCKER_CPP(&ThreadPool::SetAffinity)
        .stubs()
        .will(returnValue(0));
    tp.Work(0, 0, schedMode);
    GlobalMockObject::verify();
    MOCKER(aicpu::aicpuSetContext)
        .stubs()
        .will(returnValue(1));
    tp.Work(0, 0, schedMode);
    EXPECT_EQ(AicpuSchedule::AicpuEventManager::GetInstance().runningFlag_, false);
}
template<typename T, typename... Args>
std::shared_ptr<T> make_shared_throw_bad_alloc(Args&&... args) {
    throw std::bad_alloc();
    // return std::shared_ptr<T>(new T(std::forward<Args>(args)...));
    return std::shared_ptr<T>(nullptr);
}

TEST_F(AiCPUThreadDatadumpSt, WorkTest_CreateKfcDumpInfoSt) {
    int32_t ret = 0;
    MOCKER_CPP(&std::make_shared<KfcDumpInfo>).stubs().will(invoke(make_shared_throw_bad_alloc<KfcDumpInfo>));
    OpDumpTaskManager &opDumpTaskMgr = OpDumpTaskManager::GetInstance();
    std::shared_ptr<KfcDumpInfo> kfcDumpInfoPtr1 = nullptr;
    ret = opDumpTaskMgr.CreateKfcDumpInfo(kfcDumpInfoPtr1);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_DUMP_FAILED);
    EXPECT_EQ(kfcDumpInfoPtr1, nullptr);
}

template<typename T, typename... Args>
std::shared_ptr<T> make_shared_throw_bad_alloc1(Args&&... args) {
    throw std::bad_alloc();
    // return std::shared_ptr<T>(new T(std::forward<Args>(args)...));
    return std::shared_ptr<T>(nullptr);
}

TEST_F(AiCPUThreadDatadumpSt, WorkTest_CreateOpDumpTaskSt) {
    int32_t ret = 0;
    const int32_t hostPid = 1;
    const uint32_t deviceId = 1;

    OpDumpTaskManager &opDumpTaskMgr = OpDumpTaskManager::GetInstance();
    std::shared_ptr<OpDumpTask> OpDumpTaskPtr1 = nullptr;
    ret = opDumpTaskMgr.CreateOpDumpTask(OpDumpTaskPtr1, hostPid, deviceId);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
}
TEST_F(AiCPUThreadDatadumpSt, InitAICPUDatadumpSt_CreateOpDumpTask_failed) {
    const uint32_t taskId = 3333;
    const uint32_t streamId = 3;
    const uint32_t contextid = 1;
    const uint32_t threadid = 2;
    const uint32_t modelId = 33;
    const int32_t dataType = 3;
    uint64_t stepId = 1;
    uint64_t iterationsPerLoop = 1;
    uint64_t loopCond = 1;
    std::string opMappingInfoStr1;
    std::string opMappingInfoStr2;
    {
        aicpu::dump::OpMappingInfo opMappingInfo;
        opMappingInfo.set_step_id_addr(reinterpret_cast<uint64_t>(&stepId));
        opMappingInfo.set_iterations_per_loop_addr(reinterpret_cast<uint64_t>(&iterationsPerLoop));
        opMappingInfo.set_loop_cond_addr(reinterpret_cast<uint64_t>(&loopCond));
        opMappingInfo.set_dump_path("dump_path");
        opMappingInfo.set_model_name("model_debug");
        opMappingInfo.set_model_id(modelId);
        opMappingInfo.set_flag(0x01);

        aicpu::dump::Task *task = opMappingInfo.add_task();
        task->set_task_id(taskId);
        task->set_stream_id(streamId);
        task->set_context_id(INVALID_VAL);
        task->set_tasktype(aicpu::dump::Task::FFTSPLUS);
        task->add_context();
        opMappingInfo.SerializeToString(&opMappingInfoStr1);
    }
    {
        aicpu::dump::OpMappingInfo opMappingInfo;
        opMappingInfo.set_step_id_addr(reinterpret_cast<uint64_t>(&stepId));
        opMappingInfo.set_iterations_per_loop_addr(reinterpret_cast<uint64_t>(&iterationsPerLoop));
        opMappingInfo.set_loop_cond_addr(reinterpret_cast<uint64_t>(&loopCond));
        opMappingInfo.set_dump_path("dump_path");
        opMappingInfo.set_model_name("model_debug");
        opMappingInfo.set_model_id(modelId);
        opMappingInfo.set_flag(0x01);
 
        aicpu::dump::Task *task = opMappingInfo.add_task();
        task->set_task_id(taskId);
        task->set_stream_id(streamId);
        task->set_context_id(INVALID_VAL);
        task->set_tasktype(aicpu::dump::Task::DEBUG);
        task->add_context();
        opMappingInfo.SerializeToString(&opMappingInfoStr2);
    }

    OpDumpTaskManager &opDumpTaskMgr = OpDumpTaskManager::GetInstance();
    // load op mapping info
    MOCKER_CPP(&OpDumpTask::PreProcessOpMappingInfo).stubs().will(returnValue(AICPU_SCHEDULE_ERROR_DUMP_FAILED));
    EXPECT_EQ(opDumpTaskMgr.LoadOpMappingInfo(opMappingInfoStr1.c_str(), opMappingInfoStr1.length()), AICPU_SCHEDULE_ERROR_DUMP_FAILED);
    EXPECT_EQ(opDumpTaskMgr.LoadOpMappingInfo(opMappingInfoStr2.c_str(), opMappingInfoStr2.length()), AICPU_SCHEDULE_ERROR_DUMP_FAILED);

    MOCKER_CPP(&OpDumpTaskManager::CreateOpDumpTask).stubs().will(returnValue(AICPU_SCHEDULE_ERROR_DUMP_FAILED));
    EXPECT_EQ(opDumpTaskMgr.LoadOpMappingInfo(opMappingInfoStr1.c_str(), opMappingInfoStr1.length()), AICPU_SCHEDULE_ERROR_DUMP_FAILED);
    EXPECT_EQ(opDumpTaskMgr.LoadOpMappingInfo(opMappingInfoStr2.c_str(), opMappingInfoStr2.length()), AICPU_SCHEDULE_ERROR_DUMP_FAILED);
}

TEST_F(AiCPUThreadDatadumpSt, InitAICPUDatadumpSt_CreateOpDumpTask_failed1) {
    const uint32_t taskId = 3333;
    const uint32_t streamId = 3;
    const uint32_t contextid = 1;
    const uint32_t threadid = 2;
    const uint32_t modelId = 33;
    const int32_t dataType = 3;
    uint64_t stepId = 1;
    uint64_t iterationsPerLoop = 1;
    uint64_t loopCond = 1;
    std::string opMappingInfoStr1;
    std::string opMappingInfoStr2;
    {
        aicpu::dump::OpMappingInfo opMappingInfo;
        opMappingInfo.set_step_id_addr(reinterpret_cast<uint64_t>(&stepId));
        opMappingInfo.set_iterations_per_loop_addr(reinterpret_cast<uint64_t>(&iterationsPerLoop));
        opMappingInfo.set_loop_cond_addr(reinterpret_cast<uint64_t>(&loopCond));
        opMappingInfo.set_dump_path("dump_path");
        opMappingInfo.set_model_name("model_debug");
        opMappingInfo.set_model_id(modelId);
        opMappingInfo.set_flag(0x01);

        aicpu::dump::Task *task = opMappingInfo.add_task();
        task->set_task_id(taskId);
        task->set_stream_id(streamId);
        task->set_context_id(INVALID_VAL);
        task->set_tasktype(aicpu::dump::Task::FFTSPLUS);
        task->add_context();
        opMappingInfo.SerializeToString(&opMappingInfoStr1);
    }
    {
        aicpu::dump::OpMappingInfo opMappingInfo;
        opMappingInfo.set_step_id_addr(reinterpret_cast<uint64_t>(&stepId));
        opMappingInfo.set_iterations_per_loop_addr(reinterpret_cast<uint64_t>(&iterationsPerLoop));
        opMappingInfo.set_loop_cond_addr(reinterpret_cast<uint64_t>(&loopCond));
        opMappingInfo.set_dump_path("dump_path");
        opMappingInfo.set_model_name("model_debug");
        opMappingInfo.set_model_id(modelId);
        opMappingInfo.set_flag(0x01);

        aicpu::dump::Task *task = opMappingInfo.add_task();
        task->set_task_id(taskId);
        task->set_stream_id(streamId);
        task->set_context_id(INVALID_VAL);
        task->set_tasktype(aicpu::dump::Task::DEBUG);
        task->add_context();
        opMappingInfo.SerializeToString(&opMappingInfoStr2);
    }

    OpDumpTaskManager &opDumpTaskMgr = OpDumpTaskManager::GetInstance();
    // load op mapping info
    MOCKER_CPP(&OpDumpTask::PreProcessOpMappingInfo).stubs().will(returnValue(AICPU_SCHEDULE_ERROR_DUMP_FAILED));
    EXPECT_EQ(opDumpTaskMgr.LoadOpMappingInfo(opMappingInfoStr1.c_str(), opMappingInfoStr1.length()), AICPU_SCHEDULE_ERROR_DUMP_FAILED);
    EXPECT_EQ(opDumpTaskMgr.LoadOpMappingInfo(opMappingInfoStr2.c_str(), opMappingInfoStr2.length()), AICPU_SCHEDULE_ERROR_DUMP_FAILED);

    MOCKER_CPP(&OpDumpTaskManager::CreateOpDumpTask).stubs().will(returnValue(0));
    EXPECT_EQ(opDumpTaskMgr.LoadOpMappingInfo(opMappingInfoStr1.c_str(), opMappingInfoStr1.length()), AICPU_SCHEDULE_ERROR_DUMP_FAILED);
    EXPECT_EQ(opDumpTaskMgr.LoadOpMappingInfo(opMappingInfoStr2.c_str(), opMappingInfoStr2.length()), AICPU_SCHEDULE_ERROR_DUMP_FAILED);
    MOCKER_CPP(&OpDumpTaskManager::GetDumpStepFromString).stubs().will(returnValue(false));
    EXPECT_EQ(opDumpTaskMgr.LoadOpMappingInfo(opMappingInfoStr2.c_str(), opMappingInfoStr2.length()), AICPU_SCHEDULE_ERROR_DUMP_FAILED);
}

TEST_F(AiCPUThreadDatadumpSt, WorkTest_MatchAndInsertSt_failed) {
    bool ret;
    OpDumpTaskManager &opDumpTaskMgr = OpDumpTaskManager::GetInstance();
    const std::string step = "1+1+2";
    DumpStep tmpDumpStep = {};
    ret = opDumpTaskMgr.MatchAndInsert(step, tmpDumpStep);
    EXPECT_EQ(ret, false);
}

bool MatchAndInsert_stub(const std::string &step, DumpStep &tmpDumpStep) {
    throw std::bad_alloc();
    return true;
}

TEST_F(AiCPUThreadDatadumpSt, WorkTest_GetDumpStepFromStringSt_failed) {
    bool ret;
    OpDumpTaskManager &opDumpTaskMgr = OpDumpTaskManager::GetInstance();
    const std::string step = "1+1+2";
    DumpStep tmpDumpStep = {};
    MOCKER_CPP(&OpDumpTaskManager::MatchAndInsert).stubs().will(returnValue(false));
    ret = opDumpTaskMgr.GetDumpStepFromString(step, tmpDumpStep);
    EXPECT_EQ(ret, false);
    GlobalMockObject::verify();
    MOCKER_CPP(&OpDumpTaskManager::MatchAndInsert).stubs().will(invoke(MatchAndInsert_stub));
    ret = opDumpTaskMgr.GetDumpStepFromString(step, tmpDumpStep);
    EXPECT_EQ(ret, false);
    KfcDumpTask KfcTaskinfo;
    KfcTaskinfo.streamId_ = 0;
    KfcTaskinfo.taskId_ = 0;
    KfcTaskinfo.index_ = 0;

    const bool flag = true;
    TaskInfo taskInfo(0, 0);
    opDumpTaskMgr.custDumpTaskMap_.insert(std::make_pair(taskInfo, flag));
    opDumpTaskMgr.ClearKfcDumpTaskInfo(KfcTaskinfo);
}

TEST_F(AiCPUThreadDatadumpSt, WorkTest_LoadSt_failed) {
    MOCKER_CPP(&OpDumpTaskManager::GetDumpStepFromString).stubs().will(returnValue(false));
    OpDumpTaskManager &opDumpTaskMgr = OpDumpTaskManager::GetInstance();
    aicpu::dump::OpMappingInfo opMappingInfo;
    const uint32_t streamId = 0;
    const uint32_t taskId = 0;
    AicpuSqeAdapter ada(0U);
    int32_t ret = opDumpTaskMgr.Load(opMappingInfo, ada);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_DUMP_FAILED);
    ret = opDumpTaskMgr.DoDump(opMappingInfo);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_DUMP_FAILED);
}