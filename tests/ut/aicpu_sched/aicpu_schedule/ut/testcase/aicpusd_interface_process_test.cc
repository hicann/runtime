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
#include <unistd.h>
#include <sys/types.h>
#include <sys/stat.h>
#include "gtest/gtest.h"
#include "mockcpp/mockcpp.hpp"
#include "tsd.h"
#include "profiling_adp.h"
#include "aicpusd_status.h"
#include "aicpu_engine.h"
#include "aicpusd_monitor.h"
#define private public
#include "aicpusd_msg_send.h"
#include "aicpusd_interface_process.h"
#include "aicpusd_event_manager.h"
#include "aicpusd_event_process.h"
#include "aicpusd_drv_manager.h"
#include "aicpusd_model_execute.h"
#include "aicpusd_resource_manager.h"
#include "dump_task.h"
#include "aicpusd_threads_process.h"
#include "stub/aicpusd_context.h"
#include "common/aicpusd_context.h"
#include "aicpu_event_struct.h"
#include "aicpusd_cust_so_manager.h"
#include "aicpusd_interface.h"
#include "aicpusd_sub_module_interface.h"
#include "aicpusd_hal_interface_ref.h"
#include "aicpusd_cust_dump_process.h"
#include "hwts_kernel_register.h"
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
}

class AICPUScheduleInterfaceTEST : public testing::Test {
protected:
    static void SetUpTestCase()
    {
        std::cout << "AICPUScheduleInterfaceTEST SetUpTestCase" << std::endl;
    }

    static void TearDownTestCase()
    {
        std::cout << "AICPUScheduleInterfaceTEST TearDownTestCase" << std::endl;
    }

    virtual void SetUp()
    {
        std::cout << "AICPUScheduleInterfaceTEST SetUP" << std::endl;
    }

    virtual void TearDown()
    {
        GlobalMockObject::verify();
        std::cout << "AICPUScheduleInterfaceTEST TearDown" << std::endl;
    }
};

namespace {
    int halGrpQueryWithTwoGroup(GroupQueryCmdType cmd,
                    void *inBuff, unsigned int inLen, void *outBuff, unsigned int *outLen)
    {
        GroupQueryOutput *groupQueryOutput = reinterpret_cast<GroupQueryOutput *>(outBuff);
        groupQueryOutput->grpQueryGroupsOfProcInfo[0].groupName[0] = 'g';
        groupQueryOutput->grpQueryGroupsOfProcInfo[0].groupName[1] = '1';
        groupQueryOutput->grpQueryGroupsOfProcInfo[0].groupName[2] = '\0';
        groupQueryOutput->grpQueryGroupsOfProcInfo[0].attr.admin = 1;
        groupQueryOutput->grpQueryGroupsOfProcInfo[0].attr.read = 1;
        groupQueryOutput->grpQueryGroupsOfProcInfo[0].attr.write = 1;
        groupQueryOutput->grpQueryGroupsOfProcInfo[0].attr.alloc = 1;
        groupQueryOutput->grpQueryGroupsOfProcInfo[1].groupName[0] = 'g';
        groupQueryOutput->grpQueryGroupsOfProcInfo[1].groupName[1] = '2';
        groupQueryOutput->grpQueryGroupsOfProcInfo[1].groupName[2] = '\0';
        groupQueryOutput->grpQueryGroupsOfProcInfo[1].attr.admin = 0;
        groupQueryOutput->grpQueryGroupsOfProcInfo[1].attr.read = 1;
        groupQueryOutput->grpQueryGroupsOfProcInfo[1].attr.write = 1;
        groupQueryOutput->grpQueryGroupsOfProcInfo[1].attr.alloc = 1;
        *outLen = sizeof(groupQueryOutput->grpQueryGroupsOfProcInfo[0]) * 2;
        return 0;
    }

        int halGrpQueryWithError(GroupQueryCmdType cmd,
                    void *inBuff, unsigned int inLen, void *outBuff, unsigned int *outLen)
    {
        GroupQueryOutput *groupQueryOutput = reinterpret_cast<GroupQueryOutput *>(outBuff);
        groupQueryOutput->grpQueryGroupsOfProcInfo[0].groupName[0] = 'g';
        groupQueryOutput->grpQueryGroupsOfProcInfo[0].groupName[1] = '1';
        groupQueryOutput->grpQueryGroupsOfProcInfo[0].groupName[2] = '\0';
        groupQueryOutput->grpQueryGroupsOfProcInfo[0].attr.admin = 1;
        groupQueryOutput->grpQueryGroupsOfProcInfo[0].attr.read = 1;
        groupQueryOutput->grpQueryGroupsOfProcInfo[0].attr.write = 1;
        groupQueryOutput->grpQueryGroupsOfProcInfo[0].attr.alloc = 1;
        groupQueryOutput->grpQueryGroupsOfProcInfo[1].groupName[0] = 'g';
        groupQueryOutput->grpQueryGroupsOfProcInfo[1].groupName[1] = '2';
        groupQueryOutput->grpQueryGroupsOfProcInfo[1].groupName[2] = '\0';
        groupQueryOutput->grpQueryGroupsOfProcInfo[1].attr.admin = 0;
        groupQueryOutput->grpQueryGroupsOfProcInfo[1].attr.read = 1;
        groupQueryOutput->grpQueryGroupsOfProcInfo[1].attr.write = 1;
        groupQueryOutput->grpQueryGroupsOfProcInfo[1].attr.alloc = 1;
        *outLen = sizeof(groupQueryOutput->grpQueryGroupsOfProcInfo[0]);
        return 0;
    }

    int halGrpQueryWithSize(GroupQueryCmdType cmd, void *inBuff, unsigned int inLen, void *outBuff,
        unsigned int *outLen)
    {
        if (GRP_QUERY_GROUPS_OF_PROCESS == cmd) {
            *outLen = sizeof(GrpQueryGroupsOfProcInfo);
        } else if (GRP_QUERY_GROUP_ADDR_INFO) {
            *outLen = sizeof(GrpQueryGroupAddrInfo);
        } else {
            *outLen = 0;
        }
        return static_cast<int>(DRV_ERROR_NONE);
    }

    int32_t CreateOrFindCustPidStub(const uint32_t deviceId, const uint32_t loadLibNum,
        const char * const loadLibName[], const uint32_t hostPid, const uint32_t vfId, const char *groupNameList,
        const uint32_t groupNameNum, int32_t *custProcPid, bool *firstStart)
    {
        *custProcPid = 1234509;
        *firstStart = true;
        return 0;
    }
    int32_t CreateOrFindCustPidStubExist(const uint32_t deviceId, const uint32_t loadLibNum,
        const char * const loadLibName[], const uint32_t hostPid, const uint32_t vfId, const char *groupNameList,
        const uint32_t groupNameNum, int32_t *custProcPid, bool *firstStart)
    {
        *custProcPid = 1234509;
        *firstStart = false;
        return 0;
    }
    int32_t CreateOrFindCustPidFailedStub(const uint32_t deviceId, const uint32_t loadLibNum,
        const char * const loadLibName[], const uint32_t hostPid, const uint32_t vfId, const char *groupNameList,
        const uint32_t groupNameNum, int32_t *custProcPid, bool *firstStart)
    {
        *custProcPid = -1;
        *firstStart = false;
        return 1;
    }
    int32_t CreateOrFindCustPidFailedStub2(const uint32_t deviceId, const uint32_t loadLibNum,
        const char * const loadLibName[], const uint32_t hostPid, const uint32_t vfId, const char *groupNameList,
        const uint32_t groupNameNum, int32_t *custProcPid, bool *firstStart)
    {
        *custProcPid = -100;
        *firstStart = false;
        return 1;
    }
}

