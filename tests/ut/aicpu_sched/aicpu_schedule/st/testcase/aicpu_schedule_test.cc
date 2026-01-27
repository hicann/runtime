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
#include <list>
#include <memory>
#include <map>
#include <thread>
#include <sys/types.h>
#include <stdlib.h>
#include <sstream>
#include "gtest/gtest.h"
#include "mockcpp/mockcpp.hpp"
#include "ascend_hal.h"
#include "ascend_hal_error.h"
#include <dlfcn.h>
#define private public
#include "aicpu_mc2_maintenance_thread.h"
#include "aicpusd_mc2_maintenance_thread.h"
#include "aicpusd_context.h"
#include "aicpusd_info.h"
#include "aicpusd_interface.h"
#include "aicpusd_status.h"
#include "aicpusd_interface_process.h"
#include "aicpusd_event_manager.h"
#include "aicpusd_event_process.h"
#include "aicpusd_drv_manager.h"
#include "aicpusd_model_execute.h"
#include "task_queue.h"
#include "dump_task.h"
#include "aicpu_sharder.h"
#include "aicpusd_threads_process.h"
#include "aicpusd_task_queue.h"
#include "aicpusd_queue_event_process.h"
#include "tdt_server.h"
#include "adump/ide_daemon_api.h"
#include "aicpu_task_struct.h"
#include "aicpu_context.h"
#include "aicpusd_worker.h"
#include "aicpusd_drv_manager.h"
#include "aicpusd_so_manager.h"
#include "aicpu_event_struct.h"
#include "aicpu_pulse.h"
#include "aicpusd_cust_so_manager.h"
#include "aicpusd_resource_manager.h"
#include "aicpusd_msg_send.h"
#include "aicpu_async_event.h"
#include "ProcMgrSysOperatorAgent.h"
#include "securec.h"
#include "profiling_adp.h"
#include "aicpu_engine.h"
#include "aicpusd_cust_dump_process.h"
#include "aicpu_prof.h"
#include "aicpusd_args_parser.h"
#include "aicpusd_resource_limit.h"
#include "hwts_kernel_dfx.h"
#include "hwts_kernel_model_process.h"
#include "hwts_kernel_queue.h"
#include "aicpusd_message_queue.h"
#include "aicpusd_send_platform_Info_to_custom.h"
#undef private
#include "tsd.h"
#include "aicpusd_util.h"
#include "ProcMgrSysOperatorAgent.h"
#include "aicpusd_mc2_maintenance_thread_api.h"

using namespace AicpuSchedule;
using namespace aicpu;

namespace {
constexpr uint64_t CHIP_MDC = 2U;
constexpr uint64_t CHIP_CLOUD_V2 = 5U;
constexpr uint32_t mbufDataOffSet = 10;
constexpr uint32_t maxMbufNumInMbuflist = 20;
constexpr uint32_t mbufSize = 128;
constexpr uint32_t mbufDataPtrSize = mbufSize-mbufDataOffSet;
constexpr uint32_t maxQueueNum = 64;
constexpr uint32_t modelId = 1;
constexpr uint32_t mbufHeadSize = 4;
char dequeueFakeMBuf[maxQueueNum][maxMbufNumInMbuflist][mbufSize] = {0};
char allocFakeMBuf[maxQueueNum][mbufSize] = {0};
uint32_t allocIndex = 0;
uint32_t singeMbufListIndex = 0;
void* singleMbufList[maxQueueNum] = {0};
std::map<uint32_t, std::list<void*>> enqueueFakeStore;
std::list<uint32_t> mbufChainGetNumReturnValues;
uint32_t dequeueCount = 0;
uint32_t enqueueCount = 0;
constexpr uint32_t MAX_SIZE_NUM = 128U;
AicpuModel *aicpuModel = nullptr;
constexpr uint32_t MAX_SIZE_BUF_FOR_FAKE_EOS = 512U;
char bufForFakeEOS[MAX_SIZE_BUF_FOR_FAKE_EOS] = {0};
void *halMbufGetBuffAddrFakeAddr = nullptr;

RunContext runContextT = {.modelId = modelId,
                .modelTsId = 1,
                .streamId = 1,
                .pending = false,
                .executeInline = true};

static struct event_info g_event = {
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

int32_t halMbufGetBuffAddrFake2(Mbuf *mbuf, void **buf)
{
    *buf = halMbufGetBuffAddrFakeAddr;
    return DRV_ERROR_NONE;
}

int halMbufGetPrivInfoFakeForEOS(Mbuf *mbuf,  void **priv, unsigned int *size)
{
  *priv = (void *)mbuf;
  *size = 256;
  return DRV_ERROR_NONE;
}

drvError_t halQueueDeQueueFakeForEOS(unsigned int devId, unsigned int qid, void **mbuf)
{
  *mbuf = (Mbuf *)bufForFakeEOS;
  return DRV_ERROR_NONE;
}

int halMbufGetPrivInfoFake(Mbuf *mbuf,  void **priv, unsigned int *size)
{
    *priv = (void *)mbuf;
    *size = mbufHeadSize;
    return DRV_ERROR_NONE;
}

drvError_t halQueueDeQueueFake(unsigned int devId, unsigned int qid, void **mbuf)
{
    uint32_t index = qid%maxQueueNum;
    *mbuf = (Mbuf *)dequeueFakeMBuf[index];
    printf("halQueueDeQueueFake mbuf:%p, index:%u\n", *mbuf, index);
    dequeueCount++;
    return DRV_ERROR_NONE;
}
DLLEXPORT drvError_t halQueueEnQueueFake(unsigned int devId, unsigned int qid, void *mbuf)
{
    uint32_t index = qid % maxQueueNum;
    auto enqueueListIter = enqueueFakeStore.find(index);
    if (enqueueListIter != enqueueFakeStore.end()) {
        enqueueListIter->second.push_back(mbuf);
    } else {
        enqueueFakeStore.emplace(std::make_pair(index, std::list<void*>{mbuf}));
    }
    printf("halQueueEnQueueFake mbuf:%p, index:%u\n", mbuf, index);
    enqueueCount++;
    return DRV_ERROR_NONE;
}

int halMbufAllocFake(unsigned int size, unsigned int align, unsigned long flag, int grp_id, Mbuf **mbuf)
{
    uint32_t index = allocIndex++%maxQueueNum;
    *mbuf = (Mbuf *)allocFakeMBuf[index];
    printf("halMbufAllocFake mbuf:%p, index:%u\n", *mbuf, index);
    return 0;
}

int halMbufFreeFake(Mbuf *mbuf)
{
    allocIndex--;
    return 0;
}

int32_t halMbufGetBuffAddrFake(Mbuf *mbuf, void **buf)
{
    // 假设每个dataPtr间隔一个mbufDataOffSet，mbuf指针和第一个dataPtr也间隔一个mbufDataOffSet
    *buf = (void*)((char*)mbuf+mbufDataOffSet);
    printf("getMbufDataPtr mbuf:%p, dataPtr:%p.\n", mbuf, *buf);
    return 0;
}

uint32_t getMbufInMbufListOffSet(uint32_t index)
{
    return mbufSize*index;
}

Mbuf* getMbufInMbufList(Mbuf* mbufChainHead, uint32_t index)
{
    return (Mbuf*)((char*)mbufChainHead+getMbufInMbufListOffSet(index));
}

void* calcMbufDataPtrFack(Mbuf* mbufChainHead, unsigned int index)
{
    void *buf = nullptr;
    halMbufGetBuffAddrFake(getMbufInMbufList(mbufChainHead, index), &buf);
    return buf;
}

int halMbufChainGetMbufFake(Mbuf *mbufChainHead, unsigned int index, Mbuf **mbuf)
{
    *mbuf = getMbufInMbufList(mbufChainHead, index);
    printf("halMbufChainGetMbufFake mbuf:%p, dataPtr:%p, index:%u.\n", mbuf, *mbuf, index);
    return 0;
}

int halMbufChainAppendFake(Mbuf *a, Mbuf *b)
{
    if (singeMbufListIndex == 0) {
        printf("halMbufChainAppendFake add a mbuf:%p, index:%u\n", a, singeMbufListIndex);
        singleMbufList[singeMbufListIndex++] = a;

    }
    printf("halMbufChainAppendFake add b mbuf:%p, index:%u\n", b, singeMbufListIndex);
    singleMbufList[singeMbufListIndex++] = b;
    return 0;
}

int halMbufGetDataLenFake(Mbuf *mbuf, uint64_t *len)
{
    *len = sizeof(RuntimeTensorDesc) + sizeof(uint64_t);
    return 0;
}

int halMbufChainGetMbufNumFack(Mbuf *mbufChainHead, unsigned int *num)
{
    if (!mbufChainGetNumReturnValues.empty()) {
        *num = mbufChainGetNumReturnValues.front();
        mbufChainGetNumReturnValues.pop_front();
        printf("halMbufChainGetMbufNumFack get num:%u\n", *num);
    } else {
        printf("mbufChainGetNumReturnValues is empty, return num 1. \n");
        *num = 1;
    }
    return 0;
}

uint32_t calcGuardBufSize(bool isSingleMbuflistOutput)
{
    if (isSingleMbuflistOutput) {
        // alloc的mbuf使用头指针去守护一次
        uint32_t guardCount = allocIndex > 0 ? 1 : 0;
        return guardCount + dequeueCount - enqueueCount;
    } else {
        // 当前guard数值为：alloc数值+dequeue和enqueue差值
        return allocIndex + dequeueCount - enqueueCount;
    }
}

drvError_t halGetDeviceInfoFake1(uint32_t devId, int32_t moduleType, int32_t infoType, int64_t *value)
{
    if (moduleType == 1 && infoType == 3) {
        *value = 1;
    }
    if (moduleType == 1 && infoType == 8) {
        *value = 65532;
    }

    if ((moduleType == MODULE_TYPE_SYSTEM) && (infoType == INFO_TYPE_VERSION)) {
        *value = CHIP_MDC << 8;
    }
    return DRV_ERROR_NONE;
}

drvError_t halGetDeviceInfoFake2(uint32_t devId, int32_t moduleType, int32_t infoType, int64_t *value)
{
    if (moduleType == 1 && infoType == 3) {
        *value = 8;
    }
    if (moduleType == 1 && infoType == 8) {
        *value = 1020;
    }
    return DRV_ERROR_NONE;
}

StatusCode GetAicpuDeployContextOnHost(DeployContext &deployCtx)
{
    deployCtx = DeployContext::HOST;
    return AICPU_SCHEDULE_OK;
}

StatusCode GetAicpuDeployContextOnHostCpu(DeployContext &deployCtx)
{
    deployCtx = DeployContext::HOSTCPU;
    return AICPU_SCHEDULE_OK;
}

int32_t ExecuteTaskTestStub(const AicpuTaskInfo &kernelTaskInfo, const RunContext &taskContext)
{
    *(const_cast<int32_t *>(&taskContext.gotoTaskIndex)) = 0;
    *(const_cast<bool *>(&taskContext.pending)) = false;
    return AICPU_SCHEDULE_OK;
}

drvError_t halGetDeviceInfoFake1OnHost(uint32_t devId, int32_t moduleType, int32_t infoType, int64_t *value)
{
    if (moduleType == 1 && infoType == 20) {
        *value = 64;
    }
    if (moduleType == 1 && infoType == 21) {
        *value = 0;
    }
    return DRV_ERROR_NONE;
}

drvError_t drvQueryProcessHostPidFake1(int pid, unsigned int *chip_id, unsigned int *vfid,
                                       unsigned int *host_pid, unsigned int *cp_type)
{
    *host_pid = 1;
    *cp_type = DEVDRV_PROCESS_CP1;
    return DRV_ERROR_NONE;
}

drvError_t drvQueryProcessHostPidFake2(int pid, unsigned int *chip_id, unsigned int *vfid,
                                       unsigned int *host_pid, unsigned int *cp_type)
{
    static uint32_t cnt = 0U;
    if (cnt == 0U) {
        ++cnt;
        return DRV_ERROR_NO_PROCESS;
    }

    return DRV_ERROR_UNINIT;
}

drvError_t drvQueryProcessHostPidFake3(int pid, unsigned int *chip_id, unsigned int *vfid,
                                       unsigned int *host_pid, unsigned int *cp_type)
{
    return DRV_ERROR_INNER_ERR;
}

drvError_t drvQueryProcessHostPidFake4(int pid, unsigned int *chip_id, unsigned int *vfid,
                                       unsigned int *host_pid, unsigned int *cp_type)
{
    static uint32_t cnt = 0U;
    if (cnt == 0) {
        ++cnt;
        *host_pid = 1;
        *cp_type = DEVDRV_PROCESS_CP1;
        return DRV_ERROR_NONE;
    }
    *host_pid = 2;
    *cp_type = DEVDRV_PROCESS_CP1;
    return DRV_ERROR_NONE;
}

drvError_t drvQueryProcessHostPidFake5(int pid, unsigned int *chip_id, unsigned int *vfid,
                                       unsigned int *host_pid, unsigned int *cp_type)
{
    return DRV_ERROR_NO_PROCESS;
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
void setSimpleAicpuPrepareInfo(AicpuPrepareInfo &info)
{
    void *input1, *input2, *input3, *input4, *input5;
    /* 假设ge拼接方式*/
    uint64_t inputAddrList[] = {reinterpret_cast<uint64_t>(&input1),
        reinterpret_cast<uint64_t>(&input2),
        reinterpret_cast<uint64_t>(&input3),
        reinterpret_cast<uint64_t>(&input4),
        reinterpret_cast<uint64_t>(&input5)};

    info.aicpuPareInfoSize = sizeof(AicpuPrepareInfo);
    info.modelId = 1;
    info.inputAddrNum = sizeof(inputAddrList) / sizeof(inputAddrList[0]);
    info.inputAddrList = reinterpret_cast<uint64_t>(inputAddrList);
    info.inputIndexList = 0xffff;

    info.outputAddrNum = sizeof(inputAddrList) / sizeof(inputAddrList[0]);
    info.outputAddrList = reinterpret_cast<uint64_t>(inputAddrList);
    info.outputIndexList = 0xffff;
    info.outputMbufNum = 1;
    info.outDataSizeList = 0xffff;

    info.inQueueNum = 1;
    info.inQueueIdList = 0xffff;
    info.outQueueNum = sizeof(inputAddrList) / sizeof(inputAddrList[0]);
    info.outQueueIdList = 0xffff;
    info.mbufPtrlist =reinterpret_cast<uint64_t>(inputAddrList);
}

#define BUILD_SUCC_PREPARE_INFO()                                                                                            \
    aicpuModel = new AicpuModel();                                                                                   \
    aicpuModel->modelId_= modelId;                                                                                            \
    aicpuModel->iteratorCount_ = 1;                                                                                           \
    /*input 准备， dequeue 队列三个，总共返回4个展平后的mbuf， 需要填充5个模型输出 */                 \
    /*假设模型使用的入参数据指针*/                                                                                  \
    void *input1, *input2, *input3, *input4, *input5;                                                                            \
    /* 假设ge拼接方式*/                                                                                                    \
    uint64_t inputAddrList[] = {reinterpret_cast<uint64_t>(&input1),                                                             \
        reinterpret_cast<uint64_t>(&input2),                                                                                     \
        reinterpret_cast<uint64_t>(&input3),                                                                                     \
        reinterpret_cast<uint64_t>(&input4),                                                                                     \
        reinterpret_cast<uint64_t>(&input5)};                                                                                    \
    /* dequeue队列id*/                                                                                                         \
    uint32_t inQueueIdList[] = {10, 3, 7, 9};                                                                                    \
    /* 每个mbuflist返回的mbuf长度*/                                                                                       \
    /* 测试用例只支持最后一个是N，其余是1,因为获取后面的mbuf实际上是+1操作，总计返回4个mbuf*/ \
    std::list<uint32_t> chainNumReturnValues = {1, 1, 1, 1};                                                                     \
    mbufChainGetNumReturnValues = chainNumReturnValues;                                                                          \
                                                                                                                                 \
    /* 需要copy到用户数据指针的mbuf对应dataPtr的序号，对应4个mbuf*/                                           \
    uint32_t inputIndexList[] = {0, 2, 3, 1, 2};                                                                                 \
                                                                                                                                 \
    /* output准备，模型输出4个，申请mbuf3个用于填充，enqueue到3个队列中 模型输出数据指针1*/        \
    void *output1, *output2, *output3, *output4;                                                                                 \
    /* ge拼接方式*/                                                                                                          \
    uint64_t outputAddrList[] = {reinterpret_cast<uint64_t>(&output1),                                                           \
        reinterpret_cast<uint64_t>(&output2),                                                                                    \
        reinterpret_cast<uint64_t>(&output3),                                                                                    \
        reinterpret_cast<uint64_t>(&output4)};                                                                                   \
    /* enqueue队列id*/                                                                                                         \
    uint32_t outQueueIdList[] = {11, 12, 14};                                                                                    \
    /* 每个申请的mbuf数据长度*/                                                                                         \
    uint32_t outDataSizeList[] = {64, 64, 64};                                                                                   \
    /* 需要copy到用户数据指针的mbuf对应dataPtr的序号*/                                                            \
    uint32_t outputIndexList[] = {0, 1, 2, 1};                                                                                   \
    uint64_t mbufPtrlist[sizeof(outQueueIdList) / sizeof(outQueueIdList[0])] = {0};                                              \
                                                                                                                                 \
    AicpuPrepareInfo info;                                                                                                       \
    info.aicpuPareInfoSize = sizeof(AicpuPrepareInfo);                                                                           \
    info.modelId = 1;                                                                                                            \
    info.inputAddrNum = sizeof(inputAddrList) / sizeof(inputAddrList[0]);                                                        \
    info.inputAddrList = reinterpret_cast<uint64_t>(inputAddrList);                                                              \
    info.inputIndexList = reinterpret_cast<uint64_t>(inputIndexList);                                                            \
                                                                                                                                 \
    info.outputAddrNum = sizeof(outputAddrList) / sizeof(outputAddrList[0]);                                                     \
    info.outputAddrList = reinterpret_cast<uint64_t>(outputAddrList);                                                            \
    info.outputIndexList = reinterpret_cast<uint64_t>(outputIndexList);                                                          \
    info.outputMbufNum = sizeof(outDataSizeList) / sizeof(outDataSizeList[0]);                                                   \
    info.outDataSizeList = reinterpret_cast<uint64_t>(outDataSizeList);                                                          \
                                                                                                                                 \
    info.inQueueNum = sizeof(inQueueIdList) / sizeof(inQueueIdList[0]);                                                          \
    info.inQueueIdList = reinterpret_cast<uint64_t>(inQueueIdList);                                                              \
    info.outQueueNum = sizeof(outQueueIdList) / sizeof(outQueueIdList[0]);                                                       \
    info.outQueueIdList = reinterpret_cast<uint64_t>(outQueueIdList);                                                            \
    info.mbufPtrlist = reinterpret_cast<uint64_t>(mbufPtrlist);

// alloc和free同步mocker，halMbufSetDataLen 失败会free
#define MOCK_MBUF_ALLOCK_FAKE()                                    \
    MOCKER(halMbufAllocEx).stubs().will(invoke(halMbufAllocFake)); \
    MOCKER(halMbufFree).stubs().will(invoke(halMbufFreeFake));
}  // namespace

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
        clearData();
        std::cout << "AICPUScheduleTEST SetUP" << std::endl;
    }

