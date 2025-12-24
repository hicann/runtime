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
#include <sys/ioctl.h>
#include <sys/mman.h>
#include <stdbool.h>
#include "fault_event.h"

#ifndef _GNU_SOURCE
#define loff_t off_t
#endif

#ifdef __cplusplus
#define EXTERN_C extern "C"
#else
#define EXTERN_C
#endif

#define EVENT_PIPE_BUF_MAX 3960
#define EVENT_SPEC_SIZE_MAX 128
#define IOCTL_CMD_TIMEOUT 0x7FFF0001U
#define IOCTL_CMD_GET_FILE_TYPE 0x7FFF0002U
#define IAM_NAME_SIZE 253U
#define IAM_RESOURCE_NAME_SIZE 64UL

#define IAM_LIB_PATH "/usr/lib64/libiam.so.1"

#ifdef __cplusplus
extern "C" {
#endif

#define FILE_NAME_LEN 200UL
#define DEFAULT_FS_TIMEOUT (-1)

#define IAMNodeStatusInfo FTENodeStatusInfo
#define IAMEventSpec FTESpec
#define IAMEventInfo FTEInfo
#define IAMDidInfo FTEDidInfo
#define IAMUDSInfo FTEUDSInfo

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
int32_t IAMResMgrReportEvent(const struct IAMEventInfo *eventInfo, const struct IAMUDSInfo *udsInfo);
const char *IAMMapToServiceName(const char *path);
int32_t IAMCheckVirtualFd(int32_t fd);
int32_t IAMUnregisterService(void);
int32_t IAMRetrieveService(void);

int32_t IAMRegResStatusChangeCb(void (*ResourceStatusChangeCb)(struct IAMVirtualResourceStatus *resList,
                                                               const int32_t listNum),
                                struct IAMResourceSubscribeConfig config);
int32_t IAMRegResAllReadyCb(void (*ResourceStatusChangeCb)(enum IAMResourceStatus status), int32_t timeout);
int32_t IAMUnregResStatusChangeCb(void);
bool IAMCheckServicePreparation(void);
int32_t IAMUnregAssignedResStatusChangeCb(char *resName);

/************************************************
 *  SecVFS DFS/QFS/RTFS common
 ***********************************************/
struct IAMSecVFSFreqLimit {
    int32_t openLimit;
    int32_t generalLimit;
};
struct IAMIoctlArg {
    size_t size;
    void *argData;
};
int32_t IAMSetFreqLimit(const char *serviceName, const struct IAMSecVFSFreqLimit *limit);

/************************************************
 *  SecVFS QFS/RTFS common
 ***********************************************/
enum IAM_SECVFS_FILE_TYPE {
    QFILE = 1,
    RTFILE,
};

struct xshmem_pool;

struct IAMShmBlock {
    uint32_t blockHandle;
    void *addr;
    uint32_t size;
};
struct IAMShmPool {
    struct xshmem_pool *xshmemPool_writer;
    struct xshmem_pool *xshmemPool_reader;
    uint32_t writerPoolHandle;
    uint32_t readerPoolHandle;
    uint32_t size;
    char name[IAM_NAME_SIZE + 1U];
};
struct IAMShmPoolConfig {
    const char *fileName;
    uint32_t size;
    gid_t gid;
};

ssize_t IAMFastRead(int32_t fd, void *buf, size_t count);
int32_t IAMShmRegisterPoolWithConfig(struct IAMShmPoolConfig *config, struct IAMShmPool *poolHandle);
int32_t IAMShmRegisterPool(const char *fileName, uint32_t size, struct IAMShmPool *poolHandle);
int32_t IAMShmMalloc(struct IAMShmPool *poolHandle, uint32_t allocedSize, struct IAMShmBlock *blockHandle);
int32_t IAMShmHandleMalloc(struct IAMShmPool *poolHandle, uint32_t allocedSize, struct IAMShmBlock *blockHandle);
int32_t IAMShmWrite(struct IAMShmBlock *inBlock, const void *buffer, const size_t size, const uint32_t offset);
int32_t IAMShmFree(struct IAMShmPool *poolHandle, struct IAMShmBlock *blockHandle);
int32_t IAMShmDestroyPool(struct IAMShmPool *pool);
int32_t IAMShmExceptionHandler(void);
int32_t IAMShmSerializeBlockInfo(void *buf, size_t size, struct IAMShmBlock *blockHandle,
                                 struct IAMShmPool *poolHandle);

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
int32_t IAMResetFileConfig(const int32_t fd, const int32_t timeout);
void *IAMMmap(void *addr, size_t length, int32_t prot, int32_t flags, int32_t fd, off_t offset);
int32_t IAMMunmap(void *addr, size_t length);

/************************************************
 *  SecVFS QFS
 ***********************************************/
struct IAMDataQueue;
struct IamQfsMgrFile {
    const char *appName;
    const char *fileName;
    const char *serviceName;
    struct IAMDataQueue *queue;
    void *priv;
    uint32_t appPid;
};
struct IAMQfsFileOps {
    ssize_t (*write)(struct IamQfsMgrFile *, const char *buf, size_t len, loff_t *pos);
    int32_t (*ioctl)(struct IamQfsMgrFile *, uint32_t cmd, struct IAMIoctlArg *);
    int32_t (*open)(struct IamQfsMgrFile *);
    int32_t (*close)(struct IamQfsMgrFile *);
};
struct IAMQFileConfig {
    const char *serviceName;
    struct IAMQfsFileOps *ops;
    int32_t timeOut;
};

int32_t IAMRegisterQueueService(const struct IAMQFileConfig *config);
int32_t IAMDataEnqueue(struct IAMDataQueue *queue, struct IAMShmPool *pool, struct IAMShmBlock *block);
int32_t IAMDataClear(struct IAMDataQueue *queue);

/************************************************
 *  SecVFS RTFS
 ***********************************************/
enum IAMRTDataPriority {
    IAM_RT_DATA_PRIO_NORMAL,
    IAM_RT_DATA_PRIO_HIGH,
    IAM_RT_DATA_PRIO_INVALID
};
enum IAMHungerStrategyEnum {
    IAM_REQUEST_MIXED_STRATEGY,
    IAM_REQUEST_STRATEGY_INVALID
};
enum IAMRTType {
    IAM_POLICY_DEFAULT_PRIO_DEFAULT,
    IAM_POLICY_FIFO_PRIO_HIGH,
    IAM_RTTYPE_BUTT
};
struct IAMRTParam {
    enum IAMHungerStrategyEnum hungerStrategy;
    union IAMHungerStrategyParam {
        struct IAMMixedStrategy {
            uint32_t maxHigh;
        } mixedStrategy;
    } hungerParam;
    enum IAMRTType rtType;
};
struct IAMRTDataQueue;
struct IAMRTFSMgrFile {
    const char *appName;
    const char *fileName;
    const char *serviceName;
    struct IAMRTDataQueue *queue;
    void *priv;
    uint32_t appPid;
};
struct IAMRTFSFileOps {
    ssize_t (*write)(struct IAMRTFSMgrFile *, const char *buf, size_t len, loff_t *pos);
    int32_t (*ioctl)(struct IAMRTFSMgrFile *, uint32_t cmd, struct IAMIoctlArg *);
    int32_t (*open)(struct IAMRTFSMgrFile *);
    int32_t (*close)(struct IAMRTFSMgrFile *);
};
struct IAMRTFileConfig {
    const char *serviceName;
    struct IAMRTFSFileOps *ops;
    int32_t timeOut;
    struct IAMRTParam rtParam;
};
struct IAMRTDataPacket {
    struct IAMShmPool *pool;
    struct IAMShmBlock *block;
    enum IAMRTDataPriority prio;
};

int32_t IAMRegisterRTService(const struct IAMRTFileConfig *config);
int32_t IAMRTDataEnqueue(struct IAMRTDataQueue *queue, struct IAMRTDataPacket *data);
int32_t IAMRTDataClear(struct IAMRTDataQueue *queue);

/************************************************
 *  SecVFS RPC
 ***********************************************/
struct IAMServiceRPCConfig {
    int32_t timeOut;
};
struct IAMServiceRequest {
    uint8_t *data;
    uint32_t size;
};
struct IAMServiceResponse {
    uint8_t *data;
    uint32_t size;
};

int32_t IAMInitServiceRPC(const char *rscFilePath, size_t rscFilePathLen);
int32_t IAMInitServiceRPCWithConfig(const char *rscFilePath, size_t rscFilePathLen,
                                    const struct IAMServiceRPCConfig *config);
int32_t IAMServiceRPCSync(int32_t fd, const struct IAMServiceRequest *req, struct IAMServiceResponse *resp);
int32_t IAMFiniServiceRPC(int32_t fd);

/************************************************
 *  SsService Interface
 ***********************************************/
int32_t IamRegisterSystemService(void (*resMgrSysStateHandle)(int32_t));

struct IAMQueryPermInfo {
    const char *procName;
    const char *rscFilePath;
    int32_t pid;
};

enum IAMAuthStatus {
    AUTH_DISABLED,
    AUTH_PERMISSIVE,
    AUTH_ENFORCING
};

struct IAMPermResult {
    int32_t permission;
    int32_t isDataApp;
    enum IAMAuthStatus macStatus;
};

int32_t IAMQueryAccessPermission(const struct IAMQueryPermInfo *permInfo, struct IAMPermResult *result);

#ifdef __cplusplus
}
#endif

