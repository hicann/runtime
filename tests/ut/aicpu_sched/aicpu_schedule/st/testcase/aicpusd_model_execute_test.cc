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
#include "aicpusd_info.h"
#include "aicpusd_interface.h"
#include "aicpusd_status.h"
#include "ascend_hal.h"
#include "aicpu_event_struct.h"
#include <pthread.h>
#define private public
#include "aicpusd_event_process.h"
#include "aicpusd_interface_process.h"
#include "task_queue.h"
#include "dump_task.h"
#include "aicpu_sharder.h"
#include "aicpusd_threads_process.h"
#include "aicpusd_task_queue.h"
#include "tdt_server.h"
#include "aicpusd_model_execute.h"
#include "aicpusd_model_err_process.h"
#include "aicpusd_msg_send.h"
#undef private

using namespace AicpuSchedule;
using namespace aicpu;
using namespace std;

namespace {
    HcclResult HcclCpuCommInitClusterInfoMemConfig(const char_t *rankTable, uint32_t rank, HcclCommConfig *config)
    {
        return HCCL_SUCCESS;
    }
    std::map<std::string, void*> hcclSymbols = {
        {"HcclCpuCommInitClusterInfoMemConfig", (void*)(HcclCpuCommInitClusterInfoMemConfig)},
    };
    void *dlsymFake(void *handle, const char *symbol)
    {
        auto symbolIter = hcclSymbols.find(std::string(symbol));
        if (symbolIter != hcclSymbols.end()) {
            return symbolIter->second;
        }
        return nullptr;
    }

    void *dlsymFakeNull(void *handle, const char *symbol)
    {
        return nullptr;
    }
}
class AICPUModelExecuteTEST : public testing::Test {
protected:
    static void SetUpTestCase() {
        std::cout << "AICPUModelExecuteTEST SetUpTestCase" << std::endl;
    }

    static void TearDownTestCase() {
        std::cout << "AICPUModelExecuteTEST TearDownTestCase" << std::endl;
    }

    virtual void SetUp()
    {
        std::cout << "AICPUModelExecuteTEST SetUP" << std::endl;
    }

    virtual void TearDown()
    {
        GlobalMockObject::verify();
        std::cout << "AICPUModelExecuteTEST TearDown" << std::endl;
    }
};

int pthread_rwlock_trywrlock_stub(pthread_rwlock_t *rwlock) {
    return 0;
}

int pthread_rwlock_unlock_stub(pthread_rwlock_t *rwlock) {
    return 0;
}

constexpr uint32_t maxMbufNumInMbuflist = 20;
constexpr uint32_t mbufSize = 384;
constexpr uint32_t maxQueueNum = 64;
char dequeueFakeMBuf[maxQueueNum][maxMbufNumInMbuflist][mbufSize] = {0};
char queueNum = 0;
uint16_t g_queryCount = 0;

drvError_t halQueueDeQueueSuccessFake(unsigned int devId, unsigned int qid, void **mbuf)
{
    uint32_t index = qid%maxQueueNum;
    *mbuf = (Mbuf *)dequeueFakeMBuf[index];
    if (queueNum++ == 0) {
        return DRV_ERROR_NONE;
    } else {
        return DRV_ERROR_QUEUE_EMPTY;
    }
}

HcclResult hcomPrepareQueryStub2(HcomRequest request, HcomStatus *status)
{
    if (g_queryCount++ <= 500) {
        status->status = 1;
        return 0;
    } else {
        status->status == -1;
        g_queryCount = 0;
        return 1;
    }
}

StatusCode GetAicpuDeployContextOnHost(DeployContext &deployCtx)
{
    deployCtx = DeployContext::HOST;
    return AICPU_SCHEDULE_OK;
}

constexpr uint32_t mbufDataOffSet = 256;
constexpr uint32_t modelId = 1;
RunContext runContextT = {.modelId = modelId,
                          .modelTsId = 1,
                          .streamId = 1,
                          .pending = false,
                          .executeInline = true};
int32_t halMbufGetBuffAddrFake(Mbuf *mbuf, void **buf)
{
    // 假设每个dataPtr间隔一个mbufDataOffSet，mbuf指针和第一个dataPtr也间隔一个mbufDataOffSet
    *buf = (void*)((char*)mbuf+mbufDataOffSet);
    printf("getMbufDataPtr mbuf:%p, dataPtr:%p.\n", mbuf, *buf);
    return 0;
}

int halMbufGetPrivInfoFake2(Mbuf *mbuf,  void **priv, unsigned int *size)
{
    *priv = (void *)mbuf;
    *size = mbufDataOffSet;
    return DRV_ERROR_NONE;
}

int halMbufAllocFakeByAlloc(unsigned int size, unsigned int align, unsigned long flag, int grp_id, Mbuf **mbuf)
{
    *mbuf = reinterpret_cast<Mbuf*>(malloc(size + mbufDataOffSet));
    printf("halMbufAllocFakeByAlloc mbuf:%p\n", *mbuf);
    return 0;
}

int halMbufFreeFakeByFree(Mbuf *mbuf)
{
    printf("halMbufFreeFakeByFree mbuf:%p\n", mbuf);
    free(mbuf);
    return 0;
}

TEST_F(AICPUModelExecuteTEST, ModelExecute_success) {
    AicpuModel *aicpuModel = new AicpuModel();
    AicpuModelInfo modelInfoT;
    QueInfo modelQueueInfo = {0};
    modelQueueInfo.queueID = 128;
    modelQueueInfo.flag = 0;
    modelInfoT.queueSize = 1;
    modelInfoT.queueInfoPtr = (uintptr_t)&modelQueueInfo;
    int ret = aicpuModel->LoadQueueInfo(&modelInfoT);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);

    MOCKER_CPP(&AicpuModel::CheckOperateAndUpdateStatus)
        .stubs()
        .will(returnValue(0));
    MOCKER(pthread_rwlock_trywrlock)
        .stubs()
        .will(invoke(pthread_rwlock_trywrlock_stub));
    MOCKER(pthread_rwlock_unlock)
        .stubs()
        .will(invoke(pthread_rwlock_unlock_stub));

    ret = aicpuModel->ModelExecute();
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_STREAM_NOT_FOUND);
    aicpuModel->ClearLoadInfo();
    delete aicpuModel;
    aicpuModel = nullptr;
}

TEST_F(AICPUModelExecuteTEST, ModelExecuteLockFailed) {
    AicpuModel *aicpuModel = new AicpuModel();
    std::unique_lock<std::mutex> lockForModel(aicpuModel->mutexForModel_, std::try_to_lock);
    int ret = aicpuModel->ModelExecute();
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_IN_WORKING);
    delete aicpuModel;
    aicpuModel = nullptr;
}

TEST_F(AICPUModelExecuteTEST, ModelExecute_GetIteratorId) {
    AicpuModel *aicpuModel = new AicpuModel();
    aicpuModel->iteratorCount_ = 0x55;
    auto id = aicpuModel->GetIteratorId();
    EXPECT_EQ(id, 0x55);
    delete aicpuModel;
    aicpuModel = nullptr;
}

TEST_F(AICPUModelExecuteTEST, ModelAbort) {
    AicpuModel *aicpuModel = new AicpuModel();
    std::unique_lock<std::mutex> lockForModel(aicpuModel->mutexForModel_, std::try_to_lock);
    int ret = aicpuModel->ModelAbort();
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_IN_WORKING);
    delete aicpuModel;
    aicpuModel = nullptr;
}

TEST_F(AICPUModelExecuteTEST, hccl_api_test)
{
    HcclResult ret = StubHcomCreateGroup(nullptr, 0U, nullptr);
    EXPECT_EQ(ret, HCCL_E_RESERVED);

    ret = StubHcomDestroyGroup(nullptr);
    EXPECT_EQ(ret, HCCL_E_RESERVED);

    ret = StubHcomBroadcastByOS(nullptr, 0UL, 0, 0, nullptr, 0UL);
    EXPECT_EQ(ret, HCCL_E_RESERVED);

    ret = StubHcomGatherByOS(nullptr, 0UL, 0, nullptr, 0UL, 0, 0, nullptr, 0UL);
    EXPECT_EQ(ret, HCCL_E_RESERVED);
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

TEST_F(AICPUModelExecuteTEST, AicpuLoadModelWithEventForSyncEventSuccess)
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


TEST_F(AICPUModelExecuteTEST, ExecuteStreamMissingModel) {
    AicpuModel aicpuModel;
    aicpuModel.modelId_ = 0U;
    aicpuModel.abnormalBreak_ = true;
    aicpuModel.abnormalEnabled_ = true;
    std::vector<const AicpuTaskInfo *> streamTasks;
    std::string names[] = {"prepareMem", "getLookupReq", "setLookupResp", "getUpdateReq", "setUpdateResp",
        "collRecvLookupReq", "collSendLookupResp", "batchRecv", "streamRepeat"};
    AicpuTaskInfo tasks[9] = {};

    StreamRepeatTaskParam repeatStreamInfo = {};
    repeatStreamInfo.modelId = 0U;
    repeatStreamInfo.streamId = 0U;
    for (size_t i = 0U; i < 9U; ++i) {
        tasks[i].taskID = i;
        tasks[i].kernelType = 0U;
        tasks[i].kernelName = PtrToValue(names[i].c_str());
        tasks[i].paraBase = PtrToValue(&repeatStreamInfo);
        streamTasks.emplace_back(&tasks[i]);
    }
    AicpuModel *nullModel = nullptr;
    MOCKER_CPP(&AicpuModelManager::GetModel).stubs().will(repeat(nullModel, 16)).then(returnValue(&aicpuModel));
    MOCKER_CPP(&AicpuModel::CheckOperate).stubs().will(returnValue(0));
    MOCKER_CPP(&AicpuModelErrProc::RecordAicpuOpErrLog).stubs().will(ignoreReturnValue());
    aicpuModel.aicpuStreams_[0].InitAicpuStream(0, streamTasks);
    EXPECT_NE(aicpuModel.ExecuteStream(0, false), AICPU_SCHEDULE_OK);
    EXPECT_NE(aicpuModel.ExecuteStream(0, true), AICPU_SCHEDULE_ERROR_STREAM_NOT_FOUND);
}

TEST_F(AICPUModelExecuteTEST, AICPUModelStop_Success)
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
 
TEST_F(AICPUModelExecuteTEST, AICPUModelStop_fail1)
{
    EXPECT_EQ(AICPUModelStop(nullptr), AICPU_SCHEDULE_FAIL);
}
 
TEST_F(AICPUModelExecuteTEST, AICPUModelStop_fail2)
{
    ReDeployConfig *config = new ReDeployConfig();
    config->modelIdNum = 1;
    EXPECT_EQ(AICPUModelStop(config), AICPU_SCHEDULE_FAIL);
    delete config;
    config = nullptr;
}
 
TEST_F(AICPUModelExecuteTEST, AICPUModelStop_fail3)
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

TEST_F(AICPUModelExecuteTEST, AICPUModelStop_fail4)
{
    AicpuModel *aicpuModel = new AicpuModel();
    std::unique_lock<std::mutex> lockForModel(aicpuModel->mutexForModel_, std::try_to_lock);
    int ret = aicpuModel->ModelStop();
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_IN_WORKING);
    delete aicpuModel;
    aicpuModel = nullptr;
}

