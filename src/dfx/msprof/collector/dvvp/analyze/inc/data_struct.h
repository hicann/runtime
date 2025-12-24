/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef ANALYSIS_DVVP_ANALYZE_DATA_STRUCT_H
#define ANALYSIS_DVVP_ANALYZE_DATA_STRUCT_H

#include <cstdint>
#include <string>

namespace Analysis {
namespace Dvvp {
namespace Analyze {
// common
static const std::string KEY_SEPARATOR = "-";
constexpr uint32_t PROFILE_MODE_INVALID = 0;
constexpr uint32_t PROFILE_MODE_SINGLE_OP = 1;
constexpr uint32_t PROFILE_MODE_STEP_TRACE = 2;
constexpr uint32_t PROFILE_MODE_STATIC_SHAPE = 3;

constexpr uint32_t KNOWN_SHAPE_STREAM = 0;
constexpr uint32_t UNKNOWN_SHAPE_STREAM = 1;

struct KeypointOp {
    uint16_t streamId;
    uint16_t taskId;
    uint64_t indexId;
    uint64_t modelId;
    uint64_t startTime;
    uint64_t endTime;
    bool uploaded;           // false: send to pipe; true: not send to pipe
    uint64_t findSuccTimes;  // find op success times by this KeypointOp
};

struct OpTime {
    uint64_t indexId;
    uint64_t start;
    uint64_t startAicore;
    uint64_t endAicore;
    uint64_t end;
    uint32_t threadId;
    uint32_t flag;      // enum aclprofSubscribeOpFlag
    uint32_t streamId;  // used in aclprofSubscribe scene
};

struct StreamInfo {
    uint32_t curTaskidHigh;  // high 16 bit of task id
    uint32_t curTaskidLow;   // low 16 bit of task id
    uint32_t streamType;     // 0:known shape stream, 1:unknown shape stream
};

struct OpPMU {
    uint64_t start;
    uint64_t end;
    uint64_t totalCycle;
    uint64_t pmu[8];
};

// ge
constexpr uint32_t GE_TASK_DESC_MODEL_NAME_INDEX = 0;
constexpr uint32_t GE_TASK_DESC_OP_NAME_INDEX = 1;
constexpr uint32_t GE_TASK_DESC_BLOCK_DIM_INDEX = 2;
constexpr uint32_t GE_TASK_DESC_TASK_ID_INDEX = 3;
constexpr uint32_t GE_TASK_DESC_STREAM_ID_INDEX = 4;
constexpr uint32_t GE_TASK_DESC_MODEL_ID_INDEX = 5;
constexpr uint32_t GE_TASK_DESC_SIZE = 6;

// ts
constexpr uint8_t TS_TIMELINE_RPT_TYPE = 3;
constexpr uint8_t TS_KEYPOINT_RPT_TYPE = 10;
constexpr uint8_t TS_INVALID_TYPE = 0xff;
constexpr uint16_t TS_TIMELINE_START_TASK_STATE = 2;
constexpr uint16_t TS_TIMELINE_END_TASK_STATE = 3;
constexpr uint16_t TS_TIMELINE_AICORE_START_TASK_STATE = 7;
constexpr uint16_t TS_TIMELINE_AICORE_END_TASK_STATE = 8;
constexpr uint16_t TS_KEYPOINT_START_TASK_STATE = 0;
constexpr uint16_t TS_KEYPOINT_END_TASK_STATE = 1;

struct TsProfileDataHead {
    uint8_t mode;  // 0-host,1-device
    uint8_t rptType;
    uint16_t bufSize;
    uint8_t reserved[4];  // reserved 4 bytes
};

struct TsProfileTimeline {
    TsProfileDataHead head;
    uint16_t taskType;
    uint16_t taskState;
    uint16_t streamId;
    uint16_t taskId;
    uint64_t timestamp;
    uint32_t thread;
    uint32_t deviceId;
};

struct TsProfileKeypoint {
    TsProfileDataHead head;
    uint64_t timestamp;
    uint64_t indexId;
    uint64_t modelId;
    uint16_t streamId;
    uint16_t taskId;
    uint16_t tagId;
    uint16_t resv;
};

// hwts
constexpr uint8_t HWTS_TASK_START_TYPE = 0;
constexpr uint8_t HWTS_TASK_END_TYPE = 1;
constexpr uint8_t HWTS_INVALID_TYPE = 0xff;
constexpr uint32_t HWTS_DATA_SIZE = 64;  // 64bytes

struct HwtsProfileType01 {
    uint8_t cntRes0Type;  // bit0-2:Type, bit3:Res0, bit4-7:Cnt
    uint8_t reserved;
    uint16_t hex6bd3;      // 0x6bd3
    uint8_t reserved1[2];  // reserved 2 bytes
    uint16_t taskId;
    uint64_t syscnt;
    uint32_t streamId;
    uint8_t reserved2[44];  // reserved 44 bytes, total size: 64 bytes
};

struct HwtsProfileType2 {
    uint8_t cntRes0Type;  // bit0-2:Type, bit3:Res0, bit4-7:Cnt
    uint8_t coreId;
    uint16_t hex6bd3;  // 0x6bd3
    uint16_t blockId;
    uint16_t taskId;
    uint64_t syscnt;
    uint32_t streamId;
    uint8_t reserved[44];  // reserved 44 bytes, total size: 64 bytes
};

struct HwtsProfileType3 {
    uint8_t cntWarnType;  // bit0-2:Type, bit3:Warn, bit4-7:Cnt
    uint8_t coreId;
    uint16_t hex6bd3;  // 0x6bd3
    uint16_t blockId;
    uint16_t taskId;
    uint64_t syscnt;
    uint32_t streamId;
    uint8_t reserved[4];  // reserved 4 bytes
    uint64_t warnStatus;
    uint8_t reserved2[32];  // reserved 32 bytes, total size: 64 bytes
};

// ffts
constexpr int32_t STARS_DATA_SIZE = 64;                       // 64bytes
constexpr int32_t ACSQ_TASK_START_FUNC_TYPE = 0;             // ACSQ task start log
constexpr int32_t ACSQ_TASK_END_FUNC_TYPE = 1;               // ACSQ task end log
constexpr int32_t FFTS_SUBTASK_THREAD_START_FUNC_TYPE = 34;  // ffts thread subtask start log
constexpr int32_t FFTS_SUBTASK_THREAD_END_FUNC_TYPE = 35;    // ffts thread subtask end log
struct StarsLogHead {
    uint16_t logType : 6;
    uint16_t cnt : 4;
    uint16_t sqeType : 6;
    uint16_t hex6bd3;
};

struct StarsAcsqLog {
    StarsLogHead head;
    uint16_t streamId;
    uint16_t taskId;
    uint32_t sysCountLow;
    uint32_t sysCountHigh;
    uint32_t reserved[12];
};

struct StarsCxtLog {
    StarsLogHead head;
    uint16_t streamId;
    uint16_t taskId;
    uint32_t sysCountLow;
    uint32_t sysCountHigh;
    uint8_t cxtType;
    uint8_t res0;
    uint16_t cxtId;
    uint16_t rsv1 : 13;
    uint16_t fftsType : 3;
    uint16_t threadId;
    uint32_t rsv[10];
};

// profiling
struct ProfOpDesc {
    uint32_t signature;
    uint32_t modelId;
    uint32_t flag;
    uint32_t threadId;
    uint64_t opIndex;
    uint64_t duration;  // unit: us, schedule time + execution time;
    uint64_t start;
    uint64_t end;
    uint64_t executionTime;  // AI Core execution time;
    uint64_t cubeFops;
    uint64_t vectorFops;  // total size: 64 bytes
    uint32_t devId;
};

struct BiuPerfProfile {
    uint16_t timeData;
    uint16_t events : 12;
    uint16_t ctrlType : 4;
};

struct StarsPmuHead {
    uint16_t funcType : 6;
    uint16_t cnt : 4;
    uint16_t sqe : 6;
    uint16_t hex6bd3;
};

struct FftsSubProfile {
    StarsPmuHead head;
    uint16_t streamId;
    uint16_t taskId;
    uint64_t res2;
    uint8_t contextType; // subTaskType
    uint8_t res3;
    uint16_t contextId; // subTaskId
    uint16_t res4 : 13;
    uint16_t fftsType : 3;
    uint16_t threadId;
    uint64_t res5;
    uint64_t totalCycle;
    uint64_t ovCycle;
    uint64_t pmu[8];
    uint64_t startCnt;
    uint64_t endCnt;
};

struct FftsBlockProfile {
    StarsPmuHead head;
    uint16_t streamId;
    uint16_t taskId;
    uint64_t res2;
    uint8_t contextType;
    uint8_t res3;
    uint16_t contextId;
    uint8_t coreType : 1;
    uint8_t coreId : 7;
    uint8_t res4 : 5;
    uint8_t fftsType : 3;
    uint16_t threadId;
    uint32_t res5;
    uint16_t subBlockId;
    uint16_t blockId;
    uint64_t totalCycle;
    uint64_t ovCycle;
    uint64_t pmu[8];
    uint64_t startCnt;
    uint64_t endCnt;
};

// David
struct DavidAcsqLog {
    StarsLogHead head;
    uint16_t streamId;
    uint16_t taskId;
    uint32_t sysCountLow;
    uint32_t sysCountHigh;
    uint16_t res0;
    uint8_t accId;
    uint8_t acsqId;
    uint32_t res1[3];
};

struct DavidProfile {
    StarsPmuHead head;
    uint16_t streamId;
    uint16_t taskId;
    uint64_t totalCycle;
    uint8_t contextType;
    uint8_t mst : 1;
    uint8_t mix : 1;
    uint8_t ov : 1;
    uint8_t res1 : 5;
    uint16_t contextId;
    uint8_t coreType : 1;
    uint8_t res2 : 7;
    uint8_t coreId;
    uint16_t threadId;
    uint16_t subBlockId;
    uint16_t blockId;
    uint32_t res3;
    uint64_t pmu[10];
    uint64_t startCnt;
    uint64_t endCnt;
};

// runtime track opinfo
struct RtOpInfo {
    uint64_t tsTrackTimeStamp;
    uint64_t start;
    uint64_t end;
    uint32_t threadId;
    bool ageFlag;
    uint64_t startAicore;
    uint64_t endAicore;
    uint32_t flag;
    uint16_t contextId;
    uint32_t devId;
};

// ge op info
struct GeOpFlagInfo {
    uint64_t opNameHash;
    uint64_t opTypeHash;
    uint64_t modelId;
    uint64_t start;
    uint64_t end;
    bool modelFlag;
    bool nodeFlag;
    bool ageFlag;
    uint16_t contextId;
};

constexpr uint32_t SUMMARY_PMU_LEN = 20;
struct KernelDetail {
    uint16_t taskId;
    uint16_t streamId;
    uint16_t contextId;
    uint16_t coreType;
    uint64_t beginTime;
    uint64_t endTime;
    uint64_t aicTotalCycle;
    uint64_t aivTotalCycle;
    uint64_t pmu[SUMMARY_PMU_LEN];
    uint64_t aicCnt;
    uint64_t aivCnt;
};
}  // namespace Analyze
}  // namespace Dvvp
}  // namespace Analysis
#endif
