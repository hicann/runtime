/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include <ctime>
#include <dlfcn.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/stat.h>

#include "gtest/gtest.h"
#include "mockcpp/mockcpp.hpp"
#include "aicpu_engine.h"
#include "aicpusd_monitor.h"
#include "operator_kernel_context.h"
#define private public
#include "securec.h"
#include "aicpusd_interface_process.h"
#include "aicpusd_event_manager.h"
#include "aicpusd_event_process.h"
#include "aicpusd_drv_manager.h"
#include "aicpusd_model_execute.h"
#include "aicpusd_resource_manager.h"
#include "dump_task.h"
#include "aicpusd_msg_send.h"
#include "aicpusd_threads_process.h"
#include "tsd.h"
#include "profiling_adp.h"
#include "stub/aicpusd_context.h"
#include "common/aicpusd_context.h"
#include "aicpu_event_struct.h"
#include "aicpusd_status.h"
#include "aicpusd_cust_so_manager.h"
#include "dump_task.h"
#include "aicpu_sched/common/aicpu_task_struct.h"
#include "aicpusd_interface.h"
#include "aicpusd_msg_send.h"
#include "aicpusd_sub_module_interface.h"
#include "aicpusd_hal_interface_ref.h"
#include "aicpusd_hccl_api.h"
#include "hwts_kernel_cust_so.h"
#include "hwts_kernel_model_process.h"
#include "hwts_kernel_model_control.h"
#include "hwts_kernel_queue.h"
#include "hwts_kernel_dfx.h"
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
        MOCKER(dlclose).stubs().will(returnValue(0));
        AicpuScheduleInterface::GetInstance().Destroy();
        GlobalMockObject::verify();
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

public:
    AicpuScheduleInterface instance;
    LoadOpFromBuffTsKernel loadop_from_buffer_kernel_;
    BatchLoadSoFromBuffTsKernel batch_loadso_from_buffer_kernel_;
    DeleteCustOpTsKernel delete_custop_kernel_;
    ModelClearAndRestartTsKernel clear_and_restart_kernel_;
    ProcessDataExceptionTsKernel process_data_exception_kernel_;
    CheckSupportedTsKernel check_supported_kernel_;
    ModelStopTsKernel model_stop_kernel_;
    ActiveEntryStreamTsKernel active_entry_stream_kernel_;
    EschedPriorityTsKernel set_esched_priority_kernel_;
    ModelConfigTsKernel model_config_kernel_;
    ShapeConfigTsKernel shape_config_kernel_;
    ConfigExtInfoTsKernel config_extinfo_kernel_;
    CreateQueueTsKernel create_queue_kernel_;
    DestroyQueueTsKernel destroy_queue_kernel_;
    RecordNotifyTsKernel record_notify_kernel_;
    EndGraphTsKernel end_graph_kernel_;
};

namespace {
uint32_t currentModelId = 1000;
uint32_t currentExeModelId = 0;
uint32_t currentStreamId = 2000;
uint32_t currentTaskId = 3000;
uint32_t currentQId = 4000;
uint32_t currentTsId = 5000;
static constexpr uint32_t TS_STREAM_INDEX = 0x01;
char END_GRAPH[] = "endGraph";
uint32_t head = 0;
uint32_t *pHead = nullptr;

RunContext runContextT = {.modelId = 1,
                .modelTsId = 1,
                .streamId = 1,
                .pending = false,
                .executeInline = true};

// std::mutex g_qidToValueMutex;
std::map<uint32_t, std::vector<int32_t> > g_qidToValue;
std::map<uint32_t, uint32_t> g_qidToIndex;
// std:: vector<uint32_t> g_dataSubscribeVec;

/*drvError_t halQueueEnQueueFake(unsigned int devId, unsigned int qid, void *mbuf)
{
    std::cout << "halQueueEnQueue stub begin, queue id:" << qid << std::endl;
    auto qidToValIter = g_qidToValue.find(qid);
    if (qidToValIter == g_qidToValue.end()) {
        std::cout << "enqueue error, queue:" << qid << " does not exist." << std::endl;
        return -1;
    }

    int32_t val = 0;
    val = *(int32_t *)mbuf;
    g_qidToValue[qid].push_back(val);

    std::cout << "halQueueEnQueue stub success, queue id:" << qid << ", val:" << val
              << ", size:" << g_qidToValue[qid].size() - g_qidToIndex[qid] << std::endl;

    if (qidToValIter->second.size() - g_qidToIndex[qid] == 1) {
        auto iter = find(g_dataSubscribeVec.begin(), g_dataSubscribeVec.end(), qid);
        if (iter != g_dataSubscribeVec.end()) {
            std::cout << "enqueue empty to not empty, queue:" << qid << std::endl;
            AicpuScheduleCore::GetInstance().ProcessEnQueueEvent(qid);
        }
    }
    return DRV_ERROR_QUEUE_NONE;
}*/

/*drvError_t halQueueDeQueueFake(unsigned int devId, unsigned int qid, void **mbuf)
{
    std::cout << "halQueueDeQueue stub begin, queue id:" << qid << std::endl;
    auto qidToValIter = g_qidToValue.find(qid);
    if (qidToValIter == g_qidToValue.end()) {
        std::cout << "dequeue error, queue:" << qid << " does not exist." << std::endl;
        return -1;
    }

    if (qidToValIter->second.size() - g_qidToIndex[qid] == 0) {
        std::cout << "dequeue error, queue:" << qid << " is empty." << std::endl;
        return DRV_ERROR_QUEUE_EMPTY;
    }

    *(int32_t **)mbuf = &(qidToValIter->second)[g_qidToIndex[qid]];
    int32_t val = (qidToValIter->second)[g_qidToIndex[qid]];
    g_qidToIndex[qid]++;

    std::cout << "halQueueDeQueue stub success, queue id:" << qid << ", val:" << val
              << ", size:" << (qidToValIter->second).size() - g_qidToIndex[qid] << std::endl;
    return DRV_ERROR_QUEUE_NONE;
}*/

int32_t halMbufGetBuffAddrFake(Mbuf *mbuf, void **buf)
{
    std::cout << "aicpusd_interface_process_test halMbufGetBuffAddr stub begin" << std::endl;
    *(int32_t **)buf = (int32_t *)mbuf;
    std::cout << "aicpusd_interface_process_test halMbufGetBuffAddr stub end" << std::endl;
    return DRV_ERROR_NONE;
}

int halMbufGetBuffSizeFake(Mbuf *mbuf, uint64_t *totalSize)
{
    (void)(mbuf);
    *totalSize = 102;
    return -1;
}

int halMbufAllocFake(unsigned int size, unsigned int align, unsigned long flag, int grp_id, Mbuf **mbuf)
{
    static char buf[128];
    *mbuf = (Mbuf *)buf;
    return 0;
}

constexpr uint32_t mbufDataOffSet = 256;

int32_t halMbufGetBuffAddrFake2(Mbuf *mbuf, void **buf)
{
    std::cout << "aicpusd_interface_process_test halMbufGetBuffAddr stubv2 begin" << std::endl;
    *buf = (void*)((char*)mbuf+mbufDataOffSet);
    return 0;
}

int halMbufGetPrivInfoFake2(Mbuf *mbuf,  void **priv, unsigned int *size)
{
    *priv = (void *)mbuf;
    *size = mbufDataOffSet;
    return DRV_ERROR_NONE;
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

HcclResult HcclInitCsComm(const char_t *rankTableM, int32_t rankId, const char_t *roleTable,
                          const CalcParams *calcParams, HcclComm *comm)
{
    return HCCL_SUCCESS;
}

HcclResult HcclFinalizeComm(HcclComm comm)
{
    return HCCL_SUCCESS;
}

int32_t g_threasholdToFail = 0;
HcclResult HcclGetLookupRequest(void* keys, int32_t count, HcclDataType type, int32_t tag,
                                ServiceHandle *handle, HcclComm comm, ReqStatus *status)
{
    std::cout << "StubHcclGetLookupRequest, g_threasholdToFail: " << g_threasholdToFail << std::endl;
    if (g_threasholdToFail > 0) {
        return HCCL_E_RESERVED;
    }
    // the second call will be fail to break loop for test:LoadWithEventAndExecute
    ++g_threasholdToFail;
    return HCCL_SUCCESS;
}

HcclResult HcclIsetLookupResponse(void *values, int32_t count, HcclDataType type, ServiceHandle handle,
                                  HcclComm comm, HcclRequest *request)
{
    return HCCL_SUCCESS;
}

HcclResult HcclWaitSome(int32_t count, HcclRequest requestArray[], int32_t *compCount, int32_t compIndices[],
                        HcclStatus compStatus[])
{
    *compCount = 1;
    compIndices[0U] = 0;
    compStatus[0U].error = 0;
    return HCCL_SUCCESS;
}

HcclResult HcclAbortSelf(HcclComm comm, int32_t tag)
{
    return HCCL_SUCCESS;
}

HcclResult HddsServiceCancel(ServiceHandle handle)
{
    return HCCL_SUCCESS;
}

HcclResult HddsCollRecvUpdateRequest(void *keys, int32_t keyCount, HcclDataType keyType, void *values,
    int32_t valueCount, HcclDataType valueType, int32_t tag, ServiceHandle *handle, HcclComm comm,
    UpdateReqStatus *status)
{
    std::cout << "StubHddsCollRecvUpdateRequest, g_threasholdToFail: " << g_threasholdToFail << std::endl;
    if (g_threasholdToFail > 0) {
        return HCCL_E_RESERVED;
    }
    // the second call will be fail to break loop for test:LoadWithEventAndExecute
    ++g_threasholdToFail;
    return HCCL_SUCCESS;
}

HcclResult HddsIsendUpdateResponse(ServiceHandle handle, HcclComm comm, HcclRequest *request)
{
    return HCCL_SUCCESS;
}

HcclResult HddsCollRecvLookupRequest(void *keys, int32_t count, HcclDataType type, int32_t tag,
    ServiceHandle *handle, HcclComm comm, LookupReqStatus *status)
{
    return HCCL_SUCCESS;
}

HcclResult HddsIsendLookupResponse(void *values, int32_t count, HcclDataType type, ServiceHandle handle,
    HcclComm comm, HcclRequest *request)
{
    return HCCL_SUCCESS;
}

HcclResult HcomPrepareStart(const HcomOpDesc *op, HcomRequest *request)
{
    return HCCL_SUCCESS;
}

HcclResult HcomPrepareQuery(HcomRequest request, HcomStatus *status)
{
    return HCCL_SUCCESS;
}

HcclResult HcomSendByOS(void *buf, uint64_t count, HcclDataType dataType, uint32_t peerRank, uint32_t tag,
    const char_t *group, uint64_t flag)
{
    return HCCL_SUCCESS;
}

HcclResult HcomReceiveByOS(void *buf, uint64_t count, HcclDataType dataType, uint32_t peerRank, uint32_t tag,
    const char_t *group, uint64_t flag)
{
    return HCCL_SUCCESS;
}

HcclResult HcomInitByRankTable(const char_t *rankTable, uint32_t rankId)
{
    return HCCL_SUCCESS;
}

HcclResult HcomDestroy()
{
    return HCCL_SUCCESS;
}

HcclResult HcclDestroyResouce(HcclComm comm, int32_t tag)
{
    return HCCL_SUCCESS;
}

HcclResult HcomGatherByOs(void* inputBuf, uint64_t inputCount, HcclDataType inputType, void* outputBuf,
                               uint64_t outputCount, HcclDataType outputType, int root, const char *group,
                               uint64_t flag)
{
    return HCCL_SUCCESS;
}

HcclResult HcomBcastByOS(void* buf, uint64_t count, HcclDataType dataType, int root, const char *group,
                            uint64_t flag)
{
    return HCCL_SUCCESS;
}

HcclResult HcomCreateGroup(const char *group, uint32_t rankNum, uint32_t *rankIds)
{
    return HCCL_SUCCESS;
}

HcclResult HcomDestroyGroup(const char *group)
{
    return HCCL_SUCCESS;
}

HcclResult HcclRegisterGlobalMemory(void *addr, uint64_t size)
{
    return HCCL_SUCCESS;
}

HcclResult HcclUnregisterGlobalMemory(void *addr)
{
    return HCCL_SUCCESS;
}

HcclResult HcclPsAssociateWorkers(HcclComm comm, int32_t tag, uint32_t workerRanks[], uint64_t workerNum)
{
    return HCCL_SUCCESS;
}

std::map<std::string, void*> hcclSymbols = {
        {"HcclInitCsComm", (void*)(&HcclInitCsComm)},
        {"HcclFinalizeCsComm", (void*)(HcclFinalizeComm)},
        {"HcclGetLookupRequest", (void*)(HcclGetLookupRequest)},
        {"HcclIsetLookupResponse", (void*)(HcclIsetLookupResponse)},
        {"HcclWaitSome", (void*)(HcclWaitSome)},
        {"HcclAbortSelf", (void*)(HcclAbortSelf)},
        {"HddsServiceCancel", (void*)(HddsServiceCancel)},
        {"HddsCollRecvUpdateRequest", (void*)(HddsCollRecvUpdateRequest)},
        {"HddsIsendUpdateResponse", (void*)(HddsIsendUpdateResponse)},
        {"HddsCollRecvLookupRequest", (void*)(HddsCollRecvLookupRequest)},
        {"HddsIsendLookupResponse", (void*)(HddsIsendLookupResponse)},
        {"HcomPrepareStart", (void*)(HcomPrepareStart)},
        {"HcomPrepareQuery", (void*)(HcomPrepareQuery)},
        {"HcomSendByOS", (void*)(HcomSendByOS)},
        {"HcomReceiveByOS", (void*)(HcomReceiveByOS)},
        {"HcomInitByRankTable", (void*)(HcomInitByRankTable)},
        {"HcomDestroy", (void*)(HcomDestroy)},
        {"HcomCreateGroup", (void*)(HcomCreateGroup)},
        {"HcomDestroyGroup", (void*)(HcomDestroyGroup)},
        {"HcomGatherByOs", (void*)(HcomGatherByOs)},
        {"HcomBcastByOS", (void*)(HcomBcastByOS)},
        {"HcclDestroyResouce", (void*)(HcclDestroyResouce)},
        {"HcclRpcRegisterGlobalMemory", (void*)(HcclRegisterGlobalMemory)},
        {"HcclRpcUnregisterGlobalMemory", (void*)(HcclUnregisterGlobalMemory)},
        {"HcclPsAssociateWorkers", (void*)(HcclPsAssociateWorkers)},
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
/*drvError_t halQueueSubscribeFake(unsigned int devid, unsigned int qid, unsigned int groupId, int type)
{
    std::cout << "halQueueSubscribe stub begin" << std::endl;
    auto iter = find(g_dataSubscribeVec.begin(), g_dataSubscribeVec.end(), qid);
    if (iter != g_dataSubscribeVec.end()) {
        return DRV_ERROR_QUEUE_RE_SUBSCRIBED;
    }
    g_dataSubscribeVec.push_back(qid);
    std::cout << "halQueueSubscribe stub, g_dataSubscribeVec push " << qid << " success" << std::endl;
    return DRV_ERROR_QUEUE_NONE;
}*/

/*void CheckAndEnQueue(uint32_t qid, int32_t& val)
{
    std::cout << "EnQueue is processing..." << std::endl;
    int ret = halQueueEnQueueFake(0, qid, (void*)&val);
    EXPECT_EQ(ret, 0);
    return;
}*/

/*void CheckAndDeQueue(uint32_t qid, int32_t val)
{
    std::cout << "DeQueue is processing..." << std::endl;
    int32_t* realVal = nullptr;
    int ret = halQueueDeQueueFake(0, qid, (void**)&realVal);
    EXPECT_EQ(ret, DRV_ERROR_QUEUE_NONE);
    EXPECT_NE(realVal, nullptr);
    EXPECT_EQ(*realVal, val);
    return;
}*/

void CheckQueueSize(uint32_t qid, int32_t size)
{
    auto iter = g_qidToValue.find(qid);
    if (iter != g_qidToValue.end()) {
        EXPECT_EQ(iter->second.size() - g_qidToIndex[qid], size);
    }
    return;
}

int tsDevSendMsgAsyncFake(unsigned int devId, unsigned int tsId, char *msg, unsigned int msgLen, unsigned int handleId)
{
    currentExeModelId = handleId;
    return 0;
}

int halMbufGetPrivInfoFake(Mbuf *mbuf,  void **priv, unsigned int *size)
{
    pHead = &head;
    *priv = pHead;
    *size = sizeof(uint32_t);
    return DRV_ERROR_NONE;
}

uint32_t CreateAicpuModel(AicpuModelInfo *model)
{
    model->moduleID = currentModelId;
    currentModelId++;
    model->tsId = currentTsId;
    currentTsId++;
    model->streamInfoNum = 0;
    model->aicpuTaskNum = 0;
    model->queueSize = 0;
    return model->moduleID;
}

uint32_t CreateStream(StreamInfo *stream, uint32_t flag)
{
    stream->streamID = currentStreamId;
    currentStreamId++;
    stream->streamFlag = flag;
    return stream->streamID;
}

uint32_t CreateAicpuTask(
    AicpuTaskInfo *aicpuTask, uint32_t streamID, uint32_t kernelType, char *kernelName, uint64_t paraBase)
{
    aicpuTask->taskID = currentTaskId;
    currentTaskId++;
    aicpuTask->streamID = streamID;
    aicpuTask->kernelType = kernelType;
    aicpuTask->kernelName = (uint64_t)kernelName;
    aicpuTask->kernelSo = 0;
    aicpuTask->paraBase = paraBase;
    return aicpuTask->taskID;
}

uint32_t CreateQueue(QueInfo *queue, uint32_t flag)
{
    queue->queueID = currentQId;
    currentQId++;
    queue->flag = flag;
    g_qidToValue.insert(std::make_pair(queue->queueID, std::vector<int32_t>()));
    g_qidToIndex.insert(std::make_pair(queue->queueID, 0));
    return queue->queueID;
}

void AddStream2Model(AicpuModelInfo *model, StreamInfo *stream, uint32_t streamInfoNum)
{
    model->streamInfoNum = streamInfoNum;
    model->streamInfoPtr = (uint64_t)stream;
}

void AddAicpuTask2Model(AicpuModelInfo *model, AicpuTaskInfo *aicpuTask, uint32_t aicpuTaskNum)
{
    model->aicpuTaskNum = aicpuTaskNum;
    model->aicpuTaskPtr = (uint64_t)aicpuTask;
}

void AddQueue2Model(AicpuModelInfo *model, QueInfo *queue, uint32_t queueSize)
{
    model->queueSize = queueSize;
    model->queueInfoPtr = (uint64_t)queue;
}

/*drvError_t halEschedSubmitEventStub(unsigned int devId, struct event_summary *event)
{
    event_info eventInfo = g_event;
    eventInfo.priv.msg_len = event->msg_len;
    // eventInfo.priv.msg = event->msg;
    memset(eventInfo.priv.msg, 0, 128);
    memcpy(eventInfo.priv.msg, event->msg, event->msg_len);
    eventInfo.comm.subevent_id = event->subevent_id;
    ModelStatus status;
    AicpuScheduleInterface::GetInstance().ProcessAICPUEvent(eventInfo, status);
    return DRV_ERROR_NONE;
}*/

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
        *custProcPid = 12;
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
}  // namespace

TEST_F(AICPUScheduleInterfaceTEST, TsKernelLoadOpFromBuf)
{
    MOCKER(halGrpQuery)
    .stubs()
    .will(invoke(halGrpQueryWithTwoGroup));
    MOCKER(halGrpAttach)
    .stubs()
    .will(returnValue(0));
    MOCKER(CreateOrFindCustPid, int32_t(const uint32_t, const uint32_t, const char * const *,
        const uint32_t, const uint32_t, const char *, const uint32_t, int32_t*, bool*))
        .stubs()
        .will(invoke(CreateOrFindCustPidStub));
    aicpu::SetHaveCustPid(false);
    std::vector<uint32_t> deviceVec;
    deviceVec.push_back(1);
    AicpuDrvManager::GetInstance().InitDrvMgr(deviceVec, 3200, 0, false);
    (void)AicpuCustSoManager::GetInstance().InitAicpuCustSoManager(aicpu::AicpuRunMode::THREAD_MODE,
                                                                   SCHED_MODE_INTERRUPT);
    uint32_t deviceId = AicpuDrvManager::GetInstance().GetDeviceId();
    bool hasThread = AicpuDrvManager::GetInstance().HasThread();
    pid_t hostPid = AicpuDrvManager::GetInstance().GetHostPid();
    aicpu::HwtsTsKernel tsKernelInfo;
    aicpu::HwtsCceKernel cceKernel;
    char kernel_name[] = "loadOpFromBuf";
    uint64_t kernel_name_addr = reinterpret_cast<uint64_t>(
                                reinterpret_cast<uintptr_t>(kernel_name));
    cceKernel.kernelName = kernel_name_addr;

    char soContent[] = "This is test for loadOpFromBuf";
    uint64_t kernelSoBuf = reinterpret_cast<uint64_t>(reinterpret_cast<uintptr_t>
                                                      (soContent));
    uint32_t kernelSoBufLen = strlen(soContent);
    char kernelSoNameContent[] = "libcust_aicpu_kernels.so";
    uint64_t kernelSoName = reinterpret_cast<uint64_t>(reinterpret_cast<uintptr_t>
                                                       (kernelSoNameContent));
    uint32_t kernelSoNameLen = strlen(kernelSoNameContent);

    struct LoadOpFromBufArgs loadOpFromBufArgs;
    loadOpFromBufArgs.kernelSoBuf = kernelSoBuf;
    loadOpFromBufArgs.kernelSoBufLen = kernelSoBufLen;
    loadOpFromBufArgs.kernelSoName = kernelSoName;
    loadOpFromBufArgs.kernelSoNameLen = kernelSoNameLen;

    uint64_t paramBase = reinterpret_cast<uint64_t>(
                         reinterpret_cast<uintptr_t>(&loadOpFromBufArgs));
    cceKernel.paramBase = paramBase;
    tsKernelInfo.kernelType = 2;
    tsKernelInfo.kernelBase.cceKernel = cceKernel;

    char* curDirName = getenv("HOME");
    std::string dirName(curDirName);
    if (dirName[dirName.size() - 1] != '/') {
        dirName = dirName + "/";
    }
    MOCKER(&AicpuCustSoManager::CheckSoFullPathValid).stubs().will(returnValue(0));
    int retStatus = loadop_from_buffer_kernel_.Compute(tsKernelInfo);
    deviceVec[0] = deviceId;
    AicpuDrvManager::GetInstance().InitDrvMgr(deviceVec, hostPid, 0, hasThread);
    std::string command = "rm -rf ";
    command.append(dirName).append("cust_aicpu_0_3200").append("/");
    int ret = system(command.c_str());
    EXPECT_EQ(retStatus, AICPU_SCHEDULE_OK);
}
aicpu::status_t GetAicpuRunModePCIE(aicpu::AicpuRunMode &runMode)
{
    runMode = aicpu::AicpuRunMode::PROCESS_PCIE_MODE;
    return aicpu::AICPU_ERROR_NONE;
}

TEST_F(AICPUScheduleInterfaceTEST, TsKernelLoadOpFromBuf_failed1)
{
    (void)AicpuCustSoManager::GetInstance().InitAicpuCustSoManager(aicpu::AicpuRunMode::THREAD_MODE,
                                                                   SCHED_MODE_INTERRUPT);
    aicpu::SetHaveCustPid(false);
    MOCKER_CPP(&AicpuCustSoManager::CreateSoFile)
        .stubs()
        .will(returnValue(AICPU_SCHEDULE_OK));
    aicpu::HwtsTsKernel tsKernelInfo;
    aicpu::HwtsCceKernel cceKernel;
    char kernel_name[] = "loadOpFromBuf";
    uint64_t kernel_name_addr = reinterpret_cast<uint64_t>(
                                reinterpret_cast<uintptr_t>(kernel_name));
    cceKernel.kernelName = kernel_name_addr;

    char soContent[] = "This is test for loadOpFromBuf";
    uint64_t kernelSoBuf = reinterpret_cast<uint64_t>(reinterpret_cast<uintptr_t>
                                                      (soContent));
    uint32_t kernelSoBufLen = 0;
    char kernelSoNameContent[] = "libcust_aicpu_kernels.so";
    uint64_t kernelSoName = reinterpret_cast<uint64_t>(reinterpret_cast<uintptr_t>
                                                       (kernelSoNameContent));
    uint32_t kernelSoNameLen = strlen(kernelSoNameContent);

    struct LoadOpFromBufArgs loadOpFromBufArgs;
    loadOpFromBufArgs.kernelSoBuf = kernelSoBuf;
    loadOpFromBufArgs.kernelSoBufLen = kernelSoBufLen;
    loadOpFromBufArgs.kernelSoName = kernelSoName;
    loadOpFromBufArgs.kernelSoNameLen = kernelSoNameLen;

    uint64_t paramBase = reinterpret_cast<uint64_t>(
                         reinterpret_cast<uintptr_t>(&loadOpFromBufArgs));
    cceKernel.paramBase = paramBase;
    tsKernelInfo.kernelType = 2;
    tsKernelInfo.kernelBase.cceKernel = cceKernel;
    int ret = loadop_from_buffer_kernel_.Compute(tsKernelInfo);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID);
}

TEST_F(AICPUScheduleInterfaceTEST, TsKernelLoadOpFromBuf_failed2)
{
    (void)AicpuCustSoManager::GetInstance().InitAicpuCustSoManager(aicpu::AicpuRunMode::THREAD_MODE,
                                                                   SCHED_MODE_INTERRUPT);
    aicpu::SetHaveCustPid(false);
    MOCKER_CPP(&AicpuCustSoManager::CreateSoFile)
        .stubs()
        .will(returnValue(AICPU_SCHEDULE_OK));
    aicpu::HwtsTsKernel tsKernelInfo;
    aicpu::HwtsCceKernel cceKernel;
    char kernel_name[] = "loadOpFromBuf";
    uint64_t kernel_name_addr = reinterpret_cast<uint64_t>(
                                reinterpret_cast<uintptr_t>(kernel_name));
    cceKernel.kernelName = kernel_name_addr;

    char soContent[] = "This is test for loadOpFromBuf";
    uint64_t kernelSoBuf = reinterpret_cast<uint64_t>(reinterpret_cast<uintptr_t>
                                                      (soContent));
    uint32_t kernelSoBufLen = strlen(soContent);
    char kernelSoNameContent[] = "libcust_aicpu_kernels.so";
    uint64_t kernelSoName = reinterpret_cast<uint64_t>(reinterpret_cast<uintptr_t>
                                                       (kernelSoNameContent));
    uint32_t kernelSoNameLen = 0;

    struct LoadOpFromBufArgs loadOpFromBufArgs;
    loadOpFromBufArgs.kernelSoBuf = kernelSoBuf;
    loadOpFromBufArgs.kernelSoBufLen = kernelSoBufLen;
    loadOpFromBufArgs.kernelSoName = kernelSoName;
    loadOpFromBufArgs.kernelSoNameLen = kernelSoNameLen;

    uint64_t paramBase = reinterpret_cast<uint64_t>(
                         reinterpret_cast<uintptr_t>(&loadOpFromBufArgs));
    cceKernel.paramBase = paramBase;
    tsKernelInfo.kernelType = 2;
    tsKernelInfo.kernelBase.cceKernel = cceKernel;
    int ret = loadop_from_buffer_kernel_.Compute(tsKernelInfo);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID);
}

TEST_F(AICPUScheduleInterfaceTEST, TsKernelLoadOpFromBuf_failed3)
{
    (void)AicpuCustSoManager::GetInstance().InitAicpuCustSoManager(aicpu::AicpuRunMode::THREAD_MODE,
                                                                   SCHED_MODE_INTERRUPT);
    aicpu::SetHaveCustPid(false);
    MOCKER(CreateOrFindCustPid, int32_t(const uint32_t, const uint32_t, const char * const *,
        const uint32_t, const uint32_t, const char *, const uint32_t, int32_t*, bool*))
        .stubs()
        .will(invoke(CreateOrFindCustPidFailedStub));
    MOCKER_CPP(&AicpuCustSoManager::CreateSoFile)
        .stubs()
        .will(returnValue(AICPU_SCHEDULE_ERROR_INNER_ERROR));
    aicpu::HwtsTsKernel tsKernelInfo;
    aicpu::HwtsCceKernel cceKernel;
    char kernel_name[] = "loadOpFromBuf";
    uint64_t kernel_name_addr = reinterpret_cast<uint64_t>(
                                reinterpret_cast<uintptr_t>(kernel_name));
    cceKernel.kernelName = kernel_name_addr;

    char soContent[] = "This is test for loadOpFromBuf";
    uint64_t kernelSoBuf = reinterpret_cast<uint64_t>(reinterpret_cast<uintptr_t>
                                                      (soContent));
    uint32_t kernelSoBufLen = strlen(soContent);
    char kernelSoNameContent[] = "libcust_aicpu_kernels_fail.so";
    uint64_t kernelSoName = reinterpret_cast<uint64_t>(reinterpret_cast<uintptr_t>
                                                       (kernelSoNameContent));
    uint32_t kernelSoNameLen = strlen(kernelSoNameContent);

    struct LoadOpFromBufArgs loadOpFromBufArgs;
    loadOpFromBufArgs.kernelSoBuf = kernelSoBuf;
    loadOpFromBufArgs.kernelSoBufLen = kernelSoBufLen;
    loadOpFromBufArgs.kernelSoName = kernelSoName;
    loadOpFromBufArgs.kernelSoNameLen = kernelSoNameLen;

    uint64_t paramBase = reinterpret_cast<uint64_t>(
                         reinterpret_cast<uintptr_t>(&loadOpFromBufArgs));
    cceKernel.paramBase = paramBase;
    tsKernelInfo.kernelType = 2;
    tsKernelInfo.kernelBase.cceKernel = cceKernel;
    int ret = loadop_from_buffer_kernel_.Compute(tsKernelInfo);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_INNER_ERROR);
}

