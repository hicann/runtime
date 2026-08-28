/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef CCE_RUNTIME_API_ESCHED_HPP
#define CCE_RUNTIME_API_ESCHED_HPP

#include "base.hpp"
#include "runtime/rt_mem_queue.h"

namespace cce {
namespace runtime {

class ApiEsched {
public:
    ApiEsched() = default;
    virtual ~ApiEsched() = default;

    ApiEsched(const ApiEsched&) = delete;
    ApiEsched& operator=(const ApiEsched&) = delete;
    ApiEsched(ApiEsched&&) = delete;
    ApiEsched& operator=(ApiEsched&&) = delete;

    static ApiEsched* Instance();

    virtual rtError_t EschedSubmitEventSync(
        const int32_t devId, rtEschedEventSummary_t* const evt, rtEschedEventReply_t* const ack) = 0;
    virtual rtError_t EschedAttachDevice(const uint32_t devId) = 0;
    virtual rtError_t EschedDettachDevice(const uint32_t devId) = 0;
    virtual rtError_t EschedWaitEvent(
        const int32_t devId, const uint32_t grpId, const uint32_t threadId, const int32_t timeout,
        rtEschedEventSummary_t* const evt) = 0;
    virtual rtError_t EschedCreateGrp(const int32_t devId, const uint32_t grpId, const rtGroupType_t type) = 0;
    virtual rtError_t EschedSubmitEvent(const int32_t devId, rtEschedEventSummary_t* const evt) = 0;
    virtual rtError_t EschedSubscribeEvent(
        const int32_t devId, const uint32_t grpId, const uint32_t threadId, const uint64_t eventBitmap) = 0;
    virtual rtError_t EschedAckEvent(
        const int32_t devId, const rtEventIdType_t evtId, const uint32_t subeventId, char_t* const msg,
        const uint32_t len) = 0;
    virtual rtError_t EschedQueryInfo(
        const uint32_t devId, const rtEschedQueryType type, rtEschedInputInfo* const inPut,
        rtEschedOutputInfo* const outPut) = 0;
};

} // namespace runtime
} // namespace cce

#endif // CCE_RUNTIME_API_ESCHED_HPP
