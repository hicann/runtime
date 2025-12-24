/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "log_recv.h"
#include <sys/time.h>
#include <unistd.h>
#include <threads.h>
#include "log_config_api.h"
#include "slogd_config_mgr.h"
#include "log_common.h"
#include "log_path_mgr.h"
#include "log_file_util.h"
#include "ascend_hal.h"
#include "log_pm_sig.h"
#include "log_pm.h"
#include "slogd_flush.h"
#include "log_communication.h"
#include "slogd_dev_mgr.h"

typedef struct {
    short moduleId;
    uint32_t devId;
} LogBuff;

typedef struct {
    ToolMutex lock;
    LogQueue *devLogQueue;
    LogBuff *logBuff;
    uint32_t nodeCnt;
} DeviceRes;

#define MAX_READY_RETRY_TIMES       10
STATIC DeviceRes g_deviceResource[MAX_DEV_NUM];
STATIC unsigned int g_writeDPrintNum = 0;

#ifdef STATIC_BUFFER
#include "log_session_manage.h"
static void SlogdFirmwareLogWrite(void *handle, uint32_t devId)
{
    SessionItem item = { NULL, SESSION_CONTINUES_EXPORT };
    if (SessionMgrGetSession(&item) != LOG_SUCCESS) {
        return;
    }
    uint32_t bufSize = SlogdBufferGetBufSize(FIRM_LOG_TYPE);
    char *buffer = (char *)LogMalloc(bufSize);
    if (buffer == NULL) {
        SELF_LOG_ERROR("malloc buffer for firmware log failed, strerr = %s.", strerror(ToolGetErrorCode()));
        return;
    }
    LogReportMsg *msg = (LogReportMsg *)buffer;
    msg->magic = LOG_REPORT_MAGIC;
    msg->logType = FIRM_LOG_TYPE;
    int32_t retry = 0;
    int32_t dataLen = 0;
    while (retry < MAX_WRITE_WAIT_TIME) {
        dataLen = SlogdBufferRead(handle, buffer + sizeof(LogReportMsg), bufSize - LOG_SIZEOF(LogReportMsg));
        if (dataLen == 0) {
            break;
        }
        if ((dataLen < 0) || ((uint32_t)dataLen > bufSize - LOG_SIZEOF(LogReportMsg))) {
            SELF_LOG_ERROR("read log from ring buffer failed, write buffer log failed, ret = %d.", dataLen);
            break;
        }
        msg->bufLen = (uint32_t)dataLen;
        msg->devId = (uint8_t)GetHostDeviceID(devId);
        int32_t ret = SessionMgrSendMsg(&item, buffer, dataLen + LOG_SIZEOF(LogReportMsg));
        if (ret != LOG_SUCCESS) {
            SELF_LOG_ERROR_N(&g_writeDPrintNum, GENERAL_PRINT_NUM,
                             "send firmware log to host failed, result=%d, strerr=%s, print once every %u times.",
                             ret, strerror(ToolGetErrorCode()), GENERAL_PRINT_NUM);
        }
        retry++;
    }
    XFREE(buffer);
}

void SlogdFirmwareLogReceive(void *args)
{
    ONE_ACT_ERR_LOG(args == NULL, return, "firmware log receive args is NULL.");
    int32_t deviceId = *(int32_t *)args;
    ONE_ACT_ERR_LOG(deviceId < 0, return, "firmware log receive device id[%d] is invalid.", deviceId);
    LogMsgHead *recvBuf = NULL;
    // read by hdc, drv or other
    LogRt ret = LogRecvSafeRead(deviceId, &recvBuf, SlogdBufferGetBufSize(FIRM_LOG_TYPE));
    // for device state change, eg: low power state
    ONE_ACT_NO_LOG(ret == LOG_RECV_NULL, return);
    // happens if deviceInfo equal NULL or parse recvmsg failed
    ONE_ACT_ERR_LOG(ret != SUCCESS, return, "get log or parse recvmsg failed, result=%d, strerr=%s.",
                    (int32_t)ret, strerror(ToolGetErrorCode()));
    void *handle = SlogdBufferHandleOpen(FIRM_LOG_TYPE, NULL, LOG_BUFFER_WRITE_MODE, (uint32_t)deviceId);
    if (SlogdBufferCheckFull(handle, recvBuf->dataLen)) {
        // flush
        SlogdFirmwareLogWrite(handle, (uint32_t)deviceId);
    }
    LogStatus retValue = SlogdBufferWrite(handle, (const char*)recvBuf->data, recvBuf->dataLen);
    SlogdBufferHandleClose(&handle);
    LogFree(recvBuf);
    ONE_ACT_ERR_LOG(retValue != LOG_SUCCESS, return, "write to buffer failed, result=%d", retValue);
}

