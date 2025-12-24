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

int32_t LogGetSigNo_stub(void)
{
    static count = 0;
    count++;
    sleep(1);
    if (count > 10) {
        return 15;
    }
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

// driver_hdc
#define HDC_RECV_MAX_LEN 524288 // 512KB buffer space

drvError_t drvHdcSessionClose(HDC_SESSION session)
{
    return DRV_ERROR_NONE;
}

drvError_t drvHdcAllocMsg(HDC_SESSION session, struct drvHdcMsg **ppMsg, int count)
{
    struct drvHdcMsg *msg = (struct drvHdcMsg *)calloc(1, sizeof(struct drvHdcMsg));
    if (msg == NULL) {
        printf("calloc hdc msg failed.\n");
        return DRV_ERROR_RESERVED;
    }
    *ppMsg = msg;
    return DRV_ERROR_NONE;
}

drvError_t drvHdcFreeMsg(struct drvHdcMsg *msg)
{
    free(msg);
    msg = NULL;
    return DRV_ERROR_NONE;
}

drvError_t drvHdcReuseMsg(struct drvHdcMsg *msg)
{
    return DRV_ERROR_NONE;
}

drvError_t drvHdcAddMsgBuffer(struct drvHdcMsg *msg, char *pBuf, int len)
{
    return DRV_ERROR_NONE;
}

drvError_t drvHdcGetCapacity(struct drvHdcCapacity *capacity)
{
    capacity->chanType = HDC_CHAN_TYPE_PCIE;
    capacity->maxSegment = HDC_RECV_MAX_LEN;
    return DRV_ERROR_NONE;
}

drvError_t halHdcGetSessionAttr(HDC_SESSION session, int attr, int *value)
{
    value = 1; // 1 non-docker; 2 docker
    return DRV_ERROR_NONE;
}

hdcError_t halHdcSend(HDC_SESSION session, struct drvHdcMsg *pMsg, UINT64 flag, UINT32 timeout)
{
    return DRV_ERROR_NONE;
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

drvError_t drvDeviceStatus(uint32_t devId, drvStatus_t *status)
{
    status = DRV_STATUS_WORK;
    return DRV_ERROR_NONE;
}

// driver_log
int log_set_level(int device_id, int channel_type, unsigned int log_level)
{
    return 0;
}

int log_get_channel_type(int device_id, int *channel_type_set, int *channel_type_num, int set_size)
{
    channel_type_set[0] = LOG_CHANNEL_TYPE_TS;
    channel_type_set[1] = LOG_CHANNEL_TYPE_MCU_DUMP;
    channel_type_set[2] = LOG_CHANNEL_TYPE_LPM3;
    channel_type_set[3] = LOG_CHANNEL_TYPE_IMU;
    channel_type_set[4] = LOG_CHANNEL_TYPE_IMP;
    channel_type_set[5] = LOG_CHANNEL_TYPE_ISP;
    channel_type_set[6] = LOG_CHANNEL_TYPE_SIS;
    channel_type_set[7] = LOG_CHANNEL_TYPE_SIS_BIST;
    channel_type_set[8] = LOG_CHANNEL_TYPE_HSM;
    channel_type_set[9] = LOG_CHANNEL_TYPE_RTC;
    channel_type_set[10] = LOG_CHANNEL_TYPE_MAX - 1;
    *channel_type_num = 11;
    return 0;
}

drvError_t halGetDevNumEx(uint32_t hw_type, uint32_t *devNum)
{
    if (hw_type == 0) {
        *devNum = 1;
        return 0;
    } else {
        *devNum = 0;
        return 1;
    }
}

drvError_t halGetDevIDsEx(uint32_t hw_type, uint32_t *devices, uint32_t len)
{
    if (hw_type == 0) {
        devices[0] = 0;
        return 0;
    } else {
        return 1;
    }
}

int log_read(int device_id, char *buf, unsigned int *size, int timeout)
{
    LogMsgHead msgHead = { 0 };
    char buffer[1024] = "test for firmware log.\n";
    msgHead.dataLen = strlen(buffer) + 1;
    memcpy_s(buf, 1024, &msgHead, sizeof(LogMsgHead));
    memcpy_s(buf + sizeof(LogMsgHead), 1024 - sizeof(LogMsgHead), buffer, strlen(buffer) + 1);
    *size = sizeof(LogMsgHead) + strlen(buffer) + 1;
    usleep(timeout * 1000);
    return 0;
}

int log_read_by_type(int device_id, char *buf, unsigned int *size, int timeout, enum log_channel_type channel_type)
{
    (void)device_id;
    (void)buf;
    (void)size;
    (void)channel_type;
    usleep(timeout);
    return LOG_NOT_READY;
}

int32_t log_read_by_type_stub_no_data(int device_id, char *buf, unsigned int *size, int timeout, enum log_channel_type channel_type)
{
    (void)device_id;
    static int cnt = 0;
    cnt++;
    if (cnt == 1) {
        return LOG_NOT_SUPPORT;
    } else if (cnt == 2) {
        return LOG_ERROR;
    } else if (cnt >= 3) {
        usleep(timeout);
        return LOG_NOT_READY;
    }
}

int32_t log_read_by_type_stub_data(int device_id, char *buf, unsigned int *size, int timeout, enum log_channel_type channel_type)
{
    char msg[1024] = { 0 };
    if (channel_type == LOG_CHANNEL_TYPE_EVENT) {
        static int i = 0;
        snprintf_s(msg, 1024, 1024, "[EVENT] test for event log, index = %d.\n", i);
        i++;
    } else {
        static int j = 0;
        snprintf_s(msg, 1024, 1024, "test for log, index = %d.\n", j);
        j++;
    }

    memcpy_s(buf, 1024, msg, strlen(msg) + 1);
    *size = strlen(msg);
    usleep(10000);
    return LOG_OK;
}

drvError_t halGetDeviceInfo_stub(uint32_t devId, int32_t moduleType, int32_t infoType, int64_t *value)
{
    *value = 0; // pooling
    return 0;
}