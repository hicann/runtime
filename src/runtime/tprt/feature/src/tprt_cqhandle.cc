/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "tprt_cqhandle.hpp"
#include "tprt.hpp"
#include "tprt_base.hpp"

namespace cce{
namespace tprt{

TprtCqHandle::TprtCqHandle(const uint32_t devId, const uint32_t cqId) : devId_(devId), cqId_(cqId)
{
}

TprtCqHandle::~TprtCqHandle()
{
    TPRT_LOG(TPRT_LOG_INFO, "device_id:%u, cq_id=%u destructor", devId_, cqId_);
    devId_ = 0xFFFFFFFFU;
    cqId_ = 0xFFFFFFFFU;
    cqHead_.store(0U);
    cqTail_.store(0U);
}

uint32_t TprtCqHandle::TprtCqWriteCqe(const uint8_t errorType, const uint32_t errorCode, const TprtSqe_t *sqe,
                                      const TprtSqHandle *sqHandle)
{
    TprtCqeReport_t cqe = {};
    const uint32_t queueDepth = TprtManage::Instance()->TprtGetSqMaxDepth();
    if (sqHandle == nullptr) {
        TPRT_LOG(TPRT_LOG_ERROR, "device_id:%u cq_id=%u sqhandle is null.", devId_, cqId_);
        return TPRT_SQ_HANDLE_INVALID;
    }
    uint16_t cqHead = cqHead_.load();
    uint16_t cqTail = cqTail_.load();
    bool queueFull = TprtManage::Instance()->IsQueueFull(cqHead, cqTail, 1U);
    if (queueFull) {
        TPRT_LOG(TPRT_LOG_ERROR, "[tprt]device_id[%u] cq_id[%u] queue is full, before:cqHead[%u], cqTail[%u], after:cqHead[%u]"
                 ", cqTail[%u].", devId_, cqId_, cqHead, cqTail, cqHead_.load(), cqTail_.load());
        return TPRT_SQ_QUEUE_FULL;
    }
    cqe.taskSn = sqe->commonSqe.sqeHeader.taskSn;
    cqe.errorCode = errorCode;    // cqe acc_status/sq_sw_status
    cqe.errorType = errorType;
    cqe.sqeType = sqe->commonSqe.sqeHeader.type;
    cqe.sqId = sqHandle->SqGetSqId();
    cqe.sqHead = sqHandle->SqGetSqHead();
    const std::lock_guard<std::mutex> lock(cqQueueLock_);
    cqQueue_[cqTail] = cqe;
    cqTail_ = (cqTail + 1U) % queueDepth;
    return TPRT_SUCCESS;
}

void TprtCqHandle::TprtCqHandleGetCqe(TprtReportCqeInfo_t *cqeInfo)
{
    uint16_t cqTail = cqTail_.load();
    uint16_t cqHead = cqHead_.load();
    if (cqTail == cqHead) {
        cqeInfo->reportCqeNum = 0U;
        return;
    }
    const uint32_t queueDepth = TprtManage::Instance()->TprtGetSqMaxDepth();
    uint32_t reportCqeNum = 0U;
    const std::lock_guard<std::mutex> lock(cqQueueLock_);
    while ((cqHead != cqTail) && (reportCqeNum < cqeInfo->cqeNum)) {
        (TprtPtrToPtr<TprtCqeReport_t *>(cqeInfo->cqeAddr))[reportCqeNum] = cqQueue_[cqHead];
        ++reportCqeNum;
        cqHead = (cqHead + 1U) % queueDepth;
    }
    cqeInfo->reportCqeNum = reportCqeNum;
    cqHead_.store(cqHead);
}

}
}