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
#include "aicpusd_feature_ctrl.h"
#include "aicpusd_resource_limit.h"
#include "dynamic_sched.pb.h"
#include "ProcMgrSysOperatorAgent.h"
#include "aicpusd_util.h"
#include "aicpusd_mc2_maintenance_thread_api.h"
#include "aicpusd_message_queue.h"
#define private public
#include "aicpu_mc2_maintenance_thread.h"
#include "aicpusd_mc2_maintenance_thread.h"
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
#include "aicpusd_profiler.h"
#include "aicpusd_args_parser.h"
#include "aicpusd_cust_dump_process.h"
#include "aicpu_prof.h"
#include "aicpusd_args_parser.h"
#include "aicpusd_message_queue.h"
#include "aicpusd_send_platform_Info_to_custom.h"
#include "aicpusd_model_err_process.h"
#undef private
using namespace AicpuSchedule;
using namespace aicpu;


namespace {
static struct event_info g_event = {
    .comm = {
        .event_id = EVENT_TEST,
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

drvError_t halEschedAckEventModelOperatorV0Success(uint32_t devId, EVENT_ID eventId, uint32_t subeventId,
    char *msg, uint32_t msgLen) {
    hwts_response_t *hwtsResp  = reinterpret_cast<hwts_response_t *>(msg);
    TsAicpuSqe *ctrlMsg = reinterpret_cast<TsAicpuSqe *>(hwtsResp->msg);
    EXPECT_EQ(ctrlMsg->cmd_type, AICPU_MODEL_OPERATE_RESPONSE);
    EXPECT_EQ(ctrlMsg->u.aicpu_model_operate_resp.cmd_type, AICPU_MODEL_OPERATE);
    std::cout << "halEschedAckEvent v0 check succ." << std::endl;
    return DRV_ERROR_NONE;
}

drvError_t halEschedAckEventModelOperatorV1Success(uint32_t devId, EVENT_ID eventId, uint32_t subeventId,
    char *msg, uint32_t msgLen) {
    hwts_response_t *hwtsResp  = reinterpret_cast<hwts_response_t *>(msg);
    TsAicpuMsgInfo *msgInfo = reinterpret_cast<TsAicpuMsgInfo *>(hwtsResp->msg);
    EXPECT_EQ(msgInfo->cmd_type, TS_AICPU_MODEL_OPERATE);
    std::cout << "halEschedAckEvent v1 check succ." << std::endl;
    return DRV_ERROR_NONE;
}

int tsDevSendMsgAsyncSuccess(unsigned int devId, unsigned int tsId, char *msg,
                             unsigned int msgLen, unsigned int handleId) {
    TsAicpuSqe *ctrlMsg = reinterpret_cast<TsAicpuSqe *>(msg);
    EXPECT_EQ(ctrlMsg->u.aicpu_timeout_cfg_resp.result, AICPU_SCHEDULE_OK);
    return 0;
}

int tsDevSendMsgAsyncModelreporterrlogV0Success(unsigned int devId, unsigned int tsId, char *msg,
                             unsigned int msgLen, unsigned int handleId) {
    TsAicpuSqe *ctrlMsg = reinterpret_cast<TsAicpuSqe *>(msg);
    EXPECT_EQ(ctrlMsg->cmd_type, AICPU_ERR_MSG_REPORT);
    return 0;
}

int tsDevSendMsgAsyncreporterrlogV1Success(unsigned int devId, unsigned int tsId, char *msg,
                             unsigned int msgLen, unsigned int handleId) {
    TsAicpuSqe *ctrlMsg = reinterpret_cast<TsAicpuSqe *>(msg);
    EXPECT_EQ(ctrlMsg->cmd_type, TS_AICPU_TASK_REPORT);
    return 0;
}

int tsDevSendMsgAsyncDumpResponseV0Success(unsigned int devId, unsigned int tsId, char *msg,
                             unsigned int msgLen, unsigned int handleId) {
    TsAicpuSqe *ctrlMsg = reinterpret_cast<TsAicpuSqe *>(msg);
    EXPECT_EQ(ctrlMsg->cmd_type, AICPU_DATADUMP_RESPONSE);
    EXPECT_EQ(ctrlMsg->u.aicpu_dump_resp.cmd_type, AICPU_DATADUMP_REPORT);
    return 0;
}

int tsDevSendMsgAsyncDumpResponseV1Success(unsigned int devId, unsigned int tsId, char *msg,
                             unsigned int msgLen, unsigned int handleId) {
    TsAicpuSqe *ctrlMsg = reinterpret_cast<TsAicpuSqe *>(msg);
    EXPECT_EQ(ctrlMsg->cmd_type, TS_AICPU_DEBUG_DATADUMP_REPORT);
    return 0;
}

int tsDevSendMsgAsyncDataDumpLoadResponseV0Success(unsigned int devId, unsigned int tsId, char *msg,
                             unsigned int msgLen, unsigned int handleId) {
    TsAicpuSqe *ctrlMsg = reinterpret_cast<TsAicpuSqe *>(msg);
    EXPECT_EQ(ctrlMsg->cmd_type, AICPU_DATADUMP_RESPONSE);
    EXPECT_EQ(ctrlMsg->u.aicpu_dump_resp.cmd_type, AICPU_DATADUMP_LOADINFO);
    return 0;
}

int tsDevSendMsgAsyncDataDumpLoadResponseV1Success(unsigned int devId, unsigned int tsId, char *msg,
                             unsigned int msgLen, unsigned int handleId) {
    TsAicpuSqe *ctrlMsg = reinterpret_cast<TsAicpuSqe *>(msg);
    EXPECT_EQ(ctrlMsg->cmd_type, TS_AICPU_DEBUG_DATADUMP_REPORT);
    return 0;
}


int tsDevSendMsgAsyncNoticeTsPidResponseV0Success(unsigned int devId, unsigned int tsId, char *msg,
                             unsigned int msgLen, unsigned int handleId) {
    TsAicpuSqe *ctrlMsg = reinterpret_cast<TsAicpuSqe *>(msg);
    EXPECT_EQ(ctrlMsg->cmd_type, AICPU_NOTICE_TS_PID);
    return 0;
}

int tsDevSendMsgAsyncNoticeTsPidResponseV1Success(unsigned int devId, unsigned int tsId, char *msg,
                             unsigned int msgLen, unsigned int handleId) {
    TsAicpuSqe *ctrlMsg = reinterpret_cast<TsAicpuSqe *>(msg);
    EXPECT_EQ(ctrlMsg->cmd_type, TS_AICPU_RECORD);
    return 0;
}

int tsDevSendMsgAsyncRecordResponseV0Success(unsigned int devId, unsigned int tsId, char *msg,
                             unsigned int msgLen, unsigned int handleId) {
    TsAicpuSqe *ctrlMsg = reinterpret_cast<TsAicpuSqe *>(msg);
    EXPECT_EQ(ctrlMsg->cmd_type, AICPU_RECORD);
    return 0;
}

int tsDevSendMsgAsyncRecordResponseV1Success(unsigned int devId, unsigned int tsId, char *msg,
                             unsigned int msgLen, unsigned int handleId) {
    TsAicpuSqe *ctrlMsg = reinterpret_cast<TsAicpuSqe *>(msg);
    EXPECT_EQ(ctrlMsg->cmd_type, TS_AICPU_RECORD);
    return 0;
}

int tsDevSendMsgAsyncAicpuTimeOutConfigResponseV0Success(unsigned int devId, unsigned int tsId, char *msg,
                             unsigned int msgLen, unsigned int handleId) {
    TsAicpuSqe *ctrlMsg = reinterpret_cast<TsAicpuSqe *>(msg);
    EXPECT_EQ(ctrlMsg->cmd_type, AICPU_TIMEOUT_CONFIG_RESPONSE);
    return 0;
}

int tsDevSendMsgAsyncAicpuTimeOutConfigResponseV1Success(unsigned int devId, unsigned int tsId, char *msg,
                             unsigned int msgLen, unsigned int handleId) {
    TsAicpuSqe *ctrlMsg = reinterpret_cast<TsAicpuSqe *>(msg);
    EXPECT_EQ(ctrlMsg->cmd_type, TS_AICPU_TIMEOUT_CONFIG);
    return 0;
}

int tsDevSendMsgAsyncInfoLoadResponseV0Success(unsigned int devId, unsigned int tsId, char *msg,
                             unsigned int msgLen, unsigned int handleId) {
    TsAicpuSqe *ctrlMsg = reinterpret_cast<TsAicpuSqe *>(msg);
    EXPECT_EQ(ctrlMsg->cmd_type, AICPU_INFO_LOAD_RESPONSE);
    return 0;
}

int tsDevSendMsgAsyncInfoLoadResponseV1Success(unsigned int devId, unsigned int tsId, char *msg,
                             unsigned int msgLen, unsigned int handleId) {
    TsAicpuSqe *ctrlMsg = reinterpret_cast<TsAicpuSqe *>(msg);
    EXPECT_EQ(ctrlMsg->cmd_type, TS_AICPU_INFO_LOAD);
    return 0;
}

int tsDevSendMsgAsyncFail(unsigned int devId, unsigned int tsId, char *msg,
                             unsigned int msgLen, unsigned int handleId) {
    TsAicpuSqe *ctrlMsg = reinterpret_cast<TsAicpuSqe *>(msg);
    EXPECT_NE(ctrlMsg->u.aicpu_timeout_cfg_resp.result, AICPU_SCHEDULE_OK);
    return 0;
}
void addPreProcessFFTSPLUSContext(const aicpu::dump::Task *task, aicpu::dump::Context *context)
{
    const auto &inputFromTask = task->input();
    uint32_t inputFromTaskSize = static_cast<uint32_t>(inputFromTask.size());
    for (uint32_t j = 0U; j < inputFromTaskSize; ++j) {
        aicpu::dump::RealAddressAndSize * opInput = context->add_input();
        const auto &task_input = inputFromTask.at(j);
        uint64_t dataAddr = task_input.address();
        uint64_t size = task_input.size();
        opInput->set_address(dataAddr);
        opInput->set_size(size);
    }
    const auto &outputFromTask = task->output();
    uint32_t outputFromTaskSize = static_cast<uint32_t>(outputFromTask.size());
    for (uint32_t j = 0U; j < outputFromTaskSize; ++j) {
        aicpu::dump::RealAddressAndSize * outInput = context->add_output();
        const auto &task_output = outputFromTask.at(j);
        uint64_t dataAddr = task_output.address();
        uint64_t size = task_output.size();
        outInput->set_address(dataAddr);
        outInput->set_size(size);
    }
}
}

class AICPUScheduleTEST : public testing::Test {
protected:
    static void SetUpTestCase() {
        std::cout << "AICPUScheduleTEST SetUpTestCase" << std::endl;
    }

    static void TearDownTestCase() {
        std::cout << "AICPUScheduleTEST TearDownTestCase" << std::endl;
    }

    virtual void SetUp()
    {
        std::cout << "AICPUScheduleTEST SetUP" << std::endl;
    }

    virtual void TearDown()
    {
        GlobalMockObject::verify();
        std::cout << "AICPUScheduleTEST TearDown" << std::endl;
    }
};

TEST_F(AICPUScheduleTEST, LOADTEST) {
    AicpuModelInfo *ModelInfoptr = (AicpuModelInfo *)malloc(sizeof(AicpuModelInfo));
    if (ModelInfoptr == nullptr) {
        return;
    }
    ModelInfoptr->moduleID = 1;
    ModelInfoptr->streamInfoNum = 10;
    ModelInfoptr->aicpuTaskNum  = 10;
    ModelInfoptr->queueSize  = 0;
    // TODO
    ModelInfoptr->tsId  = 0;
    StreamInfo *streamInfo = (StreamInfo *)malloc(sizeof(StreamInfo) * 10);
    if (streamInfo == nullptr) {
        return;
    }
    streamInfo[0].streamID = 0;
    streamInfo[0].streamFlag = AICPU_STREAM_INDEX|HEAD_STREAM_INDEX;
    for (int i = 1; i < 10; i++) {
        streamInfo[i].streamID = i;
        streamInfo[i].streamFlag = 0;
    }


    AicpuTaskInfo *aicpuTaskinfo = (AicpuTaskInfo *)malloc(sizeof(AicpuTaskInfo) * 10);
    if (aicpuTaskinfo == nullptr) {
        return ;
    }

    std::string taskNames[10];
    for (int i = 0; i < 10; i++) {
        aicpuTaskinfo[i].taskID = i;
        aicpuTaskinfo[i].streamID = 0;
        taskNames[i] = "task" + std::to_string(i);
        aicpuTaskinfo[i].kernelName = PtrToValue(taskNames[i].c_str());
    }

    ModelInfoptr->streamInfoPtr = (uint64_t)streamInfo;
    ModelInfoptr->aicpuTaskPtr  = (uint64_t)aicpuTaskinfo;

    int ret = AICPUModelLoad((void *)ModelInfoptr);
    ret = AICPUModelDestroy(ModelInfoptr->moduleID);
    free(ModelInfoptr);
    free(streamInfo);
    free(aicpuTaskinfo);
    EXPECT_EQ(ret, 0);
}

char g_char[] = "endGraph";
int g_tryTimes = 0;
std::map<pid_t, uint32_t> g_threadAndModelId;
std::mutex mtxForThreadModel;

int AICPUScheduleTESTStub_EndGraph(unsigned int chip_id, unsigned int grpId,
                                   unsigned int thread_index, unsigned int timeout,
                                   struct event_info *eventInfo)
{


    uintptr_t modelIdaddr = 0;
    mtxForThreadModel.lock();
    auto it = g_threadAndModelId.find(GetTid());
    if (it != g_threadAndModelId.end()) {
        modelIdaddr = it->second;
    }

    mtxForThreadModel.unlock();

    eventInfo->comm.pid = 100;
    eventInfo->comm.host_pid = 200;
    eventInfo->comm.event_id = EVENT_TS_HWTS_KERNEL;
    eventInfo->comm.subevent_id = 1122;
    eventInfo->comm.submit_timestamp = 0;
    eventInfo->comm.sched_timestamp = 10;

    struct hwts_ts_task eventMsg = {0};
    eventMsg.mailbox_id = 0x55AA;
    eventMsg.serial_no = 0x1122;
    eventMsg.kernel_info.kernel_type = 0;
    eventMsg.kernel_info.kernelName = (uintptr_t)g_char;
    eventMsg.kernel_info.paramBase = (uintptr_t)modelIdaddr;
    eventInfo->priv.msg_len = sizeof(hwts_ts_task);
    memcpy(eventInfo->priv.msg,(char *)&eventMsg,sizeof(hwts_ts_task));
    return 0;
}

std::mutex mt;
int g_load_try = 0;
AicpuModelInfo *ModelInfoptr = nullptr;
StreamInfo *streamInfo = nullptr;
AicpuTaskInfo *aicpuTaskinfo = nullptr;
char *kernelName = nullptr;
uint32_t *streamId = nullptr;
// drvError_t halEschedWaitEvent(unsigned int chip_id, unsigned int  thread_index, unsigned int timeout，struct event_info *event)
int AICPUScheduleTESTStub_LOAD(unsigned int chip_id,
                                unsigned int grpId,
                                 unsigned int thread_index,
                                 unsigned int timeout,
                                 struct event_info *eventInfo)
{
    {
        std::unique_lock<std::mutex> lock(mt);
        if (g_load_try >= 1) {
            sleep(1);
            return 2;
        }
        g_load_try++;
        if (eventInfo == nullptr) {
            return 2;
        }
    }

    printf("\n=============AICPUScheduleTESTStub_LOAD====\n");


    ModelInfoptr = (AicpuModelInfo *)malloc(sizeof(AicpuModelInfo));
    if (ModelInfoptr == nullptr) {
        return 0;
    }
    ModelInfoptr->moduleID = 100;
    ModelInfoptr->tsId = 12345;
    ModelInfoptr->streamInfoNum = 10;
    ModelInfoptr->aicpuTaskNum  = 10;
    ModelInfoptr->queueSize  = 0;
    streamInfo = (StreamInfo *)malloc(sizeof(StreamInfo) * 10);
    if (streamInfo == nullptr) {
        return 0;
    }
    streamInfo[0].streamID = 0;
    streamInfo[0].streamFlag = AICPU_STREAM_INDEX|HEAD_STREAM_INDEX;
    for (int i = 1; i < 10; i++) {
        streamInfo[i].streamID = i;
        streamInfo[i].streamFlag = 0;
    }

    aicpuTaskinfo = (AicpuTaskInfo *)malloc(sizeof(AicpuTaskInfo) * 10);
    if (aicpuTaskinfo == nullptr) {
        return 0;
    }

    kernelName = (char *)malloc(20);
    for (int i = 0; i < 10; i++) {
        aicpuTaskinfo[i].kernelName = (uintptr_t)kernelName;
    }
    memcpy((char *)(uintptr_t)aicpuTaskinfo[0].kernelName, "activeEntryStream", strlen("activeEntryStream") + 1);

    streamId = (uint32_t *)malloc(4);
    *streamId = 1;
    aicpuTaskinfo[0].paraBase = (uintptr_t)streamId;

    aicpuTaskinfo[0].kernelType = 0;
    for (int i = 0; i < 10; i++) {
        aicpuTaskinfo[i].taskID = i;
        aicpuTaskinfo[i].streamID = 0;
    }

    ModelInfoptr->streamInfoPtr = (uint64_t)streamInfo;
    ModelInfoptr->aicpuTaskPtr  = (uint64_t)aicpuTaskinfo;



    eventInfo->comm.pid = 100;
    eventInfo->comm.host_pid = 200;
    eventInfo->comm.event_id = EVENT_TS_CTRL_MSG;
    eventInfo->comm.subevent_id = 1122;
    eventInfo->comm.submit_timestamp = 0;
    eventInfo->comm.sched_timestamp = 10;

    TsAicpuSqe eventMsg = {0};
    // TODO:need to modify
    eventMsg.pid = 0x1111;
    eventMsg.cmd_type = AICPU_MODEL_OPERATE;
    eventMsg.vf_id = 0;
    eventMsg.tid = 0x10;
    eventMsg.u.aicpu_model_operate.cmd_type = TS_AICPU_MODEL_LOAD;
    eventMsg.u.aicpu_model_operate.model_id = 3;
    eventMsg.u.aicpu_model_operate.arg_ptr = (uintptr_t)ModelInfoptr;

    eventInfo->priv.msg_len = sizeof(ts_aicpu_sqe_t);
    memcpy(eventInfo->priv.msg, (char *)&eventMsg, sizeof(ts_aicpu_sqe_t));
    return 0;
}

// int32_t halEschedAckEvent(uint32_t chip_id, EVENT_ID event_id, char *msg, uint32_t msg_len)
int AICPUScheduleTESTAckStub(unsigned int chip_id,
                               EVENT_ID event_id,
                               unsigned int subeventId,
                               char *msg,
                               uint32_t msg_len)
{
    printf("===========event_id=%d===========\n", event_id);
    hwts_response_t *response = (hwts_response_t *)msg;
    printf("===========result=%d===========\n", response->result);
    printf("===========mailbox_id=%d=======\n", response->mailbox_id);
    printf("===========serial_no=%d========\n", response->serial_no);
    return 0;
}

// int32_t halEschedAckEvent(uint32_t chip_id, EVENT_ID event_id, char *msg, uint32_t msg_len)
int AICPUScheduleTESTAckStub_LOAD(unsigned int chip_id,
                               EVENT_ID event_id,
                               unsigned int subeventId,
                               char *msg,
                               uint32_t msg_len)
{
    printf("===========event_id=%d===========\n", event_id);
    TsAicpuSqe *response = (TsAicpuSqe *)msg;
    printf("===========result=%d=============\n", response->u.aicpu_model_operate_resp.result_code);
    printf("===========cmdType=%d============\n", response->cmd_type);
    return 0;
}

std::mutex mut;

void PackageLoadInformation (uint32_t *modelId,
                             AicpuModelInfo *&ModelInfoptr,
                             StreamInfo *&streamInfo,
                             AicpuTaskInfo *&aicpuTaskinfo,
                             uint32_t *&streamId) {
    ModelInfoptr = (AicpuModelInfo *)malloc(sizeof(AicpuModelInfo));
    if (ModelInfoptr == nullptr) {
        return;
    }

    mtxForThreadModel.lock();
    auto it = g_threadAndModelId.find(GetTid());
    if (it != g_threadAndModelId.end()) {
        g_threadAndModelId.erase(it);
    }

    g_threadAndModelId.insert(std::pair<pid_t, uint32_t>(GetTid(), (uint32_t)(uintptr_t)(modelId)));
    mtxForThreadModel.unlock();

    ModelInfoptr->moduleID = *modelId;
    ModelInfoptr->tsId = 12345;
    ModelInfoptr->streamInfoNum = 10;
    ModelInfoptr->aicpuTaskNum  = 10;
    ModelInfoptr->queueSize  = 0;
    streamInfo = (StreamInfo *)malloc(sizeof(StreamInfo) * 10);
    if (streamInfo == nullptr) {
        return;
    }
    streamInfo[0].streamID = (*modelId - 1) * 10;
    streamInfo[0].streamFlag = AICPU_STREAM_INDEX|HEAD_STREAM_INDEX;
    for (int i = (*modelId - 1) * 10 + 1; i < (*modelId - 1) * 10 + 10; i++) {
        streamInfo[i - (*modelId - 1) * 10].streamID = i;
        streamInfo[i - (*modelId - 1) * 10].streamFlag = 0;
    }

    aicpuTaskinfo = (AicpuTaskInfo *)malloc(sizeof(AicpuTaskInfo) * 10);
    if (aicpuTaskinfo == nullptr) {
        return ;
    }

    aicpuTaskinfo[0].kernelName = (uintptr_t)(char *)malloc(20);
    memcpy((char *)(uintptr_t)aicpuTaskinfo[0].kernelName, "activeEntryStream", strlen("activeEntryStream") + 1);

    streamId = (uint32_t *)malloc(4);
    *streamId = (*modelId - 1) * 10 + 1;
    aicpuTaskinfo[0].paraBase = (uintptr_t)streamId;

    aicpuTaskinfo[0].kernelType = 0;
    for (int i = 0; i < 10; i++) {
        aicpuTaskinfo[i].taskID = i;
        aicpuTaskinfo[i].streamID = (*modelId - 1) * 10;
    }

    ModelInfoptr->streamInfoPtr = (uint64_t)streamInfo;
    ModelInfoptr->aicpuTaskPtr  = (uint64_t)aicpuTaskinfo;
}

void freeLoadInformation(AicpuModelInfo *&ModelInfoptr,
                         StreamInfo *&streamInfo,
                         AicpuTaskInfo *&aicpuTaskinfo,
                         uint32_t *&streamId) {
    free(ModelInfoptr);
    free(streamInfo);
    free((char *)(uintptr_t)aicpuTaskinfo[0].kernelName);
    free(streamId);
    free(aicpuTaskinfo);
}

void LoadAndExecute(uint32_t *modelId) {
    printf("===========LoadAndExecute: modelId=%d===========\n", *modelId);
    AicpuModelInfo *ModelInfoptr = (AicpuModelInfo *)malloc(sizeof(AicpuModelInfo));
    if (ModelInfoptr == nullptr) {
        return;
    }
    mtxForThreadModel.lock();

    auto it = g_threadAndModelId.find(GetTid());
    if (it != g_threadAndModelId.end()) {
        g_threadAndModelId.erase(it);
    }

    g_threadAndModelId.insert(std::pair<pid_t, uint32_t>(GetTid(), (uint32_t)(uintptr_t)(modelId)));
    mtxForThreadModel.unlock();

    ModelInfoptr->moduleID = *modelId;
    ModelInfoptr->tsId = 12345;
    ModelInfoptr->streamInfoNum = 10;
    ModelInfoptr->aicpuTaskNum  = 10;
    ModelInfoptr->queueSize  = 0;
    StreamInfo *streamInfo = (StreamInfo *)malloc(sizeof(StreamInfo) * 10);
    if (streamInfo == nullptr) {
        return;
    }
    streamInfo[0].streamID = (*modelId - 1) * 10;
    streamInfo[0].streamFlag = AICPU_STREAM_INDEX|HEAD_STREAM_INDEX;
    for (int i = (*modelId - 1) * 10 + 1; i < (*modelId - 1) * 10 + 10; i++) {
        streamInfo[i - (*modelId - 1) * 10].streamID = i;
        streamInfo[i - (*modelId - 1) * 10].streamFlag = 0;
    }

    AicpuTaskInfo *aicpuTaskinfo = (AicpuTaskInfo *)malloc(sizeof(AicpuTaskInfo) * 10);
    if (aicpuTaskinfo == nullptr) {
        return ;
    }

    for (int i = 0; i < 10; i++) {
        aicpuTaskinfo[i].kernelName = (uintptr_t)(char *)malloc(20);
        memcpy((char *)(uintptr_t)aicpuTaskinfo[i].kernelName, "activeEntryStream", strlen("activeEntryStream") + 1);
    }

    uint32_t *streamId = (uint32_t *)malloc(4);
    *streamId = (*modelId - 1) * 10 + 1;
    aicpuTaskinfo[0].paraBase = (uintptr_t)streamId;

    aicpuTaskinfo[0].kernelType = 0;
    aicpuTaskinfo[0].kernelSo = 0;
    for (int i = 0; i < 10; i++) {
        aicpuTaskinfo[i].taskID = i;
        aicpuTaskinfo[i].streamID = (*modelId - 1) * 10;
        if (i != 0) {
            aicpuTaskinfo[i].kernelType = 1;
        }
    }

    ModelInfoptr->streamInfoPtr = (uint64_t)streamInfo;
    ModelInfoptr->aicpuTaskPtr  = (uint64_t)aicpuTaskinfo;

    int ret = AICPUModelLoad((void *)ModelInfoptr);
    ret = AICPUModelExecute(*modelId);
    ret = AICPUModelDestroy(*modelId);
    free(ModelInfoptr);
    free(streamInfo);
    for (int i = 0; i < 10; i++) {
        free((char *)(uintptr_t)aicpuTaskinfo[i].kernelName);
    }
    free(streamId);
    free(aicpuTaskinfo);
}

uint32_t modelId1 = 1;
uint32_t modelId2 = 2;
uint32_t modelId3 = 3;

TEST_F(AICPUScheduleTEST, EXECUTETESTLOOPWAIT) {
    MOCKER(halEschedWaitEvent)
        .stubs()
        .will(invoke(AICPUScheduleTESTStub_EndGraph));

    MOCKER_CPP(&AicpuEventManager::DoOnce)
        .stubs()
        .will(returnValue(16));
    MOCKER_CPP(&AicpuEventManager::ModelLoopTimeOut)
        .stubs()
        .will(returnValue(true));
    MOCKER(halEschedAckEvent)
        .stubs()
        .will(invoke(AICPUScheduleTESTAckStub));
    LoadAndExecute(&modelId1);
    LoadAndExecute(&modelId2);
    LoadAndExecute(&modelId1);
    LoadAndExecute(&modelId3);

    MOCKER(halEschedWaitEvent)
        .stubs()
        .will(returnValue(DRV_ERROR_SCHED_PARA_ERR));
    AicpuEventManager::GetInstance().DoOnce(0, 0);
    EXPECT_EQ(AicpuEventManager::GetInstance().runningFlag_, true);
}

TEST_F(AICPUScheduleTEST, EXECUTETESTREPORTSTATUS) {
    AicpuModelInfo *ModelInfoptr = (AicpuModelInfo *)malloc(sizeof(AicpuModelInfo));
    if (ModelInfoptr == nullptr) {
        return;
    }
    const uint32_t modelId = 1;
    const uint32_t aicpuStreamId = 1;
    ModelInfoptr->moduleID = modelId;
    ModelInfoptr->tsId = 12345;
    ModelInfoptr->streamInfoNum = 1;
    ModelInfoptr->aicpuTaskNum  = 1;
    ModelInfoptr->queueSize  = 0;
    StreamInfo *streamInfo = (StreamInfo *)malloc(sizeof(StreamInfo));
    if (streamInfo == nullptr) {
        return;
    }
    streamInfo[0].streamID = aicpuStreamId;
    streamInfo[0].streamFlag = AICPU_STREAM_INDEX|HEAD_STREAM_INDEX;

    AicpuTaskInfo *aicpuTaskinfo = (AicpuTaskInfo *)malloc(sizeof(AicpuTaskInfo));
    if (aicpuTaskinfo == nullptr) {
        return ;
    }

    aicpuTaskinfo[0].kernelName = (uintptr_t)(char *)malloc(20);
    memcpy((char *)(uintptr_t)aicpuTaskinfo[0].kernelName, "modelReportStatus", strlen("modelReportStatus") + 1);

    uint32_t *paraMem = (uint32_t *)malloc(sizeof(ReportStatusInfo) + 2 * sizeof(uint32_t));
    ReportStatusInfo *reportStatusInfo = reinterpret_cast<ReportStatusInfo *>(paraMem);
    reportStatusInfo->inputNum = 1U;
    aicpuTaskinfo[0].paraBase = (uintptr_t)paraMem;

    aicpuTaskinfo[0].kernelType = 0;
    aicpuTaskinfo[0].kernelSo = 0;
    aicpuTaskinfo[0].taskID = 0;
    aicpuTaskinfo[0].streamID = aicpuStreamId;

    ModelInfoptr->streamInfoPtr = (uint64_t)streamInfo;
    ModelInfoptr->aicpuTaskPtr  = (uint64_t)aicpuTaskinfo;

    int ret = AICPUModelLoad((void *)ModelInfoptr);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
    ret = AICPUModelDestroy(modelId);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
    free(ModelInfoptr);
    free(streamInfo);
    free((char *)(uintptr_t)aicpuTaskinfo[0].kernelName);
    free(paraMem);
    free(aicpuTaskinfo);
}

static uint32_t modelId11 = 1;
static uint32_t modelId22 = 2;
static uint32_t modelId33 = 3;
TEST_F(AICPUScheduleTEST, multiThread_EXECUTETEST) {

    MOCKER(halEschedWaitEvent)
        .stubs()
        .will(invoke(AICPUScheduleTESTStub_EndGraph));
    MOCKER_CPP(&AicpuEventManager::CallModeLoopProcess)
        .stubs();
    MOCKER(halEschedAckEvent)
        .stubs()
        .will(invoke(AICPUScheduleTESTAckStub));

    printf("=======================multiThread_EXECUTETEST=====================\n");
    std::thread t1(LoadAndExecute,&modelId11);
    std::thread t2(LoadAndExecute,&modelId22);
    std::thread t3(LoadAndExecute,&modelId33);
    t1.join();
    t2.join();
    t3.join();
    EXPECT_EQ(AicpuEventManager::GetInstance().runningFlag_, true);
}

#if 1
drvError_t drvGetPlatformInfo_stub(uint32_t *info)
{
    *info = 0;
    return DRV_ERROR_NONE;
}

TEST_F(AICPUScheduleTEST, MULTI_EXECUTETEST) {
    printf("=======================MULTI_EXECUTETEST=====================\n");
    g_load_try = 0;
    MOCKER_CPP(&AicpuSdCustDumpProcess::InitCustDumpProcess)
        .stubs()
        .will(returnValue(0));
    MOCKER(halEschedWaitEvent)
        .stubs()
        .will(invoke(AICPUScheduleTESTStub_LOAD));

    MOCKER(halEschedAckEvent)
        .stubs()
        .will(invoke(AICPUScheduleTESTAckStub_LOAD));

    MOCKER(drvGetPlatformInfo)
        .stubs()
        .will(invoke(drvGetPlatformInfo_stub));

    MOCKER_CPP(&ThreadPool::CreateWorker)
        .stubs()
        .will(returnValue(0));

    setenv("ASCEND_GLOBAL_LOG_LEVEL", "3", 1);
    setenv("ASCEND_GLOBAL_EVENT_ENABLE", "1", 1);
    int ret = InitAICPUScheduler(0, 100, PROFILING_CLOSE);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);

    sleep(1);
    StopAICPUScheduler(0, 100);
    free(ModelInfoptr);
    free(streamInfo);
    free(aicpuTaskinfo);
    free(kernelName);
    free(streamId);
}

#endif

TEST_F(AICPUScheduleTEST, AICPUExecuteTask_FAIL) {
    int ret = AICPUExecuteTask(nullptr, nullptr);
    EXPECT_EQ(ret, AICPU_SCHEDULE_FAIL);
}

TEST_F(AICPUScheduleTEST, AICPUPreOpenKernels_FAIL) {
    int ret = AICPUPreOpenKernels(nullptr);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID);
}

TEST_F(AICPUScheduleTEST, AICPUPreOpenKernels_SUCCESS) {
    char test[10] = "test";
    int ret = AICPUPreOpenKernels(test);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
}

TEST_F(AICPUScheduleTEST, LOADPROCESS_ERROR) {
    static uint32_t modelId1 = 1;
    int ret = AICPUModelLoad((void *)nullptr);
    EXPECT_EQ(ret, AICPU_SCHEDULE_FAIL);
}

TEST_F(AICPUScheduleTEST, DoOnceTest1) {
    MOCKER(halEschedWaitEvent)
        .stubs()
        .will(returnValue(DRV_ERROR_SCHED_PARA_ERR));
    AicpuEventManager::GetInstance().DoOnce(0, 0);
    EXPECT_EQ(AicpuEventManager::GetInstance().runningFlag_, false);
}

TEST_F(AICPUScheduleTEST, DoOnceTest2) {
    MOCKER(halEschedWaitEvent)
        .stubs()
        .will(returnValue(DRV_ERROR_SCHED_PROCESS_EXIT));
    AicpuEventManager::GetInstance().DoOnce(0, 0);
    EXPECT_EQ(AicpuEventManager::GetInstance().runningFlag_, false);
}

TEST_F(AICPUScheduleTEST, DoOnceTest3) {
    MOCKER(halEschedWaitEvent)
        .stubs()
        .will(returnValue(DRV_ERROR_SCHED_WAIT_FAILED));
    AicpuEventManager::GetInstance().DoOnce(0, 0);
    EXPECT_EQ(AicpuEventManager::GetInstance().runningFlag_, false);
}

TEST_F(AICPUScheduleTEST, DoOnceTest4) {
    MOCKER_CPP(&AicpuSchedule::g_aicpuProfiler.GetHiperfSoStatus)
        .stubs()
        .will(returnValue(true));
    AicpuEventManager::GetInstance().DoOnce(0, 0);
    EXPECT_EQ(AicpuEventManager::GetInstance().runningFlag_, false);
}

TEST_F(AICPUScheduleTEST, DoOnceTestFailedAicpuIllegalCPU) {
    MOCKER(halEschedWaitEvent)
        .stubs()
        .will(returnValue(DRV_ERROR_SCHED_RUN_IN_ILLEGAL_CPU));
    int32_t ret = AicpuEventManager::GetInstance().DoOnce(0, 0);
    EXPECT_EQ(ret, DRV_ERROR_SCHED_RUN_IN_ILLEGAL_CPU);
}

TEST_F(AICPUScheduleTEST, CheckAndSetExitFlagTest) {
    AicpuEventManager::GetInstance().noThreadFlag_ = true;
    AicpuEventManager::GetInstance().CheckAndSetExitFlag();
    EXPECT_EQ(AicpuEventManager::GetInstance().noThreadFlag_, true);
}

TEST_F(AICPUScheduleTEST, GetRunningFlag) {
    const bool flag = AicpuEventManager::GetInstance().GetRunningFlag();
    EXPECT_EQ(flag, false);
}

TEST_F(AICPUScheduleTEST, ModelLoopTimeOutTest) {
    const int32_t retVal = 0;
    uint32_t waitCounter = 0U;
    const bool timeoutFlag = AicpuEventManager::GetInstance().ModelLoopTimeOut(retVal, waitCounter, 1);
    EXPECT_EQ(timeoutFlag, false);
}