TEST_F(AICPUScheduleInterfaceTEST, TsKernelLoadOpFromBuf_failed4)
{
    (void)AicpuCustSoManager::GetInstance().InitAicpuCustSoManager(aicpu::AicpuRunMode::THREAD_MODE,
                                                                   SCHED_MODE_INTERRUPT);
    aicpu::SetHaveCustPid(false);
    MOCKER_CPP(&AicpuCustSoManager::CreateSoFile)
        .stubs()
        .will(returnValue(AICPU_SCHEDULE_ERROR_INNER_ERROR));
    aicpu::HwtsTsKernel tsKernelInfo;
    aicpu::HwtsCceKernel cceKernel;
    char kernel_name[] = "loadOpFromBuf";
    uint64_t kernel_name_addr = reinterpret_cast<uint64_t>(
                                reinterpret_cast<uintptr_t>(kernel_name));
    cceKernel.kernelName = kernel_name_addr;

    char soContent[] = "This is test for loadOpFromBuf";
    uint64_t kernelSoBuf = reinterpret_cast<uint64_t>(reinterpret_cast<uintptr_t>
                                                      (soContent));
    uint32_t kernelSoBufLen = strlen(soContent);
    char kernelSoNameContent[] = "libcust_cpu_kernels.so";
    uint64_t kernelSoName = reinterpret_cast<uint64_t>(reinterpret_cast<uintptr_t>
                                                       (kernelSoNameContent));
    uint32_t kernelSoNameLen = strlen(kernelSoNameContent);

    struct LoadOpFromBufArgs loadOpFromBufArgs;
    loadOpFromBufArgs.kernelSoBuf = kernelSoBuf;
    loadOpFromBufArgs.kernelSoBufLen = kernelSoBufLen;
    loadOpFromBufArgs.kernelSoName = kernelSoName;
    loadOpFromBufArgs.kernelSoNameLen = kernelSoNameLen;

    uint64_t paramBase = reinterpret_cast<uint64_t>(
                         reinterpret_cast<uintptr_t>(&loadOpFromBufArgs));
    cceKernel.paramBase = paramBase;
    tsKernelInfo.kernelType = 2;
    tsKernelInfo.kernelBase.cceKernel = cceKernel;
    int ret = loadop_from_buffer_kernel_.Compute(tsKernelInfo);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_INNER_ERROR);
}


TEST_F(AICPUScheduleInterfaceTEST, TsKernelLoadOpFromBufNotSupport)
{
    (void)AicpuCustSoManager::GetInstance().InitAicpuCustSoManager(aicpu::AicpuRunMode::THREAD_MODE,
                                                                   SCHED_MODE_MSGQ);

    aicpu::HwtsTsKernel tsKernelInfo;
    aicpu::HwtsCceKernel cceKernel;
    char kernel_name[] = "loadOpFromBuf";
    uint64_t kernel_name_addr = reinterpret_cast<uint64_t>(reinterpret_cast<uintptr_t>(kernel_name));
    cceKernel.kernelName = kernel_name_addr;
    tsKernelInfo.kernelType = 2;
    tsKernelInfo.kernelBase.cceKernel = cceKernel;
    int ret = loadop_from_buffer_kernel_.Compute(tsKernelInfo);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_INNER_ERROR);
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

TEST_F(AICPUScheduleInterfaceTEST, TsKernelBatchLoadOpFromBuf_success)
{
    MOCKER(&AicpuCustSoManager::CheckSoFullPathValid).stubs().will(returnValue(0));
    MOCKER(halGrpQuery)
    .stubs()
    .will(invoke(halGrpQueryWithTwoGroup));
    MOCKER(halGrpAttach)
    .stubs()
    .will(returnValue(0));
    MOCKER(CreateOrFindCustPid, int32_t(const uint32_t, const uint32_t, const char * const *,
        const uint32_t, const uint32_t, const char *, const uint32_t, int32_t*, bool*))
        .stubs()
        .will(invoke(CreateOrFindCustPidStub));
    (void)AicpuCustSoManager::GetInstance().InitAicpuCustSoManager(aicpu::AicpuRunMode::THREAD_MODE,
                                                                   SCHED_MODE_INTERRUPT);
    aicpu::SetHaveCustPid(false);
    uint32_t deviceId = AicpuDrvManager::GetInstance().GetDeviceId();
    bool hasThread = AicpuDrvManager::GetInstance().HasThread();
    pid_t hostPid = AicpuDrvManager::GetInstance().GetHostPid();
    std::vector<uint32_t> deviceVec;
    deviceVec.push_back(1);
    AicpuDrvManager::GetInstance().InitDrvMgr(deviceVec, 3001, 0, true);
    aicpu::HwtsTsKernel tsKernelInfo;
    aicpu::HwtsCceKernel cceKernel;
    char kernel_name[] = "batchLoadOpFromBuf";
    uint64_t kernel_name_addr = reinterpret_cast<uint64_t>(
                                reinterpret_cast<uintptr_t>(kernel_name));
    cceKernel.kernelName = kernel_name_addr;

    char soContent[] = "This is test for batchLoadOpFromBuf";
    uint64_t kernelSoBuf = reinterpret_cast<uint64_t>(reinterpret_cast<uintptr_t>
                                                      (soContent));
    uint32_t kernelSoBufLen = strlen(soContent);
    char kernelSoNameContent[] = "libcust_aicpu_kernels.so";
    uint64_t kernelSoName = reinterpret_cast<uint64_t>(reinterpret_cast<uintptr_t>
                                                       (kernelSoNameContent));
    uint32_t kernelSoNameLen = strlen(kernelSoNameContent);

    char soContent2[] = "batchLoadOpFromBuf batchLoadOpFromBuf batchLoadOpFromBuf";
    uint64_t kernelSoBuf2 = reinterpret_cast<uint64_t>(reinterpret_cast<uintptr_t>
                                                      (soContent2));
    uint32_t kernelSoBufLen2 = strlen(soContent2);
    char kernelSoNameContent2[] = "libcust_aicpu_kernels2.so";
    uint64_t kernelSoName2 = reinterpret_cast<uint64_t>(reinterpret_cast<uintptr_t>
                                                       (kernelSoNameContent2));
    uint32_t kernelSoNameLen2 = strlen(kernelSoNameContent2);

    uint32_t num = 2;
    BatchLoadOpFromBufArgs *p=(BatchLoadOpFromBufArgs*)malloc(sizeof(BatchLoadOpFromBufArgs)+sizeof(LoadOpFromBufArgs)*num);
    p->soNum=num;
    std::vector<LoadOpFromBufArgs> v_cust_so;
    LoadOpFromBufArgs custSoInfo;
    custSoInfo.kernelSoBuf=kernelSoBuf;
    custSoInfo.kernelSoBufLen=kernelSoBufLen;
    custSoInfo.kernelSoName=kernelSoName;
    custSoInfo.kernelSoNameLen=kernelSoNameLen;
    v_cust_so.push_back(custSoInfo);
    LoadOpFromBufArgs custSoInfo2;
    custSoInfo2.kernelSoBuf=kernelSoBuf2;
    custSoInfo2.kernelSoBufLen=kernelSoBufLen2;
    custSoInfo2.kernelSoName=kernelSoName2;
    custSoInfo2.kernelSoNameLen=kernelSoNameLen2;
    v_cust_so.push_back(custSoInfo2);

    p->opInfoArgs=reinterpret_cast<uint64_t>(reinterpret_cast<uintptr_t>(v_cust_so.data()));

    uint64_t paramBase = reinterpret_cast<uint64_t>(
                         reinterpret_cast<uintptr_t>(p));
    cceKernel.paramBase = paramBase;
    tsKernelInfo.kernelType = 2;
    tsKernelInfo.kernelBase.cceKernel = cceKernel;

    char* curDirName = getenv("HOME");
    std::string dirName(curDirName);
    if (dirName[dirName.size() - 1] != '/') {
        dirName = dirName + "/";
    }
    int retStatus = batch_loadso_from_buffer_kernel_.Compute(tsKernelInfo);

    EXPECT_EQ(retStatus, AICPU_SCHEDULE_OK);
    //AicpuDrvManager::GetInstance().InitDrvMgr(1, 3000, true);
    retStatus = delete_custop_kernel_.Compute(tsKernelInfo);
    deviceVec[0] = deviceId;
    AicpuDrvManager::GetInstance().InitDrvMgr(deviceVec, hostPid, 0, hasThread);

    std::string command = "rm -rf ";
    command = command + dirName + "cust_aicpu_0_3001";
    int ret = system(command.c_str());

    free (p);
    EXPECT_EQ(retStatus, AICPU_SCHEDULE_OK);
}

TEST_F(AICPUScheduleInterfaceTEST, TsKernelBatchLoadOpFromBuf_fail0)
{
    (void)AicpuCustSoManager::GetInstance().InitAicpuCustSoManager(aicpu::AicpuRunMode::THREAD_MODE,
                                                                   SCHED_MODE_INTERRUPT);
    aicpu::SetHaveCustPid(false);
    uint32_t deviceId = AicpuDrvManager::GetInstance().GetDeviceId();
    bool hasThread = AicpuDrvManager::GetInstance().HasThread();
    pid_t hostPid = AicpuDrvManager::GetInstance().GetHostPid();
    std::vector<uint32_t> deviceVec;
    deviceVec.push_back(1);
    AicpuDrvManager::GetInstance().InitDrvMgr(deviceVec, 3000, 0, true);
    aicpu::HwtsTsKernel tsKernelInfo;
    aicpu::HwtsCceKernel cceKernel;
    char kernel_name[] = "batchLoadOpFromBuf";
    uint64_t kernel_name_addr = reinterpret_cast<uint64_t>(
                                reinterpret_cast<uintptr_t>(kernel_name));
    cceKernel.kernelName = kernel_name_addr;

    char soContent[] = "This is test for batchLoadOpFromBuf";
    uint64_t kernelSoBuf = reinterpret_cast<uint64_t>(reinterpret_cast<uintptr_t>
                                                      (soContent));
    uint32_t kernelSoBufLen = 0;//strlen(soContent);
    char kernelSoNameContent[] = "libcust_aicpu_kernels.so";
    uint64_t kernelSoName = reinterpret_cast<uint64_t>(reinterpret_cast<uintptr_t>
                                                       (kernelSoNameContent));
    uint32_t kernelSoNameLen = strlen(kernelSoNameContent);

    char soContent2[] = "batchLoadOpFromBuf batchLoadOpFromBuf batchLoadOpFromBuf";
    uint64_t kernelSoBuf2 = reinterpret_cast<uint64_t>(reinterpret_cast<uintptr_t>
                                                      (soContent2));
    uint32_t kernelSoBufLen2 = strlen(soContent2);
    char kernelSoNameContent2[] = "libcust_aicpu_kernels2.so";
    uint64_t kernelSoName2 = reinterpret_cast<uint64_t>(reinterpret_cast<uintptr_t>
                                                       (kernelSoNameContent2));
    uint32_t kernelSoNameLen2 = strlen(kernelSoNameContent2);

    uint32_t num = 2;
    BatchLoadOpFromBufArgs *p=(BatchLoadOpFromBufArgs*)malloc(sizeof(BatchLoadOpFromBufArgs)+sizeof(LoadOpFromBufArgs)*num);
    p->soNum=num;
    std::vector<LoadOpFromBufArgs> v_cust_so;
    LoadOpFromBufArgs custSoInfo;
    custSoInfo.kernelSoBuf=kernelSoBuf;
    custSoInfo.kernelSoBufLen=kernelSoBufLen;
    custSoInfo.kernelSoName=kernelSoName;
    custSoInfo.kernelSoNameLen=kernelSoNameLen;
    v_cust_so.push_back(custSoInfo);
    LoadOpFromBufArgs custSoInfo2;
    custSoInfo2.kernelSoBuf=kernelSoBuf2;
    custSoInfo2.kernelSoBufLen=kernelSoBufLen2;
    custSoInfo2.kernelSoName=kernelSoName2;
    custSoInfo2.kernelSoNameLen=kernelSoNameLen2;
    v_cust_so.push_back(custSoInfo2);

    p->opInfoArgs=reinterpret_cast<uint64_t>(reinterpret_cast<uintptr_t>(v_cust_so.data()));

    uint64_t paramBase = reinterpret_cast<uint64_t>(
                         reinterpret_cast<uintptr_t>(p));
    cceKernel.paramBase = paramBase;
    tsKernelInfo.kernelType = 2;
    tsKernelInfo.kernelBase.cceKernel = cceKernel;
    int retStatus = batch_loadso_from_buffer_kernel_.Compute(tsKernelInfo);

    free (p);
    EXPECT_EQ(retStatus, AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID);
}

TEST_F(AICPUScheduleInterfaceTEST, TsKernelBatchLoadOpFromBuf_fail3)
{
    (void)AicpuCustSoManager::GetInstance().InitAicpuCustSoManager(aicpu::AicpuRunMode::THREAD_MODE,
                                                                   SCHED_MODE_INTERRUPT);
    aicpu::SetHaveCustPid(false);
    uint32_t deviceId = AicpuDrvManager::GetInstance().GetDeviceId();
    bool hasThread = AicpuDrvManager::GetInstance().HasThread();
    pid_t hostPid = AicpuDrvManager::GetInstance().GetHostPid();
    std::vector<uint32_t> deviceVec;
    deviceVec.push_back(1);
    AicpuDrvManager::GetInstance().InitDrvMgr(deviceVec, 3003, 0, true);
    aicpu::HwtsTsKernel tsKernelInfo;
    aicpu::HwtsCceKernel cceKernel;
    char kernel_name[] = "batchLoadOpFromBuf";
    uint64_t kernel_name_addr = reinterpret_cast<uint64_t>(
                                reinterpret_cast<uintptr_t>(kernel_name));
    //cceKernel.kernelName = kernel_name_addr;

    char soContent[] = "This is test for batchLoadOpFromBuf";
    uint64_t kernelSoBuf = reinterpret_cast<uint64_t>(reinterpret_cast<uintptr_t>
                                                      (soContent));
    uint32_t kernelSoBufLen = 0;//strlen(soContent);
    char kernelSoNameContent[] = "libcust_aicpu_kernels.so";
    uint64_t kernelSoName = reinterpret_cast<uint64_t>(reinterpret_cast<uintptr_t>
                                                       (kernelSoNameContent));
    uint32_t kernelSoNameLen = strlen(kernelSoNameContent);

    char soContent2[] = "batchLoadOpFromBuf batchLoadOpFromBuf batchLoadOpFromBuf";
    uint64_t kernelSoBuf2 = reinterpret_cast<uint64_t>(reinterpret_cast<uintptr_t>
                                                      (soContent2));
    uint32_t kernelSoBufLen2 = strlen(soContent2);
    char kernelSoNameContent2[] = "libcust_aicpu_kernels2.so";
    uint64_t kernelSoName2 = reinterpret_cast<uint64_t>(reinterpret_cast<uintptr_t>
                                                       (kernelSoNameContent2));
    uint32_t kernelSoNameLen2 = strlen(kernelSoNameContent2);

    uint32_t num = 2;
    BatchLoadOpFromBufArgs *p=(BatchLoadOpFromBufArgs*)malloc(sizeof(BatchLoadOpFromBufArgs)+sizeof(LoadOpFromBufArgs)*num);
    p->soNum=num;
    std::vector<LoadOpFromBufArgs> v_cust_so;
    LoadOpFromBufArgs custSoInfo;
    custSoInfo.kernelSoBuf=kernelSoBuf;
    custSoInfo.kernelSoBufLen=kernelSoBufLen;
    custSoInfo.kernelSoName=kernelSoName;
    custSoInfo.kernelSoNameLen=kernelSoNameLen;
    v_cust_so.push_back(custSoInfo);
    LoadOpFromBufArgs custSoInfo2;
    custSoInfo2.kernelSoBuf=kernelSoBuf2;
    custSoInfo2.kernelSoBufLen=kernelSoBufLen2;
    custSoInfo2.kernelSoName=kernelSoName2;
    custSoInfo2.kernelSoNameLen=kernelSoNameLen2;
    v_cust_so.push_back(custSoInfo2);

    p->opInfoArgs=reinterpret_cast<uint64_t>(reinterpret_cast<uintptr_t>(v_cust_so.data()));

    uint64_t paramBase = reinterpret_cast<uint64_t>(
                         reinterpret_cast<uintptr_t>(p));
    cceKernel.paramBase = paramBase;
    tsKernelInfo.kernelType = 2;
    tsKernelInfo.kernelBase.cceKernel = cceKernel;

    int retStatus = batch_loadso_from_buffer_kernel_.Compute(tsKernelInfo);

    free (p);
    EXPECT_EQ(retStatus, AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID);
}

TEST_F(AICPUScheduleInterfaceTEST, TsKernelBatchLoadOpFromBuf_fail4)
{
    MOCKER(&AicpuCustSoManager::CheckSoFullPathValid).stubs().will(returnValue(0));
    MOCKER(halGrpQuery)
    .stubs()
    .will(invoke(halGrpQueryWithTwoGroup));
    MOCKER(halGrpAttach)
    .stubs()
    .will(returnValue(0));
    MOCKER(CreateOrFindCustPid, int32_t(const uint32_t, const uint32_t, const char * const *,
        const uint32_t, const uint32_t, const char *, const uint32_t, int32_t*, bool*))
        .stubs()
        .will(invoke(CreateOrFindCustPidStub));
    std::vector<uint32_t> deviceVec;
    deviceVec.push_back(1);
    AicpuDrvManager::GetInstance().InitDrvMgr(deviceVec, 3004, 0, true);
    (void)AicpuCustSoManager::GetInstance().InitAicpuCustSoManager(aicpu::AicpuRunMode::THREAD_MODE,
                                                                   SCHED_MODE_INTERRUPT);
    aicpu::SetHaveCustPid(false);
    uint32_t deviceId = AicpuDrvManager::GetInstance().GetDeviceId();
    bool hasThread = AicpuDrvManager::GetInstance().HasThread();
    pid_t hostPid = AicpuDrvManager::GetInstance().GetHostPid();
    aicpu::HwtsTsKernel tsKernelInfo;
    aicpu::HwtsCceKernel cceKernel;
    char kernel_name[] = "batchLoadOpFromBuf";
    uint64_t kernel_name_addr = reinterpret_cast<uint64_t>(
                                reinterpret_cast<uintptr_t>(kernel_name));
    cceKernel.kernelName = kernel_name_addr;

    char soContent[] = "This is test for batchLoadOpFromBuf";
    uint64_t kernelSoBuf = reinterpret_cast<uint64_t>(reinterpret_cast<uintptr_t>
                                                      (soContent));
    uint32_t kernelSoBufLen = strlen(soContent);
    char kernelSoNameContent[] = "libcust_aicpu_kernels.so";
    uint64_t kernelSoName = reinterpret_cast<uint64_t>(reinterpret_cast<uintptr_t>
                                                       (kernelSoNameContent));
    uint32_t kernelSoNameLen = strlen(kernelSoNameContent);

    char soContent2[] = "batchLoadOpFromBuf batchLoadOpFromBuf batchLoadOpFromBuf";
    uint64_t kernelSoBuf2 = reinterpret_cast<uint64_t>(reinterpret_cast<uintptr_t>
                                                      (soContent2));
    uint32_t kernelSoBufLen2 = strlen(soContent2);
    char kernelSoNameContent2[] = "libcust_aicpu_kernels2.so";
    uint64_t kernelSoName2 = reinterpret_cast<uint64_t>(reinterpret_cast<uintptr_t>
                                                       (kernelSoNameContent2));
    uint32_t kernelSoNameLen2 = strlen(kernelSoNameContent2);

    uint32_t num = 2;
    BatchLoadOpFromBufArgs *p=(BatchLoadOpFromBufArgs*)malloc(sizeof(BatchLoadOpFromBufArgs)+sizeof(LoadOpFromBufArgs)*num);
    p->soNum=num;
    std::vector<LoadOpFromBufArgs> v_cust_so;
    LoadOpFromBufArgs custSoInfo;
    custSoInfo.kernelSoBuf=kernelSoBuf;
    custSoInfo.kernelSoBufLen=kernelSoBufLen;
    custSoInfo.kernelSoName=kernelSoName;
    custSoInfo.kernelSoNameLen=kernelSoNameLen;
    v_cust_so.push_back(custSoInfo);
    LoadOpFromBufArgs custSoInfo2;
    custSoInfo2.kernelSoBuf=kernelSoBuf2;
    custSoInfo2.kernelSoBufLen=kernelSoBufLen2;
    custSoInfo2.kernelSoName=kernelSoName2;
    custSoInfo2.kernelSoNameLen=kernelSoNameLen2;
    v_cust_so.push_back(custSoInfo2);

    p->opInfoArgs=reinterpret_cast<uint64_t>(reinterpret_cast<uintptr_t>(v_cust_so.data()));

    uint64_t paramBase = reinterpret_cast<uint64_t>(
                         reinterpret_cast<uintptr_t>(p));
    cceKernel.paramBase = paramBase;
    tsKernelInfo.kernelType = 2;
    tsKernelInfo.kernelBase.cceKernel = cceKernel;

    int retStatus = batch_loadso_from_buffer_kernel_.Compute(tsKernelInfo);
    EXPECT_EQ(retStatus, 0);
    char* curDirName = getenv("HOME");
    std::string dirName(curDirName);
    if (dirName[dirName.size() - 1] != '/') {
        dirName = dirName + "/";
    }
    std::string command = "rm -rf ";
    command = command + dirName + "cust_aicpu_0_3004/libcust_aicpu_kernels.so";
    int ret = system(command.c_str());
    retStatus = delete_custop_kernel_.Compute(tsKernelInfo);
    EXPECT_EQ(retStatus, 0);
    v_cust_so.clear();
    LoadOpFromBufArgs custSoInfo1;
    custSoInfo1.kernelSoBuf=kernelSoBuf;
    custSoInfo1.kernelSoBufLen=kernelSoBufLen;
    custSoInfo1.kernelSoName=kernelSoName;
    custSoInfo1.kernelSoNameLen=0;
    v_cust_so.push_back(custSoInfo1);
    p->soNum=1;
    p->opInfoArgs=reinterpret_cast<uint64_t>(reinterpret_cast<uintptr_t>(v_cust_so.data()));

    uint64_t paramBase2 = reinterpret_cast<uint64_t>(
                         reinterpret_cast<uintptr_t>(p));
    cceKernel.paramBase = paramBase;
    tsKernelInfo.kernelBase.cceKernel = cceKernel;
    retStatus = delete_custop_kernel_.Compute(tsKernelInfo);
    deviceVec[0] = deviceId;
    AicpuDrvManager::GetInstance().InitDrvMgr(deviceVec, hostPid, 0, hasThread);
    free (p);

    command = "rm -rf ";
    command = command + dirName + "cust_aicpu_0_3004";
    system(command.c_str());
    EXPECT_NE(retStatus, AICPU_SCHEDULE_OK);
}

TEST_F(AICPUScheduleInterfaceTEST, TsKernelBatchLoadOpFromBuf_success2)
{
    (void)AicpuCustSoManager::GetInstance().InitAicpuCustSoManager(aicpu::AicpuRunMode::THREAD_MODE,
                                                                   SCHED_MODE_INTERRUPT);
    aicpu::SetHaveCustPid(false);
    MOCKER(CreateOrFindCustPid, int32_t(const uint32_t, const uint32_t, const char * const *,
        const uint32_t, const uint32_t, const char *, const uint32_t, int32_t*, bool*))
        .stubs()
        .will(invoke(CreateOrFindCustPidFailedStub));
    MOCKER_CPP(&AicpuCustSoManager::CreateSoFile)
        .stubs()
        .will(returnValue(AICPU_SCHEDULE_OK));
    std::vector<uint32_t> deviceVec;
    deviceVec.push_back(1);
    AicpuDrvManager::GetInstance().InitDrvMgr(deviceVec, 3005, 0, true);
    aicpu::HwtsTsKernel tsKernelInfo;
    aicpu::HwtsCceKernel cceKernel;
    char kernel_name[] = "batchLoadOpFromBuf";
    uint64_t kernel_name_addr = reinterpret_cast<uint64_t>(
                                reinterpret_cast<uintptr_t>(kernel_name));
    cceKernel.kernelName = kernel_name_addr;

    char soContent[] = "This is test for batchLoadOpFromBuf";
    uint64_t kernelSoBuf = reinterpret_cast<uint64_t>(reinterpret_cast<uintptr_t>
                                                      (soContent));
    uint32_t kernelSoBufLen = strlen(soContent);
    char kernelSoNameContent[] = "libcust_aicpu_kernels.so";
    uint64_t kernelSoName = reinterpret_cast<uint64_t>(reinterpret_cast<uintptr_t>
                                                       (kernelSoNameContent));
    uint32_t kernelSoNameLen = strlen(kernelSoNameContent);

    char soContent2[] = "batchLoadOpFromBuf batchLoadOpFromBuf batchLoadOpFromBuf";
    uint64_t kernelSoBuf2 = reinterpret_cast<uint64_t>(reinterpret_cast<uintptr_t>
                                                      (soContent2));
    uint32_t kernelSoBufLen2 = strlen(soContent2);
    char kernelSoNameContent2[] = "libcust_aicpu_kernels2.so";
    uint64_t kernelSoName2 = reinterpret_cast<uint64_t>(reinterpret_cast<uintptr_t>
                                                       (kernelSoNameContent2));
    uint32_t kernelSoNameLen2 = strlen(kernelSoNameContent2);

    uint32_t num = 2;
    BatchLoadOpFromBufArgs *p=(BatchLoadOpFromBufArgs*)malloc(sizeof(BatchLoadOpFromBufArgs)+sizeof(LoadOpFromBufArgs)*num);
    p->soNum=num;
    std::vector<LoadOpFromBufArgs> v_cust_so;
    LoadOpFromBufArgs custSoInfo;
    custSoInfo.kernelSoBuf=kernelSoBuf;
    custSoInfo.kernelSoBufLen=kernelSoBufLen;
    custSoInfo.kernelSoName=kernelSoName;
    custSoInfo.kernelSoNameLen=kernelSoNameLen;
    v_cust_so.push_back(custSoInfo);
    LoadOpFromBufArgs custSoInfo2;
    custSoInfo2.kernelSoBuf=kernelSoBuf2;
    custSoInfo2.kernelSoBufLen=kernelSoBufLen2;
    custSoInfo2.kernelSoName=kernelSoName2;
    custSoInfo2.kernelSoNameLen=kernelSoNameLen2;
    v_cust_so.push_back(custSoInfo2);

    p->opInfoArgs=reinterpret_cast<uint64_t>(reinterpret_cast<uintptr_t>(v_cust_so.data()));

    uint64_t paramBase = reinterpret_cast<uint64_t>(
                         reinterpret_cast<uintptr_t>(p));
    cceKernel.paramBase = paramBase;
    tsKernelInfo.kernelType = 2;
    tsKernelInfo.kernelBase.cceKernel = cceKernel;

    int retStatus = batch_loadso_from_buffer_kernel_.Compute(tsKernelInfo);

    char* curDirName = getenv("HOME");
    std::string dirName(curDirName);
    if (dirName[dirName.size() - 1] != '/') {
        dirName = dirName + "/";
    }
    std::string command = "rm -rf ";
    command = command + dirName + "cust_aicpu_0_" + std::to_string(static_cast<int32_t>(getpid()));
    int ret = system(command.c_str());
    if (ret != 0) {
        aicpusd_info("Remove directory %s fail", dirName.c_str());
    }
    EXPECT_EQ(retStatus, AICPU_SCHEDULE_OK);
    free (p);
}


