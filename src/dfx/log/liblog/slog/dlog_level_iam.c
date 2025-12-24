/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "dlog_level_mgr.h"
#include "dlog_iam.h"
#include "dlog_attr.h"

#ifdef __cplusplus
extern "C" {
#endif // __cplusplus

#if (!defined LOG_CPP) && (!defined APP_LOG)

#define ENABLEEVENT_KEY     "enableEvent"
#define GLOBALLEVEL_KEY     "global_level"
#define DEBUGLEVEL_KEY      "debug_level"
#define RUNLEVEL_KEY        "run_level"
#define IOCTL_W_PRINT_NUM   1000U

STATIC uint32_t g_ioctlGlobalPrintNum = 0;

/**
 * @brief        : get module loglevel by IAM
 */
STATIC void GetModuleLogLevelByIam(void)
{
    LogLevelConfInfo levelInfo;
    const ModuleInfo *moduleInfo = DlogGetModuleInfos();
    (void)memset_s(&levelInfo, sizeof(LogLevelConfInfo), 0, sizeof(LogLevelConfInfo));
    int32_t ret = strncpy_s(levelInfo.configName, CONF_NAME_MAX_LEN + 1, IOCTL_MODULE_NAME, strlen(IOCTL_MODULE_NAME));
    if (ret != EOK) {
        SELF_LOG_ERROR("moduleName strcpy failed, ret=%d, strerr=%s, pid=%d.", \
                       ret, strerror(ToolGetErrorCode()), ToolGetPid());
        return;
    }
    // app call write to get info from slogmgr
    struct IAMIoctlArg arg;
    arg.size = sizeof(LogLevelConfInfo);
    arg.argData = (void *)&levelInfo;
    ret = DlogIamIoctlGetLevel(&arg);
    if (ret == SYS_ERROR) {
        return;
    }

    for (; moduleInfo->moduleName != NULL; moduleInfo++) {
        if ((moduleInfo->moduleId < 0) || (moduleInfo->moduleId >= INVLID_MOUDLE_ID) ||
            (levelInfo.configValue[moduleInfo->moduleId] < LOG_MIN_LEVEL) ||
            (levelInfo.configValue[moduleInfo->moduleId] > LOG_MAX_LEVEL)) {
            continue;
        }
        (void)DlogSetLogTypeLevelByModuleId(moduleInfo->moduleId, levelInfo.configValue[moduleInfo->moduleId],
                                            DLOG_GLOBAL_TYPE_MASK);
    }
    return;
}

/**
 * @brief        : get global loglevel By IAM
 */
STATIC void GetGlobalLogLevelByIam(void)
{
    LogLevelConfInfo levelInfo;
    (void)memset_s(&levelInfo, sizeof(LogLevelConfInfo), 0, sizeof(LogLevelConfInfo));
    int32_t ret = strncpy_s(levelInfo.configName, CONF_NAME_MAX_LEN + 1, GLOBALLEVEL_KEY, strlen(GLOBALLEVEL_KEY));
    if (ret != EOK) {
        SELF_LOG_ERROR("name(global_level) strcpy failed, result=%d, strerr=%s, pid=%d.", \
                       ret, strerror(ToolGetErrorCode()), ToolGetPid());
        return;
    }
    struct IAMIoctlArg arg;
    arg.size = sizeof(LogLevelConfInfo);
    arg.argData = (void *)&levelInfo;
    ret = DlogIamIoctlGetLevel(&arg);
    if (ret == SYS_OK) {
        if ((levelInfo.configValue[0] >= LOG_MIN_LEVEL) && (levelInfo.configValue[0] <= LOG_MAX_LEVEL)) {
            SetGlobalLogTypeLevelVar(levelInfo.configValue[0], DLOG_GLOBAL_TYPE_MASK);
            DlogSetLogTypeLevelToAllModule(levelInfo.configValue[0], DLOG_GLOBAL_TYPE_MASK);
            SELF_LOG_INFO("%s=%d.", GLOBALLEVEL_KEY, levelInfo.configValue[0]);
        } else {
            SELF_LOG_WARN("%s=%d is illegal, pid=%d, use value=%d.", GLOBALLEVEL_KEY,
                          levelInfo.configValue[0], ToolGetPid(), GetGlobalLogTypeLevelVar(DLOG_GLOBAL_TYPE_MASK));
        }
        if ((levelInfo.configValue[1] == EVENT_DISABLE_VALUE) || (levelInfo.configValue[1] == EVENT_ENABLE_VALUE)) {
            bool enable = (levelInfo.configValue[1] == EVENT_ENABLE_VALUE) ? true : false;
            SetGlobalEnableEventVar(enable);
            SELF_LOG_INFO("g_enableEvent=%d.", levelInfo.configValue[1]);
        } else {
            SELF_LOG_WARN("enableEvent=%d is illegal, pid=%d, use value=%d.", \
                          levelInfo.configValue[1], ToolGetPid(), GetGlobalEnableEventVar());
        }
    } else {
        SELF_LOG_WARN_N(&g_ioctlGlobalPrintNum, IOCTL_W_PRINT_NUM, "can not get global_level, result=%d, "
                        "pid=%d, use value=%d", ret, ToolGetPid(), GetGlobalLogTypeLevelVar(DLOG_GLOBAL_TYPE_MASK));
    }
}

/**
 * @brief           : when iam is ready, get log level by iam will be call back
 */
STATIC void DlogLevelInitCallBack(void)
{
    if (!DlogCheckAttrSystem()) {   // APP
        return;
    }

    // get global_level
    GetGlobalLogLevelByIam();
    // get module loglevel
    GetModuleLogLevelByIam();
}

/**
 * @brief           : register log level call back
 */
void DlogLevelInit(void)
{
    DlogIamRegisterServer(DlogLevelInitCallBack);
    SetGlobalLogTypeLevelVar(DLOG_IAM_DEFAULT_LEVEL, DLOG_GLOBAL_TYPE_MASK);
    DlogSetLogTypeLevelToAllModule(DLOG_IAM_DEFAULT_LEVEL, DLOG_GLOBAL_TYPE_MASK);
    return;
}

#endif  // ifndef LOG_CPP

#ifdef __cplusplus
}
#endif // __cplusplus