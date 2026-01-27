/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef __CCE_TPRT_SQHANDLE_HPP__
#define __CCE_TPRT_SQHANDLE_HPP__
#include "tprt_type.h"
#include "tprt_base.hpp"
#include "tprt_sqe_cqe.h"

namespace cce {
namespace tprt {

class TprtSqHandle {
public:
    explicit TprtSqHandle(const uint32_t devId, const uint32_t sqId);
    ~TprtSqHandle();
    void TprtSetSqState(const TprtSqState_t status);
    uint32_t SqPushTask(const uint8_t *sqeAddr, const uint32_t sqeNum);
    uint32_t SqPeekTask(TprtSqe_t *sqe);
    uint16_t SqGetSqHead() const
    {
        return sqHead_.load();
    }
    void SqSetSqTailToHead()
    {
        sqHead_.store(sqTail_.load());
    }
    void SqSetSqState(TprtSqState_t state)
    {
        sqState_.store(state);
    }
    TprtSqState_t SqGetSqState() const
    {
        return sqState_.load();
    }
    uint32_t SqExeTask(const TprtSqe_t *sqe);
    uint32_t SqGetCqeState() const
    {
        if (isExistCqe_) {
            return 1U;
        }
        return 0U;
    }
    void SqSetCqeState(bool flag)
    {
        isExistCqe_ = flag;
    }
    uint32_t SqGetSqId() const
    {
        return sqId_;
    }
    void SqUpdateHead(const uint8_t sqeNum);
    template<typename T>
    void PrintTprtSqe(T const sqe, const size_t size = 64) const
    {
        if (CheckLogLevel(static_cast<int32_t>(RUNTIME), DLOG_DEBUG) == 0) {
            return;
        }
        const uint32_t * const cmd = TprtPtrToPtr<const uint32_t *>(sqe);
        for (size_t i = 0UL; i < (size / sizeof(uint32_t)); i += 8U) {
            TPRT_LOG(TPRT_LOG_DEBUG, "%08x %08x %08x %08x %08x %08x %08x %08x",
                cmd[i], cmd[i + 1U], cmd[i + 2U], cmd[i + 3U], cmd[i + 4U], cmd[i + 5U], cmd[i + 6U],
                cmd[i + 7U]);
        }
    }
private:
    uint32_t devId_{0xFFFFFFFFU};
    uint32_t sqId_{0xFFFFFFFFU};
    std::atomic<TprtSqState_t> sqState_;
    std::atomic<bool> isExistCqe_{false};
    std::atomic<uint16_t> sqHead_{0U};
    std::atomic<uint16_t> sqTail_{0U};
    std::mutex sqQueueLock_;
    std::array<TprtSqe_t, 1024> sqQueue_;
};
}
}

#endif