TEST_F(AICPUScheduleInterfaceTEST, TsKernelBatchLoadOpFromBuf_fail_queryGrp01)
{
    (void)AicpuCustSoManager::GetInstance().InitAicpuCustSoManager(aicpu::AicpuRunMode::THREAD_MODE,
                                                                   SCHED_MODE_INTERRUPT);
    aicpu::SetHaveCustPid(false);
    MOCKER(CreateOrFindCustPid, int32_t(const uint32_t, const uint32_t, const char * const *,
        const uint32_t, const uint32_t, const char *, const uint32_t, int32_t*, bool*))
        .stubs()
        .will(invoke(CreateOrFindCustPidFailedStub));
    MOCKER(halGrpQuery)
    .stubs()
    .will(returnValue(1));
    MOCKER(halGrpAttach)
    .stubs()
    .will(returnValue(0));
    MOCKER_CPP(&AicpuCustSoManager::CreateSoFile)
        .stubs()
        .will(returnValue(AICPU_SCHEDULE_OK));
    std::vector<uint32_t> deviceVec;
    deviceVec.push_back(1);
    AicpuDrvManager::GetInstance().InitDrvMgr(deviceVec, 3005, 0, true);
    aicpu::HwtsTsKernel tsKernelInfo;
    aicpu::HwtsCceKernel cceKernel;
    char kernel_name[] = "batchLoadOpFromBuf";
    uint64_t kernel_name_addr = reinterpret_cast<uint64_t>(
                                reinterpret_cast<uintptr_t>(kernel_name));
    cceKernel.kernelName = kernel_name_addr;

    char soContent[] = "This is test for batchLoadOpFromBuf";
    uint64_t kernelSoBuf = reinterpret_cast<uint64_t>(reinterpret_cast<uintptr_t>
                                                      (soContent));
    uint32_t kernelSoBufLen = strlen(soContent);
    char kernelSoNameContent[] = "libcust_aicpu_kernels.so";
    uint64_t kernelSoName = reinterpret_cast<uint64_t>(reinterpret_cast<uintptr_t>
                                                       (kernelSoNameContent));
    uint32_t kernelSoNameLen = strlen(kernelSoNameContent);

    char soContent2[] = "batchLoadOpFromBuf batchLoadOpFromBuf batchLoadOpFromBuf";
    uint64_t kernelSoBuf2 = reinterpret_cast<uint64_t>(reinterpret_cast<uintptr_t>
                                                      (soContent2));
    uint32_t kernelSoBufLen2 = strlen(soContent2);
    char kernelSoNameContent2[] = "libcust_aicpu_kernels2.so";
    uint64_t kernelSoName2 = reinterpret_cast<uint64_t>(reinterpret_cast<uintptr_t>
                                                       (kernelSoNameContent2));
    uint32_t kernelSoNameLen2 = strlen(kernelSoNameContent2);

    uint32_t num = 2;
    BatchLoadOpFromBufArgs *p=(BatchLoadOpFromBufArgs*)malloc(sizeof(BatchLoadOpFromBufArgs)+sizeof(LoadOpFromBufArgs)*num);
    p->soNum=num;
    std::vector<LoadOpFromBufArgs> v_cust_so;
    LoadOpFromBufArgs custSoInfo;
    custSoInfo.kernelSoBuf=kernelSoBuf;
    custSoInfo.kernelSoBufLen=kernelSoBufLen;
    custSoInfo.kernelSoName=kernelSoName;
    custSoInfo.kernelSoNameLen=kernelSoNameLen;
    v_cust_so.push_back(custSoInfo);
    LoadOpFromBufArgs custSoInfo2;
    custSoInfo2.kernelSoBuf=kernelSoBuf2;
    custSoInfo2.kernelSoBufLen=kernelSoBufLen2;
    custSoInfo2.kernelSoName=kernelSoName2;
    custSoInfo2.kernelSoNameLen=kernelSoNameLen2;
    v_cust_so.push_back(custSoInfo2);

    p->opInfoArgs=reinterpret_cast<uint64_t>(reinterpret_cast<uintptr_t>(v_cust_so.data()));

    uint64_t paramBase = reinterpret_cast<uint64_t>(
                         reinterpret_cast<uintptr_t>(p));
    cceKernel.paramBase = paramBase;
    tsKernelInfo.kernelType = 2;
    tsKernelInfo.kernelBase.cceKernel = cceKernel;

    int retStatus = batch_loadso_from_buffer_kernel_.Compute(tsKernelInfo);
    char* curDirName = getenv("HOME");
    std::string dirName(curDirName);
    if (dirName[dirName.size() - 1] != '/') {
        dirName = dirName + "/";
    }
    std::string command = "rm -rf ";
    command = command + dirName + "cust_aicpu_0_" + std::to_string(static_cast<int32_t>(getpid()));
    int ret = system(command.c_str());
    if (ret != 0) {
        aicpusd_info("Remove directory %s fail", dirName.c_str());
    }
    EXPECT_EQ(retStatus, AICPU_SCHEDULE_OK);
    free (p);
}


TEST_F(AICPUScheduleInterfaceTEST, TsKernelBatchLoadOpFromBuf_fail_queryGrp02)
{
    (void)AicpuCustSoManager::GetInstance().InitAicpuCustSoManager(aicpu::AicpuRunMode::THREAD_MODE,
                                                                   SCHED_MODE_INTERRUPT);
    aicpu::SetHaveCustPid(false);
    MOCKER(CreateOrFindCustPid, int32_t(const uint32_t, const uint32_t, const char * const *,
        const uint32_t, const uint32_t, const char *, const uint32_t, int32_t*, bool*))
        .stubs()
        .will(invoke(CreateOrFindCustPidFailedStub));
    MOCKER(halGrpQuery)
    .stubs()
    .will(invoke(halGrpQueryWithError));
    MOCKER(halGrpAttach)
    .stubs()
    .will(returnValue(0));
    MOCKER_CPP(&AicpuCustSoManager::CreateSoFile)
        .stubs()
        .will(returnValue(AICPU_SCHEDULE_OK));
    std::vector<uint32_t> deviceVec;
    deviceVec.push_back(1);
    AicpuDrvManager::GetInstance().InitDrvMgr(deviceVec, 3005, 0, true);
    aicpu::HwtsTsKernel tsKernelInfo;
    aicpu::HwtsCceKernel cceKernel;
    char kernel_name[] = "batchLoadOpFromBuf";
    uint64_t kernel_name_addr = reinterpret_cast<uint64_t>(
                                reinterpret_cast<uintptr_t>(kernel_name));
    cceKernel.kernelName = kernel_name_addr;

    char soContent[] = "This is test for batchLoadOpFromBuf";
    uint64_t kernelSoBuf = reinterpret_cast<uint64_t>(reinterpret_cast<uintptr_t>
                                                      (soContent));
    uint32_t kernelSoBufLen = strlen(soContent);
    char kernelSoNameContent[] = "libcust_aicpu_kernels.so";
    uint64_t kernelSoName = reinterpret_cast<uint64_t>(reinterpret_cast<uintptr_t>
                                                       (kernelSoNameContent));
    uint32_t kernelSoNameLen = strlen(kernelSoNameContent);

    char soContent2[] = "batchLoadOpFromBuf batchLoadOpFromBuf batchLoadOpFromBuf";
    uint64_t kernelSoBuf2 = reinterpret_cast<uint64_t>(reinterpret_cast<uintptr_t>
                                                      (soContent2));
    uint32_t kernelSoBufLen2 = strlen(soContent2);
    char kernelSoNameContent2[] = "libcust_aicpu_kernels2.so";
    uint64_t kernelSoName2 = reinterpret_cast<uint64_t>(reinterpret_cast<uintptr_t>
                                                       (kernelSoNameContent2));
    uint32_t kernelSoNameLen2 = strlen(kernelSoNameContent2);

    uint32_t num = 2;
    BatchLoadOpFromBufArgs *p=(BatchLoadOpFromBufArgs*)malloc(sizeof(BatchLoadOpFromBufArgs)+sizeof(LoadOpFromBufArgs)*num);
    p->soNum=num;
    std::vector<LoadOpFromBufArgs> v_cust_so;
    LoadOpFromBufArgs custSoInfo;
    custSoInfo.kernelSoBuf=kernelSoBuf;
    custSoInfo.kernelSoBufLen=kernelSoBufLen;
    custSoInfo.kernelSoName=kernelSoName;
    custSoInfo.kernelSoNameLen=kernelSoNameLen;
    v_cust_so.push_back(custSoInfo);
    LoadOpFromBufArgs custSoInfo2;
    custSoInfo2.kernelSoBuf=kernelSoBuf2;
    custSoInfo2.kernelSoBufLen=kernelSoBufLen2;
    custSoInfo2.kernelSoName=kernelSoName2;
    custSoInfo2.kernelSoNameLen=kernelSoNameLen2;
    v_cust_so.push_back(custSoInfo2);

    p->opInfoArgs=reinterpret_cast<uint64_t>(reinterpret_cast<uintptr_t>(v_cust_so.data()));

    uint64_t paramBase = reinterpret_cast<uint64_t>(
                         reinterpret_cast<uintptr_t>(p));
    cceKernel.paramBase = paramBase;
    tsKernelInfo.kernelType = 2;
    tsKernelInfo.kernelBase.cceKernel = cceKernel;

    int retStatus = batch_loadso_from_buffer_kernel_.Compute(tsKernelInfo);
    char* curDirName = getenv("HOME");
    std::string dirName(curDirName);
    if (dirName[dirName.size() - 1] != '/') {
        dirName = dirName + "/";
    }
    std::string command = "rm -rf ";
    command = command + dirName + "cust_aicpu_0_" + std::to_string(static_cast<int32_t>(getpid()));
    int ret = system(command.c_str());
    if (ret != 0) {
        aicpusd_info("Remove directory %s fail", dirName.c_str());
    }
    EXPECT_EQ(retStatus, AICPU_SCHEDULE_OK);
    free (p);
}

TEST_F(AICPUScheduleInterfaceTEST, TsKernelBatchLoadOpFromBuf_fail_addGrp)
{
    (void)AicpuCustSoManager::GetInstance().InitAicpuCustSoManager(aicpu::AicpuRunMode::THREAD_MODE,
                                                                   SCHED_MODE_INTERRUPT);
    aicpu::SetHaveCustPid(false);
    MOCKER(CreateOrFindCustPid, int32_t(const uint32_t, const uint32_t, const char * const *,
        const uint32_t, const uint32_t, const char *, const uint32_t, int32_t*, bool*))
        .stubs()
        .will(invoke(CreateOrFindCustPidFailedStub));
    MOCKER(halGrpQuery)
    .stubs()
    .will(invoke(halGrpQueryWithTwoGroup));
    MOCKER(halGrpAttach)
    .stubs()
    .will(returnValue(0));
    MOCKER(halGrpAddProc)
    .stubs()
    .will(returnValue(1));
    MOCKER_CPP(&AicpuCustSoManager::CreateSoFile)
        .stubs()
        .will(returnValue(AICPU_SCHEDULE_OK));
    std::vector<uint32_t> deviceVec;
    deviceVec.push_back(1);
    AicpuDrvManager::GetInstance().InitDrvMgr(deviceVec, 3005, 0, true);
    aicpu::HwtsTsKernel tsKernelInfo;
    aicpu::HwtsCceKernel cceKernel;
    char kernel_name[] = "batchLoadOpFromBuf";
    uint64_t kernel_name_addr = reinterpret_cast<uint64_t>(
                                reinterpret_cast<uintptr_t>(kernel_name));
    cceKernel.kernelName = kernel_name_addr;

    char soContent[] = "This is test for batchLoadOpFromBuf";
    uint64_t kernelSoBuf = reinterpret_cast<uint64_t>(reinterpret_cast<uintptr_t>
                                                      (soContent));
    uint32_t kernelSoBufLen = strlen(soContent);
    char kernelSoNameContent[] = "libcust_aicpu_kernels.so";
    uint64_t kernelSoName = reinterpret_cast<uint64_t>(reinterpret_cast<uintptr_t>
                                                       (kernelSoNameContent));
    uint32_t kernelSoNameLen = strlen(kernelSoNameContent);

    char soContent2[] = "batchLoadOpFromBuf batchLoadOpFromBuf batchLoadOpFromBuf";
    uint64_t kernelSoBuf2 = reinterpret_cast<uint64_t>(reinterpret_cast<uintptr_t>
                                                      (soContent2));
    uint32_t kernelSoBufLen2 = strlen(soContent2);
    char kernelSoNameContent2[] = "libcust_aicpu_kernels2.so";
    uint64_t kernelSoName2 = reinterpret_cast<uint64_t>(reinterpret_cast<uintptr_t>
                                                       (kernelSoNameContent2));
    uint32_t kernelSoNameLen2 = strlen(kernelSoNameContent2);

    uint32_t num = 2;
    BatchLoadOpFromBufArgs *p=(BatchLoadOpFromBufArgs*)malloc(sizeof(BatchLoadOpFromBufArgs)+sizeof(LoadOpFromBufArgs)*num);
    p->soNum=num;
    std::vector<LoadOpFromBufArgs> v_cust_so;
    LoadOpFromBufArgs custSoInfo;
    custSoInfo.kernelSoBuf=kernelSoBuf;
    custSoInfo.kernelSoBufLen=kernelSoBufLen;
    custSoInfo.kernelSoName=kernelSoName;
    custSoInfo.kernelSoNameLen=kernelSoNameLen;
    v_cust_so.push_back(custSoInfo);
    LoadOpFromBufArgs custSoInfo2;
    custSoInfo2.kernelSoBuf=kernelSoBuf2;
    custSoInfo2.kernelSoBufLen=kernelSoBufLen2;
    custSoInfo2.kernelSoName=kernelSoName2;
    custSoInfo2.kernelSoNameLen=kernelSoNameLen2;
    v_cust_so.push_back(custSoInfo2);

    p->opInfoArgs=reinterpret_cast<uint64_t>(reinterpret_cast<uintptr_t>(v_cust_so.data()));

    uint64_t paramBase = reinterpret_cast<uint64_t>(
                         reinterpret_cast<uintptr_t>(p));
    cceKernel.paramBase = paramBase;
    tsKernelInfo.kernelType = 2;
    tsKernelInfo.kernelBase.cceKernel = cceKernel;

    int retStatus = batch_loadso_from_buffer_kernel_.Compute(tsKernelInfo);
    char* curDirName = getenv("HOME");
    std::string dirName(curDirName);
    if (dirName[dirName.size() - 1] != '/') {
        dirName = dirName + "/";
    }
    std::string command = "rm -rf ";
    command = command + dirName + "cust_aicpu_0_" + std::to_string(static_cast<int32_t>(getpid()));
    int ret = system(command.c_str());
    if (ret != 0) {
        aicpusd_info("Remove directory %s fail", dirName.c_str());
    }
    EXPECT_EQ(retStatus, AICPU_SCHEDULE_OK);
    free (p);
}

TEST_F(AICPUScheduleInterfaceTEST, TsKernelBatchLoadOpFromBuf_fail_StartCust)
{
    (void)AicpuCustSoManager::GetInstance().InitAicpuCustSoManager(aicpu::AicpuRunMode::THREAD_MODE,
                                                                   SCHED_MODE_INTERRUPT);
    aicpu::SetHaveCustPid(false);
    MOCKER(CreateOrFindCustPid, int32_t(const uint32_t, const uint32_t, const char * const *,
        const uint32_t, const uint32_t, const char *, const uint32_t, int32_t*, bool*))
        .stubs()
        .will(invoke(CreateOrFindCustPidFailedStub2));
    MOCKER(halGrpQuery)
    .stubs()
    .will(invoke(halGrpQueryWithTwoGroup));
    MOCKER(halGrpAttach)
    .stubs()
    .will(returnValue(0));
    MOCKER(halGrpAddProc)
    .stubs()
    .will(returnValue(0));
    MOCKER_CPP(&AicpuCustSoManager::CreateSoFile)
        .stubs()
        .will(returnValue(AICPU_SCHEDULE_OK));
    std::vector<uint32_t> deviceVec;
    deviceVec.push_back(1);
    AicpuDrvManager::GetInstance().InitDrvMgr(deviceVec, 3005, 0, true);
    aicpu::HwtsTsKernel tsKernelInfo;
    aicpu::HwtsCceKernel cceKernel;
    char kernel_name[] = "batchLoadOpFromBuf";
    uint64_t kernel_name_addr = reinterpret_cast<uint64_t>(
                                reinterpret_cast<uintptr_t>(kernel_name));
    cceKernel.kernelName = kernel_name_addr;

    char soContent[] = "This is test for batchLoadOpFromBuf";
    uint64_t kernelSoBuf = reinterpret_cast<uint64_t>(reinterpret_cast<uintptr_t>
                                                      (soContent));
    uint32_t kernelSoBufLen = strlen(soContent);
    char kernelSoNameContent[] = "libcust_aicpu_kernels.so";
    uint64_t kernelSoName = reinterpret_cast<uint64_t>(reinterpret_cast<uintptr_t>
                                                       (kernelSoNameContent));
    uint32_t kernelSoNameLen = strlen(kernelSoNameContent);

    char soContent2[] = "batchLoadOpFromBuf batchLoadOpFromBuf batchLoadOpFromBuf";
    uint64_t kernelSoBuf2 = reinterpret_cast<uint64_t>(reinterpret_cast<uintptr_t>
                                                      (soContent2));
    uint32_t kernelSoBufLen2 = strlen(soContent2);
    char kernelSoNameContent2[] = "libcust_aicpu_kernels2.so";
    uint64_t kernelSoName2 = reinterpret_cast<uint64_t>(reinterpret_cast<uintptr_t>
                                                       (kernelSoNameContent2));
    uint32_t kernelSoNameLen2 = strlen(kernelSoNameContent2);

    uint32_t num = 2;
    BatchLoadOpFromBufArgs *p=(BatchLoadOpFromBufArgs*)malloc(sizeof(BatchLoadOpFromBufArgs)+sizeof(LoadOpFromBufArgs)*num);
    p->soNum=num;
    std::vector<LoadOpFromBufArgs> v_cust_so;
    LoadOpFromBufArgs custSoInfo;
    custSoInfo.kernelSoBuf=kernelSoBuf;
    custSoInfo.kernelSoBufLen=kernelSoBufLen;
    custSoInfo.kernelSoName=kernelSoName;
    custSoInfo.kernelSoNameLen=kernelSoNameLen;
    v_cust_so.push_back(custSoInfo);
    LoadOpFromBufArgs custSoInfo2;
    custSoInfo2.kernelSoBuf=kernelSoBuf2;
    custSoInfo2.kernelSoBufLen=kernelSoBufLen2;
    custSoInfo2.kernelSoName=kernelSoName2;
    custSoInfo2.kernelSoNameLen=kernelSoNameLen2;
    v_cust_so.push_back(custSoInfo2);

    p->opInfoArgs=reinterpret_cast<uint64_t>(reinterpret_cast<uintptr_t>(v_cust_so.data()));

    uint64_t paramBase = reinterpret_cast<uint64_t>(
                         reinterpret_cast<uintptr_t>(p));
    cceKernel.paramBase = paramBase;
    tsKernelInfo.kernelType = 2;
    tsKernelInfo.kernelBase.cceKernel = cceKernel;

    int retStatus = batch_loadso_from_buffer_kernel_.Compute(tsKernelInfo);
    char* curDirName = getenv("HOME");
    std::string dirName(curDirName);
    if (dirName[dirName.size() - 1] != '/') {
        dirName = dirName + "/";
    }
    std::string command = "rm -rf ";
    command = command + dirName + "cust_aicpu_0_" + std::to_string(static_cast<int32_t>(getpid()));
    int ret = system(command.c_str());
    if (ret != 0) {
        aicpusd_info("Remove directory %s fail", dirName.c_str());
    }
    EXPECT_EQ(retStatus, AICPU_SCHEDULE_OK);
    free (p);
}

TEST_F(AICPUScheduleInterfaceTEST, TsKernelBatchLoadOpFromBuf_succ_StartCust)
{
    (void)AicpuCustSoManager::GetInstance().InitAicpuCustSoManager(aicpu::AicpuRunMode::THREAD_MODE,
                                                                   SCHED_MODE_INTERRUPT);
    aicpu::SetHaveCustPid(false);
    MOCKER(CreateOrFindCustPid, int32_t(const uint32_t, const uint32_t, const char * const *,
        const uint32_t, const uint32_t, const char *, const uint32_t, int32_t*, bool*))
        .stubs()
        .will(invoke(CreateOrFindCustPidStubExist));
    MOCKER(halGrpQuery)
    .stubs()
    .will(invoke(halGrpQueryWithTwoGroup));
    MOCKER(halGrpAttach)
    .stubs()
    .will(returnValue(0));
    MOCKER(halGrpAddProc)
    .stubs()
    .will(returnValue(0));
    MOCKER_CPP(&AicpuCustSoManager::CreateSoFile)
        .stubs()
        .will(returnValue(AICPU_SCHEDULE_OK));
    std::vector<uint32_t> deviceVec;
    deviceVec.push_back(1);
    AicpuDrvManager::GetInstance().InitDrvMgr(deviceVec, 3005, 0, true);
    aicpu::HwtsTsKernel tsKernelInfo;
    aicpu::HwtsCceKernel cceKernel;
    char kernel_name[] = "batchLoadOpFromBuf";
    uint64_t kernel_name_addr = reinterpret_cast<uint64_t>(
                                reinterpret_cast<uintptr_t>(kernel_name));
    cceKernel.kernelName = kernel_name_addr;

    char soContent[] = "This is test for batchLoadOpFromBuf";
    uint64_t kernelSoBuf = reinterpret_cast<uint64_t>(reinterpret_cast<uintptr_t>
                                                      (soContent));
    uint32_t kernelSoBufLen = strlen(soContent);
    char kernelSoNameContent[] = "libcust_aicpu_kernels.so";
    uint64_t kernelSoName = reinterpret_cast<uint64_t>(reinterpret_cast<uintptr_t>
                                                       (kernelSoNameContent));
    uint32_t kernelSoNameLen = strlen(kernelSoNameContent);

    char soContent2[] = "batchLoadOpFromBuf batchLoadOpFromBuf batchLoadOpFromBuf";
    uint64_t kernelSoBuf2 = reinterpret_cast<uint64_t>(reinterpret_cast<uintptr_t>
                                                      (soContent2));
    uint32_t kernelSoBufLen2 = strlen(soContent2);
    char kernelSoNameContent2[] = "libcust_aicpu_kernels2.so";
    uint64_t kernelSoName2 = reinterpret_cast<uint64_t>(reinterpret_cast<uintptr_t>
                                                       (kernelSoNameContent2));
    uint32_t kernelSoNameLen2 = strlen(kernelSoNameContent2);

    uint32_t num = 2;
    BatchLoadOpFromBufArgs *p=(BatchLoadOpFromBufArgs*)malloc(sizeof(BatchLoadOpFromBufArgs)+sizeof(LoadOpFromBufArgs)*num);
    p->soNum=num;
    std::vector<LoadOpFromBufArgs> v_cust_so;
    LoadOpFromBufArgs custSoInfo;
    custSoInfo.kernelSoBuf=kernelSoBuf;
    custSoInfo.kernelSoBufLen=kernelSoBufLen;
    custSoInfo.kernelSoName=kernelSoName;
    custSoInfo.kernelSoNameLen=kernelSoNameLen;
    v_cust_so.push_back(custSoInfo);
    LoadOpFromBufArgs custSoInfo2;
    custSoInfo2.kernelSoBuf=kernelSoBuf2;
    custSoInfo2.kernelSoBufLen=kernelSoBufLen2;
    custSoInfo2.kernelSoName=kernelSoName2;
    custSoInfo2.kernelSoNameLen=kernelSoNameLen2;
    v_cust_so.push_back(custSoInfo2);

    p->opInfoArgs=reinterpret_cast<uint64_t>(reinterpret_cast<uintptr_t>(v_cust_so.data()));

    uint64_t paramBase = reinterpret_cast<uint64_t>(
                         reinterpret_cast<uintptr_t>(p));
    cceKernel.paramBase = paramBase;
    tsKernelInfo.kernelType = 2;
    tsKernelInfo.kernelBase.cceKernel = cceKernel;

    int retStatus = batch_loadso_from_buffer_kernel_.Compute(tsKernelInfo);
    char* curDirName = getenv("HOME");
    std::string dirName(curDirName);
    if (dirName[dirName.size() - 1] != '/') {
        dirName = dirName + "/";
    }
    std::string command = "rm -rf ";
    command = command + dirName + "cust_aicpu_0_" + std::to_string(static_cast<int32_t>(getpid()));
    int ret = system(command.c_str());
    if (ret != 0) {
        aicpusd_info("Remove directory %s fail", dirName.c_str());
    }
    EXPECT_EQ(retStatus, AICPU_SCHEDULE_OK);
    free (p);
}

TEST_F(AICPUScheduleInterfaceTEST, TsKernelBatchLoadOpFromBuf_failed6)
{
    (void)AicpuCustSoManager::GetInstance().InitAicpuCustSoManager(aicpu::AicpuRunMode::THREAD_MODE,
                                                                   SCHED_MODE_INTERRUPT);
    aicpu::SetHaveCustPid(false);
    MOCKER_CPP(&AicpuCustSoManager::CreateSoFile)
        .stubs()
        .will(returnValue(AICPU_SCHEDULE_ERROR_INNER_ERROR));
    std::vector<uint32_t> deviceVec;
    deviceVec.push_back(1);
    AicpuDrvManager::GetInstance().InitDrvMgr(deviceVec, 3006, 0, true);
    aicpu::HwtsTsKernel tsKernelInfo;
    aicpu::HwtsCceKernel cceKernel;
    char kernel_name[] = "batchLoadOpFromBuf";
    uint64_t kernel_name_addr = reinterpret_cast<uint64_t>(
                                reinterpret_cast<uintptr_t>(kernel_name));
    cceKernel.kernelName = kernel_name_addr;

    char soContent[] = "This is test for batchLoadOpFromBuf";
    uint64_t kernelSoBuf = reinterpret_cast<uint64_t>(reinterpret_cast<uintptr_t>
                                                      (soContent));
    uint32_t kernelSoBufLen = strlen(soContent);
    char kernelSoNameContent[] = "libcust_aicpu_kernels.so";
    uint64_t kernelSoName = reinterpret_cast<uint64_t>(reinterpret_cast<uintptr_t>
                                                       (kernelSoNameContent));
    uint32_t kernelSoNameLen = strlen(kernelSoNameContent);

    char soContent2[] = "batchLoadOpFromBuf batchLoadOpFromBuf batchLoadOpFromBuf";
    uint64_t kernelSoBuf2 = reinterpret_cast<uint64_t>(reinterpret_cast<uintptr_t>
                                                      (soContent2));
    uint32_t kernelSoBufLen2 = strlen(soContent2);
    char kernelSoNameContent2[] = "libcust_aicpu_kernels2.so";
    uint64_t kernelSoName2 = reinterpret_cast<uint64_t>(reinterpret_cast<uintptr_t>
                                                       (kernelSoNameContent2));
    uint32_t kernelSoNameLen2 = strlen(kernelSoNameContent2);

    uint32_t num = 2;
    BatchLoadOpFromBufArgs *p=(BatchLoadOpFromBufArgs*)malloc(sizeof(BatchLoadOpFromBufArgs)+sizeof(LoadOpFromBufArgs)*num);
    p->soNum=num;
    std::vector<LoadOpFromBufArgs> v_cust_so;
    LoadOpFromBufArgs custSoInfo;
    custSoInfo.kernelSoBuf=kernelSoBuf;
    custSoInfo.kernelSoBufLen=kernelSoBufLen;
    custSoInfo.kernelSoName=kernelSoName;
    custSoInfo.kernelSoNameLen=kernelSoNameLen;
    v_cust_so.push_back(custSoInfo);
    LoadOpFromBufArgs custSoInfo2;
    custSoInfo2.kernelSoBuf=kernelSoBuf2;
    custSoInfo2.kernelSoBufLen=kernelSoBufLen2;
    custSoInfo2.kernelSoName=kernelSoName2;
    custSoInfo2.kernelSoNameLen=kernelSoNameLen2;
    v_cust_so.push_back(custSoInfo2);

    p->opInfoArgs=reinterpret_cast<uint64_t>(reinterpret_cast<uintptr_t>(v_cust_so.data()));

    uint64_t paramBase = reinterpret_cast<uint64_t>(
                         reinterpret_cast<uintptr_t>(p));
    cceKernel.paramBase = paramBase;
    tsKernelInfo.kernelType = 2;
    tsKernelInfo.kernelBase.cceKernel = cceKernel;

    int retStatus = batch_loadso_from_buffer_kernel_.Compute(tsKernelInfo);
    free (p);
    EXPECT_NE(retStatus, AICPU_SCHEDULE_OK);
}

