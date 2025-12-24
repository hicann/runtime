/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "mdc_slog_stub.h"
#include "log_level.h"
#include "log_config.h"
#include "dlog_attr.h"
#include "log_system_api.h"
#include "log_print.h"

#define NULL 0

typedef void (*IamRegister) (struct IAMVirtualResourceStatus *resList, const int32_t listNum);
IamRegister g_iamRegRes = NULL;

int32_t IAMRegResStatusChangeCb(void (*ResourceStatusChangeCb)(struct IAMVirtualResourceStatus *resList,
                                                               const int32_t listNum),
                                struct IAMResourceSubscribeConfig config)
{
    g_iamRegRes = ResourceStatusChangeCb;
    struct IAMVirtualResourceStatus virtualResStatus = { LOGOUT_IAM_SERVICE_PATH, IAM_RESOURCE_READY };
    g_iamRegRes(&virtualResStatus, 1);
    return 0;
}

int32_t IAMUnregAssignedResStatusChangeCb(const char * const resName)
{
    g_iamRegRes = NULL;
    return 0;
}

bool IAMCheckServicePreparation(void)
{
    return true;
}

static int32_t g_globalLevel = 3;
static int32_t g_eventLevel = 1;

void SlogSetLevel(int32_t level)
{
    g_globalLevel = level;
}

void SlogSetEventLevel(int32_t level)
{
    g_eventLevel = level;
}

int32_t SlogIamIoctlStub(int32_t fd, uint32_t cmd, struct IAMIoctlArg *arg)
{
    if (cmd == IAM_CMD_GET_LEVEL) {
        LogLevelConfInfo *levelConfInfo = (LogLevelConfInfo *)(arg->argData);
        if (strcmp(levelConfInfo->configName, GLOBALLEVEL_KEY) == 0) {
            levelConfInfo->configValue[0] = g_globalLevel; // global_level
            levelConfInfo->configValue[1] = g_eventLevel; // event_level
            return 0;
        }
        if (strcmp(levelConfInfo->configName, IOCTL_MODULE_NAME) == 0) {
            for (int32_t i = 0; i < INVLID_MOUDLE_ID; i++) {
                levelConfInfo->configValue[i] = 5;
            }
            return 0;
        }
    } else {
        return 0;
    }
}

int32_t clock_gettime_stub(clockid_t clock_id, struct timespec *tp)
{
    static long nsec = 0;
    nsec += 200 * 1000000; // 200ms
    tp->tv_nsec = nsec;
    return 0;
}

int32_t g_sendThreadStatus = 0;
ToolThread  g_sendThreadTid = 0;
typedef void (*Timer) (void);

STATIC void *WriteLogByIamPeriodic(void *arg)
{
    Timer callBack = (Timer)arg;
    NO_ACT_WARN_LOG(ToolSetThreadName("WriteLogByIamPeriodic") != 0,
                    "can not set thread_name(WriteLogByIamPeriodic), pid=%d.", DlogGetCurrPid());
    while (g_sendThreadStatus != 0) {
        callBack();
        ToolSleep(1000);
    }
    SELF_LOG_INFO("Thread(WriteLogByIamPeriodic) quit, pid=%d.", DlogGetCurrPid());
    return NULL;
}

static void DlogStartSendThread(void (*callback)())
{
    // start thread
    ToolUserBlock thread;
    thread.procFunc = WriteLogByIamPeriodic;
    thread.pulArg = callback;
    ToolThreadAttr attr = { 0, 0, 0, 0, 0, 0, 0 };
    ToolThread  tid = 0;
    g_sendThreadStatus = 1;
    ToolCreateTaskWithThreadAttr(&tid, &thread, &attr);
    g_sendThreadTid = tid;
}

static *DlogSyncTaskStub(void *arg)
{
    Timer callBack = (Timer)arg;
    usleep(100000); // sleep 100ms
    callBack();
    SELF_LOG_INFO("DlogSyncTaskStub finished.");
    return NULL;
}