int32_t SlogdFirmwareLogFlush(void *args, uint32_t len, bool flushFlag)
{
    (void)len;
    (void)flushFlag;
    ONE_ACT_ERR_LOG(args == NULL, return LOG_FAILURE, "firmware log flush args is NULL.");
    int32_t deviceId = *(int32_t *)args;
    ONE_ACT_ERR_LOG(deviceId < 0, return LOG_FAILURE, "firmware log flush device id[%d] is invalid.", deviceId);
    void *handle = SlogdBufferHandleOpen(FIRM_LOG_TYPE, NULL, LOG_BUFFER_WRITE_MODE, deviceId);
    if (!SlogdBufferCheckEmpty(handle)) {
        SlogdFirmwareLogWrite(handle, (uint32_t)deviceId);
    }
    SlogdBufferHandleClose(&handle);
    ToolSleep(TWO_HUNDRED_MILLISECOND);
    return LOG_SUCCESS;
}

void SlogdFirmwareLogGet(SessionItem *handle, void *buffer, uint32_t bufferLen, int32_t devId)
{
    ONE_ACT_ERR_LOG(buffer == NULL, return, "buffer is NULL");
    ONE_ACT_ERR_LOG(devId < 0, return, "get firmware log device id[%d] is invalid.", devId);
    int32_t readLen = 0;
    int32_t ret = 0;
    char fileName[MAX_FILENAME_LEN] = {0};

    void *bufHandle = SlogdBufferHandleOpen(FIRM_LOG_TYPE, NULL, LOG_BUFFER_READ_MODE, (uint32_t)devId);
    while (true) {
        readLen = SlogdBufferRead(bufHandle, (char *)buffer, (uint32_t)bufferLen);
        if (readLen == 0) {
            break;
        }
        SlogdMsgData *msgData = (SlogdMsgData *)buffer;
        ret = snprintf_s(fileName, MAX_FILENAME_LEN, MAX_FILENAME_LEN - 1, "debug/device-%u/device-%u_%s.log",
            GetHostDeviceID((uint32_t)devId), GetHostDeviceID((uint32_t)devId), msgData->timeStr);
        ONE_ACT_ERR_LOG(ret == -1, continue, "snprintf_s for event log, timestamp:%s", msgData->timeStr);

        SELF_LOG_INFO("send file:%s, readLen:%d", fileName, readLen);
        ret = SessionMgrSendMsg(handle, fileName, (uint32_t)strlen(fileName));
        ONE_ACT_ERR_LOG(ret != LOG_SUCCESS, continue, "send file name failed, fileName:%s.", fileName);
        ret = SessionMgrSendMsg(handle, msgData->data, readLen);

        ONE_ACT_ERR_LOG(ret != LOG_SUCCESS, continue, "send file content failed, fileName:%s.", fileName);
        (void)memset_s(fileName, MAX_FILENAME_LEN, 0, MAX_FILENAME_LEN);
    }
    SlogdBufferHandleClose(&bufHandle);
}

#else

/**
 * @brief EnQueSavedBuff: push buffer to queue
 * @param [in]queue: log queue instance
 * @param [in]savedBuff: log data which need to be enqueued. will be free in SetupDeviceWriteThread
 * @param [in]handle: savedBuff buffer handle
 * @param [in]nodeCnt: log data node count
 * @return: LogRt, SUCCESS/ARGV_NULL/MALLOC_FAILED/others
 */