TEST_F(AICPUScheduleInterfaceTEST, TsKernelBatchLoadOpFromBuf_failed7)
{
    (void)AicpuCustSoManager::GetInstance().InitAicpuCustSoManager(aicpu::AicpuRunMode::THREAD_MODE,
                                                                   SCHED_MODE_INTERRUPT);
    aicpu::SetHaveCustPid(false);
    aicpu::HwtsTsKernel tsKernelInfo;
    aicpu::HwtsCceKernel cceKernel;
    char kernel_name[] = "batchLoadOpFromBuf";
    uint64_t kernel_name_addr = reinterpret_cast<uint64_t>(
                                reinterpret_cast<uintptr_t>(kernel_name));
    cceKernel.kernelName = kernel_name_addr;

    char soContent[] = "This is test for batchLoadOpFromBuf";
    uint64_t kernelSoBuf = reinterpret_cast<uint64_t>(reinterpret_cast<uintptr_t>
                                                      (soContent));
    uint32_t kernelSoBufLen = strlen(soContent);
    char kernelSoNameContent[] = "libcust_aicpu_kernels.so";
    uint64_t kernelSoName = reinterpret_cast<uint64_t>(reinterpret_cast<uintptr_t>
                                                       (kernelSoNameContent));
    uint32_t kernelSoNameLen = strlen(kernelSoNameContent);

    char soContent2[] = "batchLoadOpFromBuf batchLoadOpFromBuf batchLoadOpFromBuf";
    uint64_t kernelSoBuf2 = reinterpret_cast<uint64_t>(reinterpret_cast<uintptr_t>
                                                      (soContent2));
    uint32_t kernelSoBufLen2 = strlen(soContent2);
    char kernelSoNameContent2[] = "libcust_aicpu_kernels2.so";
    uint64_t kernelSoName2 = reinterpret_cast<uint64_t>(reinterpret_cast<uintptr_t>
                                                       (kernelSoNameContent2));
    uint32_t kernelSoNameLen2 = strlen(kernelSoNameContent2);

    uint32_t num = 0;
    BatchLoadOpFromBufArgs *p=(BatchLoadOpFromBufArgs*)malloc(sizeof(BatchLoadOpFromBufArgs)+sizeof(LoadOpFromBufArgs)*num);
    p->soNum=num;
    std::vector<LoadOpFromBufArgs> v_cust_so;
    LoadOpFromBufArgs custSoInfo;
    custSoInfo.kernelSoBuf=kernelSoBuf;
    custSoInfo.kernelSoBufLen=kernelSoBufLen;
    custSoInfo.kernelSoName=kernelSoName;
    custSoInfo.kernelSoNameLen=kernelSoNameLen;
    v_cust_so.push_back(custSoInfo);
    p->opInfoArgs=reinterpret_cast<uint64_t>(reinterpret_cast<uintptr_t>(v_cust_so.data()));

    uint64_t paramBase = reinterpret_cast<uint64_t>(
                         reinterpret_cast<uintptr_t>(p));
    cceKernel.paramBase = paramBase;
    tsKernelInfo.kernelType = 2;
    tsKernelInfo.kernelBase.cceKernel = cceKernel;

    int retStatus = batch_loadso_from_buffer_kernel_.Compute(tsKernelInfo);
    free (p);
    EXPECT_EQ(retStatus, AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID);
}

TEST_F(AICPUScheduleInterfaceTEST, TsKernelBatchLoadOpFromBuf_success3)
{
   MOCKER(halGrpQuery)
    .stubs()
    .will(invoke(halGrpQueryWithTwoGroup));
    MOCKER(halGrpAttach)
    .stubs()
    .will(returnValue(0));
    MOCKER(CreateOrFindCustPid, int32_t(const uint32_t, const uint32_t, const char * const *,
        const uint32_t, const uint32_t, const char *, const uint32_t, int32_t*, bool*))
        .stubs()
        .will(invoke(CreateOrFindCustPidStub));
    std::vector<uint32_t> deviceVec;
    deviceVec.push_back(1);
    AicpuDrvManager::GetInstance().InitDrvMgr(deviceVec, 3006, 0, true);
    (void)AicpuCustSoManager::GetInstance().InitAicpuCustSoManager(aicpu::AicpuRunMode::THREAD_MODE,
                                                                   SCHED_MODE_INTERRUPT);
    aicpu::HwtsTsKernel tsKernelInfo;
    aicpu::HwtsCceKernel cceKernel;
    char kernel_name[] = "batchLoadOpFromBuf";
    uint64_t kernel_name_addr = reinterpret_cast<uint64_t>(
                                reinterpret_cast<uintptr_t>(kernel_name));
    cceKernel.kernelName = kernel_name_addr;

    char soContent[] = "This is test for batchLoadOpFromBuf";
    uint64_t kernelSoBuf = reinterpret_cast<uint64_t>(reinterpret_cast<uintptr_t>
                                                      (soContent));
    uint32_t kernelSoBufLen = strlen(soContent);
    char kernelSoNameContent[] = "libcust_aicpu_kernels.so";
    uint64_t kernelSoName = reinterpret_cast<uint64_t>(reinterpret_cast<uintptr_t>
                                                       (kernelSoNameContent));
    uint32_t kernelSoNameLen = strlen(kernelSoNameContent);

    char soContent2[] = "batchLoadOpFromBuf batchLoadOpFromBuf batchLoadOpFromBuf";
    uint64_t kernelSoBuf2 = reinterpret_cast<uint64_t>(reinterpret_cast<uintptr_t>
                                                      (soContent2));
    uint32_t kernelSoBufLen2 = strlen(soContent2);
    char kernelSoNameContent2[] = "libcust_aicpu_kernels2.so";
    uint64_t kernelSoName2 = reinterpret_cast<uint64_t>(reinterpret_cast<uintptr_t>
                                                       (kernelSoNameContent2));
    uint32_t kernelSoNameLen2 = strlen(kernelSoNameContent2);

    uint32_t num = 2;
    BatchLoadOpFromBufArgs *p=(BatchLoadOpFromBufArgs*)malloc(sizeof(BatchLoadOpFromBufArgs)+sizeof(LoadOpFromBufArgs)*num);
    p->soNum=num;
    std::vector<LoadOpFromBufArgs> v_cust_so;
    LoadOpFromBufArgs custSoInfo;
    custSoInfo.kernelSoBuf=kernelSoBuf;
    custSoInfo.kernelSoBufLen=kernelSoBufLen;
    custSoInfo.kernelSoName=kernelSoName;
    custSoInfo.kernelSoNameLen=kernelSoNameLen;
    v_cust_so.push_back(custSoInfo);
    LoadOpFromBufArgs custSoInfo2;
    custSoInfo2.kernelSoBuf=kernelSoBuf2;
    custSoInfo2.kernelSoBufLen=kernelSoBufLen2;
    custSoInfo2.kernelSoName=kernelSoName2;
    custSoInfo2.kernelSoNameLen=kernelSoNameLen2;
    v_cust_so.push_back(custSoInfo2);

    p->opInfoArgs=reinterpret_cast<uint64_t>(reinterpret_cast<uintptr_t>(v_cust_so.data()));

    uint64_t paramBase = reinterpret_cast<uint64_t>(
                         reinterpret_cast<uintptr_t>(p));
    cceKernel.paramBase = paramBase;
    tsKernelInfo.kernelType = 2;
    tsKernelInfo.kernelBase.cceKernel = cceKernel;

    char* curDirName = getenv("HOME");
    std::string dirName(curDirName);
    if (dirName[dirName.size() - 1] != '/') {
        dirName = dirName + "/";
    }

    MOCKER_CPP(&AicpuCustSoManager::CreateSoFile)
        .stubs()
        .will(returnValue(AICPU_SCHEDULE_OK));

    int retStatus = batch_loadso_from_buffer_kernel_.Compute(tsKernelInfo);
    EXPECT_EQ(retStatus, AICPU_SCHEDULE_OK);

    std::string command = "rm -rf ";
    command = command + dirName + "cust_aicpu_0_3006";
    int ret = system(command.c_str());
    free (p);
}

TEST_F(AICPUScheduleInterfaceTEST, TsKernelBatchLoadOpFromBufNotSupport)
{
    std::vector<uint32_t> deviceVec = {1};
    AicpuDrvManager::GetInstance().InitDrvMgr(deviceVec, 3006, 0, true);
    (void)AicpuCustSoManager::GetInstance().InitAicpuCustSoManager(aicpu::AicpuRunMode::THREAD_MODE,
                                                                   SCHED_MODE_MSGQ);
    aicpu::HwtsTsKernel tsKernelInfo;
    aicpu::HwtsCceKernel cceKernel;
    char kernel_name[] = "batchLoadOpFromBuf";
    uint64_t kernel_name_addr = reinterpret_cast<uint64_t>(reinterpret_cast<uintptr_t>(kernel_name));
    cceKernel.kernelName = kernel_name_addr;

    tsKernelInfo.kernelType = 2;
    tsKernelInfo.kernelBase.cceKernel = cceKernel;

    int retStatus = batch_loadso_from_buffer_kernel_.Compute(tsKernelInfo);
    EXPECT_EQ(retStatus, AICPU_SCHEDULE_ERROR_INNER_ERROR);
}

TEST_F(AICPUScheduleInterfaceTEST, TsKernelDeleteCustOp_fail1)
{
    std::vector<uint32_t> deviceVec;
    deviceVec.push_back(1);
    AicpuDrvManager::GetInstance().InitDrvMgr(deviceVec, 3006, 0, true);
    (void)AicpuCustSoManager::GetInstance().InitAicpuCustSoManager(aicpu::AicpuRunMode::THREAD_MODE,
                                                                   SCHED_MODE_INTERRUPT);
    aicpu::HwtsTsKernel tsKernelInfo;
    aicpu::HwtsCceKernel cceKernel;
    char kernel_name[] = "deleteCustOp";
    uint64_t kernel_name_addr = reinterpret_cast<uint64_t>(
                                reinterpret_cast<uintptr_t>(kernel_name));
    cceKernel.kernelName = kernel_name_addr;

    char soContent[] = "This is test for deleteCustOp";
    uint64_t kernelSoBuf = reinterpret_cast<uint64_t>(reinterpret_cast<uintptr_t>
                                                      (soContent));
    uint32_t kernelSoBufLen = strlen(soContent);
    char kernelSoNameContent[] = "libcust_aicpu_kernels.so";
    uint64_t kernelSoName = reinterpret_cast<uint64_t>(reinterpret_cast<uintptr_t>
                                                       (kernelSoNameContent));
    uint32_t kernelSoNameLen = strlen(kernelSoNameContent);

    char soContent2[] = "deleteCustOp deleteCustOp deleteCustOp";
    uint64_t kernelSoBuf2 = reinterpret_cast<uint64_t>(reinterpret_cast<uintptr_t>
                                                      (soContent2));
    uint32_t kernelSoBufLen2 = strlen(soContent2);
    char kernelSoNameContent2[] = "../../libcust_aicpu_kernels2.so";
    uint64_t kernelSoName2 = reinterpret_cast<uint64_t>(reinterpret_cast<uintptr_t>
                                                       (kernelSoNameContent2));
    uint32_t kernelSoNameLen2 = strlen(kernelSoNameContent2);

    uint32_t num = 2;
    BatchLoadOpFromBufArgs *p=(BatchLoadOpFromBufArgs*)malloc(sizeof(BatchLoadOpFromBufArgs)+sizeof(LoadOpFromBufArgs)*num);
    p->soNum=num;
    std::vector<LoadOpFromBufArgs> v_cust_so;
    LoadOpFromBufArgs custSoInfo;
    custSoInfo.kernelSoBuf=kernelSoBuf;
    custSoInfo.kernelSoBufLen=kernelSoBufLen;
    custSoInfo.kernelSoName=kernelSoName;
    custSoInfo.kernelSoNameLen=kernelSoNameLen;
    v_cust_so.push_back(custSoInfo);
    LoadOpFromBufArgs custSoInfo2;
    custSoInfo2.kernelSoBuf=kernelSoBuf2;
    custSoInfo2.kernelSoBufLen=kernelSoBufLen2;
    custSoInfo2.kernelSoName=kernelSoName2;
    custSoInfo2.kernelSoNameLen=kernelSoNameLen2;
    v_cust_so.push_back(custSoInfo2);

    p->opInfoArgs=reinterpret_cast<uint64_t>(reinterpret_cast<uintptr_t>(v_cust_so.data()));

    uint64_t paramBase = reinterpret_cast<uint64_t>(
                         reinterpret_cast<uintptr_t>(p));
    cceKernel.paramBase = paramBase;
    tsKernelInfo.kernelType = 2;
    tsKernelInfo.kernelBase.cceKernel = cceKernel;

    char* curDirName = getenv("HOME");
    std::string dirName(curDirName);
    if (dirName[dirName.size() - 1] != '/') {
        dirName = dirName + "/";
    }
    int retStatus = delete_custop_kernel_.Compute(tsKernelInfo);
    free (p);
    EXPECT_EQ(retStatus, AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID);
}

TEST_F(AICPUScheduleInterfaceTEST, TsKernelDeleteCustOp_fail2)
{
    std::vector<uint32_t> deviceVec;
    deviceVec.push_back(1);
    AicpuDrvManager::GetInstance().InitDrvMgr(deviceVec, 3006, 0, true);
    (void)AicpuCustSoManager::GetInstance().InitAicpuCustSoManager(aicpu::AicpuRunMode::THREAD_MODE,
                                                                   SCHED_MODE_INTERRUPT);
    aicpu::HwtsTsKernel tsKernelInfo;
    aicpu::HwtsCceKernel cceKernel;
    char kernel_name[] = "deleteCustOp";
    uint64_t kernel_name_addr = reinterpret_cast<uint64_t>(
                                reinterpret_cast<uintptr_t>(kernel_name));
    cceKernel.kernelName = kernel_name_addr;

    uint32_t num = 0;
    BatchLoadOpFromBufArgs *p=(BatchLoadOpFromBufArgs*)malloc(sizeof(BatchLoadOpFromBufArgs)+sizeof(LoadOpFromBufArgs)*num);
    p->soNum = num;
    p->opInfoArgs = 0;

    uint64_t paramBase = reinterpret_cast<uint64_t>(
                         reinterpret_cast<uintptr_t>(p));
    cceKernel.paramBase = paramBase;
    tsKernelInfo.kernelType = 2;
    tsKernelInfo.kernelBase.cceKernel = cceKernel;

    char* curDirName = getenv("HOME");
    std::string dirName(curDirName);
    if (dirName[dirName.size() - 1] != '/') {
        dirName = dirName + "/";
    }
    int retStatus = delete_custop_kernel_.Compute(tsKernelInfo);
    free (p);
    EXPECT_EQ(retStatus, AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID);
}

TEST_F(AICPUScheduleInterfaceTEST, TsKernelDeleteCustOp_fail3)
{
    std::vector<uint32_t> deviceVec = {1};
    AicpuDrvManager::GetInstance().InitDrvMgr(deviceVec, 3006, 0, true);
    (void)AicpuCustSoManager::GetInstance().InitAicpuCustSoManager(aicpu::AicpuRunMode::THREAD_MODE,
                                                                   SCHED_MODE_MSGQ);
    aicpu::HwtsTsKernel tsKernelInfo;
    aicpu::HwtsCceKernel cceKernel;
    char kernel_name[] = "deleteCustOp";
    uint64_t kernel_name_addr = reinterpret_cast<uint64_t>(reinterpret_cast<uintptr_t>(kernel_name));
    cceKernel.kernelName = kernel_name_addr;

    cceKernel.paramBase = 0;
    tsKernelInfo.kernelType = 2;
    tsKernelInfo.kernelBase.cceKernel = cceKernel;

    int retStatus = delete_custop_kernel_.Compute(tsKernelInfo);
    EXPECT_EQ(retStatus, AICPU_SCHEDULE_ERROR_INNER_ERROR);
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
    modeInfo.flag = 1;
    event.para.modeInfo = modeInfo;
    int ret = AicpuEventProcess::GetInstance().AICPUEventUpdateProfilingMode(event);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
}

TEST_F(AICPUScheduleInterfaceTEST, AICPUEventEndGraph01)
{
    AICPUSubEventInfo event;
    AICPUEndGraphInfo endGraphInfo;
    endGraphInfo.result = 1;
    event.para.endGraphInfo = endGraphInfo;
    event.modelId = 0;
    int ret = AicpuEventProcess::GetInstance().AICPUEventEndGraph(event);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_MODEL_NOT_FOUND);
}


TEST_F(AICPUScheduleInterfaceTEST, AICPUEventEndGraph02) {
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
    int32_t ret = AicpuEventProcess::GetInstance().AICPUEventEndGraph(event);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_MODEL_NOT_FOUND);
}

TEST_F(AICPUScheduleInterfaceTEST, TsKernelRecordNotifyHasWait)
{
    AicpuModel *aicpuModel = nullptr;
    MOCKER_CPP(&AicpuModelManager::GetModel).stubs().will(returnValue(aicpuModel));
    MOCKER_CPP(&ModelStreamManager::GetStreamModelId).stubs().will(returnValue(AICPU_SCHEDULE_OK));

    aicpu::HwtsTsKernel tsKernelInfo = {};
    aicpu::HwtsCceKernel cceKernel = {};
    TsAicpuNotify notifyInfo = {};
    notifyInfo.notify_id = 159;
    cceKernel.paramBase = (uint64_t)&notifyInfo;
    tsKernelInfo.kernelBase.cceKernel = cceKernel;
    const uint32_t waitStreamId = 160U;
    bool needWait = true;
    EventWaitManager::NotifyWaitManager().WaitEvent(notifyInfo.notify_id, waitStreamId, needWait);
    int ret = record_notify_kernel_.Compute(tsKernelInfo);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
}

TEST_F(AICPUScheduleInterfaceTEST, TsKernelRecordNotify)
{
    AicpuModel *aicpuModel = nullptr;
    MOCKER_CPP(&AicpuModelManager::GetModel).stubs().will(returnValue(aicpuModel));

    aicpu::HwtsTsKernel tsKernelInfo;
    aicpu::HwtsCceKernel cceKernel;
    int modelId = 1;
    cceKernel.paramBase = (uint64_t)&modelId;
    tsKernelInfo.kernelBase.cceKernel = cceKernel;
    int ret = record_notify_kernel_.Compute(tsKernelInfo);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
}

TEST_F(AICPUScheduleInterfaceTEST, TsKernelRecordNotifySucc)
{
    aicpu::HwtsTsKernel tsKernelInfo;
    aicpu::HwtsCceKernel cceKernel;
    int notifyId = 1;
    uint32_t waitStreamId = 11;
    bool needWait = false;
    cceKernel.paramBase = (uint64_t)&notifyId;
    tsKernelInfo.kernelBase.cceKernel = cceKernel;
    const auto info = reinterpret_cast<TsAicpuNotify *>(static_cast<uintptr_t>(
            tsKernelInfo.kernelBase.cceKernel.paramBase));
    EventWaitManager::NotifyWaitManager().WaitEvent(static_cast<size_t>(info->notify_id), waitStreamId, needWait);
    MOCKER_CPP(&ModelStreamManager::GetInstance().GetStreamModelId).stubs().will(returnValue(0));
    MOCKER_CPP(&AicpuMsgSend::SendAICPUSubEvent).stubs().will(returnValue(0));
    int ret = record_notify_kernel_.Compute(tsKernelInfo);
    
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
}

TEST_F(AICPUScheduleInterfaceTEST, TsKernelCreateQueue_success) {
    aicpu::HwtsTsKernel tsKernelInfo;
    aicpu::HwtsCceKernel cceKernel;
    const uint32_t len =  sizeof(aicpu::AicpuParamHead) + sizeof(uint64_t) + QUEUE_MAX_STR_LEN + sizeof(uint32_t);
    char args[len] = {};
    aicpu::AicpuParamHead *paramHead = reinterpret_cast<aicpu::AicpuParamHead *>(args);
    paramHead->length = len;
    char *p = args + sizeof(aicpu::AicpuParamHead);
    uint64_t *qidAddr = (uint64_t *)p;
    uint32_t qid = 1;
    *qidAddr = (uint64_t)&qid;
    p += sizeof(uint64_t);
    memcpy(p, "test_queue", 10);
    p += QUEUE_MAX_STR_LEN;
    uint32_t *qDepth = (uint32_t *)p;
    *qDepth = 8;
    cceKernel.paramBase = (uint64_t)args;
    tsKernelInfo.kernelBase.cceKernel = cceKernel;
    int ret = create_queue_kernel_.Compute(tsKernelInfo);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
}

TEST_F(AICPUScheduleInterfaceTEST, TsKernelCreateQueue_fail) {
    MOCKER_CPP(&CreateQueueTsKernel::CreateGrp)
        .stubs()
        .will(returnValue(1));
    aicpu::HwtsTsKernel tsKernelInfo;
    aicpu::HwtsCceKernel cceKernel;
    const uint32_t len =  sizeof(aicpu::AicpuParamHead) + sizeof(uint64_t) + QUEUE_MAX_STR_LEN + sizeof(uint32_t);
    char args[len] = {};
    aicpu::AicpuParamHead *paramHead = reinterpret_cast<aicpu::AicpuParamHead *>(args);
    paramHead->length = len;
    char *p = args + sizeof(aicpu::AicpuParamHead);
    uint64_t *qidAddr = (uint64_t *)p;
    uint32_t qid = 1;
    *qidAddr = (uint64_t)&qid;
    p += sizeof(uint64_t);
    memcpy(p, "test_queue", 10);
    p += QUEUE_MAX_STR_LEN;
    uint32_t *qDepth = (uint32_t *)p;
    *qDepth = 8;
    cceKernel.paramBase = (uint64_t)args;
    tsKernelInfo.kernelBase.cceKernel = cceKernel;
    int ret = create_queue_kernel_.Compute(tsKernelInfo);
    EXPECT_NE(ret, AICPU_SCHEDULE_OK);
}

TEST_F(AICPUScheduleInterfaceTEST, TsKernelDestroyQueue_success) {
    aicpu::HwtsTsKernel tsKernelInfo;
    aicpu::HwtsCceKernel cceKernel;
    const uint32_t len =  sizeof(aicpu::AicpuParamHead) + sizeof(uint32_t);
    char args[len] = {};
    aicpu::AicpuParamHead *paramHead = reinterpret_cast<aicpu::AicpuParamHead *>(args);
    paramHead->length = len;
    char *p = args + sizeof(aicpu::AicpuParamHead);
    uint32_t qid = 1;
    p = (char *)&qid;
    cceKernel.paramBase = (uint64_t)args;
    tsKernelInfo.kernelBase.cceKernel = cceKernel;
    int ret = destroy_queue_kernel_.Compute(tsKernelInfo);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
}

TEST_F(AICPUScheduleInterfaceTEST, TsKernelDestroyQueue_failed) {
    aicpu::HwtsTsKernel tsKernelInfo;
    aicpu::HwtsCceKernel cceKernel;
    cceKernel.paramBase = 0;
    tsKernelInfo.kernelBase.cceKernel = cceKernel;
    int ret = destroy_queue_kernel_.Compute(tsKernelInfo);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID);
}

TEST_F(AICPUScheduleInterfaceTEST, TsKernelDestroyQueue_failed2) {
    aicpu::HwtsTsKernel tsKernelInfo;
    aicpu::HwtsCceKernel cceKernel;
    const uint32_t len =  sizeof(aicpu::AicpuParamHead) + sizeof(uint32_t) + 100;
    char args[len] = {};
    aicpu::AicpuParamHead *paramHead = reinterpret_cast<aicpu::AicpuParamHead *>(args);
    paramHead->length = len;
    cceKernel.paramBase = (uint64_t)args;
    tsKernelInfo.kernelBase.cceKernel = cceKernel;
    int ret = destroy_queue_kernel_.Compute(tsKernelInfo);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID);
}

TEST_F(AICPUScheduleInterfaceTEST, Resubscribe_success) {
    int32_t ret = create_queue_kernel_.Resubscribe(0, 0);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
}

TEST_F(AICPUScheduleInterfaceTEST, Resubscribe_failed) {
    MOCKER(halQueueUnsubscribe).stubs().will(returnValue(200));
    int32_t ret = create_queue_kernel_.Resubscribe(0, 0);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_DRV_ERR);
}

TEST_F(AICPUScheduleInterfaceTEST, Resubscribe_failed2) {
    MOCKER(halQueueSubscribe).stubs().will(returnValue(200));
    int32_t ret = create_queue_kernel_.Resubscribe(0, 0);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_DRV_ERR);
}

TEST_F(AICPUScheduleInterfaceTEST, ResubscribeF2NF_success) {
    int32_t ret = create_queue_kernel_.ResubscribeF2NF(0, 0);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
}

TEST_F(AICPUScheduleInterfaceTEST, ResubscribeF2NF_failed) {
    MOCKER(halQueueUnsubF2NFEvent).stubs().will(returnValue(200));
    int32_t ret = create_queue_kernel_.ResubscribeF2NF(0, 0);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_DRV_ERR);
}

TEST_F(AICPUScheduleInterfaceTEST, ResubscribeF2NF_failed2) {
    MOCKER(halQueueSubF2NFEvent).stubs().will(returnValue(200));
    int32_t ret = create_queue_kernel_.ResubscribeF2NF(0, 0);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_DRV_ERR);
}

TEST_F(AICPUScheduleInterfaceTEST, SubscribeEvent_failed) {
    MOCKER(halQueueSubscribe).stubs().will(returnValue(200));
    int32_t ret = create_queue_kernel_.SubscribeEvent(0, 0);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_DRV_ERR);
}

TEST_F(AICPUScheduleInterfaceTEST, SubscribeEvent_failed2) {
    MOCKER(halQueueSubscribe).stubs().will(returnValue(DRV_ERROR_QUEUE_RE_SUBSCRIBED));
    MOCKER(halQueueUnsubscribe).stubs().will(returnValue(200));
    int32_t ret = create_queue_kernel_.SubscribeEvent(0, 0);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_DRV_ERR);
}

TEST_F(AICPUScheduleInterfaceTEST, SubscribeEvent_failed3) {
    MOCKER(halQueueSubF2NFEvent).stubs().will(returnValue(200));
    int32_t ret = create_queue_kernel_.SubscribeEvent(0, 0);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_DRV_ERR);
}

TEST_F(AICPUScheduleInterfaceTEST, SubscribeEvent_failed4) {
    MOCKER(halQueueSubF2NFEvent).stubs().will(returnValue(DRV_ERROR_QUEUE_RE_SUBSCRIBED));
    MOCKER(halQueueUnsubscribe).stubs().will(returnValue(200));
    int32_t ret = create_queue_kernel_.SubscribeEvent(0, 0);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_DRV_ERR);
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
    std::vector<uint32_t> deviceVec;
    deviceVec.push_back(0);
    pid_t hostPid = 0;
    char *pidSign = "test";
    bool isOnline = true;
    AicpuScheduleInterface::GetInstance().UpdateOrInsertStartFlag(0U, false);
    MOCKER_CPP(&AicpuDrvManager::InitDrvSchedModule).stubs().will(returnValue(10));
    int ret = AicpuScheduleInterface::GetInstance().InitAICPUScheduler(deviceVec, hostPid, pidSign, PROFILING_CLOSE,
                                                                       0, isOnline, SCHED_MODE_INTERRUPT);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_DRV_ERR);
}

TEST_F(AICPUScheduleInterfaceTEST, InitAICPUScheduler_failed2)
{
    std::vector<uint32_t> deviceVec;
    deviceVec.push_back(0);
    pid_t hostPid = 0;
    char *pidSign = "test";
    bool isOnline = true;
    AicpuScheduleInterface::GetInstance().UpdateOrInsertStartFlag(0U, false);
    MOCKER_CPP(&AicpuDrvManager::InitDrvSchedModule).stubs().will(returnValue(0));
    MOCKER_CPP(&ComputeProcess::Start).stubs().will(returnValue(10));
    MOCKER_CPP(&AicpuDrvManager::CheckBindHostPid)
        .stubs()
        .will(returnValue(0));
    int ret = AicpuScheduleInterface::GetInstance().InitAICPUScheduler(deviceVec, hostPid, pidSign, PROFILING_CLOSE,
                                                                       0, isOnline, SCHED_MODE_INTERRUPT);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_INIT_CP_FAILED);
}