TEST_F(AICPUModelExecuteTEST, ModelRestart_LockFail)
{
    AicpuModel *aicpuModel = new AicpuModel();
    std::unique_lock<std::mutex> lockForModel(aicpuModel->mutexForModel_, std::try_to_lock);
    int ret = aicpuModel->ModelRestart();
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_IN_WORKING);
    delete aicpuModel;
    aicpuModel = nullptr;
}

TEST_F(AICPUModelExecuteTEST, ModelClearInput_LockFail)
{
    AicpuModel *aicpuModel = new AicpuModel();
    std::unique_lock<std::mutex> lockForModel(aicpuModel->mutexForModel_, std::try_to_lock);
    int ret = aicpuModel->ModelClearInput();
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_IN_WORKING);
    delete aicpuModel;
    aicpuModel = nullptr;
}

TEST_F(AICPUModelExecuteTEST, EndGraph_LockFailed)
{
    AicpuModel *aicpuModel = new AicpuModel();
    std::unique_lock<std::mutex> lockForModel(aicpuModel->mutexForModel_, std::try_to_lock);
    int ret = aicpuModel->EndGraph();
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_IN_WORKING);
    delete aicpuModel;
    aicpuModel = nullptr;
}

TEST_F(AICPUModelExecuteTEST, EndGraph_Success)
{
    AicpuModel *aicpuModel = new AicpuModel();
    MOCKER_CPP(&AicpuModel::CheckOperateAndUpdateStatus)
        .stubs()
        .will(returnValue(0));
    int ret = aicpuModel->EndGraph();
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
    delete aicpuModel;
    aicpuModel = nullptr;
}

TEST_F(AICPUModelExecuteTEST, Exit_success) {
    AicpuModel *aicpuModel = new AicpuModel();
    aicpuModel->isValid = true;
    MOCKER_CPP(&AicpuModel::ReleaseModelResource)
            .stubs()
            .will(returnValue(0));
    aicpuModel->RecordLockedTable(5);
    aicpuModel->RecordLockedTable(5);
    aicpuModel->ClearLockedTable(1);
    auto ret = aicpuModel->Exit();
    EXPECT_EQ(ret, 0);
    delete aicpuModel;
    aicpuModel = nullptr;
}
 
TEST_F(AICPUModelExecuteTEST, AICPUModelClearInputAndRestart_Success)
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
 
TEST_F(AICPUModelExecuteTEST, AICPUModelClearInputAndRestart_fail1)
{
    EXPECT_EQ(AICPUModelClearInputAndRestart(nullptr), AICPU_SCHEDULE_FAIL);
}
 
TEST_F(AICPUModelExecuteTEST, AICPUModelClearInputAndRestart_fail2)
{
    ReDeployConfig *config = new ReDeployConfig();
    config->modelIdNum = 1;
    EXPECT_EQ(AICPUModelClearInputAndRestart(config), AICPU_SCHEDULE_FAIL);
    delete config;
    config = nullptr;
}
 
TEST_F(AICPUModelExecuteTEST, AICPUModelClearInputAndRestart_fail3)
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
 
TEST_F(AICPUModelExecuteTEST, AICPUModelClearInputAndRestart_fail4)
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

TEST_F(AICPUModelExecuteTEST, loadCfgErrorForEmbedding) {
    ModelCfgInfo cfgInfo = {};
    MOCKER_CPP(&AicpuModel::InitBufPool)
        .stubs()
        .will(returnValue(-1))
        .then(returnValue(0));
    cfgInfo.modelType = 0U;
    cfgInfo.memoryRegister = true;
    AicpuModel tempModel;
    // fail for initbuffpool
    EXPECT_EQ(tempModel.LoadCfg(&cfgInfo), AICPU_SCHEDULE_ERROR_INNER_ERROR);
    // fail for hcom was not initialiezed
    EXPECT_EQ(tempModel.LoadCfg(&cfgInfo), AICPU_SCHEDULE_ERROR_INNER_ERROR);
    // fail for invalid client ranks
    auto &modelManager = AicpuModelManager::GetInstance();
    modelManager.hcclEmbInit_ = true;
    cfgInfo.clientRankNum = 2U;
    EXPECT_EQ(tempModel.LoadCfg(&cfgInfo), AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID);
    // fail for hccl
    uint32_t ranks[2U] = {0U, 1U};
    cfgInfo.clientRankAddr = PtrToValue(&ranks[0U]);
    EXPECT_EQ(tempModel.LoadCfg(&cfgInfo), AICPU_SCHEDULE_ERROR_CALL_HCCL);
    // success
    MOCKER(StubHcclPsAssociateWorkers).stubs().will(returnValue(HCCL_SUCCESS));
    EXPECT_EQ(tempModel.LoadCfg(&cfgInfo), AICPU_SCHEDULE_OK);
    modelManager.hcclEmbInit_ = false;
    GlobalMockObject::verify();
}

TEST_F(AICPUModelExecuteTEST, loadCfgErrorForSyncEvent) {
    ModelCfgInfo cfgInfo = {};
    MOCKER_CPP(&AicpuModel::InitModelGroups)
        .stubs()
        .will(returnValue(1))
        .then(returnValue(0));
    MOCKER_CPP(&AicpuModel::PrepareHcclLink)
        .stubs()
        .will(returnValue(1))
        .then(returnValue(0));
    MOCKER_CPP(&AicpuModel::InitBufPool)
        .stubs()
        .will(returnValue(-1));
    cfgInfo.modelType = 1U;
    AicpuModel tempModel;
    // fail for InitModelGroups
    EXPECT_EQ(tempModel.LoadCfg(&cfgInfo), 1);
    // fail for PrepareHcclLink
    EXPECT_EQ(tempModel.LoadCfg(&cfgInfo), 1);
    // fail for InitBufPool
    EXPECT_EQ(tempModel.LoadCfg(&cfgInfo), AICPU_SCHEDULE_ERROR_INNER_ERROR);
    GlobalMockObject::verify();
}

TEST_F(AICPUModelExecuteTEST, loadCfgError_03) {
    ModelCfgInfo cfgInfo;
    MOCKER_CPP(&AicpuModel::InitModelGroups)
        .stubs()
        .will(returnValue(0));
    MOCKER_CPP(&AicpuModel::PrepareHcclLink)
        .stubs()
        .will(returnValue(0));
    MOCKER_CPP(&AicpuModel::InitBufPool)
        .stubs()
        .will(returnValue(-1));
    cfgInfo.modelType = 1U;
    AicpuModel tempModel;
    StatusCode ret = tempModel.LoadCfg(&cfgInfo);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_INNER_ERROR);
    GlobalMockObject::verify();
}

TEST_F(AICPUModelExecuteTEST, loadCfgError_04) {
    ModelCfgInfo cfgInfo;
    MOCKER_CPP(&AicpuModel::InitModelGroups)
        .stubs()
        .will(returnValue(1));
    cfgInfo.modelType = 1U;
    AicpuModel tempModel;
    StatusCode ret = tempModel.LoadCfg(&cfgInfo);
    EXPECT_EQ(ret, 1);
    GlobalMockObject::verify();
}

TEST_F(AICPUModelExecuteTEST, AttachReportStatusQueueParaIsNull) {
    AicpuStream stream;

    std::string kernelName = "modelReportStatus";
    AicpuTaskInfo taskInfo = {};
    taskInfo.kernelName = PtrToValue(kernelName.data());
    taskInfo.paraBase = 0UL;
    stream.tasks_.clear();
    stream.tasks_.push_back(taskInfo);

    const int32_t ret = stream.AttachReportStatusQueue();
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID);
}

