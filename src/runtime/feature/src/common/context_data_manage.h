/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef CCE_RUNTIME_CONTEXT_DATA_MANAGE_HPP
#define CCE_RUNTIME_CONTEXT_DATA_MANAGE_HPP
#include <cstdint>
#include <string>
#include <iostream>
#include <vector>
#include <unordered_set>
#include <unordered_map>
#include "rw_lock.h"
namespace cce {
namespace runtime {
class Context;

class ContextDataManage {
public:
    ContextDataManage() = default;
    ~ContextDataManage() = default;

    static ContextDataManage &Instance();

    mmRWLock_t &GetSetRwLock()
    {
        return setLock_;
    };

    std::unordered_set<Context *> &GetSetObj()
    {
        return set_;
    };

    void InsertSetValueWithoutLock(Context *key)
    {
        (void)set_.insert(key);
    };

    void InsertSetValueWithLock(Context *key)
    {
        const WriteProtect wp(&setLock_);
        (void)set_.insert(key);
    };

    bool EraseSetValueWithoutLock(Context *key)
    {
        const auto it = set_.find(key);
        if (unlikely(it == set_.end())) {
            return false;
        }
        (void)set_.erase(it);
        return true;
    };

    bool EraseSetValueWithLock(Context *key)
    {
        const WriteProtect wp(&setLock_);
        const auto it = set_.find(key);
        if (unlikely(it == set_.end())) {
            return false;
        }
        (void)set_.erase(it);
        return true;
    };

    bool ExistsSetValueWithoutLock(Context *key)
    {
        return !(set_.find(key) == set_.end());
    };

private:
    mmRWLock_t setLock_;
    std::unordered_set<Context *> set_;
};

}  // namespace runtime
}  // namespace cce
#endif  // CCE_RUNTIME_CONTEXT_DATA_MANAGE_HPP
