/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "tprt_error_code.h"
#include "tprt_api.h"
#include "tprt_type.h"
#include "tprt_worker.hpp"
#include "tprt.hpp"
#if defined(__cplusplus)
extern "C" {
#endif
uint32_t TprtDeviceOpen(const uint32_t devId, const TprtCfgInfo_t *cfg)
{
    if (cfg == nullptr) {
        TPRT_LOG(TPRT_LOG_ERROR, "[tprt]device_id[%u] input is null.", devId);
        return TPRT_INPUT_NULL;
    }
    if ((cfg->sqcqMaxDepth == 0U) || (cfg->sqcqMaxDepth > 1024U) || (cfg->sqcqMaxNum == 0U)) {
        TPRT_LOG(TPRT_LOG_ERROR,
            "[tprt]device_id[%u] sqcqMaxDepth[%u], sqcqMaxNum[%u].",
            devId,
            cfg->sqcqMaxDepth,
            cfg->sqcqMaxNum);
        return TPRT_INPUT_INVALID;
    }
    return cce::tprt::TprtManage::Instance()->TprtDeviceOpen(devId, cfg);
}

uint32_t TprtDeviceClose(uint32_t devId)
{
    return cce::tprt::TprtManage::Instance()->TprtDeviceClose(devId);
}

uint32_t TprtSqCqCreate(const uint32_t devId, const TprtSqCqInputInfo *sqInfo, const TprtSqCqInputInfo *cqInfo)
{
    if (sqInfo == nullptr) {
        TPRT_LOG(TPRT_LOG_ERROR, "[tprt]sqInfo is null, device_id=%u.", devId);
        return TPRT_INPUT_INVALID;
    }
    if (cqInfo == nullptr) {
        TPRT_LOG(TPRT_LOG_ERROR, "[tprt]cqInfo is null, device_id=%u.", devId);
        return TPRT_INPUT_INVALID;
    }
    if (sqInfo->inputType != TPRT_ALLOC_SQ_TYPE) {
        TPRT_LOG(TPRT_LOG_ERROR, "[tprt]Input type of sqInfo is wrong, device_id=%u, inputType=%u.", devId, sqInfo->inputType);
        return TPRT_INPUT_INVALID;
    }
    if (cqInfo->inputType != TPRT_ALLOC_CQ_TYPE) {
        TPRT_LOG(TPRT_LOG_ERROR, "[tprt]Input type of cqInfo is wrong, device_id=%u, inputType=%u.", devId, cqInfo->inputType);
        return TPRT_INPUT_INVALID;
    }

    uint32_t sqCqMaxNum = cce::tprt::TprtManage::Instance()->TprtGetSqCqMaxNum();
    if (sqInfo->reqId >= sqCqMaxNum) {
        TPRT_LOG(TPRT_LOG_ERROR,
            "[tprt]The reqId of sqInfo is larger than max num, device_id=%u, reqId=%u, sqCqMaxNum=%u.",
            devId,
            sqInfo->reqId,
            sqCqMaxNum);
        return TPRT_INPUT_INVALID;
    }

    if (cqInfo->reqId >= sqCqMaxNum) {
        TPRT_LOG(TPRT_LOG_ERROR,
            "[tprt]The reqId of cqInfo is larger than max num, device_id=%u, reqId=%u, sqCqMaxNum=%u.",
            devId,
            cqInfo->reqId,
            sqCqMaxNum);
        return TPRT_INPUT_INVALID;
    }

    cce::tprt::TprtDevice *device = cce::tprt::TprtManage::Instance()->GetDeviceByDevId(devId);
    if (device == nullptr) {
        TPRT_LOG(TPRT_LOG_ERROR, "[tprt]device_id[%u] is not found.", devId);
        return TPRT_DEVICE_INVALID;
    }

    uint32_t error = device->TprtSqCqAlloc(sqInfo->reqId, cqInfo->reqId);
    if (error != TPRT_SUCCESS) {
        TPRT_LOG(TPRT_LOG_ERROR,
            "[tprt]Failed to alloc sq cq. device_id=%u, sq_id=%u, cq_id=%u",
            devId,
            sqInfo->reqId,
            cqInfo->reqId);
        return error;
    }
    return TPRT_SUCCESS;
}

uint32_t TprtSqCqDestroy(const uint32_t devId, const TprtSqCqInputInfo *sqInfo, const TprtSqCqInputInfo *cqInfo)
{
    if (sqInfo == nullptr) {
        TPRT_LOG(TPRT_LOG_ERROR, "[tprt]sqInfo is null, device_id=%u.", devId);
        return TPRT_INPUT_INVALID;
    }
    if (cqInfo == nullptr) {
        TPRT_LOG(TPRT_LOG_ERROR, "[tprt]cqInfo is null, device_id=%u.", devId);
        return TPRT_INPUT_INVALID;
    }
    if (sqInfo->inputType != TPRT_FREE_SQ_TYPE) {
        TPRT_LOG(TPRT_LOG_ERROR, "[tprt]Input type of sqInfo is wrong, device_id=%u, inputType=%u.", devId, sqInfo->inputType);
        return TPRT_INPUT_INVALID;
    }
    if (cqInfo->inputType != TPRT_FREE_CQ_TYPE) {
        TPRT_LOG(TPRT_LOG_ERROR, "[tprt]Input type of cqInfo is wrong, device_id=%u, inputType=%u.", devId, cqInfo->inputType);
        return TPRT_INPUT_INVALID;
    }

    cce::tprt::TprtDevice *device = cce::tprt::TprtManage::Instance()->GetDeviceByDevId(devId);
    if (device == nullptr) {
        TPRT_LOG(TPRT_LOG_ERROR, "[tprt]device_id[%u] is not found.", devId);
        return TPRT_DEVICE_INVALID;
    }

    uint32_t error = device->TprtSqCqDeAlloc(sqInfo->reqId, cqInfo->reqId);
    return error;
}

uint32_t TprtSqPushTask(const uint32_t devId, const TprtTaskSendInfo_t *sendInfo)
{
    const uint32_t depth = cce::tprt::TprtManage::Instance()->TprtGetSqMaxDepth();
    if ((sendInfo == nullptr) || (sendInfo->sqeNum >= depth)) {
        TPRT_LOG(TPRT_LOG_ERROR, "[tprt]input is invalid device_id[%u].", devId);
        return TPRT_INPUT_INVALID;
    }
    cce::tprt::TprtManage *manage = cce::tprt::TprtManage::Instance();
    cce::tprt::TprtDevice *dev = manage->GetDeviceByDevId(devId);
    if (dev == nullptr) {
        TPRT_LOG(TPRT_LOG_ERROR, "[tprt]device_id[%u] is invalid.", devId);
        return TPRT_DEVICE_INVALID;
    }
    cce::tprt::TprtSqHandle *sqHandle = dev->TprtGetSqHandleBySqId(sendInfo->sqId);
    if (sqHandle == nullptr) {
        TPRT_LOG(TPRT_LOG_ERROR, "[tprt]device_id[%u] sq_id[%u] is invalid.", devId, sendInfo->sqId);
        return TPRT_SQ_HANDLE_INVALID;
    }
    cce::tprt::TprtWorker *worker = dev->TprtGetWorkHandleBySqHandle(sqHandle);
    if (worker == nullptr) {
        TPRT_LOG(TPRT_LOG_ERROR, "[tprt]device_id[%u] sq_id[%u] worker is invalid.", devId, sendInfo->sqId);
        return TPRT_WORKER_INVALID;
    }
    uint32_t error = sqHandle->SqPushTask(sendInfo->sqeAddr, sendInfo->sqeNum);
    if (error != TPRT_SUCCESS) {
        TPRT_LOG(TPRT_LOG_ERROR, "[tprt]device_id[%u] sq_id[%u] push task failed, error=%u.", devId,
            sendInfo->sqId, error);
        return error;
    }
    worker->WorkerWakeUp();
    return error;
}

uint32_t TprtOpSqCqInfo(uint32_t devId, TprtSqCqOpInfo_t *opInfo)
{
    if (opInfo == nullptr) {
        TPRT_LOG(TPRT_LOG_ERROR, "[tprt]input is null device_id[%u].", devId);
        return TPRT_INPUT_INVALID;
    }
    cce::tprt::TprtManage *manage = cce::tprt::TprtManage::Instance();
    cce::tprt::TprtDevice *dev = manage->GetDeviceByDevId(devId);
    if (dev == nullptr) {
        TPRT_LOG(TPRT_LOG_ERROR, "[tprt]device_id[%u] is invalid.", devId);
        return TPRT_DEVICE_INVALID;
    }
    const uint32_t error = dev->TprtDevOpSqCqInfo(opInfo);
    return error;
}

uint32_t TprtCqReportRecv(uint32_t devId, TprtReportCqeInfo_t *cqeInfo)
{
    if ((cqeInfo == nullptr) || (cqeInfo->cqeNum == 0U) || (cqeInfo->cqeAddr == nullptr)) {
        TPRT_LOG(TPRT_LOG_ERROR, "[tprt]cqe info is invalid, device_id=%u.", devId);
        return TPRT_INPUT_INVALID;
    }
    if (cqeInfo->type != TPRT_QUERY_CQ_INFO) {
        TPRT_LOG(TPRT_LOG_ERROR, "[tprt]device_id=%u op type[%u] is invalid.", devId, cqeInfo->type);
        return TPRT_INPUT_OP_TYPE_INVALID;
    }
    cce::tprt::TprtManage *manage = cce::tprt::TprtManage::Instance();
    cce::tprt::TprtDevice *dev = manage->GetDeviceByDevId(devId);
    if (dev == nullptr) {
        TPRT_LOG(TPRT_LOG_ERROR, "[tprt]device_id[%u] is invalid.", devId);
        return TPRT_DEVICE_INVALID;
    }
    cce::tprt::TprtCqHandle *cqHandle = dev->TprtGetCqHandleByCqId(cqeInfo->cqId);
    if (cqHandle == nullptr) {
        TPRT_LOG(TPRT_LOG_ERROR, "[tprt]device_id[%u] cq_id=%u cqhandle can not find.", devId, cqeInfo->cqId);
        return TPRT_CQ_HANDLE_INVALID;
    }
    cqHandle->TprtCqHandleGetCqe(cqeInfo);
    return TPRT_SUCCESS;
}

#ifdef __cplusplus
}
#endif