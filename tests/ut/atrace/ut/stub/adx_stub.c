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
#include "adcore_api.h"

int32_t AdxRegisterService(int32_t serverType, ComponentType componentType, AdxComponentInit init,
    AdxComponentProcess process, AdxComponentUnInit uninit)
{
    return 0;
}

int32_t AdxServiceStartup(ServerInitInfo info)
{
    return 0;
}

int32_t AdxSendMsg(AdxCommConHandle handle, const char* data, uint32_t len)
{
    return 0;
}

int32_t AdxRecvMsg(AdxCommHandle handle, char **data, uint32_t *len, uint32_t timeout)
{
    return 0;
}

int32_t AdxGetAttrByCommHandle(AdxCommConHandle handle, int32_t attr, int32_t *value)
{
    *value = 0;
    return 0;
}

int32_t AdxIsCommHandleValid(AdxCommConHandle handle)
{
    if (handle == NULL) {
        return -1;
    }
    return 0;
}

void AdxDestroyCommHandle(AdxCommHandle handle)
{
    free(handle);
    return;
}