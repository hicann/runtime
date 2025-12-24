/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef MSTX_MANAGER_H
#define MSTX_MANAGER_H

#include <atomic>
#include <mutex>
#include <unordered_map>
#include "msprof_error_manager.h"
#include "singleton/singleton.h"
#include "thread/thread.h"
#include "queue/ring_buffer.h"
#include "msprof_tx_manager.h"

namespace Collector {
namespace Dvvp {
namespace Mstx {
using namespace Msprof::MsprofTx;

constexpr size_t RING_BUFFER_DEFAULT_CAPACITY = 512;

enum class MstxDataType {
    DATA_MARK = 0,
    DATA_RANGE_START,
    DATA_RANGE_END,
    DATA_INVALID
};

class MstxDataHandler : public analysis::dvvp::common::singleton::Singleton<MstxDataHandler>,
                    public analysis::dvvp::common::thread::Thread {
public:
    MstxDataHandler();
    ~MstxDataHandler();

    int Start(const std::string &mstxDomainInclude, const std::string &mstxDomainExclude);
    int Stop();
    void Run(const struct error_message::Context &errorContext) override;
    bool IsStart();
    int SaveMstxData(const char* msg, uint64_t mstxEventId, MstxDataType type, uint64_t domainNameHash = 0);

private:
    void Init();
    void Uninit();
    int SaveMarkData(const char* msg, uint64_t mstxEventId, uint64_t domainNameHash);
    int SaveRangeData(const char* msg, uint64_t mstxEventId, MstxDataType type, uint64_t domainNameHash);

    void Flush();
    void ReportData();

private:
    uint32_t processId_{0};
    std::atomic<bool> init_{false};
    std::atomic<bool> start_{false};
    analysis::dvvp::common::queue::RingBuffer<MsprofTxInfo> mstxDataBuf_{MsprofTxInfo{}};
    std::mutex tmpRangeDataMutex_;
    std::unordered_map<uint64_t, MsprofTxInfo> tmpMstxRangeData_;
};
}
}
}
#endif
