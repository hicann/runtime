/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef __CCE_RUNTIME_PROFILER_STRUCT_HPP__
#define __CCE_RUNTIME_PROFILER_STRUCT_HPP__
#include "base.hpp"
#include "profiler_struct.hpp"
#include "toolchain/prof_api.h"

#define M_PROF_DIRSTR_LEN       (128)
#define M_PROF_FMTSTR_LEN       (64)
#define M_PROF_FMTSTR_NUM       (64)
#define M_PROF_CFGLNE_LEN       (256)
#define M_PROF_EVEID_NUM        (8)
#define M_PROF_EVEARR_LEN       (64)
#define M_PROF_DEVID_NUM        (3)
#define M_PROF_MIN_EVEID        (0)
#define M_PROF_MAX_EVEID        (135)
#define M_PROF_PACKAGE_LEN      (128)
#define M_PROF_KERNEL_TASK_NAME_LEN (255)
#define M_PROF_STREAM_NAME_LEN  (16)
#define M_PROF_EVENT_NAME_LEN   (16)
#define RUNTIME_TASK_TRACK_BUFF_NUM (5U)

#define StreamArgTag   \
    uint16_t streamId; \
    uint16_t deviceId; \
    char_t streamName[M_PROF_STREAM_NAME_LEN];

#define EventArgTag   \
    uint16_t eventId; \
    char_t eventName[M_PROF_EVENT_NAME_LEN];

