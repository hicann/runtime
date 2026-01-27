/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "subscribe_manager.h"
#include "log_inner.h"
#include "error_manage.h"

#if defined(__cplusplus)
extern "C" {
#endif

uint64_t GetCurSubscribeId(void)
{
    uint32_t taskId = mmGetTaskId();
    if (taskId == MM_TASK_ID_INVALID) {
        RT_LOG_ERROR("get taskId failed.");
        return ACL_ERROR_RT_STREAM_SUBSCRIBE;
    }
    return (uint64_t)taskId;
}

rtError_t SubscribeReport(uint64_t threadId, rtStream_t stm, SUBSCRIBE_TYPE type)
{
    rtStream_t stream = stm;
    if (stream == NULL) {
        RT_LOG_ERROR("stream is NULL.");
        return ACL_ERROR_RT_PARAM_INVALID;
    }

    if (SetStreamThreadID(stream, type, threadId)) {
        drvError_t drvRet = halSqSubscribeTid(
            (uint8_t)GetStreamDeviceId(stream), (uint8_t)GetStreamSqID(stream), (uint8_t)type, (int64_t)threadId);
        if (drvRet != DRV_ERROR_NONE) {
            RT_LOG_ERROR("subscribe failed, ret=%d.", drvRet);
            ResetStreamThreadID(stream, type);
            return ErrorConvert(drvRet);
        }
        RT_LOG_INFO("subscribe success.");
    } else {
        RT_LOG_ERROR("stream has been subscribed.");
        return ACL_ERROR_RT_STREAM_SUBSCRIBE;
    }

    return ACL_RT_SUCCESS;
}

rtError_t UnSubscribeReport(uint64_t threadId, rtStream_t stm, SUBSCRIBE_TYPE type)
{
    rtStream_t stream = stm;
    if (stream == NULL) {
        RT_LOG_ERROR("stream is NULL.");
        return ACL_ERROR_RT_PARAM_INVALID;
    }

    uint64_t streamThreadId = GetStreamThreadID(stream, type);
    if ((streamThreadId != UINT64_MAX) && (streamThreadId == threadId)) {
        ResetStreamThreadID(stream, type);
        drvError_t drvRet = halSqUnSubscribeTid(
            (uint8_t)GetStreamDeviceId(stream), (uint8_t)GetStreamSqID(stream), (uint8_t)type);
        if (drvRet != DRV_ERROR_NONE) {
            RT_LOG_ERROR("unSubscribe failed, ret=%d.", drvRet);
            return ErrorConvert(drvRet);
        }
        RT_LOG_INFO("unSubscribe success.");
    } else {
        RT_LOG_ERROR("stream has not been subscribed to tid[0x%llx].", (uint64_t)threadId);
        return ACL_ERROR_RT_STREAM_SUBSCRIBE;
    }

    return ACL_RT_SUCCESS;
}

#if defined(__cplusplus)
}
#endif