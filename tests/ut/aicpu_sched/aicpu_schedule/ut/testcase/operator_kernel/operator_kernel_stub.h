/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef OPERATOR_KERNEL_STUB_H
#define OPERATOR_KERNEL_STUB_H

#include <list>
#include "gtest/gtest.h"
#include "mockcpp/mockcpp.hpp"
#include "aicpusd_status.h"
#include "aicpusd_common.h"
#define private public
#include "aicpusd_model.h"
#include "aicpusd_resource_manager.h"
#undef private
#include "operator_kernel_context.h"
#include <iostream>
namespace AicpuSchedule {
struct CommonBufHead {
    uint64_t resv[24];
    MbufHeadMsg aicpuBufhead;
};

constexpr uint32_t mbufDataOffSet = 256;
constexpr uint32_t maxMbufNumInMbuflist = 20;
constexpr uint32_t mbufSize = 384;
constexpr uint32_t mbufDataPtrSize = mbufSize-mbufDataOffSet;
constexpr uint32_t maxQueueNum = 64;
constexpr uint32_t modelId = 1;
constexpr uint32_t mbufHeadSize = 4;
constexpr uint32_t MAX_SIZE_BUF_FOR_FAKE_EOS = 512U;

// global variable
extern char dequeueFakeMBuf[maxQueueNum][maxMbufNumInMbuflist][mbufSize];
extern char allocFakeMBuf[maxQueueNum][mbufSize];
extern uint32_t allocIndex;
extern uint32_t singeMbufListIndex;
extern void* singleMbufList[maxQueueNum];
extern std::map<uint32_t, std::list<void*>> enqueueFakeStore;
extern std::list<uint32_t> mbufChainGetNumReturnValues;
extern uint32_t dequeueCount;
extern uint32_t enqueueCount;
extern AicpuModel *aicpuModel;
extern char bufForFakeEOS[MAX_SIZE_BUF_FOR_FAKE_EOS];
extern void *halMbufGetBuffAddrFakeAddr;
extern RunContext runContextT;
extern CommonBufHead g_curHead;
extern uint32_t batchDequeueInfoQueueIds[];
extern uint8_t mbuf[1024];
extern uint64_t mbufAddr;
extern uint64_t batchDequeueInfoMbufAddrs[];

class OperatorKernelTest : public testing::Test {
public:
    virtual void SetUp()
    {
        clearData();
    }

    virtual void TearDown()
    {
        clearData();
        GlobalMockObject::verify();
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
};


int32_t halMbufGetBuffAddrFake2(Mbuf *mbuf, void **buf);
int halMbufGetPrivInfoFake(Mbuf *mbuf,  void **priv, unsigned int *size);
int halMbufGetBuffSizeFake(Mbuf *mbuf, uint64_t *totalSize);
drvError_t halQueueDeQueueFake(unsigned int devId, unsigned int qid, void **mbuf);
int halMbufGetPrivInfoFakeForEOS(Mbuf *mbuf,  void **priv, unsigned int *size);
drvError_t halQueueDeQueueFakeForEOS(unsigned int devId, unsigned int qid, void **mbuf);
DLLEXPORT drvError_t halQueueEnQueueFake(unsigned int devId, unsigned int qid, void *mbuf);
int halMbufAllocFake(unsigned int size, unsigned int align, unsigned long flag, int grp_id, Mbuf **mbuf);
int halMbufFreeFake(Mbuf *mbuf);
int32_t halMbufGetBuffAddrFake(Mbuf *mbuf, void **buf);
int halMbufGetPrivInfoFake2(Mbuf *mbuf,  void **priv, unsigned int *size);
int halMbufAllocFakeByAlloc(uint64_t size, unsigned int align, unsigned long flag, int grp_id, Mbuf **mbuf);
int halMbufFreeFakeByFree(Mbuf *mbuf);
uint32_t getMbufInMbufListOffSet(uint32_t index);
Mbuf* getMbufInMbufList(Mbuf* mbufChainHead, uint32_t index);
void* calcMbufDataPtrFack(Mbuf* mbufChainHead, unsigned int index);
int halMbufChainGetMbufFake(Mbuf *mbufChainHead, unsigned int index, Mbuf **mbuf);
int halMbufChainAppendFake(Mbuf *a, Mbuf *b);
int halMbufChainGetMbufNumFack(Mbuf *mbufChainHead, unsigned int *num);
int halMbufGetDataLenFake(Mbuf *mbuf, uint64_t *len);
uint32_t calcGuardBufSize(bool isSingleMbuflistOutput);
void setSimpleAicpuPrepareInfo(AicpuPrepareInfo &info);
HcclResult HcclWaitOneSuccessFake(int32_t count, HcclRequest requestArray[], int32_t *compCount, int32_t compIndices[],
                                  HcclStatus compStatus[]);
int32_t AlignTimestampStub1(BatchDequeueInfo &batchDeqInfo, const RunContext &taskContext,
    uint32_t &maxAlignTimestamp, uint32_t &minAlignTimestamp, uint32_t &minTimestampIndex);
int32_t AlignTimestampStub2(BatchDequeueInfo &batchDeqInfo, const RunContext &taskContext, uint32_t &maxAlignTimestamp,
    uint32_t &minAlignTimestamp, uint32_t &minTimestampIndex);

#define BUILD_SUCC_PREPARE_INFO()                                                                                            \
    aicpuModel = new AicpuModel();                                                                                   \
    aicpuModel->modelId_= modelId;                                                                                            \
    aicpuModel->iteratorCount_ = 1;                                                                                            \
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

}  // namespace AicpuSchedule

#endif  // OPERATOR_KERNEL_STUB_H