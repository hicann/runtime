/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "slogd_stub.h"

#define NULL 0

char *g_iamRes = NULL;
typedef void (*IamRegister) (struct IAMVirtualResourceStatus *resList, const int32_t listNum);
IamRegister g_iamRegRes = NULL;

int32_t IAMRegisterService(const struct IAMFileConfig *config)
{
    return 0;
}

int32_t IamRegisterSystemService(void (*resMgrSysStateHandle)(int32_t))
{
    return 0;
}

int32_t IAMResMgrReady(void)
{
    g_iamRes = (char *)malloc(sizeof(char));
    return 0;
}

int32_t IAMRetrieveService(void)
{
    free(g_iamRes);
    g_iamRes = NULL;
    return 0;
}

int32_t IAMRegResStatusChangeCb(void (*ResourceStatusChangeCb)(struct IAMVirtualResourceStatus *resList,
                                                               const int32_t listNum),
                                struct IAMResourceSubscribeConfig config)
{
    for (int32_t i = 0; i < config.listNum; i++) {
        if (config.resList == NULL) {
            continue;
        }
        config.resList->status = IAM_RESOURCE_READY;
    }
    g_iamRegRes = ResourceStatusChangeCb;
    return 0;
}

void ResChangeStatus(char *IAMResName, enum IAMResourceStatus status)
{
    if (g_iamRegRes != NULL) {
        struct IAMVirtualResourceStatus virtualResStatus = { 0 };
        snprintf_s(virtualResStatus.IAMResName, IAM_RESOURCE_NAME_SIZE, IAM_RESOURCE_NAME_SIZE - 1, "%s", IAMResName);
        virtualResStatus.status = status;
        g_iamRegRes(&virtualResStatus, 1);
    }
}

int32_t IAMUnregResStatusChangeCb(void)
{
    g_iamRegRes = NULL;
    return 0;
}

int32_t IAMUnregAssignedResStatusChangeCb(const char * const resName)
{
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

int log_set_level(int device_id, int channel_type, unsigned int log_level)
{
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

drvError_t drvDeviceStatus(uint32_t devId, drvStatus_t *status)
{
    *status = DRV_STATUS_WORK;
    return DRV_ERROR_NONE;
}

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
// driver_hdc
#define HDC_RECV_MAX_LEN 524288 // 512KB buffer space
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