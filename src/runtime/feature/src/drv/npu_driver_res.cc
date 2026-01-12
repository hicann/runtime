/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "npu_driver.hpp"
#include "driver/ascend_hal.h"
#include "mmpa/mmpa_api.h"
#include "driver/ascend_inpackage_hal.h"
#include "task.hpp"
#include "driver.hpp"
#include "securec.h"
#include "runtime.hpp"
#include "osal.hpp"
#include "arg_loader.hpp"
#include "errcode_manage.hpp"
#include "error_message_manage.hpp"
#include "npu_driver_record.hpp"

namespace cce {
namespace runtime {

constexpr uint32_t GET_SQ_HEAD_MAX_RETRY_TIMES = 100U;
constexpr uint32_t GET_SQ_HEAD_QUERY_FAIL_STAT_TIMES = 1000U;

rtError_t NpuDriver::GetFaultEvent(const int32_t deviceId, const rtDmsEventFilter * const filter,
                                   rtDmsFaultEvent *dmsEvent, uint32_t len, uint32_t *eventCount)
{
    drvError_t drvRet = DRV_ERROR_NONE;

    COND_RETURN_WARN(&halGetFaultEvent == nullptr, RT_ERROR_FEATURE_NOT_SUPPORT,
        "[drv api] halGetFaultEvent does not exist");
    struct halEventFilter dmsFilter = {};
    dmsFilter.filter_flag = static_cast<uint64_t>(RT_DSM_EVENT_FILTER_FLAG_PID);
    dmsFilter.event_id = filter->eventId;
    dmsFilter.severity = filter->severity;
    dmsFilter.node_type = filter->nodeType;
    RT_LOG(RT_LOG_INFO, "get fault event, drv devId=%d, filterFlag=%llu, outputLen=%u.",
        deviceId, dmsFilter.filter_flag, len);
    drvRet = halGetFaultEvent(static_cast<uint32_t>(deviceId), &dmsFilter,
        RtPtrToPtr<halFaultEventInfo *>(dmsEvent), len, eventCount);

    COND_RETURN_WARN(drvRet == DRV_ERROR_NOT_SUPPORT, RT_ERROR_FEATURE_NOT_SUPPORT,
        "[drv api] halGetFaultEvent does not support.");
    if (drvRet != DRV_ERROR_NONE) {
        DRV_ERROR_PROCESS(drvRet, "[drv api]halGetFaultEvent failed. drvRetCode=%d, device_id=%d.",
            static_cast<int32_t>(drvRet), deviceId);
    }

    return RT_GET_DRV_ERRCODE(drvRet);
}

rtError_t NpuDriver::GetAllFaultEvent(const uint32_t deviceId, rtDmsFaultEvent * const dmsEvent,
    uint32_t len, uint32_t *eventCount)
{
    drvError_t drvRet = DRV_ERROR_NONE;

    COND_RETURN_WARN(&halGetFaultEvent == nullptr, RT_ERROR_FEATURE_NOT_SUPPORT,
        "[drv api] halGetFaultEvent does not exist");
    struct halEventFilter dmsFilter = {};
    dmsFilter.filter_flag = 0U;
    drvRet = halGetFaultEvent(deviceId, &dmsFilter,
        RtPtrToPtr<halFaultEventInfo *>(dmsEvent), len, eventCount);
    COND_RETURN_WARN(drvRet == DRV_ERROR_NOT_SUPPORT, RT_ERROR_FEATURE_NOT_SUPPORT,
        "[drv api] halGetFaultEvent does not support.");
    if (drvRet != DRV_ERROR_NONE) {
        DRV_ERROR_PROCESS(drvRet, "[drv api]halGetFaultEvent failed. drvRetCode=%d, drv devId=%u, len=%u, flag=%llu.",
            static_cast<int32_t>(drvRet), deviceId, len, dmsFilter.filter_flag);
    }

    return RT_GET_DRV_ERRCODE(drvRet);
}

rtError_t NpuDriver::ReadFaultEvent(
    const int32_t deviceId, uint32_t timeout, const rtDmsEventFilter * const filter, rtDmsFaultEvent *dmsEvent)
{
    NULL_PTR_RETURN_MSG(filter, RT_ERROR_INVALID_VALUE);
    drvError_t drvRet = DRV_ERROR_NONE;

    COND_RETURN_WARN(&halReadFaultEvent == nullptr, RT_ERROR_FEATURE_NOT_SUPPORT,
        "[drv api] halReadFaultEvent does not exist");
    struct halEventFilter dmsFilter = {};
    dmsFilter.filter_flag = filter->filterFlag;
    dmsFilter.event_id = filter->eventId;
    dmsFilter.severity = filter->severity;
    dmsFilter.node_type = filter->nodeType;
    drvRet = halReadFaultEvent(deviceId, static_cast<int>(timeout), &dmsFilter,
        RtPtrToPtr<halFaultEventInfo *>(dmsEvent));
    COND_RETURN_WARN(drvRet == DRV_ERROR_NOT_SUPPORT, RT_ERROR_FEATURE_NOT_SUPPORT,
        "[drv api] halReadFaultEvent does not support.");
    COND_RETURN_WARN(drvRet == DRV_ERROR_RESOURCE_OCCUPIED, RT_ERROR_DRV_NO_RESOURCES,
        "[drv api] halReadFaultEvent, drv no resource.");

    if (drvRet != DRV_ERROR_NONE && drvRet != DRV_ERROR_NO_EVENT) {
        DRV_ERROR_PROCESS(drvRet,
            "[drv api]halReadFaultEvent failed. drvRetCode=%d, drv devId=%d, flag=%llu, eventId=%u, timeout=%ums.",
            static_cast<int32_t>(drvRet), deviceId, dmsFilter.filter_flag, dmsFilter.event_id, timeout);
    }

    return RT_GET_DRV_ERRCODE(drvRet);
}

rtError_t NpuDriver::GetRasSyscnt(const uint32_t deviceId, RtHbmRasInfo *hbmRasInfo)
{
    drvError_t drvRet = DRV_ERROR_NONE;

    COND_RETURN_WARN(&halGetDeviceInfoByBuff == nullptr, RT_ERROR_FEATURE_NOT_SUPPORT,
        "[drv api] halGetDeviceInfoByBuff does not exist");
    constexpr int32_t infoType = RT_INFO_TYPE_SYS_COUNT;
    constexpr int32_t moduleType = RT_MODULE_TYPE_MEMORY;
    int32_t size = sizeof(RtHbmRasInfo);
    RT_LOG(RT_LOG_INFO, "get hbm ras syscnt begin, device_id=%u, moduleType=%d, infoType=%d",
        deviceId, moduleType, infoType);
    drvRet = halGetDeviceInfoByBuff(deviceId, moduleType, infoType, static_cast<void *>(hbmRasInfo), &size);
    COND_RETURN_WARN(drvRet == DRV_ERROR_NOT_SUPPORT, RT_ERROR_FEATURE_NOT_SUPPORT,
        "[drv api] halGetDeviceInfoByBuff does not support.");
    if (drvRet != DRV_ERROR_NONE) {
        DRV_ERROR_PROCESS(drvRet, "[drv api]halGetDeviceInfoByBuff failed. drvRetCode=%d, device_id=%u,"
        "moduleType=%d, infoType=%d.", static_cast<int32_t>(drvRet), deviceId, moduleType, infoType);
    }

    return RT_GET_DRV_ERRCODE(drvRet);
}

rtError_t NpuDriver::GetMemUceInfo(const uint32_t deviceId, rtMemUceInfo *memUceInfo)
{
    drvError_t drvRet = DRV_ERROR_NONE;

    COND_RETURN_WARN(&halGetDeviceInfoByBuff == nullptr, RT_ERROR_FEATURE_NOT_SUPPORT,
        "[drv api] halGetDeviceInfoByBuff does not exist");
    constexpr int32_t infoType = RT_INFO_TYPE_VA;
    constexpr int32_t moduleType = RT_MODULE_TYPE_MEMORY;
    int32_t size = sizeof(rtMemUceInfo);
    RT_LOG(RT_LOG_INFO, "get mem uce info begin, device_id=%u, moduleType=%d, infoType=%d",
        deviceId, moduleType, infoType);
    drvRet = halGetDeviceInfoByBuff(deviceId, moduleType, infoType, static_cast<void *>(memUceInfo), &size);
    COND_RETURN_WARN(drvRet == DRV_ERROR_NOT_SUPPORT, RT_ERROR_FEATURE_NOT_SUPPORT,
        "[drv api] halGetDeviceInfoByBuff does not support.");
    if (drvRet != DRV_ERROR_NONE) {
        DRV_ERROR_PROCESS(drvRet, "[drv api]halGetDeviceInfoByBuff failed. drvRetCode=%d, device_id=%u,"
        "moduleType=%d, infoType=%d.", static_cast<int32_t>(drvRet), deviceId, moduleType, infoType);
    }

    return RT_GET_DRV_ERRCODE(drvRet);
}

rtError_t NpuDriver::GetDeviceInfoByBuff(const uint32_t deviceId, const int32_t moduleType, const int32_t infoType,
    void * const buf, int32_t * const size)
{
    drvError_t drvRet = DRV_ERROR_NONE;

    COND_RETURN_WARN(&halGetDeviceInfoByBuff == nullptr, RT_ERROR_FEATURE_NOT_SUPPORT,
        "[drv api] halGetDeviceInfoByBuff does not exist");
    drvRet = halGetDeviceInfoByBuff(deviceId, moduleType, infoType, buf, size);
    COND_RETURN_WARN(drvRet == DRV_ERROR_NOT_SUPPORT, RT_ERROR_FEATURE_NOT_SUPPORT,
        "[drv api] halGetDeviceInfoByBuff does not support.");
    if (drvRet != DRV_ERROR_NONE) {
        DRV_ERROR_PROCESS(drvRet, "[drv api]halGetDeviceInfoByBuff failed. drvRetCode=%d, device_id=%d,"
        "moduleType=%d, infoType=%d.", static_cast<int32_t>(drvRet), deviceId, moduleType, infoType);
    }

    return RT_GET_DRV_ERRCODE(drvRet);
}

rtError_t NpuDriver::SetDeviceInfoByBuff(const uint32_t deviceId, const int32_t moduleType, const int32_t infoType,
    void * const buf, const int32_t size)
{
    drvError_t drvRet = DRV_ERROR_NONE;

    COND_RETURN_WARN(&halSetDeviceInfoByBuff == nullptr, RT_ERROR_FEATURE_NOT_SUPPORT,
        "[drv api] halGetDeviceInfoByBuff does not exist");
    drvRet = halSetDeviceInfoByBuff(deviceId, moduleType, infoType, buf, size);
    COND_RETURN_WARN(drvRet == DRV_ERROR_NOT_SUPPORT, RT_ERROR_FEATURE_NOT_SUPPORT,
        "[drv api] halSetDeviceInfoByBuff does not support.");
    if (drvRet != DRV_ERROR_NONE) {
        DRV_ERROR_PROCESS(drvRet, "[drv api]halSetDeviceInfoByBuff failed. drvRetCode=%d, device_id=%u,"
        "moduleType=%d, infoType=%d.", static_cast<int32_t>(drvRet), deviceId, moduleType, infoType);
    }

    return RT_GET_DRV_ERRCODE(drvRet);
}

rtError_t NpuDriver::GetDeviceAicpuStat(const uint32_t deviceId)
{
    COND_RETURN_INFO(halCheckProcessStatus == nullptr, RT_ERROR_NONE, "[drv api] halCheckProcessStatus does not exist.");
    bool isMatched = false;
    const drvError_t drvRet = halCheckProcessStatus(deviceId, PROCESS_CP1, STATUS_NOMEM, &isMatched);
    if (drvRet != DRV_ERROR_NONE) {
        DRV_ERROR_PROCESS(drvRet, "[driver interface] halCheckProcessStatus failed: device_id=%u, "
            "drvRetCode=%d!", deviceId, static_cast<int32_t>(drvRet));
        return RT_GET_DRV_ERRCODE(drvRet);
    }
    if (isMatched) {
        return RT_ERROR_DEVICE_OOM;
    }

    return RT_ERROR_NONE;
}

rtError_t NpuDriver::GetDeviceStatus(uint32_t devId, drvStatus_t * const status)
{
    COND_RETURN_WARN(&drvDeviceStatus == nullptr, RT_ERROR_DRV_NOT_SUPPORT,
        "[drv api] drvDeviceStatus does not exist");
    const drvError_t drvRet = drvDeviceStatus(devId, status);
    if (drvRet != DRV_ERROR_NONE) {
        DRV_ERROR_PROCESS(drvRet, "drvDeviceStatus failed, drv devid(%u), drvRetCode(%d).",
            devId, static_cast<int32_t>(drvRet));
        return RT_GET_DRV_ERRCODE(drvRet);
    }
    COND_PROC((drvStatus_ != (*status)),
        RT_LOG(RT_LOG_EVENT, "GetDeviceStatus status=%d.", *status);
        drvStatus_ = *status);

    return RT_ERROR_NONE;
}

rtError_t NpuDriver::TaskKill(const uint32_t deviceId, const uint32_t tsId,
		              const uint32_t sqId, const uint32_t operationType)
{
    ts_ctrl_msg_body_t killIn = {};
    ts_ctrl_msg_body_t killAck = {};
    size_t ackCount = sizeof(ts_ctrl_msg_body_t);

    killIn.type = operationType;
    // when aborting stream, sq id is needed by TS;
    if (operationType == OP_ABORT_STREAM) {
        killIn.u.kill_stream_info.sq_id = sqId;
    }

    struct tsdrv_ctrl_msg para;
    para.tsid = tsId;
    para.msg_len = sizeof(ts_ctrl_msg_body_t);
    para.msg = static_cast<void*>(&killIn);

    COND_RETURN_WARN(&halTsdrvCtl == nullptr, RT_ERROR_DRV_NOT_SUPPORT,
        "[drv api] halTsdrvCtl does not exist.");
    RT_LOG(RT_LOG_INFO, "deviceId=%u, tsId=%u, sqId=%u.", deviceId, tsId, sqId);
    const drvError_t drvRet = halTsdrvCtl(deviceId, TSDRV_CTL_CMD_CTRL_MSG,
        static_cast<void*>(&para), sizeof(tsdrv_ctrl_msg), static_cast<void*>(&killAck), &ackCount);
    COND_RETURN_ERROR_MSG_CALL(ERR_MODULE_DRV, drvRet != DRV_ERROR_NONE, RT_GET_DRV_ERRCODE(drvRet),
        "device_id=%u, ts_id=%u, sq_id=%u, drvRetCode=%d.", deviceId, tsId, sqId, static_cast<int32_t>(drvRet));

    return RT_ERROR_NONE;
}

rtError_t NpuDriver::TaskAbortByType(const uint32_t deviceId, const uint32_t tsId, const uint32_t opType,
    const uint32_t targetId, uint32_t &result)
{
    ts_ctrl_msg_body_t killIn = {};
    ts_ctrl_msg_body_t killAck = {};
    size_t ackCount = sizeof(ts_ctrl_msg_body_t);
    COND_RETURN_ERROR((opType >= OP_INVALID), RT_ERROR_INVALID_VALUE, "Invalid abort param");
    killIn.type = opType;
    if (opType == OP_ABORT_STREAM) {
        killIn.u.kill_stream_info.sq_id = targetId;
    } else if (opType == OP_ABORT_MODEL) {
        killIn.u.kill_model_info.model_id = targetId;
    } else {
        // no operation
    }

    struct tsdrv_ctrl_msg para;
    para.tsid = tsId;
    para.msg_len = sizeof(ts_ctrl_msg_body_t);
    para.msg = static_cast<void*>(&killIn);

    COND_RETURN_WARN(&halTsdrvCtl == nullptr, RT_ERROR_DRV_NOT_SUPPORT,
        "[drv api] halTsdrvCtl does not exist.");
    RT_LOG(RT_LOG_INFO, "device_id=%u, op_type=%u, target_id=%u.", deviceId, opType, targetId);
    const drvError_t drvRet = halTsdrvCtl(deviceId, TSDRV_CTL_CMD_CTRL_MSG,
        static_cast<void*>(&para), sizeof(tsdrv_ctrl_msg), static_cast<void*>(&killAck), &ackCount);
    COND_RETURN_ERROR_MSG_CALL(ERR_MODULE_DRV, drvRet != DRV_ERROR_NONE, RT_GET_DRV_ERRCODE(drvRet),
        "device_id=%u, ts_id=%u, target_id=%u, drvRetCode=%d.", deviceId, tsId, targetId, static_cast<int32_t>(drvRet));

    if (opType == OP_ABORT_STREAM) {
        result = killAck.u.kill_stream_info.result;
    } else if (opType == OP_ABORT_MODEL) {
        result = killAck.u.kill_model_info.result;
    } else if (opType == OP_ABORT_APP) {
        result = killAck.u.kill_app_info.result;
    }

    return RT_ERROR_NONE;
}

rtError_t NpuDriver::QueryAbortStatusByType(const uint32_t deviceId, const uint32_t tsId, const uint32_t queryType,
    const uint32_t targetId, uint32_t &status)
{
    ts_ctrl_msg_body_t queryIn = {};
    ts_ctrl_msg_body_t queryAck = {};
    size_t ackCount = sizeof(ts_ctrl_msg_body_t);
    queryIn.type = OP_QUERY_ABORT_STATUS;
    queryIn.u.query_abort_info.choice = queryType;
    queryIn.u.query_abort_info.target_id = targetId;

    struct tsdrv_ctrl_msg para;
    para.tsid = tsId;
    para.msg_len = sizeof(ts_ctrl_msg_body_t);
    para.msg = static_cast<void*>(&queryIn);

    COND_RETURN_WARN(&halTsdrvCtl == nullptr, RT_ERROR_DRV_NOT_SUPPORT,
        "[drv api] halTsdrvCtl does not exist.");
    RT_LOG(RT_LOG_INFO, "device_id=%u, ts_id=%u, target_id=%u.", deviceId, tsId, targetId);
    const drvError_t drvRet = halTsdrvCtl(deviceId, TSDRV_CTL_CMD_CTRL_MSG,
        static_cast<void*>(&para), sizeof(tsdrv_ctrl_msg), static_cast<void*>(&queryAck), &ackCount);
    COND_RETURN_ERROR_MSG_CALL(ERR_MODULE_DRV, drvRet != DRV_ERROR_NONE, RT_GET_DRV_ERRCODE(drvRet),
        "[drv api] halTsdrvCtl device_id=%u, ts_id=%u, target_id=%u, drvRetCode=%d.",
        deviceId, tsId, targetId, static_cast<int32_t>(drvRet));
    COND_RETURN_ERROR_MSG_CALL(ERR_MODULE_DRV, (ackCount != sizeof(ts_ctrl_msg_body_t)),
        RT_GET_DRV_ERRCODE(DRV_ERROR_PARA_ERROR),
        "[drv api] halTsdrvCtl device_id=%u, ts_id=%u, target_id=%u, drvRetCode=%d.",
        deviceId, tsId, targetId, static_cast<int32_t>(drvRet));
    status = queryAck.u.query_abort_ack_info.status;

    return RT_ERROR_NONE;
}

rtError_t NpuDriver::RecoverAbortByType(const uint32_t deviceId, const uint32_t tsId, const uint32_t opType,
    const uint32_t targetId, uint32_t &result)
{
    ts_ctrl_msg_body_t recoverIn = {};
    ts_ctrl_msg_body_t recoverAck = {};
    size_t ackCount = sizeof(ts_ctrl_msg_body_t);
    COND_RETURN_ERROR((opType >= OP_INVALID), RT_ERROR_INVALID_VALUE, "Invalid recover param");
    recoverIn.type = opType;
    if (opType == OP_RECOVER_STREAM) {
        recoverIn.u.recover_stream_info.sq_id = targetId;
    }

    struct tsdrv_ctrl_msg para;
    para.tsid = tsId;
    para.msg_len = sizeof(ts_ctrl_msg_body_t);
    para.msg = static_cast<void*>(&recoverIn);

    COND_RETURN_WARN(&halTsdrvCtl == nullptr, RT_ERROR_DRV_NOT_SUPPORT,
        "[drv api] halTsdrvCtl does not exist.");
    RT_LOG(RT_LOG_INFO, "device_id=%u, op_type=%u, target_id=%u.", deviceId, opType, targetId);
    const drvError_t drvRet = halTsdrvCtl(deviceId, TSDRV_CTL_CMD_CTRL_MSG,
        static_cast<void*>(&para), sizeof(tsdrv_ctrl_msg), static_cast<void*>(&recoverAck), &ackCount);
    COND_RETURN_ERROR_MSG_CALL(ERR_MODULE_DRV, drvRet != DRV_ERROR_NONE, RT_GET_DRV_ERRCODE(drvRet),
        "device_id=%u, ts_id=%u, target_id=%u, drvRetCode=%d.", deviceId, tsId, targetId, static_cast<int32_t>(drvRet));
    if (opType == OP_RECOVER_STREAM) {
        result = recoverAck.u.recover_stream_info.result;
    } else if (opType == OP_RECOVER_APP) {
        result = recoverAck.u.recover_app_info.result;
    }

    return RT_ERROR_NONE;
}

rtError_t NpuDriver::QueryRecoverStatusByType(const uint32_t deviceId, const uint32_t tsId, const uint32_t queryType,
    const uint32_t targetId, uint32_t &status)
{
    ts_ctrl_msg_body_t queryIn = {};
    ts_ctrl_msg_body_t queryAck = {};
    size_t ackCount = sizeof(ts_ctrl_msg_body_t);
    queryIn.type = OP_QUERY_RECOVER_STATUS;
    queryIn.u.query_abort_info.choice = queryType;
    queryIn.u.query_abort_info.target_id = targetId;

    struct tsdrv_ctrl_msg para;
    para.tsid = tsId;
    para.msg_len = sizeof(ts_ctrl_msg_body_t);
    para.msg = static_cast<void*>(&queryIn);

    COND_RETURN_WARN(&halTsdrvCtl == nullptr, RT_ERROR_DRV_NOT_SUPPORT,
        "[drv api] halTsdrvCtl does not exist.");
    RT_LOG(RT_LOG_INFO, "device_id=%u, ts_id=%u, target_id=%u.", deviceId, tsId, targetId);
    const drvError_t drvRet = halTsdrvCtl(deviceId, TSDRV_CTL_CMD_CTRL_MSG,
        static_cast<void*>(&para), sizeof(tsdrv_ctrl_msg), static_cast<void*>(&queryAck), &ackCount);
    COND_RETURN_ERROR_MSG_CALL(ERR_MODULE_DRV, drvRet != DRV_ERROR_NONE, RT_GET_DRV_ERRCODE(drvRet),
        "[drv api] halTsdrvCtl device_id=%u, ts_id=%u, target_id=%u, drvRetCode=%d.",
        deviceId, tsId, targetId, static_cast<int32_t>(drvRet));
    COND_RETURN_ERROR_MSG_CALL(ERR_MODULE_DRV, (ackCount != sizeof(ts_ctrl_msg_body_t)),
        RT_GET_DRV_ERRCODE(DRV_ERROR_PARA_ERROR),
        "[drv api] halTsdrvCtl device_id=%u, ts_id=%u, target_id=%u, drvRetCode=%d.",
        deviceId, tsId, targetId, static_cast<int32_t>(drvRet));
    status = queryAck.u.query_abort_ack_info.status;

    return RT_ERROR_NONE;
}

rtError_t NpuDriver::MemUceRepair(const uint32_t deviceId, rtMemUceInfo *memUceInfo)
{
    drvError_t drvRet = DRV_ERROR_NONE;

    COND_RETURN_WARN(&halMemCtl == nullptr, RT_ERROR_FEATURE_NOT_SUPPORT,
        "[drv api] halMemCtl does not exist");

    drvRet = halMemCtl(static_cast<int32_t>(RtCtrlType::RT_CTRL_TYPE_MEM_REPAIR),
                       static_cast<void *>(memUceInfo), sizeof(rtMemUceInfo), nullptr, nullptr);
    COND_RETURN_WARN(drvRet == DRV_ERROR_NOT_SUPPORT, RT_ERROR_FEATURE_NOT_SUPPORT,
        "[drv api] halMemCtl does not support.");
    if (drvRet != DRV_ERROR_NONE) {
        DRV_ERROR_PROCESS(drvRet, "[drv api]halMemCtl failed. drvRetCode=%d, drv devId=%u.",
            static_cast<int32_t>(drvRet), deviceId);
    }

    return RT_GET_DRV_ERRCODE(drvRet);
}

rtError_t NpuDriver::ResourceReset(const uint32_t deviceId, const uint32_t tsId, drvIdType_t type)
{
    struct halResourceIdInputInfo in = {};
    in.type = type;
    in.tsId = tsId;
    in.resourceId = MAX_UINT32_NUM;
    struct halResourceConfigInfo configInfo = {};

    COND_RETURN_WARN(&halResourceConfig == nullptr, RT_ERROR_DRV_NOT_SUPPORT,
        "[drv api] halResourceConfig does not exist");
    const errno_t rc = memset_s(&configInfo, sizeof(halResourceConfigInfo), 0, sizeof(halResourceConfigInfo));
    COND_LOG(rc != EOK, "memset_s failed, size=%zu(bytes), retCode=%d!", sizeof(halResourceConfigInfo), rc);
    configInfo.prop = DRV_ID_RESET;

    const drvError_t ret = halResourceConfig(deviceId, &in, &configInfo);
    if (ret != DRV_ERROR_NONE) {
        DRV_ERROR_PROCESS(ret, "[drv api] halResourceConfig fail, device_id=%u, ts_id=%u ", deviceId, tsId);
        return RT_GET_DRV_ERRCODE(ret);
    }

    if ((type == DRV_NOTIFY_ID) || (type == DRV_CNT_NOTIFY_ID)) {
        in.res[1U] = static_cast<uint32_t>(TSDRV_FLAG_REMOTE_ID);
        const drvError_t drvRet = halResourceConfig(deviceId, &in, &configInfo);
        if (drvRet != DRV_ERROR_NONE) {
            DRV_ERROR_PROCESS(drvRet, "[drv api] remote notify reset fail, drv devId=%u, ts_id=%u ", deviceId, tsId);
            return RT_GET_DRV_ERRCODE(drvRet);
        }
    }
    RT_LOG(RT_LOG_INFO, "reset success: drv devId=%u, tsId=%u, type=%u.", deviceId, tsId, type);
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::GetMaxStreamAndTask(const uint32_t deviceId, const uint32_t tsId, uint32_t * const maxStrCount)
{
    struct halResourceInfo queryInfoInput;
    queryInfoInput.capacity = 0U;
    COND_RETURN_INFO(&halResourceInfoQuery == nullptr, RT_ERROR_NONE, "[drv api] halResourceInfoQuery does not exist.");
    const Runtime * const rt = Runtime::Instance();
    drvError_t drvRet;

    if (rt->ChipIsHaveStars()) {
        drvRet = halResourceInfoQuery(deviceId, tsId, DRV_RESOURCE_SQ_ID, &queryInfoInput);
        if (drvRet != DRV_ERROR_NONE) {
            DRV_ERROR_PROCESS(drvRet, "[driver interface] halResourceInfoQuery sq failed: device_id=%u, "
                "ts_id=%u, drvRetCode=%d!", deviceId, tsId, static_cast<int32_t>(drvRet));
            return RT_GET_DRV_ERRCODE(drvRet);
        }
    } else {
        drvRet = halResourceInfoQuery(deviceId, tsId, DRV_RESOURCE_STREAM_ID, &queryInfoInput);
        if (drvRet != DRV_ERROR_NONE) {
            DRV_ERROR_PROCESS(drvRet, "[driver interface] halResourceInfoQuery streamid failed: device_id=%u, "
                "ts_id=%u, drvRetCode=%d!", deviceId, tsId, static_cast<int32_t>(drvRet));
            return RT_GET_DRV_ERRCODE(drvRet);
        }
    }

    *maxStrCount = queryInfoInput.capacity;
    RT_LOG(RT_LOG_INFO, "deviceId=%u, tsId=%u, streamCount=%u.", deviceId, tsId, *maxStrCount);

    return RT_ERROR_NONE;
}

rtError_t NpuDriver::GetAvailStreamNum(const uint32_t deviceId, const uint32_t tsId, uint32_t * const streamCount)
{
    struct halResourceInfo queryInfoInput;
    queryInfoInput.capacity = 0U;
    COND_RETURN_INFO(halResourceInfoQuery == nullptr, RT_ERROR_NONE, "[drv api] halResourceInfoQuery does not exist.");
    const Runtime * const rt = Runtime::Instance();
    drvError_t drvRet;

    if (rt->ChipIsHaveStars()) {
        drvRet = halResourceInfoQuery(deviceId, tsId, DRV_RESOURCE_SQ_ID, &queryInfoInput);
        if (drvRet != DRV_ERROR_NONE) {
            DRV_ERROR_PROCESS(drvRet, "[driver interface] halResourceInfoQuery sq failed: device_id=%u, "
                "ts_id=%u, drvRetCode=%d!", deviceId, tsId, static_cast<int32_t>(drvRet));
            return RT_GET_DRV_ERRCODE(drvRet);
        }
    } else {
        drvRet = halResourceInfoQuery(deviceId, tsId, DRV_RESOURCE_STREAM_ID, &queryInfoInput);
        if (drvRet != DRV_ERROR_NONE) {
            DRV_ERROR_PROCESS(drvRet, "[driver interface] halResourceInfoQuery streamid failed: device_id=%u, "
                "ts_id=%u, drvRetCode=%d!", deviceId, tsId, static_cast<int32_t>(drvRet));
            return RT_GET_DRV_ERRCODE(drvRet);
        }
    }

    *streamCount = queryInfoInput.capacity - queryInfoInput.usedNum;
    RT_LOG(RT_LOG_INFO, "deviceId=%u, tsId=%u, availStreamCount=%u.", deviceId, tsId, *streamCount);

    return RT_ERROR_NONE;
}

rtError_t NpuDriver::GetAvailEventNum(const uint32_t deviceId, const uint32_t tsId, uint32_t * const eventCount)
{
    struct halResourceInfo queryInfoInput;
    queryInfoInput.capacity = 0U;
    COND_RETURN_INFO(&halResourceInfoQuery == nullptr, RT_ERROR_NONE, "[drv api] halResourceInfoQuery does not exist.");
    const drvError_t drvRet = halResourceInfoQuery(deviceId, tsId,
        IsSupportFeature(RtOptionalFeatureType::RT_FEATURE_DEVICE_NOTIFY_ONLY) ? DRV_RESOURCE_NOTIFY_ID : DRV_RESOURCE_EVENT_ID,
        &queryInfoInput);

    if (drvRet != DRV_ERROR_NONE) {
        DRV_ERROR_PROCESS(drvRet, "[driver interface] halResourceInfoQuery sq failed: device_id=%u, "
            "ts_id=%u, drvRetCode=%d!", deviceId, tsId, static_cast<int32_t>(drvRet));
        return RT_GET_DRV_ERRCODE(drvRet);
    }

    *eventCount = queryInfoInput.capacity - queryInfoInput.usedNum;
    RT_LOG(RT_LOG_INFO, "deviceId=%u, tsId=%u, availEventCount=%u", deviceId, tsId, *eventCount);

    return RT_ERROR_NONE;
}

rtError_t NpuDriver::GetMaxModelNum(const uint32_t deviceId, const uint32_t tsId, uint32_t *maxModelCount)
{
    RT_LOG(RT_LOG_INFO, "get MaxModel. deviceId=%u, task=%u", deviceId, tsId);

    struct halResourceInfo queryInfoInput;
    queryInfoInput.capacity = 0U;
    COND_RETURN_INFO(halResourceInfoQuery == nullptr, RT_ERROR_NONE, "[drv api] halResourceInfoQuery does not exist.");
    const drvError_t drvRet = halResourceInfoQuery(deviceId, tsId, DRV_RESOURCE_MODEL_ID, &queryInfoInput);
    if (drvRet != DRV_ERROR_NONE) {
        DRV_ERROR_PROCESS(drvRet, "[driver interface] halResourceInfoQuery modelid failed: device_id=%u, "
            "ts_id=%u, drvRetCode=%d!", deviceId, tsId, static_cast<int32_t>(drvRet));
        return RT_GET_DRV_ERRCODE(drvRet);
    }
    *maxModelCount = queryInfoInput.capacity;
    RT_LOG(RT_LOG_DEBUG, "GetMaxModelNum=%u.", *maxModelCount);

    return RT_ERROR_NONE;
}

// timeoutInterval: op execut timeout interval, uint:ns
rtError_t NpuDriver::QueryOpExecTimeoutInterval(const uint32_t deviceId, const uint32_t tsId,
    uint64_t &timeoutInterval)
{
    ts_ctrl_msg_body_t timeoutIn = {};
    ts_ctrl_msg_body_t timeoutAck = {};
    size_t ackCount = sizeof(ts_ctrl_msg_body_t);

    timeoutIn.type = OP_QUERY_OP_EXEC_TIMEOUT_INTERVAL;
    struct tsdrv_ctrl_msg para;
    para.tsid = tsId;
    para.msg_len = sizeof(ts_ctrl_msg_body_t);
    para.msg = static_cast<void*>(&timeoutIn);

    COND_RETURN_WARN(&halTsdrvCtl == nullptr, RT_ERROR_DRV_NOT_SUPPORT,
        "[drv api] halTsdrvCtl does not exist.");
    const drvError_t drvRet = halTsdrvCtl(deviceId, TSDRV_CTL_CMD_CTRL_MSG,
        static_cast<void*>(&para), sizeof(tsdrv_ctrl_msg), static_cast<void*>(&timeoutAck), &ackCount);
    COND_RETURN_ERROR_MSG_CALL(ERR_MODULE_DRV, drvRet != DRV_ERROR_NONE, RT_GET_DRV_ERRCODE(drvRet),
        "device_id=%u, ts_id=%u, drvRetCode=%d.", deviceId, tsId, static_cast<int32_t>(drvRet));
    
    timeoutInterval = static_cast<uint64_t>(timeoutAck.u.query_op_exec_timeout_ack_info.timeout_interval_l) |
        (static_cast<uint64_t>(timeoutAck.u.query_op_exec_timeout_ack_info.timeout_interval_h) << 32U);
    RT_LOG(RT_LOG_INFO, "device_id=%u, ts_id=%u, op execute timeoutInterval=%" PRIu64 "ns.",
        deviceId, tsId, timeoutInterval);

    return RT_ERROR_NONE;
}

rtError_t NpuDriver::QuerySq(const uint32_t deviceId, const uint32_t tsId, const uint32_t sqId,
		             const uint32_t queryType, uint32_t &status)
{
    ts_ctrl_msg_body_t queryIn = {};
    ts_ctrl_msg_body_t queryAck = {};
    size_t ackCount = sizeof(ts_ctrl_msg_body_t);
    queryIn.type = OP_QUERY_ABORT_STATUS;
    queryIn.u.query_task_info.choice = queryType;
    queryIn.u.query_task_info.sq_id = sqId;

    struct tsdrv_ctrl_msg para;
    para.tsid = tsId;
    para.msg_len = sizeof(ts_ctrl_msg_body_t);
    para.msg = static_cast<void*>(&queryIn);

    COND_RETURN_WARN(&halTsdrvCtl == nullptr, RT_ERROR_DRV_NOT_SUPPORT,
        "[drv api] halTsdrvCtl does not exist.");
    RT_LOG(RT_LOG_INFO, "deviceId=%u, tsId=%u, sqId=%u.", deviceId, tsId, sqId);
    const drvError_t drvRet = halTsdrvCtl(deviceId, TSDRV_CTL_CMD_CTRL_MSG,
        static_cast<void*>(&para), sizeof(tsdrv_ctrl_msg), static_cast<void*>(&queryAck), &ackCount);
    COND_RETURN_ERROR_MSG_CALL(ERR_MODULE_DRV, drvRet != DRV_ERROR_NONE, RT_GET_DRV_ERRCODE(drvRet),
        "[drv api] halTsdrvCtl device_id=%u, ts_id=%u, sq_id=%u, drvRetCode=%d.",
        deviceId, tsId, sqId, static_cast<int32_t>(drvRet));
    COND_RETURN_ERROR_MSG_CALL(ERR_MODULE_DRV, (ackCount != sizeof(ts_ctrl_msg_body_t)),
        RT_GET_DRV_ERRCODE(DRV_ERROR_PARA_ERROR),
        "[drv api] halTsdrvCtl device_id=%u, ts_id=%u, sq_id=%u, drvRetCode=%d.",
        deviceId, tsId, sqId, static_cast<int32_t>(drvRet));
    status = queryAck.u.query_task_ack_info.status;

    return RT_ERROR_NONE;
}

rtError_t NpuDriver::GetSqHead(const uint32_t deviceId, const uint32_t tsId, const uint32_t sqId, uint16_t &head, bool needLog)
{
    UNUSED(needLog);

    struct halSqCqQueryInfo queryInfoIn = {};
    queryInfoIn.type = DRV_NORMAL_TYPE;
    queryInfoIn.tsId = tsId;
    queryInfoIn.sqId = sqId;
    queryInfoIn.cqId = 0U;
    queryInfoIn.prop = DRV_SQCQ_PROP_SQ_HEAD;

    COND_RETURN_WARN(&halSqCqQuery == nullptr, RT_ERROR_DRV_NOT_SUPPORT, "[drv api] halSqCqQuery does not exist");

    uint32_t retryCount = 0U;

    while (retryCount < GET_SQ_HEAD_MAX_RETRY_TIMES) {
        const drvError_t drvRet = halSqCqQuery(deviceId, &queryInfoIn);
        COND_RETURN_ERROR_MSG_CALL(ERR_MODULE_DRV, drvRet != DRV_ERROR_NONE, RT_GET_DRV_ERRCODE(drvRet),
            "[drv api] halSqCqQuery device_id=%u, ts_id=%u, sq_id=%u, drvRetCode=%d.", deviceId, tsId, sqId,
            static_cast<int32_t>(drvRet));

        head = static_cast<uint16_t>(queryInfoIn.value[0] & 0xFFFFU);
        if (head != 0xFFFFU) {
            break;
        }

        retryCount++;
    }

    if (retryCount != 0U) {
        if (retryCount > sqHeadRetryMaxNum_.Value()) {
            sqHeadRetryMaxNum_.Set(retryCount);
        }

        if (sqHeadQueryFailNum_.Value() % GET_SQ_HEAD_QUERY_FAIL_STAT_TIMES == 0U) {
            RT_LOG(RT_LOG_EVENT, "deviceId=%u, tsId=%u, sqId=%u, head=%hu, "
                "current retryCount=%u, max retryCount=%u, query fail num=%u.",
                deviceId, tsId, sqId, head, retryCount, sqHeadRetryMaxNum_.Value(),
                sqHeadQueryFailNum_.Value());
        }

        sqHeadQueryFailNum_.Add(1U);
    }

    return RT_ERROR_NONE;
}

rtError_t NpuDriver::GetSqTail(const uint32_t deviceId, const uint32_t tsId, const uint32_t sqId, uint16_t &tail)
{
    struct halSqCqQueryInfo queryInfoIn = {};
    queryInfoIn.type = DRV_NORMAL_TYPE;
    queryInfoIn.tsId = tsId;
    queryInfoIn.sqId = sqId;
    queryInfoIn.cqId = 0U;
    queryInfoIn.prop = DRV_SQCQ_PROP_SQ_TAIL;

    COND_RETURN_WARN(&halSqCqQuery == nullptr, RT_ERROR_DRV_NOT_SUPPORT, "[drv api] halSqCqQuery does not exist.");

    uint32_t retryCount = 0U;

    while (retryCount < GET_SQ_HEAD_MAX_RETRY_TIMES) {
        const drvError_t drvRet = halSqCqQuery(deviceId, &queryInfoIn);
        COND_RETURN_ERROR_MSG_CALL(ERR_MODULE_DRV, drvRet != DRV_ERROR_NONE, RT_GET_DRV_ERRCODE(drvRet),
            "[drv api] halSqCqQuery device_id=%u, ts_id=%u, sq_id=%u, drvRetCode=%d.", deviceId, tsId, sqId,
            static_cast<int32_t>(drvRet));

        tail = static_cast<uint16_t>(queryInfoIn.value[0] & 0xFFFFU);
        if (tail != 0xFFFFU) {
            break;
        }

        retryCount++;
    }

    if (retryCount != 0U) {
        if (retryCount > sqTailRetryMaxNum_.Value()) {
            sqTailRetryMaxNum_.Set(retryCount);
        }

        if (sqTailQueryFailNum_.Value() % GET_SQ_HEAD_QUERY_FAIL_STAT_TIMES == 0U) {
            RT_LOG(RT_LOG_EVENT, "deviceId=%u, tsId=%u, sqId=%u, tail=%hu, "
                "current retryCount=%u, max retryCount=%u, query fail num=%u.",
                deviceId, tsId, sqId, tail, retryCount, sqTailRetryMaxNum_.Value(),
                sqTailQueryFailNum_.Value());
        }

        sqTailQueryFailNum_.Add(1U);
    } else {
        static uint16_t lastTail = 0U;
        static uint32_t readCount = 0U;

        readCount++;
        if (lastTail != tail) {
            lastTail = tail;
            RT_LOG(RT_LOG_INFO, "deviceId=%u, tsId=%u, sqId=%u, tail=%u, readCount=%u.", deviceId, tsId, sqId,
                queryInfoIn.value[0], readCount);
            readCount = 0U;
        }
    }

    return RT_ERROR_NONE;
}

rtError_t NpuDriver::GetSqEnable(const uint32_t deviceId, const uint32_t tsId, const uint32_t sqId, bool &enable)
{
    struct halSqCqQueryInfo queryInfoIn = {};
    queryInfoIn.type = DRV_NORMAL_TYPE;
    queryInfoIn.tsId = tsId;
    queryInfoIn.sqId = sqId;
    queryInfoIn.cqId = 0U;
    queryInfoIn.prop = DRV_SQCQ_PROP_SQ_STATUS ;
    static uint16_t lastSqEnableStatus = UINT16_MAX;
    static uint32_t readCount = 0U;

    COND_RETURN_WARN(&halSqCqQuery == nullptr, RT_ERROR_DRV_NOT_SUPPORT, "[drv api] halSqCqQuery does not exist.");
    const drvError_t drvRet = halSqCqQuery(deviceId, &queryInfoIn);
    COND_RETURN_ERROR_MSG_CALL(ERR_MODULE_DRV, drvRet != DRV_ERROR_NONE, RT_GET_DRV_ERRCODE(drvRet),
        "[drv api] halSqCqQuery device_id=%u, ts_id=%u, sq_id=%u, drvRetCode=%d.", deviceId, tsId, sqId,
        static_cast<int32_t>(drvRet));

    enable = (queryInfoIn.value[0] != 0U) ? true : false;
    readCount++;
    if (lastSqEnableStatus != enable) {
        lastSqEnableStatus = enable;
        RT_LOG(RT_LOG_INFO, "deviceId=%u, tsId=%u, sqId=%u, enable=%u, readCount=%u.", deviceId, tsId, sqId,
            queryInfoIn.value[0], readCount);
        readCount = 0U;
    }

    return RT_ERROR_NONE;
}

rtError_t NpuDriver::GetCqeStatus(const uint32_t deviceId, const uint32_t tsId, const uint32_t sqId, bool &status)
{
    struct halSqCqQueryInfo queryInfoIn = {};
    queryInfoIn.type = DRV_NORMAL_TYPE;
    queryInfoIn.tsId = tsId;
    queryInfoIn.sqId = sqId;
    queryInfoIn.cqId = 0U;
    queryInfoIn.prop = DRV_SQCQ_PROP_SQ_CQE_STATUS;

    COND_RETURN_WARN(&halSqCqQuery == nullptr, RT_ERROR_DRV_NOT_SUPPORT, "[drv api] halSqCqQuery does not exist.");
    const drvError_t drvRet = halSqCqQuery(deviceId, &queryInfoIn);
    COND_RETURN_ERROR_MSG_CALL(ERR_MODULE_DRV, drvRet != DRV_ERROR_NONE, RT_GET_DRV_ERRCODE(drvRet),
        "[drv api] halSqCqQuery device_id=%u, ts_id=%u, sq_id=%u, drvRetCode=%d.", deviceId, tsId, sqId,
        static_cast<int32_t>(drvRet));

    status = (queryInfoIn.value[0] != 0U) ? true : false;
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::GetCtrlSqHead(const uint32_t deviceId, const uint32_t tsId, const uint32_t sqId, uint16_t &head)
{
    struct halSqCqQueryInfo queryInfoIn = {};
    queryInfoIn.type = DRV_CTRL_TYPE;
    queryInfoIn.tsId = tsId;
    queryInfoIn.sqId = sqId;
    queryInfoIn.cqId = 0U;
    queryInfoIn.prop = DRV_SQCQ_PROP_SQ_HEAD;

    COND_RETURN_WARN(&halSqCqQuery == nullptr, RT_ERROR_DRV_NOT_SUPPORT, "[drv api] halSqCqQuery does not exist");
    const drvError_t drvRet = halSqCqQuery(deviceId, &queryInfoIn);
    COND_RETURN_ERROR_MSG_CALL(ERR_MODULE_DRV, drvRet != DRV_ERROR_NONE, RT_GET_DRV_ERRCODE(drvRet),
        "[drv api] for head, halSqCqQuery device_id=%u, ts_id=%u, sq_id=%u, drvRetCode=%d.", deviceId, tsId, sqId,
        static_cast<int32_t>(drvRet));

    head = static_cast<uint16_t>(queryInfoIn.value[0] & 0xFFFFU);
    RT_LOG(RT_LOG_DEBUG, "device_id=%u, ts_id=%u, sq_id=%u, head=%hu", deviceId, tsId, sqId, head);

    return RT_ERROR_NONE;
}

rtError_t NpuDriver::SetSqHead(const uint32_t deviceId, const uint32_t tsId,
                               const uint32_t sqId, const uint32_t head)
{
    struct halSqCqConfigInfo configInfo;
    configInfo.type = DRV_NORMAL_TYPE;
    configInfo.tsId = tsId;
    configInfo.sqId = sqId;
    configInfo.prop = DRV_SQCQ_PROP_SQ_HEAD;
    configInfo.value[0] = head;

    COND_RETURN_WARN(&halSqCqConfig == nullptr, RT_ERROR_DRV_NOT_SUPPORT,
        "[drv api] halSqCqConfig does not exist.");
    RT_LOG(RT_LOG_INFO, "deviceId=%u, tsId=%u, sqId=%u, head=%u.", deviceId, tsId, sqId, head);
    const drvError_t drvRet = halSqCqConfig(deviceId, &configInfo);
    if (drvRet != DRV_ERROR_NONE) {
        DRV_ERROR_PROCESS(drvRet,
            "[drv api] halSqCqConfig DRV_NORMAL_TYPE DRV_SQCQ_PROP_SQ_STATUS value=%u, "
            "device_id=%u, ts_id=%u, sq_id=%u, drvRetCode=%d.",
            head, deviceId, tsId, sqId, static_cast<int32_t>(drvRet));
        return RT_GET_DRV_ERRCODE(drvRet);
    }

    return RT_ERROR_NONE;
}

rtError_t NpuDriver::CleanSq(const uint32_t deviceId, const uint32_t tsId, const uint32_t sqId)
{
    struct halSqCqConfigInfo configInfo;
    configInfo.type = DRV_NORMAL_TYPE;
    configInfo.tsId = tsId;
    configInfo.sqId = sqId;
    configInfo.prop = DRV_SQCQ_PROP_SQ_PAUSE;

    COND_RETURN_WARN(&halSqCqConfig == nullptr, RT_ERROR_DRV_NOT_SUPPORT,
        "[drv api] halSqCqConfig does not exist.");
    RT_LOG(RT_LOG_INFO, "deviceId=%u, tsId=%u, sqId=%u.", deviceId, tsId, sqId);
    const drvError_t drvRet = halSqCqConfig(deviceId, &configInfo);
    if (drvRet != DRV_ERROR_NONE) {
        DRV_ERROR_PROCESS(drvRet,
            "device_id=%u, ts_id=%u, sq_id=%u, drvRetCode=%d.",
            deviceId, tsId, sqId, static_cast<int32_t>(drvRet));
        return RT_GET_DRV_ERRCODE(drvRet);
    }

    return RT_ERROR_NONE;
}

rtError_t NpuDriver::StreamUnBindLogicCq(const uint32_t deviceId, const uint32_t tsId,
                                         const uint32_t streamId, const uint32_t logicCqId,
                                         const uint32_t drvFlag)
{
    struct halResourceIdInputInfo in;
    in.type = DRV_STREAM_ID;
    in.tsId = tsId;
    in.resourceId = streamId;
    in.res[1U] = drvFlag;

    struct halResourceConfigInfo configInfo;
    configInfo.prop = DRV_STREAM_UNBIND_LOGIC_CQ;

    const drvError_t drvRet = halResourceConfig(deviceId, &in, &configInfo);
    if (drvRet != DRV_ERROR_NONE) {
        DRV_ERROR_PROCESS(drvRet, "[drv api] halResourceConfig fail, device_id=%u, ts_id=%u, stream_id=%u, "
            "logicCq=%u, drvRetCode=%d.", deviceId, tsId, streamId, logicCqId, static_cast<int32_t>(drvRet));
        return RT_GET_DRV_ERRCODE(drvRet);
    }

    RT_LOG(RT_LOG_INFO, "success: deviceId=%u, tsId=%u, streamId=%u, logicCq=%u.",
        deviceId, tsId, streamId, logicCqId);

    return RT_ERROR_NONE;
}

rtError_t NpuDriver::StreamBindLogicCq(const uint32_t deviceId, const uint32_t tsId,
                                       const uint32_t streamId, const uint32_t logicCqId,
                                       const uint32_t drvFlag)
{
    struct halResourceIdInputInfo in = {};
    in.type = DRV_STREAM_ID;
    in.tsId = tsId;
    in.resourceId = streamId;
    in.res[1U] = drvFlag;

    struct halResourceConfigInfo configInfo = {};
    configInfo.prop = DRV_STREAM_BIND_LOGIC_CQ;
    configInfo.value[0U] = logicCqId;   // res[0]: logicCqId

    const drvError_t drvRet = halResourceConfig(deviceId, &in, &configInfo);
    COND_RETURN_ERROR_MSG_CALL(ERR_MODULE_DRV, drvRet != DRV_ERROR_NONE, RT_GET_DRV_ERRCODE(drvRet),
        "[drv api] halResourceConfig fail, device_id=%u, ts_id=%u, stream_id=%u, logicCq=%u, drvRetCode=%d.",
        deviceId, tsId, streamId, logicCqId, static_cast<int32_t>(drvRet));

    RT_LOG(RT_LOG_INFO, "success: deviceId=%u, tsId=%u, streamId=%u, logicCq=%u.",
        deviceId, tsId, streamId, logicCqId);

    return RT_ERROR_NONE;
}

rtError_t NpuDriver::StreamEnableStmSyncEsched(const uint32_t deviceId, const uint32_t tsId,
                                               const uint32_t streamId, const uint32_t grpId,
                                               const uint32_t eventId)
{
    struct halResourceIdInputInfo in = {};
    in.type = DRV_STREAM_ID;
    in.tsId = tsId;
    in.resourceId = streamId;
    struct halResourceConfigInfo configInfo = {};

    COND_RETURN_WARN(&halResourceConfig == nullptr, RT_ERROR_DRV_NOT_SUPPORT,
        "[drv api] halResourceConfig does not exist");
    const errno_t rc = memset_s(&configInfo, sizeof(halResourceConfigInfo), 0, sizeof(halResourceConfigInfo));
    COND_LOG(rc != EOK, "memset_s failed, size=%zu(bytes), retCode=%d!", sizeof(halResourceConfigInfo), rc);
    configInfo.prop = DRV_STREAM_ENABLE_EVENT;
    configInfo.value[0U] = grpId;
    configInfo.value[1U] = eventId;
    const drvError_t drvRet = halResourceConfig(deviceId, &in, &configInfo);
    if (drvRet != DRV_ERROR_NONE) {
        DRV_ERROR_PROCESS(drvRet, "[drv api] halResourceConfig fail, device_id=%u, ts_id=%u, stream_id=%u, "
            "grpId=%u, eventId=%u, drvRetCode=%d.", deviceId, tsId, streamId, grpId,
            eventId, static_cast<int32_t>(drvRet));
        return RT_GET_DRV_ERRCODE(drvRet);
    }

    RT_LOG(RT_LOG_INFO, "success: deviceId=%u, tsId=%u, streamId=%u, grpId=%u, eventId=%u.",
        deviceId, tsId, streamId, grpId, eventId);
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::UnbindHostPid(rtBindHostpidInfo info)
{
    drvError_t drvRet = DRV_ERROR_NONE;

    COND_RETURN_WARN(&drvUnbindHostPid == nullptr, RT_ERROR_FEATURE_NOT_SUPPORT,
        "[drv api] drvUnbindHostPid does not exist");

    struct drvBindHostpidInfo infoNew = {};
    uint32_t len_new = sizeof(infoNew);
    uint32_t len = sizeof(info);
    errno_t ret = memcpy_s(&infoNew, len_new, &info, len);
    COND_RETURN_ERROR_MSG_CALL(ERR_MODULE_SYSTEM, ret != EOK, RT_ERROR_SEC_HANDLE,
                               "Call memcpy_s failed, dst length=%u, src length=%u, retCode=%d!",
                               len_new, len, ret);

    drvRet = drvUnbindHostPid(infoNew);
    COND_RETURN_WARN(drvRet == DRV_ERROR_NOT_SUPPORT, RT_ERROR_FEATURE_NOT_SUPPORT,
        "[drv api] drvUnbindHostPid does not support.");
    if (drvRet != DRV_ERROR_NONE) {
        DRV_ERROR_PROCESS(drvRet, "[drv api]drvUnbindHostPid failed. drvRetCode=%d.", static_cast<int32_t>(drvRet));
        return RT_GET_DRV_ERRCODE(drvRet);
    }

    return RT_GET_DRV_ERRCODE(drvRet);
}

rtError_t NpuDriver::BindHostPid(rtBindHostpidInfo info)
{
    drvError_t drvRet = DRV_ERROR_NONE;

    COND_RETURN_WARN(&drvBindHostPid == nullptr, RT_ERROR_FEATURE_NOT_SUPPORT,
        "[drv api] drvBindHostPid does not exist");

    struct drvBindHostpidInfo infoNew = {};
    uint32_t len_new = sizeof(infoNew);
    uint32_t len = sizeof(info);
    errno_t ret = memcpy_s(&infoNew, len_new, &info, len);
    COND_RETURN_ERROR_MSG_CALL(ERR_MODULE_SYSTEM, ret != EOK, RT_ERROR_SEC_HANDLE,
                               "Call memcpy_s failed, dst length=%u, src length=%u, retCode=%d!",
                               len_new, len, ret);

    drvRet = drvBindHostPid(infoNew);
    COND_RETURN_WARN(drvRet == DRV_ERROR_NOT_SUPPORT, RT_ERROR_FEATURE_NOT_SUPPORT,
        "[drv api] drvBindHostPid does not support.");
    if (drvRet != DRV_ERROR_NONE) {
        DRV_ERROR_PROCESS(drvRet, "[drv api]drvBindHostPid failed. drvRetCode=%d.", static_cast<int32_t>(drvRet));
        return RT_GET_DRV_ERRCODE(drvRet);
    }

    return RT_GET_DRV_ERRCODE(drvRet);
}

rtError_t NpuDriver::SqSwitchStreamBatch(const uint32_t deviceId, struct sq_switch_stream_info *switchInfo,
    const uint32_t num)
{
    COND_RETURN_WARN(&halSqSwitchStreamBatch == nullptr, RT_ERROR_DRV_NOT_SUPPORT,
        "[drv api] halSqSwitchStreamBatch does not exist.");

    const drvError_t drvRet = halSqSwitchStreamBatch(deviceId, switchInfo, num);
    if (drvRet != DRV_ERROR_NONE) {
        DRV_ERROR_PROCESS(drvRet, "[drv api] halSqSwitchStreamBatch failed: device_id=%u, num=%u, drvRetCode=%d!",
            deviceId, num, static_cast<int32_t>(drvRet));
        return RT_GET_DRV_ERRCODE(drvRet);
    }

    RT_LOG(RT_LOG_INFO, "halSqSwitchStreamBatch success, device_id=%u, num=%u.", deviceId, num);
    return RT_ERROR_NONE;    
}

rtError_t NpuDriver::QueryProcessHostPid(int32_t pid, uint32_t *chipId, uint32_t *vfId, uint32_t *hostPid,
    uint32_t *cpType)
{
    drvError_t drvRet = DRV_ERROR_NONE;

    COND_RETURN_WARN(&drvQueryProcessHostPid == nullptr, RT_ERROR_FEATURE_NOT_SUPPORT,
        "[drv api] drvQueryProcessHostPid does not exist");

    drvRet = drvQueryProcessHostPid(pid, chipId, vfId, hostPid, cpType);
    COND_RETURN_WARN(drvRet == DRV_ERROR_NOT_SUPPORT, RT_ERROR_FEATURE_NOT_SUPPORT,
        "[drv api] drvQueryProcessHostPid does not support.");
    if (drvRet != DRV_ERROR_NONE) {
        DRV_ERROR_PROCESS(drvRet, "[drv api]drvQueryProcessHostPid failed. drvRetCode=%d.",
            static_cast<int32_t>(drvRet));
        return RT_GET_DRV_ERRCODE(drvRet);
    }

    return RT_GET_DRV_ERRCODE(drvRet);
}

rtError_t NpuDriver::ShmemSetPodPid(const char *name, uint32_t sdid, int32_t pid[], int32_t num)
{
    drvError_t drvRet = DRV_ERROR_NONE;

    COND_RETURN_WARN(&halShmemSetPodPid == nullptr, RT_ERROR_FEATURE_NOT_SUPPORT,
        "[drv api] halShmemSetPodPid does not exist");

    drvRet = halShmemSetPodPid(name, sdid, pid, num);
    COND_RETURN_WARN(drvRet == DRV_ERROR_NOT_SUPPORT, RT_ERROR_FEATURE_NOT_SUPPORT,
        "[drv api] halShmemSetPodPid does not support.");
    if (drvRet != DRV_ERROR_NONE) {
        DRV_ERROR_PROCESS(drvRet, "[drv api]halShmemSetPodPid failed. drvRetCode=%d.", static_cast<int32_t>(drvRet));
        return RT_GET_DRV_ERRCODE(drvRet);
    }

    return RT_GET_DRV_ERRCODE(drvRet);
}

rtError_t NpuDriver::ShrIdSetPodPid(const char *name, uint32_t sdid, int32_t pid)
{
    drvError_t drvRet = DRV_ERROR_NONE;

    COND_RETURN_WARN(&halShrIdSetPodPid == nullptr, RT_ERROR_FEATURE_NOT_SUPPORT,
        "[drv api] halShrIdSetPodPid does not exist");

    drvRet = halShrIdSetPodPid(name, sdid, pid);
    COND_RETURN_WARN(drvRet == DRV_ERROR_NOT_SUPPORT, RT_ERROR_FEATURE_NOT_SUPPORT,
        "[drv api] halShrIdSetPodPid does not support.");
    if (drvRet != DRV_ERROR_NONE) {
        DRV_ERROR_PROCESS(drvRet, "[drv api]halShrIdSetPodPid failed. drvRetCode=%d.", static_cast<int32_t>(drvRet));
        return RT_GET_DRV_ERRCODE(drvRet);
    }

    return RT_GET_DRV_ERRCODE(drvRet);
}

rtError_t NpuDriver::ParseSDID(const uint32_t sdid, uint32_t *srvId, uint32_t *chipId, uint32_t *dieId, uint32_t *pyhId)
{
    drvError_t drvRet = DRV_ERROR_NONE;

    COND_RETURN_WARN(&halParseSDID == nullptr, RT_ERROR_FEATURE_NOT_SUPPORT,
        "[drv api] halParseSDID does not exist");

    struct halSDIDParseInfo sdidParse;
    drvRet = halParseSDID(sdid, &sdidParse);
    COND_RETURN_WARN(drvRet == DRV_ERROR_NOT_SUPPORT, RT_ERROR_FEATURE_NOT_SUPPORT,
        "[drv api] halParseSDID does not support.");
    if (drvRet != DRV_ERROR_NONE) {
        DRV_ERROR_PROCESS(drvRet, "[drv api]halParseSDID failed. drvRetCode=%d.", static_cast<int32_t>(drvRet));
        return RT_GET_DRV_ERRCODE(drvRet);
    }
    *srvId = sdidParse.server_id;
    *chipId = sdidParse.chip_id;
    *dieId = sdidParse.die_id;
    *pyhId = sdidParse.udevid;

    return RT_GET_DRV_ERRCODE(drvRet);
}

rtError_t NpuDriver::GetSqRegVirtualAddrBySqid(const int32_t deviceId, const uint32_t tsId, const uint32_t sqId,
                                               uint64_t * const addr, uint32_t * const len)
{
    if (IsSupportFeature(RtOptionalFeatureType::RT_FEATURE_STREAM_MAP_SQ_ADDR_TO_USER_SPACE))  {
        return GetSqRegVirtualAddrBySqidForStarsV2(deviceId, tsId, sqId, addr);
    } else {
        struct halSqCqQueryInfo queryInfoIn = {};
        queryInfoIn.type = DRV_NORMAL_TYPE;
        queryInfoIn.tsId = tsId;
        queryInfoIn.sqId = sqId;
        queryInfoIn.cqId = 0U;
        queryInfoIn.prop = DRV_SQCQ_PROP_SQ_REG_BASE;
        COND_RETURN_WARN(&halSqCqQuery == nullptr, RT_ERROR_DRV_NOT_SUPPORT, "[drv api] halSqCqQuery does not exist");
        const drvError_t drvRet = halSqCqQuery(static_cast<uint32_t>(deviceId), &queryInfoIn);
        COND_RETURN_ERROR_MSG_CALL(ERR_MODULE_DRV, drvRet != DRV_ERROR_NONE, RT_GET_DRV_ERRCODE(drvRet),
                                   "[drv api] halSqCqQuery get SqSimple Virtual Addr failed device_id=%u, ts_id=%u, "
                                   "sq_id=%u, drvRetCode=%d.", deviceId, tsId, sqId, static_cast<int32_t>(drvRet));
        // value[0] is the high 32 bit of virtual addr, value[1] is low 32 bit.
        *addr = (static_cast<uint64_t>(queryInfoIn.value[0]) << 32U) | (static_cast<uint64_t>(queryInfoIn.value[1]));
        // value[2] is addr size.
        *len = queryInfoIn.value[2];
        COND_RETURN_ERROR(*addr == 0ULL, RT_ERROR_DRV_ERR, "[drv api] halSqCqQuery get SqSimple Virtual Addr=0 fail.");
        RT_LOG(RT_LOG_INFO, "addr high 32 bit=0x%x, addr low 32 bit=0x%x, addr=0x%" PRIx64 ", size=%u",
            queryInfoIn.value[0], queryInfoIn.value[1], *addr, queryInfoIn.value[2]);
    }

    return RT_ERROR_NONE;
}

/* ========================================================
 * Subcategory: Resource ID Alloc
 * ======================================================== */

rtError_t NpuDriver::ReAllocResourceId(const uint32_t deviceId, const uint32_t tsId, const uint32_t priority,
                                       const uint32_t resourceId, drvIdType_t idType)
{
    struct halResourceIdInputInfo resAllocInput = {};
    struct halResourceIdOutputInfo resAllocOutput = {};

    resAllocInput.type = idType;
    resAllocInput.tsId = tsId;
    resAllocInput.resourceId = resourceId;
    resAllocInput.res[0U] = priority;
    resAllocInput.res[1U] = TSDRV_RES_SPECIFIED_ID;

    RT_LOG(RT_LOG_INFO, "Realloc id begin, device_id=%u, priority=%u, ts_id=%u, resourceId=%u, idType=%d",
        deviceId, priority, tsId, resourceId, idType);

    const drvError_t drvRet = halResourceIdAlloc(deviceId, &resAllocInput, &resAllocOutput);
    if ((drvRet != DRV_ERROR_NONE) || (resourceId != resAllocOutput.resourceId)) {
        DRV_ERROR_PROCESS(drvRet, "[drv api] halResourceIdAlloc realloc id failed: device_id=%u, priority=%u, "
            "ts_id=%u, resourceId=%u, resAllocOutput.resourceId=%u, idType=%d, drvRetCode=%d",
            deviceId, priority, tsId, resourceId, resAllocOutput.resourceId, idType, static_cast<int32_t>(drvRet));
        return RT_GET_DRV_ERRCODE(drvRet);
    }

    RT_LOG(RT_LOG_DEBUG, "Realloc id succ, device_id=%u, priority=%u, ts_id=%u, resourceId=%u, idType=%d",
        deviceId, priority, tsId, resourceId, idType);
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::StreamIdAlloc(int32_t * const id, const uint32_t deviceId, const uint32_t tsId,
                                   const uint32_t priority, uint32_t streamFlag)
{
    struct halResourceIdInputInfo resAllocInput;
    struct halResourceIdOutputInfo resAllocOutput;

    (void)memset_s(resAllocInput.res, sizeof(resAllocInput.res), 0U, sizeof(resAllocInput.res));
    resAllocInput.type = DRV_STREAM_ID;
    resAllocInput.tsId = tsId;
    resAllocInput.res[0U] = priority;
    uint32_t drvFlag = ((streamFlag & RT_STREAM_CP_PROCESS_USE) != 0U) ?
        static_cast<uint32_t>(TSDRV_FLAG_REMOTE_ID) : 0U;
    if ((IsSupportFeature(RtOptionalFeatureType::RT_FEATURE_DRIVER_RESOURCE_ALLOC_WITH_VFID)) && (vfId_ != MAX_UINT32_NUM)) {
        resAllocInput.res[2U] = vfId_; // used for starsv2 vf scene
        drvFlag |= (static_cast<uint32_t>(TSDRV_RES_RANGE_ID));
    }
    resAllocInput.res[1U] = drvFlag;
    resAllocOutput.resourceId = 0U;

    RT_LOG(RT_LOG_INFO, "stream id alloc begin, device_id=%u, priority=%u, ts_id=%u, remote_stream_id=%u, vf_id=%u",
        deviceId, resAllocInput.res[0U], tsId, resAllocInput.res[1U], resAllocInput.res[2U]);

    const drvError_t drvRet = halResourceIdAlloc(deviceId, &resAllocInput, &resAllocOutput);
    if (drvRet != DRV_ERROR_NONE) {
        DRV_ERROR_PROCESS(drvRet, "[drv api] halResourceIdAlloc streamid failed: device_id=%u, "
            "ts_id=%u, drvRetCode=%d!", deviceId, tsId, static_cast<int32_t>(drvRet));
        return RT_GET_DRV_ERRCODE(drvRet);
    }

    *id = static_cast<int32_t>(resAllocOutput.resourceId);
    RT_LOG(RT_LOG_DEBUG, "Succ, stream_id=%d, priority=%u, device_id=%u, ts_id=%u, streamFlag=%u",
        *id, priority, deviceId, tsId, streamFlag);
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::StreamIdFree(const int32_t id, const uint32_t deviceId, const uint32_t tsId,
                                  const uint32_t streamFlag)
{
    struct halResourceIdInputInfo resFreeInput;

    (void)memset_s(resFreeInput.res, sizeof(resFreeInput.res), 0U, sizeof(resFreeInput.res));
    resFreeInput.type = DRV_STREAM_ID;
    resFreeInput.tsId = tsId;
    resFreeInput.resourceId = static_cast<uint32_t>(id);
    resFreeInput.res[1U] = ((streamFlag & RT_STREAM_CP_PROCESS_USE) != 0U) ?
        static_cast<uint32_t>(TSDRV_FLAG_REMOTE_ID) : 0U;

    RT_LOG(RT_LOG_INFO, "stream id free begin, device_id=%u, stream_id=%u, ts_id=%u, remote_stream_id=%u",
        deviceId, resFreeInput.resourceId, resFreeInput.tsId, resFreeInput.res[1U]);
    const drvError_t drvRet = halResourceIdFree(deviceId, &resFreeInput);
    if (drvRet != DRV_ERROR_NONE) {
        DRV_ERROR_PROCESS(drvRet, "[drv api] halResourceIdFree failed: stream_id=%d, device_id=%u, "
            "ts_id=%u, drvRetCode=%d!", id, deviceId, tsId, static_cast<int32_t>(drvRet));
        return RT_GET_DRV_ERRCODE(drvRet);
    }

    RT_LOG(RT_LOG_INFO, "Stream id free success, stream_id=%d, device_id=%u, tsId=%u, streamFlag=%u",
        id, deviceId, tsId, streamFlag);
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::EventIdAlloc(int32_t * const id, const uint32_t deviceId, const uint32_t tsId,
                                  const uint32_t eventFlag, const bool createFlag)
{
    struct halResourceIdInputInfo resAllocInput;
    struct halResourceIdOutputInfo resAllocOutput;

    (void)memset_s(resAllocInput.res, sizeof(resAllocInput.res), 0U, sizeof(resAllocInput.res));
    resAllocInput.type = DRV_EVENT_ID;
    resAllocInput.tsId = tsId;
    resAllocInput.res[1U] = (eventFlag == static_cast<uint32_t>(RT_EVENT_MC2)) ?
        static_cast<uint32_t>(TSDRV_FLAG_REMOTE_ID) : 0U;
    resAllocOutput.resourceId = 0U;

    drvError_t drvRet = DRV_ERROR_NONE;
    if (!createFlag) {
        drvRet = halResourceIdAlloc(deviceId, &resAllocInput, &resAllocOutput);
    } else {
        int32_t tryCount = 0;
        do {
            RT_LOG(RT_LOG_INFO, "event id alloc begin, device_id=%u, ts_id=%u, remote_event_id=%u",
                deviceId, resAllocInput.tsId, resAllocInput.res[1U]);
            drvRet = halResourceIdAlloc(deviceId, &resAllocInput, &resAllocOutput);
            COND_PROC((drvRet != DRV_ERROR_NONE), tryCount++; (void)mmSleep(50U);)
        } while ((drvRet != DRV_ERROR_NONE) && (tryCount < 10)); // try count 10
    }

    if (drvRet != DRV_ERROR_NONE) {
        if ((drvRet == DRV_ERROR_NO_EVENT_RESOURCES) && (!createFlag)) {
            RT_LOG(RT_LOG_WARNING, "Event id alloc fail, no resources now. device_id=%u, ts_id=%u, eventFlag=%u",
                   deviceId, tsId, eventFlag);
            return RT_ERROR_DRV_NO_EVENT_RESOURCES;
        }
        DRV_ERROR_PROCESS(drvRet, "[drv api] halResourceIdAlloc eventid failed: device_id=%u, ts_id=%u, "
            "drvRetCode=%d!", deviceId, tsId, static_cast<int32_t>(drvRet));
        return RT_GET_DRV_ERRCODE(drvRet);
    }

    *id = static_cast<int32_t>(resAllocOutput.resourceId);
    RT_LOG(RT_LOG_INFO, "Event id alloc success, device_id=%u, ts_id=%u, event_id=%d, eventFlag=%u",
        deviceId, tsId, *id, eventFlag);
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::EventIdFree(const int32_t id, const uint32_t deviceId, const uint32_t tsId,
                                 const uint32_t eventFlag)
{
    TIMESTAMP_NAME(__func__);
    struct halResourceIdInputInfo resFreeInput;

    (void)memset_s(resFreeInput.res, sizeof(resFreeInput.res), 0U, sizeof(resFreeInput.res));
    resFreeInput.type = DRV_EVENT_ID;
    resFreeInput.tsId = tsId;
    resFreeInput.resourceId = static_cast<uint32_t>(id);
    resFreeInput.res[1U] = (eventFlag == static_cast<uint32_t>(RT_EVENT_MC2)) ?
        static_cast<uint32_t>(TSDRV_FLAG_REMOTE_ID) : 0U;

    RT_LOG(RT_LOG_INFO, "event id free begin, device_id=%u, event_id=%u, ts_id=%u, remote_event_id=%u",
        deviceId, resFreeInput.resourceId, resFreeInput.tsId, resFreeInput.res[1U]);
    const drvError_t drvRet = halResourceIdFree(deviceId, &resFreeInput);
    if (drvRet != DRV_ERROR_NONE) {
        DRV_ERROR_PROCESS(drvRet, "[drv api] halResourceIdFree eventid failed: device_id=%u, "
            "ts_id=%u, event_id=%d, drvRetCode=%d!", deviceId, tsId, id, static_cast<int32_t>(drvRet));
        return RT_GET_DRV_ERRCODE(drvRet);
    }
    RT_LOG(RT_LOG_DEBUG, "event id free success, device_id=%u, ts_id=%u, event_id=%d, eventFlag=%u",
        deviceId, tsId, id, eventFlag);
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::CmoIdAlloc(int32_t * const id, const uint32_t deviceId, const uint32_t tsId)
{
    struct halResourceIdInputInfo resAllocInput;
    struct halResourceIdOutputInfo resAllocOutput;

    (void)memset_s(resAllocInput.res, sizeof(resAllocInput.res), 0U, sizeof(resAllocInput.res));
    resAllocInput.type = DRV_CMO_ID;
    resAllocInput.tsId = tsId;
    resAllocOutput.resourceId = 0U;

    const drvError_t drvRet = halResourceIdAlloc(deviceId, &resAllocInput, &resAllocOutput);
    if (drvRet != DRV_ERROR_NONE) {
        DRV_ERROR_PROCESS(drvRet, "[drv api] halResourceIdAlloc cmo id failed: device_id=%u, "
            "ts_id=%u, drvRetCode=%d!", deviceId, tsId, static_cast<int32_t>(drvRet));
        return RT_GET_DRV_ERRCODE(drvRet);
    }

    *id = static_cast<int32_t>(resAllocOutput.resourceId);
    RT_LOG(RT_LOG_INFO, "Cmo id alloc success, cmo_id=%d, device_id=%u, ts_id=%u.", *id, deviceId, tsId);
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::CmoIdFree(const int32_t id, const uint32_t deviceId, const uint32_t tsId)
{
    struct halResourceIdInputInfo resFreeInput;

    (void)memset_s(resFreeInput.res, sizeof(resFreeInput.res), 0U, sizeof(resFreeInput.res));
    resFreeInput.type = DRV_CMO_ID;
    resFreeInput.tsId = tsId;
    resFreeInput.resourceId = static_cast<uint32_t>(id);

    const drvError_t drvRet = halResourceIdFree(deviceId, &resFreeInput);
    if (drvRet != DRV_ERROR_NONE) {
        DRV_ERROR_PROCESS(drvRet, "[drv api] halResourceIdFree failed: cmo_id=%d, device_id=%u, "
            "tsId=%u, drvRetCode=%d!", id, deviceId, tsId, static_cast<int32_t>(drvRet));
        return RT_GET_DRV_ERRCODE(drvRet);
    }

    RT_LOG(RT_LOG_INFO, "Cmo id free success, cmo_id=%d, device_id=%u, tsId=%u.", id, deviceId, tsId);
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::NotifyIdAlloc(const int32_t deviceId, uint32_t * const id, const uint32_t tsId,
                                   const uint32_t notifyFlag, const bool isCountNotify, const bool isEvent)
{
    struct halResourceIdInputInfo  resAllocInput;
    struct halResourceIdOutputInfo  resAllocOutput;

    (void)memset_s(resAllocInput.res, sizeof(resAllocInput.res), 0U, sizeof(resAllocInput.res));
    resAllocInput.type = DRV_NOTIFY_ID;
    if (isCountNotify) {
        resAllocInput.type = DRV_CNT_NOTIFY_ID;
    }
    resAllocInput.tsId = tsId;
    uint32_t drvFlag = (notifyFlag == static_cast<uint32_t>(RT_NOTIFY_MC2)) ?
        static_cast<uint32_t>(TSDRV_FLAG_REMOTE_ID) : 0U;
    if ((IsSupportFeature(RtOptionalFeatureType::RT_FEATURE_DRIVER_RESOURCE_ALLOC_WITH_VFID)) && (vfId_ != MAX_UINT32_NUM)) {
        resAllocInput.res[2U] = vfId_; // used for starsv2 vf scene
        drvFlag |= (static_cast<uint32_t>(TSDRV_RES_RANGE_ID));
    }
    resAllocInput.res[1U] = drvFlag;
    resAllocOutput.resourceId = 0U;

    RT_LOG(RT_LOG_INFO, "notify id alloc begin, device_id=%u, ts_id=%u, remote_notify_id=%u",
        deviceId, resAllocInput.tsId, resAllocInput.res[1U]);
    drvError_t drvRet = halResourceIdAlloc(static_cast<uint32_t>(deviceId), &resAllocInput, &resAllocOutput);
    if (drvRet != DRV_ERROR_NONE) {
        if ((drvRet == DRV_ERROR_NO_NOTIFY_RESOURCES) && isEvent) {
            drvRet = DRV_ERROR_NO_EVENT_RESOURCES;
        }
        return RT_GET_DRV_ERRCODE(drvRet);
    }

    *id = resAllocOutput.resourceId;
    RT_LOG(RT_LOG_INFO, "notify id alloc end, device_id=%d, ts_id=%u, notify_id=%u, notify_flag=%u",
            deviceId, tsId, *id, notifyFlag);

    return RT_ERROR_NONE;
}

TIMESTAMP_EXTERN(halResourceIdFree);
rtError_t NpuDriver::NotifyIdFree(const int32_t deviceId, const uint32_t id, const uint32_t tsId,
                                  const uint32_t notifyFlag, const bool isCountNotify)
{
    struct halResourceIdInputInfo resFreeInput;

    (void)memset_s(resFreeInput.res, sizeof(resFreeInput.res), 0U, sizeof(resFreeInput.res));
    resFreeInput.type = DRV_NOTIFY_ID;
    if (isCountNotify) {
        resFreeInput.type = DRV_CNT_NOTIFY_ID;
    }
    resFreeInput.tsId = tsId;
    resFreeInput.resourceId = id;
    resFreeInput.res[1U] = (notifyFlag == static_cast<uint32_t>(RT_NOTIFY_MC2)) ?
        static_cast<uint32_t>(TSDRV_FLAG_REMOTE_ID) : 0U;

    RT_LOG(RT_LOG_INFO, "NotifyIdFree begin, device_id=%d, notify_id=%u, ts_id=%u, remote_notify_id=%u",
        deviceId, resFreeInput.resourceId, resFreeInput.tsId, resFreeInput.res[1U]);
    TIMESTAMP_BEGIN(halResourceIdFree);
    const drvError_t drvRet = halResourceIdFree(static_cast<uint32_t>(deviceId), &resFreeInput);
    TIMESTAMP_END(halResourceIdFree);
    if (drvRet != DRV_ERROR_NONE) {
        DRV_ERROR_PROCESS(drvRet, "[drv api] halResourceIdFree failed: device_id=%d, id=%u, "
            "drvRetCode=%d!", deviceId, id, static_cast<int32_t>(drvRet));
        return RT_GET_DRV_ERRCODE(drvRet);
    }

    RT_LOG(RT_LOG_INFO, "NotifyIdFree success, device_id=%d, ts_id=%u, notify_id=%u, notify_flag=%u",
            deviceId, tsId, id, notifyFlag);

    return RT_ERROR_NONE;
}

rtError_t NpuDriver::ModelIdAlloc(int32_t * const id, const uint32_t deviceId, const uint32_t tsId)
{
    struct halResourceIdInputInfo  resAllocInput;
    struct halResourceIdOutputInfo  resAllocOutput;

    (void)memset_s(resAllocInput.res, sizeof(resAllocInput.res), 0U, sizeof(resAllocInput.res));
    resAllocInput.type = DRV_MODEL_ID;
    resAllocInput.tsId = tsId;
    resAllocOutput.resourceId = 0U;
    if ((GetDevProperties().resAllocRange != 0) && (vfId_ != MAX_UINT32_NUM)) {
        resAllocInput.res[1U] = GetDevProperties().resAllocRange;
        resAllocInput.res[2U] = vfId_;
    }

    const drvError_t drvRet = halResourceIdAlloc(deviceId, &resAllocInput, &resAllocOutput);
    if (drvRet != DRV_ERROR_NONE) {
        DRV_ERROR_PROCESS(drvRet, "[drv api] model id alloc halResourceIdAlloc failed: device_id=%u, "
            "tsId=%u, drvRetCode=%d!", deviceId, tsId, static_cast<int32_t>(drvRet));
        return RT_GET_DRV_ERRCODE(drvRet);
    }

    *id = static_cast<int32_t>(resAllocOutput.resourceId);
    RT_LOG(RT_LOG_INFO, "Succ, deviceId=%u, tsId=%u, id=%d.", deviceId, tsId, *id);
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::ModelIdFree(const int32_t id, const uint32_t deviceId, const uint32_t tsId)
{
    struct halResourceIdInputInfo resFreeInput;

    (void)memset_s(resFreeInput.res, sizeof(resFreeInput.res), 0U, sizeof(resFreeInput.res));
    resFreeInput.type = DRV_MODEL_ID;
    resFreeInput.tsId = tsId;
    resFreeInput.resourceId = static_cast<uint32_t>(id);

    const drvError_t drvRet = halResourceIdFree(deviceId, &resFreeInput);
    if (drvRet != DRV_ERROR_NONE) {
        DRV_ERROR_PROCESS(drvRet, "[drv api] halResourceIdFree failed: device_id=%u, tsId=%u, "
            "modelId=%d, drvRetCode=%d!", deviceId, tsId, id, static_cast<int32_t>(drvRet));
        return RT_GET_DRV_ERRCODE(drvRet);
    }

    RT_LOG(RT_LOG_INFO, "Succ, deviceId=%u, id=%d, tsId=%u.", deviceId, id, tsId);
    return RT_ERROR_NONE;
}

/* ========================================================
 * Subcategory: SQCQ Alloc and Free
 * ======================================================== */

rtError_t NpuDriver::SqCqAllocate(const uint32_t deviceId, const uint32_t tsId, const uint32_t groupId,
                                  uint32_t * const sqId, uint32_t * const cqId)
{
    struct halSqCqOutputInfo normalSqCqAllocOutputInfo;
    struct halSqCqInputInfo normalSqCqAllocInputInfo;

    normalSqCqAllocInputInfo.type = DRV_CALLBACK_TYPE;
    normalSqCqAllocInputInfo.tsId = tsId;
    normalSqCqAllocInputInfo.sqeSize = static_cast<uint32_t>(sizeof(rtHostFuncSqCommand_t));
    normalSqCqAllocInputInfo.cqeSize = static_cast<uint32_t>(sizeof(rtHostFuncCqReport_t));
    normalSqCqAllocInputInfo.sqeDepth = 1U;
    normalSqCqAllocInputInfo.cqeDepth = RT_CB_ASYNC_CQ_DEPTH;
    normalSqCqAllocInputInfo.grpId = groupId;
    normalSqCqAllocInputInfo.flag = 0x0U;
    normalSqCqAllocOutputInfo.sqId = 0U;
    normalSqCqAllocOutputInfo.cqId = 0U;

    RT_LOG(RT_LOG_INFO, "deviceId=%u, tsId=%u, groupId=%u.", deviceId, tsId, groupId);

    const drvError_t drvRet = halSqCqAllocate(deviceId, &normalSqCqAllocInputInfo, &normalSqCqAllocOutputInfo);
    if (drvRet != DRV_ERROR_NONE) {
        DRV_ERROR_PROCESS(drvRet, "[drv api] halSqCqAllocate failed: device_id=%u, groupId=%u, drvRetCode=%d!",
            deviceId, groupId, static_cast<int32_t>(drvRet));
        return RT_GET_DRV_ERRCODE(drvRet);
    }

    RT_LOG(RT_LOG_INFO, "alloc success, deviceId=%u sqId=%u, cqId=%u.",
        deviceId, normalSqCqAllocOutputInfo.sqId, normalSqCqAllocOutputInfo.cqId);

    *sqId = normalSqCqAllocOutputInfo.sqId;
    *cqId = normalSqCqAllocOutputInfo.cqId;

    return RT_ERROR_NONE;
}

rtError_t NpuDriver::SqCqFree(const uint32_t sqId, const uint32_t cqId, const uint32_t deviceId, const uint32_t tsId)
{
    struct halSqCqFreeInfo SqCqFreeInputInfo;
    SqCqFreeInputInfo.type = DRV_CALLBACK_TYPE;
    SqCqFreeInputInfo.tsId = tsId;
    SqCqFreeInputInfo.sqId = sqId;
    SqCqFreeInputInfo.cqId = cqId;
    SqCqFreeInputInfo.flag = 0U;

    TIMESTAMP_NAME(__func__);
    RT_LOG(RT_LOG_INFO, "deviceId=%u, tsId=%u, sqId=%d, cqId=%u", deviceId, tsId, sqId, cqId);

    const drvError_t drvRet = halSqCqFree(deviceId, &SqCqFreeInputInfo);
    if (drvRet != DRV_ERROR_NONE) {
        DRV_ERROR_PROCESS(drvRet, "[drv api] halSqCqFree failed: device_id=%u, sqId=%u, cqId=%u, drvRetCode=%d!",
            deviceId, sqId, cqId, static_cast<int32_t>(drvRet));
        return RT_GET_DRV_ERRCODE(drvRet);
    }
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::NormalSqCqAllocate(const uint32_t deviceId, const uint32_t tsId, const uint32_t drvFlag,
                                        uint32_t * const sqId, uint32_t * const cqId,
                                        uint32_t * const info, const uint32_t len,
                                        uint32_t * const msg, const uint32_t msgLen)
{
    struct halSqCqInputInfo normalSqCqAllocInputInfo = {};
    struct halSqCqOutputInfo normalSqCqAllocOutputInfo;
    NULL_PTR_RETURN_MSG(sqId, RT_ERROR_INVALID_VALUE);
    NULL_PTR_RETURN_MSG(cqId, RT_ERROR_INVALID_VALUE);

    normalSqCqAllocInputInfo.type = DRV_NORMAL_TYPE;
    normalSqCqAllocInputInfo.tsId = tsId;
    normalSqCqAllocInputInfo.sqeSize = static_cast<uint32_t>(sizeof(rtHostFuncSqCommand_t));
    normalSqCqAllocInputInfo.cqeSize = 12U;
    normalSqCqAllocInputInfo.sqeDepth = 1024U;
    normalSqCqAllocInputInfo.cqeDepth = 1024U;
    normalSqCqAllocInputInfo.grpId = 0U;
    normalSqCqAllocInputInfo.flag = drvFlag;
    normalSqCqAllocInputInfo.cqId = *cqId;
    normalSqCqAllocInputInfo.sqId = *sqId;
    if (IsSupportFeature(RtOptionalFeatureType::RT_FEATURE_DRIVER_RESOURCE_SQCQ_ALLOC_EX)) {
        normalSqCqAllocInputInfo.ext_info_len = msgLen;
        normalSqCqAllocInputInfo.ext_info = msg;
    }
    normalSqCqAllocOutputInfo.sqId = 0U;
    normalSqCqAllocOutputInfo.cqId = 0U;

    uint32_t sqeDepth = GetDevProperties().sqeDepth;
    if ((GetDevProperties().cqeSize == RT_VIRTUAL_CQE_SIZE) && (sqeDepth != UINT32_MAX)) {
        normalSqCqAllocInputInfo.cqeSize = RT_VIRTUAL_CQE_SIZE;
        normalSqCqAllocInputInfo.sqeDepth = sqeDepth;
    }

    if ((GetDevProperties().cqeSize == RT_VIRTUAL_CQE_SIZE) && (sqeDepth == UINT32_MAX)) {
        normalSqCqAllocInputInfo.cqeSize = RT_VIRTUAL_CQE_SIZE;
        normalSqCqAllocInputInfo.sqeDepth = Runtime::macroValue_.rtsqDepth;
        normalSqCqAllocInputInfo.cqeDepth = Runtime::macroValue_.rtsqDepth;
    }

    if (IsSupportFeature(RtOptionalFeatureType::RT_FEATURE_DRIVER_RESOURCE_SQCQ_ALLOC_EX)) {
        normalSqCqAllocInputInfo.cqeSize = RT_STARSV2_VIRTUAL_CQE_SIZE;
        normalSqCqAllocInputInfo.sqeDepth = Runtime::macroValue_.rtsqDepth;
        normalSqCqAllocInputInfo.cqeDepth = Runtime::macroValue_.rtsqDepth;
    }

    normalSqCqAllocInputInfo.cqeDepth =
        ((sysMode_ == RUN_MACHINE_VIRTUAL && addrMode_ != 0) ?
            CQ_DEPTH_FOR_FLAT_ADDR_VIRTURE_MACH : normalSqCqAllocInputInfo.cqeDepth);
    RT_LOG(RT_LOG_INFO, "Set cq dep to %u, sysMode=%d addrMode=%d",
        normalSqCqAllocInputInfo.cqeDepth, sysMode_, addrMode_);

    // streamid send to ts, it will be need when resource recycle
    const errno_t ret = memcpy_s(normalSqCqAllocInputInfo.info, sizeof(normalSqCqAllocInputInfo.info), info,
        static_cast<size_t>(len));
    COND_RETURN_ERROR_MSG_CALL(ERR_MODULE_SYSTEM, ret != EOK, RT_ERROR_SEC_HANDLE,
                               "Call memcpy_s failed, dst length=%zu, src length=%u, retCode=%d!",
                               sizeof(normalSqCqAllocInputInfo.info), len, ret);
    TIMESTAMP_NAME(__func__);
    RT_LOG(RT_LOG_DEBUG, "normal sqcq alloc, device_id=%u, tsId=%u, flag=%u, cqId=%u, sqId=%u.",
        deviceId, tsId, normalSqCqAllocInputInfo.flag, *cqId, *sqId);

    drvError_t drvRet = halSqCqAllocate(deviceId, &normalSqCqAllocInputInfo, &normalSqCqAllocOutputInfo);
    if (g_isAddrFlatDevice) {
        int32_t tryCount = 0;
        while ((drvRet != DRV_ERROR_NONE) && (tryCount < 10)) { // try count 10
            (void)mmSleep(300U); // retry every 300ms
            tryCount++;
            drvRet = halSqCqAllocate(deviceId, &normalSqCqAllocInputInfo, &normalSqCqAllocOutputInfo);
        }
    }

    if (drvRet == DRV_ERROR_SQID_FULL) {
        RT_LOG(RT_LOG_INFO, "halSqCqAllocate: device_id=%u, drvRetCode=%d.", deviceId, static_cast<int32_t>(drvRet));
        return RT_ERROR_SQID_FULL;
    }

    COND_RETURN_EVENT(drvRet == DRV_ERROR_NO_RESOURCES, RT_ERROR_DRV_NO_RESOURCES,
        "halSqCqAllocate no resource: device_id=%u, drvRetCode=%d.", deviceId, static_cast<int32_t>(drvRet));

    if (drvRet != DRV_ERROR_NONE) {
        DRV_ERROR_PROCESS(drvRet, "[drv api] halSqCqAllocate failed: device_id=%u, drvRetCode=%d!", deviceId,
                          static_cast<int32_t>(drvRet));
        return RT_GET_DRV_ERRCODE(drvRet);
    }

    *sqId = normalSqCqAllocOutputInfo.sqId;
    *cqId = normalSqCqAllocOutputInfo.cqId;
    RT_LOG(RT_LOG_DEBUG, "Normal sqcq alloc success, device_id=%u, tsId=%u, flag=%u, sqId=%u, cqId=%u.",
        deviceId, tsId, normalSqCqAllocInputInfo.flag, *sqId, *cqId);

    return RT_ERROR_NONE;
}

rtError_t NpuDriver::NormalSqCqFree(const uint32_t deviceId, const uint32_t tsId,
                                    const uint32_t drvFlag, const uint32_t sqId, const uint32_t cqId)
{
    struct halSqCqFreeInfo normalSqCqFreeInputInfo;
    normalSqCqFreeInputInfo.type = DRV_NORMAL_TYPE;
    normalSqCqFreeInputInfo.tsId = tsId;
    normalSqCqFreeInputInfo.sqId = sqId;
    normalSqCqFreeInputInfo.cqId = cqId;
    normalSqCqFreeInputInfo.flag = drvFlag;
    RT_LOG(RT_LOG_INFO, "Normal sqcq free, sqId=%u, cqId=%u, device_id=%u, tsId=%u, drvFlag=%u",
        normalSqCqFreeInputInfo.sqId, normalSqCqFreeInputInfo.cqId, deviceId, tsId, drvFlag);
    const drvError_t drvRet = halSqCqFree(deviceId, &normalSqCqFreeInputInfo);
    if (drvRet != DRV_ERROR_NONE) {
        DRV_ERROR_PROCESS(drvRet, "[drv api] halSqCqFree failed: device_id=%u, sqId=%u, cqId=%u, drvRetCode=%d!",
            deviceId, sqId, cqId, static_cast<int32_t>(drvRet));
        return RT_GET_DRV_ERRCODE(drvRet);
    }
    RT_LOG(RT_LOG_INFO, "Normal sqcq free success, sqId=%u, cqId=%u, device_id=%u, tsId=%u, drvFlag=%u",
        normalSqCqFreeInputInfo.sqId, normalSqCqFreeInputInfo.cqId, deviceId, tsId, drvFlag);
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::LogicCqAllocate(const uint32_t devId, const uint32_t tsId, const uint32_t streamId,
    const bool isNeedFast, uint32_t &cqId, bool &isFastCq, const bool isCtrlSq)
{
    struct halSqCqInputInfo allocInput = {};
    allocInput.type = DRV_LOGIC_TYPE;
    allocInput.tsId = tsId;
    allocInput.sqeSize = 0U;
    allocInput.cqeSize = static_cast<uint32_t>(sizeof(rtLogicReport_t));
    allocInput.sqeDepth = 0U;
    allocInput.cqeDepth = GetDevProperties().cqeDepth;
    allocInput.grpId = 0U;
    allocInput.flag = 0U;
    if (isNeedFast) {
        allocInput.flag |= static_cast<uint32_t>(TSDRV_FLAG_THREAD_BIND_IRQ);
    }
    allocInput.cqId = cqId;
    allocInput.sqId = 0U;

    allocInput.info[0] = streamId;
    allocInput.info[1] = PidTidFetcher::GetCurrentTid();
    if (isCtrlSq) {
        allocInput.info[LOGICCQ_CTRLSQ_TAG_INDEX] = MAX_UINT16_NUM;
    }

    struct halSqCqOutputInfo allocOutput = {};
    const drvError_t drvRet = halSqCqAllocate(devId, &allocInput, &allocOutput);
    if (drvRet != DRV_ERROR_NONE) {
#ifndef CFG_DEV_PLATFORM_PC
        DRV_ERROR_PROCESS(drvRet, "[drv api] halSqCqAllocate failed: device_id=%u, tsId=%u, drvRetCode=%d!",
            devId, tsId, static_cast<int32_t>(drvRet));
#endif
        return RT_GET_DRV_ERRCODE(drvRet);
    }

    if ((allocOutput.flag & static_cast<uint32_t>(TSDRV_FLAG_THREAD_BIND_IRQ)) != 0) {
        isFastCq = true;
    }
    cqId = allocOutput.cqId;
    RT_LOG(RT_LOG_INFO, "Call halSqCqAllocate success: device_id=%u, ts_id=%u, cq_id=%u, stream_id=%u, "
        "isNeedFast:%d, isFastCq:%d", devId, tsId, cqId, streamId, static_cast<int32_t>(isNeedFast),
        static_cast<int32_t>(isFastCq));
    return RT_ERROR_NONE;
}

// alloc logic cq for stars
rtError_t NpuDriver::LogicCqAllocateV2(const uint32_t devId, const uint32_t tsId, const uint32_t streamId,
    uint32_t &cqId, const bool isDvppGrp, const uint32_t drvFlag)
{
    struct halSqCqInputInfo allocInput = {};
    uint32_t cqeDepth = 0U;
    allocInput.type = DRV_LOGIC_TYPE;
    allocInput.tsId = tsId;
    allocInput.sqeSize = 0U;
    allocInput.cqeSize = static_cast<uint32_t>(sizeof(rtLogicCqReport_t));
    allocInput.sqeDepth = 0U;
    if (GetDevProperties().cqeDepth == static_cast<uint32_t>(CqeDepth::CQE_DEPTH_DVPP_GRP)) {
        // 16384U = 64(task num of each stream) * 256(stream num of dvpp grp)
        cqeDepth = isDvppGrp ? static_cast<uint32_t>(CqeDepth::CQE_DEPTH_DVPP_GRP) :
            static_cast<uint32_t>(CqeDepth::CQE_DEPTH_NON_DVPP_GRP);
    } else {
        cqeDepth = GetDevProperties().cqeDepth;
    }

    allocInput.cqeDepth = cqeDepth;
    allocInput.grpId = 0U;
    allocInput.flag = drvFlag;
    allocInput.cqId = cqId;
    allocInput.sqId = 0U;

    allocInput.info[0] = streamId;
    allocInput.info[1] = PidTidFetcher::GetCurrentTid();

    RT_LOG(RT_LOG_INFO, "cqeDepth=%u, isDvppGrp=%u, inFlag=%u", allocInput.cqeDepth, isDvppGrp, drvFlag);

    struct halSqCqOutputInfo allocOutput = {};
    const drvError_t drvRet = halSqCqAllocate(devId, &allocInput, &allocOutput);
    if (drvRet != DRV_ERROR_NONE) {
        DRV_ERROR_PROCESS(drvRet, "[drv api] halSqCqAllocate failed: device_id=%u, tsId=%u, drvRetCode=%d!",
            devId, tsId, static_cast<int32_t>(drvRet));
        return RT_GET_DRV_ERRCODE(drvRet);
    }

    cqId = allocOutput.cqId;
    RT_LOG(RT_LOG_INFO, "success: deviceId=%u, tsId=%u, cqId=%u, streamId=%u, logicCq=%u, cqeDepth=%u",
        devId, tsId, cqId, streamId, cqId, allocInput.cqeDepth);
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::LogicCqFree(const uint32_t devId, const uint32_t tsId, const uint32_t cqId,
    const uint32_t drvFlag)
{
    struct halSqCqFreeInfo freeInput;
    freeInput.type = DRV_LOGIC_TYPE;
    freeInput.tsId = tsId;
    freeInput.sqId = 0U;
    freeInput.cqId = cqId;
    freeInput.flag = drvFlag;
    const drvError_t drvRet = halSqCqFree(devId, &freeInput);
    if (drvRet != DRV_ERROR_NONE) {
        DRV_ERROR_PROCESS(drvRet,
            "[drv api] halSqCqFree failed:device_id=%u,tsId=%u,type=%u,cqId=%u,drvRetCode=%d.",
            devId, freeInput.tsId, static_cast<uint32_t>(freeInput.type), freeInput.cqId, static_cast<int32_t>(drvRet));
        return RT_ERROR_DRV_ERR;
    }

    RT_LOG(RT_LOG_INFO, "Succ:device_id=%u,ts_id=%u,type=%u,logic_cq_id=%u, drvFlag=%u.",
           devId, freeInput.tsId, static_cast<uint32_t>(freeInput.type), freeInput.cqId, drvFlag);
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::CtrlSqCqAllocate(const uint32_t deviceId, const uint32_t tsId,
                                      uint32_t * const sqId, uint32_t * const cqId, const uint32_t logicCqId)
{
    struct halSqCqInputInfo ctrlSqCqAllocInputInfo = {};
    struct halSqCqOutputInfo ctrlSqCqAllocOutputInfo;
    NULL_PTR_RETURN_MSG(sqId, RT_ERROR_INVALID_VALUE);
    NULL_PTR_RETURN_MSG(cqId, RT_ERROR_INVALID_VALUE);

    ctrlSqCqAllocInputInfo.type = DRV_CTRL_TYPE;
    ctrlSqCqAllocInputInfo.tsId = tsId;
    ctrlSqCqAllocInputInfo.sqeSize = static_cast<uint32_t>(sizeof(rtHostFuncSqCommand_t));
    ctrlSqCqAllocInputInfo.cqeSize = 16U;
    ctrlSqCqAllocInputInfo.sqeDepth = 1024U;
    ctrlSqCqAllocInputInfo.cqeDepth = 1024U;
    ctrlSqCqAllocInputInfo.grpId = 0U;
    ctrlSqCqAllocInputInfo.flag = 0U;
    ctrlSqCqAllocInputInfo.cqId = *cqId;
    ctrlSqCqAllocInputInfo.sqId = *sqId;
    ctrlSqCqAllocInputInfo.info[SQCQ_DISTHREAD_INDEX] = static_cast<uint32_t>(Runtime::Instance()->GetDisableThread());
    ctrlSqCqAllocInputInfo.info[0] = logicCqId;
    ctrlSqCqAllocOutputInfo.sqId = 0U;
    ctrlSqCqAllocOutputInfo.cqId = 0U;

    TIMESTAMP_NAME(__func__);
    RT_LOG(RT_LOG_DEBUG, "ctrl sqcq alloc, device_id=%u, tsId=%u, flag=%u, cqId=%u, sqId=%u, logicCqId=%u.",
        deviceId, tsId, ctrlSqCqAllocInputInfo.flag, *cqId, *sqId, logicCqId);

    const drvError_t drvRet = halSqCqAllocate(deviceId, &ctrlSqCqAllocInputInfo, &ctrlSqCqAllocOutputInfo);
    if (drvRet == DRV_ERROR_SQID_FULL) {
        RT_LOG(RT_LOG_INFO, "CtrlSqCqAllocate: device_id=%u, drvRetCode=%d.", deviceId, static_cast<int32_t>(drvRet));
        return RT_ERROR_SQID_FULL;
    }

    if (drvRet != DRV_ERROR_NONE) {
        RT_LOG(RT_LOG_WARNING, "[drv api] CtrlSqCqAllocate failed: device_id=%u, drvRetCode=%d!", deviceId,
            static_cast<int32_t>(drvRet));
        return RT_GET_DRV_ERRCODE(drvRet);
    }

    *sqId = ctrlSqCqAllocOutputInfo.sqId;
    *cqId = ctrlSqCqAllocOutputInfo.cqId;
    RT_LOG(RT_LOG_DEBUG, "ctrl sqcq alloc success, device_id=%u, tsId=%u, flag=%u, sqId=%u, cqId=%u.",
        deviceId, tsId, ctrlSqCqAllocInputInfo.flag, *sqId, *cqId);

    return RT_ERROR_NONE;
}

rtError_t NpuDriver::CtrlSqCqFree(const uint32_t deviceId, const uint32_t tsId,
                                  const uint32_t sqId, const uint32_t cqId)
{
    struct halSqCqFreeInfo ctrlSqCqFreeInputInfo;
    ctrlSqCqFreeInputInfo.type = DRV_CTRL_TYPE;
    ctrlSqCqFreeInputInfo.tsId = tsId;
    ctrlSqCqFreeInputInfo.sqId = sqId;
    ctrlSqCqFreeInputInfo.cqId = cqId;
    ctrlSqCqFreeInputInfo.flag = 0U;
    const drvError_t drvRet = halSqCqFree(deviceId, &ctrlSqCqFreeInputInfo);
    RT_LOG(RT_LOG_INFO, "sqId=%u, cqId=%u, device_id=%u, tsId=%u.",
        ctrlSqCqFreeInputInfo.sqId, ctrlSqCqFreeInputInfo.cqId, deviceId, tsId);
    if (drvRet != DRV_ERROR_NONE) {
        RT_LOG(RT_LOG_WARNING, "[drv api] CtrlSqCqFree failed: device_id=%u, sqId=%u, cqId=%u, drvRetCode=%d!",
            deviceId, sqId, cqId, static_cast<int32_t>(drvRet));
        return RT_GET_DRV_ERRCODE(drvRet);
    }
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::VirtualCqAllocate(const uint32_t devId, const uint32_t tsId,
                                       uint32_t &sqId, uint32_t &cqId, uint8_t *&addr, bool &shmSqReadonly)
{
    struct halSqCqInputInfo allocInput = {};
    allocInput.type = DRV_SHM_TYPE;
    allocInput.tsId = tsId;
    allocInput.sqeSize = RT_VIRTUAL_SQE_SIZE;
    allocInput.cqeSize = RT_VIRTUAL_CQE_SIZE;  // ts and driver.
    allocInput.sqeDepth = 1024U;
    allocInput.cqeDepth = 1024U;
    allocInput.grpId = 0U;
    allocInput.flag = 0U;

    struct halSqCqOutputInfo allocOutput = {};
    const drvError_t drvRet = halSqCqAllocate(devId, &allocInput, &allocOutput);
    if (drvRet == DRV_ERROR_NONE) {
        RT_LOG(RT_LOG_INFO,
            "VirtualCqAllocate success:dev_id=%u, ts_id=%u, sq_id=%u, cq_id=%u, queue=%#llx, out flag=%u",
            devId, tsId, allocOutput.sqId, allocOutput.cqId, allocOutput.queueVAddr, allocOutput.flag);
        sqId = allocOutput.sqId;
        cqId = allocOutput.cqId;
        addr = RtPtrToPtr<uint8_t *>(static_cast<uintptr_t>(allocOutput.queueVAddr));
        // flag mark is read only
        shmSqReadonly = ((allocOutput.flag & static_cast<uint32_t>(TSRRV_FLAG_SQ_RDONLY)) != 0U);
        Runtime::Instance()->SetDisableThread(true);
        return RT_ERROR_NONE;
    } else if (drvRet == DRV_ERROR_INVALID_VALUE) {
        RT_LOG(RT_LOG_INFO, "device_id=%u not support virtual cq, use thread mode", devId);
        return RT_GET_DRV_ERRCODE(drvRet);
    } else {
        DRV_ERROR_PROCESS(drvRet, "[drv api] halSqCqAllocate failed: device_id=%u, ts_id=%u, "
            "drvRetCode=%d", devId, tsId, static_cast<int32_t>(drvRet));
        return RT_GET_DRV_ERRCODE(drvRet);
    }
}

rtError_t NpuDriver::VirtualCqFree(const uint32_t devId, const uint32_t tsId, const uint32_t sqId, const uint32_t cqId)
{
    struct halSqCqFreeInfo freeInput;
    freeInput.type = DRV_SHM_TYPE;
    freeInput.tsId = tsId;
    freeInput.sqId = sqId;
    freeInput.cqId = cqId;
    freeInput.flag = 0U;
    RT_LOG(RT_LOG_DEBUG, "halSqCqFree begin: device_id=%u, ts_id=%u, sq_id=%d, cq_id=%u", devId, tsId, sqId, cqId);
    const drvError_t drvRet = halSqCqFree(devId, &freeInput);
    RT_LOG(RT_LOG_INFO, "Call halSqCqFree finish: device_id=%u, ts_id=%u, sq_id=%d, cq_id=%u, drvRetCode=%d",
           devId, tsId, sqId, cqId, static_cast<int32_t>(drvRet));
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::DebugSqCqAllocate(const uint32_t deviceId, const uint32_t tsId,
                                       uint32_t &sqId, uint32_t &cqId)
{
    RT_LOG(RT_LOG_DEBUG, "debug sqcq alloc, device_id=%u, tsId=%u", deviceId, tsId);

    struct halSqCqInputInfo debugSqCqAllocInputInfo = {};
    struct halSqCqOutputInfo debugSqCqAllocOutputInfo = {};
    debugSqCqAllocInputInfo.type = DRV_GDB_TYPE;
    debugSqCqAllocInputInfo.tsId = tsId;
    debugSqCqAllocInputInfo.sqeSize = static_cast<uint32_t>(sizeof(RtDebugSendInfo));
    debugSqCqAllocInputInfo.cqeSize = static_cast<uint32_t>(sizeof(rtDebugReportInfo_t));
    debugSqCqAllocInputInfo.sqeDepth = 4U;
    debugSqCqAllocInputInfo.cqeDepth = 4U;

    const drvError_t drvRet = halSqCqAllocate(deviceId, &debugSqCqAllocInputInfo, &debugSqCqAllocOutputInfo);
    if (drvRet == DRV_ERROR_SQID_FULL) {
        RT_LOG(RT_LOG_INFO, "halSqCqAllocate: device_id=%u, ts_id=%u, drvRetCode=%d.", deviceId, tsId,
               static_cast<int32_t>(drvRet));
        return RT_ERROR_SQID_FULL;
    }
    if (drvRet != DRV_ERROR_NONE) {
        DRV_ERROR_PROCESS(drvRet, "[drv api] halSqCqAllocate failed: device_id=%u, ts_id=%u, drvRetCode=%d!",
                          deviceId, tsId, static_cast<int32_t>(drvRet));
        return RT_GET_DRV_ERRCODE(drvRet);
    }

    sqId = debugSqCqAllocOutputInfo.sqId;
    cqId = debugSqCqAllocOutputInfo.cqId;
    RT_LOG(RT_LOG_DEBUG, "debug sqcq alloc success, device_id=%u, tsId=%u, sqId=%u, cqId=%u.",
           deviceId, tsId, sqId, cqId);
    return RT_ERROR_NONE;
}

/* ========================================================
 * Subcategory: SQCQ Config
 * ======================================================== */

rtError_t NpuDriver::EnableSq(const uint32_t deviceId, const uint32_t tsId, const uint32_t sqId)
{
    COND_RETURN_WARN(&halSqCqConfig == nullptr, RT_ERROR_DRV_NOT_SUPPORT,
        "[drv api] halSqCqConfig does not exist.");

    struct halSqCqConfigInfo configInfo;
    configInfo.type = DRV_NORMAL_TYPE;
    configInfo.tsId = tsId;
    configInfo.sqId = sqId;
    configInfo.prop = DRV_SQCQ_PROP_SQ_STATUS;
    configInfo.value[0] = 1U;

    RT_LOG(RT_LOG_INFO, "deviceId=%u, tsId=%u, sqId=%u.", deviceId, tsId, sqId);
    const drvError_t drvRet = halSqCqConfig(deviceId, &configInfo);
    if (drvRet != DRV_ERROR_NONE) {
        DRV_ERROR_PROCESS(drvRet,
            "[drv api] halSqCqConfig DRV_NORMAL_TYPE DRV_SQCQ_PROP_SQ_STATUS value=1, "
            "device_id=%u, ts_id=%u, sq_id=%u, drvRetCode=%d.",
            deviceId, tsId, sqId, static_cast<int32_t>(drvRet));
        return RT_GET_DRV_ERRCODE(drvRet);
    }
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::DisableSq(const uint32_t deviceId, const uint32_t tsId, const uint32_t sqId)
{
    COND_RETURN_WARN(&halSqCqConfig == nullptr, RT_ERROR_DRV_NOT_SUPPORT,
        "[drv api] halSqCqConfig does not exist.");
    struct halSqCqConfigInfo configInfo;
    configInfo.type = DRV_NORMAL_TYPE;
    configInfo.tsId = tsId;
    configInfo.sqId = sqId;
    configInfo.prop = DRV_SQCQ_PROP_SQ_STATUS;
    configInfo.value[0] = 0U;

    RT_LOG(RT_LOG_INFO, "deviceId=%u, tsId=%u, sqId=%u.", deviceId, tsId, sqId);
    const drvError_t drvRet = halSqCqConfig(deviceId, &configInfo);
    if (drvRet != DRV_ERROR_NONE) {
        DRV_ERROR_PROCESS(drvRet,
            "[drv api] halSqCqConfig DRV_NORMAL_TYPE DRV_SQCQ_PROP_SQ_STATUS value=0, "
            "device_id=%u, ts_id=%u, sq_id=%u, drvRetCode=%d.",
            deviceId, tsId, sqId, static_cast<int32_t>(drvRet));
        return RT_GET_DRV_ERRCODE(drvRet);
    }

    return RT_ERROR_NONE;
}

/* ========================================================
 * Subcategory: SQCQ Send
 * ======================================================== */

rtError_t NpuDriver::CommandOccupy(const uint32_t sqId, rtTsCmdSqBuf_t ** const command,
                                   const uint32_t cmdCount, const uint32_t deviceId,
                                   const uint32_t tsId, uint32_t * const pos)
{
    struct halSqMemGetInput sqMemGetInput;
    struct halSqMemGetOutput sqMemGetOutput;

    sqMemGetInput.type = DRV_NORMAL_TYPE;
    sqMemGetInput.tsId = tsId;
    sqMemGetInput.sqId = sqId;
    sqMemGetInput.cmdCount = cmdCount;
    sqMemGetOutput.cmdCount = 0U;
    sqMemGetOutput.cmdPtr = nullptr;
    sqMemGetOutput.pos = 0U;

    const drvError_t drvRet = halSqMemGet(deviceId, &sqMemGetInput, &sqMemGetOutput);
    if ((drvRet != DRV_ERROR_NONE) || (sqMemGetOutput.cmdCount != cmdCount)) {
        return RT_ERROR_DRV_OCCUPY;
    }

    *command = RtPtrToPtr<rtTsCmdSqBuf_t *>(const_cast<void *>(sqMemGetOutput.cmdPtr));
    *pos     = sqMemGetOutput.pos;
    RT_LOG(RT_LOG_DEBUG, "sqId=%u, device_id=%u, tsId=%u, cmdCount=%u, pos=%u.",
        sqId, deviceId, tsId, sqMemGetOutput.cmdCount, *pos);
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::SqCommandOccupy(const uint32_t deviceId, const uint32_t tsId, const uint32_t sqId,
                                     rtHostFuncCommand_t ** const command, const uint32_t cnt)
{
    struct halSqMemGetInput sqMemGetInput;
    struct halSqMemGetOutput sqMemGetOutput;

    sqMemGetInput.type = DRV_CALLBACK_TYPE;
    sqMemGetInput.tsId = tsId;
    sqMemGetInput.sqId = sqId;
    sqMemGetInput.cmdCount = static_cast<uint32_t>(cnt);
    sqMemGetOutput.cmdPtr = nullptr;

    TIMESTAMP_NAME(__func__);
    RT_LOG(RT_LOG_INFO, "deviceId=%u, tsId=%u, sqId=%u, count=%u.", deviceId, tsId, sqId, cnt);

    const drvError_t drvRet = halSqMemGet(deviceId, &sqMemGetInput, &sqMemGetOutput);
    if (drvRet != DRV_ERROR_NONE) {
        DRV_ERROR_PROCESS(drvRet, "[drv api] halSqMemGet failed, device_id=%u, sqId=%u, drvRetCode=%d!", deviceId,
            sqId, static_cast<int32_t>(drvRet));
        return RT_GET_DRV_ERRCODE(drvRet);
    }
    *command = RtPtrToPtr<rtHostFuncCommand_t *>(RtPtrToPtr<uintptr_t>(sqMemGetOutput.cmdPtr));
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::SqTaskSend(const uint32_t sqId, rtStarsSqe_t * const sqe, const uint32_t deviceId,
                                const uint32_t tsId, const uint32_t sqeNum)
{
    struct halTaskSendInfo info = {};
    info.type = DRV_NORMAL_TYPE;
    info.sqe_addr = RtPtrToPtr<uint8_t *>(sqe);
    info.sqe_num = sqeNum;
    info.tsId = tsId;
    info.sqId = sqId;

    const drvError_t drvRet = halSqTaskSend(deviceId, &info);
    if (unlikely(drvRet != DRV_ERROR_NONE)) {
        RT_LOG(RT_LOG_WARNING, "[drv api] halSqTaskSend failed: [sqId=%u], device_id=%u, ts_id=%u, "
            "sqe_num=%u, drvRetCode=%d!", sqId, deviceId, tsId, sqeNum, static_cast<int32_t>(drvRet));
        return RT_GET_DRV_ERRCODE(drvRet);
    }

    return RT_ERROR_NONE;
}

rtError_t NpuDriver::CommandSend(const uint32_t sqId, const rtTsCmdSqBuf_t * const command, const uint32_t reportCount,
                                 const uint32_t deviceId, const uint32_t tsId, const uint32_t cmdCount)
{
    UNUSED(command);
    TIMESTAMP_NAME(__func__);
    halSqMsgInfo sendInfo;
    sendInfo.type = DRV_NORMAL_TYPE;
    sendInfo.tsId = tsId;
    sendInfo.sqId = sqId;
    sendInfo.cmdCount = cmdCount;
    sendInfo.reportCount = reportCount;
    const drvError_t drvRet = halSqMsgSend(deviceId, &sendInfo);
    if (unlikely(drvRet != DRV_ERROR_NONE)) {
        DRV_ERROR_PROCESS(drvRet, "[drv api] halSqMsgSend failed: [sqId=%u], device_id=%u, ts_id=%u, "
            "reportCount=%u, cmdCount=%u, drvRetCode=%d!",
            sqId, deviceId, tsId, reportCount, cmdCount, static_cast<int32_t>(drvRet));
        return RT_GET_DRV_ERRCODE(drvRet);
    }

    RT_LOG(RT_LOG_INFO, "device_id=%u, ts_id=%u, sq_id=%d, reportCount=%u, cmdCount=%u.",
        deviceId, tsId, sqId, reportCount, cmdCount);
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::SqCommandSend(const uint32_t deviceId, const uint32_t tsId, const uint32_t sqId,
                                   rtHostFuncCommand_t * const command, const uint32_t cnt)
{
    (void)command;
    struct halSqMsgInfo sendInfo;
    sendInfo.type = DRV_CALLBACK_TYPE;
    sendInfo.tsId = tsId;
    sendInfo.sqId = sqId;
    sendInfo.cmdCount = static_cast<uint32_t>(cnt);
    sendInfo.reportCount = static_cast<uint32_t>(cnt);

    TIMESTAMP_NAME(__func__);
    RT_LOG(RT_LOG_INFO, "deviceId=%u, tsId=%u, sqId=%u, count=%d.", deviceId, tsId, sqId, cnt);

    const drvError_t drvRet = halSqMsgSend(deviceId, &sendInfo);
    if (drvRet != DRV_ERROR_NONE) {
        DRV_ERROR_PROCESS(drvRet, "[drv api] halSqMsgSend failed: device_id=%u, sqId=%u, drvRetCode=%d.", deviceId,
            sqId, static_cast<int32_t>(drvRet));
        return RT_GET_DRV_ERRCODE(drvRet);
    }
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::DebugSqTaskSend(const uint32_t sqId, uint8_t *const sqe, const uint32_t deviceId,
                                     const uint32_t tsId)
{
    struct halTaskSendInfo info = {};
    info.type = DRV_GDB_TYPE;
    info.sqe_addr = sqe;
    info.sqe_num = 1U;
    info.tsId = tsId;
    info.sqId = sqId;

    const drvError_t drvRet = halSqTaskSend(deviceId, &info);
    if (unlikely(drvRet != DRV_ERROR_NONE)) {
        RT_LOG(RT_LOG_WARNING, "[drv api] halSqTaskSend failed: [sqId=%u], device_id=%u, ts_id=%u, "
            "drvRetCode=%d!", sqId, deviceId, tsId, static_cast<int32_t>(drvRet));
        return RT_GET_DRV_ERRCODE(drvRet);
    }

    RT_LOG(RT_LOG_INFO, "device_id=%u, ts_id=%u, sq_id=%d.", deviceId, tsId, sqId);
    return RT_ERROR_NONE;
}

/* ========================================================
 * Subcategory: CQ Report
 * ======================================================== */

rtError_t NpuDriver::LogicCqReportV2(const LogicCqWaitInfo &waitInfo, uint8_t *report, uint32_t reportCnt,
    uint32_t &realCnt)
{
    Runtime * const rtInstance = Runtime::Instance();
    if (waitInfo.isFastCq) {
        struct halReportInfoInput irqWaitInputInfo;
        struct halReportInfoOutput irqWaitOutputInfo;
        irqWaitInputInfo.type = DRV_LOGIC_TYPE;
        irqWaitInputInfo.grpId = waitInfo.cqId;  // reuse grpId for cqId.
        irqWaitInputInfo.tsId = waitInfo.tsId;
        irqWaitInputInfo.timeout = waitInfo.timeout;

        const drvError_t drvReportWaitRet = halCqReportIrqWait(waitInfo.devId, &irqWaitInputInfo, &irqWaitOutputInfo);
        if (unlikely((drvReportWaitRet != DRV_ERROR_NONE) && (drvReportWaitRet != DRV_ERROR_SOCKET_CLOSE) &&
            (drvReportWaitRet != DRV_ERROR_WAIT_TIMEOUT))) {
            RT_LOG(RT_LOG_ERROR, "[drv api] halCqReportIrqWait failed, device_id=%u, ts_id=%u"
                ", type=%u, logicCq=%u, drvRetCode=%d",
                waitInfo.devId, waitInfo.tsId, static_cast<uint32_t>(irqWaitInputInfo.type),
                waitInfo.cqId, static_cast<int32_t>(drvReportWaitRet));
        } else {
            RT_LOG(RT_LOG_DEBUG, "fast cq, device_id=%u, ts_id=%u, type=%u, logicCq=%u, drvRetCode=%d",
                waitInfo.devId, waitInfo.tsId, static_cast<uint32_t>(irqWaitInputInfo.type),
                waitInfo.cqId, static_cast<int32_t>(drvReportWaitRet));
        }

        return RT_GET_DRV_ERRCODE(drvReportWaitRet);
    }

    struct halReportRecvInfo repRecvInfo;
    repRecvInfo.type = DRV_LOGIC_TYPE;
    repRecvInfo.tsId = waitInfo.tsId;
    repRecvInfo.cqId = waitInfo.cqId;
    if (rtInstance->IsStreamSyncEsched()) {
        repRecvInfo.timeout = 0;
    } else {
        repRecvInfo.timeout = waitInfo.timeout;
    }
    repRecvInfo.cqe_addr = report;
    repRecvInfo.cqe_num = reportCnt;
    repRecvInfo.stream_id = waitInfo.streamId;
    repRecvInfo.task_id = waitInfo.taskId;
    repRecvInfo.report_cqe_num = reportCnt;
    RT_LOG(RT_LOG_DEBUG, "device_id=%u,ts_id=%u,type=%u,logicCq=%u,stream_id=%u,task_id=%u,"
        "timeout=%dms,report_cqe_num=%u",
        waitInfo.devId, waitInfo.tsId, static_cast<uint32_t>(repRecvInfo.type), waitInfo.cqId,
        waitInfo.streamId, waitInfo.taskId, repRecvInfo.timeout, reportCnt);

    drvError_t drvReportGetRet = halCqReportRecv(waitInfo.devId, &repRecvInfo);
    RT_LOG(RT_LOG_DEBUG, "report_cqe_num=%u,drvReportGetRet=%d", repRecvInfo.report_cqe_num, drvReportGetRet);
    if ((rtInstance->IsStreamSyncEsched()) && (repRecvInfo.report_cqe_num == 0U)) {
        const uint32_t grpId = rtInstance->GetStreamSyncEschedGrpID();
        const int32_t curTid = mmGetTid();
        rtInstance->StreamSyncEschedLock();
        std::map<int32_t, uint32_t>::const_iterator it =
            rtInstance->eschedMap_.find(curTid);
        if (it == rtInstance->eschedMap_.end()) {
            RT_LOG(RT_LOG_ERROR, "eschedMap can not find current os tid (=%u).", curTid);
            rtInstance->StreamSyncEschedUnLock();
            return RT_ERROR_INVALID_VALUE;
        }
        const uint32_t eschedTid = it->second;
        rtInstance->StreamSyncEschedUnLock();
        drvReportGetRet = DrvEschedManage(waitInfo.devId, waitInfo.timeout, eschedTid, grpId, &repRecvInfo);
    }
    if (drvReportGetRet == DRV_ERROR_WAIT_TIMEOUT) {
        RT_LOG(RT_LOG_DEBUG, "halCqReportRecv failed:device_id=%u,ts_id=%u,type=%u,logic_cq=%u,drv_ret_code=%d",
               waitInfo.devId, repRecvInfo.tsId, static_cast<uint32_t>(repRecvInfo.type), repRecvInfo.cqId,
               static_cast<int32_t>(drvReportGetRet));
        return RT_GET_DRV_ERRCODE(drvReportGetRet);
    }
    if ((drvReportGetRet != DRV_ERROR_NONE) && (drvReportGetRet != DRV_ERROR_SOCKET_CLOSE)) {
        DRV_ERROR_PROCESS(drvReportGetRet, "[drv api] halCqReportRecv failed: device_id=%u, ts_id=%u, type=%u, "
            "logic_cq=%u, drv_ret_code=%d", waitInfo.devId, repRecvInfo.tsId, static_cast<uint32_t>(repRecvInfo.type),
            repRecvInfo.cqId, static_cast<int32_t>(drvReportGetRet));
        return RT_GET_DRV_ERRCODE(drvReportGetRet);
    }
    realCnt = repRecvInfo.report_cqe_num;

    RT_LOG(RT_LOG_DEBUG, "logic_cq real cnt=%u", realCnt);
    for (uint32_t i = 0U; i < realCnt; i++) {
        if (rtInstance->ChipIsHaveStars()) {
            const rtLogicCqReport_t &cqe = (RtPtrToPtr<rtLogicCqReport_t *>(report))[i];
            PrintStarsCqeInfo(cqe, waitInfo.devId, repRecvInfo.cqId);
        } else {
            const RtLogicCqReportMsg &cqe = (RtPtrToPtr<RtLogicCqReportMsg *>(report))[i];
            RT_LOG(RT_LOG_DEBUG, "device_id=%u,stream_id=%hu,task_id=%hu,cq_id=%u,error_type=%hhu",
                   waitInfo.devId, cqe.stream_id, cqe.task_id, repRecvInfo.cqId, cqe.error_type);
        }
    }

    return static_cast<rtError_t>((drvReportGetRet == DRV_ERROR_SOCKET_CLOSE) ? RT_ERROR_SOCKET_CLOSE : RT_ERROR_NONE);
}

rtError_t NpuDriver::LogicCqReport(const LogicCqWaitInfo &waitInfo, rtLogicReport_t *&report, uint32_t &cnt)
{
    TIMESTAMP_NAME(__func__);
    struct halReportInfoInput irqWaitInputInfo;
    struct halReportInfoOutput irqWaitOutputInfo;
    irqWaitInputInfo.type = DRV_LOGIC_TYPE;
    irqWaitInputInfo.grpId = waitInfo.cqId;  // reuse grpId for cqId.
    irqWaitInputInfo.tsId = waitInfo.tsId;
    irqWaitInputInfo.timeout = waitInfo.timeout;

    const drvError_t drvReportWaitRet = halCqReportIrqWait(waitInfo.devId, &irqWaitInputInfo, &irqWaitOutputInfo);
    if (unlikely((drvReportWaitRet != DRV_ERROR_NONE)  && (drvReportWaitRet != DRV_ERROR_SOCKET_CLOSE))) {
        RT_LOG(RT_LOG_DEBUG, "halCqReportIrqWait:device_id=%u,ts_id=%u,type=%u,cq_id=%u,drvRetCode=%d",
               waitInfo.devId, irqWaitInputInfo.tsId, static_cast<uint32_t>(irqWaitInputInfo.type),
               irqWaitInputInfo.grpId, static_cast<int32_t>(drvReportWaitRet));
        return RT_GET_DRV_ERRCODE(drvReportWaitRet);
    }

    if (waitInfo.isFastCq) {
        RT_LOG(RT_LOG_DEBUG, "fast cq,device_id=%u,ts_id=%u,type=%u,cq_id=%u",
               waitInfo.devId, waitInfo.tsId, static_cast<uint32_t>(irqWaitInputInfo.type), waitInfo.cqId);
        return static_cast<rtError_t>((drvReportWaitRet == DRV_ERROR_SOCKET_CLOSE) ?
                                      RT_ERROR_SOCKET_CLOSE : RT_ERROR_NONE);
    }

    struct halReportGetInput repGetInputInfo;
    struct halReportGetOutput repGetOutputInfo;
    repGetInputInfo.type = DRV_LOGIC_TYPE;
    repGetInputInfo.tsId = waitInfo.tsId;
    repGetInputInfo.cqId = waitInfo.cqId;
    repGetOutputInfo.count = 0U;
    repGetOutputInfo.reportPtr = nullptr;
    const drvError_t drvReportGetRet = halCqReportGet(waitInfo.devId, &repGetInputInfo, &repGetOutputInfo);
    if (drvReportGetRet != DRV_ERROR_NONE) {
        DRV_ERROR_PROCESS(drvReportGetRet, "[drv api] halCqReportGet failed:device_id=%u,tsId=%u,type=%u,cqId=%u, "
            "drvRetCode=%d", waitInfo.devId, repGetInputInfo.tsId, static_cast<uint32_t>(repGetInputInfo.type),
            repGetInputInfo.cqId, static_cast<int32_t>(drvReportGetRet));
        return RT_GET_DRV_ERRCODE(drvReportGetRet);
    }

    cnt = repGetOutputInfo.count;
    report = static_cast<rtLogicReport_t *>(repGetOutputInfo.reportPtr);

    return static_cast<rtError_t>((drvReportWaitRet == DRV_ERROR_SOCKET_CLOSE) ? RT_ERROR_SOCKET_CLOSE : RT_ERROR_NONE);
}

rtError_t NpuDriver::DebugCqReport(const uint32_t devId, const uint32_t tsId, const uint32_t cqId,
                                   uint8_t *const report, uint32_t &realCnt)
{
    struct halReportRecvInfo repRecvInfo = {};
    repRecvInfo.type = DRV_GDB_TYPE;
    repRecvInfo.tsId = tsId;
    repRecvInfo.cqId = cqId;
    repRecvInfo.timeout = 5000; // 超时时间，等待5000ms
    repRecvInfo.cqe_addr = report;
    repRecvInfo.cqe_num = 4U; // 固定的4
    repRecvInfo.report_cqe_num = 0U; // 出参
    RT_LOG(RT_LOG_DEBUG, "device_id=%u, ts_id=%u, cq_id=%u, timeout=5000ms", devId, tsId, cqId);

    const drvError_t drvReportGetRet = halCqReportRecv(devId, &repRecvInfo);
    RT_LOG(RT_LOG_DEBUG, "report_cqe_num=%u, drvReportGetRet=%d", repRecvInfo.report_cqe_num, drvReportGetRet);

    if (drvReportGetRet != DRV_ERROR_NONE) {
        DRV_ERROR_PROCESS(drvReportGetRet, "[drv api] halCqReportRecv failed: device_id=%u, ts_id=%u, "
            "cq_id=%u, drv_ret_code=%d", devId, tsId, cqId, static_cast<int32_t>(drvReportGetRet));
        return RT_GET_DRV_ERRCODE(drvReportGetRet);
    }
    realCnt = repRecvInfo.report_cqe_num;
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::CqReportIrqWait(const uint32_t deviceId, const uint32_t tsId, const uint32_t groupId,
                                     const int32_t timeout, uint64_t * const getCqidList, const uint32_t cqidListNum)
{
    struct halReportInfoInput irqWaitInputInfo;
    struct halReportInfoOutput irqWaitOutputInfo;
    TIMESTAMP_NAME(__func__);

    irqWaitInputInfo.type = DRV_CALLBACK_TYPE;
    irqWaitInputInfo.grpId = groupId;
    irqWaitInputInfo.tsId = tsId;
    irqWaitInputInfo.timeout = timeout;
    irqWaitOutputInfo.cqIdBitmap = getCqidList;
    irqWaitOutputInfo.cqIdBitmapSize = cqidListNum;  // input para

    RT_LOG(RT_LOG_INFO, "Irq wait start, deviceId=%u, tsId=%u, groupId=%u.", deviceId, tsId, groupId);

    const drvError_t drvRet = halCqReportIrqWait(deviceId, &irqWaitInputInfo, &irqWaitOutputInfo);
    COND_RETURN_WARN(drvRet != DRV_ERROR_NONE, RT_GET_DRV_ERRCODE(drvRet),
                     "[drv api] halCqReportIrqWait: device_id=%u, tsId=%u, groupId=%u, drvRetCode=%d.",
                     deviceId, tsId, groupId, static_cast<int32_t>(drvRet));
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::CqReportGet(const uint32_t deviceId, const uint32_t tsId, const uint32_t cqId,
                                 rtHostFuncCqReport_t ** const report, uint32_t * const cnt)
{
    struct halReportGetInput repGetInputInfo;
    struct halReportGetOutput repGetOutputInfo;

    TIMESTAMP_NAME(__func__);
    RT_LOG(RT_LOG_INFO, "cq report get start, device_id=%u, tsId=%u.", deviceId, tsId);
    repGetInputInfo.type = DRV_CALLBACK_TYPE;
    repGetInputInfo.tsId = tsId;
    repGetInputInfo.cqId = cqId;
    repGetOutputInfo.count = 0U;

    const drvError_t drvRet = halCqReportGet(deviceId, &repGetInputInfo, &repGetOutputInfo);
    RT_LOG(RT_LOG_INFO, "halCqReportGet count=%u", repGetOutputInfo.count);
    if (drvRet != DRV_ERROR_NONE) {
        DRV_ERROR_PROCESS(drvRet, "[drv api] halCqReportGet failed: device_id=%u, tsId=%u, cqId=%u, drvRetCode=%d!",
            deviceId, tsId, cqId, static_cast<int32_t>(drvRet));
        return RT_GET_DRV_ERRCODE(drvRet);
    }

    *cnt = repGetOutputInfo.count;
    *report = RtPtrToPtr<rtHostFuncCqReport_t *>(RtPtrToPtr<uintptr_t>(repGetOutputInfo.reportPtr));

    return RT_ERROR_NONE;
}

rtError_t NpuDriver::CqReportRelease(rtHostFuncCqReport_t * const report, const uint32_t deviceId,
                                     const uint32_t cqId, const uint32_t tsId, const bool noLog)
{
    UNUSED(report);
    const uint32_t reportCount = 1U;
    halReportReleaseInfo drvRepReleaseInfo;

    TIMESTAMP_NAME(__func__);
    drvRepReleaseInfo.type = DRV_CALLBACK_TYPE;
    drvRepReleaseInfo.tsId = tsId;
    drvRepReleaseInfo.cqId = cqId;
    drvRepReleaseInfo.count = reportCount;

    const drvError_t drvRet = halReportRelease(deviceId, &drvRepReleaseInfo);
    if (drvRet != DRV_ERROR_NONE) {
        if (!noLog) {
            DRV_ERROR_PROCESS(drvRet, "[drv api] halReportRelease failed: device_id=%u, cqId=%u, tsId=%u, drvRetCode=%d!",
                deviceId, cqId, tsId, static_cast<int32_t>(drvRet));
        }
        return RT_GET_DRV_ERRCODE(drvRet);
    }

    RT_LOG(RT_LOG_DEBUG, "deviceId=%u, cqId=%u, tsId=%u.", deviceId, cqId, tsId);

    return RT_ERROR_NONE;
}

rtError_t NpuDriver::ReportWait(void ** const report, int32_t * const cnt, const uint32_t deviceId,
                                const uint32_t tsId, const uint32_t cqId)
{
    TIMESTAMP_NAME(__func__);
    struct halReportInfoInput irqWaitInputInfo;
    struct halReportInfoOutput irqWaitOutputInfo;
    irqWaitInputInfo.type = DRV_NORMAL_TYPE;
    irqWaitInputInfo.grpId = 0U;
    irqWaitInputInfo.tsId = tsId;
    irqWaitInputInfo.timeout = RT_REPORT_TIMEOUT_TIME;

    const drvError_t drvReportWaitRet = halCqReportIrqWait(deviceId, &irqWaitInputInfo, &irqWaitOutputInfo);
    if (unlikely((drvReportWaitRet != DRV_ERROR_NONE) && (drvReportWaitRet != DRV_ERROR_SOCKET_CLOSE))) {
        RT_LOG(RT_LOG_DEBUG, "[drv api] halCqReportIrqWait: device_id=%u, ts_id=%u, "
               "drvRetCode=%d.", deviceId, tsId, drvReportWaitRet);
        drvDfxShowReport(deviceId);
        return RT_GET_DRV_ERRCODE(drvReportWaitRet);
    }

    struct halReportGetInput repGetInputInfo;
    struct halReportGetOutput repGetOutputInfo;
    repGetInputInfo.type = DRV_NORMAL_TYPE;
    repGetInputInfo.tsId = tsId;
    repGetInputInfo.cqId = cqId;
    repGetOutputInfo.count = 0U;
    repGetOutputInfo.reportPtr = nullptr;

    const drvError_t drvReportGetRet = halCqReportGet(deviceId, &repGetInputInfo, &repGetOutputInfo);
    if (drvReportGetRet != DRV_ERROR_NONE) {
        DRV_ERROR_PROCESS(drvReportGetRet, "[drv api] halCqReportGet failed: "
            "device_id=%u, ts_id=%u, drvRetCode=%d!", deviceId, tsId, drvReportGetRet);
        drvDfxShowReport(deviceId);
        return RT_GET_DRV_ERRCODE(drvReportGetRet);
    }

    *cnt = static_cast<int32_t>(repGetOutputInfo.count);
    *report = repGetOutputInfo.reportPtr;

    return static_cast<rtError_t>((drvReportWaitRet == DRV_ERROR_SOCKET_CLOSE) ? RT_ERROR_SOCKET_CLOSE : RT_ERROR_NONE);
}

rtError_t NpuDriver::ReportRelease(const uint32_t deviceId, const uint32_t tsId,
                                   const uint32_t cqId, const drvSqCqType_t type)
{
    constexpr uint32_t reportCount = 1U;
    struct halReportReleaseInfo repReleaseInfo;

    TIMESTAMP_NAME(__func__);

    repReleaseInfo.type = type;
    repReleaseInfo.tsId = tsId;
    repReleaseInfo.cqId = cqId;
    repReleaseInfo.count = reportCount;
    const drvError_t drvRet = halReportRelease(deviceId, &repReleaseInfo);
    if (unlikely(drvRet != DRV_ERROR_NONE)) {
        DRV_ERROR_PROCESS(drvRet, "[drv api] halReportRelease failed: device_id=%u, tsId=%u, "
            "drvRetCode=%d!", deviceId, tsId, static_cast<int32_t>(drvRet));
        return RT_GET_DRV_ERRCODE(drvRet);
    }

    RT_LOG(RT_LOG_DEBUG, "report release success, device_id=%u, tsId=%u.", deviceId, tsId);
    return RT_ERROR_NONE;
}

/* ========================================================
 * Subcategory: SQ Backup and Restore
 * ======================================================== */

rtError_t NpuDriver::SqBackup(const uint32_t deviceId, uint32_t *sqIdGroup, const size_t sqIdCnt)
{
    COND_RETURN_WARN(&halStreamBackup == nullptr, RT_ERROR_DRV_NOT_SUPPORT,
        "[drv api] halStreamBackup does not exist");

    struct stream_backup_info info = {};
    info.type = DRV_RESOURCE_SQ_ID;
    info.id_num = static_cast<uint32_t>(sqIdCnt);
    info.id_list = sqIdGroup;
    const drvError_t drvRet = halStreamBackup(deviceId, &info);
    if (drvRet != DRV_ERROR_NONE) {
        DRV_ERROR_PROCESS(drvRet, "Backup NPU SQ failed, deviceId=%u, sqIdCnt=%zu, drvRet=%d",
            deviceId, sqIdCnt, static_cast<int32_t>(drvRet));
        return RT_GET_DRV_ERRCODE(drvRet);
    }
 
    RT_LOG(RT_LOG_INFO, "Success to backup NPU SQ, drv deviceId=%u, sqIdCnt=%zu.", deviceId, sqIdCnt);
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::SqRestore(const uint32_t deviceId, uint32_t *sqIdGroup, const size_t sqIdCnt)
{
    COND_RETURN_WARN(&halStreamRestore == nullptr, RT_ERROR_DRV_NOT_SUPPORT,
        "[drv api] halStreamRestore does not exist");

    struct stream_backup_info info = {};
    info.type = DRV_RESOURCE_SQ_ID;
    info.id_num = static_cast<uint32_t>(sqIdCnt);
    info.id_list = sqIdGroup;
    const drvError_t drvRet = halStreamRestore(deviceId, &info);
    if (drvRet != DRV_ERROR_NONE) {
        DRV_ERROR_PROCESS(drvRet, "Restore NPU SQ failed, deviceId=%u, sqIdCnt=%zu, drvRet=%d",
            deviceId, sqIdCnt, static_cast<int32_t>(drvRet));
        return RT_GET_DRV_ERRCODE(drvRet);
    }
 
    RT_LOG(RT_LOG_INFO, "Success to restore NPU SQ, drv deviceId=%u, sqIdCnt=%zu.", deviceId, sqIdCnt);
    return RT_ERROR_NONE;
}

}  // namespace runtime
}  // namespace cce