STATIC LogRt EnQueSavedBuff(LogQueue *queue, LogBuff *savedBuff, void *handle, uint32_t *nodeCnt)
{
    ONE_ACT_WARN_LOG(queue == NULL, return ARGV_NULL, "[input] queue is null.");
    ONE_ACT_WARN_LOG(savedBuff == NULL, return ARGV_NULL, "[input] saved buffer is null.");
    ONE_ACT_WARN_LOG(handle == NULL, return ARGV_NULL, "[input] buffer handle is null.");
    ONE_ACT_WARN_LOG(nodeCnt == NULL, return ARGV_NULL, "[input] node number is null.");

    LogNode *logNode = (LogNode *)LogMalloc(sizeof(LogNode));
    if (logNode == NULL) {
        SELF_LOG_ERROR("malloc failed, strerr=%s.", strerror(ToolGetErrorCode()));
        return MALLOC_FAILED;
    }
    uint32_t bufSize = SlogdBufferGetBufSize(FIRM_LOG_TYPE);
    logNode->stNodeData = (char *)LogMalloc((size_t)bufSize);
    if (logNode->stNodeData == NULL) {
        SELF_LOG_ERROR("malloc failed, strerr=%s.", strerror(ToolGetErrorCode()));
        XFREE(logNode);
        return MALLOC_FAILED;
    }
    int32_t res = SlogdBufferRead(handle, logNode->stNodeData, bufSize);
    if (res == 0) {
        XFREE(logNode->stNodeData);
        XFREE(logNode);
        return SUCCESS;
    }
    if ((res < 0) || ((uint32_t)res > bufSize)) {
        XFREE(logNode->stNodeData);
        XFREE(logNode);
        SELF_LOG_ERROR("read buffer failed, result=%d.", res);
        return FAILED;
    }
    logNode->uiNodeDataLen = (uint32_t)res;
    logNode->uiNodeNum = *nodeCnt;
    logNode->next = NULL;
    logNode->moduleId = savedBuff->moduleId;

    LogRt ret = LogQueueEnqueue(queue, logNode);
    if (ret != SUCCESS) {
        XFREE(logNode->stNodeData);
        XFREE(logNode);
        SELF_LOG_ERROR("enqueue failed, result=%d.", (int32_t)ret);
        return ret;
    }

    savedBuff->moduleId = 0;
    *nodeCnt = 0;
    SlogdBufferReset(handle);
    return SUCCESS;
}

/**
* @brief BuffEnqueueAndAllocNew: push buffer to queue and malloc new buffer
* @param [in]queue: log queue instance
* @param [in]savedBuff: buffer will be enqueued and re-malloced
* @param [in]handle: savedBuff buffer handle
* @param [in]nodeCnt: log data node count
* @return: LogRt, SUCCESS/ARGV_NULL/MALLOC_FAILED/others
*/
STATIC LogRt BuffEnqueueAndAllocNew(LogQueue *queue, LogBuff *savedBuff, void *handle, unsigned int *nodeCnt)
{
    ONE_ACT_WARN_LOG(queue == NULL, return ARGV_NULL, "[input] queue is null.");
    ONE_ACT_WARN_LOG(savedBuff == NULL, return ARGV_NULL, "[input] saved buffer is null.");
    ONE_ACT_WARN_LOG(handle == NULL, return ARGV_NULL, "[input] buffer handle is null.");
    ONE_ACT_WARN_LOG(nodeCnt == NULL, return ARGV_NULL, "[input] node number is null.");

    return EnQueSavedBuff(queue, savedBuff, handle, nodeCnt);
}

/**
* @brief FullAddBuffQueue: push buffer to queue if buffer is full. if not full copy new data to savedBuff
* @param [in]queue: log queue instance
* @param [in]recvMsg: buffer for log data. this will be cleaned up after enqueued
* @param [in]nodeCnt: log data node count
* @param [in]savedBuff: buffer to store log data which will be enqueued
* @return: LogRt, SUCCESS/ARGV_NULL/STR_COPY_FAILED/others
*/
STATIC LogRt FullAddBuffQueue(LogQueue *queue, LogMsgHead *recvMsg, unsigned int *nodeCnt, LogBuff *savedBuff)
{
    LogRt ret;

    ONE_ACT_WARN_LOG(queue == NULL, return ARGV_NULL, "[input] queue is null.");
    ONE_ACT_WARN_LOG(recvMsg == NULL, return ARGV_NULL, "[input] received message is null.");
    ONE_ACT_WARN_LOG(savedBuff == NULL, return ARGV_NULL, "[input] saved buffer is null.");
    ONE_ACT_WARN_LOG(nodeCnt == NULL, return ARGV_NULL, "[input] node number is null.");

    // if total length exceed limit or current log type not equal to stored log type, enqueue stored log
    void *handle = SlogdBufferHandleOpen(FIRM_LOG_TYPE, NULL, LOG_BUFFER_WRITE_MODE, savedBuff->devId);
    if (handle == NULL) {
        SELF_LOG_ERROR("get firmware log[device id = %u] buffer handle failed.", savedBuff->devId);
        return FAILED;
    }
    if (SlogdBufferCheckFull(handle, recvMsg->dataLen)) {
        ret = BuffEnqueueAndAllocNew(queue, savedBuff, handle, nodeCnt);
        TWO_ACT_ERR_LOG(ret != SUCCESS, SlogdBufferHandleClose(&handle), return ret,
            "enqueue and allocate new buffer failed, result=%d.", (int32_t)ret);
    }

    LogStatus retValue = SlogdBufferWrite(handle, (const char*)recvMsg->data, recvMsg->dataLen);
    SlogdBufferHandleClose(&handle);
    ONE_ACT_ERR_LOG(retValue != LOG_SUCCESS, return STR_COPY_FAILED,
                    "write to buffer failed, result=%d, strerr=%s.", retValue, strerror(ToolGetErrorCode()));

    savedBuff->moduleId = recvMsg->moduleId;
    *nodeCnt = (*nodeCnt) + 1U;
    recvMsg->dataLen = 0;
    return SUCCESS;
}

