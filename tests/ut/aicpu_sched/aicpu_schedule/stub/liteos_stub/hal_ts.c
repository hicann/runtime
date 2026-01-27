/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "hal_ts.h"
#include "file_if.h"

drvError_t halEschedWaitEvent(uint32_t tId, void *outInfo, uint32_t *infotype,
    uint32_t *ctrlinfo,  uint32_t *outsize, int32_t timeout)
{
    return DRV_ERROR_NONE;
}
 
drvError_t halEschedAckEvent(uint32_t infoType, uint32_t ctrlInfo)
{
    return DRV_ERROR_NONE;
}

int32_t file_create(char *filename, size_t size)
{
    return 0;
}

file_t *file_open(const char *filename, const char *mode)
{
    file_t *a;
    return a;
}

int32_t file_close(file_t *file)
{
    return 0;
}

size_t file_read(void *dst, size_t size, size_t nmemb, file_t *file)
{
    return 0;
}

size_t file_write(const void *src, size_t size, size_t nmemb, file_t *file)
{
    return nmemb;
}

int32_t file_seek(file_t *file, long offset, int32_t whence)
{
    return 0;
}

long int file_tell(file_t *file)
{
    return 0;
}

uint32_t LOS_CurTaskIDGet(void)
{
    return 0;
}
drvError_t halHostMemAlloc(void **pp, unsigned long long size, unsigned long long flag)
{
    *pp = malloc(size);
    return 0;
}
void drv_uart_send(const char *fmt, ...)
{
    return;
}
drvError_t halHostMemFree(void *p)
{
    free(p);
    return 0;
}