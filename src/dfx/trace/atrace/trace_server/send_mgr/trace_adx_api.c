/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "trace_adx_api.h"
#include "adcore_api.h"

int32_t TraceAdxIsCommHandleValid(const void *handle)
{
    return AdxIsCommHandleValid((AdxCommConHandle)handle);
}

void TraceAdxDestroyCommHandle(const void *handle)
{
    AdxDestroyCommHandle((AdxCommHandle)handle);
}

int32_t TraceAdxSendMsg(const void *handle, const char *data, uint32_t len)
{
    return AdxSendMsg((AdxCommConHandle)handle, data, len);
}

int32_t TraceAdxRecvMsg(const void *handle, char **data, uint32_t *len, uint32_t timeout)
{
    return AdxRecvMsg((AdxCommHandle)handle, data, len, timeout);
}

int32_t TraceAdxGetAttrByCommHandle(const void *handle, int32_t attr, int32_t *value)
{
    return AdxGetAttrByCommHandle((AdxCommConHandle)handle, attr, value);
}