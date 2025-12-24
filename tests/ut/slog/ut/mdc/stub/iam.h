/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef IAM_H
#define IAM_H
#include <sys/types.h>
#include <sys/stat.h>
#include <unistd.h>
#include <stdint.h>
#include <fcntl.h>
#include <sys/mman.h>
#include <stdbool.h>

#define IAM_RESOURCE_NAME_SIZE 64UL

#define IAM_LIB_PATH "/usr/lib64/libiam.so.1"

#ifdef __cplusplus
extern "C" {
#endif

/************************************************
 *  IAM manage
 ***********************************************/
enum IAMResourceStatus {
    IAM_RESOURCE_READY = 0U,
    IAM_RESOURCE_WAITING,
    IAM_RESOURCE_INVALID, // invalid res name or cannot be subscrib
    IAM_RESOURCE_GETSTATUS_TIMEOUT, // open pipe timeout
    IAM_RESOURCE_STATUS_MAX_VALUE,
};

struct IAMVirtualResourceStatus {
    char IAMResName[IAM_RESOURCE_NAME_SIZE];
    enum IAMResourceStatus status;
};

struct IAMResourceSubscribeConfig {
    struct IAMVirtualResourceStatus *resList;
    uint32_t listNum;
    int32_t timeout;
};

int32_t IAMResMgrReady(void);
int32_t IAMUnregisterService(void);
int32_t IAMRetrieveService(void);

int32_t IAMRegResStatusChangeCb(void (*ResourceStatusChangeCb)(struct IAMVirtualResourceStatus *resList,
                                                               const int32_t listNum),
                                struct IAMResourceSubscribeConfig config);
int32_t IAMRegResAllReadyCb(void (*ResourceStatusChangeCb)(enum IAMResourceStatus status), int32_t timeout);
int32_t IAMUnregResStatusChangeCb(void);
int32_t IAMUnregAssignedResStatusChangeCb(const char * const resName);
bool IAMCheckServicePreparation(void);

/************************************************
 *  SecVFS DFS/QFS/RTFS common
 ***********************************************/
struct IAMIoctlArg {
    size_t size;
    void *argData;
};

/************************************************
 *  SecVFS DFS
 ***********************************************/
struct IAMMgrFile {
    int32_t sid;
    const char *appName;
    const char *fileName;
    const char *serviceName;
    int32_t flags;
    mode_t mode;
    void *priv;
    int32_t timeOut;
    uint32_t appPid;
    uint32_t accessPerm;
};
struct IAMFileOps {
    ssize_t (*read)(struct IAMMgrFile *, char *buf, size_t len, loff_t *pos);
    ssize_t (*write)(struct IAMMgrFile *, const char *buf, size_t len, loff_t *pos);
    int32_t (*ioctl)(struct IAMMgrFile *, uint32_t cmd, struct IAMIoctlArg *);
    int32_t (*open)(struct IAMMgrFile *);
    int32_t (*close)(struct IAMMgrFile *);
};
struct IAMFileConfig {
    const char *serviceName;
    const struct IAMFileOps *ops;
    int32_t timeOut;
};

int32_t IAMRegisterService(const struct IAMFileConfig *config);

/************************************************
 *  SsService Interface
 ***********************************************/
int32_t IamRegisterSystemService(void (*resMgrSysStateHandle)(int32_t));

#ifdef __cplusplus
}
#endif

#endif // IAM_H