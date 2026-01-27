/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef QS_INTERFACE_PROCESS_H
#define QS_INTERFACE_PROCESS_H

#include <atomic>
#include <functional>
#include <mutex>
#include <thread>
#include <vector>
#include <memory>
#include <string>
#include "driver/ascend_hal.h"
#include "queue_schedule.h"
#include "common/bqs_log.h"
#include "bind_cpu_utils.h"
#include "common/bqs_feature_ctrl.h"

namespace bqs {
    class QueueScheduleInterface {
    public:
        __attribute__((visibility("default"))) static QueueScheduleInterface &GetInstance();

        /**
        * @ingroup QueueScheduleInterface
        * @brief it use to destroy all model.
        * @return AICPU_SCHEDULE_OK:success, other failed.
        */
        __attribute__((visibility("default"))) int32_t Destroy() const;

        /**
        * @ingroup QueueScheduleInterface
        * @brief it use to initialize aicpu schedule.
        * @param [in] params InitQsParams
        * @return AICPU_SCHEDULE_OK: success, other: error code
        */
        __attribute__((visibility("default"))) int32_t InitQueueScheduler(const InitQsParams &params);

        /**
        * @ingroup QueueScheduleInterface
        * @brief it use to get cpu info.
        * @return AICPU_SCHEDULE_OK: success, other: error code
        */
        const CpuInfo &GetCpuInfo() const
        {
            return cpuInfo_;
        }

        /**
        * @ingroup QueueScheduleInterface
        * @brief it use to get control cpu ids.
        * @return AICPU_SCHEDULE_OK: success, other: error code
        */
        const std::vector<uint32_t> &GetCtrlCpuIds() const
        {
            return ctrlCpuIds_;
        }

        const std::vector<uint32_t> &GetAiCpuIds() const
        {
            return aiCpuIds_;
        }

        uint32_t GetAicpuPhysIndex(uint32_t deviceId, const uint32_t aicpuLogIndex) const;

        uint32_t GetExtraAicpuPhysIndex(uint32_t deviceId, const uint32_t aicpuLogIndex) const;

        uint32_t GetAicpuPhysIndexInVfMode(const uint32_t aicpuLogIndex, const uint32_t deviceId) const
        {
            if (aicpuLogIndex >= aiCpuIds_.size()) {
                BQS_LOG_ERROR("Get aicpu index error");
                return 0U;
            }
            if (FeatureCtrl::IsVfModeDie1(deviceId)) {
                return coreNumPerDev_ + aiCpuIds_[aicpuLogIndex];
            }
            return aiCpuIds_[aicpuLogIndex];
        }

        uint32_t GetExtraAicpuPhysIndexInVfMode(const uint32_t aicpuLogIndex, const uint32_t deviceId) const
        {
            if (aicpuLogIndex >= aiCpuIdsExtra_.size()) {
                BQS_LOG_ERROR("Get aicpu index error");
                return 0U;
            }
            if (FeatureCtrl::IsVfModeDie1(deviceId)) {
                return coreNumPerDevExtra_ + aiCpuIdsExtra_[aicpuLogIndex];
            }
            return aiCpuIdsExtra_[aicpuLogIndex];
        }
        uint32_t GetAiCpuNum() const
        {
            return aicpuNum_;
        }

        uint32_t GetExtraAiCpuNum() const
        {
            return aicpuNumExtra_;
        }
        int32_t CheckBindHostPid(const uint32_t selfHostPid) const;
        /**
        * wait for stop.
        */
        __attribute__((visibility("default"))) void WaitForStop();

        void ReportAbnormal() const;

    private:
        QueueScheduleInterface() = default;

        ~QueueScheduleInterface() = default;

        QueueScheduleInterface(const QueueScheduleInterface &) = delete;

        QueueScheduleInterface &operator=(const QueueScheduleInterface &) = delete;

        // it is used in updating model status.
        std::mutex mutexForInit_;
        std::unique_ptr<bqs::QueueSchedule> queueSchedule_;
        CpuInfo cpuInfo_;
        std::vector<uint32_t> ctrlCpuIds_;
        std::vector<uint32_t> aiCpuIds_;
        uint32_t coreNumPerDev_;
        uint32_t aicpuNum_;
        uint32_t aicpuBaseId_;

        std::vector<uint32_t> ctrlCpuIdsExtra_;
        std::vector<uint32_t> aiCpuIdsExtra_;
        uint32_t coreNumPerDevExtra_;
        uint32_t aicpuNumExtra_;
        uint32_t aicpuBaseIdExtra_;
    };
}
#endif  // QS_INTERFACE_PROCESS_H