TEST_F(AICPUScheduleInterfaceTEST, TsControlExecuteProcess)
{
    AicpuModel *aicpuModel = new AicpuModel();
    MOCKER_CPP(&AicpuModelManager::GetModel).stubs().will(returnValue(aicpuModel));
    MOCKER_CPP(&AicpuModel::ModelExecute).stubs().will(returnValue(0));
    int ret = AicpuEventManager::GetInstance().TsControlExecuteProcess(0);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
    delete aicpuModel;
    aicpuModel = nullptr;
}

TEST_F(AICPUScheduleInterfaceTEST, TsControlExecuteProcess_failed)
{
    AicpuModel *aicpuModel = nullptr;
    MOCKER_CPP(&AicpuModelManager::GetModel).stubs().will(returnValue(aicpuModel));
    int ret = AicpuEventManager::GetInstance().TsControlExecuteProcess(0);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_MODEL_NOT_FOUND);
}

TEST_F(AICPUScheduleInterfaceTEST, AICPUEventExecuteModel)
{
    AicpuModel *aicpuModel = new AicpuModel();
    MOCKER_CPP(&AicpuModelManager::GetModel).stubs().will(returnValue(aicpuModel));
    MOCKER_CPP(&AicpuModel::ModelExecute).stubs().will(returnValue(0));
    AICPUSubEventInfo event;
    int ret = AicpuEventProcess::GetInstance().AICPUEventExecuteModel(event);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
    delete aicpuModel;
    aicpuModel = nullptr;
}

TEST_F(AICPUScheduleInterfaceTEST, AICPUEventExecuteModel_failed1)
{
    AicpuModel *aicpuModel = nullptr;
    MOCKER_CPP(&AicpuModelManager::GetModel).stubs().will(returnValue(aicpuModel));
    AICPUSubEventInfo event;
    int ret = AicpuEventProcess::GetInstance().AICPUEventExecuteModel(event);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_MODEL_NOT_FOUND);
}

TEST_F(AICPUScheduleInterfaceTEST, AICPUEventExecuteModel_failed2)
{
    AicpuModel *aicpuModel = new AicpuModel();
    MOCKER_CPP(&AicpuModelManager::GetModel).stubs().will(returnValue(aicpuModel));
    MOCKER_CPP(&AicpuModel::ModelExecute).stubs().will(returnValue(1));
    AICPUSubEventInfo event;
    int ret = AicpuEventProcess::GetInstance().AICPUEventExecuteModel(event);
    EXPECT_EQ(ret, 1);
    delete aicpuModel;
    aicpuModel = nullptr;
}

TEST_F(AICPUScheduleInterfaceTEST, AICPUEventActiveAicpuStream)
{
    AicpuModel *aicpuModel = new AicpuModel();
    MOCKER_CPP(&AicpuModelManager::GetModel).stubs().will(returnValue(aicpuModel));
    MOCKER_CPP(&AicpuModel::ActiveStream).stubs().will(returnValue(0));
    AICPUSubEventInfo event;
    int ret = AicpuEventProcess::GetInstance().AICPUEventActiveAicpuStream(event);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
    delete aicpuModel;
    aicpuModel = nullptr;
}

TEST_F(AICPUScheduleInterfaceTEST, AICPUEventActiveAicpuStream_failed)
{
    AicpuModel *aicpuModel = nullptr;
    AICPUSubEventInfo event;
    int ret = AicpuEventProcess::GetInstance().AICPUEventActiveAicpuStream(event);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_MODEL_NOT_FOUND);
}


TEST_F(AICPUScheduleInterfaceTEST, AICPUEventRepeatModel)
{
    AicpuModel *aicpuModel = new AicpuModel();
    MOCKER_CPP(&AicpuModelManager::GetModel).stubs().will(returnValue(aicpuModel));
    MOCKER_CPP(&AicpuModel::ModelRepeat).stubs().will(returnValue(0));
    AICPUSubEventInfo event;
    int ret = AicpuEventProcess::GetInstance().AICPUEventRepeatModel(event);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
    delete aicpuModel;
    aicpuModel = nullptr;
}

TEST_F(AICPUScheduleInterfaceTEST, AICPUEventRepeatModel_failed)
{
    AicpuModel *aicpuModel = new AicpuModel();
    MOCKER_CPP(&AicpuModelManager::GetModel).stubs().will(returnValue(aicpuModel));
    MOCKER_CPP(&AicpuModel::ModelRepeat).stubs().will(returnValue(1));
    AICPUSubEventInfo event;
    int ret = AicpuEventProcess::GetInstance().AICPUEventRepeatModel(event);
    EXPECT_EQ(ret, 1);
    delete aicpuModel;
    aicpuModel = nullptr;
}

TEST_F(AICPUScheduleInterfaceTEST, AICPUEventRecoveryStream)
{
    AicpuModel *aicpuModel = new AicpuModel();
    MOCKER_CPP(&AicpuModelManager::GetModel).stubs().will(returnValue(aicpuModel));
    MOCKER_CPP(&AicpuModel::RecoverStream).stubs().will(returnValue(0));
    AICPUSubEventInfo event;
    AICPUSubEventStreamInfo streamInfo;
    streamInfo.streamId = 0;
    event.para.streamInfo = streamInfo;
    int ret = AicpuEventProcess::GetInstance().AICPUEventRecoveryStream(event);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
    delete aicpuModel;
    aicpuModel = nullptr;
}

TEST_F(AICPUScheduleInterfaceTEST, AICPUEventUpdateProfilingMode)
{
    AICPUSubEventInfo event;
    AICPUProfilingModeInfo modeInfo;
    modeInfo.flag = 7U;
    event.para.modeInfo = modeInfo;
    int ret = AicpuEventProcess::GetInstance().AICPUEventUpdateProfilingMode(event);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
}

TEST_F(AICPUScheduleInterfaceTEST, AICPUEventEndGraph01)
{
    AICPUSubEventInfo event;
    AICPUEndGraphInfo endGraphInfo;
    endGraphInfo.result = 0;
    event.para.endGraphInfo = endGraphInfo;
    event.modelId = 0;
    int ret = AicpuEventProcess::GetInstance().AICPUEventEndGraph(event);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_MODEL_NOT_FOUND);
}

TEST_F(AICPUScheduleInterfaceTEST, AICPUEventEndGraph02)
{
    AICPUSubEventInfo event;
    AICPUEndGraphInfo endGraphInfo;
    endGraphInfo.result = 1;
    event.para.endGraphInfo = endGraphInfo;
    event.modelId = 0;
    int ret = AicpuEventProcess::GetInstance().AICPUEventEndGraph(event);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_MODEL_NOT_FOUND);
}

