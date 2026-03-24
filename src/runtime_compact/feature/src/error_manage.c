/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include <stdlib.h>
#include "error_manage.h"

#if defined(__cplusplus)
extern "C" {
#endif

struct ErrorMessage {
    int32_t drvError;
    int32_t rtError;
};

// g_errorMap is sorted by the first column.
static struct ErrorMessage g_errorMap[] = {
    {DRV_ERROR_NONE, ACL_RT_SUCCESS},
    {DRV_ERROR_NO_DEVICE, ACL_ERROR_RT_NO_DEVICE},
    {DRV_ERROR_INVALID_DEVICE, ACL_ERROR_RT_INVALID_DEVICEID},
    {DRV_ERROR_INVALID_VALUE, ACL_ERROR_RT_PARAM_INVALID},
    {DRV_ERROR_INVALID_HANDLE, ACL_ERROR_RT_INVALID_HANDLE},
    {DRV_ERROR_INVALID_MALLOC_TYPE, ACL_ERROR_RT_INVALID_MALLOC_TYPE},
    {DRV_ERROR_OUT_OF_MEMORY, ACL_ERROR_RT_MEMORY_ALLOCATION},
    {DRV_ERROR_REPEATED_INIT, ACL_ERROR_RT_REPEATED_INIT},
    {DRV_ERROR_NO_RESOURCES, ACL_ERROR_RT_RESOURCE_ALLOC_FAIL},
    {DRV_ERROR_WAIT_TIMEOUT, ACL_ERROR_RT_REPORT_TIMEOUT},
    {DRV_ERROR_IOCRL_FAIL, ACL_ERROR_RT_DRV_INTERNAL_ERROR},
    {DRV_ERROR_SOCKET_CLOSE, ACL_ERROR_RT_SOCKET_CLOSE},
    {DRV_ERROR_SEND_MESG, ACL_ERROR_RT_SEND_MSG},
    {DRV_ERROR_BUS_DOWN, ACL_ERROR_RT_LOST_HEARTBEAT},
    {DRV_ERROR_OVER_LIMIT, ACL_ERROR_RT_OVER_LIMIT},
    {DRV_ERROR_MALLOC_FAIL, ACL_ERROR_RT_RESOURCE_ALLOC_FAIL},
    {DRV_ERROR_DEV_PROCESS_HANG, ACL_ERROR_RT_LOST_HEARTBEAT},
    {DRV_ERROR_OPER_NOT_PERMITTED, ACL_ERROR_RT_NO_PERMISSION},
    {DRV_ERROR_NO_EVENT_RESOURCES, ACL_ERROR_RT_NO_EVENT_RESOURCE},
    {DRV_ERROR_NO_STREAM_RESOURCES, ACL_ERROR_RT_NO_STREAM_RESOURCE},
    {DRV_ERROR_NO_NOTIFY_RESOURCES, ACL_ERROR_RT_NO_NOTIFY_RESOURCE},
    {DRV_ERROR_NO_MODEL_RESOURCES, ACL_ERROR_RT_DRV_INTERNAL_ERROR},
    {DRV_ERROR_MEMORY_OPT_FAIL, ACL_ERROR_RT_PARAM_INVALID},
    {DRV_ERROR_COPY_USER_FAIL, ACL_ERROR_RT_COPY_DATA},
    {DRV_ERROR_QUEUE_EMPTY, ACL_ERROR_RT_QUEUE_EMPTY},
    {DRV_ERROR_QUEUE_FULL, ACL_ERROR_RT_QUEUE_FULL},
    {DRV_ERROR_CDQ_ABNORMAL, ACL_ERROR_RT_CDQ_BATCH_ABNORMAL},
    {DRV_ERROR_CDQ_NOT_EXIST, ACL_ERROR_RT_PARAM_INVALID},
    {DRV_ERROR_NO_CDQ_RESOURCES, ACL_ERROR_RT_NO_CDQ_RESOURCE},
    {DRV_ERROR_NOT_SUPPORT, ACL_ERROR_RT_FEATURE_NOT_SUPPORT}
};

static int Compare(const void* a, const void* b)
{
    return ((*(const struct ErrorMessage *)a).drvError - (*(const struct ErrorMessage *)b).drvError) ;
}

int32_t ErrorConvert(int32_t drvError)
{
    struct ErrorMessage errorPair = {drvError, 0};
    static size_t errorMapLen = sizeof(g_errorMap) / sizeof(g_errorMap[0]);
    static size_t errorPairLen = sizeof(g_errorMap[0]);

    struct ErrorMessage *ret =
        (struct ErrorMessage *)bsearch(&errorPair, g_errorMap, errorMapLen, errorPairLen, Compare);
    if (ret != NULL) {
        return (*ret).rtError;
    }
    return ACL_ERROR_RT_DRV_INTERNAL_ERROR;
}

#if defined(__cplusplus)
}
#endif