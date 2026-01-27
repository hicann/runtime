/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include <bitset>
#include "gtest/gtest.h"
#include "mockcpp/mockcpp.hpp"
#include "securec.h"
#include "runtime/rt.h"
#include "raw_device.hpp"
#define private public
#include "runtime.hpp"
#undef private
#include "thread_local_container.hpp"

using namespace testing;
using namespace cce::runtime;

class ChipFftsAutoThreadTest : public testing::Test {
protected:
    static void SetUpTestCase()
    {
        
    }

    static void TearDownTestCase()
    {

    }

    virtual void SetUp()
    {
        GlobalMockObject::verify();
    }

    virtual void TearDown()
    {
        rtDeviceReset(0);
        GlobalMockObject::verify();
    }

    rtError_t AddAutoThreadSubTask(rtFftsTaskInfo_t &fftsTask, rtFftsSubTaskType_t subTaskType,
                                   uint32_t srcCacheNum, uint32_t dstCacheNum)
    {
        rtError_t error = ACL_RT_SUCCESS;

        if (srcCacheNum > RT_FFTS_MAX_TICKET_CACHE_PER_SUBTASK) {
            std::cout << "srcCacheNum is over max sub task cache num. srcCacheNum=" << srcCacheNum << std::endl;
            return ACL_ERROR_RT_PARAM_INVALID;
        }
        if (dstCacheNum > RT_FFTS_MAX_TICKET_CACHE_PER_SUBTASK) {
            std::cout << "dstCacheNum is over max sub task cache num. dstCacheNum=" << dstCacheNum << std::endl;
            return ACL_ERROR_RT_PARAM_INVALID;
        }

        switch (subTaskType) {
            case RT_FFTS_SUB_TASK_TYPE_AIC:
            case RT_FFTS_SUB_TASK_TYPE_AIV:
                error = AddAutoThreadAicSubTask(fftsTask, srcCacheNum, dstCacheNum);
                break;
            case RT_FFTS_SUB_TASK_TYPE_NOP:
                error = AddAutoThreadNopTask(fftsTask, srcCacheNum, dstCacheNum);
                break;
            default:
                error = ACL_ERROR_RT_FEATURE_NOT_SUPPORT;
                std::cout << "subTaskType is invalid. subTaskType=" << subTaskType << std::endl;
                break;
        }
        return error;
    }

private:

    rtError_t AddAutoThreadCache(rtFftsTaskInfo_t &fftsTask, uint8_t &cacheId, bool isSrc)
    {
        uint32_t cacheIdx = fftsTask.tickCacheNum;

        if (cacheIdx >= RT_FFTS_MAX_TICKET_CACHE_NUM) {
            std::cout << "cacheIdx is over max ticket cache num. cacheIdx=" << cacheIdx << std::endl;
            return ACL_ERROR_RT_PARAM_INVALID;
        }
        rtTicketCache_t &cache = fftsTask.ticketCache[cacheIdx];
        rtAutoThreadCacheInfo_t &autoCache = cache.custom.autoThreadCache;
        if (isSrc) {
            cache.cacheOption = RT_CACHE_OP_INVALIDATE;
        } else {
            cache.cacheOption = RT_CACHE_OP_FLUSH;
        }
        cache.ticketCacheWindow = 10;
        autoCache.dataAddr = 0x100;
        autoCache.dataAddrOffset = 0;
        autoCache.nonTailDataLen = 100;
        autoCache.tailDataLen = 10;
        autoCache.ticketCacheRefCnt = 1;
        cacheId = fftsTask.tickCacheNum++;
        return ACL_RT_SUCCESS;
    }

    rtError_t InitAutoThreadSrcSlot(rtFftsTaskInfo_t &fftsTask, rtFftsSubTaskInfo_t &subTask, uint32_t srcCacheNum)
    {
        rtError_t error = ACL_RT_SUCCESS;
        for (uint8_t srcIdx = 0; srcIdx < srcCacheNum; ++srcIdx) {
            uint8_t bitMask = (1 << srcIdx);
            subTask.srcTickCacheVldBitmap |= bitMask;
            // mark over 0 is out of sub graph
            if (srcIdx > 0) {
                subTask.srcDataOutOfSubGraphBitmap |= bitMask;
            }
            error = AddAutoThreadCache(fftsTask, subTask.srcTickCacheID[srcIdx], true);
            EXPECT_EQ(error, ACL_RT_SUCCESS);
        }
        return error;
    }