TEST_F(AICPUModelExecuteTEST, AttachReportStatusQueueAttachFail) {
    AicpuStream stream;

    std::string kernelName = "modelReportStatus";
    ReportStatusInfo bufInfo = {};
    AicpuTaskInfo taskInfo = {};
    taskInfo.kernelName = PtrToValue(kernelName.data());
    taskInfo.paraBase = PtrToValue(&bufInfo);;
    stream.tasks_.clear();
    stream.tasks_.push_back(taskInfo);

    MOCKER(halQueueAttach).stubs().will(returnValue(static_cast<int32_t>(DRV_ERROR_INVALID_VALUE)));
    const int32_t ret = stream.AttachReportStatusQueue();
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_FROM_DRV);
}

TEST_F(AICPUModelExecuteTEST, ModelLoadLoadSuccess) {
    StreamInfo stream = {
        .streamID = 1U,
        .streamFlag = AICPU_STREAM_INDEX|HEAD_STREAM_INDEX,
    };

    std::string kernelName = "endGraph";
    AicpuTaskInfo task = {
        .taskID = 0U,
        .streamID = 1U,
        .kernelType = 0,
        .kernelName = PtrToValue(kernelName.data())
    };

    AicpuModelInfo modelInfoT = {
        .moduleID = 1U,
        .tsId = 1U,
        .streamInfoNum = 1,
        .aicpuTaskNum = 1,
        .streamInfoPtr = PtrToValue(&stream),
        .aicpuTaskPtr = PtrToValue(&task),
        .queueSize = 0,
        .queueInfoPtr = 0UL
    };

    AicpuModelManager::GetInstance().msgQMap_.emplace(modelInfoT.moduleID, std::make_pair(1, 2));

    AicpuModel aicpuModel;
    int ret = aicpuModel.ModelLoad(&modelInfoT);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
}

TEST_F(AICPUModelExecuteTEST, ModelLoadLoadLockFailed) {
    StreamInfo stream = {
        .streamID = 1U,
        .streamFlag = AICPU_STREAM_INDEX|HEAD_STREAM_INDEX,
    };

    std::string kernelName = "endGraph";
    AicpuTaskInfo task = {
        .taskID = 0U,
        .streamID = 1U,
        .kernelType = 0,
        .kernelName = PtrToValue(kernelName.data())
    };

    AicpuModelInfo modelInfoT = {
        .moduleID = 1U,
        .tsId = 1U,
        .streamInfoNum = 1,
        .aicpuTaskNum = 1,
        .streamInfoPtr = PtrToValue(&stream),
        .aicpuTaskPtr = PtrToValue(&task),
        .queueSize = 0,
        .queueInfoPtr = 0UL
    };

    AicpuModelManager::GetInstance().msgQMap_.emplace(modelInfoT.moduleID, std::make_pair(1, 2));

    AicpuModel aicpuModel;
    std::unique_lock<std::mutex> lockForModel(aicpuModel.mutexForModel_, std::try_to_lock);
    int ret = aicpuModel.ModelLoad(&modelInfoT);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_IN_WORKING);
}

TEST_F(AICPUModelExecuteTEST, ModelLoadCheckStatusFail) {
    AicpuModel aicpuModel;

    MOCKER_CPP(&AicpuModel::CheckOperateAndUpdateStatus).stubs().will(returnValue(1));
    AicpuModelInfo modelInfoT = {0};
    modelInfoT.moduleID = 1;
    int ret = aicpuModel.ModelLoad(&modelInfoT);
    EXPECT_EQ(ret, 1);
}

TEST_F(AICPUModelExecuteTEST, ModelExecute_failed1) {
    AicpuModel *aicpuModel = new AicpuModel();

    MOCKER_CPP(&AicpuModel::CheckOperateAndUpdateStatus)
        .stubs()
        .will(returnValue(-1));

    int ret = aicpuModel->ModelExecute();
    EXPECT_EQ(ret, -1);
    delete aicpuModel;
    aicpuModel = nullptr;
}

TEST_F(AICPUModelExecuteTEST, ModelExecute_failed2) {
    AicpuModel *aicpuModel = new AicpuModel();

    MOCKER_CPP(&AicpuModel::CheckOperateAndUpdateStatus)
        .stubs()
        .will(returnValue(0));
    MOCKER_CPP(&AicpuModel::ResetModelForExecute)
        .stubs()
        .will(returnValue(-1));

    int ret = aicpuModel->ModelExecute();
    EXPECT_EQ(ret, -1);
    delete aicpuModel;
    aicpuModel = nullptr;
}

TEST_F(AICPUModelExecuteTEST, ModelLoadLoadStreamAndDestroyFail) {
    MOCKER_CPP(&AicpuModel::ModelDestroy).stubs()
        .will(returnValue(static_cast<int32_t>(AICPU_SCHEDULE_ERROR_INNER_ERROR)));
    AicpuModelInfo modelInfoT = {0};
    modelInfoT.moduleID = 1;

    AicpuModel aicpuModel;
    const int32_t ret = aicpuModel.ModelLoad(&modelInfoT);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID);
}

TEST_F(AICPUModelExecuteTEST, ModelLoadLoadQueueAndDestroyFail) {
    StreamInfo stream = {
        .streamID = 1U,
        .streamFlag = AICPU_STREAM_INDEX|HEAD_STREAM_INDEX,
    };

    std::string kernelName = "endGraph";
    AicpuTaskInfo task = {
        .taskID = 0U,
        .streamID = 1U,
        .kernelType = 0,
        .kernelName = PtrToValue(kernelName.data())
    };

    AicpuModelInfo modelInfoT = {
        .moduleID = 1U,
        .tsId = 1U,
        .streamInfoNum = 1,
        .aicpuTaskNum = 1,
        .streamInfoPtr = PtrToValue(&stream),
        .aicpuTaskPtr = PtrToValue(&task),
        .queueSize = 1,
        .queueInfoPtr = 0UL
    };

    MOCKER_CPP(&AicpuModel::ModelDestroy).stubs()
        .will(returnValue(static_cast<int32_t>(AICPU_SCHEDULE_ERROR_INNER_ERROR)));

    AicpuModel aicpuModel;
    int ret = aicpuModel.ModelLoad(&modelInfoT);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID);
}

TEST_F(AICPUModelExecuteTEST, ModelLoadAttachAndDestroyFail) {
    StreamInfo stream = {
        .streamID = 1U,
        .streamFlag = AICPU_STREAM_INDEX|HEAD_STREAM_INDEX,
    };

    AicpuTaskInfo task = {
        .taskID = 0U,
        .streamID = 1U,
        .kernelType = 0,
        .kernelName = 0UL
    };

    AicpuModelInfo modelInfoT = {
        .moduleID = 1U,
        .tsId = 1U,
        .streamInfoNum = 1,
        .aicpuTaskNum = 1,
        .streamInfoPtr = PtrToValue(&stream),
        .aicpuTaskPtr = PtrToValue(&task),
        .queueSize = 0,
        .queueInfoPtr = 0UL
    };

    MOCKER_CPP(&AicpuModel::ModelDestroy).stubs()
        .will(returnValue(static_cast<int32_t>(AICPU_SCHEDULE_ERROR_INNER_ERROR)));

    AicpuModel aicpuModel;
    int ret = aicpuModel.ModelLoad(&modelInfoT);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID);
}

TEST_F(AICPUModelExecuteTEST, ModelLoadLoadCfgAndDestroyFail) {
    StreamInfo stream = {
        .streamID = 1U,
        .streamFlag = AICPU_STREAM_INDEX|HEAD_STREAM_INDEX,
    };

    std::string kernelName = "endGraph";
    AicpuTaskInfo task = {
        .taskID = 0U,
        .streamID = 1U,
        .kernelType = 0,
        .kernelName = PtrToValue(kernelName.data())
    };

    AicpuModelInfo modelInfoT = {
        .moduleID = 961U,
        .tsId = 1U,
        .streamInfoNum = 1,
        .aicpuTaskNum = 1,
        .streamInfoPtr = PtrToValue(&stream),
        .aicpuTaskPtr = PtrToValue(&task),
        .queueSize = 0,
        .queueInfoPtr = 0UL
    };

    ModelCfgInfo cfgInfo = {};
    cfgInfo.modelType = UINT32_MAX;

    MOCKER_CPP(&AicpuModel::ModelDestroy).stubs()
        .will(returnValue(static_cast<int32_t>(AICPU_SCHEDULE_ERROR_INNER_ERROR)));

    AicpuModel aicpuModel;
    int ret = aicpuModel.ModelLoad(&modelInfoT, &cfgInfo);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID);
}

TEST_F(AICPUModelExecuteTEST, ActiveOtherAicpuStreamsSendEventFail) {
    AicpuModel aicpuModel;
    aicpuModel.otherAicpuStreams_.clear();
    aicpuModel.otherAicpuStreams_.push_back(1);

    MOCKER_CPP(&AicpuMsgSend::SendAICPUSubEvent).stubs()
        .will(returnValue(static_cast<int32_t>(AICPU_SCHEDULE_ERROR_INNER_ERROR)));
    aicpuModel.ActiveOtherAicpuStreams();
    EXPECT_EQ(aicpuModel.modelId_, INVALID_NUMBER);
}

TEST_F(AICPUModelExecuteTEST, ModelDestroyReleaseResourceFail) {
    AicpuModel aicpuModel;

    MOCKER_CPP(&AicpuModel::ReleaseModelResource).stubs()
        .will(returnValue(static_cast<int32_t>(AICPU_SCHEDULE_ERROR_INNER_ERROR)));
    const int32_t ret = aicpuModel.ModelDestroy();
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_INNER_ERROR);
}

