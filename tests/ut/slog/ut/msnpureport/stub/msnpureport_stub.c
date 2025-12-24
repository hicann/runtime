/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "msnpureport_stub.h"
#include "msnpureport_level.h"
#include "msn_operate_log_level.h"
#include "log_file_util.h"
#include "adcore_api.h"
#include "dsmi_common_interface.h"

#ifndef INFO_TYPE_PRODUCT_TYPE
#define INFO_TYPE_PRODUCT_TYPE 100
#endif
int AdxGetDeviceFile(unsigned short devId, const char *desPath, const char *logType)
{
    return 0;
}

int32_t AdxGetDeviceFileTimeout(uint16_t devId, IdeString desPath, IdeString logType, uint32_t timeout)
{
    return 0;
}

int32_t AdxGetSpecifiedFile(uint16_t devId, IdeString desPath, IdeString logType, int32_t hdcType, int32_t compType)
{
    return 0;
}

drvError_t drvGetDevNum(uint32_t *num_dev)
{
    *num_dev = 1;
    return 0;
}

drvError_t drvGetDevIDs(uint32_t *devices, uint32_t len)
{
    devices[0] = 0;
    devices[1] = 1;
    return 0;
}

drvError_t drvDeviceGetIndexByPhyId(uint32_t phyId, uint32_t *devIndex)
{
    return 0;
}

drvError_t drvDeviceGetPhyIdByIndex(uint32_t devIndex, uint32_t *phyId)
{
    *phyId = devIndex;
    return 0;
}


drvError_t halGetDeviceInfo(uint32_t devId, int32_t moduleType, int32_t infoType, int64_t *value)
{
    if (infoType == (int32_t)INFO_TYPE_MASTERID) {
        *value = 2;
    } else if (infoType == INFO_TYPE_PRODUCT_TYPE) {
        return DRV_ERROR_NOT_SUPPORT;
    }
    return DRV_ERROR_NONE;
}

drvError_t drvDeviceStatus(uint32_t devId, drvStatus_t *status)
{
    *status = DRV_STATUS_COMMUNICATION_LOST;
    return DRV_ERROR_NONE;
}

int BboxStartDump(const char *path, int pSize, const struct BboxDumpOpt *opt)
{
    return 0;
}

void BboxStopDump(void)
{

}

int32_t AdxSendMsg(const CommHandle *handle, AdxString data, uint32_t len)
{
    return 0;
}

int32_t AdxSendMsgAndGetResultByType(AdxHdcServiceType type, IdeTlvConReq req, const AdxStringBuffer result,
    uint32_t resultLen)
{
    return 0;
}

int32_t AdxDevCommShortLink(AdxHdcServiceType type, AdxTlvConReq req, AdxStringBuffer result, uint32_t length,
    uint32_t timeout)
{
    return 0;
}

INT32 ToolAccess(const CHAR *lpPathName);

drvError_t halGetDeviceInfoByBuff(uint32_t devId, int32_t moduleType, int32_t infoType, void *buf, int32_t *size)
{
    return 0;
}

AdxCommHandle AdxCreateCommHandle(AdxHdcServiceType type, int32_t devId, ComponentType compType)
{
    return (AdxCommHandle)malloc(sizeof(CommHandle));
}

int32_t AdxRecvMsg(AdxCommHandle handle, char **data, uint32_t *len, uint32_t timeout)
{
    return 0;
}

void AdxDestroyCommHandle(AdxCommHandle handle)
{
    if (handle != NULL) {
        free(handle);
    }
}

int32_t AdxIsCommHandleValid(AdxCommConHandle handle)
{
    if ((handle == NULL) || (handle->session == 0)) {
        return IDE_DAEMON_ERROR;
    }
    return IDE_DAEMON_OK;
}

int32_t AdxRecvDevFileTimeout(AdxCommHandle handle, AdxString desPath, uint32_t timeout, char *fileName,
    uint32_t fileNameLen)
{
    return IDE_DAEMON_OK;
}

int dsmi_subscribe_fault_event(int device_id, struct dsmi_event_filter filter, fault_event_callback handler)
{
    struct dsmi_event event = {DMS_FAULT_EVENT, {1234, 0}};
    if (handler == NULL) {
        return -1;
    }
    handler(&event);
    return 0;
}

void *DlopenStub(const char *filename, int flags)
{
    if (strcmp(filename, "libdrvdsmi_host.so") == 0) {
        return (void *)0x12345;
    }
    return NULL;
}

void *DlsymStub(void *handle, const char *symbol)
{
    if (strcmp(symbol, "dsmi_subscribe_fault_event") == 0) {
        return (void *)dsmi_subscribe_fault_event;
    }
    return NULL;
}

drvError_t halGetDeviceInfo_stub(uint32_t devId, int32_t moduleType, int32_t infoType, int64_t *value)
{
    *value = 0; // pooling
    return 0;
}