/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "runtime/kernel.h"
#include "hal_ts.h"
#include "error_codes/rt_error_codes.h"
#include "error_manage.h"
#include "log_inner.h"
#include "subscribe_manager.h"

#if defined(__cplusplus)
extern "C" {
#endif

rtError_t rtSubscribeHostFunc(uint64_t threadId, rtStream_t stream)
{
    return SubscribeReport(threadId, stream, SUBSCRIBE_HOSTFUNC);
}

rtError_t rtProcessHostFunc(int32_t timeout)
{
    if ((timeout < -1) || (timeout == 0)) {
        RT_LOG_ERROR("Invalid timeout, [%d]", timeout);
        return ACL_ERROR_RT_PARAM_INVALID;
    }
    uint64_t subscribeUUID = GetCurSubscribeId();
    if (subscribeUUID == UINT64_MAX) {
        return ACL_ERROR_RT_THREAD_SUBSCRIBE;
    }
    drvError_t drvRet = halHostFuncWait((timeout == -1) ? 0 : timeout, (int64_t)subscribeUUID);
    if (drvRet != DRV_ERROR_NONE) {
        if (drvRet == DRV_ERROR_WAIT_TIMEOUT) {
            RT_LOG_WARNING("Wait timeout, ret=%d", drvRet);
        } else {
            RT_LOG_ERROR("Wait failed, ret=%d", drvRet);
        }
        return ErrorConvert(drvRet);
    }
    return ACL_RT_SUCCESS;
}

rtError_t rtUnSubscribeHostFunc(uint64_t threadId, rtStream_t stream)
{
    return UnSubscribeReport(threadId, stream, SUBSCRIBE_HOSTFUNC);
}

#if defined(__cplusplus)
}
#endif