TEST_F(AICPUModelExecuteTEST, ModelAbort_failed02) {
    AicpuModel *aicpuModel = new AicpuModel();

    MOCKER_CPP(&AicpuModel::CheckOperateAndUpdateStatus)
        .stubs()
        .will(returnValue(0));

    MOCKER_CPP(&AicpuModel::ReleaseModelResource)
        .stubs()
        .will(returnValue(-1));

    int ret = aicpuModel->ModelAbort();
    EXPECT_EQ(ret, -1);
    delete aicpuModel;
    aicpuModel = nullptr;
}

TEST_F(AICPUModelExecuteTEST, ModelDestroy_failed) {
    AicpuModel *aicpuModel = new AicpuModel();

    MOCKER_CPP(&AicpuModel::CheckOperateAndUpdateStatus)
        .stubs()
        .will(returnValue(-1));

    int ret = aicpuModel->ModelDestroy();
    EXPECT_EQ(ret, -1);
    delete aicpuModel;
    aicpuModel = nullptr;
}

TEST_F(AICPUModelExecuteTEST, Exit_fialed) {
    AicpuModel *aicpuModel = new AicpuModel();
    aicpuModel->isValid = true;
    MOCKER_CPP(&AicpuModel::ReleaseModelResource)
            .stubs()
            .will(returnValue(-1));
    auto ret = aicpuModel->Exit();
    EXPECT_EQ(ret, -1);
    delete aicpuModel;
    aicpuModel = nullptr;
}

TEST_F(AICPUModelExecuteTEST, ModelRepeat) {
    AicpuModel *aicpuModel = new AicpuModel();

    MOCKER_CPP(&AicpuModel::ModelExecute)
        .stubs()
        .will(returnValue(0));
    int ret = aicpuModel->ModelRepeat();
    EXPECT_EQ(ret, 0);
    delete aicpuModel;
    aicpuModel = nullptr;
}

TEST_F(AICPUModelExecuteTEST, ModelRepeatProf) {
    AicpuModel *aicpuModel = new AicpuModel();

    MOCKER_CPP(&AicpuModel::ModelExecute)
        .stubs()
        .will(returnValue(0));
    aicpuModel->SetExtModelId(0UL);
    int ret = aicpuModel->ModelRepeat();
    EXPECT_EQ(ret, 0);
    delete aicpuModel;
    aicpuModel = nullptr;
}

TEST_F(AICPUModelExecuteTEST, ResetModelForExecute_fialed) {
    AicpuModel *aicpuModel = new AicpuModel();
    MOCKER_CPP(&AicpuModel::ReleaseModelResource)
            .stubs()
            .will(returnValue(-1));
    auto ret = aicpuModel->ResetModelForExecute();
    EXPECT_EQ(ret, -1);
    delete aicpuModel;
    aicpuModel = nullptr;
}

TEST_F(AICPUModelExecuteTEST, ResetModelForExecute_fialed1) {
    AicpuModel *aicpuModel = new AicpuModel();
    aicpuModel->inputMsgQueueIds_.insert(9216U);
    auto ret = aicpuModel->ReleaseModelResource();
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID);
    delete aicpuModel;
    aicpuModel = nullptr;
}

TEST_F(AICPUModelExecuteTEST, ResetModelForExecute_fialed2) {
    AicpuModel *aicpuModel = new AicpuModel();
    aicpuModel->outputMsgQueueIds_.insert(9216U);
    auto ret = aicpuModel->ReleaseModelResource();
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID);
    delete aicpuModel;
    aicpuModel = nullptr;
}

TEST_F(AICPUModelExecuteTEST, ResetModelForExecute_fialed3) {
    AicpuModel *aicpuModel = new AicpuModel();
    aicpuModel->inputQueueIds_.insert(9216U);
    auto ret = aicpuModel->ReleaseModelResource();
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID);
    delete aicpuModel;
    aicpuModel = nullptr;
}

TEST_F(AICPUModelExecuteTEST, ResetModelForExecute_fialed4) {
    AicpuModel *aicpuModel = new AicpuModel();
    aicpuModel->outputQueueIds_.insert(9216U);
    auto ret = aicpuModel->ReleaseModelResource();
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID);
    delete aicpuModel;
    aicpuModel = nullptr;
}

TEST_F(AICPUModelExecuteTEST, ResetModelForExecute_Success) {
    AicpuModel *aicpuModel = new AicpuModel();
    ModelCfgInfo cfgInfo = {};
    uint16_t blockNums[] = {100U};
    uint64_t blockSizes[] = {1U};
    cfgInfo.inputNum = 1U;
    cfgInfo.inBuffPoolSizeAddr = PtrToValue(&blockNums[0U]);
    cfgInfo.inBuffSizeAddr = PtrToValue(&blockSizes[0U]);
    cfgInfo.outputNum = 1U;
    cfgInfo.outBuffPoolSizeAddr = PtrToValue(&blockNums[0U]);;
    cfgInfo.outBuffSizeAddr = PtrToValue(&blockSizes[0U]);

    MOCKER(halBuffCreatePool).stubs().will(returnValue(static_cast<int32_t>(DRV_ERROR_NONE)));
    auto ret = aicpuModel->InitBufPool(&cfgInfo);
    EXPECT_EQ(ret, 0);
    MOCKER(GetAicpuDeployContext).stubs().will(invoke(GetAicpuDeployContextOnHost));
    ret = aicpuModel->ReleaseModelResource();
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
    delete aicpuModel;
    aicpuModel = nullptr;
}

TEST_F(AICPUModelExecuteTEST, ModelDestroy_LockFailed) {
    AicpuModel *aicpuModel = new AicpuModel();
    std::unique_lock<std::mutex> lockForModel(aicpuModel->mutexForModel_, std::try_to_lock);
    int ret = aicpuModel->ModelDestroy();
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_IN_WORKING);
    delete aicpuModel;
    aicpuModel = nullptr;
}

TEST_F(AICPUModelExecuteTEST, ModelClearInputQueueFail) {
    AicpuModel aicpuModel;
    aicpuModel.modelStatus_ = AicpuModelStatus::MODEL_STATUS_STOPPED;

    MOCKER_CPP(&AicpuModel::ModelClearInputQueues).stubs()
        .will(returnValue(static_cast<int32_t>(AICPU_SCHEDULE_ERROR_INNER_ERROR)));
    int32_t ret = aicpuModel.ModelClearInput();
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_INNER_ERROR);
}

TEST_F(AICPUModelExecuteTEST, ModelClearInputQueueSecondFail) {
    AicpuModel aicpuModel;
    aicpuModel.modelStatus_ = AicpuModelStatus::MODEL_STATUS_STOPPED;

    MOCKER_CPP(&AicpuModel::ModelClearInputQueues).stubs()
        .will(returnValue(static_cast<int32_t>(AICPU_SCHEDULE_OK)))
        .then(returnValue(static_cast<int32_t>(AICPU_SCHEDULE_ERROR_INNER_ERROR)));
    int32_t ret = aicpuModel.ModelClearInput();
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_INNER_ERROR);
}

TEST_F(AICPUModelExecuteTEST, ModelClearInput_success2) {
    std::unordered_set<size_t> inputQueueIdsTmp;
    AicpuModel *aicpuModel = new AicpuModel();
    MOCKER(halMbufFree)
        .stubs()
        .will(returnValue(0));
    MOCKER(halQueueDeQueue)
        .stubs()
        .will(invoke(halQueueDeQueueSuccessFake));
    inputQueueIdsTmp.insert(10U);
    queueNum = 0;
    int ret = aicpuModel->ModelClearInputQueues(inputQueueIdsTmp, 0);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
    delete aicpuModel;
    aicpuModel = nullptr;
}

TEST_F(AICPUModelExecuteTEST, ModelClearInput_failed1) {
    std::unordered_set<size_t> inputQueueIdsTmp;
    AicpuModel *aicpuModel = new AicpuModel();
    MOCKER(halMbufFree)
        .stubs()
        .will(returnValue(0));
    MOCKER(halQueueDeQueue)
        .stubs()
        .will(returnValue(1));
    inputQueueIdsTmp.insert(10U);
    int ret = aicpuModel->ModelClearInputQueues(inputQueueIdsTmp, 0);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_FROM_DRV);
    delete aicpuModel;
    aicpuModel = nullptr;
}

TEST_F(AICPUModelExecuteTEST, ExecuteStreamCheckOperateFail) {
    AicpuModel aicpuModel;
    aicpuModel.modelId_ = 1U;
    AicpuStream stream;
    uint32_t streamId = 1U;
    AicpuTaskInfo taskInfo = {};
    const std::vector<const AicpuTaskInfo *> streamTasks = {&taskInfo};
    aicpuModel.aicpuStreams_[streamId].InitAicpuStream(streamId, streamTasks);

    const int32_t ret = aicpuModel.ExecuteStream(streamId, false);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_MODEL_STATUS_NOT_ALLOW_OPERATE);
}

TEST_F(AICPUModelExecuteTEST, ProcessModelExceptionGetRunModeFail) {
    AicpuModel aicpuModel;

    MOCKER(aicpu::GetAicpuRunMode).stubs().will(returnValue(1));
    aicpuModel.ProcessModelException(1);
    EXPECT_EQ(aicpuModel.abnormalBreak_.load(), false);
}

TEST_F(AICPUModelExecuteTEST, ExecuteNextTask_KernelTypeErr)
{
    AicpuTaskInfo kernelTaskInfo = {};
    kernelTaskInfo.kernelType = 0xff;
    RunContext taskContext = {};
    const int32_t ret = AicpuStream::ExecuteTask(kernelTaskInfo, taskContext);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID);
}