    virtual void TearDown()
    {
        clearData();
        GlobalMockObject::verify();
        std::cout << "AICPUScheduleTEST TearDown" << std::endl;
    }

    void clearData()
    {
        BufManager::GetInstance().FreeAllBuf();
        for (uint32_t i = 0; i < singeMbufListIndex; i++) {
            singleMbufList[i] = nullptr;
        }
        singeMbufListIndex = 0;
        enqueueFakeStore.clear();
        runContextT.pending = false;
        mbufChainGetNumReturnValues.clear();
        allocIndex = 0;
        dequeueCount = 0;
        enqueueCount = 0;
        if (aicpuModel != nullptr) {
            delete aicpuModel;
            aicpuModel = nullptr;
        }
    }

public:
    DumpDataInfoTsKernel dump_data_info_kernel_;
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
    EXPECT_EQ(ret, 0);
    ret = AICPUModelDestroy(ModelInfoptr->moduleID);
    EXPECT_EQ(ret, 0);
    free(ModelInfoptr);
    free(streamInfo);
    free(aicpuTaskinfo);
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
// drvError_t halEschedWaitEvent(unsigned int chip_id, unsigned int  thread_index, unsigned int timeoutï¼Œstruct event_info *event)
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
    printf("===========LoadAndExecute: modelId=%d===========\n", modelId);
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

TEST_F(AICPUScheduleTEST, DoOnceTest4AicpuIllegalCPU) {
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
    ret = AicpuEventManager::GetInstance().ProcessHWTSControlEvent(eventInfo);
    EXPECT_NE(ret, AICPU_SCHEDULE_OK);

    ctrlMsg->cmd_type = 20;
    ret = AicpuEventManager::GetInstance().ProcessHWTSControlEvent(eventInfo);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);

    ctrlMsg->cmd_type = 21;
    ret = AicpuEventManager::GetInstance().ProcessHWTSControlEvent(eventInfo);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_NOT_FOUND_EVENT);

    ctrlMsg->cmd_type = AICPU_DATADUMP_LOADINFO;
    ret = AicpuEventManager::GetInstance().ProcessHWTSControlEvent(eventInfo);
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
    MOCKER_CPP(&AicpuEventProcess::ExecuteTsKernelTask)
        .stubs()
        .will(returnValue(0));
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

TEST_F(AICPUScheduleTEST, ProcessHWTSTimoutCfgTestOutRange) {
    MOCKER(aicpu::GetSystemTickFreq)
        .stubs()
        .will(returnValue(0xFFFFFFFFFFFFFFFF));
    event_info eventInfo = g_event;
    eventInfo.priv.msg_len = sizeof(ts_aicpu_sqe_t);
    ts_aicpu_sqe_t *ctrlMsg = reinterpret_cast<ts_aicpu_sqe_t *>(eventInfo.priv.msg);
    ctrlMsg->cmd_type = AICPU_TIMEOUT_CONFIG;
    ctrlMsg->u.ts_to_aicpu_timeout_cfg.op_execute_timeout_en = 1;
    ctrlMsg->u.ts_to_aicpu_timeout_cfg.op_execute_timeout = 2;
    int ret = AicpuEventManager::GetInstance().ProcessHWTSControlEvent(eventInfo);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
}

TEST_F(AICPUScheduleTEST, ProcessHWTSTimoutCloseOpTimer) {
    event_info eventInfo = g_event;
    eventInfo.priv.msg_len = sizeof(ts_aicpu_sqe_t);
    ts_aicpu_sqe_t *ctrlMsg = reinterpret_cast<ts_aicpu_sqe_t *>(eventInfo.priv.msg);
    ctrlMsg->cmd_type = AICPU_TIMEOUT_CONFIG;
    ctrlMsg->u.ts_to_aicpu_timeout_cfg.op_execute_timeout_en = 1;
    ctrlMsg->u.ts_to_aicpu_timeout_cfg.op_execute_timeout = 200;
    ctrlMsg->u.ts_to_aicpu_timeout_cfg.op_wait_timeout_en = 1;
    ctrlMsg->u.ts_to_aicpu_timeout_cfg.op_wait_timeout = 100;
    int ret = AicpuEventManager::GetInstance().ProcessHWTSControlEvent(eventInfo);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
}

TEST_F(AICPUScheduleTEST, ProcessHWTSTimoutReopenOpTimer) {
    event_info eventInfo = g_event;
    eventInfo.priv.msg_len = sizeof(ts_aicpu_sqe_t);
    ts_aicpu_sqe_t *ctrlMsg = reinterpret_cast<ts_aicpu_sqe_t *>(eventInfo.priv.msg);
    ctrlMsg->cmd_type = AICPU_TIMEOUT_CONFIG;
    ctrlMsg->u.ts_to_aicpu_timeout_cfg.op_execute_timeout_en = 1;
    ctrlMsg->u.ts_to_aicpu_timeout_cfg.op_execute_timeout = 200;
    ctrlMsg->u.ts_to_aicpu_timeout_cfg.op_wait_timeout_en = 1;
    ctrlMsg->u.ts_to_aicpu_timeout_cfg.op_wait_timeout = 300;
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

TEST_F(AICPUScheduleTEST, InitAICPUSchedulerTest_SUCCESS) {
    AicpuScheduleInterface::GetInstance().initFlag_ = true;
    MOCKER_CPP(&ThreadPool::CreateWorker)
        .stubs()
        .will(returnValue(0));
    std::vector<uint32_t> deviceVec;
    deviceVec.push_back(1);
    std::string ch = "000000000000000000000000000000000000000000000000";
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
    eventInfo.comm.event_id = EVENT_TS_HWTS_KERNEL;
    // MOCKER_CPP(&AicpuEventManager::ProcessHWTSKernelEvent)
    //     .stubs()
    //     .will(returnValue(0));
    int ret = AicpuEventManager::GetInstance().ProcessEvent(eventInfo, 0);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);

    eventInfo.comm.event_id = EVENT_DVPP_MSG;
    ret = AicpuEventManager::GetInstance().ProcessEvent(eventInfo, 0);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);

    eventInfo.comm.event_id = EVENT_FR_MSG;
    ret = AicpuEventManager::GetInstance().ProcessEvent(eventInfo, 0);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);

    eventInfo.comm.event_id = EVENT_RANDOM_KERNEL;
    ret = AicpuEventManager::GetInstance().ProcessEvent(eventInfo, 0);
    EXPECT_EQ(ret, AICPU_SCHEDULE_FAIL);

    eventInfo.comm.event_id = EVENT_TS_CTRL_MSG;
    ret = AicpuEventManager::GetInstance().ProcessEvent(eventInfo, 0);
    EXPECT_NE(ret, AICPU_SCHEDULE_OK);

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

    eventInfo.comm.event_id = EVENT_QUEUE_EMPTY_TO_NOT_EMPTY;
    eventInfo.comm.subevent_id = 1;
    ret = AicpuEventManager::GetInstance().ProcessEvent(eventInfo, 0);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);

    eventInfo.comm.event_id = EVENT_QUEUE_FULL_TO_NOT_FULL;
    eventInfo.comm.subevent_id = 1;
    ret = AicpuEventManager::GetInstance().ProcessEvent(eventInfo, 0);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);

    eventInfo.comm.event_id = EVENT_TIMER;
    eventInfo.comm.subevent_id = 1;
    ret = AicpuEventManager::GetInstance().ProcessEvent(eventInfo, 0);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_NOT_FOUND_EVENT);
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
    AicpuSqeAdapter ada(eventMsgLoadOpMappingInfo, 0U);
    EXPECT_EQ(LoadOpMappingInfo(opMappingInfoStr.c_str(), opMappingInfoStr.length()), AICPU_SCHEDULE_OK);
    ret = AicpuEventProcess::GetInstance().ProcessLoadOpMappingEvent(ada);
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

TEST_F(AICPUScheduleTEST, FftsPlusDumpDataFailThreadId) {
    MOCKER_CPP(&IdeDumpData)
        .stubs()
        .will(returnValue(0));
    MOCKER_CPP(&IdeDumpStart)
        .stubs()
        .will(returnValue((void *)111));
    MOCKER(memcpy_s).stubs().will(returnValue(EOK));
    const uint32_t taskId = 40;
    const uint32_t streamId = 40;
    const uint32_t contextId = 1;
    const uint32_t modelId = 222;
    int32_t input[8] = {1, 2, 3, 4, 5, 6, 7 ,8};
    int32_t *inputaddress = &input[0];
    int32_t inputSize = sizeof(input);
    int32_t inputoffset = 2 * sizeof(int32_t);

    int32_t output[4] = {1, 2, 3, 4};
    int32_t *outputaddress = &output[0];
    int32_t outputSize = sizeof(output);
    int32_t outputoffset = 2 * sizeof(int32_t);
    const int32_t dataType = 7; // int32
    aicpu::dump::OpMappingInfo opMappingInfo;

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
        aicpu::dump::Output *output = task->add_output();
        {
            output->set_data_type(dataType);
            output->set_format(1);
            aicpu::dump::Shape *shape = output->mutable_shape();
            {
                shape->add_dim(2);
                shape->add_dim(2);
            }

            aicpu::dump::Shape *originShape = output->mutable_origin_shape();
            {
                originShape->add_dim(2);
                originShape->add_dim(2);
            }
            output->set_addr_type(0);
            output->set_address(reinterpret_cast<uint64_t>(&outputaddress));
            output->set_original_name("original_name");
            output->set_original_output_index(11);
            output->set_original_output_data_type(dataType);
            output->set_original_output_format(1);
            output->set_size(outputSize);
            output->set_offset(outputoffset);
        }
        // task->set_end_graph();
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
    opMappingInfo.set_dump_data(0);

    std::string opMappingInfoStr;
    opMappingInfo.SerializeToString(&opMappingInfoStr);
    OpDumpTaskManager &opDumpTaskMgr = OpDumpTaskManager::GetInstance();
    EXPECT_EQ(opDumpTaskMgr.LoadOpMappingInfo(opMappingInfoStr.c_str(), opMappingInfoStr.length()), AICPU_SCHEDULE_OK);

    TaskInfoExt dumpTaskInfo;
    dumpTaskInfo.streamId_ = streamId;
    dumpTaskInfo.taskId_ = taskId;
    dumpTaskInfo.contextId_ = contextId;
    dumpTaskInfo.threadId_ = 4;
    DumpFileName name(streamId, taskId, contextId, 4);
    EXPECT_EQ(opDumpTaskMgr.DumpOpInfo(dumpTaskInfo, name), AICPU_SCHEDULE_OK);

    dumpTaskInfo.streamId_ = streamId;
    dumpTaskInfo.taskId_ = taskId;
    dumpTaskInfo.contextId_ = contextId;
    dumpTaskInfo.threadId_ = 8;
    DumpFileName name1(streamId, taskId, contextId, 8);
    EXPECT_EQ(opDumpTaskMgr.DumpOpInfo(dumpTaskInfo, name1), AICPU_SCHEDULE_OK);

    // unload model
    opMappingInfo.set_flag(0x00);
    opMappingInfo.SerializeToString(&opMappingInfoStr);
    opDumpTaskMgr.LoadOpMappingInfo(opMappingInfoStr.c_str(), opMappingInfoStr.length());
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
    DumpFileName name(streamId, taskId);
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
    aicpu::dump::DimRange *dimRange = output->add_dim_range();
    dimRange->set_dim_start(1);
    dimRange->set_dim_end(2);

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
        task.inputsAddrType_.push_back(0);
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
        task.outputsAddrType_.push_back(0);
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
        EXPECT_EQ(task.ProcessInputDump(task.baseDumpData_, "", IdeDumpStart(nullptr)), AICPU_SCHEDULE_ERROR_DUMP_FAILED);
    }
}

