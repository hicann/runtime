/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "log_daemon_ut_stub.h"
#include "ascend_hal.h"
#include "log_recv.h"
#include "appmon_lib.h"

int StackMonitor(void)
{
    return 0;
}

void StackRegisterPrint(void (*printFunc)(const char *format, ...))
{
    return;
}

hdcError_t drvHdcSessionClose(HDC_SESSION session)
{
    return DRV_ERROR_NONE;
}

DLLEXPORT hdcError_t drvHdcClientCreate(HDC_CLIENT *client, int maxSessionNum, int serviceType, int flag)
{
    return 0;
}
LogRt RunSockSendFile(void)
{
    return SUCCESS;
}

DLLEXPORT hdcError_t drvHdcAllocMsg(HDC_SESSION session, struct drvHdcMsg **ppMsg, int count)
{
    return 0;
}

DLLEXPORT hdcError_t halHdcRecv(HDC_SESSION session, struct drvHdcMsg *pMsg, int bufLen,
                                UINT64 flag, int *recvBufCount, UINT32 timeout)
{
    return 0;
}

DLLEXPORT hdcError_t drvHdcSessionConnect(int peer_node, int peer_devid,
                                HDC_CLIENT client, HDC_SESSION *session)
{
    return 0;
}

DLLEXPORT hdcError_t drvHdcClientDestroy(HDC_CLIENT client)
{
    return 0;
}

DLLEXPORT hdcError_t drvHdcSetSessionReference (HDC_SESSION session)
{
    return 0;
}

DLLEXPORT drvError_t drvGetDevNum(uint32_t *num_dev)
{
    return 0;
}

DLLEXPORT drvError_t drvGetDevIDs(uint32_t *devices, uint32_t len)
{
    return 0;
}

DLLEXPORT hdcError_t drvHdcGetMsgBuffer(struct drvHdcMsg *msg, int index,
                              char **pBuf, int *pLen)
{
    return 0;
}

DLLEXPORT drvError_t drvDeviceGetPhyIdByIndex(uint32_t devIndex, uint32_t *phyId)
{
    *phyId = devIndex;
    return 0;
}