#ifdef __cplusplus
#include <string>
enum ProcType {
    GENERAL,
    PRIVILEGED
};

struct AppConfig {
    std::string procName;
    std::string executablePath;
    enum ProcType type;
};

enum class ReportAppStateType : uint32_t {
    /* STARTING_TO_RUNNING */
    RUNNING_NORMAL_START,
    /* RESTART_START_STARTING_TO_RUNNING */
    RUNNING_NORMAL_RESTART,
    /* TERMINATING_TO_RUNNING */
    RUNNING_ABNORMAL_TERM_TIMEOUT,
    /* TERMINATING_TO_TERMINATED */
    TERMINATED_NORMAL_EXIT,
    /* RUNNING_TO_TERMINATED or STARTING_TO_TERMINATED or RESTART_START_STARTING_TO_TERMINATED */
    TERMINATED_ABNORMAL_EXIT,
    /* try again */
    INVALID_INTERMEDIATE_STATE
};

enum AppAbnormalExitReason : uint32_t  {
    NORMAL_REASON,
    EXIT_BY_EIO,
    REASON_MAX,
};

struct IAMAppInfo {
    std::string appName;
    uint32_t pid;
    gid_t gid;
    ReportAppStateType state;
    enum AppAbnormalExitReason abnormalReason;
};

int32_t IAMInitProc(const AppConfig &config);

/*
 * This function provides only for EM in C++ format, and is declared in #ifdef __cplusplus branch.
 * EM module has a requirement for dynamically loading and calling this function. One way is to add
 * extern "C"  declaraction:
 * https://tldp.org/HOWTO/pdf/C++-dlopen.pdf
 * so we add extern "C" for this C++ interface, and EM will use dlopen and dlsym to call IAMSendAppInfo.
 */
EXTERN_C int32_t IAMSendAppInfo(const struct IAMAppInfo &appInfo);

#endif

#endif // IAM_H