TEST_F(AICPUScheduleTEST, ModelLoopTimeOutTestTrue) {
    const int32_t retVal = 16;
    uint32_t waitCounter = 0U;
    const bool timeoutFlag = AicpuEventManager::GetInstance().ModelLoopTimeOut(retVal, waitCounter, 1);
    EXPECT_EQ(timeoutFlag, true);
}

TEST_F(AICPUScheduleTEST,EventDistributionTest) {
    AicpuSqeAdapter::AicpuModelOperateInfo info = {0};
    info.cmd_type = TS_AICPU_MODEL_EXECUTE;
    int ret = AicpuEventManager::GetInstance().EventDistribution(info);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_MODEL_NOT_FOUND);

    info.cmd_type = TS_AICPU_MODEL_ABORT;
    ret = AicpuEventManager::GetInstance().EventDistribution(info);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_MODEL_NOT_FOUND);

    info.cmd_type = TS_AICPU_MODEL_DESTROY;
    ret = AicpuEventManager::GetInstance().EventDistribution(info);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_MODEL_NOT_FOUND);

    info.cmd_type = 11;
    ret = AicpuEventManager::GetInstance().EventDistribution(info);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_NOT_FOUND_CMD_TYPE);
}

TEST_F(AICPUScheduleTEST, ProcessHWTSControlEventTest) {
    MOCKER_CPP(&AicpuSdCustDumpProcess::InitCustDumpProcess).stubs().will(returnValue(0));
    event_info eventInfo = g_event;
    eventInfo.priv.msg_len = sizeof(TsAicpuSqe);
    TsAicpuSqe *ctrlMsg = reinterpret_cast<TsAicpuSqe *>(eventInfo.priv.msg);
    ctrlMsg->cmd_type = AIC_TASK_REPORT;
    int ret = AicpuEventManager::GetInstance().ProcessHWTSControlEvent(eventInfo);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_MODEL_NOT_FOUND);

    // MOCKER_CPP(&AicpuEventProcess::ProcessTaskReportEvent)
    //     .stubs()
    //     .will(returnValue(0));
    // ret = AicpuEventManager::GetInstance().ProcessHWTSControlEvent(eventInfo);
    EXPECT_NE(ret, AICPU_SCHEDULE_OK);

    ctrlMsg->cmd_type = 20;
    ret = AicpuEventManager::GetInstance().ProcessHWTSControlEvent(eventInfo);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);

    ctrlMsg->cmd_type = 21;
    ret = AicpuEventManager::GetInstance().ProcessHWTSControlEvent(eventInfo);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_NOT_FOUND_EVENT);
}

TEST_F(AICPUScheduleTEST, ProcessHWTSControlEventV1Test) {
    MOCKER_CPP(&AicpuSdCustDumpProcess::InitCustDumpProcess).stubs().will(returnValue(0));
    event_info eventInfo = g_event;
    eventInfo.priv.msg_len = sizeof(TsAicpuMsgInfo);
    TsAicpuMsgInfo *ctrlMsg = reinterpret_cast<TsAicpuMsgInfo *>(eventInfo.priv.msg);
    uint16_t version = 1;
    MOCKER_CPP(&FeatureCtrl::GetTsMsgVersion)
        .stubs()
        .will(returnValue(version));
    ctrlMsg->cmd_type = TS_AIC_ERROR_REPORT;
    int ret = AicpuEventManager::GetInstance().ProcessHWTSControlEvent(eventInfo);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
}

TEST_F(AICPUScheduleTEST, ProcessHWTSControlEventV1ModelOperatorTest) {
    MOCKER_CPP(&AicpuSdCustDumpProcess::InitCustDumpProcess).stubs().will(returnValue(0));
    event_info eventInfo;
    eventInfo.comm.event_id = EVENT_TS_CTRL_MSG;
    eventInfo.priv.msg_len = sizeof(TsAicpuMsgInfo);

    const uint32_t timeout = 100U;
    TsAicpuMsgInfo *msgInfo = reinterpret_cast<TsAicpuMsgInfo *>(eventInfo.priv.msg);
    msgInfo->tid = 5;
    msgInfo->ts_id = 1;
    msgInfo->cmd_type = TS_AICPU_MODEL_OPERATE;
    uint16_t version = 1;
    MOCKER_CPP(&FeatureCtrl::GetTsMsgVersion)
        .stubs()
        .will(returnValue(version));
    MOCKER_CPP(&AicpuEventManager::EventDistribution)
        .stubs()
        .will(returnValue(AICPU_SCHEDULE_OK));
    MOCKER(halEschedAckEvent).stubs().will(invoke(halEschedAckEventModelOperatorV1Success));
    int ret = AicpuEventManager::GetInstance().ProcessHWTSControlEvent(eventInfo);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
}

TEST_F(AICPUScheduleTEST, ProcessHWTSControlEventV0ModelOperatorTest) {
    MOCKER_CPP(&AicpuSdCustDumpProcess::InitCustDumpProcess).stubs().will(returnValue(0));
    event_info eventInfo;
    eventInfo.comm.event_id = EVENT_TS_CTRL_MSG;
    eventInfo.priv.msg_len = sizeof(TsAicpuSqe);

    const uint32_t timeout = 100U;
    TsAicpuSqe *info = reinterpret_cast<TsAicpuSqe *>(eventInfo.priv.msg);
    info->tid = 5;
    info->ts_id = 1;
    info->cmd_type = AICPU_MODEL_OPERATE;
    uint16_t version = 0;
    MOCKER_CPP(&FeatureCtrl::GetTsMsgVersion)
        .stubs()
        .will(returnValue(version));
    MOCKER_CPP(&AicpuEventManager::EventDistribution)
        .stubs()
        .will(returnValue(AICPU_SCHEDULE_OK));
    MOCKER(halEschedAckEvent).stubs().will(invoke(halEschedAckEventModelOperatorV0Success));
    int ret = AicpuEventManager::GetInstance().ProcessHWTSControlEvent(eventInfo);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
}

TEST_F(AICPUScheduleTEST, ProcessHWTSControlEventV1ReportErrLogTest) {
    ErrLogRptInfo reportInfo = {};
    TsAicpuMsgInfo info = {0};
    info.cmd_type = TS_AICPU_TASK_REPORT;
    AicpuSqeAdapter adapter(info, 1U);
    MOCKER(tsDevSendMsgAsync).stubs().will(invoke(tsDevSendMsgAsyncreporterrlogV1Success));
    const auto ret = AicpuModelErrProc::GetInstance().ReportErrLog(reportInfo, &adapter);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
}

TEST_F(AICPUScheduleTEST, ProcessHWTSControlEventV0ReportErrLogTest) {
    TsAicpuSqe info = {0};
    ErrLogRptInfo reportInfo = {};
    AicpuSqeAdapter adapter(info, 0U);
    MOCKER(tsDevSendMsgAsync).stubs().will(invoke(tsDevSendMsgAsyncModelreporterrlogV0Success));
    const auto ret = AicpuModelErrProc::GetInstance().ReportErrLog(reportInfo, &adapter);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
}

TEST_F(AICPUScheduleTEST, ProcessHWTSControlDumpRspV1Test) {
    TsAicpuMsgInfo info{0};
    info.cmd_type = TS_AICPU_DEBUG_DATADUMP_REPORT;
    AicpuSqeAdapter adapter(info, 1U);
    MOCKER(tsDevSendMsgAsync).stubs().will(invoke(tsDevSendMsgAsyncDumpResponseV1Success));
    const auto ret = adapter.AicpuDumpResponseToTs(0);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
}

TEST_F(AICPUScheduleTEST, ProcessHWTSControlDumpRspV0Test) {
    TsAicpuSqe info = {0};
    AicpuSqeAdapter adapter(info, 0U);
    MOCKER(tsDevSendMsgAsync).stubs().will(invoke(tsDevSendMsgAsyncDumpResponseV0Success));
    const auto ret = adapter.AicpuDumpResponseToTs(0);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
}

TEST_F(AICPUScheduleTEST, ProcessHWTSControlNoticeTsPidResponseV1Test) {
    TsAicpuMsgInfo info{0};
    AicpuSqeAdapter adapter(info, 1U);
    MOCKER(tsDevSendMsgAsync).stubs().will(returnValue(0));                
    const auto ret = adapter.AicpuNoticeTsPidResponse(0);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
}

TEST_F(AICPUScheduleTEST, ProcessHWTSControlNoticeTsPidResponseV0Test) {
    TsAicpuSqe info = {0};
    AicpuSqeAdapter adapter(info, 0U);
    MOCKER(tsDevSendMsgAsync).stubs().will(invoke(tsDevSendMsgAsyncNoticeTsPidResponseV0Success));
    const auto ret = adapter.AicpuNoticeTsPidResponse(0);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
}

TEST_F(AICPUScheduleTEST, ProcessHWTSControlRecordResponseV1Test) {
    TsAicpuMsgInfo info{0};
    AicpuSqeAdapter adapter(info, 1U);
    MOCKER(tsDevSendMsgAsync).stubs().will(invoke(tsDevSendMsgAsyncRecordResponseV1Success));
    AicpuSqeAdapter::AicpuRecordInfo info1(0,0,0,0,0,0,0);
    const auto ret = adapter.AicpuRecordResponseToTs(info1);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
}

TEST_F(AICPUScheduleTEST, ProcessHWTSControlRecordResponseV0Test) {
    TsAicpuSqe info = {0};
    AicpuSqeAdapter adapter(info, 0U);
    AicpuSqeAdapter::AicpuRecordInfo info1(0,0,0,0,0,0,0);
    MOCKER(tsDevSendMsgAsync).stubs().will(invoke(tsDevSendMsgAsyncRecordResponseV0Success));
    const auto ret = adapter.AicpuRecordResponseToTs(info1);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
}

TEST_F(AICPUScheduleTEST, ProcessHWTSControlTimeOutConfigResponseV1Test) {
    TsAicpuMsgInfo info{0};
    info.cmd_type = TS_AICPU_TIMEOUT_CONFIG;
    AicpuSqeAdapter adapter(info, 1U);
    MOCKER(tsDevSendMsgAsync).stubs().will(invoke(tsDevSendMsgAsyncAicpuTimeOutConfigResponseV1Success));
    const auto ret = adapter.AicpuTimeOutConfigResponseToTs(0);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
}

TEST_F(AICPUScheduleTEST, ProcessHWTSControlTimeOutConfigResponseV0Test) {
    TsAicpuSqe info = {0};
    AicpuSqeAdapter adapter(info, 0U);
    MOCKER(tsDevSendMsgAsync).stubs().will(invoke(tsDevSendMsgAsyncAicpuTimeOutConfigResponseV0Success));
    const auto ret = adapter.AicpuTimeOutConfigResponseToTs(0);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
}

TEST_F(AICPUScheduleTEST, ProcessHWTSControlInfoLoadResponseV1Test) {
    TsAicpuMsgInfo info{0};
    info.cmd_type = TS_AICPU_INFO_LOAD;
    AicpuSqeAdapter adapter(info, 1U);
    MOCKER(tsDevSendMsgAsync).stubs().will(invoke(tsDevSendMsgAsyncInfoLoadResponseV1Success));
    const auto ret = adapter.AicpuInfoLoadResponseToTs(0);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
}

TEST_F(AICPUScheduleTEST, ProcessHWTSControlInfoLoadResponseV0Test) {
    TsAicpuSqe info = {0};
    AicpuSqeAdapter adapter(info, 0U);
    MOCKER(tsDevSendMsgAsync).stubs().will(invoke(tsDevSendMsgAsyncInfoLoadResponseV0Success));
    const auto ret = adapter.AicpuInfoLoadResponseToTs(0);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
}

TEST_F(AICPUScheduleTEST, ProcessSetTimeoutEventSuccess01) {
    // set op execute success
    event_info eventInfo;
    eventInfo.comm.event_id = EVENT_TS_CTRL_MSG;
    eventInfo.priv.msg_len = sizeof(TsAicpuSqe);

    const uint32_t timeout = 100U;
    TsAicpuSqe *ctrlMsg = reinterpret_cast<TsAicpuSqe *>(eventInfo.priv.msg);
    ctrlMsg->tid = 5;
    ctrlMsg->ts_id = 1;
    ctrlMsg->cmd_type = AICPU_TIMEOUT_CONFIG;
    ctrlMsg->u.ts_to_aicpu_timeout_cfg.op_execute_timeout_en = 1;
    ctrlMsg->u.ts_to_aicpu_timeout_cfg.op_execute_timeout = timeout;
    ctrlMsg->u.ts_to_aicpu_timeout_cfg.op_wait_timeout_en = 0;
    ctrlMsg->u.ts_to_aicpu_timeout_cfg.op_wait_timeout = 0;

    MOCKER(tsDevSendMsgAsync).stubs().will(invoke(tsDevSendMsgAsyncSuccess));
    int ret = AicpuEventManager::GetInstance().ProcessHWTSControlEvent(eventInfo);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
    EXPECT_EQ(AicpuMonitor::GetInstance().tsOpTimeOut_, timeout);
}

TEST_F(AICPUScheduleTEST, ProcessSetTimeoutEventSuccess02) {
    // set op wait success and stop aicpu op timer
    event_info eventInfo;
    eventInfo.comm.event_id = EVENT_TS_CTRL_MSG;
    eventInfo.priv.msg_len = sizeof(TsAicpuSqe);

    const uint32_t timeout = 100U;
    TsAicpuSqe *ctrlMsg = reinterpret_cast<TsAicpuSqe *>(eventInfo.priv.msg);
    ctrlMsg->tid = 5;
    ctrlMsg->ts_id = 1;
    ctrlMsg->cmd_type = AICPU_TIMEOUT_CONFIG;
    ctrlMsg->u.ts_to_aicpu_timeout_cfg.op_execute_timeout_en = 0;
    ctrlMsg->u.ts_to_aicpu_timeout_cfg.op_execute_timeout = 0;
    ctrlMsg->u.ts_to_aicpu_timeout_cfg.op_wait_timeout_en = 1;
    ctrlMsg->u.ts_to_aicpu_timeout_cfg.op_wait_timeout = timeout;

    MOCKER(tsDevSendMsgAsync).stubs().will(invoke(tsDevSendMsgAsyncSuccess));
    int ret = AicpuEventManager::GetInstance().ProcessHWTSControlEvent(eventInfo);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
    EXPECT_EQ(AicpuMonitor::GetInstance().opTimeoutFlag_, true);
}

TEST_F(AICPUScheduleTEST, ProcessSetTimeoutEventSuccess03) {
    // set op wait and execute success
    event_info eventInfo;
    eventInfo.comm.event_id = EVENT_TS_CTRL_MSG;
    eventInfo.priv.msg_len = sizeof(TsAicpuSqe);

    const uint32_t timeout = 100U;
    TsAicpuSqe *ctrlMsg = reinterpret_cast<TsAicpuSqe *>(eventInfo.priv.msg);
    ctrlMsg->tid = 5;
    ctrlMsg->ts_id = 1;
    ctrlMsg->cmd_type = AICPU_TIMEOUT_CONFIG;
    ctrlMsg->u.ts_to_aicpu_timeout_cfg.op_execute_timeout_en = 1;
    ctrlMsg->u.ts_to_aicpu_timeout_cfg.op_execute_timeout = timeout;
    ctrlMsg->u.ts_to_aicpu_timeout_cfg.op_wait_timeout_en = 1;
    ctrlMsg->u.ts_to_aicpu_timeout_cfg.op_wait_timeout = timeout;

    MOCKER(tsDevSendMsgAsync).stubs().will(invoke(tsDevSendMsgAsyncSuccess));
    int ret = AicpuEventManager::GetInstance().ProcessHWTSControlEvent(eventInfo);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
    EXPECT_EQ(AicpuMonitor::GetInstance().opTimeoutFlag_, true);
    EXPECT_EQ(AicpuMonitor::GetInstance().tsOpTimeOut_, timeout);
}


TEST_F(AICPUScheduleTEST, ProcessSetTimeoutEventSuccess04) {
    // op wait enable and wait time is 0, aicpu op timer will not be closed
    event_info eventInfo;
    eventInfo.comm.event_id = EVENT_TS_CTRL_MSG;
    eventInfo.priv.msg_len = sizeof(TsAicpuSqe);

    const uint32_t timeout = 100;
    TsAicpuSqe *ctrlMsg = reinterpret_cast<TsAicpuSqe *>(eventInfo.priv.msg);
    ctrlMsg->tid = 5;
    ctrlMsg->ts_id = 1;
    ctrlMsg->cmd_type = AICPU_TIMEOUT_CONFIG;
    ctrlMsg->u.ts_to_aicpu_timeout_cfg.op_execute_timeout_en = 1;
    ctrlMsg->u.ts_to_aicpu_timeout_cfg.op_execute_timeout = timeout;
    ctrlMsg->u.ts_to_aicpu_timeout_cfg.op_wait_timeout_en = 1;
    ctrlMsg->u.ts_to_aicpu_timeout_cfg.op_wait_timeout = 0;

    AicpuMonitor::GetInstance().opTimeoutFlag_ = true;
    MOCKER(tsDevSendMsgAsync).stubs().will(invoke(tsDevSendMsgAsyncSuccess));
    int ret = AicpuEventManager::GetInstance().ProcessHWTSControlEvent(eventInfo);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
    EXPECT_EQ(AicpuMonitor::GetInstance().opTimeoutFlag_, true);
}

TEST_F(AICPUScheduleTEST, ProcessSetTimeoutEventSuccess05) {
    // op wait enable and wait time is larger than execut time, aicpu op timer will not be closed
    event_info eventInfo;
    eventInfo.comm.event_id = EVENT_TS_CTRL_MSG;
    eventInfo.priv.msg_len = sizeof(TsAicpuSqe);

    const uint32_t timeout = 100;
    TsAicpuSqe *ctrlMsg = reinterpret_cast<TsAicpuSqe *>(eventInfo.priv.msg);
    ctrlMsg->tid = 5;
    ctrlMsg->ts_id = 1;
    ctrlMsg->cmd_type = AICPU_TIMEOUT_CONFIG;
    ctrlMsg->u.ts_to_aicpu_timeout_cfg.op_execute_timeout_en = 1;
    ctrlMsg->u.ts_to_aicpu_timeout_cfg.op_execute_timeout = timeout;
    ctrlMsg->u.ts_to_aicpu_timeout_cfg.op_wait_timeout_en = 1;
    ctrlMsg->u.ts_to_aicpu_timeout_cfg.op_wait_timeout = 500;

    AicpuMonitor::GetInstance().opTimeoutFlag_ = true;
    MOCKER(tsDevSendMsgAsync).stubs().will(invoke(tsDevSendMsgAsyncSuccess));
    int ret = AicpuEventManager::GetInstance().ProcessHWTSControlEvent(eventInfo);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
    EXPECT_EQ(AicpuMonitor::GetInstance().opTimeoutFlag_, true);
    EXPECT_EQ(AicpuMonitor::GetInstance().tsOpTimeOut_.load(), timeout);
}

TEST_F(AICPUScheduleTEST, ProcessSetTimeoutEventSuccess06) {
    // op wait enable and wait time is lesser than execut time, aicpu op timer will not be closed
    event_info eventInfo;
    eventInfo.comm.event_id = EVENT_TS_CTRL_MSG;
    eventInfo.priv.msg_len = sizeof(TsAicpuSqe);

    const uint32_t timeout = 100;
    TsAicpuSqe *ctrlMsg = reinterpret_cast<TsAicpuSqe *>(eventInfo.priv.msg);
    ctrlMsg->tid = 5;
    ctrlMsg->ts_id = 1;
    ctrlMsg->cmd_type = AICPU_TIMEOUT_CONFIG;
    ctrlMsg->u.ts_to_aicpu_timeout_cfg.op_execute_timeout_en = 1;
    ctrlMsg->u.ts_to_aicpu_timeout_cfg.op_execute_timeout = timeout;
    ctrlMsg->u.ts_to_aicpu_timeout_cfg.op_wait_timeout_en = 1;
    ctrlMsg->u.ts_to_aicpu_timeout_cfg.op_wait_timeout = 10;

    AicpuMonitor::GetInstance().opTimeoutFlag_ = true;
    MOCKER(tsDevSendMsgAsync).stubs().will(invoke(tsDevSendMsgAsyncSuccess));
    int ret = AicpuEventManager::GetInstance().ProcessHWTSControlEvent(eventInfo);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
    EXPECT_EQ(AicpuMonitor::GetInstance().opTimeoutFlag_, false);
    EXPECT_EQ(AicpuMonitor::GetInstance().tsOpTimeOut_.load(), timeout);
}

TEST_F(AICPUScheduleTEST, ProcessSetTimeoutEventFail01) {
    // set op execute failed by timeout overflow
    event_info eventInfo;
    eventInfo.comm.event_id = EVENT_TS_CTRL_MSG;
    eventInfo.priv.msg_len = sizeof(TsAicpuSqe);

    const uint32_t timeout = 100;
    TsAicpuSqe *ctrlMsg = reinterpret_cast<TsAicpuSqe *>(eventInfo.priv.msg);
    ctrlMsg->tid = 5;
    ctrlMsg->ts_id = 1;
    ctrlMsg->cmd_type = AICPU_TIMEOUT_CONFIG;
    ctrlMsg->u.ts_to_aicpu_timeout_cfg.op_execute_timeout_en = 1;
    ctrlMsg->u.ts_to_aicpu_timeout_cfg.op_execute_timeout = timeout;
    ctrlMsg->u.ts_to_aicpu_timeout_cfg.op_wait_timeout_en = 0;
    ctrlMsg->u.ts_to_aicpu_timeout_cfg.op_wait_timeout = 0;

    MOCKER(tsDevSendMsgAsync).stubs().will(invoke(tsDevSendMsgAsyncFail));
    MOCKER_CPP(&aicpu::GetSystemTickFreq).stubs().will(returnValue(UINT64_MAX / (timeout-1)));
    int ret = AicpuEventManager::GetInstance().ProcessHWTSControlEvent(eventInfo);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
}

TEST_F(AICPUScheduleTEST, ProcessSetTimeoutEventFail02) {
    // set timeout config failed by not set anything
    event_info eventInfo;
    eventInfo.comm.event_id = EVENT_TS_CTRL_MSG;
    eventInfo.priv.msg_len = sizeof(TsAicpuSqe);

    const uint32_t timeout = 100;
    TsAicpuSqe *ctrlMsg = reinterpret_cast<TsAicpuSqe *>(eventInfo.priv.msg);
    ctrlMsg->tid = 5;
    ctrlMsg->ts_id = 1;
    ctrlMsg->cmd_type = AICPU_TIMEOUT_CONFIG;
    ctrlMsg->u.ts_to_aicpu_timeout_cfg.op_execute_timeout_en = 0;
    ctrlMsg->u.ts_to_aicpu_timeout_cfg.op_execute_timeout = timeout;
    ctrlMsg->u.ts_to_aicpu_timeout_cfg.op_wait_timeout_en = 0;
    ctrlMsg->u.ts_to_aicpu_timeout_cfg.op_wait_timeout = 0;

    MOCKER(tsDevSendMsgAsync).stubs().will(invoke(tsDevSendMsgAsyncSuccess));
    int ret = AicpuEventManager::GetInstance().ProcessHWTSControlEvent(eventInfo);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
}

TEST_F(AICPUScheduleTEST, ProcessSetTimeoutEventFail03) {
    // set op execute failed by send msg fail
    event_info eventInfo;
    eventInfo.comm.event_id = EVENT_TS_CTRL_MSG;
    eventInfo.priv.msg_len = sizeof(TsAicpuSqe);

    const uint32_t timeout = 100;
    TsAicpuSqe *ctrlMsg = reinterpret_cast<TsAicpuSqe *>(eventInfo.priv.msg);
    ctrlMsg->tid = 5;
    ctrlMsg->ts_id = 1;
    ctrlMsg->cmd_type = AICPU_TIMEOUT_CONFIG;
    ctrlMsg->u.ts_to_aicpu_timeout_cfg.op_execute_timeout_en = 1;
    ctrlMsg->u.ts_to_aicpu_timeout_cfg.op_execute_timeout = timeout;
    ctrlMsg->u.ts_to_aicpu_timeout_cfg.op_wait_timeout_en = 0;
    ctrlMsg->u.ts_to_aicpu_timeout_cfg.op_wait_timeout = 0;

    MOCKER(tsDevSendMsgAsync).stubs().will(returnValue(-1));
    int ret = AicpuEventManager::GetInstance().ProcessHWTSControlEvent(eventInfo);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_INNER_ERROR);
}

TEST_F(AICPUScheduleTEST, ProcessHWTSKernelEventTest) {
    event_info eventInfo = g_event;
    eventInfo.comm.event_id = EVENT_TS_HWTS_KERNEL;
    eventInfo.priv.msg_len = sizeof(hwts_ts_task);
    struct hwts_ts_task *eventMsg = reinterpret_cast<hwts_ts_task *>(eventInfo.priv.msg);
    eventMsg->mailbox_id = 1;
    eventMsg->serial_no = 9527;
    eventMsg->kernel_info.kernel_type = KERNEL_TYPE_AICPU;
    eventMsg->kernel_info.streamID = 203;
    char kernelName[] = "CastV2";
    char kernelSo[] = "libcpu_kernels.so";
    eventMsg->kernel_info.kernelName = (uintptr_t)kernelName;
    eventMsg->kernel_info.kernelSo = (uintptr_t)kernelSo;
    MOCKER_CPP(&MessageQueue::SendResponse).stubs();
    MOCKER_CPP(&AicpuEventProcess::ExecuteTsKernelTask)
        .stubs()
        .will(returnValue(0));
    int ret = AicpuEventManager::GetInstance().ProcessEvent(eventInfo, 0);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
}

namespace AicpuSchedule {
bool StubCheckOverflow(int32_t &result)
{
    result = AICPU_SCHEDULE_ERROR_OVERFLOW;
    return true;
}

void ResetFpsrStub() {}
}

TEST_F(AICPUScheduleTEST, ProcessFFTSKernelEventTest) {
    event_info eventInfo = g_event;
    eventInfo.comm.event_id = EVENT_TS_HWTS_KERNEL;
    eventInfo.comm.subevent_id = EVENT_FFTS_PLUS_MSG;
    eventInfo.priv.msg_len = sizeof(hwts_ts_task);
    struct hwts_ts_task *eventMsg = reinterpret_cast<hwts_ts_task *>(eventInfo.priv.msg);
    eventMsg->mailbox_id = 1;
    eventMsg->serial_no = 9527;
    eventMsg->kernel_info.kernel_type = KERNEL_TYPE_AICPU;
    eventMsg->kernel_info.streamID = 203;
    char kernelName[] = "CastV2";
    char kernelSo[] = "libcpu_kernels.so";
    eventMsg->kernel_info.kernelName = (uintptr_t)kernelName;
    eventMsg->kernel_info.kernelSo = (uintptr_t)kernelSo;
    MOCKER_CPP(&AicpuEventProcess::ExecuteTsKernelTask)
        .stubs()
        .will(returnValue(0));
    MOCKER_CPP(&MessageQueue::SendResponse).stubs();
    int ret = AicpuEventManager::GetInstance().ProcessEvent(eventInfo, 0);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
}

TEST_F(AICPUScheduleTEST, ProcessEventCDQTest) {
    event_info eventInfo = g_event;
    eventInfo.comm.event_id = EVENT_CDQ_MSG;
    eventInfo.comm.subevent_id = 0;
    int ret = AicpuEventManager::GetInstance().ProcessEvent(eventInfo, 0);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
}

TEST_F(AICPUScheduleTEST, ProcessHWTSTimoutCfgTest) {
    event_info eventInfo = g_event;
    eventInfo.priv.msg_len = sizeof(ts_aicpu_sqe_t);
    ts_aicpu_sqe_t *ctrlMsg = reinterpret_cast<ts_aicpu_sqe_t *>(eventInfo.priv.msg);
    ctrlMsg->cmd_type = AICPU_TIMEOUT_CONFIG;
    ctrlMsg->u.ts_to_aicpu_timeout_cfg.op_execute_timeout_en = 1;
    ctrlMsg->u.ts_to_aicpu_timeout_cfg.op_execute_timeout = 300;
    int ret = AicpuEventManager::GetInstance().ProcessHWTSControlEvent(eventInfo);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
}

TEST_F(AICPUScheduleTEST, ProcessHWTSTimoutCfgTestFail) {
    MOCKER(aicpu::GetSystemTickFreq)
        .stubs()
        .will(returnValue(0xFFFFFFFFFFFFFFFF));
    event_info eventInfo = g_event;
    eventInfo.priv.msg_len = sizeof(ts_aicpu_sqe_t);
    ts_aicpu_sqe_t *ctrlMsg = reinterpret_cast<ts_aicpu_sqe_t *>(eventInfo.priv.msg);
    ctrlMsg->cmd_type = AICPU_TIMEOUT_CONFIG;
    ctrlMsg->u.ts_to_aicpu_timeout_cfg.op_execute_timeout_en = 1;
    ctrlMsg->u.ts_to_aicpu_timeout_cfg.op_execute_timeout = 300;
    int ret = AicpuEventManager::GetInstance().ProcessHWTSControlEvent(eventInfo);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
}

TEST_F(AICPUScheduleTEST, ProcessCdqEventTest) {
    event_info eventInfo = g_event;
    eventInfo.comm.event_id = EVENT_CDQ_MSG;
    eventInfo.comm.subevent_id = 0;
    int ret = AicpuEventManager::GetInstance().ProcessCdqEvent(eventInfo);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
}

TEST_F(AICPUScheduleTEST, InitAICPUSchedulerTest_JsonEmpty) {
    AicpuScheduleInterface::GetInstance().initFlag_ = true;
    MOCKER_CPP(&AicpuSdCustDumpProcess::InitCustDumpProcess)
        .stubs()
        .will(returnValue(0));
    MOCKER_CPP(&ThreadPool::CreateWorker)
        .stubs()
        .will(returnValue(0));

    std::string ch = "000000000000000000000000000000000000000000000000";
    std::vector<uint32_t> deviceVec;
    deviceVec.push_back(1);
    MOCKER_CPP(&AicpuDrvManager::CheckBindHostPid)
        .stubs()
        .will(returnValue(0));
    MOCKER(tsDevSendMsgAsync).stubs().will(returnValue(-1));
    int ret = AicpuScheduleInterface::GetInstance().InitAICPUScheduler(deviceVec, 0, ch, (ProfilingMode)0,
                                                                       1, true, SCHED_MODE_INTERRUPT);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);

    AicpuScheduleInterface::GetInstance().initFlag_ = false;
    MOCKER_CPP(&AicpuDrvManager::CheckBindHostPid)
        .stubs()
        .will(returnValue(0));
    ret = AicpuScheduleInterface::GetInstance().InitAICPUScheduler(deviceVec, 0, ch, (ProfilingMode)0,
                                                                   1, true, SCHED_MODE_INTERRUPT);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
}

TEST_F(AICPUScheduleTEST, InitAICPUSchedulerTest_SUCCESS) {
    AicpuScheduleInterface::GetInstance().initFlag_ = true;
    MOCKER_CPP(&ThreadPool::CreateWorker)
        .stubs()
        .will(returnValue(0));

    std::string ch = "000000000000000000000000000000000000000000000000";
    std::vector<uint32_t> deviceVec;
    deviceVec.push_back(0);
    MOCKER_CPP(&AicpuDrvManager::CheckBindHostPid)
        .stubs()
        .will(returnValue(0));
    int ret = AicpuScheduleInterface::GetInstance().InitAICPUScheduler(deviceVec, 0, ch, (ProfilingMode)0,
                                                                       0, true, SCHED_MODE_INTERRUPT);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);

    AicpuScheduleInterface::GetInstance().initFlag_ = false;
    MOCKER_CPP(&AicpuDrvManager::CheckBindHostPid)
        .stubs()
        .will(returnValue(0));
    ret = AicpuScheduleInterface::GetInstance().InitAICPUScheduler(deviceVec, 0, ch, (ProfilingMode)0,
                                                                   0, true, SCHED_MODE_INTERRUPT);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
}

TEST_F(AICPUScheduleTEST, UpdateProfilingModeTest) {
    int ret = UpdateProfilingMode(0, 0, 1);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
}

TEST_F(AICPUScheduleTEST, ProcessEventTest) {
    event_info eventInfo = g_event;
    eventInfo.comm.event_id = EVENT_DVPP_MSG;
    int ret = AicpuEventManager::GetInstance().ProcessEvent(eventInfo, 0);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);

    eventInfo.comm.event_id = EVENT_FR_MSG;
    ret = AicpuEventManager::GetInstance().ProcessEvent(eventInfo, 0);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);

    eventInfo.comm.event_id = EVENT_RANDOM_KERNEL;
    ret = AicpuEventManager::GetInstance().ProcessEvent(eventInfo, 0);
    EXPECT_EQ(ret, AICPU_SCHEDULE_FAIL);

    eventInfo.comm.event_id = EVENT_QUEUE_ENQUEUE;
    ret = AicpuEventManager::GetInstance().ProcessEvent(eventInfo, 0);
    EXPECT_EQ(ret, 1);

    MOCKER_CPP(&AicpuEventProcess::ProcessAICPUEvent)
        .stubs()
        .will(returnValue(0));
    eventInfo.comm.event_id = EVENT_AICPU_MSG;
    ret = AicpuEventManager::GetInstance().ProcessEvent(eventInfo, 0);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);

    eventInfo.comm.event_id = EVENT_TDT_ENQUEUE;
    ret = AicpuEventManager::GetInstance().ProcessEvent(eventInfo, 0);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);

    // MOCKER_CPP(&AicpuEventManager::ProcessCdqEvent)
    //     .stubs()
    //     .will(returnValue(0));
    // eventInfo.comm.event_id = EVENT_CDQ_MSG;
    // ret = AicpuEventManager::GetInstance().ProcessEvent(eventInfo, 0);
    // EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
}

TEST_F(AICPUScheduleTEST, ProcessEventTest02) {
    event_info eventInfo = g_event;
    eventInfo.comm.event_id = EVENT_TS_HWTS_KERNEL;
    MOCKER_CPP(&MessageQueue::SendResponse).stubs();
    int ret = AicpuEventManager::GetInstance().ProcessEvent(eventInfo, 0);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);

    eventInfo.comm.event_id = EVENT_TS_CTRL_MSG;
    ret = AicpuEventManager::GetInstance().ProcessEvent(eventInfo, 0);
    EXPECT_NE(ret, AICPU_SCHEDULE_OK);
}