STATIC LogRt FullAddBuffQueueS(LogQueue *queue, LogMsgHead *recvMsg,
                               unsigned int *nodeCnt, LogBuff *buff, ToolMutex *threadLock)
{
    LogRt ret = SUCCESS;
    do {
        // save buffer to queue when buffer is full safely
        LOCK_WARN_LOG(threadLock);
        ret = FullAddBuffQueue(queue, recvMsg, nodeCnt, buff);
        if (ret == QUEUE_IS_FULL) {
            UNLOCK_WARN_LOG(threadLock);
            SELF_LOG_INFO("queue is full while enqueue.");
            (void)ToolSleep(ONE_HUNDRED_MILLISECOND);
        }
    } while (ret == QUEUE_IS_FULL);

    UNLOCK_WARN_LOG(threadLock);
    return ret;
}

/**
 * @brief AddBuffQueue: save log msg <buffTmp> to buffer <buffAllData>
 *                      if buffer <buffAllData> is full, save it to queue <queue>
 *                      or if log msg <buffTmp> is end, save buffer <buffAllData> to queue <queue> too
 * @param [in]queue: log queue instance
 * @param [in]recvBuf: buffer read by hdc, drv or other, contains log state
 * @param [in]deviceInfo: struct that contains device resources
 * @return: LogRt, SUCCESS/ARGV_NULL/STR_COPY_FAILED/others
 */
STATIC LogRt AddBuffQueue(LogQueue *queue, LogMsgHead *recvBuf, DeviceRes *deviceInfo)
{
    LogRt ret;
    ONE_ACT_WARN_LOG(queue == NULL, return ARGV_NULL, "[input] queue is null.");
    ONE_ACT_WARN_LOG(recvBuf == NULL, return ARGV_NULL, "[input] received buffer is null.");
    ONE_ACT_WARN_LOG(deviceInfo == NULL, return ARGV_NULL, "[input] device info is null.");

    ret = FullAddBuffQueueS(queue, recvBuf, &(deviceInfo->nodeCnt), deviceInfo->logBuff, &deviceInfo->lock);
    ONE_ACT_ERR_LOG(ret != SUCCESS, return ret, "enqueue failed, result=%d.", (int32_t)ret);

    return SUCCESS;
}

/**
* @brief: check whether specified time interval was passed by
* @param [in/out]lastTv: previous time value
* @return: pointer to result. 1 for time enough, 0 for not
*/
STATIC bool TimerEnough(struct timespec *lastTv)
{
    ONE_ACT_NO_LOG(lastTv == NULL, return false);

    struct timespec realTv = {0, 0};
    NO_ACT_WARN_LOG(LogGetMonotonicTime(&realTv) != LOG_SUCCESS,
        "get time failed, strerr=%s.", strerror(ToolGetErrorCode()));

    bool flag = ((realTv.tv_sec - lastTv->tv_sec) >= WRITE_INTERVAL) ? true : false;

    lastTv->tv_sec = realTv.tv_sec;
    return flag;
}

