/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "log_config_api.h"
#include "log_common.h"
#include "ascend_hal.h"
#include "ascend_hal.h"
#include "log_session_manage.h"
#include "log_to_file.h"
#include "slogd_utest_stub.h"
#include "dlog_console.h"
#include "adx_service_config.h"

#define FD_STDOUT 100
#define HDC_RECV_MAX_LEN 524288 // 512KB buffer space

int ToolSetThreadName(const char *threadName)
{
    return 0;
}

LogRt InitWriteZip(const char* fileName, int* fd)
{
    return SUCCESS;
}

INT32 ToolGetErrorCode()
{
    return 0;
}

INT32 ToolOpen(const CHAR *pathName, INT32 flags)
{
    return 0;
}

INT32 ToolOpenWithMode(const CHAR *pathName, INT32 flags, toolMode mode)
{
    return 0;
}

INT32 ToolFsync(toolProcess fd)
{
    return 0;
}

INT32 ToolWrite(INT32 fd, const VOID *buf, UINT32 bufLen)
{
    if (buf == NULL) {
        return -2;
    }
    if (fd == FD_STDOUT) {
        printf("%s", buf);
    }
}

INT32 ToolClose(INT32 fd)
{
    return 0;
}

toolSockHandle ToolSocket(INT32 sockFamily, INT32 type, INT32 protocol)
{
    return 0;
}

INT32 ToolBind(toolSockHandle sockfd, const ToolSockAddr *addr, toolSocklen addrlen)
{
    return 0;
}

INT32 ToolMutexInit( ToolMutex *mutex )
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

INT32 ToolChmod(const CHAR *filename, INT32 mode)
{
    return 0;
}

INT32 ToolLocalTimeR(const time_t *timep, struct tm *result)
{
    return  0;
}

INT32 ToolGetTimeOfDay(ToolTimeval *tv, ToolTimezone *tz)
{
    return 0;
}

INT32 ToolGetPid()
{
    return 0;
}

INT32 ToolAccess(const CHAR *lpPathName)
{
    return 0;
}

INT32 ToolAccessWithMode(const CHAR *pathName, INT32 mode)
{
    return 0;
}

INT32 ToolScandir(const CHAR *path, ToolDirent ***entry_list, ToolFilter filterFunc, ToolSort sort)
{
    return 0;
}

void ToolScandirFree(ToolDirent **entry_list,INT32 count)
{

}

INT32 ToolUnlink(const CHAR *filename)
{

    return 0;
}

INT32 ToolRead (INT32 fd, VOID* mmBuf, UINT32 mmCount)
{
    return 0;
}

INT32 ToolConnect(toolSockHandle sockfd, const ToolSockAddr* addr, toolSocklen addrlen)
{
    return 0;
}

INT32 ToolMkdir(const CHAR* lpPathName, toolMode mode)
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

INT32 ToolCreateTaskWithDetach(ToolThread  *pstThreadHandle, const ToolUserBlock *pstFuncBlock)
{
    return 0;
}

INT32 ToolCreateTaskWithThreadAttr(ToolThread  *threadHandle, const ToolUserBlock *funcBlock,
    const ToolThreadAttr *threadAttr)
{
    return 0;
}

INT32 ToolStatGet(const CHAR *path,  ToolStat *buffer)
{
    return 0;
}

INT32 ToolRealPath(const CHAR *path,CHAR *realPath, INT32 realPathLen)
{
    memcpy(realPath, path, strlen(path));
    return 0;
}

INT32 ToolFileno(FILE *stream)
{
    return FD_STDOUT;
}

VOID ToolMemBarrier()
{
    return;
}

INT32 ToolSleep(UINT32 millseconds)
{
    return 0;
}

INT32 ToolCloseSocket(toolSockHandle sockFd)
{
    return 0;
}

INT32 ToolChown(const char *filename, uid_t owner, gid_t group)
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

