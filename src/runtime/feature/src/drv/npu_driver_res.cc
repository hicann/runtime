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
    RT_LOG(RT_LOG_INFO, "device_id=%u, ts_id=%u, op execute timeoutInterval=%" PRIu64 "us.",
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

}  // namespace runtime
}  // namespace cce
