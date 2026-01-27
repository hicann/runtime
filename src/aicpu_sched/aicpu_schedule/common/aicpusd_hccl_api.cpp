/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "aicpusd_hccl_api.h"

#include <algorithm>
#include <dlfcn.h>

#include "aicpusd_status.h"

namespace AicpuSchedule {
constexpr int32_t BUFF_POOL_DEVICE_ID = 0;
constexpr uint32_t BUFF_POOL_ALIGN = 4096U;  // 4kb
constexpr int32_t COUNT_ONE = 1;
constexpr uint32_t INDEX_ZERO = 0U;

using HcclInitCsCommFunc = HcclResult (*)(const char_t*, int32_t, const char_t*, const CalcParams*, HcclComm*);
using HcclFinalizeCommFunc = HcclResult (*)(HcclComm);
using HcclGetLookupRequestFunc = HcclResult (*)(void*, int32_t, HcclDataType, int32_t, ServiceHandle*, HcclComm,
                                                ReqStatus*);
using HcclIsetLookupResponseFunc = HcclResult (*)(void*, int32_t, HcclDataType, ServiceHandle, HcclComm, HcclRequest*);
using HcclWaitSomeFunc = HcclResult (*)(int32_t, HcclRequest[], int32_t*, int32_t[], HcclStatus[]);
using HcclAbortSelfFunc = HcclResult (*)(HcclComm, int32_t);
using HddsServiceCancelFunc = HcclResult (*)(ServiceHandle);
using HddsCollRecvUpdateRequestFunc = HcclResult (*)(void*, int32_t, HcclDataType, void*, int32_t, HcclDataType,
    int32_t, ServiceHandle*, HcclComm, UpdateReqStatus*);
using HddsIsendUpdateResponseFunc = HcclResult (*)(ServiceHandle, HcclComm, HcclRequest*);
using HddsCollRecvLookupRequestFunc = HcclResult (*)(void*, int32_t, HcclDataType, int32_t, ServiceHandle*, HcclComm,
    LookupReqStatus*);
using HddsIsendLookupResponseFunc = HcclResult (*)(void*, int32_t, HcclDataType, ServiceHandle, HcclComm, HcclRequest*);
using HcomPrepareStartFunc = HcclResult (*)(const HcomOpDesc*, HcomRequest*);
using HcomPrepareQueryFunc = HcclResult (*)(HcomRequest, HcomStatus*);
using HcomSendByOSFunc = HcclResult (*)(void*, uint64_t, HcclDataType, uint32_t, uint32_t, const char_t*, uint64_t);
using HcomReceiveByOSFunc = HcclResult (*)(void*, uint64_t, HcclDataType, uint32_t, uint32_t, const char_t*, uint64_t);
using HcomInitByRankTableFunc = HcclResult (*)(const char_t*, uint32_t);
using HcomDestroyFunc = HcclResult (*)();
using HcomCreateGroupFunc = HcclResult (*)(const char_t *, uint32_t, uint32_t *);
using HcomDestroyGroupFunc = HcclResult (*)(const char_t *);
using HcomBroadcastByOSFunc = HcclResult (*)(void*, uint64_t, HcclDataType, uint32_t, const char *, uint64_t);
using HcomGatherByOSFunc = HcclResult (*)(void*, uint64_t, HcclDataType, void*, uint64_t, HcclDataType, uint32_t,
                                          const char *, uint64_t);
using HcclDestroyResouceFunc = HcclResult (*)(HcclComm, int32_t);
using HcclRegisterGlobalMemoryFunc = HcclResult (*)(void*, uint64_t);
using HcclUnregisterGlobalMemoryFunc = HcclResult (*)(void*);
using HcclPsAssociateWorkersFunc = HcclResult (*)(HcclComm, int32_t, uint32_t[], uint64_t);
using HcclCpuCommInitClusterInfoMemConfigFunc = HcclResult (*)(const char_t*, uint32_t, HcclCommConfig*);

HcclSoManager *HcclSoManager::GetInstance()
{
    static HcclSoManager hcclSoIns;
    return &hcclSoIns;
}

void HcclSoManager::LoadHccdSo()
{
    if (hccdSoHandle_ != nullptr) {
        aicpusd_info("Already load libhccd.so");
        return;
    }
    hccdSoHandle_ = dlopen("libhccd.so", RTLD_LAZY);
    if (hccdSoHandle_ == nullptr) {
        aicpusd_err("Failed to dlopen libhccd.so!");
        return;
    }
    const std::string funcName[] = {"HcclInitCsComm", "HcclFinalizeCsComm",
                                    "HcclGetLookupRequest", "HcclIsetLookupResponse", "HcclWaitSome", "HcclAbortSelf",
                                    "HddsServiceCancel", "HddsCollRecvUpdateRequest", "HddsIsendUpdateResponse",
                                    "HddsCollRecvLookupRequest", "HddsIsendLookupResponse", "HcclDestroyResouce",
                                    "HcclRpcRegisterGlobalMemory", "HcclRpcUnregisterGlobalMemory",
                                    "HcclPsAssociateWorkers"};
    for (auto &name : funcName) {
        void *func = dlsym(hccdSoHandle_, name.c_str());
        if (func != nullptr) {
            funcMap_[name] = func;
        } else {
            aicpusd_err("Failed to get function [%s]", name.c_str());
        }
    }
    aicpusd_info("Load libhccd.so success");
}

void HcclSoManager::LoadHcclSo()
{
    if (hcclSoHandle_ != nullptr) {
        aicpusd_info("Already load libhccl_heterog.so");
        return;
    }
    hcclSoHandle_ = dlopen("libhccl_heterog.so", RTLD_LAZY);
    if (hcclSoHandle_ == nullptr) {
        aicpusd_err("Failed to dlopen libhccl_heterog.so!");
        return;
    }
    const std::string funcName[] = {"HcomPrepareStart", "HcomPrepareQuery", "HcomSendByOS", "HcomReceiveByOS",
                                    "HcomInitByRankTable", "HcomDestroy", "HcomCreateGroup",
                                    "HcomDestroyGroup", "HcomGatherByOs", "HcomBcastByOS",
                                    "HcclCpuCommInitClusterInfoMemConfig"};
    for (auto &name : funcName) {
        void *func = dlsym(hcclSoHandle_, name.c_str());
        if (func != nullptr) {
            funcMap_[name] = func;
        } else {
            aicpusd_err("Failed to get function [%s]", name.c_str());
        }
    }
    aicpusd_info("Load libhccl_heterog.so success");
}

void HcclSoManager::LoadSo()
{
    LoadHccdSo();
    LoadHcclSo();
}

void HcclSoManager::UnLoadHccdSo()
{
    if (hccdSoHandle_ != nullptr) {
        (void)dlclose(hccdSoHandle_);
        hccdSoHandle_ = nullptr;
    }
    aicpusd_info("Unload libhccd.so success");
}

void HcclSoManager::UnLoadHcclSo()
{
    if (hcclSoHandle_ != nullptr) {
        (void)dlclose(hcclSoHandle_);
        hcclSoHandle_ = nullptr;
    }
    aicpusd_info("Unload libhccl.so success");
}
void HcclSoManager::UnloadSo()
{
    funcMap_.clear();
    UnLoadHccdSo();
    UnLoadHcclSo();
}

void *HcclSoManager::GetFunc(const std::string &name) const
{
    const auto it = funcMap_.find(name);
    if (it != funcMap_.end()) {
        return it->second;
    }
    aicpusd_err("Can't get function [%s] from hccl so", name.c_str());
    return nullptr;
}

HcclSoManager::~HcclSoManager()
{
    UnloadSo();
}

int32_t MBufferPool::Init(const uint32_t blockNum, const uint32_t blockSize, const bool registerMem)
{
    mpAttr attr = {};
    attr.devid = BUFF_POOL_DEVICE_ID;
    attr.blkSize = blockSize;
    attr.blkNum  = blockNum;
    attr.align = BUFF_POOL_ALIGN;
    const auto ret = halBuffCreatePool(&attr, &mp_);
    if (ret != RET_SUCCESS) {
        aicpusd_err("Fail to create pool, ret is %d", ret);
        return ret;
    }

    if (!registerMem) {
        aicpusd_info("create pool success without register meomry, blockSize: %u, blockNum: %u", blockSize, blockNum);
        return RET_SUCCESS;
    }

    MemPoolInfo poolInfo = {};
    uint32_t outLen = static_cast<uint32_t>(sizeof(poolInfo));
    const auto poolInfoRet = halBuffGetInfo(BUFF_GET_MEMPOOL_INFO, &mp_, static_cast<uint32_t>(sizeof(mp_)),
        &poolInfo, &outLen);
    if (poolInfoRet == static_cast<int32_t>(DRV_ERROR_NONE)) {
        poolAddr_ = poolInfo.blk_start;
        poolSize_ = poolInfo.blk_total_len;
        const auto res = StubHcclRegisterGlobalMemory(poolAddr_, poolSize_);
        if (res != HCCL_SUCCESS) {
            aicpusd_err("Fail to register memory, res is %d.", static_cast<int32_t>(res));
        } else {
            isRegister_ = true;
            aicpusd_info("Success to register memory[%lu]", poolSize_);
        }
    } else {
        aicpusd_err("halBuffGetInfo fail, ret is %d", poolInfoRet);
    }
    aicpusd_info("create pool success, blockSize: %u, blockNum: %u", blockSize, blockNum);
    return RET_SUCCESS;
}

void MBufferPool::UnInit()
{
    if (mp_ == nullptr) {
        aicpusd_warn("mbufferPool has not been initialized yet!");
        return;
    }

    if (isRegister_) {
        const auto res = StubHcclUnregisterGlobalMemory(poolAddr_);
        if (res != HCCL_SUCCESS) {
            aicpusd_err("Fail to unregister memory, res is %d.", static_cast<int32_t>(res));
        } else {
            isRegister_ = false;
        }
    }

    const auto ret = halBuffDeletePool(mp_);
    if (ret != RET_SUCCESS) {
        aicpusd_err("Fail to delete pool, ret is %d", ret);
        return;
    }
    mp_ = nullptr;
    aicpusd_info("delete bufferpool");
}

int32_t MBufferPool::Allocate(Mbuf **mbufPtr)
{
    if (mp_ == nullptr) {
        aicpusd_err("mbufferPool has not been initialized yet!");
        return RET_FAILED;
    }
    const auto ret = halMbufAllocByPool(mp_, mbufPtr);
    if (ret != RET_SUCCESS) {
        aicpusd_warn("unable allocate by pool, ret is %d", ret);
    } else {
        std::lock_guard<std::mutex> lockForMbufSet(mutexForMbufSet_);
        mbufsAllocated_.emplace(*mbufPtr);
    }
    return ret;
}

int32_t MBufferPool::Free(Mbuf *mbuf)
{
    const auto ret = halMbufFree(mbuf);
    if (ret != RET_SUCCESS) {
        aicpusd_err("Fail to free, ret is %d", ret);
    } else {
        std::lock_guard<std::mutex> lockForMbufSet(mutexForMbufSet_);
        mbufsAllocated_.erase(mbuf);
    }
    return ret;
}

int32_t MBufferPool::FreeAll()
{
    std::set<Mbuf *> mbufsBack = mbufsAllocated_;
    for (auto mbuf: mbufsBack) {
        auto ret = Free(mbuf);
        if (ret != RET_SUCCESS) {
            return ret;
        }
    }
    return RET_SUCCESS;
}

// PS侧控制面接口:类似Helper1.0的通信域创建接口。内部根据rank_table和clusterConfig中描述的PS/worker信息直接建链,
// 只建立一组通信连接，使用者需要防重入
HcclResult StubHcclInitCsComm(const char_t *rankTableM, int32_t rankId, const char_t *roleTable,
                              const CalcParams *calcParams, HcclComm *comm)
{
    auto func = AicpuSchedule::HcclSoManager::GetInstance()->GetFunc("HcclInitCsComm");
    if (func == nullptr) {
        return HCCL_E_RESERVED;
    }
    return (reinterpret_cast<AicpuSchedule::HcclInitCsCommFunc>(func))(rankTableM, rankId, roleTable, calcParams, comm);
}

HcclResult StubHcclFinalizeComm(HcclComm comm)
{
    auto func = AicpuSchedule::HcclSoManager::GetInstance()->GetFunc("HcclFinalizeCsComm");
    if (func == nullptr) {
        return HCCL_E_RESERVED;
    }
    return (reinterpret_cast<AicpuSchedule::HcclFinalizeCommFunc>(func))(comm);
}

HcclResult StubHcclGetLookupRequest(void *keys, int32_t count, HcclDataType type, int32_t tag, ServiceHandle *handle,
                                    HcclComm comm, ReqStatus *status)
{
    auto func = AicpuSchedule::HcclSoManager::GetInstance()->GetFunc("HcclGetLookupRequest");
    if (func == nullptr) {
        return HCCL_E_RESERVED;
    }
    return (reinterpret_cast<AicpuSchedule::HcclGetLookupRequestFunc>(func))(
        keys, count, type, tag, handle, comm, status);
}

HcclResult StubHcclIsetLookupResponse(void *values, int32_t count, HcclDataType type, ServiceHandle handle,
    HcclComm comm, HcclRequest *request)
{
    auto func = AicpuSchedule::HcclSoManager::GetInstance()->GetFunc("HcclIsetLookupResponse");
    if (func == nullptr) {
        return HCCL_E_RESERVED;
    }
    return (reinterpret_cast<AicpuSchedule::HcclIsetLookupResponseFunc>(func))(
        values, count, type, handle, comm, request);
}

HcclResult StubHcclWaitSome(int32_t count, HcclRequest requestArray[], int32_t *compCount, int32_t compIndices[],
                            HcclStatus compStatus[])
{
    auto func = AicpuSchedule::HcclSoManager::GetInstance()->GetFunc("HcclWaitSome");
    if (func == nullptr) {
        return HCCL_E_RESERVED;
    }
    return (reinterpret_cast<AicpuSchedule::HcclWaitSomeFunc>(func))(
        count, requestArray, compCount, compIndices, compStatus);
}

HcclResult StubHcclAbortSelf(HcclComm comm, int32_t tag)
{
    auto func = AicpuSchedule::HcclSoManager::GetInstance()->GetFunc("HcclAbortSelf");
    if (func == nullptr) {
        return HCCL_E_RESERVED;
    }
    return (reinterpret_cast<AicpuSchedule::HcclAbortSelfFunc>(func))(comm, tag);
}

HcclResult StubHddsServiceCancel(ServiceHandle handle)
{
    auto func = AicpuSchedule::HcclSoManager::GetInstance()->GetFunc("HddsServiceCancel");
    if (func == nullptr) {
        return HCCL_E_RESERVED;
    }
    return (reinterpret_cast<AicpuSchedule::HddsServiceCancelFunc>(func))(handle);
}

int32_t SingleHcclWait(HcclRequest request)
{
    constexpr int32_t count = 1;
    HcclRequest requestArray[] = {request};
    int32_t compCount = 0;
    int32_t compIndices[] = {-1};
    HcclStatus status = {};
    HcclStatus compStatus[] = {status};

    const auto testRet = StubHcclWaitSome(count, requestArray, &compCount, compIndices, compStatus);
    if (testRet == HCCL_E_AGAIN) {
        return RET_SUCCESS;
    }

    if (testRet != HCCL_SUCCESS) {
        aicpusd_err("Fail to call HcclWaitSome, ret is %d", static_cast<int32_t>(testRet));
        return RET_FAILED;
    }

    if ((compCount != COUNT_ONE) || (compIndices[0U] != INDEX_ZERO) || (compStatus[0U].error != RET_SUCCESS)) {
        aicpusd_err("Something returned by HcclWaitSome is illegal, compCount[%d], compIndices[%d], status_error[%d]",
                    compCount, compIndices[0U], compStatus[0U].error);
        return RET_FAILED;
    }

    return RET_SUCCESS;
}

HcclResult StubHddsCollRecvUpdateRequest(void *keys, int32_t keyCount, HcclDataType keyType, void *values,
    int32_t valueCount, HcclDataType valueType, int32_t tag, ServiceHandle *handle, HcclComm comm,
    UpdateReqStatus *status)
{
    auto func = AicpuSchedule::HcclSoManager::GetInstance()->GetFunc("HddsCollRecvUpdateRequest");
    if (func == nullptr) {
        return HCCL_E_RESERVED;
    }
    return (reinterpret_cast<AicpuSchedule::HddsCollRecvUpdateRequestFunc>(func))(keys, keyCount, keyType, values,
        valueCount, valueType, tag, handle, comm, status);
}

HcclResult StubHddsIsendUpdateResponse(ServiceHandle handle, HcclComm comm, HcclRequest *request)
{
    auto func = AicpuSchedule::HcclSoManager::GetInstance()->GetFunc("HddsIsendUpdateResponse");
    if (func == nullptr) {
        return HCCL_E_RESERVED;
    }
    return (reinterpret_cast<AicpuSchedule::HddsIsendUpdateResponseFunc>(func))(handle, comm, request);
}

HcclResult StubHddsCollRecvLookupRequest(void *keys, int32_t count, HcclDataType type, int32_t tag,
    ServiceHandle *handle, HcclComm comm, LookupReqStatus *status)
{
    auto func = AicpuSchedule::HcclSoManager::GetInstance()->GetFunc("HddsCollRecvLookupRequest");
    if (func == nullptr) {
        return HCCL_E_RESERVED;
    }
    return (reinterpret_cast<AicpuSchedule::HddsCollRecvLookupRequestFunc>(func))(
        keys, count, type, tag, handle, comm, status);
}

HcclResult StubHddsIsendLookupResponse(void *values, int32_t count, HcclDataType type, ServiceHandle handle,
    HcclComm comm, HcclRequest *request)
{
    auto func = AicpuSchedule::HcclSoManager::GetInstance()->GetFunc("HddsIsendLookupResponse");
    if (func == nullptr) {
        return HCCL_E_RESERVED;
    }
    return (reinterpret_cast<AicpuSchedule::HddsIsendLookupResponseFunc>(func))(
        values, count, type, handle, comm, request);
}

HcclResult StubHcomPrepareStart(const HcomOpDesc *op, HcomRequest *request)
{
    auto func = AicpuSchedule::HcclSoManager::GetInstance()->GetFunc("HcomPrepareStart");
    if (func == nullptr) {
        return HCCL_E_RESERVED;
    }
    return (reinterpret_cast<AicpuSchedule::HcomPrepareStartFunc>(func))(op, request);
}

HcclResult StubHcomPrepareQuery(HcomRequest request, HcomStatus *status)
{
    auto func = AicpuSchedule::HcclSoManager::GetInstance()->GetFunc("HcomPrepareQuery");
    if (func == nullptr) {
        return HCCL_E_RESERVED;
    }
    return (reinterpret_cast<AicpuSchedule::HcomPrepareQueryFunc>(func))(request, status);
}

HcclResult StubHcomSendByOS(void *buf, uint64_t count, HcclDataType dataType, uint32_t peerRank, uint32_t tag,
    const char_t *group, uint64_t flag)
{
    auto func = AicpuSchedule::HcclSoManager::GetInstance()->GetFunc("HcomSendByOS");
    if (func == nullptr) {
        return HCCL_E_RESERVED;
    }
    return (reinterpret_cast<AicpuSchedule::HcomSendByOSFunc>(func))(buf, count, dataType, peerRank, tag, group, flag);
}

HcclResult StubHcomReceiveByOS(void *buf, uint64_t count, HcclDataType dataType, uint32_t peerRank, uint32_t tag,
    const char_t *group, uint64_t flag)
{
    auto func = AicpuSchedule::HcclSoManager::GetInstance()->GetFunc("HcomReceiveByOS");
    if (func == nullptr) {
        return HCCL_E_RESERVED;
    }
    return (reinterpret_cast<AicpuSchedule::HcomReceiveByOSFunc>(func))(
        buf, count, dataType, peerRank, tag, group, flag);
}

HcclResult StubHcomInitByRankTable(const char_t *rankTable, uint32_t rankId)
{
    auto func = AicpuSchedule::HcclSoManager::GetInstance()->GetFunc("HcomInitByRankTable");
    if (func == nullptr) {
        return HCCL_E_RESERVED;
    }
    return (reinterpret_cast<AicpuSchedule::HcomInitByRankTableFunc>(func))(rankTable, rankId);
}

HcclResult StubHcomDestroy()
{
    auto func = AicpuSchedule::HcclSoManager::GetInstance()->GetFunc("HcomDestroy");
    if (func == nullptr) {
        return HCCL_E_RESERVED;
    }
    return (reinterpret_cast<AicpuSchedule::HcomDestroyFunc>(func))();
}

HcclResult StubHcomCreateGroup(const char_t *group, uint32_t rankNum, uint32_t *rankIds)
{
    auto func = AicpuSchedule::HcclSoManager::GetInstance()->GetFunc("HcomCreateGroup");
    if (func == nullptr) {
        return HCCL_E_RESERVED;
    }
    return (reinterpret_cast<AicpuSchedule::HcomCreateGroupFunc>(func))(group, rankNum, rankIds);
}

HcclResult StubHcomDestroyGroup(const char_t *group)
{
    auto func = AicpuSchedule::HcclSoManager::GetInstance()->GetFunc("HcomDestroyGroup");
    if (func == nullptr) {
        return HCCL_E_RESERVED;
    }
    return (reinterpret_cast<AicpuSchedule::HcomDestroyGroupFunc>(func))(group);
}

HcclResult StubHcomBroadcastByOS(void* buf, uint64_t count, HcclDataType dataType, uint32_t root, const char *group,
                                 uint64_t flag)
{
    auto func = AicpuSchedule::HcclSoManager::GetInstance()->GetFunc("HcomBcastByOS");
    if (func == nullptr) {
        return HCCL_E_RESERVED;
    }
    return (reinterpret_cast<AicpuSchedule::HcomBroadcastByOSFunc>(func))(buf, count, dataType, root, group, flag);
}

HcclResult StubHcomGatherByOS(void* inputBuf, uint64_t inputCount, HcclDataType inputType, void* outputBuf,
                              uint64_t outputCount, HcclDataType outputType, uint32_t root, const char *group,
                              uint64_t flag)
{
    auto func = AicpuSchedule::HcclSoManager::GetInstance()->GetFunc("HcomGatherByOs");
    if (func == nullptr) {
        return HCCL_E_RESERVED;
    }
    return (reinterpret_cast<AicpuSchedule::HcomGatherByOSFunc>(func))(inputBuf, inputCount, inputType, outputBuf,
                                                                       outputCount, outputType, root, group, flag);
}

HcclResult StubHcclDestroyResouce(HcclComm comm, int32_t tag)
{
    auto func = AicpuSchedule::HcclSoManager::GetInstance()->GetFunc("HcclDestroyResouce");
    if (func == nullptr) {
        return HCCL_E_RESERVED;
    }
    return (reinterpret_cast<AicpuSchedule::HcclDestroyResouceFunc>(func))(comm, tag);
}

HcclResult StubHcclRegisterGlobalMemory(void *addr, uint64_t size)
{
    auto func = AicpuSchedule::HcclSoManager::GetInstance()->GetFunc("HcclRpcRegisterGlobalMemory");
    if (func == nullptr) {
        return HCCL_E_RESERVED;
    }
    return (reinterpret_cast<AicpuSchedule::HcclRegisterGlobalMemoryFunc>(func))(addr, size);
}

HcclResult StubHcclUnregisterGlobalMemory(void *addr)
{
    auto func = AicpuSchedule::HcclSoManager::GetInstance()->GetFunc("HcclRpcUnregisterGlobalMemory");
    if (func == nullptr) {
        return HCCL_E_RESERVED;
    }
    return (reinterpret_cast<AicpuSchedule::HcclUnregisterGlobalMemoryFunc>(func))(addr);
}

HcclResult StubHcclPsAssociateWorkers(HcclComm comm, int32_t tag, uint32_t workerRanks[], uint64_t workerNum)
{
    auto func = AicpuSchedule::HcclSoManager::GetInstance()->GetFunc("HcclPsAssociateWorkers");
    if (func == nullptr) {
        return HCCL_E_RESERVED;
    }
    return (reinterpret_cast<AicpuSchedule::HcclPsAssociateWorkersFunc>(func))(comm, tag, workerRanks, workerNum);
}

HcclResult StubHcclCpuCommInit(const char_t *rankTable, uint32_t rank, HcclCommConfig* config)
{
    auto func = AicpuSchedule::HcclSoManager::GetInstance()->GetFunc("HcclCpuCommInitClusterInfoMemConfig");
    if (func == nullptr) {
        return HCCL_E_RESERVED;
    }
    return (reinterpret_cast<AicpuSchedule::HcclCpuCommInitClusterInfoMemConfigFunc>(func))(rankTable, rank, config);
}
} // namespace AicpuSchedule
