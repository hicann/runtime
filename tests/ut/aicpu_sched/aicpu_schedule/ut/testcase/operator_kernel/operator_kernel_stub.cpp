/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "operator_kernel_stub.h"

namespace AicpuSchedule {
char dequeueFakeMBuf[maxQueueNum][maxMbufNumInMbuflist][mbufSize] = {0};
char allocFakeMBuf[maxQueueNum][mbufSize] = {0};
uint32_t allocIndex = 0;
uint32_t singeMbufListIndex = 0;
void *singleMbufList[maxQueueNum] = {nullptr};
std::map<uint32_t, std::list<void *>> enqueueFakeStore;
std::list<uint32_t> mbufChainGetNumReturnValues;
uint32_t dequeueCount = 0;
uint32_t enqueueCount = 0;
AicpuModel *aicpuModel = nullptr;
char bufForFakeEOS[MAX_SIZE_BUF_FOR_FAKE_EOS] = {0};
void *halMbufGetBuffAddrFakeAddr = nullptr;
RunContext runContextT = {.modelId = modelId, .modelTsId = 1, .streamId = 1, .pending = false, .executeInline = true};
CommonBufHead g_curHead = {};
uint32_t batchDequeueInfoQueueIds[] = { 0U, 1U };
uint8_t mbuf[1024] = {0x1};
uint64_t mbufAddr = static_cast<uint64_t>(reinterpret_cast<uintptr_t>(reinterpret_cast<void *>(mbuf)));
uint64_t batchDequeueInfoMbufAddrs[] = { mbufAddr, mbufAddr };

int32_t halMbufGetBuffAddrFake2(Mbuf *mbuf, void **buf)
{
    *buf = halMbufGetBuffAddrFakeAddr;
    return DRV_ERROR_NONE;
}

int halMbufGetPrivInfoFake(Mbuf *mbuf,  void **priv, unsigned int *size)
{
    *priv = (void *)mbuf;
    *size = mbufHeadSize;
    return DRV_ERROR_NONE;
}

int halMbufGetBuffSizeFake(Mbuf *mbuf, uint64_t *totalSize)
{
    (void)(mbuf);
    *totalSize = 102;
    return -1;
}

drvError_t halQueueDeQueueFake(unsigned int devId, unsigned int qid, void **mbuf)
{
    uint32_t index = qid%maxQueueNum;
    *mbuf = (Mbuf *)dequeueFakeMBuf[index];
    printf("halQueueDeQueueFake mbuf:%p, index:%u\n", *mbuf, index);
    dequeueCount++;
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

int halMbufGetPrivInfoFake2(Mbuf *mbuf,  void **priv, unsigned int *size)
{
    *priv = (void *)mbuf;
    *size = mbufDataOffSet;
    return DRV_ERROR_NONE;
}

int halMbufAllocFakeByAlloc(uint64_t size, unsigned int align, unsigned long flag, int grp_id, Mbuf **mbuf)
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

int halMbufGetDataLenFake(Mbuf *mbuf, uint64_t *len)
{
    *len = sizeof(RuntimeTensorDesc) + sizeof(uint64_t);
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

HcclResult HcclWaitOneSuccessFake(int32_t count, HcclRequest requestArray[], int32_t *compCount, int32_t compIndices[],
                                  HcclStatus compStatus[])
{
    *compCount = 1;
    compIndices[0U] = 0;
    compStatus[0U].error = 0;
    return HCCL_SUCCESS;
}

int32_t AlignTimestampStub1(BatchDequeueInfo &batchDeqInfo, const RunContext &taskContext,
    uint32_t &maxAlignTimestamp, uint32_t &minAlignTimestamp, uint32_t &minTimestampIndex)
{
    maxAlignTimestamp = 0;
    minAlignTimestamp = 0;
    minTimestampIndex = 0;
    return AICPU_SCHEDULE_OK;
}

int32_t AlignTimestampStub2(BatchDequeueInfo &batchDeqInfo, const RunContext &taskContext, uint32_t &maxAlignTimestamp,
    uint32_t &minAlignTimestamp, uint32_t &minTimestampIndex)
{
    maxAlignTimestamp = 1;
    minAlignTimestamp = 0;
    minTimestampIndex = 0;
    return AICPU_SCHEDULE_OK;
}
}  // namespace AicpuSchedule