TEST_F(AICPUScheduleInterfaceTEST, StopAICPUScheduler_failed1)
{
    std::vector<uint32_t> deviceVec;
    deviceVec.push_back(0);
    pid_t hostPid = 0;
    AicpuScheduleInterface::GetInstance().noThreadFlag_ = true;
    MOCKER(halEschedDettachDevice)
        .stubs()
        .will(returnValue(10));
    int32_t ret = AicpuScheduleInterface::GetInstance().StopAICPUScheduler(deviceVec, hostPid);
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
    MOCKER_CPP(&FeatureCtrl::ShouldInitDrvThread).stubs().will(returnValue(false));
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

TEST_F(AICPUScheduleInterfaceTEST, ProcessEndGraph)
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

TEST_F(AICPUScheduleInterfaceTEST, TsKernelCfgExtInfo_success) {
    aicpu::HwtsTsKernel tsKernelInfo;
    AicpuExtendInfo cfgMsg;
    cfgMsg.msgType = static_cast<uint8_t>(AicpuExtInfoMsgType::EXT_MODEL_ID_MSG_TYPE);
    cfgMsg.modelIdMap.modelId = 0U;
    cfgMsg.modelIdMap.extendModelId = 1U;
    tsKernelInfo.kernelBase.cceKernel.paramBase = (uint64_t)&cfgMsg;
    AicpuModelManager::GetInstance().allModel_[0].isValid = true;
    int ret = config_extinfo_kernel_.Compute(tsKernelInfo);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
    AicpuModelManager::GetInstance().allModel_[0].isValid = false;
}

TEST_F(AICPUScheduleInterfaceTEST, TsKernelModelConfig_success) {
    aicpu::HwtsTsKernel tsKernelInfo;
    aicpu::HwtsCceKernel cceKernel;
    const uint32_t len =  sizeof(aicpu::AicpuParamHead) + sizeof(AicpuModelConfig);
    char args[len] = {};
    aicpu::AicpuParamHead *paramHead = reinterpret_cast<aicpu::AicpuParamHead *>(args);
    paramHead->length = len;
    char *p = args + sizeof(aicpu::AicpuParamHead);
    AicpuModelConfig cfg;
    cfg.geModelId = 1;
    cfg.runtimeModelId = 0;
    cfg.abnormalBreak = 1;
    cfg.abnormalEnqueue = 1;
    p = (char *)&cfg;
    cceKernel.paramBase = (uint64_t)args;
    tsKernelInfo.kernelBase.cceKernel = cceKernel;
    int ret = model_config_kernel_.Compute(tsKernelInfo);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
}

TEST_F(AICPUScheduleInterfaceTEST, TsKernelModelConfig_failed) {
    aicpu::HwtsTsKernel tsKernelInfo;
    aicpu::HwtsCceKernel cceKernel;
    cceKernel.paramBase = 0;
    tsKernelInfo.kernelBase.cceKernel = cceKernel;
    int ret = model_config_kernel_.Compute(tsKernelInfo);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID);
}

TEST_F(AICPUScheduleInterfaceTEST, TsKernelModelConfigHasShape_success01) {
    aicpu::HwtsTsKernel tsKernelInfo;
    aicpu::HwtsCceKernel cceKernel;
    uint8_t data[36] = {
        -24, 3, 0, 0, 16, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, -23, 3, 0, 0, 4, 0, 0, 0, 1, 0, 0, 0};
    const uint32_t len =  sizeof(aicpu::AicpuParamHead) + sizeof(AicpuModelShapeConfig);
    uint8_t args[len] = {};
    aicpu::AicpuParamHead *paramHead = reinterpret_cast<aicpu::AicpuParamHead *>(args);
    paramHead->length = len;
    AicpuModelShapeConfig *cfg =
        reinterpret_cast<AicpuModelShapeConfig *>(reinterpret_cast<uint8_t *>(args) + sizeof(aicpu::AicpuParamHead));
    cfg->geModelId = 1;
    cfg->runtimeModelId = 0;
    cfg->tensortlvLen = 36;
    cfg->tlvDataAddr = (uint64_t)data;
    cceKernel.paramBase = (uint64_t)args;
    tsKernelInfo.kernelBase.cceKernel = cceKernel;
    int ret = shape_config_kernel_.Compute(tsKernelInfo);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
}

TEST_F(AICPUScheduleInterfaceTEST, TsKernelModelConfigHasShape_success02) {
    aicpu::HwtsTsKernel tsKernelInfo;
    aicpu::HwtsCceKernel cceKernel;
    uint8_t data[56] = {-24, 3, 0, 0, 8, 0, 0, 0, 12, 0, 0, 0, 0, 0, 0, 0, -23, 3, 0, 0, 4, 0, 0, 0, 3, 0, 0, 0,
        -24, 3, 0, 0, 8, 0, 0, 0, 12, 0, 0, 0, 0, 0, 0, 0, -23, 3, 0, 0, 4, 0, 0, 0, 3, 0, 0, 0};
    const uint32_t len =  sizeof(aicpu::AicpuParamHead) + sizeof(AicpuModelShapeConfig);
    uint8_t args[len] = {};
    aicpu::AicpuParamHead *paramHead = reinterpret_cast<aicpu::AicpuParamHead *>(args);
    paramHead->length = len;
    AicpuModelShapeConfig *cfg =
        reinterpret_cast<AicpuModelShapeConfig *>(reinterpret_cast<uint8_t *>(args) + sizeof(aicpu::AicpuParamHead));
    cfg->geModelId = 1;
    cfg->runtimeModelId = 0;
    cfg->tensortlvLen = 56;
    cfg->tlvDataAddr = (uint64_t)data;
    cceKernel.paramBase = (uint64_t)args;
    tsKernelInfo.kernelBase.cceKernel = cceKernel;
    int ret = shape_config_kernel_.Compute(tsKernelInfo);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
}

TEST_F(AICPUScheduleInterfaceTEST, TsKernelModelConfigHasShape_failed01) {
    aicpu::HwtsTsKernel tsKernelInfo;
    aicpu::HwtsCceKernel cceKernel;
    uint8_t data[36] = {
        -24, 3, 0, 0, 16, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, -23, 3, 0, 0, 4, 0, 0, 0, 1, 0, 0, 0};
    const uint32_t len =  sizeof(aicpu::AicpuParamHead) + sizeof(AicpuModelShapeConfig);
    uint8_t args[len] = {};
    aicpu::AicpuParamHead *paramHead = reinterpret_cast<aicpu::AicpuParamHead *>(args);
    paramHead->length = len;
    AicpuModelShapeConfig *cfg =
        reinterpret_cast<AicpuModelShapeConfig *>(reinterpret_cast<uint8_t *>(args) + sizeof(aicpu::AicpuParamHead));
    cfg->geModelId = 1;
    cfg->runtimeModelId = 0;
    cfg->tensortlvLen = 35;
    cfg->tlvDataAddr = (uint64_t)data;
    cceKernel.paramBase = (uint64_t)args;
    tsKernelInfo.kernelBase.cceKernel = cceKernel;
    int ret = shape_config_kernel_.Compute(tsKernelInfo);
    EXPECT_NE(ret, AICPU_SCHEDULE_OK);
}

TEST_F(AICPUScheduleInterfaceTEST, TsKernelModelConfigHasShape_failed02) {
    aicpu::HwtsTsKernel tsKernelInfo;
    aicpu::HwtsCceKernel cceKernel;
    uint8_t data[36] = {
        1, 0, 0, 0, 16, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 4, 0, 0, 0, 1, 0, 0, 0};
    const uint32_t len =  sizeof(aicpu::AicpuParamHead) + sizeof(AicpuModelShapeConfig);
    uint8_t args[len] = {};
    aicpu::AicpuParamHead *paramHead = reinterpret_cast<aicpu::AicpuParamHead *>(args);
    paramHead->length = len;
    AicpuModelShapeConfig *cfg =
        reinterpret_cast<AicpuModelShapeConfig *>(reinterpret_cast<uint8_t *>(args) + sizeof(aicpu::AicpuParamHead));
    cfg->geModelId = 1;
    cfg->runtimeModelId = 0;
    cfg->tensortlvLen = 36;
    cfg->tlvDataAddr = (uint64_t)data;
    cceKernel.paramBase = (uint64_t)args;
    tsKernelInfo.kernelBase.cceKernel = cceKernel;
    int ret = shape_config_kernel_.Compute(tsKernelInfo);
    EXPECT_NE(ret, AICPU_SCHEDULE_OK);
}

TEST_F(AICPUScheduleInterfaceTEST, TsKernelModelConfigHasShape_failed03) {
    aicpu::HwtsTsKernel tsKernelInfo;
    aicpu::HwtsCceKernel cceKernel;
    uint8_t data[36] = {
        -24, 3, 0, 0, 16, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4, 0, 0, 0, 1, 0, 0, 0};
    const uint32_t len =  sizeof(aicpu::AicpuParamHead) + sizeof(AicpuModelShapeConfig);
    uint8_t args[len] = {};
    aicpu::AicpuParamHead *paramHead = reinterpret_cast<aicpu::AicpuParamHead *>(args);
    paramHead->length = len;
    AicpuModelShapeConfig *cfg =
        reinterpret_cast<AicpuModelShapeConfig *>(reinterpret_cast<uint8_t *>(args) + sizeof(aicpu::AicpuParamHead));
    cfg->geModelId = 1;
    cfg->runtimeModelId = 0;
    cfg->tensortlvLen = 36;
    cfg->tlvDataAddr = (uint64_t)data;
    cceKernel.paramBase = (uint64_t)args;
    tsKernelInfo.kernelBase.cceKernel = cceKernel;
    int ret = shape_config_kernel_.Compute(tsKernelInfo);
    EXPECT_NE(ret, AICPU_SCHEDULE_OK);
}

TEST_F(AICPUScheduleInterfaceTEST, TsKernelModelConfigHasShape_failed04) {
    aicpu::HwtsTsKernel tsKernelInfo;
    aicpu::HwtsCceKernel cceKernel;
    uint8_t data[36] = {
        -24, 3, 0, 0, 16, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, -23, 3, 0, 0, 4, 0, 0, 0, 1, 0, 0, 0};
    const uint32_t len =  sizeof(aicpu::AicpuParamHead) + sizeof(AicpuModelShapeConfig);
    uint8_t args[len] = {};
    aicpu::AicpuParamHead *paramHead = reinterpret_cast<aicpu::AicpuParamHead *>(args);
    paramHead->length = len - 1;
    AicpuModelShapeConfig *cfg =
        reinterpret_cast<AicpuModelShapeConfig *>(reinterpret_cast<uint8_t *>(args) + sizeof(aicpu::AicpuParamHead));
    cfg->geModelId = 1;
    cfg->runtimeModelId = 0;
    cfg->tensortlvLen = 35;
    cfg->tlvDataAddr = (uint64_t)data;
    cceKernel.paramBase = (uint64_t)args;
    tsKernelInfo.kernelBase.cceKernel = cceKernel;
    int ret = shape_config_kernel_.Compute(tsKernelInfo);
    EXPECT_NE(ret, AICPU_SCHEDULE_OK);
}

TEST_F(AICPUScheduleInterfaceTEST, TsKernelSetPriority_success) {
    aicpu::HwtsTsKernel tsKernelInfo;
    aicpu::HwtsCceKernel cceKernel;
    const uint32_t len =  sizeof(aicpu::AicpuParamHead) + sizeof(AicpuPriInfo);
    char args[len] = {};
    aicpu::AicpuParamHead *paramHead = reinterpret_cast<aicpu::AicpuParamHead *>(args);
    paramHead->length = len;
    AicpuPriInfo *cfg = reinterpret_cast<AicpuPriInfo *>(args + sizeof(aicpu::AicpuParamHead));
    cfg->checkHead = PRIORITY_MSG_CHECKCODE;
    cfg->pidPriority = 3;
    cfg->eventPriority = 1;
    cceKernel.paramBase = (uint64_t)args;
    tsKernelInfo.kernelBase.cceKernel = cceKernel;
    int ret = set_esched_priority_kernel_.Compute(tsKernelInfo);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
}

TEST_F(AICPUScheduleInterfaceTEST, TsKernelSetPriority_fail) {
    aicpu::HwtsTsKernel tsKernelInfo;
    aicpu::HwtsCceKernel cceKernel;
    const uint32_t len =  sizeof(aicpu::AicpuParamHead) + sizeof(AicpuPriInfo);
    char args[len] = {};
    aicpu::AicpuParamHead *paramHead = reinterpret_cast<aicpu::AicpuParamHead *>(args);
    paramHead->length = len;
    AicpuPriInfo *cfg = reinterpret_cast<AicpuPriInfo *>(args + sizeof(aicpu::AicpuParamHead));
    cfg->checkHead = 0x1234;
    cfg->pidPriority = 3;
    cfg->eventPriority = 1;
    cceKernel.paramBase = (uint64_t)args;
    tsKernelInfo.kernelBase.cceKernel = cceKernel;
    int ret = set_esched_priority_kernel_.Compute(tsKernelInfo);
    EXPECT_NE(ret, AICPU_SCHEDULE_OK);
}

TEST_F(AICPUScheduleInterfaceTEST, TsKernelSetPriority_default) {
    aicpu::HwtsTsKernel tsKernelInfo;
    aicpu::HwtsCceKernel cceKernel;
    const uint32_t len =  sizeof(aicpu::AicpuParamHead) + sizeof(AicpuPriInfo);
    char args[len] = {};
    aicpu::AicpuParamHead *paramHead = reinterpret_cast<aicpu::AicpuParamHead *>(args);
    paramHead->length = len;
    AicpuPriInfo *cfg = reinterpret_cast<AicpuPriInfo *>(args + sizeof(aicpu::AicpuParamHead));
    cfg->checkHead = PRIORITY_MSG_CHECKCODE;
    cfg->pidPriority = -1;
    cfg->eventPriority = -1;
    cceKernel.paramBase = (uint64_t)args;
    tsKernelInfo.kernelBase.cceKernel = cceKernel;
    int ret = set_esched_priority_kernel_.Compute(tsKernelInfo);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
}

TEST_F(AICPUScheduleInterfaceTEST, TsKernelSetPriority_fail_0) {
    aicpu::HwtsTsKernel tsKernelInfo;
    aicpu::HwtsCceKernel cceKernel;
    const uint32_t len =  sizeof(aicpu::AicpuParamHead) + sizeof(AicpuPriInfo);
    char args[len] = {};
    aicpu::AicpuParamHead *paramHead = reinterpret_cast<aicpu::AicpuParamHead *>(args);
    paramHead->length = len;
    AicpuPriInfo *cfg = reinterpret_cast<AicpuPriInfo *>(args + sizeof(aicpu::AicpuParamHead));
    cfg->checkHead = PRIORITY_MSG_CHECKCODE;
    cfg->pidPriority = 2;
    cfg->eventPriority = 2;
    cceKernel.paramBase = (uint64_t)args;
    tsKernelInfo.kernelBase.cceKernel = cceKernel;
    AicpuDrvManager::GetInstance().deviceVec_.clear();
    MOCKER(halEschedSetPidPriority).stubs().will(returnValue(1));
    int ret = set_esched_priority_kernel_.Compute(tsKernelInfo);
    EXPECT_NE(ret, AICPU_SCHEDULE_OK);
}

TEST_F(AICPUScheduleInterfaceTEST, TsKernelSetPriority_fail_1) {
    aicpu::HwtsTsKernel tsKernelInfo;
    aicpu::HwtsCceKernel cceKernel;
    const uint32_t len =  sizeof(aicpu::AicpuParamHead) + sizeof(AicpuPriInfo);
    char args[len] = {};
    aicpu::AicpuParamHead *paramHead = reinterpret_cast<aicpu::AicpuParamHead *>(args);
    paramHead->length = len;
    AicpuPriInfo *cfg = reinterpret_cast<AicpuPriInfo *>(args + sizeof(aicpu::AicpuParamHead));
    cfg->checkHead = PRIORITY_MSG_CHECKCODE;
    cfg->pidPriority = 2;
    cfg->eventPriority = 2;
    cceKernel.paramBase = (uint64_t)args;
    tsKernelInfo.kernelBase.cceKernel = cceKernel;
    AicpuDrvManager::GetInstance().deviceVec_.push_back(0);
    MOCKER(halEschedSetPidPriority).stubs().will(returnValue(1));
    int ret = set_esched_priority_kernel_.Compute(tsKernelInfo);
    EXPECT_NE(ret, AICPU_SCHEDULE_OK);
    GlobalMockObject::verify();
}

TEST_F(AICPUScheduleInterfaceTEST, TsKernelSetPriority_fail_2) {
    aicpu::HwtsTsKernel tsKernelInfo;
    aicpu::HwtsCceKernel cceKernel;
    const uint32_t len =  sizeof(aicpu::AicpuParamHead) + sizeof(AicpuPriInfo);
    char args[len] = {};
    aicpu::AicpuParamHead *paramHead = reinterpret_cast<aicpu::AicpuParamHead *>(args);
    paramHead->length = len;
    AicpuPriInfo *cfg = reinterpret_cast<AicpuPriInfo *>(args + sizeof(aicpu::AicpuParamHead));
    cfg->checkHead = PRIORITY_MSG_CHECKCODE;
    cfg->pidPriority = 2;
    cfg->eventPriority = 2;
    cceKernel.paramBase = (uint64_t)args;
    tsKernelInfo.kernelBase.cceKernel = cceKernel;
    AicpuDrvManager::GetInstance().deviceVec_.push_back(0);
    MOCKER(halEschedSetEventPriority).stubs().will(returnValue(1));
    AicpuModelManager::GetInstance().curPidPri_ = -1;
    AicpuModelManager::GetInstance().curEventPri_ = -1;
    int ret = set_esched_priority_kernel_.Compute(tsKernelInfo);
    EXPECT_NE(ret, AICPU_SCHEDULE_OK);
    GlobalMockObject::verify();
}

TEST_F(AICPUScheduleInterfaceTEST, LoadWithEventAndExecute)
{
    std::string names[] = {"prepareMem", "getLookupReq", "setLookupResp", "cpuZeroCpy", "streamRepeat"};

    char placeHolder[1500] = {0};
    uint64_t dataLen = 1500 - mbufDataOffSet;
    Mbuf *mbufP = reinterpret_cast<Mbuf*>(placeHolder);
    Mbuf *ptrHolder = nullptr;
    uint64_t secondPtr = PtrToValue(&ptrHolder);
    Mbuf *ptrHolder1 = nullptr;
    uint64_t secondPtr1 = PtrToValue(&ptrHolder1);
    std::vector<uintptr_t> vec;
    vec.emplace_back(secondPtr);
    vec.emplace_back(secondPtr1);

    HcclComm comm;

    MOCKER_CPP(&MBufferPool::Allocate).stubs().with(outBoundP(&mbufP, sizeof(Mbuf**))).will(returnValue(0));
    PrepareMemTaskParam param0 = {0};
    param0.inBuffPtr = vec.data();
    param0.outBuffPtr = vec.data();
    param0.inBuffNum = 2U;
    param0.outBuffNum = 1U;
    ModelTaskInfo prepareMemTask = {0U, PtrToValue(names[0U].c_str()), PtrToValue(&param0)};

    GetRemoteReqTaskParam param1 = {0};
    param1.inBuffPtr = vec.data();
    ModelTaskInfo getRemoteReqTask = {1U, PtrToValue(names[1U].c_str()), PtrToValue(&param1)};
    MOCKER(halMbufGetBuffAddr).stubs().will(invoke(halMbufGetBuffAddrFake2));
    MOCKER(halMbufGetPrivInfo).stubs().will(invoke(halMbufGetPrivInfoFake2));
    MOCKER(halMbufGetBuffSize).stubs().with(mockcpp::any(), outBoundP(&dataLen))
        .will(returnValue(static_cast<int32_t>(DRV_ERROR_NONE)));
    MOCKER_CPP(&AicpuModelManager::GetHcclComm).stubs().will(returnValue(&comm));

    SetRemoteRespTaskParam param2 = {0};
    param2.inBuffPtr = vec.data();
    param2.outBuffPtr = vec.data();
    param2.inBuffNum = 2U;
    ModelTaskInfo setRemoteRespTask = {2U, PtrToValue(names[2U].c_str()), PtrToValue(&param2)};

    AddrMapInfo mapInfo = {};
    void *src1 = nullptr;
    void *src2 = nullptr;
    uint64_t srcAddrList[] = {PtrToValue(&src1), PtrToValue(&src2)};
    void *dst1 = nullptr;
    void *dst2 = nullptr;
    uint64_t dstAddrList[] = {PtrToValue(&dst1), PtrToValue(&dst2)};
    mapInfo.srcAddrList = PtrToValue(&srcAddrList[0U]);
    mapInfo.dstAddrList = PtrToValue(&dstAddrList[0U]);
    mapInfo.addrNum = 2U;
    ModelTaskInfo cpuZeroCpyTask = {3U, PtrToValue(names[3U].c_str()), PtrToValue(&mapInfo)};

    StreamRepeatTaskParam param4 = {0};
    param4.modelId = 0U;
    param4.streamId = 1U;
    ModelTaskInfo streamRepeatTask = {4U, PtrToValue(names[4U].c_str()), PtrToValue(&param4)};

    ModelTaskInfo tasks[] = {prepareMemTask, getRemoteReqTask, setRemoteRespTask, cpuZeroCpyTask, streamRepeatTask};
    ModelStreamInfo modelStreamInfo = {1, 0x28U, 5, tasks};
    ModelCfgInfo cfg = {};
    cfg.modelType == static_cast<uint32_t>(kModelWithEmbedding);
    uint16_t blockNums[] = {1U};
    uint64_t blockSizes[] = {10U};
    cfg.inputNum = 1U;
    cfg.inBuffPoolSizeAddr = PtrToValue(&blockNums[0U]);
    cfg.inBuffSizeAddr = PtrToValue(&blockSizes[0U]);
    cfg.clientRankNum = 2U;
    uint32_t ranks[2U] = {0U, 1U};
    cfg.clientRankAddr = PtrToValue(&ranks[0U]);
    ModelInfo modelInfo = {}; //{0, 1, &modelStreamInfo, };
    modelInfo.modelId = 0U;
    modelInfo.aicpuStreamNum = 1U;
    modelInfo.streams = &modelStreamInfo;
    modelInfo.cfgInfoPtr = PtrToValue(&cfg);
    modelInfo.abnormalBreak = 1;

    MOCKER(dlopen).stubs().will(returnValue((void*)1));
    MOCKER(dlsym).stubs().will(invoke(dlsymFake));
    MOCKER(dlclose).stubs().will(returnValue(0));
    MOCKER_CPP(&AicpuModel::CheckOperateAndUpdateStatus).stubs().will(returnValue(0));
    MOCKER(halGrpQuery).stubs().will(invoke(halGrpQueryWithSize));
    mempool_t *mp = 1;
    MOCKER(halBuffCreatePool).stubs().with(mockcpp::any(), outBoundP(&mp)).will(returnValue(RET_SUCCESS));
    EXPECT_EQ(static_cast<int32_t>(AICPU_SCHEDULE_SUCCESS), AicpuLoadModel((void*)(&modelInfo)));

    MOCKER_CPP(&AicpuModel::CheckOperate).stubs().will(returnValue(0));
    AICPUSubEventInfo event = {0, };
    g_threasholdToFail = 0;
    EXPECT_NE(0, AicpuEventProcess::GetInstance().AICPUEventExecuteModel(event));
    AicpuScheduleInterface::GetInstance().Destroy(0U);
}

TEST_F(AICPUScheduleInterfaceTEST, LoadWithEventAndExecuteForTrain)
{
    std::string names[] = {"collRecvLookupReq", "collSendLookupResp"};

    char placeHolder[1500] = {0};
    uint64_t dataLen = 1500 - mbufDataOffSet;
    Mbuf *mbufP = reinterpret_cast<Mbuf*>(placeHolder);
    uint64_t secondPtr = PtrToValue(&mbufP);
    std::vector<uintptr_t> vec;
    vec.emplace_back(secondPtr);
    uint64_t secondPtr1 = PtrToValue(&mbufP);
    vec.emplace_back(secondPtr);
    vec.emplace_back(secondPtr1);

    HcclComm comm;

    GetRemoteReqTaskParam param0 = {0};
    param0.inBuffPtr = vec.data();
    ModelTaskInfo getRemoteReqTask = {0U, PtrToValue(names[0U].c_str()), PtrToValue(&param0)};
    MOCKER(halMbufGetBuffAddr).stubs().will(invoke(halMbufGetBuffAddrFake2));
    MOCKER(halMbufGetPrivInfo).stubs().will(invoke(halMbufGetPrivInfoFake2));
    MOCKER(halMbufGetBuffSize).stubs().with(mockcpp::any(), outBoundP(&dataLen))
        .will(returnValue(static_cast<int32_t>(DRV_ERROR_NONE)));
    MOCKER_CPP(&AicpuModelManager::GetHcclComm).stubs().will(returnValue(&comm));

    SetRemoteRespTaskParam param1 = {0};
    param1.inBuffPtr = vec.data();
    param1.outBuffPtr = vec.data();
    ModelTaskInfo setRemoteRespTask = {1U, PtrToValue(names[1U].c_str()), PtrToValue(&param1)};

    ModelTaskInfo tasks[] = {getRemoteReqTask, setRemoteRespTask};
    ModelStreamInfo modelStreamInfo = {1, 0x28U, 2, tasks};
    ModelCfgInfo cfg = {};
    ModelInfo modelInfo = {};
    modelInfo.modelId = 0U;
    modelInfo.aicpuStreamNum = 1U;
    modelInfo.streams = &modelStreamInfo;
    modelInfo.cfgInfoPtr = PtrToValue(&cfg);

    MOCKER(dlopen).stubs().will(returnValue((void*)1));
    MOCKER(dlsym).stubs().will(invoke(dlsymFake));
    MOCKER(dlclose).stubs().will(returnValue(0));
    MOCKER_CPP(&AicpuModel::CheckOperateAndUpdateStatus).stubs().will(returnValue(0));
    MOCKER(halGrpQuery).stubs().will(invoke(halGrpQueryWithSize));
    EXPECT_EQ(static_cast<int32_t>(AICPU_SCHEDULE_SUCCESS), AicpuLoadModel((void*)(&modelInfo)));

    MOCKER_CPP(&AicpuModel::CheckOperate).stubs().will(returnValue(0));
    AICPUSubEventInfo event = {0, };
    g_threasholdToFail = 0;
    EXPECT_EQ(0, AicpuEventProcess::GetInstance().AICPUEventExecuteModel(event));
    AicpuScheduleInterface::GetInstance().Destroy(0U);
}

TEST_F(AICPUScheduleInterfaceTEST, LoadWithEventAndExecuteOnPending)
{
    std::string names[] = {"prepareMem", "getLookupReq", "setLookupResp", "streamRepeat"};

    char placeHolder[1500] = {0};
    uint64_t dataLen = 1500 - mbufDataOffSet;
    Mbuf *mbufP = reinterpret_cast<Mbuf*>(placeHolder);
    Mbuf *ptrHolder = nullptr;
    uint64_t secondPtr = PtrToValue(&ptrHolder);
    std::vector<uintptr_t> vec;
    vec.emplace_back(secondPtr);

    HcclComm comm;

    Mbuf *allocateHolder = reinterpret_cast<Mbuf*>(1);
    MOCKER_CPP(&MBufferPool::Allocate)
        .stubs()
        .with(outBoundP(&allocateHolder))
        .will(returnValue(0))
        .then(returnValue(-1));
    PrepareMemTaskParam param0 = {0};
    param0.inBuffPtr = vec.data();
    param0.outBuffPtr = vec.data();
    param0.inBuffNum = 1U;
    param0.outBuffNum = 1U;
    ModelTaskInfo prepareMemTask = {0U, PtrToValue(names[0U].c_str()), PtrToValue(&param0)};

    GetRemoteReqTaskParam param1 = {0};
    param1.inBuffPtr = vec.data();
    ModelTaskInfo getRemoteReqTask = {1U, PtrToValue(names[1U].c_str()), PtrToValue(&param1)};
    MOCKER(halMbufGetBuffAddr).stubs().will(invoke(halMbufGetBuffAddrFake2));
    MOCKER(halMbufGetPrivInfo).stubs().will(invoke(halMbufGetPrivInfoFake2));
    MOCKER(halMbufGetBuffSize).stubs().with(mockcpp::any(), outBoundP(&dataLen))
        .will(returnValue(static_cast<int32_t>(DRV_ERROR_NONE)));
    MOCKER_CPP(&AicpuModelManager::GetHcclComm).stubs().will(returnValue(&comm));

    SetRemoteRespTaskParam param2 = {0};
    param2.inBuffPtr = vec.data();
    param2.outBuffPtr = vec.data();
    ModelTaskInfo setRemoteRespTask = {2U, PtrToValue(names[2U].c_str()), PtrToValue(&param2)};

    StreamRepeatTaskParam param3 = {0};
    param3.modelId = 0U;
    param3.streamId = 1U;
    ModelTaskInfo streamRepeatTask = {3U, PtrToValue(names[3U].c_str()), PtrToValue(&param3)};

    ModelTaskInfo tasks[] = {prepareMemTask, getRemoteReqTask, setRemoteRespTask, streamRepeatTask};
    ModelStreamInfo modelStreamInfo0 = {1, 0x28U, 4, tasks};
    ModelStreamInfo modelStreamInfo1 = {2, 0x08U, 4, tasks};
    ModelStreamInfo modelStreams[] = {modelStreamInfo0, modelStreamInfo1};
    ModelCfgInfo cfg = {};
    ModelInfo modelInfo = {}; //{0, 1, &modelStreamInfo, };
    modelInfo.modelId = 0U;
    modelInfo.aicpuStreamNum = 2U;
    modelInfo.streams = modelStreams;
    modelInfo.cfgInfoPtr = PtrToValue(&cfg);

    MOCKER(dlopen).stubs().will(returnValue((void*)1));
    MOCKER(dlsym).stubs().will(invoke(dlsymFake));
    MOCKER(dlclose).stubs().will(returnValue(0));
    MOCKER_CPP(&AicpuModel::CheckOperateAndUpdateStatus).stubs().will(returnValue(0));
    MOCKER(halGrpQuery).stubs().will(invoke(halGrpQueryWithSize));
    EXPECT_EQ(static_cast<int32_t>(AICPU_SCHEDULE_SUCCESS), AicpuLoadModel((void*)(&modelInfo)));

    MOCKER_CPP(&AicpuModel::CheckOperate).stubs().will(returnValue(0));
    AICPUSubEventInfo event = {0, };
    g_threasholdToFail = 0;
    EXPECT_EQ(0, AicpuEventProcess::GetInstance().AICPUEventExecuteModel(event));
    AicpuScheduleInterface::GetInstance().Destroy(0U);
}