TEST_F(AICPUScheduleInterfaceTEST, AICPUEventEndGraph03) {
    printf("=======================AicpuLoadModelWithQ=====================\n");
    ModelQueueInfo modelQueueInfo = {0, 0};
    ModelTaskInfo modelTaskInfo = {0, 0, 0};
    ModelStreamInfo modelStreamInfo = {1, 0x28U, 1, &modelTaskInfo};
    ModelInfo modelInfo = {}; //{0, 1, &modelStreamInfo, 1, &modelQueueInfo, };
    modelInfo.modelId = 0U;
    modelInfo.aicpuStreamNum = 1U;
    modelInfo.streams = &modelStreamInfo;
    modelInfo.queueNum = 1U;
    modelInfo.queues = &modelQueueInfo;

    AicpuLoadModelWithQ((void*)(&modelInfo));
    AICPUSubEventInfo event;
    AICPUEndGraphInfo endGraphInfo;
    endGraphInfo.result = 0;
    event.para.endGraphInfo = endGraphInfo;
    event.modelId = 0;
    int ret = AicpuEventProcess::GetInstance().AICPUEventEndGraph(event);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_MODEL_NOT_FOUND);
}

TEST_F(AICPUScheduleInterfaceTEST, AicpuLoadModelWithEventSuccess)
{
    printf("=======================AicpuLoadModelWithEvent=====================\n");
    const char * const kernelName = "test";
    ModelTaskInfo modelTaskInfo0_0 = {0, (uintptr_t)kernelName, 0};
    ModelStreamInfo modelStreamInfo0 = {0, 0x28U, 1, &modelTaskInfo0_0};
    ModelTaskInfo modelTaskInfo1_0 = {1, (uintptr_t)kernelName, 0};
    ModelStreamInfo modelStreamInfo1 = {1, 0x08U, 1, &modelTaskInfo1_0};
    ModelStreamInfo modelStreams[] = {modelStreamInfo0, modelStreamInfo1};
    ModelCfgInfo cfg = {};
    ModelInfo modelInfo = {};
    modelInfo.modelId = 1U;
    modelInfo.aicpuStreamNum = 2U;
    modelInfo.streams = modelStreams,
    modelInfo.cfgInfoPtr = PtrToValue(&cfg);

    MOCKER(StubHcclInitCsComm).stubs().will(returnValue(HCCL_SUCCESS));
    MOCKER(StubHcclFinalizeComm).stubs().will(returnValue(HCCL_SUCCESS));
    MOCKER(StubHcclPsAssociateWorkers).stubs().will(returnValue(HCCL_SUCCESS));
    MOCKER(halGrpQuery).stubs().will(invoke(halGrpQueryWithSize));

    EXPECT_EQ(AICPU_SCHEDULE_SUCCESS, AicpuLoadModel((void*)(&modelInfo)));
    EXPECT_EQ(AICPUModelDestroy(1U), 0);
}

TEST_F(AICPUScheduleInterfaceTEST, AicpuLoadModelWithEventForSyncEventSuccess)
{
    printf("=======================AicpuLoadModelWithEvent=====================\n");
    const char * const kernelName = "test";
    ModelTaskInfo modelTaskInfo0_0 = {0, (uintptr_t)kernelName, 0};
    ModelStreamInfo modelStreamInfo0 = {0, 0x28U, 1, &modelTaskInfo0_0};
    ModelTaskInfo modelTaskInfo1_0 = {1, (uintptr_t)kernelName, 0};
    ModelStreamInfo modelStreamInfo1 = {1, 0x08U, 1, &modelTaskInfo1_0};
    ModelStreamInfo modelStreams[] = {modelStreamInfo0, modelStreamInfo1};
    std::vector<HcomOpDesc> opVec = {HcomOpDesc(), HcomOpDesc()};
    ModelCommOpList opList = {};
    opList.opNum = 2U;
    opList.commOpDescsListAddr = PtrToValue(opVec.data());

    std::vector<CommGroup> groupVec = {CommGroup(), CommGroup()};
    CommGroups groupList = {};
    groupList.groupNum = 2U;
    groupList.groups = groupVec.data();

    ModelCfgInfo cfg = {};
    cfg.modelType = static_cast<uint32_t>(kModelWithSyncEvent);
    cfg.modelCommOpListAddr = &opList;
    cfg.commGroupsAddr = &groupList;
    ModelInfo modelInfo = {};
    modelInfo.modelId = 1U;
    modelInfo.aicpuStreamNum = 2U;
    modelInfo.streams = modelStreams,
    modelInfo.cfgInfoPtr = PtrToValue(&cfg);

    MOCKER(StubHcomInitByRankTable).stubs().will(returnValue(HCCL_SUCCESS));
    MOCKER(StubHcomDestroy).stubs().will(returnValue(HCCL_SUCCESS));
    MOCKER(StubHcomPrepareStart).stubs().will(returnValue(HCCL_SUCCESS));
    MOCKER(StubHcomPrepareQuery).stubs().will(returnValue(HCCL_SUCCESS));

    MOCKER(halGrpQuery).stubs().will(invoke(halGrpQueryWithSize));
    MOCKER(StubHcomCreateGroup).stubs().will(returnValue(HCCL_SUCCESS));
    EXPECT_EQ(AICPU_SCHEDULE_SUCCESS, AicpuLoadModel((void*)(&modelInfo)));
    EXPECT_EQ(AICPUModelDestroy(1U), 0);
}

TEST_F(AICPUScheduleInterfaceTEST, ProcessAICPUEvent)
{
    AicpuModel *aicpuModel = new AicpuModel();
    MOCKER_CPP(&AicpuModelManager::GetModel).stubs().will(returnValue(aicpuModel));
    MOCKER_CPP(&AicpuModel::ActiveStream).stubs().will(returnValue(0));
    event_info eventInfo = g_event;
    eventInfo.priv.msg_len = sizeof(AICPUSubEventInfo);
    eventInfo.comm.subevent_id = 0;
    int ret = AicpuEventProcess::GetInstance().ProcessAICPUEvent(eventInfo);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
    delete aicpuModel;
    aicpuModel = nullptr;
}

TEST_F(AICPUScheduleInterfaceTEST, ProcessAICPUEvent_failed0)
{
    AicpuModel *aicpuModel = new AicpuModel();
    MOCKER_CPP(&AicpuModelManager::GetModel).stubs().will(returnValue(aicpuModel));
    MOCKER_CPP(&AicpuModel::ActiveStream).stubs().will(returnValue(0));
    event_info eventInfo = g_event;
    eventInfo.priv.msg_len = sizeof(AICPUSubEventInfo);
    eventInfo.comm.subevent_id = 0;
    MOCKER_CPP(&AicpuEventProcess::AICPUEventActiveAicpuStream).stubs().will(returnValue(1));
    int ret = AicpuEventProcess::GetInstance().ProcessAICPUEvent(eventInfo);
    EXPECT_NE(ret, AICPU_SCHEDULE_OK);
    delete aicpuModel;
    aicpuModel = nullptr;
}

TEST_F(AICPUScheduleInterfaceTEST, ProcessAICPUEvent_failed1)
{
    event_info eventInfo = g_event;
    eventInfo.priv.msg_len = 1;
    eventInfo.comm.subevent_id = 0;
    int ret = AicpuEventProcess::GetInstance().ProcessAICPUEvent(eventInfo);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID);
}

