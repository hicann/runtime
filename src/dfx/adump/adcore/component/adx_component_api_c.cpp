/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "adx_component_api_c.h"
#include "server_register.h"
#include "adx_common_component.h"
#include "log/adx_log.h"
#include "extra_config.h"
#include "ascend_hal.h"
using namespace Adx;
int32_t AdxRegisterService(int32_t serverType, ComponentType componentType, AdxComponentInit init,
    AdxComponentProcess process, AdxComponentUnInit uninit)
{
    std::unique_ptr<AdxComponent> commonComponent(new (std::nothrow)
        AdxCommonComponent(init, process, uninit, componentType));
    IDE_CTRL_VALUE_FAILED(commonComponent != nullptr, return IDE_DAEMON_ERROR, "create common component error");
    return AdxRegisterComponentFunc(static_cast<drvHdcServiceType>(serverType), commonComponent);
}

int32_t AdxUnRegisterService(int32_t serverType, ComponentType componentType)
{
    return AdxComponentServerCleanup(static_cast<drvHdcServiceType>(serverType), componentType);
}

int32_t AdxServiceStartup(ServerInitInfo info)
{
    return AdxComponentServerStartup(info);
}

int32_t AdxServiceCleanup(int32_t serverType)
{
    return AdxComponentServerCleanup(static_cast<drvHdcServiceType>(serverType));
}