/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef CCE_RUNTIME_DAVID_PLACE_HOLDER_SQE_H
#define CCE_RUNTIME_DAVID_PLACE_HOLDER_SQE_H

#include "base.h"
#include "task_info_base.hpp"
#include "driver/ascend_hal_define.h"

namespace cce {
namespace runtime {
#pragma pack(push)
#pragma pack (1)

struct DavidStarsMaintaince {
    uint8_t  subType; // force recyle
    uint8_t  rsv;
    uint16_t targetId;
    uint8_t  reserved[44];
};

struct DavidDataDumpLoadInfo {
    uint64_t dumpinfoPtr;
    uint32_t length;
    uint16_t streamId;
    uint16_t taskId;
    uint16_t kernelType;
    uint16_t reserved;
};

struct DavidDynamicProf {
    uint64_t pid;
    uint8_t eventMuxConfig[8];
    uint64_t startCycle;
    uint64_t stopCycle;
    uint8_t userDefinedEnable;
    uint8_t isTimelineProfEn;
    uint8_t isTaskBasedProfEn;
    uint8_t isProfLogEn;
    uint8_t isSocLogEn;
    uint8_t reserved[11]; // reserved 11 bytes
};

struct DavidProfilerTraceEx {
    uint64_t profilerTraceId;
    uint64_t modelId;
    uint16_t tagId;
    uint8_t reserved[30];
};

struct DavidModelDebugRegister {
    uint64_t addr;
    uint32_t modelId;
    uint32_t flag;
    uint32_t reserved[8];
};

struct DavidStreamDebugRegister {
    uint64_t addr;
    uint32_t streamId;
    uint32_t flag;
    uint32_t reserved[8];
};

struct DavidStarsModelMaintaince {
    uint16_t modelId;
    uint16_t streamId;
    uint16_t operation;
    uint16_t streamType;
    uint16_t firstTaskId;
    uint16_t endgraphNotifyId;
    uint32_t executorFlag;
    uint64_t streamExecTimesAddr;
    uint32_t reserved[6];
};

struct DavidRingBufferControl {
    uint64_t ringbufferOffset;
    uint64_t ringbufferPhyAddr;
    uint64_t pid;
    uint32_t totalLen;
    uint8_t  ringbufferDelFlag; // 0:create 1:delete
    uint8_t  reserved[19];
};

struct DavidMemCpyAsyncWithoutSdma {
    uint64_t src;
    uint64_t dest;
    uint32_t size;
    uint32_t pid;
    uint8_t reserved[24];
};

struct DavidStreamOverflowSwitch {
    uint16_t streamId;
    uint16_t isSwitchOn : 1;
    uint16_t rsv : 15;
    uint32_t reserved[11];
};

struct DavidGetDevMsg {
    uint64_t devAddr;
    uint64_t offset;
    uint32_t len;
    uint16_t type;
    uint8_t reserved[26];
};

struct DavidStreamSetTag {
    uint16_t streamId;
    uint16_t rsv;
    uint32_t geOpTag;
    uint32_t reserved[10];
};

struct DavidDebugStatus {
    uint8_t debugFlag;
    uint8_t reserved[3];
};

struct DavidFlipTaskTag {
    uint16_t flipNumReport;
    uint8_t reserved[46];
};

struct DavidAicpuInfoLoad {
    uint64_t aicpufoPtr;
    uint32_t length;
    uint16_t streamId;
    uint16_t taskId;
    uint16_t reserved[2];
};

struct DavidMdlTaskUpdate {
    uint64_t tilingKeyOffset;
    uint64_t blockDimOffset;
    uint64_t tilingTabOffset;
    uint16_t tilingTabLen;
    uint16_t desStreamId;
    uint32_t destaskId;
    uint16_t exeStreamId;
    uint16_t resv;
};

struct DavidCallBackTask {
    /* word4-5 */
    uint16_t cbCqId;
    uint16_t cbGroupId;
    uint16_t devId;
    uint16_t streamId;

    /* word6-7 */
    uint32_t notifyId;
    uint16_t taskId;
    uint8_t isBlock : 1;
    uint8_t isOnline : 1;
    uint8_t res0 : 6;
    uint8_t res1;

    /* word8-11 */
    uint32_t hostfuncAddrLow;
    uint32_t hostfuncAddrHigh;
    uint32_t fndataLow;
    uint32_t fndataHigh;

    /* word12-13 */
    uint32_t res2;               // noly vf & topic AICPU & callback msg use for hostpid.
    uint32_t res3;

    /* word14 */
    uint32_t subTopicId : 12;
    uint32_t topicId : 6;
    uint32_t groupId : 6;
    uint32_t usrDataLen : 8;

    /* word15 */
    uint32_t destPid;
};

struct RtDavidPlaceHolderSqe {
    rtDavidStarsSqeHeader_t header;
    /* word2-3 */
    uint32_t res1;
    uint16_t taskType;
    uint8_t kernelCredit;
    uint8_t timeoutType;  // use for timeout cqe in david

    /* use reserved field */
    /* The struct in the union must be 48 bytes */
    union {
        DavidStarsMaintaince maintainceInfo;
        DavidDataDumpLoadInfo dataDumpLoadInfo;
        DavidDynamicProf dynamicProfilingInfo;
        DavidProfilerTraceEx profileTraceInfo;
        DavidModelDebugRegister modelDebugRegisterInfo;
        DavidStreamDebugRegister streamDebugRegisterInfo;
        DavidStarsModelMaintaince modelMaintainceInfo;
        DavidRingBufferControl ringBufferControlInfo;
        DavidMemCpyAsyncWithoutSdma memcpyAsyncWithoutSdmaInfo;
        DavidStreamOverflowSwitch streamOverflowSwitchInfo;
        DavidGetDevMsg getDevMsgInfo;
        DavidStreamSetTag streamSetTagInfo;
        DavidDebugStatus  debugStatusInfo;
        DavidFlipTaskTag flipTaskInfo;
        DavidMdlTaskUpdate mdlTaskUpdateInfo;
        DavidAicpuInfoLoad aiCpuLoadInfo;
        DavidCallBackTask callBackInfo;
        uint32_t resv[12];
    } u;
};

#pragma pack(pop)
}
}
#endif