TEST_F(AICPUScheduleInterfaceTEST, SendAICPUSubEvent)
{
    AICPUSubEventInfo subEventInfo = {0};
    subEventInfo.modelId = 0;
    subEventInfo.para.streamInfo.streamId = 0;
    int ret = AicpuMsgSend::SendAICPUSubEvent(reinterpret_cast<char *>(&subEventInfo), sizeof(AICPUSubEventInfo), 0, 0);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
}

TEST_F(AICPUScheduleInterfaceTEST, SendAICPUSubEvent_failed1)
{
    char *msg = nullptr;
    int ret = AicpuMsgSend::SendAICPUSubEvent(msg, 1, 0, 0);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_INVAILD_EVENT_SUBMIT);
}

TEST_F(AICPUScheduleInterfaceTEST, SendAICPUSubEvent_failed2)
{
    char *msg = "test";
    int ret = AicpuMsgSend::SendAICPUSubEvent(msg, 0, 0, 0);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_INVAILD_EVENT_SUBMIT);
}

TEST_F(AICPUScheduleInterfaceTEST, ProcessQueueNotEmptyEvent)
{
    uint32_t queueId = 1;
    int ret = AicpuEventProcess::GetInstance().ProcessQueueNotEmptyEvent(queueId);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
}

TEST_F(AICPUScheduleInterfaceTEST, ProcessQueueNotFullEvent)
{
    uint32_t queueId = 1;
    int ret = AicpuEventProcess::GetInstance().ProcessQueueNotFullEvent(queueId);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
}


TEST_F(AICPUScheduleInterfaceTEST, InitAICPUScheduler_failed1)
{
    pid_t hostPid = 0;
    char *pidSign = "test";
    bool isOnline = true;
    AicpuScheduleInterface::GetInstance().UpdateOrInsertStartFlag(0U, false);
    MOCKER_CPP(&AicpuDrvManager::InitDrvSchedModule).stubs().will(returnValue(10));
    std::vector<uint32_t> deviceVec;
    deviceVec.push_back(0);
    int ret = AicpuScheduleInterface::GetInstance().InitAICPUScheduler(deviceVec, hostPid, pidSign, PROFILING_CLOSE,
                                                                       0, isOnline, SCHED_MODE_INTERRUPT);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_DRV_ERR);
}

TEST_F(AICPUScheduleInterfaceTEST, InitAICPUScheduler_failed2)
{
    pid_t hostPid = 0;
    char *pidSign = "test";
    bool isOnline = true;
    AicpuScheduleInterface::GetInstance().UpdateOrInsertStartFlag(0U, false);
    MOCKER_CPP(&AicpuDrvManager::InitDrvSchedModule).stubs().will(returnValue(0));
    MOCKER_CPP(&ComputeProcess::Start).stubs().will(returnValue(10));
    std::vector<uint32_t> deviceVec;
    deviceVec.push_back(0);
    int ret = AicpuScheduleInterface::GetInstance().InitAICPUScheduler(deviceVec, hostPid, pidSign, PROFILING_CLOSE,
                                                                       0, isOnline, SCHED_MODE_INTERRUPT);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_INIT_CP_FAILED);
}

TEST_F(AICPUScheduleInterfaceTEST, StopAICPUScheduler_failed1)
{
    pid_t hostPid = 0;
    AicpuScheduleInterface::GetInstance().noThreadFlag_ = true;
    MOCKER(halEschedDettachDevice)
        .stubs()
        .will(returnValue(10));
    std::vector<uint32_t> deviceId;
    deviceId.push_back(0);
    int32_t ret = AicpuScheduleInterface::GetInstance().StopAICPUScheduler(deviceId, hostPid);
    EXPECT_EQ(ret, 10);
}

hdcError_t drvHdcGetCapacity_pcie(struct drvHdcCapacity *capacity)
{
    capacity->chanType = HDC_CHAN_TYPE_PCIE;
    return DRV_ERROR_NONE;
}
TEST_F(AICPUScheduleInterfaceTEST, StopAICPUScheduler_failed2)
{
    pid_t hostPid = 0;
    AicpuScheduleInterface::GetInstance().noThreadFlag_ = true;
    MOCKER(halEschedDettachDevice)
        .stubs()
        .will(returnValue(10));
    MOCKER(drvHdcGetCapacity)
        .stubs()
        .will(invoke(drvHdcGetCapacity_pcie));
    std::vector<uint32_t> deviceId;
    deviceId.push_back(0);
    AicpuScheduleInterface::GetInstance().GetCurrentRunMode(true);
    int32_t ret = AicpuScheduleInterface::GetInstance().StopAICPUScheduler(deviceId, hostPid);
    EXPECT_EQ(ret, 10);
}

TEST_F(AICPUScheduleInterfaceTEST, DettachDeviceInDestory_success)
{
    MOCKER_CPP(&SubModuleInterface::GetStartFlag).stubs().will(returnValue(false));
    MOCKER_CPP(&FeatureCtrl::ShouldInitDrvThread).stubs().will(returnValue(true));
    MOCKER(GetAicpuDeployContext).stubs().with(outBound(DeployContext::DEVICE)).will(returnValue(AICPU_SCHEDULE_OK));
    std::vector<uint32_t> deviceVec = {1U};
    EXPECT_EQ(AicpuScheduleInterface::GetInstance().DettachDeviceInDestroy(deviceVec), AICPU_SCHEDULE_OK);
}

TEST_F(AICPUScheduleInterfaceTEST, ExecuteProcess_failed1)
{
    AicpuModel *aicpuModel = nullptr;
    MOCKER_CPP(&AicpuModelManager::GetModel).stubs().will(returnValue(aicpuModel));
    int ret = AicpuEventManager::GetInstance().ExecuteProcess(0);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_MODEL_NOT_FOUND);
}

TEST_F(AICPUScheduleInterfaceTEST, ProcessDumpDataEvent_failed1)
{
    TsAicpuSqe ctrlMsg;
    ctrlMsg.cmd_type = AICPU_DATADUMP_RESPONSE;
    ts_to_aicpu_datadump_t ts_to_aicpu_datadump;
    ctrlMsg.u.ts_to_aicpu_datadump = ts_to_aicpu_datadump;
    MOCKER(tsDevSendMsgAsync)
        .stubs()
        .will(returnValue(10));
    AicpuSqeAdapter ada(ctrlMsg, 0U);
    int32_t ret = AicpuEventProcess::GetInstance().ProcessDumpDataEvent(ada);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_INNER_ERROR);
}

TEST_F(AICPUScheduleInterfaceTEST, ProcessLoadOpMappingEvent_failed1)
{
    MOCKER_CPP(&AicpuSdCustDumpProcess::InitCustDumpProcess).stubs().will(returnValue(0));
    TsAicpuSqe ctrlMsg;
    ctrlMsg.cmd_type = AICPU_DATADUMP_RESPONSE;
    ts_to_aicpu_datadumploadinfo_t ts_to_aicpu_datadumploadinfo;
    ctrlMsg.u.ts_to_aicpu_datadumploadinfo = ts_to_aicpu_datadumploadinfo;

    MOCKER(halEschedAckEvent)
        .stubs()
        .will(returnValue(10));
    MOCKER_CPP(&OpDumpTaskManager::LoadOpMappingInfo,int32_t(OpDumpTaskManager::*)(const char_t * const, const uint32_t))
            .stubs()
            .will(returnValue(0));
    MOCKER_CPP(&OpDumpTaskManager::LoadOpMappingInfo,int32_t(OpDumpTaskManager::*)(const char_t * const, const uint32_t, AicpuSqeAdapter &))
            .stubs()
            .will(returnValue(0));
    AicpuSqeAdapter ada(ctrlMsg, 0U);
    int32_t ret = AicpuEventProcess::GetInstance().ProcessLoadOpMappingEvent(ada);
    EXPECT_EQ(ret, 0);
}