    rtError_t InitAutoThreadDstSlot(rtFftsTaskInfo_t &fftsTask, rtFftsSubTaskInfo_t &subTask, uint32_t dstCacheNum)
    {
        rtError_t error = ACL_RT_SUCCESS;
        for (uint8_t dstIdx = 0; dstIdx < dstCacheNum; ++dstIdx) {
            uint8_t bitMask = (1 << dstIdx);
            subTask.dstTickCacheVldBitmap |= bitMask;
            error = AddAutoThreadCache(fftsTask, subTask.dstTickCacheID[dstIdx], false);
            EXPECT_EQ(error, ACL_RT_SUCCESS);
        }
        return error;
    }

    rtError_t AddAutoThreadAicSubTask(rtFftsTaskInfo_t &fftsTask, uint32_t srcCacheNum, uint32_t dstCacheNum)
    {
        rtError_t error = ACL_RT_SUCCESS;
        uint32_t taskIdx = fftsTask.subTaskNum;
        if (taskIdx >= RT_FFTS_MAX_SUB_TASK_NUM) {
            std::cout << "taskIdx is over max sub task num. taskIdx=" << taskIdx << std::endl;
            return ACL_ERROR_RT_PARAM_INVALID;
        }

        rtFftsSubTaskInfo_t &subTask = fftsTask.subTask[taskIdx];
        rtAutoThreadAicAivInfo_t &autoThreadAicAiv = subTask.custom.autoThreadAicAiv;
        subTask.subTaskType = RT_FFTS_SUB_TASK_TYPE_AIC;
        subTask.threadDim = 10;
        error = InitAutoThreadSrcSlot(fftsTask, subTask, srcCacheNum);
        EXPECT_EQ(error, ACL_RT_SUCCESS);
        error = InitAutoThreadDstSlot(fftsTask, subTask, dstCacheNum);
        EXPECT_EQ(error, ACL_RT_SUCCESS);

        autoThreadAicAiv.prefetchEnableBitmap = subTask.srcDataOutOfSubGraphBitmap;
        autoThreadAicAiv.prefetchOnceBitmap = subTask.srcDataOutOfSubGraphBitmap;

        autoThreadAicAiv.taskParamAddr = 0x1;
        autoThreadAicAiv.taskParamOffset = 100;
        autoThreadAicAiv.satMode = 1;
        autoThreadAicAiv.scheduleMode = 0;
        autoThreadAicAiv.iCachePrefetchCnt = 1;
        autoThreadAicAiv.tailBlkDim = 10;
        autoThreadAicAiv.nonTailBlkDim = 1;
        autoThreadAicAiv.tailTaskFuncStub = "tailTaskFuncStub";
        autoThreadAicAiv.nonTailTaskFuncStub = "nonTailTaskFuncStub";

        std::bitset<8> bitmap(subTask.custom.autoThreadAicAiv.prefetchEnableBitmap);
        auto count = bitmap.count();
        for (auto i = 0; i < count; ++i) {
            autoThreadAicAiv.srcPrefetch[i].dataAddr = 0x100;
            autoThreadAicAiv.srcPrefetch[i].dataAddrOffset = 100;
            autoThreadAicAiv.srcPrefetch[i].nonTailDataLen = 10;
            autoThreadAicAiv.srcPrefetch[i].tailDataLen = 20;
        }
        ++fftsTask.subTaskNum;
        return ACL_RT_SUCCESS;
    }

    rtError_t AddAutoThreadNopTask(rtFftsTaskInfo_t &fftsTask, uint32_t srcCacheNum, uint32_t dstCacheNum)
    {
        rtError_t error = ACL_RT_SUCCESS;
        uint32_t taskIdx = fftsTask.subTaskNum;
        if (taskIdx >= RT_FFTS_MAX_SUB_TASK_NUM) {
            std::cout << "taskIdx is over max sub task num. taskIdx=" << taskIdx << std::endl;
            return ACL_ERROR_RT_PARAM_INVALID;
        }

        rtFftsSubTaskInfo_t &subTask = fftsTask.subTask[taskIdx];
        subTask.subTaskType = RT_FFTS_SUB_TASK_TYPE_NOP;
        subTask.threadDim = 10;
        InitAutoThreadSrcSlot(fftsTask, subTask, srcCacheNum);
        InitAutoThreadDstSlot(fftsTask, subTask, dstCacheNum);
        ++fftsTask.subTaskNum;
        return ACL_RT_SUCCESS;
    }

public:
    static rtStream_t stream_;
};

rtStream_t ChipFftsAutoThreadTest::stream_ = nullptr;

class ChipFftsManualThreadTest : public testing::Test {
protected:
    static void SetUpTestCase()
    {
    }

    static void TearDownTestCase()
    {
        rtDeviceReset(0);
    }