TEST_F(AICPUModelExecuteTEST, ExecuteNextTask_CallSoFail)
{
    AicpuTaskInfo kernelTaskInfo = {};
    kernelTaskInfo.kernelType = static_cast<uint32_t>(AicpuKernelType::FWK_KERNEL);
    RunContext taskContext = {};

    MOCKER(aeCallInterface).stubs().will(returnValue(static_cast<int32_t>(AE_STATUS_TASK_ABORT)));
    const int32_t ret = AicpuStream::ExecuteTask(kernelTaskInfo, taskContext);
    EXPECT_EQ(ret, AE_STATUS_TASK_ABORT);
}

TEST_F(AICPUModelExecuteTEST, ExecuteNextTask_DumpFail)
{
    AicpuTaskInfo kernelTaskInfo = {};
    kernelTaskInfo.kernelType = static_cast<uint32_t>(AicpuKernelType::FWK_KERNEL);
    kernelTaskInfo.taskFlag = 0x01U;
    RunContext taskContext = {};

    MOCKER(aeCallInterface).stubs().will(returnValue(0));
    MOCKER_CPP(&OpDumpTaskManager::DumpOpInfo, int32_t(OpDumpTaskManager::*)(TaskInfoExt&, const DumpFileName&))
        .stubs().will(returnValue(AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID));
    const int32_t ret = AicpuStream::ExecuteTask(kernelTaskInfo, taskContext);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
}

TEST_F(AICPUModelExecuteTEST, ConvertToTsKernel_CceKernel)
{
    AicpuTaskInfo kernelTaskInfo = {};
    kernelTaskInfo.kernelType = static_cast<uint32_t>(AicpuKernelType::CCE_KERNEL);
    aicpu::HwtsTsKernel info = {};

    const int32_t ret = AicpuStream::ConvertToTsKernel(kernelTaskInfo, info);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
}

TEST_F(AICPUModelExecuteTEST, ProcessModelExceptionSendEventFail) {
    AicpuModel aicpuModel;

    MOCKER(&AicpuMsgSend::SendAICPUSubEvent).stubs()
        .will(returnValue(AICPU_SCHEDULE_ERROR_INNER_ERROR));
    aicpuModel.ProcessModelException(1);
    EXPECT_EQ(aicpuModel.abnormalBreak_.load(), false);
}

TEST_F(AICPUModelExecuteTEST, LoadStreamAndTaskS0StreamRepeat) {
    const uint32_t streamNum = 2U;
    StreamInfo stream[streamNum] = {
        {.streamID = 1U, .streamFlag = AICPU_STREAM_INDEX|HEAD_STREAM_INDEX},
        {.streamID = 2U, .streamFlag = AICPU_STREAM_INDEX|HEAD_STREAM_INDEX}
    };

    std::string kernelName = "endGraph";
    AicpuTaskInfo task = {
        .taskID = 0U,
        .streamID = 1U,
        .kernelType = 0,
        .kernelName = PtrToValue(kernelName.data())
    };

    AicpuModelInfo modelInfo = {
        .moduleID = 962U,
        .tsId = 1U,
        .streamInfoNum = streamNum,
        .aicpuTaskNum = 1,
        .streamInfoPtr = PtrToValue(&stream),
        .aicpuTaskPtr = PtrToValue(&task),
        .queueSize = 0,
        .queueInfoPtr = 0UL
    };

    AicpuModel aicpuModel;
    const int32_t ret = aicpuModel.LoadStreamAndTask(&modelInfo);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID);
}

TEST_F(AICPUModelExecuteTEST, LoadStreamAndTaskNumNull) {
    const uint32_t streamNum = 1U;
    StreamInfo stream[streamNum] = {
        {.streamID = 1U, .streamFlag = AICPU_STREAM_INDEX|HEAD_STREAM_INDEX},
    };

    std::string kernelName = "endGraph";
    AicpuTaskInfo task = {
        .taskID = 0U,
        .streamID = 1U,
        .kernelType = 0,
        .kernelName = PtrToValue(kernelName.data())
    };

    AicpuModelInfo modelInfo = {
        .moduleID = 962U,
        .tsId = 1U,
        .streamInfoNum = streamNum,
        .aicpuTaskNum = 0,
        .streamInfoPtr = PtrToValue(&stream),
        .aicpuTaskPtr = PtrToValue(&task),
        .queueSize = 0,
        .queueInfoPtr = 0UL
    };

    AicpuModel aicpuModel;
    const int32_t ret = aicpuModel.LoadStreamAndTask(&modelInfo);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID);
}

TEST_F(AICPUModelExecuteTEST, LoadStreamAndTaskPtrNull) {
    const uint32_t streamNum = 1U;
    StreamInfo stream[streamNum] = {
        {.streamID = 1U, .streamFlag = AICPU_STREAM_INDEX|HEAD_STREAM_INDEX},
    };

    std::string kernelName = "endGraph";
    AicpuTaskInfo task = {
        .taskID = 0U,
        .streamID = 1U,
        .kernelType = 0,
        .kernelName = PtrToValue(kernelName.data())
    };

    AicpuModelInfo modelInfo = {
        .moduleID = 962U,
        .tsId = 1U,
        .streamInfoNum = streamNum,
        .aicpuTaskNum = 1,
        .streamInfoPtr = PtrToValue(&stream),
        .aicpuTaskPtr = 0,
        .queueSize = 0,
        .queueInfoPtr = 0UL
    };

    AicpuModel aicpuModel;
    const int32_t ret = aicpuModel.LoadStreamAndTask(&modelInfo);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID);
}

TEST_F(AICPUModelExecuteTEST, LoadStreamAndTask_failed2) {
    AicpuModel *aicpuModel = new AicpuModel();

    AicpuModelInfo modelInfoT;
    modelInfoT.streamInfoNum = 1;
    uint32_t *streamInfoPtr = nullptr;
    modelInfoT.streamInfoPtr = (uintptr_t)streamInfoPtr;
    int ret = aicpuModel->LoadStreamAndTask(&modelInfoT);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID);
    delete aicpuModel;
    aicpuModel = nullptr;
}

TEST_F(AICPUModelExecuteTEST, LoadQueueInfoSubscribeEventFail) {
    const uint32_t streamNum = 1U;
    StreamInfo stream[streamNum] = {
        {.streamID = 1U, .streamFlag = AICPU_STREAM_INDEX|HEAD_STREAM_INDEX},
    };

    std::string kernelName = "endGraph";
    AicpuTaskInfo task = {
        .taskID = 0U,
        .streamID = 1U,
        .kernelType = 0,
        .kernelName = PtrToValue(kernelName.data())
    };

    QueInfo qInfo = {
        .queueID = 1,
        .flag = static_cast<uint32_t>(QueueDirectionFlag::QUEUE_INPUT_FLAG)
    };

    AicpuModelInfo modelInfo = {
        .moduleID = 962U,
        .tsId = 1U,
        .streamInfoNum = streamNum,
        .aicpuTaskNum = 1,
        .streamInfoPtr = PtrToValue(&stream),
        .aicpuTaskPtr = PtrToValue(&task),
        .queueSize = 1,
        .queueInfoPtr = PtrToValue(&qInfo)
    };

    MOCKER(halQueueAttach).stubs().will(returnValue(static_cast<int32_t>(DRV_ERROR_NONE)));
    MOCKER_CPP(&AicpuDrvManager::SubscribeQueueNotEmptyEvent).stubs()
        .will(returnValue(static_cast<int32_t>(AICPU_SCHEDULE_ERROR_FROM_DRV)));

    AicpuModel aicpuModel;
    const int32_t ret = aicpuModel.LoadQueueInfo(&modelInfo);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_FROM_DRV);
}

TEST_F(AICPUModelExecuteTEST, LoadQueueInfo_failed2) {
    AicpuModel *aicpuModel = new AicpuModel();

    AicpuModelInfo modelInfoT;
    QueInfo modelQueueInfo = {0};
    modelQueueInfo.queueID = 1;
    modelQueueInfo.flag = 5;
    modelInfoT.queueSize = 1;
    modelInfoT.queueInfoPtr = (uintptr_t)&modelQueueInfo;
    int ret = aicpuModel->LoadQueueInfo(&modelInfoT);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID);
    delete aicpuModel;
    aicpuModel = nullptr;
}

TEST_F(AICPUModelExecuteTEST, LoadQueueInfo_FailForSetQueue) {
    AicpuModel *aicpuModel = new AicpuModel();
    MOCKER(halQueueSet)
        .stubs()
        .will(returnValue(DRV_ERROR_QUEUE_INNER_ERROR));
    AicpuModelInfo modelInfoT;
    QueInfo modelQueueInfo = {};
    modelQueueInfo.queueID = 1;
    modelQueueInfo.flag = 0;
    modelInfoT.queueSize = 1;
    modelInfoT.queueInfoPtr = (uintptr_t)&modelQueueInfo;
    int ret = aicpuModel->LoadQueueInfo(&modelInfoT);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_FROM_DRV);
    delete aicpuModel;
    aicpuModel = nullptr;
}

TEST_F(AICPUModelExecuteTEST, LoadWaitNotifyId_success1) {
    AicpuModel *aicpuModel = new AicpuModel();

    AicpuTaskInfo aicpuTaskInfoT;
    aicpuTaskInfoT.kernelSo = 0;
    aicpuTaskInfoT.kernelType = KERNEL_TYPE_FWK;

    std::unordered_set<size_t> waitNotifyIdSetT;
    aicpuModel->LoadWaitNotifyId(aicpuTaskInfoT, waitNotifyIdSetT);
    EXPECT_EQ(aicpuModel->modelId_, INVALID_NUMBER);
    delete aicpuModel;
    aicpuModel = nullptr;
}