TEST_F(AICPUScheduleInterfaceTEST, ParseSoFile_Fail6)
{
    std::vector<uint32_t> deviceVec;
    deviceVec.push_back(1);
    AicpuDrvManager::GetInstance().InitDrvMgr(deviceVec, 3206, 0, true);
    (void)AicpuCustSoManager::GetInstance().InitAicpuCustSoManager(aicpu::AicpuRunMode::THREAD_MODE,
                                                                   SCHED_MODE_INTERRUPT);
    aicpu::SetHaveCustPid(false);
    char* curDirName = getenv("HOME");
    std::string dirName(curDirName);
    if (dirName[dirName.size() - 1] != '/') {
        dirName = dirName + "/";
    }

    char soContent[] = "This is test for loadOpFromBuf";
    void *buf = reinterpret_cast<void *>(soContent);
    size_t kernelSoBufLen = strlen(soContent);
    char kernelSoName[] = "libcust_cpu_kernels.so";

    MOCKER(&AicpuCustSoManager::CheckSoFullPathValid).stubs().will(returnValue(0));
    FileInfo fileInfo = {.data=soContent, .size=kernelSoBufLen, .name=kernelSoName};
    int retStatus = AicpuCustSoManager::GetInstance().CreateSoFile(fileInfo);

    std::string command = "rm -rf ";
    command = command + dirName + "cust_aicpu_0_3206";
    int ret = system(command.c_str());
    if (ret != 0) {
        aicpusd_info("Remove directory %s fail", dirName.c_str());
    }
    EXPECT_EQ(retStatus, AICPU_SCHEDULE_OK);
}

TEST_F(AICPUScheduleInterfaceTEST, ParseSoFile7)
{
    MOCKER(&AicpuCustSoManager::CheckSoFullPathValid).stubs().will(returnValue(0));
    aicpu::SetHaveCustPid(false);
    (void)AicpuCustSoManager::GetInstance().InitAicpuCustSoManager(aicpu::AicpuRunMode::THREAD_MODE,
                                                                   SCHED_MODE_INTERRUPT);
    std::vector<uint32_t> deviceVec;
    deviceVec.push_back(1);
    AicpuDrvManager::GetInstance().InitDrvMgr(deviceVec, 3207, 0, true);
    char* curDirName = getenv("HOME");
    std::string dirName(curDirName);
    if (dirName[dirName.size() - 1] != '/') {
        dirName = dirName + "/";
    }

    char soContent[] = "This is test for loadOpFromBuf";
    void *buf = reinterpret_cast<void *>(soContent);
    size_t kernelSoBufLen = strlen(soContent);
    char kernelSoName[] = "libcust_cpu_kernels.so";
    FileInfo fileInfo = {.data=soContent, .size=kernelSoBufLen, .name=kernelSoName};
    int retStatus = AicpuCustSoManager::GetInstance().CreateSoFile(fileInfo);

    std::string command = "rm -rf ";
    command = command + dirName + "cust_aicpu_0_3207";
    int ret = system(command.c_str());
    if (ret != 0) {
        aicpusd_info("Remove directory %s fail", dirName.c_str());
    }

    EXPECT_EQ(retStatus, AICPU_SCHEDULE_OK);
}

TEST_F(AICPUScheduleInterfaceTEST, ParseSoFile8)
{
    MOCKER(&AicpuCustSoManager::CheckSoFullPathValid).stubs().will(returnValue(0));
    (void)AicpuCustSoManager::GetInstance().InitAicpuCustSoManager(aicpu::AicpuRunMode::THREAD_MODE,
                                                                   SCHED_MODE_INTERRUPT);
    aicpu::SetHaveCustPid(false);
    std::vector<uint32_t> deviceVec;
    deviceVec.push_back(1);
    AicpuDrvManager::GetInstance().InitDrvMgr(deviceVec, 3208, 0, true);
    char* curDirName = getenv("HOME");
    std::string dirName(curDirName);
    if (dirName[dirName.size() - 1] != '/') {
        dirName = dirName + "/";
    }

    char soContent[] = "This is test for loadOpFromBuf";
    void *buf = reinterpret_cast<void *>(soContent);
    size_t kernelSoBufLen = strlen(soContent);
    char kernelSoName[] = "libcust_cpu_kernels.so";
    FileInfo fileInfo = {.data=soContent, .size=kernelSoBufLen, .name=kernelSoName};
    int retStatus = AicpuCustSoManager::GetInstance().CreateSoFile(fileInfo);

    std::string command = "rm -rf ";
    command = command + dirName + "cust_aicpu_0_3208";
    int ret = system(command.c_str());
    if (ret != 0) {
        aicpusd_info("Remove directory %s fail", dirName.c_str());
    }

    EXPECT_EQ(retStatus, AICPU_SCHEDULE_OK);
}

TEST_F(AICPUScheduleInterfaceTEST, ParseSoFile9)
{
    MOCKER(&AicpuCustSoManager::CheckSoFullPathValid).stubs().will(returnValue(0));
    (void)AicpuCustSoManager::GetInstance().InitAicpuCustSoManager(aicpu::AicpuRunMode::THREAD_MODE,
                                                                   SCHED_MODE_INTERRUPT);
    aicpu::SetHaveCustPid(false);
    std::vector<uint32_t> deviceVec;
    deviceVec.push_back(1);
    AicpuDrvManager::GetInstance().InitDrvMgr(deviceVec, 3209, 0, true);
    char* curDirName = getenv("HOME");
    std::string dirName(curDirName);
    if (dirName[dirName.size() - 1] != '/') {
        dirName = dirName + "/";
    }

    char soContent[] = "This is test for loadOpFromBuf";
    void *buf = reinterpret_cast<void *>(soContent);
    size_t kernelSoBufLen = strlen(soContent);
    char kernelSoName[] = "libcust_cpu_kernels.so";
    FileInfo fileInfo = {.data=soContent, .size=kernelSoBufLen, .name=kernelSoName};
    int retStatus = AicpuCustSoManager::GetInstance().CreateSoFile(fileInfo);

    std::string command = "rm -rf ";
    command = command + dirName + "cust_aicpu_0_3209";
    int ret = system(command.c_str());
    if (ret != 0) {
        aicpusd_info("Remove directory %s fail", dirName.c_str());
    }

    EXPECT_EQ(retStatus, AICPU_SCHEDULE_OK);
}