TEST_F(AICPUScheduleTEST, ProcessOutputDump_invalid_threadId) {
    OpDumpTask task(0, 0);
    ::toolkit::dumpdata::OpOutput *opOutput = task.baseDumpData_.add_output();
    if (opOutput != nullptr) {
        uint64_t addr = 2;
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
        int32_t data = 1;
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
        int32_t data = 1;
        uint64_t addr = (uint64_t)(&data);
        opOutput->set_size(sizeof(data));
        task.outputsBaseAddr_.push_back((uint64_t)(&addr));
        task.outputsAddrType_.push_back(0);
        task.taskType_ = aicpu::dump::Task::AICPU;
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

TEST_F(AICPUScheduleTEST, SingleOpOrUnknownShapeOpDumpTest) {
    const int32_t dataType = 7; //int32
    aicpu::dump::OpMappingInfo opMappingInfo;

    opMappingInfo.set_dump_path("dump_path");

    uint64_t stepId = 1;
    opMappingInfo.set_step_id_addr(reinterpret_cast<uint64_t>(&stepId));
    aicpu::dump::Task *task = opMappingInfo.add_task();

    aicpu::dump::Op *op = task->mutable_op();
    op->set_op_name("handsome");
    op->set_op_type("Handsome");

    aicpu::dump::Output *output = task->add_output();
    output->set_data_type(dataType);
    output->set_format(1);
    aicpu::dump::Shape *shape = output->mutable_shape();
    shape->add_dim(2);
    shape->add_dim(2);
    int32_t data[4] = {1, 2, 3, 4};
    int32_t *p = &data[0];
    output->set_address(reinterpret_cast<uint64_t>(p));
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
    int32_t inData[4] = {10, 20, 30, 40};
    int32_t *q = &(inData[0]);
    input->set_address(reinterpret_cast<uint64_t>(q));
    input->set_size(sizeof(inData));

    std::string opMappingInfoStr;
    opMappingInfo.SerializeToString(&opMappingInfoStr);
    uint64_t protoSize = opMappingInfoStr.size();

    HwtsTsKernel kernelInfo = {0};
    kernelInfo.kernelType = aicpu::KERNEL_TYPE_AICPU;
    kernelInfo.kernelBase.cceKernel.kernelSo = 0;
    const char *kernelName = "DumpDataInfo";
    kernelInfo.kernelBase.cceKernel.kernelName = uint64_t(kernelName);
    const uint32_t singleOpDumpParamNum = 2;
    const uint32_t paramLen =  sizeof(AicpuParamHead) + singleOpDumpParamNum*sizeof(uint64_t);
    std::unique_ptr<char[]> buff(new (std::nothrow) char[paramLen]);
    if (buff == nullptr) {
        return;
    }
    AicpuParamHead *paramHead = (AicpuParamHead*)(buff.get());
    paramHead->length = paramLen;
    paramHead->ioAddrNum = 2;
    uint64_t *param = (uint64_t*)((char*)(buff.get()) + sizeof(AicpuParamHead));
    param[0] = uint64_t(opMappingInfoStr.data());
    param[1] = uint64_t(&protoSize);
    kernelInfo.kernelBase.cceKernel.paramBase = uint64_t(buff.get());

    EXPECT_EQ(dump_data_info_kernel_.Compute(kernelInfo), AICPU_SCHEDULE_OK);
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
    char *kernelname = "TestKernelNameExceptionAbnormalLongOverFlowTestKernelNameExceptionAbnormalLongOverFlowTestKernelNameExceptionAbnormalLongOverFlowTestKernelNameExceptionAbnormalLongOverFlowTestKernelNameExceptionAbnormalLongOverFlow";
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

TEST_F(AICPUScheduleTEST, StopTdtServerERROR1) {
    ComputeProcess::GetInstance().isStartTdtFlag_ = false;
    ComputeProcess::GetInstance().StopTdtServer();
    EXPECT_EQ(ComputeProcess::GetInstance().runMode_, aicpu::AicpuRunMode::PROCESS_SOCKET_MODE);
}

TEST_F(AICPUScheduleTEST, StopTdtServerERROR2) {
    ComputeProcess::GetInstance().isStartTdtFlag_ = true;
    MOCKER(&tdt::TDTServerStop)
        .stubs()
        .will(returnValue(1));
    ComputeProcess::GetInstance().StopTdtServer();
    EXPECT_EQ(ComputeProcess::GetInstance().runMode_, aicpu::AicpuRunMode::PROCESS_SOCKET_MODE);
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
    deviceVec.push_back(0);
    const AicpuSchedMode schedMode = SCHED_MODE_INTERRUPT;
    int ret = ComputeProcess::GetInstance().Start(deviceVec, 100, ch, PROFILING_OPEN, 0, aicpu::PROCESS_PCIE_MODE, schedMode);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
}

TEST_F(AICPUScheduleTEST, TdtServerTestSuccessWithoutDcpu_01) {
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

TEST_F(AICPUScheduleTEST, TdtServerTestSuccessWithoutDcpu_02) {
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

TEST_F(AICPUScheduleTEST, getTopic_01) {
    MOCKER_CPP(&ThreadPool::CreateWorker)
        .stubs()
        .will(returnValue(0));
    MOCKER(halEschedGetEvent)
        .stubs()
        .will(returnValue(DRV_ERROR_NO_EVENT));
    std::string ch = "000000000000000000000000000000000000000000000000";
    std::vector<uint32_t> deviceVec;
    deviceVec.push_back(0);
    const AicpuSchedMode schedMode = SCHED_MODE_INTERRUPT;
    int ret = ComputeProcess::GetInstance().Start(deviceVec, 100, ch, PROFILING_OPEN, 0, aicpu::PROCESS_PCIE_MODE, schedMode);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
    SharderWork shard = nullptr;
    EXPECT_EQ(SharderNonBlock::GetInstance().GetCPUNum(), 1);
}

extern int32_t ComputeProcessMain(int32_t argc, char* argv[]);

TEST_F(AICPUScheduleTEST, MainTest) {
    char processName[] = "aicpu_scheduler";
    char paramDeviceIdOk[] = "--deviceId=1";
    char paramPidOk[] = "--pid=2";
    char paramPidSignOk[] = "--pidSign=12345A";
    char paramModeOk[] = "--profilingMode=1";
    char paramLogLevelOk[] = "--logLevelInPid=0";

    MOCKER(system)
        .stubs()
        .will(returnValue(0));

    char* argv[] = { processName, paramDeviceIdOk, paramPidOk, paramPidSignOk, paramModeOk, paramLogLevelOk };
    int32_t argc = 5;
    MOCKER_CPP(&AicpuScheduleInterface::InitAICPUScheduler)
        .stubs()
        .will(returnValue(20));
    int32_t ret = ComputeProcessMain(argc, argv);
    EXPECT_EQ(ret, -1);
}

TEST_F(AICPUScheduleTEST, MainTestGroup) {
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
}

TEST_F(AICPUScheduleTEST, AICPUPreOpenKernels_SUCCESS) {
    char test[10] = "test";
    int ret = AICPUPreOpenKernels(test);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
}

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
    char paramGrpNumErr2[] = "--groupNameNum=-2";
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

    char *argv5[] = {processName, paramDeviceIdOk, paramPidOk,  paramPidSignOk,  paramModeErr};
    int32_t argc5 = 5;
    ret = ComputeProcessMain(argc5, argv5);
    EXPECT_EQ(ret, -1);

    char *argv6[] = {processName, paramDeviceIdOk, paramPidOk,  paramPidSignOk,  paramModeOk, paramVfIdErr1};
    int32_t argc6 = 6;
    ret = ComputeProcessMain(argc6, argv6);
    EXPECT_EQ(ret, -1);

    char *argv7[] = {processName, paramDeviceIdOk, paramPidOk,  paramPidSignOk,  paramModeOk, paramVfIdErr2};
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
    char *argv11[] = {processName, paramDeviceIdOk, paramPidOk, paramPidSignOk, paramModeOk,
                      paramLogLevelOk, paramGrpNameErr2, paramGrpNumErr2};
    int32_t argc11 = 8;
    ret = ComputeProcessMain(argc11, argv11);
    EXPECT_EQ(ret, -1);
    char *argv12[] = {processName, paramDeviceIdOk, paramPidOk, paramPidSignOk, paramModeOk,
                      paramLogLevelOk, paramGrpNameErr1, paramGrpNumErr1};
    int32_t argc12 = 8;
    ret = ComputeProcessMain(argc12, argv12);
    MOCKER(halGrpAttach).stubs().will(returnValue(1));
    MOCKER_CPP(&AicpuScheduleInterface::InitAICPUScheduler)
        .stubs()
        .will(returnValue(0));
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

    char* argv[] = { processName, paramDeviceIdOk, paramPidOk, paramPidSignOk, paramModeOk };
    int32_t argc = 5;
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

TEST_F(AICPUScheduleTEST, GetThreadVfAicpuDCpuInfo) {
    std::vector<uint32_t> deviceVec;
    deviceVec.push_back(1);
    int ret = AicpuDrvManager::GetInstance().GetThreadVfAicpuDCpuInfo(deviceVec);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
}

TEST_F(AICPUScheduleTEST, GetNormalAicpuInfoInVf) {
    std::vector<uint32_t> deviceVec;
    deviceVec.push_back(1);
    int ret = AicpuDrvManager::GetInstance().GetNormalAicpuInfo(deviceVec);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
}

TEST_F(AICPUScheduleTEST, GetNormalAicpuInfoInVfFail) {
    MOCKER(halGetDeviceInfo)
        .stubs()
        .will(returnValue(1));
    std::vector<uint32_t> deviceVec;
    deviceVec.push_back(1);
    int ret = AicpuDrvManager::GetInstance().GetNormalAicpuInfo(deviceVec);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_INIT_FAILED);
}

TEST_F(AICPUScheduleTEST, InitDrvMgrVf32) {
    std::vector<uint32_t> deviceVec;
    deviceVec.push_back(32);
    int ret = AicpuDrvManager::GetInstance().InitDrvMgr(deviceVec, 3200, 0, false);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
}

TEST_F(AICPUScheduleTEST, InitDrvMgrDevice1Vf1) {
    std::vector<uint32_t> deviceVec;
    deviceVec.push_back(1);
    int ret = AicpuDrvManager::GetInstance().InitDrvMgr(deviceVec, 3200, 1, false);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
}

TEST_F(AICPUScheduleTEST, InitDrvMgrVf32GetVfFail) {
    MOCKER(halGetDeviceInfo)
        .stubs()
        .will(returnValue(1));
    std::vector<uint32_t> deviceVec;
    deviceVec.push_back(32);
    int ret = AicpuDrvManager::GetInstance().InitDrvMgr(deviceVec, 3200, 0, false);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_INIT_FAILED);
}

TEST_F(AICPUScheduleTEST, CheckBindHostPid001) {
    AicpuDrvManager &drvMgr = AicpuDrvManager::GetInstance();
    MOCKER(drvQueryProcessHostPid)
        .stubs()
        .will(invoke(drvQueryProcessHostPidFake1));
    drvMgr.hostPid_ = 1;
    int32_t bindPidRet = drvMgr.CheckBindHostPid();
    EXPECT_EQ(bindPidRet, AICPU_SCHEDULE_OK);
}

TEST_F(AICPUScheduleTEST, CheckBindHostPid002) {
    AicpuDrvManager &drvMgr = AicpuDrvManager::GetInstance();
    MOCKER(drvQueryProcessHostPid).stubs().will(invoke(drvQueryProcessHostPidFake2));
    drvMgr.hostPid_ = 1;
    int32_t bindPidRet = drvMgr.CheckBindHostPid();
    EXPECT_EQ(bindPidRet, AICPU_SCHEDULE_ERROR_DRV_ERR);
}

TEST_F(AICPUScheduleTEST, CheckBindHostPid003) {
    AicpuDrvManager &drvMgr = AicpuDrvManager::GetInstance();
    MOCKER(drvQueryProcessHostPid)
        .stubs()
        .will(invoke(drvQueryProcessHostPidFake3));
    int32_t bindPidRet = drvMgr.CheckBindHostPid();
    EXPECT_EQ(bindPidRet, AICPU_SCHEDULE_ERROR_DRV_ERR);
}

TEST_F(AICPUScheduleTEST, CheckBindHostPid004) {
    AicpuDrvManager &drvMgr = AicpuDrvManager::GetInstance();
    MOCKER(drvQueryProcessHostPid)
        .stubs()
        .will(invoke(drvQueryProcessHostPidFake4));
    drvMgr.hostPid_ = 2;
    int32_t bindPidRet = drvMgr.CheckBindHostPid();
    EXPECT_EQ(bindPidRet, AICPU_SCHEDULE_ERROR_DRV_ERR);
}

TEST_F(AICPUScheduleTEST, CheckBindHostPid005) {
    AicpuDrvManager &drvMgr = AicpuDrvManager::GetInstance();
    MOCKER(drvQueryProcessHostPid)
        .stubs()
        .will(invoke(drvQueryProcessHostPidFake5));
    drvMgr.hostPid_ = 2;
    int32_t bindPidRet = drvMgr.CheckBindHostPid();
    EXPECT_EQ(bindPidRet, AICPU_SCHEDULE_ERROR_DRV_ERR);
}

TEST_F(AICPUScheduleTEST, InitSocType_CHIP_CLOUD_V2) {
    AicpuDrvManager inst;
    int64_t deviceInfo = CHIP_CLOUD_V2 << 8;
    MOCKER(halGetDeviceInfo)
        .stubs()
        .with(mockcpp::any(), mockcpp::any(), mockcpp::any(), outBoundP(&deviceInfo))
        .will(returnValue(DRV_ERROR_NONE));
    char socVersion[] = "Ascend910_93";
    MOCKER(halGetSocVersion)
        .stubs()
        .with(mockcpp::any(), outBoundP(socVersion, strlen(socVersion)), mockcpp::any())
        .will(returnValue(DRV_ERROR_NONE));

    inst.InitSocType(0);

    EXPECT_TRUE(FeatureCtrl::IsBindPidByHal());
    EXPECT_TRUE(FeatureCtrl::IfCheckEventSender());
    EXPECT_TRUE(FeatureCtrl::IsDoubleDieProduct());

    FeatureCtrl::aicpuFeatureBindPidByHal_ = false;
    FeatureCtrl::aicpuFeatureDoubleDieProduct_ = false;
    FeatureCtrl::aicpuFeatureCheckEventSender_ = false;
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
    deviceVec.push_back(0);
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
    deviceVec.push_back(0);
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



TEST_F(AICPUScheduleTEST, SendAicpuRecordSuccessMsg_success)
{
    aicpu::AsyncNotifyInfo notifyInfo;
    notifyInfo.taskId = 11;
    notifyInfo.streamId = 11;
    notifyInfo.waitId = 1;
    notifyInfo.waitType = 1;
    notifyInfo.retCode = 0;
    
    MOCKER(tsDevSendMsgAsync)
        .stubs()
        .will(returnValue(0));
    AicpuMsgSend::AicpuReportNotifyInfo(notifyInfo);
    AicpuMsgSend::SendAicpuRecordMsg(&notifyInfo, sizeof(aicpu::AsyncNotifyInfo));
    EXPECT_EQ(notifyInfo.retCode, 0);
}

TEST_F(AICPUScheduleTEST, SendAicpuRecordExceptionMsg_success)
{
    AsyncNotifyInfo notifyInfo;
    notifyInfo.taskId = 11;
    notifyInfo.streamId = 11;
    notifyInfo.waitId = 1;
    notifyInfo.waitType = 1;
    notifyInfo.retCode = 0;

    MOCKER(tsDevSendMsgAsync).stubs().will(returnValue(1));
    AicpuMsgSend::AicpuReportNotifyInfo(notifyInfo);

    MOCKER(halTsDevRecord)
            .stubs()
            .will(returnValue(0));
    AicpuMsgSend::SendAicpuRecordMsg(&notifyInfo, sizeof(aicpu::AsyncNotifyInfo));
    EXPECT_EQ(notifyInfo.retCode, 0);
}

TEST_F(AICPUScheduleTEST, SetAffinityBySelfTest) {
    MOCKER_CPP(&ThreadPool::WriteTidForAffinity)
        .stubs()
        .will(returnValue(0));
    MOCKER(pthread_setaffinity_np)
        .stubs()
        .will(returnValue(0))
        .then(returnValue(-1));
    MOCKER_CPP(&ThreadPool::PostSem)
        .stubs();
    setenv("PROCMGR_AICPU_CPUSET", "0", 1);
    ThreadPool tp;
    tp.threadStatusList_ = std::move(std::vector<ThreadStatus>(1, ThreadStatus::THREAD_INIT));
    EXPECT_EQ(tp.SetAffinity(0, 0), 0);

    tp.threadStatusList_ = std::move(std::vector<ThreadStatus>(1, ThreadStatus::THREAD_INIT));
    EXPECT_NE(tp.SetAffinity(0, 0), 0);
}

TEST_F(AICPUScheduleTEST, SetAffinityBySelfTest2)
{
    MOCKER_CPP(&ThreadPool::WriteTidForAffinity).stubs().will(returnValue(0));
    MOCKER_CPP(&halGetVdevNum).stubs().will(returnValue(1));
    ThreadPool tp;
    tp.threadStatusList_ = std::move(std::vector<ThreadStatus>(1, ThreadStatus::THREAD_INIT));
    EXPECT_EQ(tp.SetAffinityBySelf(0, 32), AICPU_SCHEDULE_ERROR_FROM_DRV);
}

TEST_F(AICPUScheduleTEST, SetAffinityBySelfTest3)
{
    MOCKER_CPP(&ThreadPool::WriteTidForAffinity).stubs().will(returnValue(1));
    MOCKER_CPP(&halGetVdevNum).stubs().will(returnValue(0));
    ThreadPool tp;
    tp.threadStatusList_ = std::move(std::vector<ThreadStatus>(1, ThreadStatus::THREAD_INIT));
    EXPECT_EQ(tp.SetAffinityBySelf(0, 0), AICPU_SCHEDULE_ERROR_INIT_FAILED);
}

TEST_F(AICPUScheduleTEST, SetAffinity_Success)
{
    MOCKER_CPP(&FeatureCtrl::IsBindPidByHal).stubs().will(returnValue(true));
    MOCKER(&halBindCgroup).stubs().will(returnValue(0));
    MOCKER(pthread_setaffinity_np)
        .stubs()
        .will(returnValue(0))
        .then(returnValue(-1));
    MOCKER_CPP(&ThreadPool::PostSem)
        .stubs();
    ThreadPool tp;
    tp.threadStatusList_ = std::move(std::vector<ThreadStatus>(1, ThreadStatus::THREAD_INIT));
    EXPECT_EQ(tp.SetAffinity(0, 0), AICPU_SCHEDULE_OK);
}

TEST_F(AICPUScheduleTEST, SetAffinity_Fail)
{
    MOCKER_CPP(&FeatureCtrl::IsBindPidByHal).stubs().will(returnValue(true));
    MOCKER(&halBindCgroup).stubs().will(returnValue(1));
    MOCKER(pthread_setaffinity_np)
        .stubs()
        .will(returnValue(0))
        .then(returnValue(-1));
    MOCKER_CPP(&ThreadPool::PostSem)
        .stubs();
    ThreadPool tp;
    tp.threadStatusList_ = std::move(std::vector<ThreadStatus>(1, ThreadStatus::THREAD_INIT));
    EXPECT_EQ(tp.SetAffinity(0, 0), AICPU_SCHEDULE_ERROR_INIT_FAILED);
}

TEST_F(AICPUScheduleTEST, SetAffinityByPmTest_Succ) {
    setenv("PROCMGR_AICPU_CPUSET", "1", 1);
    ThreadPool tp;
    tp.threadStatusList_ = std::move(std::vector<ThreadStatus>(1, ThreadStatus::THREAD_INIT));
    EXPECT_EQ(tp.SetAffinity(0, 0), 0);
}

TEST_F(AICPUScheduleTEST, SetAffinityByPmTest_Failed) {
    MOCKER(ProcMgrBindThread)
        .stubs()
        .will(returnValue(2));
    setenv("PROCMGR_AICPU_CPUSET", "1", 1);
    ThreadPool tp;
    tp.threadStatusList_ = std::move(std::vector<ThreadStatus>(1, ThreadStatus::THREAD_INIT));
    EXPECT_NE(tp.SetAffinity(0, 0), 0);
}

TEST_F(AICPUScheduleTEST, SetAffinityBySelfSuccessWithNormalAicpuIndex) {
    AicpuDrvManager::GetInstance().aicpuNumPerDev_ = 1;
    AicpuDrvManager::GetInstance().aicpuIdVec_ = {2};
    MOCKER_CPP(&ThreadPool::WriteTidForAffinity).stubs().will(returnValue(0));
    ThreadPool tp;
    tp.threadStatusList_ = std::move(std::vector<ThreadStatus>(1, ThreadStatus::THREAD_INIT));
    EXPECT_EQ(tp.SetAffinityBySelf(0, 0), AICPU_SCHEDULE_OK);
}

TEST_F(AICPUScheduleTEST, InitDrvMgrfailedWithAbnormalAicpuCoreIndex) {
    MOCKER(halGetDeviceInfo).stubs().will(invoke(halGetDeviceInfoFake1));
    std::vector<uint32_t> deviceVec;
    deviceVec.push_back(31U);
    int ret = AicpuDrvManager::GetInstance().InitDrvMgr(deviceVec, 3200, 0, false);
    AicpuDrvManager::GetInstance().aicpuNumPerDev_ = 1;
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_INIT_FAILED);
}

TEST_F(AICPUScheduleTEST, LoadQueueInfo_success1) {
    AicpuModel *aicpuModel = new AicpuModel();

    AicpuModelInfo modelInfoT;
    QueInfo modelQueueInfo = {0};
    modelQueueInfo.queueID = 1;
    modelQueueInfo.flag = 0;
    modelInfoT.queueSize = 1;
    modelInfoT.queueInfoPtr = (uintptr_t)&modelQueueInfo;
    int ret = aicpuModel->LoadQueueInfo(&modelInfoT);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
    delete aicpuModel;
    aicpuModel = nullptr;
}

TEST_F(AICPUScheduleTEST, LoadQueueInfo_success2) {
    AicpuModel *aicpuModel = new AicpuModel();

    AicpuModelInfo modelInfoT;
    QueInfo modelQueueInfo = {0};
    modelQueueInfo.queueID = 1;
    modelQueueInfo.flag = 1;
    modelInfoT.queueSize = 1;
    modelInfoT.queueInfoPtr = (uintptr_t)&modelQueueInfo;
    int ret = aicpuModel->LoadQueueInfo(&modelInfoT);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
    delete aicpuModel;
    aicpuModel = nullptr;
}

TEST_F(AICPUScheduleTEST, LoadQueueInfo_success3) {
    AicpuModel *aicpuModel = new AicpuModel();

    AicpuModelInfo modelInfoT;
    QueInfo modelQueueInfo = {0};
    modelQueueInfo.queueID = 1;
    modelQueueInfo.flag = 2;
    modelInfoT.queueSize = 1;
    modelInfoT.queueInfoPtr = (uintptr_t)&modelQueueInfo;
    int ret = aicpuModel->LoadQueueInfo(&modelInfoT);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
    delete aicpuModel;
    aicpuModel = nullptr;
}

TEST_F(AICPUScheduleTEST, LoadQueueInfo_InfoNullPtrFailed) {
    AicpuModel *aicpuModel = new AicpuModel();

    AicpuModelInfo modelInfoT;
    modelInfoT.queueSize = 1;
    modelInfoT.queueInfoPtr = (uintptr_t)nullptr;
    int ret = aicpuModel->LoadQueueInfo(&modelInfoT);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID);
    delete aicpuModel;
    aicpuModel = nullptr;
}

TEST_F(AICPUScheduleTEST, LoadQueueInfo_InitFailed) {
    AicpuModel *aicpuModel = new AicpuModel();
    MOCKER(halQueueInit)
        .stubs()
        .will(returnValue(DRV_ERROR_QUEUE_INNER_ERROR));
    AicpuModelInfo modelInfoT;
    QueInfo modelQueueInfo = {0};
    modelQueueInfo.queueID = 1;
    modelQueueInfo.flag = 1;
    modelInfoT.queueSize = 1;
    modelInfoT.queueInfoPtr = (uintptr_t)&modelQueueInfo;
    int ret = aicpuModel->LoadQueueInfo(&modelInfoT);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_FROM_DRV);
    delete aicpuModel;
    aicpuModel = nullptr;
}

TEST_F(AICPUScheduleTEST, LoadQueueInfo_QueueAttachFailed1) {
    AicpuModel *aicpuModel = new AicpuModel();
    MOCKER(halQueueAttach)
        .stubs()
        .will(returnValue(DRV_ERROR_QUEUE_INNER_ERROR));
    AicpuModelInfo modelInfoT;
    QueInfo modelQueueInfo = {0};
    modelQueueInfo.queueID = 1;
    modelQueueInfo.flag = 0;
    modelInfoT.queueSize = 1;
    modelInfoT.queueInfoPtr = (uintptr_t)&modelQueueInfo;
    int ret = aicpuModel->LoadQueueInfo(&modelInfoT);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_FROM_DRV);
    delete aicpuModel;
    aicpuModel = nullptr;
}

