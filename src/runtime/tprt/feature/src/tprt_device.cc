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
#include "tprt_device.hpp"
#include "tprt_api.h"
#include <sstream>

namespace cce {
namespace tprt {

using PfnTprtOpSqCq = uint32_t (*)(TprtDevice *, TprtSqCqOpInfo_t *);
static uint32_t TprtProcSqQueryInfo(TprtDevice *dev, TprtSqCqOpInfo_t *opInfo)
{
    TprtSqHandle *sqHandle = dev->TprtGetSqHandleBySqId(opInfo->reqId);
    if (sqHandle == nullptr) {
        TPRT_LOG(TPRT_LOG_ERROR, "[tprt]device_id[%u] sq_id[%u] is invalid.", dev->TprtDevGetDevId_(), opInfo->reqId);
        return TPRT_SQ_HANDLE_INVALID;
    }

    uint32_t error = TPRT_SUCCESS;
    switch (opInfo->prop) {
        case TPRT_SQCQ_PROP_SQ_HEAD:
            opInfo->value[0] = static_cast<uint32_t>(sqHandle->SqGetSqHead());
            break;
        case TPRT_SQCQ_PROP_SQ_STATUS:
            opInfo->value[0] = static_cast<uint32_t>(sqHandle->SqGetSqState());
            break;
        case TPRT_SQCQ_PROP_SQ_CQE_STATUS:
            opInfo->value[0] = sqHandle->SqGetCqeState();
            sqHandle->SqSetCqeState(false);
            break;
        default:
            error = TPRT_INPUT_OP_TYPE_INVALID;
            TPRT_LOG(TPRT_LOG_ERROR,
                "[tprt]device_id[%u] sq_id[%u] op=%u is invalid.",
                dev->TprtDevGetDevId_(),
                opInfo->reqId,
                opInfo->prop);
            break;
    }
    return error;
}

static uint32_t TprtProcConfigSq(TprtDevice *dev, TprtSqCqOpInfo_t *opInfo)
{
    TprtSqHandle *sqHandle = dev->TprtGetSqHandleBySqId(opInfo->reqId);
    if (sqHandle == nullptr) {
        TPRT_LOG(TPRT_LOG_ERROR, "[tprt]device_id[%u] sq_id[%u] is invalid.", dev->TprtDevGetDevId_(), opInfo->reqId);
        return TPRT_SQ_HANDLE_INVALID;
    }
    uint32_t error = TPRT_SUCCESS;
    switch (opInfo->prop) {
        case TPRT_SQCQ_PROP_SQ_SET_STATUS_QUIT:
            sqHandle->SqSetSqState(TPRT_SQ_STATE_IS_QUITTED);
            break;
        default:
            error = TPRT_INPUT_OP_TYPE_INVALID;
            TPRT_LOG(TPRT_LOG_ERROR,
                "[tprt]device_id[%u] sq_id[%u] prop[%u].",
                dev->TprtDevGetDevId_(),
                opInfo->reqId,
                opInfo->prop);
            break;
    }
    return error;
}

TprtDevice::TprtDevice(uint32_t devId) : devId_(devId)
{}

TprtDevice::~TprtDevice()
{
    TPRT_LOG(TPRT_LOG_EVENT, "~TprtDevice.");
}

uint32_t TprtDevice::TprtDeviceStop()
{
    uint32_t sqCqId = 0U;
    for (auto it = sqHandleMap_.begin(); it != sqHandleMap_.end();) {
        sqCqId = it->first;
        it++;
        (void)TprtSqCqDeAlloc(sqCqId, sqCqId);
    }
    return TPRT_SUCCESS;
}
uint32_t TprtDevice::TprtSqCqAlloc(const uint32_t sqId, const uint32_t cqId)
{
    TprtSqHandle *sqHandle = nullptr;
    TprtCqHandle *cqHandle = nullptr;
    TprtWorker *worker = nullptr;

    std::lock_guard<std::mutex> allocLock(sqCqWorkerMapLock_);
    if (sqHandleMap_.find(sqId) != sqHandleMap_.end()) {
        TPRT_LOG(TPRT_LOG_ERROR, "Duplicate sq id. device_id=%u, sq_id=%u", devId_, sqId);
        return TPRT_SQ_HANDLE_INVALID;
    }

    if (cqHandleMap_.find(cqId) != cqHandleMap_.end()) {
        TPRT_LOG(TPRT_LOG_ERROR, "Duplicate cq id. device_id=%u, cq_id=%u", devId_, cqId);
        return TPRT_CQ_HANDLE_INVALID;
    }

    std::function<void()> const errRecycle = [&sqId, &cqId, &sqHandle, &cqHandle, &worker, this]() {
        if (this->sqHandleMap_.find(sqId) != this->sqHandleMap_.end()) { this->sqHandleMap_.erase(sqId); }
        if (this->cqHandleMap_.find(cqId) != this->cqHandleMap_.end()) { this->cqHandleMap_.erase(cqId); }
        if (this->workerMap_.find(sqHandle) != this->workerMap_.end()) { this->workerMap_.erase(sqHandle); }
        DELETE_O(sqHandle);
        DELETE_O(cqHandle);
        DELETE_O(worker);
    };
    ScopeGuard allocErrRecycle(errRecycle);
    sqHandle = new (std::nothrow) TprtSqHandle(devId_, sqId);
    if (sqHandle == nullptr) {
        TPRT_LOG(TPRT_LOG_ERROR, "New sq handle failed, device_id=%u, sq_id=%u", devId_, sqId);
        return TPRT_SQ_HANDLE_NEW_FAILED;
    }
    sqHandleMap_[sqId] = sqHandle;

    cqHandle = new (std::nothrow) TprtCqHandle(devId_, cqId);
    if (cqHandle == nullptr) {
        TPRT_LOG(TPRT_LOG_ERROR, "New cq handle failed, device_id=%u, cq_id=%u", devId_, cqId);
        return TPRT_CQ_HANDLE_NEW_FAILED;
    }
    cqHandleMap_[cqId] = cqHandle;

    worker = new (std::nothrow) TprtWorker(devId_, sqHandle, cqHandle);
    if (worker == nullptr) {
        TPRT_LOG(TPRT_LOG_ERROR, "New worker failed, device_id=%u, sq_id=%u", devId_, sqId);
        return TPRT_WORKER_NEW_FAILED;
    }
    workerMap_[sqHandle] = worker;

    const uint32_t ret = worker->TprtWorkerStart();
    if (ret != TPRT_SUCCESS) {
        TPRT_LOG(TPRT_LOG_ERROR, "start worker, device_id=%u", devId_);
        return ret;
    }
    allocErrRecycle.ReleaseGuard();
    return TPRT_SUCCESS;
}

uint32_t TprtDevice::TprtSqCqDeAlloc(const uint32_t sqId, const uint32_t cqId)
{
    TprtSqHandle *sqHandle = nullptr;
    TprtCqHandle *cqHandle = nullptr;
    TprtWorker *workHandle = nullptr;
    std::unique_lock<std::mutex> mapLock(sqCqWorkerMapLock_);
    auto sqItor = sqHandleMap_.find(sqId);
    if (sqItor != sqHandleMap_.end()) {
        sqHandle = sqItor->second;
        sqHandleMap_.erase(sqItor);
    }

    if (sqHandle != nullptr) {
        sqHandle->TprtSetSqState(TPRT_SQ_STATE_IS_QUITTED);

        auto workerItor = workerMap_.find(sqHandle);
        if (workerItor != workerMap_.end()) {
            workHandle = workerItor->second;
            workerMap_.erase(workerItor);
        }

        if (workHandle != nullptr) {
            workHandle->TprtWorkerFree();
            DELETE_O(workHandle);
        } else {
            TPRT_LOG(TPRT_LOG_WARNING, "work handle does not exist, sq_id=%u.", sqId);
        }
        DELETE_O(sqHandle);
    } else {
        TPRT_LOG(TPRT_LOG_WARNING, "sq does not exist, sq_id=%u.", sqId);
    }

    auto cqItor = cqHandleMap_.find(cqId);
    if (cqItor != cqHandleMap_.end()) {
        cqHandle = cqItor->second;
        cqHandleMap_.erase(cqItor);
    }
    if (cqHandle == nullptr) {
        TPRT_LOG(TPRT_LOG_WARNING, "cq does not exist, cq_id=%u.", cqId);
    }
    DELETE_O(cqHandle);
    return TPRT_SUCCESS;
}

TprtSqHandle *TprtDevice::TprtGetSqHandleBySqId(uint32_t sqId)
{
    std::unique_lock<std::mutex> sqLock(sqCqWorkerMapLock_);
    if (sqHandleMap_.find(sqId) != sqHandleMap_.end()) {
        return sqHandleMap_[sqId];
    }
    TPRT_LOG(TPRT_LOG_ERROR, "sq does not exist, sq_id=%u.", sqId);
    return nullptr;
}

TprtCqHandle *TprtDevice::TprtGetCqHandleByCqId(uint32_t cqId)
{
    std::unique_lock<std::mutex> cqLock(sqCqWorkerMapLock_);
    if (cqHandleMap_.find(cqId) != cqHandleMap_.end()) {
        return cqHandleMap_[cqId];
    }
    TPRT_LOG(TPRT_LOG_ERROR, "cq does not exist, cq_id=%u.", cqId);
    return nullptr;
}

TprtWorker *TprtDevice::TprtGetWorkHandleBySqHandle(TprtSqHandle *handle)
{
    std::unique_lock<std::mutex> mapLock(sqCqWorkerMapLock_);
    if (workerMap_.find(handle) != workerMap_.end()) {
        return workerMap_[handle];
    }
    TPRT_LOG(TPRT_LOG_ERROR, "workerHandle does not exist, sqHandle=%p.", handle);
    return nullptr;
}

uint32_t TprtDevice::TprtDevOpSqCqInfo(TprtSqCqOpInfo_t *opInfo)
{
    TPRT_LOG(TPRT_LOG_DEBUG,
        "[tprt]device_id[%u] process op type[%d] reqId[%u] prop[%u].",
        devId_,
        opInfo->type,
        opInfo->reqId,
        opInfo->prop);
    uint32_t error = TPRT_SUCCESS;
    switch (opInfo->type) {
        case TPRT_QUERY_SQ_INFO:
            error = TprtProcSqQueryInfo(this, opInfo);
            break;
        case TPRT_CONFIG_SQ:
            error = TprtProcConfigSq(this, opInfo);
            break;
        default:
            error = TPRT_INPUT_OP_TYPE_INVALID;
    }
    if (error != TPRT_SUCCESS) {
            TPRT_LOG(TPRT_LOG_ERROR,
                "[tprt]device_id[%u] process op type[%d] reqId[%u] prop[%u] failed, error=%u.",
                devId_,
                opInfo->type,
                opInfo->reqId,
                opInfo->prop,
                error);
    }
    return error;
}
}  // namespace tprt
}  // namespace cce