namespace cce {
namespace runtime {
enum rtProfTag {
    RT_PROF_TAG_API_CALL = 0,
    RT_PROF_TAG_COMMAND,
    RT_PROF_TAG_REPORT,
    RT_PROF_TAG_TIMELINE,
    RT_PROF_TAG_TASK_BASE_AICORE,    // task base aicore data
    RT_PROF_TAG_SAMPLE_BASE_AICORE,  // sample base aicore data
    RT_PROF_TAG_TASK_TRACK,
    RT_PROF_TAG_TS_CPU_USAGE,
    RT_PROF_TAG_AICORE_STATUS,
    RT_PROF_TAG_BUTT
};

enum rtProfApiType_t : uint32_t {
    RT_PROF_API_DEVBINARY_REGISTER = 0,
    RT_PROF_API_DEVBINARY_UNREGISTER = 1,
    RT_PROF_API_FUNCTION_REGISTER = 2,
    RT_PROF_API_KERNEL_LAUNCH = 3,
    RT_PROF_API_KERNEL_FUSION_START = 4,
    RT_PROF_API_KERNEL_FUSION_END = 5,
    RT_PROF_API_STREAM_CREATE = 6,
    RT_PROF_API_STREAM_DESTROY = 7,
    RT_PROF_API_STREAM_WAITEVENT = 8,
    RT_PROF_API_STREAM_SYNCHRONIZE = 9,
    RT_PROF_API_EVENT_CREATE = 10,
    RT_PROF_API_EVENT_DESTROY = 11,
    RT_PROF_API_EVENT_RECORD = 12,
    RT_PROF_API_EVENT_SYNCHRONIZE = 13,
    RT_PROF_API_DEV_MALLOC = 14,
    RT_PROF_API_DEV_FREE = 15,
    RT_PROF_API_HOST_MALLOC = 16,
    RT_PROF_API_HOST_FREE = 17,
    RT_PROF_API_MANAGEDMEM_ALLOC = 18,
    RT_PROF_API_MANAGEDMEM_FREE = 19,
    RT_PROF_API_MEM_CPY = 20,
    RT_PROF_API_MEM_ASYNC = 21,
    RT_PROF_API_SET_DEVICE = 22,          // refer default stream
    RT_PROF_API_DEVICE_RESET = 23,        // refer default stream
    RT_PROF_API_DEVICE_SYNCHRONIZE = 24,  // refer default stream
    RT_PROF_API_CONTEXT_CREATE = 25,
    RT_PROF_API_CONTEXT_DESTROY = 26,
    RT_PROF_API_CONTEXT_SETCURRENT = 27,
    RT_PROF_API_CONTEXT_SYNCHRONIZE = 28,  // refer default stream
    RT_PROF_API_IPC_EVENT_CREATE = 29,
    RT_PROF_API_IPC_EVENT_OPEN = 30,
    RT_PROF_API_IPC_MEMORY_CREATE = 31,
    RT_PROF_API_IPC_MEMORY_OPEN = 32,
    RT_PROF_API_IPC_MEMORY_CLOSE = 33,
    RT_PROF_API_MEMORY_ADVISE = 34,
    RT_PROF_API_MODEL_CREATE = 35,
    RT_PROF_API_MODEL_BIND_STREAM = 36,
    RT_PROF_API_GET_FUNCTION_BY_NAME = 37,
    RT_PROF_API_MODEL_GET_TASKID = 38,
    RT_PROF_API_MODEL_EXECUTE = 39,
    RT_PROF_API_MODEL_UNBIND_STREAM = 40,  // refer default stream
    RT_PROF_API_MODEL_DESTROY = 41,
    RT_PROF_API_RDMASend = 42,
    RT_PROF_API_NotifyCreate = 43,
    RT_PROF_API_NotifyDestroy = 44,
    RT_PROF_API_NotifyRecord = 45,
    RT_PROF_API_NotifyWait = 46,
    RT_PROF_API_IpcOpenNotify = 47,
    RT_PROF_API_rtSwitch = 48,
    RT_PROF_API_rtStreamActive = 49,
    RT_PROF_API_rtSubscribeReport = 50,
    RT_PROF_API_rtCallbackLaunch = 51,
    RT_PROF_API_rtProcessReport = 52,
    RT_PROF_API_rtUnSubscribeReport = 53,
    RT_PROF_API_rtGetRunMode = 54,
    RT_PROF_API_GetEventID = 55,
    RT_PROF_API_RdmaDbSend = 56,
    RT_PROF_API_LabelSwitchByIndex = 57,
    RT_PROF_API_LabelSwitchByCond = 58,
    RT_PROF_API_LabelGotoEx = 59,
    RT_PROF_API_Label2Content = 60,
    RT_PROF_API_CAHCEDMEM_ALLOC = 61,
    RT_PROF_API_ALLKERNEL_REGISTER = 62,
    RT_PROF_API_KERNEL_LAUNCH_WITH_HANDLE = 63,
    RT_PROF_API_STARS_COMMON = 64,
    RT_PROF_API_FFTS = 65,