TEST_F(AICPUScheduleTEST, LoadQueueInfo_QueueAttachFailed2) {
    AicpuModel *aicpuModel = new AicpuModel();
    MOCKER(halQueueAttach)
        .stubs()
        .will(returnValue(DRV_ERROR_QUEUE_INNER_ERROR));
    AicpuModelInfo modelInfoT;
    QueInfo modelQueueInfo = {0};
    modelQueueInfo.queueID = 1;
    modelQueueInfo.flag = 1;
    modelInfoT.queueSize = 1;
    modelInfoT.queueInfoPtr = (uintptr_t)&modelQueueInfo;
    int ret = aicpuModel->LoadQueueInfo(&modelInfoT);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_FROM_DRV);
    delete aicpuModel;
    aicpuModel = nullptr;
}

RunContext runContextM = {.modelId = 1,
                .modelTsId = 1,
                .streamId = 1,
                .pending = false,
                .executeInline = true};

TEST_F(AICPUScheduleTEST, ExecuteNextTask_success1) {
    bool streamEnd = false;
    AicpuStream *aicpuStream = new AicpuStream();
    int ret = aicpuStream->ExecuteNextTask(runContextM, streamEnd);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
    delete aicpuStream;
    aicpuStream = nullptr;
}

TEST_F(AICPUScheduleTEST, ExecuteNextTask_successTaskIndex) {
    bool streamEnd = false;
    std::string kernelName = "modelReportStatus";
    AicpuStream *aicpuStream = new AicpuStream();
    AicpuTaskInfo taskInfo = {};
    taskInfo.kernelName = PtrToValue(kernelName.data());
    taskInfo.paraBase = 0UL;
    aicpuStream->tasks_.clear();
    aicpuStream->tasks_.push_back(taskInfo);

    MOCKER(&AicpuStream::ExecuteTask).stubs().will(invoke(ExecuteTaskTestStub));
    int ret = aicpuStream->ExecuteNextTask(runContextM, streamEnd);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
    runContextM.gotoTaskIndex = -1;
    delete aicpuStream;
    aicpuStream = nullptr;
}

