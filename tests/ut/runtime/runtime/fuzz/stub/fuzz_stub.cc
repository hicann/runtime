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

#include "securec.h"
#include "driver/ascend_hal.h"
#include "driver/ascend_inpackage_hal.h"
#include "task.hpp"
#include "base.hpp"

#define MAX_DEVICE_NUM  2
#define MAX_LOG_BUF_SIZE 2048

using namespace cce::runtime;

DVresult drvMemSmmuQuery(DVdevice device, UINT32 *SSID)
{
    return DRV_ERROR_NONE;
}

drvError_t drvMemAllocL2buffAddr (DVdevice device, void **l2buff, UINT64 *pte)
{
    return DRV_ERROR_NONE;
}

drvError_t drvMemReleaseL2buffAddr (DVdevice device, void *l2buff)
{
    return DRV_ERROR_NONE;
}

drvError_t drvDeviceOpen(void **device, uint32_t deviceId)
{
    //*device = deviceId;
    return DRV_ERROR_NONE;
}
drvError_t drvDeviceClose(uint32_t devId)
{
    return DRV_ERROR_NONE;
}

drvError_t drvDevicePowerUp(uint32_t devId)
{
    return DRV_ERROR_NONE;
}

drvError_t drvDevicePowerDown(uint32_t devId)
{
    return DRV_ERROR_NONE;
}

drvError_t drvDeviceReboot(uint32_t devId)
{
    return DRV_ERROR_NONE;
}

drvError_t drvGetDevNum(int32_t *count)
{
    *count = MAX_DEVICE_NUM;
    return DRV_ERROR_NONE;
}
drvError_t drvGetDevIDs(uint32_t *devices, uint32_t len)
{
    return DRV_ERROR_NONE;
}

drvError_t halGetDeviceInfo(uint32_t devId, int32_t moduleType, int32_t infoType, int64_t *value)
{
    if (value) {
        *value = 0;
    }
    return DRV_ERROR_NONE;
}

drvError_t drvEventIdAlloc(uint32_t device, drvEventIdInfo *info)
{
    info->eventId=1;
    return DRV_ERROR_NONE;
}

drvError_t drvEventIdFree(uint32_t device, drvEventIdInfo* info)
{
    return DRV_ERROR_NONE;
}

drvError_t drvStreamIdAlloc(uint32_t device, drvStreamIdInfo* info)
{
    info->streamId = 1;
    return DRV_ERROR_NONE;
}

drvError_t drvStreamIdFree(uint32_t device, drvStreamIdInfo* info)
{
    return DRV_ERROR_NONE;
}

static volatile int32_t sendCount[MAX_DEVICE_NUM] = { 0 };
static volatile int32_t recvCount[MAX_DEVICE_NUM] = { 0 };
static rtTaskReport_t g_report[MAX_DEVICE_NUM][2][Task::MAX_REPORT_COUNT]; //pingpong
static int32_t g_reportCount[MAX_DEVICE_NUM][2] = { 0 };
static rtCommand_t g_command[MAX_DEVICE_NUM];
static uint64_t g_timeStamp[MAX_DEVICE_NUM] = { 0 };
static int32_t mallocbuff[1024*1024] = {0};

drvError_t drvCommandOccupy(uint32_t devId, drvCommandOccupyInfo* info)
{
    if ((devId < 0) || (devId >= MAX_DEVICE_NUM))
        return DRV_ERROR_INVALID_VALUE;

    memset_s(&g_command[devId], sizeof(rtTaskReport_t), 0, sizeof(rtTaskReport_t));
    info->cmdPtr = (void *)&g_command[devId];
    return DRV_ERROR_NONE;
}

drvError_t halSqMsgSend(uint32_t devId, halSqMsgInfo *Sendinfo)
{
    if ((devId < 0) || (devId >= MAX_DEVICE_NUM))
        return DRV_ERROR_INVALID_VALUE;
    while (sendCount[devId] != recvCount[devId]);

    rtCommand_t *cmd = &g_command[devId];
    int32_t pingpong = sendCount[devId] % 2;
    rtTaskReport_t *report;
    uint64_t ts;

    switch (cmd->type)
    {
    case TS_TASK_TYPE_EVENT_RECORD:
        ts = g_timeStamp[devId]++;
        report = &g_report[devId][pingpong][0];
        report->streamID = cmd->streamID;
        report->taskID = cmd->taskID;
        report->payLoad = ts & 0xffffffffu;
        report->SOP = 1;
        report->MOP = 0;
        report->EOP = 0;
        report = &g_report[devId][pingpong][1];
        report->streamID = cmd->streamID;
        report->taskID = cmd->taskID;
        report->payLoad = ts >> 32;
        report->SOP = 0;
        report->MOP = 0;
        report->EOP = 1;
        break;
    default:
        report = &g_report[devId][pingpong][0];
        report->streamID = cmd->streamID;
        report->taskID = cmd->taskID;
        report->payLoad = 0;
        report->SOP = 1;
        report->MOP = 0;
        report->EOP = 1;
        //delete cmd;
        break;
    }
    g_reportCount[devId][pingpong] = Sendinfo->reportCount > 2? 2: Sendinfo->reportCount;
    sendCount[devId]++;
    return DRV_ERROR_NONE;
}

