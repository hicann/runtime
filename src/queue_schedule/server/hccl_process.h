/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef DGW_HCCL_PROCESS_H
#define DGW_HCCL_PROCESS_H

#include <mutex>
#include <atomic>
#include <cstdint>
#include "fsm/state_define.h"
#include "driver/ascend_hal.h"
#include "hccl/hccl_types_in.h"
#include "hccl/hcom.h"
#include "hccl/hccl_ex.h"
#include "bqs_util.h"
#include "entity_manager.h"

namespace dgw {
class HcclProcess {
public:
    /**
     * get the instance object
     * @return HcclProcess&
     */
    static HcclProcess &GetInstance();

    ~HcclProcess() = default;

    /**
     * process recv request event
     * @param event event info
     * @return FsmStatus FSM_SUCCESS:success other:failed
     */
    FsmStatus ProcessRecvRequestEvent(const event_info &event, const uint32_t deviceId, const uint32_t resIndex);

    /**
     * process send completion event
     * @param event event info
     * @return FsmStatus FSM_SUCCESS:success other:failed
     */
    FsmStatus ProcessSendCompletionEvent(const event_info &event, const uint32_t deviceId, const uint32_t resIndex);

    /**
     * process recv completion event
     * @param event event info
     * @return FsmStatus FSM_SUCCESS:success other:failed
     */
    FsmStatus ProcessRecvCompletionEvent(const event_info &event, const uint32_t deviceId, const uint32_t resIndex);

    /**
     * process hccl f2nf event
     * @param event event info
     * @return FsmStatus FSM_SUCCESS:success other:failed
     */
    FsmStatus ProcessCongestionReliefEvent(const event_info &event, const uint32_t deviceId,
        const uint32_t resIndex) const;

    /**
     * supply all hccl event
     * @return FsmStatus FSM_SUCCESS:success other:failed
     */
    FsmStatus SupplyEvents(const uint32_t resIndex = 0U) const;

private:
    explicit HcclProcess() = default;
    HcclProcess(const HcclProcess &) = delete;
    HcclProcess(const HcclProcess &&) = delete;
    HcclProcess &operator = (const HcclProcess &) = delete;
    HcclProcess &operator = (HcclProcess &&) = delete;
    void Init();

    /**
     * @brief test some comm channels
     * @param channels comm channels
     * @param isSrc is source channel
     * @param totalCompCount total completed count
     * @return FSM_SUCCESS: success, other: failed
     */
    FsmStatus TestSomeCommChannels(CommChannels &channels, const bool isSrc, uint32_t &totalCompCount,
        const uint32_t resIndex) const;

    /**
     * @brief process test some results
     * @param compCount completed count
     * @param channels comm channels
     * @return FSM_SUCCESS: success, other: failed
     */
    FsmStatus ProcTestSomeResults(const int32_t compCount, CommChannels &channels, int32_t hcclRet) const;

    /**
     * @brief probe comm channel
     * @param entity comm channel entity
     * @param probeCount probe count
     * @return FSM_SUCCESS: success, other: failed
     */
    FsmStatus ProbeCommChannel(const ChannelEntityPtr &entity, uint32_t &probeCount) const;

    /**
     * @brief reply hccl event
     * @param event hccl event
     * @return FSM_SUCCESS: success, other: failed
     */
    FsmStatus ReplyHcclEvent(const event_info &event, const uint32_t deviceId) const;

    FsmStatus PreProcessSetUplinkReq(const RequestInfo * const hcclReq) const;

    // mutual exclusion lock for recv request event
    std::atomic_flag recvRequestEventAtomicFlag_ = ATOMIC_FLAG_INIT;
    std::atomic_flag recvRequestEventAtomicFlagExtra_ = ATOMIC_FLAG_INIT;
    // mutual exclusion lock for send completion event
    std::atomic_flag sendCompEventAtomicFlag_ = ATOMIC_FLAG_INIT;
    std::atomic_flag sendCompEventAtomicFlagExtra_ = ATOMIC_FLAG_INIT;
    //  mutual exclusion lock for recv completion event
    std::atomic_flag recvCompEventAtomicFlag_ = ATOMIC_FLAG_INIT;
    std::atomic_flag recvCompEventAtomicFlagExtra_ = ATOMIC_FLAG_INIT;
    bool inited_{false};
    bool oneTrackEventEnabled_{false};
};
}
#endif