TEST_F(AICPUScheduleTEST, ExecuteNextTask_success2) {
    RunContext runContextT2 = {.modelId = 1,
                .modelTsId = 1,
                .streamId = 1,
                .pending = true,
                .executeInline = true};

    bool streamEnd = false;
    AicpuStream *aicpuStream = new AicpuStream();

    std::vector<const AicpuTaskInfo *> tasksT;

    AicpuTaskInfo aicpuTaskInfo = {0};
    aicpuTaskInfo.taskID = 1;
    tasksT.emplace_back(&aicpuTaskInfo);
    uint32_t streamId = 1;
    aicpuStream->InitAicpuStream(streamId, tasksT);

    MOCKER(&AicpuStream::ExecuteTask)
        .stubs()
        .will(returnValue(0));

    int ret = aicpuStream->ExecuteNextTask(runContextT2, streamEnd);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
    delete aicpuStream;
    aicpuStream = nullptr;
}

TEST_F(AICPUScheduleTEST, ExecuteNextTask_failed1) {
    AicpuModel *aicpuModel = new AicpuModel();
    MOCKER_CPP(&AicpuModelManager::GetModel).stubs().will(returnValue(aicpuModel));
    bool streamEnd = false;
    AicpuStream *aicpuStream = new AicpuStream();

    std::vector<const AicpuTaskInfo *> tasksT;

    AicpuTaskInfo aicpuTaskInfo = {0};
    aicpuTaskInfo.taskID = 1;
    tasksT.emplace_back(&aicpuTaskInfo);
    uint32_t streamId = 1;
    aicpuStream->InitAicpuStream(streamId, tasksT);

    MOCKER(&AicpuStream::ExecuteTask)
        .stubs()
        .will(returnValue(-1));

    int ret = aicpuStream->ExecuteNextTask(runContextM, streamEnd);
    EXPECT_EQ(ret, -1);
    delete aicpuStream;
    aicpuStream = nullptr;
    delete aicpuModel;
    aicpuModel = nullptr;
}

TEST_F(AICPUScheduleTEST, ModelLoad_failed1) {
    AicpuModel *aicpuModel = new AicpuModel();

    AicpuModelInfo *modelInfoT = nullptr;
    int ret = aicpuModel->ModelLoad(modelInfoT);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID);
    delete aicpuModel;
    aicpuModel = nullptr;
}

TEST_F(AICPUScheduleTEST, ModelLoad_failed2) {
    AicpuModel *aicpuModel = new AicpuModel();

    MOCKER_CPP(&AicpuModel::CheckOperateAndUpdateStatus)
        .stubs()
        .will(returnValue(0));

    MOCKER_CPP(&AicpuModel::LoadStreamAndTask)
        .stubs()
        .will(returnValue(-1));

    AicpuModelInfo modelInfoT = {0};
    modelInfoT.moduleID = 1;
    int ret = aicpuModel->ModelLoad(&modelInfoT);
    EXPECT_EQ(ret, -1);
    delete aicpuModel;
    aicpuModel = nullptr;
}

TEST_F(AICPUScheduleTEST, ModelLoad_failed3) {
    AicpuModel *aicpuModel = new AicpuModel();

    MOCKER_CPP(&AicpuModel::CheckOperateAndUpdateStatus)
        .stubs()
        .will(returnValue(0));

    MOCKER_CPP(&AicpuModel::LoadStreamAndTask)
        .stubs()
        .will(returnValue(0));

    MOCKER_CPP(&AicpuModel::LoadQueueInfo)
        .stubs()
        .will(returnValue(-1));

    AicpuModelInfo modelInfoT = {0};
    modelInfoT.moduleID = 1;
    int ret = aicpuModel->ModelLoad(&modelInfoT);
    EXPECT_EQ(ret, -1);
    delete aicpuModel;
    aicpuModel = nullptr;
}

TEST_F(AICPUScheduleTEST, ModelLoad_failed4) {
    AicpuModel *aicpuModel = new AicpuModel();

    MOCKER_CPP(&AicpuModel::CheckOperateAndUpdateStatus)
        .stubs()
        .will(returnValue(0));

    MOCKER_CPP(&AicpuModel::LoadStreamAndTask)
        .stubs()
        .will(returnValue(0));

    MOCKER_CPP(&AicpuModel::LoadQueueInfo)
        .stubs()
        .will(returnValue(0));
    
    MOCKER_CPP(&AicpuModel::AttachReportStatusQueue)
        .stubs()
        .will(returnValue(0));

    MOCKER_CPP(&AicpuModel::LoadCfg)
        .stubs()
        .will(returnValue(-1));

    MOCKER_CPP(&AicpuModel::ModelDestroy)
        .stubs()
        .will(returnValue(0));

    AicpuModelInfo modelInfoT = {0};
    modelInfoT.moduleID = 1;
    int ret = aicpuModel->ModelLoad(&modelInfoT);
    EXPECT_EQ(ret, -1);
    delete aicpuModel;
    aicpuModel = nullptr;
}

TEST_F(AICPUScheduleTEST, TaskReport) {
    AicpuModel *aicpuModel = new AicpuModel();

    MOCKER_CPP(&AicpuModel::CheckOperateAndUpdateStatus)
        .stubs()
        .will(returnValue(0));

    int ret = aicpuModel->TaskReport();
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
    delete aicpuModel;
    aicpuModel = nullptr;
}

TEST_F(AICPUScheduleTEST, TaskReport_failed) {
    AicpuModel *aicpuModel = new AicpuModel();

    MOCKER_CPP(&AicpuModel::CheckOperateAndUpdateStatus)
        .stubs()
        .will(returnValue(-1));

    int ret = aicpuModel->TaskReport();
    EXPECT_EQ(ret, -1);
    delete aicpuModel;
    aicpuModel = nullptr;
}

TEST_F(AICPUScheduleTEST, ModelAbort) {
    AicpuModel *aicpuModel = new AicpuModel();

    MOCKER_CPP(&AicpuModel::CheckOperateAndUpdateStatus)
        .stubs()
        .will(returnValue(0));

    MOCKER_CPP(&AicpuModel::ReleaseModelResource)
        .stubs()
        .will(returnValue(0));

    int ret = aicpuModel->ModelAbort();
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
    delete aicpuModel;
    aicpuModel = nullptr;
}

TEST_F(AICPUScheduleTEST, ModelAbort_failed) {
    AicpuModel *aicpuModel = new AicpuModel();

    MOCKER_CPP(&AicpuModel::CheckOperateAndUpdateStatus)
        .stubs()
        .will(returnValue(-1));

    int ret = aicpuModel->ModelAbort();
    EXPECT_EQ(ret, -1);
    delete aicpuModel;
    aicpuModel = nullptr;
}

TEST_F(AICPUScheduleTEST, EndGraph_failed) {
    AicpuModel *aicpuModel = new AicpuModel();

    MOCKER_CPP(&AicpuModel::CheckOperateAndUpdateStatus)
        .stubs()
        .will(returnValue(-1));

    int ret = aicpuModel->EndGraph();
    EXPECT_EQ(ret, -1);
    delete aicpuModel;
    aicpuModel = nullptr;
}

TEST_F(AICPUScheduleTEST, ActiveStream) {
    AicpuModel *aicpuModel = new AicpuModel();

    MOCKER_CPP(&AicpuModel::ExecuteStream)
        .stubs()
        .will(returnValue(0));
    uint32_t streamId = 1;
    int ret = aicpuModel->ActiveStream(streamId);
    EXPECT_EQ(ret, 0);
    delete aicpuModel;
    aicpuModel = nullptr;
}

TEST_F(AICPUScheduleTEST, RecoverStream) {
    AicpuModel *aicpuModel = new AicpuModel();

    MOCKER_CPP(&AicpuModel::ExecuteStream)
        .stubs()
        .will(returnValue(0));
    uint32_t streamId = 1;
    int ret = aicpuModel->RecoverStream(streamId);
    EXPECT_EQ(ret, 0);
    delete aicpuModel;
    aicpuModel = nullptr;
}

TEST_F(AICPUScheduleTEST, ExecuteStream_failed1) {
    AicpuModel *aicpuModel = new AicpuModel();

    AicpuStream *aicpuStream = nullptr;

    MOCKER_CPP(&AicpuModel::GetStreamByStreamId)
        .stubs()
        .will(returnValue(aicpuStream));

    uint32_t streamId = 1;
    bool executeInline = false;

    int ret = aicpuModel->ExecuteStream(streamId, executeInline);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_STREAM_NOT_FOUND);
    delete aicpuModel;
    aicpuModel = nullptr;
}

static int32_t g_stub_ExecuteTaskTimes = 0;
int32_t ExecuteNextTaskStub(AicpuStream *stream, RunContext &runContext, bool &streamEnd)
{
    if (g_stub_ExecuteTaskTimes == 0) {
        runContext.streamId += 1;
    }
    g_stub_ExecuteTaskTimes++;
    streamEnd = true;
    return AICPU_SCHEDULE_OK;
}

TEST_F(AICPUScheduleTEST, ExecuteStreamInlineTest) {
    MOCKER_CPP(&AicpuStream::ExecuteNextTask)
            .stubs()
            .will(invoke(ExecuteNextTaskStub));
    AicpuModel aicpuModel;
    aicpuModel.modelStatus_ = AicpuModelStatus::MODEL_STATUS_RUNNING;
    auto ret = aicpuModel.ExecuteStream(0, true);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_STREAM_NOT_FOUND);
}


int32_t ExecuteNextTaskStub2(AicpuStream *stream, RunContext &runContext, bool &streamEnd)
{
    std::cout << "g_stub_ExecuteTaskTimes=" << g_stub_ExecuteTaskTimes << std::endl;
    if (g_stub_ExecuteTaskTimes == 0) {
        runContext.streamId = 1;
    } else if (g_stub_ExecuteTaskTimes == 1) {
        runContext.streamId = 1;
        streamEnd = true;
    } else {
       return AICPU_SCHEDULE_ERROR_TASK_EXECUTE_FAILED;
    }
    g_stub_ExecuteTaskTimes++;
    return AICPU_SCHEDULE_OK;
}

TEST_F(AICPUScheduleTEST, ExecuteStreamInlineTestSuccess2) {
    AicpuStream *aicpuStream = new AicpuStream();
    g_stub_ExecuteTaskTimes = 0;
    MOCKER_CPP(&AicpuModel::GetStreamByStreamId)
        .stubs()
        .will(returnValue(aicpuStream));
    MOCKER_CPP(&AicpuModel::CheckOperate)
        .stubs()
        .will(returnValue(0));
    MOCKER_CPP(&AicpuStream::ExecuteNextTask)
            .stubs()
            .will(invoke(ExecuteNextTaskStub2));
    AicpuModel aicpuModel;
    aicpuModel.modelStatus_ = AicpuModelStatus::MODEL_STATUS_RUNNING;
    auto ret = aicpuModel.ExecuteStream(0, true);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_TASK_EXECUTE_FAILED);
    delete aicpuStream;
    aicpuStream = nullptr;
}

TEST_F(AICPUScheduleTEST, ExecuteStreamInlineTestSuccess3) {
    AicpuStream *aicpuStream = new AicpuStream();
    AicpuStream *aicpuStreamNull = nullptr;
    g_stub_ExecuteTaskTimes = 0;
    MOCKER_CPP(&AicpuModel::GetStreamByStreamId)
        .stubs()
        .will(returnValue(aicpuStream))
        .then(returnValue(aicpuStreamNull));
    MOCKER_CPP(&AicpuModel::CheckOperate)
        .stubs()
        .will(returnValue(0));
    MOCKER_CPP(&AicpuStream::ExecuteNextTask)
            .stubs()
            .will(invoke(ExecuteNextTaskStub2));
    AicpuModel aicpuModel;
    aicpuModel.modelStatus_ = AicpuModelStatus::MODEL_STATUS_RUNNING;
    auto ret = aicpuModel.ExecuteStream(0, true);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_STREAM_NOT_FOUND);
    delete aicpuStream;
    aicpuStream = nullptr;
}

TEST_F(AICPUScheduleTEST, ModelLoadM_failed1) {
    AicpuModelInfo *modelInfo = nullptr;
    int ret = AicpuModelManager::GetInstance().ModelLoad(modelInfo);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID);
}

TEST_F(AICPUScheduleTEST, ModelLoadM_failed2) {
    AicpuModelInfo modelInfoT = {0};
    modelInfoT.moduleID = MAX_MODEL_COUNT;
    int ret = AicpuModelManager::GetInstance().ModelLoad(&modelInfoT);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID);
}

TEST_F(AICPUScheduleTEST, GetModelByStreamId_success) {
    uint32_t streamId = 1;
    const AicpuModel *inst = AicpuModelManager::GetInstance().GetModelByStreamId(streamId);
    EXPECT_EQ(inst, nullptr);
}

TEST_F(AICPUScheduleTEST, ProcessTaskReportEvent_failed) {
    TsToAicpuTaskReport info;
    info.model_id = 1;
    AicpuModel *model = new AicpuModel();
    MOCKER_CPP(&AicpuModelManager::GetModel).stubs().will(returnValue(model));
    MOCKER_CPP(&AicpuModel::IsEndOfSequence).stubs().will(returnValue(false));
    TsAicpuSqe sqe{};
    sqe.u.ts_to_aicpu_task_report.model_id = info.model_id;
    AicpuSqeAdapter ada(sqe, 0U);
    int ret = AicpuEventProcess::GetInstance().ProcessTaskReportEvent(ada);
    EXPECT_NE(ret, AICPU_SCHEDULE_OK);
    delete model;
    model = nullptr;
}

TEST_F(AICPUScheduleTEST, ProcessTaskReportEvent_failed2) {
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

    delete model;
    model = nullptr;
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_MODEL_STATUS_NOT_ALLOW_OPERATE);
}

TEST_F(AICPUScheduleTEST, ProcessTaskReportEvent_failed3) {
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

    delete model;
    model = nullptr;
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_MODEL_STATUS_NOT_ALLOW_OPERATE);
}

