/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef CORE_AICPUSD_MSG_SEND_H
#define CORE_AICPUSD_MSG_SEND_H

#include <atomic>
#include <mutex>
#include "aicpusd_status.h"
#include "aicpusd_common.h"
#include "aicpu_async_event.h"
#include "aicpusd_sqe_adapter.h"

namespace AicpuSchedule {
class AicpuMsgSend {
public:
    /**
     * @ingroup AicpuMsgSend
     * @brief it use to set SchedSubmitEvent.
     * @param [in] devId : device id
     * @param [in] event : submit event
     */
    static void SetSchedSubmitEvent(const uint32_t devId, const event_summary &event);

    /**
     * @ingroup AicpuMsgSend
     * @brief it use to set TsDevSendMsgAsync.
     * @param [in] devId : device id
     * @param [in] tsId : ts id
     * @param [in] aicpuSqe : send event
     * @param [in] handleId : handle id
     */
    static void SetTsDevSendMsgAsync(const uint32_t devId, const uint32_t tsId, const TsAicpuSqe &aicpuSqe,
        const uint32_t handleId);

    /**
     * @ingroup AicpuMsgSend
     * @brief it use to set TsDevSendMsgAsync.
     * @param [in] devId : device id
     * @param [in] tsId : ts id
     * @param [in] aicpuSqe : send event
     * @param [in] handleId : handle id
     */
    static void SetTsDevSendMsgAsync(const uint32_t devId, const uint32_t tsId, const TsAicpuMsgInfo &msgInfo,
        const uint32_t handleId);

    /**
     * @ingroup AicpuMsgSend
     * @brief it use to send event.
     */
    static void SendEvent();

    /**
    * @ingroup AicpuEventProcess
    * @brief send aicpu sub event.
    * @param [in] msg: message.
    * @param [in] msgLen: message length.
    * @param [in] subEventId: sub event id
    * @param [in] syncSendFlag: sync sumbit event flag
    * @return AICPU_SCHEDULE_OK: success, other: error code
    */
    static int32_t SendAICPUSubEvent(const char_t * const msg,
                                     const uint32_t msgLen,
                                     const uint32_t subEventId,
                                     const uint32_t grpId,
                                     const bool syncSendFlag = false);

    /**
     * @ingroup AicpuMsgSend
     * @brief send aicpu record msg to ts for notify eventwait or notify wait
     * @param notifyParam
     * @param paramLen
     */
    static void SendAicpuRecordMsg(const void *const notifyParam, const uint32_t paramLen);

    /**
     * @ingroup AicpuMsgSend
     * @brief send info to ts
     * @param notifyParam
     * @param paramLen
     */
    static void AicpuReportNotifyInfo(const aicpu::AsyncNotifyInfo &notifyInfo);

private:
    AicpuMsgSend() = default;
    ~AicpuMsgSend() = default;
    AicpuMsgSend(const AicpuMsgSend &) = delete;
    AicpuMsgSend &operator = (const AicpuMsgSend &) = delete;

    /**
     * @ingroup AicpuMsgSend
     * @brief it use to check and send event.
     */
    static void CheckAndSendEvent();
};
}

#endif // CORE_AICPUSD_MSG_SEND_H
