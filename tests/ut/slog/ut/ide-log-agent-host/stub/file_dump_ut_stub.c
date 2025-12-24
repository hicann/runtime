/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "ascend_hal.h"
#include "log_recv.h"
#include "mmpa_api.h"
#include "adx_service_config.h"
#include "adcore_api.h"

int mmAccess2(const char *pathName, int mode)
{
    return 0;
}

void mmScandirFree(mmDirent **entryList, int count)
{
}

int mmScandir(const char *path, mmDirent ***entryList, mmFilter filterFunc, mmSort sort)
{
    return 0;
}

int mmRealPath(const char *path, char *realPath, int realPathLen)
{
    return 0;
}

int mmIsDir(const char *fileName)
{
    return 0;
}

int mmMkdir(const char *pathName, mmMode_t mode)
{
    return 0;
}

int mmAccess(const char *pathName)
{
    return 0;
}

int mmWaitPid(mmProcess pid, int *status, int options)
{
    return 0;
}

int mmCreateProcess(const char *fileName, const mmArgvEnv *env, const char *stdoutRedirectFile, mmProcess *id)
{
    return 0;
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

int32_t AdxSendFileByHandle(AdxCommConHandle handle, CmdClassT type, AdxString srcPath, AdxString desPath,
    SendFileType flag)
{
    return 0;
}

int32_t AdxSendMsgByHandle(AdxCommConHandle handle, CmdClassT type, AdxString data, uint32_t len)
{
    return 0;
}

int HdclogDeviceInit(void)
{
    return 0;
}

int HdclogDeviceDestroy(void)
{
    return 0;
}

int IdeDeviceLogProcess(const CommHandle *command, const void* value, unsigned int len)
{
    return 0;
}

int32_t MsnCmdInit(void)
{
    return 0;
}
int32_t MsnCmdDestory(void)
{
    return 0;
}
int32_t MsnCmdProcess(const CommHandle *command, const void* value, uint32_t len)
{
    return 0;
}

int AdxServiceStartup(ServerInitInfo info)
{
    return 0;
}

drvError_t halHdcGetSessionAttr(HDC_SESSION session, int attr, int *value)
{
    return DRV_ERROR_NONE;
}

int AdxComponentServerStartup(ServerInitInfo info)
{
    return 0;
}

int AdxRegisterComponentFunc(int serverType, void **adxComponent)
{
    return 0;
}

void AdxDestroyCommHandle(CommHandle *handle)
{
    (void)handle;
}

int32_t HbmDetectInit(void)
{
    return 0;
}

int32_t HbmDetectDestroy(void)
{
    return 0;
}

int32_t HbmDetectProcess(const CommHandle *command, const void* value, uint32_t len)
{
    (void)command;
    (void)value;
    (void)len;
    return 0;
}

int32_t AdxSendMsg(const CommHandle *handle, AdxString data, uint32_t len)
{
    return 0;
}

int32_t AdxRecvMsg(AdxCommHandle handle, char **data, uint32_t *len, uint32_t timeout)
{
    return 0;
}

int32_t AdxGetAttrByCommHandle(AdxCommConHandle handle, int32_t attr, int32_t *value)
{
    (void)handle;
    if (attr == 6) { // HDC_SESSION_ATTR_STATUS
        *value = 1; // connect
    } else if (attr == 2) { // HDC_SESSION_ATTR_RUN_ENV
        *value = 1; // NON_DOCKER
    } else {
        *value = 0;
    }
    return 0;
}