TEST_F(AICPUScheduleTEST, ProcessTaskReportEvent_failed4) {
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


TEST_F(AICPUScheduleTEST, CheckOperateTest) {
    AicpuModel *aicpuModel = new AicpuModel();

    aicpuModel->modelStatus_ = AicpuModelStatus::MODEL_STATUS_UNINIT;
    AicpuSchedule::AicpuModelOperate operate = AicpuModelOperate::MODEL_OPERATE_LOAD;
    int ret = aicpuModel->CheckOperate(operate);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);

    aicpuModel->modelStatus_ = AicpuModelStatus::MODEL_STATUS_UNINIT;
    operate = AicpuModelOperate::MODEL_OPERATE_EXECUTE;
    ret = aicpuModel->CheckOperate(operate);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_MODEL_STATUS_NOT_ALLOW_OPERATE);

    delete aicpuModel;
    aicpuModel = nullptr;
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
    ModelInfo modelInfo = {}; //{0, 1, &modelStreamInfo, 1, &modelQueueInfo, };
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
    ModelInfo modelInfo = {}; // {0, 1, &modelStreamInfo, 1, &modelQueueInfo, };
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
    ModelInfo modelInfo = {};//{0, 1, &modelStreamInfo, 1, nullptr, };
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
    MOCKER(RegEventMsgCallBackFunc).stubs().will(returnValue(0));
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
    MOCKER(RegEventMsgCallBackFunc).stubs().will(returnValue(0));
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

int StubDclose(void * __handle)
{
    return 0;
}

TEST_F(AICPUScheduleTEST, RegQueueScheduleModuleCallBack_nok2) {
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
    MOCKER(RegEventMsgCallBackFunc).stubs().will(returnValue(0));
    MOCKER(dlsym).stubs().will(invoke(dlsymStubAicpuSdMainNull));
    MOCKER(dlclose).stubs().will(invoke(StubDclose));
    MOCKER(halGetDeviceCountFromChip).stubs().will(returnValue(0));
    MOCKER(halGetDeviceFromChip).stubs().will(returnValue(0));
    MOCKER(halBuffInit).stubs().will(returnValue(0));

    char* argv[] = {processName, paramDeviceIdOk, paramPidOk, paramPidSignOk, paramModeOk, paramLogLevelOk, paramGrpNameOk, paramGrpNumOk, paramDeviceModel};
    int32_t argc = 9;
    MOCKER_CPP(&AicpuScheduleInterface::InitAICPUScheduler).stubs().will(returnValue(0));
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

TEST_F(AICPUScheduleTEST, FftsPlusDumpData) {
    MOCKER_CPP(&IdeDumpData)
        .stubs()
        .will(returnValue(0));
    MOCKER_CPP(&IdeDumpStart)
        .stubs()
        .will(returnValue((void *)111));
    MOCKER(memcpy_s).stubs().will(returnValue(EOK));
    const uint32_t taskId = 20;
    const uint32_t streamId = 31;
    const uint32_t contextId = 1;
    const uint32_t modelId = 222;
    int32_t input[4] = {1, 2, 3, 4};
    int32_t *inputaddress = &input[0];
    int32_t inputSize = sizeof(input);
    int32_t inputoffset = inputSize/2;

    int32_t output[4] = {1, 2, 3, 4};
    int32_t *outputaddress = &output[0];
    int32_t outputSize = sizeof(output);
    int32_t outputoffset = outputSize/2;
    const int32_t dataType = 7; // int32
    aicpu::dump::OpMappingInfo opMappingInfo;

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
        aicpu::dump::Output *output = task->add_output();
        {
            output->set_data_type(dataType);
            output->set_format(1);
            aicpu::dump::Shape *shape = output->mutable_shape();
            {
                shape->add_dim(2);
                shape->add_dim(2);
            }

            aicpu::dump::Shape *originShape = output->mutable_origin_shape();
            {
                originShape->add_dim(2);
                originShape->add_dim(2);
            }
            output->set_addr_type(2);
            output->set_address(reinterpret_cast<uint64_t>(&outputaddress));
            output->set_original_name("original_name");
            output->set_original_output_index(11);
            output->set_original_output_data_type(dataType);
            output->set_original_output_format(1);
            output->set_size(outputSize);
            output->set_offset(outputoffset);
        }
        // task->set_end_graph();
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
            input->set_addr_type(2);
            int32_t inData[4] = {10, 20, 30, 40};
            input->set_size(inputSize);
            input->set_offset(inputoffset);
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
    // opMappingInfo.set_dump_step("1");
    opMappingInfo.set_dump_data(0);
    aicpu::dump::Context *context = task->add_context();
    context->set_context_id(contextId);
    context->set_thread_id(0);
    addPreProcessFFTSPLUSContext(task, context);
    std::string opMappingInfoStr;
    opMappingInfo.SerializeToString(&opMappingInfoStr);
    OpDumpTaskManager &opDumpTaskMgr = OpDumpTaskManager::GetInstance();
    EXPECT_EQ(opDumpTaskMgr.LoadOpMappingInfo(opMappingInfoStr.c_str(), opMappingInfoStr.length()), AICPU_SCHEDULE_OK);

    TaskInfoExt dumpTaskInfo;
    dumpTaskInfo.streamId_ = streamId;
    dumpTaskInfo.taskId_ = taskId;
    dumpTaskInfo.contextId_ = contextId;
    dumpTaskInfo.threadId_ = 0;
    DumpFileName name(streamId, taskId, contextId, 0);
    EXPECT_EQ(opDumpTaskMgr.DumpOpInfo(dumpTaskInfo, name), AICPU_SCHEDULE_OK);

    // unload model
    opMappingInfo.set_flag(0x00);
    opMappingInfo.SerializeToString(&opMappingInfoStr);
    opDumpTaskMgr.LoadOpMappingInfo(opMappingInfoStr.c_str(), opMappingInfoStr.length());
}

TEST_F(AICPUScheduleTEST, FftsPlusdataDumpStats) {
    MOCKER_CPP(&IdeDumpData)
        .stubs()
        .will(returnValue(0));
    MOCKER_CPP(&IdeDumpStart)
        .stubs()
        .will(returnValue((void *)111));
    MOCKER(memcpy_s).stubs().will(returnValue(EOK));
    const uint32_t taskId = 20;
    const uint32_t streamId = 31;
    const uint32_t contextId = 1;
    const uint32_t modelId = 222;
    int32_t input[4] = {1, 2, 3, 4};
    int32_t *inputaddress = &input[0];
    int32_t inputSize = sizeof(input);
    int32_t inputoffset = inputSize/2;

    int32_t output[4] = {1, 2, 3, 4};
    int32_t *outputaddress = &output[0];
    int32_t outputSize = sizeof(output);
    int32_t outputoffset = outputSize/2;
    const int32_t dataType = 7; // int32
    aicpu::dump::OpMappingInfo opMappingInfo;

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
        // aicpu::dump::OpBuffer *opBuffer = task->add_buffer();
        task->set_tasktype(aicpu::dump::Task::FFTSPLUS); // FFTSPLUS
        task->set_context_id(contextId);
        aicpu::dump::OpAttr *opAttr = task->add_attr();
        {
            opAttr->set_name("name");
            opAttr->set_value("value");
        }
    }
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
//    EXPECT_EQ(opDumpTaskMgr.DumpOpInfo(dumpTaskInfo), AICPU_SCHEDULE_OK);

    // unload model
    opMappingInfo.set_flag(0x00);
    opMappingInfo.SerializeToString(&opMappingInfoStr);
    opDumpTaskMgr.LoadOpMappingInfo(opMappingInfoStr.c_str(), opMappingInfoStr.length());
}

TEST_F(AICPUScheduleTEST, WorkspaceDumpDataSuccess) {
    MOCKER_CPP(&IdeDumpData)
        .stubs()
        .will(returnValue(0));
    MOCKER_CPP(&IdeDumpStart)
        .stubs()
        .will(returnValue((void *)111));
    MOCKER(memcpy_s).stubs().will(returnValue(EOK));
    const uint32_t taskId = 401;
    const uint32_t streamId = 401;

    int32_t input[8] = {1, 2, 3, 4, 5, 6, 7 ,8};
    int32_t *inputaddress = &input[0];
    int32_t inputSize = sizeof(input);
    int32_t inputoffset = 2 * sizeof(int32_t);
    int32_t output[4] = {1, 2, 3, 4};
    int32_t *outputaddress = &output[0];
    int32_t outputSize = sizeof(output);
    int32_t outputoffset = 2 * sizeof(int32_t);
    const int32_t dataType = 7; // int32
    aicpu::dump::OpMappingInfo opMappingInfo;

    int32_t data[10] = {1, 2, 3, 4, 5, 6, 7 ,8, 9, 10}; // workspace

    opMappingInfo.set_dump_path("dump_path");
    opMappingInfo.set_model_name("model_n a.m\\ /e");
    // opMappingInfo.set_model_id(modelId);
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
        aicpu::dump::Output *output = task->add_output();
        {
            output->set_data_type(dataType);
            output->set_format(1);
            aicpu::dump::Shape *shape = output->mutable_shape();
            {
                shape->add_dim(2);
                shape->add_dim(2);
            }

            aicpu::dump::Shape *originShape = output->mutable_origin_shape();
            {
                originShape->add_dim(2);
                originShape->add_dim(2);
            }
            output->set_addr_type(0);
            output->set_address(reinterpret_cast<uint64_t>(&outputaddress));
            output->set_original_name("original_name");
            output->set_original_output_index(11);
            output->set_original_output_data_type(dataType);
            output->set_original_output_format(1);
            output->set_size(outputSize);
            output->set_offset(outputoffset);
        }
        // task->set_end_graph();
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
        // aicpu::dump::OpBuffer *opBuffer = task->add_buffer();
        // task->set_tasktype(aicpu::dump::Task::FFTSPLUS); // FFTSPLUS
        // task->set_context_id(contextId);
        aicpu::dump::OpAttr *opAttr = task->add_attr();
        {
            opAttr->set_name("name");
            opAttr->set_value("value");
        }
        // Workspace
        aicpu::dump::Workspace *space = task->add_space();
        {
            space->set_type(aicpu::dump::Workspace::LOG);     
            space->set_data_addr(data);
            space->set_size(sizeof(data));
        }
    }
    // opMappingInfo.set_dump_step("1");
    opMappingInfo.set_dump_data(0);

    std::string opMappingInfoStr;
    opMappingInfo.SerializeToString(&opMappingInfoStr);
    OpDumpTaskManager &opDumpTaskMgr = OpDumpTaskManager::GetInstance();
    EXPECT_EQ(opDumpTaskMgr.LoadOpMappingInfo(opMappingInfoStr.c_str(), opMappingInfoStr.length()), AICPU_SCHEDULE_OK);

    TaskInfoExt dumpTaskInfo;
    dumpTaskInfo.streamId_ = streamId;
    dumpTaskInfo.taskId_ = taskId;
    // dumpTaskInfo.contextId_ = contextId;
    // dumpTaskInfo.threadId_ = 0;
    DumpFileName name(streamId, taskId);
    EXPECT_EQ(opDumpTaskMgr.DumpOpInfo(dumpTaskInfo, name), AICPU_SCHEDULE_OK);

    // unload model
    opMappingInfo.set_flag(0x00);
    opMappingInfo.SerializeToString(&opMappingInfoStr);
    opDumpTaskMgr.LoadOpMappingInfo(opMappingInfoStr.c_str(), opMappingInfoStr.length());
}

TEST_F(AICPUScheduleTEST, WorkspcaeDumpDataFailTEST) {
    MOCKER_CPP(&IdeDumpData)
        .stubs()
        .will(returnValue(0));
    MOCKER_CPP(&IdeDumpStart)
        .stubs()
        .will(returnValue((void *)111));
    MOCKER(memcpy_s).stubs().will(returnValue(EOK));
    const uint32_t taskId = 402;
    const uint32_t streamId = 402;
    aicpu::dump::OpMappingInfo opMappingInfo;
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
    aicpu::dump::Task *task1 = opMappingInfo.add_task();
    {
        task1->set_task_id(taskId);
        task1->set_stream_id(streamId);
        
        aicpu::dump::Op *op = task1->mutable_op();
        {
            op->set_op_name("op_n a.m\\ /e");
            op->set_op_type("op_t y.p\\e/ rr");
        }
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
        // Workspace
        aicpu::dump::Workspace *space = task1->add_space();
        {
            space->set_type(aicpu::dump::Workspace::LOG);     
            //space->set_data_addr(data);
            //space->set_size(sizeof(data));
            space->set_data_addr(data);
            space->set_size(0); // task1 的size为0
        }
    }
    // opMappingInfo.set_dump_step("1");
    // opMappingInfo.set_dump_data(0);

    std::string opMappingInfoStr;
    opMappingInfo.SerializeToString(&opMappingInfoStr);
    OpDumpTaskManager &opDumpTaskMgr = OpDumpTaskManager::GetInstance();
    EXPECT_EQ(opDumpTaskMgr.LoadOpMappingInfo(opMappingInfoStr.c_str(), opMappingInfoStr.length()), AICPU_SCHEDULE_OK);

    TaskInfoExt dumpTaskInfo;
    dumpTaskInfo.streamId_ = streamId;
    dumpTaskInfo.taskId_ = taskId;
    DumpFileName name1(streamId, taskId);
    EXPECT_EQ(opDumpTaskMgr.DumpOpInfo(dumpTaskInfo, name1), AICPU_SCHEDULE_OK); // 测试size为0


    dumpTaskInfo.streamId_ = streamId+1;
    dumpTaskInfo.taskId_ = taskId+1;
    DumpFileName name2(dumpTaskInfo.streamId_, dumpTaskInfo.taskId_);
    EXPECT_EQ(opDumpTaskMgr.DumpOpInfo(dumpTaskInfo, name2), AICPU_SCHEDULE_OK); // 测试data_addr为0

    // unload model
    opMappingInfo.set_flag(0x00);
    opMappingInfo.SerializeToString(&opMappingInfoStr);
    opDumpTaskMgr.LoadOpMappingInfo(opMappingInfoStr.c_str(), opMappingInfoStr.length());
}