TEST_F(AICPUScheduleTEST, ProcessEventTest2) {
    MOCKER_CPP(&AicpuEventProcess::ProcessAICPUEvent)
        .stubs()
        .will(returnValue(0));
    MOCKER_CPP(&AicpuQueueEventProcess::ProcessQsMsg)
        .stubs()
        .will(returnValue(0));
    MOCKER_CPP(&AicpuQueueEventProcess::ProcessDrvMsg)
        .stubs()
        .will(returnValue(0));
    MOCKER_CPP(&MessageQueue::SendResponse).stubs();
    // MOCKER_CPP(&AicpuEventManager::ProcessCdqEvent)
    //     .stubs()
    //     .will(returnValue(0));

    event_info eventInfo = g_event;
    eventInfo.comm.event_id = EVENT_DVPP_MPI_MSG;
    std::cout << "AICPUScheduleTEST EVENT_DVPP_MPI_MSG" << std::endl;
    auto ret = AicpuEventManager::GetInstance().ProcessEvent(eventInfo, 0);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);

    eventInfo.comm.event_id = EVENT_SPLIT_KERNEL;
    std::cout << "AICPUScheduleTEST EVENT_SPLIT_KERNEL" << std::endl;
    ret = AicpuEventManager::GetInstance().ProcessEvent(eventInfo, 0);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);

    eventInfo.comm.event_id = EVENT_QUEUE_EMPTY_TO_NOT_EMPTY;
    eventInfo.comm.subevent_id = 1;
    std::cout << "AICPUScheduleTEST EVENT_QUEUE_EMPTY_TO_NOT_EMPTY" << std::endl;
    ret = AicpuEventManager::GetInstance().ProcessEvent(eventInfo, 0);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);

    eventInfo.comm.event_id = EVENT_QUEUE_FULL_TO_NOT_FULL;
    eventInfo.comm.subevent_id = 1;
    std::cout << "AICPUScheduleTEST EVENT_QUEUE_FULL_TO_NOT_FULL" << std::endl;
    ret = AicpuEventManager::GetInstance().ProcessEvent(eventInfo, 0);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);

    eventInfo.comm.event_id = EVENT_ACPU_MSG_TYPE1;
    std::cout << "AICPUScheduleTEST EVENT_ACPU_MSG_TYPE1" << std::endl;
    ret = AicpuEventManager::GetInstance().ProcessEvent(eventInfo, 0);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);

    // eventInfo.comm.event_id = EVENT_CDQ_MSG;
    // std::cout << "AICPUScheduleTEST EVENT_CDQ_MSG" << std::endl;
    // ret = AicpuEventManager::GetInstance().ProcessEvent(eventInfo, 0);
    // EXPECT_EQ(ret, AICPU_SCHEDULE_OK);

    eventInfo.comm.event_id = EVENT_QS_MSG;
    std::cout << "AICPUScheduleTEST EVENT_QS_MSG" << std::endl;
    ret = AicpuEventManager::GetInstance().ProcessEvent(eventInfo, 0);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);

    eventInfo.comm.event_id = EVENT_DRV_MSG;
    std::cout << "AICPUScheduleTEST EVENT_DRV_MSG" << std::endl;
    ret = AicpuEventManager::GetInstance().ProcessEvent(eventInfo, 0);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);

    eventInfo.comm.event_id = EVENT_TIMER;
    std::cout << "AICPUScheduleTEST EVENT_TIMER" << std::endl;
    ret = AicpuEventManager::GetInstance().ProcessEvent(eventInfo, 0);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_NOT_FOUND_EVENT);

    eventInfo.comm.event_id = EVENT_MAX_NUM;
    std::cout << "AICPUScheduleTEST EVENT_MAX_NUM" << std::endl;
    ret = AicpuEventManager::GetInstance().ProcessEvent(eventInfo, 0);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_NOT_FOUND_EVENT);
}

TEST_F(AICPUScheduleTEST, DumpDataSeccTEST) {
    MOCKER_CPP(&AicpuSdCustDumpProcess::InitCustDumpProcess).stubs().will(returnValue(0));
    const uint32_t taskId = 11;
    const uint32_t streamId = 1;
    const uint32_t modelId = 22;
    const int32_t dataType = 3;
    aicpu::dump::OpMappingInfo opMappingInfo;

    opMappingInfo.set_dump_path("dump_path");
    opMappingInfo.set_model_name("model_n a.m\\ /e");
    opMappingInfo.set_model_id(modelId);

    uint64_t stepId = 1;
    uint64_t iterationsPerLoop = 1;
    uint64_t loopCond = 1;
    opMappingInfo.set_step_id_addr(reinterpret_cast<uint64_t>(&stepId));
    opMappingInfo.set_iterations_per_loop_addr(reinterpret_cast<uint64_t>(&iterationsPerLoop));
    opMappingInfo.set_loop_cond_addr(reinterpret_cast<uint64_t>(&loopCond));

    opMappingInfo.set_flag(0x01);
    aicpu::dump::Task *task = opMappingInfo.add_task();
    task->set_task_id(taskId);
    task->set_stream_id(streamId);
    task->set_context_id(INVALID_VAL);

    aicpu::dump::Op *op = task->mutable_op();
    op->set_op_name("op_n a.m\\ /e");
    op->set_op_type("op_t y.p\\e/ rr");

    aicpu::dump::Output *output = task->add_output();
    aicpu::dump::DimRange *dimRange = output->add_dim_range();
    dimRange->set_dim_start(1);
    dimRange->set_dim_end(2);

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

    aicpu::dump::Output *output1 = task->add_output();
    output1->set_data_type(dataType);
    output1->set_format(1);
    RuntimeTensorDesc tensorDesc;
    int32_t data2[4] = {1, 2, 3, 4};
    int *p2 = &data2[0];
    tensorDesc.dataAddr = static_cast<uint64_t>(reinterpret_cast<uintptr_t>(p2));
    tensorDesc.shape[0] = 2;
    tensorDesc.shape[1] = 2;
    tensorDesc.shape[2] = 2;
    tensorDesc.originalShape[0] = 2;
    tensorDesc.originalShape[1] = 2;
    tensorDesc.originalShape[2] = 2;
    tensorDesc.dtype = dataType;
    aicpu::dump::Shape *shape1 = output1->mutable_shape();
    shape1->add_dim(-1);
    shape1->add_dim(2);
    RuntimeTensorDesc *descp = &tensorDesc;
    output1->set_address(reinterpret_cast<uint64_t>(&descp));
    output1->set_size(sizeof(data2));
    output1->set_addr_type(aicpu::dump::AddressType::NOTILING_ADDR); // aicpu::dump::AddressType::NOTILING_ADDR

    aicpu::dump::OpBuffer *opBuffer = task->add_buffer();
    opBuffer->set_buffer_type(aicpu::dump::BufferType::L1);
    opBuffer->set_address(uint64_t(p));
    opBuffer->set_size(sizeof(data));

    aicpu::dump::Input *input = task->add_input();
    input->set_data_type(dataType);
    input->set_format(1);
    RuntimeTensorDesc inputDesc;
    int32_t inData[4] = {10, 20, 30, 40};
    int32_t *q = &inData[0];
    inputDesc.dataAddr = static_cast<uint64_t>(reinterpret_cast<uintptr_t>(q));
    inputDesc.shape[0] = 2;
    inputDesc.shape[1] = 2;
    inputDesc.shape[2] = 2;
    inputDesc.originalShape[0] = 2;
    inputDesc.originalShape[1] = 2;
    inputDesc.originalShape[2] = 2;
    inputDesc.dtype = dataType;
    aicpu::dump::Shape *inShape = input->mutable_shape();
    inShape->add_dim(-1);
    inShape->add_dim(2);
    RuntimeTensorDesc *descp2 = &inputDesc;
    input->set_address(reinterpret_cast<uint64_t>(&descp2));
    input->set_size(sizeof(inData));
    input->set_addr_type(aicpu::dump::AddressType::NOTILING_ADDR); // aicpu::dump::AddressType::NOTILING_ADDR

    // std::cout << "total size: " << opMappingInfo.ByteSize() <<std::endl;
    std::string opMappingInfoStr;
    opMappingInfo.SerializeToString(&opMappingInfoStr);

    // load op mapping info
    EXPECT_EQ(LoadOpMappingInfo(opMappingInfoStr.c_str(), opMappingInfoStr.length()), AICPU_SCHEDULE_OK);
    TsAicpuSqe eventMsgDumpData = {0};
    eventMsgDumpData.pid = 0x1112;
    eventMsgDumpData.cmd_type = AICPU_DATADUMP_REPORT;
    eventMsgDumpData.vf_id = 0;
    eventMsgDumpData.tid = 0x10001;
    eventMsgDumpData.u.ts_to_aicpu_datadump.model_id = 10;
    eventMsgDumpData.u.ts_to_aicpu_datadump.stream_id = streamId;
    eventMsgDumpData.u.ts_to_aicpu_datadump.task_id = taskId;
    OpDumpTaskManager &opDumpTaskMgr = OpDumpTaskManager::GetInstance();
    EXPECT_EQ(opDumpTaskMgr.DumpOpInfo(streamId, taskId), AICPU_SCHEDULE_OK);
    AicpuSqeAdapter adapter(eventMsgDumpData, 0U);
    auto ret = AicpuEventProcess::GetInstance().ProcessDumpDataEvent(adapter);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);

    // load op mapping info twice
    EXPECT_EQ(LoadOpMappingInfo(opMappingInfoStr.c_str(), opMappingInfoStr.length()), AICPU_SCHEDULE_OK);
    // unload model
    opMappingInfo.set_flag(0x00);
    opMappingInfo.SerializeToString(&opMappingInfoStr);
    EXPECT_EQ(LoadOpMappingInfo(opMappingInfoStr.c_str(), opMappingInfoStr.length()), AICPU_SCHEDULE_OK);

    // load op mapping info
    opMappingInfo.set_flag(0x01);
    opMappingInfo.SerializeToString(&opMappingInfoStr);
    TsAicpuSqe eventMsgLoadOpMappingInfo = {0};
    eventMsgLoadOpMappingInfo.pid = 0x1111;
    eventMsgLoadOpMappingInfo.cmd_type = AICPU_DATADUMP_LOADINFO;
    eventMsgLoadOpMappingInfo.vf_id = 0;
    eventMsgLoadOpMappingInfo.tid = 0x10000;
    eventMsgLoadOpMappingInfo.u.ts_to_aicpu_datadumploadinfo.dumpinfoPtr = (uint64_t)opMappingInfoStr.c_str();
    eventMsgLoadOpMappingInfo.u.ts_to_aicpu_datadumploadinfo.length = opMappingInfoStr.length();
    eventMsgLoadOpMappingInfo.u.ts_to_aicpu_datadumploadinfo.stream_id = 10;
    eventMsgLoadOpMappingInfo.u.ts_to_aicpu_datadumploadinfo.task_id = 10;
    AicpuSqeAdapter adapter1(eventMsgLoadOpMappingInfo, 0U);
    EXPECT_EQ(LoadOpMappingInfo(opMappingInfoStr.c_str(), opMappingInfoStr.length()), AICPU_SCHEDULE_OK);
    ret = AicpuEventProcess::GetInstance().ProcessLoadOpMappingEvent(adapter1);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);

    // set demp step
    opMappingInfo.set_flag(0x01);
    opMappingInfo.set_dump_step("0|2-1");
    opMappingInfo.SerializeToString(&opMappingInfoStr);
    EXPECT_EQ(LoadOpMappingInfo(opMappingInfoStr.c_str(), opMappingInfoStr.length()), AICPU_SCHEDULE_OK);
    EXPECT_EQ(opDumpTaskMgr.DumpOpInfo(streamId, taskId), AICPU_SCHEDULE_OK);
    ret = AicpuEventProcess::GetInstance().ProcessDumpDataEvent(adapter);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);

    // set end graph task
    task->set_end_graph(true);
    opMappingInfo.SerializeToString(&opMappingInfoStr);
    EXPECT_EQ(LoadOpMappingInfo(opMappingInfoStr.c_str(), opMappingInfoStr.length()), AICPU_SCHEDULE_OK);
    EXPECT_EQ(opDumpTaskMgr.DumpOpInfo(streamId, taskId), AICPU_SCHEDULE_OK);
    ret = AicpuEventProcess::GetInstance().ProcessDumpDataEvent(adapter);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);

    task->set_task_id(65536U);
    opMappingInfo.SerializeToString(&opMappingInfoStr);
    EXPECT_EQ(opDumpTaskMgr.LoadOpMappingInfo(opMappingInfoStr.c_str(), opMappingInfoStr.length()),
        AICPU_SCHEDULE_OK);
}

TEST_F(AICPUScheduleTEST, DumpDataFailTEST) {
    const uint32_t taskId = 111;
    const uint32_t streamId = 1;
    const uint32_t modelId = 222;

    const int32_t dataType = 7; // int32
    aicpu::dump::OpMappingInfo opMappingInfo;

    opMappingInfo.set_dump_path("dump_path");
    opMappingInfo.set_model_name("model_n a.m\\ /e");
    opMappingInfo.set_model_id(modelId);
    opMappingInfo.set_flag(0x01);
    aicpu::dump::Task *task = opMappingInfo.add_task();
    task->set_task_id(taskId);
    task->set_stream_id(streamId);
    task->set_context_id(INVALID_VAL);

    aicpu::dump::Op *op = task->mutable_op();
    op->set_op_name("op_n a.m\\ /e");
    op->set_op_type("op_t y.p\\e/ rr");

    aicpu::dump::Output *output = task->add_output();
    output->set_data_type(dataType);
    output->set_format(1);
    aicpu::dump::Shape *shape = output->mutable_shape();
    shape->add_dim(2);
    shape->add_dim(2);
    aicpu::dump::Shape *originShape = output->mutable_origin_shape();
    originShape->add_dim(2);
    originShape->add_dim(2);
    int32_t data[4] = {1, 2, 3, 4};
    int32_t *p = &data[0];
    output->set_address(reinterpret_cast<uint64_t>(&p));
    output->set_original_name("original_name");
    output->set_original_output_index(11);
    output->set_original_output_data_type(dataType);
    output->set_original_output_format(1);
    output->set_size(sizeof(data));

    aicpu::dump::Input *input = task->add_input();
    input->set_data_type(dataType);
    input->set_format(1);
    aicpu::dump::Shape *inShape = input->mutable_shape();
    inShape->add_dim(2);
    inShape->add_dim(2);
    aicpu::dump::Shape *inputOriginShape = input->mutable_origin_shape();
    inputOriginShape->add_dim(2);
    inputOriginShape->add_dim(2);
    int32_t inData[4] = {10, 20, 30, 40};
    input->set_address(reinterpret_cast<uint64_t>(&p));
    input->set_size(sizeof(inData));

    std::string opMappingInfoStr;
    opMappingInfo.SerializeToString(&opMappingInfoStr);

    int32_t ret = 0;
    // load op mapping info
    LoadOpMappingInfo(opMappingInfoStr.c_str(), opMappingInfoStr.length());
    OpDumpTaskManager &opDumpTaskMgr = OpDumpTaskManager::GetInstance();

    // task not exist
    EXPECT_EQ(opDumpTaskMgr.DumpOpInfo(streamId, taskId + 1), AICPU_SCHEDULE_OK);

    // op mapping info is nullptr
    EXPECT_EQ(LoadOpMappingInfo(nullptr, 1), AICPU_SCHEDULE_ERROR_DUMP_FAILED);
    // op mapping info parse fail
    EXPECT_EQ(LoadOpMappingInfo(opMappingInfoStr.c_str(), 1), AICPU_SCHEDULE_ERROR_DUMP_FAILED);

    // loop cond addr is null
    output->set_data_type(dataType);
    uint64_t stepId = 1;
    uint64_t iterationsPerLoop = 1;
    opMappingInfo.set_step_id_addr(reinterpret_cast<uint64_t>(&stepId));
    opMappingInfo.set_iterations_per_loop_addr(reinterpret_cast<uint64_t>(&iterationsPerLoop));
    opMappingInfo.set_loop_cond_addr(0LLU);
    opMappingInfo.SerializeToString(&opMappingInfoStr);
    EXPECT_EQ(opDumpTaskMgr.LoadOpMappingInfo(opMappingInfoStr.c_str(), opMappingInfoStr.length()),
        AICPU_SCHEDULE_OK);
    EXPECT_EQ(opDumpTaskMgr.DumpOpInfo(streamId, taskId), AICPU_SCHEDULE_ERROR_DUMP_FAILED);

    // invalied dump step
    opMappingInfo.set_dump_step("1000000000000000000000000000000000000000000000000000000000000");
    opMappingInfo.SerializeToString(&opMappingInfoStr);
    EXPECT_EQ(opDumpTaskMgr.LoadOpMappingInfo(opMappingInfoStr.c_str(), opMappingInfoStr.length()),
        AICPU_SCHEDULE_ERROR_DUMP_FAILED);

    // unload model
    opMappingInfo.set_flag(0x00);
    opMappingInfo.SerializeToString(&opMappingInfoStr);
    LoadOpMappingInfo(opMappingInfoStr.c_str(), opMappingInfoStr.length());
    std::shared_ptr<OpDumpTask> opDumpTaskPtr = nullptr;
    opDumpTaskPtr = std::make_shared<OpDumpTask>(0, 0);
    MappingInfoOptionalParam param;
    DumpStep dumpStep;
    opDumpTaskPtr->PreProcessOpMappingInfo(*task, "", param, dumpStep, DumpMode::TENSOR_DUMP_DATA);
}

int tsDevSendMsgAsyncDataDumpStub(unsigned int devId, unsigned int tsId, char *msg, unsigned int msgLen,
                                  unsigned int handleId) {

    TsAicpuSqe *rsp = reinterpret_cast<TsAicpuSqe *>(msg);
    const uint16_t dumpRet = rsp->u.aicpu_dump_resp.result_code;
    EXPECT_EQ(dumpRet, AICPU_SCHEDULE_ERROR_DUMP_FAILED);

    return 0;
}

TEST_F(AICPUScheduleTEST, DumpDataFailedByInvalidStreamId) {
    TsAicpuSqe eventMsgDumpData = {0};
    eventMsgDumpData.pid = 0x1112;
    eventMsgDumpData.cmd_type = AICPU_DATADUMP_REPORT;
    eventMsgDumpData.vf_id = 0;
    eventMsgDumpData.tid = 0x10001;
    eventMsgDumpData.u.ts_to_aicpu_datadump.model_id = 10;
    eventMsgDumpData.u.ts_to_aicpu_datadump.stream_id = INVALID_VAL;
    eventMsgDumpData.u.ts_to_aicpu_datadump.task_id = 2;
    eventMsgDumpData.u.ts_to_aicpu_datadump.stream_id1 = INVALID_VAL;
    eventMsgDumpData.u.ts_to_aicpu_datadump.task_id1 = 2;
    MOCKER(tsDevSendMsgAsync).stubs().will(invoke(tsDevSendMsgAsyncSuccess));
    AicpuSqeAdapter ada(eventMsgDumpData, 0U);
    const auto ret = AicpuEventProcess::GetInstance().ProcessDumpDataEvent(ada);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
}

TEST_F(AICPUScheduleTEST, DumpDataFailedByInvalidTaskId) {
    TsAicpuSqe eventMsgDumpData = {0};
    eventMsgDumpData.pid = 0x1112;
    eventMsgDumpData.cmd_type = AICPU_DATADUMP_REPORT;
    eventMsgDumpData.vf_id = 0;
    eventMsgDumpData.tid = 0x10001;
    eventMsgDumpData.u.ts_to_aicpu_datadump.model_id = 10;
    eventMsgDumpData.u.ts_to_aicpu_datadump.stream_id = 2;
    eventMsgDumpData.u.ts_to_aicpu_datadump.task_id = INVALID_VAL;
    eventMsgDumpData.u.ts_to_aicpu_datadump.stream_id1 = 2;
    eventMsgDumpData.u.ts_to_aicpu_datadump.task_id1 = INVALID_VAL;
    MOCKER(tsDevSendMsgAsync).stubs().will(invoke(tsDevSendMsgAsyncSuccess));
    AicpuSqeAdapter ada(eventMsgDumpData, 0U);
    const auto ret = AicpuEventProcess::GetInstance().ProcessDumpDataEvent(ada);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
}

TEST_F(AICPUScheduleTEST, DumpDataFailedByInvalidModelId) {
    TsAicpuSqe eventMsgDumpData = {0};
    eventMsgDumpData.pid = 0x1112;
    eventMsgDumpData.cmd_type = AICPU_DATADUMP_REPORT;
    eventMsgDumpData.vf_id = 0;
    eventMsgDumpData.tid = 0x10001;
    eventMsgDumpData.u.ts_to_aicpu_datadump.model_id = INVALID_VAL;
    eventMsgDumpData.u.ts_to_aicpu_datadump.stream_id = 2;
    eventMsgDumpData.u.ts_to_aicpu_datadump.task_id = INVALID_VAL;
    eventMsgDumpData.u.ts_to_aicpu_datadump.stream_id1 = 2;
    eventMsgDumpData.u.ts_to_aicpu_datadump.task_id1 = 2;
    MOCKER(tsDevSendMsgAsync).stubs().will(invoke(tsDevSendMsgAsyncSuccess));
    AicpuSqeAdapter ada(eventMsgDumpData, 0U);
    const auto ret = AicpuEventProcess::GetInstance().ProcessDumpDataEvent(ada);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
}

TEST_F(AICPUScheduleTEST, DumpFftsDataFailedByInvalidStreamId) {
    TsAicpuSqe eventMsgDumpData = {0};
    eventMsgDumpData.pid = 0x1112;
    eventMsgDumpData.cmd_type = AICPU_DATADUMP_REPORT;
    eventMsgDumpData.vf_id = 0;
    eventMsgDumpData.tid = 0x10001;
    eventMsgDumpData.u.ts_to_aicpu_datadump.model_id = 10;
    eventMsgDumpData.u.ts_to_aicpu_datadump.stream_id = INVALID_VAL;
    eventMsgDumpData.u.ts_to_aicpu_datadump.task_id = 2;
    eventMsgDumpData.u.ts_to_aicpu_datadump.stream_id1 = INVALID_VAL;
    eventMsgDumpData.u.ts_to_aicpu_datadump.task_id1 = 2;
    MOCKER(tsDevSendMsgAsync).stubs().will(invoke(tsDevSendMsgAsyncDataDumpStub));
    AicpuSqeAdapter ada(eventMsgDumpData, 0U);
    const auto ret = AicpuEventProcess::GetInstance().ProcessDumpFFTSPlusDataEvent(ada);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
}

TEST_F(AICPUScheduleTEST, DumpFftsDataFailedByInvalidTaskId) {
    TsAicpuSqe eventMsgDumpData = {0};
    eventMsgDumpData.pid = 0x1112;
    eventMsgDumpData.cmd_type = AICPU_DATADUMP_REPORT;
    eventMsgDumpData.vf_id = 0;
    eventMsgDumpData.tid = 0x10001;
    eventMsgDumpData.u.ts_to_aicpu_datadump.model_id = 10;
    eventMsgDumpData.u.ts_to_aicpu_datadump.stream_id = 2;
    eventMsgDumpData.u.ts_to_aicpu_datadump.task_id = INVALID_VAL;
    eventMsgDumpData.u.ts_to_aicpu_datadump.stream_id1 = 2;
    eventMsgDumpData.u.ts_to_aicpu_datadump.task_id1 = INVALID_VAL;
    AicpuSqeAdapter ada(eventMsgDumpData, 0U);
    MOCKER(tsDevSendMsgAsync).stubs().will(invoke(tsDevSendMsgAsyncDataDumpStub));
    const auto ret = AicpuEventProcess::GetInstance().ProcessDumpFFTSPlusDataEvent(ada);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
}

TEST_F(AICPUScheduleTEST, DumpDebugInfoTEST) {
    const uint32_t taskId = 333;
    const uint32_t streamId = 3;
    const uint32_t modelId = 33;
    const int32_t dataType = 3;
    aicpu::dump::OpMappingInfo opMappingInfo;

    opMappingInfo.set_dump_path("dump_path");
    opMappingInfo.set_model_name("model_debug");
    opMappingInfo.set_model_id(modelId);

    uint64_t stepId = 1;
    uint64_t iterationsPerLoop = 1;
    uint64_t loopCond = 1;
    opMappingInfo.set_step_id_addr(reinterpret_cast<uint64_t>(&stepId));
    opMappingInfo.set_iterations_per_loop_addr(reinterpret_cast<uint64_t>(&iterationsPerLoop));
    opMappingInfo.set_loop_cond_addr(reinterpret_cast<uint64_t>(&loopCond));

    opMappingInfo.set_flag(0x01);
    aicpu::dump::Task *task = opMappingInfo.add_task();
    task->set_task_id(taskId);
    task->set_stream_id(streamId);
    task->set_context_id(INVALID_VAL);

    aicpu::dump::Op *op = task->mutable_op();
    op->set_op_name("op_name_debug");
    op->set_op_type("op_type_debug");

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

    // load op mapping info
    EXPECT_EQ(LoadOpMappingInfo(opMappingInfoStr.c_str(), opMappingInfoStr.length()), AICPU_SCHEDULE_OK);

    OpDumpTaskManager &opDumpTaskMgr = OpDumpTaskManager::GetInstance();
    EXPECT_EQ(opDumpTaskMgr.DumpOpInfo(streamId, taskId, INVALID_VAL, INVALID_VAL), AICPU_SCHEDULE_OK);
}

TEST_F(AICPUScheduleTEST, ProcessDumpPath) {
  OpDumpTask task(0, 0);
  task.optionalParam_.hasModelId = true;
  AicpuModel *aicpuModel = new AicpuModel();
  MOCKER_CPP(&AicpuModelManager::GetModel).stubs().will(returnValue(aicpuModel));
  DumpFileName dumpFileName(0, 0);
  EXPECT_EQ(task.DumpPath(0, 0, dumpFileName, false).empty(), false);
  delete aicpuModel;
  aicpuModel = nullptr;
}

TEST_F(AICPUScheduleTEST, FftsPlusDumpDataFailTEST) {
    const uint32_t taskId = 111;
    const uint32_t streamId = 1;
    const uint32_t modelId = 222;

    const int32_t dataType = 7; // int32
    aicpu::dump::OpMappingInfo opMappingInfo;

    opMappingInfo.set_dump_path("dump_path");
    opMappingInfo.set_model_name("model_n a.m\\ /e");
    opMappingInfo.set_model_id(modelId);
    opMappingInfo.set_flag(0x01);
    aicpu::dump::Task *task = opMappingInfo.add_task();
    task->set_task_id(taskId);
    task->set_stream_id(streamId);
    task->set_context_id(0);
    task->set_tasktype(aicpu::dump::Task::FFTSPLUS);

    aicpu::dump::Op *op = task->mutable_op();
    op->set_op_name("op_n a.m\\ /e");
    op->set_op_type("op_t y.p\\e/ rr");
    aicpu::dump::OpAttr *opAttr = task->add_attr();
    opAttr->set_name("name");
    opAttr->set_value("value");

    aicpu::dump::Output *output = task->add_output();
    output->set_data_type(dataType);
    output->set_format(1);
    aicpu::dump::Shape *shape = output->mutable_shape();
    shape->add_dim(2);
    shape->add_dim(2);
    aicpu::dump::Shape *originShape = output->mutable_origin_shape();
    originShape->add_dim(2);
    originShape->add_dim(2);
    int32_t data[4] = {1, 2, 3, 4};
    int32_t *p = &data[0];
    output->set_address(reinterpret_cast<uint64_t>(&p));
    output->set_original_name("original_name");
    output->set_original_output_index(11);
    output->set_original_output_data_type(dataType);
    output->set_original_output_format(1);
    output->set_size(sizeof(data));

    aicpu::dump::Input *input = task->add_input();
    input->set_data_type(dataType);
    input->set_format(1);
    aicpu::dump::Shape *inShape = input->mutable_shape();
    inShape->add_dim(2);
    inShape->add_dim(2);
    aicpu::dump::Shape *inputOriginShape = input->mutable_origin_shape();
    inputOriginShape->add_dim(2);
    inputOriginShape->add_dim(2);
    int32_t inData[4] = {10, 20, 30, 40};
    input->set_address(reinterpret_cast<uint64_t>(&p));
    input->set_size(sizeof(inData));

    std::string opMappingInfoStr;
    opMappingInfo.SerializeToString(&opMappingInfoStr);

    int32_t ret = 0;
    // load op mapping info
    OpDumpTaskManager &opDumpTaskMgr = OpDumpTaskManager::GetInstance();

    // task not exist
    EXPECT_EQ(opDumpTaskMgr.DumpOpInfo(streamId, taskId + 1), AICPU_SCHEDULE_OK);
    opDumpTaskMgr.LoadOpMappingInfo(opMappingInfoStr.c_str(), opMappingInfoStr.length());
    // op mapping info is nullptr
    EXPECT_EQ(opDumpTaskMgr.LoadOpMappingInfo(nullptr, 1), AICPU_SCHEDULE_ERROR_DUMP_FAILED);
    // op mapping info parse fail
    EXPECT_EQ(opDumpTaskMgr.LoadOpMappingInfo(opMappingInfoStr.c_str(), 1), AICPU_SCHEDULE_ERROR_DUMP_FAILED);

    // loop cond addr is null
    output->set_data_type(dataType);
    uint64_t stepId = 1;
    uint64_t iterationsPerLoop = 1;
    opMappingInfo.set_step_id_addr(reinterpret_cast<uint64_t>(&stepId));
    opMappingInfo.set_iterations_per_loop_addr(reinterpret_cast<uint64_t>(&iterationsPerLoop));
    opMappingInfo.set_loop_cond_addr(0LLU);
    opMappingInfo.SerializeToString(&opMappingInfoStr);
    EXPECT_EQ(opDumpTaskMgr.LoadOpMappingInfo(opMappingInfoStr.c_str(), opMappingInfoStr.length()),
        AICPU_SCHEDULE_OK);
    TaskInfoExt dumpTaskInfo;
    dumpTaskInfo.streamId_ = streamId;
    dumpTaskInfo.taskId_ = taskId;
    dumpTaskInfo.contextId_ = 0;
    dumpTaskInfo.threadId_ = 0;
    DumpFileName name(dumpTaskInfo.streamId_, dumpTaskInfo.taskId_, dumpTaskInfo.contextId_, dumpTaskInfo.threadId_);
    EXPECT_EQ(opDumpTaskMgr.DumpOpInfo(dumpTaskInfo, name), AICPU_SCHEDULE_OK);

    // invalied dump step
    opMappingInfo.set_dump_step("1000000000000000000000000000000000000000000000000000000000000");
    opMappingInfo.SerializeToString(&opMappingInfoStr);
    EXPECT_EQ(opDumpTaskMgr.DumpOpInfo(dumpTaskInfo, name),
        AICPU_SCHEDULE_OK);

    // unload model
    opMappingInfo.set_flag(0x00);
    opMappingInfo.SerializeToString(&opMappingInfoStr);
    opDumpTaskMgr.LoadOpMappingInfo(opMappingInfoStr.c_str(), opMappingInfoStr.length());
}

TEST_F(AICPUScheduleTEST, FftsPlusDumpDebugInfoTEST) {
    const uint32_t taskId = 333;
    const uint32_t streamId = 3;
    const uint32_t modelId = 33;
    const int32_t dataType = 3;
    aicpu::dump::OpMappingInfo opMappingInfo;

    opMappingInfo.set_dump_path("dump_path");
    opMappingInfo.set_model_name("model_debug");
    opMappingInfo.set_model_id(modelId);

    uint64_t stepId = 1;
    uint64_t iterationsPerLoop = 1;
    uint64_t loopCond = 1;
    opMappingInfo.set_step_id_addr(reinterpret_cast<uint64_t>(&stepId));
    opMappingInfo.set_iterations_per_loop_addr(reinterpret_cast<uint64_t>(&iterationsPerLoop));
    opMappingInfo.set_loop_cond_addr(reinterpret_cast<uint64_t>(&loopCond));

    opMappingInfo.set_flag(0x01);
    aicpu::dump::Task *task = opMappingInfo.add_task();
    task->set_task_id(taskId);
    task->set_stream_id(streamId);
    task->set_context_id(0);
    task->set_tasktype(aicpu::dump::Task::FFTSPLUS);

    aicpu::dump::Op *op = task->mutable_op();
    op->set_op_name("op_name_debug");
    op->set_op_type("op_type_debug");

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
    aicpu::dump::Context *context = task->add_context();
    addPreProcessFFTSPLUSContext(task, context);
    std::string opMappingInfoStr;
    opMappingInfo.SerializeToString(&opMappingInfoStr);



    OpDumpTaskManager &opDumpTaskMgr = OpDumpTaskManager::GetInstance();
    // load op mapping info
    EXPECT_EQ(opDumpTaskMgr.LoadOpMappingInfo(opMappingInfoStr.c_str(), opMappingInfoStr.length()), AICPU_SCHEDULE_OK);
    TaskInfoExt dumpTaskInfo;
    dumpTaskInfo.streamId_ = streamId;
    dumpTaskInfo.taskId_ = taskId;
    dumpTaskInfo.contextId_ = 0;
    dumpTaskInfo.threadId_ = 0;
    DumpFileName dumpFileName(0, 0);
    EXPECT_EQ(opDumpTaskMgr.DumpOpInfo(dumpTaskInfo, dumpFileName), AICPU_SCHEDULE_OK);

    TsAicpuSqe eventMsgDumpData = {0};
    eventMsgDumpData.pid = 0x1112;
    eventMsgDumpData.cmd_type = AICPU_DATADUMP_REPORT;
    eventMsgDumpData.vf_id = 0;
    eventMsgDumpData.tid = 0x10001;
    eventMsgDumpData.u.ts_to_aicpu_ffts_plus_datadump.model_id = 222;
    eventMsgDumpData.u.ts_to_aicpu_ffts_plus_datadump.stream_id = streamId+1;
    eventMsgDumpData.u.ts_to_aicpu_ffts_plus_datadump.task_id = taskId+1;
    eventMsgDumpData.u.ts_to_aicpu_ffts_plus_datadump.stream_id1 = streamId+1;
    eventMsgDumpData.u.ts_to_aicpu_ffts_plus_datadump.task_id1 = taskId+1;
    AicpuSqeAdapter ada(eventMsgDumpData, 0U);
    AicpuEventProcess::GetInstance().ProcessDumpFFTSPlusDataEvent(ada);
}

TEST_F(AICPUScheduleTEST, ProcessInputDump_output_with_0) {
    const uint32_t taskId = 1111;
    const uint32_t streamId = 11;
    const uint32_t modelId = 2222;

    const int32_t dataType = 7; // int32
    aicpu::dump::OpMappingInfo opMappingInfo;

    opMappingInfo.set_dump_path("/home/zhangzc/tmp/dump/");
    opMappingInfo.set_model_name("model_name_1");
    opMappingInfo.set_model_id(modelId);
    opMappingInfo.set_flag(0x01);
    aicpu::dump::Task *task = opMappingInfo.add_task();
    task->set_task_id(taskId);
    task->set_stream_id(streamId);
    task->set_context_id(INVALID_VAL);

    aicpu::dump::Op *op = task->mutable_op();
    op->set_op_name("opname_1");
    op->set_op_type("optype_1");

    // output 1
    aicpu::dump::Output *output = task->add_output();
    output->set_data_type(dataType);
    output->set_format(1);
    aicpu::dump::Shape *shape = output->mutable_shape();
    shape->add_dim(2);
    shape->add_dim(2);
    aicpu::dump::Shape *originShape = output->mutable_origin_shape();
    originShape->add_dim(2);
    originShape->add_dim(2);
    int32_t data[4] = {1, 2, 3, 4};
    int32_t *p = &data[0];
    output->set_address(reinterpret_cast<uint64_t>(&p));
    output->set_original_name("original_name");
    output->set_original_output_index(11);
    output->set_original_output_data_type(dataType);
    output->set_original_output_format(1);
    output->set_size(sizeof(data));

    // output 2
    aicpu::dump::Output *output1 = task->add_output();
    output1->set_data_type(dataType);
    output1->set_format(1);
    aicpu::dump::Shape *shape1 = output1->mutable_shape();
    shape1->add_dim(0);
    aicpu::dump::Shape *originShape1 = output1->mutable_origin_shape();
    originShape1->add_dim(0);
    output1->set_address(0ULL);
    output1->set_original_name("original_name_output2");
    output1->set_original_output_index(2);
    output1->set_original_output_data_type(dataType);
    output1->set_original_output_format(1);
    output1->set_size(0);

    // output 3
    aicpu::dump::Output *output2 = task->add_output();
    output2->set_data_type(dataType);
    output2->set_format(1);
    aicpu::dump::Shape *shape2 = output2->mutable_shape();
    shape2->add_dim(2);
    shape2->add_dim(2);
    aicpu::dump::Shape *originShape2 = output2->mutable_origin_shape();
    originShape2->add_dim(2);
    originShape2->add_dim(2);
    output2->set_address(reinterpret_cast<uint64_t>(&p));
    output2->set_original_name("original_name_out3");
    output2->set_original_output_index(3);
    output2->set_original_output_data_type(dataType);
    output2->set_original_output_format(1);
    output2->set_size(sizeof(data));

    // input 0
    aicpu::dump::Input *input = task->add_input();
    input->set_data_type(dataType);
    input->set_format(1);
    aicpu::dump::Shape *inShape = input->mutable_shape();
    inShape->add_dim(2);
    inShape->add_dim(2);
    aicpu::dump::Shape *inputOriginShape = input->mutable_origin_shape();
    inputOriginShape->add_dim(2);
    inputOriginShape->add_dim(2);
    input->set_address(reinterpret_cast<uint64_t>(&p));
    input->set_size(sizeof(data));

    // input 1
    aicpu::dump::Input *input1 = task->add_input();
    input1->set_data_type(dataType);
    input1->set_format(1);
    aicpu::dump::Shape *inShape1 = input1->mutable_shape();
    inShape1->add_dim(0);
    aicpu::dump::Shape *inputOriginShape1 = input1->mutable_origin_shape();
    inputOriginShape1->add_dim(0);
    input1->set_size(0);

    std::string opMappingInfoStr;
    opMappingInfo.SerializeToString(&opMappingInfoStr);

    int32_t ret = 0;
    // load op mapping info
    LoadOpMappingInfo(opMappingInfoStr.c_str(), opMappingInfoStr.length());
    OpDumpTaskManager &opDumpTaskMgr = OpDumpTaskManager::GetInstance();

    EXPECT_EQ(opDumpTaskMgr.DumpOpInfo(streamId, taskId), AICPU_SCHEDULE_OK);

    // unload model
    opMappingInfo.set_flag(0x00);
    opMappingInfo.SerializeToString(&opMappingInfoStr);
    LoadOpMappingInfo(opMappingInfoStr.c_str(), opMappingInfoStr.length());
}