    RT_PROF_API_Memset = 71,
    RT_PROF_API_CpuKernelLaunch = 72,
    RT_PROF_API_MemsetAsync = 73,
    RT_PROF_API_ReduceAsync = 74,
    RT_PROF_API_EventReset = 75,
    RT_PROF_API_MEM_CPY2D = 76,
    RT_PROF_API_MEM_CPY2D_ASYNC = 77,
    RT_PROF_API_MODEL_SET_SCH_GROUP_ID = 78,
    RT_PROF_API_BUTT = 79,
    RT_PROF_API_HOST_TASK_MEMCPY = 80,
    RT_PROF_API_MODEL_SET_EXT_ID = 81,
    RT_PROF_API_STREAM_SET_MODE = 82,
    RT_PROF_API_TaskInfoLaunch = 83,
    RT_PROF_API_IpcIntNotice = 84,
    RT_PROF_API_STREAM_GET_MODE = 85,
    RT_PROF_API_QUERY_FUNCTION_REGISTERED = 86,
    RT_PROF_API_KERNEL_LAUNCH_HUGE = 87,
    RT_PROF_API_KERNEL_LAUNCH_BIG = 88,
    RT_PROF_API_KERNEL_LAUNCH_FLOW_CTRL = 89,
    RT_PROF_API_KERNEL_LAUNCH_WITH_HANDLE_HUGE = 90,
    RT_PROF_API_KERNEL_LAUNCH_WITH_HANDLE_BIG = 91,
    RT_PROF_API_KERNEL_LAUNCH_WITH_HANDLE_FLOW_CTRL = 92,
    RT_PROF_API_KERNEL_LAUNCH_EX = 93,
    RT_PROF_API_CpuKernelLaunch_EX = 94,
    RT_PROF_API_CpuKernelLaunch_EX_WITH_ARG = 95,
    RT_PROF_API_DATA_DUMP_INFO_LOAD = 96,
    RT_PROF_API_EVENT_CREATE_FOR_NOTIFY = 97,
    RT_PROF_API_EVENT_RECORD_FOR_NOTIFY = 98,
    RT_PROF_API_DEV_DVPP_MALLOC = 99,
    RT_PROF_API_DEV_DVPP_FREE = 100,
    RT_PROF_API_MEM_ADVISE = 101,
    RT_PROF_API_MEMCPY_ASYNC_HUGE = 102,
    RT_PROF_API_MEMCPY_ASYNC = 103,
    RT_PROF_API_MEMCPY_ASYNC_FLOW_CTRL = 104,
    RT_PROF_API_REDUCE_ASYNC_V2 = 105,
    RT_PROF_API_CONTEXT_GET_CURRENT = 106,
    RT_PROF_API_STARS_TASK_LAUNCH = 107,
    RT_PROF_API_FFTS_PLUS_TASK_LAUNCH = 109,
    RT_PROF_API_LABELDESTROY = 110,
    RT_PROF_API_CMO_TASK_LAUNCH = 111,
    RT_PROF_API_BARRIER_TASK_LAUNCH = 112,
    RT_PROF_API_STREAM_SYNC_TASK_FINISH = 113,
    RT_PROF_API_GET_NOTIFY_ADDR = 114,
    RT_PROF_API_BUFF_GET_INFO = 115,
    RT_PROF_API_BINARY_LOAD = 116,
    RT_PROF_API_BINARY_GET_FUNCTION = 117,
    RT_PROF_API_BINARY_UNLOAD = 118,
    RT_PROF_API_LAUNCH_KERNEL = 119,
    RT_PROF_API_CtxSetSysParamOpt = 120,
    RT_PROF_API_CtxGetSysParamOpt = 121,
    RT_PROF_API_CtxGetOverflowAddr = 122,
    RT_PROF_API_GetDeviceSatStatus = 123,
    RT_PROF_API_CleanDeviceSatStatus = 124,
    RT_PROF_API_CpuKernelLaunch_EX_WITH_ARG_BIG = 125,
    RT_PROF_API_CpuKernelLaunch_EX_WITH_ARG_HUGE = 126,
    RT_PROF_API_LAUNCH_KERNEL_HUGE = 127,
    RT_PROF_API_LAUNCH_KERNEL_BIG = 128,
    RT_PROF_API_GET_DEV_ARG_ADDR = 129,
    RT_PROF_API_BINARY_GET_FUNCTION_BY_NAME = 130,
    RT_PROF_API_BINARY_LOAD_WITHOUT_TILING_KEY = 131,
    RT_PROF_API_CMO_ADDR_TASK_LAUNCH = 132,
    RT_PROF_API_EVENT_CREATE_EX = 133,
    RT_PROF_API_AI_CPU_INFO_LOAD = 134,
    RT_PROF_API_MODEL_TASK_UPDATE = 135,
    RT_PROF_API_STREAM_CLEAR = 136,
    RT_PROF_API_NOTIFY_RESET = 137,
    RT_PROF_API_GetServerIDBySDID = 138,
    RT_PROF_API_KERNEL_LAUNCH_LARGE = 139,
    RT_PROF_API_KERNEL_LAUNCH_WITH_HANDLE_LARGE = 140,
    RT_PROF_API_CpuKernelLaunch_EX_WITH_ARG_LARGE = 141,
    RT_PROF_API_LAUNCH_KERNEL_LARGE = 142,
    RT_PROF_API_DEVICE_RESET_FORCE = 143,
    RT_PROF_API_MEM_CPY_ASYNC_PTR = 144,
    RT_PROF_API_USER_TO_LOGIC_ID = 145,
    RT_PROF_API_LOGIC_TO_USER_ID = 146,
    RT_PROF_API_BINARY_LOAD_FROM_FILE = 147,
    RT_PROF_API_BINARY_LOAD_FROM_DATA = 148,
    RT_PROF_API_FUNC_GET_ADDR = 149,
    RT_PROF_API_LAUNCH_DVPP_TASK = 150,
    RT_PROF_API_LAUNCH_RANDOM_NUM_TASK = 151,
    RT_PROF_API_KERNEL_ARGS_INIT = 152,
    RT_PROF_API_KERNEL_ARGS_APEND_PLACE_HOLDER = 153,
    RT_PROF_API_KERNEL_ARGS_GET_PLACE_HOLDER_BUFF = 154,
    RT_PROF_API_KERNEL_ARGS_GET_HANDLE_MEM_SIZE = 155,
    RT_PROF_API_KERNEL_ARGS_FINALIZE = 156,
    RT_PROF_API_KERNEL_ARGS_GET_MEM_SIZE = 157,
    RT_PROF_API_KERNEL_ARGS_INIT_BY_USER_MEM = 158,
    RT_PROF_API_KERNEL_ARGS_APEND = 159,
    RT_PROF_API_LAUNCH_KERNEL_V2 = 160,
    RT_PROF_API_BINARY_GET_FUNCTION_BY_ENTRY = 161,
    RT_PROF_API_COUNT_NOTIFY_CREATE = 162,
    RT_PROF_API_COUNT_NOTIFY_DESTROY = 163,
    RT_PROF_API_COUNT_NOTIFY_RECORD = 164,
    RT_PROF_API_COUNT_NOTIFY_WAIT = 165,
    RT_PROF_API_GET_COUNT_NOTIFY_ADDR = 166,
    RT_PROF_API_GET_COUNT_NOTIFY_RESET = 167,
    RT_PROF_API_WRITE_VALUE = 168,
    RT_PROF_API_UB_DB_SEND = 169,
    RT_PROF_API_UB_DIRECT_SEND = 170,
    RT_PROF_API_FUSION_KERNEL_LAUNCH = 171,
    RT_PROF_API_CCU_LAUNCH = 172,
    RT_PROF_API_MEMCPY_BATCH = 173, 
    RT_PROF_API_GET_CMO_DESC_SIZE = 174,
    RT_PROF_API_SET_CMO_DESC = 175,
    RT_PROF_API_MODEL_EXECUTE_SYNC = 176,
    RT_PROF_API_MODEL_EXECUTE_ASYNC = 177,
    RT_PROF_API_MEM_WRITE_VALUE = 178,
    RT_PROF_API_MEM_WAIT_VALUE = 179,
    RT_PROF_API_GET_DEFAULT_CTX_STATE = 180,
    RT_PROF_API_MEMCPY_ASYNC_BATCH = 181,
    RT_PROF_API_LAUNCH_HOST_CALLBACK = 182,
    RT_PROF_API_CACHE_LAST_TASK_OP_INFO = 183,
    RT_PROF_API_GET_EVENT_HANDLE = 184,
    RT_PROF_API_OPEN_EVENT_HANDLE = 185,
    RT_PROF_API_MAX = 200
};

enum rtProfDrvApiType : uint16_t {
    RT_PROF_DRV_API_BASE            = static_cast<uint16_t>(RT_PROF_API_MAX) + 1U,
    RT_PROF_DRV_API_DrvMemcpy       = RT_PROF_DRV_API_BASE + 1U,     // drvMemcpy
    RT_PROF_DRV_API_DrvMemsetD8     = RT_PROF_DRV_API_BASE + 2U,     // drvMemsetD8
    RT_PROF_DRV_API_HalMemAlloc     = RT_PROF_DRV_API_BASE + 3U,     // halMemAlloc
    RT_PROF_DRV_API_DevMallocCached = RT_PROF_DRV_API_BASE + 4U,     // halMemAlloc
    RT_PROF_DRV_API_DevFree         = RT_PROF_DRV_API_BASE + 5U,     // halMemFree
    RT_PROF_DRV_API_DevDvppMalloc   = RT_PROF_DRV_API_BASE + 6U,     // halMemAlloc
    RT_PROF_DRV_API_DevDvppFree     = RT_PROF_DRV_API_BASE + 7U,     // halMemFree
    RT_PROF_DRV_API_HostMalloc      = RT_PROF_DRV_API_BASE + 8U,     // halMemAlloc
    RT_PROF_DRV_API_HostFree        = RT_PROF_DRV_API_BASE + 9U,     // halMemFree
    RT_PROF_DRV_API_MngMalloc       = RT_PROF_DRV_API_BASE + 10U,    // halMemAlloc
    RT_PROF_DRV_API_MngFree         = RT_PROF_DRV_API_BASE + 11U,    // halMemFree
    RT_PROF_DRV_API_HalMemcpy2D     = RT_PROF_DRV_API_BASE + 12U,    // halMemcpy2D
    RT_PROF_DRV_API_MemcpyBatch     = RT_PROF_DRV_API_BASE + 13U     // halMemcpyBatch
};

/*
for new data struct
before report date, need to register data type useing api MsprofRegTypeInfo
0~800 : task type enum
801: memcpy info
802: task track
803~999 : reserve
1000~ : api
*/
enum rtProfileDataType_t : uint32_t {
    RT_PROFILE_TYPE_TASK_BEGIN = 0,
    RT_PROFILE_TYPE_TASK_END = 800,
    RT_PROFILE_TYPE_MEMCPY_INFO = 801,      /* memcpy info */
    RT_PROFILE_TYPE_TASK_TRACK = 802,      /* task track */
    RT_PROFILE_TYPE_CAPTURE_STREAM_INFO = 803,
    RT_PROFILE_TYPE_SOFTWARE_SQ_ENABLE = 804,
    RT_PROFILE_TYPE_SHAPE_INFO = 805,       /* aclgraph cache & report shape info */
    RT_PROFILE_TYPE_API_BEGIN = 1000,       /* regist task type and task name for Parsing task info*/
    RT_PROFILE_TYPE_API_END = 2000,
    RT_PROFILE_TYPE_MAX = 2001
};

struct RuntimeMemcpyInfo {  // for memcpy info
    uint64_t dateSize;
    uint64_t maxSize;
    uint16_t direction;
};

struct ProfTypeRegisterInfo {
    uint32_t type;
    const char_t* name;
};

#define RUNTIME_TASK_ID_NUM 10U
struct RuntimeProfApiData {
    uint16_t magicNumber = MSPROF_DATA_HEAD_MAGIC_NUM;
    uint16_t dataTag = MSPROF_RUNTIME_DATA_TAG_API;
    uint32_t threadId;
    uint64_t entryTime = 0ULL;
    uint64_t exitTime;
    uint64_t dataSize;
    uint64_t maxSize;
    uint32_t retCode;
    uint32_t streamId;
    uint32_t taskNum;
    uint32_t taskId[RUNTIME_TASK_ID_NUM];
    uint16_t memcpyDirection;
    uint16_t profileType;
};

struct RuntimeProfTrackData {
    uint32_t isModel;
    MsprofCompactInfo compactInfo;
};
 
struct TaskTrackInfo {
    RuntimeProfTrackData trackBuff[RUNTIME_TASK_TRACK_BUFF_NUM];
    uint32_t taskNum = 0U;
};

typedef enum tagTsTaskState {
    TASK_STATE_WAIT = 1,
    TASK_STATE_RUN = 2,
    TASK_STATE_COMPLETE = 3,
    TASK_STATE_PENDING = 4
} tsTaskState_t;

typedef struct ProfileConfig {
    uint8_t isRtsProfEn : 1;
    uint8_t isUsrDefProfEn : 1;
    uint8_t isTaskBasedProfEn : 1;
    uint8_t isOptSelDevice : 1;
    uint8_t isProfLogEn : 1;
    uint8_t isHwtsLogEn : 1;
    uint8_t reserved : 2;
    uint8_t eventId[M_PROF_EVEID_NUM];
    uint64_t profStartCyc;
    uint64_t profStopCyc;
} rtProfCfg_t;

/**
 * @ingroup
 * @brief Profile Record Type
 */
typedef enum tagProfileRecordType {
    PROFILE_RECORD_TYPE_SRART            = 0,

    /* runtime */
    PROFILE_RECORD_TYPE_RT_CALL_RT       = 1,
    PROFILE_RECORD_TYPE_RT_CALL_DRV      = 2,
    PROFILE_RECORD_TYPE_RT_ASYNC_INFO    = 3,
    PROFILE_RECORD_TYPE_RT_ASYNC_SEND    = 4,
    PROFILE_RECORD_TYPE_RT_ASYNC_RECV    = 5,

    /* TS */
    PROFILE_RECORD_TYPE_TS_FORWARD       = 11,
    PROFILE_RECORD_TYPE_TS_BACKWARD      = 12,

    PROFILE_RECORD_TYPE_END              = 13
} rtProfileRecordType_t;

/**
 * @ingroup
 * @brief the struct define of RT_SYNC_RT
 */
typedef struct tagRtProfileRecordSyncRt {
    uint16_t type;     // rtProfileRecordType_t
    uint16_t rtOpType; // rtOperationProfApiType_t
    uint32_t pid;
    uint32_t tid;
    uint32_t seqId;
    uint64_t startStamp;
    uint64_t endStamp;
} rtProfileRecordSyncRt_t;

/**
 * @ingroup
 * @brief the struct define of RT_SYNC_DRV
 */
typedef struct tagRtProfileRecordSyncDrv {
    uint16_t type;
    uint16_t drvOpType; // rtDrvOperationType_t
    uint32_t pid;
    uint32_t tid;
    uint32_t seqId;
    uint64_t startStamp;
    uint64_t endStamp;
} rtProfileRecordSyncDrv_t;

/**
 * @ingroup
 * @brief the struct define of RT_ASYNC_RT
 */
typedef struct tagRtProfileRecordAsyncRt {
    uint16_t type;
    uint16_t rtOpType; // rtOperationProfApiType_t
    uint16_t taskId;
    uint16_t streamId;
    uint32_t pid;
    uint32_t tid;
    uint64_t startStamp;
    uint64_t endStamp;
} rtProfileRecordAsyncRt_t;

/**
 * @ingroup
 * @brief the struct define of RT_ASYNC_SEND
 */
typedef struct tagRtProfileRecordAsyncSend {
    uint16_t type;
    uint16_t reserved; // devId or TaskType
    uint32_t pid;
    uint32_t taskId;
    uint32_t streamId;
    uint64_t sendStamp;
} rtProfileRecordAsyncSend_t;

/**
 * @ingroup
 * @brief the struct define of RT_ASYNC_RECV
 */
typedef struct tagRtProfileRecordAsyncRecv {
    uint16_t type;
    uint16_t reserved; // devId or TaskType
    uint32_t pid;
    uint32_t taskId;
    uint32_t streamId;
    uint64_t recvStamp;
} rtProfileRecordAsyncRecv_t;

}
}

#endif  // __CCE_RUNTIME_PROFILER_STRUCT_HPP__
