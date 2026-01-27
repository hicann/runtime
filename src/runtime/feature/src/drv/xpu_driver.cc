/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "xpu_driver.hpp"
#include "base.hpp"
#include "errcode_manage.hpp"
#include "error_message_manage.hpp"
#include "tprt_api.h"
#include "tprt_error_code.h"
#include "tprt_type.h"

namespace cce {
namespace runtime {
bool g_xpuDriverRegResult = DriverFactory::RegDriver(XPU_DRIVER, &XpuDriver::Instance_);

XpuDriver::XpuDriver() : NpuDriver()
{
    InitDrvErrCodeMap();
}

void XpuDriver::InitDrvErrCodeMap()
{
    tprtErrMap_[TPRT_SUCCESS] = RT_ERROR_NONE;
    tprtErrMap_[TPRT_INPUT_NULL] = RT_ERROR_DRV_NULL;
    tprtErrMap_[TPRT_INPUT_INVALID] = RT_ERROR_DRV_INPUT;
    tprtErrMap_[TPRT_INPUT_OP_TYPE_INVALID] = RT_ERROR_DRV_INPUT;
    tprtErrMap_[TPRT_DEVICE_INVALID] = RT_ERROR_DRV_INVALID_DEVICE;
    tprtErrMap_[TPRT_DEVICE_NEW_FAILED] = RT_ERROR_DRV_NEW;
    tprtErrMap_[TPRT_SQ_HANDLE_INVALID] = RT_ERROR_DRV_INVALID_HANDLE;
    tprtErrMap_[TPRT_SQ_DEPTH_IS_INVALID] = RT_ERROR_DRV_INPUT;
    tprtErrMap_[TPRT_SQ_HANDLE_NEW_FAILED] = RT_ERROR_DRV_INPUT;
    tprtErrMap_[TPRT_SQ_QUEUE_FULL] = RT_ERROR_DRV_QUEUE_FULL;
    tprtErrMap_[TPRT_CQ_HANDLE_INVALID] = RT_ERROR_DRV_INVALID_HANDLE;
    tprtErrMap_[TPRT_CQ_QUEUE_FULL] = RT_ERROR_DRV_QUEUE_FULL;
    tprtErrMap_[TPRT_CQ_HANDLE_INVALID] = RT_ERROR_DRV_INVALID_HANDLE;
    tprtErrMap_[TPRT_CQ_HANDLE_NEW_FAILED] = RT_ERROR_DRV_NEW;
    tprtErrMap_[TPRT_WORKER_INVALID] = RT_ERROR_DRV_INVALID_HANDLE;
    tprtErrMap_[TPRT_WORKER_NEW_FAILED] = RT_ERROR_DRV_NEW;
    tprtErrMap_[TPRT_START_WORKER_FAILED] = RT_ERROR_DRV_ERR;
}

rtError_t XpuDriver::GetDrvErrCode(const uint32_t errCode)
{
    const auto it = tprtErrMap_.find(errCode);
    if (it == tprtErrMap_.end()) {
        return RT_ERROR_DRV_ERR;
    }
    return it->second;
}

rtError_t XpuDriver::XpuDriverDeviceOpen(const uint32_t devId, TprtCfgInfo_t *devInfo) const
{
    rtError_t error = RT_ERROR_NONE;
	error = TprtDeviceOpen(devId, devInfo);
    COND_RETURN_ERROR_MSG_INNER(error != RT_ERROR_NONE, error, "Open device failed, device_id=%u, error=%u.", devId, error);
    return RT_ERROR_NONE;
}

rtError_t XpuDriver::XpuDriverDeviceClose(const uint32_t devId) const
{
    rtError_t error = RT_ERROR_NONE;
    error = TprtDeviceClose(devId);
    COND_RETURN_ERROR_MSG_INNER(error != RT_ERROR_NONE, error, "Close device failed, device_id=%u, error=%u.", devId, error);
    return RT_ERROR_NONE;
}

rtError_t XpuDriver::XpuDriverSetSqCqStatus(const uint32_t devId, const uint32_t sqId)
{
    TprtSqCqOpInfo_t opInfo = {};
    opInfo.type = TPRT_CONFIG_SQ;
    opInfo.reqId = sqId;
    opInfo.prop = TPRT_SQCQ_PROP_SQ_SET_STATUS_QUIT;
    const uint32_t ret = TprtOpSqCqInfo(devId, &opInfo);
    COND_RETURN_ERROR_MSG_INNER(ret != TPRT_SUCCESS, GetDrvErrCode(ret),
        "[tprt api] tprtOpSqCqInfo device_id=%u, sq_id=%u, retCode=%u.", devId, sqId, ret);
    return RT_ERROR_NONE;
}

rtError_t XpuDriver::XpuDriverDeviceSqCqAlloc(const uint32_t devId, const uint32_t sqId, const uint32_t cqId)
{
    TprtSqCqInputInfo sqInfo = {0, TPRT_INVALID_TYPE};
    sqInfo.reqId = sqId;
    sqInfo.inputType = TPRT_ALLOC_SQ_TYPE;

    TprtSqCqInputInfo cqInfo = {0, TPRT_INVALID_TYPE};
    cqInfo.reqId = cqId;
    cqInfo.inputType = TPRT_ALLOC_CQ_TYPE;
    uint32_t error = TprtSqCqCreate(devId, &sqInfo, &cqInfo);
    COND_RETURN_ERROR_MSG_INNER(error != TPRT_SUCCESS,
        GetDrvErrCode(error),
        "AllocXpuStreamSqCq failed, device_id=%u, sq_id=%u, cq_id=%u, retCode=%u.",
        devId,
        sqId,
        cqId,
        error);
    return RT_ERROR_NONE;
}

rtError_t XpuDriver::XpuDriverSqCqDestroy(const uint32_t devId, const uint32_t sqId, const uint32_t cqId)
{
    rtError_t error = RT_ERROR_NONE;
    TprtSqCqInputInfo sqInfo = {0, TPRT_INVALID_TYPE};
    sqInfo.reqId = sqId;
    sqInfo.inputType = TPRT_FREE_SQ_TYPE;
    TprtSqCqInputInfo cqInfo = {0, TPRT_INVALID_TYPE};
    cqInfo.reqId = cqId;
    cqInfo.inputType = TPRT_FREE_CQ_TYPE;
    error = TprtSqCqDestroy(devId, &sqInfo, &cqInfo);
    COND_RETURN_ERROR_MSG_INNER(error != RT_ERROR_NONE,
        GetDrvErrCode(error),
        "TprtSqCqDestroy failed, device_id=%u, sq_id=%u, cq_id=%u, retCode=%u.",
        devId,
        sqId,
        cqId,
        error);
    return RT_ERROR_NONE;
}

rtError_t XpuDriver::GetSqHead(const uint32_t deviceId, const uint32_t tsId, const uint32_t sqId, uint16_t &head, bool needLog)
{
    (void)tsId;
    (void)needLog;
    TprtSqCqOpInfo_t opInfo = {};
    opInfo.type = TPRT_QUERY_SQ_INFO;
    opInfo.reqId = sqId;
    opInfo.prop = TPRT_SQCQ_PROP_SQ_HEAD;
    const uint32_t ret = TprtOpSqCqInfo(deviceId, &opInfo);
    COND_RETURN_ERROR_MSG_INNER(ret != TPRT_SUCCESS, GetDrvErrCode(ret),
        "[tprt api] tprtOpSqCqInfo device_id=%u, sq_id=%u, retCode=%d.", deviceId, sqId,
        static_cast<int32_t>(ret));

    head = static_cast<uint16_t>(opInfo.value[0] & 0xFFFFU);
    return RT_ERROR_NONE;
}

rtError_t XpuDriver::GetCqeStatus(const uint32_t deviceId, const uint32_t tsId, const uint32_t sqId, bool &status)
{
    (void)tsId;
    TprtSqCqOpInfo_t opInfo = {};
    opInfo.type = TPRT_QUERY_SQ_INFO;
    opInfo.reqId = sqId;
    opInfo.prop = TPRT_SQCQ_PROP_SQ_CQE_STATUS;
    const uint32_t ret = TprtOpSqCqInfo(deviceId, &opInfo);
    COND_RETURN_ERROR_MSG_INNER(ret != TPRT_SUCCESS, GetDrvErrCode(ret),
        "[tprt api] tprtOpSqCqInfo device_id=%u, sq_id=%u, retCode=%u.", deviceId, sqId,
        static_cast<int32_t>(ret));
    status = (opInfo.value[0] != 0U) ? true : false;
    return RT_ERROR_NONE;
}

rtError_t XpuDriver::LogicCqReportV2(const LogicCqWaitInfo &waitInfo, uint8_t *report, uint32_t reportCnt,
    uint32_t &realCnt)
{
    TprtReportCqeInfo_t repRecvInfo = {};
    repRecvInfo.type = TPRT_QUERY_CQ_INFO;
    repRecvInfo.cqId = waitInfo.cqId;
    repRecvInfo.cqeAddr = report;
    repRecvInfo.cqeNum = reportCnt;
    repRecvInfo.reportCqeNum = reportCnt;
    RT_LOG(RT_LOG_DEBUG, "device_id=%u, ts_id=%u, type=%u, logicCq=%u, stream_id=%u, reportCqeNum=%u.",
        waitInfo.devId, waitInfo.tsId, static_cast<uint32_t>(repRecvInfo.type), waitInfo.cqId,
        waitInfo.streamId, reportCnt);
    uint32_t reportGetRet = TprtCqReportRecv(waitInfo.devId, &repRecvInfo);
    RT_LOG(RT_LOG_DEBUG, "reportCqeNum=%u, drvReportGetRet=%d.", repRecvInfo.reportCqeNum, reportGetRet);
    if (reportGetRet != TPRT_SUCCESS) {
        RT_LOG(RT_LOG_ERROR, "device_id=%u, cq_id=%u, reportGetRet=%u.",
               waitInfo.devId, waitInfo.cqId, reportGetRet);
        return GetDrvErrCode(reportGetRet);
    }
    realCnt = repRecvInfo.reportCqeNum;
    for (uint32_t i = 0U; i < realCnt; i++) {
        const TprtLogicCqReport_t &cqe = (RtPtrToPtr<TprtLogicCqReport_t *>(report))[i];
        RT_LOG(RT_LOG_DEBUG, "device_id=%u, sq_id=%hu, sq_head=%hu, task_sn=%u, cq_id=%u, sqe_type=%hhu",
               waitInfo.devId, cqe.sqId, cqe.sqHead, cqe.taskSn, waitInfo.cqId, cqe.sqeType);
    }
    return RT_ERROR_NONE;
}

rtError_t XpuDriver::GetSqState(const uint32_t deviceId, const uint32_t sqId, uint32_t &status)
{
    TprtSqCqOpInfo_t opInfo = {};
    opInfo.type = TPRT_QUERY_SQ_INFO;
    opInfo.reqId = sqId;
    opInfo.prop = TPRT_SQCQ_PROP_SQ_STATUS;
    const uint32_t ret = TprtOpSqCqInfo(deviceId, &opInfo);
    COND_RETURN_ERROR_MSG_INNER(ret != TPRT_SUCCESS, GetDrvErrCode(ret),
        "[tprt api] tprtOpSqCqInfo device_id=%u, sq_id=%u, retCode=%u.", deviceId, sqId,
        static_cast<int32_t>(ret));
    status = opInfo.value[0];
    return RT_ERROR_NONE;
}

}  // namespace runtime
}  // namespace cce
