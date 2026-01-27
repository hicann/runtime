/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "hccl/hcom.h"
#include "hccl/hccl_ex.h"
#include "common/bqs_log.h"
#include "hccl/hccl_so_manager.h"

HcclResult HcclInitComm(const char_t *rankTableM, uint32_t rank, const CommAttr *attr, HcclComm *comm)
{
    void * const func = dgw::HcclSoManager::GetInstance()->GetFunc("HcclInitComm");
    if (func == nullptr) {
        DGW_LOG_ERROR("libhccl.so can't get function [HcclInitComm]");
        return HCCL_E_RESERVED;
    }
    return (PtrToFunctionPtr<void, dgw::HcclInitCommFunc>(func))(rankTableM, rank, attr, comm);
}

HcclResult HcclFinalizeComm(HcclComm comm)
{
    void * const func = dgw::HcclSoManager::GetInstance()->GetFunc("HcclFinalizeComm");
    if (func == nullptr) {
        DGW_LOG_ERROR("libhccl.so can't get function [HcclFinalizeComm]");
        return HCCL_E_RESERVED;
    }
    return (PtrToFunctionPtr<void, dgw::HcclFinalizeCommFunc>(func))(comm);
}

int HcclIsend(void *buffer, int count, HcclDataType dataType,
              int dstRank, int tag, HcclComm comm, HcclRequest *request)
{
    void * const func = dgw::HcclSoManager::GetInstance()->GetFunc("HcclIsend");
    if (func == nullptr) {
        DGW_LOG_ERROR("libhccl.so can't get function [HcclIsend]");
        return HCCL_E_RESERVED;
    }
    return (PtrToFunctionPtr<void, dgw::HcclIsendFunc>(func))(buffer, count, dataType, dstRank, tag, comm, request);
}

int HcclImrecv(void *buffer, int count, HcclDataType datatype, HcclMessage *msg, HcclRequest *request)
{
    void * const func = dgw::HcclSoManager::GetInstance()->GetFunc("HcclImrecv");
    if (func == nullptr) {
        DGW_LOG_ERROR("libhccl.so can't get function [HcclImrecv]");
        return HCCL_E_RESERVED;
    }
    return (PtrToFunctionPtr<void, dgw::HcclImrecvFunc>(func))(buffer, count, datatype, msg, request);
}

int HcclImprobe(int srcRank, int tag, HcclComm comm, int *flag, HcclMessage *msg, HcclStatus *status)
{
    void * const func = dgw::HcclSoManager::GetInstance()->GetFunc("HcclImprobe");
    if (func == nullptr) {
        DGW_LOG_ERROR("libhccl.so can't get function [HcclImprobe]");
        return HCCL_E_RESERVED;
    }
    return (PtrToFunctionPtr<void, dgw::HcclImprobeFunc>(func))(srcRank, tag, comm, flag, msg, status);
}

int HcclGetCount(const HcclStatus *status, HcclDataType dataType, int *count)
{
    void * const func = dgw::HcclSoManager::GetInstance()->GetFunc("HcclGetCount");
    if (func == nullptr) {
        DGW_LOG_ERROR("libhccl.so can't get function [HcclGetCount]");
        return HCCL_E_RESERVED;
    }
    return (PtrToFunctionPtr<void, dgw::HcclGetCountFunc>(func))(status, dataType, count);
}

int HcclTestSome(int count, HcclRequest requestArray[], int *compCount, int compIndices[], HcclStatus compStatus[])
{
    void * const func = dgw::HcclSoManager::GetInstance()->GetFunc("HcclTestSome");
    if (func == nullptr) {
        DGW_LOG_ERROR("libhccl.so can't get function [HcclTestSome]");
        return HCCL_E_RESERVED;
    }
    return (PtrToFunctionPtr<void, dgw::HcclTestSomeFunc>(func))(count, requestArray, compCount, compIndices, compStatus);
}

HcclResult HcclRegisterMemory(HcclComm comm, void *addr, uint64_t size)
{
    void * const func = dgw::HcclSoManager::GetInstance()->GetFunc("HcclRegisterMemory");
    if (func == nullptr) {
        DGW_LOG_ERROR("libhccl.so can't get function [HcclRegisterMemory]");
        return HCCL_E_RESERVED;
    }
    return (PtrToFunctionPtr<void, dgw::HcclRegisterMemoryFunc>(func))(comm, addr, size);
}

HcclResult HcclUnregisterMemory(HcclComm comm, void *addr)
{
    void * const func = dgw::HcclSoManager::GetInstance()->GetFunc("HcclUnregisterMemory");
    if (func == nullptr) {
        DGW_LOG_ERROR("libhccl.so can't get function [HcclUnregisterMemory]");
        return HCCL_E_RESERVED;
    }
    return (PtrToFunctionPtr<void, dgw::HcclUnregisterMemoryFunc>(func))(comm, addr);
}

HcclResult HcclSetGrpIdCallback(int32_t(*grpIdCallback)(int32_t, int32_t*, int32_t*))
{
    void * const func = dgw::HcclSoManager::GetInstance()->GetFunc("HcclSetGrpIdCallback");
    if (func == nullptr) {
        DGW_LOG_ERROR("libhccl.so can't get function [HcclSetGrpIdCallback]");
        return HCCL_E_RESERVED;
    }
    return (PtrToFunctionPtr<void, dgw::HcclSetGrpIdCallback>(func))(grpIdCallback);
}