TEST_F(AICPUScheduleInterfaceTEST, InitAicpuCustSoManager1)
{
    MOCKER(&AicpuDrvManager::GetInstance().GetUniqueVfId).stubs().will(returnValue(32));
    int32_t ret = AicpuCustSoManager::GetInstance().InitAicpuCustSoManager(aicpu::AicpuRunMode::PROCESS_PCIE_MODE,
                                                                   SCHED_MODE_INTERRUPT);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
    MOCKER(&AicpuDrvManager::GetInstance().GetUniqueVfId).stubs().will(returnValue(1));
    ret = AicpuCustSoManager::GetInstance().InitAicpuCustSoManager(aicpu::AicpuRunMode::PROCESS_PCIE_MODE,
                                                                   SCHED_MODE_INTERRUPT);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
}

TEST_F(AICPUScheduleInterfaceTEST, AICPUModelStop_Success)
{
    ReDeployConfig *config = new ReDeployConfig();
    config->modelIdNum = 1;
    uint32_t modelIds[1] = {0};
    config->modelIdsAddr = PtrToValue(&modelIds[0]);
    MOCKER_CPP(&AicpuScheduleInterface::Stop)
        .stubs()
        .will(returnValue(AICPU_SCHEDULE_OK));
    EXPECT_EQ(AICPUModelStop(config), AICPU_SCHEDULE_SUCCESS);
    delete config;
    config = nullptr;
}

TEST_F(AICPUScheduleInterfaceTEST, AICPUModelStop_fail1)
{
    EXPECT_EQ(AICPUModelStop(nullptr), AICPU_SCHEDULE_FAIL);
}

TEST_F(AICPUScheduleInterfaceTEST, AICPUModelStop_fail2)
{
    ReDeployConfig *config = new ReDeployConfig();
    config->modelIdNum = 1;
    EXPECT_EQ(AICPUModelStop(config), AICPU_SCHEDULE_FAIL);
    delete config;
    config = nullptr;
}

TEST_F(AICPUScheduleInterfaceTEST, AICPUModelStop_fail3)
{
    ReDeployConfig *config = new ReDeployConfig();
    config->modelIdNum = 1;
    uint32_t modelIds[1] = {0};
    config->modelIdsAddr = PtrToValue(&modelIds[0]);
    MOCKER_CPP(&AicpuScheduleInterface::Stop)
        .stubs()
        .will(returnValue(-1));
    EXPECT_EQ(AICPUModelStop(config), AICPU_SCHEDULE_FAIL);
    delete config;
    config = nullptr;
}

TEST_F(AICPUScheduleInterfaceTEST, AICPUModelClearInputAndRestart_Success)
{
    ReDeployConfig *config = new ReDeployConfig();
    config->modelIdNum = 1;
    uint32_t modelIds[1] = {0};
    config->modelIdsAddr = PtrToValue(&modelIds[0]);
    MOCKER_CPP(&AicpuScheduleInterface::ClearInput)
        .stubs()
        .will(returnValue(AICPU_SCHEDULE_OK));
    MOCKER_CPP(&AicpuScheduleInterface::Restart)
        .stubs()
        .will(returnValue(AICPU_SCHEDULE_OK));
    EXPECT_EQ(AICPUModelClearInputAndRestart(config), AICPU_SCHEDULE_SUCCESS);
    delete config;
    config = nullptr;
}

TEST_F(AICPUScheduleInterfaceTEST, AICPUModelClearInputAndRestart_fail1)
{
    EXPECT_EQ(AICPUModelClearInputAndRestart(nullptr), AICPU_SCHEDULE_FAIL);
}

TEST_F(AICPUScheduleInterfaceTEST, AICPUModelClearInputAndRestart_fail2)
{
    ReDeployConfig *config = new ReDeployConfig();
    config->modelIdNum = 1;
    EXPECT_EQ(AICPUModelClearInputAndRestart(config), AICPU_SCHEDULE_FAIL);
    delete config;
    config = nullptr;
}

TEST_F(AICPUScheduleInterfaceTEST, AICPUModelClearInputAndRestart_fail3)
{
    ReDeployConfig *config = new ReDeployConfig();
    config->modelIdNum = 1;
    uint32_t modelIds[1] = {0};
    config->modelIdsAddr = PtrToValue(&modelIds[0]);
    MOCKER_CPP(&AicpuScheduleInterface::ClearInput)
        .stubs()
        .will(returnValue(-1));
    EXPECT_EQ(AICPUModelClearInputAndRestart(config), AICPU_SCHEDULE_FAIL);
    delete config;
    config = nullptr;
}

TEST_F(AICPUScheduleInterfaceTEST, AICPUModelClearInputAndRestart_fail4)
{
    ReDeployConfig *config = new ReDeployConfig();
    config->modelIdNum = 1;
    uint32_t modelIds[1] = {0};
    config->modelIdsAddr = PtrToValue(&modelIds[0]);
    MOCKER_CPP(&AicpuScheduleInterface::ClearInput)
        .stubs()
        .will(returnValue(AICPU_SCHEDULE_OK));
    MOCKER_CPP(&AicpuScheduleInterface::Restart)
        .stubs()
        .will(returnValue(-1));
    EXPECT_EQ(AICPUModelClearInputAndRestart(config), AICPU_SCHEDULE_FAIL);
    delete config;
    config = nullptr;
}

TEST_F(AICPUScheduleInterfaceTEST, Stop_Success)
{
    AicpuModel *aicpuModel = new AicpuModel();
    MOCKER_CPP(&AicpuModelManager::GetModel).stubs().will(returnValue(aicpuModel));
    MOCKER_CPP(&AicpuModel::ModelStop)
        .stubs()
        .will(returnValue(0));
    int ret = AicpuScheduleInterface::GetInstance().Stop(0U);
    EXPECT_EQ(ret, 0);
    delete aicpuModel;
    aicpuModel = nullptr;
}

TEST_F(AICPUScheduleInterfaceTEST, Stop_fail1)
{
    AicpuModel *aicpuModel = nullptr;
    MOCKER_CPP(&AicpuModelManager::GetModel).stubs().will(returnValue(aicpuModel));
    int ret = AicpuScheduleInterface::GetInstance().Stop(0U);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_MODEL_NOT_FOUND);
}

TEST_F(AICPUScheduleInterfaceTEST, Stop_fail2)
{
    AicpuModel *aicpuModel = new AicpuModel();
    MOCKER_CPP(&AicpuModelManager::GetModel).stubs().will(returnValue(aicpuModel));
    MOCKER_CPP(&AicpuModel::ModelStop)
        .stubs()
        .will(returnValue(0));
    AicpuModelInfo modelInfoT = {0};
    modelInfoT.moduleID = 1;
    (void)aicpuModel->ModelLoad(&modelInfoT);
    MOCKER(tsDevSendMsgAsync).stubs().will(returnValue(-1));
    int ret = AicpuScheduleInterface::GetInstance().Stop(0U);
    EXPECT_EQ(ret, 0);
    delete aicpuModel;
    aicpuModel = nullptr;
}

TEST_F(AICPUScheduleInterfaceTEST, Restart_Success)
{
    AicpuModel *aicpuModel = new AicpuModel();
    MOCKER_CPP(&AicpuModelManager::GetModel).stubs().will(returnValue(aicpuModel));
    MOCKER_CPP(&AicpuModel::ModelRestart)
        .stubs()
        .will(returnValue(0));
    int ret = AicpuScheduleInterface::GetInstance().Restart(0U);
    EXPECT_EQ(ret, 0);
    delete aicpuModel;
    aicpuModel = nullptr;
}