TEST_F(AICPUScheduleInterfaceTEST, LoadWithEventAndExecuteOnGetLookupBreaking)
{
    std::string names[] = {"prepareMem", "getLookupReq", "setLookupResp", "cpuZeroCpy", "streamRepeat"};

    char placeHolder[1500] = {0};
    uint64_t dataLen = 1500 - mbufDataOffSet;
    Mbuf *mbufP = reinterpret_cast<Mbuf*>(placeHolder);
    Mbuf *ptrHolder = nullptr;
    uint64_t secondPtr = PtrToValue(&ptrHolder);
    uint64_t secondPtr1 = PtrToValue(&ptrHolder);
    std::vector<uintptr_t> vec;
    vec.emplace_back(secondPtr);
    vec.emplace_back(secondPtr1);

    HcclComm comm;

    MOCKER_CPP(&MBufferPool::Allocate).stubs().with(outBoundP(&mbufP, sizeof(Mbuf**))).will(returnValue(0));
    PrepareMemTaskParam param0 = {0};
    param0.inBuffPtr = vec.data();
    param0.outBuffPtr = vec.data();
    param0.inBuffNum = 1U;
    param0.outBuffNum = 1U;
    ModelTaskInfo prepareMemTask = {0U, PtrToValue(names[0U].c_str()), PtrToValue(&param0)};

    GetRemoteReqTaskParam param1 = {0};
    param1.inBuffPtr = vec.data();
    ModelTaskInfo getRemoteReqTask = {1U, PtrToValue(names[1U].c_str()), PtrToValue(&param1)};
    MOCKER(halMbufGetBuffAddr).stubs().will(invoke(halMbufGetBuffAddrFake2));
    MOCKER(halMbufGetPrivInfo).stubs().will(invoke(halMbufGetPrivInfoFake2));
    MOCKER(halMbufGetBuffSize).stubs().with(mockcpp::any(), outBoundP(&dataLen))
        .will(returnValue(static_cast<int32_t>(DRV_ERROR_NONE)));
    MOCKER_CPP(&AicpuModelManager::GetHcclComm).stubs().will(returnValue(&comm));
    MOCKER(StubHcclGetLookupRequest).stubs().will(returnValue(HCCL_E_AGAIN));

    SetRemoteRespTaskParam param2 = {0};
    param2.inBuffPtr = vec.data();
    param2.outBuffPtr = vec.data();
    ModelTaskInfo setRemoteRespTask = {2U, PtrToValue(names[2U].c_str()), PtrToValue(&param2)};

    AddrMapInfo mapInfo = {};
    void *src1 = nullptr;
    void *src2 = nullptr;
    uint64_t srcAddrList[] = {PtrToValue(&src1), PtrToValue(&src2)};
    void *dst1 = nullptr;
    void *dst2 = nullptr;
    uint64_t dstAddrList[] = {PtrToValue(&dst1), PtrToValue(&dst2)};
    mapInfo.srcAddrList = PtrToValue(&srcAddrList[0U]);
    mapInfo.dstAddrList = PtrToValue(&dstAddrList[0U]);
    mapInfo.addrNum = 2U;
    ModelTaskInfo cpuZeroCpyTask = {3U, PtrToValue(names[3U].c_str()), PtrToValue(&mapInfo)};

    StreamRepeatTaskParam param4 = {0};
    param4.modelId = 0U;
    param4.streamId = 1U;
    ModelTaskInfo streamRepeatTask = {4U, PtrToValue(names[4U].c_str()), PtrToValue(&param4)};

    ModelTaskInfo tasks[] = {prepareMemTask, getRemoteReqTask, setRemoteRespTask, cpuZeroCpyTask, streamRepeatTask};
    ModelStreamInfo modelStreamInfo = {1, 0x28U, 5, tasks};
    ModelCfgInfo cfg = {};
    ModelInfo modelInfo = {}; //{0, 1, &modelStreamInfo, };
    modelInfo.modelId = 0U;
    modelInfo.aicpuStreamNum = 1U;
    modelInfo.streams = &modelStreamInfo;
    modelInfo.cfgInfoPtr = PtrToValue(&cfg);

    MOCKER(dlopen).stubs().will(returnValue((void*)1));
    MOCKER(dlsym).stubs().will(invoke(dlsymFake));
    MOCKER(dlclose).stubs().will(returnValue(0));
    MOCKER_CPP(&AicpuModel::CheckOperateAndUpdateStatus).stubs().will(returnValue(0));
    MOCKER(halGrpQuery).stubs().will(invoke(halGrpQueryWithSize));
    EXPECT_EQ(static_cast<int32_t>(AICPU_SCHEDULE_SUCCESS), AicpuLoadModel((void*)(&modelInfo)));

    MOCKER_CPP(&AicpuModel::CheckOperate).stubs().will(returnValue(0));
    AICPUSubEventInfo event = {0, };
    g_threasholdToFail = 0;
    EXPECT_EQ(0, AicpuEventProcess::GetInstance().AICPUEventExecuteModel(event));
    AicpuScheduleInterface::GetInstance().Destroy(0U);
}

TEST_F(AICPUScheduleInterfaceTEST, LoadWithEventAndExecuteOnSetResponseBreaking)
{
    std::string names[] = {"prepareMem", "getLookupReq", "setLookupResp", "cpuZeroCpy", "streamRepeat"};

    char placeHolder[1500] = {0};
    uint64_t dataLen = 1500 - mbufDataOffSet;
    MbufHeadMsg *head = reinterpret_cast<MbufHeadMsg*>(&placeHolder[mbufDataOffSet - sizeof(MbufHeadMsg)]);
    head->retCode = 1;
    Mbuf *mbufP = reinterpret_cast<Mbuf*>(placeHolder);
    Mbuf *ptrHolder = nullptr;
    uint64_t secondPtr = PtrToValue(&ptrHolder);
    std::vector<uintptr_t> vec;
    vec.emplace_back(secondPtr);
    Mbuf *ptrHolder1 = nullptr;
    uint64_t secondPtr1 = PtrToValue(&ptrHolder1);
    vec.emplace_back(secondPtr1);

    HcclComm comm;

    MOCKER_CPP(&MBufferPool::Allocate).stubs().with(outBoundP(&mbufP, sizeof(Mbuf**))).will(returnValue(0));
    PrepareMemTaskParam param0 = {0};
    param0.inBuffPtr = vec.data();
    param0.outBuffPtr = vec.data();
    param0.inBuffNum = 1U;
    param0.outBuffNum = 1U;
    ModelTaskInfo prepareMemTask = {0U, PtrToValue(names[0U].c_str()), PtrToValue(&param0)};

    GetRemoteReqTaskParam param1 = {0};
    param1.inBuffPtr = vec.data();
    ModelTaskInfo getRemoteReqTask = {1U, PtrToValue(names[1U].c_str()), PtrToValue(&param1)};
    MOCKER(halMbufGetBuffAddr).stubs().will(invoke(halMbufGetBuffAddrFake2));
    MOCKER(halMbufGetPrivInfo).stubs().will(invoke(halMbufGetPrivInfoFake2));
    MOCKER(halMbufGetBuffSize).stubs().with(mockcpp::any(), outBoundP(&dataLen))
        .will(returnValue(static_cast<int32_t>(DRV_ERROR_NONE)));
    MOCKER_CPP(&AicpuModelManager::GetHcclComm).stubs().will(returnValue(&comm));

    SetRemoteRespTaskParam param2 = {0};
    param2.inBuffPtr = vec.data();
    param2.outBuffPtr = vec.data();
    ModelTaskInfo setRemoteRespTask = {2U, PtrToValue(names[2U].c_str()), PtrToValue(&param2)};

    AddrMapInfo mapInfo = {};
    void *src1 = nullptr;
    void *src2 = nullptr;
    uint64_t srcAddrList[] = {PtrToValue(&src1), PtrToValue(&src2)};
    void *dst1 = nullptr;
    void *dst2 = nullptr;
    uint64_t dstAddrList[] = {PtrToValue(&dst1), PtrToValue(&dst2)};
    mapInfo.srcAddrList = PtrToValue(&srcAddrList[0U]);
    mapInfo.dstAddrList = PtrToValue(&dstAddrList[0U]);
    mapInfo.addrNum = 2U;
    ModelTaskInfo cpuZeroCpyTask = {3U, PtrToValue(names[3U].c_str()), PtrToValue(&mapInfo)};

    StreamRepeatTaskParam param4 = {0};
    param4.modelId = 0U;
    param4.streamId = 1U;
    ModelTaskInfo streamRepeatTask = {4U, PtrToValue(names[4U].c_str()), PtrToValue(&param4)};

    ModelTaskInfo tasks[] = {prepareMemTask, getRemoteReqTask, setRemoteRespTask, cpuZeroCpyTask, streamRepeatTask};
    ModelStreamInfo modelStreamInfo = {1, 0x28U, 5, tasks};
    ModelCfgInfo cfg = {};
    ModelInfo modelInfo = {}; //{0, 1, &modelStreamInfo, };
    modelInfo.modelId = 0U;
    modelInfo.aicpuStreamNum = 1U;
    modelInfo.streams = &modelStreamInfo;
    modelInfo.cfgInfoPtr = PtrToValue(&cfg);
    modelInfo.abnormalBreak = 1;

    MOCKER(dlopen).stubs().will(returnValue((void*)1));
    MOCKER(dlsym).stubs().will(invoke(dlsymFake));
    MOCKER(dlclose).stubs().will(returnValue(0));
    MOCKER_CPP(&AicpuModel::CheckOperateAndUpdateStatus).stubs().will(returnValue(0));
    MOCKER(halGrpQuery).stubs().will(invoke(halGrpQueryWithSize));
    EXPECT_EQ(static_cast<int32_t>(AICPU_SCHEDULE_SUCCESS), AicpuLoadModel((void*)(&modelInfo)));

    MOCKER_CPP(&AicpuModel::CheckOperate).stubs().will(returnValue(0));
    AICPUSubEventInfo event = {0, };
    g_threasholdToFail = 0;
    EXPECT_NE(0, AicpuEventProcess::GetInstance().AICPUEventExecuteModel(event));
    AicpuScheduleInterface::GetInstance().Destroy(0U);
}

TEST_F(AICPUScheduleInterfaceTEST, LoadWithEventAndExecuteForUpdate)
{
    std::string names[] = {"prepareMem", "getUpdateReq", "setUpdateResp", "cpuZeroCpy", "streamRepeat"};

    char placeHolder[1500] = {0};
    uint64_t dataLen = 1500 - mbufDataOffSet;
    Mbuf *mbufP = reinterpret_cast<Mbuf*>(placeHolder);
    Mbuf *ptrHolder = nullptr;
    uint64_t secondPtr = PtrToValue(&ptrHolder);
    Mbuf *ptrHolder1 = nullptr;
    uint64_t secondPtr1 = PtrToValue(&ptrHolder1);
    Mbuf *ptrHolder2 = nullptr;
    uint64_t secondPtr2 = PtrToValue(&mbufP);
    std::vector<uintptr_t> vec;
    vec.emplace_back(secondPtr);
    vec.emplace_back(secondPtr1);
    vec.emplace_back(secondPtr2);

    HcclComm comm;

    MOCKER_CPP(&MBufferPool::Allocate).stubs().with(outBoundP(&mbufP, sizeof(Mbuf**))).will(returnValue(0));
    PrepareMemTaskParam param0 = {0};
    param0.inBuffPtr = vec.data();
    param0.inBuffNum = 3U;
    ModelTaskInfo prepareMemTask = {0U, PtrToValue(names[0U].c_str()), PtrToValue(&param0)};

    GetRemoteReqTaskParam param1 = {0};
    param1.inBuffPtr = vec.data();
    param1.embeddingDim = 1U;
    param1.inBuffNum = 3U;
    ModelTaskInfo getRemoteReqTask = {1U, PtrToValue(names[1U].c_str()), PtrToValue(&param1)};
    MOCKER(halMbufGetBuffAddr).stubs().will(invoke(halMbufGetBuffAddrFake2));
    MOCKER(halMbufGetPrivInfo).stubs().will(invoke(halMbufGetPrivInfoFake2));
    MOCKER(halMbufGetBuffSize).stubs().with(mockcpp::any(), outBoundP(&dataLen))
        .will(returnValue(static_cast<int32_t>(DRV_ERROR_NONE)));
    MOCKER_CPP(&AicpuModelManager::GetHcclComm).stubs().will(returnValue(&comm));

    SetRemoteRespTaskParam param2 = {0};
    param2.inBuffPtr = vec.data();
    param2.inBuffNum = 3U;
    ModelTaskInfo setRemoteRespTask = {2U, PtrToValue(names[2U].c_str()), PtrToValue(&param2)};

    AddrMapInfo mapInfo = {};
    void *src1 = nullptr;
    void *src2 = nullptr;
    uint64_t srcAddrList[] = {PtrToValue(&src1), PtrToValue(&src2)};
    void *dst1 = nullptr;
    void *dst2 = nullptr;
    uint64_t dstAddrList[] = {PtrToValue(&dst1), PtrToValue(&dst2)};
    mapInfo.srcAddrList = PtrToValue(&srcAddrList[0U]);
    mapInfo.dstAddrList = PtrToValue(&dstAddrList[0U]);
    mapInfo.addrNum = 2U;
    ModelTaskInfo cpuZeroCpyTask = {3U, PtrToValue(names[3U].c_str()), PtrToValue(&mapInfo)};

    StreamRepeatTaskParam param4 = {0};
    param4.modelId = 0U;
    param4.streamId = 1U;
    ModelTaskInfo streamRepeatTask = {4U, PtrToValue(names[4U].c_str()), PtrToValue(&param4)};

    ModelTaskInfo tasks[] = {prepareMemTask, getRemoteReqTask, setRemoteRespTask, cpuZeroCpyTask, streamRepeatTask};
    ModelStreamInfo modelStreamInfo = {1, 0x28U, 5, tasks};
    ModelCfgInfo cfg = {};
    ModelInfo modelInfo = {}; //{0, 1, &modelStreamInfo, };
    modelInfo.modelId = 0U;
    modelInfo.aicpuStreamNum = 1U;
    modelInfo.streams = &modelStreamInfo;
    modelInfo.cfgInfoPtr = PtrToValue(&cfg);
    modelInfo.abnormalBreak = 1;

    MOCKER(dlopen).stubs().will(returnValue((void*)1));
    MOCKER(dlsym).stubs().will(invoke(dlsymFake));
    MOCKER(dlclose).stubs().will(returnValue(0));
    MOCKER_CPP(&AicpuModel::CheckOperateAndUpdateStatus).stubs().will(returnValue(0));
    MOCKER(halGrpQuery).stubs().will(invoke(halGrpQueryWithSize));
    EXPECT_EQ(static_cast<int32_t>(AICPU_SCHEDULE_SUCCESS), AicpuLoadModel((void*)(&modelInfo)));

    MOCKER_CPP(&AicpuModel::CheckOperate).stubs().will(returnValue(0));
    AICPUSubEventInfo event = {0, };
    g_threasholdToFail = -1;
    EXPECT_NE(0, AicpuEventProcess::GetInstance().AICPUEventExecuteModel(event));
    AicpuScheduleInterface::GetInstance().Destroy(0U);
}

TEST_F(AICPUScheduleInterfaceTEST, LoadWithEventAndExecuteForUpdate2WithGS)
{
    std::string names[] = {"prepareMem", "getUpdateReq", "setUpdateResp", "cpuZeroCpy", "streamRepeat"};

    char placeHolder[1500] = {0};
    uint64_t dataLen = 1500 - mbufDataOffSet;
    Mbuf *mbufP = reinterpret_cast<Mbuf*>(placeHolder);
    Mbuf *ptrHolder = nullptr;
    uint64_t secondPtr = PtrToValue(&ptrHolder);
    Mbuf *ptrHolder1 = nullptr;

    uint64_t secondPtr1 = PtrToValue(&ptrHolder1);
    Mbuf *ptrHolder2 = nullptr;
    uint64_t secondPtr2 = PtrToValue(&mbufP);
    Mbuf *ptrHolder3 = nullptr;
    uint64_t secondPtr3 = PtrToValue(&mbufP);
    std::vector<uintptr_t> vec;
    vec.emplace_back(secondPtr);
    vec.emplace_back(secondPtr1);
    vec.emplace_back(secondPtr2);
    vec.emplace_back(secondPtr3);

    HcclComm comm;

    MOCKER_CPP(&MBufferPool::Allocate).stubs().with(outBoundP(&mbufP, sizeof(Mbuf**))).will(returnValue(0));
    PrepareMemTaskParam param0 = {0};
    param0.inBuffPtr = vec.data();
    param0.inBuffNum = 4U;
    ModelTaskInfo prepareMemTask = {0U, PtrToValue(names[0U].c_str()), PtrToValue(&param0)};

    GetRemoteReqTaskParam param1 = {0};
    param1.inBuffPtr = vec.data();
    param1.embeddingDim = 1U;
    param1.inBuffNum = 4U;
    ModelTaskInfo getRemoteReqTask = {1U, PtrToValue(names[1U].c_str()), PtrToValue(&param1)};
    MOCKER(halMbufGetBuffAddr).stubs().will(invoke(halMbufGetBuffAddrFake2));
    MOCKER(halMbufGetPrivInfo).stubs().will(invoke(halMbufGetPrivInfoFake2));
    MOCKER(halMbufGetBuffSize).stubs().with(mockcpp::any(), outBoundP(&dataLen))
        .will(returnValue(static_cast<int32_t>(DRV_ERROR_NONE)));
    MOCKER_CPP(&AicpuModelManager::GetHcclComm).stubs().will(returnValue(&comm));

    SetRemoteRespTaskParam param2 = {0};
    param2.inBuffPtr = vec.data();
    param2.inBuffNum = 4U;
    ModelTaskInfo setRemoteRespTask = {2U, PtrToValue(names[2U].c_str()), PtrToValue(&param2)};

    AddrMapInfo mapInfo = {};
    void *src1 = nullptr;
    void *src2 = nullptr;
    uint64_t srcAddrList[] = {PtrToValue(&src1), PtrToValue(&src2)};
    void *dst1 = nullptr;
    void *dst2 = nullptr;
    uint64_t dstAddrList[] = {PtrToValue(&dst1), PtrToValue(&dst2)};
    mapInfo.srcAddrList = PtrToValue(&srcAddrList[0U]);
    mapInfo.dstAddrList = PtrToValue(&dstAddrList[0U]);
    mapInfo.addrNum = 2U;
    ModelTaskInfo cpuZeroCpyTask = {3U, PtrToValue(names[3U].c_str()), PtrToValue(&mapInfo)};

    StreamRepeatTaskParam param4 = {0};
    param4.modelId = 0U;
    param4.streamId = 1U;
    ModelTaskInfo streamRepeatTask = {4U, PtrToValue(names[4U].c_str()), PtrToValue(&param4)};

    ModelTaskInfo tasks[] = {prepareMemTask, getRemoteReqTask, setRemoteRespTask, cpuZeroCpyTask, streamRepeatTask};
    ModelStreamInfo modelStreamInfo = {1, 0x28U, 5, tasks};
    ModelCfgInfo cfg = {};
    ModelInfo modelInfo = {}; //{0, 1, &modelStreamInfo, };
    modelInfo.modelId = 0U;
    modelInfo.aicpuStreamNum = 1U;
    modelInfo.streams = &modelStreamInfo;
    modelInfo.cfgInfoPtr = PtrToValue(&cfg);
    modelInfo.abnormalBreak = 1;

    MOCKER(dlopen).stubs().will(returnValue((void*)1));
    MOCKER(dlsym).stubs().will(invoke(dlsymFake));
    MOCKER(dlclose).stubs().will(returnValue(0));
    MOCKER_CPP(&AicpuModel::CheckOperateAndUpdateStatus).stubs().will(returnValue(0));
    MOCKER(halGrpQuery).stubs().will(invoke(halGrpQueryWithSize));
    EXPECT_EQ(static_cast<int32_t>(AICPU_SCHEDULE_SUCCESS), AicpuLoadModel((void*)(&modelInfo)));

    MOCKER_CPP(&AicpuModel::CheckOperate).stubs().will(returnValue(0));
    AICPUSubEventInfo event = {0, };
    g_threasholdToFail = -1;
    EXPECT_NE(0, AicpuEventProcess::GetInstance().AICPUEventExecuteModel(event));
    AicpuScheduleInterface::GetInstance().Destroy(0U);
}

TEST_F(AICPUScheduleInterfaceTEST, LoadWithEventAndExecuteForSyncEvent)
{
    std::string names[] = {"batchRecv", "batchSend", "modelRepeat"};

    std::vector<HcomP2pOpInfo> p2pVec = {HcomP2pOpInfo(), HcomP2pOpInfo()};
    BatchSendRecvTaskParam batchTaskParam = {};
    batchTaskParam.ioNum = 2U;
    batchTaskParam.hcomP2pOpList = PtrToValue(p2pVec.data());
    ModelTaskInfo batchRecvTask = {0U, PtrToValue(names[0U].c_str()), PtrToValue(&batchTaskParam)};

    ModelTaskInfo batchSendTask = {1U, PtrToValue(names[1U].c_str()), PtrToValue(&batchTaskParam)};

    uint32_t modelId = 0U;
    ModelTaskInfo modelRepeatTask = {1U, PtrToValue(names[2U].c_str()), PtrToValue(&modelId)};

    ModelTaskInfo tasks[] = {batchRecvTask, batchSendTask, modelRepeatTask};
    ModelStreamInfo modelStreamInfo = {1, 0x28U, 3, tasks};

    std::vector<HcomOpDesc> opVec = {HcomOpDesc(), HcomOpDesc()};
    ModelCommOpList opList = {};
    opList.opNum = 2U;
    opList.commOpDescsListAddr = PtrToValue(opVec.data());
    ModelCfgInfo cfg = {};
    cfg.modelType = static_cast<uint32_t>(kModelWithSyncEvent);
    cfg.modelCommOpListAddr = PtrToValue(&opList);
    ModelInfo modelInfo = {};
    modelInfo.modelId = 0U;
    modelInfo.aicpuStreamNum = 1U;
    modelInfo.streams = &modelStreamInfo;
    modelInfo.cfgInfoPtr = PtrToValue(&cfg);

    MOCKER(dlopen).stubs().will(returnValue((void*)1));
    MOCKER(dlsym).stubs().will(invoke(dlsymFake));
    MOCKER(dlclose).stubs().will(returnValue(0));
    MOCKER_CPP(&AicpuModel::CheckOperateAndUpdateStatus).stubs().will(returnValue(0));
    MOCKER(halGrpQuery).stubs().will(invoke(halGrpQueryWithSize));
    EXPECT_EQ(static_cast<int32_t>(AICPU_SCHEDULE_SUCCESS), AicpuLoadModel((void*)(&modelInfo)));

    MOCKER_CPP(&AicpuModel::CheckOperate).stubs().will(returnValue(0));
    AICPUSubEventInfo event = {0, };
    EXPECT_EQ(0, AicpuEventProcess::GetInstance().AICPUEventExecuteModel(event));
    AicpuScheduleInterface::GetInstance().Destroy(0U);
}

std::vector<MbufHeadMsg> g_mbufHeads[3];
size_t g_dequeCursor[3] = {0};
void GenerateMbufHead(uint64_t transId, uint32_t routeLabel, std::vector<MbufHeadMsg> &heads) {
    MbufHeadMsg mbufhead = {};
    mbufhead.transId = transId;
    mbufhead.dataLabel = routeLabel;
    heads.emplace_back(mbufhead);
}
void ClearMbufHeads() {
    for (size_t i = 0; i < 3U; ++i) {
        g_mbufHeads[i].clear();
        g_dequeCursor[i] = 0U;
    }
}

drvError_t halQueueDeQueueHead(unsigned int devId, unsigned int qid, void **mbuf)
{
    if (qid >= 3U) {
        return DRV_ERROR_NO_DEVICE;
    }

    if (g_dequeCursor[qid] >= g_mbufHeads[qid].size()) {
        return DRV_ERROR_QUEUE_EMPTY;
    }

    auto &head = g_mbufHeads[qid][g_dequeCursor[qid]];
    *mbuf = (Mbuf *)(&head);
    std::cout << "dequed mbuf: "<< *mbuf << " from queue: " << qid << std::endl;
    g_dequeCursor[qid]++;
    if ((head.transId == 0U) && (head.routeLabel == 0U)) {
        return DRV_ERROR_QUEUE_EMPTY;
    }
    return DRV_ERROR_NONE;
}

int halMbufGetPrivInfoFakeHead(Mbuf *mbuf,  void **priv, unsigned int *size)
{
    *priv = (void *)mbuf;
    *size = sizeof(MbufHeadMsg);
    return DRV_ERROR_NONE;
}

int32_t halMbufGetBuffAddrFakeHead(Mbuf *mbuf, void **buf)
{
    std::cout << "aicpusd_interface_process_test halMbufGetBuffAddrFakeHead begin" << std::endl;
    *buf = (void*)((char*)mbuf+sizeof(MbufHeadMsg));
    return 0;
}
TEST_F(AICPUScheduleInterfaceTEST, LoadAndExecuteModelForGatherDeque_success) {

    GatherDequeParam param0 = {};
    param0.inputNums = 3U;
    uint32_t queueIds[3] = {0U, 1U, 2U};
    param0.queueIdsAddr = (uint64_t)(&queueIds[0U]);
    MbufHeadMsg *placeHolder[3] = {nullptr};
    MbufHeadMsg **mbufAddrsAddr[3] = {&placeHolder[0], &placeHolder[1], &placeHolder[2]};
    param0.mbufAddrsAddr = (uint64_t)(&mbufAddrsAddr[0U]);
    uint32_t deviceTypes[3] = {0U};
    param0.deviceTypeAddr = (uint64_t)(&deviceTypes[0U]);
    param0.deviceIdAddr = (uint64_t)(&deviceTypes[0U]);
    ModelTaskInfo gatherDequeTask = {0U, "gatherDequeue", PtrToValue(&param0)};

    // add 2 gatherDequeTask to mock repeate once
    ModelTaskInfo tasks[] = {gatherDequeTask, gatherDequeTask};
    ModelStreamInfo modelStreamInfo = {1, 0x28U, 2, tasks};
    ModelInfo modelInfo = {};
    modelInfo.modelId = 0U;
    modelInfo.aicpuStreamNum = 1U;
    modelInfo.streams = &modelStreamInfo;
    modelInfo.queueNum = 3U;

    ModelQueueInfo queueInfo0 = {0, 0};
    ModelQueueInfo queueInfo1 = {1, 0};
    ModelQueueInfo queueInfo2 = {2, 0};
    ModelQueueInfo modelQueueInfos[] = {queueInfo0, queueInfo1, queueInfo2};
    modelInfo.queues = &modelQueueInfos[0U];

    MOCKER_CPP(&AicpuModel::CheckOperateAndUpdateStatus).stubs().will(returnValue(0));
    EXPECT_EQ(static_cast<int32_t>(AICPU_SCHEDULE_SUCCESS), AicpuLoadModelWithQ((void*)(&modelInfo)));

    MOCKER_CPP(&AicpuModel::CheckOperate).stubs().will(returnValue(0));
    AICPUSubEventInfo event = {0, };
    GenerateMbufHead(1U, 1U, g_mbufHeads[0]);
    GenerateMbufHead(2U, 2U, g_mbufHeads[0]);
    GenerateMbufHead(0U, 0U, g_mbufHeads[0]); // use (0,0) to mock data-break
    GenerateMbufHead(3U, 2U, g_mbufHeads[0]); 
    GenerateMbufHead(2U, 2U, g_mbufHeads[1]);
    GenerateMbufHead(3U, 2U, g_mbufHeads[1]);
    GenerateMbufHead(3U, 3U, g_mbufHeads[1]);
    GenerateMbufHead(1U, 1U, g_mbufHeads[2]);
    GenerateMbufHead(3U, 3U, g_mbufHeads[2]);
    GenerateMbufHead(2U, 2U, g_mbufHeads[2]);
    MOCKER(halQueueDeQueue).stubs().will(invoke(halQueueDeQueueHead));
    // there's just MbufHeadMsg in mbuf head
    MOCKER(halMbufGetPrivInfo).stubs().will(invoke(halMbufGetPrivInfoFakeHead));
    // after executing, stream will pending on the first task
    EXPECT_EQ(0, AicpuEventProcess::GetInstance().AICPUEventExecuteModel(event));
    EXPECT_EQ(placeHolder[0], nullptr);

    // wake up stream, after executing, stream will pending on the second task
    EXPECT_EQ(0, AicpuEventProcess::GetInstance().ProcessQueueNotEmptyEvent(2U));
    EXPECT_EQ(placeHolder[0]->transId, 2U);
    EXPECT_EQ(placeHolder[0]->dataLabel, 2U);
    EXPECT_EQ(placeHolder[1]->transId, 2U);
    EXPECT_EQ(placeHolder[1]->dataLabel, 2U);
    EXPECT_EQ(placeHolder[2]->transId, 2U);
    EXPECT_EQ(placeHolder[2]->dataLabel, 2U);

    uint64_t dataLen = sizeof(RuntimeTensorDesc);
    char mbufStub[dataLen + mbufDataOffSet] = {};
    MOCKER_CPP(&BufManager::MallocAndGuardBufU64)
        .stubs()
        .will(returnValue(reinterpret_cast<Mbuf*>(&mbufStub[0U])));
    // for we have mock mbuf head to just MbufHeadMsg, so we should shift sizeof(MbufHeadMsg) to get data
    MOCKER(halMbufGetBuffAddr).stubs().will(invoke(halMbufGetBuffAddrFakeHead));
    MOCKER(halMbufGetBuffSize).stubs().with(mockcpp::any(), outBoundP(&dataLen))
        .will(returnValue(static_cast<int32_t>(DRV_ERROR_NONE)));
    param0.inputsAlignMaxCacheNum = 1U;
    AICPUSubEventInfo subEventInfo = {};
    std::cout << "Begin to process supply event, not allow drop" << std::endl;
    // after executing, the second task finish, stream reach end
    EXPECT_EQ(0, AicpuEventProcess::GetInstance().AICPUEventSupplyEnque(subEventInfo));
    EXPECT_EQ(PtrToValue(placeHolder[1]), PtrToValue(&mbufStub[0U]));
    MbufHeadMsg *headMsg = PtrToPtr<char_t, MbufHeadMsg>(&mbufStub[0U]);
    EXPECT_EQ(headMsg->retCode, INNER_ERROR_BASE + AICPU_SCHEDULE_ERROR_DISCARD_DATA);

    AicpuScheduleInterface::GetInstance().Destroy(0U);
    ClearMbufHeads();
}