    virtual void SetUp()
    {
        dmuList_.reserve(1024);
    }

    virtual void TearDown()
    {
        GlobalMockObject::verify();
        dmuList_.clear();
    }

    rtError_t AddManualThreadSubTask(rtFftsTaskInfo_t &fftsTask, rtFftsSubTaskType_t subTaskType,
                                     uint32_t srcCacheNum, uint32_t dstCacheNum)
    {
        rtError_t error = ACL_RT_SUCCESS;

        if (srcCacheNum > RT_FFTS_MAX_TICKET_CACHE_PER_SUBTASK) {
            std::cout << "srcCacheNum is over max sub task cache num. srcCacheNum=" << srcCacheNum << std::endl;
            return ACL_ERROR_RT_PARAM_INVALID;
        }
        if (dstCacheNum > RT_FFTS_MAX_TICKET_CACHE_PER_SUBTASK) {
            std::cout << "dstCacheNum is over max sub task cache num. dstCacheNum=" << dstCacheNum << std::endl;
            return ACL_ERROR_RT_PARAM_INVALID;
        }

        switch (subTaskType) {
            case RT_FFTS_SUB_TASK_TYPE_AIC:
            case RT_FFTS_SUB_TASK_TYPE_AIV:
                error = AddManualThreadAicSubTask(fftsTask, srcCacheNum, dstCacheNum);
                break;
            case RT_FFTS_SUB_TASK_TYPE_NOP:
                error = AddManualThreadNopTask(fftsTask, srcCacheNum, dstCacheNum);
                break;
            default:
                error = ACL_ERROR_RT_FEATURE_NOT_SUPPORT;
                std::cout << "subTaskType is invalid. subTaskType=" << subTaskType << std::endl;
                break;
        }
        return error;
    }

private:

    rtError_t AddManualThreadCache(rtFftsTaskInfo_t &fftsTask, uint8_t &cacheId, bool isSrc)
    {
        uint32_t cacheIdx = fftsTask.tickCacheNum;

        if (cacheIdx >= RT_FFTS_MAX_TICKET_CACHE_NUM) {
            std::cout << "cacheIdx is over max ticket cache num. cacheIdx=" << cacheIdx << std::endl;
            return ACL_ERROR_RT_PARAM_INVALID;
        }
        rtTicketCache_t &cache = fftsTask.ticketCache[cacheIdx];
        rtManualThreadCacheInfo_t &manualCache = cache.custom.manualThreadCache;
        if (isSrc) {
            cache.cacheOption = RT_CACHE_OP_INVALIDATE;
        } else {
            cache.cacheOption = RT_CACHE_OP_FLUSH;
        }
        cache.ticketCacheWindow = 10;

        size_t dmuStartPos = dmuList_.size();
        manualCache.dmuNum = threadNum_;
        for (int i = 0 ; i < threadNum_; ++i) {
            rtManualThreadDmuInfo_t dmuInfo{0};
            dmuInfo.dataAddr = 0x10 + i;
            dmuList_.emplace_back(dmuInfo);
            manualCache.sliceDmuIdx[i] = i + 1;
            manualCache.ticketCacheRefCntTbl[i] = 1;
        }

        manualCache.dmuList = &dmuList_[dmuStartPos];

        cacheId = fftsTask.tickCacheNum++;
        return ACL_RT_SUCCESS;
    }

    rtError_t InitManualThreadSrcSlot(rtFftsTaskInfo_t &fftsTask, rtFftsSubTaskInfo_t &subTask, uint32_t srcCacheNum)
    {
        rtError_t error = ACL_RT_SUCCESS;
        for (uint8_t srcIdx = 0; srcIdx < srcCacheNum; ++srcIdx) {
            uint8_t bitMask = (1 << srcIdx);
            subTask.srcTickCacheVldBitmap |= bitMask;
            // mark over 0 is out of sub graph
            if (srcIdx > 0) {
                subTask.srcDataOutOfSubGraphBitmap |= bitMask;
            }
            error = AddManualThreadCache(fftsTask, subTask.srcTickCacheID[srcIdx], true);
            EXPECT_EQ(error, ACL_RT_SUCCESS);
        }
        return error;
    }

    rtError_t InitManualThreadDstSlot(rtFftsTaskInfo_t &fftsTask, rtFftsSubTaskInfo_t &subTask, uint32_t dstCacheNum)
    {
        rtError_t error = ACL_RT_SUCCESS;
        for (uint8_t dstIdx = 0; dstIdx < dstCacheNum; ++dstIdx) {
            uint8_t bitMask = (1 << dstIdx);
            subTask.dstTickCacheVldBitmap |= bitMask;
            error = AddManualThreadCache(fftsTask, subTask.dstTickCacheID[dstIdx], false);
            EXPECT_EQ(error, ACL_RT_SUCCESS);
        }
        return error;
    }