TEST_F(AICPUScheduleTEST, FFTSPlusOpDebugDumpFailContextIsINVALID) {
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

TEST_F(AICPUScheduleTEST, FFTSPlusOpDebugDumpFailThreadIsINVALID) {
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

TEST_F(AICPUScheduleTEST, FFTSPlusOpDebugDumpSuccessTest) {
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

TEST_F(AICPUScheduleTEST, FFTSPlus_st_dynamicshape_dump) {
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
    DumpFileName name1(dumpTaskInfo.streamId_, dumpTaskInfo.taskId_, dumpTaskInfo.contextId_, dumpTaskInfo.threadId_);
    opDumpTaskMgr.DumpOpInfo(dumpTaskInfo, name1);
    dumpTaskInfo.streamId_ = streamId;
    dumpTaskInfo.taskId_ = taskId;
    dumpTaskInfo.contextId_ = contextId0;
    dumpTaskInfo.threadId_ = 1;
    DumpFileName name2(dumpTaskInfo.streamId_, dumpTaskInfo.taskId_, dumpTaskInfo.contextId_, dumpTaskInfo.threadId_);
    opDumpTaskMgr.DumpOpInfo(dumpTaskInfo, name2);

    // unload model
    opMappingInfo.set_flag(0x00);
    opMappingInfo.SerializeToString(&opMappingInfoStr);
    opDumpTaskMgr.LoadOpMappingInfo(opMappingInfoStr.c_str(), opMappingInfoStr.length());
}

// 此用例请务必保证最后执行，可能影响其余用例的正常运行
TEST_F(AICPUScheduleTEST, ST_MainTestWithVf) {
    char processName[] = "aicpu_scheduler";
    char paramDeviceIdOk[] = "--deviceId=1";
    char paramPidOk[] = "--pid=2";
    char paramPidSignOk[] = "--pidSign=12345A";
    char paramModeOk[] = "--profilingMode=1";
    char paramLogLevelOk[] = "--logLevelInPid=0";
    char paramVfId[] = "--vfId=1";
    char paramGrpNameOk[] = "--groupNameList=Grp1";
    char paramGrpNumOk[] = "--groupNameNum=1";
    MOCKER(system)
        .stubs()
        .will(returnValue(0));
    MOCKER(open, int(const char*, int)).stubs().will(returnValue(0));
    char* argv[] = { processName, paramDeviceIdOk, paramPidOk, paramPidSignOk,
                     paramModeOk, paramLogLevelOk, paramVfId, paramGrpNameOk, paramGrpNumOk };
    int32_t argc = 9;
    MOCKER_CPP(&AicpuScheduleInterface::InitAICPUScheduler)
        .stubs()
        .will(returnValue(0));
    int32_t ret = ComputeProcessMain(argc, argv);
    EXPECT_EQ(ret, 0);
}

TEST_F(AICPUScheduleTEST, STMainTestWithVf_openFail) {
    char processName[] = "aicpu_scheduler";
    char paramDeviceIdOk[] = "--deviceId=1";
    char paramPidOk[] = "--pid=2";
    char paramPidSignOk[] = "--pidSign=12345A";
    char paramModeOk[] = "--profilingMode=1";
    char paramLogLevelOk[] = "--logLevelInPid=0";
    char paramVfId[] = "--vfId=1";
    char paramGrpNameOk[] = "--groupNameList=Grp1";
    char paramGrpNumOk[] = "--groupNameNum=1";
    MOCKER(system)
        .stubs()
        .will(returnValue(0));
    MOCKER(open, int(const char*, int)).stubs().will(returnValue(-1));
    char* argv[] = { processName, paramDeviceIdOk, paramPidOk, paramPidSignOk,
                     paramModeOk, paramLogLevelOk, paramVfId, paramGrpNameOk, paramGrpNumOk };
    int32_t argc = 9;
    MOCKER_CPP(&AicpuScheduleInterface::InitAICPUScheduler)
        .stubs()
        .will(returnValue(0));
    int32_t ret = ComputeProcessMain(argc, argv);
    EXPECT_EQ(ret, 0);
}

TEST_F(AICPUScheduleTEST, AicpuLoadModelWithQ_SetPri_CHECKHEAD_ERROR) {
    printf("=======================AicpuLoadModelWithQ=====================\n");
    ModelTaskInfo modelTaskInfo = {0, 0, 0};
    ModelStreamInfo modelStreamInfo = {0, 0, 1, &modelTaskInfo};
    ModelQueueInfo queueInfo = {0, 0};
    ModelInfo modelInfo = {}; //{0, 1, &modelStreamInfo, 1, &queueInfo, };
    modelInfo.modelId = 0U;
    modelInfo.aicpuStreamNum = 1U;
    modelInfo.streams = &modelStreamInfo;
    modelInfo.queueNum = 1U;
    modelInfo.queues = &queueInfo;
    modelInfo.aicpuPriInfo.checkHead = 0x1234;
    AicpuDrvManager::GetInstance().deviceVec_.push_back(0);
    MOCKER_CPP(&AicpuScheduleInterface::LoadProcess).stubs().will(returnValue(0));
    int ret = AicpuLoadModelWithQ((void*)(&modelInfo));
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
}

TEST_F(AICPUScheduleTEST, AicpuLoadModelWithQ_SetPri_VALUE_DEFAULT) {
    printf("=======================AicpuLoadModelWithQ=====================\n");
    ModelTaskInfo modelTaskInfo = {0, 0, 0};
    ModelStreamInfo modelStreamInfo = {0, 0, 1, &modelTaskInfo};
     ModelQueueInfo queueInfo = {0, 0};
    ModelInfo modelInfo = {}; //{0, 1, &modelStreamInfo, 1, &queueInfo, };
    modelInfo.modelId = 0U;
    modelInfo.aicpuStreamNum = 1U;
    modelInfo.streams = &modelStreamInfo;
    modelInfo.queueNum = 1U;
    modelInfo.queues = &queueInfo;
    modelInfo.aicpuPriInfo.checkHead = PRIORITY_MSG_CHECKCODE;
    modelInfo.aicpuPriInfo.eventPriority = INVALID_ESCAPE_PRI_VALUE;
    modelInfo.aicpuPriInfo.pidPriority = INVALID_ESCAPE_PRI_VALUE;
    AicpuDrvManager::GetInstance().deviceVec_.push_back(0);
    MOCKER_CPP(&AicpuScheduleInterface::LoadProcess).stubs().will(returnValue(0));
    int ret = AicpuLoadModelWithQ((void*)(&modelInfo));
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
}

TEST_F(AICPUScheduleTEST, AicpuLoadModelWithQ_SetPri_VALUE_OK) {
    printf("=======================AicpuLoadModelWithQ=====================\n");
    ModelTaskInfo modelTaskInfo = {0, 0, 0};
    ModelStreamInfo modelStreamInfo = {0, 0, 1, &modelTaskInfo};
     ModelQueueInfo queueInfo = {0, 0};
    ModelInfo modelInfo = {}; //{0, 1, &modelStreamInfo, 1, &queueInfo, };
    modelInfo.modelId = 0U;
    modelInfo.aicpuStreamNum = 1U;
    modelInfo.streams = &modelStreamInfo;
    modelInfo.queueNum = 1U;
    modelInfo.queues = &queueInfo;
    modelInfo.aicpuPriInfo.checkHead = PRIORITY_MSG_CHECKCODE;
    modelInfo.aicpuPriInfo.eventPriority = INVALID_ESCAPE_PRI_VALUE;
    modelInfo.aicpuPriInfo.pidPriority = 2;
    AicpuDrvManager::GetInstance().deviceVec_.push_back(0);
    MOCKER_CPP(&AicpuScheduleInterface::LoadProcess).stubs().will(returnValue(0));
    int ret = AicpuLoadModelWithQ((void*)(&modelInfo));
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
    modelInfo.aicpuPriInfo.pidPriority = 3;
    ret = AicpuLoadModelWithQ((void*)(&modelInfo));
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
    modelInfo.aicpuPriInfo.pidPriority = INVALID_ESCAPE_PRI_VALUE;
    ret = AicpuLoadModelWithQ((void*)(&modelInfo));
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
    modelInfo.aicpuPriInfo.eventPriority = 1;
    modelInfo.aicpuPriInfo.pidPriority = 1;
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
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

TEST_F(AICPUScheduleTEST, GetNormalAicpuInfoSuccess1OnHostCpu) {
    std::vector<uint32_t> device_vec;
    device_vec.push_back(32U);
    int64_t expect_aicpuNum = 64;
    MOCKER(halGetDeviceInfo).stubs().will(invoke(halGetDeviceInfoFake1OnHost));
    MOCKER(GetAicpuDeployContext).stubs().will(invoke(GetAicpuDeployContextOnHostCpu));
    int ret = AicpuDrvManager::GetInstance().GetNormalAicpuInfo(device_vec);
    EXPECT_EQ(ret, DRV_ERROR_NONE);
}

TEST_F(AICPUScheduleTEST, GetNormalAicpuInfoSuccess1OnHost) {
    std::vector<uint32_t> device_vec;
    device_vec.push_back(32U);
    int64_t expect_aicpuNum = 64;
    MOCKER(halGetDeviceInfo).stubs().will(invoke(halGetDeviceInfoFake1OnHost));
    MOCKER(GetAicpuDeployContext).stubs().will(invoke(GetAicpuDeployContextOnHost));
    int ret = AicpuDrvManager::GetInstance().GetNormalAicpuInfo(device_vec);
    EXPECT_EQ(ret, DRV_ERROR_NONE);
    EXPECT_EQ(expect_aicpuNum, AicpuDrvManager::GetInstance().GetAicpuNumPerDevice());
    for (uint32_t i = 0; i < expect_aicpuNum; i++) {
        EXPECT_EQ(AicpuDrvManager::GetInstance().GetAicpuPhysIndex(i, 0U), i);
    }
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

TEST_F(AICPUScheduleTEST, AICPUEventPrepareMem) {
    AicpuModel *nullModel = nullptr;
    MOCKER_CPP(&AicpuModelManager::GetModel).stubs().will(returnValue(nullModel));
    MOCKER_CPP(&AicpuModel::RecoverStream).stubs().will(returnValue(AICPU_SCHEDULE_OK));

    bool needWait = false;
    EventWaitManager::PrepareMemWaitManager().WaitEvent(0, 0, needWait);
    AICPUSubEventInfo event;
    event.modelId = 0;
    auto ret = AicpuEventProcess::GetInstance().AICPUEventPrepareMem(event);
    EXPECT_EQ(ret, static_cast<int32_t>(AICPU_SCHEDULE_ERROR_MODEL_NOT_FOUND));
}

TEST_F(AICPUScheduleTEST, AICPUEventRepeatModelNoModel)
{
    MOCKER_CPP(&AicpuModelManager::GetModel).stubs().will(returnValue((AicpuModel*)nullptr));
    AICPUSubEventInfo event;
    int ret = AicpuEventProcess::GetInstance().AICPUEventRepeatModel(event);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_MODEL_NOT_FOUND);
}

TEST_F(AICPUScheduleTEST, AICPUEventRecoveryStreamNoModel)
{
    MOCKER_CPP(&AicpuModelManager::GetModel).stubs().will(returnValue((AicpuModel*)nullptr));
    AICPUSubEventInfo event;
    AICPUSubEventStreamInfo streamInfo;
    streamInfo.streamId = 0;
    event.para.streamInfo = streamInfo;
    int ret = AicpuEventProcess::GetInstance().AICPUEventRecoveryStream(event);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_MODEL_NOT_FOUND);
}

TEST_F(AICPUScheduleTEST, ProcessEndGraphAbort)
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

TEST_F(AICPUScheduleTEST, AICPUEventPrepareMemNoModel) {
    MOCKER_CPP(&AicpuModelManager::GetModel).stubs().will(returnValue((AicpuModel*)nullptr));
    MOCKER_CPP(&AicpuModel::RecoverStream).stubs().will(returnValue(AICPU_SCHEDULE_OK));

    AICPUSubEventInfo event;
    event.modelId = 111;
    bool needWait = true;
    EventWaitManager::PrepareMemWaitManager().WaitEvent(event.modelId, 0, needWait);
    
    auto ret = AicpuEventProcess::GetInstance().AICPUEventPrepareMem(event);
    EXPECT_EQ(ret, static_cast<int32_t>(AICPU_SCHEDULE_ERROR_MODEL_NOT_FOUND));
}

TEST_F(AICPUScheduleTEST, AICPUEventPrepareMemRecoverFail) {
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

TEST_F(AICPUScheduleTEST, AICPUEventSupplyEnqueNoModel) {
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

    uint32_t *paraMem = (uint32_t *)malloc(sizeof(ReportStatusInfo) + sizeof(QueueAttrs));
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

uint32_t CastV2(void * parm)
{
    return 0;
}
TEST_F(AICPUScheduleTEST, ProcessHWTSKernelEvent_KFC_STest) {
    MOCKER(dlsym).stubs().will(returnValue((void *)CastV2));
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

uint32_t batchDequeueInfoDeviceIds[] = { 0U, 1U };
uint32_t batchDequeueInfoQueueIds[] = { 0U, 1U };
uint8_t mbuf[1024] = {0x1};
uint64_t mbufAddr = static_cast<uint64_t>(reinterpret_cast<uintptr_t>(reinterpret_cast<void *>(mbuf)));
uint64_t batchDequeueInfoMbufAddrs[] = { mbufAddr, mbufAddr };
uint32_t batchDequeueInfoAlignOffsets[2] = { 0, 10 };
int32_t CheckAndParseBatchDeqBufParamsStub(const BatchDequeueBuffDesc *const batchDeqBufDesc,
    const AicpuTaskInfo &kernelTaskInfo, const RunContext &taskContext, BatchDequeueBuffInfo &batchDeqBufInfo)
{
    batchDeqBufInfo.inputNums = 1;
    batchDeqBufInfo.queueIds = &batchDequeueInfoQueueIds[0];
    batchDeqBufInfo.mbufAddrs = &batchDequeueInfoMbufAddrs[0];
    batchDeqBufInfo.deviceIds = &batchDequeueInfoDeviceIds[0];
    return AICPU_SCHEDULE_OK;
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


TEST_F(AICPUScheduleTEST, St_ProcessMessageTest1) {
    MOCKER(halEschedWaitEvent)
        .stubs()
        .will(returnValue(DRV_ERROR_SCHED_PARA_ERR));
    int32_t ret = AicpuSdCustDumpProcess::GetInstance().ProcessMessage(0);
    EXPECT_EQ(ret, DRV_ERROR_SCHED_PARA_ERR);
}
 
TEST_F(AICPUScheduleTEST, St_ProcessMessageTest2) {
    MOCKER(halEschedWaitEvent)
        .stubs()
        .will(returnValue(DRV_ERROR_SCHED_PROCESS_EXIT));
    int32_t ret = AicpuSdCustDumpProcess::GetInstance().ProcessMessage(0);
    EXPECT_EQ(ret, DRV_ERROR_SCHED_PROCESS_EXIT);
}
 
TEST_F(AICPUScheduleTEST, St_ProcessMessageTest3) {
    MOCKER(halEschedWaitEvent)
        .stubs()
        .will(returnValue(1));
    int32_t ret = AicpuSdCustDumpProcess::GetInstance().ProcessMessage(0);
    EXPECT_EQ(ret, 1);
}
 
TEST_F(AICPUScheduleTEST, St_ProcessMessageTest4AicpuIllegalCPU) {
    MOCKER(halEschedWaitEvent)
        .stubs()
        .will(returnValue(DRV_ERROR_SCHED_RUN_IN_ILLEGAL_CPU));
    int32_t ret = AicpuSdCustDumpProcess::GetInstance().ProcessMessage(0);
    EXPECT_EQ(ret, DRV_ERROR_SCHED_RUN_IN_ILLEGAL_CPU);
}
 
TEST_F(AICPUScheduleTEST, St_UnitCustDataDumpProcess) {
    AicpuSdCustDumpProcess::GetInstance().initFlag_ = false;
    AicpuSdCustDumpProcess::GetInstance().UnitCustDataDumpProcess();
    AicpuSdCustDumpProcess::GetInstance().initFlag_ = true;
    AicpuSdCustDumpProcess::GetInstance().UnitCustDataDumpProcess();
    EXPECT_EQ(AicpuSdCustDumpProcess::GetInstance().initFlag_, false);
}
 
TEST_F(AICPUScheduleTEST, St_DoCustDatadumpTask) {
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
drvError_t halGetDeviceInfoFakeSt1(uint32_t devId, int32_t moduleType, int32_t infoType, int64_t *value)
{
    if (moduleType == 1 && infoType == 3) {
        *value = 1;
    }
    if (moduleType == 1 && infoType == 8) {
        *value = 65532;
    }
    return DRV_ERROR_NONE;
}
TEST_F(AICPUScheduleTEST, St_SetDataDumpThreadAffinity_test1) {
    int32_t ret = 0;
    ret = AicpuSdCustDumpProcess::GetInstance().SetDataDumpThreadAffinity();
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
    std::vector<uint32_t> deviceVec;
    deviceVec.push_back(1);
    MOCKER(halGetDeviceInfo).stubs().will(invoke(halGetDeviceInfoFakeSt1));
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
 
TEST_F(AICPUScheduleTEST, St_LoopProcessEventTest4DRV_ERROR_SCHED_PROCESS_EXIT) {
    MOCKER(halEschedWaitEvent)
        .stubs()
        .will(returnValue(DRV_ERROR_SCHED_PROCESS_EXIT));
    AicpuSdCustDumpProcess::GetInstance().runningFlag_ = true;
    AicpuSdCustDumpProcess::GetInstance().LoopProcessEvent();
    EXPECT_EQ(AicpuSdCustDumpProcess::GetInstance().runningFlag_, false);
}
TEST_F(AICPUScheduleTEST, St_StartProcessEvent_test1) {
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
TEST_F(AICPUScheduleTEST, St_InitDumpProcess_test1) {
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
TEST_F(AICPUScheduleTEST, ST_StartMC2MaintenanceThread) {
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
 
TEST_F(AICPUScheduleTEST, ST_SetMc2MantenanceThreadAffinity) {
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

TEST_F(AICPUScheduleTEST, GetAicpuPhysIndexSuccess) {
    AicpuDrvManager inst;
    inst.aicpuIdVec_ = {1, 2};
    inst.coreNumPerDev_ = 3;
    inst.aicpuNumPerDev_ = 2;
    inst.deviceNum_ = 1;
    const auto ids = inst.GetAicpuPhysIndexs(0);
    EXPECT_EQ(ids[0], 1);
    ids = inst.GetAicpuPhysIndexs(0);
    EXPECT_EQ(ids[0], 1);
}

TEST_F(AICPUScheduleTEST, StartMC2MaintenanceThread_loopFunIsNULL_St) {
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

TEST_F(AICPUScheduleTEST, StartMC2MaintenanceThread_stopNotifyFunIsNULL_St) {
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

TEST_F(AICPUScheduleTEST, StartMC2MaintenanceThread_loopFunIsNULL_stopNotifyFunIsNULL_St) {
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

TEST_F(AICPUScheduleTEST, StartMC2MaintenanceThread_AICPU_SCHEDULE_THREAD_ALREADY_EXISTS_St) {
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
TEST_F(AICPUScheduleTEST, StartMC2MaintenanceThread_AICPU_SCHEDULE_NOT_SUPPORT_St) {
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
TEST_F(AICPUScheduleTEST, CreateMc2MantenanceThread_already_init_St) {
    int ret = 0;
    MOCKER(pthread_setaffinity_np).stubs().will(returnValue(2));
    AicpuSchedule::AicpuMc2MaintenanceThread::GetInstance(0).initFlag_ = true;
    ret = AicpuSchedule::AicpuMc2MaintenanceThread::GetInstance(0).CreateMc2MantenanceThread();
    if (AicpuSchedule::AicpuMc2MaintenanceThread::GetInstance(0).processThread_.joinable()) {
        AicpuSchedule::AicpuMc2MaintenanceThread::GetInstance(0).processThread_.join();
    }
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
}
TEST_F(AICPUScheduleTEST, CreateMc2MantenanceThread_Start_thread_multiple_times_St) {
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
 
TEST_F(AICPUScheduleTEST, CreateMc2MantenanceThread_destructor_St) {
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

TEST_F(AICPUScheduleTEST, CreateMc2MantenanceThread_failed_St) {
    MOCKER_CPP(&AicpuMc2MaintenanceThread::CreateMc2MantenanceThread).stubs().will(returnValue(1));
    int ret = 0;
    struct TsdSubEventInfo msg;
    ret = CreateMc2MantenanceThread(&msg);
    EXPECT_EQ(ret, 1);
}

TEST_F(AICPUScheduleTEST, StartMC2MaintenanceThread_sem_wait_failed_St) {
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

TEST_F(AICPUScheduleTEST, NeedDump_return_false_St) {
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

TEST_F(AICPUScheduleTEST, GetNormalAicpuDCpuInfo_001) {
    AicpuDrvManager inst;
    std::vector<uint32_t> deviceVec;
    deviceVec.push_back(1);
    MOCKER_CPP(&FeatureCtrl::IsAosCore).stubs().will(returnValue(true));
    auto ret = inst.GetNormalAicpuDCpuInfo(deviceVec);
    EXPECT_EQ(ret, 0);
}

TEST_F(AICPUScheduleTEST, GetNormalAicpuDCpuInfo_002) {
    AicpuDrvManager inst;
    std::vector<uint32_t> deviceVec;
    deviceVec.push_back(48);
    MOCKER(halGetDeviceInfo)
        .stubs()
        .will(returnValue(0));
    MOCKER_CPP(&FeatureCtrl::IsAosCore).stubs().will(returnValue(true));
    auto ret = inst.GetNormalAicpuDCpuInfo(deviceVec);
    EXPECT_EQ(ret, 0);
}

TEST_F(AICPUScheduleTEST, GetNormalAicpuDCpuInfo_003) {
    AicpuDrvManager inst;
    std::vector<uint32_t> deviceVec;
    deviceVec.push_back(48);
    MOCKER(halGetDeviceInfo)
        .stubs()
        .will(returnValue(1));
    MOCKER_CPP(&FeatureCtrl::IsAosCore).stubs().will(returnValue(true));
    auto ret = inst.GetNormalAicpuDCpuInfo(deviceVec);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_INIT_FAILED);
}
 
TEST_F(AICPUScheduleTEST, GetThreadVfAicpuDCpuInfo_001) {
    AicpuDrvManager inst;
    std::vector<uint32_t> deviceVec;
    deviceVec.push_back(1);
    MOCKER_CPP(&FeatureCtrl::IsAosCore).stubs().will(returnValue(true));
    auto ret = inst.GetThreadVfAicpuDCpuInfo(deviceVec);
    EXPECT_EQ(ret, 0);
}
 
TEST_F(AICPUScheduleTEST, InitDrvMgrCaluniqueVfId_001) {
    AicpuDrvManager inst;
    std::vector<uint32_t> deviceVec;
    deviceVec.push_back(1);
    MOCKER_CPP(&FeatureCtrl::IsAosCore).stubs().will(returnValue(true));
    inst.InitDrvMgrCaluniqueVfId(deviceVec, 1);
    EXPECT_EQ(inst.uniqueVfId_, 1);
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
    MOCKER_CPP(&FeatureCtrl::LoadKernelSo).stubs().will(returnValue(true));
    MOCKER_CPP(&ComputeProcess::StartTdtServer)
        .stubs()
        .will(returnValue(0));
    const AicpuSchedMode schedMode = SCHED_MODE_INTERRUPT;
    int ret = ComputeProcess::GetInstance().Start(deviceVec, 100, ch, PROFILING_OPEN, 0, aicpu::PROCESS_PCIE_MODE, schedMode);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
}
 
TEST_F(AICPUScheduleTEST, GetNormalAicpuInfoSuccess4) {
    std::vector<uint32_t> device_vec;
    device_vec.push_back(0U);
    int64_t expect_aicpuNum = 8;
    int64_t expect_aicpu_index[] = {0, 1, 2, 3, 4, 5, 6, 7};
    MOCKER(halGetDeviceInfo).stubs().will(invoke(halGetDeviceInfoFake2));
    int ret = AicpuDrvManager::GetInstance().GetNormalAicpuInfo(device_vec);
    EXPECT_EQ(ret, DRV_ERROR_NONE);
    EXPECT_EQ(expect_aicpuNum, AicpuDrvManager::GetInstance().GetAicpuNumPerDevice());
    MOCKER_CPP(&FeatureCtrl::IsAosCore).stubs().will(returnValue(true));
    for (uint32_t i = 0; i < expect_aicpuNum; i++) {
        EXPECT_EQ(AicpuDrvManager::GetInstance().GetAicpuPhysIndex(i, 0U), expect_aicpu_index[i]);
    }
}
 
TEST_F(AICPUScheduleTEST, InitDrvMgr_001) {
    MOCKER(halGetDeviceInfo)
        .stubs()
        .will(returnValue(1));
    std::vector<uint32_t> deviceVec;
    deviceVec.push_back(32);
    MOCKER_CPP(&AicpuDrvManager::GetNormalAicpuInfo).stubs().will(returnValue(0));
    MOCKER_CPP(&AicpuDrvManager::GetCcpuInfo).stubs().will(returnValue(AICPU_SCHEDULE_ERROR_INIT_FAILED));
    int ret = AicpuDrvManager::GetInstance().InitDrvMgr(deviceVec, 3200, 0, false);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_INIT_FAILED);
}
 
TEST_F(AICPUScheduleTEST, BuildAndSetContext_001)
{
    MOCKER_CPP(&FeatureCtrl::IsAosCore).stubs().will(returnValue(true));
    auto ret = AicpuScheduleInterface::GetInstance().BuildAndSetContext(0, 0, 0);
    EXPECT_EQ(ret, 0);
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

TEST_F(AICPUScheduleTEST, St_SendLoadPlatformInfoToCust) {
    MOCKER(sem_init) .stubs().will(returnValue(0));
    MOCKER(sem_wait).stubs().will(returnValue(0));
    MOCKER(sem_post).stubs().will(returnValue(0));
    MOCKER(sem_destroy).stubs().will(returnValue(0));
    MOCKER_CPP(&AicpuSdLoadPlatformInfoProcess::SendLoadPlatformInfoMessageToCustSync).stubs().will(returnValue(0));
    struct TsdSubEventInfo msg;
    int32_t ret = SendLoadPlatformInfoToCust(&msg);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
}

TEST_F(AICPUScheduleTEST, St_SendLoadPlatformInfoToCust_failed1) {
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

TEST_F(AICPUScheduleTEST, St_SendMsgToMain) {
    MOCKER(sem_init) .stubs().will(returnValue(0));
    MOCKER(sem_wait).stubs().will(returnValue(0));
    MOCKER(sem_post).stubs().will(returnValue(0));
    MOCKER(sem_destroy).stubs().will(returnValue(0));
    MOCKER(halEschedSubmitEvent).stubs().will(returnValue(AICPU_SCHEDULE_OK));
    struct TsdSubEventInfo msg;
    int32_t ret = AicpuSdLoadPlatformInfoProcess::GetInstance().SendMsgToMain((void *)(&msg), sizeof(msg));
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
}

TEST_F(AICPUScheduleTEST, St_SendMsgToMain_failed1) {
    MOCKER(sem_init) .stubs().will(returnValue(0));
    MOCKER(sem_wait).stubs().will(returnValue(0));
    MOCKER(sem_post).stubs().will(returnValue(0));
    MOCKER(sem_destroy).stubs().will(returnValue(0));
    MOCKER(halEschedSubmitEvent).stubs().will(returnValue(1));
    struct TsdSubEventInfo msg;
    int32_t ret = AicpuSdLoadPlatformInfoProcess::GetInstance().SendMsgToMain((void *)(&msg), sizeof(msg));
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_DRV_ERR);
}

TEST_F(AICPUScheduleTEST, St_SendMsgToMain_failed2) {
    MOCKER(sem_init) .stubs().will(returnValue(0));
    MOCKER(sem_wait).stubs().will(returnValue(-1));
    MOCKER(sem_post).stubs().will(returnValue(0));
    MOCKER(sem_destroy).stubs().will(returnValue(0));
    MOCKER(halEschedSubmitEvent).stubs().will(returnValue(0));
    struct TsdSubEventInfo msg;
    int32_t ret = AicpuSdLoadPlatformInfoProcess::GetInstance().SendMsgToMain((void *)(&msg), sizeof(msg));
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_INIT_FAILED);
}

TEST_F(AICPUScheduleTEST, St_SendMsgToMain_failed3) {
    MOCKER(sem_init) .stubs().will(returnValue(-1));
    MOCKER(sem_wait).stubs().will(returnValue(0));
    MOCKER(sem_post).stubs().will(returnValue(0));
    MOCKER(sem_destroy).stubs().will(returnValue(0));
    MOCKER(halEschedSubmitEvent).stubs().will(returnValue(AICPU_SCHEDULE_OK));
    struct TsdSubEventInfo msg;
    int32_t ret = AicpuSdLoadPlatformInfoProcess::GetInstance().SendMsgToMain((void *)(&msg), sizeof(msg));
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_INIT_FAILED);
}

TEST_F(AICPUScheduleTEST, St_SendMsgToMain_failed4) {
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

TEST_F(AICPUScheduleTEST, St_SendLoadPlatformInfoMessageToCustSync) {
    MOCKER(sem_init) .stubs().will(returnValue(0));
    MOCKER(sem_wait).stubs().will(returnValue(0));
    MOCKER(sem_post).stubs().will(returnValue(0));
    MOCKER(sem_destroy).stubs().will(returnValue(0));
    struct TsdSubEventInfo msg;
    int32_t ret = AicpuSdLoadPlatformInfoProcess::GetInstance().SendMsgToMain((void *)(&msg), sizeof(msg));
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
}


TEST_F(AICPUScheduleTEST, St_DoUdfDatadumpTask) {
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

TEST_F(AICPUScheduleTEST, ST_CreateUdfDatadumpThread) {
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

TEST_F(AICPUScheduleTEST, ST_CreateDatadumpThread) {
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