static LogStatus SlogdBuffEnqueue(DeviceRes *deviceInfo)
{
    void *handle = SlogdBufferHandleOpen(FIRM_LOG_TYPE, NULL, LOG_BUFFER_WRITE_MODE,
        deviceInfo->logBuff->devId);
    if (SlogdBufferCheckEmpty(handle)) {
        SlogdBufferHandleClose(&handle);
        return LOG_SUCCESS;
    }
    LogRt ret = BuffEnqueueAndAllocNew(deviceInfo->devLogQueue, deviceInfo->logBuff, handle, &(deviceInfo->nodeCnt));
    SlogdBufferHandleClose(&handle);
    if ((ret != SUCCESS) && (ret != QUEUE_IS_FULL)) {
        SELF_LOG_ERROR("queue is not full, but buffer enqueue failed, result=%d.", (int32_t)ret);
        return LOG_FAILURE;
    }
    return LOG_SUCCESS;
}

/**
 * @brief           : write log to file from log queue
 * @param [in]      : deviceInfo    pointer to DeviceRes
 * @param [in]      : flushFlag     whether to forcibly flush
 * @return          : == LOG_SUCCESS success; others failure
 */
STATIC int32_t SlogdWriteDeviceLog(DeviceRes *deviceInfo, bool flushFlag)
{
    uint32_t deviceId = deviceInfo->devLogQueue->deviceId;
    // Note: lock should be here, can not be putted in func BuffEnqueueAndAllocNew
    LOCK_WARN_LOG(&deviceInfo->lock);
    static thread_local struct timespec lastTv = {0, 0};
    bool writeFlag = TimerEnough(&lastTv);
    // enqueue because of time interval reached or process is to exit
    if (writeFlag || flushFlag) {
        if (SlogdBuffEnqueue(deviceInfo) != LOG_SUCCESS) {
            UNLOCK_WARN_LOG(&deviceInfo->lock);
            return LOG_FAILURE;
        }
    }
    LogNode *logNode = NULL;
    // get data pointer and release lock
    LogRt ret = LogQueueDequeue(deviceInfo->devLogQueue, &logNode);
    UNLOCK_WARN_LOG(&deviceInfo->lock);
    // queue is null and is not to forcibly flush, sleep and return
    if (ret == QUEUE_IS_NULL) {
        if (!flushFlag) {
            (void)ToolSleep(TWO_HUNDRED_MILLISECOND);
        }
        return LOG_SUCCESS;
    }
    ONE_ACT_ERR_LOG(ret != SUCCESS, return LOG_FAILURE, "log queue dequeue failed, result=%d.", (int32_t)ret);

    DeviceWriteLogInfo deviceWriteLogInfo;
    deviceWriteLogInfo.deviceId = deviceId;
    deviceWriteLogInfo.logType = DEBUG_LOG;
    deviceWriteLogInfo.moduleId = logNode->moduleId;
    deviceWriteLogInfo.len = logNode->uiNodeDataLen;

    uint32_t res = LogAgentWriteDeviceLog(GetGlobalLogFileList(), (char*)logNode->stNodeData, &deviceWriteLogInfo);
    XFreeLogNode(&logNode);
    if (res != OK) {
        SELF_LOG_ERROR_N(&g_writeDPrintNum, GENERAL_PRINT_NUM, "write device log to file failed, device_id=%u,"
                         "result=%u, print once every %u times.", deviceId, res, GENERAL_PRINT_NUM);
    }
    return LOG_SUCCESS;
}

void SlogdFirmwareLogReceive(void *args)
{
    ONE_ACT_ERR_LOG(args == NULL, return, "firmware log receive args is NULL.");
    int32_t deviceId = *(int32_t *)args;
    DeviceRes *deviceInfo = &g_deviceResource[deviceId];
    LogMsgHead *recvBuf = NULL;
    // read by hdc, drv or other
    LogRt ret = LogRecvSafeRead(deviceId, &recvBuf, SlogdBufferGetBufSize(FIRM_LOG_TYPE));
    // for device state change, eg: low power state
    ONE_ACT_NO_LOG(ret == LOG_RECV_NULL, return);
    // happens if deviceInfo equal NULL or parse recvmsg failed
    ONE_ACT_ERR_LOG(ret != SUCCESS, return, "get log or parse recvmsg failed, result=%d, strerr=%s.",
                    (int32_t)ret, strerror(ToolGetErrorCode()));
    ret = AddBuffQueue(deviceInfo->devLogQueue, recvBuf, deviceInfo);
    NO_ACT_ERR_LOG(ret != SUCCESS, "enqueue failed, result=%d.", (int32_t)ret);
    // release recvmsg
    LogFree(recvBuf);
    recvBuf = NULL;
}

