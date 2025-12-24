/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef __POOL_ALLOCATOR_H__
#define __POOL_ALLOCATOR_H__

#include <cstdlib>
#include <limits>
#include <new>
#include <numeric>
#include "opdev/op_log.h"

namespace op {
namespace internal {

void *MallocPtr(size_t size);
void FreePtr(void *block);

template<class T>
struct PoolAllocator {
    using value_type = T;
    using size_t = std::size_t;

    PoolAllocator() = default;

    template<class U>
    constexpr PoolAllocator(const PoolAllocator<U> &) noexcept
    {
    }

    T *allocate(size_t n)
    {
        if (n > std::numeric_limits<size_t>::max() / sizeof(T)) {
            return nullptr;
        }

        T *p = static_cast<T *>(MallocPtr(n * sizeof(T)));
        if (p != nullptr) {
            return p;
        }

        return nullptr;
    }

    void deallocate(T *p, [[maybe_unused]] size_t n) noexcept
    {
        FreePtr(p);
    }

    template<typename _Up, typename... _Args>
    void construct(_Up *__p, _Args &&...__args)
    {
        ::new ((void *) __p) _Up(std::forward<_Args>(__args)...);
    }

    template<typename _Up>
    void destroy(_Up *__p)
    {
        __p->~_Up();
    }
};

template<class T, class U>
bool operator==(const PoolAllocator<T> &, const PoolAllocator<U> &)
{
    return true;
}

template<class T, class U>
bool operator!=(const PoolAllocator<T> &, const PoolAllocator<U> &)
{
    return false;
}

} // namespace internal
} // namespace op

#endif