TEST_F(AICPUScheduleInterfaceTEST, Restart_fail)
{
    AicpuModel *aicpuModel = nullptr;
    MOCKER_CPP(&AicpuModelManager::GetModel).stubs().will(returnValue(aicpuModel));
    int ret = AicpuScheduleInterface::GetInstance().Restart(0U);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_MODEL_NOT_FOUND);
}

TEST_F(AICPUScheduleInterfaceTEST, ClearInput_Success)
{
    AicpuModel *aicpuModel = new AicpuModel();
    MOCKER_CPP(&AicpuModelManager::GetModel).stubs().will(returnValue(aicpuModel));
    MOCKER_CPP(&AicpuModel::ModelClearInput)
        .stubs()
        .will(returnValue(0));
    int ret = AicpuScheduleInterface::GetInstance().ClearInput(0U);
    EXPECT_EQ(ret, 0);
    delete aicpuModel;
    aicpuModel = nullptr;
}

TEST_F(AICPUScheduleInterfaceTEST, ClearInput_fail)
{
    AicpuModel *aicpuModel = nullptr;
    MOCKER_CPP(&AicpuModelManager::GetModel).stubs().will(returnValue(aicpuModel));
    int ret = AicpuScheduleInterface::GetInstance().ClearInput(0U);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_MODEL_NOT_FOUND);
}

TEST_F(AICPUScheduleInterfaceTEST, TsKernelCheckKernelSupported_success)
{
    CheckKernelSupportedConfig *config = new CheckKernelSupportedConfig();
    config->kernelNameLen = 8;
    char *OpraterkernelName = "markStep";
    config->kernelNameAddr = PtrToValue(&OpraterkernelName[0]);
    uint32_t retValue = 10;
    config->checkResultAddr = PtrToValue(&retValue);
    config->checkResultLen = sizeof(uint32_t);
    int ret = CheckKernelSupported(config);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
    uint32_t *resultAddr = PtrToPtr<void, uint32_t>(ValueToPtr(config->checkResultAddr));
    EXPECT_EQ(*resultAddr, AICPU_SCHEDULE_OK);

    char *tsKernelName = "tsKernel:ProcessDataException";
    config->kernelNameAddr = PtrToValue(tsKernelName);
    config->kernelNameLen = strlen(tsKernelName);
    retValue = 10;
    ret = CheckKernelSupported(config);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
    EXPECT_EQ(retValue, AICPU_SCHEDULE_OK);

    delete config;
    config = nullptr;
}
 
TEST_F(AICPUScheduleInterfaceTEST, TsKernelCheckKernelSupported_failed01)
{
    CheckKernelSupportedConfig *config = new CheckKernelSupportedConfig();
    config->kernelNameLen = 14;
    char *OpraterkernelName = "markStepMytest";
    config->kernelNameAddr = PtrToValue(&OpraterkernelName[0]);
    uint32_t retValue = 10;
    config->checkResultAddr = PtrToValue(&retValue);
    config->checkResultLen = 0;
    int ret = CheckKernelSupported(config);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
    uint32_t *resultAddr = PtrToPtr<void, uint32_t>(ValueToPtr(config->checkResultAddr));
    EXPECT_EQ(*resultAddr, AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID);

    char *tsKernelName = "tsKernel:Unknown";
    config->kernelNameAddr = PtrToValue(tsKernelName);
    config->kernelNameLen = strlen(tsKernelName);
    retValue = 0;
    ret = CheckKernelSupported(config);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
    EXPECT_EQ(retValue, AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID);

    delete config;
    config = nullptr;
}

TEST_F(AICPUScheduleInterfaceTEST, TsKernelCheckKernelSupported_failed02)
{
    EXPECT_EQ(CheckKernelSupported(nullptr), AICPU_SCHEDULE_FAIL);
}

TEST_F(AICPUScheduleInterfaceTEST, TsKernelCheckKernelSupported_failed3)
{
    CheckKernelSupportedConfig *config = new CheckKernelSupportedConfig();
    int ret = CheckKernelSupported(config);
    EXPECT_EQ(ret, AICPU_SCHEDULE_FAIL);
    delete config;
    config = nullptr;
}

TEST_F(AICPUScheduleInterfaceTEST, AICPUModelDestroy_failed)
{
    MOCKER_CPP(&AicpuScheduleInterface::Destroy, int32_t(AicpuScheduleInterface::*)(const uint32_t)const).stubs().will(returnValue(AICPU_SCHEDULE_ERROR_MODEL_NOT_FOUND));
    EXPECT_EQ(AICPUModelDestroy(1U), AICPU_SCHEDULE_FAIL);
}

TEST_F(AICPUScheduleInterfaceTEST, AICPUModelExecute_failed)
{
    MOCKER_CPP(&AicpuEventManager::ExecuteProcess).stubs().will(returnValue(AICPU_SCHEDULE_ERROR_MODEL_NOT_FOUND));
    EXPECT_EQ(AICPUModelExecute(1U), AICPU_SCHEDULE_FAIL);
}

TEST_F(AICPUScheduleInterfaceTEST, AICPUExecuteTask_success)
{
    struct event_info drvEventInfo = {};
    struct event_ack drvEventAck = {};
    MOCKER_CPP(&AicpuEventManager::ExecuteProcessSyc).stubs().will(returnValue(AicpuSchedule::AICPU_SCHEDULE_OK));
    EXPECT_EQ(AICPUExecuteTask(&drvEventInfo, &drvEventAck), AICPU_SCHEDULE_SUCCESS);
}

TEST_F(AICPUScheduleInterfaceTEST, AICPUExecuteTask_failed)
{
    struct event_info *drvEventInfo;
    struct event_ack *drvEventAck;
    MOCKER_CPP(&AicpuEventManager::ExecuteProcessSyc).stubs().will(returnValue(AICPU_SCHEDULE_ERROR_MODEL_NOT_FOUND));
    EXPECT_EQ(AICPUExecuteTask(drvEventInfo, drvEventAck), AICPU_SCHEDULE_FAIL);
}

TEST_F(AICPUScheduleInterfaceTEST, AICPUPreOpenKernels_failed)
{
    const char* soName = "lib.so";
    MOCKER_CPP(aeBatchLoadKernelSo).stubs().will(returnValue(AE_STATUS_END_OF_SEQUENCE));
    EXPECT_EQ(AICPUPreOpenKernels(soName), AE_STATUS_END_OF_SEQUENCE);
}

TEST_F(AICPUScheduleInterfaceTEST, InitAICPUScheduler_failed0)
{
    pid_t hostPid = 0;
    const uint32_t deviceId = 2;
    const ProfilingMode profilingMode;
    MOCKER_CPP(&AicpuSchedule::AicpuScheduleInterface::IsInitialized).stubs().will(returnValue(false));
    MOCKER_CPP(AicpuSchedule::AicpuUtil::IsEnvValEqual).stubs().will(returnValue(true));
    MOCKER(GetAicpuDeployContext).stubs().with(outBound(DeployContext::DEVICE)).will(returnValue(-1));
    int ret = InitAICPUScheduler(deviceId, hostPid, profilingMode);
    EXPECT_EQ(ret, -1);
}

