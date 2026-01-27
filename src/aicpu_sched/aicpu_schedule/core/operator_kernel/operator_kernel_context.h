/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef OPERATOR_KERNEL_CONTEXT_H
#define OPERATOR_KERNEL_CONTEXT_H

#include <sstream>
#include "type_def.h"
#include "aicpusd_common.h"


namespace AicpuSchedule {
constexpr size_t MBUF_HEAD_MAX_SIZE = 256U;
constexpr uint32_t MBUF_HEAD_END_OF_SEQUENCE_POS = 128U;
constexpr uint8_t END_OF_SEQUENCE_FLAG = 0x5AU;
constexpr size_t DEQUEUED_SIZE = 8U;
constexpr uint32_t MAX_SIZE_NUM = 128U;
constexpr int64_t FORMAT_ND = 2;
constexpr int64_t DT_INT64 = 9;
constexpr int64_t DT_INT32 = 3;
constexpr int64_t DT_FLOAT = 0;
constexpr size_t DIM_NUM_INDEX = 0U;
constexpr size_t DIM0_INDEX = 1U;
constexpr size_t DIM1_INDEX = 2U;
constexpr int64_t DIM_NUM_ONE = 1;
constexpr int64_t DIM_NUM_TWO = 2;
constexpr uint8_t MBUF_HEAD_DATA_FLAG_MASK = 0x01U;

enum class DataFlag {
    DFLOW_HAS_DATA_FLAG = 0,
    DFLOW_NULL_DATA_FLAG = 1
};

struct MbufHeadMsg {
    uint64_t transId;
    uint16_t version;
    uint16_t msgType;
    int32_t retCode;
    uint64_t startTime;
    uint64_t endTime;
    uint32_t flags; // EOS, SEG contrl flag ect.
    uint8_t dataFlag; // 0 bit is data flag. 1 is null data, 0 is has data.
    char rsv0[3];
    int32_t workerId;
    uint32_t stepId;
    char rsv[8];
    uint32_t dataLabel;     // use for data align
    uint32_t routeLabel;

    std::string DebugString() const
    {
        std::stringstream ss;
        ss << "Mbuf head msg. "
           << "transId=" << transId << ", "
           << "version=" << version << ", "
           << "msgType=" << msgType << ", "
           << "retCode=" << retCode << ", "
           << "startTime=" << startTime << ", "
           << "endTime=" << endTime << ", "
           << "flags=" << flags << ", "
           << "dataFlag=" << dataFlag << ", "
           << "workerId=" << workerId << ", "
           << "stepId=" << stepId << ", "
           << "routeLabel=" << routeLabel << std::endl;

        return ss.str();
    }
};

enum class MsgType : uint16_t {
    MSG_TYPE_TENSOR_DATA = 0,   // tensor data msg type
    MSG_TYPE_RAW_MSG = 1,       // raw data msg type
    MSG_TYPE_TENSOR_LIST = 2,   // raw data msg type
    MSG_TYPE_USER_DEFINE_START = 1024
};

struct FusionInfo {
    uint64_t dataSize;
    uint64_t lastDataOffset;
    int32_t lastFusionOffset;
};
}  // namespace AicpuSchedule

#endif  // OPERATOR_KERNEL_CONTEXT_H