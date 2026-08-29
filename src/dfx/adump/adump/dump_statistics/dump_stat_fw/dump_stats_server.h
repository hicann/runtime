/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef DUMP_STATS_SERVER_H
#define DUMP_STATS_SERVER_H

#include <string>
#include <cstdint>
#include <unistd.h>
#include <sys/syscall.h>
#include "dump_stats_param.h"

namespace kfc_dump_stats {
constexpr uint64_t NSEC_PER_USEC = 1000U;
constexpr uint64_t NSEC_PER_SEC = 1000000000U;
constexpr uint64_t DEFAULT_KFC_DUMP_WAIT_TIMEOUT = 30 * NSEC_PER_SEC;
constexpr uint32_t DUMP_MSG_CNT = 16U;
constexpr uint32_t MSG_BODY_SIZE = 2048;
constexpr uint32_t MSGQ_SIZE = 1024 * 1024;
constexpr uint32_t SYNC_SPACE_BYTES_PER_CORE = 32U;
constexpr uint32_t DUMP_MSG_VALID_MASK = 0x5CDF123A;

inline uint64_t GetCurCpuTimestamp()
{
    struct timespec timestamp;
    (void)clock_gettime(CLOCK_MONOTONIC_RAW, &timestamp);
    return static_cast<uint64_t>((timestamp.tv_sec * NSEC_PER_SEC) + (timestamp.tv_nsec));
}

extern uint64_t g_kfcDumpWaitTimeout;

inline KfcDumpResult CheckTimeOut(uint64_t startTime)
{
    if (GetCurCpuTimestamp() - startTime > g_kfcDumpWaitTimeout) {
        return KFC_DUMP_E_TIMEOUT;
    }
    return KFC_DUMP_SUCCESS;
}

// 64B对齐(AIV单cache line可回刷完成)
struct KfcDumpStatsMsg {
    DumpStatMsgType msgType;
    uint32_t dataType;
    uint64_t dataCount;
    uint64_t dataAddr;
    uint64_t dumpStatClass;
    uint64_t outputAddr;
    uint64_t outputAddrSize;
    uint32_t valid;
    uint32_t result;
    uint32_t reserved[2];
};

struct KfcDumpMsgBody {
    KfcDumpStatsMsg msgRcvArea[DUMP_MSG_CNT];
    KfcDumpStatsMsg msgSndArea[DUMP_MSG_CNT];
};

class KfcDumpStatsServer {
public:
    KfcDumpStatsServer() = default;

    ~KfcDumpStatsServer() = default;

    void Init(uint64_t workSpaceAddr);

    KfcDumpResult RcvMsg(KfcDumpStatsMsg* rMsg);

    KfcDumpResult PostMsg(KfcDumpStatsMsg* rMsg);

    KfcDumpResult CheckDumpResult(KfcDumpStatsMsg* rMsg);

    bool ReadValidMsg(KfcDumpStatsMsg* rMsg, KfcDumpStatsMsg* msg);

private:
    KfcDumpMsgBody* msgBody_ = nullptr;
    uint32_t rcvMsgPos_ = 0;
    uint32_t sndMsgPos_ = 0;
};
} // namespace kfc_dump_stats

#endif // DUMP_STATS_SERVER_H
