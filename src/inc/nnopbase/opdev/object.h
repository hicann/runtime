/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef OP_API_OBJECT_HEAD_H
#define OP_API_OBJECT_HEAD_H

#include <new>
#include <cstddef>

using std::size_t;

namespace op {

class Object {
public:
    Object() = default;
    virtual ~Object() = default;

public:
    void *operator new(size_t size) throw();
    void *operator new[](size_t size) throw();

    void *operator new(size_t size, [[maybe_unused]] const std::nothrow_t &tag) throw();
    void *operator new[](size_t size, [[maybe_unused]] const std::nothrow_t &tag) throw();

    void operator delete(void *addr);
    void operator delete[](void *addr);
};

} // namespace op

#endif
