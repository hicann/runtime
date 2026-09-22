/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "driver.hpp"
#include "npu_driver_base.hpp"
#include "errcode_manage.hpp"
#include "error_message_manage.hpp"
#include "runtime.hpp"
#include "context.hpp"
#include "raw_device.hpp"
#include "model.hpp"

namespace cce {
namespace runtime {
rtError_t GetIpcNotifyVa(
    const uint32_t notifyId, Driver* const curDrv, const uint32_t deviceId, const uint32_t phyId, uint64_t& Va)
{
    UNUSED(curDrv);
    UNUSED(phyId);
    UNUSED(Va);
    UNUSED(notifyId);
    UNUSED(deviceId);
    return RT_ERROR_NONE;
}

rtError_t GetConnectUbFlagFromDrv(const uint32_t deviceId, bool& connectUbFlag)
{
    UNUSED(deviceId);
    connectUbFlag = false;
    return RT_ERROR_NONE;
}

rtError_t InitDrvEventThread(const uint32_t deviceId)
{
    COND_RETURN_AND_MSG_OUTER(
        &halDrvEventThreadInit == nullptr, RT_ERROR_FEATURE_NOT_SUPPORT, ErrorCode::EE1015,
        "Initializing the driver event thread", "The driver interface halDrvEventThreadInit does not exist.");

    const drvError_t err = halDrvEventThreadInit(deviceId);
    COND_RETURN_WARN(
        err == DRV_ERROR_NOT_SUPPORT, RT_GET_DRV_ERRCODE(err), "[drv api] halDrvEventThreadInit does not support");
    DRV_PROCESS_ERROR_RETURN(
        err, "Failed to init drv event thread, error=%#x, devId=%u", RT_GET_DRV_ERRCODE(err), deviceId);
    return RT_GET_DRV_ERRCODE(err);
}

rtError_t GetDrvSentinelMode(void)
{
    constexpr int32_t sentinelIndex = 11;
    int32_t sentinelMode = 0;
    int64_t dieNum = 0;
    Driver* curDrv = nullptr;
    curDrv = Runtime::Instance()->driverFactory_.GetDriver(NPU_DRIVER);
    rtError_t err = curDrv->GetCentreNotify(sentinelIndex, &sentinelMode); /* index 11可以获取是否为哨兵模式 */
    COND_RETURN_ERROR_MSG_INNER(err != RT_ERROR_NONE, err, "Failed to get driver sentinel mode, error=%#x.", err);
    err = curDrv->GetDevInfo(0, MODULE_TYPE_AICORE, INFO_TYPE_DIE_NUM, &dieNum);
    COND_RETURN_ERROR_MSG_INNER(err != RT_ERROR_NONE, err, "Failed to get die number, error=%#x.", err);
    // 1：to lowpower  3: lowpower
    const bool mode = ((sentinelMode == 1) || (sentinelMode == 3) || (dieNum == 0)) ? true : false;
    Runtime::Instance()->SetSentinelMode(mode);
    RT_LOG(RT_LOG_INFO, "Get sentinel mode info success, sentinelMode=%u, dieNum=%lld", sentinelMode, dieNum);
    return RT_ERROR_NONE;
}

bool IsOfflineNotSupportMemType(const rtMemType_t& type)
{
    UNUSED(type);
    return false;
}

bool isNeedOpenDevice(bool& isTscOpen, bool& isTsvOpen, const uint32_t tsId)
{
    UNUSED(tsId);
    return !(isTscOpen || isTsvOpen);
}

bool isNeedCloseDevice(bool& isTscOpen, bool& isTsvOpen) { return !(isTscOpen && isTsvOpen); }

rtError_t SetModelNameWithCtrlMsg(Model* const mdl)
{
    ts_ctrl_msg_body_t modelNameIn = {};
    ts_ctrl_msg_body_t modelNameAck = {};
    size_t ackCount = sizeof(ts_ctrl_msg_body_t);

    modelNameIn.type = OP_SET_MODEL_NAME;
    uint32_t tsId = mdl->Context_()->Device_()->DevGetTsId();
    modelNameIn.u.set_model_name_info.ts_id = tsId;
    modelNameIn.u.set_model_name_info.model_id = mdl->Id_();
    const std::string& modelName = mdl->GetName();
    constexpr size_t modelNameMaxLen = sizeof(modelNameIn.u.set_model_name_info.model_name);
    const size_t copyLen = std::min(modelName.length(), modelNameMaxLen - 1);
    const errno_t ret = memcpy_s(
        const_cast<char*>(modelNameIn.u.set_model_name_info.model_name), modelNameMaxLen, modelName.c_str(), copyLen);
    if (ret != EOK) {
        RT_LOG(RT_LOG_ERROR, "memcpy_s model name failed, retCode=%d, srcLen=%zu", ret, copyLen);
        return RT_ERROR_SEC_HANDLE;
    }
    uint32_t deviceId = mdl->Context_()->Device_()->Id_();
    struct tsdrv_ctrl_msg para;
    para.tsid = tsId;
    para.msg_len = sizeof(ts_ctrl_msg_body_t);
    para.msg = static_cast<void*>(&modelNameIn);

    COND_RETURN_WARN(&halTsdrvCtl == nullptr, RT_ERROR_DRV_NOT_SUPPORT, "[drv api] halTsdrvCtl does not exist.");
    RT_LOG(RT_LOG_INFO, "device_id=%u, ts_id=%u.", deviceId, tsId);
    const drvError_t drvRet = halTsdrvCtl(
        deviceId, TSDRV_CTL_CMD_CTRL_MSG, static_cast<void*>(&para), sizeof(tsdrv_ctrl_msg),
        static_cast<void*>(&modelNameAck), &ackCount);
    COND_RETURN_ERROR_MSG_CALL(
        ERR_MODULE_DRV, drvRet != DRV_ERROR_NONE, RT_GET_DRV_ERRCODE(drvRet), "device_id=%u, ts_id=%u, drvRetCode=%d.",
        deviceId, tsId, static_cast<int32_t>(drvRet));

    return RT_ERROR_NONE;
}
} // namespace runtime
} // namespace cce
