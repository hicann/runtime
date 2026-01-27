/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
// #include "hcom.h"

HcclResult HcclInitComm(const char* rankTableM, uint32_t rank, const CommAttr *attr, HcclComm *comm)
{
    return HCCL_SUCCESS;
}

HcclResult HcclFanalizeComm(HcclComm comm)
{
    return HCCL_SUCCESS;
}

HcclResult HcclRegisterBuffer(void* buffer, uint64_t size)
{
    return HCCL_SUCCESS;
}

HcclResult HcclUnregisterBuffer(void* buffer)
{
    return HCCL_SUCCESS;
}

HcclResult HcclAllocTag(HcclComm comm, uint32_t peerRank, const TagAttr* attr, uint32_t* tag)
{
    return HCCL_SUCCESS;
}

HcclResult HcclFreeTag(HcclComm comm, uint32_t peerRank, uint32_t tag)
{
    return HCCL_SUCCESS;
}

HcclResult HcclIsendWithEvent(void* buffer, uint64_t count, HcclDataType dataType, uint32_t peerRank, uint32_t tag,
    HcclComm comm, void* userHandle)
{
    return HCCL_SUCCESS;
}

HcclResult HcclIrecvWithEvent(void* buffer, uint64_t count, HcclDataType dataType, uint32_t peerRank, uint32_t tag,
    HcclComm comm, void* userHandle)
{
    return HCCL_SUCCESS;
}

HcclResult HcclGetSendCompletion(HcclComm comm, uint32_t peerRank, uint32_t tag, void** buffer, uint64_t* count,
    HcclDataType* dataType, void** userHandle)
{
    return HCCL_SUCCESS;
}    

HcclResult HcclGetRecvRequest(HcclComm comm, uint32_t peerRank, uint32_t tag, uint64_t* count, HcclDataType* dataType)
{
    return HCCL_SUCCESS;
}

HcclResult HcclGetRecvData(HcclComm comm, uint32_t peerRank, uint32_t tag, void** buffer, uint64_t* count,
    HcclDataType* dataType, void** userHandle)
{
    return HCCL_SUCCESS;
}

HcclResult HcclEventContinue(HcclComm comm, uint32_t peerRank, uint32_t tag, HcclEventType eventType)
{
    return HCCL_SUCCESS;
}

int HcclIsend(void *buffer, int count, HcclDataType dataType, int dstRank, int tag, HcclComm comm, HcclRequest *request)
{
    return HCCL_SUCCESS;
}

int HcclImrecv(void *buffer, int count, HcclDataType datatype, HcclMessage *msg, HcclRequest *request)
{
    return HCCL_SUCCESS;
}

int HcclImprobe(int srcRank, int tag, HcclComm comm, int *flag, HcclMessage *msg, HcclStatus *status)
{
    return HCCL_SUCCESS;
}

int HcclGetCount(const HcclStatus *status, HcclDataType dataType, int *count)
{
    return HCCL_SUCCESS;
}

int HcclTestSome(int count, HcclRequest requestArray[], int *compCount, int compIndices[], HcclStatus compStatus[])
{
    return HCCL_SUCCESS;
}

HcclResult HcclRegisterMemory(HcclComm comm, void *addr, uint64_t size)
{
    return HCCL_SUCCESS;
}

HcclResult HcclUnregisterMemory(HcclComm comm, void *addr)
{
    return HCCL_SUCCESS;
}