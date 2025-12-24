/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include <stdarg.h>
#include "adcore_api.h"

// stub for bbox_proc
void BboxStartMainThread(void)
{
    return;
}

void BboxStopMainThread(void)
{
    return;
}

// stub for stackcore
int StackMonitor(void)
{
    return 0;
}

void StackRegisterPrint(void (*printFunc)(const char *format, ...))
{
    return;
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
    if (attr == HDC_SESSION_ATTR_RUN_ENV) {
        *value = 1; // 1 non-docker; 2 docker
    }
    if (attr == HDC_SESSION_ATTR_VFID) {
        *value = 0;
    }
    if (attr == HDC_SESSION_ATTR_STATUS) {
        *value = 1; // 1 connect; 2 closed
    }
    return DRV_ERROR_NONE;
}

hdcError_t halHdcSend(HDC_SESSION session, struct drvHdcMsg *pMsg, UINT64 flag, UINT32 timeout)
{
    return DRV_ERROR_NONE;
}

hdcError_t halGetDeviceInfoByBuff(uint32_t devId, int32_t moduleType, int32_t infoType, void *buf, int32_t *size)
{
    memcpy(buf, "VERSION", 7);
    return DRV_ERROR_NONE;
}

int32_t AdxSendMsgByHandle(const CommHandle *handle, CmdClassT type, IdeString data, uint32_t len)
{
    return 0;
}

int32_t AdxGetAttrByCommHandle(const CommHandle *handle, int32_t attr, int32_t *value)
{
    return (int32_t)halHdcGetSessionAttr(handle->session, attr, value);
}

int32_t AdxSendMsg(const CommHandle *handle, AdxString data, uint32_t len)
{
    (void)handle;
    (void)data;
    (void)len;
    return 0;
}

int32_t AdxRecvMsg(AdxCommHandle handle, char **data, uint32_t *len, uint32_t timeout)
{
    return 0;
}

int32_t AdxServiceStartup(ServerInitInfo info)
{
    return 0;
}

int32_t AdxServiceCleanup(int32_t serverType)
{
    return 0;
}

int32_t FileDumpInit(void)
{
    return 0;
}

int32_t FileDumpExit(void)
{
    return 0;
}

int32_t AdxSendFileByHandle(AdxCommConHandle handle, CmdClassT type, AdxString srcPath, AdxString desPath,
    SendFileType flag)
{
    return 0;
}

int32_t HdclogDeviceInit(void)
{
    return 0;
}

int32_t HdclogDeviceDestroy(void)
{
    return 0;
}

int32_t IdeDeviceLogProcess(const CommHandle *command, const void* value, uint32_t len)
{
    return 0;
}
static int g_cpuAlarmNum = 0;
static int g_cpuStatNum = 0;
static int g_memAlarmNum = 0;
static int g_memStatNum = 0;
static int g_fdAlarmNum = 0;
static int g_fdTopNum = 0;
static int g_fdStatNum = 0;
static int g_zpAlarmNum = 0;
static int g_zpStatNum = 0;
static int g_frameStart = 0;

int LogGetCpuAlarmNum(void)
{
    return g_cpuAlarmNum;
}

int LogGetCpuStatNum(void)
{
    return g_cpuStatNum;
}

int LogGetMemAlarmNum(void)
{
    return g_memAlarmNum;
}

int LogGetMemStatNum(void)
{
    return g_memStatNum;
}

int LogGetFdAlarmNum(void)
{
    return g_fdAlarmNum;
}

int LogGetFdTopNum(void)
{
    return g_fdTopNum;
}

int LogGetFdStatNum(void)
{
    return g_fdStatNum;
}

int LogGetZpAlarmNum(void)
{
    return g_zpAlarmNum;
}

int LogGetZpStatNum(void)
{
    return g_zpStatNum;
}

int LogGetFrameStart(void)
{
    return g_frameStart;
}

void LogClearPrintNum(void)
{
    g_cpuAlarmNum = 0;
    g_cpuStatNum = 0;
    g_memAlarmNum = 0;
    g_memStatNum = 0;
    g_fdAlarmNum = 0;
    g_fdTopNum = 0;
    g_fdStatNum = 0;
    g_zpAlarmNum = 0;
    g_zpStatNum = 0;
    g_frameStart = 0;
}

#define LLT_DLOG_DEBUG         0x0            // debug level id
#define LLT_DLOG_INFO          0x1            // info level id
#define LLT_DLOG_WARN          0x2            // warning level id
#define LLT_DLOG_ERROR         0x3            // error level id
#define LLT_MODULE_SLOG        73             // SYSMONITOR
#define LLT_LOG_MAX_LEN        1024
#define LLT_CPU_ALARM_LOG      "cpu usage alarm, total"
#define LLT_CPU_STAT_LOG       "cpu usage stat"
#define LLT_MEM_ALARM_LOG      "memory usage alarm"
#define LLT_MEM_STAT_LOG       "memory usage stat"
#define LLT_FD_ALARM_LOG       "fd usage alarm"
#define LLT_FD_TOP_LOG         "fd used"
#define LLT_FD_STAT_LOG        "fd usage stat"
#define LLT_ZP_ALARM_LOG       "zombie process count alarm"
#define LLT_ZP_STAT_LOG        "zombie process count stat"
#define LLT_FRAME_START_LOG    "system resource monitor start"

int CheckLogLevel(int moduleId, int logLevel)
{
    return 1;
}

void DlogRecord(int moduleId, int level, const char *fmt, ...)
{
    if (fmt == NULL) {
        return;
    }

    if (moduleId == LLT_MODULE_SLOG) {
        return;
    }

    va_list args;
    va_start(args, fmt);
    char msg[LLT_LOG_MAX_LEN] = { 0 };
    vsnprintf_s(msg, LLT_LOG_MAX_LEN - 1, LLT_LOG_MAX_LEN - 1, fmt, args);
    va_end(args);

    if (strstr(msg, LLT_CPU_ALARM_LOG) != NULL) {
        g_cpuAlarmNum++;
    } else if (strstr(msg, LLT_CPU_STAT_LOG) != NULL){
        g_cpuStatNum++;
    } else if (strstr(msg, LLT_MEM_ALARM_LOG) != NULL){
        g_memAlarmNum++;
    } else if (strstr(msg, LLT_MEM_STAT_LOG) != NULL){
        g_memStatNum++;
    } else if (strstr(msg, LLT_FD_ALARM_LOG) != NULL){
        g_fdAlarmNum++;
    } else if (strstr(msg, LLT_FD_TOP_LOG) != NULL){
        g_fdTopNum++;
    } else if (strstr(msg, LLT_FD_STAT_LOG) != NULL){
        g_fdStatNum++;
    } else if (strstr(msg, LLT_ZP_ALARM_LOG) != NULL){
        g_zpAlarmNum++;
    } else if (strstr(msg, LLT_ZP_STAT_LOG) != NULL){
        g_zpStatNum++;
    } else if (strstr(msg, LLT_FRAME_START_LOG) != NULL){
        g_frameStart++;
    }
}

drvError_t drvGetDevIDByLocalDevID(uint32_t localDevId, uint32_t *devId)
{
    devId = 0;
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

void AdxDestroyCommHandle(AdxCommHandle handle)
{
    return;
}

int AdxRegisterService(int serverType, ComponentType componentType, AdxComponentInit init,
    AdxComponentProcess process, AdxComponentUnInit uninit)
{
    return 0;
}

int AdxUnRegisterService(int32_t serverType, ComponentType componentType)
{
    return 0;
}