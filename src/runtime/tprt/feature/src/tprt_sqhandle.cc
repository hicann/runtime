/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include <map>
#include "tprt_sqhandle.hpp"
#include "tprt.hpp"
#include "tprt_type.h"
namespace cce{
namespace tprt{
using PfnTprtExeSqe = uint32_t (*)(const TprtSqe_t *sqe);
using PfnAicpuSqeFunc = uint32_t (*)(const uint64_t);

TprtSqHandle::TprtSqHandle(const uint32_t devId, const uint32_t sqId) : devId_(devId), sqId_(sqId)
{
    sqState_ = TPRT_SQ_STATE_IS_RUNNING;
}

TprtSqHandle::~TprtSqHandle()
{
    TPRT_LOG(TPRT_LOG_INFO, "device_id:%u, sq_id=%u destructor", devId_, sqId_);
    devId_ = 0xFFFFFFFFU;
    sqId_ = 0xFFFFFFFFU;
    sqState_ = TPRT_SQ_STATE_IS_QUITTED;
    isExistCqe_ = false;
    sqHead_.store(0U);
    sqTail_.store(0U);
}

void TprtSqHandle::TprtSetSqState(const TprtSqState_t status)
{
    sqState_ = status;
}

static uint32_t TprtExeAicpuTask(const TprtSqe_t *sqe)
{
    uint64_t pcStart = sqe->aicpuSqe.startPcAddr;
    uint64_t argsAddr = sqe->aicpuSqe.argsAddr;
    if ((pcStart == 0UL) || (argsAddr == 0UL)) {
        return TPRT_SQE_PARA_IS_INVALID;
    }
    PfnAicpuSqeFunc aicpuFunc = TprtValueToPtr<PfnAicpuSqeFunc>(pcStart);
    return aicpuFunc(argsAddr);
}

const std::map<TprtSqeType, PfnTprtExeSqe> tprtSqeExeFuncMap = {
    {TPRT_SQE_TYPE_AICPU, TprtExeAicpuTask},
};

void TprtSqHandle::SqUpdateHead(const uint8_t sqeNum)
{
    const uint32_t depth = TprtManage::Instance()->TprtGetSqMaxDepth();
    uint16_t sqHead = sqHead_.load();
    sqHead_.store((sqHead + sqeNum + 1U) % depth);
}

uint32_t TprtSqHandle::SqPushTask(const uint8_t *sqeAddr, const uint32_t sqeNum)
{
    const uint32_t depth = TprtManage::Instance()->TprtGetSqMaxDepth();
    const std::lock_guard<std::mutex> lock(sqQueueLock_);
    uint16_t sqHead = sqHead_.load();
    uint16_t sqTail = sqTail_.load();
    bool queueFull = TprtManage::Instance()->IsQueueFull(sqHead, sqTail, sqeNum);
    if (queueFull) {
        TPRT_LOG(TPRT_LOG_ERROR, "[tprt]device_id[%u] sq_id[%u] queue is full, before:sqHead[%u], sqTail[%u], after:sqHead[%u]"
                 ", sqTail[%u].", devId_, sqId_, sqHead, sqTail, sqHead_.load(), sqTail_.load());
        return TPRT_SQ_QUEUE_FULL;
    }
    uint32_t copySqeNum = 0U;
    while (copySqeNum != sqeNum) {
        sqQueue_[sqTail] = (TprtPtrToPtr<const TprtSqe_t *>(sqeAddr))[copySqeNum];
        PrintTprtSqe(&sqQueue_[sqTail]);
        ++copySqeNum;
        sqTail = (sqTail + 1U) % depth;
    }
    sqTail_.store(sqTail);
    TPRT_LOG(TPRT_LOG_INFO,"[tprt]device_id[%u] sq_id[%u] copy sqe to queue, sqeNum=%u, sqtail=%u.",
             devId_, sqId_, sqeNum, sqTail_.load());
    return TPRT_SUCCESS;
}

uint32_t TprtSqHandle::SqPeekTask(TprtSqe_t *sqe)
{
    if (sqState_.load() != TPRT_SQ_STATE_IS_RUNNING) {
        return TPRT_SQ_STATE_ABNORMAL;
    }
    if (sqHead_.load() == sqTail_.load()) {
        return TPRT_SQ_EMPTY;
    }
    const std::lock_guard<std::mutex> lock(sqQueueLock_);
    *sqe = sqQueue_[sqHead_];
    return TPRT_SUCCESS;
}

uint32_t TprtSqHandle::SqExeTask(const TprtSqe_t *sqe)
{
    uint8_t sqeType = sqe->commonSqe.sqeHeader.type;
    if (sqeType >= TPRT_SQE_TYPE_INVALID) {
        return TPRT_SQE_TYPE_IS_INVALID;
    }
    uint32_t result = TPRT_SUCCESS;
    const auto it = tprtSqeExeFuncMap.find(TprtSqeType(sqeType));
    if (it != tprtSqeExeFuncMap.end()) {
        auto func = it->second;
        result = func(sqe);
        if (result != TPRT_SUCCESS) {
            TPRT_LOG(TPRT_LOG_ERROR, "[tprt]device_id=%u, sq_id=%u, sqHead=%u, sqTail=%u, errorCode=%u sqe exe fail.",
                     devId_, sqId_, sqHead_.load(), sqTail_.load(), result);
        }
    } else {
        TPRT_LOG(TPRT_LOG_ERROR, "Failed to find function to process task.");
        result = TPRT_SQE_TYPE_IS_INVALID;
    }
    return result;
}
}
}
