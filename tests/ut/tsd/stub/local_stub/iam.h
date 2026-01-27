/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef IAMMGR_IAM_H
#define IAMMGR_IAM_H
#include <sys/types.h>
#include <sys/stat.h>
#include <unistd.h>
#include <stdint.h>
#include <fcntl.h>
#include <sys/ioctl.h>
#include <sys/mman.h>

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
#define IOCTL_CMD_TIMEOUT 0x7FFF0001
#define IOCTL_CMD_GET_FILE_TYPE 0x7FFF0002
#define IOCTL_CMD_MMAP 0x7FFF0003
#define IOCTL_CMD_MUNMAP 0x7FFF0004

// This is the location of IAM library in runtime env
#define IAM_LIB_PATH    "/usr/lib64/libiam.so.1"

#ifdef __cplusplus
extern "C" {
#endif

const size_t FILE_NAME_LEN = 200;
const int DEFAULT_FS_TIMEOUT = -1;

#define IAMNodeStatusInfo FTENodeStatusInfo

#define IAMEventSpec FTESpec

#define IAMEventInfo FTEInfo

#define IAMDidInfo FTEDidInfo

#define IAMUDSInfo FTEUDSInfo

struct IAMServiceRequest {
    uint8_t *data;
    uint32_t size;
};

struct IAMIoctlArg {
    size_t size;
    void *argData;
};

struct IAMServiceResponse {
    uint8_t *data;
    uint32_t size;
};

struct IAMMgrFile {
    int sid;
    const char *appName;
    const char *fileName;
    const char *serviceName;
    int flags;
    mode_t mode;
    void *priv;
    int timeOut;
};

enum ProcType { // 进程类型
    GENERAL,
    PRIVILEGED
};


struct AppConfig {
    std::string procName; //全局唯一的进程名，该进程名会被映射到FIFO管道文件名
    std::string executablePath;
    enum ProcType type;
};


enum IAM_SECVFS_FILE_TYPE {
    QFILE = 1,
    RTFILE,
};

struct IAMFileOps {
    ssize_t (*read)(struct IAMMgrFile *, char *buf, size_t len, loff_t *pos);
    ssize_t (*write)(struct IAMMgrFile *, const char *buf, size_t len, loff_t *pos);
    int (*ioctl)(struct IAMMgrFile *, unsigned cmd, struct IAMIoctlArg *);
    int (*open)(struct IAMMgrFile *);
    int (*close)(struct IAMMgrFile *);
};

struct IAMFileConfig {
    const char *serviceName;
    const struct IAMFileOps *ops;
    int timeOut;
};

int IAMRegisterService(const struct IAMFileConfig *config);
int IAMResMgrReady(void);
int IAMRegAllSystemStateChange(void);
int IAMResMgrReportEvent(const struct IAMEventInfo *eventInfo, const struct IAMUDSInfo *udsInfo);
int IAMValidateDev(const char *cert, unsigned int certLen);
int IAMInitProc(const AppConfig &config);


struct IAMShmBlock {
    struct xshmem_block *block;
    void *addr;
    uint32_t size;
};

struct IAMShmPool {
    struct xshmem_pool *xshmemPool_writer;
    struct xshmem_pool *xshmemPool_reader;
    uint32_t size;
    char name[100];
};

/************************************************
 *  IAM QFS
 ***********************************************/
struct IAMDataQueue;

struct IamQfsMgrFile {
    const char *appName;
    const char *fileName;
    const char *serviceName;
    struct IAMDataQueue *queue;
    void *priv;
};

struct IAMQfsFileOps {
    ssize_t (*write)(struct IamQfsMgrFile *, const char *buf, size_t len, loff_t *pos);
    int (*ioctl)(struct IamQfsMgrFile *, unsigned cmd, struct IAMIoctlArg *);
    int (*open)(struct IamQfsMgrFile *);
    int (*close)(struct IamQfsMgrFile *);
};

struct IAMQFileConfig {
    const char *serviceName;
    struct IAMQfsFileOps *ops;
    int timeOut;
};

/************************************************
 *  IAM RTFS
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
#ifdef __cplusplus
    IAMRTParam();
#endif
};

struct IAMRTDataQueue;

struct IAMRTFSMgrFile {
    const char *appName;
    const char *fileName;
    const char *serviceName;
    struct IAMRTDataQueue *queue;
    void *priv;
};

struct IAMRTFSFileOps {
    ssize_t (*write)(struct IAMRTFSMgrFile *, const char *buf, size_t len, loff_t *pos);
    int (*ioctl)(struct IAMRTFSMgrFile *, unsigned cmd, struct IAMIoctlArg *);
    int (*open)(struct IAMRTFSMgrFile *);
    int (*close)(struct IAMRTFSMgrFile *);
};

struct IAMRTFileConfig {
    const char *serviceName;
    struct IAMRTFSFileOps *ops;
    int timeOut;
    struct IAMRTParam rtParam;
#ifdef __cplusplus
    IAMRTFileConfig();
#endif
};

struct IAMRTDataPacket {
    struct IAMShmPool *pool;
    struct IAMShmBlock *block;
    enum IAMRTDataPriority prio;
};

int IAMRTDataEnqueue(struct IAMRTDataQueue *queue, struct IAMRTDataPacket *data);
int IAMRTDataClear(struct IAMRTDataQueue *queue);

struct IAMServiceRPCConfig {
    int timeOut;
};

#ifndef IAM_HOOK
int IAMOpen(const char *, int, ...);
int IAMClose(int);
int IAMIoctl(int, unsigned long, ...);
ssize_t IAMRead(int, void *, size_t);
ssize_t IAMWrite(int, const void *, size_t);
#endif

int IAMRegisterQueueService(const struct IAMQFileConfig *config);
int IAMRegisterRTService(const struct IAMRTFileConfig *config);
int IAMDataEnqueue(struct IAMDataQueue *queue, struct IAMShmPool *pool, struct IAMShmBlock *block);
int IAMDataClear(struct IAMDataQueue *queue);
ssize_t IAMFastRead(int fd, void *buf, size_t count);
void *IAMMmap(void *addr, size_t length, int prot, int flags, int fd, off_t offset);
int IAMMunmap(void *addr, size_t length);

int IAMInitServiceRPC(const char *rscFilePath, size_t rscFilePathLen);
int IAMInitServiceRPCWithConfig(const char *rscFilePath, size_t rscFilePathLen,
                                const struct IAMServiceRPCConfig *config);
int IAMServiceRPCSync(int fd, const struct IAMServiceRequest *req, struct IAMServiceResponse *resp);
int IAMFiniServiceRPC(int fd);

int IAMShmRegisterPool(const char *fileName, unsigned int size, struct IAMShmPool *poolHandle);
int IAMShmMalloc(struct IAMShmPool *poolHandle, unsigned int allocedSize, struct IAMShmBlock *blockHandle);
int IAMShmFree(struct IAMShmPool *poolHandle, struct IAMShmBlock *blockHandle);
int IAMShmDestroyPool(struct IAMShmPool *pool);
#ifdef __cplusplus
}
#endif

#endif // IAMMGR_IAM_H

