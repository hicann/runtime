/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "log_hdc_server.h"
#include "ascend_hal.h"
#include "log_hdc.h"
#include "log_print.h"
#include "server_register.h"
#include "adx_component_api_c.h"
using namespace Adx;

int32_t LogHdcServerInit(const struct LogServerInitInfo *info)
{
    int32_t err = SYS_ERROR;
    std::unique_ptr<AdxComponent> cpn(new(std::nothrow)LogHdc());
    ONE_ACT_ERR_LOG(cpn == nullptr, return err, "init component error");
    err = AdxRegisterComponentFunc(HDC_SERVICE_TYPE_LOG, cpn);
    ONE_ACT_ERR_LOG(err != SYS_OK, return err, "register component func error");
    err = AdxRegisterService(static_cast<int32_t>(HDC_SERVICE_TYPE_LOG),
        ComponentType::COMPONENT_SYS_GET, SysGetInit, SysGetProcess, SysGetDestroy);
    ONE_ACT_ERR_LOG(err != SYS_OK, return err, "register sys get component func C error");
    err = AdxRegisterService(static_cast<int32_t>(HDC_SERVICE_TYPE_LOG),
        ComponentType::COMPONENT_SYS_REPORT, SysReportInit, SysReportProcess, SysReportDestroy);
    ONE_ACT_ERR_LOG(err != SYS_OK, return err, "register sys report component func C error");
    ServerInitInfo serverInfo{static_cast<int32_t>(HDC_SERVICE_TYPE_LOG), info->mode, info->deviceId};
    err = AdxComponentServerStartup(serverInfo);
    ONE_ACT_ERR_LOG(err != SYS_OK, return err, "startup component server error");
    return err;
}
