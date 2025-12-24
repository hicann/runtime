/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef ANALYSIS_DVVP_COMMON_OSAL_LINUX_H
#define ANALYSIS_DVVP_COMMON_OSAL_LINUX_H

#include "osal.h"
#ifdef __cplusplus
extern "C" {
#endif  // __cpluscplus

struct CpuTypeTable {
    const CHAR *key;
    const CHAR *value;
};

OSAL_FUNC_VISIBILITY int32_t LinuxSleep(uint32_t milliSecond);
OSAL_FUNC_VISIBILITY int32_t LinuxGetPid(void);
OSAL_FUNC_VISIBILITY int32_t LinuxGetTid(void);

OSAL_FUNC_VISIBILITY OsalSockHandle LinuxSocket(int32_t sockFamily, int32_t type, int32_t protocol);
OSAL_FUNC_VISIBILITY int32_t LinuxBind(OsalSockHandle sockFd, OsalSockAddr *addr, OsalSocklen addrLen);
OSAL_FUNC_VISIBILITY int32_t LinuxListen(OsalSockHandle sockFd, int32_t backLog);
OSAL_FUNC_VISIBILITY OsalSockHandle LinuxAccept(OsalSockHandle sockFd, OsalSockAddr *addr, OsalSocklen *addrLen);
OSAL_FUNC_VISIBILITY int32_t LinuxConnect(OsalSockHandle sockFd, OsalSockAddr *addr, OsalSocklen addrLen);
OSAL_FUNC_VISIBILITY OsalSsize LinuxSocketSend(OsalSockHandle sockFd, VOID *sendBuf, int32_t sendLen, int32_t sendFlag);
OSAL_FUNC_VISIBILITY OsalSsize LinuxSocketRecv(OsalSockHandle sockFd, VOID *recvBuf, int32_t recvLen, int32_t recvFlag);
OSAL_FUNC_VISIBILITY int32_t LinuxGetFileSize(const CHAR *fileName, uint64_t *length);
OSAL_FUNC_VISIBILITY int32_t LinuxGetDiskFreeSpace(const CHAR *path, OsalDiskSize *diskSize);
OSAL_FUNC_VISIBILITY int32_t LinuxIsDir(const CHAR *fileName);
OSAL_FUNC_VISIBILITY int32_t LinuxAccess(const CHAR *pathName);
OSAL_FUNC_VISIBILITY int32_t LinuxAccess2(const CHAR *pathName, int32_t mode);
OSAL_FUNC_VISIBILITY CHAR *LinuxDirName(CHAR *path);
OSAL_FUNC_VISIBILITY CHAR *LinuxBaseName(CHAR *path);
OSAL_FUNC_VISIBILITY int32_t LinuxGetCwd(CHAR *buffer, int32_t maxLen);
OSAL_FUNC_VISIBILITY int32_t LinuxMkdir(const CHAR *pathName, OsalMode mode);
OSAL_FUNC_VISIBILITY int32_t LinuxChmod(const CHAR *filename, int32_t mode);
OSAL_FUNC_VISIBILITY int32_t LinuxChdir(const CHAR *path);
OSAL_FUNC_VISIBILITY int32_t LinuxScandir(const CHAR *path,
    OsalDirent ***entryList, OsalFilter filterFunc, OsalSort sort);
OSAL_FUNC_VISIBILITY VOID LinuxScandirFree(OsalDirent **entryList, int32_t count);
OSAL_FUNC_VISIBILITY int32_t LinuxRmdir(const CHAR *pathName);
OSAL_FUNC_VISIBILITY int32_t LinuxUnlink(const CHAR *filename);
OSAL_FUNC_VISIBILITY int32_t LinuxRealPath(const CHAR *path, CHAR *realPath, int32_t realPathLen);
OSAL_FUNC_VISIBILITY CHAR *LinuxGetErrorFormatMessage(OsalErrorMsg errnum, CHAR *buf, OsalSize size);
OSAL_FUNC_VISIBILITY int32_t LinuxStatGet(const CHAR *path, OsalStat *buffer);
OSAL_FUNC_VISIBILITY int32_t LinuxDup(int32_t oldFd, int32_t newFd);
OSAL_FUNC_VISIBILITY int32_t LinuxOpen(const CHAR *pathName, int32_t flags, OsalMode mode);
OSAL_FUNC_VISIBILITY int32_t LinuxClose(int32_t fd);
OSAL_FUNC_VISIBILITY OsalSsize LinuxWrite(int32_t fd, VOID *buf, uint32_t bufLen);
OSAL_FUNC_VISIBILITY int32_t LinuxGetOptInd(void);
OSAL_FUNC_VISIBILITY CHAR *LinuxGetOptArg(void);
OSAL_FUNC_VISIBILITY int32_t LinuxGetOsName(CHAR *name, int32_t nameSize);
OSAL_FUNC_VISIBILITY VOID *LinuxDlopen(const CHAR *fileName, int32_t mode);
OSAL_FUNC_VISIBILITY VOID *LinuxDlsym(VOID *handle, const CHAR *funcName);
OSAL_FUNC_VISIBILITY int32_t LinuxDlclose(VOID *handle);
OSAL_FUNC_VISIBILITY CHAR *LinuxDlerror(void);

OSAL_FUNC_VISIBILITY int32_t LinuxGetErrorCode(void);
OSAL_FUNC_VISIBILITY int32_t LinuxCreateProcess(const CHAR *fileName, const OsalArgvEnv *env,
    const CHAR *stdoutRedirectFile, OsalProcess *id);
OSAL_FUNC_VISIBILITY int32_t LinuxCreateTaskWithThreadAttr(OsalThread *threadHandle,
    const OsalUserBlock *funcBlock, const OsalThreadAttr *threadAttr);
OSAL_FUNC_VISIBILITY int32_t LinuxWaitPid(OsalProcess pid, int32_t *status, int32_t options);
OSAL_FUNC_VISIBILITY int32_t LinuxJoinTask(OsalThread *threadHandle);
OSAL_FUNC_VISIBILITY OsalTimespec LinuxGetTickCount(void);
OSAL_FUNC_VISIBILITY int32_t LinuxSetCurrentThreadName(const CHAR *name);
OSAL_FUNC_VISIBILITY int32_t LinuxGetOptLong(int32_t argc, CHAR *const *argv, const CHAR *opts,
    const OsalStructOption *longOpts, int32_t *longIndex);
OSAL_FUNC_VISIBILITY int32_t LinuxGetOsVersion(CHAR *versionInfo, int32_t versionLength);
OSAL_FUNC_VISIBILITY int32_t LinuxGetCpuInfo(OsalCpuDesc **cpuInfo, int32_t *count);
OSAL_FUNC_VISIBILITY int32_t LinuxCpuInfoFree(OsalCpuDesc *cpuInfo, int32_t count);
OSAL_FUNC_VISIBILITY int32_t LinuxGetLocalTime(OsalSystemTime *sysTimePtr);
OSAL_FUNC_VISIBILITY int32_t LinuxGetTimeOfDay(OsalTimeval *timeVal, OsalTimezone *timeZone);
#ifdef __cplusplus
}
#endif /* __cpluscplus */

#endif /* ANALYSIS_DVVP_COMMON_OSAL_LINUX_H */