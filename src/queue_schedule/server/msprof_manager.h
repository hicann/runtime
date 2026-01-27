/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef QUEUE_SCHEDULE_MSPROF_MANAGER_H
#define QUEUE_SCHEDULE_MSPROF_MANAGER_H

#include <atomic>
#include <cstdint>
#include <string>
#include "common/bqs_log.h"
#include "msprof_api_adapter.h"

namespace bqs {
enum class DgwProfInfoType : int32_t {
    HCCL_TRANS_DATA = 0x020000, // MSPROF_REPORT_MODEL_AICPU_BASE_TYPE
    ALLOC_MBUF,
    ENQUEUE_DATA,
    PROF_INFO_TYPE_BUTT
};

inline uint64_t GetTimeStamp()
{
    return BqsMsprofApiAdapter::GetInstance().MsprofSysCycleTime();
}

struct ProfInfo {
    uint32_t type;
    uint64_t itemId;
    uint64_t timeStamp;
};

class BqsMsprofManager {
public:
    static BqsMsprofManager &GetInstance();

    void InitBqsMsprofManager(const bool initFlag, const std::string &cfgData);
    void ReportApiPerf(const ProfInfo &profData) const;
    void ReportEventPerf(const ProfInfo &profData);

    inline bool IsStartProfling() const
    {
        return isRun_;
    }

private:
    BqsMsprofManager() : isInitMsprof_(false), isRun_(false), agingFlag_(true), requestId_(0U) {};
    ~BqsMsprofManager()
    {
        if (!isInitMsprof_) {
            return;
        }

        BQS_LOG_RUN_INFO("[Prof]Start finalize msprof.");
        try {
            (void)BqsMsprofApiAdapter::GetInstance().MsprofFinalize();
        } catch (std::exception &e) {
            // pass
        }

        isInitMsprof_ = false;
    };

    BqsMsprofManager(const BqsMsprofManager &) = delete;
    BqsMsprofManager &operator=(const BqsMsprofManager &) = delete;
    BqsMsprofManager(BqsMsprofManager &&) = delete;
    BqsMsprofManager &operator=(BqsMsprofManager &&) = delete;

    ProfStatus InitProf(const std::string &cfgData);
    ProfStatus RegProfCallback() const;
    ProfStatus RegProfType() const;
    static int32_t ProfCallback(uint32_t type, void *data, uint32_t dataLen);
    ProfStatus HandleCtrlSwitch(const MsprofCommandHandle &profCmdHandle);
    ProfStatus HandelCtrlReporter(const MsprofCommandHandle &profCmdHandle) const;
    ProfStatus HandleCtrlStepInfo(const MsprofCommandHandle &profCmdHandle) const;

    bool isInitMsprof_;
    bool isRun_;
    bool agingFlag_; // qs data is always need againg
    std::atomic<uint32_t> requestId_;
};
} // namespace bqs

#endif // QUEUE_SCHEDULE_MSPROF_MANAGER_H