TEST_F(AICPUModelExecuteTEST, LoadWaitNotifyId_success2) {
    AicpuModel *aicpuModel = new AicpuModel();

    AicpuTaskInfo aicpuTaskInfoT;
    aicpuTaskInfoT.kernelSo = 0;
    aicpuTaskInfoT.kernelType = KERNEL_TYPE_CCE;
    const char *name = "waitNotify";
    aicpuTaskInfoT.kernelName = (uintptr_t)name;

    uint32_t paraBase = 1;
    aicpuTaskInfoT.paraBase = (uintptr_t)&paraBase;

    std::unordered_set<size_t> waitNotifyIdSetT;
    aicpuModel->LoadWaitNotifyId(aicpuTaskInfoT, waitNotifyIdSetT);
    EXPECT_EQ(aicpuModel->modelId_, INVALID_NUMBER);
    delete aicpuModel;
    aicpuModel = nullptr;
}

TEST_F(AICPUModelExecuteTEST, LoadWaitNotifyId_success3) {
    AicpuModel *aicpuModel = new AicpuModel();

    AicpuTaskInfo aicpuTaskInfoT;
    aicpuTaskInfoT.kernelSo = 0;
    aicpuTaskInfoT.kernelType = KERNEL_TYPE_CCE;
    const char *name = "waitNotify";
    aicpuTaskInfoT.kernelName = (uintptr_t)name;

    uint32_t *paraBase = nullptr;
    aicpuTaskInfoT.paraBase = (uintptr_t)paraBase;

    std::unordered_set<size_t> waitNotifyIdSetT;
    aicpuModel->LoadWaitNotifyId(aicpuTaskInfoT, waitNotifyIdSetT);
    EXPECT_EQ(aicpuModel->modelId_, INVALID_NUMBER);
    delete aicpuModel;
    aicpuModel = nullptr;
}

TEST_F(AICPUModelExecuteTEST, InitBufPoolInitFail) {
    ModelCfgInfo cfgInfo = {};
    cfgInfo.inputNum = 1U;
    uint16_t blockNums[] = {100U};
    cfgInfo.inBuffPoolSizeAddr = PtrToValue(&blockNums[0U]);
    uint64_t blockSizes[] = {1U};
    cfgInfo.inBuffSizeAddr = PtrToValue(&blockSizes[0U]);

    MOCKER(halBuffCreatePool).stubs().will(returnValue(static_cast<int32_t>(DRV_ERROR_INVALID_VALUE)));
    AicpuModel aicpuModel;
    const int32_t ret = aicpuModel.InitBufPool(&cfgInfo);
    EXPECT_EQ(ret, DRV_ERROR_INVALID_VALUE);
}

TEST_F(AICPUModelExecuteTEST, InitBufPoolInitFailPartly) {
    ModelCfgInfo cfgInfo = {};
    uint16_t blockNums[] = {100U};
    uint64_t blockSizes[] = {1U};
    cfgInfo.inputNum = 1U;
    cfgInfo.inBuffPoolSizeAddr = PtrToValue(&blockNums[0U]);
    cfgInfo.inBuffSizeAddr = PtrToValue(&blockSizes[0U]);
    cfgInfo.outputNum = 1U;
    cfgInfo.outBuffPoolSizeAddr = PtrToValue(&blockNums[0U]);;
    cfgInfo.outBuffSizeAddr = PtrToValue(&blockSizes[0U]);

    MOCKER(halBuffCreatePool)
        .stubs()
        .will(returnValue(static_cast<int32_t>(DRV_ERROR_NONE)))
        .then(returnValue(static_cast<int32_t>(DRV_ERROR_INVALID_VALUE)));
    AicpuModel aicpuModel;
    const int32_t ret = aicpuModel.InitBufPool(&cfgInfo);
    EXPECT_EQ(ret, DRV_ERROR_INVALID_VALUE);
}

TEST_F(AICPUModelExecuteTEST, InitBufPoolInitSuccess) {
    ModelCfgInfo cfgInfo = {};
    uint16_t blockNums[] = {100U};
    uint64_t blockSizes[] = {1U};
    cfgInfo.inputNum = 1U;
    cfgInfo.inBuffPoolSizeAddr = PtrToValue(&blockNums[0U]);
    cfgInfo.inBuffSizeAddr = PtrToValue(&blockSizes[0U]);
    cfgInfo.outputNum = 1U;
    cfgInfo.outBuffPoolSizeAddr = PtrToValue(&blockNums[0U]);
    cfgInfo.outBuffSizeAddr = PtrToValue(&blockSizes[0U]);

    MOCKER(halBuffCreatePool).stubs().will(returnValue(static_cast<int32_t>(DRV_ERROR_NONE)));
    AicpuModel aicpuModel;
    const int32_t ret = aicpuModel.InitBufPool(&cfgInfo);
    EXPECT_EQ(ret, 0);
}

TEST_F(AICPUModelExecuteTEST, InitBufPoolInitFailed) {
    ModelCfgInfo cfgInfo = {};
    cfgInfo.inputNum = 1U;
    cfgInfo.inBuffPoolSizeAddr = 0;
    cfgInfo.outputNum = 1U;
    cfgInfo.outBuffPoolSizeAddr = 0;
    AicpuModel aicpuModel;
    const int32_t ret = aicpuModel.InitBufPool(&cfgInfo);
    EXPECT_EQ(ret, RET_FAILED);
}

TEST_F(AICPUModelExecuteTEST, LoadCfgPrepareHcclLinkFail) {
    ModelCfgInfo cfgInfo = {};
    cfgInfo.modelType = static_cast<uint32_t>(kModelWithSyncEvent);

    MOCKER_CPP(&AicpuModel::InitModelGroups).stubs().will(returnValue(AICPU_SCHEDULE_OK));
    MOCKER_CPP(&AicpuModel::PrepareHcclLink).stubs().will(returnValue(AICPU_SCHEDULE_ERROR_INNER_ERROR));

    AicpuModel aicpuModel;
    const StatusCode ret = aicpuModel.LoadCfg(&cfgInfo);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_INNER_ERROR);
}

TEST_F(AICPUModelExecuteTEST, PrepareHcclLinkCommOpsNullptr) {
    ModelCfgInfo cfgInfo = {};
    cfgInfo.modelCommOpListAddr = 0UL;

    AicpuModel aicpuModel;
    const StatusCode ret = aicpuModel.PrepareHcclLink(&cfgInfo);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID);
}

TEST_F(AICPUModelExecuteTEST, PrepareHcclLinkOpNumNull) {
    ModelCommOpList opList = {};
    opList.opNum = 0;

    ModelCfgInfo cfgInfo = {};
    cfgInfo.modelCommOpListAddr = PtrToValue(&opList);

    AicpuModel aicpuModel;
    const StatusCode ret = aicpuModel.PrepareHcclLink(&cfgInfo);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID);
}

TEST_F(AICPUModelExecuteTEST, PrepareHcclLinkHcomStartFail) {
    HcomOpDesc opDesc = {};

    ModelCommOpList opList = {};
    opList.opNum = 1;
    opList.commOpDescsListAddr = PtrToValue(&opDesc);

    ModelCfgInfo cfgInfo = {};
    cfgInfo.modelCommOpListAddr = PtrToValue(&opList);
   

    AicpuModel aicpuModel;
    const StatusCode ret = aicpuModel.PrepareHcclLink(&cfgInfo);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_CALL_HCCL);
}

TEST_F(AICPUModelExecuteTEST, PrepareHcclLinkPrepareQueryFail) {
    HcomOpDesc opDesc = {};

    ModelCommOpList opList = {};
    opList.opNum = 1;
    opList.commOpDescsListAddr = PtrToValue(&opDesc);

    ModelCfgInfo cfgInfo = {};
    cfgInfo.modelCommOpListAddr = PtrToValue(&opList);

   MOCKER(StubHcomPrepareStart).stubs().will(returnValue(0));

   MOCKER(StubHcomPrepareQuery)
        .stubs()
        .will(invoke(hcomPrepareQueryStub2));
    AicpuModel aicpuModel;
    const StatusCode ret = aicpuModel.PrepareHcclLink(&cfgInfo);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_CALL_HCCL);
}

TEST_F(AICPUModelExecuteTEST, ClearLoadInfoOutputQueue) {
    AicpuModel aicpuModel;
    aicpuModel.queueEventSubscribedInfo_.clear();
    QueInfo qInfo = {.queueID = 1, .flag = static_cast<uint32_t>(QueueDirectionFlag::QUEUE_OUTPUT_FLAG)};
    aicpuModel.queueEventSubscribedInfo_.push_back(qInfo);

    aicpuModel.ClearLoadInfo();
    EXPECT_EQ(aicpuModel.isDestroyModel_, true);
}

TEST_F(AICPUModelExecuteTEST, ClearLoadInfoUnknownQueue) {
    AicpuModel aicpuModel;
    aicpuModel.queueEventSubscribedInfo_.clear();
    QueInfo qInfo = {.queueID = 1, .flag = UINT32_MAX};
    aicpuModel.queueEventSubscribedInfo_.push_back(qInfo);

    aicpuModel.ClearLoadInfo();
    EXPECT_EQ(aicpuModel.isDestroyModel_, true);
}

TEST_F(AICPUModelExecuteTEST, ClearLoadInfoInputBuf) {
    AicpuModel aicpuModel;
    aicpuModel.inputBufPools_.clear();
    aicpuModel.outputBufPools_.clear();
    MBufferPool poolTest = {};
    aicpuModel.inputBufPools_[0].Init(1, 1, &poolTest);
    aicpuModel.outputBufPools_[0].Init(1, 1, &poolTest);

    aicpuModel.ClearLoadInfo();
    EXPECT_EQ(aicpuModel.isDestroyModel_, true);
}