TEST_F(AICPUScheduleInterfaceTEST, InitAICPUScheduler_failed3)
{
    pid_t hostPid = 0;
    const uint32_t deviceId = 2;
    const ProfilingMode profilingMode;
    MOCKER_CPP(&AicpuScheduleInterface::IsInitialized).stubs().will(returnValue(false));
    MOCKER_CPP(AicpuSchedule::AicpuUtil::IsEnvValEqual).stubs().will(returnValue(false));
    MOCKER_CPP(DlogSetAttr).stubs().will(returnValue(1));
    MOCKER(GetAicpuDeployContext).stubs().with(outBound(DeployContext::DEVICE)).will(returnValue(AICPU_SCHEDULE_OK));
    MOCKER_CPP(drvGetProcessSign).stubs().will(returnValue(DRV_ERROR_SCHED_WAIT_TIMEOUT));
    int ret = InitAICPUScheduler(deviceId, hostPid, profilingMode);
    EXPECT_EQ(ret, AICPU_SCHEDULE_FAIL);
}

TEST_F(AICPUScheduleInterfaceTEST, UpdateProfilingMode_success)
{
    pid_t hostPid = 0;
    const uint32_t deviceId = 2;
    uint32_t flag = 1;
    int ret = UpdateProfilingMode(deviceId, hostPid, flag);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
}

TEST_F(AICPUScheduleInterfaceTEST, AicpuSetMsprofReporterCallback)
{
    MsprofReporterCallback reportCallback;
    MOCKER_CPP(aicpu::SetMsprofReporterCallback).stubs().will(returnValue(AICPU_SCHEDULE_OK));
    int ret = AicpuSetMsprofReporterCallback(reportCallback);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
}

TEST_F(AICPUScheduleInterfaceTEST, AicpuLoadModelWithQ_success)
{
    MOCKER_CPP(&AicpuSchedule::AicpuScheduleInterface::LoadModelWithQueue).stubs().will(returnValue(AicpuSchedule::AICPU_SCHEDULE_OK));
    int ret = AicpuLoadModelWithQ(nullptr);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
}

TEST_F(AICPUScheduleInterfaceTEST, AicpuLoadModel)
{
    MOCKER_CPP(&AicpuSchedule::AicpuScheduleInterface::LoadModelWithEvent).stubs().will(returnValue(-1));
    int ret = AicpuLoadModel(nullptr);
    EXPECT_EQ(ret, AICPU_SCHEDULE_FAIL);
}

TEST_F(AICPUScheduleInterfaceTEST, StopCPUScheduler_success)
{
    MOCKER_CPP(&AicpuSchedule::AicpuScheduleInterface::StopAICPUSchedulerWithFlag).stubs().will(returnValue(0));
    int ret = StopCPUScheduler(0, 0);
    EXPECT_EQ(ret, 0);
}

TEST_F(AICPUScheduleInterfaceTEST, AICPUModelProcessDataException_success)
{
    DataFlowExceptionNotify notify = {};
    notify.modelIdNum = 2U;
    std::vector<uint32_t> modelIds = {0U, 1U};
    notify.modelIdsAddr = PtrToValue(modelIds.data());

    AicpuModelManager::GetInstance().allModel_[0U].modelId_ = 0U;
    AicpuModelManager::GetInstance().allModel_[0U].isValid = true;
    AicpuModel &aicpuModel0 = AicpuModelManager::GetInstance().allModel_[0U];
    AicpuModelManager::GetInstance().allModel_[1U].modelId_ = 1U;
    AicpuModelManager::GetInstance().allModel_[1U].isValid = true;
    AicpuModel &aicpuModel1 = AicpuModelManager::GetInstance().allModel_[1U];

    // first adding execption transid
    EXPECT_EQ(AICPUModelProcessDataException(&notify), AICPU_SCHEDULE_OK);

    // repeat adding execption transid
    EXPECT_EQ(AICPUModelProcessDataException(&notify), AICPU_SCHEDULE_OK);

    // first expiring execption transid
    notify.type = 1U;
    EXPECT_EQ(AICPUModelProcessDataException(&notify), AICPU_SCHEDULE_OK);
    // repeat expiring execption transid
    EXPECT_EQ(AICPUModelProcessDataException(&notify), AICPU_SCHEDULE_OK);
    aicpuModel0.isValid = false;
    aicpuModel1.isValid = false;
}

TEST_F(AICPUScheduleInterfaceTEST, AICPUModelProcessDataException_fail_for_invalid_model)
{
    DataFlowExceptionNotify notify = {};
    notify.modelIdNum = 2U;
    std::vector<uint32_t> modelIds = {0U, 1U};
    notify.modelIdsAddr = PtrToValue(modelIds.data());

    AicpuModel aicpuModel0;
    aicpuModel0.modelId_ = 0U;
    AicpuModel *nullAicpuModel = nullptr;
    MOCKER_CPP(&AicpuModelManager::GetModel).stubs()
        .will(returnValue(&aicpuModel0))
        .then(returnValue(nullAicpuModel));

    EXPECT_EQ(AICPUModelProcessDataException(&notify), AICPU_SCHEDULE_ERROR_MODEL_NOT_FOUND);
}

TEST_F(AICPUScheduleInterfaceTEST, AICPUModelProcessDataException_fail_for_invalid_parameter)
{
    // fail for null exception info
    EXPECT_EQ(AICPUModelProcessDataException(nullptr), AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID);

    // fail for modelIdsAddr null
    DataFlowExceptionNotify notify = {};
    notify.modelIdNum = 2U;
    EXPECT_EQ(AICPUModelProcessDataException(&notify), AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID);

    // fail for invalid type
    std::vector<uint32_t> modelIds = {0U};
    notify.modelIdsAddr = PtrToValue(modelIds.data());
    notify.type = 3U;
    AicpuModel aicpuModel0;
    aicpuModel0.modelId_ = 0U;
    MOCKER_CPP(&AicpuModelManager::GetModel).stubs().will(returnValue(&aicpuModel0));
    EXPECT_EQ(AICPUModelProcessDataException(&notify), AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID);
}

TEST_F(AICPUScheduleInterfaceTEST, BuildAndSetContext_001)
{
    MOCKER_CPP(&FeatureCtrl::IsAosCore).stubs().will(returnValue(true));
    auto ret = AicpuScheduleInterface::GetInstance().BuildAndSetContext(0, 0, 0);
    EXPECT_EQ(ret, 0);
}

TEST_F(AICPUScheduleInterfaceTEST, AICPUEventUpdateProfilingMode_devnull)
{
    AICPUSubEventInfo event;
    AICPUProfilingModeInfo modeInfo;
    modeInfo.flag = 7U;
    event.para.modeInfo = modeInfo;
    std::vector<uint32_t> deviceVec = AicpuDrvManager::GetInstance().deviceVec_;
    AicpuDrvManager::GetInstance().deviceVec_.clear();
    int ret = AicpuEventProcess::GetInstance().AICPUEventUpdateProfilingMode(event);
    AicpuDrvManager::GetInstance().deviceVec_ = deviceVec;
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_TASK_EXECUTE_FAILED);
}

TEST_F(AICPUScheduleInterfaceTEST, CheckTsKernelSupportedFailed)
{
    int32_t ret = HwTsKernelRegister::Instance().CheckTsKernelSupported("test");
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID);
}