TEST_F(AICPUScheduleInterfaceTEST, LoadAndExecuteModelForGatherDeque_passTimeOut) {

    GatherDequeParam param0 = {};
    param0.inputNums = 3U;
    uint32_t queueIds[3] = {0U, 1U, 2U};
    param0.queueIdsAddr = (uint64_t)(&queueIds[0U]);
    MbufHeadMsg *placeHolder[3] = {nullptr};
    MbufHeadMsg **mbufAddrsAddr[3] = {&placeHolder[0], &placeHolder[1], &placeHolder[2]};
    param0.mbufAddrsAddr = (uint64_t)(&mbufAddrsAddr[0U]);
    uint32_t deviceTypes[3] = {0U};
    param0.deviceTypeAddr = (uint64_t)(&deviceTypes[0U]);
    param0.deviceIdAddr = (uint64_t)(&deviceTypes[0U]);
    ModelTaskInfo gatherDequeTask = {0U, "gatherDequeue", PtrToValue(&param0)};

    // add 2 gatherDequeTask to mock repeate once
    ModelTaskInfo tasks[] = {gatherDequeTask};
    ModelStreamInfo modelStreamInfo = {1, 0x28U, 1, tasks};
    ModelInfo modelInfo = {};
    modelInfo.modelId = 0U;
    modelInfo.aicpuStreamNum = 1U;
    modelInfo.streams = &modelStreamInfo;
    modelInfo.queueNum = 3U;

    ModelQueueInfo queueInfo0 = {0, 0};
    ModelQueueInfo queueInfo1 = {1, 0};
    ModelQueueInfo queueInfo2 = {2, 0};
    ModelQueueInfo modelQueueInfos[] = {queueInfo0, queueInfo1, queueInfo2};
    modelInfo.queues = &modelQueueInfos[0U];

    MOCKER_CPP(&AicpuModel::CheckOperateAndUpdateStatus).stubs().will(returnValue(0));
    EXPECT_EQ(static_cast<int32_t>(AICPU_SCHEDULE_SUCCESS), AicpuLoadModelWithQ((void*)(&modelInfo)));

    MOCKER_CPP(&AicpuModel::CheckOperate).stubs().will(returnValue(0));
    AICPUSubEventInfo event = {0, };
    GenerateMbufHead(1U, 1U, g_mbufHeads[0]);
    GenerateMbufHead(2U, 2U, g_mbufHeads[1]);
    GenerateMbufHead(2U, 2U, g_mbufHeads[2]);
    MOCKER(halQueueDeQueue).stubs().will(invoke(halQueueDeQueueHead));
    // there's just MbufHeadMsg in mbuf head
    MOCKER(halMbufGetPrivInfo).stubs().will(invoke(halMbufGetPrivInfoFakeHead));
    // after executing, stream will pending on the first task
    EXPECT_EQ(0, AicpuEventProcess::GetInstance().AICPUEventExecuteModel(event));
    EXPECT_EQ(placeHolder[0], nullptr);

    sleep(1);
    std::cout << "Begin to process supply event, allow drop" << std::endl;
    param0.inputsAlignDropout = true;
    param0.inputsAlignTimeout = 100;
    EXPECT_EQ(0, AicpuEventProcess::GetInstance().AICPUEventSupplyEnque(event));
}

TEST_F(AICPUScheduleInterfaceTEST, NN_lock_success)
{
    std::string names[] = {"lockTable", "unlockTable"};

    LockTableTaskParam lockParam = {};
    lockParam.lockType = 0;
    lockParam.tableId = 0U;
    ModelTaskInfo lockTask = {0U, PtrToValue(names[0U].c_str()), PtrToValue(&lockParam)};

    UnlockTableTaskParam unlockParam = {};
    unlockParam.tableId = 0U;
    ModelTaskInfo unlockTask = {1U, PtrToValue(names[1U].c_str()), PtrToValue(&unlockParam)};


    ModelTaskInfo tasks[] = {lockTask, unlockTask};
    ModelStreamInfo modelStreamInfo = {101, 0x28U, 2, tasks};

    ModelQueueInfo queueInfo0 = {0, 0};
    ModelQueueInfo modelQueueInfos[] = {queueInfo0};

    ModelInfo modelInfo = {};
    modelInfo.modelId = 101U;
    modelInfo.aicpuStreamNum = 1U;
    modelInfo.streams = &modelStreamInfo;
    modelInfo.queueNum = 1U;
    modelInfo.queues = &modelQueueInfos[0U];

    MOCKER_CPP(&AicpuModel::CheckOperateAndUpdateStatus).stubs().will(returnValue(0));
    EXPECT_EQ(static_cast<int32_t>(AICPU_SCHEDULE_SUCCESS), AicpuLoadModelWithQ((void*)(&modelInfo)));

    MOCKER_CPP(&AicpuModel::CheckOperate).stubs().will(returnValue(0));
    AICPUSubEventInfo event = {modelInfo.modelId, };
    EXPECT_EQ(0, AicpuEventProcess::GetInstance().AICPUEventExecuteModel(event));
    AicpuScheduleInterface::GetInstance().Destroy(modelInfo.modelId );
}

drvError_t StubHalEschedSubmitEvent(unsigned int devId, struct event_summary *event)
{
    std::cout << "StubHalEschedSubmitEvent, event is " << event->event_id << ", subevent is " << event->subevent_id << std::endl;
    event_info eventInfo = {};
    eventInfo.comm.event_id = event->event_id;
    eventInfo.comm.subevent_id = event->subevent_id;
    eventInfo.priv.msg_len = event->msg_len;
    memset(eventInfo.priv.msg, 0, 128);
    memcpy(eventInfo.priv.msg, event->msg, event->msg_len);

    AicpuEventManager::GetInstance().ProcessEvent(eventInfo, 0U);
    return DRV_ERROR_NONE;
}

TEST_F(AICPUScheduleInterfaceTEST, SetTsDevSendMsgAsync2) {
    MOCKER(tsDevSendMsgAsync).stubs().will(returnValue(1)).then(returnValue(0));
    TsAicpuSqe tsAicpuSqe = {0};
    tsAicpuSqe.pid = 0;
    tsAicpuSqe.cmd_type = AICPU_ACTIVE_STREAM;
    tsAicpuSqe.vf_id = 0;
    tsAicpuSqe.tid = 0; // no need tid
    tsAicpuSqe.ts_id = 0;
    tsAicpuSqe.u.aicpu_active_stream.stream_id = 0;
    AicpuMsgSend::SetTsDevSendMsgAsync(0, 0, tsAicpuSqe, 0);
    AicpuMsgSend::SetTsDevSendMsgAsync(0, 0, tsAicpuSqe, 0);
    AicpuMsgSend::SendEvent();

    aicpu::HwtsTsKernel tsKernelInfo;
    aicpu::HwtsCceKernel cceKernel;
    int streamId = 1;
    cceKernel.paramBase = (uint64_t)&streamId;
    tsKernelInfo.kernelBase.cceKernel = cceKernel;
    MOCKER_CPP(&ModelStreamManager::GetInstance().GetStreamModelId).stubs().will(returnValue(0));
    MOCKER_CPP(&AicpuMsgSend::SendAICPUSubEvent).stubs().will(returnValue(0));
    int32_t ret = active_entry_stream_kernel_.Compute(tsKernelInfo);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
}

TEST_F(AICPUScheduleInterfaceTEST, NN_lock_read_write_fail)
{
    // 清空残留事件
    AicpuMsgSend::SendEvent();
    // 发送即触发
    MOCKER(halEschedSubmitEvent).stubs().will(invoke(StubHalEschedSubmitEvent));

    // load model0 and execute
    // lock, pending - recover, unlock
    std::string names0[] = {"lockTable", "modelWaitEndGraph", "unlockTable"};

    LockTableTaskParam rdLockParam = {};
    rdLockParam.lockType = 0;
    rdLockParam.tableId = 0U;
    ModelTaskInfo rdLockTask = {0U, PtrToValue(names0[0U].c_str()), PtrToValue(&rdLockParam)};

    uint32_t modelId0 = 0U;
    ModelTaskInfo waitEndGraphTask = {1U, PtrToValue(names0[1U].c_str()), PtrToValue(&modelId0)};

    UnlockTableTaskParam unlockParam = {};
    unlockParam.tableId = 0U;
    ModelTaskInfo unlockTask = {2U, PtrToValue(names0[2U].c_str()), PtrToValue(&unlockParam)};

    ModelTaskInfo tasks[] = {rdLockTask, waitEndGraphTask, unlockTask};
    uint32_t streamId0 = 0U;
    ModelStreamInfo modelStreamInfo = {streamId0, 0x28U, 3, tasks};

    ModelQueueInfo queueInfo0 = {0, 0};
    ModelQueueInfo modelQueueInfos[] = {queueInfo0};

    ModelInfo modelInfo = {};
    modelInfo.modelId = modelId0;
    modelInfo.aicpuStreamNum = 1U;
    modelInfo.streams = &modelStreamInfo;
    modelInfo.queueNum = 1U;
    modelInfo.queues = &modelQueueInfos[0U];

    MOCKER_CPP(&AicpuModel::CheckOperateAndUpdateStatus).stubs().will(returnValue(0));
    MOCKER_CPP(&AicpuModel::CheckOperate).stubs().will(returnValue(0));
    EXPECT_EQ(static_cast<int32_t>(AICPU_SCHEDULE_SUCCESS), AicpuLoadModelWithQ((void*)(&modelInfo)));
    // 触发模型执行
    AicpuMsgSend::SendEvent();

    auto model0 = AicpuModelManager::GetInstance().GetModel(modelId0);
    ASSERT_TRUE(model0 != nullptr);
    auto stream0 = model0->GetStreamByStreamId(streamId0);
    ASSERT_TRUE(stream0 != nullptr);
    EXPECT_EQ(stream0->nextTaskIndex_, 1);

    // load model1 and execute
    LockTableTaskParam wrLockParam = {};
    wrLockParam.lockType = 1;
    wrLockParam.tableId = 0U;
    ModelTaskInfo wrLockTask = {0U, PtrToValue(names0[0U].c_str()), PtrToValue(&wrLockParam)};
    uint32_t modelId1 = 1U;
    ModelTaskInfo tasks1[] = {wrLockTask, unlockTask};
    uint32_t streamId1 = 1U;
    ModelStreamInfo modelStreamInfo1 = {streamId1, 0x28U, 2, tasks1};

    ModelInfo modelInfo1 = {};
    modelInfo1.modelId = modelId1;
    modelInfo1.aicpuStreamNum = 1U;
    modelInfo1.streams = &modelStreamInfo1;
    modelInfo1.queueNum = 1U;
    modelInfo1.queues = &modelQueueInfos[0U];

    MOCKER_CPP(&AicpuModel::CheckOperate).stubs().will(returnValue(0));
    EXPECT_EQ(static_cast<int32_t>(AICPU_SCHEDULE_SUCCESS), AicpuLoadModelWithQ((void*)(&modelInfo1)));
    // 触发模型执行
    AicpuMsgSend::SendEvent();

    auto model1 = AicpuModelManager::GetInstance().GetModel(modelId1);
    ASSERT_TRUE(model1 != nullptr);
    auto stream1 = model1->GetStreamByStreamId(streamId1);
    ASSERT_TRUE(stream1 != nullptr);
    EXPECT_EQ(stream1->nextTaskIndex_, 0);

    // wakeup model0, then model0 unlock, then wakeup model1, then model1 lock and unlock
    AICPUSubEventInfo eventEndGraph = {};
    eventEndGraph.modelId = modelId0;
    eventEndGraph.para.endGraphInfo.result = 0U;
    AicpuEventProcess::GetInstance().AICPUEventEndGraph(eventEndGraph);
    // 触发事件发送
    AicpuMsgSend::SendEvent();


    EXPECT_EQ(stream0->nextTaskIndex_, 3);
    EXPECT_EQ(stream1->nextTaskIndex_, 2);

    AicpuScheduleInterface::GetInstance().Destroy(modelId0);
    AicpuScheduleInterface::GetInstance().Destroy(modelId1);
}

TEST_F(AICPUScheduleInterfaceTEST, NN_lock_read_read_success)
{
    // 清空残留事件
    AicpuMsgSend::SendEvent();
    // 发送即触发
    MOCKER(halEschedSubmitEvent).stubs().will(invoke(StubHalEschedSubmitEvent));

    // load model0 and execute
    // lock, pending - recover, unlock
    std::string names0[] = {"lockTable", "modelWaitEndGraph", "unlockTable"};

    LockTableTaskParam rdLockParam = {};
    rdLockParam.lockType = 0;
    rdLockParam.tableId = 0U;
    ModelTaskInfo rdLockTask = {0U, PtrToValue(names0[0U].c_str()), PtrToValue(&rdLockParam)};

    uint32_t modelId0 = 0U;
    ModelTaskInfo waitEndGraphTask = {1U, PtrToValue(names0[1U].c_str()), PtrToValue(&modelId0)};

    UnlockTableTaskParam unlockParam = {};
    unlockParam.tableId = 0U;
    ModelTaskInfo unlockTask = {2U, PtrToValue(names0[2U].c_str()), PtrToValue(&unlockParam)};

    ModelTaskInfo tasks[] = {rdLockTask, waitEndGraphTask, unlockTask};
    uint32_t streamId0 = 0U;
    ModelStreamInfo modelStreamInfo = {streamId0, 0x28U, 3, tasks};

    ModelQueueInfo queueInfo0 = {0, 0};
    ModelQueueInfo modelQueueInfos[] = {queueInfo0};

    ModelInfo modelInfo = {};
    modelInfo.modelId = modelId0;
    modelInfo.aicpuStreamNum = 1U;
    modelInfo.streams = &modelStreamInfo;
    modelInfo.queueNum = 1U;
    modelInfo.queues = &modelQueueInfos[0U];

    MOCKER_CPP(&AicpuModel::CheckOperateAndUpdateStatus).stubs().will(returnValue(0));
    MOCKER_CPP(&AicpuModel::CheckOperate).stubs().will(returnValue(0));
    EXPECT_EQ(static_cast<int32_t>(AICPU_SCHEDULE_SUCCESS), AicpuLoadModelWithQ((void*)(&modelInfo)));
    // 触发模型执行
    AicpuMsgSend::SendEvent();

    auto model0 = AicpuModelManager::GetInstance().GetModel(modelId0);
    ASSERT_TRUE(model0 != nullptr);
    auto stream0 = model0->GetStreamByStreamId(streamId0);
    ASSERT_TRUE(stream0 != nullptr);
    EXPECT_EQ(stream0->nextTaskIndex_, 1);

    // load model1 and execute
    LockTableTaskParam rdLockParam1 = {};
    rdLockParam1.lockType = 0;
    rdLockParam1.tableId = 0U;
    ModelTaskInfo rdLockTask1 = {0U, PtrToValue(names0[0U].c_str()), PtrToValue(&rdLockParam1)};
    uint32_t modelId1 = 1U;
    ModelTaskInfo tasks1[] = {rdLockTask1, unlockTask};
    uint32_t streamId1 = 1U;
    ModelStreamInfo modelStreamInfo1 = {streamId1, 0x28U, 2, tasks1};

    ModelInfo modelInfo1 = {};
    modelInfo1.modelId = modelId1;
    modelInfo1.aicpuStreamNum = 1U;
    modelInfo1.streams = &modelStreamInfo1;
    modelInfo1.queueNum = 1U;
    modelInfo1.queues = &modelQueueInfos[0U];

    MOCKER_CPP(&AicpuModel::CheckOperate).stubs().will(returnValue(0));
    EXPECT_EQ(static_cast<int32_t>(AICPU_SCHEDULE_SUCCESS), AicpuLoadModelWithQ((void*)(&modelInfo1)));
    // 触发模型执行
    AicpuMsgSend::SendEvent();

    auto model1 = AicpuModelManager::GetInstance().GetModel(modelId1);
    ASSERT_TRUE(model1 != nullptr);
    auto stream1 = model1->GetStreamByStreamId(streamId1);
    ASSERT_TRUE(stream1 != nullptr);
    EXPECT_EQ(stream1->nextTaskIndex_, 2);

    // wakeup model0, then model0 unlock, then wakeup model1, then model1 lock and unlock
    AICPUSubEventInfo eventEndGraph = {};
    eventEndGraph.modelId = modelId0;
    eventEndGraph.para.endGraphInfo.result = 0U;
    AicpuEventProcess::GetInstance().AICPUEventEndGraph(eventEndGraph);
    // 触发事件发送
    AicpuMsgSend::SendEvent();


    EXPECT_EQ(stream0->nextTaskIndex_, 3);
    EXPECT_EQ(stream1->nextTaskIndex_, 2);

    AicpuScheduleInterface::GetInstance().Destroy(modelId0);
    AicpuScheduleInterface::GetInstance().Destroy(modelId1);
}

TEST_F(AICPUScheduleInterfaceTEST, NN_lock_write_read_fail)
{
    // 清空残留事件
    AicpuMsgSend::SendEvent();
    // 发送即触发
    MOCKER(halEschedSubmitEvent).stubs().will(invoke(StubHalEschedSubmitEvent));

    // load model0 and execute
    // lock, pending - recover, unlock
    std::string names0[] = {"lockTable", "modelWaitEndGraph", "unlockTable"};

    LockTableTaskParam wrLockParam = {};
    wrLockParam.lockType = 1;
    wrLockParam.tableId = 0U;
    ModelTaskInfo wrLockTask = {0U, PtrToValue(names0[0U].c_str()), PtrToValue(&wrLockParam)};

    uint32_t modelId0 = 0U;
    ModelTaskInfo waitEndGraphTask = {1U, PtrToValue(names0[1U].c_str()), PtrToValue(&modelId0)};

    UnlockTableTaskParam unlockParam = {};
    unlockParam.tableId = 0U;
    ModelTaskInfo unlockTask = {2U, PtrToValue(names0[2U].c_str()), PtrToValue(&unlockParam)};

    ModelTaskInfo tasks[] = {wrLockTask, waitEndGraphTask, unlockTask};
    uint32_t streamId0 = 0U;
    ModelStreamInfo modelStreamInfo = {streamId0, 0x28U, 3, tasks};

    ModelQueueInfo queueInfo0 = {0, 0};
    ModelQueueInfo modelQueueInfos[] = {queueInfo0};

    ModelInfo modelInfo = {};
    modelInfo.modelId = modelId0;
    modelInfo.aicpuStreamNum = 1U;
    modelInfo.streams = &modelStreamInfo;
    modelInfo.queueNum = 1U;
    modelInfo.queues = &modelQueueInfos[0U];

    MOCKER_CPP(&AicpuModel::CheckOperateAndUpdateStatus).stubs().will(returnValue(0));
    MOCKER_CPP(&AicpuModel::CheckOperate).stubs().will(returnValue(0));
    EXPECT_EQ(static_cast<int32_t>(AICPU_SCHEDULE_SUCCESS), AicpuLoadModelWithQ((void*)(&modelInfo)));
    // 触发模型执行
    AicpuMsgSend::SendEvent();

    auto model0 = AicpuModelManager::GetInstance().GetModel(modelId0);
    ASSERT_TRUE(model0 != nullptr);
    auto stream0 = model0->GetStreamByStreamId(streamId0);
    ASSERT_TRUE(stream0 != nullptr);
    EXPECT_EQ(stream0->nextTaskIndex_, 1);

    // load model1 and execute
    LockTableTaskParam rdLockParam1 = {};
    rdLockParam1.lockType = 0;
    rdLockParam1.tableId = 0U;
    ModelTaskInfo rdLockTask1 = {0U, PtrToValue(names0[0U].c_str()), PtrToValue(&rdLockParam1)};
    uint32_t modelId1 = 1U;
    ModelTaskInfo tasks1[] = {rdLockTask1, unlockTask};
    uint32_t streamId1 = 1U;
    ModelStreamInfo modelStreamInfo1 = {streamId1, 0x28U, 2, tasks1};

    ModelInfo modelInfo1 = {};
    modelInfo1.modelId = modelId1;
    modelInfo1.aicpuStreamNum = 1U;
    modelInfo1.streams = &modelStreamInfo1;
    modelInfo1.queueNum = 1U;
    modelInfo1.queues = &modelQueueInfos[0U];

    MOCKER_CPP(&AicpuModel::CheckOperate).stubs().will(returnValue(0));
    EXPECT_EQ(static_cast<int32_t>(AICPU_SCHEDULE_SUCCESS), AicpuLoadModelWithQ((void*)(&modelInfo1)));
    // 触发模型执行
    AicpuMsgSend::SendEvent();

    auto model1 = AicpuModelManager::GetInstance().GetModel(modelId1);
    ASSERT_TRUE(model1 != nullptr);
    auto stream1 = model1->GetStreamByStreamId(streamId1);
    ASSERT_TRUE(stream1 != nullptr);
    EXPECT_EQ(stream1->nextTaskIndex_, 0);

    // wakeup model0, then model0 unlock, then wakeup model1, then model1 lock and unlock
    AICPUSubEventInfo eventEndGraph = {};
    eventEndGraph.modelId = modelId0;
    eventEndGraph.para.endGraphInfo.result = 0U;
    AicpuEventProcess::GetInstance().AICPUEventEndGraph(eventEndGraph);
    // 触发事件发送
    AicpuMsgSend::SendEvent();


    EXPECT_EQ(stream0->nextTaskIndex_, 3);
    EXPECT_EQ(stream1->nextTaskIndex_, 2);

    AicpuScheduleInterface::GetInstance().Destroy(modelId0);
    AicpuScheduleInterface::GetInstance().Destroy(modelId1);
}

TEST_F(AICPUScheduleInterfaceTEST, NN_lock_write_write_fail)
{
    // 清空残留事件
    AicpuMsgSend::SendEvent();
    // 发送即触发
    MOCKER(halEschedSubmitEvent).stubs().will(invoke(StubHalEschedSubmitEvent));

    // load model0 and execute
    // lock, pending - recover, unlock
    std::string names0[] = {"lockTable", "modelWaitEndGraph", "unlockTable"};

    LockTableTaskParam wrLockParam = {};
    wrLockParam.lockType = 1;
    wrLockParam.tableId = 0U;
    ModelTaskInfo rdLockTask = {0U, PtrToValue(names0[0U].c_str()), PtrToValue(&wrLockParam)};

    uint32_t modelId0 = 0U;
    ModelTaskInfo waitEndGraphTask = {1U, PtrToValue(names0[1U].c_str()), PtrToValue(&modelId0)};

    UnlockTableTaskParam unlockParam = {};
    unlockParam.tableId = 0U;
    ModelTaskInfo unlockTask = {2U, PtrToValue(names0[2U].c_str()), PtrToValue(&unlockParam)};

    ModelTaskInfo tasks[] = {rdLockTask, waitEndGraphTask, unlockTask};
    uint32_t streamId0 = 0U;
    ModelStreamInfo modelStreamInfo = {streamId0, 0x28U, 3, tasks};

    ModelQueueInfo queueInfo0 = {0, 0};
    ModelQueueInfo modelQueueInfos[] = {queueInfo0};

    ModelInfo modelInfo = {};
    modelInfo.modelId = modelId0;
    modelInfo.aicpuStreamNum = 1U;
    modelInfo.streams = &modelStreamInfo;
    modelInfo.queueNum = 1U;
    modelInfo.queues = &modelQueueInfos[0U];

    MOCKER_CPP(&AicpuModel::CheckOperateAndUpdateStatus).stubs().will(returnValue(0));
    MOCKER_CPP(&AicpuModel::CheckOperate).stubs().will(returnValue(0));
    EXPECT_EQ(static_cast<int32_t>(AICPU_SCHEDULE_SUCCESS), AicpuLoadModelWithQ((void*)(&modelInfo)));
    // 触发模型执行
    AicpuMsgSend::SendEvent();

    auto model0 = AicpuModelManager::GetInstance().GetModel(modelId0);
    ASSERT_TRUE(model0 != nullptr);
    auto stream0 = model0->GetStreamByStreamId(streamId0);
    ASSERT_TRUE(stream0 != nullptr);
    EXPECT_EQ(stream0->nextTaskIndex_, 1);

    // load model1 and execute
    LockTableTaskParam wrLockParam1 = {};
    wrLockParam1.lockType = 1;
    wrLockParam1.tableId = 0U;
    ModelTaskInfo wrLockTask1 = {0U, PtrToValue(names0[0U].c_str()), PtrToValue(&wrLockParam1)};
    uint32_t modelId1 = 1U;
    ModelTaskInfo tasks1[] = {wrLockTask1, unlockTask};
    uint32_t streamId1 = 1U;
    ModelStreamInfo modelStreamInfo1 = {streamId1, 0x28U, 2, tasks1};

    ModelInfo modelInfo1 = {};
    modelInfo1.modelId = modelId1;
    modelInfo1.aicpuStreamNum = 1U;
    modelInfo1.streams = &modelStreamInfo1;
    modelInfo1.queueNum = 1U;
    modelInfo1.queues = &modelQueueInfos[0U];

    MOCKER_CPP(&AicpuModel::CheckOperate).stubs().will(returnValue(0));
    EXPECT_EQ(static_cast<int32_t>(AICPU_SCHEDULE_SUCCESS), AicpuLoadModelWithQ((void*)(&modelInfo1)));
    // 触发模型执行
    AicpuMsgSend::SendEvent();

    auto model1 = AicpuModelManager::GetInstance().GetModel(modelId1);
    ASSERT_TRUE(model1 != nullptr);
    auto stream1 = model1->GetStreamByStreamId(streamId1);
    ASSERT_TRUE(stream1 != nullptr);
    EXPECT_EQ(stream1->nextTaskIndex_, 0);

    // wakeup model0, then model0 unlock, then wakeup model1, then model1 lock and unlock
    AICPUSubEventInfo eventEndGraph = {};
    eventEndGraph.modelId = modelId0;
    eventEndGraph.para.endGraphInfo.result = 0U;
    AicpuEventProcess::GetInstance().AICPUEventEndGraph(eventEndGraph);
    // 触发事件发送
    AicpuMsgSend::SendEvent();


    EXPECT_EQ(stream0->nextTaskIndex_, 3);
    EXPECT_EQ(stream1->nextTaskIndex_, 2);

    AicpuScheduleInterface::GetInstance().Destroy(modelId0);
    AicpuScheduleInterface::GetInstance().Destroy(modelId1);
}