int32_t SlogdFirmwareLogFlush(void *args, uint32_t len, bool flushFlag)
{
    (void)len;
    ONE_ACT_ERR_LOG(args == NULL, return LOG_FAILURE, "firmware log flush args is NULL.");
    int32_t deviceId = *(int32_t *)args;
    return SlogdWriteDeviceLog(&g_deviceResource[deviceId], flushFlag);
}

void SlogdFirmwareLogGet(SessionItem *handle, void *buffer, uint32_t bufferLen, int32_t devId)
{
    (void)handle;
    (void)buffer;
    (void)bufferLen;
    (void)devId;
}

#endif

/**
* @brief: used to clean up resources shared between recv and write thread
* @param [in]deviceInfo: struct which contains device resources
*/
STATIC void CleanUpSharedRes(DeviceRes *deviceInfo)
{
    ONE_ACT_NO_LOG(deviceInfo == NULL, return);
    LOCK_WARN_LOG(&deviceInfo->lock);
    (void)LogQueueFree(deviceInfo->devLogQueue, XFreeLogNode);
    XFREE(deviceInfo->devLogQueue);
    XFREE(deviceInfo->logBuff);
    UNLOCK_WARN_LOG(&deviceInfo->lock);
    (void)ToolMutexDestroy(&deviceInfo->lock);
}

static LogStatus PrepareThreadRes(const unsigned int deviceId)
{
    // avoid memory leak when thread restart
    DeviceRes *deviceInfo = &g_deviceResource[deviceId];

    // set and init different device buffer queue
    LogQueue *devLogQueue = (LogQueue *)LogMalloc(sizeof(LogQueue));
    if (devLogQueue == NULL) {
        SELF_LOG_ERROR("malloc failed, device_id=%u, strerr=%s.", deviceId, strerror(ToolGetErrorCode()));
        return LOG_FAILURE;
    }

    // init log buffer queue for every device,one buffer queue for one device
    (void)LogQueueInit(devLogQueue, deviceId);

    LogBuff *logBuff = (LogBuff *)LogMalloc(sizeof(LogBuff));
    if (logBuff == NULL) {
        SELF_LOG_ERROR("malloc failed, device_id=%u, strerr=%s.", deviceId, strerror(ToolGetErrorCode()));
        XFREE(devLogQueue);
        return LOG_FAILURE;
    }
    logBuff->moduleId = 0; // to distinguish different type of modules
    logBuff->devId = deviceId;
    deviceInfo->logBuff = logBuff;
    deviceInfo->devLogQueue = devLogQueue;

    return LOG_SUCCESS;
}

STATIC LogRt GetDevNumIDs(uint32_t *deviceNum, uint32_t *deviceIdArray)
{
    int32_t devNum = 0;
    int32_t devId[MAX_DEV_NUM] = { 0 };
    if ((deviceNum == NULL) || (deviceIdArray == NULL)) {
        return FLAG_FALSE;
    }
    int32_t ret = log_get_device_id(devId, &devNum, MAX_DEV_NUM);
    if ((ret != SYS_OK) || (devNum > MAX_DEV_NUM) || (devNum < 0)) {
        SELF_LOG_ERROR("get device id failed, result=%d, device_number=%d.", ret, devNum);
        return FLAG_FALSE;
    }
    *deviceNum = (uint32_t)devNum;
    int32_t idx = 0;
    for (; idx < devNum; idx++) {
        if ((devId[idx] >= 0) && (devId[idx] < MAX_DEV_NUM)) {
            deviceIdArray[idx] = (uint32_t)devId[idx];
        }
    }
    return SUCCESS;
}

STATIC int32_t FirmwareDirFilter(const ToolDirent *dir)
{
    ONE_ACT_NO_LOG(dir == NULL, return FILTER_NOK);
    if ((dir->d_type == (uint8_t)DT_DIR) && LogStrStartsWith(dir->d_name, DEVICE_HEAD)) {
        return FILTER_OK;
    }
    return FILTER_NOK;
}

STATIC int32_t FirmwareFileFilter(const ToolDirent *dir)
{
    ONE_ACT_NO_LOG(dir == NULL, return FILTER_NOK);
    if (LogStrStartsWith(dir->d_name, DEVICE_HEAD)) {
        return FILTER_OK;
    }
    return FILTER_NOK;
}

