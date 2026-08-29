/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef DUMP_STATS_PARAM_H
#define DUMP_STATS_PARAM_H

#include <vector>
#include <cstdint>
#include <sys/types.h>
#include "hdc_log.h"
#include "securec.h"

namespace kfc_dump_stats {
constexpr uint32_t FILE_NAME_MAX = 32;
constexpr uint32_t STEP_COUNT = 10;
constexpr uint32_t SHAPE_SIZE = 25;
constexpr size_t STAT_LEN = 512;

enum KfcDumpResult {
    KFC_DUMP_SUCCESS = 0,       // Succeeded
    KFC_DUMP_E_PARA = 1,        // Invalid parameter: interface args is null, or unexpected message type received
    KFC_DUMP_E_TIMEOUT = 2,     // Timeout on waiting aiv response, free sq slot or statistics task completion
    KFC_DUMP_E_NOT_SUPPORT = 3, // Chip type is none of CHIP_DC / CHIP_CLOUD_V2 / CHIP_CLOUD_V4 / CHIP_CLOUD_V5,
                                // or an aicpu scheduler weak symbol is unresolved
    KFC_DUMP_E_AGAIN = 4,       // Retry needed, reserved and not used by current implementation
    KFC_DUMP_E_INTERNAL = 5,    // Launch before init, null sqe construct function, or reporting result failed
    KFC_DUMP_E_MEMORY = 6,      // Memory operation failed: memcpy_s / memset_s returned non-EOK
    KFC_DUMP_E_DRIVE = 7,       // Driver interface failed: halSqCqQuery / halSqCqConfig returned non-zero
    KFC_DUMP_E_RESERVED         // Upper bound of result codes, never returned
};

struct KfcDumpStreamCtx {
    uint32_t streamId;
    uint32_t sqId;
    uint32_t cqId;
    uint32_t logicCqId;
    uint32_t devId;
    uint32_t chipType;
    uint32_t sqHead;
    uint32_t sqDepth;
    uint32_t sqTail;
    void* sqBaseAddr;
};
struct KfcDumpContext {
    uint64_t msgQ;
    uint64_t workspace;
    uint64_t workspaceSizeAddr;
    uint64_t aiCoreNumAddr;
    uint64_t ubSizeAddr;
    uint64_t syncSpace;
    uint64_t workspaceSize;
    uint64_t aiCoreNum;
    uint64_t ubSize;
};

struct KfcDumpStreamInfo {
    uint32_t streamIds;
    uint32_t sqIds;
    uint32_t cqIds;
    uint32_t logicCqIds;
    uint32_t deviceId;
    uint32_t res;
};
struct KfcDumpWorkSpace {
    uint64_t msgQ;
    uint64_t msgQSize;
    uint64_t output;
    uint64_t outputSize;
    uint64_t workspace;
    uint64_t workspaceSize;
    uint64_t stackPhyBase32k;
    uint64_t stackPhyBase32kSize;
};

struct KfcDumpOpConfig {
    uint64_t aiCoreNum;
    uint64_t vectorCoreNum;
    uint64_t ubSize;
    uint64_t dumpStatPcAddr;
    uint64_t statsType;
    uint64_t chipType;
};

struct KfcDumpOpInitParam {
    KfcDumpWorkSpace kfcWorkSpace;
    KfcDumpOpConfig config;
    KfcDumpStreamInfo streamInfo;
    char soName[FILE_NAME_MAX];
    char kernelName[FILE_NAME_MAX];
};

enum ChipType {
    CHIP_DC = 4,        // Uses AddOneStatDumpTaskV2 / PrintSqeV2
    CHIP_CLOUD_V2 = 5,  // Uses AddOneStatDumpTaskV1 / PrintSqeV1
    CHIP_CLOUD_V4 = 15, // Uses AddStatDumpTaskCloudV4 / PrintSqeCloudV4
    CHIP_CLOUD_V5 = 16, // Uses AddStatDumpTaskCloudV5 / PrintSqeCloudV5
};

enum TensorType {
    TENSOR_TYPE_INPUT = 0,  // Tensor comes from KfcDumpInfo::inputDumpInfo
    TENSOR_TYPE_OUTPUT = 1, // Tensor comes from KfcDumpInfo::outputDumpInfo
};

enum DumpStatMsgType {
    KFC_DUMP_MSG_DEFAULT = 0,  // Idle slot, set by the peer after a message is consumed
    KFC_DUMP_MSG_REQUEST = 1,  // Server -> aiv: compute statistics of one tensor
    KFC_DUMP_MSG_RESPONSE = 2, // Aiv -> server: statistics of one tensor are ready
    KFC_DUMP_MSG_FINISHED = 3, // Server -> aiv: all tensors are done, aiv may exit
    KFC_DUMP_MSG_RESERVED,     // Upper bound of message types, never sent
};

struct TensorStatsResult {
    int64_t size;
    uint32_t dType;
    uint32_t format;
    int32_t shapeSize;
    uint32_t shape[SHAPE_SIZE];
    uint32_t result; // 0: Success; OtherValues: Failure
    int32_t statsLen;
    int8_t stats[STAT_LEN];
    int32_t io;
    int32_t index;
};

struct OpStatsResult {
    int32_t tensorNum;
    int32_t res;
    int64_t statItem;
    TensorStatsResult stat[STEP_COUNT];
};

} // namespace kfc_dump_stats

#define DUMP_STATS_CHK_RET(call)                                    \
    do {                                                            \
        kfc_dump_stats::KfcDumpResult kfcRet = (call);              \
        if (kfcRet != kfc_dump_stats::KFC_DUMP_SUCCESS) {           \
            if (kfcRet == kfc_dump_stats::KFC_DUMP_E_AGAIN) {       \
                IDE_LOGW("Kfc dump call trace, result=%d", kfcRet); \
            } else {                                                \
                IDE_LOGE("Kfc dump call trace, result=%d", kfcRet); \
            }                                                       \
            return kfcRet;                                          \
        }                                                           \
    } while (0)

#endif // DUMP_STATS_PARAM_H