TEST_F(AICPUModelExecuteTEST, ClearLoadInfoQueueId) {
    AicpuModel aicpuModel;
    aicpuModel.inputMsgQueueIds_.clear();
    aicpuModel.outputMsgQueueIds_.clear();
    aicpuModel.inputMsgQueueIds_.insert(static_cast<size_t>(0));
    aicpuModel.outputMsgQueueIds_.insert(static_cast<size_t>(1));

    aicpuModel.ClearLoadInfo();
    EXPECT_EQ(aicpuModel.isDestroyModel_, true);
}

TEST_F(AICPUModelExecuteTEST, ClearLoadInfoQueueId_Success) {
    AicpuModel aicpuModel;
    ModelCfgInfo cfgInfo = {};
    uint16_t blockNums[] = {100U};
    uint64_t blockSizes[] = {1U};
    cfgInfo.inputNum = 1U;
    cfgInfo.inBuffPoolSizeAddr = PtrToValue(&blockNums[0U]);
    cfgInfo.inBuffSizeAddr = PtrToValue(&blockSizes[0U]);
    cfgInfo.outputNum = 1U;
    cfgInfo.outBuffPoolSizeAddr = PtrToValue(&blockNums[0U]);;
    cfgInfo.outBuffSizeAddr = PtrToValue(&blockSizes[0U]);
 
    MOCKER(halBuffCreatePool).stubs().will(returnValue(static_cast<int32_t>(DRV_ERROR_NONE)));
    auto ret = aicpuModel.InitBufPool(&cfgInfo);
    EXPECT_EQ(ret, 0);
    MOCKER(GetAicpuDeployContext).stubs().will(invoke(GetAicpuDeployContextOnHost));
    aicpuModel.ClearLoadInfo();
    EXPECT_EQ(aicpuModel.isDestroyModel_, true);
}

TEST_F(AICPUModelExecuteTEST, InitModelGroupsNullptr) {
    ModelCfgInfo cfgInfo = {};
    cfgInfo.commGroupsAddr = 0UL;

    AicpuModel aicpuModel;
    const StatusCode ret = aicpuModel.InitModelGroups(&cfgInfo);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
}

TEST_F(AICPUModelExecuteTEST, InitModelGroupsHcclFailed) {
    std::vector<CommGroup> groupVec = {CommGroup(), CommGroup()};
    CommGroups groupList = {};
    groupList.groupNum = 2U;
    groupList.groups = groupVec.data();

    ModelCfgInfo cfg = {};
    cfg.commGroupsAddr = &groupList;
    MOCKER(StubHcomCreateGroup).stubs().will(returnValue(1));
    AicpuModel aicpuModel;
    const StatusCode ret = aicpuModel.InitModelGroups(&cfg);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_CALL_HCCL);
}

TEST_F(AICPUModelExecuteTEST, InitModelGroupsOK) {
    CommGroup testA = {"test", 0, nullptr};
    std::vector<CommGroup> groupVec = {testA, CommGroup()};
    CommGroups groupList = {};
    groupList.groupNum = 2U;
    groupList.groups = groupVec.data();

    ModelCfgInfo cfg = {};
    cfg.commGroupsAddr = &groupList;
    MOCKER(StubHcomCreateGroup).stubs().will(returnValue(0));
    AicpuModel aicpuModel;
    const StatusCode ret = aicpuModel.InitModelGroups(&cfg);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
}

TEST_F(AICPUModelExecuteTEST, DestoryModelGroupsSuccess) {
    AicpuModel aicpuModel;
    aicpuModel.groupList_.push_back("test_queue");

    MOCKER(StubHcomDestroyGroup).stubs().will(returnValue(HCCL_SUCCESS));

    aicpuModel.DestroyModelGroups();
    EXPECT_EQ(aicpuModel.groupList_.size(), 0);
}

TEST_F(AICPUModelExecuteTEST, DestoryModelGroupsFail) {
    AicpuModel aicpuModel;
    aicpuModel.groupList_.push_back("test_queue");

    MOCKER(StubHcomDestroyGroup).stubs().will(returnValue(HCCL_E_NETWORK));

    aicpuModel.DestroyModelGroups();
    EXPECT_EQ(aicpuModel.groupList_.size(), 0);
}

TEST_F(AICPUModelExecuteTEST, ClearAllLockedTableSuccess) {
    AicpuModel aicpuModel;
    aicpuModel.tableLocked_.emplace(100, 101);
    aicpuModel.ClearAllLockedTable();
    EXPECT_EQ(aicpuModel.tableLocked_.size(), 0);
}

TEST_F(AICPUModelExecuteTEST, ClearAllLockedTableFail) {
    AicpuModel aicpuModel;
    aicpuModel.tableTryLock_ = 101;
    aicpuModel.tableLocked_.emplace(100, 101);
    aicpuModel.ClearAllLockedTable();
    EXPECT_EQ(aicpuModel.tableLocked_.size(), 0);
    EXPECT_EQ(aicpuModel.tableTryLock_, INVALID_TABLE_ID);
}

TEST_F(AICPUModelExecuteTEST, GetModelsByTableIdSuccess) {
    AicpuModelManager modelMgr;
    modelMgr.allModel_[0].isValid = true;
    const int64_t tableId = 101;
    modelMgr.allModel_[0].tableTryLock_ = tableId;
    auto ret = modelMgr.GetModelsByTableId(tableId);
    EXPECT_EQ(ret.size(), 1);
}

TEST_F(AICPUModelExecuteTEST, AddAsyncTask_success)
{
    AicpuModel aicpuModel;
    aicpuModel.isValid = true;
    AsyncTaskInfo task = {};
    MOCKER(SingleHcclWait).stubs().will(returnValue(0));
    EXPECT_EQ(aicpuModel.AddAsyncTask(task), AICPU_SCHEDULE_OK);
    EXPECT_EQ(aicpuModel.asyncTaskThreads_.size() ,1);
    usleep(10000);
    aicpuModel.StopAsyncThread();
    EXPECT_EQ(aicpuModel.asyncTaskThreads_.size() ,0);
}

TEST_F(AICPUModelExecuteTEST, DoReleaseMem_fail_SingleHcclWait)
{
    AicpuModel aicpuModel;
    aicpuModel.isValid = true;
    MOCKER(SingleHcclWait).stubs().will(returnValue(1));
    AsyncTaskInfo task = {};
    aicpuModel.DoReleaseMem(task);
    EXPECT_EQ(aicpuModel.asyncTaskRunning_, false);
}

TEST_F(AICPUModelExecuteTEST, DoReleaseMem_fail_SendMsg)
{
    AicpuModel aicpuModel;
    aicpuModel.isValid = true;
    MOCKER(SingleHcclWait).stubs().will(returnValue(0));
    MOCKER_CPP(&AicpuMsgSend::SendAICPUSubEvent).stubs().will(returnValue(1));
    AsyncTaskInfo task = {};
    aicpuModel.DoReleaseMem(task);
    EXPECT_EQ(aicpuModel.asyncTaskRunning_, false);
}

TEST_F(AICPUModelExecuteTEST, ProcessDataException_fail_SendMsg)
{
    AicpuModel aicpuModel;
    MOCKER_CPP(&AicpuMsgSend::SendAICPUSubEvent).stubs().will(returnValue(1));
    AsyncTaskInfo task = {};
    int ret = aicpuModel.ProcessDataException(0, 0);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
}

TEST_F(AICPUModelExecuteTEST, GetCurDequeIndex) {
    const uint32_t streamNum = 2U;
    StreamInfo stream[streamNum] = {
        {.streamID = 1U, .streamFlag = AICPU_STREAM_INDEX|HEAD_STREAM_INDEX},
        {.streamID = 2U, .streamFlag = AICPU_STREAM_INDEX|HEAD_STREAM_INDEX}
    };

    std::string kernelName = "endGraph";
    AicpuTaskInfo task = {
        .taskID = 0U,
        .streamID = 1U,
        .kernelType = 0,
        .kernelName = PtrToValue(kernelName.data())
    };

    AicpuModelInfo modelInfo = {
        .moduleID = 962U,
        .tsId = 1U,
        .streamInfoNum = streamNum,
        .aicpuTaskNum = 1,
        .streamInfoPtr = PtrToValue(&stream),
        .aicpuTaskPtr = PtrToValue(&task),
        .queueSize = 0,
        .queueInfoPtr = 0UL
    };

    AicpuModel aicpuModel;
    size_t qCnt = 6UL;
    int32_t qIndex = aicpuModel.GetCurDequeIndex(qCnt);
    EXPECT_EQ(qIndex, 0UL);
    aicpuModel.gatheredMbufCntList_[0] = 2UL;
    aicpuModel.gatheredMbufCntList_[1] = 2UL;
    aicpuModel.gatheredMbufCntList_[3] = 2UL;
    qIndex = aicpuModel.GetCurDequeIndex(qCnt);
    EXPECT_EQ(qIndex, 2UL);
    aicpuModel.gatheredMbufCntList_[0] = 2UL;
    aicpuModel.gatheredMbufCntList_[1] = 2UL;
    aicpuModel.gatheredMbufCntList_[3] = 2UL;
    aicpuModel.gatheredMbufCntList_[2] = 3UL;
    aicpuModel.gatheredMbufCntList_[4] = 1UL;
    aicpuModel.gatheredMbufCntList_[5] = 1UL;
    qIndex = aicpuModel.GetCurDequeIndex(qCnt);
    EXPECT_EQ(qIndex, 4UL);
    aicpuModel.gatheredMbufCntList_[0] = 2UL;
    aicpuModel.gatheredMbufCntList_[1] = 2UL;
    aicpuModel.gatheredMbufCntList_[3] = 2UL;
    aicpuModel.gatheredMbufCntList_[2] = 3UL;
    aicpuModel.gatheredMbufCntList_[4] = 1UL;
    aicpuModel.gatheredMbufCntList_[5] = 0UL;
    qIndex = aicpuModel.GetCurDequeIndex(qCnt);
    EXPECT_EQ(qIndex, 5UL);
}

