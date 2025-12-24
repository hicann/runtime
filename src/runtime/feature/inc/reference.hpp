/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef __CCE_RUNTIME_REFERENCE_HPP__
#define __CCE_RUNTIME_REFERENCE_HPP__

#include "osal.hpp"
#include "base.hpp"

namespace cce {
namespace runtime {

template <class T, T initVal = static_cast<T>(0)>
class RefObject {
public:
    RefObject() : status_(STATUS_IDLE), count_(0ULL), value_(initVal)
    {
    }

    ~RefObject() = default;

    bool IncRef()
    {
        uint64_t oldVal;
        uint64_t newVal;
        bool success = false;
        uint64_t tryCount = 0ULL;
        constexpr uint64_t PER_SCHED_YIELD = 1000ULL;
        do {
            tryCount++;
            if ((tryCount % PER_SCHED_YIELD) == 0ULL) {
                (void)sched_yield();
            }
            oldVal = count_.Value();
            if ((oldVal & REF_UPDATING) != 0ULL) {
                continue;
            }
            newVal = (oldVal > 0ULL) ? (oldVal + 1ULL) : (static_cast<uint64_t>(REF_UPDATING) + 1ULL);
            success = count_.CompareExchange(oldVal, newVal);
        } while (!success);
        if (newVal == (REF_UPDATING - 1ULL)) {
            RT_LOG(RT_LOG_EVENT, "Maximum ref count reached, count=%#llx", newVal);
        }
        return oldVal != 0ULL;
    }

    bool DecRef()
    {
        uint64_t oldVal;
        uint64_t newVal;
        bool success = false;

        do {
            oldVal = count_.Value();
            if ((oldVal & REF_UPDATING) != 0ULL) {
                continue;
            }
            newVal = (oldVal == 1ULL) ? static_cast<uint64_t>(REF_UPDATING) : (oldVal - 1ULL);
            success = count_.CompareExchange(oldVal, newVal);
        } while (!success);
        return newVal != REF_UPDATING;
    }

    // The return value indicates whether the reference count is decremented, diffrent from other api.
    bool TryDecRef(bool &needReset)
    {
        uint64_t oldVal;
        uint64_t newVal;
        bool success = false;

        do {
            oldVal = count_.Value();
            if (oldVal == 0ULL) {
                return false;
            }

            if ((oldVal & REF_UPDATING) != 0ULL) {
                continue;
            }

            newVal = (oldVal == 1ULL) ? static_cast<uint64_t>(REF_UPDATING) : (oldVal - 1ULL);
            success = count_.CompareExchange(oldVal, newVal);
        } while (!success);

        needReset = (newVal == REF_UPDATING);
        return true;
    }

    bool TryIncRef()
    {
        uint64_t oldVal;
        uint64_t newVal;
        bool success = false;

        do {
            oldVal = count_.Value();
            if (oldVal == 0ULL) {
                return false;
            }

            if ((oldVal & REF_UPDATING) != 0ULL) {
                continue;
            }

            newVal = oldVal + 1ULL;
            success = count_.CompareExchange(oldVal, newVal);
        } while (!success);

        return true;
    }

    bool TryIncAndSet(T val)
    {
        bool success = count_.CompareExchange(0ULL, REF_UPDATING + 1ULL);
        if (success) {
            SetVal(val);
        }
        return success;
    }

    uint64_t GetRef() const
    {
        return count_.Value();
    }

    // callef after IncRef return 0.
    void SetVal(T val)
    {
        value_ = val;
        if (count_.Value() >= REF_UPDATING) {
            count_.Sub(REF_UPDATING);
        }
    }

    // callef after DecRef return 0.
    void ResetVal()
    {
        SetVal(initVal);
    }

    void ResetValForAbort()
    {
        value_ = initVal;
        count_.Set(0ULL);
    }

    // safe call after IncRef
    const T GetVal(bool polling = true) const
    {
        while (polling && ((count_.Value() & REF_UPDATING) != 0ULL)) {
            // Do nothing
        }

        return value_;
    }

    bool IsValIdle()
    {
        return status_.CompareExchange(STATUS_IDLE, STATUS_BUSY);
    }

    void ChangeValStatus(uint32_t status)
    {
        status_.Set(status);
    }

    bool GetPrimaryCtxCallBackFlag() const
    {
        return primaryCtxCallBackFlag_;
    }

    void SetPrimaryCtxCallBackFlag(const bool flag)
    {
        primaryCtxCallBackFlag_ = flag;
    }
    static constexpr uint32_t STATUS_IDLE = 0U;
    static constexpr uint32_t STATUS_BUSY = 1U;

private:
    Atomic<uint32_t> status_;
    Atomic<uint64_t> count_;
    volatile T value_;
    static constexpr uint64_t REF_UPDATING = 0x8000000000000000ULL; // INT64_MAX + 1
    bool primaryCtxCallBackFlag_ = false;
};
}
}

#endif  // __CCE_RUNTIME_REFERENCE_HPP__