static void DlogAddSyncThread(void (*callback)())
{
    // start thread
    ToolUserBlock thread;
    thread.procFunc = DlogSyncTaskStub;
    thread.pulArg = callback;
    ToolThreadAttr attr = { 0, 0, 0, 0, 0, 0, 0 };
    ToolThread tid = 0;
    ToolCreateTaskWithThreadAttr(&tid, &thread, &attr);
}

uint32_t AddUnifiedTimer(const char *timerName, void (*callback)(), int64_t period, enum TimerType type)
{
    if (type == PERIODIC_TIMER) {
        DlogStartSendThread(callback);
    } else {
        DlogAddSyncThread(callback);
    }
    return 0;
}

void DlogStopSendThread(void)
{
    g_sendThreadStatus = 0;
    if ((g_sendThreadTid != 0) && (DlogCheckCurrPid())) {
        (void)ToolJoinTask(&g_sendThreadTid);
        g_sendThreadTid = 0;
    }
}

uint32_t RemoveUnifiedTimer(const char *timerName)
{
    DlogStopSendThread();
    return 0;
}

void CloseUnifiedTimer()
{
    return;
}

void ResetStatus(void)
{
    g_sendThreadStatus = 0;
    if ((g_sendThreadTid != 0) && (DlogCheckCurrPid())) {
        (void)ToolJoinTask(&g_sendThreadTid);
    }
    g_sendThreadTid = 0;
}

int32_t g_handle = 0;
#define MAP_SIZE 3
static SymbolInfo g_timerMap[3] = {
    { "AddUnifiedTimer", (void *)AddUnifiedTimer },
    { "RemoveUnifiedTimer", (void *)RemoveUnifiedTimer },
    { "CloseUnifiedTimer", (void *)CloseUnifiedTimer },
};

void *logDlopen(const char *fileName, int mode)
{
    if (strcmp(fileName, "libunified_timer.so") == 0)
    {
        return &g_handle;
    }
    return NULL;
}

int32_t logDlclose(void *handle)
{
    return 0;
}

void *logDlsym(void *handle, const char* funcName)
{
    for (int32_t i = 0; i < MAP_SIZE; i++) {
        if (strcmp(funcName, g_timerMap[i].symbol) == 0) {
            return g_timerMap[i].handle;
        }
    }
    return NULL;
}

void DlogCreateCmdFile(int32_t clockId)
{
    FILE *fp = fopen(BOOTARGS_FILE_PATH, "w");
    uint32_t length = 1024;
    char msg[length];
    snprintf_s(msg, length, length - 1, "[MDC_SLOGD_FUNC_STEST][Log] test for dpclk=%d", clockId);
    fwrite(msg, length, 1, fp);
    fclose(fp);
}

int32_t DlogGetLogLossNum(char *msg, int32_t mode)
{
    char resultFile[200] = {0};
    sprintf(resultFile, "%s/LogLossResult.txt", PATH_ROOT);
    char cmd[200] = {0};
    // level control loss
    if (mode == 0) {
        sprintf(cmd, "cat %s/LogFile.txt | grep -a \"%s\" | awk '{print $(NF-0)}' > %s", PATH_ROOT, msg, resultFile); // level control loss
        system(cmd);
        memset_s(cmd, sizeof(cmd), 0, sizeof(cmd));
    }
    // covered loss
    if (mode == 1) {
        sprintf(cmd, "cat %s/LogFile.txt | grep -a \"%s\" | awk '{print $(NF-7)}' > %s", PATH_ROOT, msg, resultFile); // last covered loss
        system(cmd);
        memset_s(cmd, sizeof(cmd), 0, sizeof(cmd));
        sprintf(cmd, "cat %s/LogFile.txt | grep -a \"%s\" | awk '{print $(NF-4)}' >> %s", PATH_ROOT, msg, resultFile); // covered loss
        system(cmd);
        memset_s(cmd, sizeof(cmd), 0, sizeof(cmd));
    }
    char buf[MSG_LENGTH] = {0};
    FILE *fp = fopen(resultFile, "r");
    if (fp == NULL) {
        return false;
    }
    int32_t num = 0;
    while (fgets(buf, MSG_LENGTH, fp) != NULL) {
        num += atoi(buf);
        (void)memset_s(buf, MSG_LENGTH, 0, MSG_LENGTH);
    }
    return num;
}