TEST_F(AICPUScheduleTEST, ProcessInputDump_output_all_0) {
    const uint32_t taskId = 11111;
    const uint32_t streamId = 111;
    const uint32_t modelId = 22222;

    const int32_t dataType = 7; // int32
    aicpu::dump::OpMappingInfo opMappingInfo;

    opMappingInfo.set_dump_path("/home/zhangzc/tmp/dump/");
    opMappingInfo.set_model_name("model_name_1");
    opMappingInfo.set_model_id(modelId);
    opMappingInfo.set_flag(0x01);
    aicpu::dump::Task *task = opMappingInfo.add_task();
    task->set_task_id(taskId);
    task->set_stream_id(streamId);
    task->set_context_id(INVALID_VAL);

    aicpu::dump::Op *op = task->mutable_op();
    op->set_op_name("opname_1");
    op->set_op_type("optype_1");

    // output 1
    aicpu::dump::Output *output = task->add_output();
    output->set_data_type(dataType);
    output->set_format(1);
    aicpu::dump::Shape *shape = output->mutable_shape();
    shape->add_dim(0);
    aicpu::dump::Shape *originShape = output->mutable_origin_shape();
    originShape->add_dim(0);
    output->set_address(0ULL);
    output->set_original_name("original_name");
    output->set_original_output_index(11);
    output->set_original_output_data_type(dataType);
    output->set_original_output_format(1);
    output->set_size(0);

    // output 2
    aicpu::dump::Output *output1 = task->add_output();
    output1->set_data_type(dataType);
    output1->set_format(1);
    aicpu::dump::Shape *shape1 = output1->mutable_shape();
    shape1->add_dim(0);
    aicpu::dump::Shape *originShape1 = output1->mutable_origin_shape();
    originShape1->add_dim(0);
    output1->set_address(0ULL);
    output1->set_original_name("original_name_output2");
    output1->set_original_output_index(2);
    output1->set_original_output_data_type(dataType);
    output1->set_original_output_format(1);
    output1->set_size(0);

    // input 1
    aicpu::dump::Input *input1 = task->add_input();
    input1->set_data_type(dataType);
    input1->set_format(1);
    aicpu::dump::Shape *inShape1 = input1->mutable_shape();
    inShape1->add_dim(0);
    aicpu::dump::Shape *inputOriginShape1 = input1->mutable_origin_shape();
    inputOriginShape1->add_dim(0);
    input1->set_size(0);

    std::string opMappingInfoStr;
    opMappingInfo.SerializeToString(&opMappingInfoStr);

    int32_t ret = 0;
    // load op mapping info
    LoadOpMappingInfo(opMappingInfoStr.c_str(), opMappingInfoStr.length());
    OpDumpTaskManager &opDumpTaskMgr = OpDumpTaskManager::GetInstance();

    EXPECT_EQ(opDumpTaskMgr.DumpOpInfo(streamId, taskId), AICPU_SCHEDULE_OK);

    // unload model
    opMappingInfo.set_flag(0x00);
    opMappingInfo.SerializeToString(&opMappingInfoStr);
    LoadOpMappingInfo(opMappingInfoStr.c_str(), opMappingInfoStr.length());
}

TEST_F(AICPUScheduleTEST, ProcessInputDump_baseaddr_null) {
    OpDumpTask task(0, 0);
    ::toolkit::dumpdata::OpInput *opInput = task.baseDumpData_.add_input();
    if (opInput != nullptr) {
        opInput->set_size(100);
        uint64_t baseAddr = 0;
        task.inputsBaseAddr_.push_back(baseAddr);
        task.UpdateDumpData();
        EXPECT_EQ(task.ProcessInputDump(task.baseDumpData_, "", IdeDumpStart(nullptr)), AICPU_SCHEDULE_OK);
    }
}

TEST_F(AICPUScheduleTEST, ProcessOutputDump_baseaddr_null) {
    OpDumpTask task(0, 0);
    ::toolkit::dumpdata::OpOutput *opOutput = task.baseDumpData_.add_output();
    if (opOutput != nullptr) {
        opOutput->set_size(100);
        uint64_t baseAddr = 0;
        task.outputsBaseAddr_.push_back(baseAddr);
        task.UpdateDumpData();
        EXPECT_EQ(task.ProcessOutputDump(task.baseDumpData_, "", IdeDumpStart(nullptr)), AICPU_SCHEDULE_OK);
    }
}

TEST_F(AICPUScheduleTEST, ProcessInputDump_data_addr_null) {
    OpDumpTask task(0, 0);
    ::toolkit::dumpdata::OpInput *opInput = task.baseDumpData_.add_input();
    if (opInput != nullptr) {
        uint64_t addr = 0;
        opInput->set_size(1);
        task.inputsBaseAddr_.push_back((uint64_t)(&addr));
        task.inputsAddrType_.push_back(0);
        task.UpdateDumpData();
        EXPECT_EQ(task.ProcessInputDump(task.baseDumpData_, "", IdeDumpStart(nullptr)), AICPU_SCHEDULE_OK);
    }
}

TEST_F(AICPUScheduleTEST, ProcessOutputDump_data_addr_null) {
    OpDumpTask task(0, 0);
    ::toolkit::dumpdata::OpOutput *opOutput = task.baseDumpData_.add_output();
    if (opOutput != nullptr) {
        uint64_t addr = 0;
        opOutput->set_size(1);
        task.outputsBaseAddr_.push_back((uint64_t)(&addr));
        task.outputsAddrType_.push_back(0);
        task.UpdateDumpData();
        EXPECT_EQ(task.ProcessOutputDump(task.baseDumpData_, "", IdeDumpStart(nullptr)), AICPU_SCHEDULE_OK);
    }
}

TEST_F(AICPUScheduleTEST, FFTSPLUS_DumpPath_INVALID_VAL) {
    OpDumpTask task(0, 0);
    task.taskType_ = aicpu::dump::Task::FFTSPLUS;
    DumpFileName dumpFileName(1, 1, INVALID_VAL, INVALID_VAL);
    const std::string str = task.DumpPath(1, 1, dumpFileName, true);
    EXPECT_STREQ(str.c_str(), "/.Debug.1.1.1");
}

TEST_F(AICPUScheduleTEST, ProcessInputDump_invalid_threadId) {
    OpDumpTask task(0, 0);
    ::toolkit::dumpdata::OpInput *opInput = task.baseDumpData_.add_input();
    if (opInput != nullptr) {
        uint64_t addr = 1;
        opInput->set_size(1);
        task.inputsBaseAddr_.push_back((uint64_t)(&addr));
        task.inputsAddrType_.push_back(0);
        task.taskType_ = aicpu::dump::Task::FFTSPLUS;
        uint64_t offset = 1U;
        uint32_t invalidThread = INVALID_VAL + 1;
        task.inputsOffset_.push_back(offset);
        task.inputsSize_.push_back(offset * invalidThread + 1);
        task.UpdateDumpData();
        aicpu::dump::Context item;
        task.UpdatePreProcessFftsPlusInputAndOutput(item);
        item.add_input();
        item.add_output();
        task.UpdatePreProcessFftsPlusInputAndOutput(item);
        EXPECT_EQ(task.ProcessInputDump(task.baseDumpData_, "", IdeDumpStart(nullptr)), AICPU_SCHEDULE_OK);
    }
}

TEST_F(AICPUScheduleTEST, ProcessOutputDump_invalid_threadId) {
    OpDumpTask task(0, 0);
    ::toolkit::dumpdata::OpOutput *opOutput = task.baseDumpData_.add_output();
    if (opOutput != nullptr) {
        uint64_t addr = 1;
        opOutput->set_size(1);
        task.outputsBaseAddr_.push_back((uint64_t)(&addr));
        task.outputsAddrType_.push_back(0);
        task.taskType_ = aicpu::dump::Task::FFTSPLUS;
        uint64_t offset = 1U;
        uint32_t invalidThread = INVALID_VAL + 1;
        task.outputOffset_.push_back(offset);
        task.outputSize_.push_back(offset * invalidThread + 1);
        task.UpdateDumpData();
        EXPECT_EQ(task.ProcessOutputDump(task.baseDumpData_, "", IdeDumpStart(nullptr)), AICPU_SCHEDULE_ERROR_DUMP_FAILED);
    }
}

TEST_F(AICPUScheduleTEST, ProcessInputDump_memcpy_fail) {
    OpDumpTask task(0, 0);
    ::toolkit::dumpdata::OpInput *opInput = task.baseDumpData_.add_input();
    if (opInput != nullptr) {
        int32_t data = 0;
        uint64_t addr = (uint64_t)(&data);
        opInput->set_size(sizeof(data));
        task.inputsBaseAddr_.push_back((uint64_t)(&addr));
        task.inputsAddrType_.push_back(0);
        task.taskType_ = aicpu::dump::Task::AICPU;
        task.UpdateDumpData();
        EXPECT_EQ(task.ProcessInputDump(task.baseDumpData_, "", IdeDumpStart(nullptr)),
                                        AICPU_SCHEDULE_ERROR_DUMP_FAILED);
    }
}

TEST_F(AICPUScheduleTEST, ProcessOutputDump_memcpy_fail) {
    OpDumpTask task(0, 0);
    ::toolkit::dumpdata::OpOutput *opOutput = task.baseDumpData_.add_output();
    if (opOutput != nullptr) {
        int32_t data = 0;
        uint64_t addr = (uint64_t)(&data);
        opOutput->set_size(sizeof(data));
        task.outputsBaseAddr_.push_back((uint64_t)(&addr));
        task.outputsAddrType_.push_back(0);
        task.UpdateDumpData();
        EXPECT_EQ(task.ProcessOutputDump(task.baseDumpData_, "", IdeDumpStart(nullptr)),
                  AICPU_SCHEDULE_ERROR_DUMP_FAILED);
    }
}

TEST_F(AICPUScheduleTEST, ProcessInputDump_dump_fail) {
    OpDumpTask task(0, 0);
    ::toolkit::dumpdata::OpInput *opInput = task.baseDumpData_.add_input();
    if (opInput != nullptr) {
        int64_t data = 0;
        uint64_t addr = (uint64_t)(&data);
        opInput->set_size(sizeof(data));
        task.inputsBaseAddr_.push_back((uint64_t)(&addr));
        task.inputsAddrType_.push_back(0);
        task.UpdateDumpData();
        task.buffSize_ = 4;
        task.buff_.reset(new char[task.buffSize_]);
        MOCKER(IdeDumpData)
            .stubs()
            .will(returnValue(IDE_DAEMON_UNKNOW_ERROR));
        EXPECT_EQ(task.ProcessInputDump(task.baseDumpData_, "", IdeDumpStart(nullptr)),
                  AICPU_SCHEDULE_ERROR_DUMP_FAILED);
    }
}

TEST_F(AICPUScheduleTEST, ProcessOutputDump_dump_fail) {
    OpDumpTask task(0, 0);
    ::toolkit::dumpdata::OpOutput *opOutput = task.baseDumpData_.add_output();
    if (opOutput != nullptr) {
        int64_t data = 0;
        uint64_t addr = (uint64_t)(&data);
        opOutput->set_size(sizeof(data));
        task.outputsBaseAddr_.push_back((uint64_t)(&addr));
        task.outputsAddrType_.push_back(0);
        task.UpdateDumpData();
        task.buffSize_ = 4;
        task.buff_.reset(new char[task.buffSize_]);
        MOCKER(IdeDumpData)
            .stubs()
            .will(returnValue(IDE_DAEMON_UNKNOW_ERROR));
        EXPECT_EQ(task.ProcessOutputDump(task.baseDumpData_, "", IdeDumpStart(nullptr)),
                                         AICPU_SCHEDULE_ERROR_DUMP_FAILED);
    }
}

TEST_F(AICPUScheduleTEST, ProcessOutputDump_input_output_null) {
    ::toolkit::dumpdata::DumpData dumpData;
    OpDumpTask task(0, 0);
    task.baseDumpData_ = dumpData;
    EXPECT_EQ(task.DumpOpInfo(), AICPU_SCHEDULE_OK);
}

TEST_F(AICPUScheduleTEST, ProcessOutputDump_input_size_0) {
    ::toolkit::dumpdata::DumpData dumpData;
    ::toolkit::dumpdata::OpInput *opInput = dumpData.add_input();
    if (opInput != nullptr) {
        uint64_t buffSize = 0;
        opInput->set_size(buffSize);
        OpDumpTask task(0, 0);
        EXPECT_EQ(task.ProcessInputDump(dumpData, "", IdeDumpStart(nullptr)), AICPU_SCHEDULE_OK);
    }
}

TEST_F(AICPUScheduleTEST, ProcessOutputDump_output_size_0) {
    ::toolkit::dumpdata::DumpData dumpData;
    ::toolkit::dumpdata::OpOutput *opOutput = dumpData.add_output();
    if (opOutput != nullptr) {
        uint64_t buffSize = 0;
        opOutput->set_size(buffSize);
        OpDumpTask task(0, 0);
        EXPECT_EQ(task.ProcessOutputDump(dumpData, "", IdeDumpStart(nullptr)), AICPU_SCHEDULE_OK);
    }
}

TEST_F(AICPUScheduleTEST, ProcessOpWorkspaceDumpFailTes) {
    MOCKER_CPP(&IdeDumpData)
        .stubs()
        .will(returnValue(0));
    MOCKER_CPP(&IdeDumpStart)
        .stubs()
        .will(returnValue((void *)111));
    MOCKER(memcpy_s).stubs().will(returnValue(EOK));
    int32_t data[8] = {1, 2, 3, 4, 5, 6, 7 ,8};
    uint64_t data_size = sizeof(data);
    OpDumpTask task(0, 0);
    uint64_t data_addr = data;
    ::toolkit::dumpdata::Workspace *workSpace = task.baseDumpData_.add_space();
    if (workSpace != nullptr) {
        workSpace->set_size(data_size);
        task.opWorkspaceAddr_.push_back(0);
        task.buffSize_ = data_size;

        // 预期打印 [ERROR] op space[0] addr is null
        EXPECT_EQ(task.ProcessOpWorkspaceDump(task.baseDumpData_, "", IdeDumpStart(nullptr)), AICPU_SCHEDULE_OK);

        // workSpace->set_size(data_size);
        workSpace->set_size(0);
        task.buffSize_ = data_size;
        task.opWorkspaceAddr_[0] = data;
        // 预期打印 [ERROR] data size is zero
        EXPECT_EQ(task.ProcessOpWorkspaceDump(task.baseDumpData_, "", IdeDumpStart(nullptr)), AICPU_SCHEDULE_OK);
    }
}

TEST_F(AICPUScheduleTEST, ProcessOpWorkspaceDumpSuccessTest) {
    MOCKER_CPP(&IdeDumpData)
        .stubs()
        .will(returnValue(0));
    MOCKER_CPP(&IdeDumpStart)
        .stubs()
        .will(returnValue((void *)111));
    MOCKER(memcpy_s).stubs().will(returnValue(EOK));
    int32_t data[8] = {1, 2, 3, 4, 5, 6, 7 ,8};
    uint64_t data_size = sizeof(data);
    OpDumpTask task(0, 0);
    uint64_t data_addr = data;
    ::toolkit::dumpdata::Workspace *workSpace = task.baseDumpData_.add_space();
    if (workSpace != nullptr) {
        // workSpace->set_data_addr(data);
        workSpace->set_size(data_size);
        task.opWorkspaceAddr_.push_back(data_size);
        task.buffSize_ = data_size;
        // 预期无 [ERROR] 打印
        EXPECT_EQ(task.ProcessOpWorkspaceDump(task.baseDumpData_, "", IdeDumpStart(nullptr)), AICPU_SCHEDULE_OK);
    }
}

TEST_F(AICPUScheduleTEST, PreProcessWorkspaceSuccessTest) {
    MOCKER_CPP(&IdeDumpData)
        .stubs()
        .will(returnValue(0));
    MOCKER_CPP(&IdeDumpStart)
        .stubs()
        .will(returnValue((void *)111));
    MOCKER(memcpy_s).stubs().will(returnValue(EOK));
    OpDumpTask opDumpTask(0, 0);
    aicpu::dump::OpMappingInfo opMappingInfo;
    {
        const uint32_t taskId = 402;
        const uint32_t streamId = 402;
        
        int32_t input[8] = {1, 2, 3, 4, 5, 6, 7 ,8};
        int32_t *inputaddress = &input[0];
        int32_t inputSize = sizeof(input);
        int32_t inputoffset = 0;
        int32_t data[10] = {1, 2, 3, 4, 5, 6, 7 ,8, 9, 10}; // workspace
        const int32_t dataType = 7; // int32

        opMappingInfo.set_dump_path("dump_path");
        opMappingInfo.set_model_name("model_n a.m\\ /e");
        uint64_t stepId = 1;
        uint64_t iterationsPerLoop = 1;

        opMappingInfo.set_flag(0x01);
        aicpu::dump::Task *task = opMappingInfo.add_task();
        {
            task->set_task_id(taskId+1);
            task->set_stream_id(streamId+1);
            
            // input
            aicpu::dump::Input *input = task->add_input();
            {
                input->set_data_type(dataType);
                input->set_format(1);
                aicpu::dump::Shape *inShape = input->mutable_shape();
                {
                    inShape->add_dim(2);
                    inShape->add_dim(2);
                }
                input->set_address(reinterpret_cast<uint64_t>(&inputaddress));
                aicpu::dump::Shape *inputOriginShape = input->mutable_origin_shape();
                {
                    inputOriginShape->add_dim(2);
                    inputOriginShape->add_dim(2);
                }
                input->set_addr_type(0);
                input->set_size(inputSize);
                input->set_offset(inputoffset);
            }
            aicpu::dump::Op *op = task->mutable_op();
            {
                op->set_op_name("op_n a.m\\ /e");
                op->set_op_type("op_t y.p\\e/ rr");
            }
            // Workspace
            aicpu::dump::Workspace *space = task->add_space();
            {
                space->set_type(aicpu::dump::Workspace::LOG);
                //space->set_data_addr(data);
                //space->set_size(sizeof(data));
                space->set_data_addr(0); // task0 的data_addr为0
                space->set_size(sizeof(data));
            }
        }

    }
    ::toolkit::dumpdata::DumpData dumpData;
    aicpu::dump::Task task = opMappingInfo.task().at(0);
    EXPECT_EQ(opDumpTask.PreProcessWorkspace(task, dumpData), AICPU_SCHEDULE_OK);

}

TEST_F(AICPUScheduleTEST, ExecuteTsKernelTaskTest) {
    MOCKER(&aicpu::IsSupportedProfData)
        .stubs()
        .will(returnValue(true));
    HwtsTsKernel kernelInfo = {0};
    kernelInfo.kernelType = 1;

    AicpuEventProcess &aep = AicpuEventProcess::GetInstance();

    EXPECT_EQ(aep.ExecuteTsKernelTask(kernelInfo, 0, 0, 0, 0, 0), AICPU_SCHEDULE_OK);
}

namespace aicpu {
status_t GetThreadLocalCtxStub(const std::string &key, std::string &value)
{
    value = "True";
    return AICPU_ERROR_NONE;
}
}
TEST_F(AICPUScheduleTEST, ExecuteTsKernelTaskTest2) {
    MOCKER(aicpu::GetThreadLocalCtx)
        .stubs()
        .will(invoke(aicpu::GetThreadLocalCtxStub));
    HwtsTsKernel kernelInfo = {0};
    kernelInfo.kernelType = 1;

    AicpuEventProcess &aep = AicpuEventProcess::GetInstance();

    EXPECT_EQ(aep.ExecuteTsKernelTask(kernelInfo, 0, 0, 0, 0, 0), AICPU_SCHEDULE_OK);
}

TEST_F(AICPUScheduleTEST, ExecuteTsKernelTaskTest3) {
    MOCKER(&aicpu::IsSupportedProfData)
        .stubs()
        .will(returnValue(true));
    MOCKER(aeCallInterface)
        .stubs()
        .will(returnValue(static_cast<int32_t>(AE_STATUS_KERNEL_API_INNER_ERROR)));
    HwtsTsKernel kernelInfo = {0};
    kernelInfo.kernelType = 1;

    AicpuEventProcess &aep = AicpuEventProcess::GetInstance();

    EXPECT_EQ(aep.ExecuteTsKernelTask(kernelInfo, 0, 0, 0, 0, 0), AE_STATUS_KERNEL_API_INNER_ERROR);
}

TEST_F(AICPUScheduleTEST, ExecuteTsKernelTaskNoKernelName) {
    MOCKER(aicpu::GetThreadLocalCtx)
        .stubs()
        .will(invoke(aicpu::GetThreadLocalCtxStub));
    HwtsTsKernel kernelInfo = {0};
    kernelInfo.kernelType = 0;
    char *kernelname = "TestKernelName";
    kernelInfo.kernelBase.cceKernel.kernelName = reinterpret_cast<uintptr_t>(kernelname);
    AicpuEventProcess &aep = AicpuEventProcess::GetInstance();
    EXPECT_EQ(aep.ExecuteTsKernelTask(kernelInfo, 0, 0, 0, 0, 0), AICPU_SCHEDULE_ERROR_NOT_FOUND_LOGICAL_TASK);
}

TEST_F(AICPUScheduleTEST, ExecuteTsKernelTaskLongKernelName) {
    MOCKER(aicpu::GetThreadLocalCtx)
        .stubs()
        .will(invoke(aicpu::GetThreadLocalCtxStub));
    MOCKER(strncpy_s)
        .stubs()
        .will(returnValue(161));
    HwtsTsKernel kernelInfo = {0};
    kernelInfo.kernelType = 0;
    char *kernelname = "TestKernelNameExceptionAbnormalLongOverFlowTestKernelNameExceptionAbnormalLongOverFlowTestKernelNameExceptionAbnormalLongOverFlowTestKernelNameExceptionAbnormalLongOverFlowTestKernelNameExceptionAbnormalLongOverFlowTestKernelNameExceptionAbnormalLongOverFlow";
    kernelInfo.kernelBase.cceKernel.kernelName = reinterpret_cast<uintptr_t>(kernelname);
    AicpuEventProcess &aep = AicpuEventProcess::GetInstance();
    EXPECT_EQ(aep.ExecuteTsKernelTask(kernelInfo, 0, 0, 0, 0, 0), AICPU_SCHEDULE_ERROR_NOT_FOUND_LOGICAL_TASK);
}

TEST_F(AICPUScheduleTEST, ExecuteTsKernelTaskTaskAbort) {
    MOCKER(aicpu::GetThreadLocalCtx).stubs().will(invoke(aicpu::GetThreadLocalCtxStub));
    HwtsTsKernel kernelInfo = {0};
    kernelInfo.kernelType = 1;
 
    AicpuEventProcess &aep = AicpuEventProcess::GetInstance();
    MOCKER(aeCallInterface).stubs().will(returnValue(static_cast<int32_t>(AE_STATUS_TASK_ABORT)));
    EXPECT_EQ(aep.ExecuteTsKernelTask(kernelInfo, 0, 0, 0, 0, 0), AE_STATUS_TASK_ABORT);
}

TEST_F(AICPUScheduleTEST, StopTest) {
    ComputeProcess::GetInstance().Stop();
    EXPECT_TRUE(true);
}

namespace {
    drvError_t halEschedSubmitEventBatchPart(unsigned int devId, SUBMIT_FLAG flag,
        struct event_summary *events, unsigned int event_num, unsigned int *succ_event_num)
    {
        if (event_num >= 1) {
            *succ_event_num = event_num - 1;
        } else {
            *succ_event_num = event_num;
        }
        return DRV_ERROR_NONE;
    }
}

TEST_F(AICPUScheduleTEST, TdtServerTestERROR1) {
    // MOCKER(&tdt::TDTServerInit)
    //     .stubs()
    //     .will(returnValue(1));
    int ret = ComputeProcess::GetInstance().StartTdtServer();
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
    MOCKER(&tdt::TDTServerStop)
        .stubs()
        .will(returnValue(0));
    ComputeProcess::GetInstance().StopTdtServer();
}


TEST_F(AICPUScheduleTEST, TdtServerTestSuccess) {
    MOCKER(&tdt::TDTServerInit)
        .stubs()
        .will(returnValue(0));
    int ret = ComputeProcess::GetInstance().StartTdtServer();
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
    MOCKER(&tdt::TDTServerStop)
        .stubs()
        .will(returnValue(0));
    ComputeProcess::GetInstance().StopTdtServer();
}

const char* stubGetEnv()
{
    char *str = "1";
    std::cout << "stubGetEnv"<< std::endl;
    return str;
}

TEST_F(AICPUScheduleTEST, TdtServerTestSuccessWithoutDcpu_01) {
    MOCKER(&tdt::TDTServerInit)
        .stubs()
        .will(returnValue(0));
    AicpuSchedule::AicpuDrvManager::GetInstance().dcpuNum_ = 1;
    AicpuSchedule::AicpuDrvManager::GetInstance().aicpuNumPerDev_ = 1;
    ComputeProcess::GetInstance().runMode_ = aicpu::AicpuRunMode::PROCESS_PCIE_MODE;
    std::vector<uint32_t> deviceVec;
    deviceVec.push_back(1);
    AicpuDrvManager::GetInstance().InitDrvMgr(deviceVec, 3200, 0, false);
    std::string ch = "000000000000000000000000000000000000000000000000";
    deviceVec[0] = 1;
    MOCKER_CPP(&AicpuDrvManager::CheckBindHostPid)
        .stubs()
        .will(returnValue(0));
    int ret = AicpuScheduleInterface::GetInstance().InitAICPUScheduler(deviceVec, 0, ch, (ProfilingMode)0,
                                                                       0, true, SCHED_MODE_INTERRUPT);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
    setenv("DATAMASTER_RUN_MODE", "1", 1);
    ret = ComputeProcess::GetInstance().StartTdtServer();
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
    MOCKER(&tdt::TDTServerStop)
        .stubs()
        .will(returnValue(0));
    ComputeProcess::GetInstance().StopTdtServer();
    unsetenv("DATAMASTER_RUN_MODE");
}

TEST_F(AICPUScheduleTEST, TdtServerTestSuccessWithoutDcpu_02) {
    MOCKER(&tdt::TDTServerInit)
        .stubs()
        .will(returnValue(0));
    AicpuSchedule::AicpuDrvManager::GetInstance().dcpuNum_ = 1;
    AicpuSchedule::AicpuDrvManager::GetInstance().aicpuNumPerDev_ = 1;
    ComputeProcess::GetInstance().runMode_ = aicpu::AicpuRunMode::PROCESS_PCIE_MODE;
    setenv("DATAMASTER_RUN_MODE", "1", 1);
    int ret = ComputeProcess::GetInstance().StartTdtServer();
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
    MOCKER(&tdt::TDTServerStop)
        .stubs()
        .will(returnValue(0));
    ComputeProcess::GetInstance().StopTdtServer();
    unsetenv("DATAMASTER_RUN_MODE");
}

TEST_F(AICPUScheduleTEST, TdtServerTestSuccessWithoutDcpu_03) {
    MOCKER(&tdt::TDTServerInit)
        .stubs()
        .will(returnValue(0));
    AicpuSchedule::AicpuDrvManager::GetInstance().dcpuNum_ = 0;
    AicpuSchedule::AicpuDrvManager::GetInstance().aicpuNumPerDev_ = 1;
    ComputeProcess::GetInstance().runMode_ = aicpu::AicpuRunMode::PROCESS_PCIE_MODE;
    setenv("DATAMASTER_RUN_MODE", "1", 1);
    int ret = ComputeProcess::GetInstance().StartTdtServer();
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
    MOCKER(&tdt::TDTServerStop)
        .stubs()
        .will(returnValue(0));
    ComputeProcess::GetInstance().StopTdtServer();
    unsetenv("DATAMASTER_RUN_MODE");
}

TEST_F(AICPUScheduleTEST, StopTdtServerERROR1) {
    ComputeProcess::GetInstance().isStartTdtFlag_ = false;
    ComputeProcess::GetInstance().StopTdtServer();
    EXPECT_EQ(ComputeProcess::GetInstance().runMode_, aicpu::AicpuRunMode::PROCESS_PCIE_MODE);
}

TEST_F(AICPUScheduleTEST, StopTdtServerERROR2) {
    ComputeProcess::GetInstance().isStartTdtFlag_ = true;
    MOCKER(&tdt::TDTServerStop)
        .stubs()
        .will(returnValue(1));
    ComputeProcess::GetInstance().StopTdtServer();
    EXPECT_EQ(ComputeProcess::GetInstance().runMode_, aicpu::AicpuRunMode::PROCESS_PCIE_MODE);
}

TEST_F(AICPUScheduleTEST, MemorySvmDeviceERROR3) {
    ComputeProcess::GetInstance().pidSign_ = "123";
    MOCKER(halMemInitSvmDevice)
        .stubs()
        .will(returnValue(1));
    int ret = ComputeProcess::GetInstance().MemorySvmDevice();
    EXPECT_NE(ret, AICPU_SCHEDULE_OK);
}

TEST_F(AICPUScheduleTEST, ComputeProcessStartTestOK) {
    MOCKER_CPP(&ThreadPool::CreateWorker)
        .stubs()
        .will(returnValue(0));
    std::string ch = "000000000000000000000000000000000000000000000000";
    std::vector<uint32_t> deviceVec;
    deviceVec.push_back(1);
    const AicpuSchedMode schedMode = SCHED_MODE_INTERRUPT;
    int ret = ComputeProcess::GetInstance().Start(deviceVec, 100, ch, PROFILING_OPEN, 0, aicpu::PROCESS_PCIE_MODE, schedMode);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
}

extern int32_t ComputeProcessMain(int32_t argc, char* argv[]);
TEST_F(AICPUScheduleTEST, MainTest) {
    char processName[] = "aicpu_scheduler";
    char paramDeviceIdOk[] = "--deviceId=1";
    char paramPidOk[] = "--pid=2";
    char paramPidSignOk[] = "--pidSign=12345A";
    char paramModeOk[] = "--profilingMode=1";
    char paramLogLevelOk[] = "--logLevelInPid=0";
    char paramGrpNameOk[] = "--groupNameList=Grp1,Grp2";
    char paramGrpNumOk[] = "--groupNameNum=2";
    MOCKER(halGrpAttach).stubs().will(returnValue(0));
    MOCKER(halBuffInit).stubs().will(returnValue(0));
    MOCKER(system)
        .stubs()
        .will(returnValue(0));

    char* argv[] = {processName, paramDeviceIdOk, paramPidOk, paramPidSignOk, paramModeOk, paramLogLevelOk, paramGrpNameOk, paramGrpNumOk};
    int32_t argc = 7;
    MOCKER_CPP(&AicpuScheduleInterface::InitAICPUScheduler)
        .stubs()
        .will(returnValue(20));
    int32_t ret = ComputeProcessMain(argc, argv);
    EXPECT_EQ(ret, -1);
}

TEST_F(AICPUScheduleTEST, MainTest02) {
    char processName[] = "aicpu_scheduler";
    char paramDeviceIdOk[] = "--deviceId=1";
    char paramPidOk[] = "--pid=2";
    char paramPidSignOk[] = "--pidSign=12345A";
    char paramModeOk[] = "--profilingMode=1";
    char paramLogLevelOk[] = "--logLevelInPid=0";
    char paramGrpNameOk[] = "--groupNameList=Grp1,Grp2";
    char paramGrpNumOk[] = "--groupNameNum=2";
    MOCKER(halGrpAttach).stubs().will(returnValue(0));
    MOCKER(halBuffInit).stubs().will(returnValue(0));
    MOCKER(system)
        .stubs()
        .will(returnValue(0));

    char* argv[] = {processName, paramDeviceIdOk, paramPidOk, paramPidSignOk, paramModeOk, paramLogLevelOk, paramGrpNameOk, paramGrpNumOk};
    int32_t argc = 7;
    MOCKER_CPP(&AicpuScheduleInterface::InitAICPUScheduler)
        .stubs()
        .will(returnValue(20));
    int32_t ret = ComputeProcessMain(argc, argv);
    EXPECT_EQ(ret, -1);
}

/*
TEST_F(AICPUScheduleTEST, MainTestSuccess) {
    char processName[] = "aicpu_scheduler";
    char paramDeviceIdOk[] = "--deviceId=1";
    char paramPidOk[] = "--pid=2";
    char paramPidSignOk[] = "--pidSign=12345A";
    char paramModeOk[] = "--profilingMode=1";
    char paramLogLevelOk[] = "--logLevelInPid=0";
    char paramGrpNameOk[] = "--groupNameList=Grp1,Grp2";
    char paramGrpNumOk[] = "--groupNameNum=2";
    MOCKER(halGrpAttach).stubs().will(returnValue(0));
    MOCKER(halBuffInit).stubs().will(returnValue(0));

    MOCKER(system)
        .stubs()
        .will(returnValue(0));

    char* argv[] = { processName, paramDeviceIdOk, paramPidOk, paramPidSignOk, paramModeOk, paramLogLevelOk, paramGrpNameOk, paramGrpNumOk };
    int32_t argc = 8;
    MOCKER_CPP(&AicpuScheduleInterface::InitAICPUScheduler)
        .stubs()
        .will(returnValue(0));
    int32_t ret = ComputeProcessMain(argc, argv);
    EXPECT_EQ(ret, 0);
}*/

