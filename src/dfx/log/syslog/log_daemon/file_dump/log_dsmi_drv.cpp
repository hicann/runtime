/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "log_dsmi_drv.h"
#include "mmpa_api.h"
#include "log_print.h"
namespace Adx {
/**
 * @brief       : get env info by HDC session, is docker or not
 * @param [in]  : session    hdc session handle
 * @param [in]  : runEnv     1 non-docker 2 docker
 * @return      : SYS_OK     get hdc session succ
 *                SYS_ERROR  get hdc session failed
 */
int32_t LogIdeGetRunEnvBySession(HDC_SESSION session, IdeI32Pt runEnv)
{
    ONE_ACT_ERR_LOG(session == nullptr, return SYS_ERROR, "session is nullptr");
    ONE_ACT_ERR_LOG(runEnv == nullptr, return SYS_ERROR, "runEnv is nullptr");

    hdcError_t err = halHdcGetSessionAttr(session, HDC_SESSION_ATTR_RUN_ENV, runEnv);
    if (err != DRV_ERROR_NONE) {
        SELF_LOG_ERROR("Hdc Get Session runEnv Failed, err: %d", err);
        return SYS_ERROR;
    }

    return SYS_OK;
}

/**
 * @brief       : get pid info by HDC session
 * @param [in]  : session    hdc session handle
 * @param [in]  : pid        app pid
 * @return      : SYS_OK     get hdc session succ
 *                SYS_ERROR: get hdc session failed
 */
int32_t LogIdeGetPidBySession(HDC_SESSION session, IdeI32Pt pid)
{
    ONE_ACT_ERR_LOG(session == nullptr, return SYS_ERROR, "session is nullptr");
    ONE_ACT_ERR_LOG(pid == nullptr, return SYS_ERROR, "pid is nullptr");

    hdcError_t err = halHdcGetSessionAttr(session, HDC_SESSION_ATTR_PEER_CREATE_PID, pid);
    if (err != DRV_ERROR_NONE) {
        SELF_LOG_ERROR("Hdc Get Session runEnv Failed, err: %d", err);
        return SYS_ERROR;
    }

    return SYS_OK;
}
}
