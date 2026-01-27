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
#include <map>
#include "gtest/gtest.h"
#include "mockcpp/mockcpp.hpp"

#define private public
#include "aicpusd_hccl_api.h"
#undef private

using namespace AicpuSchedule;

namespace {
    HcclResult HcclInitCsComm(const char_t *rankTableM, int32_t rankId, const char_t *roleTable,
                              const CalcParams *calcParams, HcclComm *comm)
    {
        return HCCL_SUCCESS;
    }

    HcclResult HcclFinalizeComm(HcclComm comm)
    {
        return HCCL_SUCCESS;
    }

    HcclResult HcclGetLookupRequest(void* keys, int32_t count, HcclDataType type, int32_t tag,
                                    ServiceHandle *handle, HcclComm comm, ReqStatus *status)
    {
        std::cout << "StubHcclGetLookupRequest" << std::endl;
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

    HcclResult HcclDestroyResouce(HcclComm comm, int32_t tag)
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

    HcclResult HcclCpuCommInitClusterInfoMemConfig(const char_t *rankTable, uint32_t rank, HcclCommConfig *config)
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

class AicpuSdHcclApiUt : public ::testing::Test {
public:
    virtual void SetUp()
    {}

    virtual void TearDown()
    {
        GlobalMockObject::verify();
    }
};

TEST_F(AicpuSdHcclApiUt, HcclSoManagerGetFuncFail)
{
    auto hcclSoManager = HcclSoManager::GetInstance();
    hcclSoManager->LoadSo();
    EXPECT_EQ(hcclSoManager->GetFunc("HcclWaitSome"), nullptr);
    hcclSoManager->UnloadSo();
}

TEST_F(AicpuSdHcclApiUt, SingleHcclWait)
{
    MOCKER(StubHcclWaitSome).stubs().will(returnValue(HCCL_SUCCESS));
    HcclRequest request;
    EXPECT_EQ(SingleHcclWait(request), -1);
}

TEST_F(AicpuSdHcclApiUt, SingleHcclWait_HCCL_E_AGAIN)
{
    MOCKER(StubHcclWaitSome).stubs().will(returnValue(HCCL_E_AGAIN));
    HcclRequest request;
    EXPECT_EQ(SingleHcclWait(request), 0);
}

TEST_F(AicpuSdHcclApiUt, HcclApiSuccess)
{
    MOCKER(dlopen).stubs().will(returnValue((void*)1));
    MOCKER(dlsym).stubs().will(invoke(dlsymFake));
    MOCKER(dlclose).stubs().will(returnValue(0));

    auto hcclSoManager = HcclSoManager::GetInstance();
    hcclSoManager->LoadSo();

    EXPECT_EQ(HCCL_SUCCESS, StubHcclInitCsComm(nullptr, 0, nullptr, nullptr, nullptr));

    HcclComm comm;
    EXPECT_EQ(HCCL_SUCCESS, StubHcclFinalizeComm(comm));

    EXPECT_EQ(HCCL_SUCCESS, StubHcclGetLookupRequest(nullptr, 0, HCCL_DATA_TYPE_INT8, 0, nullptr, comm, nullptr));

    EXPECT_EQ(HCCL_SUCCESS, StubHcclIsetLookupResponse(nullptr, 0, HCCL_DATA_TYPE_INT8, nullptr, comm, nullptr));

    EXPECT_EQ(HCCL_SUCCESS, StubHcclWaitSome(0, nullptr, nullptr, nullptr, nullptr));

    EXPECT_EQ(HCCL_SUCCESS, StubHcclAbortSelf(comm, 0));

    EXPECT_EQ(HCCL_SUCCESS, StubHddsServiceCancel(nullptr));

    EXPECT_EQ(HCCL_SUCCESS, StubHddsCollRecvUpdateRequest(nullptr, 0, HCCL_DATA_TYPE_INT8, nullptr, 0,
        HCCL_DATA_TYPE_INT8, 0, nullptr, comm, nullptr));

    EXPECT_EQ(HCCL_SUCCESS, StubHddsIsendUpdateResponse(nullptr, comm, nullptr));

    EXPECT_EQ(HCCL_SUCCESS, StubHddsCollRecvLookupRequest(nullptr, 0, HCCL_DATA_TYPE_INT8, 0, nullptr, comm, nullptr));

    EXPECT_EQ(HCCL_SUCCESS, StubHddsIsendLookupResponse(nullptr, 0, HCCL_DATA_TYPE_INT8, nullptr, comm, nullptr));

    EXPECT_EQ(HCCL_SUCCESS, StubHcomPrepareStart(nullptr, nullptr));

    EXPECT_EQ(HCCL_SUCCESS, StubHcomPrepareQuery(nullptr, nullptr));

    EXPECT_EQ(HCCL_SUCCESS, StubHcomSendByOS(nullptr, 0U, HCCL_DATA_TYPE_INT8, 0U, 0U, nullptr, 0U));

    EXPECT_EQ(HCCL_SUCCESS, StubHcomReceiveByOS(nullptr, 0U, HCCL_DATA_TYPE_INT8, 0U, 0U, nullptr, 0U));

    EXPECT_EQ(HCCL_SUCCESS, StubHcomInitByRankTable(nullptr, 0U));

    EXPECT_EQ(HCCL_SUCCESS, StubHcomDestroy());

    EXPECT_EQ(HCCL_SUCCESS, StubHcomCreateGroup(nullptr, 0U, nullptr));

    EXPECT_EQ(HCCL_SUCCESS, StubHcomDestroyGroup(nullptr));

    EXPECT_EQ(HCCL_SUCCESS, StubHcomBroadcastByOS(nullptr, 0UL, 0, 0, nullptr, 0UL));

    EXPECT_EQ(HCCL_SUCCESS, StubHcomGatherByOS(nullptr, 0UL, 0, nullptr, 0UL, 0, 0, nullptr, 0UL));

    EXPECT_EQ(HCCL_SUCCESS, StubHcclDestroyResouce(comm, 0));

    EXPECT_EQ(HCCL_SUCCESS, StubHcclRegisterGlobalMemory(nullptr, 0U));

    EXPECT_EQ(HCCL_SUCCESS, StubHcclUnregisterGlobalMemory(nullptr));

    uint32_t workerRanks[1] = {0U};
    EXPECT_EQ(HCCL_SUCCESS, StubHcclPsAssociateWorkers(comm, 0, workerRanks, 1U));

    EXPECT_EQ(HCCL_SUCCESS, StubHcclCpuCommInit(nullptr, 0U, nullptr));

    hcclSoManager->UnloadSo();
}

TEST_F(AicpuSdHcclApiUt, LoadHccdSoFail)
{
    auto hcclSoManager = HcclSoManager::GetInstance();
    int tmp = 9;
    hcclSoManager->hccdSoHandle_ = &tmp;
    MOCKER(dlsym).stubs().will(returnValue((void *)nullptr));
    MOCKER(dlclose).stubs().will(returnValue(0));
    hcclSoManager->LoadHccdSo();
    hcclSoManager->UnLoadHccdSo();
    EXPECT_EQ(hcclSoManager->hcclSoHandle_, nullptr);
}

TEST_F(AicpuSdHcclApiUt, LoadHcclSoFail)
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

TEST_F(AicpuSdHcclApiUt, MBufferPoolInitAndUninit)
{
    MBufferPool bufferPool;
    uint32_t blockNum = 2;
    uint32_t blockSize = 13;
    mempool_t *mp = 1;
    MOCKER(halBuffCreatePool)
        .stubs()
        .with(mockcpp::any(), outBoundP(&mp))
        .will(returnValue(RET_SUCCESS));
    MOCKER(StubHcclRegisterGlobalMemory).stubs().will(returnValue(HCCL_SUCCESS));
    EXPECT_EQ(bufferPool.Init(blockNum, blockSize, true), RET_SUCCESS);
    EXPECT_TRUE(bufferPool.isRegister_);

    MOCKER(StubHcclUnregisterGlobalMemory).stubs().will(returnValue(HCCL_SUCCESS));
    MOCKER(halBuffDeletePool).stubs().will(returnValue(RET_SUCCESS));
    bufferPool.UnInit();
    EXPECT_FALSE(bufferPool.isRegister_);
    EXPECT_EQ(bufferPool.mp_, nullptr);
}

TEST_F(AicpuSdHcclApiUt, MBufferPoolAllocateFailed)
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

TEST_F(AicpuSdHcclApiUt, MBufferPoolAllocateSuccess)
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

TEST_F(AicpuSdHcclApiUt, MBufferPoolFreeFail)
{
    MBufferPool bufferPool;
    MOCKER(halMbufFree).stubs().will(returnValue(-1));
    int32_t ret = bufferPool.Free(nullptr);
    EXPECT_EQ(ret, -1);
}

TEST_F(AicpuSdHcclApiUt, MBufferPoolFreeAllFail)
{
    MBufferPool bufferPool;
    Mbuf *tmp;
    bufferPool.mbufsAllocated_.emplace(tmp);
    MOCKER(halMbufFree).stubs().will(returnValue(-1));
    int32_t ret = bufferPool.FreeAll();
    EXPECT_EQ(ret, -1);
}

TEST_F(AicpuSdHcclApiUt, HcclApiFail)
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

    EXPECT_EQ(HCCL_E_RESERVED, StubHcclRegisterGlobalMemory(nullptr, 0U));

    EXPECT_EQ(HCCL_E_RESERVED, StubHcclUnregisterGlobalMemory(nullptr));

    uint32_t workerRanks[1] = {0U};
    EXPECT_EQ(HCCL_E_RESERVED, StubHcclPsAssociateWorkers(comm, 0, workerRanks, 1U));

    EXPECT_EQ(HCCL_E_RESERVED, StubHcclCpuCommInit(nullptr, 0U, nullptr));

    hcclSoManager->UnloadSo();
}

TEST_F(AicpuSdHcclApiUt, SingleHcclWaitFail)
{
    MOCKER(StubHcclWaitSome).stubs().will(returnValue(HCCL_E_NOT_SUPPORT));
    HcclRequest request;
    EXPECT_EQ(SingleHcclWait(request), RET_FAILED);
}