TEST_F(AICPUScheduleTEST, MainTestErr) {
    char processName[] = "aicpu_scheduler";
    char paramDeviceIdOk[] = "--deviceId=0";
    char paramDeviceIdErr1[] = "--deviceId=20";
    char paramDeviceIdErr2[] = "--deviceId=0A";
    char paramPidOk[] = "--pid=2";
    char paramPidErr[] = "--pid=-100";
    char paramPidSignOk[] = "--pidSign=12345A";
    char paramModeOk[] = "--profilingMode=1";
    char paramModeErr[] = "--profilingMode=100";
    char paramVfIdOk[] = "--vfId=16";
    char paramVfIdErr1[] = "--vfId=20";
    char paramVfIdErr2[] = "--vfId=10A";
    char paramDeviceModeErr1[] = "--deviceMode=1As";
    char paramDeviceModeErr2[] = "--deviceMode=3";
    char paramGrpNameOk[] = "--groupNameList=Grp1,Grp2";
    char paramGrpNameErr1[] = "--groupNameList=";
    char paramGrpNameErr2[] = "--groupNameList=Grp1";
    char paramGrpNumOk[] = "--groupNameNum=2";
    char paramGrpNumErr1[] = "--groupNameNum=a";
    char paramLogLevelOk[] = "--logLevelInPid=0";
    MOCKER(system)
        .stubs()
        .will(returnValue(0));

    char *argv1[] = {processName};
    int32_t argc1 = 1;
    int32_t ret = ComputeProcessMain(argc1, argv1);
    EXPECT_EQ(ret, -1);

    char *argv2[] = {processName, paramDeviceIdErr1};
    int32_t argc2 = 2;
    ret = ComputeProcessMain(argc2, argv2);
    EXPECT_EQ(ret, -1);

    char *argv3[] = {processName, paramDeviceIdErr2};
    int32_t argc3 = 2;
    ret = ComputeProcessMain(argc3, argv3);
    EXPECT_EQ(ret, -1);

    char *argv4[] = {processName, paramDeviceIdOk, paramPidErr};
    int32_t argc4 = 3;
    ret = ComputeProcessMain(argc4, argv4);
    EXPECT_EQ(ret, -1);

    char *argv5[] = {processName, paramDeviceIdOk, paramPidOk, paramPidSignOk, paramModeErr};
    int32_t argc5 = 5;
    ret = ComputeProcessMain(argc5, argv5);
    EXPECT_EQ(ret, -1);

    char *argv6[] = {processName, paramDeviceIdOk, paramPidOk, paramPidSignOk, paramModeOk, paramVfIdErr1};
    int32_t argc6 = 6;
    ret = ComputeProcessMain(argc6, argv6);
    EXPECT_EQ(ret, -1);

    char *argv7[] = {processName, paramDeviceIdOk, paramPidOk, paramPidSignOk, paramModeOk, paramVfIdErr2};
    int32_t argc7 = 6;
    ret = ComputeProcessMain(argc7, argv7);
    EXPECT_EQ(ret, -1);
    char *argv8[] = {processName, paramDeviceIdOk, paramPidOk, paramPidSignOk, paramModeOk, paramDeviceModeErr1};
    int32_t argc8 = 6;
    ret = ComputeProcessMain(argc8, argv8);
    EXPECT_EQ(ret, -1);
    char *argv9[] = {processName, paramDeviceIdOk, paramPidOk, paramPidSignOk, paramModeOk, paramDeviceModeErr2};
    int32_t argc9 = 6;
    ret = ComputeProcessMain(argc9, argv9);
    EXPECT_EQ(ret, -1);
    char *argv10[] = {processName, paramDeviceIdOk, paramPidOk, paramPidSignOk, paramModeOk,
                      paramLogLevelOk, paramGrpNameErr1, paramGrpNumOk};
    int32_t argc10 = 8;
    ret = ComputeProcessMain(argc10, argv10);
    EXPECT_EQ(ret, -1);
    char *argv11[] = {processName, paramDeviceIdOk, paramPidOk, paramPidSignOk, paramModeOk,
                      paramLogLevelOk, paramGrpNameErr2, paramGrpNumOk};
    int32_t argc11 = 8;
    ret = ComputeProcessMain(argc11, argv11);
    EXPECT_EQ(ret, -1);
    char *argv12[] = {processName, paramDeviceIdOk, paramPidOk, paramPidSignOk, paramModeOk,
                      paramLogLevelOk, paramGrpNameOk, paramGrpNumErr1};
    int32_t argc12 = 8;
    ret = ComputeProcessMain(argc12, argv12);
    EXPECT_EQ(ret, -1);
    MOCKER(halGrpAttach).stubs().will(returnValue(1));
    char *argv13[] = {processName, paramDeviceIdOk, paramPidOk, paramPidSignOk, paramModeOk,
                      paramLogLevelOk, paramGrpNameOk, paramGrpNumOk};
    int32_t argc13 = 8;
    ret = ComputeProcessMain(argc13, argv13);
    EXPECT_EQ(ret, -1);
}

TEST_F(AICPUScheduleTEST, AddToCgroup_ERROR)
{
    char processName[] = "aicpu_scheduler";
    char paramDeviceIdOk[] = "--deviceId=1";
    char paramPidOk[] = "--pid=2";
    char paramPidSignOk[] = "--pidSign=12345A";
    char paramModeOk[] = "--profilingMode=1";
    char paramDeviceModeOk[] = "--deviceMode=1";
    char* argv[] = { processName, paramDeviceIdOk, paramPidOk, paramPidSignOk, paramModeOk, paramDeviceModeOk };
    int32_t argc = 6;
    MOCKER(system)
        .stubs()
        .will(returnValue(-1));
    int32_t ret = ComputeProcessMain(argc, argv);
    EXPECT_EQ(ret, -1);
}

TEST_F(AICPUScheduleTEST, InitDrvSchedModuleTest) {
    MOCKER(halEschedAttachDevice)
        .stubs()
        .will(returnValue(1));
    std::map<EVENT_ID, SCHEDULE_PRIORITY> priority;
    int ret = AicpuDrvManager::GetInstance().InitDrvSchedModule(0,priority);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_INIT_FAILED);

    GlobalMockObject::verify();
    MOCKER(halEschedCreateGrp)
        .stubs()
        .will(returnValue(1));
    ret = AicpuDrvManager::GetInstance().InitDrvSchedModule(0,priority);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_INIT_FAILED);

}

TEST_F(AICPUScheduleTEST, HWTSKernelEventMessageParse_1951) {
    event_info eventInfo = g_event;
    eventInfo.comm.pid = 100;
    eventInfo.comm.host_pid = 200;
    eventInfo.comm.event_id = EVENT_TS_HWTS_KERNEL;
    eventInfo.comm.subevent_id = 1122;
    eventInfo.comm.submit_timestamp = 0;
    eventInfo.comm.sched_timestamp = 10;

    struct hwts_ts_task eventMsg = {0};
    eventMsg.mailbox_id = 0x55AA;
    eventMsg.serial_no = 0x1122;
//#ifndef CFG_SOC_PLATFORM_CLOUD
    eventMsg.kernel_info.pid = GetTid();
    eventMsg.kernel_info.kernel_type = 0;
    eventMsg.kernel_info.streamID = 0;
    eventMsg.kernel_info.kernelName = (uintptr_t)g_char;
    eventMsg.kernel_info.kernelSo = (uintptr_t)g_char;
    eventMsg.kernel_info.paramBase = (uintptr_t)g_char;
    eventMsg.kernel_info.l2VaddrBase = (uintptr_t)g_char;
    eventMsg.kernel_info.l2Ctrl = (uintptr_t)g_char;
    eventMsg.kernel_info.blockId = 0;
    eventMsg.kernel_info.blockNum = 1;
    eventMsg.kernel_info.l2InMain = 1;
    eventMsg.kernel_info.taskID = (uintptr_t)g_char;
//#endif
    eventInfo.priv.msg_len = sizeof(hwts_ts_task);
    memcpy(eventInfo.priv.msg, (char *)&eventMsg, sizeof(hwts_ts_task));

    HwtsTsKernel aicpufwKernelInfo = {0};
    uint32_t mailboxId = 0;
    uint64_t serialNo = 0;
    uint32_t streamId = 0;
    uint64_t taskId = 0;
    uint16_t dataDumpEnableMode = 0U;
    int ret = AicpuEventManager::GetInstance().HWTSKernelEventMessageParse(eventInfo, mailboxId, aicpufwKernelInfo,
        serialNo, streamId, taskId, dataDumpEnableMode);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
//#ifndef CFG_SOC_PLATFORM_CLOUD

    eventMsg.mailbox_id = 0x55AA;
    eventMsg.serial_no = 0x1122;
    eventMsg.kernel_info.pid = GetTid();
    eventMsg.kernel_info.kernel_type = 1;
    eventMsg.kernel_info.paramBase = (uintptr_t)g_char;
    eventInfo.priv.msg_len = sizeof(hwts_ts_task);
    memcpy(eventInfo.priv.msg, (char *)&eventMsg, sizeof(hwts_ts_task));
    ret = AicpuEventManager::GetInstance().HWTSKernelEventMessageParse(eventInfo, mailboxId, aicpufwKernelInfo,
        serialNo, streamId, taskId, dataDumpEnableMode);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);

    eventMsg.mailbox_id = 0x55AA;
    eventMsg.serial_no = 0x1122;
    eventMsg.kernel_info.pid = GetTid();
    eventMsg.kernel_info.kernel_type = 10;
    eventInfo.priv.msg_len = sizeof(hwts_ts_task);
    memcpy(eventInfo.priv.msg, (char *)&eventMsg, sizeof(hwts_ts_task));
    ret = AicpuEventManager::GetInstance().HWTSKernelEventMessageParse(eventInfo, mailboxId, aicpufwKernelInfo, serialNo,
                                                                       streamId, taskId, dataDumpEnableMode);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_DRV_ERR);
//#endif
}

namespace {
    hdcError_t drvHdcGetCapacityPCIE(struct drvHdcCapacity *capacity)
    {
        capacity->chanType = HDC_CHAN_TYPE_PCIE;
        return DRV_ERROR_NONE;
    }
}

TEST_F(AICPUScheduleTEST, ComputeProcessStart_MemorySvmDevice) {
    MOCKER(halMemInitSvmDevice)
        .stubs()
        .will(returnValue(0));
    MOCKER(drvHdcGetCapacity)
        .stubs()
        .will(invoke(drvHdcGetCapacityPCIE));
    MOCKER_CPP(&ThreadPool::CreateWorker)
        .stubs()
        .will(returnValue(0));
    std::string ch = "000000000000000000000000000000000000000000000000";
    std::vector<uint32_t> deviceVec;
    deviceVec.push_back(1);
    const AicpuSchedMode schedMode = SCHED_MODE_INTERRUPT;
    int ret = ComputeProcess::GetInstance().Start(deviceVec, 100, ch, PROFILING_OPEN, 0, aicpu::PROCESS_PCIE_MODE, schedMode);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
}

TEST_F(AICPUScheduleTEST, ComputeProcessStart_InitTaskMonitorContext_ERR) {
    MOCKER(halMemInitSvmDevice)
        .stubs()
        .will(returnValue(0));
    MOCKER(drvHdcGetCapacity)
        .stubs()
        .will(invoke(drvHdcGetCapacityPCIE));
    MOCKER(InitTaskMonitorContext)
        .stubs()
        .will(returnValue(1));
    std::string ch = "000000000000000000000000000000000000000000000000";
    std::vector<uint32_t> deviceVec;
    deviceVec.push_back(1);
    const AicpuSchedMode schedMode = SCHED_MODE_INTERRUPT;
    int ret = ComputeProcess::GetInstance().Start(deviceVec, 100, ch, PROFILING_OPEN, 0, aicpu::PROCESS_PCIE_MODE, schedMode);
    EXPECT_NE(ret, AICPU_SCHEDULE_OK);
}

TEST_F(AICPUScheduleTEST, StartMsqSuccess) {
    MOCKER_CPP(&ThreadPool::CreateWorker)
        .stubs()
        .will(returnValue(0));
    std::string ch = "000000000000000000000000000000000000000000000000";
    std::vector<uint32_t> deviceVec;
    deviceVec.push_back(1);
    MOCKER_CPP(&MessageQueue::InitMessageQueue).stubs().will(returnValue(AICPU_SCHEDULE_OK));
    const AicpuSchedMode schedMode = SCHED_MODE_MSGQ;
    int ret = ComputeProcess::GetInstance().Start(deviceVec, 100, ch, PROFILING_OPEN, 0, aicpu::PROCESS_PCIE_MODE, schedMode);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
}

TEST_F(AICPUScheduleTEST, StartMsqSuccessFail) {
    MOCKER_CPP(&ThreadPool::CreateWorker)
        .stubs()
        .will(returnValue(0));
    std::string ch = "000000000000000000000000000000000000000000000000";
    std::vector<uint32_t> deviceVec;
    deviceVec.push_back(1);
    MOCKER_CPP(&MessageQueue::InitMessageQueue).stubs().will(returnValue(AICPU_SCHEDULE_ERROR_FROM_DRV));
    const AicpuSchedMode schedMode = SCHED_MODE_MSGQ;
    int ret = ComputeProcess::GetInstance().Start(deviceVec, 100, ch, PROFILING_OPEN, 0, aicpu::PROCESS_PCIE_MODE, schedMode);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_FROM_DRV);
}

TEST_F(AICPUScheduleTEST, ComputeProcessStart_LoadKernelSo) {
    MOCKER(aeBatchLoadKernelSo).stubs().will(returnValue(0));
    ComputeProcess::GetInstance().LoadKernelSo();
    EXPECT_EQ(ComputeProcess::GetInstance().runMode_, aicpu::AicpuRunMode::PROCESS_PCIE_MODE);
}

TEST_F(AICPUScheduleTEST, ComputeProcessStart_UpdateProfilingMode) {
    ComputeProcess::GetInstance().UpdateProfilingMode(1);
    EXPECT_EQ(ComputeProcess::GetInstance().runMode_, aicpu::AicpuRunMode::PROCESS_PCIE_MODE);
}

TEST_F(AICPUScheduleTEST, ComputeProcessStart_UpdateProfilingModelMode) {
    ComputeProcess::GetInstance().UpdateProfilingModelMode(false);
    EXPECT_EQ(ComputeProcess::GetInstance().runMode_, aicpu::AicpuRunMode::PROCESS_PCIE_MODE);
}

TEST_F(AICPUScheduleTEST, TransferErrCodeToErrMsg_01) {
    char processName[] = "aicpu_scheduler";
    char paramDeviceIdOk[] = "--deviceId=1";
    char paramPidOk[] = "--pid=2";
    char paramPidSignOk[] = "--pidSign=12345A";
    char paramModeOk[] = "--profilingMode=1";
    char paramLogLevelOk[] = "--logLevelInPid=0";
    char paramGrpNameOk[] = "--groupNameList=Grp1,Grp2";
    char paramGrpNumOk[] = "--groupNameNum=2";
    MOCKER(halGrpAttach).stubs().will(returnValue(0));
    MOCKER(halBuffInit).stubs().will(returnValue(0));
    MOCKER(system)
        .stubs()
        .will(returnValue(0));

    char* argv[] = {processName, paramDeviceIdOk, paramPidOk, paramPidSignOk, paramModeOk, paramLogLevelOk, paramGrpNameOk, paramGrpNumOk};
    int32_t argc = 8;
    MOCKER_CPP(&AicpuScheduleInterface::InitAICPUScheduler)
        .stubs()
        .will(returnValue(20));
    MOCKER(dlog_setlevel).stubs().will(returnValue(-1));
    MOCKER(DlogSetAttr).stubs().will(returnValue(-1));
    MOCKER(TsdReportStartOrStopErrCode).stubs().will(returnValue(-1));
    int32_t ret = ComputeProcessMain(argc, argv);
    EXPECT_EQ(ret, -1);
}

TEST_F(AICPUScheduleTEST, TransferErrCodeToErrMsg_02) {
    char processName[] = "aicpu_scheduler";
    char paramDeviceIdOk[] = "--deviceId=1";
    char paramPidOk[] = "--pid=2";
    char paramPidSignOk[] = "--pidSign=12345A";
    char paramModeOk[] = "--profilingMode=1";
    char paramLogLevelOk[] = "--logLevelInPid=0";
    char paramGrpNameOk[] = "--groupNameList=Grp1,Grp2";
    char paramGrpNumOk[] = "--groupNameNum=2";
    MOCKER(halGrpAttach).stubs().will(returnValue(0));
    MOCKER(halBuffInit).stubs().will(returnValue(0));
    MOCKER(system)
        .stubs()
        .will(returnValue(-1));

    char* argv[] = {processName, paramDeviceIdOk, paramPidOk, paramPidSignOk, paramModeOk, paramLogLevelOk, paramGrpNameOk, paramGrpNumOk};
    int32_t argc = 8;
    MOCKER_CPP(&AicpuScheduleInterface::InitAICPUScheduler)
        .stubs()
        .will(returnValue(20));
    int32_t ret = ComputeProcessMain(argc, argv);
    EXPECT_EQ(ret, -1);
}

TEST_F(AICPUScheduleTEST, TransferErrCodeToErrMsg_03) {
    char processName[] = "aicpu_scheduler";
    char paramDeviceIdOk[] = "--deviceId=1";
    char paramPidOk[] = "--pid=2";
    char paramPidSignOk[] = "--pidSign=12345A";
    char paramModeOk[] = "--profilingMode=1";
    char paramLogLevelOk[] = "--logLevelInPid=0";
    char paramGrpNameOk[] = "--groupNameList=Grp1,Grp2";
    char paramGrpNumOk[] = "--groupNameNum=2";
    char paramDeviceModel[] = "--deviceMode=1";
    MOCKER(halGetDeviceCountFromChip).stubs().will(returnValue(1));
    MOCKER(halBuffInit).stubs().will(returnValue(0));
    MOCKER(system)
        .stubs()
        .will(returnValue(-1));

    char* argv[] = {processName, paramDeviceIdOk, paramPidOk, paramPidSignOk, paramModeOk, paramLogLevelOk, paramGrpNameOk, paramGrpNumOk, paramDeviceModel};
    int32_t argc = 9;
    MOCKER_CPP(&AicpuScheduleInterface::InitAICPUScheduler)
        .stubs()
        .will(returnValue(20));
    int32_t ret = ComputeProcessMain(argc, argv);
    EXPECT_EQ(ret, -1);
}

TEST_F(AICPUScheduleTEST, TransferErrCodeToErrMsg_04) {
    char processName[] = "aicpu_scheduler";
    char paramDeviceIdOk[] = "--deviceId=1";
    char paramPidOk[] = "--pid=2";
    char paramPidSignOk[] = "--pidSign=12345A";
    char paramModeOk[] = "--profilingMode=1";
    char paramLogLevelOk[] = "--logLevelInPid=0";
    char paramGrpNameOk[] = "--groupNameList=Grp1,Grp2";
    char paramGrpNumOk[] = "--groupNameNum=2";
    char paramDeviceModel[] = "--deviceMode=1";
    MOCKER(halGetDeviceCountFromChip).stubs().will(returnValue(1));
    MOCKER(halBuffInit).stubs().will(returnValue(0));
    MOCKER(system)
        .stubs()
        .will(returnValue(-1));

    char* argv[] = {processName, paramDeviceIdOk, paramPidOk, paramPidSignOk, paramModeOk, paramLogLevelOk, paramGrpNameOk, paramGrpNumOk, paramDeviceModel};
    int32_t argc = 9;
    MOCKER_CPP(&AicpuScheduleInterface::InitAICPUScheduler)
        .stubs()
        .will(returnValue(AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID));
    int32_t ret = ComputeProcessMain(argc, argv);
    EXPECT_EQ(ret, -1);
}

TEST_F(AICPUScheduleTEST, TransferErrCodeToErrMsg_05) {
    char processName[] = "aicpu_scheduler";
    char paramDeviceIdOk[] = "--deviceId=1";
    char paramPidOk[] = "--pid=2";
    char paramPidSignOk[] = "--pidSign=12345A";
    char paramModeOk[] = "--profilingMode=1";
    char paramLogLevelOk[] = "--logLevelInPid=0";
    char paramGrpNameOk[] = "--groupNameList=Grp1,Grp2";
    char paramGrpNumOk[] = "--groupNameNum=2";
    char paramDeviceModel[] = "--deviceMode=1";
    MOCKER(halGetDeviceCountFromChip).stubs().will(returnValue(1));
    MOCKER(halBuffInit).stubs().will(returnValue(0));
    MOCKER(system)
        .stubs()
        .will(returnValue(-1));

    char* argv[] = {processName, paramDeviceIdOk, paramPidOk, paramPidSignOk, paramModeOk, paramLogLevelOk, paramGrpNameOk, paramGrpNumOk, paramDeviceModel};
    int32_t argc = 9;
    MOCKER_CPP(&AicpuScheduleInterface::InitAICPUScheduler)
        .stubs()
        .will(returnValue(AICPU_SCHEDULE_ERROR_INIT_FAILED));
    int32_t ret = ComputeProcessMain(argc, argv);
    EXPECT_EQ(ret, -1);
}

TEST_F(AICPUScheduleTEST, InitCpuScheduler_Success) {
    printf("=======================InitCpuScheduler=====================\n");
    MOCKER_CPP(&AicpuScheduleInterface::InitAICPUScheduler)
        .stubs()
        .will(returnValue(0));
    CpuSchedInitParam initParam = {0, 0, PROFILING_CLOSE};
    int ret = InitCpuScheduler(&initParam);
    EXPECT_EQ(ret, AICPU_SCHEDULE_SUCCESS);
}

TEST_F(AICPUScheduleTEST, InitCpuScheduler_Failed) {
    printf("=======================InitCpuScheduler=====================\n");
    int ret = InitCpuScheduler(nullptr);
    EXPECT_EQ(ret, AICPU_SCHEDULE_FAIL);
}

TEST_F(AICPUScheduleTEST, AicpuLoadModelWithQ_Failed) {
    printf("=======================AicpuLoadModelWithQ=====================\n");
    int ret = AicpuLoadModelWithQ(nullptr);
    EXPECT_EQ(ret, AICPU_SCHEDULE_FAIL);
}

TEST_F(AICPUScheduleTEST, AicpuLoadModelWithQ_Success) {
    printf("=======================AicpuLoadModelWithQ=====================\n");
    ModelQueueInfo modelQueueInfo = {0, 0};
    ModelTaskInfo modelTaskInfo = {0, 0, 0};
    ModelStreamInfo modelStreamInfo = {0, 0, 1, &modelTaskInfo};
    ModelInfo modelInfo = {}; // {0, 1, &modelStreamInfo, 1, &modelQueueInfo, };
    modelInfo.modelId = 0U;
    modelInfo.aicpuStreamNum = 1U;
    modelInfo.streams = &modelStreamInfo;
    modelInfo.queueNum = 1U;
    modelInfo.queues = &modelQueueInfo;

    int ret = AicpuLoadModelWithQ((void*)(&modelInfo));
    EXPECT_EQ(ret, AICPU_SCHEDULE_FAIL);
}

TEST_F(AICPUScheduleTEST, AicpuLoadModelWithQ_StreamsNull) {
    printf("=======================AicpuLoadModelWithQ=====================\n");
    ModelQueueInfo modelQueueInfo = {0, 0};
    ModelInfo modelInfo = {}; //{0, 1, nullptr, 1, &modelQueueInfo, };
    modelInfo.modelId = 0U;
    modelInfo.aicpuStreamNum = 1U;
    modelInfo.streams = nullptr;
    modelInfo.queueNum = 1U;
    modelInfo.queues = &modelQueueInfo;

    int ret = AicpuLoadModelWithQ((void*)(&modelInfo));
    EXPECT_EQ(ret, AICPU_SCHEDULE_FAIL);
}

TEST_F(AICPUScheduleTEST, AicpuLoadModelWithQ_TasksNull) {
    printf("=======================AicpuLoadModelWithQ=====================\n");
    ModelQueueInfo modelQueueInfo = {0, 0};
    ModelStreamInfo modelStreamInfo = {0, 0, 1, nullptr};
    ModelInfo modelInfo = {}; //{0, 1, &modelStreamInfo, 1, &modelQueueInfo, };
    modelInfo.modelId = 0U;
    modelInfo.aicpuStreamNum = 1U;
    modelInfo.streams = &modelStreamInfo;
    modelInfo.queueNum = 1U;
    modelInfo.queues = &modelQueueInfo;

    int ret = AicpuLoadModelWithQ((void*)(&modelInfo));
    EXPECT_EQ(ret, AICPU_SCHEDULE_FAIL);
}

TEST_F(AICPUScheduleTEST, AicpuLoadModelWithQ_QueuesNull) {
    printf("=======================AicpuLoadModelWithQ=====================\n");
    ModelTaskInfo modelTaskInfo = {0, 0, 0};
    ModelStreamInfo modelStreamInfo = {0, 0, 1, &modelTaskInfo};
    ModelInfo modelInfo = {}; //{0, 1, &modelStreamInfo, 1, nullptr, };
    modelInfo.modelId = 0U;
    modelInfo.aicpuStreamNum = 1U;
    modelInfo.streams = &modelStreamInfo;
    modelInfo.queueNum = 1U;
    modelInfo.queues = nullptr;

    int ret = AicpuLoadModelWithQ((void*)(&modelInfo));
    EXPECT_EQ(ret, AICPU_SCHEDULE_FAIL);
}

int32_t AicpuSchedulerSubModuleProcessFake(const struct TsdSubEventInfo * const eventInfo)
{
    std::cout << "enter AicpuSchedulerSubModuleProcessFake" << std::endl;
    return 0;
}

void *dlsymStubAicpuSdMain(void *const soHandle, const char_t * const funcName)
{
    std::cout << "enter dlsymStub" << std::endl;
    return (reinterpret_cast<void *>(AicpuSchedulerSubModuleProcessFake));
}

int dlcloseStub(void *handle)
{
    return 0;
}

TEST_F(AICPUScheduleTEST, RegQueueScheduleModuleCallBack_Ok) {
    char processName[] = "aicpu_scheduler";
    char paramDeviceIdOk[] = "--deviceId=1";
    char paramPidOk[] = "--pid=2";
    char paramPidSignOk[] = "--pidSign=12345A";
    char paramModeOk[] = "--profilingMode=1";
    char paramLogLevelOk[] = "--logLevelInPid=0";
    char paramGrpNameOk[] = "--groupNameList=Grp1,Grp2";
    char paramGrpNumOk[] = "--groupNameNum=2";
    char paramDeviceModel[] = "--deviceMode=0";
    uint64_t rest = 0;
    MOCKER(system).stubs().will(returnValue(0));
    MOCKER(halGrpAttach).stubs().will(returnValue(0));
    MOCKER(dlopen).stubs().will(returnValue((void *)(&rest)));
    MOCKER(dlsym).stubs().will(invoke(dlsymStubAicpuSdMain));
    MOCKER(dlclose).stubs().will(invoke(dlcloseStub));
    MOCKER(halGetDeviceCountFromChip).stubs().will(returnValue(0));
    MOCKER(halGetDeviceFromChip).stubs().will(returnValue(0));
    MOCKER(halBuffInit).stubs().will(returnValue(0));

    char* argv[] = {processName, paramDeviceIdOk, paramPidOk, paramPidSignOk, paramModeOk, paramLogLevelOk, paramGrpNameOk, paramGrpNumOk, paramDeviceModel};
    int32_t argc = 9;
    MOCKER_CPP(&AicpuScheduleInterface::InitAICPUScheduler)
        .stubs()
        .will(returnValue(0));
    int32_t ret = ComputeProcessMain(argc, argv);
    EXPECT_EQ(ret, 0);
    GlobalMockObject::verify();
}

TEST_F(AICPUScheduleTEST, RegQueueScheduleModuleCallBack_Ok2) {
    char processName[] = "aicpu_scheduler";
    char paramDeviceIdOk[] = "--deviceId=1";
    char paramPidOk[] = "--pid=2";
    char paramPidSignOk[] = "--pidSign=12345A";
    char paramModeOk[] = "--profilingMode=1";
    char paramLogLevelOk[] = "--logLevelInPid=0";
    char paramGrpNameOk[] = "--groupNameList=Grp1,Grp2";
    char paramGrpNumOk[] = "--groupNameNum=0";
    char paramDeviceModel[] = "--deviceMode=0";
    uint64_t rest = 0;
    MOCKER(system).stubs().will(returnValue(0));
    MOCKER(halGrpAttach).stubs().will(returnValue(0));
    MOCKER(dlopen).stubs().will(returnValue((void *)(&rest)));
    MOCKER(dlsym).stubs().will(invoke(dlsymStubAicpuSdMain));
    MOCKER(dlclose).stubs().will(invoke(dlcloseStub));
    MOCKER(halGetDeviceCountFromChip).stubs().will(returnValue(0));
    MOCKER(halGetDeviceFromChip).stubs().will(returnValue(0));
    MOCKER(halBuffInit).stubs().will(returnValue(0));

    char* argv[] = {processName, paramDeviceIdOk, paramPidOk, paramPidSignOk, paramModeOk, paramLogLevelOk, paramGrpNameOk, paramGrpNumOk, paramDeviceModel};
    int32_t argc = 9;
    MOCKER_CPP(&AicpuScheduleInterface::InitAICPUScheduler)
        .stubs()
        .will(returnValue(0));
    int32_t ret = ComputeProcessMain(argc, argv);
    EXPECT_EQ(ret, 0);
    GlobalMockObject::verify();
}

TEST_F(AICPUScheduleTEST, RegQueueScheduleModuleCallBack_nok1) {
    char processName[] = "aicpu_scheduler";
    char paramDeviceIdOk[] = "--deviceId=1";
    char paramPidOk[] = "--pid=2";
    char paramPidSignOk[] = "--pidSign=12345A";
    char paramModeOk[] = "--profilingMode=1";
    char paramLogLevelOk[] = "--logLevelInPid=0";
    char paramGrpNameOk[] = "--groupNameList=Grp1,Grp2";
    char paramGrpNumOk[] = "--groupNameNum=2";
    char paramDeviceModel[] = "--deviceMode=0";
    uint64_t rest = 0;
    MOCKER(system).stubs().will(returnValue(0));
    MOCKER(halGrpAttach).stubs().will(returnValue(0));
    MOCKER(dlsym).stubs().will(invoke(dlsymStubAicpuSdMain));
    MOCKER(halGetDeviceCountFromChip).stubs().will(returnValue(0));
    MOCKER(halGetDeviceFromChip).stubs().will(returnValue(0));
    MOCKER(halBuffInit).stubs().will(returnValue(0));

    char* argv[] = {processName, paramDeviceIdOk, paramPidOk, paramPidSignOk, paramModeOk, paramLogLevelOk, paramGrpNameOk, paramGrpNumOk, paramDeviceModel};
    int32_t argc = 9;
    MOCKER_CPP(&AicpuScheduleInterface::InitAICPUScheduler)
        .stubs()
        .will(returnValue(0));
    int32_t ret = ComputeProcessMain(argc, argv);
    EXPECT_EQ(ret, 0);
    GlobalMockObject::verify();
}

void *dlsymStubAicpuSdMainNull(void *const soHandle, const char_t * const funcName)
{
    std::cout << "enter dlsymStub" << std::endl;
    return NULL;
}

TEST_F(AICPUScheduleTEST, RegEventMsgCallBackFunc_Fail) {
    char processName[] = "aicpu_scheduler";
    char paramDeviceIdOk[] = "--deviceId=1";
    char paramPidOk[] = "--pid=2";
    char paramPidSignOk[] = "--pidSign=12345A";
    char paramModeOk[] = "--profilingMode=1";
    char paramLogLevelOk[] = "--logLevelInPid=0";
    char paramGrpNameOk[] = "--groupNameList=Grp1,Grp2";
    char paramGrpNumOk[] = "--groupNameNum=2";
    char paramDeviceModel[] = "--deviceMode=0";
    uint64_t rest = 0;
    MOCKER(system).stubs().will(returnValue(0));
    MOCKER(halGrpAttach).stubs().will(returnValue(0));
    MOCKER(dlopen).stubs().will(returnValue((void *)(&rest)));
    MOCKER(dlsym).stubs().will(invoke(dlsymStubAicpuSdMain));
    MOCKER(dlclose).stubs().will(invoke(dlcloseStub));
    MOCKER(halGetDeviceCountFromChip).stubs().will(returnValue(0));
    MOCKER(halGetDeviceFromChip).stubs().will(returnValue(0));
    MOCKER(halBuffInit).stubs().will(returnValue(0));
    MOCKER(RegEventMsgCallBackFunc).stubs().will(returnValue(1));

    char* argv[] = {processName, paramDeviceIdOk, paramPidOk, paramPidSignOk, paramModeOk, paramLogLevelOk, paramGrpNameOk, paramGrpNumOk, paramDeviceModel};
    int32_t argc = 9;
    MOCKER_CPP(&AicpuScheduleInterface::InitAICPUScheduler)
        .stubs()
        .will(returnValue(0));
    int32_t ret = ComputeProcessMain(argc, argv);
    EXPECT_EQ(ret, 0);
    GlobalMockObject::verify();
}

TEST_F(AICPUScheduleTEST, RegEventMsgCallBackFunc_Fail2) {
    char processName[] = "aicpu_scheduler";
    char paramDeviceIdOk[] = "--deviceId=1";
    char paramPidOk[] = "--pid=2";
    char paramPidSignOk[] = "--pidSign=12345A";
    char paramModeOk[] = "--profilingMode=1";
    char paramLogLevelOk[] = "--logLevelInPid=0";
    char paramGrpNameOk[] = "--groupNameList=Grp1,Grp2";
    char paramGrpNumOk[] = "--groupNameNum=2";
    char paramDeviceModel[] = "--deviceMode=0";
    uint64_t rest = 0;
    MOCKER(system).stubs().will(returnValue(0));
    MOCKER(halGrpAttach).stubs().will(returnValue(0));
    MOCKER(dlopen).stubs().will(returnValue((void *)(&rest)));
    MOCKER(dlsym).stubs().will(invoke(dlsymStubAicpuSdMain));
    MOCKER(dlclose).stubs().will(invoke(dlcloseStub));
    MOCKER(halGetDeviceCountFromChip).stubs().will(returnValue(0));
    MOCKER(halGetDeviceFromChip).stubs().will(returnValue(0));
    MOCKER(halBuffInit).stubs().will(returnValue(0));
    MOCKER(RegEventMsgCallBackFunc).stubs().will(returnValue(0)).then(returnValue(1));

    char* argv[] = {processName, paramDeviceIdOk, paramPidOk, paramPidSignOk, paramModeOk, paramLogLevelOk, paramGrpNameOk, paramGrpNumOk, paramDeviceModel};
    int32_t argc = 9;
    MOCKER_CPP(&AicpuScheduleInterface::InitAICPUScheduler)
        .stubs()
        .will(returnValue(0));
    int32_t ret = ComputeProcessMain(argc, argv);
    EXPECT_EQ(ret, 0);
    GlobalMockObject::verify();
}

TEST_F(AICPUScheduleTEST, StopQsSubModuleInAicpu_Fail) {
    char processName[] = "aicpu_scheduler";
    char paramDeviceIdOk[] = "--deviceId=1";
    char paramPidOk[] = "--pid=2";
    char paramPidSignOk[] = "--pidSign=12345A";
    char paramModeOk[] = "--profilingMode=1";
    char paramLogLevelOk[] = "--logLevelInPid=0";
    char paramGrpNameOk[] = "--groupNameList=Grp1,Grp2";
    char paramGrpNumOk[] = "--groupNameNum=2";
    char paramDeviceModel[] = "--deviceMode=0";
    uint64_t rest = 0;
    MOCKER(system).stubs().will(returnValue(0));
    MOCKER(halGrpAttach).stubs().will(returnValue(0));
    MOCKER(dlopen).stubs().will(returnValue((void *)(&rest)));
    MOCKER(dlsym).stubs().will(invoke(dlsymStubAicpuSdMain)).then(invoke(dlsymStubAicpuSdMain)).then(invoke(dlsymStubAicpuSdMain)).then(invoke(dlsymStubAicpuSdMainNull));
    MOCKER(dlclose).stubs().will(invoke(dlcloseStub));
    MOCKER(halGetDeviceCountFromChip).stubs().will(returnValue(0));
    MOCKER(halGetDeviceFromChip).stubs().will(returnValue(0));
    MOCKER(halBuffInit).stubs().will(returnValue(0));

    char* argv[] = {processName, paramDeviceIdOk, paramPidOk, paramPidSignOk, paramModeOk, paramLogLevelOk, paramGrpNameOk, paramGrpNumOk, paramDeviceModel};
    int32_t argc = 9;
    MOCKER_CPP(&AicpuScheduleInterface::InitAICPUScheduler)
        .stubs()
        .will(returnValue(0));
    int32_t ret = ComputeProcessMain(argc, argv);
    EXPECT_EQ(ret, 0);
    GlobalMockObject::verify();
}