STATIC void RenameOldFirmwareDirs(const char *path, const char *dir)
{
    ONE_ACT_NO_LOG(path == NULL, return);
    ONE_ACT_NO_LOG(dir == NULL, return);
    char srcDir[MAX_FILEDIR_LEN] = { 0 };
    int32_t ret = snprintf_s(srcDir, MAX_FILEDIR_LEN, MAX_FILEDIR_LEN - 1U, "%s/%s", path, dir);
    ONE_ACT_ERR_LOG(ret == -1, return, "snprintf_s failed, strerr=%s", strerror(ToolGetErrorCode()));

    char dstDir[MAX_FILEDIR_LEN] = { 0 };
    ret = snprintf_s(dstDir, MAX_FILEDIR_LEN, MAX_FILEDIR_LEN - 1U, "%s/%s/%s", path, DEBUG_DIR_NAME, dir);
    ONE_ACT_ERR_LOG(ret == -1, return, "snprintf_s failed, strerr=%s", strerror(ToolGetErrorCode()));

    LogStatus result = LogRenameDir(srcDir, dstDir, FirmwareFileFilter);
    if (result != LOG_SUCCESS) {
        SELF_LOG_ERROR("rename firmware dir failed, source directory=%s, destined directory=%s, result=%d.",
                       srcDir, dstDir, result);
    } else {
        SELF_LOG_INFO("rename firmware dir succeed, dir=%s.", srcDir);
    }
}

/**
 * @brief       : scan path and move dir[device-0] to dir debug
                  delete this func after one-year compatibility period, merged at 2023/11
 * @param [in]  : path      scan path
 * @return      : level
 */
STATIC void ScanFirmwareDir(const char *path)
{
    ONE_ACT_NO_LOG(path == NULL, return);
    ToolDirent **namelist = NULL;
    // get dir lists
    int32_t totalNum = ToolScandir(path, &namelist, FirmwareDirFilter, NULL);
    if ((totalNum < 0) || ((totalNum > 0) && (namelist == NULL))) {
        return;
    }

    for (int32_t i = 0; i < totalNum; i++) {
        RenameOldFirmwareDirs(path, namelist[i]->d_name);
    }
    ToolScandirFree(namelist, totalNum);
}

static LogStatus SlogdFirmwareLogDirInit(void)
{
    // scan root path and move dir[device-*] to dir[debug]
    char *rootPath = LogGetRootPath();
    ONE_ACT_ERR_LOG(rootPath == NULL, return LOG_FAILURE, "Root path is null.");
    ScanFirmwareDir(rootPath);
    return LOG_SUCCESS;
}

LogStatus SlogdFirmwareLogResInit(void)
{
    for (uint32_t i = 0; i < MAX_DEV_NUM; i++) {
        g_deviceResource[i].devLogQueue = NULL;
        g_deviceResource[i].logBuff = NULL;
        g_deviceResource[i].nodeCnt = 0;
        (void)ToolMutexInit(&g_deviceResource[i].lock); // device thread operate lock
    }
    uint32_t deviceIdArray[MAX_DEV_NUM] = { 0 };    // device-side device id array
    uint32_t devNum = 0;
    ONE_ACT_ERR_LOG(GetDevNumIDs(&devNum, deviceIdArray) != SUCCESS, return LOG_FAILURE, "get device id failed.");
    LogStatus ret = LOG_SUCCESS;
    uint32_t bufSize = SlogdConfigMgrGetBufSize(FIRM_LOG_TYPE);
    for (uint32_t i = 0; i < devNum; i++) {
        ret = SlogdBufferInit(FIRM_LOG_TYPE, bufSize, deviceIdArray[i], NULL);
        if (ret != LOG_SUCCESS) {
            return LOG_FAILURE;
        }
        ret = PrepareThreadRes(deviceIdArray[i]);
        if (ret != LOG_SUCCESS) {
            return LOG_FAILURE;
        }
    }
    ret = SlogdFirmwareLogDirInit();
    if (ret != LOG_SUCCESS) {
        return LOG_FAILURE;
    }
    return LOG_SUCCESS;
}

void SlogdFirmwareLogResExit(void)
{
    for (uint32_t i = 0; i < MAX_DEV_NUM; i++) {
        CleanUpSharedRes(&(g_deviceResource[i]));
    }
    SlogdBufferExit(FIRM_LOG_TYPE, NULL);
}