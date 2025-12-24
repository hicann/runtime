/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef OP_API_OP_API_COMMON_INC_COMMON_UTILS_H
#define OP_API_OP_API_COMMON_INC_COMMON_UTILS_H

#include <atomic>
#include "opdev/op_log.h"

namespace op {
namespace internal {

constexpr uint32_t FLAG_NOT_EXECUTE = 0;
constexpr uint32_t FLAG_EXECUTING = 1;
constexpr uint32_t FLAG_EXECUTED = 2;

class ResettableOnceFlag {
public:
    ResettableOnceFlag() : onceFlag_(FLAG_NOT_EXECUTE)
    {}

    template <typename F, typename... Args>
    void CallOnce(F &&func, Args &&...args)
    {
        uint32_t expect = FLAG_NOT_EXECUTE;
        if (onceFlag_.compare_exchange_strong(expect, FLAG_EXECUTING)) {
            try {
                // execute func
                std::invoke(std::forward<F>(func), std::forward<Args>(args)...);
                onceFlag_.store(FLAG_EXECUTED);
            } catch (std::exception &e) {
                OP_LOGW("invoke call function failed, reason: %s", e.what());
                onceFlag_.store(FLAG_NOT_EXECUTE);
                throw;
            }
        } else {
            while (onceFlag_.load() == FLAG_EXECUTING) {
                std::this_thread::yield();
            }
        }
    }

    void reset()
    {
        while (onceFlag_.load() == FLAG_EXECUTING) {
            std::this_thread::yield();
        }
        uint32_t expected = FLAG_EXECUTED;
        if (!onceFlag_.compare_exchange_strong(expected, FLAG_NOT_EXECUTE)) {
            onceFlag_.store(FLAG_NOT_EXECUTE);
        }
    }

private:
    std::atomic<uint32_t> onceFlag_;
};

}  // namespace internal
}  // namespace op

#endif // OP_API_OP_API_COMMON_INC_COMMON_UTILS_H