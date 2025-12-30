/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef ASCEND_HAL_BASE_H
#define ASCEND_HAL_BASE_H

#include "ascend_hal_define.h"
#include "ascend_hal_external.h"

#ifdef __cplusplus
extern "C" {
#endif

typedef drvError_t hdcError_t;
typedef void *HDC_CLIENT;
typedef void *HDC_SESSION;
typedef void *HDC_SERVER;
typedef void *HDC_EPOLL;

#define HDC_EPOLL_CTL_ADD 0
#define HDC_EPOLL_CTL_DEL 1

#define HDC_EPOLL_CONN_IN (0x1 << 0)
#define HDC_EPOLL_DATA_IN (0x1 << 1)
#define HDC_EPOLL_FAST_DATA_IN (0x1 << 2)
#define HDC_EPOLL_SESSION_CLOSE (0x1 << 3)

struct drvHdcEvent {
    unsigned int events;
    uintptr_t data;
};

#define RUN_ENV_UNKNOW 0
#define RUN_ENV_PHYSICAL 1
#define RUN_ENV_PHYSICAL_CONTAINER 2
#define RUN_ENV_VIRTUAL 3
#define RUN_ENV_VIRTUAL_CONTAINER 4

/**< The HDC interface is dead and blocked by default. Set HDC_FLAG_NOWAIT to be non-blocked */
/**< Set HDC_FLAG_WAIT_TIMEOUT to timeout after blocking for a period of time. HDC_FLAG_WAIT_TIMEOUT */
/**< takes precedence over HDC_FLAG_NOWAIT */
#define HDC_FLAG_NOWAIT (0x1 << 0)        /**< Occupy bit0 */
#define HDC_FLAG_WAIT_TIMEOUT (0x1 << 1)  /**< Occupy bit1 */
#define HDC_FLAG_MAP_VA32BIT (0x1 << 1)   /**< Use low 32bit memory */
#define HDC_FLAG_MAP_HUGE (0x1 << 2)      /**< Using large pages */

/* 通信类型 */
enum halHdcTransType {
    HDC_TRANS_USE_SOCKET = 0,
    HDC_TRANS_USE_PCIE = 1
};

enum drvHdcServiceType {
    HDC_SERVICE_TYPE_DMP = 0,
    HDC_SERVICE_TYPE_PROFILING = 1, /**< used by profiling tool */
    HDC_SERVICE_TYPE_IDE1 = 2,
    HDC_SERVICE_TYPE_FILE_TRANS = 3,
    HDC_SERVICE_TYPE_IDE2 = 4,
    HDC_SERVICE_TYPE_LOG = 5,
    HDC_SERVICE_TYPE_RDMA = 6,
    HDC_SERVICE_TYPE_BBOX = 7,
    HDC_SERVICE_TYPE_FRAMEWORK = 8,
    HDC_SERVICE_TYPE_TSD = 9,
    HDC_SERVICE_TYPE_TDT = 10,
    HDC_SERVICE_TYPE_PROF = 11, /* used by drv prof */
    HDC_SERVICE_TYPE_IDE_FILE_TRANS = 12,
    HDC_SERVICE_TYPE_DUMP = 13,
    HDC_SERVICE_TYPE_USER3 = 14, /* used by user */
    HDC_SERVICE_TYPE_DVPP = 15, /* support multiple processes */
    HDC_SERVICE_TYPE_QUEUE = 16, /* support multiple processes */
    HDC_SERVICE_TYPE_UPGRADE = 17,
    HDC_SERVICE_TYPE_RDMA_V2 = 18, /* support multiple processes */
    HDC_SERVICE_TYPE_TEST = 19, /* support multiple processes */
    HDC_SERVICE_TYPE_KMS = 20,
    HDC_SERVICE_TYPE_USER_START = 64,
    HDC_SERVICE_TYPE_USER_END = 127,
    HDC_SERVICE_TYPE_MAX
};

enum drvHdcSessionAttr {
    HDC_SESSION_ATTR_DEV_ID = 0,
    HDC_SESSION_ATTR_UID = 1,
    HDC_SESSION_ATTR_RUN_ENV = 2,
    HDC_SESSION_ATTR_VFID = 3,
    HDC_SESSION_ATTR_LOCAL_CREATE_PID = 4,
    HDC_SESSION_ATTR_PEER_CREATE_PID = 5,
    HDC_SESSION_ATTR_STATUS = 6,
    HDC_SESSION_ATTR_DFX = 7,
    HDC_SESSION_ATTR_MAX
};

enum drvHdcServerAttr {
    HDC_SERVER_ATTR_DEV_ID = 0,
    HDC_SERVER_ATTR_MAX
};

enum drvHdcChanType {
    HDC_CHAN_TYPE_SOCKET = 0,
    HDC_CHAN_TYPE_PCIE,
    HDC_CHAN_TYPE_MAX
};

enum drvHdcMemType {
    HDC_MEM_TYPE_TX_DATA = 0,
    HDC_MEM_TYPE_TX_CTRL = 1,
    HDC_MEM_TYPE_RX_DATA = 2,
    HDC_MEM_TYPE_RX_CTRL = 3,
    HDC_MEM_TYPE_DVPP = 4,
    HDC_MEM_TYPE_ANY = 5,
    HDC_MEM_TYPE_MAX
};

enum drvHdcSessionCloseType {
    HDC_SESSION_CLOSE_FLAG_NORMAL = 0,  /* close session with notify remote */
    HDC_SESSION_CLOSE_FLAG_LOCAL = 1,   /* close session without notify remote */
    HDC_SESSION_CLOSE_FLAG_MAX
};

#define HDC_SESSION_MEM_MAX_NUM 100

struct drvHdcFastSendMsg {
    unsigned long long srcDataAddr;
    unsigned long long dstDataAddr;
    unsigned long long srcCtrlAddr;
    unsigned long long dstCtrlAddr;
    unsigned int dataLen;
    unsigned int ctrlLen;
};

struct drvHdcFastRecvMsg {
    unsigned long long dataAddr;
    unsigned long long ctrlAddr;
    unsigned int dataLen;
    unsigned int ctrlLen;
};

struct drvHdcFastSendFinishMsg {
    unsigned long long dataAddr;
    unsigned long long ctrlAddr;
    unsigned int dataLen;
    unsigned int ctrlLen;

    unsigned int result; /* 0-send success, other- send fail */
    unsigned int rsv1;
    unsigned int rsv2;
};

struct drvHdcWaitMsgInput {
    int time_out;
    unsigned int result_type;
    unsigned int rsv1;
    unsigned int rsv2;
};

struct drvHdcCapacity {
    enum drvHdcChanType chanType;
    unsigned int maxSegment;
};

struct drvHdcMsgBuf {
    char *pBuf;
    int len;
};

struct drvHdcMsg {
    int count;
    struct drvHdcMsgBuf bufList[0];
};

struct drvHdcRecvConfig {
    UINT64 wait_flag;
    UINT32 timeout;
    int group_flag;
    int reserved_params1;
    int reserved_params2;
    int reserved_params3;
    int reserved_params4;
};

struct drvHdcProgInfo {
    char name[256];
    int progress;
    long long int send_bytes;
    long long int rate;
    int remain_time;
};

#define HDC_SESSION_INFO_RES_CNT 8

struct drvHdcSessionInfo {
    unsigned int devid;
    unsigned int fid;
    unsigned int res[HDC_SESSION_INFO_RES_CNT];
};

typedef int (*drvHdcSessionConnectNotify)(int dev_id, int vfid, int peer_pid, int local_pid);
typedef int (*drvHdcSessionCloseNotify)(int dev_id, int vfid, int peer_pid, int local_pid);
typedef int (*drvHdcSessionDataInNotify)(int dev_id, int vfid, int local_pid);

struct HdcSessionNotify {
    drvHdcSessionConnectNotify connect_notify;
    drvHdcSessionCloseNotify close_notify;
    drvHdcSessionDataInNotify data_in_notify;
};

struct mem_module_usage {
    char name[32]; /* module name Length 32 */
    uint64_t cur_mem_size;   /* Current memory size occupied by the module */
    uint64_t mem_peak_size;   /* Peak memory size occupied by the module */
    size_t reserved[8];  /* reserved field 8 */
};

#ifdef __cplusplus
}
#endif
#endif