TEST_F(AICPUScheduleTEST, StartupResponse_Fail) {
    char processName[] = "aicpu_scheduler";
    char paramDeviceIdOk[] = "--deviceId=1";
    char paramPidOk[] = "--pid=2";
    char paramPidSignOk[] = "--pidSign=12345A";
    char paramModeOk[] = "--profilingMode=1";
    char paramLogLevelOk[] = "--logLevelInPid=0";
    char paramGrpNameOk[] = "--groupNameList=Grp1,Grp2";
    char paramGrpNumOk[] = "--groupNameNum=2";
    char paramDeviceModel[] = "--deviceMode=0";
    uint64_t rest = 0;
    MOCKER(system).stubs().will(returnValue(0));
    MOCKER(halGrpAttach).stubs().will(returnValue(0));
    MOCKER(dlsym).stubs().will(invoke(dlsymStubAicpuSdMain));
    MOCKER(halGetDeviceCountFromChip).stubs().will(returnValue(0));
    MOCKER(halGetDeviceFromChip).stubs().will(returnValue(0));
    MOCKER(halBuffInit).stubs().will(returnValue(0));
    MOCKER(StartupResponse).stubs().will(returnValue(-1));

    char* argv[] = {processName, paramDeviceIdOk, paramPidOk, paramPidSignOk, paramModeOk, paramLogLevelOk, paramGrpNameOk, paramGrpNumOk, paramDeviceModel};
    int32_t argc = 9;
    MOCKER_CPP(&AicpuScheduleInterface::InitAICPUScheduler)
        .stubs()
        .will(returnValue(0));
    int32_t ret = ComputeProcessMain(argc, argv);
    EXPECT_EQ(ret, -1);
    GlobalMockObject::verify();
}

TEST_F(AICPUScheduleTEST, WaitForShutDown_Fail) {
    char processName[] = "aicpu_scheduler";
    char paramDeviceIdOk[] = "--deviceId=1";
    char paramPidOk[] = "--pid=2";
    char paramPidSignOk[] = "--pidSign=12345A";
    char paramModeOk[] = "--profilingMode=1";
    char paramLogLevelOk[] = "--logLevelInPid=0";
    char paramGrpNameOk[] = "--groupNameList=Grp1,Grp2";
    char paramGrpNumOk[] = "--groupNameNum=2";
    char paramDeviceModel[] = "--deviceMode=0";
    uint64_t rest = 0;
    MOCKER(system).stubs().will(returnValue(0));
    MOCKER(halGrpAttach).stubs().will(returnValue(0));
    MOCKER(dlsym).stubs().will(invoke(dlsymStubAicpuSdMain));
    MOCKER(halGetDeviceCountFromChip).stubs().will(returnValue(0));
    MOCKER(halGetDeviceFromChip).stubs().will(returnValue(0));
    MOCKER(halBuffInit).stubs().will(returnValue(0));
    MOCKER(WaitForShutDown).stubs().will(returnValue(-1));

    char* argv[] = {processName, paramDeviceIdOk, paramPidOk, paramPidSignOk, paramModeOk, paramLogLevelOk, paramGrpNameOk, paramGrpNumOk, paramDeviceModel};
    int32_t argc = 9;
    MOCKER_CPP(&AicpuScheduleInterface::InitAICPUScheduler)
        .stubs()
        .will(returnValue(0));
    int32_t ret = ComputeProcessMain(argc, argv);
    EXPECT_EQ(ret, -1);
    GlobalMockObject::verify();
}

TEST_F(AICPUScheduleTEST, RegQueueScheduleModuleCallBack_Fail) {
    char processName[] = "aicpu_scheduler";
    char paramDeviceIdOk[] = "--deviceId=1";
    char paramPidOk[] = "--pid=2";
    char paramPidSignOk[] = "--pidSign=12345A";
    char paramModeOk[] = "--profilingMode=1";
    char paramLogLevelOk[] = "--logLevelInPid=0";
    char paramGrpNameOk[] = "--groupNameList=Grp1,Grp2";
    char paramGrpNumOk[] = "--groupNameNum=2";
    char paramDeviceModel[] = "--deviceMode=0";
    uint64_t rest = 0;
    MOCKER(system).stubs().will(returnValue(0));
    MOCKER(halGrpAttach).stubs().will(returnValue(0));
    MOCKER(dlopen).stubs().will(returnValue((void *)(&rest)));
    MOCKER(dlclose).stubs().will(invoke(dlcloseStub));
    MOCKER(dlsym).stubs().will(invoke(dlsymStubAicpuSdMainNull));
    MOCKER(halGetDeviceCountFromChip).stubs().will(returnValue(0));
    MOCKER(halGetDeviceFromChip).stubs().will(returnValue(0));
    MOCKER(halBuffInit).stubs().will(returnValue(0));

    char* argv[] = {processName, paramDeviceIdOk, paramPidOk, paramPidSignOk, paramModeOk, paramLogLevelOk, paramGrpNameOk, paramGrpNumOk, paramDeviceModel};
    int32_t argc = 9;
    MOCKER_CPP(&AicpuScheduleInterface::InitAICPUScheduler)
        .stubs()
        .will(returnValue(0));
    int32_t ret = ComputeProcessMain(argc, argv);
    EXPECT_EQ(ret, 0);
    GlobalMockObject::verify();
}

TEST_F(AICPUScheduleTEST, RegQueueScheduleModuleCallBack_Fail2) {
    char processName[] = "aicpu_scheduler";
    char paramDeviceIdOk[] = "--deviceId=1";
    char paramPidOk[] = "--pid=2";
    char paramPidSignOk[] = "--pidSign=12345A";
    char paramModeOk[] = "--profilingMode=1";
    char paramLogLevelOk[] = "--logLevelInPid=0";
    char paramGrpNameOk[] = "--groupNameList=Grp1,Grp2";
    char paramGrpNumOk[] = "--groupNameNum=2";
    char paramDeviceModel[] = "--deviceMode=0";
    uint64_t rest = 0;
    MOCKER(system).stubs().will(returnValue(0));
    MOCKER(halGrpAttach).stubs().will(returnValue(0));
    MOCKER(dlopen).stubs().will(returnValue((void *)(&rest)));
    MOCKER(dlsym).stubs().will(invoke(dlsymStubAicpuSdMain)).then(invoke(dlsymStubAicpuSdMain)).then(invoke(dlsymStubAicpuSdMainNull));
    MOCKER(dlclose).stubs().will(invoke(dlcloseStub));
    MOCKER(halGetDeviceCountFromChip).stubs().will(returnValue(0));
    MOCKER(halGetDeviceFromChip).stubs().will(returnValue(0));
    MOCKER(halBuffInit).stubs().will(returnValue(0));

    char* argv[] = {processName, paramDeviceIdOk, paramPidOk, paramPidSignOk, paramModeOk, paramLogLevelOk, paramGrpNameOk, paramGrpNumOk, paramDeviceModel};
    int32_t argc = 9;
    MOCKER_CPP(&AicpuScheduleInterface::InitAICPUScheduler)
        .stubs()
        .will(returnValue(0));
    int32_t ret = ComputeProcessMain(argc, argv);
    EXPECT_EQ(ret, 0);
    GlobalMockObject::verify();
}

TEST_F(AICPUScheduleTEST, SetBatchLoadMode_Succ) {
    char processName[] = "aicpu_scheduler";
    char paramDeviceIdOk[] = "--deviceId=1";
    char paramPidOk[] = "--pid=2";
    char paramPidSignOk[] = "--pidSign=12345A";
    char paramModeOk[] = "--profilingMode=1";
    char paramLogLevelOk[] = "--logLevelInPid=0";
    char paramGrpNameOk[] = "--groupNameList=Grp1,Grp2";
    char paramGrpNumOk[] = "--groupNameNum=2";
    char paramDeviceModel[] = "--deviceMode=0";
    char aicpuProcNum[] = "--aicpuProcNum=49";
    uint64_t rest = 0;
    MOCKER(system).stubs().will(returnValue(0));
    MOCKER(halGrpAttach).stubs().will(returnValue(0));
    MOCKER(dlopen).stubs().will(returnValue((void *)(&rest)));
    MOCKER(dlsym).stubs().will(invoke(dlsymStubAicpuSdMain));
    MOCKER(dlclose).stubs().will(invoke(dlcloseStub));
    MOCKER(halGetDeviceCountFromChip).stubs().will(returnValue(0));
    MOCKER(halGetDeviceFromChip).stubs().will(returnValue(0));
    MOCKER(halBuffInit).stubs().will(returnValue(0));
    MOCKER(StartupResponse).stubs().will(returnValue(0));
    MOCKER(RegEventMsgCallBackFunc).stubs().will(returnValue(1));

    char* argv[] = {processName, paramDeviceIdOk, paramPidOk, paramPidSignOk, paramModeOk, paramLogLevelOk, paramGrpNameOk, paramGrpNumOk, paramDeviceModel, aicpuProcNum};
    int32_t argc = 10;
    MOCKER_CPP(&AicpuScheduleInterface::InitAICPUScheduler)
        .stubs()
        .will(returnValue(0));
    int32_t ret = ComputeProcessMain(argc, argv);
    EXPECT_EQ(ret, 0);
    GlobalMockObject::verify();
}

TEST_F(AICPUScheduleTEST, FFTSPlusProcessInputDump_baseaddr_null_threadId_over) {
    OpDumpTask task(0, 0);
    ::toolkit::dumpdata::OpInput *opInput = task.baseDumpData_.add_input();
    if (opInput != nullptr) {
        opInput->set_size(1);
        uint64_t baseAddr = 0;
        task.inputsBaseAddr_.push_back(baseAddr);
        task.inputsAddrType_.push_back(0);
        task.UpdateDumpData();
        task.inputsSize_.push_back(2);
        task.inputsOffset_.push_back(2);
        task.opName_ = "aa";
        task.taskType_ = aicpu::dump::Task::FFTSPLUS;
        EXPECT_EQ(task.ProcessInputDump(task.baseDumpData_, "", IdeDumpStart(nullptr)), AICPU_SCHEDULE_OK);
    }
}

TEST_F(AICPUScheduleTEST, FFTSPlusProcessOutputDump_baseaddr_null_threadId_over) {
    OpDumpTask task(0, 0);
    ::toolkit::dumpdata::OpOutput *opOutput = task.baseDumpData_.add_output();
    if (opOutput != nullptr) {
        opOutput->set_size(1);
        uint64_t baseAddr = 0;
        task.outputsBaseAddr_.push_back(baseAddr);
        task.outputsAddrType_.push_back(0);
        task.UpdateDumpData();
        task.outputSize_.push_back(2);
        task.outputOffset_.push_back(2);
        task.opName_ = "aa";
        task.taskType_ = aicpu::dump::Task::FFTSPLUS;
        EXPECT_EQ(task.ProcessOutputDump(task.baseDumpData_, "", IdeDumpStart(nullptr)), AICPU_SCHEDULE_OK);
    }
}

TEST_F(AICPUScheduleTEST, FFTSPlusOpDebugProcessDumpFFTSPlusDataEventSuccessTest) {
    const uint32_t taskId = 3330;
    const uint32_t streamId = 3;
    const uint32_t contextid = 1;
    const uint32_t threadid = 2;
    const uint32_t modelId = 33;
    const int32_t dataType = 3;
    aicpu::dump::OpMappingInfo opMappingInfo;

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

    // load op mapping info
    EXPECT_EQ(LoadOpMappingInfo(opMappingInfoStr.c_str(), opMappingInfoStr.length()), AICPU_SCHEDULE_OK);

    OpDumpTaskManager &opDumpTaskMgr = OpDumpTaskManager::GetInstance();
    TaskInfoExt dumpTaskInfo(streamId, taskId);
    EXPECT_EQ(opDumpTaskMgr.DumpOpInfo(dumpTaskInfo, streamId, taskId, contextid, threadid), AICPU_SCHEDULE_OK);
}

TEST_F(AICPUScheduleTEST, FFTSPlusOpDebugProcessDumpFFTSPlusDataEventFailTestContextIsINVALID) {
    const uint32_t taskId = 3331;
    const uint32_t streamId = 3;
    const uint32_t modelId = 33;
    const int32_t dataType = 3;
    aicpu::dump::OpMappingInfo opMappingInfo;

    opMappingInfo.set_dump_path("dump_path");
    opMappingInfo.set_model_name("model_debug");
    opMappingInfo.set_model_id(modelId);

    uint64_t stepId = 1;
    uint64_t iterationsPerLoop = 1;
    uint64_t loopCond = 1;
    opMappingInfo.set_step_id_addr(reinterpret_cast<uint64_t>(&stepId));
    opMappingInfo.set_iterations_per_loop_addr(reinterpret_cast<uint64_t>(&iterationsPerLoop));
    opMappingInfo.set_loop_cond_addr(reinterpret_cast<uint64_t>(&loopCond));

    opMappingInfo.set_flag(0x01);
    aicpu::dump::Task *task = opMappingInfo.add_task();
    task->set_task_id(taskId);
    task->set_stream_id(streamId);
    task->set_context_id(0);
    task->set_tasktype(aicpu::dump::Task::FFTSPLUS);

    aicpu::dump::Op *op = task->mutable_op();
    op->set_op_name("op_name_debug");
    op->set_op_type("op_type_debug");

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
    aicpu::dump::Context *context = task->add_context();
    addPreProcessFFTSPLUSContext(task, context);
    std::string opMappingInfoStr;
    opMappingInfo.SerializeToString(&opMappingInfoStr);

    OpDumpTaskManager &opDumpTaskMgr = OpDumpTaskManager::GetInstance();
    // load op mapping info
    EXPECT_EQ(opDumpTaskMgr.LoadOpMappingInfo(opMappingInfoStr.c_str(), opMappingInfoStr.length()), AICPU_SCHEDULE_OK);

    TsAicpuSqe eventMsgDumpData = {0};
    eventMsgDumpData.pid = 0x1112;
    eventMsgDumpData.cmd_type = AICPU_DATADUMP_REPORT;
    eventMsgDumpData.vf_id = 0;
    eventMsgDumpData.tid = 0x10001;
    eventMsgDumpData.u.ts_to_aicpu_ffts_plus_datadump.model_id = 222;
    eventMsgDumpData.u.ts_to_aicpu_ffts_plus_datadump.stream_id = streamId;
    eventMsgDumpData.u.ts_to_aicpu_ffts_plus_datadump.task_id = taskId;
    eventMsgDumpData.u.ts_to_aicpu_ffts_plus_datadump.stream_id1 = streamId+1;
    eventMsgDumpData.u.ts_to_aicpu_ffts_plus_datadump.task_id1 = taskId+1;
    eventMsgDumpData.u.ts_to_aicpu_ffts_plus_datadump.context_id = INVALID_VAL;
    eventMsgDumpData.u.ts_to_aicpu_ffts_plus_datadump.thread_id = 0;
    AicpuSqeAdapter ada(eventMsgDumpData, 0U);
    EXPECT_EQ(AicpuEventProcess::GetInstance().ProcessDumpFFTSPlusDataEvent(ada), AICPU_SCHEDULE_OK);
}

TEST_F(AICPUScheduleTEST, FFTSPlusOpDebugProcessDumpFFTSPlusDataEventFailTestThreadIsINVALID) {
    const uint32_t taskId = 3332;
    const uint32_t streamId = 3;
    const uint32_t modelId = 33;
    const int32_t dataType = 3;
    aicpu::dump::OpMappingInfo opMappingInfo;

    opMappingInfo.set_dump_path("dump_path");
    opMappingInfo.set_model_name("model_debug");
    opMappingInfo.set_model_id(modelId);

    uint64_t stepId = 1;
    uint64_t iterationsPerLoop = 1;
    uint64_t loopCond = 1;
    opMappingInfo.set_step_id_addr(reinterpret_cast<uint64_t>(&stepId));
    opMappingInfo.set_iterations_per_loop_addr(reinterpret_cast<uint64_t>(&iterationsPerLoop));
    opMappingInfo.set_loop_cond_addr(reinterpret_cast<uint64_t>(&loopCond));

    opMappingInfo.set_flag(0x01);
    aicpu::dump::Task *task = opMappingInfo.add_task();
    task->set_task_id(taskId);
    task->set_stream_id(streamId);
    task->set_context_id(0);
    task->set_tasktype(aicpu::dump::Task::FFTSPLUS);

    aicpu::dump::Op *op = task->mutable_op();
    op->set_op_name("op_name_debug");
    op->set_op_type("op_type_debug");

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

    TsAicpuSqe eventMsgDumpData = {0};
    eventMsgDumpData.pid = 0x1112;
    eventMsgDumpData.cmd_type = AICPU_DATADUMP_REPORT;
    eventMsgDumpData.vf_id = 0;
    eventMsgDumpData.tid = 0x10001;
    eventMsgDumpData.u.ts_to_aicpu_ffts_plus_datadump.model_id = 222;
    eventMsgDumpData.u.ts_to_aicpu_ffts_plus_datadump.stream_id = streamId;
    eventMsgDumpData.u.ts_to_aicpu_ffts_plus_datadump.task_id = taskId;
    eventMsgDumpData.u.ts_to_aicpu_ffts_plus_datadump.stream_id1 = streamId+1;
    eventMsgDumpData.u.ts_to_aicpu_ffts_plus_datadump.task_id1 = taskId+1;
    eventMsgDumpData.u.ts_to_aicpu_ffts_plus_datadump.context_id = 0;
    eventMsgDumpData.u.ts_to_aicpu_ffts_plus_datadump.thread_id = INVALID_VAL;
    AicpuSqeAdapter ada(eventMsgDumpData, 0U);
    EXPECT_EQ(AicpuEventProcess::GetInstance().ProcessDumpFFTSPlusDataEvent(ada), AICPU_SCHEDULE_OK);

    // unload model
    opMappingInfo.set_flag(0x00);
    opMappingInfo.SerializeToString(&opMappingInfoStr);
    EXPECT_EQ(LoadOpMappingInfo(opMappingInfoStr.c_str(), opMappingInfoStr.length()), AICPU_SCHEDULE_OK);
}

TEST_F(AICPUScheduleTEST, FftsPlusDumpStats) {
    MOCKER_CPP(&IdeDumpData)
        .stubs()
        .will(returnValue(0));
    MOCKER_CPP(&IdeDumpStart)
        .stubs()
        .will(returnValue((void *)111));
    MOCKER(memcpy_s).stubs().will(returnValue(EOK));
    aicpu::dump::OpMappingInfo opMappingInfo;
    const uint32_t taskId = 22;
    const uint32_t streamId = 31;
    const uint32_t contextId = 1;
    const uint32_t modelId = 222;
    int32_t output[4] = {1, 2, 3, 4};
    int32_t *outputaddress = &output[0];
    int32_t outputSize = sizeof(output);
    int32_t outputoffset = outputSize/2;
    const int32_t dataType = 7; // int32
    int32_t input[4] = {1, 2, 3, 4};
    int32_t *inputaddress = &input[0];
    int32_t inputSize = sizeof(input);
    int32_t inputoffset = inputSize/2;

    opMappingInfo.set_dump_path("dump_path");
    opMappingInfo.set_model_name("model_n a.m\\ /e");
    opMappingInfo.set_model_id(modelId);
    uint64_t stepId = 1;
    uint64_t iterationsPerLoop = 1;

    opMappingInfo.set_flag(0x01);
    aicpu::dump::Task *task = opMappingInfo.add_task();
    {
        task->set_task_id(taskId);
        task->set_stream_id(streamId);
        aicpu::dump::Op *op = task->mutable_op();
        {
            op->set_op_name("op_n a.m\\ /e");
            op->set_op_type("op_t y.p\\e/ rr");
        }
        // task->set_end_graph();
        aicpu::dump::Input *input = task->add_input();
        {
            input->set_data_type(dataType);
            input->set_format(1);
            input->set_address(reinterpret_cast<uint64_t>(&inputaddress));
            input->set_addr_type(2);
            int32_t inData[4] = {10, 20, 30, 40};
            input->set_size(inputSize);
            input->set_offset(inputoffset);
        }
        aicpu::dump::Output *output = task->add_output();
        {
            output->set_data_type(dataType);
            output->set_format(1);
            output->set_addr_type(2);
            output->set_address(reinterpret_cast<uint64_t>(&outputaddress));
            output->set_original_name("original_name");
            output->set_original_output_index(11);
            output->set_original_output_data_type(dataType);
            output->set_original_output_format(1);
            output->set_size(outputSize);
            output->set_offset(outputoffset);
        }
        // aicpu::dump::OpBuffer *opBuffer = task->add_buffer();
        task->set_tasktype(aicpu::dump::Task::FFTSPLUS); // FFTSPLUS
        task->set_context_id(contextId);
        aicpu::dump::OpAttr *opAttr = task->add_attr();
        {
            opAttr->set_name("name");
            opAttr->set_value("value");
        }
    }
    aicpu::dump::Context *context = task->add_context();
    addPreProcessFFTSPLUSContext(task, context);
    // opMappingInfo.set_dump_step("1");
    opMappingInfo.set_dump_data(1);
    std::string opMappingInfoStr;
    opMappingInfo.SerializeToString(&opMappingInfoStr);
    OpDumpTaskManager &opDumpTaskMgr = OpDumpTaskManager::GetInstance();
    EXPECT_EQ(opDumpTaskMgr.LoadOpMappingInfo(opMappingInfoStr.c_str(), opMappingInfoStr.length()), AICPU_SCHEDULE_OK);

    TaskInfoExt dumpTaskInfo;
    dumpTaskInfo.streamId_ = streamId;
    dumpTaskInfo.taskId_ = taskId;
    dumpTaskInfo.contextId_ = contextId;
    dumpTaskInfo.threadId_ = 0;
    DumpFileName name(dumpTaskInfo.streamId_, dumpTaskInfo.taskId_, dumpTaskInfo.contextId_, dumpTaskInfo.threadId_);
    EXPECT_EQ(opDumpTaskMgr.DumpOpInfo(dumpTaskInfo, name), AICPU_SCHEDULE_OK);

    // unload model
    opMappingInfo.set_flag(0x00);
    opMappingInfo.SerializeToString(&opMappingInfoStr);
    opDumpTaskMgr.LoadOpMappingInfo(opMappingInfoStr.c_str(), opMappingInfoStr.length());
}

TEST_F(AICPUScheduleTEST, FFTSPlusOpDebugOpDumpTaskOpInfoSuccessTest) {
    const uint32_t taskId = 3333;
    const uint32_t streamId = 3;
    const uint32_t contextid = 1;
    const uint32_t threadid = 2;
    const uint32_t modelId = 33;
    const int32_t dataType = 3;
    aicpu::dump::OpMappingInfo opMappingInfo;

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

    // load op mapping info
    EXPECT_EQ(LoadOpMappingInfo(opMappingInfoStr.c_str(), opMappingInfoStr.length()), AICPU_SCHEDULE_OK);

    OpDumpTaskManager &opDumpTaskMgr = OpDumpTaskManager::GetInstance();
    TaskInfoExt dumpTaskInfo(streamId, taskId);
    EXPECT_EQ(opDumpTaskMgr.DumpOpInfo(dumpTaskInfo, streamId, taskId, contextid, threadid), AICPU_SCHEDULE_OK);

    // unload model
    opMappingInfo.set_flag(0x00);
    opMappingInfo.SerializeToString(&opMappingInfoStr);
    EXPECT_EQ(LoadOpMappingInfo(opMappingInfoStr.c_str(), opMappingInfoStr.length()), AICPU_SCHEDULE_OK);
}

void setdata(int32_t * a, int size)
{
    for (int32_t i = 0; i < size; i++) {
        *(a+i) = i;
    }
    for (int32_t i = 0; i < size; i++) {
        std::cout << *(a+i) << " ";
    }
    std::cout << std::endl;
}

TEST_F(AICPUScheduleTEST, FFTSPlus_ut_dynamicshape_dump) {
    MOCKER_CPP(&IdeDumpData)
        .stubs()
        .will(returnValue(0));
    MOCKER_CPP(&IdeDumpStart)
        .stubs()
        .will(returnValue((void *)111));
    MOCKER(memcpy_s).stubs().will(returnValue(EOK));
    aicpu::dump::OpMappingInfo opMappingInfo;
    const uint32_t taskId = 22;
    const uint32_t streamId = 31;
    const uint32_t contextId0 = 0;
    const uint32_t contextId1 = 1;
    const uint32_t threadId0 = 0;
    const uint32_t threadId1 = 1;
    const uint32_t modelId = 222;
    int32_t input0[10] = {0};
    setdata(input0, 10);
    int32_t input1[20] = {0};
    setdata(input1, 20);
    int32_t output0[30] = {0};
    setdata(output0, 30);
    int32_t output1[40] = {0};
    setdata(output1, 40);
    int32_t output2[50] = {0};
    setdata(output2, 50);
    uint64_t input0address  = &input0[0];
    uint64_t input1address  = &input1[0];
    uint64_t output0address = &output0[0];
    uint64_t output1address = &output1[0];
    uint64_t output2address = &output2[0];
    uint64_t input0size = sizeof(input0);
    uint64_t input1size = sizeof(input1);
    uint64_t output0size = sizeof(output0);
    uint64_t output1size = sizeof(output1);
    uint64_t output2size = sizeof(output2);
    std::cout << "sizeof(input0) =" << sizeof(input0)  << "   sizeof(int32_t) =" << sizeof(int32_t) <<std::endl;

    uint64_t ctx0thread0input0size = sizeof(input0)*6/10;    	uint64_t ctx0thread1input0size = sizeof(input0) -ctx0thread0input0size ;
    uint64_t ctx0thread0input1size = sizeof(input1)*6/10;    	uint64_t ctx0thread1input1size = sizeof(input1) -ctx0thread0input1size ;
    uint64_t ctx0thread0output0size =sizeof(output0)*6/10;   	uint64_t ctx0thread1output0size =sizeof(output0) -ctx0thread0output0size;
    uint64_t ctx0thread0output1size =sizeof(output1)*6/10;   	uint64_t ctx0thread1output1size =sizeof(output1) -ctx0thread0output1size;
    uint64_t ctx0thread0output2size =sizeof(output2)*6/10;    	uint64_t ctx0thread1output2size =sizeof(output2) -ctx0thread0output2size;
	
	uint64_t ctx0thread0input0addr = input0address ;    	uint64_t ctx0thread1input0addr = input0address  + ctx0thread0input0size ;
    uint64_t ctx0thread0input1addr = input1address ;    	uint64_t ctx0thread1input1addr = input1address  + ctx0thread0input1size ;
    uint64_t ctx0thread0output0addr =output0address;   	    uint64_t ctx0thread1output0addr =output0address + ctx0thread0output0size;
    uint64_t ctx0thread0output1addr =output1address;   	    uint64_t ctx0thread1output1addr =output1address + ctx0thread0output1size;
    uint64_t ctx0thread0output2addr =output2address;   	    uint64_t ctx0thread1output2addr =output2address + ctx0thread0output2size;
	std::cout << "ctx0thread0input0addr =" << ctx0thread0input0addr  << " ctx0thread0input0size =" << ctx0thread0input0size  << "|"<< " ctx0thread1input0addr =" << ctx0thread1input0addr << " ctx0thread1input0size =" << ctx0thread1input0size <<std::endl;
	std::cout << "ctx0thread0input1addr =" << ctx0thread0input1addr  << " ctx0thread0input1size =" << ctx0thread0input1size  << "|"<< " ctx0thread1input1addr =" << ctx0thread1input1addr << " ctx0thread1input1size =" << ctx0thread1input1size <<std::endl;
	std::cout << "ctx0thread0output0addr=" << ctx0thread0output0addr << " ctx0thread0output0size=" << ctx0thread0output0size << "|"<< " ctx0thread1output0addr=" << ctx0thread1output0addr<< " ctx0thread1output0size=" << ctx0thread1output0size<<std::endl;
	std::cout << "ctx0thread0output1addr=" << ctx0thread0output1addr << " ctx0thread0output1size=" << ctx0thread0output1size << "|"<< " ctx0thread1output1addr=" << ctx0thread1output1addr<< " ctx0thread1output1size=" << ctx0thread1output1size<<std::endl;
	std::cout << "ctx0thread0output2addr=" << ctx0thread0output2addr << " ctx0thread0output2size=" << ctx0thread0output2size << "|"<< " ctx0thread1output2addr=" << ctx0thread1output2addr<< " ctx0thread1output2size=" << ctx0thread1output2size<<std::endl;

    const int32_t dataType = 7; // int32

    opMappingInfo.set_dump_path("dump_path");
    opMappingInfo.set_model_name("model_n a.m\\ /e");
    opMappingInfo.set_model_id(modelId);
    uint64_t stepId = 1;
    uint64_t iterationsPerLoop = 1;

    opMappingInfo.set_flag(0x01);
    aicpu::dump::Task *task = opMappingInfo.add_task();
    {
        task->set_task_id(taskId);
        task->set_stream_id(streamId);
        aicpu::dump::Op *op = task->mutable_op();
        {
            op->set_op_name("op_n a.m\\ /e");
            op->set_op_type("op_t y.p\\e/ rr");
        }
        // task->set_end_graph();
        aicpu::dump::Input *input0 = task->add_input();
        {
            input0->set_data_type(dataType);
            input0->set_format(1);
            input0->set_address(0);
            input0->set_addr_type(2);
            input0->set_size(0);
            input0->set_offset(0);
        }
        aicpu::dump::Input *input1 = task->add_input();
        {
            input1->set_data_type(dataType);
            input1->set_format(1);
            input1->set_address(0);
            input1->set_addr_type(2);
            input1->set_size(0);
            input1->set_offset(0);
        }
        aicpu::dump::Output *output0 = task->add_output();
        {
            output0->set_data_type(dataType);
            output0->set_format(1);
            output0->set_addr_type(2);
            output0->set_address(0);
            output0->set_original_name("original_name");
            output0->set_original_output_index(11);
            output0->set_original_output_data_type(dataType);
            output0->set_original_output_format(1);
            output0->set_size(0);
            output0->set_offset(0);
        }
        aicpu::dump::Output *output1 = task->add_output();
        {
            output1->set_data_type(dataType);
            output1->set_format(1);
            output1->set_addr_type(2);
            output1->set_address(0);
            output1->set_original_name("original_name");
            output1->set_original_output_index(11);
            output1->set_original_output_data_type(dataType);
            output1->set_original_output_format(1);
            output1->set_size(0);
            output1->set_offset(0);
        }
        aicpu::dump::Output *output2 = task->add_output();
        {
            output2->set_data_type(dataType);
            output2->set_format(1);
            output2->set_addr_type(2);
            output2->set_address(0);
            output2->set_original_name("original_name");
            output2->set_original_output_index(11);
            output2->set_original_output_data_type(dataType);
            output2->set_original_output_format(1);
            output2->set_size(0);
            output2->set_offset(0);
        }
        // aicpu::dump::OpBuffer *opBuffer = task->add_buffer();
        task->set_tasktype(aicpu::dump::Task::FFTSPLUS); // FFTSPLUS
        //task->set_context_id(contextId);
        aicpu::dump::Context *context0 = task->add_context();
        {
            context0->set_context_id(contextId0);
            context0->set_thread_id(0);
            aicpu::dump::RealAddressAndSize *input0 = context0->add_input(); //input 0
            {
                input0->set_address(ctx0thread0input0addr);
                input0->set_size(ctx0thread0input0size);
            }
            aicpu::dump::RealAddressAndSize *input1 = context0->add_input(); //input 1
            {
                input1->set_address(ctx0thread0input1addr);
                input1->set_size(ctx0thread0input1size);
            }
            aicpu::dump::RealAddressAndSize *output0 = context0->add_output(); //output 0
            {
                output0->set_address(ctx0thread0output0addr);
                output0->set_size(ctx0thread0output0size);
            }
            aicpu::dump::RealAddressAndSize *output1 = context0->add_output(); //output 1
            {
                output1->set_address(ctx0thread0output1addr);
                output1->set_size(ctx0thread0output1size);
            }
            aicpu::dump::RealAddressAndSize *output2 = context0->add_output(); //output 2
            {
                output2->set_address(ctx0thread0output2addr);
                output2->set_size(ctx0thread0output2size);
            }
        }

        aicpu::dump::Context *context1 = task->add_context();
        {
            context1->set_context_id(contextId0);
            context1->set_thread_id(1);
            aicpu::dump::RealAddressAndSize *input0 = context1->add_input(); //input 0
            {
                input0->set_address(ctx0thread1input0addr);
                input0->set_size(ctx0thread1input0size);
            }
            aicpu::dump::RealAddressAndSize *input1 = context1->add_input(); //input 1
            {
                input1->set_address(ctx0thread1input1addr);
                input1->set_size(ctx0thread1input1size);
            }
            aicpu::dump::RealAddressAndSize *output0 = context1->add_output(); //output 0
            {
                output0->set_address(ctx0thread1output0addr);
                output0->set_size(ctx0thread1output0size);
            }
            aicpu::dump::RealAddressAndSize *output1 = context1->add_output(); //output 1
            {
                output1->set_address(ctx0thread1output1addr);
                output1->set_size(ctx0thread1output1size);
            }
            aicpu::dump::RealAddressAndSize *output2 = context1->add_output(); //output 2
            {
                output2->set_address(ctx0thread1output2addr);
                output2->set_size(ctx0thread1output2size);
            }
        }

        aicpu::dump::OpAttr *opAttr = task->add_attr();
        {
            opAttr->set_name("name");
            opAttr->set_value("value");
        }
    }
    // opMappingInfo.set_dump_step("1");
    opMappingInfo.set_dump_data(0); // 0:datadump;1:stats

    std::string opMappingInfoStr;
    opMappingInfo.SerializeToString(&opMappingInfoStr);
    OpDumpTaskManager &opDumpTaskMgr = OpDumpTaskManager::GetInstance();
    EXPECT_EQ(opDumpTaskMgr.LoadOpMappingInfo(opMappingInfoStr.c_str(), opMappingInfoStr.length()), AICPU_SCHEDULE_OK);

    TaskInfoExt dumpTaskInfo;
    dumpTaskInfo.streamId_ = streamId;
    dumpTaskInfo.taskId_ = taskId;
    dumpTaskInfo.contextId_ = contextId0;
    dumpTaskInfo.threadId_ = 0;
    DumpFileName name(dumpTaskInfo.streamId_, dumpTaskInfo.taskId_, dumpTaskInfo.contextId_, dumpTaskInfo.threadId_);
    opDumpTaskMgr.DumpOpInfo(dumpTaskInfo, name);

    dumpTaskInfo.streamId_ = streamId;
    dumpTaskInfo.taskId_ = taskId;
    dumpTaskInfo.contextId_ = contextId0;
    dumpTaskInfo.threadId_ = 1;
    DumpFileName name1(dumpTaskInfo.streamId_, dumpTaskInfo.taskId_, dumpTaskInfo.contextId_, dumpTaskInfo.threadId_);
    opDumpTaskMgr.DumpOpInfo(dumpTaskInfo, name1);

    // unload model
    opMappingInfo.set_flag(0x00);
    opMappingInfo.SerializeToString(&opMappingInfoStr);
    opDumpTaskMgr.LoadOpMappingInfo(opMappingInfoStr.c_str(), opMappingInfoStr.length());
}