    rtError_t AddManualThreadAicSubTask(rtFftsTaskInfo_t &fftsTask, uint32_t srcCacheNum, uint32_t dstCacheNum)
    {
        uint32_t taskIdx = fftsTask.subTaskNum;
        if (taskIdx >= RT_FFTS_MAX_SUB_TASK_NUM) {
            std::cout << "taskIdx is over max sub task num. taskIdx=" << taskIdx << std::endl;
            return ACL_ERROR_RT_PARAM_INVALID;
        }

        rtFftsSubTaskInfo_t &subTask = fftsTask.subTask[taskIdx];
        rtManualThreadAicAivInfo_t &manualThreadAicAiv = subTask.custom.manualThreadAicAiv;
        subTask.subTaskType = RT_FFTS_SUB_TASK_TYPE_AIC;
        subTask.threadDim = threadNum_;
        rtError_t error = InitManualThreadSrcSlot(fftsTask, subTask, srcCacheNum);
        EXPECT_EQ(error, ACL_RT_SUCCESS);
        error = InitManualThreadDstSlot(fftsTask, subTask, dstCacheNum);
        EXPECT_EQ(error, ACL_RT_SUCCESS);

        manualThreadAicAiv.prefetchEnableBitmap = subTask.srcDataOutOfSubGraphBitmap;
        manualThreadAicAiv.prefetchOnceBitmap = subTask.srcDataOutOfSubGraphBitmap;

        manualThreadAicAiv.taskParamAddr = 0x1;
        manualThreadAicAiv.taskParamOffset = 100;
        manualThreadAicAiv.satMode = 1;
        manualThreadAicAiv.scheduleMode = 0;
        manualThreadAicAiv.iCachePrefetchCnt = 1;

        size_t dmuStartPos = dmuList_.size();
        manualThreadAicAiv.prefetchOnceDmuNum = 1;
        rtManualThreadDmuInfo_t onceDmuInfo{0};
        onceDmuInfo.dataAddr = 0x11;
        dmuList_.emplace_back(onceDmuInfo);

        for (int i = 0 ; i < threadNum_; ++i) {
            rtManualThreadDmuInfo_t dmuInfo{0};
            dmuInfo.dataAddr = 0x12 + i;
            dmuList_.emplace_back(dmuInfo);
            if (i == 0) {
                manualThreadAicAiv.threadPrefetchDmuIdx[i] = manualThreadAicAiv.prefetchOnceDmuNum + 1;
            } else {
                manualThreadAicAiv.threadPrefetchDmuIdx[i] = manualThreadAicAiv.threadPrefetchDmuIdx[i - 1] + 1;
            }
            manualThreadAicAiv.threadBlkDim[i] = 2;
            manualThreadAicAiv.threadTaskFuncStub[i] = "FuncStub" + i;
        }
        manualThreadAicAiv.prefetchList = &dmuList_[dmuStartPos];

        ++fftsTask.subTaskNum;
        return ACL_RT_SUCCESS;
    }

    rtError_t AddManualThreadNopTask(rtFftsTaskInfo_t &fftsTask, uint32_t srcCacheNum, uint32_t dstCacheNum)
    {
        uint32_t taskIdx = fftsTask.subTaskNum;
        if (taskIdx >= RT_FFTS_MAX_SUB_TASK_NUM) {
            std::cout << "taskIdx is over max sub task num. taskIdx=" << taskIdx << std::endl;
            return ACL_ERROR_RT_PARAM_INVALID;
        }

        rtFftsSubTaskInfo_t &subTask = fftsTask.subTask[taskIdx];
        subTask.subTaskType = RT_FFTS_SUB_TASK_TYPE_NOP;
        subTask.threadDim = threadNum_;
        InitManualThreadSrcSlot(fftsTask, subTask, srcCacheNum);
        InitManualThreadDstSlot(fftsTask, subTask, dstCacheNum);
        ++fftsTask.subTaskNum;
        return ACL_RT_SUCCESS;
    }

public:
    static rtStream_t stream_;
    static rtChipType_t originChipType_;
    std::vector<rtManualThreadDmuInfo_t> dmuList_;
    uint16_t threadNum_ = 1;
};

rtStream_t ChipFftsManualThreadTest::stream_ = nullptr;
rtChipType_t ChipFftsManualThreadTest::originChipType_ = CHIP_910_B_93;