int log_get_channel_type(int device_id, int *channel_type_set,
               int *channel_type_num, int set_size)
{
    return 0;
}

int log_set_level(int device_id, int channel_type,
                  unsigned int log_level)
{
    return 0;
}

int dsmi_get_user_config(int device_id, const char *config_name, unsigned int buf_size, unsigned char *buf)
{
    return 0;
}

int dsmi_set_user_config(int device_id, const char *config_name, unsigned int buf_size, unsigned char *buf)
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

int log_read_by_type(int device_id, char *buf, unsigned int *size, int timeout, enum log_channel_type channel_type)
{
    (void)device_id;
    (void)buf;
    (void)size;
    (void)channel_type;
    usleep(timeout);
    return LOG_NOT_READY;
}

DLLEXPORT drvError_t drvDeviceStatus(uint32_t devId, drvStatus_t *status)
{
    return DRV_ERROR_NONE;
}

int JustStartAProcess(const char *file)
{
    return 0;
}

void SingleResourceCleanup(const char *file)
{

}

int log_write_slog(int device_id, const char *in_buf, unsigned int buf_size, int *write_size, unsigned int timeout)
{
    return 0;
}

int appmon_client_init(client_info_t *clnt, const char *server_addr)
{
    return 0;
}

int appmon_client_register(client_info_t *clnt, unsigned long timeout, const char *timeout_action)
{
    return 0;
}

drvError_t drvGetDevIDByLocalDevID(uint32_t localDevId, uint32_t *devId)
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

hdcError_t drvHdcSendFile(int peer_node, int peer_devid, const char *file, const char *dst_path, void(*progress_notifier)(struct drvHdcProgInfo *))
{
    return 0;
}

int AdxHdcSendFile(const char * srcFile, const char * desFile)
{
    return 0;
}

void AdxDestroyCommHandle(CommHandle *handle)
{
    (void)handle;
}

hdcError_t drvHdcGetTrustedBasePath(int peer_node, int peer_devid, char *base_path, unsigned int path_len)
{
    return 0;
}

INT32 ToolMutexDestroy(ToolMutex *mutex)
{
    return 0;
}

ssize_t read(int fd, void *buf, size_t nbytes)
{
    struct inotify_event event1;
    event1.mask = IN_DELETE_SELF;
    memcpy(buf, &event1, sizeof(event1));
    return sizeof(event1);
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

INT32 ToolJoinTask(const ToolThread  *tid)
{
    return 0;
}

int32_t IamRegisterSystemService(void (*resMgrSysStateHandle)(int32_t))
{
	return 0;
}

int AdxComponentServerStartup(ServerInitInfo info)
{
    return 0;
}

int AdxRegisterComponentFunc(int serverType, void **adxComponent)
{
    return 0;
}

int32_t AdxSendMsg(const CommHandle *handle, const char *data, uint32_t len)
{
    return 0;
}

int32_t AdxRecvMsg(AdxCommHandle handle, char **data, uint32_t *len, uint32_t timeout)
{
    return 0;
}

int32_t AdxRegisterService(int32_t serverType, ComponentType componentType, AdxComponentInit init,
    AdxComponentProcess process, AdxComponentUnInit uninit)
{
    return 0;
}

int32_t AdxGetAttrByCommHandle(AdxCommConHandle handle, int32_t attr, int32_t *value)
{
    *value = 0;
    return 0;
}

drvError_t halHdcGetSessionAttr(HDC_SESSION session, int attr, int *value)
{
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

drvError_t drvHdcGetCapacity(struct drvHdcCapacity *capacity)
{
    capacity->chanType = HDC_CHAN_TYPE_PCIE;
    capacity->maxSegment = HDC_RECV_MAX_LEN;
    return DRV_ERROR_NONE;
}

hdcError_t halHdcSend(HDC_SESSION session, struct drvHdcMsg *pMsg, UINT64 flag, UINT32 timeout)
{
    return DRV_ERROR_NONE;
}
