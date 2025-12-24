/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef AICPUSD_AICPUSD_INFO_H
#define AICPUSD_AICPUSD_INFO_H

#include <cstdint>
#include <sched.h>
#include <sys/types.h>
#include "../common/type_def.h"

extern "C" {
struct __attribute__((visibility("default"))) AICPUActiveStream {
    uint32_t streamId;
};

static const uint32_t MAX_CUST_SO_NAME_LEN = 128U;
static const uint32_t OP_NAME_MAX_LEN = 50U;
static const uint32_t FUN_NAME_MAX_LEN = 30U;
static const uint32_t ERROR_KEY_INFO_MAX_LEN = 30U;
static const uint32_t MODULE_NAME_MAX_LEN = 10U;
static const uint32_t FILE_NAME_MAX_LEN = 30U;
static const uint16_t PRIORITY_MSG_CHECKCODE = 0xABCD;
static const int32_t  INVALID_ESCAPE_PRI_VALUE = -1;
// loadOpFromBuf task args
struct __attribute__((visibility("default"))) LoadOpFromBufArgs {
    uint64_t kernelSoBuf;        // the starting address of custom operator so buf
    uint32_t kernelSoBufLen;     // the length of custom operator so buf
    uint64_t kernelSoName;       // the starting address of custom operator so name
    uint32_t kernelSoNameLen;    // the length of custom operator so name
} __attribute__((packed));

// batchLoadOpFromBuf task args
struct __attribute__((visibility("default"))) BatchLoadOpFromBufArgs {
    uint32_t soNum;              // the number of so
    uint64_t opInfoArgs;
} __attribute__((packed));

/**
 * The mode of profiling
 */
enum __attribute__((visibility("default"))) ProfilingMode {
    PROFILING_CLOSE = 0,
    PROFILING_OPEN,
};

enum __attribute__((visibility("default"))) AicpuSchedMode {
    SCHED_MODE_INTERRUPT = 0,
    SCHED_MODE_MSGQ,
    SCHED_MODE_INVALID
};

enum __attribute__((visibility("default"))) AICPUSubEvent {
    AICPU_SUB_EVENT_ACTIVE_STREAM = 0,
    AICPU_SUB_EVENT_EXECUTE_MODEL,
    AICPU_SUB_EVENT_REPEAT_MODEL,
    AICPU_SUB_EVENT_RECOVERY_STREAM,
    AICPU_SUB_EVENT_UPDATE_PROFILING_MODE,
    AICPU_SUB_EVENT_LOAD_SO,
    AICPU_SUB_EVENT_END_GRAPH,
    AICPU_SUB_EVENT_ACTIVE_MODEL,
    AICPU_SUB_EVENT_PREPARE_MEM,
    AICPU_SUB_EVENT_TABLE_UNLOCK,
    AICPU_SUB_EVENT_SUPPLY_ENQUEUE,
    AICPU_SUB_EVENT_MAX_NUM,
};

enum __attribute__((visibility("default"))) AICPUCustSubEvent {
    // sub type begin with 10 for interface event
    AICPU_SUB_EVENT_BIND_SD_PID = 10,     // cust-sd bind sd pid, Implemented by cust-sd
    AICPU_SUB_EVENT_OPEN_CUSTOM_SO,  // open costom so file, Implemented by cust-sd
    AICPU_SUB_EVENT_CUST_UPDATE_PROFILING_MODE,  // update profiling mode, Implemented by cust-sd
    AICPU_SUB_EVENT_ABNORMAL_LOG,  // print aicpu cust schedule's error log
    AICPU_SUB_EVENT_REPORT_CUST_DUMPDATA, // aicpusd do cust datadump
    AICPU_SUB_EVENT_REPORT_UDF_DUMPDATA, // aicpusd do udf datadump
    AICPU_SUB_EVENT_CUST_LOAD_PLATFORM,        // custom scheduler process load platform info event
};

struct __attribute__((visibility("default"))) AICPUSubEventStreamInfo {
    uint32_t streamId;
};

struct __attribute__((visibility("default"))) AICPUProfilingModeInfo {
    uint32_t deviceId;
    pid_t hostpId;
    uint32_t flag;
};

struct __attribute__((visibility("default"))) AICPULoadSoInfo {
    uint32_t kernelSoIndex;
};

struct __attribute__((visibility("default"))) AICPUEndGraphInfo {
    uint32_t result;
};

struct __attribute__((visibility("default"))) AICPUSharderTaskInfo {
    uint32_t parallelId;
    int64_t shardNum;

    bool operator==(const AICPUSharderTaskInfo &sharderInfo) const noexcept
    {
        return (parallelId == sharderInfo.parallelId);
    }
};

struct __attribute__((visibility("default"))) AICPUUnLockTableInfo {
    uint32_t tableId;
};

struct __attribute__((visibility("default"))) AICPUDumpCustInfo {
    uint32_t threadIndex;   // dump任务的线程号
    int32_t  retCode;       // dump result
    uint32_t streamId;      // dump key streamId
    uint32_t taskId;        // dump key taskId
};

struct __attribute__((visibility("default"))) AICPUDumpUdfInfo {
    uint64_t length;
    uint64_t udfInfo;
    uint32_t udfPid;
    char_t rsv[20];
};

struct __attribute__((visibility("default"))) AICPULoadPlatformCustInfo {
    uint64_t length;
    uint64_t platformInfo;
    uint32_t aicpuPid;
    char_t rsv[20];
};

struct __attribute__((visibility("default"))) AICPUSubEventInfo {
    uint32_t modelId;
    union {
        AICPUSubEventStreamInfo streamInfo;
        AICPUProfilingModeInfo modeInfo;
        AICPULoadSoInfo loadSoInfo;
        AICPUEndGraphInfo endGraphInfo;
        AICPUSharderTaskInfo sharderTaskInfo;
        AICPUUnLockTableInfo unlockTableInfo;
    } para;
};

struct __attribute__((visibility("default"))) AICPUBindSdPidEventMsg {
    int32_t pid;
} __attribute__((packed));

struct __attribute__((visibility("default"))) AICPUOpenCustomSoEventMsg {
    char_t kernelSoName[MAX_CUST_SO_NAME_LEN];
} __attribute__((packed));

struct __attribute__((visibility("default"))) CpuSchedInitParam {
    uint32_t deviceId;
    pid_t hostPid;
    ProfilingMode profilingMode;
    char_t rsv[128];
} __attribute__((packed));

struct __attribute__((visibility("default"))) ModelQueueInfo {
    uint32_t queueId;
    uint32_t flag;
} __attribute__((packed));

struct __attribute__((visibility("default"))) ModelTaskInfo {
    uint32_t taskId;
    uint64_t kernelName;
    uint64_t paraBase;     // param地址
} __attribute__((packed));

struct __attribute__((visibility("default"))) ModelStreamInfo {
    uint32_t streamId;
    uint32_t streamFlag;
    uint16_t taskNum;
    ModelTaskInfo *tasks;
} __attribute__((packed));

struct __attribute__((visibility("default"))) AicpuPriInfo {
    uint16_t checkHead;
    int32_t pidPriority;
    int32_t eventPriority;
}__attribute__((packed));

struct __attribute__((visibility("default"))) ModelCommOpList {
    uint64_t commOpDescsListAddr;
    uint32_t opNum;
}__attribute__((packed));

// 配置类型，用于给AICPU控制不同的加载流程
enum __attribute__((visibility("default"))) ModelType {
    kModelWithEmbedding = 0,
    kModelWithSyncEvent = 1,
    kModelTypeNum
};

struct __attribute__((visibility("default"))) CommGroup {
    const char *groupName;
    uint32_t rankNum;
    uint32_t *rankIds;
}__attribute__((packed));

struct __attribute__((visibility("default"))) CommGroups {
    uint32_t groupNum;
    CommGroup *groups;
}__attribute__((packed));

struct __attribute__((visibility("default"))) ModelCfgInfo {
    uint64_t inBuffPoolSizeAddr;       // input buffer block num array's address, the array is uint16_t[]
    uint64_t outBuffPoolSizeAddr;      // output buffer block num array's address, the array is uint16_t[]
    uint64_t inBuffSizeAddr;           // input block size array's address, the array is uint64_t[]
    uint64_t outBuffSizeAddr;          // output block size array's address, the array is uint64_t[]
    uint32_t inputNum;
    uint32_t outputNum;
    int32_t tagId;                 // tag id for hccl
    int32_t rankId;                // rank id for hccl
    uint64_t rankTableLen;         // rank table length
    uint64_t rankTableAddr;        // rank table ptr
    uint64_t roleTableLen;         // cluster spec length
    uint64_t roleTableAddr;        // role table ptr
    uint64_t modelCommOpListAddr;  // ModelCommOpList ptr
    uint32_t modelType;
    uint64_t commGroupsAddr;       // communication groups ptr
    int32_t psId;                  // ps id
    bool supportCounterFilter;     // counter filter flag
    bool memoryRegister;
    uint64_t clientRankNum;        // clientRank array's length
    uint64_t clientRankAddr;       // clientRank array's address, the array is uint32_t[]
    uint64_t hcclCommNameAddr;     // hcclComm name's addr, the name is char*
    int32_t hcclTimeOut;           // 0 means default, -1 means never timeout
    bool associateWorker;          // true means we need to associate worker when load model, default false
    char rsv[53UL];
} __attribute__((packed));


struct __attribute__((visibility("default"))) ModelInfo {
    uint32_t modelId;
    uint16_t aicpuStreamNum;
    ModelStreamInfo *streams;
    uint16_t queueNum;
    ModelQueueInfo *queues;
    int32_t abnormalBreak;
    int32_t abnormalEnqueue;
    AicpuPriInfo aicpuPriInfo;
    uint64_t cfgInfoPtr = 0;
    int32_t abnormalEnable = 1;
    char rsv[98];
} __attribute__((packed));

struct __attribute__((visibility("default"))) ReDeployConfig {
    uint64_t modelIdsAddr;   // ptr which point to modelIds(uint32_t)
    uint32_t modelIdNum;  // modelIdNum
    char rsv[4];
} __attribute__((packed));

struct __attribute__((visibility("default"))) CheckKernelSupportedConfig {
    uint64_t kernelNameAddr;    // ptr which point to kernelName
    uint32_t kernelNameLen;
    uint64_t checkResultAddr;   // int32: 0 is supported, others are not supported
    uint32_t checkResultLen;
} __attribute__((packed));

struct __attribute__((visibility("default"))) DataFlowExceptionNotify {
    uint64_t transId;
    uint32_t type;	// 0:Exception occured, 1:Exception expired
    uint32_t modelIdNum;
    uint64_t modelIdsAddr; // ptr which point to modelIds(uint32_t)
    char rsv[40];
} __attribute__((packed));
}
#endif  // AICPUSD_AICPUSD_INFO_H