drvError_t drvReportGet(uint32_t devId, drvReportGetInfo* info)
{
    if ((devId < 0) || (devId >= MAX_DEVICE_NUM))
        return DRV_ERROR_INVALID_VALUE;
    while (sendCount[devId] == recvCount[devId]);
    int32_t pingpong = recvCount[devId] % 2;
    info->reportPtr = &g_report[devId][pingpong];
    info->count = g_reportCount[devId][pingpong];
    recvCount[devId]++;
    return DRV_ERROR_NONE;
}

drvError_t drvMemAlloc(void **dptr, uint64_t size, drvMemType_t type, int32_t nodeId)
{
    posix_memalign(dptr, 512, size);
    if (*dptr == NULL)
    {
        return DRV_ERROR_OUT_OF_MEMORY;
    }
    return DRV_ERROR_NONE;
}

drvError_t drvMemFree(void * dptr, int32_t deviceId)
{
    free(dptr);
    return DRV_ERROR_NONE;
}

drvError_t drvMemAllocHost(void** pp, size_t bytesize)
{
    *pp = malloc(bytesize);
    if (*pp == NULL)
    {
        return DRV_ERROR_OUT_OF_MEMORY;
    }
    return DRV_ERROR_NONE;
}

drvError_t drvMemFreeHost(void *p)
{
    free(p);
    return DRV_ERROR_NONE;
}

drvError_t drvModelMemcpy(void *dst, uint64_t destMax, const void *src, uint64_t size, drvMemcpyKind_t kind, int32_t deviceId)
{
    memcpy_s(dst, destMax, src, size);
    return DRV_ERROR_NONE;
}

drvError_t drvDriverStubInit(void)
{
    return DRV_ERROR_NONE;
}

extern "C" void StartTaskScheduler()
{
}
/***BEGIN  Tuscany V100R001C10 x00209337 MODIFY ESL200 Simulation 2017-11-13    **********/

drvError_t drvMemAllocManaged(DVdeviceptr * pp, size_t bytesize)
{
    posix_memalign((void **)pp, 512, bytesize);
    if (!(*pp)) {
        return DRV_ERROR_OUT_OF_MEMORY;
    }
    return DRV_ERROR_NONE;
}

drvError_t drvMemFreeManaged(DVdeviceptr  p)
{
    free((void *)p);
    return DRV_ERROR_NONE;
}

drvError_t drvMemAddressTranslate(DVdeviceptr vptr, UINT64 *pptr)
{
    return DRV_ERROR_NONE;
}

drvError_t drvMemcpy(DVdeviceptr dst, size_t destMax, DVdeviceptr src, size_t ByteCount)
{
    memcpy_s((void *)dst, destMax, (const void *)src, ByteCount);
    return DRV_ERROR_NONE;
}

drvError_t drvGetRserverdMem(void **dst)
{
    return DRV_ERROR_NONE;
}

drvError_t drvGetPlatformInfo(uint32_t *info)
{
    *info = 0;
}

drvError_t drvReportRelease(uint32_t devId,  drvReportReleaseInfo* info)
{
    return DRV_ERROR_NONE;
}

drvError_t drvReportPollWait(uint32_t devId, drvReportInfo* info)
{
    return DRV_ERROR_NONE;
}

drvError_t drvReportIrqWait(uint32_t devId, drvReportInfo* info)
{
    return DRV_ERROR_NONE;
}
void drvDfxShowReport(uint32_t devId)
{
    return;
}

drvError_t drvAllocOperatorMem(void **dst, int32_t size)
{
    return DRV_ERROR_NONE;
}
drvError_t drvFreeOperatorMem(void **dst, int32_t size)
{
    return DRV_ERROR_NONE;
}


