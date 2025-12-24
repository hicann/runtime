/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef __CCE_RUNTIME_RWLOCK_H__
#define __CCE_RUNTIME_RWLOCK_H__

#include "mmpa/mmpa_api.h"
#include "base.hpp"

namespace cce {
namespace runtime {
class ReadProtect {
public:
    explicit ReadProtect(mmRWLock_t *const rLock) : lock_(rLock)
    {
        if (unlikely(lock_ == nullptr)) {
            return;
        }
        (void)mmRWLockRDLock(lock_);
    }
    virtual ~ReadProtect() noexcept
    {
        if (unlikely(lock_ == nullptr)) {
            return;
        }
        (void)mmRDLockUnLock(lock_);
    }

private:
    mmRWLock_t *lock_;
};

class WriteProtect {
public:
    explicit WriteProtect(mmRWLock_t *const wLock) : lock_(wLock)
    {
        if (unlikely(lock_ == nullptr)) {
            return;
        }
        (void)mmRWLockWRLock(lock_);
    }
    virtual ~WriteProtect() noexcept
    {
        if (unlikely(lock_ == nullptr)) {
            return;
        }
        (void)mmWRLockUnLock(lock_);
    }

private:
  mmRWLock_t *lock_;
};

}
}
#endif  // __CCE_RUNTIME_RWLOCK_H__
