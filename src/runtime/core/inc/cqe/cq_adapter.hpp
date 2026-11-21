/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef __CCE_RUNTIME_CQ_ADAPTER_HPP__
#define __CCE_RUNTIME_CQ_ADAPTER_HPP__

#include <cstdint>
#include "base.hpp"
#include "driver_types.hpp"

namespace cce {
namespace runtime {

class Device;

constexpr uint32_t UBDMA_CQE_JETTY_INFO_NUM = 2U;

struct TaskJettyStatus {
    uint16_t jettyId;
    uint8_t status;
    uint8_t subStatus;
};

/**
 * @ingroup engine or starsEngine
 * @brief the type definition of logic cq for all chipType(total 32 bytes).
 */
struct rtLogicCqReport_t {
    volatile uint16_t streamId;
    volatile uint16_t taskId;
    volatile uint32_t errorCode; // cqe acc_status/sq_sw_status
    volatile uint8_t errorType;  // bit0 ~ bit5 cqe stars_defined_err_code, bit 6 cqe warning bit
    volatile uint8_t sqeType;
    volatile uint16_t sqId;
    volatile uint16_t sqHead;
    volatile uint16_t matchFlag : 1;
    volatile uint16_t dropFlag : 1;
    volatile uint16_t errorBit : 1;
    volatile uint16_t accError : 1;
    volatile uint16_t nextTaskVld : 1;
    volatile uint16_t notifyAttached : 1;
    volatile uint16_t reserved0 : 10;
    union {
        volatile uint64_t timeStamp;
        volatile uint16_t sqeIndex;
        TaskJettyStatus info[UBDMA_CQE_JETTY_INFO_NUM];
    } u1;
    /* Union description:
     *  Internal: enque_timestamp temporarily used as dfx
     *  External: reserved1
     */
    union {
        volatile uint64_t enqueTimeStamp;
        volatile uint64_t reserved1;
    } u2;
};

/**
 * @ingroup engine or starsEngine
 * @brief the type definition of cq report for runtime(total 32 bytes).
 */
struct rtCqReport_t {
    volatile uint16_t streamId;
    volatile uint16_t taskId;
    volatile uint32_t errorCode; // cqe acc_status/sq_sw_status
    volatile uint8_t errorType;  // bit0 ~ bit5 cqe stars_defined_err_code, bit 6 cqe warning bit
    volatile uint8_t sqeType;
    volatile uint16_t sqId;
    volatile uint16_t sqHead;
    volatile uint16_t nextTaskVld : 1;
    volatile uint16_t notifyAttached : 1;
    volatile uint16_t reserved0 : 14;
    volatile uint32_t reserved1;
    volatile uint64_t reserved2;
    union {
        volatile uint64_t timeStamp;
        volatile uint64_t value;
        TaskJettyStatus info[UBDMA_CQE_JETTY_INFO_NUM];
    } u;
};

void ConvertLogicCqeToRtCqe(const rtLogicCqReport_t* const logicCqe, rtCqReport_t* const rtCqe);

// 支持收logic cq和stars平台的物理cq
rtError_t RtCqRecv(
    const CqWaitInfo& waitInfo, rtCqReport_t* const rtCqe, const uint32_t allocCnt, uint32_t& realCnt,
    const Device* const dev);

} // namespace runtime
} // namespace cce
#endif // __CCE_RUNTIME_CQ_ADAPTER_HPP__