DVresult  drvMemConvertAddr(DVdeviceptr pSrc, DVdeviceptr pDst, UINT32 len, struct DMA_ADDR *dmaAddr)
{
    return DRV_ERROR_NONE;

}

DVresult  drvMemDestroyAddr(struct DMA_ADDR *ptr)
{
    return DRV_ERROR_NONE;
}

DVresult drvMemAllocHugePageManaged(DVdeviceptr *pp, size_t bytesize)
{
    return DRV_ERROR_NONE;
}

DVresult drvMemFreeHugePageManaged(DVdeviceptr p)
{
    return DRV_ERROR_NONE;
}
drvError_t drvMemAdvise(DVdeviceptr devPtr, size_t count, DVmem_advise advise, DVdevice device)
{
    return DRV_ERROR_NONE;
}

DVresult drvMemLock (DVdeviceptr devPtr, unsigned int lockType, DVdevice device)
{
    return DRV_ERROR_NONE;
}
DVresult drvMemUnLock (DVdeviceptr devPtr)
{
    return DRV_ERROR_NONE;
}

void drvFlushCache(uint64_t base, uint32_t len)
{

}

DVresult drvMemPrefetchToDevice ( DVdeviceptr devPtr, size_t len, DVdevice device )
{
    return DRV_ERROR_NONE;
}

DVresult drvMemsetD8 ( DVdeviceptr dst, size_t destMax, UINT8 value, size_t N )
{
    return DRV_ERROR_NONE;
}

drvError_t drvModelGetMemInfo(uint32_t device, size_t *free, size_t *total)
{
    return DRV_ERROR_NONE;
}

DVresult drvMemGetAttribute(DVdeviceptr vptr, struct DVattribute* addtr)
{
    addtr->devId = 0;
    addtr->isDevMem = 0;
    return DRV_ERROR_NONE;
}

void* create_collect_client(const char* address, const char* engine_name)
{
    void * client_handle = NULL;
    return client_handle;
}

int collect_write(void* handle, const char* job_ctx, struct data_chunk* data)
{
    return 0;
}

void release_collect_client(void* handle)
{
    return;
}

static const char *logLevels[] =
{
    "ERR",
    "WARNING",
    "EVENT",
    "INFO",
    "DEBUG",
    "RESERVED",
};

int CheckLogLevel(int moduleId, int logLevel)
{
    return 0;
}

void DlogErrorInner(int module_id, const char *fmt, ...)
{
    char buf[MAX_LOG_BUF_SIZE] = {0};

    va_list arg;
    va_start (arg, fmt);
    vsnprintf(buf, MAX_LOG_BUF_SIZE, fmt, arg);
    va_end (arg);

    syslog(RT_LOG_ERROR, "%u %lu [%s] %s:%d %s: %s\n",
           getpid(),syscall(SYS_gettid),logLevels[RT_LOG_ERROR],__FILE__, __LINE__, __func__, buf);
    return;
}

void DlogWarnInner(int module_id, const char *fmt, ...)
{
    char buf[MAX_LOG_BUF_SIZE] = {0};

    va_list arg;
    va_start (arg, fmt);
    vsnprintf(buf, MAX_LOG_BUF_SIZE, fmt, arg);
    va_end (arg);

    syslog(RT_LOG_WARNING, "%u %lu [%s] %s:%d %s: %s\n",
           getpid(),syscall(SYS_gettid),logLevels[RT_LOG_WARNING],__FILE__, __LINE__, __func__, buf);
    return;
}
void DlogInfoInner(int module_id, const char *fmt, ...)
{
    char buf[MAX_LOG_BUF_SIZE] = {0};

    va_list arg;
    va_start (arg, fmt);
    vsnprintf(buf, MAX_LOG_BUF_SIZE, fmt, arg);
    va_end (arg);

    syslog(RT_LOG_INFO, "%u %lu [%s] %s:%d %s: %s\n",
           getpid(),syscall(SYS_gettid),logLevels[RT_LOG_INFO],__FILE__, __LINE__, __func__, buf);
    return;
}
void DlogDebugInner(int module_id, const char *fmt, ...)
{
    char buf[MAX_LOG_BUF_SIZE] = {0};

    va_list arg;
    va_start (arg, fmt);
    vsnprintf(buf, MAX_LOG_BUF_SIZE, fmt, arg);
    va_end (arg);

    syslog(RT_LOG_DEBUG, "%u %lu [%s] %s:%d %s: %s\n",
           getpid(),syscall(SYS_gettid),logLevels[RT_LOG_DEBUG],__FILE__, __LINE__, __func__, buf);
    return;
}

