/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "ascend_hal_stub.h"
#include "slogd_buffer.h"
#include "log_recv_interface.h"
#include "zlib.h"

#define BLOCK_SIZE          (1024 * 1024) // 1MB
static char g_deflateIn[BLOCK_SIZE] = { 0 };
static char g_deflateOut[BLOCK_SIZE] = { 0 };
int hw_deflateInit2_(struct zip_stream *zstrm, int level, int method, int windowBits,
                     int memLevel, int strategy, const char *version, int stream_size)
{
    memset_s(zstrm, sizeof(struct zip_stream), 0, sizeof(struct zip_stream));
    zstrm->next_in = g_deflateIn;
    memset_s(zstrm->next_in, BLOCK_SIZE, 0, BLOCK_SIZE);
    zstrm->next_out = g_deflateOut;
    memset_s(zstrm->next_out, BLOCK_SIZE, 0, BLOCK_SIZE);
    return 0;
}
int hw_deflate(struct zip_stream *zstrm, int flush)
{
    uint64_t outLen = zstrm->avail_out;
    compress(zstrm->next_out, &outLen, zstrm->next_in, zstrm->avail_in);
    zstrm->avail_out = zstrm->avail_out - outLen;
    return 0;
}
int hw_deflateEnd(struct zip_stream *zstrm)
{
    return 0;
}

// log_server.a存在部分依赖，解耦后去掉打桩
int32_t LogHdcServerInit(const struct LogServerInitInfo *info)
{
    return 0;
}
// appmon
int appmon_client_init(client_info_t *clnt, const char *serv_addr)
{
    return 0;
}
int appmon_client_register(client_info_t *clnt, unsigned long timeout, const char *timeout_action)
{
    return 0;
}

int appmon_client_heartbeat(client_info_t *clnt)
{
    return 0;
}

drvError_t halGetDeviceInfo(uint32_t devId, int32_t moduleType, int32_t infoType, int64_t *value)
{
    return DRV_ERROR_NOT_SUPPORT;
}

// driver_device_mgr
drvError_t drvGetDevNum(uint32_t *num_dev)
{
    *num_dev = 1;
    return 0;
}

drvError_t drvGetDevIDByLocalDevID(uint32_t localDevId, uint32_t *devId)
{
    devId = 0;
    return 0;
}


// driver_log
typedef struct {
    uint32_t size;
    void *buffer;
} bufMgr;

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
            XFREE(g_buffer[i][j].buffer);
        }
    }
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