DLLEXPORT drvError_t drvDeviceStatus(uint32_t devId, drvStatus_t *status)
{
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

drvError_t drvGetPlatformInfo(uint32_t *info)
{
    return DRV_ERROR_NONE;
}

drvError_t drvHdcGetCapacity(struct drvHdcCapacity *capacity)
{
    return DRV_ERROR_NONE;
}

hdcError_t halHdcSend(HDC_SESSION session, struct drvHdcMsg *pMsg, UINT64 flag, UINT32 timeout)
{
    return DRV_ERROR_NONE;
}

hdcError_t halGetDeviceInfoByBuff(uint32_t devId, int32_t moduleType, int32_t infoType, void *buf, int32_t *size)
{
    return DRV_ERROR_NONE;
}

int ToolCreateTaskWithDetach(ToolThread  *pstThreadHandle, const ToolUserBlock *pstFuncBlock)
{
    return 0;
}

INT32 ToolSleep(UINT32 millseconds)
{
    return 0;
}

INT32 ToolCondTimedWait(ToolCond *cond, ToolMutex *mutex, UINT32 milliSecond)
{
    return 0;
}

INT32 ToolCondInit(ToolCond *cond)
{
    return 0;
}

INT32 ToolCondNotify(ToolCond *cond)
{
    return 0;
}

static int32_t g_mutexCount = 0;

int32_t CheckMutex(void)
{
    return g_mutexCount;
}

int32_t pthread_mutex_lock(ToolMutex *mutex)
{
    g_mutexCount++;
    return 0;
}

int32_t pthread_mutex_unlock(ToolMutex *mutex)
{
    g_mutexCount--;
    return 0;
}

INT32 ToolMutexLock(ToolMutex *mutex)
{
    g_mutexCount++;
    return 0;
}

INT32 ToolMutexUnLock(ToolMutex *mutex)
{
    g_mutexCount--;
    return 0;
}

DLLEXPORT hdcError_t drvHdcFreeMsg(struct drvHdcMsg *msg)
{
    return 0;
}

unsigned long ERR_get_error(void)
{
    return 0;
}

char *ERR_error_string(unsigned long e, char *buf)
{
    return NULL;
}

INT32 ToolUnlink(const CHAR *filename)
{
    return 0;
}

INT32 ToolStatGet(const CHAR *path, ToolStat *buffer)
{
    return 0;
}

INT32 ToolChmod(const CHAR *filename, INT32 mode)
{
    return 0;
}

INT32 ToolClose(INT32 fd)
{
    return 0;
}

INT32 ToolGetPid()
{
    return 0;
}

INT32 ToolWrite(INT32 fd, const VOID *buf, UINT32 bufLen)
{
    return 0;
}

INT32 ToolMutexInit(ToolMutex *mutex)
{
    return 0;
}

INT32 ToolMutexDestroy(ToolMutex *mutex)
{
    return 0;
}

INT32 ToolScandir(const CHAR *path, ToolDirent ***entryList, ToolFilter filterFunc, ToolSort sort)
{
    return 0;
}

void ToolScandirFree(ToolDirent **entryList, INT32 count)
{
    return;
}

INT32 ToolRealPath(const CHAR *path, CHAR *realPath, INT32 realPathLen)
{
    INT32 ret = SYS_OK;
    if (realPath == NULL || path == NULL || realPathLen < TOOL_MAX_PATH) {
        return SYS_INVALID_PARAM;
    }
    CHAR *ptr = realpath(path, realPath);
    if (ptr == NULL) {
        ret = SYS_ERROR;
    }
    return ret;
}

INT32 ToolLocalTimeR(const time_t *timep, struct tm *result)
{
    return 0;
}

INT32 ToolGetErrorCode()
{
    return 0;
}

INT32 ToolMkdir(const CHAR *pathName, toolMode mode)
{
    return 0;
}

INT32 ToolRmdir(const CHAR *pathName)
{
    return 0;
}

INT32 ToolRename(const CHAR *oldName, const CHAR *newName)
{
    return 0;
}

INT32 ToolAccess(const CHAR* lpPathName)
{
    return 0;
}

INT32 ToolOpenWithMode(const CHAR *pathName, INT32 flags, toolMode mode)
{
    return 0;
}

INT32 ToolOpen(const CHAR *pathName, INT32 flags)
{
    return 0;
}

INT32 ToolGetTimeOfDay(ToolTimeval *tv, ToolTimezone *tz)
{
    return 0;
}

INT32 ToolFsync(toolProcess fd)
{
    return 0;
}

INT32 ToolChown(const char *filename, uid_t owner, gid_t group)
{
    return 0;
}

INT32 ToolAccessWithMode(const CHAR *pathName, INT32 mode)
{
    return 0;
}

INT32 ToolFileno(FILE *stream)
{
    return 0;
}

INT32 ToolCloseSocket(toolSockHandle sockFd)
{
    return 0;
}

INT32 ToolRead(INT32 fd, VOID *buf, UINT32 bufLen)
{
    return 0;
}

INT32 ToolBind(toolSockHandle sockFd, const ToolSockAddr *addr, toolSocklen addrLen)
{
    return 0;
}

toolSockHandle ToolSocket(INT32 sockFamily, INT32 type, INT32 protocol)
{
    return 0;
}

INT32 ToolGetUserGroupId(UINT32 *uid, UINT32 *gid)
{
    return SYS_OK;
}

INT32 ToolChownPath(const CHAR *path)
{
    return SYS_OK;
}

INT32 ToolLChownPath(const CHAR *path)
{
    return SYS_OK;
}

INT32 ToolFChownPath(INT32 fd)
{
    return SYS_OK;
}

/* for gzip stream deflate init interface */
int hw_deflateInit2_(struct zip_stream *zstrm, int level, int method,
    int windowBits, int memLevel, int strategy,
    const char *version, int stream_size)
{
    return 0;
}

/* deflate stream interface */
int hw_deflate(struct zip_stream *zstrm, int flush)
{
    return 0;
}

/* end of deflate stream interface */
int hw_deflateEnd(struct zip_stream *zstrm)
{
    return 0;
}

void BboxStartMainThread(void){}
void BboxStopMainThread(void){}
int AdxCoreDumpServerInit() {}
void BboxDevStartupRegister(int (*devStartupNotifier)(unsigned int num, unsigned int *devId)){}
void BboxDevStateNotifierRegister(int (*devStateNotifier)(DrvDevStatT *stat)){}

int IAMResMgrReady(void)
{
    return 0;
}

int IAMRegisterService(const struct IAMFileConfig *config)
{
    return 0;
}

int32_t IAMUnregisterService(void)
{
    return 0;
}

int ToolSetThreadName(const char *threadName)
{
    return 0;
}

INT32 ToolCreateTaskWithThreadAttr(ToolThread  *threadHandle, const ToolUserBlock *funcBlock,
                                   const ToolThreadAttr *threadAttr)
{
    return 0;

}
INT32 ToolJoinTask(const ToolThread  *tid)
{
    return 0;
}

VOID ToolMemBarrier()
{
}

int EzcomSendResponse(int fd, const struct EzcomResponse *resp)
{
    return 0;
}

int EzcomOpenPipe(const char *targetProcName, int procNameLen)
{
    return 1;
}

int EzcomRegisterServiceHandler(int fd, void (*handler)(int, struct EzcomRequest *))
{
    handler(0, NULL);
    return 0;
}

int32_t IAMRegAllSystemStateChange(void)
{
    return 0;
}
int32_t IamRegisterSystemService(void (*resMgrSysStateHandle)(int32_t))
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

int appmon_client_init(client_info_t *clnt, const char *server_addr)
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

int appmon_client_deregister(client_info_t *clnt, const char *reason)
{
    return 0;
}

void appmon_client_exit(client_info_t *clnt)
{
    return;
}

drvError_t drvGetDevIDByLocalDevID(uint32_t localDevId, uint32_t *devId)
{
    return 0;
}