void DlogEventInner(int module_id, const char *fmt, ...)
{
    char buf[MAX_LOG_BUF_SIZE] = {0};

    va_list arg;
    va_start (arg, fmt);
    vsnprintf(buf, MAX_LOG_BUF_SIZE, fmt, arg);
    va_end (arg);

    syslog(RT_LOG_EVENT, "%u %lu [%s] %s:%d %s: %s\n",
           getpid(),syscall(SYS_gettid),logLevels[RT_LOG_EVENT],__FILE__, __LINE__, __func__, buf);
    return;
}

int dlog_getlevel(int module_id, int *enable_event)
{
    if (enable_event != nullptr) {
        *enable_event = true;
    }
    return 0;
}

/*offline need not to support this interface*/
drvError_t halShmemCreateHandle (DVdeviceptr vptr, uint64_t byteCountk, char * name, uint32_t len)
{
	return DRV_ERROR_NONE;
}

/*offline need not to support this interface*/
drvError_t halShmemDestroyHandle (const char * name)
{
	return DRV_ERROR_NONE;
}

/*offline need not to support this interface*/
drvError_t halShmemOpenHandle (const char * name, DVdeviceptr *vptr)
{
	return DRV_ERROR_NONE;
}

/*offline need not to support this interface*/
drvError_t halShmemCloseHandle (DVdeviceptr vptr)
{
	return DRV_ERROR_NONE;
}

drvError_t drvSetIpcNotifyPid(const char *name, pid_t pid[], int num)
{
    return DRV_ERROR_NONE;
}

drvError_t halShmemSetPidHandle(const char *name, pid_t pid[], int num)
{
    return DRV_ERROR_NONE;
}

int drvMemDeviceOpen(unsigned int devid, int devfd)
{
    return DRV_ERROR_NONE;
}

int drvMemDeviceClose(unsigned int devid)
{
    return DRV_ERROR_NONE;
}

drvError_t drvModelIdAlloc(int32_t device, drvModelIdInfo* info)
{
    info->modelId = 1;
    return DRV_ERROR_NONE;
}

drvError_t drvModelIdFree(int32_t device, drvModelIdInfo* info)
{
    return DRV_ERROR_NONE;
}

drvError_t drvNotifyIdAlloc(uint32_t device, drvNotifyInfo *info)
{
    if (!info)
        return DRV_ERROR_INVALID_VALUE;
    info->notifyId = 1;
    return DRV_ERROR_NONE;
}

drvError_t drvNotifyIdFree(uint32_t device, drvNotifyInfo *info)
{
    return DRV_ERROR_NONE;
}
drvError_t drvCreateIpcNotify(drvIpcNotifyInfo *info, char *name, uint32_t len)
{
    return DRV_ERROR_NONE;
}
drvError_t drvDestroyIpcNotify(const char *name, drvIpcNotifyInfo *info)
{
    return DRV_ERROR_NONE;
}
drvError_t drvOpenIpcNotify(const char *name, drvIpcNotifyInfo *info)
{
    return DRV_ERROR_NONE;
}
drvError_t drvCloseIpcNotify(const char *name, drvIpcNotifyInfo *info)
{
    return DRV_ERROR_NONE;
}

drvError_t drvNotifyIdAddrOffset(uint32_t deviceid_, drvNotifyInfo *info)
{
    return DRV_ERROR_NONE;
}

drvError_t drvDeviceGetTransWay(void *src, void* dst, uint8_t *trans_type)
{
    *trans_type = 0;
    return DRV_ERROR_NONE;
}


DVresult drvLoadProgram (DVdevice deviceId, void *program, unsigned int offset, size_t ByteCount, void **vPtr)
{
  return DRV_ERROR_NONE;
}


drvError_t drvCustomCall(uint32_t devid, uint32_t cmd, void *para)
{
    (void)devid;
    (void)cmd;
    (void)para;
    return DRV_ERROR_NONE;
}

drvError_t drvDeviceGetPhyIdByIndex(uint32_t devIndex, uint32_t *phyId)
{
    return DRV_ERROR_NONE;
}
drvError_t drvDeviceGetIndexByPhyId(uint32_t phyId, uint32_t *devIndex)
{
    return DRV_ERROR_NONE;
}

drvError_t halDeviceEnableP2P(uint32_t devIdDes, uint32_t phyIdSrc, uint32_t flag)
{
    return DRV_ERROR_NONE;
}

