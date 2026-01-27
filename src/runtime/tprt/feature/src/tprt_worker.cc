/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "tprt_worker.hpp"
#include "tprt_cqhandle.hpp"
#include "tprt_sqhandle.hpp"
#include "tprt_type.h"

namespace cce {
namespace tprt {

TprtWorker::TprtWorker(uint32_t devId, TprtSqHandle *sqHandle, TprtCqHandle *cqHandle)
    : devId_(devId), sqHandle_(sqHandle), cqHandle_(cqHandle)
{
    uint32_t sqId = sqHandle_->SqGetSqId();
    workerName_ = std::to_string(sqId) + "_" + std::to_string(devId_);
}

TprtWorker::~TprtWorker()
{
    TPRT_LOG(TPRT_LOG_EVENT, "worker:%s destructor", workerName_.c_str());
    sqHandle_ = nullptr;
    cqHandle_ = nullptr;
}

void TprtWorker::TprtWorkerProcessErrorCqe(TprtErrorType errorType, uint32_t errorCode, TprtSqe_t *task)
{
    TprtCqHandle *cqHandle = GetCqHandle();
    TprtSqHandle *sqHandle = GetSqHandle();
    if (cqHandle != nullptr) {
        uint32_t ret = cqHandle->TprtCqWriteCqe(errorType, errorCode, task, sqHandle);
        if (ret == TPRT_SUCCESS) {
            sqHandle->SqSetCqeState(true);
        }
    }
    if (sqHandle != nullptr) {
        sqHandle->SqSetSqState(TPRT_SQ_STATE_ERROR_ENCOUNTERED);
    }
}

void TprtWorker::TprtWorkerScheduleSq()
{
    uint32_t sqId = sqHandle_->SqGetSqId();
    workerName_ = std::to_string(sqId) + "_" + std::to_string(devId_) + "_" + std::to_string(mmGetTid());
    while(workerRunningFlag_) {
        (void)mmSemWait(&workerThreadSem_);
        TprtSqHandle *sqHandle = GetSqHandle();
        if (sqHandle != nullptr) {
            while (sqHandle->SqGetSqState() == TPRT_SQ_STATE_IS_RUNNING) {
                TprtSqe_t headTask = {};
                uint32_t ret = sqHandle->SqPeekTask(&headTask);
                if (ret == TPRT_SUCCESS) {
                    uint32_t result = sqHandle->SqExeTask(&headTask);
                    if (result == TPRT_SUCCESS) {
                        sqHandle->SqUpdateHead(headTask.commonSqe.sqeHeader.sqeLength);
                        TPRT_LOG(TPRT_LOG_DEBUG, "sq_id=%u sq_head=%u.", sqHandle->SqGetSqId(), sqHandle->SqGetSqHead());
                    } else {
                        sqHandle->PrintTprtSqe(&headTask, TPRT_LOG_ERROR);
                        TprtWorkerProcessErrorCqe(TPRT_EXIST_ERROR, result, &headTask);
                        break;
                    }
                } else {
                    break;
                }
            }
            if (sqHandle->SqGetSqState() == TPRT_SQ_STATE_IS_QUITTED) {
                sqHandle->SqSetSqTailToHead();
            }
        }
    }
}

uint32_t TprtWorker::TprtWorkerStart()
{
    const uint32_t error = mmSemInit(&workerThreadSem_, 0U);
    if (error != TPRT_SUCCESS) {
        TPRT_LOG(TPRT_LOG_ERROR, "Create sem failed, retCode=%d", error);
        return TPRT_START_WORKER_FAILED;
    }
    workerRunningFlag_ = true;
    workerThread_ = std::thread(&TprtWorker::TprtWorkerScheduleSq, this);
    TPRT_LOG(TPRT_LOG_INFO, "Worker thread start, thread_name=%s", workerName_.c_str());
    return TPRT_SUCCESS;
}
void TprtWorker::WorkerWakeUp()
{
    int val = 0;
    sem_getvalue(&workerThreadSem_, &val);
    if (val < 2) {
        (void)mmSemPost(&workerThreadSem_);
    }
}

void TprtWorker::TprtWorkerFree()
{
    workerRunningFlag_ = false;

    WorkerWakeUp();

    if (workerThread_.joinable()) {
        workerThread_.join();
        TPRT_LOG(TPRT_LOG_INFO, "Worker thread stop, thread_name=%s", workerName_.c_str());
    }
    (void)mmSemDestroy(&workerThreadSem_);
}

}  // namespace tprt
}  // namespace cce