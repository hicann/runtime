/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef DATA_STRUCT_STUB_H
#define DATA_STRUCT_STUB_H
      
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
#endif