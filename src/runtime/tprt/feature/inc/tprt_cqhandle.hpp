/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef __CCE_TPRT_CQHANDLE_HPP__
#define __CCE_TPRT_CQHANDLE_HPP__

#include "tprt_sqe_cqe.h"
#include "tprt_sqhandle.hpp"

namespace cce {
namespace tprt {

class TprtCqHandle {
public:
    explicit TprtCqHandle(const uint32_t devId, const uint32_t cqId);
    ~TprtCqHandle();
    uint32_t TprtCqWriteCqe(const uint8_t errorType, const uint32_t errorCode, const TprtSqe_t *sqe,
                            const TprtSqHandle *sqHandle);
    void TprtCqHandleGetCqe(TprtReportCqeInfo_t *cqeInfo);
    bool TprtCqIsFull(uint32_t queueDepth);
private:
    uint32_t devId_{0xFFFFFFFFU};
    uint32_t cqId_{0xFFFFFFFFU};
    std::atomic<uint16_t> cqHead_{0U};
    std::atomic<uint16_t> cqTail_{0U};
    std::array<TprtCqeReport_t, 1024> cqQueue_;
    std::mutex cqQueueLock_;
};
}
}

#endif