drvError_t halDeviceDisableP2P(uint32_t devIdDes, uint32_t phyIdSrc, uint32_t flag)
{
    return DRV_ERROR_NONE;
}
drvError_t halDeviceCanAccessPeer(int32_t *canAccessPeer, uint32_t device, uint32_t peerDevice)
{
    return DRV_ERROR_NONE;
}
drvError_t halQueueCreate(unsigned int devId, const QueueAttr *queAttr, unsigned int *qid)
{
    return DRV_ERROR_NONE;
}
drvError_t halQueueDestroy(unsigned int devId, unsigned int qid)
{
	return DRV_ERROR_NONE;
}
drvError_t halQueueInit(unsigned int devId)
{
    return DRV_ERROR_NONE;
}
drvError_t halQueueEnQueue(unsigned int devId, unsigned int qid, void *mbuf)
{
    return DRV_ERROR_NONE;
}
drvError_t halQueueDeQueue(unsigned int devId, unsigned int qid, void **mbuf)
{
    return DRV_ERROR_NONE;
}
drvError_t halQueuePeek(unsigned int devId, unsigned int qid, uint64_t *buf_len, int timeout)
{
    return DRV_ERROR_NONE;
}
drvError_t halQueueEnQueueBuff(unsigned int devId, unsigned int qid, struct buff_iovec *vector, int timeout)
{
    return DRV_ERROR_NONE;
}
drvError_t halQueueDeQueueBuff(unsigned int devId, unsigned int qid, struct buff_iovec *vector, int timeout)
{
    return DRV_ERROR_NONE;
}
drvError_t halQueueQueryInfo(unsigned int devId, unsigned int qid, QueueInfo *queInfo)
{
    return DRV_ERROR_NONE;
}
drvError_t halQueueQuery(unsigned int devId, QueueQueryCmdType cmd, QueueQueryInputPara *inPut, QueueQueryOutputPara *outPut)
{
    return DRV_ERROR_NONE;
}
drvError_t halQueueGrant(unsigned int devId, unsigned int qid, int pid, QueueShareAttr attr)
{
    return DRV_ERROR_NONE;
}
drvError_t halQueueAttach(unsigned int devId, unsigned int qid, int timeOut)
{
    return DRV_ERROR_NONE;
}
drvError_t halEschedSubmitEventSync(unsigned int devId, struct event_summary *event, int timeout, struct event_reply *ack)
{
    return DRV_ERROR_NONE;
}
drvError_t halQueryDevpid(struct halQueryDevpidInfo info, pid_t *dev_pid)
{
    return DRV_ERROR_NONE;
}
drvError_t drvQueryDevpid(struct drvBindHostpidInfo info, pid_t *dev_pid)
{
    return DRV_ERROR_NONE;
}
drvError_t halBuffGet(Mbuf *mbuf, void *buff, unsigned long size)
{
    return DRV_ERROR_NONE;
}
int halBuffInit(BuffCfg *cfg)
{
    return 0;
}
int halMbufAlloc(uint64_t size, Mbuf **mbuf)
{
    return 0;
}
int halMbufFree(Mbuf *mbuf)
{
    return 0;
}
int halMbufBuild(void *buff, uint64_t len, Mbuf **mbuf)
{
    return 0;
}
int halBuffAlloc(uint64_t size, void **buff)
{
    return 0;
}
int halBuffFree(void *buff)
{
    return 0;
}
void halBuffPut(Mbuf *mbuf, void *buff)
{
    (void)(mbuf);
    (void)(buff);
}
int halMbufUnBuild(Mbuf *mbuf, void **buff, uint64_t *len)
{
    return 0;
}
int halMbufGetBuffAddr(Mbuf *mbuf, void **buf)
{
    return 0;
}
int halMbufGetBuffSize(Mbuf *mbuf, uint64_t *totalSize)
{
    return 0;
}
int halMbufGetPrivInfo (Mbuf *mbuf,  void **priv, unsigned int *size)
{
    return 0;
}
int halGrpCreate(const char *name, GroupCfg *cfg)
{
    return 0;
}
int halGrpAddProc(const char *name, int pid, GroupShareAttr attr)
{
    return 0;
}
int halGrpAttach(const char *name, int timeout)
{
    return 0;
}
int halGrpQuery(GroupQueryCmdType cmd, void *inBuff, unsigned int inLen, void *outBuff, unsigned int *outLen)
{
    return 0;
}