TEST_F(AICPUScheduleTEST, FFTSPlus_ut_dynamicshape_dump1) {
    MOCKER_CPP(&IdeDumpData)
        .stubs()
        .will(returnValue(0));
    MOCKER_CPP(&IdeDumpStart)
        .stubs()
        .will(returnValue((void *)111));
    MOCKER(memcpy_s).stubs().will(returnValue(EOK));
    aicpu::dump::OpMappingInfo opMappingInfo;
    const uint32_t taskId = 23;
    const uint32_t streamId = 32;
    const uint32_t contextId0 = 0;
    const uint32_t contextId1 = 1;
    const uint32_t threadId0 = 0;
    const uint32_t threadId1 = 1;
    const uint32_t modelId = 222;
    int32_t input0[10] = {0};
    setdata(input0, 10);
    int32_t input1[20] = {0};
    setdata(input1, 20);
    int32_t output0[30] = {0};
    setdata(output0, 30);
    int32_t output1[40] = {0};
    setdata(output1, 40);
    int32_t output2[50] = {0};
    setdata(output2, 50);
    uint64_t input0address  = &input0[0];
    uint64_t input1address  = &input1[0];
    uint64_t output0address = &output0[0];
    uint64_t output1address = &output1[0];
    uint64_t output2address = &output2[0];
	uint64_t input0size = sizeof(input0);
	uint64_t input1size = sizeof(input1);
	uint64_t output0size = sizeof(output0);
	uint64_t output1size = sizeof(output1);
	uint64_t output2size = sizeof(output2);
    std::cout << "sizeof(input0) =" << sizeof(input0)  << "   sizeof(int32_t) =" << sizeof(int32_t) <<std::endl;

    uint64_t ctx0thread0input0size = sizeof(input0)*6/10;    	uint64_t ctx0thread1input0size = sizeof(input0) -ctx0thread0input0size ;
    uint64_t ctx0thread0input1size = sizeof(input1)*6/10;    	uint64_t ctx0thread1input1size = sizeof(input1) -ctx0thread0input1size ;
    uint64_t ctx0thread0output0size =sizeof(output0)*6/10;   	uint64_t ctx0thread1output0size =sizeof(output0) -ctx0thread0output0size;
    uint64_t ctx0thread0output1size =sizeof(output1)*6/10;   	uint64_t ctx0thread1output1size =sizeof(output1) -ctx0thread0output1size;
    uint64_t ctx0thread0output2size =sizeof(output2)*6/10;    	uint64_t ctx0thread1output2size =sizeof(output2) -ctx0thread0output2size;
	
	uint64_t ctx0thread0input0addr = input0address ;    	uint64_t ctx0thread1input0addr = input0address  + ctx0thread0input0size ;
    uint64_t ctx0thread0input1addr = input1address ;    	uint64_t ctx0thread1input1addr = input1address  + ctx0thread0input1size ;
    uint64_t ctx0thread0output0addr =output0address;   	    uint64_t ctx0thread1output0addr =output0address + ctx0thread0output0size;
    uint64_t ctx0thread0output1addr =output1address;   	    uint64_t ctx0thread1output1addr =output1address + ctx0thread0output1size;
    uint64_t ctx0thread0output2addr =output2address;   	    uint64_t ctx0thread1output2addr =output2address + ctx0thread0output2size;
	std::cout << "ctx0thread0input0addr =" << ctx0thread0input0addr  << " ctx0thread0input0size =" << ctx0thread0input0size  << "|"<< " ctx0thread1input0addr =" << ctx0thread1input0addr << " ctx0thread1input0size =" << ctx0thread1input0size <<std::endl;
	std::cout << "ctx0thread0input1addr =" << ctx0thread0input1addr  << " ctx0thread0input1size =" << ctx0thread0input1size  << "|"<< " ctx0thread1input1addr =" << ctx0thread1input1addr << " ctx0thread1input1size =" << ctx0thread1input1size <<std::endl;
	std::cout << "ctx0thread0output0addr=" << ctx0thread0output0addr << " ctx0thread0output0size=" << ctx0thread0output0size << "|"<< " ctx0thread1output0addr=" << ctx0thread1output0addr<< " ctx0thread1output0size=" << ctx0thread1output0size<<std::endl;
	std::cout << "ctx0thread0output1addr=" << ctx0thread0output1addr << " ctx0thread0output1size=" << ctx0thread0output1size << "|"<< " ctx0thread1output1addr=" << ctx0thread1output1addr<< " ctx0thread1output1size=" << ctx0thread1output1size<<std::endl;
	std::cout << "ctx0thread0output2addr=" << ctx0thread0output2addr << " ctx0thread0output2size=" << ctx0thread0output2size << "|"<< " ctx0thread1output2addr=" << ctx0thread1output2addr<< " ctx0thread1output2size=" << ctx0thread1output2size<<std::endl;

    const int32_t dataType = 7; // int32

    opMappingInfo.set_dump_path("dump_path");
    opMappingInfo.set_model_name("model_n a.m\\ /e");
    opMappingInfo.set_model_id(modelId);
    uint64_t stepId = 1;
    uint64_t iterationsPerLoop = 1;

    opMappingInfo.set_flag(0x01);
    aicpu::dump::Task *task = opMappingInfo.add_task();
    {
        task->set_task_id(taskId);
        task->set_stream_id(streamId);
        aicpu::dump::Op *op = task->mutable_op();
        {
            op->set_op_name("op_n a.m\\ /e");
            op->set_op_type("op_t y.p\\e/ rr");
        }
        // task->set_end_graph();
        aicpu::dump::Input *input0 = task->add_input();
        {
            input0->set_data_type(dataType);
            input0->set_format(1);
            input0->set_address(input0address);
            input0->set_addr_type(2);
            input0->set_size(input0size);
            input0->set_offset(0);
        }
        aicpu::dump::Input *input1 = task->add_input();
        {
            input1->set_data_type(dataType);
            input1->set_format(1);
            input1->set_address(input1address);
            input1->set_addr_type(2);
            input1->set_size(input1size);
            input1->set_offset(0);
        }
        aicpu::dump::Output *output0 = task->add_output();
        {
            output0->set_data_type(dataType);
            output0->set_format(1);
            output0->set_addr_type(2);
            output0->set_address(output0address);
            output0->set_original_name("original_name");
            output0->set_original_output_index(11);
            output0->set_original_output_data_type(dataType);
            output0->set_original_output_format(1);
            output0->set_size(output0size);
            output0->set_offset(0);
        }
        aicpu::dump::Output *output1 = task->add_output();
        {
            output1->set_data_type(dataType);
            output1->set_format(1);
            output1->set_addr_type(2);
            output1->set_address(output1address);
            output1->set_original_name("original_name");
            output1->set_original_output_index(11);
            output1->set_original_output_data_type(dataType);
            output1->set_original_output_format(1);
            output1->set_size(output1size);
            output1->set_offset(0);
        }
        aicpu::dump::Output *output2 = task->add_output();
        {
            output2->set_data_type(dataType);
            output2->set_format(1);
            output2->set_addr_type(2);
            output2->set_address(output2address);
            output2->set_original_name("original_name");
            output2->set_original_output_index(11);
            output2->set_original_output_data_type(dataType);
            output2->set_original_output_format(1);
            output2->set_size(output2size);
            output2->set_offset(0);
        }
        // aicpu::dump::OpBuffer *opBuffer = task->add_buffer();
        task->set_tasktype(0); // no FFTSPLUS
        //task->set_context_id(contextId);

        aicpu::dump::OpAttr *opAttr = task->add_attr();
        {
            opAttr->set_name("name");
            opAttr->set_value("value");
        }
    }
    // opMappingInfo.set_dump_step("1");
    opMappingInfo.set_dump_data(0); // 0:datadump;1:stats

    std::string opMappingInfoStr;
    opMappingInfo.SerializeToString(&opMappingInfoStr);
    OpDumpTaskManager &opDumpTaskMgr = OpDumpTaskManager::GetInstance();
    EXPECT_EQ(opDumpTaskMgr.LoadOpMappingInfo(opMappingInfoStr.c_str(), opMappingInfoStr.length()), AICPU_SCHEDULE_OK);

    TaskInfoExt dumpTaskInfo;
    dumpTaskInfo.streamId_ = streamId;
    dumpTaskInfo.taskId_ = taskId;
    dumpTaskInfo.contextId_ = 65535;
    dumpTaskInfo.threadId_ = 65535;
    DumpFileName name(dumpTaskInfo.streamId_, dumpTaskInfo.taskId_, dumpTaskInfo.contextId_, dumpTaskInfo.threadId_);
    opDumpTaskMgr.DumpOpInfo(dumpTaskInfo, name);

    dumpTaskInfo.streamId_ = streamId;
    dumpTaskInfo.taskId_ = taskId;
    dumpTaskInfo.contextId_ = 65535;
    dumpTaskInfo.threadId_ = 65535;
    opDumpTaskMgr.DumpOpInfo(dumpTaskInfo, name);

    // unload model
    opMappingInfo.set_flag(0x00);
    opMappingInfo.SerializeToString(&opMappingInfoStr);
    opDumpTaskMgr.LoadOpMappingInfo(opMappingInfoStr.c_str(), opMappingInfoStr.length());
}

// 此用例请务必保证最后执行，可能影响其余用例的正常运行
TEST_F(AICPUScheduleTEST, Ut_MainTestWithVf) {
    char processName[] = "aicpu_scheduler";
    char paramDeviceIdOk[] = "--deviceId=2";
    char paramPidOk[] = "--pid=4";
    char paramPidSignOk[] = "--pidSign=1234A";
    char paramModeOk[] = "--profilingMode=1";
    char paramLogLevelOk[] = "--logLevelInPid=0";
    char paramVfId[] = "--vfId=2";
    char paramGrpNameOk[] = "--groupNameList=Grp3";
    char paramGrpNumOk[] = "--groupNameNum=1";
    MOCKER(system)
        .stubs()
        .will(returnValue(0));

    MOCKER(open, int(const char*, int)).stubs().will(returnValue(0));
    MOCKER(ioctl, int(int, int, void*)).stubs().will(returnValue(0));
    MOCKER(close).stubs().will(returnValue(0));

    char* argv[] = { processName, paramDeviceIdOk, paramPidOk, paramPidSignOk,
                     paramModeOk, paramLogLevelOk, paramVfId, paramGrpNameOk, paramGrpNumOk };
    int32_t argc = 9;
    MOCKER_CPP(&AicpuScheduleInterface::InitAICPUScheduler)
        .stubs()
        .will(returnValue(0));
    int32_t ret = ComputeProcessMain(argc, argv);
    EXPECT_EQ(ret, 0);
}

TEST_F(AICPUScheduleTEST, UtMainTestWithVf_openFail) {
    char processName[] = "aicpu_scheduler";
    char paramDeviceIdOk[] = "--deviceId=2";
    char paramPidOk[] = "--pid=4";
    char paramPidSignOk[] = "--pidSign=1234A";
    char paramModeOk[] = "--profilingMode=1";
    char paramLogLevelOk[] = "--logLevelInPid=0";
    char paramVfId[] = "--vfId=2";
    char paramGrpNameOk[] = "--groupNameList=Grp3";
    char paramGrpNumOk[] = "--groupNameNum=1";
    MOCKER(system)
        .stubs()
        .will(returnValue(0));

    MOCKER(open, int(const char*, int)).stubs().will(returnValue(-1));
    MOCKER(ioctl, int(int, int, void*)).stubs().will(returnValue(0));
    MOCKER(close).stubs().will(returnValue(0));

    char* argv[] = { processName, paramDeviceIdOk, paramPidOk, paramPidSignOk,
                     paramModeOk, paramLogLevelOk, paramVfId, paramGrpNameOk, paramGrpNumOk };
    int32_t argc = 9;
    MOCKER_CPP(&AicpuScheduleInterface::InitAICPUScheduler)
        .stubs()
        .will(returnValue(0));
    int32_t ret = ComputeProcessMain(argc, argv);
    EXPECT_EQ(ret, 0);

    MOCKER(open, int(const char*, int)).stubs().will(returnValue(-1));
    ret = ComputeProcessMain(argc, argv);
    EXPECT_EQ(ret, 0);
}

TEST_F(AICPUScheduleTEST, AddToCgroup_ERROR_001)
{
    char processName[] = "aicpu_scheduler";
    char paramDeviceIdOk[] = "--deviceId=2";
    char paramPidOk[] = "--pid=4";
    char paramPidSignOk[] = "--pidSign=1234A";
    char paramModeOk[] = "--profilingMode=1";
    char paramLogLevelOk[] = "--logLevelInPid=0";
    char paramVfId[] = "--vfId=2";
    char paramGrpNameOk[] = "--groupNameList=Grp3";
    char paramGrpNumOk[] = "--groupNameNum=1";
   char* argv[] = { processName, paramDeviceIdOk, paramPidOk, paramPidSignOk,
                     paramModeOk, paramLogLevelOk, paramVfId, paramGrpNameOk, paramGrpNumOk };
    int32_t argc = 9;
    MOCKER_CPP(&AicpuSchedule::AddToCgroup).stubs().will(returnValue(false));
    MOCKER(access)
        .stubs()
        .will(returnValue(0));
     MOCKER(waitpid)
        .stubs()
        .will(returnValue(-1));
    int32_t ret = ComputeProcessMain(argc, argv);
    EXPECT_EQ(ret, -1);
}

TEST_F(AICPUScheduleTEST, GetLogLevel_001)
{
    char processName[] = "aicpu_scheduler";
    char paramCcecpuLogLevel[] = "--ccecpuLogLevel=1";
    char paramAicpuLogLevel[] = "--aicpuLogLevel=1";
    MOCKER_CPP(&ArgsParser::CheckRequiredParas).stubs().will(returnValue(true));
    MOCKER_CPP(&ArgsParser::GetCcecpuLogLevel).stubs().will(returnValue(0));
    MOCKER_CPP(&ArgsParser::GetAicpuLogLevel).stubs().will(returnValue(0));
    MOCKER(dlog_setlevel).stubs().will(returnValue(0)).then(returnValue(-1)).then(returnValue(-1));
    MOCKER_CPP(&AicpuSchedule::AddToCgroup).stubs().will(returnValue(-1));
    char *argv[] = {processName, paramCcecpuLogLevel, paramAicpuLogLevel};
    int32_t argc = 3;
    auto ret = ComputeProcessMain(argc, argv);
    EXPECT_EQ(ret, -1);
}

TEST_F(AICPUScheduleTEST, AddToCgroup_Adc)
{

    MOCKER_CPP(&FeatureCtrl::ShouldAddtocGroup).stubs().will(returnValue(false));
    const bool ret = AddToCgroup(0, 0);
    EXPECT_EQ(ret, true);
    GlobalMockObject::verify();
}

TEST_F(AICPUScheduleTEST, AddToCgroupSuccess)
{
    MOCKER(access).stubs().will(returnValue(0));
    MOCKER_CPP(AicpuUtil::ExecuteCmd).stubs().will(returnValue(0));
    const bool ret = AddToCgroup(0, 0);
    EXPECT_EQ(ret, true);
    GlobalMockObject::verify();
}

int32_t SubProcCallBackFuncInfo(uint32_t deviceID) {
    std::cout << "enter SubProcCallBackFuncInfo" << std::endl;
    return TS_SUCCESS;
}

int32_t SubProcCallBackFuncInfoFail(uint32_t deviceID) {
    return 1;
}

void *dlsymStubForDvpp(void *const soHandle, const char_t *const funcName)
{
    std::cout << "enter dlsymStub" << std::endl;
    return (reinterpret_cast<void *>(SubProcCallBackFuncInfo));
}

TEST_F(AICPUScheduleTEST, SetDeviceIdToDvpp_01)
{
    AicpuSchedule::AicpuSoManager::GetInstance().SetDeviceIdToDvpp(32);
    EXPECT_EQ(AicpuSchedule::AicpuSoManager::GetInstance().soHandle_, nullptr);
}

TEST_F(AICPUScheduleTEST, SetDeviceIdToDvpp_02)
{
    AicpuSchedule::AicpuSoManager &aicpuSoManager = AicpuSchedule::AicpuSoManager::GetInstance();
    int32_t addr = 1234;
    aicpuSoManager.soHandle_ = &addr;
    MOCKER(dlsym).stubs().will(invoke(dlsymStubForDvpp));
    aicpuSoManager.SetDeviceIdToDvpp(32);
    EXPECT_NE(AicpuSchedule::AicpuSoManager::GetInstance().soHandle_, nullptr);
    aicpuSoManager.soHandle_ = nullptr;
}

TEST_F(AICPUScheduleTEST, SetDeviceIdToDvppDlsymFail)
{
    MOCKER(dlsym).stubs().will(returnValue((void *)nullptr));
    char_t *path = "test";
    MOCKER(realpath).stubs().will(returnValue(path));
    MOCKER(dlopen).stubs().will(returnValue((void*)(123)));
    AicpuSchedule::AicpuSoManager::GetInstance().SetDeviceIdToDvpp(32);
    EXPECT_NE(AicpuSchedule::AicpuSoManager::GetInstance().soHandle_, nullptr);
}

TEST_F(AICPUScheduleTEST, SetDeviceIdToDvppSetDeviceFail)
{
    MOCKER(dlsym).stubs().will(returnValue((void *)SubProcCallBackFuncInfoFail));
    char_t *path = "test";
    MOCKER(realpath).stubs().will(returnValue(path));
    MOCKER(dlopen).stubs().will(returnValue((void*)(123)));
    AicpuSchedule::AicpuSoManager::GetInstance().SetDeviceIdToDvpp(32);
    EXPECT_NE(AicpuSchedule::AicpuSoManager::GetInstance().soHandle_, nullptr);
}

TEST_F(AICPUScheduleTEST, OpenSoFile_01)
{
    MOCKER(dlopen).stubs().will(returnValue((void*)(nullptr)));
    char_t *path = "test";
    MOCKER(realpath).stubs().will(returnValue(path));
    void *retHandle = nullptr;
    const bool ret = AicpuSchedule::AicpuSoManager::GetInstance().OpenSo("test");
    EXPECT_EQ(ret, false);
}

TEST_F(AICPUScheduleTEST, OpenSoFile_02)
{
    MOCKER(dlopen).stubs().will(returnValue((void*)(123)));
    char_t *path = "test";
    MOCKER(realpath).stubs().will(returnValue(path));
    void *retHandle = nullptr;
    const bool ret = AicpuSchedule::AicpuSoManager::GetInstance().OpenSo("test");
    EXPECT_EQ(ret, true);
}

TEST_F(AICPUScheduleTEST, OpenSoMemsetFail)
{
    MOCKER(memset_s).stubs().will(returnValue(-1));
    const bool ret = AicpuSchedule::AicpuSoManager::GetInstance().OpenSo("test");
    EXPECT_EQ(ret, false);
}

TEST_F(AICPUScheduleTEST, CloseSo_01)
{
    MOCKER(dlclose).stubs().will(returnValue(-1));
    int32_t addr = 1234;
    AicpuSchedule::AicpuSoManager::GetInstance().CloseSo();
    EXPECT_EQ(AicpuSchedule::AicpuSoManager::GetInstance().soHandle_, nullptr);
}

TEST_F(AICPUScheduleTEST, CloseSo_02)
{
    MOCKER(dlclose).stubs().will(returnValue(0));
    int32_t addr = 1234;
    AicpuSchedule::AicpuSoManager::GetInstance().CloseSo();
    EXPECT_EQ(AicpuSchedule::AicpuSoManager::GetInstance().soHandle_, nullptr);
}

uint32_t CastV2(void * parm)
{
    return 0;
}

TEST_F(AICPUScheduleTEST, ProcessHWTSKernelEvent_KFC_UTest) {
    MOCKER(dlsym).stubs().will(returnValue((void *)CastV2));
    MOCKER_CPP(&MessageQueue::SendResponse).stubs();
    event_info eventInfo = g_event;
    eventInfo.comm.event_id = EVENT_TS_HWTS_KERNEL;
    eventInfo.priv.msg_len = sizeof(hwts_ts_task);
    struct hwts_ts_task *eventMsg = reinterpret_cast<hwts_ts_task *>(eventInfo.priv.msg);
    eventMsg->mailbox_id = 1;
    eventMsg->serial_no = 9527;
    eventMsg->kernel_info.kernel_type = KERNEL_TYPE_AICPU_KFC;
    eventMsg->kernel_info.streamID = 203;
    char kernelName[] = "CastV2";
    char kernelSo[] = "libcpu_kernels.so";
    eventMsg->kernel_info.kernelName = (uintptr_t)kernelName;
    eventMsg->kernel_info.kernelSo = (uintptr_t)kernelSo;
    int ret = AicpuEventManager::GetInstance().ProcessEvent(eventInfo, 0);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
}

TEST_F(AICPUScheduleTEST, ProcessHWTSLoadPlatformFromBuf) {
    event_info eventInfo = g_event;
    eventInfo.priv.msg_len = sizeof(ts_aicpu_sqe_t);
    ts_aicpu_sqe_t *ctrlMsg = reinterpret_cast<ts_aicpu_sqe_t *>(eventInfo.priv.msg);
    ctrlMsg->cmd_type = AICPU_INFO_LOAD;
    ctrlMsg->u.ts_to_aicpu_info.length = 0U;
    int ret = AicpuEventManager::GetInstance().ProcessHWTSControlEvent(eventInfo);
    EXPECT_NE(ret, AICPU_SCHEDULE_OK);
}

TEST_F(AICPUScheduleTEST, ProcessHWTSControlEventNotifyRecord) {
    event_info eventInfo = g_event;
    eventInfo.priv.msg_len = sizeof(ts_aicpu_sqe_t);
    ts_aicpu_sqe_t *ctrlMsg = reinterpret_cast<ts_aicpu_sqe_t *>(eventInfo.priv.msg);
    ctrlMsg->cmd_type = AICPU_NOTIFY_RECORD;
    ctrlMsg->u.ts_to_aicpu_info.length = 0U;
    int ret = AicpuEventManager::GetInstance().ProcessHWTSControlEvent(eventInfo);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
}

TEST_F(AICPUScheduleTEST, ProcessHWTSControlEventDatadumpReport) {
    event_info eventInfo = g_event;
    eventInfo.priv.msg_len = sizeof(ts_aicpu_sqe_t);
    ts_aicpu_sqe_t *ctrlMsg = reinterpret_cast<ts_aicpu_sqe_t *>(eventInfo.priv.msg);
    ctrlMsg->cmd_type = AICPU_DATADUMP_REPORT;
    ctrlMsg->u.ts_to_aicpu_info.length = 0U;
    MOCKER_CPP(&AicpuEventProcess::ProcessDumpDataEvent).stubs().will(returnValue(AICPU_SCHEDULE_OK));
    int ret = AicpuEventManager::GetInstance().ProcessHWTSControlEvent(eventInfo);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
}

TEST_F(AICPUScheduleTEST, ProcessHWTSControlEventDatadumpLoadInfo) {
    event_info eventInfo = g_event;
    eventInfo.priv.msg_len = sizeof(ts_aicpu_sqe_t);
    ts_aicpu_sqe_t *ctrlMsg = reinterpret_cast<ts_aicpu_sqe_t *>(eventInfo.priv.msg);
    ctrlMsg->cmd_type = AICPU_DATADUMP_LOADINFO;
    ctrlMsg->u.ts_to_aicpu_info.length = 0U;
    MOCKER_CPP(&AicpuEventProcess::ProcessLoadOpMappingEvent).stubs().will(returnValue(AICPU_SCHEDULE_OK));
    int ret = AicpuEventManager::GetInstance().ProcessHWTSControlEvent(eventInfo);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
}

TEST_F(AICPUScheduleTEST, ProcessHWTSControlEventFftsDatadumpReport) {
    event_info eventInfo = g_event;
    eventInfo.priv.msg_len = sizeof(ts_aicpu_sqe_t);
    ts_aicpu_sqe_t *ctrlMsg = reinterpret_cast<ts_aicpu_sqe_t *>(eventInfo.priv.msg);
    ctrlMsg->cmd_type = AICPU_FFTS_PLUS_DATADUMP_REPORT;
    ctrlMsg->u.ts_to_aicpu_info.length = 0U;
    MOCKER_CPP(&AicpuEventProcess::ProcessDumpFFTSPlusDataEvent).stubs().will(returnValue(AICPU_SCHEDULE_OK));
    int ret = AicpuEventManager::GetInstance().ProcessHWTSControlEvent(eventInfo);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
}

TEST_F(AICPUScheduleTEST, ExecuteProcessSycHwtsKernel) {
    MOCKER_CPP(&MessageQueue::SendResponse).stubs();
    event_info eventInfo = g_event;
    eventInfo.comm.event_id = EVENT_TS_HWTS_KERNEL;
    event_ack eventAck = {};
    int ret = AicpuEventManager::GetInstance().ExecuteProcessSyc(&eventInfo, &eventAck);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
}

TEST_F(AICPUScheduleTEST, ExecuteProcessSycCtrlMsg) {
    event_info eventInfo = g_event;
    eventInfo.comm.event_id = EVENT_TS_CTRL_MSG;
    event_ack eventAck = {};
    int ret = AicpuEventManager::GetInstance().ExecuteProcessSyc(&eventInfo, &eventAck);
    EXPECT_NE(ret, AICPU_SCHEDULE_OK);
}

TEST_F(AICPUScheduleTEST, ExecuteProcessSycDefault) {
    event_info eventInfo = g_event;
    eventInfo.comm.event_id = EVENT_RANDOM_KERNEL;
    event_ack eventAck = {};
    int ret = AicpuEventManager::GetInstance().ExecuteProcessSyc(&eventInfo, &eventAck);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
}

TEST_F(AICPUScheduleTEST, ExecuteHWTSEventTaskDatadumpEnable) {
    uint32_t threadIndex = 0U;
    uint32_t streamId = 0U;
    uint32_t taskId = 0U;
    uint64_t serialNo = 0UL;
    aicpu::HwtsTsKernel aicpufwKernelInfo = {};
    event_info drvEventInfo = {};
    uint32_t mailboxId = 0U;
    hwts_response_t hwtsResp = {};
    uint16_t dataDumpEnableMode = 1U;
    MOCKER_CPP(&AicpuEventProcess::ExecuteTsKernelTask).stubs().will(returnValue(AICPU_SCHEDULE_OK));
    int ret = AicpuEventManager::GetInstance().ExecuteHWTSEventTask(threadIndex, streamId, taskId,
        serialNo, aicpufwKernelInfo, drvEventInfo, mailboxId, hwtsResp, dataDumpEnableMode);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
}

TEST_F(AICPUScheduleTEST, ProcProxyEventSuccess) {
    event_info eventInfo = g_event;
    uint32_t threadIndex = 0U;
    MOCKER_CPP(&AicpuQueueEventProcess::ProcessProxyMsg).stubs().will(returnValue(AICPU_SCHEDULE_OK));
    int ret = AicpuEventManager::GetInstance().ProcProxyEvent(eventInfo, threadIndex);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
}

TEST_F(AICPUScheduleTEST, DoOnceMsqSuccess) {
    MOCKER_CPP(&MessageQueue::WaitMsqInfoOnce).stubs().will(returnValue(true));
    int ret = AicpuEventManager::GetInstance().DoOnceMsq(0, 0, 0);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
}

bool WaitMsqInfoOnceFake(MsqDatas &datas)
{
    AicpuTopicMailbox mb = {};
    mb.pid = 0;
    mb.topicId = 3;
    datas = *(PtrToPtr<AicpuTopicMailbox, MsqDatas>(&mb));
    return true;
}

TEST_F(AICPUScheduleTEST, DoOnceMsqRescueOpSuccess)
{
    MOCKER_CPP(&MessageQueue::SendResponse).stubs();
    MOCKER_CPP(&MessageQueue::WaitMsqInfoOnce).stubs().will(invoke(WaitMsqInfoOnceFake));
    int ret = AicpuEventManager::GetInstance().DoOnceMsq(0, 0, 0);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
}

TEST_F(AICPUScheduleTEST, FillHwtsEventSuccess) {
    const AicpuTopicMailbox mb = {
        .mailboxId = 1,
        .vfid = 0,
        .rspMode = 1,
        .satMode = 1,
        .blkDim = 1,
        .streamId = 8,
        .taskId = 9,
        .blkId = 10,
        .kernelType = 1,
        .batchMode = 1,
        .topicType = 1,
        .qos = 1,
        .res0 = 1,
        .pid = 1134,
        .userData = {0,1,2,3,4,5,6,7,8,9},
        .subtopicId = 0,
        .topicId = 3,
        .gid = 10,
        .userDataLen = 10,
        .hacSn = 2,
        .res1 = 2,
        .tqId= 3
    };
    event_info info = {};
    int ret = AicpuEventManager::GetInstance().FillEvent(mb, info);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
    EXPECT_EQ(info.comm.event_id, 3);
}

TEST_F(AICPUScheduleTEST, FillEventFail) {
    const AicpuTopicMailbox mb = {
        .mailboxId = 1,
        .vfid = 0,
        .rspMode = 1,
        .satMode = 1,
        .blkDim = 1,
        .streamId = 8,
        .taskId = 9,
        .blkId = 10,
        .kernelType = 1,
        .batchMode = 1,
        .topicType = 1,
        .qos = 1,
        .res0 = 1,
        .pid = 1134,
        .userData = {0,1,2,3,4,5,6,7,8,9},
        .subtopicId = 0,
        .topicId = 4,
        .gid = 10,
        .userDataLen = 10,
        .hacSn = 2,
        .res1 = 2,
        .tqId= 3
    };
    event_info info = {};

    MOCKER(memcpy_s).stubs().will(returnValue(1));
    int ret = AicpuEventManager::GetInstance().FillEvent(mb, info);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
}

TEST_F(AICPUScheduleTEST, SendMsqResponseSuccess) {
    hwts_response_t rsp = {};
    MOCKER_CPP(&MessageQueue::SendResponse).stubs();
    int ret = AicpuEventManager::GetInstance().ResponseMsq(0, 1, rsp);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
}

TEST_F(AICPUScheduleTEST, ComputeProcessStart_LoadKernelSo_extend) {
    MOCKER_CPP(&FeatureCtrl::ShouldLoadExtendKernelSo).stubs().will(returnValue(false));
    MOCKER(aeBatchLoadKernelSo).stubs().will(returnValue(0));
    ComputeProcess::GetInstance().LoadExtendKernelSo();
    EXPECT_EQ(ComputeProcess::GetInstance().runMode_, aicpu::AicpuRunMode::PROCESS_PCIE_MODE);
    GlobalMockObject::verify();
}

TEST_F(AICPUScheduleTEST, Ut_ProcessMessageTest1) {
    MOCKER(halEschedWaitEvent)
        .stubs()
        .will(returnValue(DRV_ERROR_SCHED_PARA_ERR));
    int32_t ret = AicpuSdCustDumpProcess::GetInstance().ProcessMessage(0);
    EXPECT_EQ(ret, DRV_ERROR_SCHED_PARA_ERR);
}

TEST_F(AICPUScheduleTEST, Ut_ProcessMessageTest2) {
    MOCKER(halEschedWaitEvent)
        .stubs()
        .will(returnValue(DRV_ERROR_SCHED_PROCESS_EXIT));
    int32_t ret = AicpuSdCustDumpProcess::GetInstance().ProcessMessage(0);
    EXPECT_EQ(ret, DRV_ERROR_SCHED_PROCESS_EXIT);
}

TEST_F(AICPUScheduleTEST, Ut_ProcessMessageTest3) {
    MOCKER(halEschedWaitEvent)
        .stubs()
        .will(returnValue(1));
    int32_t ret = AicpuSdCustDumpProcess::GetInstance().ProcessMessage(0);
    EXPECT_EQ(ret, 1);
}

TEST_F(AICPUScheduleTEST, Ut_ProcessMessageTest4AicpuIllegalCPU) {
    MOCKER(halEschedWaitEvent)
        .stubs()
        .will(returnValue(DRV_ERROR_SCHED_RUN_IN_ILLEGAL_CPU));
    int32_t ret = AicpuSdCustDumpProcess::GetInstance().ProcessMessage(0);
    EXPECT_EQ(ret, DRV_ERROR_SCHED_RUN_IN_ILLEGAL_CPU);
}

TEST_F(AICPUScheduleTEST, Ut_UnitCustDataDumpProcess) {
    AicpuSdCustDumpProcess::GetInstance().initFlag_ = false;
    AicpuSdCustDumpProcess::GetInstance().UnitCustDataDumpProcess();
    AicpuSdCustDumpProcess::GetInstance().initFlag_ = true;
    AicpuSdCustDumpProcess::GetInstance().UnitCustDataDumpProcess();
    EXPECT_EQ(AicpuSdCustDumpProcess::GetInstance().initFlag_, false);
}

TEST_F(AICPUScheduleTEST, Ut_DoCustDatadumpTask) {
    bool flag = false;
    AicpuSdCustDumpProcess::GetInstance().GetCustDumpProcessInitFlag(flag);
    EXPECT_TRUE(flag == false);

    int32_t ret = 0;
    event_info drvEventInfo = {0};
    drvEventInfo.priv.msg_len = 0;
    ret = AicpuSdCustDumpProcess::GetInstance().DoCustDatadumpTask(drvEventInfo);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID);
    
    drvEventInfo.priv.msg_len = sizeof(AICPUDumpCustInfo);
    drvEventInfo.comm.subevent_id = AICPU_SUB_EVENT_REPORT_CUST_DUMPDATA+1;
    ret = AicpuSdCustDumpProcess::GetInstance().DoCustDatadumpTask(drvEventInfo);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID);

    drvEventInfo.comm.subevent_id = AICPU_SUB_EVENT_REPORT_CUST_DUMPDATA;
    ret = AicpuSdCustDumpProcess::GetInstance().DoCustDatadumpTask(drvEventInfo);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);

    MOCKER(halEschedSubmitEvent)
        .stubs()
        .will(returnValue(DRV_ERROR_INNER_ERR));
    ret = AicpuSdCustDumpProcess::GetInstance().DoCustDatadumpTask(drvEventInfo);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_DUMP_FAILED);
}

drvError_t halGetDeviceInfoFake1(uint32_t devId, int32_t moduleType, int32_t infoType, int64_t *value)
{
    if (moduleType == 1 && infoType == 3) {
        *value = 1;
    }
    if (moduleType == 1 && infoType == 8) {
        *value = 65532;
    }
    return DRV_ERROR_NONE;
}
TEST_F(AICPUScheduleTEST, Ut_SetDataDumpThreadAffinity_test1) {
    int32_t ret = 0;
    ret = AicpuSdCustDumpProcess::GetInstance().SetDataDumpThreadAffinity();
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
    std::vector<uint32_t> deviceVec;
    deviceVec.push_back(1);
    MOCKER(halGetDeviceInfo).stubs().will(invoke(halGetDeviceInfoFake1));
    AicpuSchedule::AicpuDrvManager::GetInstance().GetCcpuInfo(deviceVec);
    setenv("PROCMGR_AICPU_CPUSET", "1", 1);
    ret = AicpuSdCustDumpProcess::GetInstance().SetDataDumpThreadAffinity();
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
    MOCKER(ProcMgrBindThread)
        .stubs()
        .will(returnValue(2));
    ret = AicpuSdCustDumpProcess::GetInstance().SetDataDumpThreadAffinity();
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_INNER_ERROR);
    setenv("PROCMGR_AICPU_CPUSET", "0", 1);
    ret = AicpuSdCustDumpProcess::GetInstance().SetDataDumpThreadAffinity();
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
    MOCKER(pthread_setaffinity_np)
        .stubs()
        .will(returnValue(2));
    ret = AicpuSdCustDumpProcess::GetInstance().SetDataDumpThreadAffinity();
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
}

