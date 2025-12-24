/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef __CCE_RUNTIME_HWTS_HPP__
#define __CCE_RUNTIME_HWTS_HPP__

#include "task_info.hpp"

namespace cce {
namespace runtime {

/**
 * @ingroup
 * @brief the struct define of kernel type task
 */
struct TsKernelTask {
    uint64_t funcPtr;
    uint64_t funcDesc;
    uint64_t L2PreloadCtrl;
    uint64_t literalSrcAddr;
    uint32_t literalDstBase;
    uint32_t literalSize;
    uint16_t blockDim;
    uint8_t L2_size;
    uint8_t schemMode;
    uint32_t priority : 3;
    uint32_t l2PreloadVirAddr : 26; // preserve the offset of l2_preload_ctrl's phy addr, not greater than 50M now
    uint32_t isConvertAddr : 3; // 1:TS_KERNEL_CONVERT, 2:TS_KERNEL_DUMPFLAG, 4:FUSION_KERNEL_DUMPFLAG
};

/**
 * @ingroup
 * @brief the struct define of event record type task
 */
struct TsEventRecordTask {
    uint16_t eventID;       // offset 8, MAX means not set.
    uint8_t reserved0[6];
    uint64_t timelineBase;  // valid when flag bit 0 set, otherwise set to MAX.
    uint32_t offset;        // offset of timeline
    uint32_t threadId;
    uint32_t virAddr;
    uint8_t flag;           // bit0: timeline / bit1: H2D Sync / bit2: Stream Sync
    uint8_t waitCqflag;
    uint16_t waitCqId;
    uint8_t reserved[16];   // reserved 16 bytes
};

/**
 * @ingroup
 * @brief the struct define of remote event wait type task
 */
struct TsRemoteEventWaitTask {
    uint64_t srcMailboxPa;  /* offset 0 */
    uint64_t srcDoorbellPa; /* offset 8 */
    uint64_t dstDoorbellPa; /* offset 16 */
    uint16_t srcEventId;    /* offset 24 */
    uint16_t srcDeviceId;   /* offset 26 */
    uint16_t dstDeviceId;   /* offset 28 */
    uint8_t channelType;    /* offset 30 */
    uint8_t reserved[17];   /* offset 31, reserved 17 bytes */
};

/**
 * @ingroup
 * @brief the struct define of stream wait event type task
 */
struct TsStreamWaitEventTask {
    uint16_t eventID;       /* offset 8 */
    uint16_t nextStreamIdx; /* offset 10 */
    uint16_t isNotify;      /* event to notify */
    uint16_t retCode;       /* using ts_error_t, only use by ts */
    uint16_t faultTaskId;   /* using report error of operator, only use by ts */
    uint16_t faultStreamId; /* using report error of operator, only use by ts */
    uint32_t timeout;       /* offset 20, used for 51 pg1 */
    uint8_t reserved[32];   /* offset 24, reserved 32 bytes */
};

/**
 * @ingroup
 * @brief the struct define of fusion type task
 */
typedef struct tagTsFusionTask {
    uint16_t flag; /* offset 8 */
    uint8_t reserved[46]; // reserved 46 bytes
} TsFusionTask;

struct TsMemcpyTask {
    uint64_t srcBaseAddr;
    uint64_t dstBaseAddr;
    uint64_t length;
    uint16_t memcpyType;
    uint8_t dir;
    uint8_t isAddrConvert;
    uint8_t copyDataType;
    uint8_t d2dOffsetFlag : 1;
    uint8_t reserved1 : 7;
    uint8_t reserved2[2]; // reserved 3 bytes
    union {
        struct DMA_OFFSET_ADDR dmaOffsetAddr; // call MemConvertAddr
        struct NO_DMA_OFFSET_ADDR noDmaOffsetAddr; // call MemAddressTranslate
        struct D2D_ADDR_OFFSET d2dAddrOffset;       // for d2d addr memcpy with offset
    };
};

/**
 * @ingroup
 * @brief the struct define of maintenance type task
 */
struct TsMaintenanceTask {
    uint16_t goal;     /* offset 8 , 0:stream,   1:event; */
    uint16_t targetID; /* offset 10 */
    uint8_t terminal;  /** 0: Normal, 1: Primary stream Distroy */
    uint8_t reserved0;
    uint16_t waitCqId;
    uint32_t threadId;
    uint8_t flag; /* when goal is recycle task take effect */
    uint8_t reserved[35]; // reserved 36 bytes
};

struct TsCreateStream {
    uint64_t pid;
    uint64_t l2BaseVaddr; /* * for kernel */
    uint64_t asid_baddr;
    uint16_t vfId;
    uint16_t vStreamId;
    uint16_t runtimeVersion;
    uint16_t shareLogicCqId;
    uint32_t threadId;
    uint16_t asid;
    uint16_t SMMU_subStreamID;
    uint16_t SQ_id;
    uint8_t priority;
    uint8_t streamAttr;
    uint8_t group_id;
    uint8_t deviceId;
    uint8_t supportLogToHost;
    uint8_t reserved;
};

struct TsCreateL2Addr {
    uint64_t l2BaseVaddrForsdma; /* * for sysDMA get dst VA */
    uint64_t ptePA;
    uint64_t pid; /* *profiling for process CreateStream and L2 mistiming */
    uint32_t virAddr;
    uint8_t reserved[20]; // reserved 20 bytes
};

/**
 * @ingroup
 * @brief the struct define of task-based profiling enable type task
 */
struct TsTkProfEnTask {
    uint64_t pid;
    uint8_t eventMuxConfig[8];
    uint64_t startCycle;
    uint64_t stopCycle;
    uint8_t userDefinedEnable;
    uint8_t isTimelineProfEn;
    uint8_t isTaskBasedProfEn;
    uint8_t isProfLogEn;
    uint8_t isHwtsLogEn;
    uint8_t reserved[11]; // reserved 11 bytes
};

/**
 * @ingroup
 * @brief the struct define of task-based profiling disable type task
 */
struct TsTkProfDisTask {
    uint64_t pid;
    uint8_t isTimelineProfDis;
    uint8_t isTaskBasedProfDis;
    uint8_t isProfLogDis;
    uint8_t isHwtsLogDis;
    uint8_t reserved[36]; // reserved 36 bytes
};

/**
 * @ingroup
 * @brief the struct define of pc trace task
 */
typedef struct TagRtPcTraceTask {
    uint64_t contentAddr;
    uint16_t enableTaskID;
    uint16_t coreDim;
    uint32_t virAddr;
    uint8_t reserved[32]; // reserved 32 bytes
} RtPcTraceTask;

/**
 * @ingroup
 * @brief the struct define of model maintaince task
 */
typedef struct TagRtModelMaintaince {
    uint16_t modelId;
    uint16_t stream_id;
    uint16_t operation;
    uint16_t stream_type;
    uint16_t first_task_id;
    uint8_t reserved[38]; // reserved 38 bytes
} RtModelMaintaince;

/**
 * @ingroup
 * @brief the struct define of model execute task
 */
struct RtModelExecute {
    uint16_t model_id;
    uint16_t first_task_id;
    int16_t sch_group_id;
    uint8_t reserved0[2];  // 64 bits align, reserved 2 bytes
    /* send sink stream SMMU config to TS by model execute */
    uint64_t asid_baddr;
    uint64_t tcr;
    uint16_t asid;
    uint16_t SMMU_subStreamID;
    uint8_t reserved[20]; // reserved 20 bytes
};

struct TsRdmaSendTask {
    uint32_t sqIndex;
    uint32_t wqeIndex;
    uint8_t reserved[40]; // reserved 40 bytes
};

struct TsRdmaDbSendTask {
    uint64_t dbInfo;
    uint32_t dbIndex;
    uint8_t reserved[36]; // reserved 36 bytes
};

/**
 * @brief the struct define of notify wait type task
 */
struct TsNotifyWaitTask {
    uint16_t notifyid;
    uint16_t reservedfield;
    uint32_t timeout;
    uint8_t reserved[40]; // reserved 40 bytes
};


struct TsNotifyRecordTask {
    uint16_t deviceId;
    uint16_t notifyId;
    uint8_t reserved[44]; // reserved 44 bytes
};

/**
 * @brief the struct define of switch type task
 */
struct TsStreamSwitchTask {
    int64_t value;
    uint64_t pptr;
    uint64_t pValuePtr;
    uint32_t condition;
    uint16_t trueStreamId;
    uint8_t isCondEx;
    uint8_t dataType;
    uint32_t pptrVirAddr;
    uint32_t pValuePtrVirAddr;
    uint8_t reserved[8];
};

/**
 * @brief the struct define of Active type task
 */
struct TsStreamActiveTask {
    uint16_t activeStreamId;
    uint8_t reserved[46]; // reserved 46 bytes
};

/**
 * @ingroup
 * @brief the struct define of label set type task
 */
struct TsLabelSetTask {
    uint16_t labelId;
    uint16_t reserved[3];
    uint64_t labelPtr;
    uint8_t reserved1[32]; // reserved 32 bytes
};

/**
 * @ingroup
 * @brief the struct define of label switch type task
 */
struct TsLabelSwitchTask {
    uint64_t pptr;
    uint32_t condition;
    uint32_t value;
    uint16_t true_label_id;
    uint8_t reserved[26]; // reserved 26 bytes
    uint32_t virAddr;
};

/**
 * @ingroup
 * @brief the struct define of label goto type task
 */
struct TsLabelGotoTask {
    uint16_t labelId;
    uint8_t reserved[46]; // reserved 46 bytes
};

/**
 * @ingroup
 * @brief the struct define of profiler trace task
 */
struct TsProfilerTraceTask {
    uint64_t profilerTraceId;
    uint8_t notify;
    uint8_t reserved[39]; // reserved 39 bytes
} ;

/**
 * @ingroup
 * @brief the struct define of profiler trace task
 */
struct TsProfilerTraceExTask {
    uint64_t profilerTraceId;
    uint64_t modelId;
    uint16_t tagId;
    uint8_t reserved[30]; // reserved 30 bytes
};

/**
* @ingroup
* @brief the struct define of event reset type task
*/
struct TsEventResetTask {
    uint16_t eventID;       /* offset 8 */
    uint16_t isNotify;      /* event to notify */
    uint8_t reserved[44];   // reserved 44 bytes
};

/**
* @ingroup
* @brief the struct define of model end graph task
*/
struct TsModelEndGraphTask {
    uint64_t endGraphNamePtr;
    uint64_t argptr;
    uint32_t modelId;
    uint32_t executorFlag;
    uint8_t  priority;
    uint8_t flag;
    uint8_t  reserved[22]; // reserved 22 bytes
};

/**
* @ingroup
* @brief the struct define of model end graph task
*/
struct TsModelExitTask {
    uint32_t modelId;
    uint32_t streamId;
    uint8_t  reserved[40]; // reserved 40 bytes
};

/**
* @ingroup
* @brief the struct define of model info to aicpu task
*/
struct TsModelToAicpuTask {
    uint64_t modelArgPtr;
    uint32_t modelId;
    uint32_t cmdType;
    uint32_t executorFlag;
    uint8_t  reserved[28]; // reserved 28 bytes
};

/**
* @ingroup
* @brief the struct define of data dump load info task
*/
typedef struct tagDataDumpLoadInfoTask {
    uint64_t dumpInfoPtr;
    uint32_t length;
    uint8_t  reserved[36]; // reserved 36 bytes
} TsDataDumpLoadInfoTask;

/**
* @ingroup
* @brief the struct define of data dump load info task
*/
struct TsAicpuInfoLoadTask {
    uint64_t aicpuInfoPtr;
    uint32_t length;
    uint8_t  reserved[36]; // reserved 36 bytes
};

/**
 * @brief the struct define of case switch type task
 */
struct TsStreamSwitchNTask {
    uint64_t pptr;
    uint64_t pValuePtr;
    uint64_t pTrueStreamIdPtr;
    uint32_t size;
    uint32_t elementSize;
    uint32_t pptrVirAddr;
    uint32_t pValuePtrVirAddr;
    uint32_t pTrueVirAddr;
    uint8_t dataType;
    uint8_t isTransAddr;
    uint8_t reserved[2];
};

/**
 * @ingroup
 * @brief the struct define of callback launch task
 */
struct TsHostFuncCBTask {
    uint64_t hostFuncCBPtr;
    uint64_t fnDataPtr;
    uint32_t cbRptCqid;
    uint8_t isBlock;
    uint8_t reserved[27];
};

/**
 * @ingroup
 * @brief the struct define of task-based online profiling start type task
 */
struct TsOnlineProfStartTask {
    uint64_t onlineProfAddr;
    uint32_t virAddr;
    uint8_t reserved[36]; // reserved 36 bytes
};

/**
 * @ingroup
 * @brief the struct define of task-based online profiling stop type task
 */
struct TsOnlineProfStopTask {
    uint64_t onlineProfAddr;
    uint8_t reserved[40]; // reserved 40 bytes
};

/**
 * @ingroup
 * @brief the struct define of stream label switch by index
 */
struct TsStreamLabelSwitchByIndexTask {
    uint64_t indexPtr;
    uint64_t labelInfoPtr;
    uint32_t max;
    uint8_t reserved[20];
    uint32_t indexPtrVirAddr;
    uint32_t labelInfoPtrVirAddr;
};

/**
 * @ingroup
 * @brief the struct define of stream label goto
 */
struct TsStreamLabelGotoTask {
    uint16_t labelId;
    uint16_t modelId;
    uint8_t reserved[44];
};

/**
* @ingroup
* @brief the struct define of debug register task
*/
struct TsDebugRegisterTask {
    uint64_t addr;
    uint32_t modelId;
    uint32_t flag;
    uint8_t  reserved[32]; // reserved 32 bytes
};

/**
* @ingroup
* @brief the struct define of debug unregister task
*/
struct TsDebugUnRegisterTask {
    uint32_t modelId;
    uint8_t  reserved[44]; // reserved 44 bytes
};

/**
* @ingroup
* @brief the struct define of fusion dump addr set task
*/
struct TsFusionDumpAddrSetTask {
    uint64_t dumpAddrPtr;
    uint32_t dumpSize;
    uint16_t model_id;
    uint8_t flag;
    uint8_t reserved[33];
};

/**
 * @ingroup
 * @brief the struct define of task-based adc profiling type task
 */
struct TsProfTask {
    uint64_t profAddr;
    uint32_t length;
    uint8_t reserved[36]; // reserved 36 bytes
};

/**
 * @ingroup
 * @brief the struct define of processing ringbuffer in device
 */
struct TsRingBufferPassToDeviceTask {
    uint64_t ringBufferOffset;
    uint64_t ringBufferPhyAddr;
    uint64_t pid;
    uint32_t totalLen;
    uint8_t  ringBufferDelFlag; // 0:create 1:delete
    uint8_t  reserved[19];
};

/**
* @ingroup
* @brief the struct define of debug register task for stream
*/
typedef struct tagDebugRegisterForStreamTask {
    uint64_t addr;
    uint32_t streamId;
    uint32_t flag;
    uint8_t  reserved[32]; // reserved 32 bytes
} TsDebugRegisterForStreamTask;

/**
* @ingroup
* @brief the struct define of debug unregister task for stream
*/
struct TsDebugUnRegisterForStreamTask {
    uint32_t streamId;
    uint8_t  reserved[44]; // reserved 44 bytes
};

/**
 * @ingroup
 * @brief set task timeout time
 */
struct TsTimeoutSetTask {
    uint32_t opWaitTimeoutEn : 1;
    uint32_t opExecuteTimeoutEn : 1;
    uint32_t rsv : 30;
    uint32_t opWaitTimeout;
    uint32_t opExecuteTimeout;
    uint8_t reserved[36];
};

/**
 * @ingroup
 * @brief get device message
 */
struct TsGetDevMsgTask {
    uint64_t devAddr;
    uint64_t offset;
    uint32_t len;
    uint16_t type;
    uint8_t reserved[26];
};

typedef struct tagTsReduceV2Task {
    uint64_t srcBaseAddr;
    uint64_t dstBaseAddr;
    uint64_t overflowAddr;
    uint32_t length;
    uint16_t memcpyType;
    uint8_t dir;
    uint8_t isAddrConvert;
    uint32_t virOverflowAddr;
    uint8_t copyDataType;
    uint8_t reserved[11];
} TsReduceAsyncV2Task;

/**
 * @ingroup
 * @brief set stream mode
 */
struct TsSetStreamModeTask {
    uint64_t mode;
    uint8_t reserved[40]; // reserved 40 bytes
};

/**
 * @ingroup
 * @brief the struct define of flip task
 */
struct TsFlipTask {
    uint16_t flipNumReport;
    uint8_t reserved[46]; // reserved 46 bytes
};

/**
 * @ingroup
 * @brief the struct define of model update task
 */
struct TsModelUpdateTask {
    uint64_t descBufOffset;
    uint64_t tilingKeyOffset;
    uint64_t blockDimOffset;
    uint64_t tilingTabOffset;
    uint16_t tilingTabLen;
    uint16_t desStreamId;
    uint16_t destaskId;
    uint16_t exeStreamId;
    uint8_t  reserved[8];
};
/**
 * @ingroup
 * @brief the struct define of task
 */
typedef struct tagTsCommand {
    uint16_t streamID;      /* offset 0 */
    uint16_t taskID;        /* offset 2 */
    uint16_t nextTaskIdx;   /* offset 4 */
    uint16_t type;          /* offset 6 */
    uint16_t nextStreamIdx; /* offset 8 */
    uint16_t taskState;     /* 10 */
    uint8_t taskProfEn : 7;     /* offset 12 */
    uint8_t isctrl : 1;
    uint8_t taskInfoFlag;   /* bit 0: is need send cq, bit 2: endgraph dump, bit 3: sink flag */
    uint8_t reserved[2];
    union {
        TsKernelTask kernelTask;
        TsEventRecordTask eventRecordTask;
        TsRemoteEventWaitTask remoteEventWaitTask;
        TsStreamWaitEventTask streamWaitEventTask;
        TsFusionTask fusion;
        TsMemcpyTask memcpyTask;
        TsMaintenanceTask maintenanceTask;
        TsCreateStream creatStream;
        TsCreateL2Addr createL2Addr;
        TsTkProfEnTask profilingEnable;
        TsTkProfDisTask profilingDisable;
        RtPcTraceTask pctraceTask;
        RtModelMaintaince modelMaintainceTack;
        RtModelExecute modelExecuteTask;
        TsRdmaSendTask rdmaSendTask;
        TsRdmaDbSendTask rdmaDbSendTask;
        TsNotifyWaitTask notifywaitTask;
        TsNotifyRecordTask notifyrecordTask;
        TsStreamSwitchTask streamswitchTask;
        TsStreamActiveTask streamactiveTask;
        TsLabelSetTask labelSetTask;
        TsLabelSwitchTask labelSwitchTask;
        TsLabelGotoTask labelGotoTask;
        TsProfilerTraceTask profilertraceTask;
        TsProfilerTraceExTask profilerTraceExTask;
        TsModelEndGraphTask   modelEndGraphTask;
        TsEventResetTask eventResetTask;
        TsModelExitTask   modelExitTask;
        TsModelToAicpuTask    modelToAicpuTask;
        TsKernelTask activeAicpuStreamTask;
        TsDataDumpLoadInfoTask dataDumpLoadInfoTask;
        TsStreamSwitchNTask streamSwitchNTask;
        TsHostFuncCBTask hostFuncCBTask;
        TsOnlineProfStartTask onlineProfStartTask;
        TsOnlineProfStopTask  onlineProfStopTask;
        TsStreamLabelSwitchByIndexTask streamLabelSwitchIndexTask;
        TsStreamLabelGotoTask streamLabelGotoTask;
        TsDebugRegisterTask debugRegisterTask;
        TsDebugUnRegisterTask debugUnRegisterTask;
        TsFusionDumpAddrSetTask fusionDumpAddrSetTask;
        TsProfTask profTask;
        TsRingBufferPassToDeviceTask ringBufferToDeviceTask;
        TsDebugRegisterForStreamTask debugRegisterForStreamTask;
        TsDebugUnRegisterForStreamTask debugUnRegisterForStreamTask;
        TsTimeoutSetTask timeoutSetTask;
        TsGetDevMsgTask getDevMsgTask;
        TsReduceAsyncV2Task reduceAsyncV2Task;
        TsSetStreamModeTask setStreamModeTask;
        TsFlipTask flipTask;
        TsModelUpdateTask modelUpdateTask;
        TsAicpuInfoLoadTask aicpuInfoLoadTask;
    } u;
} rtCommand_t;

void ToCommand(TaskInfo *taskInfo, rtCommand_t *const command);

}  // namespace runtime
}  // namespace cce
#endif  // __CCE_RUNTIME_HWTS_HPP__