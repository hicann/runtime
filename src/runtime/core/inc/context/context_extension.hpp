/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef CCE_RUNTIME_CONTEXT_EXTENSION_HPP
#define CCE_RUNTIME_CONTEXT_EXTENSION_HPP

namespace cce {
namespace runtime {

class ContextExtension {
public:
    ContextExtension() = default;
    virtual ~ContextExtension() = 0;

    ContextExtension(const ContextExtension&) = delete;
    ContextExtension& operator=(const ContextExtension&) = delete;
    ContextExtension(ContextExtension&&) = delete;
    ContextExtension& operator=(ContextExtension&&) = delete;
};

} // namespace runtime
} // namespace cce

inline cce::runtime::ContextExtension::~ContextExtension() = default;

#endif // CCE_RUNTIME_CONTEXT_EXTENSION_HPP