TEST_F(AICPUScheduleTEST, Ut_LoopProcessEventTest4DRV_ERROR_SCHED_PROCESS_EXIT) {
    MOCKER(halEschedWaitEvent)
        .stubs()
        .will(returnValue(DRV_ERROR_SCHED_PROCESS_EXIT));
    AicpuSdCustDumpProcess::GetInstance().runningFlag_ = true;
    AicpuSdCustDumpProcess::GetInstance().LoopProcessEvent();
    EXPECT_EQ(AicpuSdCustDumpProcess::GetInstance().runningFlag_, false);
}
TEST_F(AICPUScheduleTEST, Ut_StartProcessEvent_test1) {
    int32_t ret = 0;
    MOCKER(sem_init)
        .stubs()
        .will(returnValue(0));
    MOCKER(sem_wait)
        .stubs()
        .will(returnValue(0));
    MOCKER(sem_post)
        .stubs()
        .will(returnValue(0));
    MOCKER(sem_destroy)
        .stubs()
        .will(returnValue(0));
    MOCKER_CPP(&AicpuSdCustDumpProcess::LoopProcessEvent)
        .stubs()
        .will(returnValue(0));
    AicpuSdCustDumpProcess::GetInstance().StartProcessEvent();
    MOCKER(halEschedSubscribeEvent)
        .stubs()
        .will(returnValue(1));
    AicpuSdCustDumpProcess::GetInstance().StartProcessEvent();
    MOCKER_CPP(&AicpuSdCustDumpProcess::SetDataDumpThreadAffinity)
        .stubs()
        .will(returnValue(1));
    AicpuSdCustDumpProcess::GetInstance().StartProcessEvent();
    MOCKER(halEschedCreateGrp)
        .stubs()
        .will(returnValue(1));
    AicpuSdCustDumpProcess::GetInstance().StartProcessEvent();
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
}
TEST_F(AICPUScheduleTEST, Ut_InitDumpProcess_test1) {
    int32_t ret = 0;
    MOCKER(sem_post)
        .stubs()
        .will(returnValue(0));
    MOCKER(sem_wait)
        .stubs()
        .will(returnValue(0));
    MOCKER(sem_destroy)
        .stubs()
        .will(returnValue(0));
    ret = AicpuSdCustDumpProcess::GetInstance().InitCustDumpProcess(2, 2);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
    MOCKER(sem_init)
        .stubs()
        .will(returnValue(-1));
    ret = AicpuSdCustDumpProcess::GetInstance().InitCustDumpProcess(2, 0);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_INIT_FAILED);
    ret = AicpuSdCustDumpProcess::GetInstance().InitCustDumpProcess(2, 0);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
}

TEST_F(AICPUScheduleTEST, AicpuUtil_NumElementsFail0) {
    const int64_t dimSize = 2;
    const int64_t * const shape = nullptr;
    int64_t elementNum = 4;
    int32_t ret = AicpuUtil::NumElements(shape, dimSize, elementNum);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID);
}

TEST_F(AICPUScheduleTEST, AicpuUtil_NumElementsFail1) {
    const int64_t value = -1;
    const int64_t * const shape = &value;
    const int64_t dimSize = 1;
    int64_t elementNum = 1;
    int32_t ret = AicpuUtil::NumElements(shape, dimSize, elementNum);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID);
}

TEST_F(AICPUScheduleTEST, AicpuUtil_CalcDataSizeByShape_Fail0) {
    const int64_t * const shape = nullptr;
    int64_t dataSize = 1;
    int32_t ret = AicpuUtil::CalcDataSizeByShape(shape, 1, 1, dataSize);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID);
}

TEST_F(AICPUScheduleTEST, AicpuUtil_CalcDataSizeByShape_Fail1) {
    const int64_t value = 22;
    const int64_t * const shape = &value;
    MOCKER(ge::GetSizeByDataType).stubs().will(returnValue(-1));
    int64_t dataSize = 1;
    int32_t ret = AicpuUtil::CalcDataSizeByShape(shape, 1, 1, dataSize);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID);
}

TEST_F(AICPUScheduleTEST, AicpuUtil_IsUint64MulOverflow) {
    bool ret = AicpuUtil::IsUint64MulOverflow(0, 0);
    EXPECT_EQ(ret, false);
    ret = AicpuUtil::IsUint64MulOverflow(1000, UINT64_MAX);
    EXPECT_EQ(ret, true);
}

TEST_F(AICPUScheduleTEST, AicpuUtil_ValidateStrFail0) {
    bool ret = AicpuUtil::ValidateStr("hello", "***world");
    EXPECT_EQ(ret, false);
}

TEST_F(AICPUScheduleTEST, AicpuUtil_ValidateStrFail1) {
    bool ret = AicpuUtil::ValidateStr("^***hello", "world");
    EXPECT_EQ(ret, false);
}

TEST_F(AICPUScheduleTEST, AicpuUtil_ExecuteCmdFail0) {
    int32_t ret = AicpuUtil::ExecuteCmd("");
    EXPECT_EQ(ret, -1);
    MOCKER(vfork).stubs().will(returnValue(-1));
    ret = AicpuUtil::ExecuteCmd("cp");
    EXPECT_EQ(ret, -1);
}

TEST_F(AICPUScheduleTEST, DTypeName)
{
    std::string unkownName = AicpuUtil::GetDTypeString(ge::DataType::DT_MAX);
    EXPECT_EQ(unkownName, "DT_UNDEFINED");
}

void func111(void *param)
{
  return;
}
 
void stopfunc111(void *param)
{
  return;
}
aicpu::status_t GetAicpuRunModeSOCKET1(aicpu::AicpuRunMode &runMode)
{
    static uint32_t ret = 0;
    runMode = aicpu::AicpuRunMode::PROCESS_SOCKET_MODE;
    return ret++;
}
void SendMc2CreateThreadMsgToMain_stub()
{
    struct TsdSubEventInfo *msg = nullptr;
    CreateMc2MantenanceThread(msg);
}
TEST_F(AICPUScheduleTEST, StartMC2MaintenanceThreadUt) {
    MOCKER(sem_init)
        .stubs()
        .will(returnValue(0));
    MOCKER(sem_wait)
        .stubs()
        .will(returnValue(0));
    MOCKER(sem_post)
        .stubs()
        .will(returnValue(0));
    MOCKER(sem_destroy)
        .stubs()
        .will(returnValue(0));
    MOCKER_CPP(&AicpuMc2MaintenanceThread::SendMc2CreateThreadMsgToMain).stubs().will(invoke(SendMc2CreateThreadMsgToMain_stub));
    int ret = 0;
    ret = StartMC2MaintenanceThread(&func111, nullptr, &stopfunc111, nullptr);
    EXPECT_EQ(ret, AicpuSchedule::AICPU_SCHEDULE_OK);
    ret = StartMC2MaintenanceThread(&func111, nullptr, &stopfunc111, nullptr);
    MOCKER(pthread_setaffinity_np)
        .stubs()
        .will(returnValue(2));
    AicpuMc2MaintenanceThread::GetInstance(0).StartProcessEvent();
    AicpuSchedule::AicpuMc2MaintenanceThread::GetInstance(0).initFlag_ = false;
    ret = StartMC2MaintenanceThread(nullptr, nullptr, &stopfunc111, nullptr);
    EXPECT_EQ(ret, AICPU_SCHEDULE_PARAMETER_IS_NULL);
    AicpuSchedule::AicpuMc2MaintenanceThread::GetInstance(0).initFlag_ = false;
    ret = StartMC2MaintenanceThread(&func111, nullptr, nullptr, nullptr);
    EXPECT_EQ(ret, AICPU_SCHEDULE_PARAMETER_IS_NULL);
    MOCKER(aicpu::GetAicpuRunMode)
        .stubs()
        .will(invoke(GetAicpuRunModeSOCKET1));
    AicpuSchedule::AicpuMc2MaintenanceThread::GetInstance(0).initFlag_ = false;
    ret = StartMC2MaintenanceThread(&func111, nullptr, &stopfunc111, nullptr);
    EXPECT_EQ(ret, AICPU_SCHEDULE_NOT_SUPPORT);
    AicpuSchedule::AicpuMc2MaintenanceThread::GetInstance(0).initFlag_ = false;
    ret = StartMC2MaintenanceThread(&func111, nullptr, &stopfunc111, nullptr);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_INNER_ERROR);

    AicpuMc2MaintenanceThread::GetInstance(0).processEventFuncPtr_ = nullptr;
    AicpuMc2MaintenanceThread::GetInstance(0).ProcessEventFunc();
    AicpuSchedule::AicpuMc2MaintenanceThread::GetInstance(0).initFlag_ = true;
    AicpuMc2MaintenanceThread::GetInstance(0).UnitMc2MantenanceProcess();
    AicpuMc2MaintenanceThread::GetInstance(0).StopProcessEventFunc();
    if (AicpuSchedule::AicpuMc2MaintenanceThread::GetInstance(0).processThread_.joinable()) {
        AicpuSchedule::AicpuMc2MaintenanceThread::GetInstance(0).processThread_.join();
    }
}

TEST_F(AICPUScheduleTEST, SetMc2MantenanceThreadAffinityUt) {
    int32_t ret = 0;
    ret = AicpuMc2MaintenanceThread::GetInstance(0).SetMc2MantenanceThreadAffinity();
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
    std::vector<uint32_t> deviceVec;
    deviceVec.push_back(1);
    ret = AicpuMc2MaintenanceThread::GetInstance(0).SetMc2MantenanceThreadAffinity();
    MOCKER(pthread_setaffinity_np)
        .stubs()
        .will(returnValue(2));
    ret = AicpuMc2MaintenanceThread::GetInstance(0).SetMc2MantenanceThreadAffinity();
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_INNER_ERROR);
    AicpuDrvManager::GetInstance().ccpuIdVec_.clear();
    ret = AicpuMc2MaintenanceThread::GetInstance(0).SetMc2MantenanceThreadAffinity();
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
}

TEST_F(AICPUScheduleTEST, StartMC2MaintenanceThread_loopFunIsNULL_Ut) {
    MOCKER(sem_init) .stubs().will(returnValue(0));
    MOCKER(sem_wait).stubs().will(returnValue(0));
    MOCKER(sem_post).stubs().will(returnValue(0));
    MOCKER(sem_destroy).stubs().will(returnValue(0));
    int ret = 0;
    MOCKER(pthread_setaffinity_np).stubs().will(returnValue(2));
    AicpuSchedule::AicpuMc2MaintenanceThread::GetInstance(0).initFlag_ = false;
    ret = StartMC2MaintenanceThread(nullptr, nullptr, &stopfunc111, nullptr);
    if (AicpuSchedule::AicpuMc2MaintenanceThread::GetInstance(0).processThread_.joinable()) {
        AicpuSchedule::AicpuMc2MaintenanceThread::GetInstance(0).processThread_.join();
    }
    EXPECT_EQ(ret, AICPU_SCHEDULE_PARAMETER_IS_NULL);
}

TEST_F(AICPUScheduleTEST, StartMC2MaintenanceThread_stopNotifyFunIsNULL_Ut) {
    MOCKER(sem_init) .stubs().will(returnValue(0));
    MOCKER(sem_wait).stubs().will(returnValue(0));
    MOCKER(sem_post).stubs().will(returnValue(0));
    MOCKER(sem_destroy).stubs().will(returnValue(0));
    int ret = 0;
    MOCKER(pthread_setaffinity_np).stubs().will(returnValue(2));
    AicpuSchedule::AicpuMc2MaintenanceThread::GetInstance(0).initFlag_ = false;
    ret = StartMC2MaintenanceThread(&func111, nullptr, nullptr, nullptr);
    if (AicpuSchedule::AicpuMc2MaintenanceThread::GetInstance(0).processThread_.joinable()) {
        AicpuSchedule::AicpuMc2MaintenanceThread::GetInstance(0).processThread_.join();
    }
    EXPECT_EQ(ret, AICPU_SCHEDULE_PARAMETER_IS_NULL);
}

TEST_F(AICPUScheduleTEST, StartMC2MaintenanceThread_loopFunIsNULL_stopNotifyFunIsNULL_Ut) {
    MOCKER(sem_init) .stubs().will(returnValue(0));
    MOCKER(sem_wait).stubs().will(returnValue(0));
    MOCKER(sem_post).stubs().will(returnValue(0));
    MOCKER(sem_destroy).stubs().will(returnValue(0));
    int ret = 0;
    MOCKER(pthread_setaffinity_np).stubs().will(returnValue(2));
    AicpuSchedule::AicpuMc2MaintenanceThread::GetInstance(0).initFlag_ = false;
    ret = StartMC2MaintenanceThread(nullptr, nullptr, nullptr, nullptr);
    if (AicpuSchedule::AicpuMc2MaintenanceThread::GetInstance(0).processThread_.joinable()) {
        AicpuSchedule::AicpuMc2MaintenanceThread::GetInstance(0).processThread_.join();
    }
    EXPECT_EQ(ret, AICPU_SCHEDULE_PARAMETER_IS_NULL);
}

TEST_F(AICPUScheduleTEST, StartMC2MaintenanceThread_AICPU_SCHEDULE_THREAD_ALREADY_EXISTS_Ut) {
    MOCKER(sem_init) .stubs().will(returnValue(0));
    MOCKER(sem_wait).stubs().will(returnValue(0));
    MOCKER(sem_post).stubs().will(returnValue(0));
    MOCKER(sem_destroy).stubs().will(returnValue(0));
    MOCKER(&halEschedSubmitEvent).stubs().will(returnValue(1));
    int ret = 0;
    ret = StartMC2MaintenanceThread(&func111, nullptr, &stopfunc111, nullptr);
    EXPECT_EQ(ret, AicpuSchedule::AICPU_SCHEDULE_OK);
    ret = StartMC2MaintenanceThread(&func111, nullptr, &stopfunc111, nullptr);
    AicpuSchedule::AicpuMc2MaintenanceThread::GetInstance(0).initFlag_ = true;
    AicpuMc2MaintenanceThread::GetInstance(0).UnitMc2MantenanceProcess();
    AicpuMc2MaintenanceThread::GetInstance(0).StopProcessEventFunc();
    if (AicpuSchedule::AicpuMc2MaintenanceThread::GetInstance(0).processThread_.joinable()) {
        AicpuSchedule::AicpuMc2MaintenanceThread::GetInstance(0).processThread_.join();
    }
}
aicpu::status_t GetAicpuRunModeSOCKET2(aicpu::AicpuRunMode &runMode)
{
    static uint32_t ret = 0;
    runMode = aicpu::AicpuRunMode::PROCESS_SOCKET_MODE;
    return ret;
}
TEST_F(AICPUScheduleTEST, StartMC2MaintenanceThread_AICPU_SCHEDULE_NOT_SUPPORT_Ut) {
    MOCKER(sem_init) .stubs().will(returnValue(0));
    MOCKER(sem_wait).stubs().will(returnValue(0));
    MOCKER(sem_post).stubs().will(returnValue(0));
    MOCKER(sem_destroy).stubs().will(returnValue(0));
    int ret = 0;
    MOCKER(aicpu::GetAicpuRunMode)
        .stubs()
        .will(invoke(GetAicpuRunModeSOCKET2));
    AicpuSchedule::AicpuMc2MaintenanceThread::GetInstance(0).initFlag_ = false;
    ret = StartMC2MaintenanceThread(&func111, nullptr, &stopfunc111, nullptr);
    if (AicpuSchedule::AicpuMc2MaintenanceThread::GetInstance(0).processThread_.joinable()) {
        AicpuSchedule::AicpuMc2MaintenanceThread::GetInstance(0).processThread_.join();
    }
    EXPECT_EQ(ret, AICPU_SCHEDULE_NOT_SUPPORT);
}

TEST_F(AICPUScheduleTEST, CreateMc2MantenanceThread_already_init_Ut) {
    int ret = 0;
    MOCKER(pthread_setaffinity_np).stubs().will(returnValue(2));
    AicpuSchedule::AicpuMc2MaintenanceThread::GetInstance(0).initFlag_ = true;
    ret = AicpuSchedule::AicpuMc2MaintenanceThread::GetInstance(0).CreateMc2MantenanceThread();
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
}

TEST_F(AICPUScheduleTEST, CreateMc2MantenanceThread_failed_Ut) {
    MOCKER_CPP(&AicpuMc2MaintenanceThread::CreateMc2MantenanceThread).stubs().will(returnValue(1));
    int ret = 0;
    struct TsdSubEventInfo msg;
    ret = CreateMc2MantenanceThread(&msg);
    EXPECT_EQ(ret, 1);
}
TEST_F(AICPUScheduleTEST, CreateMc2MantenanceThread_Start_thread_multiple_times_Ut) {
    MOCKER(sem_init) .stubs().will(returnValue(0));
    MOCKER(sem_wait).stubs().will(returnValue(0));
    MOCKER(sem_post).stubs().will(returnValue(0));
    MOCKER(sem_destroy).stubs().will(returnValue(0));
    int ret = 0;
    MOCKER(pthread_setaffinity_np).stubs().will(returnValue(0));
    AicpuSchedule::AicpuMc2MaintenanceThread::GetInstance(0).initFlag_ = false;
    ret = AicpuSchedule::AicpuMc2MaintenanceThread::GetInstance(0).CreateMc2MantenanceThread();
    AicpuSchedule::AicpuMc2MaintenanceThread::GetInstance(0).CreateMc2MantenanceThread();
    if (AicpuSchedule::AicpuMc2MaintenanceThread::GetInstance(0).processThread_.joinable()) {
        AicpuSchedule::AicpuMc2MaintenanceThread::GetInstance(0).processThread_.join();
    }
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
}

TEST_F(AICPUScheduleTEST, CreateMc2MantenanceThread_destructor_Ut) {
    MOCKER(sem_init) .stubs().will(returnValue(0));
    MOCKER(sem_wait).stubs().will(returnValue(0));
    MOCKER(sem_post).stubs().will(returnValue(0));
    MOCKER(sem_destroy).stubs().will(returnValue(0));
    MOCKER_CPP(&AicpuMc2MaintenanceThread::UnitMc2MantenanceProcess).stubs().will(returnValue(0));
    auto ret = CastV2(nullptr);
    MOCKER(pthread_setaffinity_np).stubs().will(returnValue(0));
    if (AicpuSchedule::AicpuMc2MaintenanceThread::GetInstance(0).processThread_.joinable()) {
        AicpuSchedule::AicpuMc2MaintenanceThread::GetInstance(0).processThread_.join();
    }
    AicpuSchedule::AicpuMc2MaintenanceThread::GetInstance(0).processThread_ = std::thread(&func111, this);
    AicpuSchedule::AicpuMc2MaintenanceThread::GetInstance(0).~AicpuMc2MaintenanceThread();
    if (AicpuSchedule::AicpuMc2MaintenanceThread::GetInstance(0).processThread_.joinable()) {
        AicpuSchedule::AicpuMc2MaintenanceThread::GetInstance(0).processThread_.join();
    }
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
}

TEST_F(AICPUScheduleTEST, StartMC2MaintenanceThread_sem_wait_failed_Ut) {
    MOCKER(sem_init)
        .stubs()
        .will(returnValue(0));
    MOCKER(sem_wait)
        .stubs()
        .will(returnValue(-1));
    MOCKER(sem_post)
        .stubs()
        .will(returnValue(0));
    MOCKER(sem_destroy)
        .stubs()
        .will(returnValue(0));
    int ret = 0;
    AicpuSchedule::AicpuMc2MaintenanceThread::GetInstance(0).initFlag_ = false;
    ret = StartMC2MaintenanceThread(&func111, nullptr, &stopfunc111, nullptr);
    EXPECT_EQ(ret, AicpuSchedule::AICPU_SCHEDULE_ERROR_INIT_FAILED);
    AicpuSchedule::AicpuMc2MaintenanceThread::GetInstance(0).initFlag_ = true;
    AicpuMc2MaintenanceThread::GetInstance(0).UnitMc2MantenanceProcess();
    AicpuMc2MaintenanceThread::GetInstance(0).StopProcessEventFunc();
    if (AicpuSchedule::AicpuMc2MaintenanceThread::GetInstance(0).processThread_.joinable()) {
        AicpuSchedule::AicpuMc2MaintenanceThread::GetInstance(0).processThread_.join();
    }
}

TEST_F(AICPUScheduleTEST, NeedDump_return_false_Ut) {
    OpDumpTask opDumpTask(0, 0);
    opDumpTask.optionalParam_.hasStepId = 0;
    opDumpTask.dumpStep_.singleStep.insert(0U);
    auto ret = opDumpTask.NeedDump(0);
    EXPECT_EQ(ret, false);
}

TEST_F(AICPUScheduleTEST, AicpuGetOpTaskInfo_fail) {
    AicpuSchedule::OpDumpTaskManager taskManager;
    const KfcDumpTask taskKey(0, 0, 0);
    int32_t ret = AicpuGetOpTaskInfo(taskKey, nullptr);
    EXPECT_EQ(ret, AicpuSchedule::AICPU_SCHEDULE_ERROR_DUMP_FAILED);
}

TEST_F(AICPUScheduleTEST, AicpuGetOpTaskInfo) {
    KfcDumpInfo *dumpInfo = nullptr;
    const KfcDumpTask taskKey(0, 0, 0);
    int32_t ret = AicpuGetOpTaskInfo(taskKey, &dumpInfo);
    EXPECT_EQ(ret, AicpuSchedule::AICPU_SCHEDULE_ERROR_DUMP_FAILED);
}

TEST_F(AICPUScheduleTEST, AicpuDumpOpTaskData_fail) {
    const KfcDumpTask taskKey(0, 0, 0);
    int32_t ret = AicpuDumpOpTaskData(taskKey, nullptr, 0);
    EXPECT_EQ(ret, AicpuSchedule::AICPU_SCHEDULE_ERROR_DUMP_FAILED);
}

TEST_F(AICPUScheduleTEST, AicpuDumpOpTaskData) {
    std::string data = "testdumpinfo";
    const KfcDumpTask taskKey(0, 0, 0);
    int32_t ret = AicpuDumpOpTaskData(taskKey, (void *)data.c_str(), 20);
    EXPECT_EQ(ret, AicpuSchedule::AICPU_SCHEDULE_ERROR_DUMP_FAILED);
}

TEST_F(AICPUScheduleTEST, ProcOnPreprocessEvent_001) {
    event_info eventInfo = g_event;
    MOCKER_CPP(&FeatureCtrl::IsAosCore).stubs().will(returnValue(true));
    auto ret = AicpuEventManager::GetInstance().ProcOnPreprocessEvent(eventInfo, 0);
    EXPECT_EQ(ret, 0);
}
  
TEST_F(AICPUScheduleTEST, Start_002) {
    MOCKER_CPP(&ThreadPool::CreateWorker)
        .stubs()
        .will(returnValue(0));
    std::string ch = "000000000000000000000000000000000000000000000000";
    std::vector<uint32_t> deviceVec;
    deviceVec.push_back(1);
    MOCKER_CPP(&ComputeProcess::StartTdtServer)
        .stubs()
        .will(returnValue(0));
    MOCKER_CPP(&FeatureCtrl::LoadKernelSo).stubs().will(returnValue(true));;
    const AicpuSchedMode schedMode = SCHED_MODE_INTERRUPT;
    int ret = ComputeProcess::GetInstance().Start(deviceVec, 100, ch, PROFILING_OPEN, 0, aicpu::PROCESS_PCIE_MODE, schedMode);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
}

TEST_F(AICPUScheduleTEST, Start_003) {
    MOCKER_CPP(&ThreadPool::CreateWorker)
        .stubs()
        .will(returnValue(0));
    std::string ch = "000000000000000000000000000000000000000000000000";
    std::vector<uint32_t> deviceVec;
    deviceVec.push_back(1);
    const AicpuSchedMode schedMode = SCHED_MODE_INTERRUPT;
    int ret = ComputeProcess::GetInstance().Start(deviceVec, 100, ch, PROFILING_OPEN, 1, aicpu::PROCESS_PCIE_MODE, schedMode);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
    ComputeProcess::GetInstance().Stop();
}

TEST_F(AICPUScheduleTEST, Start_004) {
    MOCKER_CPP(&ThreadPool::CreateWorker)
        .stubs()
        .will(returnValue(0));
    std::string ch = "000000000000000000000000000000000000000000000000";
    std::vector<uint32_t> deviceVec;
    deviceVec.push_back(1);
    MOCKER_CPP(&ComputeProcess::StartTdtServer).stubs().will(returnValue(1));
    const AicpuSchedMode schedMode = SCHED_MODE_INTERRUPT;
    int ret = ComputeProcess::GetInstance().Start(deviceVec, 100, ch, PROFILING_OPEN, 1, aicpu::PROCESS_PCIE_MODE, schedMode);
    EXPECT_EQ(ret, 1);
}

TEST_F(AICPUScheduleTEST, ComputeProcessDebugString) {
    ComputeProcess inst;
    const AICPUSharderTaskInfo taskInfo = {.parallelId = 4U};
    const aicpu::Closure task = [](){};
    std::queue<aicpu::Closure> queue;
    queue.push(task);
    inst.splitKernelTask_.BatchAddTask(taskInfo, queue);
    EXPECT_STREQ(inst.DebugString().c_str(), "Split kernel TaskMapSize=1. task=0, parallelId=4, size=1, shardNum=0");
}

TEST_F(AICPUScheduleTEST, Ut_SendLoadPlatformInfoToCust) {
    MOCKER(sem_init) .stubs().will(returnValue(0));
    MOCKER(sem_wait).stubs().will(returnValue(0));
    MOCKER(sem_post).stubs().will(returnValue(0));
    MOCKER(sem_destroy).stubs().will(returnValue(0));
    MOCKER_CPP(&AicpuSdLoadPlatformInfoProcess::SendLoadPlatformInfoMessageToCustSync).stubs().will(returnValue(0));
    struct TsdSubEventInfo msg;
    int32_t ret = SendLoadPlatformInfoToCust(&msg);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
}

TEST_F(AICPUScheduleTEST, Ut_SendLoadPlatformInfoToCust_failed1) {
    MOCKER(sem_init) .stubs().will(returnValue(0));
    MOCKER(sem_wait).stubs().will(returnValue(0));
    MOCKER(sem_post).stubs().will(returnValue(0));
    MOCKER(sem_destroy).stubs().will(returnValue(0));
    MOCKER_CPP(&AicpuSdLoadPlatformInfoProcess::SendLoadPlatformInfoMessageToCustSync).stubs().will(returnValue(0));
    MOCKER(memcpy_s).stubs().will(returnValue(1));
    struct TsdSubEventInfo msg;
    int32_t ret = SendLoadPlatformInfoToCust(&msg);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID);
}

TEST_F(AICPUScheduleTEST, Ut_SendMsgToMain) {
    MOCKER(sem_init) .stubs().will(returnValue(0));
    MOCKER(sem_wait).stubs().will(returnValue(0));
    MOCKER(sem_post).stubs().will(returnValue(0));
    MOCKER(sem_destroy).stubs().will(returnValue(0));
    MOCKER(halEschedSubmitEvent).stubs().will(returnValue(AICPU_SCHEDULE_OK));
    struct TsdSubEventInfo msg;
    int32_t ret = AicpuSdLoadPlatformInfoProcess::GetInstance().SendMsgToMain((void *)(&msg), sizeof(msg));
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
}

TEST_F(AICPUScheduleTEST, Ut_SendMsgToMain_failed1) {
    MOCKER(sem_init) .stubs().will(returnValue(0));
    MOCKER(sem_wait).stubs().will(returnValue(0));
    MOCKER(sem_post).stubs().will(returnValue(0));
    MOCKER(sem_destroy).stubs().will(returnValue(0));
    MOCKER(halEschedSubmitEvent).stubs().will(returnValue(1));
    struct TsdSubEventInfo msg;
    int32_t ret = AicpuSdLoadPlatformInfoProcess::GetInstance().SendMsgToMain((void *)(&msg), sizeof(msg));
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_DRV_ERR);
}

TEST_F(AICPUScheduleTEST, Ut_SendMsgToMain_failed2) {
    MOCKER(sem_init) .stubs().will(returnValue(0));
    MOCKER(sem_wait).stubs().will(returnValue(-1));
    MOCKER(sem_post).stubs().will(returnValue(0));
    MOCKER(sem_destroy).stubs().will(returnValue(0));
    MOCKER(halEschedSubmitEvent).stubs().will(returnValue(0));
    struct TsdSubEventInfo msg;
    int32_t ret = AicpuSdLoadPlatformInfoProcess::GetInstance().SendMsgToMain((void *)(&msg), sizeof(msg));
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_INIT_FAILED);
}

TEST_F(AICPUScheduleTEST, Ut_SendMsgToMain_failed3) {
    MOCKER(sem_init) .stubs().will(returnValue(-1));
    MOCKER(sem_wait).stubs().will(returnValue(0));
    MOCKER(sem_post).stubs().will(returnValue(0));
    MOCKER(sem_destroy).stubs().will(returnValue(0));
    MOCKER(halEschedSubmitEvent).stubs().will(returnValue(AICPU_SCHEDULE_OK));
    struct TsdSubEventInfo msg;
    int32_t ret = AicpuSdLoadPlatformInfoProcess::GetInstance().SendMsgToMain((void *)(&msg), sizeof(msg));
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_INIT_FAILED);
}

TEST_F(AICPUScheduleTEST, Ut_SendMsgToMain_failed4) {
    MOCKER(sem_init) .stubs().will(returnValue(0));
    MOCKER(sem_wait).stubs().will(returnValue(0));
    MOCKER(sem_post).stubs().will(returnValue(0));
    MOCKER(sem_destroy).stubs().will(returnValue(0));
    MOCKER(halEschedSubmitEvent).stubs().will(returnValue(AICPU_SCHEDULE_OK));
    MOCKER(memcpy_s).stubs().will(returnValue(1));
    struct TsdSubEventInfo msg;
    int32_t ret = AicpuSdLoadPlatformInfoProcess::GetInstance().SendMsgToMain((void *)(&msg), sizeof(msg));
    EXPECT_EQ(ret, 1);
}

TEST_F(AICPUScheduleTEST, Ut_SendLoadPlatformInfoMessageToCustSync) {
    MOCKER(sem_init) .stubs().will(returnValue(0));
    MOCKER(sem_wait).stubs().will(returnValue(0));
    MOCKER(sem_post).stubs().will(returnValue(0));
    MOCKER(sem_destroy).stubs().will(returnValue(0));
    struct TsdSubEventInfo msg;
    int32_t ret = AicpuSdLoadPlatformInfoProcess::GetInstance().SendMsgToMain((void *)(&msg), sizeof(msg));
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
}

TEST_F(AICPUScheduleTEST, Ut_DoUdfDatadumpTask) {
    bool flag = false;
    AicpuSdCustDumpProcess::GetInstance().GetCustDumpProcessInitFlag(flag);

    int32_t ret = 0;
    event_info drvEventInfo = {0};
    drvEventInfo.priv.msg_len = 0;
    ret = AicpuSdCustDumpProcess::GetInstance().DoUdfDatadumpTask(drvEventInfo);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID);
    drvEventInfo.priv.msg_len = 48;
    ret = AicpuSdCustDumpProcess::GetInstance().DoUdfDatadumpTask(drvEventInfo);
    EXPECT_EQ(ret, 0);
    char * a[10];
    ::toolkit::dumpdata::DumpData dumpData;
    {
        ::toolkit::dumpdata::OpInput * const opInput = dumpData.add_input();
        opInput->set_size(10);
        opInput->set_address(&a);
    }
    {
        ::toolkit::dumpdata::OpOutput * const opOutput = dumpData.add_output();
        opOutput->set_size(10);
        opOutput->set_address(&a);
    }
    std::string path = "./";
    uint32_t size = sizeof(uint64_t) + dumpData.ByteSizeLong() + sizeof(uint64_t) + path.size();
    std::unique_ptr<char[]> buff_;
    buff_.reset(new (std::nothrow) char[size]);
    uint64_t offset_ = 0;
    uint64_t * const sizePtr = reinterpret_cast<uint64_t *>(buff_.get() + offset_);
    offset_ += sizeof(uint64_t);
    *sizePtr = dumpData.ByteSizeLong();
    dumpData.SerializeToArray(buff_.get() + offset_, static_cast<int32_t>(dumpData.ByteSizeLong()));
    offset_ += dumpData.ByteSizeLong();
    uint64_t * const pathSizePtr = reinterpret_cast<uint64_t *>(buff_.get() + offset_);
    *pathSizePtr = path.size();
    offset_ += sizeof(uint64_t);
    memcpy_s(buff_.get() + offset_, size - offset_, path.c_str(), path.size());
    offset_ += path.size();
    sizeof(AICPUDumpUdfInfo);
    AICPUDumpUdfInfo info;
    info.length = offset_;
    info.udfInfo = buff_.get();
    info.udfPid = 123;
    memcpy_s(drvEventInfo.priv.msg + sizeof(event_sync_msg), sizeof(drvEventInfo.priv.msg), &info, sizeof(info));
    ret = AicpuSdCustDumpProcess::GetInstance().DoUdfDatadumpTask(drvEventInfo);
    EXPECT_EQ(ret, 0);

    MOCKER_CPP(&OpDumpTask::ProcessDumpTensor).stubs().will(returnValue(1));
    ret = AicpuSdCustDumpProcess::GetInstance().DoUdfDatadumpTask(drvEventInfo);
    EXPECT_EQ(ret, 0);
    MOCKER(halEschedSubmitEvent)
        .stubs()
        .will(returnValue(DRV_ERROR_INNER_ERR));
    ret = AicpuSdCustDumpProcess::GetInstance().DoUdfDatadumpTask(drvEventInfo);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_DUMP_FAILED);

    *pathSizePtr = 100;
    memcpy_s(drvEventInfo.priv.msg + sizeof(event_sync_msg), sizeof(drvEventInfo.priv.msg), &info, sizeof(info));
    ret = AicpuSdCustDumpProcess::GetInstance().DoUdfDatadumpTask(drvEventInfo);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_DUMP_FAILED);

    info.udfInfo = 0;
    memcpy_s(drvEventInfo.priv.msg + sizeof(event_sync_msg), sizeof(drvEventInfo.priv.msg), &info, sizeof(info));
    ret = AicpuSdCustDumpProcess::GetInstance().DoUdfDatadumpTask(drvEventInfo);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_DUMP_FAILED);

    MOCKER(memcpy_s).stubs().will(returnValue(1));
    ret = AicpuSdCustDumpProcess::GetInstance().DoUdfDatadumpTask(drvEventInfo);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID);
}
TEST_F(AICPUScheduleTEST, UT_CreateUdfDatadumpThread) {
    MOCKER_CPP(&AicpuSdCustDumpProcess::InitCustDumpProcess).stubs().will(returnValue(0));
    char b[128];
    auto ret = AicpuSdCustDumpProcess::GetInstance().CreateUdfDatadumpThread(b, 128);
    EXPECT_EQ(ret, 0);

    MOCKER(halEschedSubmitEvent).stubs().will(returnValue(DRV_ERROR_INNER_ERR));
    ret = AicpuSdCustDumpProcess::GetInstance().CreateUdfDatadumpThread(b, 128);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_DUMP_FAILED);

    MOCKER(memcpy_s).stubs().will(returnValue(1));
    ret = AicpuSdCustDumpProcess::GetInstance().CreateUdfDatadumpThread(b, 128);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_DUMP_FAILED);

    ret = AicpuSdCustDumpProcess::GetInstance().CreateUdfDatadumpThread(b, 1);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_DUMP_FAILED);
}

TEST_F(AICPUScheduleTEST, UT_CreateDatadumpThread) {
    MOCKER_CPP(&AicpuSdCustDumpProcess::InitCustDumpProcess).stubs().will(returnValue(1));
    auto ret = CreateDatadumpThread(nullptr);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID);
    TsdSubEventInfo a;
    ret = CreateDatadumpThread(&a);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID);

    MOCKER(halEschedSubmitEvent).stubs().will(returnValue(DRV_ERROR_INNER_ERR));
    ret = CreateDatadumpThread(&a);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID);
}

TEST_F(AICPUScheduleTEST, dumpHostPidInvalid) {
    bool flag = false;
    AicpuSdCustDumpProcess::GetInstance().GetCustDumpProcessInitFlag(flag);

    int32_t ret = 0;
    event_info drvEventInfo = {0};
    drvEventInfo.priv.msg_len = 0;
    drvEventInfo.comm.host_pid = 123789;
    ret = AicpuSdCustDumpProcess::GetInstance().DoUdfDatadumpTask(drvEventInfo);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID);
    AicpuScheduleInterface::GetInstance().aicpuCustSdPid_ = 123;
    ret = AicpuSdCustDumpProcess::GetInstance().DoCustDatadumpTask(drvEventInfo);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID);
}