TEST_F(AICPUModelExecuteTEST, GetCurDequeIndex_SmallIndex) {
    const uint32_t streamNum = 2U;
    StreamInfo stream[streamNum] = {
        {.streamID = 1U, .streamFlag = AICPU_STREAM_INDEX|HEAD_STREAM_INDEX},
        {.streamID = 2U, .streamFlag = AICPU_STREAM_INDEX|HEAD_STREAM_INDEX}
    };

    std::string kernelName = "endGraph";
    AicpuTaskInfo task = {
        .taskID = 0U,
        .streamID = 1U,
        .kernelType = 0,
        .kernelName = PtrToValue(kernelName.data())
    };

    AicpuModelInfo modelInfo = {
        .moduleID = 962U,
        .tsId = 1U,
        .streamInfoNum = streamNum,
        .aicpuTaskNum = 1,
        .streamInfoPtr = PtrToValue(&stream),
        .aicpuTaskPtr = PtrToValue(&task),
        .queueSize = 0,
        .queueInfoPtr = 0UL
    };

    AicpuModel aicpuModel;
    size_t qCnt = 2UL;
    int32_t qIndex = aicpuModel.GetCurDequeIndex(qCnt);
    EXPECT_EQ(qIndex, 0UL);
    aicpuModel.gatheredMbufCntList_[1] = 0UL;
    qIndex = aicpuModel.GetCurDequeIndex(qCnt);
    EXPECT_EQ(qIndex, 0UL);
    aicpuModel.gatheredMbufCntList_[1] = 2UL;
    qIndex = aicpuModel.GetCurDequeIndex(qCnt);
    EXPECT_EQ(qIndex, 0UL);
}

TEST_F(AICPUModelExecuteTEST, QueueMbufStore_test_Init) {
    QueueMbufStore temStore;
    EXPECT_EQ(temStore.IsReady(), false);
    EXPECT_EQ(temStore.IsEmpty(), true);
    temStore.queuesLists_.resize(1);
    EXPECT_EQ(temStore.Init(1), true);
}

TEST_F(AICPUModelExecuteTEST, QueueMbufStore_test_Func) {
    QueueMbufStore temStore;
    EXPECT_EQ(temStore.Init(5UL), true);
    uint64_t tmpData;
    Mbuf *tempPtr = reinterpret_cast<Mbuf *>(&tmpData);
    std::map<size_t, uint64_t> gCntList;
    EXPECT_EQ(temStore.IsReady(), false);
    EXPECT_EQ(temStore.IsEmpty(), true);
    EXPECT_EQ(temStore.Store(5UL, tempPtr, gCntList), false);
    EXPECT_EQ(gCntList.empty(), true);
    EXPECT_EQ(temStore.Store(4UL, tempPtr, gCntList), true);
    EXPECT_EQ(gCntList.empty(), false);
    EXPECT_EQ(gCntList[4UL], 1UL);
    EXPECT_EQ(temStore.IsReady(), false);
    EXPECT_EQ(temStore.IsEmpty(), false);
}

TEST_F(AICPUModelExecuteTEST, QueueMbufStoreFailed1) {
    QueueMbufStore temStore;
    std::map<size_t, uint64_t> gCntList;
    EXPECT_EQ(temStore.Store(0UL, nullptr, gCntList), false);
    EXPECT_EQ(temStore.Consume(nullptr, gCntList), false);
}

TEST_F(AICPUModelExecuteTEST, ClearExceptionStore)
{
    AicpuModel aicpuModel;

    EXPECT_EQ(aicpuModel.StoreDequedMbuf(0U, 0U, 0U, nullptr, 1U), StoreResult::SUCCESS_STORE);

    aicpuModel.exceptionTranses_[0] = false;
    aicpuModel.ClearExceptionStore();
    EXPECT_EQ(aicpuModel.gatheredMbuf_.size(), 0);
    EXPECT_TRUE(aicpuModel.exceptionTranses_[0]);

    EXPECT_EQ(aicpuModel.StoreDequedMbuf(0U, 1U, 0U, nullptr, 1U), StoreResult::ABORT_STORE);
    EXPECT_EQ(aicpuModel.gatheredMbuf_.size(), 0);
}

TEST_F(AICPUModelExecuteTEST, ClearExceptionStore2)
{
    AicpuModel aicpuModel;
    aicpuModel.exceptionTranses_[0] = false;
    aicpuModel.ClearExceptionStore();
    EXPECT_EQ(aicpuModel.gatheredMbuf_.size(), 0);
    EXPECT_TRUE(aicpuModel.exceptionTranses_[0]);
}

TEST_F(AICPUModelExecuteTEST, StoreDequedMbufFailed)
{
    MOCKER_CPP(&AicpuModel::IsTransIdException)
        .stubs()
        .will(returnValue(false));
    MOCKER_CPP(&QueueMbufStore::Store)
        .stubs()
        .will(returnValue(false));
    AicpuModel aicpuModel;
    EXPECT_EQ(aicpuModel.StoreDequedMbuf(0U, 0U, 0U, nullptr, 1U), StoreResult::FAIL_STORE);
}

TEST_F(AICPUModelExecuteTEST, InitHcclForSyncEvent_SUCCESS)
{
    MOCKER(dlopen).stubs().will(returnValue((void*)1));
    MOCKER(dlsym).stubs().will(invoke(dlsymFake));
    MOCKER(dlclose).stubs().will(returnValue(0));
    ModelCfgInfo cfg = {};
    const char* hcomName = "hcom";
    cfg.hcclCommNameAddr = PtrToValue(hcomName);
    cfg.hcclTimeOut = -1;
    cfg.modelType = 1U;

    AicpuModelManager manager;
    HcclInitType initType = HcclInitType::INIT_TYPE_NUM;
    // first init
    EXPECT_EQ(manager.InitHccl(&cfg, initType), AICPU_SCHEDULE_OK);
    // other init
    EXPECT_EQ(manager.InitHccl(&cfg, initType), AICPU_SCHEDULE_OK);

    HcclSoManager::GetInstance()->UnloadSo();
}

TEST_F(AICPUModelExecuteTEST, InitHcclForSyncEvent_FAIL)
{
    MOCKER(dlopen).stubs().will(returnValue((void*)1));
    MOCKER(dlsym).stubs().will(invoke(dlsymFakeNull));
    MOCKER(dlclose).stubs().will(returnValue(0));
    ModelCfgInfo cfg = {};
    const char* hcomName = "hcom";
    cfg.hcclCommNameAddr = PtrToValue(hcomName);
    cfg.modelType = 1U;

    AicpuModelManager manager;
    HcclInitType initType = HcclInitType::INIT_TYPE_NUM;
    MOCKER(strncpy_s)
        .stubs()
        .will(returnValue(1))
        .then(returnValue(0));
    // fail for strncpy_s
    EXPECT_EQ(manager.InitHccl(&cfg, initType), AICPU_SCHEDULE_ERROR_INNER_ERROR);
    // fail for StubHcclCpuCommInit
    EXPECT_EQ(manager.InitHccl(&cfg, initType), AICPU_SCHEDULE_ERROR_CALL_HCCL);

    HcclSoManager::GetInstance()->UnloadSo();
}

TEST_F(AICPUModelExecuteTEST, ProcessModelConfigMsg_FailForSetQueue) {
    AicpuModelConfig cfg = {};
    cfg.inputMsgQueue = 1;
    cfg.outputMsgQueue = 2;
    MOCKER(halQueueSet)
        .stubs()
        .will(returnValue(DRV_ERROR_QUEUE_INNER_ERROR));
    EXPECT_EQ(AicpuModelManager::GetInstance().ProcessModelConfigMsg(cfg), AICPU_SCHEDULE_ERROR_FROM_DRV);
}

TEST_F(AICPUModelExecuteTEST, ProcessModelConfigMsg_FailForSubscribeEmptyEvent) {
    AicpuModelConfig cfg = {};
    cfg.inputMsgQueue = 1;
    cfg.outputMsgQueue = 2;
    MOCKER_CPP(&AicpuDrvManager::SubscribeQueueNotEmptyEvent)
        .stubs()
        .will(returnValue(AICPU_SCHEDULE_ERROR_FROM_DRV));
    EXPECT_EQ(AicpuModelManager::GetInstance().ProcessModelConfigMsg(cfg), AICPU_SCHEDULE_ERROR_FROM_DRV);
}

TEST_F(AICPUModelExecuteTEST, ProcessModelConfigMsg_FailForSubscribeNotFullEvent) {
    AicpuModelConfig cfg = {};
    cfg.inputMsgQueue = 1;
    cfg.outputMsgQueue = 2;
    MOCKER_CPP(&AicpuDrvManager::SubscribeQueueNotFullEvent)
        .stubs()
        .will(returnValue(AICPU_SCHEDULE_ERROR_FROM_DRV));
    EXPECT_EQ(AicpuModelManager::GetInstance().ProcessModelConfigMsg(cfg), AICPU_SCHEDULE_ERROR_FROM_DRV);
}