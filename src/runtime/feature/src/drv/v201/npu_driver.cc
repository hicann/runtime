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
#include "errcode_manage.hpp"
#include "error_message_manage.hpp"
#include "runtime.hpp"
#include "context.hpp"
#include "raw_device.hpp"

namespace cce {
namespace runtime {
rtError_t GetConnectUbFlagFromDrv(bool &connectUbFlag)
{
    connectUbFlag = false;
    return RT_ERROR_NONE;
}

rtError_t InitDrvEventThread(const uint32_t deviceId)
{
    COND_RETURN_WARN(&halDrvEventThreadInit == nullptr, RT_ERROR_FEATURE_NOT_SUPPORT,
        "[drv api] halDrvEventThreadInit does not exist");

    const drvError_t err = halDrvEventThreadInit(deviceId);
    COND_RETURN_ERROR_MSG_INNER(err != DRV_ERROR_NONE, RT_GET_DRV_ERRCODE(err),
        "Failed to init drv event thread, error=%#x, devId=%u", RT_GET_DRV_ERRCODE(err), deviceId);
    return RT_GET_DRV_ERRCODE(err);
}

rtError_t GetDrvSentinelMode(void)
{
    int32_t sentinelMode = 0;
    int64_t dieNum = 0;
    Driver *curDrv = nullptr;
    curDrv = Runtime::Instance()->driverFactory_.GetDriver(NPU_DRIVER);
    rtError_t err = curDrv->GetCentreNotify(11, &sentinelMode); /* index 11可以获取是否为哨兵模式 */
    COND_RETURN_ERROR_MSG_INNER(err != RT_ERROR_NONE, err,
        "Failed to get drv sentinel mode, error=%#x", err);
    err = curDrv->GetDevInfo(0, MODULE_TYPE_AICORE, INFO_TYPE_DIE_NUM, &dieNum);
    COND_RETURN_ERROR_MSG_INNER(err != RT_ERROR_NONE, err,
        "Get Ddie_die_num failed! error=%#x", err);
    // 1：to lowpower  3: lowpower
    bool mode = ((sentinelMode == 1) || (sentinelMode == 3) || (dieNum == 0)) ? true : false;
    Runtime::Instance()->SetSentinelMode(mode);
    RT_LOG(RT_LOG_INFO,"Get sentinel mode info success.sentinelMode=%u,dieNum=%lld", sentinelMode, dieNum);
    return RT_ERROR_NONE;
}

bool IsOfflineSupportMemType(const rtMemType_t &type)
{
    UNUSED(type);
    return true;
}
}  // namespace runtime
}  // namespace cce
