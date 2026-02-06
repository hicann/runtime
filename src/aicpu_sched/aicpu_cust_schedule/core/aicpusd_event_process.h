/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef CORE_AICPUSD_EVENT_PROCESS_PROC_H
#define CORE_AICPUSD_EVENT_PROCESS_PROC_H

#include <map>
#include "aicpu_event_struct.h"
#include "aicpusd_info.h"
#include "ascend_hal.h"
#include "aicpusd_common.h"
#include "profiling_adp.h"
#include "aicpu_context.h"
#include "type_def.h"
#include "aicpusd_sqe_adapter.h"

namespace AicpuSchedule {
    class AicpuEventProcess {
    public:
        static AicpuEventProcess &GetInstance();

        /**
         * @ingroup AicpuEventProcess
         * @brief it use to process the AICPU event.
         * @param [in] eventInfo : the event information from ts.
         * @return AICPU_SCHEDULE_OK: success, other: error code
         */
        int32_t ProcessAICPUEvent(const event_info &eventInfo);

        /**
         * @ingroup AicpuEventProcess
         * @brief it use to set profMsg data.
         * @param [in] profMsg : profMsg handle.
         * @param [in] aicpuProfCtx : aicpu profMsg context.
         * @param [in] threadIndex : the id of thread.
         * @param [in] streamId : stream id.
         * @param [in] taskId : task id.
         */
        void SetProfData(const std::shared_ptr<aicpu::ProfMessage> profMsg,
                         const aicpu::aicpuProfContext_t &aicpuProfCtx,
                         const uint32_t threadIndex,
                         const uint64_t streamId,
                         const uint64_t taskId) const;
        /**
         * @ingroup AicpuEventProcess
         * @brief it use to execute ts kernel task.
         * @param [in] tsKernelInfo : the event information from ts.
         * @param [in] threadIndex : the id of thread.
         * @return AICPU_SCHEDULE_OK: success, other: error code
         */
        int32_t ExecuteTsKernelTask(aicpu::HwtsTsKernel &tsKernelInfo, const uint32_t threadIndex,
                                    const uint64_t drvSubmitTick, const uint64_t drvSchedTick,
                                    const uint64_t streamId, const uint64_t taskId);

        /**
         * @ingroup AicpuEventProcess
         * @brief it use to process op mapping load event.
         * @param [in] ctrlMsg : the struct of control task.
         * @return AICPU_SCHEDULE_OK: success, other: error code
         */
        int32_t ProcessLoadOpMappingEvent(AicpuSqeAdapter &aicpuSqeAdapter) const;

        /**
         * @ingroup SendCtrlCpuMsg
         * @brief send ctrl msg.
         * @param [in] custAicpuPid: msg dest pid
         * @param [in] eventType: msg type
         * @param [in] msg: msg body
         * @param [in] msgLen: msg len
         * @return AICPU_SCHEDULE_OK: success, other: error code
         */
        int32_t SendCtrlCpuMsg(int32_t aicpuPid, const uint32_t eventType, char_t *msg,
                               const uint32_t msgLen) const;

        /**
         * @ingroup AicpuEventProcess
         * @brief it is used to process the msg version.
         * @param [in] info : the information of task.
         * @return AICPU_SCHEDULE_OK: success, other: error code
         */
        int32_t ProcessMsgVersionEvent(AicpuSqeAdapter &aicpuSqeAdapter) const;

    private:

        AicpuEventProcess();

        ~AicpuEventProcess();

        AicpuEventProcess(AicpuEventProcess &) = delete;

        AicpuEventProcess &operator=(AicpuEventProcess &) = delete;

        int32_t AICPUEventBindSdPid(const event_info_priv &privEventInfo) const;

        int32_t AICPUEventOpenCustomSo(const event_info_priv &privEventInfo) const;

        int32_t AICPUEventCustUpdateProfilingMode(const event_info_priv &privEventInfo) const;

    private:
        using EventProcess = int32_t (AicpuEventProcess::*)(const event_info_priv &privEventInfo) const;
        std::map<AICPUCustSubEvent, EventProcess> eventTaskProcess_;
    };
}
#endif
