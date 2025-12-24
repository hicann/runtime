/* *
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "file_monitor_core.h"
#include "log_print.h"
#include "event_process_core.h"
#include "file_monitor_common.h"
#include "file_bbox_monitor.h"
#include "stackcore_file_monitor.h"
#include "file_slogdlog_monitor.h"
#include "file_device_app_monitor.h"
#include "server_mgr.h"

#define MAX_CONCURRENT_NUM 1U

static ServerHandle g_monitorHandle = NULL;

static void FileMonitorStopAll(void)
{
    BboxMonitorStop();
    (void)StackcoreMonitorStop();
    SlogdlogMonitorStop();
    DeviceAppMonitorStop();
}

STATIC void FileMonitorStop(void)
{
    FileMonitorStopAll();
    g_monitorHandle = NULL;
}

static int32_t FileMonitorStartAll(void)
{
    int32_t ret = LOG_SUCCESS;
    if (BboxMonitorStart() != LOG_SUCCESS) {
        SELF_LOG_ERROR("start bbox monitor failed.");
        ret = LOG_FAILURE;
    }
    if (StackcoreMonitorStart() != LOG_SUCCESS) {
        SELF_LOG_ERROR("start stackcore monitor failed.");
        ret = LOG_FAILURE;
    }
    if (SlogdlogMonitorStart() != LOG_SUCCESS) {
        SELF_LOG_ERROR("start slogdlog monitor failed.");
        ret = LOG_FAILURE;
    }
    if (DeviceAppMonitorStart() != LOG_SUCCESS) {
        SELF_LOG_ERROR("start device app monitor failed.");
        ret = LOG_FAILURE;
    }
    return ret;
}

STATIC int32_t FileMonitorStart(ServerHandle handle)
{
    // the handle of the exception branch is released by the ServerMgr.
    if (handle == NULL) {
        SELF_LOG_ERROR("input handle is invalid.");
        return LOG_FAILURE;
    }
    if (g_monitorHandle != NULL) {
        SELF_LOG_ERROR("monitor handle is exist, no more handle is needed.");
        return LOG_FAILURE;
    }

    // receives the master ID sent by the host.
    uint32_t bufLen = MASTER_ID_STR_LEN;
    char *buffer = (char *)LogMalloc(bufLen);
    ONE_ACT_ERR_LOG(buffer == NULL, return LOG_FAILURE,
        "malloc for ack buffer failed, strerr=%s.", strerror(ToolGetErrorCode()));
    const uint32_t timeout = 1000; // timeout for receive msg
    int32_t ret = ServerRecvMsg(handle, &buffer, &bufLen, timeout);
    if ((ret != LOG_SUCCESS) || (bufLen == 0U)) {
        SELF_LOG_ERROR("receive message from host failed, ret=%d, bufLen=%u.", ret, bufLen);
        XFREE(buffer);
        return LOG_FAILURE;
    }
    if (!LogStrStartsWith(buffer, MASTER_ID_STR_HEAD)) {
        SELF_LOG_ERROR("check message from host failed, message = %s.", buffer);
        XFREE(buffer);
        return LOG_FAILURE;
    }
    FileMonitorSetMasterIdStr(buffer);
    XFREE(buffer);

    g_monitorHandle = handle;
    ret = FileMonitorStartAll();
    if (ret != LOG_SUCCESS) {
        SELF_LOG_ERROR("start file monitor failed, ret = %d.", ret);
        FileMonitorStop();
        return LOG_FAILURE;
    }
    return LOG_SUCCESS;
}

static int32_t FileMonitorSync(const char *srcFileName, const char *dstFileName)
{
    return ServerSyncFile(g_monitorHandle, srcFileName, dstFileName);
}

static int32_t FileMonitorInitAll(void)
{
    int32_t ret = BboxMonitorInit(FileMonitorSync);
    ONE_ACT_NO_LOG(ret != LOG_SUCCESS, return LOG_FAILURE);
    ret = StackcoreMonitorInit(FileMonitorSync);
    ONE_ACT_NO_LOG(ret != LOG_SUCCESS, return LOG_FAILURE);
    ret = SlogdlogMonitorInit(FileMonitorSync);
    ONE_ACT_NO_LOG(ret != LOG_SUCCESS, return LOG_FAILURE);
    ret = DeviceAppMonitorInit(FileMonitorSync);
    ONE_ACT_NO_LOG(ret != LOG_SUCCESS, return LOG_FAILURE);
    return LOG_SUCCESS;
}

int32_t FileMonitorInit(void)
{
    // if the init operation fails, the upper layer invokes FileMonitorExit to release the resource.
    int32_t ret = EventThreadCreate();
    if (ret != LOG_SUCCESS) {
        SELF_LOG_ERROR("create event thread failed, ret = %d.", ret);
        return LOG_FAILURE;
    }

    ServerAttr attr = { MAX_CONCURRENT_NUM, SERVER_LONG_LINK, ENV_NON_DOCKER };
    ret = ServerCreate(COMPONENT_FILE_REPORT, FileMonitorStart, FileMonitorStop, &attr);
    if (ret != LOG_SUCCESS) {
        SELF_LOG_ERROR("create file trans server failed, ret = %d.", ret);
        return LOG_FAILURE;
    }

    ret = FileMonitorInitAll();
    if (ret != LOG_SUCCESS) {
        SELF_LOG_ERROR("init file monitor failed, ret = %d.", ret);
        return LOG_FAILURE;
    }
    SELF_LOG_INFO("file monitor init success");
    return LOG_SUCCESS;
}

static void FileMonitorExitAll(void)
{
    BboxMonitorExit();
    StackcoreMonitorExit();
    SlogdlogMonitorExit();
    DeviceAppMonitorExit();
}

void FileMonitorExit(void)
{
    EventThreadRelease();
    FileMonitorExitAll();
    ServerRelease(COMPONENT_FILE_REPORT);
}