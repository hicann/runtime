/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef SYS_MONITOR_COMMON_H
#define SYS_MONITOR_COMMON_H

#include <stdint.h>
#include <stdbool.h>

#ifdef __cplusplus
extern "C" {
#endif

#if defined __IDE_UT
#define STATIC
#else
#define STATIC static
#endif

#define MONITOR_MESSAGE_MAX_SIZE     1024U
#define MONITOR_ONE_HUNDRED_FLOAT    100.0f
#define MONITOR_SILENCE_DISABLE      -1
#define MONITOR_BASE_NUM             10      // decimal

typedef struct SysmonitorInfo {
    float alarmValue;
    float resumeValue;
    uint32_t monitorCount;           // 执行次数
    uint32_t monitorPeriod;          // monitorCount * 最大公约数 >= monitorPeriod时:执行一次monitorFunc监控,monitorCount清零
    uint32_t alarmCount;             // 统计周期内告警次数
    uint32_t alarmMaxCount;          // 统计周期内最大告警次数
    uint32_t statCount;              // 统计次数
    uint32_t statPeriod;             // 统计时长 达到统计时长时:打印统计数据,statCount清零
    int32_t silenceCount;            // 静默次数 -1:静默未打开; >=0:静默期
    uint32_t silencePeriod;          // 静默时长 silenceCount * monitorPeriod == silencePeriod时:恢复输出,silenceCount置为-1
    bool thresholdFlag;              // 上冲到alarm时设为true,下行到resume时设为false
    void (*monitorFunc)(void);
} SysmonitorInfo;

enum SysmonitorItem {
    SYS_MONITOR_CPU = 0,
    SYS_MONITOR_MEM,
    SYS_MONITOR_FD,
    SYS_MONITOR_ZP,
    SYS_MONITOR_COUNT
};

typedef struct MonitorStatInfo {
    float minUsage;
    float maxUsage;
    float avgUsage;
    uint32_t alarmNum;    // 一个统计周期内的上行超过上限阈值的告警次数
    uint32_t resumeNum;   // 一个统计周期内的下行超过下限阈值的恢复次数
    uint32_t duration;    // 告警到恢复之间的时长总和
} MonitorStatInfo;

#ifdef __cplusplus
}
#endif
#endif