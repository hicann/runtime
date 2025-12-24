/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "ascend_hal.h"
#include "log_common.h"

drvError_t halGetDeviceInfo(uint32_t devId, int32_t moduleType, int32_t infoType, int64_t *value)
{
    return DRV_ERROR_NOT_SUPPORT;
}

int log_set_dfx_param(uint32_t devid, uint32_t chan_type, void *data, uint32_t data_len)
{
    (void)devid;
    (void)chan_type;
    (void)data;
    (void)data_len;
    return 0;
}
int log_get_dfx_param(uint32_t device_id, uint32_t channel_type, void *data, uint32_t dataLen)
{
    (void)device_id;
    (void)channel_type;
    (void)data;
    (void)dataLen;
    return 0;
}

typedef struct {
    uint32_t size;
    void *buffer;
} bufMgr;

#define MAX_DEV_NUM             64

static bufMgr g_buffer[LOG_TYPE_MAX_NUM][MAX_DEV_NUM] = { 0 };
void *log_type_alloc_mem(uint32_t device_id, uint32_t type, uint32_t *size)
{
    if (g_buffer[type][device_id].buffer == NULL) {
        g_buffer[type][device_id].buffer = malloc(*size);
        memset_s(g_buffer[type][device_id].buffer, *size, 0, *size);
        g_buffer[type][device_id].size = *size;
    }
    *size = g_buffer[type][device_id].size;
    return g_buffer[type][device_id].buffer;
}

void log_release_buffer(void)
{
    for (int i = 0; i < LOG_TYPE_MAX_NUM; i++) {
        for (int j = 0; j < MAX_DEV_NUM; j++) {
            if (g_buffer[i][j].buffer != NULL) {
                free(g_buffer[i][j].buffer);
            }
            g_buffer[i][j].buffer = NULL;
        }
    }
}