TEST_F(AICPUScheduleInterfaceTEST, TsKernelModelStop_success) {
    aicpu::HwtsTsKernel tsKernelInfo;
    aicpu::HwtsCceKernel cceKernel;
    ReDeployConfig *config = new ReDeployConfig();
    config->modelIdNum = 1;
    uint32_t modelIds[1] = {0};
    config->modelIdsAddr = PtrToValue(&modelIds[0]);
    cceKernel.paramBase = (uint64_t)config;
    tsKernelInfo.kernelBase.cceKernel = cceKernel;
    AicpuModel *aicpuModel = new AicpuModel();
    MOCKER_CPP(&AicpuModelManager::GetModel).stubs().will(returnValue(aicpuModel));
    MOCKER_CPP(&AicpuModel::CheckOperateAndUpdateStatus)
        .stubs()
        .will(returnValue(AICPU_SCHEDULE_OK));
    MOCKER_CPP(&AicpuModel::ReleaseModelResource)
        .stubs()
        .will(returnValue(AICPU_SCHEDULE_OK));
    int ret = model_stop_kernel_.Compute(tsKernelInfo);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
    delete aicpuModel;
    aicpuModel = nullptr;
    delete config;
    config = nullptr;
}

TEST_F(AICPUScheduleInterfaceTEST, TsKernelModelStop_fail1) {
    aicpu::HwtsTsKernel tsKernelInfo;
    aicpu::HwtsCceKernel cceKernel;
    ReDeployConfig *config = new ReDeployConfig();
    config->modelIdNum = 1;
    uint32_t modelIds[1] = {0};
    config->modelIdsAddr = PtrToValue(&modelIds[0]);
    cceKernel.paramBase = (uint64_t)config;
    tsKernelInfo.kernelBase.cceKernel = cceKernel;
    int ret = model_stop_kernel_.Compute(tsKernelInfo);
    EXPECT_NE(ret, AICPU_SCHEDULE_OK);
    delete config;
    config = nullptr;
}

TEST_F(AICPUScheduleInterfaceTEST, TsKernelModelStop_fail2) {
    aicpu::HwtsTsKernel tsKernelInfo;
    aicpu::HwtsCceKernel cceKernel;
    ReDeployConfig *config = new ReDeployConfig();
    config->modelIdNum = 1;
    uint32_t modelIds[1] = {0};
    config->modelIdsAddr = PtrToValue(&modelIds[0]);
    cceKernel.paramBase = (uint64_t)config;
    tsKernelInfo.kernelBase.cceKernel = cceKernel;
    AicpuModel *aicpuModel = new AicpuModel();
    MOCKER_CPP(&AicpuModelManager::GetModel).stubs().will(returnValue(aicpuModel));
    MOCKER_CPP(&AicpuModel::CheckOperateAndUpdateStatus)
        .stubs()
        .will(returnValue(-1));
    int ret = model_stop_kernel_.Compute(tsKernelInfo);
    EXPECT_NE(ret, AICPU_SCHEDULE_OK);
    delete aicpuModel;
    aicpuModel = nullptr;
    delete config;
    config = nullptr;
}

TEST_F(AICPUScheduleInterfaceTEST, TsKernelModelStop_fail3) {
    aicpu::HwtsTsKernel tsKernelInfo;
    aicpu::HwtsCceKernel cceKernel;
    ReDeployConfig *config = new ReDeployConfig();
    config->modelIdNum = 1;
    uint32_t modelIds[1] = {0};
    config->modelIdsAddr = PtrToValue(&modelIds[0]);
    cceKernel.paramBase = (uint64_t)config;
    tsKernelInfo.kernelBase.cceKernel = cceKernel;
    AicpuModel *aicpuModel = new AicpuModel();
    MOCKER_CPP(&AicpuModelManager::GetModel).stubs().will(returnValue(aicpuModel));
    MOCKER_CPP(&AicpuModel::CheckOperateAndUpdateStatus)
        .stubs()
        .will(returnValue(AICPU_SCHEDULE_OK));
    MOCKER_CPP(&AicpuModel::ReleaseModelResource)
        .stubs()
        .will(returnValue(-1));
    int ret = model_stop_kernel_.Compute(tsKernelInfo);
    EXPECT_NE(ret, AICPU_SCHEDULE_OK);
    delete aicpuModel;
    aicpuModel = nullptr;
    delete config;
    config = nullptr;
}

TEST_F(AICPUScheduleInterfaceTEST, TsKernelModelStop_fail4) {
    aicpu::HwtsTsKernel tsKernelInfo;
    aicpu::HwtsCceKernel cceKernel;
    ReDeployConfig *config = new ReDeployConfig();
    config->modelIdNum = 1;
    uint32_t modelIds[1] = {0};
    config->modelIdsAddr = PtrToValue(&modelIds[0]);
    cceKernel.paramBase = (uint64_t)config;
    tsKernelInfo.kernelBase.cceKernel = cceKernel;
    AicpuModel *aicpuModel = new AicpuModel();
    MOCKER_CPP(&AicpuModelManager::GetModel).stubs().will(returnValue(aicpuModel));
    AicpuModelInfo modelInfoT = {0};
    modelInfoT.moduleID = 1;
    (void)aicpuModel->ModelLoad(&modelInfoT);
    MOCKER(tsDevSendMsgAsync).stubs().will(returnValue(-1));
    MOCKER_CPP(&AicpuModel::ModelStop)
        .stubs()
        .will(returnValue(-1));
    int ret = model_stop_kernel_.Compute(tsKernelInfo);
    EXPECT_NE(ret, AICPU_SCHEDULE_OK);
    delete aicpuModel;
    aicpuModel = nullptr;
    delete config;
    config = nullptr;
}

TEST_F(AICPUScheduleInterfaceTEST, TsKernelModelClearInputAndRestart_success) {
    aicpu::HwtsTsKernel tsKernelInfo;
    aicpu::HwtsCceKernel cceKernel;
    ReDeployConfig *config = new ReDeployConfig();
    config->modelIdNum = 1;
    uint32_t modelIds[1] = {0};
    config->modelIdsAddr = PtrToValue(&modelIds[0]);
    cceKernel.paramBase = (uint64_t)config;
    tsKernelInfo.kernelBase.cceKernel = cceKernel;
    AicpuModel *aicpuModel = new AicpuModel();
    MOCKER_CPP(&AicpuModelManager::GetModel).stubs().will(returnValue(aicpuModel));
    MOCKER_CPP(&AicpuModel::CheckOperateAndUpdateStatus)
        .stubs()
        .will(returnValue(AICPU_SCHEDULE_OK))
        .then(returnValue(AICPU_SCHEDULE_OK));
    MOCKER(halQueueDeQueue)
        .stubs()
        .will(returnValue(DRV_ERROR_QUEUE_EMPTY));
    MOCKER_CPP(&AicpuMsgSend::SendAICPUSubEvent)
        .stubs()
        .will(returnValue(AICPU_SCHEDULE_OK));
    int ret = clear_and_restart_kernel_.Compute(tsKernelInfo);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
    delete aicpuModel;
    aicpuModel = nullptr;
    delete config;
    config = nullptr;
}

TEST_F(AICPUScheduleInterfaceTEST, TsKernelModelClearInputAndRestart_fail1) {
    aicpu::HwtsTsKernel tsKernelInfo;
    aicpu::HwtsCceKernel cceKernel;
    ReDeployConfig *config = new ReDeployConfig();
    config->modelIdNum = 1;
    uint32_t modelIds[1] = {0};
    config->modelIdsAddr = PtrToValue(&modelIds[0]);
    cceKernel.paramBase = (uint64_t)config;
    tsKernelInfo.kernelBase.cceKernel = cceKernel;
    int ret = clear_and_restart_kernel_.Compute(tsKernelInfo);
    EXPECT_NE(ret, AICPU_SCHEDULE_OK);
    delete config;
    config = nullptr;
}

TEST_F(AICPUScheduleInterfaceTEST, TsKernelModelClearInputAndRestart_fail2) {
    aicpu::HwtsTsKernel tsKernelInfo;
    aicpu::HwtsCceKernel cceKernel;
    ReDeployConfig *config = new ReDeployConfig();
    config->modelIdNum = 1;
    uint32_t modelIds[1] = {0};
    config->modelIdsAddr = PtrToValue(&modelIds[0]);
    cceKernel.paramBase = (uint64_t)config;
    tsKernelInfo.kernelBase.cceKernel = cceKernel;
    AicpuModel *aicpuModel = new AicpuModel();
    MOCKER_CPP(&AicpuModelManager::GetModel).stubs().will(returnValue(aicpuModel));
    MOCKER_CPP(&AicpuModel::CheckOperateAndUpdateStatus)
        .stubs()
        .will(returnValue(-1));
    int ret = clear_and_restart_kernel_.Compute(tsKernelInfo);
    EXPECT_NE(ret, AICPU_SCHEDULE_OK);
    delete aicpuModel;
    aicpuModel = nullptr;
    delete config;
    config = nullptr;
}

TEST_F(AICPUScheduleInterfaceTEST, TsKernelModelClearInputAndRestart_fail3) {
    aicpu::HwtsTsKernel tsKernelInfo;
    aicpu::HwtsCceKernel cceKernel;
    ReDeployConfig *config = new ReDeployConfig();
    config->modelIdNum = 1;
    uint32_t modelIds[1] = {0};
    config->modelIdsAddr = PtrToValue(&modelIds[0]);
    cceKernel.paramBase = (uint64_t)config;
    tsKernelInfo.kernelBase.cceKernel = cceKernel;
    AicpuModel *aicpuModel = new AicpuModel();
    MOCKER_CPP(&AicpuModelManager::GetModel).stubs().will(returnValue(aicpuModel));
    MOCKER_CPP(&AicpuModel::CheckOperateAndUpdateStatus)
        .stubs()
        .will(returnValue(AICPU_SCHEDULE_OK))
        .then(returnValue(-1));
    MOCKER(halQueueDeQueue)
        .stubs()
        .will(returnValue(DRV_ERROR_QUEUE_EMPTY));
    int ret = clear_and_restart_kernel_.Compute(tsKernelInfo);
    EXPECT_NE(ret, AICPU_SCHEDULE_OK);
    delete aicpuModel;
    aicpuModel = nullptr;
    delete config;
    config = nullptr;
}

TEST_F(AICPUScheduleInterfaceTEST, TsKernelModelClearInputAndRestart_fail4) {
    aicpu::HwtsTsKernel tsKernelInfo;
    aicpu::HwtsCceKernel cceKernel;
    ReDeployConfig *config = new ReDeployConfig();
    config->modelIdNum = 1;
    uint32_t modelIds[1] = {0};
    config->modelIdsAddr = PtrToValue(&modelIds[0]);
    cceKernel.paramBase = (uint64_t)config;
    tsKernelInfo.kernelBase.cceKernel = cceKernel;
    AicpuModel *aicpuModel = new AicpuModel();
    MOCKER_CPP(&AicpuModelManager::GetModel).stubs().will(returnValue(aicpuModel));
    MOCKER_CPP(&AicpuModel::CheckOperateAndUpdateStatus)
        .stubs()
        .will(returnValue(AICPU_SCHEDULE_OK))
        .then(returnValue(AICPU_SCHEDULE_OK));
    MOCKER(halQueueDeQueue)
        .stubs()
        .will(returnValue(DRV_ERROR_QUEUE_EMPTY));
    MOCKER_CPP(&AicpuMsgSend::SendAICPUSubEvent)
        .stubs()
        .will(returnValue(-1));
    int ret = clear_and_restart_kernel_.Compute(tsKernelInfo);
    EXPECT_NE(ret, AICPU_SCHEDULE_OK);
    delete aicpuModel;
    aicpuModel = nullptr;
    delete config;
    config = nullptr;
}

TEST_F(AICPUScheduleInterfaceTEST, TsKernelCheckKernelSupported_success01)
{
    CheckKernelSupportedConfig *config = new CheckKernelSupportedConfig();
    config->kernelNameLen = 8;
    char *OpraterkernelName = "markStep";
    config->kernelNameAddr = PtrToValue(&OpraterkernelName[0]);
    uint32_t retValue = 10;
    config->checkResultAddr = PtrToValue(&retValue);
    config->checkResultLen = 0;
    int ret = CheckKernelSupported(config);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
    uint32_t *resultAddr = PtrToPtr<void, uint32_t>(ValueToPtr(config->checkResultAddr));
    EXPECT_EQ(*resultAddr, AICPU_SCHEDULE_OK);
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
    delete config;
    config = nullptr;
}

TEST_F(AICPUScheduleInterfaceTEST, TsKernelCheckKernelSupported_failed02)
{
    EXPECT_EQ(CheckKernelSupported(nullptr), AICPU_SCHEDULE_FAIL);
}

TEST_F(AICPUScheduleInterfaceTEST, TsKernelCheckKernelSupported_failed03)
{
    CheckKernelSupportedConfig *config = new CheckKernelSupportedConfig();
    int ret = CheckKernelSupported(config);
    EXPECT_EQ(ret, AICPU_SCHEDULE_FAIL);
    delete config;
    config = nullptr;
}

TEST_F(AICPUScheduleInterfaceTEST, TsKernelCheckKernelSupported_success02)
{
    aicpu::HwtsTsKernel tsKernelInfo;
    aicpu::HwtsCceKernel cceKernel;
    char kernel_name[] = "TsKernelCheckKernelSupported";
    uint64_t kernel_name_addr = reinterpret_cast<uint64_t>(
                                reinterpret_cast<uintptr_t>(kernel_name));
    cceKernel.kernelName = kernel_name_addr;
    CheckKernelSupportedConfig *config = new CheckKernelSupportedConfig();
    config->kernelNameLen = 8;
    char *OpraterkernelName = "markStep";
    config->kernelNameAddr = PtrToValue(&OpraterkernelName[0]);
    uint32_t retValue = 10;
    config->checkResultAddr = PtrToValue(&retValue);
    config->checkResultLen = 0;
    cceKernel.paramBase = (uint64_t)config;
    tsKernelInfo.kernelType = 2;
    tsKernelInfo.kernelBase.cceKernel = cceKernel;
    int ret = check_supported_kernel_.Compute(tsKernelInfo);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
    uint32_t *resultAddr = PtrToPtr<void, uint32_t>(ValueToPtr(config->checkResultAddr));
    EXPECT_EQ(*resultAddr, AICPU_SCHEDULE_OK);
    delete config;
    config = nullptr;
}

TEST_F(AICPUScheduleInterfaceTEST, TsKernelCheckKernelSupported_success03)
{
    aicpu::HwtsTsKernel tsKernelInfo;
    aicpu::HwtsCceKernel cceKernel;
    char kernel_name[] = "TsKernelCheckKernelSupported";
    uint64_t kernel_name_addr = reinterpret_cast<uint64_t>(
                                reinterpret_cast<uintptr_t>(kernel_name));
    cceKernel.kernelName = kernel_name_addr;
    CheckKernelSupportedConfig *config = new CheckKernelSupportedConfig();
    config->kernelNameLen = 14;
    char *OpraterkernelName = "markStepMytest";
    config->kernelNameAddr = PtrToValue(&OpraterkernelName[0]);
    cceKernel.paramBase = (uint64_t)config;
    tsKernelInfo.kernelType = 2;
    tsKernelInfo.kernelBase.cceKernel = cceKernel;
    int ret = check_supported_kernel_.Compute(tsKernelInfo);
    EXPECT_EQ(ret, AICPU_SCHEDULE_FAIL);
    delete config;
    config = nullptr;
}

TEST_F(AICPUScheduleInterfaceTEST, TsKernelCheckKernelSupported_failed05)
{
    aicpu::HwtsTsKernel tsKernelInfo;
    aicpu::HwtsCceKernel cceKernel;
    char kernel_name[] = "TsKernelCheckKernelSupported";
    uint64_t kernel_name_addr = reinterpret_cast<uint64_t>(
                                reinterpret_cast<uintptr_t>(kernel_name));
    cceKernel.kernelName = kernel_name_addr;
    CheckKernelSupportedConfig *config = new CheckKernelSupportedConfig();
    config->kernelNameLen = 14;
    char *OpraterkernelName = "markStepMytest";
    config->kernelNameAddr = PtrToValue(&OpraterkernelName[0]);
    uint32_t retValue = 10;
    config->checkResultAddr = PtrToValue(&retValue);
    config->checkResultLen = 0;
    cceKernel.paramBase = (uint64_t)config;
    tsKernelInfo.kernelType = 2;
    tsKernelInfo.kernelBase.cceKernel = cceKernel;
    int ret = check_supported_kernel_.Compute(tsKernelInfo);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
    uint32_t *resultAddr = PtrToPtr<void, uint32_t>(ValueToPtr(config->checkResultAddr));
    EXPECT_EQ(*resultAddr, AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID);
    delete config;
    config = nullptr;
}

TEST_F(AICPUScheduleInterfaceTEST, SendLoadPlatformFromBufMsgRsp_01) {
    TsAicpuSqe ctrlMsg = {};
    AicpuSqeAdapter adapter(ctrlMsg, 0U);
    MOCKER(tsDevSendMsgAsync).stubs().will(returnValue(0));
    auto ret = AicpuEventProcess::GetInstance().SendLoadPlatformFromBufMsgRsp(123, adapter);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
    GlobalMockObject::verify();
}

TEST_F(AICPUScheduleInterfaceTEST, SendLoadPlatformFromBufMsgRsp_02) {
    TsAicpuSqe ctrlMsg = {};
    AicpuSqeAdapter adapter(ctrlMsg, 0U);
    MOCKER(tsDevSendMsgAsync).stubs().will(returnValue(1));
    auto ret = AicpuEventProcess::GetInstance().SendLoadPlatformFromBufMsgRsp(123, adapter);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_INNER_ERROR);
    GlobalMockObject::verify();
}

TEST_F(AICPUScheduleInterfaceTEST, ProcessLoadPlatformFromBuf) {
    TsAicpuSqe ctrlMsg = {};
    AicpuSqeAdapter adapter(ctrlMsg, 0U);
    auto ret = AicpuEventProcess::GetInstance().ProcessLoadPlatformFromBuf(adapter);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID);
}

TEST_F(AICPUScheduleInterfaceTEST, GetAicpuExtendSoPlatformFuncPtr) {
    auto ret = AicpuEventProcess::GetInstance().GetAicpuExtendSoPlatformFuncPtr();
    EXPECT_EQ(ret, nullptr);
}

TEST_F(AICPUScheduleInterfaceTEST, LoadHccdSoFail)
{
    auto hcclSoManager = HcclSoManager::GetInstance();
    int tmp = 9;
    hcclSoManager->hccdSoHandle_ = &tmp;
    MOCKER(dlsym).stubs().will(returnValue((void *)nullptr));
    MOCKER(dlclose).stubs().will(returnValue(0));
    hcclSoManager->LoadHccdSo();
    hcclSoManager->UnLoadHcclSo();
    EXPECT_EQ(hcclSoManager->hcclSoHandle_, nullptr);
}

TEST_F(AICPUScheduleInterfaceTEST, LoadHcclSoFail)
{
    auto hcclSoManager = HcclSoManager::GetInstance();
    hcclSoManager->hcclSoHandle_ = nullptr;
    int tmp = 9;
    hcclSoManager->hcclSoHandle_ = &tmp;
    MOCKER(dlsym).stubs().will(returnValue((void *)nullptr));
    MOCKER(dlclose).stubs().will(returnValue(0));
    hcclSoManager->LoadHcclSo();
    hcclSoManager->UnLoadHcclSo();
    EXPECT_EQ(hcclSoManager->hcclSoHandle_, nullptr);
}

TEST_F(AICPUScheduleInterfaceTEST, MBufferPoolInitAndUninit)
{
    MBufferPool bufferPool;
    uint32_t blockNum = 2;
    uint32_t blockSize = 13;
    MOCKER(halBuffCreatePool).stubs().will(returnValue(RET_SUCCESS));
    bufferPool.Init(blockNum, blockSize, true);
    poolHandle pHandle;
    bufferPool.mp_ = pHandle;
    MOCKER(halBuffDeletePool).stubs().will(returnValue(RET_SUCCESS));
    bufferPool.UnInit();
    EXPECT_EQ(bufferPool.mp_, nullptr);
}

TEST_F(AICPUScheduleInterfaceTEST, MBufferPoolAllocateFailed)
{
    MBufferPool bufferPool;
    int32_t ret = bufferPool.Allocate(nullptr);
    EXPECT_EQ(ret, RET_FAILED);
    poolHandle pHandle;
    bufferPool.mp_ = pHandle;
    MOCKER(halMbufAllocByPool).stubs().will(returnValue(-1));
    ret = bufferPool.Allocate(nullptr);
    EXPECT_EQ(ret, RET_FAILED);
}

TEST_F(AICPUScheduleInterfaceTEST, MBufferPoolAllocateSuccess)
{
    MBufferPool bufferPool;
    poolHandle pHandle;
    bufferPool.mp_ = pHandle;
    MOCKER(halMbufAllocByPool).stubs().will(returnValue(RET_SUCCESS));
    int mbufVal = 1;
    Mbuf *mbuf = (Mbuf *)&mbufVal;
    int32_t ret = bufferPool.Allocate(&mbuf);
    EXPECT_EQ(ret, RET_SUCCESS);
    ret = bufferPool.FreeAll();
    EXPECT_EQ(ret, 0);
}

TEST_F(AICPUScheduleInterfaceTEST, MBufferPoolFreeFail)
{
    MBufferPool bufferPool;
    MOCKER(halMbufFree).stubs().will(returnValue(-1));
    int32_t ret = bufferPool.Free(nullptr);
    EXPECT_EQ(ret, -1);
}

TEST_F(AICPUScheduleInterfaceTEST, MBufferPoolFreeAllFail)
{
    MBufferPool bufferPool;
    Mbuf *tmp;
    bufferPool.mbufsAllocated_.emplace(tmp);
    MOCKER(halMbufFree).stubs().will(returnValue(-1));
    int32_t ret = bufferPool.FreeAll();
    EXPECT_EQ(ret, -1);
}

TEST_F(AICPUScheduleInterfaceTEST, HcclApiFail)
{
    MOCKER(dlopen).stubs().will(returnValue((void*)1));
    MOCKER(dlclose).stubs().will(returnValue(0));
    MOCKER(dlsym).stubs().will(invoke(dlsymFakeNull));

    auto hcclSoManager = HcclSoManager::GetInstance();
    hcclSoManager->LoadSo();

    EXPECT_EQ(HCCL_E_RESERVED, StubHcclInitCsComm(nullptr, 0, nullptr, nullptr, nullptr));

    HcclComm comm;
    EXPECT_EQ(HCCL_E_RESERVED, StubHcclFinalizeComm(comm));

    EXPECT_EQ(HCCL_E_RESERVED, StubHcclGetLookupRequest(nullptr, 0, HCCL_DATA_TYPE_INT8, 0, nullptr, comm, nullptr));

    EXPECT_EQ(HCCL_E_RESERVED, StubHcclIsetLookupResponse(nullptr, 0, HCCL_DATA_TYPE_INT8, nullptr, comm, nullptr));

    EXPECT_EQ(HCCL_E_RESERVED, StubHcclWaitSome(0, nullptr, nullptr, nullptr, nullptr));

    EXPECT_EQ(HCCL_E_RESERVED, StubHcclAbortSelf(comm, 0));

    EXPECT_EQ(HCCL_E_RESERVED, StubHddsServiceCancel(nullptr));

    EXPECT_EQ(HCCL_E_RESERVED, StubHddsCollRecvUpdateRequest(nullptr, 0, HCCL_DATA_TYPE_INT8, nullptr, 0,
        HCCL_DATA_TYPE_INT8, 0, nullptr, comm, nullptr));

    EXPECT_EQ(HCCL_E_RESERVED, StubHddsIsendUpdateResponse(nullptr, comm, nullptr));

    EXPECT_EQ(HCCL_E_RESERVED, StubHddsCollRecvLookupRequest(nullptr, 0, HCCL_DATA_TYPE_INT8, 0, nullptr, comm, nullptr));

    EXPECT_EQ(HCCL_E_RESERVED, StubHddsIsendLookupResponse(nullptr, 0, HCCL_DATA_TYPE_INT8, nullptr, comm, nullptr));

    EXPECT_EQ(HCCL_E_RESERVED, StubHcomPrepareStart(nullptr, nullptr));

    EXPECT_EQ(HCCL_E_RESERVED, StubHcomPrepareQuery(nullptr, nullptr));

    EXPECT_EQ(HCCL_E_RESERVED, StubHcomSendByOS(nullptr, 0U, HCCL_DATA_TYPE_INT8, 0U, 0U, nullptr, 0U));

    EXPECT_EQ(HCCL_E_RESERVED, StubHcomReceiveByOS(nullptr, 0U, HCCL_DATA_TYPE_INT8, 0U, 0U, nullptr, 0U));

    EXPECT_EQ(HCCL_E_RESERVED, StubHcomInitByRankTable(nullptr, 0U));

    EXPECT_EQ(HCCL_E_RESERVED, StubHcomDestroy());

    EXPECT_EQ(HCCL_E_RESERVED, StubHcomCreateGroup(nullptr, 0U, nullptr));

    EXPECT_EQ(HCCL_E_RESERVED, StubHcomDestroyGroup(nullptr));

    EXPECT_EQ(HCCL_E_RESERVED, StubHcomBroadcastByOS(nullptr, 0UL, 0, 0, nullptr, 0UL));

    EXPECT_EQ(HCCL_E_RESERVED, StubHcomGatherByOS(nullptr, 0UL, 0, nullptr, 0UL, 0, 0, nullptr, 0UL));

    EXPECT_EQ(HCCL_E_RESERVED, StubHcclDestroyResouce(comm, 0));
    hcclSoManager->UnloadSo();
}

TEST_F(AICPUScheduleInterfaceTEST, SingleHcclWaitFail)
{
    MOCKER(StubHcclWaitSome).stubs().will(returnValue(HCCL_E_NOT_SUPPORT));
    HcclRequest request;
    EXPECT_EQ(SingleHcclWait(request), RET_FAILED);
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

    EXPECT_EQ(aicpuModel0.StoreDequedMbuf(0U, 0U, 0U, nullptr, 1U), StoreResult::SUCCESS_STORE);

    // first adding execption transid
    EXPECT_EQ(AICPUModelProcessDataException(&notify), AICPU_SCHEDULE_OK);

    // repeat adding execption transid
    EXPECT_EQ(AICPUModelProcessDataException(&notify), AICPU_SCHEDULE_OK);

    Mbuf *mbuf = nullptr;
    Mbuf **mbufPtr =  &mbuf;
    EXPECT_EQ(aicpuModel0.SelectGatheredMbuf(&mbufPtr, 1000U, 1000U), GatherResult::UN_SELECTED);
    EXPECT_EQ(aicpuModel0.gatheredMbuf_.size(), 0);
    EXPECT_TRUE(aicpuModel0.exceptionTranses_[0]);

    EXPECT_EQ(aicpuModel0.StoreDequedMbuf(0U, 1U, 0U, nullptr, 1U), StoreResult::ABORT_STORE);
    EXPECT_EQ(aicpuModel0.gatheredMbuf_.size(), 0);

    // first expiring execption transid
    notify.type = 1U;
    EXPECT_EQ(AICPUModelProcessDataException(&notify), AICPU_SCHEDULE_OK);
    // repeat expiring execption transid
    EXPECT_EQ(AICPUModelProcessDataException(&notify), AICPU_SCHEDULE_OK);

    EXPECT_EQ(aicpuModel0.StoreDequedMbuf(0U, 2U, 0U, nullptr, 1U), StoreResult::SUCCESS_STORE);
    EXPECT_EQ(aicpuModel0.gatheredMbuf_.size(), 1);

    AicpuModelManager::GetInstance().allModel_[0U].isValid = false;
    AicpuModelManager::GetInstance().allModel_[1U].isValid = false;
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

TEST_F(AICPUScheduleInterfaceTEST, TsKernelProcessDataException_success) {
    DataFlowExceptionNotify notify = {};
    notify.modelIdNum = 2U;
    std::vector<uint32_t> modelIds = {0U, 1U};
    notify.modelIdsAddr = PtrToValue(modelIds.data());

    AicpuModel aicpuModel0;
    aicpuModel0.modelId_ = 0U;
    AicpuModel aicpuModel1;
    aicpuModel1.modelId_ = 0U;
    MOCKER_CPP(&AicpuModelManager::GetModel).stubs()
        .will(returnValue(&aicpuModel0))
        .then(returnValue(&aicpuModel1));

    aicpu::HwtsTsKernel tskenrel = {};
    tskenrel.kernelBase.cceKernel.paramBase = PtrToValue(&notify);
    EXPECT_EQ(process_data_exception_kernel_.Compute(tskenrel), AICPU_SCHEDULE_OK);
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