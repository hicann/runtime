/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef TESTS_UT_AICPU_SCHED_AICPU_SCHEDULE_UT_TESTCASE_AICPUSD_HCCL_API_H_
#define TESTS_UT_AICPU_SCHED_AICPU_SCHEDULE_UT_TESTCASE_AICPUSD_HCCL_API_H_

#include <map>
#include <mutex>
#include <set>
#include <string>
#include "aicpusd_common.h"
#include "driver/ascend_hal_define.h"

using ServiceHandle = void*;
using HcclRequest = void*;
using HcclComm = void*;
constexpr int32_t RET_SUCCESS = 0;
constexpr int32_t RET_FAILED = 1;

enum HcclResult { HCCL_SUCCESS = 0, HCCL_E_AGAIN = 7, HCCL_E_RESERVED = 11 };

enum HcclDataType { HCCL_DATA_TYPE_INT8 = 0 };

struct CalcParams {};
struct ReqStatus {
    int32_t error;
};
struct UpdateReqStatus {
    int32_t error;
};
struct LookupReqStatus {
    int32_t error;
};
struct HcclStatus {
    int32_t error;
};
struct HcomOpDesc {};
using HcomRequest = void*;
struct HcomStatus {
    int32_t error;
};
struct HcclCommConfig {};

namespace AicpuSchedule {
class HcclSoManager {
public:
    static HcclSoManager* GetInstance();
    void LoadHccdSo();
    void LoadHcclSo();
    void LoadSo();
    void UnLoadHccdSo();
    void UnLoadHcclSo();
    void UnloadSo();
    void* GetFunc(const std::string& name) const;
    ~HcclSoManager();

private:
    HcclSoManager() = default;
    void* hccdSoHandle_ = nullptr;
    void* hcclSoHandle_ = nullptr;
    std::map<std::string, void*> funcMap_;
};

class MBufferPool {
public:
    int32_t Init(uint32_t blockNum, uint32_t blockSize, bool registerMem);
    void UnInit();
    int32_t Allocate(Mbuf** mbufPtr);
    int32_t Free(Mbuf* mbuf);
    int32_t FreeAll();

private:
    poolHandle mp_ = nullptr;
    void* poolAddr_ = nullptr;
    uint64_t poolSize_ = 0UL;
    bool isRegister_ = false;
    std::mutex mutexForMbufSet_;
    std::set<Mbuf*> mbufsAllocated_;
};

HcclResult StubHcclInitCsComm(
    const char_t* rankTableM, int32_t rankId, const char_t* roleTable, const CalcParams* calcParams, HcclComm* comm);
HcclResult StubHcclFinalizeComm(HcclComm comm);
HcclResult StubHcclGetLookupRequest(
    void* keys, int32_t count, HcclDataType type, int32_t tag, ServiceHandle* handle, HcclComm comm, ReqStatus* status);
HcclResult StubHcclIsetLookupResponse(
    void* values, int32_t count, HcclDataType type, ServiceHandle handle, HcclComm comm, HcclRequest* request);
HcclResult StubHcclWaitSome(
    int32_t count, HcclRequest requestArray[], int32_t* compCount, int32_t compIndices[], HcclStatus compStatus[]);
HcclResult StubHcclAbortSelf(HcclComm comm, int32_t tag);
HcclResult StubHddsServiceCancel(ServiceHandle handle);
int32_t SingleHcclWait(HcclRequest request);
HcclResult StubHddsCollRecvUpdateRequest(
    void* keys, int32_t keyCount, HcclDataType keyType, void* values, int32_t valueCount, HcclDataType valueType,
    int32_t tag, ServiceHandle* handle, HcclComm comm, UpdateReqStatus* status);
HcclResult StubHddsIsendUpdateResponse(ServiceHandle handle, HcclComm comm, HcclRequest* request);
HcclResult StubHddsCollRecvLookupRequest(
    void* keys, int32_t count, HcclDataType type, int32_t tag, ServiceHandle* handle, HcclComm comm,
    LookupReqStatus* status);
HcclResult StubHddsIsendLookupResponse(
    void* values, int32_t count, HcclDataType type, ServiceHandle handle, HcclComm comm, HcclRequest* request);
HcclResult StubHcomPrepareStart(const HcomOpDesc* op, HcomRequest* request);
HcclResult StubHcomPrepareQuery(HcomRequest request, HcomStatus* status);
HcclResult StubHcomSendByOS(
    void* buf, uint64_t count, HcclDataType dataType, uint32_t peerRank, uint32_t tag, const char_t* group,
    uint64_t flag);
HcclResult StubHcomReceiveByOS(
    void* buf, uint64_t count, HcclDataType dataType, uint32_t peerRank, uint32_t tag, const char_t* group,
    uint64_t flag);
HcclResult StubHcomInitByRankTable(const char_t* rankTable, uint32_t rankId);
HcclResult StubHcomDestroy();
HcclResult StubHcomCreateGroup(const char_t* group, uint32_t rankNum, uint32_t* rankIds);
HcclResult StubHcomDestroyGroup(const char_t* group);
HcclResult StubHcomBroadcastByOS(
    void* buf, uint64_t count, HcclDataType dataType, uint32_t root, const char* group, uint64_t flag);
HcclResult StubHcomGatherByOS(
    void* inputBuf, uint64_t inputCount, HcclDataType inputType, void* outputBuf, uint64_t outputCount,
    HcclDataType outputType, uint32_t root, const char* group, uint64_t flag);
HcclResult StubHcclDestroyResouce(HcclComm comm, int32_t tag);
HcclResult StubHcclRegisterGlobalMemory(void* addr, uint64_t size);
HcclResult StubHcclUnregisterGlobalMemory(void* addr);
HcclResult StubHcclPsAssociateWorkers(HcclComm comm, int32_t tag, uint32_t workerRanks[], uint64_t workerNum);
HcclResult StubHcclCpuCommInit(const char_t* rankTable, uint32_t rank, HcclCommConfig* config);
} // namespace AicpuSchedule

#endif // TESTS_UT_AICPU_SCHED_AICPU_SCHEDULE_UT_TESTCASE_AICPUSD_HCCL_API_H_
