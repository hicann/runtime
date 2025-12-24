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
#define MAX_QUEUE_SIZE (8 * 1024 * 1024)
#define MAX_QUEUE_COUNT 16
#define DRV_RECV_MAX_LEN            524288
typedef struct {
    uint32_t pid;
    uint32_t log_size;
    uint8_t endFlag; // 0 start; 1 mid; 2 end
    uint8_t reserve[23];
} TraceInfoHead;

drvError_t drvGetPlatformInfo(uint32_t *info)
{
    *info = 1; // HOST_SIDE
    return DRV_ERROR_NONE;
}

drvError_t drvGetDevNum(uint32_t *num_dev)
{
    *num_dev = 1;
    return DRV_ERROR_NONE;
}

drvError_t halGetAPIVersion(int32_t *version)
{
    *version = 0x072316U;
    return DRV_ERROR_NONE;
}

drvError_t halBindCgroupStub(BIND_CGROUP_TYPE bindType)
{
    return DRV_ERROR_NONE;
}

drvError_t halBindCgroup(BIND_CGROUP_TYPE bindType)
{
    return halBindCgroupStub(bindType);
}

drvError_t halGetDeviceInfo(uint32_t devId, int32_t moduleType, int32_t infoType, int64_t *value)
{
    if (moduleType == MODULE_TYPE_CCPU && infoType == INFO_TYPE_CORE_NUM) {
        *value = 1;
    } else if (moduleType == MODULE_TYPE_AICPU && infoType == INFO_TYPE_PF_CORE_NUM) {
        *value = 6;
    } else if (moduleType == MODULE_TYPE_DCPU && infoType == INFO_TYPE_CORE_NUM) {
        *value = 1;
    } else if (moduleType == MODULE_TYPE_AICPU && infoType == INFO_TYPE_PF_OCCUPY) {
        if (devId == 0) {
            *value = 0b11111100;
        } else if (devId == 1) {
            *value = 0b1111110000000000;
        } else {
            return DRV_ERROR_NOT_SUPPORT;
        }
    } 
    return DRV_ERROR_NONE;
}

drvError_t drvGetDevIDByLocalDevID(uint32_t localDevId, uint32_t *devId)
{
    devId = localDevId + 1;
    return DRV_ERROR_NONE;
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

int log_read_by_type(int device_id, char *buf, unsigned int *size, int timeout, enum log_channel_type channel_type)
{
    TraceInfoHead head = { 0 };
    head.pid = 0;
    head.log_size = 1024;
    memcpy_s(buf, *size, &head, sizeof(head));
    snprintf_s(buf + sizeof(head), *size - sizeof(head), *size - 1 - sizeof(head),
               "test write to os log, test write to os log, test write to os log, \
               test write to os log, test write to os log, test write to os log, \
               test write to os log, test write to os log, test write to os log, \
               test write to os log, test write to os log, test write to os log, \
               test write to os log, test write to os log, test write to os log.");
    *size = head.log_size + sizeof(TraceInfoHead);
    return 0;
}

int32_t log_read_by_type_stub_start(int device_id, char *buf, unsigned int *size, int timeout, enum log_channel_type channel_type)
{
    (void)device_id;
    (void)channel_type;
    TraceInfoHead *head = (TraceInfoHead *)buf;
    head->pid = 10;
    head->endFlag = 0;
    char *msg = "test log_read_by_type start, test log_read_by_type start, \
                test log_read_by_type start, test log_read_by_type start, \
                test log_read_by_type start, test log_read_by_type start, \
                test log_read_by_type start, test log_read_by_type start, \
                test log_read_by_type start, test log_read_by_type start.";
    strncpy_s(head + sizeof(head), *size - sizeof(head), msg, strlen(msg));
    head->log_size = strlen(msg) + 1;
    *size = head->log_size + sizeof(TraceInfoHead);
    usleep(timeout);
    return 0;
}
 
int32_t log_read_by_type_stub_middle(int device_id, char *buf, unsigned int *size, int timeout, enum log_channel_type channel_type)
{
    (void)device_id;
    (void)channel_type;
    TraceInfoHead *head = (TraceInfoHead *)buf;
    head->pid = 10;
    head->endFlag = 1;
    char *msg = "test log_read_by_type mid, test log_read_by_type mid, \
                test log_read_by_type mid, test log_read_by_type mid, \
                test log_read_by_type mid, test log_read_by_type mid, \
                test log_read_by_type mid, test log_read_by_type mid, \
                test log_read_by_type mid, test log_read_by_type mid.";
    strncpy_s(head + sizeof(head), *size - sizeof(head), msg, strlen(msg));
    head->log_size = strlen(msg) + 1;
    *size = head->log_size + sizeof(TraceInfoHead);
    usleep(timeout);
    return 0;
}
 
int32_t log_read_by_type_stub_end(int device_id, char *buf, unsigned int *size, int timeout, enum log_channel_type channel_type)
{
    (void)device_id;
    (void)channel_type;
    TraceInfoHead *head = (TraceInfoHead *)buf;
    head->pid = 10;
    head->endFlag = 2;
    char *msg = "test log_read_by_type end, test log_read_by_type end, \
                test log_read_by_type end, test log_read_by_type end, \
                test log_read_by_type end, test log_read_by_type end, \
                test log_read_by_type end, test log_read_by_type end, \
                test log_read_by_type end, test log_read_by_type end.";
    strncpy_s(head + sizeof(head), *size - sizeof(head), msg, strlen(msg));
    head->log_size = strlen(msg) + 1;
    *size = head->log_size + sizeof(TraceInfoHead);
    usleep(timeout);
    return 0;
}

int32_t log_read_by_type_stub_size_over(int device_id, char *buf, unsigned int *size, int timeout, enum log_channel_type channel_type)
{
    static int i = 0;
    if (i > MAX_QUEUE_COUNT + 1) {
        return log_read_by_type_stub_null(device_id, buf, size, timeout, channel_type);
    }
    (void)device_id;
    (void)channel_type;
    TraceInfoHead *head = (TraceInfoHead *)buf;
    head->pid = 10;
    head->endFlag = 2;
    char *msg = "test log_read_by_type over, test log_read_by_type over, \
                test log_read_by_type over, test log_read_by_type over, \
                test log_read_by_type over, test log_read_by_type over, \
                test log_read_by_type over, test log_read_by_type over, \
                test log_read_by_type over, test log_read_by_type over.";
    strncpy_s(head + sizeof(head), *size - sizeof(head), msg, strlen(msg));
    head->log_size = strlen(msg) + 1;
    *size = head->log_size + sizeof(TraceInfoHead);
    usleep(timeout);
    i++;
    return 0;
}
 
int32_t log_read_by_type_stub_null(int device_id, char *buf, unsigned int *size, int timeout, unsigned int channel_type)
{
    (void)device_id;
    (void)channel_type;
    usleep(timeout);
    return LOG_NOT_READY;
}

int32_t log_read_by_type_stub_invalid(int device_id, char *buf, unsigned int *size, int timeout, enum log_channel_type channel_type)
{
    (void)device_id;
    (void)channel_type;
    TraceInfoHead *head = (TraceInfoHead *)buf;
    head->pid = 10;
    head->endFlag = 2;
    head->log_size = DRV_RECV_MAX_LEN;
    *size = DRV_RECV_MAX_LEN;
    usleep(timeout);
    return 0;
}