/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include <cstdint>

namespace {
constexpr int32_t kHcclSuccess = 0;
constexpr int32_t kHcclAgain = 7;

bool g_returnAgain = false;

struct FakeStatus {
    int32_t error;
};
} // namespace

extern "C" void AicpusdFakeHcclSetWaitAgain(const bool returnAgain) { g_returnAgain = returnAgain; }

extern "C" int32_t HcclInitCsComm(const char*, int32_t, const char*, const void*, void** comm)
{
    if (comm != nullptr) {
        *comm = reinterpret_cast<void*>(0x1UL);
    }
    return kHcclSuccess;
}

extern "C" int32_t HcclFinalizeCsComm(void*) { return kHcclSuccess; }

extern "C" int32_t HcclGetLookupRequest(void*, int32_t, int32_t, int32_t, void** handle, void*, FakeStatus* status)
{
    if (handle != nullptr) {
        *handle = reinterpret_cast<void*>(0x2UL);
    }
    if (status != nullptr) {
        status->error = kHcclSuccess;
    }
    return kHcclSuccess;
}

extern "C" int32_t HcclIsetLookupResponse(void*, int32_t, int32_t, void*, void*, void** request)
{
    if (request != nullptr) {
        *request = reinterpret_cast<void*>(0x3UL);
    }
    return kHcclSuccess;
}

extern "C" int32_t HcclWaitSome(int32_t, void*[], int32_t* compCount, int32_t compIndices[], FakeStatus compStatus[])
{
    if (g_returnAgain) {
        return kHcclAgain;
    }
    if (compCount != nullptr) {
        *compCount = 1;
    }
    if (compIndices != nullptr) {
        compIndices[0] = 0;
    }
    if (compStatus != nullptr) {
        compStatus[0].error = kHcclSuccess;
    }
    return kHcclSuccess;
}

extern "C" int32_t HcclAbortSelf(void*, int32_t) { return kHcclSuccess; }

extern "C" int32_t HddsServiceCancel(void*) { return kHcclSuccess; }

extern "C" int32_t HddsCollRecvUpdateRequest(
    void*, int32_t, int32_t, void*, int32_t, int32_t, int32_t, void** handle, void*, FakeStatus* status)
{
    if (handle != nullptr) {
        *handle = reinterpret_cast<void*>(0x4UL);
    }
    if (status != nullptr) {
        status->error = kHcclSuccess;
    }
    return kHcclSuccess;
}

extern "C" int32_t HddsIsendUpdateResponse(void*, void*, void** request)
{
    if (request != nullptr) {
        *request = reinterpret_cast<void*>(0x5UL);
    }
    return kHcclSuccess;
}

extern "C" int32_t HddsCollRecvLookupRequest(void*, int32_t, int32_t, int32_t, void** handle, void*, FakeStatus* status)
{
    if (handle != nullptr) {
        *handle = reinterpret_cast<void*>(0x6UL);
    }
    if (status != nullptr) {
        status->error = kHcclSuccess;
    }
    return kHcclSuccess;
}

extern "C" int32_t HddsIsendLookupResponse(void*, int32_t, int32_t, void*, void*, void** request)
{
    if (request != nullptr) {
        *request = reinterpret_cast<void*>(0x7UL);
    }
    return kHcclSuccess;
}

extern "C" int32_t HcclDestroyResouce(void*, int32_t) { return kHcclSuccess; }

extern "C" int32_t HcclRpcRegisterGlobalMemory(void*, uint64_t) { return kHcclSuccess; }

extern "C" int32_t HcclRpcUnregisterGlobalMemory(void*) { return kHcclSuccess; }

extern "C" int32_t HcclPsAssociateWorkers(void*, int32_t, uint32_t[], uint64_t) { return kHcclSuccess; }

extern "C" int32_t HcomPrepareStart(const void*, void** request)
{
    if (request != nullptr) {
        *request = reinterpret_cast<void*>(0x8UL);
    }
    return kHcclSuccess;
}

extern "C" int32_t HcomPrepareQuery(void*, FakeStatus* status)
{
    if (status != nullptr) {
        status->error = kHcclSuccess;
    }
    return kHcclSuccess;
}

extern "C" int32_t HcomSendByOS(void*, uint64_t, int32_t, uint32_t, uint32_t, const char*, uint64_t)
{
    return kHcclSuccess;
}

extern "C" int32_t HcomReceiveByOS(void*, uint64_t, int32_t, uint32_t, uint32_t, const char*, uint64_t)
{
    return kHcclSuccess;
}

extern "C" int32_t HcomInitByRankTable(const char*, uint32_t) { return kHcclSuccess; }

extern "C" int32_t HcomDestroy() { return kHcclSuccess; }

extern "C" int32_t HcomCreateGroup(const char*, uint32_t, uint32_t*) { return kHcclSuccess; }

extern "C" int32_t HcomDestroyGroup(const char*) { return kHcclSuccess; }

extern "C" int32_t HcomGatherByOs(void*, uint64_t, int32_t, void*, uint64_t, int32_t, uint32_t, const char*, uint64_t)
{
    return kHcclSuccess;
}

extern "C" int32_t HcomBcastByOS(void*, uint64_t, int32_t, uint32_t, const char*, uint64_t) { return kHcclSuccess; }

extern "C" int32_t HcclCpuCommInitClusterInfoMemConfig(const char*, uint32_t, void*) { return kHcclSuccess; }
